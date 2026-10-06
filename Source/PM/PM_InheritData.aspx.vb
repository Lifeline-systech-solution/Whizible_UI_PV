Imports CommonFunctions

Public Class PM_InheritData
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_INHERIT As String = "INHERIT"
    Protected CONST_INHERIT_DETAILS As String = "INHERITDETAILS"
    Protected CONST_ACTION_SAVE As String = "SAVE"

    Protected m_lngDestinationProjectID As Long
    Protected m_lngSourceProjectID As Long
    Protected m_strMode As String
    Protected m_strAlphabet As String
    Protected m_strAction As String
    Protected m_strWindowTitle As String

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

        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_INHERIT") + ""
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_InheritData", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 31 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objPaging As WebPage.Templates.Paging
        Dim strProjectName As String
        Dim strPagingHTML As String

        'get the values form the query string
        m_strMode = Request.QueryString("Mode") + ""
        m_strAction = Request.QueryString("Action") + ""
        m_strAlphabet = Request.QueryString("Alphabet") + ""
        If m_strAlphabet = "" Then m_strAlphabet = "-1"
        m_lngDestinationProjectID = CType(Session("intProjectId"), Long)
        If Request.QueryString("ProjectID") <> "" Then
            m_lngSourceProjectID = CType(Request.QueryString("ProjectID"), Long)
        End If

        ''Added by Yogesh Jalamkar  on 02 AUG 2016 to validate Token

        If Request.QueryString("ProjectID") IsNot Nothing And Request.QueryString("PK_TokenInherit") IsNot Nothing Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PK_TokenInherit")) = False) Then
                ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_YearValue, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        '  End of addition Yogesh Jalamkar  on 02 AUG 2016 to validate Token
        ''TODO : hardcoded for testing
        'm_lngDestinationProjectID = 268

        If m_strMode = "" Then m_strMode = CONST_INHERIT

        Select Case m_strMode

            Case CONST_INHERIT

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('HLP_INHRT')")

                'copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.PM_InheritData", "AppResources")

                'display the paging links on the menu bar
                objPaging = New WebPage.Templates.Paging
                strSQL = "usp_Sel_ListOfProjects_ProjectGroup_ProjectType_PagingAlphabet " + m_lngDestinationProjectID.ToString
                strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQL, MyBase.GetResourceString("PAGING_SELECT"), "Paging_OnClick", "ProjectName", True)
                objPaging = Nothing

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")
                'create lower menu without paging links 
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_INHERIT"))
                General.WriteHTML("<BR>")

                'draw page description
                objHeader = New WebPage.Templates.HeaderFooter
                ' Modified on 21 st October  By Nitin V S.
                ' To Remove Duplicate Page Captions
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_INHERIT") + ""
                objHeader.HeaderFooter = "      "
                General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                General.WriteHTML("<BR>")
                objHeader = Nothing

                'plot the grid for project list
                Call plotGridForProjects(m_lngDestinationProjectID, m_strAlphabet)


            Case CONST_INHERIT_DETAILS

                If m_strAction.ToUpper = CONST_ACTION_SAVE Then
                    Call performInheritDetailsAction()
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_INHERIT")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_INHERIT_TOOLTIP")) : arrClientSideFunctions.Add("InheritSave_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('HLP_INHRT')")

                'copy all the elements to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for SDLC_Process page.
                MyBase.InitializeResources("AppResources.PM_InheritData", "AppResources")

                'get the project name and display
                strProjectName = ""
                strSQL = "usp_sel_tbl_pm_project " + m_lngSourceProjectID.ToString
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    If Not IsDBNull(objDR("ProjectName")) Then
                        strProjectName = objDR("ProjectName").ToString + ""
                    End If
                End If
                objDR.Close()
                objDR.Dispose()
                objDR = Nothing

                'draw page caption with entity name
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_INHERIT_DATA") + " : " + strProjectName.Trim)
                General.WriteHTML("<BR>")

                'draw page description
                objHeader = New WebPage.Templates.HeaderFooter
                objHeader.HeaderFooter = Mid(MyBase.GetResourceString("PAGE_DESC_INHERIT_DATA"), 1) + ""
                General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                General.WriteHTML("<BR>")
                objHeader = Nothing

                'plot the grid for project list
                Call plotScreenForProjectDetails(m_lngDestinationProjectID, m_lngSourceProjectID)

            Case Else
        End Select

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotGridForProjects
    ' Parameters Passed		:	lngProjectID - long  
    '                           strAlphabet - string
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid for the list of projects
    ' Description			:	This procedure will plot the grid of list of projects excluding the one
    '                           whose project id is passed as parameter.This will show the list with paging
    '                           for the alphabet passed.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 31 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotGridForProjects(ByVal lngProjectID As Long, ByVal strAlphabet As String)
        Dim strSql As String
        Dim objGrid As WebPage.Templates.GenericGrid

        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_INHERIT")}
        Dim arrAN() As String = {"ProjectName", MyBase.GetResourceString("COL_INHERIT_LINK")}
        Dim arrRowLink() As String = {"", "Inherit_Onclick(ProjectID)"}

        ' Modified on 21 st October 2004 for aligning the Column Caption and data.
        'Dim arrTDStyle() As String = {"align='left'", "align='Center'"}
        Dim arrTDStyle() As String = {"align='left'", "align='Left'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'create the SP for grid data without sorting but with paging
        strSql = "usp_Sel_ListOfProjects_ProjectGroup_ProjectType " + lngProjectID.ToString + ",'" + strAlphabet.Trim + "'"

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid

        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.RowLinkArray = arrRowLink
        objGrid.TDStyleArray = arrTDStyle
        'objGrid.PrimaryKey = "ProjectID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 400
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 1
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        objGrid.SQL = strSql
        objGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForProjectDetails
    ' Parameters Passed		:	lngDestinationProjectID - long  
    '                           lngSourceProjectID  - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the screen for the details of the project selected.
    ' Description			:	This procedure will plot the screen of list of project details which
    '                           can be inherited to another project(Destination Project)
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 1 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForProjectDetails(ByVal lngDestinationProjectID As Long, ByVal lngSourceProjectID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim blnAllowIssueMaster As Boolean
        Dim blnCustomerContacts As Boolean
        Dim blnAllowPhases As Boolean
        'Added By Jayavant On 18-Oct-2004   --Issues ID = 13420
        Dim blnAllowResources As Boolean = False
        'End Addition

        strSQL = "usp_Sel_CheckPermissions_InheritData " + lngDestinationProjectID.ToString + "," + lngSourceProjectID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            If Not IsDBNull(objDR("AllowPhases")) Then
                blnAllowPhases = CType(objDR("AllowPhases"), Boolean)
            Else
                blnAllowPhases = False
            End If
            If Not IsDBNull(objDR("AllowCustomerContacts")) Then
                blnCustomerContacts = CType(objDR("AllowCustomerContacts"), Boolean)
            Else
                blnCustomerContacts = False
            End If
            If Not IsDBNull(objDR("AllowIssueMasters")) Then
                blnAllowIssueMaster = CType(objDR("AllowIssueMasters"), Boolean)
            Else
                blnAllowIssueMaster = False
            End If
            'Added By Jayavant On 18-Oct-2004   --Issues ID = 13420
            blnAllowResources = CType(CommonFunctions.Data.CheckIsDBNull(objDR("AllowResources"), "False"), Boolean)
            'End Addition
        Else
            blnAllowPhases = False
            blnCustomerContacts = False
            blnAllowIssueMaster = False
        End If
        objDR.Close()
        objDR.Dispose()
        objDR = Nothing

        '**************************************************************************************************
        General.WriteHTML("<Div id='DivList' width=100% style='Overflow: auto;' >")
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0>")

        'display the col headers
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("COL_ITEMS") + "</TD>")
        General.WriteHTML("<TD align='middle'>" + MyBase.GetResourceString("COL_INHERIT") + "</TD>")
        General.WriteHTML("</TR>")

        'project Phases
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_PROJECT_PHASES") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkProjectPhases", "chkProjectPhases", , blnAllowPhases, "1", (Not blnAllowPhases), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Managerial Process
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_MANAGERIAL_PROCESS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkManagerialProcess", "chkManagerialProcess", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Resources
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_RESOURCES") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkResources", "chkResources", , blnAllowResources, "1", (Not blnAllowResources), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Tools
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_TOOLS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkTools", "chkTools", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Hardware
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_HARDWARE") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkHardware", "chkHardware", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Quantitative objective
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_QUANTITATIVE_OBJ") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkQuantitativeObj", "chkQuantitativeObj", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'SDLC Process
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_SDLC_PROCESS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkSDLCProcess", "chkSDLCProcess", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'SCM PLan
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_SCM_PLAN") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkSCMPlan", "chkSCMPlan", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Training PLan
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_TRAINING_PLAN") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkTrainingPlan", "chkTrainingPlan", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Project Risks
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_PROJECT_RISK") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkProjectRisk", "chkProjectRisk", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'customer contacts
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_CUSTOMER_CONTACTS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkCustomerContacts", "chkCustomerContacts", , blnCustomerContacts, "1", (Not blnCustomerContacts), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Modules
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_MODULES") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkModules", "chkModules", , True, "1", , , True) + "</TD>")
        General.WriteHTML("</TR>")

        '************** Issue Master ***************
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD colspan=2>" + MyBase.GetResourceString("CAP_ISSUE_MASTER") + "</TD>")
        General.WriteHTML("</TR>")

        'Keywords
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_KEYWORDS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkKeywords", "chkKeywords", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Priorities
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_PRIORITIES") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkPriorities", "chkPriorities", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Kernels
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_KERNELS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkKernels", "chkKernels", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'OS
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_OS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkOS", "chkOS", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'severity
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_SEVERITY") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkSeverity", "chkSeverity", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Version
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_VERSION") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkVersion", "chkVersion", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Types
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_TYPES") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkTypes", "chkTypes", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        'Custom fields
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD width=80%>" + MyBase.GetResourceString("CAP_CUSTOM_FIELDS") + "</TD>")
        General.WriteHTML("<TD align='middle'>")
        General.WriteHTML(HTMLControls.DrawCheckBox("chkCustomFields", "chkCustomFields", , blnAllowIssueMaster, "1", (Not blnAllowIssueMaster), , True) + "</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</Div>")

    End Sub

    '=====================================================================
    ' Procedure Name		:	performInheritDetailsAction
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database for inheriting the data from the sourceproject to destination project.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 1 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performInheritDetailsAction()
        Dim strSQL As String
        '**************************************
        Dim strProjectPhase As String = "NULL"
        Dim strManagerialProcess As String = "NULL"
        Dim strResources As String = "NULL"
        Dim strTools As String = "NULL"
        Dim strHardware As String = "NULL"
        Dim strQuantitativeObj As String = "NULL"
        Dim strSDLCProcess As String = "NULL"
        Dim strSCMPlan As String = "NULL"
        Dim strTrainingPlan As String = "NULL"
        Dim strProjectRisk As String = "NULL"
        Dim strCustomerContacts As String = "NULL"
        Dim strModules As String = "0"
        Dim strKeywords As String = "0"
        Dim strPriorities As String = "0"
        Dim strKernels As String = "0"
        Dim strOS As String = "0"
        Dim strSeverity As String = "0"
        Dim strVersion As String = "0"
        Dim strTypes As String = "0"
        Dim strCustomFields As String = "0"
        '**************************************

        'get the data from the checkboxes
        If MyBase.GetFormValue("chkProjectPhases") <> "" Then
            strProjectPhase = MyBase.GetFormValue("chkProjectPhases") + ""
        End If
        If MyBase.GetFormValue("chkManagerialProcess") <> "" Then
            strManagerialProcess = MyBase.GetFormValue("chkManagerialProcess") + ""
        End If
        If MyBase.GetFormValue("chkResources") <> "" Then
            strResources = MyBase.GetFormValue("chkResources") + ""
        End If
        If MyBase.GetFormValue("chkTools") <> "" Then
            strTools = MyBase.GetFormValue("chkTools") + ""
        End If
        If MyBase.GetFormValue("chkHardware") <> "" Then
            strHardware = MyBase.GetFormValue("chkHardware") + ""
        End If
        If MyBase.GetFormValue("chkQuantitativeObj") <> "" Then
            strQuantitativeObj = MyBase.GetFormValue("chkQuantitativeObj") + ""
        End If
        If MyBase.GetFormValue("chkSDLCProcess") <> "" Then
            strSDLCProcess = MyBase.GetFormValue("chkSDLCProcess") + ""
        End If
        If MyBase.GetFormValue("chkSCMPlan") <> "" Then
            strSCMPlan = MyBase.GetFormValue("chkSCMPlan") + ""
        End If
        If MyBase.GetFormValue("chkTrainingPlan") <> "" Then
            strTrainingPlan = MyBase.GetFormValue("chkTrainingPlan") + ""
        End If
        If MyBase.GetFormValue("chkProjectRisk") <> "" Then
            strProjectRisk = MyBase.GetFormValue("chkProjectRisk") + ""
        End If
        If MyBase.GetFormValue("chkCustomerContacts") <> "" Then
            strCustomerContacts = MyBase.GetFormValue("chkCustomerContacts") + ""
        End If
        If MyBase.GetFormValue("chkModules") <> "" Then
            strModules = MyBase.GetFormValue("chkModules") + ""
        End If
        If MyBase.GetFormValue("chkKeywords") <> "" Then
            strKeywords = MyBase.GetFormValue("chkKeywords") + ""
        End If
        If MyBase.GetFormValue("chkPriorities") <> "" Then
            strPriorities = MyBase.GetFormValue("chkPriorities") + ""
        End If
        If MyBase.GetFormValue("chkKernels") <> "" Then
            strKernels = MyBase.GetFormValue("chkKernels") + ""
        End If
        If MyBase.GetFormValue("chkOS") <> "" Then
            strOS = MyBase.GetFormValue("chkOS") + ""
        End If
        If MyBase.GetFormValue("chkSeverity") <> "" Then
            strSeverity = MyBase.GetFormValue("chkSeverity") + ""
        End If
        If MyBase.GetFormValue("chkVersion") <> "" Then
            strVersion = MyBase.GetFormValue("chkVersion") + ""
        End If
        If MyBase.GetFormValue("chkTypes") <> "" Then
            strTypes = MyBase.GetFormValue("chkTypes") + ""
        End If
        If MyBase.GetFormValue("chkCustomFields") <> "" Then
            strCustomFields = MyBase.GetFormValue("chkCustomFields") + ""
        End If

        'careate the SQL by appending the parameters to the SP to update the database
        strSQL = "usp_Ins_InheritData " + m_lngDestinationProjectID.ToString + "," + m_lngSourceProjectID.ToString
        strSQL += "," + strProjectPhase.Trim
        strSQL += "," + strManagerialProcess.Trim
        strSQL += "," + strResources.Trim
        strSQL += "," + strTools.Trim
        strSQL += "," + strHardware.Trim
        strSQL += "," + strQuantitativeObj.Trim
        strSQL += "," + strSDLCProcess.Trim
        strSQL += "," + strSCMPlan.Trim
        strSQL += "," + strTrainingPlan.Trim
        strSQL += "," + strProjectRisk.Trim
        strSQL += "," + strCustomerContacts.Trim
        strSQL += "," + strKeywords.Trim
        strSQL += "," + strPriorities.Trim
        strSQL += "," + strKernels.Trim
        strSQL += "," + strOS.Trim
        strSQL += "," + strSeverity.Trim
        strSQL += "," + strVersion.Trim
        strSQL += "," + strTypes.Trim
        strSQL += "," + strCustomFields.Trim
        strSQL += "," + strModules.Trim

        'execute the SQL
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

    End Sub
    ''Added by Yogesh J on 01-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_InheritOnclick(EmployeeID As String, ProjectId As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(ProjectId, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 01-Feb-2016
End Class
