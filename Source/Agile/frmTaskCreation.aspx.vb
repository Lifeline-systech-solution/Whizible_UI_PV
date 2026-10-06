Imports System.Xml
Imports System.IO
Public Class frmTaskCreation
    Inherits WebPages.Template.WhizTemplate
    Protected intCurrentSprintID As String = "0"
    Protected strResult As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)

        Dim strsql As String = "SELECT dbo.fn_NG2_Sel_CurrentIterationOrRelease(" & HttpContext.Current.Session("IntProjectID") & ",'ITERATION')"

        intCurrentSprintID = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strsql, True), "0")

        Dim strSql1 As String = "usp_NG2_sel_tbl_PM_ScrumUserStory " & intCurrentSprintID

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function SaveTaskDetails(ByVal AssignTaskData As Object, ByVal UserStoryId As String) As String
        Dim strSQL, strSQL1 As String
        Dim m_lngTaskId As String
        Dim storyPoint As String
        storyPoint = AssignTaskData(0)("StoryPoints")
        If storyPoint = "0" Then
            storyPoint = "null"
        End If

        Dim objfrmSprintPlanning As New frmSprintPlanning()
        Try
            ''Commented and Added by Usha Pandit on 04-April-2019 Purpose::Whizible 2 Work field change
            'If AssignTaskData(0)("Flag") = "Save" Then

            '    'strSQL = "usp_NG2_Ins_tbl_PM_ProjectAssignedTasks NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "'"
            '    'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
            '    strSQL = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedTasks NULL," & AssignTaskData(0)("strProjectID") & ",'" & AssignTaskData(0)("TaskName").Replace("'", "''") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "','" & AssignTaskData(0)("WorkHrs") & "','O'," & AssignTaskData(0)("Billable") & ",'" & AssignTaskData(0)("TaskNote").Replace("'", "''") & "','" & AssignTaskData(0)("TaskType") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "'," & AssignTaskData(0)("WorkHrs") & ",'" & AssignTaskData(0)("Priority") & "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,null, NULL,null,null, NULL,null,null,0,1," & AssignTaskData(0)("Hold") & ",'" & HttpContext.Current.Session("strUserName") & "',1," & UserStoryId & ",NULL," & storyPoint & ""
            '    m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Long)
            '    strSQL1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId & "," & HttpContext.Current.Session("intUserID") & ",NULL," & AssignTaskData(0)("strProjectID") & ",'" & AssignTaskData(0)("TaskName").Replace("'", "''") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "','" & AssignTaskData(0)("WorkHrs") & "','O'," & AssignTaskData(0)("Billable") & ",'" & AssignTaskData(0)("TaskNote").Replace("'", "''") & "','" & AssignTaskData(0)("TaskType") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "'," & AssignTaskData(0)("WorkHrs") & ",'" & AssignTaskData(0)("Priority") & "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,null, NULL,null,null, NULL,null,null,0,1," & AssignTaskData(0)("Hold") & ",'" & HttpContext.Current.Session("strUserName") & "',1," & UserStoryId & ",NULL," & storyPoint & ""
            '    CommonFunctions.Data.GetDataScalar(strSQL1, True)
            '    Return "1"
            'ElseIf AssignTaskData(0)("Flag") = "Update" Then
            '    strSQL1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks null," & HttpContext.Current.Session("intUserID") & "," & AssignTaskData(0)("TaskID") & "," & AssignTaskData(0)("strProjectID") & ",'" & AssignTaskData(0)("TaskName").Replace("'", "''") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "','" & AssignTaskData(0)("WorkHrs") & "','O'," & AssignTaskData(0)("Billable") & ",'" & AssignTaskData(0)("TaskNote").Replace("'", "''") & "','" & AssignTaskData(0)("TaskType") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "'," & AssignTaskData(0)("WorkHrs") & ",'" & AssignTaskData(0)("Priority") & "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,null, NULL,null,null, NULL,null,null,0,1," & AssignTaskData(0)("Hold") & ",'" & HttpContext.Current.Session("strUserName") & "',1," & UserStoryId & ",NULL," & storyPoint & ""
            '    CommonFunctions.Data.GetDataScalar(strSQL1, True)
            'End If
            ''objfrmSprintPlanning.SaveTaskDetails(AssignTaskData)

            Dim fltWorkHrs As Decimal

            fltWorkHrs = CommonFunction.Data.GetDataScalar("SELECT dbo.fn_Whizible2_ConvertDecimalToHourViceVersa('" + AssignTaskData(0)("WorkHrs") + "',2)", True)

            If AssignTaskData(0)("Flag") = "Save" Then

                'strSQL = "usp_NG2_Ins_tbl_PM_ProjectAssignedTasks NULL," & strUserStoryID & ",'" & SubStoryName.Replace("'", "''") & "','" & SubStoryDesc.Replace("'", "''") & "','" & strPriority.Replace("'", "''") & "','" & HttpContext.Current.Session("strUserName") & "','" & strRank & "'"
                'CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                strSQL = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedTasks NULL," & AssignTaskData(0)("strProjectID") & ",'" & AssignTaskData(0)("TaskName").Replace("'", "''") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "','" & fltWorkHrs & "','O'," & AssignTaskData(0)("Billable") & ",'" & AssignTaskData(0)("TaskNote").Replace("'", "''") & "','" & AssignTaskData(0)("TaskType") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "'," & fltWorkHrs & ",'" & AssignTaskData(0)("Priority") & "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,null, NULL,null,null, NULL,null,null,0,1," & AssignTaskData(0)("Hold") & ",'" & HttpContext.Current.Session("strUserName") & "',1," & UserStoryId & ",NULL," & storyPoint & ""
                m_lngTaskId = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "0"), Long)
                strSQL1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks " & m_lngTaskId & "," & HttpContext.Current.Session("intUserID") & ",NULL," & AssignTaskData(0)("strProjectID") & ",'" & AssignTaskData(0)("TaskName").Replace("'", "''") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "','" & fltWorkHrs & "','O'," & AssignTaskData(0)("Billable") & ",'" & AssignTaskData(0)("TaskNote").Replace("'", "''") & "','" & AssignTaskData(0)("TaskType") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "'," & fltWorkHrs & ",'" & AssignTaskData(0)("Priority") & "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,null, NULL,null,null, NULL,null,null,0,1," & AssignTaskData(0)("Hold") & ",'" & HttpContext.Current.Session("strUserName") & "',1," & UserStoryId & ",NULL," & storyPoint & ""
                CommonFunctions.Data.GetDataScalar(strSQL1, True)
                Return "1"
            ElseIf AssignTaskData(0)("Flag") = "Update" Then
                strSQL1 = "Exec usp_NG2_Ins_tbl_PM_ProjectAssignedSubTasks null," & HttpContext.Current.Session("intUserID") & "," & AssignTaskData(0)("TaskID") & "," & AssignTaskData(0)("strProjectID") & ",'" & AssignTaskData(0)("TaskName").Replace("'", "''") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "','" & fltWorkHrs & "','O'," & AssignTaskData(0)("Billable") & ",'" & AssignTaskData(0)("TaskNote").Replace("'", "''") & "','" & AssignTaskData(0)("TaskType") & "','" & AssignTaskData(0)("StartDate") & "','" & AssignTaskData(0)("EndDate") & "'," & fltWorkHrs & ",'" & AssignTaskData(0)("Priority") & "', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,null, NULL,null,null, NULL,null,null,0,1," & AssignTaskData(0)("Hold") & ",'" & HttpContext.Current.Session("strUserName") & "',1," & UserStoryId & ",NULL," & storyPoint & ""
                CommonFunctions.Data.GetDataScalar(strSQL1, True)
            End If

            ''End of Added by Usha Pandit on 04-April-2019 Purpose::Whizible 2 Work field change
            Return "1"
        Catch ex As Exception
            Return "Bad Request found"

        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetSprintDropDown()
        Try
            Dim strsql As String = ""
            Dim strResult As String = ""
            Dim strHTML As New StringBuilder()

            strsql = "usp_NG2_SEL_tbl_PM_ScrumIterationDataCurrentSprint " & CStr(HttpContext.Current.Session("intProjectID"))

            Dim dt As New DataTable()
            dt = CommonFunctions.Data.GetDataTable(strsql, True)
            strResult = GetSerialized(dt)
            strHTML.Append(vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateSprintAndUS(ByVal UserStoryID As Integer)
        Try
            Dim strAddLinkAccess As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("Usp_Ng2_Chk_IterationRelaseFiled_mapped " & UserStoryID & ",'UserStory'", True))

            Return strAddLinkAccess
        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetDropDownValues(ByVal IterationID As Integer)
        Try
            Dim strsql As String = ""
            Dim strResult As String = ""
            Dim strHTML As New StringBuilder()

            strsql = "usp_NG2_sel_tbl_PM_ScrumUserStory_SP " & CStr(HttpContext.Current.Session("intProjectID")) & "," & IterationID

            Dim dt As New DataTable()
            dt = CommonFunctions.Data.GetDataTable(strsql, True)
            strResult = GetSerialized(dt)
            strHTML.Append(vbCrLf)
            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowTasksList(ByVal UserStoryID As String, ByVal FilterName As String)
        Try
            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_sel_tbl_PM_ScrumTask NULL," & UserStoryID & ",'" & FilterName & "'"
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString

        Catch ex As Exception
            Return "Bad Request found"
        End Try



    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaskPriorities()
        Try
            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_NG2_Sel_tbl_IB_Priorities "
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaskTypes()
        Try
            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_NG2_Sel_tbl_PM_Project_TaskTypes_Names " & CStr(HttpContext.Current.Session("intProjectID")) & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetTaskDetails(ByVal TaskID As Integer)
        Try
            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_sel_tbl_PM_ScrumTask " & TaskID
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetOverallTaskDetails(ByVal iterationID As Integer, ByVal Assignedto As Integer)
        Try
            Dim drTabData As DataTable
            Dim strHTML As New StringBuilder()

            Dim StrSql As String = "usp_Get_tbl_PM_ScrumTask " & iterationID & "," & Assignedto & ""
            drTabData = CommonFunctions.Data.GetDataTable(StrSql, True)

            Dim strResult As String = GetSerialized(drTabData)


            Return strResult & "|" & strHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try




    End Function



    Public Shared Function GetSerialized(dt As DataTable) As String

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




    End Function
End Class