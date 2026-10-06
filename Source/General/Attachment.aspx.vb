Public Class Attachment
    Inherits WebPages.Template.WhizTemplate

    Protected m_strFromWhere As String = ""
    Protected m_strAction As String = ""

    Protected m_strMode As String = ""
    Protected m_strID As String = ""
    Protected m_strShow As String = ""
    Protected m_strAttachmentType As String = ""

    Protected m_strPage As String = ""
    Protected m_strQueryString As String = ""
    Protected m_lngMaxLength As Long = 100
    Private m_lngProjectIDWSR As Long

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean

    'Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_strIssueID As String
    Protected m_PKToken As String
    Protected m_Mode As String
    'End of Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_strExtensionList As String = ""
    Protected m_intTagID As Integer


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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()
        If Page.IsPostBack Then
            Call PerformActions()
        End If
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        ' MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True, 2)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        ' From Where
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        Else
            m_strFromWhere = ""
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("ID") Is Nothing Then
            m_strID = Request.QueryString("ID").ToString
        Else
            m_strID = ""
        End If
        If Not Request.QueryString("Show") Is Nothing Then
            m_strShow = Request.QueryString("Show").ToString
        Else
            m_strShow = ""
        End If
        If Not Request.QueryString("AttachmentType") Is Nothing Then
            m_strAttachmentType = Request.QueryString("AttachmentType").ToString
        Else
            m_strAttachmentType = ""
        End If
        If Not Request.QueryString("ProjectID") Is Nothing Then
            m_lngProjectIDWSR = CType(Request.QueryString("ProjectID"), Long)
        Else
            m_lngProjectIDWSR = 0
        End If
        If Not Request.QueryString("Page") Is Nothing Then
            m_strPage = Request.QueryString("Page").ToString
        Else
            m_strPage = ""
        End If
        If Not Request.QueryString("QueryString") Is Nothing Then
            m_strQueryString = Request.QueryString("QueryString").ToString
        Else
            m_strQueryString = ""
        End If

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If (UCase(Trim(m_strFromWhere & "")) = "CRM,AR" Or UCase(Trim(m_strFromWhere & "")) = "CRM,SR" Or UCase(Trim(m_strFromWhere & "")) = "CRM,DB") Then
            If CType(m_PKToken, String) <> "0" Then
                If Request.QueryString("PKToken") Is Nothing Then
                    m_PKToken = Request.Form("txtPkToken").ToString
                Else
                    m_PKToken = Request.QueryString("PKToken").ToString
                End If
            End If
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

        ' Added by SavitaS 20 Sept 2006 for Security Issue 6197

        If UCase(Trim(m_strFromWhere & "")) = "BTS" Then
            If Not Request.QueryString("Mode") Is Nothing Then
                m_Mode = Request.QueryString("Mode").ToString
            Else
                m_Mode = ""
            End If
            If Not Request.QueryString("ID") Is Nothing Then
                m_strIssueID = Request.QueryString("ID").ToString
            Else
                m_strIssueID = "0"
            End If

            If CType(m_PKToken, String) <> "0" Then
                If Request.QueryString("PKToken") Is Nothing Then
                    m_PKToken = Request.Form("txtPkToken").ToString
                Else
                    m_PKToken = Request.QueryString("PKToken").ToString
                End If
            End If

            If ((m_PKToken = "") And (m_strIssueID.ToString <> "0")) Or _
    ((m_strIssueID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False)) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_strIssueID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        'End of Added by SavitaS 20 Sept 2006 for Security Issue 6197

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        'Added by ArchanaN on 1-Oct-2010
        If Not Request.QueryString("TagID") Is Nothing Then
            m_intTagID = CommonFunction.General.CheckIsNothing(Request.QueryString("TagID").ToString, 0)
        Else
            m_intTagID = CommonFunction.General.CheckIsNothing(Request.Form("txtTagID").ToString, 0)
        End If

        If m_intTagID <> 0 Then
            m_strExtensionList = CommonFunction.General.GetFileExtnListForTag(m_intTagID.ToString)
        End If
        'End of Added by ArchanaN on 1-Oct-2010

        ' set the max-length
        Select Case UCase(Trim(m_strFromWhere & ""))
            Case "BTS" : m_lngMaxLength = 8000
            Case "KM" : m_lngMaxLength = 100
            Case "RTS" : m_lngMaxLength = 100
            Case "PM" : m_lngMaxLength = 100
            Case "FA" : m_lngMaxLength = 100
            Case "WSR" : m_lngMaxLength = 100
            Case "RESUME" : m_lngMaxLength = 100
            Case "CRM_ADMIN" : m_lngMaxLength = 100

                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                '' Case "CRM" : m_lngMaxLength = 1000
            Case "CRM,SR", "CRM,AR", "CRM,DB" : m_lngMaxLength = 1000
                '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

            Case Else : Exit Sub
        End Select

    End Sub


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
        Dim strSessionUserName As String
        If UCase(Trim(m_strAction & "")) = "ATTACH" Then
            ' The path 
            Select Case UCase(Trim(m_strFromWhere & ""))
                Case "BTS" : strPath = Server.MapPath("../../Attachments/BTS/")
                Case "KM" : strPath = Server.MapPath("../../Attachments/KM/")
                Case "RTS" : strPath = Server.MapPath("../../Attachments/RTS/")
                Case "PM" : strPath = Server.MapPath("../../Projects/")
                Case "FA" : strPath = Server.MapPath("../../Attachments/FA/")
                Case "WSR" : strPath = Server.MapPath("../../Attachments/PM/")
                Case "RESUME" : strPath = Server.MapPath("../../Attachments/RESUME/")
                Case "CRM_ADMIN" : strPath = Server.MapPath("../../Attachments/CRM/")

                    ''Case "CRM" : strPath = Server.MapPath("../../Attachments/CRM/")
                Case "CRM,SR", "CRM,AR", "CRM,DB" : strPath = Server.MapPath("../../Attachments/CRM/")
                Case Else : Exit Sub
            End Select
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

            strDescription = MyBase.GetFormValue("txtComments")

            ' database updates!!!
            Select Case UCase(Trim(m_strFromWhere & ""))
                Case "BTS"
                    '***** Modified by SandipL on 17 Feb 2006 to solve IssueID 2133 whizsem_whiz2 SP6
                    strSQL = "Exec usp_Ins_tbl_IB_Attachments " & m_strID & ", " & Session("IssueProject").ToString & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                    'strSQL = "Exec usp_Ins_tbl_IB_Attachments " & m_strID & ", " & Session("intProjectID").ToString & ", " & Session("intUserID").ToString & ", '" & Session("LoginType").ToString & "'"
                    '***** End Modification by SandipL on 17 FEB 2006
                    strSQL &= ", '" & CommonFunctions.General.BuildQueryString(strFileName) & "', '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "', '" & CommonFunctions.General.BuildQueryString(strDescription) & "'"
                    If UCase(Trim(m_strAttachmentType & "")) = "LINK" Then
                        strSQL &= ", 1"
                    End If
                Case "KM"
                    strSessionUserName = CType(Session("strUserName"), String).Replace("'", "''")
                    If UCase(Trim(m_strAttachmentType & "")) = "LINK" Then
                        'Commented and modified by SuchitraP on 12-Nov-2008 
                        'Purpose:To insert Attached by and AttachedDate in Attachments table
                        'strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename,SaveAsLink)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "',1)"

                        strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename,SaveAsLink,AttachedBy,AttachedDate)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "',1,'" & strSessionUserName & "',GetDate())"
                        'End by SuchitraP
                    Else
                        'Commented and modified by SuchitraP on 12-Nov-2008 
                        'Purpose:To insert Attached by and AttachedDate in Attachments table
                        'strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "')"
                        strSQL = "Insert InTo tbl_KM_Attachments(ProcedureID,Description,Attachments,originalfilename,AttachedBy,AttachedDate)Values(" & m_strID & ",'" & CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','" & strSessionUserName & "',GetDate())"
                        'End by SuchitraP
                    End If
                Case "RTS", "PM", "FA"
                    ' NA
                Case "WSR"
                    strSQL = "EXEC usp_UploadWSRFiles '" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(strDescription) & "'," & m_strID & "," & m_lngProjectIDWSR
                Case "RESUME"
                    If Trim(m_strID & "") = "" Then
                        m_strID = Session("intUserID").ToString
                    End If
                    If m_strID <> "" Then
                        'If File name is of greater than max chars then
                        If (Len(strOriginalFileName) > 100) Then
                            strOriginalFileName = Right(strOriginalFileName, 100) & ""
                        End If
                        strSQL = "UPDATE tbl_PM_Employee SET SystemGeneratedFileName = '" & CommonFunctions.General.BuildQueryString(strFileName) & "', OriginalFileName = '" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "' WHERE EmployeeID = " & m_strID
                    End If
                Case "CRM_ADMIN"
                    'If File name is of greater than max chars then
                    If (Len(strOriginalFileName) > 100) Then
                        strOriginalFileName = Right(strOriginalFileName, 100) & ""
                    End If
                    strSQL = "usp_Ins_tbl_CRM_SubRequestType_Templates '" & m_strID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','" & CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "'"

                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                    ''Case "CRM" 
                Case "CRM,SR", "CRM,AR", "CRM,DB"
                    If ((m_PKToken = "" And m_strID.ToString <> "0")) Or (m_strID <> "0" And CommonFunctions.Security.Token.ValidateToken(m_strID + CType(m_lngEmployeeID, String) + "0" + "0", m_PKToken) = False) Then
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Attachments", 0, 0, "Query ID", m_strID.ToString)
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

                    : strPath = Server.MapPath("../../Attachments/CRM/")
                    'integrted by harshadad for whiziblesem SP7.2 issueID 4518
                    'Added by SavitaS on 28 June 2006 for Sierra IssueID 2590 
                    'Purpose :Length of File Name to be checked while the user is uploading a document
                    Dim count As Integer = 0
                    count = strOriginalFileName.ToString.Length
                    If count <= 100 Then
                        'End of Added by SavitaS on 28 June 2006 for Sierra IssueID 2590 
                        ' end of integration
                        strSQL = "usp_CRM_Insert_Attachment '" & m_strID & "','" & CommonFunctions.General.BuildQueryString(strOriginalFileName) & "','"
                        strSQL &= CommonFunctions.General.BuildQueryString(strFileName) & "','" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "','"
                        strSQL &= CommonFunctions.General.BuildQueryString(strDescription) & "','" & CommonFunctions.General.BuildQueryString(Session("LoginType").ToString) & "'"
                        'integrted by harshadad for whiziblesem SP7.2 issueID 4518
                        'Added by SavitaS on 28 June 2006 for Sierra IssueID 2590 
                    Else
                        CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
                        CommonFunctions.General.WriteHTML("alert('File Name Length cannot be greater than 100 characters');")
                        CommonFunctions.General.WriteHTML("</script>")
                    End If
                    'End of Added by SavitaS on 28 June 2006 for Sierra IssueID 2590 
                    ' end of integration
                Case Else
            End Select

            If Trim(strSQL & "") <> "" Then
                CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
            End If

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
        ' Author                : Rajanikant
        ' Created               : Feb 24,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {"Upload", MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {"Upload", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrCSFunction() As String = {"Attach_OnClick('" & m_strID & "','" & m_strFromWhere & "','" & m_lngProjectIDWSR & "')", "Close_OnClick()"}

        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            .Write(strMenu)
            .Write("<BR>")
            .Write("<DIV ID='divList' Style='Height:100px;WIDTH:100%;OVERFLOW:auto;'>")

            .Write("<TABLE id='tblFileAttachment' cellspacing=0 Width='99.9%' class=clsTable style='visibility:visible;display:block'>")
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            .Write("<B>" + "Select File" + "</B>")
            .Write("</TD>")
            .Write("</TR>")

            ' the file control
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            CommonFunctions.HTMLControls.DrawFileControl("txtFileName", "txtFileName", , 74, , , , , , "onkeydown='return txtFileName_onkeydown()' onbeforepaste='return txtFileName_onbeforepaste()' onpaste='return txtFileName_onpaste()'")
            .Write("</TD>")
            .Write("</TR>")

            ' comments
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            'Modified By ShraddhaM on 28 July 2006
            ''Commented by Nilesh G on 2/12/2015 for html encode
            ''CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmAttachment", , , 450, 100, 2000, Wrap:="Soft")
            '' CommonFunctions.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , m_intTagID.ToString, IsHidden:=True)
            CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmAttachment", , , 450, 100, 2000, Wrap:="Soft", EnableHTMLEncode:=True)
            CommonFunctions.HTMLControls.DrawTextBox("txtTagID", "txtTagID", , , , m_intTagID.ToString, IsHidden:=True, EnableHTMLEncode:=True)
            ''end of Commented by Nilesh G on 2/12/2015 for html encode
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")

            'Added by SavitaS on 20 Sept 2006
            .Write("<TR class=clsTREven>")
            .Write("<TD>")
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken, , , , , , , , , , , , True, )
            .Write("</TD>")
            .Write("</TR>")
            .Write("</TABLE>")
            'End Addition by SvaitaS

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
