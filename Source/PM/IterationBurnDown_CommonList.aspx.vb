Imports CommonEngines.General.cEventHandlers
Public Class IterationBurnDown_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "IterationBurnDown_CommonList.aspx"
        MyBase.strFormPage = "IterationBurnDown_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Private m_strSessionProjectID As String
    Private m_IterationID As String
    Private m_Type As String
    'Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' graph location
    'Private m_intGraphHeight As Integer     ' graph Height    
    'Private m_intGraphWidth As Integer      '  graph width
    'Protected m_strXAxisTitle As String
    'Protected m_strImageFileName As String
    'Protected m_strGraphTitle As String
    'Protected m_strGraphSQL As String
    'Protected m_strGraphType As String
    'Protected m_strConnString As String
    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strHtml As String
        m_strSessionProjectID = CType(Session("intProjectID"), String)
        If Not Request.QueryString("IterationID") Is Nothing Then
            m_IterationID = Request.QueryString("IterationID").ToString
        Else
            m_IterationID = ""
        End If
        If Not Request.QueryString("Type") Is Nothing Then
            m_Type = Request.QueryString("Type").ToString
        Else
            m_Type = ""
        End If
        strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
        strHtml += "<tr class=clsTREven><td align=center width=50%><b>Iteration </b>"

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strHtml += CommonFunction.HTMLControls.DrawComboBox("cboIteration", "select IterationID,IterationName from tbl_PM_Scrumiteration where ProjectID=" + m_strSessionProjectID.ToString + " order by IterationName", 170, CommonFunctions.General.CheckIsNothing(CType(m_IterationID, String), ""), "onchange=javascript:ShowReport()", True, True)
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboIteration", "usp_sel_tbl_PM_Scrumiteration_IterationID_IterationName " + m_strSessionProjectID.ToString, 170, CommonFunctions.General.CheckIsNothing(CType(m_IterationID, String), ""), "onchange=javascript:ShowReport()", True, True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strHtml += "</td>"
        strHtml += "<td align=left width=50%><b>Graph Type </b>"

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strHtml += CommonFunction.HTMLControls.DrawComboBox("cboGraphtype", "select '1','Line' UNION select '2','Column'", 70, CommonFunctions.General.CheckIsNothing(CType(m_Type, String), ""), "onchange=javascript:ShowReport()", True, True)
        strHtml += CommonFunction.HTMLControls.DrawComboBox("cboGraphtype", "usp_sel_cboGraphtype", 70, CommonFunctions.General.CheckIsNothing(CType(m_Type, String), ""), "onchange=javascript:ShowReport()", True, True)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        strHtml += "</td>"
        strHtml += "</tr>"
        strHtml += "</table><br>"
        CommonFunction.General.WriteHTML(strHtml)
    End Sub
    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Cancel = True
    End Sub
    Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        If Request.QueryString("IterationID") = "" And Request.QueryString("Type") = "" Then
            If Args.GraphTitle = "Iteration Burn Down Column Graph" Or Args.GraphTitle = "Iteration Burn Down Line Graph" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("IterationID") Is Nothing And Request.QueryString("Type") = "1" Then
            'Call Plotgraph("Usp_Sel_ReleaseBurnDown " + Request.QueryString("IterationID").ToString + ",'Iteration'")
            If Args.GraphTitle = "Iteration Burn Down Line Graph" Then
                Args.SQL = "Usp_Sel_ReleaseBurnDown " + Request.QueryString("IterationID").ToString + ",'Iteration'"
            ElseIf Args.GraphTitle = "Iteration Burn Down Column Graph" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("IterationID") Is Nothing And Request.QueryString("Type") = "2" Then
            If Args.GraphTitle = "Iteration Burn Down Column Graph" Then
                Args.SQL = "Usp_Sel_ReleaseBurnDown " + Request.QueryString("IterationID").ToString + ",'Iteration'"
            ElseIf Args.GraphTitle = "Iteration Burn Down Line Graph" Then
                Cancel = True
            End If
        End If
        If Not Request.QueryString("IterationID") Is Nothing And Request.QueryString("Type") = "" Then
            If Args.GraphTitle = "Iteration Burn Down Column Graph" Then
                Args.SQL = "Usp_Sel_ReleaseBurnDown " + Request.QueryString("IterationID").ToString + ",'Iteration'"
            ElseIf Args.GraphTitle = "Iteration Burn Down Line Graph" Then
                Cancel = True
            End If
        End If
    End Sub
    'Private Sub Plotgraph(ByVal query)

    '    Dim objGraph As Graph.Graph
    '    Dim blnShowLegends As Boolean = False
    '    Dim blnShowCaptions As Boolean = True
    '    Dim blnShowExplodedPie As Boolean = False
    '    Dim blnEnable3D As Boolean = False
    '    Dim lngEntityID As Long = 0
    '    Dim strNomenclature As String = ""
    '    Dim arrstrChartType() As String = {}
    '    Dim strVirtualImgPath As String
    '    Dim arr(3) As String
    '    Dim arrLegandcolor() As String = {"", "Green", "DarkMagenta"}

    '    m_strGraphSQL = query

    '    Try
    '        m_strImageFileName = "ErrorDistributionDP_" + CommonFunction.FileDirectory.GetUniqueFileName()
    '        blnShowLegends = True
    '        blnShowCaptions = True
    '        objGraph = New Graph.Graph
    '        With objGraph
    '            strVirtualImgPath = GRAPH_DIRECTORY + m_strImageFileName

    '            'strImageFileName
    '            .VirtualImagePath = strVirtualImgPath
    '            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
    '            '.ConnectionString = CommonFunction.Application.ConnectionString
    '            .ConnectionString = m_strConnString
    '            ' .VirtualImagePath = ""
    '            .Enable3D = False
    '            'When Graph Type Is Column /  bar
    '            arr(0) = "COLUMN"
    '            arr(1) = "COLUMN"
    '            arr(2) = "COLUMN"
    '            arr(3) = "COLUMN"

    '            .LegendColor = arrLegandcolor
    '            .ChartType = arr

    '            .GraphTitleColor = "black"
    '            .ChartBackColor = "Silver"
    '            .ChartAreaColor = "Snow"
    '            .BorderStyle = "Embossed Frame"
    '            .ShowLegends = True
    '            .XAxisTitle = "Phases"

    '            .Nomenclature = "Errors"
    '            .LegendCaptionColor = "black"
    '            .PalleteStyle = "EARTHTONES"
    '            .EnableXAxis = True
    '            .EnableYAxis = True
    '            .EnableSmartLabels = False
    '            .ShowCaptions = False
    '            .GraphTitleColor = "Black"
    '            .ShowDataColumnNameAsXAxisTitle = False
    '            '-- Fixed Settings
    '            .GraphTitle = "Iteration Burn Down"
    '            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
    '            .Height = 350
    '            .Width = 700
    '            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
    '            .SQL = m_strGraphSQL
    '            .BorderGradientColor = "WHITE"
    '            .BorderGradientStyle = "TOPBOTTOM"
    '            .ChartBackGradientColor = "WHITE"
    '            .ChartBackGradientStyle = "TOPBOTTOM"
    '            .ChartAreaGradientColor = "WHITE"
    '            .ChartAreaGradientStyle = "TOPBOTTOM"
    '            .LegendDocking = "RIGHT"
    '            .LegendStyle = "COLUMN"
    '            .ChartAreaWidth = 98 ''original value:100
    '            .ChartAreaHeight = 75
    '            .XAxisInterval = 1

    '            ' return the graph image
    '            .GenerateImage()
    '        End With
    '        ' return the graph image
    '        '-- Display Graph
    '        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY) & m_strImageFileName & ".png") Then
    '            'Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY & m_strImageFileName & ".png" & "'>")
    '            Response.Write("<IMG HEIGHT=350  WIDTH=700 " & " src='" + GRAPH_DIRECTORY & m_strImageFileName & ".png" & "'>")
    '        Else
    '            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
    '        End If
    '    Catch EX As Exception
    '        Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
    '    End Try

    'End Sub
End Class
