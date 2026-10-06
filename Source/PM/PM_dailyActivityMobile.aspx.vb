Public Class PM_dailyActivityMobile
    Inherits WebPages.Template.WhizTemplate
    Protected EXPIRY_OF_TASK As String = ""
    Protected EXPIRY_OF_TASK_FORWARD As String = ""
    ''Added By Vaijat K ON 28/04/2016 For WCF Security
    Protected m_PKToken As String = ""
    'End of addition
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
          MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(Session("intLoginID"))
        'If Value2 IsNot Nothing Then
        '    For i As Integer = 0 To Value2.Count - 1
        '        If Value2.Item(i) <> Session.SessionID Then
        '            CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(Session("intLoginID"))
        '            Session("intUserID") = Nothing
        '            Session.Abandon()
        '            Response.Redirect("../../Default.aspx?Message=SESSIONEXPIRED")
        '        End If
        '    Next
        'End If
        EXPIRY_OF_TASK = CommonFunction.Application.BackdatingNoDays.ToString()
        EXPIRY_OF_TASK_FORWARD = CommonFunction.Application.ForwardDatingNoDays.ToString()

        ''Added By Vaijat K ON 28/04/2016 For WCF Security
        m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String))
        'End of addition
    End Sub
    ''Added by Yogesh J on 18-Mar-2016 To generate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function SetWork(TaskId As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(TaskId, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function SaveUpdateTask(EmployeeID As String, TaskID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(TaskID, String))

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 18-Mar-2016 To generate Token
    <System.Web.Services.WebMethod()> _
    Public Shared Function GetTimesheetDetailsforEntryDate(ByVal m_strProjectID As String) As String
        Try
            Dim EXPIRY_OF_TASK As String = ""
            Dim EXPIRY_OF_TASK_FORWARD As String = ""
            Dim m_blnProjectBackdateEntry As String
            Dim m_blnProjectFwddateEntry As String
            EXPIRY_OF_TASK = CommonFunction.Application.BackdatingNoDays.ToString()
            EXPIRY_OF_TASK_FORWARD = CommonFunction.Application.ForwardDatingNoDays.ToString()
            If CStr(EXPIRY_OF_TASK) <> "" Then
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_strProjectID, True)

                If drBackDatedConf.Read() Then
                    'Entry exists for the current project and current user in configuration table
                    If CType(drBackDatedConf("IsBackDating"), Boolean) = False Then
                        m_blnProjectBackdateEntry = "False"
                    Else
                        m_blnProjectBackdateEntry = "True"
                    End If
                Else
                    'Entry Doesnot exist for the current project and current user in configuration table
                    m_blnProjectBackdateEntry = "False"
                End If
                CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            Else
                m_blnProjectBackdateEntry = "True"
            End If

            If CStr(EXPIRY_OF_TASK_FORWARD) <> "" Then
                Dim drBackDatedConf As IDataReader
                drBackDatedConf = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_PM_BackdatingConfiguration null," & m_strProjectID, True)

                If drBackDatedConf.Read() Then
                    'Entry exists for the current project and current user in configuration table
                    If CType(drBackDatedConf("IsForwardDating"), Boolean) = False Then
                        m_blnProjectFwddateEntry = "False"
                    Else
                        m_blnProjectFwddateEntry = "True"
                    End If
                Else
                    'Entry Doesnot exist for the current project and current user in configuration table
                    m_blnProjectFwddateEntry = "False"
                End If
                CommonFunction.Data.DisposeDataReader(drBackDatedConf)
            Else
                m_blnProjectFwddateEntry = "True"
            End If

            Return m_blnProjectBackdateEntry & "," & m_blnProjectFwddateEntry
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
 _
    Public Shared Function GetRoleAccess(ByVal intUserID As String)
        Try
            Dim strRoleAccess As String
            strRoleAccess = CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Login_AccessibleModules_ForRole " & intUserID & "", True), "")
            Return strRoleAccess
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''added By tejal deshmukh
    <System.Web.Services.WebMethod()>
    Public Shared Function HolidayChek(ByVal DateHoliday() As String)
        Try
            ''Dim Holiday As IDataReader = CommonFunctions.Data.GetDataReader("select HolidayDate from tbl_PM_Holiday", True)
            Dim Holiday1 As New List(Of String)
            Dim strSQL As String
            Dim isHoliday As String
            Dim Len As Integer
            Len = DateHoliday.Length

            For i As Integer = 0 To Len - 1

                strSQL = "usp_chk_IsHoliday '" & DateHoliday(i) & "'"
                isHoliday = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")
                If isHoliday = "1" Then
                    Holiday1.Add(DateHoliday(i))
                End If
            Next
            'Dim isHoliday As Integer
            'Dim strSQL As String
            'strSQL = "usp_chk_IsHoliday '" & DateHoliday & "'"
            'isHoliday = CommonFunction.Data.GetDataScalar(strSQL, True)

            Return Holiday1
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function DayChek()
        Try
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''Dim days As String = CType(CommonFunctions.Data.GetDataScalar("select StartingDayOfWeek from tbl_PM_CompanyInformation", True), String)
            Dim days As String = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_StartingDayOfWeek", True), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''Dim Wday As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select WeekDays from tbl_PM_CompanyInformation", True), ""), String)
            Dim Wday As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_WeekDays", True), ""), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'Dim dayCollection As IDataReader = CommonFunctions.Data.GetDataReader("usp_Sel_selectDay", True)
            'Dim days As String = dayCollection("StartingDayOfWeek ").ToString
            'Dim Wday As String = dayCollection("WeekDays").ToString
            Dim a As New List(Of String)
            a.Add(days)
            a.Add(Wday)

            Return a
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function LeavesChek(ByVal intUserID As String, ByVal DateHoliday1() As String)
        Try
            Dim leave As New List(Of String)
            Dim strSQL As String
            Dim isLeave As String
            Dim Len1 As Integer
            Len1 = DateHoliday1.Length
            For i As Integer = 0 To Len1 - 1
                strSQL = "usp_chk_IsLeave " & intUserID & ",'" & DateHoliday1(i) & "'"
                isLeave = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")
                If isLeave = "1" Then
                    leave.Add(DateHoliday1(i))
                End If
            Next
            Return leave
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function HalfDayChek(ByVal intUserID As String, ByVal DateHoliday2() As String)
        Try
            Dim HalfDay As New List(Of String)
            Dim strSQL As String
            Dim isLeave As String
            Dim Len1 As Integer
            Len1 = DateHoliday2.Length
            For i As Integer = 0 To Len1 - 1
                strSQL = "usp_chk_HalfDay " & intUserID & ",'" & DateHoliday2(i) & "'"
                isLeave = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")
                If isLeave = "1" Then
                    HalfDay.Add(DateHoliday2(i))
                End If
            Next
            Return HalfDay
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    '<System.Web.Services.WebMethod()>
    'Public Shared Function TaskChek(ByVal intUserID As String, ByVal DateHoliday2() As String)
    '    Dim task As New List(Of String)
    '    Dim strSQL As String
    '    Dim isTask As String
    '    Dim Len2 As Integer
    '    Len2 = DateHoliday2.Length
    '    For i As Integer = 0 To Len2 - 1
    '        strSQL = "usp_chk_IsTasks " & intUserID & ",'" & DateHoliday2(i) & "'"
    '        isTask = CommonFunction.Data.GetDataScalar(strSQL, True)
    '        If isTask = "1" Then
    '            task.Add(DateHoliday2(i))
    '        End If
    '    Next
    '    Return task
    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSerialized(dt As DataTable) As String
        Try
            Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))()
            Dim row As Dictionary(Of String, Object)
            For Each dr As DataRow In dt.Rows
                row = New Dictionary(Of String, Object)()
                For Each col As DataColumn In dt.Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Return serializer.Serialize(rows)
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ChekTaskCount(ByVal intUserID As String, ByVal DateHoliday3() As String)
        Try 'Dim taskCount As New List(Of String)
            Dim dt As New DataTable
            Dim strSQL As String
            Dim isTaskCount As String
            Dim Len2 As Integer
            Len2 = DateHoliday3.Length
            dt.Columns.Add("Date")
            dt.Columns.Add("isTaskCount")
            Dim strData As String
            For i As Integer = 0 To Len2 - 1
                strSQL = "usp_chk_IsTasksCount " & intUserID & ",'" & DateHoliday3(i) & "'"
                isTaskCount = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")
                ' Return taskCount
                ' Return isTaskCount
                dt.Rows.Add()
                dt.Rows(i).Item(0) = DateHoliday3(i)
                dt.Rows(i).Item(1) = isTaskCount

                strData = GetSerialized(dt)

            Next
            Return strData
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DisplayTaskName(ByVal intUserID As String, ByVal DateHoliday3 As String)
        Try
            Dim dt As New DataTable
            Dim strSQL As String
            Dim name As String
            ' Dim Len2 As Integer
            'Len2 = DateHoliday3.Length
            'dt.Columns.Add("Date")
            'dt.Columns.Add("name")
            Dim strDataTask As String
            ' For i As Integer = 0 To Len2 - 1
            strSQL = "usp_DisplayTaskName " & intUserID & ",'" & DateHoliday3 & "'"
            name = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")

            If name = "" Or name Is Nothing Then

                name = "no Events"
                ' Return name
            End If

            strDataTask = GetSerialized(dt)

            Return name

        Catch ex As Exception
            Return "Bad Request Found"
        End Try

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function DisplayHolidayname(ByVal DateHoliday3 As String)
        Try
            Dim dt As New DataTable
            Dim strSQL As String
            Dim HolidayName As String
            Dim strDataTask As String
            strSQL = "usp_DisplayHolidayName '" & DateHoliday3 & "'"
            HolidayName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")
            If HolidayName = "" Or HolidayName Is Nothing Then

                HolidayName = "no Events"
                ' Return name
            End If

            strDataTask = GetSerialized(dt)

            Return HolidayName
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function PlannedTask(ByVal intUserID As String, ByVal DateHoliday3() As String)
        Try
            Dim taskNum As New List(Of String)
            Dim strSQL As String
            Dim isLeave As String
            Dim Len1 As Integer
            Len1 = DateHoliday3.Length
            Len1 = DateHoliday3.Length
            For i As Integer = 0 To Len1 - 1
                strSQL = "usp_chk_numberOfTask " & intUserID & ",'" & DateHoliday3(i) & "'"
                isLeave = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), "")
                If isLeave >= "1" Then
                    taskNum.Add(DateHoliday3(i))
                End If
            Next
            Return taskNum
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    '<System.Web.Services.WebMethod()>
    'Public Shared Function BirthDate(ByVal intUserID As String, ByVal DateHoliday3 As String)

    '    Dim dt As New DataTable
    '    Dim strSQL As String
    '    Dim EmployeeName As String
    '    Dim strDataTask As String
    '    ' strSQL = "usp_EmployeeBirthDate " & intUserID & ""
    '    strSQL = "usp_EmployeeBirthDate " & intUserID & ",'" & DateHoliday3 & "'"
    '    EmployeeName =  CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True),"")

    '    If EmployeeName = "" Or EmployeeName Is Nothing Then

    '        EmployeeName = "no Events"
    '        ' Return name
    '    End If

    '    strDataTask = GetSerialized(dt)

    '    Return EmployeeName



    'End Function


    'Ended by tejal deshmukh

    ''Added By Vaijat K ON 05/03/2016 For Issue ID-3732
    <System.Web.Services.WebMethod()>
    Public Shared Function GetIsTaskCompleteFlag(taskID As String) As String
        Try
            Dim m_strIsTaskComplete As String
            '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''m_strIsTaskComplete = CommonFunction.Data.GetDataScalar("SELECT isTaskComplete FROM tbl_pm_projectTasks where taskID= " & taskID, True)
            m_strIsTaskComplete = CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectTasks_IsTaskComplete " & taskID, True)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            Return m_strIsTaskComplete
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition Vaijat K
End Class