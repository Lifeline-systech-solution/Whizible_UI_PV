Option Explicit On
Imports Whizible
Imports CommonFunctions
Imports WebPages.Template
Public Class GeneratePrevSnapshots
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
    Private WithEvents m_objDataGrid As New WebPages.Template.GenericGrid
    Public Const PAGE_CAPTION As String = "Generate Previous Snapshots"
    Public Const MSG_NO_RECORDS = "There are no items to show in this view."
    Protected m_strHeaderTables As New System.Text.StringBuilder
    Protected m_strPT As String
    Public strSelectedTitle As String = ""
    Private m_strSortBy As String = ""
    Private m_strOrderBy As String = ""
    Private m_strAction As String = ""
    Private strSQLQuery As String = ""

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
        Dim strFreq As String
        strFreq = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_SEL_tbl_MET_ProjectAttributes_Frequency " + CType(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"), String), True), "")
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFreq", "txtFreq", , , , strFreq, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFreq", "txtFreq", , , , strFreq, , , , , , True, , True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015

        DrawMenu()
        If m_strAction.ToUpper = "SAVE" Then
            Dim strSelectedIDS() As String
            Dim intCounter As Integer
            strSelectedIDS = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkSelect"), "").Split(","c)
            If strSelectedIDS.Length <> 0 Then
                For intCounter = 0 To strSelectedIDS.Length - 1
                    strSQLQuery = "Exec Usp_ins_Previous_SnapShot " + CommonFunction.General.CheckIsNothing(Session("intProjectID").ToString, "0").ToString() + ",'" + CStr(strSelectedIDS(intCounter)) + "'," + HttpContext.Current.Request.Form("txtFreq").ToString()
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Next
            End If
        End If
        DrawDataGrid()
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

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"), "") <> "" Then
            m_strAction = Request.QueryString("Action")
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

    Public Sub DrawDataGrid()
        Dim txtSQLQuery As New System.Text.StringBuilder
        m_objDataGrid = New WebPages.Template.GenericGrid()
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=center width='20%'", "align=center width='20%'", "align=center width='20%'", "align=center width='10%'"}
        'Dim arrColRowLinks() As String = {"GeneratePrevData(Snapshotda,MappingEntityID)"}

        Dim arrCheckBoxIDs() As String = {"", "", "", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", "", "", "Selected"}

        strSQLQuery = "exec usp_sel_tbl_PRS_MetricHistory_Previous_SnapShot " + CommonFunction.General.CheckIsNothing(Session("intProjectID").ToString, "0").ToString() + ",'" + m_strPageNumber + "'"
        arrColumnHeadingList.Add("Snapshot Date")
        arrColumnHeadingList.Add("From Date")
        arrColumnHeadingList.Add("To Date")
        arrColumnHeadingList.Add("Select")

        arrActualColumnNames.Add("SnapShotDate")
        arrActualColumnNames.Add("FromDate")
        arrActualColumnNames.Add("ToDate")
        arrActualColumnNames.Add("")
        ' m_strSortBy = "SnapshotDate"
        If Not Request.QueryString("sortby") Is Nothing Then
            m_strSortBy = Request.QueryString("sortby")
        Else
            m_strSortBy = "SnapshotDate"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            m_strOrderBy = Request.QueryString("sortorder")
        Else
            m_strOrderBy = "ASC"
        End If
        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        With m_objDataGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            '.CheckBoxIDArray = arrCheckBoxIDs
            .CheckBoxIDArray = arrCheckBoxIDs
            '.RowLinkArray = arrColRowLinks
            '.CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Count - 1
            .PrimaryKey = "SnapshotDate"
            .ClientSideSortFunctionName = "Sort_OnClick"
            .TDStyleArray = arrWidthArray
            '.RowLinkArray = arrColRowLinks
            '.DIVStyle = "overflow:auto;width:99.99%;Height:99.99%"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .SortBy = m_strSortBy
            .SortOrder = m_strOrderBy
            .DIVHeight = 400
            .DIVStyle = "overflow:auto;width:99.99%"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            ''''Added By Vaijat K On 06/10/2015
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            ''''End Added By Vaijat K On 06/10/2015
            .DrawGrid()
        End With
        m_objDataGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        '  arrColRowLinks = Nothing
    End Sub
    Private Sub DrawMenu()
        Dim m_SQLSB As System.Text.StringBuilder
        Dim m_strSQL As String

        m_strSQL = "usp_sel_PreviousSnapShot_Paging " + CommonFunction.General.CheckIsNothing(Session("intProjectID").ToString, "0").ToString()
        strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, "Select", , "Alphabet", True)

        Dim arrCMenu() As String = {"Save", "Close"}
        Dim arrCMenuToolTip() As String = {"Save", "Close"}
        Dim arrCClientSideFunctions() As String = {"Save_OnClick()", "Close_OnClick()"}

        If strPageAlphabets = "" Then m_strPageNumber = "-1"
        Dim strmenu As String = ""
        m_objMenu = New WebPages.Template.StaticMenu
        strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True, strPageAlphabets)
        'If blnShowPaging Then
        '    strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True, strPageAlphabets)
        'Else
        '    strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True)
        'End If
        CommonFunctions.General.WriteHTML(strmenu)
        m_objMenu = Nothing
        ''''''''''
        CommonFunctions.General.WriteHTML("<BR><TABLE id='tblCap054'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption><TD align=Left>Sanpshots</TD></TR></TABLE><BR>")
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
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

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

