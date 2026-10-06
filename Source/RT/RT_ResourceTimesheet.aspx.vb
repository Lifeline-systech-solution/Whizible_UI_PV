
#Region "Imports"
Imports WebPages.Security
Imports WebPages.Template
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports System.Text
#End Region

Public Class RT_ResourceTimesheet
    Inherits WebPages.Template.WhizTemplate

    Private Function IsTimeSheetGenerated() As Boolean
        '====================================================================
        ' Function Name        : IsTimeSheetGenerated
        ' Parameters Passed     : None
        ' Returns               : Boolean
        ' Parameters Affected   : None
        ' Purpose               : Determines whether Timesheet Is Generated 
        ' Description           : Determines whether Timesheet Is Generated. If the Timesheet is generated
        '                         then the function returns TRUE else FALSE
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : 
        ' Created               : Noble K
        ' Created Date          : 13th Jan 2005
        ' Revisions             :
        '=====================================================================

        Dim drTimeSheetGenerated As IDataReader
        '  Dim strSQLQuery As String
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim dblDATimeSheetHrs As Double

        strSQLQuery.Append("SELECT TimeSheetID ")
        strSQLQuery.Append(" FROM tbl_PM_ResourceTimesheet ")
        strSQLQuery.Append(" WHERE EmployeeID = " & CStr(m_intUserID))
        strSQLQuery.Append(" And FromDate = '" & CStr(m_dtFromDate) & "' AND ToDate = '" & CStr(m_dtToDate) & "'")

        drTimeSheetGenerated = CommonFunctions.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        If drTimeSheetGenerated.Read() Then
            m_blnTimeSheetGenerated = True
        End If
        CommonFunctions.Data.DisposeDataReader(drTimeSheetGenerated)
        strSQLQuery = Nothing
    End Function

    Private Function IsDAsPresentInTimeSheet() As Boolean
        '====================================================================
        ' Function Name        : IsDAsPresentInTimeSheet
        ' Parameters Passed     : None
        ' Returns               : Boolean
        ' Parameters Affected   : None
        ' Purpose               : Determines whether DAs are present for a Generated Timesheet
        ' Description           : If a DA is present for a Generated Timesheet then the boolean
        '                         variable returns TRUE else FALSE
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : 
        ' Created               : Noble K
        ' Created Date          : 13th Jan 2005
        ' Revisions             :
        '=====================================================================

        Dim drDAsPresentInTimeSheet As IDataReader
        Dim strSQLQuery As New System.Text.StringBuilder
        Dim dblDATimeSheetHrs As Double

        strSQLQuery.Append("SELECT DATimeSheetHrs = ISNULL(SUM(Duration),0) ")
        strSQLQuery.Append(" FROM tbl_PM_DailyActivity ")
        strSQLQuery.Append(" WHERE EmployeeID = " & CStr(m_intUserID) & " And ResourceTimeSheetID Is Not Null ")
        strSQLQuery.Append(" And EntryDate BETWEEN '" & CStr(m_dtFromDate) & "' AND '" & CStr(m_dtToDate) & "'")

        drDAsPresentInTimeSheet = CommonFunctions.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        If drDAsPresentInTimeSheet.Read() Then
            dblDATimeSheetHrs = CType(drDAsPresentInTimeSheet("DATimeSheetHrs"), Double)
            If dblDATimeSheetHrs > 0 Then
                m_blnDAsPresentInTimeSheet = True
                'added By VidyaJ - IssueID - 11778
                mblnZeroHrsDA = False
            Else
                mblnZeroHrsDA = True
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drDAsPresentInTimeSheet)

        '====================================================================================================
        'Block Returns No. of DAs present for the given period irrespective of their timesheet generated status.
        '====================================================================================================
        strSQLQuery.Remove(0, strSQLQuery.ToString.Length)
        strSQLQuery.Append("SELECT DATimeSheetCount = DailyActivityEntryID ")
        strSQLQuery.Append(" FROM tbl_PM_DailyActivity ")
        strSQLQuery.Append(" WHERE EmployeeID = " & CStr(m_intUserID))
        strSQLQuery.Append(" And EntryDate BETWEEN '" & CStr(m_dtFromDate) & "' AND '" & CStr(m_dtToDate) & "'")
        'Modified By VidyaJ - 11778
        m_intDACountForTimesheetPeriod = 0
        drDAsPresentInTimeSheet = CommonFunctions.Data.GetDataReader(strSQLQuery.ToString, MyBase.UseSQL)
        If drDAsPresentInTimeSheet.Read() Then
            m_intDACountForTimesheetPeriod = CType(drDAsPresentInTimeSheet("DATimeSheetCount"), Integer)
            m_blnDAsPresentInTimeSheet = True
        End If
        CommonFunctions.Data.DisposeDataReader(drDAsPresentInTimeSheet)
        strSQLQuery = Nothing
    End Function

    '=====================================================================
    ' Page Name 	        :	ResourceTimesheet
    ' Purpose				:	Display pending Timesheets if any and generate Resource Timesheet of the 
    '                           logged in user
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	
    ' Author				:	Priyanka
    ' Created				:	19th July 2004
    ' Revisions				:	
    '=====================================================================

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
    Private WithEvents m_objMenu As New StaticMenu      'This variable is used for plotting static menu. 
    Private WithEvents m_objGrid As New GenericGrid     'This variable is use to plotting grid.
    Private WithEvents m_objAdvGrid As New WebPage.Templates.AdvancedGrid 'This variable is use to plotting advanced grid.
    Private m_objGlobal As IGlobal                      'This variable is of global object inteface. 
    Private m_objAccessRights As cAccessRights          'This variable is for access rights of page.
    Private strMenu As String                           'stores the static menu string.
    Private WithEvents obj As New WebPage.Templates.PageLegends

    '--- Constants for the Actions that this page performs
    Private Const MODE_VIEW_TIMESHEET As String = "View"
    Private Const MODE_GENERATE_TIMESHEET As String = "Generate"
    Private Const MODE_REGENERATE_TIMESHEET As String = "Regenerate"
    Private Const MODE_READY_FOR_VERIFICATION_TIMESHEET As String = "ReadyForVerification"

    '--- Constants for the Actions that this page performs
    Private Const ACTION_VIEW_TIMESHEET As String = "View"
    Private Const ACTION_EDIT_TIMESHEET As String = "Edit"
    Private Const ACTION_PENDING_TIMESHEET As String = "Pending"
    Private Const ACTION_NO_PENDING_TIMESHEET As String = "NoPending"

    '--- Constants for the Timesheet to be generated using the information from the Company Information
    Private Const ACTION_GENERATE_WEEKLY_TIMESHEET As String = "W"
    Private Const ACTION_GENERATE_FORNIGHTLY_TIMESHEET As String = "F"
    Private Const ACTION_GENERATE_MONTHLY_TIMESHEET As String = "M"

    '--- Constants for the Timesheet Status
    Private Const STATUS_NOT_READY_FOR_VERIFICATION As String = "N"
    Private Const STATUS_READY_FOR_VERIFICATION As String = "R"
    Private Const STATUS_VERIFIED As String = "V"
    Private Const STATUS_REJECTED As String = "J"

    '--- Constant for Graph Directory
    Private Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"

    Private Const MAIL_READY_FOR_VERIFICATION As Integer = 434

    Protected m_strWindowTitle As String                'Page Title
    Private m_strMode As String                         'Mode for the Page

    'Modified by MrugajaB on 02-Apr-2005
    'Purpose:Changed scope of variable from private to public
    Public m_strAction As String                       'Action for the Page
    'End Modification

    Private m_dtFromDate As Date                        'From Date 
    Private m_dtToDate As Date                          'To Date
    Private m_blnPendingTimesheet As Boolean            'If there are any pending Timesheets
    Private m_intUserID As Integer                      'User Id for whom Resource Timesheet is to be generated
    Private m_strEmployeeName As String                 'Name of the logged in employee 
    Private m_strRole As String                         'Role of the logged in employee 
    Private m_strEmployeeCode As String                 'EmployeeCode of the logged in employee 
    Private m_strDepartment As String                   'Department of the logged in employee 
    Private m_strLocation As String                     'Location of the logged in employee 
    Private m_strTimesheetStatus As String              'Timesheet Status code
    Private m_strTimesheetStatusDescription As String   'Timesheet Status decription
    Private m_intTimesheetID As Integer                   'Timesheet ID, if it is in the View Mode
    Private m_strTimesheetFrequency As String           'Frequency of timesheet to be generated as per Company Information setting
    Private m_intDayCounter As Integer                  'Day counter for displaying the link for Daily Activity entry
    Private m_intNoOfDays As Integer                    'Days with the week 
    Private m_blnShowRemarks As Boolean                 'Show Remarks if any are entered for the Resource Timesheet

    'Variables used to display graph
    Private m_strPalleteSytle As String
    Private m_intGraphHeight As Integer
    Private m_intGraphWidth As Integer

    Private m_strGroup1IsExpanded As String             'Maintaing if the Group 1 is expanded or collapsed for Monthly RT
    Private m_strGroup2IsExpanded As String             'Maintaing if the Group 2 is expanded or collapsed for Monthly RT

    'Variables for displaying the Totals
    Private m_strProjectSelected As String = ""
    Private m_arrDaywiseTotals As Double()
    Private m_dblGroupTotal As Double = 0
    Private m_dblProjectTotal As Double = 0


    Protected m_TagTaskDetails As Long = CommonFunction.Constants.APP_TAG_RES_TMSHEET_TASK_DETAILS
    Protected m_TagShowRemarks As Long = CommonFunction.Constants.APP_Tag_TIMESHEET_SHOW_REMARKS
    'Protected m_TagMyTimesheets As Long = 2120
    Protected m_TagMyTimesheets As Long = CommonFunction.Constants.APP_Tag_TIMESHEET_MYTIMESHEETS
    Protected m_TagTimesheetHisotryForEmployee As Long = CommonFunction.Constants.APP_TAG_RTS_SHOW_HISTORY_EMPLOYEE


    'Code Added by Noble K on 12th Jan 2005
    'This variable determines whether the TaskID is blank or not
    'Default value is set to false
    Private m_blnTimeSheetGenerated As Boolean
    Private m_blnDAsPresentInTimeSheet As Boolean
    Public m_intDACountForTimesheetPeriod As Integer
    'Code Added by Noble K on 12th Jan 2005

    'Added By VidyaJ - IssueID - 11778
    Public mblnZeroHrsDA As Boolean

    ' Added  by MrugajaB on 2nd March 2005
    Private m_intProjectID As Integer
    Private m_strApproverName As String = ""
    Private m_strProjectStatus As String = ""
    ' End of Addition

    'Added By Vidya - RT Performance Issue - 87 (SP4)
    Public m_intPrevProjectSelected As Integer = 0
    Public m_strProjectList As String = ""

    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
    Protected m_strToken As String
    Protected m_strTokenViewTimesheet As String
    Protected s_ParentTagID As Long = 0
    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

    '---- Added By purvaj on 13 Oct 2008 for Holiday, Leave and weekend changes.
    Dim blnFlag As Boolean = False
    '--- End addition purvaJ
    Protected str_Token As String
#End Region

