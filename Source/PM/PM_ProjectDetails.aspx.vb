Imports CommonFunctions

Public Class PM_ProjectDetails
    Inherits WebPages.Template.WhizTemplate

    Private CONST_MODE_PROJECT As String = "ProjectDetails"

    Protected m_strMode As String
    Protected m_strFromWhere As String
    Protected m_strAction As String
    Protected m_strAlphabet As String
    Protected m_strWindowTitle As String
    Private m_strEmployeeID As String
    Private m_strEmployeeName As String
    Private m_blnShowPreviousProjects As Boolean
    Private m_blnShowOnGoingProjects As Boolean
    Private WithEvents m_objPreviousProjectGrid As WebPage.Templates.GenericGrid
    Private m_strCurrentProjectID As String
    Protected WithEvents frmProjectDetails As System.Web.UI.HtmlControls.HtmlForm
    Private m_intSubRowRecordCount As Integer
    Protected m_ExpectedStartDate As String
    Protected m_ExpectedEndDate As String
    Protected m_strFlag As String

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
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")
    End Sub
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.PM_ProjectDetails", "AppResources")
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
    ' Created				:	Feb 24 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim strMenu As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strHelpID As String
        'Added By JayavantK on 18-Oct-2004 ---Issue ID = 11433
        Dim strRightCaption As String = ""
        'End Addition

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_MODE_PROJECT
        m_strFromWhere = Request.QueryString("FromWhere") + ""
        m_strAction = Request.QueryString("Action") + ""
        m_strEmployeeID = Request.QueryString("EmployeeID") + ""

        m_ExpectedStartDate = Request.QueryString("ExpectedStartDate") + ""
        m_ExpectedEndDate = Request.QueryString("ExpectedEndDate") + ""

        m_strFlag = Request.QueryString("strFlag") + ""

        If Request.QueryString("ShowOnGoing") = "1" Then
            m_blnShowOnGoingProjects = True
        Else
            m_blnShowOnGoingProjects = False
        End If
        If Request.QueryString("ShowPrevious") = "1" Then
            m_blnShowPreviousProjects = True
        Else
            m_blnShowPreviousProjects = False
        End If

        ''TODO: get from the querystring
        'm_strEmployeeID = "61"
        'm_blnShowOnGoingProjects = True
        'm_blnShowPreviousProjects = True

        If m_blnShowOnGoingProjects And Not m_blnShowPreviousProjects Then strHelpID = "SKILLS_CURRENT_PROJECTS"
        If m_blnShowOnGoingProjects And m_blnShowPreviousProjects Then strHelpID = "SKILLS_ALL_PROJECTS"

        Select Case m_strMode
            Case CONST_MODE_PROJECT

                'initialize the resource file for standard menu and create menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                Dim arrstrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrstrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrstrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('" + strHelpID.Trim + "')"}

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'get the name of the employee
                strSQL = "usp_Sel_tbl_PM_Employee " + m_strEmployeeID.Trim
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    m_strEmployeeName = Data.CheckIsDBNull(objDR("UserName"), "").ToString
                End If
                Data.DisposeDataReader(objDR)

                'initialize the resource file for PM_ProjectDetails page.
                MyBase.InitializeResources("AppResources.PM_ProjectDetails", "AppResources")

                'Added By JayavantK on 18-Oct-2004 ---Issue ID = 11433
                If m_strEmployeeName <> "" Then
                    strRightCaption = MyBase.GetResourceString("PAGE_RIGHT_CAPTION") + " : "
                    strRightCaption = strRightCaption + m_strEmployeeName
                End If
                'End Addition

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), strRightCaption)
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the grid for project list
                General.WriteHTML("<div id='DivList' width=100% Style='Overflow: auto'>")
                Call plotProjectListGrid()
                General.WriteHTML("</Div>")

                'draw lower menu
                General.WriteHTML("<BR>")
                General.WriteHTML(strMenu)
            Case Else
        End Select

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotProjectListGrid
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid of the project details for the given employee id 
    ' Description			:	same as above.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 25 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotProjectListGrid()
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim strSql As String

        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_ROLE"), MyBase.GetResourceString("COL_START_DATE"), MyBase.GetResourceString("COL_END_DATE"), MyBase.GetResourceString("COL_RESOURCE")}     ', MyBase.GetResourceString("COL_PROJECT_MANAGER")}
        Dim arrAN() As String = {"ProjectName", "RoleDescription", "ExpectedStartDate", "ExpectedEndDate", "ResourcePercentage"}    ', "ProjectManager"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''  Added By Vidya Jadhav ON 8 Aug 2017 For Bulk Allocation Changes: To get Employee Project Details in given time period
        If m_strFlag.ToUpper = "BULKALLOCATION" Then

            strSql = "usp_Sel_GetProjectEmployee_Details " + m_strEmployeeID.Trim + ",1,'" & m_ExpectedStartDate & "','" & m_ExpectedEndDate & "'"
        Else
            strSql = "usp_Sel_GetProjectEmployeeDetails " + m_strEmployeeID.Trim + ",1"
        End If
        ''End Of Added By Vidya Jadhav ON 8 Aug 2017 For Bulk Allocation Changes: To get Employee Project Details in given time period

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.DIVID = "DivList1"
        objGrid.DIVHeight = 200
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 5
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"
        'Commented By JayavantK on 18-Oct-2004 ---Issue ID = 11433
        'objGrid.HeaderHTML = "<Table width=100% class='clsTable'><TR class='clsTREven'><TD width=100%><B>" + MyBase.GetResourceString("CAP_CURRENT_PROJECT") + "</B></TD></TR></Table>"
        'End Comments
        objGrid.SQL = strSql
        objGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing

        If m_blnShowPreviousProjects = True Then

            Dim arrColHeader1() As String = {MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_ROLE"), MyBase.GetResourceString("COL_ACTUAL_START_DATE"), MyBase.GetResourceString("COL_ACTUAL_END_DATE")}    ', MyBase.GetResourceString("COL_PROJECT_MANAGER")}
            Dim arrAN1() As String = {"ProjectName", "RoleDescription", "ActualStartDate", "ActualEndDate"}  ', "ProjectManager"}

            strSql = "usp_Sel_GetProjectEmployeeDetails " + m_strEmployeeID.Trim + ",NULL,1"

            'create Grid object and set the properties
            m_objPreviousProjectGrid = New WebPage.Templates.GenericGrid
            With m_objPreviousProjectGrid
                .ActualColumnArray = arrAN1
                .UserFriendlyColumnArray = arrColHeader1
                .DIVID = "DivList2"
                .DIVHeight = 200
                .DIVStyle = "overflow: auto"
                .NoOfDataColumns = 4
                .PrinterFriendlyVersion = False
                .VerticalDisplay = False
                .ColNameToolTipOnEachRow = True
                .returnHTML = False
                .EmptyValueReplacement = "-"
                .HeaderHTML = "<Table width=99.9% class='clsTable'><TR class='clsTREven'><TD width=100%><B>" + MyBase.GetResourceString("CAP_CLOSED_PROJECT") + "</B></TD></TR></Table>"
                .SQL = strSql
                .UseSQL = MyBase.UseSQL
                m_intSubRowRecordCount = 0
                m_strCurrentProjectID = ""
                'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                'plot the grid 
                .DrawGrid()
            End With
            m_objPreviousProjectGrid = Nothing

        End If
    End Sub

    'In this event record count for the subgrid for next row is calculated. Subgrid is 
    'is plotted in the TR inserted which is kept hidden default and make visible at client side.
    Private Sub m_objPreviousProejctGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objPreviousProjectGrid.DataRowTR_BeforePrint
        Dim strSQL As String
        Dim objDr As IDataReader

        m_strCurrentProjectID = Data.CheckIsDBNull(Args.DataReader("ProjectID"), "").ToString

        strSQL = "usp_Sel_tbl_PM_EmployeeSkillMatrix_detail " + m_strCurrentProjectID.Trim + "," + m_strEmployeeID.Trim
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        m_intSubRowRecordCount = 0
        While objDr.Read
            m_intSubRowRecordCount += 1
        End While
        Data.DisposeDataReader(objDr)

    End Sub

    Private Sub m_objPreviousProejctGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objPreviousProjectGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex = 0 Then
            Args.ColumnName = ""
        End If
    End Sub

    'Here in this event the link to expand or collapse the subgrid is plotted in the first col.
    Private Sub m_objPreviousProjectGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objPreviousProjectGrid.DataRowTD_BeforePrint
        Dim strTRClass As String

        If Args.ColIndex = 0 Then
            If Args.NoOfRowsPrinted Mod 2 = 0 Then strTRClass = "'clsTROdd'" Else strTRClass = "'clsTREven'"

            If m_intSubRowRecordCount > 0 Then
                Args.StringToBeInserted = "<TR class=" + strTRClass.Trim + " ><TD align='center' ><A href='javascript:ExpandCollapse_Onclick(" + m_strCurrentProjectID.Trim + ")' style='TEXT-DECORATION: none'>" + HTMLControls.DrawImage("..\..\Images\plus.gif", "Img" + m_strCurrentProjectID.Trim, , , , , , True) + "</A></TD>"
            Else
                Args.StringToBeInserted = "<TR class=" + strTRClass.Trim + " ><TD align='center' >-</TD>"
            End If
            Cancel = True
        End If
    End Sub

    Private Sub m_objPreviousProjectGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objPreviousProjectGrid.DataRowTR_AfterPrint
        Dim objGrid As WebPage.Templates.GenericGrid
        Dim strSQL As String

        m_strCurrentProjectID = Data.CheckIsDBNull(Args.DataReader("ProjectID"), "").ToString

        If m_intSubRowRecordCount > 0 Then

            Dim arrColHeader() As String = {MyBase.GetResourceString("COL_SKILLS"), MyBase.GetResourceString("COL_YEARS"), MyBase.GetResourceString("COL_MONTHS")}
            Dim arrAN() As String = {"Description", "YearsOfExperience", "MonthsOfExperience"}
            Dim arrIgnoreHTMLEncode() As String = {"0"}

            strSQL = "usp_Sel_tbl_PM_EmployeeSkillMatrix_detail " + m_strCurrentProjectID.Trim + "," + m_strEmployeeID.Trim

            'create Grid object and set the properties
            objGrid = New WebPage.Templates.GenericGrid
            objGrid.ActualColumnArray = arrAN
            objGrid.UserFriendlyColumnArray = arrColHeader
            objGrid.DIVID = "DivSubGrid"
            objGrid.DIVHeight = 100
            objGrid.DIVStyle = "overflow: auto"
            objGrid.NoOfDataColumns = 3
            objGrid.PrinterFriendlyVersion = False
            objGrid.VerticalDisplay = False
            objGrid.ColNameToolTipOnEachRow = True
            objGrid.returnHTML = True
            objGrid.EmptyValueReplacement = "-"
            objGrid.HeaderHTML = "<Table width=99.9% class='clsTable'><TR class='clsTREven'><TD width=100%><B>" + MyBase.GetResourceString("CAP_EXPERIENCED") + "</B></TD></TR></Table>"
            objGrid.SQL = strSQL
            objGrid.UseSQL = MyBase.UseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'plot the sub grid 
            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' id='TR" + m_strCurrentProjectID.Trim + "' Style='Display: none;' ><TD></TD><TD colspan=4>"
            Args.StringToBeInserted += objGrid.DrawGrid()
            Args.StringToBeInserted += "</TD></TR>"
            objGrid = Nothing
        End If
    End Sub

End Class
