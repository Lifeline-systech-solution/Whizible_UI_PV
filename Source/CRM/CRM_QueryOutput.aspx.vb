Public Class CRM_QueryOutput
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	CRM_QueryOutput
    ' Purpose				:	The class generates the output of the query
    '                           for CDB module. 
    ' Description			:	The page displays the query output in a grid 
    '                           format.
    ' Assumptions			:	None
    ' Dependencies			:	
    ' Author				:	Rajanikant
    ' Created				:	Feb 21, 2003
    ' Revisions				:	
    '=====================================================================
    Protected m_lngQueryID As Long
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    Protected m_strColName As String = ""
    Protected m_strColValue As String = ""
    Protected m_lngAlertID As Long
    Private m_lngUserID As Long
    Private m_blnUseSQL As Boolean
    Protected m_PKToken_Query_DT As String = "" '' Added by Yogesh J 

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
        ''Added by Yogesh J on 19-Jan-2016 for to generate and validate Token
        If m_PKToken_Query_DT <> "" Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_Query_DT) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_lngQueryID, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of addition by Yogesh J 
        Call WriteQueryOutputPage()
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        ' the query id
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("QueryID"), Long)

        End If

        ' the alert id
        If Not Request.QueryString("AlertID") Is Nothing Then
            m_lngAlertID = CType(Request.QueryString("AlertID"), Long)
        End If

        ' sort by field
        If Not Request.QueryString("sortby") Is Nothing Then
            m_strSortBy = Request.QueryString("sortby")
        End If

        ' sort order 
        If Not Request.QueryString("sortorder") Is Nothing Then
            m_strSortOrder = Request.QueryString("sortorder")
        End If

        ' column
        If Not Request.QueryString("colname") Is Nothing Then
            m_strColName = Request.QueryString("colname")
        End If

        ' column value
        If Not Request.QueryString("colvalue") Is Nothing Then
            m_strColValue = Request.QueryString("colvalue")
        End If
        ''Added by Yogesh J on 19-Jan-2016 for generate and validate Token
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKToken_Query_DT = Request.QueryString("PKToken").ToString
        End If
        ''Ended by Yogesh J on 19-Jan-2016 for generate and validate Token
        m_lngUserID = CType(Session("intUserID"), Long)
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
    End Sub


    Private Sub WriteQueryOutputPage()
        '=====================================================================
        ' Procedure Name        : WriteQueryOutputPage()	
        ' Purpose               : To write the Query Output page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : BuildGrid(), module variables
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick('CDB_GENERAL')"}
        Dim lngTotalRecords As Long
        Dim strGrid As String
        ' write the menu
        Call WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False)
        Response.Write("<BR>")
        ' the query information
        Call WriteQueryInformation(m_lngQueryID)
        Response.Write("<BR>")
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        ' get the grid
        strGrid = BuildGrid(m_lngQueryID, m_strSortBy, m_strSortOrder, 0, m_blnUseSQL, True, lngTotalRecords, m_strColName, m_strColValue, m_lngAlertID, MyBase.GetResourceString("NO_RECORDS"), Trim(Request.QueryString("CURRWHERE") & ""), m_lngUserID)
        ' total no of rows:
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        Response.Write("<Table width=99.9% class=clsTable cellpadding=0 cellspacing=0 ><tr class=clsTRSectionHeader><td align=left><B>Total records: " + lngTotalRecords.ToString + "</B></td></tr></table>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        ' display the grid
        Response.Write(strGrid)

        ' clean up
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrCSFunction = Nothing
    End Sub


    Private Sub WriteQueryInformation(ByVal lngQueryID As Long)
        '=====================================================================
        ' Procedure Name        : WriteQueryInformation()	
        ' Purpose               : To write the query information
        ' Description           : Same as above
        ' Parameters Passed     : ByVal Query ID
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : usp_sel_tbl_QRB_Query_Master
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strCurrentWhereClause As String = ""

        If Trim(m_strColName & "") <> "" Then
            strCurrentWhereClause = "<B>" + CommonFunctions.General.FormatString(m_strColName) + "='" + CommonFunctions.General.FormatString(m_strColValue) + "'" + "</B>"
        End If

        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Query_Master " + lngQueryID.ToString, m_blnUseSQL)
        If dr.Read Then
            With Response
                'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                .Write("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='99.9%'>")
                'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                .Write("<TR class=clsTREven>")
                .Write("<TD align=left width='30%'><B>Entity Name </B></TD><TD align=left>: " + dr("UserFriendlyEntityName").ToString + "</TD>")
                .Write("</TR>")
                .Write("<TR class=clsTREven>")
                .Write("<TD align=left width='30%'><B>Generated On </B></TD><TD align=left>: " + CommonFunctions.Dates.CGetDateTime(Now.Date) + "</TD>")
                .Write("</TR>")
                .Write("<TR class=clsTREven>")
                If Trim(dr("UserFriendlyWhereClause").ToString & "") <> "" Then
                    .Write("<TD align=left width='30%'><B>Filters </B></TD><TD align=left>: " + dr("UserFriendlyWhereClause").ToString)
                End If
                If Trim(dr("UserFriendlyWhereClause").ToString & "") <> "" Then
                    If Trim(strCurrentWhereClause & "") <> "" Then
                        .Write(" AND " + strCurrentWhereClause + "</TD>")
                    End If
                End If
                .Write("</TR>")
                .Write("</TABLE>")
            End With
        End If
        CloseDataReader(dr)
    End Sub


    Public Shared Function BuildGrid(ByVal lngQueryID As Long, ByVal strSortBy As String, ByVal strSortOrder As String, ByVal intDivHeight As Integer, ByVal UseSQL As Boolean, Optional ByVal ReturnHTML As Boolean = False, Optional ByRef NoOfRows As Long = 0, Optional ByVal ColName As String = "", Optional ByVal ColValue As String = "", Optional ByVal AlertID As Long = 0, Optional ByVal NoDataComment As String = "", Optional ByVal strPrevWhere As String = "", Optional ByVal UserID As Long = 0) As String
        '=====================================================================
        ' Procedure Name        : BuildGrid()	
        ' Purpose               : To build the grid for the Query id
        ' Description           : To build the grid for the Query id
        ' Parameters Passed     : ByVal Query ID, sortby, sortorder, div height
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : ProjectByNet.QueryBuilder namespace
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        Dim objAccessibleAttributes As QueryBuilders.cAccessibleAttributes
        'Dim objGrid As WebPage.Grid.cGenericGrid
        Dim objGrid As WebPage.Templates.GenericGrid

        Dim dr As IDataReader
        Dim drDetail As IDataReader
        Dim lngEntityID As Long
        Dim intX As Integer
        Dim intY As Integer
        Dim intUpperBound As Integer
        Dim intActualColumnCount As Integer
        Dim strOrderBy As String = ""
        Dim strSQL As String = ""
        Dim arrAttributesAN() As String = {}
        Dim arrAttributesUFN() As String = {}
        Dim arrAttributes() As String = {}
        Dim arrAttributesUFAttributes() As String = {}
        Dim strWhereClause As String = ""
        Dim arrRowLink() As String = {}
        Dim strLinkURL As String = ""
        Dim intWinHeight As Integer = 0
        Dim intWinWidth As Integer = 0
        Dim strLinkSQL As String = ""
        Dim strKeyName As String = ""
        Dim strKeyValue As String = ""
        Dim arrQueryString() As String = {}
        Dim arrPlaceHolder() As String = {}
        Dim strFields As String
        Dim intCount2 As Integer
        Dim intCount3 As Integer
        Dim intUBound1 As Integer
        Dim intUBound2 As Integer
        Dim lngFunctionID As Long
        Dim intUBound As Integer
        Dim arr() As String = {}

        ' append the current where clause

        If Trim(ColName & "") <> "" Then
            If UCase(Trim(ColValue & "")) = "NOT SPECIFIED" Then
                strWhereClause = ColName + " IS NULL "
            Else
                strWhereClause = ColName + "='" + CommonFunctions.General.BuildQueryString(ColValue) + "'"
            End If
        End If

        If Trim(strPrevWhere & "") <> "" Then
            strWhereClause = "(" & strWhereClause & ") AND (" & strPrevWhere & ")"
        End If

        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeDepartment " & UserID, UseSQL)
        If dr.Read Then
            lngFunctionID = CType(CommonFunctions.General.CheckIsNothing(dr("DepartmentID"), "0"), Long)
        Else
            lngFunctionID = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        'Commented by SandipL 03 Jul 2007 Employee can have access of other depts

        'If Trim(strWhereClause & "") <> "" Then
        '    strWhereClause += " AND FunctionID = " & lngFunctionID
        'Else
        '    strWhereClause += " FunctionID = " & lngFunctionID
        'End commenting by SandipL
        'End If 


        ' sort order
        If Trim(strSortBy & "") <> "" Then
            strOrderBy = strSortBy + " " + strSortOrder
        End If

        ' get the SQL for the grid
        strSQL = BuildQuery(lngQueryID, UseSQL, strOrderBy, strWhereClause)

        ' get the entityid for the query
        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_QRB_Query_Master " + lngQueryID.ToString, UseSQL)
        If dr.Read Then
            lngEntityID = CType(dr("EntityID"), Long)
        Else
            ' entity id is missing 
            Exit Function
        End If
        CloseDataReader(dr)


        ' populate the attirb arrays
        Call PopulateEntityAttributeArrays(lngEntityID, arrAttributes, arrAttributesUFAttributes, UseSQL)
        intUpperBound = UBound(arrAttributes)
        ReDim arrAttributesAN(0) : ReDim arrAttributesUFN(0)

        ' execute the SQL passed--> to get the actual columns
        dr = CommonFunction.Data.GetDataReader(strSQL, UseSQL)
        For intX = 0 To dr.FieldCount - 1
            ReDim Preserve arrAttributesAN(intX) : ReDim Preserve arrAttributesUFN(intX)
            For intY = 0 To intUpperBound
                If arrAttributes(intY).Trim.ToUpper = dr.GetName(intX).Trim.ToUpper _
                Or arrAttributes(intY).Trim.ToUpper = "[" + dr.GetName(intX).Trim.ToUpper + "]" Then
                    intActualColumnCount += 1
                    arrAttributesAN(intX) = Replace(Replace(arrAttributes(intY).Trim, "]", ""), "[", "")
                    arrAttributesUFN(intX) = Replace(Replace(arrAttributesUFAttributes(intY).Trim, "]", ""), "[", "")
                    Exit For
                End If
            Next
        Next
        CloseDataReader(dr)

        If AlertID > 0 Then
            intUpperBound = UBound(arrAttributesUFN)
            ' get the query which returns all columns
            strLinkSQL = BuildQuery(lngQueryID, UseSQL, strOrderBy, strWhereClause, True)

            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_CDB_Alert_Links " + AlertID.ToString, UseSQL)
            Do While dr.Read

                If Not IsDBNull(dr("WindowHeight")) Then
                    intWinHeight = CType(dr("WindowHeight"), Integer)
                End If

                If Not IsDBNull(dr("WindowWidth")) Then
                    intWinWidth = CType(dr("WindowWidth"), Integer)
                End If
                ReDim Preserve arrRowLink(intUpperBound + 1)
                ReDim Preserve arrAttributesAN(intUpperBound + 1)
                ReDim Preserve arrAttributesUFN(intUpperBound + 1)
                arrAttributesAN(intUpperBound + 1) = dr("LinkName").ToString
                arrAttributesUFN(intUpperBound + 1) = dr("LinkName").ToString

                ' there is some link associated to the alert
                If Not IsDBNull(dr("LinkURL")) Then

                    If InStr(dr("LinkURL").ToString, "<", CompareMethod.Binary) > 0 Then
                        arrRowLink(intUpperBound + 1) = "LinkURL_OnClick({}" + dr("LinkURL").ToString + ",{}" + intWinHeight.ToString + ",{}" + intWinWidth.ToString + ")"
                        ' there are place holders which are to be replaced with data values
                        ' build the url
                        arrQueryString = Split(dr("LinkURL").ToString, "<", -1, CompareMethod.Binary)
                        intUBound1 = UBound(arrQueryString)
                        For intCount2 = 0 To intUBound1
                            If InStr(arrQueryString(intCount2), ">", CompareMethod.Binary) > 0 Then
                                arrPlaceHolder = Split(arrQueryString(intCount2), ">")
                                intUBound2 = UBound(arrPlaceHolder)
                                If intUBound2 >= 0 Then
                                    strFields += "," + arrPlaceHolder(0)
                                End If
                            End If
                        Next

                        If Left(strFields, 1) = "," Then
                            strFields = Right(strFields, Len(strFields) - 1)
                        End If

                        ' modify the sql
                        strSQL = Replace(strSQL, " FROM ", "," + strFields + " FROM ", 1, -1, CompareMethod.Binary)
                        If InStr(strSQL, " GROUP BY ", CompareMethod.Binary) > 0 Then
                            strSQL = Replace(strSQL, " GROUP BY ", " GROUP BY " + strFields + ",", 1, -1, CompareMethod.Binary)
                        Else
                            arr = Split(Replace(UCase(strSQL), "SELECT ", "", , , CompareMethod.Binary), " FROM ", , CompareMethod.Binary)
                            If UBound(arr) <> -1 Then
                                arr = Split(arr(0), ",", , CompareMethod.Binary)
                                intUBound = UBound(arr)
                                For intX = 0 To intUBound
                                    Select Case UCase(Trim(Left(arr(intX), 4) & ""))
                                        Case "SUM(", "MIN(", "MAX(", "AVG("
                                            strSQL += " GROUP BY " + strFields
                                            Exit For
                                        Case Else
                                            If UCase(Trim(Left(arr(intX), 6) & "")) = "COUNT(" Or UCase(Trim(Left(arr(intX), 9) & "")) = "DISTINCT(" Then
                                                strSQL += " GROUP BY " + strKeyValue
                                                Exit For
                                            End If
                                    End Select
                                Next
                            End If
                        End If
                    Else
                        arrRowLink(intUpperBound + 1) = "LinkURL_OnClick({}'" + dr("LinkURL").ToString + "',{}" + intWinHeight.ToString + ",{}" + intWinWidth.ToString + ")"
                    End If

                Else
                    If Trim(dr("PrimaryKey").ToString & "") <> "" Then

                        ' get the key name & value
                        drDetail = CommonFunctions.Data.GetDataReader("usp_CDB_Get_KeyNames " + AlertID.ToString + "," + dr("LinkQueryID").ToString, UseSQL)
                        If drDetail.Read Then
                            strKeyName = drDetail("KeyName").ToString
                            strKeyValue = drDetail("KeyValue").ToString
                        End If
                        CloseDataReader(drDetail)

                        ' modify the sql
                        strSQL = Replace(strSQL, " FROM ", "," + strKeyValue + " FROM ", 1, -1, CompareMethod.Binary)
                        If InStr(strSQL, " GROUP BY ", CompareMethod.Binary) > 0 Then
                            strSQL = Replace(strSQL, " GROUP BY ", " GROUP BY " + strKeyValue + ",", 1, -1, CompareMethod.Binary)
                        Else
                            arr = Split(Replace(UCase(strSQL), "SELECT ", "", , , CompareMethod.Binary), " FROM ", , CompareMethod.Binary)
                            If UBound(arr) <> -1 Then
                                arr = Split(arr(0), ",", , CompareMethod.Binary)
                                intUBound = UBound(arr)
                                For intX = 0 To intUBound
                                    Select Case UCase(Trim(Left(arr(intX), 4) & ""))
                                        Case "SUM(", "MIN(", "MAX(", "AVG("
                                            strSQL += " GROUP BY " + strKeyValue
                                            Exit For
                                        Case Else
                                            If UCase(Trim(Left(arr(intX), 6) & "")) = "COUNT(" Or UCase(Trim(Left(arr(intX), 9) & "")) = "DISTINCT(" Then
                                                strSQL += " GROUP BY " + strKeyValue
                                                Exit For
                                            End If
                                    End Select
                                Next
                            End If
                        End If

                        ' set the row link function
                        arrRowLink(intUpperBound + 1) = "LinkQuery_OnClick('{}" + strKeyName + "','" + strKeyValue + "',{}" + dr("LinkQueryID").ToString + ",{}" + intWinHeight.ToString + ",{}" + intWinWidth.ToString + ")"
                    Else
                        ' no key has to be passed
                        arrRowLink(intUpperBound + 1) = "LinkQuery_OnClick('{}1','{}1',{}" + dr("LinkQueryID").ToString + ",{}" + intWinHeight.ToString + ",{}" + intWinWidth.ToString + ")"
                    End If
                End If
                intUpperBound += 1
            Loop
            CloseDataReader(dr)
        End If


        ' Grid object
        objGrid = New WebPage.Templates.GenericGrid
        ' set attributes
        objGrid.ActualColumnArray = arrAttributesAN
        objGrid.UserFriendlyColumnArray = arrAttributesUFN
        objGrid.RowLinkArray = arrRowLink
        objGrid.ClientSideSortFunctionName = "Sort_OnClick"
        objGrid.DIVHeight = intDivHeight : objGrid.DIVID = "DivList" : objGrid.DIVStyle = "overflow:scroll"
        objGrid.NoOfDataColumns = intActualColumnCount
        objGrid.SortOrder = strSortOrder : objGrid.SortBy = strSortBy
        objGrid.PrinterFriendlyVersion = False
        objGrid.SQL = strSQL : objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = ReturnHTML
        objGrid.UseSQL = UseSQL

        ' return html string/ write the grid
        BuildGrid = objGrid.DrawGrid()

        'Added By Bharat T on 11th_Nov-2016 for MasterCard Upgrade Issue fixing
        BuildGrid = "<Div id='DivList'>" & BuildGrid & " </Div>"
        'End of Added By Bharat T on 11th_Nov-2016 for MasterCard Upgrade Issue fixing

        ' set the no of rows in the grid
        NoOfRows = objGrid.NoOfRows


        ' clean up
        arrAttributes = Nothing : arrAttributesUFAttributes = Nothing
        arrAttributesAN = Nothing : arrAttributesUFN = Nothing : objGrid = Nothing

    End Function




    Public Shared Sub PopulateEntityAttributeArrays(ByVal EntityID As Long, ByRef arrActual As String(), ByRef arrUserFriendly As String(), ByVal UseSQL As Boolean)
        '=====================================================================
        ' Procedure Name        : PopulateEntityAttributeArrays()	
        ' Purpose               : To populate the arrays of attributes for the entity
        ' Description           : same as above
        ' Parameters Passed     : ByVal entityID, byref actualattrib(), byref userfriendlyattrib()
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Usp_QRB_AllAttributes_For_FormulaBuilder
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim intX As Integer
        dr = CommonFunctions.Data.GetDataReader(" Usp_QRB_AllAttributes_For_FormulaBuilder " + EntityID.ToString, UseSQL)
        intX = 0
        Do While dr.Read
            ReDim Preserve arrActual(intX) : ReDim Preserve arrUserFriendly(intX)
            arrActual(intX) = dr("AttributeName").ToString : arrUserFriendly(intX) = dr("UserFriendlyAttributeName").ToString
            intX += 1
        Loop
        'dr.Close() : dr = Nothing
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub


    Public Shared Function BuildQuery(ByVal QueryID As Long, ByVal UseSQL As Boolean, Optional ByVal strORDERBY As String = "", Optional ByVal strWhereClause As String = "", Optional ByVal SelectAllColumns As Boolean = False) As String
        '=====================================================================
        ' Procedure Name        : BuildQuery()	
        ' Purpose               : To build the query for the Query id
        ' Description           : To build the query for the Query id
        ' Parameters Passed     : ByVal Query ID
        ' Returns               : SQL string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : QueryBuilder.cBuildQuery
        ' Author                : Rajanikant
        ' Created               : Nov 10,2003
        ' Revisions             :
        '=====================================================================
        Dim objQRB As QueryBuilders.cQuery

        objQRB = New QueryBuilders.cQuery(HttpContext.Current.Session("strUserName").ToString, CType(HttpContext.Current.Session("intPostID"), Long), CType(HttpContext.Current.Session("intUserID"), Long), HttpContext.Current.Session("LoginType").ToString, 1, CType(HttpContext.Current.Session("IsCreatedByCustomer"), Boolean))
        objQRB.QueryID = QueryID : objQRB.UseSQL = UseSQL
        BuildQuery = objQRB.BuildQuery(, strWhereClause, , strORDERBY, , SelectAllColumns)
        objQRB = Nothing
    End Function


    Public Shared Sub CloseDataReader(ByRef dr As IDataReader)
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
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub
End Class
