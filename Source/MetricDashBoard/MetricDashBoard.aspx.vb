Imports System.Drawing

Public Class MetricDashBoard
    Inherits Whiz.WebPage.Templates.ProjectByNetTemplate

#Region " Member Variables "

    '--- Constant for Graph Directory
    ''Private GRAPH_DIRECTORY_MDB As String

    Private GRAPH_DIRECTORY As String ''= "../../images/BrickRed/"
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer

    Private m_intChartAreaWidth As Integer
    Private m_intChartArea_X_Position As Integer
    Private m_intChartArea_Y_Position As Integer
    Private m_intInnerPlotPosition_X As Integer
    Private m_intInnerPlotPosition_Y As Integer

    Private m_strPalleteSytle As String
    Private m_TabName As String

    Protected m_ProjectID As String
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
    Protected m_strProjectName As String
    Protected m_strFROMwhere As String
    Protected m_strConnectionString As String = CommonFunction.Application.ConnectionString
    Protected m_blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Protected m_strMetricID As String = ""
    Protected m_strHTMLDiv As String = ""
    Protected m_intCnt As Integer = 0
    Protected m_strMode As String = ""

    ''END ADDED BY AMIT MAHADIK 0N 11 MAY 2011 WHIZIBLE SEM 10.0,For dashboard
    Public m_intGraphCount As Integer = 2
    Protected m_intCurrentGraphCount As Integer = 1
    Protected m_GraphDisplay As Boolean = False

    Protected m_GImageName As String = ""
    Protected m_strProjectTypeID As String = ""
    Protected m_strPMIID As String
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Public strMetricView As String = ""
    Protected dsGraph As DataSet

