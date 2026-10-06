Namespace PBCommons
    ''Added by Dhanashri S on 29 Oct 2015
    Public Class Constants
        Public Const FRAMEWORK_KEY_CONTROL_SAVE As String = "PB_CONTROL_SAVE"
        Public Const FRAMEWORK_KEY_GRAPH_DELETE As String = "PB_GRAPH_DELETE"
        Public Const FRAMEWORK_KEY_GRAPH_SAVE As String = "PB_GRAPH_SAVE"
        Public Const FRAMEWORK_KEY_RELATED_DATA_DELETE As String = "PB_RELATED_DATA_DELETE"
        Public Const FRAMEWORK_KEY_RELATED_DATA_SAVE As String = "PB_RELATED_DATA_SAVE"
        Public Const FRAMEWORK_KEY_TAB_CONTROL_SAVE As String = "PB_TAB_CONTROL_SAVE"
        Public Const FRAMEWORK_KEY_ACTION_DELETE As String = "PB_ACTION_DELETE"
        Public Const FRAMEWORK_KEY_ACTION_SAVE As String = "PB_ACTION_SAVE"
        Public Const UI_TEMPLATEID_ADVANCED As String = "E7E5FD0C-F513-4E0E-A5A6-8CE8C939456B"
        Public Const UI_TEMPLATEID_SUBTAG_PAGE_AND_LIST As String = "C81B27E7-54B5-4C24-96D2-14969AFF0F1B" 'Added by Ninad on 29 Oct 2007, Req ID - WAF3_PB_54 - Is Non Database Control
    End Class
    ''End of Addition by Dhanashri S on 29 Oct 2015

    Public Class CommonFunctions
        '=====================================================================
        ' Procedure Name		:	GetSPAccordingToEnvironment
        ' Parameters Passed		:	strSPName - name of sp or table
        '                           lngUniqueID -  The primary of the table on which the query is being fired
        '                                           such as TagID, SubTagID etc.
        ' Returns				:	String
        ' Parameters Affected	:	None
        ' Purpose				:	This function prepares the SP according to the 
        '                           deveopment environment
        ' Description			:	if development env = "D" then returns the string by appending " "
        '                           if development env = "P" then returns the string by appending "_User "
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	PrasannaP
        ' Created				:	15 November, 2003
        ' Revisions				:	
        '=====================================================================

        Public Shared Function GetSPAccordingToEnvironment(ByVal strSPName As String, Optional ByVal lngUniqueID As Long = Nothing) As String
            Dim strEnvironment As String
            Dim strSPAccordingToEnvironment As String
            strSPName = Trim(strSPName)
            strEnvironment = CType(CommonFunction.General.GetApplicationKeySetting("Environment"), String)
            'For SPs and Queries other than insert
            If Not (lngUniqueID = Nothing) Then
                If (strEnvironment.Equals(CommonFunction.Constants.DEVELOPMENT_ENVIORNMENT) Or lngUniqueID < 50000) Then
                    strSPAccordingToEnvironment = strSPName + " "
                ElseIf (strEnvironment.Equals(CommonFunction.Constants.PRODUCTION_ENVIORNMENT) Or lngUniqueID >= 50000) Then
                    strSPAccordingToEnvironment = strSPName + "_User "
                End If
                'For insert SPs and Queries
            Else
                If (strEnvironment.Equals(CommonFunction.Constants.DEVELOPMENT_ENVIORNMENT)) Then
                    strSPAccordingToEnvironment = strSPName + " "
                ElseIf (strEnvironment.Equals(CommonFunction.Constants.PRODUCTION_ENVIORNMENT)) Then
                    strSPAccordingToEnvironment = strSPName + "_User "
                End If
            End If
            Return strSPAccordingToEnvironment
        End Function

        Public Shared Sub DrawInstructions(ByVal strInstructions As String)
            Dim objHeaderFooter As New WebPage.Templates.HeaderFooter()
            objHeaderFooter.HeaderFooter = strInstructions
            objHeaderFooter.DrawHeaderFooter()
            CommonFunction.General.WriteHTML("<BR>")
        End Sub


        'Common function for plotting controls
        Public Shared Sub PlotControl(ByVal strName As String, ByVal strid As String, ByVal intControlTypeID As Integer, _
        ByVal strCaption As String, ByVal strDetails As String, ByVal lngWidth As Long, ByVal lngMaxLength As Long, _
        ByVal blnMandatory As Boolean, ByVal strAddInfo As String, ByVal strAlignment As String, ByVal strValue As String, _
        Optional ByVal strMessage As String = "", Optional ByVal strFormName As String = "", _
        Optional ByVal strToBeInserted As String = "", Optional ByVal blnIsChecked As Boolean = False, _
        Optional ByVal blnShowHTMLEditor As Boolean = False, Optional ByVal blnIsDisabled As Boolean = False, _
        Optional ByVal strCaptionTDWidth As String = "25%", Optional ByVal strControlTDWidth As String = "75%", _
        Optional ByVal strSupplementary As String = "")

            '####### Select case for Control Type
            Select Case intControlTypeID
                '###### If control type is Text Box
                Case CommonFunction.Constants.CONTROL_TYPE_TEXT_BOX
                    CommonFunction.General.WriteHTML("<TR id='tr" + strName + "' class='clsTREven' width='100%'>")
                    CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                    CommonFunction.General.WriteHTML(strCaption & "&nbsp;")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD width='" + strControlTDWidth + "'>")
                    'drawing text box for dataheader
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    CommonFunction.HTMLControls.DrawTextBox(strName, strid, , lngWidth, lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory, EnableHTMLEncode:=True)
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    If Not strMessage = "" Then
                        CommonFunction.General.WriteHTML("&nbsp;&nbsp;" & strMessage)
                    End If
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    '###### End

                    '###### If control type is Combo Box
                Case CommonFunction.Constants.CONTROL_TYPE_COMBO_BOX
                    ''Added by Dhanashri S on 29 Oct 2015

                    '=============================================================================================================
                    'Added By   : Ninad
                    'Purpose    : To set the display of table row containing visibility combo,
                    '             display is depend on selected value of Display position combo
                    'Req. ID	: WAF3_PB_27
                    'Date       : 27 July 2006
                    '=============================================================================================================

                    ''End of Addition by Dhanashri S on 29 Oct 2015
                    CommonFunction.General.WriteHTML("<TR id='tr" + strName + "' class='clsTREven' width='100%'>")

                    ''Added by Dhanashri S on 29 Oct 2015
                    If strName.ToUpper = "COMBOVISIBILITY" Then
                        CommonFunction.General.WriteHTML(" " + strToBeInserted + " ")
                        strToBeInserted = ""
                    End If
                    CommonFunction.General.WriteHTML(">")
                    '=============================================================================================================
                    'End Addition By  : Ninad
                    '=============================================================================================================
                    'Added By NinadP :	6 April 2007 : Requirement Tag - WAF3_PB_42 - Dropdown Menu
                    If strName = "DynamicAction_NavigationSchema" Then
                        'If Drop Down Navigation is enabled then only show the "Action Navigation Schema" Property
                        If CommonFunction.General.GetFrameworkSettings("GEN_ACTION_NAVIGATION_DROPDOWNMENU", "Disabled") Then Exit Sub
                        If strValue = "2" Then
                            Dim strIsSubTag As String = CStr(IIf(HttpContext.Current.Request.QueryString("FromElement") = "Tag", "0", "1"))
                            Dim strTagID As String
                            If strIsSubTag = "0" Then
                                strTagID = CStr(HttpContext.Current.Request.QueryString("TagID"))
                            Else
                                strTagID = CStr(HttpContext.Current.Request.QueryString("SubTagID"))
                            End If
                            CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                            CommonFunction.General.WriteHTML("<a href=""Javascript:ActionLinksSchema_OnClick(" + strIsSubTag + "," + strTagID + ")"">" + strCaption + "</a>&nbsp;")
                            CommonFunction.General.WriteHTML("</TD>")
                        Else
                            CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                            CommonFunction.General.WriteHTML(strCaption & "&nbsp;")
                            CommonFunction.General.WriteHTML("</TD>")
                        End If
                    Else
                        ''End of Addition by Dhanashri S on 29 Oct 2015

                        CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                        CommonFunction.General.WriteHTML(strCaption & "&nbsp;")
                        CommonFunction.General.WriteHTML("</TD>")

                        ''Added by Dhanashri S on 29 Oct 2015
                    End If
                    'Addition End By : Ninad   Req Id : WAF3_PB_42 - Dropdown Menu
                    ''End of Addition by Dhanashri S on 29 Oct 2015

                    CommonFunction.General.WriteHTML("<TD width='" + strControlTDWidth + "'>")
                    Dim blnInsertBlankRow As Boolean = True
                    If blnMandatory Then
                        blnInsertBlankRow = False
                    End If
                    ''Added by Dhanashri S on 29 Oct 2015
                    '=============================================================================================================
                    'Added By   : Ninad
                    'Purpose    : To skip inserting blank row in Visibility combo 
                    'Req. ID	: WAF3_PB_27
                    'Date       : 27 July 2006
                    '=============================================================================================================
                    If strName.ToUpper = "COMBOVISIBILITY" Then
                        blnInsertBlankRow = False
                    End If
                    '=============================================================================================================
                    'End Addition By  : Ninad
                    '=============================================================================================================

                    ''End of Addition by Dhanashri S on 29 Oct 2015
                    If (strSupplementary = "COLOR_COMBO") Then
                        CommonFunction.HTMLControls.DrawColorComboBox(strName, CType(lngWidth, Integer), strValue, strToBeInserted, blnInsertBlankRow, , , blnMandatory)
                    Else
                        CommonFunction.HTMLControls.DrawComboBox(strName, strAddInfo, CType(lngWidth, Integer), strValue, strToBeInserted, blnInsertBlankRow, , , blnMandatory)
                    End If
                    If Not strMessage = "" Then
                        CommonFunction.General.WriteHTML("&nbsp;" & strMessage)
                    End If
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    '###### End

                    '###### if control type is Check Box
                Case CommonFunction.Constants.CONTROL_TYPE_CHECK_BOX
                    CommonFunction.General.WriteHTML("<TR class='clsTREven' width='100%'>")

                    ''Added by Dhanashri S on 29 Oct 2015

                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On 14-May-2007 For Requirement ID - WAF3_PB_47
                    'Reason   - For conditionally hiding the control
                    '-------------------------------------------------------------------------------------------------------------
                    If strName = "ShowInContextMenu" Then
                        CommonFunction.General.WriteHTML(strToBeInserted)
                        strToBeInserted = ""
                    End If
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On 14-May-2007 For Requirement ID - WAF3_PB_47
                    '-------------------------------------------------------------------------------------------------------------

                    CommonFunction.General.WriteHTML(">")

                    ''End of Addition by Dhanashri S on 29 Oct 2015

                    CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                    CommonFunction.General.WriteHTML(strCaption & "&nbsp;")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD width='" + strControlTDWidth + "'>")
                    'Dim blnIsChecked As Boolean
                    Select Case strValue
                        Case "True"
                            blnIsChecked = True
                        Case "0"
                            blnIsChecked = False
                        Case ""
                            blnIsChecked = False
                            'Case "A", "E", "D", "V"
                            '    blnIsChecked = True

                    End Select
                    CommonFunction.HTMLControls.DrawCheckBox(strName, strName, , blnIsChecked, strValue, blnIsDisabled, strToBeInserted, , blnMandatory)

                    If Not strMessage = "" Then
                        CommonFunction.General.WriteHTML("&nbsp;" & strMessage)
                    End If
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    '###### End

                    '###### if control type is text area
                Case CommonFunction.Constants.CONTROL_TYPE_TEXT_AREA
                    CommonFunction.General.WriteHTML("<TR id='tr" + strName + "' class='clsTREven' width='100%'>")
                    CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                    CommonFunction.General.WriteHTML(strCaption & "&nbsp;")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD width='" + strControlTDWidth + "'>")

                    ''Added by Dhanashri S on 29 Oct 2015

                    'Added By Ninad on 10 Mar 2008, WAF3_PB_62 - UI Design Template
                    If strName.ToUpper = "UIDESIGNTEMPLATE" Then
                        blnShowHTMLEditor = False
                    End If
                    'End Addition By Ninad on 10 Mar 2008, WAF3_PB_62 - UI Design Template
                    '--------------------------------------------------------------------------------- 
                    'Added By Shrikant on 22 May 2008 , WAF3_PB_62_V2 - UI Design Footer Template
                    If strName.ToUpper = "UIDESIGNFOOTERTEMPLATE" Then
                        blnShowHTMLEditor = False
                    End If
                    'End Addition By Shrikant on 22 May 2008 , WAF3_PB_62_V2 - UI Design Footer Template
                    '---------------------------------------------------------------------------------

                    ''End of Addition by Dhanashri S on 29 Oct 2015

                    If blnShowHTMLEditor = True Then
                        ''Commented and Added by Dhanashri S on 29 Oct 2015
                        'CommonFunction.HTMLControls.DrawTextArea(strName, strid, strCaption, , , strFormName, , , lngWidth, , lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory, , True, , "Show HTML Editor")
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        ' CommonFunction.HTMLControls.DrawTextArea(strName, strid, strCaption, , , strFormName, , , lngWidth, , lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory, , True, , "Show HTML Editor", , "off", -1) 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 11 June 2007 TabIndex set to -1
                        CommonFunction.HTMLControls.DrawTextArea(strName, strid, strCaption, , , strFormName, , , lngWidth, , lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory, , True, , "Show HTML Editor", , "off", -1, True) 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 11 June 2007 TabIndex set to -1
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        ''End of Comment and Addition by Dhanashri S on 29 Oct 2015
                    Else
                        ''Commented and Added by Dhanashri S on 29 Oct 2015
                        'CommonFunction.HTMLControls.DrawTextArea(strName, strid, strCaption, , , strFormName, , , lngWidth, , lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory)
                        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        'CommonFunction.HTMLControls.DrawTextArea(strName, strid, strCaption, , , strFormName, , , lngWidth, , lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory, , , , , , "off", -1) 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 11 June 2007 TabIndex set to -1
                        CommonFunction.HTMLControls.DrawTextArea(strName, strid, strCaption, , , strFormName, , , lngWidth, , lngMaxLength, strValue, strAlignment, , blnIsDisabled, , , , , , blnMandatory, , , , , , "off", -1, True) 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 11 June 2007 TabIndex set to -1
                        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        ''End of Comment and Addition by Dhanashri S on 29 Oct 2015
                    End If
                    If Not strMessage = "" Then
                        CommonFunction.General.WriteHTML("&nbsp;" & strMessage)
                    End If
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    '###### End
                Case CommonFunction.Constants.CONTROL_TYPE_HTML_TAG
                    CommonFunction.General.WriteHTML("<TR id='tr" + strName + "' class='clsTREven' width='100%'>")
                    CommonFunction.General.WriteHTML("<TD vAlign='top' align='right' width='" + strCaptionTDWidth + "'>")
                    CommonFunction.General.WriteHTML(strCaption + "&nbsp;")
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("<TD width='" + strControlTDWidth + "'>")
                    'Drawing html tag
                    CommonFunction.General.WriteHTML(strValue)
                    CommonFunction.General.WriteHTML("</TD>")
                    CommonFunction.General.WriteHTML("</TR>")
                    '##### End
            End Select
            '###### End
        End Sub

        '=====================================================================
        ' Procedure  Name		:	ValidateSQLStatement
        ' Parameters Passed		:	strSQLStatement - SQL statement to be validated
        ' Returns				:	If the SQL statement is valid then true, else false
        ' Parameters Affected	:	None
        ' Purpose				:	To check whether an SQL statement is a valid SQL statement
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AbhijeetD
        ' Created				:	20 Dec 2003
        ' Revisions				:	
        '=====================================================================

        Public Shared Function ValidateSQLStatement(ByVal strSQLStatement As String, ByVal lngTagID As Long) As Boolean
            Dim strSQL As String
            Dim drCheckSP As IDataReader

            'Replace the PlaceHolders and QueryStringParameters in the sql statement by zeroes
            strSQLStatement = ReplacePlaceHolders(strSQLStatement)
            strSQLStatement = ReplaceQueryStringParameters(strSQLStatement, lngTagID)
            strSQLStatement = Trim(strSQLStatement)
            If (Left(strSQLStatement.ToUpper, 5) = "EXEC ") Then
                strSQLStatement = strSQLStatement.Remove(0, 5)
            ElseIf (Left(strSQLStatement.ToUpper, 8) = "EXECUTE ") Then
                strSQLStatement = strSQLStatement.Remove(0, 8)
            End If
            strSQLStatement = "EXEC " + "('" + strSQLStatement + "')"

            'Set transactions on the statement, to rollback the query once it is executed for validation
            strSQL = "BEGIN TRANSACTION T1" + vbCrLf
            strSQL = strSQL + strSQLStatement + vbCrLf
            strSQL = strSQL + "ROLLBACK TRANSACTION T1"

            Try
                drCheckSP = (CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)))
            Catch ex As Exception
                Return False
            Finally
                If Not IsNothing(drCheckSP) Then
                    drCheckSP.Close() : drCheckSP.Dispose() : drCheckSP = Nothing
                End If
            End Try
            Return True
        End Function

        '=====================================================================
        ' Procedure  Name		:	ReplacePlaceHolders()
        ' Parameters Passed		:	strSQLStatement - SQL statement 
        ' Returns				:	SQL statement with the place holders, if any replaced by zeroes
        ' Parameters Affected	:	None
        ' Purpose				:	This function replaces standard placeholders such as <UNIQUE_ID> by zeroes
        ' Description			:	Same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AbhijeetD
        ' Created				:	Jan 22 2004
        ' Revisions				:	
        '=====================================================================
        Private Shared Function ReplacePlaceHolders(ByVal strSQLStatement As String) As String
            If strSQLStatement = "" Then Return ""
            Dim objPlaceHolder() As CommonEngines.HashTables.UIPlaceHolders
            objPlaceHolder = CommonEngines.HashTables.GetHashTableObject.GetHashTablePlaceHoldersObject()
            If objPlaceHolder Is Nothing Then Return strSQLStatement
            Dim intIndex As Integer
            Dim intLastIndex As Integer = objPlaceHolder.Length - 1
            For intIndex = 0 To intLastIndex

                ''Commented and Added by Dhanashri S on 29 Oct 2015
                'If objPlaceHolder(intIndex).UseSessionVariables = False Then
                '    strSQLStatement = strSQLStatement.Replace(objPlaceHolder(intIndex).PlaceHolder, "0")
                If LCase(objPlaceHolder(intIndex).DataType) = "uniqueidentifier" Then
                    strSQLStatement = strSQLStatement.Replace("''" + objPlaceHolder(intIndex).PlaceHolder + "''", "NULL")
                Else
                    strSQLStatement = strSQLStatement.Replace(objPlaceHolder(intIndex).PlaceHolder, "''0''")
                    ''End of Comment and Addition by Dhanashri S on 29 Oct 2015
                End If

            Next
            Return strSQLStatement
        End Function

        '=====================================================================
        ' Procedure  Name		:	ReplaceQueryStringParameters()
        ' Parameters Passed		:	strSQLStatement - SQL statement 
        ' Returns				:	SQL statement with the query string parameters, if any replaced by zeroes
        ' Parameters Affected	:	None
        ' Purpose				:	This function replaces query string parameters such as <#intUserID> by zeroes
        ' Description			:	Same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AbhijeetD
        ' Created				:	Jan 22 2004
        ' Revisions				:	
        '=====================================================================
        Private Shared Function ReplaceQueryStringParameters(ByVal strSQLStatement As String, ByVal lngTagID As Long) As String
            Dim objDefaultFilter() As CommonEngines.HashTables.UITagDefaultFilters
            If strSQLStatement = "" Then Return ""
            'Create object of Default Filter hash table 'ALWAYS of MASTER TAG
            objDefaultFilter = CommonEngines.HashTables.GetHashTableObject.GetHashTableDefaultFiltersObject(lngTagID)
            If objDefaultFilter Is Nothing Then Return strSQLStatement
            Dim intIndex As Integer
            Dim intLastIndex As Integer = objDefaultFilter.Length - 1
            For intIndex = 0 To intLastIndex
                If objDefaultFilter(intIndex).IsQueryStringParameter = True Then
                    strSQLStatement = strSQLStatement.Replace("<#" + objDefaultFilter(intIndex).FieldName + ">", "0")
                End If
            Next
            Return strSQLStatement
        End Function

        ''Added by Dhanashri S on 29 Oct 2015
        '=====================================================================
        ' Procedure  Name		:	FrameworkSetting
        ' Parameters Passed		:	strFeatureKey - Key whose setting is to be checked
        ' Returns				:	If the setting is as per required ("Enabled") then true, else false
        ' Parameters Affected	:	None
        ' Purpose				:	To check the Framework setting of a feature
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AbhijeetD
        ' Created				:	28 Jan 2004
        ' Revisions				:	
        '=====================================================================
        Public Shared Function FrameworkSetting(ByVal strFeatureKey As String) As Boolean
            Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
            objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject(strFeatureKey)
            If Not objFrameworkSetting Is Nothing Then
                If UCase(Trim(objFrameworkSetting.Status & "")) = "ENABLED" Then
                    Return True
                Else
                    Return False
                End If
            End If
            objFrameworkSetting = Nothing
        End Function
        ''End of Addition by Dhanashri S on 29 Oct 2015 

    End Class


