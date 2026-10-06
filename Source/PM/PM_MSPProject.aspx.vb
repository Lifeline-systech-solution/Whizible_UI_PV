Public Class PM_MSPProject
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PM_MSPProject
    ' Purpose               : MSP-Integration
    ' Description           : Check-In/ Check-out of MPP File 
    '                         Show History of MPP Project file (Check-ins Check-outs) and
    ' Parameters Passed     : 
    ' Assumptions           : AppResources.PM_MSPProject.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Feb 16th, 2004
    ' Revisions             : 
    '=====================================================================

    Protected m_strPageTitle As String
    Protected m_lngProjectID As Long
    Protected m_lngTagID As Long
    Protected m_blnAddAccess, m_blnDeleteAccess, m_blnEditAccess As Boolean
    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu

    'Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
    'Purpose: Not allow to do any activity if Project is not baselined 
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_intBaselineNumber As Integer = 0

    'Addtion ended
    Private m_blnUseSQL As Boolean
    Private m_blnCan_Undo_CheckOut_File, m_blnFile_Uploaded As Boolean
    Private m_bln_FileCheckedOut As Boolean
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_strMSPConnStr As String
    Private m_objConnection As New ADODB.Connection

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
        'Put user code to initialize the page here

        Dim strSQL, strFile As String
        Dim strFromWhere, strURL As String
        Dim drResult, drGetResourceInfo, drCheckBaseLine As IDataReader

        Call Initialize()
        Call CreateGlobalObject()

        '___________________________________________________________________________________________
        ' SAVE MODE
        If ((Request.QueryString("Mode") + "").Trim.ToUpper = "SAVE") Then

       
            'Here we will call function to upload the tasks to PBN
            'GetFileName from the Database
            strSQL = "EXEC usp_Sel_ProjectParameters " + Session("intProjectID").ToString + ",1"
            drCheckBaseLine = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

            If (drCheckBaseLine.Read) Then
                strFile = Server.MapPath("..\..\Projects") + "\" + drCheckBaseLine("MSProjectFileName").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(drCheckBaseLine)

            'OLEDB Componant of the MSProject 2000
            'Purpose: to give support to the MSP 2000 and MSP 2002
            'Fire one query which will return you the type of MSP you are using

            Select Case CommonFunctions.Application.MSPVersion.ToString
                Case "2000"
                    'OLEDB Componant of the MSProject 2000
                    m_strMSPConnStr = "Provider=Microsoft.Project.OLEDB.9.0;PROJECT NAME=" + strFile

                Case "2002"
                    'OLEDB Componant of the MSProject 2002
                    m_strMSPConnStr = "Provider=Microsoft.Project.OLEDB.10.0;PROJECT NAME=" + strFile

                Case "2003"
                    'OLEDB Componant of the MSProject 2003
                    m_strMSPConnStr = "Provider=Microsoft.Project.OLEDB.11.0;PROJECT NAME=" + strFile

                Case Else
                    'OLEDB Componant of the MSProject 2000 (By default it will be MS Project 2000)
                    m_strMSPConnStr = "Provider=Microsoft.Project.OLEDB.9.0;PROJECT NAME=" + strFile

            End Select


            Call subImportData(strFile)

            '-- refresh Current Page
            'Response.Write("<SCRIPT Language=javascript>" + vbCrLf) '
            'Response.Write("var objForm = GetFormReference('Uploadutility');" + vbCrLf)
            'Response.Write("objForm.action = 'PM_MSPProject.aspx?'" + vbCrLf)
            'Response.Write("objForm.submit(); " + vbCrLf)

            'Response.Write("alert (" + Chr(34) + MyBase.GetResourceString("SUCCESS_MSG") + Chr(34) + ");" + vbCrLf)

            'Response.Write("</SCRIPT>" + vbCrLf)
        End If

        '____________________________________________________________________________________________
        '-- WHEN UNDO CHECKOUT is Clicked
        If ((Request.QueryString("cmdUndoCheckOut") + "").Trim.ToUpper = "CHECKOUT") Then
            'Here In this we are passing the variable 1 as a querytype because this SP is use at two different places
            'This paramater will deside which query we have to execute
            strSQL = "EXEC usp_upd_MsProject_UndoCheckOUT " + m_lngProjectID.ToString + "," + Session("intUserID").ToString + ",1"

            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

        End If

        '____________________________________________________________________________________________
        '-- first check that user has assign resources to this project
        '-- If No resources r assigned: Alert the User
        strSQL = "EXEC usp_Sel_teammembers " + m_lngProjectID.ToString
        drGetResourceInfo = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        If Not (drGetResourceInfo.Read) Then
            Response.Write("<script Language=javascript>")
            Response.Write("alert('" + MyBase.GetResourceString("NORESOURCE_MSG") + "');")
            Response.Write("</script>")

        End If
        CommonFunctions.Data.DisposeDataReader(drGetResourceInfo)

        '____________________________________________________________________________________________
        '-- When user Clicks on GET: Get a Copy of File and Open in New Window
        If ((Request.QueryString("cmdUpload") + "").Trim.ToString = "GET") Then
            strFromWhere = "PM"

            strURL = CommonFunction.General.funcReturnOriginalFileName(strFromWhere, 0)

            'strSQL = "SELECT MsProjectFileName,OriginalFileName FROM tbl_PM_Project WHERE ProjectID = " + HttpContext.Current.Session("intProjectId").ToString
            'drResult = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            'If drResult.Read Then
            '    strURL = drResult("OriginalFileName").ToString
            'End If

            'strURL = Server.MapPath(strURL)
            Response.Write("<script language=javascript>" + vbCrLf)
            Response.Write("window.open('../General/ViewAttachment.aspx?FromWhere=PM&FileName=" + strURL + "');" + vbCrLf)
            Response.Write("</script>" + vbCrLf)
        End If

        '____________________________________________________________________________________________
        '-- On Check Out Update the checkin checkout table..
        If ((Request.QueryString("cmdUpload") + "").Trim.ToUpper = "DOWNLOAD") Then
            'This query will insert new record in the MSPreview table and also update the fields of the checkin checkout table

            strSQL = "EXEC usp_upd_MsProject_UndoCheckOUT " + Session("intProjectID").ToString + "," + Session("intUserID").ToString + ",2"

            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

            strFromWhere = "PM"
            strURL = CommonFunction.General.funcReturnOriginalFileName(strFromWhere, 0)

            Response.Write("<script language=javascript>" + vbCrLf)
            Response.Write("window.open('../General/ViewAttachment.aspx?FromWhere=PM&FileName=" + Server.UrlEncode(strURL) + "');" + vbCrLf)
            Response.Write("</script>" + vbCrLf)

        End If

        CommonFunctions.Data.DisposeDataReader(drResult)
        'Get the status of 'Project creation workflow required' flag

       
    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Function called from the <FORM> tag
        ' Description           : Draws the Page Controls on the page
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================

        '-- Draws the controls on the page 
        '-- Functions is called from aspx page.. from within the Body tag
        Dim strMessage, strMenu, strSQL As String
        Dim drMSProjectFileName, drDownloadStatus As IDataReader
        Dim strFileName, strEmployeeName As String
        Dim dtmDownloadDate As Date

        '-- 1st Table 
        strSQL = "EXEC usp_Sel_ProjectParameters " + Session("intProjectID").ToString + ",1"
        drMSProjectFileName = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        strSQL = "EXEC usp_Sel_ProjectParameters " + Session("intProjectID").ToString + ",2"
        drDownloadStatus = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        'Modified By PrachiK on 28 Feb 2005 for Issue ID. 15334
        'Purpose: Not allow to do any activity if Project is not baselined
        m_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(Session("intProjectID").ToString, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
        Dim strQuery As String = ""
        Dim drProjectStatus As IDataReader

        strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

        drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
            If drProjectStatus.Read() Then
                m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectStatus)
        'If m_blnIsProjectCreationWorkflowReqd = True Then
        '    If m_intBaselineNumber = 0 Then
        '        Args.ToBeInsertedInFunction += "alert('Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project is not Baselined.');" & vbCrLf
        '        Args.ToBeInsertedInFunction += "return;"
        '    End If
        'End If
        'Addtion ended



        If drMSProjectFileName.Read Then
            m_blnFile_Uploaded = True

            strFileName = drMSProjectFileName("OriginalFileName").ToString

            If drDownloadStatus.Read Then
                '-- File is Checked Out
                strMessage = ""
                If (CType(drDownloadStatus("DownloadStatus"), Boolean)) Then
                    m_bln_FileCheckedOut = True
                    strEmployeeName = drDownloadStatus("EmployeeName").ToString
                    dtmDownloadDate = CType(CommonFunctions.Data.CheckIsDBNull(drDownloadStatus("DownloadDate"), ""), Date)
                End If

                '-- If File has been downloaded by This Employee then only s/he can 'Check In' 
                '-- that file And 'Undo CheckOut'
                If (CType(drDownloadStatus("DownloadStatus"), Boolean) And (drDownloadStatus("EmployeeId").ToString = Session("intUserID").ToString)) Then

                    'User Can Check In AND Undo Check Out IF s/he has Add/Edit Access
                    m_blnCan_Undo_CheckOut_File = True

                End If

            End If

        End If
        CommonFunctions.Data.DisposeDataReader(drDownloadStatus)
        CommonFunctions.Data.DisposeDataReader(drMSProjectFileName)

        '____________________________________________________________________________________________
        '-- Draw TOP Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")

        '-- Draw Page Caption

        WebPage.Templates.PageCaption.GetPageCaptions(m_objGlobal, , , , False)
        Response.Write("<BR>")

        '-- Display header
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<DIV ID='divList' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")

        If m_blnFile_Uploaded Then
            strMessage = MyBase.GetResourceString("LAST_FILE") + strFileName + ""
            Response.Write("<TABLE Width='99.9%' Class=clsTable cellspacing=0>")
            Response.Write("<TR class=clsTREven>")
            Response.Write("<TD align=center>")
            Response.Write(Server.HtmlEncode(strMessage))
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("</TABLE><br>")
        End If

        If m_bln_FileCheckedOut Then
            strMessage = MyBase.GetResourceString("LOCKED_MSG") + strEmployeeName + "."
            strMessage = strMessage + MyBase.GetResourceString("FILE_DL_DATE") + "" + CommonFunctions.Dates.CGetDateTime(dtmDownloadDate)

            '-- Show 'File is Locked' Message on Screen
            Response.Write("<TABLE Width='99.9%' Class=clsTable cellspacing=0>")
            Response.Write("<TR class=clsTRColumnHeader>")
            Response.Write("<TD align=center>")
            Response.Write(Server.HtmlEncode(strMessage))
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("</TABLE><br>")

        End If


        If m_blnFile_Uploaded Then
            'Call fn. to Display Review Grid
            Call Plot_MPP_Review_Grid()
        Else
            '-- MPP File Not Uploaded
            strMessage = MyBase.GetResourceString("NO_MPP_FILE")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            Response.Write("<TABLE Width='99.9%' Class=clsTable cellspacing=0>")
            Response.Write("<TR class=clsTRColumnHeader>")
            Response.Write("<TD colspan=2><b>")
            Response.Write(Server.HtmlEncode(MyBase.GetResourceString("INSTRUCT_MSG")))
            Response.Write("</TD>")
            Response.Write("</TR>")
            Response.Write("<TR class=clsTROdd><TD>1.")
            Response.Write("<TD><b>")
            Response.Write(Server.HtmlEncode(MyBase.GetResourceString("INSTRUCT_1")))
            Response.Write("</TD></TR>")
            Response.Write("<TR class=clsTROdd><TD>2.")
            Response.Write("<TD><b>")
            Response.Write(Server.HtmlEncode(MyBase.GetResourceString("INSTRUCT_2")))
            Response.Write("</TD></TR>")
            Response.Write("</TABLE>")

        End If

        Response.Write("</DIV>")

        '-- Display Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        Response.Write("<br>")
        Response.Write(strMenu)

        m_objGlobal = Nothing

    End Sub

    Private Sub Plot_MPP_Review_Grid()
        '=====================================================================
        ' Procedure Name        : Plot_MPP_Review_Grid
        ' Purpose               : Draws the Vertical MPP Grid for Review details
        ' Description           : 
        ' Parameters Passed     : None
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        '-- Display all the reviews for the currently selected project
        '-- We use a Vertical Grid
        strSQL = " usp_Sel_MSP_FileReviewHistory " + Session("intProjectID").ToString

        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrstrActualList() As String = {"Status", "ReviewNote"}
        Dim arrstrUserFriendlyList() As String = {"", ""}
        Dim arrstrTDStyle() As String = {" align=left ", " align=left"}
        Dim strGRID As String
        Dim arrstrIgnoreHTML() As String = {"1", "1"}

        'Response.Write("<div>")
        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .SQL = strSQL
            .VerticalDisplay = True
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            strGRID = .DrawGrid()
        End With
        objGrid = Nothing

        Dim objMSPReview As New WebPages.Template.SectionTitle
        With objMSPReview
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("PROJECT_HISTORY"), "DivOtherInfo", "ShowHideOtherInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivOtherInfo' Style='Overflow:Auto;Height:100px;width:100%'>")
        '--call to display Grid
        Response.Write(strGRID)
        Response.Write("</DIV>")

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize
        ' Purpose               : To initialize the Page Level variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        '-- Init. Variables and resource file 
        MyBase.InitializeResources("AppResources.PM_MSPProject", "AppResources")
        m_blnCan_Undo_CheckOut_File = False
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_lngProjectID = CType(Session("intProjectID"), Long)
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_lngTagID = CType(Request.QueryString("MasterTagID"), Long)
        If m_lngTagID = 0 Then m_lngTagID = 29

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
        MyBase.InitializeResources("AppResources.PM_MSPProject", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("CHECKIN"), MyBase.GetResourceString("UNDO_CHECKOUT"), MyBase.GetResourceString("USER_MAPPING"), MyBase.GetResourceString("GET"), MyBase.GetResourceString("CHECKOUT"), MyBase.GetResourceString("MSPHISTORY"), MyBase.GetResourceString("MSPERRORS"), MyBase.GetResourceString("HELP")}
        'Added By PrachiK on 21 Mar 2005 for Issue ID 16451. 
        'Purpose:Consistency Issue :- In MSP Integration :- to get a help for this page a link 'Help' is present whereas for the other nodes in the application '?' symbol is present.

        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("CHECKIN"), MyBase.GetResourceString("UNDO_CHECKOUT"), MyBase.GetResourceString("USER_MAPPING"), MyBase.GetResourceString("GET"), MyBase.GetResourceString("CHECKOUT"), MyBase.GetResourceString("MSPHISTORY"), MyBase.GetResourceString("MSPERRORS"), MyBase.GetResourceString("HELP_TOOLTIP")}
        'Modification Ended
        Dim arrClientSideFunctions() As String = {"DL_OnClick()", "Undo_CheckOut()", "UserMapping_OnClick()", "Get_OnClick(" + m_lngTagID.ToString + ")", "UP_OnClick()", "MSPHistory_OnClick()", "MSPErrors_OnClick()", "Help_OnClick(" + m_lngTagID.ToString + ")"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu


    End Function

    Public Sub PlotHead()
        '-- Plots head od the page
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

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
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject

        If m_lngTagID = 0 Then
            m_lngTagID = m_objGlobal.TagID
        Else
            m_objGlobal.TagID = m_lngTagID
        End If

        objAccess.GetAccess(m_objGlobal)

        m_blnAddAccess = objAccess.Add          'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete    'If User has Delete Access
        m_blnEditAccess = objAccess.Edit        'If user has Edit Access

        'destroy global and AccessRights objects
        objAccess = Nothing

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        '-- In this event we control the Access to the links according to Access rights and CheckIn/Checkout
        Dim strSQL As String
        Dim drTemp As IDataReader

        '-- UNDO CHECK OUT :: If Flag set AND the User has Add/Edit Access then only show link
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("UNDO_CHECKOUT").ToUpper) Then
            If Not (m_blnCan_Undo_CheckOut_File And (m_blnAddAccess Or m_blnEditAccess)) Then

                Cancel = True
            End If
        End If

        '-- CHECKIN ::
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("CHECKIN").ToUpper) Then
            If Not (m_blnAddAccess Or m_blnEditAccess) Then
                Cancel = True
            End If

            If Not (m_blnCan_Undo_CheckOut_File Or Not m_blnFile_Uploaded) Then

                Cancel = True
            End If
        End If

        '-- CHECKOUT:: When Not to show 'CheckOut' Link
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("CHECKOUT").ToUpper) Then
            If Not (m_blnAddAccess Or m_blnEditAccess) Then
                Cancel = True
            End If

            If (m_bln_FileCheckedOut) Then
                Cancel = True
            End If

            If Not (m_blnFile_Uploaded) Then
                Cancel = True
            End If
        End If

        '-- GET:: link enable when a File has been checked IN 
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("GET").ToUpper) Then
            If Not m_blnFile_Uploaded Then
                Cancel = True
            End If
        End If

        '-- MSP HISTORY
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("MSPHISTORY").ToUpper) Then

            '-- If No records present in history table, then we do not show History table
            strSQL = "EXEC usp_Sel_GetMSPHistory " + Session("intProjectId").ToString + ",1,NULL"
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If Not drTemp.Read Then
                Cancel = True

            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
        End If

        '-- MSP ERRORS :: If No records not present in History table 
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("MSPERRORS").ToUpper) Then

            '-- If No records present in history table, then we do not show History table
            strSQL = "EXEC usp_show_MSPErrors " + Session("intProjectId").ToString + ",1,NULL"
            drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            If Not drTemp.Read Then
                Cancel = True

            End If
            CommonFunctions.Data.DisposeDataReader(drTemp)
        End If

        '-- USER MAPPING : If File is uploaded , then this page can be accessed
        If (Args.LinkName.ToUpper = MyBase.GetResourceString("USER_MAPPING").ToUpper) Then
            If Not m_blnFile_Uploaded Then
                Cancel = True
            End If
        End If

    End Sub



    Private Sub subImportData(ByVal strFile As String)
        '=====================================================================
        ' Procedure Name        : subImportData
        ' Description           : Import all the data from OLEDB to the temp tables
        '						  and from temp tables to the Projecttask and milestone table 
        ' Purpose               : 
        ' Parameters Passed     : FileName to get the required OLEDB object
        ' Returns               : None
        ' Parameters Affected   : ProjectTask table
        ' Assumptions           : It is assume that a valid filename is pass to the function
        ' Dependencies          : None
        ' Author                : AmitL
        ' Created               : Friday, 02 March, 2002 14:35 
        ' Revisions             :
        '=====================================================================
        Dim drResult As IDataReader
        Dim strSelect, strTaskName, strSQL As String
        Dim intCritical As Integer
        Dim intMilestone As Integer
        Dim IsTaskComplete As Integer
        Dim conMSPData As CommonFunctions.Connection
        Dim dtmStartDate, dtmFinishDate, strConstraintDate As String
        Dim dtmActualStartDate, dtmActualFinishDate As String
        Dim dtmBaselineStartDate, dtmBaselineFinishDate As String
        Dim lngResourcePercentage As Double

        Dim rsTest As New ADODB.Recordset

        'first delete all the records from the temp tables
        strSelect = "EXEC usp_Del_Temp_Tables_Contents " + Session("intProjectID").ToString
        CommonFunctions.Data.InsertOrUpdateData(strSelect, m_blnUseSQL)

        'First extract all the data from the TASKS TABLE
        '-- Revised: SuryabirD 6th April : Added 2 Constraint Fields 
        strSelect = "Select TaskName,TaskUniqueId,TaskRemainingWork,TaskNotes,TaskStartVariance, " & _
                    " TaskFinishVariance, TaskBaselineDuration, TaskDuration, TaskCritical, TaskMilestone," & _
                    " TaskPriority, TaskText30, TaskUniqueIDPredecessors, TaskUniqueIDSuccessors, TaskConstraintType, TaskConstraintDate FROM Tasks " & _
                    " WHERE TaskSummary = 0 "

        'drTest = CommonFunctions.Data.GetDataReader(strSelect, False, m_strMSPConnStr)

        '-- Open Connection to MSP File
        m_objConnection.Open(m_strMSPConnStr)

        rsTest = m_objConnection.Execute(strSelect)

        Do While Not (rsTest.EOF)
            If CStr(rsTest("TaskName").Value) <> "" Then
                If CBool(rsTest("TaskCritical").Value) Then
                    intCritical = 1
                Else
                    intCritical = 0
                End If

                If CBool(rsTest("TaskMilestone").Value) Then
                    intMilestone = 1
                Else
                    intMilestone = 0
                End If

                If (CDbl(rsTest("TaskRemainingWork").Value) = 0) Then
                    IsTaskComplete = 1
                Else
                    IsTaskComplete = 0
                End If

                'Constraint Date
                If Len(CStr(rsTest("TaskConstraintDate").Value)) < 12 Then
                    If (InStr(1, CStr(rsTest("TaskConstraintDate").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("TaskConstraintDate").Value), "PM") <> 0) Then
                        strConstraintDate = "NULL"
                    Else
                        strConstraintDate = "'" + CStr(rsTest("TaskConstraintDate").Value) + "'"
                    End If
                Else
                    strConstraintDate = "'" + CStr(rsTest("TaskConstraintDate").Value) + "'"
                End If

                strTaskName = CommonFunctions.General.CheckIsNothing(funcBuildTaskName(CStr(rsTest("TaskUniqueId").Value)), "")

                'strSelect = "Insert into tbl_MSP_Tasks "
                'strSelect = strSelect + " (TaskName,TaskUniqueId,TaskRemainingWork,TaskNotes,TaskStartVariance,TaskFinishVariance,TaskBaselineDuration,TaskDuration,TaskCritical,TaskMilestone,TaskPriority,Text30,ProjectId,TaskPredecessors,TaskSuccessors)"
                'strSelect = strSelect + " VALUES('" + Trim(Left(CommonFunctions.General.BuildQueryString(strTaskName) + "", 254)) + _
                '"'," + Replace(drTest("TaskUniqueId"), vbNullChar, "") + "," + IsTaskComplete + ",'" + _
                'Trim(Left(CommonFunctions.General.BuildQueryString(Replace(drTest("TaskNotes"), vbNullChar, "")), 1999)) + _
                '"'," + Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskStartVariance"), ""), vbNullChar, "") + ", " + Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskFinishVariance")), vbNullChar, "") + "," + _
                'Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskBaselineDuration")), vbNullChar, "") + "," + Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskDuration"), ""), vbNullChar, "") + "," + intCritical + "," + _
                'intMilestone + ",'" + Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskPriority")).ToString, vbNullChar, "") + "','" + _
                'Trim(Left(CommonFunctions.General.BuildQueryString(Replace(drTest("TaskText30").ToString, vbNullChar, "")), 99)) + "'," + Session("intProjectID").ToString + _
                '",'" + Trim(Left(CommonFunctions.General.BuildQueryString(Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskUniqueIDPredecessors")).ToString, vbNullChar, "")) + "", 49)) + _
                '"','" + Trim(Left(CommonFunctions.General.BuildQueryString(Replace(CommonFunctions.Data.CheckIsDBNull(drTest("TaskUniqueIDSuccessors")).ToString, vbNullChar, "")), 49)) + "')"

                strSelect = "Insert into tbl_MSP_Tasks "
                strSelect = strSelect & " (TaskName,TaskUniqueId,TaskRemainingWork,TaskNotes,TaskStartVariance,TaskFinishVariance,TaskBaselineDuration,TaskDuration,TaskCritical,TaskMilestone,TaskPriority,Text30,ProjectId,TaskPredecessors,TaskSuccessors, ConstraintType, ConstraintDate) "
                strSelect = strSelect & " VALUES('" & Trim(Left(CommonFunctions.General.BuildQueryString(strTaskName) & "", 254)) & "'," & _
                CStr(rsTest("TaskUniqueId").Value) & "," & IsTaskComplete & ",'" & Trim(Left(CommonFunctions.General.BuildQueryString(CStr(rsTest("TaskNotes").Value)) & "", 1999)) & "'," & _
                CStr(rsTest("TaskStartVariance").Value) & ", " & CStr(rsTest("TaskFinishVariance").Value) & "," & _
                CStr(rsTest("TaskBaselineDuration").Value) & "," & CStr(rsTest("TaskDuration").Value) & "," & intCritical & "," & intMilestone & ",'" & _
                CStr(rsTest("TaskPriority").Value) & "','" & Trim(Left(CommonFunctions.General.BuildQueryString(CStr(rsTest("TaskText30").Value)) & "", 99)) & "'," & _
                CStr(Session("intProjectID")) & ",'" & Trim(Left(CommonFunctions.General.BuildQueryString(CStr(rsTest("TaskUniqueIDPredecessors").Value)) & "", 49)) & "','" & _
                Trim(Left(CommonFunctions.General.BuildQueryString(CStr(rsTest("TaskUniqueIDSuccessors").Value)) & "", 49)) & "'," & _
                "'" & CommonFunctions.Data.CheckIsDBNull(rsTest("TaskConstraintType").Value).ToString & "'," & strConstraintDate & ")"

                CommonFunctions.Data.InsertOrUpdateData(strSelect, m_blnUseSQL)

            End If
            rsTest.MoveNext()
        Loop

        rsTest = Nothing

        'Now extract all the data from the ASSIGNMENT TABLE

        strSelect = "Select AssignmentTaskSummaryName,ResourceUniqueId,TaskUniqueID,Assignmentstart,AssignmentFinish,AssignmentWork,AssignmentActualWork,AssignmentActualstart,assignmentactualfinish,AssignmentBaselineWork,AssignmentBaselinestart,AssignmentBaselinefinish,AssignmentUnits FROM Assignments"

        'drTest = CommonFunctions.Data.GetDataReader(strSelect, False, m_strMSPConnStr)

        rsTest = m_objConnection.Execute(strSelect)

        Do While Not (rsTest.EOF)

            'start
            If Len(CStr(rsTest("Assignmentstart").Value)) < 12 Then
                If (InStr(1, CStr(rsTest("Assignmentstart").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("Assignmentstart").Value), "PM") <> 0) Then
                    dtmStartDate = "NULL"
                Else
                    dtmStartDate = "'" + CStr(rsTest("Assignmentstart").Value) + "'"
                End If
            Else
                dtmStartDate = "'" + CStr(rsTest("Assignmentstart").Value) + "'"
            End If

            'finish
            If Len(CStr(rsTest("AssignmentFinish").Value)) < 12 Then
                If (InStr(1, CStr(rsTest("AssignmentFinish").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("AssignmentFinish").Value), "PM") <> 0) Then
                    dtmFinishDate = "NULL"
                Else
                    dtmFinishDate = "'" + CStr(rsTest("AssignmentFinish").Value) + "'"
                End If
            Else
                dtmFinishDate = "'" + CStr(rsTest("AssignmentFinish").Value) + "'"
            End If

            'Actual start
            If Len(CStr(rsTest("AssignmentActualstart").Value)) < 12 Then
                If (InStr(1, CStr(rsTest("AssignmentActualstart").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("AssignmentActualstart").Value), "PM") <> 0) Then
                    dtmActualStartDate = "NULL"
                Else
                    dtmActualStartDate = "'" + CStr(rsTest("AssignmentActualstart").Value) + "'"
                End If
            Else
                dtmActualStartDate = "'" + CStr(rsTest("AssignmentActualstart").Value) + "'"
            End If

            'actualfinish
            If Len(CStr(rsTest("AssignmentActualFinish").Value)) < 12 Then
                If (InStr(1, CStr(rsTest("AssignmentActualFinish").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("AssignmentActualFinish").Value), "PM") <> 0) Then
                    dtmActualFinishDate = "NULL"
                Else
                    dtmActualFinishDate = "'" + CStr(rsTest("AssignmentActualFinish").Value) + "'"
                End If
            Else
                dtmActualFinishDate = "'" + CStr(rsTest("AssignmentActualFinish").Value) + "'"
            End If

            'Baseline start
            If Len(CStr(rsTest("AssignmentBaselinestart").Value)) < 12 Then
                If (InStr(1, CStr(rsTest("AssignmentBaselinestart").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("AssignmentBaselinestart").Value), "PM") <> 0) Then
                    dtmBaselineStartDate = "NULL"
                Else
                    dtmBaselineStartDate = "'" + CStr(rsTest("AssignmentBaselinestart").Value) + "'"
                End If
            Else
                dtmBaselineStartDate = "'" + CStr(rsTest("AssignmentBaselinestart").Value) + "'"
            End If

            'Baseline finish
            If Len(CStr(rsTest("AssignmentBaselineFinish").Value)) < 12 Then
                If (InStr(1, CStr(rsTest("AssignmentBaselineFinish").Value), "AM") <> 0) Or (InStr(1, CStr(rsTest("AssignmentBaselineFinish").Value), "PM") <> 0) Then
                    dtmBaselineFinishDate = "NULL"
                Else
                    dtmBaselineFinishDate = "'" + CStr(rsTest("AssignmentBaselineFinish").Value) + "'"
                End If
            Else
                dtmBaselineFinishDate = "'" + CStr(rsTest("AssignmentBaselineFinish").Value) + "'"
            End If

            'Find out the resource percentage for the selected Task
            lngResourcePercentage = CDbl(rsTest("AssignmentUnits").Value) * 100

            strSelect = "Insert into tbl_MSP_Assignments "
            strSelect = strSelect + " (ResourceId,TaskUniqueId,Start,Finish,[Work],ActualStart,ActualFinish,BaselineWork,BaselineStart,BaselineFinish,TaskSummaryName,AssignmentActualWork,ProjectId,ResourcePercentage)"
            strSelect = strSelect + " VALUES(" + CStr(rsTest("ResourceUniqueId").Value) + "," + CStr(rsTest("TaskUniqueId").Value) + "," + dtmStartDate + "," + dtmFinishDate + "," + CStr(rsTest("AssignmentWork").Value) + "," + dtmActualStartDate + "," + dtmActualFinishDate + "," + CStr(rsTest("AssignmentBaselineWork").Value) + "," + dtmBaselineStartDate + "," + dtmBaselineFinishDate + ",'" + Trim(Left(CommonFunctions.General.BuildQueryString(Replace(CStr(rsTest("AssignmentTaskSummaryName").Value), vbNullChar, "")) + "", 250)) + "'," + CStr(rsTest("AssignmentActualWork").Value) + "," + Session("intProjectId").ToString + "," + lngResourcePercentage.ToString + ")"

            CommonFunctions.Data.InsertOrUpdateData(strSelect, m_blnUseSQL)
            rsTest.MoveNext()
        Loop

        'Now extract all the data from the RESOURCE TABLE
        strSelect = "Select ResourceUniqueID,ResourceName,ResourcePeakUnits FROM Resources where ResourceName <> ''"
        'drTest = CommonFunctions.Data.GetDataReader(strSelect, False, m_strMSPConnStr)
        rsTest = m_objConnection.Execute(strSelect)

        Do While Not (rsTest.EOF)
            strSelect = "Insert into tbl_MSP_Resource "
            strSelect = strSelect & " (ResourceId,MSPId,ProjectId,ResourcePercentage)"
            strSelect = strSelect & " VALUES(" + CStr(rsTest("ResourceUniqueId").Value) + ",'" + Trim(Left(CommonFunctions.General.BuildQueryString(Replace(CStr(rsTest("ResourceName").Value), vbNullChar, "")) + "", 99)) + "'," + Session("intProjectId").ToString + "," + Replace(CStr(rsTest("ResourcePeakUnits").Value), vbNullChar, "") + ")"

            CommonFunctions.Data.InsertOrUpdateData(strSelect, m_blnUseSQL)
            rsTest.MoveNext()
        Loop

        'Now we have all data present on our SQL server now fire one query which will
        'copy all the data and put it into the Data table
        'Write one SP which will copy all the data from the created new tables and
        'put it in the ProjectTask table
        strSQL = "EXEC usp_MSP_Upload_Operations " + Session("intProjectId").ToString

        '	Response.Write strSQL	
        CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        'CommonFunctions.Data.DisposeDataReader(drTest)

        rsTest = Nothing
        m_objConnection = Nothing

    End Sub

    '=====================================================================
    ' Procedure Name        : funcBuildTaskName
    ' Description           : Builds Tasknamefrom the given successors and predecessorsors
    ' Purpose               : 
    ' Parameters Passed     : Task uniqueID
    ' Returns               : Task Name
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : AmitL
    ' Created               : Friday, 02 March, 2002 14:37 
    ' Revisions             :
    '=====================================================================
    Function funcBuildTaskName(ByVal strTask_UID As String) As String
        'Declarations
        Dim rsTask As New ADODB.Recordset
        Dim rsTaskName As New ADODB.Recordset

        Dim strQuery, strTask_OutlineNum, strTaskName As String
        Dim intIndex, intLength As Integer
        Dim strTaskOutlineNumber As String
        Dim strCurrentTaskName As String
        Dim arrstrTempString() As Char
        funcBuildTaskName = ""

        'Getting info about the particular passed Task
        strQuery = "select TaskOutlineNumber,TaskName,TaskUniqueID from Tasks where TaskUniqueID = " + strTask_UID
        'rsTask = CommonFunctions.Data.GetDataReader(strQuery, False, m_strMSPConnStr)
        rsTask = m_objConnection.Execute(strQuery)

        If (rsTask.EOF And rsTask.BOF) Then
            funcBuildTaskName = ""
            'CommonFunctions.Data.DisposeDataReader(drTask)
            rsTask = Nothing
            Exit Function
        End If

        strTaskOutlineNumber = CStr(rsTask("TaskOutlineNumber").Value)
        strTaskOutlineNumber = Replace(strTaskOutlineNumber, vbNullChar, "").Trim   '--IMP:: to replace vbNullChar

        strTaskOutlineNumber = Left(strTaskOutlineNumber, Len(strTaskOutlineNumber))
        Dim arrLength() As String = Split(strTaskOutlineNumber, ".")

        intLength = UBound(arrLength) + 1

        If intLength > 1 Then

            strTaskName = ""
            strTask_OutlineNum = Replace(arrLength(0), Chr(34), "")
            strQuery = "select Taskname from TASKS where TaskOutlineNumber='" + strTask_OutlineNum + "'"
            'strTaskName = CommonFunctions.Data.GetDataScalar(strQuery, False, m_strMSPConnStr).ToString
            rsTaskName = m_objConnection.Execute(strQuery)

            strTaskName = CStr(rsTaskName("Taskname").Value)
            strTaskName = Replace(strTaskName, vbNullChar, "")
            rsTaskName = Nothing

            'For all the Parents of the passed Task
            For intIndex = 1 To intLength - 1 'Length of hierarchy

                strTask_OutlineNum = strTask_OutlineNum + "." + arrLength(intIndex)
                strQuery = "select Taskname from TASKS where TaskOutlineNumber='" + strTask_OutlineNum + "'"
                'strCurrentTaskName = CommonFunctions.Data.GetDataScalar(strQuery, False, m_strMSPConnStr).ToString
                rsTaskName = m_objConnection.Execute(strQuery)
                strCurrentTaskName = CStr(rsTaskName("Taskname").Value)
                'Appending the names with --> in between

                strTaskName = strTaskName + "-->" + Replace(strCurrentTaskName, vbNullChar, "")
                rsTaskName.Close()
            Next

        Else    ' When Task is at Parent Level
            strTaskName = Replace(CStr(rsTask("TaskName").Value), vbNullChar, "")
        End If

        'Close the recordset for Tasks
        'CommonFunctions.Data.DisposeDataReader(drTask)
        rsTask = Nothing
        rsTaskName = Nothing

        Return strTaskName

    End Function


    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PM_MSPProject", "AppResources")
    End Sub
End Class
