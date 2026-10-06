Public Class MyTaskList
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

    Private WithEvents m_objAdvGrid As New WebPage.Templates.AdvancedGrid
    Public AllTasks As String
    Public strTaskType As String
    '' Added by ParagD 23 Nov 2005
    Private m_strProjectFilters As String = ""
    '' End addition by ParagD 23 Nov 2005
    Public Sub PageInit()
        '====================================================================
        ' FunctionName Name            : PageInit
        ' Parameters Passed     : None
        ' Returns               : Boolean
        ' Parameters Affected   : None
        ' Purpose               : To Generate the daily activity view
        ' Description           : 
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : 
        ' Created               : VivekP
        ' Created Date          : 29 Apr 2005
        ' Revisions             :
        '=====================================================================

        '######### Page Code starts here
        Dim strGRID As String
        Dim arrstrUserFriendlyList As New ArrayList, arrstrRowLinkField As New ArrayList
        Dim arrColGroupNames As New ArrayList, arrColGroupExpanded As New ArrayList
        Dim arrstrIgnoreHTML As New ArrayList, arrColGroup As New ArrayList
        Dim arrstrGroupOnColumn As New ArrayList, arrstrTDStyle As New ArrayList
        Dim arrstrActualList As New ArrayList, arrstrSummaryFunctionsList As New ArrayList
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strGroup As String, strIsExpanded As String, strPageCaption As String
        Dim drTimesheetStatus As IDataReader, drActualHrs As IDataReader
        Dim arrGroupSummaryFunctions As New ArrayList
        Dim dblActualHrs As Double, dblExpectedHrs As Double, dblTotalHrs As Double
        Dim arrIgnoreHTMLEncode As New ArrayList
        Dim index As String
        Dim indexSub As String
        Dim m_OrderBy As String
        Dim m_Order As String
        Dim blnIncludeCompletedTasks As String = ""
        Dim strSQLQuery As String
        Dim dr As IDataReader
        Dim status As Integer = 0
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim arrMenu() As String = {"Close", "?"}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('PM_MYTASKLIST')"}
        Dim arrMenuToolTip() As String = {"Close", "Help"}

        Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))
        Response.Write("<BR>")
        Response.Write("<table CellSpacing='0' width='99.9%' class='clsTable'><TR class=clsTRPageCaption><TD align=Left><b>My Task List</b></td></tr></table>")


        Response.Write("<BR>")
        'Response.Write("<PRE>")
        Response.Write("<table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='100%'><td>")
        Response.Write("<center>")
        If Request.QueryString("ComboVal") <> "" Then
            index = Request.QueryString("ComboVal")

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''Response.Write("Task Filter : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "SELECT 'Assigned Tasks'  UNION SELECT 'General Tasks' UNION SELECT 'Issues Assigned' UNION SELECT 'MPP Tasks' ", 150, index, " onChange=ChangeStatus(this.value,cboSubCategory.value)", , True))
            Response.Write("Task Filter : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_sel_cboCategory", 150, index, " onChange=ChangeStatus(this.value,cboSubCategory.value)", , True))
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Else

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'Response.Write("Task Filter : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "SELECT 'Assigned Tasks'  UNION SELECT 'General Tasks' UNION SELECT 'Issues Assigned' UNION SELECT 'MPP Tasks' ", 150, , " onChange=ChangeStatus(this.value,cboSubCategory.value)", , True))
            Response.Write("Task Filter : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboCategory", "usp_sel_cboCategory", 150, , " onChange=ChangeStatus(this.value,cboSubCategory.value)", , True))
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        End If
        Response.Write("</td><td align=left>")
        If Request.QueryString("ComboSubVal") <> "" Then
            indexSub = Request.QueryString("ComboSubVal")

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''Response.Write("Is Task Completed : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory", "SELECT 'No' UNION SELECT 'Yes'  ", 50, indexSub, " onChange=ChangeSubStatus(this.value,cboCategory.value)", True, True))
            Response.Write("Is Task Completed : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory", "usp_sel_cboSubCategory", 50, indexSub, " onChange=ChangeSubStatus(this.value,cboCategory.value)", True, True))
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Else

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''Response.Write("Is Task Completed : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory", "SELECT 'No' UNION SELECT 'Yes'  ", 50, , " onChange=ChangeSubStatus(this.value,cboCategory.value)", True, True))
            Response.Write("Is Task Completed : &nbsp;" + CommonFunctions.HTMLControls.DrawComboBox("cboSubCategory", "usp_sel_cboSubCategory", 50, , " onChange=ChangeSubStatus(this.value,cboCategory.value)", True, True))
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        End If

        Response.Write("</center>")
        Response.Write("</td></tr></table>")
        Response.Write("<BR>")

        '' Added by ParagD 23 Nov 2005
        '' Purpose : RequestID = 164 - DSS
        Dim intRoleLevel As Integer
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
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
        '' End addition by ParagD 23 Nov 2005

        If Request.QueryString("ComboVal") <> "" Then
            strTaskType = Request.QueryString("ComboVal")
        Else
            strTaskType = "Assigned Tasks"
        End If
        If Request.QueryString("ComboSubVal") = "Yes" Then
            AllTasks = "Yes"
            blnIncludeCompletedTasks = "True"
        End If
        If Request.QueryString("ComboSubVal") = "No" Then
            blnIncludeCompletedTasks = "False"
            AllTasks = "No"
        End If


        If Not Request.QueryString("OrderBy") Is Nothing Then
            m_OrderBy = Request.QueryString("OrderBy")
        Else
            m_OrderBy = "TaskName"
        End If

        If Not Request.QueryString("ASCDESC") Is Nothing Then
            m_Order = Request.QueryString("ASCDESC")
        Else
            m_Order = "Desc"
        End If



        strSQLQuery = "Exec usp_Sel_Tasks_For_MyTaskList 0," + Session("intUserID").ToString
        'strSQLQuery = "Exec usp_Sel_Tasks_For_MyTaskList 0,586" ',1,NULL,NULL,NULL,--NULL, NULL, NULL, 1, NULL, ' AND IsTaskComplete = 0  ORDER BY ProjectName, TaskName ASC' "

        If strTaskType = "Assigned Tasks" Then
            ''Parag
            strSQLQuery = strSQLQuery & ",NULL,NULL,NULL,NULL,1"
        End If
        If strTaskType = "MPP Tasks" Then
            strSQLQuery = strSQLQuery & ",NULL,NULL,NULL,1,NULL"
        End If
        If strTaskType = "General Tasks" Then
            '' Added by ParagD 23 Nov 2005
            If intRoleLevel = 2 Then
                strSQLQuery = strSQLQuery & ",NULL,1," & "'" & m_strProjectFilters & "',NULL,NULL"
            Else
                strSQLQuery = strSQLQuery & ",NULL,1,NULL,NULL,NULL"
            End If

        End If
        If strTaskType = "Issues Assigned" Then
            strSQLQuery = strSQLQuery & ",1,NULL,NULL,NULL"
            strSQLQuery = strSQLQuery & ",NULL, NULL, NULL, NULL ,1, NULL,'"
        Else
        strSQLQuery = strSQLQuery & ",NULL, NULL, NULL, 1, NULL,'"
        End If
        '' End addition by ParagD 23 Nov 2005

        If blnIncludeCompletedTasks = "False" Then
            strSQLQuery = strSQLQuery & " AND IsTaskComplete = 0 "
        End If
        If blnIncludeCompletedTasks = "True" Then
            strSQLQuery = strSQLQuery & " AND IsTaskComplete = 1 "
        End If
        'strSQLQuery = strSQLQuery & " ORDER BY ProjectName, TaskName ASC' "
        If m_OrderBy = "ProjectName" Then
            strSQLQuery = strSQLQuery & " ORDER BY " + m_OrderBy + " " + m_Order + "'"
        Else
            If m_OrderBy = "ActualStartDate" Then
                strSQLQuery = strSQLQuery & " ORDER BY A.ActualStartDate " + m_Order + " '"
            Else
                strSQLQuery = strSQLQuery & " ORDER BY ProjectName," + m_OrderBy + " " + m_Order + "'"
            End If
        End If


        dr = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        strGroupByField = "ProjectName"
        strGroupByFieldValue = ""

        '-- Define the Actual Array and UserFriendly array..
        arrstrActualList.Add("ProjectName")
        arrstrUserFriendlyList.Add("Project")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=5%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        arrstrActualList.Add("TaskName")
        arrstrUserFriendlyList.Add("Task Name")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=20%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        arrstrActualList.Add("StartDate")
        arrstrUserFriendlyList.Add("Planned Start Date")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=5%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        arrstrActualList.Add("EndDate")
        arrstrUserFriendlyList.Add("Planned End Date")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=5%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        arrstrActualList.Add("Work")
        arrstrUserFriendlyList.Add("Planned Work[Hrs]")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("align=right style='width=5%'")
        arrstrSummaryFunctionsList.Add("SUM")
        arrGroupSummaryFunctions.Add("SUM")
        arrIgnoreHTMLEncode.Add("SUM")

        arrstrActualList.Add("ActualStartDate")
        arrstrUserFriendlyList.Add("Actual Start Date")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("style='width=5%'")
        arrstrSummaryFunctionsList.Add("")
        arrGroupSummaryFunctions.Add("")
        arrIgnoreHTMLEncode.Add("")

        'arrstrActualList.Add("ActualEndDate")
        'arrstrUserFriendlyList.Add("Actual End Date")
        'arrstrRowLinkField.Add("")
        'arrstrTDStyle.Add("style='width=5%'")
        'arrstrSummaryFunctionsList.Add("")
        'arrGroupSummaryFunctions.Add("")
        'arrIgnoreHTMLEncode.Add("")

        arrstrActualList.Add("ActualWork")
        arrstrUserFriendlyList.Add("Actual Work[Hrs]")
        arrstrRowLinkField.Add("")
        arrstrTDStyle.Add("align=right style='width=5%'")
        arrstrSummaryFunctionsList.Add("SUM")
        arrGroupSummaryFunctions.Add("SUM")
        arrIgnoreHTMLEncode.Add("SUM")



        arrstrGroupOnColumn.Add("2")



        '--Plotting the Timesheet Details Grid's properties
        If dr.Read Then
            With m_objAdvGrid

                .GroupOnColumn = GetArray(arrstrGroupOnColumn)
                .ActualColumnArray = GetArray(arrstrActualList)
                .TDStyleArray = GetArray(arrstrTDStyle)
                .UserFriendlyColumnArray = GetArray(arrstrUserFriendlyList)

                .ColNameToolTipOnEachRow = True
                .NoOfDataColumns = GetArray(arrstrUserFriendlyList).GetLength(0)
                .RowLinkArray = GetArray(arrstrRowLinkField)
                .SQL = strSQLQuery

                .GroupSummaryFunc = GetArray(arrGroupSummaryFunctions)
                .SummaryFunctions = GetArray(arrstrSummaryFunctionsList)
                .ShowSummaryFunctions = True
                .SortBy = m_OrderBy
                .SortOrder = m_Order
                .DIVID = "DivList"
                'Commented And Added By Vaijat K On 18/11/2015
                '.DIVStyle = "overflow:auto;width:870"
                .DIVStyle = "overflow:auto;"
                .DIVHeight = 390
                '.DIVStyle = "overflow:auto"
                .ClientSideSortFunctionName = "Sort_OnClick"
                .IgnoreHTMLEncode = GetArray(arrIgnoreHTMLEncode)
                .returnHTML = True
                .UseSQL = MyBase.UseSQL
                .EmptyValueReplacement = "N/A"
                strGRID = .DrawGrid()
                Response.Write(strGRID)

            End With
            status = 1
        End If
        If status = 0 Then
            If status = 0 Then
                Response.Write("<DIV id=DivList style='overflow:auto;Height:390'><table CellSpacing='0' width='99.9%'><tr class='clsTREven' width='100%'><td width='100%' align=middle>There is no items in this view.</td></tr></table></div>")
                'Response.Write("<table CellSpacing='0' width='100%'><tr class='clsTREven' width='100%'><td width='100%' align=middle>There is no items in this view.</td></tr></table>")
            End If

        End If
        Response.Write(objMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))

        CommonFunction.Data.DisposeDataReader(dr)
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
        ' Author                : VivekP
        ' Created               : 25 Apr 2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Sub m_objAdvGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles m_objAdvGrid.DataRowTD_AfterPrint
        
    End Sub
    'Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
    Private Sub m_objAdvGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objAdvGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "TASKNAME" Then
            If Args.DataReader("IsUserStoryTask").ToString.ToUpper = "TRUE" Then
                Cancel = True
                Args.StringToBeInserted += "<TD  vAlign=top style='width=20%' title=""Task Name"">"
                Args.StringToBeInserted += "<IMG src=""../../Images/Scrum/UserStory.gif""> " + Args.DataReader("TaskName")
                Args.StringToBeInserted += "</td>"
            End If
        End If
    End Sub
    'End - Added by NitinC on 08 June 2011 for WhizibleSEM 10.0 for Agile Methodology
End Class
