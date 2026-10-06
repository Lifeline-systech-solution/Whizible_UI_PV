'Imports ProjectByNet
Imports System.Net
Imports Newtonsoft.Json
Imports System.Xml
Imports CommonFunction.general
Imports System.IO

Namespace CommonEngine
    Namespace General
        Public Class CLCP_Events_Attachments

            Public Shared Sub Before_ViewAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal WhizGlobal As WebPages.Template.IGlobal)
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '******************************************************************* 

                Dim strEvent As String
                strEvent = "Before_ViewAttachment"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(1) As Object
                    objParameters(0) = CType(Args, Object)
                    objParameters(1) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, _
                        CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Args = CType(objParameters(0), EventHandlers.WAF_Attachment.WAF_AttachmentView)
                    WhizGlobal = CType(objParameters(1), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '*******************************************************************    
                Select Case WhizGlobal.TagID
                    Case CommonFunction.Constants.APP_TAG_RELEASE
                        Dim strSQL As String = "usp_Sel_tbl_PM_ReleaseFiles_DirName " + Args.PrimaryKeyValue.ToString
                        Args.AttachmentFolderPath = CommonFunctions.FileDirectory.CleanPath(Args.AttachmentFolderPath) + CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


                End Select
            End Sub

            Public Shared Sub Initialize_Attachment(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Initialize, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before plotting attachment UI
                Cancel = False
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective Tag's event handler.
                '*******************************************************************
                Dim strEvent As String
                strEvent = "Initialize_Attachment"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(2) As Object
                    objParameters(0) = CType(Cancel, Object)
                    objParameters(1) = CType(Args, Object)
                    objParameters(2) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Cancel = CType(objParameters(0), Boolean)
                    Args = CType(objParameters(1), EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Initialize)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '*******************************************************************  
                Select Case WhizGlobal.TagID

                End Select
            End Sub

            Public Shared Sub Before_FileControl_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before printing File Control
                Cancel = False
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '*******************************************************************    
                Dim strEvent As String
                strEvent = "Before_FileControl_Print"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(2) As Object
                    objParameters(0) = CType(Cancel, Object)
                    objParameters(1) = CType(Args, Object)
                    objParameters(2) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Cancel = CType(objParameters(0), Boolean)
                    Args = CType(objParameters(1), EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '*******************************************************************    

                Select Case WhizGlobal.TagID

                End Select
            End Sub

            Public Shared Sub Before_Description_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before printing File Control
                Cancel = False
                Dim strEvent As String
                strEvent = "Before_Description_Print"
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '*******************************************************************    
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(2) As Object
                    objParameters(0) = CType(Cancel, Object)
                    objParameters(1) = CType(Args, Object)
                    objParameters(2) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Cancel = CType(objParameters(0), Boolean)
                    Args = CType(objParameters(1), EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                Select Case WhizGlobal.TagID
                    Case CommonFunction.Constants.APP_TAG_TEMPLATES
                        Cancel = True
                End Select
            End Sub

            Public Shared Sub After_UI_Print(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control, ByVal WhizGlobal As WebPages.Template.IGlobal)
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '******************************************************************* 
                Dim strEvent As String
                strEvent = "After_UI_Print"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(1) As Object
                    objParameters(0) = CType(Args, Object)
                    objParameters(1) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Args = CType(objParameters(0), EventHandlers.WAF_Attachment.WAF_AttachmentUI.WAF_Control)
                    WhizGlobal = CType(objParameters(1), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'This event will occur before plotting attachment UI
                Select Case WhizGlobal.TagID

                End Select
            End Sub

            Public Shared Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before Uploading attachment
                Cancel = False
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '******************************************************************* 
                Dim strEvent As String
                strEvent = "Before_UploadAttachment"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(2) As Object
                    objParameters(0) = CType(Cancel, Object)
                    objParameters(1) = CType(Args, Object)
                    objParameters(2) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Cancel = CType(objParameters(0), Boolean)
                    Args = CType(objParameters(1), EventHandlers.WAF_Attachment.WAF_AttachmentUpload)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_RELEASE
                            Dim strSQL As String = "usp_Sel_v_tbl_PM_Project " + WhizGlobal.ProjectID.ToString
                            Dim strDir As String = CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString + Replace(Replace(Date.Now.ToString, "/", "-"), ":", "-")
                            Args.AttachmentFolderPath = Replace(CommonFunctions.FileDirectory.CleanPath(Args.AttachmentFolderPath) + strDir, "\", "/")
                            Dim objDir As System.IO.DirectoryInfo
                            objDir = New System.IO.DirectoryInfo(HttpContext.Current.Server.MapPath(Args.AttachmentFolderPath))
                            If objDir.Exists = False Then
                                'Create the Sub Folder
                                objDir.Create()
                            End If
                            'Destroy the object
                            objDir = Nothing


                    End Select
                Else
                    'For Details Tag

                End If
            End Sub

            Public Shared Sub After_UploadAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur After Uploading attachment
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '*******************************************************************   
                Dim strEvent As String
                strEvent = "After_UploadAttachment"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(1) As Object
                    objParameters(0) = CType(Args, Object)
                    objParameters(1) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Args = CType(objParameters(0), EventHandlers.WAF_Attachment.WAF_AttachmentUpload)
                    WhizGlobal = CType(objParameters(1), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_COMPANY_INFORMATION
                            'Modified By NileshD on 19 Sep 2005
                            'Purpose: To to logo path as , Customer logo would crash when uploaded
                            'Dim strDestFilePath As String = CommonFunction.FileDirectory.CleanPath(Args.AttachmentFolderPath) + "CustomerLogo.gif"
                            Dim strDestFilePath As String = HttpContext.Current.Server.MapPath(CommonFunction.FileDirectory.CleanPath(Args.AttachmentFolderPath) + "CustomerLogo.gif")
                            'Dim strSourceFilePath As String = CommonFunction.FileDirectory.CleanPath(Args.AttachmentFolderPath) + Args.SystemFileName
                            Dim strSourceFilePath As String = HttpContext.Current.Server.MapPath(CommonFunction.FileDirectory.CleanPath(Args.AttachmentFolderPath) + Args.SystemFileName)
                            'End Modification 
                            Dim objFile As New System.IO.FileInfo(strDestFilePath)
                            'If the Dest file exists then change its attributes to Normal to avoid Permossion Denied error for Read Only file 
                            If objFile.Exists = True Then objFile.Attributes = IO.FileAttributes.Normal
                            objFile = Nothing
                            System.IO.File.Copy(strSourceFilePath, strDestFilePath, True)
                            'Args.OriginalFileName = "CustomerLogo.gif"
                    End Select
                Else
                    'For Details Tag

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
                'allDone.WaitOne()


            End Function
            Public Shared Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before Save attachment
                Cancel = False
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '*******************************************************************    
                ''Added by swapnil aswale on 15-06-2016
                Dim response As String = String.Empty
                'Dim file As HttpPostedFile = HttpContext.Current.Request.Files(0)
                Dim buffer As Byte() = New Byte(256) {}
                Dim strListofTypes As String = ConfigurationManager.AppSettings("FileContentType")
                Dim MimeType As String
                'CommonFunction.General.PostedFileObj.InputStream.Read(buffer, 0, 256)
                buffer = CommonFunction.General.buffer

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
                'Commented By Bharat Tekade on 29th-Aug-2016 to solve mime type issues
                'file.InputStream.Read(buffer, 0, 256)
                Dim magicNumber As String = BitConverter.ToString(buffer)
                magicNumber = magicNumber.Replace("-", " ")



                Dim xmlDoc As New XmlDocument()
                Dim xmlPath As String = CommonFunctions.FileDirectory.CleanPath(System.AppDomain.CurrentDomain.BaseDirectory)
                xmlDoc.Load(xmlPath + "MIMEType.xml")
                Dim nodes As XmlNodeList = xmlDoc.DocumentElement.SelectNodes("/MIMETYPE/MIME")
                Dim xMagicNumber As String = "", xContentType As String = ""
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
                If MimeType Is Nothing Then
                    MimeType = "unknown/unknowns"
                End If
                'End If

                If strListofTypes.IndexOf(MimeType) >= 0 Then
                Else
                    Cancel = True
                End If
                ''Ended by swapnil aswale on 15-06-2016

                Dim strEvent As String
                strEvent = "Before_SaveAttachment"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(2) As Object
                    objParameters(0) = CType(Cancel, Object)
                    objParameters(1) = CType(Args, Object)
                    objParameters(2) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Cancel = CType(objParameters(0), Boolean)
                    Args = CType(objParameters(1), EventHandlers.WAF_Attachment.WAF_AttachmentSave)
                    WhizGlobal = CType(objParameters(2), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                Select Case WhizGlobal.TagID
                    Case CommonFunction.Constants.APP_TAG_TEMPLATES
                        Dim strSQL As String


                        'Added by PrachiK on 17 Mar  2005 for IssueID 16119
                        'Purpose:When Single Quotes are used in Deliverable Title, we cannot associate this Deliverable with any other tasks etc...
                        Dim strDescription As String = ""
                        If (Not (HttpContext.Current.Request.Form("txtDescription")) Is Nothing) Then
                            If (HttpContext.Current.Request.Form("txtDescription") = "") Then
                                strDescription = ""
                            Else
                                strDescription = CType(HttpContext.Current.Request.Form("txtDescription"), String)
                            End If
                        End If

                        strSQL = "UPDATE " + Args.DataSource + " SET " + Args.AttTblCol_OriginalFileName + "='" + Args.AttTblCol_OriginalFileNameValue + "'," + Chr(13) + Chr(10) _
                            + Args.AttTblCol_SystemFileName + "='" + Args.AttTblCol_SystemFileNameValue + "'," + Chr(13) + Chr(10) _
                            + Args.AttTblCol_AttachedBy + "='" + CommonFunction.General.BuildQueryString(WhizGlobal.UserName) + "'," + Chr(13) + Chr(10) _
                            + Args.AttTblCol_LoginType + "='" + WhizGlobal.LoginType + "'," + Chr(13) + Chr(10) _
                            + Args.AttTblCol_DateAttached + "=getdate()," + Chr(13) + Chr(10) _
                            + Args.AttTblCol_Description + "='" + strDescription + "'" + Chr(13) + Chr(10) _
                            + " WHERE " + Args.AttTblCol_ForeignKey + " ='" + Args.AttTblCol_ForeignKeyValue + "'"
                        'Addtion ended
                        'Save without description
                        CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        'Cancel the actual save
                        Cancel = True
                End Select
            End Sub

            Public Shared Sub After_SaveAttachment(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur After Save attachment
                '*******************************************************************    
                ' Code Added:RajeshB                    23rd September, 2004
                ' Purpose: Route event to respective tag's event handler.
                '*******************************************************************    
                Dim strEvent As String
                strEvent = "After_SaveAttachment"
                Dim blnUseRouter As Boolean = False
                blnUseRouter = WAF.EventRouter.CheckRouterUse(WhizGlobal.TagID, WhizGlobal.ParentTagID, strEvent)

                If blnUseRouter = True Then
                    Dim objParameters(1) As Object
                    objParameters(0) = CType(Args, Object)
                    objParameters(1) = CType(WhizGlobal, Object)
                    WAF.EventRouter.RouteRequest(objParameters, strEvent, CType(WhizGlobal.TagID, String), WhizGlobal.ParentTagID)
                    Args = CType(objParameters(0), EventHandlers.WAF_Attachment.WAF_AttachmentSave)
                    WhizGlobal = CType(objParameters(1), WebPages.Template.IGlobal)
                    Return
                End If
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                If WhizGlobal.ParentTagID = 0 Then
                    'For Master Tag
                    Select Case WhizGlobal.TagID
                        Case CommonFunction.Constants.APP_TAG_RELEASE
                            Dim strPathAry() As String = Split(Args.AttachmentFolderPath, "/")
                            'code modified by SandiPL on 30 Nov 2005 --IssueID 672  -- to solve problem of improper path in case project code contains / e.g. cspl/\bng/sdfds
                            ' Dim strFolder As String = strPathAry(strPathAry.Length - 1)
                            Dim strFolder As String = Args.AttachmentFolderPath.Substring(15)
                            'End modification by SandipL on 30 Nov 2005
                            Dim strSQL As String = "usp_Upd_tbl_PM_ReleaseFiles " + Args.AttTblCol_PrimaryKeyValue + ",'" + CommonFunctions.General.BuildQueryString(strFolder) + "'," + WhizGlobal.ProjectID.ToString
                            CommonFunctions.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                            'added by SachinR   on 1 Sep 2004
                        Case CommonFunction.Constants.APP_TAG_PROCESS_PHASETASK
                            'update the status of the phasetask to draft after saving the document
                            'parent tagid is zero for subtag also so case written in Tag section
                            Dim strSQL As String
                            strSQL = "usp_Upd_UpdatePhaseTaskDraftStatus " + Args.AttTblCol_ForeignKeyValue.Trim
                            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                            'addition end

                            '    'Code Added for DXU - VidyaJ
                            'Case CommonFunction.Constants.APP_TAG_TEMPLATE_DESIGN
                            '    '__________Added By HemantB on Dec 09, 2004 for Template Design Utility________________________
                            '    Dim strConnStringExcel As String
                            '    'Getting Path of the Uploaded file.
                            '    Dim strSourceFilePath As String = HttpContext.Current.Server.MapPath(CommonFunction.FileDirectory.CleanPath(Args.AttachmentFolderPath) + Args.AttTblCol_SystemFileNameValue)

                            '    Dim objConnection As New ADODB.Connection
                            '    'Catalog object for getting all the sheets in an EXCEL workbook.

                            '    Dim objExcel As New ADOX.Catalog

                            '    Dim objConn As New CommonFunctions.Connection
                            '    Dim objData As CommonFunctions.Data
                            '    Dim objDataReader As System.Data.IDataReader

                            '    Dim sqlCmd As SqlClient.SqlCommand

                            '    'Connection string for EXCEL file.
                            '    strConnStringExcel = "Provider=" & _
                            '       "Microsoft.Jet.OLEDB.4.0;" & _
                            '       "Data Source=" & strSourceFilePath & ";" & _
                            '       "Extended Properties=Excel 8.0;"

                            '    objConnection.Open(strConnStringExcel)
                            '    objExcel.ActiveConnection = objConnection

                            '    Dim strSQL As String
                            '    strSQL = "SELECT TOP 1 * FROM [" & objExcel.Tables(0).Name & "]"
                            '    strSQL = "SELECT TOP 1 * FROM [Sheet1$]"

                            '    'Getting TemplateID - Template for which this file is uploaded.
                            '    Dim intTemplateId As Integer
                            '    intTemplateId = CType(Args.AttTblCol_ForeignKeyValue, Integer)

                            '    Dim intCounter As Integer = 0

                            '    objDataReader = objData.GetDataReader(strSQL, False, strConnStringExcel)
                            '    sqlCmd = New SqlClient.SqlCommand
                            '    sqlCmd.Connection = objConn.GetSQLConnection(CommonFunction.General.GetConnectionString)


                            '    'Delete earlier records from the TemplateDetails table while re-uploading for the already
                            '    'existing Template.
                            '    Dim strCheckSQL As String = "Select * from tbl_DXU_TemplateDetails where TemplateID = " & intTemplateId
                            '    Dim objChkDataReader As System.Data.IDataReader

                            '    objChkDataReader = objData.GetDataReader(strCheckSQL, True)
                            '    If objChkDataReader.Read = True Then
                            '        strSQL = "Delete from tbl_DXU_TemplateDetails where TemplateId = " & intTemplateId
                            '        sqlCmd.CommandText = strSQL
                            '        sqlCmd.ExecuteNonQuery()
                            '    End If

                            '    'Inserting each column-headers of the EXCEL file into the Template Details table.
                            '    For intCounter = 0 To objDataReader.FieldCount - 1
                            '        strSQL = "Insert into tbl_DXU_TemplateDetails (TemplateId,TemplateFieldName,ActualExcelColName) values("
                            '        strSQL &= intTemplateId & ",'"
                            '        strSQL &= Replace(objDataReader.GetName(intCounter), " ", "") & "','"
                            '        strSQL &= objDataReader.GetName(intCounter) & "')"
                            '        sqlCmd.CommandText = strSQL
                            '        sqlCmd.ExecuteNonQuery()
                            '    Next

                            '    '__________Addition by HemantB ends here________________________
                            'Case CommonFunction.Constants.APP_TAG_UPLOAD_DATA ', CommonFunction.Constants.TAG_UPLOAD_DATA_PROJECTTAB

                            '    Dim objRequest As New DataExchangeLib.Request
                            '    With objRequest
                            '        .ConnectionString = CommonFunction.General.GetConnectionString
                            '        .LogFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Logs")
                            '        .RejectedRecordsFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/RejectedFiles")
                            '        .UploadedFilePath = HttpContext.Current.Server.MapPath("../../Attachments/DXU/Requests")
                            '        '.RequestID = HttpContext.Current.Request.Form("RequestID_PK") 'this is nothing 
                            '        'as Current.Request.Form is attachments form, get value from Request.Form("foreignkeyvalue")
                            '        .RequestID = CType(HttpContext.Current.Request.Form("foreignkeyvalue"), Integer)
                            '        .Post()
                            '    End With
                            '    objRequest = Nothing
                            '    'End Of addition

                            'Addition by SuchitraP on 12 Sept 2007
                        Case CommonFunction.Constants.APP_TAG_COMPANY_INFORMATION
                            Call CommonFunction.General.LoadCompanyApplicationSettings()
                            'End of addition by SuchitraP on 12 Sept 2007

                    End Select
                Else
                    'For Details Tag
                    Select Case WhizGlobal.TagID


                    End Select

                End If
            End Sub

            '_______________________Added By UmeshJ on 18 November 2004___________________________#ATT18
            Public Shared Sub Initialize_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteInitialize, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before plotting attachment UI
                Cancel = False
                Select Case WhizGlobal.TagID

                End Select
            End Sub
            Public Shared Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before plotting attachment UI
                Cancel = False
                Select Case WhizGlobal.TagID
                    Case CommonFunction.Constants.APP_TAG_RELEASE
                        Dim strSQL As String = ""
                        If Args.PrimaryKeyValue <> "" Then
                            strSQL = "SELECT DirName FROM tbl_PM_ReleaseFiles WHERE FileID = " + Args.PrimaryKeyValue
                            Args.AttachmentFolderPath += CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, CBool(CommonFunction.General.GetApplicationKeySetting("UseSQL"))))
                            Args.AttachmentFolderPath = CommonFunctions.FileDirectory.CleanPath(Args.AttachmentFolderPath)
                        End If


                End Select
            End Sub
            Public Shared Sub After_AttachmentDelete(ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)
                'This event will occur before plotting attachment UI
                Select Case WhizGlobal.TagID

                End Select
            End Sub
            '_______________________End of addition on 18 November 2004___________________________

        End Class
    End Namespace
End Namespace
