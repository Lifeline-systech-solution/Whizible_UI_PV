Option Explicit On
Imports Whizible

Public Class MetricSpecificGraphs
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

        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
        InitializeComponent()
    End Sub

#End Region
#Region "Variable Declaration"
    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private ObjSectionTitle As WebPage.Templates.SectionTitle

    Private m_strProjectID As String = ""
    Private m_strMetricID As String = ""
    Private m_strMasterRecID As String = ""
    Private m_strMode As String = ""
    Private m_strImageName As String
    Private m_strMonthFrom As String = ""
    Private m_strMonthTo As String = ""

    Private strMetricName As String = ""

    Public Const PAGE_CAPTION As String = "Metric Specific Graphs"
    Public Const DETAILS_HEADER As String = "Metric Specific Graphs"
    Public Const MSG_NO_RECORDS = "There are no items to show in this view."
    Public Const PAGE_HEADER As String = "Metric Specific Graphs"
    Protected m_strHeaderTables As New System.Text.StringBuilder

#End Region
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Public Sub DrawPage()
        Initializations()

        PlotHead()
        'Drawing Top Menu

        CommonFunctions.General.WriteHTML(PrepareMenu())
        CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML("<DIV id='divPage' Style='overflow:auto;height:20%;width:100%;'>")
        'Drawing the page title
        PlotHeader()
        'Drawing the Sections
        'CommonFunctions.General.WriteHTML("<BR>")
        'Drawing the Metric Info Grid

        CommonFunctions.General.WriteHTML(PlotMetricInfoHeader())


        If m_strMode = "PH" Or m_strMode = "MO" Or m_strMode = "DL" Or m_strMode = "ML" Or m_strMode = "SP" Then
            '  CommonFunctions.General.WriteHTML("<DIV id='divMain' Style='overflow:auto;height:60%;width:100%;'>")
            DrawGraphSection()
            '   CommonFunctions.General.WriteHTML("</DIV>")                     'End of divMain
            DrawRelatedDataSection()
            'SrikanthY on 08 Aug 2007, Added Below code to show Datapoint graphs at Below project level , for whizible metrics
        ElseIf m_strMode = "PHDP" Or m_strMode = "MLDP" Or m_strMode = "DLDP" Then
            DrawGraphSection()
            DrawRelatedDataPointSection()
        End If
        'End of addition by SrikanthY on 08 Aug 2007
        ' CommonFunctions.General.WriteHTML("</DIV>")         'End of divPage
        CommonFunctions.General.WriteHTML("<BR>")

        'Drawing Bottom Menu
        CommonFunctions.General.WriteHTML(PrepareMenu())

    End Sub

    Private Sub Initializations()
        Dim strGetToAndFrmMonthsQuery As String
        Dim drToFromMonths As IDataReader
        Dim intCnt As Integer = 0

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterRecID"), "") <> "" Then
            m_strMasterRecID = Request.QueryString("MasterRecID")
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("For"), "") <> "" Then
            m_strMode = Request.QueryString("For")
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("MetricID"), "") <> "" Then
            m_strMetricID = Request.QueryString("MetricID")
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Graph"), "") <> "" Then
            m_strImageName = Request.QueryString("Graph")
        End If

        'Getting the From Month and To month from the SP used for displaying the graph
        strGetToAndFrmMonthsQuery = "usp_Sel_MetricValue_For_Metric '" & m_strMode & "', " & m_strMasterRecID & ", " & m_strMetricID & ", 1, " & Session("intProjectID").ToString
        drToFromMonths = CommonFunctions.Data.GetDataReader(strGetToAndFrmMonthsQuery, True)
        Do While drToFromMonths.Read
            If intCnt = 0 Then
                m_strMonthTo = drToFromMonths(0)
            End If
            m_strMonthFrom = drToFromMonths(0)
            intCnt = intCnt + 1
        Loop

    End Sub

    Public Sub PlotHead()
        '=====================================================================
        ' Procedure Name        : PlotHead
        ' Purpose               : To plot the Header of the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Jan 11, 2006
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.PlotPageHeadTag(PAGE_HEADER)

    End Sub

    Public Sub PlotHeader()
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
        Dim strQuery As String = ""
        Dim strDynPageTitle As String = ""
        Dim strPrjName As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        Dim drProject As IDataReader

        If m_strMode = "PRPH" Then
            strDynPageTitle = "Phase Wise"
        ElseIf m_strMode = "PRMO" Then
            strDynPageTitle = "Module Wise"
        ElseIf m_strMode = "PH" Or m_strMode = "PHDP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT Phase FROM tbl_IB_Project_Phases WHERE ProjectPhaseID = " & m_strMasterRecID
            strQuery = "usp_sel_tbl_IB_Project_Phases_Phase1 " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = strMetricName & " Graph for Phase -" & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        ElseIf m_strMode = "MO" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT ModuleName FROM tbl_PM_Module WHERE ModuleID = " & m_strMasterRecID
            strQuery = "usp_sel_tbl_PM_Module_MD " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = strMetricName & " Graph for Module - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        ElseIf m_strMode = "ML" Or m_strMode = "MLDP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' strQuery = "SELECT Milestone FROM tbl_PM_Milestones WHERE MilestoneID = " & m_strMasterRecID
            strQuery = "usp_sel_tbl_PM_Milestones_Milestone " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = strMetricName & " Graph for Milestone - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        ElseIf m_strMode = "DL" Or m_strMode = "DLDP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT Title FROM tbl_PM_OtherSchedules WHERE ScheduleID = " & m_strMasterRecID
            strQuery = "usp_sel_tbl_PM_OtherSchedules_TitleMaster " & m_strMasterRecID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = strMetricName & " Graph for Deliverable - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        ElseIf m_strMode = "SP" Then

            'strQuery = "SELECT SubProjectName FROM tbl_PM_SubProjects WHERE SubProjectID = " & m_strMasterRecID
            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = strMetricName & " Graph for SubProject - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'strDynPageTitle = strDynPageTitle & " For the Period From " & m_strMonthFrom & " To " & m_strMonthTo

        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        objHeaderFooter.HeaderFooter = "<B>" & strDynPageTitle & "</B>"
        strHTML = objHeaderFooter.DrawHeaderFooter(, True)
        If strHTML <> "" Then
            CommonFunctions.General.WriteHTML(strHTML)
        End If
    End Sub

    Private Function PrepareMenu() As String
        '=====================================================================
        ' Procedure Name        : PrepareMenu
        ' Purpose               : To draw the Menu
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : String which contains the HTML Code for plotting 
        '                            the menu
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Jan 11, 2006
        ' Revisions             :
        '=====================================================================
        Dim strMenu As String
        If m_strMode = "PRPH" Or m_strMode = "PRMO" Then
            Dim arrMenu() As String = {"Phases", "Modules", "Close", " ? "}
            Dim arrMenuToolTip() As String = {"Phases", "Modules", "Close", "Help"}
            Dim arrClientSideFunctions() As String = {"PhasesMenu_OnClick(" & m_strProjectID & ")", "ModulesMenu_OnClick(" & m_strProjectID & ")", "Close_OnClick()", "Help_OnClick()"}
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Else
            Dim arrMenu() As String = {"Close", " ? "}
            Dim arrMenuToolTip() As String = {"Close", "Help"}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick()"}
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        End If
        Return strMenu
    End Function
    Private Function PlotMetricInfoHeader() As String
        Dim strQueryForMetricInfo As String
        Dim drMetricInfo As IDataReader
        Dim strHTML As String
        Dim intColCnt As Integer = 0

        strQueryForMetricInfo = "usp_Sel_MetricInfo " & m_strMetricID & ", " & m_strMasterRecID & ", '" & m_strMode & "'"

        If m_strMode = "PHDP" Then
            strQueryForMetricInfo = " usp_Sel_MeasurementInfo  " & m_strMetricID & ", " & m_strMasterRecID & ", 'PH'"
        ElseIf m_strMode = "MLDP" Then
            strQueryForMetricInfo = " usp_Sel_MeasurementInfo  " & m_strMetricID & ", " & m_strMasterRecID & ", 'ML'"
            ''Added by GokulP on 21 Jan 2010 for Deliverable Graph
        ElseIf m_strMode = "DLDP" Then
            strQueryForMetricInfo = " usp_Sel_MeasurementInfo  " & m_strMetricID & ", " & m_strMasterRecID & ", 'DL'"
            ''End of Addition by GokulP on 21 Jan 2010 for Deliverable Graph
        End If

        drMetricInfo = CommonFunctions.Data.GetDataReader(strQueryForMetricInfo, True)
        strHTML = "<TABLE class= clsTable width = 100% height= 80px>"
        Do While drMetricInfo.Read
            While intColCnt < drMetricInfo.FieldCount
                strHTML = strHTML & "<TR class=clsTRSectionHeader>"
                strHTML = strHTML & "<TD align=left width=25%>"
                strHTML = strHTML & drMetricInfo.GetName(intColCnt)
                strHTML = strHTML & "</TD>"
                'strHTML = strHTML & "<TD width= 15px>"
                'strHTML = strHTML & "</TD>"
                strHTML = strHTML & "<TD align=left>"
                strHTML = strHTML & drMetricInfo(intColCnt)
                strHTML = strHTML & "</TD>"
                strHTML = strHTML & "</TR>"
                intColCnt = intColCnt + 1
            End While
        Loop
        strHTML = strHTML & "</TABLE>"


        PlotMetricInfoHeader = strHTML
    End Function
    Private Sub DrawGraphSection()
        Dim strQuery As String
        Dim strImageName As String
        Dim drSingleRec As IDataReader
        Dim blnhasRows As Boolean = False
        CommonFunctions.General.WriteHTML("<TABLE id='Table3' cellspacing='0' cellpadding='0' Width='99.9%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRPageCaption'>")
        CommonFunctions.General.WriteHTML("<TD align='Left'>Graph</TD></TR></Table>")

        'CommonFunctions.General.WriteHTML("<div style='height=260px  width=100%'>")
        CommonFunctions.General.WriteHTML("<TABLE class= clsTable width=100%>")
        CommonFunctions.General.WriteHTML("<TR>")
        CommonFunctions.General.WriteHTML("<td align=center>")
        'Foursoft Customization Chabge image path from Images to Images/Metrics
        CommonFunctions.General.WriteHTML("<IMG  border=0 src='../../Images/Metrics/" & m_strImageName & ".png'>")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>") '</div>")
    End Sub

    Private Sub DrawRelatedDataSection()
        Dim objSection As New Whiz.WebPage.Templates.SectionTitle
        Dim m_objGrid As New WebPages.Template.GenericGrid
        Dim strQuery As String

        strQuery = "usp_Sel_MetricValue_For_Metric '" & m_strMode & "', " & m_strMasterRecID & ", " & m_strMetricID & ", 2, " & Session("intProjectID").ToString
        'With objSection
        '    .GetSectionTitle("Releated Data Section", "divRelatedData", "ShowHideRelatedData")
        '    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
        '    CommonFunctions.General.WriteHTML(.ClientsideScript)
        '    CommonFunctions.General.WriteHTML("</SCRIPT>")
        'End With
        'CommonFunctions.General.WriteHTML("<DIV id='divRelatedData' style='Overflow:auto;width:100%;height:100%;'>")
        'CommonFunctions.General.WriteHTML("<TABLE id='tblDetails' class='clsGridTable' height=100% width='100%' cellspacing=1 border=0 >")
        'CommonFunctions.General.WriteHTML("<TR>")
        'CommonFunctions.General.WriteHTML("<TD>")
        '-------------Draw the Grid to display the data
        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {"Snap Shot Month" _
                                                    , "LCL" _
                                                    , "UCL" _
                                                    , "" _
                                                }

        '---------Actual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"Month" _
                                                , "LCL" _
                                                , "UCL" _
                                                , "" _
                                                }
        '-----------------------------------------------------------------
        Dim arrTDStyle() As String = {"align=left" _
                                    , "align=right" _
                                     , "align=right" _
                                      , "align=right" _
                                    }

        If strQuery <> "" Then

            ''''Added By Vaijat K On 06/10/2015
            Dim arrIgnoreHTMLEncode() As String = {"0"}
            ''''End Added By Vaijat K On 06/10/2015

            With m_objGrid
                .ActualColumnArray = arrActualColumnNames
                .UserFriendlyColumnArray = arrColumnHeadingList
                .NoOfDataColumns = 5
                .TDStyleArray = arrTDStyle
                .DIVStyle = "overflow:none" ' height=60px
                .ColNameToolTipOnEachRow = True
                .SQL = strQuery
                .UseSQL = MyBase.UseSQL
                .PrimaryKey = "Month"
                .DIVHeight = 100
                ''''Added By Vaijat K On 06/10/2015
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                ''''End Added By Vaijat K On 06/10/2015
                .DrawGrid()
            End With
        End If
        m_objGrid = Nothing
        '-----------------
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")
        ' CommonFunctions.General.WriteHTML("</DIV>")
    End Sub
    'SrikanthY on 08 Aug 2007, Added Below Procedure to show Datapoint graphs at Below project level , for whizible metrics 3.0
    Private Sub DrawRelatedDataPointSection()
        Dim objSection As New Whiz.WebPage.Templates.SectionTitle
        Dim m_objGrid As New WebPages.Template.GenericGrid
        Dim strQuery As String
        Dim Mode As String
        Dim arrColRowLinks() As String = {"", ""}
        If m_strMode = "PHDP" Then
            Mode = "PH"
        ElseIf m_strMode = "MLDP" Then
            Mode = "ML"
        ElseIf m_strMode = "DLDP" Then
            Mode = "DL"
        End If
        strQuery = "usp_Sel_MeasurementValue_For_Measurement_Graph_Details '" & Mode & "', " & m_strMasterRecID & ", " & m_strMetricID & "," + Session("intProjectID").ToString

        'With objSection
        '    .GetSectionTitle("Releated Data Section", "divRelatedData", "ShowHideRelatedData")
        '    CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
        '    CommonFunctions.General.WriteHTML(.ClientsideScript)
        '    CommonFunctions.General.WriteHTML("</SCRIPT>")
        'End With
        'CommonFunctions.General.WriteHTML("<DIV id='divRelatedData' style='Overflow:auto;width:100%;height:100px;'>")

        'CommonFunctions.General.WriteHTML("<TABLE id='tblDetails' class='clsGridTable' height=100% width='100%' cellspacing=1 border=0 >")
        'CommonFunctions.General.WriteHTML("<TR>")
        'CommonFunctions.General.WriteHTML("<TD>")
        '-------------Draw the Grid to display the data
        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {"Snap Shot Month", "Value"}

        '---------Actual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"Month", ""}
        '-----------------------------------------------------------------
        Dim arrTDStyle() As String = {"align=left", "align=right"}



        Dim strMetricView As String
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strMetricView = CommonFunctions.Data.GetDataScalar(" SELECT DBO.UDF_Get_TBL_MET_FREQUENCYTYPES(" + Session("intProjectID").ToString + ")  ", MyBase.UseSQL, )
        strMetricView = CommonFunctions.Data.GetDataScalar("usp_sel_Get_TBL_MET_FREQUENCYTYPES " + Session("intProjectID").ToString, MyBase.UseSQL, )
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        If strMetricView = "Weekly" Then
            arrColumnHeadingList.SetValue("Date", 0)
            arrActualColumnNames.SetValue("SnapShotDate", 0)
        End If

        Dim strIsExternal As String
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' strIsExternal = CommonFunctions.Data.GetDataScalar(" Select IsEditable From tbl_MET_Project_Measurements Where ProjectID = " + Session("intProjectID").ToString + " And  MeasurementID=" + m_strMetricID, MyBase.UseSQL)
        strIsExternal = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_MET_Project_Measurements " + Session("intProjectID").ToString + "," + m_strMetricID, MyBase.UseSQL)
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        If strIsExternal = "1" Then
            arrColRowLinks.SetValue("", 0)
        Else
            '            arrColRowLinks.SetValue("Value_onclick(" + Session("intProjectID").ToString + "," + m_strMeasurementID + "," + )", 1)
            If strMetricView = "Weekly" Then
                arrColRowLinks.SetValue("Value_onclick(ProjectId,MeasurementID,CharType,BreakupID,FromDate,ToDate,SnapShotDate)", 1)
            Else
                arrColRowLinks.SetValue("Value_onclick(ProjectId,MeasurementID,CharType,BreakupID,FromDate,ToDate,SnapShotDate)", 1)

            End If
        End If
        If strQuery <> "" Then

            ''''Added By Vaijat K On 06/10/2015
            Dim arrIgnoreHTMLEncode() As String = {"0"}
            ''''End Added By Vaijat K On 06/10/2015

            With m_objGrid
                .ActualColumnArray = arrActualColumnNames
                .UserFriendlyColumnArray = arrColumnHeadingList
                .NoOfDataColumns = 9
                .RowLinkArray = arrColRowLinks
                .TDStyleArray = arrTDStyle
                .DIVStyle = "overflow:none height=60px"
                .ColNameToolTipOnEachRow = True
                .SQL = strQuery
                .UseSQL = MyBase.UseSQL
                If strMetricView = "Weekly" Then
                    .PrimaryKey = "SnapShotDate"
                Else
                    .PrimaryKey = "Month"
                End If
                ''''Added By Vaijat K On 06/10/2015
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                ''''End Added By Vaijat K On 06/10/2015
                .DIVHeight = 100
                .DrawGrid()
            End With
        End If
        m_objGrid = Nothing
        '-----------------
        'CommonFunctions.General.WriteHTML("</TD>")
        'CommonFunctions.General.WriteHTML("</TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")
        'CommonFunctions.General.WriteHTML("</DIV>")

    End Sub
End Class
