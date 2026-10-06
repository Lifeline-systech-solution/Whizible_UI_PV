
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports Microsoft.SharePoint
Imports System.Data.SqlClient
Imports Whiz.Sharepoint.DocumentManagement
Imports Whiz.EPM.P2007PSI
Imports System.Net


Partial Public Class WhizDocManagement
    ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

#Region "Private Constants"
    Private Const APP_TAG_REVIEW As Integer = 3627
#End Region

#Region "Public Variables"
    'private string m_strFromWhere = "";
    Private m_intMasterTagID As Integer
    Protected strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
    Protected blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))
    Private intProjectID As Integer
    Private strProjectServerURL As String
    Private m_intPrimaryKey As Integer
#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)

        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016

        Try

            'add client side event to the close button
            btnBottomClose.Attributes.Add("onclick", "javascript:Window_Close()")
            btnClose.Attributes.Add("onclick", "javascript:Window_Close()")

            'Set connection string
            'strConnectionString = CommonFunctions.General.BuildConnectionString(ConfigurationManager.AppSettings.Get("ConnectionString"))
            'First findout from where the page is called
            If Request.QueryString("MasterTagID") Is Nothing Then
                m_intMasterTagID = 0
            Else
                m_intMasterTagID = System.Convert.ToInt32(Request.QueryString("MasterTagID"))
            End If

            'get the record id
            If Request.QueryString("RecordID") Is Nothing Then
                m_intPrimaryKey = 0
            Else
                m_intPrimaryKey = System.Convert.ToInt32(Request.QueryString("RecordID"))
            End If

            If Request.QueryString("ProjectID") Is Nothing Then
                intProjectID = 0
            Else
                intProjectID = System.Convert.ToInt32(Request.QueryString("ProjectID"))
            End If

            Dim strUserName As String = ""
            Dim strPassword As String = ""
            Dim strDomainName As String = ""


            'Get_PSI_Credentials(strUserName, strPassword, strDomainName)

            strProjectServerURL = ProjectServerURL(m_intMasterTagID, m_intPrimaryKey, intProjectID)

            Select Case m_intMasterTagID
                Case Else
                    'Find out whether document library is created for the project
                    'If its not created then create the file.
                    If isDocumentLibraryCreated(m_intMasterTagID, intProjectID, strConnectionString) = False Then
                        'ShowMessage("Document Library not found. Need to be created.")
                        CreateDocumentLibrary(m_intMasterTagID, strProjectServerURL, intProjectID, strConnectionString)
                    End If
            End Select

        Catch ex As Exception
            ShowMessage("Page_Load" + ex.StackTrace.Replace(Environment.NewLine, " "), True)
        End Try

    End Sub 'Page_Load

    Public Shared Function isDocumentLibraryCreated(ByVal intMasterTagID As Integer, ByVal intProjectID As Integer, ByVal strConnectionString As String) As Boolean

        Dim blnReturnValue As Boolean = False
        Dim strSQL As String = "SELECT DocumentLibraryID FROM tbl_SP_DocumentLibrary WHERE MasterTagID = " + System.Convert.ToString(intMasterTagID)
        Dim intDocumentLibraryID As Integer = 0
        Try
            If System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString), "")) = "" Then
                intDocumentLibraryID = 0
            Else
                intDocumentLibraryID = System.Convert.ToInt32(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))
            End If
            'ShowMessage("intDocumentLibraryId:" + System.Convert.ToString(intDocumentLibraryID))
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            'strSQL = "SELECT DocumentLibraryGUID FROM tbl_SP_ProjectDocumentLibraries WHERE ProjectID = " + System.Convert.ToString(intProjectID) + " AND DocumentLibraryID = " + System.Convert.ToString(intDocumentLibraryID)
            strSQL = "usp_sel_tbl_SP_ProjectDocumentLibraries_Project " + System.Convert.ToString(intProjectID) + "," + System.Convert.ToString(intDocumentLibraryID)
            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


            If System.Convert.ToString(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString), "")) = "" Then
                blnReturnValue = False
            Else
                blnReturnValue = True
            End If

            Return blnReturnValue

        Catch ex As Exception
            ShowMessage("Is Doc Lib created ", True)
        End Try

    End Function 'isDocumentLibraryCreated



    Public Shared Sub CreateDocumentLibrary(ByVal intMasterTagID As Integer, ByVal strProjectServerURL As String, Optional ByVal intProjectID As Integer = 0, Optional ByVal strConnectionString As String = "")
        Dim strSQL As String = ""
        '"USP_ins_tbl_SP_ProjectDocumentLibraries " + System.Convert.ToString(intProjectID) + ",1,'" + strGUID + "'";

        strSQL = "SELECT * FROM tbl_SP_DocumentLibrary WHERE MasterTagID= " + System.Convert.ToString(intMasterTagID)

        Dim objDr As IDataReader = Nothing
        Dim strDocLibraryID As String = ""
        Dim strDocLibraryName As String = ""
        Dim strDocLibraryDesc As String = ""

        Dim strGUID As String = ""

        Dim strText As String = ""


        If strConnectionString = "" Then
            strConnectionString = CommonFunctions.General.BuildConnectionString(ConfigurationManager.AppSettings.Get("ConnectionString"))
        End If

        Try

            objDr = CommonFunctions.Data.GetDataReader(strSQL, True, strConnectionString, False, False)
            If objDr.Read() Then
                strDocLibraryID = System.Convert.ToString(objDr("DocumentLibraryID"))
                strDocLibraryName = System.Convert.ToString(objDr("DocumentLibraryName"))
                strDocLibraryDesc = System.Convert.ToString(objDr("DocumentLibraryDescription"))
            End If
            If Not (objDr Is Nothing) Then
                objDr = Nothing
            End If

            'ShowMessage("Doc Lib: strDocLibraryID:" + strDocLibraryID)
            'ShowMessage("Doc Lib: strDocLibraryName:" + strDocLibraryName)
            'ShowMessage("Doc Lib: strDocLibraryDesc:" + strDocLibraryDesc)
            'ShowMessage("Doc Lib: strProjectServerURL:" + strProjectServerURL)

            'Dim objWhizDoc As WhizDocumentManagement = New WhizDocumentManagement(strProjectServerURL)

            'ShowMessage("Whiz Doc Lib object is created.")

            'create document library
            'Dim objWhizDocLib As WhizDocumentLibrary = objWhizDoc.CreateDocumentLibrary(strDocLibraryName, strDocLibraryDesc)

            'ShowMessage("Whiz Doc Library is created.")

            ' strGUID = System.Convert.ToString(objWhizDocLib.DocumentLibraryUniqueID)

            'ShowMessage("Doc Lib: strGUID:" + strGUID)
            'ShowMessage("Doc Lib: Name:" + objWhizDocLib.DocumentLibraryName)

            'store newly created document library details
            strSQL = "USP_ins_tbl_SP_ProjectDocumentLibraries " + System.Convert.ToString(intProjectID) + "," + strDocLibraryID + ",'" + strGUID + "'"
            'HttpContext.Current.Response.Write(strSQL)
            'ShowMessage("Doc Lib: StrSQL:" + strSQL)
            'strText = strText + " Doc Lib: StrSQL:" + strSQL

            CommonFunctions.Data.InsertOrUpdateData(strSQL, True, strConnectionString)


            ShowMessage("Document Library is created successfully. Now you can upload a file to it.", False)

            'If Not (objWhizDocLib Is Nothing) Then
            '    objWhizDocLib = Nothing
            'End If
            'If Not (objWhizDoc Is Nothing) Then
            '    objWhizDoc = Nothing
            'End If

        Catch ex As Exception
            Dim strMSG As String = " Error in Create Document Library " & ex.Message
            ShowMessage(strMSG, True)
        Finally

        End Try
    End Sub 'CreateDocumentLibrary

    Public Shared Sub DownloadFile(ByVal strDocumentLibraryGUID As String, ByVal strFileGUID As String, ByVal strFileName As String, ByVal strProjectServerURL As String)
        'Dim objWhizDocMGMT As WhizDocumentManagement = New WhizDocumentManagement(strProjectServerURL)
        Dim arrFile As Byte() = Nothing
        Dim Buffer As Byte()
        Try
            'ShowMessage(strDocumentLibraryGUID, True)
            'ShowMessage(strFileGUID, True)
            ShowMessage(strFileName, True)
            ShowMessage(strProjectServerURL, True)
            'arrFile = objWhizDocMGMT.ReadDocument(New Guid(strDocumentLibraryGUID), New Guid(strFileGUID))

            HttpContext.Current.Response.ContentType = "application/octet-stream"
            HttpContext.Current.Response.AddHeader("Content-Disposition", "attachment; filename=" + strFileName)
            ' Write the data to the current output stream.
            HttpContext.Current.Response.Clear()

            If arrFile.Length > 0 Then
                If HttpContext.Current.Response.IsClientConnected = True Then
                    HttpContext.Current.Response.OutputStream.Write(arrFile, 0, arrFile.Length)
                End If
                ' Flush the data to the HTML output.
            End If
            HttpContext.Current.Response.Flush()
        Catch ex As Exception
            ShowMessage(ex.Message.Replace(Environment.NewLine, " "), True)
        Finally
            'If Not (objWhizDocMGMT Is Nothing) Then
            '    objWhizDocMGMT = Nothing
            'End If
        End Try

    End Sub 'DownloadFile

    Public Shared Function ProjectServerURL(ByVal MasterTagId As Integer, ByVal RecordID As Integer, ByVal ProjectID As Integer, Optional ByVal StrConnectionString As String = "") As String
        Dim strProjectServerURL As String = ""
        Try
            If StrConnectionString = "" Then
                StrConnectionString = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
            End If

            'If user is in a workspace then we get following property directly 
            'else we need to findout the URL of WSS Site for the project

            'If Not (SPContext.Current.Web.AllProperties("MSPWAPROJUID") Is Nothing) Then
            '    If (ProjectID = 0) Then
            '        'HttpContext.Current.Response.Write("MSPWAPROJUID ProjecTId 0 ")
            '        strProjectServerURL = System.Convert.ToString(SPContext.Current.Web.AllProperties("PWAURL").ToString())
            '    Else
            '        'HttpContext.Current.Response.Write("MSPWAPROJUID ProjecTId = " + ProjectID.ToString() + " SPContext.Current.Web.Url" + SPContext.Current.Web.Url + " MSPWAPROJUID" + SPContext.Current.Web.AllProperties("MSPWAPROJUID").ToString())
            '        strProjectServerURL = System.Convert.ToString(GetWSSURL(SPContext.Current.Web.Url.ToString(), ProjectID, StrConnectionString))
            '    End If
            'ElseIf ProjectID = 0 Then
            '    'HttpContext.Current.Response.Write("MSPWAPROJUID null  ProjecTId  0 ")
            '    strProjectServerURL = SPContext.Current.Web.Url
            'Else
            '    'HttpContext.Current.Response.Write("MSPWAPROJUID null  ProjecTId  " + ProjectID.ToString())
            '    strProjectServerURL = System.Convert.ToString(GetWSSURL(SPContext.Current.Web.Url.ToString(), ProjectID, StrConnectionString))

            'End If
            'HttpContext.Current.Response.Write(",strProjectServerURL: " + strProjectServerURL)

            'strProjectServerURL = "http://192.168.100.19:10504/pwa"
            Return strProjectServerURL

        Catch ex As Exception
            ShowMessage("Error at ProjectServerURL " + ex.Message.Replace(Environment.NewLine, " "), True)
        End Try
    End Function

    Public Shared Function GetWSSURL(ByVal strURL As String, Optional ByVal ProjectID As Integer = 0, Optional ByVal strConnectionString As String = "") As String

        Try

            If strConnectionString = "" Then
                strConnectionString = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
            End If

            Dim strProjectGUID As String = GetProjectGUID(ProjectID, strConnectionString)


            'Looging in
            Dim cookies As New CookieContainer()
            'Dim objLogon As New Logon()
            Dim strUserName As String = ""
            Dim strPassword As String = ""
            Dim strDomainName As String = ""


            'Get_PSI_Credentials(strUserName, strPassword, strDomainName)


            'objLogon.UserName = strUserName
            'objLogon.Password = strPassword
            'objLogon.DomainName = strDomainName


            'objLogon.WindowsLogin = True
            'objLogon.ProjectServerURL = strURL
            'cookies = objLogon.LogonToProjectServer()


            'Dim objProj As New Whiz.EPM.P2007PSI.Project()

            'objProj.Credentials = objLogon.LoginCredentials
            'objProj.LoginCookie = cookies
            'objProj.ProjectServerURL = objLogon.ProjectServerURL

            'Return objProj.GetWSSURL(New Guid(strProjectGUID))

        Catch ex As Exception
            ShowMessage(" GetwssURL " + ex.StackTrace.Replace(Environment.NewLine, " "), True)
        Finally
            'objLogon.Logoff()
        End Try
    End Function 'GetWSSURL

    Public Shared Function GetProjectGUID(ByVal ProjectID As Integer, ByVal strConnectionString As String) As String
        Dim strSQL As String = "SELECT P12ProjectID FROM tbl_PM_Project WHERE ProjectID = " + System.Convert.ToString(ProjectID)
        Try

        
            Return System.Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))
        Catch ex As Exception
            ShowMessage("GetProjectGUID", True)
        End Try
    End Function 'GetProjectGUID



    Public Shared Sub ShowMessage(ByVal strMessage As String, Optional ByVal isError As Boolean = True)
        HttpContext.Current.Response.Write("<script language='javascript' >" + Environment.NewLine)
        strMessage = System.Convert.ToString(strMessage).Replace(Chr(13), " ")
        strMessage = System.Convert.ToString(strMessage).Replace(Chr(10), " ")
        HttpContext.Current.Response.Write("alert(""" + strMessage + """);" + Environment.NewLine)
        HttpContext.Current.Response.Write("</script>")
    End Sub

    Private Sub SetDataGrid()
        Dim objDS As DataSet = Nothing
        Dim objDA As SqlDataAdapter = Nothing
        Dim strSQL As String = "USP_SEL_tbl_SP_UploadedFiles " + System.Convert.ToString(m_intMasterTagID)
        strSQL += "," + System.Convert.ToString(m_intPrimaryKey)
        Try
            objDA = New SqlDataAdapter(strSQL, strConnectionString)
            objDS = New DataSet()
            objDA.Fill(objDS)
            gdWhizDocuments.DataSource = objDS
            gdWhizDocuments.DataMember = objDS.Tables(0).TableName
            gdWhizDocuments.DataBind()
        Catch ex As Exception
            ShowMessage(ex.Message.Replace(Environment.NewLine, " "), True)
        Finally
            If Not (objDS Is Nothing) Then
                objDS = Nothing
            End If
            If Not (objDA Is Nothing) Then
                objDA = Nothing
            End If
        End Try
    End Sub 'SetDataGrid

    '/ <summary>
    '/ Creates document library for given Master TagID in Sharepoint
    '/ </summary>
    '/ <param name="intMasterTagID">Tag Id of the page for which you want to create the document library</param>
 

    'Private Sub ShowMessage(ByVal strMessage As String, ByVal isError As Boolean)
    '    If isError = True Then
    '        'lblMessage.Text = lblMessage.Text + "<BR>" + strMessage;
    '        'lblMessage.ForeColor = System.Drawing.Color.Red;
    '        lblErrorMessage.Text = strMessage
    '        lblErrorMessage.Visible = True
    '    Else
    '        'lblMessage.Text = lblMessage.Text + "<BR>" + strMessage;
    '        'lblMessage.ForeColor = System.Drawing.Color.Black;
    '        lblErrorMessage.Text = ""
    '        lblErrorMessage.Visible = False
    '    End If
    'End Sub 'ShowMessage
    'lblMessage.Text = strMessage;



    Protected Sub btnUpload_Click(ByVal sender As Object, ByVal e As EventArgs)
        'Dim objWhizDocMGMT As WhizDocumentManagement = Nothing
        'Dim objWhizDoc As WhizDocument = Nothing
        Dim docLibGuid As Guid
        Dim flUploadingFile As Byte() = Nothing
        Dim FileSize As Long = 0
        Dim strSQL As System.Text.StringBuilder = New System.Text.StringBuilder("USP_INS_tbl_SP_UploadedFiles ")
        Dim blnIsSingleDocument As Boolean = False
        Try
            'If ctlFileUpload.FileName <> "" Then
            '    'objWhizDocMGMT = New WhizDocumentManagement(strProjectServerURL)
            '    'docLibGuid = New Guid(GetDocLibUID())
            '    'flUploadingFile = ctlFileUpload.FileBytes
            '    'FileSize = ctlFileUpload.FileContent.Length / 1024

            '    'objWhizDoc = objWhizDocMGMT.UploadDocument(docLibGuid, flUploadingFile, ctlFileUpload.FileName)
            '    strSQL.Append("'" + System.Convert.ToString(objWhizDoc.WhizDocGUID) + "',")
            '    strSQL.Append(GetDocLibID() + ",")
            '    strSQL.Append("'" + objWhizDoc.WhizDocTitle + "',")
            '    strSQL.Append("'" + objWhizDoc.WhizDocCreatedBy + "',")
            '    strSQL.Append("'" + objWhizDoc.WhizDocCreatedDate + "',")
            '    strSQL.Append(System.Convert.ToString(m_intPrimaryKey) + ",")
            '    strSQL.Append(System.Convert.ToString(m_intMasterTagID) + ",'")
            '    strSQL.Append(txtDescription.Text + "',")
            '    strSQL.Append(FileSize.ToString())
            '    CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString, True, strConnectionString)


            '    HttpContext.Current.Response.Write("<script type='text/javascript' language='javascript' >" + Environment.NewLine)
            '    HttpContext.Current.Response.Write("window.opener.location.href= window.opener.location.href;" + Environment.NewLine)
            '    HttpContext.Current.Response.Write("</script>")

            '    ' Check whether IssingleDocument is true for the selected Document Library.

            '    blnIsSingleDocument = System.Convert.ToBoolean(CommonFunctions.Data.GetDataScalar("SELECT IsNull( IsSingleDocument ,0) FROM tbl_SP_DocumentLibrary WHERE MasterTagID =" + m_intMasterTagID.ToString(), blnUseSQL, strConnectionString))

            '    If blnIsSingleDocument = True Then
            '        ' If Yes delete other documents uploaded earlier to the selected recordId if exists
            '        Dim objdr As IDataReader
            '        Dim strUploadedFilesID As String
            '        strSQL.Length = 0
            '        strSQL.Append("SELECT UploadedFilesID FROM Tbl_SP_uploadedfiles WHERE MasterTagID = ")
            '        strSQL.Append(m_intMasterTagID.ToString())
            '        strSQL.Append(" AND RecordID = " + m_intPrimaryKey.ToString())
            '        strSQL.Append(" AND UploadedFileGUID <> '")
            '        strSQL.Append(objWhizDoc.WhizDocGUID.ToString())
            '        strSQL.Append("' ")
            '        objdr = CommonFunctions.Data.GetDataReader(strSQL.ToString, blnUseSQL, strConnectionString)

            '        While objdr.Read()
            '            strUploadedFilesID = objdr("UploadedFilesID").ToString()
            '            DeleteSharePointDocument(m_intMasterTagID, m_intPrimaryKey, strUploadedFilesID, strProjectServerURL)
            '        End While

            '        CommonFunctions.Data.DisposeDataReader(objdr)

            '    End If

            'Else
            '    ShowMessage("Please select a file to upload.", True)
            'End If
            'refresh datagrid
            'SetDataGrid()
        Catch ex As Exception
            ShowMessage(ex.Message.Replace(Environment.NewLine, " "), True)
        Finally
            'If Not (objWhizDoc Is Nothing) Then
            '    objWhizDoc = Nothing
            'End If
            'If Not (objWhizDocMGMT Is Nothing) Then
            '    objWhizDocMGMT = Nothing
            'End If
            'If Not (flUploadingFile Is Nothing) Then
            '    flUploadingFile = Nothing
            'End If
        End Try
    End Sub 'btnUpload_Click

    Private Function GetDocLibUID() As String

        Dim strSQL As String = "SELECT DocumentLibraryGUID FROM tbl_SP_ProjectDocumentLibraries WHERE ProjectID = " + System.Convert.ToString(intProjectID) + " AND DocumentLibraryID = "
        strSQL += "(SELECT DocumentLibraryID FROM tbl_SP_DocumentLibrary WHERE MasterTagID= " + System.Convert.ToString(m_intMasterTagID) + ")"
       
        Dim strDocLibID As String = System.Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))
        Return strDocLibID
    End Function 'GetDocLibUID


    Private Function GetDocLibID() As String

        Dim strSQL As String = "SELECT ProjectDocumentLibraryID FROM tbl_SP_ProjectDocumentLibraries WHERE ProjectID = " + System.Convert.ToString(intProjectID) + " AND DocumentLibraryID = "
        strSQL += "(SELECT DocumentLibraryID FROM tbl_SP_DocumentLibrary WHERE MasterTagID= " + System.Convert.ToString(m_intMasterTagID) + ")"
        
        Dim strDocLibID As String = System.Convert.ToString(CommonFunctions.Data.GetDataScalar(strSQL, True, strConnectionString))
        Return strDocLibID
    End Function 'GetDocLibID


    Protected Sub GridCommandButton_OnClick(ByVal sender As Object, ByVal e As GridViewCommandEventArgs)
        Dim strDocumentLibraryGUID As String = ""
        Dim strFileGUID As String = ""
        Dim strFileName As String = ""
        Dim index As Integer = System.Convert.ToInt32(e.CommandArgument)
        Dim strSQL As String = ""
        Select Case e.CommandName
            Case "DownloadFile"
                Dim grdRow As GridViewRow = gdWhizDocuments.Rows(index)
                strDocumentLibraryGUID = System.Convert.ToString(gdWhizDocuments.DataKeys(index).Values("DocumentLibraryGUID"))
                strFileGUID = System.Convert.ToString(gdWhizDocuments.DataKeys(index).Values("UploadedFileGUID"))
                Dim objLinkBtn As LinkButton = CType(grdRow.Cells(0).Controls(0), LinkButton)
                strFileName = objLinkBtn.Text
                'ShowMessage(strFileName, True)
                DownloadFile(strDocumentLibraryGUID, strFileGUID, strFileName, strProjectServerURL)
            Case "DeleteFile"
                strSQL = "DELETE FROM tbl_SP_UploadedFiles WHERE UploadedFilesID = " + System.Convert.ToString(gdWhizDocuments.DataKeys(index).Values("UploadedFilesID"))
                strDocumentLibraryGUID = System.Convert.ToString(gdWhizDocuments.DataKeys(index).Values("DocumentLibraryGUID"))
                strFileGUID = System.Convert.ToString(gdWhizDocuments.DataKeys(index).Values("UploadedFileGUID"))
                DeleteFile(strDocumentLibraryGUID, strFileGUID, strProjectServerURL)
                CommonFunctions.Data.InsertOrUpdateData(strSQL, True, strConnectionString)
                SetDataGrid()
        End Select
    End Sub 'GridCommandButton_OnClick


    Private Shared Sub DeleteFile(ByVal strDocumentLibraryGUID As String, ByVal strFileGUID As String, ByVal strProjectServerURL As String)

        Try
            'Dim objWhizDocMGMT As WhizDocumentManagement = New WhizDocumentManagement(strProjectServerURL)
            'objWhizDocMGMT.DeleteDocument(New Guid(strDocumentLibraryGUID), New Guid(strFileGUID))
            'If Not (objWhizDocMGMT Is Nothing) Then
            '    objWhizDocMGMT = Nothing
            'End If
        Catch ex As Exception
            ShowMessage(ex.Message.Replace(Environment.NewLine, " "), True)
        Finally

        End Try
    End Sub 'DeleteFile
    '<summary>
    'Deletes the Documents from Sharepoint Document Library.
    '</summary>
    '<param name="MasterTagID">Pass the value of MasterTagID of Page</param>
    '<param name="RecordId">Pass the value UniqueID of the page</param>
    '<param name="strUploadedFilesIDs">Pass the value of txtDocUploadedFilesID</param>
    '<param name="strProjectServerURL">Pass the value StrProjectServerURL</param>

    Public Shared Function DeleteSharePointDocument(ByVal MasterTagID As Integer, ByVal RecordId As Integer, ByVal strUploadedFilesIDs As String, ByVal strProjectServerURL As String) As String
        Dim strResult As String
        Dim arrUploadedFilesIDs As String() = strUploadedFilesIDs.Split(","c)
        Dim strUploadedFilesID As String
        Dim strDocumentLibraryGUID As String
        Dim strFileGUID As String
        Dim objDR As IDataReader
        Dim sbSQL As New StringBuilder
        Dim strConnectionString As String = CommonFunctions.General.BuildConnectionString(System.Configuration.ConfigurationManager.AppSettings.Get("ConnectionString"))
        Dim blnUseSQL As [Boolean] = System.Convert.ToBoolean(System.Configuration.ConfigurationManager.AppSettings.Get("UseSQL"))

        Try

            Select Case MasterTagID

                Case Else

                    For Each strUploadedFilesID In arrUploadedFilesIDs
                        sbSQL.Length = 0
                        sbSQL.Append("USP_SEL_tbl_SP_UploadedFiles ")
                        sbSQL.Append(MasterTagID.ToString)
                        sbSQL.Append(",")
                        sbSQL.Append(RecordId.ToString)
                        sbSQL.Append(",")
                        sbSQL.Append(strUploadedFilesID)

                        objDR = CommonFunctions.Data.GetDataReader(sbSQL.ToString(), blnUseSQL, strConnectionString)
                        If (objDR.Read()) Then
                            strDocumentLibraryGUID = objDR("DocumentLibraryGUID").ToString
                            strFileGUID = objDR("UploadedFileGUID").ToString
                        End If
                        CommonFunctions.Data.DisposeDataReader(objDR)

                        If (strDocumentLibraryGUID <> "" And strFileGUID <> "" And strProjectServerURL <> "") Then
                            WhizDocManagement.DeleteFile(strDocumentLibraryGUID, strFileGUID, strProjectServerURL)
                            CommonFunctions.Data.InsertOrUpdateData("usp_del_Tbl_SP_UploadedFiles " + strUploadedFilesID, blnUseSQL, strConnectionString)
                        End If

                    Next
            End Select

        Catch ex As Exception
            Throw ex
            ShowMessage(ex.Message.Replace(Environment.NewLine, " "), True)


        End Try

    End Function

    Public Shared Sub Get_PSI_Credentials(ByRef UserName As String, ByRef Password As String, ByRef Domain As String)
        Try
            UserName = CommonFunctions.General.DecryptString(ConfigurationManager.AppSettings.Get("P12UserName"))
            Password = CommonFunctions.General.DecryptString(ConfigurationManager.AppSettings.Get("P12Password"))
            Domain = CommonFunctions.General.DecryptString(ConfigurationManager.AppSettings.Get("P12Domain"))
        Catch ex As Exception
            ShowMessage("Get_PSI_Credentials", True)
        End Try
    End Sub

End Class '_Default