Public Class CLCP_AdvanceFilters
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region


#Region "Global Variables"

    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_strDivTag As String = "divFilters"
    Private Const FORM_NAME As String = "frmAdvFilters"
    Private m_strPageCaption As String = "Advance Filters"
    Private m_strFilterName As String = ""

    Private m_strFilterQuery As String = "" 'User Friendly Filter Query
    Private m_strActualFilterQuery As String = "" 'Actual Filter Query 'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
    Private m_blnIsDatabaseFilter As Boolean 'WAF3_PB_38 -

    Private m_blnIsApplied As Boolean = False
    Private m_lngTagID As Long
    Private m_lngFilterID As Long = 0
    Private m_strResFilterName As String
    Private m_strResFilterQuery As String
    Private m_strMode As String = ""
    Private m_strSubMode As String = ""
    Private m_strErrorMessage As String = ""
    'Added By NiileshD on 9th Aug 2005
    Private m_strClosePage As String = "0"
    '============================================================================================================
    ' Added By        :	Ninad
    ' Added On        :	19 July 2006.
    ' Purpose         : To indicate status of weather filter is applied through view, so as to escape printing Apply related link       
    ' Requirement Tag : WAF3_PB_24 
    '============================================================================================================
    Private m_blnIsFilterAppliedThroughView As Boolean = False
    'To get the master tag id i.e. to know from where request comes, page canvas or from common list

    '============================================================================================================
    'Addition End : By Ninad 
    '============================================================================================================


#End Region

