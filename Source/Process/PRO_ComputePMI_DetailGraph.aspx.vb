Public Class PRO_ComputePMI_DetailGraph
    Inherits WebPages.Template.WhizTemplate
    '=====================================================================
    ' Page Name             : PRO_ComputePMI_DetailGraph
    ' Purpose               : Called from PRO_ComputePMI.aspx page. Displays the Details of Selected
    ' Description           : metric OR the Graph.. depending upon 
    ' Parameters Passed     : 
    ' Assumptions           : AppResources.PRO_ComputePMI.resx Resource file exists
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js
    ' Author                : SuryabirD
    ' Created               : Mar 8th, 2004
    '=====================================================================
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
    Private m_blnValidate As Boolean = True
    Protected m_strPageTitle, m_strSigma As String
    Private m_lngPMIID, m_lngMetricID As Long
    Private m_intGraphWidth, m_intGraphHeight As Integer
    Private m_PKToken_Request_Multiple As String
    Private Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here


        ' ''commented by nilesh g on 31/12/2015 for Security
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''end of commented by nilesh g on 31/12/2015 for Security

        'm_PKToken_Request_Multiple = Request.QueryString("PKToken").ToString()
        ' ''Added And Commented by Sanyogeeta R on 12-Aug-2016 to validate Token
        If (Request.QueryString("PKToken") = "" And HttpContext.Current.Session("intUserID") <> 0) Then
            m_blnValidate = False
        ElseIf Request.QueryString("PMIID") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("METRICID") <> "" Then
            ' If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PMIID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(Request.QueryString("METRICID"), String), Request.QueryString("PKToken")) = False) Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("PMIID"), String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String) + CType(Request.QueryString("METRICID"), String), Request.QueryString("PKToken")) = False) Then

                m_blnValidate = False
            End If
        End If

        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If

        ' ''Added by Yogesh J on 10-Feb-2016 to validate Token
        'If Request.QueryString("PMIID") <> "" And Request.QueryString("PKToken") <> "" And Request.QueryString("METRICID") <> "" Then
        '    If Request.QueryString("FromWhere") = "PRO" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("PMIID"), String) + CType(Request.QueryString("METRICID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Show Graph", 0, 0, "METRICID", CType(Request.QueryString("METRICID"), String))
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If

        '    End If
        'End If
        ' ''End of addition by Yogesh J on on 10-Feb-2016 to validate Token

        ' ''End Added And Commented by Sanyogeeta R on 12-Aug-2016 to validate Token
        m_lngPMIID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("PMIID"), "0"), Long)
        m_strSigma = CommonFunctions.General.CheckIsNothing(Request.QueryString("SIGMA"), "0")
        m_lngMetricID = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("METRICID"), "0"), Long)

        m_intGraphWidth = 600
        m_intGraphHeight = 400

        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

    End Sub

    Protected Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Main fn. called from within the Form Tag to plot Controls on the page
        ' Parameters Passed     : 
        ' Returns               : None
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 10,2004   
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String
        Dim strMetricName As String
        Dim drMetric As IDataReader

        '-- Display Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<BR>")

        '-- Get the Name of the Metric
        drMetric = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PRS_MetricMaster " + m_lngMetricID.ToString, MyBase.UseSQL)
        If drMetric.Read Then
            strMetricName = drMetric("Name").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drMetric)

        '-- Display Caption
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("METRIC") + strMetricName, , , True))
        Response.Write("<BR>")

        Response.Write("<DIV ID='DivList' Style='WIDTH:100%;OVERFLOW:auto;'>")

        '-- Call Fn. to Generate the Graph
        Call MetricDetails_Graph(strMetricName)

        Response.Write("</DIV>")

        Response.Write("<BR>" + strMenu)

    End Sub


    Private Sub MetricDetails_Graph(ByVal strMetricName As String)
        '=====================================================================
        ' Procedure Name        : MetricDetails_Graph
        ' Purpose               : Plots the Graph for the Passed Metric
        ' Description           : 
        ' Parameters Passed     : strMetricName - Metric Name
        ' Returns               : None
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Mar 10,2004   
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery, strQuery As String
        Dim strFileName, strUnit As String
        Dim objTemp As Object
        Dim drPMINames As IDataReader
        Dim dblUCL, dblLCL As Double

        strQuery = "Exec usp_Sel_PRS_GetMetricListOfPMI " + m_lngPMIID.ToString + "," + m_lngMetricID.ToString + ",'EDT'"
        drPMINames = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If drPMINames.Read Then
            dblUCL = CType(CommonFunctions.Data.CheckIsDBNull(drPMINames("Maximum"), "0"), Double)
            dblLCL = CType(CommonFunctions.Data.CheckIsDBNull(drPMINames("Minimum"), "0"), Double)
            strUnit = drPMINames("UnitName").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(drPMINames)

        strSQLQuery = "Exec usp_Sel_PDB_MetricActualValues_Graph " + m_lngPMIID.ToString + "," + m_lngMetricID.ToString
        strFileName = "MetricValues"

        Call CreateGraph(strSQLQuery, "SPLINE", strFileName, MyBase.GetResourceString("PMI_METRIC") + "(" + strMetricName + ")", 2, dblUCL, dblLCL, strUnit)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE class=clsTable Width=99.9% cellspacing =0><TR class=clsTREven width =100%><TD >")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        '-- Now Display Graph Image
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY + strFileName + ".png")) Then
            Response.Write("<IMG HEIGHT=" + m_intGraphHeight.ToString + " WIDTH=" + m_intGraphWidth.ToString + " src='" + GRAPH_DIRECTORY + strFileName + ".png" + "'>")
        Else
            Response.Write("<IMG src='..\..\images\NoPreview.gif'>")
        End If

        Response.Write("</TD></TR></TABLE>")
    End Sub

    Private Sub CreateGraph(ByVal strSQLQueryForGraph As String, ByVal strChartType As String, ByVal strImageFileName As String, ByVal strGraphTitle As String, ByVal intNoOfColumns As Integer, ByVal dblUCL As Double, ByVal dblLCL As Double, ByVal strUnit As String)
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuryabirD
        ' Created               : Noveber 07,2003
        ' Revisions             : 
        '=====================================================================
        Dim objGraph As Graph.Graph

        Dim strItemName As String = ""
        Dim lngEntityID As Long = 0
        Dim arrstrChartType() As String = {}
        Dim strVirtualImgPath, strPalleteStyle As String

        Dim i As Integer
        '-- Setting some main Graph Properties

        '-- Build Array for specifying the Chart Type for each column
        ReDim arrstrChartType(intNoOfColumns - 1)
        For i = 0 To intNoOfColumns - 1
            arrstrChartType(i) = strChartType
        Next

        ' create the graph for the item values
        objGraph = New Graph.Graph
        With objGraph
            strVirtualImgPath = GRAPH_DIRECTORY + strImageFileName
            .VirtualImagePath = strVirtualImgPath
            .AbsoluteImagePath = Server.MapPath(strVirtualImgPath)
            .ConnectionString = CommonFunction.Application.ConnectionString
            .Nomenclature = "Actual Value in " + strUnit
            .VirtualImagePath = ""
            .Enable3D = False
            .ChartType = arrstrChartType 'GetChartType(ItemID, SQL, m_intGraphID, m_blnUseSQL)
            .BorderStyle = "FrameTitle5"
            .GraphTitle = strGraphTitle
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .GraphTitleColor = "white"
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .ShowExplodedPie = False
            .ChartBackColor = "PaleGoldenRod"
            .ChartAreaColor = "GoldenRod"
            .PalleteStyle = "EARTHTONES"
            .LCL = CType(dblLCL, Long)
            .UCL = CType(dblUCL, Long)

            'Integrated by MrugajaB on 29th July 2005 for WhizibleSEM sp4 Issue ID.92 (Graphs not generating properly )
            ' Code Added By PradipK On 12 July 2005
            'Purpose To Solve Issue 19536 
            'To Display  UCL and LCL in Different Color in Graph.
            .UCLColor = "black"
            .LCLColor = "Blue"
            'End Addition By Pradipk on 12 July 2005

            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            .LegendCaptionColor = "black"
            .BorderColor = "Blue"
            .ShowLegends = True
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .SQL = strSQLQueryForGraph
            .EnableSmartLabels = True
            .ShowCaptions = False

            ' return the graph control
            .GenerateImage()
        End With

        objGraph = Nothing
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
        ' Author                : SuryabirD
        ' Created               : Jan 28,2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('1052')"}
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim strMenu As String = objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.PRO_ComputePMI_DetailGraph", "AppResources")
        objMenu = Nothing

        Return strMenu

    End Function


    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'initialize the resource file for PRO_ProjectTypeConfiguration page.
        MyBase.InitializeResources("AppResources.PRO_ComputePMI_DetailGraph", "AppResources")
    End Sub
End Class
