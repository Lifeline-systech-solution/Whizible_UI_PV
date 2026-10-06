Public Class ProjectProfitabilityGraphs
    Inherits WebPage.Templates.WhizTemplate

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

    Private m_intGraphHeight As Integer = 375
    Private m_intGraphWidth As Integer = 750
    Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    Private m_dsGraphs As System.Data.DataSet
    Public Const GRAPH_DIRECTORY As String = "../../images/ProjectProfitability/"  ' graph location
    Private m_intAttributeID As Integer = 1
    Private m_intAttributeValue As Integer
    Private m_intAttributeGraph1 As Long
    Protected m_ProjectID As String = "0"
    Protected m_ProjectName As String = ""
    Protected m_ProjectStartDate As String = ""
    Protected m_ProjectEndDate As String = ""
    Protected m_ProjectActualStartDate As String = ""
    Protected m_projectActualEndDate As String = ""
    Protected m_ProjectValue As String = "0"
    Protected m_CurrencySymbol As String = ""
    Protected m_FromDate As String = ""
    Protected m_ToDate As String = ""
    Protected m_strGraphType1 As String = ""
    Protected m_strMenu As String = ""

    Protected m_strFromPeriod As String = ""
    Protected m_strToPeriod As String = ""

    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected m_strCommercialType As String = ""
    Protected m_strCostMethod As String = ""
    Private Structure GraphCaption
        Dim GraphCaption As String
        Dim LeftCaption As String
        Dim XaxisCaption As String
    End Structure
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Public Sub PageInit()
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        Dim intRowCount As Integer = 0
        Dim strSQL As String = ""
        Dim row As HtmlTableRow
        Dim cell As HtmlTableCell
        Dim strLabels As String = ""
        Dim strTitle As String = ""
        Dim strMenu As String = ""
        Dim blnRestrictView As Boolean = False
        Dim blnRestrictEdit As Boolean = False
        Dim FilterTable As New System.Web.UI.HtmlControls.HtmlTable
        Dim strGraphType() As String = {"SPLINE", "LINE", "COLUMN", "POINT"}
        Dim intGraphCount As Integer

        Init_Variables()
        Dim Graphcount As Integer = 0
        Dim strctGraphDetails As New GraphCaption
        m_strMenu = InitializeMenu()
        CommonFunctions.General.WriteHTML(m_strMenu)


        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Project Profitability", "(All figures in :" + m_CurrencySymbol + ")", , True))
        CommonFunctions.General.WriteHTML("<br>")

        ' Draw the Project Details. 
        DrawProjectDetails()

        CommonFunctions.General.WriteHTML("<br>")
        Dim strLeftSectionTitle As String = ""

        For Each table As DataTable In m_dsGraphs.Tables
            Graphcount += 1
            strctGraphDetails = GetGraphDetails(3, 1)

            With tblGraphs
                row = New HtmlTableRow
                .Rows.Add(row)
                cell = New HtmlTableCell
                cell.Attributes.Add("width", "100%")
                cell.Attributes.Add("colspan", "2")
                cell.Attributes.Add("align", "left")
                cell.Attributes.Add("Valign", "Top")
                cell.InnerHtml = "<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'><TR class='clsTRPageCaption'><td colspan='6'><b>" + strctGraphDetails.GraphCaption + "</b></td>"
                'cell.InnerHtml = cell.InnerHtml + "<TR class='clsTREven'><TD align='right'>Attribute Value</TD><TD align='left'>&nbsp;" & CommonFunctions.HTMLControls.DrawComboBox("cboAttributeValue", "usp_Sel_NormalizationCompensationAttributeValue " & CStr(m_intAttributeID), 200, m_intAttributeValue, " onchange=javascript:Filter_OnChange(5) ", True, True) & "</TD>"
                'cell.InnerHtml = cell.InnerHtml + "<TD align='right'>Attribute Value Type</TD><TD align='left'>&nbsp;" & CommonFunctions.HTMLControls.DrawComboBox("cboAttributeGraph1", "usp_Sel_NormalizationCompensationAttributeGraph1 " & CStr(m_intAttributeID), 200, m_intAttributeGraph1, " onchange=javascript:Filter_OnChange(6) ", , True) & "</TD>"
                cell.InnerHtml = cell.InnerHtml + "<TD align='right'>Graph Type</TD><TD align='left'>&nbsp;" & CommonFunctions.HTMLControls.DrawComboBox("cboGraphType" + Graphcount.ToString(), "usp_SEL_GraphType ", 200, m_strGraphType1, " onchange=javascript:GraphOnChange(this," + Graphcount.ToString() + ") ", , True) & "</TD></TR></TABLE><BR>"
                row.Cells.Add(cell)
                row = New HtmlTableRow
                .Rows.Add(row)

                For intGraphCount = 0 To strGraphType.Length() - 1
                    cell = New HtmlTableCell
                    cell.Attributes.Add("width", "100%")
                    cell.Attributes.Add("colspan", "2")
                    cell.Attributes.Add("align", "center")
                    cell.Attributes.Add("Valign", "middle")
                    cell.Attributes.Add("id", "Graph" & Graphcount.ToString() & strGraphType(intGraphCount))
                    If intGraphCount <> 0 Then
                        cell.Attributes.Add("style", "display:none")
                    End If
                    cell.Controls.Add(plotGraph(Graphcount, strGraphType(intGraphCount), strctGraphDetails))
                    row.Cells.Add(cell)
                Next

            End With

        Next
        tblGraphs.Attributes.Add("Style", "")


        m_dsGraphs.Dispose()
        m_dsGraphs = Nothing

    End Sub
    Private Sub DrawProjectDetails()
        ' Draw the Project Details. 
        CommonFunction.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding='1' style='width:99.99%' >")

        ' Project Name 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Project Name :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectName)
        CommonFunction.General.WriteHTML("</td>")
        'CommonFunction.General.WriteHTML("</tr>")

        ' Project Start Date 
        'CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Project Value :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_CurrencySymbol)
        CommonFunction.General.WriteHTML(" ")
        CommonFunction.General.WriteHTML(FormatNumber(m_ProjectValue, 2))
        
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Commercial Type :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_strCommercialType)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")

        ' Project Start Date 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Start Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectStartDate)
        CommonFunction.General.WriteHTML("</td>")

        ' Project Start Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("End Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectEndDate)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Cost Method :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_strCostMethod)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")

        ' Project Actual Start Date 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Actual Start Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectActualStartDate)
        CommonFunction.General.WriteHTML("</td>")

        ' Project Actual End Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Actual End Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' colspan='3'>&nbsp;")
        CommonFunction.General.WriteHTML(m_projectActualEndDate)
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        ' Reporting Start Date 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Reporting From :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("fltFromDate", "fltFromDate", , , m_FromDate, , "frmProjectProfit", Returnhtml:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboFromPeriod", "usp_Sel_ProjectProfitability_Periods " + m_ProjectID + ",'F'", 150, m_strFromPeriod, "onchange='javascript:showData()'", True, True))
        CommonFunction.General.WriteHTML("</td>")

        ' Reporting End Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Reporting To :")
        CommonFunction.General.WriteHTML("&nbsp;")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' colspan='3'>&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboToPeriod", "usp_Sel_ProjectProfitability_Periods " + m_ProjectID + ",'T'", 150, m_strToPeriod, "onchange='javascript:showData()'", True, True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("fltToDate", "fltToDate", , , m_ToDate, , "frmProjectProfit", Returnhtml:=True))
        'CommonFunction.General.WriteHTML("&nbsp;<input type='button' onclick=""showData()"" value=""Show"">")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("</table>")

    End Sub
    Private Sub Init_Variables()
        Dim objDr As IDataReader
        'Commented And Added By Usha Pandit On 05.01.2020 For crash if project is not in session
        'm_ProjectID = HttpContext.Current.Session("intProjectID").ToString()
        m_ProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString()
        'End Of Added By Usha Pandit On 05.01.2020 For crash if project is not in session
        m_strFromPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboFromPeriod"))
        m_strToPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboToPeriod"))

        m_strCostMethod = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Corporate_CostMethod", MyBase.UseSQL)))

        objDr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_TaskCaseStructure " + m_ProjectID, MyBase.UseSQL)

        If objDr.Read Then
            m_ProjectName = CommonFunction.Data.CheckIsDBNull(objDr("ProjectName"), "").ToString()
            m_ProjectStartDate = objDr("ExpectedStartDate").ToString.Format("dd-MMM-yyyy")
            m_ProjectEndDate = objDr("ExpectedEndDate").ToString.Format("dd-MMM-yyyy")
            m_ProjectValue = CommonFunction.Data.CheckIsDBNull(objDr("ContractValue"), "0").ToString()

            m_strCommercialType = CType(CommonFunction.Data.CheckIsDBNull(objDr("NodeLabel"), "0"), String)

            m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(objDr("CurrencySymbol"), "").ToString()
            If m_CurrencySymbol = "" Then
                m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_SEL_Tbl_PM_Compnayinformation_Currency", MyBase.UseSQL), "").ToString()
            End If

            If Not IsNothing(objDr("ExpectedStartDate")) = True Then
                m_ProjectStartDate = CommonFunction.Dates.CGetDate(CType(objDr("ExpectedStartDate"), Date))
            Else
                m_ProjectStartDate = ""
            End If

            If Not IsNothing(objDr("ExpectedEndDate")) = True Then
                m_ProjectEndDate = CommonFunction.Dates.CGetDate(CType(objDr("ExpectedEndDate"), Date))
            Else
                m_ProjectEndDate = ""
            End If

            If Not IsDBNull(objDr("ActualStartDate")) = True Then
                m_ProjectActualStartDate = CommonFunction.Dates.CGetDate(CType(objDr("ActualStartDate"), Date))
            Else
                m_ProjectActualStartDate = ""
            End If

            If Not IsDBNull(objDr("ActualEndDate")) = True Then
                m_projectActualEndDate = CommonFunction.Dates.CGetDate(CType(objDr("ActualEndDate"), Date))
            Else
                m_projectActualEndDate = ""
            End If

        End If

        CommonFunction.Data.DisposeDataReader(objDr)

        'If Not IsNothing(HttpContext.Current.Request.Form("fltFromDate")) = True Then
        If m_strFromPeriod <> "" Then
            m_FromDate = CommonFunctions.Dates.GetDate(CType(m_strFromPeriod, Date))
        Else
            m_FromDate = ""
        End If
        'Else
        'm_FromDate = ""
        'End If

        'If Not IsNothing(HttpContext.Current.Request.Form("fltToDate")) = True Then
        '    If HttpContext.Current.Request.Form("fltToDate").ToString() <> "" Then
        '        m_ToDate = CommonFunctions.Dates.GetDate(CType(HttpContext.Current.Request.Form("fltToDate"), Date))
        '    Else
        '        m_ToDate = ""
        '    End If

        'Else
        '    m_ToDate = ""
        'End If
        If m_strToPeriod <> "" Then
            m_ToDate = CommonFunctions.Dates.GetDate(CType(m_strToPeriod, Date))
        Else
            m_ToDate = ""
        End If

        m_dsGraphs = CommonFunctions.Data.GetDataSet("USP_SEL_ProjectProfitabilityTrends " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString() + ",3", "Trends", , , MyBase.UseSQL)

    End Sub
    Private Function plotGraph(ByVal intTableID As Integer, ByVal strGraphType As String, ByVal GraphDetails As GraphCaption) As Dundas.Charting.WebControl.Chart
        '=====================================================================
        ' Procedure Name        : plotGraph()	
        ' Purpose               : to Generate  Graph
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 14-April-2008
        ' Revisions             :
        '=====================================================================

        Dim objGraph As Graph.Graph
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
        Dim arrColor(5) As String
        Dim dsGraph As New System.Data.DataSet("Graph")
        Dim ddChart As New Dundas.Charting.WebControl.Chart
        Dim strctGraphDetails As New GraphCaption

        arrColor(0) = "red"
        arrColor(1) = "red"
        arrColor(2) = "green"
        arrColor(3) = "orange"
        arrColor(4) = "black"

        strctGraphDetails = GraphDetails
        dsGraph.Tables.Add(m_dsGraphs.Tables(intTableID - 1).Copy())
        strImageFileName = "ProjectProfitability_" + CommonFunction.FileDirectory.GetUniqueFileName()
        blnShowLegends = True
        strNomenclature = "Project Profitability"
        blnShowCaptions = True
        ' create the graph for the item values
        objGraph = New Graph.Graph


        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .Enable3D = False
            arr(0) = strGraphType.ToUpper
            arr(1) = strGraphType.ToUpper
            arr(2) = strGraphType.ToUpper
            arr(3) = strGraphType.ToUpper
            .ChartType = arr
            .GraphTitleColor = "black"
            .ChartBackColor = "Bisque"
            .ChartAreaColor = "FloralWhite"
            .ShowLegends = True
            .XAxisTitle = strctGraphDetails.XaxisCaption
            .Nomenclature = strctGraphDetails.LeftCaption
            .LegendDocking = "bottom"
            .LegendStyle = "column"
            .LegendCaptionColor = "black"
            .PalleteStyle = "EARTHTONES"
            .EnableXAxis = True
            .EnableYAxis = True
            .EnableXAxisMinorGrid = False
            .EnableYAxisMinorGrid = False

            .EnableSmartLabels = False
            .ShowCaptions = False
            .GraphTitleColor = "black"
            .ShowDataColumnNameAsXAxisTitle = False
            '-- Fixed Settings
            .GraphTitle = strctGraphDetails.GraphCaption
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)

            .DataSet = dsGraph

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
            .XAxisTitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .XAxisLabelStyle = 2

            '.MapAreaHREF = "javascript:ShowGraphDetails(" & intTableID.ToString & ")"

            '.DrillDownClientSideFunctionName = "ShowGraphDetails(" & intTableID.ToString & ","

            .ChartAreaWidth = 95

            ddChart = .GenerateChartControl

        End With

        dsGraph.Dispose()
        dsGraph = Nothing
        Return ddChart

    End Function

    Private Function GetGraphDetails(ByVal intAttributeID As Integer, ByVal intGraphOrder As Integer) As GraphCaption

        '=====================================================================
        ' Procedure Name        : GetGraphDetails()	
        ' Purpose               : to get graph details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 14-April-2008
        ' Revisions             :
        '=====================================================================
        Dim strGraphTitle As String = ""
        Dim strGraphName As String = ""
        If intAttributeID = 1 Then
            strGraphTitle = "Cost Trend"
            strGraphName = "As On"
        End If

        If intAttributeID = 2 Then
            strGraphTitle = "Revenue Trend"
            strGraphName = "As On"
        End If

        If intAttributeID = 3 Then
            strGraphTitle = "GPM Trend"
            strGraphName = "As On"
        End If

        Dim arrStrFirstGraph(,) As String = {{strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}}

        Dim arrStrSecondGraph(,) As String = {{strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}}

        Dim arrStrThirdGraph(,) As String = {{strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}, {strGraphTitle, strGraphName, "Amount"}}

        Dim strctGraph As New GraphCaption
        Select Case intGraphOrder
            Case 1
                strctGraph.GraphCaption = arrStrFirstGraph(intAttributeID - 1, 0)
                strctGraph.XaxisCaption = arrStrFirstGraph(intAttributeID - 1, 1)
                strctGraph.LeftCaption = arrStrFirstGraph(intAttributeID - 1, 2)
            Case 2
                strctGraph.GraphCaption = arrStrSecondGraph(intAttributeID - 1, 0)
                strctGraph.XaxisCaption = arrStrSecondGraph(intAttributeID - 1, 1)
                strctGraph.LeftCaption = arrStrSecondGraph(intAttributeID - 1, 2)
            Case Else
                strctGraph.GraphCaption = arrStrThirdGraph(intAttributeID - 1, 0)
                strctGraph.XaxisCaption = arrStrThirdGraph(intAttributeID - 1, 1)
                strctGraph.LeftCaption = arrStrThirdGraph(intAttributeID - 1, 2)
        End Select

        Return strctGraph
    End Function


    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""

        ArrMenuCaptionsList.Add("?")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("OpenHelpPage('3943')")

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing
        Return strMenu
    End Function

End Class

