
'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleE
' Module Name           :  RT_ProductivityMetricData.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrajaktaR
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
Imports System.Globalization
#End Region

Public Class PM_Task_EasyEdit
    Inherits WebPages.Template.WhizTemplate
#Region "Variables"

#Region "Private"
    Dim WithEvents objGrid As New AdvancedGrid

    Dim m_strUserName As String = ""
    Dim m_strGroupDate As String = ""
    Dim m_strEntryDate As String = ""
    Dim m_GroupTotal As Double = 0
    Dim m_intGroupNumber As Int32 = -1
    Dim strProjectID_Filter As String = "null"
    Dim strEmployeeID_Filter As String = "null"
    Dim str_FromDate_Filter As String = ""
    Dim str_ToDate_Filter As String = ""
    Dim strTaskIDs As String = ""
    Private m_intTaskID As String
    Private m_strTaskType As String                     'Stores the Task Type
    Private m_blnUseClientDateForDA As Boolean
    Private m_intParentTask_UID As Integer
    Private m_objGlobal As WebPages.Template.IGlobal                    'This variable is of global object inteface. 

    Private m_objDTFI As New DateTimeFormatInfo       'Required to parse the date.

    Dim objMenu As New WebPages.Template.StaticMenu
    Private strJavafun_SendXMLHTTP As String = "SendXMLHTTP_Save"
    Private strMenu As String


    'Added By ShraddhaM on 21 Aug 2006
    Private m_lngProjectLocationID As Long = 0
    Private strLeaveDays As String = ""
    Private strEmployeeName As String = ""
    Private EmpId As String
    'Endded By ShraddhaM on 21 Aug 2006

#End Region
#Region "Protected"
    Protected strTaskID As String = ""
    'Protected blnShowWSR As Boolean = True
    'Protected blnShowDelete As Boolean = True
    Protected blnIsEdit As Boolean = True
    Protected m_intProjectID As Integer                     'Project ID
    Protected m_intEmployeeID As Integer                      'EmployeeID
    Protected m_dtFromDate1 As String                    'From Date
    Protected m_dtToDate1 As String                      'To Date
    Protected m_dtFromDate As String                    'From Date
    Protected m_dtToDate As String
    Protected m_FilterDivStatus As Boolean = True 'm_FilterDivStatus=True means "Open" or m_FilterDivStatus = "Close"
    Protected IsXMLHTTP_Off As Boolean = False

    Protected m_ParentTaskStartDate As String
    Protected m_ParentTaskEndDate As String
    Protected m_ParentTaskWork As String
    'shraddhaM 8/8/2006
    Protected strDateFormat As String
    Protected strInputFormat As String
    'Added By shraddhaM 21/8/2006
    Protected m_dblHoursPerDay As Double = 0
    Protected m_lngWeekDays As Long = 0
    Protected m_strHolidays As String = ""
    Protected strLeaveMessage As String
    Protected ParentTaskName As String
    Protected IsCaseOneProject As Boolean
    Protected ProjectStartDate As String
    Protected ProjectEndDate As String

    Protected dt_FromDate As Date
    Protected str_FromDate As String
    Protected dt_ToDate As Date
    Protected str_ToDate As String
    Protected str_IsEdit As String

    Protected m_dblTotalAllocatedTaskLCE As Double = 0
    Protected m_dblTotalLCE As Double = 0
    Protected comboProjectID As Integer
    Protected m_strStartingDayOfWeek As String = ""
    Protected TaskEdit As String = "TaskEdit"
    'Added By NitinVS on 12 July 2007 for WhizibleSEM 7 
    'addedBY HarshK for sp4 issueID 120,121 on 06/10/2005
    Protected m_bitResourceValidation As Boolean = False
    'End addedBY HarshK for sp4 issueID 120,121 on 06/10/2005

    ' End Addition By NitinVS on 12 july 2007 For whizibleSEM 7
    'Added by NitinC on 20 Jan 2012 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 58849)
    Protected m_intFlag As String = "0"
    'End of Added by NitinC on 20 Jan 2012 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 58849)

#End Region
#Region "Constants"
    Protected strJavafun_StartDate As String = "StartDate_onChange"
    Protected strJavafun_EndDate As String = "EndDate_onChange"
    Protected strJavafun_Work As String = "Work_onChange"
    Protected strJavafun_BaselineUpdate As String = "BaselineUpdate_onChange"
#End Region
#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        ' MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.PM_TaskUpdation", "AppResources")
    End Sub

    'Public Sub New()
    '    MyBase.ApplySecurity()
    '    MyBase.InitializeResources("AppResources.PM_Task_EasyEdit", "AppResources")
    'End Sub
