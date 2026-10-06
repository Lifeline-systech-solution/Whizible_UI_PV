Imports CommonFunctions
'=====================================================================
' Class	Name	        :	HTMLTable
' Purpose				:   HTML Table For DashBoard creation
' Description			:	
' Assumptions			:	None
' Dependencies			:	None
' Author				:	Padmnabh Anturkar
' Created				:	December 13 , 2005
' Revisions				:	
'=====================================================================
Public Class HTMLTable

#Region "Private Variables"
    Dim strSQLQuery As String                   'Sql query 
    Dim strConnection As String                 'Connection string
    Dim strTitle As String                      'Title for the table 
    Dim strDivID As String                      'Identity column
    Dim strUniqueIDField As String              'UniqueID
    Dim strLinkField As String                  'Link field
    Dim strLinkUrl As String                    'Link Url
    Dim strGroupByField As String               'Group field
    Dim blnShowIndicatorForTR As Boolean
    Dim strIndicatorColor As String
#End Region

#Region "Properties"
    Property SqlQuery() As String
        Get
            Return strSQLQuery
        End Get
        Set(ByVal Value As String)
            strSQLQuery = Value
        End Set
    End Property
    Property Title() As String
        Get
            Return strTitle
        End Get
        Set(ByVal Value As String)
            strTitle = Value
        End Set
    End Property
    Property GroupBy() As String
        Get
            Return strGroupByField
        End Get
        Set(ByVal Value As String)
            strGroupByField = Value
        End Set
    End Property
    Property LinkField() As String
        Get
            Return strLinkField
        End Get
        Set(ByVal Value As String)
            strLinkField = Value
        End Set
    End Property
    Property LinkUrl() As String
        Get
            Return strLinkUrl
        End Get
        Set(ByVal Value As String)
            strLinkUrl = Value
        End Set
    End Property
    Property UniqueIDField() As String
        Get
            Return strUniqueIDField
        End Get
        Set(ByVal Value As String)
            strUniqueIDField = Value
        End Set
    End Property
    Property ConnectionString() As String
        Get
            Return strConnection
        End Get
        Set(ByVal Value As String)
            strConnection = CommonFunctions.Application.ConnectionString
        End Set
    End Property
    Property DivName() As String
        Get
            Return strDivID
        End Get
        Set(ByVal Value As String)
            strDivID = Value
        End Set
    End Property
#End Region

#Region "Constructor"
    Public Sub New(ByVal SQLQuery As String, ByVal Title As String, ByVal DivName As String, ByVal UniqueIDField As String, ByVal LinkField As String, ByVal LinkUrl As String, ByVal GroupByField As String)
        strSQLQuery = SQLQuery
        strTitle = Title
        strGroupByField = GroupByField
        strLinkField = LinkField
        strLinkUrl = LinkUrl
        strUniqueIDField = UniqueIDField
        strDivID = DivName
        strConnection = CommonFunctions.Application.ConnectionString()
    End Sub
    Public Sub New(ByVal SQLQuery As String, ByVal Title As String, ByVal DivName As String, ByVal UniqueIDField As String, ByVal LinkField As String, ByVal LinkUrl As String)
        strSQLQuery = SQLQuery
        strTitle = Title
        strDivID = DivName
        strLinkField = LinkField
        strLinkUrl = LinkUrl
        strUniqueIDField = UniqueIDField
        strConnection = CommonFunctions.Application.ConnectionString()
    End Sub
    Public Sub New(ByVal SQLQuery As String, ByVal Title As String, ByVal DivName As String, ByVal UniqueIDField As String, ByVal GroupByField As String)
        strSQLQuery = SQLQuery
        strTitle = Title
        strDivID = DivName
        strUniqueIDField = UniqueIDField
        strGroupByField = GroupByField
        strConnection = CommonFunctions.Application.ConnectionString()
    End Sub
    Public Sub New(ByVal SQLQuery As String, ByVal Title As String, ByVal DivName As String, ByVal UniqueIDField As String)
        strSQLQuery = SQLQuery
        strTitle = Title
        strDivID = DivName
        strUniqueIDField = UniqueIDField
        strConnection = CommonFunctions.Application.ConnectionString()
    End Sub
