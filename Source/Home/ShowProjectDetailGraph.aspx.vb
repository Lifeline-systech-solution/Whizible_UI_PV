'ASPX was Modified for following reasons:
'1) Added Palette_OnClick
'3) Modified functions - DrillDown_OnClick, callDetail.
'  for showing crosstab on drill-down page.
'3) Added Dashboards_OnClick function  
'   For WAF3_CDB_22 - for Dashboard Deletion.
'4) changed the position of JS script blocks. Placed the script block at the beginning,
'   as it is required for the menu-inks and other links on the page.
' For CDB_CONFIG_DRILLDOWN_PK_13_AUG_2007
'5) Changed the width of window for Dashboard-Settings 
'   For CDB_CONFIG_DRILLDOWN_PK_13_AUG_2007 : NoOfGraphsPerRow.
'6) Added Refresh_OnClick 
'    for CDB_CONFIG_DRILLDOWN_PK_13_AUG_2007 : IssueID: 14381
'7) Modified DrillDown_OnClick and callDetail JS functions for intDisplayType parameter
'    For CDB_CONFIG_DRILLDOWN_PK_13_AUG_2007: IssueID: 14839 & 14912   
'8) Added SetGraphSkin JS function
'    For WAF3_CDB_28

Imports Dundas.Charting.WebControl
Imports System.IO.File
Imports System.IO.StringWriter
Imports System.Text
Imports Whiz

Public Class ShowProjectDetailGraph
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	CDB_Main
    ' Purpose				:	The class generates the main page of the 
    '                           CDB module. 
    ' Description			:	The page displays all graphs for the user
    '                           dashboard, along with alerts set.
    ' Assumptions			:	None
    ' Dependencies			:	
    ' Author				:	Vaijat
    ' Created				:	March 07,2016
    ' Revisions				:	
    '=====================================================================
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
#Region "constants"

    Private Const GRAPH_TYPE_PIE As Byte = 2
    Private Const GRAPH_TYPE_DOUGHNUT As Byte = 7
    Private Const GRAPH_TYPE_NEEDLE As Byte = 1



    Private Const GRAPH_TYPE_STACKEDCOLUMN As Byte = 13
    Private Const GRAPH_TYPE_STACKEDBAR As Byte = 14
    Private Const GRAPH_TYPE_STACKEDAREA As Byte = 15

    Private Const GRAPH_TYPE_BUBBLE As Byte = 16
    Private Const GRAPH_TYPE_POINT As Byte = 17

#End Region
#Region "module variables"
    Private m_strMode As String = ""
    Private m_lngUserID As Long = 0
    Private m_lngPostID As Long = 0
    Private m_blnUseSQL As Boolean
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnFromADMIN As Boolean = False
    Private m_lngEntityID As Long
    Private m_lngQueryID As Long
    Private cell As New HtmlTableCell
    Private row As New HtmlTableRow
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer
    Private m_strPalleteStyle As String
    Private m_strAccess As String

    Protected m_blnIsDBIdZero As Boolean = False
    Private m_blnHideDBCombo As Boolean = False

    Private m_intNoOfGraphsPerRow As Int16 = 2

    Private m_blnShowNeedleGraphs As Boolean = True
    Private m_blnShowOtherGraphs As Boolean = True
    Private m_blnShowMyQueries As Boolean = True
    Private m_blnShowDescriptiveAlert As Boolean = True
    '============================================================================================================================
    ' Modified By               :	Vaijat
    ' Purpose                   :   Not to allow to modify Favorite queries shared by another user, declaration of objGrid is changed to handle events
    ' Added                     :	March 07,2016
    ' IssueID                   :   WAF3_QB_IssueFixes 1
    '=============================================================================================================================
    Dim WithEvents objGrid As WebPage.Templates.GenericGrid
    '============================================================================================================================
    'End Modification 
    '=============================================================================================================================
    Private m_blnIsDropdownMenuEnabled As Boolean
#End Region

#Region "protected module variables"
    Protected m_strClientSideScript As String = ""
    Protected m_intCnt As Integer = 0
    Protected m_arrDBUsersID(0) As String
    Protected m_arrDBUsers(0) As String
    Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    Protected divGraphs As System.Web.UI.HtmlControls.HtmlControl
    Protected m_strFromWhere As String = ""
    Protected m_lngDashboardID As Long = 0
    Protected m_strFromPage As String = ""
    Protected m_lngDisplayAlertID As Long = 0
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
#End Region

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
    End Sub

    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()
        ' Purpose               : To write the page 
        ' Description           : Writes the CDB main page, which consists of
        '                         all graphs/alerts and links
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : DisplaySetDefaultLink()
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             : Changed the flow of plotting Combo 
        '                         and Default Dashboard Link
        '=====================================================================
        Dim blnShowGraphsTable As Boolean = False
        Dim strSQL As String = ""
        Dim dr As IDataReader
        Dim blnPrinted As Boolean = False
        Dim intDivHeight As Integer = 0


        With HttpContext.Current.Response

            If Not m_blnFromADMIN Then
                ' combo holding all dashboards for the user
                .Write("<TABLE class=clsTable width='100%' cellpadding=0 cellspacing=0>")
                .Write("<TR class=clsTRPageCaption>" & vbCrLf)
                .Write("<TD align='left' VAlign='top'>" & vbCrLf)

                If Not m_blnHideDBCombo Then ' CDB_SHOW_HIDE_DB_COMBO

                    MyBase.InitializeResources("Resources.CDB_Main", "Resources")

                    .Write("<a id='lnkDashboards' name='lnkDashboards' href='javascript:Dashboards_OnClick(" + CommonFunctions.General.CheckIsNothing(m_lngDashboardID, "0") + ")'>")
                    .Write("<B>" + MyBase.GetResourceString("CONFIG_DB") + "</B>")
                    .Write("</a>&nbsp;&nbsp;&nbsp;")
                    If m_lngPostID <> 0 Then
                        CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & m_lngUserID.ToString & "," & m_lngPostID.ToString, 0, "../CDB/CDB_Main.aspx|" & m_lngDashboardID.ToString, "OnChange='JavaScript:cboDashboard_OnChange()'")
                    Else
                        CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo  " & m_lngUserID.ToString, 0, "../CDB/CDB_Main.aspx|" & m_lngDashboardID.ToString, "OnChange='JavaScript:cboDashboard_OnChange()'")
                    End If

                End If 'for CDB_SHOW_HIDE_DB_COMBO

                .Write("</TD>")

                'Save the unnecessary Server trip
                If Not m_blnIsDBIdZero Then
                    ' set as default link
                    'Call DisplaySetDefaultLink(m_lngDashboardID, m_lngUserID)
                End If
                .Write("</TR></TABLE>" & vbCrLf)
            End If

            'Again save server trips
            If Not m_blnIsDBIdZero Then

                If UCase(Trim(m_strFromWhere & "")) = "ADMIN" Then
                    strSQL = "usp_CDB_Get_UserSettings	" & m_lngDashboardID & "," & m_lngUserID & ",3,1,'" & m_strLoginType & "'"
                Else
                    strSQL = "usp_CDB_Get_UserSettings	" & m_lngDashboardID & "," & m_lngUserID & ",3,0,'" & m_strLoginType & "'"
                End If

                MyBase.InitializeResources("Resources.StandardMenu", "Resources")
                ' menu
                'Call WriteMenu()

                MyBase.InitializeResources("Resources.CDB_Main", "Resources")

                ' Checking if there are any items configured for the user
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                blnShowGraphsTable = dr.Read
                CloseDataReader(dr)

                ' get the sql for section display
                If m_blnFromADMIN Then
                    strSQL = "usp_sel_tbl_CDB_DashboardSections " + m_lngDashboardID.ToString + ",null,'" + m_strLoginType + "',1"
                Else
                    strSQL = "usp_sel_tbl_CDB_DashboardSections " + m_lngDashboardID.ToString + "," + m_lngUserID.ToString + ",'" + m_strLoginType + "',1"
                End If
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                Do While dr.Read
                    ' get the section height
                    If Not IsDBNull(dr("SectionHeight")) Then
                        intDivHeight = CType(dr("SectionHeight"), Integer)
                    End If

                    Select Case Trim(dr("SectionName").ToString & "").ToUpper
                        'Case "LINKS" : Call DisplayLinks(intDivHeight)
                        'Case "SUMMARYALERTS" : Call DisplaySummaryAlerts(m_lngUserID, m_lngDashboardID, m_blnUseSQL, intDivHeight)
                        'Case "DESCRIPTIVEALERTS" : Call DisplayDescriptiveAlert(Not blnShowGraphsTable, intDivHeight, dr("UserFriendlySectionName").ToString)
                        'Case "NEEDLEGRAPHS" : Call DisplayNeedleGraphs(m_lngDashboardID, m_lngUserID, intDivHeight, dr("UserFriendlySectionName").ToString)
                        Case "OTHERGRAPHS" : Call DisplayNonNeedleGraphs(m_lngDashboardID, m_lngUserID, intDivHeight, dr("UserFriendlySectionName").ToString)
                            'Case "MYQUERIES" : Call DisplayMyQueries(intDivHeight, dr("UserFriendlySectionName").ToString)
                        Case Else
                    End Select

                    blnPrinted = True
                Loop
                CloseDataReader(dr)

                If Not blnPrinted Then
                    ' default if no sections were defined for the dashboard
                    'Call DisplaySummaryAlerts(m_lngUserID, m_lngDashboardID, m_blnUseSQL)
                    'Call DisplayDescriptiveAlert(Not blnShowGraphsTable)
                    'Call DisplayNeedleGraphs(m_lngDashboardID, m_lngUserID)
                    Call DisplayNonNeedleGraphs(m_lngDashboardID, m_lngUserID)
                End If

                Call DisplayNoItemMessage()

            End If

        End With
        Response.Flush()
    End Sub

#Region "Private Methods"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim intSetDefault As Integer
        ' initialize the module variables
        Call Initialize()
        ' check for actions to be performed
        If Trim(m_strMode & "").ToUpper = "SET_DEFAULT" Then
            If Not Request.QueryString("SetDefault") Is Nothing Then
                intSetDefault = CType(Request.QueryString("SetDefault"), Integer)
                If Trim(intSetDefault & "") <> "" Then
                    SetResetDefaultDashboard((Trim(intSetDefault & "") = "1"), m_lngUserID, m_strLoginType, m_lngDashboardID)
                End If
            End If
        End If
    End Sub

