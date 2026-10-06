Imports Whiz.CommonFunction
Imports System.Data.SqlClient
Imports System.Text
Imports PbNIT

Namespace QueryBuilder

    Public Class cAccessibleAttributes
        Inherits QueryBuilders.cAccessibleAttributes
        'Inherits WebPage.Templates.Global
        ''=====================================================================
        '' Class	Name	        :	cAccessibleAttributes
        '' Purpose				:	This class will return two arrays for
        ''                           accessible attribs for the user in an entity
        '' Description			:	same as above
        ''                           
        '' Assumptions			:	None
        '' Dependencies			:	None
        '' Author				:	Rajanikant
        '' Created				:	Spetember 08,2003
        '' Revisions				:	
        ''=====================================================================
        'Private m_arrUFAttributes() As String
        'Private m_arrAttributes() As String
        'Private m_intEntityID As Long
        'Private m_blnUseSQL As Boolean

        'Public ReadOnly Property UserFriendlyAccessibleAttributes() As String()
        '    Get
        '        UserFriendlyAccessibleAttributes = m_arrUFAttributes
        '    End Get
        'End Property

        'Public ReadOnly Property AccessibleAttributes() As String()
        '    Get
        '        AccessibleAttributes = m_arrAttributes
        '    End Get
        'End Property

        'Public Property EntityID() As Long
        '    Get
        '        EntityID = m_intEntityID
        '    End Get
        '    Set(ByVal Value As Long)
        '        m_intEntityID = Value
        '    End Set
        'End Property

        'Public Property UseSQL() As Boolean
        '    Get
        '        UseSQL = m_blnUseSQL
        '    End Get
        '    Set(ByVal Value As Boolean)
        '        m_blnUseSQL = Value
        '    End Set
        'End Property


        'Sub New()

        'End Sub

        Sub New(ByVal UserName As String, ByVal RoleID As Long, ByVal UserID As Long, _
                ByVal LoginType As String, ByVal RoleLevel As Integer, Optional ByVal IsCustomerCreated As Boolean = False)
            MyBase.UserName = UserName
            MyBase.RoleID = RoleID
            MyBase.UserID = UserID
            MyBase.LoginType = LoginType
            MyBase.RoleLevel = RoleLevel
            MyBase.IsCustomerCreated = IsCustomerCreated
        End Sub

        'Public Function GetAccessibleAttributes() As Boolean
        '    '=====================================================================
        '    ' Function	Name        :	GetAccessibleAttributes
        '    ' Purpose				:	This function populates the module arrays
        '    '                           for accessible attributes.
        '    ' Description			:	same as above
        '    ' Assumptions			:	None
        '    ' return param.         :   True if successfull else false
        '    ' Dependencies			:	
        '    ' Author				:	Rajanikant
        '    ' Created				:	September 06,2003
        '    ' Revisions				:	
        '    '=====================================================================
        '    Dim dr As IDataReader
        '    Dim sb As System.Text.StringBuilder
        '    Dim intCount As Integer

        '    Try
        '        ' build the sql string
        '        sb = New System.Text.StringBuilder("")
        '        sb.Append("usp_QRB_GetAccessibleAttributes_For_QueryResult ")
        '        sb.Append(m_intEntityID)
        '        sb.Append(",'")
        '        sb.Append(CommonFunction.General.BuildQueryString(MyBase.UserName).Trim)
        '        sb.Append("','")
        '        sb.Append(CommonFunction.General.BuildQueryString(MyBase.LoginType).Trim)
        '        sb.Append("'")

        '        ' get the datareader for the sql
        '        dr = CommonFunction.Data.GetDataReader(sb.ToString, m_blnUseSQL)
        '        intCount = 0
        '        Do While dr.Read
        '            ' resize the arrays
        '            ReDim Preserve m_arrAttributes(intCount)
        '            ReDim Preserve m_arrUFAttributes(intCount)
        '            ' populate the arrays
        '            m_arrAttributes(intCount) = dr("AttributeName").ToString
        '            m_arrUFAttributes(intCount) = dr("UserFriendlyAttributeName").ToString
        '            intCount += 1
        '        Loop
        '        Return True

        '    Catch e As Exception
        '        Return False
        '    End Try
        'End Function

    End Class


    Public Class cQuery
        Inherits QueryBuilders.cQuery
        'Inherits WebPage.Templates.Global
        ''=====================================================================
        '' Class	Name	        :	cBuildQuery
        '' Purpose				:	This class will return the sql query
        ''                           for the Query ID passed to it
        '' Description			:	same as above
        ''                           
        '' Assumptions			:	None
        '' Dependencies			:	cRoleLevelAccessFilter
        '' Author				:	Rajanikant
        '' Created				:	Spetember 06,2003
        '' Revisions				:	
        ''=====================================================================
        'Private m_lngQueryID As Long
        'Private m_intEntityID As Long
        'Private m_blnUseSQL As Boolean

        'Public Property QueryID() As Long
        '    Get
        '        QueryID = m_lngQueryID
        '    End Get
        '    Set(ByVal Value As Long)
        '        m_lngQueryID = Value
        '    End Set
        'End Property

        'Public Property EntityID() As Long
        '    Get
        '        EntityID = m_intEntityID
        '    End Get
        '    Set(ByVal Value As Long)
        '        m_intEntityID = Value
        '    End Set
        'End Property

        'Public Property UseSQL() As Boolean
        '    Get
        '        UseSQL = m_blnUseSQL
        '    End Get
        '    Set(ByVal Value As Boolean)
        '        m_blnUseSQL = Value
        '    End Set
        'End Property

        'Sub New()
        'End Sub

        Sub New(ByVal UserName As String, ByVal RoleID As Long, ByVal UserID As Long, _
                ByVal LoginType As String, ByVal RoleLevel As Integer, Optional ByVal IsCustomerCreated As Boolean = False)
            MyBase.UserName = UserName
            MyBase.RoleID = RoleID
            MyBase.UserID = UserID
            MyBase.LoginType = LoginType
            MyBase.RoleLevel = RoleLevel
            MyBase.IsCustomerCreated = IsCustomerCreated
        End Sub

        'Public Function BuildQuery(Optional ByVal SELECTClause As String = "", _
        '                           Optional ByVal WHEREClause As String = "", _
        '                           Optional ByVal UIWHEREClause As String = "", _
        '                           Optional ByVal ORDERBYClause As String = "", _
        '                           Optional ByVal GROUPBYClause As String = "", _
        '                           Optional ByVal SelectAll As Boolean = False _
        '                           ) As String
        '    '=====================================================================
        '    ' Procedure Name        : BuildQuery
        '    ' Description           :   This PUBLIC method will build the complete Query
        '    '                           for the Query ID passed
        '    ' Purpose               : Same as above
        '    ' Parameters Passed     : [Select clause],[Where clause],[UI where clause]
        '    '                         [Order By clause],[Group by clause]  
        '    ' Returns               : Return the Query built as string
        '    ' Parameters Affected   : None
        '    ' Assumptions           : 
        '    ' Dependencies          : cRoleLevelAccessFilter, Global class
        '    ' Author                : Rajanikant
        '    ' Created               : Saturday September 06,2003
        '    ' Revisions             :
        '    '=====================================================================
        '    Dim DR As IDataReader
        '    Dim strSQL As String
        '    Dim strExtendedWhereClause As String
        '    Dim strWhereClause As String
        '    Dim strRoleAccessFilter As String
        '    Dim arr() As String
        '    Dim sbQuery As System.Text.StringBuilder
        '    Dim lngEntityID As Long = 0

        '    strSQL = "usp_Sel_tbl_QRB_Query_Master " + m_lngQueryID.ToString.Trim
        '    DR = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)

        '    If DR.Read() Then
        '        sbQuery = New System.Text.StringBuilder("")
        '        lngEntityID = CType(DR("EntityID"), Long)

        '        ' select
        '        sbQuery.Append(" SELECT ")
        '        If SELECTClause.Trim = "" Then
        '            If SelectAll Then
        '                ' select all attributes
        '                sbQuery.Append(" * ")
        '            Else
        '                sbQuery.Append(DR("SelectClause").ToString)
        '            End If
        '        Else
        '            sbQuery.Append(SELECTClause)
        '        End If


        '        ' from
        '        sbQuery.Append(" FROM ")
        '        sbQuery.Append(DR("EntityName").ToString)


        '        ' where
        '        sbQuery.Append(" WHERE 1=1 ")

        '        If Trim(DR("WhereClause").ToString & "") <> "" Then
        '            If Trim(WHEREClause & "") = "" Then

        '                strWhereClause = BuildWhereClause(DR("WhereClause").ToString, UIWHEREClause)
        '                If Trim(strWhereClause & "") <> "" Then
        '                    sbQuery.Append(" AND ")
        '                    sbQuery.Append(strWhereClause)
        '                End If

        '                ' Extended where
        '                strExtendedWhereClause = DR("ExtendedWhereClause").ToString
        '                If Trim(strExtendedWhereClause & "") <> "" Then
        '                    sbQuery.Append(" ")
        '                    arr = Split(Trim(strExtendedWhereClause & ""), " ")
        '                    If arr(0).Trim.ToUpper = "AND" Or arr(0).Trim.ToUpper = "OR" Then
        '                        sbQuery.Append(strExtendedWhereClause)
        '                    Else
        '                        sbQuery.Append(" AND ")
        '                        sbQuery.Append(strExtendedWhereClause)
        '                    End If
        '                End If
        '            Else
        '                strWhereClause = BuildWhereClause(WHEREClause, UIWHEREClause)
        '                If Trim(strWhereClause & "") <> "" Then
        '                    sbQuery.Append(" AND ")
        '                    sbQuery.Append(strWhereClause)
        '                End If
        '            End If
        '        Else
        '            strWhereClause = BuildWhereClause(WHEREClause, UIWHEREClause)
        '            If Trim(strWhereClause & "") <> "" Then
        '                sbQuery.Append(" AND ")
        '                sbQuery.Append(strWhereClause)
        '            End If
        '        End If

        '        ' role level accessa applies only to role levels 2 & 3
        '        If MyBase.RoleLevel <> 1 Then
        '            ' get the access filters
        '            strRoleAccessFilter = WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(m_blnUseSQL, lngEntityID, strWhereClause)
        '            If strRoleAccessFilter <> "" Then
        '                sbQuery.Append(" AND ")
        '                sbQuery.Append(strRoleAccessFilter)
        '            End If
        '        End If


        '        ' group by
        '        If GROUPBYClause.Trim = "" Then
        '            If DR("GroupByClause").ToString.Trim <> "" Then
        '                sbQuery.Append(" GROUP BY ")
        '                sbQuery.Append(DR("GroupByClause").ToString)
        '            End If
        '        Else
        '            sbQuery.Append(" GROUP BY ")
        '            sbQuery.Append(GROUPBYClause.ToString)
        '        End If


        '        ' order by 
        '        If ORDERBYClause.Trim = "" Then
        '            If DR("OrderByClause").ToString.Trim <> "" Then
        '                sbQuery.Append(" ORDER BY ")
        '                sbQuery.Append(DR("OrderByClause").ToString)
        '            End If
        '        Else
        '            sbQuery.Append(" ORDER BY ")
        '            sbQuery.Append(ORDERBYClause.ToString)
        '        End If


        '        ' return the built SQL string
        '        Return CommonFunctions.General.ReplacePlaceHolders(Replace(Replace(Replace(sbQuery.ToString.Trim, "@COMMA@", ","), "[[", "["), "]]", "]"))
        '    Else
        '        ' no entry was found in the data base return empty string
        '        Return ""
        '    End If

        'End Function


        'Public Shared Function BuildWhereClause(ByVal WhereClause As String, ByVal UIWhereClause As String) As String
        '    '=====================================================================
        '    ' Procedure Name        : BuildWhereClause()
        '    ' Description           :
        '    ' Purpose               : to Buil the where clause
        '    ' Parameters Passed     : WhereClause,UIWhereClause
        '    ' Returns               :
        '    ' Parameters Affected   : 
        '    ' Assumptions           :
        '    ' Dependencies          : tables/Sps in database
        '    ' Author                : Rajanikant
        '    ' Created               : September 06,2003
        '    ' Revisions             :
        '    '=====================================================================
        '    Dim dr As SqlDataReader
        '    Dim Where As String
        '    Dim UIWhere As String
        '    Dim arr() As String
        '    Dim arrUIElements() As String
        '    Dim iLoopCount As Integer
        '    Dim iLoopCtr As Integer
        '    Dim sTempWhere As String

        '    ' **Since there can be "," in the value passed we have to remove it
        '    ' before splitting on ","'UIWhereClause = Replace(UIWhereClause & "","," ,"$@$")
        '    ' the UIwhereclause comes in this format with $@$ as the replacement of ","(comma)
        '    ' so after operations on the query components we replace this value by ","
        '    arrUIElements = Split(UIWhereClause & "", ",")

        '    If Trim(WhereClause & "") <> "" Then

        '        ' Putting the spaces
        '        WhereClause = Replace(WhereClause, "/*", " /*")
        '        WhereClause = Replace(WhereClause, "*\", "*\ ")
        '        WhereClause = Replace(WhereClause, "@", " @")

        '        ' splitting on space
        '        arr = Split(WhereClause, Chr(32))
        '        sTempWhere = ""
        '        For iLoopCount = 0 To UBound(arr)
        '            If Trim(arr(iLoopCount) & "") <> "" Then

        '                If Left(Trim(arr(iLoopCount) & ""), 1) = "@" Then
        '                    ' in Case Of Strings there can be spaces withing the value
        '                    ' **Checking it
        '                    If Left(Trim(arr(iLoopCount) & ""), 2) = "@'" Then

        '                        If Right(Trim(arr(iLoopCount) & ""), 1) <> "'" Then
        '                            For iLoopCtr = iLoopCount To UBound(arr)

        '                                If Right(Trim(arr(iLoopCtr) & ""), 1) = "'" Then
        '                                    iLoopCount = iLoopCtr
        '                                    Exit For
        '                                End If
        '                            Next
        '                        End If
        '                    End If

        '                    ' Dynamic field
        '                    sTempWhere = sTempWhere & " "
        '                Else
        '                    '	To handle subscript out of range error
        '                    If iLoopCount >= 1 Then
        '                        '	To handle IS NOT, NOT LIKE in UI operators
        '                        If UCase(Trim(arr(iLoopCount) & "")) = "LIKE" And UCase(Trim(arr(iLoopCount - 1) & "")) = "@NOT" Then
        '                            sTempWhere = sTempWhere & " "
        '                        ElseIf UCase(Trim(arr(iLoopCount) & "")) = "NOT" And UCase(Trim(arr(iLoopCount - 1) & "")) = "@IS" Then
        '                            sTempWhere = sTempWhere & " "
        '                        Else
        '                            sTempWhere = " " & sTempWhere & " " & arr(iLoopCount)
        '                        End If
        '                    Else
        '                        sTempWhere = " " & sTempWhere & " " & arr(iLoopCount)
        '                    End If

        '                End If
        '            End If
        '        Next

        '        ' Now we have the where clause with field-values to be replaced with dynamic values
        '        ' splitting on 
        '        arr = Split(sTempWhere, "#")
        '        For iLoopCount = 0 To UBound(arr)
        '            If iLoopCount <= UBound(arrUIElements) Then
        '                Where = Where & " " & arr(iLoopCount) & arrUIElements(iLoopCount)
        '            Else
        '                Where = Where & " " & arr(iLoopCount)
        '            End If
        '        Next

        '        Where = Replace(Where & "", "/*", Chr(32))
        '        Where = Replace(Where & "", "*/", Chr(32))
        '        Where = Replace(Where & "", "$@$", ",")

        '    Else
        '        ' Sending the same value back 
        '        Where = Replace(WhereClause & "", "$@$", ",")
        '    End If

        '    ' returning the where clause
        '    Return Where

        'End Function


    End Class

    Public Class WAFConnections

        Public Shared Function GetConnectionString(ByVal lngConnectionID As Long, ByRef IsOracle As Boolean) As String
            '-------------------------------------------------------------------------------------------------------------
            ' Method                : GetConnectionString()	
            ' Requirement Tag       : Requirement ID. - WAF3_GEN_8
            ' Description           : To get the connection info. for conn. id.
            ' Parameters Passed     : Connection ID, IsOracle (passed ByRef)
            ' Returns               : Connection String associated with the connection id
            ' Parameters Affected   : IsOracle
            ' Assumptions           : Connection Master is cached.
            ' Dependencies          : - tbl_QRB_Connection_Master and Whiz.WebForms.Caching.dll
            ' Author                : PushkarK
            ' Created On            : Thursday, November 09, 2006
            ' Revisions             : 
            '-------------------------------------------------------------------------------------------------------------

            Dim htConnectionMaster As CommonEngines.HashTables.ConnectionMaster

            Try

                If lngConnectionID <> 0 Then
                    htConnectionMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableConnectionMasterObject(lngConnectionID)
                    If htConnectionMaster.DatabaseType.ToString.Trim.ToUpper = "S" Then
                        IsOracle = False
                    Else
                        IsOracle = True
                    End If
                    If Not htConnectionMaster.ConnectionString Is Nothing Then
                        GetConnectionString = htConnectionMaster.ConnectionString()
                    Else
                        GetConnectionString = CommonFunctions.General.GetConnectionString()
                        IsOracle = Not CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"), Boolean)
                    End If
                    htConnectionMaster = Nothing
                Else
                    GetConnectionString = CommonFunctions.General.GetConnectionString()
                    IsOracle = Not CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"), Boolean)
                End If

            Catch ex As Exception
                htConnectionMaster = Nothing
                GetConnectionString = CommonFunctions.General.GetConnectionString()
                IsOracle = Not CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"), Boolean)
            End Try

        End Function

        Public Shared Function GetConnectionID(Optional ByVal EntityID As Long = 0, Optional ByVal QueryID As Long = 0, Optional ByVal UseSQL As Boolean = True) As Long
            '=====================================================================
            ' Procedure Name        : GetConnectionID()	
            ' Description           : To get the connection info. for conn. id.
            ' Purpose               : To get the connection info. for conn. id.
            ' Parameters Passed     : (either) Entity ID, (or) Query ID, UseSQL (true/false)
            ' Returns               : connection ID
            ' Parameters Affected   : 
            ' Assumptions           : 
            ' Dependencies          : usp_QRB_GetConnectionID, usp_QRB_GetConnectionID_ForQuerys
            ' Author                : Rajanikant
            ' Created               : Nov 07,2003
            ' Revisions             :
            '=====================================================================
            Dim dr As IDataReader
            If QueryID = 0 Then
                dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID " & EntityID, UseSQL)
                If dr.Read Then
                    If Not IsDBNull(dr("ConnectionID")) Then
                        GetConnectionID = CType(dr("ConnectionID"), Long)
                    Else
                        GetConnectionID = 0
                    End If
                Else
                    GetConnectionID = 0
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
            Else
                dr = CommonFunctions.Data.GetDataReader("usp_QRB_GetConnectionID_ForQuery " & QueryID, UseSQL)
                If dr.Read Then
                    If Not IsDBNull(dr("ConnectionID")) Then
                        GetConnectionID = CType(dr("ConnectionID"), Long)
                    Else
                        GetConnectionID = 0
                    End If
                Else
                    GetConnectionID = 0
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
            End If

        End Function

    End Class

End Namespace
