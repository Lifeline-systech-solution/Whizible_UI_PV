Public Class Home_MyTaskList
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objGrid As New WebPage.Templates.AdvancedGrid
    Private WithEvents m_objReviewGrid As New WebPage.Templates.AdvancedGrid
    Private WithEvents m_objGridIssueList As New WebPage.Templates.AdvancedGrid
    Protected WithEvents txtContentTab As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected m_strContentTab As String = "Issues"
    Private m_GridName As StructGridName = New StructGridName
    Protected m_intTasksTotalNoOfRows As Integer
    Protected m_intReviewsTotalNoOfRows As Integer
    Protected m_intIssuesTotalNoOfRows As Integer
    Protected m_strProjectID As String
    Protected m_strTypeID As String
    Protected m_TaskOnHold As String = "0"

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    Public Structure StructGridName
        Dim strDumy As String
        Private Const TotalGrid As Integer = 3
        Public ReadOnly Property TASKS() As String
            Get
                TASKS = "Tasks"
            End Get
        End Property
        Public ReadOnly Property ISSUES() As String
            Get
                ISSUES = "Issues"
            End Get
        End Property
        Public ReadOnly Property REVIEWS() As String
            Get
                REVIEWS = "Reviews"
            End Get
        End Property
    End Structure
    Private Const MODE_APPROVE As String = "APPROVE"
    Private Enum GridIndex
        TASKS = 1
        ISSUES = 2
        REVIEWS = 3
        TOTAL_GRID = 3
    End Enum

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Protected Sub Page_Init()

        InitVariables()
        'CommonFunction.General.WriteHTML(GenerateMenu())
        DrawFilters()
        DrawPage()
        'CommonFunction.General.WriteHTML("<Table width='99.9%' cellspacing='0' cellpadding='0' class='clsTable'><TR class='clsTRSectionHeader'><TD align='left' width='20%'>Tasks</TD><TD width='80%'>&nbsp;</TD></TR><TR><TD colspan=2>")
        'PlotTasksGrid()
        'CommonFunction.General.WriteHTML("</TD></TR></Table>")
        'CommonFunction.General.WriteHTML("<BR>")
        'CommonFunction.General.WriteHTML("<Table width='99.9%' cellspacing='0' cellpadding='0' class='clsTable'><TR class='clsTRSectionHeader'><TD align='left' width='20%'>Tasks</TD><TD width='80%'>&nbsp;</TD></TR><TR><TD colspan=2>")
        'PlotIssuesGrid()
        'CommonFunction.General.WriteHTML("</TD></TR></Table>")
    End Sub

    Protected Sub InitVariables()
        If txtContentTab.Value <> "" Then
            m_strContentTab = Server.UrlDecode(txtContentTab.Value)
        Else
            m_strContentTab = m_GridName.TASKS
        End If
        If m_strContentTab = m_GridName.TASKS Then
            m_intTasksTotalNoOfRows = (CommonFunction.Data.GetDataSet("usp_sel_ProjectTasks_Home " + Session("intUserID").ToString, m_GridName.TASKS, , , MyBase.UseSQL)).Tables(m_GridName.TASKS).Rows.Count
        End If
        If m_strContentTab = m_GridName.ISSUES Then
            m_intIssuesTotalNoOfRows = (CommonFunction.Data.GetDataSet("usp_sel_Issues_Home " + Session("intUserID").ToString, m_GridName.ISSUES, , , MyBase.UseSQL)).Tables(m_GridName.ISSUES).Rows.Count
        End If

        m_strProjectID = CommonFunction.General.CheckIsNothing(Request.Form("cboProject"), "")
        m_strTypeID = CommonFunction.General.CheckIsNothing(Request.Form("cboType"), "")
    End Sub
    Protected Sub PlotTasksGrid()
        Dim blnShowCurrent, blnShowBaseline, blnShowActual As Boolean
        Dim blnIsChecked As Boolean
        Dim dtmTaskList_FromDate, dtmTaskList_ToDate As String
        Dim strSQLQuery As String
        Dim strSortByField, strAscOrDesc As String
        Dim drProjectCount As IDataReader
        Dim intProjectCount As Integer
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strShowCurrent, strShowBaseline As String
        Dim strShowActual As String
        Dim strGRID As String

        Dim m_arrstrToolTipForGrid() As String
        Dim arrstrGroupOnColumn() As String = {"ProjectName", "", "", ""}
        Dim arrstrActualList() As String = {"ProjectName", "Taskname", "StartDate", "EndDate"}
        Dim arrstrUserFriendlyList() As String = {"Project Name", "Task name", "Start Date", "End Date"}

        If m_strProjectID = "" Then
            strSQLQuery = "usp_sel_ProjectTasks_Home " + Session("intUserID").ToString
        Else
            strSQLQuery = "usp_sel_ProjectTasks_Home " + Session("intUserID").ToString + "," + m_strProjectID.ToString
        End If


        With m_objGrid
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            ' Commented by NitinVS on 15 Dec 2004
            ' To make apply different style based on IsCritical 
            '.TDStyleArray = arrstrToolTipForGrid
            .TDStyleArray = m_arrstrToolTipForGrid

            .UserFriendlyColumnArray = arrstrUserFriendlyList
            '.IgnoreHTMLEncode = "1"
            '-- Column Grouping
            '.ColumnGroupNameArray = arrColGroupNames
            '.ColumnGroupColumnsArray = arrColGroup
            '.ColumnGroupExpandedArray = arrColGroupExpanded
            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_OnClick"
            .ClientSideSortFunctionName = "Sort_OnClick"
            '.SortBy = m_strSortByField
            .SortOrder = "Asc"
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            '.RowLinkArray = arrstrRowLinkField
            .SQL = strSQLQuery
            .EmptyValueReplacement = "-"
            .DIVHeight = 450
            .returnHTML = True
            .UseSQL = True
            strGRID = .DrawGrid() ' Called from within the section below
        End With
        Response.Write(strGRID)
    End Sub
    Protected Sub PlotIssuesGrid()
        Dim blnShowCurrent, blnShowBaseline, blnShowActual As Boolean
        Dim blnIsChecked As Boolean
        Dim dtmTaskList_FromDate, dtmTaskList_ToDate As String
        Dim strSQLQuery As String
        Dim strSortByField, strAscOrDesc As String
        Dim drProjectCount As IDataReader
        Dim intProjectCount As Integer
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strShowCurrent, strShowBaseline As String
        Dim strShowActual As String
        Dim strGRID As String

        Dim m_arrstrToolTipForGrid() As String
        Dim arrstrGroupOnColumn() As String = {"ProjectName", "", "", ""}
        Dim arrstrActualList() As String = {"ProjectName", "Taskname", "StartDate", "EndDate"}
        Dim arrstrUserFriendlyList() As String = {"Project Name", "Issue Task", "Start Date", "End Date"}

        strSQLQuery = "usp_sel_Issues_Home " + Session("intUserID").ToString

        With m_objGrid
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            ' Commented by NitinVS on 15 Dec 2004
            ' To make apply different style based on IsCritical 
            '.TDStyleArray = arrstrToolTipForGrid
            .TDStyleArray = m_arrstrToolTipForGrid

            .UserFriendlyColumnArray = arrstrUserFriendlyList
            '.IgnoreHTMLEncode = "1"
            '-- Column Grouping
            '.ColumnGroupNameArray = arrColGroupNames
            '.ColumnGroupColumnsArray = arrColGroup
            '.ColumnGroupExpandedArray = arrColGroupExpanded
            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_OnClick"
            .ClientSideSortFunctionName = "Sort_OnClick"
            '.SortBy = m_strSortByField
            .SortOrder = "Asc"
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            '.RowLinkArray = arrstrRowLinkField
            .SQL = strSQLQuery
            .EmptyValueReplacement = "-"
            .DIVHeight = 450
            .returnHTML = True
            .UseSQL = True
            strGRID = .DrawGrid() ' Called from within the section below
        End With
        Response.Write(strGRID)
    End Sub
    Protected Sub TabContent()

        '=====================================================================
        ' Procedure Name        : TabContent()	
        ' Purpose               : Draw the tab button for detail page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : 4-Feb-2009
        ' Revisions             : 
        '=====================================================================

        CommonFunctions.General.WriteHTML("<ul id='countenttabs' class='shadetabs' valign='top'>")

        If m_strContentTab.ToUpper = m_GridName.TASKS.ToUpper Then
            CommonFunctions.General.WriteHTML("<li><a href='#' id=""" + m_GridName.TASKS + """ class = selected>" + m_GridName.TASKS + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.TASKS) + """)' id=""" + m_GridName.TASKS + """ >" + m_GridName.TASKS + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.ISSUES.ToUpper Then
            CommonFunctions.General.WriteHTML("<li><a href='#' id=""" + m_GridName.ISSUES + """ class = selected>" + m_GridName.ISSUES + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.ISSUES) + """)' id=""" + m_GridName.ISSUES + """ >" + m_GridName.ISSUES + " </a></li>&nbsp;")
        End If
        If m_strContentTab.ToUpper = m_GridName.REVIEWS.ToUpper Then
            CommonFunctions.General.WriteHTML("<li><a href='#' id=""" + m_GridName.REVIEWS + """ class = selected>" + m_GridName.REVIEWS + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.REVIEWS) + """)' id=""" + m_GridName.REVIEWS + """ >" + m_GridName.REVIEWS + " </a></li>&nbsp;")
        End If

        CommonFunctions.General.WriteHTML("</ul>")
    End Sub
    Protected Sub DrawPage()
        Dim intTotalNoOfGrid As Integer = GridIndex.TOTAL_GRID
        Dim intCount As Integer = 1
        ' CommonFunction.General.WriteHTML(PlotSearchControl())
        Call TabContent()
        CommonFunctions.General.WriteHTML("<div id=divList style='border:1px solid gray;width:100%;padding:2px;'>")
        CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
        While intTotalNoOfGrid >= intCount

            Select Case intCount
                Case GridIndex.TASKS
                    ' To plot Leave Approvals Grid
                    If m_intTasksTotalNoOfRows > 0 And m_strContentTab.ToUpper = m_GridName.TASKS.ToUpper Then
                        'CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTREven'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.TASKS + " </B></TD></TR></Table>")
                        'blnNoItemsFoundFlag = False
                        'If m_intTasksTotalNoOfRows > m_intPageSize Then
                        '    Call WritePaging(m_GridName.LEAVE, GridIndex.LEAVE)
                        'End If
                        'Call PlotTasksGrid()
                        Call Display_ToDoList_Tab()
                        'CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                        'CommonFunctions.General.WriteHTML("<TABLE  class='clsGridTable' border=0 cellspacing =1 width=99.9% ><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%'>Total Records :" + CType(m_intTasksTotalNoOfRows, String) + "</TD></TR></TABLE>")

                    End If
                Case GridIndex.ISSUES
                    ' To plot Resource TimeSheet Approvals Grid
                    If m_intIssuesTotalNoOfRows > 0 And m_strContentTab.ToUpper = m_GridName.ISSUES.ToUpper Then
                        'CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTREven'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.ISSUES + " </B></TD></TR></Table>")
                        'blnNoItemsFoundFlag = False
                        'If m_intResourceTimeSheetTotalNoOfRows > m_intPageSize Then
                        '    Call WritePaging(m_GridName.RESOURCE_TIMESHEET, GridIndex.RESOURCE_TIMESHEET)
                        'End If
                        'Call PlotIssuesGrid()
                        Call Display_IssuesList_Tab()
                        'CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                        'CommonFunctions.General.WriteHTML("<TABLE  class='clsGridTable' border=0 cellspacing =1 width=99.9% ><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%'>Total Records :" + CType(m_intIssuesTotalNoOfRows, String) + "</TD></TR></TABLE>")
                    End If
                Case GridIndex.REVIEWS
                    ' To plot Resource TimeSheet Approvals Grid
                    If m_strContentTab.ToUpper = m_GridName.REVIEWS.ToUpper Then
                        'CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTREven'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.REVIEWS + " </B></TD></TR></Table>")
                        'blnNoItemsFoundFlag = False
                        'If m_intResourceTimeSheetTotalNoOfRows > m_intPageSize Then
                        '    Call WritePaging(m_GridName.RESOURCE_TIMESHEET, GridIndex.RESOURCE_TIMESHEET)
                        'End If
                        Call Display_ReviewsList_Tab()
                        'CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                        'CommonFunctions.General.WriteHTML("<TABLE  class='clsGridTable' border=0 cellspacing =1 width=99.9% ><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%'>Total Records :" + CType(m_intIssuesTotalNoOfRows, String) + "</TD></TR></TABLE>")
                    End If

            End Select
            intCount += 1
        End While
        CommonFunctions.General.WriteHTML("</table></div>")

    End Sub

    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top and bottom menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 9:57 AM 9/17/2007
        ' Revisions             :
        '=====================================================================
        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        ArrTopMenuCaptionsList.Add("Back")
        ArrTopMenuToolTipsList.Add("Back")
        ArrTopMenuFunctionsList.Add("Back_OnClick()")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing
        Return m_objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
    End Function


    Protected Sub PlotHeadTag()
        CommonFunctions.General.PlotPageHeadTag("My Tasklist", , , , "<link rel=""stylesheet"" type=""text/css"" href=""../General/tabcontent.css"" />")
    End Sub

    Private Sub Display_ReviewsList_Tab()
        '=====================================================================
        ' Page Name             : Display_ReviewsList_Tab
        ' Purpose               : Draws the REVIEWS LIST Assigned to the user
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.DeveloperDB
        ' Author                : SuryabirD
        ' Created               : Feb 10, 2004
        ' Revisions             : 
        '=====================================================================


        Dim strSQL As String
        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"IsReviewee", "ProjectName", "ReviewType", "ReviewedDate", "ReviewedBy", "Reviewee", "ReviewEffort", "ReviewStatus"}
        'Purpose:Corrected spelling mistake in word 'Reviewwee'
        Dim arrstrUserFriendlyList() As String = {"", "Project Name", "Review Type", "Review Date", "Reviewer(s)", "Reviewee", "Work (hrs)", "Review Status"}
        'End modification

        '-- define the Style/Tool tip for each column
        Dim arrstrRowLinkField() As String = {"", "", "", "", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"", "Title='Project Name' ", "style='width=25%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'"}
        Dim arrstrIgnoreHTML() As String = {"", "1", "1"}
        
        Dim arrstrGroupOnColumn(0) As String '= {"1"}
        Dim strGRID As String
        Dim strSQLQuery As String
        Dim drReviews As IDataReader
        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("1")
        Else
            arrstrGroupOnColumn(0) = ""
        End If

        Response.Write("<TABLE ID='tblReview' cellspacing=1 border=0 width=99.9% >")
        Response.Write("<TR class=clsTREven><TD align=center>")

        ' Build the query to retrieve the list of reviews.
        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ", 8"
        strSQLQuery = strSQLQuery & ",' ORDER BY [IsReviewee], ProjectName asc'"
        strSQLQuery = strSQLQuery & ", '1 = 1 AND "

        If m_strProjectID <> "" Then
            strSQLQuery = strSQLQuery & " R.ProjectID = " & m_strProjectID.ToString & "  AND  "
        End If

        strSQL = " ((Reviewee +'','' Like ''%" + Replace(Session("strUserName").ToString, "'", "''''") + ",%'') OR (ReviewedBy +'','' Like ''%" + Replace(Session("strUserName").ToString, "'", "''''") + ",%''))'"

        '--Plotting the Grid 
        With m_objReviewGrid
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .RowLinkArray = arrstrRowLinkField
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .SQL = strSQLQuery + strSQL
            .EmptyValueReplacement = "-"
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 450
            .SortBy = "ProjectName"
            .SortOrder = "asc"
            .returnHTML = True
            .UseSQL = True
            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</td></tr>")
        Response.Write("</table>")
    End Sub

    Private Sub m_objReviewGrid_ColumnHeaderTD_BeforePrint1(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objReviewGrid.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "ISREVIEWEE" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
    End Sub
    Private Function PlotSearchControl() As String
        Dim sbHTML As New System.Text.StringBuilder

        sbHTML.Append("<table class='clsTable' cellspacing='0' cellpadding='0' style='width:99.9%;height:30px;border-color:black;border-width:1px;border-style:Solid'>")
        sbHTML.Append("<TR class='clsTROdd' valign='middle'>")
        sbHTML.Append("<td align='left'>")
        sbHTML.Append("<img border='0' valign='bottom' title='My Tasklist' style='cursor:hand;' src='../../Images/Home/Tasklist.gif'  onclick='MyTaskList_Click()'>&nbsp;&nbsp;")
        sbHTML.Append("<img border='0' valign='bottom' title='Pending Approvals' style='cursor:hand;' src='../../Images/Home/Approvals.gif' onclick='Approval_Click()'>&nbsp;&nbsp;")
        sbHTML.Append("<img border='0' valign='bottom' title='Last updated' style='cursor:hand;' src='../../Images/Home/LastUpdated.gif'  onclick='LastUpdated_Click()'>&nbsp;&nbsp;")
        sbHTML.Append("<td align='center' width='90%'>&nbsp;") ' <b>Search </b></td><td align=left>")
        'sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSearch", "txtSearch", , 400, 200, , returnHTML:=True, ToBeInserted:="onkeypress='Search_OnKeyPress(event)' "))

        'sbHTML.Append(" <a href='Javascript:Search_OnClick()' >")
        'sbHTML.Append("<img border='0' valign='bottom' align='absbottom' src='../../Images/Home/Search.gif' width='30' height='20' title='Search' onmouseover='this.src="" ../../Images/Home/Search.gif""' onmousedown='this.src="" ../../Images/Home/Search.gif""' onmouseout=' this.src="" ../../Images/Home/Search.gif""'></a>")
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right' width='5%' >")
        sbHTML.Append("<A align='right' href='JavaScript:Back_OnClick()' style='TEXT-DECORATION:none;font: 11px verdana' ><Img Border=0 src='../../Images/cssImages/Link images/back.gif'><BR><span class='clsSelected'>Back</SPAN></A>") 'style='TEXT-DECORATION:none'
        sbHTML.Append("</td>")
        sbHTML.Append("<td align='right' width='5%' >")
        sbHTML.Append("<A align='right' href='JavaScript:Filter_OnClick()' style='TEXT-DECORATION:none;font: 11px verdana' ><Img Border=0 src='../../Images/cssImages/Link images/Filter.gif'><BR> <span class='clsSelected'>Filters</SPAN></A>") 'style='TEXT-DECORATION:none'
        sbHTML.Append("</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</Table>")
        Return sbHTML.ToString

    End Function


    Private Sub DrawFilters()
        CommonFunction.General.WriteHTML("<DIV id='divFilters' style=""width=200px;display:none;border:blue 1px outset;"">")
        CommonFunction.General.WriteHTML("<table id='tblFilter' border='0' cellspacing=1 cellpadding=0 name='tblFilter' class='clsTable' width='100%'><TR class='clsTRPageFilters'><TD align='right'>Project </TD><TD align='left'>")
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & Session("intUserID").ToString, 200, m_strProjectID.ToString, , True, True))
        CommonFunction.General.WriteHTML("</TD>")
        'If m_strContentTab.ToUpper = m_GridName.TASKS.ToUpper Then
        '    CommonFunction.General.WriteHTML("<TD align='right'>Task Type </TD><TD align='left'>")
        '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboType", "usp_Get_TaskFilter_Attributes 'TT'", 200, , , True, True))
        '    CommonFunction.General.WriteHTML("</TD>")
        'End If
        'If m_strContentTab.ToUpper = m_GridName.ISSUES.ToUpper Then
        '    CommonFunction.General.WriteHTML("<TD align='right'>Issue Type </TD><TD align='left'>")
        '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboType", "usp_Get_TaskFilter_Attributes 'TT'", 200, , , True, True))
        '    CommonFunction.General.WriteHTML("</TD>")
        'End If
        'If m_strContentTab.ToUpper = m_GridName.REVIEWS.ToUpper Then
        '    CommonFunction.General.WriteHTML("<TD align='right'>Review Type </TD><TD align='left'>")
        '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboType", "usp_sel_tbl_PM_TaskTypes_Corporate", 200, , , True, True))
        '    CommonFunction.General.WriteHTML("</TD>")
        'End If
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr class='clsTRPageFilters'>")
        CommonFunction.General.WriteHTML("<td>&nbsp;")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td colspan='3'  style='text-align:center;' >")
        CommonFunction.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;FONT-SIZE: 10pt;' href='javascript:applyFilter(0)' >Apply</a>")
        CommonFunction.General.WriteHTML("&nbsp;&nbsp;<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;FONT-SIZE: 10pt;' href='javascript:Filter_OnClick()' >Cancel</a>")
        CommonFunction.General.WriteHTML("&nbsp;&nbsp;<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;FONT-SIZE: 10pt;' href='javascript:applyFilter(1)' >Clear</a>")
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</TABLE></DIV>")

    End Sub
    Private Sub Display_IssuesList_Tab()
        '-- define the Actual Array and UserFriendly array..
        Dim arrstrActualList() As String = {"ProjectName", "TaskName", "Issue_Priority", "Issue_Status", "Task_StartDate", "Task_EndDate", "Work", "Actualwork"}
        Dim arrstrUserFriendlyList() As String = {"", "Issue Task", "Priority", "Status", "Start Date", "End Date", "Work(Hrs)", "Actual Work(Hrs)"}
        '-- define the Style/Tool tip for each column
        Dim arrstrToolTipForGrid() As String = {"style='width:1%", "{}Title='[TaskNotes]' style='width:25%' align='left'", " nowrap ", "", "", "", " align=right ", " align=right "}
        'Dim arrstrRowLinkField() As String = {"", "BugDisplay(ProjectID,OtherTaskID)", "", "", "", "", "", ""}

        Dim arrstrTDStyle() As String = {"", "{}Title='[TaskNotes]' style='width:25%' align='left'", " nowrap ", "", "", "", " align=right "}
        Dim arrstrGroupOnColumn(0) As String '= {"1"}
        Dim arrstrIgnoreHTML() As String = {"", "0", "0"}

        Dim strGRID As String
        Dim strSQLQuery As String

        If CType(Session("ShowFlag"), Int16) = 0 Then
            arrstrGroupOnColumn(0) = ("1")
        Else
            arrstrGroupOnColumn(0) = ""
        End If

        Response.Write("<TABLE ID='Bug' cellspacing=1 border=0 width=99.9% >")

        Response.Write("<TR class=clsTREven ><TD align=center>")

        'fire a query which will return you the all the tasks for a selected person for that particular day
        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",2"
        strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName asc'"
        If m_strProjectID <> "" Then
            strSQLQuery = strSQLQuery & ", 'A.ProjectID = " & m_strProjectID.ToString & "'"
        End If
        '--Plotting the Grid 
        With m_objGridIssueList
            '--Columns in the Grid
            .GroupOnColumn = arrstrGroupOnColumn
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            '.RowLinkArray = arrstrRowLinkField
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            .TDStyleArray = arrstrTDStyle 'arrstrToolTipForGrid
            .SQL = strSQLQuery
            '.EmptyValueReplacement = m_strNotSpecified
            .ColNameToolTipOnEachRow = True

            '-- Properties for Sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = "ProjectName"
            .SortOrder = "asc"
            .DIVHeight = 450
            .returnHTML = True
            .UseSQL = True

            strGRID = .DrawGrid()
        End With

        Response.Write(strGRID)
        Response.Write("</td></tr>")
        Response.Write("</table>")

        m_objGridIssueList = Nothing
    End Sub

    Private Sub m_objGridIssueList_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGridIssueList.ColumnHeaderTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "PROJECTNAME" Then
            If CType(Session("ShowFlag"), Int16) = 0 Then
                Args.ColumnName = "" : Args.ApplySorting = False
            Else
                Args.ColumnName = "Project Name" : Args.ApplySorting = True
            End If
        End If
        If Args.DataField.Trim.ToUpper = "TASKTYPELINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
        If Args.DataField.Trim.ToUpper = "DOCUMENTLINK" Then
            Args.ColumnName = "" : Args.ApplySorting = False
        End If
    End Sub

    'Private Sub m_objGridIssueList_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGridIssueList.DataRowTD_BeforePrint
    '    Dim txtOnHold As String
    '    Dim m_strToken As String
    '    Dim txtProjectOnHold As String
    '    Dim MapToProjectOnHold As Boolean
    '    Dim blnProjectTimesheetBlocked As Boolean = False

    '    'If Args.DataField.ToUpper = "TASKNAME" Then
    '    '    Cancel = True
    '    '    m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("OtherTaskID"), String) + CType(Session("intUserID"), String) + "0" + "0")

    '    '    Args.StringToBeInserted = "<TD align=center>" _
    '    '                  & "<A href=""JavaScript:BugDisplay('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("OtherTaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
    '    '    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(CType(Args.DataReader("TaskName"), String)) & "</A></TD>"
    '    'End If

    '    If Args.DataField.ToUpper = "TASKNAME" Then
    '        txtOnHold = "txtOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
    '        m_TaskOnHold = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskOnHold")), String).ToString.ToLower
    '        Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtOnHold, txtOnHold, , , , m_TaskOnHold, , , , , , True, , True))
    '        txtProjectOnHold = "txtProjectOnHold" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString
    '        MapToProjectOnHold = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("MapToProjectOnHold"), "0"), Boolean)
    '        Response.Write(CommonFunctions.HTMLControls.DrawTextBox(txtProjectOnHold, txtProjectOnHold, , , , MapToProjectOnHold, , , , , , True, , True))
    '        blnProjectTimesheetBlocked = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsProjectTimesheetBlocked"), "0"), Boolean)
    '        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, "txtProjectTimesheetBlocked" + CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")).ToString, , , , blnProjectTimesheetBlocked, , , , , , True, , True))

    '    End If

    '    Dim strClass As String

    '    'If Args.DataField.ToUpper = "FLAG" Then
    '    '    If Args.ColIndex = 1 Then
    '    '        Dim strSql As String
    '    '        Dim strFlagTo As String
    '    '        strSql = "Select FlagTo from tbl_PM_FlagForTracking where ContextType ='IB' and ContextID=" + CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID"))

    '    '        strFlagTo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()
    '    '        If strFlagTo = "1" Then
    '    '            Args.StringToBeInserted = "<TD Title ='Review' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
    '    '                                      & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
    '    '        ElseIf strFlagTo = "0" Then
    '    '            Args.StringToBeInserted = "<TD Title ='Follow Up' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
    '    '                                        & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
    '    '        Else
    '    '            Args.StringToBeInserted = "<TD Title ='Flag' class=" & strClass & " vAlign=top style='width:1%;color:red';>" _
    '    '                                         & "<A href=""JavaScript:Flag_Issue_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("IssueID")) & "')"">"
    '    '        End If
    '    '        'End
    '    '        Args.StringToBeInserted = Args.StringToBeInserted & CommonFunctions.General.CheckIsNothing(Args.DataReader("Flag")) & "</A></TD>"
    '    '        Cancel = True
    '    '    End If
    '    'End If
    '    'If Args.DataField.ToUpper = "TASK ENTRY" Then
    '    '    Cancel = True
    '    '    m_strToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("TaskID"), String) + CType(Session("intUserID"), String) + "0" + CType(1038, String))

    '    '    Args.StringToBeInserted = "<TD align=center>" _
    '    '                  & "<A href=""JavaScript:TaskLink_OnClick('" & CommonFunctions.General.CheckIsNothing(Args.DataReader("ProjectID")) & "','" & CommonFunctions.General.CheckIsNothing(Args.DataReader("TaskID")) & "','" & CommonFunctions.General.CheckIsNothing(m_strToken) & "')"">"
    '    '    Args.StringToBeInserted = Args.StringToBeInserted & "Task Entry" & "</A></TD>"

    '    'End If
    'End Sub

    Private Sub Display_ToDoList_Tab()
        Dim blnShowCurrent, blnShowBaseline, blnShowActual As Boolean
        Dim blnIsChecked As Boolean
        Dim dtmTaskList_FromDate, dtmTaskList_ToDate As String
        Dim strSQLQuery As String
        Dim strSortByField, strAscOrDesc As String
        Dim drProjectCount As IDataReader
        Dim intProjectCount As Integer
        Dim strGroupByField, strGroupByFieldValue As String
        Dim strShowCurrent As String
        Dim strShowBaseline As String = "1"
        Dim strShowActual As String = "1"
        strSQLQuery = "EXEC usp_DB_MenuOptions " & Session("intUserID").ToString & ",1"
        strSQLQuery = strSQLQuery & ",'ORDER BY ProjectName'"

        If m_strProjectID <> "" Then
            strSQLQuery = strSQLQuery & ", 'A.ProjectID = " & m_strProjectID.ToString & "'"
        Else
            strSQLQuery = strSQLQuery & ", NULL"
        End If

        drProjectCount = CommonFunctions.Data.GetDataReader(strSQLQuery & ", 1", True)
        If drProjectCount.Read Then
            intProjectCount = CType(drProjectCount("ProjectCount"), Integer)
        Else
            intProjectCount = 10
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectCount)

        strSQLQuery = strSQLQuery & ", 0"
        strSQLQuery = strSQLQuery & ", NULL"
        strSQLQuery = strSQLQuery & ", NULL"

        strGroupByField = "ProjectName"
        strGroupByFieldValue = ""

        Dim arrstrActualList() As String = {"ProjectName", "TaskName", "Priority", "BaselineStart", "BaselineEnd", "BaselineDuration", "BaselineWork", "ActualStartDate", "ActualWork", "Variance"}

        Dim arrstrUserFriendlyList() As String = {"Project Name", "Task Name", "Priority", "Start Date", "End Date", "Duration", "Work", "Start Date", "Work (hrs)", "Variance (hrs)"}

        'Dim arrstrLinkArray() As String = {"", "", "", "", "", "", "", "", "", "", ""}
        Dim arrColGroup() As String = {"1-3", "4-7", "8-9", "10"}
        Dim arrColGroupNames() As String = {"", "Baseline", "Actual", ""}
        Dim arrColGroupExpanded() As String = {"1", strShowBaseline, strShowActual, "1"}

        Dim arrstrGroupOnColumn() As String = {"1"}
        Dim arrstrIgnoreHTML() As String = {"1", "1"}
        'Dim arrstrRowLinkField() As String = {"", "TaskLink_OnClick(ProjectID,TaskID)", "", "", "", "", "", "", "", ""}
        Dim arrstrTDStyle() As String = {"style='width=1%'", "style='width=20%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=10%'", "style='width=9%'"}
        Dim strGRID As String
        
        With m_objGrid
            .GroupOnColumn = arrstrGroupOnColumn
            .ActualColumnArray = arrstrActualList
            .UserFriendlyColumnArray = arrstrUserFriendlyList
            .IgnoreHTMLEncode = arrstrIgnoreHTML
            '-- Column Grouping
            .ColumnGroupNameArray = arrColGroupNames
            .ColumnGroupColumnsArray = arrColGroup
            .ColumnGroupExpandedArray = arrColGroupExpanded
            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_OnClick"
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = "ProjectName"
            .SortOrder = "asc"
            .ColNameToolTipOnEachRow = True
            .NoOfDataColumns = arrstrUserFriendlyList.GetLength(0)
            '.RowLinkArray = arrstrRowLinkField
            .TDStyleArray = arrstrTDStyle
            .SQL = strSQLQuery
            .EmptyValueReplacement = "-"
            .DIVHeight = 450
            .returnHTML = True
            .UseSQL = True
            strGRID = .DrawGrid() ' Called from within the section below
        End With
        Response.Write(strGRID)
        m_objGrid = Nothing
    End Sub
End Class