#Region "My Queries, Links & Alerts"

    Private Sub DisplayMyQueries(Optional ByVal DivHeight As Integer = 0, Optional ByVal SectionName As String = "")
        '=====================================================================
        ' Procedure Name        : DisplayMyQueries()
        ' Purpose               : To display the favorite queries for the user
        ' Description           : same as above
        ' Parameters Passed     : [Div height],[Section Name]
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String


        Dim arrCaptions() As String = {MyBase.GetResourceString("CAP_TYPE"), MyBase.GetResourceString("CAP_QUERY_NAME"), ""}
        Dim arrColumns() As String = {"GroupName", "QueryName", "Execute"}
        Dim arrRowLink() As String = {"OpenFavorites(type)", "Query_OnClick(QueryID,type)", "Execute_OnClick(QueryID,type)"} 'Added  by VinayB on 15-APR-2009 3.0.06.P.Y-SP12-WAF IssueID->30072
        Dim arrGroup() As String = {"1"}
        Dim arrRowLinkToolTip() As String = {"", "Edit Query", "Execute"}
        Dim arrRowLinkOnColumn() As String = {"", "Editable"}


        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Dim strLeftSectionTitle As String
        Dim strSectionTag As String
        Dim strFunctionName As String
        Dim blnPrinted As Boolean = False

        Dim dr As IDataReader
        Dim index As Integer
        Dim strUserList As String = ""
        'create the list of user list who are sharing the query on their dashboard
        index = 0
        strSQL = "usp_sel_CDB_MyQueries '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For Showing Queries on selected Dashboards. 
        '-------------------------------------------------------------------------------------------------------------
        strSQL += "," + m_lngDashboardID.ToString()
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Do While dr.Read
            strSQL = "usp_CDB_Get_QueryUserNames " + dr("QueryID").ToString
            strUserList = CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), String) + ""
            If strUserList <> "" And strUserList <> Nothing Then
                ReDim Preserve m_arrDBUsersID(index)
                ReDim Preserve m_arrDBUsers(index)
                m_arrDBUsersID(index) = dr("QueryID").ToString
                m_arrDBUsers(index) = strUserList
                index += 1
            End If
        Loop
        CloseDataReader(dr)

        strLeftSectionTitle = SectionName
        strFunctionName = "ShowHide_divMyQueries"
        strSectionTag = "divMyQueries"

        strLeftSectionTitle += "&nbsp;" + MyBase.GetResourceString("NOTE_MYQUERIES_SECTION") + ""


        strSQL = "usp_sel_CDB_MyQueries '" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For Showing Queries on selected Dashboards. 
        '-------------------------------------------------------------------------------------------------------------
        strSQL += "," + m_lngDashboardID.ToString()
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        objGrid = New WebPage.Templates.GenericGrid
        With objGrid
            If Not blnPrinted Then
                If m_blnShowMyQueries Then
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName))
                    m_strClientSideScript += "<script language=javascript>" + vbCrLf + "ShowMyQueries=1;" + vbCrLf + "" + vbCrLf + "</script>" + vbCrLf
                Else

                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , "../../images/plus.gif"))
                    m_strClientSideScript += "<script language=javascript>" + vbCrLf
                    m_strClientSideScript += "ShowMyQueries=0;" + vbCrLf + "" + vbCrLf
                    m_strClientSideScript += "</script>" + vbCrLf
                End If
                'Destroy the object
                cObjSectionTitle = Nothing
                blnPrinted = True
            End If

            .ActualColumnArray = arrColumns
            .UserFriendlyColumnArray = arrCaptions
            .RowLinkArray = arrRowLink
            .RowLinkToolTipArray = arrRowLinkToolTip
            .RowLinkEnableOnColumn = arrRowLinkOnColumn
            .GroupOnColumn = arrGroup
            .NoOfDataColumns = 2
            If DivHeight > 0 Then
                .DIVHeight = DivHeight
            Else
                .DIVHeight = 300
            End If
            .DIVID = "divMyQueries"
            If m_blnShowMyQueries Then
                If DivHeight > 0 Then
                    .DIVStyle = "overflow:auto;height:" + DivHeight.ToString + "px"
                Else
                    .DIVStyle = "overflow:auto"
                End If
            Else
                If DivHeight > 0 Then
                    .DIVStyle = "overflow:auto;height:" + DivHeight.ToString + "px;display:none"
                Else
                    .DIVStyle = "overflow:auto;display:none"
                End If
            End If
            .returnHTML = False
            .PrinterFriendlyVersion = False
            .UseSQL = m_blnUseSQL
            .SQL = strSQL
            .DrawGrid()
        End With
        objGrid = Nothing

        Response.Flush()

    End Sub

    Private Sub DisplayLinks(Optional ByVal DivHeight As Integer = 0)
        '=====================================================================
        ' Procedure Name        : DisplayLinks()
        ' Purpose               : To display the links for the DB
        ' Description           : Displays all links
        ' Parameters Passed     : [Divheight=0]
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Vaijat
        ' Created               : March 7,2016
        ' Revisions             :
        '=====================================================================
        ' 
        Dim dr As IDataReader
        Dim strSQL As String = ""
        Dim blnPrinted As Boolean = False

        With Response
            .Write("<BR>")

            strSQL = "usp_sel_tbl_CDB_Links " + m_lngDashboardID.ToString + "," + m_lngUserID.ToString + ",'" + m_strLoginType + "','LinkName','ASC'"
            If m_blnFromADMIN Then
                strSQL += ",1"
            End If
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

            Do While dr.Read
                If Not blnPrinted Then
                    If DivHeight > 0 Then
                        .Write("<DIV id=DIVLinks style='overflow:auto;height=" + DivHeight.ToString + "'>")
                    End If
                    .Write("<TABLE class=clsTable width='100%' cellpadding=0 cellspacing=0>")
                    .Write("<TR class=clsTRSectionHeader><TD>")
                    blnPrinted = True
                End If
                ' the link
                ' .Write("<A class='clsCDBLinks' href=javascript:Link_OnClick('" + Server.UrlPathEncode(dr("LinkURL").ToString) + "') title='" + dr("LinkURL").ToString + "'>" + CommonFunctions.General.FormatString(dr("LinkName").ToString) + "</A> | ")
                .Write("<A class='clsCDBLinks' href=javascript:Link_OnClick('" + Microsoft.VisualBasic.Strings.Replace(Server.UrlPathEncode(dr("LinkURL").ToString), "'", "\'") + "') title='" + Microsoft.VisualBasic.Strings.Replace(dr("LinkURL").ToString, "'", "&#39;") + "'>" + Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(Server.HtmlEncode(dr("LinkName").ToString), """", "&quot;"), "'", "&#39;") + "</A> | ") 'Modified By Shrikant on 19 June 2008 Issue ID 20608
            Loop
            CloseDataReader(dr)

            If blnPrinted Then
                .Write("</TD></TR>")
                .Write("</TABLE>")
                If DivHeight > 0 Then
                    .Write("</DIV>")
                End If
            End If
        End With

        Response.Flush()

    End Sub

    Private Sub DisplaySummaryAlerts(ByVal lngUserID As Long, ByVal lngDashboardID As Long, ByVal UseSQL As Boolean, Optional ByVal DivHeight As Integer = 0)
        '=====================================================================
        ' Procedure Name        : DisplaySummaryAlerts()
        ' Purpose               : To display the summary alerts for the DB
        ' Description           : Displays all the summary alerts for the DB
        '                         set by the user
        ' Parameters Passed     : ByVal lngUserID As Long, ByVal lngDashboardID As Long, ByVal UseSQL As Boolean
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim sbAlertList As New System.Text.StringBuilder("")
        Dim dr As IDataReader

        'Dim drConnection As IDataReader

        Dim drFormula As IDataReader
        Dim drValue As IDataReader
        Dim lngFormulaID As Long
        Dim lngEntityID As Long
        Dim lngConnectionID As Long
        Dim dblFormulaOutput As Double
        Dim strFormulaSQL As String
        Dim strWhereClause As String
        Dim strConnectionString As String
        Dim strBold, strBold2, strItalic, strItalic2, strUnderline, strUnderline2 As String
        Dim strTDStyle As String
        Dim strValue As String
        Dim blnIsOracle As Boolean
        Dim dblNStart, dblNEnd, dblWStart, dblWEnd, dblDStart, dblDEnd As Double
        Dim strSQL As String

        Dim strAccess As String = ""

        If DivHeight <> 0 Then
            sbAlertList.Append("<DIV id=DivList style='overflow:auto;height=" + DivHeight.ToString + "'>")
        End If
        sbAlertList.Append("<table class=clsTable border=1 bordercolor=black cellpadding=0 cellspacing=0 width='100%'><tr>")

        strSQL = "usp_CDB_Get_UserAlertForDisplay  " & lngUserID & ",NULL," & lngDashboardID
        If m_blnFromADMIN Then
            strSQL += ",1"
        End If
        dr = CommonFunctions.Data.GetDataReader(strSQL, UseSQL)
        Do While dr.Read
            ' get the formula id, entity id and connection id
            lngFormulaID = CType(dr("FormulaID"), Long)
            lngEntityID = CType(dr("EntityID"), Long)

            ' get the connection string
            '-------------------------------------------------------------------------------------------------------------
            'Reason      - To get the decrypted connection string from hashtable instead of getting it from database.
            '              Use the GetConnectionID method of QueryBuilder.WAFConnections to get the Connection ID
            '-------------------------------------------------------------------------------------------------------------

            'drConnection = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID	" & lngEntityID, UseSQL)
            'If drConnection.Read Then
            '    If Trim(drConnection("ConnectionID").ToString & "") <> "" Then
            '        lngConnectionID = CType(drConnection("ConnectionID"), Long)
            '    Else
            '        lngConnectionID = 0
            '    End If
            'Else
            '    lngConnectionID = 0
            'End If
            'CloseDataReader(drConnection)
            'strConnectionString = GetConnectionString(lngConnectionID, blnIsOracle, m_blnUseSQL)


            ''lngConnectionID = QueryBuilder.WAFConnections.GetConnectionID(lngEntityID, 0, UseSQL)
            ''strConnectionString = QueryBuilder.WAFConnections.GetConnectionString(lngConnectionID, blnIsOracle)
            lngConnectionID = Whiz.QueryBuilder.WAFConnections.GetConnectionID(lngEntityID, 0, UseSQL)
            strConnectionString = Whiz.QueryBuilder.WAFConnections.GetConnectionString(lngConnectionID, blnIsOracle)
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------

            ' Getting the Formula details from the formula master for the ID
            drFormula = CommonFunctions.Data.GetDataReader("usp_CDB_Get_FormulaDetails  " & lngFormulaID, UseSQL)
            If drFormula.Read Then
                strFormulaSQL = "SELECT	" & CommonFunctions.General.BuildQueryString(drFormula("FormulaValue").ToString & "") & " FROM	" & CommonFunctions.General.BuildQueryString(drFormula("EntityName").ToString & "")
            Else
                strFormulaSQL = ""
            End If
            CloseDataReader(drFormula)

            ' The where clause for the formula
            strWhereClause = dr("WhereClause").ToString & ""

            ' Applying ROLE BASED FILTERS for the Entity
            If Trim(lngConnectionID & "") <> "" And Trim(lngConnectionID & "") <> "0" Then
                strWhereClause = Microsoft.VisualBasic.Strings.Replace(Trim(strWhereClause & ""), "@", "")
            Else
                strAccess = WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(m_blnUseSQL, lngEntityID)
                If Trim(strAccess & "") <> "" Then
                    If Trim(strWhereClause & "") <> "" Then
                        strWhereClause = Microsoft.VisualBasic.Strings.Replace(Trim(strWhereClause & ""), "@", "") & " AND " & strAccess
                    Else
                        strWhereClause = Microsoft.VisualBasic.Strings.Replace(Trim(strWhereClause & ""), "@", "") & strAccess
                    End If
                Else
                    strWhereClause = Microsoft.VisualBasic.Strings.Replace(Trim(strWhereClause & ""), "@", "")
                End If

            End If

            ' Appending the where clause if present
            If Trim(strWhereClause & "") <> "" Then
                strFormulaSQL = strFormulaSQL & " WHERE " & strWhereClause
            End If

            ' getting the Value of the formula 
            If Trim(strFormulaSQL & "") <> "" Then
                strFormulaSQL = Microsoft.VisualBasic.Strings.Replace(UCase(Trim(strFormulaSQL & "")), "@COMMA@", ",")
                If blnIsOracle Then
                    strFormulaSQL = Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(strFormulaSQL, "[", ""), "]", "")
                End If

                CommonFunctions.General.SetQRBSessionVariables()
                strFormulaSQL = CommonFunctions.General.ReplacePlaceHolders(strFormulaSQL, True)
                CommonFunctions.General.ClearQRBSessionVariables()

                drValue = CommonFunctions.Data.GetDataReader(strFormulaSQL, Not blnIsOracle, strConnectionString)
                ' The output of the formula
                If drValue.Read Then
                    If Trim(drValue(0).ToString & "") = "" Then
                        dblFormulaOutput = 0
                    Else
                        dblFormulaOutput = CDbl(drValue(0))
                    End If
                Else
                    dblFormulaOutput = 0
                End If
                CloseDataReader(drValue)
            End If

            ' the font  BOLD string
            If CType(dr("FontBold"), Boolean) = True Then
                strBold = "<B>" : strBold2 = "</B>"
            Else
                strBold = "" : strBold2 = ""
            End If
            ' the font italic string
            If CType(dr("FontItalic"), Boolean) = True Then
                strItalic = "<i>" : strItalic2 = "</i>"
            Else
                strItalic = "" : strItalic2 = ""
            End If
            ' the font underline string
            If CType(dr("FontUnderline"), Boolean) = True Then
                strUnderline = "<u>" : strUnderline2 = "</u>"
            Else
                strUnderline = "" : strUnderline2 = ""
            End If
            If IsDBNull(dr("NormalStart")) Then dblNStart = 0 Else dblNStart = CType(dr("NormalStart"), Double)
            If IsDBNull(dr("NormalEnd")) Then dblNEnd = 0 Else dblNEnd = CType(dr("NormalEnd"), Double)
            If IsDBNull(dr("WarningStart")) Then dblWStart = 0 Else dblWStart = CType(dr("WarningStart"), Double)
            If IsDBNull(dr("WarningEnd")) Then dblWEnd = 0 Else dblWEnd = CType(dr("WarningEnd"), Double)
            If IsDBNull(dr("DangerStart")) Then dblDStart = 0 Else dblDStart = CType(dr("DangerStart"), Double)
            If IsDBNull(dr("DangerEnd")) Then dblDEnd = 0 Else dblDEnd = CType(dr("DangerEnd"), Double)

            ' finding the alert range 
            If dblFormulaOutput >= dblNStart And dblFormulaOutput <= dblNEnd Then
                ' NORMAL range 
                strTDStyle = "clsTDDBNormal"
                strValue = FormatNumber(dblNStart, 2) & "<=" & FormatNumber(dblFormulaOutput, 2) & "<=" & FormatNumber(dblNEnd, 2) & "  "
            ElseIf dblFormulaOutput >= dblWStart And dblFormulaOutput <= dblWEnd Then
                ' WARNING range
                strTDStyle = "clsTDDBWarning"
                strValue = FormatNumber(dblWStart, 2) & "<=" & FormatNumber(dblFormulaOutput, 2) & "<=" & FormatNumber(dblWEnd, 2) & "  "
            ElseIf dblFormulaOutput >= dblDStart And dblFormulaOutput <= dblDEnd Then
                ' DANGER range 
                strTDStyle = "clsTDDBDanger"
                strValue = FormatNumber(dblDStart, 2) & "<=" & FormatNumber(dblFormulaOutput, 2) & "<=" & FormatNumber(dblDEnd, 2) & "  "
            Else
                ' default style
                strTDStyle = ""
                strValue = "Value is out of all ranges specified"
            End If
            sbAlertList.Append("<td class=" & strTDStyle & " height=18px width='10%' NoWrap align=center VAlign=Top>")

            ' if the query id is specified along with the formulaid the query id is used for the details
            If Trim(dr("QueryID").ToString & "") <> "" Then
                ' Showing the title as link
                sbAlertList.Append("&nbsp;<A class=clsCDBSummaryAlert href='JavaScript:Show_AlertDetail(" & dr("QueryID").ToString & "," & dr("AlertID").ToString & ")'   Title=" & Chr(34) & Server.HtmlEncode(strValue & "") & Chr(34) & " STYLE='TEXT-DECORATION:None'>")
            End If
            sbAlertList.Append(strBold & strItalic & strUnderline & "")
            sbAlertList.Append(Server.HtmlEncode(Trim(dr("AlertTitle").ToString & "") & " (" & FormatNumber(dblFormulaOutput, 2) & ")"))
            sbAlertList.Append(strBold2 & strItalic2 & strUnderline2)
            sbAlertList.Append("</td>")
        Loop
        CloseDataReader(dr)
        sbAlertList.Append("</tr></table>")

        If DivHeight <> 0 Then
            sbAlertList.Append("</DIV>")
        End If
        ' Writing down the list of alerts 
        Response.Write(sbAlertList.ToString)

        Response.Flush()

    End Sub

    Private Sub DisplayDescriptiveAlert(ByVal ShowDIV As Boolean, Optional ByVal DivHeight As Integer = 200, Optional ByVal SectionName As String = "")
        '=====================================================================
        ' Procedure Name        : DisplayDescriptiveAlert()	
        ' Description           :
        ' Purpose               : 
        ' Parameters Passed     : ByVal AlertID
        ' Returns               :
        ' Parameters Affected   : 
        ' Assumptions           :
        ' Dependencies          : Module variables strSortField & strSortFieldOrder 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim lngQueryID As Long
        Dim intRowCount As Integer
        Dim strAlertTitle As String
        Dim strSQL As String
        Dim objQRB As QueryBuilder.cQuery
        Dim intDIVHeight As Integer = 0
        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Dim strLeftSectionTitle As String = ""
        Dim strSectionTag As String = ""
        Dim strFunctionName As String = ""
        Dim blnPrinted As Boolean = False


        If m_lngDisplayAlertID = 0 Then
            strSQL = "usp_CDB_Get_UserAlertForDisplay  " & m_lngUserID & ",1," & m_lngDashboardID
            If m_blnFromADMIN Then
                strSQL += ",1"
            End If
            ' get the default alert
            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
            Do While dr.Read
                If CType(dr("ShowAlert"), Boolean) = False Then Exit Sub
                ' if default alert is found exiting the loop
                If CType(dr("IsDefaultAlert"), Boolean) Then
                    ' exit the do loop
                    m_lngDisplayAlertID = CType(dr("AlertID"), Long) : Exit Do
                End If
            Loop
            CloseDataReader(dr)
        End If

        ' create a collapsible section for the descriptive alert
        strLeftSectionTitle = DisplayListOfAlertGrids(m_lngUserID, m_lngDisplayAlertID, intDIVHeight)
        If Trim(strLeftSectionTitle & "") <> "" Then
            strFunctionName = "ShowHide_DivList"
            strSectionTag = "DivList"
            If DivHeight <> 0 Then
                cObjSectionTitle = New WebPage.Templates.SectionTitle
                With cObjSectionTitle
                    ' the section title
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName))
                    ' write the client side script
                    m_strClientSideScript += vbCrLf + "<SCRIPT language=javascript>" + vbCrLf
                    m_strClientSideScript += .ClientsideScript()
                    m_strClientSideScript += vbCrLf + "</SCRIPT>" + vbCrLf
                End With
                'Destroy the object
                cObjSectionTitle = Nothing
            End If
        End If

        ' Getting the alert details
        dr = CommonFunctions.Data.GetDataReader("usp_sel_CDB_Alerts  " & m_lngDisplayAlertID, m_blnUseSQL)
        If dr.Read Then
            If CType(dr("ShowAlert"), Boolean) = False Then
                CloseDataReader(dr)
                Exit Sub
            End If
            ' The query id and the alert-title
            lngQueryID = CType(dr("QueryID"), Long)

            If Not ShowDIV Then intDIVHeight = DivHeight

            MyBase.InitializeResources("Resources.StandardCaptions", "Resources")

            ' build the grid
            Call CDB_QueryOutput.BuildGrid(lngQueryID, m_strSortBy, m_strSortOrder, DivHeight, m_blnUseSQL, , , , , m_lngDisplayAlertID)
        Else
            With Response
                .Write("<DIV id=DivList style='overflow:auto'></DIV>")
            End With
        End If
        CloseDataReader(dr)
    End Sub

    Private Function DisplayListOfAlertGrids(ByVal UserId As Long, ByVal AlertID As Long, Optional ByVal DivHeight As Integer = 0) As String
        '=====================================================================
        ' Procedure Name        : DisplayListOfAlertGrids()	
        ' Description           : The list of alerts are displayed with links
        ' Purpose               : To display the list of alerts for the DB
        ' Parameters Passed     : ByVal UserId,ByVal AlertID
        ' Returns               : HTML string for list of desc. alerts
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables, SPs
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim ds As System.Data.DataSet
        'Dim drDetails As IDataReader
        Dim lngQueryID As Long
        Dim lngAlertID As Long
        Dim lngConnectionID As Long
        Dim intRowCount As Integer
        Dim strAlertTitle, strSQL As String
        Dim strConnectionString As String
        Dim blnIsOracle As Boolean
        Dim blnPrinted As Boolean = False
        Const SELECTED_ALERT_COLOR As String = "BLACK"
        Dim sb As New System.Text.StringBuilder("")

        strSQL = "usp_CDB_Get_UserAlertForDisplay  " & UserId & ",1," & m_lngDashboardID
        If m_blnFromADMIN Then
            strSQL += ",1"
        End If
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Response.Write("<BR>")
        sb.Append("|")
        Do While dr.Read
            ' The query id 
            If Not IsDBNull(dr("QueryID")) Then
                lngQueryID = CType(dr("QueryID"), Long)
            End If
            If Not IsDBNull(dr("AlertID")) Then
                lngAlertID = CType(dr("AlertID"), Long)
            End If
            'and the alert-title
            strAlertTitle = dr("AlertTitle").ToString

            If m_lngDisplayAlertID = 0 Then
                If CType(dr("IsDefaultAlert"), Boolean) Then
                    m_lngDisplayAlertID = CType(dr("AlertID"), Long)
                End If
            End If

            ' Building the query
            strSQL = CDB_QueryOutput.BuildQuery(lngQueryID, m_blnUseSQL)

            ' get the connection string for the query
            '-------------------------------------------------------------------------------------------------------------
            'Reason      - To get the decrypted connection string from hashtable instead of getting it from database.
            '-------------------------------------------------------------------------------------------------------------
            'drDetails = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID_ForQuery	" & lngQueryID, m_blnUseSQL)
            'If drDetails.Read Then
            '    If IsDBNull(drDetails("ConnectionID")) Then
            '        lngConnectionID = 0
            '    Else
            '        lngConnectionID = CType(drDetails("ConnectionID"), Long)
            '    End If
            'Else
            '    lngConnectionID = 0
            'End If
            'CloseDataReader(drDetails)
            'strConnectionString = GetConnectionString(lngConnectionID, blnIsOracle, m_blnUseSQL)

            lngConnectionID = QueryBuilder.WAFConnections.GetConnectionID(0, lngQueryID, m_blnUseSQL)
            strConnectionString = QueryBuilder.WAFConnections.GetConnectionString(lngConnectionID, blnIsOracle)
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------

            If Trim(strSQL & "") <> "" Then
                If blnIsOracle Then
                    strSQL = Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(strSQL, "[", ""), "]", "")
                End If
                ' Getting the count of rows returned by the query using a dataset
                ds = CommonFunctions.Data.GetDataSet(strSQL & "", "Default", , , Not blnIsOracle, strConnectionString)
                intRowCount = ds.Tables(0).Rows.Count
                ds.Dispose() : ds = Nothing
            End If

            If Trim(m_lngDisplayAlertID.ToString & "") = Trim(lngAlertID.ToString & "") Then
                ' Selected alert link "BLUE" colored
                sb.Append("<a href='JavaScript:Alert_Display(0)' style='TEXT-DECORATION:None'>" & vbCrLf)
                sb.Append("<IMG border=0 forecolor=black height=5 src='../../images/arrowselect.gif' width=7><b>" & vbCrLf)
                sb.Append("<Font Size=1 face=Arial;verdana color = " + SELECTED_ALERT_COLOR + "> " & Server.HtmlEncode(strAlertTitle) & "</A></font></B>" & vbCrLf) 'Modified By ShrikantB On 19 June 2008 For IssueId-20608
                ' sb.Append("<Font Size=1 face=Arial;verdana color = " + SELECTED_ALERT_COLOR + "> " & strAlertTitle & "</A></font></B>" & vbCrLf)
                sb.Append("<A href='JavaScript:Show_AlertDetail(" & lngQueryID & "," & lngAlertID & ")' style='TEXT-DECORATION:None' Title='Click to open the printer friendly view'>" & vbCrLf)
                sb.Append("<Font Size=1 face=Arial;verdana color=Brown><b> (" & intRowCount & ")" & "</font></B></A>" & vbCrLf)
                sb.Append("|")
            Else
                ' other alerts	
                sb.Append("<B><a href='JavaScript:Alert_Display(" & dr("AlertID").ToString & ")' style='TEXT-DECORATION:None'>" & vbCrLf)
                sb.Append("<IMG border=0 height=5 src='../../images/arrowselect.gif' width=7><b>" & vbCrLf)
                'sb.Append("<Font Size=1 face=Arial;verdana color=white> " & strAlertTitle & "</A></font></B>" & vbCrLf)
                sb.Append("<Font Size=1 face=Arial;verdana color=white> " & Server.HtmlEncode(strAlertTitle) & "</A></font></B>" & vbCrLf) 'Modified By ShrikantB On 19 June 2008 For IssueId-20608
                sb.Append("<A href='JavaScript:Show_AlertDetail(" & lngQueryID & "," & lngAlertID & ")' style='TEXT-DECORATION:None' Title='Click to open the printer friendly view'>" & vbCrLf)
                sb.Append("<Font Size=1 face=Arial;verdana color=Brown><b> (" & intRowCount & ")" & "</font></B></A>" & vbCrLf)
                sb.Append("|")
            End If

            blnPrinted = True
        Loop
        CloseDataReader(dr)

        ' return string
        If blnPrinted Then
            DisplayListOfAlertGrids = sb.ToString
        Else
            Return ""
        End If
        ' destroy the string builder object
        sb = Nothing
    End Function
#End Region

#Region "Needle Graphs"

    Private Sub DisplayNeedleGraphs(ByVal DashboardID As Long, ByVal UserID As Long, Optional ByVal DivHeight As Integer = 0, Optional ByVal SectionName As String = "")
        '=====================================================================
        ' Procedure Name        : DisplayNeedleGraphs()
        ' Purpose               : To display all the needle graphs for the dashboard
        ' Description           : The procedure displays all the needle graphs for the
        '                         dashboard. Three graphs are displayed in a row
        ' Parameters Passed     : Dashboard ID, User ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim intTDCount As Integer = 1
        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Dim strLeftSectionTitle As String = ""
        Dim strSectionTag As String = ""
        Dim strFunctionName As String = ""
        Dim blnPrinted As Boolean = False

        Response.Write("<BR>")

        ' Getting the user settings for the needle-graphs
        strSQL = "usp_CDB_Get_UserSettings	" & DashboardID & "," & UserID & ",1"
        If Trim(Request.QueryString("FromWhere") & "").ToUpper = "ADMIN" Then
            strSQL += ",1,'" & m_strLoginType & "'"
        Else
            strSQL += ",0,'" & m_strLoginType & "'"
        End If


        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            If Not blnPrinted Then
                ' create a collapsible section for the graph type
                strLeftSectionTitle = SectionName
                strFunctionName = "ShowHide_divNeedleGraph"
                strSectionTag = "divNeedleGraph"
                cObjSectionTitle = New WebPage.Templates.SectionTitle


                If m_blnShowNeedleGraphs Then
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName))
                    m_strClientSideScript += "<script language=javascript>" + vbCrLf + "ShowNeedleGraphs=1;" + vbCrLf + "" + vbCrLf + "</script>" + vbCrLf
                    If DivHeight > 0 Then
                        Response.Write("<DIV id=divNeedleGraph style='overflow:auto;height=" + DivHeight.ToString + "'>" + vbCrLf)
                    Else
                        Response.Write("<DIV id=divNeedleGraph style='overflow:auto;'>" + vbCrLf)
                    End If

                Else
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , "../../Images/plus.gif"))
                    m_strClientSideScript += "<script language=javascript>" + vbCrLf
                    m_strClientSideScript += "ShowNeedleGraphs=0;" + vbCrLf + "" + vbCrLf
                    m_strClientSideScript += "</script>" + vbCrLf
                    If DivHeight > 0 Then
                        Response.Write("<DIV id=divNeedleGraph style='overflow:auto;height=" + DivHeight.ToString + ";display:none'>" + vbCrLf)
                    Else
                        Response.Write("<DIV id=divNeedleGraph style='overflow:auto;display:none'>" + vbCrLf)
                    End If

                End If
                'Destroy the object
                cObjSectionTitle = Nothing

                Response.Write("<table class= bgcolor=black align=center valign=middle width='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write("<tr>" & vbCrLf)

                blnPrinted = True
            End If

            ' Showing 2 needle graphs in a row
            If m_intNoOfGraphsPerRow = 1 OrElse intTDCount > 2 Then ' for CDB_CONFIG_DRILLDOWN_PK_: NoOfGraphsPerRow
                ' ending the row and table for the next 2 graphs
                Response.Write("</TR>" & vbCrLf)
                Response.Write("<TR>" & vbCrLf)
                ' resetting the Td counter
                intTDCount = 1
            End If

            ' Creating the graph by calling the procedure for the module
            Call DisplayNeedleGraph(CType(dr("ItemID"), Long), UserID)

            ' Incremneting the TD count
            intTDCount = intTDCount + 1
        Loop
        CloseDataReader(dr)

        If blnPrinted Then
            Response.Write("</TR>" & vbCrLf)
            Response.Write("</TABLE>" & vbCrLf)
            Response.Write("</DIV>")
        End If

        Response.Flush()

    End Sub

    Private Sub DisplayNonNeedleGraphs(ByVal DashboardID As Long, ByVal UserID As Long, Optional ByVal DivHeight As Integer = 0, Optional ByVal SectionName As String = "")
        '=====================================================================
        ' Procedure Name        : DisplayNoNeedleGraphs()
        ' Purpose               : To display all the graphs for the dashboard
        ' Description           : The procedure displays all the graphs for the
        '                         dashboard
        ' Parameters Passed     : Dashboard ID, User ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Graph.dll
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim objQRB As QueryBuilder.cQuery
        Dim drGraphs As IDataReader
        Dim dr As IDataReader
        'Dim drDetails As IDataReader
        Dim intRowCount As Integer
        Dim blnShowDrillDowns As Boolean
        Dim blnOracleDB As Boolean = False
        Dim strSQL As String
        Dim strGraphSQL As String
        Dim myGraph As Graph.Graph
        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Dim strLeftSectionTitle As String = ""
        Dim strSectionTag As String = ""
        Dim strFunctionName As String = ""
        Dim blnPrinted As Boolean = False
        Dim intNoOfGraphElements As Integer = 5
        Dim lngConnectionID As Long
        Dim strConnectionString As String = ""
        Dim strImagePath As String

        ' create a collapsible section for the graph type
        strLeftSectionTitle = SectionName
        strFunctionName = "ShowHide_divOtherGraph"
        strSectionTag = "divOtherGraph"

        Response.Write("<BR>")
        If m_blnFromADMIN Then
            strSQL = "usp_CDB_Get_UserSettings " + m_lngDashboardID.ToString + "," + m_lngUserID.ToString + ",3,1,'" & m_strLoginType & "'"
        Else
            strSQL = "usp_CDB_Get_UserSettings " + m_lngDashboardID.ToString + "," + m_lngUserID.ToString + ",3,0,'" & m_strLoginType & "'"
        End If


        drGraphs = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        Do While drGraphs.Read
            If Not blnPrinted Then
                If m_blnShowOtherGraphs Then
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    'Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName))

                    m_strClientSideScript += "<script language=javascript>" + vbCrLf + "ShowOtherGraphs=1;" + vbCrLf + "" + vbCrLf + "</script>" + vbCrLf
                    If DivHeight > 0 Then
                        divGraphs.Attributes.Add("style", "overflow:auto;width:100%;height:" + DivHeight.ToString + "px")
                    Else
                        divGraphs.Attributes.Add("style", "overflow:auto;width:100%;" + vbCrLf)
                    End If
                Else
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    'Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , "../../images/plus.gif"))
                    m_strClientSideScript += "<script language=javascript>" + vbCrLf
                    m_strClientSideScript += "ShowOtherGraphs=0;" + vbCrLf + "" + vbCrLf
                    m_strClientSideScript += "</script>" + vbCrLf
                    If DivHeight > 0 Then
                        divGraphs.Attributes.Add("style", "overflow:auto;height:" + DivHeight.ToString + "px;display:none" + vbCrLf)
                    Else
                        divGraphs.Attributes.Add("style", "overflow:auto;display:none" + vbCrLf)
                    End If
                End If
                'Destroy the object
                cObjSectionTitle = Nothing
                blnPrinted = True
            End If

            If CInt(drGraphs.Item("GraphTypeID")) <> 1 Then
                With tblGraphs
                    If intRowCount = 0 Then
                        row = New HtmlTableRow
                        .Rows.Add(row)
                    End If
                    intRowCount += 1
                    ' add row cells
                    cell = New HtmlTableCell
                    cell.Attributes.Add("width", "100%")
                    cell.Attributes.Add("align", "center")
                    cell.Attributes.Add("Valign", "middle")
                    objQRB = New QueryBuilder.cQuery(Session("strUserName").ToString, CType(Session("intPostID"), Long), CType(Session("intUserID"), Long), Session("LoginType").ToString, CType(Session("intRoleLevel"), Integer), CType(Session("IsCreatedByCustomer"), Boolean))
                    objQRB.QueryID = CLng(drGraphs("QueryID"))
                    objQRB.UseSQL = m_blnUseSQL

                    ' ===============================================================
                    ' The ordering was done by second column DESC.
                    ' Modification: set the default order by clause only when the
                    ' order by clause iss not specified for the query
                    ' ===============================================================
                    If Trim(drGraphs("OrderByClause").ToString & "") = "" Then
                        ' no order by clause do the system default sorting
                        Try
                            strGraphSQL = objQRB.BuildQuery(ORDERBYClause:="2 Desc")
                        Catch
                            strGraphSQL = objQRB.BuildQuery(ORDERBYClause:="1 Desc")
                        End Try
                    Else
                        ' use the query as is
                        strGraphSQL = objQRB.BuildQuery()
                    End If
                    ' ===============================================================
                    ' ===============================================================
                    objQRB = Nothing

                    If Not IsDBNull(drGraphs("NoOfGraphElements")) Then
                        intNoOfGraphElements = CType(drGraphs("NoOfGraphElements"), Integer)
                    Else
                        intNoOfGraphElements = 5
                    End If

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason      - To get the decrypted connection string from hashtable instead of getting it from database.
                    '-------------------------------------------------------------------------------------------------------------
                    'drDetails = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID_ForQuery	" & CLng(drGraphs("QueryID")), m_blnUseSQL)
                    'If drDetails.Read Then
                    '    If IsDBNull(drDetails("ConnectionID")) Then
                    '        lngConnectionID = 0
                    '    Else
                    '        lngConnectionID = CType(drDetails("ConnectionID"), Long)
                    '    End If
                    'Else
                    '    lngConnectionID = 0
                    'End If
                    'CloseDataReader(drDetails)
                    'strConnectionString = GetConnectionString(lngConnectionID, blnOracleDB, m_blnUseSQL)

                    'lngConnectionID = QueryBuilder.WAFConnections.GetConnectionID(0, CLng(drGraphs("QueryID")), m_blnUseSQL)
                    'strConnectionString = QueryBuilder.WAFConnections.GetConnectionString(lngConnectionID, blnOracleDB)
                    ''-------------------------------------------------------------------------------------------------------------
                    ''-------------------------------------------------------------------------------------------------------------

                    'If Trim(strConnectionString & "") = "" Then strConnectionString = "" & CommonFunctions.Application.ConnectionString

                    'If blnOracleDB Then
                    '    strGraphSQL = "SELECT " & Right(Trim(strGraphSQL & ""), Len(Trim(strGraphSQL & "")) - 6)
                    '    strGraphSQL = "SELECT * From (" & strGraphSQL & ") Where RowNum < " & (intNoOfGraphElements + 1)
                    'Else
                    '    strGraphSQL = "SELECT TOP " & intNoOfGraphElements & "  " & Right(Trim(strGraphSQL & ""), Len(Trim(strGraphSQL & "")) - 6)
                    'End If

                    'If blnOracleDB Then
                    '    strGraphSQL = Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(strGraphSQL, "[", ""), "]", "")
                    'End If
                    'blnShowDrillDowns = CBool(drGraphs.Item("ShowDrillDowns"))
                    'If blnShowDrillDowns Then
                    '    If m_blnFromADMIN Then
                    '        strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Master  " & CType(drGraphs.Item("ItemID"), Long)
                    '    Else
                    '        strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Details  " & m_lngUserID & "," & CType(drGraphs.Item("ItemID"), Long) & ",'" & m_strLoginType & "'"
                    '    End If
                    '    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    '    If dr.Read Then
                    '        blnShowDrillDowns = True
                    '    Else
                    '        blnShowDrillDowns = False
                    '    End If
                    '    CloseDataReader(dr)
                    'End If

                    ' in case there is an error in the graph item dont add it
                    Try
                        ' adding the chart here by calling the function
                        cell.Controls.Add(CreateGraph(CType(drGraphs.Item("ItemID"), Long), strGraphSQL, m_intGraphHeight, m_intGraphWidth, blnShowDrillDowns, strConnectionString, Not blnOracleDB))
                        'End If
                    Catch exc As Exception
                        cell.Attributes.Add("class", "clsTDOdd")
                        cell.Attributes.Add("align", "center")
                        cell.Attributes.Add("border", "1")
                        cell.Attributes.Add("bordercolor", "black")
                        cell.InnerHtml = "<B>The graph was not generated</B>"
                    End Try
                    row.Cells.Add(cell)
                    If m_intNoOfGraphsPerRow = 1 OrElse intRowCount > 1 Then
                        intRowCount = 0
                    End If
                    cell.Dispose() : row.Dispose()
                End With

            End If
        Loop
        CloseDataReader(drGraphs)

        ' rendering the control at the position
        tblGraphs.Attributes.Add("Style", "")
        Dim SB As New System.Text.StringBuilder
        Dim SW As New System.IO.StringWriter(SB)
        Dim htmlTW As New HtmlTextWriter(SW)
        divGraphs.RenderControl(htmlTW)
        Dim HTML As String = SB.ToString()

        Response.Write(Microsoft.VisualBasic.Strings.Replace(HTML, "divGraphs", "divOtherGraph", , , Microsoft.VisualBasic.CompareMethod.Binary))

        ' hiding the rendered controls
        tblGraphs.Attributes.Add("style", "Display:None")
        divGraphs.Attributes.Add("style", "Display:None")

        SB = Nothing : SW = Nothing : htmlTW = Nothing

        Response.Flush()

    End Sub


    Private Sub DisplayNeedleGraph(ByVal ItemID As Long, ByVal EmployeeID As Long)
        '=====================================================================
        ' Procedure Name        : DisplayNeedleGraph()
        ' Description           : to display the needle graph 
        ' Purpose               : 
        ' Parameters Passed     : ItemID | the module id
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader
        Dim drDetail As IDataReader
        Dim intDrillDownsPresent As Integer = 0
        Dim strSQL As String
        Dim strFileName As String = ""
        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For resizing the CDB_Detail Window according to Existance of CT definition.
        '-------------------------------------------------------------------------------------------------------------
        Dim intShowCT As Integer = 1
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        Dim intDisplayType As Integer = 0 ' For CDB_CONFIG_DRILLDOWN_PK_13_AUG_2007: IssueID: 14839 & 14912

        If UCase(Trim(m_strFromWhere & "")) = "ADMIN" Then
            strSQL = "usp_Sel_tbl_CDB_Item_Master	NULL," & ItemID
        Else
            strSQL = "usp_Sel_tbl_CDB_Item_Details	" & m_lngDashboardID.ToString & "," & ItemID & "," & EmployeeID & ",'" & m_strLoginType & "'"
        End If


        ' getting the module details
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        ' creating the UI to display the graph
        If dr.Read Then
            Response.Write("<td Align=center valign=middle width='33.34%'>" & vbCrLf)
            Response.Write("<table class=clsTable border=0 cellPadding=0 cellSpacing=0 width=100% align=center>" & vbCrLf)
            Response.Write("<tr height=20px>" & vbCrLf)

            ' checking for drill downs
            If CType(dr("ShowDrillDowns"), Boolean) Then
                If UCase(Trim(m_strFromWhere & "")) = "ADMIN" Then
                    strSQL = "EXEC usp_Get_CDB_ItemDrillDowns " & ItemID & "," & EmployeeID & ",null,1,1"
                Else
                    strSQL = "EXEC usp_Get_CDB_ItemDrillDowns " & ItemID & "," & EmployeeID & ",null,1,0,'" + m_strLoginType + "'" 'SRID: 314
                End If
                drDetail = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If drDetail.Read Then
                    intDrillDownsPresent = 1
                Else
                    intDrillDownsPresent = 0
                End If
                drDetail = Nothing
            End If

            strFileName = CommonFunctions.FileDirectory.GetUniqueFileName("png")
            Dim objNeedleGraph As New WAFGauge.GaugeLibrary.GaugeGraph
            With objNeedleGraph
                .Interval = (CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphMaximumValue"), "10"), Integer) - CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphMinimumValue"), "10"), Integer)) Mod 10
                .Title = dr("ItemName").ToString + vbCrLf
                If Trim(dr("Nomenclature").ToString & "") <> "" Then
                    .Title = .Title + "(" + dr("Nomenclature").ToString + ")"
                Else
                    .Title = .Title + "."
                End If
                .TitleColor = "WHITE"
                .Nomenclature = ""
                .ImageType = "PNG"

                ' colors
                .AreaColor = "BLACK" : .BackColor = "SILVER"
                .CaptionColor = "YELLOW" : .FrameColor = "BLACK" : .FrameStyle = "SIMPLE"
                .NeedleColor = "AQUA" : .NeedleCapColor = "BLUE"

                ' ranges
                .RangeWidth = 55
                .RangeStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphMinimumValue"), "0"), Integer) : .RangeEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphMaximumValue"), "0"), Integer)
                .GreenRangeStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("NormalMinimumValue"), "0"), Integer) : .GreenRangeEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("NormalMaximumValue"), "0"), Integer)
                .RedRangeStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("DangerMinimumValue"), "0"), Integer) : .RedRangeEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("DangerMaximumValue"), "0"), Integer)
                .YellowRangeStart = CType(CommonFunctions.Data.CheckIsDBNull(dr("WarningMinimumValue"), "0"), Integer) : .YellowRangeEnd = CType(CommonFunctions.Data.CheckIsDBNull(dr("WarningMaximumValue"), "0"), Integer)

                ' needle
                .NeedleValue = GetNeedleValue(CType(CommonFunctions.Data.CheckIsDBNull(dr("QueryID"), "0"), Long))

                .Height = m_intGraphHeight : .Width = m_intGraphWidth
                .GlassEffect = False 'True
                .CreateNeedleGraph(Server.MapPath("../../Images" + "\" + strFileName), Server.MapPath("../../Images/"))
            End With
            objNeedleGraph.Dispose() : objNeedleGraph = Nothing

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - For resizing the CDB_Detail Window according to Existance of CT definition.
            '-------------------------------------------------------------------------------------------------------------
            intShowCT = 1
            If CType(CommonFunctions.Data.CheckIsDBNull((dr("XAxisAttribute")), ""), String) = "" Then
                intShowCT = 0
            End If
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------

            intDisplayType = 0
            If Trim(CStr(CommonFunctions.Data.CheckIsDBNull((dr("DisplayType")), ""))) <> "" Then
                intDisplayType = CInt(dr("DisplayType"))
                If intDisplayType <> 0 Then intShowCT = 0
            End If


            ' If the graph exists then showing it else showing the default graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath("../../Images" + "\" + strFileName)) Then
                Response.Write("</tr>" & vbCrLf)
                Response.Write("<tr>" & vbCrLf)
                '-------------------------------------------------------------------------------------------------------------
                'Reason      - Paramerter intShowCT is passed which will be used for Setting the size of the CDB_DrillDown window.
                '-------------------------------------------------------------------------------------------------------------

                Response.Write("<td bgcolor='black' valign=middle Align=center><a href='javascript:callDetail(" & ItemID & "," & intDrillDownsPresent & "," & intShowCT.ToString & "," & intDisplayType.ToString & ")'><img border=0  src='../../images" + "\" + strFileName + "' title=" & Chr(34) & Server.HtmlEncode(Trim(dr("FooterNote").ToString & "")) & "  Please click the item to view details..." & Chr(34) & "></a></td>" & vbCrLf)
            Else
                Response.Write("</tr>" & vbCrLf)
                Response.Write("<tr>" & vbCrLf)
                Response.Write("<td Valign=middle Align=center height=" + m_intGraphHeight.ToString + " width=" + m_intGraphWidth.ToString + "><a href='javascript:callDetail(" & ItemID & "," & intDrillDownsPresent & "," & intShowCT.ToString & "," & intDisplayType.ToString & ")'><font face=verdana style='TEXT-DECORATION:none' color=white><B>The needle graph could not be generated</B></font></A></td>" & vbCrLf)

                '-------------------------------------------------------------------------------------------------------------
                '-------------------------------------------------------------------------------------------------------------
            End If
            Response.Write("</tr>" & vbCrLf)
            Response.Write("</table>" & vbCrLf)
            Response.Write("</td>" & vbCrLf)
        End If

        ' closing the record set object
        CommonFunctions.Data.DisposeDataReader(dr)
        Response.Flush()
    End Sub


    Private Function GetNeedleValue(ByVal QueryID As Long) As Double
        '=====================================================================
        ' Procedure Name        : GetNeedleValue()
        ' Purpose               : To get the needle value by executing the query
        ' Description           : Same as above
        ' Parameters Passed     : Query ID
        ' Returns               : Double result value
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objQRB As QueryBuilder.cQuery
        Dim strSQL As String

        ' get the query for the user
        objQRB = New QueryBuilder.cQuery(HttpContext.Current.Session("strUserName").ToString, CType(HttpContext.Current.Session("intPostID"), Long), CType(HttpContext.Current.Session("intUserID"), Long), HttpContext.Current.Session("LoginType").ToString, CType(HttpContext.Current.Session("intRoleLevel"), Integer), CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean))
        objQRB.QueryID = QueryID : objQRB.UseSQL = m_blnUseSQL
        strSQL = objQRB.BuildQuery()
        objQRB = Nothing

        GetNeedleValue = 0
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            Try
                ' take the first value of the query as the needle value
                GetNeedleValue = CType(CommonFunctions.Data.CheckIsDBNull(dr(0), "0"), Double)
            Catch ex As Exception
                ' do nothing - let the value be 0
            End Try
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

#End Region

#Region "Other graphs"
    Private Function CreateGraph(ByVal ItemID As Long, ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ShowDrillDowns As Boolean, ByVal ConnectionString As String, ByVal UseSQL As Boolean, Optional ByRef ImagePath As String = "") As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : Graph Control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strBorderStyle As String = ""
        Dim strBorderColor As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim intUCL As Double = 0
        Dim intLCL As Double = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim intGraphID As Integer
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For resizing the CDB_Detail Window according to Existance of CT definition.
        '-------------------------------------------------------------------------------------------------------------
        Dim intShowCT As Integer = 0
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        Dim intDisplayType As Integer = 0

        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For Adding extra item level properties. 
        '-------------------------------------------------------------------------------------------------------------
        Dim blnShowDrillDownLinkOnGrapthTitle As Boolean = True
        Dim blnShowPointValuesOnGraph As Boolean = True
        Dim intXAxisLabelStyle As Integer = 0
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For Adding extra item level properties. 
        '-------------------------------------------------------------------------------------------------------------
        Dim intLegendStyle As Integer = 0
        Dim intChartAreaWidth As Integer = 75
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------



        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        Dim blnShowHover As Boolean = True
        'check the application settings for hover on graphs
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("EnableHoverForCDBMain")
        If Not objFrameworkSetting Is Nothing Then
            If objFrameworkSetting.ValidateStatus() = True Then
                If UCase(Trim(objFrameworkSetting.Status & "")) = "Y" Then
                    blnShowHover = True
                Else
                    blnShowHover = False
                End If
            Else
                blnShowHover = False
            End If
        End If
        objFrameworkSetting = Nothing

        ' get the item details
        If m_blnFromADMIN Then
            strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem " & m_lngDashboardID & "," & ItemID & ",null,null,1"
        Else
            strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem  " & m_lngDashboardID & "," & ItemID & "," & m_lngUserID & ",'" & m_strLoginType & "'"
        End If

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strItemName = dr("ItemName").ToString : strBorderStyle = dr("BorderStyle").ToString
            strBorderColor = dr("BorderColor").ToString : strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString : strCaptionColor = dr("CaptionColor").ToString
            strTitleColor = dr("TitleColor").ToString
            If Not IsDBNull(dr("UCL")) Then
                intUCL = CType(dr("UCL"), Double)
            End If
            strUCLColor = dr("UCLColor").ToString
            If Not IsDBNull(dr("LCL")) Then
                intLCL = CType(dr("LCL"), Double)
            End If
            strLCLColor = dr("LCLColor").ToString
            If Not IsDBNull(dr("ShowLegends")) Then
                blnShowLegends = CType(dr("ShowLegends"), Boolean)
            End If
            If Not IsDBNull(dr("ShowExplodedPie")) Then
                blnShowExplodedPie = CType(dr("ShowExplodedPie"), Boolean)
            End If
            intGraphID = CType(dr("GraphTypeID"), Integer)

            If Not IsDBNull(dr("Enable3D")) Then
                blnEnable3D = CType(dr("Enable3D"), Boolean)
            End If
            lngEntityID = CType(dr("EntityID"), Long)
            strNomenclature = dr("Nomenclature").ToString
            strPieLabelStyle = dr("PieLabelStyle").ToString

            If Not IsDBNull(dr("XAxisMin")) Then
                intXAxisMin = CType(dr("XAxisMin"), Long)
            End If
            If Not IsDBNull(dr("XAxisMax")) Then
                intXAxisMax = CType(dr("XAxisMax"), Long)
            End If
            If Not IsDBNull(dr("XAxisInterval")) Then
                intXAxisInterval = CType(dr("XAxisInterval"), Long)
            End If

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - For resizing the CDB_Detail Window according to Existance of CT definition.
            '-------------------------------------------------------------------------------------------------------------
            intShowCT = 0
            If CType(CommonFunctions.Data.CheckIsDBNull((dr("XAxisAttribute")), ""), String) <> "" Then
                If CType(CommonFunctions.Data.CheckIsDBNull((dr("YAxisAttribute")), ""), String) <> "" Then
                    intShowCT = 1
                End If
            End If
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------


            If Trim(CStr(CommonFunctions.Data.CheckIsDBNull((dr("DisplayType")), ""))) <> "" Then
                intDisplayType = CInt(dr("DisplayType"))
                If intDisplayType <> 0 Then intShowCT = 0
            End If

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - For Adding extra item level properties. 
            '-------------------------------------------------------------------------------------------------------------
            If Not IsDBNull(dr("ShowDrillDownLinkOnGrapthTitle")) Then
                blnShowDrillDownLinkOnGrapthTitle = CBool(CommonFunctions.General.CheckIsNothing(dr("ShowDrillDownLinkOnGrapthTitle"), "True"))
            End If
            If Not IsDBNull(dr("ShowPointValuesOnGraph")) Then
                blnShowPointValuesOnGraph = CBool(CommonFunctions.General.CheckIsNothing(dr("ShowPointValuesOnGraph"), "True"))
            End If
            If Not IsDBNull(dr("XAxisLabelStyle")) Then
                intXAxisLabelStyle = CInt(CommonFunctions.General.CheckIsNothing(dr("XAxisLabelStyle"), "0"))
            End If
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - For Adding extra item level properties. 
            '-------------------------------------------------------------------------------------------------------------
            If Not IsDBNull(dr("LegendStyle")) Then
                intLegendStyle = CInt(CommonFunctions.General.CheckIsNothing(dr("LegendStyle"), "0"))
            End If
            If Not IsDBNull(dr("ChartAreaWidth")) Then
                intChartAreaWidth = CInt(CommonFunctions.General.CheckIsNothing(dr("ChartAreaWidth"), "75"))
                If intChartAreaWidth < 70 Then intChartAreaWidth = 70
                If intChartAreaWidth > 95 Then intChartAreaWidth = 95
            End If
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------
        End If

        CloseDataReader(dr)

        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        ' create the grpah for the item values
        objGraph = New Graph.Graph

        '-------------------------------------------------------------------------------------------------------------
        'Reason      - Instead of firing graph-query twise, we will get the dataset and use it for getting chart-type,
        '               as well as for Graph-Objects DataSource.
        '-------------------------------------------------------------------------------------------------------------
        'objGraph.ExternalDBConnectionString = ConnectionString
        'objGraph.ExternalDBUseSQL = UseSQL
        'objGraph.UseSQL = m_blnUseSQL
        'objGraph.ConnectionString = CommonFunctions.Application.ConnectionString
        'objGraph.SQL = SQL

        Dim intUBound As Integer
        Dim dsForGraph As DataSet
        Dim strConnString As String
        Dim blnUseSQL As Boolean = True
        If Trim(CommonFunctions.General.CheckIsNothing(ConnectionString)) <> "" Then
            strConnString = ConnectionString
            blnUseSQL = UseSQL
        Else
            strConnString = CommonFunctions.Application.ConnectionString
            blnUseSQL = m_blnUseSQL
        End If
        ''Added By Vaijat K ON 01/03/2016 
        If Request.QueryString IsNot Nothing Then
            If Request.QueryString("TabID") = 3 Then
                SQL = "usp_Sel_DefectDensity " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & "," & Request.QueryString("Snapshot") & "," & Session("intUserID")
            ElseIf Request.QueryString("TabID") = 4 Then
                SQL = "usp_GetReworkHours_Quickview " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & "," & Request.QueryString("Snapshot") & "," & Session("intUserID")
            ElseIf Request.QueryString("TabID") = 5 Then
                'SQL = "usp_Sel_TotalNoOfDeliverables_Quickview " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & "," & Request.QueryString("Snapshot") & "," & Request.QueryString("GraphTypeID")
                SQL = "usp_Sel_TotalNoOfDeliverables_Quickview " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & "," & Request.QueryString("Snapshot") & "," & Session("intUserID")
            ElseIf Request.QueryString("TabID") = 6 Then
                SQL = "usp_Sel_TotalNoOfDeliverablesOpen " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & ""
            ElseIf Request.QueryString("TabID") = 7 Then
                SQL = "usp_Sel_TotalNoOfDeliverablesClosed " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & ""
            ElseIf Request.QueryString("TabID") = 8 Then
                SQL = "usp_sel_ScheduleSlippage " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & ",'" & Request.QueryString("Attribute") & "'," & Request.QueryString("Snapshot") & "," & Session("intUserID")
            ElseIf Request.QueryString("TabID") = 2 Then
                SQL = "usp_UD_Sel_OnTimedelivery " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & "," & Request.QueryString("Snapshot") & "," & Session("intUserID")
            ElseIf Request.QueryString("TabID") = 1 Then
                SQL = "usp_Sel_Effort_Variance_Quickview " & CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), 0) & ",'" & Request.QueryString("Attribute") & "'," & Request.QueryString("Snapshot") & "," & Session("intUserID")
            ElseIf Request.QueryString("TabID") = 0 Then
                SQL = "usp_sel_tbl_SV_Temp "
            End If
        End If
        ''Ended


        dsForGraph = CommonFunctions.Data.GetDataSet(SQL, "default", , , blnUseSQL, strConnString)
        intUBound = dsForGraph.Tables(0).Columns.Count()
        'objGraph.ChartType = GetChartType(ItemID, SQL, intGraphID, UseSQL, ConnectionString)
        'If Request.QueryString("TabID") = 0 Then
        '    objGraph.ChartType = GetChartType(ItemID, intUBound, intGraphID)
        'Else
        objGraph.ChartType = GetChartTypeForOther(Request.QueryString("GraphTypeID"))
        'End If
        objGraph.DataSet = dsForGraph
        dsForGraph.Dispose() : dsForGraph = Nothing
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------
        If Request.QueryString("TabID") = 6 Then
            'objGraph.EnableXAxis = True
            'objGraph.XAxisTitle = ""
        End If
        objGraph.VirtualImagePath = "../../Images/" : objGraph.Enable3D = blnEnable3D
        'objGraph.BorderStyle = strBorderStyle
        'objGraph.GraphTitle = strItemName : objGraph.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
        'objGraph.GraphTitleColor = strTitleColor
        objGraph.Width = Width : objGraph.Height = Height
        'objGraph.ShowExplodedPie = blnShowExplodedPie : objGraph.ChartBackColor = strChartBackColor
        If strChartAreaColor = "" Then
            objGraph.ChartAreaColor = "RoyalBlue"
        Else
            objGraph.ChartAreaColor = strChartAreaColor
        End If

        objGraph.PalleteStyle = m_strPalleteStyle

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For Adding extra item level properties. 
        '-------------------------------------------------------------------------------------------------------------
        If Not (intGraphID = GRAPH_TYPE_DOUGHNUT Or intGraphID = GRAPH_TYPE_PIE) Then
            objGraph.ShowCaptions = False
            objGraph.XAxisLabelStyle = intXAxisLabelStyle
        End If
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        '-------------------------------------------------------------------------------------------------------------
        'Reason   - For Adding extra item level properties. 
        '-------------------------------------------------------------------------------------------------------------
        objGraph.LegendDocking = GetLegendDocking(intLegendStyle)
        objGraph.LegendStyle = GetLegendArrangement(intLegendStyle)
        If Request.QueryString("GraphTypeID") = 12 Then
            objGraph.ChartAreaWidth = 100
        Else
            objGraph.ChartAreaWidth = intChartAreaWidth
        End If
        If intChartAreaWidth > 75 Then
            objGraph.ChartAreaPlotWidth = 80
        End If
        If objGraph.ChartAreaWidth > 75 Then
            objGraph.ChartAreaPlotWidth = 100
        End If
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------


        'If Not (intGraphID = 2 Or intGraphID = 7) Then 

        objGraph.LegendColor = GetColor(ItemID, intGraphID)


        ' End If


        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)

        If strCaptionColor = "" Then
            objGraph.LegendCaptionColor = "Black"
            objGraph.LegendBorderColor = "Black"
        Else
            objGraph.LegendCaptionColor = strCaptionColor
            objGraph.LegendBorderColor = strCaptionColor
        End If
        If strBorderColor = "" Then
            objGraph.BorderColor = "Black"
        Else
            objGraph.BorderColor = strBorderColor
        End If

        objGraph.ShowLegends = True
        objGraph.BorderGradientColor = "WHITE"
        objGraph.BorderGradientStyle = "TOPBOTTOM"
        objGraph.ChartBackGradientColor = "WHITE"
        objGraph.ChartBackGradientStyle = "TOPBOTTOM"
        objGraph.ChartAreaGradientColor = "WHITE"
        If objGraph.ChartType(0) = "PIE" Or objGraph.ChartType(0) = "DOUGHNUT" Then
            objGraph.ChartAreaGradientStyle = "CENTER"
        Else
            objGraph.ChartAreaGradientStyle = "TOPBOTTOM"
        End If
        objGraph.PieChartLabelStyle = strPieLabelStyle


        ' if drill downs are present?
        'If ShowDrillDowns Then
        '    If blnShowHover Then
        '        objGraph.DrillDownHoverPage = "CDB_DrillDown_Hover.aspx?DashboardID=" & m_lngDashboardID & "&FromWhere=" & m_strFromWhere & "&ItemID=" + ItemID.ToString + "&"
        '    End If
        '    '-------------------------------------------------------------------------------------------------------------

        '    'Reason      - Paramerter intShowCT is passed which will be used for Setting the size of the CDB_DrillDown window.
        '    '-------------------------------------------------------------------------------------------------------------
        '    objGraph.DrillDownClientSideFunctionName = "DrillDown_OnClick(" + intDisplayType.ToString() + "," + intShowCT.ToString + "," + ItemID.ToString + ","
        '    '-------------------------------------------------------------------------------------------------------------

        '    '-------------------------------------------------------------------------------------------------------------
        'End If
        objGraph.EntityID = lngEntityID : objGraph.Nomenclature = ""
        If intGraphID <> 5 Then
            objGraph.LCL = intLCL : objGraph.LCLColor = strLCLColor
            objGraph.UCL = intUCL : objGraph.UCLColor = strUCLColor
        End If

        objGraph.YAxisMin = intXAxisMin
        If intXAxisMax <> 0 Then
            objGraph.YAxisMax = intXAxisMax
        End If
        If intXAxisInterval <> 0 Then
            objGraph.YAxisInterval = intXAxisInterval
        End If
        objGraph.XAxisInterval = 1

        objGraph.MapAreaTooltip = "click here to view details"


        'If ShowDrillDowns AndAlso blnShowDrillDownLinkOnGrapthTitle Then


        '    '-------------------------------------------------------------------------------------------------------------
        '    'Reason      - Paramerter intShowCT is passed which will be used for Setting the size of the CDB_DrillDown window.
        '    '-------------------------------------------------------------------------------------------------------------


        '    objGraph.MapAreaHREF = "javascript:callDetail(" & ItemID & ",1," + intShowCT.ToString + "," + intDisplayType.ToString() + ")"
        'Else
        '    objGraph.MapAreaHREF = "javascript:callDetail(" & ItemID & ",0," + intShowCT.ToString + "," + intDisplayType.ToString() + ")"


        '    '-------------------------------------------------------------------------------------------------------------

        '    '-------------------------------------------------------------------------------------------------------------
        'End If

        '*************************************************

        '*************************************************
        If intGraphID = GRAPH_TYPE_STACKEDCOLUMN OrElse intGraphID = GRAPH_TYPE_STACKEDBAR OrElse intGraphID = GRAPH_TYPE_STACKEDAREA Then
            ' stacked graphs
            CreateGraph = objGraph.GenerateStackedGraphControl()
        Else
            CreateGraph = objGraph.GenerateChartControl()
        End If
        objGraph = Nothing
        '*************************************************

        '*************************************************

    End Function

    '   R.No:WAF3_CDB_7
    ' Added Param graph type
    Private Function GetColor(ByVal ItemID As Long, ByVal GraphType As Integer) As String()
        '=====================================================================
        ' Procedure Name        : GetColor
        ' Purpose               : To get the colors the sql
        ' Description           : 
        ' Parameters Passed     : item id
        ' Returns               : arr of string for color
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim intCount As Integer
        Dim arr() As String = {}

        strSQL = "usp_CDB_GetPaletteColors " + ItemID.ToString + "," _
                                             + m_lngUserID.ToString + ",'" _
                                             + CommonFunctions.General.BuildQueryString(m_strLoginType) + "'"
        If m_blnFromADMIN Then : strSQL += ",1" : End If

        ' for graphs other than pie/doughnut first color is not required
        If Not (GraphType = GRAPH_TYPE_PIE Or GraphType = GRAPH_TYPE_DOUGHNUT) Then
            ReDim Preserve arr(0) : arr(0) = ""
            intCount = 1
        End If

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arr(intCount) : arr(intCount) = dr("ColorName").ToString
            intCount += 1
        Loop
        CommonFunctions.Data.DisposeDataReader(dr)

        GetColor = arr
        arr = Nothing

    End Function
    ''Added By Vaijat K ON 01/03/2016 For GraphType
    Private Function GetChartTypeForOther(ByVal intTypeID As Integer)
        Dim arr(2) As String
        Select Case intTypeID
            Case GRAPH_TYPE_PIE : arr(0) = "PIE" : arr(1) = "PIE" : arr(2) = "PIE"
            Case 3 : arr(0) = "COLUMN" : arr(1) = "COLUMN" : arr(2) = "COLUMN"
            Case 4 : arr(0) = "LINE" : arr(1) = "LINE" : arr(2) = "LINE"
            Case 5 : arr(0) = "BAR" : arr(1) = "BAR" : arr(2) = "BAR"
            Case 6 : arr(0) = "STEPLINE" : arr(1) = "STEPLINE" : arr(2) = "STEPLINE"
            Case GRAPH_TYPE_DOUGHNUT : arr(0) = "DOUGHNUT" : arr(1) = "DOUGHNUT" : arr(2) = "DOUGHNUT"
            Case 8 : arr(0) = "CANDLESTICK" : arr(1) = "CANDLESTICK" : arr(2) = "CANDLESTICK"
            Case 9 : arr(0) = "SPLINE" : arr(1) = "SPLINE" : arr(2) = "SPLINE"
            Case 10 : arr(0) = "SPLINEAREA" : arr(1) = "SPLINEAREA" : arr(2) = "SPLINEAREA"
            Case 11 : arr(0) = "AREA" : arr(1) = "AREA" : arr(2) = "AREA"
            Case 12 : arr(0) = "RADAR" : arr(1) = "RADAR" : arr(2) = "RADAR"
            Case 13 : arr(0) = "STACKEDCOLUMN" : arr(1) = "STACKEDCOLUMN" : arr(2) = "STACKEDCOLUMN"
            Case 14 : arr(0) = "STACKEDBAR" : arr(1) = "STACKEDBAR" : arr(2) = "STACKEDBAR"
            Case 15 : arr(0) = "STACKEDAREA" : arr(1) = "STACKEDAREA" : arr(2) = "STACKEDAREA"
            Case GRAPH_TYPE_BUBBLE : arr(0) = "BUBBLE" : arr(1) = "BUBBLE" : arr(2) = "BUBBLE"
            Case GRAPH_TYPE_POINT : arr(0) = "POINT" : arr(1) = "POINT" : arr(2) = "POINT"
            Case Else : arr(0) = "COLUMN" : arr(1) = "COLUMN" : arr(2) = "COLUMN"
        End Select
        Return arr
    End Function
    'Ended



    'Private Function GetChartType(ByVal ItemID As Long, ByVal strSQL As String, ByVal intGraphID As Integer, ByVal UseSQL As Boolean, ByVal ConnectionString As String) As String()
    Private Function GetChartType(ByVal ItemID As Long, ByVal intUBound As Integer, ByVal intGraphID As Integer) As String()
        '=====================================================================
        ' Procedure Name        : GetChartType
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             : 1
        ' Modified              : 
        ' Modification          : Instead of firing the passed query of graph here in the function,
        '                         we will pass the UBound for the column count. Hence the signature
        '                         of this private function is changed.
        '=====================================================================
        Dim intX As Integer

        Dim dr As IDataReader
        Dim arr() As String = {}
        Dim intCount As Integer = 1
        Dim arrGraph() As String = {}

        '-------------------------------------------------------------------------------------------------------------
        'Reason       - The passed wuery and dataset will not be used. Instead UBound for the column count will be used.
        '-------------------------------------------------------------------------------------------------------------

        'Dim ds As DataSet
        'Dim intUBound As Integer
        'ds = CommonFunctions.Data.GetDataSet(strSQL, "default", , , UseSQL, ConnectionString)
        'intUBound = ds.Tables(0).Columns.Count()
        'ds.Dispose() : ds = Nothing

        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        Dim strSQL As String = ""

        If m_blnFromADMIN Then
            strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + ItemID.ToString
        Else
            strSQL = "usp_sel_tbl_CDB_Item_Series_Detail " + ItemID.ToString + "," + m_lngUserID.ToString + ",'" + m_strLoginType + "'"
        End If
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arrGraph(intCount)
            arrGraph(intCount) = dr("GraphID").ToString
            intCount += 1
        Loop
        CloseDataReader(dr)

        Select Case intGraphID
            Case 2 'pie
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "PIE"
                Next
                Return arr
            Case 3 ' column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                                arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                            Else
                                arr(intX) = "COLUMN"
                            End If
                        Else
                            arr(intX) = "COLUMN"
                        End If
                    Else
                        arr(intX) = "COLUMN"
                    End If
                Next
                Return arr
            Case 4 ' line
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "LINE"
                        End If
                    Else
                        arr(intX) = "LINE"
                    End If
                Next
                Return arr
            Case 5 ' bar
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "BAR"
                Next
                Return arr
            Case 6 ' step
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STEPLINE"
                        End If
                    Else
                        arr(intX) = "STEPLINE"
                    End If
                Next
                Return arr
            Case 7 ' doughnut
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "DOUGHNUT"
                Next
                Return arr

            Case 8 ' CandleStick
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "CANDLESTICK"
                        End If
                    Else
                        arr(intX) = "CANDLESTICK"
                    End If
                Next
                Return arr

            Case 9 ' Spline
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINE"
                        End If
                    Else
                        arr(intX) = "SPLINE"
                    End If
                Next
                Return arr
            Case 10 ' Splin area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINEAREA"
                        End If
                    Else
                        arr(intX) = "SPLINEAREA"
                    End If
                Next
                Return arr

            Case 11 ' Area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "AREA"
                        End If
                    Else
                        arr(intX) = "AREA"
                    End If
                Next
                Return arr
            Case 12 ' radar
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "RADAR"
                Next
                Return arr
                '*************************************************
                '*************************************************
            Case GRAPH_TYPE_STACKEDCOLUMN
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STACKEDCOLUMN"
                        End If
                    Else
                        arr(intX) = "STACKEDCOLUMN"
                    End If
                Next
                Return arr
            Case GRAPH_TYPE_STACKEDBAR
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STACKEDBAR"
                        End If
                    Else
                        arr(intX) = "STACKEDBAR"
                    End If
                Next
                Return arr
            Case GRAPH_TYPE_STACKEDAREA
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STACKEDAREA"
                        End If
                    Else
                        arr(intX) = "STACKEDAREA"
                    End If
                Next
                Return arr
                '*************************************************
                '*************************************************
                '*************************************************
                '*************************************************
            Case GRAPH_TYPE_BUBBLE
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "BUBBLE"
                        End If
                    Else
                        arr(intX) = "BUBBLE"
                    End If
                Next
                Return arr
            Case GRAPH_TYPE_POINT
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "POINT"
                        End If
                    Else
                        arr(intX) = "POINT"
                    End If
                Next
                Return arr
                '*************************************************
                '*************************************************
            Case Else
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "COLUMN"
                Next
                Return arr
        End Select
    End Function

    Private Function GetChartName(ByVal intGraphID As Integer) As String
        '=====================================================================
        ' Procedure Name        : GetChartName
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================

        Select Case intGraphID
            Case GRAPH_TYPE_PIE : Return "PIE"
            Case 3 : Return "COLUMN"
            Case 4 : Return "LINE"
            Case 5 : Return "BAR"
            Case 6 : Return "STEPLINE"
            Case GRAPH_TYPE_DOUGHNUT : Return "DOUGHNUT"
            Case 8 : Return "CANDLESTICK"
            Case 9 : Return "SPLINE"
            Case 10 : Return "SPLINEAREA"
            Case 11 : Return "AREA"
            Case 12 : Return "RADAR"
                '*************************************************
                '*************************************************
            Case 13 : Return "STACKEDCOLUMN"
            Case 14 : Return "STACKEDBAR"
            Case 15 : Return "STACKEDAREA"
                '*************************************************
                '*************************************************
                '*************************************************
                '*************************************************
            Case GRAPH_TYPE_BUBBLE : Return "BUBBLE"
            Case GRAPH_TYPE_POINT : Return "POINT"
                '*************************************************
                '*************************************************
            Case Else : Return "COLUMN"
        End Select
    End Function

    Private Sub SetGraphSettings()
        '=====================================================================
        ' Procedure Name        : SetGraphSettings
        ' Purpose               : To get the pallete style to be applied
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_CDB_DashboardSettings " & m_lngDashboardID & "," & m_lngUserID & ",'" & m_strLoginType & "'", m_blnUseSQL)
        If dr.Read Then
            m_strPalleteStyle = dr("PalleteStyle").ToString
            m_intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphHeight").ToString, "0"), Integer)
            m_intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphWidth").ToString, "0"), Integer)
            If Not IsDBNull(dr("NoOfGraphsPerRow")) Then
                m_intNoOfGraphsPerRow = CType(dr("NoOfGraphsPerRow"), Int16)
            End If
        End If
        CloseDataReader(dr)
    End Sub
#End Region

#Region "General"
    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()
        ' Purpose               : To initialize the module variables 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader

        If Not Request.QueryString("DashboardID") Is Nothing Then
            m_lngDashboardID = CType(Request.QueryString("DashboardID"), Long)
        End If
        If Not Request.QueryString("DisplayAlertID") Is Nothing Then
            m_lngDisplayAlertID = CType(Request.QueryString("DisplayAlertID"), Long)
        Else
            m_lngDisplayAlertID = 0
        End If
        If Not Request.QueryString("sortby") Is Nothing Then
            ' ***********************************************************************************
            ' ***********************************************************************************
            m_strSortBy = HttpUtility.HtmlEncode(Request.QueryString("sortby"))
        End If
        If Not Request.QueryString("sortorder") Is Nothing Then
            ' ***********************************************************************************
            ' ***********************************************************************************
            m_strSortOrder = HttpUtility.HtmlEncode(Request.QueryString("sortorder"))
        End If
        If Not Request.QueryString("Mode") Is Nothing Then
            ' *********************************************************************************** 
            ' ***********************************************************************************
            'm_strMode = HttpUtility.HtmlEncode(Request.QueryString("Mode").ToString)  MODIFIED BY PUNEET M ON 02-09-2015
            If Request.QueryString("Mode") Is Nothing Then
                m_strMode = Request.QueryString("Mode") + ""
            Else
                m_strMode = HttpUtility.HtmlEncode(Request.QueryString("Mode").ToString)
            End If
        End If
        If Not Request.QueryString("FromWhere") Is Nothing Then
            ' ***********************************************************************************
            ' ***********************************************************************************
            'm_strFromWhere = HttpUtility.HtmlEncode(Request.QueryString("FromWhere").ToString)     ''' MODIFIED BY PUNEET M ON 02-09-2015
            If Request.QueryString("FromWhere") Is Nothing Then
                m_strSortOrder = Request.QueryString("FromWhere") + ""
            Else
                m_strSortOrder = HttpUtility.HtmlEncode(Request.QueryString("FromWhere").ToString)
            End If
        End If
        If Trim(m_strFromWhere & "").ToUpper = "ADMIN" Then
            m_blnFromADMIN = True
        Else
            m_blnFromADMIN = False
        End If

        If Not Request.QueryString("ShowNeedleGraphs") Is Nothing Then
            m_blnShowNeedleGraphs = CType(Request.QueryString("ShowNeedleGraphs"), Boolean)
        End If

        If Not Request.QueryString("ShowOtherGraphs") Is Nothing Then
            m_blnShowOtherGraphs = CType(Request.QueryString("ShowOtherGraphs"), Boolean)
        End If

        If Not Request.QueryString("ShowMyQueries") Is Nothing Then
            m_blnShowMyQueries = CType(Request.QueryString("ShowMyQueries"), Boolean)
        End If
        If Not Request.QueryString("ShowDescriptiveAlert") Is Nothing Then
            m_blnShowDescriptiveAlert = CType(Request.QueryString("ShowDescriptiveAlert"), Boolean)
        End If
        m_lngUserID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = CommonFunctions.General.CheckIsNothing(Session("LoginType"), "E") 'SRID: 314
        m_lngPostID = CType(Session("intPostID"), Long)
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)


        '-------------------------------------------------------------------------------------------------------------
        'Reason      - For Dashboard Deletion. Added "If" condition to prevent database trips, when there is no default dashboard.
        '-------------------------------------------------------------------------------------------------------------

        If CommonFunctions.General.CheckIsNothing(m_lngDashboardID, "0") <> "0" Then

            ' set the DB settings
            dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_DashboardDetails " + m_lngDashboardID.ToString, m_blnUseSQL)
            If dr.Read Then
                If Not IsDBNull(dr("DashboardType")) Then
                    m_strAccess = dr("DashboardType").ToString
                Else
                    m_strAccess = "FULL_ACCESS"
                End If
                If Not IsDBNull(dr("PalleteStyle")) Then
                    m_strPalleteStyle = dr("PalleteStyle").ToString
                Else
                    m_strPalleteStyle = "EARTHTONES"
                End If

                If Not IsDBNull(dr("GraphHeight")) Then
                    m_intGraphHeight = CType(dr("GraphHeight"), Integer)
                Else
                    m_intGraphHeight = 260
                End If

                If Not IsDBNull(dr("GraphWidth")) Then
                    m_intGraphWidth = CType(dr("GraphWidth"), Integer)
                Else
                    m_intGraphWidth = 492
                End If

                m_strFromPage = Trim(dr("PageName").ToString & "") + "?DashboardID=" + m_lngDashboardID.ToString

                ' for CDB_SHOW_HIDE_DB_COMBO
                If Not IsDBNull(dr("HideDBCombo")) Then
                    m_blnHideDBCombo = CBool(dr("HideDBCombo"))
                End If
                ' for CDB_SHOW_HIDE_DB_COMBO

                If Not IsDBNull(dr("NoOfGraphsPerRow")) Then
                    m_intNoOfGraphsPerRow = CType(dr("NoOfGraphsPerRow"), Int16)
                End If

            End If
            CloseDataReader(dr)

            ' set the grpah settings
            If Not m_blnFromADMIN Then
                SetGraphSettings()
            End If

        Else
            m_blnIsDBIdZero = True
            m_strFromPage = "../CDB/CDB_Main.aspx?DashboardID=0"
        End If
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------

        If CommonFunctions.General.GetFrameworkSettings("GEN_ACTION_NAVIGATION_DROPDOWNMENU", "Enabled") = False Then
            m_blnIsDropdownMenuEnabled = False
        Else
            m_blnIsDropdownMenuEnabled = True
        End If

    End Sub

    Private Sub WriteMenu()
        '=====================================================================
        ' Procedure Name        : WriteMenu()	
        ' Purpose               : To write the menu for the page based on mode 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================

        'Added Link - Graph Skins

        If m_blnFromADMIN Then
            ' for admin only addition of graphs is provided

            ' for adding MENU_PALETTE,PALETTE,Palette_OnClick()
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SECTION"), _
            MyBase.GetResourceString("MENU_LINKS"), _
            MyBase.GetResourceString("MENU_ALERTS"), _
            MyBase.GetResourceString("MENU_GRAPHS"), _
            MyBase.GetResourceString("MENU_PALETTES"), _
            MyBase.GetResourceString("MENU_GRAPHSKINS"), _
            MyBase.GetResourceString("MENU_CLOSE"), _
            MyBase.GetResourceString("MENU_HELP")}

            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SECTION_TOOLTIP"), _
            MyBase.GetResourceString("MENU_LINKS_TOOLTIP"), _
            MyBase.GetResourceString("MENU_ALERTS_TOOLTIP"), _
            MyBase.GetResourceString("MENU_GRAPHS_TOOLTIP"), _
            MyBase.GetResourceString("MENU_PALETTES_TOOLTIP"), _
            MyBase.GetResourceString("MENU_GRAPHSKINS_TOOLTIP"), _
            MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
            MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

            Dim arrCSFunction() As String = {"Set_Sections_OnClick(" + m_lngDashboardID.ToString + ")", _
            "Set_Links_OnClick(" + m_lngDashboardID.ToString + ")", _
            "Set_Alerts_OnClick(" + m_lngDashboardID.ToString + ")", _
            "Set_Graphs_OnClick(" + m_lngDashboardID.ToString + ")", _
            "Palette_OnClick()", _
            "SetGraphSkin()", _
            "Close_OnClick()", _
            "Help_OnClick('CDB_GENERAL')"}

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - To show Images for static menu. 
            '-------------------------------------------------------------------------------------------------------------
            Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/sections.gif", _
            "../../Images/cssImages/Link images/links.gif", _
            "../../Images/cssImages/Link images/alerts.gif", _
            "../../Images/cssImages/Link images/graph.gif", _
            "../../Images/cssImages/Link images/palette.gif", _
            "../../Images/cssImages/Link images/palette.gif", _
            "../../Images/cssImages/Link images/close.gif", _
            "../../Images/cssImages/Link images/help.gif"}
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - To show Images for static menu, added parameter - arrImagePaths
            '-------------------------------------------------------------------------------------------------------------

            If m_blnIsDropdownMenuEnabled = False Then
                Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, , , arrImagePaths))
            Else
                Dim arrSeparator() As Boolean = {True, True, True, True, True, True, True, False}
                Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, "", "", arrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 120, arrSeparator))
                arrSeparator = Nothing
            End If

            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------

            '-------------------------------------------------------------------------------------------------------------
            'Reason   - Set the arrays to nothing. 
            '-------------------------------------------------------------------------------------------------------------
            arrMenu = Nothing
            arrMenuToolTip = Nothing
            arrCSFunction = Nothing
            arrImagePaths = Nothing
            '-------------------------------------------------------------------------------------------------------------
            '-------------------------------------------------------------------------------------------------------------
        Else
            ' plot the menu based on the access
            Select Case m_strAccess.ToUpper
                Case "FULL_ACCESS", "READ_ONLY_WITH_ITEM_ADDITION"
                    ' for adding MENU_PALETTE,PALETTE,Palette_OnClick()
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SETTINGS"), _
                    MyBase.GetResourceString("MENU_SECTION"), _
                    MyBase.GetResourceString("MENU_LINKS"), _
                    MyBase.GetResourceString("MENU_ALERTS"), _
                    MyBase.GetResourceString("MENU_GRAPHS"), _
                    MyBase.GetResourceString("MENU_PALETTES"), _
                    MyBase.GetResourceString("MENU_GRAPHSKINS"), _
                    MyBase.GetResourceString("MENU_HELP")}

                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SETTINGS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_SECTION_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_LINKS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_ALERTS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_GRAPHS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_PALETTES_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_GRAPHSKINS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

                    Dim arrCSFunction() As String = {"Settings_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Sections_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Links_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Alerts_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Graphs_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Palette_OnClick()", _
                    "SetGraphSkin()", _
                    "Help_OnClick('CDB_GENERAL')"}
                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/config.gif", _
                    "../../Images/cssImages/Link images/sections.gif", _
                    "../../Images/cssImages/Link images/links.gif", _
                    "../../Images/cssImages/Link images/alerts.gif", _
                    "../../Images/cssImages/Link images/graph.gif", _
                    "../../Images/cssImages/Link images/palette.gif", _
                    "../../Images/cssImages/Link images/palette.gif", _
                    "../../Images/cssImages/Link images/help.gif"}
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - To show Images for static menu, added parameter - arrImagePaths
                    '-------------------------------------------------------------------------------------------------------------
                    If m_blnIsDropdownMenuEnabled = False Then
                        Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, , , arrImagePaths))
                    Else
                        Dim arrSeparator() As Boolean = {True, True, True, True, True, True, True, False}
                        Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, "", "", arrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 120, arrSeparator, "", "", "", 27))
                        arrSeparator = Nothing
                    End If
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - Set the arrays to nothing. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrMenu = Nothing
                    arrMenuToolTip = Nothing
                    arrCSFunction = Nothing
                    arrImagePaths = Nothing
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                Case "READ_ONLY"
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_HELP")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                    Dim arrCSFunction() As String = {"Help_OnClick('CDB_GENERAL')"}
                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/help.gif"}
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - To show Images for static menu, added parameter - arrImagePaths
                    '-------------------------------------------------------------------------------------------------------------

                    If m_blnIsDropdownMenuEnabled = False Then
                        Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, , , arrImagePaths))
                    Else
                        Dim arrSeparator() As Boolean = {False}
                        Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, "", "", arrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 120, arrSeparator, "", "", "", 27))
                        arrSeparator = Nothing
                    End If

                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - Set the arrays to nothing. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrMenu = Nothing
                    arrMenuToolTip = Nothing
                    arrCSFunction = Nothing
                    arrImagePaths = Nothing
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                Case Else

                    ' for adding MENU_PALETTE,PALETTE,Palette_OnClick()
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SETTINGS"), _
                    MyBase.GetResourceString("MENU_SECTION"), _
                    MyBase.GetResourceString("MENU_LINKS"), _
                    MyBase.GetResourceString("MENU_ALERTS"), _
                    MyBase.GetResourceString("MENU_GRAPHS"), _
                    MyBase.GetResourceString("MENU_PALETTES"), _
                    MyBase.GetResourceString("MENU_GRAPHSKINS"), _
                    MyBase.GetResourceString("MENU_HELP")}

                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SETTINGS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_SECTION_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_LINKS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_ALERTS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_GRAPHS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_PALETTES_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_GRAPHSKINS_TOOLTIP"), _
                    MyBase.GetResourceString("MENU_HELP_TOOLTIP")}

                    Dim arrCSFunction() As String = {"Settings_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Sections_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Links_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Alerts_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Set_Graphs_OnClick(" + m_lngDashboardID.ToString + ")", _
                    "Palette_OnClick()", _
                    "SetGraphSkin()", _
                    "Help_OnClick('CDB_GENERAL')"}

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/config.gif", _
                    "../../Images/cssImages/Link images/sections.gif", _
                    "../../Images/cssImages/Link images/links.gif", _
                    "../../Images/cssImages/Link images/alerts.gif", _
                    "../../Images/cssImages/Link images/graph.gif", _
                    "../../Images/cssImages/Link images/palette.gif", _
                    "../../Images/cssImages/Link images/palette.gif", _
                    "../../Images/cssImages/Link images/help.gif"}
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - To show Images for static menu, added parameter - arrImagePaths
                    '-------------------------------------------------------------------------------------------------------------
                    If m_blnIsDropdownMenuEnabled = False Then
                        Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, , , arrImagePaths))
                    Else
                        Dim arrSeparator() As Boolean = {True, True, True, True, True, True, True, False}
                        Response.Write(WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, "", "", arrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 120, arrSeparator, "", "", "", 27))
                        arrSeparator = Nothing
                    End If

                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------

                    '-------------------------------------------------------------------------------------------------------------
                    'Reason   - Set the arrays to nothing. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrMenu = Nothing
                    arrMenuToolTip = Nothing
                    arrCSFunction = Nothing
                    arrImagePaths = Nothing
                    '-------------------------------------------------------------------------------------------------------------
                    '-------------------------------------------------------------------------------------------------------------
            End Select
        End If



        Response.Flush()
    End Sub

    Private Sub DisplayNoItemMessage()
        '=====================================================================
        ' Procedure Name        : DisplayNoItemMessage()
        ' Purpose               : To display the msg that no items are configured
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String = ""

        ' check for existence of items on the DB
        If m_blnFromADMIN Then
            strSQL = "usp_sel_CDB_ItemAvailableStatus " & m_lngDashboardID & ",null,null,1"
        Else
            strSQL = "usp_sel_CDB_ItemAvailableStatus " & m_lngDashboardID & "," & m_lngUserID & ",'" & m_strLoginType & "',0"
        End If
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            If CType(dr("AreItemsAvailable"), Boolean) = False Then

                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_ITEM_MSG"))
            End If
        End If
        CloseDataReader(dr)
    End Sub

    Private Sub CloseDataReader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : CloseDataReader
        ' Purpose               : To close the datareader object
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

    Private Sub DisplaySetDefaultLink(ByVal DashboardID As Long, ByVal UserID As Long)
        '=====================================================================
        ' Procedure Name        : DisplaySetDefaultLink()
        ' Purpose               : Writes the "Set as Default" link if a CDB
        ' Description           : if the DB is not user-specific link is missing
        ' Parameters Passed     : Dashboard ID, User ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_CDB_Get_DashboardDetails,usp_Sel_tbl_CDB_DefaultDashboard
        ' Author                : Vaijat
        ' Created               : March 07,2016
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim blnDBExists As Boolean


        '-------------------------------------------------------------------------------------------------------------
        'Reason       - User can set System Dashboard as default, if she wishes.
        '-------------------------------------------------------------------------------------------------------------
        '' if the DB is a CDB and its not created by the current user (is a global DB)exit
        'dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_DashboardDetails  " & DashboardID, True)
        'If dr.Read Then
        '    If Not CType(dr("IsStatic"), Boolean) And Trim(dr("EmployeeID").ToString & "") = "" Then
        '        CloseDataReader(dr)
        '        Exit Sub
        '    End If
        'End If
        'CloseDataReader(dr)
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------


        ' setting to false
        blnDBExists = False
        ' checking if the user has a default Db 
        dr = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_CDB_DefaultDashboard	" & UserID, True)
        If dr.Read Then
            If CType(dr("DashboardID"), Long) = DashboardID Then
                ' User HAS an EXISTING default DB 
                blnDBExists = True
            Else
                ' no default DB 	
                blnDBExists = False
            End If
        Else
            ' no default DB, 
            blnDBExists = False
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        ' writing the link here
        Response.Write("<td align=right>")
        ' no based on the blnDBExists flag we show the link

        Response.Write(GetRefreshLink("Refresh_OnClick"))

        Response.Write(GetDefaultDashboardLink(Not blnDBExists, "SetDefaultDashboard"))
        Response.Write("</td>" & vbCrLf)

        Response.Flush()
    End Sub
    Public Shared Function GetRefreshLink(ByVal JSFunctionName As String) As String
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : GetRefreshLink
        ' Requirement Tag       : CDB_CONFIG_DRILLDOWN_PK : IssueID: 14381
        ' Description           : Returns the HTML for Refresh Link
        ' Parameters Passed     : JSFunctionName [String]
        ' Returns               : String
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : Vaijat
        ' Created On            : March 07,2016
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        Dim sb As New StringBuilder()

        Dim objWhizTemplate As New WebPages.Template.WhizTemplate()
        objWhizTemplate.InitializeResources("Resources.CDB_Main", "Resources")

        sb.Append("<a class='clsReset' href='JavaScript:")
        JSFunctionName = CommonFunctions.General.CheckIsNothing(JSFunctionName)
        If JSFunctionName <> "" Then JSFunctionName = "Refresh_OnClick"
        sb.Append(JSFunctionName)
        sb.Append("()' >")
        sb.Append(vbCrLf)
        sb.Append(objWhizTemplate.GetResourceString("LINK_REFRESH"))
        sb.Append("</a>")

        GetRefreshLink = sb.ToString()
        objWhizTemplate.Dispose() : objWhizTemplate = Nothing
        sb = Nothing
    End Function
    Public Shared Function GetDefaultDashboardLink(ByVal SetDefaultFlag As Boolean, ByVal JSFunctionName As String) As String
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : GetDefaultDashboardLink
        ' Requirement Tag       : CDB_CONFIG_DRILLDOWN_PK : Set Default Custom Dashboard
        ' Description           : Returns the HTML for Set/Reset Default Dashboard Link
        ' Parameters Passed     : ResetDefaultFlag [Boolean], JSFunctionName [String]
        ' Returns               : String
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : Vaijat
        ' Created On            : March 07,2016
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        Dim sb As New StringBuilder()

        Dim objWhizTemplate As New WebPages.Template.WhizTemplate()
        objWhizTemplate.InitializeResources("Resources.CDB_Main", "Resources")

        sb.Append("<a class='clsReset' href='JavaScript:")
        JSFunctionName = CommonFunctions.General.CheckIsNothing(JSFunctionName)
        If JSFunctionName <> "" Then JSFunctionName = "SetDefaultDashboard"
        sb.Append(JSFunctionName)
        If SetDefaultFlag Then
            sb.Append("(1)' title='")
            sb.Append(objWhizTemplate.GetResourceString("TOOL_TIP_SET_DEFAULT")) 'Set as default dashboard..
            sb.Append("'>")
            sb.Append(vbCrLf)
            sb.Append(objWhizTemplate.GetResourceString("LINK_SET_DEFAULT")) '| Set As Default Dashboard |
            sb.Append("</a>")
        Else
            sb.Append("(0)' title='")
            sb.Append(objWhizTemplate.GetResourceString("TOOL_TIP_RESET_DEFAULT")) 'Reset the default dashboard..
            sb.Append("'>")
            sb.Append(vbCrLf)
            sb.Append(objWhizTemplate.GetResourceString("LINK_RESET_DEFAULT")) '| Reset Default Dashboard |
            sb.Append("</a>")
        End If

        GetDefaultDashboardLink = sb.ToString()
        objWhizTemplate.Dispose() : objWhizTemplate = Nothing
        sb = Nothing
    End Function
    Public Shared Sub SetResetDefaultDashboard(ByVal SetDefaultFlag As Boolean, ByVal UserID As Long, ByVal LoginType As String, Optional ByVal DashboardID As Long = 0)
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : SetResetDefaultDashboard
        ' Requirement Tag       : CDB_CONFIG_DRILLDOWN_PK : Set Default Custom Dashboard
        ' Description           : Sets/Resets the default dashboard.
        ' Parameters Passed     : DashboardID, UserID, LoginType.
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : Vaijat
        ' Created On            : March 07,2016
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        Dim blnUseSQL As Boolean = CBool(CommonFunctions.General.GetApplicationKeySetting("UseSQL"))
        CommonFunctions.Data.InsertOrUpdateData("EXEC usp_Del_tbl_CDB_DefaultDashboard	" + UserID.ToString + ",'" + CommonFunctions.General.BuildQueryString(LoginType) + "'", blnUseSQL)
        If SetDefaultFlag AndAlso DashboardID <> 0 Then
            ' setting the current dashboard as default
            CommonFunctions.Data.InsertOrUpdateData("EXEC usp_Ins_tbl_CDB_DefaultDashboard  " + UserID.ToString + "," + DashboardID.ToString + ",'" + CommonFunctions.General.BuildQueryString(LoginType) + "'", blnUseSQL)
        End If

    End Sub

#Region ""
    'Private Function GetConnectionString(ByVal lngConnectionID As Long, ByRef IsOracle As Boolean, ByVal UseSQL As Boolean) As String
    '    '=====================================================================
    '    ' Procedure Name        : GetConnectionString()	
    '    ' Description           : To get the connection info. for conn. id.
    '    ' Purpose               : To get the connection info. for conn. id.
    '    ' Parameters Passed     : ByVal Connection ID,ByRef Database type, BYval UseSQL (true/false)
    '    ' Returns               : connection string
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : usp_sel_tbl_QRB_Connection_Master
    '    ' Author                : Vaijat
    '    ' Created               : March 07,2016
    '    ' Revisions             :
    '    '=====================================================================
    '    If lngConnectionID <> 0 Then
    '        Dim dr As IDataReader
    '        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Connection_Master " + lngConnectionID.ToString, UseSQL)
    '        If dr.Read Then
    '            GetConnectionString = dr("ConnectionString").ToString
    '            If dr("DatabaseType").ToString.Trim.ToUpper = "S" Then
    '                IsOracle = False
    '            Else
    '                IsOracle = True
    '            End If
    '        Else
    '            GetConnectionString = ""
    '        End If
    '        CloseDataReader(dr)
    '    Else
    '        GetConnectionString = ""
    '    End If

    'End Function
#End Region

#End Region

#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    '============================================================================================================================
    ' Added By                  :	
    ' Purpose                   :   Not to allow to modify Favorite queries shared by another user
    ' Added                     :	
    ' IssueID                   :
    '=============================================================================================================================
    Private Sub objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objGrid.DataRowTD_BeforePrint
        If Args.DataField = "QueryName" Then
            If Args.DataReader("ShowEnable").ToString.ToUpper = "FALSE" Then
                Args.EnableLink = False
            End If
        End If
    End Sub
    '============================================================================================================================
    ' To set the paging alphabet
    '=============================================================================================================================

    Public Shared Function GetLegendDocking(ByVal LegendStyle As Integer) As String
        Return CStr(IIf(LegendStyle <= 2, "RIGHT", "BOTTOM"))
    End Function
    Public Shared Function GetLegendArrangement(ByVal LegendStyle As Integer) As String
        Select Case LegendStyle
            Case 0, 3
                Return "COLUMN"
            Case 1, 4
                Return "ROW"
            Case 2, 5
                Return "TABLE"
            Case Else
                Return "COLUMN"
        End Select
    End Function

End Class