#Region "Global Constants"

    Private Const FUNCTION_HELP_ONCLICK As String = "OpenHelpPage('ADVANCE_FILTER')"
    Private Const FUNCTION_CBOFIELD_ONCHANGE As String = "cboFieldOnchange()"
    Private Const FUNCTION_APPLY_WITHOUT_SAVE_ONCLICK As String = "ApplyWithoutSave_Onclick()"
    Private Const FUNCTION_SAVE_AND_APPLY_ONCLICK As String = "SaveApply_Onclick()"
    Private Const FUNCTION_SAVE_ONCLICK As String = "Save_Onclick()"
    Private Const FUNCTION_REMOVE_ONCLICK As String = "RemoveFilter_Onclick()"
    Private Const FUNCTION_BACK_ONCLICK As String = "Back_Onclick()"
    Private Const FUNCTION_CLOSE_ONCLICK As String = "Close_Onclick()"

    Private Const FUNCTION_APPEND_ONCLICK As String = "Append_OnClick()"
    Private Const FUNCTION_OPEN_BRACKET_ONCLICK As String = "OpenBracket_OnClick()"
    Private Const FUNCTION_CLOSE_BRACKET_ONCLICK As String = "CloseBracket_Onclick()"
    Private Const FUNCTION_AND_ONCLICK As String = "And_Onclick()"
    Private Const FUNCTION_OR_ONCLICK As String = "Or_Onclick()"
    Private Const FUNCTION_CLEARALL_ONCLICK As String = "ClearAll_Onclick()"
    Private Const FUNCTION_VALIDATE_UI As String = "ValidateUI()"
    Private Const FUNCTION_VALIDATE_UI_WITHOUTSAVE As String = "ValidateUIWithoutSave()"

    Private Const MODE_SAVE As String = "SAVE"
    Private Const SUB_MODE_APPLY As String = "APPLY"
    Private Const SUB_MODE_DONOT_APPLY As String = "DONOT_APPLY"
    Private Const MODE_APPLY As String = "APPLY_WITHOUT_SAVE"
    Private Const MODE_REMOVE As String = "REMOVE"
    Dim blnFromCanvas As Boolean = False
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by ninad to get fromcanvas  
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MasterTagID")) = "1840" Then
            blnFromCanvas = True
        ElseIf CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromCanvas")) = "1" Then
            blnFromCanvas = True
        End If
        'Put user code to initialize the page here
        Call GetParameters()
        'Get the WhizGlobal object details
        Call GetGlobalObject()
        'Save and Apply Filter
        Call SaveAndApplyFilter()
        'Get the UI Data
        Call GetUIInformation()
        'Plot the Page Details
        Call PlotPageDetails()
        'Memory Cleanup
        Call MemoryCleanUp()
    End Sub

    Private Function GetOldQueryString(ByVal lngTagID As Long) As String
        '-------------------------------------------------------------------------------------------------------------
        ' Function Name         : GetOldQueryString
        ' Description           : To get the querystring Default parameters
        ' Parameters Passed     : lngTagID - Long 
        ' Returns               : String
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Friday, December 30, 2005
        '-------------------------------------------------------------------------------------------------------------

        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'Get the WhizGlobal object
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = lngTagID
        GetOldQueryString = ""
        GetOldQueryString = CommonFunction.General.GetQueryStringDefaultParameters(objGlobal)
        objGlobal = Nothing

    End Function
    '===============================================================================================================
    ' Added By        :	Ninad
    ' Purpose         : To set the flag m_blnIsFilterAppliedThroughView . 
    ' Description     : To set the flag m_blnIsFilterAppliedThroughView , so as to escape printing Apply
    '                   related links. If filter is applied through view, the value of m_blnIsFilterApplied is 
    '                   set to true and is used while printing apply related links and client side functions
    ' Requirement Tag : WAF3_PB_24 
    ' Added On        :	19 July 2006.
    '===============================================================================================================
    Private Sub CheckFilterApplied()
        Dim strViewID As String = CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableUPFCache(CStr(MyBase.GlobalObject.UserID) + "-" + CStr(MyBase.GlobalObject.LoginType) + "-VIEWS-" + CStr(m_lngTagID)))
        'get view ID of applied view
        Dim objViews As CommonEngines.HashTables.Views
        objViews = CommonEngines.HashTables.GetHashTableObject.GetHashTableViewsObject(strViewID)
        'if view is applied
        If Not objViews Is Nothing Then
            Dim strFilterID As String = objViews.FilterID
            'if filter is applied
            If Not strFilterID = "" Then
                'set the flage 
                m_blnIsFilterAppliedThroughView = True
            End If
        End If
        objViews = Nothing
    End Sub
    '============================================================================================================
    'Addition End : By Ninad 
    '============================================================================================================

    Private Sub GetGlobalObject()
        '=====================================================================
        ' Procedure Name        :	GetGlobalObject
        ' Purpose               :	Get Page Specific WhizGlobal Object
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Jan 29, 2004 
        ' Revisions             :
        '=====================================================================
        'Create the WhizGlobal class object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        'Get the WhizGlobal object
        m_objGlobal = MyBase.GlobalObject
        If m_lngTagID <> 0 Then m_objGlobal.TagID = m_lngTagID
    End Sub

    Private Sub GetParameters()
        '=====================================================================
        ' Procedure Name        :	GetParameters
        ' Purpose               :	Get the request Parameters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 29, 2004
        ' Revisions             :
        '=====================================================================
        'Get the TagID
        If Not Request("TagID") Is Nothing Then m_lngTagID = CType(Request("TagID"), Long)
        If Not Request("Mode") Is Nothing Then m_strMode = Request("Mode").ToString
        If Not Request("SubMode") Is Nothing Then m_strSubMode = Request("SubMode").ToString
        If Not Request("FilterID") Is Nothing Then m_lngFilterID = CType(Request("FilterID"), Long)
    End Sub

    Private Sub SaveAndApplyFilter()
        '=====================================================================
        ' Procedure Name        :	SaveAndApplyFilter
        ' Purpose               :	Save And Apply Filter depending upon the mode
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004 
        ' Modified By           :   Ninad   req TagID.      :   WAF3_PB_24
        ' Revisions             :
        '=====================================================================
        Dim strQueryStringOld As String = ""

        If m_strMode = MODE_SAVE Or m_strMode = MODE_APPLY Then
            'For Save or Apply mode First Validate the Filter Query
            m_strFilterName = MyBase.GetFormValue("txtFilterName", False)

            'Get the User Friendly Filter Query to validate
            m_strFilterQuery = Microsoft.VisualBasic.Strings.Replace(MyBase.GetFormValue("txtFilterQuery", False) & "", vbCrLf, "")



            '-------------------------------------------------------------------------------------------------------------
            'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
            'Reason   - For using Dataset as Webform Grid Datasource.
            '-------------------------------------------------------------------------------------------------------------
            'Get the Actual Filter Query which will be used to filter out "DataSet"
            m_strActualFilterQuery = Microsoft.VisualBasic.Strings.Replace(MyBase.GetFormValue("txtFilterQueryHidden", False) & "", vbCrLf, "")
            'If ((m_strFilterQuery.Contains("< ''")) OrElse (m_strFilterQuery.Contains("> ''")) OrElse (m_strFilterQuery.Contains("= ''"))) Then
            '    Dim intLastIndexOfDash As Integer
            '    Dim strID As String = ""
            '    Dim strTemp As String = ""
            '    Dim strValueWithID As String = ""
            '    Dim strValue As String = ""
            '    intLastIndexOfDash = m_strFilterQuery.IndexOf("<")
            '    'intLastIndexOfDash = m_strFilterQuery.IndexOf(">")
            '    'intLastIndexOfDash = m_strFilterQuery.IndexOf("=")
            '    strValue = m_strFilterQuery.Substring(0, intLastIndexOfDash - 1)
            '    'strTemp = "<=ISNULL(" + strValue + ",'')"
            '    strTemp = " = " + strValue
            '    m_strFilterQuery = m_strFilterQuery.Replace("< ''", strTemp)
            '    'm_strFilterQuery = m_strFilterQuery.Replace("> ''", strTemp)
            '    'm_strFilterQuery = m_strFilterQuery.Replace("= ''", strTemp)


            '    Dim intLastIndexOfDashAF As Integer
            '    Dim strTempAF As String = ""
            '    Dim strValueWithIDAF As String = ""
            '    Dim strValueAF As String = ""
            '    intLastIndexOfDashAF = m_strActualFilterQuery.IndexOf("")
            '    intLastIndexOfDashAF = m_strActualFilterQuery.IndexOf("<")
            '    'intLastIndexOfDashAF = m_strActualFilterQuery.IndexOf(">")
            '    'intLastIndexOfDashAF = m_strActualFilterQuery.IndexOf("=")
            '    strValueAF = m_strActualFilterQuery.Substring(0, intLastIndexOfDashAF - 1)
            '    'strTemp = "<=ISNULL(" + strValue + ",'')"
            '    strTempAF = " = " + strValueAF
            '    m_strActualFilterQuery = m_strActualFilterQuery.Replace("< ''", strTempAF)
            '    ' m_strActualFilterQuery = m_strActualFilterQuery.Replace("> ''", strTempAF)
            '    'm_strActualFilterQuery = m_strActualFilterQuery.Replace("= ''", strTempAF)


            'End If
            'If (m_strFilterQuery.Contains("> ''")) Then
            '    Dim intLastIndexOfDash As Integer
            '    Dim strID As String = ""
            '    Dim strTemp As String = ""
            '    Dim strValueWithID As String = ""
            '    Dim strValue As String = ""
            '    intLastIndexOfDash = m_strFilterQuery.IndexOf(">")
            '    strValue = m_strFilterQuery.Substring(0, intLastIndexOfDash - 1)
            '    'strTemp = ">=ISNULL(" + strValue + ",'')"
            '    strTemp = " = " + strValue
            '    m_strFilterQuery = m_strFilterQuery.Replace("> ''", strTemp)

            '    Dim intLastIndexOfDashAF As Integer
            '    Dim strTempAF As String = ""
            '    Dim strValueWithIDAF As String = ""
            '    Dim strValueAF As String = ""
            '    intLastIndexOfDashAF = m_strActualFilterQuery.IndexOf(">")
            '    strValueAF = m_strActualFilterQuery.Substring(0, intLastIndexOfDashAF - 1)
            '    'strTemp = "<=ISNULL(" + strValue + ",'')"
            '    strTempAF = " = " + strValueAF
            '    m_strActualFilterQuery = m_strActualFilterQuery.Replace("> ''", strTempAF)
            'End If
            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
            '-------------------------------------------------------------------------------------------------------------


            'create filter key
            Dim strFilterKey As String = m_objGlobal.UserID.ToString + "-" + m_objGlobal.LoginType + "-ADVANCE_FILTER-" + m_lngTagID.ToString
            Dim strDataSourceName As String = GetDataSource()

            'Validate User Friendly Filter Query on Database
            Dim strValidationQuery As String = "Select * From " + strDataSourceName + " Where (" + m_strFilterQuery + ")"

            Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
            If CommonFunction.Data.ValidateQuery(strValidationQuery, blnUseSQL) = True Then
                Dim strRefreshCL As String = ""
                'Added By NiileshD on 9th Aug 2005
                m_strClosePage = ""
                'Filter Query is valid
                If m_strMode = MODE_SAVE Then

                    Dim strSQL As String
                    'request come from canvas, then set UserID=-1
                    'UmeshJ 28-Aug-2007; Request ID: 274; DBCS Support START
                    If blnFromCanvas Then
                        strSQL = "usp_Ins_tbl_UI_AdvanceFilters '" + m_lngFilterID.ToString + "','-1','" + m_objGlobal.LoginType + "','" + m_lngTagID.ToString + "',N'" + CommonFunction.General.BuildQueryString(m_strFilterName) + "',N'" + CommonFunction.General.BuildQueryString(m_strFilterQuery) + "'" 'WAF3_PB_38
                    Else
                        strSQL = "usp_Ins_tbl_UI_AdvanceFilters '" + m_lngFilterID.ToString + "','" + m_objGlobal.UserID.ToString + "','" + m_objGlobal.LoginType + "','" + m_lngTagID.ToString + "',N'" + CommonFunction.General.BuildQueryString(m_strFilterName) + "',N'" + CommonFunction.General.BuildQueryString(m_strFilterQuery) + "'"
                    End If

                    '================================================================================================================
                    'Modified by ninad to apply filter
                    'original is commented below
                    'date 26 August  2006
                    'Apply Filter
                    '================================================================================================================
                    'If m_strSubMode = SUB_MODE_APPLY Then strSQL += ",1"
                    'Dim strAppliedFilter As String = ""
                    'strAppliedFilter = CommonFunction.General.CheckIsNothing(Request.QueryString("IsAppliedFilter"), "")
                    'If strAppliedFilter.Trim.ToUpper = "Y" Then
                    '    strAppliedFilter = ",1"
                    '    m_strClosePage = "1"
                    'Else
                    '    strAppliedFilter = ",0"
                    'End If
                    'strSQL += strAppliedFilter
                    'Execute SQL to save the filter into Database


                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                    'Reason   - For using Dataset as Webform Grid Datasource. Passed one more newly added parameter
                    '-------------------------------------------------------------------------------------------------------------
                    strSQL += ",0,N'" + CommonFunction.General.BuildQueryString(m_strActualFilterQuery) + "'"
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                    '-------------------------------------------------------------------------------------------------------------
                    'UmeshJ 28-Aug-2007; Request ID: 274; DBCS Support END
                    'WAF3_PB_38 -
                    If blnFromCanvas = True Then
                        If MyBase.GetFormValue("chkIsDatabaseFilter", False).ToUpper = "ON" Then
                            strSQL += ",1" 'IsDatabaseFilter
                        Else
                            strSQL += ",0" 'IsDatabaseFilter
                        End If
                    Else
                        strSQL += ",0" 'IsDatabaseFilter
                        Session("AdvanceDBFilter" + m_lngTagID.ToString) = "0"
                    End If
                    'WAF3_PB_38 -
                    m_lngFilterID = CLng(CommonFunction.Data.GetSQLDataScalar(strSQL))

                    'If m_strSubMode = SUB_MODE_APPLY Then
                    '    CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strFilterKey, m_lngFilterID.ToString)
                    'End If
                    Dim strAppliedFilter As String = ""
                    strAppliedFilter = CommonFunction.General.CheckIsNothing(Request.QueryString("IsAppliedFilter"), "")
                    If strAppliedFilter.Trim.ToUpper = "Y" Then
                        'CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strFilterKey, m_lngFilterID.ToString)

                        '-------------------------------------------------------------------------------------------------------------
                        'Modified By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                        'Reason      - For using Dataset as Webform Grid Datasource.
                        '              Used Actual Filter Query which does not contain "/* */" and " N' ".
                        '              This query will be used to fire on DataSet.
                        '-------------------------------------------------------------------------------------------------------------
                        'Session("AdvanceFilter" + m_lngTagID.ToString) = m_strFilterQuery
                        Session("AdvanceFilter" + m_lngTagID.ToString) = m_strActualFilterQuery
                        '-------------------------------------------------------------------------------------------------------------
                        'Modification Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                        '-------------------------------------------------------------------------------------------------------------


                        strRefreshCL = "&RefreshCL=1"
                        m_strClosePage = "1"
                        ' Else
                        'CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(strFilterKey)
                    End If
                    '================================================================================================================
                    'Modification end by Ninad
                    '================================================================================================================


                    'Execute SQL to save the filter into Database
                    'CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)
                    'Added By NileshD on 8 Aug 2005
                    'Set the Filter into Session IssueID - 20530,20604
                    'If CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_UI_AdvanceFilters_User_Applied " + m_lngTagID.ToString + "," + CStr(IIf(blnFromCanvas, "-1", m_objGlobal.UserID.ToString)) + ",'" + m_objGlobal.LoginType + "'", blnUseSQL), "-1") = m_lngFilterID.ToString Then
                    '    Session("AdvanceFilter" + m_lngTagID.ToString) = m_strFilterQuery
                    '    strRefreshCL = "&RefreshCL=1"
                    'End If
                    'End Of Addition IssueID - 20535

                    'Refresh Hash Table 
                    'Commented By PushkarK on Aug 09,2005
                    'Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("TagID")), Long))

                    If m_strSubMode = SUB_MODE_APPLY Then
                        'set the filter in UPF cache
                        CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strFilterKey, m_lngFilterID.ToString)
                        'Set the Filter into Session

                        '-------------------------------------------------------------------------------------------------------------
                        'Modified By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                        'Reason      - For using Dataset as Webform Grid Datasource.
                        '              Used Actual Filter Query which does not contain "/* */" and " N' ".
                        '              This query will be used to fire on DataSet.
                        '-------------------------------------------------------------------------------------------------------------
                        'Session("AdvanceFilter" + m_lngTagID.ToString) = m_strFilterQuery
                        Session("AdvanceFilter" + m_lngTagID.ToString) = m_strActualFilterQuery
                        '-------------------------------------------------------------------------------------------------------------
                        'Modification Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                        '-------------------------------------------------------------------------------------------------------------

                        strRefreshCL = "&RefreshCL=1"
                        'Added By NiileshD on 8th Aug 2005
                        m_strClosePage = "1"
                    End If
                ElseIf m_strMode = MODE_APPLY Then
                    'Set the Filter into Session

                    '-------------------------------------------------------------------------------------------------------------
                    'Modified By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                    'Reason      - For using Dataset as Webform Grid Datasource.
                    '              Used Actual Filter Query which does not contain "/* */" and " N' ".
                    '              This query will be used to fire on DataSet.
                    '-------------------------------------------------------------------------------------------------------------
                    'Session("AdvanceFilter" + m_lngTagID.ToString) = m_strFilterQuery
                    Session("AdvanceFilter" + m_lngTagID.ToString) = m_strActualFilterQuery
                    '-------------------------------------------------------------------------------------------------------------
                    'Modification Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                    '-------------------------------------------------------------------------------------------------------------

                    strRefreshCL = "&RefreshCL=1"
                    'Added By NiileshD on 8th Aug 2005
                    m_strClosePage = "1"
                    'Added By NileshD on 8 Aug 2005 IssueID - 20533
                    'clear the applied filter.
                    '    Dim strSQL As String
                    'strSQL = "usp_sel_tbl_UI_AdvanceFilters_SetResetFilter null,0," + m_lngTagID.ToString + "," + m_objGlobal.UserID.ToString + ",'" + m_objGlobal.LoginType + "'"
                    ''strSQL = "usp_sel_tbl_UI_AdvanceFilters_SetResetFilter null,0," + m_lngTagID.ToString + "," + CStr(CommonFunction.Data.GetDataScalar("usp_sel_tbl_UI_AdvanceFilters_GetUserID " + m_lngFilterID.ToString, blnUseSQL)) + ",'" + m_objGlobal.LoginType + "'"
                    '    CommonFunction.Data.GetDataScalar(strSQL, blnUseSQL)
                    '=============================================================================================================
                    'Added by   :   Ninad
                    'Purpose    :   To reset applied filter in UPF cache
                    'Date       :   25 August 2006
                    'Req Tag    :   
                    '=============================================================================================================
                    CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strFilterKey, "")
                    '=============================================================================================================

                    'End Of Addition
                End If
                'Remove unwanted objects from memory
                Call MemoryCleanUp()
                '====================================================================
                ' Modified By           :   PushkarK
                ' Modified On           :   Aug 04, 2005
                '====================================================================

                'Server.Transfer("CommonList.aspx?MasterTagID=" + CommonFunction.Constants.TAG_ADVANCE_FILTERS.ToString + "&TagID=" + m_lngTagID.ToString + strRefreshCL)
                'Changed By NiileshD on 9th Aug 2005
                'Added one parameter to page "ClosePage" for closing the list page

                'Code Added and Modified By - PushkarK on Friday, December 30, 2005 for Issue- FLT_QRY_PARAM added oldQuery string params
                strQueryStringOld = GetOldQueryString(m_lngTagID)
                strQueryStringOld = Replace(Replace(Replace(strQueryStringOld, "\\", "\"), "\'", "'"), "\""", """") 'RequestID : 272 UmeshJ 13 Aug 2007
                'request come from canvas, then set queryString parameter masterTagID=1840 o.w. 1017 - modified by ninad
                If blnFromCanvas Then
                    Response.Redirect("Filter_CommonList.aspx?ConnectionID=" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "&MasterTagID=1840&TagID=" + m_lngTagID.ToString + strRefreshCL + "&ClosePage=" + m_strClosePage + strQueryStringOld)
                Else
                    Response.Redirect("Filter_CommonList.aspx?ConnectionID=" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "&MasterTagID=" + CommonFunction.Constants.TAG_ADVANCE_FILTERS.ToString + "&TagID=" + m_lngTagID.ToString + strRefreshCL + "&ClosePage=" + m_strClosePage + strQueryStringOld)
                End If

                'Code Addition and Modification Ends By - PushkarK on Friday, December 30, 2005 for Issue- FLT_QRY_PARAM added oldQuery string params

                '====================================================================
                ' Modification Ends.
                '====================================================================

            Else
                m_strErrorMessage = MyBase.GetResourceString("ERROR_MESSAGE")
            End If
        ElseIf m_strMode = MODE_REMOVE Then
            '=============================================================================================================
            'Added by   :   Ninad
            'Purpose    :   To reset applied filter in UPF cache
            'Date       :   25 August 2006
            'Req Tag    :   
            '=============================================================================================================
            Dim strFilterKey As String = m_objGlobal.UserID.ToString + "-" + m_objGlobal.LoginType + "-ADVANCE_FILTER-" + CStr(m_lngTagID)
            CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(strFilterKey)
            'CommonEngines.HashTables.CreateHashTables.SetHashTableKeyUPFCache(strFilterKey, m_lngFilterID.ToString)
            '=============================================================================================================

            'Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
            'Dim strSQL As String = "usp_sel_tbl_UI_AdvanceFilters_SetResetFilter '" + m_lngFilterID.ToString + "',0"
            'Dim strSQL As String = "usp_sel_tbl_UI_AdvanceFilters_SetResetFilter '" + m_lngFilterID.ToString + "',0"
            'Execute SQL to Reset the Filter
            'CommonFunction.Data.InsertOrUpdateData(strSQL, blnUseSQL)
            'Reset the Filter from Session
            Session("AdvanceFilter" + m_lngTagID.ToString) = ""
            'Refresh Hash Table

            ' Commented By: PushkarK on Aug 09,2005
            'Call CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(m_lngTagID)

            'No Error so refresh parent and goto filter list page
            Call MemoryCleanUp()

            '====================================================================
            ' Modified By           :   PushkarK
            ' Modified On           :   Aug 04, 2005
            '====================================================================

            'Server.Transfer("CommonList.aspx?RefreshCL=1&MasterTagID=" + CommonFunction.Constants.TAG_ADVANCE_FILTERS.ToString + "&TagID=" + m_lngTagID.ToString)
            'Code Added and Modified By - PushkarK on Friday, December 30, 2005 for Issue- FLT_QRY_PARAM added oldQuery string params
            strQueryStringOld = GetOldQueryString(m_lngTagID)
            strQueryStringOld = Replace(Replace(Replace(strQueryStringOld, "\\", "\"), "\'", "'"), "\""", """") 'RequestID : 272 UmeshJ 13 Aug 2007
            Response.Redirect("Filter_CommonList.aspx?ConnectionID=" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "&RefreshCL=1&MasterTagID=" + CommonFunction.Constants.TAG_ADVANCE_FILTERS.ToString + "&TagID=" + m_lngTagID.ToString + strQueryStringOld)
            'Code Addition and Modification Ends By - PushkarK on Friday, December 30, 2005 for Issue- FLT_QRY_PARAM added oldQuery string params

            '====================================================================
            ' Modification Ends.
            '====================================================================

        End If
    End Sub

    Private Function GetDataSource() As String
        '=====================================================================
        ' Procedure Name        :	GetDataSource
        ' Purpose               :	Get Data Source for the TagID
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	Data Source
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004 
        ' Revisions             :
        '=====================================================================

        If m_objGlobal.UseHashTable = "N" Then
            Dim drTagMaster As IDataReader
            Dim strSQL As String

            'Local culture ID is same as the default culture id
            strSQL = "usp_Sel_v_tbl_UI_TagMaster " + m_lngTagID.ToString
            drTagMaster = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drTagMaster.Read() Then
                'strPageCaption = drTagMaster("TagDescription").ToString
                'If the Relative View is Specified then use it else use the Table Name
                If CommonFunction.Data.CheckIsDBNull(drTagMaster("RelativeView")).ToString <> "" Then
                    GetDataSource = drTagMaster("RelativeView").ToString
                Else
                    GetDataSource = CommonFunction.Data.CheckIsDBNull(drTagMaster("TableName")).ToString
                End If
            End If
            'Destroy the object
            CommonFunction.Data.DisposeDataReader(drTagMaster)
        Else
            Dim objUITagMaster As CommonEngines.HashTables.UITagMaster

            'Local culture ID is same as the default culture id
            objUITagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(CType(m_objGlobal.TagID, Long))
            'Page Details from the hash table
            'strPageCaption = objUITagMaster.TagDescription.ToString
            If CommonFunction.General.CheckIsNothing(objUITagMaster.RelativeView) = "" Then
                GetDataSource = objUITagMaster.TableName.ToString
            Else
                GetDataSource = objUITagMaster.RelativeView.ToString
            End If
            'Destroy the object
            objUITagMaster = Nothing
        End If
    End Function

    Private Sub GetUIInformation()
        '=====================================================================
        ' Procedure Name        :	GetUIInformation
        ' Purpose               :	Get UI Information from the database
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004 
        ' Revisions             :
        '=====================================================================
        If m_lngFilterID <> 0 And (m_strMode <> MODE_SAVE And m_strMode <> MODE_APPLY) Then
            Dim strSQL As String
            Dim drFilter As IDataReader
            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
                'Default
                strSQL = "usp_Sel_tbl_UI_AdvanceFilters '" + m_lngFilterID.ToString + "'"
            Else
                'For Specified Culture
                strSQL = "usp_Sel_tbl_UI_AdvanceFilters '" + m_lngFilterID.ToString + "','" + m_objGlobal.LCID.ToString + "'"
                drFilter = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If Not drFilter.Read Then
                    'Default
                    strSQL = "usp_Sel_tbl_UI_AdvanceFilters '" + m_lngFilterID.ToString + "'"
                Else
                    'Dispose data reader
                    CommonFunction.Data.DisposeDataReader(drFilter)
                End If
            End If

            drFilter = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drFilter.Read() Then
                'Get Filter Details
                m_strFilterName = CommonFunction.Data.CheckIsDBNull(drFilter("FilterName")).ToString

                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                'Reason      - For using Dataset as Webform Grid Datasource. Get the Actual Filter Query 
                '              and User Friendly Filter Query as well
                '-------------------------------------------------------------------------------------------------------------
                'm_strFilterQuery = CommonFunction.Data.CheckIsDBNull(drFilter("FilterQuery")).ToString
                m_strFilterQuery = CommonFunction.Data.CheckIsDBNull(drFilter("UserFriendlyFilterQuery")).ToString

                m_strActualFilterQuery = CommonFunction.Data.CheckIsDBNull(drFilter("FilterQuery")).ToString
                m_blnIsDatabaseFilter = CBool(CommonFunction.Data.CheckIsDBNull(drFilter("IsDatabaseFilter"), "False")) 'WAF3_PB_38 -
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
                '-------------------------------------------------------------------------------------------------------------

                m_blnIsApplied = CType(IIf(CommonFunction.General.CheckIsNothing(Request("IsAppliedFilter"), "") = "Y", True, False), Boolean)
            End If
            'Dispose data reader
            CommonFunction.Data.DisposeDataReader(drFilter)
        End If
    End Sub

    Private Sub PlotPageDetails()
        '=====================================================================
        ' Procedure Name        :	PlotPageDetails
        ' Purpose               :	Plot the page details
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 05, 2004
        ' Revisions             :
        '=====================================================================
        'Create form
        Call CreateForm()
        'Create Hiddeen Parameters to persist the values
        Call CreateHiddenParameters()
        'Check filter is applied or not
        Call CheckFilterApplied()
        'Plot Top Menu
        Call GetMenu()
        'Plot Page Legends
        Call PlotPageLegends()
        'Plot page caption to display msg if filter is applied through view 
        Call PlotPageCaptionForAppliedFilter()
        'Plot Page Caption
        Call PlotPageCaption()
        'Plot UI
        Call PlotUI()
        'Plot Bottom Menu
        Call GetMenu()
        'End form
        Call EndForm()
        'client side
        Call WriteClientsideScript()
    End Sub

    Private Sub CreateForm()
        '=====================================================================
        ' Procedure Name        :	CreateForm
        ' Purpose               :	Create Form tag
        ' Description           :	This method will plot the initial portion 
        '                           for the page and form tag
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2004 
        ' Revisions             :
        '=====================================================================
        ' commented by miiint 23/12/2014
        'Response.Write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>")
        ' added by miint 23/12/2014
        Response.Write("<!DOCTYPE HTML>")
        Response.Write("<HTML>")
        'Page Caption

        ' ***************************************************************************************
        ' Modified Aug 27,2004 Rajanikant Khethawatt R.No.WAF2_PB_32
        ' ***************************************************************************************
        Response.Write(CommonFunction.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_TITLE"), , , , , True, m_objGlobal.TagID))
        ' ***************************************************************************************
        ' End Modification Aug 27,2004 Rajanikant Khethawatt
        ' ***************************************************************************************

        'Issue ID 28888, Modified by PrasannaP.
        'Response.Write("<BODY class='clsBody' onload='window_onload()' onresize='window_onresize()' ><FORM name='" + FORM_NAME + "' method=post>")
        'WAF3_PB_42 April 16, 2007 UmeshJ pass parameter value 30 as Fill Factor to the functions in .js
        Response.Write("<BODY class='clsBody' onload='window_onload(30)' onresize='window_onresize(30)' ><FORM id='" + FORM_NAME + "' name='" + FORM_NAME + "' method=post>")
    End Sub

    Private Sub EndForm()
        'Form End Tag
        Response.Write("</FORM></BODY></HTML>")
    End Sub

    Private Sub GetMenu()
        '=====================================================================
        ' Procedure Name        :	GetMenu
        ' Purpose               :	Plot menu on the page
        ' Description           :	This method will plot the menu
        ' Parameters Passed     :	None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 28, 2004 
        ' Revisions             :
        '=====================================================================
        Dim arrlstMenu As New System.Collections.ArrayList
        Dim arrlstMenuToolTip As New System.Collections.ArrayList
        Dim arrlstMenuFunction As New System.Collections.ArrayList

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - To show Images for static menu. 
        '-------------------------------------------------------------------------------------------------------------
        Dim arrlstImagePaths As New System.Collections.ArrayList
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------


        '=====================================================================
        ' Added By        :	Ninad
        ' Added On        :	19 July 2006.
        ' Purpose         : To escape printing Apply Without Save,Save And Apply, Remove link if filter is applied through view      
        ' Requirement Tag : WAF3_PB_24 
        '=====================================================================
        If Not blnFromCanvas Then
            'request come from page canvas then do not print apply related link i. apply without save, save and apply
            If Not m_blnIsFilterAppliedThroughView Then
                'Add Menu Items
                arrlstMenu.Add(MyBase.GetResourceString("MENU_WITHOUTSAVE"))
                arrlstMenu.Add(MyBase.GetResourceString("MENU_SAVE_AND_APPLY"))

                'Add Menu Tooltip items
                arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_WITHOUTSAVE_TOOLTIP"))
                arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_AND_APPLY_TOOLTIP"))
                'Add Menu client side function name items
                arrlstMenuFunction.Add(FUNCTION_APPLY_WITHOUT_SAVE_ONCLICK)
                arrlstMenuFunction.Add(FUNCTION_SAVE_AND_APPLY_ONCLICK)

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrlstImagePaths.Add("../../Images/cssImages/Link images/apply.gif")
                arrlstImagePaths.Add("../../Images/cssImages/Link images/saveapply.gif")
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                If m_blnIsApplied = True Then
                    'If the Filter is applied then only show the Remove Filter link
                    arrlstMenu.Add(" " + MyBase.GetResourceString("MENU_REMOVE"))
                    arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_REMOVE_TOOLTIP"))
                    arrlstMenuFunction.Add(FUNCTION_REMOVE_ONCLICK)
                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrlstImagePaths.Add("../../Images/cssImages/Link images/clearFilter.gif")
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    '-------------------------------------------------------------------------------------------------------------
                End If
            End If
        End If
        'Not to show save link in edit mode of filter applied through view   
        'If Not (m_blnIsApplied And m_blnIsFilterAppliedThroughView) Then
        'Add Menu Items
        arrlstMenu.Add(" " + MyBase.GetResourceString("MENU_SAVE"))

        'Add Menu Tooltip items
        arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))

        'Add Menu client side function name items
        arrlstMenuFunction.Add(FUNCTION_SAVE_ONCLICK)
        'End If

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - To show Images for static menu. 
        '-------------------------------------------------------------------------------------------------------------
        arrlstImagePaths.Add("../../Images/cssImages/Link images/save.gif")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------

        '============================================================================================================
        'Addition End : By Ninad 
        '============================================================================================================

        'Add Menu Items
        arrlstMenu.Add(MyBase.GetResourceString("MENU_BACK"))
        arrlstMenu.Add(MyBase.GetResourceString("MENU_CLOSE"))
        arrlstMenu.Add(MyBase.GetResourceString("MENU_HELP"))

        'Add Menu Tooltip items
        arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_BACK_TOOLTIP"))
        arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        arrlstMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        'Add Menu client side function name items
        arrlstMenuFunction.Add(FUNCTION_BACK_ONCLICK)
        arrlstMenuFunction.Add(FUNCTION_CLOSE_ONCLICK)
        arrlstMenuFunction.Add(FUNCTION_HELP_ONCLICK)

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - To show Images for static menu. 
        '-------------------------------------------------------------------------------------------------------------
        arrlstImagePaths.Add("../../Images/cssImages/Link images/back.gif")
        arrlstImagePaths.Add("../../Images/cssImages/Link images/close.gif")
        arrlstImagePaths.Add("../../Images/cssImages/Link images/help.gif")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------

        'Copy Arrat list Menu items to Menu array
        Dim arrMenu(arrlstMenu.Count - 1) As String
        arrlstMenu.CopyTo(arrMenu)
        arrlstMenu = Nothing

        'Copy Arrat list Menu tool tip items to Menu array
        Dim arrMenuTooltip(arrlstMenuToolTip.Count - 1) As String
        arrlstMenuToolTip.CopyTo(arrMenuTooltip)
        arrlstMenuToolTip = Nothing

        'Copy Arrat list Menu function items to Menu array
        Dim arrClientSideFunctions(arrlstMenuFunction.Count - 1) As String
        arrlstMenuFunction.CopyTo(arrClientSideFunctions)
        arrlstMenu = Nothing

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - To show Images for static menu. 
        '-------------------------------------------------------------------------------------------------------------
        Dim arrImagePaths(arrlstImagePaths.Count - 1) As String
        arrlstImagePaths.CopyTo(arrImagePaths)
        arrlstImagePaths = Nothing
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------

        'Plot menu
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - To show Images for static menu, added parameter - arrImagePaths
        '-------------------------------------------------------------------------------------------------------------
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True, , , arrImagePaths)
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - Set the arrays to nothing. 
        '-------------------------------------------------------------------------------------------------------------
        arrMenu = Nothing
        arrMenuTooltip = Nothing
        arrClientSideFunctions = Nothing
        arrImagePaths = Nothing
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------

        Response.Write(strMenu)
    End Sub

    Private Sub PlotUI()
        '=====================================================================
        ' Procedure Name        :	PlotUI
        ' Purpose               :	Plot the UI
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Jan 29, 2004 
        ' Revisions             :
        '=====================================================================
        'Added by Vinay on 08 DEC. 2008 WAF3_GEN_18
        Dim strDirection As String = ""
        Dim strRTLDirection As String = ""
        Dim strDivDirection As String = ""
        If CommonFunctions.General.CheckIsRTLCultureSupported = True Then
            strDirection = "right"
            strRTLDirection = "left"
            strDivDirection = "rtl"
        Else
            strDirection = "left"
            strRTLDirection = "right"
            strDivDirection = ""
        End If
        'Addtion End by Vinay on 08  DEC. 2008 WAF3_GEN_18

        ' CommonFunction.General.WriteHTML("<DIV dir=" + strDivDirection + " Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:400px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        ''Modified by swapnil aswale on 2-oct-2015 for [UI Issue increase height 400px to 510px]
        CommonFunction.General.WriteHTML("<DIV dir=" + strDivDirection + " Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:510px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        ''Ended by swapnil aswale on 2-oct-2015 for [UI Issue increase height 400px to 510px]
        CommonFunction.General.WriteHTML("<Table cellspacing=0 cellpadding=0 class=clsTable width='100%'>")
        'Filter Name
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD align=" + strRTLDirection + ">" + MyBase.GetResourceString("CONTROL_FILTERNAME") + "</TD><TD colspan=4>" + CommonFunction.HTMLControls.DrawTextBox("txtFilterName", "txtFilterName", , 500, 500, m_strFilterName, , , , , , , , True, True) + "</TD>")
        'WAF3_PB_38 -
        If blnFromCanvas = False Then
            CommonFunction.General.WriteHTML("<TD colspan=2></TD>")
        Else
            Dim strTooltip As String = "If selected, then the advance filter will be applied on the database, otherwise it will be applied on the Dataset. As applying filter on Dataset has some limitations, hence the Query will not be allowed to enter manually."
            CommonFunction.General.WriteHTML("<TD align=" + strRTLDirection + " Title='" + strTooltip + "'>Is Database Filter</TD><TD Title='" + strTooltip + "'>" + CommonFunction.HTMLControls.DrawCheckBox("chkIsDatabaseFilter", "chkIsDatabaseFilter", , m_blnIsDatabaseFilter, applyValueProperty:=False, ToBeInserted:="onclick='javascript:chkIsDatabaseFilterOnClick()'", returnHTML:=True) + "</TD>")
        End If
        'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("</TR>")
        'Prepare Filter Condition
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        'Select Field
        Dim strSelectFieldSQL As String
        Dim strControlTypeSQL As String = "usp_sel_tbl_UI_AdvanceFilters_ControlTypes " + m_objGlobal.TagID.ToString
        Dim strDataTypeSQL As String = "usp_sel_tbl_UI_AdvanceFilters_DataTypes " + m_objGlobal.TagID.ToString
        Dim strCheckboxSQL As String = "usp_sel_tbl_UI_AdvanceFilters_CheckboxValues"

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Default Culture
            strSelectFieldSQL = "usp_sel_tbl_UI_AdvanceFilters_SelectFields " + m_objGlobal.TagID.ToString
        Else
            'Different Culture
            strSelectFieldSQL = "usp_sel_tbl_UI_AdvanceFilters_SelectFields " + m_objGlobal.TagID.ToString + "," + m_objGlobal.LCID.ToString
        End If

        'The select field combo contains FieldName as value and Field Caption as display value...the CONTROL TYPE combo is hidden and has Field Name as value and Control Type ID as display value..this combo contains Control Type Id entries corresponding to the Select Field combo list
        CommonFunction.General.WriteHTML("<TD align=" + strRTLDirection + ">" + MyBase.GetResourceString("CONTROL_SELECTFIELD") + "</TD><TD>" + CommonFunction.HTMLControls.DrawComboBox("cboField", strSelectFieldSQL, 200, , "onchange=Javascript:" + FUNCTION_CBOFIELD_ONCHANGE, True, True) + CommonFunction.HTMLControls.DrawComboBox("cboControlType", strControlTypeSQL, 150, , "style='display:none;'", True, True) + CommonFunction.HTMLControls.DrawComboBox("cboDataType", strDataTypeSQL, 150, , "style='display:none;'", True, True) + "</TD>")

        'Operator
        CommonFunction.General.WriteHTML("<TD align=" + strRTLDirection + ">" + MyBase.GetResourceString("CONTROL_OPERATOR") + "</TD><TD>" + CommonFunction.HTMLControls.DrawComboBox("cboOperator", "usp_sel_tbl_UI_AdvanceFilters_Operators", , "=", , , True) + "</TD>")

        'Value....has a hidden calendar control that will be displayed for the DATE field 
        'Added by VinayB on 14-APR-2009 Purpose:-Applying Date Format According to Application Setting 3.0.06.P.Y-SP12-WAF IssueID->30061
        CommonFunction.General.WriteHTML("<TD align=" + strRTLDirection + ">" + MyBase.GetResourceString("CONTROL_VALUE") + "</TD><TD>" + CommonFunction.HTMLControls.DrawTextBox("txtValue", "txtValue", , 150, 500, , , , , , , , , True, ) + CommonFunction.HTMLControls.DrawComboBox("cboCheckBox", strCheckboxSQL, , , "style='display:none;'", , True) + "&nbsp;<A id=dt style='display:none' Href='#' onclick=""javascript:callcalendar('" + FORM_NAME + "','txtValue')""><Image BORDER=0 src='../../Images/Calendar.gif' alt=''title='" + CommonFunctions.Application.InputeDateFormat + "'></A></TD>") 'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert  

        'Append link
        CommonFunction.General.WriteHTML("<TD>" + "|&nbsp;" + DrawLink(MyBase.GetResourceString("LINK_APPEND"), FUNCTION_APPEND_ONCLICK, MyBase.GetResourceString("LINK_APPEND_TOOLTIP")) + "&nbsp;|" + "</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        'Insert ( ) AND OR
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD colspan=5></TD><TD align=" + strRTLDirection + " colspan=2>" + MyBase.GetResourceString("LABEL_INSERT") + "&nbsp;:&nbsp;|&nbsp;&nbsp;" + DrawLink("(", FUNCTION_OPEN_BRACKET_ONCLICK, MyBase.GetResourceString("LINK_OPEN_BRACKET_TOOLTIP")) + "&nbsp;&nbsp;|&nbsp;&nbsp;" + DrawLink(")", FUNCTION_CLOSE_BRACKET_ONCLICK, MyBase.GetResourceString("LINK_CLOSE_BRACKET_TOOLTIP")) + "&nbsp;&nbsp;|&nbsp;&nbsp;" + DrawLink(MyBase.GetResourceString("LINK_AND"), FUNCTION_AND_ONCLICK, MyBase.GetResourceString("LINK_AND_TOOLTIP")) + "&nbsp;&nbsp;|&nbsp;&nbsp;" + DrawLink(MyBase.GetResourceString("LINK_OR"), FUNCTION_OR_ONCLICK, MyBase.GetResourceString("LINK_OR_TOOLTIP")) + "&nbsp;&nbsp;|" + "</TD>")
        CommonFunction.General.WriteHTML("</TR>")

        'Filter Query

        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason      - For using Dataset as Webform Grid Datasource.
        '              Disable the Text Area. This control will be used as UserFriendly FilterQuery.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD valign=Top align=" + strRTLDirection + ">" + MyBase.GetResourceString("CONTROL_FILTERQUERY") + "</TD><TD colspan=6>" + CommonFunction.HTMLControls.DrawTextArea("txtFilterQuery", "txtFilterQuery", MyBase.GetResourceString("CONTROL_FILTERQUERY"), , "", FORM_NAME, "", "", 500, 100, , m_strFilterQuery, , , , CBool(IIf(m_blnIsDatabaseFilter = True, False, True)), , , , True, True) + "</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------


        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource.
        '-------------------------------------------------------------------------------------------------------------
        'Filter Query
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFilterQueryHidden", "txtFilterQueryHidden", , , , m_strActualFilterQuery, , , , , , True, , True))
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------


        'Clear All
        CommonFunction.General.WriteHTML("<TR class=clsTREven>")
        CommonFunction.General.WriteHTML("<TD colspan=5></TD><TD colspan=2 align=" + strRTLDirection + ">|&nbsp;" + DrawLink(MyBase.GetResourceString("LINK_CLEARALL"), FUNCTION_CLEARALL_ONCLICK, MyBase.GetResourceString("LINK_CLEARALL_TOOLTIP")) + "&nbsp;|" + "</TD>") 'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("</TR>")

        CommonFunction.General.WriteHTML("</TABLE>")

        'Error Message
        If m_strErrorMessage.Trim <> "" Then
            CommonFunction.General.WriteHTML("<BR><BR><TABLE width='100%' cellspacing=0 cellpadding=0>")
            CommonFunction.General.WriteHTML("<TR class=clsTREven>")
            CommonFunction.General.WriteHTML("<TD align=center><B><FONT COLOR=RED>" + m_strErrorMessage + "</FONT></B></TD>")
            CommonFunction.General.WriteHTML("</TR></TABLE>")
        End If
        CommonFunction.General.WriteHTML("</DIV>")
    End Sub

    Private Function DrawLink(ByVal strLinkName As String, ByVal strLinkFunction As String, Optional ByVal strLinkTooltip As String = "") As String
        '=====================================================================
        ' Procedure Name        :	DrawLink
        ' Purpose               :	Draw Link 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 24, 2004
        ' Revisions             :
        '=====================================================================
        Dim objLink As New WebPages.UI.cDynamicLink(m_objGlobal)
        With objLink
            .LinkName = "<B>" + strLinkName + "</B>"
            'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
            .FunctionName = strLinkFunction
            .OtherProperties = ""
            'End Modification By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
            .Tooltip = strLinkTooltip
            .LinkStyle = "TEXT-DECORATION:none;"
            .ReturnHTML = True
            DrawLink = .GetDynamicLink()
        End With
        objLink = Nothing
    End Function

    Private Sub CreateHiddenParameters()
        '=====================================================================
        ' Procedure Name        :	CreateHiddenParameters
        ' Purpose               :	Create hidden Controls to hold the parameter 
        '                           values for which state needs to be persisted
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004
        ' Revisions             :
        '=====================================================================
        'hidden Controls to hold the parameter values 
        Response.Write("<INPUT type=hidden name='TagID' value='" + m_lngTagID.ToString + "'>")
        Response.Write("<INPUT type=hidden name='FilterID' value='" + m_lngFilterID.ToString + "'>")
        '==========================================================================================================
        'Added By NinadP :	17 Nov 2006 : Requirement Tag - WAF3_PB_33 
        Response.Write("<INPUT type=hidden id='ConnectionID' name='ConnectionID' value='" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "'>")
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================

    End Sub

    Private Sub PlotPageLegends()
        '=====================================================================
        ' Procedure Name        :	PlotPageLegends
        ' Purpose               :	Plot the Page Legends
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 12, 2004
        ' Revisions             :
        '=====================================================================
        Dim cObjPageLegends As New WebPage.Templates.PageLegends
        Dim strHTMLTagImageArray As String() = {CommonFunction.HTMLControls.DrawMandatoryImage(, True)}
        Dim strHTMLTagCaptionArray As String() = {MyBase.GetResourceString("Mandatory")}
        Response.Write(cObjPageLegends.DrawPageLegends(m_objGlobal, strHTMLTagImageArray, strHTMLTagCaptionArray, False, ""))
        'Destroy the object
        cObjPageLegends = Nothing
    End Sub
    Private Sub PlotPageCaptionForAppliedFilter()
        '=====================================================================
        ' Procedure Name        :	PlotPageCaptionForAppliedFilter
        ' Purpose               :	To plot page caption to tell user about filter is applied through view, so he/she can't apply filter
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Ninad 
        ' Created               :	25 July 2006 
        ' Revisions             :
        '=====================================================================
        'Added by Vinay on 08 DEC. 2008 WAF3_GEN_18
        Dim strDirection As String = ""
        If CommonFunctions.General.CheckIsRTLCultureSupported = True Then
            strDirection = "right"
        Else
            strDirection = "left"
        End If
        'Addtion End by Vinay on 08  DEC. 2008 WAF3_GEN_18
        If m_blnIsFilterAppliedThroughView Then
            Dim HEADER_MESSAGE_FOR_VIEW As String
            HEADER_MESSAGE_FOR_VIEW = MyBase.GetResourceString("HEADER_MESSAGE_FOR_VIEW")
            Dim strHTML As String = "<TABLE  Width='100%' cellspacing=0 class=clsTable><TR class=clsTRPageHeader><TD align=" + strDirection + ">" + HEADER_MESSAGE_FOR_VIEW + "</TD></TR></TABLE><BR>"
            Response.Write(strHTML)
        End If
    End Sub
    Private Sub PlotPageCaption()
        '=====================================================================
        ' Procedure Name        :	PlotPageCaption
        ' Purpose               :	Plot the Page Caption
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 12, 2004
        ' Revisions             :
        '=====================================================================

        Dim cObjPageCaption As New WebPage.Templates.PageCaption
        Response.Write(cObjPageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_TITLE"), "", ""))
        Response.Write("<BR>")
        'Destroy the object
        cObjPageCaption = Nothing
    End Sub

    Private Sub WriteClientsideScript()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2004
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        'Added by Ninad, WAF3_PB_64
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
            Response.Write("var blnShowNavigationAlert = true;")
            Response.Write("window.onbeforeunload = confirmExit;")
            Response.Write("var strContainerDivs = 'divFilters';")
            Response.Write("blnNavigate = null;")
        End If
        'End Addition by Ninad, WAF3_PB_64
        'Create the form object...will be used throughout the clientside scripts
        Response.Write(vbCrLf + "   var objfrm;")
        Response.Write(vbCrLf + "   var objdivlist;")
        Response.Write(vbCrLf + "   objfrm = GetFormReference('" + FORM_NAME + "')")
        Response.Write(vbCrLf + "   objdivlist=GetObjectReference('" + FORM_NAME + "','" + m_strDivTag + "')" + vbCrLf)
        'Window_OnResize and Window_OnReload
        'WAF3_PB_42 April 16, 2007 UmeshJ Remove local functions, use these from .js
        'Call WriteClientsideScript_WindowOnload_Resize()
        'Set focus on first control
        Call WriteClientsideScript_SetFocus()
        'cboFieldOnChange
        Call WriteClientsideScript_cboFieldOnChange()
        ''AppendOmclick
        Call WriteClientsideScript_AppendOnClick()
        'OpenBracketOnClick
        Call WriteClientsideScript_OpenBracketOnClick()
        'CloseBracketOnClick
        Call WriteClientsideScript_CloseBracketOnClick()
        'ANDOnClick
        Call WriteClientsideScript_ANDOnClick()
        'OROnClick
        Call WriteClientsideScript_OROnClick()
        'ClearAllOnClick
        Call WriteClientsideScript_ClearAllOnClick()
        'Validation Resources
        Call InitializeValidationResources()
        'close
        Call WriteClientsideScript_CloseOnClick()
        'back
        Call WriteClientsideScript_BackOnClick()
        '=====================================================================
        ' Added By        :	Ninad
        ' Added On        :	19 July 2006.
        ' Purpose         : To escape printing Apply related scripts,  if filter is applied through view      
        ' Requirement Tag : WAF3_PB_24 
        '=====================================================================
        'if request come from page canvas then do not print these fun
        If Not blnFromCanvas Then
            'if filter is applied through then do not print these fun
            If Not m_blnIsFilterAppliedThroughView Then
                'Validate UI For Apply Without Save
                Call WriteClientsideScript_ValidateUIWithoutSave()
                'Save and Apply Filter
                Call WriteClientsideScript_SaveAndApplyOnClick()
                'Apply without saving
                Call WriteClientsideScript_ApplyWithoutSaveClick()
                'Remove Filter
                Call WriteClientsideScript_RemoveOnClick()
            End If
        Else
            Call WriteClientsideScript_chkIsDatabaseFilterOnClick() 'WAF3_PB_38 -
        End If
        'If Filter is applied through view and is in edit mode, then don't  write client side script to validate and save
        'If Not (m_blnIsApplied And m_blnIsFilterAppliedThroughView) Then
        'Validate UI
        Call WriteClientsideScript_ValidateUI()
        'Save onclick
        Call WriteClientsideScript_SaveOnClick()
        'End If
        '============================================================================================================
        'Addition End : By Ninad 
        '============================================================================================================
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
    End Sub
    Private Sub WriteClientsideScript_SetFocus()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SetFocus
        ' Purpose               :	WriteClientsideScript to SetFocus on first control
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2004
        ' Revisions             :
        '=====================================================================
        CommonFunction.General.WriteHTML("var objFirstControl = GetObjectReference('" + FORM_NAME + "','txtFilterName')")
        CommonFunction.General.WriteHTML("if (objFirstControl!=null) {objFirstControl.focus();}")
    End Sub
    'Private Sub WriteClientsideScript_WindowOnload_Resize()
    '    '=====================================================================
    '    ' Procedure Name        :	WriteClientsideScript_WindowOnload_Resize
    '    ' Purpose               :	Write Clientside Script 
    '    ' Description           :	Same as above
    '    ' Parameters Passed     :	None.
    '    ' Parameters Affected   :	None.
    '    ' Returns               :	None
    '    ' Assumptions           :	None.
    '    ' Dependencies          :	None.
    '    ' Author                :	UmeshJ
    '    ' Created               :	October 18, 2004
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim intHeightFactor As Integer = 42

    '    CommonFunction.General.WriteHTML("//window resize for Common list")
    '    CommonFunction.General.WriteHTML("	function window_onresize()")
    '    CommonFunction.General.WriteHTML("	{")
    '    CommonFunction.General.WriteHTML("		var intDivHeight ;")
    '    CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
    '    CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
    '    CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
    '    CommonFunction.General.WriteHTML("			intDivHeight = 100;")
    '    CommonFunction.General.WriteHTML("				")
    '    CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
    '    CommonFunction.General.WriteHTML("	}")

    '    CommonFunction.General.WriteHTML("	//window onload for Common list")
    '    CommonFunction.General.WriteHTML("	function window_onload()")
    '    CommonFunction.General.WriteHTML("	{")
    '    CommonFunction.General.WriteHTML("		var intDivHeight ;")
    '    CommonFunction.General.WriteHTML("		var intDivHeightRisk;")
    '    CommonFunction.General.WriteHTML("		var lc;")
    '    CommonFunction.General.WriteHTML("		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
    '    CommonFunction.General.WriteHTML("		if (intDivHeight < 100)")
    '    CommonFunction.General.WriteHTML("			intDivHeight = 100;")
    '    CommonFunction.General.WriteHTML("		objdivlist.style.height = intDivHeight	;")
    '    CommonFunction.General.WriteHTML("	}")
    'End Sub

    Private Sub WriteClientsideScript_cboFieldOnChange()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_cboFieldOnChange
        ' Purpose               :	Write Clientside Script for function cboFieldOnChange
        ' Description           :	This function will dynamicaly change the disaply of the Value 
        '                           text box depending upon the type of the selected field. 
        '                           For date control it will disaply the calendar control
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 29, 2004
        ' Revisions             :   PrasannaP on 18th May 2005. IssueID 18968
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_CBOFIELD_ONCHANGE + " {")
        CommonFunction.General.WriteHTML("  var objcboField=GetObjectReference('" + FORM_NAME + "','cboField')")
        CommonFunction.General.WriteHTML("  var objcboControlType=GetObjectReference('" + FORM_NAME + "','cboControlType')")
        CommonFunction.General.WriteHTML("  var objValue=GetObjectReference('" + FORM_NAME + "','txtValue')")
        CommonFunction.General.WriteHTML("  objValue.readOnly=false;")
        'Field is selected
        CommonFunction.General.WriteHTML("  if (objcboField.selectedIndex != -1) { ")
        'Field is of DATE Type..display calendar control and make the value text box as disabled
        CommonFunction.General.WriteHTML("      var objcboCheckBox=GetObjectReference('" + FORM_NAME + "','cboCheckBox')")
        '---------------------------------------------------------------------------------------------------------------------------------
        'modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("      var strInnerText")
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') {")
        CommonFunction.General.WriteHTML("     strInnerText = objcboControlType.options[objcboField.selectedIndex].innerHTML; }")
        CommonFunction.General.WriteHTML("     else {")
        CommonFunction.General.WriteHTML("     strInnerText = objcboControlType.options(objcboField.selectedIndex).innerText; }")
        CommonFunction.General.WriteHTML("     if( strInnerText == " + CommonFunction.Constants.CONTROL_TYPE_DATE.ToString + ") {")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '---------------------------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("          var objDt=GetObjectReference('" + FORM_NAME + "','dt')")
        CommonFunction.General.WriteHTML("          objDt.style.display = """";")
        CommonFunction.General.WriteHTML("          objValue.style.display = """";")
        CommonFunction.General.WriteHTML("          objValue.readOnly=true;")
        CommonFunction.General.WriteHTML("          objValue.style.width = ""80px"";")
        CommonFunction.General.WriteHTML("          objcboCheckBox.style.display = ""none"";")
        CommonFunction.General.WriteHTML("      }")
        'Field is NOT of DATE Type but a Check box type..hide calendar control and make the value text box as enable
        'hide txtValue show cboCheckBox
        CommonFunction.General.WriteHTML("     else if(strInnerText == " + CommonFunction.Constants.CONTROL_TYPE_CHECK_BOX.ToString + ") {")
        CommonFunction.General.WriteHTML("          objcboCheckBox.style.display = """";")
        CommonFunction.General.WriteHTML("          objcboCheckBox.value = 0;")
        CommonFunction.General.WriteHTML("          var objDt=GetObjectReference('" + FORM_NAME + "','dt')")
        CommonFunction.General.WriteHTML("          objDt.style.display = ""none"";")
        CommonFunction.General.WriteHTML("          objValue.style.display = ""none"";")
        CommonFunction.General.WriteHTML("      }")
        'Field is NOT of DATE Type..hide calendar control and make the value text box as enable
        CommonFunction.General.WriteHTML("      else {")
        CommonFunction.General.WriteHTML("          var objDt=GetObjectReference('" + FORM_NAME + "','dt')")
        CommonFunction.General.WriteHTML("          objDt.style.display = ""none"";")
        CommonFunction.General.WriteHTML("          objValue.style.display = """";")
        CommonFunction.General.WriteHTML("          objValue.disabled = false;")
        CommonFunction.General.WriteHTML("          objValue.style.width = ""150px"";")
        CommonFunction.General.WriteHTML("          objcboCheckBox.style.display = ""none"";")
        CommonFunction.General.WriteHTML("  }")
        CommonFunction.General.WriteHTML(" }")
        CommonFunction.General.WriteHTML(" objValue.value="""";")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_AppendOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_AppendOnClick
        ' Purpose               :	Write Clientside Script for function Append Onclick
        ' Description           :	Append the selected filter condition to the existing one
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================

        CommonFunction.General.WriteHTML("function " + FUNCTION_APPEND_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  var objcboField=GetObjectReference('" + FORM_NAME + "','cboField')")
        CommonFunction.General.WriteHTML("  var objcboControlType=GetObjectReference('" + FORM_NAME + "','cboControlType')")
        CommonFunction.General.WriteHTML("  if (disallowBlank(objcboField,'\'Select Field\' should not be left blank.') == true) { return; }")
        CommonFunction.General.WriteHTML("  var objcboOp=GetObjectReference('" + FORM_NAME + "','cboOperator')")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")


        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------
        '---------------------------------------------------------------------------------------------------------------------------------
        'modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("      var objValue=GetObjectReference('" + FORM_NAME + "','txtValue')")
        'For the NUMERIC data types do not non numeric data
        CommonFunction.General.WriteHTML("      var objcboDataType=GetObjectReference('" + FORM_NAME + "','cboDataType')")
        CommonFunction.General.WriteHTML("      var strInnerText;")
        CommonFunction.General.WriteHTML("      var strInnerTextcboField;")
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') {")
        CommonFunction.General.WriteHTML("     strInnerText = objcboControlType.options[objcboField.selectedIndex].innerHTML; ")
        CommonFunction.General.WriteHTML("     strInnerTextcboField = objcboField[objcboField.selectedIndex].innerHTML; ")
        CommonFunction.General.WriteHTML("     strInnerTextField = objcboControlType[objcboField.selectedIndex].innerHTML;")
        CommonFunction.General.WriteHTML("     strInnerDataTypeField = objcboDataType[objcboField.selectedIndex].innerHTML; }")

        CommonFunction.General.WriteHTML("     else {")
        CommonFunction.General.WriteHTML("     strInnerText = objcboControlType.options(objcboField.selectedIndex).innerText; ")
        CommonFunction.General.WriteHTML("     strInnerTextField = objcboControlType(objcboField.selectedIndex).innerText; ")
        CommonFunction.General.WriteHTML("     strInnerTextcboField = objcboField(objcboField.selectedIndex).innerText; ")
        CommonFunction.General.WriteHTML("     strInnerDataTypeField = objcboDataType(objcboField.selectedIndex).innerText; }")


        CommonFunction.General.WriteHTML("  if ( strInnerText != " + CommonFunction.Constants.CONTROL_TYPE_CHECK_BOX.ToString + " ) {")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '---------------------------------------------------------------------------------------------------------------------------------

        'CommonFunction.General.WriteHTML("  if (objcboControlType(objcboField.selectedIndex).innerText != " + CommonFunction.Constants.CONTROL_TYPE_CHECK_BOX.ToString + " ) {")
        'CommonFunction.General.WriteHTML("      var objValue=GetObjectReference('" + FORM_NAME + "','txtValue')")
        ''For the NUMERIC data types do not non numeric data
        'CommonFunction.General.WriteHTML("      var objcboDataType=GetObjectReference('" + FORM_NAME + "','cboDataType')")
        CommonFunction.General.WriteHTML("      var strVal = objValue.value;")
        CommonFunction.General.WriteHTML("      if(disallowBlank(objValue) == false && strInnerDataTypeField == " + CommonFunction.Constants.FIELD_DATA_TYPE_NUMERIC.ToString + ") {")
        'Changed BY NileshD on 14 Sep 2005 For Support Req ID - 19
        CommonFunction.General.WriteHTML("          if (disallowNonNumeric(objValue,""Please enter numeric value only!!"") == true) {return;}")
        'End Of Changed BY NileshD on 14 Sep 2005 For Support Req ID - 19
        CommonFunction.General.WriteHTML("      }")
        'WAF3_PB_38 Dataset UJ 30-Jan-07 Start
        CommonFunction.General.WriteHTML("      if(strInnerDataTypeField == " + CommonFunction.Constants.FIELD_DATA_TYPE_NUMERIC.ToString + ") {")
        CommonFunction.General.WriteHTML("          if (objcboOp.value==""LIKE"" || objcboOp.value==""NOT LIKE"") {alert(""'LIKE' and 'NOT LIKE' operators are not applicable for the numeric field '"" + strInnerTextcboField +""'."");setFocus(objcboOp);return;}")
        'Added By Vinay on 08 Spet. 2008 Issue Id->19981
        CommonFunction.General.WriteHTML("  strVal = Trim(objValue.value);")
        CommonFunction.General.WriteHTML("if(strVal==''){alert(""Value for Numeric field '"" + strInnerTextcboField +""' should not be left blank."");return;}}")
        'Addition End By Vinay Issue Id->19981
        'For Date field LIKE / NOT LIKE are not allowed
        CommonFunction.General.WriteHTML("  if (strInnerTextField == " + CommonFunction.Constants.CONTROL_TYPE_DATE.ToString + " ) {")
        CommonFunction.General.WriteHTML("  if (objcboOp.value==""LIKE"" || objcboOp.value==""NOT LIKE"") {alert(""'LIKE' and 'NOT LIKE' operators are not applicable for the date field '"" + strInnerTextcboField +""'."");setFocus(objcboOp);return;}")
        'Added By Vinay on 08 Spet. 2008 Issue Id->19981
        CommonFunction.General.WriteHTML("if(strVal==''){alert(""Value for Date field '"" + strInnerTextcboField +""' should not be left blank."");return;}}")
        'Addition End By Vinay Issue Id->19981
        'WAF3_PB_38 Dataset UJ 30-Jan-07 End

        CommonFunction.General.WriteHTML("      var strVal = objValue.value;")
        'For LIKE / NOT LIKE operators add %value%
        CommonFunction.General.WriteHTML("      var objIsDBF=GetObjectReference('" + FORM_NAME + "','chkIsDatabaseFilter');var dBF=0; if(objIsDBF!= null){if(objIsDBF.checked==true)dBF=1;} ") 'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("      if (objcboOp.value==""LIKE"" || objcboOp.value==""NOT LIKE"") {if (dBF==0) {strVal=""%"" + replaceSubstring(replaceSubstring(replaceSubstring(strVal,""["",""[[]""),""%"",""[%]""),""*"",""[*]"") + ""%"";}else{strVal=""%"" + strVal + ""%""}}") 'WAF3_PB_38 - Request ID:245
        CommonFunction.General.WriteHTML("      if (objcboOp.value==""IS NULL"" || objcboOp.value==""IS NOT NULL"") {strVal="""";}") 'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("      else { strVal=""'"" + replaceSubstring(strVal,""'"",""''"") + ""'"";}") 'WAF3_PB_38
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer'){ ")
        CommonFunction.General.WriteHTML("      objQuery.innerHTML =  objQuery.innerHTML  + objcboField.value + ""/*"" + strInnerTextcboField + ""*/ "" + objcboOp.value + "" ""  + strVal;  ")
        CommonFunction.General.WriteHTML("}else{")
        CommonFunction.General.WriteHTML("      objQuery.innerText =  objQuery.innerText  + objcboField.value + ""/*"" + strInnerTextcboField + ""*/ "" + objcboOp.value + "" ""  + strVal;  ")
        CommonFunction.General.WriteHTML("}")

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("      objActualQuery.value =  objActualQuery.value  + objcboField.value + "" ""  + objcboOp.value + "" ""  + strVal; ") 'WAF3_PB_38 -
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("  }")
        CommonFunction.General.WriteHTML("  else {")
        'For Check box get the value from cboCheckBox
        'WAF3_PB_38 Dataset UJ 30-Jan-07 Start
        'For Checkbox fields LIKE / NOT LIKE are not allowed
        CommonFunction.General.WriteHTML("  if (objcboOp.value==""LIKE"" || objcboOp.value==""NOT LIKE"") {alert(""'LIKE' and 'NOT LIKE' operators are not applicable for the field '"" + strInnerTextcboField +""'."");setFocus(objcboOp);return;}")

        CommonFunction.General.WriteHTML("  var objcboCheckBox=GetObjectReference('" + FORM_NAME + "','cboCheckBox')")
        CommonFunction.General.WriteHTML("  var strVal = objcboCheckBox.value;")
        CommonFunction.General.WriteHTML("  if (objcboOp.value==""IS NULL"" || objcboOp.value==""IS NOT NULL"") {strVal="""";}")
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer'){ ")
        CommonFunction.General.WriteHTML("  objQuery.innerHTML =  objQuery.innerHTML  + objcboField.value + ""/*"" + strInnerTextcboField + ""*/ "" + objcboOp.value + "" "" +  strVal ;  ")
        'Commented And Added By Usha Pandit On 05.02.2020 For storing hidden value for advanced filter
        'CommonFunction.General.WriteHTML("  objActualQuery.innerHTML =  objActualQuery.value  + objcboField.value + "" "" + objcboOp.value + "" "" +  strVal ;")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  objActualQuery.value  + objcboField.value + "" "" + objcboOp.value + "" "" +  strVal ;")
        'End Of Added By Usha Pandit On 05.02.2020 For storing hidden value for advanced filter
        CommonFunction.General.WriteHTML("}else{")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  objQuery.innerText  + objcboField.value + ""/*"" + strInnerTextcboField + ""*/ "" + objcboOp.value + "" "" +  strVal ;  ")
        'Commented And Added By Usha Pandit On 05.02.2020 For storing hidden value for advanced filter
        'CommonFunction.General.WriteHTML("  objActualQuery.innerText =  objActualQuery.value  + objcboField.value + "" "" + objcboOp.value + "" "" +  strVal ;")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  objActualQuery.value  + objcboField.value + "" "" + objcboOp.value + "" "" +  strVal ;")
        'End Of Added By Usha Pandit On 05.02.2020 For storing hidden value for advanced filter
        CommonFunction.General.WriteHTML("}")
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        '        CommonFunction.General.WriteHTML("  objActualQuery.innerText =  objActualQuery.value  + objcboField.value + "" "" + objcboOp.value + "" "" +  strVal ;")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------
        'WAF3_PB_38 Dataset UJ 30-Jan-07 End

        CommonFunction.General.WriteHTML("  }")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_OpenBracketOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_OpenBracketOnClick
        ' Purpose               :	Write Clientside Script for function OpenBracket Onclick
        ' Description           :	Append the OpenBracket to the existing filter query
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_OPEN_BRACKET_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') ")
        CommonFunction.General.WriteHTML("  objQuery.innerHTML =  objQuery.innerHTML + "" ("";  ")
        CommonFunction.General.WriteHTML("  else ")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  objQuery.innerText + "" ("";  ")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  objActualQuery.value + "" ("";  ")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_CloseBracketOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_CloseBracketOnClick
        ' Purpose               :	Write Clientside Script for function CloseBracket Onclick
        ' Description           :	Append the Close Bracket to the existing filter query
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_CLOSE_BRACKET_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') ")
        CommonFunction.General.WriteHTML("  objQuery.innerHTML =  objQuery.innerHTML + "" )"";  ")
        CommonFunction.General.WriteHTML("  else ")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  objQuery.innerText + "" )"";  ")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '-------------------------------------------------------------------------------------------------------------


        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  objActualQuery.value + "" )"";  ")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_ANDOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ANDOnClick
        ' Purpose               :	Write Clientside Script for function AND Onclick
        ' Description           :	Append the AND operator to the existing filter query
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_AND_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') ")
        CommonFunction.General.WriteHTML("  objQuery.innerHTML =  objQuery.innerHTML + "" AND "";  ")
        CommonFunction.General.WriteHTML("  else ")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  objQuery.innerText + "" AND "";  ")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '-------------------------------------------------------------------------------------------------------------

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  objActualQuery.value + "" AND "";  ")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_OROnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_OROnClick
        ' Purpose               :	Write Clientside Script for function OR Onclick
        ' Description           :	Append the OR operator to the existing filter query
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_OR_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') ")
        CommonFunction.General.WriteHTML("  objQuery.innerHTML =  objQuery.innerHTML + "" OR "";  ")
        CommonFunction.General.WriteHTML("  else ")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  objQuery.innerText + "" OR "";  ")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '-------------------------------------------------------------------------------------------------------------
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  objActualQuery.value + "" OR "";")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_ClearAllOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ClearAllOnClick
        ' Purpose               :	Write Clientside Script for function Clear Onclick
        ' Description           :	Clear the existing filter query
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_CLEARALL_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By Shrikant B On 29 Sep 2008 For Request Id 328
        CommonFunction.General.WriteHTML("     if ( navigator.appName != 'Microsoft Internet Explorer') ")
        CommonFunction.General.WriteHTML("  objQuery.innerHTML =  """";  ")
        CommonFunction.General.WriteHTML("  else ")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  """";  ")
        'Modification End By Shrikant B On 29 Sep 2008 For Request Id 328
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        'Reason   - For using Dataset as Webform Grid Datasource. Change the values of User friendly text area and 
        '           hidden text area as well.
        '-------------------------------------------------------------------------------------------------------------
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  """";  ")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, January 16,  2007 For Requirement ID. - WAF3_PB_38
        '-------------------------------------------------------------------------------------------------------------

        CommonFunction.General.WriteHTML("}")
    End Sub
    Private Sub WriteClientsideScript_chkIsDatabaseFilterOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_chkIsDatabaseFilterOnClick
        ' Purpose               :	Write Clientside Script for chkIsDatabaseFilter On Click event
        ' Description           :	Enables / Disables the Query Text area (WAF3_PB_38 -)
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	February 26, 2007 
        ' Revisions             :   
        '====================================================================
        CommonFunction.General.WriteHTML("function chkIsDatabaseFilterOnClick(){")
        CommonFunction.General.WriteHTML("  var objIsDBF=GetObjectReference('" + FORM_NAME + "','chkIsDatabaseFilter')")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        CommonFunction.General.WriteHTML("  if (objIsDBF.checked == false){ ")
        CommonFunction.General.WriteHTML("  objQuery.readOnly=true;")
        CommonFunction.General.WriteHTML("  objQuery.innerText =  """";  ")
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  objActualQuery.value =  """";}  ")
        CommonFunction.General.WriteHTML("  else {objQuery.readOnly=false;}")
        CommonFunction.General.WriteHTML("}")
    End Sub
    Private Sub InitializeValidationResources()
        '=====================================================================
        ' Procedure Name        :	InitializeValidationResources
        ' Purpose               :	Initialize Validation Resources
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        m_strResFilterName = MyBase.GetResourceString("CONTROL_FILTERNAME")
        m_strResFilterQuery = MyBase.GetResourceString("CONTROL_FILTERQUERY")
        'StandardValidations Resource File
        MyBase.InitializeResources("Resources.StandardValidations", "Resources")
    End Sub

    Private Sub WriteClientsideScript_ValidateUI()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ValidateUI
        ' Purpose               :	Write Clientside Script for UI Validations
        ' Description           :	Validate the form before submitting
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :   On 8 Aug 2005 By NileshD IssueID - 20535
        '                           Added the validation for filter name
        '====================================================================
        Dim drFilter As IDataReader 'Added By NileshD on 8 Aug 2005 IssueID - 20535
        Dim strScript As String

        CommonFunction.General.WriteHTML("function " + FUNCTION_VALIDATE_UI + " {")
        CommonFunction.General.WriteHTML("  var objFilter = GetObjectReference('" + FORM_NAME + "','txtFilterName')")
        'Added By NileshD on 8 Aug IssueID - 20535
        'Added the validation for filter name
        If m_lngFilterID = 0 Then
            drFilter = CommonFunction.Data.GetDataReader("usp_sel_tbl_UI_AdvanceFilters_User " + m_lngTagID.ToString + "," + CStr(IIf(blnFromCanvas, "-1", m_objGlobal.UserID.ToString)) + ",'" + m_objGlobal.LoginType + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drFilter.Read Then
                strScript = " var arrFilterName=new Array("
                '=======================================================================================================
                'Modified By    : Ninad
                'Purpose        : To replace single quote in filter name so as to 
                '                   avoid errors while creating array in java script for check duplications of filter name
                'original       : drFilter("FilterName").ToString
                'Modified       : drFilter("FilterName").ToString.Replace("'", "\'")
                'Date           : 25 July 2006
                'Date           : 28 Aug 2007 By UmeshJ Also handle \ 'Request ID: 274 not part of this Support Request but found issue during testing
                '=======================================================================================================
                strScript += vbCrLf + "'" + drFilter("FilterName").ToString.Replace("\", "\\").Replace("'", "\'") + "'"
                Do While drFilter.Read
                    strScript += ", '" + drFilter("FilterName").ToString.Replace("\", "\\").Replace("'", "\'") + "'"
                Loop
                '=======================================================================================================
                'End Modification : by Ninad  Date : 25 July 2006
                '=======================================================================================================

                strScript += " )" + vbCrLf
                strScript += "if (disallowDuplicates(GetObjectReference(""frmCommonPage"",""txtFilterName""),arrFilterName,'&#39;Filter Name&#39; already exists.',true,false))"
                strScript += vbCrLf + "{ return false; }" + vbCrLf
                CommonFunction.General.WriteHTML(strScript)
            End If
            drFilter.Close()
            CommonFunction.Data.DisposeDataReader(drFilter)
        End If
        'End Of Addition IssueID - 20535
        'Added By Shrikant 19 June 2008, IssueID 20608
        CommonFunction.General.WriteHTML("if (disallowSpecialCharacters(GetObjectReference(""frmCommonPage"",""txtFilterName""),""Characters [/:*?+\""><|,\\\\] are not allowed within the 'Filter Name'.""))")
        CommonFunction.General.WriteHTML(vbCrLf + "{GetObjectReference(""frmCommonPage"",""txtFilterName"").focus(); return false; }" + vbCrLf)
        'End Addition By Shrikant 19 June 2008, IssueID 20608
        CommonFunction.General.WriteHTML("  if (disallowBlank(objFilter,'" + CommonFunction.General.ReplacePlaceHoldersInStandardValidations(MyBase.GetResourceString("DISALLOW_BLANK"), m_strResFilterName) + "') == true) {return false;} ")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        CommonFunction.General.WriteHTML("  if (disallowBlank(objQuery,'" + CommonFunction.General.ReplacePlaceHoldersInStandardValidations(MyBase.GetResourceString("DISALLOW_BLANK"), m_strResFilterQuery) + "') == true) {return false;} ")
        'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  var objIsDBF=GetObjectReference('" + FORM_NAME + "','chkIsDatabaseFilter')")
        CommonFunction.General.WriteHTML("  if(objIsDBF != null) {if(objIsDBF.checked==true){objActualQuery.value=objQuery.value;}}")
        'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("  return true;")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_ValidateUIWithoutSave()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ValidateUIWithoutSave
        ' Purpose               :	Write Clientside Script for UI Validations
        ' Description           :	Validate the form before submitting
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_VALIDATE_UI_WITHOUTSAVE + " {")
        CommonFunction.General.WriteHTML("  var objQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQuery')")
        CommonFunction.General.WriteHTML("  if (disallowBlank(objQuery,'" + CommonFunction.General.ReplacePlaceHoldersInStandardValidations(MyBase.GetResourceString("DISALLOW_BLANK"), m_strResFilterQuery) + "') == true) {return false;} ")
        'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("  var objActualQuery=GetObjectReference('" + FORM_NAME + "','txtFilterQueryHidden')")
        CommonFunction.General.WriteHTML("  var objIsDBF=GetObjectReference('" + FORM_NAME + "','chkIsDatabaseFilter')")
        CommonFunction.General.WriteHTML("  if(objIsDBF != null) {if(objIsDBF.checked==true){objActualQuery.value=objQuery.value;}}")
        'WAF3_PB_38 -
        CommonFunction.General.WriteHTML("  return true;")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_SaveOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SaveOnClick
        ' Purpose               :	Write Clientside Script for function Save Onclick
        ' Description           :	Validate the form and Submit the page
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        Dim strQueryStringOld As String = ""
        strQueryStringOld = GetOldQueryString(m_lngTagID)

        CommonFunction.General.WriteHTML("function " + FUNCTION_SAVE_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  if (" + FUNCTION_VALIDATE_UI + " == false) {return;} ")
        Dim strEditMode As String = "N"
        Dim strAppliedFilter As String = "N"
        Dim strAddQueryString As String = ""
        strEditMode = CommonFunction.General.CheckIsNothing(Request.QueryString("IsEditModeFltr"), "")
        If strEditMode.Trim.ToUpper = "Y" Then
            strAppliedFilter = CommonFunction.General.CheckIsNothing(Request.QueryString("IsAppliedFilter"), "")
            If strAppliedFilter.Trim.ToUpper = "Y" Then
                strAddQueryString = "&IsAppliedFilter=Y"
            End If
        End If
        'request come from canvas, then set queryString parameter masterTagID=1840 o.w. 1017
        If blnFromCanvas Then
            CommonFunction.General.WriteHTML("  objfrm.action=""CLCP_AdvanceFilters.aspx?MasterTagID=1840&Mode=" + MODE_SAVE + "&SubMode=" + SUB_MODE_DONOT_APPLY + "&TagID=" + m_lngTagID.ToString + strAddQueryString + strQueryStringOld + """;")
        Else
            CommonFunction.General.WriteHTML("  objfrm.action=""CLCP_AdvanceFilters.aspx?Mode=" + MODE_SAVE + "&SubMode=" + SUB_MODE_DONOT_APPLY + "&TagID=" + m_lngTagID.ToString + strAddQueryString + strQueryStringOld + """;")
        End If
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then CommonFunction.General.WriteHTML("  blnNavigate = false; ") 'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        CommonFunction.General.WriteHTML("  objfrm.submit();")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_SaveAndApplyOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SaveAndApplyOnClick
        ' Purpose               :	WriteClientsideScript for Save And Apply filter
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004
        ' Revisions             :
        '====================================================================

        Dim strQueryStringOld As String = ""
        strQueryStringOld = GetOldQueryString(m_lngTagID)

        CommonFunction.General.WriteHTML("function " + FUNCTION_SAVE_AND_APPLY_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  if (" + FUNCTION_VALIDATE_UI + " == false) {return;} ")
        CommonFunction.General.WriteHTML("  objfrm.action=""CLCP_AdvanceFilters.aspx?Mode=" + MODE_SAVE + "&SubMode=" + SUB_MODE_APPLY + "&TagID=" + m_lngTagID.ToString + strQueryStringOld + """;")
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then CommonFunction.General.WriteHTML("  blnNavigate = false; ") 'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        CommonFunction.General.WriteHTML("  objfrm.submit();")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_RemoveOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_RemoveOnClick
        ' Purpose               :	Write Clientside Script for function Remove filter Onclick
        ' Description           :	Remove the Applied Filter
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 30, 2004
        ' Revisions             :
        '====================================================================
        Dim strQueryStringOld As String = ""
        strQueryStringOld = GetOldQueryString(m_lngTagID)

        CommonFunction.General.WriteHTML("function " + FUNCTION_REMOVE_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  objfrm.action=""CLCP_AdvanceFilters.aspx?Mode=" + MODE_REMOVE + strQueryStringOld + """;")
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then CommonFunction.General.WriteHTML("  if(ShowNavigationAlert()==false) return; ") 'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        CommonFunction.General.WriteHTML("  objfrm.submit();")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_BackOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_BackOnClick
        ' Purpose               :	Write Clientside Script for function Back Onclick
        ' Description           :	Goto Filter List
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004
        ' Revisions             :
        '====================================================================
        Dim strQueryStringOld As String = ""
        CommonFunction.General.WriteHTML("function " + FUNCTION_BACK_ONCLICK + " {")
        '====================================================================
        ' Modified By           :   PushkarK
        ' Modified On           :   Aug 04, 2005
        '====================================================================
        Dim strTagID As String
        strTagID = CommonFunction.General.CheckIsNothing(Request.QueryString("TagID"), "")
        strQueryStringOld = GetOldQueryString(CType(strTagID, Long))
        'request come from canvas, then set queryString parameter masterTagID=1840 o.w. 1017
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then CommonFunction.General.WriteHTML("  if(ShowNavigationAlert()==false) return; ") 'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        If blnFromCanvas Then
            CommonFunction.General.WriteHTML("  window.location.href=""Filter_CommonList.aspx?ConnectionID=" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "&MasterTagID=1840&TagID=" + strTagID + strQueryStringOld + """;")
        Else
            CommonFunction.General.WriteHTML("  window.location.href=""Filter_CommonList.aspx?ConnectionID=" + CommonFunctions.General.CheckIsNothing(Request("ConnectionID")) + "&MasterTagID=" + CommonFunction.Constants.TAG_ADVANCE_FILTERS.ToString + "&TagID=" + strTagID + strQueryStringOld + """;")
        End If

        '====================================================================
        ' Modification Ends.
        '====================================================================
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_CloseOnClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_CloseOnClick
        ' Purpose               :	Write Clientside Script for function Close Onclick
        ' Description           :	Goto Filter List
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004
        ' Revisions             :
        '====================================================================
        CommonFunction.General.WriteHTML("function " + FUNCTION_CLOSE_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  window.close();")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_ApplyWithoutSaveClick()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ApplyWithoutSaveClick
        ' Purpose               :	Write Clientside Script for function Apply Without Save Onclick
        ' Description           :	Apply the filter but do not save
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 02, 2004
        ' Revisions             :
        '====================================================================
        Dim strQueryStringOld As String = ""
        strQueryStringOld = GetOldQueryString(m_lngTagID)
        CommonFunction.General.WriteHTML("function " + FUNCTION_APPLY_WITHOUT_SAVE_ONCLICK + " {")
        CommonFunction.General.WriteHTML("  if (" + FUNCTION_VALIDATE_UI_WITHOUTSAVE + " == false) {return;} ")
        CommonFunction.General.WriteHTML("  objfrm.action=""CLCP_AdvanceFilters.aspx?Mode=" + MODE_APPLY + "&TagID=" + m_lngTagID.ToString + strQueryStringOld + """;")
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then CommonFunction.General.WriteHTML("  blnNavigate = false; ") 'Modified By Ninad 27 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        CommonFunction.General.WriteHTML("  objfrm.submit();")
        CommonFunction.General.WriteHTML("}")
    End Sub

    Private Sub WriteClientsideScript_RefreshParent()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_RefreshParent
        ' Purpose               :	Write Clientside Script for refreshing the 
        '                           Parent window
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 25, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<Script language=javascript>")

        'Response.Write(vbCrLf + "var parentPage='CommonList.aspx';")

        Response.Write(vbCrLf + "var parentPage='CommonList.aspx';")

        Response.Write(vbCrLf + "var parentFormName='frmCommonList'")
        Response.Write(vbCrLf + "var strParentPage = new String();")
        Response.Write(vbCrLf + "try { ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
        Response.Write(vbCrLf + "strParentPage = opener.location.href;")
        Response.Write(vbCrLf + "if (strParentPage.toUpperCase().indexOf(parentPage.toUpperCase()) != -1)")
        Response.Write(vbCrLf + "{")
        Response.Write(vbCrLf + "	window.opener.document.forms[parentFormName].action = parentPage;")
        Response.Write(vbCrLf + "	window.opener.document.forms[parentFormName].submit();")
        Response.Write(vbCrLf + "}")
        Response.Write(vbCrLf + "}catch(e) { } ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
        'Response.Write(vbCrLf + "if (closeChildWindow==true) { window.close(); }")
        Response.Write(vbCrLf + "</Script>" + vbCrLf)
    End Sub

    Private Sub MemoryCleanUp()
        '=====================================================================
        ' Procedure Name        :	MemoryCleanUp
        ' Purpose               :	Remove the unused objects from the memory
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2004 
        ' Revisions             :
        '=====================================================================
        'Sub Tag Objects
        If Not m_objGlobal Is Nothing Then m_objGlobal = Nothing
    End Sub

    Public Sub New()
        'Advance Page Filters Resource File
        MyBase.InitializeResources("Resources.AdvanceFilters", "Resources")
        'MyBase.ApplySecurity()
        ''Added by SwapnilA on 11-07-2016 for Applysecurity for SQLInjection and XSS injection
        MyBase.ApplySecurity(True, 2, True, True, True)
        ''Ended by SwapnilA
    End Sub

End Class
