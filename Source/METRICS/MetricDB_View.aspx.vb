'Imports Whizible

'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhiziblePPM
' Module Name           :  MetricDB_ProjectTypeView.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
Imports Whizible
#End Region

Public Class MetricDB_View
    Inherits WebPages.Template.WhizTemplate
    Protected WithEvents Report As DynamicReports.Report
    Protected m_strFileName As String

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
    Dim m_strWeekEndDate As String
    Dim strStatus As String
    Dim dtstrMonthEndDate As String
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Protected m_PageMode As String
    Protected m_LoginType As String
    Protected m_LoginId As String
    Protected m_Role As String
    Protected m_strProjectFilters As String = ""
    Protected m_strMonthEndDate As String = ""
    Protected m_dtReportDate As Date
    Protected m_intMonth As String
    Protected m_strMonthName As String
    Protected m_intYear As String
    Protected WithEvents objGrid As WebPage.Templates.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    'Added By RathinP To Integrate Weekly View
    Dim strMetricView As String
    Dim m_WeekStartDate As DateTime
    Public strWeekStartDate As String
    Public strWeekEndDate As String
    'End of Addition By RattinP
    Protected m_FromGenerator As Integer = 0
    Protected Enum PageModes
        PROJECT_TYPE_VIEW = 1
        SINGLE_PROJECT_VIEW = 2
        ALL_PROJECT_VIEW = 3
        TREND_GRAPH_VIEW = 4
        GENERATOR_VIEW = 5
    End Enum

