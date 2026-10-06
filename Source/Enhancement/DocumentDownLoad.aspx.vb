Imports Whizible
Public Class DocumentDownLoad
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	HR_ResourceDocument
    ' Purpose				:	Page for Resource document upload
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Nov 28,2007
    ' Revisions				:	
    '=====================================================================
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

    Protected CONST_MODE_HISTORY As String = "HISTORY"
    Protected CONST_MODE_UPLOAD As String = "UPLOAD"
    Protected CONST_MODE_ATTACHURL As String = "URL"


    Protected CONST_ACTION_DELETE As String = "DELETE"
    Protected CONST_ACTION_UPLOAD As String = "UPLOAD"
    Protected CONST_ACTION_ATTACHURL As String = "ATTACH"
    Protected CONST_ACTION_HISTORYDOWNLOAD As String = "HSDOWNLOAD"
    Protected CONST_ACTION_LISTDOWNLOAD As String = "LSDOWNLOAD"

    Protected CONST_ACTION_HISTORYSHOW As String = "SHOW"
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected m_strOpenerTagID As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strActionType As String = ""
    Private m_strRoleID As String
    Private m_strOpportunityID As String
    Private m_strPipelineID As String
    Protected m_strcategoryID As String
    Private m_strAttachcategoryID As String
    Private m_strDescription As String
    Private m_strSubCategoryID As String
    Private m_strUserName As String
    Private m_strComments As String
    Protected strIsStaffingPlanSendForApproval As String = ""


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : Start of Page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : This function must be called within FORM tag in aspx page.
        ' Author                : SuchitraP
        ' Created               : Nov 28,2007
        ' Revisions             :
        '=====================================================================

        Dim arrMenu As New System.Collections.ArrayList
        Dim arrMenuToolTip As New System.Collections.ArrayList
        Dim arrCSFunction As New System.Collections.ArrayList
        Dim strMenu As String

        m_strMode = Request.QueryString("Mode")
        m_strRoleID = Session("intPostID").ToString
        m_strUserName = Session("strUserName").ToString
        m_strOpportunityID = Request.QueryString("OpportunityID")
        m_strPipelineID = Request.QueryString("PipelineID")
        If m_strOpportunityID Is Nothing Then
            m_strOpportunityID = Request.Form("hidOpportunityID")
        End If
        If m_strPipelineID Is Nothing Then
            m_strPipelineID = Request.Form("hidPipelineID")
        End If
        Response.Write("<INPUT type=hidden name=hidOpportunityID id=hidOpportunityID value=" + m_strOpportunityID + " >")
        Response.Write("<INPUT type=hidden name=hidPipelineID id=hidPipelineID value=" + m_strPipelineID + " >")

        m_strcategoryID = Request.Form("cboCategory")
        m_strSubCategoryID = Request.Form("cboSubCategory")
        m_strDescription = Request.Form("txtDescription")
        m_strComments = Request.Form("txtComments")
        m_strAttachcategoryID = Request.Form("cboAttachCategory")


        'If m_strMode = "" Then m_strMode = CONST_MODE_LIST
        m_strAction = Request.QueryString("Action")
        m_strActionType = Request.QueryString("ActionType")

        'strIsStaffingPlanSendForApproval = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("IF EXISTS(SELECT 1 FROM [tbl_RM_Pipeline_Approval] WITH(NOLOCK) WHERE PipelineID = " & m_strPipelineID.ToString & ")select 1 else select 0", True), "0")

        'If Request.Params("FromXML") = "1" Then
        '    Response.Clear()
        '    Response.Write(PopulateCombo)
        '    Response.End()
        'End If

        'Select Case m_strMode.ToUpper.Trim


        '    Case CONST_MODE_UPLOAD
        '        If m_strAction <> "" Then
        '            'Call performUploadAction()
        '        End If

        '        If m_strActionType = "DELETEDETAILS" Then
        '            ' Call DeleteDocuments()
        '        End If

        'If (strIsStaffingPlanSendForApproval.ToString = "0") Then
        '    arrMenu.Add("Upload")
        '    arrMenuToolTip.Add("Upload")
        '    arrCSFunction.Add("Upload_OnClick()")

        '    arrMenu.Add("Delete")
        '    arrMenuToolTip.Add("Delete")
        '    arrCSFunction.Add("DeleteDetails_OnClick()")

        '    arrMenu.Add("Close")
        '    arrMenuToolTip.Add("Close")
        '    arrCSFunction.Add("Close_OnClick()")

        'Else

        arrMenu.Add("Close")
        arrMenuToolTip.Add("Close")
        arrCSFunction.Add("Close_OnClick()")
        'End If


        strMenu = WebPage.Templates.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip), True)
        Response.Write(strMenu)

        'Display the (* Mandatory) PageLegends 
        Dim strarrLegend() As String = {"Mandatory"}
        Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, "Document Download")
        Response.Write("<BR>")

        'plot the screen for document upload
        'Call plotDocumentUploadScreen()
        Call DrawDocumentUploadGrid()

        'plot the lower menu
        Response.Write("<BR>")
        'Response.Write(strMenu)

        'Case CONST_MODE_ATTACHURL
        '    If m_strAction <> "" Then
        '        Call performAttachURLAction()
        '    End If

        '    arrMenu.Add("Attach URL")
        '    arrMenuToolTip.Add("Attach URL")
        '    arrCSFunction.Add("Attach_OnClick()")

        '    arrMenu.Add("Close")
        '    arrMenuToolTip.Add("Close")
        '    arrCSFunction.Add("Close_OnClick()")

        '    strMenu = WebPage.Templates.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip), True)
        '    Response.Write(strMenu)

        '    'Display the (* Mandatory) PageLegends 
        '    Dim strarrLegend() As String = {"Mandatory"}
        '    Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        '    Response.Write(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

        '    'draw page caption 
        '    WebPage.Templates.PageCaption.GetPageCaptions(, "Upload Document")
        '    Response.Write("<BR>")

        '    'plot the screen for document upload
        '    Call plotAttachURLScreen()

        '    'plot the lower menu
        '    Response.Write("<BR>")
        '    Response.Write(strMenu)

        'Case CONST_MODE_HISTORY
        '    'Addition by SuchitraP on 5Dec07
        '    arrMenu.Add("Close")
        '    arrMenuToolTip.Add("Close")
        '    arrCSFunction.Add("Close_OnClick()")

        '    arrMenu.Add("?")
        '    arrMenuToolTip.Add("Help")
        '    arrCSFunction.Add("Help_OnClick('History')")

        '    strMenu = WebPage.Templates.StaticMenu.DrawMenu(GetArray(arrMenu), GetArray(arrCSFunction), GetArray(arrMenuToolTip), True)
        '    Response.Write(strMenu)

        '    'draw page caption 
        '    WebPage.Templates.PageCaption.GetPageCaptions(, "Document History")
        '    Response.Write("<BR>")
        '    'End Suchitra

        '    If m_strAction = CONST_ACTION_HISTORYSHOW Then
        '        plotDocumentHistoryScreen()
        '    ElseIf m_strAction = CONST_ACTION_LISTDOWNLOAD Or m_strAction = CONST_ACTION_HISTORYDOWNLOAD Then
        '        Dim strDocID As String
        '        Dim strFileWithPath As String
        '        Dim dr As IDataReader
        '        strDocID = Request.QueryString("DocumentID")
        '        If m_strAction = CONST_ACTION_LISTDOWNLOAD Then
        '            dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_OpportunityDocuments_FileDownload " + strDocID + ",0", MyBase.UseSQL)
        '        Else
        '            dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_OpportunityDocuments_FileDownload " + strDocID + ",1", MyBase.UseSQL)
        '        End If


        '        If dr.Read Then
        '            strFileWithPath = dr(0).ToString

        '            strFileWithPath = Server.MapPath(strFileWithPath)
        '            Response.Clear()
        '            'Response.ContentType = "application/octet-stream"
        '            ViewDocument(strFileWithPath, dr(1).ToString)
        '            CommonFunction.Data.DisposeDataReader(dr)
        '            Response.End()
        '        End If
        '    End If
        'Addition by SuchitraP on 5Dec07
        'plot the lower menu
        'Response.Write("<BR>")
        'Response.Write(strMenu)
        'End Suchitra

        'End Select
        'm_strOpenerTagID = Request.QueryString("OpenerTagID")
        'If m_strOpenerTagID Is Nothing OrElse m_strOpenerTagID = "" Then
        '    m_strOpenerTagID = Request.Form("OpenerTagID")
        'End If
        'Response.Write("<INPUT type=HIDDEN name=OpenerTagID value=" + m_strOpenerTagID + ">")

    End Sub

    'Private Sub DeleteDocuments()
    '    Dim m_strRequestID As String
    '    Dim arrIDs() As String
    '    Dim lenArray As Integer

    '    If CType(Request.Form("chkDelete"), String) <> "" Then
    '        m_strRequestID = CType(Request.Form("chkDelete"), String)

    '        arrIDs = m_strRequestID.Split(CType(",", Char))
    '        'Now Insert Into Table
    '        For lenArray = 0 To arrIDs.Length - 1
    '            If (arrIDs(lenArray) <> "") Then
    '                CommonFunctions.Data.InsertOrUpdateData("DELETE FROM tbl_RM_OpportunityDocuments WHERE DocumentID = " + arrIDs(lenArray), MyBase.UseSQL)
    '            End If
    '        Next
    '    End If
    'End Sub
    Private Sub plotDocumentUploadScreen()
        '=====================================================================
        ' Procedure Name		:	plotDocumentUploadScreen
        ' Parameters Passed		:	plotDocumentUploadScreen
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plot the controls for the upload mode of the page.
        ' Description			:	Here HTML file control is plotted to select the file from the disk.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SuchitraP
        ' Created				:	28 Nov 2007
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String
        Dim strcategoryID As String
        Dim strDescription As String

        If m_strcategoryID Is Nothing Or m_strcategoryID = "" Then
            m_strcategoryID = "NULL"
        Else
            m_strcategoryID = Request.Form("cboCategory")
        End If


        CommonFunction.General.WriteHTML("<Div id='DivList' width=100% height=90% style='overflow: auto;' >")
        'Once Send for approval Only Uploaded details should be shown
        'If (strIsStaffingPlanSendForApproval.ToString = "0") Then

        CommonFunction.General.WriteHTML("<Table id='tblFileAttachment' class='clsTable' width=99.9% cellspacing=0 cellpadding=0 style='visibility:visible;display:block'>")

        'display the file control
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='left'> Select document to Upload </TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='left'>")
        CommonFunction.HTMLControls.DrawFileControl("txtFileName", "txtFileName", "clsFileControl", 60, , , , , , , False)
        CommonFunction.General.WriteHTML("</TD></TR>")

        'Commented By ShubhangiD On 8 April 2015 : EASI Custmization
        'display document category combo
        ''CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        ''CommonFunction.General.WriteHTML("<TD align='left'> Select document Category </TD>")
        ''CommonFunction.General.WriteHTML("</TR>")
        ''CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        ''strSQL = "usp_Sel_tbl_RM_OpportunityDocuments " + m_strRoleID + "," + m_strOpportunityID
        ''CommonFunction.General.WriteHTML("<TD align='left'>")
        ''CommonFunctions.HTMLControls.DrawComboBox("cboCategory", strSQL, 400, m_strcategoryID, "onchange = cboCategory_OnChange()", True, False, , True)
        ''CommonFunction.General.WriteHTML("</TD></TR>")

        '''display document Sub category combo
        ''CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        ''CommonFunction.General.WriteHTML("<TD align='left'> Select document Sub Category</TD>")
        ''CommonFunction.General.WriteHTML("</TR>")
        ''CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        ''strSQL = "usp_Sel_tbl_RM_OpportunitySubCategory " + m_strcategoryID
        ''CommonFunction.General.WriteHTML("<TD id='tdSubCategory' align='left'>")
        ''CommonFunction.HTMLControls.DrawComboBox("cboSubCategory", strSQL, 400, , , True, False, , False)
        ''CommonFunction.General.WriteHTML("</TD></TR>")
        'End of Commented By ShubhangiD On 8 April 2015 : EASI Custmization

        'display discription textarea
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='left'>Description</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align='left'>")
        ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        ''CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description", , , "frmProjectDocuments", , , 450, 50, , , , , , , , , , False, True)
        CommonFunction.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description", , , "frmProjectDocuments", , , 450, 50, , , , , , , , , , False, True, EnableHTMLEncode:=True)
        ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
        CommonFunction.General.WriteHTML("</TD></TR></Table>")

        ' Message Table
        CommonFunction.General.WriteHTML("<TABLE id='tblFileUploadStatus' cellspacing='1' height='5%' Width='99.9%' class='clsTable' style='visibility:visible;display:none'>")
        CommonFunction.General.WriteHTML("<TR>")
        CommonFunction.General.WriteHTML("<TD height='20'>")
        CommonFunction.General.WriteHTML("&nbsp;</TD></TR>")
        CommonFunction.General.WriteHTML("<TR><TD align=center class=clsTDEven>")
        CommonFunction.General.WriteHTML("<LABEL id='lblFileUploadStatus'><B>Uploading file...Please wait !!</B></LABEL>")
        CommonFunction.General.WriteHTML("</TD></TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("<BR>")
        'End If

        DrawDocumentUploadGrid()

        CommonFunction.General.WriteHTML("</div>")
        'write client side script to set focus on the filename textbox
        CommonFunction.General.WriteHTML("<Script language=javascript>")
        CommonFunction.General.WriteHTML(" var objTxt =  GetObjectReference('frmResourceDocuments','txtFileName');")
        CommonFunction.General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")
        CommonFunction.General.WriteHTML("</Script>")


    End Sub

    Private Sub DrawDocumentUploadGrid()
        Dim strSQL As String
        Dim RoleId = CType(Session("intPostID"), Integer)

        'strSQL = " SELECT DocumentID,UploadedBy,CategoryID,isnull(SubCategoryID,'') as SubCategoryID,FileName,UploadedDate,SystemFileName,FileSize  FROM tbl_RM_OpportunityDocuments WITH(NOLOCK) WHERE OpportunityID = " & m_strOpportunityID & ""
        strSQL = "EXEC usp_sel_tbl_PM_Documents_UploadDoc " & RoleId
        'If (strIsStaffingPlanSendForApproval.ToString = "0") Then
        Dim arrColumnHeadingList() As String = {"Document Name", "Download"}
        Dim arrActualColumnNames() As String = {"FileName", "DocumentName"}
        Dim arrTDStyle() As String = {"align=left width=25%", "align=left style='width=15%'"}
        Dim arrGroupColName() As String = {"UploadedBy"}

        With m_objGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrColumnHeadingList
            .NoOfDataColumns = 2
            .TDStyleArray = arrTDStyle
            .DIVStyle = "overflow:none,height:290px"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivGrid"
            .DIVHeight = 100%
            .SQL = strSQL
            .UseSQL = True
            '.GroupOnColumn = arrGroupColName
            .PrimaryKey = "DocumentID"
            .DrawGrid()

        End With
        m_objGrid = Nothing
        'Else
        'Dim arrColumnHeadingList() As String = {"Uploaded By", "Document Name", "Attached Date"}
        'Dim arrActualColumnNames() As String = {"UploadedBy", "FileName", "AttachedDate"}
        'Dim arrTDStyle() As String = {"align=left style='width=15%'", "align=left width=25%", "align=left style='width=15%'"}
        'Dim arrGroupColName() As String = {"UploadedBy"}

        'With m_objGrid
        '    .ActualColumnArray = arrActualColumnNames
        '    .UserFriendlyColumnArray = arrColumnHeadingList
        '    .NoOfDataColumns = 3
        '    .TDStyleArray = arrTDStyle
        '    .DIVStyle = "overflow:none"
        '    .ColNameToolTipOnEachRow = True
        '    .DIVID = "DivGrid"
        '    .DIVHeight = 100%
        '    .SQL = strSQL
        '    .UseSQL = True
        '    .GroupOnColumn = arrGroupColName
        '    .PrimaryKey = "DocumentID"
        '    .DrawGrid()

        'End With
        'm_objGrid = Nothing
        'End If
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper = "DOCUMENTNAME" Then
            Cancel = True
            'Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("SystemFileName")) & """,'Resource_Demand'," & m_strOpportunityID.ToString & ") >" & CStr(Args.DataReader("FileName")) & "</A></TD>"
            'Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("DocumentName")) & """,'Documents') >" & CStr(Args.DataReader("DocumentName")) & "</A></TD>"

            'Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("DocumentName")) & """,'Documents') >" & "Download" & "</A></TD>"
            Args.StringToBeInserted = "<TD align=left Title=""View Uploaded File""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("DocumentName")).Replace(" ", "_") & """,'Documents') >" & "Download" & "</A></TD>"
            'Args.StringToBeInserted = "<TD   align=Left ><A href='" + Args.DataReader("DocumentName").ToString + "' target=_blank >" + Args.DataReader("DocumentName").ToString + "</A></TD>"
        End If

        If Args.ColumnName = "Delete" Then
            Cancel = True
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , CType(Args.DataReader("DocumentID"), String), , , True) + "</td>"

        End If

    End Sub
    'Private Sub plotAttachURLScreen()
    '    Dim strSQL As String

    '    If m_strAttachcategoryID Is Nothing Or m_strAttachcategoryID = "" Then
    '        m_strAttachcategoryID = "NULL"
    '    Else
    '        m_strAttachcategoryID = Request.Form("cboAttachCategory")
    '    End If

    '    'plot the controls
    '    CommonFunction.General.WriteHTML("<div id='divList' Style='Height:620px;WIDTH:100%;OVERFLOW:auto;' >")
    '    CommonFunction.General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

    '    'display URL text box
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'> Enter URL (Please enter the complete URL [http://...])  </TD>")
    '    CommonFunction.General.WriteHTML("</TR>")
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'>")
    '    CommonFunctions.HTMLControls.DrawTextBox("txtURL", "txtURL", , 400, 500, , , , , , , , , False, True)
    '    CommonFunction.General.WriteHTML("</TD></TR>")

    '    'display category combo
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'> Select document Category</TD>")
    '    CommonFunction.General.WriteHTML("</TR>")
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    strSQL = "usp_Sel_tbl_RM_OpportunityDocuments " + m_strRoleID + "," + m_strOpportunityID
    '    CommonFunction.General.WriteHTML("<TD align='left'>")
    '    CommonFunctions.HTMLControls.DrawComboBox("cboAttachCategory", strSQL, 400, m_strAttachcategoryID, "onchange = cboAttachCategory_OnChange()", True, False, , True)
    '    CommonFunction.General.WriteHTML("</TD></TR>")


    '    'display document Sub category combo
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'> Select document Sub category</TD>")
    '    CommonFunction.General.WriteHTML("</TR>")
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    strSQL = "usp_Sel_tbl_RM_OpportunitySubCategory " + m_strAttachcategoryID
    '    CommonFunction.General.WriteHTML("<TD id='tdSubCategory' align='left'>")
    '    CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory", strSQL, 400, , , True, False, , False)
    '    CommonFunction.General.WriteHTML("</TD></TR>")

    '    'display description
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'>Description</TD>")
    '    CommonFunction.General.WriteHTML("</TR>")
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'>")
    '    CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Enter Description", , , "frmProjectDocuments", , , 400, 50, , , , , , , , , , False, True)
    '    CommonFunction.General.WriteHTML("</TD></TR>")

    '    CommonFunction.General.WriteHTML("</Table>")
    '    CommonFunction.General.WriteHTML("</Div>")

    '    'write client side script to set focus on the filename textbox
    '    CommonFunction.General.WriteHTML("<Script language=javascript>")
    '    CommonFunction.General.WriteHTML(" var objTxt =  GetObjectReference('frmResourceDocuments','txtURL');")
    '    CommonFunction.General.WriteHTML(" if(objTxt!=null) objTxt.focus(); ")
    '    CommonFunction.General.WriteHTML("</Script>")

    'End Sub

    Private Sub plotDocumentListGrid()

    End Sub

    'Private Sub performUploadAction()
    '    Dim objFileUpload As FileUpload.cUpload
    '    Dim objFile As CommonFunction.FileDirectory.FileProperties
    '    Dim strDirectoryName As String
    '    Dim strSystemFileName As String
    '    Dim strFileName As String
    '    Dim strUploadedFileName As String
    '    Dim dblFileSize As Double
    '    Dim strCreatedDate As String
    '    Dim strLastModifiedDate As String
    '    Dim strSQL As String
    '    Dim strDir As String

    '    strSystemFileName = CommonFunctions.FileDirectory.GetUniqueFileName()

    '    strDirectoryName = CreateDirectory()
    '    objFileUpload = New FileUpload.cUpload("txtFileName", strDirectoryName, strSystemFileName)
    '    objFileUpload.OverwriteIfExists = False
    '    objFileUpload.UploadFile()
    '    strFileName = objFileUpload.OriginalFileName
    '    strUploadedFileName = objFileUpload.UploadedFileName

    '    objFile = New CommonFunction.FileDirectory.FileProperties
    '    objFile.FilePath = strDirectoryName + "\" + strUploadedFileName
    '    objFile.GetFileProperties()
    '    dblFileSize = objFile.FileSizeInKB
    '    strCreatedDate = objFile.FileCreatedDate.ToString
    '    strLastModifiedDate = objFile.LastUpdatedDate.ToString
    '    'comment by PrashantD
    '    'strUploadedFileName = strUploadedFileName.Substring(0, strUploadedFileName.LastIndexOf("."))
    '    'strFileName = strFileName.Substring(0, strFileName.LastIndexOf("."))
    '    'End of commnet by PrashantD

    '    'Modified and Added By ShubhangiD On 27 March 2015
    '    strDir = "../../Attachments/Resource_Demand"
    '    ''+ "/" + m_strOpportunityID
    '    ''strDir = strDir + "/" + m_strcategoryID

    '    ''If m_strSubCategoryID <> "" Then
    '    ''    strDir = strDir + "/" + m_strSubCategoryID
    '    ''End If
    '    'End of Modified and Added By ShubhangiD On 27 March 2015

    '    'strSQL = "usp_Ins_tbl_RM_OpportunityDocuments " + m_strcategoryID + "," + m_strOpportunityID + ",'" + CommonFunction.General.BuildQueryString(strDir.Trim) + "','" + CommonFunction.General.BuildQueryString(strFileName.Trim) + "','" + _
    '    '         CommonFunction.General.BuildQueryString(strUploadedFileName.Trim) + "','" + strCreatedDate.Trim + "','" + strLastModifiedDate.Trim + "','" + m_strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + _
    '    '         "','" + m_strUserName.ToString + "'," & m_strPipelineID & ""
    '    strSQL = "usp_Ins_tbl_RM_OpportunityDocuments NULL," + m_strOpportunityID + ",'" + CommonFunction.General.BuildQueryString(strDir.Trim) + "','" + CommonFunction.General.BuildQueryString(strFileName.Trim) + "','" + _
    '             CommonFunction.General.BuildQueryString(strUploadedFileName.Trim) + "','" + strCreatedDate.Trim + "','" + strLastModifiedDate.Trim + "','" + m_strDescription.Trim + "'," + dblFileSize.ToString + ",'" + objFile.Extension.Substring(1, objFile.Extension.Length - 1) + _
    '             "','" + m_strUserName.ToString + "'," & m_strPipelineID & ""

    '    If m_strSubCategoryID <> "" Then
    '        strSQL = strSQL & ", " & m_strSubCategoryID
    '    Else
    '        strSQL = strSQL & ", NULL"
    '    End If

    '    CommonFunction.Data.InsertOrUpdateData(strSQL, True)


    'End Sub

    'Private Sub performAttachURLAction()
    '    '=====================================================================
    '    ' Procedure Name		:	performAttachURLAction
    '    ' Parameters Passed		:	None
    '    ' Returns				:	None
    '    ' Parameters Affected	:	None
    '    ' Purpose				:	To update the database with the entry of given URL
    '    ' Description			:	Same as above
    '    ' Assumptions			:	None
    '    ' Dependencies			:	None
    '    ' Author				:	SuchitraP
    '    ' Created				:	6 Dec 2007
    '    ' Revisions				:	
    '    '=====================================================================
    '    Dim strSQL As String
    '    Dim strURL As String

    '    strURL = HttpContext.Current.Request.Form("txtURL")

    '    'm_strAttachcategoryID,m_strOpportunityID,strURL,m_strDescription,m_strUserName
    '    strSQL = "usp_Ins_tbl_RM_OpportunityDocuments_URL " + m_strAttachcategoryID + "," + m_strOpportunityID + ",'" + CommonFunction.General.BuildQueryString(strURL.Trim) + "','" + m_strDescription.Trim + "','" + m_strUserName.ToString + "'"

    '    If m_strSubCategoryID <> "" Then
    '        strSQL = strSQL & ", " & m_strSubCategoryID
    '    Else
    '        strSQL = strSQL & ", NULL"
    '    End If

    '    CommonFunction.Data.InsertOrUpdateData(strSQL, True)

    'End Sub
    Private Function CreateDirectory() As String
        Dim strDirectory As String
        Dim strFullPath As String
        Dim strResourceDemandPath As String

        Dim objFile As CommonFunction.FileDirectory

        'Modified and Added By ShubhangiD On 27 March 2015

        strResourceDemandPath = Server.MapPath("../../Attachments/Documents")
        strFullPath = strResourceDemandPath

        'strResourceDemandPath = Server.MapPath("../../Attachments/Resource_Demand") + "\"
        'create the directory of Opportunity
        ''strFullPath = strResourceDemandPath + m_strOpportunityID
        ''If CommonFunction.FileDirectory.IsDirectoryExists(strFullPath) = False Then
        ''    CommonFunctions.FileDirectory.CreateDirectory(strResourceDemandPath, m_strOpportunityID)
        ''End If

        '''Create the directory of Category
        ''strResourceDemandPath = strFullPath + "\"
        ''strFullPath = strFullPath + "\" + m_strcategoryID
        ''If CommonFunction.FileDirectory.IsDirectoryExists(strFullPath) = False Then
        ''    CommonFunctions.FileDirectory.CreateDirectory(strResourceDemandPath, m_strcategoryID)
        ''End If

        ''If Not m_strSubCategoryID Is Nothing Then
        ''    strResourceDemandPath = strFullPath + "\"
        ''    strFullPath = strFullPath + "\" + m_strSubCategoryID
        ''    If CommonFunction.FileDirectory.IsDirectoryExists(strFullPath) = False Then
        ''        CommonFunctions.FileDirectory.CreateDirectory(strResourceDemandPath, m_strSubCategoryID)
        ''    End If

        ''End If
        'End of Modified and Added By ShubhangiD On 27 March 2015

        CreateDirectory = strFullPath.Trim

    End Function
    'Private Function PopulateCombo() As String
    '    Dim strQuery As String
    '    Dim strCategory As String
    '    Dim strHtml As String

    '    strCategory = HttpContext.Current.Request.Params("CategoryID")

    '    strQuery = "usp_Sel_tbl_RM_OpportunitySubCategory " + strCategory
    '    strHtml = CommonFunction.HTMLControls.DrawComboBox("cboSubCategory", strQuery, 400, , , True, True, , False)

    '    Return strHtml
    'End Function
    'Private Sub plotDocumentHistoryScreen()
    '    MyBase.InitializeResources("AppResources.PM_ProjectDocuments", "AppResources")
    '    Dim strSQL As String
    '    Dim objDr As IDataReader
    '    Dim objFile As CommonFunction.FileDirectory
    '    Dim objLink As WebPage.UI.cDynamicLink
    '    Dim strFileName As String
    '    Dim strDocumentCategory As String
    '    Dim strTRClass As String
    '    Dim intRowCount As Integer
    '    Dim strFilePath As String
    '    Dim blnFileExists As Boolean
    '    'Prashant
    '    Dim m_strDocumentID As String
    '    m_strDocumentID = Request.QueryString("DocumentID")
    '    'End Prashant

    '    'get document category from the database
    '    strDocumentCategory = ""
    '    strSQL = "usp_Sel_tbl_RM_OpportunityDocuments_History " + m_strOpportunityID + "," + m_strDocumentID
    '    objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
    '    If objDr.Read Then
    '        strDocumentCategory = CommonFunction.Data.CheckIsDBNull(objDr("Category"), "").ToString + ""
    '    End If
    '    '''''''CommonFunction.Data.DisposeDataReader(objDr)

    '    'display document category
    '    CommonFunction.General.WriteHTML("<Table width=99.9% class='clsTable' cellpadding=0 cellspacing=0 >")
    '    CommonFunction.General.WriteHTML("<TR class='clsTRSectionHeader'>")
    '    CommonFunction.General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("CAP_CATEGORY") + " : </B> ")
    '    CommonFunction.General.WriteHTML(Server.HtmlEncode(strDocumentCategory.Trim) + "</TD>")
    '    CommonFunction.General.WriteHTML("</TR></Table>")

    '    'display the grid for document history details
    '    CommonFunction.General.WriteHTML("<div id='DivList' width=100% height=90% style='overflow: auto;'>")
    '    CommonFunction.General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

    '    'get the data for each document history record
    '    intRowCount = 0
    '    objFile = New CommonFunction.FileDirectory
    '    objLink = New WebPage.UI.cDynamicLink
    '    objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
    '    objLink.ReturnHTML = True


    '    While 1 = 1

    '        If intRowCount Mod 2 = 0 Then strTRClass = "clsTREven" Else strTRClass = "clsTROdd"

    '        strFilePath = Server.MapPath(CommonFunction.Data.CheckIsDBNull(objDr("DirectoryName"), "").ToString + "/" + CommonFunction.Data.CheckIsDBNull(objDr("SystemFileName"), "").ToString)
    '        If objFile.IsFileExists(strFilePath.Trim) = True Then
    '            blnFileExists = True
    '        Else
    '            blnFileExists = False
    '        End If

    '        'display file name
    '        CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '        CommonFunction.General.WriteHTML("<TD width=25% align='right' ><B>" + MyBase.GetResourceString("COL_FILE_NAME") + "</B>&nbsp;</TD>")
    '        CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.Data.CheckIsDBNull(objDr("FileName"), "").ToString + "</TD>")

    '        'if file exists then show the download link
    '        If blnFileExists = True Then
    '            objLink.LinkName = MyBase.GetResourceString("LINK_DOWNLOAD") + ""
    '            objLink.FunctionName = "Download_OnClick('" + objDr("DocumentID").ToString + "')"
    '            objLink.Tooltip = MyBase.GetResourceString("LINK_DOWNLOAD_TOOLTIP") + ""
    '            CommonFunction.General.WriteHTML("<TD></TD><TD align='right'>| " + objLink.GetDynamicLink() + " |</TD>")
    '        Else
    '            CommonFunction.General.WriteHTML("<TD></TD><TD></TD>")
    '        End If
    '        CommonFunction.General.WriteHTML("</TR>")

    '        'show uploaded by and file size
    '        CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '        CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_UPLOAD_DATE") + "</B>&nbsp;</TD>")
    '        CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(objDr("UploadedDate"), ""), Date)) + "</TD>")
    '        If blnFileExists = True Then
    '            CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_FILE_SIZE") + "</B>&nbsp;</TD>")
    '            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.Data.CheckIsDBNull(objDr("FileSize"), "").ToString + " " + MyBase.GetResourceString("KB") + "</TD>")
    '        Else
    '            CommonFunction.General.WriteHTML("<TD></TD><TD></TD>")
    '        End If
    '        CommonFunction.General.WriteHTML("</TR>")

    '        'display Last modified
    '        CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '        CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_LAST_MODIFIED") + "</B>&nbsp;</TD>")

    '        Dim strDate As String
    '        If CStr(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "")) = "" Then
    '            strDate = ""
    '        Else
    '            strDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(objDr("UpdatedDate"), "").ToString))
    '        End If
    '        CommonFunction.General.WriteHTML("<TD align='left' colspan=3>" + strDate + "</TD>")
    '        'End
    '        CommonFunction.General.WriteHTML("</TR>")

    '        'display Comments
    '        CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '        CommonFunction.General.WriteHTML("<TD align='right' valign='top'><B>" + MyBase.GetResourceString("CAP_DESC") + "</B>&nbsp;</TD>")

    '        CommonFunction.General.WriteHTML("<TD align='left' colspan=3>" + CommonFunction.General.FormatString(CommonFunction.Data.CheckIsDBNull(objDr("Description"), "").ToString) + "</TD>")

    '        CommonFunction.General.WriteHTML("</TR>")

    '        'display uploaded by
    '        CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '        CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_UPLOADEDBY") + "</B>&nbsp;</TD>")
    '        CommonFunction.General.WriteHTML("<TD align='left' colspan=3>" + CommonFunction.Data.CheckIsDBNull(objDr("UploadedBy"), "").ToString + "</TD>")
    '        CommonFunction.General.WriteHTML("</TR>")

    '        'display the reviewd date and reviewed by if reviewed date is present
    '        If Not IsDBNull(objDr("ReviewedBy")) Then
    '            CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '            CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_REVIEWEDBY") + "</B>&nbsp;</TD>")
    '            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.Data.CheckIsDBNull(objDr("ReviewedBy"), "").ToString + "</TD>")
    '            CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("CAP_REVIEW_DATE") + "</B>&nbsp;</TD>")
    '            CommonFunction.General.WriteHTML("<TD align='left'>" + CommonFunction.Dates.GetDate(CType(CommonFunction.Data.CheckIsDBNull(objDr("ReviewedDate"), ""), Date)) + "</TD>")
    '            CommonFunction.General.WriteHTML("</TR>")
    '            'display Review Notes
    '            CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '            CommonFunction.General.WriteHTML("<TD align='right'valign='top'><B>" + MyBase.GetResourceString("CAP_REVIEW_COMMENTS") + "</B></TD>")
    '            CommonFunction.General.WriteHTML("<TD align='left' colspan=3>" + CommonFunction.Data.CheckIsDBNull(objDr("ReviewNotes"), " ").ToString + "</TD>")
    '            CommonFunction.General.WriteHTML("</TR>")
    '        End If

    '        ''''if user has delete access then show the delete checkbox column
    '        '''If m_blnDelAccess = True Then
    '        '''    If Not IsDBNull(objDr("DocumentRefID")) Then
    '        '''        CommonFunction.General.WriteHTML("<TR class='" + strTRClass.Trim + "' >")
    '        '''        CommonFunction.General.WriteHTML("<TD align='right'><B>" + MyBase.GetResourceString("COL_DELETE") + "</B>&nbsp;</TD>")
    '        '''        CommonFunction.General.WriteHTML("<TD align='left' colspan=3>")
    '        '''        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , objDr("DocumentID").ToString, , , True))
    '        '''        CommonFunction.General.WriteHTML("</TD></TR>")
    '        '''    End If
    '        '''End If

    '        'increament the row conter
    '        intRowCount += 1
    '        If Not objDr.Read Then
    '            Exit While
    '        End If
    '    End While
    '    CommonFunction.Data.DisposeDataReader(objDr)
    '    objLink = Nothing
    '    objFile = Nothing

    '    'if no rows printed then display message 
    '    If intRowCount < 1 Then
    '        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '        CommonFunction.General.WriteHTML("<TD align='center' colspan=4 >")
    '        CommonFunction.General.WriteHTML(MyBase.GetResourceString("NORECORDFOUND"))
    '        CommonFunction.General.WriteHTML("</TD></TR>")
    '    End If

    '    'close the table
    '    CommonFunction.General.WriteHTML("</Table>")
    '    CommonFunction.General.WriteHTML("</Div>")

    '    'save the record count in the hidden control
    '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txthdRowCount", "txthdRowCount", , , , intRowCount.ToString, , , , , , True, , True))

    'End Sub
    Private Sub ViewDocument(ByVal strFileWithPath As String, ByVal strDisplayFileName As String)
        Dim iStream As System.IO.Stream

        ' Buffer to read 10K bytes in chunk:
        Dim buffer(10000) As Byte

        ' Length of the file:
        Dim length As Integer

        ' Total bytes to read:
        Dim dataToRead As Long

        ' Identify the file to download including its path.
        Dim filepath As String = strFileWithPath

        ' Identify the file name.
        Dim filename As String = System.IO.Path.GetFileName(filepath)

        Try
            ' Open the file.
            iStream = New System.IO.FileStream(filepath, System.IO.FileMode.Open, _
                                                   IO.FileAccess.Read, IO.FileShare.Read)

            ' Total bytes to read:
            dataToRead = iStream.Length

            Response.ClearContent()
            Response.ClearHeaders()

            Response.ContentType = "application/octet-stream"
            Response.AddHeader("Content-Disposition", "attachment; filename=" & strDisplayFileName)

            ' Read the bytes.
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

        Catch ex As Exception
            ' Trap the error, if any.
            Response.Write("Error : " & ex.Message)
        Finally
            If IsNothing(iStream) = False Then
                ' Close the file.
                iStream.Close()
            End If
        End Try

    End Sub
End Class

