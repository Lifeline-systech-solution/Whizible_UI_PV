Public Class PM_ResourceUtilizationReport
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
    Dim m_strMode As String                             ' indicates mode of page 'GenerateReport' or ' 
    Dim m_strSessionUserID As String                    ' to store session user id
    'Private m_strResourcePageCaption As String = MyBase.GetResourceString("GRAPHTITLE") 'to store page caption
    Public Const GRAPH_DIRECTORY As String = "../../images/DB_Graphs/"  ' graph location
    Private m_intGraphHeight As Integer                 ' graph Height    
    Private m_intGraphWidth As Integer                  '  graph width
    Private WithEvents objListGrid As New WebPage.Templates.GenericGrid
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

    Private Const UTILIZATION_TAGID As Integer = 2221







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
        MyBase.InitializeResources("AppResources.PM_ResourceUtilizationReport", "AppResources")


        'If Not IsPostBack() Then
        Call GeneratePageCaption()
        Call GeneratePageHeader()
        'End If

        Call DisplayPageDetails()

        Response.Write(GenerateMenu())


    End Sub


    Private Sub GenerateReportGraph()
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
        Dim arr(8) As String
        Dim i As Integer
        Dim strQuery As String

        ' Initialize Resource Utilization Report SP
        strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + ",'" + m_strFromdate + "','" + m_strTodate + "'"


        strImageFileName = "ResUtil" + m_strSessionUserID
        blnShowLegends = True
        strNomenclature = "ResourceUtilization"
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
            arr(0) = "COLUMN"
            arr(1) = "COLUMN"
            arr(2) = "COLUMN"
            arr(3) = "COLUMN"
            arr(4) = "COLUMN"
            arr(5) = "COLUMN"
            arr(6) = "LINE"
            arr(7) = "LINE"
            arr(8) = "LINE"
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

            ' return the graph image
            .GenerateImage()
        End With


        '-- Display Graph
        If CommonFunctions.FileDirectory.IsFileExists(Server.MapPath(GRAPH_DIRECTORY & "ResUtil") & m_strSessionUserID & ".png") Then
            Response.Write("<IMG HEIGHT=" & m_intGraphHeight & " WIDTH=" & m_intGraphWidth & " src='" + GRAPH_DIRECTORY + "ResUtil" & m_strSessionUserID & ".png" & "'>")
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
        MyBase.InitializeResources("AppResources.PM_ResourceUtilizationReport", "AppResources")
        If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" Then
            'Generate Report
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_GENERATEREPORT_TOOLTIP"))
            ArrTopMenuFunctionsList.Add("GenerateReport()")
        Else
            'Initialize resource file 
            If m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" Then

                MyBase.InitializeResources("AppResources.PM_ResourceUtilizationReport", "AppResources")
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMARYDETAILS"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYSUMMAYDETAILS_TOOLTIP"))
                ArrTopMenuFunctionsList.Add(" DisplaySummaryDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")

                MyBase.InitializeResources("AppResources.PM_ResourceUtilizationReport", "AppResources")
                ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS"))
                ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DISPLAYDETAILS_TOOLTIP"))
                ArrTopMenuFunctionsList.Add(" DisplayDetails_OnClink('" + m_strBUID + "','" + m_strOUID + "','" + m_strProjectID + "','" + m_strEmployeeID + "','" + m_strFromdate + "','" + m_strTodate + "')")
            End If

            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
            ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
            ArrTopMenuFunctionsList.Add(" Close_OnClink()")
        End If

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ArrTopMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrTopMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrTopMenuFunctionsList.Add("Help_OnClick(" & UTILIZATION_TAGID & ")")

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

    Private Sub DisplayPageDetails()
        Dim strHTML As String
        Dim strCase As String

        Dim strPossibleCauses As String
        Dim strPossibleSolutions As String
        Dim objSection As WebPages.Template.SectionTitle
        Dim strTitle As String
        Dim strProjectName As String
        Dim drInfo As IDataReader
        Dim strBusinessGroup As String
        Dim strOrganizationUnit As String
        Dim strEmployeeName As String

        'Main Div
        CommonFunctions.General.WriteHTML("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:630px'>")

        If m_strMode.ToUpper = "GENERATE" Or m_strMode.ToUpper = "DISPLAYDETAILS" Or m_strMode.ToUpper = "DISPLAYSUMMARYDETAILS" Then

            If m_strBUID <> "" And m_strBUID <> "NULL" Then
                '-- Get Business Unit Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_CNF_BusinessGroups " + m_strBUID, MyBase.UseSQL)
                If drInfo.Read Then
                    strBusinessGroup = CommonFunctions.Data.CheckIsDBNull(drInfo("BusinessGroup"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            If m_strOUID <> "" And m_strOUID <> "NULL" Then
                '-- Get Organization Unit Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Location " + m_strOUID, MyBase.UseSQL)
                If drInfo.Read Then
                    strOrganizationUnit = CommonFunctions.Data.CheckIsDBNull(drInfo("Location"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            If m_strProjectID <> "" And m_strProjectID <> "NULL" Then
                '-- Get Project Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
                If drInfo.Read Then
                    strProjectName = CommonFunctions.Data.CheckIsDBNull(drInfo("ProjectName"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            If m_strEmployeeID <> "" And m_strEmployeeID <> "NULL" Then
                '-- Get Organization Unit Name
                drInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_EmployeeName " + m_strEmployeeID, MyBase.UseSQL)
                If drInfo.Read Then
                    strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drInfo("EmployeeName"), "").ToString
                End If
                CommonFunctions.Data.DisposeDataReader(drInfo)
            End If

            CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageHeader " + ">")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven><b>  " + MyBase.GetResourceString("SELECT_BU") + " : </b>  " + strBusinessGroup + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven> <b>  " + MyBase.GetResourceString("SELECT_OU") + " : </b> " + strOrganizationUnit + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven > <b>  " + MyBase.GetResourceString("SELECT_PROJECT") + " : </b>" + strProjectName + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven> <b> " + MyBase.GetResourceString("SELECT_RESOURCE") + " : </b> " + strEmployeeName + "</TD>")
            CommonFunctions.General.WriteHTML("</TR><TR class=clsTRPageHeader>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven > <b> " + MyBase.GetResourceString("FROMDATE") + " : </b>" + CommonFunctions.Dates.CGetDate(CType(m_strFromdate, Date)) + "</TD>")
            CommonFunctions.General.WriteHTML("<TD class=clsTDEven colspan=3> <b> " + MyBase.GetResourceString("TODATE") + " : </b>" + CommonFunctions.Dates.CGetDate(CType(m_strTodate, Date)) + " </TD>")
            CommonFunctions.General.WriteHTML("</TR></Table>")


            CommonFunctions.General.WriteHTML("<BR><BR>")


        End If


        CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven " + ">")

        If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" Then

            'Display Business Unit Combo

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_BU") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboBU", "usp_Sel_GetBusinessGroups " + m_strOUID + "," + m_strProjectID, 250, m_strBUID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            'Display Organization Unit Combo

            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_OU") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Sel_GetOrganizationUnit " + m_strBUID + "," + m_strProjectID, 250, m_strOUID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            'Display Project Combo
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_PROJECT") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_Sel_GetProjectNameList " + m_strBUID + "," + m_strOUID, 250, m_strProjectID, "" + " Langugage=JavaScript OnChange=Filter_change()", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            'Display Resources Combo
            CommonFunctions.General.WriteHTML("<TR class=clsTREven><TD align=right>" + MyBase.GetResourceString("SELECT_RESOURCE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboResource", "usp_Sel_GetResources  " + m_strBUID + "," + m_strOUID + "," + m_strProjectID, , m_strEmployeeID, "" + " ", True, True, , False))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            'Display From and To Date
            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("FROMDATE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunction.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromdate, , "frmResourceUtilization", , , , False, , , , True)
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROMDATE_COMMENT"))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")

            CommonFunctions.General.WriteHTML(" <TR class=clsTREven > ")
            CommonFunctions.General.WriteHTML("<TD align=right>" + MyBase.GetResourceString("TODATE") + "</TD>")
            CommonFunctions.General.WriteHTML("<TD align=left >")
            CommonFunction.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strTodate, , "frmResourceUtilization", , , , , , , , True)
            CommonFunctions.General.WriteHTML("</TD>")



            CommonFunctions.General.WriteHTML("</TR>")



        Else
            If m_strMode.ToUpper = "GENERATE" Then
                CommonFunctions.General.WriteHTML(" <TD align=center>")
                Call GenerateReportGraph()
                CommonFunctions.General.WriteHTML(" </TD></TR>")


                CommonFunctions.General.WriteHTML("</TABLE>")

                CommonFunctions.General.WriteHTML("<Table cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageFooter " + ">")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven width=10%><b> " + MyBase.GetResourceString("NOTE") + " : </b> </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left> " + MyBase.GetResourceString("CAPCITY") + "   </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("ALLOCATED") + " </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>  " + MyBase.GetResourceString("ACTUAL") + "     </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>   " + MyBase.GetResourceString("BILLABLE") + "  </TD></TR> ")
                CommonFunctions.General.WriteHTML("<TR class=clsTRPageFooter>")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven> &nbsp; </TD> ")
                CommonFunctions.General.WriteHTML("<TD class=clsTDEven align=left>   " + MyBase.GetResourceString("ONBENCH") + "   </TD></TR></TABLE> ")
            Else
                CommonFunctions.General.WriteHTML(" <TD align=center>")
                If m_strMode.ToUpper = "DISPLAYDETAILS" Then
                    Call DisplayResourceDetails()
                Else
                    Call DisplaySummaryDetails()
                End If
                CommonFunctions.General.WriteHTML(" </TD></TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")

            End If


        End If
        CommonFunctions.General.WriteHTML("</TABLE></DIV>")



    End Sub

    Private Sub DisplayResourceDetails()

        Dim ArrActualFieldNames() As String = {"Month", "ResourceName", "InstallCapacityHrs", "CapacityHrs", "Capacity%", "AllocatedHrs", "Allocated%", "ActualHrs", "Actual%", "BillableHrs", "Billable%"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("MONTH"), MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT")}
        Dim ArrSummaryFunctions() As String = {"", "", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrGroupSummaryFunctions() As String = {"", "", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrTDStyle() As String = {"align=left width=8%", "align=left width=15%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + ",'" + m_strFromdate + "','" + m_strTodate + "',1"

        With objListGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 500
            .SQL = strSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub
    Private Sub DisplaySummaryDetails()

        Dim ArrActualFieldNames() As String = {"Month", "InstallCapacityHrs", "CapacityHrs", "Capacity%", "AllocatedHrs", "Allocated%", "ActualHrs", "Actual%", "BillableHrs", "Billable%"}
        ' Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("EMPLOYEENAME"), MyBase.GetResourceString("DATE"), MyBase.GetResourceString("TASKNAME"), MyBase.GetResourceString("DESCRIPTION"), MyBase.GetResourceString("ACTUALWORKHRS")}
        Dim ArrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("MONTH"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT"), MyBase.GetResourceString("HOURS"), MyBase.GetResourceString("PERCENT")}
        Dim ArrSummaryFunctions() As String = {"", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrGroupSummaryFunctions() As String = {"", "SUM", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG", "SUM", "AVG"}
        Dim ArrTDStyle() As String = {"align=left width=8%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%", "align=right width=10%"}
        Dim strSQL As String
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = " EXEC  usp_Sel_ResourceUtilizationDetails " + m_strBUID + "," + m_strOUID + "," + m_strProjectID + "," + m_strEmployeeID + ",'" + m_strFromdate + "','" + m_strTodate + "',2"

        With objListSummaryGrid
            .ActualColumnArray = ArrActualFieldNames
            .UserFriendlyColumnArray = ArrUserFriendlyFieldNames
            .TDStyleArray = ArrTDStyle
            .NoOfDataColumns = 11
            .DIVID = "DivList"
            .DIVStyle = "Overflow:auto;width:100%"
            .DIVHeight = 500
            .SQL = strSQL
            .ShowSummaryFunctions = True
            .GroupSummaryFunc = ArrGroupSummaryFunctions
            .SummaryFunctions = ArrSummaryFunctions
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

    End Sub

    Private Sub GeneratePageHeader()
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
        '=====================================================================
        ' Procedure Name        : GeneratePageCaption()	
        ' Purpose               : to generate page caption
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
        'Modified by NikhatM on 24 Feb 2005 for isue id 16226,page caption vanishes when values are selected
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, , , , True))
        'Added by PrachiK on 17 Mar  2005 for IssueID 16226
        'Purpose:When a value is selected from combo fields 'Business Groups' / 'Organization Unit' / 'Project' Then the header title - 'Resource Utilization Report' vanishes.
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("GRAPHTITLE"), , , True))
        'Addtion ended
        'Modification ends
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
        m_intGraphHeight = 450
        m_intGraphWidth = 600 '492
        m_strTodate = ""
        m_strFromdate = ""

        'get Financial Start And End Dates
        CommonFunction.Dates.GetFromAndToDates("10", m_strFromdate, m_strTodate, "")


        'Set Global object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()

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

        If m_strMode.ToUpper <> "GENERATE" And m_strMode.ToUpper <> "DISPLAYDETAILS" And m_strMode.ToUpper <> "DISPLAYSUMMARYDETAILS" Then

            'Get Business Unit ID
            If Not MyBase.GetFormValue("cboBU") Is Nothing Then
                If MyBase.GetFormValue("cboBU") <> "" Then
                    m_strBUID = MyBase.GetFormValue("cboBU")
                Else
                    m_strBUID = "NULL"
                End If
            Else
                m_strBUID = "NULL"
            End If

            'Get Organization Unit ID
            If Not MyBase.GetFormValue("cboOU") Is Nothing Then
                If MyBase.GetFormValue("cboOU") <> "" Then
                    m_strOUID = MyBase.GetFormValue("cboOU")
                Else
                    m_strOUID = "NULL"
                End If
            Else
                m_strOUID = "NULL"
            End If

            'From Date
            If Not MyBase.GetFormValue("txtFromDate") Is Nothing Then
                If MyBase.GetFormValue("txtFromDate") <> "" Then
                    m_strFromdate = MyBase.GetFormValue("txtFromDate")
                End If
            End If

            'To Date
            If Not MyBase.GetFormValue("txtToDate") Is Nothing Then
                If MyBase.GetFormValue("txtToDate") <> "" Then
                    m_strTodate = MyBase.GetFormValue("txtToDate")
                End If
            End If


            'Get ProjectID
            If Not MyBase.GetFormValue("cboProject") Is Nothing Then
                If MyBase.GetFormValue("cboProject") <> "" Then
                    m_strProjectID = MyBase.GetFormValue("cboProject")
                    'GET OU and BU of selected Project
                    '-- Get Project Name
                    drProjectInfo = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Project " + m_strProjectID, MyBase.UseSQL)
                    If drProjectInfo.Read Then
                        m_strBUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("BusinessGroupID"), "").ToString
                        m_strOUID = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("LocationID"), "").ToString
                        m_strFromdate = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ExpectedStartDate"), "").ToString
                        m_strTodate = CommonFunctions.Data.CheckIsDBNull(drProjectInfo("ExpectedEndDate"), "").ToString
                    End If
                    CommonFunctions.Data.DisposeDataReader(drProjectInfo)
                Else
                    m_strProjectID = "NULL"
                End If
            Else
                m_strProjectID = "NULL"
            End If

            'Get Resource ID
            If Not MyBase.GetFormValue("cboResource") Is Nothing Then
                If MyBase.GetFormValue("cboResource") <> "" Then
                    m_strEmployeeID = MyBase.GetFormValue("cboResource")
                Else
                    m_strEmployeeID = "NULL"
                End If
            Else
                m_strEmployeeID = "NULL"
            End If
        Else
            If Not Request.QueryString("FromDate") Is Nothing Then
                If Request.QueryString("FromDate") <> "" Then
                    m_strFromdate = Request.QueryString("FromDate")
                Else
                    m_strFromdate = "NULL"
                End If
            Else
                m_strFromdate = "NULL"
            End If

            If Not Request.QueryString("ToDate") Is Nothing Then
                If Request.QueryString("ToDate") <> "" Then
                    m_strTodate = Request.QueryString("ToDate")
                Else
                    m_strTodate = "NULL"
                End If
            Else
                m_strTodate = "NULL"
            End If
            If Not Request.QueryString("BUID") Is Nothing Then
                If Request.QueryString("BUID") <> "" Then
                    m_strBUID = Request.QueryString("BUID")
                Else
                    m_strBUID = "NULL"
                End If
            Else
                m_strBUID = "NULL"
            End If
            If Not Request.QueryString("OUID") Is Nothing Then
                If Request.QueryString("OUID") <> "" Then
                    m_strOUID = Request.QueryString("OUID")
                Else
                    m_strOUID = "NULL"
                End If
            Else
                m_strOUID = "NULL"
            End If
            If Not Request.QueryString("ProjectID") Is Nothing Then
                If Request.QueryString("ProjectID") <> "" Then
                    m_strProjectID = Request.QueryString("ProjectID")
                Else
                    m_strProjectID = "NULL"
                End If
            Else
                m_strProjectID = "NULL"
            End If
            If Not Request.QueryString("ResourceID") Is Nothing Then
                If Request.QueryString("ResourceID") <> "" Then
                    m_strEmployeeID = Request.QueryString("ResourceID")
                Else
                    m_strEmployeeID = "NULL"
                End If
            Else
                m_strEmployeeID = "NULL"
            End If
        End If

        If m_strFromdate <> "" Then
            m_strFromdate = CommonFunctions.Dates.GetDate(CType(m_strFromdate, Date))
        End If
        If m_strTodate <> "" Then
            m_strTodate = CommonFunctions.Dates.GetDate(CType(m_strTodate, Date))
        End If

        m_strSessionUserID = CType(Session("intUserID"), String)

    End Sub



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
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for the page



    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub objListGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListGrid.DataRowTR_BeforePrint
        m_intCount = m_intCount + 1
        'Check for Group Value
        If m_strMonth <> Args.DataReader("Month").ToString.Trim Then
            If m_GroupTotalCapacity >= 0 Then
                'Insert sum for the Month
                Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue>" + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacityPer / m_intCount).ToString("N2") + "</FONT></TD>"

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocatedPer / m_intCount).ToString("N2") + "</FONT></TD>"

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActualPer / m_intCount).ToString("N2") + "</FONT></TD>"

                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
                Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillablePer / m_intCount).ToString("N2") + "</FONT></TD></TR>"
            End If

            'Initialize GroupSum to 0 for next group
            m_intCount = 0
            m_GroupTotalCapacity = 0
            m_GroupTotalAllocated = 0
            m_GroupTotalActual = 0
            m_GroupTotalBillable = 0
            m_GroupTotalCapacityPer = 0
            m_GroupTotalAllocatedPer = 0
            m_GroupTotalActualPer = 0
            m_GroupTotalBillablePer = 0
            m_GroupInstallCapacity = 0

            'reset Month
            m_strMonth = Args.DataReader("Month").ToString + ""

            'Insert TR which will have group value
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left' colspan=11>" + Args.DataReader("Month").ToString + "</FONT></TD></TR>"
            m_GroupTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GroupTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GroupTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GroupTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
            m_GroupInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GroupTotalCapacityPer += CType(Args.DataReader("Capacity%"), Double)
            m_GroupTotalAllocatedPer += CType(Args.DataReader("Allocated%"), Double)
            m_GroupTotalActualPer += CType(Args.DataReader("Actual%"), Double)
            m_GroupTotalBillablePer += CType(Args.DataReader("Billable%"), Double)

        Else
            'update GroupSum
            m_GroupTotalCapacity += CType(Args.DataReader("CapacityHrs"), Double)
            m_GroupTotalAllocated += CType(Args.DataReader("AllocatedHrs"), Double)
            m_GroupTotalActual += CType(Args.DataReader("ActualHrs"), Double)
            m_GroupTotalBillable += CType(Args.DataReader("BillableHrs"), Double)
            m_GroupInstallCapacity += CType(Args.DataReader("InstallCapacityHrs"), Double)
            m_GroupTotalCapacityPer += CType(Args.DataReader("Capacity%"), Double)
            m_GroupTotalAllocatedPer += CType(Args.DataReader("Allocated%"), Double)
            m_GroupTotalActualPer += CType(Args.DataReader("Actual%"), Double)
            m_GroupTotalBillablePer += CType(Args.DataReader("Billable%"), Double)
        End If

    End Sub

    Private Sub objListGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objListGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then 'if first column(Month)

            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TR class='clsTREven'><TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TR class='clsTROdd'><TD align='left'></TD>"
            End If
            Cancel = True
        End If
    End Sub

    Private Sub objListGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles objListGrid.SummaryFunctionsTR_BeforePrint
        If m_GroupTotalCapacity >= 0 Then
            m_intCount = m_intCount + 1



            'Insert sum for the Month
            Args.StringToBeInserted = "<TR class='clsTRSectionHeader' ><TD align='left' colspan=2><FONT color=blue> " + MyBase.GetResourceString("TOTALCAPTION") + "  " + m_strMonth + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupInstallCapacity.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalCapacity.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalCapacityPer / m_intCount).ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalAllocated.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalAllocatedPer / m_intCount).ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalActual.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalActualPer / m_intCount).ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + m_GroupTotalBillable.ToString("N2") + "</FONT></TD>"
            Args.StringToBeInserted += "<TD align=right ><FONT color=blue>" + (m_GroupTotalBillablePer / m_intCount).ToString("N2") + "</FONT></TD></TR>"
        End If
    End Sub

    Private Sub objListGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListGrid.ColumnHeaderTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=2>&nbsp;</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"

    End Sub

    Private Sub objListSummaryGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objListSummaryGrid.DataRowTR_BeforePrint

    End Sub

    Private Sub objListSummaryGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles objListSummaryGrid.ColumnHeaderTR_BeforePrint
        Args.StringToBeInserted = "<TR class='clsTRColumnHeader' ><TD align='center' colspan=1>&nbsp;</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=1>" + MyBase.GetResourceString("HEADER_INSTALLCAPACITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_CAPCITY") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ALLOCATED") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_ACTUAL") + "</TD>"
        Args.StringToBeInserted += "<TD align=center colspan=2>" + MyBase.GetResourceString("HEADER_BILLABLE") + "</TD></TR>"
    End Sub
End Class