#End Region

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Public Sub DrawPage()
        
        m_strFROMwhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FROM"), "NULL").ToString()
        ''''CommonFunctions.General.WriteHTML("<div id ='rapper' name='rapper' Style='overflow:auto;height:680px;width:100%'><div id='tab_1111' style='width:99.99%;height:99.99%;' ><table cellSpacing='0' cellPadding='0' border='0' style='width:100%'>")



        Call SetValueDetails()

        Call DrawDashBoardProjectListComboBox()


        If m_strFROMwhere.ToUpper() = "MDB" Then
            '' Call PageInit()
        End If


        ''''CommonFunctions.General.WriteHTML("</div>")

        

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
        CommonFunctions.General.WriteHTML("<div id='tab_1' style='display:block;'><table class='container' ' width='100%' cellpadding='0' cellspacing='0'><tr >") '
        CommonFunctions.General.WriteHTML("<td  align='left' valign='center' height='30px' class='container_header_PPDB' style='HEIGHT: 25px;text-decoration: none;'>")

        'CommonFunctions.General.WriteHTML("<a href=javascript:ShowSummary_ProjectSTab('Summary'," + CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), String) + ",'0') > ")
        'CommonFunctions.General.WriteHTML("Summary</a>")

        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select Project&nbsp;&nbsp;")
        ''' m_EmployeeID = CType(CommonFunctions.General.CheckIsNothing(Session("intUserID"), "0"), String)
        '*********************************************************************************
        Dim drTabs As IDataReader
        Dim strSql As String
        Dim intCount As Integer = 2
        Dim m_drProjectID As String
        Dim m_drProjectName As String

        If (m_LoginType.ToLower = "c") Then
            strSql = " usp_sel_AccessibleProjectListDB " + m_intUserID + ",'C'"
        Else
            strSql = " usp_sel_AccessibleProjectListDB " + m_intUserID + ",'E'"
        End If
        drTabs = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
        intCount = 1
        'Commented And Edited by KIRAN K K FOR issue id:2435 on 1-11-15
        'CommonFunctions.General.WriteHTML("<select id='cboProjectList' class='clsComboBoxBlue' onchange=""Project_MetricLink_OnClick()"" >")
        CommonFunctions.General.WriteHTML("<select id='cboProjectList' class='clsComboBox' onchange=""Project_MetricLink_OnClick()"" >")
        'Commented And Edited End by KIRAN K K FOR issue id:2435 on 1-11-15
        CommonFunctions.General.WriteHTML("<option value='")
        CommonFunctions.General.WriteHTML("-1")
        CommonFunctions.General.WriteHTML("'>")
        CommonFunctions.General.WriteHTML("---Select Project---")
        CommonFunctions.General.WriteHTML("</option>")
        Do While drTabs.Read
            '''''ShowSummary_ProjectSTab('Project'," + m_drProjectID + "," + intCount.ToString + ");
            m_drProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drTabs("ProjectName"), ""), String)
            m_drProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drTabs("ProjectID"), ""), String)
            ''NitinC
            'If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0").ToString() = "0" Then
            '    m_ProjectID = m_drProjectID
            'End If
            'If CommonFunctions.General.CheckIsNothing(Request.QueryString("strProjectName"), "Summary").ToString = "Summary" Then
            '    m_strProjectName = m_drProjectName
            'End If
            'If CommonFunctions.General.CheckIsNothing(Request.QueryString("TabName"), "Summary").ToString = "Summary" Then
            '    m_TabName = "Project"
            'End If
            ''End of NitinC
            CommonFunctions.General.WriteHTML("<option value='")
            CommonFunctions.General.WriteHTML(m_drProjectID)
            'Commented and added by NitinC on 23 Dec 2011 For WhizibleSEM 11.0
            'CommonFunctions.General.WriteHTML("'>")
            If m_ProjectID = m_drProjectID Then
                ''CommonFunctions.General.WriteHTML("'>")
                CommonFunctions.General.WriteHTML("'selected>")
                m_strProjectName = m_drProjectName
            Else
                CommonFunctions.General.WriteHTML("'>")
            End If
            'Commented and added by NitinC on 23 Dec 2011 For WhizibleSEM 11.0
            CommonFunctions.General.WriteHTML(m_drProjectName)
            CommonFunctions.General.WriteHTML("</option>")

            intCount += 1
        Loop
        drTabs = Nothing
        '*********************************************************************************
        ''''''CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", "usp_CDB_GetUserDashboardsForCombo " + m_EmployeeID + "," + m_RoleID, 250, "../MetricDashBoard/MetricDashBoard.aspx|0", "onchange=""JavaScript:cboDashboard_OnChange()""", , , "field")
        CommonFunctions.General.WriteHTML("</select>")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr></table></div>")
    End Sub

    Private Sub SetValueDetails()

        m_UserName = CommonFunctions.General.CheckIsNothing(Session("strUserName"), "").ToString()
        m_intUserID = CommonFunctions.General.CheckIsNothing(Session("intUserID"), "0")
        m_LoginType = CommonFunctions.General.CheckIsNothing(Session("LoginType"), "E")
        m_ProjectID = CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIDfromDB"), "0").ToString() ''CStr(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"))
        m_PKToken_Edit = CommonFunctions.Security.Token.GetToken(m_ProjectID.ToString + m_intUserID + "0" + "42")

    End Sub

    Protected Sub PageInit()
      
        InitVariables()
        If m_strMode.ToUpper = "SAVE" Then
            If m_intCnt = 0 Then
                m_intCnt = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCount"), 0)
            End If
            SaveOrderNumber(m_intCnt)
        End If

        m_strHTMLDiv = Replace(DrawOrderDiv(), """", "'")
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtCount", "txtCount", , , , m_intCnt, IsHidden:=True, returnHTML:=True))
        HttpContext.Current.Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtCount", "txtCount", , , , m_intCnt, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015
        If m_strMode.ToUpper = "ZOOM" Then
            PlotZOOM()
        ElseIf m_strMode.ToUpper = "PRINT" Then
            DrawPrintMenu()
            HttpContext.Current.Response.Write("<br>")
            DrawPageCaption("Project :  " & m_strProjectName)
            '  DrawPrintPage()
            'HttpContext.Current.Response.Write("<div id ='DivList' name='DivList' Style='overflow:auto;height:490px;width:100%'>")
            Call InitGraph()
            'HttpContext.Current.Response.Write("</div>")
            DrawPrintMenu()
            'PlotPrint()
        Else
            Call WriteMenu()
            HttpContext.Current.Response.Write("<br>")

            'Display Project Name
            DrawPageCaption("Project :  " & m_strProjectName)


            'HttpContext.Current.Response.Write("<div id ='DivList' name='DivList' Style='overflow:auto;height:480px;width:100%'>")
            HttpContext.Current.Response.Write("<div id ='DivList' name='DivList' Style='overflow:auto;height:100%;width:100%'>")
            Call InitGraph()
            HttpContext.Current.Response.Write("</div>")
            Call WriteMenu()
        End If


    End Sub

    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialize the Variables
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================

        Dim strSQL As String

        ''m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("mode"), "")
        'm_strMetricID = CommonFunctions.General.CheckIsNothing(Request.QueryString("MetricID"), "0")
        ' m_GImageName = CommonFunctions.General.CheckIsNothing(Request.QueryString("gImage"), "")

        GRAPH_DIRECTORY = CStr(CommonFunctions.General.CheckIsNothing((MyBase.GetResourceString("GRAPH_DIRECTORY")), "..\..\Images\"))


        If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), ""), String) <> "" Then
            m_strFromWhere = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), ""), String)
        End If

        'If m_strFromWhere = "SEM" Then
        '    Dim drConnectionDetails As IDataReader
        '    drConnectionDetails = CommonFunctions.Data.GetDataReader("select ConnectionString from V_Get_MetricConnectionString_Details", MyBase.UseSQL, m_strConnectionString)
        '    If drConnectionDetails.Read Then
        '        m_strConnectionString = CommonFunctions.General.DecryptString(CommonFunctions.General.CheckIsNothing(drConnectionDetails(0), m_strConnectionString))
        '    End If
        '    CommonFunctions.Data.DisposeDataReader(drConnectionDetails)
        'End If

        'strSQL = "Select Top 1 ProjectTypeID from tbl_PM_Project Where ProjectID=" & m_ProjectID
        'm_strProjectTypeID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL, m_strConnectionString), "0")

        'strSQL = "Select Top 1 PMIID from tbl_PRS_ProjectType_PMI where ProjectTypeID=" & m_strProjectTypeID
        'm_strPMIID = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL, m_strConnectionString), "0")

        strSQL = "Select Top 1 ProjectName from tbl_PM_Project Where ProjectID=" & m_ProjectID
        m_strProjectName = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL, m_strConnectionString), "")

        'Added by SrikanthY on 04 Jul 2007, to enable weekly logic while Generating datapoint report
        strMetricView = CommonFunctions.Data.GetDataScalar(" SELECT DBO.UDF_Get_TBL_MET_FREQUENCYTYPES(" & m_ProjectID.ToString & ") ", MyBase.UseSQL, m_strConnectionString)


    End Sub

    Sub InitGraph()
        '=====================================================================
        ' Procedure Name        : InitGraph()
        ' Purpose               : To Initialize the Draw graph Process
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandeepA
        ' Created               : Oct 26,2005
        ' Revisions             : 
        '=====================================================================

        'Variable Declaration
        Dim strSQL As String
        Dim intMetricID As Integer
        Dim lngQueryID As Long
        Dim strGraphSQL As String
        Dim strGraphName As String
        Dim intUCL As String
        Dim intLCL As String
        Dim lngItemID As Long
        Dim strMetricName As String
        Dim drMetrics As IDataReader
        Dim drQuery As IDataReader
        Dim strNoItemsToShowMessage As String
        Dim strGrpahType As String
        Dim strUrlForMap As String = ""

        Try
            'Count for number of graphs and plot of TD TR
            With HttpContext.Current.Response
                .Write("<TABLE Class=clsTable Width='100%'>")

            End With

            'Get Metrics for that PMI
            strSQL = "usp_SEL_tbl_MET_Metric_Project_Breakup_Mapping_Graph " & m_ProjectID.ToString
            drMetrics = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL, m_strConnectionString)
            While drMetrics.Read()
                intMetricID = drMetrics.Item("MetricID")
                strGrpahType = drMetrics.Item("GraphType")
                strSQL = " Exec USP_SEL_MetricSQL " + intMetricID.ToString + " , " + m_ProjectID.ToString
                drQuery = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL, m_strConnectionString)
                If drQuery.Read Then
                    strGraphSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drQuery("SQL"), ""), "")
                    intUCL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drQuery("UCL"), "0"), "0")
                    intLCL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drQuery("LCL"), "0"), "0")
                    strMetricName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drQuery("MetricName"), ""), "")
                End If
                CommonFunctions.Data.DisposeDataReader(drQuery)

                With HttpContext.Current.Response
                    .Write("<TR class=clsTREven>")
                    .Write("<TD align=Left >")
                End With

                'If m_intCurrentGraphCount = 1 Then
                '    With HttpContext.Current.Response
                '        .Write("<TR class=clsTREven>")
                '        .Write("<TD align=Left >")
                '    End With
                '    m_intCurrentGraphCount += 1
                'Else
                '    With HttpContext.Current.Response
                '        .Write("<TD align=Left >")
                '    End With
                '    m_intCurrentGraphCount += 1
                'End If

                'Draw Graph
                strGraphName = strMetricName '"Graph_" & strProjectName & "_" & intMetricID
                If strGraphSQL Is Nothing Or strGraphSQL = "" Then
                Else

                    strUrlForMap = "../MetricDashBoard/MetricDashBoard.aspx?mode=ZOOM&FromWhere=" + m_strFROMwhere + "&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&ProjectID_PK=" + m_ProjectID.ToString + "&ProjectID=" + m_ProjectID.ToString + "&MetricID=" + intMetricID.ToString
                    GenerateGraphNew(strGraphSQL, strGraphName, intUCL, intLCL, True, strUrlForMap, strGrpahType)
                End If

                With HttpContext.Current.Response
                    .Write("</TD>")
                    .Write("</TR>")
                    m_intCurrentGraphCount = 1
                End With

                'If m_intCurrentGraphCount > m_intGraphCount Then
                '    With HttpContext.Current.Response
                '        .Write("</TD>")
                '        .Write("</TR>")
                '        m_intCurrentGraphCount = 1
                '    End With
                'Else
                '    With HttpContext.Current.Response
                '        .Write("</TD>")
                '    End With
                'End If

            End While

            HttpContext.Current.Response.Write("</TABLE>")

            If m_GraphDisplay = False Then
                'Display the No Items to Show  Message
                strNoItemsToShowMessage = MyBase.GetResourceString("NO_ITEMS_TO_SHOW")
                'Plot table to inform the user that there are no record
                Response.Write("<BR>")
                CommonFunction.General.WriteHTML("<Table class=clsTable width='99.9%' cellspacing=0 border=0>")
                CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=center>" + strNoItemsToShowMessage)
                CommonFunction.General.WriteHTML("</TD></TR></Table>")
            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Function DrawOrderDiv() As String
        '=====================================================================
        ' Procedure Name        : DrawOrderDiv()
        ' Purpose               : To Plot The Metrics to set the order number
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Archanan 
        ' Created               : 9-Apr-2010
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String = ""
        Dim drMetric As IDataReader
        Dim strMetric As String = ""
        Dim intOrderNumber As Integer
        Dim sbHTML As New System.Text.StringBuilder("")
        Dim intMetricProjectMappingID As Integer

        strSQL = "USP_SEL_Metrics_OrderNumber " & CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectIDfromDB"), "0").ToString()
        drMetric = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHTML.Append("<Table  id='tblMenu' cellspacing='0' cellpadding='0'  width=99.9%>")
        sbHTML.Append("<TR>")
        sbHTML.Append("<TD align='Right'>")
        sbHTML.Append(" | <A class='Menu'  HREF='Javascript:SaveOrderNo_OnClick()' Title='Save' ><Img Border=0 src='../../Images/cssImages/Link images/Save.gif'></A>")
        sbHTML.Append(" | <A class='Menu'  HREF='Javascript:CloseDiv_OnClick()' Title='Close' ><Img Border=0 src='../../Images/cssImages/Link images/Close.gif'></A>")
        sbHTML.Append(" |</td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")

        sbHTML.Append("<Table  id='tblHead' cellspacing='0' cellpadding='0' width=99.0%>")
        sbHTML.Append("<TR class='clsTRColumnHeader'>")
        sbHTML.Append("<TD align='LEFT'><b>Set Order Number for Metrics Graphs</b></td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("<br>")

        sbHTML.Append("<Table width='99.9%' cellpadding=0 cellspacing=0 border=1 style='overflow:auto'>")
        sbHTML.Append("<Tr class=clsTRColumnHeader>")
        sbHTML.Append("<TD valign=top align=Left><b>Metric Name</b></td>")
        sbHTML.Append("<TD valign=top align=Center><b>Order Number</b></td>")
        sbHTML.Append("</tr>")
        m_intCnt = 0
        While drMetric.Read
            strMetric = CommonFunction.Data.CheckIsDBNull(drMetric("Name"), "")
            intOrderNumber = CommonFunction.Data.CheckIsDBNull(drMetric("OrderNo"), 0)
            intMetricProjectMappingID = CommonFunction.Data.CheckIsDBNull(drMetric("MetricProjectMappingID"), 0)

            sbHTML.Append("<Tr class=clsTREven>")
            sbHTML.Append("<TD valign=top align=Left>")
            sbHTML.Append(strMetric)
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtMappingID_" & m_intCnt, "txtMappingID_" & m_intCnt, , 50, 5, intMetricProjectMappingID, "Right", returnHTML:=True, IsHidden:=True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtMappingID_" & m_intCnt, "txtMappingID_" & m_intCnt, , 50, 5, intMetricProjectMappingID, "Right", returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True))
            ''''End Added By Vaijat K On 06/10/2015
            sbHTML.Append("</td>")

            sbHTML.Append("<TD valign=top align=Right>")
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrderNo_" & m_intCnt, "txtOrderNo_" & m_intCnt, , 50, 5, intOrderNumber, "Right", IsMandatory:=True, returnHTML:=True))
            sbHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOrderNo_" & m_intCnt, "txtOrderNo_" & m_intCnt, , 50, 5, intOrderNumber, "Right", IsMandatory:=True, returnHTML:=True, EnableHTMLEncode:=True))
            ''''End Added By Vaijat K On 06/10/2015
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            m_intCnt += 1
        End While
        sbHTML.Append("</table>")
        sbHTML.Append("<br>")
        sbHTML.Append("</div>")

        Return sbHTML.ToString
        sbHTML = Nothing
        strSQL = Nothing
        drMetric = Nothing
    End Function

    Sub WriteMenu()
        '=====================================================================
        ' Procedure Name        : WriteMenu()
        ' Purpose               : To Plot Menu
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandeepA
        ' Created               : Oct 26,2005
        ' Revisions             : 
        '=====================================================================

        'Plot Menu
        Dim objStaticMenu As New WebPages.Template.StaticMenu()

        Dim arrmenuNames() As String = {"Set Order Number" _
                                        , MyBase.GetResourceString("MENU_REPORT") _
                                        , MyBase.GetResourceString("MENU_PRINT_PREVIEW") _
                                        , MyBase.GetResourceString("MENU_HELP") _
                                        }
        ', MyBase.GetResourceString("MENU_CLOSE") _
        Dim arrmenuFunctions() As String = {"ChangeOrder()" _
                                            , "Project_Metric_Report(" + m_ProjectID.ToString + ")" _
                                            , "PrintPreview_OnClick()" _
                                            , "Help()" _
                                            }
        ', "Close_OnClick()" _
        Dim arrLinkToolTip() As String = {"Set Order Number" _
                                         , MyBase.GetResourceString("MENU_REPORT_TOOLTIP") _
                                         , MyBase.GetResourceString("MENU_PRINT_PREVIEW_TOOLTIP") _
                                         , MyBase.GetResourceString("MENU_HELP_TOOLTIP") _
                                        }
        ', MyBase.GetResourceString("MENU_CLOSE_TOOLTIP") _

        'Display Back Link MENU
        HttpContext.Current.Response.Write(WebPages.Template.StaticMenu.DrawMenu(arrmenuNames, arrmenuFunctions, arrLinkToolTip, False))

    End Sub

    Private Sub SaveOrderNumber(ByVal intCnt As Integer)
        Dim strSQL As String = ""
        Dim cnt As Integer = 0
        Dim strMetricProjectMappingIDs As String = ""
        Dim strOrderNumbers As String = ""

        While cnt < intCnt
            strMetricProjectMappingIDs += HttpContext.Current.Request.Form("txtMappingID_" & cnt) + ","
            strOrderNumbers += CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo_" & cnt), 0) + ","
            strSQL = "usp_Upd_Metrics_OrderNumber '" & strMetricProjectMappingIDs & "','" & strOrderNumbers & "'"
            cnt += 1
        End While
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        strSQL = Nothing
    End Sub

