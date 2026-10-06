Imports Whizible
Partial Public Class MetricsCrossTabGridReport
    Inherits WebPages.Template.WhizTemplate

#Region "Member Variables"
    Protected m_strUserName As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected m_dsCrossTabReport As DataSet
    Protected m_dsGroupReport As DataSet
    ' Protected m_dsCrossTabRecordCount As DataSet
    Protected m_intCTReportID As Integer = 0
    Protected WithEvents m_objCrossTabReportGrid As New WebPages.Template.AdvancedGrid
    Private WithEvents objReport As DynamicReports.Report
    Protected m_strUserID As String = "0"
    Protected m_strFileName As String = ""
    Dim m_strSource As String = ""
    Dim m_strAttribute As String = ""
    Dim m_strYAxis As String = ""
    Dim m_strXAxis As String = ""
    Dim m_strCTReportTitle As String = ""
    Dim m_strFormula As String = ""
    Dim m_strEntityType As String = ""
    Dim m_strDetailQuery As String = ""
    Dim m_strWhereClause As String = ""
    Protected m_strMode As String = ""
    Protected m_strAction As String = ""
    Protected m_intShowMessage As Integer = 0
    Protected m_strDQYAxis As String = ""
    Protected m_strDQXAxis As String = ""
    Protected m_strSQL As String = ""
    Protected m_strXAxisFilterString As String = ""
    Protected m_strYAxisFilterString As String = ""

    Protected m_strXAxisFilter As String = ""
    Protected m_strYAxisFilter As String = ""
    Protected m_strGroupReportID As String = ""
    Protected m_strEmployeeFilterOn As String = ""

    Protected m_PageSize As Integer = CommonFunction.Application.MaximumItemsToShowInList
    Protected m_curIndex As Integer = 1
    Protected m_curPageNumber As Integer = 1
    Protected m_NoOfpages As Integer
    Protected m_intTotalRow As Integer


    Protected m_blnIsFYDriven As Boolean = False
    ' Added By NitinVS on 9 Apr 2009 To Financial Period Navigation based on FinancialType 
    Protected m_FinancialType As String = "Y"
    Protected m_StartDate As String = ""
    Protected m_EndDate As String = ""

    Dim strCurrentFYTitle As String
    Dim strPreviousFYTitle As String
    Dim strNextFYTitle As String
    ' End Addition By NitinVS on 9 Apr 2009 To Financial Period Navigation based on FinancialType 
    Protected m_strFYPeriod As String = "0"
    Protected m_strFromWhere As String = ""
    Protected m_GraphNomencleture As String = ""
    Protected m_strProjectID As String = ""
    Protected m_strXAxisOrderBy As String = ""
    Protected m_strYAxisOrderBy As String = ""
    Protected m_strShowEvenReleaseFromProject As String = "1"
    Protected m_strLoginID As String = "0"
    Protected strLoginType As String = "E"

    Protected m_strFixedColumns As String = ""

    'Protected m_strAction As String = ""

    'Private m_intPageNumber As Integer = 1
    'Protected m_intTotalNoOfRows As Integer
    'Protected m_PageSize As Integer = CommonFunction.Application.MaximumItemsToShowInList
    ' Dim strPaging As String = ""
    'Protected m_curIndex As Integer = 1


    'Added By Amol Changle On: 06 Apr 2009
    'Purpose: To add advanced filters for CrossTab Reports
    Private m_dsAdvancedFilters As DataSet
    'End Addition
    Protected m_blnShowBackLink As Boolean = False
    Protected m_strMenuGroupId As String = ""
    Protected m_lngProjectID As Long = 0
    Protected m_SQL As String = ""
    Protected m_PKToken As String = ""
    Protected m_QueryPKToken As String = ""
    Protected m_QueryCTReportID As String = ""
    Protected m_Querym_strFYPeriod As String = ""
    Protected tblGraphs As Global.System.Web.UI.HtmlControls.HtmlTable = New HtmlControls.HtmlTable()

