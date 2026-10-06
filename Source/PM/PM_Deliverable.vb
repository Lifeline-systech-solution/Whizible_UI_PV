Imports CommonFunctions


Namespace CommonEngine
    Namespace HashTables

        Module DeliverableHashTable
            'hash table variable for Deliverable field config table (tbl_CNF_ScheduleFieldConfig)
            Public m_ht_DeliverableFields As New System.Collections.Hashtable
        End Module


        '=====================================================================
        ' Class	Name	    :	DeliverableField
        ' Purpose			:	This class is implementation of deliverable field configuration table
        '                       for Hash table of deliverable fields
        ' Description		:	
        ' Assumptions		:	None
        ' Dependencies		:	None
        ' Author			:	SachinR
        ' Created			:	01 Nov 2004
        ' Revisions			:	
        '=====================================================================
        Public Class DeliverableField

            Private m_lngDeliverableTypeID As Long
            Private m_strFieldName As String
            Private m_strLabel As String
            Private m_blnApplicable As Boolean
            Private m_blnMandatory As Boolean

            Public Property DeliverableTypeID() As Long
                Get
                    DeliverableTypeID = m_lngDeliverableTypeID
                End Get
                Set(ByVal Value As Long)
                    m_lngDeliverableTypeID = Value
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
        ' Class	Name	        :	Deliverable
        ' Purpose				:	This class has methods to create and retrieve the hash table for the 
        '                           DeliverableField class.
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	SachinR
        ' Created				:	01 Nov 2004
        ' Revisions				:	
        '=====================================================================
        Public Class Deliverable

            '============================================================================
            'Procedure Name		: CreateDeliverableHashTable
            'Description		: Procedure to create the hash table for Deliverable fields 
            '                     configuration
            'Parameters         : DeliverableID
            '                     
            'Return Values		: None
            'Author				: SachinR
            'Created			: 01 Nov 2004
            '============================================================================
            Public Shared Sub CreateDeliverableHashTable(Optional ByVal lngDeliverableTypeID As Long = 0)
                Dim objDrDeliverableType As IDataReader
                Dim dsDeliverableField As DataSet
                Dim rwDeliverableField As DataRow
                Dim strSQL As String
                Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                Dim intIndex As Integer

                Try

                    'if deliverable id is given then get data for that deliverable only else get data
                    'for all the deliverable fields
                    strSQL = "usp_Sel_tbl_PM_CompanySchedules_HashTable "
                    If lngDeliverableTypeID > 0 Then
                        strSQL += lngDeliverableTypeID.ToString
                    Else
                        'when full hashtable is to be created then first clear previous elements, if any
                        m_ht_DeliverableFields.Clear()
                    End If


                    objDrDeliverableType = CommonFunction.Data.GetDataReader(strSQL, blnUseSQL)

                    While objDrDeliverableType.Read

                        lngDeliverableTypeID = CType(CommonFunction.Data.CheckIsDBNull(objDrDeliverableType("ScheduleID"), "0"), Long)

                        dsDeliverableField = New DataSet
                        strSQL = "usp_Sel_tbl_CNF_ScheduleFieldConfig_HashTable " + lngDeliverableTypeID.ToString
                        dsDeliverableField = CommonFunction.Data.GetDataSet(strSQL, "DeliverableFields", , , blnUseSQL)

                        If dsDeliverableField.Tables("DeliverableFields").Rows.Count > 0 Then

                            intIndex = 0
                            Dim objAryDeliverableField(dsDeliverableField.Tables("DeliverableFields").Rows.Count - 1) As DeliverableField

                            For Each rwDeliverableField In dsDeliverableField.Tables("DeliverableFields").Rows

                                Dim objDeliverableField As New DeliverableField

                                objDeliverableField.DeliverableTypeID = CType(CommonFunction.Data.CheckIsDBNull(rwDeliverableField("ScheduleTypeID"), "0"), Long)
                                objDeliverableField.FieldName = CommonFunction.Data.CheckIsDBNull(rwDeliverableField("FieldName"), "").ToString
                                objDeliverableField.Label = CommonFunction.Data.CheckIsDBNull(rwDeliverableField("Label"), "").ToString
                                objDeliverableField.Applicable = CType(CommonFunction.Data.CheckIsDBNull(rwDeliverableField("Applicable"), "0"), Boolean)
                                objDeliverableField.Mandatory = CType(CommonFunction.Data.CheckIsDBNull(rwDeliverableField("Mandatory"), "0"), Boolean)

                                objAryDeliverableField(intIndex) = objDeliverableField
                                objDeliverableField = Nothing
                                intIndex += 1
                            Next
                            rwDeliverableField = Nothing

                            If m_ht_DeliverableFields.ContainsKey(lngDeliverableTypeID) = False Then
                                m_ht_DeliverableFields.Add(lngDeliverableTypeID, objAryDeliverableField)
                            Else
                                m_ht_DeliverableFields.Item(lngDeliverableTypeID) = objAryDeliverableField
                            End If

                            objAryDeliverableField = Nothing
                        End If
                        dsDeliverableField.Dispose()
                        dsDeliverableField = Nothing

                    End While
                    CommonFunction.Data.DisposeDataReader(objDrDeliverableType)


                Catch ex As Exception
                    Err.Raise(Err.Number, "CreateDeliverableHashTable", ex.Message)
                End Try
            End Sub

            '============================================================================
            'Procedure Name		: GetHashTableDeliverableObject
            'Description		: Procedure to get the object of the given deliverable ID from 
            '                     the hash table 
            'Parameters         : DeliverableID
            '                     
            'Return Values		: None
            'Author				: SachinR
            'Created			: 01 Nov 2004
            '============================================================================
            Public Shared Function GetHashTableDeliverableObject(ByVal Key As Long) As DeliverableField()

                Try
                    Return DirectCast(m_ht_DeliverableFields.Item(Key), DeliverableField())
                Catch ex As Exception
                    Err.Raise(Err.Number, "GetHashTableDeliverableObject", ex.Message)
                End Try
            End Function


            '============================================================================
            'Procedure Name		: GetHashTableDeliverableFieldObject
            'Description		: Procedure to get the object of the given deliverable ID from 
            '                     the hash table 
            'Parameters         : DeliverableID
            '                     
            'Return Values		: None
            'Author				: SachinR
            'Created			: 01 Nov 2004
            '============================================================================
            Public Shared Function GetHashTableDeliverableFieldObject(ByVal Key As Long, ByVal strFieldName As String) As DeliverableField

                Try
                    Dim objDeliverableField As DeliverableField
                    Dim blnMatchFound As Boolean = False
                    Dim objAryDeliverableFields() As DeliverableField

                    objAryDeliverableFields = GetHashTableDeliverableObject(Key)
                    If Not objAryDeliverableFields Is Nothing Then

                        For Each objDeliverableField In objAryDeliverableFields
                            If UCase(objDeliverableField.FieldName) = UCase(strFieldName) Then
                                blnMatchFound = True
                                Exit For
                            End If
                        Next
                    End If
                    objAryDeliverableFields = Nothing

                    If blnMatchFound Then
                        Return DirectCast(objDeliverableField, DeliverableField)
                    Else
                        Return Nothing
                    End If

                Catch ex As Exception
                    Err.Raise(Err.Number, "GetHashTableDeliverableFieldObject", ex.Message)
                End Try
            End Function

            '============================================================================
            'Procedure Name		: ClearHashTable
            'Description		: Procedure release the memory allocated for the hashtable 
            '                     of the deliverable field class
            'Parameters         : None
            '                     
            'Return Values		: None
            'Author				: SachinR
            'Created			: 01 Nov 2004
            '============================================================================
            Public Shared Sub ClearHashTable()
                Try
                    m_ht_DeliverableFields.Clear()
                Catch ex As Exception
                    Err.Raise(Err.Number, "ClearHashTable", ex.Message)
                End Try
            End Sub

            '============================================================================
            'Procedure Name		: RemoveHashTableDeliverableObject
            'Description		: Procedure remove deliverable object from the hashtable for the 
            '                     given deliverable ID to release the memory allocated 
            'Parameters         : None
            '                     
            'Return Values		: None
            'Author				: SachinR
            'Created			: 02 Nov 2004
            '============================================================================
            Public Shared Sub RemoveHashTableDeliverableObject(ByVal lngDeliverableTypeID As Long)

                Try
                    m_ht_DeliverableFields.Remove(lngDeliverableTypeID)
                Catch ex As Exception
                    Err.Raise(Err.Number, "RemoveHashTableDeliverableObject", ex.Message)
                End Try
            End Sub

        End Class

    End Namespace
End Namespace
