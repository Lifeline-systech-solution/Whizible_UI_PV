Option Explicit On
Imports Whizible
Imports CommonFunctions
Imports WebPages.Template
Public Class LinkMetrics
    Inherits WebPage.Templates.WhizTemplate
#Region "Variable Declaration"
    Private ObjSectionTitle As WebPage.Templates.SectionTitle
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private strPageAlphabets As String = ""
    Protected m_strPageNumber As String = ""
    Private m_strDateFrom As String = ""
    Private m_strDateTo As String = ""
    Private m_strSnapShotDate As String = ""
    Protected m_strShow As String = ""
    Private WithEvents m_objstageGrid As New WebPages.Template.GenericGrid
    Protected m_strDivScrollHeight As String = ""
    Public Const PAGE_CAPTION As String = "Link Metrics"
    Public Const MSG_NO_RECORDS = "There are no items to show in this view."
    Public Const TAB_NAME_Practice = "Practice"
    Public Const TAB_NAME_Customer = "Customer"
    Protected m_strHeaderTables As New System.Text.StringBuilder
    Protected m_strPT As String
    Public strSelectedTitle As String = ""
    Private m_strSortBy As String = ""
    Private m_strOrderBy As String = ""

    Public Enum SelectedTab
        Practice
        Customer
    End Enum
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

        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
    End Sub

    Public Sub BuildPage()
        '=====================================================================
        ' function Name         : BuildPage()	
        ' Purpose               : To build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Dec 12, 2005
        ' Revisions             :
        '=====================================================================

        GetInitialData()
        DrawPage()
    End Sub

    Private Sub GetInitialData()
        '=====================================================================
        ' function Name         : GetInitialData()	
        ' Purpose               : To get All initialization values
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Dec 12, 2005
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim dr As IDataReader
        'Commented and added by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query
        ' strQuery = "SELECT TOP 1 MAX(FromDate) AS 'FromDate', MAX(ToDate) AS 'ToDate' , MAX(SnapShotDate) AS 'SnapShotDate' FROM Tbl_PRS_MetricHistory_BreakUp"
        strQuery = "usp_sel_Tbl_PRS_MetricHistory_BreakUp"
        'End of addition by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query

        dr = CommonFunctions.Data.GetDataReader(strQuery, True)
        Do While dr.Read
            m_strDateFrom = CommonFunctions.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(dr("FromDate"), CommonFunctions.Dates.GetDate(Now())))
            m_strDateTo = CommonFunctions.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(dr("ToDate"), CommonFunctions.Dates.GetDate(Now())))
            m_strSnapShotDate = CommonFunctions.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(dr("SnapShotdate"), CommonFunctions.Dates.GetDate(Now())))
        Loop
        dr.Dispose()
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Show"), "") <> "" Then
            m_strShow = Request.QueryString("Show")
        End If

        m_strDivScrollHeight = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("hdnDivScrollHeight"), "0")

        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PType"), "") <> "" Then
            m_strPT = CType(HttpContext.Current.Request.QueryString("PType"), String)
        ElseIf CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboPT"), "") <> "" Then
            m_strPT = CType(MyBase.GetFormValue("cboPT"), String)
        Else
            m_strPT = ""
        End If

        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request("PageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If

    End Sub
    Private Sub DrawPage()
        If UCase(m_strShow) = UCase("Customer") Or m_strShow = "" Then
            DrawMenu(True, 2)
            CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Customer))
            drawCustomerGrid()
        End If
        If UCase(m_strShow) = UCase("Practice") Then
            DrawMenu(True, 1)
            CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Practice))
            drawPracticeGrid()
        End If
        General.WriteHTML("</DIV>")                     'End of divPage
        CommonFunctions.General.WriteHTML(m_strHeaderTables.ToString)
    End Sub

    Public Sub drawCustomerGrid()
        Dim txtSQLQuery As New System.Text.StringBuilder
        m_objstageGrid = New WebPages.Template.GenericGrid()
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left width='70%'", "align=center width='20%'"}
        Dim arrColRowLinks() As String = {"LinkMetric_OnClick(Customer,MappingEntityID)"}
        txtSQLQuery.Append("usp_Sel_tbl_MET_Metircs_Mapping 2,'" + m_strPageNumber + "'")
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing
        arrColumnHeadingList.Add("Customer")
        arrColumnHeadingList.Add("Mapped Metrics")
        arrActualColumnNames.Add("CustomerName")
        arrActualColumnNames.Add("MetricCount")
        If Not Request.QueryString("sortby") Is Nothing Then
            m_strSortBy = Request.QueryString("sortby")
        Else
            m_strSortBy = "CustomerName"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            m_strOrderBy = Request.QueryString("sortorder")
        Else
            m_strOrderBy = "ASC"
        End If
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        With m_objstageGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            '.CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Count
            .PrimaryKey = "Customer"
            .ClientSideSortFunctionName = "Sort_OnClick"
            .TDStyleArray = arrWidthArray
            .RowLinkArray = arrColRowLinks
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .SortBy = m_strSortBy
            .SortOrder = m_strOrderBy
            .DIVHeight = 450
            '.DIVStyle = "overflow:auto"
            'Commented Ande Added By Vaijat K On 21/10/2015
            .DIVStyle = "overflow:auto;position:relative;"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015
            .DrawGrid()
        End With
        m_objstageGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        arrColRowLinks = Nothing
    End Sub

    Public Sub drawPracticeGrid()
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left width='70%'", "align=center width='20%'"}
        Dim arrColRowLinks() As String = {"LinkMetric_OnClick(TypeID,MappingEntityID)", ""}
        txtSQLQuery.Append("usp_Sel_tbl_MET_Metircs_Mapping 1,'" + m_strPageNumber + "'")
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing
        arrColumnHeadingList.Add("Practice")
        arrColumnHeadingList.Add("Mapped Metrics")
        arrActualColumnNames.Add("ProjectType")
        arrActualColumnNames.Add("MetricCount")

        If Not Request.QueryString("sortby") Is Nothing Then
            m_strSortBy = Request.QueryString("sortby")
        Else
            m_strSortBy = "ProjectType"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            m_strOrderBy = Request.QueryString("sortorder")
        Else
            m_strOrderBy = "ASC"
        End If
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015

        m_objstageGrid = New WebPages.Template.GenericGrid()
        With m_objstageGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            '.CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Count
            .PrimaryKey = "TypeID"
            .TDStyleArray = arrWidthArray
            .ClientSideSortFunctionName = "Sort_OnClick"
            .RowLinkArray = arrColRowLinks
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 450
            .DIVStyle = "overflow:auto"
            .SortBy = m_strSortBy '"ProjectType"
            .SortOrder = m_strOrderBy
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015
            .DrawGrid()
        End With

        m_objstageGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        arrColRowLinks = Nothing
    End Sub

    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True, Optional ByVal intMappingID As Integer = 0)
        Dim m_SQLSB As System.Text.StringBuilder
        Dim m_strSQL As String
        If intMappingID = 2 Then
            m_strSQL = "usp_Sel_tbl_MET_Metircs_Mapping_Paging 2"
            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, "Select", , "Alphabet", True)
        ElseIf intMappingID = 1 Then
            m_strSQL = "usp_Sel_tbl_MET_Metircs_Mapping_Paging 1"
            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, "Select", , "Alphabet", True)
        End If

        Dim arrCMenu() As String = {"Help"}
        Dim arrCMenuToolTip() As String = {"Help"}
        ''Commented And Added By Vaijat K On 21/10/2015
        ''Dim arrCClientSideFunctions() As String = {""}
        Dim arrCClientSideFunctions() As String = {"OpenHelpPage(8070)"}

        If strPageAlphabets = "" Then m_strPageNumber = "-1"
        Dim strmenu As String = ""
        m_objMenu = New WebPages.Template.StaticMenu
        If blnShowPaging Then
            strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True, strPageAlphabets)
        Else
            strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True)
        End If

        CommonFunctions.General.WriteHTML(strmenu)

        m_objMenu = Nothing
        ''''''''''
        CommonFunctions.General.WriteHTML("<BR><TABLE id='tblCap054'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Link Metrics</TD></TR></TABLE><BR>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblCap054'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR><TD align=Left><font color='red'>This UI provides facility to map metrics to customer and process entities. Metrics selected here will be inherited on project depending on project’s customer and practice.</font></TD></TR></TABLE><BR>")

    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

    Private Sub DrawHeader(ByVal arrlst As ArrayList, ByVal intFor As Integer)
        Dim intCounter As Integer = 0
        m_strHeaderTables.Append("<TABLE id='tblH" & CType(intFor, String) & "' class='clsGridTable' width='100%' cellspacing=1 border=0 style='display:none;height:0px;TABLE-LAYOUT:fixed;'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
        m_strHeaderTables.Append("<TR class='clsTRColumnHeader'>")

        If intFor = 1 Then
            CommonFunctions.General.WriteHTML("<TD >")
            CommonFunctions.General.WriteHTML("</TD>")
            m_strHeaderTables.Append("<TD></TD>")
        End If

        While intCounter < arrlst.Count
            If intFor = 1 Then
                If intCounter > 2 Then
                    CommonFunctions.General.WriteHTML("<TD>")
                    CommonFunctions.General.WriteHTML(arrlst.Item(intCounter))
                    CommonFunctions.General.WriteHTML("</TD>")
                    m_strHeaderTables.Append("<td></td>")
                End If
            Else
                If intCounter > 0 Then
                    CommonFunctions.General.WriteHTML("<TD>")
                    CommonFunctions.General.WriteHTML(arrlst.Item(intCounter))
                    CommonFunctions.General.WriteHTML("</TD>")
                    m_strHeaderTables.Append("<td></td>")
                End If
            End If
            intCounter = intCounter + 1
        End While
        m_strHeaderTables.Append("</TR></Table>")
        CommonFunctions.General.WriteHTML("</TR>")
    End Sub
    'Added by SrikanthY on 07 Aug 2007 , to show Metric,Datapoint graphs at Below project level , for whizible metrics 3.0
    Private Sub DrawBreakupHeader(ByVal arrlst As ArrayList, ByVal intFor As Integer, ByVal strFor As String)
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML(strFor)
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML("")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
    End Sub
    'End of Addition by SrikanthY on 07 Aug 2007  

    Private Sub DrawHiddens()
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunctions.HTMLControls.DrawTextBox("hdnDivScrollHeight", "hdnDivScrollHeight", , , , m_strDivScrollHeight, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("hdnDivScrollHeight", "hdnDivScrollHeight", , , , m_strDivScrollHeight, , , , , , True, EnableHTMLEncode:=True)
        ''''End Added By Vaijat K On 06/10/2015
    End Sub

    Public Sub PlotHead(ByVal strPageTitle As String)
        '=====================================================================
        ' Sub Name              : PlotHead()	
        ' Purpose               : To plot the header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Dec 12, 2005
        ' Revisions             :
        '=====================================================================
        Dim strHTML As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        objHeaderFooter.HeaderFooter = "<B>" & strPageTitle & "</B>"
        strHTML = objHeaderFooter.DrawHeaderFooter(, True)
        If strHTML <> "" Then
            CommonFunctions.General.WriteHTML(strHTML)
        End If
    End Sub


    Private Function DrawTabs(ByVal SelectedTabValue As Integer) As String
        '=====================================================================
        ' Procedure Name        : DrawTabs()
        ' Purpose               : Generic function to Draw the Tabs for Potfolio Analyser
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK 
        ' Created               : 17 Jan 2006 
        ' Revisions             :
        '=====================================================================
        Dim strResult As String
        Dim txtResult As New System.Text.StringBuilder
        Dim strSelectedTitle As String

        txtResult.Append("<TABLE BORDER=0 cellpadding=1 cellspacing=0 width='100%' ><TR class=clsTRNavLinks valign=middle>" + vbCrLf)
        'Commented And Added By Vaijat K ON 02/12/2015 Issue ID-1989
        'txtResult.Append("<TD nowrap class=clsLinkPageHeaderInner>")
        If Request.Browser.Browser.ToUpper() <> "CHROME" Then
            txtResult.Append("<TD nowrap class=clsLinkPageHeaderInner>")
        Else
            If SelectedTabValue = SelectedTab.Practice Then
                txtResult.Append("<TD nowrap class=clsLinkPageHeaderInner style='display:flex;width:25px;margin-top:12px'>")
            Else
                txtResult.Append("<TD nowrap class=clsLinkPageHeaderInner>")
            End If

        End If
        'End Added By Vaijat K ON 02/12/2015 Issue ID-1989
        If SelectedTabValue = SelectedTab.Customer Then
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsSelected'   Title='" + TAB_NAME_Customer + "' href='javascript:Customer_OnClick()'>" + TAB_NAME_Customer + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Practice + "' href='javascript:Practice_OnClick()'>" + TAB_NAME_Practice + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
        End If

        If SelectedTabValue = SelectedTab.Practice Then
            'Commented And Added By Chakshuta H on 20th-Nov-2015 Purpose::QA issue fixing
            'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_Customer + "' href='javascript:Customer_OnClick()'>" + TAB_NAME_Customer + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            'Commented And Added By Vaijat K ON 02/12/2015 Issue ID-1989
            'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a id='processselected' class='clsNavTab'   Title='" + TAB_NAME_Customer + "' href='javascript:Customer_OnClick()'>" + TAB_NAME_Customer + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_Practice + "' href='javascript:Practice_OnClick()'>" + TAB_NAME_Practice + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            If Request.Browser.Browser.ToUpper() <> "CHROME" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a id='processselected' class='clsNavTab'   Title='" + TAB_NAME_Customer + "' href='javascript:Customer_OnClick()'>" + TAB_NAME_Customer + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_Practice + "' href='javascript:Practice_OnClick()'>" + TAB_NAME_Practice + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                txtResult.Append("<a class='clsNavTab' style='padding-left:0px;padding-right:0px'  Title='" + TAB_NAME_Customer + "' href='javascript:Customer_OnClick()'>" + TAB_NAME_Customer + "</a>")
                txtResult.Append("<a class='clsSelected'  Title='" + TAB_NAME_Practice + "' href='javascript:Practice_OnClick()'>" + TAB_NAME_Practice + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            'End Added By Vaijat K ON 02/12/2015 Issue ID-1989
            'End Of Commented And Added By Chakshuta H on 20th-Nov-2015 Purpose::QA issue fixing
        End If
        txtResult.Append("<TD height='10px' width='100%'></td>")
        txtResult.Append("</TR></TABLE>")

        strResult = txtResult.ToString
        txtResult = Nothing

        Return strResult

    End Function

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

