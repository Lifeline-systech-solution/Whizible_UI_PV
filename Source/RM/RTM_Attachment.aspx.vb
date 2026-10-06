Imports System.IO
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class RTM_Attachment
    Inherits WebPages.Template.WhizTemplate

    Protected m_strProjectRequirementID As String = ""
    Protected m_strReqTRPhaseID As String = ""
    Protected m_strTRPhaseID As String = ""
    Protected m_strPath As String = ""
    Protected m_strFileName As String = ""
    Protected m_intProjectID As Long = 0
    Protected m_strPKToken As String = ""
    Protected m_strLoginType As String
    Protected m_strFromWhere As String = ""
    Protected m_strAction As String = ""
    Protected m_lngUserID As Long
    Protected m_strMode As String = ""
    Protected m_strID As String = ""
    Private m_blnUseSQL As Boolean
    Protected m_lngMaxLength As Long = 100
    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
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
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        MyBase.InitializeResources("AppResources.RM_Documents", "AppResources")


    End Sub
    Private Function CreateDirectoryStructure(ByVal lngProjectID As Long, ByVal lngProjectRequirementID As Long) As String  ', ByVal lngSubCategoryID As String, ByVal lngDocumentTypeID As Long
        '=====================================================================
        ' Procedure Name		:	CreateDirectoryStructure
        ' Parameters Passed		:	lngProjectID    - Long - current project ID
        '                           lngProjectRequirementID   _ Long  - ProjectRequirement ID
        ' Returns				:	String - Directory name
        ' Parameters Affected	:	None
        ' Purpose				:	To Get the directory name for the project and category given
        ' Description			:	Here this function will create the directory structure for the given 
        '                           project and category if it is not present. Structure is there is ProjectCode nameed
        '                           directory under Documents and under that there is Category named directory.
        ' Assumptions			:	None
        ' Dependencies			:	None

        ' Modified By           :   ChristinaT
        ' Purpose               :   Requirement Management (RM)
        ' Created               :   Dec(28, 2006)

        '=====================================================================

        Dim strDirectory As String
        Dim strFullPath As String
        Dim strProjectCode As String
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objDrProject As IDataReader
        Dim objFile As CommonFunction.FileDirectory

        strFullPath = Server.MapPath("../..") + "\" + "Requirement Management"
        'if Requirement Management directory does not exist ,create it
        If CommonFunctions.FileDirectory.IsDirectoryExists(strFullPath) = False Then
            CommonFunctions.FileDirectory.CreateDirectory(Server.MapPath("../../"), "Requirement Management")
        End If

        'get the project code to create the directory of name project code
        strSQL = "usp_Sel_tbl_PM_Project " + lngProjectID.ToString
        objDrProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDrProject.Read Then
            strProjectCode = CommonFunctions.Data.CheckIsDBNull(objDrProject("ProjectCode"), "").ToString + ""
        End If
        CommonFunctions.Data.DisposeDataReader(objDrProject)

        strProjectCode = Replace(strProjectCode, "\", "_")
        strProjectCode = Replace(strProjectCode, "/", "_")

        'create full path to create the directory
        strFullPath = Server.MapPath("../../Requirement Management") + "\" + strProjectCode.Trim
        'if project code named directory is not existing then create it
        If CommonFunctions.FileDirectory.IsDirectoryExists(strFullPath) = False Then
            CommonFunctions.FileDirectory.CreateDirectory(Server.MapPath("../../Requirement Management/"), strProjectCode.Trim)
        End If
        strFullPath += "\"

        ''strSQL = "usp_Sel_RM_GetDirName " + lngDocumentTypeID.ToString
        ''objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        ''If objDr.Read Then
        ''    strDirectory = CommonFunctions.Data.CheckIsDBNull(objDr("DirName"), "").ToString + ""

        ''    'if directory for dirname corresponding to a document type is not existing then create it
        ''    strFullPath += strDirectory
        ''    If CommonFunctions.FileDirectory.IsDirectoryExists(strFullPath) = False Then
        ''        CommonFunctions.FileDirectory.CreateDirectory(Server.MapPath("../../Requirement Management/" + strProjectCode + "/"), strDirectory)
        ''    End If

        ''End If

        strDirectory = "ReqTRPhaseID" + m_strReqTRPhaseID
        strFullPath += strDirectory
        If CommonFunctions.FileDirectory.IsDirectoryExists(strFullPath) = False Then
            CommonFunctions.FileDirectory.CreateDirectory(Server.MapPath("../../Requirement Management/" + strProjectCode + "/"), "ReqTRPhaseID" + m_strReqTRPhaseID)
        End If

        m_strPath = strFullPath

        CommonFunctions.Data.DisposeDataReader(objDr)
        CreateDirectoryStructure = strDirectory
    End Function
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
        Dim strFileName As String
        Dim strOriginalFileName As String
        Dim strDescription As String
        Dim strTemplateID As String
        ''Dim intDocumentTypeId As Integer
        Dim objFileUpload As FileUpload.cUpload
        Dim drDoc As IDataReader
        Dim objFile As CommonFunction.FileDirectory.FileProperties
        Dim dblFileSize As Double
        Dim strCreatedDate As String
        Dim strLastModifiedDate As String
        Dim strOldFileName As String
        Dim strUploadedFileName As String
        Dim strFilePath As String
        Dim strDirectoryName As String

        If UCase(Trim(m_strAction & "")) = "ATTACH" Then
            ''intDocumentTypeId = CInt(HttpContext.Current.Request.Form("cboDocumentType"))
            ''Added by swapnil aswale on 15-06-2016

            Dim response As String = String.Empty
            Dim file As HttpPostedFile = Context.Request.Files(0)
            Dim buffer As Byte() = New Byte(256) {}

            Dim MimeType As String
            Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
            Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
            Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
            Dim CharList As String()
            CharList = ValidateFileName.Split(","c)
            For i As Integer = 0 To CharList.Length - 1
                If fileName.Contains(CharList(i).ToString) Then
                    fileName1 = fileName1.Replace(CharList(i).ToString, "")
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
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
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
                'Dim fileNameExtention As String = HttpContext.Current.Request.Files(0).FileName
                'Dim ext1 As String = Path.GetExtension(fileNameExtention)
                'Dim count As Integer = ext1.Split("."c).Length - 1
                'Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
                'If count > 1 Then
                '    MimeType = ""
                'End If
                'If count = 1 Or count2 = 1 Then
                For Each node As XmlNode In nodes
                        xContentType = node.SelectSingleNode("ContentType").InnerText
                        If strFileType = xContentType Then
                            fileName = HttpContext.Current.Request.Files(0).FileName
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
            If strListofTypes.IndexOf(MimeType) >= 0 Then
                strDirectoryName = CreateDirectoryStructure(m_intProjectID, CInt(m_strProjectRequirementID))
                objFileUpload = New FileUpload.cUpload("txtFileName", m_strPath)
                objFileUpload.OverwriteIfExists = False
                objFileUpload.UploadFile()
                strOldFileName = objFileUpload.OriginalFileName
                If strOldFileName = "" Then
                    strOldFileName = "NULL"
                End If
                strUploadedFileName = objFileUpload.UploadedFileName

                objFileUpload = Nothing

                'create the fileProperties object ot get the properties of the file
                objFile = New CommonFunction.FileDirectory.FileProperties
                objFile.FilePath = m_strPath + "\" + strUploadedFileName.Trim
                objFile.GetFileProperties()
                dblFileSize = objFile.FileSizeInKB
                strCreatedDate = objFile.FileCreatedDate.ToString
                strLastModifiedDate = objFile.LastUpdatedDate.ToString

                strUploadedFileName = strUploadedFileName.Substring(0, strUploadedFileName.LastIndexOf("."))
                strFileName = strOldFileName.Substring(0, strOldFileName.LastIndexOf("."))

                strDescription = Request.Form("txtComments").ToString

                'make the entry of the file in the database
                If m_strLoginType.ToUpper.Trim = "C" Then
                    ' To cater for special characters in filename, added function General.BuildQueryString() to strUploadedFileName
                    strSQL = "Exec usp_Ins_tbl_RTM_ProjectReqTRDocument " + m_strProjectRequirementID + "," + m_intProjectID.ToString + ","
                    strSQL += m_strReqTRPhaseID.Trim + "," + m_strTRPhaseID.Trim + ",'" + CommonFunctions.General.BuildQueryString(strDirectoryName.Trim) + "','"
                    strSQL += CommonFunctions.General.BuildQueryString(strUploadedFileName.Trim) + "','" + strCreatedDate.Trim + "','" + strLastModifiedDate.Trim + "','"
                    strSQL += strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + "','"
                    strSQL += CommonFunctions.General.BuildQueryString(strFileName.Trim) + "'," + m_lngUserID.ToString + ",'C',NULL,'" + strOldFileName + "'"
                Else
                    strSQL = "Exec usp_Ins_tbl_RTM_ProjectReqTRDocument " + m_strProjectRequirementID + "," + m_intProjectID.ToString + ","
                    strSQL += m_strReqTRPhaseID.Trim + "," + m_strTRPhaseID.Trim + ",'" + CommonFunctions.General.BuildQueryString(strDirectoryName.Trim) + "','"
                    strSQL += CommonFunctions.General.BuildQueryString(strUploadedFileName.Trim) + "','" + strCreatedDate.Trim + "','" + strLastModifiedDate.Trim + "','"
                    strSQL += strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + "','"
                    strSQL += CommonFunctions.General.BuildQueryString(strFileName.Trim) + "'," + m_lngUserID.ToString + ",'E',NULL,'" + strOldFileName + "'"
                End If

                objFile = Nothing

                If Trim(strSQL & "") <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If

                Dim strScript As String


                strScript = vbCrLf + "<Script language=javascript>"
                'Comment and addition by SuchitraP on 13 Sept 2007
                'strScript += vbCrLf + "    refreshParent('frmCommonList','RequirementTraceabilityDocument_CommonList.aspx','RequirementTraceabilityDocument_CommonList.aspx?ProjectID=" + m_intProjectID.ToString + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID=" + m_strReqTRPhaseID + "&TRPhaseID=" + m_strTRPhaseID + _
                '                "&MasterTagID=10061&FromWhere=RM&FromCL=1' );"
                strScript += vbCrLf + "    refreshParent('frmCommonList','RequirementTraceabilityDocument_CommonList.aspx','RequirementTraceabilityDocument_CommonList.aspx?ProjectID=" + m_intProjectID.ToString + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID=" + m_strReqTRPhaseID + "&TRPhaseID=" + m_strTRPhaseID +
                                "&MasterTagID=3841&FromWhere=RM&FromCL=1' );"
                'End of Comment and addition by SuchitraP on 13 Sept 2007
                strScript += vbCrLf + "    window.close();"
                '''added by PrashantD for refresh tracking page
                ''strScript += vbCrLf + "window.opener.opener.document.forms[0].action=""../RM/RM_Tracking.aspx"";"
                ''strScript += vbCrLf + "window.opener.opener.document.forms[0].submit();"
                '''end of addition by PrashantD
                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)
            Else
                CommonFunction.General.WriteHTML("<Script>")
                'CommonFunction.General.WriteHTML("alert('Invalid Content Type!!'); ")
                CommonFunction.General.WriteHTML("alert('Please upload valid file.'); ")
                CommonFunction.General.WriteHTML("</Script>")
            End If


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


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the variables
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 6,2006
        ' Revisions             :
        '=====================================================================
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        If Not Request.QueryString("ID") Is Nothing Then
            m_strID = Request.QueryString("ID").ToString
        Else
            m_strID = ""
        End If
        If Request.QueryString("ProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        Else
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If

        If Request.QueryString("ReqTRPhaseID") <> "" Then
            m_strReqTRPhaseID = Request.QueryString("ReqTRPhaseID")
        Else
            m_strReqTRPhaseID = Request.Form("hidReqTRPhaseID")
        End If
        If Request.QueryString("TRPhaseID") <> "" Then
            m_strTRPhaseID = Request.QueryString("TRPhaseID")
        Else
            m_strTRPhaseID = Request.Form("hidTRPhaseID")
        End If


        If Not Request.Form("txtPkToken") Is Nothing Then
            m_strPKToken = Request.Form("txtPkToken").ToString
        End If
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        End If
        m_strLoginType = Session("LoginType").ToString + ""
        'm_intProjectID = CType(Session("intProjectID"), Long)
        If Request.QueryString("ProjectID") <> "" Then
            m_intProjectID = CType(Request.QueryString("ProjectID"), Long)
        Else
            m_intProjectID = CType(Request.Form("hidProjectID"), Long)
        End If
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_intProjectID.ToString + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidTRPhaseID id=hidTRPhaseID value=" + m_strTRPhaseID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidReqTRPhaseID id=hidReqTRPhaseID value=" + m_strReqTRPhaseID + ">")

        m_lngUserID = CType(Session("intUserID").ToString, Long)
        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub

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
        ' Author                : KapilGK
        ' Created               : Oct 6,2006
        ' Revisions             :
        '=====================================================================

        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If


        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE"), "?"}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), "Help"}
        Dim arrCSFunction() As String = {"Attach_OnClick('" & m_strProjectRequirementID & "','" & m_strFileName & "','" + m_intProjectID.ToString + "')", "Close_OnClick()", "Help_OnClick('3721')"}
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strTemplateSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            .Write(strMenu)
            .Write("<BR>")

            'draw page caption 
            WebPage.Templates.PageCaption.GetPageCaptions(, "Document Upload")
            CommonFunctions.General.WriteHTML("<BR>")

            .Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")

            .Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")

            ''strTemplateSQL = " Usp_RM_GetDocumentType "

            ''.Write("<TR class=clsTREven>")
            ''.Write("<TD>")
            ''.Write("" + MyBase.GetResourceString("LBL_DOCUMENTTYPE") + "")
            ''.Write("</TD>")
            ''.Write("<TD align=left >")
            ''CommonFunctions.HTMLControls.DrawComboBox("cboDocumentType", strTemplateSQL, , "", , True, , , True, "../../Images/Star.gif", , 0)
            ''.Write("</TD>")
            ''.Write("</TR>")

            ''.Write("<TR class=clsTREven>")
            ''.Write("<TD>")
            ''.Write("Reference Section")
            ''.Write("</TD>")
            ''.Write("<TD align=left >")
            ''CommonFunctions.HTMLControls.DrawComboBox("cboSection", "usp_Sel_tbl_RM_ProjectRequirementSections_ForAttachCombo " + m_strProjectRequirementID, , "", , True)
            ''.Write("</TD>")
            ''.Write("</TR>")


            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("" + MyBase.GetResourceString("LBL_SELECTFILE") + "")
            .Write("</TD>")

            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'", , , 1)
            .Write("</TD>")
            .Write("</TR>")

            ' comments
            .Write("<TR class=clsTREven>")
            .Write("<TD>" + MyBase.GetResourceString("LBL_DESCRIPTION") + "</TD>")
            .Write("<TD>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRTM_Attachment", , , 450, 100, 2000, Wrap:="Hard")
            CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRTM_Attachment", , , 450, 100, 2000, Wrap:="Hard", EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            ' Message Table
            .Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='90%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            .Write("<TR>")
            .Write("<TD height='20'>")
            .Write("&nbsp;</TD></TR>")
            .Write("<TR><TD align=center class=clsTDEven>")
            .Write("<LABEL id=lblFileUploadStatus><B>Uploading file...Please wait !!</B></LABEL>")
            .Write("</TD></TR>")
            .Write("</TABLE>")

            .Write("</DIV>")
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub
End Class