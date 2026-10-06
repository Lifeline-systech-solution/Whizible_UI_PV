Option Explicit On
Imports System.Drawing
Imports PBNIT
Imports CommonFunctions
Public Class ProjectMetricGraphs
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmPrjMetricGraphs As System.Web.UI.HtmlControls.HtmlForm

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
    Public Const PAGE_HEADER As String = "Project Metric Graphs"
    Private m_strMasterRecID As String = ""
    Private m_strFor As String = "PH"
    Private m_strProjectID As String
    'Private strProjectID As String
    Private strMode As String
    Private arrMetricNameList As ArrayList = New ArrayList(50)
    Private arrMetricIDList As ArrayList = New ArrayList(50)
    Private arrPhaseIDList As ArrayList
    Private arrModuleIDList As ArrayList
    'Added by GokulP on 21 Jan 2010 for Deliverable Type Graph
    Private arrDeliverableIDList As ArrayList
    'End of Addition by GokulP on 21 Jan 2010 for Deliverable Type Graph
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
        'Drawing the page title
        PlotHeader()
        'Drawing the Sections
        CommonFunctions.General.WriteHTML("<DIV id='divPage' Style='overflow:auto;height:490px;width:100%;'>")
        DrawSections()

        CommonFunctions.General.WriteHTML("<BR>")
        'Drawing Bottom Menu
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML(PrepareMenu())

    End Sub

    Private Sub Initializations()
        Dim strQuery As String
        Dim strQueryForProject As String

        Dim drProject As IDataReader
        Dim drMetricNames As IDataReader

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "") <> "" Then
            m_strProjectID = Request.QueryString("ProjectID")
            'PRPH indicates ProjectPhase and PRMO indicates ProjectModule, only if Query String has ProjectID
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("For"), "") <> "" Then
                strMode = Request.QueryString("For")
            Else
                strMode = "PRPH"
            End If
        Else
            ''Added By Dipali V On 20th March 2020 If Project ID was Blank then m_strProjectID should be null
            If m_strProjectID = "" Then
                m_strProjectID = "NULL"
            End If
            ''End of Added By Dipali V On 20th March 2020 If Project ID was Blank then m_strProjectID should be null
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("For"), "") <> "" Then
            strMode = Request.QueryString("For")
            m_strFor = strMode
        End If

        'If the mode is for Project Phase then
        If strMode = "PRPH" Then
            arrPhaseIDList = New ArrayList(100)
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT DISTINCT ProjectPhaseID, Phase FROM tbl_IB_Project_Phases WHERE ProjectID = " & m_strProjectID & " ORDER BY Phase"
            strQuery = "usp_sel_Phase_tbl_IB_Project_Phases " & m_strProjectID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                arrPhaseIDList.Add(drProject(0))
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'If the mode is for Project Module then
        If strMode = "PRMO" Then
            arrModuleIDList = New ArrayList(100)
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT DISTINCT ModuleID, ModuleName FROM tbl_PM_Module WHERE ProjectID = " & m_strProjectID & " ORDER BY ModuleName"
            strQuery = "usp_sel_ModuleName_tbl_PM_Module " & m_strProjectID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                arrModuleIDList.Add(drProject(0))
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'If the query string has PhaseID then display only graphs for that phase
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("PhaseID"), "") <> "" Then
            m_strMasterRecID = Request.QueryString("PhaseID")
            'strMode = "PH"
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQueryForProject = "SELECT ProjectID FROM tbl_IB_Project_Phases WHERE ProjectPhaseID = " & m_strMasterRecID
            strQueryForProject = "usp_sel_phase1_tbl_IB_Project_Phases " & m_strMasterRecID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQueryForProject, True)
            Do While drProject.Read
                m_strProjectID = drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If
        'If the query string has ModuleID then display only graphs for that Module
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ModuleID"), "") <> "" Then
            m_strFor = "MO"
            m_strMasterRecID = Request.QueryString("ModuleID")
            strMode = "MO"
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQueryForProject = "SELECT ProjectID FROM tbl_PM_Module WHERE ModuleID = " & m_strMasterRecID
            strQueryForProject = "usp_sel_ModuleID_tbl_PM_Module " & m_strMasterRecID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQueryForProject, True)
            Do While drProject.Read
                m_strProjectID = drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'If the query string has ModuleID then display only graphs for that Milestone
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("MilestoneID"), "") <> "" Then
            'm_strFor = "ML"
            m_strMasterRecID = Request.QueryString("MilestoneID")
            'strMode = "ML"
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQueryForProject = "SELECT ProjectID FROM tbl_PM_Milestones WHERE MilestoneID = " & m_strMasterRecID
            strQueryForProject = "usp_sel_Milestone_tbl_PM_Milestones " & m_strMasterRecID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQueryForProject, True)
            Do While drProject.Read
                m_strProjectID = drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'If the query string has DeliverableID then display only graphs for that Deliverable
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DeliverableID"), "") <> "" Then
            'm_strFor = "DL"
            m_strMasterRecID = Request.QueryString("DeliverableID")
            'strMode = "DL"
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQueryForProject = "SELECT ProjectID FROM tbl_PM_OtherSchedules WHERE ScheduleID = " & m_strMasterRecID
            strQueryForProject = "usp_sel_Schedule_tbl_PM_OtherSchedules " & m_strMasterRecID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQueryForProject, True)
            Do While drProject.Read
                m_strProjectID = drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'If the query string has SubProjectID then display only graphs for that Deliverable
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("SubProjectID"), "") <> "" Then
            m_strFor = "SP"
            m_strMasterRecID = Request.QueryString("SubProjectID")
            strMode = "SP"
            strQueryForProject = "SELECT ProjectID FROM tbl_PM_subProjects WHERE SubProjectID = " & m_strMasterRecID
            drProject = CommonFunctions.Data.GetDataReader(strQueryForProject, True)
            Do While drProject.Read
                m_strProjectID = drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        'Code Added by Noble K on 19th Jan, 2005 to Consider only those metric whicha have been mapped for phases and Modules
        If m_strFor = "MO" Then
            strQuery = "SELECT DISTINCT tbl_MET_MetricMaster.MetricID, tbl_MET_MetricMaster.[Name] " &
                            " FROM tbl_MET_MetricMaster INNER JOIN tbl_MET_Metric_Project_BreakUp_Mapping ON tbl_MET_MetricMaster.MetricID = tbl_MET_Metric_Project_BreakUp_Mapping.MetricID " &
                            " WHERE tbl_MET_Metric_Project_BreakUp_Mapping.ShowInGraph =1 And tbl_MET_Metric_Project_BreakUp_Mapping.ProjectID = " & m_strProjectID & " AND ConsiderForModule = 1" &
                            " AND tbl_MET_MetricMaster.IsModuleLevelMetric = 1" &
                            " ORDER BY [Name]"
        ElseIf m_strFor = "PH" Then
            strQuery = "exec usp_sel_tbl_MET_Metric_Project_BreakUp_Mapping " & m_strProjectID & ",'PH'"
        ElseIf m_strFor = "DL" Then
            strQuery = "exec usp_sel_tbl_MET_Metric_Project_BreakUp_Mapping " & m_strProjectID & ",'DL'"
        ElseIf m_strFor = "ML" Then
            strQuery = "exec usp_sel_tbl_MET_Metric_Project_BreakUp_Mapping " & m_strProjectID & ",'ML'"
            'ElseIf m_strFor = "PH" Then
            '    strQuery = "SELECT DISTINCT tbl_MET_MetricMaster.MetricID, tbl_MET_MetricMaster.[Name] " & _
            '                    " FROM tbl_MET_MetricMaster INNER JOIN tbl_MET_Metric_Project_BreakUp_Mapping ON tbl_MET_MetricMaster.MetricID = tbl_MET_Metric_Project_BreakUp_Mapping.MetricID " & _
            '                    " WHERE tbl_MET_Metric_Project_BreakUp_Mapping.ShowInGraph =1 And tbl_MET_Metric_Project_BreakUp_Mapping.ProjectID = " & m_strProjectID & " AND ConsiderForPhase = 1 " & _
            '                    " AND  tbl_MET_MetricMaster.IsEnableForPMD = 1" & _
            '                    " ORDER BY [Name]"
            'ElseIf m_strFor = "DL" Then
            '    strQuery = "SELECT DISTINCT tbl_MET_MetricMaster.MetricID, tbl_MET_MetricMaster.[Name] " & _
            '                    " FROM tbl_MET_MetricMaster INNER JOIN tbl_MET_Metric_Project_BreakUp_Mapping ON tbl_MET_MetricMaster.MetricID = tbl_MET_Metric_Project_BreakUp_Mapping.MetricID " & _
            '                    " WHERE tbl_MET_Metric_Project_BreakUp_Mapping.ShowInGraph =1 And tbl_MET_Metric_Project_BreakUp_Mapping.ProjectID = " & m_strProjectID & " AND ConsiderForDeliverable = 1 " & _
            '                    " AND tbl_MET_MetricMaster.IsEnableForPMD = 1" & _
            '                    " ORDER BY [Name]"
            'ElseIf m_strFor = "ML" Then
            '    strQuery = "SELECT DISTINCT tbl_MET_MetricMaster.MetricID, tbl_MET_MetricMaster.[Name] " & _
            '                    " FROM tbl_MET_MetricMaster INNER JOIN tbl_MET_Metric_Project_BreakUp_Mapping ON tbl_MET_MetricMaster.MetricID = tbl_MET_Metric_Project_BreakUp_Mapping.MetricID " & _
            '                    " WHERE tbl_MET_Metric_Project_BreakUp_Mapping.ShowInGraph =1 And tbl_MET_Metric_Project_BreakUp_Mapping.ProjectID = " & m_strProjectID & " AND ConsiderForMilestone = 1 " & _
            '                    " AND tbl_MET_MetricMaster.IsEnableForPMD = 1" & _
            '                    " ORDER BY [Name]"
        ElseIf m_strFor = "SP" Then
            strQuery = "SELECT DISTINCT tbl_MET_MetricMaster.MetricID, tbl_MET_MetricMaster.[Name] " &
                            " FROM tbl_MET_MetricMaster INNER JOIN tbl_MET_Metric_Project_BreakUp_Mapping ON tbl_MET_MetricMaster.MetricID = tbl_MET_Metric_Project_BreakUp_Mapping.MetricID " &
                            " WHERE tbl_MET_Metric_Project_BreakUp_Mapping.ProjectID = " & m_strProjectID & " AND ConsiderForSubProject = 1 " &
                            " AND tbl_MET_MetricMaster.IsSubProjectLevelMetric = 1" &
                            " ORDER BY [Name]"
            'SrikanthY on 08 Aug 2007, Added Below code to show Datapoint graphs at Below project level , for whizible metrics 3.0
        ElseIf m_strFor = "PHDP" Then
            strQuery = " SELECT DISTINCT tbl_PRS_Measurements.MeasurementID, tbl_PRS_Measurements.[UserFriendlyName] " &
                            " FROM tbl_PRS_Measurements INNER JOIN tbl_MET_Project_Measurements ON tbl_PRS_Measurements.MeasurementID = tbl_MET_Project_Measurements.MeasurementID  " &
                            "  WHERE tbl_MET_Project_Measurements.ProjectID = " & m_strProjectID &
                            "  AND tbl_MET_Project_Measurements.ShowInGraph = 1 And tbl_MET_Project_Measurements.IsPhaseLevelMeasurement = 1 AND tbl_PRS_Measurements.IsPhaseLevelMeasurement = 1 " &
                            " ORDER BY [UserFriendlyName]"
        ElseIf m_strFor = "MLDP" Then
            strQuery = " SELECT DISTINCT tbl_PRS_Measurements.MeasurementID, tbl_PRS_Measurements.[UserFriendlyName] " &
                            " FROM tbl_PRS_Measurements INNER JOIN tbl_MET_Project_Measurements ON tbl_PRS_Measurements.MeasurementID = tbl_MET_Project_Measurements.MeasurementID  " &
                            "  WHERE tbl_MET_Project_Measurements.ProjectID = " & m_strProjectID &
                            "  AND tbl_MET_Project_Measurements.ShowInGraph = 1 And tbl_MET_Project_Measurements.IsMilestoneLevelMeasurement = 1 AND tbl_PRS_Measurements.IsMilestoneLevelMeasurement = 1 " &
                            " ORDER BY [UserFriendlyName]"
            'Added by GokulP on 21 Jan 2010 for Deliverable Type graph
        ElseIf m_strFor = "DLDP" Then
            strQuery = " SELECT DISTINCT tbl_PRS_Measurements.MeasurementID, tbl_PRS_Measurements.[UserFriendlyName] " &
                            " FROM tbl_PRS_Measurements INNER JOIN tbl_MET_Project_Measurements ON tbl_PRS_Measurements.MeasurementID = tbl_MET_Project_Measurements.MeasurementID  " &
                            "  WHERE tbl_MET_Project_Measurements.ProjectID = " & m_strProjectID &
                            "  AND tbl_MET_Project_Measurements.ShowInGraph = 1 And tbl_MET_Project_Measurements.IsDeliverableLevelMeasurement = 1 AND tbl_PRS_Measurements.IsDeliverableLevelMeasurement = 1 " &
                            " ORDER BY [UserFriendlyName]"
            'End of Addition by GokulP on 21 Jan 2010 for Deliverable Type graph
        End If
        'End of addition by SrikanthY on 08 Aug 2007
        'strQuery = "SELECT DISTINCT tbl_MET_MetricMaster.MetricID, tbl_MET_MetricMaster.[Name] FROM tbl_MET_MetricMaster ORDER BY [Name]"
        'End of Code added by Noble K on 19th Jan, 2005
        drMetricNames = CommonFunctions.Data.GetDataReader(strQuery, True)
        Do While drMetricNames.Read
            arrMetricIDList.Add(drMetricNames(0))
            arrMetricNameList.Add(drMetricNames(1))
        Loop
        CommonFunctions.Data.DisposeDataReader(drMetricNames)
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

        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'Dim strQuery As String = "SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " & m_strProjectID
        Dim strQuery As String = "usp_sel_Select_tbl_PM_Project " & m_strProjectID
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

        Dim strDynPageTitle As String = ""
        Dim strPrjName As String = ""
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter
        Dim drProject As IDataReader

        drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
        Do While drProject.Read
            strPrjName = drProject(0)
        Loop
        CommonFunctions.Data.DisposeDataReader(drProject)


        If strMode = "PRPH" Then
            strDynPageTitle = "Phase Wise"

        ElseIf strMode = "PRMO" Then
            strDynPageTitle = "Module Wise"

        ElseIf strMode = "PH" Or strMode = "PHDP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            ' strQuery = "SELECT Phase FROM tbl_IB_Project_Phases WHERE ProjectPhaseID = " & m_strMasterRecID
            strQuery = "usp_sel_IB_tbl_IB_Project_Phases " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = "Phase -" & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        ElseIf strMode = "MO" Or strMode = "MODP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT ModuleName FROM tbl_PM_Module WHERE ModuleID = " & m_strMasterRecID
            strQuery = "usp_sel_PmModule_tbl_PM_Module " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = "Module - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)

        ElseIf strMode = "DL" Or strMode = "DLDP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT Title FROM tbl_PM_OtherSchedules WHERE ScheduleID = " & m_strMasterRecID
            strQuery = "usp_sel_ScheduleTitle_tbl_PM_OtherSchedules " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = "Deliverable - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)

        ElseIf strMode = "ML" Or strMode = "MLDP" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT Milestone FROM tbl_PM_Milestones WHERE MilestoneID = " & m_strMasterRecID
            strQuery = "usp_sel_tbl_PM_Milestones_Milestone " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = "Milestone - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)

        ElseIf strMode = "SP" Then

            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strQuery = "SELECT SubProjectName FROM tbl_PM_SubProject WHERE SubProjectID = " & m_strMasterRecID
            strQuery = "usp_sel_tbl_PM_SubProject_SubProject " & m_strMasterRecID
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drProject = CommonFunctions.Data.GetDataReader(strQuery, True)
            Do While drProject.Read
                strDynPageTitle = "SubProject - " & drProject(0)
            Loop
            CommonFunctions.Data.DisposeDataReader(drProject)
        End If

        strDynPageTitle = strDynPageTitle & " Details for Project - " & strPrjName
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
        If strMode = "PRPH" Or strMode = "PRMO" Then
            Dim arrMenu() As String = {"Phases", "Modules", "Close", " ? "}
            Dim arrMenuToolTip() As String = {"Phases", "Modules", "Close", "Help"}
            Dim arrClientSideFunctions() As String = {"PhasesMenu_OnClick(" & m_strProjectID & ")", "ModulesMenu_OnClick(" & m_strProjectID & ")", "Close_OnClick()", "Help_OnClick()"}
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Else
            Dim arrMenu() As String = {"Back", " ? "}
            Dim arrMenuToolTip() As String = {"Back", "Help"}
            Dim arrClientSideFunctions() As String = {"Back_OnClick('" & CommonFunctions.General.CheckIsNothing(Request.QueryString("For"), "") & "')", "Help_OnClick()"}

            'Dim arrMenu() As String = {"Close", " ? "}
            'Dim arrMenuToolTip() As String = {"Close", "Help"}
            'Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick()"}
            strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        End If
        Return strMenu
    End Function

    'Private Sub DrawSections()
    '    '=====================================================================
    '    ' Procedure Name        : DrawSections
    '    ' Purpose               : To plot the Section for each graph on the page
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : 
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : NobleK
    '    ' Created               : Jan 11, 2006
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strQuery As String = ""
    '    Dim drPhaseMetric As IDataReader
    '    Dim intRowCounter As Integer = 1
    '    Dim strImageName As String
    '    Dim blnDrawColumn As Boolean = True
    '    Dim intCounter As Integer = 0
    '    Dim intMaxCount As Integer
    '    Dim intNoofGraphs As Integer = 0
    '    Dim intRecordCnt As Integer = 0
    '    Dim blnFirstRow As Boolean = True
    '    Dim blnTRdrawn As Boolean = False
    '    Dim blnHasData As Boolean = False

    '    intMaxCount = arrMetricIDList.Count

    '    CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;height:100%;'>")
    '    CommonFunctions.General.WriteHTML("<TABLE id='tblList' class='clsGridTable'width='100%' cellspacing=1 border=0 >")
    '    While intCounter < intMaxCount
    '        'intNoofGraphs = intNoofGraphs + 1
    '        'Execute the query and store in datareader
    '        'pass sp appropriately
    '        If strMode = "PRPH" Or strMode = "PRMO" Then
    '            strQuery = "usp_Sel_MetricValue_For_Metric_For_Project '" & strMode & "', " & m_strProjectID & ", " & arrMetricIDList(intCounter)
    '        ElseIf strMode = "PH" Or strMode = "MO" Then
    '            strQuery = "usp_Sel_MetricValue_For_Metric '" & strMode & "', " & m_strMasterRecID & ", " & arrMetricIDList(intCounter)
    '        End If
    '        drPhaseMetric = CommonFunctions.Data.GetDataReader(strQuery, True)
    '        If strMode = "PRPH" Or strMode = "PRMO" Then
    '            strImageName = strMode & m_strProjectID & arrMetricIDList(intCounter) & arrMetricNameList(intCounter)
    '        Else
    '            strImageName = strMode & m_strProjectID & m_strMasterRecID & arrMetricIDList(intCounter) & arrMetricNameList(intCounter)
    '        End If
    '        'Create the Image of the graph
    '        'Depending on mode display the graph , bar graph for Project level metrics
    '        ' and spline graph for BreakUp level metrics
    '        If strMode = "PRPH" Or strMode = "PRMO" Then
    '            CreateGraph(strQuery, strImageName, 2, arrMetricNameList(intCounter))
    '        Else
    '            CreateGraph(strQuery, strImageName, 1, arrMetricNameList(intCounter))
    '        End If
    '        CreateGraph(strQuery, strImageName, 1, arrMetricNameList(intCounter))

    '        'If blnFirstRow = True Or intNoofGraphs = 2 Then
    '        '    CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
    '        '    blnFirstRow = False
    '        '    blnTRdrawn = True

    '        'End If
    '        If intCounter = 0 Then
    '            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
    '        End If
    '        If intCounter > 0 And intCounter Mod 2 = 0 Then
    '            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
    '        End If
    '        'CommonFunctions.General.WriteHTML("<tr class ='clsTREven'>")
    '        'CommonFunctions.General.WriteHTML("<TD width = '50%'>")
    '        'CommonFunctions.General.WriteHTML("<TABLE class='clsTable' cellspacing=1 border=0 width='100%'>")
    '        'CommonFunctions.General.WriteHTML("<TR class='clsTREven' align='center'>")
    '        'CommonFunctions.General.WriteHTML("<TD width='45%'>")
    '        'CommonFunctions.General.WriteHTML("<DIV id='Details" & intCounter & "' style='OVERFLOW:auto;height:300px;width:100%;'>")
    '        'CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' cellspacing=1 border=0 width='100%' height='50%'>")
    '        'Drawing the Column Headers
    '        'CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
    '        'If strMode = "PRPH" Or strMode = "PRMO" Then
    '        '    '---
    '        '    'CommonFunctions.General.WriteHTML("<TD>Short Name</TD>")
    '        '    '--
    '        '    'CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric.GetName(0) & "</TD>")
    '        '    'CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric.GetName(0) & "</TD>")
    '        '    'CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric.GetName(1) & "</TD>")
    '        'ElseIf strMode = "PH" Or strMode = "MO" Then
    '        '    CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric.GetName(0) & "</TD>")
    '        '    CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric.GetName(3) & "</TD>")
    '        'End If

    '        'CommonFunctions.General.WriteHTML("</TR>")
    '        'blnHasData = False
    '        'Do While drPhaseMetric.Read
    '        '    intRowCounter = 1
    '        '    blnHasData = True
    '        '    If intRowCounter Mod 2 <> 0 Then
    '        '        CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
    '        '    Else
    '        '        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
    '        '    End If
    '        '    intRowCounter = intRowCounter + 1
    '        '    If strMode = "PRPH" Then
    '        '        'CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric(0) & "</TD>")
    '        '        'Displaying the link for the Phase in the Details Grid
    '        '        CommonFunctions.General.WriteHTML("<TD><A HRef='Javascript:PhaseGrid_OnClick(" & arrPhaseIDList(intRecordCnt) & "," & arrMetricIDList(intCounter) & ")'>" & drPhaseMetric(0) & "</A></TD>")
    '        '        'CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric(1) & "</TD>")
    '        '        CommonFunctions.General.WriteHTML("<TD>" & FormatNumber(drPhaseMetric(1), 2) & "</TD>")
    '        '    ElseIf strMode = "PRMO" Then
    '        '        CommonFunctions.General.WriteHTML("<TD><A HRef='Javascript:ModuleGrid_OnClick(" & arrModuleIDList(intRecordCnt) & "," & arrMetricIDList(intCounter) & ")'>" & drPhaseMetric(0) & "</A></TD>")
    '        '        CommonFunctions.General.WriteHTML("<TD>" & FormatNumber(drPhaseMetric(1), 2) & "</TD>")
    '        '    Else
    '        '        CommonFunctions.General.WriteHTML("<TD>" & drPhaseMetric(0) & "</TD>")
    '        '        CommonFunctions.General.WriteHTML("<TD>" & FormatNumber(drPhaseMetric(3), 2) & "</TD>")
    '        '    End If
    '        '    CommonFunctions.General.WriteHTML("</TR>")
    '        '    intRowCounter = intRowCounter + 1
    '        '    intRecordCnt = intRecordCnt + 1
    '        'Loop
    '        'intRecordCnt = 0
    '        'If blnHasData = False Then
    '        '    CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
    '        '    CommonFunctions.General.WriteHTML("<TD colspan = 2>There is no data in this view.</TD>")
    '        '    CommonFunctions.General.WriteHTML("</TR>")
    '        'End If
    '        'CommonFunctions.General.WriteHTML("</TABLE>")
    '        'CommonFunctions.General.WriteHTML("</DIV>")
    '        'CommonFunctions.General.WriteHTML("</TD>")
    '        CommonFunctions.General.WriteHTML("<TD width='50%' align =center >")
    '        CommonFunctions.General.WriteHTML("<IMG src=""../../Images/" & strImageName & ".png"">")
    '        CommonFunctions.General.WriteHTML("</TD>")
    '        CommonFunctions.General.WriteHTML("</TR>")
    '        CommonFunctions.General.WriteHTML("</TABLE>")
    '        CommonFunctions.General.WriteHTML("</TD>")
    '        'If intNoofGraphs = 2 And blnTRdrawn = True Then
    '        '    CommonFunctions.General.WriteHTML("</TD>")
    '        '    'CommonFunctions.General.WriteHTML("</TR>")
    '        '    blnTRdrawn = False
    '        '    If intNoofGraphs = 2 Then
    '        '        intNoofGraphs = 0
    '        '    End If
    '        'End If
    '        If intCounter > 0 And intCounter Mod 2 <> 0 Then
    '            'CommonFunctions.General.WriteHTML("</TD>")
    '            CommonFunctions.General.WriteHTML("</TR>")
    '        End If
    '        intCounter = intCounter + 1
    '    End While
    '    CommonFunctions.General.WriteHTML("</TR>")
    '    CommonFunctions.General.WriteHTML("</TABLE>")
    '    CommonFunctions.General.WriteHTML("</DIV>")

    '    CommonFunctions.Data.DisposeDataReader(drPhaseMetric)
    'End Sub

    Private Sub DrawSections()
        '=====================================================================
        ' Procedure Name        : DrawSections
        ' Purpose               : To plot the Section for each graph on the page
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
        Dim strQuery As String = ""
        Dim drPhaseMetric As IDataReader
        Dim intRowCounter As Integer = 1
        Dim strImageName As String
        Dim blnDrawColumn As Boolean = True
        Dim intCounter As Integer = 0
        Dim intMaxCount As Integer
        Dim intNoofGraphs As Integer = 0
        Dim intRecordCnt As Integer = 0
        Dim blnFirstRow As Boolean = True
        Dim blnTRdrawn As Boolean = False
        Dim blnHasData As Boolean = False
        Dim Name As String
        Dim intUCL As Integer
        Dim intLCL As Integer

        'Added by GokulP on 10 Feb 2010 for Graph Type
        Dim strGraphType As String = "Column"
        'End of Addition by GokulP on 10 Feb 2010 for Graph Type

        intMaxCount = arrMetricIDList.Count

        'CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;height:70%;'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblList' class='clsTable'width='100%' cellspacing=1 border=0 >")
        While intCounter < intMaxCount
            'Execute the query and store in datareader
            'pass sp appropriately
            If strMode = "PRPH" Or strMode = "PRMO" Then
                strQuery = "usp_Sel_MetricValue_For_Metric_For_Project '" & strMode & "', " & m_strProjectID & ", " & arrMetricIDList(intCounter)
            ElseIf strMode = "PH" Or strMode = "MO" Or strMode = "DL" Or strMode = "ML" Or strMode = "SP" Then
                strQuery = "usp_Sel_MetricValue_For_Metric_ForGraph '" & strMode & "', " & m_strMasterRecID & ", " & arrMetricIDList(intCounter) & ", 1, " & Session("intProjectID").ToString
            ElseIf strMode = "PHDP" Then
                strQuery = "usp_Sel_MeasurementValue_For_Measurement 'PH', " & m_strMasterRecID & ", " & arrMetricIDList(intCounter) & ", 1, " & Session("intProjectID").ToString
            ElseIf strMode = "MLDP" Then
                strQuery = "usp_Sel_MeasurementValue_For_Measurement 'ML', " & m_strMasterRecID & ", " & arrMetricIDList(intCounter) & ", 1, " & Session("intProjectID").ToString
                'Added by GokulP on 21 Jan 2010 for Deliverable Graph
            ElseIf strMode = "DLDP" Then
                strQuery = "usp_Sel_MeasurementValue_For_Measurement 'DL', " & m_strMasterRecID & ", " & arrMetricIDList(intCounter) & ", 1, " & Session("intProjectID").ToString
                'End of Addition by GokulP on 21 Jan 2010 for Deliverable Graph
            End If
            Dim Isdata As String = "0"
            drPhaseMetric = CommonFunctions.Data.GetDataReader(strQuery, True)
            If strMode = "PH" Or strMode = "MO" Or strMode = "DL" Or strMode = "ML" Or strMode = "SP" Then
                While drPhaseMetric.Read()
                    Isdata = "1" 'Added By Dipali V On 13th July 2020 For Data was not present 
                    strQuery = CType(CommonFunctions.Data.CheckIsDBNull(drPhaseMetric(0), ""), String)
                    Name = CType(CommonFunctions.Data.CheckIsDBNull(drPhaseMetric(1), ""), String)
                    intUCL = CType(drPhaseMetric(2), Integer)
                    intLCL = CType(drPhaseMetric(3), Integer)
                End While
            End If
            If strMode = "PRPH" Or strMode = "PRMO" Then
                strImageName = strMode & m_strProjectID & arrMetricIDList(intCounter) '& arrMetricNameList(intCounter)
                'Else
            ElseIf strMode = "PH" Or strMode = "MO" Or strMode = "DL" Or strMode = "ML" Or strMode = "SP" Then
                strImageName = strMode & m_strProjectID & m_strMasterRecID & arrMetricIDList(intCounter) '& arrMetricNameList(intCounter)
            ElseIf strMode = "PHDP" Or strMode = "MLDP" Or strMode = "DLDP" Then
                strImageName = strMode & m_strProjectID & m_strMasterRecID & arrMetricIDList(intCounter) '& arrMetricNameList(intCounter)
            End If

            strImageName = strImageName & CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            'Create the Image of the graph
            'Depending on mode display the graph , bar graph for Project level metrics
            ' and spline graph for BreakUp level metrics
            If strMode = "PRPH" Or strMode = "PRMO" Then
                CreateGraph(strQuery, strImageName, 2, Name, intUCL, intLCL)
                'Else
            ElseIf strMode = "PH" Or strMode = "MO" Or strMode = "DL" Or strMode = "ML" Or strMode = "SP" Then
                'Commented & Added by GokulP on 10 Feb 2010 for Graph Type 
                'CreateGraph(strQuery, strImageName,1, Name, intUCL, intLCL)
                strGraphType = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(" usp_Sel_MetricValue_For_Metric_ForGraph_GraphType '" + strMode.ToString + "', " + m_strMasterRecID.ToString + ", " + arrMetricIDList(intCounter).ToString + ", " + Session("intProjectID").ToString, MyBase.UseSQL), "")
                If strGraphType Is Nothing Then
                    strGraphType = "Line"
                End If
                CreateGraph(strQuery, strImageName, strGraphType, Name, intUCL, intLCL)
                'End of Comment & Addition by GokulP on 10 Feb 2010 for Graph Type 

            ElseIf strMode = "PHDP" Or strMode = "MLDP" Or strMode = "DLDP" Then
                'CreateDataPointGraph(strQuery, strImageName, 1, arrMetricNameList(intCounter))
                'Commented & Added by GokulP on 10 Feb 2010 for Graph Type 
                'CreateDataPointGraph(strQuery, strImageName, 1, arrMetricNameList(intCounter))
                strGraphType = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(" usp_Sel_MetricValue_For_Metric_ForGraph_GraphType '" + strMode.ToString + "', " + m_strMasterRecID.ToString + ", " + arrMetricIDList(intCounter).ToString + ", " + Session("intProjectID").ToString, MyBase.UseSQL), "")
                If strGraphType Is Nothing Then
                    strGraphType = "Line"
                End If
                'Added By Dipali V On 13th July 2020 For Data was not present 
                'If (Isdata <> "0") Then 'Commented By Usha Pandit On 24.02.2021 For correct data fecth for Data point graph
                CreateDataPointGraph(strQuery, strImageName, strGraphType, arrMetricNameList(intCounter))
                'End If 'Commented By Usha Pandit On 24.02.2021 For correct data fecth for Data point graph
                'End of 'Added By Dipali V On 13th July 2020 For Data was not present 
                'End of Comment & Addition by GokulP on 10 Feb 2010 for Graph Type 
            End If
            CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            'If intCounter = 0 Then
            '    CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            'End If
            'If intCounter > 0 And intCounter Mod 2 = 0 Then
            '    CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            'End If
            CommonFunctions.General.WriteHTML("<TD width='50%' align =center >")
            CommonFunctions.General.WriteHTML("<a href=""javascript:MetricGraph_OnClick('" & strMode & "', '" & strImageName & "', " & m_strMasterRecID & ", " & arrMetricIDList(intCounter) & ")""><IMG  border=0 src='../../Images/Metrics/" & strImageName & ".png'></a>")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            'If intCounter > 0 And intCounter Mod 2 <> 0 Then
            '    CommonFunctions.General.WriteHTML("</TR>")
            'End If
            intCounter = intCounter + 1
        End While
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        ' CommonFunctions.General.WriteHTML("</DIV>")

        CommonFunctions.Data.DisposeDataReader(drPhaseMetric)
    End Sub

    Public Function CreateGraph(ByVal strQuery As String, ByVal strImageName As String, ByVal strGraphType As String, ByVal strGraphTitle As String, Optional ByVal intUCL As Integer = 10, Optional ByVal intLCL As Integer = 1) As Dundas.Charting.WebControl.Chart
        '=====================================================================
        ' Procedure Name        : CreateGraph
        ' Purpose               : To draw graphs as per parameters passed
        ' Description           : same as above
        ' Parameters Passed     : 
        '                         1.strQuery      :  SQL Query or SP Name for the Graph
        '                         2.strImageName  :  Name of the Image for the graph. 
        '                                            i.e. filename without extension.
        '                                            The default extension is "png".
        '                         3.intGraphType  :  1 for bar graph & 2 for pie graph.
        '                         4.strGraphTitle :  Title for the graph.
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : 12 Jan, 2006   
        ' Revisions             :
        '=====================================================================
        Dim objGraph As New Graph.Graph
        Dim arrSplineChart() As String = {"LINE", "LINE", "LINE", "LINE"}
        Dim strsql As String
        Dim BarChart As New Dundas.Charting.WebControl.Chart
        Dim drGraphSource As SqlClient.SqlDataReader
        'Dim intGraphHeight As Integer = CInt(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("GRAPH_HEIGHT"), "260")) '300
        'Dim intGraphWidth As Integer = CInt(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("GRAPH_WIDTH"), "475")) '375
        objGraph = New Graph.Graph

        'Added by GokulP on 10 Feb 2010 for Graph Type
        Dim drTemp As IDataReader
        Dim arrstrChartType() As String = {}
        Dim i As Integer = 0
        Dim GRAPH_DIRECTORY As String = ""
        GRAPH_DIRECTORY = CStr(CommonFunctions.General.CheckIsNothing((MyBase.GetResourceString("GRAPH_DIRECTORY")), "..\..\Images\Metrics\"))

        drTemp = CommonFunctions.Data.GetDataReader(strQuery, True)

        '-- Build Array for specifying the Chart Type for each column
        ReDim arrstrChartType(drTemp.FieldCount - 1)
        For i = 0 To drTemp.FieldCount - 1
            arrstrChartType(i) = strGraphType
        Next

        If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageName) & ".png") Then
            CommonFunctions.FileDirectory.DeleteFile(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageName) & ".png")
        End If

        CommonFunctions.Data.DisposeDataReader(drTemp)
        'End of Addition by GokulP on 10 Feb 2010 for Graph Type
        With objGraph
            '.VirtualImagePath = "../../Images/DBGraphs"
            .VirtualImagePath = GRAPH_DIRECTORY + strImageName
            '.AbsoluteImagePath = Server.MapPath("../../Images/" & strImageName)
            .AbsoluteImagePath = Server.MapPath(GRAPH_DIRECTORY & strImageName)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            'Commented & Added by GokulP on 10 Feb 2010 for Graph Type
            '.ChartType = arrSplineChart
            .ChartType = arrstrChartType
            'End of Comment & Addition by GokulP on 10 Feb 2010 for Graph Type
            Dim Chart As Dundas.Charting.WebControl.Chart
            '-- Take settings From Database table
            .BorderStyle = "None"
            .BorderColor = "Black"
            .GraphTitleColor = "white"
            .ChartBackColor = "Wheat"
            .ChartAreaColor = "White"
            .ShowLegends = True
            .LegendDocking = "Bottom"
            .LegendStyle = "Column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = True
            .ShowCaptions = True
            .GraphTitleColor = "Black"
            '-- Fixed Settings
            .GraphTitle = strGraphTitle
            .TitleFont = New Font("verdana", 9, FontStyle.Bold)
            .SQL = strQuery
            .UCL = intUCL
            .LCL = intLCL
            .UCLSeriesName = "USL"
            .LCLSeriesName = "LSL"
            .LCLColor = "Green"
            .UCLColor = "Crimson"
            .Width = 750 '475
            .Height = 260
            .XAxisInterval = 1
            .ShowExplodedPie = False
            .LegendFont = New Font("verdana", 8, FontStyle.Regular)
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .ChartAreaWidth = 98
            .LegendStyle = "Column" ' "Row"

            ' Draw Graph
            .GenerateChartControl()
        End With
        objGraph.Dispose()
    End Function
    'SrikanthY on 08 Aug 2007, Added Below code to show Datapoint graphs at Below project level , for whizible metrics 3.0
    Public Function CreateDataPointGraph(ByVal strQuery As String, ByVal strImageName As String, ByVal strGraphType As String, ByVal strGraphTitle As String) As Dundas.Charting.WebControl.Chart
        '=====================================================================
        ' Procedure Name        : CreateDataPointGraph
        ' Purpose               : To draw Datapoint graphs as per parameters passed
        ' Description           : same as above
        ' Parameters Passed     : 
        '                         1.strQuery      :  SQL Query or SP Name for the Graph
        '                         2.strImageName  :  Name of the Image for the graph. 
        '                                            i.e. filename without extension.
        '                                            The default extension is "png".
        '                         3.intGraphType  :  1 for bar graph & 2 for pie graph.
        '                         4.strGraphTitle :  Title for the graph.
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SrikanthY
        ' Created               : 08 Aug 2007  
        ' Revisions             :
        '=====================================================================
        Dim objGraph As New Graph.Graph
        Dim arrSplineChart() As String = {"LINE", "LINE", "LINE", "LINE"}
        Dim strsql As String
        Dim BarChart As New Dundas.Charting.WebControl.Chart
        Dim drGraphSource As SqlClient.SqlDataReader
        objGraph = New Graph.Graph

        'Added by GokulP on 10 Feb 2010 for Graph Type
        Dim drTemp As IDataReader
        Dim arrstrChartType() As String = {}
        Dim i As Integer = 0
        Dim GRAPH_DIRECTORY As String = ""
        GRAPH_DIRECTORY = CStr(CommonFunctions.General.CheckIsNothing((MyBase.GetResourceString("GRAPH_DIRECTORY")), "..\..\Images\Metrics\"))

        drTemp = CommonFunctions.Data.GetDataReader(strQuery, True)

        '-- Build Array for specifying the Chart Type for each column
        ReDim arrstrChartType(drTemp.FieldCount - 1)
        For i = 0 To drTemp.FieldCount - 1
            arrstrChartType(i) = strGraphType
        Next

        If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageName) & ".png") Then
            CommonFunctions.FileDirectory.DeleteFile(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageName) & ".png")
        End If

        CommonFunctions.Data.DisposeDataReader(drTemp)
        'End of Addition by GokulP on 10 Feb 2010 for Graph Type

        With objGraph
            .VirtualImagePath = "../../Images/Metrics/"
            .AbsoluteImagePath = Server.MapPath("../../Images/Metrics/" & strImageName)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            'Commented & Added by GokulP on 10 Feb 2010 for Graph Type
            '.ChartType = arrSplineChart
            .ChartType = arrstrChartType
            'End of Comment & Addition by GokulP on 10 Feb 2010 for Graph Type
            Dim Chart As Dundas.Charting.WebControl.Chart
            '-- Take settings From Database table
            .BorderStyle = "None"
            .BorderColor = "Black"
            .GraphTitleColor = "white"
            .ChartBackColor = "Wheat"
            .ChartAreaColor = "White"
            .ShowLegends = True
            .LegendDocking = "Bottom"
            .LegendStyle = "Column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = True
            .ShowCaptions = True
            .GraphTitleColor = "Black"
            '-- Fixed Settings
            .GraphTitle = strGraphTitle
            .TitleFont = New Font("verdana", 9, FontStyle.Bold)
            .SQL = strQuery
            .Width = 750 '475
            .Height = 260
            .XAxisInterval = 1
            .ShowExplodedPie = False
            .LegendFont = New Font("verdana", 8, FontStyle.Regular)
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .ChartAreaWidth = 98
            .LegendStyle = "Row"

            ' Draw Graph
            .GenerateChartControl()
        End With
        objGraph.Dispose()
    End Function
    'End of addition by SrikanthY on 08 Aug 2007
End Class
