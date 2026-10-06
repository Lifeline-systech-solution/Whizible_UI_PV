Imports System.Data.SqlClient
Imports Dundas.Charting.WebControl
Public Class CRM_DrillDown_Hover
    Inherits WebPage.Templates.WhizTemplate

    Protected WithEvents Chart As Dundas.Charting.WebControl.Chart
    Protected m_lngItemId As Long
    Protected m_lngDashboardID As Long
    Protected m_strCurrWHERE As String
    Protected m_strPrevWHERE As String
    Protected m_strPrevAttribute As String
    Protected m_strPrevAttributeValue As String
    Protected m_intGraphHeight As Integer = 0
    Protected m_intGraphWidth As Integer = 0
    Private m_strSQL As String = ""
    Private m_strGraphSQL As String = ""
    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Private m_strFromWhere As String = ""
    Private m_lngEntityID As Long
    Private m_lngQueryID As Long
    Private m_intGraphID As Integer
    Private m_intNoOfGraphElements As Integer = 5
    Protected m_intCurrDrillDown As Integer
    Private m_intPrevDrillDown As Integer
    Private m_intLastDrillDown As Integer
    Private m_strDrillDown_FirstField As String
    Private m_blnIsOracleDB As Boolean = False
    Private m_blnDrillDownExists As Boolean = False
    Private m_strConnectionString As String = ""
    Private m_strPalleteStyle As String
    Private m_strAccess As String
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
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()
        Call CreateGraph(m_lngItemId, m_strGraphSQL, m_intGraphHeight, m_intGraphWidth, False)
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize
        ' Purpose               : To initialize the module variables
        ' Description           : To initialize the module variables
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : , CommonFucntions.dll
        '                         funApplyAccessFilter,funGetUserFriendlyAttributeName
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        Dim intGraphTypeID As Integer

        m_lngItemId = CType(Request.QueryString("ItemID"), Long)
        If Not Request.QueryString("DashboardID") Is Nothing Then
            m_lngDashboardID = CType(Request.QueryString("DashboardID"), Integer)
        End If
        If Not Request.QueryString("height") Is Nothing Then
            m_intGraphHeight = CType(Request.QueryString("height"), Integer)
        End If
        If Not Request.QueryString("width") Is Nothing Then
            m_intGraphWidth = CType(Request.QueryString("width"), Integer)
        End If

        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        End If

        m_strPrevWHERE = Request.QueryString("CURRWHERE")
        m_strPrevWHERE = Replace(m_strPrevWHERE, "|||", "'")


        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)


        ' get the graph id
        strSQL = "EXEC usp_Sel_tbl_CDB_Item_Master  NULL," & m_lngItemId

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            m_lngQueryID = CType(dr("QueryID"), Long)
            If IsDBNull(dr("DrillDownGraphTypeID")) Then
                m_intGraphID = CType(dr("GraphTypeID"), Integer)
            End If
            m_lngDashboardID = CType(dr("DashboardID"), Long)
            intGraphTypeID = CType(dr("GraphTypeID"), Integer)
            If Not IsDBNull(dr("NoOfGraphElements")) Then
                m_intNoOfGraphElements = CType(dr("NoOfGraphElements"), Integer)
            Else
                m_intNoOfGraphElements = 5
            End If
        End If
        CloseDataReader(dr)

        m_strPrevAttribute = Request.QueryString("colname")
        m_strPrevAttributeValue = Request.QueryString("colvalue")
        m_strPrevAttributeValue = Replace(m_strPrevAttributeValue, "|||", "'")

        If Trim(m_strPrevAttribute & "") <> "" And Trim(m_strPrevAttributeValue & "") = "" Then
            m_strPrevAttributeValue = "NOT SPECIFIED"
        End If
        m_strPrevAttributeValue = Replace(m_strPrevAttributeValue, "|||", "'")

        If Not Request.QueryString("CURR") Is Nothing Then
            m_intCurrDrillDown = CType(Request.QueryString("CURR"), Integer)
        Else
            m_intCurrDrillDown = -1
        End If

        m_blnDrillDownExists = False

        ' DRILL DOWN DETAILS
        strSQL = "EXEC usp_Sel_tbl_CDB_Item_DrillDown_Master  " & m_lngItemId


        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)

        Do While dr.Read
            If m_blnDrillDownExists = False Then
                If m_intCurrDrillDown <> -1 Then
                    ' THe prev. drill down was on this
                    If CInt(dr("DrillDownOrderNumber")) = m_intCurrDrillDown Then
                        m_intPrevDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
                        m_strPrevAttribute = dr("AttributeName").ToString
                    End If
                    ' NExt level
                    If CInt(dr("DrillDownOrderNumber")) > m_intCurrDrillDown Then
                        m_blnDrillDownExists = True
                        m_intCurrDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
                        m_strDrillDown_FirstField = dr("AttributeName").ToString
                    End If
                Else
                    ' FIrst level
                    m_blnDrillDownExists = True
                    m_intCurrDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
                    m_strDrillDown_FirstField = dr("AttributeName").ToString
                End If
            End If

            ' THe last drill down will be this
            m_intLastDrillDown = CType(dr("DrillDownOrderNumber"), Integer)
        Loop
        CloseDataReader(dr)

        If m_intCurrDrillDown = m_intLastDrillDown Then m_blnDrillDownExists = False

        m_strSQL = funBuildQueryForDrillDown(m_lngQueryID, intGraphTypeID, m_strDrillDown_FirstField)

        If m_blnIsOracleDB Then
            m_strGraphSQL = "SELECT " & Right(Trim(m_strSQL & ""), Len(Trim(m_strSQL & "")) - 6)
            m_strGraphSQL = "SELECT * From (" & m_strSQL & ") Where RowNum < " & (m_intNoOfGraphElements + 1)
        Else
            m_strGraphSQL = "SELECT TOP " & m_intNoOfGraphElements & "  " & Right(Trim(m_strSQL & ""), Len(Trim(m_strSQL & "")) - 6)
        End If


        ' set the DB settings
        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_DashboardDetails " + m_lngDashboardID.ToString, m_blnUseSQL)
        If dr.Read Then
            If Not IsDBNull(dr("DashboardType")) Then
                m_strAccess = dr("DashboardType").ToString
            Else
                m_strAccess = "FULL_ACCESS"
            End If
            If Not IsDBNull(dr("PalleteStyle")) Then
                m_strPalleteStyle = dr("PalleteStyle").ToString
            Else
                m_strPalleteStyle = "EARTHTONES"
            End If
            If m_intGraphHeight = 0 Then
                If Not IsDBNull(dr("GraphHeight")) Then
                    m_intGraphHeight = CType(dr("GraphHeight"), Integer)
                Else
                    m_intGraphHeight = 260
                End If
            End If

            If m_intGraphWidth = 0 Then
                If Not IsDBNull(dr("GraphWidth")) Then
                    m_intGraphWidth = CType(dr("GraphWidth"), Integer)
                Else
                    m_intGraphWidth = 492
                End If
            End If
        End If
        CloseDataReader(dr)

    End Sub


    Private Function funBuildQueryForDrillDown(ByVal intQueryID As Long, ByVal intGraphTypeID As Integer, ByVal strAttribute As String) As String
        '=====================================================================
        ' Procedure Name        : funBuildQueryForDrillDown
        ' Description           : Build the query for the ID Passed for the next level
        ' Purpose               : To build the query for the ID Passed 
        ' Parameters Passed     : Query ID, GraphTypeID, ByVal strAttribute
        ' Returns               : The SQL Query
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : usp_CDB_Get_QueryDetails, CommonFucntions.dll
        '                         funApplyAccessFilter,funGetUserFriendlyAttributeName
        ' Author                : Rajanikant
        ' Created               : Wednesday, Jan 07, 2004 
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String, strSELECT As String, strFROM As String
        Dim strORDERBY As String, strGROUPBY As String, strWHERE As String
        Dim arrTemp() As String = {}
        Dim intUpperBound, intLoopCtr As Integer
        Dim strValueField As String
        Dim strTempWhere As String
        Dim strExtendedWhereClause As String
        Dim arr() As String = {}
        Dim intEntityID As Long
        Dim strDrillDownFilters As String
        Dim blnIsOracleDB As Boolean = False

        Dim arrSelect() As String = {}
        Dim arrGroupBy() As String = {}
        Dim arrOrderBy() As String = {}
        Dim intUpperBound2 As Integer
        Dim intGroupCount As Integer = 0

        Dim strAccess As String = ""

        ' The Details of the query
        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_QueryDetails " & intQueryID, True)
        If dr.Read Then
            strSELECT = dr("SelectClause").ToString
            strFROM = dr("EntityName").ToString
            strWHERE = dr("WhereClause").ToString
            strGROUPBY = dr("GroupByClause").ToString
            strORDERBY = dr("OrderByClause").ToString
            strExtendedWhereClause = dr("ExtendedWhereClause").ToString
            strTempWhere = strWHERE.ToString
            intEntityID = CType(dr("EntityID"), Long)
        End If
        CloseDataReader(dr)



        ' splitting the select list on comma (",")
        arrTemp = Split(strSELECT, ",")

        ' getting the upper bound of the array of select elements
        intUpperBound = UBound(arrTemp)

        For intLoopCtr = 0 To intUpperBound
            ReDim Preserve arrSelect(intLoopCtr)
            ReDim Preserve arrOrderBy(intLoopCtr)

            If InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "SUM(", Microsoft.VisualBasic.CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "MAX(", Microsoft.VisualBasic.CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "MIN(", Microsoft.VisualBasic.CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "AVG(", Microsoft.VisualBasic.CompareMethod.Binary) > 0 _
                Or InStr(UCase(Trim(arrTemp(intLoopCtr) & "")), "COUNT(", Microsoft.VisualBasic.CompareMethod.Binary) > 0 _
                Then
                If intUpperBound = 0 Then
                    ReDim Preserve arrSelect(1)
                    ReDim Preserve arrOrderBy(1)
                    ReDim Preserve arrGroupBy(0)

                    ' function is applied
                    arr = Split(arrTemp(intLoopCtr), " As ")
                    intUpperBound2 = UBound(arr)

                    If blnIsOracleDB = True Then
                        strValueField = "NVL(" & arr(0) & ",0) As " & arr(intUpperBound2)
                    Else
                        strValueField = "IsNull(" & arr(0) & ",0) As " & arr(intUpperBound2)
                    End If
                    arrSelect(0) = "IsNull(" + strAttribute + ",'Not Specified') As " + strAttribute
                    arrOrderBy(0) = (1).ToString + " Asc"
                    arrGroupBy(0) = strAttribute
                    arrSelect(1) = strValueField
                    arrOrderBy(1) = (2).ToString + " Desc"
                    m_strPrevAttributeValue = ""
                    m_strPrevAttribute = ""
                Else
                    If intLoopCtr > 0 Then
                        ' function is applied
                        arr = Split(arrTemp(intLoopCtr), " As ")
                        intUpperBound2 = UBound(arr)

                        If blnIsOracleDB = True Then
                            strValueField = "NVL(" & arr(0) & ",0) As " & arr(intUpperBound2)
                        Else
                            strValueField = "IsNull(" & arr(0) & ",0) As " & arr(intUpperBound2)
                        End If
                        arrSelect(intLoopCtr) = strValueField
                        arrOrderBy(intLoopCtr) = (intLoopCtr + 1).ToString + " Desc"
                    Else
                        arrSelect(0) = "IsNull(" + strAttribute + ",'Not Specified') As " + strAttribute
                        arrOrderBy(0) = (intLoopCtr + 1).ToString + " Desc"
                    End If
                End If
            Else
                ReDim Preserve arrGroupBy(intGroupCount)
                'no function is applied
                If intLoopCtr = 0 Then
                    arrSelect(0) = "IsNull(" + strAttribute + ",'Not Specified') As " + strAttribute
                    arrGroupBy(intGroupCount) = strAttribute
                    arrOrderBy(intLoopCtr) = (intLoopCtr + 1).ToString + " Asc"
                Else
                    arr = Split(arrTemp(intLoopCtr), " As ")
                    intUpperBound2 = UBound(arr)

                    If blnIsOracleDB = True Then
                        strValueField = "NVL(" & arr(0) & ",0) As " & arr(intUpperBound2)
                    Else
                        strValueField = "IsNull(" & arr(0) & ",0) As " & arr(intUpperBound2)
                    End If
                    arrSelect(intLoopCtr) = strValueField
                    arrGroupBy(intGroupCount) = arrTemp(intLoopCtr)
                    arrOrderBy(intLoopCtr) = (intLoopCtr + 1).ToString + " Asc"
                End If
                intGroupCount += 1
            End If
        Next

        strSQL = "SELECT " + Join(arrSelect, ",")

        strSQL = strSQL & " FROM " & strFROM

        ' WHERE
        If Trim(m_strPrevWHERE & "") = "" Then
            ' the where clause with the level filter
            strAccess = " FunctionID=" & GetEmployeeDepartment(m_lngEmployeeID)

            'addded by harshada d on 14 feb 2006 for helpdesk enhancements
            Dim strSQLAccessibleRequests As New System.Text.StringBuilder
            'strSQLAccessibleRequests.Append(" WHERE(1 = 1)")
            strSQLAccessibleRequests.Append("  v_CRM_HelpDesk_Master.QueryID IN ")
            strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where v_CRM_HelpDesk_Master.FunctionID IN ")
            strSQLAccessibleRequests.Append("( SELECT DepartmentID FROM fnAccessibleDepts(" & m_lngEmployeeID & "")
            strSQLAccessibleRequests.Append(" ))")
            strSQLAccessibleRequests.Append("UNION")
            strSQLAccessibleRequests.Append("( Select QueryID FROM v_CRM_HelpDesk_Master where ")
            strSQLAccessibleRequests.Append(" v_CRM_HelpDesk_Master.CustomerID in (SELECT CustomerShortName ")
            strSQLAccessibleRequests.Append("from fnAccessibleCustomers (" & m_lngEmployeeID & "")
            strSQLAccessibleRequests.Append(" ))))")

            If Trim(strSQLAccessibleRequests.ToString + "") <> "" Then
                If Trim(strWHERE & "") <> "" Then
                    strWHERE = Replace(Trim(strWHERE & ""), "@", "") & " AND " + strSQLAccessibleRequests.ToString
                Else
                    strWHERE = strSQLAccessibleRequests.ToString
                End If
            End If

        Else
            ' the where clause for the last drill down
            strWHERE = "(" & m_strPrevWHERE & ")"
        End If

        ' CAll was from a detail
        If Trim(m_strPrevAttributeValue & "") <> "" Then
            If UCase(Trim(m_strPrevAttributeValue & "")) = "NOT SPECIFIED" Then
                ' THe attribute value Is "Not specifed" (implies it is NULL in the database)		
                If Trim(strWHERE & "") <> "" Then
                    strWHERE = strWHERE & " AND " & m_strPrevAttribute & "  IS NULL "
                Else
                    strWHERE = m_strPrevAttribute & " IS NULL "
                End If
            Else
                ' else appending the condition for the drill down
                If Trim(strWHERE & "") <> "" Then
                    strWHERE = strWHERE & " AND " & m_strPrevAttribute & " = '" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                Else
                    strWHERE = m_strPrevAttribute & " = '" & CommonFunctions.General.BuildQueryString(m_strPrevAttributeValue) & "'"
                End If
            End If
        End If

        strSQL = strSQL & " WHERE 1=1 "
        If Trim(strWHERE & "") <> "" Then
            strSQL = strSQL & " AND " & strWHERE
        End If

        If Trim(strExtendedWhereClause & "") <> "" Then
            arr = Split(Trim(strExtendedWhereClause & ""), " ")
            If UCase(Trim(arr(0) & "")) = "AND" Or UCase(Trim(arr(0) & "")) = "OR" Then
                strSQL = strSQL & " " & strExtendedWhereClause
            Else
                strSQL = strSQL & " AND " & strExtendedWhereClause
            End If
        End If

        ' the current where clause that will submitted
        m_strCurrWHERE = strWHERE

        strDrillDownFilters = Replace(strWHERE, strAccess, "")

        strDrillDownFilters = Replace(Trim(strDrillDownFilters & ""), Trim(strTempWhere & ""), "", 1, Len(Trim(strDrillDownFilters & "")), Microsoft.VisualBasic.CompareMethod.Binary)

        If Left(Trim(strDrillDownFilters & ""), 4) = "AND " Then
            strDrillDownFilters = Right(Trim(strDrillDownFilters & ""), Len(Trim(strDrillDownFilters & "")) - 4)
        End If

        strGROUPBY = Join(arrGroupBy, ",")
        If Right(Trim(strGROUPBY & ""), 1) = "," Then
            strGROUPBY = Left(Trim(strGROUPBY & ""), Len(Trim(strGROUPBY & "")) - 1)
        End If
        ' GROUP BY
        strSQL = strSQL & " GROUP BY " & strGROUPBY

        ' ORDER BY
        arrOrderBy.Reverse(arrOrderBy)
        strORDERBY = Join(arrOrderBy, ",")
        If Right(Trim(strORDERBY & ""), 1) = "," Then
            strORDERBY = Left(Trim(strORDERBY & ""), Len(Trim(strORDERBY & "")) - 1)
        End If
        If Trim(strORDERBY & "") <> "" Then
            strSQL = strSQL & " ORDER BY " & strORDERBY
        End If

        'REplacing the comma operator if any
        strSQL = Replace(strSQL, "@COMMA@", ",")

        strSQL = Replace(Replace(strSQL, "[[", "[", , , Microsoft.VisualBasic.CompareMethod.Binary), "]]", "]", , , Microsoft.VisualBasic.CompareMethod.Binary)
        strSQL = CommonFunctions.General.ReplacePlaceHolders(strSQL)

        ' REturning the final query
        funBuildQueryForDrillDown = Replace(Replace(strSQL & "", "[[", "["), "]]", "]")
    End Function

    Private Function GetEmployeeDepartment(ByVal EmployeeID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetEmployeeDepartment
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeDepartment " & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            GetEmployeeDepartment = CType(CommonFunctions.General.CheckIsNothing(dr("DepartmentID"), "0"), Long)
        Else
            GetEmployeeDepartment = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function funGetUserFriendlyAttributeName(ByVal intEntityID As Long, ByVal strAttributeName As String) As String
        '=====================================================================
        ' Procedure Name        : funGetUserFriendlyAttributeName()
        ' Description           : to get the user friendlyname of the attribute
        ' Purpose               : 
        ' Parameters Passed     : ByVal intEntityID, ByVal strAttributeName
        ' Returns               :
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          : communfunctions.asp,usp_CDB_Get_UserFriendlyName
        ' Author                : Rajanikant
        ' Created               : Friday, August 09, 2002 14:56 
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader

        dr = CommonFunctions.Data.GetDataReader("usp_CDB_Get_UserFriendlyName  " & intEntityID & ",'" & CommonFunctions.General.BuildQueryString(Trim(strAttributeName & "")) & "'", m_blnUseSQL)
        If dr.Read Then
            ' REturning the User Friendly name
            funGetUserFriendlyAttributeName = Trim(dr(0).ToString & "")
        Else
            ' NO match found returning the same attribute back
            funGetUserFriendlyAttributeName = Trim(strAttributeName & "")
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

    End Function


    Private Function CreateGraph(ByVal ItemID As Long, ByVal SQL As String, ByVal Height As Integer, ByVal Width As Integer, ByVal ShowDrillDowns As Boolean) As WebControl
        '=====================================================================
        ' Procedure Name        : CreateGraph
        ' Purpose               : To create the graph for the dashboard item
        ' Description           : 
        ' Parameters Passed     : itemid, sql, height,width,showdrilldowns(true/false)
        ' Returns               : graph control as web control
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
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
        Dim intUCL As Integer = 0
        Dim intLCL As Integer = 0
        Dim strUCLColor As String = ""
        Dim strLCLColor As String = ""
        Dim strPieLabelStyle As String = ""
        Dim blnShowLegends As Boolean = False
        Dim blnShowExplodedPie As Boolean = False
        Dim strItemName As String = ""
        Dim blnEnable3D As Boolean = False
        Dim series As Series
        Dim pointIndex As Integer
        Dim lngEntityID As Long
        Dim strNomenclature As String = ""
        Dim strTitleColor As String = ""

        Dim intUBound As Integer
        Dim intLoopCtr As Integer
        Dim intX As Integer
        Dim arr() As String = {}
        Dim strSeriesName As String = ""

        Dim intXAxisMax As Long = 0
        Dim intXAxisMin As Long = 0
        Dim intXAxisInterval As Long = 0

        ' get the item details
        strSQL = "EXEC usp_CDB_GetQueryDetails_ForItem " & m_lngDashboardID & "," & m_lngItemId & ",null,null,1"

        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            ' set the item values
            strItemName = dr("ItemName").ToString
            strBorderStyle = dr("BorderStyle").ToString
            strBorderColor = dr("BorderColor").ToString
            strChartBackColor = dr("ChartBackColor").ToString
            strChartAreaColor = dr("ChartAreaColor").ToString
            strCaptionColor = dr("CaptionColor").ToString
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
            strPieLabelStyle = dr("PieLabelStyle").ToString
            If Not IsDBNull(dr("DrillDownGraphTypeID")) Then
                m_intGraphID = CType(dr("DrillDownGraphTypeID"), Integer)
            Else
                m_intGraphID = CType(dr("GraphTypeID"), Integer)
            End If
            If Not IsDBNull(dr("Enable3D")) Then
                blnEnable3D = CType(dr("Enable3D"), Boolean)
            End If
            m_strConnectionString = dr("ConnectionString").ToString
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
        CloseDataReader(dr)

        ' default title color
        If Trim(strTitleColor & "") = "" Then strTitleColor = "white"

        ' Commented by nitinvs on 30 SEP 2009 Datareader is overriden in with block
        'dr = CommonFunctions.Data.GetDataReader(SQL, m_blnUseSQL)
        'End Comment by NitinVS on 30 SEP 2009
        ' create the graph for the item
        With Chart
            .Enabled = True
            '.Series("default").ChartType = GetChartType(0).ToString
            .Height = Chart.Height.Pixel(m_intGraphHeight)
            .Width = Chart.Width.Pixel(m_intGraphWidth)
            .BorderStyle = Dundas.Charting.WebControl.ChartDashStyle.Solid
            .Palette = getPalleteStyle(m_strPalleteStyle)
            .Title = strItemName + vbCrLf + "(" + funGetUserFriendlyAttributeName(lngEntityID, m_strPrevAttribute) + ":" + m_strPrevAttributeValue + ")"
            .TitleFontColor = getSystemColor(strTitleColor)
            .TitleFont = New System.Drawing.Font("verdana", 9, System.Drawing.FontStyle.Bold)
            .BackColor = getSystemColor("white")
            .BackGradientEndColor = getSystemColor(strChartBackColor)
            .BackGradientType = GradientType.TopBottom

            ' border frame 
            .BorderSkin.SkinStyle = getBorderSkinStyle(strBorderStyle)
            .BorderSkin.FrameBackColor = getSystemColor(strBorderColor)
            .BorderSkin.FrameBackGradientEndColor = getSystemColor("white")
            .BorderSkin.FrameBackGradientType = GradientType.TopBottom
            With .Legend
                .EquallySpacedItems = True
                .Enabled = False
                .InsideChartArea = ""
                .Docking = LegendDocking.Right
                .LegendStyle = LegendStyle.Column
                .BorderColor = System.Drawing.Color.Black
                .BorderWidth = 1
                .AutoFitText = True
                .Font = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
                .ShadowColor = System.Drawing.Color.FromArgb(128, 0, 0, 0)
                .ShadowOffset = 0
                .Alignment = System.Drawing.StringAlignment.Near
            End With
            With .ChartAreas("Default")
                .BackColor = getSystemColor("white")
                .BackGradientEndColor = getSystemColor(strChartAreaColor)
                If GetChartType(0).ToString.ToUpper = "PIE" Or GetChartType(0).ToString.ToUpper = "DOUGHNUT" Then
                    .BackGradientType = GradientType.Center
                Else
                    .BackGradientType = GradientType.TopBottom
                End If
                If blnEnable3D Then
                    .Area3DStyle.Light = LightStyle.Realistic
                    .Area3DStyle.Enable3D = True
                    .Area3DStyle.PointDepth = 200
                    .Area3DStyle.PointGapDepth = 200
                End If
                .BorderStyle = ChartDashStyle.Solid
                .BorderColor = getSystemColor("black")
                .BorderWidth = 1
                .ShadowOffset = 2

                .EquallySizedAxesFont = True
                If intXAxisMax <> 0 Then
                    .AxisY.Maximum = intXAxisMax
                End If
                If intXAxisMin <> 0 Then
                    .AxisY.Minimum = intXAxisMin
                End If
                If intXAxisInterval <> 0 Then
                    .AxisY.Interval = intXAxisInterval
                End If
                .AxisX.Interval = 1

                ' Disable axis labels auto fitting of text
                .AxisX.LabelsAutoFit = True

                .AxisX.LabelsAutoFitStyle = LabelsAutoFitStyle.LabelsAngleStep90 Or _
                                            LabelsAutoFitStyle.WordWrap Or _
                                            LabelsAutoFitStyle.OffsetLabels
                ' Set axis labels font
                .AxisX.LabelStyle.Font = New System.Drawing.Font("Arial", 8)
                .AxisX.LabelStyle.FontColor = getSystemColor(strCaptionColor)
                ' Set axis labels angle
                .AxisX.LabelStyle.FontAngle = 90
                ' Disable offset labels style
                .AxisX.LabelStyle.OffsetLabels = True
                ' Enable X axis labels
                .AxisX.LabelStyle.Enabled = True
                .AxisY.LabelsAutoFit = True
                .AxisY.LabelsAutoFitStyle = LabelsAutoFitStyle.LabelsAngleStep90 Or _
                                            LabelsAutoFitStyle.WordWrap Or _
                                            LabelsAutoFitStyle.OffsetLabels
                .AxisY.LabelStyle.Font = New System.Drawing.Font("Arial", 8)
            End With


            ' get the reader for the sql passed
            dr = CommonFunction.Data.GetDataReader(m_strGraphSQL, m_blnUseSQL, m_strConnectionString)

            ' populating the array for data types
            For intX = 0 To dr.FieldCount - 1
                ReDim Preserve arr(intX)
                If UCase$(Trim$(dr.GetDataTypeName(intX))) = "FLOAT" Or UCase$(Trim$(dr.GetDataTypeName(intX))) = "INT" Then
                    arr(intX) = UCase$(Trim$(dr.GetDataTypeName(intX)))
                End If
            Next intX
            dr.Close()

            ' for all fields within the recordset we check for series
            For intX = 0 To UBound(arr)

                ' add the series
                strSeriesName = "series" + (Chart.Series.Count + 1).ToString
                .Series.Add(strSeriesName)
                .Series(strSeriesName)("LabelStyle") = strPieLabelStyle

                If intX <= UBound(GetChartType) Then
                    .Series(strSeriesName).ChartType = GetChartType(intX)
                End If

                If arr(intX) = "FLOAT" Or arr(intX) = "INT" Then

                    dr = CommonFunction.Data.GetDataReader(m_strGraphSQL, m_blnUseSQL, m_strConnectionString)
                    .ChartAreas("Default").AxisX.Title = funGetUserFriendlyAttributeName(lngEntityID, dr.GetName(0))
                    .ChartAreas("Default").AxisX.TitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Bold)
                    .ChartAreas("Default").AxisY.TitleColor = getSystemColor(strCaptionColor)
                    .ChartAreas("Default").AxisY.TitleFont = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Bold)
                    If intX = 1 Then
                        .ChartAreas("Default").AxisY.Title = strNomenclature
                    Else
                        .ChartAreas("Default").AxisY.Title = funGetUserFriendlyAttributeName(lngEntityID, dr.GetName(intX))
                    End If
                    CloseDataReader(dr)

                    .Series(strSeriesName).BorderColor = getSystemColor(strCaptionColor)

                    .Series(strSeriesName).Points.DataBindXY(GetXArray(m_strGraphSQL), GetYArray(m_strGraphSQL, intX))

                    dr = CommonFunction.Data.GetDataReader(m_strGraphSQL, m_blnUseSQL, m_strConnectionString)
                    If GetChartType(intX).Trim.ToUpper = "PIE" Or GetChartType(intX).Trim.ToUpper = "DOUGHNUT" Then
                        .Series(strSeriesName).LegendText = .Series(strSeriesName).AxisLabel '"#VALX--#VALY:#PERCENT" 
                    Else
                        .Series(strSeriesName).LegendText = funGetUserFriendlyAttributeName(lngEntityID, dr.GetName(intX))
                    End If

                    CommonFunction.Data.DisposeDataReader(dr)

                    ' series properties
                    .Series(strSeriesName).ShowInLegend = True
                    .Series(strSeriesName).ShowLabelAsValue = True
                    If Not (GetChartType(intX).Trim.ToUpper = "PIE" Or GetChartType(intX).Trim.ToUpper = "DOUGHNUT") Then
                        .Series(strSeriesName)("BarLabelStyle") = "Center"
                    End If
                    .Series(strSeriesName).LabelFormat = "N"
                    .Series(strSeriesName).FontColor = getSystemColor(strCaptionColor)
                Else
                    .Series(strSeriesName).ShowInLegend = False
                End If
            Next intX
        End With


        For Each series In Chart.Series
            ' inside/outside labels for pie charts
            If series.ChartType.Trim.ToUpper = "PIE" Then
                If Trim$(strPieLabelStyle & "") = "" Then
                    strPieLabelStyle = "inside"
                End If
                series.CustomAttributes = "LabelStyle=" + strPieLabelStyle
            End If

            For pointIndex = 0 To series.Points.Count - 1
                series.ToolTip = "#PERCENT"

                ' the caption for legends
                If series.ChartType.Trim.ToUpper <> "PIE" And series.ChartType.Trim.ToUpper <> "DOUGHNUT" Then
                    series.Points(pointIndex).FontColor = getSystemColor(strCaptionColor)
                End If
                series.Points(pointIndex).ToolTip = Replace(series.Points(pointIndex).AxisLabel, "'", "", , , Microsoft.VisualBasic.CompareMethod.Binary) + "\n" + "value:#VAL" + "\n" + "percentage:#PERCENT"
                series.Points(pointIndex).Font = New System.Drawing.Font("verdana", 8, System.Drawing.FontStyle.Regular)

                If blnShowLegends Then
                    series.Points(pointIndex).LegendText = series.Points(pointIndex).AxisLabel + "(#PERCENT)"
                End If

                If series.ChartType.Trim.ToUpper = "PIE" And blnShowExplodedPie = True Then
                    series.Points(pointIndex)("Exploded") = "True"
                End If
                If (series.ChartType.Trim.ToUpper = "PIE" Or series.ChartType.Trim.ToUpper = "DOUGHNUT") Then
                    series.Points(pointIndex).Label = series.Points(pointIndex).AxisLabel
                    If blnShowExplodedPie Then
                        series.Points(pointIndex)("Exploded") = "true"
                    End If
                Else
                    series.Points(pointIndex).Label = "#VAL"
                    series.Points(pointIndex)("LabelStyle") = "Top"
                    Select Case series.ChartType.Trim.ToUpper
                        Case "LINE", "SPLINE", "STEPLINE"
                            series.Points(pointIndex)("PointWidth") = "1"
                        Case Else
                    End Select
                End If
            Next pointIndex
        Next series

        If m_intGraphID <> 5 Then
            With Chart
                If intUCL > 0 Then
                    ' adding a series here actually
                    intUBound = UBound(GetXArray(m_strGraphSQL))
                    .Series.Add("UCL")
                    .Series("UCL").ChartType = "LINE"
                    .Series("UCL").Points.AddY(CType(intUCL, Double))
                    For intLoopCtr = 0 To intUBound
                        .Series("UCL").Points.AddY(CType(intUCL, Double))
                    Next
                    .Series("UCL").Points.AddY(CType(intUCL, Double))
                    .Series("UCL").Color = getSystemColor(strUCLColor)
                    .Series("UCL").CustomAttributes = "PointWidth = 1"
                End If

                ' set the LCL value
                If intLCL > 0 Then
                    ' adding a series here actually
                    intUBound = UBound(GetXArray(m_strGraphSQL))
                    .Series.Add("LCL")
                    .Series("LCL").ChartType = "LINE"
                    .Series("LCL").Points.AddY(CType(intLCL, Double))
                    For intLoopCtr = 0 To intUBound
                        .Series("LCL").Points.AddY(CType(intLCL, Double))
                    Next
                    .Series("LCL").Points.AddY(CType(intLCL, Double))
                    .Series("LCL").Color = getSystemColor(strLCLColor)
                    .Series("LCL").CustomAttributes = "PointWidth = 1"
                End If
            End With


        End If


    End Function


    Private Function GetChartType() As String()
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
        ' Created               : Nov 22,2003
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

        ds = CommonFunctions.Data.GetDataSet(m_strSQL, "default", , , UseSQL)
        intUBound = ds.Tables(0).Columns.Count()
        ds.Dispose() : ds = Nothing

        strSQL = "usp_sel_tbl_CDB_Item_Series_Master " + m_lngItemId.ToString
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        Do While dr.Read
            ReDim Preserve arrGraph(intCount)
            arrGraph(intCount) = dr("GraphID").ToString
            intCount += 1
        Loop
        CloseDataReader(dr)

        Select Case m_intGraphID
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
            Case 12 : Return "RADAR"
            Case Else : Return "COLUMN"
        End Select
    End Function

    Private Function GetXArray(ByVal SQL As String) As String()
        '=====================================================================
        ' Function   Name       :   GetXArray
        ' Parameters Passed     :   SQL 
        ' Returns               :   Array for X value (string)
        ' Parameters Affected   :   None
        ' Purpose               :   To get the X array for graph
        ' Description           :  
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   Rajanikant
        ' Created               :   Nov 26 2003
        ' Revisions             :   
        '=====================================================================
        Dim ds As DataSet = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL, m_strConnectionString)

        'Dim intTotalColumns As Integer = ds.Tables(0).Columns.Count
        Dim intTotalRows As Integer = ds.Tables(0).Rows.Count
        Dim intCount As Integer
        Dim arr(intTotalRows - 1) As String
        Dim DataRow As DataRow

        For Each DataRow In ds.Tables(0).Rows
            arr(intCount) = DataRow(0).ToString
            intCount += 1
        Next

        ds = Nothing
        DataRow = Nothing

        Return arr

    End Function


    Private Function GetYArray(ByVal SQL As String, ByVal ColumnNumber As Integer) As Double()
        '=====================================================================
        ' Function   Name       :   GetYArray
        ' Parameters Passed     :   SQL and column number
        ' Returns               :   Array for Y value (double)
        ' Parameters Affected   :   None
        ' Purpose               :   To get the Y array for graph
        ' Description           :  
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   Rajanikant
        ' Created               :   Nov 26 2003
        ' Revisions             :   
        '=====================================================================
        Dim ds As DataSet = CommonFunctions.Data.GetDataSet(SQL, "default", , , m_blnUseSQL, m_strConnectionString)

        'Dim intTotalColumns As Integer = ds.Tables(0).Columns.Count
        Dim intTotalRows As Integer = ds.Tables(0).Rows.Count
        Dim intCount As Integer
        Dim arr(intTotalRows - 1) As Double
        Dim DataRow As DataRow

        For Each DataRow In ds.Tables(0).Rows

            If Not IsDBNull(DataRow(ColumnNumber)) Then
                Try
                    arr(intCount) = CType(FormatNumber(DataRow(ColumnNumber), 2), Double)
                Catch
                    arr(intCount) = CType(DataRow(ColumnNumber), Double)
                End Try
            Else
                arr(intCount) = 0
            End If
            intCount += 1
        Next

        ds = Nothing
        DataRow = Nothing

        Return arr

    End Function


    Private Sub CloseDataReader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : CloseDataReader
        ' Purpose               : To close the datareader object
        ' Description           : 
        ' Parameters Passed     : data reader object
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 22,2003
        ' Revisions             :
        '=====================================================================
        If Not dr Is Nothing Then
            If Not dr.IsClosed Then
                dr.Close() : dr.Dispose()
            End If
        End If
        dr = Nothing
    End Sub


    Private Function getSystemColor(ByVal strColor As String) As System.Drawing.Color
        '=====================================================================
        ' Function   Name       :   getSystemColor
        ' Parameters Passed     :   color name as string
        ' Returns               :   system color
        ' Parameters Affected   :   None
        ' Purpose               :   To get the equivalent system color
        ' Description           :  
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   Rajanikant
        ' Created               :   August 11 2003
        ' Revisions             :   
        '=====================================================================
        Try
            Return System.Drawing.Color.FromName(Trim(strColor & ""))
        Catch exc As Exception
            Return System.Drawing.Color.White

        End Try
    End Function

    Private Function getBorderSkinStyle(ByVal strSkinStyle As String) As BorderSkinStyle
        '=====================================================================
        ' Function   Name       :   getBorderSkinStyle
        ' Parameters Passed     :   Skin Style name as string
        ' Returns               :   BorderSkinStyle
        ' Parameters Affected   :   None
        ' Purpose               :   To get the BorderSkinStyle for the graph
        ' Description           :  
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   Rajanikant
        ' Created               :   August 09 2003
        ' Revisions             :   
        '=====================================================================
        Try
            Select Case UCase$(Trim$(strSkinStyle & ""))
                Case "NONE"
                    Return BorderSkinStyle.None
                Case "EMBOSS"
                    Return BorderSkinStyle.Emboss
                Case "RAISED"
                    Return BorderSkinStyle.Raised
                Case "SUNKEN"
                    Return BorderSkinStyle.Sunken
                Case "FRAMETHIN1"
                    Return BorderSkinStyle.FrameThin1
                Case "FRAMETHIN2"
                    Return BorderSkinStyle.FrameThin2
                Case "FRAMETHIN3"
                    Return BorderSkinStyle.FrameThin3
                Case "FRAMETHIN4"
                    Return BorderSkinStyle.FrameThin4
                Case "FRAMETHIN5"
                    Return BorderSkinStyle.FrameThin5
                Case "FRAMETHIN6"
                    Return BorderSkinStyle.FrameThin6
                Case "FRAMETITLE1"
                    Return BorderSkinStyle.FrameTitle1
                Case "FRAMETITLE2"
                    Return BorderSkinStyle.FrameTitle2
                Case "FRAMETITLE3"
                    Return BorderSkinStyle.FrameTitle3
                Case "FRAMETITLE4"
                    Return BorderSkinStyle.FrameTitle4
                Case "FRAMETITLE5"
                    Return BorderSkinStyle.FrameTitle5
                Case "FRAMETITLE6"
                    Return BorderSkinStyle.FrameTitle6
                Case "FRAMETITLE7"
                    Return BorderSkinStyle.FrameTitle7
                Case "FRAMETITLE8"
                    Return BorderSkinStyle.FrameTitle8
                Case Else
                    Return BorderSkinStyle.None
            End Select
        Catch exc As Exception
            Return BorderSkinStyle.None
        End Try
    End Function

    Private Function getPalleteStyle(ByVal strPallete As String) As ChartColorPalette
        '=====================================================================
        ' Function   Name       :   getPalleteStyle
        ' Parameters Passed     :   Pallete name as string
        ' Returns               :   ChartColorPalette
        ' Parameters Affected   :   None
        ' Purpose               :   To get the ChartColorPalette for the graph
        ' Description           :  
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   Rajanikant
        ' Created               :   August 09 2003
        ' Revisions             :   
        '=====================================================================
        Try
            Select Case UCase$(Trim$(strPallete & ""))
                Case "EARTHTONES"
                    Return ChartColorPalette.EarthTones
                Case "EXCEL"
                    Return ChartColorPalette.Excel
                Case "GRAYSCALE"
                    Return ChartColorPalette.GrayScale
                Case "LIGHT"
                    Return ChartColorPalette.Light
                Case "DEFAULT"
                    Return ChartColorPalette.Default
                Case "NONE"
                    Return ChartColorPalette.None
                Case "PASTEL"
                    Return ChartColorPalette.Pastel
                Case "SEMITRANSPARENT"
                    Return ChartColorPalette.SemiTransparent
                Case "BERRY"
                    Return ChartColorPalette.Berry
                Case "CHOCOLATE"
                    Return ChartColorPalette.Chocolate
                Case "FIRE"
                    Return ChartColorPalette.Fire
                Case "SEAGREEN"
                    Return ChartColorPalette.SeaGreen
                Case Else
                    Return ChartColorPalette.None
            End Select
        Catch exc As Exception
            Return ChartColorPalette.None
        End Try
    End Function

End Class