#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   
        ' Revisions             :   
        '=====================================================================
        'Added by Archanan on 7-Apr-2010
        If UCase(Trim(Request.QueryString("Action") & "") & "") = "EXPORT" Then
            Call InitVariables()
            Call ShowGeneratorView()
        Else
            'End of Added by Archanan on 7-Apr-2010
            Call GetGlobalObject()
            Call InitVariables()
            Call DrawMenu()

            Select Case m_PageMode
                Case PageModes.PROJECT_TYPE_VIEW
                    Call ShowProjectTypeView()

                Case PageModes.ALL_PROJECT_VIEW
                    Call ShowProjectView()

                Case PageModes.SINGLE_PROJECT_VIEW

                Case PageModes.TREND_GRAPH_VIEW

                Case PageModes.GENERATOR_VIEW
                    'Added by SrikanthY on 12 Jul 2007 Foe Whizible Metrics 3.0
                    Call ShowGeneratorView()
            End Select
            Call DrawMenu()
        End If
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub InitVariables()
        '====================================================================
        ' Procedure Name        :  InitVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Initialise the variables 
        ' Description           :  This sub-routine fills the variables 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  28 Nov 2005 
        ' Revisions             :  
        '=====================================================================


        ' Get the Mode 
        If Not IsNothing(HttpContext.Current.Request.QueryString("MODE")) Then
            m_PageMode = HttpContext.Current.Request.QueryString("MODE")
        End If

        m_LoginType = CType(HttpContext.Current.Session("LoginType"), String)
        m_LoginId = CType(HttpContext.Current.Session("intUserID"), String)

        m_strProjectFilters = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")

        If m_strProjectFilters <> "" Then
            Dim strRemove As String = "ProjectID IN"
            m_strProjectFilters = m_strProjectFilters.Remove(0, strRemove.Length)
            'End Addition
            m_strProjectFilters = m_strProjectFilters.Replace("'", "")
            m_strProjectFilters = m_strProjectFilters.Replace("(", "")
            m_strProjectFilters = m_strProjectFilters.Replace(")", "")
        End If
        'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        'strMetricView = CType(CommonFunctions.Data.GetDataScalar(" SELECT DBO.UDF_Get_TBL_MET_FREQUENCYTYPES(" + Session("intProjectID").ToString + ")", MyBase.UseSQL), String)
        strMetricView = CType(CommonFunctions.Data.GetDataScalar("usp_sel_Get_TBL_MET_FREQUENCYTYPES " + Session("intProjectID").ToString, MyBase.UseSQL), String)
        'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
        Select Case (strMetricView.ToUpper)
            Case "MONTHLY"
                ' Set the Month End date 
                If m_strMonthEndDate = "" Then
                    m_strMonthEndDate = CType(Date.Today.AddDays(Date.Today.DaysInMonth(Date.Today.Year, Date.Today.Month) - Date.Today.Day), String)
                    m_intMonth = Date.Today.Month
                    m_intYear = Date.Today.Year
                    m_dtReportDate = m_strMonthEndDate
                    m_strMonthName = CommonFunction.Data.GetDataScalar("SELECT DateName( month , '" + m_strMonthEndDate + "') ", MyBase.UseSQL)
                End If
                If Not IsNothing(Request.QueryString("MonthValue")) Then

                    Dim strMonthValue As String = Request.QueryString("MonthValue")
                    ' if MonthValue = 1 then move to mext month else if MonthValue = -1 then move to previous month


                    m_intMonth = CType(Request.QueryString("Month"), String)
                    m_intYear = CType(Request.QueryString("Year"), String)
                    m_dtReportDate = Date.Parse(Trim(m_intMonth) + "/" + CType(Date.DaysInMonth(CType(m_intYear, Integer), CType(m_intMonth, Integer)), String) + "/" + Trim(m_intYear))

                    '' m_dtReportDate = Date.Parse(m_strMonthEndDate)
                    'If strMonthValue = "1" Then
                    '    m_dtReportDate = m_dtReportDate.AddMonths(1)

                    'ElseIf strMonthValue = "-1" Then
                    '    m_dtReportDate = m_dtReportDate.AddMonths(-1)
                    'End If

                    m_strMonthEndDate = m_dtReportDate.ToString
                    m_strMonthName = CommonFunction.Data.GetDataScalar("SELECT DateName( month ,'" + m_strMonthEndDate + "' ) ", MyBase.UseSQL)
                End If
                'Added By RathinP On 26-June-2007
                ' To Integrate Weekly View
            Case "WEEKLY"

                If Not IsNothing(Request.QueryString("WeekStartDate")) Then


                    strStatus = Request.QueryString("Status")
                    dtstrMonthEndDate = Request.QueryString("WeekStartDate")
                    If strStatus = "-1" Then
                        m_strMonthEndDate = CType(dtstrMonthEndDate, DateTime).AddDays(-7)
                        m_strWeekEndDate = CType(dtstrMonthEndDate, DateTime).AddDays(-7)
                    Else
                        m_strMonthEndDate = CType(dtstrMonthEndDate, DateTime).AddDays(1)
                        'RathinP on 28-June-2007
                        ' To Set the EndDate of the Week
                        m_strWeekEndDate = CType(dtstrMonthEndDate, DateTime).AddDays(7)
                        'End of Addition by RathinP for EndDate
                    End If
                    m_intMonth = Date.Today.Month
                    m_intYear = Date.Today.Year
                    m_dtReportDate = m_strMonthEndDate
                    m_strMonthName = CommonFunction.Data.GetDataScalar("SELECT DateName( month , '" + m_strMonthEndDate + "') ", MyBase.UseSQL)
                Else
                    'Added By RathinP On 26-June-2007
                    ' To Integrate Weekly View
                    m_strMonthEndDate = CommonFunction.Data.GetDataScalar("SELECT Getdate() ", MyBase.UseSQL)
                    m_intMonth = Date.Today.Month
                    m_intYear = Date.Today.Year
                    m_dtReportDate = m_strMonthEndDate
                    m_strMonthName = CommonFunction.Data.GetDataScalar("SELECT DateName( month , '" + m_strMonthEndDate + "') ", MyBase.UseSQL)
                End If
                'End of Addition By RathinP 

        End Select

        If m_PageMode.ToString = "5" Then
            m_FromGenerator = 1
        End If

    End Sub
    Private Sub ShowProjectTypeView()
        '====================================================================
        ' Procedure Name        :  ShowProjectTypeView
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Show the Summary of Metrics and Data Points for Project Types 
        ' Description           :  This sub-routine Shows the Summary of Metrics and Data Points for Project Types 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  28 Nov 2005 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String
        Dim ObjProjectTypeDr As IDataReader
        Dim objMetricDr As IDataReader
        Dim strProjectTypeID As String
        Dim strProjectType As String
        Dim strDashboardId As String
        Dim ProjectTypeCount As Integer = 0
        Dim blnHeaderPlotted As Boolean = False
        Dim strCategory As String = ""

        ' Draw The Header Information 
        Select Case (strMetricView.ToUpper)
            Case "MONTHLY"
                If m_LoginType = "C" Then
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_TYPE_VIEW") + "/ Month - " + m_strMonthName + " '" + m_intYear, , )
                Else
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_TYPE_VIEW") + "/ Month - " + m_strMonthName + " '" + m_intYear, , )
                End If
                'Added By RathinP On 26-June-2007
                ' To Integrate Weekly View
            Case "WEEKLY"
                'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                'strWeekStartDate = CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate('" + m_dtReportDate + "')  ", MyBase.UseSQL)
                strWeekStartDate = CommonFunctions.Data.GetDataScalar("usp_sel_udf_getCurrentWeek_Function " + m_dtReportDate, MyBase.UseSQL)
                ' strWeekEndDate = CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate('" + m_dtReportDate + "')+6  ", MyBase.UseSQL)
                strWeekEndDate = CommonFunctions.Data.GetDataScalar("usp_sel_udf_getCurrentWeek_FunctionPlus " + m_dtReportDate, MyBase.UseSQL)
                'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query

                If m_LoginType = "C" Then
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_TYPE_VIEW") + " From " + CType(strWeekStartDate, Date).ToString("dd-MMM-yyyy") + " To " + CType(strWeekStartDate, DateTime).AddDays(6).ToString("dd-MMM-yyyy"), , )
                Else
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_TYPE_VIEW") + " From " + CType(strWeekStartDate, Date).ToString("dd-MMM-yyyy") + " To " + CType(strWeekStartDate, DateTime).AddDays(6).ToString("dd-MMM-yyyy"), , )
                End If
                'End of Addition By RathinP 


        End Select

        '' Draw The Header Information 
        'If m_LoginType = "C" Then
        '    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_TYPE_VIEW") + "/ Month - " + m_strMonthName + " '" + m_intYear, , )
        'Else
        '    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_TYPE_VIEW") + "/ Month - " + m_strMonthName + " '" + m_intYear, , )
        'End If

        ' Get the project Types accessible to the currently logged in user
        'RathinP on 28-June-2007
        ' To Set the EndDate of the Week
        If strMetricView.ToUpper = "MONTHLY" Then
            strSQL = "usp_sel_Tbl_PRS_ProjectTypes_accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + m_strMonthEndDate + "'"
        ElseIf strMetricView.ToUpper = "WEEKLY" Then
            strSQL = "usp_sel_Tbl_PRS_ProjectTypes_accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + m_strWeekEndDate + "'"
        End If

        ObjProjectTypeDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'Draw the Main Div

        Response.Write("<Div id=DivMain name=DivMain style='Overflow:auto;width:99.99%;Height:600px'>")

        ' Draw The Container Table To show two project types in one row
        Response.Write("<table id=TableMain name=TableMain class='clsTable' width=100% Height=50% cellpadding=0 cellspacing=10 >" + vbCrLf)


        While ObjProjectTypeDr.Read

            strProjectTypeID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectTypeDr("ProjectTypeID"), ""), "")
            strProjectType = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectTypeDr("ProjectType"), ""), "")
            strDashboardId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectTypeDr("DashboardID"), ""), "")

            If ProjectTypeCount Mod 2 = 0 Then

                Response.Write("<tr class='clsTREven'>")
                Response.Write("<td width=45% align=left valign=top>")
                ProjectTypeCount += 1
            Else
                Response.Write("<td width=45% align=left valign=top>")
                ProjectTypeCount += 1
            End If


            ' Select the Metric Details for the selected Month else for the current month
            'RathinP on 28-June-2007
            ' To Set the EndDate of the Week
            If strMetricView.ToUpper = "MONTHLY" Then
                strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProjectType '" + m_strMonthEndDate + "' , '" + strProjectType + "', '" + m_strProjectFilters + "' "
            ElseIf strMetricView.ToUpper = "WEEKLY" Then
                strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProjectType '" + m_strWeekEndDate + "' , '" + strProjectType + "', '" + m_strProjectFilters + "' "
            End If

            objMetricDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

            'CommonFunction.General.WriteHTML("<A href = '../MetricDB/MetricDB_View.aspx?MODE=4&ProjectTypeID=" + strProjectTypeID + "' style='COLOR:#ff9100' > <img height=8 alt='View " + strProjectType + " Projects Trends' src = '../MetricDB/images/trends.gif' width=19 border=0> View Trends</A> <BR> <BR> ")


            ' Draw Metric Table 
            Response.Write("<table id=TableMetric name=TableMetric class='clsGridTable' width=100%  cellpadding=1 cellspacing=1 border=1 > ")

            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=center colspan=4>" + strProjectType + " Projects</TD>")
            Response.Write("<TD align=right> <A href = 'javascript:showProjectTypeTrend(" + strDashboardId + ")' style='COLOR:#ff9100' > <img height=8 alt='View " + strProjectType + " Projects Trends' src = '../Metrics/images/trends.gif' width=19 border=0> View Trends</A></TD>")

            Response.Write("</TR>" + vbCrLf)

            ' Draw Header Row 
            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=left width=20%>Category</TD>")
            Response.Write("<TD align=left width=50%>Metric</TD>")
            Response.Write("<TD align=right width=10%>UCL</TD>")
            Response.Write("<TD align=right width=10%>LCL</TD>")
            Response.Write("<TD align=right width=10%>Data</TD>")
            Response.Write("</TR>" + vbCrLf)
            blnHeaderPlotted = True

            While objMetricDr.Read

                ' Draw the Data 


                If strCategory <> CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Category"), ""), "") Then
                    strCategory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Category"), ""), "")
                    Response.Write("<TR class='clsTROdd'>")
                    Response.Write("<TD align=left colspan=7> <B>" + strCategory + " </B> </TD>")
                    Response.Write("</TR><TR class='clsTROdd'>")
                Else
                    Response.Write("<TR class='clsTROdd'>")
                    Response.Write("<TD align=left >&nbsp;</TD>")
                End If

                Response.Write("<TD align=left >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Metric"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("UCL"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("LCL"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right style='BACKGROUND-COLOR:" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("COLOR"), ""), "") + "' >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Data"), "&nbsp;"), "&nbsp;") + "</TD>")
                Response.Write("</TR>" + vbCrLf)

            End While

            CommonFunction.Data.DisposeDataReader(objMetricDr)

            ' Close Table 
            Response.Write("</table>")


            If ProjectTypeCount Mod 2 = 0 Then
                Response.Write("</td>")
                Response.Write("</tr>" + vbCrLf)
            Else
                Response.Write("</td>")
            End If


        End While
        ' Dispose Data Reader
        CommonFunction.Data.DisposeDataReader(ObjProjectTypeDr)

        ' No Record Found 
        If ProjectTypeCount = 0 Then
            Response.Write("<table id=TableNoData name=TableNoData class='clsTable' width=100%> ")
            Response.Write("<tr class=clsTREven> <TD align=center height=10 valign=top>" + MyBase.GetResourceString("MSG_NO_DATA") + "</td> </tr></table>")
        End If
        ' Close the Outer Table 
        If ProjectTypeCount Mod 2 <> 0 Then
            'Response.Write("<td>&nbsp;</td>")
            Response.Write("</tr>" + vbCrLf)
        End If

        Response.Write("</Table>")
        ' Close DivMain
        Response.Write("</Div>")
        ' Draw a consolidated view for Current Month for each Project Type

        '' Draw the Month Links 
        'Response.Write("<table id=TableLink name=TableLink class='clsTable' width=100%>" + vbCrLf)
        'Response.Write("<TR class='clsTROdd'>")
        'Response.Write("<TD align=left >" + "<A href='../MetricDB/MetricDB_View.aspx?MODE=1&MonthValue=-1&Month=" + IIf(m_intMonth = "1", "12", CType(m_intMonth, Integer) - 1).ToString + "&Year=" + IIf(m_intMonth = "1", CType(m_intYear, Integer) - 1, m_intYear).ToString + "' style='COLOR:#ff9100'> Previous Month </A> " + "</TD>")
        'Response.Write("<TD align=right >" + "<A href='../MetricDB/MetricDB_View.aspx?MODE=1&MonthValue=1&Month=" + IIf(m_intMonth = "12", "1", CType(m_intMonth, Integer) + 1).ToString + "&Year=" + IIf(m_intMonth = "12", CType(m_intYear, Integer) + 1, m_intYear).ToString + "' style='COLOR:#ff9100'> Next Month </A> " + "</TD>")
        'Response.Write("</tr>" + vbCrLf)
        'Response.Write("</Table>")
    End Sub

    Private Sub ShowProjectView()
        '====================================================================
        ' Procedure Name        :  ShowProjectView
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Show the Summary of Metrics and Data Points for Projects 
        ' Description           :  This sub-routine Shows the Summary of Metrics and Data Points for Project 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  NitinVS 
        ' Created               :  28 Nov 2005 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String
        Dim ObjProjectDr As IDataReader
        Dim objMetricDr As IDataReader
        Dim strProjectID As String
        Dim ProjectName As String
        Dim strDashboardId As String
        Dim ProjectCount As Integer = 0
        Dim blnHeaderPlotted As Boolean = False
        Dim strCategory As String = ""
        Select Case (strMetricView.ToUpper)

            Case "MONTHLY"
                If m_LoginType = "C" Then
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + "/ Month - " + m_strMonthName + " '" + m_intYear, , )
                Else
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + "/ Month - " + m_strMonthName + " '" + m_intYear, , )
                End If
                'Added By RathinP On 26-June-2007
                ' To Integrate Weekly View
            Case "WEEKLY"
                strWeekStartDate = CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate('" + m_dtReportDate + "')  ", MyBase.UseSQL)
                strWeekEndDate = CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate('" + m_dtReportDate + "')+6  ", MyBase.UseSQL)
                If m_LoginType = "C" Then
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + " From " + CType(strWeekStartDate, Date).ToString("dd-MMM-yyyy") + " To " + CType(strWeekStartDate, DateTime).AddDays(6).ToString("dd-MMM-yyyy"), , )
                Else
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + " From " + CType(strWeekStartDate, Date).ToString("dd-MMM-yyyy") + " To " + CType(strWeekStartDate, DateTime).AddDays(6).ToString("dd-MMM-yyyy"), , )
                End If
                'End of Addition By RathinP 
        End Select

        ' Draw The Header Information 

        ' Get the project Types accessible to the currently logged in user
        'RathinP on 28-June-2007
        ' To Set the EndDate of the Week
        If strMetricView.ToUpper = "MONTHLY" Then
            strSQL = "usp_sel_Tbl_MET_Project_Accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + m_strMonthEndDate + "'" + "," + Session("intProjectID").ToString
        ElseIf strMetricView.ToUpper = "WEEKLY" Then
            strSQL = "usp_sel_Tbl_MET_Project_Accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + m_strWeekEndDate + "'" + "," + Session("intProjectID").ToString
        End If

        ObjProjectDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        'Draw the Main Div

        Response.Write("<Div id=DivMain name=DivMain style='Overflow:auto;width:99.99%;Height:600px'>")

        ' Draw The Container Table To show two project types in one row
        Response.Write("<table id=TableMain name=TableMain class='clsTable' width=100% Height=50% cellpadding=0 cellspacing=10 >" + vbCrLf)


        While ObjProjectDr.Read

            strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectDr("ProjectID"), ""), "")
            ProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectDr("ProjectName"), ""), "")

            If ProjectCount Mod 2 = 0 Then

                Response.Write("<tr class='clsTREven'>")
                Response.Write("<td width=45% align=left valign=top>")
                ProjectCount += 1
            Else
                Response.Write("<td width=45% align=left valign=top>")
                ProjectCount += 1
            End If


            ' Select the Metric Details for the selected Month else for the current month
            'RathinP on 28-June-2007
            ' To Set the EndDate of the Week
            If strMetricView.ToUpper = "MONTHLY" Then
                strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject '" + m_strMonthEndDate + "' , '" + strProjectID + "', '" + m_strProjectFilters + "' "
            ElseIf strMetricView.ToUpper = "WEEKLY" Then
                strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject '" + m_strWeekEndDate + "' , '" + strProjectID + "', '" + m_strProjectFilters + "' "
            End If
            objMetricDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


            ' Draw Metric Table 
            Response.Write("<table id=TableMetric name=TableMetric class='clsTable' width=100%  cellpadding=1 cellspacing=1 border=1 style='border-color:transparent '> ")

            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=center colspan=4> Project " + ProjectName + " </TD>")
            Response.Write("<TD align=right> <A href = 'javascript:showProjectTrend(" + strProjectID + ")' style='COLOR:#ff9100' > <img height=8 alt='View Project " + ProjectName + " Trends' src = '../Metrics/images/trends.gif' width=19 border=0> View Trends</A></TD>")

            Response.Write("</TR>" + vbCrLf)

            ' Draw Header Row 
            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=left width=20%>Category</TD>")
            Response.Write("<TD align=left width=50%>Metric</TD>")
            Response.Write("<TD align=right width=10%>UCL</TD>")
            Response.Write("<TD align=right width=10%>LCL</TD>")
            Response.Write("<TD align=right width=10%>Data</TD>")
            Response.Write("</TR>" + vbCrLf)
            blnHeaderPlotted = True

            While objMetricDr.Read

                ' Draw the Data 
                Response.Write("<TR class='clsTROdd'>")

                If strCategory <> CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Category"), ""), "") Then
                    strCategory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Category"), ""), "")

                    Response.Write("<TD align=left > <B>" + strCategory + " </B> </TD>")
                Else
                    Response.Write("<TD align=left >&nbsp;</TD>")
                End If

                Response.Write("<TD align=left >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Metric"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("UCL"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("LCL"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right style='BACKGROUND-COLOR:" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("COLOR"), ""), "") + "' >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Data"), "&nbsp;"), "&nbsp;") + "</TD>")
                Response.Write("</TR>" + vbCrLf)

            End While

            CommonFunction.Data.DisposeDataReader(objMetricDr)
            ' Close Table 
            Response.Write("</table>")


            If ProjectCount Mod 2 = 0 Then
                Response.Write("</td>")
                Response.Write("</tr>" + vbCrLf)
            Else
                Response.Write("</td>")
            End If


        End While
        ' Dispose Data Reader
        CommonFunction.Data.DisposeDataReader(ObjProjectDr)

        ' No Record Found 
        If ProjectCount = 0 Then
            Response.Write("<table id=TableNoData name=TableNoData class='clsTable' width=100%> ")
            Response.Write("<tr class=clsTREven> <TD align=center height=10 valign=top>" + MyBase.GetResourceString("MSG_NO_DATA") + "</td> </tr>")
        End If

        ' Close the Outer Table 
        If ProjectCount Mod 2 <> 0 Then
            'Response.Write("<td>&nbsp;</td>")
            Response.Write("</tr>" + vbCrLf)
        End If

        Response.Write("</Table>")
        ' Close DivMain


        Response.Write("</Div>")
        ' Draw a consolidated view for Current Month for each Project Type

        '' Draw the Month Links 
        'Response.Write("<table id=TableLink name=TableLink class='clsTable' width=100%>" + vbCrLf)
        'Response.Write("<TR class='clsTROdd'>")
        'Response.Write("<TD align=left >" + "<A href='../MetricDB/MetricDB_View.aspx?MODE=3&MonthValue=-1&Month=" + IIf(m_intMonth = "1", "12", CType(m_intMonth, Integer) - 1).ToString + "&Year=" + IIf(m_intMonth = "1", CType(m_intYear, Integer) - 1, m_intYear).ToString + "' style='COLOR:#ff9100'> Previous Month </A> " + "</TD>")
        'Response.Write("<TD align=right >" + "<A href='../MetricDB/MetricDB_View.aspx?MODE=3&MonthValue=1&Month=" + IIf(m_intMonth = "12", "1", CType(m_intMonth, Integer) + 1).ToString + "&Year=" + IIf(m_intMonth = "12", CType(m_intYear, Integer) + 1, m_intYear).ToString + "' style='COLOR:#ff9100'> Next Month </A> " + "</TD>")
        'Response.Write("</tr>" + vbCrLf)
        'Response.Write("</Table>")
    End Sub

    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : To plot the Menu on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 30 Nov 2005
        ' Revisions             :
        '=====================================================================

        Dim arrMenuCaptionsList As New ArrayList
        Dim arrMenuToolTipsList As New ArrayList
        Dim arrClientSideFunctionList As New ArrayList
        Dim strMenu As String                           'Used to store the Menu List as HTML
        Dim strPaging As String
        Dim strSQL As String

        If m_FromGenerator = 0 Then
            'strMetricView = CommonFunctions.Data.GetDataScalar(" SELECT DBO.UDF_Get_TBL_PRS_FREQUENCYTYPES()  ", MyBase.UseSQL)
            Select Case (strMetricView.ToUpper)
                Case "MONTHLY"

                    arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_PREVIOUS_MONTH"), "?"))
                    arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_PREVIOUS_MONTH_TOOLTIP"), "Help"))
                    arrClientSideFunctionList.Add(" MoveToMonth(" + IIf(m_intMonth = "1", "12", CType(m_intMonth, Integer) - 1).ToString + "," + IIf(m_intMonth = "1", CType(m_intYear, Integer) - 1, m_intYear).ToString + "," + m_PageMode + ",-1 )")

                    ' if the current month is report month then do not plot the next menu link 
                    If Not (m_dtReportDate.Month = Date.Today.Month And m_dtReportDate.Year = Date.Today.Year) Then

                        arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_NEXT_MONTH"), "?"))
                        arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_NEXT_MONTH_TOOLTIP"), "Help"))
                        arrClientSideFunctionList.Add("MoveToMonth(" + IIf(m_intMonth = "12", "1", CType(m_intMonth, Integer) + 1).ToString + "," + IIf(m_intMonth = "12", CType(m_intYear, Integer) + 1, m_intYear).ToString + "," + m_PageMode + ",1 )")
                    End If

                    'Added By RathinP On 26-June-2007
                    ' To Integrate Weekly View
                Case "WEEKLY"
                    arrMenuCaptionsList.Add("Previous Week")
                    arrMenuToolTipsList.Add("Previous Week")
                    arrClientSideFunctionList.Add(" MoveToWeek(" + IIf(m_intMonth = "1", "12", CType(m_intMonth, Integer) - 1).ToString + "," + IIf(m_intMonth = "1", CType(m_intYear, Integer) - 1, m_intYear).ToString + "," + m_PageMode + ",-1,-1 )")

                    ' if the current month is report month then do not plot the next menu link 
                    Dim IsWeekBetweenDate As Boolean
                    IsWeekBetweenDate = CommonFunctions.Data.GetDataScalar(" usp_Get_WeekDetails_DashBoardDB '" + m_strMonthEndDate + "'", MyBase.UseSQL)
                    'If Not (m_dtReportDate.Month = Date.Today.Month And m_dtReportDate.Year = Date.Today.Year) Then
                    If IsWeekBetweenDate = 0 Then
                        arrMenuCaptionsList.Add("Next Week")
                        arrMenuToolTipsList.Add("Next Week")
                        arrClientSideFunctionList.Add("MoveToWeek(" + IIf(m_intMonth = "12", "1", CType(m_intMonth, Integer) + 1).ToString + "," + IIf(m_intMonth = "12", CType(m_intYear, Integer) + 1, m_intYear).ToString + "," + m_PageMode + ",1,1 )")
                    End If
                    'End of Addition By RathinP 

            End Select
            arrMenuCaptionsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_HELP"), "?"))
            arrMenuToolTipsList.Add(CommonFunctions.General.CheckIsNothing(MyBase.GetResourceString("MENU_HELP_TOOLTIP"), "Help"))
            arrClientSideFunctionList.Add("OpenHelpPage('2163')")

            m_objMenu = New WebPages.Template.StaticMenu
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
            CommonFunctions.General.WriteHTML(strMenu)

        ElseIf m_FromGenerator = 1 Then
            arrMenuCaptionsList.Add("Close")
            arrMenuToolTipsList.Add("Close")
            arrClientSideFunctionList.Add("ClosePage()")
            m_objMenu = New WebPages.Template.StaticMenu
            strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuCaptionsList), GetArray(arrClientSideFunctionList), GetArray(arrMenuToolTipsList), True)
            CommonFunctions.General.WriteHTML(strMenu)

        End If
    End Sub

#End Region

    Public Sub New()

        ''Commented and Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        '  MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 
        MyBase.InitializeResources("AppResourcePPM.MetricDB_View", "AppResourcePPM")
    End Sub

    Private Sub objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles objGrid.Table_BeforePrint
        Args.TableStyle = "border=1 cellspacing=2 cellpadding=2"
    End Sub
    Public Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : HarshK
        ' Created               : 04/10/2005
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements
    End Function
    Private Sub ShowGeneratorView()
        '====================================================================
        ' Procedure Name        :  ShowGeneratorView
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To Show the Summary of Metrics and Data Points for Projects 
        ' Description           :  This sub-routine Shows the Summary of Metrics and Data Points for Project 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  SrikanthY
        ' Created               :  12 Jul 2007 
        ' Revisions             :  
        '=====================================================================
        Dim strSQL As String
        Dim ObjProjectDr As IDataReader
        Dim objMetricDr As IDataReader
        Dim strProjectID As String
        Dim ProjectName As String
        Dim strDashboardId As String
        Dim ProjectCount As Integer = 0
        Dim blnHeaderPlotted As Boolean = False
        Dim strCategory As String = ""

        Dim strMonthName As String
        Dim strdtReportDate As String
        Dim strMonthEndDate As String
        Dim strWeekSDate As String
        Dim strWeekEDate As String
        strdtReportDate = CType(HttpContext.Current.Request.QueryString("SnapShotDate"), String)
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''Response.Write(CommonFunction.HTMLControls.DrawTextBox("strSnapShotDate", "strSnapShotDate", , , , strdtReportDate, IsHidden:=True, returnHTML:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("strSnapShotDate", "strSnapShotDate", , , , strdtReportDate, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015
        If strdtReportDate = "" Then
            strdtReportDate = CType(HttpContext.Current.Request.Form("strSnapShotDate"), String)
        End If

        'm_strMonthEndDate = CType(Date.Today.AddDays(Date.Today.DaysInMonth(Date.Today.Year, Date.Today.Month) - Date.Today.Day), String)
        'm_intMonth = Date.Today.Month
        'm_intYear = Date.Today.Year
        '' m_dtReportDate = m_strMonthEndDate

        Select Case (strMetricView.ToUpper)
            Case "MONTHLY"
                strMonthName = CommonFunction.Data.GetDataScalar("SELECT DateName( month , '" + strdtReportDate + "') ", MyBase.UseSQL)
                strMonthEndDate = strdtReportDate
                If m_LoginType = "C" Then
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + "/ Month - " + strMonthName + " '" + m_intYear, , )
                Else
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + "/ Month - " + strMonthName + " '" + m_intYear, , )
                End If
            Case "WEEKLY"
                strWeekSDate = CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate('" + strdtReportDate + "')  ", MyBase.UseSQL)
                strWeekEDate = CommonFunctions.Data.GetDataScalar("Select dbo.udf_getCurrentWeek_For_SpecifiedDate('" + strdtReportDate + "')+6  ", MyBase.UseSQL)
                If m_LoginType = "C" Then
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + " From " + CType(strWeekSDate, Date).ToString("dd-MMM-yyyy") + " To " + CType(strWeekSDate, DateTime).AddDays(6).ToString("dd-MMM-yyyy"), , )
                Else
                    WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_VIEW") + " From " + CType(strWeekSDate, Date).ToString("dd-MMM-yyyy") + " To " + CType(strWeekSDate, DateTime).AddDays(6).ToString("dd-MMM-yyyy"), , )
                End If
        End Select

        If strMetricView.ToUpper = "MONTHLY" Then
            strSQL = "usp_sel_Tbl_MET_Project_Accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + strMonthEndDate + "'" + "," + Session("intProjectId").ToString
        ElseIf strMetricView.ToUpper = "WEEKLY" Then
            strSQL = "usp_sel_Tbl_MET_Project_Accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + strWeekEDate + "'" + "," + Session("intProjectId").ToString
        End If

        ObjProjectDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        Response.Write("<Div id=DivPage name=DivPage style='Overflow:auto;width:100%;Height:620px'>")
        Response.Write("<TABLE id=""tblMT""  cellspacing=0 cellpadding=0 Width=""99.9%""  class=clsTable border width=""2""><TR class=clsTRPageCaption><TD align=Left><B> Metric Details </B> </TD>")
        ' Added by Archanan on 8-Apr-2010
        Response.Write("<TD align=right >" + "<A href='javascript:ExportToExcel(" + IIf(m_intMonth = "1", "12", CType(m_intMonth, Integer) - 1).ToString + "," + IIf(m_intMonth = "1", CType(m_intYear, Integer) - 1, m_intYear).ToString + "," + m_PageMode + ",-1,-1,""Metric"")'><FONT color=blue>Export To Excel</font> </A> " + "</TD>")
        ' End of Added by Archanan on 8-Apr-2010
       
        Response.Write("</tr></table>")

        'Response.Write("<Div id=DivMain name=DivMain style='Overflow:auto;width:99.99%;Height:600px'>")
        Response.Write("<DIV id='DivMetrics' style='Overflow:auto;width:100%;height=40%'>")
        Response.Write("<table id=TableMain name=TableMain class='clsTable' width=100% Height=50% cellpadding=0 cellspacing=10 >" + vbCrLf)


        While ObjProjectDr.Read

            strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectDr("ProjectID"), ""), "")
            ProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectDr("ProjectName"), ""), "")

            If ProjectCount Mod 2 = 0 Then

                Response.Write("<tr class='clsTREven'>")
                Response.Write("<td width=45% align=left valign=top>")
                ProjectCount += 1
            Else
                Response.Write("<td width=45% align=left valign=top>")
                ProjectCount += 1
            End If
            'Commented and Added by ArchanaN on 9-Apr-2010
            ''If strMetricView.ToUpper = "MONTHLY" Then
            ''    strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject '" + strMonthEndDate + "' , '" + strProjectID + "', '" + m_strProjectFilters + "' "
            ''ElseIf strMetricView.ToUpper = "WEEKLY" Then
            ''    strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject '" + strWeekEDate + "' , '" + strProjectID + "', '" + m_strProjectFilters + "' "
            ''End If
            If strMetricView.ToUpper = "MONTHLY" Then
                strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject '" + strMonthEndDate + "' , '" + strProjectID + "'"
            ElseIf strMetricView.ToUpper = "WEEKLY" Then
                strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject '" + strWeekEDate + "' , '" + strProjectID + "'"
            End If
            'End Commented and Added by ArchanaN on 9-Apr-2010

            'Added by ArchanaN on 6-Apr-2010
            If UCase(Trim(Request.QueryString("Action") & "") & "") = "EXPORT" And UCase(Trim(Request.QueryString("Type") & "") & "") = "METRIC" Then
                If strMetricView.ToUpper = "MONTHLY" Then
                    strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject_Export '" + strMonthEndDate + "' , '" + strProjectID + "'"
                ElseIf strMetricView.ToUpper = "WEEKLY" Then
                    strSQL = " EXEC  usp_Sel_Tbl_PRS_MetricHistory_forProject_Export '" + strWeekEDate + "' , '" + strProjectID + "'"
                End If
                GenerateReport(strSQL, "")
                Exit Sub
            End If
            'End of Added by ArchanaN on 6-Apr-2010


            objMetricDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)


            ' Draw Metric Table 
            Response.Write("<table id=TableMetric name=TableMetric class='clsGridTable' width=100%  cellpadding=0 cellspacing=1 border=0 style='border-color:transparent '> ")

            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=center colspan=8><B> " + ProjectName + " </B></TD>")
            Response.Write("</TR>" + vbCrLf)

            ' Draw Header Row 
            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=left width=20%>Category</TD>")
            Response.Write("<TD align=left width=38%>Metric</TD>")
            'Response.Write("<TD align=right width=7%>UCL</TD>")
            'Response.Write("<TD align=right width=7%>LCL</TD>")
            ' Added by Archanan on 8-Apr-2010
            Response.Write("<TD align=right width=7%>Target</TD>")
            Response.Write("<TD align=right width=7%>USL</TD>")
            Response.Write("<TD align=right width=7%>LSL</TD>")
            ' End of Added by Archanan on 8-Apr-2010
            Response.Write("<TD align=right width=7%>Value</TD>")
            Response.Write("<TD align=right width=7%>Unit</TD>")

            Response.Write("</TR>" + vbCrLf)
            blnHeaderPlotted = True

            While objMetricDr.Read

                If strCategory <> CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Category"), ""), "") Then
                    strCategory = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Category"), ""), "")
                    Response.Write("<TR class='clsTROdd'>")
                    Response.Write("<TD align=left colspan=8><B>" + strCategory + "</B></TD>")
                    Response.Write("</TR><TR class='clsTROdd'><TD align=left >&nbsp;</TD>")
                Else
                    Response.Write("<TR class='clsTROdd'>")
                    Response.Write("<TD align=left >&nbsp;</TD>")
                End If

                Response.Write("<TD align=left >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Metric"), "&nbsp;"), "") + "</TD>")
                'Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("UCL"), "&nbsp;"), "") + "</TD>")
                'Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("LCL"), "&nbsp;"), "") + "</TD>")
                ' Added by Archanan on 8-Apr-2010
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Target"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("USL"), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("LSL"), "&nbsp;"), "") + "</TD>")
                ' End Added by Archanan on 8-Apr-2010
                Response.Write("<TD align=right style='BACKGROUND-COLOR:" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("COLOR"), ""), "") + "' >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("Data"), "&nbsp;"), "&nbsp;") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr("UnitName"), "&nbsp;"), "") + "</TD>")
                Response.Write("</TR>" + vbCrLf)

            End While

            CommonFunction.Data.DisposeDataReader(objMetricDr)
            ' Close Table 
            Response.Write("</table>")


            If ProjectCount Mod 2 = 0 Then
                Response.Write("</td>")
                Response.Write("</tr>" + vbCrLf)
            Else
                Response.Write("</td>")
            End If


        End While
        CommonFunction.Data.DisposeDataReader(ObjProjectDr)

        If ProjectCount = 0 Then
            Response.Write("<table id=TableNoData name=TableNoData class='clsTable' width=100%> ")
            Response.Write("<tr class=clsTREven> <TD align=center height=10 valign=top>" + MyBase.GetResourceString("MSG_NO_DATA") + "</td> </tr>")
        End If

        If ProjectCount Mod 2 <> 0 Then
            Response.Write("</tr>" + vbCrLf)
        End If

        Response.Write("</Table>")
        Response.Write("</Div>")
        Response.Write("<TABLE id=""tblDP""  cellspacing=0 cellpadding=0 Width=""99.9%""  class=clsTable border width=""2""><TR class=clsTRPageCaption><TD align=Left><B> Datapoint Details </B> </TD>")
        ' Added by Archanan on 8-Apr-2010
        Response.Write("<TD align=right >" + "<A href='javascript:ExportToExcel(" + IIf(m_intMonth = "1", "12", CType(m_intMonth, Integer) - 1).ToString + "," + IIf(m_intMonth = "1", CType(m_intYear, Integer) - 1, m_intYear).ToString + "," + m_PageMode + ",-1,-1,""DataPoint"")' ><FONT color=blue>Export To Excel </Font></A> " + "</TD>")
        Response.Write("</tr></table>")
        ' End Added by Archanan on 8-Apr-2010
        If strMetricView.ToUpper = "MONTHLY" Then
            strSQL = "usp_sel_Tbl_MET_Project_Accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + strMonthEndDate + "'," + Session("intProjectId").ToString
        ElseIf strMetricView.ToUpper = "WEEKLY" Then
            strSQL = "usp_sel_Tbl_MET_Project_Accessible " + m_LoginId + " , '" + m_LoginType + "' ,'" + m_strProjectFilters + "' , '" + strWeekEDate + "'," + Session("intProjectId").ToString
        End If

        ObjProjectDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        Response.Write("<DIV id='DivDatapoints' style='Overflow:auto;width:100%;height=60%'>")
        Response.Write("<table id=TableSub name=TableSub class='clsTable' width=100% Height=50% cellpadding=0 cellspacing=10 >" + vbCrLf)
        While ObjProjectDr.Read
            strProjectID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectDr("ProjectID"), ""), "")
            ProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ObjProjectDr("ProjectName"), ""), "")
            If ProjectCount Mod 2 = 0 Then
                Response.Write("<tr class='clsTREven'>")
                Response.Write("<td width=45% align=left valign=top>")
                ProjectCount += 1
            Else
                Response.Write("<td width=45% align=left valign=top>")
                ProjectCount += 1
            End If
            If strMetricView.ToUpper = "MONTHLY" Then
                strSQL = " EXEC  usp_sel_tbl_PRS_Measurements_For_DBView '" + strProjectID + "' , '" + strMonthEndDate + "'"
            ElseIf strMetricView.ToUpper = "WEEKLY" Then
                strSQL = " EXEC  usp_sel_tbl_PRS_Measurements_For_DBView '" + strProjectID + "' , '" + strWeekEDate + "' "
            End If


            'Added by ArchanaN on 6-Apr-2010
            If UCase(Trim(Request.QueryString("Action") & "") & "") = "EXPORT" And UCase(Trim(Request.QueryString("Type") & "") & "") = "DATAPOINT" Then
                If strMetricView.ToUpper = "MONTHLY" Then
                    strSQL = " EXEC  usp_sel_tbl_PRS_Measurements_For_DBView_Export '" + strProjectID + "' , '" + strMonthEndDate + "'"
                ElseIf strMetricView.ToUpper = "WEEKLY" Then
                    strSQL = " EXEC  usp_sel_tbl_PRS_Measurements_For_DBView_Export '" + strProjectID + "' , '" + strWeekEDate + "' "
                End If
                GenerateReport(strSQL, "")
                Exit Sub
            End If
            'End of Added by ArchanaN on 6-Apr-2010



            objMetricDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            ' Draw DP Table 
            Response.Write("<table id=TableDP name=TableDP class='clsGridTable' width=100%  cellpadding=0 cellspacing=1 border=0 style='border-color:transparent '> ")

            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=center colspan=3><B> " + ProjectName + " </B></TD>")
            Response.Write("</TR>" + vbCrLf)
            '  Draw Header Row 
            Response.Write("<TR class='clsTRColumnHeader'>")
            Response.Write("<TD align=left width=25%>Datapoint</TD>")
            Response.Write("<TD align=left width=50%>Guidelines</TD>")
            Response.Write("<TD align=right width=25%>Value</TD>")
            Response.Write("</TR>" + vbCrLf)
            blnHeaderPlotted = True
            While objMetricDr.Read
                Response.Write("<TR class='clsTROdd'>")
                Response.Write("<TD align=left >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr(5), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr(2), "&nbsp;"), "") + "</TD>")
                Response.Write("<TD align=right >" + CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(objMetricDr(3), "&nbsp;"), "") + "</TD>")
                Response.Write("</TR>" + vbCrLf)

            End While
            CommonFunction.Data.DisposeDataReader(objMetricDr)
            Response.Write("</table>")
        End While
        CommonFunction.Data.DisposeDataReader(ObjProjectDr)

        If ProjectCount = 0 Then
            Response.Write("<table id=TableNoData name=TableNoData class='clsGridTable' width=100%> ")
            Response.Write("<tr class=clsTREven> <TD align=center height=10 valign=top>" + MyBase.GetResourceString("MSG_NO_DATA") + "</td> </tr>")
        End If

        If ProjectCount Mod 2 <> 0 Then
            Response.Write("</tr>" + vbCrLf)
        End If

        Response.Write("</Table>")
        Response.Write("</Div>")
        Response.Write("</Div>")
    End Sub

    Private Sub GenerateReport(ByVal SQL As String, ByVal Title As String)
        '=====================================================================
        ' Procedure Name        : GenerateReport()
        ' Purpose               : To generate the report for the Tag/Sub Tag
        ' Description           : 
        ' Parameters Passed     : SQL, Title of the report
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : DynamicReports.dll
        ' Author                : Archanan
        ' Created               : 6-Apr-2010
        ' Revisions             :
        ' Req. No.              :  
        '=====================================================================
        Dim strFormat As String = ""
        Dim strFilePath As String = ""
        'Dim dr As IDataReader

        strFormat = UCase(Trim(Request.QueryString("Format") & "") & "")
        Report = New DynamicReports.Report


        ' dr = CommonFunctions.Data.GetDataReader(SQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), CommonFunctions.Application.ConnectionString)
        ' If dr.Read Then
        ' The reports are created in the "Reports" folder
        strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))
        ' get a unique file name
        m_strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
        ' add extn to file name based on format requested
        Select Case strFormat
            Case "PDF" : m_strFileName += ".pdf"
            Case "HTML" : m_strFileName += ".htm"
            Case "RTF" : m_strFileName += ".rtf"
            Case "EXCEL" : m_strFileName += ".xls"
            Case "CSV" : m_strFileName += ".csv"
            Case "TEXT" : m_strFileName += ".txt"
            Case "XML" : m_strFileName += ".xml"
            Case Else : m_strFileName += ".pdf"
        End Select

        With Report
            .CompanyName = CommonFunctions.Application.CompanyName
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .DateFormat = CInt(CommonFunctions.Application.DateFormatID)
            .EmptyValueReplacement = " "
            .ErrorLogFilePathName = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/"))
            .FilePathName = Trim(strFilePath & "") & m_strFileName
            .FontName = "Arial"
            .LogoPathName = Server.MapPath("../../Images/") & "CustomerLogo.gif"

            ' Set the tag/sub-tag specific SQL and Title
            .SQLSource = SQL
            .Title = Title

            .UseMSSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

            Select Case strFormat
                Case "PDF" : .GenerateReport(DynamicReports.Format.PDF)
                Case "HTML" : .GenerateReport(DynamicReports.Format.HTML)
                Case "RTF" : .GenerateReport(DynamicReports.Format.RTF)
                Case "EXCEL" : .GenerateReport(DynamicReports.Format.EXCEL)
                Case "CSV" : .GenerateReport(DynamicReports.Format.CSV)
                Case "TEXT" : .GenerateReport(DynamicReports.Format.TEXT)
                Case "XML" : .GenerateReport(DynamicReports.Format.XML)
                Case Else : .GenerateReport(DynamicReports.Format.PDF)
            End Select
        End With

        '  Else
        'no data present..show the msg to the user
        ' m_bytShowMessage = NO_DATA_PRESENT
        '  m_strDXUFileName = CommonFunction.Data.GetDataScalar("select SystemFileName from tbl_DXU_Attachments Where TemplateID =  " & m_lngTemplateID.ToString, True)
        'Response.Redirect("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=" + m_strDXUFileName, True)
        ' End If
        Response.Redirect("../CRW/CRW_ReportOutput.aspx?filename=" + m_strFileName, True)
        ' CommonFunctions.Data.DisposeDataReader(dr)
        Report = Nothing

    End Sub
End Class