#Region "HTML Table Plotting Class"
    Public Class TablePlotting
        '=====================================================================
        ' Class Name    		:	TablePlotting
        ' Parameters Passed		:	NA
        ' Returns				:	NA
        ' Parameters Affected	:	None
        ' Purpose				:	This class is used to plot the html specifically tables
        ' Description			:	DrawTable() DrawRow() DrawCell() CloseCell() CloseRow() CloseTable()
        '                           Above functions are mainly used to plot the table.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	PrasannaP
        ' Created				:	17 November, 2003
        ' Revisions				:	
        '=====================================================================

        Public Shared Sub DrawTable(ByVal strID As String, Optional ByVal strClsTable As String = "clsTable")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            CommonFunction.General.WriteHTML("<TABLE class=""" + strClsTable + """ id=""" + strID + """ border=""0"" width=""99.9%"" cellpadding=""0"" cellspacing=""0"">")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        End Sub

        Public Shared Sub CloseTable()
            CommonFunction.General.WriteHTML("</TABLE>")
        End Sub

        Public Shared Sub DrawRow(Optional ByVal strWidth As String = "100%", Optional ByVal strID As String = Nothing, _
                                  Optional ByVal strHeight As String = Nothing, Optional ByVal strStringToBeInserted As String = "")
            If strID Is Nothing Then
                CommonFunction.General.WriteHTML("<TR Width=""" + strWidth + """ Class=""clsTREven"">")
            Else
                CommonFunction.General.WriteHTML("<TR id=""" + strID + """ Width=""" + strWidth + """ class=""clsTDEven"">")
            End If
        End Sub

        Public Shared Sub CloseRow()
            CommonFunction.General.WriteHTML("</TR>")
        End Sub


        Public Shared Sub DrawCell(ByVal strAlignment As String, ByVal CaptionFlag As Boolean, Optional ByVal strWidth As String = "25%", Optional ByVal splitFlag As Boolean = False)
            Dim strClsLabel As String = ""
            Dim strClsTDOdd As String = ""
            If CaptionFlag = True Then
                CommonFunction.General.WriteHTML("<TD align=""" + strAlignment + """ width=""" + strWidth + """>")
            End If
            If CaptionFlag = False And splitFlag = True Then
                CommonFunction.General.WriteHTML("<TD align=""" + strAlignment + """ width=""" + strWidth + """>")
            End If
            If CaptionFlag = False And splitFlag = False Then
                CommonFunction.General.WriteHTML("<TD align=""" + strAlignment + """ width=""75%"">")
            End If
        End Sub

        Public Shared Sub CloseCell()
            CommonFunction.General.WriteHTML("</TD>")
        End Sub

    End Class
#End Region

#Region "Validation Rule Class"

    Public Class cPBValidationRules
        '=====================================================================
        ' Class	Name	        :	cValidationRules
        ' Purpose				:	This class will be used to set the validation
        '                           rules for the control
        ' Description			:	Same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	UmeshJ
        ' Created				:	November 02, 2003
        ' Revisions				:	
        '=====================================================================
        'Class Variables
        Private strAppliedValidationRules As String
        Private strFormName As String = ""
        Private strControlName As String = ""
        Private strControlCaption As String = ""
        Private intMaxlength As Integer
        Private lngCurrentLCID As Long
        Private lngDefaultLCID As Long

        ''Added by Dhanashri S on 29 Oct 2015
        Private strExistingValuesArray As String = ""
        Private strValidationSQL As String = ""
        Private strCurrentValue As String
        Private intMinlength As Integer
        Private dblMinValue As Long
        Private dblMaxValue As Long
        ''End of Addition by Dhanashri Son 29 Oct 2015

        Public WriteOnly Property AppliedValidationRules() As String
            Set(ByVal Value As String)
                strAppliedValidationRules = Value
            End Set
        End Property

        Public WriteOnly Property FormName() As String
            Set(ByVal Value As String)
                strFormName = Value
            End Set
        End Property

        Public WriteOnly Property ControlName() As String
            Set(ByVal Value As String)
                strControlName = Value
            End Set
        End Property

        Public WriteOnly Property ControlCaption() As String
            Set(ByVal Value As String)
                strControlCaption = Value
            End Set
        End Property

        Public WriteOnly Property MaxLength() As Integer
            Set(ByVal value As Integer)
                intMaxlength = value
            End Set
        End Property

        Public WriteOnly Property CurrentLCID() As Long
            Set(ByVal value As Long)
                lngCurrentLCID = value
            End Set
        End Property

        Public WriteOnly Property DefaultLCID() As Long
            Set(ByVal value As Long)
                lngDefaultLCID = value
            End Set
        End Property

        ''Added by Dhanashri S on 29 Oct 2015
        Public WriteOnly Property ValidationSQL() As String
            Set(ByVal value As String)
                strValidationSQL = value
            End Set
        End Property
        Public WriteOnly Property ExistingValuesArray() As String
            Set(ByVal value As String)
                strExistingValuesArray = value
            End Set
        End Property
        Public WriteOnly Property CurrentValue() As String
            Set(ByVal value As String)
                strCurrentValue = value
            End Set
        End Property
        Public WriteOnly Property MinLength() As Integer
            Set(ByVal value As Integer)
                intMinlength = value
            End Set
        End Property

        Public WriteOnly Property MinValue() As Long
            Set(ByVal value As Long)
                dblMinValue = value
            End Set
        End Property

        Public WriteOnly Property MaxValue() As Long
            Set(ByVal value As Long)
                dblMaxValue = value
            End Set
        End Property
        ''End of Addition by Dhanashri S on 29 Oct 2015

        'Constructor

        Public Function GetValidationRules() As String
            '=====================================================================
            ' Procedure Name        :	GetValidationRules
            ' Purpose               :	This Public method will return the FORMATED 
            '                           Validation Rules to be applied for the control
            ' Description           :	Same as above 
            ' Parameters Passed     :	None.
            ' Parameters Affected   :	None.
            ' Returns               :	Validation Rules
            ' Assumptions           :	None.
            ' Dependencies          :	None.
            ' Author                :	UmeshJ
            ' Created               :	November 02, 2003 
            ' Revisions             :
            '=====================================================================
            Dim strAppliedRules As String() = Split(strAppliedValidationRules, ",")
            Dim intUBound As Integer = strAppliedRules.GetUpperBound(0)
            Dim intIndex As Integer
            Dim sbRules As New System.Text.StringBuilder("")
            Dim strRule As String = ""
            Dim strValidationMessage As String

            For intIndex = 0 To intUBound
                'Build Client side script for each rule
                If strAppliedRules(intIndex).Trim <> "" Then
                    Dim strSQL As String
                    Dim drGetValidationMessage As IDataReader
                    'Get the data reader object
                    If lngDefaultLCID = lngCurrentLCID Then
                        drGetValidationMessage = CommonFunction.Data.GetDataReader("usp_Sel_PB_GetValidationMessage " & strAppliedRules(intIndex), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    Else
                        drGetValidationMessage = CommonFunction.Data.GetDataReader("usp_Sel_PB_GetValidationMessage_Culture " + strAppliedRules(intIndex) + ", " + CStr(lngCurrentLCID), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                    End If
                    drGetValidationMessage.Read()

                    strValidationMessage = drGetValidationMessage("ValidationMessage").ToString
                    If Not IsDBNull(drGetValidationMessage("ValidationMessage")) Then
                        strValidationMessage = CType(drGetValidationMessage("ValidationMessage"), String)
                    End If
                    drGetValidationMessage.Close() : drGetValidationMessage.Dispose() : drGetValidationMessage = Nothing

                    strRule = BuildValidationScript(CType(strAppliedRules(intIndex).Trim, Integer), strValidationMessage)
                    If strRule.Trim <> "" Then sbRules.Append(strRule)
                End If
            Next

            GetValidationRules = sbRules.ToString
            sbRules = Nothing
        End Function

        Private Function BuildValidationScript(ByVal RuleID As Integer, ByVal Message As String) As String
            '=====================================================================
            ' Procedure Name        :	BuildValidationScript
            ' Purpose               :	This private method will accept the RuleID 
            '                           as parameter and build the client side 
            '                           validation rule script of it and will return it
            ' Description           :	Same as above 
            ' Parameters Passed     :	Rule ID.
            ' Parameters Affected   :	None.
            ' Returns               :	Validation Rule Client side Script
            ' Assumptions           :	None.
            ' Dependencies          :	None.
            ' Author                :	UmeshJ
            ' Created               :	November 02, 2003 
            ' Revisions             :
            '=====================================================================
            Dim sbRule As New System.Text.StringBuilder("")

            Select Case RuleID
                Case CommonFunction.Constants.VALIDATION_NOT_BLANK
                    'Disallow blank
                    'sbRule.Append(vbCrLf + "if (disallowBlank(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, strValidationRuleMessages(strValidationRuleIDs.IndexOf(strValidationRuleIDs, RuleID.ToString.Trim))) + Chr(39) + ",true) )")
                    sbRule.Append(vbCrLf + "if (disallowBlank(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true) )")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_IS_DATE
                    'Check if valid date
                    sbRule.Append(vbCrLf + "if (!isDate(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_IS_NUMERIC
                    'Disallow non numeric data
                    sbRule.Append(vbCrLf + "if (disallowNonNumeric(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_ONLY_ALPHABETS
                    'Disallow non alphabet data (other than A-Z or a-z)
                    sbRule.Append(vbCrLf + "if (disallowNonAlphabets(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_MAX_LENGTH
                    'Donot allow maxlength violation
                    sbRule.Append(vbCrLf + "if (disallowMaxlengthViolation(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + intMaxlength.ToString + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)

                    ''Added by Dhanashri S on 29 Oct 2015
                Case CommonFunction.Constants.VALIDATION_MIN_LENGTH
                    'Donot allow minlength violation
                    sbRule.Append(vbCrLf + "if (disallowMinlengthViolation(GetObjectReference(" + Chr(34) + Microsoft.VisualBasic.Strings.Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + intMinlength.ToString + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                    ''End of Addition by Dhanashri S on 29 Oct 2015

                Case CommonFunction.Constants.VALIDATION_IS_POSITIVE_NUMERIC
                    'Allow only positive numeric data
                    sbRule.Append(vbCrLf + "if (disallowNegativeNumeric(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)

                    ''Added by Dhanashri S on 29 Oct 2015
                Case CommonFunction.Constants.VALIDATION_IS_DUPLICATE
                    Dim strDuplicateArray As String = GetExistingValuesArray()
                    If strDuplicateArray.Trim <> "" Then
                        sbRule.Append(strDuplicateArray)
                        'Disallow duplicate values : Ignore Case
                        sbRule.Append(vbCrLf + "if (disallowDuplicates(GetObjectReference(" + Chr(34) + Microsoft.VisualBasic.Strings.Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + strExistingValuesArray + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true,false))")
                        sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                    End If
                Case CommonFunction.Constants.VALIDATION_IS_DUPLICATE_MATCH_CASE
                    Dim strDuplicateArray As String = GetExistingValuesArray()
                    If strDuplicateArray.Trim <> "" Then
                        sbRule.Append(strDuplicateArray)
                        'Disallow duplicate values : Match Case
                        sbRule.Append(vbCrLf + "if (disallowDuplicates(GetObjectReference(" + Chr(34) + Microsoft.VisualBasic.Strings.Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + strExistingValuesArray + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true,true))")
                        sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                    End If
                    ''End of Addition by Dhanashri S on 29 Oct 2015

                Case CommonFunction.Constants.VALIDATION_DISALLOW_SP_CHARS
                    'Disallow special characters
                    sbRule.Append(vbCrLf + "if (disallowSpecialCharacters(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)

                    ''Added by Dhanashri S on 29 Oct 2015
                Case CommonFunction.Constants.VALIDATION_MIN_VALUE
                    'The value must be greater than the Minimum value
                    sbRule.Append(vbCrLf + "if (disallowMinValueViolation(GetObjectReference(" + Chr(34) + Microsoft.VisualBasic.Strings.Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + dblMinValue.ToString + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_MAX_VALUE
                    'The value must be less than the Maximum value
                    sbRule.Append(vbCrLf + "if (disallowMaxValueViolation(GetObjectReference(" + Chr(34) + Microsoft.VisualBasic.Strings.Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + dblMaxValue.ToString + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_VALUE_RANGE
                    'The value must be with in the range
                    sbRule.Append(vbCrLf + "if (disallowValueRangeViolation(GetObjectReference(" + Chr(34) + Microsoft.VisualBasic.Strings.Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + dblMinValue.ToString + "," + dblMaxValue.ToString + "," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                    ''End of Addition by Dhanashri S on 29 Oct 2015

                Case CommonFunction.Constants.VALIDATION_IS_INTEGER
                    sbRule.Append(vbCrLf + "if (disallowNonInteger(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
                Case CommonFunction.Constants.VALIDATION_IS_POSITIVE_INTEGER
                    sbRule.Append(vbCrLf + "if (disallowNegativeInteger(GetObjectReference(" + Chr(34) + Replace(strFormName, """", "\quot;") + Chr(34) + "," + Chr(34) + strControlName + Chr(34) + ")," + Chr(39) + FormatMessage(RuleID, Message) + Chr(39) + ",true))")
                    sbRule.Append(vbCrLf + "{ return false; }" + vbCrLf)
            End Select
            BuildValidationScript = sbRule.ToString
            sbRule = Nothing
        End Function
        Private Function FormatMessage(ByVal RuleID As Integer, ByVal strMsg As String) As String
            '=====================================================================
            ' Procedure Name        :	FormatMessage
            ' Purpose               :	This private method will format the Message
            ' Description           :	Replace the place holders with their actual values
            ' Parameters Passed     :	RuleID , Message
            ' Parameters Affected   :	None.
            ' Returns               :	Formated Message
            ' Assumptions           :	None.
            ' Dependencies          :	None.
            ' Author                :	UmeshJ
            ' Created               :	November 04, 2003 
            ' Revisions             :
            '=====================================================================
            FormatMessage = ""
            If strMsg.Trim <> "" Then
                'FormatMessage = Replace(strMsg, "<ID>", "" + Replace(strControlCaption, """", "\quot;") + "")
                FormatMessage = Replace(strMsg, "<ID>", "" + strControlCaption + "")

                ''Added by Dhanashri S on 29 Oct 2015
                FormatMessage = Microsoft.VisualBasic.Strings.Replace(strMsg, "<ID>", "&#39;" + strControlCaption + "&#39;")
                ''End of Addition by Dhanashri S on 29 Oct 2015

                Select Case RuleID
                    Case CommonFunction.Constants.VALIDATION_MAX_LENGTH
                        FormatMessage = Replace(FormatMessage, "<LENGTH>", intMaxlength.ToString)

                        ''Added by Dhanashri S on 29 Oct 2015
                    Case CommonFunction.Constants.VALIDATION_MIN_LENGTH
                        FormatMessage = Microsoft.VisualBasic.Strings.Replace(FormatMessage, "<LENGTH>", intMinlength.ToString)
                    Case CommonFunction.Constants.VALIDATION_MIN_VALUE
                        FormatMessage = Microsoft.VisualBasic.Strings.Replace(FormatMessage, "<VALUE>", dblMinValue.ToString)
                    Case CommonFunction.Constants.VALIDATION_MAX_VALUE
                        FormatMessage = Microsoft.VisualBasic.Strings.Replace(FormatMessage, "<VALUE>", dblMaxValue.ToString)
                    Case CommonFunction.Constants.VALIDATION_VALUE_RANGE
                        FormatMessage = Microsoft.VisualBasic.Strings.Replace(FormatMessage, "<RANGE>", dblMinValue.ToString + "-" + dblMaxValue.ToString)
                        ''End of Addition by Dhanashri S on 29 Oct 2015

                End Select
            End If
        End Function

        ''Added by Dhanashri S on 29 Oct 2015
        Private Function GetExistingValuesArray() As String
            '=====================================================================
            ' Procedure Name        :	GetExistingValuesArray
            ' Purpose               :	Get client side script for Existing Values 
            '                           Array for combo bo
            ' Description           :	Same as above
            ' Parameters Passed     :	None
            ' Parameters Affected   :	None.
            ' Returns               :	Client side array definition
            ' Assumptions           :	None.
            ' Dependencies          :	None.
            ' Author                :	UmeshJ
            ' Created               :	November 04,2003
            ' Revisions             :   Jan 19, 2004 Modified By UmeshJ for Issue ID 9233
            '=====================================================================
            If strValidationSQL.Trim = "" Or strExistingValuesArray.Trim = "" Then Return ""

            Dim drValues As IDataReader
            Dim sbArray As New System.Text.StringBuilder
            Dim blnVlaueExists As Boolean = False
            sbArray.Append(vbCrLf + "   var " + strExistingValuesArray + "=new Array(")
            drValues = CommonFunction.Data.GetDataReader(strValidationSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Do While drValues.Read
                If drValues(0).ToString.Trim <> strCurrentValue.Trim Then
                    '###########Modified By UmeshJ for Issue ID 9233 (Jan 19, 2004)
                    'For the DATE datatype remove the TIME part and Compare only DATES
                    If drValues.GetDataTypeName(0).ToUpper = "DATETIME" Or drValues.GetDataTypeName(0).ToUpper = "SMALLDATETIME" Then
                        sbArray.Append(Chr(34) + Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(CommonFunction.Dates.GetDate(CType(CommonFunction.General.CheckIsNothing(drValues(0)), Date)), "\", "\\"), Chr(34), "\" + Chr(34)) + Chr(34) + ",")
                    Else
                        sbArray.Append(Chr(34) + Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(drValues(0).ToString.Trim, "\", "\\"), Chr(34), "\" + Chr(34)) + Chr(34) + ",")
                    End If
                    '###########Modification Ends for Issue ID 9233
                    blnVlaueExists = True
                End If
            Loop
            'Remove Last Comma 
            If blnVlaueExists = True Then sbArray.Remove(sbArray.Length - 1, 1)
            sbArray.Append(");")
            If blnVlaueExists = True Then
                GetExistingValuesArray = sbArray.ToString
            Else
                GetExistingValuesArray = ""
            End If

            'Close
            sbArray = Nothing
            drValues.Dispose()
            drValues.Close()
            drValues = Nothing
        End Function
        ''End of Addition by Dhanashri  Son 29 Oct 2015

    End Class
#End Region
End Namespace