
Imports System.IO
Imports CommonFunctions
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class TCM_Attachment
    Inherits WebPages.Template.WhizTemplate

    Protected m_strTestSetID As String = ""
    Protected m_strFileName As String = ""
    Protected m_intProjectID As Long = 0
    Protected m_strPKToken As String = ""

    Protected m_strFromWhere As String = ""
    Protected m_strAction As String = ""

    Protected m_strMode As String = ""
    Protected m_strID As String = ""
    Private m_blnUseSQL As Boolean
    Protected m_lngMaxLength As Long = 100
    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
    Protected m_strExtensionList As String = ""
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
        'Call Initialize()
        'If Page.IsPostBack Then
        '    Call PerformActions()
        'End If

    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        Call Initialize()

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
    Public Shared Function ReadAllBytes(fileName As String) As Byte()
        Dim buffer As Byte() = Nothing
        Using fs As New FileStream(fileName, FileMode.Open, FileAccess.Read)
            buffer = New Byte(256) {}
            fs.Read(buffer, 0, 256)
        End Using
        Return buffer
    End Function
    'End of Added By Bharat Tekade on 30th-Jun-2016 for sem enhamcement
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
        Dim strTemplateID As String
        Dim strRequestID As String


        If UCase(Trim(m_strAction & "")) = "ATTACH" Then
            Dim MimeType As String
            Dim file As HttpPostedFile = Context.Request.Files(0)
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
                ''Added by swapnil aswale on 15-06-2016
                Dim response As String = String.Empty
                Dim buffer As Byte() = New Byte(256) {}
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

            If strListofTypes.IndexOf(MimeType) >= 0 Then
                ''Ended by swapnil aswale on 15-06-2016

                ' The path 

                strPath = Server.MapPath("../../Attachments/DXU/Requests")

                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

                ' upload the file
                'Dim objFile As New FileUpload.cUpload("txtFileName", strPath, strFileName)
                'objFile.OverwriteIfExists = True
                'objFile.UploadFile()

                Dim fileSavePath As String = Path.Combine(strPath, HttpContext.Current.Request.Files(0).FileName)

                Request.Files(0).SaveAs(fileSavePath)

                ' the file name
                strOriginalFileName = HttpContext.Current.Request.Files(0).FileName
                strFileName = HttpContext.Current.Request.Files(0).FileName
                'objFile = Nothing

                strDescription = Request.Form("txtComments").ToString
                strTemplateID = Request.Form("cboTemplate").ToString
                'Create an Request Entry


                If m_strFromWhere <> "PM" Then
                    ' strSQL = " usp_Ins_TestCaseDXURequest " & Session("intUserID").ToString & "," & Session("intProjectID").ToString
                    strSQL = " usp_Ins_TestCaseDXURequest " & Session("intUserID").ToString & ",0"
                    strSQL &= ", " & strTemplateID & "," & m_strID
                Else
                    strSQL = " usp_Ins_TestCaseDXURequest " & Session("intUserID").ToString & "," & CStr(Session("intProjectID"))
                    strSQL &= ", " & strTemplateID & "," & m_strID
                End If


                strRequestID = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString()


                strSQL = "Exec usp_Ins_tbl_TCM_TestCaseAttachments " & strRequestID & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                strSQL &= ", '" & CommonFunctions.General.BuildQueryString(strFileName) & "', '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "', '" & CommonFunctions.General.BuildQueryString(strDescription) & "'"



                If Trim(strSQL & "") <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If



                Dim objRequest As New DataExchangeLib.Request
                With objRequest
                    .ConnectionString = CommonFunction.General.GetConnectionString
                    .LogFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Logs")
                    .RejectedRecordsFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/RejectedFiles")
                    .UploadedFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Requests")
                    .SpecialRequestTemplateFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU")
                    '.RequestID = HttpContext.Current.Request.Form("RequestID_PK") 'this is nothing 
                    'as Current.Request.Form is attachments form, get value from Request.Form("foreignkeyvalue")
                    .RequestID = CInt(strRequestID)
                    .Post()
                End With
                objRequest = Nothing

                'Added By VarunA on 28-Apr-2009 RequestID-20043
                'Purpose : before uploading the test case excel, it will check whether the excel is correct or not. then only will upload data while clinking on Upload.
                ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                ''strSQL = "SELECT 1 from tbl_DXU_UploadRequestsQueue WHERE RequestID = " & CInt(strRequestID) & " AND Status = 'I' AND EmployeeID = " & Session("intUserID").ToString
                strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_RequestIDAndEmployeeID " & CInt(strRequestID) & "," & Session("intUserID").ToString

                If CType(CommonFunctions.Data.CheckIsDBNull(CType(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), String), "0"), String) = "1" Then
                    strSQL = "EXEC USP_DXU_TRANSFERREQUESTDATA " & CInt(strRequestID)
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If
                'End By VarunA on 28-Apr-2009 RequestID-20043

                'CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                ''CommonFunctions.General.WriteHTML(" refreshParent('frmCommonPage','TestSet_CommonPage.aspx','TestSet_CommonPage.aspx?FocusOn=SUBTAG');")
                'CommonFunctions.General.WriteHTML(" window.close();")
                'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                Dim strScript As String

                'strScript = vbCrLf + "<Script language=javascript>"
                'strScript += vbCrLf + "    refreshParent('frmCommonPage','TestSet_CommonPage.aspx','TestSet_CommonPage.aspx?FocusOn=SUBTAG' );"
                'strScript += vbCrLf + "    window.close();"
                'strScript += vbCrLf + "</Script>"
                'CommonFunction.General.WriteHTML(strScript)
                If Not Request.QueryString("TestSetID") Is Nothing Then
                    m_strTestSetID = Request.QueryString("TestSetID").ToString
                Else
                    m_strTestSetID = "0"
                End If
                If m_strFromWhere <> "PM" Then
                    strScript = vbCrLf + "<Script language=javascript>"
                    strScript += vbCrLf + "    refreshParent('frmCommonPage','TestSet_CommonPage.aspx','TestSet_CommonPage.aspx?TestSetID_PK=" + m_strTestSetID.ToString + "&MasterTagID=3648&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1' );"
                    strScript += vbCrLf + "    window.close();"
                    strScript += vbCrLf + "</Script>"
                    CommonFunction.General.WriteHTML(strScript)
                Else
                    strScript = vbCrLf + "<Script language=javascript>"
                    strScript += vbCrLf + "    refreshParent('frmCommonPage','ProjectTestSet_CommonPage.aspx','ProjectTestSet_CommonPage.aspx?ProjectTestSetID_PK=" + m_strTestSetID.ToString + "&MasterTagID=3664&FromWhere=PM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1' );"
                    strScript += vbCrLf + "    window.close();"
                    strScript += vbCrLf + "</Script>"
                    CommonFunction.General.WriteHTML(strScript)
                End If

                'Added By Bharat Tekade on 30th-Jun-2016 for sem enhamcement
            Else
                CommonFunction.General.WriteHTML("<Script>")
                'CommonFunction.General.WriteHTML("alert('Invalid Content Type!!'); ")
                CommonFunction.General.WriteHTML("alert('Please upload valid file.'); ")
                CommonFunction.General.WriteHTML("</Script>")
            End If
            'End of Added By Bharat Tekade on 30th-Jun-2016 for sem enhamcement
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
        If Not Request.QueryString("TestSetID") Is Nothing Then
            m_strTestSetID = Request.QueryString("TestSetID").ToString
        Else
            m_strTestSetID = "0"
        End If

        If Not Request.Form("txtPkToken") Is Nothing Then
            m_strPKToken = Request.Form("txtPkToken").ToString
        End If
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        End If

        'Added by ArchanaN on 1-Oct-2010
        m_strExtensionList = CommonFunction.General.GetFileExtnListForTag("3648")
        'End of Added by ArchanaN on 1-Oct-2010


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


        Dim arrMenu() As String = {"Upload", MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {"Upload", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrCSFunction() As String = {"Attach_OnClick('" & m_strTestSetID & "','" & m_strFileName & "','0')", "Close_OnClick()"}
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
            'Commented added by Shamkant S on 28 Nov 2015
            '.Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")
            .Write("<DIV ID='divList' Style='WIDTH:100%;OVERFLOW:auto;'>")
            'Commented ended by Shamkant S
            .Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")


            If m_strFromWhere <> "PM" Then
                strTemplateSQL = " Usp_TCM_GetTemplateName 0"
            Else
                strTemplateSQL = " Usp_TCM_GetTemplateName 1"
            End If

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("" + "Select Template" + "")
            .Write("</TD>")
            .Write("<TD align=left >")
            CommonFunctions.HTMLControls.DrawComboBox("cboTemplate", strTemplateSQL, , "", , True, , , True, "../../Images/Star.gif", , 0)
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("" + "Select File" + "")
            .Write("</TD>")

            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'", , , 1)
            .Write("</TD>")
            .Write("</TR>")

            ' comments
            .Write("<TR class=clsTREven>")
            .Write("<TD>Description</TD>")
            .Write("<TD>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmTCM_Attachment", , , 450, 100, 2000, Wrap:="Hard")
            CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmTCM_Attachment", , , 450, 100, 2000, Wrap:="Hard", EnableHTMLEncode:=True)
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