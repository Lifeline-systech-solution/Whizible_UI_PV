'DECLARATION: THIS IS A FRAMEWORK CODE ITEM. IT IS NOT EXPECTED TO MODIFY THIS AT THE APPLICATION LEVEL 31/12/2025
Imports System.Net
Imports Newtonsoft.Json
Imports System.Xml
Imports System.IO
Imports System.Runtime.InteropServices

Public Class CLCP_Attachment
    Inherits WebPages.Template.WhizTemplate


    'Local Constants
    Private Const FORM_NAME As String = "frmAttachment"
    Private Const FORM_ID As String = "frmAttachment"
    Private Const DIV_TAG As String = "divAttachment"
    Private Const FUNCTION_ATTACH_ONCLICK As String = "Attach_Onclick()"
    Private Const FUNCTION_CLOSE_ONCLICK As String = "Close_Onclick()"
    'Local Variables
    'UJ_04052006, Issue ID: 123
    Protected m_objGlobal As WebPages.Template.IGlobal
    Private m_objSubTagCLSQL As CommonEngine.CommonList.cSubTagCLSQL
    Private m_lngSubTagId As Long = 0
    Private m_Att As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Initialize
    Private m_AttControl As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control
    Private m_strInsertIntoUploadFunction As String = ""
    Private m_strParentTagQuerystringDefaultParameters As String = ""
    'Code Modified:RajeshB  
    Protected strFormPage As String = "CommonPage.aspx"
    'Added BY NileshD on 21 June 2005
    Protected strAttachmentPage As String = "CLCP_Attachment.aspx"
    Protected m_blnRefreshScript As Boolean = True
    'Modification Ends.
    Private WithEvents m_objMenu As WebPage.UI.cStaticMenu 'WAF3_PB_39
    Private m_blnTopLinkPlotted As Boolean = False 'WAF3_PB_39
    '==========================================================================================================
    'Added By NinadP :	13 Feb 2007 : Requirement Tag - WAF3_PB_33 
    '==========================================================================================================
    Protected m_strConnectionString As String = ""
    '==========================================================================================================
    ' Addition End By : Ninad   Req Id : WAF3_PB_33
    '==========================================================================================================
    Protected m_strExtensionList As String = ""
    Protected m_strMinFileSize As String = ""

    Protected m_intTagID As Integer
    'Added By Chakshuta H on 29th-Oct-2015
    'Private WithEvents m_objMenu As WebPage.UI.cStaticMenu 'WAF3_PB_39
    'Private m_blnTopLinkPlotted As Boolean = False 'WAF3_PB_39
    'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
    Private m_intNoOfAttachmentAllowed As Integer = 1
    Private m_blnIsSingleRecordAttachmentTab As Boolean
    Protected WithEvents m_cObjHeaderFooter As WebPage.Templates.HeaderFooter
    Protected WithEvents m_objGrid As New WebPage.Templates.GenericGrid
    Dim strATTACH_LINK As String
    Dim strATTACH_LINK_TITLE As String
    Dim strCOL_CAPTION_FILE_NAME As String
    Dim strCOL_CAPTION_DELETE As String
    Dim strDELETE_TITLE As String
    Dim strCOL_CAPTION_DESCRIPTION As String
    'End Addition By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
    'Ended By Chakshuta H on 29th-Oct-2015
    Dim PostedFileObj As HttpPostedFile
    Dim buffer As Byte() = New Byte(256) {}
    Protected m_AllowtoUpload As Integer = 1
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
    'Private -> Protected Overridable

    Protected Overridable Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '==========================================================================================================
        'Added By NinadP :	13 Feb 2007 : Requirement Tag - WAF3_PB_33 
        If CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) <> "" Then
            m_strConnectionString = CommonEngines.HashTables.GetHashTableObject.GetHashTableConnection(CommonFunctions.General.DecryptString(Request("ConnectionID")))
        End If
        If CommonFunctions.General.CheckIsNothing(Request("strFormPageName")) <> "" Then
            strFormPage = CommonFunctions.General.DecryptString(Request("strFormPageName"))
        Else
            strFormPage = "CommonPage.aspx"
        End If
        'Added by ArchanaN on 1-Oct-2010
        m_intTagID = CommonFunction.General.CheckIsNothing(Request("ParentTagID"), 0)
        If m_intTagID <> 0 Then
            'Commented and Added By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
            'm_strExtensionList = CommonFunction.General.GetFileExtnListForTag(m_intTagID)
            m_strExtensionList = ConfigurationManager.AppSettings("FileExtensionDisallow")
            m_strMinFileSize = ConfigurationManager.AppSettings("MinFileSize")
            'End of Commented and Added By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
        End If

        'If HttpContext.Current.Request("Mode") = CommonFunction.Constants.MODE_ATTACH Then
        '    If HttpContext.Current.Request.Files.Count > 0 Then
        '        PostedFileObj = HttpContext.Current.Request.Files(0)
        '        PostedFileObj.InputStream.Read(buffer, 0, 256)
        '        'Added By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
        '        PostedFileObj.InputStream.Position = 0
        '        'End of Added By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
        '        CommonFunction.General.buffer = buffer

        '        Dim MimeType As String
        '        Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
        '        Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
        '        Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
        '        Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
        '        Dim CharList As String()
        '        Dim extensions As String()
        '        Dim IsValidExtension As Integer = 1
        '        extensions = fileName.Split("."c)
        '        If (extensions.Length > 2) Then
        '            IsValidExtension = 0
        '        End If
        '        CharList = ValidateFileName.Split(","c)
        '        For k As Integer = 0 To CharList.Length - 1
        '            If fileName.Contains(CharList(k).ToString) Then
        '                fileName1 = fileName1.Replace(CharList(k).ToString, "")
        '            End If
        '        Next
        '        If fileName = fileName1 And IsValidExtension = 1 Then
        '            Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))

        '            Dim xmlDoc As New XmlDocument()
        '            Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
        '            xmlDoc.Load(xmlPath + "MIMEType.xml")
        '            Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
        '            Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""

        '            'Added by imran on 02-01-2023
        '            'Dim fileNameExtention As String = HttpContext.Current.Request.Files(0).FileName
        '            'Dim ext1 As String = Path.GetExtension(fileNameExtention)
        '            'Dim count As Integer = ext1.Split("."c).Length - 1
        '            'End of comment by imran on 02-01-2022

        '            'If count > 1 Then
        '            '    MimeType = ""
        '            '    m_AllowtoUpload = 0
        '            'End If

        '            'If count = 1 Then
        '            For Each node As XmlNode In nodes
        '                    xContentType = node.SelectSingleNode("ContentType").InnerText
        '                    If strFileType = xContentType Then
        '                        fileName = HttpContext.Current.Request.Files(0).FileName
        '                        Dim ext As String = Path.GetExtension(fileName)
        '                        ext = ext.Substring(1, ext.Length - 1).ToLower()
        '                        extfromContentType = node.SelectSingleNode("Extension").InnerText.ToLower()
        '                        If extfromContentType.IndexOf(ext) > -1 Then
        '                            MimeType = strFileType
        '                            Exit For
        '                        End If
        '                    End If
        '                Next
        '            'End If
        '        Else
        '            MimeType = ""
        '            m_AllowtoUpload = 0
        '        End If

        '        If MimeType Is Nothing Or MimeType = "" Then
        '            MimeType = "unknown/unknowns"
        '        End If

        '        If strListofTypes.IndexOf(MimeType) >= 0 Then
        '            m_AllowtoUpload = 1
        '        Else
        '            m_AllowtoUpload = 0

        '        End If


        '    End If
        '    If m_AllowtoUpload = 0 Then
        '        CommonFunction.General.WriteHTML("<div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:120px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        '        CommonFunction.General.WriteHTML("<Table cellspacing=0 height='100%' class=clsTable width='99.9%'><TR class=clsTREven>")
        '        'CommonFunction.General.WriteHTML("<TD align=center style='color:red;'><B>Invalid File Content!!</B></TD>")
        '        CommonFunction.General.WriteHTML("<TD align=center style='color:red;'><B>Please upload valid file.</B></TD>")
        '        CommonFunction.General.WriteHTML("</TR></Table>")
        '        CommonFunction.General.WriteHTML("</div>")
        '        Exit Sub
        '    End If
        'End If


        'End of Added by ArchanaN on 1-Oct-2010

        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Create the global class object
        Call GetGlobalObject()

        'Added By Bharat Tekade on 1st-July-2016 for access byte array of file
        If HttpContext.Current.Request.Files.Count > 0 Then
            PostedFileObj = HttpContext.Current.Request.Files(0)
            PostedFileObj.InputStream.Read(buffer, 0, 256)
            'Added By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            PostedFileObj.InputStream.Position = 0
            'End of Added By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            CommonFunction.General.buffer = buffer
        End If
        If HttpContext.Current.Request("Mode") = CommonFunction.Constants.MODE_ATTACH Then
            Dim MimeType As String
            Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
            Dim fileName1 As String = Utilities.Security.SecurityBuilder.CheckUserInput(fileName, 2, True, True, True)
            Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            Dim ValidateFileName As String = ConfigurationManager.AppSettings("ValidateFileName")
            Dim CharList As String()
            Dim extensions As String()
            Dim IsValidExtension As Integer = 1
            extensions = fileName.Split("."c)
            If (extensions.Length > 2) Then
                IsValidExtension = 0
            End If
            CharList = ValidateFileName.Split(","c)
            For k As Integer = 0 To CharList.Length - 1
                If fileName.Contains(CharList(k).ToString) Then
                    fileName1 = fileName1.Replace(CharList(k).ToString, "")
                End If
            Next
            If fileName = fileName1 And IsValidExtension = 1 Then
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))

                Dim xmlDoc As New XmlDocument()
                Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                xmlDoc.Load(xmlPath + "MIMEType.xml")
                Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                Dim xMagicNumber As String = "", xContentType As String = "", extfromContentType As String = ""


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
            Else
                MimeType = ""
                m_AllowtoUpload = 0
            End If

            If MimeType Is Nothing Or MimeType = "" Then
                MimeType = "unknown/unknowns"
            End If

            If strListofTypes.IndexOf(MimeType) >= 0 Then
                m_AllowtoUpload = 1
            Else
                m_AllowtoUpload = 0

            End If


        End If
        If m_AllowtoUpload = 0 Then
            CommonFunction.General.WriteHTML("<div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:120px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            CommonFunction.General.WriteHTML("<Table cellspacing=0 height='100%' class=clsTable width='99.9%'><TR class=clsTREven>")
            'CommonFunction.General.WriteHTML("<TD align=center style='color:red;'><B>Invalid File Content!!</B></TD>")
            CommonFunction.General.WriteHTML("<TD align=center style='color:red;'><B>Please upload valid file.</B></TD>")
            CommonFunction.General.WriteHTML("</TR></Table>")
            CommonFunction.General.WriteHTML("</div>")
            Exit Sub

        End If
        'Added By Bharat Tekade on 1st-July-2016 for access byte array of file

        'Get the Attachment Tag Detail and upload the attachment
        'If m_AllowtoUpload = 1 Then
        Call SubTag_GetCLSQL()
        'End If
        'Call SubTag_GetCLSQL()
        If ViewAttachment() = False Then
            'Page Details
            Call PageDetails()
        End If
        'Remove objects from memory
        Call MemoryCleanUp()
    End Sub
    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function
    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr
        Dim MaxContent As Integer = CInt(file.ContentLength)
        'If MaxContent > 200 Then
        '    MaxContent = 200
        'End If
        MaxContent = 200
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

    Private Sub GetGlobalObject()
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get Page Specific Global Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Create the global class object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"), , 0)
        m_objGlobal = MyBase.GlobalObject
        'Create tye global object as required
        m_lngSubTagId = CType(CommonFunction.General.CheckIsNothing(Request("MasterTagID")), Long)
        m_objGlobal.TagID = CType(CommonFunction.General.CheckIsNothing(Request("ParentTagID")), Long)
        m_objGlobal.ParentTagID = 0
        'Apply Security
        MyBase.ApplySecurity(True, 2, , , True, m_objGlobal.TagID, m_objGlobal.ParentTagID)
        'Added by Nilesh G date 11/3/2016 For SQL Injection,Cross Scripting
        ''Commented By Vaijat K ON 12/11/2016 For Issue ID - 5457
        '' MyBase.ApplySecurity(True)
        ''End Of Comment
        'End of Addtion by Nilesh G date 11/3/2016 For SQL Injection,Cross Scripting
    End Sub

    Private Sub SubTag_GetCLSQL()
        '=====================================================================
        ' Procedure Name        :	SubTag_GetCLSQL
        ' Purpose               :	Get the Page Details from the database
        ' Description           :	This method access the cSubTagCLSQL class to retrieve 
        '                           the page details required to plot the Sub tag Common List 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'UJ_04052006, Issue ID: 123
        m_objSubTagCLSQL = InitSubTagCLSQL(m_objGlobal) 'New CommonEngine.CommonList.cSubTagCLSQL(m_objGlobal)
        With m_objSubTagCLSQL
            '==========================================================================================================
            'Added By NinadP :	13 Feb 2007 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .SubTagId = m_lngSubTagId
            .ForeignKeyValue = CommonFunction.General.CheckIsNothing(Request("ForeignKeyValue"))
            .TabOnclickFunction = "OnClick" + m_objGlobal.TagID.ToString
            .GetSubTagDetails()
            'Added By Chakshuta H on 29th-Oct-2015
            m_intNoOfAttachmentAllowed = .NoOfAttachmentAllowed 'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            m_blnIsSingleRecordAttachmentTab = .IsSingleRecordAttachmentTab  'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            'Ended By Chakshuta H on 29th-Oct-2015
        End With
    End Sub
    'UJ_04052006, Issue ID: 123
    Protected Overridable Function InitSubTagCLSQL(ByVal objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New CommonEngine.CommonList.cSubTagCLSQL(objSubTagGlobal)
    End Function
    Private Function ViewAttachment() As Boolean
        '=====================================================================
        ' Procedure Name        :	ViewAttachment
        ' Purpose               :	View Attachment
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 02, 2003 
        ' Revisions             :
        '=====================================================================
        ViewAttachment = False
        If CommonFunction.General.CheckIsNothing(Request("Operation")) = CommonFunction.Constants.OPERATION_VIEW_ATTACHMENT Then

            '__________________________WAF3_PB_26 By UmeshJ 24th August 2006__________________________
            If m_objSubTagCLSQL.PKToken_IsValid = False Then
                'Insert Record into the log table
                Dim PKVal As String = ""
                Try
                    PKVal = CommonFunctions.General.CheckIsNothing(Request(m_objSubTagCLSQL.PrimaryKey))
                Catch
                End Try
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess(m_objSubTagCLSQL.PageCaption, m_lngSubTagId, m_objGlobal.TagID, m_objSubTagCLSQL.PrimaryKey, PKVal)
                'Security Alert...Token check failed
                Call MemoryCleanUp()
                'Redirect to User Friendly Message Page
                Dim strRedirectPagePath As String = "" & strFormPage & "?MasterTagId=1836&FromWhere=1"
                Response.Redirect(strRedirectPagePath)
                Exit Function
            End If
            '__________________________WAF3_PB_26 By UmeshJ 24th August 2006__________________________

            'Added By Ashish Date 16-Apr-05
            Dim iStream As System.IO.Stream
            Dim buffer(10000) As Byte
            ' Length of the file:
            Dim length As Integer
            ' Total bytes to read:
            Dim dataToRead As Long
            'Addition End


            If m_objSubTagCLSQL.AttachmentFilePath.Trim <> "" Then
                ' allow content types for all report formats
                'Added By AmitJ & AmrutaJ on 21 sept 2006 For Sierra Atlantic IssueId 3689=>
                'Uploaded document under Releases is not displaying in correct format.
                Response.Clear()
                'End of Addition by Amitj

                Response.ContentType = "Application/octet-stream" '"Application/pdf/html/csv/excel/rtf/xml/text" UJ 16 Aug 2007 for HTML format issue
                Try
                    Dim strFilePath As String = Server.MapPath(m_objSubTagCLSQL.AttachmentFilePath.Trim)
                    ' add the file name to the header
                    'Response.AddHeader("Content-Disposition", "attachment;filename=" + m_objSubTagCLSQL.AttachmentFileName)
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + HttpUtility.UrlEncode(m_objSubTagCLSQL.AttachmentFileName))
                    ' Response.AddHeader("Content-Disposition", "attachment;filename=" + m_objSubTagCLSQL.AttachmentFileName)


                    ' if the file exists write the file
                    If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                        'Added By Ashish to read the file in chunk Date 16-Apr-05
                        ' Open the file.
                        iStream = New System.IO.FileStream(strFilePath, System.IO.FileMode.Open,
                                                               IO.FileAccess.Read, IO.FileShare.Read)

                        ' Total bytes to read:
                        dataToRead = iStream.Length
                        'Read the bytes.
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
                        'Addition end Ashish

                        'Response.WriteFile(strFilePath)
                        'Added By SnehalV Sp7 BFT Issue Integration on 3rd October 2006
                        If IsNothing(iStream) = False Then
                            iStream.Close()
                            iStream = Nothing
                        End If
                        'End Of Addition By SnehalV
                    Else
                        Throw New Exception(MyBase.GetResourceString("FILE_NOT_FOUND"))
                    End If
                    'Response.Flush()
                Catch exc As Exception
                    exc.Source = "CLCP_Attachment.aspx->ViewAttachment()"
                    Throw exc
                Finally
                    If IsNothing(iStream) = False Then
                        ' Close the file.
                        iStream.Close()
                    End If
                End Try
            Else
                'Inform the user about the File not found
                Call CreateForm()
                Call InformFileNotFound()
                Call EndForm()
                Call WriteClientsideScript()
            End If
            ViewAttachment = True
        End If
    End Function
    Private Sub CreateForm()
        '=====================================================================
        ' Procedure Name        :	CreateForm
        ' Purpose               :	Create Form tag
        ' Description           :	This method will plot the initial portion 
        '                           for the page and form tag
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :   Modified by PrasannaP on 30th May 2005, Added FormID.. Issue ID: 28888
        '=====================================================================
        ' commented by miiint 23/12/2014
        'Response.Write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>")
        ' added by miint 23/12/2014
        Response.Write("<!DOCTYPE HTML>")
        Response.Write("<HTML>")
        'Head Tag
        ' ***************************************************************************************
        ' Modified Aug 27,2004 Rajanikant Khethawatt R.No.WAF2_PB_32
        ' ***************************************************************************************
        Response.Write(CommonFunction.General.PlotPageHeadTag(CommonFunction.General.CheckIsNothing(m_objSubTagCLSQL.PageCaption), , , , , True, m_objGlobal.ParentTagID))
        ' ***************************************************************************************
        ' End Modification Aug 27,2004 Rajanikant Khethawatt
        ' ***************************************************************************************

        Response.Write("<BODY class=clsBody onload='window_onload()' onresize='window_onresize()'><FORM id='" + FORM_ID + "' name='" + FORM_NAME + "' method=post enctype='multipart/form-data'>")
    End Sub

    Private Sub EndForm()
        Response.Write("</FORM></BODY></HTML>")
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
        'allDone.WaitOne()


    End Function
    'Added By Bharat Tekade on 30th-Jun-2016 for sem enhamcement
    'Public Shared Function ReadAllBytes(fileName As String) As Byte()
    '    Dim buffer As Byte() = Nothing
    '    Using fs As New FileStream(fileName, FileMode.Open, FileAccess.Read)
    '        buffer = New Byte(256) {}
    '        fs.Read(buffer, 0, 256)
    '    End Using
    '    Return buffer
    'End Function
    'End of Added By Bharat Tekade on 30th-Jun-2016 for sem enhamcement
    Private Sub PageDetails()
        '=====================================================================
        ' Procedure Name        :	PageDetails
        ' Purpose               :	Get Page Details
        ' Description           :	This method will plot the page
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 29, 2003 
        ' Revisions             :
        '=====================================================================
        Call CreateForm()
        Call GetQueryStringDefaultParametersForParentTag()
        If HttpContext.Current.Request("Mode") = CommonFunction.Constants.MODE_ATTACH Then
            ''Added by swapnil aswale on 15-06-2016
            Dim response As String = String.Empty
            'Dim file As HttpPostedFile = Context.Request.Files(0)
            Dim buffer As Byte() = New Byte(256) {}
            Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
            Dim MimeType As String
            'CommonFunction.General.PostedFileObj.InputStream.Read(buffer, 0, 256)
            buffer = CommonFunction.General.buffer
            ' buffer = ReadAllBytes(file.FileName)

            'Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            'Dim mimeKey = ConfigurationManager.AppSettings("MimeHostPath")
            'Dim uri As String = String.Format(mimeKey)

            'response = GetResponse(uri, buffer)
            'Dim tokenJson = JsonConvert.SerializeObject(response)

            'Dim jsonResult = JsonConvert.DeserializeObject(Of Dictionary(Of String, Object))(response)
            'MimeType = jsonResult.Item("mime")
            'End of Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues


            'If strListofTypes.Contains("text/plain") Or strListofTypes.Contains("text/xml") Or strListofTypes.Contains("application/xml") Or strListofTypes.Contains("text/html") Then

            'Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            'If MimeType = "text/plain" Or MimeType = "text/xml" Or MimeType = "application/xml" Or MimeType = "text/html" Then

            'Else
            'End of Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            'file.InputStream.Read(buffer, 0, 256)
            Dim magicNumber As String = BitConverter.ToString(buffer)
            magicNumber = magicNumber.Replace("-", " ")

            Dim xmlDoc As New XmlDocument()
            Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
            xmlDoc.Load(xmlPath + "MIMEType.xml")
            Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
            Dim xMagicNumber As String = "", xContentType As String = ""

            'Added by imran on 02-01-2023
            Dim fileNameExtention As String = HttpContext.Current.Request.Files(0).FileName
            Dim ext1 As String = Path.GetExtension(fileNameExtention)
            Dim count As Integer = ext1.Split("."c).Length - 1
            Dim count2 As Integer = fileNameExtention.Split("."c).Length - 1
            If count > 1 Then
                MimeType = ""
                m_AllowtoUpload = 0
                Exit Sub
            End If
            'End of comment by imran on 02-01-2022

            If count = 1 Or count2 = 1 Then
                For Each node As XmlNode In nodes
                    xMagicNumber = node.SelectSingleNode("MagicNumber").InnerText

                    Dim xsubstring As String = magicNumber.Substring(0, Convert.ToInt32(xMagicNumber.Length))
                    'If Convert.ToInt32(xMagicNumber.Length) > 25 Then
                    '    xMagicNumber.Substring(0, 25)
                    'End If
                    If xsubstring = xMagicNumber Then
                        MimeType = node.SelectSingleNode("ContentType").InnerText
                        Exit For
                    Else
                        Dim fileName As String = HttpContext.Current.Request.Files(0).FileName
                        Dim ext As String = Path.GetExtension(fileName)
                        ext = ext.Substring(1, ext.Length - 1)
                        If ext = xMagicNumber Then
                            MimeType = node.SelectSingleNode("ContentType").InnerText
                        End If
                    End If
                Next
            End If

            If MimeType Is Nothing Then
                MimeType = "unknown/unknowns"
            End If
            'Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            'End If
            'End of Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
            'If strListofTypes.IndexOf(MimeType) >= 0 Then
            '    Call InformFileUpload()
            'Else
            '    CommonFunction.General.WriteHTML("<div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:120px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            '    CommonFunction.General.WriteHTML("<Table cellspacing=0 height='100%' class=clsTable width='99.9%'><TR class=clsTREven>")
            '    CommonFunction.General.WriteHTML("<TD align=center style='color:red;'><B>Invalid File Content!!</B></TD>")
            '    CommonFunction.General.WriteHTML("</TR></Table>")
            '    CommonFunction.General.WriteHTML("</div>")
            'End If
            If m_AllowtoUpload = 1 Then
                Call InformFileUpload()
            End If

        Else
            Call CreateHiddenParameters()
            'Added By Chakshuta H on 29th-Oct-2015
            'Issue ID: 19728
            Dim arrMenu() As String = {" " + MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_UPLOAD_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {FUNCTION_ATTACH_ONCLICK, FUNCTION_CLOSE_ONCLICK}
            Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/uploaddata.gif", "../../Images/cssImages/Link images/close.gif"}
            Dim arrSeparator() As Boolean = {True, False} 'Added By Ninad Issue ID: 19728

            'Commented By Dhanashri S on 2nd-Nov-2015 Purpose::QA issue fixing
            'Call GetMenu(arrMenu, arrMenuToolTip, arrClientSideFunctions, arrImagePaths, arrSeparator) 'Issue ID: 19728
            'End Of Comment By Dhanashri S on 2nd-Nov-2015 Purpose::QA issue fixing

            'Ended By Chakshuta H on 29th-Oct-2015

            'Call GetMenu()
            Call GetMenu(arrMenu, arrMenuToolTip, arrClientSideFunctions, arrImagePaths, arrSeparator) 'Issue ID: 19728

            Call PlotControls()
            'WAF3_PB_42 April 09, 2007 UmeshJ START
            If m_objSubTagCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
                'Commented And Added by Chakshuta H on 29th-Oct-2015
                ''Call GetMenu()
                Call GetMenu(arrMenu, arrMenuToolTip, arrClientSideFunctions, arrImagePaths, arrSeparator) 'Issue ID: 19728
                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
            End If
            'WAF3_PB_42 April 09, 2007 UmeshJ END
            'Added By Chakshuta H on 29th-Oct-2015
            arrMenu = Nothing : arrMenuToolTip = Nothing : arrClientSideFunctions = Nothing : arrImagePaths = Nothing : arrSeparator = Nothing 'Issue ID: 19728
            'Ended By Chakshuta H on 29th-Oct-2015

        End If
        Call WriteClientsideScript()
        Call EndForm()
    End Sub
    'Commented And Added by Chakshuta H on 29th-Oct-2015
    'Private Sub GetMenu()
    Private Sub GetMenu(ByVal arrMenu() As String, ByVal arrMenuToolTip() As String, ByVal arrClientSideFunctions() As String, ByVal arrImagePaths() As String, ByVal arrSeparator() As Boolean)
        'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
        '=====================================================================
        ' Procedure Name        :	GetMenu
        ' Purpose               :	Plot menu on the page
        ' Description           :	This method will plot the menu
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 28, 2003 
        ' Revisions             :
        '=====================================================================
        ''Dim arrMenu() As String = {" " + MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE")}
        ''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_UPLOAD_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        ''Dim arrClientSideFunctions() As String = {FUNCTION_ATTACH_ONCLICK, FUNCTION_CLOSE_ONCLICK}

        'WAF3_PB_39 start
        'Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu( arrMenu, arrClientSideFunctions, arrMenuToolTip, True , , , arrImagePaths)
        m_objMenu = New WebPage.UI.cStaticMenu
        m_objMenu.MenuNames = arrMenu
        m_objMenu.ToolTip = arrMenuToolTip
        m_objMenu.ClientSideFunctionNames = arrClientSideFunctions
        'Added By Chakshuta H on 29th-Oct-2015
        m_objMenu.ImageURLs = arrImagePaths
        'Ended By Chakshuta H on 29th-Oct-2015
        m_objMenu.clsTable = "clsTable"
        m_objMenu.clsTR = "clsTRMenu"
        m_objMenu.LinkSeperator = "|"
        m_objMenu.cssClass = "Menu"
        m_objMenu.TableStyle = "cellspacing=0 cellpadding=0 width='100%'"
        m_objMenu.MenuAlignment = "right"
        m_objMenu.returnHTML = True
        'WAF3_PB_42 April 03, 2007 UJ START
        Dim strMenu As String
        If m_objSubTagCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
            m_objMenu.Action_NavigationSchema = WebPages.UI.cStaticMenu.DynamicAction_NavigationSchema.CLASSICAL
            strMenu = m_objMenu.DrawMenu()
        Else
            'Dim arrSeparator() As Boolean = {True, False}
            m_objMenu.Action_NavigationSchema = WebPages.UI.cStaticMenu.DynamicAction_NavigationSchema.DROPDOWN
            m_objMenu.DropdownMenu_AddSeparatorAfterLink = arrSeparator
            m_objMenu.DropdownMenu_HideControls = ""
            m_objMenu.DropdownMenu_EnclosingDiv = ""
            m_objMenu.DropdownMenu_Width = 100
            m_objMenu.DropdownMenu_TopFillFactor = 2
            strMenu = m_objMenu.DrawMenu()
            arrSeparator = Nothing
        End If
        'WAF3_PB_42 April 03, 2007 UJ END
        m_objMenu = Nothing
        'Added By Chakshuta H on 29th-Oct-2015
        'WAF3_PB_39 End
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - Set the arrays to nothing. 
        '-------------------------------------------------------------------------------------------------------------
        'Ended By Chakshuta H on 29th-Oct-2015
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing
        'Added By Chakshuta H on 29th-Oct-2015
        arrImagePaths = Nothing
        arrSeparator = Nothing
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------
        'Ended By Chakshuta H on 29th-Oct-2015
        'WAF3_PB_39 End
        Response.Write(strMenu)
    End Sub
    Private Sub InformFileNotFound()
        '=====================================================================
        ' Procedure Name        :	InformFileNotFound
        ' Purpose               :	Inform the user about File not found
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 29, 2003 
        ' Revisions             :   Width Modified 100 to 99.9 by PrasannaP on 30th May 2005. IssueID 28888
        '=====================================================================
        Dim strMsgUploadFile As String = MyBase.GetResourceString("FILE_NOT_FOUND")
        CommonFunction.General.WriteHTML("<div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:120px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        CommonFunction.General.WriteHTML("<Table cellspacing=0 height='100%' class=clsTable width='99.9%'><TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=center><B>" + strMsgUploadFile + "</B></TD>")
        CommonFunction.General.WriteHTML("</TR></Table>")
        CommonFunction.General.WriteHTML("</div>")
    End Sub
    Private Sub InformFileUpload()
        '=====================================================================
        ' Procedure Name        :	InformFileUpload
        ' Purpose               :	Inform the user about File Upload
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 29, 2003 
        ' Revisions             :   Width Modified 100 to 99.9 by PrasannaP on 30th May 2005. IssueID 28888
        '=====================================================================
        'Commented And Added by Chakshuta H on 29th-Oct-2015
        ''Dim strMsgUploadFile As String = MyBase.GetResourceString("FILE_UPLOAD_MSG")
        'Added By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
        Dim strMsgUploadFile As String
        If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
            strMsgUploadFile = MyBase.GetResourceString("FILES_UPLOAD_MSG")
        Else
            strMsgUploadFile = MyBase.GetResourceString("FILE_UPLOAD_MSG")
        End If
        'End Addition By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
        'Issue ID: 19728
        Dim arrMenu() As String = {" " + MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {FUNCTION_CLOSE_ONCLICK}
        Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/close.gif"}
        Dim arrSeparator() As Boolean = {False}
        Call GetMenu(arrMenu, arrMenuToolTip, arrClientSideFunctions, arrImagePaths, arrSeparator) 'Issue ID: 19728

        ''CommonFunction.General.WriteHTML("<div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:120px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        CommonFunction.General.WriteHTML("<BR><div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:120px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">") 'Issue ID: 19728 add <BR>
        'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
        CommonFunction.General.WriteHTML("<Table cellspacing=0 height='100%' class=clsTable width='99.9%'><TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=center><B>" + strMsgUploadFile + "</B></TD>")
        CommonFunction.General.WriteHTML("</TR></Table>")
        ''CommonFunction.General.WriteHTML("</div>")
        CommonFunction.General.WriteHTML("</div><BR>") 'Issue ID: 19728 add <BR>
        'Added By Chakshuta H on 29th-Oct-2015
        If m_objSubTagCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then 'Added By Ninad, Issue ID: 19728
            Call GetMenu(arrMenu, arrMenuToolTip, arrClientSideFunctions, arrImagePaths, arrSeparator) 'Issue ID: 19728
        End If
        arrMenu = Nothing : arrMenuToolTip = Nothing : arrClientSideFunctions = Nothing : arrImagePaths = Nothing : arrSeparator = Nothing 'Added By Ninad Issue ID: 19728

        'Ended By Chakshuta H on 29th-Oct-2015

        If HttpContext.Current.Request("RefreshScript") = "1" Then
            CommonFunction.General.WriteHTML("<Script language=javascript>")
            'CommonFunction.General.WriteHTML("   refreshParent('" + CommonPage.FORM_NAME + "','','CommonPage.aspx?FocusOn=" + CommonPage.FocusOn_SUBTAG + m_strParentTagQuerystringDefaultParameters + "');")
            CommonFunction.General.WriteHTML("   refreshParent('" + CommonPage.FORM_NAME + "','','" & strFormPage & "?FocusOn=" + CommonPage.FocusOn_SUBTAG + m_strParentTagQuerystringDefaultParameters + "');")

            CommonFunction.General.WriteHTML("</Script>")
        End If
    End Sub
#Region "EVENTS"
    'Added By UmeshJ on 13 July 2007
    Public Overridable Sub Initialize_Attachment(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Initialize, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonEngine.General.CLCP_Events_Attachments.Initialize_Attachment(Cancel, Args, WhizGlobal)
    End Sub

    Public Overridable Sub Before_FileControl_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonEngine.General.CLCP_Events_Attachments.Before_FileControl_Print(Cancel, Args, WhizGlobal)
    End Sub

    Public Overridable Sub Before_Description_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonEngine.General.CLCP_Events_Attachments.Before_Description_Print(Cancel, Args, WhizGlobal)
    End Sub

    Public Overridable Sub After_UI_Print(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonEngine.General.CLCP_Events_Attachments.After_UI_Print(Args, WhizGlobal)
    End Sub
#End Region
    Private Sub PlotControls()
        '=====================================================================
        ' Procedure Name        :	PlotControls
        ' Purpose               :	Plot Controls on the page
        ' Description           :	This method will plot the file control
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 28, 2003 
        ' Revisions             :
        '=====================================================================
        'Prepare the Attachment object
        Call PrepareAttachmentUIObject()
        Dim blnCancel As Boolean = False

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", "Initialize_Attachment")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************   

            'Code Modified to replace shared variables with class properties. by PrasannaP - 15-JUL-2005
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_WAF_Initialize = m_Att
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.Cancel = blnCancel
            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, _
                        "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", "Initialize_Attachment", _
                        ExtensionArgs)
            blnCancel = ExtensionArgs.Cancel
            m_Att = ExtensionArgs.m_WAF_Initialize
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends

            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Call the initialize event
            Call Initialize_Attachment(blnCancel, m_Att, m_objGlobal) 'By UmeshJ on 13 July 2007
            'CommonEngine.General.CLCP_Events_Attachments.Initialize_Attachment(blnCancel, m_Att, m_objGlobal)
        End If
        'Addition Ends.
        If blnCancel = False Then
            'Added By Chakshuta H on 29th-Oct-2015
            'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
                PlotPageNote()
            End If
            'End Addition By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

            'Ended By Chakshuta H on 29th-Oct-2015

            CommonFunction.General.WriteHTML("<BR><div id=" + m_Att.DIVID + " Style=" & Chr(34) + "HEIGHT:" + m_Att.DIVHeight.ToString + "px;" + m_Att.DIVStyle + Chr(34) + ">")
            CommonFunction.General.WriteHTML("<Table " + m_Att.TableStyle + " class=" + m_Att.clsTable + " width='" + m_Att.TableWidth + "'>")

            'Prepare the File Control object
            Call PrepareFileControlObject()
            Dim blnCancelControl As Boolean = False
            'Code Added:RajeshB	14 October, 2004
            'Purpose: Check if event is to be raised

            blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", "Before_FileControl_Print")
            If blnCheckEventCall = True Then
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************   
                'Code Modified to replace shared variables with class properties. by PrasannaP - 15-JUL-2005.
                Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                ExtensionArgs.m_attachControl = m_AttControl
                ExtensionArgs.m_global = m_objGlobal
                ExtensionArgs.Cancel = blnCancelControl
                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, _
                                "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", "Before_FileControl_Print", _
                                ExtensionArgs)
                blnCancelControl = ExtensionArgs.Cancel
                m_AttControl = ExtensionArgs.m_attachControl
                m_objGlobal = ExtensionArgs.m_global

                If Not ExtensionArgs Is Nothing Then
                    ExtensionArgs = Nothing
                End If
                'Modification Ends.

                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'Call the initialize event
                Call Before_FileControl_Print(blnCancelControl, m_AttControl, m_objGlobal) 'By UmeshJ on 13 July 2007
                'CommonEngine.General.CLCP_Events_Attachments.Before_FileControl_Print(blnCancelControl, m_AttControl, m_objGlobal)
            End If
            'Addition Ends
            If blnCancelControl = False Then
                'File Upload Control
                'Commented And Added by Chakshuta H on 29th-Oct-2015
                ''CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + m_AttControl.ControlCaption + "</TD></TR>")
                ''CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + CommonFunction.HTMLControls.DrawFileControl(m_AttControl.ControlName, m_AttControl.ControlName, m_AttControl.cssClass, m_AttControl.Width, , , , , , , True) + m_AttControl.ToBeInserted + "</TD></TR>")
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + m_AttControl.ControlCaption + "</TD><td width='13%'></td></TR>") 'Modified By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "' id='TDFileControl' name='TDFileControl'>" + CommonFunction.HTMLControls.DrawFileControl(m_AttControl.ControlName, m_AttControl.ControlName, m_AttControl.cssClass, m_AttControl.Width, , , , , , , True) + m_AttControl.ToBeInserted + "</TD><td width='13%'>" + PlotAttachLink() + "</td></TR>") 'Modified By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
            End If
            m_strInsertIntoUploadFunction += m_AttControl.ToBeInsertedInUploadFunction

            'Prepare the Description object
            Call PrepareDescriptionObject()
            blnCancelControl = False
            'Code Added:RajeshB	14 October, 2004
            'Purpose: Check if event is to be raised

            blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", _
                            "Before_Description_Print")
            If blnCheckEventCall = True Then
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************   
                'Code Modified to replace shared variables with class properties. by PrasannaP - 15-JUL-2005
                Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                ExtensionArgs.m_attachControl = m_AttControl
                ExtensionArgs.m_global = m_objGlobal
                ExtensionArgs.Cancel = blnCancelControl
                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, _
                            "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", "Before_Description_Print", _
                            ExtensionArgs)
                blnCancelControl = ExtensionArgs.Cancel
                m_AttControl = ExtensionArgs.m_attachControl
                m_objGlobal = ExtensionArgs.m_global

                If Not ExtensionArgs Is Nothing Then
                    ExtensionArgs = Nothing
                End If
                'Modification Ends.

                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'Call the initialize event
                Call Before_Description_Print(blnCancelControl, m_AttControl, m_objGlobal) 'By UmeshJ on 13 July 2007
                'CommonEngine.General.CLCP_Events_Attachments.Before_Description_Print(blnCancelControl, m_AttControl, m_objGlobal)
            End If
            'addition ends
            If blnCancelControl = False Then
                'Commented And Added by Chakshuta H on 29th-Oct-2015
                ''CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + m_AttControl.ControlCaption + "</TD></TR>")
                ''CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + CommonFunction.HTMLControls.DrawTextBox(m_AttControl.ControlName, m_AttControl.ControlName, m_AttControl.cssClass, m_AttControl.Width, m_AttControl.MaxLength, m_AttControl.Value, , , , , , , m_AttControl.OtherProperties, True) + m_AttControl.ToBeInserted + "</TD>")
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + m_AttControl.ControlCaption + "</TD><td width='13%'></td></TR>") 'Modified By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'  id='TDFileDescription' name='TDFileDescription'>" + CommonFunction.HTMLControls.DrawTextBox(m_AttControl.ControlName, m_AttControl.ControlName, m_AttControl.cssClass, m_AttControl.Width, m_AttControl.MaxLength, m_AttControl.Value, , , , , , , m_AttControl.OtherProperties, True) + m_AttControl.ToBeInserted + "</TD><td width='13%'></td>") 'Modified By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
                'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
                CommonFunction.General.WriteHTML("</TR>")
            End If
            m_strInsertIntoUploadFunction += m_AttControl.ToBeInsertedInUploadFunction

            'Prepare After control print object
            Call PrepareAfterUIPrintObject()
            blnCancelControl = False

            'Code Added:RajeshB	14 October, 2004
            'Purpose: Check if event is to be raised

            blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", _
                                "After_UI_Print")
            If blnCheckEventCall = True Then
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************   
                'Code Modified to replace shared variables with class properties. by PrasannaP - 15-JUL-2005
                Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                ExtensionArgs.m_attachControl = m_AttControl
                ExtensionArgs.m_global = m_objGlobal
                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, _
                                "ProjectByNet.CommonEngine.General.CLCP_Events_Attachments", _
                                "After_UI_Print", _
                                ExtensionArgs)

                m_AttControl = ExtensionArgs.m_attachControl
                m_objGlobal = ExtensionArgs.m_global

                If Not ExtensionArgs Is Nothing Then
                    ExtensionArgs = Nothing
                End If
                'Modification Ends


                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'After plotting the controls call the after print event
                Call After_UI_Print(m_AttControl, m_objGlobal) 'By UmeshJ on 13 July 2007
                'CommonEngine.General.CLCP_Events_Attachments.After_UI_Print(m_AttControl, m_objGlobal)
            End If
            'addition ends.
            CommonFunction.General.WriteHTML(m_AttControl.ToBeInserted)
            m_strInsertIntoUploadFunction += m_AttControl.ToBeInsertedInUploadFunction

            CommonFunction.General.WriteHTML("</Table>")
            CommonFunction.General.WriteHTML("</div><BR>")
            'Added By Chakshuta H on 29th-Oct-2015
            'Added By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
                PlotGrid_UploadedFiles()
            End If
            'End Addition By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

            'Ended By Chakshuta H on 29th-Oct-2015

        End If
        'Code Added:RajeshB 31 Jan 2005
        m_blnRefreshScript = m_Att.RefreshScript
        'Addition Ends
        'Destroy the object
        m_Att = Nothing
        m_AttControl = Nothing
    End Sub
    'Added By Chakshuta H on 29th-Oct-2015
    'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
    Private Function PlotAttachLink() As String
        '=====================================================================
        ' Procedure Name        : PlotAttachLink
        ' Purpose               : Plot the Attach link 
        ' Description           : Add line in grid of attached files
        ' Returns               : Attach link defination
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NinadP
        ' Created               : Feb 18, 2008   
        ' Req ID                : WAF3_PB_61 - Upload Multiple Attachment at one time
        ' Revisions             :
        '=====================================================================
        If Not (Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1) Then Return ""
        Dim strlink As String
        Dim blnCancel As Boolean = False
        strlink = "|<a class='Menu' id='lnkAttach_File' name='lnkAttach_File' href='#' onclick='JavaScript:Attach_File_OnClick()' title='" + strATTACH_LINK_TITLE + "'><b>&nbsp;" + strATTACH_LINK + "&nbsp;</b></a>|" 'Modified By Ninad 22 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        Before_PlotAttachLink(blnCancel, strlink)
        If Not blnCancel Then
            Return strlink
        End If
        Return ""
    End Function
    Protected Overridable Sub Before_PlotAttachLink(ByRef Cancel As Boolean, ByRef strlink As String)
    End Sub
    Private Sub PlotGrid_UploadedFiles()
        '=====================================================================
        ' Procedure Name        : PlotGrid_UploadedFiles
        ' Purpose               : Plot the grid to show list of uploaded files
        ' Description           : uses GenericGrid class
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NinadP
        ' Created               : Feb 18, 2008   
        ' Req ID                : WAF3_PB_61 - Upload Multiple Attachment at one time
        ' Revisions             :
        '=====================================================================
        Dim strSQLQuery As String
        Dim arrstrActualList() As String = {"FileName", "Description", ""}
        Dim arrstrUserFriendlyList() As String = {strCOL_CAPTION_FILE_NAME, strCOL_CAPTION_DESCRIPTION, strCOL_CAPTION_DELETE}
        Dim arrstrCheckboxID() As String = {"", "", "chkDelete"}
        Dim arrstrTDStyle() As String = {"", "", ""}
        Dim arrRowLink() As String = {"", "", ""}
        With m_objGrid
            .ColNameToolTipOnEachRow = True
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = 1
            .PrimaryKey = ""
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "left"
            .SortBy = ""
            .SortOrder = ""
            .ClientSideSortFunctionName = ""
            .RowLinkArray = arrRowLink
            .SQL = "Select '1' as FileName where 1=2"
            .DIVHeight = 125
            .UseSQL = True
            .TDStyleArray = arrstrTDStyle
            .DrawGrid()
        End With
    End Sub
    Protected Overridable Sub Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.TableStyle = " id='tblFileGrid' name='tblFileGrid' cellpadding=0 cellspacing=1 "
    End Sub
    Protected Overridable Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName.ToUpper = strCOL_CAPTION_DELETE.ToUpper Then
            Args.Alignment = "Center width='10%'"
        End If
        If Args.ColumnName.ToUpper = strCOL_CAPTION_DESCRIPTION.ToUpper Then
            Args.Alignment += " width='50%'"
        End If
        If Args.ColumnName.ToUpper = strCOL_CAPTION_FILE_NAME.ToUpper Then
            Args.Alignment += " width='40%'"
        End If
    End Sub
    Private Sub PlotPageNote()
        '=====================================================================
        ' Procedure Name        :	PlotPageNote
        ' Purpose               :	Plot the Page Legends, to show maximum no of attachment allow to upload
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	15 Feb 2008
        ' Revisions             :
        '=====================================================================

        m_cObjHeaderFooter = New WebPage.Templates.HeaderFooter
        With m_cObjHeaderFooter
            .DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
            Dim srtTempAssembly As String = MyBase.ResourceAssemblyName
            Dim srtTempResource As String = MyBase.ResourceName
            MyBase.InitializeResources("Resources.PB_AttachmentTab", "Resources")
            strATTACH_LINK = MyBase.GetResourceString("ATTACH_LINK")
            strATTACH_LINK_TITLE = MyBase.GetResourceString("ATTACH_LINK_TITLE")
            strCOL_CAPTION_FILE_NAME = MyBase.GetResourceString("COL_CAPTION_FILE_NAME")
            strCOL_CAPTION_DELETE = MyBase.GetResourceString("COL_CAPTION_DELETE")
            strDELETE_TITLE = MyBase.GetResourceString("DELETE_TITLE")
            strCOL_CAPTION_DESCRIPTION = MyBase.GetResourceString("COL_CAPTION_DESCRIPTION")
            .HeaderFooter = MyBase.GetResourceString("MSG_NUMBER_OF_ATTACHMENTS_ALLOWED").Replace("<NOOFATTACHMENT>", m_intNoOfAttachmentAllowed.ToString)
            'Restore resources
            MyBase.InitializeResources(srtTempResource, srtTempAssembly)
        End With
        Response.Write("<BR>")
        Response.Write(m_cObjHeaderFooter.DrawHeaderFooter(m_objGlobal))
        'Destroy the object
        m_cObjHeaderFooter = Nothing
    End Sub
    'End Addition By Ninad on 7 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

    'Ended By Chakshuta H on 29th-Oct-2015

    Private Sub PrepareAttachmentUIObject()
        '=====================================================================
        ' Procedure Name        :	PrepareAttachmentUIObject
        ' Purpose               :	Prepare Attachment UI Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 18, 2004
        ' Revisions             :   Width Modified 100 to 99.9 by PrasannaP on 30th May 2005. IssueID 28888
        '=====================================================================
        With m_Att
            .clsTable = "clsTable"
            'Added By Chakshuta H on 29th-Oct-2015
            'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
                .DIVHeight = 80
            Else
                .DIVHeight = 120
            End If
            'End Addition By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            'Ended By Chakshuta H on 29th-Oct-2015
            .DIVID = DIV_TAG
            .DIVStyle = "OVERFLOW:auto; WIDTH:99.9%"
            .TableStyle = "cellspacing=0"
            .TableWidth = "100%"
            'Code Added:RajeshB         31 Jan 2005
            .RefreshScript = True
            'Addition Ends.
        End With
    End Sub

    Private Sub PrepareFileControlObject()
        '=====================================================================
        ' Procedure Name        :	PrepareFileControlObject
        ' Purpose               :	Prepare File Control Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        With m_AttControl
            .ControlCaption = "<B>" + MyBase.GetResourceString("SELECT_FILE") + "</B>"
            .clsTR = "clsTREven"
            .TRAlign = "Left"
            'Added By Chakshuta H on 29th-Oct-2015
            'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
                .ControlName = CommonFunction.Constants.ATTACHMENT_FILE_CONTROL_NAME + "1"
            Else
                .ControlName = CommonFunction.Constants.ATTACHMENT_FILE_CONTROL_NAME
            End If
            'End Addition By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

            'Ended By Chakshuta H on 29th-Oct-2015
            .cssClass = "clsFileControl"
            .Width = 70
            .ToBeInserted = ""
            .ToBeInsertedInUploadFunction = ""
        End With
    End Sub

    Private Sub PrepareDescriptionObject()
        '=====================================================================
        ' Procedure Name        :	PrepareDescriptionObject
        ' Purpose               :	Prepare Description Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        With m_AttControl
            .ControlCaption = "<B>" + MyBase.GetResourceString("ATTACHED_DESCRIPTION") + "</B>"
            .clsTR = "clsTREven"
            .TRAlign = "Left"
            'Added By Chakshuta H on 29th-Oct-2015
            'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
                .ControlName = CommonFunction.Constants.ATTACHMENT_DESCRIPTION_CONTROL_NAME + "1"
            Else
                .ControlName = CommonFunction.Constants.ATTACHMENT_DESCRIPTION_CONTROL_NAME
            End If
            'End Addition By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            'Ended By Chakshuta H on 29th-Oct-2015
            .cssClass = "clsTextBox"
            .Width = 530
            'Commeted & Added By Chetan M On 29th July 2020 For Maxlength of Description
            '.MaxLength = 500
            .MaxLength = 50
            'Commeted & Added By Chetan M On 29th July 2020 For Maxlength of Description
            .ToBeInserted = ""
            .ToBeInsertedInUploadFunction = ""
            .Value = ""
            .OtherProperties = ""
        End With
    End Sub

    Private Sub PrepareAfterUIPrintObject()
        '=====================================================================
        ' Procedure Name        :	PrepareAfterUIPrintObject
        ' Purpose               :	Prepare After UI Print Object 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 18, 2004
        ' Revisions             :
        '=====================================================================
        With m_AttControl
            .ControlCaption = ""
            .clsTR = "clsTREven"
            .TRAlign = "Left"
            .ControlName = ""
            .cssClass = ""
            .Width = 0
            .MaxLength = 0
            .ToBeInserted = ""
            .ToBeInsertedInUploadFunction = ""
            .Value = ""
            .OtherProperties = ""
        End With
    End Sub

    Private Sub CreateHiddenParameters()
        '=====================================================================
        ' Procedure Name        :	CreateHiddenParameters
        ' Purpose               :	Create hidden Controls to hold the parameter 
        '                           values for which state needs to be persisted
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        ' Modified By           :   PushkarK On - Friday, June 16, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006
        ' Modification          :   For netscape compatibility added Id for the hidden controls.
        '=====================================================================
        'hidden Controls to hold the parameter values 
        Response.Write("<INPUT type=hidden ID='MasterTagID' name='MasterTagID' value='" + CommonFunction.General.CheckIsNothing(Request("MasterTagID")) + "'>")
        Response.Write("<INPUT type=hidden ID='ParentTagID' name='ParentTagID' value='" + CommonFunction.General.CheckIsNothing(Request("ParentTagID")) + "'>")
        Response.Write("<INPUT type=hidden ID='FromWhere' name='FromWhere' value='" + m_objGlobal.FromWhere + "'>")
        Response.Write("<INPUT type=hidden ID='ForeignKeyValue' name='ForeignKeyValue' value='" + CommonFunction.General.CheckIsNothing(Request("ForeignKeyValue")) + "'>")
        Response.Write("<INPUT type=hidden ID='ForeignKey' name='ForeignKey' value='" + CommonFunction.General.CheckIsNothing(Request("ForeignKey")) + "'>")
        '==========================================================================================================
        'Added By NinadP :	13 Feb 2007 : Requirement Tag - WAF3_PB_33 
        Response.Write("<INPUT type=hidden id='ConnectionID' name='ConnectionID' value='" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "'>")
        'to refresh parent page, if it is inherited one
        Response.Write("<INPUT type=hidden id='strFormPageName' name='strFormPageName' value='" + CommonFunctions.General.CheckIsNothing(Request("strFormPageName")) + "'>")
        'Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Added By Chakshuta H on 29th-Oct-2015
        If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then Response.Write("<INPUT type=hidden id='NoOfAttachmentAllowed' name='NoOfAttachmentAllowed' value='" + m_intNoOfAttachmentAllowed.ToString + "'>") 'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
        'Ended By Chakshuta H on 29th-Oct-2015

    End Sub

    Private Sub WriteClientsideScript()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript
        ' Purpose               :	Write Clientside Script
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        'Added By Chakshuta H on 29th-Oct-2015
        'Added By Ninad 15 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
            If CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_objGlobal.TagID).ShowNavigationAlert Then
                Response.Write(vbCrLf + "window.onbeforeunload = confirmExit;")
                Response.Write(vbCrLf + "var blnShowNavigationAlert = true;")
                Response.Write(vbCrLf + "var strContainerDivs = '" + DIV_TAG + "';")
            End If
        End If
        Response.Write(vbCrLf + "blnNavigate = null;")
        'End Addition By Ninad 15 May 2008, Req ID - WAF3_PB_64 - - Show Navigation Alert
        'Ended By Chakshuta H on 29th-Oct-2015
        Response.Write(vbCrLf + "   var objfrm;")
        Response.Write(vbCrLf + "   var objdivlist;")
        Response.Write(vbCrLf + "   var objFile =GetObjectReference('" + FORM_NAME + "','fileAttach');")
        Response.Write(vbCrLf + "   objfrm = GetFormReference('" + FORM_NAME + "')")
        Response.Write(vbCrLf + "   objdivlist=GetObjectReference('" + FORM_NAME + "','" + DIV_TAG + "')" + vbCrLf)
        'Added By Chakshuta H on 29th-Oct-2015
        'Added By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
        If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 And HttpContext.Current.Request("Mode") <> CommonFunction.Constants.MODE_ATTACH Then
            Response.Write(vbCrLf + "var attachmentNo=1;")
            Response.Write(vbCrLf + "var NumberOfAttachment;")
            Response.Write(vbCrLf + "var table =  document.getElementById('tblFileGrid');")
            Response.Write(vbCrLf + "if(navigator.appName == 'Microsoft Internet Explorer')")
            Response.Write(vbCrLf + vbTab + "NumberOfAttachment=table.rows.length-2; ")
            Response.Write(vbCrLf + "else")
            Response.Write(vbCrLf + vbTab + "NumberOfAttachment=table.rows.length-1; ")
            WriteClientsideScript_Attach_File_OnClick()
            WriteClientsideScript_Delete_File_OnClick()
        End If
        'End Addition By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

        'Ended By Chakshuta H on 29th-Oct-2015

        'Window_OnResize and Window_OnReload
        Call WriteClientsideScript_WindowOnload_Resize()
        'Attach onlick
        Call WriteClientsideScript_Attach_Onclick()
        'Close onclick
        Call WriteClientsideScript_Close_Onclick()
        'WAF3_PB_35
        If CType(CommonFunction.General.GetApplicationKeySetting("Environment"), String) = "P" Then Response.Write(vbCrLf + "disableRightClick();")
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
    End Sub

    Private Sub WriteClientsideScript_WindowOnload_Resize()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_WindowOnload_Resize
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :
        '=====================================================================
        Dim intHeightFactor As Integer = 55

        CommonFunction.General.WriteHTML("//window resize for Common Page" + vbCrLf)
        CommonFunction.General.WriteHTML("	function window_onresize()")
        CommonFunction.General.WriteHTML("	{")
        'Added By Chakshuta H on 29th-Oct-2015
        If Not (Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1) Then 'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

            'Ended By Chakshuta H on 29th-Oct-2015
            CommonFunction.General.WriteHTML("		var intDivHeight ;")
            CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
            CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
            CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
            CommonFunction.General.WriteHTML("			intDivHeight = 100;")
            CommonFunction.General.WriteHTML("				")
            'Modified by Miiint on 16-Feb-2015 to append px to height
            'CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
            CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight + 'px';")
            CommonFunction.General.WriteHTML("	}")
        End If
        CommonFunction.General.WriteHTML("	//window onload for Common list" + vbCrLf)
        CommonFunction.General.WriteHTML("	function window_onload()")
        CommonFunction.General.WriteHTML("	{")
        'Added By Chakshuta H on 29th-Oct-2015
        If Not (Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1) Then 'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
            'Ended By Chakshuta H on 29th-Oct-2015
            CommonFunction.General.WriteHTML("		var intDivHeight ;")
            CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
            CommonFunction.General.WriteHTML("		var lc;")
            CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
            CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
            CommonFunction.General.WriteHTML("			intDivHeight = 100;")
            'Modified by Miiint on 16-Feb-2015 to append px to height
            'CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
            CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight + 'px';")
            'Added By Chakshuta H on 29th-Oct-2015
        End If
        'Added By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
        If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
            If HttpContext.Current.Request("Mode") <> CommonFunction.Constants.MODE_ATTACH Then
                Response.Write(vbCrLf + "window.resizeTo(650,320);" & vbCrLf)
            Else
                Response.Write(vbCrLf + "window.resizeTo(650,200);" & vbCrLf)
            End If
        End If
        'End Addition By Ninad on 18 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

        'Ended By Chakshuta H on 29th-Oct-2015

        CommonFunction.General.WriteHTML("	}")
    End Sub

    Private Sub WriteClientsideScript_Attach_Onclick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Attach_Onclick
        ' Purpose               :	Write Clientside Script for Attach onclick
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML(vbCrLf + "function " + FUNCTION_ATTACH_ONCLICK + " { ")
        'Commented And Added by Chakshuta H on 29th-Oct-2015
        ''CommonFunction.General.WriteHTML("  if (disallowBlank(objFile,'" + MyBase.GetResourceString("FILE_SELECT_MSG") + "')) { return; }")
        ''CommonFunction.General.WriteHTML("  if (disallowSpecialCharacters(objFile,'" + MyBase.GetResourceString("FILE_HASH_NOT_ALLOWED") + "',true,'#')) { return; }")

        ' ''2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 START
        ''CommonFunction.General.WriteHTML("  if (disallowFileNameLengthGreaterThanMax(objFile,150,'" + Replace(MyBase.GetResourceString("DISALLOW_FILENAME_MAX_LENGTH_VIOLATION"), "[MAX_LENGTH]", "150") + "',true)) { return; }")
        ' ''2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 END
        'Added By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time
        If Not m_blnIsSingleRecordAttachmentTab And m_intNoOfAttachmentAllowed > 1 Then
            CommonFunction.General.WriteHTML(vbCrLf)
            'CommonFunction.General.WriteHTML("debugger;")
            CommonFunction.General.WriteHTML("if (NumberOfAttachment==0)")
            CommonFunction.General.WriteHTML(vbCrLf)
            'Added By Bharat T on 11th-Oct-2015
            Dim intParentTagID As Integer
            intParentTagID = Request.QueryString("ParentTagID")
            If m_objGlobal.TagID.ToString = "1029" Or m_objGlobal.TagID.ToString = "23" Then
                CommonFunction.General.WriteHTML("if (ValidateExtension() == false) return;")
            Else
                'Modified(added minfilesize parameter) By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
                CommonFunction.General.WriteHTML("if (ValidateFileExtensions(" + FORM_NAME + ",'fileAttach','" + m_strExtensionList + "','" + m_strMinFileSize + "') == false) return;")
                'End of Modified By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
            End If

            'End of Added By Bharat T on 11th-Oct-2015
            CommonFunction.General.WriteHTML("{")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("alert('" + MyBase.GetResourceString("FILE_SELECT_MSG") + "');")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("GetObjectReference('frmAttachment','fileAttach' + attachmentNo).focus();")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("return;")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("}")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("objFile=GetObjectReference('frmAttachment','fileAttach' + attachmentNo);")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("var objDesc = document.getElementById('txtDescription' + attachmentNo);")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("objFile.parentNode.removeChild(objFile);")
            CommonFunction.General.WriteHTML(vbCrLf)
            CommonFunction.General.WriteHTML("objDesc.parentNode.removeChild(objDesc);")
            CommonFunction.General.WriteHTML(vbCrLf)
        Else
            'Added By Nilesh G on 5th-Oct-2015
            Dim intParentTagID As Integer
            intParentTagID = Request.QueryString("ParentTagID")
            If m_objGlobal.TagID.ToString = "1029" Or m_objGlobal.TagID.ToString = "23" Then
                CommonFunction.General.WriteHTML("if (ValidateExtension() == false) return;")
            Else
                'Modified(added minfilesize parameter) By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
                CommonFunction.General.WriteHTML("if (ValidateFileExtensions(" + FORM_NAME + ",'fileAttach','" + m_strExtensionList + "','" + m_strMinFileSize + "') == false) return;")
                'End of Modified(added minfilesize parameter) By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
            End If

            'End of Added By Nilesh G on 5-Oct-2015
            CommonFunction.General.WriteHTML("  if (disallowBlank(objFile,'" + MyBase.GetResourceString("FILE_SELECT_MSG") + "')) { return; }")
            CommonFunction.General.WriteHTML("  if (disallowSpecialCharacters(objFile,'" + MyBase.GetResourceString("FILE_HASH_NOT_ALLOWED") + "',true,'#')) { return; }")
            '2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 START
            CommonFunction.General.WriteHTML("  if (disallowFileNameLengthGreaterThanMax(objFile,150,'" + Replace(MyBase.GetResourceString("DISALLOW_FILENAME_MAX_LENGTH_VIOLATION"), "[MAX_LENGTH]", "150") + "',true)) { return; }")
            '2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 END
        End If
        'End Addition By Ninad on 20 Feb 2008, Req ID WAF3_PB_61 - Upload Multiple Attachment at one time

        'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
        If m_strInsertIntoUploadFunction.Trim <> "" Then CommonFunction.General.WriteHTML(m_strInsertIntoUploadFunction)
        'Code Modified:RajeshB  31 Jan 2005
        'Refresh parent configurability
        Dim strRefreshValue As String = "1"
        If HttpContext.Current.Request("Mode") = "ADD_NEW" And m_blnRefreshScript = False Then
            strRefreshValue = "0"
        End If
        ' Added by Archanan on 1-Oct-2010
        'If m_strExtensionList <> "" Then
        '    'Modified(added minfilesize parameter) By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
        '    CommonFunction.General.WriteHTML("if (ValidateFileExtensions(" + FORM_NAME + ",'fileAttach','" + m_strExtensionList + "','" + m_strMinFileSize + "')==false)")
        '    'End of Modified(added minfilesize parameter) By Bharat Tekade on 30th-July-2016 for read the file extensions from web.config file
        '    CommonFunction.General.WriteHTML("return;")
        'End If
        ' End of Added by Archanan on 1-Oct-2010

        'WAF3_PB_39 - Hide the Upload link
        CommonFunction.General.WriteHTML("objSNAtt = GetObjectReference('" + FORM_NAME + "','upldT');if (objSNAtt != null){objSNAtt.style.display='none';}")
        CommonFunction.General.WriteHTML("objSNAtt = GetObjectReference('" + FORM_NAME + "','upldB');if (objSNAtt != null){objSNAtt.style.display='none';}")

        'Changed By NileshD on 21 June 2005
        'CommonFunction.General.WriteHTML("	objfrm.action=""CLCP_Attachment.aspx?Mode=" + CommonFunction.Constants.MODE_ATTACH + "&RefreshScript=" + strRefreshValue + m_strParentTagQuerystringDefaultParameters + """;")
        'CommonFunction.General.WriteHTML("	objfrm.action=""" + strAttachmentPage + "?Mode=" + CommonFunction.Constants.MODE_ATTACH + "&RefreshScript=" + strRefreshValue + m_strParentTagQuerystringDefaultParameters + """;")

        'Commented And Added By Usha Pandit On 16.08.2020 For attachment Refresh issue
        'CommonFunction.General.WriteHTML("	objfrm.action=""" + strAttachmentPage + "?Mode=" + CommonFunction.Constants.MODE_ATTACH + m_strParentTagQuerystringDefaultParameters + """;")
        CommonFunction.General.WriteHTML("	objfrm.action=""" + strAttachmentPage + "?Mode=" + CommonFunction.Constants.MODE_ATTACH + m_strParentTagQuerystringDefaultParameters + "&RefreshScript=1"";")
        'End Of Added By Usha Pandit On 16.08.2020 For attachment Refresh issue

        'End OF changed By NileshD on 21 June 2005

        'Modification Ends
        'Added By Chakshuta H on 29th-Oct-2015
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then CommonFunction.General.WriteHTML(vbCrLf + "blnNavigate = false;" + vbCrLf) 'Added By Ninad 19 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        'Ended By Chakshuta H on 29th-Oct-2015

        CommonFunction.General.WriteHTML("	objfrm.submit();")
        CommonFunction.General.WriteHTML("	}")
    End Sub
    'Added By Chakshuta H on 29th-Oct-2015

    Private Sub WriteClientsideScript_Attach_File_OnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Attach_File_OnClick
        ' Purpose               :	Write Clientside Script for Attach_File_OnClick
        ' Description           :	Attach the file to upload, add entry to grid
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	19 Feb 2008
        ' Revisions             :
        '=====================================================================
        Dim sbAttach_File_OnClick As New System.Text.StringBuilder()
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("function Attach_File_OnClick()")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("{")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var NumberOfAttachmentAllowed = document.getElementById('NoOfAttachmentAllowed').value;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if (NumberOfAttachment==NumberOfAttachmentAllowed)")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("return;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objFile=GetObjectReference('frmAttachment','fileAttach' + attachmentNo);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("  if (disallowBlank(objFile,'" + MyBase.GetResourceString("FILE_SELECT_MSG") + "')) { return; }")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("  if (disallowSpecialCharacters(objFile,'" + MyBase.GetResourceString("FILE_HASH_NOT_ALLOWED") + "',true,'#')) { return; }")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("  if (disallowFileNameLengthGreaterThanMax(objFile,150,'" + Replace(MyBase.GetResourceString("DISALLOW_FILENAME_MAX_LENGTH_VIOLATION"), "[MAX_LENGTH]", "150") + "',true)) { return; }")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var objDesc = document.getElementById('txtDescription' + attachmentNo);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if (NumberOfAttachment==0)")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("{")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if(navigator.appName == 'Microsoft Internet Explorer')")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("table.rows(1).style.display = 'none';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("else")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("table.rows[0].style.display = 'none';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("}")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var row = table.insertRow(table.rows.length);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var cell = row.insertCell(row.cells.length);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var fileName = objFile.value;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var index = fileName.lastIndexOf('\\');")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if (index==-1)")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("index = fileName.lastIndexOf('/');")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if (index != -1)")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("fileName = fileName.substring(index+1,fileName.length);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell.innerHTML = fileName;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell.align='left';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell = row.insertCell(row.cells.length);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell.innerHTML = objDesc.value;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell.align='left';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell = row.insertCell(row.cells.length);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell.innerHTML = ""<a style='text-decoration:underline; cursor:hand;' onClick='JavaScript:Delete_File_OnClick(this,""+ attachmentNo +"")' title='" + strDELETE_TITLE + "'>" + strCOL_CAPTION_DELETE + "</a>"";")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("cell.align='center';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if ((table.rows.length % 2) == 0)")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("row.className='clsTREven';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("else")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("row.className='clsTROdd';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("attachmentNo = parseInt(attachmentNo) + 1;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("NumberOfAttachment = parseInt(NumberOfAttachment) + 1;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var objFileClone = objFile.cloneNode(true);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objFileClone.name='fileAttach' + attachmentNo;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objFileClone.id='fileAttach' + attachmentNo;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("var objDescriptionClone = objDesc.cloneNode(true);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objDescriptionClone.name='txtDescription' + attachmentNo;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objDescriptionClone.id='txtDescription' + attachmentNo;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objDescriptionClone.value='';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("document.getElementById('TDFileControl').appendChild(objFileClone);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("document.getElementById('TDFileDescription').appendChild(objDescriptionClone);")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objFile.style.display = 'none';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objDesc.style.display = 'none';")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("if (NumberOfAttachment==NumberOfAttachmentAllowed)")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("{")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objFileClone.disabled=true;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("objDescriptionClone.disabled=true;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("document.getElementById('lnkAttach_File').disabled=true;")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("}")
        sbAttach_File_OnClick.Append(vbCrLf)
        sbAttach_File_OnClick.Append("}")
        sbAttach_File_OnClick.Append(vbCrLf)
        Dim strScript As String = sbAttach_File_OnClick.ToString
        Before_WriteClientsideScript_Attach_File_OnClick(strScript)
        Response.Write(strScript)
        sbAttach_File_OnClick = Nothing
    End Sub
    Protected Overridable Sub Before_WriteClientsideScript_Attach_File_OnClick(ByRef strClientsideScript_Attach_File_OnClick As String)
    End Sub
    Private Sub WriteClientsideScript_Delete_File_OnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Delete_File_OnClick
        ' Purpose               :	Write Clientside Script for Delete_File_OnClick
        ' Description           :	Delete the Attached file, delete entry from grid
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	19 Feb 2008
        ' Revisions             :
        '=====================================================================
        Dim sbDelete_File_OnClick As New System.Text.StringBuilder()
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("function Delete_File_OnClick(obj,index)")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("{")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("obj.parentNode.parentNode.parentNode.removeChild(obj.parentNode.parentNode);")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("objFile=GetObjectReference('frmAttachment','fileAttach' + index);")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("var objDesc = document.getElementById('txtDescription' + index);")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("objFile.parentNode.removeChild(objFile);")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("objDesc.parentNode.removeChild(objDesc);")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("NumberOfAttachment = parseInt(NumberOfAttachment) - 1;")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("if (NumberOfAttachment<document.getElementById('NoOfAttachmentAllowed').value && document.getElementById('fileAttach' + attachmentNo).disabled==true)")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("{")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("document.getElementById('fileAttach' + attachmentNo).disabled=false;")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("document.getElementById('txtDescription' + attachmentNo).disabled=false;")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("document.getElementById('lnkAttach_File').disabled=false;")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("}")
        sbDelete_File_OnClick.Append(vbCrLf)


        sbDelete_File_OnClick.Append("if (NumberOfAttachment==0)")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("{")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("if(navigator.appName == 'Microsoft Internet Explorer')")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("table.rows(1).style.display = '';")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("else")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("table.rows[0].style.display = '';")
        sbDelete_File_OnClick.Append(vbCrLf)
        sbDelete_File_OnClick.Append("}")
        sbDelete_File_OnClick.Append(vbCrLf)


        sbDelete_File_OnClick.Append("}")
        sbDelete_File_OnClick.Append(vbCrLf)
        Dim strScript As String = sbDelete_File_OnClick.ToString
        Before_WriteClientsideScript_Delete_File_OnClick(strScript)
        Response.Write(strScript)
        sbDelete_File_OnClick = Nothing
    End Sub
    Protected Overridable Sub Before_WriteClientsideScript_Delete_File_OnClick(ByRef strClientsideScript_Delete_File_OnClick As String)
    End Sub
    'Ended By Chakshuta H on 29th-Oct-2015

    Private Sub GetQueryStringDefaultParametersForParentTag()
        '=====================================================================
        ' Procedure Name        :	GetQueryStringDefaultParametersForParentTag
        ' Purpose               :	Get the Master Tags Default Query string Filter parameters while refreshing the master page
        ' Description           :	Get the Master Tags Default Query string Filter parameters while refreshing the master page
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	July 05, 2004
        ' Revisions             :   IssueID 12044
        '=====================================================================
        m_strParentTagQuerystringDefaultParameters = CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
    End Sub

    Private Sub WriteClientsideScript_Close_Onclick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Close_Onclick
        ' Purpose               :	Write Clientside Script for Close onclick
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 16, 2004
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_CLOSE_ONCLICK + " {")
        CommonFunction.General.WriteHTML("	window.close();")
        CommonFunction.General.WriteHTML("	}")
    End Sub

    Private Sub MemoryCleanUp()
        '=====================================================================
        ' Procedure Name        :	MemoryCleanUp
        ' Purpose               :	Remove the unused objects from the memory
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Destroy the exists objects
        If Not m_objGlobal Is Nothing Then m_objGlobal = Nothing
        If Not m_objSubTagCLSQL Is Nothing Then m_objSubTagCLSQL = Nothing
    End Sub

    Public Sub New()
        'Common Page Resource File
        MyBase.InitializeResources("Resources.CommonPage", "Resources")
    End Sub
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'WAF3_PB_39
        If Args.FunctionName = FUNCTION_ATTACH_ONCLICK Then
            'Hide Upload link on click
            If m_blnTopLinkPlotted = False Then
                Args.StringToBeInserted = "<Span id='upldT'>"
                m_blnTopLinkPlotted = True
            Else
                Args.StringToBeInserted = "<Span id='upldB'>"
            End If
        End If
    End Sub
    Private Sub m_objMenu_After_Link_Print(ByRef Args As WAF_Menu_Links) Handles m_objMenu.After_Link_Print
        'WAF3_PB_39
        If Args.FunctionName = FUNCTION_ATTACH_ONCLICK Then Args.StringToBeInserted = "</Span>"
    End Sub
End Class