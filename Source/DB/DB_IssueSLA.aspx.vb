Option Strict Off
Public Class DB_IssueSLA
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmTimeSheet As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()


    End Sub

#End Region
    Private m_objGlobal As WebPages.Template.IGlobal   ' To store Global object
    Dim m_strBUID As String                              ' to store selected BU ID
    Dim m_strOUID As String                              ' to store selected OU ID
    Dim m_strProjectID As String                        ' to store selected Project ID
    Dim m_strEmployeeID As String                        ' to store selected Employee ID
    Dim m_strFromdate As String                          ' to store from date
    Dim m_strTodate As String                            ' to store To Date
    Protected m_strMode As String                             ' indicates mode of page 'GenerateReport' or ' 
    Protected m_strFrom As String
    Protected m_strDisplayDetails As String
    Protected m_strMove As String
    Protected m_strView As String
    Protected m_strID As String
    Protected m_dtStartDateOfWeek As Date
    Protected m_dtEndDateOfWeek As Date
    Dim strStartDateOfWeek As String = ""
    Protected m_intStartingDayOfWeek As Integer = 0
    Protected m_intCurrentDayOfWeek As Integer = 0
    Dim m_strSessionUserID As String                    ' to store session user id
    'Private m_strResourcePageCaption As String = MyBase.GetResourceString("GRAPHTITLE") 'to store page caption
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' graph location
    Private m_intGraphHeight As Integer                 ' graph Height    
    Private m_intGraphWidth As Integer                  '  graph width
    ' Private WithEvents objListGrid As New WebPage.Templates.GenericGrid
    Private WithEvents objListGrid As New WebPage.Templates.AdvancedGrid
    Private WithEvents objListSummaryGrid As New WebPage.Templates.GenericGrid
    Private m_strMonth As String = ""
    Private m_GroupTotalCapacity As Double = -1
    Private m_GroupTotalAllocated As Double = -1
    Private m_GroupTotalActual As Double = -1
    Private m_GroupTotalBillable As Double = -1
    Private m_GroupTotalCapacityPer As Double = -1
    Private m_GroupTotalAllocatedPer As Double = -1
    Private m_GroupTotalActualPer As Double = -1
    Private m_GroupTotalBillablePer As Double = -1
    Private m_GroupInstallCapacity As Double = -1
    Private m_intCount As Integer = 0
    Private UTILIZATION_TAGID As Long
    ' Added by NitinVS on 20 July 2005 for WhizSEM SP4 IssueId 182
    Private m_strProjectFilters As String = ""
    Private intRoleLevel As Integer
    Private m_strDUID As String  ' Delivery Unit ID 
    Private m_strDateRangeID As String
    Protected m_intProjectReport As Integer
    Private m_GrandTotalCapacity As Double = 0
    Private m_GrandTotalAllocated As Double = 0
    Private m_GrandTotalActual As Double = 0
    Private m_GrandTotalBillable As Double = 0
    Private m_GrandTotalCapacityPer As Double = 0
    Private m_GrandTotalAllocatedPer As Double = 0
    Private m_GrandTotalActualPer As Double = 0
    Private m_GrandTotalBillablePer As Double = 0
    Private m_GrandInstallCapacity As Double = 0
    Protected m_strLoginType As String = "E"
    Protected m_strLoginName As String = ""

    Public dtmSelectedDate As String
    Public dtmFromDate As String, dtmFromDate1 As String
    Public dtmToDate As String, dtmToDate1 As String
    Protected m_UseEditableDateControl As Boolean = CommonFunctions.General.GetFrameworkSettings("EDITABLE_DATE_CONTROL", "Enabled")
    Protected strInputdateFormat As String = CommonFunction.Application.InputeDateFormat
    Private WithEvents objListRelatedDataGrid As New WebPage.Templates.GenericGrid
    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
        ' Revisions             :
        '=====================================================================
        Call SetVariables()



        Response.Write(GenerateMenu())
        'Initialize resource file 
        MyBase.InitializeResources("AppResources.DB_IssueSLA", "AppResources")
        'If Not IsPostBack() Then
        Call GeneratePageCaption()
        Call GeneratePageHeader()
        'End If

        If m_strMode.ToUpper <> "MEETSLA" And m_strMode.ToUpper <> "ALERTSLA" And m_strMode.ToUpper <> "ESCSLA" And m_strDisplayDetails.ToUpper <> "TRUE" Then

            CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:450px'>")
            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='100%'  class=clsTable><TR class=clsTREven " + ">")
            'Display Business Unit Combo
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right> View </TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            ''CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboView", "SELECT  'Customer' union SELECT  'AssignTo' union  SELECT  'ProjectWise'  ", , True, True, True, False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboView", "usp_sel_View", , True, True, True, False))

            CommonFunctions.General.WriteHTML("</TD>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right> Customer </TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboCustomer", "usp_sel_tbl_PM_Customer_cboCustomer", , True, True, , False))
            CommonFunctions.General.WriteHTML("</TD></TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right> Employee </TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", "usp_sel_tbl_PM_Employee_cboEmployee", , True, True, , False))
            CommonFunctions.General.WriteHTML("</TD></TR>")

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right> Project </TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            '' CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "SELECT ProjectId,ProjectName FROM tbl_PM_Project order by ProjectName  ", , True, True, , False))
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_tbl_PM_Project_cboProject", , True, True, , False))
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            CommonFunctions.General.WriteHTML("</TD></TR>")

            CommonFunctions.General.WriteHTML("</TR></TABLE></DIV>")


        End If



        If Request.QueryString("SelectedDate") <> "" Then
            dtmSelectedDate = Request.QueryString("SelectedDate")
        Else
            dtmSelectedDate = CommonFunction.Dates.GetDate(Now())
            'dtmSelectedDate = CDate(CommonFunction.Dates.GetDate(CDate(Session("ClientDate"))).ToString("dd-MMM-yyyy")
            'dtmSelectedDate = New Date
        End If

        'dtmSelectedDate = dtmToDate
        ' Response.Write(CommonFunctions.Dates.GetDate(CDate(Session("ClientDate"))))
        CommonFunction.Dates.GetFromAndToDates("1", dtmFromDate, dtmToDate, dtmSelectedDate)

        dtmFromDate1 = CommonFunctions.Dates.GetDate(CType(dtmFromDate, Date))
        'dtmToDate1 = CommonFunctions.Dates.GetDate(CType(dtmToDate, Date))
        'dtmFromDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 2, Date.Parse(dtmFromDate)))
        'integrated by harshada d on 19092005 for issue id 299
        ' code commented and added by harshada d for ALLIANCE issue 20412 : to take into consideration the startday of the week and weekDays from the table tbl_pm_companyInformation .
        'dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 2, Date.Parse(dtmToDate)))
        Dim intdayDiff As Integer ' this variable stores the no of weekEnd days .
        intdayDiff = 6 - CType(DateDiff("d", CDate(dtmFromDate), CDate(dtmToDate)), Integer)
        dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 6, Date.Parse(dtmFromDate1)))
        ' end of addition by harshada d for ALLIANCE issue 20412 
        'end of integration by harshada d on 19092005 for issue id 299

        If Request.QueryString("Move") = "NEXT" Then
            dtmSelectedDate = CommonFunctions.Dates.GetDate(DateAdd("d", 7, Date.Parse(dtmSelectedDate)))
            dtmFromDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 7, Date.Parse(dtmFromDate)))
            dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 6, Date.Parse(dtmFromDate1)))
        End If

        If Request.QueryString("Move") = "PREV" Then
            dtmSelectedDate = CommonFunctions.Dates.GetDate(DateAdd("d", -7, Date.Parse(dtmSelectedDate)))
            dtmFromDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", -7, Date.Parse(dtmFromDate)))
            dtmToDate1 = CommonFunctions.Dates.GetDate(DateAdd("d", 6, Date.Parse(dtmFromDate1)))
        End If

        ' Modified by NitinVS on 7 Dec 2005 for WhizibleSEM  SP5 IssueID 672

        If m_strDisplayDetails.ToUpper <> "TRUE" Then
            Response.Write("<table CellSpacing='0' width='100%'><tr class='clsTREven' width='100%'><td width='100%'>")
            Response.Write("<center>     From Date " + CommonFunctions.HTMLControls.DrawDateControl("FromDate", "FromDate", , , dtmFromDate1, , "frmSLAReport", "..\..\images\Calendar.gif", , , , , , True, True, "../../Images/Star.gif", " onKeyPress=FromDate_onKeyPress(event)") + "      ")
            'Response.Write("To Date " + CommonFunctions.HTMLControls.DrawTextBox("ToDate", "ToDate", , 80, , dtmToDate1, , , True, , , , , True, , ) + "</center>")
            Response.Write("To Date " + CommonFunction.HTMLControls.DrawDateControl("ToDate", "ToDate", , 80, dtmToDate1, , "frmSLAReport", , , , True, True, , True) + "</center>")
            ' End Modification by NitinVS on 7 Dec 2005 for WhizibleSEM  SP5 IssueID 672
            Response.Write("</td></tr></table>")
            Response.Write("<BR>")
        End If

        'If Request.QueryString("Show") = "true" Then
        'If Request.QueryString("Show") <> "true" Then
        If Request.QueryString("FromDate") <> "" Then
            dtmFromDate = Request.QueryString("FromDate")
        Else
            dtmFromDate = dtmFromDate1
        End If
        If Request.QueryString("ToDate") <> "" Then
            dtmToDate = Request.QueryString("ToDate")
        Else
            dtmToDate = dtmToDate1
        End If







        CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='Overflow:auto'>")

        If (m_strMode.ToUpper = "MEETSLA" Or m_strMode.ToUpper = "ALERTSLA" Or m_strMode.ToUpper = "ESCSLA") And m_strDisplayDetails.ToUpper <> "TRUE" Then

            ''added by purvaj on 13 july 2006 
            'CommonFunctions.General.WriteHTML("<DIV id='DivGraph' style='Overflow:auto;width:100%;height=450px'>")
            ''end addition purvaj

            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%' height='99.9%' class=clsTable><TR class=clsTREven " + ">")
            CommonFunctions.General.WriteHTML(" <TD align=center>")
            If m_strMode.ToUpper = "MEETSLA" Then
                GenerateSLAMeetReportGraph()
            End If
            If m_strMode.ToUpper = "ALERTSLA" Then
                GenerateSLAAlertReportGraph()
            End If
            If m_strMode.ToUpper = "ESCSLA" Then
                GenerateSLAEscReportGraph()
            End If
            CommonFunctions.General.WriteHTML(" </TD></TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
            CommonFunctions.General.WriteHTML("</DIV>")


            'CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='100%'  class=clsTable><TR class=clsTRPageFooter " + ">")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven width=10%><b> " + MyBase.GetResourceString("NOTE") + " : </b> </TD> ")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left> " + MyBase.GetResourceString("REPORTEDISSUES") + "   </TD></TR> ")
            'CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("APPLICABLEISSUES") + " </TD></TR> ")
            'CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
            'CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
            'If m_strMode.ToUpper = "MEETSLA" Then
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("MEETISSUES") + "     </TD></TR> ")
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>   " + MyBase.GetResourceString("NOTMEETISSUES") + "  </TD></TR></TABLE> ")
            'End If
            'If m_strMode.ToUpper = "ALERTSLA" Then
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("ALERTISSUES") + "     </TD></TR>")
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left> &nbsp; </TD></TR></TABLE> ")
            'End If
            'If m_strMode.ToUpper = "ESCSLA" Then
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("ESC_ISSUES") + "     </TD></TR> ")
            '    CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
            '    CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  &nbsp;  </TD></TR></TABLE> ")
            'End If

        End If




        If m_strMode.ToUpper = "MEETSLA" And m_strDisplayDetails.ToUpper = "TRUE" Then
            DisplaySLAMeetDetails()
        End If

        If m_strMode.ToUpper = "ALERTSLA" And m_strDisplayDetails.ToUpper = "TRUE" Then
            DisplaySLAAlertDetails()
        End If

        If m_strMode.ToUpper = "ESCSLA" And m_strDisplayDetails.ToUpper = "TRUE" Then
            DisplaySLAEscDetails()
        End If
        ' Call DisplayPageDetails()
        Response.Write(GenerateMenu())

    End Sub
    Private Sub GenerateSLAMeetReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate Resource Utilization Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
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
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(4) As String
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "Red", "Green", "Peru", "Brown"}

        strSQL = "usp_Sel_IssueSLADashBoard null,'" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        If m_strView = "C" Then 'CUSTOMER
            strSQL = "usp_Sel_IssueSLADashBoard null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','C','" + m_strID.ToString + "'"
        End If
        'If m_strView = "A" Then 'ASSIGN TO
        '    strSQL = "usp_Sel_IssueSLADashBoard null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        'End If
        If m_strView = "E" Then 'PROJECTWISE
            strSQL = "usp_Sel_IssueSLADashBoard  null,'" + dtmFromDate1 + " ','" + dtmToDate1 + "','E','" + m_strID.ToString + "'"
        End If
        If m_strView = "E" And m_strFrom = "Resource" Then
            strSQL = "usp_Sel_IssueSLADashBoard null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        End If
        strImageFileName = "IssueSLA" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "Issue SLA"
        blnShowCaptions = True
        ' create the graph for the item values
        objGraph = New Graph.Graph
        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            arr(0) = "STACKEDCOLUMN"
            arr(1) = "STACKEDCOLUMN"
            arr(2) = "STACKEDCOLUMN"
            arr(3) = "STACKEDCOLUMN"
            arr(4) = "STACKEDCOLUMN"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "GoldenRod"
            .ShowLegends = True
            .XAxisTitle = MyBase.GetResourceString("XAXISTITLE")
            .Nomenclature = MyBase.GetResourceString("YAXISTITLE")
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "Green"
            .ShowDataColumnNameAsXAxisTitle = False
            '-- Fixed Settings
            .GraphTitle = MyBase.GetResourceString("GRAPHTITLE")
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .SQL = strSQL
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            ' .ExtendedSeriesColor = arrColor
            .LegendColor = arrColor
            'Added by purvaj on 13 July 2006 roamware customization
            .YAxisInterval = 1
            '.Height = 350
            'End addition purvaj
            ' return the graph image
            .GenerateStackedGraphImage()
        End With


        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & strImageFileName & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If




    End Sub
    Private Sub GenerateSLAAlertReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate Resource Utilization Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
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
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(3) As String
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "Red", "Peru", "Brown"}
        strSQL = "usp_Sel_SLAIssues_Alert_Esc  'A', null,'" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        If m_strView = "C" Then 'CUSTOMER
            strSQL = "usp_Sel_SLAIssues_Alert_Esc 'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','C','" + m_strID.ToString + "'"
        End If
        'If m_strView = "A" Then 'ASSIGN TO
        '    strSQL = "usp_Sel_SLAIssues_Alert_Esc 'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        'End If
        If m_strView = "E" Then 'PROJECTWISE
            strSQL = "usp_Sel_SLAIssues_Alert_Esc  'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','E','" + m_strID.ToString + "'"
        End If
        If m_strView = "E" And m_strFrom = "Resource" Then
            strSQL = "usp_Sel_SLAIssues_Alert_Esc 'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        End If

        strImageFileName = "IssueSLA" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "Issue SLA"
        blnShowCaptions = True

        ' create the graph for the item values
        objGraph = New Graph.Graph

        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            arr(0) = "STACKEDCOLUMN"
            arr(1) = "STACKEDCOLUMN"
            arr(2) = "STACKEDCOLUMN"
            arr(3) = "STACKEDCOLUMN"

            'arr(5) = "COLUMN"
            'arr(6) = "LINE"
            'arr(7) = "LINE"
            'arr(8) = "LINE"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "GoldenRod"
            .ShowLegends = True
            .XAxisTitle = MyBase.GetResourceString("XAXISTITLE")
            .Nomenclature = MyBase.GetResourceString("YAXISTITLE")
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "Green"
            .ShowDataColumnNameAsXAxisTitle = False

            '-- Fixed Settings
            .GraphTitle = MyBase.GetResourceString("GRAPHTITLE")
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .SQL = strSQL
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .LegendColor = arrColor
            'Added by purvaj on 13 July 2006 roamware customization
            .YAxisInterval = 1
            '.Height = 460
            'End addition purvaj
            ' return the graph image
            .GenerateStackedGraphImage()
        End With


        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & strImageFileName & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If




    End Sub
    Private Sub GenerateSLAEscReportGraph()
        '=====================================================================
        ' Procedure Name        : GenerateReport()	
        ' Purpose               : to Generate Resource Utilization Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
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
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath As String
        Dim arr(3) As String
        Dim i As Integer
        Dim strQuery As String
        Dim arrColor() As String = {"", "Red", "Peru", "Brown"}

        strSQL = "usp_Sel_SLAIssues_Alert_Esc  'E', null,'" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        If m_strView = "C" Then 'CUSTOMER
            strSQL = "usp_Sel_SLAIssues_Alert_Esc 'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','C','" + m_strID.ToString + "'"
        End If
        'If m_strView = "A" Then 'ASSIGN TO
        '    strSQL = "usp_Sel_SLAIssues_Alert_Esc 'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        'End If
        If m_strView = "E" Then 'PROJECTWISE
            strSQL = "usp_Sel_SLAIssues_Alert_Esc  'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','E','" + m_strID.ToString + "'"
        End If
        If m_strView = "E" And m_strFrom = "Resource" Then
            strSQL = "usp_Sel_SLAIssues_Alert_Esc 'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        End If

        strImageFileName = "IssueSLA" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "Issue SLA"
        blnShowCaptions = True

        ' create the graph for the item values
        objGraph = New Graph.Graph

        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .VirtualImagePath = ""
            .Enable3D = False
            arr(0) = "STACKEDCOLUMN"
            arr(1) = "STACKEDCOLUMN"
            arr(2) = "STACKEDCOLUMN"
            arr(3) = "STACKEDCOLUMN"
            'arr(4) = "COLUMN"
            'arr(5) = "COLUMN"
            'arr(6) = "LINE"
            'arr(7) = "LINE"
            'arr(8) = "LINE"
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "GoldenRod"
            .ShowLegends = True
            .XAxisTitle = MyBase.GetResourceString("XAXISTITLE")
            .Nomenclature = MyBase.GetResourceString("YAXISTITLE")
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "Green"
            .ShowDataColumnNameAsXAxisTitle = False

            '-- Fixed Settings
            .GraphTitle = MyBase.GetResourceString("GRAPHTITLE")
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .SQL = strSQL
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            'Added by purvaj on 13 July 2006 roamware customization
            .YAxisInterval = 1
            '.Height = 460
            'End addition purvaj
            .LegendColor = arrColor
            ' return the graph image
            .GenerateStackedGraphImage()
        End With


        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & strImageFileName & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & strImageFileName & ".png" & "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If




    End Sub
    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 06, 2004
        ' Revisions             :
        '=====================================================================
        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList
        'Initialize resource file 
        MyBase.InitializeResources("AppResources.DB_IssueSLA", "AppResources")

        If m_strMode.ToUpper <> "MEETSLA" And m_strMode.ToUpper <> "ALERTSLA" And m_strMode.ToUpper <> "ESCSLA" Then
            'Generate Report
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_MEETSLA"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_MEETSLA_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("MeetSLA()")

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ALERTSLA"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ALERTSLA_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("AlertSLA()")

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ESCSLA"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ESCSLA_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("EscSLA()")
        End If

        If (m_strMode.ToUpper = "MEETSLA" Or m_strMode.ToUpper = "ALERTSLA" Or m_strMode.ToUpper = "ESCSLA") And m_strDisplayDetails.ToUpper <> "TRUE" Then

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MNU_PREVIOUE_WEEK"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MNU_PREVIOUE_WEEK_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("PreviousWeek_OnClick()")

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MNU_NEXT_WEEK"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MNU_NEXT_WEEK_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("NextWeek_OnClick()")

            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("DisplayDetails_MeetSLA()")

            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            MyBase.InitializeResources("AppResources.DB_IssueSLA", "AppResources")
            If m_strMode.ToUpper = "MEETSLA" Then
                ArrTopMenuFunctionsList.Add(" Help_OnClick('" + MyBase.GetResourceString("HELPID_MEETSLA") + "')")
            End If
            If m_strMode.ToUpper = "ALERTSLA" Then
                ArrTopMenuFunctionsList.Add(" Help_OnClick('" + MyBase.GetResourceString("HELPID_ALERTSLA") + "')")
            End If
            If m_strMode.ToUpper = "ESCSLA" Then
                ArrTopMenuFunctionsList.Add(" Help_OnClick('" + MyBase.GetResourceString("HELPID_ESCSLA") + "')")
            End If

        End If
        If (m_strMode.ToUpper = "MEETSLA" And m_strDisplayDetails.ToUpper = "TRUE") Or (m_strMode.ToUpper = "ALERTSLA" And m_strDisplayDetails.ToUpper = "TRUE") Or (m_strMode.ToUpper = "ESCSLA" And m_strDisplayDetails.ToUpper = "TRUE") Then
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
            ArrTopMenuFunctionsList.Add(" Close_OnClink()")
            'Initialize resource file 
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
            MyBase.InitializeResources("AppResources.DB_IssueSLA", "AppResources")
            ArrTopMenuFunctionsList.Add(" Help_OnClick('" + MyBase.GetResourceString("HELPID_DETAILS") + "')")

        End If



        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True) + "<BR>"
    End Function
    Private Sub DisplaySLAMeetDetails()

        Dim ArrActualFieldNames() As String = {"ReportedDate", "ProjectName", "IssueType", "IssueName", "SLAName", "FromStatus", "ToStatus", "PlanDuration", "ActualDuration", "UnitOfNorm", "Status"} '"Severity", "Priority", "Complexity", "Status"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {"Reported Date", "Project Name", "Issue Type", "Issue Name", "SLA Name", "From Status", "To Status", "Plan Duration", "Actual Duration", "Unit Of Norm", "SLA Status"} '"Severity", "Priority", "Complexity", "Status"}

        Dim ArrTDStyle() As String = {"align=left width=15%", "align=left width=30%", "align=left width=15%", "align=left width=25%", "align=left width=15%", "align=left width=5%", "align=left width=5%", "align=right width=5%", "align=right width=5%", "align=left width=5%", "align=left width=5%"} ', "align=left width=5%", "align=left width=5%", "align=left width=5%"}
        Dim strSQL As String
        Dim ArrGroupColumn() As String = {"1"}

        'strSQL = "usp_Sel_IssueSLADashBoard_Details 1123,'5-June-2006','11-June-2006'"
        strSQL = "usp_Sel_IssueSLADashBoard_Details NULL,'" + dtmFromDate1 + "','" + dtmToDate1 + "'"


        If m_strView = "C" Then 'CUSTOMER
            strSQL = "usp_Sel_IssueSLADashBoard_Details null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','C','" + m_strID.ToString + "'"
        End If
        'If m_strView = "A" Then 'ASSIGN TO
        '    strSQL = "usp_Sel_IssueSLADashBoard_Details null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        'End If
        'If m_strView = "P" Then 'PROJECTWISE
        '    strSQL = "usp_Sel_IssueSLADashBoard_Details  '" + m_strID.ToString + "','" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        'End If

        If m_strView = "E" Then 'PROJECTWISE
            strSQL = "usp_Sel_IssueSLADashBoard_Details  null,'" + dtmFromDate1 + " ','" + dtmToDate1 + "','E','" + m_strID.ToString + "'"
        End If

        If m_strView = "E" And m_strFrom = "Resource" Then
            strSQL = "usp_Sel_IssueSLADashBoard_Details null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        End If
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        With objListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .GroupOnColumn = ArrGroupColumn
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 600
            .SQL = strSQL
            '.ShowSummaryFunctions = True
            '  .GroupSummaryFunc = ArrGroupSummaryFunctions
            '  .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .EmptyValueReplacement = ""
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
    End Sub
    Private Sub DisplaySLAAlertDetails()

        Dim ArrActualFieldNames() As String = {"ReportedDate", "ProjectName", "IssueType", "IssueName", "SLAName", "FromStatus", "ToStatus", "PlanDuration", "ActualDuration", "UnitOfNorm", "Status"} '"Severity", "Priority", "Complexity", "Status"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {"Reported Date", "Project Name", "Issue Type", "Issue Name", "SLA Name", "From Status", "To Status", "Plan Duration", "Actual Duration", "Unit Of Norm", "SLA Status"} '"Severity", "Priority", "Complexity", "Status"}

        Dim ArrTDStyle() As String = {"align=left width=15%", "align=left width=30%", "align=left width=15%", "align=left width=25%", "align=left width=15%", "align=left width=5%", "align=left width=5%", "align=right width=5%", "align=right width=5%", "align=left width=5%", "align=left width=5%"} ', "align=left width=5%", "align=left width=5%", "align=left width=5%"}
        Dim strSQL As String
        Dim ArrGroupColumn() As String = {"1"}

        strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details  'A', null,'" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        If m_strView = "C" Then 'CUSTOMER
            strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','C','" + m_strID.ToString + "'"
        End If
        'If m_strView = "A" Then 'ASSIGN TO
        '    strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        'End If
        'If m_strView = "P" Then 'PROJECTWISE
        '    strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details  'A','" + m_strID.ToString + "','" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        'End If

        If m_strView = "E" Then 'PROJECTWISE
            strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'A',null,'" + dtmFromDate1 + " ','" + dtmToDate1 + "','E','" + m_strID.ToString + "'"
        End If
        If m_strView = "E" And m_strFrom = "Resource" Then
            strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'A',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        End If

        Dim arrIgnoreHTMLEncode() As String = {"0"}
        With objListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .GroupOnColumn = ArrGroupColumn
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 600
            .SQL = strSQL
            '.ShowSummaryFunctions = True
            '  .GroupSummaryFunc = ArrGroupSummaryFunctions
            '  .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .EmptyValueReplacement = ""
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
    End Sub
    Private Sub DisplaySLAEscDetails()

        Dim ArrActualFieldNames() As String = {"ReportedDate", "ProjectName", "IssueType", "IssueName", "SLAName", "FromStatus", "ToStatus", "PlanDuration", "ActualDuration", "UnitOfNorm", "Status"} '"Severity", "Priority", "Complexity", "Status"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {"Reported Date", "Project Name", "Issue Type", "Issue Name", "SLA Name", "From Status", "To Status", "Plan Duration", "Actual Duration", "Unit Of Norm", "SLA Status"} '"Severity", "Priority", "Complexity", "Status"}

        Dim ArrTDStyle() As String = {"align=left width=15%", "align=left width=30%", "align=left width=15%", "align=left width=25%", "align=left width=15%", "align=left width=5%", "align=left width=5%", "align=right width=5%", "align=right width=5%", "align=left width=5%", "align=left width=5%"} ', "align=left width=5%", "align=left width=5%", "align=left width=5%"}
        Dim strSQL As String
        Dim ArrGroupColumn() As String = {"1"}

        strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details  'E', null,'" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        If m_strView = "C" Then 'CUSTOMER
            strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','C','" + m_strID.ToString + "'"
        End If
        'If m_strView = "A" Then 'ASSIGN TO
        '    strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        'End If
        'If m_strView = "P" Then 'PROJECTWISE
        '    strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details  'E','" + m_strID.ToString + "','" + dtmFromDate1 + "','" + dtmToDate1 + "'"
        'End If
        If m_strView = "E" Then 'PROJECTWISE
            strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'E',null,'" + dtmFromDate1 + " ','" + dtmToDate1 + "','E','" + m_strID.ToString + "'"
        End If
        If m_strView = "E" And m_strFrom = "Resource" Then
            strSQL = "usp_Sel_SLAIssues_Alert_Esc_Details 'E',null,'" + dtmFromDate1 + "','" + dtmToDate1 + "','A','" + m_strID.ToString + "'"
        End If

        Dim arrIgnoreHTMLEncode() As String = {"0"}
        With objListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .GroupOnColumn = ArrGroupColumn
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 600
            .SQL = strSQL
            '.ShowSummaryFunctions = True
            '  .GroupSummaryFunc = ArrGroupSummaryFunctions
            '  .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            .EmptyValueReplacement = ""
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
    End Sub
    Protected Sub GeneratePageHeader()
        '=====================================================================
        ' Procedure Name        : GeneratePageHeader()	
        ' Purpose               : to generate page header
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Aug 04, 2004
        ' Revisions             :
        '=====================================================================

        Dim objHeaderFooter As New WebPage.Templates.HeaderFooter


        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)

        objHeaderFooter = Nothing



    End Sub
    Private Sub GeneratePageCaption()
        If m_strMode.ToUpper = "MEETSLA" And m_strDisplayDetails.ToUpper <> "TRUE" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_MEET_NOTMEET"), , , True))
        End If
        If m_strMode.ToUpper = "ALERTSLA" And m_strDisplayDetails.ToUpper <> "TRUE" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_ALERT"), , , True))
        End If
        If m_strMode.ToUpper = "ESCSLA" And m_strDisplayDetails.ToUpper <> "TRUE" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_ESC"), , , True))
        End If
        If m_strMode.ToUpper = "MEETSLA" And m_strDisplayDetails.ToUpper = "TRUE" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_MEET_NOTMEET_DETAILS"), , , True))
        End If
        If m_strMode.ToUpper = "ALERTSLA" And m_strDisplayDetails.ToUpper = "TRUE" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_ALERT_DETAILS"), , , True))
        End If
        If m_strMode.ToUpper = "ESCSLA" And m_strDisplayDetails.ToUpper = "TRUE" Then
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_ESC_DETAILS"), , , True))
        End If



    End Sub
    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set variable values (QueryString and form references)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : VidyaJ
        ' Created               : Sept 23, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drProjectInfo As IDataReader
        'Graph variables
        m_intGraphHeight = 375
        m_intGraphWidth = 600 '492
        m_strTodate = ""
        m_strFromdate = ""
        'get Financial Start And End Dates
        CommonFunction.Dates.GetFromAndToDates("10", m_strFromdate, m_strTodate, "")
        'Set Global object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        UTILIZATION_TAGID = m_objGlobal.TagID

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                m_strMode = Request.QueryString("Mode")
            Else
                m_strMode = ""
            End If
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("DisplayDetails") Is Nothing Then
            If Request.QueryString("DisplayDetails") <> "" Then
                m_strDisplayDetails = Request.QueryString("DisplayDetails")
            Else
                m_strDisplayDetails = ""
            End If
        Else
            m_strDisplayDetails = ""
        End If
        'Move
        If Not Request.QueryString("Move") Is Nothing Then
            If Request.QueryString("Move") <> "" Then
                m_strMove = Request.QueryString("Move")
            Else
                m_strMove = ""
            End If
        Else
            m_strMove = ""
        End If
        '-------------------

        If Session("LoginType") Is "E" Then
            m_strView = Session("LoginType").ToString
            m_strID = CType(Session("intUserID"), String)
        End If

        If Session("LoginType") Is "C" Then
            m_strView = Session("LoginType").ToString
            m_strID = CType(Session("intUserID"), String)
        End If


        If Not Request.QueryString("From") Is Nothing Then
            If Request.QueryString("From") <> "" Then
                If Request.QueryString("From") = "Resource" Then
                    m_strFrom = "Resource"
                End If
            End If
        End If




        'If Not Request.QueryString("View") Is Nothing Then
        '    If Request.QueryString("View") <> "" Then
        '        m_strView = Request.QueryString("View")
        '        m_strID = Request.QueryString("ID")
        '    Else
        '        m_strView = ""
        '    End If
        'Else
        '    m_strView = ""
        'End If



        '-------------------
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select StartingDayofweek from tbl_PM_CompanyInformation", MyBase.UseSQL), "0"))
        m_intStartingDayOfWeek = CInt(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_StartingDayofweek", MyBase.UseSQL), "0"))
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_intStartingDayOfWeek += 1
        If m_intStartingDayOfWeek > 7 Then
            m_intStartingDayOfWeek = 1
        End If
        m_intCurrentDayOfWeek = System.DateTime.Now.DayOfWeek

        'Move
        If Not Request.QueryString("FromDate") Is Nothing Then
            If Request.QueryString("FromDate") <> "" Then
                m_dtStartDateOfWeek = Request.QueryString("FromDate")
                strStartDateOfWeek = CType(m_dtStartDateOfWeek, String)
                m_dtEndDateOfWeek = Request.QueryString("ToDate")
            End If
        End If
        If m_strMove = "PREV" Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, -7, m_dtStartDateOfWeek)
            strStartDateOfWeek = CType(m_dtStartDateOfWeek, String)
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        ElseIf m_strMove = "NEXT" Then
            m_dtStartDateOfWeek = DateAdd(DateInterval.Day, 7, m_dtStartDateOfWeek)
            strStartDateOfWeek = CType(m_dtStartDateOfWeek, String)
            m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
        Else
            If strStartDateOfWeek = "" Then
                m_dtStartDateOfWeek = StartDateOfWeek(m_intCurrentDayOfWeek, m_intStartingDayOfWeek)
                strStartDateOfWeek = CType(m_dtStartDateOfWeek, String)
                m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)
            End If
        End If
    End Sub
    Private Function StartDateOfWeek(ByVal m_intCurrentDayOfWeek As Integer, ByVal m_intStartingDayOfWeek As Integer) As Date
        Dim tempDate As Date
        Dim intWD As Integer = Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday)

        Select Case m_intStartingDayOfWeek
            Case 1
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Sunday) - 1), System.DateTime.Now)
            Case 2
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Monday) - 1), System.DateTime.Now)
            Case 3
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday) - 1), System.DateTime.Now)
            Case 4
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday) - 1), System.DateTime.Now)
            Case 5
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Thursday) - 1), System.DateTime.Now)
            Case 6
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Friday) - 1), System.DateTime.Now)
            Case 7
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Saturday) - 1), System.DateTime.Now)
        End Select
        Return tempDate

    End Function
    Public Sub New()

        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting


        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for the page
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
    'Private Sub objListGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListGrid.DataRowTR_BeforePrint
    '    m_intCount = m_intCount + 1
    '    'Check for Group Value
    '    If m_strMonth <> Args.DataReader("Month").ToString.Trim Then
    '        If m_GroupTotalCapacity >= 0 Then
    '            'Insert sum for the Month
    '            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue>" + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"

    '            ' Modified By NitinVS on 20 July 2005 for WhizibleSEM SP4 
    '            ' The Percentage Is Shown and not average of Percentage 

    '            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacityPer / m_intCount).ToString("N2") + "</FONT></TD>"
    '            If m_GroupInstallCapacity <> 0 Or m_GroupTotalCapacity <> 0 Then
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacity * 100 / m_GroupInstallCapacity).ToString("N2") + "</FONT></TD>"
    '            Else
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '            End If

    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"
    '            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocatedPer / m_intCount).ToString("N2") + "</FONT></TD>"
    '            If m_GroupTotalCapacity <> 0 Or m_GroupTotalAllocated <> 0 Then
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocated * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
    '            Else
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '            End If

    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"
    '            'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActualPer / m_intCount).ToString("N2") + "</FONT></TD>"
    '            If m_GroupTotalCapacity <> 0 Or m_GroupTotalActual <> 0 Then
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActual * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
    '            Else
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '            End If

    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
    '            ' Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillablePer / m_intCount).ToString("N2") + "</FONT></TD></TR>"
    '            If m_GroupTotalCapacity <> 0 Or m_GroupTotalBillable <> 0 Then
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillable * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD></TR>"
    '            Else
    '                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '            End If

    '            ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4 

    '        End If

    '        'Initialize GroupSum to 0 for next group
    '        m_intCount = 0
    '        m_GroupTotalCapacity = 0
    '        m_GroupTotalAllocated = 0
    '        m_GroupTotalActual = 0
    '        m_GroupTotalBillable = 0
    '        m_GroupTotalCapacityPer = 0
    '        m_GroupTotalAllocatedPer = 0
    '        m_GroupTotalActualPer = 0
    '        m_GroupTotalBillablePer = 0
    '        m_GroupInstallCapacity = 0

    '        'reset Month
    '        m_strMonth = Args.DataReader("Month").ToString + ""

    '        'Insert TR which will have group value
    '        Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left' colspan=11>" + Args.DataReader("Month").ToString + "</FONT></TD></TR>"
    '        m_GroupTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
    '        m_GroupTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
    '        m_GroupTotalActual += CType(Args.DataReader("ActualHrs"), Double)
    '        m_GroupTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
    '        m_GroupInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
    '        m_GroupTotalCapacityPer += CType(Args.DataReader("Capacity%"), Double)
    '        m_GroupTotalAllocatedPer += CType(Args.DataReader("Allocated%"), Double)
    '        m_GroupTotalActualPer += CType(Args.DataReader("Actual%"), Double)
    '        m_GroupTotalBillablePer += CType(Args.DataReader("Billable%"), Double)

    '        ' Added By NitinVs on 20 July 2005 for WhizibleSEM SP4 
    '        m_GrandInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
    '        m_GrandTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
    '        m_GrandTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
    '        m_GrandTotalActual += CType(Args.DataReader("ActualHrs"), Double)
    '        m_GrandTotalBillable += CType(Args.DataReader("BillableHrs"), Double)

    '        ' End Addition By NitinVS on 20 July 2005 for whizibleSEM SP4 
    '    Else
    '        'update GroupSum
    '        m_GroupTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
    '        m_GroupTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
    '        m_GroupTotalActual += CType(Args.DataReader("ActualHrs"), Double)
    '        m_GroupTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
    '        m_GroupInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
    '        m_GroupTotalCapacityPer += CType(Args.DataReader("Capacity%"), Double)
    '        m_GroupTotalAllocatedPer += CType(Args.DataReader("Allocated%"), Double)
    '        m_GroupTotalActualPer += CType(Args.DataReader("Actual%"), Double)
    '        m_GroupTotalBillablePer += CType(Args.DataReader("Billable%"), Double)

    '        ' Added By NitinVs on 20 July 2005 for WhizibleSEM SP4 
    '        m_GrandInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
    '        m_GrandTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
    '        m_GrandTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
    '        m_GrandTotalActual += CType(Args.DataReader("ActualHrs"), Double)
    '        m_GrandTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
    '        ' End Addition By NitinVS on 20 July 2005 for whizibleSEM SP4 

    '    End If

    'End Sub

    'Private Sub objListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objListGrid.DataRowTD_BeforePrint
    '    If Args.ColIndex = 0 Then 'if first column(Month)

    '        'Determine stylesheet for row
    '        If Args.NoOfRowsPrinted Mod 2 = 0 Then
    '            'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
    '            Args.StringToBeInserted = "<TR class='clsTREven'><TD align='left'></TD>"
    '        Else
    '            Args.StringToBeInserted = "<TR class='clsTROdd'><TD align='left'></TD>"
    '        End If
    '        Cancel = True
    '    End If
    'End Sub

    'Private Sub objListGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objListGrid.SummaryFunctionsTR_BeforePrint
    '    If m_GroupTotalCapacity >= 0 Then
    '        m_intCount = m_intCount + 1

    '        ' Modified By NitinVS on 20 July 2005 for whizibleSEM SP4 
    '        ' Percentage Is To Be Shown and not Average of Percentage 
    '        'Insert sum for the Month
    '        Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue> " + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
    '        Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
    '        Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"

    '        'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacityPer / m_intCount).ToString("N2") + "</FONT></TD>"
    '        If m_GroupInstallCapacity <> 0 And m_GroupTotalCapacity <> 0 Then
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacity * 100 / m_GroupInstallCapacity).ToString("N2") + "</FONT></TD>"
    '        Else
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '        End If

    '        Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"

    '        'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocatedPer / m_intCount).ToString("N2") + "</FONT></TD>"
    '        If m_GroupTotalCapacity <> 0 And m_GroupTotalAllocated <> 0 Then
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocated * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
    '        Else
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '        End If

    '        Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"

    '        'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActualPer / m_intCount).ToString("N2") + "</FONT></TD>"
    '        If m_GroupTotalCapacity <> 0 And m_GroupTotalActual <> 0 Then
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActual * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD>"
    '        Else
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '        End If

    '        Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
    '        'Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillablePer / m_intCount).ToString("N2") + "</FONT></TD></TR>"
    '        If m_GroupTotalCapacity <> 0 And m_GroupTotalBillable <> 0 Then
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillable * 100 / m_GroupTotalCapacity).ToString("N2") + "</FONT></TD></TR>"
    '        Else
    '            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (0).ToString("N2") + "</FONT></TD>"
    '        End If
    '        ' End Modification By NitinVS on 20 July 2005 for WhizibleSEM SP4  

    '    End If
    'End Sub

    'Private Sub objListGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListGrid.ColumnHeaderTR_BeforePrint
    '    Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=2>&nbsp;</TD>"
    '    Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
    '    'Modified By NitinVs on 20 july 2005 for WhizibleSEM SP4 
    '    ' If Project is selected then show the Booked hrs 
    '    'If m_strProjectID <> "" And m_strProjectID <> "NULL" Then
    '    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BOOKED") + "</TD>"
    '    'Else
    '    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
    '    'End If
    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
    '    ' End Modification By NitinVs on 20 july 2005 for WhizibleSEM SP4  

    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"

    'End Sub

    'Private Sub objListSummaryGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListSummaryGrid.DataRowTR_BeforePrint
    '    ' Added By NitinVs on 20 July 2005 for WhizibleSEM SP4 
    '    m_GrandInstallCapacity += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("InstallCapacityHrs"), "0"), "0"), Double)
    '    m_GrandTotalCapacity += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CapacityHrs"), "0"), "0"), Double)
    '    m_GrandTotalAllocated += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("AllocatedHrs"), "0"), "0"), Double)
    '    m_GrandTotalActual += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ActualHrs"), "0"), "0"), Double)
    '    m_GrandTotalBillable += CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("BillableHrs"), "0"), "0"), Double)

    '    ' End Addition By NitinVS on 20 July 2005 for whizibleSEM SP4 
    'End Sub

    'Private Sub objListSummaryGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListSummaryGrid.ColumnHeaderTR_BeforePrint
    '    Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=1>&nbsp;</TD>"
    '    Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
    '    'Modified By NitinVs on 20 july 2005 for WhizibleSEM SP4 
    '    ' If Project is selected then show the Booked hrs 
    '    'If m_strProjectID <> "" And m_strProjectID <> "NULL" Then
    '    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BOOKED") + "</TD>"
    '    'Else
    '    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
    '    'End If
    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
    '    ' End Modification By NitinVs on 20 july 2005 for WhizibleSEM SP4  

    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
    '    Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"
    'End Sub

    '' Added By NitinVS on 20 July 2005 for WhizibleSEM SP4 
    '' The Percentage is to be shown and not average.
    'Private Sub objListGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objListGrid.SummaryFunctionsTD_BeforePrint
    '    If Args.ColIndex = 0 Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align=right> Grand Total</TD>"
    '    End If

    '    If Args.ColIndex = 4 Then
    '        Cancel = True
    '        If m_GrandInstallCapacity <> 0 And m_GrandTotalCapacity <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalCapacity * 100 / m_GrandInstallCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If

    '    End If


    '    If Args.ColIndex = 6 Then
    '        Cancel = True
    '        If m_GrandTotalCapacity <> 0 And m_GrandTotalAllocated <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalAllocated * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If
    '    End If

    '    If Args.ColIndex = 8 Then
    '        Cancel = True
    '        If m_GrandTotalCapacity <> 0 And m_GrandTotalActual <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalActual * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If
    '    End If

    '    If Args.ColIndex = 10 Then
    '        Cancel = True
    '        If m_GrandTotalCapacity <> 0 And m_GrandTotalBillable <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalBillable * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If
    '    End If

    '    ' End Addition By  NitinVS on 20 July 2005 for WhizibleSEM SP4 

    'End Sub
    '' Added By NitinVS on 20 July 2005 for WhizibleSEM SP4 
    '' The Percentage is to be shown and not average.
    'Private Sub objListSummaryGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles objListSummaryGrid.SummaryFunctionsTD_BeforePrint
    '    If Args.ColIndex = 0 Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align=right> Grand Total</TD>"
    '    End If
    '    If Args.ColIndex = 3 Then
    '        Cancel = True
    '        If m_GrandInstallCapacity <> 0 And m_GrandTotalCapacity <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalCapacity * 100 / m_GrandInstallCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If

    '    End If


    '    If Args.ColIndex = 5 Then
    '        Cancel = True
    '        If m_GrandInstallCapacity <> 0 And m_GrandTotalAllocated <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalAllocated * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If
    '    End If

    '    If Args.ColIndex = 7 Then
    '        Cancel = True
    '        If m_GrandInstallCapacity <> 0 And m_GrandTotalActual <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalActual * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If
    '    End If

    '    If Args.ColIndex = 9 Then
    '        Cancel = True
    '        If m_GrandInstallCapacity <> 0 And m_GrandTotalBillable <> 0 Then
    '            Args.StringToBeInserted = "<TD align=right> " + (m_GrandTotalBillable * 100 / m_GrandTotalCapacity).ToString("N2") + "</TD>"
    '        Else
    '            Args.StringToBeInserted = "<TD align=right> " + (0).ToString("N2") + "</TD>"
    '        End If
    '    End If

    '    ' End Addition By  NitinVS on 20 July 2005 for WhizibleSEM SP4 
    'End Sub
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
    End Sub
End Class
