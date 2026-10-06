Imports CommonFunctions
'Imports Whizible

Public Class Measurement_FactDetails
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmProjectMeasurements As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting        
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016
        InitializeComponent()
    End Sub

#End Region

    '=====================================================================
    ' Page Name             :	MB_Plot_MeasurementGraphs_For_Projects.aspx
    ' Purpose               :	Plot the Measurements Graphs and DrillDowns
    ' Description           :	Same as above
    ' Assumptions           :	All required data is present.
    ' Dependencies          :	Tables and SP's in database.
    ' Author                :	Sandeep Aparajit
    ' Created               :	November 08, 2005 
    ' Revisions             :   
    '=====================================================================

#Region "Variables"
    Public m_intGraphCount As Integer = 2
    Private m_intCurrentGraphCount As Integer = 1
    Private GRAPH_DIRECTORY As String
    Private m_blnUseSQL As Boolean = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private m_strConnectionString As String = CommonFunction.Application.ConnectionString
    Public m_lngProjectID As Long = 0
    Protected m_GraphDisplay As Boolean = False

    Public m_strProjectName As String = ""
    Protected m_strMode As String = ""
    Private m_strMeasurementID As String = ""
    Private m_GImageName As String = ""
    Private m_strFromDate As String = ""

    Private m_strCharType As String = ""
    Private m_strCharID As String = ""
    Private m_strToDate As String = ""
    Private m_strProjectTypeID As String = ""
    Private m_strPMIID As String
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Public strMetricView As String = ""
    Protected m_strFromWhere As String
    Protected dsGraph As DataSet
#End Region

#Region "Page Load"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Your code here
    End Sub
#End Region

#Region "Write Menu"
    Sub WriteMenu()
        '=====================================================================
        ' Procedure Name        : WriteMenu()
        ' Purpose               : To Plot Menu
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Resource File.
        ' Author                : SandeepA
        ' Created               : Nov 08,2005
        ' Revisions             : 
        '=====================================================================

        'Plot Menu
        Dim objStaticMenu As New WebPages.Template.StaticMenu
        Dim arrmenuNames() As String = {MyBase.GetResourceString("MENU_REPORT") _
                                        , MyBase.GetResourceString("PRINT_PREVIEW_MENU") _
                                        , MyBase.GetResourceString("MENU_CLOSE") _
                                        , MyBase.GetResourceString("MENU_HELP") _
                                        }
        Dim arrmenuFunctions() As String = {"Project_Measurement_Report(" + m_lngProjectID.ToString + ")" _
                                            , "PrintPreview_OnClick()" _
                                            , "Close_OnClick()" _
                                            , "Help()" _
                                            }
        Dim arrLinkToolTip() As String = {MyBase.GetResourceString("MENU_REPORT") _
                                        , MyBase.GetResourceString("PRINT_PREVIEW_TOOLTIP") _
                                         , MyBase.GetResourceString("MENU_CLOSE_TOOLTIP") _
                                        , MyBase.GetResourceString("MENU_HELP_TOOLTIP") _
                                        }

        'Display MENU Links 
        objStaticMenu.DrawMenu(arrmenuNames, arrmenuFunctions, arrLinkToolTip, False)

    End Sub
#End Region