#Region "Graphs"
    Private Sub CreateGraph()
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create Pie chart displaying Resource Timesheet Total Project wise
        ' Description           : Same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : July 21,2004
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
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
        Dim arr(1) As String

        Dim i As Integer
        Dim strQuery As String

        ' get the item details
        strSQL = " EXEC usp_sel_GetDADetails " + CStr(m_intUserID) + ",'" + CStr(m_dtFromDate) + "','" + CStr(m_dtToDate) + "'"

        drGraph = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drGraph.Read Then

            strItemName = MyBase.GetResourceString("HEADING_GRAPH_TITLE")
            strImageFileName = "DADetails" & m_intUserID
            blnShowLegends = True
            'blnEnable3D = True
            strNomenclature = "Test"
            blnShowCaptions = True

            ' create the graph for the item values
            objGraph = New Graph.Graph

            With objGraph
                strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
                .VirtualImagePath = strVirtualImgPath
                .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
                .ConnectionString = CommonFunction.Application.ConnectionString

                '.VirtualImagePath = ""
                .Enable3D = True
                arr(0) = "PIE"
                arr(1) = "PIE"
                .ChartType = arr
                .GraphTitleColor = "black"
                .ChartBackColor = "PaleGoldenRod"
                .ChartAreaColor = "GoldenRod"
                .ShowLegends = True
                .LegendDocking = "right"
                .LegendStyle = "column"
                .LegendCaptionColor = "black"
                .PalleteStyle = m_strPalleteSytle
                .EnableXAxis = True
                .EnableYAxis = True
                .EnableSmartLabels = False
                .ShowCaptions = True
                .GraphTitleColor = "Green"

                '-- Fixed Settings
                .GraphTitle = "DA Details"
                .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
                .SQL = strSQL
                .Width = m_intGraphWidth
                .Height = m_intGraphHeight
                .ShowExplodedPie = False
                .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

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
    '--Graph Functions
    Private Sub CreateGraphSection()
        '=====================================================================
        ' Procedure Name        : CreateGraphSection()
        ' Purpose               : Creates the Graph Section
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Jan 30, 2003
        ' Revisions             : 1.    HiteshS on 11th Jan.2005
        '                               To display section Title for Graph
        '                               for IssueID - 15222
        '                               Changes made at line .GetSectionTitle(
        '=====================================================================
        Dim strGraphDescription, strGraphFileName As String
        Dim strSP_Name_ForGraph As String
        Dim IsDrillDownGraph As Boolean
        Dim strLinkField, strGraphtype As String
        Dim objGraphSection As WebPages.Template.SectionTitle
        Dim tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
        Dim divGraphs As System.Web.UI.HtmlControls.HtmlControl

        m_strPalleteSytle = "EARTHTONES"
        m_intGraphHeight = 250

        'Integrated by MrugajaB on 27th Apr,2005 for WhizibleSEM SP3
        'Commented By PrajaktaR for PCFC IssueID 17514 on 21st April 2005 
        'm_intGraphWidth = 450
        'Added by PrajaktaR
        m_intGraphWidth = 750
        'End of Addition By PrajaktaR for PCFC IssueID 17514 on 21st April 2005

        '-- Print the Section 
        objGraphSection = New WebPages.Template.SectionTitle
        With objGraphSection
            Response.Write(.GetSectionTitle("Graph for Daily Activity Details", "DivOtherInfo", "ShowHideOtherInfo"))
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("GRAPH"), "DivOtherInfo", "ShowHideOtherInfo"))
            Response.Write(vbCrLf + "<SCRIPT language=javascript>" + vbCrLf)
            Response.Write(.ClientsideScript())
            Response.Write(vbCrLf + "</SCRIPT>" + vbCrLf)
        End With

        '--Div for section title
        Response.Write("<DIV Id='DivOtherInfo' Style='Overflow:Auto;Width=100%'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE Class=clsTable Width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=center width=100%>")

        '-- Call fn. to create the Graph Image
        Call CreateGraph()

        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & "DADetails") & CType(Session("intUserID"), String) & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + "DADetails" & CType(Session("intUserID"), String) & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If

        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")

        '--End of Graph Section's div
        Response.Write("</DIV>")
    End Sub
#End Region

#Region "Projectwise Totals"
    Private Function DisplayProjectwiseTotals() As String

        Dim intCount As Integer
        Dim strToBeInserted As String = ""
        'Dim strToBeReturned As String = ""
        Dim strToBeReturned As New System.Text.StringBuilder("")
        Dim intColspan As Integer = 0

        strToBeReturned.Append("<tr class='clsTRColumnHeader'><td nowrap align=left width='100%' colspan=2")
        strToBeReturned.Append(">")
        strToBeReturned.Append(MyBase.GetResourceString("HEADING_PROJECTWISE_TOTAL"))
        strToBeReturned.Append(" " & m_strProjectSelected)   '+ strToBeInserted
        strToBeReturned.Append("</td>")

        '--- Check the frequency of the Timesheet to be displayed and accordingly display the Projectwise totals
        If m_intNoOfDays > 15 Then
            If m_strGroup1IsExpanded = "0" Then
                strToBeReturned.Append("<td></td>")
            Else
                strToBeReturned.Append("<td colspan=15></td>")
            End If

            If m_strGroup2IsExpanded = "0" Then
                strToBeReturned.Append("<td></td>")
            Else
                strToBeReturned.Append("<td colspan=" + CStr(m_intNoOfDays - 15) + "></td>")
            End If
        Else
            strToBeReturned.Append("<td colspan=" + CStr(m_intNoOfDays) + "></td>")
        End If

        strToBeReturned.Append("<td align=right>" & FormatNumber(m_dblGroupTotal, 2))
        strToBeReturned.Append("</td></tr>")

        'Integrated by MrugajaB on 28th March 2005
        'Purpose:To Display approver and status for each timesheet
        ' Code Added by RajkumarM to Add Timesheet Verifier for that Project and Status on 2nd March
        If m_strTimesheetStatus <> STATUS_NOT_READY_FOR_VERIFICATION Then
            strToBeReturned.Append("<tr class='clsTRColumnHeader'><td align=left width='100%'colspan=2>")
            strToBeReturned.Append(MyBase.GetResourceString("HEADING_TIMESHEET_APPROVER") & ":")
            strToBeReturned.Append("<font color='blue'> " & m_strApproverName & "<font>")
            strToBeReturned.Append("</td>")
            'strToBeReturned &= "<td colspan=" + CStr(m_intNoOfDays) + "></td>"
            If m_intNoOfDays > 15 Then
                If m_strGroup1IsExpanded = "0" Then
                    strToBeReturned.Append("<td></td>")
                Else
                    strToBeReturned.Append("<td colspan=15></td>")
                End If

                If m_strGroup2IsExpanded = "0" Then
                    strToBeReturned.Append("<td></td>")
                Else
                    strToBeReturned.Append("<td colspan=" + CStr(m_intNoOfDays - 15) + "></td>")
                End If
            Else
                strToBeReturned.Append("<td colspan=" + CStr(m_intNoOfDays) + "></td>")
            End If
            'Modified Code - VidyaJ - For RT Performance IssueID - 87 (SP4)
            'Removed nowrap
            strToBeReturned.Append("<td  align=left width='100%' >")
            strToBeReturned.Append(MyBase.GetResourceString("HEADING_STATUS"))
            strToBeReturned.Append(" : " & m_strProjectStatus)  '+ strToBeInserted

            strToBeReturned.Append("</td></tr>")
        End If
        ' End of Adition by RajkumarM on 2nd march
        'End Integration
        Return strToBeReturned.ToString
        strToBeReturned = Nothing

    End Function
#End Region

