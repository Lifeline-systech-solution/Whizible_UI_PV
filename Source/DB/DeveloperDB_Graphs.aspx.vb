Public Class DeveloperDB_Graphs
    Inherits WebPages.Template.WhizTemplate

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
    '-- Module Level variables/Constants

    Private m_blnUseSQL As Boolean
    Private m_strNotSpecified, m_strPageTitle As String
    Private m_strMode, m_strGraph As String
    Private m_intProjectID As Integer
    Private Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"
    Private m_intGraphWidth, m_intGraphHeight As Integer
    Private m_intUserID As Long


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        '================== FOR TESTING ============================
        m_strMode = "TaskDistribution"
        m_intGraphWidth = 600
        m_intGraphHeight = 300
        '============================================================

        m_intUserID = CType(Session("intUserID"), Long)

        'Put user code to initialize the page here
        Call Initialize()

        '-- Caption for Page

        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
    End Sub

    Public Sub DrawPage()
        Dim strMenu, strPageCaption As String
        Dim cObjPageCaption As New WebPage.Templates.PageCaption

        strMenu = PrepareMenu()
        Response.Write(strMenu + "<br>")
        MyBase.InitializeResources("AppResources.DeveloperDB_Graphs", "AppResources")

        Response.Write("<DIV ID='DivList' style='overflow:auto'>")
       
        Select Case m_strMode
            Case "MyPerformance"
                strPageCaption = MyBase.GetResourceString("PAGE_CAPTION_PERF")
                CommonFunction.General.WriteHTML(cObjPageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") & " for ", , , True) + vbCrLf)
                cObjPageCaption = Nothing

                'Call DrawExpected_Vs_ActualGraph()


            Case "TaskDistribution"
                strPageCaption = MyBase.GetResourceString("PAGE_CAPTION_TASKDIST")
                CommonFunction.General.WriteHTML(cObjPageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") & " for " + CommonFunctions.General.CheckIsNothing(Session("strUserName"), "").ToString, , , True) + vbCrLf)
                cObjPageCaption = Nothing

                Call CreateTaskDistribution()

            Case Else
        End Select

        Response.Write("</TR>")
        Response.Write("</TABLE>")

        Response.Write("</DIV>")

        Response.Write("<br>" + strMenu)

    End Sub

    Private Sub CreateTaskDistribution()
        '-- Graph
        Dim strSQLQuery, strGRID As String
        Dim drGetEmployeeInfo As IDataReader
        Dim dblTotalHours As Double
        Dim strFileName, strStatus As String

        '-- For Grid
        Dim arrstrActualList() As String = {"Title", "Hours"}
        Dim arrstrUserFriendlyList() As String = {"Task Type", "Work (hrs)"}
        Dim arrstrSummaryFunctions() As String = {"", "SUM"}

        '-- Draw User Controls
        strSQLQuery = "EXEC usp_DB_TaskDistribution " + Session("intUserID").ToString
        strFileName = "TaskDistribution" + m_intUserID.ToString
        ' If any option is selected, then...
        If CommonFunctions.General.CheckIsNothing(Request.Form("optWeek")) <> "" Then
            strSQLQuery = strSQLQuery + "," & CommonFunctions.General.CheckIsNothing(Request.Form("optWeek"))

            If CommonFunctions.General.CheckIsNothing(Request.Form("optWeek")) = "3" Then

                ' From Date.
                If CommonFunctions.General.CheckIsNothing(Request.Form("txtFromDate")) <> "" Then
                    strSQLQuery = strSQLQuery + ", '" + CommonFunctions.General.CheckIsNothing(Request.Form("txtFromDate")) + "'"
                Else
                    strSQLQuery = strSQLQuery + ", NULL"
                End If

                ' To Date.
                If CommonFunctions.General.CheckIsNothing(Request.Form("txtToDate")) <> "" Then
                    strSQLQuery = strSQLQuery + ", '" + CommonFunctions.General.CheckIsNothing(Request.Form("txtToDate")) + "'"
                Else
                    strSQLQuery = strSQLQuery + ", NULL"
                End If

            End If

        End If

        drGetEmployeeInfo = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
        dblTotalHours = 0
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<TABLE Class=clsTable Width=99.9%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<TR Class=clsTROdd>")
        Response.Write("<TD>")
        ' Get the total hours worked in the selected week.
        Do While drGetEmployeeInfo.Read
            dblTotalHours = dblTotalHours + CType(CommonFunctions.Data.CheckIsDBNull(drGetEmployeeInfo("Hours"), "0"), Double)
        Loop

        ' If the total hours worked in previous week is greater than 0 then show pie chart. 
        '-- Generate Graph Image
        If dblTotalHours > 0 Then

            Call CreateGraph(strSQLQuery, "PIE", strFileName, MyBase.GetResourceString("TASK_DISTRIBUTION"), 2)
            ' If the total hours worked in previous week is 0 then show bar graph. 
        Else
            strFileName = ""
        End If

        '--Option Buttons for 1. Prev. Week 2) This Week 3) Date Range
        strStatus = ""
        If CommonFunctions.General.CheckIsNothing(Request.Form("optWeek")) = "" Or CommonFunctions.General.CheckIsNothing(Request.Form("optWeek")) = "2" Then strStatus = " checked "
        CommonFunctions.HTMLControls.DrawOptionButton("optWeek", "optPreviousWeek", , , "2", , strStatus + " onclick='Week_OnClick()'")
        Response.Write("<font size=1>" + MyBase.GetResourceString("PREVIOUS_WEEK") + "</font>")

        strStatus = ""
        If CommonFunctions.General.CheckIsNothing(Request.Form("optWeek")) = "1" Then strStatus = " checked "
        CommonFunctions.HTMLControls.DrawOptionButton("optWeek", "optCurrentWeek", , , "1", , strStatus + " onclick='Week_OnClick()'")
        Response.Write("<font size=1>" + MyBase.GetResourceString("THIS_WEEK") + "</font>")

        strStatus = ""
        If Request.Form("optWeek") = "3" Then strStatus = " checked "
        CommonFunctions.HTMLControls.DrawOptionButton("optWeek", "optDateRange", , , "3", , strStatus + " onclick='optDateRange_OnClick()' ")

        strStatus = ""
        Response.Write("<font size=1>" + MyBase.GetResourceString("DATE_RANGE") + "</font>")
        If Request.Form("optWeek") <> "3" Then strStatus = " style='display:none' "
        Response.Write("<label id=cellDateRange " + strStatus + ">")

        Response.Write("&nbsp;<font size=1>| From ")
        CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , CommonFunctions.General.CheckIsNothing(Request.Form("txtFromDate")), , "frmDBGraphs")
        Response.Write("&nbsp;To ")
        CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , CommonFunctions.General.CheckIsNothing(Request.Form("txtToDate")), , "frmDBGraphs")

        Response.Write("<a style='TEXT-DECORATION: none' HREF='javascript:Week_OnClick()'><font Size=1 Face=verdana color=black><b> Show</b></font>")
        Response.Write("</a>|</font></label>")

        Response.Write("</TD></TR><TR class=clsTREven Width=100%><TD align=center>")
        '-- Now Display Graph Image
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
            Response.Write("<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If

        Response.Write("</TD><TR>")
        Response.Write("<TR class=clsTREven><TD Width=100% Align=center>")

        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        '--Columns in the Grid
        With objGrid
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            '.TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .SQL = strSQLQuery
            .ShowSummaryFunctions = True
            .SummaryFunctions = arrstrSummaryFunctions
            .DIVHeight = 0
            .returnHTML = True
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</TR>")

        objGrid = Nothing

    End Sub
    Private Sub CreateGraph(ByVal strSQLQueryForGraph As String, ByVal strChartType As String, ByVal strImageFileName As String, ByVal strGraphTitle As String, ByVal intNoOfColumns As Integer)
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Noveber 07,2003
        ' Revisions             : 
        '=====================================================================
        Dim objGraph As Graph.Graph

        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = True
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath, strPalleteStyle As String

        Dim i As Integer


        '-- Setting some main Graph Properties

        '-- Build Array for specifying the Chart Type for each column
        ReDim arrstrChartType(intNoOfColumns - 1)
        For i = 0 To intNoOfColumns - 1
            arrstrChartType(i) = strChartType
        Next

        blnShowLegends = True
        'blnEnable3D = True
        strNomenclature = "Test"

        ' create the graph for the item values
        objGraph = New Graph.Graph
        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString

            .VirtualImagePath = ""
            .Enable3D = blnEnable3D
            .ChartType = arrstrChartType 'GetChartType(ItemID, SQL, m_intGraphID, m_blnUseSQL)
            .ShowExplodedPie = blnShowExplodedPie
            .BorderStyle = "FrameTitle5"
            .GraphTitle = strGraphTitle
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .GraphTitleColor = "white"
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .ShowExplodedPie = False
            .ChartBackColor = "PaleGoldenRod"
            strPalleteStyle = "EARTHTONES"
            .ChartAreaColor = "GoldenRod"
            .PalleteStyle = strPalleteStyle

            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .LegendCaptionColor = "black"
            .BorderColor = "Blue"
            .ShowLegends = blnShowLegends
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .SQL = strSQLQueryForGraph
            '.XAxisFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
            '.XAxisFontAngle = 90
            'objGraph.ChartAreaAutoPosition = True

            ' return the graph control
            .GenerateImage()
        End With

        objGraph = Nothing
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page
        ' Description           : Also gets the various User Preferences from the Database
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : SuryabirD
        ' Created               : Jan 5th, 2004
        ' Revisions             : 
        '=====================================================================
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        m_strNotSpecified = MyBase.GetResourceString("NOT_SPECIFIED")
        m_intProjectID = CType(Session("intProjectID"), Integer)
        m_strMode = Request.QueryString("Mode")
    End Sub

    Private Function PrepareMenu() As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : Function used to draw the Botom menu..
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('PROJECT_GRAPHS')"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu


    End Function

    Public Sub PlotHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Public Sub New()

        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.DeveloperDB_Graphs", "AppResources")

    End Sub
End Class
