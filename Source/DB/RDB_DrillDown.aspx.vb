Public Class RDB_DrillDown
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents tblGraph As System.Web.UI.HtmlControls.HtmlTable
    Protected m_strType As String = ""  ' | BR - Business Radar, PR - Project Radar
    Protected m_intRefreshParent As Integer
    Protected m_lngDepartmentID As Long = 0
    Protected m_lngLocationID As Long = 0
    Protected m_lngParameterID As Long = 0
    Protected m_lngProjectID As Long = 0
    Protected m_intGraphHeight As Integer = 0
    Protected m_intGraphWidth As Integer = 0
    Protected m_strCurrWHERE As String = ""
    Protected m_strPrevAttribute As String
    Protected m_strPrevAttributeValue As String

    Protected m_intCurrDrillDown As Integer
    Private m_intPrevDrillDown As Integer
    Private m_intLastDrillDown As Integer

    Private m_lngEmployeeID As Long = 0
    Private m_strUserName As String = ""
    Private m_strLoginType As String = ""
    Private m_blnUseSQL As Boolean
    Private m_blnDrillDownExists As Boolean = False
    Private m_strSQL As String = ""

    Private Const DD_QTRLY As Byte = 1
    Private Const DD_MTHTLY As Byte = 2
    Private Const DD_DAILY As Byte = 3
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu
    Protected arrIgnoreHTMLEncode() As String = {"0"}

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        Call Initialize()
        Call CreateDrillDownGraph()
    End Sub

    Public Sub New()
        'MyBase.ApplySecurity(False, 2)
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True, 2)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the variables for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 28,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String = ""

        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngEmployeeID = CType(Session("intUserID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("type")) <> "" Then
            m_strType = Request.QueryString("type").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ParameterID")) <> "" Then
            m_lngParameterID = CType(Request.QueryString("ParameterID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("LocationID")) <> "" Then
            m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DepartmentID")) <> "" Then
            m_lngDepartmentID = CType(Request.QueryString("DepartmentID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
            m_lngProjectID = CType(Request.QueryString("ProjectID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("height")) <> "" Then
            m_intGraphHeight = CType(Request.QueryString("height"), Integer)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("width")) <> "" Then
            m_intGraphWidth = CType(Request.QueryString("width"), Integer)
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("CURR")) <> "" Then
            m_intCurrDrillDown = CType(Request.QueryString("CURR"), Integer)
        Else
            m_intCurrDrillDown = -1
        End If

        strSQL = "usp_sel_tbl_RDB_DrillDown_UserSettings " & m_lngParameterID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            If m_blnDrillDownExists = False Then
                If m_intCurrDrillDown <> -1 Then
                    ' THe prev. drill down was on this
                    If CInt(dr("DrillDownOrder")) = m_intCurrDrillDown Then
                        m_intPrevDrillDown = CType(dr("DrillDownOrder"), Integer)
                    End If
                    ' NExt level
                    If CInt(dr("DrillDownOrder")) > m_intCurrDrillDown Then
                        m_blnDrillDownExists = True
                        m_intCurrDrillDown = CType(dr("DrillDownOrder"), Integer)
                    End If
                Else
                    ' FIrst level
                    m_blnDrillDownExists = True
                    m_intCurrDrillDown = CType(dr("DrillDownOrder"), Integer)
                End If
            End If
            ' THe last drill down will be this
            m_intLastDrillDown = CType(dr("DrillDownOrder"), Integer)
        Loop
        Call DisposeDataDeader(dr)

        If m_intCurrDrillDown = m_intLastDrillDown Then m_blnDrillDownExists = False

        m_strPrevAttributeValue = Server.UrlDecode(Replace(Replace(Request.QueryString("colvalue"), "38", "&"), "43", "+"))

        Call BuildQueryForDrillDown()

    End Sub

    Protected Sub WriteMenu(ByVal ShowPageCaption As Boolean)
        '=====================================================================
        ' Procedure Name        : WriteMenu
        ' Purpose               : To write the menu for page
        ' Description           : To write the menu for page
        ' Parameters Passed     : ShowPageCaption as boolean
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : WebPage.Templates namespace
        ' Author                : Rajanikant
        ' Created               : Apr 29,2004
        ' Revisions             :
        '=====================================================================
        Dim strPeriod As String = ""
        Dim strZoom As String = ""

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'MENU_PROJECT_RADAR
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_PROJECT_RADAR"), MyBase.GetResourceString("MENU_NEXTLEVEL"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_PROJECT_RADAR_TOOLTIP"), MyBase.GetResourceString("MENU_NEXTLEVEL_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
        Dim arrCSFunction() As String = {"ProjectRadar_OnClick()", "NextLevel_OnClick()", "Close_OnClick()"}

        m_objMenu = New WebPages.Template.StaticMenu
        ' draw the menu with events
        Call m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)

        MyBase.InitializeResources("AppResources.RDB_DrillDown", "AppResources")

        Select Case m_intCurrDrillDown
            Case DD_QTRLY : strPeriod = MyBase.GetResourceString("LBL_QTRLY_TREND")
            Case DD_MTHTLY : strPeriod = MyBase.GetResourceString("LBL_MTHLY_TREND")
            Case DD_DAILY : strPeriod = MyBase.GetResourceString("LBL_DAILY_TREND")
        End Select
        strZoom = "<a href='javascript:ZoomOut_OnClick(" & m_intGraphHeight & "," & m_intGraphWidth & ")'><img id='zoomin' src='../../Images/zoomin.gif' border='0' title='" & MyBase.GetResourceString("TOOLTIP_ZOOMIN") & "'></a> "
        strZoom += "<a href='javascript:ZoomIn_OnClick(" & m_intGraphHeight & "," & m_intGraphWidth & ")' title='" & MyBase.GetResourceString("TOOLTIP_ZOOMOUT") & "'><img id='zoomout' src='../../Images/zoomout.gif' border='0'></a>"

        If ShowPageCaption Then
            Response.Write("<BR>" + vbCrLf)
            ' page caption
            WebPage.Templates.PageCaption.GetPageCaptions(, Replace(MyBase.GetResourceString("CAP_DRILLDOWNS"), "<PARAM_NAME>", Server.HtmlEncode(GetParameterName(m_lngParameterID))) & strPeriod, strZoom)
            Response.Write("<BR>" + vbCrLf)
        End If
    End Sub

    Protected Sub WriteInformation()
        '=====================================================================
        ' Procedure Name        : WriteInformation()	
        ' Purpose               : To write the information of curr. drill down
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 07,2004
        ' Revisions             :
        '=====================================================================
        With Response
            .Write("<Table class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")
            .Write(DrawLine("black", 2))
            If m_lngProjectID <> 0 Then
                .Write("<TR class=clsTREven><TD width=20% align=right>" & MyBase.GetResourceString("LBL_PROJECT") & "</TD><TD><B>" & Server.HtmlEncode(GetProjectName(m_lngProjectID)) & "</B></TD></TR>")
            End If
            .Write("<TR class=clsTRRadarCurrent><TD  width=20% align=right>" & MyBase.GetResourceString("LBL_CURRENT_VALUE") & "</TD><TD><B>" & Server.HtmlEncode(GetCurrentValue()) & "</B></TD></TR>")
            .Write(DrawLine("black", 2))
            .Write("</table>")

        End With
    End Sub


    Protected Sub BuildGrid()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for the Radar DB
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 28,2004
        ' Revisions             :
        '=====================================================================

        Select Case m_intCurrDrillDown
            Case DD_QTRLY
                ' grid related variables
                Dim arrColumn() As String = {"QuarterName", "ParamValue"}
                Dim arrUFColumn() As String = {MyBase.GetResourceString("LBL_QUARTER"), GetParameterName(m_lngParameterID)}
                Dim arrLink() As String = {"DrillDownGrid_OnClick({}" & m_lngParameterID & ",'QuarterName')"}
                Dim arrTDStyle() As String = {"{}title='" & MyBase.GetResourceString("TOOLTIP_DRILLDOWN_QTR") & " [QuarterName]'"}

                With Response
                    ' grid 
                    m_objGrid = New WebPages.Template.GenericGrid
                    With m_objGrid
                        .ActualColumnArray = arrColumn : .UserFriendlyColumnArray = arrUFColumn
                        .RowLinkArray = arrLink : .TDStyleArray = arrTDStyle : .NoOfDataColumns = 2
                        If m_blnDrillDownExists Then .RowLinkArray = arrLink
                        .DIVID = "divGrid" : .DIVStyle = "overflow:scroll" : .DIVHeight = m_intGraphHeight
                        .SQL = m_strSQL : .UseSQL = m_blnUseSQL
                        .returnHTML = False
                        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing
                End With

            Case DD_MTHTLY
                ' grid related variables
                Dim arrColumn() As String = {"MonthName", "ParamValue"}
                Dim arrUFColumn() As String = {MyBase.GetResourceString("LBL_MONTH"), GetParameterName(m_lngParameterID)}
                ' Modified By NitinVS on 2 Sep 2005 for WhizibleSEM SP4 IssueID 130 
                ' No Other drill Than Monthly Is to Be shown.
                'Dim arrLink() As String = {"DrillDownGrid_OnClick({}" & m_lngParameterID & ",'MonthName')"}
                Dim arrLink() As String = {"", ""}
                ' End Modification By NitinVS on 2 Sep 2005 for WhizibleSEM SP4 IssueID 130  

                Dim arrTDStyle() As String = {"{}title='" & MyBase.GetResourceString("TOOLTIP_DRILLDOWN_MTH") & ": [MonthName]'"}
                With Response
                    ' grid 
                    m_objGrid = New WebPages.Template.GenericGrid
                    With m_objGrid
                        .ActualColumnArray = arrColumn : .UserFriendlyColumnArray = arrUFColumn
                        .NoOfDataColumns = 2
                        If m_blnDrillDownExists Then
                            .RowLinkArray = arrLink : .TDStyleArray = arrTDStyle
                        End If
                        .DIVID = "divGrid" : .DIVStyle = "overflow:scroll" : .DIVHeight = m_intGraphHeight
                        .SQL = m_strSQL : .UseSQL = m_blnUseSQL
                        .returnHTML = False
                        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing
                End With

            Case DD_DAILY
                ' grid related variables
                Dim arrColumn() As String = {"EntryDate", "ParamValue"}
                Dim arrUFColumn() As String = {MyBase.GetResourceString("LBL_DATE"), GetParameterName(m_lngParameterID)}
                With Response
                    ' grid 
                    m_objGrid = New WebPages.Template.GenericGrid
                    With m_objGrid
                        .ActualColumnArray = arrColumn : .UserFriendlyColumnArray = arrUFColumn
                        .NoOfDataColumns = 2
                        .DIVID = "divGrid" : .DIVStyle = "overflow:scroll" : .DIVHeight = m_intGraphHeight
                        .SQL = m_strSQL : .UseSQL = m_blnUseSQL
                        .returnHTML = False
                        'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing
                End With
        End Select


    End Sub

#Region "Other Procedures"

    Private Sub BuildQueryForDrillDown()
        '=====================================================================
        ' Procedure Name        : BuildQueryForDrillDown
        ' Purpose               : To build the
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Apr 30,2004
        ' Revisions             :
        '=====================================================================
        Dim strAccess As String = ""
        If UCase(Trim(m_strType & "")) = "BR" Then
            ' Business Radar 
            Select Case m_intCurrDrillDown
                Case DD_QTRLY

                    m_strSQL = "usp_RDB_Get_BusinessRadar_Data_Quarterly " & m_lngParameterID
                    If m_lngLocationID <> 0 Then : m_strSQL += "," & m_lngLocationID : Else : m_strSQL += ",null" : End If
                    If m_lngDepartmentID <> 0 Then : m_strSQL += "," & m_lngDepartmentID : Else : m_strSQL += ",null" : End If
                    If m_lngLocationID <> 0 Or m_lngDepartmentID <> 0 Then : m_strSQL += ",0" : Else : m_strSQL += ",1" : End If

                Case DD_MTHTLY

                    m_strSQL = "usp_RDB_Get_BusinessRadar_Data_Monthly " & m_lngParameterID
                    If m_lngLocationID <> 0 Then : m_strSQL += "," & m_lngLocationID : Else : m_strSQL += ",null" : End If
                    If m_lngDepartmentID <> 0 Then : m_strSQL += "," & m_lngDepartmentID : Else : m_strSQL += ",null" : End If
                    If m_lngLocationID <> 0 Or m_lngDepartmentID <> 0 Then : m_strSQL += ",0" : Else : m_strSQL += ",1" : End If

                    If Trim(m_strPrevAttributeValue & "") <> "" Then
                        m_strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                    End If

                Case DD_DAILY

                    m_strSQL = "usp_RDB_Get_BusinessRadar_Data_Daily " & m_lngParameterID
                    If m_lngLocationID <> 0 Then : m_strSQL += "," & m_lngLocationID : Else : m_strSQL += ",null" : End If
                    If m_lngDepartmentID <> 0 Then : m_strSQL += "," & m_lngDepartmentID : Else : m_strSQL += ",null" : End If
                    If m_lngLocationID <> 0 Or m_lngDepartmentID <> 0 Then : m_strSQL += ",0" : Else : m_strSQL += ",1" : End If

                    If Trim(m_strPrevAttributeValue & "") <> "" Then
                        m_strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                    End If

                Case Else
                    ' no such case.. ignore!
            End Select
        Else
            strAccess = GetProjectAccessFilter()

            ' Project Radar 
            Select Case m_intCurrDrillDown
                Case DD_QTRLY

                    m_strSQL = "usp_RDB_Get_ProjectRadar_Data_Quarterly " & m_lngParameterID
                    If m_lngLocationID <> 0 Then : m_strSQL += "," & m_lngLocationID : Else : m_strSQL += ",null" : End If
                    If m_lngDepartmentID <> 0 Then : m_strSQL += "," & m_lngDepartmentID : Else : m_strSQL += ",null" : End If
                    If m_lngProjectID <> 0 Then : m_strSQL += "," & m_lngProjectID : Else : m_strSQL += ",null" : End If
                    If Trim(strAccess & "") <> "" Then
                        'Modified by PrajaktaR on 2 June 2005 for IssueID 19217 of Nucleus
                        'm_strSQL += ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(strAccess)) + "'"
                        m_strSQL += ",'" + CommonFunctions.General.BuildQueryString(strAccess) + "'"
                        'End of Modification by PrajaktaR on 2 June 2005 for IssueID 19037 of Nucleus
                    Else
                        m_strSQL += ",null"
                    End If
                Case DD_MTHTLY

                    m_strSQL = "usp_RDB_Get_ProjectRadar_Data_Monthly " & m_lngParameterID
                    If m_lngLocationID <> 0 Then : m_strSQL += "," & m_lngLocationID : Else : m_strSQL += ",null" : End If
                    If m_lngDepartmentID <> 0 Then : m_strSQL += "," & m_lngDepartmentID : Else : m_strSQL += ",null" : End If
                    If m_lngProjectID <> 0 Then : m_strSQL += "," & m_lngProjectID : Else : m_strSQL += ",null" : End If

                    If Trim(m_strPrevAttributeValue & "") <> "" Then
                        m_strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                    Else
                        m_strSQL += ",null"
                    End If
                    If Trim(strAccess & "") <> "" Then
                        'Modified by PrajaktaR on 2 June 2005 for IssueID 19217 of Nucleus
                        'm_strSQL += ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(strAccess)) + "'"
                        m_strSQL += ",'" + CommonFunctions.General.BuildQueryString(strAccess) + "'"
                        'End of Modification by PrajaktaR on 2 June 2005 for IssueID 19037 of Nucleus
                    Else
                        m_strSQL += ",null"
                    End If
                Case DD_DAILY

                    m_strSQL = "usp_RDB_Get_ProjectRadar_Data_Daily " & m_lngParameterID
                    If m_lngLocationID <> 0 Then : m_strSQL += "," & m_lngLocationID : Else : m_strSQL += ",null" : End If
                    If m_lngDepartmentID <> 0 Then : m_strSQL += "," & m_lngDepartmentID : Else : m_strSQL += ",null" : End If
                    If m_lngProjectID <> 0 Then : m_strSQL += "," & m_lngProjectID : Else : m_strSQL += ",null" : End If

                    If Trim(m_strPrevAttributeValue & "") <> "" Then
                        m_strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                    Else
                        m_strSQL += ",null"
                    End If
                    If Trim(strAccess & "") <> "" Then
                        'Modified by PrajaktaR on 2 June 2005 for IssueID 19217 of Nucleus
                        'm_strSQL += ",'" + CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(strAccess)) + "'"
                        m_strSQL += ",'" + CommonFunctions.General.BuildQueryString(strAccess) + "'"
                        'End of Modification by PrajaktaR on 2 June 2005 for IssueID 19037 of Nucleus
                    Else
                        m_strSQL += ",null"
                    End If
                Case Else
                    ' no such case.. ignore!
            End Select
        End If

    End Sub

    Private Function GetProjectAccessFilter() As String
        '=====================================================================
        ' Procedure Name        : GetProjectAccessFilter()	
        ' Purpose               : To get the project access
        ' Description           : same as above
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Session Variables are set
        ' Dependencies          : WebPages.Filters.cRoleLevelAccessFilter
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 09,2004
        ' Revisions             :
        '=====================================================================
        Dim strAccess As String
        Dim objAccess As New WebPages.Filters.cRoleLevelAccessFilter(Session("strUserName").ToString, CType(Session("intPostID"), Long), CType(Session("intUserID"), Long), Session("LoginType").ToString, CType(Session("intLoginID"), Integer), CType(Session("intRoleLevel"), Integer), CType(Session("IsCreatedByCustomer"), Boolean))
        'Dim objAccess As New WebPages.Filters.cRoleLevelAccessFilter("VilasJ", 21, 64, "E", 64, 1, False)
        With objAccess
            .UseSQL = m_blnUseSQL
            .AccessParameter = "ProjectID"
            .ShowReleasedProjects = False
            strAccess = .GetRoleLevelAccessFilter()
        End With
        objAccess = Nothing
        ' just in case! if string is greater than 7900 chars truncate it
        If Len(strAccess & "") > 7900 Then
            strAccess = Left(strAccess, 7900)
            If Right(Trim(strAccess & ""), 1) = "," Then
                strAccess = Left(strAccess, 7899) + ")"
            End If
            If Right(Trim(strAccess & ""), 1) = "'" Then
                strAccess = Left(strAccess, 7899) + "')"
            End If
            If Right(Trim(strAccess & ""), 1) <> ")" Then
                strAccess = Left(strAccess, 7899) + "')"
            End If
        End If
        GetProjectAccessFilter = strAccess
    End Function

    Private Sub CreateDrillDownGraph()
        '=====================================================================
        ' Procedure Name        : CreateDrillDownGraph
        ' Purpose               : To create the drill down graph
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Apr 29,2004
        ' Revisions             :
        '=====================================================================
        Dim cell As New HtmlTableCell
        Dim row As New HtmlTableRow

        tblGraph.Rows.Add(row)
        ' add row cells
        cell = New HtmlTableCell
        cell.Attributes.Add("width", "100%")
        cell.Attributes.Add("align", "center")
        Try
            ' adding the chart control here by calling the function
            cell.Controls.Add(CreateGraph(m_lngParameterID, m_strSQL, True))
        Catch exc As Exception
            cell.Attributes.Add("class", "clsTDOdd")
            cell.Attributes.Add("border", "1")
            cell.Attributes.Add("bordercolor", "black")
            cell.Attributes.Add("align", "center")
            cell.InnerHtml = MyBase.GetResourceString("LBL_GRAPHNOTGENERATED")
        End Try
        row.Cells.Add(cell)
    End Sub

    Private Sub DisposeDataDeader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : DisposeDataDeader()	
        ' Purpose               : To dispose the data reader object
        ' Description           : same as above
        ' Parameters Passed     : by ref data-reader object
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : None
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 28,2004
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

    Private Function CreateGraph(ByVal ParameterID As Long, ByVal SQL As String, ByVal ShowDrillDowns As Boolean) As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph
        ' Purpose               : To create the graph for the dashboard item
        ' Description           : 
        ' Parameters Passed     : parameterid, sql, height,width,showdrilldowns(true/false)
        ' Returns               : graph control as web control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Apr 29,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim objGraph As Graph.Graph
        Dim strSQL As String
        Dim strBorderStyle As String = ""
        Dim strBorderColor As String = ""
        Dim strChartBackColor As String = ""
        Dim strChartAreaColor As String = ""
        Dim strCaptionColor As String = ""
        Dim blnShowLegends As Boolean = False
        Dim strItemName As String = ""
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""
        Dim blnEnable3D As Boolean = False
        Dim blnShowLabels As Boolean = False
        Dim strPalleteStyle As String = ""
        Dim intGraphTypeID As Integer
        ' get the item details
        strSQL = "usp_sel_tbl_RDB_DrillDown_UserSettings " & m_lngParameterID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'," & m_intCurrDrillDown
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            strItemName = dr("ParameterName").ToString
            strBorderStyle = dr("BorderStyle").ToString
            strCaptionColor = dr("CaptionColor").ToString
            strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString
            strNomenclature = dr("ParameterName").ToString
            strPalleteStyle = dr("PalleteStyle").ToString
            strBorderColor = MyBase.GetFormValue("cboBorderColor")
            strTitleColor = MyBase.GetFormValue("cboTitleColor")
            If m_intGraphHeight = 0 Then
                m_intGraphHeight = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphHeight"), "300"), Integer)
            End If
            If m_intGraphWidth = 0 Then
                m_intGraphWidth = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphWidth"), "300"), Integer)
            End If
            blnShowLegends = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowLegends"), "0"), Boolean)
            blnShowLabels = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowLabels"), "0"), Boolean)
            intGraphTypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr("GraphType"), "0"), Integer)
            blnEnable3D = CType(CommonFunctions.Data.CheckIsDBNull(dr("Enable3D"), "0"), Boolean)
        End If
        DisposeDataDeader(dr)

        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        ' create the graph for the item
        objGraph = New Graph.Graph
        With objGraph
            .ConnectionString = CommonFunctions.Application.ConnectionString
            .VirtualImagePath = "../../Images/"
            .Enable3D = blnEnable3D
            .ChartType = GetChartType(intGraphTypeID)
            .BorderStyle = strBorderStyle
            .PalleteStyle = strPalleteStyle
            .GraphTitle = strItemName
            .GraphTitleColor = strTitleColor
            .TitleFont = New System.Drawing.Font("verdana", 10, System.Drawing.FontStyle.Bold)
            .SQL = SQL
            .Width = m_intGraphWidth
            .Height = m_intGraphHeight
            .ChartBackColor = strChartBackColor
            .ChartAreaColor = strChartAreaColor
            .BorderColor = strBorderColor
            .BorderGradientColor = "WHITE"
            .BorderGradientStyle = "TOPBOTTOM"
            .ChartBackGradientColor = "WHITE"
            .ChartBackGradientStyle = "TOPBOTTOM"
            .ChartAreaGradientColor = "WHITE"
            .ChartAreaGradientStyle = "TOPBOTTOM"
            .LegendCaptionColor = strCaptionColor
            .LegendBorderColor = strCaptionColor
            .LegendFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)
            If m_blnDrillDownExists Then
                .DrillDownClientSideFunctionName = "DrillDown_OnClick(" + ParameterID.ToString + ","
            End If
            .ShowLegends = blnShowLegends
            .Nomenclature = strNomenclature
            .ShowCaptions = blnShowLabels
            .ShowDataColumnNameAsXAxisTitle = False
            Select Case m_intCurrDrillDown
                Case DD_QTRLY : .XAxisTitle = "Quarter"
                Case DD_MTHTLY : .XAxisTitle = "Month"
                Case DD_DAILY : .XAxisTitle = "Date"
            End Select

            ' return the control
            Return .GenerateChartControl()
        End With
        objGraph = Nothing
    End Function

    Private Function GetProjectName(ByVal ProjectID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetProjectName()	
        ' Purpose               : To get the project name
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data, "usp_sel_tbl_PM_Project"
        ' Author                : Rajanikant Khethawatt
        ' Created               : May 07,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        GetProjectName = ""
        strSQL = "usp_sel_tbl_PM_Project " & ProjectID
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetProjectName = dr("ProjectName").ToString
        End If
        DisposeDataDeader(dr)
    End Function

    Private Function GetParameterName(ByVal ParameterID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetParameterName()	
        ' Purpose               : To get the parameter name
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        GetParameterName = ""
        strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'," & ParameterID & ",'" & CommonFunctions.General.BuildQueryString(m_strType) & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetParameterName = dr("ParameterName").ToString
        End If
        DisposeDataDeader(dr)
    End Function

    Private Function GetChartType(ByVal GraphTypeID As Long) As String()
        '=====================================================================
        ' Procedure Name        : GetChartType()
        ' Purpose               : get the chart type array
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : array of chart types
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Apr 30,2004
        ' Revisions             :
        '=====================================================================
        Dim ds As DataSet
        Dim intUBound As Integer
        Dim intX As Integer
        Dim strSQL As String
        Dim dr As IDataReader
        Dim arr() As String = {}
        Dim intCount As Integer = 1
        Dim arrGraph() As String = {}

        ds = CommonFunctions.Data.GetDataSet(m_strSQL, "default", , , m_blnUseSQL)
        intUBound = ds.Tables(0).Columns.Count()
        ds.Dispose() : ds = Nothing

        Select Case GraphTypeID
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

    Private Function GetChartName(ByVal intGraphID As Integer) As String
        '=====================================================================
        ' Procedure Name        : GetChartName
        ' Purpose               : To get the chart types for the sql
        ' Description           : 
        ' Parameters Passed     : Graph type id
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Apr 30,2004
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
            Case 12 : Return "RADAR"
            Case Else : Return "COLUMN"
        End Select
    End Function

    Private Function DrawLine(ByVal Color As String, ByVal ColSpan As Integer) As String
        '=====================================================================
        ' Procedure Name        : DrawLine()	
        ' Purpose               : To draw a line
        ' Description           : same as above
        ' Parameters Passed     : Color, Colspan
        ' Returns               : String
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 11,2003
        ' Revisions             :
        '=====================================================================
        Dim sb As New System.Text.StringBuilder("")
        sb.Append("<tr><td bgColor=" + Color + " width='100%' align='left' colspan='" + ColSpan.ToString + "'></td></tr>" + vbCrLf)
        DrawLine = sb.ToString
        sb = Nothing
    End Function


    Private Function GetCurrentValue() As String
        '=====================================================================
        ' Procedure Name        : GetCurrentValue
        ' Purpose               : To get the current value for current drill-down
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : current value
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Commonfunctions.Data
        ' Author                : Rajanikant
        ' Created               : May 07,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String = ""

        ' build the query
        If UCase(Trim(m_strType & "")) = "BR" Then
            ' Business Radar
            strSQL = "usp_sel_tbl_RDB_BusinessRadar_Data " & m_lngEmployeeID & ",'" & m_strLoginType & "'"

            ' location specific?
            If m_lngLocationID <> 0 Then
                strSQL += "," + m_lngLocationID.ToString
            Else
                strSQL += ",null"
            End If
            ' department specific?
            If m_lngDepartmentID <> 0 Then
                strSQL += "," + m_lngDepartmentID.ToString
            Else
                strSQL += ",null"
            End If
            If m_lngLocationID <> 0 Or m_lngDepartmentID <> 0 Then
                ' Not organisation level data
                strSQL += ",0"
            Else
                ' organisation level data
                strSQL += ",1"
            End If
            strSQL += "," & m_lngParameterID
        Else
            ' Project radar
            strSQL = "usp_sel_tbl_RDB_ProjectRadar_Data " & m_lngEmployeeID & ",'" & m_strLoginType & "'"

            ' location specific?
            If m_lngLocationID <> 0 Then
                strSQL += "," + m_lngLocationID.ToString
            Else
                strSQL += ",null"
            End If
            ' department specific?
            If m_lngDepartmentID <> 0 Then
                strSQL += "," + m_lngDepartmentID.ToString
            Else
                strSQL += ",null"
            End If
            ' parameter specific?
            strSQL += "," + m_lngParameterID.ToString

            ' project specific?
            If m_lngProjectID <> 0 Then
                strSQL += "," + m_lngProjectID.ToString
            Else
                strSQL += ",null"
            End If
        End If

        ' get the value
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetCurrentValue = FormatNumber(CommonFunctions.Data.CheckIsDBNull(dr("KeyValue"), "0"), 2)
        End If
        DisposeDataDeader(dr)

    End Function
#End Region

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

#Region "events"

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        If Args.DataReader(0).ToString.ToUpper.Trim = "CURRENT" Then
            Args.clsTR = "clsTRRadarCurrent"
        End If
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        Dim dr As IDataReader
        Dim strSQL As String

        If Args.MenuColIndex = 0 Then
            If UCase(Trim(m_strType & "")) = "BR" Then
                ' show project radar?
                strSQL = "usp_sel_tbl_RDB_Parameter_Master " & m_lngParameterID
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If dr.Read Then
                    If Not CType(CommonFunctions.Data.CheckIsDBNull(dr("IsProjectRelated"), "0"), Boolean) Then
                        Cancel = True
                    End If
                End If
                DisposeDataDeader(dr)
            Else
                Cancel = True
            End If
        ElseIf Args.MenuColIndex = 1 Then
            ' "Next Level" link
            If m_intCurrDrillDown = DD_MTHTLY Then
                Cancel = True
            ElseIf Not m_blnDrillDownExists Then
                Cancel = True
            End If
        End If
    End Sub
#End Region

    Protected Overrides Sub Finalize()
        m_objMenu = Nothing
        MyBase.Finalize()
    End Sub
End Class