#Region "Functions & Procedures"

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        : GetGlobalObject
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Get the global object and assign it to variable
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        : DrawMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the menu depending upon the ACTION
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Priyanka
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuList As New ArrayList
        Dim arrMenuToolTipList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList

        ' Added by DiptiK on 13 Oct 2k4
        Dim intNoofDays As Integer
        ' Addition Ends



        Select Case m_strAction
            Case ACTION_PENDING_TIMESHEET
                arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                arrClientSideFunctionList.Add("Back_OnClick('','')")

                arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
                arrClientSideFunctionList.Add("Help_OnClick('2123')")

            Case ACTION_VIEW_TIMESHEET

                'Added and modified by HarshK on 7 Dec 2005 for sp4 issueid 859 (for weekly view time sheet)to Plot close link only
                    If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "") = "WTimeSheet" Then
                        arrMenuList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_CLOSE"), "Close"))
                        arrMenuToolTipList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), "Close"))
                        arrClientSideFunctionList.Add("Close_OnClick()")
                    Else
                        'Code Modified by Noble K 12th Jan 2005 to hide the Generate Timesheet
                        'Condition added to check whether m_blnDAsPresentInTimeSheet = true then show the Action Link
                        If m_blnDAsPresentInTimeSheet = True Then
                            arrMenuList.Add(MyBase.GetResourceString("MENU_GENERATE_TIMESHEET"))
                            arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_GENERATE_TIMESHEET_TOOLTIP"))

                        '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
                        If (CommonFunctions.Security.Token.ValidateToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String), m_strTokenViewTimesheet) = True) Then
                            arrClientSideFunctionList.Add("GenerateTimesheet_OnClick()")
                        Else
                            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("My Timesheet", m_TagMyTimesheets, s_ParentTagID, "Timesheet ID", CType(m_intTimesheetID, String))
                            'Token is Invalid now redirect to the Invalid Access Page
                            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                        End If
                        '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

                    End If
                        'Modification by Noble K 12th Jan 2005 Ends

                        arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                        arrClientSideFunctionList.Add("Back_OnClick('View','Pending')")
                    End If
                    'End Added and modified by HarshK on 7 Dec 2005 for sp4 issueid 859 (for weekly view time sheet)to Plot close link only
                    arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
                    arrClientSideFunctionList.Add("Help_OnClick('2123')")
              

            Case ACTION_EDIT_TIMESHEET

                If m_strTimesheetStatus = STATUS_REJECTED Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_SHOW_REMARKS"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SHOW_REMARKS_TOOLTIP"))
                    arrClientSideFunctionList.Add("ShowRemarks_OnClick(" + CStr(m_intTimesheetID) + ")")
                End If

                'Code Modified by Noble K 12th Jan 2005 to hide the Print Timesheet
                'Condition added to check whether m_blnDAsPresentInTimeSheet = true then show the Action Link
                If m_blnDAsPresentInTimeSheet = True Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_SHOW_REPORT"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_SHOW_REPORT_TOOLTIP"))

                    ' Added by DiptiK on 14 Oct 2k4
                    intNoofDays = CType((DateDiff("d", CDate(m_dtFromDate), CDate(m_dtToDate)) + 1), Integer)
                    arrClientSideFunctionList.Add("Report_OnClick(" + CStr(m_intTimesheetID) + "," + CStr(intNoofDays) + ")")
                    'Addition Ends
                End If
                'Modification by Noble K 12th Jan 2005 Ends

                arrMenuList.Add("Show History")
                arrMenuToolTipList.Add("Show History")
                arrClientSideFunctionList.Add("ShowHistory_OnClick(" + CStr(m_intTimesheetID) + ")")

                'Code Modified by Noble K 12th Jan 2005 to hide the Send For Verification and Status
                'Condition added to check whether m_blnDAsPresentInTimeSheet = true then show the Action Link

                If m_blnDAsPresentInTimeSheet = True Then
                    If m_strTimesheetStatus = STATUS_NOT_READY_FOR_VERIFICATION Then
                        arrMenuList.Add(MyBase.GetResourceString("MENU_READY_FOR_VERIFICATION"))
                        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_READY_FOR_VERIFICATION_TOOLTIP"))

                        '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
                        m_strToken = CommonFunctions.Security.Token.GetToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String))
                        If (CommonFunctions.Security.Token.ValidateToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String), m_strToken) = True) Then
                            arrClientSideFunctionList.Add("ReadyForVerification_OnClick(" + CStr(m_intTimesheetID) + ")")
                        Else
                            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("My Timesheet", m_TagMyTimesheets, s_ParentTagID, "Timesheet ID", CType(m_intTimesheetID, String))
                            'Token is Invalid now redirect to the Invalid Access Page
                            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                        End If
                        '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

                        '' arrClientSideFunctionList.Add("ReadyForVerification_OnClick(" & CStr(m_intTimesheetID) & ",'" & m_strToken & "')")
                    End If
                End If
                'Modification by Noble K 12th Jan 2005 Ends

                'Modified By VidyaJ - IssueID - 11775
                If m_blnDAsPresentInTimeSheet = True Then
                    If m_strTimesheetStatus = STATUS_READY_FOR_VERIFICATION Or m_strTimesheetStatus = STATUS_NOT_READY_FOR_VERIFICATION Or m_strTimesheetStatus = STATUS_REJECTED Then
                        arrMenuList.Add(MyBase.GetResourceString("MENU_REGENERATE_TIMESHEET"))
                        arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_REGENERATE_TIMESHEET_TOOLTIP"))

                        '' START : Added By ParagD On 14-Sept-2006 : Security Issue 6197
                        If (CommonFunctions.Security.Token.ValidateToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String), m_strToken) = True) Then
                            arrClientSideFunctionList.Add("RegenerateTimesheet_OnClick(" + CStr(m_intTimesheetID) + ")")
                        Else
                            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("My Timesheet", m_TagMyTimesheets, s_ParentTagID, "Timesheet ID", CType(m_intTimesheetID, String))
                            'Token is Invalid now redirect to the Invalid Access Page
                            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                        End If
                        '' END : Added By ParagD On 14-Sept-2006 : Security Issue 6197

                    End If
                End If

                If CType(Request.QueryString("FromWhere"), String) = "List" Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                    arrClientSideFunctionList.Add("Back_OnClick('View','')")
                ElseIf CType(Request.QueryString("Mode"), String) = "View" Or CType(Request.QueryString("Mode"), String) = "Regenerate" Or CType(Request.QueryString("Mode"), String) = "ReadyForVerification" Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                    arrClientSideFunctionList.Add("Back_OnClick('','')")
                ElseIf CType(Request.QueryString("Mode"), String) = "Generate" Then
                    arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                    arrClientSideFunctionList.Add("Back_OnClick('View','')")
                End If

                arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
                arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
                arrClientSideFunctionList.Add("Help_OnClick('2123')")



            Case ACTION_NO_PENDING_TIMESHEET
                    arrMenuList.Add(MyBase.GetResourceString("MENU_BACK"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
                    arrClientSideFunctionList.Add("Back_OnClick('','')")

                    arrMenuList.Add(MyBase.GetResourceString("MENU_HELP"))
                    arrMenuToolTipList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
                    arrClientSideFunctionList.Add("Help_OnClick('2123')")

        End Select

        'Create the static menu.
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipList), True)

    End Sub

    Private Sub DrawPageCaption()
        '====================================================================
        ' Procedure Name        : DrawPageCaption
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page caption thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================

        'Response.Write(PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Response.Write("<BR>")

    End Sub

    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strReturn As String
        objHeader = New HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        strReturn = objHeader.DrawHeaderFooter(m_objGlobal, True)
        If strReturn <> "" Then
            Response.Write(strReturn)
        End If
        objHeader = Nothing

    End Sub

    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                :
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        m_objMenu = Nothing
        m_objGrid = Nothing
        m_objGlobal = Nothing
        m_objAccessRights = Nothing

    End Sub

    Private Sub DisplayGrid()
        '=====================================================================
        ' Function Name         : DisplayGrid
        ' Purpose               : Displays the grid depending upon the action to be taken
        ' Description           : Same as above
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================

        Dim sbHTML As New StringBuilder("")

        Select Case m_strAction
            Case ACTION_NO_PENDING_TIMESHEET
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                sbHTML.Append("<TABLE cellspacing=0; cellpadding=0 class=clsTable width='99.9%'>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                sbHTML.Append("<TR class='clsTREven'><TD align=center>")
                sbHTML.Append(MyBase.GetResourceString("MSG_NO_PENDING_TIMESHEETS"))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE></BR>")

                CommonFunctions.General.WriteHTML(sbHTML.ToString())

            Case ACTION_PENDING_TIMESHEET
                DrawGrid()

            Case ACTION_VIEW_TIMESHEET, ACTION_EDIT_TIMESHEET
                'Modified By VidyaJ - IssueID - 11778 
                If mblnZeroHrsDA = False Or m_intDACountForTimesheetPeriod > 0 Then
                    DrawTimesheetDetailsGrid()
                Else
                    If m_intDACountForTimesheetPeriod > 0 Then
                        Response.Write("<TABLE CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank><TD align='Center'><B><font Face='Verdana' color='#cc0000' size='1'> ")
                        Response.Write(" No Daily Activities Present in the Generated Timesheet. Please Regenerate Timesheet to include newly added Daily Activity entries</FONT></B></TD></TR></TABLE>")
                        CommonFunctions.General.WriteHTML("<input type='hidden' id='txtFromDate' name='txtFromDate' value=" + CStr(m_dtFromDate) + ">")
                        CommonFunctions.General.WriteHTML("<input type='hidden' id='txtToDate' name='txtToDate' value=" + CStr(m_dtToDate) + ">")
                        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

                    End If

                End If


        End Select
        sbHTML = Nothing
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Initialize()
    End Sub

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        : PageInit
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This procedure construct the page
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        '######### Page Code starts here

        'This will initialize all the global objects.



        GetGlobalObject()

        DrawPage()

        DisposeObjects()
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

        Dim drPendingTM As IDataReader
        Dim drFrequency As IDataReader
        Dim drShowRemarks As IDataReader
        Dim drTimesheetStatus As IDataReader
        Dim strSQLQuery As String

        '--- Get the UserID from the Session
        m_intUserID = CInt(Session("intUserID"))
        m_strWindowTitle = MyBase.GetResourceString("HEADING_RESOURCE_TIMESHEET")

        '--- Gets information from the Querystring
        '--- Action
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))

        '--- Action
        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"))
        If m_strMode = "" Or m_strMode = "ADD_NEW" Then
            m_strMode = MODE_VIEW_TIMESHEET
        End If

        '--- TimesheetID
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("TimesheetID")) = "" Then
            m_intTimesheetID = 0
        Else
            m_intTimesheetID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TimesheetID")), Integer)
        End If

        'Modified By VidyaJ For IssueID - 87(SP4)
        'Get List of project's which have no approver
        If m_intTimesheetID <> 0 Then
            strSQLQuery = " Exec usp_sel_GetRTApprovers " & CStr(m_intTimesheetID) & "," & CStr(m_intUserID)
            m_strProjectList = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "NULL").ToString
        End If
        'End Of Modifications


        '--- From Date
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate")) <> "" Then
            m_dtFromDate = CDate(CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate")))
        End If

        '--- To Date
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate")) <> "" Then
            m_dtToDate = CDate(CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate")))
        End If
        '---

        '--- Get the frequency for Timesheet Generation from the Company Information
        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT ResourceTimeSheetFrequency FROM tbl_PM_CompanyInformation"
        strSQLQuery = "usp_sel_tbl_PM_CompanyInformation_TimeSheetFrequency"
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        drFrequency = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drFrequency) <> "" Then
            If drFrequency.Read() Then
                m_strTimesheetFrequency = CType(CommonFunctions.Data.CheckIsDBNull(drFrequency.Item("ResourceTimeSheetFrequency"), ACTION_GENERATE_WEEKLY_TIMESHEET), String)
            End If
        Else
            m_strTimesheetFrequency = ACTION_GENERATE_WEEKLY_TIMESHEET
        End If
        CommonFunctions.Data.DisposeDataReader(drFrequency)
        '---

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If CStr(m_intTimesheetID) <> "0" Then
            If Request.QueryString("PKToken") <> "" Then
                m_strToken = Request.QueryString("PKToken")
            Else
                m_strToken = CommonFunctions.Security.Token.GetToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String))
            End If
        End If
        '' Add OR View mode -- PrimaryKey not exists ,thus added as "0" 
        m_strTokenViewTimesheet = CommonFunctions.Security.Token.GetToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String))

        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

        '--- Depending upon the Mode action is taken
        Select Case m_strMode
            Case MODE_VIEW_TIMESHEET

                '--- If Action not specified in the Querystring then sets the default action
                If m_strAction = "" Then
                    '--- Check if there are any pending Timesheets to be generated.
                    '--- Depending on this the Action will be changed
                    '-- ''Modified Code - VidyaJ - For RT Performance IssueID - 20528
                    '-- Added Additional Parameter -- to Get only First Record
                    strSQLQuery = "EXEC usp_tbl_PM_PendingResourceTimesheets " & m_intUserID & ",1"

                    drPendingTM = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

                    If CommonFunctions.General.CheckIsNothing(drPendingTM) <> "" Then
                        If drPendingTM.Read() Then

                            m_blnPendingTimesheet = True
                            m_strAction = ACTION_PENDING_TIMESHEET

                            m_dtFromDate = CDate(CommonFunctions.Data.CheckIsDBNull(drPendingTM("FromDate"), ""))
                            m_dtToDate = CDate(CommonFunctions.Data.CheckIsDBNull(drPendingTM("ToDate"), ""))

                        Else

                            m_strAction = ACTION_NO_PENDING_TIMESHEET
                            m_blnPendingTimesheet = False

                        End If
                    Else

                        m_strAction = ACTION_NO_PENDING_TIMESHEET
                        m_blnPendingTimesheet = False

                    End If

                    CommonFunctions.Data.DisposeDataReader(drPendingTM)
                End If

            Case MODE_GENERATE_TIMESHEET
                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                '' m_GenerateTimesheetFromList = Request.QueryString("PKToken")
                If (CommonFunctions.Security.Token.ValidateToken("0" + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String), m_strTokenViewTimesheet) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                    GenerateTimesheet()
                    '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                Else
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("My Timesheet", m_TagMyTimesheets, s_ParentTagID, "Timesheet ID", CType(m_intTimesheetID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If

            Case MODE_REGENERATE_TIMESHEET
                '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                If (CommonFunctions.Security.Token.ValidateToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String), m_strToken) = True) Then
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197 
                    GenerateTimesheet()
                Else
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("My Timesheet", m_TagMyTimesheets, s_ParentTagID, "Timesheet ID", CType(m_intTimesheetID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197

            Case MODE_READY_FOR_VERIFICATION_TIMESHEET
                m_strToken = CommonFunctions.Security.Token.GetToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String))
                If m_intTimesheetID > 0 Then
                    ''m_strToken = Request.QueryString("PKToken")
                    If (CommonFunctions.Security.Token.ValidateToken(CStr(m_intTimesheetID) + CType(m_intUserID, String) + CType(s_ParentTagID, String) + CType(m_TagMyTimesheets, String), m_strToken) = True) Then
                        '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197 
                        UpdateResourceTimesheetStatus()
                        '' START : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197
                    Else
                        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("My Timesheet", m_TagMyTimesheets, s_ParentTagID, "Timesheet ID", CType(m_intTimesheetID, String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                    '' END : Added By ParagD 13-Sept for whiziblesem SP7 issue ID.6197


                End If

        End Select

        '--- Get whether there are any remarks to be displayed
        If m_intTimesheetID > 0 Then
            'Modified Code - VidyaJ - For RT Performance IssueID - 20528
            'Replace * with DailyActivityEntryID

            'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'strSQLQuery = "SELECT DailyActivityEntryID FROM tbl_PM_DailyActivity WHERE Remarks <> '' AND ResourceTimesheetID = " + CStr(m_intTimesheetID)
            strSQLQuery = "usp_sel_tbl_PM_DailyActivity_DailyActivityEntryIDRemark " + CStr(m_intTimesheetID)
            'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'End Of Modifications
            drShowRemarks = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            m_blnShowRemarks = False
            If drShowRemarks.Read() Then
                m_blnShowRemarks = True
            Else
                m_blnShowRemarks = False
            End If
            CommonFunctions.Data.DisposeDataReader(drShowRemarks)

            '--- Get the StatusCode, FromDate and ToDate of the Timesheet

            'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'strSQLQuery = "SELECT StatusCode, FromDate, ToDate FROM tbl_PM_ResourceTimesheet WHERE TimesheetID = " & m_intTimesheetID
            strSQLQuery = "usp_sel_tbl_PM_ResourceTimesheet_FromDate " & m_intTimesheetID
            'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            drTimesheetStatus = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drTimesheetStatus) <> "" Then
                If drTimesheetStatus.Read() Then
                    m_strTimesheetStatus = CStr(CommonFunctions.Data.CheckIsDBNull(drTimesheetStatus("StatusCode"), STATUS_NOT_READY_FOR_VERIFICATION))
                    m_dtFromDate = CDate(CommonFunctions.Data.CheckIsDBNull(drTimesheetStatus("FromDate"), ""))
                    m_dtToDate = CDate(CommonFunctions.Data.CheckIsDBNull(drTimesheetStatus("ToDate"), ""))
                End If
            Else
                m_strTimesheetStatus = STATUS_NOT_READY_FOR_VERIFICATION
            End If
            CommonFunctions.Data.DisposeDataReader(drTimesheetStatus)
            '---

        End If
        '---

        If m_intTimesheetID > 0 And m_strMode = MODE_READY_FOR_VERIFICATION_TIMESHEET Then

            str_Token = CommonFunctions.Security.Token.GetToken(CType(Session("intUserID"), String) + CType(m_dtFromDate, String) + CType(m_dtToDate, String) + "0" + "0")
            CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
            CommonFunctions.General.WriteHTML("window.open('RT_UpdateTaskCompletePerc.aspx?StartDate=" + CType(m_dtFromDate, String) + "&EndDate=" + CType(m_dtToDate, String) + "&RTtimesheetToken=" + str_Token + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=700,height=600');" + vbCrLf)
            CommonFunctions.General.WriteHTML("</script>" + vbCrLf)

        End If
        'Code Added by NobleK on 12th Jan 2005
        m_blnTimeSheetGenerated = False
        m_blnDAsPresentInTimeSheet = False
        m_intDACountForTimesheetPeriod = 0
        'Code Added by NobleK on 12th Jan 2005 Ends
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Function Name         : DrawPage
        ' Purpose               : Displays the page depending on the Action required
        ' Description           : 
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================

        'This will set value for variable IsDAsPresentInTimeSheet to true OR false
        'based on weather DA exists for which Timesheet is generated
        'Code Added by Noble K 12th Jan 2005
        'Modified Code - VidyaJ - For RT Performance IssueID - 87 (SP4)
        If m_intTimesheetID = 0 Then
            IsTimeSheetGenerated()
        Else
            m_blnTimeSheetGenerated = True
        End If
        'End Of Modifications

        If m_blnTimeSheetGenerated = True Then
            IsDAsPresentInTimeSheet()
        Else
            m_blnDAsPresentInTimeSheet = True
        End If
        'Code Added by Noble K 12th Jan 2005 Ends



        'This will store the constructed menu string in a string variable.   
        DrawMenu()
        CommonFunctions.General.WriteHTML(strMenu)

        'Display Page Legend
        'Code Modified by Noble K to Display the Page Legend. If m_blnDAsPresentInTimeSheet = True then
        'The default Page Legend is displayed else the Message saying no DAs are prresent is displayed
        If m_strAction = ACTION_EDIT_TIMESHEET Then
            If m_blnDAsPresentInTimeSheet = True Then
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                If mblnZeroHrsDA = False Then
                    Response.Write("<TABLE CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank><TD align='Right'><B><font Face='Verdana' color='#cc0000' size='1'>Task is displayed in red colour, if all activites under that task are not approved</FONT></B></TD></TR></TABLE>")
                End If
                '--- addded By Purvaj on 13 Oct 2008 for Holiday, Leave and Weekends
                Response.Write("<TABLE CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank><TD align='Right'><B><font Face='Verdana' color='#cc0000' size='1'>" + MyBase.GetResourceString("NOTE").ToString + "</FONT></B></TD></TR></TABLE>")
                '--- End addition Purvaj
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            Else
                'Code modified by MrugajaB on 3rd Feb 2005
                'Modified message from 'DA' to 'Daily Acivities'
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                Response.Write("<TABLE CellSpacing=0 width='99.9%' class=clsTable><TR class=clsTRBlank><TD align='Center'><B><font Face='Verdana' color='#cc0000' size='1'>No Daily Activities Present in the Timesheet.</FONT></B></TD></TR></TABLE>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            End If
        End If
        'Display the page caption.
        DrawPageCaption()



        'Display the Header if exist. 
        DrawHeader()

        'Display the grid depending upon the Action
        Response.Write("<DIV Id= 'PageDiv' Style='Width:100%;OverFlow:auto'>")
        DisplayGrid()
        HttpContext.Current.Response.Write("</DIV>")
        'Response.Write("<BR>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

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
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Function GetShortDate(ByVal dTDate As Date) As String
        '=====================================================================
        ' Procedure Name        : GetShortDate()	
        ' Purpose               : Returns the day for the date passed to this function
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim intDate As Integer
        Dim strMonth As String

        intDate = Day(dTDate)
        strMonth = MonthName(Month(dTDate), True) + " " + CType(intDate, String)

        GetShortDate = strMonth

    End Function

#End Region

#Region "Database Related"

    Private Sub GenerateTimesheet()
        '=====================================================================
        ' Function Name         : GenerateTimesheet
        ' Purpose               : Generates or Regenerates the Resource Timesheet
        ' Description           : Same as above
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 25th July 2004
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim drTimesheet As IDataReader

        strSQLQuery = "EXEC usp_GenerateResourceTimeSheet " + CStr(m_intUserID) + ",'" + CStr(m_dtFromDate) + "','" + CStr(m_dtToDate) + "'," + CStr(m_intTimesheetID)
        drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drTimesheet.Read Then
            m_intTimesheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drTimesheet)

        'Integrated by MrugajaB on 1st March 2006 for WhizibleSEM6 Issue ID.2543
        ''added by RohiniK on 16th Jan 2005 for Tavant Issue: 22175
        ''Purpose: To display alert message if any of project(in Resource Timesheet)for high leval resource has not default appprover set
        If m_intTimesheetID <> 0 Then
            strSQLQuery = " Exec usp_sel_GetRTApprovers " & CStr(m_intTimesheetID) & "," & CStr(m_intUserID)
            m_strProjectList = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, True), "NULL").ToString
        End If
        ''end of addition by RohiniK on 16th Jan 2005 for for Tavant Issue: 22175
        'End Integration

    End Sub

    Private Sub UpdateResourceTimesheetStatus()
        '=====================================================================
        ' Function Name         : UpdateResourceTimesheetStatus
        ' Purpose               : Updates the status of the Resource Timesheet
        ' Description           : Same as above
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim drTimesheet As IDataReader, drEmailMessage As IDataReader
        Dim blnSendEmail As Boolean, blnShowPopup As Boolean

        strSQLQuery = "EXEC usp_Upd_ResouceTimesheetStatus " + CStr(m_intTimesheetID) + ",'" + STATUS_READY_FOR_VERIFICATION + "'"
        drTimesheet = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drTimesheet.Read Then
            m_intTimesheetID = CType(CommonFunction.Data.CheckIsDBNull(drTimesheet("TimesheetID"), "0"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drTimesheet)

        '--- Set the StatusCode of the Timesheet to STATUS_READY_FOR_VERIFICATION
        m_strTimesheetStatus = STATUS_READY_FOR_VERIFICATION

        strSQLQuery = "usp_Sel_tbl_PM_EmailMessages " + CStr(MAIL_READY_FOR_VERIFICATION)
        drEmailMessage = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drEmailMessage.Read Then
            blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
            blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(drEmailMessage)

        ' Check if the mail has to be sent.
        If blnSendEmail = True Then
            ' Check if a popup message has to be shown.
            If blnShowPopup = True Then
                CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
                CommonFunctions.General.WriteHTML("window.open('../../Source/General/SendEmail.aspx?MessageID=" + CStr(MAIL_READY_FOR_VERIFICATION) + "&TimesheetID=" + CType(m_intTimesheetID, String) + "&EmailMode=" + CType(Request.QueryString("EmailMode"), String) + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=100,top=100,width=600,height=500')" + vbCrLf)
                CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
                ' Else, if the mail has to be sent silently, then...
            Else
                'TO DO: SEND EMAIL MESSAGE WITH CC
                'CommonFunction.EmailMessages.PMMessages. CRMMessages.GetEmailMessage_45(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intVerifiedBy, m_strEmployeeID)
                'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
        End If

    End Sub

    Private Sub GetTimesheetStatus()
        '=====================================================================
        ' Function Name         : GetTimesheetStatus
        ' Purpose               : Gets the status of the Resource Timesheet
        ' Description           : Same as above
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 
        ' Revisions             : 
        '=====================================================================

        Dim strSQLQuery As String
        Dim drTimesheetStatus As IDataReader

        ' --- Get the description of the Timesheet Status
        strSQLQuery = "EXEC usp_Sel_PM_SelTimesheetStatus " & CType(m_strTimesheetStatus, String)
        drTimesheetStatus = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTimesheetStatus) <> "" Then
            If drTimesheetStatus.Read() Then
                m_strTimesheetStatusDescription = CType(CommonFunctions.Data.CheckIsDBNull(drTimesheetStatus.Item("StatusDescription"), ""), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drTimesheetStatus)

    End Sub

    Private Sub GetAndDisplayEmployeeDetails()
        '=====================================================================
        ' Function Name         : GetAndDisplayEmployeeDetails
        ' Purpose               : Gets the display of the Resource Timesheet
        ' Description           : CURRENTLY THIS IS NOT USED
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 
        ' Revisions             : 
        '=====================================================================
        Dim strSQLQuery As String
        Dim drEmpProfile As IDataReader
        Dim sbHTML As New StringBuilder("")
        Dim intWidth As Integer

        '--- Calculate the width of the Day columns using the number of columns
        intWidth = CType((90 / m_intNoOfDays), Integer)

        '--- Get the details of the employee to display on the page
        strSQLQuery = "EXEC usp_Sel_tbl_PM_EmployeeProfile " & CType(m_intUserID, Integer)
        drEmpProfile = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmpProfile) <> "" Then
            If drEmpProfile.Read() Then
                m_strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drEmpProfile.Item("EmployeeName"), ""), String)
                m_strEmployeeCode = CType(CommonFunctions.Data.CheckIsDBNull(drEmpProfile.Item("EmployeeCode"), ""), String)
                m_strRole = CType(CommonFunctions.Data.CheckIsDBNull(drEmpProfile.Item("RoleDescription"), ""), String)
                m_strDepartment = CType(CommonFunctions.Data.CheckIsDBNull(drEmpProfile.Item("Department"), ""), String)
                m_strLocation = CType(CommonFunctions.Data.CheckIsDBNull(drEmpProfile.Item("Location"), ""), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmpProfile)


        '--- Build the header to be displayed before the grid headers
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<TABLE cellspacing=0; cellpadding=0 class=clsTable width='99.9%'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<TR class='clsTREven'>")

        sbHTML.Append("<TD align=left valign=top style='width:15%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_RESOURCE_NAME"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:20%'>")
        sbHTML.Append(m_strEmployeeName)
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:15%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_RESOURCE_ROLE"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:20%'>")
        sbHTML.Append(m_strRole)
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")

        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD align=left valign=top style='width:15%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_EMPLOYEE_NO"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:20%'>")
        sbHTML.Append(m_strEmployeeCode)
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:15%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_WORKING_DEPARTMENT"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:20%'>")
        sbHTML.Append(m_strDepartment)
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")

        sbHTML.Append("<TR class='clsTREven'>")
        sbHTML.Append("<TD align=left valign=top style='width:15%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_WORKING_OFFICE"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:20%'>")
        sbHTML.Append(m_strLocation)
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:15%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_TIMESHEET_STATUS"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=left valign=top style='width:20%'><font color=red>")
        sbHTML.Append(m_strTimesheetStatusDescription)
        sbHTML.Append("</font></TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE><BR>")

        '--- Headers for the No. of days to be displayed
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<TABLE cellspacing=0; cellpadding=0 class=clsTable width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        sbHTML.Append("<TR class='clsTRColumnHeader'>")

        sbHTML.Append("<TD align=left valign=top style='width:" + CStr(intWidth + 10) + "%'>")
        sbHTML.Append(MyBase.GetResourceString("HEADING_TASK_NAME"))
        sbHTML.Append("</TD>")

        sbHTML.Append("<TD align=center valign=top style='width:" + CStr(intWidth * m_intNoOfDays) + "%' colspan=" + CType(m_intNoOfDays, String) + ">")
        sbHTML.Append(MyBase.GetResourceString("HEADING_DAILY_RECORD"))
        sbHTML.Append("</TD>")

       sbHTML.Append("<TD align=left valign=top style='width:" + CStr(intWidth) + "20%'>")
      
        sbHTML.Append(MyBase.GetResourceString("HEADING_ACTUAL_HRS"))
        sbHTML.Append("</TD>")

        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub

