Option Explicit On
'Imports Whizible
Imports CommonFunctions
Public Class ProjectBreakUp_MasterSelection
    Inherits WebPage.Templates.WhizTemplate
#Region "Variable Declaration"
    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private ObjSectionTitle As WebPage.Templates.SectionTitle
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

    Private m_strProjectID As String = ""
    Private m_strProjectName As String = ""
    Private m_strDateFrom As String = ""
    Private m_strDateTo As String = ""
    Private m_strSnapShotDate As String = ""
    Private m_strShow As String = ""

    Public m_strConsiderPrjForPhases As String = "0"
    Public m_strConsiderPrjForMilestones As String = "0"
    'Added by GokulP on 20 Jan 2010 for Deliverable Tab
    Public m_strConsiderPrjForDeliverables As String = "0"
    'End of Addition by GokulP on 20 Jan 2010 for Deliverable Tab
    Protected m_strDivScrollHeight As String = ""
    Public Const PAGE_CAPTION As String = "Phases And Milestones"
    Public Const DETAILS_HEADER As String = "Project BreakUp Details"
    Public Const PHASE_SEC_DETAIL As String = "Phase Details"
    Public Const MODULE_SEC_DETAIL As String = "Milestone Details"
    'Added by GokulP on 20 Jan 2010 for Deliverable Tab
    Public Const DELIVERABLE_SEC_DETAIL As String = "Deliverable Details"
    'End of Addition by GokulP on 20 Jan 2010 for Deliverable Tab
    Public Const MSG_NO_RECORDS = "There are no items to show in this view."
    Public Const TAB_NAME_PHASES = "Phases"
    Public Const TAB_NAME_MILESTONES = "Milestones"
    'Added by GokulP on 20 Jan 2010 for Deliverable Tab
    Public Const TAB_NAME_DELIVERABLES = "Deliverables"
    'End of Addition by GokulP on 20 Jan 2010 for Deliverable Tab
    'Public Const STR_SELECTED_DATA_DETAILS = "Data For Project: '<PROJECT_NAME>' From <FROM_DATE> To <TO_DATE> As On <SNAPSHOT_DATE>"
    Public Const STR_SELECTED_DATA_DETAILS = "Data For Project: '<PROJECT_NAME>' "
    Protected m_strHeaderTables As New System.Text.StringBuilder
    Protected m_strPT As String
    Public strSelectedTitle As String = ""

    Public Enum SelectedTab
        PHASES
        MILESTONES
        'Added by GokulP on 21 Jan 2010 for Deliverable Tab
        DELIVERABLE
        'End of Addition by GokulP on 21 Jan 2010 for Deliverable Tab
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
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' strQuery = "SELECT TOP 1 MAX(FromDate) AS 'FromDate', MAX(ToDate) AS 'ToDate' , MAX(SnapShotDate) AS 'SnapShotDate' FROM Tbl_PRS_MetricHistory_BreakUp"
        strQuery = "usp_sel_Tbl_PRS_MetricHistory_BreakUp"
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        dr = CommonFunctions.Data.GetDataReader(strQuery, True)
        Do While dr.Read
            m_strDateFrom = CommonFunctions.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(dr("FromDate"), CommonFunctions.Dates.GetDate(Now())))
            m_strDateTo = CommonFunctions.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(dr("ToDate"), CommonFunctions.Dates.GetDate(Now())))
            m_strSnapShotDate = CommonFunctions.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(dr("SnapShotdate"), CommonFunctions.Dates.GetDate(Now())))
        Loop
        dr.Dispose()
        m_strProjectID = Session("intProjectID").ToString
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "") <> "" Then
        '    m_strProjectID = Request.QueryString("ProjectID")
        'End If

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
    End Sub
    Private Sub DrawPage()
        '=====================================================================
        ' Sub Name              : DrawPage()	
        ' Purpose               : To draw the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Jab 06, 2006
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Dim drPrjAttributes As IDataReader
        '  DrawFilter()
        CommonFunctions.General.WriteHTML("<DIV id='divPage' Style='overflow:auto;height:625px;width:100%;'>")

        CommonFunctions.General.WriteHTML("<DIV id='divMain' Style='overflow:auto;height:10%;width:100%;'>")
        DrawProjectMetricGrid()
        General.WriteHTML("</DIV>")                     'End of divMain
        'CommonFunctions.General.WriteHTML("<BR>")
        '---------------------------
        strSelectedTitle = Replace(STR_SELECTED_DATA_DETAILS, "<PROJECT_NAME>", m_strProjectName)
        strSelectedTitle = Replace(strSelectedTitle, "<FROM_DATE>", m_strDateFrom)
        strSelectedTitle = Replace(strSelectedTitle, "<TO_DATE>", m_strDateTo)
        strSelectedTitle = Replace(strSelectedTitle, "<SNAPSHOT_DATE>", m_strSnapShotDate)

        CommonFunctions.General.WriteHTML("<TABLE class=clsTable width =100%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
        CommonFunctions.General.WriteHTML("<TD class=clsTROdd colspan = 13 align=right>")
        CommonFunctions.General.WriteHTML("<I>" & strSelectedTitle & "</I>")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        '---------------------------

        'Getting the Setting from tbl_MET_ProjectAttributes
        strQuery = "SELECT ISNULL(ConsiderPhaseLevelMetrics, 0) AS ConsiderPhaseLevelMetrics, ISNULL(ConsiderDeliverableLevelMetrics, 0) AS ConsiderDeliverableLevelMetrics,ISNULL(ConsiderMilestoneLevelMetrics, 0) AS ConsiderMilestoneLevelMetrics " & _
                    " FROM tbl_MET_ProjectAttributes " & _
                    " WHERE ProjectID = " & m_strProjectID
        If m_strProjectID <> "" Then
            drPrjAttributes = CommonFunctions.Data.GetDataReader(strQuery, True)

            Do While drPrjAttributes.Read
                '''m_strConsiderPrjForModules = CommonFunctions.Data.CheckIsDBNull(drPrjAttributes("ConsiderModuleLevelMetrics"), "False")
                m_strConsiderPrjForPhases = CommonFunctions.Data.CheckIsDBNull(drPrjAttributes("ConsiderPhaseLevelMetrics"), "False")
                '''m_strConsiderPrjForSubProjects = CommonFunctions.Data.CheckIsDBNull(drPrjAttributes("ConsiderSubProjectLevelMetrics"), "False")
                '''m_strConsiderPrjForDeliverables = CommonFunctions.Data.CheckIsDBNull(drPrjAttributes("ConsiderDeliverableLevelMetrics"), "False")
                m_strConsiderPrjForMilestones = CommonFunctions.Data.CheckIsDBNull(drPrjAttributes("ConsiderMilestoneLevelMetrics"), "False")
                'Added by GokulP on 21 Jan 2010 for Deliverable Tab
                m_strConsiderPrjForDeliverables = CommonFunctions.Data.CheckIsDBNull(drPrjAttributes("ConsiderDeliverableLevelMetrics"), "False")
                'End of addition by GokulP on 21 Jan 2010 for Deliverable Tab
            Loop
            CommonFunctions.Data.DisposeDataReader(drPrjAttributes)
        End If
        'Phase Grid
        If (m_strConsiderPrjForPhases.Trim = "True") Then
            If m_strShow & "" = "" Then
                m_strShow = "Phase"
            End If
            If UCase(m_strShow) = UCase("Phase") Then
                CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.PHASES))
                DrawPhaseGrid()
            End If
        End If
        'Milestone Grid
        If (m_strConsiderPrjForMilestones.Trim = "True") Then
            If m_strShow & "" = "" Then
                m_strShow = "MileStone"
            End If
            If UCase(m_strShow) = UCase("MileStone") Then
                CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.MILESTONES))
                DrawMileStoneGrid()
            End If
        End If
        'Added by GokulP on 21 Jan 2010 for Deliverable Tab
        'Deliverable Grid
        If (m_strConsiderPrjForDeliverables.Trim = "True") Then
            If m_strShow & "" = "" Then
                m_strShow = "Deliverable"
            End If
            If UCase(m_strShow) = UCase("Deliverable") Then
                CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.DELIVERABLE))
                DrawDeliverableGrid()
            End If
        End If

        'End of Addition by GokulP on 21 Jan 2010 for Deliverable Tab

        General.WriteHTML("</DIV>")                     'End of divPage
        CommonFunctions.General.WriteHTML(m_strHeaderTables.ToString)
    End Sub

    Private Sub DrawProjectMetricGrid()
        '=====================================================================
        ' Sub Name              : DrawProjectMetricGrid()	
        ' Purpose               : To draw the Project Metric Matrix Grid (top Grid)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Jab 09, 2006
        ' Revisions             :
        '=====================================================================
        Dim intPrevPrjTypeID As Integer = 0
        Dim intPrjTypeID As Integer
        Dim intRowCnt As Integer = 1
        Dim intColCnt As Integer
        Dim intCounter As Integer = 0
        Dim strPrjType As String
        Dim arrColNameList As ArrayList = New ArrayList(100)
        Dim blnRowSelected As Boolean
        Dim strProjectID As String
        Dim strMetricName As String

        Dim strSQLQuery As String
        strProjectID = Session("intProjectID").ToString


        Dim drPrjTypePrjMetricData As IDataReader

        'Added on 20th Jan, 2005 to provide the list of projects based on role
        Dim intRoleLevel As Integer
        Dim m_strProjectFilters As String = ""
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        ' m_strProjectFilters = ""
        'If middle level then apply filter for Projects
        'If intRoleLevel = 2 Then
        '    'Apply Role Access Filter for Project List
        '    m_strProjectFilters = ""
        '    Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
        '    If strFilter <> "" Then
        '        m_strProjectFilters += strFilter
        '    End If
        'End If
        'm_strProjectFilters = Replace(UCase(m_strProjectFilters), "ProjectID IN(", "")
        'm_strProjectFilters = Replace(UCase(m_strProjectFilters), ")", "")
        'm_strProjectFilters = Replace(UCase(m_strProjectFilters), "'", "")
        'If m_strPT = "" Then
        strSQLQuery = "usp_Sel_ProjectType_ProjectMetricData '" & strProjectID & "'"
        'Else
        '    strSQLQuery = "usp_Sel_ProjectType_ProjectMetricData '" & m_strProjectFilters & "'," + m_strPT
        'End If
        'strSQLQuery = "usp_Sel_ProjectType_ProjectMetricData "
        'End of Code Added on 20th Jan, 2005 to provide the list of projects based on role
        drPrjTypePrjMetricData = Data.GetDataReader(strSQLQuery, True)
        While (intCounter <= drPrjTypePrjMetricData.FieldCount - 1)
            arrColNameList.Add(drPrjTypePrjMetricData.GetName(intCounter))
            intCounter = intCounter + 1
        End While
        intCounter = 0

        CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width:100%;height:100%;'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblList' class='clsGridTable'width='100%' cellspacing=1 border=0 >")

        DrawHeader(arrColNameList, 1)

        Do While drPrjTypePrjMetricData.Read

            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            intColCnt = drPrjTypePrjMetricData.FieldCount
            intPrjTypeID = drPrjTypePrjMetricData.Item("ProjectTypeID")
            strPrjType = drPrjTypePrjMetricData.Item("ProjectType")
            strProjectID = drPrjTypePrjMetricData.Item("ProjectID")
            If m_strProjectID = "" Then
                m_strProjectID = strProjectID
            End If

            If drPrjTypePrjMetricData("ProjectID") = m_strProjectID Then
                blnRowSelected = True
            Else
                blnRowSelected = False
            End If
            If intPrjTypeID = intPrevPrjTypeID Then
                If blnRowSelected = True Then
                    CommonFunctions.General.WriteHTML("<TR class='clsTR' bgcolor='#f5deb3'>")
                    m_strProjectName = drPrjTypePrjMetricData.Item("Project")
                    intRowCnt = intRowCnt + 1
                ElseIf intRowCnt Mod 2 <> 0 Then
                    CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
                    intRowCnt = intRowCnt + 1
                Else
                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                    intRowCnt = intRowCnt + 1
                End If
                'TD for displaying the image of selected row
                If blnRowSelected = True Then
                    CommonFunctions.General.WriteHTML("<TD align=center>")
                    CommonFunctions.General.WriteHTML("<img src='../../Images/NavNextEnable.gif'>")
                Else
                    CommonFunctions.General.WriteHTML("<TD  onclick=""JavaScript:TD_OnClick('" & drPrjTypePrjMetricData("ProjectID") & "')"" Title='Select Project' align=center style=""CURSOR: hand"">")
                End If

                While intCounter <= intColCnt - 1
                    'For Project Name
                    'First 3 columns contain ProjectTypeID, ProjectType, ProjectID which need not be displayed
                    If intCounter = 3 Then
                        CommonFunctions.General.WriteHTML("<TD>")
                        CommonFunctions.General.WriteHTML(drPrjTypePrjMetricData(arrColNameList.Item(intCounter).ToString))
                        CommonFunctions.General.WriteHTML("</TD>")
                    ElseIf intCounter = 4 Or intCounter = 5 Then
                        'For Start Date and EndDate
                        CommonFunctions.General.WriteHTML("<TD>")
                        CommonFunctions.General.WriteHTML(CommonFunctions.Dates.GetDate(drPrjTypePrjMetricData(arrColNameList.Item(intCounter).ToString)))
                        CommonFunctions.General.WriteHTML("</TD>")
                    End If
                    'CommonFunctions.General.WriteHTML("<TD>")
                    intCounter = intCounter + 1
                End While
                CommonFunctions.General.WriteHTML("</TR>")
                intCounter = 0
                intPrevPrjTypeID = intPrjTypeID
            Else
                intRowCnt = 1
                'CommonFunctions.General.WriteHTML("<TR class='clsTRSectionHeader'>")
                ''We are subtracting 2 bcos there are 2 columns displaying IDs which we dont want to display
                ''CommonFunctions.General.WriteHTML("<TD align=Left colspan=" & (arrColNameList.Count - 2) & ">")
                ''CommonFunctions.General.WriteHTML(strPrjType.ToString)
                ''CommonFunctions.General.WriteHTML("</TD>")
                'CommonFunctions.General.WriteHTML("</TR>")
                If blnRowSelected = True Then
                    CommonFunctions.General.WriteHTML("<TR class='clsTR' bgcolor='#f5deb3'>")
                    m_strProjectName = drPrjTypePrjMetricData.Item("Project")
                    intRowCnt = intRowCnt + 1
                ElseIf intRowCnt Mod 2 <> 0 Then
                    CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
                    intRowCnt = intRowCnt + 1
                ElseIf intCounter = 4 Or intCounter = 5 Then
                    CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                    intRowCnt = intRowCnt + 1
                End If
                'TD for displaying the image of selected row
                If blnRowSelected = True Then
                    CommonFunctions.General.WriteHTML("<TD align=center>")
                    CommonFunctions.General.WriteHTML("<img src='../../Images/NavNextEnable.gif'>")
                    CommonFunctions.General.WriteHTML("</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD  onclick=""JavaScript:TD_OnClick('" & drPrjTypePrjMetricData("ProjectID") & "')"" Title='Select Project' align=center>")
                    CommonFunctions.General.WriteHTML("</TD>")
                End If
                While intCounter <= intColCnt - 1
                    '##################################Code Commented by Noble K on 17th Jan, 2005 to change UI to display the Project Information
                    '                                   and not the MetricDetails ##################################
                    'If intCounter > 3 Then
                    '    CommonFunctions.General.WriteHTML("<TD>")
                    '    'CommonFunctions.General.WriteHTML(FormatNumber(drPrjTypePrjMetricData(arrColNameList.Item(intCounter)), 2))
                    '    If Trim(FormatNumber(drPrjTypePrjMetricData(arrColNameList.Item(intCounter)), 2)) <> Trim("0.00") Then
                    '        CommonFunctions.General.WriteHTML("<A HRef='Javascript:ProjectMetric_OnClick(" & m_strProjectID & "," & arrColNameList.Item(intCounter) & ")'>" & FormatNumber(drPrjTypePrjMetricData(arrColNameList.Item(intCounter)), 2) & "</A>")
                    '    Else
                    '        CommonFunctions.General.WriteHTML(FormatNumber(drPrjTypePrjMetricData(arrColNameList.Item(intCounter)), 2))
                    '    End If
                    '    CommonFunctions.General.WriteHTML("</TD>")
                    'ElseIf intCounter = 3 Then
                    '    CommonFunctions.General.WriteHTML("<TD>")
                    '    'CommonFunctions.General.WriteHTML(drPrjTypePrjMetricData(arrColNameList.Item(intCounter)))
                    '    CommonFunctions.General.WriteHTML("<A HRef='JavaScript:ProjectLink_OnClick(" & m_strProjectID & ")'>" & drPrjTypePrjMetricData(arrColNameList.Item(intCounter)) & "</A>")
                    '    CommonFunctions.General.WriteHTML("</TD>")
                    'End If
                    'intCounter = intCounter + 1
                    '##################################End of Code Commented by Noble K on 17th Jan, 2005 to change UI to display the Project Information
                    '                                and not the MetricDetails ##################################

                    'For Project Name
                    'First 3 columns contain ProjectTypeID, ProjectType, ProjectID which need not be displayed
                    If intCounter = 3 Then
                        CommonFunctions.General.WriteHTML("<TD>")
                        CommonFunctions.General.WriteHTML(drPrjTypePrjMetricData(arrColNameList.Item(intCounter).ToString))
                        CommonFunctions.General.WriteHTML("</TD>")
                    ElseIf intCounter = 4 Or intCounter = 5 Then
                        'For Start Date and EndDate
                        CommonFunctions.General.WriteHTML("<TD>")
                        CommonFunctions.General.WriteHTML(CommonFunctions.Dates.GetDate(drPrjTypePrjMetricData(arrColNameList.Item(intCounter).ToString)))
                        CommonFunctions.General.WriteHTML("</TD>")
                    ElseIf intCounter = 6 Then
                        'CommonFunctions.General.WriteHTML("<TD>")
                        CommonFunctions.General.WriteHTML("<TD align=Left Title=""Metrics Graph"" ><A href=""Javascript:Project_MetricLink_OnClick(" + strProjectID + ")""  >Metrics Graph</A></TD>")
                        CommonFunctions.General.WriteHTML("<TD align=Left Title=""DataPoint Graph"" ><A href=""Javascript:Project_DPLink_OnClick(" + strProjectID + ")""  >Data Points Graph</A></TD>")
                        'CommonFunctions.General.WriteHTML("</TD>")
                    End If
                    intCounter = intCounter + 1
                    'CommonFunctions.General.WriteHTML("<TD>")
                End While
                CommonFunctions.General.WriteHTML("</TR>")
                intCounter = 0
                intPrevPrjTypeID = intPrjTypeID
            End If
        Loop
        CommonFunctions.Data.DisposeDataReader(drPrjTypePrjMetricData)
        General.WriteHTML("</TABLE>") 'End of tblList1
        General.WriteHTML("</DIV>") 'End of divList
        DrawHiddens()
    End Sub

    Private Sub DrawFilter()

        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width=100%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='right' width=30%> Practice &nbsp;&nbsp;&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD align='left' width=40%>")
        'Dim S As String = CommonFunctions.HTMLControls.DrawComboBox("cboPT", "usp_sel_tbl_PRS_ProjectTypes_For_cbo", , m_strPT, "onchange='javascript:PT_Onchange(" + m_strPT + ")'")
        CommonFunctions.HTMLControls.DrawComboBox("cboPT", "usp_sel_tbl_PRS_ProjectTypes_For_cbo", , m_strPT, "onchange='javascript:PT_Onchange()'", True)
        CommonFunctions.General.WriteHTML("</TD><TD></TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

    End Sub
    Private Sub DrawPhaseGrid()
        '=====================================================================
        ' Sub Name              : DrawPhaseGrid()	
        ' Purpose               : To draw the Phase Metric Matrix Grid (Bottom Grid)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Jab 10, 2006
        ' Revisions             :
        '=====================================================================
        Dim arrColNameList As ArrayList = New ArrayList(100)
        Dim intCounter As Integer = 0
        Dim intRowCnt As Integer = 1
        Dim blnHasRows As Boolean = False
        Dim strPhaseID As String

        Dim strSQLQuery As String
        Dim drPrjPhaseMetricData As IDataReader

        'Getting the ProjectName and Replacing the placeholders with appropriate values
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " & m_strProjectID
        strSQLQuery = "usp_sel_Select_tbl_PM_Project " & m_strProjectID
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        drPrjPhaseMetricData = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        Do While drPrjPhaseMetricData.Read
            m_strProjectName = drPrjPhaseMetricData("ProjectName")
        Loop
        CommonFunctions.Data.DisposeDataReader(drPrjPhaseMetricData)

        strSelectedTitle = Replace(STR_SELECTED_DATA_DETAILS, "<PROJECT_NAME>", m_strProjectName)
        strSelectedTitle = Replace(strSelectedTitle, "<FROM_DATE>", m_strDateFrom)
        strSelectedTitle = Replace(strSelectedTitle, "<TO_DATE>", m_strDateTo)
        strSelectedTitle = Replace(strSelectedTitle, "<SNAPSHOT_DATE>", m_strSnapShotDate)

        'strSQLQuery = "usp_Sel_Project_BreakUpMetricData " & m_strProjectID & ", 'PH'"
        strSQLQuery = "usp_Sel_Project_BreakUpData " & m_strProjectID & ", 'PH'"

        drPrjPhaseMetricData = Data.GetDataReader(strSQLQuery, True)
        While (intCounter <= drPrjPhaseMetricData.FieldCount - 1)
            arrColNameList.Add(drPrjPhaseMetricData.GetName(intCounter))
            intCounter = intCounter + 1
        End While
        intCounter = 0

        CommonFunctions.General.WriteHTML("<DIV id='DivDetails' style='Overflow:auto;width:100%;height:70%;'>")
        'PlotHead(strSelectedTitle)
        CommonFunctions.General.WriteHTML("<TABLE id='tblDetails' class='clsGridTable'width='100%' cellspacing=1 border=0 >")

        DrawBreakupHeader(arrColNameList, 2, "Phase")
        'Do While drPrjPhaseMetricData.Read
        While drPrjPhaseMetricData.Read
            strPhaseID = drPrjPhaseMetricData("PhaseID")
            blnHasRows = True
            If intRowCnt Mod 2 <> 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
                intRowCnt = intRowCnt + 1
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                intRowCnt = intRowCnt + 1
            End If
            '''While intCounter < drPrjPhaseMetricData.FieldCount
            '''    If intCounter > 1 Then
            '''        CommonFunctions.General.WriteHTML("<TD align=right>")
            '''        CommonFunctions.General.WriteHTML(FormatNumber(drPrjPhaseMetricData(arrColNameList.Item(intCounter)), 2))
            '''        CommonFunctions.General.WriteHTML("</TD>")
            '''    ElseIf intCounter = 1 Then
            '''        CommonFunctions.General.WriteHTML("<TD>")
            '''        CommonFunctions.General.WriteHTML("<A HRef='JavaScript:PhaseLink_OnClick(" & strPhaseID & ")'>" & drPrjPhaseMetricData(arrColNameList.Item(intCounter)) & "</A>")
            '''        CommonFunctions.General.WriteHTML("</TD>")
            '''    End If
            '''    intCounter = intCounter + 1
            '''End While

            'Added by SrikanthY on 07 Aug 2007 , to show Metric,Datapoint graphs at Below project level , for whizible metrics 3.0
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(drPrjPhaseMetricData(arrColNameList.Item(1).ToString))
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD align=Left Title=""Metrics Graph"" ><A href=""Javascript:PhaseMetricLink_OnClick(" + strPhaseID + ")""  >Metrics Graph</A></TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left Title=""DataPoint Graph"" ><A href=""Javascript:PhaseDPLink_OnClick(" + strPhaseID + ")""  >Data Points Graph</A></TD>")
            'End of Addition by SrikanthY on 07 Aug 2007  
            CommonFunctions.General.WriteHTML("</TR>")
            intCounter = 0
            'Loop
        End While

        If blnHasRows = False Then
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD align=Center colspan=3>")
            CommonFunctions.General.WriteHTML(MSG_NO_RECORDS)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drPrjPhaseMetricData)
        General.WriteHTML("</TABLE>")   'End of tblPhaseDetails
        General.WriteHTML("</DIV>")     'End of divPhaseDetails
    End Sub

    Private Sub DrawMileStoneGrid()
        '=====================================================================
        ' Sub Name              : DrawMileStoneGrid()	
        ' Purpose               : To draw the Milestone Metric Matrix Grid (Bottom Grid)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Feb 07, 2006
        ' Revisions             :
        '=====================================================================
        Dim arrColNameList As ArrayList = New ArrayList(100)
        Dim intCounter As Integer = 0
        Dim intRowCnt As Integer = 1
        Dim blnHasRows As Boolean = False
        Dim strMileStoneID As String
        Dim strSQLQuery As String
        Dim drPrjMilestoneMetricData As IDataReader

        'Getting the ProjectName and Replacing the placeholders with appropriate values
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " & m_strProjectID'
        strSQLQuery = "usp_sel_Select_tbl_PM_Project " & m_strProjectID
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

       

        drPrjMilestoneMetricData = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        Do While drPrjMilestoneMetricData.Read
            m_strProjectName = drPrjMilestoneMetricData("ProjectName")
        Loop
        CommonFunctions.Data.DisposeDataReader(drPrjMilestoneMetricData)

        strSelectedTitle = Replace(STR_SELECTED_DATA_DETAILS, "<PROJECT_NAME>", m_strProjectName)
        strSelectedTitle = Replace(strSelectedTitle, "<FROM_DATE>", m_strDateFrom)
        strSelectedTitle = Replace(strSelectedTitle, "<TO_DATE>", m_strDateTo)
        strSelectedTitle = Replace(strSelectedTitle, "<SNAPSHOT_DATE>", m_strSnapShotDate)


        'strSQLQuery = "usp_Sel_Project_BreakUpMetricData " & m_strProjectID & ", 'ML'"
        strSQLQuery = "usp_Sel_Project_BreakUpData " & m_strProjectID & ", 'ML'"

        drPrjMilestoneMetricData = Data.GetDataReader(strSQLQuery, True)
        While (intCounter <= drPrjMilestoneMetricData.FieldCount - 1)
            arrColNameList.Add(drPrjMilestoneMetricData.GetName(intCounter))
            intCounter = intCounter + 1
        End While
        intCounter = 0

        CommonFunctions.General.WriteHTML("<DIV id='DivDetails' style='Overflow:auto;width:100%;height:70%;'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblDetails' class='clsGridTable'width='100%' cellspacing=1 border=0 >")

         'DrawHeader(arrColNameList, 2)
        DrawBreakupHeader(arrColNameList, 2, "Milestone")
        While drPrjMilestoneMetricData.Read
            '''Do While drPrjMilestoneMetricData.Read
            blnHasRows = True
            strMileStoneID = drPrjMilestoneMetricData("MileStoneID")
            If intRowCnt Mod 2 <> 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
                intRowCnt = intRowCnt + 1
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                intRowCnt = intRowCnt + 1
            End If
            '''While intCounter < drPrjMilestoneMetricData.FieldCount
            '''    If intCounter > 1 Then
            '''        CommonFunctions.General.WriteHTML("<TD align=right>")
            '''        CommonFunctions.General.WriteHTML(FormatNumber(drPrjMilestoneMetricData(arrColNameList.Item(intCounter)), 2))
            '''        CommonFunctions.General.WriteHTML("</TD>")
            '''    ElseIf intCounter = 1 Then
            '''        CommonFunctions.General.WriteHTML("<TD>")
            '''        CommonFunctions.General.WriteHTML("<A HRef='JavaScript:MileStoneLink_OnClick(" & strMileStoneID & ")'>" & drPrjMilestoneMetricData(arrColNameList.Item(intCounter)) & "</A>")
            '''        CommonFunctions.General.WriteHTML("</TD>")
            '''    End If
            '''    intCounter = intCounter + 1
            '''End While

            'Added by SrikanthY on 07 Aug 2007 , to show Metric,Datapoint graphs at Below project level , for whizible metrics 3.0
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(drPrjMilestoneMetricData(arrColNameList.Item(1).ToString))
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD align=Left Title=""Metrics Graph"" ><A href=""Javascript:MileStoneMetricLink_OnClick(" + strMileStoneID + ")""  >Metrics Graph</A></TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left Title=""DataPoint Graph"" ><A href=""Javascript:MileStoneDPLink_OnClick(" + strMileStoneID + ")""  >Data Points Graph</A></TD>")
            'End of Addition by SrikanthY on 07 Aug 2007  

            CommonFunctions.General.WriteHTML("</TR>")
            intCounter = 0
            '''Loop
        End While
        If blnHasRows = False Then
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD align=Center colspan=3>")
            CommonFunctions.General.WriteHTML(MSG_NO_RECORDS)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drPrjMilestoneMetricData)
        General.WriteHTML("</TABLE>")   'End of tblDetails
        General.WriteHTML("</DIV>")     'End of divDetails
    End Sub
    Private Sub DrawDeliverableGrid()
        '=====================================================================
        ' Sub Name              : DrawDeliverableGrid()	
        ' Purpose               : To draw the Deliverable Metric Matrix Grid (Bottom Grid)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : GokulP
        ' Created               : 21 Jan 2010
        ' Revisions             :
        '=====================================================================
        Dim arrColNameList As ArrayList = New ArrayList(100)
        Dim intCounter As Integer = 0
        Dim intRowCnt As Integer = 1
        Dim blnHasRows As Boolean = False
        Dim strDeliverableID As String
        Dim strSQLQuery As String
        Dim drPrjDeliverableMetricData As IDataReader

        'Getting the ProjectName and Replacing the placeholders with appropriate values
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = " & m_strProjectID
        strSQLQuery = "usp_sel_Select_tbl_PM_Project " & m_strProjectID
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

       drPrjDeliverableMetricData = CommonFunctions.Data.GetDataReader(strSQLQuery, True)
        Do While drPrjDeliverableMetricData.Read
            m_strProjectName = drPrjDeliverableMetricData("ProjectName")
        Loop
        CommonFunctions.Data.DisposeDataReader(drPrjDeliverableMetricData)

        strSelectedTitle = Replace(STR_SELECTED_DATA_DETAILS, "<PROJECT_NAME>", m_strProjectName)
        strSelectedTitle = Replace(strSelectedTitle, "<FROM_DATE>", m_strDateFrom)
        strSelectedTitle = Replace(strSelectedTitle, "<TO_DATE>", m_strDateTo)
        strSelectedTitle = Replace(strSelectedTitle, "<SNAPSHOT_DATE>", m_strSnapShotDate)


        'strSQLQuery = "usp_Sel_Project_BreakUpMetricData " & m_strProjectID & ", 'ML'"
        strSQLQuery = "usp_Sel_Project_BreakUpData " & m_strProjectID & ", 'DL'"

        drPrjDeliverableMetricData = Data.GetDataReader(strSQLQuery, True)
        While (intCounter <= drPrjDeliverableMetricData.FieldCount - 1)
            arrColNameList.Add(drPrjDeliverableMetricData.GetName(intCounter))
            intCounter = intCounter + 1
        End While
        intCounter = 0

        CommonFunctions.General.WriteHTML("<DIV id='DivDetails' style='Overflow:auto;width:100%;height:70%;'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblDetails' class='clsGridTable'width='100%' cellspacing=1 border=0 >")

        'DrawHeader(arrColNameList, 2)
        DrawBreakupHeader(arrColNameList, 2, "Deliverable")
        While drPrjDeliverableMetricData.Read
            '''Do While drPrjMilestoneMetricData.Read
            blnHasRows = True
            strDeliverableID = drPrjDeliverableMetricData("DeliverableID")
            If intRowCnt Mod 2 <> 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
                intRowCnt = intRowCnt + 1
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                intRowCnt = intRowCnt + 1
            End If
            '''While intCounter < drPrjMilestoneMetricData.FieldCount
            '''    If intCounter > 1 Then
            '''        CommonFunctions.General.WriteHTML("<TD align=right>")
            '''        CommonFunctions.General.WriteHTML(FormatNumber(drPrjMilestoneMetricData(arrColNameList.Item(intCounter)), 2))
            '''        CommonFunctions.General.WriteHTML("</TD>")
            '''    ElseIf intCounter = 1 Then
            '''        CommonFunctions.General.WriteHTML("<TD>")
            '''        CommonFunctions.General.WriteHTML("<A HRef='JavaScript:MileStoneLink_OnClick(" & strMileStoneID & ")'>" & drPrjMilestoneMetricData(arrColNameList.Item(intCounter)) & "</A>")
            '''        CommonFunctions.General.WriteHTML("</TD>")
            '''    End If
            '''    intCounter = intCounter + 1
            '''End While

            'Added by SrikanthY on 07 Aug 2007 , to show Metric,Datapoint graphs at Below project level , for whizible metrics 3.0
            CommonFunctions.General.WriteHTML("<TD>")
            CommonFunctions.General.WriteHTML(drPrjDeliverableMetricData(arrColNameList.Item(1).ToString))
            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TD align=Left Title=""Metrics Graph"" ><A href=""Javascript:DeliverableMetricLink_OnClick(" + strDeliverableID + ")""  >Metrics Graph</A></TD>")
            CommonFunctions.General.WriteHTML("<TD align=Left Title=""DataPoint Graph"" ><A href=""Javascript:DeliverableDPLink_OnClick(" + strDeliverableID + ")""  >Data Points Graph</A></TD>")
            'End of Addition by SrikanthY on 07 Aug 2007  

            CommonFunctions.General.WriteHTML("</TR>")
            intCounter = 0
            '''Loop
        End While
        If blnHasRows = False Then
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD align=Center colspan=3>")
            CommonFunctions.General.WriteHTML(MSG_NO_RECORDS)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If

        CommonFunctions.Data.DisposeDataReader(drPrjDeliverableMetricData)
        General.WriteHTML("</TABLE>")   'End of tblDetails
        General.WriteHTML("</DIV>")     'End of divDetails
    End Sub
    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Noble K
        ' Created               : 06 Jan, 2006
        ' Revisions             :
        '=====================================================================
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
        CommonFunctions.General.WriteHTML("Metrics Graph")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML("Data Points Graph")
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
        ' Create the Tab structure all the tabs 
        txtResult.Append("<TD nowrap class=clsLinkPageHeaderInner>")
        '   1- Phases
        If SelectedTabValue = SelectedTab.PHASES Then

            If m_strConsiderPrjForMilestones.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_MILESTONES + "' href='javascript:MilestoneTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_MILESTONES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If m_strConsiderPrjForPhases.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_PHASES + "' href='javascript:PhaseTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_PHASES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_PHASES + "'>" + TAB_NAME_PHASES + "&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            ''Added by GokulP on 21 Jan 2010 for Deliverable Tab
            If m_strConsiderPrjForDeliverables.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_DELIVERABLES + "' href='javascript:DeliverableTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_DELIVERABLES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_PHASES + "'>" + TAB_NAME_PHASES + "&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            ''End of Addition by GokulP on 21 Jan 2010 for Deliverable Tab
        End If

        '   2 - Milestones
        If SelectedTabValue = SelectedTab.MILESTONES Then

            If m_strConsiderPrjForMilestones.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_MILESTONES + "' href='javascript:MilestoneTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_MILESTONES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_MILESTONES + "'>" + TAB_NAME_MILESTONES + "&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If m_strConsiderPrjForPhases.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_PHASES + "' href='javascript:PhaseTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_PHASES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            ''Added by GokulP on 21 Jan 2010 for Deliverable Tab
            If m_strConsiderPrjForDeliverables.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_DELIVERABLES + "' href='javascript:DeliverableTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_DELIVERABLES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            ''End of Addition by GokulP on 21 Jan 2010 for Deliverable Tab
        End If

        ''Added by GokulP on 21 Jan 2010 for Deliverable Tab
        '   3 - Deliverable
        If SelectedTabValue = SelectedTab.DELIVERABLE Then

            If m_strConsiderPrjForMilestones.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_MILESTONES + "' href='javascript:MilestoneTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_MILESTONES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                'txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_MILESTONES + "'>" + TAB_NAME_MILESTONES + "&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If m_strConsiderPrjForPhases.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_PHASES + "' href='javascript:PhaseTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_PHASES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If m_strConsiderPrjForDeliverables.Trim = "True" Then
                txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsSelected'   Title='" + TAB_NAME_DELIVERABLES + "' href='javascript:DeliverableTab_OnClick(""" + m_strProjectID + """)'>" + TAB_NAME_DELIVERABLES + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

        End If
        ''End of Addition by GokulP on 21 Jan 2010 for Deliverable Tab
        txtResult.Append("<TD height='10px' width='100%'></td>")
        txtResult.Append("</TR><TR ><TD  height='10px' colspan=3 class=clsLinkPageHeaderInner></TD></TR></TABLE>")

        strResult = txtResult.ToString
        txtResult = Nothing

        Return strResult

    End Function
End Class
