
'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhiziblePPM
' Module Name           :  ProjectDataPoint_EntrySheet.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
Imports Whizible
'Imports Whizible

#End Region

Public Class ProjectDataPoint_EntrySheet
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0

    Private m_strFromDate As String
    Private m_strToDate As String
    'Private m_strSnapShotdate As String
    Protected m_strSnapShotdate As String
    Protected m_strProjectID As String = "0"
    Private m_strProjectName As String = ""
    Private m_strIsMetricDate As String = "0"
    Private m_strIsCurrentDate As String = "0"
    Protected m_strMode As String
    Protected m_strFromPage As String = ""
    Public m_blnPhaseBreakUpData As Boolean = False
    Public m_blnMilestoneBreakUpData As Boolean = False
    Public m_blnProjectData As Boolean = False

    'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
    Public m_blnDeliverableBreakUpData As Boolean = False
    'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab

    'Code added by vidyak for Change in Grid pltting logic for Phase,Mileastone 

    Private m_arrstrMeasurementsIDList As New ArrayList(100)
    Private m_arrstrMeasurementsCodeList As New ArrayList(100)

    Private m_arrstrMeasurementsPhaseIDList As New ArrayList(100)
    Private m_arrstrMeasurementsPhaseCodeList As New ArrayList(100)

    Private m_arrstrMeasurementsMileStIDList As New ArrayList(100)
    Private m_arrstrMeasurementsMileStCodeList As New ArrayList(100)

    Private m_arrstrMeasurementsDeliverableList As New ArrayList(100)
    Private m_arrstrMeasurementsDeliverableCodeList As New ArrayList(100)
    'End of Code added by vidyak for Change in Grid pltting logic for Phase,Mileastone 


    '''Private m_arrstrMetricsIDList As New ArrayList(100)
    Dim strMetricView As String
    Private Const PAGE_HEADER = "Project Datapoint Entry Sheet"
    Private m_strSnapShotID As String

    Private m_ShowProjectDiv As Integer
    Private m_ShowPhaseDiv As Integer
    Private m_ShowMilestoneDiv As Integer

    Private m_strFromTab As String

    'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
    Private m_ShowDeliverableDiv As Integer
    'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
    Public Const TAB_NAME_Project = "Project"
    Public Const TAB_NAME_Phase = "Phase"
    Public Const TAB_NAME_Milestone = "Milestone"
    Public Const TAB_NAME_Deliverable = "Deliverable"

    Public Enum SelectedTab
        Project
        Phase
        Milestone
        Deliverable
    End Enum

#End Region

#Region "Functions and Sub-Procedures"

    Private Sub Initializations()
        '=====================================================================
        ' Procedure Name        : Initializations
        ' Purpose               : To do all the initializations
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Feb 15, 2006
        ' Revisions             :
        '=====================================================================
        Dim strFirstDateOfMonth As String = ""
        Dim strSPProject As String
        Dim strDateSP As String
        Dim strCurrentDate As String
        Dim strMode As String
        Dim strSPForMeasurementsIDList As String
        Dim strSPForMetricIDList As String
        Dim intDaysInMonth As Integer
        Dim drForSPProject As IDataReader
        Dim drForDate As IDataReader
        Dim intIsDateGreaterthanToday As Integer
        'commented & Added by GokulP on 22 Jan 2010 for Removing Filter
        'Project Related Query String Formatting
        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "") = "" Then
        '    strSPProject = "usp_Sel_Project_Milestone_Phases_Measurements '" & m_strToDate & "'"
        '    drForSPProject = CommonFunctions.Data.GetDataReader(strSPProject, MyBase.UseSQL)
        '    Dim intCounter As Integer = 0
        '    Do While drForSPProject.Read
        '        If intCounter = 0 Then
        '            m_strProjectID = drForSPProject("ProjectID")
        '            m_strProjectName = drForSPProject("ProjectName")
        '        End If
        '        intCounter = intCounter + 1
        '    Loop
        '    CommonFunctions.Data.DisposeDataReader(drForSPProject)

        '    If m_strProjectID = "0" And CommonFunctions.General.CheckIsNothing(Request("txtProject"), "") <> "" Then
        '        m_strProjectID = Request("txtProject")
        '        Dim strSQL As String = "SELECT ProjectName from tbl_PM_Project WHERE ProjectID = " & m_strProjectID
        '        drForSPProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        '        Do While drForSPProject.Read
        '            m_strProjectName = drForSPProject("ProjectName")
        '        Loop
        '        CommonFunctions.Data.DisposeDataReader(drForSPProject)
        '    End If
        'Else
        '    m_strProjectID = Request.QueryString("ProjectID")
        m_strProjectID = Session("intProjectID").ToString
        'End of comment & Addition by GokulP on 22 Jan 2010 for Removing Filter
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'Dim strSQL As String = "SELECT ProjectName from tbl_PM_Project WITH (NOLOCK) WHERE ProjectID = " & m_strProjectID
        Dim strSQL As String = "usp_sel_Select_tbl_PM_Project " & m_strProjectID

        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


        drForSPProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drForSPProject.Read
            m_strProjectName = drForSPProject("ProjectName")
        Loop
        CommonFunctions.Data.DisposeDataReader(drForSPProject)
        'commented by GokulP on 22 Jan 2010 for Removing Filter
        'End If
        'End of comment by GokulP on 22 Jan 2010 for Removing Filter


        'strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1"
        'drForSPProject = CommonFunctions.Data.GetDataReader(strSPForMeasurementsIDList, MyBase.UseSQL)
        'Do While drForSPProject.Read
        '    m_arrstrMeasurementsIDList.Add(drForSPProject("MeasurementID"))
        '    m_arrstrMeasurementsCodeList.Add(drForSPProject("MeasurementCode"))
        '    m_arrstrMeasurementsNameList.Add(drForSPProject("UserFriendlyName"))
        'Loop
        'CommonFunctions.Data.DisposeDataReader(drForSPProject)

        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SavePhaseData" Then

        strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1"
        If strSPForMeasurementsIDList <> "" Then
            drForSPProject = CommonFunctions.Data.GetDataReader(strSPForMeasurementsIDList, MyBase.UseSQL)
            Do While drForSPProject.Read
                If drForSPProject("Name") = "Phase" Then
                    m_arrstrMeasurementsPhaseIDList.Add(drForSPProject("MeasurementID"))
                    m_arrstrMeasurementsPhaseCodeList.Add(drForSPProject("MeasurementCode"))
                ElseIf drForSPProject("Name") = "Milestone" Then
                    m_arrstrMeasurementsMileStIDList.Add(drForSPProject("MeasurementID"))
                    m_arrstrMeasurementsMileStCodeList.Add(drForSPProject("MeasurementCode"))
                ElseIf drForSPProject("Name") = "Deliverable" Then
                    m_arrstrMeasurementsDeliverableList.Add(drForSPProject("MeasurementID"))
                    m_arrstrMeasurementsDeliverableCodeList.Add(drForSPProject("MeasurementCode"))
                End If

            Loop
            CommonFunctions.Data.DisposeDataReader(drForSPProject)
        End If


        'strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1,2"
        'If strSPForMeasurementsIDList <> "" Then
        '    drForSPProject = CommonFunctions.Data.GetDataReader(strSPForMeasurementsIDList, MyBase.UseSQL)
        '    Do While drForSPProject.Read
        '        m_arrstrMeasurementsMileStIDList.Add(drForSPProject("MeasurementID"))
        '        m_arrstrMeasurementsMileStCodeList.Add(drForSPProject("MeasurementCode"))
        '    Loop
        '    CommonFunctions.Data.DisposeDataReader(drForSPProject)
        'End If


        'strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1,2"
        'If strSPForMeasurementsIDList <> "" Then
        '    drForSPProject = CommonFunctions.Data.GetDataReader(strSPForMeasurementsIDList, MyBase.UseSQL)
        '    Do While drForSPProject.Read
        '        m_arrstrMeasurementsMileStIDList.Add(drForSPProject("MeasurementID"))
        '        m_arrstrMeasurementsMileStCodeList.Add(drForSPProject("MeasurementCode"))
        '    Loop
        '    CommonFunctions.Data.DisposeDataReader(drForSPProject)
        'End If

        'ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SaveMilestoneData" Then
        '    strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1,2"
        'ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SaveDeliverableData" Then
        '    strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1,3"
        'Else
        '    strSPForMeasurementsIDList = "usp_Sel_Measurements_For_Project " & m_strProjectID & ",1"
        'End If

        'If strSPForMeasurementsIDList <> "" Then
        '    drForSPProject = CommonFunctions.Data.GetDataReader(strSPForMeasurementsIDList, MyBase.UseSQL)
        '    Do While drForSPProject.Read
        '        m_arrstrMeasurementsIDList.Add("P", drForSPProject("MeasurementID"))
        '        'm_arrstrMeasurementsCodeList.Add(drForSPProject("MeasurementCode"))
        '    Loop
        '    CommonFunctions.Data.DisposeDataReader(drForSPProject)
        'End If


        'strSPForMetricIDList = "usp_Sel_Metrics_For_Project " & m_strProjectID & ", NULL, 1"
        'drForSPProject = CommonFunctions.Data.GetDataReader(strSPForMetricIDList, MyBase.UseSQL)
        'Do While drForSPProject.Read
        '    m_arrstrMetricsIDList.Add(drForSPProject(0))
        'Loop

        'Date Related Query String Formatting
        'Added by RathinP on 26/06/2007 
        'To Integrate Weekly View
        strMetricView = CommonFunctions.Data.GetDataScalar(" SELECT DBO.UDF_Get_TBL_MET_FREQUENCYTYPES(" + Session("intProjectID").ToString + ") ", MyBase.UseSQL)
        Select Case (strMetricView.ToUpper)

            Case "MONTHLY"

                If CommonFunctions.General.CheckIsNothing(Request.QueryString("DateMode"), "") = "NextMonth" Then
                    strCurrentDate = Request("txthdnCurrentDate")
                    strMode = "NEXT"

                ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("DateMode"), "") = "PreviousMonth" Then
                    strCurrentDate = Request("txthdnCurrentDate")
                    strMode = "PREVIOUS"

                ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("DateMode"), "") = "CurrentMonth" Then
                    If Request("txthdnCurrentDate") Is Nothing Then
                        strCurrentDate = Now.Date
                    Else
                        strCurrentDate = Request("txthdnCurrentDate")
                    End If
                    strMode = "CURRENT"
                Else
                    If Request("txthdnCurrentDate") Is Nothing Then
                        strCurrentDate = Now.Date
                    Else
                        strCurrentDate = Request("txthdnCurrentDate")
                    End If
                    ' strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "CURRENT")
                    strMode = "CURRENT"
                End If
                m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper
                m_strFromPage = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromPage"), "").ToUpper
                'strCurrentDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "")
                If m_strProjectID <> "0" Then
                    If m_strMode = "ADD_NEW" Then
                        'In ADD_NEW Mode when a Project is Selected Next Date should appear i.e.
                        strSQL = "Usp_GetDate_For_Measurement " & m_strProjectID
                        strCurrentDate = CDate(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        ' m_strDate = strDateTime 'Set Global Date variable
                        'If snap shot date is greater that today's date then redirect to CL page
                        'strSnapshotdate = strCurrentDate.ToString("yyyy-MM-dd")
                        '  strSQL = "usp_Check_SnapshotDate '" & strCurrentDate.ToString("yyyy-MM-dd") & "'"
                        strSQL = "usp_Check_SnapshotDate '" & strCurrentDate & "'"
                        intIsDateGreaterthanToday = CInt(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        If intIsDateGreaterthanToday = 0 Then
                            Response.Write("<script> alert(""" & MyBase.GetResourceString("FUTURE_DATE_ENTRIES_ALERT") & """) ;return;</script>")
                            'Response.Redirect("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&Date=GreaterThanToday&Mode=ADD_NEW")
                        End If

                    Else
                        'In EDIT_MODE the last SnapShotDate should appear.
                        If CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "0")) <> "0" Then
                            strCurrentDate = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "0"))
                            If strCurrentDate <> "0" Then
                                strCurrentDate = CDate(strCurrentDate)
                            End If
                        End If

                    End If
                End If


                ' strCurrentDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "")

                strDateSP = "usp_Sel_Month_Details '" & strCurrentDate & "', '" & strMode & "'," & m_strProjectID
                drForDate = CommonFunctions.Data.GetDataReader(strDateSP, MyBase.UseSQL)
                Do While drForDate.Read
                    m_strFromDate = drForDate("FromDate")
                    m_strToDate = drForDate("ToDate")
                    m_strSnapShotdate = drForDate("ToDate")
                    m_strIsMetricDate = drForDate("IsEqualToMetricStartDate")
                    m_strIsCurrentDate = drForDate("IsEqualToToday")
                Loop
                CommonFunctions.Data.DisposeDataReader(drForDate)
                'Vidyak
                'm_strFromDate = CommonFunctions.Dates.GetDate(CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), ""))
                ' m_strFromDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "")

            Case "WEEKLY"

                If CommonFunctions.General.CheckIsNothing(Request.QueryString("DateMode"), "") = "NextWeek" Then
                    strCurrentDate = Request("txthdnCurrentDate")
                    strMode = "NEXT"

                ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("DateMode"), "") = "PreviousWeek" Then
                    strCurrentDate = Request("txthdnCurrentDate")
                    strMode = "PREVIOUS"

                ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("DateMode"), "") = "CurrentWeek" Then
                    If Request("txthdnCurrentDate") Is Nothing Then
                        strCurrentDate = Now.Date
                    Else
                        strCurrentDate = Request("txthdnCurrentDate")
                    End If
                    strMode = "CURRENT"
                Else
                    If Request("txthdnCurrentDate") Is Nothing Then
                        strCurrentDate = Now.Date
                    Else
                        strCurrentDate = Request("txthdnCurrentDate")
                    End If
                    strMode = "CURRENT"
                End If
                m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper
                m_strFromPage = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromPage"), "").ToUpper
                If m_strProjectID <> "0" Then
                    If m_strMode.ToUpper = "ADD_NEW" Then
                        'In ADD_NEW Mode when a Project is Selected Next Date should appear i.e.
                        strSQL = "Usp_GetDate_For_Measurement " & m_strProjectID
                        strCurrentDate = CDate(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        ' m_strDate = strDateTime 'Set Global Date variable
                        'If snap shot date is greater that today's date then redirect to CL page
                        'strSnapshotdate = strCurrentDate.ToString("yyyy-MM-dd")
                        strSQL = "usp_Check_SnapshotDate '" & CDate(strCurrentDate).ToString("yyyy-MM-dd") & "'"
                        intIsDateGreaterthanToday = CInt(CommonFunctions.Data.GetDataScalar(strSQL, True))
                        If intIsDateGreaterthanToday = 0 Then
                            Response.Redirect("../METRICS/MB_ProjectMeasurementsHistory.aspx?Action=ADD&Date=GreaterThanToday&Mode=ADD_NEW")
                        End If

                    Else
                        If CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "0")) <> "0" Then
                            strCurrentDate = CStr(CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "0"))
                            If strCurrentDate <> "0" Then
                                strCurrentDate = CDate(strCurrentDate)
                            End If
                        End If
                    End If
                End If


                strDateSP = "usp_Sel_Weekly_Details '" & strCurrentDate & "', '" & strMode & "'," & m_strProjectID
                drForDate = CommonFunctions.Data.GetDataReader(strDateSP, MyBase.UseSQL)
                Do While drForDate.Read
                    m_strFromDate = drForDate("FromDate")
                    m_strToDate = drForDate("ToDate")
                    m_strSnapShotdate = drForDate("ToDate")
                    m_strIsMetricDate = drForDate("IsEqualToMetricStartDate")
                    m_strIsCurrentDate = drForDate("IsEqualToToday")
                Loop
                CommonFunctions.Data.DisposeDataReader(drForDate)
        End Select
        'End of Addition by RathinP

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ShowProjectDiv"), "") <> "" Then
            m_ShowProjectDiv = CType(Request.QueryString("ShowProjectDiv"), String)
        ElseIf CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtShowProjectDiv"), "") <> "" Then
            m_ShowProjectDiv = CType(MyBase.GetFormValue("txtShowProjectDiv"), String)
        Else
            m_ShowProjectDiv = "1"
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ShowPhaseDiv"), "") <> "" Then
            m_ShowPhaseDiv = CType(Request.QueryString("ShowPhaseDiv"), String)
        ElseIf CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtShowPhaseDiv"), "") <> "" Then
            m_ShowPhaseDiv = CType(MyBase.GetFormValue("txtShowPhaseDiv"), String)
        Else
            m_ShowPhaseDiv = "1"
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ShowMilestoneDiv"), "") <> "" Then
            m_ShowMilestoneDiv = CType(Request.QueryString("ShowMilestoneDiv"), String)
        ElseIf CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtShowMilestoneDiv"), "") <> "" Then
            m_ShowMilestoneDiv = CType(MyBase.GetFormValue("txtShowMilestoneDiv"), String)
        Else
            m_ShowMilestoneDiv = "1"
        End If

        'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ShowDeliverableDiv"), "") <> "" Then
            m_ShowDeliverableDiv = CType(Request.QueryString("ShowDeliverableDiv"), String)
        ElseIf CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtShowDeliverableDiv"), "") <> "" Then
            m_ShowDeliverableDiv = CType(MyBase.GetFormValue("txtShowDeliverableDiv"), String)
        Else
            m_ShowDeliverableDiv = "1"
        End If
        'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab

        'Added for fousoft

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromTab"), "") <> "" Then
            m_strFromTab = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromTab"), "0")
        Else
            m_strFromTab = "0"
        End If


        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SaveMilestoneData" Then
            Call SaveBreakUpData("Milestone")      'Action Related Query String Formatting


        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SavePhaseData" Then
            Call SaveBreakUpData("Phase")

            'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "SaveDeliverableData" Then
            Call SaveBreakUpData("Deliverable")
            'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab

        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "GeneratePhaseReport" Then
            '   Call GenerateReport("Phase")

        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "GenerateMilestoneReport" Then
            ' Call GenerateReport("Milestone")
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "ProjectSave" Then
            'Added by SrikanthY on 12 Jul 2007 for Whizible Metrics 3.0	
            SaveProjectData()
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "ReGenerate" Then
            'Added by SrikanthY on 12 Jul 2007 for Whizible Metrics 3.0	
            ReGenerateData()
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "AfterProjectSave" Then
            'm_strToDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("SnapShotDate"), "")
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "GenerateData" Then
            ProcessMigration_N_Calculation()
        End If

        m_strSnapShotID = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PRS_GenerateData_ProjectLevel " & m_strProjectID & ",'" & m_strSnapShotdate & "'", MyBase.UseSQL), "")


    End Sub
    Private Sub ProcessMigration_N_Calculation()
        Dim strXMLString As String = ""
        If m_strMode.ToUpper = "GENERATEDATA" Then
            'Added by SrikanthY on 19 Jun 2007 to move Generation Logic To Service
            Dim strSQL As String
            strSQL = " USP_INS_TBL_MET_METRIC_GENERATEDATA_QUEUE  '" & m_strSnapShotdate & "','" & m_strFromDate & "','" & m_strToDate & "'," & Session("intProjectID").ToString
            CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            Response.Write("<script>alert(""SnapshotDate has been saved in Queue , Data will be Generated through Service in regular intervals !"");")
            'End of addition by SrikanthY on 19 Jun 2007

            'Added by GokulP on 02 Feb 2010 for goto list page
            Response.Write("window.location.href = ""../METRICS/MB_MetricCommonList.aspx?CMode=PND&Mode=ADD_NEW&MasterTagID=2523&FromWhere=PM&ParentTagID=0&FromCL=1;""")
            Response.Write("</script>")
            'End of Addition by GokulP on 02 Feb 2010 for goto list page

            'Response.Clear()
            'Response.Write(strXMLString)
            'ElseIf m_strAction.ToUpper = "GALL" Then
            '    m_blnDone = GenarateAll()
        End If
    End Sub
    Sub SaveProjectData()
        '=====================================================================
        ' Procedure Name        :	SaveProjectData
        ' Purpose               :	Handles the SAVE of data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SrikanthY
        ' Created               :	Jul 11, 2007 
        ' Revisions             :
        '=====================================================================

        Dim lngMeasurementsHistoryID As Long
        Dim lngProjectID As Long
        Dim strProjectID As String
        Dim strSQL As String
        Dim strMode As String
        Dim blnUseSQl As Boolean
        Dim dblFunctionValue As Double
        Dim drReader As IDataReader
        Dim intResult As Integer
        Dim strSnapShotDate As String
        Dim strFromDate As String
        Dim FromDPMaster As String
        Dim ValuePresent As Integer
        strProjectID = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtProject"), "0")
        strSnapShotDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDate"), Date.Now.ToString)
        strFromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFromDate"), Date.Now.ToString)

        blnUseSQl = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        FromDPMaster = MyBase.GetFormValue("txtFromDPMaster")
        If FromDPMaster = "0" Then
            'strSQL = "Select MeasurementsHistoryID from tbl_PRS_Measurements_History where ProjectID=" & strProjectID & " and DateDiff(dd,SnapShotDate,'" & strSnapShotDate & "')=0"
            strSQL = " usp_sel_tbl_PRS_Measurements_For_MB_ProjectMeasureentsHistory_Revised " & strProjectID & ",'" & strSnapShotDate & "'"
            drReader = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQl)
            While drReader.Read()
                lngMeasurementsHistoryID = CLng(CommonFunctions.Data.CheckIsDBNull(drReader.Item("MeasurementID"), "0"))
                dblFunctionValue = CDbl(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("txtProjectDP" + lngMeasurementsHistoryID.ToString), "0"))
                ValuePresent = CInt(CommonFunctions.Data.CheckIsDBNull(drReader.Item("ValuePresent"), "0"))

                If ValuePresent = 0 Then
                    strSQL = "usp_ins_tbl_PRS_Measurements_History  '" & drReader.Item("MeasurementCode").ToString & "'," & strProjectID & ",'" & strSnapShotDate & "'," & dblFunctionValue & ",'" & strFromDate & "'"  'REPLACE(CONVERT(VARCHAR(12),getDate(),102),'.','-')
                ElseIf CommonFunctions.Data.CheckIsDBNull(drReader.Item("IsEditable"), "False") Then
                    strSQL = "usp_upd_tbl_PRS_Measurements_History  " & dblFunctionValue & "," & lngMeasurementsHistoryID
                End If
                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQl)
            End While
            CommonFunctions.Data.DisposeDataReader(drReader)
        Else
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            strSQL = "Select MeasurementID,MeasurementCode from tbl_PRS_Measurements Where MeasurementID IN (Select MeasurementID from tbl_MET_Project_Measurements where ProjectID=" & strProjectID & " and IsEditable=1) Order By MeasurementCode ASC"
            strSQL = "usp_sel_MeasurementCode_tbl_PRS_Measurements " + strProjectID

            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            drReader = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQl)
            While drReader.Read()
                dblFunctionValue = CDbl(CommonFunctions.General.CheckIsNothing((MyBase.GetFormValue("txtProjectDP" + drReader(0).ToString)), "0"))
                strSQL = "usp_ins_tbl_PRS_Measurements_History  '" & drReader.Item("MeasurementCode").ToString & "'," & strProjectID & ",'" & strSnapShotDate & "'," & dblFunctionValue & ",'" & strFromDate & "'" 'REPLACE(CONVERT(VARCHAR(12),getDate(),102),'.','-')
                CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQl)
            End While
            CommonFunctions.Data.DisposeDataReader(drReader)
        End If


        'Response.Redirect("../PRJBU/ProjectDataPoint_EntrySheet.aspx?Mode=CURRENT&ProjectID=" + strProjectID + "&SnapShotDate=" & strSnapShotDate & "")
        SaveSnapshotDetails(strProjectID, strSnapShotDate)
    End Sub

    Sub ReGenerateData()
        Dim m_blnDone As Boolean
        Dim strProjectID As String = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtProject"), "0")
        Dim strGenerate As String
        ClearDataForProject(strProjectID, m_strSnapShotdate)
        m_blnDone = MeasurementDataMigration(strProjectID, m_strSnapShotdate, m_strFromDate, m_strToDate)
        m_blnDone = MetricCalculation(strProjectID, m_strSnapShotdate, m_strFromDate, m_strToDate)
        If m_blnDone = True Then
            Response.Write("<script>alert('Data Regenerated Successfully for this period')</script>")
            strGenerate = "UPDATE tbl_PRS_GenerateData_ProjectLevel SET IsReGenerated=1 WHERE PROJECTID=" + strProjectID + "AND DATEDIFF(DD,SnapShotDate,'" + m_strSnapShotdate + "')=0 "
            CommonFunctions.Data.InsertOrUpdateData(strGenerate, MyBase.UseSQL)
        End If
    End Sub

    Sub ClearDataForProject(ByVal ProjectID As String, ByVal strSnapShotDate As String)
        Dim strProject As String = " usp_Del_tbl_PRS_MetricHistory_Project " + ProjectID + ",'" + strSnapShotDate + "'"
        CommonFunctions.Data.InsertOrUpdateData(strProject, MyBase.UseSQL)
    End Sub

    Private Function MeasurementDataMigration(ByVal ProjectID As String, ByVal strSnapShotDate As String, ByVal strFromDate As String, ByVal strToDate As String) As Boolean
        Dim strSQLQuery As String

        Try
            strSQLQuery = "Exec usp_ins_tbl_PRS_Measurements_History_Calculation_Project " + ProjectID + ",'" & strSnapShotDate & "','" & strFromDate & "','" & strToDate & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)

            MeasurementDataMigration = True
        Catch ex As Exception
            MeasurementDataMigration = False
        Finally

        End Try
    End Function

    Private Function MetricCalculation(ByVal ProjectID As String, ByVal strSnapShotDate As String, ByVal strFromDate As String, ByVal strToDate As String) As Boolean
        Dim blnUseSQL As Boolean
        Dim strSQLQuery As String
        Try
            blnUseSQL = MyBase.UseSQL
            strSQLQuery = "usp_ins_tbl_PRS_MetricHistory_Calculation_Project  " + ProjectID + ",'" & strSnapShotDate & "','" & strFromDate _
                            & "','" & strToDate & "'"

            CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, blnUseSQL)

            MetricCalculation = True
        Catch ex As Exception
            MetricCalculation = False
        Finally

        End Try
    End Function

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
        ' Created               : Feb 15, 2006
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
        ' Created               : Feb 15, 2005
        ' Revisions             :
        '=====================================================================
        Dim strHTML As String = ""
        'vidya
        Dim strHeader As String = "Extenal Data Points For Project '" & m_strProjectName & "' From " & CommonFunctions.Dates.GetDate(m_strFromDate) & vbTab & "To " & CommonFunctions.Dates.GetDate(m_strToDate) & vbTab & "As On " & CommonFunctions.Dates.GetDate(m_strSnapShotdate)
        Dim objHeaderFooter As New WebPages.Template.HeaderFooter

        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER
        'vidya
        objHeaderFooter.HeaderFooter = "<B>" & strHeader & "</B>"
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
        ' Parameters Passed     : intFlag - determines where top menu or submenu
        '                           0 - Page Level Links
        '                           1 - Header Level Links                            
        ' Returns               : String which contains the HTML Code for plotting 
        '                            the menu
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Feb 15, 2006
        ' Revisions             :
        '=====================================================================
        'Added by RathinP on 26/06/2007 
        'To Integrate Weekly View

        Dim strMenu As String
        Dim alMenu As New ArrayList
        Dim alMenuToolTip As New ArrayList
        Dim alClientSideFunctions As New ArrayList
        alMenu.Add("Close") : alMenuToolTip.Add("Close") : alClientSideFunctions.Add("Close_OnClick()")
        'Select Case (strMetricView.ToUpper)



        '    Case "MONTHLY"
        '        If m_strIsMetricDate.Trim = "True" Then

        '            'Dim arrMenu() As String = {"Re Generate", "Next Month", " ? "}
        '            'Dim arrMenuToolTip() As String = {"Re Generate", "Next Month", "Help"}
        '            'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        '            'Return strMenu

        '            'Code added by VidyaK
        '            If (m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "SAVEMILESTONEDATA" Or m_strMode.ToUpper = "SAVEPHASEDATA" Or m_strMode.ToUpper = "SAVEDELIVERABLEDATA" Or m_strMode.ToUpper = "PROJECTSAVE") And m_strFromPage.ToUpper = "GENERATEDATAPAGE" Then
        '                alMenu.Add("Generate") : alMenuToolTip.Add("Generate") : alClientSideFunctions.Add("Generate()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("BackFrmGenerate_OnClick()")
        '                'End of code added by VidyaK
        '            Else

        '                'Commented by VidyaK
        '                'If m_strSnapShotID <> "" Then
        '                '    alMenu.Add("Re Generate") : alMenuToolTip.Add("Re Generate") : alClientSideFunctions.Add("ReGenerate()")
        '                'End If
        '                'End of code Commented by VidyaK
        '                If m_strIsCurrentDate.Trim = "False" Then
        '                    alMenu.Add("Next Month") : alMenuToolTip.Add("Next Month") : alClientSideFunctions.Add("NextMonth_OnClick()")
        '                End If
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("Back_OnClick()")
        '                alMenu.Add(" ? ") : alMenuToolTip.Add("Help") : alClientSideFunctions.Add("Help_OnClick()")
        '            End If
        '        ElseIf m_strIsCurrentDate.Trim = "True" Then

        '            'Dim arrMenu() As String = {"Re Generate", "Previous Month", " ? "}
        '            'Dim arrMenuToolTip() As String = {"Re Generate", "Previous Month", "Help"}
        '            'Dim arrClientSideFunctions() As String = {"ReGenerate()", "PreviousMonth_OnClick()", "Help_OnClick()"}
        '            'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        '            'Return strMenu
        '            'Code added by VidyaK
        '            If (m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "SAVEMILESTONEDATA" Or m_strMode.ToUpper = "SAVEPHASEDATA" Or m_strMode.ToUpper = "SAVEDELIVERABLEDATA" Or m_strMode.ToUpper = "PROJECTSAVE") And m_strFromPage.ToUpper = "GENERATEDATAPAGE" Then
        '                alMenu.Add("Generate") : alMenuToolTip.Add("Generate") : alClientSideFunctions.Add("Generate()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("BackFrmGenerate_OnClick()")
        '            Else
        '                'End of code added by VidyaK

        '                'If m_strSnapShotID <> "" Then
        '                '    alMenu.Add("Re Generate") : alMenuToolTip.Add("Re Generate") : alClientSideFunctions.Add("ReGenerate()")
        '                'End If
        '                alMenu.Add("Previous Month") : alMenuToolTip.Add("Previous Month") : alClientSideFunctions.Add("PreviousMonth_OnClick()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("Back_OnClick()")
        '                alMenu.Add(" ? ") : alMenuToolTip.Add("Help") : alClientSideFunctions.Add("Help_OnClick()")
        '            End If
        '        Else

        '            'Dim arrMenu() As String = {"Re Generate", "Previous Month", "Next Month", " ? "}
        '            'Dim arrMenuToolTip() As String = {"Re Generate", "Previous Month", "Next Month", "Help"}
        '            'Dim arrClientSideFunctions() As String = {"ReGenerate()", "PreviousMonth_OnClick()", "NextMonth_OnClick()", "Help_OnClick()"}
        '            'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        '            'Return strMenu
        '            'Code added by VidyaK
        '            If (m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "SAVEMILESTONEDATA" Or m_strMode.ToUpper = "SAVEPHASEDATA" Or m_strMode.ToUpper = "SAVEDELIVERABLEDATA" Or m_strMode.ToUpper = "PROJECTSAVE") And m_strFromPage.ToUpper = "GENERATEDATAPAGE" Then
        '                alMenu.Add("Generate") : alMenuToolTip.Add("Generate") : alClientSideFunctions.Add("Generate()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("BackFrmGenerate_OnClick()")
        '            Else
        '                'End of code added by VidyaK

        '                'Commented by VidyaK
        '                'If m_strSnapShotID <> "" Then
        '                '    alMenu.Add("Re Generate") : alMenuToolTip.Add("Re Generate") : alClientSideFunctions.Add("ReGenerate()")
        '                'End If
        '                'End of code Commented by VidyaK

        '                alMenu.Add("Previous Month") : alMenuToolTip.Add("Previous Month") : alClientSideFunctions.Add("PreviousMonth_OnClick()")
        '                alMenu.Add("Next Month") : alMenuToolTip.Add("Next Month") : alClientSideFunctions.Add("NextMonth_OnClick()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("Back_OnClick()")
        '                alMenu.Add(" ? ") : alMenuToolTip.Add("Help") : alClientSideFunctions.Add("Help_OnClick()")
        '            End If
        '        End If

        '    Case "WEEKLY"
        '        If m_strIsMetricDate.Trim = "True" Then

        '            'Dim arrMenu() As String = {"Re Generate", "Next Week", " ? "}
        '            'Dim arrMenuToolTip() As String = {"Re Generate", "Next Week", "Help"}
        '            'Dim arrClientSideFunctions() As String = {"ReGenerate()", "NextWeek_OnClick()", "Help_OnClick()"}
        '            'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        '            'Return strMenu
        '            'Code added by VidyaK
        '            If (m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "SAVEMILESTONEDATA" Or m_strMode.ToUpper = "SAVEPHASEDATA" Or m_strMode.ToUpper = "SAVEDELIVERABLEDATA" Or m_strMode.ToUpper = "PROJECTSAVE") And m_strFromPage.ToUpper = "GENERATEDATAPAGE" Then
        '                alMenu.Add("Generate") : alMenuToolTip.Add("Generate") : alClientSideFunctions.Add("Generate()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("BackFrmGenerate_OnClick()")
        '            Else

        '                'End of code added by VidyaK

        '                'Commented by VidyaK
        '                'If m_strSnapShotID <> "" Then
        '                '    alMenu.Add("Re Generate") : alMenuToolTip.Add("Re Generate") : alClientSideFunctions.Add("ReGenerate()")
        '                'End If
        '                'End of code Commented by VidyaK
        '                If m_strIsCurrentDate.Trim = "False" Then
        '                    alMenu.Add("Next Week") : alMenuToolTip.Add("Next Week") : alClientSideFunctions.Add("NextWeek_OnClick()")
        '                End If
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("Back_OnClick()")
        '                alMenu.Add(" ? ") : alMenuToolTip.Add("Help") : alClientSideFunctions.Add("Help_OnClick()")
        '            End If

        '        ElseIf m_strIsCurrentDate.Trim = "True" Then

        '            'Dim arrMenu() As String = {"Re Generate", "Previous Week", " ? "}
        '            'Dim arrMenuToolTip() As String = {"Re Generate", "Previous Week", "Help"}
        '            'Dim arrClientSideFunctions() As String = {"ReGenerate()", "PreviousWeek_OnClick()", "Help_OnClick()"}
        '            'Code added by VidyaK
        '            If (m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "SAVEMILESTONEDATA" Or m_strMode.ToUpper = "SAVEPHASEDATA" Or m_strMode.ToUpper = "SAVEDELIVERABLEDATA" Or m_strMode.ToUpper = "PROJECTSAVE") And m_strFromPage.ToUpper = "GENERATEDATAPAGE" Then
        '                alMenu.Add("Generate") : alMenuToolTip.Add("Generate") : alClientSideFunctions.Add("Generate()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("BackFrmGenerate_OnClick()")
        '            Else
        '                alMenu.Add("Previous Week") : alMenuToolTip.Add("Previous Week") : alClientSideFunctions.Add("PreviousWeek_OnClick()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("Back_OnClick()")
        '                alMenu.Add(" ? ") : alMenuToolTip.Add("Help") : alClientSideFunctions.Add("Help_OnClick()")
        '            End If
        '            'End of code added by VidyaK
        '            'Commented by VidyaK
        '            'If m_strSnapShotID <> "" Then
        '            '    alMenu.Add("Re Generate") : alMenuToolTip.Add("Re Generate") : alClientSideFunctions.Add("ReGenerate()")
        '            'End If
        '            'End of code Commented by VidyaK



        '        Else

        '            'Dim arrMenu() As String = {"Re Generate", "Previous Week", "Next Week", " ? "}
        '            'Dim arrMenuToolTip() As String = {"Re Generate", "Previous Week", "Next Week", "Help"}
        '            'Dim arrClientSideFunctions() As String = {"ReGenerate()", "PreviousWeek_OnClick()", "NextWeek_OnClick()", "Help_OnClick()"}
        '            '    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        '            'Return strMenu
        '            'Code added by VidyaK
        '            If (m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "SAVEMILESTONEDATA" Or m_strMode.ToUpper = "SAVEPHASEDATA" Or m_strMode.ToUpper = "SAVEDELIVERABLEDATA" Or m_strMode.ToUpper = "PROJECTSAVE") And m_strFromPage.ToUpper = "GENERATEDATAPAGE" Then
        '                alMenu.Add("Generate") : alMenuToolTip.Add("Generate") : alClientSideFunctions.Add("Generate()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("BackFrmGenerate_OnClick()")
        '            Else
        '                alMenu.Add("Previous Week") : alMenuToolTip.Add("Previous Week") : alClientSideFunctions.Add("PreviousWeek_OnClick()")
        '                alMenu.Add("Next Week") : alMenuToolTip.Add("Next Week") : alClientSideFunctions.Add("NextWeek_OnClick()")
        '                alMenu.Add("Back") : alMenuToolTip.Add("Back") : alClientSideFunctions.Add("Back_OnClick()")
        '                alMenu.Add(" ? ") : alMenuToolTip.Add("Help") : alClientSideFunctions.Add("Help_OnClick()")
        '            End If
        '            'End of code added by VidyaK
        '            'If m_strSnapShotID <> "" Then
        '            '    alMenu.Add("Re Generate") : alMenuToolTip.Add("Re Generate") : alClientSideFunctions.Add("ReGenerate()")
        '            'End If



        '        End If
        'End Select

        Dim arrmenu(alMenu.Count - 1) As String
        Dim arrMenuToolTip(alMenu.Count - 1) As String
        Dim arrClientSideFunctions(alMenu.Count - 1) As String

        alMenu.CopyTo(arrmenu)
        alMenuToolTip.CopyTo(arrMenuToolTip)
        alClientSideFunctions.CopyTo(arrClientSideFunctions)

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrmenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu
        'End of Addition by RathinP
    End Function

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        Call Initializations()
        Call DrawPage()
    End Sub

    Private Sub DrawPage()
        '====================================================================
        ' Procedure Name        :   DrawPage()
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   Calls all functions used for building the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   NobleK
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Call PlotHead()
        CommonFunctions.General.WriteHTML(PrepareMenu())
        CommonFunctions.General.WriteHTML("<BR>")
        ''''Commented & Added by GokulP on 22 Jan 2010 for Removing filter
        ''''Call DrawFilterSection()
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthdnCurrentDate", "txthdnCurrentDate", , 50, , m_strFromDate, , , , , , True, , True, , , , , ))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthdnCurrentDate", "txthdnCurrentDate", , 50, , m_strFromDate, , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015
        ''''End of Comment & Addition by GokulP on 22 Jan 2010 for Removing filter
        'CommonFunctions.General.WriteHTML("<BR>")
        Call PlotHeader()
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto;width:100%;height:100%;'>")
        Call DrawUI()
        CommonFunctions.General.WriteHTML("</DIV>")
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(PrepareMenu())
    End Sub

    Private Sub DrawFilterSection()
        '====================================================================
        ' Procedure Name        :   DrawFilter()
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   Creates the UI Page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   NobleK
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        Dim intRoleLevel As Integer
        Dim strProjectFilters As String = ""
        Dim strSPForCombo As String = ""
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        strProjectFilters = ""
        'If middle level then apply filter for Projects
        If intRoleLevel = 2 Then
            'Apply Role Access Filter for Project List
            strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                strProjectFilters += strFilter
            End If
        End If

        If Len(strProjectFilters) > 0 Then
            strProjectFilters = Replace(UCase(strProjectFilters), "ProjectID IN(", "")
            strProjectFilters = Replace(UCase(strProjectFilters), ")", "")
            strProjectFilters = Replace(UCase(strProjectFilters), "'", "")
            strProjectFilters = strProjectFilters + ","
            strSPForCombo = "usp_Sel_Project_Milestone_Phases_Measurements '" & m_strToDate & "', '" & strProjectFilters & "'"
        Else
            strSPForCombo = "usp_Sel_Project_Milestone_Phases_Measurements '" & m_strToDate & "'"
        End If

        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' width=100%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='right' width=30%> Select Project &nbsp;&nbsp;&nbsp&nbsp;&nbsp;</TD>")
        CommonFunctions.General.WriteHTML("<TD align='left' width=40%>")
        CommonFunctions.HTMLControls.DrawComboBox("cboProjects", strSPForCombo, , m_strProjectID, "onchange='javascript:Project_OnChange()'")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD align='left' width=30%>")
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthdnCurrentDate", "txthdnCurrentDate", , 50, , m_strFromDate, , , , , , True, , True, , , , , ))
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox("txthdnCurrentDate", "txthdnCurrentDate", , 50, , m_strFromDate, , , , , , True, , True, , , , , , EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub

    Private Sub DrawUI()
        '====================================================================
        ' Procedure Name        :   DrawUI()
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   Creates the UI Page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   NoneFPreviou
        ' Author                :   NobleK
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        If m_strFromTab = "0" Then
            CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Project))
            DrawProjectGrid()
        ElseIf m_strFromTab = "1" Then
            CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Phase))
            DrawBreakUpGrid("1", "Phase")
        ElseIf m_strFromTab = "2" Then
            CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Milestone))
            DrawBreakUpGrid("2", "Milestone")
        ElseIf m_strFromTab = "3" Then
            CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Deliverable))
            DrawBreakUpGrid("3", "Deliverable")
        End If


        'If m_ShowProjectDiv = "0" Then
        '    DrawShowHideLink(1)
        'ElseIf m_ShowProjectDiv = "1" And m_strFromTab = "0" Then
        '    'CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Project))
        '    DrawProjectGrid()
        'End If
        'If m_ShowPhaseDiv = "0" Then
        '    DrawShowHideLink(2)
        'ElseIf m_ShowPhaseDiv = "1" And m_strFromTab = "1" Then
        '    ' CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Project))
        '    DrawBreakUpGrid("1", "Phase")
        'End If

        'If m_ShowMilestoneDiv = "0" And m_strFromTab = "2" Then
        '    DrawShowHideLink(3)
        'ElseIf m_ShowMilestoneDiv = "1" Then
        '    'CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Project))
        '    DrawBreakUpGrid("2", "Milestone")
        'End If

        ''Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
        'If m_ShowDeliverableDiv = "0" Then
        '    DrawShowHideLink(4)
        'ElseIf m_ShowDeliverableDiv = "1" And m_strFromTab = "3" Then
        '    ' CommonFunctions.General.WriteHTML(DrawTabs(SelectedTab.Project))
        '    DrawBreakUpGrid("3", "Deliverable")
        'End If
        ''End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab

        DrawHiddenFields()
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
        txtResult.Append("<TD height='10px' class=clsLinkPageHeaderInner>")
        If SelectedTabValue = SelectedTab.Project Then
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsSelected'   Title='" + TAB_NAME_Project + "' href='javascript:Tab_OnClick(0)'>" + TAB_NAME_Project + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Phase + "' href='javascript:Tab_OnClick(1)'>" + TAB_NAME_Phase + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Milestone + "' href='javascript:Tab_OnClick(2)'>" + TAB_NAME_Milestone + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Deliverable + "' href='javascript:Tab_OnClick(3)'>" + TAB_NAME_Deliverable + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
        End If

        If SelectedTabValue = SelectedTab.Phase Then
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_Project + "' href='javascript:Tab_OnClick(0)'>" + TAB_NAME_Project + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_Phase + "' href='javascript:Tab_OnClick(1)'>" + TAB_NAME_Phase + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Milestone + "' href='javascript:Tab_OnClick(2)'>" + TAB_NAME_Milestone + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Deliverable + "' href='javascript:Tab_OnClick(3)'>" + TAB_NAME_Deliverable + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
        End If
        If SelectedTabValue = SelectedTab.Milestone Then
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_Project + "' href='javascript:Tab_OnClick(0)'>" + TAB_NAME_Project + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Phase + "' href='javascript:Tab_OnClick(1)'>" + TAB_NAME_Phase + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_Milestone + "' href='javascript:Tab_OnClick(2)'>" + TAB_NAME_Milestone + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Deliverable + "' href='javascript:Tab_OnClick(3)'>" + TAB_NAME_Deliverable + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
        End If

        If SelectedTabValue = SelectedTab.Deliverable Then
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a  class='clsNavTab'   Title='" + TAB_NAME_Project + "' href='javascript:Tab_OnClick(0)'>" + TAB_NAME_Project + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Phase + "' href='javascript:Tab_OnClick(1)'>" + TAB_NAME_Phase + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='" + TAB_NAME_Milestone + "' href='javascript:Tab_OnClick(2)'>" + TAB_NAME_Milestone + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            txtResult.Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='" + TAB_NAME_Deliverable + "' href='javascript:Tab_OnClick(3)'>" + TAB_NAME_Deliverable + "</a>&nbsp;&nbsp;&nbsp;&nbsp;")
        End If
        txtResult.Append("</td>")
        '<TD height='10px' width='100%'></td>
        txtResult.Append("</TR>")
        'colspan=3
        txtResult.Append("<TR ><TD  height='10px'  class=clsLinkPageHeaderInner></TD></TR></TABLE>")
        strResult = txtResult.ToString
        txtResult = Nothing

        Return strResult

    End Function

    Private Sub DrawHiddenFields()
        ''''Commented And Added By Vaijat K On 06/10/2015
        'CommonFunctions.HTMLControls.DrawTextBox("txtShowProjectDiv", "txtShowProjectDiv", , , , m_ShowProjectDiv, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtShowPhaseDiv", "txtShowPhaseDiv", , , , m_ShowPhaseDiv, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtShowMilestoneDiv", "txtShowMilestoneDiv", , , , m_ShowMilestoneDiv, , , , , , True)
        ''Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
        'CommonFunctions.HTMLControls.DrawTextBox("txtShowDeliverableDiv", "txtShowDeliverableDiv", , , , m_ShowDeliverableDiv, , , , , , True)
        ''End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
        'CommonFunctions.HTMLControls.DrawTextBox("txtProject", "txtProject", , , , m_strProjectID.ToString, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtDate", "txtDate", , , , m_strToDate.ToString, , , , , , True)
        'CommonFunctions.HTMLControls.DrawTextBox("txtFromDate", "txtFromDate", , , , m_strFromDate.ToString, , , , , , True)

        CommonFunctions.HTMLControls.DrawTextBox("txtShowProjectDiv", "txtShowProjectDiv", , , , m_ShowProjectDiv, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtShowPhaseDiv", "txtShowPhaseDiv", , , , m_ShowPhaseDiv, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtShowMilestoneDiv", "txtShowMilestoneDiv", , , , m_ShowMilestoneDiv, , , , , , True, EnableHTMLEncode:=True)
        'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
        CommonFunctions.HTMLControls.DrawTextBox("txtShowDeliverableDiv", "txtShowDeliverableDiv", , , , m_ShowDeliverableDiv, , , , , , True, EnableHTMLEncode:=True)
        'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
        CommonFunctions.HTMLControls.DrawTextBox("txtProject", "txtProject", , , , m_strProjectID.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtDate", "txtDate", , , , m_strToDate.ToString, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFromDate", "txtFromDate", , , , m_strFromDate.ToString, , , , , , True, EnableHTMLEncode:=True)
        ''''End Added By Vaijat K On 06/10/2015

    End Sub

    Private Sub DrawShowHideLink(ByVal Indicator)
        Select Case Indicator
            Case 1
                CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable id='tableShowProject'><TR class=clsTRSectionHeader><TD  align=Left width='1%'><A href=""Javascript:Show_divSection(1)""><Img Border=0 id=tdShowHide_showHide_divSection1 Src=""../../Images/plus.gif"" title=''></A></TD><TD align=Left><B>Project Datapoints</B></TD><TD align=Right><Div id='SecLinksdivSection2'></Div></TD></TR></TABLE>")
            Case 2
                CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable id='tableShowPhase'><TR class=clsTRSectionHeader><TD  align=Left width='1%'><A href=""Javascript:Show_divSection(2)""><Img Border=0 id=tdShowHide_showHide_divSection1 Src=""../../Images/plus.gif"" title=''></A></TD><TD align=Left><B>Phases Datapoints</B></TD><TD align=Right><Div id='SecLinksdivSection2'></Div></TD></TR></TABLE>")
            Case 3
                CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable id='tableShowMilestone'><TR class=clsTRSectionHeader><TD  align=Left width='1%'><A href=""Javascript:Show_divSection(3)""><Img Border=0 id=tdShowHide_showHide_divSection1 Src=""../../Images/plus.gif"" title=''></A></TD><TD align=Left><B>Milestones Datapoints</B></TD><TD align=Right><Div id='SecLinksdivSection2'></Div></TD></TR></TABLE>")
                'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
            Case 4
                CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable id='tableShowDeliverable'><TR class=clsTRSectionHeader><TD  align=Left width='1%'><A href=""Javascript:Show_divSection(4)""><Img Border=0 id=tdShowHide_showHide_divSection1 Src=""../../Images/plus.gif"" title=''></A></TD><TD align=Left><B>Deliverable Datapoints</B></TD><TD align=Right><Div id='SecLinksdivSection2'></Div></TD></TR></TABLE>")
                'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
        End Select
    End Sub

    Private Sub DrawBreakUpGrid(ByVal strFlag As String, ByVal strFor As String)
        '====================================================================
        ' Procedure Name        :  DrawBreakUpGrid
        ' Parameters Passed     :  strFor - indicating for what the Procedure is
        '                                   called 
        '                          intFlag- indicating for what the procedure is called
        '                                   1. Phase
        '                                   2. Milestone
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the BreakUp Grid
        ' Description           :  This sub -routine draws the phase and milestone grid
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  Noble K
        ' Created               :  17th Feb, 2006
        ' Revisions             :  
        '=====================================================================
        Dim intRowCnt As Integer = 0
        Dim intColCnt As Integer = 2
        Dim intMeasurmentCounter As Integer = 0

        Dim blnBreakUpData As Boolean = False

        Dim strSPBreakUps As String

        Dim strBreakUpName As String = ""
        Dim strMeasurementName As String = ""
        Dim strTextBoxID As String

        Dim drForSPBreakUps As IDataReader
        Dim Index As Integer
        Dim objSectionBreakUp As New Whiz.WebPage.Templates.SectionTitle

        If strFor = "Milestone" Then
            m_blnMilestoneBreakUpData = False
            Index = 3
        ElseIf strFor = "Phase" Then
            m_blnPhaseBreakUpData = False
            Index = 2
            'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
        ElseIf strFor = "Deliverable" Then
            m_blnDeliverableBreakUpData = False
            Index = 4
            'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
        End If

        strSPBreakUps = "usp_Sel_Project_Milestone_Phases_Measurements '" & m_strToDate & "', " & m_strProjectID & ", " & strFlag
        drForSPBreakUps = CommonFunctions.Data.GetDataReader(strSPBreakUps, MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<DIV id='divBreakup" & strFor & "' style='Overflow:auto;width:100%;height=500px'>")
        Dim objSectionPhases As New Whiz.WebPage.Templates.SectionTitle
        With objSectionPhases
            '.GetSectionTitle("<A href=""Javascript:Hide_divSection(" + Index.ToString + ")""><Img Border=0 id=tdShowHide_showHide_divSection1 Src=""../../Images/minus.gif"" title=''></A><B>" & " " & strFor & "s</B>", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:" & strFor & "Save_OnClick(" + m_strProjectID + ",""" + blnBreakUpData.ToString + """)'>Save</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            .GetSectionTitle("", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:" & strFor & "Save_OnClick(" + m_strProjectID + ",""" + blnBreakUpData.ToString + """)'>Save</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;")

            CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
            CommonFunctions.General.WriteHTML(.ClientsideScript)
            CommonFunctions.General.WriteHTML("</SCRIPT>")
        End With
        CommonFunctions.General.WriteHTML("<TABLE id='tblBreakUpDataPoints' class='clsGridTable' width='100%' cellspacing=1 border=0 >")
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader' width=100%>")
        'adding the column headers
        intColCnt = 2
        While intColCnt < drForSPBreakUps.FieldCount
            If intColCnt = 2 Then
                CommonFunctions.General.WriteHTML("<TD  align='left'>" & drForSPBreakUps.GetName(intColCnt) & "</TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD  align='center'>" & drForSPBreakUps.GetName(intColCnt) & "</TD>")
            End If
            'CommonFunctions.General.WriteHTML("<TD  align='center'>" & drForSPBreakUps.GetName(intColCnt) & "</TD>")
            intColCnt = intColCnt + 1
        End While
        Do While drForSPBreakUps.Read
            intMeasurmentCounter = 0
            intColCnt = 2
            If strFor = "Phase" Then
                m_blnPhaseBreakUpData = True
                'Commented & Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
                'Else
                '   m_blnMilestoneBreakUpData = True
            ElseIf strFor = "Milestone" Then
                m_blnMilestoneBreakUpData = True
            ElseIf strFor = "Deliverable" Then
                m_blnDeliverableBreakUpData = True
                'End of Comment & Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
            End If

            If intRowCnt Mod 2 = 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            End If
            'Adding the columns data
            While intColCnt < drForSPBreakUps.FieldCount
                strBreakUpName = drForSPBreakUps.Item(2)
                strMeasurementName = drForSPBreakUps.GetName(intColCnt)
                If intColCnt > 2 Then
                    If strFor = "Phase" Then
                        strTextBoxID = "txtMeasurement" & strFor & drForSPBreakUps(1).ToString & m_arrstrMeasurementsPhaseIDList(intMeasurmentCounter).ToString
                    ElseIf strFor = "Milestone" Then
                        strTextBoxID = "txtMeasurement" & strFor & drForSPBreakUps(1).ToString & m_arrstrMeasurementsMileStIDList(intMeasurmentCounter).ToString
                    ElseIf strFor = "Deliverable" Then
                        strTextBoxID = "txtMeasurement" & strFor & drForSPBreakUps(1).ToString & m_arrstrMeasurementsDeliverableList(intMeasurmentCounter).ToString
                    End If

                    intMeasurmentCounter = intMeasurmentCounter + 1
                    'If FormatNumber(drForSPBreakUps(intColCnt), 2).ToString = "0.00" Then
                    CommonFunctions.General.WriteHTML("<TD align='center' Title='" & strFor & ":" & strBreakUpName & " Datapoint:" & strMeasurementName & "'>")
                    'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, , drForSPBreakUps(intColCnt), "right", , , , , , "onchange='javascript:MeasurmentValue_OnChange(" & strTextBoxID & ")'", True, , , , , intColCnt))
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    ''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, , FormatNumber(CommonFunctions.Data.CheckIsDBNull(drForSPBreakUps(intColCnt), "0"), 2, TriState.False, TriState.False, TriState.False), "right", , , , , , "onchange='javascript:MeasurmentValue_OnChange(this)'", True, , , , , intColCnt))
                    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, , FormatNumber(CommonFunctions.Data.CheckIsDBNull(drForSPBreakUps(intColCnt), "0"), 2, TriState.False, TriState.False, TriState.False), "right", , , , , , "onchange='javascript:MeasurmentValue_OnChange(this)'", True, , , , , intColCnt, EnableHTMLEncode:=True))
                    ''END OF Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    'Else
                    '    CommonFunctions.General.WriteHTML("<TD align='right' Title='" & strFor & ":" & strBreakUpName & " Datapoint:" & strMeasurementName & "'>")
                    '    CommonFunctions.General.WriteHTML(FormatNumber(drForSPBreakUps(intColCnt), 2).ToString)
                    'End If
                    CommonFunctions.General.WriteHTML("</TD>")
                Else
                    CommonFunctions.General.WriteHTML("<TD Title='" & strFor & ":" & strBreakUpName & " Datapoint:" & strMeasurementName & "'>" & drForSPBreakUps(intColCnt) & "</TD>")
                End If
                intColCnt = intColCnt + 1
            End While
            CommonFunctions.General.WriteHTML("</TR>")
            'Getting the row cnt
            intRowCnt = intRowCnt + 1
        Loop

        If strFor = "Phase" Then
            If m_blnPhaseBreakUpData = False Then
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                CommonFunctions.General.WriteHTML("<TD align='center'> There are no items in this view. </TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'Comment & Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
            'Else
        ElseIf strFor = "Milestone" Then
            'End of Comment & Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab

            If m_blnMilestoneBreakUpData = False Then
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                CommonFunctions.General.WriteHTML("<TD align='center'> There are no items in this view. </TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'Comment & Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
        Else
            If m_blnDeliverableBreakUpData = False Then
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
                CommonFunctions.General.WriteHTML("<TD align='center'> There are no items in this view. </TD>")
                CommonFunctions.General.WriteHTML("</TR>")
            End If
            'End of Comment & Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab
        End If

        CommonFunctions.General.WriteHTML("</TABLE>") 'End of Table holding the BreakUpdata
        CommonFunctions.General.WriteHTML("</DIV>")   'End of DivBreakup
    End Sub

    Private Sub DrawProjectGrid()
        '====================================================================
        ' Procedure Name        :  DrawProjectGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the project datapoint Grid
        ' Description           :  This sub -routine draws the project datapoint grid
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  SrikanthY
        ' Created               :  11 Jul 2007
        ' Revisions             :  
        '=====================================================================
        Dim intRowCnt As Integer = 0
        Dim blnBreakUpData As Boolean = False
        Dim strSPProject, strFor As String
        Dim strBreakUpName As String = ""
        Dim strMeasurementName As String = ""
        Dim strTextControls As String = ""
        Dim drForSPProject As IDataReader
        Dim objSectionBreakUp As New Whiz.WebPage.Templates.SectionTitle
        Dim FromDPMaster As Integer = 0
        strFor = "Project Datapoints"
        ' strFor = ""
        m_blnProjectData = False

        strSPProject = "usp_sel_tbl_PRS_Measurements_For_MB_ProjectMeasureentsHistory_Revised " & m_strProjectID & ",'" & m_strToDate & "'"

        drForSPProject = CommonFunctions.Data.GetDataReader(strSPProject, MyBase.UseSQL)

        strFor = ""
        CommonFunctions.General.WriteHTML("<DIV id='divBreakup" & strFor & "' style='Overflow:auto;width:100%;height=100%'>")
        Dim objSectionPhases As New Whiz.WebPage.Templates.SectionTitle
        With objSectionPhases
            '.GetSectionTitle("<A href=""Javascript:Hide_divSection(1)""><Img Border=0 id=tdShowHide_showHide_divSection1 Src=""../../Images/minus.gif"" title=''></A><B>" & " " & strFor & "</B>", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:" & "Project" & "Save_OnClick(" + m_strProjectID + ")'>Save</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
            .GetSectionTitle("<B>" & " " & strFor & "</B>", "", "", , "&nbsp;|&nbsp;" & "<a class='Menu' Title='Save' href='javascript:" & "Project" & "Save_OnClick(" + m_strProjectID + ")'>Save</a>" & "&nbsp;|&nbsp;&nbsp;&nbsp;")
            '&nbsp;&nbsp;&nbsp;
            CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
            CommonFunctions.General.WriteHTML(.ClientsideScript)
            CommonFunctions.General.WriteHTML("</SCRIPT>")
        End With
        CommonFunctions.General.WriteHTML("<TABLE id='tblBreakUpDataPoints' class='clsGridTable' width='100%' cellspacing=1 border=0 >")
        CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader' width=100%>")

        CommonFunctions.General.WriteHTML("<TD>" & "Datapoint" & "</TD>")
        CommonFunctions.General.WriteHTML("<TD>" & "User Guidelines" & "</TD>")
        CommonFunctions.General.WriteHTML("<TD>" & "Unit" & "</TD>")
        CommonFunctions.General.WriteHTML("<TD align='center'>" & "Value" & "</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        While drForSPProject.Read
            If strTextControls = "" Then
                strTextControls = drForSPProject(0).ToString
            Else
                strTextControls += "," + drForSPProject(0).ToString
            End If

            m_blnProjectData = True
            If intRowCnt Mod 2 = 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            End If
            CommonFunctions.General.WriteHTML("<TD>" & drForSPProject(5).ToString & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & drForSPProject(2).ToString & "</TD>")
            CommonFunctions.General.WriteHTML("<TD>" & drForSPProject(9).ToString & "</TD>")
            'Dim strTextBoxID As String = "txtMeasurement" & strFor & drForSPProject(1).ToString & intRowCnt.ToString
            Dim strTextBoxID As String = "txtProjectDP" + drForSPProject(0).ToString
            CommonFunctions.General.WriteHTML("<TD align='center' Title='" & strFor & ":" & strBreakUpName & " Datapoint:" & strMeasurementName & "'>")
            If drForSPProject(6).ToString = "False" Then
                ''''Commented And Added By Vaijat K On 06/10/2015
                '''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, 10, FormatNumber(CommonFunctions.Data.CheckIsDBNull(drForSPProject(3), "0"), 2, TriState.False, TriState.False, TriState.False), "right", , True, , , , "onchange='javascript:MeasurmentValue_OnChange(" & strTextBoxID & ")'", True, , , , , intRowCnt))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, 10, FormatNumber(CommonFunctions.Data.CheckIsDBNull(drForSPProject(3), "0"), 2, TriState.False, TriState.False, TriState.False), "right", , True, , , , "onchange='javascript:MeasurmentValue_OnChange(" & strTextBoxID & ")'", True, , , , , intRowCnt, EnableHTMLEncode:=True))
                ''''End Added By Vaijat K On 06/10/2015
            ElseIf drForSPProject(6).ToString = "True" Then
                ''''Commented And Added By Vaijat K On 06/10/2015
                '''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, 10, FormatNumber(CommonFunctions.Data.CheckIsDBNull(drForSPProject(3), "0"), 2, TriState.False, TriState.False, TriState.False), "right", , , , , , "onchange='javascript:MeasurmentValue_OnChange(" & strTextBoxID & ")'", True, , , , , intRowCnt))
                CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawTextBox(strTextBoxID, strTextBoxID, , 50, 10, FormatNumber(CommonFunctions.Data.CheckIsDBNull(drForSPProject(3), "0"), 2, TriState.False, TriState.False, TriState.False), "right", , , , , , "onchange='javascript:MeasurmentValue_OnChange(" & strTextBoxID & ")'", True, , , , , intRowCnt, EnableHTMLEncode:=True))
                ''''End Added By Vaijat K On 06/10/2015
            End If
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            intRowCnt = intRowCnt + 1
            If intRowCnt = 1 Then
                If drForSPProject(7).ToString = "1" Then FromDPMaster = 1
            End If
        End While
        ''''Commented And Added By Vaijat K On 06/10/2015
        ' ''CommonFunctions.HTMLControls.DrawTextBox("txtTextControls", "txtTextControls", , , , strTextControls, , , , , , True)
        ' ''CommonFunctions.HTMLControls.DrawTextBox("txtFromDPMaster", "txtFromDPMaster", , , , FromDPMaster, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("txtTextControls", "txtTextControls", , , , strTextControls, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txtFromDPMaster", "txtFromDPMaster", , , , FromDPMaster, , , , , , True, EnableHTMLEncode:=True)
        ''''End Added By Vaijat K On 06/10/2015
        If m_blnProjectData = False Then
            CommonFunctions.General.WriteHTML("<TR class='clsTREven' >")
            CommonFunctions.General.WriteHTML("<TD align='center' colspan='3'> There are no items in this view. </TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If

        CommonFunctions.General.WriteHTML("</TABLE>") 'End of Table holding the BreakUpdata
        CommonFunctions.General.WriteHTML("</DIV>")   'End of DivBreakup

    End Sub

    Private Sub SaveBreakUpData(ByVal strFor As String)
        '=====================================================================
        ' Procedure Name        : SaveBreakUpData
        ' Purpose               : To Save the data
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Feb 17, 2006
        ' Revisions             :
        '=====================================================================
        Dim strSPBreakUpList As String
        Dim strInsertSQLStmt As String
        Dim strSPInsertMetrics As String

        Dim intBreakUpCounter As Integer = 0
        Dim intMeasurementCounter As Integer = 0
        'vidya
        Dim intMeasurementArrayCounter As Integer = 0
        Dim strTextBoxID As String = ""
        'end 
        Dim intMetricCounter As Integer = 0

        Dim drBreakUpData As IDataReader

        Dim strarrBreakUpList As New ArrayList(100)
        Dim strarrMeasurementValues As New ArrayList(100)

        strSPBreakUpList = "usp_Sel_Applicable_Phases_Milestones '" & m_strSnapShotdate & "', " & m_strProjectID & ", '" & strFor & "'"
        drBreakUpData = CommonFunctions.Data.GetDataReader(strSPBreakUpList, MyBase.UseSQL)
        Do While drBreakUpData.Read
            strarrBreakUpList.Add(drBreakUpData(0))
        Loop
        If strFor = "Phase" Then
            intMeasurementArrayCounter = m_arrstrMeasurementsPhaseIDList.Count
        ElseIf strFor = "Milestone" Then
            intMeasurementArrayCounter = m_arrstrMeasurementsMileStIDList.Count
        ElseIf strFor = "Deliverable" Then
            intMeasurementArrayCounter = m_arrstrMeasurementsDeliverableList.Count
        End If



        While intBreakUpCounter < strarrBreakUpList.Count
            intMeasurementCounter = 0
            'Modified by vidyaK
            'While intMeasurementCounter < m_arrstrMeasurementsIDList.Count
            While intMeasurementCounter < intMeasurementArrayCounter
                'added by vidya
                If strFor = "Phase" Then
                    strTextBoxID = "txtMeasurement" & CType(strFor, String) & CType(strarrBreakUpList.Item(intBreakUpCounter), String) & CType(m_arrstrMeasurementsPhaseIDList.Item(intMeasurementCounter), String)
                ElseIf strFor = "Milestone" Then
                    strTextBoxID = "txtMeasurement" & CType(strFor, String) & CType(strarrBreakUpList.Item(intBreakUpCounter), String) & CType(m_arrstrMeasurementsMileStIDList.Item(intMeasurementCounter), String)
                ElseIf strFor = "Deliverable" Then
                    strTextBoxID = "txtMeasurement" & CType(strFor, String) & CType(strarrBreakUpList.Item(intBreakUpCounter), String) & CType(m_arrstrMeasurementsDeliverableList.Item(intMeasurementCounter), String)
                End If
                'End added by vidya

                'Dim strTextBoxID = "txtMeasurement" & CType(strFor, String) & CType(strarrBreakUpList.Item(intBreakUpCounter), String) & CType(m_arrstrMeasurementsIDList.Item(intMeasurementCounter), String)
                Dim strTextBoxValue = Request(strTextBoxID)

                If Not strTextBoxValue Is Nothing Then
                    strInsertSQLStmt = "usp_Ins_tbl_PRS_Measurements_BreakUp_History " & m_strProjectID & ", "
                    If strFor = "Phase" Then
                        strInsertSQLStmt = strInsertSQLStmt & strarrBreakUpList.Item(intBreakUpCounter) & ", NULL,NULL, "
                        strInsertSQLStmt = strInsertSQLStmt & m_arrstrMeasurementsPhaseIDList.Item(intMeasurementCounter) & ", '" & m_arrstrMeasurementsPhaseCodeList(intMeasurementCounter) & "', "
                    ElseIf strFor = "Milestone" Then
                        strInsertSQLStmt = strInsertSQLStmt & "NULL, " & strarrBreakUpList.Item(intBreakUpCounter) & ",NULL, "
                        strInsertSQLStmt = strInsertSQLStmt & m_arrstrMeasurementsMileStIDList.Item(intMeasurementCounter) & ", '" & m_arrstrMeasurementsMileStCodeList(intMeasurementCounter) & "', "
                        'Added by GokulP on 20 Jan 2010 for addition of Deliverable tab
                    ElseIf strFor = "Deliverable" Then
                        strInsertSQLStmt = strInsertSQLStmt & "NULL, NULL," & strarrBreakUpList.Item(intBreakUpCounter) & ", "
                        strInsertSQLStmt = strInsertSQLStmt & m_arrstrMeasurementsDeliverableList.Item(intMeasurementCounter) & ", '" & m_arrstrMeasurementsDeliverableCodeList(intMeasurementCounter) & "', "
                        'End of Addition by GokulP on 20 Jan 2010 for addition of Deliverable tab

                    End If
                    'strInsertSQLStmt = strInsertSQLStmt & m_arrstrMeasurementsIDList.Item(intMeasurementCounter) & ", '" & m_arrstrMeasurementsCodeList(intMeasurementCounter) & "', "
                    strInsertSQLStmt = strInsertSQLStmt & CType(strTextBoxValue, Double) & ", '" & m_strFromDate & "', '" & m_strToDate & "', '" & m_strSnapShotdate & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strInsertSQLStmt, MyBase.UseSQL)
                    strInsertSQLStmt = ""
                End If
                intMeasurementCounter = intMeasurementCounter + 1
            End While
            intBreakUpCounter = intBreakUpCounter + 1
        End While

        '''intBreakUpCounter = 0
        '''While intBreakUpCounter < strarrBreakUpList.Count
        '''    intMetricCounter = 0
        '''    While intMetricCounter < m_arrstrMetricsIDList.Count
        '''        strSPInsertMetrics = "usp_ins_tbl_PRS_MetricHistory_BreakUp_Calculation_Per_Metric_Periodic " & m_strProjectID & ", " & m_arrstrMetricsIDList(intMetricCounter) & ", '" & m_strFromDate & "', '" & m_strToDate & "', '" & m_strSnapShotdate & "'"
        '''        CommonFunctions.Data.InsertOrUpdateData(strSPInsertMetrics, MyBase.UseSQL)
        '''        intMetricCounter = intMetricCounter + 1
        '''    End While
        '''    intBreakUpCounter = intBreakUpCounter + 1
        '''End While

        strSPInsertMetrics = "Exec usp_ins_tbl_PRS_MetricHistory_Breakup_Calculation '" & m_strSnapShotdate & "', '" & m_strFromDate & "', '" & m_strToDate & "', " & m_strProjectID
        CommonFunctions.Data.InsertOrUpdateData(strSPInsertMetrics, MyBase.UseSQL)

        SaveSnapshotDetails(m_strProjectID, m_strSnapShotdate)
    End Sub

    Sub SaveSnapshotDetails(ByVal ProjectID, ByVal SnapShotDate)
        Dim strSnapshot As String = "usp_ins_tbl_PRS_GenerateData_ProjectLevel " & ProjectID & ",'" & SnapShotDate & "'"
        CommonFunctions.Data.InsertOrUpdateData(strSnapshot, MyBase.UseSQL)
    End Sub

    'Private Sub GenerateReport(ByVal strFor As String)
    '    '====================================================================
    '    ' Procedure Name        :  GenerateReport
    '    ' Parameters Passed     :  strFor
    '    ' Returns               :  None
    '    ' Parameters Affected   :  None
    '    ' Purpose               :  To Make the Excel Report
    '    ' Description           :  Same as above
    '    ' Assumptions           :  None
    '    ' Dependencies          :  None
    '    ' Author                :  NobleK
    '    ' Created               :  20th Feb, 2006
    '    ' Revisions             :  
    '    '=====================================================================
    '    Dim strClientScript As New System.Text.StringBuilder

    '    strClientScript.Append(" <SCRIPT LANGUAGE=vbscript> " & vbCrLf)
    '    strClientScript.Append(" Dim objUser, strExcelPath, objExcel, objSheet, k, objGroup" & vbCrLf)
    '    strClientScript.Append(" On Error Resume Next" & vbCrLf)

    '    strClientScript.Append("  set objExcel = createobject(""Excel.Application"") " & vbCrLf)
    '    strClientScript.Append(" On Error Goto 0" & vbCrLf)
    '    strClientScript.Append(" If err.number<>0 then " & vbCrLf)
    '    strClientScript.Append(" document.frmOpenRequestStats.action=""PM_HelpDesk_OpenRequests_ExcelReport.aspx?Action=Error""" & vbCrLf)
    '    strClientScript.Append(" document.frmOpenRequestStats.submit() " & vbCrLf)
    '    strClientScript.Append(" End If " & vbCrLf)

    '    ' Make it visible
    '    strClientScript.Append("  objExcel.Visible = true " & vbCrLf)

    '    ' Add a new workbook
    '    'strClientScript.Append(" dim wb " & vbCrLf)
    '    'strClientScript.Append(" set wb = objExcel.workbooks.add " & vbCrLf)
    '    strClientScript.Append(" objExcel.WorkBooks.add " & vbCrLf)
    '    strClientScript.Append(" objSheet = objExcel.ActiveWorkbook.Worksheets(1) " & vbCrLf)

    '    strClientScript.Append(MakeDataReport(strFor).ToString & vbCrLf)
    '    strClientScript.Append(" </Script> " & vbCrLf)
    '    CommonFunctions.General.WriteHTML(strClientScript.ToString)

    'End Sub

    'Private Function MakeDataReport(ByVal strFor As String) As System.Text.StringBuilder
    '    '====================================================================
    '    ' Procedure Name        :  MakeDataReport
    '    ' Parameters Passed     :  strFor
    '    ' Returns               :  None
    '    ' Parameters Affected   :  None
    '    ' Purpose               :  To Make the Main Excel Report i.e the first Tab-> Data
    '    ' Description           :  Same as above
    '    ' Assumptions           :  None
    '    ' Dependencies          :  None
    '    ' Author                :  NobleK
    '    ' Created               :  20th Feb, 2006
    '    ' Revisions             :  
    '    '=====================================================================
    '    Dim strScript As New System.Text.StringBuilder
    '    strScript.Append("   objSheet.Cells.Font.Size=8 " & vbCrLf)
    '    'strScript.Append("   objSheet.Name=""Data""" & vbCrLf)
    '    strScript.Append("   objSheet.Cells(1, 1).Value = ""User Common Name""" & vbCrLf)
    '    strScript.Append("   objSheet.Cells.Range(A1:B3).Select " & vbCrLf)
    '    MakeDataReport = strScript
    'End Function

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

#End Region

    Public Sub New()
        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End  of addition by Yogesh Jalamkar on 10-OCT-2016 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

End Class
