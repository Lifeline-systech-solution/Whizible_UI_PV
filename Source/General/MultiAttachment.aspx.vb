Imports System.Xml
Imports System.IO
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class MultiAttachment
    Inherits WebPages.Template.WhizTemplate

    Protected m_strFromWhere As String = ""
    Protected m_strAction As String = ""

    Protected m_strMode As String = ""
    Protected m_strID As String = ""
    Protected m_strShow As String = ""
    Protected m_strAttachmentType As String = ""
    Protected m_strQueryID As String = ""

    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
    Protected m_lngMaxLength As Long = 100
    Private m_lngProjectIDWSR As Long

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean


    'Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_strIssueID As String
    Protected m_PKToken As String
    Protected m_Mode As String
    'End of Added by SavitaS on 20 Sept 2006 for Security Issue 6197

    'Added by VijayD on 17 Aug 2009 For Maintaing Search Filter on the Issue_Entry Page
    Protected m_strIssueListSearchType As String
    Protected m_strIssueListSearchValue As String
    'Addition end by VijayD
    Protected m_strExtensionList As String = ""
    Protected m_intTagID As Integer

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

        ''Commented by Yogesh J on 19-Jan-2016
        ''commented by nilesh g on 31/12/2015 for Security
        'If Request.Browser.Browser <> "IE" And Request.Browser.Browser <> "InternetExplorer" Then
        '    If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '        Response.Write(vbCrLf + "<script>")
        '        Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '        If strRedirectToPage.Trim = "" Then
        '            Response.Write(vbCrLf + "window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '        Else
        '            Response.Write(vbCrLf + "window.open('" + strRedirectToPage + "','_top');")
        '        End If
        '        Response.Write(vbCrLf + "</script>")
        '    End If
        'End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        ''End of comment by Yogesh J on 19-Jan-2016

        Call Initialize()

        'Code Added By Bharat Tekade on 3rd-Feb-2016
        If m_strFromWhere = "SR" Then
            If (m_PKToken <> "" Or Not m_PKToken Is Nothing) And m_strQueryID <> "" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(m_strQueryID, String) + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strQueryID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        ElseIf m_strFromWhere = "BTS" Then
            If (m_PKToken <> "" Or Not m_PKToken Is Nothing) And Request.QueryString("TagID") = "5" And m_strID <> "" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(m_strID, String) + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        ElseIf InStr(m_strFromWhere.ToString, "CRM", CompareMethod.Text) > 0 Then
            If (m_PKToken <> "" Or Not m_PKToken Is Nothing) And Request.QueryString("TagID") = "405" And m_strID <> "" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(m_strID, String) + CType(m_lngEmployeeID, String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        'End of Code Added By Bharat Tekade on 3rd-Feb-2016


        'If Page.IsPostBack Then
        If (Request.QueryString("Action") & "").ToUpper = "ATTACH" Then
            Call PerformActions()
        End If
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True, 2)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        'Added by VijayD on 17 Aug 2009 For Maintaing Search Filter on the Issue_Entry Page
        m_strIssueListSearchType = CommonFunctions.General.CheckIsNothing(Convert.ToString(Request.QueryString("IssueListSearchType")), "")
        m_strIssueListSearchValue = CommonFunctions.General.CheckIsNothing(Convert.ToString(Request.QueryString("IssueListSearchValue")), "0")
        'End Addition By VijayD

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        ' From Where
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        Else
            m_strFromWhere = ""
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("ID") Is Nothing Then
            m_strID = Request.QueryString("ID").ToString
        Else
            m_strID = ""
        End If
        If Not Request.QueryString("Show") Is Nothing Then
            m_strShow = Request.QueryString("Show").ToString
        Else
            m_strShow = ""
        End If
        If Not Request.QueryString("AttachmentType") Is Nothing Then
            m_strAttachmentType = Request.QueryString("AttachmentType").ToString
        Else
            m_strAttachmentType = ""
        End If
        If Not Request.QueryString("ProjectID") Is Nothing Then
            m_lngProjectIDWSR = CType(Request.QueryString("ProjectID"), Long)
        Else
            m_lngProjectIDWSR = 0
        End If
        If Not Request.QueryString("Page") Is Nothing Then
            m_strPage = Request.QueryString("Page").ToString
        Else
            m_strPage = ""
        End If
        If Not Request.QueryString("QueryString") Is Nothing Then
            m_strQueryString = Request.QueryString("QueryString").ToString
        Else
            m_strQueryString = ""
        End If
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_strQueryID = Request.QueryString("QueryID").ToString
        Else
            m_strQueryID = ""
        End If


        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        'If (UCase(Trim(m_strFromWhere & "")) = "CRM,AR" Or UCase(Trim(m_strFromWhere & "")) = "CRM,SR" Or UCase(Trim(m_strFromWhere & "")) = "CRM,DB") Then
        If CType(m_PKToken, String) <> "0" Then
            If Request.QueryString("PKToken") Is Nothing Then
                m_PKToken = Request.Form("txtPkToken").ToString
            Else
                m_PKToken = Request.QueryString("PKToken").ToString
            End If
        End If
        'End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

        ' Added by SavitaS 20 Sept 2006 for Security Issue 6197

        If UCase(Trim(m_strFromWhere & "")) = "BTS" Then
            If Not Request.QueryString("Mode") Is Nothing Then
                m_Mode = Request.QueryString("Mode").ToString
            Else
                m_Mode = ""
            End If
            If Not Request.QueryString("ID") Is Nothing Then
                m_strIssueID = Request.QueryString("ID").ToString
            Else
                m_strIssueID = "0"
            End If

            If CType(m_PKToken, String) <> "0" Then
                If Request.QueryString("PKToken") Is Nothing Then
                    m_PKToken = Request.Form("txtPkToken").ToString
                Else
                    m_PKToken = Request.QueryString("PKToken").ToString
                End If
            End If

            Dim m_attachtoken As String

            m_attachtoken = CommonFunctions.Security.Token.GetToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String))

            If ((m_PKToken = "") And (m_strIssueID.ToString <> "0")) Or _
    ((m_strIssueID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strIssueID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        'End of Added by SavitaS 20 Sept 2006 for Security Issue 6197

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        'Added by ArchanaN on 1-Oct-2010
        If Not Request.QueryString("TagID") Is Nothing Then
            m_intTagID = CommonFunction.General.CheckIsNothing(Request.QueryString("TagID").ToString, 0)
        Else
            m_intTagID = CommonFunction.General.CheckIsNothing(Request.Form("txtTagID").ToString, 0)
        End If
        If m_intTagID <> 0 Then
            m_strExtensionList = CommonFunction.General.GetFileExtnListForTag(m_intTagID.ToString)
        End If
        'End of Added by ArchanaN on 1-Oct-2010

        ' set the max-length
        Select Case UCase(Trim(m_strFromWhere & ""))
            Case "BTS" : m_lngMaxLength = 8000
            Case "KM" : m_lngMaxLength = 100
            Case "RTS" : m_lngMaxLength = 100
            Case "PM" : m_lngMaxLength = 100
            Case "FA" : m_lngMaxLength = 100
            Case "WSR" : m_lngMaxLength = 100
            Case "RESUME" : m_lngMaxLength = 100
            Case "CRM_ADMIN" : m_lngMaxLength = 100
            Case "CRM" : m_lngMaxLength = 1000
                'Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
            Case "CRM,SR", "CRM,AR", "CRM,DB" : m_lngMaxLength = 1000
                'End of Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
            Case Else : Exit Sub
        End Select

    End Sub
    Private Shared Function GetResponse(uri As String, data As Byte()) As String

        Try
            Dim request As HttpWebRequest = TryCast(HttpWebRequest.Create(New Uri(uri)), HttpWebRequest)
            request.KeepAlive = False
            'request.UserAgent = WhatsConstants.UserAgent;
            request.Method = "POST"
            request.Accept = "text/json"
            request.ContentType = "application/x-www-form-urlencoded"
            request.ContentLength = data.Length
            'Dim stream As Stream = New MemoryStream(byteArray)
            ' request.BeginGetRequestStream(New AsyncCallback(AddressOf GetRequestStreamCallback), request)
            request.GetRequestStream().Write(data, 0, data.Length)
            Using reader = New System.IO.StreamReader(request.GetResponse().GetResponseStream())

                Return reader.ReadLine()
            End Using

        Catch ex As System.Net.WebException
            '   MessageBox.Show(ex.Message, "Error Message", MessageBoxButtons.OK, MessageBoxIcon.[Error])
            'var response = ex.Response as HttpWebResponse;
            'ServiceData fex = new ServiceData();
            'throw new FaultException<ServiceData>(fex,new FaultReason(fex.ErrorDetails));
            Return ""
        End Try
        ' allDone.WaitOne()


    End Function

    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strPath As String
        Dim strFileName As String
        Dim strOriginalFileName As String
        Dim strDescription As String
        'Added by NitinC on 22 March 2011 for whizibleSEM 10.0
        Dim arrDescription() As String
        'End of Added by NitinC on 22 March 2011 for whizibleSEM 10.0
        'Added by NitinC on 10 Nov 2011 for whizibleSEM 10.0    
        Dim ShowToCustomer As String
        'End of Added by NitinC on 10 Nov 2011 for whizibleSEM 10.0    

        If UCase(Trim(m_strAction & "")) = "ATTACH" Then
            ' The path 
            Select Case UCase(Trim(m_strFromWhere & ""))
                Case "BTS" : strPath = Server.MapPath("../../Attachments/BTS/")
                Case "KM" : strPath = Server.MapPath("../../Attachments/KM/")
                Case "RTS" : strPath = Server.MapPath("../../Attachments/RTS/")
                Case "PM" : strPath = Server.MapPath("../../Projects/")
                Case "FA" : strPath = Server.MapPath("../../Attachments/FA/")
                Case "WSR" : strPath = Server.MapPath("../../Attachments/PM/")
                Case "RESUME" : strPath = Server.MapPath("../../Attachments/RESUME/")
                Case "CRM_ADMIN" : strPath = Server.MapPath("../../Attachments/CRM/")
                Case "CRM" : strPath = Server.MapPath("../../Attachments/CRM/")
                    'Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
                Case "CRM,SR", "CRM,AR", "CRM,DB" : strPath = Server.MapPath("../../Attachments/CRM/")
                    'End of Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
                Case Else : Exit Sub
            End Select

            'Added while loop by PrashantD 
            'Aded By Mandar N 
            Dim Chkflag As Integer
            'Chkflag = 0
            Dim count As Integer
            count = 0
            While Request.Files.Count > count

                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

                ' upload the file
                'Dim objFile As New FileUpload.cUpload("txtFileName", strPath, strFileName)
                Dim objFile As New FileUpload.cUpload(Request.Files.Keys.Item(count), strPath, strFileName)
                'Added By Mandar N for checking size before uploading the file
                'Added by NitinC on 17 March 2011 for WhizibleSEM version 10.0

                ''Added by swapnil aswale on 15-06-2016
                Dim response As String = String.Empty
                Dim file As HttpPostedFile = Context.Request.Files(count)
                Dim buffer As Byte() = New Byte(256) {}
                Dim MimeType As String

                Dim fileName As String = HttpContext.Current.Request.Files(count).FileName
                Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
                Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
                Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
                Dim CharList As String()
                CharList = ValidateFileName.Split(","c)
                For k As Integer = 0 To CharList.Length - 1
                    If fileName.Contains(CharList(k).ToString) Then
                        fileName1 = fileName1.Replace(CharList(k).ToString, "")
                    End If
                Next
                Dim IsValidFileName As Integer = 1
                Dim ExtensionList As String()
                ExtensionList = fileName.Split("."c)
                If ExtensionList.Length > 2 Then
                    IsValidFileName = 0
                End If
                If fileName = fileName1 And IsValidFileName = 1 Then
                    file.InputStream.Read(buffer, 0, 256)
                    'Added By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
                    file.InputStream.Position = 0
                    'End of Added By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
                    'Commented By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
                    'Dim mimeKey = ConfigurationManager.AppSettings("MimeHostPath")
                    'Dim uri As String = String.Format(mimeKey)

                    'response = GetResponse(uri, buffer)
                    'Dim tokenJson = JsonConvert.SerializeObject(response)

                    'Dim jsonResult = JsonConvert.DeserializeObject(Of Dictionary(Of String, Object))(response)
                    'MimeType = jsonResult.Item("mime")
                    'End of Commented By Bharat Tekade on 26th-Aug-2016 to solve file upload issue

                    Dim logpath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                    Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(count))
                    'If strListofTypes.Contains("text/plain") Or strListofTypes.Contains("text/xml") Or strListofTypes.Contains("application/xml") Or strListofTypes.Contains("text/html") Then
                    'Commented By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
                    'If MimeType = "text/plain" Or MimeType = "text/xml" Or MimeType = "application/xml" Or MimeType = "text/html" Then

                    'Else
                    'End of Commented By Bharat Tekade on 26th-Aug-2016 to solve file upload issue

                    'file.InputStream.Read(buffer, 0, 256)
                    Dim magicNumber As String = BitConverter.ToString(buffer)
                    magicNumber = magicNumber.Replace("-", " ")
                    Dim xmlDoc As New XmlDocument()
                    Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                    xmlDoc.Load(xmlPath + "MIMEType.xml")
                    Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                    Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

                    'Added by imran on 02-01-2023
                    'Dim fileNameExtention As String = HttpContext.Current.Request.Files(count).FileName
                    'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                    'Dim tcount As Integer = ext1.Split("."c).Length - 1
                    'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                    'If tcount > 1 Then
                    '    MimeType = ""
                    'End If

                    'If count = 1 Or count2 = 1 Then
                    For Each node As XmlNode In nodes
                            xContentType = node.SelectSingleNode("ContentType").InnerText
                            If strFileType = xContentType Then
                                fileName = HttpContext.Current.Request.Files(count).FileName
                                Dim ext As String = Path.GetExtension(fileName)
                                ext = ext.Substring(1, ext.Length - 1).ToLower()
                                extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
                                If extfromContentType.IndexOf(ext) > -1 Then
                                    MimeType = strFileType
                                    Exit For
                                End If
                            End If
                        Next
                    'End If
                    'End of comment by imran on 02-01-2022
                Else
                    MimeType = ""
                End If

                If MimeType Is Nothing Or MimeType = "" Then
                    MimeType = "unknown/unknowns"
                End If

                'End If

                ''Ended by swapnil aswale on 15-06-2016

                'Commented By Mandar N on 17.4.12
                'If objFile.FileSize > 3072 Then
                '  changed by mandar for checking that if file size exceed more than 3 MB on 17.4.12

                ''Commented By Vaijat K ON 22/06/2017 For Removing file upload limit
                'If Request.Files.Item(count).ContentLength > 11534336 Then
                '    Dim strMessage As String
                '    strMessage = "<script language=javascript>"
                '    strMessage = strMessage + "alert('File : " + Request.Files.Item(count).FileName.ToString + " exceeded size limit of 3MB');"
                '    strMessage = strMessage + "</script>"
                '    HttpContext.Current.Response.Write(strMessage)
                '    Chkflag = 0

                'Else
                ''End of Commented By Vaijat K ON 22/06/2017 For Removing file upload limit   
                If strListofTypes.IndexOf(MimeType) >= 0 Then
                    Chkflag = 1

                    objFile.OverwriteIfExists = True
                    objFile.UploadFile()

                    ' the file name
                    strOriginalFileName = objFile.OriginalFileName
                    strFileName = objFile.UploadedFileName

                    'End of Added by NitinC on 17 March 2011 for WhizibleSEM version 10.0
                Else
                    CommonFunction.General.WriteHTML("<Script>")
                    CommonFunction.General.WriteHTML("alert('Invalid Content Type!!'); ")
                    'CommonFunction.General.WriteHTML("alert('Please upload valid file.'); ")
                    CommonFunction.General.WriteHTML("</Script>")
                End If
                ''End By Mandar N on 17.4.12

                objFile = Nothing
                'Added by NitinC on 22 March 2011 for whizibleSEM 10.0
                arrDescription = MyBase.GetFormValue("txtComments").Split(",")
                strDescription = arrDescription(count)
                'End of Added by NitinC on 22 March 2011 for whizibleSEM 10.0

                'Added by NitinC on 10 Nov 2011 for whizibleSEM 10.0
                If m_intTagID = 405 Then
                    ShowToCustomer = MyBase.GetFormValue("chkIsShowToCustomer" + CType(count, String))
                    If ShowToCustomer = "on" Then
                        ShowToCustomer = "I"
                    End If
                End If
                'End of Added by NitinC on 10 Nov 2011 for whizibleSEM 10.0

                'Commented by NitinC on 22 March 2011 for WhizibleSEM 10.1
                'strDescription = MyBase.GetFormValue("txtComments")
                'End of Commented by NitinC on 22 March 2011 for WhizibleSEM 10.1

                ' database updates!!!
                If Chkflag = 1 Then '' chkflag condition added by mandar n if file size excceds then it will not be uploaded in attachments table on 17.4.12


                    Select Case UCase(Trim(m_strFromWhere & ""))
                        Case "BTS"
                            '***** Modified by SandipL on 17 Feb 2006 to solve IssueID 2133 whizsem_whiz2 SP6
                            'Modified by PrashantD on 15 March 2007 for IssueID 11562
                            'strSQL = "Exec usp_Ins_tbl_IB_Attachments " & m_strID & ", " & Session("IssueProject").ToString & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                            strSQL = "Exec usp_Ins_tbl_IB_Attachments " & m_strID & ",NULL , " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                            'End of modification by PrashantD on 15 March 2007
                            'strSQL = "Exec usp_Ins_tbl_IB_Attachments " & m_strID & ", " & Session("intProjectID").ToString & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                            '***** End Modification by SandipL on 17 FEB 2006
                            strSQL &= ", '" & CommonFunctions.General.BuildQueryString(strFileName) & "', '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "', '" & CommonFunctions.General.BuildQueryString(strDescription) & "'"
                            If UCase(Trim(m_strAttachmentType & "")) = "LINK" Then
                                strSQL &= ", 1"
                            End If
                        Case "KM"
                            If UCase(Trim(m_strAttachmentType & "")) = "LINK" Then
                                'Commented and modified by SuchitraP on 12-Nov-2008 
                                'Purpose:To insert Attached by and AttachedDate in Attachments table
                                'strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename,SaveAsLink)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "',1)"
                                strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename,SaveAsLink)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "',1,'" & CType(Session("strUserName"), String) & "',GetDate())"
                                'End by SuchitraP
                            Else
                                'Commented and modified by SuchitraP on 12-Nov-2008 
                                'Purpose:To insert Attached by and AttachedDate in Attachments table
                                'strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "')"
                                strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','" & CType(Session("strUserName"), String) & "',GetDate())"
                                'End by SuchitraP
                            End If
                        Case "RTS", "PM", "FA"
                            ' NA
                        Case "WSR"
                            strSQL = "EXEC usp_UploadWSRFiles '" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strDescription) & "'," & m_strID & "," & m_lngProjectIDWSR
                        Case "RESUME"
                            If Trim(m_strID & "") = "" Then
                                m_strID = Session("intUserID").ToString
                            End If
                            If m_strID <> "" Then
                                'If File name is of greater than max chars then
                                If (Len(strOriginalFileName) > 100) Then
                                    strOriginalFileName = Right(strOriginalFileName, 100) & ""
                                End If
                                strSQL = "UPDATE tbl_PM_Employee SET SystemGeneratedFileName = '" & CommonFunctions.General.BuildQueryString(strFileName) & "', OriginalFileName = '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "' WHERE EmployeeID = " & m_strID
                            End If
                        Case "CRM_ADMIN"
                            'If File name is of greater than max chars then
                            If (Len(strOriginalFileName) > 100) Then
                                strOriginalFileName = Right(strOriginalFileName, 100) & ""
                            End If
                            strSQL = "usp_Ins_tbl_CRM_SubRequestType_Templates '" & m_strID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "'"


                        Case "CRM", "CRM,SR", "CRM,AR", "CRM,DB" 'Added , "CRM,SR", "CRM,AR", "CRM,DB" by NitinC on 16 March 2011 for WhizibleSEM version 10.0
                            'Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0
                            'If File name is of greater than max chars then
                            If (Len(strOriginalFileName) > 100) Then
                                strOriginalFileName = Right(strOriginalFileName, 100) & ""
                            End If
                            'End of Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0

                            'Commnted and Added by NitinC on 11 Nov 2011 for whizibleSEM 10.0

                            'strSQL = "usp_CRM_Insert_Attachment '" & m_strID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','"
                            'strSQL &= CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "','"
                            'strSQL &= CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(Session("LoginType").ToString) & "'"
                            If m_intTagID = 405 And ShowToCustomer = "I" Then
                                strSQL = "usp_CRM_Insert_Attachment '" & m_strID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','"
                                strSQL &= CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "','"
                                strSQL &= CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(Session("LoginType").ToString) & "','" & CommonFunctions.General.BuildQueryString(ShowToCustomer) & "'"
                            Else
                                strSQL = "usp_CRM_Insert_Attachment '" & m_strID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','"
                                strSQL &= CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "','"
                                strSQL &= CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(Session("LoginType").ToString) & "'"
                            End If


                            'End of Commnted and Added by NitinC on 11 Nov 2011 for whizibleSEM 10.0
                        Case Else
                    End Select

                End If
                If Trim(strSQL & "") <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If
                count += 1
            End While
        End If
    End Sub
    'Added By Dipali V On 31st Oct 2022 For File Content Type
    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function
    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr
        Dim MaxContent As Integer = CInt(file.ContentLength)
        If MaxContent > 200 Then MaxContent = 200
        Dim buf As Byte() = New Byte(MaxContent - 1) {}
        file.InputStream.Read(buf, 0, MaxContent)
        Dim result As Integer = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, Nothing, 0, mimeout, 0)

        If result <> 0 Then
            Marshal.FreeCoTaskMem(mimeout)
            Return ""
        End If

        Dim mime As String = Marshal.PtrToStringUni(mimeout)
        Marshal.FreeCoTaskMem(mimeout)
        Return mime.ToLower()
    End Function
    'End of Added By Dipali V On 31st Oct 2022 For File Content Type

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {"Upload", MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {"Upload", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrCSFunction() As String = {"Attach_OnClick('" & m_strID & "','" & m_strFromWhere & "','" & m_lngProjectIDWSR & "')", "Close_OnClick()"}

        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")

            '.Write("<TABLE id='tblFileAttachment' cellspacing=0 class=clsTable style='Width:99.9%;visibility:visible;DISPLAY: inline'>")   'Commented & Added by Puneet M ON 25-11-2015 IssueID:1768
            .Write("<TABLE id='tblFileAttachment' cellspacing=0 class=clsTable style='Width:99.9%;visibility:visible;'>")

            'Added By KapilGK For WhizibleSEM SP 8 On 10 Nov 2006
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("<B>Note : </B> User can attach maximum five files at a time.")
            .Write("</TD>")
            .Write("</TR>")
            'End of Addition By KapilGk

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            'Added by NitinC on 01 April 2011 for WhizibleSEM 10.0
            CommonFunctions.General.WriteHTML("<BR>")
            'End of Added by NitinC on 01 April 2011 for WhizibleSEM 10.0
            .Write("<B>" + "Select File" + "</B>")
            .Write("</TD>")
            .Write("</TR>")

            ' the file control
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            'CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()' onchange='addFileinGrid()'")
            .Write("</TD>")
            .Write("</TR>")

            ''added by PrashantD
            'Modified by NitinC on 10 Nov 2011 for WhizibleSEM 10.0
            If m_intTagID = 405 Then
                CommonFunctions.General.WriteHTML("<tr class=clsTREven id=AttFileHead style='display:none' ><td><B>Attached Files</B></td></tr><TR class=clsTREven ><TD><BR><table id=tblFiles style='display:none;width=85%;' class=clsGridTable><thead class=clsTRColumnHeader align='left'><th>Files</th><th width=100>Comments</th><th >Document Status(Checked if internal)</th><th ></th></thead></table></TD></TR>")
            Else
                CommonFunctions.General.WriteHTML("<tr class=clsTREven id=AttFileHead style='display:none' ><td><B>Attached Files</B></td></tr><TR class=clsTREven ><TD><BR><table id=tblFiles style='display:none;width=85%;' class=clsGridTable><thead class=clsTRColumnHeader align='left'><th>Files</th><th width=100>Comments</th><th ></th></thead></table></TD></TR>")
            End If
            'End of Modified by NitinC on 10 Nov 2011 for WhizibleSEM 10.0


            ' comments
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            'Commented by NitinC on 22 March 2011 for WhizibleSEM 10.0
            'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmAttachment", , , 450, 100, 2000)
            'End of Commented by NitinC on 22 March 2011 for WhizibleSEM 10.0
            CommonFunctions.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , m_intTagID.ToString, IsHidden:=True)
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            ' Message Table
            .Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='90%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            .Write("<TR>")
            .Write("<TD height='20'>")
            .Write("&nbsp;</TD></TR>")
            .Write("<TR><TD align=center class=clsTDEven>")
            .Write("<LABEL id=lblFileUploadStatus><B>Uploading file(s)...Please wait !!</B></LABEL>")
            .Write("</TD></TR>")
            .Write("</TABLE>")

            .Write("</DIV>")
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub

End Class