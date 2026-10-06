Imports System.Drawing
Public Class ScrumDashBoard
    Inherits Whiz.WebPage.Templates.ProjectByNetTemplate

    '--- Constant for Graph Directory
    Private Const GRAPH_DIRECTORY As String = "../../images/BrickRed/"
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer

    Private m_intChartAreaWidth As Integer
    Private m_intChartArea_X_Position As Integer
    Private m_intChartArea_Y_Position As Integer
    Private m_intInnerPlotPosition_X As Integer
    Private m_intInnerPlotPosition_Y As Integer

    Private m_strPalleteSytle As String
    Private m_TabName As String

    Private m_ProjectID As String
    Private m_intUserID As String
    Private m_LoginType As String
    Private m_UserName As String
    Protected m_PKToken_Edit As String
    Private m_SummaryTaskStatus As String
    Private m_ProjectTaskStatus As String
    Private m_SummaryIssueStatus As String
    Private m_ProjectIssueStatus As String
    Private m_SummaryIssueType As String
    Private m_div_ProjectIssues As String
    Private m_div_ProjectTask As String
    Private m_ProjectTimeSheet_Result As String
    Private m_ProjectTimeSheet_Status As String
    Private Mode_Notification As String
    Private m_WeeklyStatus As String

    Private m_ProjectTeamDetail As String
    Private m_CurrWeekStartDate As String
    Private m_PrevWeekStartDate As String
    Private m_SummaryIssueCriteria As String
    Private m_IssueNextLastToday As String

    Private m_CurrWeekStartDateTask As String
    Private m_PrevWeekStartDateTask As String
    Private m_SummaryIssueCriteriaTask As String
    Private m_IssueNextLastTodayTask As String

    Protected m_Deliverables_Search As String
    Protected m_Milestones_Search As String
    Protected m_div_Deliverables As String
    Protected m_div_Milestones As String

    Private Mode_TimeSheetDetail As String

    Private Mode_WSRTimeSheetDetail As String
    'Accept/Reject Timesheet
    Protected strTimeSheetList As String
    Dim Mode_ApproveReject As String
    'Till Here
    Protected m_strTabCount As String

    'CSS for Links on each page
    Private strLinkCss As String = "STYLE='padding-right: 3px;padding-left: 3px;padding-bottom: 3px;padding-top: 1px;border-top-width: 0px;font-weight: lighter;border-left-width: 0px;font-size: 10px;border-left-color: white;border-bottom-width: 0px;border-bottom-color: white;color: black;border-top-color: white;font-family: Verdana, Arial;border-right-width: 0px;text-decoration: none;border-right-color: white;'"


    ''ADDED BY AMIT MAHADIK 0N 11 MAY 2011 WHIZIBLE SEM 10.0,For dashboard
    Dim m_strProjectName As String
    ''END ADDED BY AMIT MAHADIK 0N 11 MAY 2011 WHIZIBLE SEM 10.0,For dashboard

    ''Added by NitinC 
    Protected m_IterationID As String
    Protected m_SeverityID As String
    Protected m_strToken As String = ""
    Protected ProjectID As String = ""
    ''End of added by NitinC
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
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting
        'If Not Request.QueryString("ProjectID") Is Nothing Then
        '    ProjectID = Request.QueryString("ProjectID").ToString
        'Else
        '    ProjectID = 0
        'End If

    End Sub

    Public Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage()
        ' Purpose               : To  Draw  Page for current logged in user.
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Call GetValueDetails()
        If (Mode_Notification = "True") Then
            Call PlotControls_Notification_Timesheet()
        ElseIf (Mode_TimeSheetDetail = "True") Then
            Call PlotControls_Timesheet_Details()
        ElseIf (Mode_WSRTimeSheetDetail = "True") Then
            Call PlotControls_WSR()
        ElseIf Request.QueryString("ToApprove") = "ToApprove" Or Request.QueryString("ToReject") = "ToReject" Then
            Call PlotGridApprovedOrReject()
        ElseIf (Request.QueryString("Mode_ApproveReject") = "Approve") Then
            'Call PlotGridApprovedOrReject()
            Call Authenticate_Timesheet()
        ElseIf (Request.QueryString("Mode_ApproveReject") = "Reject") Then
            Call PlotGridApprovedOrReject()
            Call Reject_Timesheet()
        Else

            '''DELETED BY AMIT MAHADIK ON 11 MAY 2011 WHIZIBLE SEM 10.0 ,DISPALY:NONE;
            ''''Call DrawDashBoardComboBox()
            '''END DELETED BY AMIT MAHADIK ON 11 MAY 2011 WHIZIBLE SEM 10.0 ,DISPALY:NONE;

            '''ADDED BY AMIT MAHADIK ON 11 MAY 2011 WHIZIBLE SEM 10.0 ,DISPALY:NONE;
            Call DrawDashBoardProjectListComboBox()
            '''END ADDED BY AMIT MAHADIK ON 11 MAY 2011 WHIZIBLE SEM 10.0 ,DISPALY:NONE;

            ''Added by NitinC
            ''Added by NitinC
            If Not Request.QueryString("ProjectID") Is Nothing Then
                ProjectID = Request.QueryString("ProjectID").ToString
            Else
                ProjectID = 0
            End If
            ProjectID = m_ProjectID
            If Not Request.QueryString("IterationID") Is Nothing Then
                m_IterationID = Request.QueryString("IterationID").ToString
            Else
                m_IterationID = "0"
            End If
            If Not Request.QueryString("SeverityID") Is Nothing Then
                m_SeverityID = Request.QueryString("SeverityID").ToString
            Else
                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'm_SeverityID = CType(CommonFunctions.Data.GetDataScalar("select top 1 StatusOfStatusId,StatusOfStatus from tbl_ib_status_for_status WITH(NOLOCK)", MyBase.UseSQL), String)
                m_SeverityID = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_ib_status_for_status_StatusOfStatusId", MyBase.UseSQL), String)
                ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            End If
            ''End of added by NitinC

            ''End of added by NitinC
            '''MODIFIED BY AMIT MAHADIK ON 11 MAY 2011 WHIZIBLE SEM 10.0 ,DISPALY:NONE;
            CommonFunctions.General.WriteHTML("<div id='tab_111' style='width:99.99%;overflow-x:auto;height=45px;display:none;'>")
            '''END MODIFIED BY AMIT MAHADIK ON 11 MAY 2011 WHIZIBLE SEM 10.0 ,DISPALY:NONE;
            CommonFunctions.General.WriteHTML("<table width='100%'  'border='0' cellspacing='0' cellpadding='0' >")
            Call DrawMainTabs()
            Call DrawLegend()
            If (m_TabName = "" Or m_TabName.ToLower = "summary") Then
                Dim strLevel As String
                strLevel = CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_ScrumDashboard_RoleLevel " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID, MyBase.UseSQL)
                If strLevel = 1 Or strLevel = 2 Or CType(Session("intPostID"), Integer) = 1 Then
                    Call DrawScrumDashbordHigherLevel()
                Else
                    Call DrawScrumDashbordLowerLevel()
                End If
            Else
                'Call DrawProjectPage()
                Dim strLevel As String
                strLevel = CommonFunctions.Data.GetDataScalar("EXEC usp_Sel_ScrumDashboard_RoleLevel " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID, MyBase.UseSQL)
                If strLevel = 1 Or strLevel = 2 Or CType(Session("intPostID"), Integer) = 1 Then
                    Call DrawScrumDashbordHigherLevel()
                Else
                    Call DrawScrumDashbordLowerLevel()
                End If

            End If
        End If
    End Sub
    'Added by NitinC
    Private Sub DrawScrumDashbordLowerLevel()
        '=====================================================================
        ' Procedure Name        : DrawProjectPage()
        ' Purpose               : To  Draw the Page if user has selected any projects from the main tabs
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinC
        ' Created               : 20 Oct 2011
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String   '        m_div_ProjectIssues,m_div_ProjectTask
        Dim strDeliverableLastWeek As String
        Dim strDeliverableNextWeek As String
        Dim strDeliverableAll As String

        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div_RecentActivity'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>Recent Activity</li></ul>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        'CommonFunctions.General.WriteHTML("<div style=""padding-right: 0px;padding-left: 0px;background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top;padding-bottom: 10px;padding-top: 15px;height: 499px;"">")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")

        ''FOR Recent Activity
        Dim strSQLRecentActivity As String
        Dim drRecentActivity As IDataReader
        strSQLRecentActivity = "usp_Sel_ScrumDashboard_RecentActivity " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        drRecentActivity = CommonFunctions.Data.GetDataReader(strSQLRecentActivity, MyBase.UseSQL)
        Do While drRecentActivity.Read
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td colspan=""2"" style=""padding-right: 5px;padding-left: 9px;font-weight: bold;font-size: 12px;padding-bottom: 0px;line-height: 25px;padding-top: 0px;"">")
            CommonFunctions.General.WriteHTML("<font color=""blue""><b>Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("IssueID"), "0"), String) + "&nbsp;</b></font><b>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("Summary")), ""), String) + "</b></td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            'CommonFunctions.General.WriteHTML("<TD valign=top title='' style='padding-right: 5px;padding-left: 9px;' >")
            'CommonFunctions.General.WriteHTML("<BR>")
            'CommonFunctions.General.WriteHTML("<img name = EmployeeImage src='" + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("ImagePath"), "../../Images/NoPreview.gif"), String) + "' border = 0 height = 75 width = 75>")
            'CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<td style='padding-right: 30px;padding-top: 0px;height: 25px;font-size: 12px;line-height: 18px;font-family: Arial, Helvetica, sans-serif;'>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("Comment1"), ""), String) + " <font color='blue'><b>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("UserName"), ""), String) + "</b></font>, " + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("ProjectName")), ""), String) + " Team<br />""" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("Comment2")), ""), String) + """</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr><td><hr /></td><td><hr /></td> </tr>")
        Loop
        drRecentActivity = Nothing


        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td>")
        'Below HTML is for My Tasks and My Defects
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div_ProjectTask'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>My Tasks</li></ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")
        ''To Fill Drop Down 
        strSQL = "select 'All' AS employeeID,'All' AS EmployeeName union  "
        strSQL += "select DISTINCT(E.EmployeeName), E.EmployeeName "
        strSQL += "from tbl_PM_Projecttasks T With (noLock)   "
        strSQL += "left join tbl_PM_Employee E  With (noLock) on T.EmployeeID = E.EmployeeID  "
        strSQL += "Left Join tbl_PM_Project  With (noLock)  on T.ProjectID=tbl_PM_Project.ProjectID "
        strSQL += "where tbl_PM_Project.ProjectID=" + m_ProjectID + " AND  E.EmployeeName IS NOT NULL" '(parenttask_uid,0) >=  "
        '   strSQL += "case when Whichtask = 'o' and CRMQueryID IS NULL then 1 else 0 end" ' ORDER BY e.employeeID

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectTaskStatus", strSQL, 120, m_ProjectTaskStatus, "onchange=""JavaScript:OnProjectTaskStatusChange('Project'," + m_ProjectID + ",'div_ProjectTask');""", False, , "field")

        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div style='padding-right: 0px; padding-left: 0px; background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top; padding-bottom: 10px; overflow: auto; padding-top: 15px; height: 190px;'>")

        Call DrawGridTasks("Project")

        CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("<br />")

        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div_ProjectIssues'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>My Defects</li></ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectIssueStatus", strSQL, 120, m_ProjectIssueStatus, "onchange=""JavaScript:OnProjectIsssueStatusChange('Project'," + m_ProjectID + ",'div_ProjectIssues');""", False, , "field")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'><div class='purp_grad1_PPDB'>")
        Call DrawGridIssues("Project")

        CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("<br />")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%'  border='0' cellspacing='0' cellpadding='0'><tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<ul><li class='normal'>Open Defects</li></ul>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div id='div2'style='padding-right: 0px;	padding-left: 0px;background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top;padding-bottom: 10px;padding-top: 15px;height: 80px;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td></td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        Dim OpenDefects As String
        OpenDefects = CType(CommonFunction.Data.GetDataScalar("usp_Sel_ScrumDashboard_GetOpenDefects " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID, MyBase.UseSQL), String)
        CommonFunctions.General.WriteHTML("<td style='padding-right: 5px;padding-left: 9px;font-size: 20px;padding-bottom: 0px;padding-top: 0px;height: 25px;' align='center'>" + OpenDefects + "</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td></td><td><br /></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='divIterationBurnDown'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='normal'>Iteration BurnDown</li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results: ")
        ''To Fill Drop Down for Iteration Graph

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "select IterationID,IterationName from tbl_PM_Scrumiteration where ProjectID= " + m_ProjectID + " order by IterationName"
        strSQL = "usp_sel_tbl_PM_Scrumiteration_IterationID_IterationName " + m_ProjectID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.HTMLControls.DrawComboBox("cboIteration", strSQL, 170, CommonFunctions.General.CheckIsNothing(CType(m_IterationID, String), ""), "onchange=""JavaScript:ShowIterationGraph('Project'," + m_ProjectID + ",0,'" + m_strProjectName + "');""", False, , "field")

        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        'If Not m_IterationID Is Nothing Then
        Call CreateGraph("IterationGraph")
        'End If
        '<IMG HEIGHT=250 WIDTH=450 src='../../images/BrickRed/9dd76df8.png'>
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='div_DefectsBySeverity'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='normal'>Defects By Severity</li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results :")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "select StatusOfStatusId,StatusOfStatus from tbl_ib_status_for_status WITH(NOLOCK) "
        strSQL = "usp_sel_tbl_ib_status_for_status_StatusOfStatusId_StatusOfStatus "
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, 120, CommonFunctions.General.CheckIsNothing(CType(m_SeverityID, String), ""), "onchange=""JavaScript:ShowSeverityGraph('Project'," + m_ProjectID + ",0,'" + m_strProjectName + "');""", False, , "field")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        '<IMG HEIGHT=250 WIDTH=450 src='../../images/BrickRed/9dd76df8.png'>
        Call CreateGraph("BugsBySeverityGraph")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")


        ''''''''''''''''''''''


        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        'CommonFunctions.General.WriteHTML("<div style='display:" + m_div_ProjectTask + ";' id='div_ProjectTask'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_ProjectTask','div_ProjectIssues');>Tasks</a></li>")
        'CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('div_ProjectIssues','div_ProjectTask');>Issues</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        'strSQL = "select 'All' AS employeeID,'All' AS EmployeeName union  "
        'strSQL += "select DISTINCT(E.EmployeeName), E.EmployeeName "
        'strSQL += "from tbl_PM_Projecttasks T With (noLock)   "
        'strSQL += "left join tbl_PM_Employee E  With (noLock) on T.EmployeeID = E.EmployeeID  "
        'strSQL += "Left Join tbl_PM_Project  With (noLock)  on T.ProjectID=tbl_PM_Project.ProjectID "
        'strSQL += "where tbl_PM_Project.ProjectID=" + m_ProjectID + " AND  E.EmployeeName IS NOT NULL" '(parenttask_uid,0) >=  "
        ''   strSQL += "case when Whichtask = 'o' and CRMQueryID IS NULL then 1 else 0 end" ' ORDER BY e.employeeID

        'CommonFunctions.HTMLControls.DrawComboBox("cboProjectTaskStatus", strSQL, 120, m_ProjectTaskStatus, "onchange=""JavaScript:OnProjectTaskStatusChange('Project'," + m_ProjectID + ",'div_ProjectTask');""", False, , "field")


        'CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1'>")
        'CommonFunctions.General.WriteHTML("<div class='blue_grad1_PPDB'>")
        'Call DrawGridTasks("Project")
        'CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")

        'CommonFunctions.General.WriteHTML("<div style='display:" + m_div_ProjectIssues + ";' id='div_ProjectIssues'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('div_ProjectTask','div_ProjectIssues')>Tasks</a></li>")
        'CommonFunctions.General.WriteHTML("<li class='current1' ><a href=javascript:ShowHide_SubTabs('div_ProjectIssues','div_ProjectTask')>Issues</a></li> ")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        'CommonFunctions.HTMLControls.DrawComboBox("cboProjectIssueStatus", strSQL, 120, m_ProjectIssueStatus, "onchange=""JavaScript:OnProjectIsssueStatusChange('Project'," + m_ProjectID + ",'div_ProjectIssues');""", False, , "field")

        'CommonFunctions.General.WriteHTML(" </td>")
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1'><div class='purp_grad1_PPDB'>")

        'Call DrawGridIssues("Project")

        'CommonFunctions.General.WriteHTML("</div></td></tr></table></div></td>")

        'CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        'CommonFunctions.General.WriteHTML("<div id='divtag_Deliverables' style='display:" + m_div_Deliverables + "'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr><td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        'CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")

        ''Added By VijayD oN 28 July 2008
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        '' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        'If (m_Deliverables_Search <> "Last Week") Then
        '    strDeliverableLastWeek = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Milestones_Search + "');"">Last Week</A>"
        'Else
        '    strDeliverableLastWeek = "Last Week"
        'End If
        'If (m_Deliverables_Search <> "Next Week") Then
        '    strDeliverableNextWeek = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Milestones_Search + "');"">Next Week</A>"
        'Else
        '    strDeliverableNextWeek = "Next Week"
        'End If
        'If (m_Deliverables_Search <> "All") Then
        '    strDeliverableAll = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Milestones_Search + "');"">All</A>"
        'Else
        '    strDeliverableAll = "All"
        'End If
        ''Hidden Field
        ''CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        'CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        ''Added By VijayD oN 28 July 2008

        'CommonFunctions.General.WriteHTML("</td>") '<td class='options_text_PPDB' align='right'>&nbsp;
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td class='border1'>") 'class='milestone'
        'CommonFunctions.General.WriteHTML("<div id='div_Deliverables'class='blue_grad1_PPDB'>") 'Extra Addition By VijayD  
        'Call DrawDeliverablesDetails()

        'CommonFunctions.General.WriteHTML("</DIV>") 'Extra Addition By VijayD <br>
        'CommonFunctions.General.WriteHTML("</td></tr></table></div>")


        'CommonFunctions.General.WriteHTML("<div id='divtag_Milestones' style='display:" + m_div_Milestones + "'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        'CommonFunctions.General.WriteHTML("</ul>") '</td>

        ''Added By VijayD oN 28 July 2008
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        '' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        'If (m_Milestones_Search <> "Last Week") Then
        '    strDeliverableLastWeek = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Deliverables_Search + "');"">Last Week</A>"
        'Else
        '    strDeliverableLastWeek = "Last Week"
        'End If
        'If (m_Milestones_Search <> "Next Week") Then
        '    strDeliverableNextWeek = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Deliverables_Search + "');"">Next Week</A>"
        'Else
        '    strDeliverableNextWeek = "Next Week"
        'End If
        'If (m_Milestones_Search <> "All") Then
        '    strDeliverableAll = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Deliverables_Search + "');"">All</A>"
        'Else
        '    strDeliverableAll = "All"
        'End If
        ''Hidden Field
        ''CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        'CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        ''Added By VijayD oN 28 July 2008

        'CommonFunctions.General.WriteHTML("</td>") '<td class='options_text_PPDB' align='right'>&nbsp;
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td class='border1'>") 'class='milestone'
        'CommonFunctions.General.WriteHTML("<div id='div_MileStones' class='blue_grad1_PPDB'>") 'Extra Addition By VijayD
        'Call DrawMileStonesDetails()
        'CommonFunctions.General.WriteHTML("</div>") 'Extra Addition By VijayD
        'CommonFunctions.General.WriteHTML("</td></tr></table></div></td></tr></table><br>")

        'Call DrawTimeSheetDetails()
        'Call DrawWeeklyStatusDetails()
        'Call DrawTeamDetailPage()

        'CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        'CommonFunctions.General.WriteHTML("<div id='div_Issue_Graph'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('div_Task_Graph','div_Issue_Graph')>Task Graph</a></li>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_Issue_Graph','div_Task_Graph')>Issues Graph</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        'CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        'Call CreateGraph("IssueGraph")
        'CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")


        'CommonFunctions.General.WriteHTML("<div style='display:none;' id='div_Task_Graph'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_Task_Graph','div_Issue_Graph')>Task Graph</a></li>")
        'CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('div_Issue_Graph','div_Task_Graph')>Issues Graph</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        'CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        'Call CreateGraph("TaskGraph")
        'CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div></td></tr></table></div>")

        'CommonFunctions.General.WriteHTML("</td></tr></table></div>")
    End Sub

    Private Sub DrawScrumDashbordHigherLevel()
        '=====================================================================
        ' Procedure Name        : DrawProjectPage()
        ' Purpose               : To  Draw the Page if user has selected any projects from the main tabs
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinC
        ' Created               : 20 Oct 2011
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String   '        m_div_ProjectIssues,m_div_ProjectTask
        Dim strDeliverableLastWeek As String
        Dim strDeliverableNextWeek As String
        Dim strDeliverableAll As String

        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div_RecentActivity'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>Recent Activity</li></ul>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div style=""padding-right: 0px;padding-left: 0px;background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top;padding-bottom: 10px;padding-top: 15px;height: 499px;"">")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")

        ''FOR Recent Activity
        Dim strSQLRecentActivity As String
        Dim drRecentActivity As IDataReader
        strSQLRecentActivity = "usp_Sel_ScrumDashboard_RecentActivity " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        drRecentActivity = CommonFunctions.Data.GetDataReader(strSQLRecentActivity, MyBase.UseSQL)
        Do While drRecentActivity.Read
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td colspan=""2"" style=""padding-right: 5px;padding-left: 9px;font-weight: bold;font-size: 12px;padding-bottom: 0px;line-height: 25px;padding-top: 0px;"">")
            CommonFunctions.General.WriteHTML("<font color=""blue""><b>Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("IssueID"), "0"), String) + "&nbsp;</b></font><b>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("Summary")), ""), String) + "</b></td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            'CommonFunctions.General.WriteHTML("<TD valign=top title='' style='padding-right: 5px;padding-left: 9px;' >")
            'CommonFunctions.General.WriteHTML("<BR>")
            'CommonFunctions.General.WriteHTML("<img name = EmployeeImage src='" + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("ImagePath"), "../../Images/NoPreview.gif"), String) + "' border = 0 height = 75 width = 75>")
            'CommonFunctions.General.WriteHTML("</TD>")
            m_strToken = CommonFunctions.Security.Token.GetToken(CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("IssueID"), "0"), String) + CType(Session("intUserID"), String) + "0" + "0")
            CommonFunctions.General.WriteHTML("<td style='padding-right: 30px;padding-top: 0px;height: 25px;font-size: 12px;line-height: 18px;font-family: Arial, Helvetica, sans-serif;'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("Comment1")), ""), String) + " <font color='blue'><b>" + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("UserName"), ""), String) + "</b></font>, " + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("ProjectName")), ""), String) + " Team<br />""" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drRecentActivity("Comment2")), ""), String) + """<br /><font color=""blue""><A href=""JavaScript:DiscussionThread_OnClick('" + CType(CommonFunctions.Data.CheckIsDBNull(drRecentActivity("IssueID"), "0"), String) + "','" + m_strToken + "')"" >Reply</A></font></td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr><td><hr /></td><td><hr /></td> </tr>")
        Loop
        drRecentActivity = Nothing


        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td>")
        'Below HTML is for My Tasks and My Defects
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div_ProjectTask'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>My Tasks</li></ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")
        ''To Fill Drop Down 
        strSQL = "select 'All' AS employeeID,'All' AS EmployeeName union  "
        strSQL += "select DISTINCT(E.EmployeeName), E.EmployeeName "
        strSQL += "from tbl_PM_Projecttasks T With (noLock)   "
        strSQL += "left join tbl_PM_Employee E  With (noLock) on T.EmployeeID = E.EmployeeID  "
        strSQL += "Left Join tbl_PM_Project  With (noLock)  on T.ProjectID=tbl_PM_Project.ProjectID "
        strSQL += "where tbl_PM_Project.ProjectID=" + m_ProjectID + " AND  E.EmployeeName IS NOT NULL" '(parenttask_uid,0) >=  "
        '   strSQL += "case when Whichtask = 'o' and CRMQueryID IS NULL then 1 else 0 end" ' ORDER BY e.employeeID

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectTaskStatus", strSQL, 120, m_ProjectTaskStatus, "onchange=""JavaScript:OnProjectTaskStatusChange('Project'," + m_ProjectID + ",'div_ProjectTask');""", False, , "field")

        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div style='padding-right: 0px; padding-left: 0px; background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top; padding-bottom: 10px; overflow: auto; padding-top: 15px; height: 190px;'>")

        Call DrawGridTasks("Project")

        CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("<br />")

        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div_ProjectIssues'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>My Defects</li></ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectIssueStatus", strSQL, 120, m_ProjectIssueStatus, "onchange=""JavaScript:OnProjectIsssueStatusChange('Project'," + m_ProjectID + ",'div_ProjectIssues');""", False, , "field")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'><div class='purp_grad1_PPDB'>")
        Call DrawGridIssues("Project")

        CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("<br />")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%'  border='0' cellspacing='0' cellpadding='0'><tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<ul><li class='normal'>Open Defects</li></ul>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div id='div2'style='padding-right: 0px;	padding-left: 0px;background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top;padding-bottom: 10px;padding-top: 15px;height: 80px;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td></td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        Dim OpenDefects As String
        OpenDefects = CType(CommonFunction.Data.GetDataScalar("usp_Sel_ScrumDashboard_GetOpenDefects " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID, MyBase.UseSQL), String)
        CommonFunctions.General.WriteHTML("<td style='padding-right: 5px;padding-left: 9px;font-size: 20px;padding-bottom: 0px;padding-top: 0px;height: 25px;' align='center'>" + OpenDefects + "</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td></td><td><br /></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='divIterationBurnDown'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='normal'>Iteration BurnDown</li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results: ")
        ''To Fill Drop Down for Iteration Graph

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        '''strSQL = "select IterationID,IterationName from tbl_PM_Scrumiteration where ProjectID= " + m_ProjectID + " order by IterationName"
        strSQL = "usp_sel_tbl_PM_Scrumiteration_IterationID_IterationName " + m_ProjectID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.HTMLControls.DrawComboBox("cboIteration", strSQL, 170, CommonFunctions.General.CheckIsNothing(CType(m_IterationID, String), ""), "onchange=""JavaScript:ShowIterationGraph('Project'," + m_ProjectID + ",0,'" + m_strProjectName + "');""", False, , "field")

        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        Call CreateGraph("IterationGraph")
        '<IMG HEIGHT=250 WIDTH=450 src='../../images/BrickRed/9dd76df8.png'>
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='div_DefectsBySeverity'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='normal'>Defects By Severity</li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results :")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "select StatusOfStatusId,StatusOfStatus from tbl_ib_status_for_status WITH(NOLOCK) "
        strSQL = "usp_sel_tbl_ib_status_for_status_StatusOfStatusId_StatusOfStatus "
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, 120, CommonFunctions.General.CheckIsNothing(CType(m_SeverityID, String), ""), "onchange=""JavaScript:ShowSeverityGraph('Project'," + m_ProjectID + ",0,'" + m_strProjectName + "');""", False, , "field")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        '<IMG HEIGHT=250 WIDTH=450 src='../../images/BrickRed/9dd76df8.png'>
        Call CreateGraph("BugsBySeverityGraph")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr><td></td><td><br /></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='div1'>")
        Call DrawTeamDetailPage()
        CommonFunctions.General.WriteHTML("</tr></table></div>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div style='display:block;' id='div3'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul><li class='normal'>Stories Needing Estimates</li></ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div style='padding-right: 0px;padding-left: 0px;background: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top;padding-bottom: 10px;overflow: auto;padding-top: 15px;height: 190px;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='project_heading_PPDB'></td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Rank</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>ID</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Name</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Plan Est</td>")
        CommonFunctions.General.WriteHTML("</tr>")


        ''FOR User Story Est
        Dim strSQLUserStoryEst As String
        Dim drUserStoryEst As IDataReader
        strSQLUserStoryEst = "usp_Sel_ScrumDashboard_UserStoryEst " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        drUserStoryEst = CommonFunctions.Data.GetDataReader(strSQLUserStoryEst, MyBase.UseSQL)
        Do While drUserStoryEst.Read
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(drUserStoryEst("Rank"), "0"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(drUserStoryEst("ID"), "0"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(drUserStoryEst("Name"), "0"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content' >")
            CommonFunctions.General.WriteHTML("<A href=""JavaScript:MapToIteration_OnClick('" + CType(CommonFunctions.Data.CheckIsDBNull(drUserStoryEst("ID"), "0"), String) + "')"" >Map To Iteration</A>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
        Loop
        drUserStoryEst = Nothing

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")


        ''''''''''''''''''''''


        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        'CommonFunctions.General.WriteHTML("<div style='display:" + m_div_ProjectTask + ";' id='div_ProjectTask'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_ProjectTask','div_ProjectIssues');>Tasks</a></li>")
        'CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('div_ProjectIssues','div_ProjectTask');>Issues</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        'strSQL = "select 'All' AS employeeID,'All' AS EmployeeName union  "
        'strSQL += "select DISTINCT(E.EmployeeName), E.EmployeeName "
        'strSQL += "from tbl_PM_Projecttasks T With (noLock)   "
        'strSQL += "left join tbl_PM_Employee E  With (noLock) on T.EmployeeID = E.EmployeeID  "
        'strSQL += "Left Join tbl_PM_Project  With (noLock)  on T.ProjectID=tbl_PM_Project.ProjectID "
        'strSQL += "where tbl_PM_Project.ProjectID=" + m_ProjectID + " AND  E.EmployeeName IS NOT NULL" '(parenttask_uid,0) >=  "
        ''   strSQL += "case when Whichtask = 'o' and CRMQueryID IS NULL then 1 else 0 end" ' ORDER BY e.employeeID

        'CommonFunctions.HTMLControls.DrawComboBox("cboProjectTaskStatus", strSQL, 120, m_ProjectTaskStatus, "onchange=""JavaScript:OnProjectTaskStatusChange('Project'," + m_ProjectID + ",'div_ProjectTask');""", False, , "field")


        'CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1'>")
        'CommonFunctions.General.WriteHTML("<div class='blue_grad1_PPDB'>")
        'Call DrawGridTasks("Project")
        'CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")

        'CommonFunctions.General.WriteHTML("<div style='display:" + m_div_ProjectIssues + ";' id='div_ProjectIssues'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('div_ProjectTask','div_ProjectIssues')>Tasks</a></li>")
        'CommonFunctions.General.WriteHTML("<li class='current1' ><a href=javascript:ShowHide_SubTabs('div_ProjectIssues','div_ProjectTask')>Issues</a></li> ")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        'CommonFunctions.HTMLControls.DrawComboBox("cboProjectIssueStatus", strSQL, 120, m_ProjectIssueStatus, "onchange=""JavaScript:OnProjectIsssueStatusChange('Project'," + m_ProjectID + ",'div_ProjectIssues');""", False, , "field")

        'CommonFunctions.General.WriteHTML(" </td>")
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1'><div class='purp_grad1_PPDB'>")

        'Call DrawGridIssues("Project")

        'CommonFunctions.General.WriteHTML("</div></td></tr></table></div></td>")

        'CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        'CommonFunctions.General.WriteHTML("<div id='divtag_Deliverables' style='display:" + m_div_Deliverables + "'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr><td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        'CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")

        ''Added By VijayD oN 28 July 2008
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        '' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        'If (m_Deliverables_Search <> "Last Week") Then
        '    strDeliverableLastWeek = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Milestones_Search + "');"">Last Week</A>"
        'Else
        '    strDeliverableLastWeek = "Last Week"
        'End If
        'If (m_Deliverables_Search <> "Next Week") Then
        '    strDeliverableNextWeek = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Milestones_Search + "');"">Next Week</A>"
        'Else
        '    strDeliverableNextWeek = "Next Week"
        'End If
        'If (m_Deliverables_Search <> "All") Then
        '    strDeliverableAll = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Milestones_Search + "');"">All</A>"
        'Else
        '    strDeliverableAll = "All"
        'End If
        ''Hidden Field
        ''CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        'CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        ''Added By VijayD oN 28 July 2008

        'CommonFunctions.General.WriteHTML("</td>") '<td class='options_text_PPDB' align='right'>&nbsp;
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td class='border1'>") 'class='milestone'
        'CommonFunctions.General.WriteHTML("<div id='div_Deliverables'class='blue_grad1_PPDB'>") 'Extra Addition By VijayD  
        'Call DrawDeliverablesDetails()

        'CommonFunctions.General.WriteHTML("</DIV>") 'Extra Addition By VijayD <br>
        'CommonFunctions.General.WriteHTML("</td></tr></table></div>")


        'CommonFunctions.General.WriteHTML("<div id='divtag_Milestones' style='display:" + m_div_Milestones + "'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        'CommonFunctions.General.WriteHTML("</ul>") '</td>

        ''Added By VijayD oN 28 July 2008
        'CommonFunctions.General.WriteHTML("</td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        '' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        'If (m_Milestones_Search <> "Last Week") Then
        '    strDeliverableLastWeek = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Deliverables_Search + "');"">Last Week</A>"
        'Else
        '    strDeliverableLastWeek = "Last Week"
        'End If
        'If (m_Milestones_Search <> "Next Week") Then
        '    strDeliverableNextWeek = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Deliverables_Search + "');"">Next Week</A>"
        'Else
        '    strDeliverableNextWeek = "Next Week"
        'End If
        'If (m_Milestones_Search <> "All") Then
        '    strDeliverableAll = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Deliverables_Search + "');"">All</A>"
        'Else
        '    strDeliverableAll = "All"
        'End If
        ''Hidden Field
        ''CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        'CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        ''Added By VijayD oN 28 July 2008

        'CommonFunctions.General.WriteHTML("</td>") '<td class='options_text_PPDB' align='right'>&nbsp;
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr> ")
        'CommonFunctions.General.WriteHTML("<td class='border1'>") 'class='milestone'
        'CommonFunctions.General.WriteHTML("<div id='div_MileStones' class='blue_grad1_PPDB'>") 'Extra Addition By VijayD
        'Call DrawMileStonesDetails()
        'CommonFunctions.General.WriteHTML("</div>") 'Extra Addition By VijayD
        'CommonFunctions.General.WriteHTML("</td></tr></table></div></td></tr></table><br>")

        'Call DrawTimeSheetDetails()
        'Call DrawWeeklyStatusDetails()
        'Call DrawTeamDetailPage()

        'CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        'CommonFunctions.General.WriteHTML("<div id='div_Issue_Graph'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('div_Task_Graph','div_Issue_Graph')>Task Graph</a></li>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_Issue_Graph','div_Task_Graph')>Issues Graph</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        'CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        'Call CreateGraph("IssueGraph")
        'CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")


        'CommonFunctions.General.WriteHTML("<div style='display:none;' id='div_Task_Graph'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td><ul>")
        'CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_Task_Graph','div_Issue_Graph')>Task Graph</a></li>")
        'CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('div_Issue_Graph','div_Task_Graph')>Issues Graph</a></li>")
        'CommonFunctions.General.WriteHTML("</ul></td>")
        'CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        'CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        'CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        'Call CreateGraph("TaskGraph")
        'CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div></td></tr></table></div>")

        'CommonFunctions.General.WriteHTML("</td></tr></table></div>")
    End Sub
    'End of added by NitinC
    Private Sub GetValueDetails()
        '=====================================================================
        ' Procedure Name        : GetValueDetails()
        ' Purpose               : To Assign the values of querystring or seession variable for further use.
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================

        m_TabName = CommonFunctions.General.CheckIsNothing(Request.QueryString("TabName"), "Summary").ToString
        m_UserName = CommonFunctions.General.CheckIsNothing(Session("strUserName"), "").ToString()
        m_ProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0").ToString()
        ''ADDED BY AMIT MAHADIK 0N 11 MAY 2011 WHIZIBLE SEM 10.0,For dashboard
        m_strProjectName = CommonFunctions.General.CheckIsNothing(Request.QueryString("strProjectName"), "Summary").ToString
        ''END ADDED BY AMIT MAHADIK 0N 11 MAY 2011 WHIZIBLE SEM 10.0
        m_intUserID = CommonFunctions.General.CheckIsNothing(Session("intUserID"), "0")
        m_LoginType = CommonFunctions.General.CheckIsNothing(Session("LoginType"), "E")
        m_SummaryTaskStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryTaskStatus"), "All")
        m_ProjectTaskStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectTaskStatus"), "All")

        m_PKToken_Edit = CommonFunctions.Security.Token.GetToken(m_ProjectID.ToString + m_intUserID + "0" + "42")

        m_SummaryIssueStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryIssueStatus"), "All")
        m_SummaryIssueType = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryIssueType"), "All")
        m_ProjectIssueStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIssueStatus"), "All")


        m_div_ProjectIssues = CommonFunctions.General.CheckIsNothing(Request.QueryString("div_ProjectIssues"), "none")
        m_div_ProjectTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("div_ProjectTask"), "block")

        m_ProjectTimeSheet_Result = CommonFunctions.General.CheckIsNothing(Request.QueryString("TimeSheet_Result"), "All")
        m_ProjectTimeSheet_Status = CommonFunctions.General.CheckIsNothing(Request.QueryString("TimeSheet_Status"), "All")

        Mode_Notification = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode_Notification"), "False")
        Mode_TimeSheetDetail = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode_TimeSheetDetail"), "False")
        Mode_WSRTimeSheetDetail = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode_WSRTimeSheetDetail"), "False")
        '
        m_WeeklyStatus = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeeklyStatus"), "All")
        m_ProjectTeamDetail = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectTeamDetail"), "1") '1=All

        m_SummaryIssueCriteria = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryIssueCriteria"), "Combo")
        m_IssueNextLastToday = CommonFunctions.General.CheckIsNothing(Request.QueryString("IssueNextLastToday"), "Today")

        m_strTabCount = CommonFunctions.General.CheckIsNothing(Request.QueryString("intTabNo"), "0")

        
        If (CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), "") = "") Then
            Dim WeekStart As Integer
            Dim WeekToday As Integer
            Dim CNT As Integer

            WeekStart = 2
            WeekToday = Weekday(Now)
            CNT = WeekToday - WeekStart
            m_CurrWeekStartDate = CType(DateAdd(DateInterval.Day, -CNT, Now.Date), String)
            m_PrevWeekStartDate = CType(DateAdd(DateInterval.Day, -CNT, Now.Date), String)
            'End If
        Else
            If (m_SummaryIssueCriteria = "Last Week") Then
                Dim WeekStart As Integer = 2
                Dim WeekToday As Integer = Weekday(Now)
                Dim Cnt As Integer
                Cnt = WeekToday - WeekStart
                m_PrevWeekStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                m_CurrWeekStartDate = CType(DateAdd(DateInterval.Day, -7, CType(m_PrevWeekStartDate, Date)), String)

            ElseIf (m_SummaryIssueCriteria = "Next Week") Then
                Dim WeekStart As Integer = 2
                Dim WeekToday As Integer = Weekday(Now)
                Dim Cnt As Integer
                Cnt = WeekToday - WeekStart
                m_PrevWeekStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                m_CurrWeekStartDate = CType(DateAdd(DateInterval.Day, 7, CType(m_PrevWeekStartDate, Date)), String)
            Else
                Dim WeekStart As Integer = 2
                Dim WeekToday As Integer = Weekday(Now)
                Dim Cnt As Integer
                Cnt = WeekToday - WeekStart
                m_PrevWeekStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                m_CurrWeekStartDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDate"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))

            End If
        End If

        '--------------------Task Related Functionality
        m_SummaryIssueCriteriaTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryTaskCriteria"), "Combo")
        m_IssueNextLastTodayTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("TaskNextLastToday"), "Today")

        m_Deliverables_Search = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryDeliverables"), "All")
        m_Milestones_Search = CommonFunctions.General.CheckIsNothing(Request.QueryString("SummaryMilestones"), "All")
        m_div_Deliverables = CommonFunctions.General.CheckIsNothing(Request.QueryString("div_Deliverables"), "block")
        m_div_Milestones = CommonFunctions.General.CheckIsNothing(Request.QueryString("div_Milestones"), "none")

        If (CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDateTask"), "") = "none") Then
            Dim WeekStart As Integer
            Dim WeekToday As Integer
            Dim CNT As Integer

            WeekStart = 2
            WeekToday = Weekday(Now)
            CNT = WeekToday - WeekStart
            m_CurrWeekStartDateTask = CType(DateAdd(DateInterval.Day, -CNT, Now.Date), String)
            m_PrevWeekStartDateTask = CType(DateAdd(DateInterval.Day, -CNT, Now.Date), String)
            'End If
        Else
            If (m_SummaryIssueCriteriaTask = "Last Week") Then
                Dim WeekStart As Integer = 2
                Dim WeekToday As Integer = Weekday(Now)
                Dim Cnt As Integer
                Cnt = WeekToday - WeekStart
                m_PrevWeekStartDateTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDateTask"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                m_CurrWeekStartDateTask = CType(DateAdd(DateInterval.Day, -7, CType(m_PrevWeekStartDateTask, Date)), String)

            ElseIf (m_SummaryIssueCriteriaTask = "Next Week") Then
                Dim WeekStart As Integer = 2
                Dim WeekToday As Integer = Weekday(Now)
                Dim Cnt As Integer
                Cnt = WeekToday - WeekStart
                m_PrevWeekStartDateTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDateTask"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                m_CurrWeekStartDateTask = CType(DateAdd(DateInterval.Day, 7, CType(m_PrevWeekStartDateTask, Date)), String)
            Else
                Dim WeekStart As Integer = 2
                Dim WeekToday As Integer = Weekday(Now)
                Dim Cnt As Integer
                Cnt = WeekToday - WeekStart
                m_PrevWeekStartDateTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDateTask"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))
                m_CurrWeekStartDateTask = CommonFunctions.General.CheckIsNothing(Request.QueryString("WeekDateTask"), CType(DateAdd(DateInterval.Day, -Cnt, Now.Date), String))

            End If
        End If

    End Sub

    Private Sub DrawSummaryPage()
        '=====================================================================
        ' Procedure Name        : DrawSummaryPage()
        ' Purpose               : To  Draw summary Page for current logged in user.
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String
        Dim strScriptName As String
        Dim strScriptName1 As String
        Dim strScriptNameToday As String

        Dim strDeliverableLastWeek As String
        Dim strDeliverableNextWeek As String
        Dim strDeliverableAll As String

        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td style='PADDING-RIGHT: 10px; PADDING-LEFT: 10px' vAlign='top' width='50%'>")
        CommonFunctions.General.WriteHTML("<table class='container' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td>")
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='container_header_PPDB'>Completion Status</td></tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("<tr><td  class='border'>")

        CommonFunctions.General.WriteHTML("<div id='tab_CompletionStatus' style='width:450px;height:260px;overflow:auto'>") 'Added By VijayD On 30th June 2008

        Call CreateGraph("CompletionStatus")
        CommonFunctions.General.WriteHTML("<div>") 'Added By VijayD On 30th June 2008

        CommonFunctions.General.WriteHTML("</td></tr></table></td>")
        CommonFunctions.General.WriteHTML("<td style='PADDING-RIGHT: 10px; PADDING-LEFT: 10px' vAlign='top' width='50%'>")
        CommonFunctions.General.WriteHTML("<table class='container' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td>")
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='container_header_PPDB'>Schedule Variance</td></tr>")
        CommonFunctions.General.WriteHTML("</table></td></tr><tr>")

        CommonFunctions.General.WriteHTML("<td  class='border'>")
        CommonFunctions.General.WriteHTML("<div id='tab_ScheduleVariance' style='width:450px;height:260px;overflow:auto'>") 'Added By VijayD On 30th June 2008

        Call CreateGraph("ScheduleVariance")
        CommonFunctions.General.WriteHTML("<div>") 'Added By VijayD On 30th June 2008
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table>")
        CommonFunctions.General.WriteHTML("<br>")

        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td style='PADDING-RIGHT: 10px; PADDING-LEFT: 10px' vAlign='top' width='50%'>")
        CommonFunctions.General.WriteHTML("<table class='container' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td>")
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='container_header_PPDB' style='HEIGHT: 25px'>Tasks</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT 'All' Union SELECT 'Red' Union SELECT 'Yellow' Union SELECT 'Green' "
        strSQL = "usp_sel_SummaryTaskStatus"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strScriptName = "onchange=""JavaScript:OnSummaryTaskStatusChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""

        CommonFunctions.HTMLControls.DrawComboBox("cboSummaryTaskStatus", strSQL, , m_SummaryTaskStatus, strScriptName, , , "field")
        If (m_IssueNextLastTodayTask <> "Last Week") Then
            strScriptName = "<A href=""JavaScript:OnSummaryTaskStatusChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','Last Week');"">Last Week</A>"
        Else
            strScriptName = "Last Week"
        End If
        If (m_IssueNextLastTodayTask <> "Next Week") Then
            strScriptName1 = "<A href=""JavaScript:OnSummaryTaskStatusChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','Next Week');"">Next Week</A>"
        Else
            strScriptName1 = "Next Week"
        End If
        If (m_IssueNextLastTodayTask <> "Today") Then
            strScriptNameToday = "<A href=""JavaScript:OnSummaryTaskStatusChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','Today');"">Today</A>"
        Else
            strScriptNameToday = "Today"
        End If
        'Hidden Field

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("|" + strScriptName + " | " + strScriptNameToday + " | " + strScriptName1 + "")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")


        CommonFunctions.General.WriteHTML("<tr><td><div id='div_ProjectTask' class='blue_grad_PPDB' overflow:'Auto'>")
        Call DrawGridTasks("Summary")
        CommonFunctions.General.WriteHTML("</div></td></tr></table></td>")

        CommonFunctions.General.WriteHTML("<td style='PADDING-RIGHT: 10px; PADDING-LEFT: 10px' vAlign='top' width='50%'>")
        CommonFunctions.General.WriteHTML("<table class='container' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td>")
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='container_header_PPDB' style='HEIGHT: 25px'>Issues</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Type :")

        strScriptName = "onchange=""JavaScript:OnSummaryIssueStatusTypeChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        ''MODIFIED BY AMIT MAHADIK ON 03 MAY 2011 FOR WHIZIBLESEM 10.0 , ORDER BY 1

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboSummaryIssueType", "SELECT 'All' AS Type, 'All' AS Type UNION Select Distinct(Type),Type From tbl_IB_Issue WITH(NOLOCK)order By 1", 70, m_SummaryIssueType, strScriptName, , , "field")
        CommonFunctions.HTMLControls.DrawComboBox("cboSummaryIssueType", "usp_sel_tbl_IB_Issue_SummaryIssueType", 70, m_SummaryIssueType, strScriptName, , , "field")
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ''END MODIFIED BY AMIT MAHADIK ON 03 MAY 2011 FOR WHIZIBLESEM 10.0 , ORDER BY 1
        CommonFunctions.General.WriteHTML("| &nbsp;Status :")
        ''MODIFIED BY AMIT MAHADIK ON 03 MAY 2011 FOR WHIZIBLESEM 10.0 , ORDER BY 1

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboSummaryIssueStatus", "SELECT 'All' AS Status, 'All' AS Status UNION Select Status,Status From tbl_IB_Status WITH(NOLOCK) order By 1", 70, m_SummaryIssueStatus, strScriptName, , , "field")
        CommonFunctions.HTMLControls.DrawComboBox("cboSummaryIssueStatus", "usp_sel_tbl_IB_Status_Status", 70, m_SummaryIssueStatus, strScriptName, , , "field")
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        ''END MODIFIED BY AMIT MAHADIK ON 03 MAY 2011 FOR WHIZIBLESEM 10.0 , ORDER BY 1
        If (m_IssueNextLastToday <> "Last Week") Then
            strScriptName = "<A href=""JavaScript:OnSummaryIssueStatusTypeChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','Last Week');"">Last Week</A>"
        Else
            strScriptName = "Last Week"
        End If
        If (m_IssueNextLastToday <> "Next Week") Then
            strScriptName1 = "<A href=""JavaScript:OnSummaryIssueStatusTypeChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','Next Week');"">Next Week</A>"
        Else
            strScriptName1 = "Next Week"
        End If
        If (m_IssueNextLastToday <> "Today") Then
            strScriptNameToday = "<A href=""JavaScript:OnSummaryIssueStatusTypeChange('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','Today');""> Today</A>"
        Else
            strScriptNameToday = "Today"
        End If
        'Hidden Field
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDate", "txthidWeekDate", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("|" + strScriptName + " |" + strScriptNameToday + " | " + strScriptName1 + "")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")

        CommonFunctions.General.WriteHTML("<tr><td><div id='div_ProjectIssues' class='purp_grad_PPDB'>")
        Call DrawGridIssues("Summary")
        CommonFunctions.General.WriteHTML("</div></td></tr></table></td></tr>")

        CommonFunctions.General.WriteHTML("<tr><td style='PADDING-RIGHT: 15px; PADDING-LEFT: 15px' vAlign='top'>")
        CommonFunctions.General.WriteHTML("<table class='notifications_PPDB' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='notifications_heading_PPDB'>Notifications</td></tr>")
        CommonFunctions.General.WriteHTML("<tr><td><table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        Call DrawNotification()
        CommonFunctions.General.WriteHTML("</table></td></tr></table></td>")

        CommonFunctions.General.WriteHTML("<td style='PADDING-RIGHT: 15px; PADDING-LEFT: 15px' vAlign='top'>")
        CommonFunctions.General.WriteHTML("<table class='notifications_PPDB' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='notifications_heading_PPDB'>Upcoming Deliverables/Milestones</td>	</tr>")
        CommonFunctions.General.WriteHTML("<tr><td>")
        CommonFunctions.General.WriteHTML("<div id='divtag_Deliverables' style='DISPLAY:" + m_div_Deliverables + "'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='tabs'>")
        CommonFunctions.General.WriteHTML("<ul>")
        CommonFunctions.General.WriteHTML("<li class='current'><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        CommonFunctions.General.WriteHTML("</ul>")

        'Added By VijayD oN 28 July 2008
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        ' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        If (m_Deliverables_Search <> "Last Week") Then
            strDeliverableLastWeek = "<A href=""JavaScript:OnClickDeliverables('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Milestones_Search + "');"">Last Week</A>"
        Else
            strDeliverableLastWeek = "Last Week"
        End If
        If (m_Deliverables_Search <> "Next Week") Then
            strDeliverableNextWeek = "<A href=""JavaScript:OnClickDeliverables('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Milestones_Search + "');"">Next Week</A>"
        Else
            strDeliverableNextWeek = "Next Week"
        End If
        If (m_Deliverables_Search <> "All") Then
            strDeliverableAll = "<A href=""JavaScript:OnClickDeliverables('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Milestones_Search + "');"">All</A>"
        Else
            strDeliverableAll = "All"
        End If
        'Hidden Field
        'CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        'Added By VijayD oN 28 July 2008

        CommonFunctions.General.WriteHTML("</td></tr><tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' COLSPAN='2'>") 'Add COLSPAN='2' By VijayD On 28 July 2008
        CommonFunctions.General.WriteHTML("<div id='div_Deliverables' class='blue_grad_PPDB'>") 'Extra Addition By VijayD
        Call DrawDeliverablesDetails()
        CommonFunctions.General.WriteHTML("</div>") 'Extra Addition By VijayD <br>
        CommonFunctions.General.WriteHTML("</td></tr></table></div>")

        CommonFunctions.General.WriteHTML("<div id='divtag_Milestones' style='DISPLAY:" + m_div_Milestones + "'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='tabs'>")
        CommonFunctions.General.WriteHTML("<ul>")
        CommonFunctions.General.WriteHTML("<li><a href=javascript:javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        CommonFunctions.General.WriteHTML("<li class='current'><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        CommonFunctions.General.WriteHTML("</ul>")
        'Added By VijayD oN 28 July 2008
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        ' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        If (m_Milestones_Search <> "Last Week") Then
            strDeliverableLastWeek = "<A href=""JavaScript:OnClickMilestones('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Deliverables_Search + "');"">Last Week</A>"
        Else
            strDeliverableLastWeek = "Last Week"
        End If
        If (m_Milestones_Search <> "Next Week") Then
            strDeliverableNextWeek = "<A href=""JavaScript:OnClickMilestones('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Deliverables_Search + "');"">Next Week</A>"
        Else
            strDeliverableNextWeek = "Next Week"
        End If
        If (m_Milestones_Search <> "All") Then
            strDeliverableAll = "<A href=""JavaScript:OnClickMilestones('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Deliverables_Search + "');"">All</A>"
        Else
            strDeliverableAll = "All"
        End If
        'Hidden Field
        'CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        'Added By VijayD oN 28 July 2008
        CommonFunctions.General.WriteHTML("</td></tr><tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' COLSPAN='2'>") 'Add COLSPAN='2' By VijayD On 28 July 2008
        CommonFunctions.General.WriteHTML("<div id='div_MileStones' class='blue_grad_PPDB'>") 'Extra Addition By VijayD
        Call DrawMileStonesDetails()

        CommonFunctions.General.WriteHTML("</td></tr></table></div></td></tr></table></td></tr></table><DIV></DIV>")
    End Sub

    Private Sub DrawProjectPage()
        '=====================================================================
        ' Procedure Name        : DrawProjectPage()
        ' Purpose               : To  Draw the Page if user has selected any projects from the main tabs
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String   '        m_div_ProjectIssues,m_div_ProjectTask
        Dim strDeliverableLastWeek As String
        Dim strDeliverableNextWeek As String
        Dim strDeliverableAll As String

        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr> ")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div style='display:" + m_div_ProjectTask + ";' id='div_ProjectTask'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_ProjectTask','div_ProjectIssues');>Tasks</a></li>")
        CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('div_ProjectIssues','div_ProjectTask');>Issues</a></li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        strSQL = "select 'All' AS employeeID,'All' AS EmployeeName union  "
        strSQL += "select DISTINCT(E.EmployeeName), E.EmployeeName "
        strSQL += "from tbl_PM_Projecttasks T With (noLock)   "
        strSQL += "left join tbl_PM_Employee E  With (noLock) on T.EmployeeID = E.EmployeeID  "
        strSQL += "Left Join tbl_PM_Project  With (noLock)  on T.ProjectID=tbl_PM_Project.ProjectID "
        strSQL += "where tbl_PM_Project.ProjectID=" + m_ProjectID + " AND  E.EmployeeName IS NOT NULL" '(parenttask_uid,0) >=  "
        '   strSQL += "case when Whichtask = 'o' and CRMQueryID IS NULL then 1 else 0 end" ' ORDER BY e.employeeID

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectTaskStatus", strSQL, 120, m_ProjectTaskStatus, "onchange=""JavaScript:OnProjectTaskStatusChange('Project'," + m_ProjectID + ",'div_ProjectTask');""", False, , "field")


        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div class='blue_grad1_PPDB'>")
        Call DrawGridTasks("Project")
        CommonFunctions.General.WriteHTML("</div></td></tr></table></div>")

        CommonFunctions.General.WriteHTML("<div style='display:" + m_div_ProjectIssues + ";' id='div_ProjectIssues'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('div_ProjectTask','div_ProjectIssues')>Tasks</a></li>")
        CommonFunctions.General.WriteHTML("<li class='current1' ><a href=javascript:ShowHide_SubTabs('div_ProjectIssues','div_ProjectTask')>Issues</a></li> ")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results : ")

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectIssueStatus", strSQL, 120, m_ProjectIssueStatus, "onchange=""JavaScript:OnProjectIsssueStatusChange('Project'," + m_ProjectID + ",'div_ProjectIssues');""", False, , "field")

        CommonFunctions.General.WriteHTML(" </td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'><div class='purp_grad1_PPDB'>")

        Call DrawGridIssues("Project")

        CommonFunctions.General.WriteHTML("</div></td></tr></table></div></td>")

        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='divtag_Deliverables' style='display:" + m_div_Deliverables + "'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr><td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'><tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        CommonFunctions.General.WriteHTML("</ul></td>")

        'Added By VijayD oN 28 July 2008
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        ' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        If (m_Deliverables_Search <> "Last Week") Then
            strDeliverableLastWeek = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Milestones_Search + "');"">Last Week</A>"
        Else
            strDeliverableLastWeek = "Last Week"
        End If
        If (m_Deliverables_Search <> "Next Week") Then
            strDeliverableNextWeek = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Milestones_Search + "');"">Next Week</A>"
        Else
            strDeliverableNextWeek = "Next Week"
        End If
        If (m_Deliverables_Search <> "All") Then
            strDeliverableAll = "<A href=""JavaScript:OnClickDeliverables('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Milestones_Search + "');"">All</A>"
        Else
            strDeliverableAll = "All"
        End If
        'Hidden Field
        'CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        'Added By VijayD oN 28 July 2008

        CommonFunctions.General.WriteHTML("</td>") '<td class='options_text_PPDB' align='right'>&nbsp;
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr> ")
        CommonFunctions.General.WriteHTML("<td class='border1'>") 'class='milestone'
        CommonFunctions.General.WriteHTML("<div id='div_Deliverables'class='blue_grad1_PPDB'>") 'Extra Addition By VijayD  
        Call DrawDeliverablesDetails()

        CommonFunctions.General.WriteHTML("</DIV>") 'Extra Addition By VijayD <br>
        CommonFunctions.General.WriteHTML("</td></tr></table></div>")


        CommonFunctions.General.WriteHTML("<div id='divtag_Milestones' style='display:" + m_div_Milestones + "'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr> ")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li><a href=javascript:ShowHide_SubTabs('divtag_Deliverables','divtag_Milestones')>Deliverables</a></li>")
        CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('divtag_Milestones','divtag_Deliverables')>Milestones</a></li>")
        CommonFunctions.General.WriteHTML("</ul>") '</td>

        'Added By VijayD oN 28 July 2008
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' style='HEIGHT: 25px' align='right'>Show Results :")
        ' strScriptName = "onchange=""JavaScript:OnDeliverables_LastWeek('Summary'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Combo','" + m_IssueNextLastToday + "');"""
        If (m_Milestones_Search <> "Last Week") Then
            strDeliverableLastWeek = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Last Week','" + m_Deliverables_Search + "');"">Last Week</A>"
        Else
            strDeliverableLastWeek = "Last Week"
        End If
        If (m_Milestones_Search <> "Next Week") Then
            strDeliverableNextWeek = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'Next Week','" + m_Deliverables_Search + "');"">Next Week</A>"
        Else
            strDeliverableNextWeek = "Next Week"
        End If
        If (m_Milestones_Search <> "All") Then
            strDeliverableAll = "<A href=""JavaScript:OnClickMilestones('Projects'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_Deliverables_Search + "');"">All</A>"
        Else
            strDeliverableAll = "All"
        End If
        'Hidden Field
        'CommonFunctions.HTMLControls.DrawTextBox("txthidWeekDateTask", "txthidWeekDateTask", value:=m_CurrWeekStartDate, returnHTML:=False, IsHidden:=True)
        CommonFunctions.General.WriteHTML("|" + strDeliverableLastWeek + " | " + strDeliverableAll + " | " + strDeliverableNextWeek + "")
        'Added By VijayD oN 28 July 2008

        CommonFunctions.General.WriteHTML("</td>") '<td class='options_text_PPDB' align='right'>&nbsp;
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr> ")
        CommonFunctions.General.WriteHTML("<td class='border1'>") 'class='milestone'
        CommonFunctions.General.WriteHTML("<div id='div_MileStones' class='blue_grad1_PPDB'>") 'Extra Addition By VijayD
        Call DrawMileStonesDetails()
        CommonFunctions.General.WriteHTML("</div>") 'Extra Addition By VijayD
        CommonFunctions.General.WriteHTML("</td></tr></table></div></td></tr></table><br>")

        Call DrawTimeSheetDetails()
        Call DrawWeeklyStatusDetails()
        Call DrawTeamDetailPage()

        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<div id='div_Issue_Graph'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('div_Task_Graph','div_Issue_Graph')>Task Graph</a></li>")
        CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_Issue_Graph','div_Task_Graph')>Issues Graph</a></li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        Call CreateGraph("IssueGraph")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div>")


        CommonFunctions.General.WriteHTML("<div style='display:none;' id='div_Task_Graph'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='current1'><a href=javascript:ShowHide_SubTabs('div_Task_Graph','div_Issue_Graph')>Task Graph</a></li>")
        CommonFunctions.General.WriteHTML("<li ><a href=javascript:ShowHide_SubTabs('div_Issue_Graph','div_Task_Graph')>Issues Graph</a></li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>&nbsp;</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1' style='overflow-y : hidden; POSITION : relative; OVERFLOW : auto; WIDTH : 100%; padding:10px  ;'>")
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='350' align='center'>")
        Call CreateGraph("TaskGraph")
        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr></table></div></td></tr></table></div>")

        CommonFunctions.General.WriteHTML("</td></tr></table></div>")
    End Sub

    Private Sub DrawDashBoardComboBox()
        '=====================================================================
        ' Procedure Name        : DrawDashBoardComboBox()
        ' Purpose               : To  Draw combobox with Accessible dashbord of the current logged in user
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim m_EmployeeID As String
        Dim m_RoleID As String

        CommonFunctions.General.WriteHTML("<div id='tab_1' style='display:block;'><table class='container' ' width='100%' cellpadding='0' cellspacing='0'><tr >") '
        CommonFunctions.General.WriteHTML("<td  align='left' valign='center' height='30px' >")
        CommonFunctions.General.WriteHTML("<a id='lnkDashboards'" + strLinkCss + " name='lnkDashboards' Title='DashBoard Details' href=javascript:Dashboards_OnClick(15001)>&nbsp;&nbsp; | Dashboards |  </a>&nbsp;&nbsp;&nbsp;")
        m_EmployeeID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID"), "0"), String)
        If (m_LoginType.ToLower = "e") Then
            m_RoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select RoleID from tbl_Pm_Login Where EmployeeID=" + m_EmployeeID, True), "0"), String)
        Else
            m_RoleID = "23"
        End If
        CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " + m_EmployeeID + "," + m_RoleID, 250, "../CustomerDashBoard/CustomerDashBoard.aspx|0", "onchange=""JavaScript:cboDashboard_OnChange()""", , , "field")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table></div>")
    End Sub
    Private Sub DrawDashBoardProjectListComboBox()
        '=====================================================================
        ' Procedure Name        : DrawDashBoardProjectListComboBox()
        ' Purpose               : To  Draw combobox with Accessible ProjectList of the current logged in user
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amit Mahadik
        ' Created               : 11 MAY 2011
        ' Revisions             : 
        '=====================================================================
        Dim m_EmployeeID As String
        Dim m_RoleID As String

        CommonFunctions.General.WriteHTML("<div id='tab_1' style='display:block;'><table class='container' ' width='100%' cellpadding='0' cellspacing='0'><tr >") '
        CommonFunctions.General.WriteHTML("<td  align='left' valign='center' height='30px' class='container_header_PPDB' style='HEIGHT: 25px;text-decoration: none;'>")

        CommonFunctions.General.WriteHTML("<a href=javascript:ShowSummary_ProjectSTab('Summary'," + CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), String) + ",'0') > ")
        CommonFunctions.General.WriteHTML("Summary</a>")

        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select Project&nbsp;&nbsp;")
        ''' m_EmployeeID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID"), "0"), String)
        '*********************************************************************************
        Dim drTabs As IDataReader
        Dim strSql As String
        Dim intCount As Integer = 2
        Dim m_drProjectID As String
        Dim m_drProjectName As String
        Dim m_CustomerName As String
        Dim dr As IDataReader
        Dim strScriptName As String

        If (m_LoginType.ToLower = "c") Then
            strSql = " usp_ScrumDashboard_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'C'"
        Else
            strSql = " usp_ScrumDashboard_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'E'"
        End If
        drTabs = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        intCount = 1
        CommonFunctions.General.WriteHTML("<select id='cboProjectList' class='clsComboBoxBlue' onchange=""ShowSummary_ProjectSTab('Project','0','0')"" >")
        'If m_ProjectID = "" Then
        CommonFunctions.General.WriteHTML("<option value='")
        CommonFunctions.General.WriteHTML("-1")
            CommonFunctions.General.WriteHTML("' selected>")
            CommonFunctions.General.WriteHTML("---Select Project---")
            CommonFunctions.General.WriteHTML("</option>")
        ' End If

        Do While drTabs.Read
            '''''ShowSummary_ProjectSTab('Project'," + m_drProjectID + "," + intCount.ToString + ");
            m_drProjectName = CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drTabs("ProjectName")), ""), String)
            m_drProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drTabs("ProjectID"), ""), String)
            'NitinC
            Dim strFlag As String

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'strFlag = CType(CommonFunctions.Data.GetDataScalar("select top 1 IterationID from tbl_PM_Scrumiteration where ProjectID= " + m_drProjectID + " order by IterationName", MyBase.UseSQL), String)
            strFlag = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Scrumiteration_topIterationID " + m_drProjectID, MyBase.UseSQL), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0").ToString() = "0" And CommonFunctions.General.CheckIsNothing(strFlag, "0") <> "0" Then
                m_ProjectID = m_drProjectID
                m_IterationID = strFlag
            End If
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("strProjectName"), "Summary").ToString = "Summary" Then
                m_strProjectName = m_drProjectName
            End If
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("TabName"), "Summary").ToString = "Summary" Then
                m_TabName = "Project"
            End If
            'End of NitinC
            CommonFunctions.General.WriteHTML("<option value='")
            'Added by Dipali V On 7th Jun 2019 For Refresh Issue
            If m_drProjectID = m_ProjectID Then
                'End of Added by Dipali V On 7th Jun 2019 For Refresh Issue
                CommonFunctions.General.WriteHTML(m_drProjectID)
                CommonFunctions.General.WriteHTML("'selected>")
            Else
                CommonFunctions.General.WriteHTML(m_drProjectID)
                CommonFunctions.General.WriteHTML("'>")
            End If

            CommonFunctions.General.WriteHTML(m_drProjectName)
            CommonFunctions.General.WriteHTML("</option>")

            intCount += 1
        Loop
        drTabs = Nothing
        '*********************************************************************************
        ''''''CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " + m_EmployeeID + "," + m_RoleID, 250, "../CustomerDashBoard/CustomerDashBoard.aspx|0", "onchange=""JavaScript:cboDashboard_OnChange()""", , , "field")
        CommonFunctions.General.WriteHTML("</select>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table></div>")
    End Sub

    Private Sub DrawMainTabs()
        '=====================================================================
        ' Procedure Name        : DrawMainTabs()
        ' Purpose               : To  Draw Main TABS on Page
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim drTabs As IDataReader
        Dim strSql As String
        Dim intCount As Integer = 2
        Dim m_drProjectID As String
        Dim tab_menu_over As String = """this.className='tab_menu_over'"""
        Dim tab_menu_PPDB As String = """this.className='tab_menu_PPDB'"""
        Dim tab_menu_over_Summary_PPDB As String = """this.className='tab_menu_over_Summary_PPDB'"""
        Dim tab_menu_Summary_PPDB As String = """this.className='tab_menu_Summary_PPDB'"""

        Dim m_CustomerName As String
        Dim dr As IDataReader
        Dim strScriptName As String

        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td >") 'class='tab_wrapper'
        CommonFunctions.General.WriteHTML("<table border='0' cellspacing='0' cellpadding='0' style='FONT-FAMILY: Arial, Helvetica, sans-serif; FONT-SIZE: 12px;'>") 'height=65px  
        CommonFunctions.General.WriteHTML("<tr>")
        If (m_TabName = "" Or m_TabName.ToLower = "summary") Then
            CommonFunctions.General.WriteHTML("<a href=javascript:ShowSummary_ProjectSTab('Summary'," + CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), String) + ",'0') ><td class='tab_menu_over' style='cursor:pointer;height:25px;width:120px' Title='Summary'>")

            CommonFunctions.General.WriteHTML("Summary</td></a>")
        Else
            CommonFunctions.General.WriteHTML("<a href=javascript:ShowSummary_ProjectSTab('Summary'," + CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), String) + ",'0') ><td class='tab_menu_over_Summary_PPDB' onMouseOver=" + tab_menu_over + " onMouseOut=" + tab_menu_over_Summary_PPDB + " style='cursor:pointer;height:25px;width:120px' Title='Summary'>")
            CommonFunctions.General.WriteHTML("Summary</td></a>")
        End If

        If (m_LoginType.ToLower = "c") Then
            strSql = " usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'C'"
        Else
            strSql = " usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'E'"
        End If

        drTabs = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        intCount = 1
        Do While drTabs.Read
            strSql = CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drTabs("ProjectName")), ""), String)
            m_drProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drTabs("ProjectID"), ""), String)
            CommonFunctions.General.WriteHTML("<a   href=javascript:ShowSummary_ProjectSTab('Project'," + m_drProjectID + "," + intCount.ToString + "); >")
            If (m_TabName = "" Or m_TabName.ToLower = "summary") Then
                CommonFunctions.General.WriteHTML("<td class='tab_menu_PPDB' onMouseOver=" + tab_menu_over + " onMouseOut=" + tab_menu_PPDB + " style='cursor:pointer;height:25px;width:120px' Title='" + HttpUtility.HtmlEncode(strSql).ToString + "'>")
            Else
                If (m_drProjectID = m_ProjectID) Then
                    CommonFunctions.General.WriteHTML("<td class='tab_menu_over' style='cursor:pointer;height:25px;width:120px' Title='" + strSql.ToString + "'>")
                Else
                    CommonFunctions.General.WriteHTML("<td class='tab_menu_PPDB' onMouseOver=" + tab_menu_over + " onMouseOut=" + tab_menu_PPDB + " style='cursor:pointer;height:25px;width:120px' Title='" + HttpUtility.HtmlEncode(strSql).ToString + "'>")
                End If
            End If

            Dim StrLen As Integer
            If strSql.Length >= 10 Then
                StrLen = 10
            Else
                StrLen = strSql.Length
            End If
            CommonFunctions.General.WriteHTML(strSql.Substring(0, StrLen).ToString + "..")
            ' CommonFunctions.General.WriteHTML(strSql)
            CommonFunctions.General.WriteHTML("</td></a>")
            intCount += 1
        Loop
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr> ")
        CommonFunctions.General.WriteHTML("</table></div>")
        drTabs = Nothing
    End Sub

    Private Sub DrawLegend()
        '=====================================================================
        ' Procedure Name        : DrawLegend()
        ' Purpose               : To  Draw Legend on Page
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='blbase' style='HEIGHT: 20px'>")
        Dim tab_menu_over As String = """this.className='tab_menu_over'"""
        ''MODIFIED by Amit Mahadik on 07 May 2011, WHIZIBLE SEM 10.0, verticle scroll
        'Commented and Added By Bharat T on 3rd-Dec-2015 for scrum dashboard alignment
        'CommonFunctions.General.WriteHTML("<div id='rapper' class='clsGridTable' style='width:100%; overflow:auto; height:480px;'><div id='tab_1111' style='width:99.99%' ><table cellSpacing='0' cellPadding='0' border='0' style='width:100%'>")
        ' CommonFunctions.General.WriteHTML("<div id='rapper' class='clsGridTable' style='width:100%; overflow:auto; height:779px;'><div id='tab_1111' style='width:99.99%' ><table cellSpacing='0' cellPadding='0' border='0' style='width:100%'>")
        'Added By Shamkant S on 18 Dec 2015
        CommonFunctions.General.WriteHTML("<div id='rapper' class='clsGridTable' style='overflow:auto; height:779px;'><div id='tab_1111' style='width:99.99%' ><table cellSpacing='0' cellPadding='0' border='0' style='width:100%'>")
        'End by shamkant s on 18 Dec 2015
        'End of Commented and Added By Bharat T on 3rd-Dec-2015 for scrum dashboard alignment
        ''MODIFIED by Amit Mahadik on 07 May 2011, WHIZIBLE SEM 10.0
        CommonFunctions.General.WriteHTML("<tr><td style='height: 20px;' class='blbase'><table cellSpacing='0' cellPadding='0' align='left' border='0'><tr><td class='legend_head' >&nbsp;&nbsp;&nbsp;&nbsp;Project:&nbsp;" + m_strProjectName + "</td></tr></table></td><td class='blbase'  style='HEIGHT: 20px'>")
        CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' align='right' border='0'>")
        CommonFunctions.General.WriteHTML("<tr>")

        CommonFunctions.General.WriteHTML("<td class='legend_head'>Legend:</td>")

        CommonFunctions.General.WriteHTML("<td><span class='flag_yellow'>Not Started</span> &nbsp;|&nbsp; <span class='flag_red'>Need ")
        CommonFunctions.General.WriteHTML("Attention</span> &nbsp;|&nbsp; <span class='flag_green'>In Progress</span></td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table> ")
        CommonFunctions.General.WriteHTML("</td></tr>")
        CommonFunctions.General.WriteHTML("<tr><td><table cellSpacing='0' cellPadding='0' border='0'>")
        CommonFunctions.General.WriteHTML("<IMG height='10' src='images/spacer.gif' width='1'></table></td><td><table cellSpacing='0' cellPadding='0' border='0'><IMG height='10' src='images/spacer.gif' width='1'></table></td></tr>")
        ''MODIFIED by Amit Mahadik on 07 May 2011, WHIZIBLE SEM 10.0, verticle scroll
        CommonFunctions.General.WriteHTML("<table></div></div>")
        ''MODIFIED by Amit Mahadik on 07 May 2011, WHIZIBLE SEM 10.0, verticle scroll

        CommonFunctions.General.WriteHTML("<div>")

    End Sub

#Region "Graphs"

    '--Graph Functions
    Public Sub CreateGraph(ByVal CallFrom As String)
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : Creates the Graph Section
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : 29 May 2008
        ' Revisions             :  
        '=====================================================================

        m_strPalleteSytle = "EARTHTONES"
        m_intGraphHeight = 250
        m_intGraphWidth = 450

        '-- Call fn. to create the Graph Image
        If (CallFrom = "CompletionStatus") Then
            Dim strImageFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Call DrawCompletionStatusGraph(strImageFileName)
            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName & ".png")) Then
                CommonFunctions.General.WriteHTML("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                'CommonFunctions.General.WriteHTML("<IMG src='..\..\images\NoPreview.gif'>")
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view. </td></tr> ")
            End If
        ElseIf (CallFrom = "ScheduleVariance") Then
            Dim strImageFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Call DrawScheduleVarianceGraph(strImageFileName)
            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName & ".png")) Then
                CommonFunctions.General.WriteHTML("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                'CommonFunctions.General.WriteHTML("<IMG src='..\..\images\NoPreview.gif'>")
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view. </td></tr> ")
            End If
        ElseIf (CallFrom = "TaskGraph") Then
            Dim strImageFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Call DrawTaskGraph(strImageFileName)
            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName & ".png")) Then
                CommonFunctions.General.WriteHTML("<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                'CommonFunctions.General.WriteHTML("<IMG src='..\..\images\NoPreview.gif'>")
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view. </td></tr> ")
            End If
        ElseIf (CallFrom = "IssueGraph") Then
            Dim strImageFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Call DrawIssueGraph(strImageFileName)
            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName & ".png")) Then
                CommonFunctions.General.WriteHTML("<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                'CommonFunctions.General.WriteHTML("<IMG src='..\..\images\NoPreview.gif'>")
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view. </td></tr> ")
            End If
            ''Added by NitinC
        ElseIf (CallFrom = "IterationGraph") Then
            Dim strImageFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Call DrawIterationGraph(strImageFileName)
            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName & ".png")) Then
                CommonFunctions.General.WriteHTML("<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                'CommonFunctions.General.WriteHTML("<IMG src='..\..\images\NoPreview.gif'>")
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view. </td></tr> ")
            End If
        ElseIf (CallFrom = "BugsBySeverityGraph") Then
            Dim strImageFileName As String = CommonFunctions.FileDirectory.GetUniqueFileName()
            Call DrawBugsBySeverityGraphGraph(strImageFileName)
            '-- Display Graph
            If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & strImageFileName & ".png")) Then
                CommonFunctions.General.WriteHTML("<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                'CommonFunctions.General.WriteHTML("<IMG src='..\..\images\NoPreview.gif'>")
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view. </td></tr> ")
            End If
            ''End of added by NitinC
        End If

    End Sub

#Region "CompletionStatus/ScheduleVariance Graph"
    Private Sub DrawCompletionStatusGraph(ByVal strImageFileName As String)
        '=====================================================================
        ' Procedure Name        : DrawCompletionStatusGraph()
        ' Purpose               : To create Pie chart, displaying Resource Timesheet Total Project wise
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : vijayd
        ' Created               : May 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim objChart As Dundas.Charting.WebControl.Chart
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr() As String = {}
        Dim intUBound As Integer
        Dim intX As Integer
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor(5) As String
        'Dim arrColor() As String = {"", "LightPink", "palegreen"}
        Dim arrProjectName(100) As String
        Dim intproIndex As Integer
        intproIndex = 0

        arrColor(0) = "SandyBrown"
        'arrColor(1) = "CornflowerBlue" 'RoyalBlue
        'arrColor(2) = "LightGoldenrodYellow"
        'arrColor(3) = "CrimSon"
        'arrColor(4) = "Chocolate"
        'arrColor(5) = "Burlywood"
        'arrColor(6) = "LightGoldenrodYellow"
        'arrColor(7) = "MediumSlateBlue"
        'arrColor(8) = "LightGreen"
        'arrColor(9) = "LightPink"
        'arrColor(10) = "LightPink"
        'arrColor(11) = "Lavender"
        'arrColor(12) = "BlanchedAlmond"
        'arrColor(13) = "MintCream"
        'arrColor(14) = "antiqueWhite"
        'arrColor(15) = "MistyRose"
        'arrColor(16) = "LightBlue"
        'arrColor(17) = "OliveDrab"
        'arrColor(18) = "SaddleBrown"
        'arrColor(19) = "Seashell"
        'arrColor(20) = "LightSalmon"
        'arrColor(21) = "DarkTurquoise"
        'arrColor(22) = "CadetBlue"
        'arrColor(23) = "DarkKhaki "
        'arrColor(24) = "FireBrick"
        'arrColor(25) = "GoldenRod"
        'arrColor(26) = "GreenYellow"
        'arrColor(27) = "MediumPurple"
        'arrColor(28) = "SaddleBrown"

        'Get the Legend Color From DB

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''drGraph = CommonFunctions.Data.GetDataReader("SELECT ColorName From tbl_BrickRed_DashBoard_GraphColor_Settings", MyBase.UseSQL)
        drGraph = CommonFunctions.Data.GetDataReader("usp_sel_tbl_BrickRed_DashBoard_GraphColor_Settings_ColorName", MyBase.UseSQL)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If drGraph.Read Then
            arrColor(1) = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ColorName"), "CornflowerBlue"), String)
        Else
            arrColor(1) = "CornflowerBlue"
        End If
        drGraph = Nothing
        ' get the item details
        strSQL = "EXEC usp_BrickRed_DB_Project_Per_Completed '" + m_UserName + "','" + m_LoginType + "'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then
            intUBound = drGraph.FieldCount()
            ReDim arr(intUBound)
            For intX = 0 To intUBound
                arr(intX) = "COLUMN"
            Next

            'arrProjectName(intproIndex) = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ProjectName"), ""), String)
            'intproIndex = intproIndex + 1 
            'While drGraph.Read
            '    arrProjectName(intproIndex) = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ProjectName"), ""), String)
            '    intproIndex = intproIndex + 1
            'End While
            If (drGraph.NextResult) Then
                If (drGraph.Read) Then
                    m_intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("GraphHeigth"), "250"), Integer)
                    m_intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("GraphWidth"), "450"), Integer)
                    m_intChartAreaWidth = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ChartAreaWidth"), "500"), Integer)
                    m_intChartArea_X_Position = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ChartArea_X_Position"), "5"), Integer)
                    m_intChartArea_Y_Position = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ChartArea_Y_Position"), "4"), Integer)
                    m_intInnerPlotPosition_X = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("InnerPlotPosition_X"), "5"), Integer)
                    m_intInnerPlotPosition_Y = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("InnerPlotPosition_Y"), "4"), Integer)
                End If
            End If

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph

                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString


                .EnableXAxis = True
                .EnableYAxis = True
                .ShowCaptions = True

                ' Graph Setting 
                .Enable3D = False
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "whitesmoke"
                .ChartAreaColor = "gainsboro"
                .BorderStyle = "Embossed Frame"

                .ShowLegends = True
                .LegendDocking = "right"
                .LegendStyle = "column"
                .LegendCaptionColor = "black"
                .LegendColor = arrColor

                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .PalleteStyle = m_strPalleteSytle
                .BorderColor = "light Grey"
                .Nomenclature = "%Completed"
                .EnableSmartLabels = False

                .SQL = strSQL
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .LegendFont = New Font("verdana", 7, FontStyle.Regular)
                .XAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .YAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                objChart = .GenerateChartControl()

                'Dim customLegendItem As Dundas.Charting.WebControl.Legend
                'Dim no As Integer
                'For no = 0 To intproIndex - 1
                '    For Each customLegendItem In objChart.Legends
                '        customLegendItem.CustomItems.Add(Color.LightPink, arrProjectName(no).ToString)
                '    Next
                'Next 
                SetAdditionalProperties(objChart, strImageFileName, "DrawCompletionStatusGraph")
                objChart = Nothing
            End With
        End If
        CommonFunctions.Data.DisposeDataReader(drGraph)
    End Sub
    Private Sub DrawScheduleVarianceGraph(ByVal strImageFileName As String)
        '=====================================================================
        ' Procedure Name        : DrawScheduleVarianceGraph()
        ' Purpose               : To create chart displaying schedule variance in terms of actual /planned work
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim objChart As Dundas.Charting.WebControl.Chart
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strVirtualImgPath As String
        Dim arr() As String = {}
        Dim intUBound As Integer
        Dim intX As Integer
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "moccasin", "palegreen"}
        ' get the item details
        strSQL = " EXEC usp_BrickRed_DB_Project_Schedule_Variance '" + m_UserName + "','" + m_LoginType + "'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then
            intUBound = drGraph.FieldCount()
            ReDim arr(intUBound)
            For intX = 0 To intUBound
                arr(intX) = "COLUMN"
            Next
            If (drGraph.NextResult) Then
                If (drGraph.Read) Then
                    m_intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("GraphHeigth"), "250"), Integer)
                    m_intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("GraphWidth"), "450"), Integer)
                    m_intChartAreaWidth = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ChartAreaWidth"), "500"), Integer)
                    m_intChartArea_X_Position = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ChartArea_X_Position"), "500"), Integer)
                    m_intChartArea_Y_Position = CType(CommonFunctions.Data.CheckIsDBNull(drGraph("ChartArea_Y_Position"), "500"), Integer)

                End If
            End If
            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph

                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString

                .EnableXAxis = True
                .EnableYAxis = True
                .ShowCaptions = True

                ' Graph Setting 
                .Enable3D = False
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "whitesmoke"
                .ChartAreaColor = "gainsboro"
                .BorderStyle = "Embossed Frame"

                .ShowLegends = True
                .LegendDocking = "Right"
                .LegendStyle = "Column"
                .LegendCaptionColor = "black"
                .LegendColor = arrColor

                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .PalleteStyle = m_strPalleteSytle
                .BorderColor = "light Grey"
                .Nomenclature = "%Planned/Actual"
                .EnableSmartLabels = False

                .SQL = strSQL
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .LegendFont = New Font("verdana", 7, FontStyle.Regular)
                .XAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .YAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                ' return the graph control
                '.GenerateChartControl()
                objChart = .GenerateChartControl()
                SetAdditionalProperties(objChart, strImageFileName, "ScheduleVariance")
                objChart = Nothing
            End With
        End If
        CommonFunctions.Data.DisposeDataReader(drGraph)
    End Sub
#End Region

#Region "Graph Issue/Task"
    Private Sub DrawIssueGraph(ByVal strImageFileName As String)
        '=====================================================================
        ' Procedure Name        : DrawIssueGraph()
        ' Purpose               : To create chart,  Issue Status Against Selected Project
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim objChart As Dundas.Charting.WebControl.Chart
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strSQL As String
        Dim strVirtualImgPath As String
        Dim arr() As String = {}
        Dim intUBound As Integer
        Dim intX As Integer
        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " EXEC usp_BrickRed_DB_Project_Issues " + m_intUserID + "," + m_ProjectID + ",'" + m_LoginType + "'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then
            intUBound = drGraph.FieldCount()
            ReDim arr(intUBound)
            For intX = 0 To intUBound
                arr(intX) = "COLUMN"
            Next

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString


                .EnableXAxis = True
                .EnableYAxis = True
                '-----------------------------------
                Dim arrColor(11) As String
                arrColor(0) = "antiqueWhite"
                arrColor(1) = "LightGreen"
                arrColor(2) = "LightPink"
                arrColor(3) = "LightBlue"
                arrColor(4) = "Lavender"
                arrColor(5) = "BlanchedAlmond"
                arrColor(6) = "MintCream"

                arrColor(7) = "CrimSon"
                arrColor(8) = "Chocolate"
                arrColor(9) = "Burlywood"
                arrColor(10) = "LightGoldenrodYellow"
                .Enable3D = False
                .ShowCaptions = True
                .ChartType = arr
                .ShowExplodedPie = False
                .ShowCaptions = True

                'X Axis
                .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
                .XAxisLabelStyle = 2
                .XAxisTitle = "Issues"
                .XAxisFontAngle = 3

                'For Legend
                .ShowLegends = True
                .LegendFont = New Drawing.Font("verdana", 7, Drawing.FontStyle.Regular)
                .XAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .YAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .LegendCaptionColor = "black"
                .LegendShadowOffset = 1
                .LegendDocking = "right"
                .LegendStyle = "column"
                .EnableSmartLabels = False
                .LegendColor = arrColor

                ' Graph Setting 
                .GraphTitleColor = "black"
                .ChartBackColor = "whitesmoke"
                .ChartAreaColor = "gainsboro"
                .BorderStyle = "Embossed Frame"
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .PalleteStyle = m_strPalleteSytle
                .BorderColor = "light Grey"
                .Nomenclature = "Issues"
                .EnableSmartLabels = False
                '-----------------------------------
                .SQL = strSQL
                .ShowExplodedPie = False
                .LegendFont = New Font("verdana", 7, FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                ' return the graph control
                objChart = .GenerateChartControl()
                SetAdditionalProperties(objChart, strImageFileName, "DrawIssueGraph")
                objChart = Nothing
            End With
        End If

        CommonFunctions.Data.DisposeDataReader(drGraph)
    End Sub
    Private Sub DrawTaskGraph(ByVal strImageFileName As String)
        '=====================================================================
        ' Procedure Name        : DrawTaskGraph()
        ' Purpose               : To create chart,  Task Status Against Selected Project
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strVirtualImgPath As String
        Dim arr() As String = {}
        Dim intUBound As Integer
        Dim intX As Integer
        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " EXEC usp_CustomDashBoard_TasksGraph_tbl_Pm_ProjectTasks " + m_ProjectID + ",'" + m_LoginType + "'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then
            intUBound = drGraph.FieldCount()
            ReDim arr(intUBound)
            For intX = 0 To intUBound
                arr(intX) = "PIE"
            Next

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString

                .Enable3D = False
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "whitesmoke"
                .ChartAreaColor = "gainsboro"
                .ShowLegends = True
                .LegendDocking = "right"
                .LegendStyle = "column"
                .LegendCaptionColor = "black"
                .PalleteStyle = "SEMITRANSPARENT" 'm_strPalleteSytle
                .EnableSmartLabels = False
                .ShowCaptions = True


                .SQL = strSQL
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .ShowExplodedPie = True
                .LegendFont = New Font("verdana", 7, FontStyle.Regular)
                .XAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .YAxisFont = New Font("verdana", 7, FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                ' return the graph control
                .GenerateChartControl()
            End With
        End If

        CommonFunctions.Data.DisposeDataReader(drGraph)

    End Sub

    ''Added by NitinC 

    Private Sub DrawIterationGraph(ByVal strImageFileName As String)
        '=====================================================================
        ' Procedure Name        : DrawIssueGraph()
        ' Purpose               : To create chart,  Issue Status Against Selected Project
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim objChart As Dundas.Charting.WebControl.Chart
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strSQL As String
        Dim strVirtualImgPath As String
        Dim arr() As String = {}
        Dim intUBound As Integer
        Dim intX As Integer
        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " EXEC Usp_Sel_ReleaseBurnDown " + m_IterationID + ",'Iteration'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then
            intUBound = drGraph.FieldCount()
            ReDim arr(intUBound)
            For intX = 0 To intUBound
                arr(intX) = "COLUMN"
            Next

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString


                .EnableXAxis = True
                .EnableYAxis = True
                '-----------------------------------
                Dim arrColor(11) As String
                arrColor(0) = "antiqueWhite"
                arrColor(1) = "LightGreen"
                arrColor(2) = "LightPink"
                arrColor(3) = "LightBlue"
                arrColor(4) = "Lavender"
                arrColor(5) = "BlanchedAlmond"
                arrColor(6) = "MintCream"

                arrColor(7) = "CrimSon"
                arrColor(8) = "Chocolate"
                arrColor(9) = "Burlywood"
                arrColor(10) = "LightGoldenrodYellow"
                .Enable3D = False
                .ShowCaptions = True
                .ChartType = arr
                .ShowExplodedPie = False
                .ShowCaptions = True

                'X Axis
                .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
                .XAxisLabelStyle = 2
                .XAxisTitle = "Issues"
                .XAxisFontAngle = 3

                'For Legend
                .ShowLegends = True
                .LegendFont = New Drawing.Font("verdana", 7, Drawing.FontStyle.Regular)
                .XAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .YAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .LegendCaptionColor = "black"
                .LegendShadowOffset = 1
                .LegendDocking = "right"
                .LegendStyle = "column"
                .EnableSmartLabels = False
                .LegendColor = arrColor

                ' Graph Setting 
                .GraphTitleColor = "black"
                .ChartBackColor = "whitesmoke"
                .ChartAreaColor = "gainsboro"
                .BorderStyle = "Embossed Frame"
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .PalleteStyle = m_strPalleteSytle
                .BorderColor = "light Grey"
                .Nomenclature = "Issues"
                .EnableSmartLabels = False
                '-----------------------------------
                .SQL = strSQL
                .ShowExplodedPie = False
                .LegendFont = New Font("verdana", 7, FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                ' return the graph control
                objChart = .GenerateChartControl()
                SetAdditionalProperties(objChart, strImageFileName, "DrawIssueGraph")
                objChart = Nothing
            End With
        End If

        CommonFunctions.Data.DisposeDataReader(drGraph)
    End Sub

    Private Sub DrawBugsBySeverityGraphGraph(ByVal strImageFileName As String)
        '=====================================================================
        ' Procedure Name        : DrawIssueGraph()
        ' Purpose               : To create chart,  Issue Status Against Selected Project
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : mAY 29 2008
        ' Revisions             : 
        '=====================================================================
        Dim objChart As Dundas.Charting.WebControl.Chart
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strSQL As String
        Dim strVirtualImgPath As String
        Dim arr() As String = {}
        Dim intUBound As Integer
        Dim intX As Integer
        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " EXEC Usp_Sel_BugCountbyStatus_Report " + m_ProjectID + ",NULL,NULL,'Severity'," + CType(m_SeverityID, String)

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then
            intUBound = drGraph.FieldCount()
            ReDim arr(intUBound)
            For intX = 0 To intUBound
                arr(intX) = "LINE"
            Next

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString


                .EnableXAxis = True
                .EnableYAxis = True
                '-----------------------------------
                Dim arrColor(11) As String
                arrColor(0) = "antiqueWhite"
                arrColor(1) = "LightGreen"
                arrColor(2) = "LightPink"
                arrColor(3) = "LightBlue"
                arrColor(4) = "Lavender"
                arrColor(5) = "BlanchedAlmond"
                arrColor(6) = "MintCream"

                arrColor(7) = "CrimSon"
                arrColor(8) = "Chocolate"
                arrColor(9) = "Burlywood"
                arrColor(10) = "LightGoldenrodYellow"
                .Enable3D = False
                .ShowCaptions = True
                .ChartType = arr
                .ShowExplodedPie = False
                .ShowCaptions = True

                'X Axis
                .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
                .XAxisLabelStyle = 2
                .XAxisTitle = "Issues"
                .XAxisFontAngle = 3

                'For Legend
                .ShowLegends = True
                .LegendFont = New Drawing.Font("verdana", 7, Drawing.FontStyle.Regular)
                .XAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .YAxisFont = New Font("verdana", 7, FontStyle.Regular)
                .LegendCaptionColor = "black"
                .LegendShadowOffset = 1
                .LegendDocking = "right"
                .LegendStyle = "column"
                .EnableSmartLabels = False
                .LegendColor = arrColor

                ' Graph Setting 
                .GraphTitleColor = "black"
                .ChartBackColor = "whitesmoke"
                .ChartAreaColor = "gainsboro"
                .BorderStyle = "Embossed Frame"
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .PalleteStyle = m_strPalleteSytle
                .BorderColor = "light Grey"
                .Nomenclature = "Issues"
                .EnableSmartLabels = False
                '-----------------------------------
                .SQL = strSQL
                .ShowExplodedPie = False
                .LegendFont = New Font("verdana", 7, FontStyle.Regular)

                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                ' return the graph control
                objChart = .GenerateChartControl()
                SetAdditionalProperties(objChart, strImageFileName, "DrawIssueGraph")
                objChart = Nothing
            End With
        End If

        CommonFunctions.Data.DisposeDataReader(drGraph)
    End Sub

    ''End of added by NitinC 
#End Region
    '--Graphs Additional Settings
    Private Sub SetAdditionalProperties(ByVal objChart As Dundas.Charting.WebControl.Chart, ByVal strImageFileName As String, Optional ByVal strCallFrom As String = "") ' arrColor, arrProjectName

        Dim series As Dundas.Charting.WebControl.Series
        Dim ChartArea As Dundas.Charting.WebControl.ChartArea
        strImageFileName = strImageFileName + ".png"
        For Each ChartArea In objChart.ChartAreas
            ChartArea.InnerPlotPosition.Height = 75
            ChartArea.InnerPlotPosition.Width = 90

            ChartArea.AxisX.Title = ""
            'Set the interval properties for the axis.
            ChartArea.AxisX.Interval = 1
            ChartArea.AxisX.IntervalOffset = 1

            If strCallFrom = "DrawIssueGraph" Then
                ChartArea.AxisX.LabelsAutoFit = True
                ChartArea.AxisX.LabelsAutoFitStyle = Dundas.Charting.WebControl.LabelsAutoFitStyle.OffsetLabels
            End If
            If (strCallFrom = "DrawCompletionStatusGraph") Then
                ChartArea.AxisY.Minimum = 0
                ChartArea.AxisY.Maximum = 100
                ChartArea.InnerPlotPosition.X = m_intInnerPlotPosition_X
                ChartArea.InnerPlotPosition.Y = m_intInnerPlotPosition_Y
                ChartArea.Position.X = m_intChartArea_X_Position
                ChartArea.Position.Y = m_intChartArea_Y_Position
                ChartArea.Position.Width = m_intChartAreaWidth
                ChartArea.Position.Height = 75
                objChart.BorderLineStyle = Dundas.Charting.WebControl.ChartDashStyle.NotSet

            End If
            If (strCallFrom = "ScheduleVariance") Then
                ChartArea.InnerPlotPosition.X = m_intInnerPlotPosition_X
                ChartArea.InnerPlotPosition.Y = m_intInnerPlotPosition_X
                ChartArea.Position.X = m_intChartArea_X_Position
                ChartArea.Position.Y = m_intChartArea_Y_Position
                ChartArea.Position.Width = m_intChartAreaWidth
                ChartArea.Position.Height = 75
                objChart.BorderLineStyle = Dundas.Charting.WebControl.ChartDashStyle.NotSet
            End If
        Next
        For Each series In objChart.Series
            series.BorderStyle = 0
            series.BorderWidth = 0
            'If (strCallFrom = "DrawCompletionStatusGraph") Then
            '    objChart.DataManipulator.GroupByAxisLabel("SUM", series.Name.ToString, series.Name.ToString)
            '    objChart.DataManipulator.InsertEmptyPoints(10, Dundas.Charting.WebControl.IntervalType.Number, series.Name.ToString)
            'End If
        Next
        Dim strFileName As String = Server.MapPath(GRAPH_DIRECTORY) + strImageFileName
        objChart.Save(strFileName)
    End Sub
#End Region

#Region "Task / Issues"
    Private Sub DrawGridTasks(ByVal m_CallFrom As String)
        '=====================================================================
        ' Procedure Name        : DrawGridTasks()	
        ' Purpose               : Plot the  grid for Tasks of projects on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drTask As IDataReader
        Dim intProjectID As Integer
        Dim blnRecordFlag As Boolean = False
        If (m_TabName = "" Or m_TabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + m_intUserID + ",'" + m_LoginType + "'"
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drProject.Read

            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='project_heading_PPDB'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), ""), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Description</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Resource</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>End Date </td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Status</td>")
            CommonFunctions.General.WriteHTML("</tr>")

            strSQL = ""
            'Modified By VijayD On 29 August 2008
            If (m_LoginType = "C") Then
                If (m_CallFrom = "Summary") Then

                    If (m_SummaryTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Summary','" + m_CurrWeekStartDateTask + "','" + m_IssueNextLastTodayTask + "'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer  " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_SummaryTaskStatus + "','Summary','" + m_CurrWeekStartDateTask + "','" + m_IssueNextLastTodayTask + "'"
                    End If
                Else
                    If (m_ProjectTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Project'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Customer  " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_ProjectTaskStatus + "','Project'"
                    End If
                End If

                'Added By VijayD
            Else
                If (m_CallFrom = "Summary") Then

                    If (m_SummaryTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Summary','" + m_CurrWeekStartDateTask + "','" + m_IssueNextLastTodayTask + "'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee  " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_SummaryTaskStatus + "','Summary','" + m_CurrWeekStartDateTask + "','" + m_IssueNextLastTodayTask + "'"
                    End If
                Else
                    If (m_ProjectTaskStatus = "All") Then
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','Project'"
                    Else
                        strSQL = "exec Usp_BrickRed_DB_tbl_Pm_ProjectTasks_Employee  " + m_intUserID + ",'" + m_LoginType + "'," + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_ProjectTaskStatus + "','Project'"
                    End If
                End If
            End If
            'eND Addition  On 29 August 2008
            'End Modification By VijayD  On 29 August 2008
            drTask = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            Do While drTask.Read
                blnRecordFlag = True
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drTask("Description")), "&nbsp"), String) + " </td>") '+ strRef + 
                CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drTask("Resource")), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(drTask("Enddate"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content' >")
                If (CType(CommonFunctions.Data.CheckIsDBNull(drTask("status"), ""), String) = "In Progress") Then
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/flag_Yellow.gif' alt='' width='10' height='10' title='In Progress'></IMG>")
                ElseIf (CType(CommonFunctions.Data.CheckIsDBNull(drTask("status"), ""), String) = "Need Attention") Then
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/flag_Red.gif'  alt='' width='10' height='10' title='Critical, Started Late, Finished Late'></IMG>")
                Else
                    CommonFunctions.General.WriteHTML("<IMG src='../../images/flag_Green.gif'  alt='' width='10' height='10' title='Assigned ,Not Yet Started''></IMG>")
                End If

                CommonFunctions.General.WriteHTML("</td></tr>")
            Loop
            drTask = Nothing
            If (blnRecordFlag = False) Then
                'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'  >")

                ''DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                ''''CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='3'> There are no items to show in this view. </td></tr> ")
                ''END DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0

                ''ADDED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='3' class='table_content' > There are no items to show in this view. </td></tr> ")
                ''END ADDED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0

                'CommonFunctions.General.WriteHTML("</table>")
            End If
            CommonFunctions.General.WriteHTML("</table>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
            blnRecordFlag = False
        Loop

        drProject = Nothing
    End Sub
    Private Sub DrawGridIssues(ByVal m_CallFrom As String)
        '=====================================================================
        ' Procedure Name        : DrawGridIssues()	
        ' Purpose               : Plot the  grid for Issues of projects on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drIssue As IDataReader
        Dim intProjectID As Integer
        Dim intCount As Integer = 0
        Dim blnFlag As Boolean = False
        Dim blnRecordFlag As Boolean = False
        If (m_TabName = "" Or m_TabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + m_intUserID + ",'" + m_LoginType + "'"
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drProject.Read

            CommonFunctions.General.WriteHTML("<table class='project_container' cellSpacing='0' cellPadding='0' width='100%' border='0'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='issues_heading_PPDB'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), "0"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML("<table cellSpacing='0' cellPadding='0' width='100%' border='0'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>ID</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Description</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Type</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Status</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Resource</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>End Date</td>")
            CommonFunctions.General.WriteHTML("</tr>")

            strSQL = ""
            If (m_CallFrom = "Summary") Then

                If (m_SummaryIssueStatus = "All" And m_SummaryIssueType = "All") Then
                    strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','All','Summary','" + m_CurrWeekStartDate + "','" + m_PrevWeekStartDate + "','" + m_IssueNextLastToday + "','" + m_LoginType + "'"
                ElseIf (m_SummaryIssueStatus <> "All" And m_SummaryIssueType = "All") Then
                    strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All','" + m_SummaryIssueStatus + "','Summary','" + m_CurrWeekStartDate + "','" + m_PrevWeekStartDate + "','" + m_IssueNextLastToday + "','" + m_LoginType + "'"
                ElseIf (m_SummaryIssueStatus = "All" And m_SummaryIssueType <> "All") Then
                    strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_SummaryIssueType + "','All','Summary','" + m_CurrWeekStartDate + "','" + m_PrevWeekStartDate + "','" + m_IssueNextLastToday + "','" + m_LoginType + "'"
                Else
                    strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_SummaryIssueType + "','" + m_SummaryIssueStatus + "','Summary','" + m_CurrWeekStartDate + "','" + m_PrevWeekStartDate + "','" + m_IssueNextLastToday + "','" + m_LoginType + "'"
                End If

            Else
                If (m_ProjectIssueStatus = "All") Then
                    strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'All',NULL,'Project',NULL,NULL,NULL,'" + m_LoginType + "'"
                Else
                    strSQL = "exec Usp_BrickRed_DB_tbl_Pm_Issue  " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "NULL"), String) + ",'" + m_ProjectIssueStatus + "',NULL,'Project',NULL,NULL,NULL,'" + m_LoginType + "'"
                End If
            End If

            drIssue = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            intCount = 0
            Do While drIssue.Read
                blnRecordFlag = True
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("IssueID"), "&nbsp"), String) + " </td>") 'strRef &
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drIssue("Summary")), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("Type"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("Status"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content' >" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("AssignToName"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drIssue("EndDate"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("</tr>")
            Loop
            drIssue = Nothing

            If (blnRecordFlag = False) Then
                ' CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'  >")
                ''DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                '''CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5'> There are no items to show in this view. </td></tr> ")
                ''DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0

                ''ADDED  BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content' > There are no items to show in this view. </td></tr> ")
                ''END ADDED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0

                ' CommonFunctions.General.WriteHTML("</table>")
            End If
            CommonFunctions.General.WriteHTML("</table>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
            blnRecordFlag = False
        Loop

        drProject = Nothing

    End Sub
#End Region

#Region "Notifications"
    Public Sub DrawNotification()
        '=====================================================================
        ' Procedure Name        : DrawNotification()	
        ' Purpose               : Plot the  Notification Details about projects on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             : 
        '=====================================================================
        Dim strNotificationCount As String
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strLink As String
        If (m_LoginType = "E") Then
            dr = CommonFunctions.Data.GetDataReader("usp_BrickRed_sel_TimesheetListCount " + m_intUserID, MyBase.UseSQL)
            If dr.Read Then
                strNotificationCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("PendingTSCount"), "0"), String)
            End If
        Else
            strSQL = "SELECT COUNT(tbl_PM_TimeSheetInvoice.TimeSheetNo ) AS PendingTSCount "
            strSQL = strSQL & " FROM tbl_PM_TimeSheetInvoice LEFT OUTER JOIN tbl_PM_SubProject "
            strSQL = strSQL & " ON tbl_PM_TimeSheetInvoice.SubProjectID = tbl_PM_SubProject.SubProjectID,tbl_PM_Project "
            strSQL = strSQL & " WHERE tbl_PM_TimeSheetInvoice.ProjectID=tbl_PM_Project.ProjectID AND ReadyToAuthenticate='Y' "
            strSQL = strSQL & " AND Authenticated<>'Y' AND "
            strSQL = strSQL & "	tbl_PM_TimeSheetInvoice.ProjectID IN (SELECT ProjectID FROM tbl_PM_Project WHERE CustomerID=" + m_intUserID + ")"

            dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If dr.Read Then
                strNotificationCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("PendingTSCount"), "0"), String)
            End If
        End If

        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class=notification_content_PPDB><span><A href='JavaScript:OnDrawNotificationCount_Click()'>" + strNotificationCount.ToString + " Timesheet(s) Pending for Approval </A></SPAN></TD>")
        CommonFunctions.General.WriteHTML("</tr>")

    End Sub
#End Region

#Region "MileStone /Delirable "
    Public Sub DrawMileStonesDetails()
        '=====================================================================
        ' Procedure Name        : DrawMileStonesDetails()	
        ' Purpose               : Plot the MileStones/ Deliverables Details on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drMilestones As IDataReader
        Dim intProjectID As Integer
        Dim intCount As Integer = 0
        Dim blnFlag As Boolean = False
        Dim blnRecordFlag As Boolean = False
        If (m_TabName = "" Or m_TabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + m_intUserID + ",'" + m_LoginType + "'"
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        End If

        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drProject.Read
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='issues_heading_PPDB'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), ""), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>ID</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Description</td>")

            CommonFunctions.General.WriteHTML("<td class='table_heading'>Start Date</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>End Date</td>")

            CommonFunctions.General.WriteHTML("</tr>")

            strSQL = "exec Usp_BrickRed_DB_tbl_PM_Milestones " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0"), String) + ",'" + m_Milestones_Search + "'"
            drMilestones = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
            intCount = 0
            Do While drMilestones.Read
                blnRecordFlag = True
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("MilestoneID"), "&nbsp"), String) + " </td>") '<a href='#'>
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("Milestone"), "&nbsp"), String) + "</td>")
                'Added By VijayD oN 28 July 2008 
                'Purpose: For Addition of StartDate And EndDate
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("StartDate"), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drMilestones("EndDate"), "&nbsp"), String) + "</td>")
                'End Addition On 28 July 2008
                CommonFunctions.General.WriteHTML("</tr>")
            Loop
            drMilestones = Nothing

            If (blnRecordFlag = False) Then
                'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'  >")
                ''DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                '''CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center' colspan='1'> There are no items to show in this view.</td></tr> ")
                ''end DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0

                ''ADDED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center' colspan='1' class='table_content' > There are no items to show in this view.</td></tr> ")
                ''END ADDED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                'CommonFunctions.General.WriteHTML("</table>")
            End If
            CommonFunctions.General.WriteHTML("</table>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
            blnRecordFlag = False
        Loop
        drProject = Nothing

    End Sub
    Public Sub DrawDeliverablesDetails()
        '=====================================================================
        ' Procedure Name        : DrawDeliverablesDetails()	
        ' Purpose               : Plot the  Notification Details about projects on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProject As IDataReader
        Dim drDeliverables As IDataReader
        Dim intProjectID As Integer
        Dim intCount As Integer = 0
        Dim blnFlag As Boolean = False
        Dim blnRecordFlag As Boolean = False
        If (m_TabName = "" Or m_TabName.ToLower = "summary") Then 'When Form is called from  Summary Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject  " + m_intUserID + ",'" + m_LoginType + "'"
        Else 'When Form is called from  any Project Tab
            strSQL = "usp_BrickRed_tbl_Pm_CustomerLoginProject " + m_intUserID + ",'" + m_LoginType + "'," + m_ProjectID
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drProject.Read
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='issues_heading_PPDB'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), ""), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td>")
            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>ID</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>Description</td>")

            CommonFunctions.General.WriteHTML("<td class='table_heading'>Start Date</td>")
            CommonFunctions.General.WriteHTML("<td class='table_heading'>End Date</td>")

            CommonFunctions.General.WriteHTML("</tr>")

            strSQL = "exec Usp_BrickRed_DB_tbl_PM_OtherSchedules " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ProjectID"), "0"), String) + " ,'" + m_Deliverables_Search + "'"
            drDeliverables = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

            Do While drDeliverables.Read

                blnRecordFlag = True

                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drDeliverables("DeliverableId"), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drDeliverables("Deliverable"), "&nbsp"), String) + "</td>")
                'Added By VijayD oN 28 July 2008 
                'Purpose: For Addition of StartDate And EndDate
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drDeliverables("StartDate"), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drDeliverables("EndDate"), "&nbsp"), String) + "</td>")
                'End Addition On 28 July 2008
                CommonFunctions.General.WriteHTML("</tr>")

            Loop
            drDeliverables = Nothing
            If (blnRecordFlag = False) Then
                '  CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'  >")

                ''DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                ''CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center' colspan='1'> There are no items to show in this view.</td></tr> ")
                ''end DELETED BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0

                ''added BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center' colspan='1' class='table_content' > There are no items to show in this view.</td></tr> ")
                ''end added BY AMIT MAHADIK ON 10 MAY 2011 FOR WHIZIBLESEM 10.0
                '  CommonFunctions.General.WriteHTML("</table>")
            End If
            CommonFunctions.General.WriteHTML("</table>")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</table>")
            blnRecordFlag = False
        Loop

        drProject = Nothing

    End Sub
#End Region

#Region "TimeSheets"
    Private Sub DrawTimeSheetDetails()
        '=====================================================================
        ' Procedure Name        : DrawTimeSheetDetails()	
        ' Purpose               : Plot the Project-TimeSheet Details on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drTimeSheet As IDataReader
        Dim intProjectID As Integer
        Dim strScriptName As String
        Dim blnRecordFlag As Boolean = False

        Dim strTimeSheetNo As String
        Dim strTimesheetStatus As String
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td>")
        CommonFunctions.General.WriteHTML("<ul><li class='normal'>Timesheets</li></ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results :")

        strScriptName = "onchange=JavaScript:OnTimeSheetStatusChange('Project'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ");"
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboTimeSheetResult", "Select 'All','All' union Select 'Pending','Pending' union Select 'Latest','Latest' union Select 'Last Month','Last Month'", 100, m_ProjectTimeSheet_Result, strScriptName, , , "field")
        CommonFunctions.HTMLControls.DrawComboBox("cboTimeSheetResult", "usp_sel_TimeSheetResult", 100, m_ProjectTimeSheet_Result, strScriptName, , , "field")
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        CommonFunctions.General.WriteHTML("| &nbsp;Status : ")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'CommonFunctions.HTMLControls.DrawComboBox("cboTimeSheetStatus", "SELECT 'All' AS TimesheetStatus, 'All' AS TimesheetStatus UNION select distinct(TimesheetStatus)as 'TimesheetStatus',TimesheetStatus from v_tbl_PM_TimeSheetInvoice", 100, m_ProjectTimeSheet_Status, strScriptName, , , "field")
        CommonFunctions.HTMLControls.DrawComboBox("cboTimeSheetStatus", "usp_sel_v_tbl_PM_TimeSheetInvoice_All_TimesheetStatus", 100, m_ProjectTimeSheet_Status, strScriptName, , , "field")
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div id='Div_TimeSheetDetails' class='normal_table' style='padding:10px 0;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>ID</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>From Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>To Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>TimeSheet  Hours</td>") 'Time Sheet 
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Status</td>")
        CommonFunctions.General.WriteHTML("</tr>")


        If (m_ProjectTimeSheet_Result = "All" And m_ProjectTimeSheet_Status = "All") Then
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','All'"
        ElseIf (m_ProjectTimeSheet_Result = "All" And m_ProjectTimeSheet_Status <> "All") Then
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','" + m_ProjectTimeSheet_Status + "'"
        ElseIf (m_ProjectTimeSheet_Result <> "All" And m_ProjectTimeSheet_Status = "All") Then
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'" + m_ProjectTimeSheet_Result + "','All'"
        Else
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'" + m_ProjectTimeSheet_Result + "','" + m_ProjectTimeSheet_Status + "'"
        End If

        drTimeSheet = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drTimeSheet.Read
            blnRecordFlag = True
            'strTimeSheetNo,strProjectName,strFromDate,strTodate,strTimesheetStatus
            strTimeSheetNo = CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimeSheetNo"), "-"), String)
            strTimesheetStatus = CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimesheetStatus"), "-"), String)
            Dim strHref As String = "href=""JavaScript:OnSummaryTimesheetNo_Click('" + strTimeSheetNo + "','" + strTimesheetStatus + "')"""
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_content'><A " + strHref + ">" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimeSheetNo"), "0"), String) + "</A></td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("Createddate"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("Fromdate"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("ToDate"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TotalTimeSheetHours"), "0.00"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimesheetStatus"), "&nbsp"), String) + "</td>")

            CommonFunctions.General.WriteHTML("</tr>")
        Loop
        drTimeSheet = Nothing
        If (blnRecordFlag = False) Then
            CommonFunctions.General.WriteHTML("<tr ><td align='center' valign='center' colspan='5' class='table_content' > There are no items to show in this view.</td></tr> ")
        End If
        CommonFunctions.General.WriteHTML("</table></div></td></tr></table></td>")
    End Sub

    Private Sub DrawWeeklyStatusDetails()
        '=====================================================================
        ' Procedure Name        : DrawWeeklyStatusDetails()	
        ' Purpose               : Plot the Project- Weekly TimeSheet Status Details on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drTimeSheet As IDataReader
        Dim intProjectID As Integer
        Dim strScriptName As String
        Dim blnRecordFlag As Boolean = False
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='container'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='normal'>Weekly Status Reports</li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results :")

        strScriptName = "onchange=JavaScript:OnTimeSheetStatusChange('Project'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ");"

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''CommonFunctions.HTMLControls.DrawComboBox("cboWeeklyStatus", "Select 'All','All' union Select 'Last Week','Last Week' union Select 'Last Month','Last Month'", 100, m_WeeklyStatus, strScriptName, , , "field")
        CommonFunctions.HTMLControls.DrawComboBox("cboWeeklyStatus", "usp_sel_WeeklyStatus", 100, m_WeeklyStatus, strScriptName, , , "field")
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'>")
        CommonFunctions.General.WriteHTML("<div id='Div_WeeklyStatusDetails' class='normal_table' style='padding:10px 0;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>ID</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>From Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>To Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>TimeSheet  Hours</td>") 'Time Sheet 
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Status</td>")
        CommonFunctions.General.WriteHTML("</tr>")


        If (m_WeeklyStatus = "All") Then
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'All','All'"
        ElseIf (m_WeeklyStatus = "Last Month") Then
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'" + m_WeeklyStatus + "','All'"
        ElseIf (m_WeeklyStatus = "Last Week") Then
            strSQL = "exec Usp_BrickRed_DB_Tbl_PM_TimeSheet " + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ",'" + m_WeeklyStatus + "','All'"
        End If
        drTimeSheet = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drTimeSheet.Read
            blnRecordFlag = True
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_content'><A href='JavaScript:OnWSRTimesheetNo_Click(" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimeSheetNo"), ""), String) + ")'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimeSheetNo"), "0"), String) + "</A></td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("Createddate"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("Fromdate"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("ToDate"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TotalTimeSheetHours"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTimeSheet("TimesheetStatus"), "&nbsp"), String) + "</td>")

            CommonFunctions.General.WriteHTML("</tr>")
        Loop
        drTimeSheet = Nothing
        If (blnRecordFlag = False) Then
            CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center' colspan='5' class='table_content'> There are no items to show in this view.</td></tr> ")
        End If
        CommonFunctions.General.WriteHTML("</table></div></td></tr></table></td></tr></table><br>")

    End Sub