#Region "Init"
    Private Sub InitVariables()

        '=====================================================================
        ' Procedure Name        :	InitVariables
        ' Purpose               :	initializes all the variables
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Sandeep Aparajit
        ' Created               :	November 08, 2005 
        ' Revisions             :
        '=====================================================================

        ' Dim strSQL As String

        m_strMode = CommonFunctions.General.CheckIsNothing(Request.QueryString("mode"), "")
        m_strMeasurementID = CommonFunctions.General.CheckIsNothing(Request.QueryString("MeasurementID"), "0")
        m_GImageName = CommonFunctions.General.CheckIsNothing(Request.QueryString("gImage"), "")

        'm_lngProjectID = CLng(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"))
        m_lngProjectID = CLng(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"))
        m_strFromDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromDate"), "0")
        m_strToDate = CommonFunctions.General.CheckIsNothing(Request.QueryString("ToDate"), "0")
        m_strCharType = CommonFunctions.General.CheckIsNothing(Request.QueryString("CharType"), "0")
        m_strCharID = CommonFunctions.General.CheckIsNothing(Request.QueryString("CharTypeID"), "0")
        'If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), ""), String) <> "" Then
        '    m_strFromWhere = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), ""), String)
        'End If

        'If m_strFromWhere = "SEM" Then
        '    Dim drConnectionDetails As IDataReader
        '    drConnectionDetails = CommonFunctions.Data.GetDataReader("select ConnectionString from V_Get_MetricConnectionString_Details", MyBase.UseSQL, m_strConnectionString)
        '    If drConnectionDetails.Read Then
        '        m_strConnectionString = CommonFunctions.General.DecryptString(CommonFunctions.General.CheckIsNothing(drConnectionDetails(0), m_strConnectionString))
        '    End If
        '    CommonFunctions.Data.DisposeDataReader(drConnectionDetails)
        'End If

        'strSQL = "If Exists(Select ProjectName from tbl_PM_Project where ProjectID=" & m_lngProjectID & ")(Select ProjectName from tbl_PM_Project where ProjectID=" & m_lngProjectID & ")else Select 'Project'"
        'm_strProjectName = CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL, m_strConnectionString)

        'GRAPH_DIRECTORY = CStr(CommonFunctions.General.CheckIsNothing((MyBase.GetResourceString("GRAPH_DIRECTORY")), "..\..\Images\"))

        ''Added by SrikanthY on 04 Jul 2007, to enable weekly logic while Generating datapoint report
        'strMetricView = CommonFunctions.Data.GetDataScalar(" SELECT dbo.UDF_Get_TBL_MET_FREQUENCYTYPES (" & m_lngProjectID & ") ", MyBase.UseSQL, m_strConnectionString)

    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To Plot The Page Containts. This is the first method called 
        ' Description           : Same as above
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Sandeep Aparajit
        ' Created               : November 08,2005
        ' Revisions             : 
        '=====================================================================

        InitVariables()
        PlotZOOM()
        'If m_strMode.ToUpper = "ZOOM" Then
        '    PlotZOOM()
        'ElseIf m_strMode.ToUpper = "ZOOM" Then
        '    PlotPrint()
        'ElseIf m_strMode.ToUpper = "PRINT" Then
        '    PlotPrint()
        'Else
        '    Dim strSQL As String, strProjectName As String
        '    Call WriteMenu()
        '    HttpContext.Current.Response.Write("<br>")
        '    'Get ProjectName 
        '    strSQL = "Select Top 1 ProjectName from tbl_PM_Project Where ProjectID=" & m_lngProjectID
        '    strProjectName = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQL, m_blnUseSQL, m_strConnectionString), "")
        '    'Display Project Name
        '    DrawPageCaption("Project :  " & strProjectName)

        '    HttpContext.Current.Response.Write("<div id ='DivList' name='DivList' Style='overflow:auto;height:490px;width:100%'>")
        '    Call InitGraph()
        '    HttpContext.Current.Response.Write("</div>")
        '    Call WriteMenu()
        'End If
    End Sub
#End Region

#Region "ZOOM Functions"
    Private Sub PlotZOOM()
        '=====================================================================
        ' Procedure Name        :	PlotZOOM
        ' Purpose               :	Plots the  DrillDown i.e. ZOOM Page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Sandeep Aparajit
        ' Created               :	November 08, 2005 
        ' Revisions             :
        '=====================================================================


        DrawZOOMMenu()

        HttpContext.Current.Response.Write("<TABLE id='tblPL032' CellSpacing=0 width='100%' class=clsTable><TR class=clsTRBlank><TD align='Right'><B>Note:Screen shows current data details.</B></TD></TR></TABLE>")
        DrawPageCaption("Measurement Information")
        DisplayMeasurementInfo()
        HttpContext.Current.Response.Write("<br>")

        DrawPageCaption("Fact Details")
        HttpContext.Current.Response.Write("<br>")
        DrawProjectMetricGrid()
        HttpContext.Current.Response.Write("<br>")
        DrawZOOMMenu()

    End Sub
    Private Sub DrawProjectMetricGrid()
        '=====================================================================
        ' Sub Name              : DrawProjectMetricGrid()	
        ' Purpose               : To draw the Project Metric Matrix Grid (top Grid)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NobleK
        ' Created               : Jab 09, 2006
        ' Revisions             :
        '=====================================================================
        Dim intPrevPrjTypeID As Integer = 0
        Dim intPrjTypeID As Integer
        Dim intRowCnt As Integer = 1
        Dim intColCnt As Integer
        Dim intCounter As Integer = 0
        Dim strPrjType As String
        Dim arrColNameList As ArrayList = New ArrayList(100)
        Dim blnRowSelected As Boolean
        Dim strProjectID As String
        Dim strMetricName As String

        Dim strSQLQuery As String
        strProjectID = Session("intProjectID").ToString


        Dim drPrjTypePrjMetricData As IDataReader

        'Added on 20th Jan, 2005 to provide the list of projects based on role
        Dim intRoleLevel As Integer
        Dim m_strProjectFilters As String = ""
        intRoleLevel = CType(CommonFunctions.General.CheckIsNothing(Session("intRoleLevel"), "0"), Integer)
        ' m_strProjectFilters = ""
        'If middle level then apply filter for Projects
        'If intRoleLevel = 2 Then
        '    'Apply Role Access Filter for Project List
        '    m_strProjectFilters = ""
        '    Dim strFilter As String = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
        '    If strFilter <> "" Then
        '        m_strProjectFilters += strFilter
        '    End If
        'End If
        'm_strProjectFilters = Replace(UCase(m_strProjectFilters), "ProjectID IN(", "")
        'm_strProjectFilters = Replace(UCase(m_strProjectFilters), ")", "")
        'm_strProjectFilters = Replace(UCase(m_strProjectFilters), "'", "")
        'If m_strPT = "" Then
        'Vidya
        'strSQLQuery = "usp_Sel_ProjectType_ProjectMetricData '" & strProjectID & "'"
        If m_strCharType = "0" Then
            strSQLQuery = "Usp_Sel_tbl_MET_Measurement_FactDetails " & strProjectID & ",'" & m_strFromDate & "','" & m_strToDate & "',NULL,NULL," & m_strMeasurementID
        Else
            strSQLQuery = "Usp_Sel_tbl_MET_Measurement_FactDetails " & strProjectID & ",'" & m_strFromDate & "','" & m_strToDate & "','" & m_strCharType & "'," & m_strCharID & "," & m_strMeasurementID
        End If

        'strSQLQuery = "Usp_Sel_tbl_MET_Measurement_FactDetails 45,'02-Feb-10','02-Feb-11','P',14,2"
        'Vidya

        'Else
        '    strSQLQuery = "usp_Sel_ProjectType_ProjectMetricData '" & m_strProjectFilters & "'," + m_strPT
        'End If
        'strSQLQuery = "usp_Sel_ProjectType_ProjectMetricData "
        'End of Code Added on 20th Jan, 2005 to provide the list of projects based on role
        drPrjTypePrjMetricData = Data.GetDataReader(strSQLQuery, True)
        While (intCounter <= drPrjTypePrjMetricData.FieldCount - 1)
            arrColNameList.Add(drPrjTypePrjMetricData.GetName(intCounter))
            intCounter = intCounter + 1
        End While
        intCounter = 0

        CommonFunctions.General.WriteHTML("<DIV id='DivList' style='Overflow:auto;width:100%;height:100%;'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblList' class='clsGridTable' width='100%' cellspacing=1 border=0 >")

        DrawHeader(arrColNameList, 1)

        Do While drPrjTypePrjMetricData.Read
            intColCnt = drPrjTypePrjMetricData.FieldCount
            intRowCnt = intRowCnt + 1
            If intRowCnt Mod 2 <> 0 Then
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
            Else
                CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            End If
            While intCounter <= intColCnt - 1
                'For Project Name
                'First 3 columns contain ProjectTypeID, ProjectType, ProjectID which need not be displayed
                '  If intCounter = 3 Then
                CommonFunctions.General.WriteHTML("<TD>")
                CommonFunctions.General.WriteHTML(drPrjTypePrjMetricData(arrColNameList.Item(intCounter).ToString))
                CommonFunctions.General.WriteHTML("</TD>")
                'ElseIf intCounter = 4 Or intCounter = 5 Then
                ''For Start Date and EndDate
                'CommonFunctions.General.WriteHTML("<TD>")
                'CommonFunctions.General.WriteHTML(CommonFunctions.Dates.GetDate(drPrjTypePrjMetricData(arrColNameList.Item(intCounter).ToString)))
                'CommonFunctions.General.WriteHTML("</TD>")
                'End If
                'CommonFunctions.General.WriteHTML("<TD>")
                intCounter = intCounter + 1
            End While
            CommonFunctions.General.WriteHTML("</TR>")
            intCounter = 0
        Loop

        CommonFunctions.Data.DisposeDataReader(drPrjTypePrjMetricData)
        General.WriteHTML("</TABLE>") 'End of tblList1
        General.WriteHTML("</DIV>") 'End of divList
        ' DrawHiddens()
    End Sub


    Private Sub DrawHeader(ByVal arrlst As ArrayList, ByVal intFor As Integer)
        Dim intCounter As Integer = 0
        '  m_strHeaderTables.Append("<TABLE id='tblH" & CType(intFor, String) & "' class='clsGridTable' width='100%' cellspacing=1 border=0 style='display:none;height:0px;TABLE-LAYOUT:fixed;'>")
        CommonFunctions.General.WriteHTML("<thead class='clsTRColumnHeader'>")
        'm_strHeaderTables.Append("<TR class='clsTRColumnHeader'>")
        While intCounter < arrlst.Count
            CommonFunctions.General.WriteHTML("<th align='left' class='DivList'>")
            CommonFunctions.General.WriteHTML(arrlst.Item(intCounter))
            CommonFunctions.General.WriteHTML("</th>")
            intCounter = intCounter + 1
        End While
        CommonFunctions.General.WriteHTML("</thead>")


        'If intFor = 1 Then
        '    CommonFunctions.General.WriteHTML("<TD >")
        '    CommonFunctions.General.WriteHTML("</TD>")
        '    m_strHeaderTables.Append("<TD></TD>")
        'End If

        'While intCounter < arrlst.Count
        '    If intFor = 1 Then
        '        If intCounter > 2 Then
        '            CommonFunctions.General.WriteHTML("<TD>")
        '            CommonFunctions.General.WriteHTML(arrlst.Item(intCounter))
        '            CommonFunctions.General.WriteHTML("</TD>")
        '            m_strHeaderTables.Append("<td></td>")
        '        End If
        '    Else
        '        If intCounter > 0 Then
        '            CommonFunctions.General.WriteHTML("<TD>")
        '            CommonFunctions.General.WriteHTML(arrlst.Item(intCounter))
        '            CommonFunctions.General.WriteHTML("</TD>") 
        '            m_strHeaderTables.Append("<td></td>")
        '        End If
        '    End If
        '    intCounter = intCounter + 1
        'End While
        ' m_strHeaderTables.Append("</TR>")
        'CommonFunctions.General.WriteHTML("</TR>")
    End Sub

    Private Sub DisplayMeasurementInfo()
        '=====================================================================
        ' Procedure Name        :	DisplayMeasurementInfo
        ' Purpose               :	Plots the  DrillDown i.e. ZOOM Page Measurement Information
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Sandeep Aparajit
        ' Created               :	November 08, 2005 
        ' Revisions             :
        '=====================================================================


        'Done
        Dim strQuery As String
        Dim drMeasurementInfo As IDataReader
        Dim strProjectName As String
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        ' strProjectName = CommonFunction.Data.GetDataScalar("SELECT ProjectName FROM Tbl_PM_Project WHERE ProjectID = " + m_lngProjectID.ToString, MyBase.UseSQL, m_strConnectionString)
        strProjectName = CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PM_Project_Display " + m_lngProjectID.ToString, MyBase.UseSQL, m_strConnectionString)

        ' strQuery = "Select MeasurementCode,Guidelines,FunctionName,UserFriendlyName,UnitName as 'Unit' from tbl_PRS_Measurements,tbl_PRS_Units Where tbl_PRS_Measurements.UnitID=tbl_PRS_Units.UnitID and MeasurementID=" & m_strMeasurementID
        strQuery = "usp_sel_tbl_PRS_Measurements_Unit " & m_strMeasurementID
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        drMeasurementInfo = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL, m_strConnectionString)
        If drMeasurementInfo.Read Then
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
            HttpContext.Current.Response.Write(MyBase.GetResourceString("MEASUREMENT_NAME"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMeasurementInfo("UserFriendlyName"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")


            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write(MyBase.GetResourceString("MEASUREMENT_CODE"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMeasurementInfo("MeasurementCode"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write(MyBase.GetResourceString("MEASUREMENT_GUIDELINES"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMeasurementInfo("Guidelines"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write(MyBase.GetResourceString("MEASUREMENT_UNIT"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(drMeasurementInfo("Unit"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")


            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write("From Date")
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(CDate(m_strFromDate).ToString("dd-MMM-yyyy"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")

            HttpContext.Current.Response.Write("<TR >")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=right>")
            HttpContext.Current.Response.Write("To Date")
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("<TD class=clsTDEven align=left>")
            HttpContext.Current.Response.Write(CDate(m_strToDate).ToString("dd-MMM-yyyy"))
            HttpContext.Current.Response.Write("</TD>")
            HttpContext.Current.Response.Write("</TR >")


            HttpContext.Current.Response.Write("</Table>")
        End If
        CommonFunctions.Data.DisposeDataReader(drMeasurementInfo)

    End Sub

    Private Sub DrawPageCaption(ByVal strCaption As String)
        '=====================================================================
        ' Procedure Name        :	DrawPageCaption
        ' Purpose               :	Plots Caption
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Sandeep Aparajit
        ' Created               :	November 08, 2005 
        ' Revisions             :
        '=====================================================================
        'strCaption = "Data points Trends"
        WebPages.Template.PageCaption.GetPageCaptions(, strCaption, , )

    End Sub

    Private Sub DrawZOOMMenu()
        '=====================================================================
        ' Procedure Name        :	DrawZOOMMenu
        ' Purpose               :	Plots DrillDown (ZOOM Page) Menu
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Sandeep Aparajit
        ' Created               :	November 08, 2005 
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML

        arrMenuCaptionsList.Add("Close")
        arrMenuToolTipsList.Add("Close")
        arrClientSideFunctionList.Add("Close_OnClick()")

        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing("?"))
        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing("Help"))
        arrClientSideFunctionList.Add("Help()")

        m_objMenu = New WebPages.Template.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function

#End Region

End Class