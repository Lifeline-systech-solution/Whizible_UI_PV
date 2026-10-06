Imports CommonFunctions
Public Class RT_SelectNewApprover
    Inherits WebPages.Template.WhizTemplate
#Region "Variable Declaration"
    Private CONST_ADD As String = "ADD"
    Private CONST_EDIT As String = "EDIT"
    Protected CONST_ACTION_SAVE As String = "SAVE"

    Protected m_strWindowTitle As String
    Protected m_strMode As String
    Protected m_strAction As String
    Protected m_strAlphabet As String
    Protected m_strDate As String
    Private m_lngProjectID As Long
    Private m_strDepartment As String
    Private m_strLocation As String
    Private m_strDesignation As String
    Private m_blnShowReviewer As Boolean
    Private m_blnShowReviewee As Boolean 'Added by SatyanarayanaA on 19-Jan-2006
    Protected m_strReviewStatisticsID As String
    Private m_strReviewerIDList As String    ' The comma separated list of Reviewer IDs.
    Private m_strRevieweeIDList As String = "" 'Added By SatyanarayanaA 19-Jan-2006
    Private m_strFilter As String
    Private WithEvents objGrid As New WebPage.Templates.GenericGrid
    Protected m_intReviewee As Integer
    Private lngNumberOfRows As Long
    Private m_sortOrder As String
    Private m_SortBy As String
    Private m_lngFirstRow As Integer = 0

#End Region

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

#Region "Page Load functions "
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strWindowTitle = "Select Approver"
    End Sub

    Public Sub PageInit()
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
        ' Created				:	Feb 16 2004
        ' Revisions				:	
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim strSQL As String
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String


        m_lngProjectID = CType(Session("intProjectID"), Long)

        'Modified By VidyaJ - issueID- 11107 for WhizibleSEM SP 8 Regression Issue 
        If Request.QueryString("Alphabet") <> "" Then
            m_strAlphabet = Request.QueryString("Alphabet") + ""

            If m_strAlphabet = "AND" Then
                m_strAlphabet = "&"
            End If
            If m_strAlphabet = "'" Then
                m_strAlphabet = "'" & CommonFunctions.General.BuildQueryString(m_strAlphabet) & "'"
            End If
            If m_strAlphabet = "HASH" Then
                m_strAlphabet = "#"
            End If
            If m_strAlphabet = "PLUS" Then
                m_strAlphabet = "+"
            End If
            ' End Mdification issueID- 11107 for WhizibleSEM SP 8 Regression Issue 
        Else
            m_strAlphabet = "-1"
        End If



        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('Approver Selection')")


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
        If Not Request.QueryString("OrderBy") Is Nothing Then
            m_SortBy = Request.QueryString("OrderBy")
        End If

        If Not Request.QueryString("ASCDESC") Is Nothing Then
            m_sortOrder = Request.QueryString("ASCDESC")
        End If

        strSQL = "usp_sel_tbl_PM_RowWiseExternalApprovers " + m_lngProjectID.ToString + ",1"


        'display the paging links on the menu bar
        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(m_strAlphabet, strSQL, "Select ", "Paging_OnClick", "Resource Name", True)
        objPaging = Nothing

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, strPagingHTML)
        'draw upper menu
        General.WriteHTML(strMenu)
        General.WriteHTML("<BR>")
        'create lower menu without paging
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        WebPage.Templates.PageCaption.GetPageCaptions(, "Select Approver", "<FONT color=blue>Resources marked blue are Project Resources with Project Roles.</FONT>")
        Call plotReviewerList()
        Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTREven'><td align=right>Number Of Records : " + lngNumberOfRows.ToString + "</TD></TR></Table><BR>")
        'plot the lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
    End Sub
#End Region

#Region "Constructor "
    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
#End Region

