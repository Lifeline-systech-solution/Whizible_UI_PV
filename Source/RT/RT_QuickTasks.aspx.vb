Imports System.Globalization

Public Class RT_QuickTasks
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected intProjectCase As Integer
    Protected intRowCount As Integer
    Protected strAction As String
    Protected dblMinHoursForDAEntry As Double
    Protected m_RestrictDurationChange_O As Integer = 0
    Protected m_RestrictDurationChange_M As Integer = 0
    Protected intAssignedTaskRows As Integer = 0
    Protected dblTotalWork As Double = 0
    Protected dblTodaysTotalWork As Double = 0
    Protected strClass As String = "clsTREven"
    Protected m_strDate As String
    Private m_objDTFI As New DateTimeFormatInfo
    Protected m_IsTimesheetBlocked As Integer = 0
    Protected m_UserID As String
    Protected m_strTaskValidationMessage = ""
    Protected m_strFirstTaskValidationMessage As String = ""
    Protected m_dblTotalAllocatedTaskLCE As Double = 0

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
    End Sub

    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : Calls the private class ReportUI to generate the
        '                         UI for the report
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 4,2007
        ' Revisions             :
        '=====================================================================
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        Dim strSQL As String

        m_UserID = HttpContext.Current.Session("intUserID").ToString

        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'strSQL = "Select MinHoursForDAEntry From tbl_PM_CompanyInformation WITH (NOLOCK) "
        strSQL = " usp_sel_tbl_PM_CompanyInformation_MinHoursForDAEntry "
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query

        dblMinHoursForDAEntry = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Double)

        strSQL = "Select Case IsNull(RestrictDurationChange_O, 0) When 0 Then 0 Else 1 End from tbl_PM_CompanyInformation WITH (NOLOCK) "
        m_RestrictDurationChange_O = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Integer)

        strSQL = "Select Case IsNull(RestrictDurationChange_M, 0) When 0 Then 0 Else 1 End from tbl_PM_CompanyInformation WITH (NOLOCK)"
        m_RestrictDurationChange_M = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Integer)


        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("Today"), "").ToString <> "" Then
            m_strDate = HttpContext.Current.Request("Today").ToString
        Else
            m_strDate = Date.Today.ToString("dd-MMM-yyyy")
        End If

        'Added to check Timesheet blocking
        strSQL = "Exec usp_sel_IsTimesheetBlocked '" + m_strDate + "'"
        m_IsTimesheetBlocked = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Integer)

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeleteMode")).ToUpper.ToString = "DELETETHISTASK" Then
            Call DeleteTask(HttpContext.Current.Request.QueryString("SelectedTaskID"))
        End If
        'Added by GokulP on 07 Oct 2009 for IssueID : 33612
        Dim sbProject As New System.Text.StringBuilder
        Dim drProjectOUworkHrs As IDataReader
        Dim drProjectOUList As IDataReader
        Dim strProjectOUWorkHrsSQL As String = ""
        Dim intCount As Integer = 0
        'Modified by vidyak for whiziblesem9 sp1 on 06 Jul 2010 
        Dim intProjectOUWorkingHrsForQuicktask As Double = 0
        'Dim intProjectOUWorkingHrsForQuicktask As Integer = 0
        'End Modified by vidyak for whiziblesem9 sp1 on 06 Jul 2010 
        Dim intProjectID As Integer = 0
        Dim strProject As String = ""
        Dim strProjectOUListSQL As String = ""

        strProjectOUListSQL = "Exec usp_Sel_ListOfProject_QuickTask '" + HttpContext.Current.Session("intUserID").ToString + "','" + m_strDate + "'"

        drProjectOUList = CommonFunction.Data.GetDataReader(strProjectOUListSQL, True)
        sbProject.Append("<SCRIPT language='javascript'>" + vbCrLf)
        sbProject.Append("var ProjectDetails = new Array();" + vbCrLf)

        While drProjectOUList.Read
            intProjectOUWorkingHrsForQuicktask = 0
            intProjectID = CType(drProjectOUList("ProjectID"), Integer)

            sbProject.Append("ProjectDetails[" & intCount.ToString() & "] = new Array(3);" + vbCrLf)

            strProjectOUWorkHrsSQL = "Exec Usp_Get_ProjectCase '" + intProjectID.ToString + "'"
            strProjectOUWorkHrsSQL += ",'" + m_strDate + "'"

            drProjectOUworkHrs = CommonFunction.Data.GetDataReader(strProjectOUWorkHrsSQL, True)
            If drProjectOUworkHrs.Read Then

                strProject = CType(drProjectOUworkHrs("ProjectName"), String)
                strProject = Replace(strProject, "'", "\'")
                intProjectOUWorkingHrsForQuicktask = CType(CommonFunction.Data.CheckIsDBNull(drProjectOUworkHrs("ProjectOUWorkingHrsForQuicktask"), "0"), Double)

                sbProject.Append("ProjectDetails[" & intCount.ToString() & "][0] = " & intProjectID.ToString() & ";" & vbCrLf)
                sbProject.Append("ProjectDetails[" & intCount.ToString() & "][1] = '" & strProject & "';" & vbCrLf)
                sbProject.Append("ProjectDetails[" & intCount.ToString() & "][2] = " & intProjectOUWorkingHrsForQuicktask.ToString() & ";" & vbCrLf)
            End If
            intCount += 1
        End While

        sbProject.Append("</SCRIPT>" + vbCrLf)
        CommonFunction.General.WriteHTML(sbProject.ToString)
        sbProject = Nothing
        CommonFunction.Data.DisposeDataReader(drProjectOUworkHrs)
        CommonFunction.Data.DisposeDataReader(drProjectOUList)
        'End of Addition by GokulP on 07 Oct 2009 for IssueID : 33612

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromXML")) = "1" Then
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeleteTask")) <> "" Then
                Call DeleteTask(HttpContext.Current.Request.QueryString("DeleteTask"))
            ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action")).ToUpper = "TASKTYPE" Then
                Call InitialiseSubTasks()
            ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowQTask")) = "1" Then
                Call EditQuickTask()
            ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action")).ToUpper = "PROJECT" Then
                InitialiseProject()
            Else
                Call InitialiseTaks()
            End If
            Exit Sub
        Else
            If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SAVE" Then
                PerformAction()
            End If
            If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SUBMIT" Then
                SubmitTask()
            End If

            If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "PLANWORK" Then
                PlanTodaysWork()
            End If

            Call EditQuickTask()

        End If
    End Sub

    Protected Sub PlanTodaysWork()
        '=====================================================================
        ' Procedure Name        : PlanTodaysWork()
        ' Purpose               : To Save/plan Todays work for the Quick and planned Tasks
        ' Description           : Same as above.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 7,2007
        ' Revisions             :
        '=====================================================================
        Dim intRows, intATCount, intCount As Integer
        Dim strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID As String
        Dim strSQL As String
        intRows = CType(HttpContext.Current.Request.QueryString("Rows"), Integer)
        Dim strPriority As String
        Dim strSQLTaskValidation As String = ""
        Dim drTaskValidation As IDataReader

        Dim strTaskAlert As New System.Text.StringBuilder

        If intRows = 0 Then
            intRows = CType(HttpContext.Current.Request.Form("RowNumber"), Integer)
        End If

        intATCount = CType(HttpContext.Current.Request.QueryString("AssignedTasks"), Integer)

        strWork = ""
        ''Planned Assigned Task validation
        For intCount = 1 To intATCount
            strWork = Request.Form("Work_" + intCount.ToString)
            strUniqueID = Request.Form("UniqueID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("SubTaskTypeID_" + intCount.ToString)

            If strSubTaskTypeID = "" Then
                strSubTaskTypeID = "NULL"
            End If

            If strWork <> "" And m_strTaskValidationMessage.ToString.Trim = "" Then

                strSQLTaskValidation = "Exec usp_Sel_IsValidQuickTask '" + HttpContext.Current.Session("intUserID").ToString + "',NULL,NULL," + strSubTaskTypeID.ToString + ",NULL,'" + strWork + "'"
                If strUniqueID <> "" Then
                    strSQLTaskValidation += ",'" + strUniqueID + "'"
                Else
                    strSQLTaskValidation += ",NULL"
                End If
                strSQLTaskValidation += ",'" + m_strDate + "',NULL,1,'AssignTask'"
                
                ' strSQLTaskValidation = "Exec usp_Sel_IsValidQuickTask " + strUniqueID + ",'" + HttpContext.Current.Session("intUserID").ToString + "','" + m_strDate.ToString + "'," + strWork.ToString + ",1"
                drTaskValidation = CommonFunction.Data.GetDataReader(strSQLTaskValidation, True)
                While drTaskValidation.Read
                    m_strTaskValidationMessage = CType(CommonFunction.Data.CheckIsDBNull(drTaskValidation("Message"), ""), String)
                    If m_strFirstTaskValidationMessage = "" And m_strTaskValidationMessage <> "" Then
                        m_strFirstTaskValidationMessage = m_strTaskValidationMessage
                    End If
                End While
                drTaskValidation.Close()
                drTaskValidation.Dispose()
                strWork = ""
            End If
            strSubTaskTypeID = ""
        Next

       
        ''Saved Plan Todays DA For Assigned Tasks 
        If m_strTaskValidationMessage.ToString.Trim = "" Then
            strWork = ""
            For intCount = 1 To intATCount
                strWork = Request.Form("Work_" + intCount.ToString)
                strUniqueID = Request.Form("UniqueID_" + intCount.ToString)
                If strWork <> "" Then
                    PlanTodaysDAForAssignedTasks(strUniqueID, strWork)
                    strWork = ""
                ElseIf strUniqueID <> "" Then
                    'Added for to delete Temporary planned work
                    strSQL = "Exec usp_Del_tbl_PM_DayPlanning " + strUniqueID + "," + HttpContext.Current.Session("intUserID").ToString
                    strSQL += ",'" + m_strDate + "'"
                    CommonFunction.Data.InsertOrUpdateData(strSQL, True)
                    'End of Addition to delete Temporary planned work
                End If
            Next
        End If

        ''Save the task --- Not Planned from Quick Task 
        Dim strSQLNoPlannedTask As String

        ''Quick Task validation
        For intCount = intATCount + 1 To intRows - 1
            strProjectID = Request.Form("ProjectID_" + intCount.ToString)
            strTaskTypeID = Request.Form("TaskTypeID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("SubTaskTypeID_" + intCount.ToString)
            strDescription = Request.Form("Description_" + intCount.ToString)
            strWork = Request.Form("Work_" + intCount.ToString)
            strUniqueID = Request.Form("UniqueID_" + intCount.ToString)
            strPriority = Request.Form("Priority_" + intCount.ToString)
            If strProjectID <> "" And Not strProjectID Is Nothing Then

                strSQLTaskValidation = "Exec usp_Sel_IsValidQuickTask '" + HttpContext.Current.Session("intUserID").ToString + "','" + strProjectID + "','"
                strSQLTaskValidation += strTaskTypeID + "','" + strSubTaskTypeID + "','" + CommonFunction.General.BuildQueryString(strDescription).ToString + "','" + strWork + "'"
                If strUniqueID <> "" Then
                    strSQLTaskValidation += ",'" + strUniqueID + "'"
                Else
                    strSQLTaskValidation += ",NULL"
                End If

                strSQLTaskValidation += ",'" + m_strDate + "'"
                strSQLTaskValidation += ",'" + strPriority + "',1,'QuickTask'"

                drTaskValidation = CommonFunction.Data.GetDataReader(strSQLTaskValidation, True)
                While drTaskValidation.Read
                    m_strTaskValidationMessage = CType(CommonFunction.Data.CheckIsDBNull(drTaskValidation("Message"), ""), String)
                    If m_strFirstTaskValidationMessage = "" And m_strTaskValidationMessage <> "" Then
                        m_strFirstTaskValidationMessage = m_strTaskValidationMessage
                    End If
                End While

                drTaskValidation.Close()
                drTaskValidation.Dispose()

                If m_strTaskValidationMessage.ToString <> "" Then
                    strSQLNoPlannedTask = "Exec Usp_Ins_Upd_tbl_PM_QuickTasks '" + HttpContext.Current.Session("intUserID").ToString + "','" + strProjectID + "','"
                    strSQLNoPlannedTask += strTaskTypeID + "','" + strSubTaskTypeID + "','" + CommonFunction.General.BuildQueryString(strDescription).ToString + "','" + strWork + "'"
                    If strUniqueID <> "" Then
                        strSQLNoPlannedTask += ",'" + strUniqueID + "'"
                    Else
                        strSQLNoPlannedTask += ",NULL"
                    End If
                    strSQLNoPlannedTask += ",'" + m_strDate + "'"
                    strSQLNoPlannedTask += ",'" + strPriority + "',0"
                    CommonFunction.Data.InsertOrUpdateData(strSQLNoPlannedTask, True)
                Else
                    CreateQuickTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID, strPriority)
                End If

            End If
        Next
    End Sub

    Protected Sub PlanTodaysDAForAssignedTasks(ByVal UniqueID As String, ByVal Work As String)
        Dim strSQL As String
        strSQL = "Exec usp_Ins_Upd_tbl_PM_DayPlanning " + UniqueID + "," + HttpContext.Current.Session("intUserID").ToString
        strSQL += ",'" + m_strDate + "','" + Work + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub

    Protected Sub PerformAction()
        Dim intRows, intCount As Integer
        Dim strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID As String

        strProjectID = Request.Form("ProjectID")
        strTaskTypeID = Request.Form("TaskTypeID")
        strSubTaskTypeID = Request.Form("SubTaskTypeID")
        strDescription = Request.Form("Description")
        strWork = Request.Form("Work")
        strUniqueID = Request.Form("UniqueID")


        If strUniqueID = "0" Then
            strUniqueID = ""
        End If
        Dim strPriority As String
        strPriority = Request.Form("Priority")

        CreateQuickTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID, strPriority)

    End Sub

    Protected Sub SubmitTask()
        '=====================================================================
        ' Procedure Name        : SubmitTask()
        ' Purpose               : To create Tasks and fill DA for the Quick Tasks
        ' Description           : Same as above.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 7,2007
        ' Revisions             :
        '=====================================================================
        Dim intRows, intATCount, intCount As Integer
        Dim strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID As String
        Dim strSQLTaskValidation As String = ""
        Dim drTaskValidation As IDataReader
        Dim strPriority As String = ""
        Dim strSQLNoPlannedTask As String

        intRows = CType(HttpContext.Current.Request.QueryString("Rows"), Integer)
        intATCount = CType(HttpContext.Current.Request.QueryString("AssignedTasks"), Integer)

        If intRows = 0 Then
            intRows = CType(HttpContext.Current.Request.Form("RowNumber"), Integer)
        End If

        strWork = ""
        ''Planned Assigned Task validation
        For intCount = 1 To intATCount
            strProjectID = Request.Form("ATProjectID_" + intCount.ToString)
            strTaskTypeID = Request.Form("ATTaskTypeID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("ATSubTaskTypeID_" + intCount.ToString)
            strWork = Request.Form("Work_" + intCount.ToString)
            strUniqueID = Request.Form("UniqueID_" + intCount.ToString)

            If strSubTaskTypeID = "" Then
                strSubTaskTypeID = "NULL"
            End If

            If strWork <> "" And m_strTaskValidationMessage.ToString.Trim = "" Then

                strSQLTaskValidation = "Exec usp_Sel_IsValidQuickTask '" + HttpContext.Current.Session("intUserID").ToString + "',NULL,NULL," + strSubTaskTypeID.ToString + ",NULL,'" + strWork + "'"
                If strUniqueID <> "" Then
                    strSQLTaskValidation += ",'" + strUniqueID + "'"
                Else
                    strSQLTaskValidation += ",NULL"
                End If
                strSQLTaskValidation += ",'" + m_strDate + "',NULL,1,'AssignTask'"

                ' strSQLTaskValidation = "Exec usp_Sel_IsValidQuickTask " + strUniqueID + ",'" + HttpContext.Current.Session("intUserID").ToString + "','" + m_strDate.ToString + "'," + strWork.ToString + ",1"
                drTaskValidation = CommonFunction.Data.GetDataReader(strSQLTaskValidation, True)
                While drTaskValidation.Read
                    m_strTaskValidationMessage = CType(CommonFunction.Data.CheckIsDBNull(drTaskValidation("Message"), ""), String)
                    If m_strFirstTaskValidationMessage = "" And m_strTaskValidationMessage <> "" Then
                        m_strFirstTaskValidationMessage = m_strTaskValidationMessage
                    End If

                    If strWork <> "" And m_strTaskValidationMessage = "" Then
                        FillDAForAssignedTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strWork, strUniqueID)
                        strWork = ""
                    End If

                End While
                drTaskValidation.Close()
                drTaskValidation.Dispose()

                strWork = ""
            End If
            strSubTaskTypeID = ""
        Next

        For intCount = intATCount + 1 To intRows - 1
            strProjectID = Request.Form("ProjectID_" + intCount.ToString)
            strTaskTypeID = Request.Form("TaskTypeID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("SubTaskTypeID_" + intCount.ToString)
            strDescription = Request.Form("Description_" + intCount.ToString)
            strWork = Request.Form("Work_" + intCount.ToString)
            strUniqueID = Request.Form("UniqueID_" + intCount.ToString)
            strPriority = Request.Form("Priority_" + intCount.ToString)
            If strWork <> "" Then

                strSQLTaskValidation = "Exec usp_Sel_IsValidQuickTask '" + HttpContext.Current.Session("intUserID").ToString + "','" + strProjectID + "','"
                strSQLTaskValidation += strTaskTypeID + "','" + strSubTaskTypeID + "','" + CommonFunction.General.BuildQueryString(strDescription).ToString + "','" + strWork + "'"
                If strUniqueID <> "" Then
                    strSQLTaskValidation += ",'" + strUniqueID + "'"
                Else
                    strSQLTaskValidation += ",NULL"
                End If

                strSQLTaskValidation += ",'" + m_strDate + "'"
                strSQLTaskValidation += ",'" + strPriority + "',1,'QuickTask'"

                drTaskValidation = CommonFunction.Data.GetDataReader(strSQLTaskValidation, True)
                While drTaskValidation.Read
                    m_strTaskValidationMessage = CType(CommonFunction.Data.CheckIsDBNull(drTaskValidation("Message"), ""), String)
                    If m_strFirstTaskValidationMessage = "" And m_strTaskValidationMessage <> "" Then
                        m_strFirstTaskValidationMessage = m_strTaskValidationMessage
                    End If
                End While

                drTaskValidation.Close()
                drTaskValidation.Dispose()

                If m_strTaskValidationMessage.ToString <> "" Then
                    strSQLNoPlannedTask = "Exec Usp_Ins_Upd_tbl_PM_QuickTasks '" + HttpContext.Current.Session("intUserID").ToString + "','" + strProjectID + "','"
                    strSQLNoPlannedTask += strTaskTypeID + "','" + strSubTaskTypeID + "','" + CommonFunction.General.BuildQueryString(strDescription).ToString + "','" + strWork + "'"
                    If strUniqueID <> "" Then
                        strSQLNoPlannedTask += ",'" + strUniqueID + "'"
                    Else
                        strSQLNoPlannedTask += ",NULL"
                    End If
                    strSQLNoPlannedTask += ",'" + m_strDate + "'"
                    strSQLNoPlannedTask += ",'" + strPriority + "',0"
                    CommonFunction.Data.InsertOrUpdateData(strSQLNoPlannedTask, True)
                Else
                    CreateAssignedTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID, strPriority)
                End If
                strWork = ""
            End If
        Next
    End Sub

    Protected Sub FillDAForAssignedTasks(ByVal ProjectID As String, ByVal TaskTypeID As String, ByVal SubTaskTypeID As String, ByVal Work As String, ByVal UniqueID As String)
        Dim strSQL As String

        strSQL = "Exec usp_Ins_tbl_PM_DailyActivity NULL, '" + UniqueID + "','" + ProjectID + "','" + HttpContext.Current.Session("intUserID").ToString + "'"
        strSQL += ",'" + HttpContext.Current.Session("intPostID").ToString + "','" + m_strDate + "','" + Work + "',NULL"
        strSQL += ",'" + TaskTypeID + "','" + SubTaskTypeID + "',Null, 0,100.00,0,null,'N'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)

        'Added for to delete Temporary planned work
        strSQL = "Exec usp_Del_tbl_PM_DayPlanning " + UniqueID + "," + HttpContext.Current.Session("intUserID").ToString
        strSQL += ",'" + m_strDate + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        'End of Addition to delete Temporary planned work

    End Sub

    Protected Sub CreateQuickTasks(ByVal ProjectID As String, ByVal TaskTypeID As String, ByVal SubTaskTypeID As String, ByVal Description As String, ByVal Work As String, ByVal UniqueID As String, ByVal Priority As String)
        Dim strSQL As String
        strSQL = "Exec Usp_Ins_Upd_tbl_PM_QuickTasks '" + HttpContext.Current.Session("intUserID").ToString + "','" + ProjectID + "','"
        strSQL += TaskTypeID + "','" + SubTaskTypeID + "','" + CommonFunction.General.BuildQueryString(Description).ToString + "','" + Work + "'"
        If UniqueID <> "" Then
            strSQL += ",'" + UniqueID + "'"
        Else
            strSQL += ",Null"
        End If
        strSQL += ",'" + m_strDate + "'"
        strSQL += ",'" + Priority + "',1,1"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub

    Protected Sub CreateAssignedTasks(ByVal ProjectID As String, ByVal TaskTypeID As String, ByVal SubTaskTypeID As String, ByVal Description As String, ByVal Work As String, ByVal UniqueID As String, ByVal Priority As String)
        '=====================================================================
        ' Procedure Name        : CreateAssignedTasks()
        ' Purpose               : To create Tasks and fill DA for the Quick Tasks
        ' Description           : Same as above.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 7,2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        strSQL = "Exec usp_Ins_tbl_PM_ProjectAssignedTasks_From_QuickTasks '" + HttpContext.Current.Session("intUserID").ToString + "',"
        strSQL += "'" + ProjectID + "','" + CommonFunction.General.BuildQueryString(Description).ToString + "','" + Work + "','" + TaskTypeID + "','" + SubTaskTypeID + "','"
        strSQL += HttpContext.Current.Session("strUserName").ToString + "','" + UniqueID + "'"
        strSQL += ",'" + m_strDate + "'"
        strSQL += ",'" + CommonFunction.General.BuildQueryString(Priority) + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub

    Protected Sub DeleteTask(ByVal TaskID As String)
        Dim strSQL As String
        strSQL = "Delete From tbl_PM_QuickTask Where TaskID = '" + TaskID + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub

    Protected Sub InitialiseProject()
        '=====================================================================
        ' Procedure Name        : InitialiseProject()
        ' Purpose               : To get accessible project for loged in person when page is called from XML object
        ' Description           : Same as above.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : RohiniK 
        ' Created               : 15 Jun 09
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim sbProject As New System.Text.StringBuilder
        Dim intCount As Integer = 0
        Dim intProjectID As Integer

        Dim strProject As String
        Dim drProject, drTaskSubTasks As IDataReader
        Dim strRowNumber As String = ""

        strSQL = "Exec usp_Sel_ListOfProject_QuickTask '" + HttpContext.Current.Session("intUserID").ToString + "','" + m_strDate + "'"
        drProject = CommonFunction.Data.GetDataReader(strSQL, True)
        While drProject.Read
            intProjectID = CType(CommonFunction.Data.CheckIsDBNull(drProject("ProjectID"), "0"), Integer)
            strProject = CommonFunction.Data.CheckIsDBNull(drProject("Project")).ToString
            strProject = Replace(strProject, "'", "\'")
            sbProject.Append(intProjectID.ToString + "|" + strProject + "|")
            intCount += 1

        End While

        HttpContext.Current.Response.Clear()
        If Not sbProject Is Nothing Then
            HttpContext.Current.Response.Write(sbProject.ToString)
        Else
            HttpContext.Current.Response.Write("null")
        End If

        HttpContext.Current.Response.End()
        sbProject = Nothing

        CommonFunction.Data.DisposeDataReader(drProject)

    End Sub

    Public Sub InitialiseTaks()
        '=====================================================================
        ' Procedure Name        : InitialiseTaks()
        ' Purpose               : To get Tasks of selected project when page is called from XML object
        ' Description           : Same as above.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 6,2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim sbTaskType As New System.Text.StringBuilder

        Dim intCount As Integer = 0
        Dim intProjectID As Integer

        Dim intTaskTypeID, intSubTaskTypeID As Integer
        Dim strTaskType, strSubTaskType As String
        Dim drTasks As IDataReader
        Dim strRowNumber As String = ""

        Dim IsTaskCreationAllowed As Integer = 0

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "") <> "" Then
            If HttpContext.Current.Request("ProjectID").ToString <> "" Then
                intProjectID = CType(HttpContext.Current.Request("ProjectID"), Integer)
            Else
                intProjectID = 0
            End If
        Else
            intProjectID = 0
        End If

        strSQL = "Exec usp_Get_TaskCreationAccess '" + HttpContext.Current.Session("intUserID").ToString + "','" + intProjectID.ToString + "'"
        IsTaskCreationAllowed = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Integer)

        If intProjectID <> 0 And IsTaskCreationAllowed = 1 Then
            strSQL = "Exec Usp_Sel_TaskType_QuickTask '" + intProjectID.ToString + "'"
            drTasks = CommonFunction.Data.GetDataReader(strSQL, True)
            While drTasks.Read
                intTaskTypeID = CType(CommonFunction.Data.CheckIsDBNull(drTasks("TaskTypeID"), "0"), Integer)
                strTaskType = CommonFunction.Data.CheckIsDBNull(drTasks("TaskType")).ToString
                strTaskType = Replace(strTaskType, "'", "\'")
                sbTaskType.Append(intTaskTypeID.ToString + "|" + strTaskType + "|")
                intCount += 1
            End While
        End If

        HttpContext.Current.Response.Clear()
        If IsTaskCreationAllowed = 1 Then
            If Not sbTaskType Is Nothing Then
                HttpContext.Current.Response.Write(sbTaskType.ToString)
            Else
                HttpContext.Current.Response.Write("null")
            End If
        Else
            HttpContext.Current.Response.Write("NO_ACCESS")
        End If

        HttpContext.Current.Response.End()
        sbTaskType = Nothing

        CommonFunction.Data.DisposeDataReader(drTasks)

    End Sub

    Protected Sub InitialiseSubTasks()
        '=====================================================================
        ' Procedure Name        : InitialiseTaks()
        ' Purpose               : To get Tasks of selected project when page is called from XML object
        ' Description           : Same as above.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 6,2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim sbSubTaskType As New System.Text.StringBuilder
        Dim intCount As Integer = 0
        Dim intProjectID As Integer

        Dim intTaskTypeID, intSubTaskTypeID As Integer
        Dim strTaskType, strSubTaskType As String
        Dim drSubTask, drSubTaskubTasks As IDataReader
        Dim strRowNumber As String = ""

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "") <> "" Then
            If HttpContext.Current.Request("ProjectID").ToString <> "" Then
                intProjectID = CType(HttpContext.Current.Request("ProjectID"), Integer)
            Else
                intProjectID = 0
            End If
        Else
            intProjectID = 0
        End If
        strSQL = "usp_Sel_SubTasks_QuickTask '" + intProjectID.ToString + "'"
        drSubTaskubTasks = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While drSubTaskubTasks.Read()
            intTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskubTasks.Item("TaskTypeID"), "0"), Integer)
            intSubTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drSubTaskubTasks.Item("SubTaskTypeID"), "0"), Integer)
            strSubTaskType = CommonFunctions.General.CheckIsNothing(drSubTaskubTasks.Item("SubTaskType"), "")
            strSubTaskType = Replace(strSubTaskType, "'", "\'")
            sbSubTaskType.Append(intTaskTypeID.ToString + "|" + intSubTaskTypeID.ToString + "|" + strSubTaskType + "|")
            intCount = intCount + 1
        End While

        HttpContext.Current.Response.Clear()

        If Not sbSubTaskType Is Nothing Then
            HttpContext.Current.Response.Write(sbSubTaskType.ToString)
        Else
            HttpContext.Current.Response.Write("null")
        End If
        HttpContext.Current.Response.End()
        sbSubTaskType = Nothing

        CommonFunction.Data.DisposeDataReader(drSubTaskubTasks)
        CommonFunction.Data.DisposeDataReader(drSubTask)
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 4,2007
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {"Save", "Save and Fill Timesheet", "?"} ''modified Link Name by RohiniK on 15 Jun 09
        Dim arrMenuToolTip() As String = {"Save", "Save and Fill Timesheet", "Help"} ''modified Link Name by RohiniK on 15 Jun 09
        Dim arrClientSideFunctions() As String = {"Save_OnClick()", "Submit_OnClick()", "OpenHelpPage('QuickTasks')"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu
    End Function

    Protected Function DrawAssignedTasks() As String
        '=====================================================================
        ' Procedure Name        : DrawAssignedTasks()
        ' Purpose               : To generate the Assigned Tasks UI
        ' Description           : To generate the Assigned Tasks UI
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sep 10,2007
        ' Revisions             :
        '=====================================================================
        Dim strSQL, strProjectID, strTaskTypeID As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim drAssignedTask As IDataReader
        Dim intCount, intNextRowCount As Integer
        Dim strActualDA As String
        Dim strData As String
        strSQL = "Exec usp_Sel_TodaysAssignedTasks '" + HttpContext.Current.Session("intUserID").ToString + "'"
        strSQL += ",'" + m_strDate + "'"

        drAssignedTask = CommonFunction.Data.GetDataReader(strSQL, True)

        intCount = 1
        While drAssignedTask.Read
            If CType(CommonFunction.Data.CheckIsDBNull(drAssignedTask("WhichTask"), ""), String).ToUpper = "O" And CType(CommonFunction.Data.CheckIsDBNull(drAssignedTask("TaskOnHold"), ""), String).ToUpper = "FALSE" And CType(CommonFunction.Data.CheckIsDBNull(drAssignedTask("Void"), ""), String).ToUpper = "FALSE" And CType(CommonFunction.Data.CheckIsDBNull(drAssignedTask("DAFilled"), ""), String).ToUpper = "FALSE" Then
                sbHtml.Append("<Tr class='" + strClass + "'>")
                sbHtml.Append("<td align='left'></td>")

                sbHtml.Append("<td align='left'>")
                sbHtml.Append(drAssignedTask("ProjectName").ToString)

                'Plot Hidden Controls 
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ATProjectID_" + intCount.ToString, "ATProjectID_" + intCount.ToString, , 50, 20, drAssignedTask("ProjectID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ATTaskTypeID_" + intCount.ToString, "ATTaskTypeID_" + intCount.ToString, , 50, 20, drAssignedTask("TaskTypeID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ATSubTaskTypeID_" + intCount.ToString, "ATSubTaskTypeID_" + intCount.ToString, , 50, 20, drAssignedTask("SubTaskTypeID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

                sbHtml.Append("</td>")

                sbHtml.Append("<td align='left'>")
                sbHtml.Append(drAssignedTask("TaskName").ToString)
                sbHtml.Append("</td>")

                sbHtml.Append("<td align='left'>")
                sbHtml.Append(drAssignedTask("ModuleName").ToString)
                sbHtml.Append("</td>")

                sbHtml.Append("<td align='left'>")
                sbHtml.Append(drAssignedTask("SubTaskTypeName").ToString)
                sbHtml.Append("</td>")
                sbHtml.Append("<td align='left'>")
                sbHtml.Append(drAssignedTask("Priority").ToString)
                sbHtml.Append("</td>")
                strData = CType(CommonFunction.Data.CheckIsDBNull(drAssignedTask("TodaysWork")), String)
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("AssignedWork_" + intCount.ToString, "AssignedWork_" + intCount.ToString, , 50, 20, drAssignedTask("Work").ToString, "right", , True, , , True, , True, EnableHTMLEncode:=True))

                'Added by GokulP on 07 Oct 2009 for IssueID : 33612
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("OUWorkingHrs_" + intCount.ToString, "OUWorkingHrs_" + intCount.ToString, , 50, 20, drAssignedTask("OUWorkingHours").ToString, "right", , True, , , True, , True, EnableHTMLEncode:=True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("TaskProjectName_" + intCount.ToString, "TaskProjectName_" + intCount.ToString, , 50, 20, drAssignedTask("ProjectName").ToString, "right", , True, , , True, , True, EnableHTMLEncode:=True))
                'End of Addition by GokulP on 07 Oct 2009 for IssueID : 33612

                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("TaskWork_" + intCount.ToString, "TaskWork_" + intCount.ToString, , 50, 20, drAssignedTask("TaskWork").ToString, "right", , True, , , True, , True, EnableHTMLEncode:=True))

                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("TaskName_" + intCount.ToString, "TaskName_" + intCount.ToString, , 50, 20, drAssignedTask("TaskName").ToString, "right", , True, , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

                strData = CType(CommonFunction.Data.CheckIsDBNull(drAssignedTask("PlannedWork")), String)
                If strData <> "" Then
                    dblTotalWork = dblTotalWork + CType(strData, Double)
                End If

                sbHtml.Append("<td align='right'>")
                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Work_" + intCount.ToString, "Work_" + intCount.ToString, , 50, 20, strData, "right", , , , , , , True, EnableHTMLEncode:=True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("WhichTask_" + intCount.ToString, "WhichTask_" + intCount.ToString, , 50, 20, drAssignedTask("WhichTask").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("UniqueID_" + intCount.ToString, "UniqueID_" + intCount.ToString, , 50, 20, drAssignedTask("TaskID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append("</td></tr>")

                intCount += 1
                If strClass = "clsTREven" Then
                    strClass = "clsTROdd"
                Else
                    strClass = "clsTREven"
                End If
            End If
        End While

        intAssignedTaskRows = intCount - 1
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("AssignedTaskCount", "AssignedTaskCount", , 50, 20, intAssignedTaskRows.ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        strSQL = "Exec usp_Get_TodaysActualDA '" + HttpContext.Current.Session("intUserID").ToString + "'"
        strSQL += ",'" + m_strDate + "'"
        strActualDA = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)
        dblTodaysTotalWork = CType(strActualDA, Double)
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ActualDA", "ActualDA", , 50, 20, strActualDA, "right", , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        DrawAssignedTasks = sbHtml.ToString
        sbHtml = Nothing
       
        CommonFunction.Data.DisposeDataReader(drAssignedTask)
    End Function

    Protected Sub EditQuickTask()
        Dim strMenu, strSQL, strProjectID, strTaskTypeID As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim drTodaysProjectTask As IDataReader
        Dim drTodaysTask As IDataReader
        Dim intCount, intNextRowCount As Integer
        Dim strData As String
        intRowCount = 0
        Dim sbProject As New System.Text.StringBuilder
        Dim drEfforts As IDataReader
        Dim drProjectDetails As IDataReader
        Dim strProject As String
        Dim intProjectID As Integer
        Dim dblTotal, dblPlanned As Double
        Dim strStartDate, strEndDate As String
        Dim intIsValidDate, intApprovedProject, intIsOnHold As Integer
        Dim intQTaskCounter As Integer
        Dim strMsg As String
        Dim strDeleteQuickTaskSQL As String = ""
        Dim strPrevDay, strNextDay As String

        strPrevDay = DateAdd("d", -1, Date.ParseExact(m_strDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")
        strNextDay = DateAdd("d", 1, Date.ParseExact(m_strDate, "d-MMM-yyyy", m_objDTFI)).ToString("dd-MMM-yyyy")


        strSQL = "Exec usp_Get_DayStatus_forEmployee '" + HttpContext.Current.Session("intUserID").ToString + "','" + m_strDate + "'"
        strMsg = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), String)

        If (CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "PLANWORK" Or CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SUBMIT") And m_strFirstTaskValidationMessage.ToString <> "" Then
            strSQL = "Exec usp_sel_tbl_PM_QuickTask_Plan '" + HttpContext.Current.Session("intUserID").ToString + "'"
            strSQL += ",Null,'" + m_strDate + "'"
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("DeleteMode"), "").ToUpper = "DELETETHISTASK" Then
            strSQL = "Exec usp_sel_tbl_PM_QuickTask_Both '" + HttpContext.Current.Session("intUserID").ToString + "'"
            strSQL += ",Null,'" + m_strDate + "'"
        Else
            strDeleteQuickTaskSQL = "DELETE FROM tbl_PM_QuickTask WHERE IsPlannedTask = 0 AND ISNULL(IsValidSavedTask,0) <> 1 AND EmployeeID = '" + HttpContext.Current.Session("intUserID").ToString + "' AND TaskDate= '" + m_strDate + "'"
            CommonFunction.Data.InsertOrUpdateData(strDeleteQuickTaskSQL, True)

            strSQL = "Exec usp_sel_tbl_PM_QuickTask '" + HttpContext.Current.Session("intUserID").ToString + "'"
            strSQL += ",Null,'" + m_strDate + "'"
        End If
 
        drTodaysProjectTask = CommonFunction.Data.GetDataReader(strSQL, True)
        'sbProject.Append("<SCRIPT language='javascript'>" + vbCrLf)
        'sbProject.Append("var ProjectDetails = new Array();" + vbCrLf)
        intCount = 0
        While drTodaysProjectTask.Read
            intProjectID = CType(drTodaysProjectTask("ProjectID"), Integer)
            strProject = CType(drTodaysProjectTask("ProjectName"), String)

            'sbProject.Append("ProjectDetails[" & intCount.ToString() & "] = new Array(5);" + vbCrLf)

            'sbProject.Append("ProjectDetails[" & intCount.ToString() & "][0] = " & intProjectID.ToString() & ";" & vbCrLf)
            strProject = Replace(strProject, "'", "\'")
            'sbProject.Append("ProjectDetails[" & intCount.ToString() & "][1] = '" & strProject & "';" & vbCrLf)
            ''' Available Work Hrs. 
            strSQL = "Exec usp_Sel_PM_DepartmentBalanceLCE '" + intProjectID.ToString + "'"
            drEfforts = CommonFunction.Data.GetDataReader(strSQL, True)
            If drEfforts.Read Then
                dblPlanned = CType(drEfforts("AllocatedLCETotal"), Double)
                dblTotal = CType(drEfforts("LCETotal"), Double)
            End If
            'sbProject.Append("ProjectDetails[" & intCount.ToString() & "][2] = " & (dblTotal - dblPlanned).ToString & ";" & vbCrLf)

            ''' Project Case, Start date and End Date
            'strSQL = "Exec Usp_Get_ProjectCase '" + intProjectID.ToString + "'"
            'strSQL += ",'" + m_strDate + "'"

            'drProjectDetails = CommonFunction.Data.GetDataReader(strSQL, True)
            'If drProjectDetails.Read Then
            '    intProjectCase = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ProjectCase"), "0"), Integer)
            '    strStartDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ExpectedStartDate"), ""), String)
            '    strEndDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ExpectedEndDate"), ""), String)
            '    intIsValidDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("IsValidDate"), "0"), Integer)
            '    intApprovedProject = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("IsApprovedProject"), "0"), Integer)
            '    intIsOnHold = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("IsOnHold"), "0"), Integer)

            '    'sbProject.Append("ProjectDetails[" & intCount.ToString() & "][3] = " & intProjectCase.ToString() & ";" & vbCrLf)

            'End If
            intCount += 1
            intRowCount += 1
        End While
        'sbProject.Append("</SCRIPT>" + vbCrLf)
        'CommonFunction.General.WriteHTML(sbProject.ToString)
        'sbProject = Nothing

        CommonFunction.Data.DisposeDataReader(drTodaysProjectTask)
        CommonFunction.Data.DisposeDataReader(drProjectDetails)
        CommonFunction.Data.DisposeDataReader(drEfforts)

        strMenu = DrawMenu()
        CommonFunction.General.WriteHTML(strMenu)
        sbHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:370px'>")
        sbHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)

        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left valign=top >Quick Tasks : ")

        sbHtml.Append(CommonFunction.HTMLControls.DrawDateControl("Today", "Today", , 80, m_strDate, , "frmRT_QuickTasks", , , , , , , True, , , "onkeypress= change_date(event)"))

        sbHtml.Append("<A class='Menu' style='' HREF='RT_QuickTasks.aspx?FromWhere=DT&Today=" + strPrevDay + "' Title='Previous Day'> ")
        sbHtml.Append("<Img src='../../Images/NavPreviousEnable.gif' border=0 />")
        sbHtml.Append("</A>")

        sbHtml.Append("<A class='Menu' style='' HREF='RT_QuickTasks.aspx?FromWhere=DT&Today=" + strNextDay + "' Title='Next Day'>")
        sbHtml.Append("<Img src='../../Images/NavNextEnable.gif' border=0 />")
        sbHtml.Append("</A>")

        If strMsg <> "" Then
            sbHtml.Append(" " + strMsg)
        End If
        sbHtml.Append("</TD></TR></TABLE><BR>" + vbCrLf)

        'Display Note for Void and Comleted
        sbHtml.Append("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" + vbCrLf)
        sbHtml.Append("<TR class='clsTREven'><TD align='left'><B>Note :</B> 'OnHold / Void' tasks and OnHold/Timesheet Blocked/Pending Project's tasks are not listed on this screen.</TD>")
        sbHtml.Append("</TR></TABLE><BR>" + vbCrLf)

        sbHtml.Append("<div ID=divTblGrid style='overflow:auto;width:100%;height:370px'>")
        sbHtml.Append("<Table name='QTasks' id='QTasks' class='clsGridTable' width=99.9% cellspacing=1 cellpadding=0><THead class='clsTRColumnHeader'>" + vbCrLf)
        sbHtml.Append("<TH class='FixedTD' align='Left' nowrap ></TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' nowrap >Project</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' >Task / Description</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' nowrap >Task Type</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' nowrap >Sub Task</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Left' nowrap >Priority</TH>")
        sbHtml.Append("<TH class='FixedTD' align='Right' >Actual Work(hrs)</TH>")
        sbHtml.Append("</THead>")
        sbHtml.Append(DrawFilledDATasks())
        sbHtml.Append(DrawAssignedTasks())

        intNextRowCount = intRowCount + intAssignedTaskRows + 1

        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("RowNumber", "RowNumber", , 100, , intNextRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True) + vbCrLf)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        ' Display existing Quick Tasks
        If (CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "PLANWORK" Or CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SUBMIT") And m_strFirstTaskValidationMessage.ToString <> "" Then
            strSQL = "Exec usp_sel_tbl_PM_QuickTask_Plan '" + HttpContext.Current.Session("intUserID").ToString + "'"
            strSQL += ",Null,'" + m_strDate + "'"
        ElseIf CommonFunction.General.CheckIsNothing(Request.QueryString("DeleteMode"), "").ToUpper = "DELETETHISTASK" Then
            strSQL = "Exec usp_sel_tbl_PM_QuickTask_Both '" + HttpContext.Current.Session("intUserID").ToString + "'"
            strSQL += ",Null,'" + m_strDate + "'"
        Else
            strSQL = "Exec usp_sel_tbl_PM_QuickTask '" + HttpContext.Current.Session("intUserID").ToString + "'"
            strSQL += ",Null,'" + m_strDate + "'"
        End If
   
        drTodaysTask = CommonFunction.Data.GetDataReader(strSQL, True)
        intQTaskCounter = intAssignedTaskRows + 1
        While drTodaysTask.Read
            sbHtml.Append("<Tr class='" + strClass + "'>")

            sbHtml.Append("<TD align=left>")
            sbHtml.Append(" <IMG BORDER=0 style='cursor:pointer;' src='../../images/delete.gif' onclick = 'DeleteThisTask(" + CommonFunctions.Data.CheckIsDBNull(drTodaysTask("TaskID").ToString).ToString + ")'>")
            sbHtml.Append("</TD>")

            sbHtml.Append("<td align='left'>")
            strProjectID = drTodaysTask("ProjectID").ToString
            strSQL = "usp_Sel_ListOfProject_QuickTask " + HttpContext.Current.Session("intUserID").ToString + ",'" + m_strDate + "'"
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("ProjectID_" + intQTaskCounter.ToString, strSQL, 150, strProjectID, "onchange=javascript:Project_Change(" + intQTaskCounter.ToString + ")", True, True, , True))

            ''Plot Hidded Control for Primary Key of a record
            strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("TaskID"), ""), String)
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("UniqueID_" + intQTaskCounter.ToString, "UniqueID_" + intQTaskCounter.ToString, , 50, 20, strData, , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            'sbHtml.Append("</td>")

            ''Commented and Modified By Aniruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
            ''strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("Description"), ""), String)
            strData = HttpUtility.HtmlEncode(CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("Description"), ""), String))
            ''End of Commented and Modified By Aniruddh Gujar on 24-Nov-2015 Purpose::SEM Issue fixing
            sbHtml.Append("<td align='left' >")
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Description_" + intQTaskCounter.ToString, "Description_" + intQTaskCounter.ToString, , 300, 255, strData, , , , , , , , True))
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            strTaskTypeID = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("TaskTypeID"), ""), String)
            strSQL = "Exec Usp_Sel_TaskType_QuickTask '" + strProjectID + "'"
            sbHtml.Append("<td align='left' >")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("TaskTypeID_" + intQTaskCounter.ToString, strSQL, 150, strTaskTypeID, "onchange=Task_Change(" + intQTaskCounter.ToString + ")", True, True, , True))
            sbHtml.Append("</td>")

            strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("SubTaskTypes"), ""), String)
            strSQL = "Exec usp_Sel_SubTasks_QuickTask '" + strProjectID + "','" + strTaskTypeID + "'"
            sbHtml.Append("<td align='left' >")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("SubTaskTypeID_" + intQTaskCounter.ToString, strSQL, 100, strData, , True, True))
            sbHtml.Append("</td>")

            strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("Priority"), ""), String)
            sbHtml.Append("<td align='left' >")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("Priority_" + intQTaskCounter.ToString, "usp_Sel_tbl_IB_Priorities", 90, strData, , True, True))

            sbHtml.Append("</td>")

            strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("Work"), ""), String)

            If strData <> "" Then
                dblTotalWork = dblTotalWork + CType(strData, Double)
            End If

            sbHtml.Append("<td align='right' valign='top'>")
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Work_" + intQTaskCounter.ToString, "Work_" + intQTaskCounter.ToString, , 50, 20, strData, "Right", , , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            sbHtml.Append("</tr>")
            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
            intQTaskCounter += 1
        End While

        sbHtml.Append("</Table>" + vbCrLf)
        sbHtml.Append("</Div>") 'Table Div 
        sbHtml.Append("</Div>") 'PageDiv

        sbHtml.Append("<BR><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0>" + vbCrLf)
        sbHtml.Append("<TR class='clsTREven'>")
        sbHtml.Append("<TD align='left'><B>Total Submitted Work (hrs) : " + dblTodaysTotalWork.ToString + "</B></TD>")
        sbHtml.Append("<TD align='right'><B>Total Actual Work (hrs) : " + dblTotalWork.ToString + "</B></TD>")

        sbHtml.Append("</TR></TABLE><BR>" + vbCrLf)
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        CommonFunction.General.WriteHTML(strMenu)
        sbHtml = Nothing

        CommonFunction.Data.DisposeDataReader(drTodaysTask)
    End Sub

    Protected Function DrawFilledDATasks() As String
        '=====================================================================
        ' Procedure Name        : DrawFilledDATasks()
        ' Purpose               : To generate the Filled DA Tasks UI
        ' Description           : To generate the Filled DA  Tasks UI
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : GokulP
        ' Created               : Sep 17,2009
        ' Revisions             :
        '=====================================================================
        Dim strSQL, strProjectID, strTaskTypeID As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim drFilledDATask As IDataReader
        Dim intCount, intNextRowCount As Integer
        Dim strActualDA As String
        Dim strData As String
        strSQL = "Exec usp_Sel_tbl_PM_DailyActivity_ForSimpleDA_QuickTask '" + HttpContext.Current.Session("intUserID").ToString + "'"
        strSQL = strSQL + ",NULL, NULL, NULL,'" + m_strDate + "','" + m_strDate + "',NULL, NULL, 1"

        drFilledDATask = CommonFunction.Data.GetDataReader(strSQL, True)

        intCount = 1
        While drFilledDATask.Read
            sbHtml.Append("<Tr class='" + strClass + "'>")
            sbHtml.Append("<td align='left'></td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drFilledDATask("ProjectName").ToString)

            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(HttpUtility.HtmlEncode(drFilledDATask("TaskName").ToString))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drFilledDATask("ModuleName").ToString)
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drFilledDATask("SubTaskTypeName").ToString)
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drFilledDATask("Priority").ToString)
            sbHtml.Append("</td>")

            strData = CType(CommonFunction.Data.CheckIsDBNull(drFilledDATask("Duration")), String)

            sbHtml.Append("<td align='right'>")
            sbHtml.Append(strData.ToString)
            sbHtml.Append("</td></tr>")

            intCount += 1
            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
        End While

        DrawFilledDATasks = sbHtml.ToString
        sbHtml = Nothing
       
        CommonFunction.Data.DisposeDataReader(drFilledDATask)
    End Function
End Class