#End Region

#Region "Functions and Procedures"

    Public Function DrawTable() As String
        '====================================================================
        ' Procedure Name        :   GenerateHTML
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   This procedure generates the HTML table and its client side script
        ' Description           :   The Html table generated using this function will have following features
        '                               1.  Depending on the data type of the TD alignment is decided
        '                               2.  Unique identity column will not be displayed on the page.
        '                               3.  If any field is of bit type, then checkboxes will be displayed
        '                                   for that field.
        '                               4.  The name of the function called on click of the link field is "LinkField_OnClick(strUniqueID)".
        '                                   The strUniqueID and Div id are parameters 
        '                               5.  
        ' Assumptions           :       1.  The stored procedure must return the field names as the
        '                               column headers to be displayed.
        '                               2.  The field values must be returned in the format they need
        '                               to be displayed. The stored procedure must take care of it.
        '                               3.  Only the columns to be displayed should be returned by the
        '                               stored procedure. All fields, except the "strUniqueField" will
        '                               be displayed.
        ' Dependencies          : 
        ' Author                :   Padmnabh Anturkar
        ' Created               :   December, 13 2005
        ' Revisions             :
        '=====================================================================
        Dim strHTML As String           'Html to be returned
        Dim strValue As String
        Dim intFieldCount As Integer    'Count of columns returned by the database procedure
        Dim intDisplayColumnsCount As Integer
        Dim intLoopCounter As Integer   'loop variable
        Dim intLoopCounter2 As Integer  'loop variable
        Dim intTRCounter As Integer

        Dim strTRClass As String        'TR Class (TREven/TROdd)
        Dim strAlign As String          'Alignment depending on the data type
        Dim strGroupByFieldValue As String

        Dim drHTMLdata As IDataReader
        Dim HtmlTable As System.Web.UI.HtmlControls.HtmlTable

        drHTMLdata = CommonFunctions.Data.GetDataReader(strSQLQuery, True, strConnection)

        intFieldCount = drHTMLdata.FieldCount()
        If strGroupByField = "" Then
            intDisplayColumnsCount = intFieldCount - 3
        Else
            intDisplayColumnsCount = intFieldCount - 4
        End If

        '=============================================================================================
        'HTML string generation block
        '=============================================================================================
        strHTML = strHTML & " <TABLE CLASS = 'clsGridTable' WIDTH='99.9%' cellSpacing='1' cellPadding='0'>"
        strHTML = strHTML & " <TR ID = '" & Trim(strDivID) & "' CLASS='clsTROdd' VALIGN='top'>"
        If strGroupByField = "" Then
            strHTML = strHTML & " <TD ID='ID" & strTitle & "' COLSPAN= " & intDisplayColumnsCount & " align = 'Center'>" & strTitle & "</TD>"
        Else
            strHTML = strHTML & " <TD ID='ID" & strTitle & "' COLSPAN= " & intDisplayColumnsCount & " align = 'Center'>" & strTitle & "</TD>"
        End If
        strHTML = strHTML & " <TD ALIGN='RIGHT' COLSPAN=0><A HREF = 'javascript:Scroll" & Trim(strDivID) & "()'> <IMG ID=I" & Trim(strDivID) & " SRC='../../Images/down_DB.gif' BORDER='0' ALIGN='right'></A></TD>"
        strHTML = strHTML & " </TR>"

        strHTML = strHTML & " <TR CLASS='clsTRColumnHeader'>"
        For intLoopCounter = 0 To intFieldCount - 1
            'Unique identity column will not be displayed on the page.
            If drHTMLdata.GetName(intLoopCounter).ToUpper <> strUniqueIDField.ToUpper And drHTMLdata.GetName(intLoopCounter).ToUpper <> strGroupByField.ToUpper And drHTMLdata.GetName(intLoopCounter).ToUpper <> "PROJECTID" Then
                strHTML = strHTML & "<TD align='Center' nowrap >" & drHTMLdata.GetName(intLoopCounter) & "</TD>"
            End If
        Next
        strHTML = strHTML & " </TR>"

        intTRCounter = 0
        intLoopCounter = 0
        strGroupByFieldValue = "0"
        While drHTMLdata.Read
            If strGroupByField <> "" Then
                If strGroupByFieldValue = "0" Then
                    strGroupByFieldValue = drHTMLdata.GetValue(drHTMLdata.GetOrdinal(strGroupByField)).ToString()
                    strHTML = strHTML & " <TR ID='" & Trim(strDivID) & intTRCounter & "' CLASS='clsTRSectionHeader'>"
                    strHTML = strHTML & "<TD align='Left' COLSPAN= " & intDisplayColumnsCount + 1 & " >" & strGroupByField & ": " & drHTMLdata.GetValue(drHTMLdata.GetOrdinal(strGroupByField)).ToString & " </TD>"
                    strHTML = strHTML & " </TR>"
                    intTRCounter += 1
                Else
                    If strGroupByFieldValue.ToString.ToUpper <> drHTMLdata.GetValue(drHTMLdata.GetOrdinal(strGroupByField)).ToString.ToUpper Then
                        strGroupByFieldValue = drHTMLdata.GetValue(drHTMLdata.GetOrdinal(strGroupByField)).ToString()
                        strHTML = strHTML & " <TR ID='" & Trim(strDivID) & intTRCounter & "' CLASS='clsTRSectionHeader'>"
                        strHTML = strHTML & "<TD align='Left' COLSPAN= " & intDisplayColumnsCount + 1 & " >" & strGroupByField & ": " & drHTMLdata.GetValue(drHTMLdata.GetOrdinal(strGroupByField)).ToString & " </TD>"
                        strHTML = strHTML & " </TR>"
                        intTRCounter += 1
                    End If
                End If
            End If

            If intLoopCounter Mod 2 = 0 Then
                strTRClass = "clsTREven"
            Else
                strTRClass = "clsTROdd"
            End If
            strHTML = strHTML & "<TR ID='" & Trim(strDivID) & intTRCounter & "'  CLASS='" & strTRClass & "'>"
            intTRCounter += 1
            For intLoopCounter2 = 0 To intFieldCount - 1
                'Unique identity column will not be displayed on the page.
                If drHTMLdata.GetName(intLoopCounter2).ToUpper <> strUniqueIDField.ToUpper And drHTMLdata.GetName(intLoopCounter2).ToUpper <> strGroupByField.ToUpper And drHTMLdata.GetName(intLoopCounter2).ToUpper <> "PROJECTID" Then
                    strValue = drHTMLdata.GetValue(intLoopCounter2).ToString
                    'Depending on the data type the TD alignment is decided
                    Select Case drHTMLdata.GetDataTypeName(intLoopCounter2).ToUpper
                        Case "NVARCHAR", "VARCHAR", "CHAR", "TEXT"
                            strAlign = "LEFT"
                        Case "INT", "NUMERIC", "FLOAT", "DECIMAL", "REAL", "MONEY"
                            strAlign = "RIGHT"
                        Case "BIT", "IMAGE"
                            strAlign = "CENTER"
                        Case "DATETIME", "SMALLDATETIME"
                            strAlign = "LEFT"
                            If (strValue <> "") Then
                                strValue = CommonFunctions.Dates.GetDate(CType(strValue, DateTime))
                            End If
                        Case Else
                            strAlign = "LEFT"
                    End Select
                    If drHTMLdata.GetName(intLoopCounter2).ToUpper = strLinkField.ToUpper Then
                        strHTML = strHTML & "<TD ALIGN=" & strAlign & "><A HREF = 'javascript:" & Trim(strDivID) & "LinkClick(" & drHTMLdata.GetValue(drHTMLdata.GetOrdinal(strUniqueIDField)).ToString & ", " & drHTMLdata.GetValue(drHTMLdata.GetOrdinal("ProjectID")).ToString & ")'>" & strValue & "</A></TD>"
                    Else
                        strHTML = strHTML & "<TD ALIGN=" & strAlign & ">" & drHTMLdata.GetValue(intLoopCounter2).ToString & "</TD>"
                    End If
                End If
            Next
            strHTML = strHTML & "</TR>"
            intLoopCounter += 1
        End While
        '=============================================================================================
        'HTML string generation block complete
        '=============================================================================================
        strHTML = strHTML & "</TABLE>"
        strHTML = strHTML & "<INPUT TYPE='HIDDEN' ID='txtDiv" & strTitle & "' NAME= 'txtDiv" & strTitle & "' VALUE=" & intTRCounter & ">"
        strHTML = strHTML & "<INPUT TYPE='HIDDEN' ID='txtDiv" & strTitle & "Count' NAME= 'txtDiv" & strTitle & "Count' VALUE=" & intLoopCounter & ">" + vbCrLf

        '=============================================================================================
        'client side script generation block
        '=============================================================================================
        strHTML = strHTML & "<Script Language = 'JavaScript'>" + vbCrLf
        strHTML = strHTML & " var int" & Trim(strDivID) & "Count; "
        strHTML = strHTML & " var objTitle; "
        strHTML = strHTML & " objTitle = document.getElementById('ID" & strTitle & "'); "
        strHTML = strHTML & "int" & Trim(strDivID) & "Count = document.forms.item(0).txtDiv" & strTitle & "Count.value; "
        strHTML = strHTML & "objTitle.innerHTML = ' " & strTitle & " (' + int" & Trim(strDivID) & "Count + ')'; "
        strHTML = strHTML & "Scroll" & Trim(strDivID) & "(); "
        strHTML = strHTML & "function Scroll" & Trim(strDivID) & "()"
        strHTML = strHTML & "{ "
        strHTML = strHTML & "   var intRecordCount; "
        strHTML = strHTML & "   var intLoopCounter; "
        strHTML = strHTML & "   var objTableTR; "
        strHTML = strHTML & "   var strID; "
        strHTML = strHTML & "   var blnUP; "
        strHTML = strHTML & "   intRecordCount = document.forms.item(0).txtDiv" & strTitle & ".value; " + vbCrLf
        strHTML = strHTML & "   for(intLoopCounter=5;intLoopCounter<intRecordCount;intLoopCounter++) " + vbCrLf
        strHTML = strHTML & "   { "
        strHTML = strHTML & "       strID= '" & Trim(strDivID) & "' + intLoopCounter ; "
        strHTML = strHTML & "       objTableTR = document.getElementById(strID); "
        strHTML = strHTML & "       if (objTableTR.style.display=='') "
        strHTML = strHTML & "       { "
        strHTML = strHTML & "           objTableTR.style.display = 'none'; "
        strHTML = strHTML & "           blnUP=1; "
        strHTML = strHTML & "       } "
        strHTML = strHTML & "       else "
        strHTML = strHTML & "       { "
        strHTML = strHTML & "           objTableTR.style.display = ''; "
        strHTML = strHTML & "           blnUP=0; "
        strHTML = strHTML & "       } "
        strHTML = strHTML & "   } " + vbCrLf
        strHTML = strHTML & "   if(blnUP==0) "
        strHTML = strHTML & "       document.forms.item(0).I" & Trim(strDivID) & ".src ='../../Images/up_DB.gif'; " + vbCrLf
        strHTML = strHTML & "   else "
        strHTML = strHTML & "       document.forms.item(0).I" & Trim(strDivID) & ".src ='../../Images/down_DB.gif'; " + vbCrLf
        strHTML = strHTML & "} "

        If strLinkField <> "" Then
            strHTML = strHTML & "function " & Trim(strDivID) & "LinkClick(UniqueID, intProjectID)" + vbCrLf
            strHTML = strHTML & "{ "
            strHTML = strHTML & " window.open("" " & strLinkUrl & "&" & strUniqueIDField & "=""+ UniqueID + ""&ProjectID="" + intProjectID, ""_blank"", ""resizable=yes,scrollbars=yes,left="" + (window.screen.width - 720)/2 + "",top="" + (window.screen.height - 400)/2 + "",width=720,height=430""); "
            strHTML = strHTML & "} " + vbCrLf
        End If

        strHTML = strHTML & "</script> " + vbCrLf
        '=============================================================================================
        'client side script generation block completed
        '=============================================================================================

        'Dispose Data Reader
        CommonFunctions.Data.DisposeDataReader(drHTMLdata)

        Return strHTML
    End Function

#End Region

End Class
