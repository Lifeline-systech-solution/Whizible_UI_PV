Imports System.Net
Imports Newtonsoft.Json
Imports System.IO
Imports System.Xml
Imports System.Runtime.InteropServices

Public Class HR_Attachment
    Inherits WebPages.Template.WhizTemplate
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_strFileName As String = ""
    Protected m_strPKToken As String = ""


    Protected m_strAction As String = ""

    Protected m_strMode As String = ""

    Private m_blnUseSQL As Boolean
    Protected m_lngMaxLength As Long = 100
    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
    Protected m_intTagID As Integer
    Protected APP_TAG_EMPLOYEE As Integer = 23
    Protected APP_TAG_JOININGPOOL As Integer = 3873
    ' Added By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 
    Protected APP_TAG_EMPLOYEE_PAYROLL As Long = 3949
    ' End Addition By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 

    'Added By VarunA on 23-Mar-2009 IssueID-28582
    'Purpose : To upload Approved Employee Leave through Excel Upload.
    Protected APP_TAG_EmployeeLeaves As Integer = 1207

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Initrole(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
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

        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'Put user code to initialize the page here
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
        ' Author                : ArchanaN
        ' Created               : 17 Dec 2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strPath As String
        Dim strFileName As String
        Dim strOriginalFileName As String

        Dim strTemplateID As String
        Dim strRequestID As String
        Dim strTemplateSQL As String

        If UCase(Trim(m_strAction & "")) = "ATTACH" Then


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
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
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


                ''End of Added by swapnil aswale on 15-06-2016


                ' The path 

                strPath = Server.MapPath("../../Attachments/DXU/Requests")

                ' the system file name
                strFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

                ' upload the file
                Dim objFile As New FileUpload.cUpload("txtFileName", strPath, strFileName)
                objFile.OverwriteIfExists = True
                objFile.UploadFile()

                ' the file name
                strOriginalFileName = objFile.OriginalFileName
                strFileName = objFile.UploadedFileName
                objFile = Nothing


                'Create an Request Entry
                strTemplateSQL = " Usp_HR_GetTemplateName " & m_intTagID
                strTemplateID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strTemplateSQL, MyBase.UseSQL), "0"), "0")
                strSQL = " usp_Ins_ResourcePoolDXURequest " & Session("intUserID").ToString '& "," & CStr(Session("intProjectID"))
                strSQL &= ", " & strTemplateID '& "," & m_strID
                strSQL &= ", " & m_intTagID

                strRequestID = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString()


                strSQL = "Exec usp_Ins_tbl_HR_ResourceAttachments " & strRequestID & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                strSQL &= ", '" & CommonFunctions.General.BuildQueryString(strFileName) & "', '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "'"     '" & CommonFunctions.General.BuildQueryString(strDescription) & "'"

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
                    .RequestID = CInt(strRequestID)
                    .Post()
                End With
                objRequest = Nothing

                ' To add the record in Resource Joining Pool 
                Dim strReqSQL As String
                Dim strinsSQL As String

                strReqSQL = " IF Exists(Select 1 from tbl_DXU_UploadRequestsQueue where RequestID = " + strRequestID + " And Status='I') Exec usp_DXU_TransferRequestData " + strRequestID
                If Trim(strReqSQL & "") <> "" Then
                    CommonFunctions.Data.InsertOrUpdateData(strReqSQL, True)
                    ' To add the record in Resource Joining Pool Skills subtab

                    ''strinsSQL = " usp_ins_tbl_PM_Employee_OfferedSkillMatrix"
                    ''If Trim(strinsSQL & "") <> "" Then
                    ''    CommonFunctions.Data.InsertOrUpdateData(strinsSQL, True)
                    ''End If
                End If

                Dim strScript As String
                strScript = vbCrLf + "<Script language=javascript>"
                'strScript += vbCrLf + "    refreshParent('frmHR_Attachment','HR_Attachment.aspx','HR_Attachment.aspx');"
                If m_intTagID = 3949 Then
                    strScript += vbCrLf + "    refreshParent('frmCommonList','EmployeePayroll_CommonList.aspx','../PRJPROFIT/EmployeePayroll_CommonList.aspx?MasterTagID=3949&FromWhere=RM');"
                Else
                    strScript += vbCrLf + "    refreshParent('frmCommonList','HR_CommonList.aspx','HR_CommonList.aspx?MasterTagID=3873&FromWhere=RM');"
                End If

                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)
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
        ' Author                : ArchanaN
        ' Created               : 17 Dec 2007
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
        'If Not Request.QueryString("FromWhere") Is Nothing Then
        '    m_strFromWhere = Request.QueryString("FromWhere").ToString
        'End If


        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_intTagID = CType(Request.QueryString("MasterTagID"), Integer)
        If m_intTagID <> 0 Then
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , CType(m_intTagID, String), , , , , , True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:06/10/15

        End If

        If m_intTagID = 0 Then
            m_intTagID = CType(Request.Form("txtTagID"), Integer)
        Else
            m_intTagID = CType(Request.QueryString("MasterTagID"), Integer)
        End If

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
        ' Created               : 17 Dec 2007
        ' Revisions             :
        '=====================================================================

        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If

        ' Commented And Added By Omkar On 26th Feb 2020 For Insecure Transport: Database
        'If Request.QueryString("Action") = "DELETEDETAILS" Then
        If HttpUtility.HtmlDecode(Request.QueryString("Action")) = "DELETEDETAILS" Then
            'End of Commented And Added By Omkar On 26th Feb 2020 For Insecure Transport: Database
            DeleteDetails()
        End If

        Dim arrMenu() As String = {"Upload", "Download Template", "Select All", "Clear All", "Delete", "Close"}
        Dim arrMenuToolTip() As String = {"Upload", "Download Template", "Select All", "Clear All", "Delete", "Close"}
        Dim arrCSFunction() As String = {"Attach_OnClick()", "Download_onclick()", "SelectAll_Onclick()", "ClearAll_Onclick()", "DeleteDetails_OnClick()", "Close_OnClick()"}

        Dim strSQL As String
        Dim dr As IDataReader
        ' Dim strTemplateSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write("<DIV ID='divList' Style='Height:620px;WIDTH:100%;OVERFLOW:auto;'>")
            .Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            .Write("<TR class=clsTRPageCaption><TD align=Left>Upload Excel </TD></TR></TABLE>")
            .Write("<TABLE cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            .Write("<TR class=clsTREven><TD align=Left> Please upload only Excel files. (.xls extension files) </TD></TR></TABLE>")
            .Write("<BR>")
            .Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("" + "Select File" + "")
            .Write("</TD>")

            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'", , , 1)
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            .Write("<TR class=clsTREven>")
            .Write("<TD>")

            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strPKToken, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:06/10/15

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
            drawGrid()
            .Write("</DIV>")
            .Write("<BR>")
            .Write(strMenu)
        End With
    End Sub
    Private Sub drawGrid()
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strSQLQuery As String
        Dim drGetLevel As IDataReader
        Dim intUserID As String
        Dim strWhere As String

        ''If CType(HttpContext.Current.Session("LoginType"), String) = "E" Then
        ''    strSQLQuery = " SELECT EmployeeID  from tbl_PM_Employee WHERE EmployeeID = " & CType(Session("intUserID"), String)
        ''End If
        ''drGetLevel = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        ''If (drGetLevel.Read) Then
        ''    If CType(HttpContext.Current.Session("LoginType"), String) = "E" Then
        ''        intUserID = CType(CommonFunctions.Data.CheckIsDBNull(drGetLevel("EmployeeID"), "0"), String)
        ''    End If

        ''End If

        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
            If CType(HttpContext.Current.Session("LoginType"), String) = "E" Then
                strWhere = " Where EmployeeID = " & CType(Session("intUserID"), String)
            Else
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        Else
            strWhere = " "
        End If


        If m_intTagID = APP_TAG_EMPLOYEE Then
            strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
                                     & " from v_tbl_PM_Employee_Attachment  " & strWhere & " order by AttachedBy  ,dateAttached desc"


        ElseIf m_intTagID = APP_TAG_JOININGPOOL Then
            strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
                             & " from v_tbl_PM_Employee_OfferedAttachment " & strWhere & " order by AttachedBy  ,dateAttached desc"
            'Added By VarunA on 23-Mar-2009 IssueID-28582
            'Purpose : To upload Approved Employee Leave through Excel Upload.
        ElseIf m_intTagID = APP_TAG_EmployeeLeaves Then
            strSQL = "Select RequestID,AttachmentID,EmployeeID,AttachedBy,OriginalFileName,SystemFileName,Status,Errmsg,DateAttached,[View Rejected File],RejectedRecordsFilePath " _
                             & " from v_tbl_PM_Employee_LeaveAttachment " & strWhere & " order by AttachedBy  ,dateAttached desc"
            'End by VarunA on 23-Mar-2009 IssueID-28582
        End If

        ' Added By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 
        If m_intTagID = APP_TAG_EMPLOYEE_PAYROLL Then
            strSQL = " usp_SEL_tbl_PM_Employee_Payroll_Attachment " + CType(Session("intUserID"), String) + "," + CType(HttpContext.Current.Session("intPostID"), String)
        End If
        'End Added By NitinVS on 9 SEP 2008 for Project Profitability Employee Payroll Template 

        Dim arrColumnHeadingList() As String = {"Attached By", "Original File Name", "Attached Date", "View Rejected File", "Delete"}
        Dim arrActualColumnNames() As String = {"AttachedBy", "OriginalFileName", "DateAttached", "ViewRejectedFile", ""}
        Dim arrTDStyle() As String = {"align=left style='width=15%'", "align=left width=25%", "align=left width=15%", "align=center width=25%", "align=center width=5%"}
        Dim arrGroupColName() As String = {"Attached By"}

        'CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width=100%'>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 3
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivGrid"
            .DIVHeight = 100%
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = True
            .GroupOnColumn = arrGroupColName
            .PrimaryKey = "AttachmentID"
            '.SortBy = "AttachedBy,DateAttached"
            '.SortOrder = "Desc"
            .DrawGrid()

        End With
        m_objGrid = Nothing
        'CommonFunctions.General.WriteHTML("</DIV>")
        '
    End Sub
    Private Sub DeleteDetails()
        Dim m_strRequestID As String
        Dim arrIDs() As String
        Dim lenArray As Integer

        ' Commented And Added By Omkar On 26th Feb 2020 For Insecure Transport: Database
        'If CType(Request.Form("chkDelete"), String) <> "" Then
        If CType(HttpUtility.HtmlDecode(Request.Form("chkDelete")), String) <> "" Then
            '        m_strRequestID = CType(Request.Form("chkDelete"), String)
            m_strRequestID = CType(HttpUtility.HtmlDecode(Request.Form("chkDelete")), String)
            'End of Commented And Added By Omkar On 26th Feb 2020 For Insecure Transport: Database

            m_strRequestID = CType(Request.Form("chkDelete"), String)

            arrIDs = m_strRequestID.Split(CType(",", Char))
            'Now Insert Into Table
            For lenArray = 0 To arrIDs.Length - 1
                If (arrIDs(lenArray) <> "") Then
                    CommonFunctions.Data.InsertOrUpdateData("DELETE FROM tbl_DXU_UploadRequestsQueue WHERE RequestID = " + arrIDs(lenArray), MyBase.UseSQL)
                End If
            Next
        End If
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "VIEWREJECTEDFILE" Then
            If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "T" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) <> "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center Title=""View Rejected File""><A href=javascript:ViewRejectedFile(""" & CStr(Args.DataReader("RequestID")) & ".xls" & """) >" & "View Rejected File" & "</A></TD>"

            ElseIf CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "T" And CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RejectedRecordsFilePath"), ""), String)) = "" Then
                Cancel = True
                Args.StringToBeInserted = "<TD align=center>Below Acceptable Threshold</TD>"

            Else
                If CStr(CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("Status"), ""), String)) = "E" Then
                    Cancel = True
                    Dim strErrmsg As String
                    If Not Args.DataReader("Errmsg") Is DBNull.Value Then
                        strErrmsg = CStr(Args.DataReader("Errmsg"))
                    Else
                        strErrmsg = "Invalid template Used"
                    End If
                    Args.StringToBeInserted = "<TD align=center>Invalid Template</TD>"
                    'Args.StringToBeInserted += "<SPAN onmouseover=""DisplayTooltipCL('<iframe height=325px width=425px scrolling=no src=../DXU/DXU_Popup.aspx?RequestID=" & CStr(Args.DataReader("RequestID")) & "></iframe>')"" onmouseout=""DisplayTooltipCL('')""><U>Invalid Template</U></SPAN></TD>"

                Else
                    Cancel = True
                    Args.StringToBeInserted = "<TD align=center>-</TD>"
                End If

            End If

        End If

        If Args.DataField.ToUpper = "ORIGINALFILENAME" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("SystemFileName")) & """,'DXU') >" & CStr(Args.DataReader("OriginalFileName")) & "</A></TD>"

        End If

        If Args.ColumnName = "Delete" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , CType(Args.DataReader("RequestID"), String), , , True) + "</td>"
        End If

    End Sub


