Imports CommonFunctions


Namespace CommonEngine
    Namespace HashTables

        Module ProjectInfoHashTable
            'hash table variable for Project fields 
            Public m_ht_ProjectInfoFields As New System.Collections.Hashtable
        End Module


        '=====================================================================
        ' Class	Name	    :	ProjectInfoFields
        ' Purpose			:	This class is implementation for Hash table of project information fields
        ' Description		:	
        ' Assumptions		:	None
        ' Dependencies		:	None
        ' Author			:	PradipK
        ' Created			:	26 May 2006
        ' Revisions			:	
        '=====================================================================
        Public Class ProjectInfoField

            Private m_lngTypeID As Long
            Private m_strFieldName As String
            Private m_strLabel As String
            Private m_blnApplicable As Boolean
            Private m_blnMandatory As Boolean


            Public Property TypeID() As Long
                Get
                    TypeID = m_lngTypeID
                End Get
                Set(ByVal Value As Long)
                    m_lngTypeID = Value
                End Set
            End Property

            Public Property FieldName() As String
                Get
                    FieldName = m_strFieldName
                End Get
                Set(ByVal Value As String)
                    m_strFieldName = Value
                End Set
            End Property
            Public Property Label() As String
                Get
                    Label = m_strLabel
                End Get
                Set(ByVal Value As String)
                    m_strLabel = Value
                End Set
            End Property
            Public Property Applicable() As Boolean
                Get
                    Applicable = m_blnApplicable
                End Get
                Set(ByVal Value As Boolean)
                    m_blnApplicable = Value
                End Set
            End Property
            Public Property Mandatory() As Boolean
                Get
                    Mandatory = m_blnMandatory
                End Get
                Set(ByVal Value As Boolean)
                    m_blnMandatory = Value
                End Set
            End Property
        End Class


        '=====================================================================
        ' Class	Name	        :	ProjectInfo
        ' Purpose				:	This class has methods to create and retrieve the hash table for the 
        '                           ProjectInfoField class.
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	PradipK
        ' Created				:	26 May 2006
        ' Revisions				:	
        '=====================================================================
        Public Class ProjectInfo

            '============================================================================
            'Procedure Name		: CreateProjectInfoHashTable
            'Description		: Procedure to create the hash table for Project Information fields 
            'Parameters         : TypeID
            '                     
            'Return Values		: None
            'Author				: PradipK
            'Created			: 10 Mar 2006
            '============================================================================
            Public Shared Sub CreateProjectInfoHashTable(Optional ByVal lngTypeID As Long = 0)
                Dim objDrProjectInfo As IDataReader
                Dim dsProjectInfoField As DataSet
                Dim rwProjectInfoField As DataRow
                Dim strSQL As String
                Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                Dim intIndex As Integer

                Try

                    'if role id is given then get data for that role only else get data
                    'for all the roles
                    strSQL = "usp_Sel_tbl_PRS_ProjectTypes_HashTable "
                    If lngTypeID > 0 Then
                        strSQL += lngTypeID.ToString
                    Else
                        'when full hashtable is to be created then first clear previous elements, if any
                        m_ht_ProjectInfoFields.Clear()
                    End If

                    objDrProjectInfo = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)

                    While objDrProjectInfo.Read
                        lngTypeID = CType(CommonFunction.Data.CheckIsDBNull(objDrProjectInfo("TypeID"), "0"), Long)

                        'get project fields data for given role
                        dsProjectInfoField = New DataSet
                        strSQL = "usp_Sel_tbl_PRS_ProjectTypeFieldConfig_HashTable " + lngTypeID.ToString

                        dsProjectInfoField = CommonFunction.Data.GetDataSet(strSQL, "ProjectInfoFields", , , blnUseSQL)
                        If dsProjectInfoField.Tables("ProjectInfoFields").Rows.Count > 0 Then

                            intIndex = 0
                            Dim objAryProjectInfoField(dsProjectInfoField.Tables("ProjectInfoFields").Rows.Count - 1) As ProjectInfoField

                            For Each rwProjectInfoField In dsProjectInfoField.Tables("ProjectInfoFields").Rows
                                Dim objProjectField As New ProjectInfoField

                                objProjectField.TypeID = lngTypeID
                                objProjectField.FieldName = CommonFunction.Data.CheckIsDBNull(rwProjectInfoField("FieldName"), "").ToString
                                objProjectField.Label = CommonFunction.Data.CheckIsDBNull(rwProjectInfoField("Label"), "").ToString
                                objProjectField.Applicable = CType(CommonFunction.Data.CheckIsDBNull(rwProjectInfoField("Applicable"), "0"), Boolean)
                                objProjectField.Mandatory = CType(CommonFunction.Data.CheckIsDBNull(rwProjectInfoField("Mandatory"), "0"), Boolean)

                                objAryProjectInfoField(intIndex) = objProjectField
                                intIndex += 1
                            Next
                            rwProjectInfoField = Nothing

                            If m_ht_ProjectInfoFields.ContainsKey(lngTypeID) = False Then
                                m_ht_ProjectInfoFields.Add(lngTypeID, objAryProjectInfoField)
                            Else
                                m_ht_ProjectInfoFields.Item(lngTypeID) = objAryProjectInfoField
                            End If
                            objAryProjectInfoField = Nothing
                        End If
                        dsProjectInfoField.Dispose()
                        dsProjectInfoField = Nothing
                    End While
                    CommonFunction.Data.DisposeDataReader(objDrProjectInfo)

                Catch ex As Exception
                    Err.Raise(Err.Number, "CreateProjectInfoHashTable", ex.Message)
                End Try
            End Sub

            '============================================================================
            'Procedure Name		: GetHashTableProjectInfoObject
            'Description		: Procedure to get the object of the given FieldName from 
            '                     the hash table 
            'Parameters         : FieldName
            '                     
            'Return Values		: None
            'Author				: PradipK
            'Created			: 26 May 2006
            '============================================================================
            Public Shared Function GetHashTableProjectInfoObject(ByVal Key As Long) As ProjectInfoField()

                Try
                    Return DirectCast(m_ht_ProjectInfoFields.Item(Key), ProjectInfoField())
                Catch ex As Exception
                    Err.Raise(Err.Number, "GetHashTableProjectInfoObject", ex.Message)
                End Try

            End Function


            '============================================================================
            'Procedure Name		: GetHashTableProjectInfoFieldObject
            'Description		: Procedure to get the object of the given Role ID from 
            '                     the hash table 
            'Parameters         : TypeID
            '                     FieldName                        
            'Return Values		: None
            'Author				: PradipK
            'Created			: 26 May 2006
            '============================================================================
            Public Shared Function GetHashTableProjectInfoFieldObject(ByVal Key As Long, ByVal strFieldName As String) As ProjectInfoField

                Try
                    Dim objProjectInfoField As ProjectInfoField
                    Dim blnMatchFound As Boolean = False
                    Dim objAryProjectInfoFields() As ProjectInfoField

                    objAryProjectInfoFields = GetHashTableProjectInfoObject(Key)
                    If Not objAryProjectInfoFields Is Nothing Then

                        For Each objProjectInfoField In objAryProjectInfoFields
                            If UCase(objProjectInfoField.FieldName) = UCase(strFieldName) Then
                                blnMatchFound = True
                                Exit For
                            End If
                        Next
                    End If
                    objAryProjectInfoFields = Nothing

                    If blnMatchFound Then
                        Return DirectCast(objProjectInfoField, ProjectInfoField)
                    Else
                        Return Nothing
                    End If

                Catch ex As Exception
                    Err.Raise(Err.Number, "GetHashTableProjectFieldObject", ex.Message)
                End Try
            End Function


            '============================================================================
            'Procedure Name		: ClearHashTable
            'Description		: Procedure release the memory allocated for the hashtable 
            '                     of the projectinfo field class
            'Parameters         : None
            '                     
            'Return Values		: None
            'Author				: PradipK
            'Created			: 26 May 2006
            '============================================================================
            Public Shared Sub ClearHashTable()
                Try
                    m_ht_ProjectInfoFields.Clear()
                Catch ex As Exception
                    Err.Raise(Err.Number, "ClearHashTable", ex.Message)
                End Try
            End Sub

            '============================================================================
            'Procedure Name		: RemoveHashTableDeliverableObject
            'Description		: Procedure remove Project Info object from the hashtable for the 
            '                     given role to release the memory allocated 
            'Parameters         : None
            '                     
            'Return Values		: None
            'Author				: PradipK
            'Created			: 10 Mar 2006
            '============================================================================
            Public Shared Sub RemoveHashTableProjectInfoObject(ByVal lngRoleID As Long)

                Try
                    m_ht_ProjectInfoFields.Remove(lngRoleID)
                Catch ex As Exception
                    Err.Raise(Err.Number, "RemoveHashTableProjectInfoObject", ex.Message)
                End Try
            End Sub

        End Class

    End Namespace
End Namespace