#End Region
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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        Initialize()
    End Sub

    Protected Sub WritePage()
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        '--- ProjectID
        Dim StartDate As String
        Dim EndDate As String
        Dim EmpID As String
        Dim strEmployeeNames As String

        'CheckLeaves()
        If IsXMLHTTP_Off = False Then
            strJavafun_StartDate = strJavafun_SendXMLHTTP
            strJavafun_EndDate = strJavafun_SendXMLHTTP
            strJavafun_Work = strJavafun_SendXMLHTTP
            strJavafun_BaselineUpdate = strJavafun_SendXMLHTTP
        End If


        'If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
        '    m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")), Integer)
        'Else
        '    If CType(Session("intProjectID"), String) & "" = "" Then
        '        Response.Clear()
        '        Response.End()
        '    Else
        '        m_intProjectID = CInt(Session("intProjectID"))
        '    End If
        'End If

        If (Request.QueryString("FromXML") & "").Trim <> "1" Then
            If IsPostBack = True Then
                If (Request.QueryString("IsEdit") & "") <> "1" Then
                    blnIsEdit = False
                End If
            End If
            If Request.Form("cboProject") & "" <> "" Then
                strProjectID_Filter = Request.Form("cboProject")
            End If
            If Request.Form("cboResource") & "" <> "" Then
                strEmployeeID_Filter = Request.Form("cboResource")
            End If
            If Request.Form("txtFromDate") & "" <> "" Then
                str_FromDate_Filter = Request.Form("txtFromDate")
            End If
            If Request.Form("txtToDate") & "" <> "" Then
                str_ToDate_Filter = Request.Form("txtToDate")
            End If

            strTaskID = Request.QueryString("TaskID")
            CommonFunctions.General.WriteHTML("<BR>")
            DrawMenu("TOP")

            CommonFunction.General.WriteHTML(strMenu) 'Top menu
            'CommonFunctions.General.WriteHTML("<BR>")
            CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='overflow:auto;Height=455px' >") '445
            DisplaySelectionHeader()
            'DrawPageFilters()
            DrawGrid()
            'Response.Write("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class='clsTRPageCaption'>")
            ''Response.Write("<TD align=left>Task Edition</TD>")
            ''            Response.Write("<TD align=Right>|<b><a class='Menu' href='javascript:Save_OnClick()'>Save</a></b>|")
            'Response.Write("<TD align=Right>")
            'Response.Write("<b><a class='Menu' href='javascript:Save_OnClick()' title='Save'>|Save</a><b>|")

            'Response.Write("<b><a class='Menu' href='javascript:PreviousWeek_OnClick()' title='Previous Week'>|Previous Week</a><b>|")
            'Response.Write("<b><a class='Menu' href='javascript:NextWeek_OnClick()' title='Next Week'>Next Week</a><b>|")
            'Response.Write("<b><a class='Menu' href='javascript:Help_OnClick(""" + TaskEdit + """)' title='Help'>?</a><b>|")
            ''Response.Write("<b><a class='Menu' href='javascript:Help_OnClick('" + TaskEdit + "')' title='Help'>?</a><b>|")

            ''Help_OnClick('PROJECTTYPE')
            'Response.Write("</TD>")
            'Response.Write("</TR></TABLE>" & vbCrLf)
            DrawMenu("BOTTOM")
            'ElseIf Request.QueryString("Action").ToUpper = "DELETE" Then
            '    DeleteData()
        Else
            strTaskID = Request.QueryString("TaskID")
            'ShraddhaM 22 Aug 2006

            StartDate = Request.QueryString("startDate")
            EndDate = Request.QueryString("endDate")
            EmpID = Request.QueryString("EmployeeID")
            Dim strTempName As String
            'strTempName = CheckLeaves(CType(EmpID, Long), StartDate, EndDate)
            If StartDate <> "" Then

                strTempName = CheckLeaves(CType(EmpID, Long), StartDate, EndDate)

                strEmployeeNames &= strTempName + "<==>"

                strLeaveMessage = strEmployeeNames
                
                If strTempName = "" Then
                    SaveData()

                End If
                Response.Clear()
                Response.Write(strLeaveMessage)

                Response.End()

                'Endded By ShraddhaM 22 Aug 2006
            Else
                SaveData()
            End If
        End If

        'objHeaderFooter = New WebPages.Template.HeaderFooter
        'objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        'objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        'objHeaderFooter = Nothing
        'CommonFunctions.General.WriteHTML("<BR>")
        ' Added by NitinVS on 12 July 2007 for WhizibleSEM 7 to validate for resource dates
        Dim strQuery2 As String
        strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_intProjectID.ToString() & ",0"
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResourceStartDate", strQuery2, 250, , , True, True, , , , True))
        strQuery2 = "EXEC usp_Sel_CurrentTeamMembers_ExpectedDate  " & m_intProjectID.ToString() & ",1"
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResourceEndDate", strQuery2, 250, , , True, True, , , , True))

        CommonFunctions.General.WriteHTML("</DIV>")
        'CommonFunction.General.WriteHTML(strMenu) 'Bottom menu
        'CommonFunctions.General.WriteHTML("<BR>")
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim strTaskIDs As String
        Dim drCompanyInformation As IDataReader
        Dim intFirstDay As Integer
        Dim dtFromDate As Date
        Dim drDates As IDataReader
        'Added By ShraddhaM on 21 Aug 2006
        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim strTemp As String = ""
        Dim strsql As String = ""
        Dim dr As IDataReader

        If IsNothing(Request.QueryString("FromXML")) = True Or (Request.QueryString("FromXML") & "").Trim <> "1" Then


            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            'Ended by ShraddhaM on 21 Aug 2006
            ''--- Get the StartingDayOfWeek
            'strSQLQuery = "EXEC usp_Sel_tbl_PM_CompanyInformation"
            'drCompanyInformation = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            'If drCompanyInformation.Read Then
            '    intFirstDay = CType(CommonFunctions.Data.CheckIsDBNull(drCompanyInformation("StartingDayOfWeek"), "1"), Integer)
            'End If
            'CommonFunctions.Data.DisposeDataReader(drCompanyInformation)
            intFirstDay = CommonFunction.Application.StartDayOfWeek
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            '--- Task Type
            m_strTaskType = "O"

            '--- From Date
            m_dtFromDate = Request.QueryString("FromDate")

            '--- To Date
            m_dtToDate = Request.QueryString("ToDate")

            'Modified by nitinvs on 26 July 2007 for WhizibleSEM 7 to initialize the project and employee from form

            '--- ProjectID
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
                m_intProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")), Integer)
            ElseIf CommonFunctions.General.CheckIsNothing(Request.Form("cboProject"), "") <> "" Then
                m_intProjectID = CType(Request.Form("cboProject"), Integer)
            Else

                m_intProjectID = CInt(Session("intProjectID"))
            End If
            'Added by NitinC on 20 Jan 2012 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 58849)
            m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_intProjectID.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            'End of Added by NitinC on 20 Jan 2012 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 58849)

            'intigrated by harshk for sp4 issueid 190
            'Purpose - To Fetch EmployeeID from QueryString
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")) <> "" Then
                m_intEmployeeID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("EmployeeID")), Integer)
            ElseIf CommonFunctions.General.CheckIsNothing(Request.Form("cboEmployee"), "") <> "" Then
                m_intEmployeeID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboProject"), "0"), Integer)
            End If
            'End of Addition
            'Modified by nitinvs on 26 July 2007 for WhizibleSEM 7 

            'end
            ' to solve the issue - When Date Range is given say 1-Jan to 31st May it still shows the Week 1-Jan to 7-Jan 
            ' after post back .
            If (Request.QueryString("Weekly") = "True" Or (Request.QueryString("Weekly") = "") And Request.QueryString("FromDate") = "" Or Request.QueryString("ToDate") = "") Then
                If Request.QueryString("FromDate") = "" Or Request.QueryString("FromDate") Is Nothing Then
                    If m_blnUseClientDateForDA = True Then
                        dtFromDate = CType(Session("ClientDate"), Date)
                    Else
                        dtFromDate = Now()
                    End If

                Else
                    dtFromDate = CType(m_dtFromDate, Date)
                End If

                'm_dtFromDate = CommonFunctions.Dates.GetDate(CDate(dtFromDate.AddDays((dtFromDate).DayOfWeek * (-1I) + intFirstDay)))
                'm_dtToDate = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate, Date))))

                '--- Get the StartingDayOfWeek
                If dtFromDate.ToString <> "" Then
                    strSQLQuery = "EXEC usp_Get_WeekDates '" + FormatDateTime(dtFromDate, DateFormat.ShortDate).ToString + "'"
                    drDates = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    If drDates.Read Then
                        m_dtFromDate1 = CommonFunctions.Dates.GetDate(CType(drDates("StartDate"), Date))
                        m_dtToDate1 = CommonFunctions.Dates.GetDate(CDate(DateAdd("d", 6, CType(m_dtFromDate1, Date))))
                    End If
                    CommonFunctions.Data.DisposeDataReader(drDates)
                End If
            End If


            'Added By ShraddhaM 21 Aug 2006

            strQuery = "Exec usp_Get_ProjectLocationWorkingHours_Days " & m_intProjectID.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    m_dblHoursPerDay = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingHours"), "0"), Double)
                    m_lngWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("WorkingDays"), "0"), Long)
                End If
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            CommonFunction.Data.DisposeDataReader(drWork)
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            'usp_sel_tbl_PM_Project_TaskCaseStructure
            'strQuery = "SELECT HaveSubTaskTypes, ApplyEffortDistribution, LocationID, ExpectedStartDate, ExpectedEndDate"
            'strQuery &= " FROM tbl_PM_Project WHERE ProjectID = " & m_intProjectID.ToString()
            strQuery = "usp_sel_tbl_PM_Project_TaskCaseStructure " & m_intProjectID.ToString()
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If drWork.Read() Then
                'blnUseActivities = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("HaveSubTaskTypes"), "False"), Boolean)
                'blnApplyEffortDistribution = CType(CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ApplyEffortDistribution"), "False"), Boolean)
                m_lngProjectLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("LocationID"), "0"), Long)
                'm_strProjectStartDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedStartDate"), "").ToString()
                'm_strProjectEndDate = CommonFunctions.Data.CheckIsDBNull(drProjectSettings.Item("ExpectedEndDate"), "").ToString()
                'If m_strProjectStartDate <> "" Then m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
                'If m_strProjectEndDate <> "" Then m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))
            End If
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            CommonFunction.Data.DisposeDataReader(drWork)
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            m_strHolidays = ""
            strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & m_lngProjectLocationID.ToString()
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                While drWork.Read()
                    strTemp = drWork.Item("HolidayDate").ToString()
                    If strTemp <> "" Then
                        m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                    End If
                End While
            End If
            'Ended by ShraddhaM
            'Added On 29 Aug 2006
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            CommonFunction.Data.DisposeDataReader(drWork)
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            Dim drLCE As IDataReader

            Dim blnAllowLCEDistribution As Boolean = False
            Dim strMsg As String = ""

            strQuery = "EXEC usp_Sel_PM_DepartmentBalanceLCE " & m_intProjectID.ToString()

            drLCE = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drLCE) <> "" Then
                If drLCE.Read() Then
                    m_dblTotalAllocatedTaskLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("AllocatedLCETotal"), "0"), Double)
                    m_dblTotalLCE = CType(CommonFunctions.Data.CheckIsDBNull(drLCE.Item("LCETotal"), "0"), Double)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drLCE)
            ''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
            'For Week Ends 
            'strsql = "Select StartingDayOfWeek from tbl_PM_CompanyInformation"
            'm_strStartingDayOfWeek = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strsql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
            m_strStartingDayOfWeek = CommonFunction.Application.StartDayOfWeek.ToString()
            ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 
        End If
    End Sub

    Private Sub DrawGrid()
        Dim strTaskIDs_seperator As String
        Dim dtStartDate As String
        Dim dtEndDate As String
        Dim strStartDate As String
        Dim strEndDate As String
        'added by TruptiK on 25-Mar-09
        Dim strActualendDate As String
        'end of addition by TrupitK

        Dim dr As IDataReader
        Dim strTRClass As String = "'clsTREven'"
        Dim strTaskFilter As String
        Dim count_hidTaskControls As Int32 = 1
        Dim strHiddenName As String = ""
        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "")
        If strTaskFilter = "2" Then
            strTaskFilter = " NULL "

        End If
        'Added By ShraddhaM on 17 Aug 2006 for WhizibleSEM
        If comboProjectID = CInt(Session("intProjectID")) And MyBase.GetFormValue("cboProject") = "" Then
            m_dtFromDate = m_dtFromDate1
            m_dtToDate = m_dtToDate1
        Else
            m_dtFromDate = MyBase.GetFormValue("txtFromDate")
            m_dtToDate = MyBase.GetFormValue("txtToDate")
            'If m_dtToDate = "" Then
            '    m_dtToDate = CType(Now().ToString("dd-MMM-yyyy").TrimEnd, String)
            'End If
        End If



        'm_dtFromDate = MyBase.GetFormValue("txtFromDate")
        'm_dtToDate = MyBase.GetFormValue("txtToDate")
        'm_dtFromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFromDate"), "")
        'm_dtToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtToDate"), "")
        Dim IsClosedProject As String
        Dim IsProjectOnHold As String
        '= "select actualEndDate from tbl_pm_project where actualEndDate is null and projectid=" & CType(m_intProjectID, String)

        ''''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'IsClosedProject = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select actualEndDate from tbl_pm_project where projectid=" & CType(m_intProjectID, String), MyBase.UseSQL), ""), String)
        IsClosedProject = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_pm_project_actualEndDate " & CType(m_intProjectID, String), MyBase.UseSQL), ""), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'Modified BY NitinVs on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 
        'Replaced * with projectID 

        ''''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'IsProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select ProjectId from tbl_pm_project where projectID= " & CType(m_intProjectID, String) & " AND projectStatusId in(select projectstatusID from tbl_cnf_projectStatus where maptoProjectonHold=1)", MyBase.UseSQL), ""), String)
        IsProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_pm_project_projectID_projectstatusID " & CType(m_intProjectID, String), MyBase.UseSQL), ""), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        'End Modification BY NitinVs on 2 May 2007 for WhizibleSEM SP 8 Regression Fixes 

        'dr = CommonFunction.Data.GetDataReader(IsClosedProject, MyBase.UseSQL)
        Dim IsAcess As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("select dbo.udf_TaskDelegationAccess_TaskEdit(" & CType(m_intProjectID, String) & "," & CType(Session("intUserID"), String) & ",1,3)", MyBase.UseSQL), ""), String)
        'CommonFunction.Data.GetDataScalar("EXEC usp_CheckProjectAccess 1038," & CType(m_intProjectID, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL)
        ' Or IsAcess = "0"
        If IsClosedProject <> "" Or IsAcess = "0" Or IsProjectOnHold <> "" Then
            m_intProjectID = 0
        End If

        Dim SQL As String = "EXEC usp_Sel_tbl_PM_TasksForEdition " & CType(m_intProjectID, String) & "," & CType(m_intEmployeeID, String) & " , '" & CType(m_dtFromDate, String) & "', '" & CType(m_dtToDate, String) & "','O'"

        If strTaskFilter = "" Then
            SQL = SQL + ", NULL"
        End If

        ''Plotting DIV DIVSTYLE AND TABLE STYLE
        'CommonFunction.General.WriteHTML("<DIV id=DivList style='overflow:auto;' >")
        CommonFunction.General.WriteHTML("<DIV id='DivList' style='overflow:auto;Height=350px' >")
        CommonFunction.General.WriteHTML("<STYLE type=text/css>{")
        CommonFunction.General.WriteHTML("TABLE {TABLE-LAYOUT: fixed;}")
        CommonFunction.General.WriteHTML("THEAD TH.DivList_Column {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.DivList_Column.locked {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.DivList_Column.locked {Z-INDEX: 30}")
        CommonFunction.General.WriteHTML("THEAD TH.DivList_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivList').scrollTop -1)}")
        CommonFunction.General.WriteHTML("TH.DivList_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivList').scrollLeft); POSITION:relative()}")
        CommonFunction.General.WriteHTML(" }</STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>{")
        CommonFunction.General.WriteHTML("TABLE {TABLE-LAYOUT: fixed;}")
        CommonFunction.General.WriteHTML("THEAD TH.Separator_DivList_Column {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.Separator_DivList_Column.locked {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.Separator_DivList_Column.locked {Z-INDEX: 30}")
        CommonFunction.General.WriteHTML("THEAD TH.Separator_DivList_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivList').scrollTop -1)}")
        CommonFunction.General.WriteHTML("TH.Separator_DivList_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivList').scrollLeft); POSITION:relative()}")
        CommonFunction.General.WriteHTML("THEAD TH.Separator_DivList {border-right: thin; padding-right: 1pt; ")
        CommonFunction.General.WriteHTML("border-top: thin; padding-left: 1pt; font-weight: bolder; font-size: 1pt; ")
        CommonFunction.General.WriteHTML("background-image: none; padding-bottom: 1pt; border-left: thin; width: 1px; ")
        CommonFunction.General.WriteHTML("color: black; padding-top: 1pt; border-bottom: thin; height: 22px; ")
        CommonFunction.General.WriteHTML("background-color: black;}")
        CommonFunction.General.WriteHTML("}</STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>{")

        CommonFunction.General.WriteHTML("TABLE {TABLE-LAYOUT: fixed;}")
        CommonFunction.General.WriteHTML("THEAD TH.Sort_DivList_Column {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.Sort_DivList_Column.locked {POSITION: relative;}")
        CommonFunction.General.WriteHTML("THEAD TH.Sort_DivList_Column.locked {Z-INDEX: 30}")
        CommonFunction.General.WriteHTML("THEAD TH.Sort_DivList_Column {Z-INDEX: 20;; TOP: expression(document.getElementById('DivList').scrollTop -1)}")
        CommonFunction.General.WriteHTML("TH.Sort_DivList_Column {Z-INDEX: 10;; LEFT: expression(document.getElementById('DivList').scrollLeft); POSITION:relative()}")
        CommonFunction.General.WriteHTML("THEAD TH.Sort_DivList_Column {border-right: thin; padding-right: 1pt; ")
        CommonFunction.General.WriteHTML("border-top: thin; padding-left: 1pt; font-weight: normal; font-size: 11px; ")
        CommonFunction.General.WriteHTML("padding-bottom: 1pt; border-left: thin; color: white; padding-top: 1pt;")
        CommonFunction.General.WriteHTML("border-bottom: thin; font-family: Verdana, Arial; height: 22px; background:")
        CommonFunction.General.WriteHTML("#3D5FA3; background-image:url(../../Images/cssImages/columnhdr_sel_bg.gif);}")
        CommonFunction.General.WriteHTML(" }</STYLE>")

        CommonFunction.General.WriteHTML("<STYLE type=text/css>")
        CommonFunction.General.WriteHTML("Td.Locked, th.Locked {")
        CommonFunction.General.WriteHTML("")
        CommonFunction.General.WriteHTML("left: expression(document.getElementById('DivList').scrollLeft);")
        CommonFunction.General.WriteHTML("position: relative;")
        CommonFunction.General.WriteHTML("z-index: 5;")
        CommonFunction.General.WriteHTML("}")
        CommonFunction.General.WriteHTML("</STYLE>")

        'End of plotting style and div

        CommonFunction.General.WriteHTML("<TABLE class='clsGridTable'  cellpadding=0 cellspacing=1 width='99.9%'>")
        'Column headers
        'class='clsTRColumnHeader'
        'class='clsTRPageCaption'
        CommonFunction.General.WriteHTML("<TR class='clsTRPageCaption'>")
        CommonFunction.General.WriteHTML("<TD align=left width=4%></TD>")
        CommonFunction.General.WriteHTML("<TD align=left width=15%>Task Name</TD>")
        'CommonFunction.General.WriteHTML("<TD align=left width=15%></TD>")
        CommonFunction.General.WriteHTML("<TD align=left width=10%>Resource</TD>")
        CommonFunction.General.WriteHTML("<TD align=centre width=10%>Start Date</TD>")
        CommonFunction.General.WriteHTML("<TD align=centre width=10%>End Date</TD>")
        CommonFunction.General.WriteHTML("<TD align=centre width=7%>Planned Work[Hrs]</TD>")
        CommonFunction.General.WriteHTML("<TD align=centre width=7%>Actual Work[Hrs]</TD>")
        'CommonFunction.General.WriteHTML("<TD align=centre width=7%>Update Baseline</TD>")

        If m_intProjectID & "" <> "" Then
            dr = CommonFunction.Data.GetDataReader(SQL, MyBase.UseSQL)
        Else
            Response.End()
        End If


        'Dim IsApplyEffort As String = "select ApplyEffortdistribution from tbl_pm_project where projectid =" + CType(m_intProjectID, String)
        'Dim HaveSubTask As String = "select havesubtasktypes from tbl_pm_project where projectid =" + CType(m_intProjectID, String)

        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'ProjectStartDate = "select ExpectedStartDate from tbl_pm_project where projectid =" + CType(m_intProjectID, String)
        'ProjectEndDate = "select ExpectedEndDate from tbl_pm_project where projectid =" + CType(m_intProjectID, String)

        'ProjectStartDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(ProjectStartDate, MyBase.UseSQL), ""), String)
        'ProjectEndDate = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(ProjectEndDate, MyBase.UseSQL), ""), String)

        'If ProjectStartDate <> "" Then ProjectStartDate = CommonFunctions.Dates.GetDate(CType(ProjectStartDate, Date))
        'If ProjectEndDate <> "" Then ProjectEndDate = CommonFunctions.Dates.GetDate(CType(ProjectEndDate, Date))

        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 


        'Dim IsApplyEffort1 As Boolean = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(IsApplyEffort, MyBase.UseSQL), ""), Boolean)
        'Dim HaveSubTask1 As Boolean = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(HaveSubTask, MyBase.UseSQL), ""), Boolean)
        Dim IsApplyEffort1 As Boolean
        Dim HaveSubTask1 As Boolean
        Dim STRSQL As String = " usp_sel_tbl_PM_Project_TaskCaseStructure " & CType(m_intProjectID, String)
        Dim objDr As IDataReader
        objDr = CommonFunction.Data.GetDataReader(STRSQL, MyBase.UseSQL)
        If objDr.Read() Then
            IsApplyEffort1 = CType(CommonFunction.Data.CheckIsDBNull(objDr("ApplyEffortdistribution"), "0"), Boolean)
            HaveSubTask1 = CType(CommonFunction.Data.CheckIsDBNull(objDr("havesubtasktypes"), "0"), Boolean)
            ProjectStartDate = CType(CommonFunction.Data.CheckIsDBNull(objDr("ExpectedStartDate"), "0"), String)
            ProjectEndDate = CType(CommonFunction.Data.CheckIsDBNull(objDr("ExpectedEndDate"), "0"), String)
            m_bitResourceValidation = CType(CommonFunction.Data.CheckIsDBNull(objDr("ResourceValidation"), "0"), Boolean)
        End If
        ' Modified By NitinVS on 8 May 2007 for WhizibleSEM 7.0
        CommonFunction.Data.DisposeDataReader(objDr)
        ' End Modification By NitinVS on 8 May 2007 for WhizibleSEM 7.0 

        'Modified by NitinVS on 2 May 2007 for WhizibleSEM SP 8 regression Fixes "
        'Moved the call out side of While Loop 

        'Modified By ShraddhaM on 7 Aug 2006 for WhizibleSEM to Display date in proper format..
        Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim DateFormat As String = "select FormatDate from tbl_pm_dateformats where DateFormatID= " + CType(dateFormatID, String)
        Dim DateFormat As String = "usp_sel_tbl_pm_dateformats_FormatDate " + CType(dateFormatID, String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
        'Strsql = "select top 1 comments from tbl_PM_ExpenseEntry_status_History where expensesentryid=" + ExpenseEntry + " order by lastupdateddate desc"
        strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)

        'End Modification by NitinVS on 2 May 2007 for WhizibleSEM SP 8 regression Fixes 

        '24 Aug 2006
        If IsApplyEffort1 = False And HaveSubTask1 = False Then
            'For Case 1 Project..
            IsCaseOneProject = True
            CommonFunction.General.WriteHTML("</TR>")


            While dr.Read
                m_intTaskID = CType(dr("TaskID"), String)

                If CType(CommonFunctions.Data.CheckIsDBNull(dr("HasChildTasks"), "0"), String) <> "0" Then

                    ParentTaskName = dr("TaskName").ToString
                    CommonFunction.General.WriteHTML("<TD align='left' name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    'CommonFunction.General.WriteHTML("<img id=folderimg" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " src='../../Images/TreeNodeImages/folder.gif' height=15>")
                    CommonFunction.General.WriteHTML("</TD>")


                Else
                    m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ParentTask_UID"), "0"), Integer)
                    Dim Task As String
                    Task = dr("TaskName").ToString
                    strTRClass = "'clsTROdd'"
                    CommonFunction.General.WriteHTML("<TR class='clsTREven' onclick=PlotControls('" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "')>")

                    CommonFunction.General.WriteHTML("<TD align='left' name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    CommonFunction.General.WriteHTML("<img id=folderimg" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " src='../../Images/TreeNodeImages/folder.gif' height=15>")
                    CommonFunction.General.WriteHTML("</TD>")

                    CommonFunction.General.WriteHTML("<TD align='left' name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    CommonFunction.General.WriteHTML(ParentTaskName)
                    CommonFunction.General.WriteHTML("</TD>")

                End If


                strTaskIDs_seperator += m_intTaskID + ","

                'Employee Name
                CommonFunction.General.WriteHTML("<TD align='left' width=10% id=TDEmployeeName_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                CommonFunction.General.WriteHTML(dr("EmployeeName").ToString)
                EmpId = dr("EmployeeID").ToString

                CommonFunction.General.WriteHTML("<input type=hidden name=hidEmpID" + m_intTaskID + " id=hidEmpID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value ='" + EmpId + "'>")

                CommonFunction.General.WriteHTML("</TD>")
                If EmpId <> "" Then
                    'Start Date
                    CommonFunction.General.WriteHTML("<TD align='left' id=TDStartDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                    'Modified BY NitinVS on 2 May 2007 for WhizibleSEM SP 8 REgression Fixes 
                    'Moved the select out of while loop as it is not going to change per record
                    '*****************************

                    ''Modified By ShraddhaM on 7 Aug 2006 for WhizibleSEM to Display date in proper format..
                    'Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)
                    'Dim DateFormat As String = "select FormatDate from tbl_pm_dateformats where DateFormatID= " + CType(dateFormatID, String)
                    'strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
                    ''Strsql = "select top 1 comments from tbl_PM_ExpenseEntry_status_History where expensesentryid=" + ExpenseEntry + " order by lastupdateddate desc"
                    'strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)

                    'End Modification BY NitinVS on 2 May 2007 for WhizibleSEM SP 8 REgression Fixes 

                    dtStartDate = dr("StartDate").ToString
                    strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtStartDate))
                    'dtStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtStartDate))
                    dtEndDate = dr("EndDate").ToString
                    'dtEndDate = CommonFunctions.Dates.GetDate(CType(dr("EndDate"), Date))
                    strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtEndDate))
    'Trupti
                    strActualendDate = Data.CheckIsDBNull(dr("ActualStartDate"), "").ToString

                    'End

                    '*****************************
                    'CommonFunction.General.WriteHTML("<LABEL id=lblStartDate_" + m_intTaskID + ">" + dr("StartDate").ToString + "</LABEL>")
                    CommonFunction.General.WriteHTML("<LABEL name=tdParentStartDate_" + m_intParentTask_UID.ToString + " id=lblStartDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">" + strStartDate.ToString + "</LABEL>")
                    CommonFunction.General.WriteHTML("</TD>")

                    'End Date
                    CommonFunction.General.WriteHTML("<TD align='left' id=TDEndDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                    'CommonFunction.General.WriteHTML("<LABEL id=lblEndDate_" + m_intTaskID + ">" + dr("EndDate").ToString + "</LABEL>")
                    CommonFunction.General.WriteHTML("<LABEL name=tdParentEndDate_" + m_intParentTask_UID.ToString + " id=lblEndDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">" + strEndDate.ToString + "</LABEL>")
                    CommonFunction.General.WriteHTML("</TD>")

                    'Planned Work[Hrs]
                    CommonFunction.General.WriteHTML("<TD align='right' width=5% name=tdParentPlanned_" + m_intParentTask_UID.ToString + " id=TDPlanned_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                    CommonFunction.General.WriteHTML("<LABEL name=tdParentPlanned_" + m_intParentTask_UID.ToString + " id=lblPlanned_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">" + dr("PlannedWork").ToString + "</LABEL>")
                    CommonFunction.General.WriteHTML("</TD>")
                    'm_GroupTotal += CType(dr("Duration"), Double)

                    'Actual Work[Hrs]
                    CommonFunction.General.WriteHTML("<TD align='right' width=5% id=TDActual" + m_intTaskID + "> ")
                    CommonFunction.General.WriteHTML("<LABEL id=lblActual" + m_intTaskID + ">" + dr("ActualWork").ToString + "</LABEL>")
                    CommonFunction.General.WriteHTML("</TD>")


                    '--- added By purvaj on 28 Nov 2008 for whiziblesem 8.0 
                    '--- validation : Planned efforts should be greater than actual efforts
                    CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidtxtActual" + m_intTaskID + " name=hidtxtActual" + m_intTaskID + " value=" + dr("ActualWork").ToString + ">")
     If strActualendDate <> "" Then
                        CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidtxtActualStartDate" + m_intTaskID + " name=hidtxtActualStartDate" + m_intTaskID + " value=" + (CDate(strActualendDate).ToString("dd-MMM-yyyy")) + ">")
                    Else
                        CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidtxtActualStartDate" + m_intTaskID + " name=hidtxtActualStartDate" + m_intTaskID + " value=" + strActualendDate + ">")
                    End If

                    '--- end addition purvaj

                    'Update Baseline
                    'CommonFunction.General.WriteHTML("<TD align='left' id=TDUpdateBaseline_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                    'CommonFunction.General.WriteHTML("<LABEL id=lblUpdateBaseline_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    'CommonFunction.General.WriteHTML("</TD>")

                    CommonFunction.General.WriteHTML("<input type=hidden name=hid_TotalHid_TS_Ctrls id=hid_TotalHid_TS_Ctrls value=" + m_intTaskID + ">")
                    CommonFunction.General.WriteHTML("</TR>")

                    'If IsXMLHTTP_Off = True Then
                    CommonFunction.General.WriteHTML("<input type=hidden name=hidStartDate" + m_intTaskID + " id=hidStartDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value ='" + strStartDate.ToString + "'>")
                    CommonFunction.General.WriteHTML("<input type=hidden name=hidEndDate" + m_intTaskID + " id=hidEndDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value='" + strEndDate.ToString + "'>")
                    CommonFunction.General.WriteHTML("<input type=hidden name=hidPlanned_" + m_intParentTask_UID.ToString + " id=hidPlanned_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value=" + dr("PlannedWork").ToString + ">")
                    CommonFunction.General.WriteHTML("<input type=hidden name=hidUpdBaseline" + m_intTaskID + " id=hidUpdBaseline_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    'End If
                    'Else

                End If
            End While


            '24 Aug 2006
        Else
            'Dim drChild As IDataReader
            While dr.Read
                m_intTaskID = CType(dr("TaskID"), String)

                If CType(CommonFunctions.Data.CheckIsDBNull(dr("HasChildTasks"), "0"), String) <> "0" Then

                    m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(dr("TaskID"), "0"), Integer)


                    'Dim SQLForChildTaskSum As String = "EXEC usp_GetChildSum" & CType(m_intProjectID, String) & "," & m_intParentTask_UID.ToString()
                    'Dim drChild As IDataReader = CommonFunction.Data.GetDataReader(SQLForChildTaskSum, MyBase.UseSQL)
                    'drChild.Read()

                    'Dim ChildSum As String = CType(drChild("ChildTaskSum"), String)

                    strTRClass = "'clsTRSectionHeader'"
                    CommonFunction.General.WriteHTML("<TR class='clsTRSectionHeader' onclick=PlotControls(" + m_intTaskID + ") >")
                    CommonFunction.General.WriteHTML("<TR class='clsTRSectionHeader'>")
                    'ChildTaskSum
                    'CommonFunction.General.WriteHTML("<td><input type=hidden name=hidChildSumID" + m_intTaskID + " id=hidChildSumID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value ='" + ChildSum + "'></td>")

                    CommonFunction.General.WriteHTML("<TD align='left' width=4% name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    ' CommonFunction.General.WriteHTML("<img src=" + "../../Images/TreeNodeImages/folder.gif" + " height=15> </TD>")
                    CommonFunction.General.WriteHTML("</TD>")

                    CommonFunction.General.WriteHTML("<TD align='left' id=td_ParentID_" + m_intTaskID + "colspan=2>")
                    CommonFunction.General.WriteHTML(dr("TaskName").ToString)
                    'CommonFunction.General.WriteHTML("&nbsp;&nbsp;&nbsp; <A class='Menu' style='' HREF=""Javascript:editAll_onClick(" + count_hidTaskControls.ToString + ")"" Title='Multiedit for Task' >MultiEdit</A> </TD>")

                    strHiddenName = "hidTaskIDs" + (count_hidTaskControls - 1).ToString
                    CommonFunction.General.WriteHTML("<input type=hidden name=" + strHiddenName + " id=" + strHiddenName + " value='" + strTaskIDs_seperator + "' >")
                    strTaskIDs_seperator = ""
                    count_hidTaskControls += 1
                Else
                    m_intParentTask_UID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ParentTask_UID"), "0"), Integer)
                    Dim Task As String
                    Task = dr("TaskName").ToString
                    strTRClass = "'clsTROdd'"
                    CommonFunction.General.WriteHTML("<TR class='clsTREven' onclick=PlotControls('" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "')>")

                    CommonFunction.General.WriteHTML("<TD align='left' width=4% name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    'CommonFunction.General.WriteHTML("<img src=" + "../../Images/TreeNodeImages/folder.gif" + " height=15> </TD>")
                    'CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<img id=folderimg" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " src='../../Images/TreeNodeImages/folder.gif' height=15>")
                    CommonFunction.General.WriteHTML("</TD>")

                    CommonFunction.General.WriteHTML("<TD align='left' name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    CommonFunction.General.WriteHTML(dr("TaskName").ToString)
                    CommonFunction.General.WriteHTML("</TD>")
                    'Else
                    'CommonFunction.General.WriteHTML("<TR class='clsTREven' onclick=PlotControls('" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "')>")
                    'CommonFunction.General.WriteHTML("<TD align='left' name=td_Parent_" + m_intParentTask_UID.ToString + " id=td_TaskID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                    'CommonFunction.General.WriteHTML("<img src=" + "../../Images/TreeNodeImages/folder.gif" + " height=15> </TD>")
                    ' CommonFunction.General.WriteHTML("</TD>")

                    'CommonFunction.General.WriteHTML("<TD align=center >")
                    'CommonFunction.General.WriteHTML("<img src=" + "../../Images/TreeNodeImages/folder.gif" + " height=15> </TD>")
                    'End If
                End If

                'Task Name
                'CommonFunction.General.WriteHTML("<TR class=" + strTRClass + " onclick=PlotControls(" + dr("TaskID").ToString + ")>")
                'CommonFunction.General.WriteHTML("<TD align='left'> ")
                'CommonFunction.General.WriteHTML(dr("TaskName").ToString)
                'CommonFunction.General.WriteHTML("</TD>")
                strTaskIDs_seperator += m_intTaskID + ","

                'Employee Name
                CommonFunction.General.WriteHTML("<TD align='left' width=10% id=TDEmployeeName_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                CommonFunction.General.WriteHTML(dr("EmployeeName").ToString)
                EmpId = dr("EmployeeID").ToString

                CommonFunction.General.WriteHTML("<input type=hidden name=hidEmpID" + m_intTaskID + " id=hidEmpID_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value ='" + EmpId + "'>")
                'm_strHolidays = ""
                'strQuery = "EXEC usp_Sel_tbl_PM_Location_Holiday " & EmpId.ToString()
                'drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                'If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                '    While drWork.Read()
                '        strTemp = drWork.Item("HolidayDate").ToString()
                '        If strTemp <> "" Then
                '            m_strHolidays &= CommonFunctions.Dates.GetDate(CType(strTemp, Date)) & ","
                '        End If
                '    End While
                'End If
                CommonFunction.General.WriteHTML("</TD>")

                'Start Date

                CommonFunction.General.WriteHTML("<TD align='left' id=TDStartDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                '*****************************
                'Modified BY NitinVS on 2 May 2007 for WhizibleSEM SP 8 regression Fixes 
                'Moved code out of while loop 

                ''Modified By ShraddhaM on 7 Aug 2006 for WhizibleSEM to Display date in proper format..
                'Dim dateFormatID As Integer = CType(CommonFunctions.Application.DateFormatID, Integer)
                'Dim DateFormat As String = "select FormatDate from tbl_pm_dateformats where DateFormatID= " + CType(dateFormatID, String)
                'strInputFormat = CType(CommonFunctions.Application.InputeDateFormat, String)
                ''Strsql = "select top 1 comments from tbl_PM_ExpenseEntry_status_History where expensesentryid=" + ExpenseEntry + " order by lastupdateddate desc"
                'strDateFormat = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(DateFormat, MyBase.UseSQL), ""), String)

                'End Modification BY NitinVS on 2 May 2007 for WhizibleSEM SP 8 regression Fixes 

                dtStartDate = dr("StartDate").ToString
                strStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtStartDate))
                'dtStartDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtStartDate))
                dtEndDate = dr("EndDate").ToString
                'dtEndDate = CommonFunctions.Dates.GetDate(CType(dr("EndDate"), Date))
                strEndDate = CommonFunctions.Dates.CGetDate(Date.Parse(dtEndDate))
 'Trupti
                strActualendDate = Data.CheckIsDBNull(dr("ActualStartDate"), "").ToString

                '*****************************
                'CommonFunction.General.WriteHTML("<LABEL id=lblStartDate_" + m_intTaskID + ">" + dr("StartDate").ToString + "</LABEL>")
                CommonFunction.General.WriteHTML("<LABEL name=tdParentStartDate_" + m_intParentTask_UID.ToString + " id=lblStartDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">" + strStartDate.ToString + "</LABEL>")
                CommonFunction.General.WriteHTML("</TD>")

                'End Date
                CommonFunction.General.WriteHTML("<TD align='left' id=TDEndDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                'CommonFunction.General.WriteHTML("<LABEL id=lblEndDate_" + m_intTaskID + ">" + dr("EndDate").ToString + "</LABEL>")
                CommonFunction.General.WriteHTML("<LABEL name=tdParentEndDate_" + m_intParentTask_UID.ToString + " id=lblEndDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">" + strEndDate.ToString + "</LABEL>")
                CommonFunction.General.WriteHTML("</TD>")

                'Planned Work[Hrs]
                CommonFunction.General.WriteHTML("<TD align='right' width=5% name=tdParentPlanned_" + m_intParentTask_UID.ToString + " id=TDPlanned_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                CommonFunction.General.WriteHTML("<LABEL name=tdParentPlanned_" + m_intParentTask_UID.ToString + " id=lblPlanned_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">" + dr("PlannedWork").ToString + "</LABEL>")
                CommonFunction.General.WriteHTML("</TD>")
                'm_GroupTotal += CType(dr("Duration"), Double)

                'Actual Work[Hrs]
                CommonFunction.General.WriteHTML("<TD align='right' width=5% id=TDActual" + m_intTaskID + "> ")
                CommonFunction.General.WriteHTML("<LABEL id=lblActual" + m_intTaskID + ">" + dr("ActualWork").ToString + "</LABEL>")
                CommonFunction.General.WriteHTML("</TD>")

                '--- added By purvaj on 28 Nov 2008 for whiziblesem 8.0 
                '--- validation : Planned efforts should be greater than actual efforts
                CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidtxtActual" + m_intTaskID + " name=hidtxtActual" + m_intTaskID + " value=" + dr("ActualWork").ToString + ">")
   If strActualendDate <> "" Then
                    CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidtxtActualStartDate" + m_intTaskID + " name=hidtxtActualStartDate" + m_intTaskID + " value=" + (CDate(strActualendDate).ToString("dd-MMM-yyyy")) + ">")
                Else
                    CommonFunction.General.WriteHTML("<INPUT Type=hidden id=hidtxtActualStartDate" + m_intTaskID + " name=hidtxtActualStartDate" + m_intTaskID + " value=" + strActualendDate + ">")
                End If
                '--- end addition purvaj


                'Update Baseline
                'CommonFunction.General.WriteHTML("<TD align='left' id=TDUpdateBaseline_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + "> ")
                'CommonFunction.General.WriteHTML("<LABEL id=lblUpdateBaseline_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                'CommonFunction.General.WriteHTML("</TD>")

                CommonFunction.General.WriteHTML("<input type=hidden name=hid_TotalHid_TS_Ctrls id=hid_TotalHid_TS_Ctrls value=" + m_intTaskID + ">")
                CommonFunction.General.WriteHTML("</TR>")

                'If IsXMLHTTP_Off = True Then
                CommonFunction.General.WriteHTML("<input type=hidden name=hidStartDate" + m_intTaskID + " id=hidStartDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value ='" + strStartDate.ToString + "'>")
                CommonFunction.General.WriteHTML("<input type=hidden name=hidEndDate" + m_intTaskID + " id=hidEndDate_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value='" + strEndDate.ToString + "'>")
                CommonFunction.General.WriteHTML("<input type=hidden name=hidPlanned_" + m_intParentTask_UID.ToString + " id=hidPlanned_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + " value=" + dr("PlannedWork").ToString + ">")
                CommonFunction.General.WriteHTML("<input type=hidden name=hidUpdBaseline" + m_intTaskID + " id=hidUpdBaseline_" + m_intTaskID + "_" + m_intParentTask_UID.ToString + ">")
                'End If

            End While
        End If
        CommonFunction.Data.DisposeDataReader(dr)
        'If m_strUserName <> "" Then
        '    CommonFunction.General.WriteHTML("<TR class='clsTRColumnHeader'>")
        '    CommonFunction.General.WriteHTML("<TD align='right' colspan=5>")
        '    CommonFunction.General.WriteHTML("Total Actual Work(hrs) for " + m_strUserName)
        '    CommonFunction.General.WriteHTML("</TD>")
        '    CommonFunction.General.WriteHTML("<TD align='right'>")
        '    CommonFunction.General.WriteHTML(m_GroupTotal.ToString)
        '    CommonFunction.General.WriteHTML("</TD>")
        '    CommonFunction.General.WriteHTML("<TD></TD><TD></TD>")
        '    CommonFunction.General.WriteHTML("</TR>")
        '    m_GroupTotal = 0

        'strHiddenName = "hidTaskIDs" + (count_hidTaskControls - 1).ToString
        'CommonFunction.General.WriteHTML("<input type=hidden name=" + strHiddenName + " id=" + strHiddenName + " value='" + strTaskIDs + "' >")
        '    'strTaskIDs = ""
        'End If
        CommonFunction.General.WriteHTML("<input type=hidden name=hid_TotalHid_TS_Ctrls id=hid_TotalHid_TS_Ctrls value=" + count_hidTaskControls.ToString + ">")
        CommonFunction.General.WriteHTML("</Table>")
        CommonFunction.General.WriteHTML("</DIV>")
    End Sub

    'Private Sub DrawPageFilters()
    '    CommonFunction.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Open' />")
    '    CommonFunction.General.WriteHTML("<TABLE width=100% class='clsTable'><TR class=clsTRSectionHeader><TD><A href='Javascript:showHide_div()'><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></A>&nbsp;&nbsp; Filters </TD></TR></TABLE>")
    '    CommonFunction.General.WriteHTML("<DIV id='FliterShow' name='FliterShow' height=20 style""'overflow:auto;display:''"">")
    '    CommonFunction.General.WriteHTML("<TABLE  cellspacing=0 cellpadding=0 Width=100% class=clsTable>")
    '    CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='right' >Project</TD><TD align='left' >")
    '    'To be changed later--------- Default ProjectID 
    '    CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " + CType(HttpContext.Current.Session.Item("UserID"), String), 300, CType(m_intProjectID, String), IsMandatory:=True)
    '    'CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " + CType(HttpContext.Current.Session.Item("UserID"), String), 300, "1364", IsMandatory:=True)
    '    CommonFunction.General.WriteHTML("</TD><TD align='right'>Resource Name</TD><TD align='left' >")
    '    CommonFunction.HTMLControls.DrawComboBox("cboResource", "EXEC usp_Sel_teammembers " + CType(m_intProjectID, String) + ",1", 200, CType(m_intEmployeeID, String), "onchange=filterChange()", True)
    '    CommonFunction.General.WriteHTML("</TD><TD></TD>")
    '    CommonFunction.General.WriteHTML("</TR><TR class='clsTREven'>")
    '    CommonFunction.General.WriteHTML("<TD align='right' >From Date </TD><TD align='left' >")
    '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , 80, str_FromDate_Filter, , "frmPM_TaskEasyEdit", returnHTML:=True, IsMandatory:=False))
    '    CommonFunction.General.WriteHTML("</TD><TD align='right' >To Date </TD><TD align='left' >")
    '    CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , 80, str_FromDate_Filter, , "frmPM_TaskEasyEdit", returnHTML:=True, IsMandatory:=False))
    '    CommonFunction.General.WriteHTML("</TD><TD><A class='Menu' style='' HREF=""Javascript:filterChange()"" Title='Show tasks between From date and To date' >|Show|</A></TD>")
    '    CommonFunction.General.WriteHTML("</TR>")
    '    CommonFunction.General.WriteHTML("</Table>")
    '    CommonFunction.General.WriteHTML("</DIV>")

    'End Sub

    Private Sub DisplaySelectionHeader()

        Dim blnIsChecked As Boolean
        Dim strSQLQuery As String
        Dim objDynamicLink As WebPages.UI.cDynamicLink

        '--- Query for displaying the Projects in Project Combo
        'Modified By VidyaJ - SP4 - IssueID - 362
        Dim intRoleLevel As Integer
        Dim m_strProjectFilters As String
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        m_strProjectFilters = ""
        'If middle level then apply filter for Projects
        If intRoleLevel = 2 Then
            'Apply Role Access Filter for Project List
            m_strProjectFilters = ""
            Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
            If strFilter <> "" Then
                m_strProjectFilters += strFilter
            End If

            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)

            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
        End If

        'udf_GetAccessibleProjectList
        ' strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",2,1"
        'strSQLQuery = "select dbo.udf_GetAccessibleProjectList(" + CType(Session("intUserID"), String) + ")"

        strSQLQuery = "EXEC usp_Sel_AccessibleProjects_ForEmployee_TaskEdit " + CType(Session("intUserID"), String) & ",0,0,0,0,'" & CType(Session("LoginType"), String) & "',0," & CType(Session("intLoginID"), Long) & ",3,1"

        'usp_Sel_AccessibleProjects_ForEmployee_TaskEdit
        '--- Display the Page Caption
        '23 Aug 2006
        'CommonFunctions.General.WriteHTML("<TABLE width=99.9% CellSpacing=0 class='clsTable'><TR class=clsTRBlank><TD align='Right'><B>(<IMG src='../../Images/Star.gif' border=0> Mandatory)</B> </TD></TR></TABLE>")
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Task Edition", , , True))
        'CommonFunctions.General.WriteHTML("<BR>")
        'Modified by ShraddhaM on 31st July 2006 for WhizibleSEM SP 7.2 Issue ID.4182
        'If m_FilterDivStatus = True Then
        '    CommonFunctions.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Open' />")
        '    CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/minus.gif' title=''></IMG></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
        '    CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=50   style=""overflow:auto;display:''"">")

        'Else
        '    CommonFunctions.General.WriteHTML("<input type=hidden name=hidFilterDivStatus id=hidFilterDivStatus value='Close' />")
        '    CommonFunctions.General.WriteHTML("<TABLE width=99.9% class='clsTable'><TR class=clsTRSectionHeader><TD><A href=""Javascript:showHide_div()""><Img Border=0 id=imgShowHide Src='../../Images/plus.gif' title=''></IMG></A>&nbsp;&nbsp; " & MyBase.GetResourceString("TASK_FILTERS_DIV") & " </TD></TR></TABLE>")
        '    CommonFunctions.General.WriteHTML("<DIV id='Show' name='Show' height=50   style=""overflow:auto;display:'none'"">")
        'End If

        '--- Display the Project combo, dates and option buttons for selection
        CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")

        '--- Project Combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven' Width = '100%'>")
        CommonFunctions.General.WriteHTML("<td align='Left' width=100%>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("Project")
        CommonFunctions.General.WriteHTML("&nbsp;")

        comboProjectID = m_intProjectID

        CommonFunctions.HTMLControls.DrawComboBox("cboProject", strSQLQuery, 230, CType(m_intProjectID, String), "onchange=filterChange()", True)
        CommonFunctions.General.WriteHTML("<IMG id=StarIDTo name=idStarIDTo display='none' src='../../Images/Star.gif' border=0>")

        'CommonFunctions.General.WriteHTML("</td>")

        'Purpose : Check Task Filter.('Show ALL Tasks' or 'Show Tasks For Period')
        Dim blnChecked As Boolean
        Dim strTaskFilter As String
        'Check Task Filter
        strTaskFilter = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optMainTaskFilter"), "")
        If strTaskFilter = "1" Then
            strTaskFilter = " NULL "
            blnChecked = True
        Else
            blnChecked = False
        End If
        Dim strQuery As String

        strQuery = "EXEC usp_Sel_TeamMembers_TaskEdit " & CType(m_intProjectID, String)
        'CommonFunctions.General.WriteHTML("<td align='Left' width=15%>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("Resource")
        'CommonFunctions.General.WriteHTML("</td>")
        ' CommonFunctions.General.WriteHTML("<td align='Left'width=32%>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strQuery, 100, CType(m_intEmployeeID, String), "onchange=filterChange()", True)
        'CommonFunctions.General.WriteHTML("</td> ")


        '<td align='Left'>")

        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , blnChecked, CStr("1"), , " language=Javascript OnClick=optTasks_OnClick(""ShowALL"") ", True, True))
        'CommonFunctions.General.WriteHTML("Show All Tasks")
        'CommonFunctions.General.WriteHTML("&nbsp;")
        If blnChecked = True Then
            blnChecked = False
        Else
            blnChecked = True
        End If
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , blnChecked, CStr("2"), , " language=JavaScript OnClick=optTasks_OnClick(""ShowWeekly"") ", True, True))
        'CommonFunctions.General.WriteHTML("Show Tasks For Selected Period")
        'CommonFunctions.General.WriteHTML("</td>")

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        'Date Filters
        ' CommonFunctions.General.WriteHTML("<td align='Left'>")

        CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        'CommonFunction.Dates.CGetDate(CType(dr("EntryDate"), Date))
        '21 Aug
        'CommonFunctions.General.
        '21 Aug
        'CommonFunctions.General.WriteHTML(" <td align='Left' width=15%>")

        m_dtFromDate = Request.QueryString("FromDate")
        m_dtToDate = Request.QueryString("ToDate")
        Dim dt_FromDate As Date
        Dim str_FromDate As String
        Dim dt_ToDate As Date
        Dim str_ToDate As String
        Dim str_IsEdit As String = Request.QueryString("IsEdit")
        Dim m_dtFromDate2 As String = MyBase.GetFormValue("txtFromDate")
        Dim m_dtToDate2 As String = MyBase.GetFormValue("txtToDate")

        If m_dtFromDate = "" And str_IsEdit = "" Then
            dt_FromDate = CType(m_dtFromDate1, Date)
            str_FromDate = CType(dt_FromDate.ToString("dd-MMM-yyyy").TrimEnd, String)

            dt_ToDate = CType(m_dtToDate1, Date)
            str_ToDate = CType(dt_ToDate.ToString("dd-MMM-yyyy").TrimEnd, String)
        ElseIf m_dtFromDate = "" And str_IsEdit = "1" Or m_dtToDate = "" Then
            'dt_FromDate = CType(m_dtFromDate, Date)
            'str_FromDate = CType(dt_FromDate.ToString("dd-MMM-yyyy").TrimEnd, String)

            str_FromDate = m_dtFromDate2
            str_ToDate = m_dtToDate2

            'dt_ToDate = CType(m_dtToDate, Date)
            'str_FromDate = CType(dt_ToDate.ToString("dd-MMM-yyyy").TrimEnd, String)
        Else
            dt_FromDate = CType(m_dtFromDate, Date)
            str_FromDate = CType(dt_FromDate.ToString("dd-MMM-yyyy").TrimEnd, String)
            dt_ToDate = CType(m_dtToDate, Date)
            str_ToDate = CType(dt_ToDate.ToString("dd-MMM-yyyy").TrimEnd, String)
        End If
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("From")

        'Dim dt_FromDate As Date = CType(m_dtFromDate1, Date)
        'Dim str_FromDate As String = CType(dt_FromDate.ToString("dd-MMM-yyyy").TrimEnd, String)

        'Dim dt_ToDate As Date = CType(m_dtToDate1, Date)
        'Dim str_ToDate As String = CType(dt_ToDate.ToString("dd-MMM-yyyy").TrimEnd, String)
        'Dim m_dtFromDate As Date = CType(Request.QueryString("FromDate"), Date)
        'Dim str_dtFromDate As String = CType(m_dtFromDate.ToString("dd-MMM-yyyy").TrimEnd, String)

        'Dim m_dtToDate As Date = CType(Request.QueryString("ToDate"), Date)
        'Dim str_dtToDate As String = CType(m_dtToDate.ToString("dd-MMM-yyyy").TrimEnd, String)


        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , str_FromDate, , "frmPM_TaskEasyEdit", returnHTML:=True, IsMandatory:=False))
        'CommonFunctions.General.WriteHTML("<IMG id=StarID name=idStarID display='none' src='../../Images/Star.gif' border=0>")

        CommonFunctions.General.WriteHTML("</Span>")

        ' CommonFunctions.General.WriteHTML("</td>")

        'CommonFunctions.General.WriteHTML("<td align='Left' width=15%>")

        ''CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("To")
        '//Modified By ShraddhaM on 2/08/2006 for Whiziblesem 6.0 SP 7.2 issue ID
        'CType(m_dtToDate1, Date).ToString
        'str_ToDate
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , str_ToDate, , "frmPM_TaskEasyEdit", returnHTML:=True, ISmandatory:=False))
        'CommonFunctions.General.WriteHTML("<IMG id=StarIDTo name=idStarIDTo display='none' src='../../Images/Star.gif' border=0>")
        '' CommonFunctions.General.WriteHTML("</Span>")
        ' CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("</tr><tr class='clsTREven'><td colspan=3>")
        'CommonFunctions.General.WriteHTML("</td>")

        '--- Display the Show Link
        'Display the Show Link
        'CommonFunctions.General.WriteHTML("<td align=center 'Style = Width = 5%'>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        CommonFunctions.General.WriteHTML("&nbsp;")
        objDynamicLink = New WebPages.UI.cDynamicLink
        objDynamicLink.LinkName = "Show"
        objDynamicLink.Tooltip = "Show"
        objDynamicLink.FunctionName = "Show_OnClick()"
        objDynamicLink.ReturnHTML = True
        CommonFunctions.General.WriteHTML(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        objDynamicLink = Nothing
        CommonFunctions.General.WriteHTML("</td>")

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")
        ''--- Task Type filters
        'CommonFunctions.General.WriteHTML("<TABLE ID='Task' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        'CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'> <td align='Left' colspan=4> </td> </tr>")
        'CommonFunctions.General.WriteHTML("<tr class='clsTREven' width = '100%'> <td align='Left'>")

        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optAllTasks", , blnChecked, CStr("1"), , " language=Javascript OnClick=optTasks_OnClick(""ShowALL"") ", True, True))
        ''CommonFunctions.General.WriteHTML("Show All Tasks")
        'CommonFunctions.General.WriteHTML("&nbsp;")
        'If blnChecked = True Then
        '    blnChecked = False
        'Else
        '    blnChecked = True
        'End If
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawOptionButton("optMainTaskFilter", "optTasksForTheWeek", , blnChecked, CStr("2"), , " language=JavaScript OnClick=optTasks_OnClick(""ShowWeekly"") ", True, True))
        ''CommonFunctions.General.WriteHTML("Show Tasks For Selected Period")
        'CommonFunctions.General.WriteHTML("</td>")

        ''Date Filters
        'CommonFunctions.General.WriteHTML("<td align='Left'>")

        'CommonFunctions.General.WriteHTML("<Span id=""FromDate"" name=""FromDate"" style=""visibility:visible"">")
        ''CommonFunction.Dates.CGetDate(CType(dr("EntryDate"), Date))
        ''21 Aug
        ''CommonFunctions.General.
        ''21 Aug

        'CommonFunctions.General.WriteHTML("From Date")
        ''Dim dt_FromDate As Date = CType(m_dtFromDate1, Date)
        ''Dim str_FromDate As String = CType(dt_FromDate.ToString("dd-MMM-yyyy").TrimEnd, String)

        ''Dim dt_ToDate As Date = CType(m_dtToDate1, Date)
        ''Dim str_ToDate As String = CType(dt_ToDate.ToString("dd-MMM-yyyy").TrimEnd, String)
        ''str_FromDate
        'm_dtFromDate = Request.QueryString("FromDate")
        'm_dtToDate = Request.QueryString("ToDate")
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_dtFromDate, , "frmPM_TaskEasyEdit", returnHTML:=True, IsMandatory:=False))
        'CommonFunctions.General.WriteHTML("<IMG id=StarID name=idStarID display='none' src='../../Images/Star.gif' border=0>")

        'CommonFunctions.General.WriteHTML("</Span>")

        'CommonFunctions.General.WriteHTML("</td>")

        'CommonFunctions.General.WriteHTML("<td align='Left'>")

        'CommonFunctions.General.WriteHTML("<Span id=""ToDate"" name=""ToDate"" style=""visibility:visible"">")

        'CommonFunctions.General.WriteHTML("To Date")
        ''//Modified By ShraddhaM on 2/08/2006 for Whiziblesem 6.0 SP 7.2 issue ID
        ''CType(m_dtToDate1, Date).ToString
        ''str_ToDate
        'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_dtToDate, , "frmPM_TaskEasyEdit", returnHTML:=True, ISmandatory:=False))
        'CommonFunctions.General.WriteHTML("<IMG id=StarIDTo name=idStarIDTo display='none' src='../../Images/Star.gif' border=0>")
        'CommonFunctions.General.WriteHTML("</Span>")
        'CommonFunctions.General.WriteHTML("</td>")
        ''CommonFunctions.General.WriteHTML("</tr><tr class='clsTREven'><td colspan=3>")
        ''CommonFunctions.General.WriteHTML("</td>")

        ''--- Display the Show Link
        ''Display the Show Link
        'CommonFunctions.General.WriteHTML("<td align=center 'Style = Width = 50%'>")
        'objDynamicLink = New WebPages.UI.cDynamicLink
        'objDynamicLink.LinkName = "Show"
        'objDynamicLink.Tooltip = "Show"
        'objDynamicLink.FunctionName = "Show_OnClick()"
        'objDynamicLink.ReturnHTML = True
        'CommonFunctions.General.WriteHTML(" |<B>" + objDynamicLink.GetDynamicLink() + "</B>| ")
        'objDynamicLink = Nothing
        'CommonFunctions.General.WriteHTML("</td></tr></table>")

        'CommonFunctions.General.WriteHTML("</DIV>")

        'CommonFunctions.General.WriteHTML("<BR>")

    End Sub

    Private Sub DrawPageCaption()
        Dim IsFreezed As Boolean
        Dim ReadyToAuthenticate As String
        Dim Authenticated As String
        Dim ID As String = ""

    End Sub

    Private Sub SaveData()
        Dim updateSQL As String
        Dim strPK() As String
        Dim strField As String


        If strTaskID <> "" Then


            'If strTaskID.ToUpper.StartsWith("CTRPLANNED") Then
            '    strField = strTaskID.Substring(11, strTaskID.Length - 11)
            'ElseIf strTaskID.ToUpper.StartsWith("CTRSTARTDATE") Then
            '    strField = strTaskID.Substring(13, strTaskID.Length - 13)
            'ElseIf strTaskID.ToUpper.StartsWith("CTRENDDATE") Then
            '    strField = strTaskID.Substring(11, strTaskID.Length - 11)
            'End If

            Dim Ctrlindex As Integer
            Dim CharIndex As Integer

            If InStr(strTaskID.ToUpper, "CTRPLANNED") > 0 Then
                strField = strTaskID.Substring(11, strTaskID.Length - 11)
            ElseIf InStr(strTaskID.ToUpper, "CTRSTARTDATE") > 0 Then
                strField = strTaskID.Substring(26, strTaskID.Length - 26)
            ElseIf InStr(strTaskID.ToUpper, "CTRENDDATE") > 0 Then
                strField = strTaskID.Substring(24, strTaskID.Length - 24)
            End If

            strPK = strField.Split(CType("_", Char))

            updateSQL = "EXEC usp_Upd_PM_TaskAssignment_EasyEdit " + strPK(0)

            'Select Case strField.ToUpper
            If InStr(strTaskID.ToUpper, "CTRSTARTDATE") > 0 Then
                'If strTaskID.ToUpper.StartsWith("CTRSTARTDATE") Then
                If Request.QueryString("Value") <> "" Then
                    updateSQL += ", '" + Request.QueryString("Value") + "'"
                End If
            ElseIf InStr(strTaskID.ToUpper, "CTRENDDATE") > 0 Then
                ' ElseIf strTaskID.ToUpper.StartsWith("CTRENDDATE") Then
                updateSQL += ", NULL, '" + Request.QueryString("Value") + "' "
            ElseIf InStr(strTaskID.ToUpper, "CTRPLANNED") > 0 Then
                'ElseIf strTaskID.ToUpper.StartsWith("CTRPLANNED") Then
                updateSQL += ", NULL, NULL, " + Request.QueryString("Value")
            End If

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("UpdateBaseline")) <> "" Then
                updateSQL += " "
                'If strTaskID.ToUpper.StartsWith("CTRSTARTDATE") Then
                '    updateSQL += ", '" + Request.QueryString("Value") + "'"
                'ElseIf strTaskID.ToUpper.StartsWith("CTRENDDATE") Then
                '    updateSQL += ", NULL, '" + Request.QueryString("Value") + "' "
                'ElseIf strTaskID.ToUpper.StartsWith("CTRPLANNED") Then
                '    updateSQL += ", NULL, NULL, " + Request.QueryString("Value")
                'End If
                If InStr(strTaskID.ToUpper, "CTRSTARTDATE") > 0 Then
                    'If strTaskID.ToUpper.StartsWith("CTRSTARTDATE") Then
                    If Request.QueryString("Value") <> "" Then
                        updateSQL += ", '" + Request.QueryString("Value") + "'"
                    End If
                ElseIf InStr(strTaskID.ToUpper, "CTRENDDATE") > 0 Then
                    ' ElseIf strTaskID.ToUpper.StartsWith("CTRENDDATE") Then
                    updateSQL += ", NULL, '" + Request.QueryString("Value") + "' "
                ElseIf InStr(strTaskID.ToUpper, "CTRPLANNED") > 0 Then
                    'ElseIf strTaskID.ToUpper.StartsWith("CTRPLANNED") Then
                    updateSQL += ", NULL, NULL, " + Request.QueryString("Value")
                End If

            End If

            Try
                CommonFunction.Data.InsertOrUpdateData(updateSQL, MyBase.UseSQL)
            Catch ex As Exception

            Finally
                Response.Clear()
                Response.End()
            End Try

        End If

    End Sub

    Private Function DrawMenu(ByVal location As String) As String
        'Dim ArrTopMenuCaptionsList As New System.Collections.ArrayList
        'Dim ArrTopMenuToolTipsList As New System.Collections.ArrayList
        'Dim ArrTopMenuFunctionsList As New System.Collections.ArrayList

        'ArrTopMenuCaptionsList.Add("Save")
        'ArrTopMenuToolTipsList.Add("Save")
        'ArrTopMenuFunctionsList.Add("Save_OnClick()")

        'ArrTopMenuCaptionsList.Add("Previous Week")
        'ArrTopMenuToolTipsList.Add("Previous Week")
        'ArrTopMenuFunctionsList.Add("PreviousWeek_OnClick()")



        Response.Write("<Table class=clsTable cellspacing=0 cellpadding=0 width='100%'><TR class='clsTRPageCaption'>")
        If location = "TOP" Then
            Response.Write("<TD align=left>Task Edit</TD>")
        End If
        'Response.Write("<TD align=Right>|<b><a class='Menu' href='javascript:Save_OnClick()'>Save</a></b>|")
        Response.Write("<TD align=Right>")
        Response.Write("<b><a class='Menu' href='javascript:Save_OnClick()' title='Save'>|Save</a><b>|")

        Response.Write("<b><a class='Menu' href='javascript:PreviousWeek_OnClick()' title='Previous Week'>|Previous Week</a><b>|")
        Response.Write("<b><a class='Menu' href='javascript:NextWeek_OnClick()' title='Next Week'>Next Week</a><b>|")
        'Response.Write("<b><a class='Menu' href='javascript:Help_OnClick('" + TaskEdit + "')' title='Help'>?</a><b>|")
        Response.Write("<b><a class='Menu' href='javascript:Help_OnClick(""" + TaskEdit + """)' title='Help'>?</a><b>|")


        Response.Write("</TD>")
        Response.Write("</TR></TABLE>" & vbCrLf)

        'ArrTopMenuCaptionsList.Add("Next Week")
        'ArrTopMenuToolTipsList.Add("Next Week")
        'ArrTopMenuFunctionsList.Add("NextWeek_OnClick()")

        'Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        'Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        'Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String

        'ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        'ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        'ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)

        'strMenu = objMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)

    End Function

    'Added By ShraddhaM on 22 Aug 2006
    Protected Function CheckLeaves(ByVal lngEmployeeID As Long, ByVal strStartDate As String, _
              ByVal strEndDate As String) As String
        '====================================================================
        ' Procedure Name       : CheckLeaves
        ' Parameters Passed    : EmployeeId - The Resources unique id
        '                       strStartDate - The Tasks Start date
        '                       strEndDate - The Tasks End date
        ' Returns              : The Name of the Employee if there is leave in between the start date and end date
        ' Parameters Affected  : None
        ' Purpose              : This function checks whether there is any leave in between the task start date 
        '                        and end date of the resource.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : ShraddhaM
        ' Created              : August 22, 2006
        ' Revisions            : 
        '=====================================================================

        Dim strReturn As String = ""
        Dim strQuery As String = ""

        Dim drLeave As IDataReader
        Dim strTemp As String = ""
        Dim strWFHDays As String = ""
        Dim strLeaveMessage As String = ""
        Dim strWFHMessage As String = ""
        'Dim dtStartDate As DateTime = CDate(strStartDate)
        'Dim dtEndDate As DateTime = CDate(strEndDate)

        MyBase.InitializeResources("AppResources.PM_TaskAssignment", "AppResources")
        ''End Added by ManishK on 6th Feb 2006 for WFH Issue 
        strQuery = "Exec usp_Sel_tbl_PM_EmployeeLeaveDetails_ForGivenDates " & m_intEmployeeID.ToString()
        'strQuery &= ", '" & dtStartDate.ToString("g") & "'"
        strQuery &= ", '" & strStartDate & "'"
        'strQuery &= ", '" & dtEndDate.ToString("g") & "'"
        strQuery &= ", '" & strEndDate & "'"
        ''Added by ManishK on 6th Feb 2006 for WFH Issue 
        drLeave = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While drLeave.Read
            strEmployeeName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("EmployeeName"), ""), "")
            If strEmployeeName <> "" Then
                strLeaveDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("LeaveDays"), ""), "")
                strWFHDays = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(drLeave("WFHDays"), ""), "")
                If strLeaveDays <> "" Then
                    strLeaveMessage = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_LEAVES") + " " + strLeaveDays.Remove(0, 1) + " "
                End If
                If strWFHDays <> "" Then
                    strWFHMessage = strEmployeeName + " " + MyBase.GetResourceString("CONFIRM_WFH") + " " + strWFHDays.Remove(0, 1)
                End If
                strTemp = strLeaveMessage + " <==> " + strWFHMessage
            End If
        End While
        CommonFunctions.Data.DisposeDataReader(drLeave)
        strReturn = strTemp
        'strReturn = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), "")
        Return strReturn

    End Function


    Protected Sub XMLHTTP_GetLeaves()
        'ShraddhaM 22 Aug 2006
        Dim StartDate As String
        Dim EndDate As String
        Dim EmpID As String
        Dim strEmployeeNames As String
        Dim strLeaveMessage As String
        StartDate = Request.QueryString("startDate")
        EndDate = Request.QueryString("endDate")
        EmpID = Request.QueryString("EmployeeID")
        Dim strTempName As String
        strTempName = CheckLeaves(CType(EmpID, Long), StartDate, EndDate)
        If strTempName <> "" Then
            strEmployeeNames &= strTempName + "<==>"


            'Check if there is any leave(s) between the start date and end date
            'strTempName = CheckLeaves(CType(arrEmpId(intCtr), Long), strCurrentStartDate, strCurrentEndDate)
            If strTempName <> "" Then strEmployeeNames &= strTempName + "<==>"
            'End If

            strLeaveMessage = strEmployeeNames

            'Check if there is any leave(s) between the start date and end date
            'strTempName = CheckLeaves(CType(strEmployeeId, Long), strCurrentStartDate, strCurrentEndDate)
            strLeaveMessage = strTempName
            'End If
            ' End If
            Response.Clear()
            Response.Write(strLeaveMessage)
        End If

    End Sub
    'Endded By ShraddhaM on 22 Aug 2006
End Class
