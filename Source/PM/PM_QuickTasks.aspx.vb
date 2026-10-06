Public Class PM_QuickTasks
    ''Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected intProjectCase As Integer
    Protected intRowCount As Integer
    Protected strAction As String
    Protected dblMinHoursForDAEntry As Double
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
        ''Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        ''End of Addition by Dhanashri S on 10 Oct 2016


        Dim strSQL As String
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL = "Select MinHoursForDAEntry From tbl_PM_CompanyInformation"
        strSQL = "usp_sel_tbl_PM_CompanyInformation_MinHoursForDAEntry"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        dblMinHoursForDAEntry = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Double)

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromXML")) = "1" Then
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DeleteTask")) <> "" Then
                Call DeleteTask(HttpContext.Current.Request.QueryString("DeleteTask"))
            ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action")).ToUpper = "TASKTYPE" Then
                Call InitialiseSubTasks()
            Else
                Call InitialiseTaks()
            End If
            Exit Sub
        Else
            ProjectInitialization()
            If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SAVE" Then
                'Dim strScript As String
                PerformAction()
            End If
            If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), "").ToUpper = "SUBMIT" Then
                'Dim strScript As String
                SubmitTask()
                'strScript = vbCrLf + "<Script language=javascript>"
                'strScript += vbCrLf + "    refreshParent('frmCommonList','WorkFlowInbox.aspx','WorkFlowInbox.aspx?MasterTagID=2182&FromWhere=DM&FromTree=1');"
                'strScript += vbCrLf + " window.close();"
                'strScript += vbCrLf + "</Script>"
                'CommonFunction.General.WriteHTML(strScript)
            End If
            Draw_Page()
        End If
    End Sub

    Protected Sub PerformAction()
        Dim intRows, intCount As Integer
        Dim strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID As String
        intRows = CType(HttpContext.Current.Request.QueryString("Rows"), Integer)
        For intCount = 1 To intRows - 1
            strProjectID = Request.Form("ProjectID_" + intCount.ToString)
            strTaskTypeID = Request.Form("TaskTypeID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("SubTaskTypeID_" + intCount.ToString)
            strDescription = Request.Form("Description_" + intCount.ToString)
            strWork = Request.Form("Work_" + intCount.ToString)
            strUniqueID = Request.Form("UniqueID_" + intCount.ToString)
            CreateQuickTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID)
        Next
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
        Dim intRows, intAssignedTasksRows, intCount As Integer
        Dim strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID As String
        intRows = CType(HttpContext.Current.Request.QueryString("Rows"), Integer)
        intAssignedTasksRows = CType(HttpContext.Current.Request.QueryString("AssignedTasks"), Integer)
        For intCount = 1 To intRows - 1
            strProjectID = Request.Form("ProjectID_" + intCount.ToString)
            strTaskTypeID = Request.Form("TaskTypeID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("SubTaskTypeID_" + intCount.ToString)
            strDescription = Request.Form("Description_" + intCount.ToString)
            strWork = Request.Form("Work_" + intCount.ToString)
            strUniqueID = Request.Form("UniqueID_" + intCount.ToString)
            CreateAssignedTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strDescription, strWork, strUniqueID)
        Next

        For intCount = 0 To intAssignedTasksRows - 1
            strProjectID = Request.Form("ATProjectID_" + intCount.ToString)
            strTaskTypeID = Request.Form("ATTaskTypeID_" + intCount.ToString)
            strSubTaskTypeID = Request.Form("ATSubTaskTypeID_" + intCount.ToString)
            strWork = Request.Form("WorkForDA_" + intCount.ToString)
            strUniqueID = Request.Form("AssignedTaskID_" + intCount.ToString)
            FillDAForAssignedTasks(strProjectID, strTaskTypeID, strSubTaskTypeID, strWork, strUniqueID)
        Next
    End Sub
    Protected Sub FillDAForAssignedTasks(ByVal ProjectID As String, ByVal TaskTypeID As String, ByVal SubTaskTypeID As String, ByVal Work As String, ByVal UniqueID As String)
        Dim strSQL As String
        strSQL = "Exec usp_Ins_tbl_PM_DailyActivity NULL, '" + UniqueID + "','" + ProjectID + "','" + HttpContext.Current.Session("intUserID").ToString + "'"
        strSQL += ",'" + HttpContext.Current.Session("intPostID").ToString + "','" + Date.Now().Today.ToString + "','" + Work + "',NULL"
        strSQL += ",'" + TaskTypeID + "','" + SubTaskTypeID + "',Null, 0,100.00,0,null,'N'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        'Exec usp_Ins_tbl_PM_DailyActivity  NULL, @ChildTaskID, @ProjectID, @EmployeeID, @RoleID, GetDate(), @Work, 
        'NULL, @TaskTypeID, @SubTaskTypeID, NULL, 0,100.00,0,null,'N'
    End Sub
    Protected Sub CreateQuickTasks(ByVal ProjectID As String, ByVal TaskTypeID As String, ByVal SubTaskTypeID As String, ByVal Description As String, ByVal Work As String, ByVal UniqueID As String)
        Dim strSQL As String
        strSQL = "Exec Usp_Ins_Upd_tbl_PM_QuickTasks '" + HttpContext.Current.Session("intUserID").ToString + "','" + ProjectID + "','"
        strSQL += TaskTypeID + "','" + SubTaskTypeID + "','" + Description + "','" + Work + "'"
        If UniqueID <> "" Then
            strSQL += ",'" + UniqueID + "'"
        End If
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub
    Protected Sub CreateAssignedTasks(ByVal ProjectID As String, ByVal TaskTypeID As String, ByVal SubTaskTypeID As String, ByVal Description As String, ByVal Work As String, ByVal UniqueID As String)
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
        strSQL += "'" + ProjectID + "','" + Description + "','" + Work + "','" + TaskTypeID + "','" + SubTaskTypeID + "','"
        strSQL += HttpContext.Current.Session("strUserName").ToString + "','" + UniqueID + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub

    Protected Sub DeleteTask(ByVal TaskID As String)
        Dim strSQL As String
        strSQL = "Delete From tbl_PM_QuickTask Where TaskID = '" + TaskID + "'"
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)
    End Sub
    Public Shared Sub InitialiseTaks()
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
        Dim drTasks, drTaskSubTasks As IDataReader
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
        '''Task - Sub Task Array
        If intProjectID <> 0 Then
            'strSQL += "ON PSTT.TaskTypeID = TT.TaskTypeID WHERE ProjectID = '" + intProjectID.ToString + "' order by TT.TaskType"
            strSQL = "Exec Usp_Sel_TaskType '" + intProjectID.ToString + "'"
            drTasks = CommonFunction.Data.GetDataReader(strSQL, True)
            While drTasks.Read
                intTaskTypeID = CType(CommonFunction.Data.CheckIsDBNull(drTasks("TaskTypeID"), "0"), Integer)
                strTaskType = CommonFunction.Data.CheckIsDBNull(drTasks("TaskType")).ToString
                strTaskType = Replace(strTaskType, "'", "\'")
                sbTaskType.Append(intTaskTypeID.ToString + "|" + strTaskType + "|")
                intCount += 1
            End While
            'sbTaskType.Append("$#TD#$")

            'intCount = 0
            'strSQL = "usp_Sel_tbl_PM_Project_SubTasks_QuickTask '" + intProjectID.ToString + "'"
            'drTaskSubTasks = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            'While drTaskSubTasks.Read()
            '    intTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTaskSubTasks.Item("TaskTypeID"), "0"), Integer)
            '    intSubTaskTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drTaskSubTasks.Item("SubTaskTypeID"), "0"), Integer)
            '    strSubTaskType = CommonFunctions.General.CheckIsNothing(drTaskSubTasks.Item("SubTaskType"), "")
            '    strSubTaskType = Replace(strSubTaskType, "'", "\'")
            '    sbTaskType.Append(intTaskTypeID.ToString + "|" + intSubTaskTypeID.ToString + "|" + strSubTaskType + "|")
            '    intCount = intCount + 1
            'End While
        End If

        HttpContext.Current.Response.Clear()

        If Not sbTaskType Is Nothing Then
            HttpContext.Current.Response.Write(sbTaskType.ToString)
        Else
            HttpContext.Current.Response.Write("null")
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


        ''''strRowNumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RowNumber"))
        ''intProjectID = CType(HttpContext.Current.Request("ProjectID"), Integer)
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "") <> "" Then
            If HttpContext.Current.Request("ProjectID").ToString <> "" Then
                intProjectID = CType(HttpContext.Current.Request("ProjectID"), Integer)
            Else
                intProjectID = 0
            End If
        Else
            intProjectID = 0
        End If

        'intTaskTypeID = CType(HttpContext.Current.Request.Form("TaskTypeID_" + strRowNumber), Integer)

        '''Task - Sub Task Array

        strSQL = "Exec usp_Sel_tbl_PM_Project_SubTasks_QuickTask '" + intProjectID.ToString + "'"
        ','" + intTaskTypeID.ToString + "'"
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
        CommonFunction.Data.DisposeDataReader(drSubTask)
    End Sub
    Protected Sub ProjectInitialization()
        '=====================================================================
        ' Procedure Name        : ProjectInitialization()
        ' Purpose               : To get project accessible to logged in user
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
        Dim sbProject As New System.Text.StringBuilder
        Dim intCount As Integer = 0
        Dim intProjectID As Integer
        Dim strProject, strSubProject As String
        Dim drProjects As IDataReader
        Dim drProjectDetails As IDataReader
        Dim drEfforts As IDataReader
        Dim strRowNumber As String = ""
        Dim dblPlanned, dblTotal As Double
        Dim strStartDate, strEndDate As String
        Dim intIsValidDate, intApprovedProject, intIsOnHold As Integer
        strSQL = "usp_Sel_AccessibleProjects_ForEmployee  '"
        strSQL += HttpContext.Current.Session("intUserID").ToString + "',1,1  "

        drProjects = CommonFunction.Data.GetDataReader(strSQL, True)
        sbProject.Append("<SCRIPT language='javascript'>" + vbCrLf)
        sbProject.Append("var Project = new Array();" + vbCrLf)
        While drProjects.Read
            intProjectID = CType(CommonFunction.Data.CheckIsDBNull(drProjects("ProjectID"), "0"), Integer)
            strProject = CommonFunction.Data.CheckIsDBNull(drProjects("ProjectName")).ToString
            'sbProject.Append("Project[" & intCount.ToString() & "] = new Array(4);" + vbCrLf)
            sbProject.Append("Project[" & intCount.ToString() & "] = new Array(9);" + vbCrLf)
            sbProject.Append("Project[" & intCount.ToString() & "][0] = " & intProjectID.ToString() & ";" & vbCrLf)
            strProject = Replace(strProject, "'", "\'")
            sbProject.Append("Project[" & intCount.ToString() & "][1] = '" & strProject & "';" & vbCrLf)

            ''' Available Work Hrs. 
            strSQL = "Exec usp_Sel_PM_DepartmentBalanceLCE '" + intProjectID.ToString + "'"
            drEfforts = CommonFunction.Data.GetDataReader(strSQL, True)
            If drEfforts.Read Then
                dblPlanned = CType(drEfforts("AllocatedLCETotal"), Double)
                dblTotal = CType(drEfforts("LCETotal"), Double)
            End If
            CommonFunction.Data.DisposeDataReader(drEfforts)
            sbProject.Append("Project[" & intCount.ToString() & "][2] = '" & (dblTotal - dblPlanned).ToString & "';" & vbCrLf)

            ''' Project Case, Start date and End Date
            strSQL = "Exec Usp_Get_ProjectCase '" + intProjectID.ToString + "'"
            drProjectDetails = CommonFunction.Data.GetDataReader(strSQL, True)
            If drProjectDetails.Read Then
                intProjectCase = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ProjectCase"), "0"), Integer)
                strStartDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ExpectedStartDate"), ""), String)
                strEndDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("ExpectedEndDate"), ""), String)
                intIsValidDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("IsValidDate"), "0"), Integer)
                intApprovedProject = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("IsApprovedProject"), "0"), Integer)
                intIsOnHold = CType(CommonFunction.Data.CheckIsDBNull(drProjectDetails("IsOnHold"), "0"), Integer)

                sbProject.Append("Project[" & intCount.ToString() & "][3] = '" & intProjectCase.ToString & "';" & vbCrLf)
                sbProject.Append("Project[" & intCount.ToString() & "][4] = '" & strStartDate & "';" & vbCrLf)
                sbProject.Append("Project[" & intCount.ToString() & "][5] = '" & strEndDate & "';" & vbCrLf)
                sbProject.Append("Project[" & intCount.ToString() & "][6] = '" & intIsValidDate.ToString & "';" & vbCrLf)
                sbProject.Append("Project[" & intCount.ToString() & "][7] = '" & intApprovedProject.ToString & "';" & vbCrLf)
                sbProject.Append("Project[" & intCount.ToString() & "][8] = '" & intIsOnHold.ToString & "';" & vbCrLf)
            End If
            CommonFunction.Data.DisposeDataReader(drProjectDetails)
            intCount += 1
        End While
        sbProject.Append("</SCRIPT>" + vbCrLf)
        CommonFunction.General.WriteHTML(sbProject.ToString)
        sbProject = Nothing
        CommonFunction.Data.DisposeDataReader(drProjects)
    End Sub

    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
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
        Dim strMenu, strSQL, strProjectID, strTaskTypeID As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim drTodaysTask As IDataReader
        Dim intCount, intNextRowCount As Integer
        Dim strData As String
        intRowCount = 0

        strSQL = "Exec usp_sel_tbl_PM_QuickTask '" + HttpContext.Current.Session("intUserID").ToString + "'"
        drTodaysTask = CommonFunction.Data.GetDataReader(strSQL, True)
        While drTodaysTask.Read
            intRowCount += 1
        End While

        If intRowCount = 0 Then
            intNextRowCount = 2
        Else
            intNextRowCount = intRowCount + 1
        End If
        CommonFunction.Data.DisposeDataReader(drTodaysTask)
        drTodaysTask = CommonFunction.Data.GetDataReader(strSQL, True)

        strMenu = DrawMenu()
        CommonFunction.General.WriteHTML(strMenu)
        sbHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:900px'>")
        sbHtml.Append("<div ID=QTaskDiv style='overflow:auto;width:100%;height:225px'>")
        sbHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>Quick Tasks</TD></TR></TABLE><BR>" + vbCrLf)

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("RowNumber", "RowNumber", , 100, , intNextRowCount.ToString, , , , , , True, , True, EnableHTMLEncode:=True) + vbCrLf)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        sbHtml.Append("<Table name='QTasks' id='QTasks' class='clsTable' width=99.9% cellspacing=0 cellpadding=0><TR class='clsTRColumnHeader'>" + vbCrLf)
        sbHtml.Append("<TD align=left>Project</TD><TD align=left>Description</TD><TD align=left>Task Type</TD><TD align=left>Activity</TD>" + vbCrLf)
        sbHtml.Append("<TD align=right>Work (hrs)</TD><TD align=center>Cancel</TD></TR>" + vbCrLf)

        ' Display existing Quick Tasks
        For intCount = 1 To intRowCount
            If drTodaysTask.Read Then
                strProjectID = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("ProjectID"), ""), String)

                strSQL = "usp_Sel_AccessibleProjects_ForEmployee  '"
                strSQL += HttpContext.Current.Session("intUserID").ToString + "',1,1  "

                sbHtml.Append("<Tr class='clsTREvenRow'>")
                sbHtml.Append("<td align='left'>")
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("ProjectID_" + intCount.ToString, strSQL, 200, strProjectID, "onchange=javascript:Project_OnChange(" + intCount.ToString + ")", True, True))


                ''Plot Hidded Control for Primary Key of a record
                strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("TaskID"), ""), String)
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("UniqueID_" + intCount.ToString, "UniqueID_" + intCount.ToString, , 50, 20, strData, , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append("</td>")


                strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("Description"), ""), String)
                sbHtml.Append("<td align='left' >")
                ''''''sbHtml.Append(CommonFunction.HTMLControls.DrawTextArea("Description_" + intCount.ToString, "Description_" + intRowCount.ToString, "Description", , , "frmPM_QuickTasks", , , 150, 50, 200, strData, , , , , , , , True))
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Description_" + intCount.ToString, "Description_" + intRowCount.ToString, , 200, 200, strData, , , , , , , , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append("</td>")


                strTaskTypeID = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("TaskTypeID"), ""), String)
                'strSQL = "SELECT Distinct PSTT.TaskTypeID, TT.TaskType FROM tbl_PM_Project_SubTaskTypes PSTT INNER JOIN tbl_PM_TaskTypes TT "
                'strSQL += "ON PSTT.TaskTypeID = TT.TaskTypeID WHERE ProjectID = '" + strProjectID + "' order by TT.TaskType"
                strSQL = "Exec Usp_Sel_TaskType '" + strProjectID + "'"
                sbHtml.Append("<td align='left' >")
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("TaskTypeID_" + intCount.ToString, strSQL, 120, strTaskTypeID, "onchange=javascript:Task_OnChange(" + intCount.ToString + ")", True, True))
                sbHtml.Append("</td>")

                strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("SubTaskTypes"), ""), String)
                strSQL = "Exec usp_Sel_SubTasks '" + strProjectID + "','" + strTaskTypeID + "'"
                sbHtml.Append("<td align='left' >")
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("SubTaskTypeID_" + intCount.ToString, strSQL, 120, strData, , True, True))
                sbHtml.Append("</td>")

                strData = CType(CommonFunction.Data.CheckIsDBNull(drTodaysTask("Work"), ""), String)
                sbHtml.Append("<td align='right' valign='top'>")
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Work_" + intCount.ToString, "Work_" + intCount.ToString, , 50, 20, strData, "Right", , , , , , , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                sbHtml.Append("</td>")

                sbHtml.Append("<td align='center' >")
                If intCount = intRowCount Then
                    sbHtml.Append("<A HREF='Javascript:Cancel_OnClick(" + intCount.ToString + ")' Title='Cancel' >Cancel</A>")
                Else
                    sbHtml.Append("Cancel")
                End If

                sbHtml.Append("</td></tr>")
            End If
        Next

        'Bydefault show one 
        If intRowCount = 0 Then
            strSQL = "usp_Sel_AccessibleProjects_ForEmployee  '"
            strSQL += HttpContext.Current.Session("intUserID").ToString + "',1,1  "

            sbHtml.Append("<Tr class='clsTREvenRow'>")
            sbHtml.Append("<td align='left' >")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("ProjectID_" + (intRowCount + 1).ToString, strSQL, 200, , "onchange=javascript:Project_OnChange(" + (intRowCount + 1).ToString + ")", True, True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("UniqueID_" + (intRowCount + 1).ToString, "UniqueID_" + (intRowCount + 1).ToString, , 50, 20, "", , , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left' >")
            ''''''sbHtml.Append(CommonFunction.HTMLControls.DrawTextArea("Description_" + (intRowCount + 1).ToString, "Description_" + intRowCount.ToString, "Description", , , "frmPM_QuickTasks", , , 150, 50, 200, , , , , , , , , True))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Description_" + (intRowCount + 1).ToString, "Description_" + (intRowCount + 1).ToString, , 200, 200, , , , , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left' >")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("TaskTypeID_" + (intRowCount + 1).ToString, "select '',''", 120, , "onchange=javascript:Task_OnChange(" + (intRowCount + 1).ToString + ")", True, True))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left' >")
            sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("SubTaskTypeID_" + (intRowCount + 1).ToString, "select '',''", 120, , , True, True))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='right' >")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Work_" + (intRowCount + 1).ToString, "Work_" + (intRowCount + 1).ToString, , 50, 20, , "Right", , , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='center' >")
            sbHtml.Append("<A HREF='Javascript:Cancel_OnClick(" + (intRowCount + 1).ToString + ")' Title='Cancel' >Cancel</A>")
            sbHtml.Append("</td></tr>")
        End If

        sbHtml.Append("</Table>" + vbCrLf)
        sbHtml.Append("</Div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)

        Call DrawAssignedTasks()
        CommonFunction.General.WriteHTML("</div>") 'PageDiv
        CommonFunction.General.WriteHTML(strMenu)
        sbHtml = Nothing
        CommonFunction.Data.DisposeDataReader(drTodaysTask)
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
        Dim arrMenu() As String = {"Add", "Save", "Submit Tasks", "Close", "?"}
        Dim arrMenuToolTip() As String = {"Add", "Save", "Submit Tasks", "Close", "Help"}
        Dim arrClientSideFunctions() As String = {"Add_OnClick()", "Save_OnClick()", "Submit_OnClick()", "Close_OnClick()", "OpenHelpPage('QuickTasks')"}

        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Return strMenu
    End Function
    Protected Sub DrawAssignedTasks()
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

        strSQL = "Exec usp_Sel_TodaysAssignedTasks '" + HttpContext.Current.Session("intUserID").ToString + "'"
        drAssignedTask = CommonFunction.Data.GetDataReader(strSQL, True)
        sbHtml.Append("<div ID=TaskDiv style='overflow:auto;width:100%;height:450px'>")
        sbHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>Assigned Tasks</TD></TR></TABLE><BR>" + vbCrLf)

        sbHtml.Append("<Table class='clsGridTable' width=99.9% cellspacing=0 cellpadding=0><TR class='clsTRColumnHeader'>" + vbCrLf)
        sbHtml.Append("<TD align=left>Project</TD><TD align=left>Description</TD><TD align=left>Task Type</TD><TD align=left>Activity</TD>" + vbCrLf)
        sbHtml.Append("<TD align=right>Work (hrs)</TD><TD align=right>Actual Work(Hrs)</TD></TR>" + vbCrLf)
        intCount = 0
        While drAssignedTask.Read
            sbHtml.Append("<Tr class='clsTREvenRow'>")
            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drAssignedTask("ProjectName").ToString)

            'Plot Hidden Controls 
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ATProjectID_" + intCount.ToString, "ATProjectID_" + intCount.ToString, , 50, 20, drAssignedTask("ProjectID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ATTaskTypeID_" + intCount.ToString, "ATTaskTypeID_" + intCount.ToString, , 50, 20, drAssignedTask("TaskTypeID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ATSubTaskTypeID_" + intCount.ToString, "ATSubTaskTypeID_" + intCount.ToString, , 50, 20, drAssignedTask("SubTaskTypeID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))

            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drAssignedTask("TaskName").ToString)
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drAssignedTask("ModuleName").ToString)
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            sbHtml.Append(drAssignedTask("SubTaskType").ToString)
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='right'>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("AssignedWork_" + intCount.ToString, "AssignedWork_" + intCount.ToString, , 50, 20, drAssignedTask("Work").ToString, "right", , True, , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='right'>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("WorkForDA_" + intCount.ToString, "WorkForDA_" + intCount.ToString, , 50, 20, , "right", , , , , , , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td>")

            sbHtml.Append("<td align='left'>")
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("AssignedTaskID_" + intCount.ToString, "AssignedTaskID_" + intCount.ToString, , 50, 20, drAssignedTask("TaskID").ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbHtml.Append("</td></tr>")
            intCount += 1
        End While

        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("AssignedTaskCount", "AssignedTaskCount", , 50, 20, intCount.ToString, "right", , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        strActualDA = CType(CommonFunction.Data.GetDataScalar("Exec usp_Get_TodaysActualDA '" + HttpContext.Current.Session("intUserID").ToString + "'", True), String)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("ActualDA", "ActualDA", , 50, 20, strActualDA, "right", , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

        sbHtml.Append("</Table><br>")
        sbHtml.Append("</div>")
        CommonFunction.General.WriteHTML(sbHtml.ToString)
        sbHtml = Nothing
        CommonFunction.Data.DisposeDataReader(drAssignedTask)

    End Sub
End Class
