Imports Whizible
Imports System.IO
Imports CommonFunctions
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Imports System.Runtime.InteropServices
Public Class FCI_Attachment
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_strPKToken As String = ""
    Protected m_strAction As String = ""
    Protected m_strMode As String = ""
    Private m_blnUseSQL As Boolean
    Protected m_lngMaxLength As Long = 100
    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
    Protected m_intTagID As Integer
    Protected m_strComments As String = ""
    Private WithEvents objReport As DynamicReports.Report
    Protected m_Batchsize As Integer = 0
    'Private m_intPageNumbertoDisp As Integer = 1
    Protected m_intTotalNoOfRows As Integer
    Protected m_intPageNumber As Integer = 1
    Private WithEvents m_objSectionTitle As New WebPages.Template.SectionTitle
    Protected m_intNoOfRows As Integer
    Protected m_blnShowGrid As Boolean
    Public m_strReturnHTML As String = ""
    Public m_objRequest As New UploadXML
    'Addded by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57606)
    Protected m_intFlag As String = "0"
    Public m_lngProjectId As Long
    'End of Addded by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57606)

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Initrole(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
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
        'MyBase.InitializeResources("Resources.StandardMenu", "Resources")

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
        ' Author                : ArchanaN
        ' Created               : 14-Jul-2010
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strPath As String
        Dim strFileName As String
        Dim strGeneratedFileName As String
        Dim strOriginalFileName As String
        Dim strRequestID As String
        'Dim strTemplateSQL As String
        Dim FileSize As String

        If UCase(Trim(Request.QueryString("Action") & "") & "") = "EXPORT" Then
            Dim IsAttributeMapped As Integer = 0
            strSQL = " EXEC  usp_Sel_tbl_FCI_ExternalSysAttribute_Mapping " & CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0").ToString
            IsAttributeMapped = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)
            If IsAttributeMapped = 1 Then
                m_strReturnHTML = "Please Map attributes to the project.."
            Else
                strPath = Server.MapPath("../../Attachments/IB/")
                ''Commented and Addded by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57606)
                'strFileName = "Issue Template"
                If m_intFlag = "1" Then
                    strFileName = "ScrumIssueTemplate"
                Else
                    strFileName = "IssueTemplate"
                End If

                ''Commented and Addded by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57606)


                strGeneratedFileName = GenerateTemplate(strSQL, strPath, strFileName)
                If strGeneratedFileName <> "" Then
                    Response.Redirect("../General/ViewAttachment.aspx?FromWhere=IB%5C&FileName=" + strGeneratedFileName, True)

                End If
            End If
        End If

        If UCase(Trim(m_strAction & "")) = "ATTACH" Then
            ' The path 

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


                strPath = Server.MapPath("../../Attachments/IB/Requests")

                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()
                strFileName &= Path.GetExtension(fileName).ToString
                Dim fileSavePath As String = Path.Combine(strPath, strFileName)
                file.SaveAs(fileSavePath)
                ' upload the file
                Dim objFile As New FileUpload.cUpload("txtFileName", strPath, strFileName)



                objFile.OverwriteIfExists = True
                'objFile.UploadFile()
                FileSize = objFile.FileSize
                ' the file name
                'strOriginalFileName = objFile.OriginalFileName
                strOriginalFileName = file.FileName
                strFileName = objFile.UploadedFileName
                objFile = Nothing
                m_strComments = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtComments"), "")

                'Create an Request Entry          
                strSQL = " usp_Ins_FCIRequest " & Session("intUserID").ToString & "," & CStr(Session("intProjectID")).ToString & ",'" & CommonFunction.General.BuildQueryString(m_strComments) & "'"

                strRequestID = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString()

                strSQL = "Exec usp_Ins_tbl_FCI_ResourceAttachments " & strRequestID & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "','" & FileSize & "'"
                strSQL &= ", '" & CommonFunctions.General.BuildQueryString(strFileName) & "', '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "'"     '" & CommonFunctions.General.BuildQueryString(strDescription) & "'"

                If Trim(strSQL & "") <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If

                ' Dim objRequest As New DataExchangeLib.Request

                With m_objRequest
                    .ConnectionString = CommonFunction.General.GetConnectionString
                    '.LogFilePath = HttpContext.Current.Server.MapPath("../../Attachments/IB/Logs")
                    .RejectedRecordsFilePath = HttpContext.Current.Server.MapPath("../../Attachments/IB/RejectedFiles")
                    .UploadedFilePath = HttpContext.Current.Server.MapPath("../../Attachments/IB/Requests/" & strFileName)
                    .RequestID = CInt(strRequestID)
                    .uploadXML()
                End With

                Dim strReqSQL As String

                Dim strScript As String
                strScript = vbCrLf + "<Script language=javascript>"
                strScript += vbCrLf + " window.location.href='../IB/FCI_Attachment.aspx?MasterTagID=8055&FromWhere=PM';"
                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)
                objFile = Nothing
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
        ' Author                : ArchanaN
        ' Created               : 14-Jul-2010
        ' Revisions             :
        '=====================================================================
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        If Not Request.Form("txtPkToken") Is Nothing Then
            m_strPKToken = Request.Form("txtPkToken").ToString
        End If
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If
        'Addded by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57606)
        If Not m_lngProjectId > 0 Then
            m_lngProjectId = CType(HttpContext.Current.Session("intProjectID"), Integer)
        End If
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_lngProjectId.ToString(), MyBase.UseSQL), String)
        'End of Addded by NitinC on 27 Dec 2011 For WhizibleSEM 11.0 - Agile Module (Issue Fix 57606)
        Exit Sub
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
        ' Author                : ArchanaN
        ' Created               : 14-Jul-2010
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strZone As String = ""

        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If

        If Request.QueryString("Action") = "DELETEDETAILS" Then
            DeleteDetails()
        End If
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'm_Batchsize = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select DXUBatchSize From tbl_PM_CompanyInformation", MyBase.UseSQL), 0)
        m_Batchsize = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_DXUBatchSize ", MyBase.UseSQL), 0)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        Dim arrMenu() As String = {"Upload", "Download Template", "Select All", "Clear All", "Delete"}
        Dim arrMenuToolTip() As String = {"Upload", "Download Template", "Select All", "Clear All", "Delete"}
        Dim arrCSFunction() As String = {"Attach_OnClick()", "Download_onclick()", "SelectAll_Onclick()", "ClearAll_Onclick()", "DeleteDetails_OnClick()"}
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write("<DIV ID='divList' Style='WIDTH:100%;OVERFLOW:none;'>")
            .Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            .Write("<TR class=clsTRPageCaption><TD align=Left>Import Issues</TD></TR></TABLE>")

            .Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            '.Write("<TR class=clsTREven><TD align=Left> Please upload only Excel files. (.xls extension files) </TD></TR></TABLE>")
            '.Write("<BR>")

            .Write("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
            .Write("<TR class=clsTRSectionHeader><TD align=Left><font color=blue><b>Note: <BR></b>1. For Excel, Date format should be 'dd-MMM-yyyy' and Time format should be 'hh:mm'.<BR>")
            .Write("2. Number of Records to be uploaded should not exceed " + m_Batchsize.ToString + ". Remaining records will be skipped.<BR>")
            .Write("3. Tasks assigned to Responsible Person will be considered as void When a) Project is ON HOLD. b) Task Efforts exceed Balance Project Efforts. c) Task Start Date and End Date is not between Resource Start Date and End Date.")
            .Write("</font></TD>")
            '.Write("<TD align=Left valign=top>")
            'WritePaging()
            '.Write("</TD>")
            .Write("</TR></TABLE>")
            .Write("<br>")

            .Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("" + "Select Excel File" + "")
            .Write("</TD>")
            .Write("<TD>")
            '//added by Parth Godshelwar onchange event for validating exe file
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onchange='validateForExe(this)' onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'", , , 1)
            'Ended by Parth Godshelwar
            .Write("</TD>")
            .Write("</TR>")




            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("Comments")
            .Write("</TD>")
            .Write("<TD>")
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , , , , 455, 35, 100, m_strComments)
            CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , , , , 455, 35, 100, m_strComments, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            .Write("</TD>")
            .Write("</TR>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("Corporate Time Zone")
            .Write("</TD>")
            .Write("<TD>")
            strSQL = "select ZoneName + ' (' + GMTZone +')' AS [ZoneName]	from dbo.tbl_FCI_TimeZoneSettings  	WITH(NOLOCK) "
            strSQL = strSQL + " INNER JOIN tbl_FCI_GMTZones  	WITH(NOLOCK)  ON tbl_FCI_TimeZoneSettings.GMTID =tbl_FCI_GMTZones.GMTID "
            strSQL = strSQL + " Where  TimeZoneID = (SElect TimeZoneID From tbl_PM_CompanyInformation ) "

            strZone = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True), "Time Zone not set at Corporate levle.")
            .Write(strZone)
            .Write("</TD>")
            '.Write("<TD>")
            '.Write("Number of Records to be uploaded &nbsp;&nbsp;" & m_Batchsize.ToString)
            '.Write("</TD>")
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
            .Write("<TABLE id=tblFileUploadStatus cellspacing=1 height='5%' Width='99.9%' class=clsTable style='visibility:visible;display:none'>")
            .Write("<TR>")
            .Write("<TD height='20'>")
            .Write("&nbsp;</TD></TR>")
            .Write("<TR><TD align=center class=clsTDEven>")
            .Write("<LABEL id=lblFileUploadStatus><B>Uploading file...Please wait !!</B></LABEL>")
            .Write("</TD></TR>")
            .Write("</TABLE>")
            .Write("<BR>")

            '.Write("<TABLE id='tblCap00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
            '.Write("<TR class=clsTRSectionHeader><TD align=Left><font color=blue><b>Note: </b>1. For Excel, Date format should be 'dd-MMM-yyyy' and Time format should be 'hh:mm'.<BR>")
            '.Write("2. Number of Records to be uploaded should not exceed " + m_Batchsize.ToString + ". Remaining records will be skipped.<BR>")
            '.Write("3. Tasks assigned to Responsible Person will be considered as void When a) Project is ON HOLD. b) Task Efforts exceed Balance Project Efforts. c) Task Start Date and End Date is not between Resource Start Date and End Date.")
            '.Write("</font></TD>")
            '.Write("<TD align=Left valign=top>")
            'WritePaging()
            '.Write("</TD>")
            '.Write("</TR></TABLE>")
            '.Write("<br>")
            '.Write("<TABLE id='tblPage00'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
            '.Write("<TR class=clsTRSectionHeader>")
            '.Write("<TD align=Left valign=top>")
            WritePaging()
            '.Write("</TD></TR></TABLE>")

            drawGrid()
            .Write("</DIV>")
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub
    Private Sub WritePaging()
        '=====================================================================
        ' Procedure Name        : WritePaging
        ' Description           : To write the paging for the request grid
        ' Purpose               : 
        ' Parameters Passed     : SQL for paging
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : ArchanaN
        ' Created               : 17-Nov-2009

        '=====================================================================
        ''Dim ds As DataSet
        ''Dim intRecordCount As Integer
        Dim strPaging As String = ""
        Dim strSectionTag As String = "divGrid"
        Dim strFunctionName As String = "ShowHide_divGrid"
        Dim PagingSQL As String
        Dim strWhere As String

        strWhere = " Where ProjectID = " & CType(Session("intProjectID"), String)

        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
            If CType(HttpContext.Current.Session("LoginType"), String) = "E" Then
                strWhere += " AND EmployeeID = " & CType(Session("intUserID"), String)
            Else
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        Else
            strWhere += " "
        End If
        PagingSQL = "Select count(1) from v_tbl_FCI_Requests_Attachments  " & strWhere
        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 15) < m_intPageNumber Then
            m_intPageNumber = 1
        End If
        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 15)).ToString + ">"
        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 15)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B> </A>"
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 15)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If m_blnShowGrid Then
            ' the section title
            Response.Write(m_objSectionTitle.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
            Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")
        Else
            ' the section title
            Response.Write(m_objSectionTitle.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , "../../images/plus.gif", , , , , , False, False))
            Response.Write("<script language=javascript>" & m_objSectionTitle.ClientsideScript & "</script>")
        End If

    End Sub
    Private Sub drawGrid()
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strWhere As String
        Dim m_dsGrid As System.Data.DataSet
        strWhere = " Where ProjectID = " & CType(Session("intProjectID"), String)
        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
            If CType(HttpContext.Current.Session("LoginType"), String) = "E" Then
                strWhere += " AND EmployeeID = " & CType(Session("intUserID"), String)

            Else
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        Else
            strWhere += " "
        End If

        If m_intPageNumber <> 0 Then
            'Added by Chakshuta H on 1st Sept 2014 for SP2 issue
            m_intPageNumber = 1
            'Ended by Chakshuta H on 1st Sept 2014 for SP2 issue
            strSQL = "Select Top " & (m_intPageNumber * 15).ToString
        Else
            strSQL = "Select "
        End If

        strSQL += " RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,FileSize,[View Rejected File],ISNULL(Comments,'')Comments,ZoneName,RejectedRecordsFilePath " _
                                     & " from v_tbl_FCI_Requests_Attachments  " & strWhere & " order by AttachedBy  ,dateAttached desc"
        m_dsGrid = CommonFunctions.Data.GetDataSet(strSQL, "default", , , Me.UseSQL)

        Dim arrColumnHeadingList() As String = {"Uploaded By", "Original File Name", "Attached Date", "File Size (in kb)", "File Status", "Comments", "Time Zone", "Delete"}
        Dim arrActualColumnNames() As String = {"AttachedBy", "OriginalFileName", "DateAttached", "FileSize", "ViewRejectedFile", "Comments", "ZoneName", ""}
        Dim arrTDStyle() As String = {"align=left style='width=10%'", "align=left width=15%", "align=left width=15%", "align=left width=8%", "align=Left width=15%", "align=left width=25%", "align=Left width=15%", "align=center width=5%"}
        Dim arrGroupColName() As String = {"Attached By"}

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15

        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 4
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivGrid"
            .DIVHeight = 215%
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = True
            .GroupOnColumn = arrGroupColName
            .PrimaryKey = "AttachmentID"
            '.SortBy = "AttachedBy,DateAttached"
            '.SortOrder = "Desc"
            .PageSize = 15
            .CurrentPage = m_intPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .DrawGrid()
        End With
        m_objGrid = Nothing
        '
    End Sub
    Private Sub DeleteDetails()
        Dim m_strRequestID As String
        Dim arrIDs() As String
        Dim lenArray As Integer
        Dim strPath As String
        Dim sysFileName As String
        strPath = Server.MapPath("../../Attachments/IB/")

        If CType(Request.Form("chkDelete"), String) <> "" Then
            m_strRequestID = CType(Request.Form("chkDelete"), String)

            arrIDs = m_strRequestID.Split(CType(",", Char))
            'Now Insert Into Table
            For lenArray = 0 To arrIDs.Length - 1

                If File.Exists(Server.MapPath("../../Attachments/IB/RejectedFiles/") & arrIDs(lenArray) & ".xls") Then
                    File.Delete(Server.MapPath("../../Attachments/IB/RejectedFiles/") & arrIDs(lenArray) & ".xls")
                End If


                If File.Exists(Server.MapPath("../../Attachments/IB/Logs/out_") & arrIDs(lenArray) & ".log") Then
                    File.Delete(Server.MapPath("../../Attachments/IB/Logs/out_") & arrIDs(lenArray) & ".log")
                End If
                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'sysFileName = CommonFunction.Data.GetDataScalar("select SystemFileName from tbl_FCI_Requests_Attachments Where requestID = " & arrIDs(lenArray), True)
                sysFileName = CommonFunction.Data.GetDataScalar("usp_sel_tbl_FCI_Requests_Attachments " & arrIDs(lenArray), True)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                If File.Exists(Server.MapPath("../../Attachments/IB/Requests/") & sysFileName) Then
                    File.Delete(Server.MapPath("../../Attachments/IB/Requests/") & sysFileName)
                End If
                If (arrIDs(lenArray) <> "") Then
                    CommonFunctions.Data.InsertOrUpdateData("DELETE FROM tbl_FCI_RequestStatus WHERE RequestID = " + arrIDs(lenArray), MyBase.UseSQL)
                End If
            Next
        End If
        Dim strScript As String
        strScript = vbCrLf + "<Script language=javascript>"
        strScript += vbCrLf + " window.location.href='../IB/FCI_Attachment.aspx?MasterTagID=8055&FromWhere=PM';"
        strScript += vbCrLf + "</Script>"
        CommonFunction.General.WriteHTML(strScript)

    End Sub

    'Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
    '    If Args.DataField.ToUpper = "DATEATTACHED" Then
    '        Cancel = True
    '        Args.StringToBeInserted += "<img src='../../Images/Sort_down.gif'> Attached Date"
    '    End If
    'End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim blnIsDisabled As Boolean = False
        If Args.DataField.ToUpper = "VIEWREJECTEDFILE" Then
            If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "C" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center>Uploaded Successfully</TD>"
            ElseIf CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "R" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) <> "" Then
                'If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) <> "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center Title=""View Rejected File""><A href=javascript:ViewRejectedFile(""" & CStr(Args.DataReader("RequestID")) & ".xls" & """) >" & "View Rejected File" & "</A></TD>"

            ElseIf CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "R" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) = "" Then
                'ElseIf CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) = "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center>Invalid Template</TD>"
            Else
                If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "E" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=center>Invalid Template</TD>"
                Else
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=center>Invalid Template</TD>"
                End If
            End If
        End If

        If Args.DataField.ToUpper = "ORIGINALFILENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("SystemFileName")) & """,'IB') >" & CStr(Args.DataReader("OriginalFileName")) & "</A></TD>"

        End If

        If Args.ColumnName = "Delete" Then
            Cancel = True
            If Args.DataReader("Status") = "C" Then
                blnIsDisabled = True
            End If

            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , CType(Args.DataReader("RequestID"), String), blnIsDisabled, , True) + "</td>"
        End If
        If Args.ColumnName.ToUpper = "COMMENTS" Then
            Cancel = True
            '  Args.StringToBeInserted = "<td align=center>" + CommonFunction.HTMLControls.DrawTextArea("txtComments", "txtComments", , , , , , "Comments", 250, 40, 400, Args.DataReader("Comments"), , , , True, returnHTML:=True) + "</td>"
            Args.StringToBeInserted = "<td align=center>" + Args.DataReader("Comments") + "</td>"
        End If
        If Args.ColumnName.ToUpper = "DATEATTACHED" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + Args.DataReader("DateAttached") + "</td>"
        End If
        If Args.DataField.ToUpper = "ZONENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + Args.DataReader("ZoneName") + "</td>"
        End If
    End Sub

    Public Function GenerateTemplate(ByVal strSQL As String, ByVal strPath As String, ByVal strFileName As String) As String
        '=====================================================================
        ' Procedure Name        : GenerateTemplate()	
        ' Purpose               : To generate the excel template
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 14-Jul-2010
        ' Revisions             :
        '=====================================================================

        Dim strFormat As String = ""
        Dim strFilePath As String = ""
        ' Dim dr As IDataReader


        strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
        ' strFileName += ".xls"
        objReport = New DynamicReports.Report

        strFormat = "EXCEL"  ' UCase(Trim(Request.QueryString("Format") & "") & "")
        objReport = New DynamicReports.Report

        'strFileName += ".xls"
        'dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), CommonFunctions.Application.ConnectionString)
        'If dr.Read Then
        ' The reports are created in the "Reports" folder
        strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
        ' get a unique file name
        ' strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
        ' add extn to file name based on format requested
        Select Case strFormat
            Case "PDF" : strFileName += ".pdf"
            Case "HTML" : strFileName += ".htm"
            Case "RTF" : strFileName += ".rtf"
            Case "EXCEL" : strFileName += ".xls"
            Case "CSV" : strFileName += ".csv"
            Case "TEXT" : strFileName += ".txt"
            Case "XML" : strFileName += ".xml"
            Case Else : strFileName += ".pdf"
        End Select

        With objReport
            .CompanyName = CommonFunctions.Application.CompanyName
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .DateFormat = CInt(CommonFunctions.Application.DateFormatID)
            .EmptyValueReplacement = " "
            .ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/"))
            .FilePathName = Trim(strFilePath & "") & strFileName
            .FontName = "Arial"
            .LogoPathName = Server.MapPath("../../Images/") & "CustomerLogo.gif"
            .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
            ' Set the tag/sub-tag specific SQL and Title
            .SQLSource = strSQL
            .Title = "Issue Import Template"

            Select Case strFormat
                Case "PDF" : .GenerateReport(DynamicReports.Format.PDF)
                Case "HTML" : .GenerateReport(DynamicReports.Format.HTML)
                Case "RTF" : .GenerateReport(DynamicReports.Format.RTF)
                Case "EXCEL" : .GenerateReport(DynamicReports.Format.EXCEL)
                Case "CSV" : .GenerateReport(DynamicReports.Format.CSV)
                Case "TEXT" : .GenerateReport(DynamicReports.Format.TEXT)
                Case "XML" : .GenerateReport(DynamicReports.Format.XML)
                Case Else : .GenerateReport(DynamicReports.Format.PDF)
            End Select
        End With

        'Copy the files from report folder to the destination (FCI Folder)
        If File.Exists(strPath + strFileName) Then
            File.Delete(strPath + strFileName)
        End If
        If File.Exists(strFilePath + "\" + strFileName) Then
            File.Copy(strFilePath + "\" + strFileName, strPath + strFileName)
            File.Delete(strFilePath + "\" + strFileName)
        End If
        Return strFileName

        objReport = Nothing
        ' CommonFunctions.Data.DisposeDataReader(dr)
        Return strFileName
        ' Else
        'Return ""
        'End If
    End Function


    ''Private Sub objReport_beforePrint(ByRef Cancel As Boolean, ByRef Args As DynamicReports.WAF_Report) Handles objReport.Report_BeforePrint

    ''End Sub
    ''Private Sub objReport_Control_beforePlot(ByRef Cancel As Boolean, ByRef Args As DynamicReports.WAF_Control) Handles objReport.Control_BeforePlot

    ''End Sub
    ''Private rowCnt As Integer = 0
    ''Private Sub objReportSectionControls_BeforePrint(ByVal sender As Object, ByVal e As EventArgs, ByVal reports As DataDynamics.ActiveReports.ActiveReport) Handles objReport.SectionControls_BeforePrint
    ''    rowCnt += 1
    ''    'If reports.Sections.Item(2).Controls.Item(rowCnt).DataField.ToUpper = "STATUS CHANGE TIME" Then
    ''    '    reports.Sections.Item(2).Controls.Item(rowCnt).Width = "20"
    ''    'End If
    ''    'If reports.Sections.Item(2).Controls.Item(rowCnt).DataField.ToUpper = "STATUS CHANGE DATE" Then
    ''    reports.Sections.Item(2).Controls.Item(rowCnt).Width = "1"
    ''    'End If
    ''End Sub
    ''Private Sub objReport_Report_InitializeSettings(ByRef Args As DynamicReports.WAF_ReportSettings) Handles objReport.Report_InitializeSettings

    ''End Sub
End Class
 