#Region "PRINT"
    Private Sub PlotPrint()
        '=====================================================================
        ' Procedure Name        : PlotPrint()
        ' Purpose               : To Plot Page for print graphs
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 8, 2005
        ' Revisions             : 
        '=====================================================================
        DrawPrintMenu()
        HttpContext.Current.Response.Write("<br>")

        DrawPageCaption("Project :  " & m_strProjectName)

        '  DrawPrintPage()

        DrawPrintMenu()
    End Sub
    Private Sub DrawPrintPage()
        '=====================================================================
        ' Procedure Name        : DrawPrintPage()
        ' Purpose               : Draw graphs for print
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 8, 2005
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String
        Dim drMetrics As IDataReader, drQuery As IDataReader
        Dim strMetricName As String, strImageFileName As String
        Dim strTempMetricID As String
        Dim intCount As Integer = 0
        Dim strresult As String = HttpContext.Current.Request.QueryString("ShowGraph")

        If strresult.ToUpper = "FALSE" Then
            'Display the No Items to Show  Message
            Dim strNoItemsToShowMessage = MyBase.GetResourceString("NO_ITEMS_TO_SHOW")
            'Plot table to inform the user that there are no record
            Response.Write("<BR>")
            'CommonFunction.General.WriteHTML("<div id ='DivList' name='DivList' Style='overflow:auto;height:490px;width:100%'>")
            CommonFunction.General.WriteHTML("<Table class=clsTable width='99.9%' height='99.9%' cellspacing=0 border=0>")
            CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=center>" + strNoItemsToShowMessage)
            CommonFunction.General.WriteHTML("</TD></TR></Table>")

            Exit Sub
        End If

        strSQL = "usp_SEL_Tbl_MET_Metrics_Graph " & m_ProjectID.ToString
        drMetrics = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL, m_strConnectionString)
        HttpContext.Current.Response.Write("<Table id=tblPrint name=tblPrint Class=clsTable Width='100%'  height='99.9%'>")
        While drMetrics.Read()
            intCount = intCount + 1

            strTempMetricID = drMetrics.Item("MetricID")
            strSQL = " Exec USP_SEL_MetricSQL " + strTempMetricID + " , " + m_ProjectID.ToString

            drQuery = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL, m_strConnectionString)
            If drQuery.Read Then
                strMetricName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drQuery("MetricName"), ""), "")
            End If
            CommonFunctions.Data.DisposeDataReader(drQuery)

            'strImageFileName = strMetricName & "__" & m_ProjectID
            strImageFileName = strMetricName & "__Metrics__" & m_ProjectID & CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            strImageFileName = strImageFileName.Trim

            If intCount Mod 2 <> 0 Then
                HttpContext.Current.Response.Write("<TR>")
            End If
            HttpContext.Current.Response.Write("<TD>")
            If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageFileName) & ".png") Then
                HttpContext.Current.Response.Write("<IMG align ='bottom' border=0 WIDTH=750 HEIGHT=260 src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
            Else
                HttpContext.Current.Response.Write("<IMG align ='bottom'  border=0 src='..\..\images\NoPreview.gif'>")
            End If

            HttpContext.Current.Response.Write("</TD>")
            If intCount Mod 2 = 0 Then
                HttpContext.Current.Response.Write("</TR>")
            End If

        End While
        If intCount Mod 2 <> 0 Then
            HttpContext.Current.Response.Write("<TD></TD>")
            HttpContext.Current.Response.Write("</TR>")
        End If
        CommonFunctions.Data.DisposeDataReader(drMetrics)

        HttpContext.Current.Response.Write("</Table>")

    End Sub
    Private Sub DrawPrintMenu()
        '=====================================================================
        ' Procedure Name        : DrawPrintMenu()
        ' Purpose               : Draw Print menu
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 8, 2005
        ' Revisions             : 
        '=====================================================================
        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML


        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MNU_PRINT")))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MNU_PRINT_TOOLTIP")))
        arrClientSideFunctionList.Add("Print_OnClick()")

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub
#End Region