#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''Added by Yogesh Jalamkar on 10-OCT-2016 Purpose:Sql injection and Cross Site Scripting
        MyBase.ApplySecurity(True)
        ''End of addition by Yogesh Jalamkar on 10-OCT-2016 

        ''Added BY Nilesh g on 1/2/2016 for url issue
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_QueryPKToken = Request.QueryString("PKToken")
        End If
        If Trim(Request.QueryString("FYPeriodID") & "") <> "" Then
            m_Querym_strFYPeriod = Request.QueryString("FYPeriodID")
        End If
        If Trim(Request.QueryString("CTReportID") & "") <> "" Then
            m_QueryCTReportID = Request.QueryString("CTReportID")
        End If
        If Request.QueryString("FYPeriodID") IsNot Nothing Then
            ''If (m_QueryPKToken <> "" And m_QueryCTReportID <> "") Then
            If (m_QueryCTReportID <> "") Then
                If (((m_QueryPKToken = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_QueryCTReportID, String) + CType(m_Querym_strFYPeriod, String) + "0" + "0", m_QueryPKToken) = False)) Then
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
            ''endded BY Nilesh g on 1/2/2016 for url issue
        End If
    End Sub
    Private Sub InitVariables()
        '=====================================================================
        ' Procedure Name        : InitVariables()
        ' Purpose               : To Initialize the Variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 22-Dec-2008
        ' Revisions             :
        '=====================================================================
        Dim drReportDetails As IDataReader
        Dim drFYTitle As IDataReader
        Dim MetricFrequency As String

        m_intCTReportID = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CTReportID"), "0"), Integer)
        m_strUserName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "")
        m_strUserName = CommonFunctions.General.BuildQueryString(m_strUserName)
        m_strUserID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0")
        m_strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode")).ToString()
        m_strAction = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action")).ToString()
        m_strShowEvenReleaseFromProject = IIf(CommonFunction.Application.ShowEvenReleaseFromProject = True, "1", "0").ToString()
        m_strLoginID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intLoginID"), "0").ToString()
        m_strFromWhere = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere")).ToString()
        strLoginType = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("strLoginType"), "E").ToString()
        If m_strFromWhere = "" Then
            m_strFromWhere = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("FromWhere")).ToString()
        End If

        ''If Trim(Request.QueryString("PKToken") & "") <> "" Then
        ''Added BY Nilesh g on 1/2/2016 for url issue

        'Commented By Rutuja D. on 7 April 2020 For issueID = 23512
        ' m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_intCTReportID, String) + CType(m_strFYPeriod, String) + "0" + "0")

        'End Commented By Rutuja D. on 7 April 2020 For issueID = 23512
        ''Added BY Nilesh g on 1/2/2016 for url issue
        '' End If
        'Added For Metrics 

        MetricFrequency = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_SEL_tbl_MET_ProjectAttributes_Frequency " + CType(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"), String), MyBase.UseSQL), "0")
        If MetricFrequency = 1 And m_intCTReportID = 10001 Then
            m_intCTReportID = 10003
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10002 Then
            m_intCTReportID = 10004
        ElseIf MetricFrequency = 1 And m_intCTReportID = 1000 Then
            m_intCTReportID = 10004
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10011 Then
            m_intCTReportID = 10005
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10012 Then
            m_intCTReportID = 10006
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10013 Then
            m_intCTReportID = 10007
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10014 Then
            m_intCTReportID = 10008
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10015 Then
            m_intCTReportID = 10009
        ElseIf MetricFrequency = 1 And m_intCTReportID = 10016 Then
            m_intCTReportID = 10010
        End If
        'End added for Metrics

        If CommonFunction.General.CheckIsNothing(Request.QueryString("MenuGroupID")) <> "" Then
            m_strMenuGroupId = CType(Request.QueryString("MenuGroupID"), String)
        Else
            m_strMenuGroupId = CommonFunction.General.CheckIsNothing(Request.Form("txtHidMenuGroupID"))
        End If

        CommonFunctions.General.WriteHTML("<input type=hidden id=FromWhere name=FromWhere value='" + m_strFromWhere + "' />")
        CommonFunctions.General.WriteHTML("<input type=hidden id=txtHidMenuGroupID name=txtHidMenuGroupID value='" + m_strMenuGroupId + "' />")

        If m_strMenuGroupId = "26" Then
            m_lngProjectID = CType(CommonFunction.General.CheckIsNothing(Session("IssueProject"), "0"), Long)
        Else
            m_lngProjectID = CType(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"), Long)
        End If

        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DQYAxis"), "").ToString() <> "" Then
            m_strDQYAxis = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DQYAxis"), "").ToString()
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''CommonFunction.HTMLControls.DrawTextBox("hdnDQYAxis", "hdnDQYAxis", , , , m_strDQYAxis.ToString, returnHTML:=False, DisplayNone:=True)
            CommonFunction.HTMLControls.DrawTextBox("hdnDQYAxis", "hdnDQYAxis", , , , m_strDQYAxis.ToString, returnHTML:=False, DisplayNone:=True, EnableHTMLEncode:=True)
            ''''End Added By Vaijat K On 06/10/2015
        Else
            m_strDQYAxis = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("hdnDQYAxis"), "").ToString()
        End If
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DQXAxis"), "").ToString() <> "" Then
            m_strDQXAxis = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DQXAxis"), "").ToString()
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''CommonFunction.HTMLControls.DrawTextBox("hdnDQXAxis", "hdnDQXAxis", , , , m_strDQXAxis.ToString, returnHTML:=False, DisplayNone:=True)
            CommonFunction.HTMLControls.DrawTextBox("hdnDQXAxis", "hdnDQXAxis", , , , m_strDQXAxis.ToString, returnHTML:=False, DisplayNone:=True, EnableHTMLEncode:=True)
            ''''End Added By Vaijat K On 06/10/2015
        Else
            m_strDQXAxis = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("hdnDQXAxis"), "").ToString()
        End If

        'Added By Amol Changle On: 09 Feb 2009
        'Purpose: To select Financial Period to show 
        m_strFYPeriod = CommonFunctions.General.CheckIsNothing(Request.QueryString("FYPeriodID"), "").ToString()
        If m_strFYPeriod = "" Then
            m_strFYPeriod = CommonFunctions.General.CheckIsNothing(Request.Form("txtFYPeriod"), "0").ToString()
        End If
        'End Addition

        'If (m_strMode = "" And m_strFromWhere.ToLower() <> "graph") Or (m_strMode.ToLower() = "graph" And m_strFromWhere.ToLower() = "menu") Then
        'Added By Rutuja D. on 7 April 2020 For issueID = 23512
        m_PKToken = CommonFunctions.General.CheckIsNothing(Request.QueryString("PKToken"), "").ToString()
        If m_PKToken = "" Then
            m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_intCTReportID, String) + CType(m_strFYPeriod, String) + "0" + "0")
        End If
        'End Added By Rutuja D. on 7 April 2020 For issueID = 23512


        If m_strMode.ToLower <> "detailquery" And m_strMode.ToLower <> "view" Then
            Session("XAxis") = ""
            Session("YAxis") = ""
        End If

        'If m_strFromWhere.ToLower() = "graph" Then
        'm_strXAxisFilterString = Session("XAxis")
        'm_strYAxisFilterString = Session("YAxis")
        'Else
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkXAxisFilter"), "").ToString() <> "" Then
            m_strXAxisFilterString = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkXAxisFilter"), "").ToString()
        Else
            m_strXAxisFilterString = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("XAxis"), "").ToString()
        End If
        Session("XAxis") = m_strXAxisFilterString


        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkYAxisFilter"), "").ToString() <> "" Then
            m_strYAxisFilterString = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkYAxisFilter"), "").ToString()
        Else
            m_strYAxisFilterString = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("YAxis"), "").ToString()
        End If
        Session("YAxis") = m_strYAxisFilterString
        'End If




        If m_strDQYAxis <> "" Then
            m_strDQYAxis = Replace(m_strDQYAxis, "AMPERCENT", "&")
            m_strDQYAxis = Replace(m_strDQYAxis, "PERCENT", "%")
            m_strDQYAxis = DecodeParemeter(m_strDQYAxis)
        End If

        If m_strDQXAxis <> "" Then
            m_strDQXAxis = Replace(m_strDQXAxis, "AMPERCENT", "&")
            m_strDQXAxis = Replace(m_strDQXAxis, "PERCENT", "%")
            m_strDQXAxis = DecodeParemeter(m_strDQXAxis)
        End If

        If m_intCTReportID <> 0 Then


            m_SQL = "usp_Sel_Tbl_SEM_CrossTabReport " + m_intCTReportID.ToString

            If m_strMenuGroupId <> "" Then
                m_SQL += "," + m_strMenuGroupId
            End If

            drReportDetails = CommonFunctions.Data.GetDataReader(m_SQL, MyBase.UseSQL)

            If drReportDetails.Read() Then
                m_strSource = CommonFunctions.Data.CheckIsDBNull(drReportDetails("Source")).ToString()
                m_strAttribute = CommonFunctions.Data.CheckIsDBNull(drReportDetails("Attribute")).ToString()
                m_strYAxis = CommonFunctions.Data.CheckIsDBNull(drReportDetails("YAxis")).ToString()
                m_strXAxis = CommonFunctions.Data.CheckIsDBNull(drReportDetails("XAxis")).ToString()
                m_strCTReportTitle = CommonFunctions.Data.CheckIsDBNull(drReportDetails("CTReportTitle")).ToString()
                m_strFormula = CommonFunctions.Data.CheckIsDBNull(drReportDetails("Formula")).ToString()
                m_strEntityType = CommonFunctions.Data.CheckIsDBNull(drReportDetails("EntityType"), "V").ToString()
                m_strDetailQuery = CommonFunctions.Data.CheckIsDBNull(drReportDetails("DetailQuery")).ToString()
                m_strWhereClause = CommonFunctions.Data.CheckIsDBNull(drReportDetails("WhereClause")).ToString()
                m_strXAxisFilter = CommonFunctions.Data.CheckIsDBNull(drReportDetails("XAxisFilter")).ToString()
                m_strYAxisFilter = CommonFunctions.Data.CheckIsDBNull(drReportDetails("YAxisFilter")).ToString()
                m_strGroupReportID = CommonFunctions.Data.CheckIsDBNull(drReportDetails("GroupReportID"), "0").ToString()
                m_blnIsFYDriven = CType(CommonFunctions.Data.CheckIsDBNull(drReportDetails("IsFYDriven"), "0"), Boolean)
                m_GraphNomencleture = CommonFunctions.Data.CheckIsDBNull(drReportDetails("GraphNomencleture"), "No.").ToString()
                m_strProjectID = CommonFunctions.Data.CheckIsDBNull(drReportDetails("ProjectID"), "0").ToString()
                m_strXAxisOrderBy = CommonFunctions.Data.CheckIsDBNull(drReportDetails("XAxisOrderByClause")).ToString()
                m_strYAxisOrderBy = CommonFunctions.Data.CheckIsDBNull(drReportDetails("YAxisOrderByClause")).ToString()
                m_strEmployeeFilterOn = CommonFunctions.Data.CheckIsDBNull(drReportDetails("EmployeeFilterOn")).ToString()
                m_strFixedColumns = CommonFunctions.Data.CheckIsDBNull(drReportDetails("FixedColumns")).ToString()
                ' Added By NitinVS on 9 Apr 2009 To Financial Period Navigation based on FinancialType 
                m_FinancialType = CommonFunctions.Data.CheckIsDBNull(drReportDetails("FinancialType")).ToString()
                ' End Addition By NitinVS on 9 Apr 2009 To Financial Period Navigation based on FinancialType 
                m_blnShowBackLink = CType(CommonFunctions.Data.CheckIsDBNull(drReportDetails("ShowBackLink"), "0"), Boolean)

                If m_strProjectID = "1" Then
                    Dim strXOrderByClause As String = ""
                    Dim strYOrderByClause As String = ""
                    If m_strXAxisFilter.ToUpper.IndexOf("ORDER BY") > 0 Then
                        strXOrderByClause = m_strXAxisFilter.Substring(m_strXAxisFilter.ToUpper.IndexOf("ORDER BY"))
                        m_strXAxisFilter = m_strXAxisFilter.Substring(0, m_strXAxisFilter.ToUpper.IndexOf("ORDER BY") - 1)
                    End If
                    If m_strYAxisFilter.ToUpper.IndexOf("ORDER BY") > 0 Then
                        strYOrderByClause = m_strYAxisFilter.Substring(m_strYAxisFilter.ToUpper.IndexOf("ORDER BY"))
                        m_strYAxisFilter = m_strYAxisFilter.Substring(0, m_strYAxisFilter.ToUpper.IndexOf("ORDER BY") - 1)
                    End If

                    If m_strXAxisFilter <> "" And m_strXAxisFilter.ToUpper.IndexOf("EXEC ") = -1 And m_strXAxisFilter.ToUpper.IndexOf("EXECUTE ") = -1 Then
                        If m_strXAxisFilter.ToUpper.IndexOf(" WHERE ") > 0 Then
                            m_strXAxisFilter = m_strXAxisFilter + " AND ProjectID = " + m_lngProjectID.ToString + strXOrderByClause
                        Else
                            m_strXAxisFilter = m_strXAxisFilter + " WHERE ProjectID = " + m_lngProjectID.ToString + strXOrderByClause
                        End If
                    End If

                    If m_strYAxisFilter <> "" And m_strXAxisFilter.ToUpper.IndexOf("EXEC ") = -1 And m_strXAxisFilter.ToUpper.IndexOf("EXECUTE ") = -1 Then
                        If m_strYAxisFilter.ToUpper.IndexOf(" WHERE ") > 0 Then
                            m_strYAxisFilter = m_strYAxisFilter + " AND ProjectID = " + m_lngProjectID.ToString + strYOrderByClause
                        Else
                            m_strYAxisFilter = m_strYAxisFilter + " WHERE ProjectID = " + m_lngProjectID.ToString + strYOrderByClause
                        End If
                    End If

                End If

                ' Added By NitinVS on 9 Apr 2009 To Financial Period Navigation based on FinancialType 
                CommonFunction.Data.DisposeDataReader(drReportDetails)
                ' End addition By NitinVS on 9 Apr 2009 To Financial Period Navigation based on FinancialType 

                drFYTitle = CommonFunctions.Data.GetDataReader("Usp_Sel_Tbl_SEM_FinancialYear_Master_GetTitle " + m_strFYPeriod + ",'" + m_FinancialType + "'", True)

                If drFYTitle.Read() Then

                    strCurrentFYTitle = CommonFunctions.Data.CheckIsDBNull(drFYTitle("CurrentFYTitle"))
                    strPreviousFYTitle = CommonFunctions.Data.CheckIsDBNull(drFYTitle("PreviousFYTitle"))
                    strNextFYTitle = CommonFunctions.Data.CheckIsDBNull(drFYTitle("NextFYTitle"))
                    If IsDBNull(drFYTitle("CurrentYearFromDate")) = False Then
                        m_StartDate = CommonFunction.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(drFYTitle("CurrentYearFromDate")))
                    End If
                    If IsDBNull(drFYTitle("CurrentYearToDate")) = False Then
                        m_EndDate = CommonFunction.Dates.GetDate(CommonFunctions.Data.CheckIsDBNull(drFYTitle("CurrentYearToDate")))
                    End If

                End If
                'drFYTitle.Dispose()
                CommonFunction.Data.DisposeDataReader(drFYTitle)

                m_strXAxisFilter = m_strXAxisFilter.ToUpper.Replace("@PERIOD", " @Period = " + m_strFYPeriod)
                m_strXAxisFilter = m_strXAxisFilter.ToUpper.Replace("@XAXIS", " @XAxis = '" + m_strXAxis + "'")
                m_strXAxisFilter = m_strXAxisFilter.ToUpper.Replace("@YAXIS", " @YAxis = '" + m_strYAxis + "'")
                m_strXAxisFilter = m_strXAxisFilter.Replace("@DTFROMDATE", " @DTFROMDATE = '" + m_StartDate + "'")
                m_strXAxisFilter = m_strXAxisFilter.Replace("@DTTODATE", " @DTTODATE = '" + m_EndDate + "'")


                m_strYAxisFilter = m_strYAxisFilter.ToUpper.Replace("@PERIOD", " @Period = " + m_strFYPeriod)
                m_strYAxisFilter = m_strYAxisFilter.ToUpper.Replace("@XAXIS", " @XAxis = '" + m_strXAxis + "'")
                m_strYAxisFilter = m_strYAxisFilter.Replace("@YAXIS", "@YAxis = '" + m_strYAxis + "'")
                m_strYAxisFilter = m_strYAxisFilter.Replace("@DTFROMDATE", " @DTFROMDATE = '" + m_StartDate + "'")
                m_strYAxisFilter = m_strYAxisFilter.Replace("@DTTODATE", " @DTTODATE = '" + m_EndDate + "'")

            End If
            Select Case m_strMode.ToUpper
                Case "DETAILQUERY"

                    If m_strDetailQuery <> "" Then
                        If m_strEntityType = "P" Then
                            m_strSQL = " EXEC " + m_strDetailQuery
                            m_strWhereClause = " @intUserID = " + m_strUserID + "," + m_strWhereClause
                            'Added By Amol Changle On: 09 Feb 2009
                            'Purpose: To view reports Financial year wise
                            If m_blnIsFYDriven Then
                                'm_strWhereClause = "@PeriodID=" + m_strFYPeriod + "," + m_strWhereClause
                                m_strWhereClause = "@PeriodID=" + m_strFYPeriod + IIf(m_strWhereClause <> "", "," + m_strWhereClause, "").ToString()
                            End If
                            'End Additionl

                            If m_strWhereClause <> "" Then
                                m_strSQL += " " + m_strWhereClause
                            End If

                            If m_strXAxis <> "" Then
                                m_strSQL += " @DQXAxis=N'" + CommonFunctions.General.BuildQueryString(m_strDQXAxis).ToString() + "'"
                            Else
                                m_strSQL += " @DQXAxis=NULL"
                            End If

                            If m_strXAxis <> "" Then
                                m_strSQL += ", @DQYAxis=N'" + CommonFunctions.General.BuildQueryString(m_strDQYAxis).ToString() + "'"
                            Else
                                m_strSQL += ", @DQYAxis=NULL"
                            End If

                            If m_strXAxisFilterString <> "" Then
                                m_strSQL += ", @XAxisFilter=N'"
                                m_strSQL += CommonFunctions.General.BuildQueryString(m_strXAxisFilterString)
                                m_strSQL += "'"
                            Else
                                m_strSQL += ", @XAxisFilter=NULL"
                            End If
                            If m_strYAxisFilterString <> "" Then
                                m_strSQL += ", @YAxisFilter=N'"
                                m_strSQL += CommonFunctions.General.BuildQueryString(m_strYAxisFilterString)
                                m_strSQL += "'"
                            Else
                                m_strSQL += ", @YAxisFilter=NULL"
                            End If

                            If m_strProjectID = "1" Then
                                m_strSQL += " , @intProjectID="
                                If m_lngProjectID.ToString <> "" Then
                                    m_strSQL += m_lngProjectID.ToString
                                Else
                                    m_strSQL += "0"
                                End If

                            End If

                            If m_blnIsFYDriven = True Then

                                If m_StartDate <> "" Then
                                    m_strSQL += " , @dtFromDate='" + m_StartDate + "'"
                                End If
                                If m_EndDate <> "" Then
                                    m_strSQL += " , @dtToDate='" + m_EndDate + "'"
                                End If

                            End If

                            'Added By Amol Changle On: 13 Apr 2009
                            'Purpose: To apply advanced filters to Detail Query
                            Dim strAdvancedFilterWhereClause As String
                            strAdvancedFilterWhereClause = CommonFunctions.General.CheckIsNothing(Session("AdvancedFilterWhereClause")).ToString()

                            If strAdvancedFilterWhereClause <> "" Then
                                m_strSQL += ",@strWhereClause=N'"
                                m_strSQL += CommonFunctions.General.BuildQueryString(strAdvancedFilterWhereClause)
                                m_strSQL += "'"
                            End If
                            'End Addition

                        Else
                            m_strSQL = m_strDetailQuery
                            m_strSQL += " WHERE " + IIf(m_strDQYAxis.ToUpper() = "TOTAL", " ", "[" + m_strYAxis).ToString() + IIf(m_strDQYAxis.ToUpper() <> "NA", IIf(m_strDQYAxis.ToUpper() = "TOTAL", "1=1", "]=N'" + CommonFunctions.General.BuildQueryString(m_strDQYAxis).ToString() + "'").ToString(), "] IS NULL ")
                            m_strSQL += " AND " + IIf(m_strDQXAxis.ToUpper() = "TOTAL", " ", "[" + m_strXAxis).ToString() + IIf(m_strDQXAxis.ToUpper() <> "NA", IIf(m_strDQXAxis.ToUpper() = "TOTAL", "1=1", "]=N'" + CommonFunctions.General.BuildQueryString(m_strDQXAxis).ToString() + "'").ToString(), "] IS NULL")
                            If m_strWhereClause <> "" Then
                                m_strSQL += "  AND " + m_strWhereClause
                            End If
                            If m_strYAxisFilterString <> "" Then
                                If m_strYAxisFilterString = "'NA'" Then
                                    m_strSQL += "  AND [" + m_strYAxis + "] IS NULL  "
                                Else
                                    If m_strYAxisFilterString.IndexOf("'NA'") <> -1 Then
                                        m_strSQL += "  AND ( [" + m_strYAxis + "] IS NULL  "
                                        m_strSQL += "  OR [" + m_strYAxis + "] IN ( " + m_strYAxisFilterString + " ) )"
                                    Else
                                        m_strSQL += "  AND [" + m_strYAxis + "] IN ( " + m_strYAxisFilterString + " ) "
                                    End If
                                End If
                            End If

                            If m_strXAxisFilterString <> "" Then
                                If m_strXAxisFilterString = "'NA'" Then
                                    m_strSQL += "  AND [" + m_strXAxis + "] IS NULL  "
                                Else
                                    If m_strXAxisFilterString.IndexOf("'NA'") <> -1 Then
                                        m_strSQL += "  AND ( [" + m_strXAxis + "] IS NULL  "
                                        m_strSQL += "  OR [" + m_strXAxis + "] IN ( " + m_strXAxisFilterString + " ) )"
                                    Else
                                        m_strSQL += "  AND [" + m_strXAxis + "] IN ( " + m_strXAxisFilterString + " ) "
                                    End If
                                End If
                            End If

                            If m_strSQL.ToUpper.IndexOf("ORDER BY") > 0 Then
                                Dim strOrderByClause As String = ""
                                strOrderByClause = m_strSQL.Substring(m_strSQL.ToUpper().IndexOf("ORDER BY"))
                                m_strSQL = m_strSQL.Substring(0, m_strSQL.ToUpper().IndexOf("ORDER BY") - 1)

                                If m_strProjectID = "1" And (m_lngProjectID.ToString <> "" And m_lngProjectID.ToString <> "0") Then

                                    If m_strSQL.ToUpper.IndexOf(" WHERE ") > 0 Then
                                        m_strSQL += " AND ProjectID="
                                    Else
                                        m_strSQL += " WHERE ProjectID="
                                    End If

                                    m_strSQL += m_lngProjectID.ToString

                                End If
                                m_strSQL += " " + strOrderByClause
                            Else
                                If m_strProjectID = "1" And (m_lngProjectID.ToString <> "" And m_lngProjectID.ToString <> "0") Then
                                    If m_strSQL.ToUpper.IndexOf(" WHERE ") > 0 Then
                                        m_strSQL += " AND ProjectID="
                                    Else
                                        m_strSQL += " WHERE ProjectID="
                                    End If

                                    m_strSQL += m_lngProjectID.ToString

                                End If
                                If m_strEmployeeFilterOn <> "" Then
                                    Dim strRoleLevel As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_SEM_GetLoogedUserRoleLevel " + m_strUserID + ",'" + strLoginType + "'", MyBase.UseSQL), "0"), "0").ToString()
                                    Dim drAccessFilter As IDataReader = CommonFunctions.Data.GetDataReader("usp_QRB_RoleLevelAccessFilter 'EmployeeID'," + m_strUserID + ",'" + strLoginType + "' ," + strRoleLevel + "," + m_strShowEvenReleaseFromProject + "," + m_strLoginID, MyBase.UseSQL)
                                    Dim strAccessFilterString As String = m_strEmployeeFilterOn + " IN ( "
                                    Dim strAccessFilterResources As String = ""
                                    While drAccessFilter.Read()
                                        strAccessFilterResources = strAccessFilterResources + IIf(strAccessFilterResources <> "", "," + CommonFunctions.Data.CheckIsDBNull(drAccessFilter("EmployeeID"), "0").ToString, CommonFunctions.Data.CheckIsDBNull(drAccessFilter("EmployeeID"), "0").ToString).ToString
                                    End While
                                    CommonFunction.Data.DisposeDataReader(drAccessFilter)
                                    strAccessFilterString = strAccessFilterString + strAccessFilterResources + " ) "
                                    If strAccessFilterResources <> "" Then
                                        m_strSQL += " AND " + strAccessFilterString
                                    End If
                                End If
                                m_strSQL += "  ORDER BY 1"
                            End If
                        End If
                        m_dsCrossTabReport = CommonFunctions.Data.GetDataSet(m_strSQL.ToString(), "CrossTabReport")
                    End If

                Case Else

                    'Added By Amol Changle On: 13 Apr 2009
                    'Purpose: To get advanced filter controls
                    m_dsAdvancedFilters = CommonFunctions.Data.GetDataSet("Usp_Sel_Tbl_SEM_CrossTabReport_Filters " + IIf(m_strGroupReportID = "", m_intCTReportID.ToString(), m_strGroupReportID), "Tbl_AdvancedFilters", UseSQL:=True)
                    'End Addition 

                    m_strSQL = GetReportSQL()
                    If m_strSQL <> "" Then
                        m_dsCrossTabReport = CommonFunctions.Data.GetDataSet(m_strSQL.ToString(), "CrossTabReport")
                    End If
            End Select
        End If
        If m_intCTReportID <> 0 Then
            m_dsGroupReport = CommonFunctions.Data.GetDataSet("usp_Sel_tbl_SEM_CrossTabReport_GroupReport " + m_strGroupReportID.ToString(), "GroupReport")
        End If



    End Sub
    Protected Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name		:	PlotPageHeadTag
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the page legends.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	22-Dec-2008
        ' Revisions				:	
        '=====================================================================

        CommonFunctions.General.PlotPageHeadTag("Cross Tab Report")
    End Sub
    Public Sub WritePage()


        '=====================================================================
        ' Procedure Name		:	WritePage
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To write the page.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	22-Dec-2008
        ' Revisions				:	
        '=====================================================================
        Call InitVariables()

        If m_strProjectID = "1" And (m_lngProjectID.ToString = "" Or m_lngProjectID.ToString = "0") Then
            CommonFunctions.General.WriteHTML("<BR><TABLE class=clsTable width=100% cellpadding=0 cellspacing=0 >")
            CommonFunctions.General.WriteHTML("<TR class=clsTROdd align=center>")
            CommonFunctions.General.WriteHTML("<TD>Please select a project.!!")
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</TABLE>")
            Exit Sub
        End If

        If m_strMode = "" Then
            ShowAllReports()
        End If

        If m_strSQL <> "" Then
            Select Case m_strMode.ToUpper
                Case "VIEW"
                    Call ExportToReport()
                Case "DETAILQUERY"
                    Call ExportToReport()
                Case "GRAPH"
                    'CommonFunctions.General.WriteHTML("<DIV id=DivMain style='overflow:auto;width:100%' height=300 >")
                    Call DrawGraph()
                    'CommonFunctions.General.WriteHTML("</div>")
                Case Else

                    CommonFunctions.General.WriteHTML(InitializeMenu())
                    CommonFunctions.General.WriteHTML("<br>")
                    CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, m_strCTReportTitle, , , True))
                    CommonFunctions.General.WriteHTML("<br>")
                    Call DrawFilter()
                    Call SetCurrentIndexForPaging()
                    m_intTotalRow = CType(IIf(Not m_dsCrossTabReport Is Nothing, m_dsCrossTabReport.Tables(0).Rows.Count, 0), Integer)
                    Call CalculateNoOfpagesForPaging()
                    CommonFunctions.General.WriteHTML(DrawPaging())
                    Call PlotCrossTabReportGrid()
                    'CommonFunctions.General.WriteHTML(InitializeMenu())
            End Select
        End If
        ''''Commented And Added By Vaijat K On 06/10/2015
        '''CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , m_NoOfpages.ToString(), , , , , , True))
        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , m_NoOfpages.ToString(), , , , , , True, EnableHTMLEncode:=True))
        ''''End Added By Vaijat K On 06/10/2015
    End Sub

    Private Sub ShowAllReports()
        '=====================================================================
        ' Procedure Name		:	ShowAllReports
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the Selection page for crosstabs 
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	nitinvs
        ' Created				:	23-MAR-2009
        ' Revisions				:	
        '=====================================================================

    End Sub
    Private Sub PlotCrossTabReportGrid()
        '=====================================================================
        ' Procedure Name		:	PlotCrossTabReportGrid
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the Cross Tab Report Grid.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	22-Dec-2008
        ' Revisions				:	
        '=====================================================================
        Dim arrActualColumnNames As New ArrayList
        Dim arrUserFriendlyColumnNames As New ArrayList
        Dim arrWidthArray As New ArrayList
        Dim sbHTML As New System.Text.StringBuilder
        Dim ColWidth As Long
        Dim arrStaticColumn As String = ""
        If Not m_dsCrossTabReport Is Nothing Then
            If m_dsCrossTabReport.Tables(0).Rows.Count > 0 Then

                If m_dsCrossTabReport.Tables(0).Columns.Contains("ColOrderY") Then
                    m_dsCrossTabReport.Tables(0).Columns.Remove("ColOrderY")
                End If


                arrStaticColumn = m_dsCrossTabReport.Tables(0).Columns(0).ColumnName

                For Each drReportColumn As DataColumn In m_dsCrossTabReport.Tables(0).Columns


                    If drReportColumn.ColumnName.ToUpper() <> "CROSSTABORDERNO" Then
                        arrActualColumnNames.Add(drReportColumn.ColumnName)
                        Select Case drReportColumn.DataType.ToString().ToUpper()
                            Case "SYSTEM.BOOLEAN"
                                arrWidthArray.Add("align='center' ")
                            Case "SYSTEM.CHAR", "SYSTEM.DATETIME", "SYSTEM.STRING"
                                arrWidthArray.Add("align='left' ")
                            Case "SYSTEM.DOUBLE", "SYSTEM.INT16", "SYSTEM.INT32", "SYSTEM.INT64", "SYSTEM.DECIMAL", "SYSTEM.SINGLE", "SYSTEM.SBYTE", "SYSTEM.BYTE"
                                arrWidthArray.Add("align='right' ")
                        End Select
                    End If


                Next
            End If



            arrUserFriendlyColumnNames = arrActualColumnNames.Clone()


            ''''Added By Vaijat K On 06/10/2015
            Dim arrIgnoreHTMLEncode() As String = {"0"}
            ''''End Added By Vaijat K On 06/10/2015
            With m_objCrossTabReportGrid
                .ActualColumnArray = GetArray(arrActualColumnNames)
                .UserFriendlyColumnArray = GetArray(arrUserFriendlyColumnNames)
                .NoOfDataColumns = arrActualColumnNames.Count
                .TDStyleArray = GetArray(arrWidthArray)
                .ColNameToolTipOnEachRow = False
                .DIVID = "DivMain"
                .DIVHeight = 300
                .DIVStyle = "overflow:auto;width:99.99%"
                '.SQL = m_strSQL
                .GridDataTable = m_dsCrossTabReport.Tables(0)
                .ColNameToolTipOnEachRow = True
                .UseSQL = True
                .StaticColumnList = arrStaticColumn
                .StaticHeaderStyle = STATIC_HEADER_STYLE.ENABLED
                .PageSize = m_PageSize
                .CurrentPage = m_curPageNumber
                ''''Added By Vaijat K On 06/10/2015
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                ''''End Added By Vaijat K On 06/10/2015
                CommonFunctions.General.WriteHTML(.DrawGrid())

            End With
            If m_dsCrossTabReport.Tables(0).Rows.Count > 0 Then
                CommonFunctions.General.WriteHTML("<BR><TABLE class=clsTable width=100% cellpadding=0 cellspacing=0 >")
                CommonFunctions.General.WriteHTML("<TR class=clsTROdd align=right>")
                CommonFunctions.General.WriteHTML("<TD>Total Records :")
                CommonFunctions.General.WriteHTML(m_dsCrossTabReport.Tables(0).Rows.Count.ToString())
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")
            End If
        End If

        m_objCrossTabReportGrid = Nothing
        arrActualColumnNames = Nothing
        arrUserFriendlyColumnNames = Nothing
        arrWidthArray = Nothing
        m_dsCrossTabReport = Nothing

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
        ' Author                : MahendraV
        ' Created               : 22-Dec-2008
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Private Function InitializeMenu() As String
        '=====================================================================
        ' Procedure Name		:	InitializeMenu
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To plote the page Menu.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	22-Dec-2008
        ' Revisions				:	
        '=====================================================================
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""
        Dim srrStr() As String = {"", ""}

        'If m_strProjectID <> "" Or m_strProjectID <> "0" Then
        '    ArrMenuCaptionsList.Add(" <Img Border=0 src='../../Images/cssImages/Link Images/Filter.gif'>&nbsp;Project")
        '    ArrMenuToolTipsList.Add("Project Selection")
        '    ArrClientSideFunctionsList.Add("ShowFilterX_OnClick()")

        '    ArrMenuCaptionsList.Add(" <Img Border=0 src='../../Images/cssImages/Link Images/Filter.gif'>&nbsp;Project")
        '    ArrMenuToolTipsList.Add("Project Selection")
        '    ArrClientSideFunctionsList.Add("ShowFilterX_OnClick()")

        'End If

        'Added By Amol Changle On: 13 Apr 2009
        'Purpose: To plot Advanced filter links
        If m_dsAdvancedFilters.Tables(0).Rows.Count > 0 Then
            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link Images/Filter.gif'>&nbsp;Advanced Filters")
            ArrMenuToolTipsList.Add("Show Advanced Filters")
            ArrClientSideFunctionsList.Add("ShowAdvancedFilters_OnClick()")

            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link Images/Close.gif'>&nbsp;Advanced Filters")
            ArrMenuToolTipsList.Add("hide Advanced Filters")
            ArrClientSideFunctionsList.Add("HideAdvancedFilters_OnClick()")
        End If
        'End Addition

        If m_strXAxisFilter <> "" Then
            ArrMenuCaptionsList.Add(" <Img Border=0 src='../../Images/cssImages/Link Images/Filter.gif'>&nbsp;X-Axis")
            ArrMenuToolTipsList.Add("Show X-Axis Filter")
            ArrClientSideFunctionsList.Add("ShowFilterX_OnClick()")

            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link Images/Close.gif'>&nbsp;X-Axis")
            ArrMenuToolTipsList.Add("Hide X-Axis Filter")
            ArrClientSideFunctionsList.Add("HideFilterX_OnClick()")
        End If

        If m_strYAxisFilter <> "" Then
            ArrMenuCaptionsList.Add(" <Img Border=0 src='../../Images/cssImages/Link Images/Filter.gif'>&nbsp;Y-Axis")
            ArrMenuToolTipsList.Add("Show Y-Axis Filter")
            ArrClientSideFunctionsList.Add("ShowFilterY_OnClick()")

            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link Images/Close.gif'>&nbsp;Y-Axis")
            ArrMenuToolTipsList.Add("Hide Y-Axis Filter")
            ArrClientSideFunctionsList.Add("HideFilterY_OnClick()")
        End If

        If Not m_dsGroupReport Is Nothing Then
            If m_dsGroupReport.Tables(0).Rows.Count > 1 Then
                ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/OtherViews.gif'>&nbsp;Other Views")
                ArrMenuToolTipsList.Add("Other Views")
                ArrClientSideFunctionsList.Add("OtherViews_OnClick()")
            End If
        End If

        If m_strMode.ToLower() = "graph" Then
            ArrMenuCaptionsList.Add("Grid View")
            ArrMenuToolTipsList.Add("Grid View")
            ArrClientSideFunctionsList.Add("GridView_OnClick()")
        End If

        If m_strMode.ToLower <> "graph" Then
            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link Images/Graph.gif'>&nbsp;Graphical View")
            ArrMenuToolTipsList.Add("Graphical View")
            ArrClientSideFunctionsList.Add("ViewGraph_OnClick()")

            ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/UploadData.gif'>&nbsp;Export Data")
            ArrMenuToolTipsList.Add("Export Data")
            ArrClientSideFunctionsList.Add("Export_OnClick()")
        End If

        If m_strMode = "" And (m_strGroupReportID = 262 Or m_strGroupReportID = 269 Or m_strGroupReportID = 276 Or m_strGroupReportID = 283) Or m_blnShowBackLink Then
            ArrMenuCaptionsList.Add(" &nbsp;Back")
            ArrMenuToolTipsList.Add("Back")
            ArrClientSideFunctionsList.Add("ShowHelpDeskAnalytics()")
        End If

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('CROSSTABREPORT_" + m_strGroupReportID + "')")


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


    Protected Sub DrawFilter()
        Dim sbHTML As New System.Text.StringBuilder
        Dim intCount As Integer = 0
        Dim strValue As String = ""

        Dim dsCrossTabReportXFilter As DataSet
        Dim dsCrossTabReportYFilter As DataSet

        ' XAxis Filter 
        sbHTML.Append("<div id=""divTblX""  style='overflow:auto;width:25%;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;' >")

        sbHTML.Append("<table id=""TblBX""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<TR class='clsTRPageCaption'>")
        sbHTML.Append("<td align='left' nowrap><B>X-Axis-&gt;" + m_strXAxis + "</B></td>")
        sbHTML.Append("</TR>")

        strValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkXAxisFilterAll"), "").ToString()

        sbHTML.Append("<TR class='clsTRBlank'>")
        sbHTML.Append("<td align='left' nowrap>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkXAxisFilterAll", "chkXAxisFilterAll", , IIf(strValue <> "", True, False), "SelectX", , "onClick='javascript:SelectAndClearAllX_OnClick()'", True))
        sbHTML.Append("<B>Select/Clear All</B></td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</table>")

        sbHTML.Append("<div id=""divTblXX""  style='overflow:auto;width:99.99%;' >")

        sbHTML.Append("<table id=""TblXX""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")

        If m_strXAxisFilter <> "" Then
            dsCrossTabReportXFilter = CommonFunctions.Data.GetDataSet(m_strXAxisFilter.ToString(), "CrossTabReportX")
        End If

        If Not dsCrossTabReportXFilter Is Nothing Then
            If dsCrossTabReportXFilter.Tables(0).Rows.Count > 0 Then
                For Each drReportRows As DataRow In dsCrossTabReportXFilter.Tables(0).Rows
                    sbHTML.Append("<TR class='clsTROdd'>")
                    sbHTML.Append("<td align='left' nowrap >")
                    If m_strXAxisFilterString.IndexOf("'" + drReportRows(0).ToString() + "'") <> -1 Then
                        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkXAxisFilter", "chkXAxisFilter", , True, "N'" + CommonFunctions.General.BuildQueryString(drReportRows(0).ToString()) + "'", , "onClick='javascript:SCX_OnClick()'", True))
                    Else
                        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkXAxisFilter", "chkXAxisFilter", , , "N'" + CommonFunctions.General.BuildQueryString(drReportRows(0).ToString()) + "'", , "onClick='javascript:SCX_OnClick()'", True))
                    End If
                    sbHTML.Append(" " + drReportRows(0).ToString())
                    sbHTML.Append("</td>")
                    sbHTML.Append("</TR>")
                Next
            End If
        End If

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        sbHTML.Append("<table id=""TblBX""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<tr class='clsTRBlank'><td  style='text-align:center;' nowrap>")
        'sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:applyFilter()' Title='Apply X-Axis Filter' ><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:CloseFilter()' Title='Close X-Axis Filter' ><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></A>")
        sbHTML.Append("<span onclick='applyFilter()' style='cursor:pointer' title='Apply X-Axis Filter'><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<span onclick='CloseFilter()' style='cursor:pointer' title='Close X-Axis Filter'><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></span>")

        sbHTML.Append("</td></tr>")

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")

        If m_strYAxisFilter <> "" Then
            dsCrossTabReportYFilter = CommonFunctions.Data.GetDataSet(m_strYAxisFilter.ToString(), "CrossTabReportY")
        End If

        ' YAxis Filter 
        sbHTML.Append("<div id=""divTblY""  style='overflow:auto;width:27%;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;' >")

        sbHTML.Append("<table id=""TblBY""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<TR class='clsTRPageCaption'>")
        sbHTML.Append("<td align='left' nowrap><B>Y-Axis-&gt;" + m_strYAxis + "</B></td>")
        sbHTML.Append("</TR>")
        strValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("chkYAxisFilterAll"), "").ToString()
        sbHTML.Append("<TR class='clsTRBlank'>")
        sbHTML.Append("<td align='left' nowrap>")
        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkYAxisFilterAll", "chkYAxisFilterAll", , IIf(strValue <> "", True, False), "SelectY", , "onClick='javascript:SelectAndClearAllY_OnClick()'", True))
        sbHTML.Append("<B>Select/Clear All</B></td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</Table>")

        sbHTML.Append("<div id=""divTblYY""  style='overflow:auto;width:99.99%;' >")
        sbHTML.Append("<table id=""TblYY"" class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")


        If Not dsCrossTabReportYFilter Is Nothing Then
            If dsCrossTabReportYFilter.Tables(0).Rows.Count > 0 Then
                For Each drReportRows1 As DataRow In dsCrossTabReportYFilter.Tables(0).Rows
                    sbHTML.Append("<TR class='clsTROdd'>")
                    sbHTML.Append("<td align='left' nowrap>")
                    If m_strYAxisFilterString.IndexOf("'" + drReportRows1(0).ToString + "'") <> -1 Then
                        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkYAxisFilter", "chkYAxisFilter", , True, "N'" + CommonFunctions.General.BuildQueryString(drReportRows1(0).ToString()) + "'", , "onClick='javascript:SCY_OnClick()'", True))
                    Else
                        sbHTML.Append(CommonFunctions.HTMLControls.DrawCheckBox("chkYAxisFilter", "chkYAxisFilter", , , "N'" + CommonFunctions.General.BuildQueryString(drReportRows1(0).ToString()) + "'", , "onClick='javascript:SCY_OnClick()'", True))
                    End If
                    sbHTML.Append(" " + drReportRows1(0).ToString())
                    sbHTML.Append("</td>")
                    sbHTML.Append("</TR>")

                Next
            End If
        End If


        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        sbHTML.Append("<table id=""TblBY""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<tr class='clsTRBlank'><td style='text-align:center;' nowrap >")
        'sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:applyFilter()' Title='Apply X-Axis Filter' ><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHTML.Append("<A style = 'text-decoration:none;valign:middle;' HREF='Javascript:CloseFilter()' Title='Close X-Axis Filter' ><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></A>")

        sbHTML.Append("<span onclick='applyFilter()' style='cursor:pointer' title='Apply Y-Axis Filter'><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<span onclick='CloseFilter()' style='cursor:pointer' title='Close Y-Axis Filter'><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></span>")


        sbHTML.Append("</td></tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")

        ' Other Views Filter 

        sbHTML.Append("<div id=""divTblMainOtherView""  style='overflow:auto;width:40%;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;' >")

        sbHTML.Append("<table id=""TblOtherView1""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<TR class='clsTRPageCaption'>")
        sbHTML.Append("<td align='left' nowrap><B>Other Views:-</B></td>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</table>")

        sbHTML.Append("<div id=""TblOtherView""  style='overflow:auto;width:99.99%;' >")
        sbHTML.Append("<table id=""TblOtherView2""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        intCount = 0
        If Not m_dsGroupReport Is Nothing Then
            If m_dsGroupReport.Tables(0).Rows.Count > 0 Then
                For Each drReportRows2 As DataRow In m_dsGroupReport.Tables(0).Rows
                    intCount += 1
                    sbHTML.Append("<TR class='clsTROdd'>")
                    sbHTML.Append("<td align='left' nowrap >[" + intCount.ToString() + "]")
                    If m_intCTReportID = CType(drReportRows2("CTReportID"), Integer) Then
                        sbHTML.Append("<font color=blue >")
                        sbHTML.Append(drReportRows2("CTReportTitle").ToString())
                        sbHTML.Append("</font>")
                        sbHTML.Append("<Img Border=0 src='../../Images/Check.gif' />")
                    Else
                        sbHTML.Append("<A class='Menu' style='text-decoration:underline;' ID = 'OTHER_VIEWS_OnClickUI_HEAD0_")
                        sbHTML.Append(drReportRows2("CTReportID").ToString())
                        sbHTML.Append("'")
                        sbHTML.Append(" HREF='Javascript:OtherViewsLink_OnClick(" + drReportRows2("CTReportID").ToString() + ")' Title='Other Views'>")
                        sbHTML.Append(drReportRows2("CTReportTitle").ToString())
                        sbHTML.Append("&nbsp;</A>")
                    End If

                    sbHTML.Append("</td>")
                    sbHTML.Append("</TR>")
                Next
            End If
        End If
        intCount = 0
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        sbHTML.Append("<table id=""TblBY""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<tr class='clsTRBlank'><td style='text-align:center;' nowrap >")
        sbHTML.Append("<span onclick='CloseFilter()' style='cursor:pointer' title='Close Other Views Filter'><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></span>")
        sbHTML.Append("</td></tr>")
        sbHTML.Append("</table>")

        sbHTML.Append("</div>")


        'Added By Amol Changle On: 06 Apr 2009
        'Purpose: To draw advanced filters div
        Dim strFilterName As String = ""
        Dim strFilterCaption As String = ""
        Dim strFilterType As String = ""
        Dim strSQLSource As String = ""
        Dim strDefaultValue As String = ""
        Dim blnMandatory As Boolean = False
        Dim strValidationScript As New StringBuilder("")
        Dim strClearFilterScript As New StringBuilder("")


        sbHTML.Append("<div id=""divMainAdvancedFilters""  style='overflow:auto;width:40%;position:absolute;border-right: black 1px outset;border-top: black 1px outset;border-left: black 1px outset;border-bottom: black 1px outset;' >")
        sbHTML.Append("<table id=""TblAdvancedFilters1""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<TR class='clsTRPageCaption'>")
        sbHTML.Append("<td align='left' nowrap><B>Advanced Filters</B></td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("<div id=""divAdvancedFilters""  style='overflow:auto;width:99.99%;' >")
        sbHTML.Append("<table id=""TblAdvancedFilters2""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")

        strValidationScript.Append("<script language=javascript>")
        strValidationScript.Append("function ValidateAdvancedFilters() {")
        strClearFilterScript.Append("function ClearFilter() {")

        For Each drFilter As DataRow In m_dsAdvancedFilters.Tables(0).Rows
            strFilterName = CommonFunctions.Data.CheckIsDBNull(drFilter("FilterName")).ToString()
            strFilterCaption = CommonFunctions.Data.CheckIsDBNull(drFilter("FilterCaption")).ToString()
            strFilterType = CommonFunctions.Data.CheckIsDBNull(drFilter("FilterType")).ToString()
            strSQLSource = CommonFunctions.Data.CheckIsDBNull(drFilter("SQLSource")).ToString()
            strDefaultValue = CommonFunctions.Data.CheckIsDBNull(drFilter("DefaultValue")).ToString()
            blnMandatory = CType(CommonFunctions.Data.CheckIsDBNull(drFilter("Mandatory"), "0"), Boolean)

            sbHTML.Append("<tr class='clsTROdd'>")
            sbHTML.Append("<td align='right' nowrap >")
            sbHTML.Append(strFilterCaption)
            sbHTML.Append("</td>")
            sbHTML.Append("<td align='left'>&nbsp;")

            If blnMandatory Then
                If strFilterType.ToLower() = "date" Then
                    strValidationScript.Append("if (disallowBlank(GetObjectReference('','" + strFilterName + "_From" + "'),'&#39;From Date&#39; should not be left blank.',true) ){return false; }")
                    strValidationScript.Append("if (disallowBlank(GetObjectReference('','" + strFilterName + "_From" + "'),'&#39;To Date&#39; should not be left blank.',true) ){return false; }")
                Else
                    strValidationScript.Append("if (disallowBlank(GetObjectReference('','" + strFilterName + "'),'&#39;" + strFilterCaption + "&#39; should not be left blank.',true) ){return false; }")
                End If
            End If

            Select Case strFilterType.ToLower()
                Case "combobox"
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawComboBox(strFilterName, GetSQL(strSQLSource), 200, CommonFunctions.General.CheckIsNothing(Request(strFilterName), strDefaultValue).ToString(), , True, True, , blnMandatory))
                    strClearFilterScript.Append("GetObjectReference('','" + strFilterName + "').value='';")
                Case "date"
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl(strFilterName + "_From", strFilterName + "_From", value:=CommonFunctions.General.CheckIsNothing(Request(strFilterName + "_From"), strDefaultValue).ToString(), FormName:="frmCrossTabGridReport", returnHTML:=True, IsMandatory:=blnMandatory))
                    sbHTML.Append("&nbsp;To&nbsp;")
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawDateControl(strFilterName + "_To", strFilterName + "_To", value:=CommonFunctions.General.CheckIsNothing(Request(strFilterName + "_To"), strDefaultValue).ToString(), FormName:="frmCrossTabGridReport", returnHTML:=True, IsMandatory:=blnMandatory))
                    strValidationScript.Append("if (disallowDate1GreaterThanDate2(GetObjectReference('','" + strFilterName + "_From" + "'),GetObjectReference('','" + strFilterName + "_To" + "'),'&#39;From Date&#39; should not be greater than &#39;To Date&#39;.',true)){return false; }")
                    strClearFilterScript.Append("GetObjectReference('','" + strFilterName + "_From" + "').value='';")
                    strClearFilterScript.Append("GetObjectReference('','" + strFilterName + "_To" + "').value='';")
                Case Else
                    ''''Commented And Added By Vaijat K On 06/10/2015
                    '''sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox(strFilterName, strFilterName, , 100, 50, CommonFunctions.General.CheckIsNothing(Request(strFilterName)).ToString(), returnHTML:=True, IsMandatory:=blnMandatory))
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox(strFilterName, strFilterName, , 100, 50, CommonFunctions.General.CheckIsNothing(Request(strFilterName)).ToString(), returnHTML:=True, IsMandatory:=blnMandatory, EnableHTMLEncode:=True))
                    ''''End Added By Vaijat K On 06/10/2015
                    strClearFilterScript.Append("GetObjectReference('','" + strFilterName + "').value='';")
            End Select

            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
        Next
        strValidationScript.Append("return true; }")
        strClearFilterScript.Append("}")
        strValidationScript.Append(vbCrLf)
        strValidationScript.Append(strClearFilterScript.ToString())
        strValidationScript.Append("</script>")
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        sbHTML.Append("<table id=""TblBX""  class='clsGridTable'cellpadding=0 cellspacing=1 width='99.9%'>")
        sbHTML.Append("<tr class='clsTRBlank'><td  style='text-align:center;' nowrap>")
        sbHTML.Append("<span onclick='applyAdvancedFilter()' style='cursor:pointer' title='Apply Advanced Filters'><Img Border=0  src='../../Images/Check.gif' ><b>Apply</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<span onclick='ClearAdvancedFilter()' style='cursor:pointer' title='Clear Advanced Filters'><Img Border=0  src='../../Images/cssImages/Link Images/clearFilter.gif' ><b>Clear</b></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbHTML.Append("<span onclick='CloseFilter()' style='cursor:pointer' title='Close Advanced Filters'><Img Border=0  src='../../Images/delete.gif' ><b>Close</b></span>")
        sbHTML.Append("</td></tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        'End Addition

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        CommonFunctions.General.WriteHTML(strValidationScript.ToString())

        strClearFilterScript = Nothing
        strValidationScript = Nothing
        sbHTML = Nothing
        dsCrossTabReportXFilter = Nothing
        dsCrossTabReportYFilter = Nothing

    End Sub


    Protected Sub ExportToReport()
        '=====================================================================
        ' Procedure Name        : ExportToReport()
        ' Purpose               : To write the query list page
        ' Description           : To write the page
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           : Module variables are present
        ' Dependencies          : CommonFucntions.dll, Generic.dll
        '                         
        ' Author                : MahendraV
        ' Created               : Dec 23,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader

        Dim strCTSQL As String
        Dim sbCTSQL As System.Text.StringBuilder 'Added By PushkarK On Monday, February 20, 2006
        Dim blnNoRecords As Boolean = False

        Try
            If Not m_dsCrossTabReport Is Nothing And m_dsCrossTabReport.Tables(0).Rows.Count = 0 Then
                blnNoRecords = True
            Else
                blnNoRecords = False
            End If

            Dim strMenu As String = ""
            If blnNoRecords Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_Help")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                Dim arrCSFunction() As String = {"Help_OnClick('CROSSTABREPORT_" + m_strGroupReportID + "')"}
                Dim arrImagePaths() As String = {"../../Images/cssImages/Link images/help.gif"}
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, True)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrCSFunction = Nothing
                arrImagePaths = Nothing
            Else

                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PDF"), MyBase.GetResourceString("MENU_HTML"), MyBase.GetResourceString("MENU_RTF"), _
                                            MyBase.GetResourceString("MENU_EXCEL"), MyBase.GetResourceString("MENU_CSV"), MyBase.GetResourceString("MENU_Text"), MyBase.GetResourceString("MENU_XML"), MyBase.GetResourceString("MENU_Help")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PDF_TOOLTIP"), MyBase.GetResourceString("MENU_HTML_TOOLTIP"), MyBase.GetResourceString("MENU_RTF_TOOLTIP"), _
                                                  MyBase.GetResourceString("MENU_EXCEL_TOOLTIP"), MyBase.GetResourceString("MENU_CSV_TOOLTIP"), MyBase.GetResourceString("MENU_Text_TOOLTIP"), MyBase.GetResourceString("MENU_XML_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                Dim arrCSFunctions() As String = {"ViewReport_OnClick('PDF')", "ViewReport_OnClick('HTML')", "ViewReport_OnClick('RTF')", "ViewReport_OnClick('EXCEL')", "ViewReport_OnClick('CSV')", "ViewReport_OnClick('TEXT')", "ViewReport_OnClick('XML')", "Help_OnClick('CROSSTABREPORT_" + m_strGroupReportID + "')"}
                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunctions, arrMenuToolTip, True)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrCSFunctions = Nothing
            End If
            With Response
                .Write(strMenu)
                .Write("<BR>")
                .Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'>")
                .Write("<TR class=clsTREven>")
                .Write("<TD align=LEFT><b>")
                .Write(m_strCTReportTitle)
                .Write("</b></TD>")
                .Write("</TR>")
                .Write("</TABLE>")
                If m_strAction.ToUpper = "REPORT" Then
                    GenerateReport(m_strSQL, m_strCTReportTitle)
                End If
                .Write("<BR>")
                .Write("<BR>")

                If m_strMode.ToUpper = "DETAILQUERY" Then
                    .Write("<TABLE class=clsTable width=100% cellpadding=0 cellspacing=0 >")
                    .Write("<TR class=clsTROdd align=left>")
                    .Write("<TD><B>Filter On : </B>")
                    .Write("<B>[</B>" + m_strXAxis + "<B>]</B>-> " + m_strDQXAxis + " <B>Vs [</B>" + m_strYAxis + "<B>]</B>-> " + m_strDQYAxis)
                    .Write("</TD>")
                    .Write("</TR>")
                    .Write("</TABLE><BR>")
                    Call SetCurrentIndexForPaging()
                    m_intTotalRow = CType(IIf(Not m_dsCrossTabReport Is Nothing, m_dsCrossTabReport.Tables(0).Rows.Count, 0), Integer)
                    Call CalculateNoOfpagesForPaging()
                    CommonFunctions.General.WriteHTML(DrawPaging())
                    Call PlotCrossTabReportGrid()
                Else
                    .Write("<DIV id=DivMain style='overflow:auto;width:100%' height=300 >")
                    If blnNoRecords Then
                        'MyBase.InitializeResources("Resources.StandardMessages", "Resources")
                        With Response
                            .Write("<TABLE class=clsTable width=100% cellpadding=0 cellspacing=0 >")
                            .Write("<TR class=clsTROdd align=center>")
                            .Write("<TD>")
                            .Write("There are no items to show in this view.")
                            .Write("</TD>")
                            .Write("</TR>")
                            .Write("</TABLE>")
                        End With
                    End If
                    .Write("<BR>")
                    .Write("</DIV>")
                End If
                .Write(strMenu)

            End With

        Catch ex As Exception
            sbCTSQL = Nothing
            ex.Source = "QRB_Output->WritePage"
            'Throw ex
        End Try
    End Sub
    Protected Function GetReportSQL()
        '=====================================================================
        ' Procedure Name        : GetReportSQL()
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : SQL, Title of the report
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : DynamicReports.dll
        ' Author                : MahendraV
        ' Created               : 23-Dec-2008
        ' Revisions             :

        '=====================================================================
        Dim strSQL As String
        Dim sbSQL As New System.Text.StringBuilder

        sbSQL.Length = 0
        If m_strSource <> "" Then
            If m_strEntityType = "V" Then
                sbSQL.Append(" EXEC usp_SEL_SEM_CrossTab ")
                sbSQL.Append("@Yaxis = N'")
                sbSQL.Append(m_strYAxis)
                sbSQL.Append("' , ")
                sbSQL.Append("@Xaxis=N'")
                sbSQL.Append(m_strXAxis)
                sbSQL.Append("' , ")
                sbSQL.Append("@Formula =N'")
                sbSQL.Append(m_strFormula)
                sbSQL.Append("' , ")
                sbSQL.Append("@Attribute=N'")
                sbSQL.Append(m_strAttribute)
                sbSQL.Append("' , ")
                sbSQL.Append("@Source=N'")
                sbSQL.Append(m_strSource)

                If m_strWhereClause <> "" Then
                    sbSQL.Append("',@WhereClause=N'")
                    sbSQL.Append(m_strWhereClause)
                End If

                sbSQL.Append("' ")
                If m_strXAxisFilterString <> "" Then
                    sbSQL.Append(",@XAxisFilter=N'")
                    sbSQL.Append(CommonFunctions.General.BuildQueryString(m_strXAxisFilterString))
                    sbSQL.Append("'")
                Else
                    sbSQL.Append(",@XAxisFilter=NULL")
                End If
                If m_strYAxisFilterString <> "" Then
                    sbSQL.Append(",@YAxisFilter=N'")
                    sbSQL.Append(CommonFunctions.General.BuildQueryString(m_strYAxisFilterString))
                    sbSQL.Append("'")
                Else
                    sbSQL.Append(",@YAxisFilter=NULL")
                End If

                If m_strProjectID = "1" Then
                    sbSQL.Append(" , @intProjectID=")
                    If m_lngProjectID.ToString <> "" Then
                        sbSQL.Append(m_lngProjectID.ToString)
                    Else
                        sbSQL.Append("0")
                    End If

                End If

                sbSQL.Append(" , @XaxisOrderBy=")
                If m_strXAxisOrderBy <> "" Then
                    sbSQL.Append("N'" + m_strXAxisOrderBy + "'")
                Else
                    sbSQL.Append("NULL")
                End If
                sbSQL.Append(" , @YaxisOrderBy=")
                If m_strYAxisOrderBy <> "" Then
                    sbSQL.Append("N'" + m_strYAxisOrderBy + "'")
                Else
                    sbSQL.Append("NULL")
                End If

                sbSQL.Append(" , @EmployeeFilterOn=")
                If m_strYAxisOrderBy <> "" Then
                    sbSQL.Append("N'" + m_strEmployeeFilterOn + "'")
                Else
                    sbSQL.Append("NULL")
                End If
                sbSQL.Append(" , @intUserID=")
                If m_strYAxisOrderBy <> "" Then
                    sbSQL.Append("N'" + m_strUserID + "'")
                Else
                    sbSQL.Append("61")
                End If
                sbSQL.Append(" , @btnShowEvenReleaseFromProject=")
                sbSQL.Append(m_strShowEvenReleaseFromProject)
                sbSQL.Append(" , @intLoginID=")
                If m_strLoginID <> "0" Then
                    sbSQL.Append(m_strLoginID)
                Else
                    sbSQL.Append("NULL")
                End If
                sbSQL.Append(" , @strLoginType='")
                sbSQL.Append(strLoginType)
                sbSQL.Append("'")

            Else
                sbSQL.Append(" EXEC  ")
                sbSQL.Append(m_strSource)
                m_strWhereClause = " @intUserID = " + m_strUserID + "," + m_strWhereClause
                'Added By Amol Changle On: 09 Feb 2009
                'Purpose: To view reports Financial year wise
                If m_blnIsFYDriven Then
                    'm_strWhereClause = "@PeriodID=" + m_strFYPeriod + "," + m_strWhereClause
                    m_strWhereClause = "@PeriodID=" + m_strFYPeriod + IIf(m_strWhereClause <> "", "," + m_strWhereClause, "").ToString()
                End If
                'End Addition

                If m_strWhereClause <> "" Then
                    sbSQL.Append(" ")
                    sbSQL.Append(m_strWhereClause)
                End If

                If m_strXAxisFilterString <> "" Then
                    sbSQL.Append(" @XAxisFilter=N'")
                    sbSQL.Append(CommonFunctions.General.BuildQueryString(m_strXAxisFilterString))
                    sbSQL.Append("'")
                Else
                    sbSQL.Append(" @XAxisFilter=NULL")
                End If
                If m_strYAxisFilterString <> "" Then
                    sbSQL.Append(",@YAxisFilter=N'")
                    sbSQL.Append(CommonFunctions.General.BuildQueryString(m_strYAxisFilterString))
                    sbSQL.Append("'")
                Else
                    sbSQL.Append(",@YAxisFilter=NULL")
                End If

                If m_strProjectID = "1" Then
                    If m_lngProjectID.ToString <> "" Then
                        sbSQL.Append(" , @intProjectID=")
                        sbSQL.Append(m_lngProjectID.ToString)
                    Else
                        sbSQL.Append(" , @intProjectID=0")
                    End If
                End If

                If m_blnIsFYDriven = True Then

                    If m_StartDate <> "" Then
                        sbSQL.Append(" , @dtFromDate='" + m_StartDate + "'")
                    End If
                    If m_EndDate <> "" Then
                        sbSQL.Append(" , @dtToDate='" + m_EndDate + "'")
                    End If

                End If

                'Added By Amol Changle On: 13 Apr 2009
                'Purpose: To append advanced filters
                Dim strAdvancedFilterWhereClause As String = ""

                If m_strMode.ToLower() = "view" Then
                    strAdvancedFilterWhereClause = CommonFunctions.General.CheckIsNothing(Session("AdvancedFilterWhereClause")).ToString()
                Else
                    If m_dsAdvancedFilters.Tables(0).Rows.Count > 0 Then
                        strAdvancedFilterWhereClause = GetAdvancedFilterWhereClause()
                    End If
                End If

                If strAdvancedFilterWhereClause <> "" Then
                    sbSQL.Append(",@strWhereClause=N'")
                    sbSQL.Append(CommonFunctions.General.BuildQueryString(strAdvancedFilterWhereClause))
                    sbSQL.Append("'")

                    Session("AdvancedFilterWhereClause") = strAdvancedFilterWhereClause
                End If
                'End Addition

            End If
        End If

        strSQL = sbSQL.ToString()

        ' strSQL = "Exec usp_SEL_SEM_CrossTab  @Yaxis='" & strYAxis & "',@Xaxis='" & strXAxis & "',@Formula='" & strFormula & "',@Attribute='" & strFunctionAttribute & "',@Source='" & strSource & "',@WhereClause='" & strWhereClause & "'"

        Return strSQL
    End Function
    Private Sub SetCurrentIndexForPaging()
        '=====================================================================
        ' Procedure Name		:	SetCurrentIndexForPaging
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To set current index for paging.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	15 Mar 2008
        ' Revisions				:	
        '=====================================================================
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCurPageNumber"), "") <> "" Then
            m_curPageNumber = CInt(CommonFunction.General.CheckIsNothing(Request.Form("txtCurPageNumber"), 1))
        End If
        If m_curPageNumber <= 1 Then
            m_curIndex = 0
        Else
            m_curIndex = (m_curPageNumber - 1) * m_PageSize
        End If
    End Sub
    Private Sub CalculateNoOfpagesForPaging()
        '=====================================================================
        ' Procedure Name		:	CalculateNoOfpagesForPaging
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To calculate no of pages for paging.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	15 Mar 2008
        ' Revisions				:	
        '=====================================================================
        If m_intTotalRow Mod m_PageSize <> 0 Then
            m_NoOfpages = Math.Floor(m_intTotalRow / m_PageSize) + 1
        Else
            m_NoOfpages = Math.Floor(m_intTotalRow / m_PageSize)
        End If
    End Sub
    Private Function DrawPaging() As String
        '=====================================================================
        ' Procedure Name        : DrawPaging()
        ' Purpose               : To Plot Paging
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : April  01,2008
        ' Revisions             :
        '=====================================================================

        Dim sbPagingSQL As StringBuilder

        sbPagingSQL = New StringBuilder("<TABLE id='tblFilter02379' CellSpacing=0 BORDER=0 class='clsTable' width='100%'><TR align=Left class='clsTRSectionHeader' >")

        If m_blnIsFYDriven And m_strMode.ToLower <> "detailquery" And m_strEntityType.ToUpper = "P" Then

            sbPagingSQL.Append("<td align='left' valign='top' nowrap>")
            sbPagingSQL.Append("<b>Financial Year:</b>&nbsp;&nbsp;<img src='../../Images/NumNavPreviousEnable.gif' alt='Previous Financial Period' onclick='javascript:ShowPreviousFY(""" + strPreviousFYTitle + """)' align='top'  >")
            sbPagingSQL.Append("<input type=hidden id='txtFYPeriod' name='txtFYPeriod' value='" + m_strFYPeriod + "'><input type ='text' name='TxtDummy' id='TxtDummy'  value='" + strCurrentFYTitle + "' readonly  style=' font-weight:bold;text-align:center ;  width:" + IIf(m_FinancialType = "Y", "80px ", "200px ") + " ' class='clsTextBox'   />")
            sbPagingSQL.Append("<img src='../../Images/NumNavNextEnable.gif' alt='Next Financial Period' onclick='javascript:ShowNextFY(""" + strNextFYTitle + """)' align='top' >")
            sbPagingSQL.Append("</td>")
        End If

        'If m_strMode.ToLower() <> "graph" Then
        sbPagingSQL.Append("<TD align='right' valign='center' width=85%>")
        sbPagingSQL.Append("<img src='../../Images/NumNavFirstEnable.gif' alt='First Record' onclick='javascript:ShowFirstPage()' align='top'>")
        sbPagingSQL.Append("<img src='../../Images/NumNavPreviousEnable.gif' alt='Previous Record' onclick='javascript:ShowPreviousPage()' align='top'>")
        If m_curIndex = -1 Or m_intTotalRow = 0 Then
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''sbPagingSQL.Append(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, , "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True))
            sbPagingSQL.Append(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, , "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True, EnableHTMLEncode:=True))
            ''''End Added By Vaijat K On 06/10/2015
        Else
            ''''Commented And Added By Vaijat K On 06/10/2015
            '''sbPagingSQL.Append(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, m_curPageNumber, "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True))
            sbPagingSQL.Append(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, m_curPageNumber, "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True, EnableHTMLEncode:=True))
            ''''End Added By Vaijat K On 06/10/2015
        End If
        sbPagingSQL.Append("<img src='../../Images/NumNavNextEnable.gif' alt='Next Record' onclick='Javascript:ShowNextPage()' align='top'>")
        sbPagingSQL.Append("<img src='../../Images/NumNavLastEnable.gif' alt='Last Record' onclick='Javascript:ShowLastPage()' align='top'>")
        sbPagingSQL.Append(" of " + m_NoOfpages.ToString)
        sbPagingSQL.Append("</TD>")
        'End If
        sbPagingSQL.Append("</tr></table><br/>")
        Return sbPagingSQL.ToString()
    End Function

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
        ' Author                : ArchanaN
        ' Created               : 22-Dec-2008
        ' Revisions             :

        '=====================================================================
        Dim strFormat As String = ""
        Dim strFilePath As String = ""
        Dim dr As IDataReader

        strFormat = UCase(Trim(Request.QueryString("Format") & "") & "")
        objReport = New DynamicReports.Report


        dr = CommonFunctions.Data.GetDataReader(SQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), CommonFunctions.Application.ConnectionString)
        If dr.Read Then
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

            With objReport
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
            Response.Redirect("../CRW/CRW_ReportOutput.aspx?filename=" + m_strFileName, True)
        Else
            ' no data present..show the msg to the user
            m_intShowMessage = 1
            '  m_strDXUFileName = CommonFunction.Data.GetDataScalar("select SystemFileName from tbl_DXU_Attachments Where TemplateID =  " & m_lngTemplateID.ToString, True)
            'Response.Redirect("../General/ViewAttachment.aspx?FromWhere=DXU&FileName=" + m_strDXUFileName, True)
        End If

        CommonFunctions.Data.DisposeDataReader(dr)
        objReport = Nothing

    End Sub

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
    End Sub

    Private Sub objReport_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As DynamicReports.WAF_Control) Handles objReport.Control_BeforePlot
        If Args.DataField.ToUpper = "CROSSTABORDERNO" Or Args.DataField.ToUpper = "COLORDERY" Then
            Cancel = True
        End If

        If Args.DataField.IndexOf("-$-") <> -1 Then
            If Args.ControlType.ToLower() = "label" Then
                Args.ControlText = Args.ControlText.Replace("-$-", " ")
            End If
        End If
        If Args.ControlText = "(** No Access)" Then
            Cancel = True
        End If
        If Args.ControlText = "Generated By: " Then
            Args.ControlText = "Generated By: " + m_strUserName
        End If
    End Sub

    Private Sub m_objCrossTabReportGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objCrossTabReportGrid.ColumnHeaderTD_BeforePrint
        If m_strMode.ToUpper = "DETAILQUERY" Then
            If Args.ColumnName.ToLower = "employeeid" Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub m_objCrossTabReportGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objCrossTabReportGrid.ColumnHeaderTR_BeforePrint
        If m_strMode = "" And (m_strGroupReportID = 262 Or m_strGroupReportID = 269 Or m_strGroupReportID = 276 Or m_strGroupReportID = 313 Or m_strGroupReportID = 323 Or m_strGroupReportID = 333 Or m_strGroupReportID = 343) Then

            Dim strCurrentGroup As String = ""
            Dim strPreviousGroup As String = ""
            Dim sbTopRow As New StringBuilder()
            Dim sbBottomRow As New StringBuilder()

            sbTopRow.Append("<thead class='clsTRColumnHeader'><TH class='Locked' >")
            sbTopRow.Append(m_objCrossTabReportGrid.GridDataTable.Columns(0).ColumnName)
            sbTopRow.Append("</TH>")
            sbBottomRow.Append("<tr class='clsTRColumnHeader'><td  class='Locked' >&nbsp;</td>")

            For Each Dc As DataColumn In m_objCrossTabReportGrid.GridDataTable.Columns
                If Dc.ColumnName.IndexOf(" -$-") > 0 Then

                    strCurrentGroup = Dc.ColumnName.Substring(0, Dc.ColumnName.IndexOf(" -$-"))
                    If strPreviousGroup <> strCurrentGroup Then
                        sbTopRow.Append("<TH colspan='3' style='text-align:center' class='DivMain' ")
                        sbTopRow.Append(" >")
                        sbTopRow.Append(Dc.ColumnName.Substring(0, Dc.ColumnName.IndexOf(" -$-")))
                        sbTopRow.Append("</th>")
                        strPreviousGroup = strCurrentGroup
                    End If
                    sbBottomRow.Append("<td  class='DivMain' ")

                    sbBottomRow.Append(" align='right' nowrap  class='DivMain' >")
                    sbBottomRow.Append(Dc.ColumnName.Substring(Dc.ColumnName.IndexOf(" -$-") + 4))
                    sbBottomRow.Append("</td>")
                End If
            Next

            'sbTopRow.Append("<TH  class='DivMain' >Total</TH> <TH  class='DivMain'   align='right' >%</TH>")
            sbTopRow.Append("</thead>")
            ' sbBottomRow.Append("<td  class='DivMain' ></td> <td   class='DivMain'  align='right' ></td>")
            sbBottomRow.Append("</tr>")

            Args.StringToBeInserted += sbTopRow.ToString()
            Args.StringToBeInserted += sbBottomRow.ToString()
            Cancel = True
        End If

    End Sub

    Private Sub m_objCrossTabReportGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objCrossTabReportGrid.DataRowTD_BeforePrint
        If m_strMode.ToUpper <> "DETAILQUERY" Then
            If Args.ColIndex <> 0 Then
                If m_strDetailQuery <> "" Then
                    If CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "0").ToString() <> "0" And CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "").ToString() <> "" Then

                        If (m_strEntityType = "P" Or Args.ColIndex < Args.DataReader.ItemArray.Length - 2) And Args.ColumnName <> "%" And Args.ColumnName.ToLower <> "turnover rate(%)" And m_strFixedColumns.ToLower().IndexOf(Args.ColumnName.ToLower) = -1 And ("276,262,269,343,333,323,313".IndexOf(m_strGroupReportID) = -1 Or ("276,262,269,343,333,323,313".IndexOf(m_strGroupReportID) <> -1 And Args.ColumnName.IndexOf("%") = -1)) Then
                            Cancel = True
                            'Args.StringToBeInserted = "<TD align='right'><A href=""javascript:Detail_OnClick('" + Args.ColumnName.ToString() + "','" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(0)).ToString() + "'," + m_intCTReportID.ToString() + ")"" ><B>"
                            Args.StringToBeInserted = "<TD align='right'><A href=""javascript:Detail_OnClick('" + EncodeParemeter(Args.ColumnName.ToString()) + "','" + EncodeParemeter(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(0)).ToString()) + "'," + m_intCTReportID.ToString() + ")"" ><B>"

                            ' if column is numeric then only apply numeric formatting 
                            Select Case Args.DataType.ToString.ToUpper()

                                Case "SYSTEM.DOUBLE", "SYSTEM.INT16", "SYSTEM.INT32", "SYSTEM.INT64", "SYSTEM.DECIMAL", "SYSTEM.SINGLE", "SYSTEM.SBYTE", "SYSTEM.BYTE"

                                    If m_strFormula.ToUpper() <> "COUNT" Then
                                        Args.StringToBeInserted += FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "0"), 2).ToString()
                                    Else
                                        Args.StringToBeInserted += FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "0"), 0).ToString()
                                    End If
                                Case Else
                                    Args.StringToBeInserted += CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "")
                            End Select

                        End If
                        Args.StringToBeInserted += "</B></A></TD>"
                    Else
                        Cancel = True

                        Args.StringToBeInserted = "<TD align='right'>"

                        ' if column is numeric then only apply numeric formatting 
                        Select Case Args.DataType.ToString.ToUpper()

                            Case "SYSTEM.DOUBLE", "SYSTEM.INT16", "SYSTEM.INT32", "SYSTEM.INT64", "SYSTEM.DECIMAL", "SYSTEM.SINGLE", "SYSTEM.SBYTE", "SYSTEM.BYTE"
                                If m_strFormula.ToUpper() <> "COUNT" Then
                                    Args.StringToBeInserted += FormatNumber(CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "0"), 2).ToString()
                                Else
                                    Args.StringToBeInserted += CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "0").ToString()
                                End If
                            Case Else
                                Args.StringToBeInserted += CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.ColIndex), "")
                        End Select

                        Args.StringToBeInserted += "</TD>"
                    End If
                End If 'Detail Query end
                
            End If
        Else
            If Args.ColumnName.ToLower = "employeeid" Then
                Cancel = True
            End If
        End If

    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If Args.FunctionName.ToUpper() = "SHOWFILTERX_ONCLICK()" Then
            Cancel = True
            Args.StringToBeInserted = "| <A class='Menu' style='' ID = 'ShowFilterX_OnClickUI_HEAD0-6350' HREF='Javascript:ShowFilterX_OnClick()' Title='Show X-Axis Filter' > <Img Border=0 src='../../Images//cssImages/Link Images/Filter.gif'>&nbsp;X-Axis</A>"
        End If
        If Args.FunctionName.ToUpper() = "HIDEFILTERX_ONCLICK()" Then
            Cancel = True
            Args.StringToBeInserted = "<A class='Menu' style='display:none' ID = 'HideFilterX_OnClickUI_HEAD0-6350' HREF='Javascript:HideFilterX_OnClick()' Title='Hide Y-Axis Filter'><Img Border=0 src='../../Images//cssImages/Link Images/Close.gif'>&nbsp;X-Axis</A>"
        End If

        If Args.FunctionName.ToUpper() = "SHOWFILTERY_ONCLICK()" Then
            Cancel = True
            Args.StringToBeInserted = "| <A class='Menu' style='' ID = 'ShowFilterY_OnClickUI_HEAD0-6350' HREF='Javascript:ShowFilterY_OnClick()' Title='Show Y-Axis Filter' > <Img Border=0 src='../../Images//cssImages/Link Images/Filter.gif'>&nbsp;Y-Axis</A>"
        End If
        If Args.FunctionName.ToUpper() = "HIDEFILTERY_ONCLICK()" Then
            Cancel = True
            Args.StringToBeInserted = "<A class='Menu' style='display:none' ID = 'HideFilterY_OnClickUI_HEAD0-6350' HREF='Javascript:HideFilterY_OnClick()' Title='Hide Y-Axis Filter'><Img Border=0 src='../../Images//cssImages/Link Images/Close.gif'>&nbsp;Y-Axis</A>"
        End If
        'Added By Amol Changle On: 06 Apr 2009
        If Args.FunctionName.ToUpper() = "SHOWADVANCEDFILTERS_ONCLICK()" Then
            Cancel = True
            Args.StringToBeInserted = "| <A class='Menu' style='' ID = 'ShowAdvancedFilters_OnClickUI_HEAD0-6350' HREF='Javascript:ShowAdvancedFilters_OnClick()' Title='Show Advanced Filters' > <Img Border=0 src='../../Images//cssImages/Link Images/Filter.gif'>&nbsp;Advanced Filters</A>"
        End If
        If Args.FunctionName.ToUpper() = "HIDEADVANCEDFILTERS_ONCLICK()" Then
            Cancel = True
            Args.StringToBeInserted = "<A class='Menu' style='display:none' ID = 'HideAdvancedFilters_OnClickUI_HEAD0-6350' HREF='Javascript:HideAdvancedFilters_OnClick()' Title='Hide Advanced Filters'><Img Border=0 src='../../Images//cssImages/Link Images/Close.gif'>&nbsp;Advanced Filters</A>"
        End If
        'End Addition
    End Sub

    Protected Function DrawGraph() As Boolean
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
        ' Created               : Nov 08,2005
        ' Revisions             : 
        '=====================================================================

        Dim dr As IDataReader
        Dim drGraph, drTemp As IDataReader
        Dim objGraph As Graph.Graph
        'Dim strChartType As String
        Dim strImageFileName As String = ""
        'Dim blnShowLegends As Boolean = False
        Dim blnShowCaptions As Boolean = True
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        'Dim strNomenclature As String = m_GraphNomencleture
        Dim arrstrChartType() As String
        Dim arrstrLegendColor() As String
        Dim ddChart As New Dundas.Charting.WebControl.Chart

        Dim strVirtualImgPath As String
        Dim m_strPalleteStyle As String
        Dim arrNomaneCleature As String = "Amount"
        Dim intGraphHeight As Integer = 425
        Dim intGraphWidth As Integer = 900
        Dim i As Integer, iRecordCount As Integer
        Dim strQuery As String
        Dim strGraphDescription As String = ""
        Dim sngMapCords() As Single = {0, 0, 300, 375}
        Dim strSQL As New StringBuilder
        Dim StrSQLPlanned As New StringBuilder
        Dim strSQLActual As New StringBuilder
        Dim strExtendedSQL(1) As String
        Dim blnShowLegends As Boolean
        Dim strMenu As String
        Dim arrGraphType As String() = {"COLUMN", "BAR", "LINE", "SPLINE", "STEPLINE", "BUBBLE", "POINT", "AREA", "SPLINEAREA"}
        Dim iGraphType As Integer

        Dim arrMenu() As String = {"Close", MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {"Close", MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunctions() As String = {"Close_OnClick()", "Help_OnClick('CROSSTABREPORT_" + m_strGroupReportID + "')"}
        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunctions, arrMenuToolTip, True)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrCSFunctions = Nothing
        Dim strClientScript As New StringBuilder

        Call DrawFilter()

        'Dim drFYTitle As IDataReader
        'Dim strCurrentFYTitle As String
        'Dim strPreviousFYTitle As String
        'Dim strNextFYTitle As String

        'drFYTitle = CommonFunctions.Data.GetDataReader("Usp_Sel_Tbl_SEM_FinancialYear_Master_GetTitle " + m_strFYPeriod + ",'" + m_FinancialType + "'", True)

        'If drFYTitle.Read() Then
        '    strCurrentFYTitle = CommonFunctions.Data.CheckIsDBNull(drFYTitle("CurrentFYTitle"))
        '    strPreviousFYTitle = CommonFunctions.Data.CheckIsDBNull(drFYTitle("PreviousFYTitle"))
        '    strNextFYTitle = CommonFunctions.Data.CheckIsDBNull(drFYTitle("NextFYTitle"))
        'End If
        'drFYTitle.Dispose()


        Dim dsGraph As DataSet

        dsGraph = CommonFunction.Data.GetDataSet(m_strSQL, "tblGraph", , , CommonFunction.General.GetApplicationKeySetting("UseSQL"))

        With Response
            '.Write(strMenu)
            .Write(InitializeMenu())
            .Write("<BR>")
            .Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'>")
            .Write("<TR class=clsTREven>")
            .Write("<TD align=LEFT><b>")
            .Write(m_strCTReportTitle)
            .Write("</b></TD>")

            If m_blnIsFYDriven Then
                .Write("<td align='left' valign='top' nowrap>")
                .Write("<b>Financial Year:</b>&nbsp;&nbsp;<img src='../../Images/NumNavPreviousEnable.gif' alt='Previous Financial Period' onclick='javascript:ShowPreviousFY(""" + strPreviousFYTitle + """)' align='top'  >")
                .Write("<input type=hidden id='txtFYPeriod' name='txtFYPeriod' value='" + m_strFYPeriod + "'><input type ='text' name='TxtDummy' id='TxtDummy'  value='" + strCurrentFYTitle + "' readonly  style=' font-weight:bold; text-align:center ; width:" + IIf(m_FinancialType = "Y", "80px ", "200px ") + " ' class='clsTextBox'   />")
                .Write("<img src='../../Images/NumNavNextEnable.gif' alt='Next Financial Period' onclick='javascript:ShowNextFY(""" + strNextFYTitle + """)' align='top' >")
                .Write("</td>")
            End If

            '==============
            Call SetCurrentIndexForPaging()
            m_intTotalRow = CType(IIf(Not dsGraph Is Nothing, dsGraph.Tables(0).Rows.Count, 0), Integer)
            Call CalculateNoOfpagesForPaging()
            .Write("<TD align='right' valign='center'>")
            .Write("<img src='../../Images/NumNavFirstEnable.gif' alt='First Record' onclick='javascript:ShowFirstPage()' align='top'>")
            .Write("<img src='../../Images/NumNavPreviousEnable.gif' alt='Previous Record' onclick='javascript:ShowPreviousPage()' align='top'>")
            If m_curIndex = -1 Or m_intTotalRow = 0 Then
                ''''Commented And Added By Vaijat K On 06/10/2015
                '''.Write(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, , "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True))
                .Write(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, , "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True, EnableHTMLEncode:=True))
                ''''End Added By Vaijat K On 06/10/2015
            Else
                ''''Commented And Added By Vaijat K On 06/10/2015
                '''.Write(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, m_curPageNumber, "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True))
                .Write(CommonFunction.HTMLControls.DrawTextBox("txtCurPageNumber", "txtCurPageNumber", , 50, 4, m_curPageNumber, "right", , , , , , "onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", True, EnableHTMLEncode:=True))
                ''''End Added By Vaijat K On 06/10/2015
            End If
            .Write("<img src='../../Images/NumNavNextEnable.gif' alt='Next Record' onclick='Javascript:ShowNextPage()' align='top'>")
            .Write("<img src='../../Images/NumNavLastEnable.gif' alt='Last Record' onclick='Javascript:ShowLastPage()' align='top'>")
            .Write(" of " + m_NoOfpages.ToString)
            .Write("</TD>")
            '==============

            '.Write("<td align='left' valign='top' nowrap>")
            '.Write("<b>Financial Year:</b>&nbsp;&nbsp;<img src='../../Images/NumNavPreviousEnable.gif' alt='Previous Financial Year' onclick='javascript:ShowPreviousFY(""" + strPreviousFYTitle + """)' align='top'>")
            '.Write("<input type=hidden id='txtFYPeriod' name='txtFYPeriod' value='" + m_strFYPeriod + "'><input type ='text' name='TxtDummy' id='TxtDummy'  value='" + strCurrentFYTitle + "' readonly  style=' font-weight:bold; width:80px ' class='clsTextBox'   />")
            '.Write("<img src='../../Images/NumNavNextEnable.gif' alt='Next Financial Year' onclick='javascript:ShowNextFY(""" + strNextFYTitle + """)' align='top'>")
            '.Write("</td>")
            .Write("<td align=right><b>Graph Type:</b>&nbsp;&nbsp;")
            .Write(CommonFunctions.HTMLControls.DrawComboBox("CboGraphType", "usp_SEL_KPI_GraphType", , "COLUMN", ToBeInserted:="onchange='javascript:CboGraphType_OnChange(this)'", ReturnAsHTML:=True))
            .Write("</td>")
            .Write("</TR>")
            .Write("</TABLE>")
            '.Write("<BR>")
            '.Write(DrawPaging())
        End With

        Try

            dsGraph = CommonFunction.Data.GetDataSet(m_strSQL, "tblGraph", (m_curPageNumber - 1) * m_PageSize, IIf(m_intTotalRow - (m_curPageNumber - 1) * m_PageSize < m_PageSize, m_intTotalRow - (m_curPageNumber - 1) * m_PageSize, m_PageSize), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If dsGraph.Tables(0).Columns.Contains("Total") Then
                dsGraph.Tables(0).Columns.Remove("Total")
            End If
            If dsGraph.Tables(0).Columns.Contains("%") Then
                dsGraph.Tables(0).Columns.Remove("%")
            End If
            If dsGraph.Tables(0).Columns.Contains("CrossTabOrderNo") Then
                dsGraph.Tables(0).Columns.Remove("CrossTabOrderNo")
            End If
            If dsGraph.Tables(0).Columns.Contains("Total-Cnt") Then
                dsGraph.Tables(0).Columns.Remove("Total-Cnt")
            End If
            If dsGraph.Tables(0).Columns.Contains("Total-Salary") Then
                dsGraph.Tables(0).Columns.Remove("Total-Salary")
            End If
            If dsGraph.Tables(0).Columns.Contains("Total-Planned Salary") Then
                dsGraph.Tables(0).Columns.Remove("Total-Planned Salary")
            End If
            If dsGraph.Tables(0).Columns.Contains("Total-Actual Salary") Then
                dsGraph.Tables(0).Columns.Remove("Total-Actual Salary")
            End If

            If dsGraph.Tables(0).Columns.Contains("ColOrderY") Then
                dsGraph.Tables(0).Columns.Remove("ColOrderY")
            End If

            If m_strFixedColumns <> "" Then
                Dim arrFixedColumns As String() = m_strFixedColumns.Split(",")
                For intIndex As Integer = 0 To arrFixedColumns.Length - 1
                    If dsGraph.Tables(0).Columns.Contains(arrFixedColumns(intIndex)) And arrFixedColumns(intIndex) <> m_strYAxis Then
                        dsGraph.Tables(0).Columns.Remove(arrFixedColumns(intIndex))
                    End If
                Next
            End If

            If dsGraph.Tables(0).Rows(dsGraph.Tables(0).Rows.Count - 1)(0).ToString().ToLower() = "total" Then
                dsGraph.Tables(0).Rows.RemoveAt(dsGraph.Tables(0).Rows.Count - 1)
            End If


            iRecordCount = dsGraph.Tables("tblGraph").Rows.Count

            strClientScript.Append("<script language=javascript>")
            strClientScript.Append("var arrSeries=new Array();")
            For i = 0 To dsGraph.Tables(0).Columns.Count - 1
                strClientScript.Append("arrSeries[" + i.ToString() + "]=""" + EncodeParemeter(dsGraph.Tables(0).Columns(i).ToString()) + """;")
            Next
            strClientScript.Append("</script>")

            CommonFunctions.General.WriteHTML(strClientScript.ToString())
            strClientScript = Nothing

            '-- Setting some main Graph Properties
            strItemName = m_strCTReportTitle '"Graph"
            strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName()
            strImageFileName = strImageFileName.Trim

            ''-- Build Array for specifying the Chart Type for each column

            blnShowLegends = True
            blnShowCaptions = True
            m_strPalleteStyle = "EARTHTONES"

            ReDim arrstrChartType(dsGraph.Tables(0).Columns.Count - 1)
            ReDim arrstrLegendColor(dsGraph.Tables(0).Columns.Count - 1)


            For iGraphType = 0 To arrGraphType.Length - 1

                For i = 0 To dsGraph.Tables(0).Columns.Count - 1
                    arrstrChartType(i) = arrGraphType(iGraphType)
                Next

                '' create the graph for the item values
                objGraph = New Graph.Graph

                With objGraph
                    strVirtualImgPath = "../../Images/" + strImageFileName
                    .VirtualImagePath = strVirtualImgPath
                    .AbsoluteImagePath = HttpContext.Current.Server.MapPath(strVirtualImgPath)
                    .Enable3D = False
                    .ChartType = arrstrChartType
                    '-- Take settings From Database table
                    .BorderStyle = "None"
                    .BorderColor = "Black"
                    .GraphTitleColor = "white"
                    .ChartBackColor = "Wheat"
                    .ChartAreaColor = "White"
                    .ShowLegends = blnShowLegends
                    .LegendDocking = "Bottom"
                    .XAxisInterval = 1

                    .LegendStyle = "Column"
                    .LegendCaptionColor = "black"
                    .PalleteStyle = "EARTHTONES"
                    .EnableXAxis = True
                    .EnableYAxis = True
                    .EnableSmartLabels = False
                    .ShowCaptions = True
                    .GraphTitleColor = "Black"
                    '-- Fixed Settings
                    .GraphTitle = IIf(strItemName.Length > 50, Left(strItemName, 50) + "...", strItemName)
                    .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)

                    .DataSet = dsGraph
                    '.SQL = strSQL.ToString()
                    .Nomenclature = ""

                    .LCLColor = "Green"
                    .UCLColor = "Crimson"
                    .Width = intGraphWidth
                    .Height = intGraphHeight
                    .ShowExplodedPie = False
                    .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
                    .BorderGradientColor = "WHITE"
                    .BorderGradientStyle = "TOPBOTTOM"
                    .ChartBackGradientColor = "WHITE"
                    .ChartBackGradientStyle = "TOPBOTTOM"
                    .ChartAreaGradientColor = "WHITE"
                    .ChartAreaGradientStyle = "TOPBOTTOM"
                    .XAxisFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

                    .Nomenclature = m_GraphNomencleture
                    '.DrillDownClientSideFunctionName = "GraphDetail_OnClick("
                    .ChartAreaWidth = 95
                    .ChartAreaHeight = 80
                    .ShowCaptions = False
                    .LegendStyle = "Row"
                    ddChart = .GenerateChartControl()
                End With
                Dim row As HtmlTableRow
                Dim cell As HtmlTableCell

                With tblGraphs
                    row = New HtmlTableRow
                    row.ID = "TR_" + arrGraphType(iGraphType)
                    If iGraphType <> 0 Then
                        row.Attributes.Add("Style", "display:none;")
                    End If
                    .Rows.Add(row)
                    cell = New HtmlTableCell
                    cell.Attributes.Add("width", "100%")
                    cell.Attributes.Add("align", "center")
                    cell.Attributes.Add("Valign", "middle")
                    cell.Controls.Add(ddChart)
                    row.Cells.Add(cell)
                End With
            Next

            Dim SB As New System.Text.StringBuilder
            Dim SW As New System.IO.StringWriter(SB)
            Dim htmlTW As New HtmlTextWriter(SW)
            tblGraphs.RenderControl(htmlTW)
            Dim HTML As String = SB.ToString()

            SB = Nothing : SW = Nothing : htmlTW = Nothing

            dsGraph.Dispose()
            Return True
        Catch ex As Exception
            'Action to be taken when an exception is raised
            Return False
        End Try
        'objGraph = Nothing


    End Function
    Private Function EncodeParemeter(ByVal strValue As String) As String
        '=====================================================================
        ' Procedure Name        : EncodeParemeter()
        ' Purpose               : To enmcode QueryString parameters
        ' Description           : Same as above
        ' Parameters Passed     : strValue
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle 
        ' Created               : 26 Feb 2009
        ' Revisions             : 
        '=====================================================================
        strValue = strValue.Replace("'", "|||")
        strValue = strValue.Replace("""", ":::")
        strValue = strValue.Replace("#", "<HASH>")
        EncodeParemeter = strValue
    End Function


    Private Function DecodeParemeter(ByVal strValue As String) As String
        '=====================================================================
        ' Procedure Name        : DecodeParemeter()
        ' Purpose               : To decode QueryString parameters
        ' Description           : Same as above
        ' Parameters Passed     : strValue
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle 
        ' Created               : 26 Feb 2009
        ' Revisions             : 
        '=====================================================================
        strValue = strValue.Replace("|||", "'")
        strValue = strValue.Replace(":::", """")
        strValue = strValue.Replace("<HASH>", "#")
        DecodeParemeter = strValue
    End Function

    Private Sub m_objCrossTabReportGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objCrossTabReportGrid.DataRowTR_BeforePrint

        If Args.DataReader(0).ToString.ToUpper = "TOTAL" Then
            Args.StringToBeInserted = "<tr class='clsTRBlank' ><td class='' colspan=" + Args.DataReader.Table.Columns.Count.ToString() + "><!-- Comment --></td></tr>"
            Args.clsTR = "clsTRGroupHeader"
        End If

    End Sub

    Private Sub m_objCrossTabReportGrid_Div_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DIV) Handles m_objCrossTabReportGrid.Div_BeforePrint
        Dim sbColumnHeader As New StringBuilder
        sbColumnHeader.Append(CommonFunction.General.PlotStaticHeaderStyle("DivMain"))
        sbColumnHeader = sbColumnHeader.Replace("THEAD", "tr")
        sbColumnHeader = sbColumnHeader.Replace("TH.", " td.")

        CommonFunction.General.WriteHTML(sbColumnHeader.ToString())
        sbColumnHeader = Nothing
    End Sub

    Private Function GetAdvancedFilterWhereClause() As String
        Dim strWhereClause As New StringBuilder
        Dim strFilterName As String = ""
        Dim strFilterType As String = ""
        Dim strDefaulValue As String = ""
        strWhereClause.Append("1=1")
        ''  Modified by SujitG on 13 Apr 2009
        ''  Purpose :   To get filter values from querystring as well as form
        For Each drAdvancedFilter As DataRow In m_dsAdvancedFilters.Tables(0).Rows
            strFilterName = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("FilterName")).ToString()
            strFilterType = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("FilterType")).ToString()
            strDefaulValue = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("DefaultValue")).ToString()
            If strFilterName <> "" Then
                Select Case strFilterType.ToLower()
                    Case "combobox"
                        If CommonFunctions.General.CheckIsNothing(Request(strFilterName), strDefaulValue).ToString() <> "" Then
                            strWhereClause.Append(" AND <TABLE_NAME>.")
                            strWhereClause.Append(strFilterName)
                            strWhereClause.Append("=N'")
                            If Request(strFilterName) Is Nothing Then
                                strWhereClause.Append(strDefaulValue)
                            Else
                                strWhereClause.Append(Request(strFilterName).ToString())
                            End If
                            strWhereClause.Append("'")
                        End If
                    Case "date"
                        If CommonFunctions.General.CheckIsNothing(Request(strFilterName + "_From")) <> "" Then
                            strWhereClause.Append(" AND DATEDIFF(DD,<TABLE_NAME>.")
                            strWhereClause.Append(strFilterName)
                            strWhereClause.Append(",'")
                            If Request(strFilterName + "_From") Is Nothing Then
                                strWhereClause.Append(strDefaulValue)
                            Else
                                strWhereClause.Append(Request(strFilterName + "_From").ToString())
                            End If
                            strWhereClause.Append("')<=0")
                        End If
                        If CommonFunctions.General.CheckIsNothing(Request(strFilterName + "_To")) <> "" Then
                            strWhereClause.Append(" AND DATEDIFF(DD,<TABLE_NAME>.")
                            strWhereClause.Append(strFilterName)
                            strWhereClause.Append(",'")
                            If Request(strFilterName + "_To") Is Nothing Then
                                strWhereClause.Append(strDefaulValue)
                            Else
                                strWhereClause.Append(Request(strFilterName + "_To").ToString())
                            End If
                            strWhereClause.Append("')>=0")
                        End If
                    Case Else
                        If CommonFunctions.General.CheckIsNothing(Request(strFilterName)) <> "" Then
                            strWhereClause.Append(" AND <TABLE_NAME>.")
                            strWhereClause.Append(strFilterName)
                            strWhereClause.Append(" LIKE N'%")
                            If Request(strFilterName) Is Nothing Then
                                strWhereClause.Append(strDefaulValue)
                            Else
                                strWhereClause.Append(Request(strFilterName).ToString())
                            End If
                            strWhereClause.Append("%'")
                        End If
                End Select
            End If
        Next
        ''  End of modification by SujitG on 13 Apr 2009
        GetAdvancedFilterWhereClause = strWhereClause.ToString()
        strWhereClause = Nothing
    End Function

    Private Function GetAppliedFilter() As String
        '=====================================================================
        ' Procedure Name        : GetAppliedFilter()
        ' Purpose               : To get currently applied filter
        ' Description           : Same as above
        ' Parameters Passed     : strValue
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Amol Changle 
        ' Created               : 07 Apr 2009
        ' Revisions             : 
        '=====================================================================
        Dim strFilter As New StringBuilder("")
        Dim strFilterCaption As String = ""
        Dim strDefaultValue As String = ""
        Dim strFilterName As String = ""
        Dim strFilterType As String = ""
        Dim strSQLSource As String = ""

        If m_dsAdvancedFilters.Tables(0).Rows.Count > 0 Then
            For Each drAdvancedFilter As DataRow In m_dsAdvancedFilters.Tables(0).Rows
                strFilterName = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("FilterName")).ToString()
                strFilterCaption = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("FilterCaption")).ToString()
                strFilterType = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("FilterType")).ToString()
                strDefaultValue = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("DefaultValue")).ToString()
                strSQLSource = CommonFunctions.Data.CheckIsDBNull(drAdvancedFilter("SQLSource")).ToString()
                Select Case strFilterType.ToLower()
                    Case "combobox"
                        If CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName), strDefaultValue).ToString() <> "" Then
                            If strFilter.ToString() <> "" Then
                                strFilter.Append(" And ")
                            End If
                            strFilter.Append(strFilterCaption)
                            strFilter.Append("='")
                            strFilter.Append(CommonFunctions.General.GetDisplayValue(strSQLSource, CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName), strDefaultValue).ToString(), True))
                            strFilter.Append("'")
                        End If
                    Case "date"
                        'If CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_From")) <> "" And CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_To")) <> "" Then
                        If Request.Form(strFilterName + "_From") Is Nothing And Request.Form(strFilterName + "_To") Is Nothing And strDefaultValue <> "" Then
                            If strFilter.ToString() <> "" Then
                                strFilter.Append(" And ")
                            End If
                            strFilter.Append(strFilterCaption)
                            strFilter.Append("='")
                            strFilter.Append(CommonFunctions.Dates.GetDate(CType(strDefaultValue, Date)))
                            strFilter.Append("'")
                        Else
                            If CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_From")) = CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_To")) And CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_From")) <> "" Then
                                If strFilter.ToString() <> "" Then
                                    strFilter.Append(" And ")
                                End If
                                strFilter.Append(strFilterCaption)
                                strFilter.Append("='")
                                strFilter.Append(CommonFunctions.Dates.GetDate(CType(Request.Form(strFilterName + "_From").ToString(), Date)))
                                strFilter.Append("'")
                            Else
                                If CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_From")) <> "" And CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_To")) <> "" Then
                                    If strFilter.ToString() <> "" Then
                                        strFilter.Append(" And ")
                                    End If
                                    strFilter.Append("'")
                                    strFilter.Append(CommonFunctions.Dates.GetDate(CType(Request.Form(strFilterName + "_From").ToString(), Date)))
                                    strFilter.Append("'")
                                    strFilter.Append(" >= ")
                                    strFilter.Append(strFilterCaption)
                                    strFilter.Append(" <= ")
                                    strFilter.Append("'")
                                    strFilter.Append(CommonFunctions.Dates.GetDate(CType(Request.Form(strFilterName + "_To").ToString(), Date)))
                                    strFilter.Append("'")
                                ElseIf CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_From")) <> "" Then
                                    If strFilter.ToString() <> "" Then
                                        strFilter.Append(" And ")
                                    End If
                                    strFilter.Append(strFilterCaption)
                                    strFilter.Append(" >= '")
                                    strFilter.Append(CommonFunctions.Dates.GetDate(CType(Request.Form(strFilterName + "_From").ToString(), Date)))
                                    strFilter.Append("'")
                                ElseIf CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName + "_To")) <> "" Then
                                    If strFilter.ToString() <> "" Then
                                        strFilter.Append(" And ")
                                    End If
                                    strFilter.Append(strFilterCaption)
                                    strFilter.Append(" <= '")
                                    strFilter.Append(CommonFunctions.Dates.GetDate(CType(Request.Form(strFilterName + "_To").ToString(), Date)))
                                    strFilter.Append("'")
                                End If
                            End If
                        End If
                        'End If
                    Case Else
                        If CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName), strDefaultValue) <> "" Then
                            If strFilter.ToString() <> "" Then
                                strFilter.Append(" And ")
                            End If
                            strFilter.Append(strFilterCaption)
                            strFilter.Append(" contains '")
                            strFilter.Append(CommonFunctions.General.CheckIsNothing(Request.Form(strFilterName), strDefaultValue))
                            strFilter.Append("'")
                        End If
                End Select
            Next
        End If



        If strFilter.ToString() = "" Then
            GetAppliedFilter = "Applied Filter : None"
        Else
            strFilter.Insert(0, "Applied Filter : <i>", 1)
            strFilter.Append("</i>")
            strFilter.Append("&nbsp;<a style=""text-decoaration:none"" title='Clear Filter' href='javascript:ClearAdvancedFilter()'><Img Border=0  src='../../Images/cssImages/Link Images/clearFilter.gif' ></a>")
            GetAppliedFilter = strFilter.ToString()
        End If

        strFilter = Nothing

    End Function

    Private Function GetSQL(ByVal strSQL As String) As String
        GetSQL = CommonFunctions.General.ReplacePlaceHolders(strSQL, True)
    End Function


End Class