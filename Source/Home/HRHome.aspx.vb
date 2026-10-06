Option Strict Off
Imports System.Text
Imports System.IO
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class HRHome
    Inherits WebPages.Template.WhizTemplate

    Private m_intLeftRows As Integer = 0
    Private m_intRightRows As Integer = 0
    Protected m_intUserID As Integer
    Private m_strModuleShortName As String = ""
    Protected m_MessageType As Long = 1
    Protected m_PageNumber As Long = 1
    Protected m_PageSize As Double = 5
    Protected m_ShortName As String = ""
    Protected m_strPhotoFilepath As String = ""
    Private m_strSearchText As String = ""
    Protected m_intShowMarqueeSection As Integer = 0
    Protected m_strShowDisplay As String = "1"
    Protected m_intItemCount As Integer = 0
    Protected m_strMode As String = ""

    Structure Access
        Dim blnAdd As Boolean
        Dim blnEdit As Boolean
        Dim blnDelete As Boolean
        Dim blnView As Boolean
        Dim blnAccess As Boolean
    End Structure

    Enum MessageType
        INBOX = 1
        SENT = 2
        COMPOSE = 3
    End Enum

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        Session.Remove("MenuGroupID")
        If Not Request.QueryString("UploadPhoto") Is Nothing Then
            If Not HttpContext.Current.Request.QueryString("FilePath") Is Nothing Then
                m_strPhotoFilepath = HttpContext.Current.Request.QueryString("FilePath")
            End If
            If m_strPhotoFilepath <> "" Then
                Call UploadPhoto()
            End If
        End If

    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To Initialize the Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================
        Dim intcontrolItemID As Integer
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsXMLHTTP"), 0) = 1 Then
            m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Mode"), "")
            If m_strMode <> "" Then
                intcontrolItemID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ControlItemID"), 0)
                AddRemoveFavourites(intcontrolItemID, m_strMode)
            End If
        Else
            InitVariables()
            Draw_Page()
            DrawHiddenControls()
        End If

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
    Private Sub UploadPhoto()
        'Response.Clear()
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
            Dim strSQL As String = ""
            ' Dim intInductionID As Integer = 0
            Dim strUniqueFileName As String = ""
            Dim strFilePath As String = ""
            Dim strOriginalfilename As String = ""
            Dim intIndex As Integer = 0
            Dim strFileExtension As String = ""
            Dim dblFileSize As Double
            Dim blnExtensionCheck As Boolean = True
            Dim strPath As String = Server.MapPath("../../Images/Photo/")
            Dim objFile As CommonFunction.FileDirectory.FileProperties
            objFile = New CommonFunction.FileDirectory.FileProperties
            objFile.FilePath = m_strPhotoFilepath
            objFile.GetFileProperties()
            dblFileSize = objFile.FileSizeInKB
            m_strPhotoFilepath = HttpContext.Current.Request.QueryString("FilePath")
            If dblFileSize > CType(CommonFunction.Data.GetDataScalar("SELECT ISNULL(FileSizeInKB,0) [FileSizeInKB] FROM tbl_PM_CompanyInformation", True), Double) Then
                CommonFunction.General.WriteHTML("<script>")
                CommonFunction.General.WriteHTML("alert('File size exceeds limit.');")
                CommonFunction.General.WriteHTML("</script>")
            Else
                'Try
                intIndex = m_strPhotoFilepath.LastIndexOf("\")
                strOriginalfilename = m_strPhotoFilepath.Substring(intIndex + 1, m_strPhotoFilepath.Length - intIndex - 1)
                intIndex = strOriginalfilename.IndexOf(".")
                strFileExtension = strOriginalfilename.Substring(intIndex + 1, strOriginalfilename.Length - intIndex - 1)

                blnExtensionCheck = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_Photo_FileExtensions '" + strFileExtension + "'", True), Boolean)
                If blnExtensionCheck = False Then
                    Exit Sub
                End If
                strUniqueFileName = CommonFunction.FileDirectory.GetUniqueFileName(strFileExtension)

                Dim objFile_new As New FileUpload.cUpload("txtFileName", strPath, strUniqueFileName)
                objFile_new.OverwriteIfExists = True
                objFile_new.UploadFile()
                ' the file name
                strOriginalfilename = objFile_new.OriginalFileName
                strUniqueFileName = objFile_new.UploadedFileName
                objFile_new = Nothing

                'CommonFunction.FileDirectory.CopyFile(m_strPhotoFilepath, Server.MapPath("../../Images/Photo/" + strUniqueFileName))

                strSQL = "usp_ins_upd_tbl_RM_EmployeeMaintenance_Attachment " + HttpContext.Current.Session("intUserID").ToString() + ",'" + CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName")) + "','" + strOriginalfilename + "','" + strUniqueFileName + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If
        Else
            CommonFunction.General.WriteHTML("<Script>")
            'CommonFunction.General.WriteHTML("alert('Invalid Content Type!!'); ")
            CommonFunction.General.WriteHTML("alert('Please upload valid file.'); ")
            CommonFunction.General.WriteHTML("</Script>")
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
    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialize the Variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================
        Dim drCurrentYear As IDataReader
        Dim strSQL As String = ""
        If Not HttpContext.Current.Request.QueryString("ShowMarquee") Is Nothing Then
            m_intShowMarqueeSection = HttpContext.Current.Request.QueryString("ShowMarquee")
        ElseIf Not HttpContext.Current.Request.Form("ShowMarquee") Is Nothing Then
            m_intShowMarqueeSection = HttpContext.Current.Request.Form("ShowMarquee")
        End If
        m_intUserID = Session("intUserID")
        'Added By KapilGK on 6-Aug-2008 for Role access
        m_strModuleShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShortName"))

        If m_strModuleShortName = "" Then
            m_strModuleShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strShortName"))
        Else
            HttpContext.Current.Session("strShortName") = m_strModuleShortName
        End If
        'End of addition by KapilGK on 6-Aug-2008 for Role access

        If IsPostBack() Then
        Else
        End If

        If Not HttpContext.Current.Request.QueryString("ShowMarquee") Is Nothing Then
            m_intShowMarqueeSection = HttpContext.Current.Request.QueryString("ShowMarquee")
        ElseIf Not HttpContext.Current.Request.Form("ShowMarquee") Is Nothing Then
            m_intShowMarqueeSection = HttpContext.Current.Request.Form("ShowMarquee")
        End If

        If Not HttpContext.Current.Request.Form("DisplayDiv") Is Nothing Then
            m_strShowDisplay = HttpContext.Current.Request.Form("DisplayDiv")

        End If

        If Not IsNothing(HttpContext.Current.Request.Form("txtMessageType")) = True Then
            m_MessageType = HttpContext.Current.Request.Form("txtMessageType").ToString()
        Else
            m_MessageType = "1"
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("txtPageNumber")) = True Then
            m_PageNumber = HttpContext.Current.Request.Form("txtPageNumber").ToString()
        Else
            m_PageNumber = 1
        End If
        'MyBase.InitializeResources("AppResourceHR.HomePage", "AppResourceHR")
        m_ShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShortName"), "")
        If m_ShortName = "" Then
            m_ShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtShortName"), "")
        End If

        'Added by SandipL for text search
        'If Not Request("txtSearch") Is Nothing Then
        '    m_strSearchText = Request("txtSearch").Trim()
        '    HttpContext.Current.Session("SearchText" + m_strModuleShortName) = m_strSearchText
        'Else
        '    If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("SearchText" + m_strModuleShortName)) <> "" Then
        '        m_strSearchText = CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("SearchText" + m_strModuleShortName))
        '    End If
        'End If

        m_strSearchText = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("SearchText"), "").ToString
    End Sub
    Protected Sub DrawMyProfile(ByVal GadgetTitle As String, ByVal sbHTML As StringBuilder)
        '=====================================================================
        ' Procedure Name        : DrawMyProfile()
        ' Purpose               : To draw the Profile details of logged in resource.
        ' Description           : The proc. draws the task pad page for the logged in user
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : NitinVS
        ' Created               : Feb 8,2008
        ' Revisions             :
        '=====================================================================
        Dim objDR As IDataReader
        Dim sbToken As New StringBuilder

        objDR = CommonFunction.Data.GetDataReader(New StringBuilder("usp_SEL_Tbl_PM_EmployeeMyProfile ").Append(m_intUserID).ToString(), MyBase.UseSQL)
        If objDR.Read() Then
            'border='0'
            'sbHTML.Append("<table id='tblMyProfile' class='clsTable' cellspacing='0' cellpadding='0' style='width:100%;height:210px;border-color:black;border-width:1px;border-style:Solid'>")

            sbHTML.Append("<table id='HeaderTable' WIDTH=100% CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableHeader' >")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td WIDTH='14' class='clsTDTopLeftCorner'>  </td>")
            sbHTML.Append("<td  rowspan='2' valign='middle'> ")

            sbHTML.Append("<table WIDTH=100% Class='clsRoundedTableHeader' ><tr><td align='Left'><b>My Profile </b></td>")
            sbHTML.Append("</tr></table>")
            sbHTML.Append("</td>")
            sbHTML.Append("<td WIDTH='14' class='clsTDTopRightCorner'>  </td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("<tr>")
            sbHTML.Append("<td>&nbsp;&nbsp;</td>")
            sbHTML.Append("<td>&nbsp;&nbsp;</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")

            sbHTML.Append("<table id='tblMyProfile' Class='clsRoundedTableMenu' height=210px cellspacing='0' cellpadding='0' >")
            sbHTML.Append(Environment.NewLine)
            sbHTML.Append("<tr class='clsTRControlMenu' >")
            sbHTML.Append("<td style='width:10%'>")
            sbHTML.Append("<img src='")
            sbHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("ImagePath"), "").ToString(), ""))
            sbHTML.Append("' style='text-decoration:none;height:144px;width:112px' border='1' />")
            sbHTML.Append("</td>")
            sbHTML.Append("<td style='vertical-align:top'>")

            sbHTML.Append("<table id='tblMyProfile1'  Class='clsTable' cellspacing='0' cellpadding='0' >")
            'sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<tr  class='clsTRControlMenu'>")
            sbHTML.Append("<td style='text-align:right;width:25%'><b>")
            sbHTML.Append("Name : ")
            sbHTML.Append("</b></td>")
            sbHTML.Append("<td style='text-align:left;width:65%'>")
            sbHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("EmployeeName"), "").ToString(), ""))
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append(Environment.NewLine)
            'sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<tr  class='clsTRControlMenu'>")
            sbHTML.Append("<td style='text-align:right'><b>")
            sbHTML.Append("Role : ")
            sbHTML.Append("</b></td>")
            sbHTML.Append("<td style='text-align:left'>")
            sbHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("RoleName"), "").ToString(), ""))
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append(Environment.NewLine)
            'sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<tr  class='clsTRControlMenu'>")
            sbHTML.Append("<td style='text-align:right'><b>")
            sbHTML.Append("Joining Date : ")
            sbHTML.Append("</b></td>")
            sbHTML.Append("<td style='text-align:left'>")
            If IsDBNull(objDR("JoiningDate")) = False Then
                sbHTML.Append(CommonFunction.Dates.CGetDate(CType(CommonFunction.Data.CheckIsDBNull(objDR("JoiningDate"), ""), DateTime)))
            Else
                sbHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("JoiningDate"), "").ToString(), ""))
            End If

            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append(Environment.NewLine)
            'sbHTML.Append("<tr class='clsTREven'>")
            sbHTML.Append("<tr  class='clsTRControlMenu'>")
            sbHTML.Append("<td style='text-align:right'><b>")
            sbHTML.Append("Grade : ")
            sbHTML.Append("</b></td>")
            sbHTML.Append("<td style='text-align:left'>")
            sbHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objDR("Grade"), "").ToString(), ""))
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            'Added By PiyushB on 19-Aug-2008 
            sbHTML.Append("<tr  class='clsTRControlMenu'>")
            sbHTML.Append("<td style='text-align:left'; colspan='2'> <a  ' href='javascript:ShowMyProfile(")
            sbHTML.Append(m_intUserID)
            sbHTML.Append(",'")
            sbToken.Length = 0
            sbToken.Append(m_intUserID)
            sbToken.Append(m_intUserID)
            sbToken.Append("0")
            sbToken.Append("2404")
            sbHTML.Append(CommonFunctions.Security.Token.GetToken(sbToken.ToString()))
            sbHTML.Append("')'")
            sbHTML.Append(">")
            sbHTML.Append("Update Profile")
            sbHTML.Append("</a></td>")
            sbHTML.Append("</tr>")
            'Code to Upload Photo
            'sbHTML.Append("<tr class='clsTREven' >")
            sbHTML.Append("<tr  class='clsTRControlMenu'>")

            sbHTML.Append("<td style='text-align:left;cursor:pointer;'; colspan='2' onclick='javascript:UploadEmployeeImage(event,")
            sbHTML.Append(m_intUserID)
            sbHTML.Append(")'")
            sbHTML.Append("><font fontFamily:' Arial'; size='-2'>")
            sbHTML.Append("<u>Update Photo</u>")
            sbHTML.Append("</font></td>")
            sbHTML.Append("</tr>")
            'Addition Ended By PiyushB on 19-Aug-2008
            sbHTML.Append("</table>")
            sbHTML.Append(Environment.NewLine)
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append(Environment.NewLine)

            sbHTML.Append("</table>")
            sbHTML.Append(Environment.NewLine)
        Else
            sbHTML.Append("<table id='tblMyProfile' class='clsGridTable' cellspacing='1' cellpadding='0' style='width:100%;border-color:black;border-width:1px;border-style:Solid'>")
            sbHTML.Append("<tr class='clsTrColumnHeader'>")
            sbHTML.Append("<td>")
            sbHTML.Append("<td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
        End If
        sbHTML.Append("<br/>")
        CommonFunction.Data.DisposeDataReader(objDR)
    End Sub
    Protected Sub DrawMyMessages(ByRef sbHTML As StringBuilder)
        '=====================================================================
        ' Procedure Name        : DrawMyMessages()
        ' Purpose               : To draw the My Message screen.
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : NitinVS
        ' Created               : Mar 7,2008
        ' Revisions             :
        '=====================================================================

        Dim objDSMessages As DataSet
        Dim objInboxGrid As New WebPage.Templates.GenericGrid
        Dim arrActualColumnNameInbox(3) As String '= {"FromEmployee", "MessageDate", "Subject", ""}
        Dim arrUserFriendlyColumnNameInbox(3) As String '= {MyBase.GetResourceString("COL_FROMEMPLOYEE"), MyBase.GetResourceString("COL_MESSAGEDATE"), MyBase.GetResourceString("COL_SUBJECT"), MyBase.GetResourceString("COL_DELTE")}
        Dim arrTdStyleInbox As String() = {"style='text-align:left;width:30%'", "style='text-align:left;width:10%'", "style='text-align:left;width:55%'", "style='text-align:center;width:5%'"}
        Dim NoOfPages As Double = 0

        Dim arrRowLinkInbox As String() = {"MessageOnClick(MessageID)", "", "", ""}
        Dim arrCheckboxArray As String() = {"", "", "", "ChkDelete"}

        Dim sbHeaderHtml As New StringBuilder("")
        '' ''If m_strShowDisplay = "2" Then
        '' ''    sbHeaderHtml.Append("<div ID='MyNewsAlertsDiv' style='overflow:auto;width:99.99%;height:200px;'>")
        '' ''Else
        '' ''    sbHeaderHtml.Append("<div ID='MyNewsAlertsDiv' style='overflow:auto;width:99.99%;height:200px;display:none;'>")
        '' ''End If

        ' If txtmesageaction = '1' delete the selected records 
        'If Not IsNothing(HttpContext.Current.Request.Form("txtmesageaction")) Then
        '    Dim MessageAction As String = HttpContext.Current.Request.Form("txtmesageaction").ToString()
        '    Dim sbSQL As New StringBuilder("usp_DEL_MyMessages ")
        '    If MessageAction = "1" Then ' Delete the selected records
        '        sbSQL.Append(m_MessageType)
        '        sbSQL.Append(",'")
        '        sbSQL.Append(HttpContext.Current.Request.Form("chkDelete").ToString())
        '        sbSQL.Append("'")
        '        CommonFunction.Data.InsertOrUpdateData(sbSQL.ToString(), MyBase.UseSQL)
        '        sbSQL = Nothing
        '        MessageAction = Nothing
        '    End If
        'End If

        'If m_MessageType = MessageType.INBOX Then

        '    arrActualColumnNameInbox(0) = "FromEmployee"
        '    arrActualColumnNameInbox(1) = "MessageDate"
        '    arrActualColumnNameInbox(2) = "Subject"
        '    arrActualColumnNameInbox(3) = '

        '    arrUserFriendlyColumnNameInbox(0) = MyBase.GetResourceString("COL_FROMEMPLOYEE")
        '    arrUserFriendlyColumnNameInbox(1) = MyBase.GetResourceString("COL_MESSAGEDATE")
        '    arrUserFriendlyColumnNameInbox(2) = MyBase.GetResourceString("COL_SUBJECT")
        '    arrUserFriendlyColumnNameInbox(3) = MyBase.GetResourceString("COL_DELTE")


        '    objDSMessages = CommonFunction.Data.GetDataSet("usp_SEL_Tbl_MSG_Message_Inbox " + m_intUserID.ToString(), "Messages", , , MyBase.UseSQL)
        'Else

        '    arrActualColumnNameInbox(0) = "ToEmployee"
        '    arrActualColumnNameInbox(1) = "MessageDate"
        '    arrActualColumnNameInbox(2) = "Subject"
        '    arrActualColumnNameInbox(3) = '

        '    arrUserFriendlyColumnNameInbox(0) = MyBase.GetResourceString("COL_TOEMPLOYEE")
        '    arrUserFriendlyColumnNameInbox(1) = MyBase.GetResourceString("COL_MESSAGEDATE")
        '    arrUserFriendlyColumnNameInbox(2) = MyBase.GetResourceString("COL_SUBJECT")
        '    arrUserFriendlyColumnNameInbox(3) = MyBase.GetResourceString("COL_DELTE")

        '    objDSMessages = CommonFunction.Data.GetDataSet("usp_SEL_Tbl_MSG_Messages_Send " + m_intUserID.ToString(), "Messages", , , MyBase.UseSQL)
        'End If

        'sbHeaderHtml.Append("<table id='HeaderTable' WIDTH=99.9% CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableHeader' >")
        'sbHeaderHtml.Append("<tr>")
        ''sbHtml.Append("<td WIDTH='14' > <img SRC='../../Images/cssImages/TopLeftCorner.bmp' BORDER='0'  width='14' height='14'> </td>")
        'sbHeaderHtml.Append("<td WIDTH='14' class='clsTDTopLeftCorner'>  </td>")
        ''sbHtml.Append("<td WIDTH='372' rowspan='2' valign='middle' align='Left'><b>" & strGroupName & "</b></td>")
        ''''''sbHtml.Append("<td WIDTH=" & (intTableWidth - 28).ToString & " rowspan='2' valign='middle'> ")
        'sbHeaderHtml.Append("<td  rowspan='2' valign='middle'> ")

        '''''''sbHtml.Append("<table WIDTH=" & (intTableWidth - 28).ToString & " Class='clsRoundedTableHeader' ><tr><td align='Left'><b>" & strGroupName & "</b></td>")
        'sbHeaderHtml.Append("<table WIDTH=100% Class='clsRoundedTableHeader' ><tr><td WIDTH=25% align='Left'><b>")
        'sbHeaderHtml.Append(MyBase.GetResourceString("CAP_MY_MESSAGES"))
        'sbHeaderHtml.Append("</b></td>")
        ''sbHTML.Append("<td align=right><a  style='border-color:blue; text-decoration: none;' HREF='Javascript:ShowHideGroup_Onclick(" & intGroupID.ToString & ")'><img style='border-color:blue; text-decoration: none;' id='imgGroup" & intGroupID.ToString & "'  SRC='../../Images/MoveUp.GIF' BORDER='0' ALT=' Show/Hide " & strGroupName & '" onmouseover=' this.border=1; ' onmousedown=' this.border=2 ' onmouseout=' this.border=0; '  width='16' height='16'></a></td></tr></table>")
        ''sbHTML.Append("</tr></table>")
        ''sbHTML.Append("</td>")
        ''sbHtml.Append("<td WIDTH='14' ><img SRC='../../Images/cssImages/TopRightCorner.bmp' BORDER='0' width='14' height='14'></td>")

        ''sbHTML.Append("</table>")

        ''sbHeaderHtml.Append("<table id='tblMyMessages' class='clsTableNavLinks' cellpadding='0' cellspacing='0' style='width:99.99%;border-color:black;border-width:1px;border-style:Solid'>")
        ''sbHeaderHtml.Append("<tr class='clsTrColumnHeader' >") 'clsTRPageCaption
        ''sbHeaderHtml.Append("<td ><b>")
        ''sbHeaderHtml.Append(MyBase.GetResourceString("CAP_MY_MESSAGES"))
        ''sbHeaderHtml.Append("</b></td>")
        ''sbHeaderHtml.Append("<td style='text-align:left;vertical-align:middle'>")
        ''' ''sbHeaderHtml.Append("&nbsp;<a id='lnkInbox' class='clsSelected' title='Inbox' href='#' onclick='javascript:ShowMessage(")
        ''' ''sbHeaderHtml.Append(m_intUserID)
        ''' ''sbHeaderHtml.Append(",")
        ''' ''sbHeaderHtml.Append(MessageType.INBOX)
        ''' ''sbHeaderHtml.Append(")' >")
        ''' ''sbHeaderHtml.Append(MyBase.GetResourceString("CAP_INBOX"))
        ''' ''sbHeaderHtml.Append("</a>")
        ''' ''sbHeaderHtml.Append("&nbsp;|&nbsp;")
        ''' ''sbHeaderHtml.Append("<a id='lnkSent' class='clsSelected' title='Sent' href='#' onclick='javascript:ShowMessage(")
        ''' ''sbHeaderHtml.Append(m_intUserID)
        ''' ''sbHeaderHtml.Append(",")
        ''' ''sbHeaderHtml.Append(MessageType.SENT)
        ''' ''sbHeaderHtml.Append(")' >")
        ''' ''sbHeaderHtml.Append(MyBase.GetResourceString("CAP_SENT"))
        ''' ''sbHeaderHtml.Append("</a>")
        ''' ''sbHeaderHtml.Append("&nbsp;|&nbsp;")
        ''' ''sbHeaderHtml.Append("<a id='lnkCompose' class='clsSelected' title='Compose' href='#' onclick='javascript:ShowCompose(")
        ''' ''sbHeaderHtml.Append(m_intUserID)
        ''' ''sbHeaderHtml.Append(")' >")
        ''' ''sbHeaderHtml.Append(MyBase.GetResourceString("CAP_COMPOSE"))
        ''' ''sbHeaderHtml.Append("</a>")
        ''' ''sbHeaderHtml.Append("&nbsp;|&nbsp;")

        ''sbHeaderHtml.Append("</td>")
        'sbHeaderHtml.Append("<td style='text-align:right;vertical-align:center;width:75%'>")

        'sbHeaderHtml.Append("<a id='lnkDelete' class='clsSelected' alt='Delete' href='#' onclick='javascript:DeleteOnClick(")
        'sbHeaderHtml.Append(m_intUserID)
        'sbHeaderHtml.Append(")' >")
        'sbHeaderHtml.Append(MyBase.GetResourceString("CAP_DELETE"))
        'sbHeaderHtml.Append("</a>")
        'sbHeaderHtml.Append("&nbsp;|&nbsp;")


        'sbHeaderHtml.Append("<img src='../../Images/NavFirstEnable.gif' alt'First Record' onclick='javascript:ShowFirstPage()'>")
        'sbHeaderHtml.Append("<img src='../../Images/NavPreviousEnable.gif' alt'Previous Record' onclick='javascript:ShowPreviousPage()'>")
        'sbHeaderHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 25, 5, m_PageNumber, "right", , , , , , "onkeypress='javascript:txtPageNumber_KeyPress(event)'", True))
        'sbHeaderHtml.Append("<img src='../../Images/NavNextEnable.gif' alt'Next Record' onclick='Javascript:ShowNextPage()'>")
        'sbHeaderHtml.Append("<img src='../../Images/NavLastEnable.gif' alt'Last Record' onclick='Javascript:ShowLastPage()'>")
        'sbHeaderHtml.Append(" of ")

        'If objDSMessages.Tables(0).Rows.Count Mod m_PageSize <> 0 Then
        '    NoOfPages = Math.Floor(objDSMessages.Tables(0).Rows.Count / m_PageSize) + 1
        'Else
        '    NoOfPages = Math.Floor(objDSMessages.Tables(0).Rows.Count / m_PageSize)
        'End If
        'sbHeaderHtml.Append(NoOfPages.ToString())
        'sbHeaderHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtMessageType", "txtMessageType", , , , m_MessageType, , , , , , , , True, , , , True))
        'sbHeaderHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , NoOfPages.ToString(), , , , , , , , True, , , , True))
        'sbHeaderHtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtmesageaction", "txtmesageaction", , , , ', , , , , , , , True, , , , True))
        'sbHeaderHtml.Append("</td>")
        'sbHeaderHtml.Append("</tr></table>")
        'sbHeaderHtml.Append("</td>")

        'sbHeaderHtml.Append("<td WIDTH='14' class='clsTDTopRightCorner'>  </td>")
        'sbHeaderHtml.Append("</tr>")
        'sbHeaderHtml.Append("<tr>")
        'sbHeaderHtml.Append("<td>&nbsp;&nbsp;</td>")
        'sbHeaderHtml.Append("<td>&nbsp;&nbsp;</td>")
        ''sbHTML.Append("<td>&nbsp;&nbsp;</td>")
        'sbHeaderHtml.Append("</tr>")

        'sbHeaderHtml.Append("</tr></table>")


        'With objInboxGrid
        '    .HeaderHTML = sbHeaderHtml.ToString()
        '    .ActualColumnArray = arrActualColumnNameInbox
        '    .UserFriendlyColumnArray = arrUserFriendlyColumnNameInbox
        '    .RowLinkArray = arrRowLinkInbox
        '    .TDStyleArray = arrTdStyleInbox
        '    .CheckBoxIDArray = arrCheckboxArray
        '    .PageSize = 5
        '    .PrimaryKey = "MessageID"
        '    '.SQL = "usp_SEL_Tbl_MSG_Message_Inbox " + m_intUserID
        '    .GridDataTable = objDSMessages.Tables(0)
        '    .UseSQL = MyBase.UseSQL
        '    .NoOfDataColumns = 3
        '    '.EditLinkName = "InboxOnClick"
        '    .returnHTML = True
        '    .EmptyValueReplacement = "-"
        '    .DIVHeight = 210
        '    .DIVID = "DivInobx"
        '    '.DIVStyle = "border-color:black;border-width:1px;border-style:Solid;overflow:auto"
        '    .DIVStyle = "border-right: #BED5F5 1px outset;border-left: #BED5F5 1px outset;border-bottom: #BED5F5 1px outset;overflow:auto"
        '    .FormID = "frmHomePage"
        '    .CurrentPage = m_PageNumber
        '    sbHTML.Append(.DrawGrid())

        'End With


        'objInboxGrid = Nothing

        'If IsNothing(objDSMessages) = False Then
        '    objDSMessages.Dispose()
        'End If


    End Sub
    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================
        Dim sbHtml As New System.Text.StringBuilder
        Dim sbHtmlLeft As New System.Text.StringBuilder
        Dim sbHtmlRight As New System.Text.StringBuilder
        Dim strTempString As String
        Dim intMenuGroupCount As Integer = 0
        Dim strSQL As String
        Dim drAccessibleMenuTabs As IDataReader
        Dim sbtxtHtml As New System.Text.StringBuilder
        Dim intcontrolItemID As Integer

        If Not Request.Form("chkDeleteRemind") Is Nothing Then
            DeleteMyReminders()
        End If


        strSQL = " Usp_Sel_tbl_UI_ControlMenuGroup_User " & m_intUserID.ToString

        If m_strModuleShortName <> "" Then
            strSQL += ",'" + m_strModuleShortName + "'"
        Else
            strSQL += ",NULL"
        End If

        strSQL += ",'" & HttpContext.Current.Session("LoginType") & "'"

        drAccessibleMenuTabs = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'sbHtml.Append("<TABLE valign='top' id='tblSearch'  cellspacing='0' cellpadding='0' Width='99.9%'  class='clsTable'>")

        'sbHtml.Append("<TR class='clsTRMenu'>")
        'sbHtml.Append("<TD align='Right'><A href='JavaScript:Configure_Section()' style='TEXT-DECORATION:none'><img src= '../../Images/DetailView/78.gif' border='0' alt='Configure Sections'></A>")
        'sbHtml.Append("</TD></TR></Table>")
        'CommonFunction.General.WriteHTML(sbHtml.ToString)
        'sbHtml.Remove(0, sbHtml.Length())

        ''''''''sbHtml.Append(PlotSearchControl())
        sbHtml.Append("<br>")

        sbHtml.Append("<div ID='PageDiv' height='100%' style='overflow:auto;width:99.9%;'>")
        '''''''''sbHtml.Append("<div ID='DivFav' style='overflow:auto;width:99.9%;'>")
        '''''''''sbHtml.Append(PlotFavourites("My Favourites", 10, 0, False, 1, 800))
        '''''''''sbHtml.Append("</div>")

        sbHtml.Append("<table CELLPADDING='0' CELLSPACING='0' BORDER='0' Width='100%' >")
        sbHtml.Append("<TR>")

        sbHtmlLeft.Append("<TD id='LeftTD' align='left' valign='top' WIDTH='50%'>")
        sbHtmlRight.Append("<TD id='RightTD' align='right' valign='top' WIDTH='50%'>")

        While (drAccessibleMenuTabs.Read())
            'If (intMenuGroupCount Mod 2) = 0 Then
            'Modified by ArchanaN for Parameters TagID and MaxControlLimit
            'Modified by SujitG on 13 Oct 2008 for adding parameter Show Marquee section
            If (drAccessibleMenuTabs("IsApplicable")) Then
                'strTempString = PlotControlMenuTab(drAccessibleMenuTabs("MenuGroup"), drAccessibleMenuTabs("MaxControlLimit"), drAccessibleMenuTabs("MenuGroupID"), drAccessibleMenuTabs("ShowMarqueeSection"), 1, 430)
                If m_intLeftRows <= m_intRightRows Then
                    sbHtmlLeft.Append(PlotControlMenuTab(drAccessibleMenuTabs("MenuGroup"), drAccessibleMenuTabs("MaxControlLimit"), drAccessibleMenuTabs("MenuGroupID"), drAccessibleMenuTabs("ShowMarqueeSection"), 1, 430))
                Else
                    sbHtmlRight.Append(PlotControlMenuTab(drAccessibleMenuTabs("MenuGroup"), drAccessibleMenuTabs("MaxControlLimit"), drAccessibleMenuTabs("MenuGroupID"), drAccessibleMenuTabs("ShowMarqueeSection"), 2, 430))
                End If
            End If
        End While
        CommonFunction.Data.DisposeDataReader(drAccessibleMenuTabs)
        sbHtmlLeft.Append("</TD>")
        sbHtmlRight.Append("</TD>")

        sbHtml.Append(sbHtmlLeft.ToString)
        sbHtml.Append("<td WIDTH='2%' align='center'>&nbsp;</td>")
        sbHtml.Append(sbHtmlRight.ToString)
        sbHtml.Append("</tr></table>")
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing
    End Sub
    'Added By PiyushB on 17 Sep 2008
    'Purpose : To add reminders in Normal View
    Private Sub DeleteMyReminders()
        Dim Iterator As Integer = 0
        Dim arrUniqueID() As String = Request.Form("chkDeleteRemind").Split(",")
        While Iterator < arrUniqueID.Length
            CommonFunction.Data.InsertOrUpdateData("usp_Del_tbl_PM_FlagForTracking_MyReminders " + arrUniqueID(Iterator), MyBase.UseSQL)
            Iterator += 1
        End While

    End Sub

    Private Sub DrawMyReminders(ByVal strGadgetTitle As String, ByRef sbHtml As StringBuilder)
        Dim strSQL As String = "usp_Sel_tbl_PM_FlagForTracking_MyReminders " + m_intUserID.ToString()
        Dim strCssClass As String = "clsTREven"
        Dim dr As IDataReader
        Dim loopCount As Integer = 0
        ' sbHtml.Append("<table id='tblReminders' class='clsGridTable' cellspacing='1' cellpadding='0' style='width:99.99%;height:200px;border-color:black;border-width:1px;border-style:Solid'>")

        'sbHtml.Append("<table id='shwReminders' class='clsGridTable' cellspacing='1' cellpadding='0' style='width:20%;border-color:black;border-width:1px;overflow: auto;border-style:Solid'>")
        'sbHtml.Append("<tr class='clsTrColumnHeader'>")
        'sbHtml.Append("<td  style='TEXT-DECORATION:NONE;text-align:left;vertical-align:middle'><b>")
        'sbHtml.Append("My Reminders")
        'sbHtml.Append("</b></td>")
        'sbHtml.Append("<td  style='TEXT-DECORATION:NONE;text-align:left;vertical-align:middle'><b>")
        'sbHtml.Append("News and Events")
        'sbHtml.Append("</b></td>")
        'sbHtml.Append("</tr>")
        'sbHtml.Append("</table>")
        ' ''If m_strShowDisplay = "2" Then
        ' ''    sbHtml.Append("<div ID='MyreminderDiv' style='overflow:auto;width:99.99%;height:200px;display:none'>")
        ' ''Else
        ' ''    sbHtml.Append("<div ID='MyreminderDiv' style='overflow:auto;width:99.99%;height:200px;'>")
        ' ''End If

        'border-color:black;border-width:1px;border-style:Solid;overflow:auto


        sbHtml.Append("<table id='HeaderTable' WIDTH=100% CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableHeader' >")
        sbHtml.Append("<tr>")
        'sbHtml.Append("<td WIDTH='14' > <img SRC='../../Images/cssImages/TopLeftCorner.bmp' BORDER='0'  width='14' height='14'> </td>")
        sbHtml.Append("<td WIDTH='14' class='clsTDTopLeftCorner'>  </td>")
        'sbHtml.Append("<td WIDTH='372' rowspan='2' valign='middle' align='Left'><b>" & strGroupName & "</b></td>")
        '''''sbHtml.Append("<td WIDTH=" & (intTableWidth - 28).ToString & " rowspan='2' valign='middle'> ")
        sbHtml.Append("<td  rowspan='2' valign='middle'> ")

        ''''''sbHtml.Append("<table WIDTH=" & (intTableWidth - 28).ToString & " Class='clsRoundedTableHeader' ><tr><td align='Left'><b>" & strGroupName & "</b></td>")
        sbHtml.Append("<table WIDTH=100% Class='clsRoundedTableHeader' ><tr><td align='Left'><b>My Reminders </b></td>")
        'sbHTML.Append("<td align=right><a  style='border-color:blue; text-decoration: none;' HREF='Javascript:ShowHideGroup_Onclick(" & intGroupID.ToString & ")'><img style='border-color:blue; text-decoration: none;' id='imgGroup" & intGroupID.ToString & "'  SRC='../../Images/MoveUp.GIF' BORDER='0' ALT=' Show/Hide " & strGroupName & '" onmouseover=' this.border=1; ' onmousedown=' this.border=2 ' onmouseout=' this.border=0; '  width='16' height='16'></a></td></tr></table>")
        'sbHtml.Append("</tr></table>")
        'sbHtml.Append("</td>")

        sbHtml.Append("<td style='TEXT-DECORATION:NONE;text-align:left;vertical-align:middle;'>")
        sbHtml.Append("<a id='lnkAddRemind' class='clsSelected' title='Add Reminders' href='javascript:AddReminders(")
        sbHtml.Append(m_intUserID.ToString())
        sbHtml.Append(")' >")

        sbHtml.Append("Add")
        sbHtml.Append("</a>")
        sbHtml.Append("&nbsp;|&nbsp;")
        sbHtml.Append("<a id='lnkDeleteRemind' class='clsSelected' title='Delete Reminders' href='javascript:DeleteReminders()' >")
        sbHtml.Append("Delete")
        sbHtml.Append("</a>")

        '' ''sbHtml.Append("&nbsp;|&nbsp;")
        '' ''sbHtml.Append("<a id='lnkShowCalendar' class='clsSelected' title='Show Calendar' href='javascript:ShowCalendar()' >")
        '' ''sbHtml.Append("Calendar")
        '' ''sbHtml.Append("</a>")

        sbHtml.Append("</td>")
        sbHtml.Append("</tr></table>")
        sbHtml.Append("</td>")
        'sbHtml.Append("<td WIDTH='14' ><img SRC='../../Images/cssImages/TopRightCorner.bmp' BORDER='0' width='14' height='14'></td>")
        sbHtml.Append("<td WIDTH='14' class='clsTDTopRightCorner'>  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")

        sbHtml.Append("<div ID='MyreminderDiv' width:100% style='border-right: #BED5F5 1px outset;border-left: #BED5F5 1px outset;border-bottom: #BED5F5 1px outset;overflow:auto;width:100%;height:210px;'>")
        sbHtml.Append("<table id='tblReminders' class='clsGridTable' cellspacing='1' cellpadding='0' style='width:100%' >")
        '''style='width:99.99%;border-color:black;border-width:1px;overflow: auto;border-style:Solid'

        'sbHtml.Append("<tr class='clsTrColumnHeader'>")
        'sbHtml.Append("<td  style='width:15%;TEXT-DECORATION:NONE;text-align:left;vertical-align:middle'><b>")
        'sbHtml.Append("My Reminders")
        'sbHtml.Append("</b></td>")
        'sbHtml.Append("<td  style='width:15%;TEXT-DECORATION:NONE;text-align:left;vertical-align:middle'><b>")
        'sbHtml.Append("News and Events")
        'sbHtml.Append("</b></td>")
        'sbHtml.Append("<td  style='width:70%;TEXT-DECORATION:NONE;text-align:left;vertical-align:middle'>")
        'sbHtml.Append(')
        'sbHtml.Append("</td>")
        'sbHtml.Append("</tR>")
        ' ''sbHtml.Append("<tr class='clsTrColumnHeader'>")


        ' ''sbHtml.Append("<td colspan=3 style='TEXT-DECORATION:NONE;text-align:left;vertical-align:middle;'><b>")
        ' ''sbHtml.Append("My Reminders")
        ' ''sbHtml.Append("</b>")

        ' ''sbHtml.Append("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a id='lnkAddRemind' class='clsSelected' title='Add Reminders' href='javascript:AddReminders(")
        ' ''sbHtml.Append(m_intUserID.ToString())
        ' ''sbHtml.Append(")' >")

        ' ''sbHtml.Append("Add")
        ' ''sbHtml.Append("</a>")
        ' ''sbHtml.Append("&nbsp;|&nbsp;")
        ' ''sbHtml.Append("<a id='lnkDeleteRemind' class='clsSelected' title='Delete Reminders' href='javascript:DeleteReminders()' >")
        ' ''sbHtml.Append("Delete")
        ' ''sbHtml.Append("</a>")

        ' '' '' ''sbHtml.Append("&nbsp;|&nbsp;")
        ' '' '' ''sbHtml.Append("<a id='lnkShowCalendar' class='clsSelected' title='Show Calendar' href='javascript:ShowCalendar()' >")
        ' '' '' ''sbHtml.Append("Calendar")
        ' '' '' ''sbHtml.Append("</a>")

        ' ''sbHtml.Append("</td>")
        ' ''sbHtml.Append("</tr>")

        'Table of Reminders
        sbHtml.Append("<tr class='clsTrColumnHeader'>")
        sbHtml.Append("<td>")
        sbHtml.Append("<b>Reminder</b>")
        sbHtml.Append("</td>")
        sbHtml.Append("<td>")
        sbHtml.Append("<b>Due Date</b>")
        sbHtml.Append("</td>")
        sbHtml.Append("<td align='center'>")
        sbHtml.Append("<b>Delete</b>")
        sbHtml.Append("</td>")
        sbHtml.Append("</tr>")
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        While dr.Read
            loopCount = loopCount + 1
            If strCssClass = "clsTREven" Then
                strCssClass = "clsTROdd"
            Else
                strCssClass = "clsTREven"
            End If
            sbHtml.Append("<tr class='" + strCssClass + "'>")
            sbHtml.Append("<td>")
            sbHtml.Append(dr("Comments").ToString)
            sbHtml.Append("</td>")
            sbHtml.Append("<td>")
            sbHtml.Append(CommonFunction.Dates.CGetDate(CType(dr("DueDate"), Date)))
            sbHtml.Append("</td>")
            sbHtml.Append("<td align='center'>")
            sbHtml.Append("<input type=checkbox   name=chkDeleteRemind id=chkDeleteRemind value=" + dr("UniqueID").ToString + ">")
            sbHtml.Append("</td>")

            sbHtml.Append("</tr>")

        End While
        If loopCount = 0 Then
            sbHtml.Append("<tr class='clsTREvenRow'>")
            sbHtml.Append("<td colspan=3 style='TEXT-DECORATION:NONE;text-align:center;'>")
            sbHtml.Append("There are no items to show in this view")
            sbHtml.Append("</td>")
            sbHtml.Append("</tr>")
        End If
        sbHtml.Append("</table>")
        sbHtml.Append("</div></br> ")
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Private Function PlotControlMenuTab(ByVal strGroupName As String, ByVal MaxControlLimit As Integer, ByVal intGroupID As Integer, ByVal blnShowMarqueeSection As Boolean, Optional ByVal intPanel As Integer = 1, Optional ByVal intTableWidth As Integer = 400) As String

        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim drMenu As IDataReader
        Dim strMenuGroupDescription As String = ""
        Dim strPageURL As String = ""
        Dim strImagePath As String = ""
        Dim strToolTip As String = ""
        Dim strItemDescription As String = ""
        Dim strControlItem As String = ""
        Dim intMenuCount As Integer = 0
        Dim strControlItemCount As String = "0"
        Dim intMidPointofRecords As Integer = 0
        Dim strGroupingOn As String = ""
        Dim strPreviousGroupingName As String = ""
        Dim intPageWidth, intPageHeight As Integer
        Dim strToBeInsertedInDynamicFunction As String = ""
        Dim strControlItemID As String = ""
        Dim intRowCount As Integer = 0
        Dim Cancel As Boolean = False
        'Added By KapilGK on 6-Aug-2008 for Role access
        Dim strTagID As String = ""
        Dim intControlMenuItemCount As Integer = 0
        Dim objAccess As New WebPage.Templates.AccessRights
        Dim objGlobal As WebPages.Template.IGlobal  'If using Whiz 2 then use objGlobal As New WebPages.Template.Global
        'End of addition By KapilGK on 6-Aug-2008 for Role access
        Dim strInsertAfterControlItem As String = ""
        'Added By PiyushB on 18-Aug-2008
        'Purpose : To create event handler page for HRHome
        Dim strSystemControlItem As String = ""
        Dim objHRHome_Event As HRHome_Event
        Dim objMenuItem As Menuitem_Home
        'End of Addition By PiyushB on 18-Aug-2008

        'Added By SujitG on 05 Sep 2008
        'Purpose : To show update link HTML
        'Dim blnShowLastUpdateRecord As Boolean
        'Dim intlastUpdationType As Integer = 0
        Dim strLastUpdationHTML As String = ""
        Dim strlastUpdateValueQuery As String = ""
        Dim strPlaceholder As String = ""
        Dim strLastUpdationSP As String = ""
        Dim intPlaceHolderCount As Integer = 0
        Dim drReplacePlaceHolder As IDataReader
        Dim intCount As Integer = 0
        Dim strPrimaryKeySQL As String = ""
        Dim intPrimaryKeyValue As String = ""
        Dim strPKToken As String = ""
        Dim strCountHTML As String = ""
        Dim strControlMenuItemID As String = "0"
        'Dim Accessset As Access
        'End of Addition By SujitG on 05 Sep 2008

        strSQL = "Usp_Sel_tbl_UI_ControlMenuItem " & intGroupID.ToString & ",1,N'" & CommonFunctions.General.BuildQueryString(m_strSearchText) & "'," & CommonFunction.General.CheckIsNothing(Session("intUserID"), "0")
        drMenu = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHtml.Append("<table id='HeaderTable' width='100%'  CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableHeader' >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH='14' class='clsTDTopLeftCorner'>  </td>")
        sbHtml.Append("<td  rowspan='2' valign='middle'> ")

        sbHtml.Append("<table WIDTH='100%'  Class='clsRoundedTableHeader' ><tr><td align='Left'><b>" & strGroupName & "</b></td>")
        sbHtml.Append("<td align='right'><a  style='border-color:blue; text-decoration: none;' HREF='Javascript:ShowHideGroup_Onclick(" & intGroupID.ToString & ")'><img style='border-color:blue; text-decoration: none;' id='imgGroup" & intGroupID.ToString & "'  SRC='../../Images/Home/MoveUp.GIF' BORDER='0' ALT=' Show/Hide " & strGroupName & "' onmouseover=' this.border=1;' onmousedown='this.border=2' onmouseout=' this.border=0; '  width='16' height='16'></a></td></tr></table>")
        sbHtml.Append("</td>")
        sbHtml.Append("<td WIDTH='14' class='clsTDTopRightCorner'>  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")
        sbHtml.Append("<table  id='tblGroup" & intGroupID.ToString & "' WIDTH='100%' CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableMenu'>")
        objHRHome_Event = New HRHome_Event
        objMenuItem = New Menuitem_Home

        While (drMenu.Read())
            strCountHTML = ""
            Cancel = False
            intRowCount = intRowCount + 1
            'Added by SujitG on 05 Sep 2008
            objMenuItem.UpdateLinkHTML = ""
            intPlaceHolderCount = 0
            strPrimaryKeySQL = ""
            strLastUpdationHTML = ""
            'End of addition by SujitG on 05 Sep 2008
            strControlMenuItemID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("FavControlItemID"), "0"), "0")
            objMenuItem.ControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ControlItem")), "")
            objMenuItem.SystemControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("SystemControlItem")), "")
            objMenuItem.ItemDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ItemDescription")), "")
            objMenuItem.PageURL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("PageURL")), "")
            objMenuItem.ImageName = "../../Images/DetailView/" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ImageName")), "")
            objMenuItem.ToolTip = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ToolTip")), "")
            objMenuItem.GroupingOn = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("GroupingOn")), "")
            objMenuItem.PageWidth = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("PageWidth"), "0"), ""))
            objMenuItem.PageHeight = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("PageHeight"), "0"), ""))
            objMenuItem.ToBeInsertedInDynamicFunction = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ToBeInsertedInDynamicFunction")), "")

            objMenuItem.ControlItemID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ControlItemID")), "")
            objMenuItem.InsertAfterControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("InsertAfterControlItem")), "")

            'Added by SujitG on 09 Sep 2008 
            objMenuItem.ShowLastUpdated = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ShowLastUpdated")), "0"))
            objMenuItem.LastUpdationType = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdationType")), "0"))
            objMenuItem.LastUpdatePrimaryKeySQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdatePrimaryKeySQL")), "")
            objMenuItem.LastUpdateHTML = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdateHTML")), "")
            objMenuItem.LastUpdateValueQuery = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdateValueQuery")), "")
            objMenuItem.countSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("CountSQL")), "")
            'End of addition by SujitG on 09 Sep 2008
            If objMenuItem.LastUpdatePrimaryKeySQL <> "" Then
                objMenuItem.LastUpdatePrimaryKeySQL = HRCommonfunction.ReplacePlaceHolders(objMenuItem.LastUpdatePrimaryKeySQL)
                objMenuItem.PrimaryKeyValue = CInt(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(objMenuItem.LastUpdatePrimaryKeySQL, True), "0"))
            End If

            'Added by SujitG on 05 Sep 2008 
            If objMenuItem.ShowLastUpdated = True Then
                objMenuItem.LastUpdateHTML = Draw_LastUpdateLink(objMenuItem)
            End If
            'End of addition by SujitG on 05 Sep 2008

            'Added by SujitG on 09 Sep 2008
            objHRHome_Event.Before_LastUpdateLinkPrint(objMenuItem, Cancel)
            'End of addition by SujitG on 09 Sep 2008
            Call Replace_PKToken(objMenuItem)

            'Added By SandipL
            objGlobal = New WebPages.Template.WhizGlobal

            'Added By KapilGK on 6-Aug-2008 for Role access
            objGlobal.LCID = MyBase.CurrentThreadUICultureID
            objMenuItem.ApplyTagSecurity = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ApplyTagSecurity"), True), True)
            objMenuItem.TagID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("TagID"), "0"), "")
            'Added By PiyushB on 18-Aug-2208

            objHRHome_Event.BeforeControlMenuPlot(objMenuItem, Cancel)
            'End of Addition By PiyushB on 18-Aug-2008

            objGlobal.UseHashTable = True
            objGlobal.TagID = CType(objMenuItem.TagID, Long)
            objGlobal.UserID = CType(HttpContext.Current.Session("intUserID"), Long)
            objGlobal.RoleID = CType(HttpContext.Current.Session("intPostID"), Long)
            objGlobal.ParentTagID = 0
            objGlobal.ProjectID = Nothing
            objGlobal.LoginType = HttpContext.Current.Session("LoginType")
            If objMenuItem.ApplyTagSecurity Then
                objAccess.GetAccess(objGlobal)
                'Accessset = GetAccess1(objGlobal, objGlobal.TagID, True)
            End If
            If objMenuItem.ApplyTagSecurity = False Or objAccess.Access Then

                sbHtml.Append("<tr class='clsTRControlMenu'>")
                sbHtml.Append("<td valign='top' width='35'>")

                If objMenuItem.ToBeInsertedInDynamicFunction = "" Then
                    sbHtml.Append("<a style=' border-color:blue; text-decoration: none;' HREF='Javascript:OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")'>")
                Else
                    sbHtml.Append("<a style='border-color:blue; text-decoration: none;' HREF='Javascript:Function_Onclick_" + objMenuItem.ControlItemID + "()'>")
                    sbHtml.Append("<script>function Function_Onclick_" + objMenuItem.ControlItemID + "(){" + vbCrLf)
                    sbHtml.Append(objMenuItem.ToBeInsertedInDynamicFunction + vbCrLf)
                    sbHtml.Append(" OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")")
                    sbHtml.Append("}</script>")
                End If

                'sbHtml.Append("<img src='" + strImagePath + "' alt='" + strToolTip + "' width=35 height=35 vspace=1 border=0></a></td>")
                sbHtml.Append("<img style='border-color:blue; text-decoration: none;' src='" + objMenuItem.ImageName + "' alt='" + objMenuItem.ToolTip + "' vspace=1 border=0 onmouseover=' this.border=1 ' onmousedown=' this.border=2 ' onmouseout=' this.border=0 '></a></td>")
                sbHtml.Append("<td valign='top'>")

                sbHtml.Append("<table width='100%' >")
                sbHtml.Append("<tr><td valign='top'>")

                If objMenuItem.ToBeInsertedInDynamicFunction = "" Then
                    sbHtml.Append("<a class='clsControlMenuLink' HREF='Javascript:OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")'>")
                Else
                    sbHtml.Append("<a class='clsControlMenuLink' HREF='Javascript:Function_Onclick_" + objMenuItem.ControlItemID + "()'>")
                    sbHtml.Append("<script>function Function_Onclick_" + objMenuItem.ControlItemID + "(){" + vbCrLf)
                    sbHtml.Append(objMenuItem.ToBeInsertedInDynamicFunction + vbCrLf)
                    sbHtml.Append(" OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + "," + strControlMenuItemID.ToString + "," + objMenuItem.TagID.ToString + ")")
                    sbHtml.Append("}</script>")
                End If
                'sbHtml.Append("<font face='Verdana, Arial'; size='-12' color='blue'>")
                sbHtml.Append(objMenuItem.ControlItem)
                'sbHtml.Append("</font>")
                sbHtml.Append("</a>")

                If objMenuItem.countSQL <> "" Then
                    Try
                        objMenuItem.countSQL = HRCommonfunction.ReplacePlaceHolders(objMenuItem.countSQL)
                        strCountHTML = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(objMenuItem.countSQL, True), "")
                    Catch ex As Exception
                        strCountHTML = ""
                    End Try
                End If
                If strCountHTML <> "" Then
                    'sbHtml.Append("<font face='Verdana, Arial'; color='red' size='-2'>")
                    sbHtml.Append(strCountHTML)
                    'sbHtml.Append("</font>")
                End If

                sbHtml.Append("</td><td valign='top' align='right'>")
                If objMenuItem.InsertAfterControlItem <> "" Then
                    objMenuItem.InsertAfterControlItem = HRCommonfunction.ReplacePlaceHolders(objMenuItem.InsertAfterControlItem)
                    sbHtml.Append(objMenuItem.InsertAfterControlItem)
                End If
                sbHtml.Append("</td></tr></table>")

                'sbHtml.Append("<br>")

                'Added by SujitG on 05 Sep 2008
                If objMenuItem.UpdateLinkHTML <> "" Then
                    'sbHtml.Append("<font face='Verdana, Arial'; size='-12' color='Indigo'>")
                    sbHtml.Append(objMenuItem.UpdateLinkHTML)
                    sbHtml.Append("</font>")
                    'sbHtml.Append("<br>")
                End If
                'End of addition by SujitG on 05 Sep 2008
                'sbHtml.Append("<font fontFamily:'Verdana, Arial'; size='-1'>")
                sbHtml.Append(objMenuItem.ItemDescription)
                If strControlMenuItemID <> "0" And strControlMenuItemID <> "" Then
                    sbHtml.Append("</td><td valign='top' align='right'><img id='imgFav" + objMenuItem.ControlItemID.ToString + "' border=0 src='../../Images/Home/RemoveFavorite.gif' title='Remove from favourites' style='cursor:hand;' onclick='addRemoveFavorites(" + objMenuItem.ControlItemID.ToString + ",""D"")'>")
                Else
                    sbHtml.Append("</td><td valign='top' align='right'><img id='imgFav" + objMenuItem.ControlItemID.ToString + "' border=0 src='../../Images/Home/AddFavorite.gif' title='Add to favourites' style='cursor:hand;' onclick='addRemoveFavorites(" + objMenuItem.ControlItemID.ToString + ",""A"")'>")
                End If


                sbHtml.Append("</td>")
                sbHtml.Append("</tr>")

                'Added By KapilGK on 6-Aug-2008 for Role access
                intControlMenuItemCount += 1
            End If
            'If intControlMenuItemCount >= 5 Then
            If intControlMenuItemCount >= MaxControlLimit Then
                Exit While
            End If
            'End of addition By KapilGK on 6-Aug-2008 for Role access

            objGlobal = Nothing
        End While

        CommonFunction.Data.DisposeDataReader(drMenu)

        If intControlMenuItemCount = MaxControlLimit Then
            sbHtml.Append("<tr class='clsTRControlMenu'>")
            sbHtml.Append("<td align='right' colspan='3'>")
            sbHtml.Append("<a HREF='Javascript:ShowDetails_Onclick(" + intGroupID.ToString + ")'> <font color='blue'>more...</font>")
            sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
            sbHtml.Append("</tr>")
        End If
        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class='clsTDBottomLeftCorner'>  </td>")
        sbHtml.Append("<td width='" & (intTableWidth - 28).ToString & "' ></td>")
        sbHtml.Append("<td></td><td class='clsTDBottomRightCorner'></td>")
        sbHtml.Append("</tr>")

        sbHtml.Append("</table>")
        sbHtml.Append("<br>")

        If intControlMenuItemCount > 0 Then
            If intPanel = 1 Then
                m_intLeftRows += intControlMenuItemCount + 3
            Else
                m_intRightRows += intControlMenuItemCount + 3
            End If
        Else
            sbHtml.Remove(0, sbHtml.Length)
        End If
        Return sbHtml.ToString
    End Function

    Private Sub DrawHiddenControls()
        '=====================================================================
        ' Procedure Name        : DrawHiddenControls()
        ' Purpose               : To Draw Hidden Contrls
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : July 26, 2008
        ' Revisions             :
        '=====================================================================
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("ShowMarquee", "ShowMarquee", , , , m_intShowMarqueeSection.ToString, , , , , , True, , True, , , ))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("DisplayDiv", "DisplayDiv", , , , m_strShowDisplay, , , , , , True, , True, , , ))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtShortName", "txtShortName", , , , m_ShortName, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("ShowMarquee", "ShowMarquee", , , , m_intShowMarqueeSection.ToString, , , , , , True, , True, , , , EnableHTMLEncode:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("DisplayDiv", "DisplayDiv", , , , m_strShowDisplay, , , , , , True, , True, , , , EnableHTMLEncode:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtShortName", "txtShortName", , , , m_ShortName, , , , , , True, , True, EnableHTMLEncode:=True))
        ''END OF Commented and added by Nilesh g on 3/8/2016 for Html Encoding
    End Sub

    Private Function Draw_LastUpdateLink(ByVal objMenuItem) As String

        '=====================================================================
        ' Function Name        : Draw_LastUpdateLink()
        ' Purpose               : To Draw Last update Link
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SujitG
        ' Created               : Sep 09, 2008
        ' Revisions             :
        '=====================================================================
        Dim strLastUpdationHTML As String = ""
        Dim strlastUpdateValueQuery As String = ""
        Dim strPlaceholder As String = ""
        Dim strLastUpdationSP As String = ""
        Dim intPlaceHolderCount As Integer = 0
        Dim drReplacePlaceHolder As IDataReader
        Dim intCount As Integer = 0
        Dim strPrimaryKeySQL As String = ""
        Dim intPrimaryKeyValue As String = ""
        Dim strPKToken As String = ""

        strPrimaryKeySQL = objMenuItem.LastUpdatePrimaryKeySQL
        Try


            If objMenuItem.LastUpdationType = 1 Then
                strLastUpdationHTML = objMenuItem.LastUpdateHTML
                strlastUpdateValueQuery = objMenuItem.LastUpdateValueQuery
                strlastUpdateValueQuery = HRCommonfunction.ReplacePlaceHolders(strlastUpdateValueQuery)

                While strLastUpdationHTML.IndexOf("<PLACEHOLDER" + (intPlaceHolderCount + 1).ToString + ">") > 0
                    intPlaceHolderCount = intPlaceHolderCount + 1
                End While

                If intPlaceHolderCount > 0 Then
                    Dim arrPlaceholder(intPlaceHolderCount - 1)
                    drReplacePlaceHolder = CommonFunction.Data.GetDataReader(strlastUpdateValueQuery, True)
                    If drReplacePlaceHolder.Read() Then
                        For intCount = 0 To intPlaceHolderCount - 1
                            strLastUpdationHTML = strLastUpdationHTML.Replace("<PLACEHOLDER" + (intCount + 1).ToString + ">", CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drReplacePlaceHolder(intCount)), ""))
                        Next
                    End If
                    CommonFunction.Data.DisposeDataReader(drReplacePlaceHolder)
                End If

            ElseIf objMenuItem.LastUpdationType = 2 Then
                strLastUpdationSP = objMenuItem.LastUpdateHTML
                strLastUpdationSP = HRCommonfunction.ReplacePlaceHolders(strLastUpdationSP)
                strLastUpdationHTML = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strLastUpdationSP, True), ""), "")

            End If
        Catch ex As Exception
            strLastUpdationHTML = ""
        End Try
        Return strLastUpdationHTML
    End Function

    Private Function Replace_PKToken(ByVal objMenuItem) As String
        If objMenuItem.LastUpdationType = 1 Then 'CommonFunction.Constants.UpdateLink.HTML Then
            If objMenuItem.LastUpdateHTML.Contains("<PKToken>") Then
                objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(objMenuItem.PrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + objMenuItem.TagID.ToString + "0")
                objMenuItem.LastUpdateHTML = objMenuItem.LastUpdateHTML.Replace("<PKToken>", objMenuItem.PKToken)
            End If
        ElseIf objMenuItem.LastUpdationType = 2 Then 'CommonFunction.Constants.UpdateLink.STOREDPROCEDURE Then
            If objMenuItem.LastUpdateHTML.Contains("<PKToken>") Then
                objMenuItem.PKToken = CommonFunctions.Security.Token.GetToken(CType(objMenuItem.PrimaryKeyValue, String) + HttpContext.Current.Session("intUserID").ToString + objMenuItem.TagID.ToString + "0")
                objMenuItem.LastUpdateHTML = objMenuItem.LastUpdateHTML.Replace("<PKToken>", objMenuItem.PKToken)
            End If
        End If
        objMenuItem.UpdateLinkHTML = objMenuItem.LastUpdateHTML
    End Function
    Private Function PlotSearchControl() As String
        Dim sbHTML As New System.Text.StringBuilder

        sbHTML.Append("<table class='clsTable' cellspacing='0' cellpadding='0' style='width:99.9%;height:30px;border-color:black;border-width:1px;border-style:Solid'>")
        sbHTML.Append("<TR class='clsTREven' valign='middle'>")
        sbHTML.Append("<td align='center'>")
        sbHTML.Append("<img border='0' valign='bottom' align='absbottom' title='My Tasklist' style='cursor:hand;' src='../../Images/Home/Tasklist.gif'  onclick='MyTaskList_Click()'>&nbsp;")
        sbHTML.Append("<img border='0' valign='bottom' align='absbottom' title='Pending Approvals' style='cursor:hand;' src='../../Images/Home/Approvals.gif' onclick='Approval_Click()'>&nbsp;")
        sbHTML.Append("<img border='0' valign='bottom' align='absbottom' title='Last updated' style='cursor:hand;' src='../../Images/Home/LastUpdated.gif'  onclick='LastUpdated_Click()'>&nbsp;")
        sbHTML.Append("<img border='0' valign='bottom' align='absbottom' title='Last updated' style='cursor:hand;' src='../../Images/Home/55.gif'  onclick='CrossTab_Click()'>&nbsp;")
        sbHTML.Append("<td align='center' width='90%'>") ' <b>Search </b></td><td align=left>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 400, 200, value:=m_strSearchText, returnHTML:=True, ToBeInserted:="onkeypress='Search_OnKeyPress(event)' "))
        sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 400, 200, value:=m_strSearchText, returnHTML:=True, ToBeInserted:="onkeypress='Search_OnKeyPress(event)' ", EnableHTMLEncode:=True))

        sbHTML.Append(" <a href='Javascript:Search_OnClick()' >")
        sbHTML.Append("<img border='0' valign='bottom' align='absbottom' src='../../Images/Home/Search.gif' width='30' height='20' title='Search' onmouseover='this.src="" ../../Images/Home/Search.gif""' onmousedown='this.src="" ../../Images/Home/Search.gif""' onmouseout=' this.src="" ../../Images/Home/Search.gif""'></a>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right' width='10%'>")
        sbHTML.Append("<A align='right' href='JavaScript:Configure_Section()' style='TEXT-DECORATION:none'><img src= '../../Images/Home/settings.gif' border='0' alt='Configure Sections'></A>")
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</Table>")
        Return sbHTML.ToString

    End Function
    Public Sub AddRemoveFavourites(ByVal intControlItemID As Integer, ByVal strmode As String)

        Dim strHTML As New System.Text.StringBuilder
        'Dim dr As IDataReader

        CommonFunction.Data.InsertOrUpdateData("usp_INS_UPD_ControlMenuItem_Favorites " + intControlItemID.ToString + "," + Session("intUserID").ToString + ",'" + m_strMode.ToString + "','S'", True)

        'dr = CommonFunction.Data.GetDataReader("usp_SEL_ControlMenuItem_Favorites " + Session("intUserID").ToString, True)
        'strHTML.Append("<table CELLPADDING='0' CELLSPACING='0' BORDER='0' Width='100%' class='clsTable' >")
        'strHTML.Append("<TR class='clsTREven'>")
        'strHTML.Append("<TD align='left'>")
        'While dr.Read()
        '    strHTML.Append(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(dr("ControlItem"), ""), ""))
        'End While
        'strHTML.Append("</TD></TR></table>")
        'CommonFunction.Data.DisposeDataReader(dr)
        strHTML.Append(PlotFavourites("My Favourites", 10, 0, False, 1, 800))
        Response.Clear()
        Response.Write(strHTML.ToString)
        Response.End()
    End Sub
    Private Function PlotFavourites(ByVal strGroupName As String, ByVal MaxControlLimit As Integer, ByVal intGroupID As Integer, ByVal blnShowMarqueeSection As Boolean, Optional ByVal intPanel As Integer = 1, Optional ByVal intTableWidth As Integer = 400) As String

        Dim sbHtml As New System.Text.StringBuilder
        Dim strSQL As String
        Dim drMenu As IDataReader
        Dim strMenuGroupDescription As String = ""
        Dim strPageURL As String = ""
        Dim strImagePath As String = ""
        Dim strToolTip As String = ""
        Dim strItemDescription As String = ""
        Dim strControlItem As String = ""
        Dim intMenuCount As Integer = 0
        Dim strControlItemCount As String = "0"
        Dim intMidPointofRecords As Integer = 0
        Dim strGroupingOn As String = ""
        Dim strPreviousGroupingName As String = ""
        Dim intPageWidth, intPageHeight As Integer
        Dim strToBeInsertedInDynamicFunction As String = ""
        Dim strControlItemID As String = ""
        Dim intRowCount As Integer = 0
        Dim Cancel As Boolean = False

        Dim strTagID As String = ""
        Dim intControlMenuItemCount As Integer = 1
        Dim objAccess As New WebPage.Templates.AccessRights
        Dim objGlobal As WebPages.Template.WhizGlobal

        Dim strInsertAfterControlItem As String = ""

        Dim strSystemControlItem As String = ""
        Dim objHRHome_Event As HRHome_Event
        Dim objMenuItem As Menuitem_Home


        Dim strLastUpdationHTML As String = ""
        Dim strlastUpdateValueQuery As String = ""
        Dim strPlaceholder As String = ""
        Dim strLastUpdationSP As String = ""
        Dim intPlaceHolderCount As Integer = 0
        Dim drReplacePlaceHolder As IDataReader
        Dim intCount As Integer = 0
        Dim strPrimaryKeySQL As String = ""
        Dim intPrimaryKeyValue As String = ""
        Dim strPKToken As String = ""
        Dim strCountHTML As String = ""
        Dim TotalRows As Integer

        strSQL = "Usp_Sel_tbl_UI_ControlMenuItem_Favourites " & Session("intUserID").ToString
        drMenu = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        TotalRows = drMenu.RecordsAffected

        sbHtml.Append("<table id='HeaderTable' width='100%'  CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableHeader' >")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td WIDTH='14' class='clsTDTopLeftCorner'>  </td>")
        sbHtml.Append("<td  rowspan='2' valign='middle'> ")

        sbHtml.Append("<table WIDTH='100%'  Class='clsRoundedTableHeader' ><tr><td align='Left'><b>" & strGroupName & "</b></td>")
        sbHtml.Append("<td align='right' style='cursor:hand' onclick='addRemoveFavorites(0,""R"")'>Remove all</TD>")
        sbHtml.Append("<td align='right'><a  style='border-color:blue; text-decoration: none;' HREF='Javascript:ShowHideGroup_Onclick(" & intGroupID.ToString & ")'><img style='border-color:blue; text-decoration: none;' id='imgGroup" & intGroupID.ToString & "'  SRC='../../Images/Home/MoveUp.GIF' BORDER='0' ALT=' Show/Hide " & strGroupName & "' onmouseover=' this.border=1;' onmousedown='this.border=2' onmouseout=' this.border=0; '  width='16' height='16'></a></td></tr></table>")
        sbHtml.Append("</td>")
        sbHtml.Append("<td WIDTH='14' class='clsTDTopRightCorner'>  </td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("<tr>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("<td>&nbsp;&nbsp;</td>")
        sbHtml.Append("</tr>")
        sbHtml.Append("</table>")

        sbHtml.Append("<table  id='tblGroup" & intGroupID.ToString & "' WIDTH='100%' CELLPADDING='0' CELLSPACING='0' BORDER='0' Class='clsRoundedTableMenu'>")
        objHRHome_Event = New HRHome_Event
        objMenuItem = New Menuitem_Home

        sbHtml.Append("<tr class='clsTRControlMenu'>")

        While (drMenu.Read())
            strCountHTML = ""
            Cancel = False
            intRowCount = intRowCount + 1

            objMenuItem.UpdateLinkHTML = ""
            intPlaceHolderCount = 0
            strPrimaryKeySQL = ""
            strLastUpdationHTML = ""

            objMenuItem.ControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ControlItem")), "")
            objMenuItem.SystemControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("SystemControlItem")), "")
            objMenuItem.ItemDescription = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ItemDescription")), "")
            objMenuItem.PageURL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("PageURL")), "")
            objMenuItem.ImageName = "../../Images/DetailView/" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ImageName")), "")
            objMenuItem.ToolTip = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ToolTip")), "")
            objMenuItem.PageWidth = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("PageWidth"), "0"), ""))
            objMenuItem.PageHeight = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("PageHeight"), "0"), ""))
            objMenuItem.ToBeInsertedInDynamicFunction = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ToBeInsertedInDynamicFunction")), "")

            objMenuItem.ControlItemID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ControlItemID")), "")
            objMenuItem.InsertAfterControlItem = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("InsertAfterControlItem")), "")

            objMenuItem.ShowLastUpdated = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ShowLastUpdated")), "0"))
            objMenuItem.LastUpdationType = CInt(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdationType")), "0"))
            objMenuItem.LastUpdatePrimaryKeySQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdatePrimaryKeySQL")), "")
            objMenuItem.LastUpdateHTML = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdateHTML")), "")
            objMenuItem.LastUpdateValueQuery = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("LastUpdateValueQuery")), "")
            objMenuItem.countSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("CountSQL")), "")

            If objMenuItem.LastUpdatePrimaryKeySQL <> "" Then
                objMenuItem.LastUpdatePrimaryKeySQL = HRCommonfunction.ReplacePlaceHolders(objMenuItem.LastUpdatePrimaryKeySQL)
                objMenuItem.PrimaryKeyValue = CInt(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(objMenuItem.LastUpdatePrimaryKeySQL, True), "0"))
            End If

            If objMenuItem.ShowLastUpdated = True Then
                objMenuItem.LastUpdateHTML = Draw_LastUpdateLink(objMenuItem)
            End If


            objHRHome_Event.Before_LastUpdateLinkPrint(objMenuItem, Cancel)

            Call Replace_PKToken(objMenuItem)


            objGlobal = New WebPages.Template.WhizGlobal


            objGlobal.LCID = MyBase.CurrentThreadUICultureID
            objMenuItem.ApplyTagSecurity = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("ApplyTagSecurity"), True), True)
            objMenuItem.TagID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drMenu("TagID"), "0"), "")

            objHRHome_Event.BeforeControlMenuPlot(objMenuItem, Cancel)


            objGlobal.UseHashTable = True
            objGlobal.TagID = CType(objMenuItem.TagID, Long)
            objGlobal.UserID = CType(HttpContext.Current.Session("intUserID"), Long)
            objGlobal.RoleID = CType(HttpContext.Current.Session("intPostID"), Long)
            objGlobal.ParentTagID = 0
            objGlobal.ProjectID = Nothing
            objGlobal.LoginType = HttpContext.Current.Session("LoginType")
            If objMenuItem.ApplyTagSecurity Then
                objAccess.GetAccess(objGlobal)
            End If
            If objMenuItem.ApplyTagSecurity = False Or objAccess.Access Then
                sbHtml.Append("<td valign='top' width='35'>")

                If objMenuItem.ToBeInsertedInDynamicFunction = "" Then
                    sbHtml.Append("<a style=' border-color:blue; text-decoration: none;' HREF='Javascript:OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + ")'>")
                Else
                    sbHtml.Append("<a style='border-color:blue; text-decoration: none;' HREF='Javascript:Function_Onclick_" + objMenuItem.ControlItemID + "()'>")
                    sbHtml.Append("<script>function Function_Onclick_" + objMenuItem.ControlItemID + "(){" + vbCrLf)
                    sbHtml.Append(objMenuItem.ToBeInsertedInDynamicFunction + vbCrLf)
                    sbHtml.Append(" OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + ")")
                    sbHtml.Append("}</script>")
                End If

                sbHtml.Append("<img style='border-color:blue; text-decoration: none;' src='" + objMenuItem.ImageName + "' alt='" + objMenuItem.ToolTip + "' vspace=1 border=0 onmouseover=' this.border=1 ' onmousedown=' this.border=2 ' onmouseout=' this.border=0 '></a></td>")
                sbHtml.Append("<td valign='top' width='45%'>")

                sbHtml.Append("<table width='100%' >")
                sbHtml.Append("<tr><td valign='top'>")

                If objMenuItem.ToBeInsertedInDynamicFunction = "" Then
                    sbHtml.Append("<a class='clsControlMenuLink' HREF='Javascript:OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + ")'>")
                Else
                    sbHtml.Append("<a class='clsControlMenuLink' HREF='Javascript:Function_Onclick_" + objMenuItem.ControlItemID + "()'>")
                    sbHtml.Append("<script>function Function_Onclick_" + objMenuItem.ControlItemID + "(){" + vbCrLf)
                    sbHtml.Append(objMenuItem.ToBeInsertedInDynamicFunction + vbCrLf)
                    sbHtml.Append(" OpenPage_Onclick(""" + objMenuItem.PageURL + """," + objMenuItem.PageHeight + "," + objMenuItem.PageWidth + ")")
                    sbHtml.Append("}</script>")
                End If

                sbHtml.Append(objMenuItem.ControlItem)

                sbHtml.Append("</a>")

                If objMenuItem.countSQL <> "" Then
                    Try
                        objMenuItem.countSQL = HRCommonfunction.ReplacePlaceHolders(objMenuItem.countSQL)
                        strCountHTML = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(objMenuItem.countSQL, True), "")
                    Catch ex As Exception
                        strCountHTML = ""
                    End Try
                End If
                If strCountHTML <> "" Then

                    sbHtml.Append(strCountHTML)

                End If

                sbHtml.Append("</td><td valign='top' align='right'>")
                If objMenuItem.InsertAfterControlItem <> "" Then
                    objMenuItem.InsertAfterControlItem = HRCommonfunction.ReplacePlaceHolders(objMenuItem.InsertAfterControlItem)
                    sbHtml.Append(objMenuItem.InsertAfterControlItem)
                End If
                sbHtml.Append("</td></tr></table>")


                If objMenuItem.UpdateLinkHTML <> "" Then

                    sbHtml.Append(objMenuItem.UpdateLinkHTML)
                    sbHtml.Append("</font>")

                End If

                sbHtml.Append(objMenuItem.ItemDescription)
                sbHtml.Append("</td><td valign='top' align='right'><img border=0 src='../../Images/Home/RemoveFavorite.gif' style='cursor:hand;' title='Remove from favourites' onclick='addRemoveFavorites(" + objMenuItem.ControlItemID.ToString + ",""D"")'>")
                sbHtml.Append("</td>")

                If intControlMenuItemCount Mod 2 = 0 Then
                    sbHtml.Append("</tr><tr class='clsTRControlMenu'>")
                End If
                intControlMenuItemCount += 1
            End If

            If intControlMenuItemCount > MaxControlLimit Then
                Exit While
            End If


            objGlobal = Nothing
        End While

        CommonFunction.Data.DisposeDataReader(drMenu)

        sbHtml.Append("</tr>")

        ''''If intControlMenuItemCount = MaxControlLimit Then
        ''''    sbHtml.Append("<tr class='clsTRControlMenu'>")
        ''''    sbHtml.Append("<td align='right' colspan='3'>")
        ''''    sbHtml.Append("<a HREF='Javascript:ShowDetails_Onclick(" + intGroupID.ToString + ")'> <font color='blue'>more...</font>")
        ''''    sbHtml.Append("</a>&nbsp;&nbsp;&nbsp;&nbsp;</td>")
        ''''    sbHtml.Append("</tr>")
        ''''End If
        sbHtml.Append(" <tr>")
        sbHtml.Append("<td  class='clsTDBottomLeftCorner'>  </td>")
        sbHtml.Append("<td width='" & (intTableWidth - 28).ToString & "' ></td>")
        sbHtml.Append("<td></td><td class='clsTDBottomRightCorner'></td>")
        sbHtml.Append("</tr>")

        sbHtml.Append("</table>")
        sbHtml.Append("<br>")

        sbHtml.Append("<input type='hidden' id='hid_favCount' name='hid_favCount' value='" + (intControlMenuItemCount - 1).ToString + "'>")

        Return sbHtml.ToString

    End Function
End Class