#Region "ZOOM Functions"
    Private Sub PlotZOOM()
        '=====================================================================
        ' Procedure Name        : PlotZOOM()
        ' Purpose               : To plot Zoomed graphs
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        DrawZOOMMenu()
        HttpContext.Current.Response.Write("<br>")

        DrawPageCaption(MyBase.GetResourceString("SEC_METRIC_INFO"))
        DisplayMetricInfo()
        HttpContext.Current.Response.Write("<br>")

        DrawPageCaption(MyBase.GetResourceString("SEC_GRAPH"))
        DisplayZoomedGraph()
        HttpContext.Current.Response.Write("<br>")

        'HttpContext.Current.Response.Write("<div id ='DivList' name='DivList' Style='overflow:auto;height:630px;width:100%'>")
        'DrawPageCaption(" ")
        DisplayGraphDetail()
        'HttpContext.Current.Response.Write("</div>")

        HttpContext.Current.Response.Write("<br>")
        DrawZOOMMenu()

    End Sub

    Private Sub DisplayGraphDetail()
        '=====================================================================
        ' Procedure Name        : DisplayGraphDetail()
        ' Purpose               : To display graph detail
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String, strGraphSQL As String, strGridQuery As String
        Dim drQuery As IDataReader

        strSQL = " Exec USP_SEL_MetricSQL_List " + m_strMetricID + " , " + m_ProjectID.ToString

        drQuery = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL, m_strConnectionString)
        If drQuery.Read Then
            strGraphSQL = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drQuery("SQL"), ""), "")
        End If

        '----------To store the column Headings(user friendly name)-------
        Dim arrColumnHeadingList() As String = {MyBase.GetResourceString("COL_MONTH") _
                                                , MyBase.GetResourceString("COL_VALUE") _
                                                , "USL" _
                                                , "LSL" _
                                                , "UNIT" _
                                                }

        '---------Atual column name  -------------------------------------
        Dim arrActualColumnNames() As String = {"Snap Shot Month" _
                                                , "Value" _
                                                , "UCL" _
                                                , "LCL" _
                                                , "Unit" _
                                                }
        '-----------------------------------------------------------------
        Dim arrTDStyle() As String = {"align=left" _
                                    , "align=left" _
                                     , "align=left" _
                                      , "align=left" _
                                       , "align=left" _
                                    }
        '-----------------------------------------------------------------
        'strGridQuery = strGraphSQL.Replace("MM,-12", "MM,-60")
        strGridQuery = strGraphSQL
        '-----------------------------------------------------------------

        ' SrikanthY on 28 Jun 2007 Added below code, to Enable the Weekly view accroding to Users Setting in Company Information table [ For Whizible Metrics 3.0]
        Dim strMetricView As String
        strMetricView = CommonFunctions.Data.GetDataScalar(" SELECT DBO.UDF_Get_TBL_MET_FREQUENCYTYPES(" + m_ProjectID.ToString + ")  ", MyBase.UseSQL, m_strConnectionString)
        If strMetricView = "Weekly" Then
            arrColumnHeadingList.SetValue("Date", 0)
            arrActualColumnNames.SetValue("Snap Shot Date", 0)
        End If
        'End of Addition by SrikanthY on 28 Jun 2007


        ''''Added By Vaijat K On 06/10/2015
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        ''''End Added By Vaijat K On 06/10/2015
        If strGridQuery <> "" Then
            With m_objGrid
                .ActualColumnArray = arrActualColumnNames
                .UserFriendlyColumnArray = arrColumnHeadingList
                .NoOfDataColumns = 5
                .TDStyleArray = arrTDStyle
                .DIVStyle = "overflow:none"
                .ColNameToolTipOnEachRow = True
                .SQL = strGridQuery
                .UseSQL = MyBase.UseSQL
                .PrimaryKey = "HistoryID"
                .DIVHeight = 100
                .ConnectionString = m_strConnectionString
                ''''Added By Vaijat K On 06/10/2015
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                ''''End Added By Vaijat K On 06/10/2015
                .DrawGrid()
            End With
        End If
        m_objGrid = Nothing

    End Sub

    Private Sub DisplayZoomedGraph()
        '=====================================================================
        ' Procedure Name        : DisplayZoomedGraph()
        ' Purpose               : To display zoomed Graph
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        HttpContext.Current.Response.Write("<Table bgColor=#d2e9ff  cellspacing=0  cellpadding=0 Width='100%'>")

        HttpContext.Current.Response.Write("<TR class=clsTREven>")
        HttpContext.Current.Response.Write("<TD class=clsTDEven align=center>")
        If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & m_GImageName) & ".png") Then
            HttpContext.Current.Response.Write("<IMG align ='bottom' WIDTH=750 HEIGHT=260 src='" + GRAPH_DIRECTORY + m_GImageName & ".png" & "'>")
        Else
            HttpContext.Current.Response.Write("<IMG align ='bottom' src='..\..\images\NoPreview.gif'>")
        End If
        HttpContext.Current.Response.Write("</TD>")
        HttpContext.Current.Response.Write("</TR >")

        HttpContext.Current.Response.Write("</Table>")
    End Sub

    Private Sub DisplayMetricInfo()
        '=====================================================================
        ' Procedure Name        : DisplayMetricInfo()
        ' Purpose               : To display metric details
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        Dim strQuery As String
        Dim drMetricInfo As IDataReader
        Dim strProjectName As String
        strProjectName = CommonFunction.Data.GetDataScalar("SELECT ProjectName FROM Tbl_PM_Project WHERE ProjectID = " + m_ProjectID.ToString, MyBase.UseSQL, m_strConnectionString)

        'strQuery = "select Name,Description,UDFormula From tbl_MET_MetricMaster Where MetricID=" & m_strMetricID
        strQuery = "select Name,Description,UDFormula From tbl_MET_Metric_Project_BreakUp_Mapping Where MetricID=" & m_strMetricID + " AND ProjectID = " + m_ProjectID.ToString
        drMetricInfo = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL, m_strConnectionString)
        If drMetricInfo.Read Then
            HttpContext.Current.Response.Write("<Table bgColor=#d2e9ff  cellspacing=0  cellpadding=0 Width='100%'>")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right >")
            HttpContext.Current.Response.Write("Project : ")
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left >")
            HttpContext.Current.Response.Write(strProjectName)
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write(MyBase.GetResourceString("CAP_METRICNAME"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMetricInfo("Name"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write(MyBase.GetResourceString("CAP_DESCRIPTION"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMetricInfo("Description"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write(MyBase.GetResourceString("CAP_FORMULA"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMetricInfo("UDFormula"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("</Table>")
        End If
        CommonFunctions.Data.DisposeDataReader(drMetricInfo)

    End Sub

    Private Sub DrawPageCaption(ByVal strCaption As String)
        '=====================================================================
        ' Procedure Name        : DrawPageCaption()
        ' Purpose               : To plot page caption
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        WebPages.Template.PageCaption.GetPageCaptions(, strCaption, , )
    End Sub

    Private Sub DrawZOOMMenu()
        '=====================================================================
        ' Procedure Name        : DrawZOOMMenu()
        ' Purpose               : To plot menu
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML

        arrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_HELP")))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_HELP_TOOLTIP")))
        arrClientSideFunctionList.Add("Help()")

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()
        ' Purpose               : To getarray from given arreyList
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : Nov 7, 2005
        ' Revisions             : 
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

#End Region

#Region "Generate Graph"
    '***************************************************************************************************
    'SrikanthY on 08 Aug 2007, Added Below code to plot Metric graphs with new style for Whizible Metrics 3.0
    'Functions for Plotting
    Public Sub GenerateGraphNew(ByVal strSQL As String, ByVal strGraphName As String, Optional ByVal intUCL As Integer = 10, Optional ByVal intLCL As Integer = 1, Optional ByVal MapRequired As Boolean = False, Optional ByVal MapUrl As String = "", Optional ByVal strGrpahType As String = "")
        '=====================================================================
        ' Procedure Name        : GenerateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SandeepA
        ' Created               : Oct 26,2005
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strImageFileName As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim m_strPalleteStyle As String
        Dim intGraphHeight As Integer = 300
        Dim intGraphWidth As Integer = 750
        Dim i As Integer, iRecordCount As Integer
        Dim strQuery As String
        Dim strGraphDescription As String = ""
        Dim sngMapCords() As Single = {0, 0, 300, 375}

        m_GraphDisplay = True

        Try
            dsGraph = CommonFunction.Data.GetDataSet(strSQL, "tblGraph", , , MyBase.UseSQL)
            iRecordCount = dsGraph.Tables("tblGraph").Rows.Count

            '-- Setting some main Graph Properties
            strItemName = strGraphName
            strImageFileName = strGraphName & "__Metrics__" & m_ProjectID & CommonFunctions.FileDirectory.GetUniqueFileName.Trim
            strImageFileName = strImageFileName.Trim
            strChartType = strGrpahType

            drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL, m_strConnectionString)

            '-- Build Array for specifying the Chart Type for each column
            ReDim arrstrChartType(drTemp.FieldCount - 1)
            For i = 0 To drTemp.FieldCount - 1
                arrstrChartType(i) = strChartType
            Next
            CommonFunctions.Data.DisposeDataReader(drTemp)

            blnShowLegends = True
            'blnEnable3D = True
            strNomenclature = "Test"
            blnShowCaptions = True
            m_strPalleteStyle = "EARTHTONES"
            ' Get Graph Height and Graph Width : Hardcoded as of now
            intGraphHeight = CInt(MyBase.GetResourceString("GRAPH_HEIGHT")) '300
            'intGraphWidth = CInt(MyBase.GetResourceString("GRAPH_WIDTH"))
            'iRecordCount = iRecordCount * 15
            'If CInt(MyBase.GetResourceString("GRAPH_WIDTH")) > iRecordCount Then
            '    intGraphWidth = CInt(MyBase.GetResourceString("GRAPH_WIDTH")) '375
            'Else
            '    intGraphWidth = iRecordCount
            'End If
            ' create the graph for the item value
            If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageFileName) & ".png") Then
                CommonFunctions.FileDirectory.DeleteFile(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageFileName) & ".png")
            End If

            objGraph = New Graph.Graph
            'HttpContext.Current.Response.Write("<DIV id ='DivGraph' name='DivGraph' Style='overflow:auto;height=285px;width:" + intGraphWidth.ToString + "px'>")
            HttpContext.Current.Response.Write("<DIV id ='DivGraph' name='DivGraph' Style='overflow:auto;height=300px;width:" + intGraphWidth.ToString + "px'>")
            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
                .ConnectionString = m_strConnectionString

                .VirtualImagePath = ""
                .Enable3D = False
                .ChartType = arrstrChartType
                Dim Chart As Dundas.Charting.WebControl.Chart
                '-- Take settings From Database table
                .BorderStyle = "None"
                .BorderColor = "Black"
                .GraphTitleColor = "white"
                .ChartBackColor = "Wheat"
                .ChartAreaColor = "White"
                .ShowLegends = blnShowLegends
                .LegendDocking = "Bottom"
                .LegendStyle = "Column"
                .LegendCaptionColor = "black"
                .PalleteStyle = "EARTHTONES"
                .EnableXAxis = True
                .EnableYAxis = True
                .EnableSmartLabels = True
                .ShowCaptions = blnShowCaptions
                .GraphTitleColor = "Black"
                '-- Fixed Settings
                .GraphTitle = strItemName
                .TitleFont = New Drawing.Font("verdana", 9, Drawing.FontStyle.Bold)
                ''Added and commented by PrashantSJ on 09 Oct 2007
                ''Purpose: to use dataset instead of sql
                '.SQL = strSQL
                .DataSet = dsGraph
                ''End of addition by PrashantSJ on 09 Oct 2007
                .UCL = intUCL
                .LCL = intLCL
                .XAxisInterval = 1
                .UCLSeriesName = "USL"
                .LCLSeriesName = "LSL"
                .LCLColor = "Green"
                .UCLColor = "Crimson"
                .Width = intGraphWidth
                .Height = intGraphHeight
                .ShowExplodedPie = False
                .LegendFont = New Drawing.Font("verdana", 8, Drawing.FontStyle.Regular)
                .BorderGradientColor = "WHITE"
                .BorderGradientStyle = "TOPBOTTOM"
                .ChartBackGradientColor = "WHITE"
                .ChartBackGradientStyle = "TOPBOTTOM"
                .ChartAreaGradientColor = "WHITE"
                .ChartAreaGradientStyle = "TOPBOTTOM"
                If MapRequired = True Then
                    .MapAreaCoordinates = sngMapCords
                    .MapAreaHREF = MapUrl + "&gImage=" + strImageFileName
                    .MapAreaTooltip = "ZOOM"
                End If
                .ChartAreaWidth = 98
                .LegendStyle = "column"
                ' Draw Graph
                .GenerateChartControl()
            End With

            dsGraph.Dispose()
            If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageFileName) & ".png") Then
                If MapRequired = True Then
                    'HttpContext.Current.Response.Write("<A href='" & MapUrl & "&gImage=" & strImageFileName & "' target='_blank'>")
                    HttpContext.Current.Response.Write("<A style='text-decoration:none'  href=""javascript:ZoomClick('" & MapUrl & "&gImage=" & strImageFileName & "')"" >")
                    HttpContext.Current.Response.Write("<IMG border=0 align ='bottom' HEIGHT=" & intGraphHeight & " WIDTH=" & intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
                    HttpContext.Current.Response.Write("</A>")
                Else
                    HttpContext.Current.Response.Write("<IMG border=0 align ='bottom' HEIGHT=" & intGraphHeight & " WIDTH=" & intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
                End If
            Else
                HttpContext.Current.Response.Write("<IMG  border=0 align ='bottom' src='..\..\images\NoPreview.gif'>")
            End If

        Catch ex As Exception
            'Action to be taken when an exception is raised
        End Try
        objGraph = Nothing
        HttpContext.Current.Response.Write("</DIV>")
    End Sub
    'End of Addititon by SrikanthY on 08 Aug 2007
    'Public Sub GenerateGraph(ByVal strSQL As String, ByVal strGraphName As String, Optional ByVal intUCL As Integer = 10, Optional ByVal intLCL As Integer = 1, Optional ByVal MapRequired As Boolean = False, Optional ByVal MapUrl As String = "")
    '    '=====================================================================
    '    ' Procedure Name        : GenerateGraph()
    '    ' Purpose               : To create the graph control
    '    ' Description           : Same as above
    '    ' Parameters Passed     : 
    '    ' Returns               : 
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : SandeepA
    '    ' Created               : Oct 26,2005
    '    ' Revisions             : 
    '    '=====================================================================
    '    Dim dr As IDataReader
    '    Dim drGraph, drTemp As IDataReader
    '    Dim objGraph As Graph.Graph
    '    Dim strChartType As String
    '    Dim strImageFileName As String = ""
    '    Dim blnShowLegends As Boolean = False
    '    Dim blnShowCaptions As Boolean = True
    '    Dim blnShowExplodedPie As Boolean = False
    '    Dim strItemName As String = ""
    '    Dim blnEnable3D As Boolean = False
    '    Dim lngEntityID As Long = 0
    '    Dim strNomenclature As String = ""
    '    Dim arrstrChartType() As String = {}
    '    Dim strVirtualImgPath As String
    '    Dim m_strPalleteStyle As String
    '    Dim intGraphHeight As Integer = 300
    '    Dim intGraphWidth As Integer = 375
    '    Dim i As Integer
    '    Dim strQuery As String
    '    Dim strGraphDescription As String = ""
    '    Dim sngMapCords() As Single = {0, 0, 300, 375}

    '    m_GraphDisplay = True

    '    Try


    '        '-- Setting some main Graph Properties
    '        strItemName = strGraphName
    '        strImageFileName = strGraphName & "__" & m_ProjectID
    '        strImageFileName = strImageFileName.Trim
    '        strChartType = "LINE"

    '        drTemp = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL, m_strConnectionString)

    '        '-- Build Array for specifying the Chart Type for each column
    '        ReDim arrstrChartType(drTemp.FieldCount - 1)
    '        For i = 0 To drTemp.FieldCount - 1
    '            arrstrChartType(i) = strChartType
    '        Next
    '        CommonFunctions.Data.DisposeDataReader(drTemp)

    '        blnShowLegends = True
    '        'blnEnable3D = True
    '        strNomenclature = "Test"
    '        blnShowCaptions = True
    '        m_strPalleteStyle = "EARTHTONES"
    '        ' Get Graph Height and Graph Width : Hardcoded as of now
    '        intGraphHeight = CInt(MyBase.GetResourceString("GRAPH_HEIGHT")) '300
    '        intGraphWidth = CInt(MyBase.GetResourceString("GRAPH_WIDTH")) '375
    '        ' create the graph for the item values
    '        objGraph = New Graph.Graph

    '        With objGraph
    '            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
    '            .VirtualImagePath = strVirtualImgPath
    '            .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
    '            .ConnectionString = CommonFunction.Application.ConnectionString

    '            .VirtualImagePath = ""
    '            .Enable3D = False
    '            .ChartType = arrstrChartType
    '            Dim Chart As Dundas.Charting.WebControl.Chart
    '            '-- Take settings From Database table
    '            .BorderStyle = "FrameTitle5"
    '            .BorderColor = "BurlyWood"
    '            .GraphTitleColor = "white"
    '            .ChartBackColor = "Cornsilk"
    '            .ChartAreaColor = "Wheat"
    '            .ShowLegends = blnShowLegends
    '            .LegendDocking = "right"
    '            .LegendStyle = "Column"
    '            .LegendCaptionColor = "black"
    '            .PalleteStyle = "EARTHTONES"
    '            .EnableXAxis = True
    '            .EnableYAxis = True
    '            .EnableSmartLabels = True
    '            .ShowCaptions = blnShowCaptions
    '            .GraphTitleColor = "White"
    '            '-- Fixed Settings
    '            .GraphTitle = strItemName
    '            .TitleFont = New Font("verdana", 9, FontStyle.Bold)
    '            .SQL = strSQL
    '            .UCL = intUCL
    '            .LCL = intLCL
    '            .LCLColor = "Green"
    '            .UCLColor = "Crimson"
    '            .Width = intGraphWidth
    '            .Height = intGraphHeight
    '            .ShowExplodedPie = False
    '            .LegendFont = New Font("verdana", 8, FontStyle.Regular)
    '            .BorderGradientColor = "WHITE"
    '            .BorderGradientStyle = "TOPBOTTOM"
    '            .ChartBackGradientColor = "WHITE"
    '            .ChartBackGradientStyle = "TOPBOTTOM"
    '            .ChartAreaGradientColor = "WHITE"
    '            .ChartAreaGradientStyle = "TOPBOTTOM"
    '            If MapRequired = True Then
    '                .MapAreaCoordinates = sngMapCords
    '                .MapAreaHREF = MapUrl + "&gImage=" + strImageFileName
    '                .MapAreaTooltip = "ZOOM"
    '            End If

    '            ' Draw Graph
    '            .GenerateChartControl()
    '        End With


    '        If CommonFunctions.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(GRAPH_DIRECTORY & strImageFileName) & ".png") Then
    '            If MapRequired = True Then
    '                'HttpContext.Current.Response.Write("<A href='" & MapUrl & "&gImage=" & strImageFileName & "' target='_blank'>")
    '                HttpContext.Current.Response.Write("<A href=""javascript:ZoomClick('" & MapUrl & "&gImage=" & strImageFileName & "')"" >")
    '                HttpContext.Current.Response.Write("<IMG align ='bottom' HEIGHT=" & intGraphHeight & " WIDTH=" & intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
    '                HttpContext.Current.Response.Write("</A>")
    '            Else
    '                HttpContext.Current.Response.Write("<IMG align ='bottom' HEIGHT=" & intGraphHeight & " WIDTH=" & intGraphWidth & " src='" + GRAPH_DIRECTORY + strImageFileName & ".png" & "'>")
    '            End If
    '        Else
    '            HttpContext.Current.Response.Write("<IMG align ='bottom' src='..\..\images\NoPreview.gif'>")
    '        End If

    '    Catch ex As Exception
    '        'Action to be taken when an exception is raised
    '    End Try
    '    objGraph = Nothing

    'End Sub
    '*****************************************************************************************************

#End Region

End Class