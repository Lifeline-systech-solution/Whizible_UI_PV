Public Class PM_MSP_History
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
    ' Page Name             : PM_MSP_History
    ' Purpose               : MSP-Integration
    ' Description           : Lists the previously uploaded MPP Files, Error logs 
    '                         Show History of MPP Project file (Check-ins Check-outs) and
    ' Parameters Passed     : 
    ' Assumptions           : AppResources.PM_MSP_History.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Feb 16th, 2004
    ' Revisions             : 
    '=====================================================================
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strPageTitle As String
    Protected m_lngTagID As Long

    Private Const MPPFILE_FOLDER As String = "../../Projects/"
    Private m_blnUseSQL As Boolean
    Private m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Dim strURL, strSQL As String
        Dim strSourceFilePath As String
        Dim drGetList As IDataReader

        '-------------- Initialize Variables --------------------
        MyBase.InitializeResources("AppResources.PM_MSP_History", "AppResources")

        '-- History Or Errors
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode")).ToString

        '-- Delete 
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("ACTION")).ToString
      
        '-- m_blnUseSQL
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        '-- Display proper Title
        Select Case m_strMode
            Case "HISTORY"
                m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE_HISTORY")
            Case "ERRORS"
                m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE_ERRORS")
            Case Else

        End Select

        '-------------- Initializations end --------------------

        '-- ON 'VIEW' OLD MPP FILE
        If (CommonFunctions.General.CheckIsNothing(Request.QueryString("cmdUpload")).ToUpper = "GET") Then

            'Integrated by MrugajaB on 19th March 2005 for Whizible SEM Issue ID.17013 
            'Added by Prajakta on 17th Feb 2005 for IssueID 11919 of Jopasna
            'strURL = Request.QueryString("OriginalFileName")
            strURL = funcCopyFileToTempFolder()
            'End Addition
            Response.Write("<script language=javascript>" + vbCrLf)
            Response.Write("window.open('../General/ViewAttachment.aspx?FromWhere=PM&FileName=" + strURL + "');" + vbCrLf)
            Response.Write("</script>" + vbCrLf)

        End If

        '-- ON 'DELETE' OLD MPP FILE OR Error
        If (CommonFunctions.General.CheckIsNothing(Request.QueryString("cmdDelete")).ToUpper = "DELETE") Then
            Select Case Request.QueryString("MODE")
                Case "HISTORY"

                    If Trim(Request.Form("chkHistoryList")) <> "" Then
                        strSQL = "EXEC usp_Sel_GetMSPHistory " + Session("intProjectId").ToString + ",2,'" + Request.Form("chkHistoryList") + "'"
                        drGetList = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                        'When you delete all the records also delete the corresponding MPP and MDB files from the Project folder
                        Do While (drGetList.Read)
                            strSourceFilePath = MPPFILE_FOLDER + drGetList("GeneratedName").ToString
                            strSourceFilePath = Server.MapPath(strSourceFilePath)

                            If (CommonFunctions.FileDirectory.IsFileExists(strSourceFilePath)) Then
                                CommonFunctions.FileDirectory.DeleteFile(strSourceFilePath)
                            End If

                            'Also Delete the MDB file from the folder
                            strSourceFilePath = Replace(strSourceFilePath, ".mpp", ".mdb")

                            If (CommonFunctions.FileDirectory.IsFileExists(strSourceFilePath)) Then
                                CommonFunctions.FileDirectory.DeleteFile(strSourceFilePath)
                            End If

                        Loop

                        CommonFunctions.Data.DisposeDataReader(drGetList)
                    End If

                Case "ERRORS"

                    If Trim(Request.Form("chkErrorList")) <> "" Then
                        strSQL = "EXEC usp_show_MSPErrors NULL,2,'" + Request.Form("chkErrorList") + "'"
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    End If

                Case Else
                    '-- ikade kaise alla tumi ??
            End Select
        End If

    End Sub

    
    Public Sub DrawPage()
        '-- Main function which is called from within the <FORM> Tag
        Dim strMenu As String

        '-- TOP Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")

        '-- Draw Page Caption
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, m_strPageTitle, , , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")

        '-- Display the Proper Grid (MSP History OR Errors)
        Select Case m_strMode
            Case "HISTORY"
                Call Display_MSPHistory_Grid()

            Case "ERRORS"
                Call display_MSPErrors_Grid()

            Case Else
                '-- Yeh kahan aa gaye hum??
        End Select

        Response.Write("</DIV>")

        '-- BOTTOM Menu
        Response.Write("<br>" + strMenu)

        '-- Destroy Module level objects
        Call DisposeObjects()
    End Sub

    Private Sub Display_MSPHistory_Grid()
        '-- History Grid

        Dim strSQL As String
        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrstrActualList() As String = {"OriginalFileName", "UploadedDate", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("GRID_FILE_NAME"), MyBase.GetResourceString("GRID_UPLOAD_DATE"), MyBase.GetResourceString("GRID_DELETE")}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Integrated by MrugajaB on 19th March 2005 for Whizible SEM Issue ID.17013
        'Modified by PrajaktaR for IssueID 11919 of Jopasna  
        'Dim arrstrRowLink() As String = {"subDisplayFile(OriginalFileName)", "", ""}
        Dim arrstrRowLink() As String = {"subDisplayFile(MSPHistoryID)", "", ""}
        'End Modification

        Dim arrstrTDStyle() As String = {" align=left ", " align=left", " align=center"}
        Dim arrstrCheckboxID() As String = {"", "", "chkHistoryList"}
        Dim strGRID As String

        strSQL = "EXEC usp_Sel_GetMSPHistory " + Session("intProjectId").ToString + ",1,NULL"

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .RowLinkArray = arrstrRowLink
            .PrimaryKey = "MSPHistoryID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "center"
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)
        objGrid = Nothing

    End Sub

    Private Sub display_MSPErrors_Grid()
        '-- Errors Grid
        Dim strSQL As String
        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrstrActualList() As String = {"ErrorDate", "ErrorDescription", ""}
        Dim arrstrUserFriendlyList() As String = {MyBase.GetResourceString("GRID_ERROR_ON"), MyBase.GetResourceString("GRID_ERROR_DESC"), MyBase.GetResourceString("GRID_DELETE")}
        Dim arrstrTDStyle() As String = {" align=left ", " align=left", " align=center"}
        Dim arrstrCheckboxID() As String = {"", "", "chkErrorList"}
        Dim strGRID As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "EXEC usp_show_MSPErrors " + Session("intProjectId").ToString + ",1,NULL"

        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0) - 1
            .PrimaryKey = "MSPID"
            .CheckBoxIDArray = arrstrCheckboxID
            .ColumnHeaderAlignment = "center"
            .SQL = strSQL
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With
        Response.Write(strGRID)
        objGrid = Nothing

    End Sub
    Private Sub DisposeObjects()
        m_objMenu = Nothing
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrClientSideFunctions() As String = {"Delete_OnClick()", "Close_OnClick()"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PM_MSP_History", "AppResources")
        Return (strMenu)

    End Function

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Function Name         : CreateGlobalObject
        ' Purpose               : Creates the Global Object for accessing TagID, FrowWhere etc.
        ' Description           : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Feb 16, 2004
        ' Revisions             : 
        '=====================================================================

        'Global object
        Dim objAccess As New WebPage.Templates.AccessRights
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject

        '-- HardCode the Master TagID For Popup page
        'objGlobal.TagID = 29
        'objGlobal.FromWhere = "PM"
        m_lngTagID = 29
        If m_lngTagID = 0 Then
            m_lngTagID = objGlobal.TagID
        Else
            objGlobal.TagID = m_lngTagID
        End If

        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing
        objGlobal = Nothing
    End Sub

    Public Sub Plothead()
        '-- Plots html page head
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)

    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PM_MSP_History", "AppResources")
    End Sub

    Public Shared Function funcCopyFileToTempFolder() As String
        '=====================================================================
        ' Procedure Name        : funcCopyFileToTempFolder
        ' Purpose               : To copy the history file to the Attachments folder
        ' Description           : The function gets the name of history file from the database,
        '                         copies the history file from the "Projects" folder to the
        '                         "Attachments" folder and saves it with the original filename.
        ' Parameters Passed     : None
        ' Returns               : String (Original filename)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : IrtaizaS
        ' Created               : FEB 16th, 2005   
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strURL As String
        Dim drfuncAttachments As IDataReader
        Dim strSourceFilePath As String
        Dim strDestinationFileName As String
        Dim strAttachmentType As String
        strAttachmentType = "File"

        strSQL = "SELECT GeneratedName,OriginalFileName FROM  tbl_PM_MSPHistory WHERE ProjectID = " + HttpContext.Current.Session("intProjectId").ToString _
                    & " AND MSPHistoryID = " & HttpContext.Current.Request.QueryString("MSPHistoryID")

        drfuncAttachments = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If Not drfuncAttachments.Read() Then
            CommonFunction.Data.DisposeDataReader(drfuncAttachments)
            Return ""
        End If

        strSourceFilePath = "..\..\Projects\" + CommonFunctions.Data.CheckIsDBNull(drfuncAttachments("GeneratedName")).ToString

        strSourceFilePath = HttpContext.Current.Server.MapPath(strSourceFilePath)
        strDestinationFileName = "..\..\Attachments\PM\" + CommonFunctions.Data.CheckIsDBNull(drfuncAttachments("OriginalFileName")).ToString
        strDestinationFileName = HttpContext.Current.Server.MapPath(strDestinationFileName)

        If (CommonFunctions.FileDirectory.IsFileExists(strSourceFilePath)) Then
            CommonFunctions.FileDirectory.CopyFile(strSourceFilePath, strDestinationFileName, True)
        End If

        strURL = CType(CommonFunctions.Data.CheckIsDBNull(drfuncAttachments("OriginalFileName")), String)

        CommonFunction.Data.DisposeDataReader(drfuncAttachments)

        Return (strURL)

    End Function

End Class
