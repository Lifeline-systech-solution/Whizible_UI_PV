Public Class CRM_CounterGraphs
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        'Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
        If Request.QueryString("Mode") = "DB" Then
            If (Request.QueryString("PkShowCounterToken") <> "" And Request.QueryString("FilterID") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("FilterID"), String) + "0" + "0", Request.QueryString("PkShowCounterToken")) = False) Then

                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        'End Of Added By Chakshuta H ON 1st-Aug-2016 For PkToken Validation 
        InitializeComponent()
    End Sub

#End Region
    Private m_objGlobal As WebPages.Template.IGlobal   ' To store Global object
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Protected tblGraphs As New System.Web.UI.HtmlControls.HtmlTable
    Protected divGraphs As System.Web.UI.HtmlControls.HtmlControl
    Private m_lngEmployeeID As Integer
    Protected m_lngFilterID As Long = 0
    Private m_blnUseSQL As Boolean = True
    Private m_blnShowOtherGraphs As Boolean = True
    Protected m_strMode As String = "DB"
    Private m_strFilterText As String = ""
    Protected m_strMenu As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
    End Sub
    Protected Sub WritePage()
        Initialize()
        m_strMenu = WriteMenu()
        CommonFunctions.General.WriteHTML(m_strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        Response.Write("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:90%'>")
        GeneratePageCaption()
        DisplayGraphs(m_lngEmployeeID, "Graphs")
    End Sub
    Private Sub Initialize()
        Dim strSQL As String
        Dim drFilterText As IDataReader
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objGlobal.TagID = 3821

        m_lngEmployeeID = CInt(HttpContext.Current.Session("intUserID"))

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        End If
        If Not Request.QueryString("FilterID") Is Nothing Then
            If Request.QueryString("FilterID") <> "" Then
                m_lngFilterID = CInt(Request.QueryString("FilterID"))
            End If
        End If
    End Sub

    ''Added by Yogesh J on 19-Jan-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RequestSLA_OnClick(itemid As String, EmployeeID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(itemid, String) + CType(EmployeeID, String) + "0" + "0")

        Return m_PKToken_Request_Multiple

    End Function
    ''End of addition by Yogesh J on 19-Jan-2016
    Private Sub DisplayGraphs(ByVal UserID As Long, Optional ByVal SectionName As String = "")
        '=====================================================================
        ' Procedure Name        : DisplayNoNeedleGraphs()
        ' Purpose               : To display all the graphs for the dashboard
        ' Description           : The procedure displays all the graphs for the
        '                         dashboard
        ' Parameters Passed     : Dashboard ID, User ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Graph.dll
        ' Author                : Rajanikant
        ' Created               : November 03,2003
        ' Revisions             :
        '=====================================================================
        Dim objQRB As QueryBuilders.cQuery
        Dim drGraphs As IDataReader
        Dim dr As IDataReader
        Dim drDetails As IDataReader
        Dim intRowCount As Integer = 0
        Dim blnShowDrillDowns As Boolean
        Dim blnOracleDB As Boolean = False
        Dim strSQL As String
        Dim strGraphSQL As String
        Dim myGraph As Graph.Graph
        Dim cObjSectionTitle As WebPage.Templates.SectionTitle
        Dim strLeftSectionTitle As String = ""
        Dim strSectionTag As String = ""
        Dim strFunctionName As String = ""
        Dim blnPrinted As Boolean = False
        Dim intNoOfGraphElements As Integer = 5
        Dim lngConnectionID As Long
        Dim strConnectionString As String = ""
        Dim strImagePath As String
        Dim cell As New HtmlTableCell
        Dim row As New HtmlTableRow
        Dim intSelectIndex As Integer = 0
        'addded by harshada d on 14 feb 2006 for helpdesk enhancements
        Dim strSQLAccessibleRequests As New System.Text.StringBuilder

        If m_strMode = "DB" Then
            strSQLAccessibleRequests.Append(" LEFT JOIN dbo.fnAccessibleDepts(" & m_lngEmployeeID & ") as A ")
            strSQLAccessibleRequests.Append(" ON A.DepartmentID = v_CRM_HelpDesk_Master.FunctionID ")

            strSQLAccessibleRequests.Append(" LEFT JOIN dbo.fnAccessibleCustomers(" & m_lngEmployeeID & ") B ON B.CustomerShortName = v_CRM_HelpDesk_Master.CustomerID")

            strSQLAccessibleRequests.Append(" WHERE(1 = 1) AND (A.DepartmentID IS NOT NULL OR B.CustomerShortName IS NOT NULL)")
        ElseIf m_strMode = "SR" Then
            strSQLAccessibleRequests.Append(" WHERE	CustomerID = '" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'")
            strSQLAccessibleRequests.Append(" AND Left(LoginType,1) ='" & m_objGlobal.LoginType & "' ")

        ElseIf m_strMode = "AR" Then
            strSQLAccessibleRequests.Append(" WHERE	AssignTo =" & m_lngEmployeeID.ToString)

        End If


        If m_lngFilterID <> 0 Then
            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_Filters " & m_lngFilterID, m_blnUseSQL)
            If dr.Read Then
                If Trim(dr("FilterText").ToString & "") <> "" Then
                    m_strFilterText = " And (" & Trim(dr("FilterText").ToString) & ")"
                    'strSQLAccessibleRequests.Append(" And (" & Trim(dr("FilterText").ToString) & ")")
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        ElseIf Not Session("strCRM_Filter_DB") Is Nothing Then
            If Session("strCRM_Filter_DB").ToString <> "" Then
                m_strFilterText = " AND (" & Session("strCRM_Filter_DB").ToString & ")"
            End If
            'strSQLAccessibleRequests.Append(" AND (" & Session("strCRM_Filter_DB").ToString & ")")
        End If
        m_strFilterText = formatfiltertext(m_strFilterText)

        If m_strFilterText.Trim <> "" Then
            strSQLAccessibleRequests.Append(m_strFilterText)
        End If

        'strSQLAccessibleRequests.Append(" AND v_CRM_HelpDesk_Master.QueryID IN ")
        'strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where v_CRM_HelpDesk_Master.FunctionID IN ")
        'strSQLAccessibleRequests.Append("( SELECT DepartmentID FROM fnAccessibleDepts(" & m_lngEmployeeID & "")
        'strSQLAccessibleRequests.Append(" ))")
        'strSQLAccessibleRequests.Append("UNION")
        'strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where ")
        ''Modified by Manishk on 21st Feb 06 for SP 6 issueID 2352
        ''strSQLAccessibleRequests.Append(" v_CRM_HelpDesk_Master.CustomerID = (SELECT CustomerShortName ")
        'strSQLAccessibleRequests.Append(" v_CRM_HelpDesk_Master.CustomerID in (SELECT CustomerShortName ")
        ''End of Modified by Manishk on 21st Feb 06 for SP 6 issueID 2352
        'strSQLAccessibleRequests.Append("from fnAccessibleCustomers (" & m_lngEmployeeID & "")
        'strSQLAccessibleRequests.Append(" ))))")

        ''strSQLAccessibleRequests.Append(" GROUP BY SubRequestType ")

        'end of addition by harshada d on 14 feb 2006 for helpdesk enhancements


        ' create a collapsible section for the graph type
        strLeftSectionTitle = SectionName
        strFunctionName = "ShowHide_divGraphs"
        strSectionTag = "divGraphs"

        Response.Write("<BR>")
        strSQL = "usp_CDB_Get_UserSettings	153," & UserID & ",2,1"

        drGraphs = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While drGraphs.Read
            If Not blnPrinted Then
                If m_blnShowOtherGraphs Then
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName))
                    Response.Write("<script language=javascript>" & cObjSectionTitle.ClientsideScript & "</script>")
                    divGraphs.Attributes.Add("style", "overflow:auto" + vbCrLf)
                Else
                    cObjSectionTitle = New WebPage.Templates.SectionTitle
                    ' the section title
                    Response.Write(cObjSectionTitle.GetSectionTitle(strLeftSectionTitle, strSectionTag, strFunctionName, , , , "../../images/plus.gif"))
                    Response.Write("<script language=javascript>" & cObjSectionTitle.ClientsideScript & "</script>")
                    divGraphs.Attributes.Add("style", "overflow:auto;display:none" + vbCrLf)
                End If
                'Destroy the object
                cObjSectionTitle = Nothing
                blnPrinted = True
            End If

            If CInt(drGraphs.Item("GraphTypeID")) <> 1 Then
                With tblGraphs
                    If intRowCount = 0 Then
                        row = New HtmlTableRow
                        .Rows.Add(row)
                    End If
                    intRowCount += 1

                    cell = New HtmlTableCell
                    cell.Attributes.Add("width", "100%")
                    cell.Attributes.Add("align", "center")
                    cell.Attributes.Add("Valign", "middle")
                    ' hardcode the role-level to 1 to avoid any role level filters
                    objQRB = New QueryBuilders.cQuery(Session("strUserName").ToString, CType(Session("intPostID"), Long), CType(Session("intUserID"), Long), Session("LoginType").ToString, 1, CType(Session("IsCreatedByCustomer"), Boolean))
                    objQRB.QueryID = CLng(drGraphs("QueryID"))
                    objQRB.UseSQL = m_blnUseSQL

                    ' build query with filter for current function
                    strGraphSQL = objQRB.BuildQuery()

                    'addition by harshada d on 14 feb 2006 for helpdesk enhancements
                    '  strGraphSQL = Replace(strGraphSQL, " WHERE 1=1 ", " WHERE 1=1 AND  FunctionID = " & m_lngDepartmentID)
                    strGraphSQL = Replace(strGraphSQL, " WHERE 1=1 ", strSQLAccessibleRequests.ToString)
                    'end of addition by harshada d on 14 feb 2006 for helpdesk enhancements

                    'If Not IsDBNull(drGraphs("NoOfGraphElements")) Then
                    '    intNoOfGraphElements = CType(drGraphs("NoOfGraphElements"), Integer)
                    'Else
                    '    intNoOfGraphElements = 5
                    'End If

                    'strGraphSQL = "SELECT TOP " & intNoOfGraphElements & "  " & Right(Trim(strGraphSQL & ""), Len(Trim(strGraphSQL & "")) - 6)

                    blnShowDrillDowns = CBool(drGraphs.Item("ShowDrillDowns"))
                    If blnShowDrillDowns Then
                        strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Master  " & CType(drGraphs.Item("ItemID"), Long)
                        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                        If dr.Read Then
                            blnShowDrillDowns = True
                        Else
                            blnShowDrillDowns = False
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                    End If
                    ' in case there is an error in the graph item dont add it
                    Try
                        ' adding the chart here by calling the function
                        cell.Controls.Add(CreateGraph(CType(drGraphs.Item("ItemID"), Long), strGraphSQL, 0, 0, blnShowDrillDowns, strConnectionString))
                    Catch exc As Exception
                        cell.Attributes.Add("class", "clsTDOdd")
                        cell.Attributes.Add("border", "1")
                        cell.Attributes.Add("bordercolor", "black")
                        cell.InnerHtml = "Graph not generated"
                    End Try
                    row.Cells.Add(cell)
                    If intRowCount > 1 Then
                        intRowCount = 0
                    End If
                End With

            End If
        Loop
        'tblGraphs.Attributes.Add("Style", "")

        'Dim SB As New System.Text.StringBuilder
        'Dim SW As New System.IO.StringWriter(SB)
        'Dim htmlTW As New HtmlTextWriter(SW)
        'divGraphs.RenderControl(htmlTW)
        'Dim HTML As String = SB.ToString()
        'Response.Write(HTML)
        CommonFunctions.Data.DisposeDataReader(drGraphs)
    End Sub
    Private Sub GeneratePageCaption()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Helpdesk Counter Graphs", , , True))
    End Sub
    Private Function CreateGraph(ByVal ItemID As Long, ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ShowDrillDowns As Boolean, ByVal ConnectionString As String, Optional ByRef ImagePath As String = "") As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph()
        ' Purpose               : To create the graph control
        ' Description           : Same as above
        ' Parameters Passed     : Graph Type ID
        ' Returns               : Graph Control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Noveber 07,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objGraph As Graph.Graph
        Dim strChartType As String
        Dim strSQL As String
        Dim strBorderStyle As String = ""
        Dim strBorderColor As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim intUCL As Integer = 0
        Dim intLCL As Integer = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim intGraphID As Integer
        Dim blnEnable3D As Boolean = False
        Dim lngEntityID As Long = 0
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""
        Dim strPalleteStyle As String


        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0

        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        Dim blnShowHover As Boolean = True
        'check the application settings for hover on graphs
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("EnableHoverForCDBMain")
        If Not objFrameworkSetting Is Nothing Then
            If UCase(Trim(objFrameworkSetting.Status & "")) = "Y" Then
                blnShowHover = True
            Else
                blnShowHover = False
            End If
        End If
        objFrameworkSetting = Nothing



        ' set the DB settings
        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_DashboardDetails 153", m_blnUseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("PalleteStyle")) Then
                strPalleteStyle = dr("PalleteStyle").ToString
            Else
                strPalleteStyle = "EARTHTONES"
            End If
            'If Not IsDBNull(dr("GraphHeight")) Then
            '    Height = CType(dr("GraphHeight"), Integer)
            'Else
            '    Height = 260
            'End If
            'If Not IsDBNull(dr("GraphWidth")) Then
            '    Width = CType(dr("GraphWidth"), Integer)
            'Else
            '    Width = 492
            'End If
            Height = 375
            Width = 450
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        ' get the item details
        strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem  153," & ItemID & ",null,null,1"

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strItemName = dr("ItemName").ToString
            'strBorderStyle = dr("BorderStyle").ToString
            'strBorderColor = dr("BorderColor").ToString
            strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString : strCaptionColor = dr("CaptionColor").ToString
            strTitleColor = dr("TitleColor").ToString
            If Not IsDBNull(dr("UCL")) Then
                intUCL = CType(dr("UCL"), Integer)
            End If
            strUCLColor = dr("UCLColor").ToString
            If Not IsDBNull(dr("LCL")) Then
                intLCL = CType(dr("LCL"), Integer)
            End If
            strLCLColor = dr("LCLColor").ToString
            If Not IsDBNull(dr("ShowLegends")) Then
                blnShowLegends = CType(dr("ShowLegends"), Boolean)
            End If
            If Not IsDBNull(dr("ShowExplodedPie")) Then
                blnShowExplodedPie = CType(dr("ShowExplodedPie"), Boolean)
            End If
            intGraphID = CType(dr("GraphTypeID"), Integer)

            If Not IsDBNull(dr("Enable3D")) Then
                blnEnable3D = CType(dr("Enable3D"), Boolean)
            End If
            lngEntityID = CType(dr("EntityID"), Long)
            strNomenclature = dr("Nomenclature").ToString
            strPieLabelStyle = dr("PieLabelStyle").ToString

            If Not IsDBNull(dr("XAxisMin")) Then
                intXAxisMin = CType(dr("XAxisMin"), Long)
            End If
            If Not IsDBNull(dr("XAxisMax")) Then
                intXAxisMax = CType(dr("XAxisMax"), Long)
            End If
            If Not IsDBNull(dr("XAxisInterval")) Then
                intXAxisInterval = CType(dr("XAxisInterval"), Long)
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        ' create the grpah for the item values
        objGraph = New Graph.Graph
        objGraph.ConnectionString = ConnectionString
        objGraph.VirtualImagePath = "../../Images/" : objGraph.Enable3D = blnEnable3D
        objGraph.ChartType = GetChartType(ItemID, SQL, intGraphID, m_blnUseSQL)
        objGraph.BorderStyle = strBorderStyle
        objGraph.GraphTitle = strItemName : objGraph.TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
        objGraph.GraphTitleColor = strTitleColor
        objGraph.SQL = SQL : objGraph.Width = Width : objGraph.Height = Height
        objGraph.ShowExplodedPie = blnShowExplodedPie : objGraph.ChartBackColor = strChartBackColor
        objGraph.ChartAreaColor = strChartAreaColor : objGraph.PalleteStyle = strPalleteStyle
        If Not (intGraphID = 2 Or intGraphID = 7) Then
            objGraph.LegendColor = getColor(ItemID)
        End If
        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)

        objGraph.LegendCaptionColor = strCaptionColor : objGraph.LegendBorderColor = strCaptionColor
        objGraph.BorderColor = strBorderColor : objGraph.ShowLegends = blnShowLegends
        objGraph.BorderGradientColor = "WHITE"
        objGraph.BorderGradientStyle = "TOPBOTTOM"
        objGraph.ChartBackGradientColor = "WHITE"
        objGraph.ChartBackGradientStyle = "TOPBOTTOM"
        objGraph.ChartAreaGradientColor = "WHITE"
        If objGraph.ChartType(0) = "PIE" Or objGraph.ChartType(0) = "DOUGHNUT" Then
            objGraph.ChartAreaGradientStyle = "CENTER"
        Else
            objGraph.ChartAreaGradientStyle = "TOPBOTTOM"
        End If
        objGraph.PieChartLabelStyle = strPieLabelStyle


        ' if drill downs are present?
        If ShowDrillDowns Then
            If blnShowHover Then
                objGraph.DrillDownHoverPage = "CRM_DrillDown_Hover.aspx?DashboardID=153&FromWhere=&ItemID=" + ItemID.ToString + "&"
            End If
            objGraph.DrillDownClientSideFunctionName = "DrillDown_OnClick(" + ItemID.ToString + ","
        End If
        objGraph.EntityID = lngEntityID : objGraph.Nomenclature = strNomenclature
        'If intGraphID <> 5 Then
        '    objGraph.LCL = intLCL : objGraph.LCLColor = strLCLColor
        '    objGraph.UCL = intUCL : objGraph.UCLColor = strUCLColor
        'End If

        If ShowDrillDowns Then
            objGraph.MapAreaHREF = "javascript:callDetail(" & ItemID & ",1,0)"
        Else
            objGraph.MapAreaHREF = "javascript:callDetail(" & ItemID & ",0,0)"
        End If


        objGraph.YAxisMin = intXAxisMin
        If intXAxisMax <> 0 Then
            objGraph.YAxisMax = intXAxisMax
        End If
        If intXAxisInterval <> 0 Then
            objGraph.YAxisInterval = intXAxisInterval
        End If
        objGraph.XAxisInterval = 1
        objGraph.ChartAreaWidth = 95
        ' return the graph control
        Return objGraph.GenerateChartControl()

    End Function

    Private Function GetChartType(ByVal ItemID As Long, ByVal strSQL As String, ByVal intGraphID As Integer, ByVal UseSQL As Boolean) As String()
        '=====================================================================
        ' Procedure Name        : GetChartType
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim ds As DataSet
        Dim intUBound As Integer
        Dim intX As Integer

        Dim dr As IDataReader
        Dim arr() As String = {}
        Dim intCount As Integer = 1
        Dim arrGraph() As String = {}

        ds = CommonFunctions.Data.GetDataSet(strSQL, "default", , , UseSQL)
        intUBound = ds.Tables(0).Columns.Count()
        ds.Dispose() : ds = Nothing


        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + ItemID.ToString

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arrGraph(intCount)
            arrGraph(intCount) = dr("GraphID").ToString
            intCount += 1
        Loop
        CommonFunction.Data.DisposeDataReader(dr)

        Select Case intGraphID
            Case 2 'pie
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "PIE"
                Next
                Return arr
            Case 3 ' column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                                arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                            Else
                                arr(intX) = "COLUMN"
                            End If
                        Else
                            arr(intX) = "COLUMN"
                        End If
                    Else
                        arr(intX) = "COLUMN"
                    End If
                Next
                Return arr
            Case 4 ' line
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "LINE"
                        End If
                    Else
                        arr(intX) = "LINE"
                    End If
                Next
                Return arr
            Case 5 ' bar
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "BAR"
                Next
                Return arr
            Case 6 ' step
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "STEPLINE"
                        End If
                    Else
                        arr(intX) = "STEPLINE"
                    End If
                Next
                Return arr
            Case 7 ' doughnut
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "DOUGHNUT"
                Next
                Return arr

            Case 8 ' CandleStick
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If arrGraph(intX) <> "" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "CANDLESTICK"
                        End If
                    Else
                        arr(intX) = "CANDLESTICK"
                    End If
                Next
                Return arr

            Case 9 ' Spline
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "COLUMN" Or GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINE"
                        End If
                    Else
                        arr(intX) = "SPLINE"
                    End If
                Next
                Return arr
            Case 10 ' Splin area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "SPLINEAREA"
                        End If
                    Else
                        arr(intX) = "SPLINEAREA"
                    End If
                Next
                Return arr

            Case 11 ' Area
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    If intX <= UBound(arrGraph) Then
                        If GetChartName(CType(arrGraph(intX), Integer)) = "LINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "SPLINE" Or GetChartName(CType(arrGraph(intX), Integer)) = "STEPLINE" Then
                            arr(intX) = GetChartName(CType(arrGraph(intX), Integer))
                        Else
                            arr(intX) = "AREA"
                        End If
                    Else
                        arr(intX) = "AREA"
                    End If
                Next
                Return arr
            Case 12 ' stacked column
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "RADAR"
                Next
                Return arr
            Case Else
                ReDim arr(intUBound)
                For intX = 0 To intUBound
                    arr(intX) = "COLUMN"
                Next
                Return arr
        End Select
    End Function

    Private Function getColor(ByVal ItemID As Long) As String()
        '=====================================================================
        ' Procedure Name        : GetColor
        ' Purpose               : To get the colors the sql
        ' Description           : 
        ' Parameters Passed     : item id
        ' Returns               : arr of string for color
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Dec 16,2003
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim intCount As Integer = 1
        Dim arr() As String = {}

        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + ItemID.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arr(intCount)
            arr(intCount) = dr("ColorName").ToString
            intCount += 1
        Loop
        CommonFunction.Data.DisposeDataReader(dr)

        Return arr
    End Function

    Private Function GetChartName(ByVal intGraphID As Integer) As String
        '=====================================================================
        ' Procedure Name        : GetChartName
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : SQL , graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================

        Select Case intGraphID
            Case 2 : Return "PIE"
            Case 3 : Return "COLUMN"
            Case 4 : Return "LINE"
            Case 5 : Return "BAR"
            Case 6 : Return "STEPLINE"
            Case 7 : Return "DOUGHNUT"
            Case 8 : Return "CANDLESTICK"
            Case 9 : Return "SPLINE"
            Case 10 : Return "SPLINEAREA"
            Case 11 : Return "AREA"
            Case 12 : Return "STACKEDCOLUMN"
            Case Else : Return "COLUMN"
        End Select
    End Function
    Private Function formatfiltertext(ByVal strFilterText As String) As String
        strFilterText = strFilterText.ToUpper.Replace("ASSIGNTO", "USERNAME")
        strFilterText = strFilterText.ToUpper.Replace("LOGINTYPE", "LEFT(LOGINTYPE,1)")
        formatfiltertext = strFilterText
    End Function
    Private Function WriteMenu() As String
        Dim arrMenu() As String = {"Close"}
        Dim arrMenuToolTip() As String = {"Close"}
        Dim arrCSFunction() As String = {"Close_OnClick()"}
        Dim objMenu As New WebPage.Templates.StaticMenu
        WriteMenu = objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, True)
    End Function

End Class