#End Region

#Region "Team Details"
    Private Sub DrawTeamDetailPage()
        '=====================================================================
        ' Procedure Name        : DrawTeamDetailPage()	
        ' Purpose               : Plot the Project-Team Details on the page
        ' Description           : Same As Above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drTeam As IDataReader
        Dim intProjectID As Integer
        Dim strScriptName As String
        Dim blnRecordFlag As Boolean = False
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td width='50%' valign='top' style='padding-left: 10px; padding-right: 10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td class='tabs2'><table width='100%' border='0' cellspacing='0' cellpadding='0' ><tr>")
        CommonFunctions.General.WriteHTML("<td><ul>")
        CommonFunctions.General.WriteHTML("<li class='normal'>Team Details</li>")
        CommonFunctions.General.WriteHTML("</ul></td>")
        CommonFunctions.General.WriteHTML("<td class='options_text_PPDB' align='right'>Show Results :")

        strScriptName = "onchange=JavaScript:OnProjectTeamDetailChange('Project'," + CType(CommonFunctions.General.CheckIsNothing(m_ProjectID, "0"), String) + ");"
        strSQL = "SELECT '1' AS A,'All' UNION SELECT '2' AS A,'Current' UNION SELECT '3'AS A ,'Last Month'"
        strSQL += " UNION SELECT '4'AS A ,'3 Months Back' UNION SELECT '5'AS A ,'Going off' ORDER BY A"

        CommonFunctions.HTMLControls.DrawComboBox("cboProjectTeamDetail", strSQL, 120, m_ProjectTeamDetail, strScriptName, , , "field")

        CommonFunctions.General.WriteHTML("</td></tr></table></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='border1'><div id='Div_TeamDetailPage' class='normal_table1' style='padding:10px 0;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Name</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Role</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Phone</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Email</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        strSQL = " usp_BrickRed_DB_Project_TeamMember  " + m_ProjectID + ", '" + m_ProjectTeamDetail + "'"

        drTeam = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Do While drTeam.Read
            blnRecordFlag = True
            CommonFunctions.General.WriteHTML("<tr>")
            If (CType(CommonFunctions.Data.CheckIsDBNull(drTeam("GoingOff"), "0"), Integer) >= 0 And CType(CommonFunctions.Data.CheckIsDBNull(drTeam("GoingOff"), "0"), Integer) <= 15) Then
                CommonFunctions.General.WriteHTML("<td class='table_content_off'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("EmployeeName"), "-"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content_off'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("RoleDescription"), "-"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content_off'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("Phone"), "-"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content_off'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("EmailID"), "-"), String) + " </td>")
            Else
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("EmployeeName"), "-"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("RoleDescription"), "-"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("Phone"), "-"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drTeam("EmailID"), "-"), String) + " </td>")
            End If
            CommonFunctions.General.WriteHTML("</tr>")
        Loop
        drTeam = Nothing
        If (blnRecordFlag = False) Then
            CommonFunctions.General.WriteHTML("<BR><tr><td align='center' valign='center' class='table_content' > There are no items to show in this view.</td></tr>")
        End If
        CommonFunctions.General.WriteHTML("</table></div></td></tr></table></td>")
    End Sub