End Class
'''Public Class cHR_AttachmentCLSQL
'''    Inherits CommonEngine.CommonList.cCLSQL

'''    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
'''        MyBase.New(objGlobal)
'''    End Sub

'''    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
'''        'If (objGlobal.FromWhere = "PM") Then
'''        GetPageSpecificFilters &= " AND ProjectID is Not NULL "
'''        GetPageSpecificFilters &= "  AND ProjectID=" & HttpContext.Current.Session("intProjectID").ToString

'''        'Modified  by ArchanaN 26 Feb 2008 For Whiziblesem 7.1 Issue ID= 19154
'''        ''If objGlobal.LoginType = "C" Then
'''        ''    GetPageSpecificFilters &= " And Customer = " & CStr(objGlobal.UserID)
'''        ''Else
'''        ''If objGlobal.LoginType = "C" Then
'''        If CType(HttpContext.Current.Session("intPostID"), String) <> "7" Then
'''            'End of Modified by ArchanaN 26 Feb 2008 For Whiziblesem 7.1 Issue ID= 19154
'''            GetPageSpecificFilters &= " And EmployeeID = " & CStr(objGlobal.UserID)
'''        End If
'''        'Else
'''        '    GetPageSpecificFilters &= " AND ProjectID is  NULL "
'''        'End If
'''    End Function
'''End Class