Imports System.IO
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class PRO_ProcessDiagram
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
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
    Protected m_intProcessID As Integer
    Protected m_strUploadedFileName As String
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : Calls the private class ReportUI to generate the
        '                         UI for the report
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 4,2007
        ' Revisions             :
        '=====================================================================
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        m_intProcessID = CInt(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProcessID"), "0"))
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SHOW" Then
            Draw_Page()
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "ADD" Then
            Draw_FileUpload()
        End If
    End Sub

    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI for Page
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 4,2007
        ' Revisions             :
        '=====================================================================
        Dim sbHtml As New System.Text.StringBuilder
        Dim drDiagram As IDataReader
        Dim strMenu, strSQL, strImage, strProcessName As String

        strProcessName = ""
        strImage = ""
        strMenu = DrawMenu()
        CommonFunction.General.WriteHTML(strMenu)

        strSQL = "Exec usp_Sel_tbl_PRS_ProcessDiagram " + m_intProcessID.ToString
        drDiagram = CommonFunction.Data.GetDataReader(strSQL, True)
        If drDiagram.Read Then
            strProcessName = CType(CommonFunction.Data.CheckIsDBNull(drDiagram("ProcessName"), ""), String)
            strImage = CType(CommonFunction.Data.CheckIsDBNull(drDiagram("FileName"), ""), String)
        End If


        sbHtml.Append("<BR><TABLE id='tblCap02182' cellspacing=0 cellpadding=0 width=99.9%  class=clsTable>" + vbCrLf)
        sbHtml.Append("<TR class='clsTRPageCaption' ><TD align=Left valign=top >Process Diagram</td><td align=right>" + strProcessName + "</td></tr></table><br>")

        sbHtml.Append("<div ID=PageDiv style='overflow:auto;width:99.9%;height:400px'>")
        If strImage = "" Then
            strImage = "../../Images/NoPreview.gif"
        Else
            strImage = "../../Images/Process/" + strImage
        End If

        sbHtml.Append("<Table class='clsTable' width=99.9% cellspacing=1 cellpadding=0>" + vbCrLf)
        sbHtml.Append("<Tr><td align='center' >")
        sbHtml.Append("<Img id='Dia'  src='" + strImage + "'>")
        sbHtml.Append("</td></tr>")
        'sbHtml.Append("<Tr><td align='left'>")
        'sbHtml.Append("<b>Note :</b> Image of size 800 X 500 will be the best fit for Process diagram.")
        'sbHtml.Append("</td></tr>")
        sbHtml.Append("</Table>")
        sbHtml.Append("</div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        CommonFunction.General.WriteHTML(strMenu)
        CommonFunction.Data.DisposeDataReader(drDiagram)
        sbHtml = Nothing
    End Sub

    Protected Sub Draw_FileUpload()
        '=====================================================================
        ' Procedure Name        : Draw_FileUpload()
        ' Purpose               : To generate the UI for Upload File
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 4,2007
        ' Revisions             :
        '=====================================================================
        Dim sbHtml As New System.Text.StringBuilder
        Dim drDiagram As IDataReader
        Dim strMenu, strSQL, strImage As String

        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList

        If CommonFunction.General.CheckIsNothing(Request.QueryString("Action"), "").ToUpper = "UPLOAD" Then
            Call performUploadAction()

            'Refresh Parent
            CommonFunction.General.WriteHTML("<Script Language=javascript>")
            CommonFunction.General.WriteHTML("window.opener.window.ChangeImage('" + m_strUploadedFileName + "');")
            'CommonFunction.General.WriteHTML("opener.location.href = 'PRO_ProcessDiagram.aspx?Mode=SHOW&ProcessID=" + m_intProcessID.ToString + "';")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")
        End If

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add("Upload") : arrMenuToolTip.Add("Upload") : arrClientSideFunctions.Add("Upload_OnClick()")
        arrMenu.Add("Close") : arrMenuToolTip.Add("Close") : arrClientSideFunctions.Add("Close_OnClick()")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing

        'draw upper menu
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        CommonFunction.General.WriteHTML(strMenu)

        Call plotDocumentUploadScreen()
        CommonFunction.General.WriteHTML("<BR>")
        CommonFunction.General.WriteHTML(strMenu)
    End Sub

    Private Sub plotDocumentUploadScreen()
        '=====================================================================
        ' Procedure Name		:	plotDocumentUploadScreen
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plot the controls for the upload mode of the page.
        ' Description			:	Here HTML file control is plotted to select the file from the disk.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	KapilGK
        ' Created				:	Oct, 4 2007
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String

        CommonFunction.General.WriteHTML("<Div id='DivList' width=100% height=90% style='overflow: auto;' >")
        CommonFunction.General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

        'display the file control
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='left'><b>Select File</b></TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.HTMLControls.DrawFileControl("txtFileName", "txtFileName", "clsFileControl", 60, , , , , , , True) + "</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</Table>")

        CommonFunction.General.WriteHTML("<Table id='tblMsg' class='clsTable' width=99.9% cellspacing=0 cellpadding=0 style='Display: none;'>")
        CommonFunction.General.WriteHTML("<TR class='clsTROdd'><TD align='center'>Uploading file,Please wait...</TD></TR>")
        CommonFunction.General.WriteHTML("</Table>")
        CommonFunction.General.WriteHTML("</div>")

        'write client side script to set focus on the filename textbox
        CommonFunction.General.WriteHTML("<Script language=javascript>")
        CommonFunction.General.WriteHTML(" var objTxt =  GetObjectReference('frmProcessDiagram','txtFileName');")
        CommonFunction.General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")
        CommonFunction.General.WriteHTML("</Script>")
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
    Private Sub performUploadAction()
        '=====================================================================
        ' Procedure Name		:	performUploadAction
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To upload the file given by the user and 
        '                       :   update the database with the entry.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	KapilGK
        ' Created				:	Oct, 4 2007
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String
        Dim strFileName As String
        Dim objFileUpload As FileUpload.cUpload
        Dim objFile As CommonFunction.FileDirectory.FileProperties
        Dim strCreatedDate As String
        Dim strOriginalFileName As String
        Dim strUploadedFileName As String
        Dim strFilePath As String
        Dim strSystemFileName As String
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
            strFilePath = Server.MapPath("../../Images/Process")

            strSystemFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
            'create the file object ot upload the file, Here Control Name is passed to the constructor
            'where the file name is taken internally from the control.Here we are not passing third parameter
            'to the constructor which is filename to upload.
            'This object creates the file name if it is already there to avoid the overwrite of old
            objFileUpload = New FileUpload.cUpload("txtFileName", strFilePath, strSystemFileName)
            objFileUpload.OverwriteIfExists = False
            objFileUpload.UploadFile()
            strOriginalFileName = objFileUpload.OriginalFileName
            strUploadedFileName = objFileUpload.UploadedFileName

            m_strUploadedFileName = strUploadedFileName
            objFileUpload = Nothing

            'create the fileProperties object ot get the properties of the file
            objFile = New CommonFunction.FileDirectory.FileProperties
            objFile.FilePath = strFilePath + "\" + strUploadedFileName.Trim
            objFile.GetFileProperties()

            'make the entry of the file in the database
            strSQL = "Exec Usp_Ins_Upd_tbl_PRS_ProcessDiagram " + m_intProcessID.ToString + ",'" + strOriginalFileName + "'"
            strSQL += ",'" + strUploadedFileName + "','" + HttpContext.Current.Session("strUserName").ToString + "'"
            'update the database 
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)

            objFile = Nothing
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

    Private Function DrawMenu() As String
        '=====================================================================
        ' Function Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 4,2007
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {"Upload Diagram", "Close", "?"}
        Dim arrMenuToolTip() As String = {"Upload Diagram", "Close", "Help"}
        Dim arrClientSideFunctions() As String = {"Add_OnClick()", "Close_OnClick()", "OpenHelpPage('ProDia')"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu
    End Function

    Protected Function Print_Title() As String
        '=====================================================================
        ' Function Name         : Print_Title
        ' Purpose               : Returns Title for the page
        ' Description           : Function is called from aspx page
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 4,2007
        ' Revisions             :
        '=====================================================================
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SHOW" Then
            Print_Title = "Process Diagram"
        End If
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "ADD" Then
            Print_Title = "Upload Diagram"
        End If
    End Function
End Class