#End Region

#Region "Constructor"
    Public Sub New()
        'This constructor initialize resources and also apply security settings.
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.RT_ResourceTimesheet", "AppResources")
    End Sub
#End Region

#Region "Destructor"
    Protected Overrides Sub Finalize()
        'This will call base class destructor.
        MyBase.Finalize()
    End Sub
#End Region

#Region "Grid plotting"

    Private Sub DrawTimesheetDetailsGrid()
        '====================================================================
        ' Procedure Name        : DrawTimesheetDetailsGrid
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Displays the grid for the Timesheet Details
        ' Description           : The grid displaying is handled depending on the Frequency of the Resource
        '                         Timesheet to be genereated
        ' Assumptions           : 
        ' Dependencies          :
        ' Author                : 
        ' Created               : Priyanka
        ' Revisions             :
        '=====================================================================

        Dim intCnt As Integer, intWidth As Integer
        Dim strWeekDayName As String, strSQLQuery As String, strGRID As String
        Dim dtCounterDate As Date
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
        Dim strMessage As String

        '--- Get Expected hours and Actual AMH for the the timesheet period
        strSQLQuery = "Exec usp_Sel_GetResourceTimesheetExpectedAndActualHours " + CStr(m_intUserID) & ",'" & CStr(m_dtFromDate) & "','" & CStr(m_dtToDate) & "'"
        drActualHrs = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drActualHrs) <> "" Then
            If drActualHrs.Read() Then
                dblActualHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drActualHrs.Item("ActualAMH"), "0"))
                dblExpectedHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drActualHrs.Item("NormalAMH"), "0"))
            Else
                dblActualHrs = 0
                dblExpectedHrs = 0
            End If
        Else
            dblActualHrs = 0
            dblExpectedHrs = 0
        End If
        CommonFunctions.Data.DisposeDataReader(drActualHrs)


        'Modified Code - VidyaJ - For RT Performance IssueID - 87 - SP4
        'Commented this code as DA actuals hours were already retrieved in above SP.
        dblTotalHrs = dblActualHrs
        ''--- Get toatl hours entered by the Resource for the the timesheet period
        'strSQLQuery = "Exec usp_tbl_PM_GetDATotalHours " + CStr(m_intUserID) & ",'" & CStr(m_dtFromDate) & "','" & CStr(m_dtToDate) & "'"
        'drActualHrs = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        'If CommonFunctions.General.CheckIsNothing(drActualHrs) <> "" Then
        '    If drActualHrs.Read() Then
        '        dblTotalHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drActualHrs.Item("TotalHrs"), "0"))
        '    Else
        '        dblTotalHrs = 0
        '    End If
        'Else
        '    dblTotalHrs = 0
        'End If
        'CommonFunctions.Data.DisposeDataReader(drActualHrs)
        'End Of Addition

        If m_blnDAsPresentInTimeSheet = True Then
            '--- Depending on the Action, Query to execute is selected
            Select Case m_strAction
                Case ACTION_VIEW_TIMESHEET
                    strSQLQuery = "Exec usp_ViewResourceTimeSheet " + CType(m_intUserID, String) + ",'" + CType(m_dtFromDate, String) + "','" + CType(m_dtToDate, String) + "'"
                    m_strTimesheetStatus = STATUS_NOT_READY_FOR_VERIFICATION

                Case ACTION_EDIT_TIMESHEET
                    strSQLQuery = "Exec usp_tbl_PM_SelResourceTimesheetDetails " + CType(m_intTimesheetID, String)

            End Select

            '--- Get the No of days between the Start Date and End Date
            m_intNoOfDays = CType(DateDiff("d", CDate(m_dtFromDate), CDate(m_dtToDate)) + 1, Integer)

            dtCounterDate = m_dtFromDate
            m_intDayCounter = 1

            ReDim m_arrDaywiseTotals(m_intNoOfDays + 3)

            '--- Calculate the width of the Day columns using the number of columns
            intWidth = CType(70 / (m_intNoOfDays + 1), Integer)

            '--- Get the details of the Employee to be printed on the Resource Timesheet
            'GetAndDisplayEmployeeDetails()

            '--- Get the status of Timesheet
            Call GetTimesheetStatus()

            '--- added By purvaj on 6 Nov 2008 for Whiziblesem8.0
            '--- total expected work hours will be calculated from resource OU working days and working hours
            dblExpectedHrs = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_ExpectedWorkHours " + Session("intUserID").ToString + ",'" + CommonFunction.Dates.GetDate(m_dtFromDate).ToString + "','" + CommonFunction.Dates.GetDate(m_dtToDate).ToString + "'", True), "0")
            '--- End addition PurvaJ

            ''--- Display the DIV & PageCaption for the grid
            CommonFunctions.General.WriteHTML("<br>")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD colspan=2 align=Left>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_TIMESHEET_PERIOD"))
            CommonFunctions.General.WriteHTML(": " + CStr(CommonFunctions.Dates.CGetDate(m_dtFromDate)) + " To " + CStr(CommonFunctions.Dates.CGetDate(m_dtToDate)))
            CommonFunctions.General.WriteHTML("</TD></TR><TR class=clsTRColumnHeader><TD align=left>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_TIMESHEET_TOTAL_HRS"))
            CommonFunctions.General.WriteHTML(" " + FormatNumber(CStr(dblActualHrs), 2) + " / " + FormatNumber(CStr(dblExpectedHrs), 2))
            CommonFunctions.General.WriteHTML("</TD><TD align=Right>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_STATUS") + ": <font color=red>" + m_strTimesheetStatusDescription + "</font>")
            CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
            CommonFunctions.General.WriteHTML("<br>")
            'Modified by PrajaktaR for PCFC IssueID 19230 on 03 May 2005
            'CommonFunction.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:420'>")
            CommonFunction.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:300'>")
            'End of Modification by PrajaktaR for PCFC IssueID 19230 on 03 May 2005

            '--- Check if the Frequency is Weekly, Fornightly, and TM already is generated for Monthly
            '--- then set the frequency to Monthly
            If m_intNoOfDays > 16 Then
                m_strTimesheetFrequency = ACTION_GENERATE_MONTHLY_TIMESHEET
            End If

            Select Case m_strTimesheetFrequency

                Case ACTION_GENERATE_WEEKLY_TIMESHEET, ACTION_GENERATE_FORNIGHTLY_TIMESHEET

                    strGroupByField = "ProjectName"
                    strGroupByFieldValue = ""

                    '-- Define the Actual Array and UserFriendly array..
                    arrstrActualList.Add("ProjectName")
                    arrstrUserFriendlyList.Add("")
                    arrstrRowLinkField.Add("")
                    'Commented And Added  by Vaijat K ON 19/112015
                    'arrstrTDStyle.Add("style='width=0%'")
                    arrstrTDStyle.Add("style='width:0%'")
                    arrstrSummaryFunctionsList.Add("")
                    arrGroupSummaryFunctions.Add("")
                    arrIgnoreHTMLEncode.Add("")

                    arrstrActualList.Add("TaskName")
                    arrstrUserFriendlyList.Add(MyBase.GetResourceString("HEADING_TASK_NAME"))
                    arrstrRowLinkField.Add("")
                    ''Commeted And Added By Vaijat K ON 19/11/2015
                    'arrstrTDStyle.Add("style='width=" + CStr(intWidth + 10) + "%' align=left")
                    arrstrTDStyle.Add("style='width:" + CStr(intWidth + 10) + "%' align=left")
                    arrstrSummaryFunctionsList.Add("")
                    arrGroupSummaryFunctions.Add("")
                    arrIgnoreHTMLEncode.Add("True")

                    '--- Build the array for column headers and column names
                    For intCnt = 1 To m_intNoOfDays

                        '-- Set the WeekDays
                        strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSunday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"

                        '---- Added By purvaj on 13 Oct 2008 for Holiday, Leave and weekend changes.

                        blnFlag = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_DA_HolidayORLeaveStatus " + m_intUserID.ToString + ",'" + dtCounterDate + "'", True), "0"), "0"))
                        If blnFlag = True Then
                            blnFlag = False
                            arrstrUserFriendlyList.Add("<FONT color='RED'>" + strWeekDayName + "</FONT>")
                        Else
                            '--- End addition purvaJ
                            arrstrUserFriendlyList.Add(strWeekDayName)
                        End If

                        dtCounterDate = DateAdd("d", 1, dtCounterDate)
                        arrstrActualList.Add("Day" + CStr(intCnt))
                        arrstrRowLinkField.Add("")
                        ''Commeted And Added By Vaijat K ON 19/11/2015
                        'arrstrTDStyle.Add("style='width=" + CStr(intWidth) + "%' align=right")
                        arrstrTDStyle.Add("style='width:" + CStr(intWidth) + "%' align=right")
                        arrstrSummaryFunctionsList.Add("SUM")
                        arrGroupSummaryFunctions.Add("SUM")
                        arrIgnoreHTMLEncode.Add("1")
                    Next intCnt

                    arrstrActualList.Add("NormalAMH")
                    arrstrUserFriendlyList.Add(MyBase.GetResourceString("HEADING_ACTUAL_HRS"))
                    arrstrRowLinkField.Add("")
                    ''Commeted And Added By Vaijat K ON 19/11/2015
                    ' arrstrTDStyle.Add("style='width=" + CStr(intWidth) + "%' align=right")
                    arrstrTDStyle.Add("style='width:" + CStr(intWidth) + "%' align=right")
                    arrstrSummaryFunctionsList.Add("SUM")
                    arrGroupSummaryFunctions.Add("")
                    arrIgnoreHTMLEncode.Add("")

                    arrstrGroupOnColumn.Add("1")


                    '--Plotting the Timesheet Details Grid's properties
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

                        .DIVID = "DivList"
                        ' Modified By NitinVS on 19 Sep 2006 for WhizibleSEM SP7 IssueID 6341 
                        ' Changed height of div from 400 to 275        
                        '.DIVHeight = 400
                        .DIVHeight = 280
                        ' End Modification By NitinVS on 19 Sep 2006 for WhizibleSEM SP7  IssueID 6341 

                        .DIVStyle = "overflow:auto"

                        .IgnoreHTMLEncode = GetArray(arrIgnoreHTMLEncode)
                        .returnHTML = True
                        .UseSQL = MyBase.UseSQL
                        
                        strGRID = .DrawGrid()
                        '--- Added By purvaj on 12 jan 2008 Whiziblsem 8.0 Regession Issue Fixes
                        '--- Repalce <FONT> from tool tip
                        strGRID = strGRID.Replace("&lt;FONT color=&#39;RED&#39;&gt;", "")
                        strGRID = strGRID.Replace("&lt;/FONT&gt;", "")
                        '--- End addition purvaj0
                        Response.Write(strGRID)


                    End With

                Case ACTION_GENERATE_MONTHLY_TIMESHEET

                    strGroupByField = "ProjectName"
                    strGroupByFieldValue = ""

                    '--- Get the preferences of displaying the required Fortnight
                    strGroup = CommonFunctions.General.CheckIsNothing(Request.QueryString("Group"), "Fortnight - 1")
                    m_strGroup1IsExpanded = CommonFunctions.General.CheckIsNothing(Request.QueryString("Group1IsExpanded"), "0")
                    m_strGroup2IsExpanded = CommonFunctions.General.CheckIsNothing(Request.QueryString("Group2IsExpanded"), "0")

                    If m_intNoOfDays > 15 Then
                        '--- Provide the columns for grouping
                        arrColGroup.Add("1-2")
                        arrColGroup.Add("3-17")
                        arrColGroup.Add("18-" + CStr(m_intNoOfDays + 2))
                        arrColGroup.Add(CStr(m_intNoOfDays + 3))

                        '--- Provide Col Grouping Name
                        arrColGroupNames.Add("")
                        arrColGroupNames.Add("Fortnight - 1")
                        arrColGroupNames.Add("Fortnight - 2")
                        arrColGroupNames.Add("")

                        arrColGroupExpanded.Add("1")
                        arrColGroupExpanded.Add(m_strGroup1IsExpanded)
                        arrColGroupExpanded.Add(m_strGroup2IsExpanded)
                        arrColGroupExpanded.Add("1")

                        arrstrIgnoreHTML.Add("")
                        arrstrIgnoreHTML.Add("1")

                    End If

                    '-- Define the Actual Array and UserFriendly array..
                    arrstrActualList.Add("ProjectName")
                    arrstrUserFriendlyList.Add("")
                    arrstrRowLinkField.Add("")
                    'Commented And Added By Vaijat K ON 19/11/2015
                    ' arrstrTDStyle.Add("style='width=0%'")
                    arrstrTDStyle.Add("style='width:0%'")
                    arrstrSummaryFunctionsList.Add("")
                    arrGroupSummaryFunctions.Add("")
                    arrIgnoreHTMLEncode.Add("")

                    arrstrActualList.Add("TaskName")
                    arrstrUserFriendlyList.Add(MyBase.GetResourceString("HEADING_TASK_NAME"))
                    arrstrRowLinkField.Add("")
                    'Commented And Added By Vaijat K ON 19/11/2015
                    'arrstrTDStyle.Add("style='width=" + CStr(intWidth + 10) + "%' align=left")
                    arrstrTDStyle.Add("style='width:" + CStr(intWidth + 10) + "%' align=left")
                    arrstrSummaryFunctionsList.Add("")
                    arrGroupSummaryFunctions.Add("")
                    arrIgnoreHTMLEncode.Add("")

                    '--- Build the array for column headers and column names
                    For intCnt = 1 To m_intNoOfDays

                        '-- Set the WeekDays
                        strWeekDayName = WeekdayName(Weekday(dtCounterDate), True, vbSunday) + vbCrLf + "[" + CStr(GetShortDate(dtCounterDate)) + "]"


                        '---- Added By purvaj on 13 Oct 2008 for Holiday, Leave and weekend changes.
                        blnFlag = CBool(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_DA_HolidayORLeaveStatus " + m_intUserID.ToString + ",'" + dtCounterDate + "'", True), "0"), "0"))
                        If blnFlag = True Then
                            blnFlag = False
                            arrstrUserFriendlyList.Add("<FONT color='RED'>" + strWeekDayName + "</FONT>")
                        Else
                            '--- End addition purvaJ
                            arrstrUserFriendlyList.Add(strWeekDayName)
                        End If


                        'arrstrUserFriendlyList.Add(strWeekDayName)

                        dtCounterDate = DateAdd("d", 1, dtCounterDate)

                        arrstrActualList.Add("Day" + CStr(intCnt))
                        arrstrRowLinkField.Add("")
                        'Commented And Added By Vaijat K ON 19/11/2015
                        'arrstrTDStyle.Add("style='width=" + CStr(intWidth) + "%' align=right")
                        arrstrTDStyle.Add("style='width:" + CStr(intWidth) + "%' align=right")
                        arrstrSummaryFunctionsList.Add("SUM")
                        arrGroupSummaryFunctions.Add("SUM")
                        '---- modified By purvaj on 13 Oct 2008 for Holiday, Leave and weekend changes.
                        '---- value  : false changed to 1
                        arrIgnoreHTMLEncode.Add("1")
                        '--- End modification purvaJ

                    Next intCnt

                    arrstrActualList.Add("NormalAMH")
                    arrstrUserFriendlyList.Add(MyBase.GetResourceString("HEADING_ACTUAL_HRS"))
                    arrstrRowLinkField.Add("")
                    'Commented And Added By Vaijat K ON 19/11/2015
                    'arrstrTDStyle.Add("style='width=" + CStr(intWidth) + "%' align=right")
                    arrstrTDStyle.Add("style='width:" + CStr(intWidth) + "%' align=right")
                    arrstrSummaryFunctionsList.Add("SUM")
                    arrGroupSummaryFunctions.Add("SUM")
                    arrIgnoreHTMLEncode.Add("")

                    arrstrGroupOnColumn.Add("1")

                    '--Plotting the Timesheet Details Grid's properties
                    With m_objAdvGrid

                        .GroupOnColumn = GetArray(arrstrGroupOnColumn)
                        .ActualColumnArray = GetArray(arrstrActualList)
                        .TDStyleArray = GetArray(arrstrTDStyle)
                        .UserFriendlyColumnArray = GetArray(arrstrUserFriendlyList)

                        If m_intNoOfDays > 15 Then
                            '-- Column Grouping
                            .ColumnGroupNameArray = GetArray(arrColGroupNames)
                            .ColumnGroupColumnsArray = GetArray(arrColGroup)
                            .ColumnGroupExpandedArray = GetArray(arrColGroupExpanded)
                            .IgnoreHTMLEncode = GetArray(arrstrIgnoreHTML)
                            .ExpandCollapseClientSideFunctionName = "ExpandCollapse_Onclick"
                        End If

                        .DIVID = "DivList"
                        ' Modified By NitinVS on 19 Sep 2006 for WhizibleSEM SP7  IssueID 6341 
                        ' Changed height of div from 400 to 275   
                        '.DIVHeight = 400
                        .DIVHeight = 280
                        ' End Modification By NitinVS on 19 Sep 2006 for WhizibleSEM SP7  IssueID 6341 
                        .DIVStyle = "overflow:auto"

                        .ColNameToolTipOnEachRow = True
                        .NoOfDataColumns = GetArray(arrstrUserFriendlyList).GetLength(0)
                        .RowLinkArray = GetArray(arrstrRowLinkField)
                        .SQL = strSQLQuery

                        .ShowSummaryFunctions = True
                        .SummaryFunctions = GetArray(arrstrSummaryFunctionsList)
                        .GroupSummaryFunc = GetArray(arrGroupSummaryFunctions)

                        .IgnoreHTMLEncode = GetArray(arrIgnoreHTMLEncode)

                        .returnHTML = True
                        .UseSQL = MyBase.UseSQL
                        strGRID = .DrawGrid()
                        '--- Added By purvaj on 12 jan 2008 Whiziblsem 8.0 Regession Issue Fixes
                        '---Repalce <FONT> from tool tip
                        strGRID = strGRID.Replace("&lt;FONT color=&#39;RED&#39;&gt;", "")
                        strGRID = strGRID.Replace("&lt;/FONT&gt;", "")
                        '--- End addition purvaj0
                        Response.Write(strGRID)

                    End With

                    CommonFunctions.General.WriteHTML("<input name=txtQuerystring id=txtQuerystring type=hidden value='" + "&Mode=" + MODE_VIEW_TIMESHEET + "&Action=" + m_strAction + _
                        "&FromDate=" + CStr(m_dtFromDate) + "&ToDate=" + CStr(m_dtToDate) + "&TimesheetID=" + CStr(m_intTimesheetID) + "'>")
                    CommonFunctions.General.WriteHTML("<input name=txtGroup1IsExpanded id=txtGroup1IsExpanded type=hidden value='" + m_strGroup1IsExpanded + "'>")
                    CommonFunctions.General.WriteHTML("<input name=txtGroup2IsExpanded id=txtGroup2IsExpanded type=hidden value='" + m_strGroup2IsExpanded + "'>")

            End Select

            '--- Keep the Total Hrs, project Total Hrs in the hidden textbox for comparison at the client side on 'Ready for verification' click
            CommonFunctions.General.WriteHTML("<input name=txtTotalHrs id=txtTotalHrs type=hidden value=" + CStr(dblTotalHrs) + ">")
            CommonFunctions.General.WriteHTML("<input name=txtProjectTotalHrs id=txtProjectTotalHrs type=hidden value=" + CStr(m_dblProjectTotal) + ">")
            CommonFunctions.General.WriteHTML("<input name=txtMsg id=txtMsg type=hidden value='" + MyBase.GetResourceString("MSG_READY_FOR_VERIFICATION") + "'>")


            '--- Keep Expected Hours and Actual Hours in hidden text box for validation
            CommonFunctions.General.WriteHTML("<input type='hidden' id='txtActualHrs' name='txtActualHrs' value=" + CStr(dblActualHrs) + ">")
            CommonFunctions.General.WriteHTML("<input type='hidden' id='txtExpectedHrs' name='txtExpectedHrs' value=" + CStr(dblExpectedHrs) + ">")

            strMessage = MyBase.GetResourceString("MSG_GENERATE_TIMESHEET")
            If Not IsNothing(strMessage) Then
                strMessage = Replace(strMessage, "ACTUALHRS", CStr(dblActualHrs), 1, , CompareMethod.Text)
                strMessage = Replace(strMessage, "EXPECTEDHRS", CStr(dblExpectedHrs), 1, , CompareMethod.Text)
            End If

            CommonFunctions.General.WriteHTML("<input type='hidden' id='txtMessage' name='txtMessage' value='" + strMessage + "'>")


            CommonFunction.General.WriteHTML("</div>")

            '--- Display the totals for the period
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunctions.General.WriteHTML("<tr class='clsTRColumnHeader'><td align=left>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_PROJECT_TOTAL"))
            CommonFunctions.General.WriteHTML(" " & FormatNumber(m_dblProjectTotal, 2))
            CommonFunctions.General.WriteHTML("</td></tr>")
            CommonFunctions.General.WriteHTML("</TABLE>")


            m_objAdvGrid = Nothing

            '--- Display the Graph
            Call CreateGraphSection()
        Else
            'Code Added by Noble K on 13th Jan 2005
            '--- Add the FromDate and ToDate as hidden controls on the form
            CommonFunctions.General.WriteHTML("<input type='hidden' id='txtFromDate' name='txtFromDate' value=" + CStr(m_dtFromDate) + ">")
            CommonFunctions.General.WriteHTML("<input type='hidden' id='txtToDate' name='txtToDate' value=" + CStr(m_dtToDate) + ">")
            '---
            'Code Added by Noble K on 13th Jan 2005 Ends
        End If

        '' ParagD 13-Sept   
        'Purpose:Hidden variable that will store value of token that is passed in edit mode from Task List Page
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidToken", "txthidToken", value:=m_strToken, returnHTML:=True, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        'End Addition

    End Sub

    Private Sub DrawGrid()
        '=====================================================================
        ' Function Name         : DrawGrid
        ' Purpose               : Displays the grid for the pending Resource Timesheets to be generated
        ' Description           : Same as above
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : Priyanka
        ' Created               : 19th July 2004
        ' Revisions             : 
        '=====================================================================
        Dim arrColHeadingsList As New ArrayList
        Dim arrColNamesList As New ArrayList
        Dim strSQLQuery As String
        Dim drRecordCount As IDataReader
        Dim intRecordCount As Integer
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        '--- Set the Column Headings for the Pending Timesheet List
        arrColHeadingsList.Add(MyBase.GetResourceString("HEADING_FROM_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("HEADING_TO_DATE"))
        arrColHeadingsList.Add(MyBase.GetResourceString("HEADING_ACTUAL_HRS"))
        arrColHeadingsList.Add(MyBase.GetResourceString("HEADING_EXPECTED_HRS"))
        arrColHeadingsList.Add(MyBase.GetResourceString("HEADING_VIEW_TIMESHEET"))
        arrColHeadingsList.Add(MyBase.GetResourceString("HEADING_GENERATE_TIMESHEET"))

        '--- Set the Columns to be used from the SP 
        arrColNamesList.Add("FromDate")
        arrColNamesList.Add("ToDate")
        arrColNamesList.Add("")
        arrColNamesList.Add("")
        arrColNamesList.Add("")
        arrColNamesList.Add("")

        '--- Set the TD style array
        'Commented And Added By Chakshuta H ON 4th-Dec-2015
        'Dim arrWidthArray() As String = {"align=left", "align=left", "align=left", "align=right", "align=right", "align=center", "align=center"}
        Dim arrWidthArray() As String = {"align=left", "align=left", "align=right", "align=right", "align=center", "align=center", "align=center"}
        'End Of Commented And Added By Chakshuta H ON 4th-Dec-2015

        '--- Display the Page Caption 
        CommonFunctions.General.WriteHTML("<br>")
        WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("HEADING_MY_TIMESHEET_PENDING"))
        CommonFunctions.General.WriteHTML("<br>")

        ''Modified Code - VidyaJ - For RT Performance IssueID - 87 - SP4
        ''--- Display the Pending Timesheets for the Resource
        ''--- Get the Record Count to be displayed at Page Footer
        strSQLQuery = "EXEC usp_tbl_PM_PendingResourceTimesheets " + CType(m_intUserID, String)
        'drRecordCount = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        'While drRecordCount.Read()
        '    intRecordCount = intRecordCount + 1
        'End While
        'CommonFunctions.Data.DisposeDataReader(drRecordCount)


        With m_objGrid
            .ActualColumnArray = GetArray(arrColNamesList)
            .UserFriendlyColumnArray = GetArray(arrColHeadingsList)
            .NoOfDataColumns = 2
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:auto"
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            ''Commented and Added by Dhanashri S on 7 Dec 2015 for IssueID:2030
            ''.DIVHeight = 400
            .DIVHeight = 620
            ''End of Comment and Addition by Dhanashri S on 
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        ''Modified Code - VidyaJ - For RT Performance IssueID - 87 - SP4
        intRecordCount = m_objGrid.NoOfRows

        m_objGrid = Nothing
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<BR><TABLE class=clsTable cellpadding=0 cellspacing=0 width='99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD width='100%' align='right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("HEADING_TOTAL_RECORDS") + " " + CStr(intRecordCount) + " </TD></TR></TABLE>")

    End Sub

