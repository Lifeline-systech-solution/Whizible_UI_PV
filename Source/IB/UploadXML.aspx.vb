Imports CommonEngines.General.cEventHandlers
Imports System.Configuration
Imports System.IO
Imports System.Data.OleDb
Imports System.Data.SqlClient
Imports System.Text
Imports Microsoft.VisualBasic.FileSystem
Imports Whizible
Imports System.Runtime.InteropServices
Imports System.Xml
Imports Newtonsoft.Json
Imports System.Net
Public Class UploadXML
    Inherits CommonList
    Protected m_Action As String = ""
    Public Shared m_strLogPath As String
    Public Shared strDay As String
    Public Shared strMonth As String
    Public Shared m_strRejectedRecordsFilePath As String
    Public Shared m_strUploadedFilePath As String
    Dim m_intRepTimeIndex As Integer = 0
    Dim m_intSCTimeIndex As Integer = 0

    Public m_strUploadedFileExtn As String
    Public Shared m_intNoRejectedRecords As Integer
    Public Shared m_strConnectionString As String
    Public Shared m_strRequestID As String = ""
    Public Shared logFile As String
    Public Shared errorFile As String
    Public Shared DetailedLog As String
    Public m_dXMLEntitySet As New DataSet()
    Public m_dXMLEntityRdr As DataTableReader
    Public m_arrColList As String()
    Public m_arrWhizColList As String()
    Public m_arrDataTypeList As String()
    Public m_arrIsMandatoryList As String()
    Public m_arrColLength As String()
    Public m_strSQLExcelColumns As String = ""
    Public m_arrAttributeValues() As String
    Public m_arrAttributeDatatype() As String
    ' Public m_arrAttributeIsMandatory() As String
    Public m_arrAttributes() As String
    Public m_IsSingleFLDForDAteTime As Boolean
    Public m_IsIssueSLAApplicable As Boolean = False
    Private m_objSQLAdapter As SqlDataAdapter
    Public m_objSQLConnection As SqlConnection

    Public m_objOLEConnection As OleDbConnection
    Public m_objOLECommand As OleDbCommand
    Public m_objOLEAdapter As New OleDbDataAdapter

    Public dtPatterns = New DataTable()
    Public m_strProjectID As String = "0"
    Public m_intIntegrationId As Integer = 0
    Public m_intSchemaCol As Integer = 0
    Public m_drReader As IDataReader
    Public m_cntDBArr As Integer = 0
    Public m_ExcelRowCnt As String
    Public m_ExcelcolCnt As Integer = 0
    ' Public m_strCustIssueCode As String = ""

    'Public IsValueExists As Boolean = True
    Public IsRowValid As Boolean = True

    Public Property RejectedRecordsFilePath() As String
        Get
            Return m_strRejectedRecordsFilePath
        End Get
        Set(ByVal Value As String)
            m_strRejectedRecordsFilePath = Value
        End Set
    End Property

    Public Property ConnectionString() As String
        Get
            Return m_strConnectionString
        End Get
        Set(ByVal Value As String)
            m_strConnectionString = Value
        End Set
    End Property

    Public Property RequestID() As String
        Get
            Return m_strRequestID
        End Get
        Set(ByVal Value As String)
            m_strRequestID = Value
        End Set
    End Property

    Property UploadedFilePath() As String
        Get
            Return m_strUploadedFilePath
        End Get
        Set(ByVal Value As String)
            m_strUploadedFilePath = Value
        End Set
    End Property
    Public Sub New()
        m_strConnectionString = CommonFunction.General.GetConnectionString()
        m_objSQLConnection = New SqlConnection(m_strConnectionString)
        m_objSQLConnection.Open()
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "UploadXML.aspx"
        MyBase.strFormPage = "Commonpage.aspx"
        'Put user code to initialize the page here

        m_Action = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"))
        If m_Action.ToUpper = "UPLOADXML" Then
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

                'If strListofTypes.Contains("text/plain") Or strListofTypes.Contains("text/xml") Or strListofTypes.Contains("application/xml") Or strListofTypes.Contains("text/html") Then
                'Commented By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
                'If MimeType = "text/plain" Or MimeType = "text/xml" Or MimeType = "application/xml" Or MimeType = "text/html" Then

                'Else
                'End of Commented By Bharat Tekade on 26th-Aug-2016 to solve file upload issue
                'file.InputStream.Read(buffer, 0, 256)
                Dim magicNumber As String = BitConverter.ToString(buffer)
                magicNumber = magicNumber.Replace("-", " ")
                Dim xmlDoc As New XmlDocument()
                Dim strFileType = getMimeFromFile(HttpContext.Current.Request.Files(0))
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
                uploadXML()
            Else
                CommonFunction.General.WriteHTML("<Script>")
                'CommonFunction.General.WriteHTML("alert('Invalid Content Type!!'); ")
                CommonFunction.General.WriteHTML("alert('Please upload valid file.'); ")
                CommonFunction.General.WriteHTML("</Script>")
            End If

        End If


        MyBase.Page_Load(sender, e)
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

    Public Sub uploadXML()


        ' Dim dXMLEntityRdr As DataTableReader
        Dim drWhizAttributes As IDataReader
        ' Dim strXMLFilePath As String
        Dim dXMLEntitySet1 As New DataSet()

        Dim strtables As String = ""
        Dim ColnotFound As Integer = 0
        Dim arrSysAttributeName As New ArrayList
        'Dim arrcnt As Integer
        Dim intSysid As Integer = 0
        Dim IsAttributesInvalid As Integer = 0
        ' Dim strOUTXML As New System.Text.StringBuilder
        '  Dim strOutProjectCode As String

        Dim strSystemId As String = "0"

        Dim IsError As Boolean = False
        Dim strErrorMsg As String
        Dim strSQL As String


        Try
            ' strOUTXML.Append("")
            ' strXMLFilePath = "D:\FCI\In.xls"
            m_strLogPath = Server.MapPath("../../Attachments/IB/Logs/")
            logFile = "Out_" & m_strRequestID & ".log"

            ' if XML files are not specified, no point in continuing further
            If m_strUploadedFilePath = "" Then
                Exit Try
            End If

            Try
                Dim dr As IDataReader
                Dim strSQLdr As String

                m_strProjectID = Session("intProjectID").ToString
                strSQLdr = "usp_get_tbl_FCI_IntegrationDetails " + m_strProjectID
                dr = CommonFunctions.Data.GetDataReader(strSQLdr, True)
                If dr.Read() Then
                    m_intIntegrationId = CommonFunction.Data.CheckIsDBNull(dr.Item("IntegrationID"), 0)
                    m_IsSingleFLDForDAteTime = CommonFunction.Data.CheckIsDBNull(dr.Item("IsSingleFLDForDAteTime"), 0)
                    m_IsIssueSLAApplicable = CommonFunction.Data.CheckIsDBNull(dr.Item("IsIssueSLAApplicable"), 0)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                m_strUploadedFileExtn = m_strUploadedFilePath.Substring(m_strUploadedFilePath.LastIndexOf("."))
                CommonFunctions.Data.InsertOrUpdateData(" EXEC usp_FCI_TempTableCreation '" + m_strRequestID + "'," + m_intIntegrationId.ToString, True)

                ''' Get the Attributes and Values
                GetAttributes()

                '''' Create temp table for Uploading Rejection  file
                strErrorMsg = createTempTableForRejectedAttributes()
                If strErrorMsg <> "" Then
                    Call Writelog(m_strLogPath, logFile, "Log", strErrorMsg)
                End If
                ExportInValidRecords(m_strRequestID, strErrorMsg)

                '' Validate the Attributes according to the maaping
                strErrorMsg = ValidateAttributes()
                If strErrorMsg <> "" Then
                    Call Writelog(m_strLogPath, logFile, "Log", strErrorMsg)
                End If
                ExportInValidRecords(m_strRequestID, strErrorMsg)

                '' End of Validate the Attributes according to the maaping

                ''''' Insert the records into temp table
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                ' If CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select 1 FROM tbl_FCI_RequestStatus Where Status ='I' and RequestID =" & m_strRequestID, True), 0) = 1 Then
                If CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_FCI_RequestStatus_FCI " & m_strRequestID, True), 0) = 1 Then
                    'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                    strErrorMsg = InsertIntoTempTable()
                    If strErrorMsg <> "" Then
                        Call Writelog(m_strLogPath, logFile, "Log", strErrorMsg)
                        ExportInValidRecords(m_strRequestID, strErrorMsg)
                    End If
                End If

                ''' Validate the Rows
                ''If IsValueExists = True Then
                strErrorMsg = ValidateRows()
                If strErrorMsg <> "" Then
                    Call Writelog(m_strLogPath, logFile, "Log", strErrorMsg)
                    ExportInValidRecords(m_strRequestID, strErrorMsg)
                End If
                ''End If

                ' Insert into Issue Base
                If IsRowValid = True Then
                    'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                    'If CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select 1 FROM tbl_FCI_RequestStatus Where Status ='A' and RequestID =" & m_strRequestID, True), 0) = 1 Then
                    If CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_FCI_RequestStatus_Request " & m_strRequestID, True), 0) = 1 Then

                        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                        CommonFunction.Data.InsertOrUpdateData("usp_FCI_ImportIssues " & m_strRequestID & "," & m_strProjectID, True)
                    End If
                End If
            Catch ex As Exception

                Call Writelog(m_strLogPath, logFile, "Log", ex.Message.ToString())
                ExportInValidRecords(m_strRequestID, ex.Message.ToString())
            Finally
            End Try

            drWhizAttributes = Nothing
            m_dXMLEntitySet = Nothing
            m_objOLEAdapter = Nothing
            m_objOLECommand = Nothing
            m_objOLEConnection = Nothing

            '' Drop the temp table to upload in the Rejected file
            strSQL = "usp_Del_FCI_Requesttemp_tables " & m_strRequestID
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)

        Catch ex As Exception
            Call Writelog(m_strLogPath, logFile, "Log", " UploadXML : " + ex.Message)
            ExportInValidRecords(m_strRequestID, ex.Message)
        Finally
        End Try



    End Sub
    Private Function GetAttributes()
        Dim strConnectionString As String
        Dim strSQL As String

        Dim cnt As Integer = 0

        Dim strErrorMsg As String
        Dim objAttrDataSet As New DataSet
        Dim objRow As DataRow
        Dim arrcnt As Integer = 0
        Try
            strConnectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" & m_strUploadedFilePath & ";"
            strConnectionString &= "Extended Properties=""Excel 12.0;HDR=YES;IMEX=1"""
            m_objOLEConnection = New OleDbConnection
            m_objOLEConnection.ConnectionString = strConnectionString
            m_objOLEConnection.Open()
            m_objOLECommand = New OleDbCommand
            m_objOLECommand.Connection = m_objOLEConnection


            'Getting all the column names from the source excel file.
            strSQL = "SELECT * FROM [Sheet1$]"
            m_objOLECommand.CommandText = strSQL

            m_objOLEAdapter.SelectCommand = m_objOLECommand
            m_objOLEAdapter.Fill(dtPatterns)
            m_dXMLEntitySet.Tables.Add(dtPatterns)

            m_strProjectID = CommonFunction.General.CheckIsNothing(Session("intProjectID"), "").ToString
            m_ExcelRowCnt = m_dXMLEntitySet.Tables(0).Rows.Count()
            m_ExcelcolCnt = m_dXMLEntitySet.Tables(0).Columns.Count

            strSQL = " Select SysAttributeName,WhizAttributeName, ISNULL(IsMandatory,0) IsMandatory ,ISNULL(IsActive,0) IsActive, Data_Type ,ISNULL(ISCustomField,0)ISCustomField ,ISNULL(Character_Maximum_Length,0) as [Character_Maximum_Length] "
            strSQL += " From tbl_FCI_ExternalSysAttribute_Mapping ESM "
            strSQL += "Inner Join  Information_Schema.columns I ON I.Column_name= ESM.WhizAttributeName AND table_name = 'tbl_IB_Issue'"
            strSQL += " Where ProjectID = " & m_strProjectID

            'Get the Mapped Attributes of the session Project
            m_objSQLAdapter = New SqlDataAdapter(strSQL, m_objSQLConnection)
            m_objSQLAdapter.Fill(objAttrDataSet)

            m_intSchemaCol = objAttrDataSet.Tables(0).Rows.Count - 1

            ReDim m_arrAttributeValues(m_ExcelcolCnt - 1)
            ReDim m_arrAttributes(m_ExcelcolCnt - 1)
            ' ReDim m_arrAttributeIsMandatory(m_ExcelcolCnt)
            ReDim m_arrAttributeDatatype(m_ExcelcolCnt)

            ReDim m_arrColList(m_intSchemaCol)
            ReDim m_arrWhizColList(m_intSchemaCol)
            ReDim m_arrDataTypeList(m_intSchemaCol)
            ReDim m_arrIsMandatoryList(m_intSchemaCol)
            ReDim m_arrColLength(m_intSchemaCol)

            For Each objRow In objAttrDataSet.Tables(0).Rows
                m_arrColList(m_cntDBArr) = objRow.Item("SysAttributeName").ToString
                m_arrWhizColList(m_cntDBArr) = objRow.Item("WhizAttributeName").ToString
                m_arrDataTypeList(m_cntDBArr) = objRow.Item("Data_Type").ToString
                m_arrIsMandatoryList(m_cntDBArr) = IIf(objRow.Item("IsActive") = True, "1", "0")
                m_arrColLength(m_cntDBArr) = objRow.Item("Character_Maximum_Length").ToString

                m_cntDBArr += 1
            Next
            ''End of Get the Mapped Attributes of the session Project

            While cnt <= m_ExcelcolCnt - 1
                m_arrAttributes(cnt) = m_dXMLEntitySet.Tables(0).Columns(cnt).ColumnName()
                m_arrAttributeDatatype(cnt) = m_dXMLEntitySet.Tables(0).Columns(cnt).DataType.ToString
                cnt += 1
            End While
            cnt = 0
            While cnt <= m_ExcelcolCnt - 1
                While arrcnt <= m_cntDBArr - 1
                    If m_arrWhizColList(arrcnt).ToUpper = "REPORTEDTIME" OrElse (m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE") Then
                        If m_arrAttributes(cnt).ToUpper = m_arrColList(arrcnt).ToUpper Then
                            m_intRepTimeIndex = cnt
                        End If
                    End If

                    If m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGETIME" OrElse (m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE") Then
                        If m_arrAttributes(cnt).ToUpper = m_arrColList(arrcnt).ToUpper Then
                            m_intSCTimeIndex = cnt
                        End If
                    End If
                    arrcnt += 1
                End While
                arrcnt = 0
                cnt += 1
            End While

            'If m_dXMLEntitySet.Tables(0).Columns("CustomerIssueID") Is Nothing Then
            '    m_strCustIssueCode = ""
            'Else
            '    m_strCustIssueCode = m_dXMLEntitySet.Tables(0).Rows(m_ExcelRowCnt - 1).Item("CustomerIssueID").ToString
            'End If


            'm_ExcelRowCnt = m_ExcelRowCnt - 1
            cnt = 1
        Catch ex As Exception
            Call Writelog(m_strLogPath, logFile, "Log", ex.Message.ToString())
            ExportInValidRecords(m_strRequestID, ex.Message.ToString())
        Finally
        End Try
        If Not m_objOLEConnection Is Nothing Then
            If m_objOLEConnection.State = ConnectionState.Open Then m_objOLEConnection.Close()
            m_objOLEConnection.Dispose()
        End If
        'drWhizAttributes = Nothing
        ' m_dXMLEntitySet = Nothing
    End Function

    Public Function createTempTableForRejectedAttributes() As String
        Try
            Dim strSQL As String = ""
            Dim cnt As Integer = 0
            Dim arrcnt As Integer = 0
            strSQL = "IF Exists(Select 1 FROM sysObjects where Name = 'tbl_FCI_temp" & m_strRequestID & "')" & vbCrLf
            strSQL += "drop table dbo.tbl_FCI_temp" & m_strRequestID & vbCrLf
            If strSQL <> "" Then
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If

            strSQL = "Create table dbo.tbl_FCI_temp" & m_strRequestID & "("
            strSQL += "[RowID] Int IDENTITY(1,1), "

            While arrcnt <= m_cntDBArr - 1
                While cnt <= m_ExcelcolCnt - 1

                    If m_arrAttributes(cnt).ToUpper = m_arrColList(arrcnt).ToUpper Then
                        If m_arrDataTypeList(arrcnt).ToUpper = "INT" Or m_arrDataTypeList(arrcnt).ToUpper = "FLOAT" Or m_arrDataTypeList(arrcnt).ToUpper = "BIT" Or m_arrDataTypeList(arrcnt).ToUpper = "DATETIME" Then
                            strSQL += "[" & m_arrAttributes(cnt) & "] [Varchar]"
                        Else
                            strSQL += "[" & m_arrAttributes(cnt) & "]  " & m_arrDataTypeList(arrcnt)
                        End If
                        If m_arrDataTypeList(arrcnt).ToUpper = "VARCHAR" Or m_arrDataTypeList(arrcnt).ToUpper = "NVARCHAR" Or m_arrDataTypeList(arrcnt).ToUpper = "CHAR" Or m_arrDataTypeList(arrcnt).ToUpper = "NCHAR" Or m_arrDataTypeList(arrcnt).ToUpper = "INT" Or m_arrDataTypeList(arrcnt).ToUpper = "FLOAT" Or m_arrDataTypeList(arrcnt).ToUpper = "BIT" Or m_arrDataTypeList(arrcnt).ToUpper = "DATETIME" Then
                            strSQL += " (2000) ,"
                        Else
                            strSQL += " ,"
                        End If
                    End If
                    cnt += 1
                End While
                arrcnt += 1
                cnt = 0
            End While
            strSQL += "[ProjectID] Int,"
            strSQL += "[IsValid] BIT ,"
            strSQL += "[Errmsg] Nvarchar(4000) "
            strSQL += ")"
            If strSQL <> "" Then
                CommonFunction.Data.InsertOrUpdateData(strSQL, True)
            End If
        Catch ex As Exception
            Return ex.Message
        End Try
    End Function
    Public Function ValidateAttributeValues(ByVal strAttribute As String, ByVal strValue As String) As String
        'Dim strErrLog As String
        Dim strSQL As String = ""
        Dim IsValueMapped As Integer = 0
        'Try
        strSQL = "usp_Validate_Mappedvalues_ForProjectAttributes " & m_intIntegrationId.ToString & ",'" & CommonFunction.General.BuildQueryString(strAttribute) & "','" & CommonFunction.General.BuildQueryString(strValue) & "'"
        IsValueMapped = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)
        'Catch ex As Exception
        '    Return ex.Message
        'End Try
        If IsValueMapped = 0 Then
            'IsValueExists = False
            Return "Value ''" + CommonFunction.General.BuildQueryString(strValue) & "'' is not mapped to the attribute ''" & CommonFunction.General.BuildQueryString(strAttribute) + "'',"
        Else
            'IsValueExists = True
        End If
    End Function
    Public Function ValidateAttributes() As String
        'Validate Attributes
        Dim intRowHead As Integer = 0
        Dim strSQLField As String = ""
        Dim strSQLValues As String = ""
        Dim strErrLog As String = ""
        Dim cnt As Integer = 0
        Dim arrcnt As Integer = 0
        Dim isColumnPresentInDB As Boolean = False
        Dim isColumnDatatypeMatchInDB As Boolean = False
        Dim isColumnMandatoryInDB As Boolean = False
        Dim strDataType As String = ""
        Dim intExcelProjectID As Integer = 0
        Dim strCreateSQL As String = ""
        Dim strSQL As String = ""
        Try
            ' If m_strCustIssueCode <> "" Then
            While cnt <= m_ExcelcolCnt - 1
                While arrcnt <= m_cntDBArr - 1
                    If Trim(m_arrAttributes(cnt).ToUpper) = Trim(m_arrColList(arrcnt).ToUpper) Then
                        If (Trim(m_arrWhizColList(arrcnt).ToUpper) <> "STATUSCHANGETIME" Or Trim(m_arrWhizColList(arrcnt).ToUpper) <> "REPORTEDTIME") Then
                            isColumnPresentInDB = True
                        End If

                        If m_arrIsMandatoryList(arrcnt) = "1" And (Trim(m_arrWhizColList(arrcnt).ToUpper) <> "STATUSCHANGETIME" Or Trim(m_arrWhizColList(arrcnt).ToUpper) <> "REPORTEDTIME") Then
                            isColumnMandatoryInDB = True
                        End If

                        If (m_IsSingleFLDForDAteTime = True And (Trim(m_arrWhizColList(arrcnt).ToUpper) = "STATUSCHANGETIME" Or Trim(m_arrWhizColList(arrcnt).ToUpper) = "REPORTEDTIME")) Then
                            strErrLog += " Attribute """ & m_arrAttributes(cnt) & """ should not be present when 'Single Field For Date & Time' is ON,"
                        End If

                        If (m_IsIssueSLAApplicable = False And (Trim(m_arrWhizColList(arrcnt).ToUpper) = "STATUSCHANGETIME" Or Trim(m_arrWhizColList(arrcnt).ToUpper) = "STATUSCHANGEDATE")) Then
                            strErrLog += " Attribute """ & m_arrAttributes(cnt) & """ should not be present when 'Is Issue SLA Applicable' is OFF,"
                        End If

                    End If
                    arrcnt += 1
                End While

                If isColumnPresentInDB = False Then
                    If m_arrAttributes(cnt).ToUpper <> "F35" Then
                        strErrLog += " Attribute """ & m_arrAttributes(cnt) & """ is not mapped to the Project, "
                    End If
                    'Else
                    ' strCreateSQL += m_dXMLEntitySet.Tables(2).Columns(cnt).ColumnName & "  nvarchar(100) ,"
                End If
                If isColumnMandatoryInDB = False Then
                    strErrLog += " Attribute """ & m_arrAttributes(cnt) & """ is active and should exists in the excel template, "
                End If
                ''If isColumnDatatypeMatchInDB = False Then
                ''    strErrLog += " Attribute " & m_arrAttributes(cnt) & "s datatype should be " & strDataType & ","
                ''End If
                If arrcnt <= m_cntDBArr Then
                    isColumnPresentInDB = False
                End If
                arrcnt = 0
                cnt += 1
            End While
            '  End If

            'Added By AmitJ on 17-Aug-2010 --- *********************************************
            'Purpose: This loop will chk whether mapped attribites present in excel or not.
            arrcnt = 0
            cnt = 0
            While arrcnt <= m_cntDBArr - 1
                While cnt <= m_ExcelcolCnt - 1

                    If Trim(m_arrAttributes(cnt).ToUpper) = Trim(m_arrColList(arrcnt).ToUpper) Then
                        isColumnPresentInDB = True
                    End If

                    cnt += 1
                End While


                If isColumnPresentInDB = False Then

                    If m_IsIssueSLAApplicable = True And (m_IsSingleFLDForDAteTime = False And (Trim(m_arrWhizColList(arrcnt).ToUpper) = "STATUSCHANGETIME")) Then
                        strErrLog += " Attribute """ & m_arrColList(arrcnt) & """ should  exists in the excel when 'Single Field For Date & Time' is OFF,"
                    End If

                    If (m_IsSingleFLDForDAteTime = False And (Trim(m_arrWhizColList(arrcnt).ToUpper) = "REPORTEDTIME")) Then
                        strErrLog += " Attribute """ & m_arrColList(arrcnt) & """ should  exists in the excel when 'Single Field For Date & Time' is OFF,"
                    End If

                    If (Trim(m_arrWhizColList(arrcnt).ToUpper) <> "STATUSCHANGETIME" And Trim(m_arrWhizColList(arrcnt).ToUpper) <> "REPORTEDTIME") Then
                        ' If m_arrAttributes(cnt).ToUpper <> "F35" Then
                        If m_arrIsMandatoryList(arrcnt) = "1" Then
                            If ((Trim(m_arrWhizColList(arrcnt).ToUpper) <> "STATUSCHANGEDATE")) Or (m_IsIssueSLAApplicable = True And (Trim(m_arrWhizColList(arrcnt).ToUpper) = "STATUSCHANGEDATE")) Then
                                strErrLog += " Attribute """ & m_arrColList(arrcnt) & """ is active and should exists in the excel , "
                            End If
                        End If
                    End If
                End If

                If arrcnt <= m_cntDBArr Then
                    isColumnPresentInDB = False
                    isColumnMandatoryInDB = False
                End If
                'arrcnt = 0
                'cnt += 1
                arrcnt += 1
                cnt = 0
            End While





            'End of Adition--- *********************************************





            ''If m_dXMLEntitySet.Tables(0).Columns("CustomerIssueID") Is Nothing Then
            ''    strErrLog += "Attribute ""CustomerIssueID"" does not exists in the Excel Template"
            ''End If

            If strErrLog <> "" Then
                ' strErrLog += "Attribute ""CustomerIssueID"" does not exists in the Excel Template"
                strSQL = " Update tbl_FCI_RequestStatus Set errmsg =  '" + CommonFunction.General.BuildQueryString(strErrLog) + "' where RequestID = " + CStr(RequestID)
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True, ConnectionString)
            End If

        Catch ex As Exception
            Return "Validate Attribue : " + ex.Message
        End Try
        Return strErrLog
        'Validate Attributes
    End Function

    Public Function ValidateRows() As String
        Dim strSQL As String = ""
        Dim strMessage As String = ""

        Try
            strSQL = "usp_FCI_ValidateIssues " & m_strRequestID
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            strSQL = " IF EXISTS(Select 1 FROM tbl_FCI_Request" + m_strRequestID + " WHERE ISNULL(IsValid,0) = 1)"
            strSQL += " Update tbl_FCI_RequestStatus SET Status='A' WHERE RequestID = " & m_strRequestID
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)

            strMessage = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ErrMsg FROM tbl_FCI_Request" + m_strRequestID + " WHERE IsValid= 0", True), "")
            If strMessage <> "" Then
                IsRowValid = False
            End If
        Catch ex As Exception
            Return "ValidateRows : " + ex.Message
        End Try
        Return strMessage
    End Function
    Public Function GetAttributeValues(ByVal strAttribute As String, ByVal strValue As String) As String
        'Dim strErrLog As String
        Dim strSQL As String = ""
        Dim strWhizValue As String

        'Try
        strSQL = "usp_Get_Mappedvalues_ForProjectAttributes " & m_intIntegrationId.ToString & ",'" & CommonFunction.General.BuildQueryString(strAttribute) & "','" & CommonFunction.General.BuildQueryString(strValue) & "'"
        strWhizValue = CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)

        'Catch ex As Exception
        '    Return ex.Message
        'End Try
        Return strWhizValue
    End Function
    Public Function InsertIntoTempTable() As String
        '=====================================================================
        ' Procedure Name        : InsertIntoTempTable()	
        ' Purpose               : To insert the record into the temp table
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 22-Jul-2010
        ' Revisions             :
        '=====================================================================
        Dim cnt As Integer = 0
        Dim strInsertColSQL As String = ""
        Dim strInsertValSQL As String = ""
        Dim strInsertRejColSQL As String = ""
        Dim strInsertRejValSQL As String = "'"
        Dim strInsertTemptbl As String = ""
        Dim rowCnt As Integer = 0

        Dim strInsertSQL As String = ""
        ' Dim strWhizValue As String = ""
        Dim arrcnt As Integer = 0
        Dim strError As String = ""

        Try
            While rowCnt <= m_ExcelRowCnt - 1
                strInsertColSQL = " Insert Into  tbl_FCI_request" & m_strRequestID & "(ProjectID,"
                strInsertRejColSQL = " Insert Into  tbl_FCI_temp" & m_strRequestID & "(ProjectID,"
                strInsertValSQL = " ) Values (" & m_strProjectID & ","
                strInsertRejValSQL = " ) Values (" & m_strProjectID & ","
                ''While cnt < m_ExcelcolCnt - 1
                While cnt <= m_ExcelcolCnt - 1
                    While arrcnt <= m_cntDBArr - 1
                        If m_arrAttributes(cnt).ToUpper = m_arrColList(arrcnt).ToUpper Then
                            strInsertColSQL += "[" + m_arrWhizColList(arrcnt) + "],"

                            If m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE" Then
                                strInsertColSQL &= " StatusChangeTime,"
                            End If
                            If m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE" Then
                                strInsertColSQL &= " ReportedTime,"
                            End If

                            strInsertRejColSQL += "[" + m_arrColList(arrcnt) + "],"
                            'If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString = "" Then
                            '    strWhizValue = "NULL"
                            'Else
                            Select Case m_arrDataTypeList(arrcnt).ToUpper
                                Case "VARCHAR", "NVARCHAR"
                                    If m_arrWhizColList(arrcnt).ToUpper = "REPORTEDTIME" Or m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGETIME" OrElse (m_IsSingleFLDForDAteTime = True And (m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE" Or m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE")) Then
                                        'If Len(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))).ToShortTimeString) <= CType(m_arrColLength(arrcnt), Integer) Then
                                        If IsDate(CommonFunction.General.BuildQueryString(Convert.ToString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))))) Then
                                            'If Len(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)) <= 5 Then
                                            If Len(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) <= 5 Then
                                                strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(GetAttributeValues(m_arrWhizColList(arrcnt), Left(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)), 5).ToString)) & "',"
                                            Else
                                                ' strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(Format(CDate(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)), "HH:mm")) & "',"
                                                strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(GetAttributeValues(m_arrWhizColList(arrcnt), Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))), "HH:mm")).ToString) & "',"
                                            End If

                                        Else
                                            strInsertValSQL &= " NULL,"
                                            If Trim(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) <> "" Then
                                                strError &= "Time column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) & "''(" & CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) & " )not in the correct format, " & vbLf
                                            Else
                                                If m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGETIME" Then
                                                    If m_IsIssueSLAApplicable = True Then
                                                        strError &= "Time ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) & "'' is mandatory when 'Is Issue SLA Applicable' is ON, " & vbLf
                                                    End If
                                                Else
                                                    strError &= "Time column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) & "'' is mandatory when 'Single Field For Date & Time' is ON, " & vbLf
                                                End If

                                            End If
                                        End If
                                        'Else
                                        '    strInsertValSQL &= "'" & Left(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString), m_arrColLength(arrcnt)) & "',"
                                        '    strError &= "Column length exceeded for column ''" & m_arrAttributes(cnt) + "'', "
                                        'End If
                                    Else
                                        If m_arrWhizColList(arrcnt).ToUpper = "DESCRIPTION" Then
                                            m_arrColLength(arrcnt) = "4000"
                                        End If
                                        If Len(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) <= CType(m_arrColLength(arrcnt), Integer) Then
                                            strError &= ValidateAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)
                                            If GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) = "" Then
                                                strInsertValSQL &= "NULL,"
                                            Else
                                                strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)) & "',"
                                            End If

                                        Else
                                            strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(Left(CommonFunction.General.BuildQueryString(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)), m_arrColLength(arrcnt))) & "',"
                                            If Trim(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) <> "" Then
                                                strError &= "Column length exceeded for column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) + "'', "
                                            End If
                                        End If
                                    End If
                                Case "DATETIME"
                                    If Not IsDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) Then
                                        strInsertValSQL &= " NULL,"
                                        If Trim(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) <> "" Then
                                            strError &= "Date column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) & "''(" & CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) & " )not in the correct format, " & vbLf
                                        End If
                                        If m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE" Then
                                            strInsertValSQL &= " NULL,"
                                        End If
                                        If m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE" Then
                                            strInsertValSQL &= " NULL,"
                                        End If
                                    Else
                                        If m_IsSingleFLDForDAteTime = False And (m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE" Or m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE") Then
                                            Dim strTime As String = ""
                                            If m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE" Then
                                                ' If m_arrWhizColList(m_intRepTimeIndex).ToUpper = "REPORTEDTIME" Then
                                                If IsDate(CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intRepTimeIndex).ToString)) Then
                                                    If Len(CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intRepTimeIndex).ToString)) <= 5 Then
                                                        strTime = Left(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intRepTimeIndex), 5).ToString
                                                    Else
                                                        strTime = Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intRepTimeIndex)), "HH:mm")
                                                    End If
                                                End If
                                                'End If
                                                strInsertValSQL &= "'" & GetAttributeValues(m_arrWhizColList(arrcnt), Format(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)), "dd-MMM-yyyy") & " " & strTime) & "',"
                                            End If

                                            If m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE" Then
                                                'If m_arrWhizColList(m_intSCTimeIndex).ToUpper = "STATUSCHANGETIME" Then
                                                If IsDate(CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intSCTimeIndex).ToString)) Then
                                                    If Len(CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intSCTimeIndex).ToString)) <= 5 Then
                                                        strTime = Left(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intSCTimeIndex), 5)
                                                    Else
                                                        strTime = Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_intSCTimeIndex)), "HH:mm")
                                                    End If
                                                End If
                                                strInsertValSQL &= "'" & GetAttributeValues(m_arrWhizColList(arrcnt), Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))), "dd-MMM-yyyy") & " " & strTime) & "',"
                                                ' Else
                                                'End If
                                            End If
                                        Else
                                            strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(GetAttributeValues(m_arrWhizColList(arrcnt), Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))), "dd-MMM-yyyy"))) & "',"

                                            If m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "REPORTEDDATE" Then
                                                strInsertValSQL &= "'" & GetAttributeValues("REPORTEDTIME", Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))), "HH:mm")) & "',"
                                            End If
                                            If m_IsSingleFLDForDAteTime = True And m_arrWhizColList(arrcnt).ToUpper = "STATUSCHANGEDATE" Then
                                                strInsertValSQL &= "'" & GetAttributeValues("STATUSCHANGETIME", Format(CDate(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt))), "HH:mm")) & "',"
                                            End If

                                        End If
                                    End If
                                Case "INT", "FLOAT", "NUMERIC"
                                    '    If Not IsNumeric(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) Then
                                    '    strInsertValSQL &= " NULL,"
                                    '    If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString <> "" Then
                                    '        strError &= "Non numeric data in the column ''" & m_arrAttributes(cnt) & "'', " & vbLf
                                    '    End If
                                    'Else
                                    strError &= ValidateAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)
                                    If GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) = "" Then
                                        strInsertValSQL &= "NULL,"
                                    Else
                                        strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString)) & "',"
                                    End If

                                        'End If
                                Case "BIT"
                                    If IsNumeric(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) Then
                                        If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)) = 0 Or m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)) = 1 Then
                                            strInsertValSQL &= m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString & ","
                                        Else
                                            strInsertValSQL &= " NULL,"
                                            If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString <> "" Then
                                                strError &= "Non bit value in the column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) & "'', " & vbLf
                                            End If
                                        End If
                                    Else
                                        strInsertValSQL &= " NULL,"
                                        If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString <> "" Then
                                            strError &= "Non bit value in the column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) & "'', " & vbLf
                                        End If
                                    End If
                                Case Else
                                    ' strInsertValSQL &= "'" & Replace(GetAttributeValues(m_arrWhizColList(arrcnt), m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString), "'", "''") & "',"
                                    If Len(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) <= 0 Then
                                        strInsertValSQL &= "NULL,"
                                        If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString <> "" Then
                                            strError &= "Column length exceeded for column ''" & CommonFunction.General.BuildQueryString(m_arrAttributes(cnt)) + "'', "
                                        End If
                                    Else
                                        strInsertValSQL &= "'" & CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt).ToString)) & "',"
                                    End If
                            End Select
                            If m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString = "" Then
                                strInsertRejValSQL &= "null ,"
                            Else
                                strInsertRejValSQL &= "'" & CommonFunction.General.BuildQueryString(m_dXMLEntitySet.Tables(0).Rows(rowCnt).Item(m_arrColList(arrcnt)).ToString) & "',"
                            End If

                            'End If

                            'If strWhizValue = "NULL" Then
                            '    strInsertValSQL += strWhizValue + ","
                            'Else
                            'strInsertValSQL += strWhizValue
                            'End If

                        End If
                        arrcnt += 1
                    End While
                    cnt += 1
                    arrcnt = 0
                End While
                If strError <> "" Then
                    strInsertColSQL += " [Errmsg] ,[IsValid],"
                    strInsertValSQL += "'" + CommonFunction.General.BuildQueryString(strError) + "',0,"
                    strInsertRejColSQL += " [Errmsg] ,[IsValid],"
                    strInsertRejValSQL += "'" + CommonFunction.General.BuildQueryString(strError) + "',0,"
                End If

                strInsertSQL += Left(strInsertColSQL, Len(strInsertColSQL) - 1) + Left(strInsertValSQL, Len(strInsertValSQL) - 1) + ")"
                strInsertTemptbl += Left(strInsertRejColSQL, Len(strInsertRejColSQL) - 1) + Left(strInsertRejValSQL, Len(strInsertRejValSQL) - 1) + ")"
                ''Else
                ''    Dim strSQL As String = "'"
                ''    strSQL = " Update tbl_FCI_RequestStatus Set errmsg =  '" + strError + "' where RequestID = " + CStr(RequestID)
                ''    CommonFunctions.Data.InsertOrUpdateData(strSQL, True, ConnectionString)
                cnt = 0
                rowCnt += 1
                strError = ""
            End While


            ''If IsValueExists = False Then
            ''    ExportInValidRecords(m_strRequestID, "")
            ''End If

            'strInsertTemptbl = " Insert into tbl_FCI_temp" & m_strRequestID
            'strInsertTemptbl += " Select * From  tbl_FCI_request" & m_strRequestID
            CommonFunction.Data.InsertOrUpdateData(strInsertTemptbl, MyBase.UseSQL)
            CommonFunction.Data.InsertOrUpdateData(strInsertSQL, MyBase.UseSQL)
        Catch ex As Exception
            Return "Insert into Temp Table : " + ex.Message
        End Try

    End Function


    Public Shared Sub Writelog(ByVal strFilePath As String, ByVal FileName As String, ByVal WriteToLogOrErrorFile As String, ByVal strMsg As String, Optional ByVal ex As System.Exception = Nothing)
        'To Write the log information into log files
        Dim strFileName As String
        Dim w As System.IO.StreamWriter

        strFileName = strFilePath + FileName

        If File.Exists(strFileName) = True Then
            ' strMsg = File.ReadAllText(strFileName) + vbCrLf + strMsg
            w = File.AppendText(strFileName)
        Else
            w = File.CreateText(strFileName)
        End If

        'If WriteToLogOrErrorFile <> "DetailedLog" Then
        '    ' w.WriteLine("Log Time - " + Now.ToString)
        '    ' w.WriteLine("*************************************************************************" + vbCrLf)
        '    w.WriteLine(strMsg + vbCrLf)
        'Else
        If strMsg <> "" Then
            w.WriteLine(strMsg + vbCrLf)
        End If

        If Not ex Is Nothing Then
            w.WriteLine("Error Description : " + ex.Message.ToString + vbCrLf)
            w.WriteLine("Source : " + ex.Source.ToString + vbCrLf)
        End If
        w.Close()
    End Sub

    Public Function ExportInValidRecords(ByVal RequestID As Integer, ByVal strErrorMsg As String) As String
        '=====================================================================
        ' Procedure Name        : ExportInValidRecords()	
        ' Purpose               : To generate the rejected excel file
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

        Try
            Dim intNoOfRecords As Integer = 0
            Dim strIntermediateTableName As String
            'Dim strExtn As String = ""
            Dim cnt As Integer = 0

            strIntermediateTableName = "tbl_FCI_Request " & RequestID.ToString
            If File.Exists(m_strRejectedRecordsFilePath + "\" + m_strRequestID + "." + m_strUploadedFileExtn) Then
                File.Delete(m_strRejectedRecordsFilePath + "\" + m_strRequestID + "." + m_strUploadedFileExtn)
            End If
            Dim strsql As String
            strsql = "select Count(RowID) from tbl_FCI_temp" & m_strRequestID & " Where IsValid = 0 "
            intNoOfRecords = CommonFunctions.Data.GetDataScalar(strsql, True, ConnectionString)
            m_intNoRejectedRecords = intNoOfRecords

            strsql = ""
            If intNoOfRecords > 0 Then
                strsql = "SELECT * FROM tbl_FCI_temp" & m_strRequestID
                strsql &= " WHERE IsValid = 0 "
            End If

            If strsql = "" And strErrorMsg <> "" Then
                If strErrorMsg <> "" Then
                    ' strErrLog += "Attribute ""CustomerIssueID"" does not exists in the Excel Template"
                    strsql = " Update tbl_FCI_RequestStatus Set errmsg =  '" + CommonFunction.General.BuildQueryString(strErrorMsg) + "' where RequestID = " + CStr(RequestID)
                    CommonFunctions.Data.InsertOrUpdateData(strsql, True, ConnectionString)
                End If
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strsql = "SELECT ErrMsg FROM tbl_FCI_RequestStatus Where RequestID = " + m_strRequestID
                strsql = "usp_sel_tbl_FCI_RequestStatus_ErrMsg " + m_strRequestID
                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                m_intNoRejectedRecords = 1
            End If

            If m_intNoRejectedRecords > 0 Then
                Dim objAttachment As New FCI_Attachment
                objAttachment.GenerateTemplate(strsql, m_strRejectedRecordsFilePath + "\", m_strRequestID)
                'File.Copy(UploadedFilePath, m_strRejectedRecordsFilePath + "\" + m_strRequestID + ".xls")
            End If


            If m_intNoRejectedRecords > 0 Then
                strsql = " Update tbl_FCI_RequestStatus Set Status='R', RejectedRecordsFilePath =  '" + RequestID.ToString + "." + m_strUploadedFileExtn + "' where RequestID = " + CStr(RequestID)
                CommonFunctions.Data.InsertOrUpdateData(strsql, True, ConnectionString)
            Else
                strsql = " Update tbl_FCI_RequestStatus Set Status = 'I' , RejectedRecordsFilePath = null where RequestID = " + CStr(RequestID)
                CommonFunctions.Data.InsertOrUpdateData(strsql, True, ConnectionString)
            End If

        Catch ex As Exception
            Return "Export invalid Records : " + ex.Message
        End Try
    End Function
End Class