#End Region

#Region "Draw Grid On Clicking Notification Count"
    Private Sub PlotControls_Notification_Timesheet()
        '=====================================================================
        ' Procedure Name        : PlotControls_Notification_Timesheet()	
        ' Purpose               : Plot the controls on the page
        ' Description           : Plot TimeSheet Details Against the Notification Ploted on the form.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQLQuery As String
        Dim drProject As IDataReader
        Dim intRecordCount As Integer = 0
        Dim blnRecordFlag As Boolean = False
        If (m_LoginType = "E") Then
            strSQLQuery = "EXEC usp_Sel_tbl_PM_TimeSheetInvoice 3,NULL,NULL,NULL,NULL,NULL," + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "0")
        Else
            strSQLQuery = " SELECT DISTINCT tbl_PM_TimeSheetInvoice.TimeSheetNo,ProjectName,tbl_PM_TimeSheetInvoice.CreatedDate,"
            strSQLQuery = strSQLQuery & " (CASE When Authenticated='Y' Then 'Approved'"
            strSQLQuery = strSQLQuery & " When Authenticated='R' Then 'Rejected'       "
            strSQLQuery = strSQLQuery & " When Authenticated='N' AND ReadyToAuthenticate IS NULL AND IsFreezed=0 THEN 'Generated' "
            strSQLQuery = strSQLQuery & " When Authenticated='N' AND ReadyToAuthenticate IS NULL AND IsFreezed=1 THEN 'Freezed' "
            strSQLQuery = strSQLQuery & " When Authenticated='N' AND ReadyToAuthenticate='Y' THEN 'Sent For Approval' END) AS TimesheetStatus"
            strSQLQuery = strSQLQuery & " FROM  tbl_PM_TimeSheetInvoice INNER JOIN Tbl_PM_TimeSheet "
            strSQLQuery = strSQLQuery & " ON tbl_PM_TimeSheetInvoice.TimeSheetNo=Tbl_PM_TimeSheet.TimeSheetNo LEFT OUTER JOIN tbl_PM_SubProject  "
            strSQLQuery = strSQLQuery & " ON tbl_PM_TimeSheetInvoice.SubProjectID = tbl_PM_SubProject.SubProjectID,tbl_PM_Project "
            strSQLQuery = strSQLQuery & " WHERE tbl_PM_TimeSheetInvoice.ProjectID=tbl_PM_Project.ProjectID AND ReadyToAuthenticate='Y'  "
            strSQLQuery = strSQLQuery & " AND Authenticated<>'Y' AND "
            strSQLQuery = strSQLQuery & " tbl_PM_TimeSheetInvoice.ProjectID IN (SELECT ProjectID FROM tbl_PM_Project WHERE CustomerID=" + CommonFunctions.General.CheckIsNothing(CType(Session("intUserID"), String), "0") + ")"
        End If
        drProject = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        'CommonFunctions.General.WriteHTML("<div id='tab_1' style='display:block;'>")
        'CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        'CommonFunctions.General.WriteHTML("<tr>")
        'CommonFunctions.General.WriteHTML("<td class='tab_wrapper'>")
        CommonFunctions.General.WriteHTML("<div id='div_Deliverables' style='BORDER-RIGHT: #aeaeae 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #aeaeae 1px solid; PADDING-LEFT: 10px; BACKGROUND: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top; PADDING-BOTTOM: 10px; OVERFLOW: auto; BORDER-LEFT: #aeaeae 1px solid; PADDING-TOP: 10px; BORDER-BOTTOM: #aeaeae 1px solid; HEIGHT: 300px;WIDTH:100%;'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='project_container'>")
        CommonFunctions.General.WriteHTML("<tr><td><IMG height='10' src='images/spacer.gif' width='1'></td></tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='project_heading_PPDB'>Timesheet Details</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'> No </td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Project Name</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Created Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Status</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        Do While drProject.Read
            blnRecordFlag = True
            intRecordCount += 1
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_content'> " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("TimeSheetNo"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'> " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("CreatedDate"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("TimeSheetStatus"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
        Loop
        If (blnRecordFlag = False) Then
            CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center'colspan='3' class='table_content'> There are no items to show in this view.</td></tr> ")
        Else
            CommonFunctions.General.WriteHTML("<BR><table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<TR><TD width='100%' align='right' class='table_content'>")
            CommonFunctions.General.WriteHTML("Total Records :" + CStr(intRecordCount) + " </TD></TR></TABLE>")
        End If
        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table></DIV>")

        'CommonFunctions.General.WriteHTML("</td></tr></table></div>")
    End Sub 'Plot controls on the page
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
        ' Author                : VijayD
        ' Created               : 29 May,2008
        ' Revisions             :
        '=====================================================================
        Try
            Dim arrElements(arrList.Count - 1) As String
            arrList.ToArray.CopyTo(arrElements, 0)
            Return arrElements
        Catch ex As Exception
            'Exception Handler
        End Try
    End Function
#End Region

#Region "Draw Grid On Clicking TimesheetID ON Project Page"
    Private Sub PlotControls_Timesheet_Details()
        '=====================================================================
        ' Procedure Name        : PlotControls_Timesheet_Details()	
        ' Purpose               : Plot the controls on the page
        ' Description           : Plot TimeSheet Details Against the Notification Ploted on the form.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQLQuery As String
        Dim drProject As IDataReader
        Dim drEmployee As IDataReader
        Dim intRecordCount As Integer = 0
        Dim blnRecordFlag As Boolean = False

        Dim strTimeSheetNo As String
        Dim strTimesheetStatus As String
        Dim fltGroupTotal As Double = 0
        Dim fltGrandTotal As Double = 0
        Dim flgCancelApprove, flgCancelReject, flgCancelViewComment As Boolean
        Dim strApprove, strReject, strWievComment As String
        flgCancelApprove = False
        flgCancelReject = False
        flgCancelViewComment = False

        strTimeSheetNo = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TimeSheetNo"), "-"), String)
        strTimesheetStatus = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TimesheetStatus"), "-"), String)
        '------------------------------------------Draw Menu From Here-----------------------------------------

        If strTimesheetStatus <> "Sent For Approval" Then 'Reject
            Dim blnIsInvoiceExists_ForProjectTimesheet As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_IsInvoiceExists_ForProjectTimesheet " + strTimeSheetNo, MyBase.UseSQL), ""), String)
            If (blnIsInvoiceExists_ForProjectTimesheet = "1" Or strTimesheetStatus = "Rejected") Then
                flgCancelReject = True
            End If
        End If
        If strTimesheetStatus <> "Sent For Approval" Then 'Approve
            Dim blnIsInvoiceExists_ForProjectTimesheet As String = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_IsInvoiceExists_ForProjectTimesheet " + strTimeSheetNo, MyBase.UseSQL), ""), String)
            If (blnIsInvoiceExists_ForProjectTimesheet = "1" Or (strTimesheetStatus = "Approved" Or strTimesheetStatus = "Rejected")) Then
                flgCancelApprove = True
            End If
        End If
        If strTimesheetStatus = "Rejected" Or strTimesheetStatus = "Approved" Then 'ViewComment
        Else
            flgCancelViewComment = True
        End If

        If (flgCancelApprove = True) Then
            strApprove = ""
        Else
            strApprove = "<A " + strLinkCss + " HREF=""Javascript:AuthenticateDetailPage_OnClick(" + strTimeSheetNo + ")"" Title='Approve' >Approve</A> |"
        End If
        If (flgCancelReject = True) Then
            strReject = ""
        Else
            strReject = "<A " + strLinkCss + " HREF=""Javascript:Reject_OnClick(" + strTimeSheetNo + ")"" Title='Reject' >Reject</A> |"
        End If
        If (flgCancelViewComment = True) Then
            strWievComment = ""
        Else
            strWievComment = "<A " + strLinkCss + " HREF=""Javascript:View_Comment_OnClick(" + strTimeSheetNo + ")"" Title='View Comment' >View Comment</A> |"
        End If
        'Header Menu
        CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND:#dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
        CommonFunctions.General.WriteHTML("<TR ><TD align=Right> | ")
        CommonFunctions.General.WriteHTML(strApprove + " " + strReject + " " + strWievComment + " <A " + strLinkCss + " HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> | </TD></TR></TABLE><br>") '<A class='" & strClass & "' HREF='Javascript:Help_OnClick('TL')' Title='Help' >&nbsp;?&nbsp;</A> |
        '------------------------------------------Draw Menu Till Here-----------------------------------------

        CommonFunctions.General.WriteHTML("<TABLE  cellspacing=0 cellpadding=0 width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 30px; PADDING-LEFT: 30px; ; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
        CommonFunctions.General.WriteHTML("<TD class='table_heading'>ID</TD>")
        CommonFunctions.General.WriteHTML("<TD class='table_heading'>Project Name</TD>")
        CommonFunctions.General.WriteHTML("<TD class='table_heading'>From Date</TD>")
        CommonFunctions.General.WriteHTML("<TD class='table_heading'>To Date</TD>")
        CommonFunctions.General.WriteHTML("<TD class='table_heading'>Today</TD>")
        CommonFunctions.General.WriteHTML("<TD class='table_heading'>Status</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        strSQLQuery = "SELECT  TimeSheetNo,convert(varchar(20),V.Createddate,106) as [Createddate],convert(varchar(20),Fromdate,106) as [Fromdate],convert(varchar(20),ToDate,106) as [ToDate],TimesheetStatus,ProjectName"
        strSQLQuery += " FROM v_tbl_PM_TimeSheetInvoice V INNER JOIN tbl_Pm_Project T ON V.ProjectID=T.ProjectID WHERE V.TimeSheetNo=" + strTimeSheetNo
        drProject = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If (drProject.Read) Then
            CommonFunctions.General.WriteHTML("<TR >")
            CommonFunctions.General.WriteHTML("<TD class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("TimeSheetNo"), "-"), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), "-"), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("FromDate"), "-"), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("ToDate"), "-"), String) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class='table_content'>" + CommonFunctions.Dates.GetDate(Date.Now) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("TimesheetStatus"), "-"), String) + "</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
        End If
        CommonFunction.Data.DisposeDataReader(drProject)

        CommonFunctions.General.WriteHTML("</TABLE><br>")

        CommonFunctions.General.WriteHTML("<div id='div_Deliverables' style='BORDER-RIGHT: #aeaeae 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #aeaeae 1px solid; PADDING-LEFT: 10px; BACKGROUND: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top; PADDING-BOTTOM: 10px; OVERFLOW: auto; BORDER-LEFT: #aeaeae 1px solid; PADDING-TOP: 15px; BORDER-BOTTOM: #aeaeae 1px solid; HEIGHT: 355px'>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td>")
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Employee Name/Date</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Task Name</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Description</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Hours.</td>")
        CommonFunctions.General.WriteHTML("</tr>")


        strSQLQuery = "SELECT DISTINCT (EMPLOYEENAME),EMP.EMPLOYEEID "
        strSQLQuery += " FROM TBL_PM_TIMESHEET TS WITH(NOLOCK) Inner Join TBL_PM_EMPLOYEE EMP WITH(NOLOCK)"
        strSQLQuery += " ON TS.EMPLOYEEID=EMP.EMPLOYEEID WHERE TS.TIMESHEETNO=" + strTimeSheetNo
        drEmployee = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)


        Do While drEmployee.Read
            blnRecordFlag = True
            strSQLQuery = "EXEC usp_BrickRed_Sel_TimeSheetForGivenTimeSheetNo  " + strTimeSheetNo + "," + CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeID"), "&nbsp"), String)
            drProject = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

            CommonFunctions.General.WriteHTML("<tr><td  class='table_heading' colspan='4'>" + CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), "&nbsp"), String) + "</td></tr>")

            Do While drProject.Read
                CommonFunctions.General.WriteHTML("<tr>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("EntryDate"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'> " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("Task"), "&nbsp"), String) + " </td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("Description")), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("<td class='table_content'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("Duration"), "&nbsp"), String) + "</td>")
                CommonFunctions.General.WriteHTML("</tr>")
                fltGroupTotal += CType(CommonFunctions.Data.CheckIsDBNull(drProject("Duration"), "0.0"), Double)
            Loop

            'CommonFunctions.General.WriteHTML("<table  width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr style='BORDER-RIGHT: #fff 2px solid ; BACKGROUND:inactivecaptiontext; COLOR: #222; HEIGHT: 20px'><td colspan='3' ><b >Total For : </b>" + CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), "&nbsp"), String) + " </td>") '; PADDING-RIGHT: 10px; PADDING-LEFT: 10px;
            CommonFunctions.General.WriteHTML("<td STYLE='PADDING-RIGHT: 5px; PADDING-LEFT: 9px;' align='left' ><b>" + fltGroupTotal.ToString + "</b><td></tr>") '</table>")

            fltGrandTotal += fltGroupTotal
            fltGroupTotal = 0
        Loop
        If (blnRecordFlag = False) Then
            CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center'colspan='4' class='table_content'> There are no items to show in this view.</td></tr> ")
        Else
            CommonFunctions.General.WriteHTML("<tr style='BORDER-RIGHT: #fff 2px solid ; BACKGROUND: inactivecaptiontext; COLOR: #222; HEIGHT: 20px'><td colspan='3'><b>Grand Total :  </b>" + " </td>")
            CommonFunctions.General.WriteHTML("<td  STYLE='PADDING-RIGHT: 5px; PADDING-LEFT: 9px;' align='left'><b>" + fltGrandTotal.ToString + "</b><td></tr>") '</table>")

        End If


        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</table></DIV>")

        'Footer Menu
        CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
        CommonFunctions.General.WriteHTML("<TR ><TD align=Right> | ")
        CommonFunctions.General.WriteHTML(strApprove + " " + strReject + " " + strWievComment + " <A " + strLinkCss + " HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> |</TD></TR></TABLE>")

        CommonFunction.Data.DisposeDataReader(drProject)

    End Sub 'Plot controls on the page

    Private Sub PlotControls_WSR()
        '=====================================================================
        ' Procedure Name        : PlotControls_Timesheet_Details()	
        ' Purpose               : Plot the controls on the page
        ' Description           : Plot TimeSheet Details Against the Notification Ploted on the form.
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VijayD
        ' Created               : May 29 , 2008
        ' Revisions             :
        '=====================================================================
        Dim strSQLQuery As String
        Dim drProject As IDataReader
        Dim drApprover As IDataReader
        Dim intRecordCount As Integer = 0
        Dim blnRecordFlag As Boolean = False
        Dim strTimesheetNo As String
        Dim m_strFromDate As String = ""
        Dim m_strToDate As String = ""
        Dim fltTotalWorkHr As Double = 0



        strTimesheetNo = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TimeSheetNo"), "0"), String)

        strSQLQuery = "EXEC usp_sel_WSR_ProjectInformationGrid  " + strTimesheetNo
        drProject = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If (drProject.Read) Then
            m_strFromDate = CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drProject("FromDate"), ""), Date))
            m_strToDate = CommonFunctions.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drProject("ToDate"), ""), Date))

            'Header Menu
            CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND:#dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
            CommonFunctions.General.WriteHTML("<TR ><TD align='right' > |  <A " + strLinkCss + " HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> |</TD></TR></TABLE>")

            CommonFunctions.General.WriteHTML("<div id='div_Deliverables' style='BORDER-RIGHT: #aeaeae 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #aeaeae 1px solid; PADDING-LEFT: 10px; BACKGROUND: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top; PADDING-BOTTOM: 10px; OVERFLOW: auto; BORDER-LEFT: #aeaeae 1px solid; PADDING-TOP: 15px; BORDER-BOTTOM: #aeaeae 1px solid; HEIGHT: 470px'>")

            CommonFunctions.General.WriteHTML("<table style='WIDTH:100%'>")
            CommonFunctions.General.WriteHTML("<tr><td style='WIDTH:100%;HEIGHT: 5px'></td></tr>")
            CommonFunctions.General.WriteHTML("<tr><td  class='project_heading_PPDB'> Weekly Status Report </td></tr>")
            CommonFunctions.General.WriteHTML("</table><BR>")

            CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content'><b> To &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content' >&nbsp" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("CustomerName"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content' ><b> Created Date &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content' >&nbsp" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("CreatedDate"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content' ><b> Project Name &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content'>&nbsp" + CType(CommonFunctions.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drProject("ProjectName")), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content' ><b> From Date &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content' >&nbsp" & m_strFromDate & "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content'><b> To Date &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content'>&nbsp" & m_strToDate & "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content'><b> From &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content'>&nbsp" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("CompanyID"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td align='right' class='table_content'><b> Subject &nbsp; :<b></td>")
            CommonFunctions.General.WriteHTML("<td align='left' class='table_content'>&nbsp" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("Subject"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("</tr>")
            CommonFunctions.General.WriteHTML("</tr></table>")
        End If
        CommonFunction.Data.DisposeDataReader(drProject)
        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td ><IMG height='5' src='images/spacer.gif' width='1'></td></tr></table>")

        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr><td  class='project_heading_PPDB'><b> Status of activities planned for the period</b></td></tr></table>")

        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'><tr><td><IMG height='5' src='images/spacer.gif' width='1'></td></tr></table>")

        strSQLQuery = "EXEC usp_sel_WSR_Activities  " + strTimesheetNo
        drProject = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        CommonFunctions.General.WriteHTML("<table width='100%' border='0' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Task name</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'align='right'>Time Sheet Work (hrs)</td>")
        CommonFunctions.General.WriteHTML("<td class='table_heading'>Status</td>")
        CommonFunctions.General.WriteHTML("</tr>")
        Do While drProject.Read
            blnRecordFlag = True
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_content'> " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("Task"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content' align='right'>" + CType(CommonFunctions.Data.CheckIsDBNull(drProject("WorkHrs"), "&nbsp"), String) + "</td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'> " + CType(CommonFunctions.Data.CheckIsDBNull(drProject("Status"), "&nbsp"), String) + " </td>")
            CommonFunctions.General.WriteHTML("</tr>")
            fltTotalWorkHr = fltTotalWorkHr + CType(CommonFunctions.Data.CheckIsDBNull(drProject("WorkHrs"), "0.0"), Double)
        Loop
        If (blnRecordFlag = False) Then
            CommonFunctions.General.WriteHTML("<tr><td align='center' valign='center'colspan='3' class='table_content' > There are no items to show in this view.</td></tr> ")
        Else
            CommonFunctions.General.WriteHTML("<tr>")
            CommonFunctions.General.WriteHTML("<td class='table_content'><b>Grand Total</b> </td>")
            CommonFunctions.General.WriteHTML("<td class='table_content' align='right'><b>" + fltTotalWorkHr.ToString + "</b></td>")
            CommonFunctions.General.WriteHTML("<td class='table_content'>&nbsp</td>")
            CommonFunctions.General.WriteHTML("</tr>")
        End If
        CommonFunctions.General.WriteHTML("</table>")
        DisplayWSROtherAttributes(m_strFromDate, m_strToDate, strTimesheetNo)
        CommonFunctions.General.WriteHTML("</DIV>")
        'Footer Menu
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
        CommonFunctions.General.WriteHTML("<TR ><TD align='right' > |  <A " + strLinkCss + " HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> |</TD></TR></TABLE>")

        CommonFunction.Data.DisposeDataReader(drProject)

    End Sub 'Plot controls on the page

    Private Sub DisplayWSROtherAttributes(ByVal m_strFromDate As String, ByVal m_strToDate As String, ByVal m_intTimeSheetNo As String)
        '=====================================================================
        ' Procedure Name        : DisplayWSROtherAttributes()	
        ' Purpose               : to display other attributes of WSR at the end of the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Mar 17, 2004
        ' Revisions             :
        '=====================================================================
        Dim m_strHighLights As String = ""
        Dim m_strActivities As String = ""
        Dim m_strSuggetions As String = ""
        Dim m_strIssues As String = ""
        Dim m_strSleepage As String = ""

        Dim drWSROtherAttributes As IDataReader
        drWSROtherAttributes = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_WSROtherAttributes " + m_intTimeSheetNo, MyBase.UseSQL)
        If drWSROtherAttributes.Read Then
            m_strHighLights = drWSROtherAttributes("Highlights").ToString
            m_strActivities = drWSROtherAttributes("Activities").ToString
            m_strSuggetions = drWSROtherAttributes("Suggetion").ToString
            m_strIssues = drWSROtherAttributes("Issues").ToString
            m_strSleepage = drWSROtherAttributes("Sleepage").ToString
        End If
        CommonFunction.Data.DisposeDataReader(drWSROtherAttributes)

        CommonFunctions.General.WriteHTML("<BR><TABLE width='99.9%' class=clsTable cellspacing=0 cellpadding=0>")

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD valign=top width='30%' align=right><b> Slippage &nbsp;&nbsp; : &nbsp;&nbsp; </b></TD>")
        CommonFunctions.General.WriteHTML("<TD  align=Left>" + m_strSleepage + "</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD valign=top  width='30%' align=right><b> Issues and Concerns &nbsp;&nbsp; : &nbsp;&nbsp; </b></TD>")
        CommonFunctions.General.WriteHTML("<TD  align=Left>" + m_strIssues + "</TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD valign=top width='30%' align=right><b>Suggestions &nbsp;&nbsp; : &nbsp;&nbsp; </b></TD>")
        CommonFunctions.General.WriteHTML("<TD  align=Left>" + m_strSuggetions + "</TD></TR>")

        Dim Interval As Double
        Interval = DateDiff(DateInterval.Day, CType(m_strFromDate, Date), CType(m_strToDate, Date))

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD  align=right width='30%'><b>The next period &nbsp;&nbsp;: &nbsp;&nbsp; </TD><TD> " + CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, Interval, CType(m_strFromDate, Date))).ToString + " To " + CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, Interval, CType(m_strToDate, Date))).ToString + "<b></TD></TR>")

        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD valign=top  width='30%' align=right><b>Notes for the next period &nbsp;&nbsp;: &nbsp;&nbsp; </TD><TD align=Left>" + m_strActivities + "</TD></TR>")

        CommonFunctions.General.WriteHTML("</TABLE>")


    End Sub

#End Region

#Region "TimeSheet Listing --Accept/Reject TimeSheet"

    Private Sub PlotGridApprovedOrReject()
        '==================================================================================
        ' Procedure Name	:	PlotGridApprovedOrReject
        ' Purpose			:	This procedure to Plot New Page which will used for Accept / Reject the Selected Timesheets.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	VijayD
        ' Created			:	12 June 2008
        ' Revisions			:	
        '==================================================================================
        Dim strTimeSheetsNos As String
        ' Dim arrTimesheetNo As String()
        Dim intCount As Integer
        Dim strQuery As String
        Dim strMenu As String = ""
        Dim drTimesheet As IDataReader
        Dim intRowCount As Integer = 0
        Dim strTrClass As String
        Dim strTimesheetNo As String
        Dim strFromDateAppR As String
        Dim strToDateAppR As String
        Dim strProjectName As String
        Dim strComments As String = ""

        Dim strClass As String = "padding-left: 2pt;font-weight: bolder;font-size: 8pt;padding-bottom: 2pt;margin: 2pt;color: black;padding-top: 2pt;font-family: Arial, Verdana;height: 15px;" 'padding-right: 2pt;

        strTimeSheetsNos = Request.QueryString("TimesheetNo_PK")

        If Request.QueryString("ToApprove") = "ToApprove" Then
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
            CommonFunctions.General.WriteHTML("<TR ><TD align=Right> | <A " + strLinkCss + " HREF=""Javascript:FinalAuthenticate_OnClick(" + Request.QueryString("TimesheetNo_PK").ToString + ")"" Title='Approve' >Approve</A> | <A " + strLinkCss + " HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> | </TD></TR></TABLE>") '" & strTimeSheetNo & "'<A class='" & strClass & "' HREF='Javascript:Help_OnClick('TL')' Title='Help' >&nbsp;?&nbsp;</A> |
            strComments = "Approved On " + CommonFunction.Dates.GetDate(Now())
        End If
        If Request.QueryString("ToReject") = "ToReject" Then
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
            CommonFunctions.General.WriteHTML("<TR ><TD align='right'> | <A " + strLinkCss + " HREF=""Javascript:FinalReject_OnClick(" + Request.QueryString("TimesheetNo_PK").ToString + ")"" Title='Reject' >Reject</A> | <A " + strLinkCss + "  HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> |</TD></TR></TABLE>") '" & strTimeSheetNo & " '| <A class='" & strClass & "' HREF='Javascript:Help_OnClick('TL')' Title='Help' >&nbsp;?&nbsp;</A> 
        End If
        CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' >")
        CommonFunctions.General.WriteHTML("<TR ><TD align='right'><font face='Times New Roman'><B>(<img src='../../images/star.gif'> Mandatory)</B></font></TD></TR>")
        CommonFunctions.General.WriteHTML("</Table>")

        CommonFunction.General.WriteHTML("<DIV ID='DIVLIST' style='BORDER-RIGHT: #aeaeae 1px solid; PADDING-RIGHT: 10px; BORDER-TOP: #aeaeae 1px solid; PADDING-LEFT: 10px; PADDING-BOTTOM: 10px; OVERFLOW: auto; BORDER-LEFT: #aeaeae 1px solid; PADDING-TOP: 10px; BORDER-BOTTOM: #aeaeae 1px solid; HEIGHT: 232px;WIDTH:100%;' >")
        CommonFunction.General.WriteHTML("<TABLE name=TimesheetListTable id=EmployeeListTable CellSpacing=0  Width='99.9%' >")
        ' Plot the Header Row 
        CommonFunction.General.WriteHTML("<TR style='BORDER-RIGHT: #fff 2px solid; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
        ' Timesheet No
        CommonFunction.General.WriteHTML("<TD align ='Left' class='table_heading'>No</TD>")
        ' Project Name
        CommonFunction.General.WriteHTML("<TD align ='Left' class='table_heading'>Project Name</TD>")
        'From Date
        CommonFunction.General.WriteHTML("<TD align ='Left' class='table_heading'>From Date</TD>")
        'To Date
        CommonFunction.General.WriteHTML("<TD align ='Left' class='table_heading'>To Date</TD>")
        ' Comments
        CommonFunction.General.WriteHTML("<TD align ='Left' class='table_heading'>Comments</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        'For intCount = 0 To arrTimesheetNo.Length - 1
        strQuery = "usp_sel_tbl_PM_TimeSheetInvoiceForApproveOrReject  '" + strTimeSheetsNos.ToString + "'"
        drTimesheet = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If drTimesheet.Read Then
            strTimesheetNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetNo"), ""), "")
            strFromDateAppR = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("FromDate"), ""), "")
            strToDateAppR = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drTimesheet("ToDate"), ""), "")
            strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(HttpUtility.HtmlEncode(drTimesheet("ProjectName")), ""), "")

            CommonFunction.General.WriteHTML("<TR  STYLE='BACKGROUND: url(../../images/gradient_blue.gif) #e8f2f9 fixed repeat-x left top;'>")

            ' Timesheet No
            CommonFunction.General.WriteHTML("<TD align ='Left' class='table_content'>" + strTimesheetNo + "</TD>")

            ' Project Name
            CommonFunction.General.WriteHTML("<TD align ='Left' class='table_content'>" + strProjectName + "</TD>")
            ' From date
            CommonFunction.General.WriteHTML("<TD align ='Left' class='table_content'>" + CommonFunctions.Dates.GetDate(CType(strFromDateAppR, Date)) + "</TD>")
            ' To date
            CommonFunction.General.WriteHTML("<TD align ='Left' class='table_content'>" + CommonFunctions.Dates.GetDate(CType(strToDateAppR, Date)) + "</TD>")
            ' Start Date
            CommonFunction.General.WriteHTML("<TD align ='Left' class='table_content'>")

            Response.Write(CommonFunction.HTMLControls.DrawTextArea("Comment" + strTimeSheetsNos, "Comment" + strTimeSheetsNos, "Comment", "field", "opentextdialog", "frmTimesheetListing", , , 250, 50, , strComments, , , , , , , , True, True, , ))

            CommonFunction.General.WriteHTML("</TD>")

            CommonFunction.General.WriteHTML("</TR>")
        End If
        ' intRowCount += 1
        ' Next

        CommonFunction.General.WriteHTML("</TABLE>")
        CommonFunction.General.WriteHTML("</DIV>")
        If Request.QueryString("ToApprove") = "ToApprove" Then
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND: #dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
            CommonFunctions.General.WriteHTML("<TR ><TD align=Right> | <A " + strLinkCss + "  HREF=""Javascript:FinalAuthenticate_OnClick()"" Title='Approve' >Approve</A> | <A " + strLinkCss + "  HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> |</TD></TR></TABLE>") '" & strTimeSheetNo & "'| <A " + strLinkCss + "  HREF='Javascript:Help_OnClick('TL')' Title='Help' >&nbsp;?&nbsp;</A> 
            strComments = "Approved On " + CommonFunction.Dates.GetDate(Now())
        End If
        If Request.QueryString("ToReject") = "ToReject" Then
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 width='100%' style='BORDER-RIGHT: #fff 2px solid; PADDING-RIGHT: 2px; PADDING-LEFT: 30px; ; BACKGROUND:#dae3ee; COLOR: #222; HEIGHT: 25px; TEXT-ALIGN: left'>")
            CommonFunctions.General.WriteHTML("<TR ><TD align=Right> | <A " + strLinkCss + "  HREF=""Javascript:FinalReject_OnClick()"" Title='Reject' >Reject</A> | <A " + strLinkCss + "  HREF='Javascript:Close_OnClick()' Title='Close' >Close</A> |</TD></TR></TABLE>") '" & strTimeSheetNo & "' <A " + strLinkCss + "  HREF='Javascript:Help_OnClick('TL')' Title='Help' >&nbsp;?&nbsp;</A> |
        End If

        CommonFunctions.Data.DisposeDataReader(drTimesheet)
    End Sub

#Region "Accept or Reject TimeSheet"
    'When Timesheet is Approved The Approval Related Functionality  is Written Bellow
    Private Sub Authenticate_Timesheet()
        '==================================================================================
        ' Procedure Name	:	Authenticate_Timesheet
        ' Purpose			:	This procedure Autheticate the Selected Timesheets.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	VijayD
        ' Created			:	12 June 2008
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim strTimeSheetsNos As String = ""
        ' Dim arrTimesheetNo() As String
        Dim intCount As Integer = 0
        Dim stremployeename As String
        Dim m_strTimesheetStatus_ApproveORReject As String
        Dim strcomment As String = ""
        Dim strTimesheetIDs As String = ""

        strTimeSheetsNos = Request.QueryString("TimesheetNo_PK").ToString

        If strTimeSheetsNos <> "" Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'm_strTimesheetStatus_ApproveORReject = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select TimesheetStatus From v_tbl_PM_TimeSheetInvoice Where TimeSheetNo=" + strTimeSheetsNos, MyBase.UseSQL), ""), String)
            m_strTimesheetStatus_ApproveORReject = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_v_tbl_PM_TimeSheetInvoice_TimesheetStatus " + strTimeSheetsNos, MyBase.UseSQL), ""), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            If m_strTimesheetStatus_ApproveORReject.ToUpper <> "APPROVED" And m_strTimesheetStatus_ApproveORReject.ToUpper <> "REJECTED" Then
                'strcomment = MyBase.FixString(MyBase.GetFormValue("Comment" + strTimeSheetsNos), 0, False, False)
                strcomment = HttpContext.Current.Request.Form("Comment" + strTimeSheetsNos).ToString

                Dim strMailTo As String = ""
                Dim strFromMail As String = ""
                Dim strSubject As String = ""
                Dim strMessage As String = ""
                Dim drEmailMessage As IDataReader
                Dim strCCToEmailID As String = ""
                Dim blnSendEmail As Boolean

                Dim blnShowPopup As Boolean


                Dim drTSAuthenticatedBy As IDataReader
                Dim drReciever As IDataReader

                drTSAuthenticatedBy = CommonFunction.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + strTimeSheetsNos, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drTSAuthenticatedBy.Read Then

                    If drTSAuthenticatedBy("AuthenticatedBy").ToString = "C" Then
                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=(SELECT CustomerID FROM tbl_PM_Project WHERE ProjectID=(SELECT ProjectID FROM tbl_PM_TimesheetInvoice WHERE TimesheetNo=" + strTimeSheetsNos + "))", True), String)
                        stremployeename = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Customer_Timesheetwise_CustomerName " + strTimeSheetsNos, True), String)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 4", MyBase.UseSQL)
                        If drEmailMessage.Read Then
                            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                        End If
                        CommonFunction.Data.DisposeDataReader(drEmailMessage)
                        If blnSendEmail = True And blnShowPopup = True Then
                            Response.Write("<Script language='javascript'>")
                            CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=4&TimeSheetID=" + strTimeSheetsNos + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                            Response.Write("</Script>")
                        End If

                        If blnSendEmail = True And blnShowPopup = False Then
                            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_4(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(strTimeSheetsNos, Long))
                            CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
                        End If

                    Else
                        stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
                        SendMailToCustomer(CType(strTimeSheetsNos, Long))
                    End If

                End If
                CommonFunctions.Data.DisposeDataReader(drTSAuthenticatedBy)

                strQuery = "usp_Upd_tbl_PM_TimeSheetInvoice '" + strTimeSheetsNos + "','" + strcomment + "','" + stremployeename + "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            Else
                strTimesheetIDs = strTimesheetIDs + strTimeSheetsNos + ","
            End If
            '  Next
        End If
        If strTimesheetIDs <> "" Then
            Response.Write(" <SCRIPT> alert('" + " These Timesheets : " + Left(strTimesheetIDs, strTimesheetIDs.Length - 1) + " are already " + " Approved ! ""'); </SCRIPT>")
        End If
        strTimesheetIDs = ""

        If Request.QueryString("FinalApproved") = "FinalApproved" Then

            Response.Write("<Script language='javascript'>")
            CommonFunctions.General.WriteHTML("var parent=window.opener.opener;" + vbCrLf)
            CommonFunctions.General.WriteHTML("if(parent!=null){" + vbCrLf)
            CommonFunctions.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf)
            Response.Write("window.opener.close();")
            Response.Write("window.close();")
            CommonFunctions.General.WriteHTML("}else{" + vbCrLf)
            Response.Write("window.opener.opener.location.href=window.opener.opener.location.href;")
            Response.Write("window.close();")
            CommonFunctions.General.WriteHTML("}" + vbCrLf)
            Response.Write("</Script>")
        End If
    End Sub

    Private Sub Reject_Timesheet()
        '==================================================================================
        ' Procedure Name	:	Reject_Timesheet
        ' Purpose			:	This procedure Reject  the Selected Timesheets.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	VijayD
        ' Created			:	12 June 2008
        ' Revisions			:	
        '==================================================================================
        Dim strTimeSheetsNos As String
        Dim intCount As Integer
        'Dim arrTimesheetNo() As String
        Dim strcomment As String = ""
        Dim stremployeename As String
        Dim strTimesheetIDs As String
        strTimeSheetsNos = Request.QueryString("TimesheetNo_PK").ToString
        strTimesheetIDs = ""
        If strTimeSheetsNos <> "" Then
            ' arrTimesheetNo = strTimeSheetsNos.Split(CType(",", Char))
            '  For intCount = 0 To arrTimesheetNo.Length - 2

            ' strcomment = MyBase.FixString(MyBase.GetFormValue("Comment" + strTimeSheetsNos), 0, False, False)
            strcomment = HttpContext.Current.Request.Form("Comment" + strTimeSheetsNos).ToString
            Dim stRejectSQL As String = ""
            Dim strMailTo As String = ""
            Dim strFromMail As String = ""
            Dim strSubject As String = ""
            Dim strMessage As String = ""
            Dim drEmailMessage As IDataReader
            Dim strCCToEmailID As String = ""
            Dim blnSendEmail As Boolean

            Dim blnShowPopup As Boolean


            Dim drTSAuthenticatedBy As IDataReader
            Dim drReciever As IDataReader

            drTSAuthenticatedBy = CommonFunction.Data.GetDataReader("EXEC usp_Sel_TimeSheetAuthenticationType " + strTimeSheetsNos, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drTSAuthenticatedBy.Read Then

                If drTSAuthenticatedBy("AuthenticatedBy").ToString = "C" Then
                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=(SELECT CustomerID FROM tbl_PM_Project WHERE ProjectID=(SELECT ProjectID FROM tbl_PM_TimesheetInvoice WHERE TimesheetNo=" + strTimeSheetsNos + "))", True), String)
                    stremployeename = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Customer_Timesheetwise_CustomerName " + strTimeSheetsNos, True), String)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 5", MyBase.UseSQL)
                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunction.Data.DisposeDataReader(drEmailMessage)
                    If blnSendEmail = True And blnShowPopup = True Then
                        Response.Write("<Script language='javascript'>")
                        CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=5&TimeSheetID=" + strTimeSheetsNos + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                        Response.Write("</Script>")
                    End If

                    If blnSendEmail = True And blnShowPopup = False Then
                        CommonFunction.EmailMessages.FAMessages.GetEmailMessage_5(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(strTimeSheetsNos, Long))
                        CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
                    End If
                Else
                    stremployeename = CType(CommonFunctions.Data.GetDataScalar("SELECT EmployeeName FROM tbl_PM_Employee WHERE EmployeeID=" + CType(Session("intUserID"), String), True), String)
                    drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 442", MyBase.UseSQL)
                    If drEmailMessage.Read Then
                        blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                        blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                    End If
                    CommonFunction.Data.DisposeDataReader(drEmailMessage)
                    If blnSendEmail = True And blnShowPopup = True Then
                        Response.Write("<Script language='javascript'>")
                        CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=442&TimeSheetID=" + strTimeSheetsNos + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                        Response.Write("</Script>")
                    End If

                    If blnSendEmail = True And blnShowPopup = False Then
                        CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(strFromMail, strMailTo, strCCToEmailID, strSubject, strMessage, CType(strTimeSheetsNos, Long))
                        CommonFunction.Emails.AppSendEmailWithCC(strMailTo, strFromMail, strCCToEmailID, strSubject, strMessage)
                    End If
                End If
            End If
            stRejectSQL = "usp_Upd_tbl_PM_TimeSheetInvoice_For_Rejection " + strTimeSheetsNos + ",'" + strcomment + "','" + stremployeename + "'"
            CommonFunctions.Data.InsertOrUpdateData(stRejectSQL, MyBase.UseSQL)

        End If

        Response.Write("<Script language='javascript'>")
        CommonFunctions.General.WriteHTML("var parent=window.opener;" + vbCrLf)
        CommonFunctions.General.WriteHTML("if(parent!=null){" + vbCrLf)
        CommonFunctions.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf)
        Response.Write("window.opener.close();")
        Response.Write("window.close();")
        CommonFunctions.General.WriteHTML("}else{" + vbCrLf)
        Response.Write("window.opener.opener.location.href=window.opener.opener.location.href;")
        Response.Write("window.close();")
        CommonFunctions.General.WriteHTML("}" + vbCrLf)
        Response.Write("</Script>")
    End Sub

    Private Sub SendMailToCustomer(ByVal lngTimeSheetId As Long)
        '==================================================================================
        ' Procedure Name	:	SendMailToCustomer
        ' Purpose			:	This procedure Send the EMail to the Customer.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	16-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strMailTo As String = ""
        Dim strFromMail As String = ""
        Dim strSubject As String = ""
        Dim strMessage As String = ""
        Dim strCCEamilID As String = ""

        Dim drEmailMessage As IDataReader
        Dim blnSendEmail As Boolean
        Dim blnShowPopup As Boolean
        drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 6", MyBase.UseSQL)
        If drEmailMessage.Read Then
            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drEmailMessage)
        If blnSendEmail = True And blnShowPopup = True Then
            Response.Write("<Script language='javascript'>")
            CommonFunctions.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=6&TimeSheetID=" + lngTimeSheetId.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
            Response.Write("</Script>")
        End If

        If blnSendEmail = True And blnShowPopup = False Then
            CommonFunction.EmailMessages.FAMessages.GetEmailMessage_6(strFromMail, strMailTo, strCCEamilID, strSubject, strMessage, lngTimeSheetId)
            CommonFunction.Emails.AppSendEmail(strMailTo, strFromMail, strSubject, strMessage)
        End If

    End Sub
#End Region


#End Region

End Class