#End Region

#Region "Grid plotting Events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Dim strSQLQuery As String
        Dim strHTML As New StringBuilder("")
        Dim dtFromDate As Date, dtToDate As Date
        Dim drActualHrs As IDataReader
        Dim dblActualHrs As Double, dblExpectedHrs As Double
        Dim strMessage As String

        Select Case m_strAction
            Case ACTION_PENDING_TIMESHEET

                ''Modified Code - VidyaJ - For RT Performance IssueID - 86 - SP4
                ''Added Condition as query was getting called repeatedly
                'Logic is not implemented in Pending Timesheet SP itself

                'dtFromDate = CDate(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FromDate")))
                'dtToDate = CDate(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ToDate")))

                ''--- Get Expected hours and Actual AMH for the the timesheet period
                'strSQLQuery = "Exec usp_Sel_GetResourceTimesheetExpectedAndActualHours " + CStr(m_intUserID) & ",'" & CStr(dtFromDate) & "','" & CStr(dtToDate) & "'"
                'drActualHrs = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                'If CommonFunctions.General.CheckIsNothing(drActualHrs) <> "" Then
                '    If drActualHrs.Read() Then
                '        dblActualHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drActualHrs.Item("ActualAMH"), "0"))
                '        dblExpectedHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(drActualHrs.Item("NormalAMH"), "0"))
                '    Else
                '        dblActualHrs = 0
                '        dblExpectedHrs = 0
                '    End If
                'Else
                '    dblActualHrs = 0
                '    dblExpectedHrs = 0
                'End If
                'CommonFunctions.Data.DisposeDataReader(drActualHrs)
                dblActualHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ActualAMH"), "0"))
                dblExpectedHrs = CDbl(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("NormalAMH"), "0"))
                'End Of Modifications

                '--- If the Columns are View Timesheet and Generate Timesheet 
                Select Case Args.ColumnName

                    Case MyBase.GetResourceString("HEADING_FROM_DATE"), MyBase.GetResourceString("HEADING_TO_DATE")

                        Cancel = True
                        Args.StringToBeInserted = "<TD align=left>" + CType(CommonFunctions.Dates.CGetDate(CType(Args.DataFieldValue, Date)), String) + "</TD>"

                    Case MyBase.GetResourceString("HEADING_VIEW_TIMESHEET"), MyBase.GetResourceString("HEADING_GENERATE_TIMESHEET")

                        If CInt(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Period"), "0")) = 1 Then

                            '-----it was here
                            '--- Add the Actual and Estimated hrs as hidden controls on the form
                            strHTML.Append("<input type='hidden' id='txtActualHrs' name='txtActualHrs' value=" + CStr(dblActualHrs) + ">")
                            strHTML.Append("<input type='hidden' id='txtExpectedHrs' name='txtExpectedHrs' value=" + CStr(dblExpectedHrs) + ">")
                            '---

                            '--- Add the FromDate and ToDate as hidden controls on the form
                            strHTML.Append("<input type='hidden' id='txtFromDate' name='txtFromDate' value=" + CStr(m_dtFromDate) + ">")
                            strHTML.Append("<input type='hidden' id='txtToDate' name='txtToDate' value=" + CStr(m_dtToDate) + ">")
                            '---

                            '--- Get the Msg form the Resource File to be displayed and replace the Actual and Expected Hrs
                            strMessage = MyBase.GetResourceString("MSG_GENERATE_TIMESHEET")
                            If Not IsNothing(strMessage) Then
                                strMessage = Replace(strMessage, "ACTUALHRS", CStr(dblActualHrs), 1, , CompareMethod.Text)
                                strMessage = Replace(strMessage, "EXPECTEDHRS", CStr(dblExpectedHrs), 1, , CompareMethod.Text)
                            End If

                            strHTML.Append("<input type='hidden' id='txtMessage' name='txtMessage' value='" + strMessage + "'>")

                            If Args.ColumnName = MyBase.GetResourceString("HEADING_VIEW_TIMESHEET") Then
                                strHTML.Append("<TD align=center><a href=Javascript:ViewTimesheet('" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("FromDate"), ""), String) + "','" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ToDate"), ""), String) + "','" + CType(ACTION_VIEW_TIMESHEET, String) + "')>" + MyBase.GetResourceString("HEADING_VIEW_TIMESHEET") + "</a></TD>")

                            ElseIf Args.ColumnName = MyBase.GetResourceString("HEADING_GENERATE_TIMESHEET") Then
                                strHTML.Append("<TD align=center><a href=Javascript:GenerateTimesheetFromList_OnClick()>" + MyBase.GetResourceString("HEADING_GENERATE_TIMESHEET") + "</a></TD>")
                            End If

                        Else
                        If Args.ColumnName = MyBase.GetResourceString("HEADING_VIEW_TIMESHEET") Then
                            strHTML.Append("<TD align=center>" + MyBase.GetResourceString("HEADING_VIEW_TIMESHEET") + "</TD>")
                        ElseIf Args.ColumnName = MyBase.GetResourceString("HEADING_GENERATE_TIMESHEET") Then
                            strHTML.Append("<TD align=center>" + MyBase.GetResourceString("HEADING_GENERATE_TIMESHEET") + "</TD>")
                        End If
                        End If

                        Cancel = True
                        Args.StringToBeInserted = strHTML.ToString

                    Case MyBase.GetResourceString("HEADING_ACTUAL_HRS"), MyBase.GetResourceString("HEADING_EXPECTED_HRS")
                        Cancel = True

                        If Args.ColumnName = MyBase.GetResourceString("HEADING_ACTUAL_HRS") Then
                            strHTML.Append("<TD align=right>" + FormatNumber(dblActualHrs, 2) + "</TD>")
                        ElseIf Args.ColumnName = MyBase.GetResourceString("HEADING_EXPECTED_HRS") Then
                            strHTML.Append("<TD align=right>" + FormatNumber(dblExpectedHrs, 2) + "</TD>")
                        End If

                        Args.StringToBeInserted = strHTML.ToString

                        strHTML = Nothing
                End Select

        End Select
    End Sub

    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint
        Dim sbHTML As New StringBuilder("")

        Select Case m_strAction
            Case ACTION_PENDING_TIMESHEET
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                sbHTML.Append("<BR><TABLE cellspacing=0; cellpadding=0 class=clsTable width='99.9%'>")
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                sbHTML.Append("<TR class='clsTREven'>")
                sbHTML.Append("<TD align=centre valign=top>")
                sbHTML.Append(MyBase.GetResourceString("MSG_PENDING_TIMESHEETS"))
                sbHTML.Append("</TD>")
                sbHTML.Append("</TR>")
                sbHTML.Append("</TABLE></BR>")

                CommonFunctions.General.WriteHTML(sbHTML.ToString())

        End Select
        sbHTML = Nothing
    End Sub

    Private Sub m_objAdvGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objAdvGrid.ColumnHeaderTR_BeforePrint
        Dim sbHTML As New StringBuilder("")

        Select Case m_strAction
            Case ACTION_VIEW_TIMESHEET, ACTION_EDIT_TIMESHEET

                '--- Add the FromDate and ToDate as hidden controls on the form
                sbHTML.Append("<input type='hidden' id='txtFromDate' name='txtFromDate' value=" + CStr(m_dtFromDate) + ">")
                sbHTML.Append("<input type='hidden' id='txtToDate' name='txtToDate' value=" + CStr(m_dtToDate) + ">")
                sbHTML.Append("<input type='hidden' id='txtTimesheetID' name='txtTimesheetID' value=" + CStr(m_intTimesheetID) + ">")
                '---

                CommonFunctions.General.WriteHTML(sbHTML.ToString())

        End Select
        sbHTML = Nothing
    End Sub

    Private Sub m_objAdvGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objAdvGrid.ColumnHeaderTD_BeforePrint

        Select Case Args.DataField.Trim.ToUpper
            Case "PROJECTNAME"
                Args.ColumnName = ""
        End Select
    End Sub

    Private Sub m_objAdvGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objAdvGrid.DataRowTD_BeforePrint
        Dim dtDate As Date
        Dim intTaskID As Integer
        Dim strTDStyle As String, dblHrs As Double


        'Integrated by MrugajaB on 28th March 2005
        'Purpose:To Display approver and status for each timesheet
        Dim drGetApprovalDetails As IDataReader
        Dim strSQLQuery As String

        If Args.DataField.ToUpper <> "PROJECTNAME" Then

            'Modified Code - VidyaJ - For RT Performance IssueID - 86 - SP4
            If m_intPrevProjectSelected <> 0 Then
                m_intPrevProjectSelected = m_intProjectID
            End If

            m_strProjectSelected = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectName"), ""), String)
            m_intProjectID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ProjectID"), "0"), Integer)

            'Modified By MrugajaB on 02 Apr 2005
            'Purpose:-StatusCode gets value only while editing timesheet so 'If' condition is added
            'Modified Code - VidyaJ - For RT Performance IssueID - 86 - SP4
            If m_strAction = ACTION_EDIT_TIMESHEET And m_intPrevProjectSelected <> m_intProjectID Then
                'End Modification
                m_strTimesheetStatus = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("StatusCode"), ""), String)
                If m_strTimesheetStatus <> STATUS_NOT_READY_FOR_VERIFICATION Then
                    strSQLQuery = "usp_sel_GetProjectwiseTimesheetStatus " + CType(m_intTimesheetID, String) + "," + CType(m_intProjectID, String)
                    drGetApprovalDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                    If drGetApprovalDetails.Read Then
                        m_strApproverName = CType(CommonFunctions.Data.CheckIsDBNull(drGetApprovalDetails("ApproverName"), ""), String)
                        m_strProjectStatus = CType(CommonFunctions.Data.CheckIsDBNull(drGetApprovalDetails("Status"), ""), String)
                    End If
                End If
                CommonFunction.Data.DisposeDataReader(drGetApprovalDetails)
                'Modified Code - VidyaJ - For RT Performance IssueID - 86 - SP4
                m_intPrevProjectSelected = m_intProjectID
            End If
            ' End Addition
        End If

        If (Args.DataField.ToUpper <> "PROJECTNAME" And Args.DataField.ToUpper <> "TASKNAME" And Args.DataField.ToUpper <> "NORMALAMH") Then
            dtDate = DateAdd("d", m_intDayCounter - 1, m_dtFromDate)
            intTaskID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TaskID"), "0"), Integer)
            dblHrs = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Day" + CStr(m_intDayCounter)), "0"), Double)

            '--- Maintain the Totals for Project and Daywise
            m_arrDaywiseTotals(m_intDayCounter) += dblHrs
            m_dblProjectTotal += dblHrs

            If dblHrs > 0 Then
                If m_intNoOfDays > 15 Then
                    If m_intDayCounter >= 1 And m_intDayCounter <= 15 Then
                        If m_strGroup1IsExpanded = "1" Then
                            Args.DataFieldValue = dblHrs
                            If m_intDayCounter = 15 Then
                                Args.StringToBeInserted = "<TD align=right valign=top><a href=javascript:Task_OnClick('" + CStr(dtDate) + "'," + CStr(intTaskID) + ")>" + FormatNumber(CStr(dblHrs), 2) + "</a>"
                            Else
                                Args.StringToBeInserted = "<TD align=right valign=top><a href=javascript:Task_OnClick('" + CStr(dtDate) + "'," + CStr(intTaskID) + ")>" + FormatNumber(CStr(dblHrs), 2) + "</a></TD>"
                            End If
                            Cancel = True
                        End If
                    End If

                    If m_intDayCounter >= 16 And m_intDayCounter <= m_intNoOfDays Then
                        If m_strGroup2IsExpanded = "1" Then
                            Args.DataFieldValue = dblHrs
                            If m_intDayCounter = m_intNoOfDays Then
                                Args.StringToBeInserted = "<TD align=right valign=top><a href=javascript:Task_OnClick('" + CStr(dtDate) + "'," + CStr(intTaskID) + ")>" + FormatNumber(CStr(dblHrs), 2) + "</a>"
                            Else
                                Args.StringToBeInserted = "<TD align=right valign=top><a href=javascript:Task_OnClick('" + CStr(dtDate) + "'," + CStr(intTaskID) + ")>" + FormatNumber(CStr(dblHrs), 2) + "</a></TD>"
                            End If

                            Cancel = True
                        End If
                    End If

                Else
                    Args.StringToBeInserted = "<TD align=right valign=top><a href=javascript:Task_OnClick('" + CStr(dtDate) + "'," + CStr(intTaskID) + ")>" + FormatNumber(CStr(dblHrs), 2) + "</a></TD>"
                    Cancel = True
                End If
            End If

            m_dblGroupTotal += dblHrs
            m_intDayCounter = m_intDayCounter + 1
        End If

        Select Case m_strAction
            Case ACTION_EDIT_TIMESHEET
                Select Case Args.ColumnName
                    Case MyBase.GetResourceString("HEADING_TASK_NAME")
                        Dim strTaskID As String
                        Dim strSQL As String
                        Dim drGetTaskDetails As IDataReader

                        Dim intFlag As Integer

                        strTaskID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskID"), ""), String)
                        'Addition by NobleK 12th Jan 2005.
                        If strTaskID <> "" Then
                            'Modified Code - VidyaJ - For RT Performance IssueID - 86 - SP4
                            'Instaed of Firing the query for each task in grid events , this logic is included in grid sp itself

                            'strSQL = "Select IsNULL(Count(DailyActivityEntryID),0) as NotApprovedActivities From tbl_PM_DailyActivity WHERE TaskID =" + CType(strTaskID, String) + " AND ResourceTimesheetID = " + CType(m_intTimesheetID, String) + " AND IsNULL(Verified,0) = 0 "

                            'drGetTaskDetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                            'If drGetTaskDetails.Read Then
                            'If CType(CommonFunctions.Data.CheckIsDBNull(drGetTaskDetails("NotApprovedActivities"), "0"), Integer) > 0 Then
                            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("NotApprovedActivities"), "0"), Integer) > 0 Then
                                Cancel = True
                                Args.StringToBeInserted = "<TD  vAlign=top style='width=19%' align=left title='" + MyBase.GetResourceString("HEADING_TASK_NAME") + "'>" + "<font color='#cc0000'>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskName"), ""), String) + "</font></td>"
                            End If
                            ' End If
                            'CommonFunction.Data.DisposeDataReader(drGetTaskDetails)
                        End If
                        'End Of Modifications
                        'CommonFunction.Data.DisposeDataReader(drGetTaskDetails)
                        'Addition by NobleK 12th Jan 2005 Ends. 
                        'strSQL = "Select IsNULL(Count(*),0) as NotApprovedActivities From tbl_PM_DailyActivity WHERE TaskID =" + CType(strTaskID, String) + " AND ResourceTimesheetID = " + CType(m_intTimesheetID, String) + " AND IsNULL(Verified,0) = 0 "

                        'drGetTaskDetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                        'If drGetTaskDetails.Read Then
                        '    If CType(CommonFunctions.Data.CheckIsDBNull(drGetTaskDetails("NotApprovedActivities"), "0"), Integer) > 0 Then
                        '        Cancel = True
                        '        Args.StringToBeInserted = "<TD  vAlign=top style='width=19%' align=left title='" + MyBase.GetResourceString("HEADING_TASK_NAME") + "'>" + "<font color='#cc0000'>" + CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TaskName"), ""), String) + "</font></td>"

                        '    End If
                        'End If
                        'CommonFunction.Data.DisposeDataReader(drGetTaskDetails)
                End Select
        End Select

    End Sub

    Private Sub m_objAdvGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objAdvGrid.DataRowTR_AfterPrint
        Args.StringToBeInserted = "<script> var objTD; objTD = document.getElementsByTagName('td');var strInText=objTD.innerHTML; if(strInText=='0.00')strInText=''; </script>"
        m_intDayCounter = 1
    End Sub

    Private Sub m_objAdvGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objAdvGrid.SummaryFunctionsTD_BeforePrint

        If Args.ColIndex = 1 Then
            Args.StringToBeInserted = "<TD align=left>" + MyBase.GetResourceString("HEADING_DAYWISE_TOTAL") + "</TD>"
            Cancel = True
        End If

        If Args.ColIndex < (m_intNoOfDays + 2) Then
            If Args.SummaryFunction = "SUM" Then
                Args.SummaryValue = m_arrDaywiseTotals(Args.ColIndex - 1)
            End If
        End If

    End Sub

    Private Sub m_objAdvGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objAdvGrid.DataRowTR_BeforePrint

        'Check for Group Value
        If (m_strProjectSelected <> CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectName").ToString.Trim, ""), String)) And (m_strProjectSelected <> "") Then
            Args.StringToBeInserted = DisplayProjectwiseTotals()
            m_dblGroupTotal = 0
        End If

    End Sub

    Private Sub m_objAdvGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objAdvGrid.SummaryFunctionsTR_BeforePrint
        Args.StringToBeInserted = DisplayProjectwiseTotals()
    End Sub

#End Region

    Private Sub m_objAdvGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles m_objAdvGrid.DataRowTD_AfterPrint

    End Sub

    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint

    End Sub
End Class