#Region "Plotting functions"
    Private Sub plotReviewerList()
        '=====================================================================
        ' Procedure Name		:	plotReviewerList
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plot the controls to show list of resources only and reviewer.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SachinR
        ' Created				:	Feb 16 2004
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String
        'Added by PrajaktaR on 21June 2006 for Bristlecone IssueID 4356 - Record Count on the page.
        Dim strCountSQL As String
        'END Of Addition by PrajaktaR on 21June 2006 for Bristlecone IssueID 4356 - Record Count on the page.
        Dim strCurrentEmpIDList As String
        Dim objdr As IDataReader
        Dim objLink As WebPage.UI.cDynamicLink
        Dim strFilter As String

        'Added by MrugajaB on 11th Feb 2006 for multiple reviewees feature Issue ID.1835
        Dim strReviewstatisticsID As String
        'End Addition

        'get the filter string if spacified
        strFilter = MyBase.GetFormValue("txtFilter", False) + ""
        'Modified By VidyaJ - issueID- 11107
        strSQL = "usp_sel_tbl_PM_RowWiseExternalApprovers " + m_lngProjectID.ToString + ",0,'" + m_strAlphabet & "'"
        If m_SortBy Is Nothing Then
            m_SortBy = "Employee Name"
        End If
        strSQL = strSQL + ", '" + m_SortBy + "'"
        If m_sortOrder Is Nothing Then
            m_sortOrder = "ASC"
        End If
        strSQL = strSQL + ", '" + m_sortOrder + "'"
        'Modified By VidyaJ - issueID- 11107
        strCountSQL = "usp_sel_tbl_PM_RowWiseExternalApprovers_Count " + m_lngProjectID.ToString + ",0,'" + m_strAlphabet & "'"

        lngNumberOfRows = CType(CommonFunction.Data.GetDataScalar(strCountSQL, MyBase.UseSQL), Long)

        Dim arrColHeader() As String = {"User Name", "Resource", "Role"}

        Dim arrAN() As String = {"Resource Name", "Employee Name", "RoleDescription"}
        'End Addition

        Dim arrRowLink() As String = {"Employee_OnClick()", "", ""}
        Dim arrCheckBox() As String = {"", "", ""}
        Dim arrCheckBoxCheck() As String = {"", "", ""}
        Dim arrTDStyle() As String = {"align='left'", "align='left'", "align='left'"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'create Grid object and set the properties
        'Added by PrajaktaR on 20th June 2006 for Bristlecone IssueID 4356
        Dim arrGroupOnColumn() As String = {"IsExternal"}
        With objGrid
            'objGrid = New WebPage.Templates.GenericGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .RowLinkArray = arrRowLink
            .CheckBoxIDArray = arrCheckBox
            .CheckboxCheckOnColumnArray = arrCheckBoxCheck
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "EmployeeID"
            .DIVID = "DivList"
            .DIVHeight = 300
            .DIVStyle = "overflow: auto"
            .NoOfDataColumns = 3
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_SortBy
            .SortOrder = m_sortOrder
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            'plot the grid 
            .DrawGrid()
        End With
        'Added by PrajaktaR on 20th June 2006 for Bristlecone IssueID 4356
        objGrid = Nothing

    End Sub
#End Region

#Region "Grid Events"
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name(Event)	:	objGrid_DataRowTD_BeforePrint
        ' Author				:	SantoshK
        ' Created				:	May 18 2006
        '=====================================================================
        If Args.DataField = "Resource Name" Then
            'Project Resource
            'modified by harshada d for whiziblesem sp7 for issue id 4582 project resources are shown in blue
            ' If CType(Args.DataReader("IsExternal"), String) = "Yes" Then
            If CType(Args.DataReader("IsExternal"), String).ToUpper = "PROJECT RESOURCE" Then
                'Commented and Modified By JyotiG
                'Start
                'Issue Id : 6457
                'Args.StringToBeInserted = "<TD  vAlign=top align='left' title='User Name'><A href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + CType(Args.DataReader("Employee Name"), String) + "') ""><FONT color=blue>" + CType(Args.DataFieldValue, String) + "</FONT></A></td>"
                Args.StringToBeInserted = "<TD  vAlign=top align='left' title='User Name'><A href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + Server.HtmlEncode(Replace(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Employee Name"), ""), String), "'", "\'")) + "') ""><FONT color=blue>" + CType(Args.DataFieldValue, String) + "</FONT></A></td>"
                'End
                m_lngFirstRow = 0
            Else
                'Commented and Modified By JyotiG
                'Start
                'Issue Id : 6457
                'Args.StringToBeInserted = "<TD  vAlign=top align='left' title='User Name'><A href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + CType(Args.DataReader("Employee Name"), String) + "') "">" + CType(Args.DataFieldValue, String) + "</A></td>"
                Args.StringToBeInserted = "<TD  vAlign=top align='left' title='User Name'><A href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + Server.HtmlEncode(Replace(CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Employee Name"), ""), String), "'", "\'")) + "') "">" + CType(Args.DataFieldValue, String) + "</A></td>"
                'End
            End If

            Cancel = True
        End If

        'If Args.DataField = "Employee Name" Then
        '    'Project Resource
        '    If CType(Args.DataReader("IsExternal"), String) = "Yes" Then
        '        Args.StringToBeInserted = "<TD  vAlign=top align='left' title='Employee Name'><FONT color=blue>" + CType(Args.DataFieldValue, String) + "</FONT></td>"
        '    Else
        '        Args.StringToBeInserted = "<TD  vAlign=top align='left' title='Employee Name'>" + CType(Args.DataFieldValue, String) + "</td>"
        '    End If
        '    Cancel = True
        'End If

        'If Args.DataField = "RoleDescription" Then
        '    'Project Resource
        '    If CType(Args.DataReader("IsExternal"), String) = "Yes" Then
        '        Args.StringToBeInserted = "<TD  vAlign=top align='left' title='Role'><FONT color=blue>" + CType(Args.DataFieldValue, String) + "</FONT></td>"
        '    Else
        '        Args.StringToBeInserted = "<TD  vAlign=top align='left' title='Role'>" + CType(Args.DataFieldValue, String) + "</td>"
        '    End If
        '    Cancel = True
        'End If
    End Sub
#End Region

    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
        'If CType(Args.DataReader("IsExternal"), String).ToUpper = "NO" Then
        '    If m_lngFirstRow = 0 Then
        '        Args.StringToBeInserted = "<TR><TD title='User Name'>User Name</td><TD title='Resource'>Resource</td><TD vAlign=top align='left' title='Corporate Role'>Corporate Role</td></TR>"
        '        m_lngFirstRow = m_lngFirstRow + 1
        '    End If
        '    'Cancel = True
        'End If
    End Sub
End Class
