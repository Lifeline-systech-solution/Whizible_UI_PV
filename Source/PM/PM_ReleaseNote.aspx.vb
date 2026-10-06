Public Class PM_ReleaseNote
    Inherits WebPage.Templates.WhizTemplate

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
    '=====================================================================
    ' Page Name             : PM_ReleaseNote
    ' Purpose               : To display the release information associated with a release
    ' Description           : This page is called from the Releases page
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : AbhijeetD
    ' Created               : 5th March 2004
    ' Revisions             : 
    '=====================================================================

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

    Private Const SUBTAGID_RELEASE_FILES As Long = 75

    Private m_strAction As String = ""
    Private m_strFromWhere As String
    Private m_strReleaseID As String
    Private m_strDate As String
    Private m_strInstallation As String
    Private m_strDetails As String
    Private m_strObjectives As String
    Private m_strKnownProblems As String
    Private m_strIssues As String
    Private m_strTestingSummary As String
    Private m_strFeedback As String
    Private m_strFolderPath As String = ""


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.

        'Retrieve parameters from query string
        m_strAction = Request.QueryString("Action")
        m_strReleaseID = Request.QueryString("ReleaseID")
        m_strFromWhere = Request.QueryString("FromWhere")

    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================
        If MyBase.Page.IsPostBack Then
            Select Case m_strAction.ToUpper
                Case "SAVE"
                    UpdateData()
            End Select
        End If

        'Plot the page
        DrawPage()

    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("Resources.PM_ReleaseNote", "Resources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Release Note -> InvalidInput" + UserInput + Cause
        Throw ex
    End Sub

    Public Sub PlotPageHeader()
        '=====================================================================
        ' Procedure Name        : PlotPageHeader
        ' Purpose               : Plot Page Header
        ' Description           : Renders the standard page header. Called from above the <body> tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.PM_ReleaseNote", "AppResources")
        CommonFunction.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION"))
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Renders the UI
        ' Description           : This function generates the html for the page
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================

        Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        If Not m_strReleaseID = "" Then

            ' Added By  on 1 March 2005 for Issue ID 16165 
            ' Draw Menu
            DrawMenu()
            ' End Addition By NitinVS on 1 March 2005 for Issue ID 16165 

            'Read the release information
            GetReleaseInformation()

            'Render the release information
            DrawReleaseInformation()

            'Render the list of release files
            StartSection(MyBase.GetResourceString("UPLOADED_FILES"), "UploadedFiles")
            DrawReleaseFilesList()
            EndSection()

            'Read the feedback information
            GetFeedbackInformation()

            'Render Feedback information
            StartSection(MyBase.GetResourceString("CUSTOMER_FEEDBACK"), "CustomerFeedback")
            DrawFeedbackInformation()
            EndSection()

        End If
        Response.Write("</DIV>")
        ' Added By  on 1 March 2005 for Issue ID 16165 
        ' Draw Menu
        DrawMenu()
        ' End Addition By NitinVS on 1 March 2005 for Issue ID 16165 

    End Sub

    Private Sub StartSection(ByVal strSectionTitle As String, ByVal strSectionID As String)
        '=====================================================================
        ' Procedure Name        : StartSection
        ' Purpose               : Render the section title and script for expand-collapse
        ' Description           : same as above
        ' Parameters Passed     : strSectionTitle - title of the section
        '                          strSectionID  - ID of the section
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : Must be followed by a call to EndSection
        ' Author                : AbhijeetD
        ' Created               : 5th March
        ' Revisions             :
        '=====================================================================

        Dim objSectionTitle As WebPage.Templates.SectionTitle

        objSectionTitle = New WebPage.Templates.SectionTitle
        With objSectionTitle
            CommonFunction.General.WriteHTML(.GetSectionTitle(strSectionTitle, strSectionID, strSectionID))
            CommonFunction.General.WriteHTML("<div id='" + strSectionID + "' style='OVERFLOW: auto;'>")
            CommonFunction.General.WriteHTML("<TABLE id='" + strSectionID + "' width='99.9%' cellSpacing='0' cellPadding='0'>")
            CommonFunction.General.WriteHTML(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            CommonFunction.General.WriteHTML(.ClientsideScript())
            CommonFunction.General.WriteHTML(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With
        objSectionTitle = Nothing

    End Sub

    Private Sub EndSection()
        '=====================================================================
        ' Procedure Name        : EndSection
        ' Purpose               : Close the table and div started in StartSection procedure
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : Must have call to StartSection prior to calling this procedure
        ' Author                : AbhijeetD
        ' Created               : 5th March
        ' Revisions             :
        '=====================================================================

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</div>")

    End Sub
    Private Sub DrawReleaseInformation()
        '=====================================================================
        ' Procedure Name        : DrawReleaseInformation
        ' Purpose               : Render the release information
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March
        ' Revisions             :
        '=====================================================================

        CommonFunction.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Border=0 width='99.9%'>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><img src='../../Images/customerLogo.gif'</img><TD align=center><FONT face=Verdana size=5 color=Black><B>" + MyBase.GetResourceString("PAGE_CAPTION") + "</B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD align=right><FONT face=Verdana size=2 color=Black><B>Date " + CommonFunction.Dates.CGetDate(CDate(m_strDate)) + "</TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=3 color=Black><B><LI>" + MyBase.GetResourceString("OBJECTIVES") + "</LI></B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=2 color=Black><UL>" + HttpUtility.HtmlEncode(m_strObjectives) + "</B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=3 color=Black><B><LI>" + MyBase.GetResourceString("DETAILS") + "</LI></B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=2 color=Black><UL>" + HttpUtility.HtmlEncode(m_strDetails) + "</B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=3 color=Black><B><LI>" + MyBase.GetResourceString("KNOWN_PROBLEMS") + "</LI></B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=2 color=Black><UL>" + HttpUtility.HtmlEncode(m_strKnownProblems) + "</B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=3 color=Black><B><LI>" + MyBase.GetResourceString("INSTALLATION") + "</LI></B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=2 color=Black><UL>" + HttpUtility.HtmlEncode(m_strInstallation) + "</B></FONT></TD>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=3 color=Black><B><LI>" + MyBase.GetResourceString("ISSUES_AND_CONCERNS") + "</LI></B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=2 color=Black><UL>" + HttpUtility.HtmlEncode(m_strIssues) + "</B></FONT></TD>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=3 color=Black><B><LI>" + MyBase.GetResourceString("TESTING_SUMMARY") + "</LI></B></FONT></TD></TR>")
        CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD><FONT face=Verdana size=2 color=Black><UL>" + HttpUtility.HtmlEncode(m_strTestingSummary) + "</B></FONT></TD>")
        CommonFunction.General.WriteHTML("</TABLE>")


    End Sub

    Private Sub DrawReleaseFilesList()
        '=====================================================================
        ' Procedure Name        : DrawReleaseFilesList
        ' Purpose               : Render the list of release files
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================



        Dim strSQL As String
        Dim arrstrActualList() As String = {"FileName", "ReleaseDate", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("FILE_NAME"), MyBase.GetResourceString("UPLOAD_DATE"), MyBase.GetResourceString("FILE_SIZE")}
        Dim arrstrRowLink() As String = {"FileName_OnClick(FileID)", "", ""}
        Dim arrstrTDStyle() As String = {" noWrap align='left' ", " noWrap align='center' ", " noWrap align='center'"}
        Dim strGRID As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Get the Attachment Folder path for release files

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "SELECT AttachmentFolderPath FROM tbl_UI_SubTagMaster WHERE SubTagID = " + SUBTAGID_RELEASE_FILES.ToString
        strSQL = "usp_sel_tbl_UI_SubTagMaster_AttachmentFolderPath_SubTagID " + SUBTAGID_RELEASE_FILES.ToString
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_strFolderPath = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL)).ToString

        'Set the sql for grid
        strSQL = "EXEC usp_Sel_tbl_PM_ReleaseFiles " + m_strReleaseID

        With m_objGrid

            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .RowLinkArray = arrstrRowLink
            .TDStyleArray = arrstrTDStyle
            .PrimaryKey = "FileID"
            .ColumnHeaderAlignment = "center"
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)

    End Sub

    Private Sub GetReleaseInformation()
        '=====================================================================
        ' Procedure Name        : GetReleaseInformation
        ' Purpose               : Reads the release information from database
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim drReader As IDataReader

        'Set the data reader
        strSQL = "usp_Sel_tbl_PM_Release " + m_strReleaseID
        drReader = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)

        If drReader.Read Then
            m_strDate = CommonFunction.Data.CheckIsDBNull(drReader("ReleaseDate")).ToString
            m_strInstallation = CommonFunction.Data.CheckIsDBNull(drReader("Installation")).ToString
            m_strDetails = CommonFunction.Data.CheckIsDBNull(drReader("Details")).ToString
            m_strObjectives = CommonFunction.Data.CheckIsDBNull(drReader("Objectives")).ToString
            m_strKnownProblems = CommonFunction.Data.CheckIsDBNull(drReader("KnownProblems")).ToString
            m_strIssues = CommonFunction.Data.CheckIsDBNull(drReader("Issues")).ToString
            m_strTestingSummary = CommonFunction.Data.CheckIsDBNull(drReader("TestingSummary")).ToString
            'Added By PradeepD on 23-Nov-2005 [DSS: HelpDeskRequestID 213] 
            'to resolve Formatting problem when newline character is present in text
            m_strInstallation = m_strInstallation.Replace(vbNewLine, "<BR>")
            m_strDetails = m_strDetails.Replace(vbNewLine, "<BR>")
            m_strObjectives = m_strObjectives.Replace(vbNewLine, "<BR>")
            m_strKnownProblems = m_strKnownProblems.Replace(vbNewLine, "<BR>")
            m_strIssues = m_strIssues.Replace(vbNewLine, "<BR>")
            m_strTestingSummary = m_strTestingSummary.Replace(vbNewLine, "<BR>")
            'END: Added By PradeepD on 23-Nov-2005
        End If

        'Dispose the data reader
        CommonFunction.Data.DisposeDataReader(drReader)

    End Sub

    Private Sub DrawFeedbackInformation()
        '=====================================================================
        ' Procedure Name        : DrawFeedbackInformation
        ' Purpose               : Render the feedback information
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March
        ' Revisions             :
        '=====================================================================

        CommonFunction.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' width='99.9%'>")
        If Not m_strFromWhere = "" Then
            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'CommonFunction.HTMLControls.DrawTextArea("txtFeedBack", "txtFeedBack", , , , "frmReleaseNote", , , 500, 75, 3500, m_strFeedback)
            CommonFunction.HTMLControls.DrawTextArea("txtFeedBack", "txtFeedBack", , , , "frmReleaseNote", , , 500, 75, 3500, m_strFeedback, EnableHTMLEncode:=True)
            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            'Modified By NitinVS on 1 March 2005 for IssueID 16605
            ' A Function DrawMenu is Added Which Will Draw The Menu

            'Dim objMenu As New WebPage.Templates.StaticMenu
            'Dim arrMenu() As String = {MyBase.GetResourceString("SEND")}
            'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("SEND")}
            'Dim arrClientSideFunctions() As String = {"Send_OnClick(" + m_strReleaseID + ",'" + m_strFromWhere + "')"}
            'Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            'CommonFunction.General.WriteHTML(strMenu)

            'End Modification By NitinVS on 1 March 2005 for Issue ID 16605 
        Else
            CommonFunction.General.WriteHTML("<TR class=" + m_strClsTREven + "><TD class=clsTDOdd>" + m_strFeedback + "</TD></TR>")
        End If
        CommonFunction.General.WriteHTML("</TABLE>")

    End Sub

    Private Sub GetFeedbackInformation()
        '=====================================================================
        ' Procedure Name        : GetFeedbackInformation
        ' Purpose               : Reads the customer feedback information from database
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================
        Dim drReader As IDataReader

        'Set the data reader
        drReader = CommonFunction.Data.GetDataReader("usp_Sel_ReleaseFeedBack " + m_strReleaseID, m_blnUseSQL)

        If drReader.Read Then
            m_strFeedback = CommonFunction.Data.CheckIsDBNull(drReader("FeedBack")).ToString
        End If

        'Dispose the data reader
        CommonFunction.Data.DisposeDataReader(drReader)

    End Sub

    Private Sub DisposeObjects()
        '=====================================================================
        ' Procedure Name        : DisposeObjects
        ' Purpose               : Dispose Objects
        ' Description           : Dispose the objects allocated with memory
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 1st Mar 2004
        ' Revisions             :
        '=====================================================================
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Initialize the folder path
        Dim strFolderPath As String = m_strFolderPath
        Dim strSQL As String = "usp_Sel_tbl_PM_ReleaseFiles_DirName " + CommonFunction.Data.CheckIsDBNull(Args.DataReader("FileID"), "0").ToString
        Dim strDirName As String = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))).ToString

        strFolderPath = strFolderPath + "/" + strDirName
        If Not strDirName = "" Then
            strFolderPath += "/"
        End If
        strFolderPath += CommonFunction.Data.CheckIsDBNull(Args.DataReader("SystemFileName")).ToString

        'Get the physical path
        strFolderPath = HttpContext.Current.Server.MapPath(strFolderPath)

        Select Case Args.ColIndex
            Case 0
                'For FileName Column
                If Not CommonFunction.FileDirectory.IsFileExists(strFolderPath) Then
                    Args.EnableLink = False
                End If

            Case 2
                'For FileSize column
                Dim objFile As New CommonFunction.FileDirectory.FileProperties
                objFile.FilePath = strFolderPath
                objFile.GetFileProperties()

                'Set the value of the File Size column
                Cancel = True
                Args.StringToBeInserted = "<TD noWrap align='center'>" + objFile.FileSizeInKB.ToString + "</TD>"

                objFile = Nothing
        End Select
    End Sub

    Private Sub UpdateData()
        '=====================================================================
        ' Procedure Name        : UpdateData
        ' Purpose               : Updates the data to the database
        ' Description           : updates the customer feedback.
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 5th March 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String

        m_strFeedback = MyBase.FixString(MyBase.GetFormValue("txtFeedBack"), 0, False, False)
        strSQL = "usp_Upd_ReleaseFeedBack " + m_strReleaseID + ",'" + m_strFeedback + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

    End Sub

    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : UpdateData
        ' Purpose               : Updates the data to the database
        ' Description           : updates the customer feedback.
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : NitinVS
        ' Created               : 1 March 2005
        ' Revisions             :
        '=====================================================================
        ' Added By NitinVS on 1 March 2005 for IssueID = 16605

        If Not m_strFromWhere = "" Then
            Dim objMenu As New WebPage.Templates.StaticMenu
            m_objMenu = New WebPage.Templates.StaticMenu
            Dim arrMenu() As String = {MyBase.GetResourceString("SEND"), MyBase.GetResourceString("CLOSE")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("SEND"), MyBase.GetResourceString("CLOSE")}
            Dim arrClientSideFunctions() As String = {"Send_OnClick(" + m_strReleaseID + ",'" + m_strFromWhere + "')", "Close_OnClick()"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunction.General.WriteHTML(strMenu)

        Else
            m_objMenu = New WebPage.Templates.StaticMenu
            Dim arrMenu() As String = {MyBase.GetResourceString("CLOSE")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("CLOSE")}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()"}
            Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
            CommonFunction.General.WriteHTML(strMenu)
        End If
    End Sub
End Class

