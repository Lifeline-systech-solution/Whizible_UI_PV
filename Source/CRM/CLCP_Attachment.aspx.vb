Imports Whizible
'Added by Vishal Mane on 30/12/2025 for server-side file upload validation
Imports System.Xml
Imports System.IO
Imports System.Runtime.InteropServices
'Added By Dipali V On 26th Mar 2026 Company Logo File
Imports System.Configuration
Imports QueryBuilders.cQuery
'End of Added By Dipali V On 26th Mar 2026 Company Logo File
'End of Added by Vishal Mane on 30/12/2025 for server-side file upload validation

Public Class CLCP_Faq_Attachment
    Inherits WebPages.Template.WhizTemplate

    'Local Constants
    Private Const FORM_NAME As String = "frmAttachment"
    Private Const FORM_ID As String = "frmAttachment"
    Private Const DIV_TAG As String = "divAttachment"
    Private Const FUNCTION_ATTACH_ONCLICK As String = "Attach_Onclick()"
    Private Const FUNCTION_CLOSE_ONCLICK As String = "Close_Onclick()"
    'Local Variables
    'Integated by MrugajaB for WhizibleSEM6.1 Issue ID.4141 i.e.Framework Patch 2.0.03 SP4-WAF on 5th June 2006
    'Private m_objGlobal As WebPages.Template.IGlobal
    'UJ_04052006, Issue ID: 123
    Protected m_objGlobal As WebPages.Template.IGlobal
    'End Integration

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
    'Added by Vishal Mane on 30/12/2025 for server-side file upload validation
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
        MyBase.ApplySecurity(True)
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
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Added by Vishal Mane on 30/12/2025 for server-side file upload validation
        '==========================================================================================================
        If HttpContext.Current.Request("Mode") = CommonFunction.Constants.MODE_ATTACH Then
            If HttpContext.Current.Request.Files.Count > 0 Then
                PostedFileObj = HttpContext.Current.Request.Files(0)
                PostedFileObj.InputStream.Read(buffer, 0, 256)
                PostedFileObj.InputStream.Position = 0
                CommonFunction.General.buffer = buffer

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
                CommonFunction.General.WriteHTML("<TD align=center style='color:red;'><B>Please upload valid file.</B></TD>")
                CommonFunction.General.WriteHTML("</TR></Table>")
                CommonFunction.General.WriteHTML("</div>")
                Exit Sub
            End If
        End If
        '==========================================================================================================
        'End of Added by Vishal Mane on 30/12/2025 for server-side file upload validation
        '==========================================================================================================
        'Create the global class object
        Call GetGlobalObject()
        'Added by Vishal Mane on 30/12/2025 for server-side file upload validation
        If HttpContext.Current.Request.Files.Count > 0 Then
            PostedFileObj = HttpContext.Current.Request.Files(0)
            PostedFileObj.InputStream.Read(buffer, 0, 256)
            PostedFileObj.InputStream.Position = 0
            CommonFunction.General.buffer = buffer
        End If
        'Added by Vishal Mane on 30/12/2025 for server-side file upload validation
        'Get the Attachment Tag Detail and upload the attachment
        Call SubTag_GetCLSQL()
        If ViewAttachment() = False Then
            'Page Details
            Call PageDetails()
        End If
        'Remove objects from memory
        Call MemoryCleanUp()
    End Sub

    'Added by Vishal Mane on 30/12/2025 for server-side file upload validation - MIME type detection
    <DllImport("urlmon.dll", CharSet:=CharSet.Unicode, ExactSpelling:=True, SetLastError:=False)>
    <System.Security.SecuritySafeCritical()>
    Shared Function FindMimeFromData(ByVal pBC As IntPtr, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzUrl As String, <MarshalAs(UnmanagedType.LPArray, ArraySubType:=UnmanagedType.I1, SizeParamIndex:=3)> ByVal pBuffer() As Byte, ByVal cbSize As Integer, <MarshalAs(UnmanagedType.LPWStr)> ByVal pwzMimeProposed As String, ByVal dwMimeFlags As Integer, ByRef ppwzMimeOut As IntPtr, ByVal dwReserved As Integer) As Integer
    End Function
    <System.Security.SecuritySafeCritical()>
    Public Shared Function getMimeFromFile(ByVal file As HttpPostedFile) As String
        Dim mimeout As IntPtr = IntPtr.Zero
        Dim MaxContent As Integer = Math.Min(CInt(file.ContentLength), 200)
        'Added By Dipali V On 26th Mar 2026 Company Logo File
        If MaxContent <= 0 Then Return ""
        'MaxContent = 200
        'End of Added By Dipali V On 26th Mar 2026 Company  Logo File
        Dim buf As Byte() = New Byte(MaxContent - 1) {}
        Try
            file.InputStream.Read(buf, 0, MaxContent)
            Dim result As Integer = FindMimeFromData(IntPtr.Zero, file.FileName, buf, MaxContent, Nothing, 0, mimeout, 0)

            If result <> 0 Then
                Return ""
            End If

            Dim mime As String = Marshal.PtrToStringUni(mimeout)
            Return mime.ToLower()
        Finally
            If mimeout <> IntPtr.Zero Then Marshal.FreeCoTaskMem(mimeout)
            If file IsNot Nothing AndAlso file.InputStream IsNot Nothing AndAlso file.InputStream.CanSeek Then
                file.InputStream.Position = 0
            End If
        End Try
    End Function
    'End of Added by Vishal Mane on 30/12/2025 for server-side file upload validation - MIME type detection
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
        ''Commented and added by Nilesh g on date 10/11/2016 Purpose : Apply Security
        ''MyBase.ApplySecurity(True, 2, , , True, m_objGlobal.TagID, m_objGlobal.ParentTagID)
        MyBase.ApplySecurity(True, 2, True, True, True, m_objGlobal.TagID, m_objGlobal.ParentTagID)
        ''end of Commented and added by Nilesh g on date 10/11/2016 Purpose : Apply Security
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
        'Integated by MrugajaB for WhizibleSEM6.1 Issue ID.4141 i.e.Framework Patch 2.0.03 SP4-WAF on 5th June 2006
        'm_objSubTagCLSQL = New CommonEngine.CommonList.cSubTagCLSQL(m_objGlobal)
        'UJ_04052006, Issue ID: 123
        m_objSubTagCLSQL = InitSubTagCLSQL(m_objGlobal) 'New CommonEngine.CommonList.cSubTagCLSQL(m_objGlobal)
        'End Integration
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
        End With
    End Sub
    'Integated by MrugajaB for WhizibleSEM6.1 Issue ID.4141 i.e.Framework Patch 2.0.03 SP4-WAF on 5th June 2006
    'UJ_04052006, Issue ID: 123
    Protected Overridable Function InitSubTagCLSQL(ByVal objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New CommonEngine.CommonList.cSubTagCLSQL(objSubTagGlobal)
    End Function
    'End Ingration
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

            'Integrated by MrugajaB on 11sept 2006 for Whiziblesem 6.0 SP7(Security Purpose)
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
            'End Integration

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

                Response.ContentType = "Application/pdf/html/csv/excel/rtf/xml/text"
                Try
                    Dim strFilePath As String = Server.MapPath(m_objSubTagCLSQL.AttachmentFilePath.Trim)
                    ' add the file name to the header
                    Response.AddHeader("Content-Disposition", "attachment;filename=" + m_objSubTagCLSQL.AttachmentFileName)

                    ' if the file exists write the file
                    If CommonFunctions.FileDirectory.IsFileExists(strFilePath) Then
                        'Added By Ashish to read the file in chunk Date 16-Apr-05
                        ' Open the file.
                        iStream = New System.IO.FileStream(strFilePath, System.IO.FileMode.Open, _
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
        Response.Write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>")
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
            Call InformFileUpload()
        Else
            Call CreateHiddenParameters()
            Call GetMenu()
            Call PlotControls()
            'WAF3_PB_42 April 09, 2007 UmeshJ START
            If m_objSubTagCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
                Call GetMenu()
            End If
            'WAF3_PB_42 April 09, 2007 UmeshJ END
        End If
        Call WriteClientsideScript()
        Call EndForm()
    End Sub
    Private Sub GetMenu()
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
        Dim arrMenu() As String = {" " + MyBase.GetResourceString("MENU_UPLOAD"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_UPLOAD_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {FUNCTION_ATTACH_ONCLICK, FUNCTION_CLOSE_ONCLICK}

        'WAF3_PB_39 start
        'Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu( arrMenu, arrClientSideFunctions, arrMenuToolTip, True , , , arrImagePaths)
        m_objMenu = New WebPage.UI.cStaticMenu
        m_objMenu.MenuNames = arrMenu
        m_objMenu.ToolTip = arrMenuToolTip
        m_objMenu.ClientSideFunctionNames = arrClientSideFunctions
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
            Dim arrSeparator() As Boolean = {True, False}
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
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing
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
        Dim strMsgUploadFile As String = MyBase.GetResourceString("FILE_UPLOAD_MSG")
        CommonFunction.General.WriteHTML("<div id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:190px !important;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        CommonFunction.General.WriteHTML("<Table cellspacing=0 height='100%' class=clsTable width='99.9%'><TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=center><B>" + strMsgUploadFile + "</B></TD>")
        CommonFunction.General.WriteHTML("</TR></Table>")
        CommonFunction.General.WriteHTML("</div>")
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
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + m_AttControl.ControlCaption + "</TD></TR>")
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + CommonFunction.HTMLControls.DrawFileControl(m_AttControl.ControlName, m_AttControl.ControlName, m_AttControl.cssClass, m_AttControl.Width, , , , , , , True) + m_AttControl.ToBeInserted + "</TD></TR>")
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
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + m_AttControl.ControlCaption + "</TD></TR>")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                CommonFunction.General.WriteHTML("<TR class='" + m_AttControl.clsTR + "'><TD align='" + m_AttControl.TRAlign + "'>" + CommonFunction.HTMLControls.DrawTextBox(m_AttControl.ControlName, m_AttControl.ControlName, m_AttControl.cssClass, m_AttControl.Width, m_AttControl.MaxLength, m_AttControl.Value, , , , , , , m_AttControl.OtherProperties, True, EnableHTMLEncode:=True) + m_AttControl.ToBeInserted + "</TD>")

                'ended by Yogesh J for HTML encoding Date:05/10/15
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
        End If
        'Code Added:RajeshB 31 Jan 2005
        m_blnRefreshScript = m_Att.RefreshScript
        'Addition Ends
        'Destroy the object
        m_Att = Nothing
        m_AttControl = Nothing
    End Sub

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
            .DIVHeight = 120
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
            .ControlName = CommonFunction.Constants.ATTACHMENT_FILE_CONTROL_NAME
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
            .ControlName = CommonFunction.Constants.ATTACHMENT_DESCRIPTION_CONTROL_NAME
            .cssClass = "clsTextBox"
            .Width = 530
            .MaxLength = 500
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
        Response.Write(vbCrLf + "   var objfrm;")
        Response.Write(vbCrLf + "   var objdivlist;")
        Response.Write(vbCrLf + "   var objFile =GetObjectReference('" + FORM_NAME + "','fileAttach');")
        Response.Write(vbCrLf + "   objfrm = GetFormReference('" + FORM_NAME + "')")
        Response.Write(vbCrLf + "   objdivlist=GetObjectReference('" + FORM_NAME + "','" + DIV_TAG + "')" + vbCrLf)
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

        CommonFunction.General.WriteHTML("//window resize for Common Page")
        CommonFunction.General.WriteHTML("	function window_onresize()")
        CommonFunction.General.WriteHTML("	{")
        CommonFunction.General.WriteHTML("		var intDivHeight ;")
        CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
        CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
        CommonFunction.General.WriteHTML("			intDivHeight = 100;")
        CommonFunction.General.WriteHTML("				")
        CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
        CommonFunction.General.WriteHTML("	}")

        CommonFunction.General.WriteHTML("	//window onload for Common list")
        CommonFunction.General.WriteHTML("	function window_onload()")
        CommonFunction.General.WriteHTML("	{")
        CommonFunction.General.WriteHTML("		var intDivHeight ;")
        CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
        CommonFunction.General.WriteHTML("		var lc;")
        CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
        CommonFunction.General.WriteHTML("			intDivHeight = 100;")
        CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
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
        CommonFunction.General.WriteHTML("function " + FUNCTION_ATTACH_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  if (disallowBlank(objFile,'" + MyBase.GetResourceString("FILE_SELECT_MSG") + "')) { return; }")
        CommonFunction.General.WriteHTML("  if (disallowSpecialCharacters(objFile,'" + MyBase.GetResourceString("FILE_HASH_NOT_ALLOWED") + "',true,'#')) { return; }")

        '2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 START
        CommonFunction.General.WriteHTML("  if (disallowFileNameLengthGreaterThanMax(objFile,150,'" + Replace(MyBase.GetResourceString("DISALLOW_FILENAME_MAX_LENGTH_VIOLATION"), "[MAX_LENGTH]", "150") + "',true)) { return; }")
        '2.0.07-SP7-WAF - Web Forms - Attachments UmeshJ April 17, 2007 END

        If m_strInsertIntoUploadFunction.Trim <> "" Then CommonFunction.General.WriteHTML(m_strInsertIntoUploadFunction)
        'Code Modified:RajeshB  31 Jan 2005
        'Refresh parent configurability
        Dim strRefreshValue As String = "1"
        If HttpContext.Current.Request("Mode") = "ADD_NEW" And m_blnRefreshScript = False Then
            strRefreshValue = "0"
        End If

        'WAF3_PB_39 - Hide the Upload link
        CommonFunction.General.WriteHTML("objSNAtt = GetObjectReference('" + FORM_NAME + "','upldT');if (objSNAtt != null){objSNAtt.style.display='none';}")
        CommonFunction.General.WriteHTML("objSNAtt = GetObjectReference('" + FORM_NAME + "','upldB');if (objSNAtt != null){objSNAtt.style.display='none';}")

        'Changed By NileshD on 21 June 2005
        'CommonFunction.General.WriteHTML("	objfrm.action=""CLCP_Attachment.aspx?Mode=" + CommonFunction.Constants.MODE_ATTACH + "&RefreshScript=" + strRefreshValue + m_strParentTagQuerystringDefaultParameters + """;")
        CommonFunction.General.WriteHTML("	objfrm.action=""" + strAttachmentPage + "?Mode=" + CommonFunction.Constants.MODE_ATTACH + "&RefreshScript=" + strRefreshValue + m_strParentTagQuerystringDefaultParameters + """;")
        'End OF changed By NileshD on 21 June 2005

        'Modification Ends
        CommonFunction.General.WriteHTML("	objfrm.submit();")
        CommonFunction.General.WriteHTML("	}")
    End Sub
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
