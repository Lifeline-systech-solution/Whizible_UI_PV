Imports CommonFunctions

Public Class PM_ResourceSchedule
    Inherits WebPages.Template.WhizTemplate

    Protected m_strWindowTitle As String
    Protected m_strEmployeeID As String
    Private m_strFromDate As String
    Private m_strToDate As String
    Private m_strEmployeeName As String
    Private WithEvents objGrid As WebPage.Templates.GenericGrid
    Private m_strProjectName As String
    Private m_strResourceName As String
    Protected m_lngQueryID As String
    Protected m_TokenKEY As String
    Protected m_PKToken_FromDT As String = ""
    Protected m_lngEmployeeIDList As String = ""
    Protected m_PKToken As String = ""
    Protected m_FromWhere As String = ""
    ' Added by tejal D Purpose PKToken on 12/8/2016
    Private m_blnValidate As Boolean = True


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
        'm_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")
        'Added by Shamkant S on 18-Jan-2016 to Generate and Validate Token
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("QueryID"), String)
        End If

        If Not Request.QueryString("EmployeeIDList") Is Nothing Then
            m_lngEmployeeIDList = CType(Request.QueryString("EmployeeIDList"), String)
        End If
        If Not Request.QueryString("PKToken") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")
        End If

        If Not Request.QueryString("FromWhere") Is Nothing Then
            '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
            m_FromWhere = Trim(Request.QueryString("FromWhere") & "")
        End If

        ' commented and  Added by tejal D Purpose PKToken on 12/8/2016  
        'If m_PKToken_FromDT = "" And m_lngQueryID <> "0" Then
        ''Added by Nilesh g on 10/11/2016 Purpose :Pktoken issue
        If m_FromWhere = "Issue" Then
            m_blnValidate = True
            ''end of Added by Nilesh g on 10/11/2016 Purpose :Pktoken issue
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("PageType"), "0") = "Schedule" Then
            m_blnValidate = True
        ElseIf m_FromWhere = "Show" Then
            m_blnValidate = True
        ElseIf m_PKToken_FromDT = "" And HttpContext.Current.Session("intUserID") <> 0 Then
            m_blnValidate = False
        ElseIf m_lngQueryID <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromDT) = False) Then
                m_blnValidate = False
            End If


        ElseIf m_lngEmployeeIDList <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngEmployeeIDList, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromDT) = False) Then
                m_blnValidate = False
            End If
        End If
        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        ' End of Addtion tejal D Purpose PKToken on 12/8/2016

        m_PKToken = CommonFunctions.Security.Token.GetToken("0" + CType(Session("intUserID"), String) + "0" + "0")

        'If m_PKToken_FromDT <> "" And m_lngQueryID <> "" Then
        '    If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromDT) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


        '    End If

        'End If *******************************************
        'End of addition by Shamkant S on 18-Jan-2016 to Generate and Validate Token


        '**********************************


        ''Added by Yogesh J on 29-Jan-2016 to Generate and Validate Token
        'If Request.QueryString("PKToken") <> "" And Request.QueryString("EmployeeIDList") <> "" Then
        '    If Request.QueryString("FromDate") IsNot Nothing And Request.QueryString("FromWhere") <> "CRM" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("EmployeeIDList"), String) + CType(Request.QueryString("FromDate"), String) + CType(Request.QueryString("ToDate"), String) + "0" + "0", m_PKToken_FromDT) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "EmployeeIDList ID", CType(Request.QueryString("EmployeeIDList"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

        '        End If
        '    End If
        'End If
        ''End of addition by Yogesh J on 29-Jan-2016 to Generate and Validate Token
    End Sub
    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.PM_ResourceSchedule", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 19 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strToDate As String
        Dim objFromDate As Date
        Dim objToDate As Date

        If Not IsPostBack Then
            m_strEmployeeID = Request.QueryString("EmployeeID") + ""
            If m_strEmployeeID = "" Then
                m_strEmployeeID = Request.QueryString("EmployeeIDList") + ""
            End If
            m_strToDate = Request.QueryString("ToDate") + ""
            m_strFromDate = Request.QueryString("FromDate") + ""
        Else
            m_strFromDate = MyBase.GetFormValue("txtFromDate") + ""
            m_strToDate = MyBase.GetFormValue("txtToDate") + ""
            m_strEmployeeID = MyBase.GetFormValue("txtEmployeeIDList") + ""
        End If

        'FromDate must not be greater than ToDate
        If m_strFromDate <> "" And m_strToDate <> "" Then

            m_strFromDate = Dates.GetDate(CType(m_strFromDate.Trim, Date)).Trim
            m_strToDate = Dates.GetDate(CType(m_strToDate.Trim, Date)).Trim

            objFromDate = Date.Parse(m_strFromDate.Trim)
            objToDate = Date.Parse(m_strToDate.Trim)

            If DateDiff(DateInterval.Day, objFromDate, objToDate) < 0 Then
                m_strFromDate = m_strToDate
            End If
        End If

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('RESOURCE_SCHEDULE')")

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

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")

        'initialize the resource file for HR_EmployeeSelection page.
        MyBase.InitializeResources("AppResources.PM_ResourceSchedule", "AppResources")

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"))
        General.WriteHTML("<BR>")

        ''draw page description
        'objHeader = New WebPage.Templates.HeaderFooter
        'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC") + ""
        'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
        'General.WriteHTML("<BR>")
        'objHeader = Nothing

        'plot the screen with data
        Call plotResourceScheduleScreen()

        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotResourceScheduleScreen
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the controls to show the schedule of resource.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 19 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotResourceScheduleScreen()
        Dim strSQL As String
        Dim objLink As WebPage.UI.cDynamicLink
        Dim blnIsPeriodElapsed As Boolean

        blnIsPeriodElapsed = False
        'Check if the date range selected has already elapsed.
        If m_strToDate <> "" Then
            If DateDiff(DateInterval.Day, Date.Parse(m_strToDate.Trim), Date.Now) > 0 Then
                blnIsPeriodElapsed = True
            End If
        End If

        'plot the date filter textboxes
        General.WriteHTML("<Table class='clsTable' cellspacing=0 cellpadding=0 width=99.9% >")
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD align='left' width=10% nowrap >" + MyBase.GetResourceString("CAP_DATE_RANGE") + "&nbsp;</TD>")
        'display from date control
        General.WriteHTML("<TD align='left' width=20% nowrap >" + MyBase.GetResourceString("CAP_FROM") + "&nbsp;")
        General.WriteHTML(HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromDate.Trim, , "frmResourceSchedule", , , , , , , True))
        General.WriteHTML("</TD>")
        'display to date control
        General.WriteHTML("<TD align='left' width=20% nowrap >" + MyBase.GetResourceString("CAP_TO") + "&nbsp;")
        General.WriteHTML(HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strToDate.Trim, , "frmResourceSchedule", , , , , , , True))
        General.WriteHTML("</TD>")
        'display show link
        objLink = New WebPage.UI.cDynamicLink
        objLink.ReturnHTML = True
        objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        objLink.LinkName = MyBase.GetResourceString("LINK_SHOW") + ""
        objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
        objLink.FunctionName = "Show_OnClick()"
        General.WriteHTML("<TD align='left' nowrap >")
        General.WriteHTML("| <B>" + objLink.GetDynamicLink() + "</B> |")
        General.WriteHTML("</TD>")
        objLink = Nothing
        General.WriteHTML("</TR>")
        'display the note if time is elapsed
        If blnIsPeriodElapsed = True Then
            General.WriteHTML("<TR class='clsTREven'>")
            General.WriteHTML("<TD align='left'><B>" + MyBase.GetResourceString("NOTE") + "</B>")
            General.WriteHTML("<TD align='left' colspan=3 >" + MyBase.GetResourceString("MSG_NOTE") + "")
            General.WriteHTML("</TR>")
        End If
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot the grid for schedule
        strSQL = "usp_Sel_tbl_PM_ResourceSchedule '" + m_strEmployeeID.Trim
        If m_strFromDate <> "" Then
            strSQL += "','" + m_strFromDate.Trim + "'"
        Else
            strSQL += "',Null"
        End If
        If m_strToDate <> "" Then
            strSQL += ",'" + m_strToDate.Trim + "'"
        Else
            strSQL += ",Null"
        End If

        'Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change
        'Dim arrColHeader() As String = {MyBase.GetResourceString("COL_RESOURCE_NAME"), MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_TASK_NAME"), MyBase.GetResourceString("COL_START_DATE"), MyBase.GetResourceString("COL_END_DATE"), MyBase.GetResourceString("COL_WORKHRS"), MyBase.GetResourceString("COL_ACTUAL_WORKHRS")}
        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_RESOURCE_NAME"), MyBase.GetResourceString("COL_PROJECT_NAME"), MyBase.GetResourceString("COL_TASK_NAME"), MyBase.GetResourceString("COL_START_DATE"), MyBase.GetResourceString("COL_END_DATE"), "Work (H:M)", "Actual Work (H:M)"}
        ''End of Commented and Modified By Usha Pandit  on 07-Mar-2019 Purpose::Whizible 2 Work field change

        Dim arrAN() As String = {"EmployeeName", "ProjectName", "TaskName", "StartDate", "EndDate", "Work", "ActualWork"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        objGrid = New WebPage.Templates.GenericGrid
        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.DIVID = "DivList"
        'objGrid.DIVHeight = 400  Commented By Vaijat K ON 07/12/2015
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 7
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "N/A"
        objGrid.SQL = strSQL
        objGrid.UseSQL = MyBase.UseSQL
        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        objGrid.IgnoreHTMLEncode = arrIgnoreHTMLEncode
        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        'plot the grid 
        objGrid.DrawGrid()
        objGrid = Nothing

        'keep data in hidden variables
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtEmployeeIDList", "txtEmployeeIDList", , , , m_strEmployeeID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

    End Sub

    'These two events are used for grouping. Group on EmployeeName and ProjectName is done here.
    'in this event group header is plotted, when new employeename or new project name is found, by
    'inserting new TR for each group
    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
        If m_strResourceName <> Args.DataReader("EmployeeName").ToString.Trim Then
            m_strResourceName = Args.DataReader("EmployeeName").ToString + ""
            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=7>" + Args.DataReader("EmployeeName").ToString + "</TD></TR>"
            m_strProjectName = ""
        End If
        If m_strProjectName <> Args.DataReader("ProjectName").ToString.Trim Then
            m_strProjectName = Args.DataReader("ProjectName").ToString + ""
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left' colspan=6>" + Args.DataReader("ProjectName").ToString + "</TD></TR>"
        End If
    End Sub

    'in this event the EmployeeName and project name columns are plotted blank as employee name and project name 
    'are displayed only once in the group header. Here blank TD is inserted inplace of actual employee name and project name
    'column and original columns are canceled.
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 1 Then
            Args.StringToBeInserted = "<TD align='left'></TD>"
            Cancel = True
        ElseIf Args.ColIndex = 0 Then
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                Args.StringToBeInserted = "<TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TD align='left'></TD>"
            End If
            Cancel = True
        End If
    End Sub

End Class
