
Public Class IBIssueList
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_lngTagId = m_objGlobal.TagID
    End Sub

#End Region

    Protected m_intPageNumber As Integer
    '' START : Added by ParagD 19-Sept-2006 : Security Issue 6197
    Protected m_PKToken_FromIssueList As String
    '' START : Added by ParagD 19-Sept-2006 : Security Issue 6197 

    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197	  
    Protected m_PKToken As String
    Protected m_IssueID As String

    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197	
    Private m_blnBatchUpdateAccess As Boolean
    'Addition by SuchitraP on 12 March 2008 for ISsueID=17070
    'Purpose:to handle page crash when sorting is done on fields having datatype as text/ntext
    Private m_IsCustomFieldTextAreaPresentInView As Boolean
    'End of addition by SuchitraP
    Private m_objGlobal As WebPages.Template.IGlobal
    Protected m_lngTagId As Long = 0
    Private m_SearchClause As String
    Protected SearchType As Int16 = 0
    Protected SearchValue As String
    Private strSearchSummary As String
    Private strSearchDescription As String
    Private strSearchSummary_Control As String
    Private strSearchDescription_Control As String
    Private strDeliverable As String = ""
    Protected DeliverableSearchValue As String
    Protected m_strDeliverable As String = ""
    Private strSearchType As String = ""
    Private strSearchStatus As String = ""
    Private strSearchResponsible As String = ""
    Private strSearchSubmittedBy As String = ""
    Private strShowToCustSearch As String = ""

    Protected strSearchFromDate As String = ""
    Protected strSearchToDate As String = ""
    Protected m_dtStartDateOfWeek As Date
    Protected m_dtEndDateOfWeek As Date
    Protected m_intStartingDayOfWeek As Integer = 0
    Protected m_intCurrentDayOfWeek As Integer = 0
    Protected m_FlagStatus As String

#Region " Form level variables Declaration "

    Private m_LoginId As Long 'Login Id
    'Commented By Dipalis And Added the following
    'private m_LoginType As String 'Login Type
    Protected m_LoginType As String 'Login Type
    Private m_RoleId As Long 'RoleId
    Private m_RoleLevel As Integer 'Role Level
    Protected m_ProjectId As Long 'ProjectId
    Private m_UserId As Long 'UserId
    Private m_UserName As String 'UserName
    Private m_CultureId As Long 'CultureId
    Private m_PageSize As Long 'PageSize

    Protected m_strSortBy, m_strAscOrDesc As String
    Protected m_intQueryID As Long
    ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

    'Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
    'Purpose: Not allow to do any activity if Project is not baselined 
    'Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    'Protected m_intBaselineNumber As Integer = 0

    ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

    'Addtion ended
    Private m_strUserOrderByField, m_strUserOrderByClause, m_strMode As String

    Private m_blnSkipQry As Boolean = False
    Private m_HistoryStatus As String

    Private m_blnAddAccess As Boolean = False 'Add access for the logged in user
    Private m_blnEditAccess As Boolean = False 'Edit access for the logged in user
    Private m_blnDeleteAccess As Boolean = False 'Delete access for the logged in user
    Private m_FieldList, m_Order, m_strQuery, m_strQueryName As String
    Private m_blnIssueIdPresent As Boolean = False

    'Added by Aniruddha on 19 may 2004 for issuecode
    Private m_blnIssueCodePresent As Boolean = False
    Private m_strIssueCodesOnPage As String = ""
    'Addition ends

    Protected m_OrderBy As String = ""

    Private m_intIssueCountForAppliedQuery As Long

    Private m_strIssueIdsOnPage As String = ""

    Private WithEvents objIssueGrid As New WebPage.Templates.GenericGrid

    'Added by AniruddhaD for Optimization
    Dim m_strPagingSQL As String

    '****Code Added*******
    'By     :   DipaliS
    'Reason :   My Issues Feature
    'Date   :   25 June 2004
    'Requirement Number :   IB_PBN_ENT_03
    'Addition Made  :   Added Declaration of variable for Display Mode i.e default or My Issues
    Protected m_strDisplayMode As String
    '********End Addition*******

#End Region

    ''added by Nilesh g on 2/2/2016 for url issue
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(intProjectID As String, EmployeeID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(intProjectID, String) + CType(EmployeeID, String) + "0" + "0")
        Return m_PKToken_Request_Multiple
    End Function

    ''ENDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE

#Region " Private Functions "

    Private Function GetDatabaseFieldNameForCustomField(ByVal strUserGivenCaption As String, ByVal intProjectID As Long) As String
        Dim drDBFieldName As IDataReader

        drDBFieldName = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_CustomFields_Master_DatabaseFieldName '" + CommonFunction.General.BuildQueryString(strUserGivenCaption) + "'," + intProjectID.ToString, MyBase.UseSQL)
        'Response.Write "EXEC usp_Sel_tbl_IB_CustomFields_Master_DatabaseFieldName '" & strUserGivenCaption &"'," & intProjectID

        If drDBFieldName.Read Then
            GetDatabaseFieldNameForCustomField = CommonFunction.Data.CheckIsDBNull(drDBFieldName("DatabaseFieldName"), "").ToString
        Else
            GetDatabaseFieldNameForCustomField = ""
        End If
        CommonFunction.Data.DisposeDataReader(drDBFieldName)

    End Function 'Get database name for custom field

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the IssueList page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        ''ADDED BY AMIT MAHADIK ON 09 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
        'Issue Copying
        ArrMenuCaptionsList.Add("Issue Copying")
        ArrMenuToolTipsList.Add("Issue Copying")
        ArrClientSideFunctionsList.Add("IssueCopying_OnClick()")
        ''END ADDED BY AMIT MAHADIK ON 09 JUNE 2011 WHIZIBLESEM 10.0 ISSUE COPYING
        'Add New 
        If m_blnAddAccess Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_ADDNEW"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_ADDNEW_TOOLTIP"))
            ArrClientSideFunctionsList.Add("AddNew_OnClick()")
        End If

        'Query
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_QUERY"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_QUERY_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Query_OnClick()")

        'Views
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_VIEWS"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_VIEWS_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Views_OnClick()")

        'Settings
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SETTINGS"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SETTINGS_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Settings_OnClick()")

        'Batch Update
        If Session("LoginType") Is "E" Then
            If m_blnBatchUpdateAccess = True Then
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_BATCHUPDATE"))
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_BATCHUPDATE"))
                ArrClientSideFunctionsList.Add("BatchUpdate_OnClick()")
            End If

        End If

        'Set Filter
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SETFILTER"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SETFILTER_TOOLTIP"))
        ArrClientSideFunctionsList.Add("SetFilter_OnClick()")



        'Clear filter
        If Not Request.QueryString("Filter") Is Nothing Then
            If Request.QueryString("Filter") = "C" Then
                Session("Filters") = ""
                Session("intFilterOnQuery") = ""
            End If
        End If

        If Session("Filters").ToString <> "" Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_CLEARFILTER"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_CLEARFILTER_TOOLTIP"))
            ArrClientSideFunctionsList.Add("ClearFilter_OnClick()")
        End If

        'Apply Default Settings
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_APPLY_DEFAULT_SETTINGS"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_APPLY_DEFAULT_SETTINGS"))
        ArrClientSideFunctionsList.Add("ApplyDefaultSettings_OnClick()")

        'Delete
        If m_blnDeleteAccess Then
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_DELETE"))
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_DELETE_TOOLTIP"))
            ArrClientSideFunctionsList.Add("Delete_OnClick()")
        End If

        ''3D Reports
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_3DREPORTS"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_3DREPORTS"))
        ArrClientSideFunctionsList.Add("Reports_OnClick()")

        ''Status Based Report
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_STATUS_BASED_REPORT"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_STATUS_BASED_REPORT"))
        ArrClientSideFunctionsList.Add("StatusBasedReport_OnClick()")

        'Show Report
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_SHOWREPORT"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_SHOWREPORT"))
        ArrClientSideFunctionsList.Add("ShowReport_OnClick()")

        'Issue Analysis
        If CommonFunction.General.CheckIsNothing(Session("LoginType"), "") = "E" Then
            ArrMenuCaptionsList.Add("Issue Analysis")
            ArrMenuToolTipsList.Add("Issue Analysis")
            ArrClientSideFunctionsList.Add("Analysis_OnClick()")
        End If

        'Refresh
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_REFRESH"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_REFRESH_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Refresh_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('IB_ISSUE_LIST')")

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function

    Private Function GetViewName() As String
        '=====================================================================
        ' Function Name         : GetViewName()	
        ' Purpose               : To get currently applied view, if any, by the user
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string(Name of Applied View)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String, strViewName As String

        If Session("intViewID").ToString = "" Then
            'if ViewId not available in Session, Check for default view for user, if any
            Dim drDefaultView As IDataReader
            strSQL = "Exec usp_Sel_tbl_IB_DefaultView " + m_UserId.ToString + ", " + m_ProjectId.ToString + ", '" & m_LoginType.ToString + "'"
            drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDefaultView.Read Then
                'Get name of default view
                strViewName = CType(drDefaultView("ViewName"), String)

                'Get field list for the view to be applied
                m_FieldList = CType(drDefaultView("Fields"), String)

                'Get fieldname to sort on
                m_OrderBy = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultView("SortBy"), ""), String)

                'set session variable 
                Session("intViewID") = CommonFunctions.Data.CheckIsDBNull(drDefaultView("ProjectViewId"), "")

                'Destroy DataReader
                CommonFunctions.Data.DisposeDataReader(drDefaultView)
            Else
                'If no default view created for user, show corporate view
                Dim drCorporateView As IDataReader
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strSQL = "select * from tbl_PM_CompanyInformation"
                strSQL = "usp_sel_tbl_PM_CompanyInformation_PM"
                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                drCorporateView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drCorporateView.Read Then
                    'Get name of default view
                    strViewName = "Corporate View"

                    'Get field list for the view to be applied
                    m_FieldList = CType(drCorporateView("IBDefaultView"), String)

                    CommonFunctions.Data.DisposeDataReader(drCorporateView)
                End If
                CommonFunctions.Data.DisposeDataReader(drDefaultView)
            End If

        Else 'Execute the given view
            strSQL = "EXEC usp_Sel_tbl_IB_Project_Views NULL,NULL,NULL," & CType(Session("intViewID"), String)
            Dim drDefaultView As IDataReader
            drDefaultView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDefaultView.Read Then
                'Get name of default view
                strViewName = CType(drDefaultView("ViewName"), String)

                'Get field list for the view to be applied
                m_FieldList = CType(drDefaultView("Fields"), String)

                'Get fieldname to sort on
                m_OrderBy = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultView("SortBy"), ""), String)

                'Destroy DataReader
                CommonFunctions.Data.DisposeDataReader(drDefaultView)
            Else
                'If no default view created for user, show corporate view
                Dim drCorporateView As IDataReader
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strSQL = "select IBDefaultView from tbl_PM_CompanyInformation"
                strSQL = "usp_sel_DefaultView_tbl_PM_CompanyInformation"
                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                drCorporateView = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drCorporateView.Read Then

                    'Get name of default view
                    strViewName = "Corporate View"

                    'Get field list for the view to be applied
                    m_FieldList = CType(drCorporateView("IBDefaultView"), String)
                End If
                CommonFunctions.Data.DisposeDataReader(drCorporateView)
            End If

        End If

        'If m_strUserOrderByClause.Trim <> "" And m_strSortBy.Trim <> "" Then m_strSortBy = m_strUserOrderByClause + "," + m_strSortBy
        'If m_strUserOrderByClause.Trim <> "" And m_strSortBy.Trim = "" Then m_strSortBy = m_strUserOrderByClause

        'Return name of view applied
        Return strViewName

    End Function

    Private Function GetHistoryStatus() As String
        '=====================================================================
        ' Function Name         : GetHistoryStatus()	
        ' Purpose               : To get current history status : on or off
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string(History status : On / Off)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        Dim drHistoryStatus As IDataReader
        Dim strSQL As String, strHistoryStatus As String

        'Set SP name to execute
        strSQL = "EXEC usp_Sel_tbl_PM_Project " & m_ProjectId

        'Execute SP using DaraReader
        drHistoryStatus = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drHistoryStatus.Read Then
            strHistoryStatus = CType(drHistoryStatus("IBHistoryOn"), String)
        End If

        'destroy data reader
        CommonFunction.Data.DisposeDataReader(drHistoryStatus)

        'Return History status value
        If strHistoryStatus = "True" Then
            Return "ON"
        Else
            Return "OFF"
        End If
    End Function

    Private Function GenerateQueryForGrid() As String
        '=====================================================================
        ' Procedure Name        : GenerateQueryForGrid (Below top menu)
        ' Purpose               : To generate SQL Query for grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Generate SQL Query for grid
        Dim strSQL, strProjectList, strCountQuery, strSQLView As String



        ''commented by aniruddhad for issue = sorting problem
        '-----------------------------------------------------
        ''Added by AniruddhaD for Optimization
        'm_strPagingSQL = "Select IssueID FROM v_tbl_IB_Issue "
        ''End of addition

        'If Not Request.QueryString("OrderBy") Is Nothing Then
        '    m_OrderBy = Request.QueryString("OrderBy")
        'Else
        '    m_OrderBy = "IssueId"
        'End If

        'If Not Request.QueryString("ASCDESC") Is Nothing Then
        '    m_Order = Request.QueryString("ASCDESC")
        'Else
        '    m_Order = "Desc"
        'End If

        ''Added by aniruddhad
        'If m_strAscOrDesc = "" Then m_strAscOrDesc = m_Order

        'If InStr("," + m_FieldList + ",", ",IssueID,") > 0 Then
        '    m_FieldList = m_FieldList
        '    m_blnIssueIdPresent = True
        'Else 'if in the view does't select the issue id field then append this field as first field 
        '    m_FieldList = "IssueID," + m_FieldList
        '    m_blnIssueIdPresent = False
        'End If
        '-----------------------------------------------------

        'Added by aniruddhad for issue = sorting problem
        '-------------------------------------------------------------------------------------
        'Added by AniruddhaD for Optimization
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'm_strPagingSQL = "Select IssueID FROM v_tbl_IB_Issue "
        m_strPagingSQL = "usp_sel_v_tbl_IB_Issue_Issue"
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        'End of addition

        If Not Request.QueryString("OrderBy") Is Nothing Then
            m_OrderBy = Request.QueryString("OrderBy")
        Else
            If m_OrderBy = "" Then
                'Code Commented by DipaliS 30 Sep 2004 and Added the following line
                'Purpose : To remove the default sorting on Issue ID
                'm_OrderBy = "IssueId"
            End If
        End If

        If Not Request.QueryString("ASCDESC") Is Nothing Then
            If Request.QueryString("ASCDESC") <> "" Then

                'if condition added by aniruddha on 14 may 2004 for issue id 11116
                If Trim(Right(m_OrderBy, 4)).ToUpper <> Trim(Request.QueryString("ASCDESC")).ToUpper Then
                    'Added By DipaliS 30 Sep 2004
                    'Purpose : To Check if there is sorting on more than 1 field, if yes then do not set the m_ord
                    'So for that Added the If Condition
                    If InStr(m_OrderBy, ",") = 0 Then
                        'End Addition by DipaliS
                        m_Order = Request.QueryString("ASCDESC")
                        'Added by DipaliS
                    End If
                    'End Addition By DipaliS
                End If

            Else
                If m_OrderBy = "IssueId" Then m_Order = "Desc"
            End If
        Else
            If m_OrderBy = "" Then
                m_Order = "Desc"
            Else
                If m_OrderBy <> "IssueId" Then
                    If InStr(m_OrderBy, ",") = 0 Then
                        m_Order = Right(m_OrderBy, 4)
                        m_OrderBy = Left(m_OrderBy, Len(m_OrderBy) - 4)
                    End If
                Else
                    m_Order = "Desc"
                End If
            End If
        End If

        'Code Added By DipaliS 19 July 2004 for Hotfix 4.0.5
        'Purpose : To persist the sorting order after paging
        If m_strAscOrDesc = "" Then m_strAscOrDesc = m_Order
        'End addition

        'Check if IssueID exists
        If InStr("," + m_FieldList + ",", ",IssueID,") > 0 Then
            m_FieldList = m_FieldList
            m_blnIssueIdPresent = True
        Else 'if in the view does't select the issue id field then append this field as first field 
            m_FieldList = "IssueID," + m_FieldList
            m_blnIssueIdPresent = False
        End If
        '-------------------------------------------------------------------------------------

        'Code added by Aniruddha on 19 May 2004, for IssueCode
        'Check if IssueCode exists
        If InStr("," + m_FieldList + ",", ",IssueCode,") > 0 Then
            m_FieldList = m_FieldList
            m_blnIssueCodePresent = True
        Else 'if in the view does't select the issue id field then append this field as first field 
            m_FieldList = "IssueCode," + m_FieldList
            m_blnIssueCodePresent = False
        End If
        '-------------------------------------------------------------------------------------
        'End of addition by AniruddhaD on 19 may 2004, for issuecode
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        strCountQuery = "Select count(IssueID) FROM v_tbl_IB_Issue "
        ''strCountQuery = "usp_sel_v_tbl_IB_Issue_count"

        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query


        strSQL = "SELECT CASE  when  (SELECT COUNT(AttachmentId) AS Attachments FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId ) = 0 then ' ' else '<IMG border=0 src=''../../Images/Pin.gif'' title=''' + cast((SELECT COUNT(AttachmentId) AS Attachments FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId )as varchar) + '''>' end as Attachments,"

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' strSQL = strSQL + "case when  exists (SELECT top 1 DailyActivityEntryID FROM tbl_PM_DailyActivity INNER  JOIN tbl_PM_ProjectTasks ON tbl_PM_DailyActivity.TaskID=tbl_PM_ProjectTasks.TaskID WHERE(tbl_PM_ProjectTasks.OtherTaskID = v_tbl_IB_Issue.IssueId) AND  tbl_PM_ProjectTasks.WhichTask='B') then '<IMG border=0 src=''../../Images/Timesheet.gif''''>' else '' end as DA,"
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'strSQL = strSQL + "'<IMG border=0 src=''../../Images/Discussions.gif'' title=''' + cast(dbo.udf_DiscussionThreadsForIssue(v_tbl_IB_Issue.IssueId) as varchar) + '''>' as Discussions, " + m_FieldList + ", "

        strSQL = strSQL + "'<IMG border=0 src=''../../Images/Discussions.gif'' title=''' + cast(dbo.udf_DiscussionThreadsForIssue(v_tbl_IB_Issue.IssueId, '" & m_LoginType & "') as varchar) + '''>' as Discussions, "
        'added by VivekP on 2 Apr 2005 for copy issue functionality - link on list page
        'If CType(Application("ACCN-ISSUECOPY"), Boolean) = True Then

        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access
        If m_blnAddAccess = True Then
            strSQL = strSQL + "'<IMG border=0 src=''../../Images/Copy.gif'' title=''Copy''>' AS Copy, "
        End If
        'End Of Modification - issueId - 191

        'End If
        'end of addition

        strSQL = strSQL + m_FieldList + ", "

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' strSQL = strSQL + "case when  exists (SELECT top 1 DailyActivityEntryID FROM tbl_PM_DailyActivity INNER  JOIN tbl_PM_ProjectTasks ON tbl_PM_DailyActivity.TaskID=tbl_PM_ProjectTasks.TaskID WHERE(tbl_PM_ProjectTasks.OtherTaskID = v_tbl_IB_Issue.IssueId) AND  tbl_PM_ProjectTasks.WhichTask='B') then 1 else 0 end as DAPresent"
        strSQL = strSQL + " 0 as DAPresent "
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' integration by harshada d on 21 DEC 2005 for whiziblesem issue id 989
        '============================'============================'============================'============================
        'Added By ManishK on 21st Nov 2005 For no of attchements attached for a Issue
        '============================'============================'============================'============================
        strSQL = strSQL + ", v_tbl_IB_Issue.ProjectID "
        '============================'============================'============================'============================
        'End of Added By ManishK on 21st Nov 2005 For no of attchements  attached for a Issue
        '============================'============================'============================'============================
        'end of integration by harshada d on 21 DEC 2005 for whiziblesem issue id 989

        'Added By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'Added By VarunA on 12-July-2007 Whizible Development and Release
        'Purpose : To have the ReportedBy, ReportedDate as a value for Follow up Tab.
        If m_strDisplayMode.ToUpper.Trim = "F" Then
            strSQL += " ,ReportedBy,CAST (ReportedDate AS VARCHAR) ReportedDate "
        End If
        'End By VarunA on 12-July-2007 

        ' Code Commented and Added By RajkumarM on Nov 10 2009 for Foursoft Issue 23718
        'strSQL += " , ISNULL((SELECT TOP 1 CAST(Comments AS NVARCHAR(2000)) FROM tbl_IB_Discussion WHERE tbl_IB_Discussion.IssueID = v_tbl_IB_Issue.IssueID ORDER BY DiscussionID DESC),'') AS [LastDiscussionThread] "
        'if login type is customer then only show the selected Discussion Threads

        strSQL += " , ISNULL((SELECT TOP 1 CAST(Comments AS NVARCHAR(2000)) FROM tbl_IB_Discussion WHERE tbl_IB_Discussion.IssueID = v_tbl_IB_Issue.IssueID"

        If m_LoginType = "C" Then
            strSQL += " AND tbl_IB_Discussion.ShowToCustomer = 1 "
        End If

        strSQL += " ORDER BY DiscussionID DESC),'') AS [LastDiscussionThread] "

        'End of Commented By RajkumarM on Nov 10 2009 for Foursoft Issue 23718

        'End Addition By GaneshG
        'Added by ShraddhaM on 18,Sep 2009 to display FlagTo
        strSQL += " ,tbl_PM_FlagForTracking.FlagTo "
        strSQL += " , (select Case When IsComplete=1 then 'B' When (Datediff(dd,tbl_PM_FlagForTracking.DDate,Getdate())>0 AND IsComplete=0) then 'L'    "
        strSQL += "	   When (Datediff(dd,tbl_PM_FlagForTracking.DDate,Getdate())<0 AND IsComplete=0) then 'G' "
        strSQL += "	 When (Datediff(dd,tbl_PM_FlagForTracking.DDate,Getdate())=0 AND IsComplete=0) then 'S' else ''  "
        strSQL += " End ) as [FlagDateStatus],LastUpdatedDate  "
        'Ended by ShraddhaM

        strSQL += " FROM v_tbl_IB_Issue "

        'Added by ShraddhaM on 18,Sep 2009 to display FlagTo
        strSQL += " LEFT JOIN d_tbl_PM_FlagForTracking AS tbl_PM_FlagForTracking ON v_tbl_IB_Issue.IssueID = tbl_PM_FlagForTracking.ContextID AND ContextType = 'IB' AND EmployeeID = " + Session("intUserID").ToString()
        'Ended by ShraddhaM
        If InStr(m_OrderBy, "tbl_IB_Priorities.OrderNumber") <> 0 Then
            strSQL += " LEFT JOIN tbl_IB_Priorities ON tbl_IB_Issue.CorporatePriority=tbl_IB_Priorities.Priority "
        End If

        If InStr(m_OrderBy, "tbl_IB_Severity.OrderNumber") <> 0 Then
            strSQL += " LEFT JOIN tbl_IB_Severity ON tbl_IB_Issue.CorporateSeverity=tbl_IB_Severity.Severity "
        End If

        'Attach the project id in where clause
        'Modified By GaneshG on 17 Nov 06
        'strSQL += " WHERE  "
        strSQL += " WHERE 1 = 1 "

        'Added by ShraddhaM on 23,Jul 2009
        'If SearchType > 0 OrElse SearchType = 7 Then
        strSQL = strSQL + m_SearchClause
        'End If

        'Ended by ShraddhaM

        'if login type is customer then only show the selected bugs
        If m_LoginType = "C" Then
            ''strSQL += " ShowToCustomer = 1 "
            strSQL += " AND ShowToCustomer = 1 "
            ''Else
            ''    strSQL += " 1 = 1 "
        End If
        'End Modification By GaneshG

        'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
        strProjectList = GetProjectIDs(CType(Session("IssueProject"), Integer))


        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   24 June 2004
        'Requirement Number :   IB_PBN_ENT_01
        'Addition Made  :   Added the Code for forming the list of types accessible to the Role for selected 
        '                   Project.

        'Append the Query for applying the Role Level Security for Type
        'Check if there is any Security applied for given Role for given projectID.
        Dim drTypeAccess As IDataReader
        Dim strSQLForRole As String
        Dim strListOfTypes As String

        strListOfTypes = ""

        'Get the Types accessible for given Role and Project
        strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_GetRecordSet " & m_ProjectId & "," & m_RoleId
        drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

        'If any record found that means security is explicitly set for the Role for that project
        While drTypeAccess.Read
            strListOfTypes = strListOfTypes + "'" + CommonFunctions.General.BuildQueryString(CType(CommonFunctions.General.CheckIsNothing(drTypeAccess.Item("TypeName")), String)) + "',"
        End While

        'Remove the last comma
        If strListOfTypes <> "" Then
            strListOfTypes = Left(strListOfTypes, strListOfTypes.Length - 1)
        End If

        CommonFunctions.Data.DisposeDataReader(drTypeAccess)

        '*******End Of Addition********

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   My Issue Base Feature
        'Date   :   25 June 2004
        'Requirement Number :   IB_PBN_ENT_03
        'Addition Made  :   'Added the Code To form SQL for My Issue Base feature which will
        'be appnded to the SQL below for the grid
        Dim strSQLMyIB As String
        strSQLMyIB = ""

        If m_strDisplayMode.ToLower.Trim = "m" Then
            If m_LoginType = "E" Then
                strSQLMyIB = " AND (ReportedBy ='" + CommonFunction.General.BuildQueryString(m_UserName) + _
                "' OR AssignToName='" + CommonFunction.General.BuildQueryString(m_UserName) + _
                "' OR IssueID IN (Select OtherTaskID From Tbl_PM_ProjectTasks where IsActive=1 AND WhichTask ='B' AND EmployeeID=" + _
                    m_UserId.ToString + " AND ProjectID In( " + strProjectList + ")) " + ")"
            End If
        End If
        '*****End Addition******

        'check for session filter
        If Session("Filters").ToString = "" Then

            '****Code Added*******
            'By     :   DipaliS
            'Reason :   My Issue Base Feature
            'Date   :   29 June 2004
            'Requirement Number :   IB_PBN_ENT_03
            'Addition Made  :   'Added the Code To Check whether to apply query or not:
            '   Condition is : Query is not applied if it is the My Issues Mode
            'If (m_strDisplayMode <> "M" And m_LoginType = "E") Or m_LoginType = "C" Then

            '********End Addition********
            'Integrated By Amit J whizible SP 7.2 Issue ID 2596
            If Not m_strQuery Is Nothing Then 'Condition Added By Amit J on 18th july 
                If m_strQuery <> "" And m_strQuery.ToUpper <> MyBase.GetResourceString("NA").ToUpper Then
                    strSQL = strSQL & " AND " & m_strQuery
                End If
            End If
            'end integration
            '****Code Added*******
            'By     :   DipaliS
            'Reason :   My Issue Base Feature
            'Date   :   29 June 2004
            'Requirement Number :   IB_PBN_ENT_03
            'Addition Made  :   End Of If Condition Added Above
            'End If
            '***********End Addition*********

            'Added by AniruddhaD on 17 Nov 2005 for providing projects combo on issue list page (IssueID:685)
            If strProjectList = "" Then
                strProjectList = "0"
            End If
            'end of addition

            strSQL += " AND v_tbl_IB_Issue.ProjectID IN(" & strProjectList & ") "

            '****Code Added*******
            'By     :   DipaliS
            'Reason :   Apply Role Level Security
            'Date   :   24 June 2004
            'Requirement Number :   IB_PBN_ENT_01
            'Addition Made  :  Appnded the Filter for Type to the SQL for Grid

            If strListOfTypes.Trim <> "" Then
                strSQL = strSQL + " AND Type in (" + strListOfTypes + ")"
            End If
            '*********End Of Addition*********

            '****Code Added*******
            'By     :   DipaliS
            'Reason :   My Issue Base Feature
            'Date   :   25 June 2004
            'Requirement Number :   IB_PBN_ENT_03
            'Addition Made  :  Appnded the Filter for My Issues to the SQL for Grid

            If strSQLMyIB.Trim <> "" Then
                strSQL = strSQL + strSQLMyIB
            End If
            '*********End Of Addition*********

            'Added By GaneshG on 17 Nov 06 -- Flag setting for Issue
            If m_strDisplayMode.ToUpper.Trim = "F" Then
                strSQL += " AND IssueID IN (SELECT ContextID FROM tbl_PM_FlagForTracking WHERE ProjectID = v_tbl_IB_Issue.ProjectID " + _
                "AND ContextID = v_tbl_IB_Issue.IssueID AND tbl_PM_FlagForTracking.ContextType = 'IB' " + _
                "AND tbl_PM_FlagForTracking.EmployeeID = " + m_UserId.ToString + ")"
            End If
            'End Addition By GaneshG 

            'Modified By GaneshG on 17 Nov 06 -- Flag setting for Issue
            'Query for getting Issue count 
            'strCountQuery = strCountQuery + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE") + 1)
            strCountQuery = strCountQuery + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE 1 = 1") + 1)
            'End Modification By GaneshG

            'Added by aniruddhad for performance
            'Modified By GaneshG on 17 Nov 06 -- Flag setting for Issue
            'm_strPagingSQL = m_strPagingSQL + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE") + 1)
            m_strPagingSQL = m_strPagingSQL + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE 1 = 1") + 1)
            'End Modification By GaneshG

            'Set the order by clause of view
            If m_OrderBy = "" Then
                'Code Commented By DipaliS 30 Sep 2004
                'Purpose    :   To remove the Default sorting on IssueID
                strSQL += " Order By IssueID Desc "
                m_OrderBy = "IssueID"
                m_Order = "Desc"
            Else
                strSQL += " Order By " + m_OrderBy + " " + m_Order
            End If
        Else
            'apply filter on query
            If Session("intFilterOnQuery").ToString = "1" Then
                '****Code Added*******
                'By     :   DipaliS
                'Reason :   My Issue Base Feature
                'Date   :   29 June 2004
                'Requirement Number :   IB_PBN_ENT_03
                'Addition Made  :   'Added the Code To Check whether to apply filter or not:
                '   Condition is : Query or filter is not applied if it is the My Issues Mode
                'If (m_strDisplayMode <> "M" And m_LoginType = "E") Or m_LoginType = "C" Then

                '********End Addition********
                If Session("UnSavedQuery").ToString <> "" Then
                    strSQL += " AND " + Session("UnSavedQuery").ToString + " And " + Session("Filters").ToString
                Else
                    strSQL += " AND " + Session("Filters").ToString
                    If m_strQuery <> MyBase.GetResourceString("NA") Then
                        strSQL = strSQL + " AND " + m_strQuery
                    End If
                End If

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   My Issue Base Feature
                'Date   :   29 June 2004
                'Requirement Number :   IB_PBN_ENT_03
                'Addition Made  :   End Of If Condition Added Above
                'End If
                '***********End Addition*********

                strSQL += " AND v_tbl_IB_Issue.ProjectID IN(" + strProjectList & ") "

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   24 June 2004
                'Requirement Number :   IB_PBN_ENT_01
                'Addition Made  :  Appnded the Filter for Type to the SQL for Grid

                If strListOfTypes.Trim <> "" Then
                    strSQL = strSQL + " AND Type in (" + strListOfTypes + ")"
                End If
                '*********End Of Addition*********

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   My Issue Base Feature
                'Date   :   25 June 2004
                'Requirement Number :   IB_PBN_ENT_03
                'Addition Made  :  Appnded the Filter for My Issues to the SQL for Grid

                If strSQLMyIB.Trim <> "" Then
                    strSQL = strSQL + strSQLMyIB
                End If
                '*********End Of Addition*********

                'Added By GaneshG on 17 Nov 06 -- Flag setting for Issue
                If m_strDisplayMode.ToUpper.Trim = "F" Then
                    strSQL += " AND IssueID IN (SELECT ContextID FROM tbl_PM_FlagForTracking WHERE ProjectID = v_tbl_IB_Issue.ProjectID " + _
                    "AND ContextID = v_tbl_IB_Issue.IssueID AND tbl_PM_FlagForTracking.ContextType = 'IB' " + _
                    "AND tbl_PM_FlagForTracking.EmployeeID = " + m_UserId.ToString + ")"
                End If
                'End Addition By GaneshG 

                'Query for getting Issue count 
                'Modified By GaneshG on 17 Nov 06 -- Flag setting for Issue
                'strCountQuery = strCountQuery + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE") + 1)
                strCountQuery = strCountQuery + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE 1 = 1") + 1)
                'End Modification By GaneshG

                'Added by aniruddhad for performance
                'Modified By GaneshG on 17 Nov 06 -- Flag setting for Issue
                'm_strPagingSQL = m_strPagingSQL + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE") + 1)
                m_strPagingSQL = m_strPagingSQL + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE 1 = 1") + 1)
                'End Modification By GaneshG

                'Set the order by clause of view
                If m_OrderBy = "" Then
                    'Code Commented By DipaliS 30 Sep 2004
                    'Purpose    :   To remove the Default sorting on IssueID
                    'strSQL += " Order By IssueID Desc "
                Else
                    strSQL += " Order By  " + m_OrderBy + " " + m_Order
                End If
            Else 'if filter is not apply on query 

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   My Issue Base Feature
                'Date   :   29 June 2004
                'Requirement Number :   IB_PBN_ENT_03
                'Addition Made  :   'Added the Code To Check whether to apply filter or not:
                '   Condition is : Query or filter is not applied if it is the My Issues Mode
                'If (m_strDisplayMode <> "M" And m_LoginType = "E") Or m_LoginType = "C" Then
                '********End Addition***********

                strSQL += " AND " & Session("Filters").ToString
                '****Code Added*******
                'By     :   DipaliS
                'Reason :   My Issue Base Feature
                'Date   :   29 June 2004
                'Requirement Number :   IB_PBN_ENT_03
                'Addition Made  :   End Of If Condition Added Above
                'End If
                '***********End Addition*********

                strSQL += " AND v_tbl_IB_Issue.ProjectID IN(" + strProjectList + ") "

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   24 June 2004
                'Requirement Number :   IB_PBN_ENT_01
                'Addition Made  :  Appnded the Filter for Type to the SQL for Grid

                If strListOfTypes.Trim <> "" Then
                    strSQL = strSQL + " AND Type in (" + strListOfTypes + ")"
                End If
                '*********End Of Addition*********

                '****Code Added*******
                'By     :   DipaliS
                'Reason :   My Issue Base Feature
                'Date   :   25 June 2004
                'Requirement Number :   IB_PBN_ENT_03
                'Addition Made  :  Appnded the Filter for My Issues to the SQL for Grid

                If strSQLMyIB.Trim <> "" Then
                    strSQL = strSQL + strSQLMyIB
                End If
                '*********End Of Addition*********

                'Added By GaneshG on 17 Nov 06 -- Flag setting for Issue
                If m_strDisplayMode.ToUpper.Trim = "F" Then
                    strSQL += " AND IssueID IN (SELECT ContextID FROM tbl_PM_FlagForTracking WHERE ProjectID = v_tbl_IB_Issue.ProjectID " + _
                    "AND ContextID = v_tbl_IB_Issue.IssueID AND tbl_PM_FlagForTracking.ContextType = 'IB' " + _
                    "AND tbl_PM_FlagForTracking.EmployeeID = " + m_UserId.ToString + ")"
                End If
                'End Addition By GaneshG 

                'Query for getting Issue count 
                'Modified By GaneshG on 17 Nov 06 -- Flag setting for Issue
                'strCountQuery = strCountQuery + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE") + 1)
                strCountQuery = strCountQuery + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE 1 = 1") + 1)
                'End Modification By GaneshG

                'Added by aniruddhad for performance
                'Modified By GaneshG on 17 Nov 06 -- Flag setting for Issue
                'm_strPagingSQL = m_strPagingSQL + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE") + 1)
                m_strPagingSQL = m_strPagingSQL + Right(strSQL, Len(strSQL) - InStrRev(strSQL, "WHERE 1 = 1") + 1)
                'End Modification By GaneshG

                'Set the order by clause of view
                If m_OrderBy = "" Then
                    'Code Commented By DipaliS 30 Sep 2004
                    'Purpose    :   To remove the Default sorting on IssueID
                    'strSQL += " Order By IssueID Desc "
                Else
                    strSQL += " Order By  " + m_OrderBy + " " + m_Order
                End If
            End If
        End If

        'Code Added By DipaliS 19 July 2004 for hotfix 4.0.5
        'Purpose : To Resolve the issue " Run Time Error occurs when sorted on custom field containing special characters
        'Assumption : The name of Field Name doesn't contain "Order By"
        Dim intOrderByIndex As Integer
        intOrderByIndex = strSQL.LastIndexOf("Order By")
        ''Check if OrderBy Exists -If Order By exists then only add []
        If intOrderByIndex > 0 Then
            Dim strPreClause As String
            Dim strLaterClause As String
            'Get the String after "Order By"
            strPreClause = Right(strSQL, strSQL.Length - intOrderByIndex - Len("Order By"))
            strPreClause = strPreClause.Trim
            'Check if the Order By Clause contains ","
            If InStr(strPreClause, ",") = 0 Then
                If Right(strPreClause, 4).Trim.ToUpper = "ASC" Or Right(strPreClause, 4).Trim.ToUpper = "DESC" Then
                    'If No then directly add [] otherwise split and then add
                    strLaterClause = " [" + Left(strPreClause, Len(strPreClause) - 4).Trim + "] " + Right(strPreClause, 4)
                Else
                    strLaterClause = " [" + strPreClause.Trim + "] "
                End If

            Else
                Dim strClause() As String
                Dim strSep As String = ","
                Dim intCount As Integer
                strClause = strPreClause.Split(strSep.ToCharArray)
                For intCount = 0 To strClause.Length - 1
                    If Right(strClause(intCount), 4).Trim.ToUpper = "ASC" Or Right(strClause(intCount), 4).Trim.ToUpper = "DESC" Then
                        strLaterClause += " [" + Left(strClause(intCount), Len(strClause(intCount)) - 4).Trim + "] " + _
                                                    Right(strClause(intCount), 4) + ","
                    Else
                        strLaterClause += " [" + strClause(intCount).Trim + "] "
                    End If
                Next
                'Remove the last ","
                If intCount > 0 Then
                    strLaterClause = Left(strLaterClause, Len(strLaterClause) - 1)
                End If
            End If
            'Replace the previous cluse with the new one
            strSQL = strSQL.Replace(strPreClause, strLaterClause)
        End If
        'End addition by DipaliS 19 July 2004


        Session("IssueSQL") = strSQL
        m_intIssueCountForAppliedQuery = CType(CommonFunction.Data.GetDataScalar(strCountQuery, MyBase.UseSQL), Long)
        'integrated by harshada D on 15092005 for EXCEL2
        '=========================================================================================
        'Code Added :                   PadmnabhA                   Thursday, July 14, 2005 9:27
        'Purpose    :   Excel format2 is used to show report in Excel. SQL query strSQL is used
        '               for displaying page as well as report. The Image columns in the query are 
        '               on ShowReport page for all the formats exept Excel2. So new query for Exel2
        '               without image columns is generated here.
        '========================================================================================= 
        Dim strColumns, strColumnsForExel2, strSQLForExel2 As String
        strColumns = "SELECT CASE  when  (SELECT COUNT(AttachmentId) AS Attachments FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId ) = 0 then ' ' else '<IMG border=0 src=''../../Images/Pin.gif'' title=''' + cast((SELECT COUNT(AttachmentId) AS Attachments FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId )as varchar) + '''>' end as Attachments,"
        ' strColumns = strColumns + "case when  exists (SELECT top 1 DailyActivityEntryID FROM tbl_PM_DailyActivity INNER  JOIN tbl_PM_ProjectTasks ON tbl_PM_DailyActivity.TaskID=tbl_PM_ProjectTasks.TaskID WHERE(tbl_PM_ProjectTasks.OtherTaskID = v_tbl_IB_Issue.IssueId) AND  tbl_PM_ProjectTasks.WhichTask='B') then '<IMG border=0 src=''../../Images/Timesheet.gif''''>' else '' end as DA,"
        strColumns = strColumns + "'<IMG border=0 src=''../../Images/Discussions.gif'' title=''' + cast(dbo.udf_DiscussionThreadsForIssue(v_tbl_IB_Issue.IssueId, '" & m_LoginType & "') as varchar) + '''>' as Discussions, "
        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access

        If m_blnAddAccess = True Then
            strColumns = strColumns + "'<IMG border=0 src=''../../Images/Copy.gif'' title=''Copy''>' AS Copy, "
        End If

        strColumns = strColumns + m_FieldList + ", "
        'strColumns = strColumns + "case when  exists (SELECT top 1 DailyActivityEntryID FROM tbl_PM_DailyActivity INNER  JOIN tbl_PM_ProjectTasks ON tbl_PM_DailyActivity.TaskID=tbl_PM_ProjectTasks.TaskID WHERE(tbl_PM_ProjectTasks.OtherTaskID = v_tbl_IB_Issue.IssueId) AND  tbl_PM_ProjectTasks.WhichTask='B') then 1 else 0 end as DAPresent"
        strColumns = strColumns + " 0 as DAPresent "
        'Modified by ShraddhaM on Date 17 July,2006 for WhizibleSEM
        strColumns += ", v_tbl_IB_Issue.ProjectID  FROM v_tbl_IB_Issue "


        strColumnsForExel2 = "SELECT /* CASE  when  (SELECT COUNT(AttachmentId) AS Attachments FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId ) = 0 then ' ' else '<IMG border=0 src=''../../Images/Pin.gif'' title=''' + cast((SELECT COUNT(AttachmentId) AS Attachments FROM tbl_IB_Attachments WHERE IssueId = v_tbl_IB_Issue.IssueId )as varchar) + '''>' end as Attachments,"
        ' strColumnsForExel2 = strColumnsForExel2 + "case when  exists (SELECT top 1 DailyActivityEntryID FROM tbl_PM_DailyActivity INNER  JOIN tbl_PM_ProjectTasks ON tbl_PM_DailyActivity.TaskID=tbl_PM_ProjectTasks.TaskID WHERE(tbl_PM_ProjectTasks.OtherTaskID = v_tbl_IB_Issue.IssueId) AND  tbl_PM_ProjectTasks.WhichTask='B') then '<IMG border=0 src=''../../Images/Timesheet.gif''''>' else '' end as DA,"
        strColumnsForExel2 = strColumnsForExel2 + "'<IMG border=0 src=''../../Images/Discussions.gif'' title=''' + cast(dbo.udf_DiscussionThreadsForIssue(v_tbl_IB_Issue.IssueId, '" & m_LoginType & "') as varchar) + '''>' as Discussions, "
        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access
        If m_blnAddAccess = True Then
            strColumnsForExel2 = strColumnsForExel2 + "'<IMG border=0 src=''../../Images/Copy.gif'' title=''Copy''>' AS Copy, "
        End If
        strColumnsForExel2 = strColumnsForExel2 + "*/" + m_FieldList + "  /*, "
        ' '<IMG border=0 src=''../../Images/Copy.gif'' title=''Copy''>' AS Copy, */" " case when  exists (SELECT top 1 DailyActivityEntryID FROM tbl_PM_DailyActivity INNER  JOIN tbl_PM_ProjectTasks ON tbl_PM_DailyActivity.TaskID=tbl_PM_ProjectTasks.TaskID WHERE(tbl_PM_ProjectTasks.OtherTaskID = v_tbl_IB_Issue.IssueId) AND  tbl_PM_ProjectTasks.WhichTask='B') then 1 else 0 end as DAPresent */ "
        strColumnsForExel2 = strColumnsForExel2 + " 0 as DAPresent */"
        strColumnsForExel2 += " FROM v_tbl_IB_Issue"

        strColumns = strColumns.ToString.Trim
        strColumnsForExel2 = strColumnsForExel2.ToString.Trim

        strSQLForExel2 = strSQL.Replace(strColumns, strColumnsForExel2).ToString.Trim

        Session("IssueSQLForExel2") = strSQLForExel2
        'strSQLForExel2
        'strColumnsForExel2
        '=========================================================================================
        'Additon Ends :                 PadmnabhA                   Thursday, July 14, 2005 9:27
        '=========================================================================================
        'end of integration by harshada D on 15092005 for EXCEL2



        Return strSQL

    End Function

    Private Function GetProjectIDs(ByVal intProjectID As Integer) As String
        '**********************************************************************************
        '                  CSPL Code Header
        ' Project Name     :	Chanakya
        ' Function Name    :	GetProjectIDs
        ' Purpose          :	To get the project ids belongs to that project group
        ' Description      :	
        ' Assumptions      :	
        ' Dependencies     :	None.
        ' Author           :	AiruddhaD
        ' Reviewed         :	
        ' Tested           :	
        ' Created          :	Jan 28, 2004
        ' Revisions        :	
        '*******************************************

        Dim drProjects As IDataReader 'To get the recordset
        Dim strSQL As String  'Variable to store the query

        strSQL = ""
        strSQL = "DECLARE @strProjectList varchar(1000) " & vbCrLf
        strSQL = strSQL & " EXEC usp_Sel_tbl_IB_GetListOfSharedProjects " & m_ProjectId & ",@strProjectList OUTPUT" & vbCrLf
        strSQL = strSQL & " SELECT  @strProjectList "

        drProjects = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drProjects.Read Then
            ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
            'Return CType(drProjects(0), String)
            GetProjectIDs = CType(drProjects(0), String)
        Else
            ' Return ""
            GetProjectIDs = ""
            ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        End If

        CommonFunction.Data.DisposeDataReader(drProjects)

    End Function

    Private Function GetQueryName() As String
        '=====================================================================
        ' Procedure Name        : GetQueryName()	
        ' Purpose               : To get name of query applied 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim drDefaultQuery As IDataReader

        'check for query id

        If CType(Session("intQueryID"), Long) = 0 Then 'get the default query
            If Trim(Session("UnsavedQuery").ToString) <> "" Then
                'Modified By PrachiK on 15 Feb 2005 for Issue ID=16329. 
                'Purpose: Issue Base - Apply Without Saving - does not consider selected project into consideration 
                m_strQuery = "(" & Session("UnsavedQuery").ToString & ")"
                'Midification ended
                m_strQueryName = MyBase.GetResourceString("NA") + "(" + MyBase.GetResourceString("QUERYAPPLIEDWITHOUTSAVING") + ")"   '"N/A(Query Applied without saving)"
                'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                'Added by PrajaktaR on 13th April for PCFC 17574 

                'Modified by SandipL on 9 Feb 2006 If Blank is selected in cboSelectQuery then dont apply default Query
                'ElseIf Not HttpContext.Current.Request.QueryString("QueryID") Is Nothing Then
            ElseIf Not HttpContext.Current.Request.QueryString("QueryID") Is Nothing Or (Not MyBase.GetFormValue("cboSelectQuery") Is Nothing And HttpContext.Current.Request.QueryString("ProjectChanged") Is Nothing) Or Not HttpContext.Current.Request.QueryString("FromIssueEntry") Is Nothing Then
                'End modification by SandipL on 9 Feb 2006

                'End of Addition by PrajaktaR on 13th April for PCFC 17574 
                'End Integration
            Else
                'Get the default Query Name		
                strSQL = "Exec usp_Sel_tbl_IB_DefaultQuery " + m_UserId.ToString + ", " + m_ProjectId.ToString + ", '" & m_LoginType.ToString + "'"
                drDefaultQuery = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
        Else 'execute the given query
            Session("UnsavedQuery") = ""
            'execute the given query
            strSQL = "Exec usp_Sel_tbl_IB_Query " & CType(Session("intQueryID"), String)
            drDefaultQuery = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If


        If CType(Session("intQueryID"), Long) >= 0 Then

            If Not drDefaultQuery Is Nothing Then
                If drDefaultQuery.Read Then
                    m_intQueryID = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery("QueryID"), "0"), Long)
                    m_strQueryName = CType(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery("QueryName"), MyBase.GetResourceString("NA")), String)
                    m_strQuery = "(" & CType(CommonFunctions.Data.CheckIsDBNull(drDefaultQuery("QueryText"), ""), String) & ")"
                    Session("intQueryId") = m_intQueryID
                Else
                    m_strQuery = MyBase.GetResourceString("NA")
                    m_strQueryName = MyBase.GetResourceString("NA")

                End If
                'Integrated by MrugajaB on 26th April 2005 for WhizibleSEM SP3
                'Added by PrajaktaR on 13th April for PCFC 17574 
            Else
                'Modified by ShraddhaM on Date 20 July,2006 for WhizibleSEM
                If Trim(Session("UnsavedQuery").ToString) <> "" Then
                    m_strQuery = m_strQuery
                    m_strQueryName = m_strQueryName
                Else
                    m_strQuery = MyBase.GetResourceString("NA")
                    m_strQueryName = MyBase.GetResourceString("NA")
                End If

                'End of Addition by PrajaktaR on 13th April for PCFC 17574 
                'End Integration
            End If
        End If

        'destroy the dataReader object
        CommonFunction.Data.DisposeDataReader(drDefaultQuery)

        Return m_strQueryName

    End Function

    Private Function GetFilters() As String
        '=====================================================================
        ' Procedure Name        : GetFilters()	
        ' Purpose               : To get currently applied filters, if any 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : filter string 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        Dim strFilter As String

        strFilter = MyBase.GetResourceString("CURRENTFILTER")

        If CType(Session("intFilterOnQuery"), String) = "1" Then
            strFilter = strFilter & MyBase.GetResourceString("ONQUERY")
        ElseIf CType(Session("intFilterOnQuery"), String) = "0" Then
            strFilter = strFilter & MyBase.GetResourceString("EXCLUDINGQUERY")
        Else
            strFilter = strFilter
        End If

        Return strFilter
    End Function

    Private Function GetUserFriendlyName(ByVal strFieldName As String) As String
        '=====================================================================
        ' Procedure Name        : GetUserFriendlyName()	
        ' Purpose               : To get user friendly field name for given field
        ' Description           : same as above
        ' Parameters Passed     : strFieldName - Actual Field name
        ' Returns               : user friendly field name (string)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             : 
        '=====================================================================
        Dim strSQL As String
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_CultureId Then
        '    strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'"
        'Else
        '    strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary_Culture '" + Trim(strFieldName) + "'," + m_CultureId.ToString
        'End If

        Dim drUserFriendlyName As IDataReader

        drUserFriendlyName = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drUserFriendlyName.Read Then
            'Return drUserFriendlyName("USerFriendlyName").ToString
            GetUserFriendlyName = drUserFriendlyName("USerFriendlyName").ToString

        Else
            'Return "Not Specified"
            GetUserFriendlyName = "Not Specified"
        End If
        CommonFunctions.Data.DisposeDataReader(drUserFriendlyName)
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

    End Function 'Get user friendly name for field

#End Region

#Region " Public Procedures "

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 2, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 5
        m_LoginId = objGlobal.LoginID
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel

        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID
        'Added by MrugajaB on 09th Mar (IssueID:685)
        Dim strSQL As String
        Dim drProjectAccess As IDataReader
        Dim blnPrjExists As Boolean = False

        'commented by AniruddhaD on 17 Nov 2005 for providing projects combo on issue list page (IssueID:685)
        'm_ProjectId = objGlobal.ProjectID

        'Added by AniruddhaD on 17 Nov 2005 for providing projects combo on issue list page (IssueID:685)
        If Not MyBase.GetFormValue("cboProject") Is Nothing Then
            If MyBase.GetFormValue("cboProject") <> "" Then
                m_ProjectId = CType(MyBase.GetFormValue("cboProject"), Integer)
            Else
                m_ProjectId = 0
            End If
            Session("IssueProject") = m_ProjectId
            'Added by SandipL on 8 Feb 2006 To Solve Issue in crash Issue Filter Page (IssueID:685)
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                Session("intViewID") = ""
                Session("intQueryID") = 0
                Session("intFilterOnQuery") = ""
                Session("Filters") = ""
                Session("UnsavedQuery") = ""


            End If
            'End Addition by SandipL on 8 Feb 2006 (IssueID:685)
        ElseIf Not Session("IssueProject") Is Nothing And (HttpContext.Current.Request.QueryString("StartPage") Is Nothing Or Not HttpContext.Current.Request.QueryString("ApplyFilter") Is Nothing) Then

            m_ProjectId = CType(Session("IssueProject"), Long)

        Else

            'Modified by MrugajaB on 9th March 2006 (Issue ID:685)
            'Purpose:When access level is low, get the accessible projects and accordingly display first project i the combo
            If CType(Session("intRoleLevel"), Integer) = 3 Then
                If CommonFunctions.Application.ShowEvenReleaseFromProject Then
                    strSQL = "Exec usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1"
                Else
                    strSQL = "Exec usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1"
                End If

                drProjectAccess = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

                If CommonFunctions.General.CheckIsNothing(drProjectAccess) <> "" Then
                    While (drProjectAccess.Read)
                        If CType(drProjectAccess("ProjectID"), Long) = CType(Session("intProjectID"), Long) Then
                            blnPrjExists = True
                        End If
                    End While
                End If
                CommonFunction.Data.DisposeDataReader(drProjectAccess)

                If blnPrjExists = True Then
                    m_ProjectId = objGlobal.ProjectID
                    Session("IssueProject") = m_ProjectId
                Else
                    m_ProjectId = 0
                End If
            Else
                m_ProjectId = objGlobal.ProjectID
                Session("IssueProject") = m_ProjectId
            End If
            'End Modification

            'm_ProjectId = objGlobal.ProjectID
            'Session("IssueProject") = m_ProjectId

            'Added by MrugajaB on 02 Mar 2006 To Solve default query/view/filter problem (IssueID:685)
            'Added Condition by PrashantD on 13 March 2007 for IssueId 11573
            If Request.QueryString("cboQuery") = "" Then
                Session("intViewID") = ""
                Session("intQueryID") = 0
            End If

            'End of addition by PrashantD on 13 March 2007
            Session("intFilterOnQuery") = ""
            Session("Filters") = ""
            Session("UnsavedQuery") = ""
            'End Addition

        End If
        'end of addition


        'Code added by SandipL on 15 Feb 2006 --IssueID 2117 -- add edit access according to cboproject projectid instead os WhizGlobal.projectID
        Dim intCorporateRoleLevel As Integer
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_roleId " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select Role from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
            m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)

            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

            If m_RoleId <> 0 Then
                objGlobal.RoleID = m_RoleId
            End If
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            ' m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_level " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

            If m_RoleLevel <> 0 Then
                objGlobal.RoleLevel = m_RoleLevel
            End If
        End If
        'End addition by SandipL
        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        objAccess = Nothing
    End Sub 'Get all session variable values

    Public Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name         : PlotPageHeadTag()	
        ' Purpose               : To plot page head tag 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================
        Call CommonFunction.General.PlotPageHeadTag("Issues")
    End Sub 'Plot Page header tag

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        'Modified by VarunA on 26-Sep-2008
        'Purpose:-Security Issue
        ' MyBase.ApplySecurity()
        ' MyBase.ApplySecurity(True, 1, , , True)
        'End by VarunA on 26-Sep-2008

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub 'Constructor for the page

    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build Issue List page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        'Added by ShraddhaM on 23,Jul 2009
        Dim ApplySearch As String
        Dim arrSearchValue() As String


        m_intCurrentDayOfWeek = System.DateTime.Now.DayOfWeek
        m_intStartingDayOfWeek = CommonFunction.Application.StartingDayofweek

        m_intStartingDayOfWeek += 1
        If m_intStartingDayOfWeek > 7 Then
            m_intStartingDayOfWeek = 1
        End If

        m_dtStartDateOfWeek = StartDateOfWeek(m_intCurrentDayOfWeek, m_intStartingDayOfWeek)
        m_dtEndDateOfWeek = DateAdd(DateInterval.Day, 6, m_dtStartDateOfWeek)

        If strSearchFromDate = "" OrElse strSearchFromDate Is Nothing Then
            strSearchFromDate = m_dtStartDateOfWeek.ToString("dd-MMM-yyyy")
        End If
        If strSearchToDate = "" OrElse strSearchToDate Is Nothing Then
            strSearchToDate = m_dtEndDateOfWeek.ToString("dd-MMM-yyyy")
        End If

        ''Added by Nilesh g on 29/12/2015 for check request from deliverable combobox
        If Not Request.Form("cboDeliverable") Is Nothing And Request.Form("cboDeliverable") <> "" Then
            strDeliverable = CType(CommonFunctions.Data.GetDataScalar("Exec usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString + "," + Replace(Trim(MyBase.GetFormValue("cboDeliverable")), "+", " "), MyBase.UseSQL), String)
            strSearchType = Request.Form("cboDeliverable").ToString()
            strSearchType = strSearchType.Replace("'", "''")
            Session("Deliverable") = Replace(Trim(MyBase.GetFormValue("cboDeliverable")), "+", " ")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchType = ""
            End If
            SearchValue = strDeliverable

        End If
        ''Endded by Nilesh g on 29/12/2015

        If Not Request.Form("txtSummary_Search") Is Nothing And Request.Form("txtSummary_Search") <> "" Then
            strSearchSummary = Request.Form("txtSummary_Search").ToString()
            strSearchSummary_Control = strSearchSummary
            strSearchSummary = strSearchSummary.Replace("''", """")
            strSearchSummary = strSearchSummary.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchSummary = ""
            End If
            SearchValue = strSearchSummary_Control 'strSearchSummary
        End If

        If Not Request.Form("txtDescription_Search") Is Nothing And Request.Form("txtDescription_Search") <> "" Then
            strSearchDescription = Request.Form("txtDescription_Search").ToString()
            strSearchDescription_Control = strSearchDescription
            strSearchDescription = strSearchDescription.Replace("''", """")
            strSearchDescription = strSearchDescription.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchDescription = ""
            End If
            SearchValue = strSearchDescription_Control 'strSearchDescription
        End If

        If Not Request.Form("cboType_Search") Is Nothing And Request.Form("cboType_Search") <> "" Then
            strSearchType = Request.Form("cboType_Search").ToString()
            strSearchType = strSearchType.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchType = ""
            End If
            SearchValue = strSearchType
        End If

        If Not Request.Form("cboStatus_Search") Is Nothing And Request.Form("cboStatus_Search") <> "" Then
            strSearchStatus = Request.Form("cboStatus_Search").ToString()
            strSearchStatus = strSearchStatus.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchStatus = ""
            End If
            SearchValue = strSearchStatus
        End If

        If Not Request.Form("cboResponsible_Search") Is Nothing And Request.Form("cboResponsible_Search") <> "" Then
            strSearchResponsible = Request.Form("cboResponsible_Search").ToString()
            strSearchResponsible = strSearchResponsible.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchResponsible = ""
            End If
            SearchValue = strSearchResponsible
        End If

        If Not Request.Form("cboSubmitted_Search") Is Nothing And Request.Form("cboSubmitted_Search") <> "" Then
            strSearchSubmittedBy = Request.Form("cboSubmitted_Search").ToString()
            strSearchSubmittedBy = strSearchSubmittedBy.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strSearchSubmittedBy = ""
            End If
            SearchValue = strSearchSubmittedBy
        End If

        If Not Request.Form("cboShowtoCust_Search") Is Nothing And Request.Form("cboShowToCust_Search") <> "" Then
            strShowToCustSearch = Request.Form("cboShowtoCust_Search").ToString()
            ' strShowToCustSearch = strShowToCustSearch.Replace("'", "''")
            If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                strShowToCustSearch = ""
            End If
            SearchValue = strShowToCustSearch
        End If



        If Not Request.Form("dtFromDate_Search") Is Nothing And HttpContext.Current.Request("ProjectChanged") Is Nothing Then
            strSearchFromDate = Request.Form("dtFromDate_Search").ToString()
            'SearchValue = strSearchFromDate
        End If

        If Not Request.Form("dtToDate_Search") Is Nothing And HttpContext.Current.Request("ProjectChanged") Is Nothing Then
            strSearchToDate = Request.Form("dtToDate_Search").ToString()
            'SearchValue = strSearchToDate
        End If

        m_SearchClause = ""

        If Not Request.Form("cboSearch") Is Nothing And Request.Form("cboSearch") <> "" Then
            SearchType = CType(Request.Form("cboSearch"), Int16)
        Else
            SearchType = CType(Request.QueryString("IssueListSearchType"), Int16)
        End If

        If Not HttpContext.Current.Request("ProjectChanged") Is Nothing Then
            SearchType = 1
        End If

        If SearchType = 7 Or SearchType = 9 Then
            SearchValue = strSearchFromDate + "|" + strSearchToDate
        End If

        If Not Request.QueryString("IssueListSearchValue") Is Nothing And Request.QueryString("IssueListSearchValue") <> "" Then
            SearchValue = Request.QueryString("IssueListSearchValue").ToString()
            ApplySearch = 1
            If SearchType = 1 Then
                strSearchSummary = SearchValue
                strSearchSummary = strSearchSummary.Replace("'", "''")
                strSearchSummary_Control = SearchValue
            ElseIf SearchType = 2 Then
                strSearchDescription = SearchValue
                strSearchDescription = strSearchDescription.Replace("'", "''")
                strSearchDescription_Control = SearchValue
            ElseIf SearchType = 3 Then
                strSearchType = SearchValue
            ElseIf SearchType = 4 Then
                strSearchStatus = SearchValue
            ElseIf SearchType = 5 Then
                strSearchResponsible = SearchValue
            ElseIf SearchType = 6 Then
                strSearchSubmittedBy = SearchValue
            ElseIf SearchType = 7 Or SearchType = 9 Then
                arrSearchValue = SearchValue.Split("|")
                strSearchFromDate = arrSearchValue(0)
                strSearchToDate = arrSearchValue(1)
            ElseIf SearchType = 8 Then
                strShowToCustSearch = SearchValue

                ''added by Nilesh g on 29/12/2015 for add deliverable
            ElseIf SearchType = 10 Then
                strDeliverable = SearchValue
                strSearchType = Session("Deliverable")
                ''  strDeliverable = CType(CommonFunctions.Data.GetDataScalar("Exec usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString + "," + Replace(Trim(MyBase.GetFormValue("cboDeliverable")), "+", " "), MyBase.UseSQL), String)
            End If


        End If


        If Not Request.QueryString("ApplySearch") Is Nothing And Request.QueryString("ApplySearch") <> "" Then
            ApplySearch = Request.QueryString("ApplySearch").ToString()
        End If

        'If ApplySearch = 1 Then
        GenerateFilterClause()
        'End If
        'Ended by ShraddhaM


        'Addition done by SuchitraP on 13 Feb 2008
        If Request.QueryString("StartPage") = "1" And Request.QueryString("FromWhere") = "BTS" Then
            Session("ShowAllProjects_IB") = Nothing
        End If
        If Session("ShowAllProjects_IB") Is Nothing Then
            If CType(Session("intRoleLevel"), Integer) = 3 Then
                Session("ShowAllProjects_IB") = "NULL"
            Else
                Dim Sesson_Project_Status As Boolean
                If Not Session("intProjectID") Is Nothing Then
                    'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                    'Sesson_Project_Status = CType(CommonFunction.Data.GetDataScalar("SELECT [OVER] FROM tbl_PM_Project WHERE ProjectID = " + Session("intProjectID").ToString, MyBase.UseSQL), Boolean)
                    Sesson_Project_Status = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_OVER " + Session("intProjectID").ToString, MyBase.UseSQL), Boolean)
                    'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                Else
                    Sesson_Project_Status = False
                End If
                If Sesson_Project_Status = True Then
                    Session("ShowAllProjects_IB") = "1"
                Else
                    Session("ShowAllProjects_IB") = "0"
                End If

            End If
        End If

        If Request.QueryString("SelectAll") = "1" Then
            Session("ShowAllProjects_IB") = "1"
        ElseIf Request.QueryString("SelectAll") = "0" Then
            Session("ShowAllProjects_IB") = "0"
        End If
        'End of addition by SuchitraP

        ''' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        m_PKToken_FromIssueList = CommonFunctions.Security.Token.GetToken(CType(Session("IssueProject"), String) + CType(m_UserId, String) + "0" + "0")
        ''' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

        Call ReadXML()
        'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
        Dim strGridSQL As String

        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode")
        Else
            m_strMode = ""
        End If

        If Not Request.QueryString("OrderBy") Is Nothing Then
            m_strUserOrderByField = Request.QueryString("OrderBy")
        Else
            m_strUserOrderByField = ""
        End If

        If Not Request.QueryString("ASCDESC") Is Nothing Then
            m_strAscOrDesc = Request.QueryString("ASCDESC")
        Else
            m_strAscOrDesc = ""
        End If
        'Added by SandipL on 9 Feb 2006 -- To Initialize Sorting Column
        If Not Request.QueryString("OrderBy") Is Nothing Then
            m_strSortBy = Request.QueryString("OrderBy")
        Else
            m_strSortBy = ""
        End If
        'End Addition by SandipL
        If CommonFunction.General.CheckIsNothing(Request.QueryString("Mode"), " ").ToUpper = "DEFAULT" Then
            m_intQueryID = 0
        ElseIf Not MyBase.GetFormValue("cboSelectQuery") Is Nothing Then
            If MyBase.GetFormValue("cboSelectQuery") <> "" Then
                m_intQueryID = CType(MyBase.GetFormValue("cboSelectQuery"), Long)
            Else
                m_intQueryID = 0
            End If
        ElseIf Not Session("intQueryID") Is Nothing Then
            If Session("intQueryID").ToString <> "" Then
                m_intQueryID = CType(Session("intQueryID"), Long)
            Else
                m_intQueryID = 0
            End If
            'Else
            '    m_intQueryID = 0
        End If

        m_strUserOrderByClause = m_strUserOrderByField + " " + m_strAscOrDesc

        'If page is for default mode, reset all session variables
        If m_strMode.ToUpper = "DEFAULT" Then
            Session("intViewID") = ""
            Session("intQueryID") = 0
            Session("intFilterOnQuery") = ""
            Session("Filters") = ""
            Session("UnsavedQuery") = ""
        ElseIf m_strMode.ToUpper = "DELETE" Then
            Call DeleteIssues() 'Delete Issue if page is opened in delete mode.
        Else
            If m_intQueryID.ToString <> "" And HttpContext.Current.Request("ProjectChanged") Is Nothing Then
                Session("intQueryID") = m_intQueryID
            Else
                Session("intQueryID") = 0
            End If

            If Session("Filters") Is Nothing Then
                Session("Filters") = ""
            End If

            If Session("intViewID") Is Nothing Then
                Session("intViewID") = ""
            End If

            If Session("UnsavedQuery") Is Nothing Then
                Session("UnsavedQuery") = ""
            End If

        End If

        'commented by AniruddhaD on 17 Nov 2005 for for providing projects combo on issue list page (IssueID:685)
        'If there is no project in session, then make user to select project.
        'If m_ProjectId = 0 Then
        '    'Initialize standard menu resource file 
        '    MyBase.InitializeResources("AppResources.IB_IssueList", "AppResources")

        '    Response.Write("<TABLE class=clsTable width='100%'><TR class=clsTREven><TD width='100%' align=center>" + MyBase.GetResourceString("NOPROJECT") + "</TD></TR></TABLE>")
        '    Exit Sub
        'End If

        'commented by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
        'If Not Session("intBTSProjectID") Is Nothing Then
        '    If Session("intBTSProjectID").ToString <> Session("intProjectID").ToString Then
        '        Session("intBTSProjectID") = Session("intProjectID")
        '        Session("intViewID") = ""
        '        Session("intQueryId") = "0"
        '        Session("Filters") = ""
        '    End If
        'Else
        '    Session("intBTSProjectID") = Session("intProjectID")
        'End If
        'end of comment

        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        Else
            m_intPageNumber = 1
        End If

        Dim strMenu As String 'Contains string for menu (to be used twice - Top and bottom of page)

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   My Issues Feature
        'Date   :   25 June 2004
        'Requirement Number :   IB_PBN_ENT_03
        'Addition Made  :  
        'If Mode is not specified then show the default mode
        If Not Request.QueryString("DisplayMode") Is Nothing Then
            m_strDisplayMode = CType(Request.QueryString("DisplayMode"), String)
            Session("MyIssueMode") = m_strDisplayMode
        Else
            If Not Session("MyIssueMode") Is Nothing Then
                m_strDisplayMode = CType(Session("MyIssueMode"), String)
            Else
                m_strDisplayMode = "A"
            End If
        End If
        '*********End Addition*******

        ''------------------------------------------------------------------------------------------
        ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module for Whiziblesem SP 7 Issue ID 5688 
        Dim strSQLAllIssueTabAccess As String = ""
        Dim blnDisableAllIssueTab As Boolean = False

        strSQLAllIssueTabAccess = "Exec usp_chk_AllIssueTabAccess " + m_ProjectId.ToString + ", " + m_UserId.ToString
        blnDisableAllIssueTab = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLAllIssueTabAccess, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Boolean)
        'Added By ShraddhaM on 3,July 2007 To Display BatchUpdate Link as Access Given In Issue Types - Configure type Security
        'usp_chk_BatchUpdateAccess
        m_blnBatchUpdateAccess = CType(CommonFunction.Data.GetDataScalar("usp_chk_BatchUpdateAccess " + m_ProjectId.ToString + ", " + m_UserId.ToString, MyBase.UseSQL), Boolean)

        'Ended By ShraddhaM on 3,July 2007 To Display BatchUpdate Link as Access Given In Issue Types - Configure type Security
        'Modified By GaneshG on 08 Nov 06 -- Flag setting for Issue
        'If blnDisableAllIssueTab Then
        If blnDisableAllIssueTab And m_strDisplayMode <> "F" Then
            m_strDisplayMode = "M"
        End If
        'End Modification By GaneshG 

        ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
        ''------------------------------------------------------------------------------------------

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        ''Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
        ''Purpose: Not allow to do any activity if Project is not baselined
        'm_blnIsProjectCreationWorkflowReqd = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_PM_GetProjectCreationWorkflowReqd_Status " & CommonFunction.General.CheckIsNothing(Session("intProjectID").ToString, "0").ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
        'Dim strQuery As String = ""
        'Dim drProjectStatus As IDataReader

        'strQuery = "EXEC usp_Sel_tbl_CNF_Project_Status " & HttpContext.Current.Session("intProjectID").ToString

        'drProjectStatus = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If CommonFunctions.General.CheckIsNothing(drProjectStatus) <> "" Then
        '    If drProjectStatus.Read() Then
        '        m_intBaselineNumber = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drProjectStatus("BaselineNumber"), "0"), "0"), Integer)
        '    End If
        'End If
        'CommonFunctions.Data.DisposeDataReader(drProjectStatus)
        ''If m_blnIsProjectCreationWorkflowReqd = True Then
        ''    If m_intBaselineNumber = 0 Then
        ''        Args.ToBeInsertedInFunction += "alert('Project related activities such as adding Task/Resource/Timesheet entry cannot be performed as the Project is not Baselined.');" & vbCrLf
        ''        Args.ToBeInsertedInFunction += "return;"
        ''    End If
        ''End If
        ''Addtion ended

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Get Menu string 

        'if condition added by AniruddhaD on 18 Nov 2005 for Project combo on issue list IssueID:685)

        'Added By JyotiG
        'Issue Id : 6566
        'Date : 04-Oct-2006
        'Start
        'Pupose: Check Resource is released or not
        Dim drReleaseResource As IDataReader
        Dim strReleaseResource As String
        If m_RoleLevel = 3 Then
            If Not CommonFunctions.Application.ShowEvenReleaseFromProject Then
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strReleaseResource = "Select ActualEndDate from tbl_Pm_ProjectEmployeeRole where EmployeeID =" + m_UserId.ToString + " and ProjectId =" + m_ProjectId.ToString
                strReleaseResource = "usp_sel_Actual_tbl_Pm_ProjectEmployeeRole " + m_UserId.ToString + "," + m_ProjectId.ToString

                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                drReleaseResource = CommonFunction.Data.GetDataReader(strReleaseResource, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drReleaseResource.Read Then
                    If CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drReleaseResource("ActualEndDate"), ""), "") <> "" Then
                        m_ProjectId = 0
                    End If
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drReleaseResource)
        End If
        'End Modification By JyotiG

        If m_ProjectId > 0 Then strMenu = GenerateMenu()

        'Write menu (Top of page)
        Response.Write(strMenu)

        'Div for fixing menu position at bottom
        'CommonFunction.General.WriteHTML("<div id='MainDiv' style='OVERFLOW:auto; HEIGHT: 500px'>")

        'Generate Information Section for Issue
        Call GenerateInformationSection()


        '****Code Added*******
        'By     :   DipaliS
        'Reason :   My Issues Feature
        'Date   :   25 June 2004
        'Requirement Number :   IB_PBN_ENT_03
        'Addition Made  :   Called the function which writes tabs for All Issues and My Issues
        'If the employee is logged in then only show the tabs, otherwise show the normal display.
        'Code added by SandipL on 8 Feb 2006 
        'If no Project is selected then Display Message and exit
        If m_ProjectId = 0 Then
            MyBase.InitializeResources("AppResources.IB_IssueList", "AppResources")
            Response.Write("<TABLE class=clsTable width='99.9%'><TR class=clsTREven><TD width='99.9%' align=center>" + MyBase.GetResourceString("NOPROJECT") + "</TD></TR></TABLE>")
            Exit Sub
        End If
        'End addition by SandipL on 8 Feb 2006



        If m_LoginType.ToLower = "e" Then
            'Added by ShraddhaM on 23,Jul 2009 for Search filter 
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 width='99.9%' cellpadding=0>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRBody'>")
            CommonFunctions.General.WriteHTML("<TD valign=bottom>Search &nbsp;")
            GenerateFilterSection()
            CommonFunctions.General.WriteHTML("<a href='javascript:ApplyAdvancedFilter()'>&nbsp;Show</a></TD>")
            CommonFunctions.General.WriteHTML("<TD valign=bottom align=Right>")
            'Ended by ShraddhaM
            GenerateTabSections()

            'Added by ShraddhaM on 23,Jul 2009 for Search filter 
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</Table>")
            'Ended by ShraddhaM
            ''Commented and Added By Vidya J ON 14 Jun 2016
            'CommonFunctions.General.WriteHTML("<table class='clsSubtagTable' width='99.9%'><TR><TD valign='top'>")
            CommonFunctions.General.WriteHTML("<table class='clsSubtagTable' width='99.9%' style='table-layout:fixed'><TR><TD valign='top'>")
            ''Commented and Added By Vidya J ON 14 Jun 2016
        Else
            'Added by ShraddhaM on 23,Jul 2009 for Search filter 
            CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellspacing=0 width='99.9%' cellpadding=0>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRBody'>")
            CommonFunctions.General.WriteHTML("<TD valign=bottom >Search &nbsp;")
            GenerateFilterSection()
            CommonFunctions.General.WriteHTML("<a href='javascript:ApplyAdvancedFilter()'>&nbsp;Show</a></TD>")
            'CommonFunctions.General.WriteHTML("<TD valign=bottom align=Right>")
            'Ended by ShraddhaM
            'GenerateTabSections()

            'Added by ShraddhaM on 23,Jul 2009 for Search filter 
            'CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TR>")
            CommonFunctions.General.WriteHTML("</Table>")
            'Ended by ShraddhaM

            'CommonFunctions.General.WriteHTML("<table class='clsSubtagTable' ><TR><TD valign='top'>")

        End If
        '*****End Addition

        strGridSQL = GenerateQueryForGrid()

        'Draw paging for IssueList Grid
        Call DrawPaging(m_strPagingSQL)

        'Plot Grid
        Call PlotGrid(strGridSQL)


        'end of div for fixing menu position at bottom
        'Response.Write("</div>")

        'Write menu (bottom of page)
        ' Response.Write(strMenu)

    End Sub 'Main procedure to build the Issue List page

#End Region

#Region " Private Procedures "
    'Added by ShraddhaM on 23,Jul 2009 for Search filter 
    Private Sub GenerateFilterClause()



        If SearchType = 1 And strSearchSummary <> "" Then
            strSearchSummary = strSearchSummary.Replace("%", "[%]")
            m_SearchClause = m_SearchClause + " AND Summary like '%" + strSearchSummary + "%'"
        ElseIf SearchType = 2 And strSearchDescription <> "" Then
            strSearchDescription = strSearchDescription.Replace("%", "[%]")
            m_SearchClause = m_SearchClause + " AND Description like '%" + strSearchDescription + "%'"
        ElseIf SearchType = 3 And strSearchType <> "" Then
            m_SearchClause = m_SearchClause + " AND Type='" + strSearchType + "'"
        ElseIf SearchType = 4 And strSearchStatus <> "" Then
            m_SearchClause = m_SearchClause + " AND status='" + strSearchStatus + "'"
        ElseIf SearchType = 5 And strSearchResponsible <> "" Then
            m_SearchClause = m_SearchClause + " AND AssignToName='" + strSearchResponsible + "'"
        ElseIf SearchType = 6 And strSearchSubmittedBy <> "" Then
            m_SearchClause = m_SearchClause + " AND ReportedBy='" + strSearchSubmittedBy + "'"
        ElseIf (SearchType = 7) Then
            'm_SearchClause = m_SearchClause + " AND ReportedDate >= isnull('" + strSearchFromDate + "',ReportedDate) AND ReportedDate <= isnull('" + strSearchToDate + "',ReportedDate)"

            If strSearchFromDate <> "" Then
                ' Commented and modified by GaneshD on 24 Sep 2009
                'm_SearchClause = m_SearchClause + " AND ReportedDate >= isnull('" + strSearchFromDate + "',ReportedDate) "
                m_SearchClause = m_SearchClause + " AND DateDIFF(dd,ReportedDate,'" & strSearchFromDate & "') <=0"
                ' End of modification by GaneshD on 24 Sep 2009
            End If

            If strSearchToDate <> "" Then
                ' Commented and modified by GaneshD on 24 Sep 2009
                'm_SearchClause = m_SearchClause + " AND ReportedDate <= isnull('" + strSearchToDate + "',ReportedDate)"
                m_SearchClause = m_SearchClause + " AND DateDIFF(dd,ReportedDate,'" & strSearchToDate & "') >=0"
                ' End of modification by GaneshD on 24 Sep 2009
            End If
        ElseIf (SearchType = 8) Then
            If strShowToCustSearch <> "" Then
                m_SearchClause = m_SearchClause + " AND ISNULL(ShowToCustomer,0) =  " + CType(strShowToCustSearch, String)
            End If


            ' Code and Added by GaneshD on 24 Sep 2009 For adding filter[Where Clause] for last updated field
        ElseIf (SearchType = 9) Then
            If strSearchFromDate <> "" Then
                m_SearchClause = m_SearchClause + " AND DateDIFF(dd,LastUpdatedDate,'" & strSearchFromDate & "') <=0"
            End If
            ''Added by Nilesh g on 29/12/2015 for add deliverable
        ElseIf SearchType = 10 And strDeliverable <> "" Then
            m_SearchClause = m_SearchClause + " AND Deliverable='" + strDeliverable + "'"
            ''ENdded by Nilesh g on 29/12/2015 for add deliverable
            'If strSearchToDate <> "" Then
            '    m_SearchClause = m_SearchClause + " AND DateDIFF(dd,LastUpdatedDate,'" & strSearchToDate & "') >=0"
            'End If
            ' End of addition by GaneshD on 24 Sep 2009
        End If

    End Sub
    Private Sub GenerateFilterSection()

        ''''''''''''''''''''
        'SearchTypes
        '1  Summary
        '2  Description
        '3  Issue Type
        '4  Status
        '5  ResponsiblePerson
        '6  Submitted by
        '7  Reported Date

        ''''''''''''''''''''


        CommonFunctions.HTMLControls.DrawComboBox("cboSearch", "usp_sel_IssueBaseSearchOptions  '" & m_LoginType & "'", 150, SearchType.ToString(), "onchange='javascript:SeachChange()'")

        If (SearchType <> 0 Or Page.IsPostBack = False) And SearchType <> 7 Then
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;<span id='searchfor'>for</span>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("&nbsp;&nbsp;<span id='searchfor' Style='display:none'>for</span>&nbsp;")
        End If

        If SearchType = 1 Or SearchType = 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtSummary_Search", "txtSummary_Search", , 150, 200, strSearchSummary_Control, , , , , , , " title='Contains' onkeypress=TextSearch_KeyPress(event)", EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        Else
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtSummary_Search", "txtSummary_Search", , 150, 200, strSearchSummary_Control, , , , , , , " title='Contains' onkeypress=TextSearch_KeyPress(event)", DisplayNone:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        End If

        If SearchType = 2 Then
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txtDescription_Search", "txtDescription_Search", , 150, 200, strSearchDescription_Control, , , , , , , " title='Contains' onkeypress=TextSearch_KeyPress(event)", EnableHTMLEncode:=True)
        Else
            CommonFunctions.HTMLControls.DrawTextBox("txtDescription_Search", "txtDescription_Search", , 150, 200, , , , , , , , " title='Contains' onkeypress=TextSearch_KeyPress(event)", DisplayNone:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        End If

        If SearchType = 3 Then
            CommonFunctions.HTMLControls.DrawComboBox("cboType_Search", "Usp_Sel_tbl_IB_Project_Sub_Type_TYPE " + m_ProjectId.ToString, 150, strSearchType, , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboType_Search", "Usp_Sel_tbl_IB_Project_Sub_Type_TYPE " + m_ProjectId.ToString, 150, , , True, DisplayNone:=True)
        End If

        If SearchType = 4 Then
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus_Search", "usp_Sel_tbl_IB_Project_Type_Status_Status " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, strSearchStatus, , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus_Search", "usp_Sel_tbl_IB_Project_Type_Status_Status " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, , , True, DisplayNone:=True)
        End If

        If SearchType = 5 Then
            CommonFunctions.HTMLControls.DrawComboBox("cboResponsible_Search", "Usp_Sel_IB_Project_Resources_ProjectGroup " + m_ProjectId.ToString, 150, strSearchResponsible, , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboResponsible_Search", "Usp_Sel_IB_Project_Resources_ProjectGroup " + m_ProjectId.ToString, 150, , , True, DisplayNone:=True)
        End If

        If SearchType = 6 Then
            CommonFunctions.HTMLControls.DrawComboBox("cboSubmitted_Search", "Usp_Sel_IB_ReportedBy " + m_ProjectId.ToString, 150, strSearchSubmittedBy, , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboSubmitted_Search", "Usp_Sel_IB_ReportedBy " + m_ProjectId.ToString, 150, , , True, DisplayNone:=True)
        End If


        If SearchType = 7 Or SearchType = 9 Then
            CommonFunctions.General.WriteHTML("&nbsp;<span id='searchFromDate'>From</span>&nbsp;")
            CommonFunctions.HTMLControls.DrawDateControl("dtFromDate_Search", "dtFromDate_Search", , , strSearchFromDate, , "frmIssueList", "..\..\images\Calendar.gif' id='imgCalendarFrom", , , , , , , , , , )
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendarFrom", " style='CURSOR: hand;'", "javascript:Calender_OnClick('dtFromDate_Search')", , , "Click to open calendar", True))

            CommonFunctions.General.WriteHTML("&nbsp;<span id='searchToDate'>To</span>&nbsp;")
            CommonFunctions.HTMLControls.DrawDateControl("dtToDate_Search", "dtToDate_Search", , , strSearchToDate, , "frmIssueList", "..\..\images\Calendar.gif' id='imgCalendarTo", , , , , , , , , , )
            'CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendarTo", " style='CURSOR: hand;'", "javascript:Calender_OnClick('dtToDate_Search')", , , "Click to open calendar", True))
            ' Code Commeted by GaneshD on 24 Sep 2009 as it is not required
        Else
            CommonFunctions.General.WriteHTML("&nbsp;<span id='searchFromDate' Style='display:none'>From</span>&nbsp;")
            CommonFunctions.HTMLControls.DrawDateControl("dtFromDate_Search", "dtFromDate_Search", , , strSearchFromDate, , , , , , , , , , , , , True, )
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendarFrom", " style='Display: none; CURSOR: hand;'", "javascript:Calender_OnClick('dtFromDate_Search')", , , "Click to open calendar", True))

            CommonFunctions.General.WriteHTML("&nbsp;<span id='searchToDate' Style='display:none'>To</span>&nbsp;")
            CommonFunctions.HTMLControls.DrawDateControl("dtToDate_Search", "dtToDate_Search", , , strSearchToDate, , , , , , , , , , , , , True, )
            CommonFunctions.General.WriteHTML(CommonFunctions.HTMLControls.DrawImage("../../Images/calendar.gif", "imgCalendarTo", " style='Display: none; CURSOR: hand;'", "javascript:Calender_OnClick('dtToDate_Search')", , , "Click to open calendar", True))
            ' End of modification by GaneshD

        End If

        If SearchType = 8 Then
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            '    CommonFunctions.HTMLControls.DrawComboBox("cboShowToCust_Search", "SELECT 1,'YES' UNION SELECT 0,'NO' ", 150, strShowToCustSearch, , True)
            'Else
            '    CommonFunctions.HTMLControls.DrawComboBox("cboShowToCust_Search", "SELECT 1,'YES' UNION SELECT 0,'NO' ", 150, , , True, DisplayNone:=True)
            CommonFunctions.HTMLControls.DrawComboBox("cboShowToCust_Search", "usp_sel_union_Select", 150, strShowToCustSearch, , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboShowToCust_Search", "usp_sel_union_Select", 150, , , True, DisplayNone:=True)

            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

            
        End If
        ''Added by Nilesh g on 29/12/2015 for add Deliverable Combobox
        If SearchType = 10 Then
            CommonFunction.HTMLControls.DrawComboBox("cboDeliverable", "usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString, 150, strSearchType, , True)
        Else
            CommonFunction.HTMLControls.DrawComboBox("cboDeliverable", "usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString, 150, , , True, DisplayNone:=True)
        End If
        ''Endded by Nilesh g on 29/12/2015 for add Deliverable Combobox

    End Sub
    Private Function StartDateOfWeek(ByVal m_intCurrentDayOfWeek As Integer, ByVal m_intStartingDayOfWeek As Integer) As Date
        Dim tempDate As Date
        Dim intWD As Integer = Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday)

        Select Case m_intStartingDayOfWeek
            Case 1
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Sunday) - 1), System.DateTime.Now)
            Case 2
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Monday) - 1), System.DateTime.Now)
            Case 3
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Tuesday) - 1), System.DateTime.Now)
            Case 4
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Wednesday) - 1), System.DateTime.Now)
            Case 5
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Thursday) - 1), System.DateTime.Now)
            Case 6
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Friday) - 1), System.DateTime.Now)
            Case 7
                tempDate = DateAdd(DateInterval.Day, -(Weekday(System.DateTime.Now, Microsoft.VisualBasic.FirstDayOfWeek.Saturday) - 1), System.DateTime.Now)
        End Select
        Return tempDate

    End Function

    'Ended by ShraddhaM on 23,Jul 2009 for Search filter 

    Private Sub DrawPaging(ByVal PagingSQL As String)

        'open recordset to get the project and resouce setting for rows per page to set the page size
        Dim drPageSize As IDataReader
        drPageSize = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DefaultSettings " + m_ProjectId.ToString & ",'" + m_LoginType + "'," & m_UserId.ToString, MyBase.UseSQL)

        If drPageSize.Read Then
            m_PageSize = CType((CommonFunctions.Data.CheckIsDBNull(drPageSize("IBRowsPerPage"), "20")), Long)
        Else 'if not set then default
            m_PageSize = 20 'Set as 20 records per Page
        End If

        'Dispose datareader
        CommonFunction.Data.DisposeDataReader(drPageSize)

        Dim dblRatio As Double = m_intIssueCountForAppliedQuery / m_PageSize
        'Draw paging for IssueList
        If System.Math.Ceiling(dblRatio) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, "PAGES:", , "", True, , , True, m_PageSize)
        Dim strPaging As String
        'Code commented and added by ShraddhaM on 11,July 2007 for CleanUp Activity
        'If m_intPageNumber = -1 Or dblRatio = 0 Then
        '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        'Else
        '    strPaging = "Page " + CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 30, 4, m_intPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True)
        'End If
        'style=vertical-align:top property added by Vaijat K ON 04/11/2015
        strPaging = "<A style='TEXT-DECORATION:NONE;vertical-align:top' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top' style='vertical-align:top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE;vertical-align:top' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top' style='vertical-align:top'></A>"

        If m_intPageNumber = -1 Or dblRatio = 0 Then
            'Commented and added by Yogesh J for HTML encoding Date:07/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", "vertical-align:top; margin-top: 0px !important;", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", "vertical-align:top;     margin-top: 0px !important;", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:07/10/15
        End If
        strPaging += "<A style='TEXT-DECORATION:NONE;vertical-align:top' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top' style='vertical-align:top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE;vertical-align:top' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top' style='vertical-align:top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intIssueCountForAppliedQuery / 20)).ToString + ">"

        'End of comment and addition by ShraddhaM on 11,July 2007 for CleanUp Activity

        strPaging += "<b style='vertical-align:top'> of " + Math.Ceiling(dblRatio).ToString + "</b>"
        strPaging += "|<A href='javascript:Page_Onclick(""-1"")' TITLE='Show All Records' style='vertical-align:top'><B>All</B> </A>"
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , Math.Ceiling(dblRatio).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15

        If strPaging <> "" Then
            '    strPaging = Replace(strPaging, "PAGES: ", "PAGES:")
            '    If dblRatio > 50 Then
            ''Code Commented by DipaliS and Added the Followoing 8 July 2004
            ''Response.Write("<DIV style='Height:40;width:100%;Overflow:auto'>")
            ''Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=left>" + strPaging + "</TD></TR></Table>")
            'If m_LoginType = "C" Then
            '    Response.Write("<DIV style='Height:40;width:100%;Overflow:auto'>")
            '    Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=left>" + strPaging + "</TD></TR></Table>")
            'Else

            'Response.Write("<DIV ID='DivPaging' style='Height:40;Overflow:auto'>")
            '    Response.Write("<Table class=clsTable width='100%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=left>" + strPaging + "</TD></TR></Table>")
            'End If
            'End Addition
            '    Response.Write("</DIV>")
            'Else
            Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            'End If

            ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 


        End If


    End Sub

    Private Sub GenerateInformationSection()
        '=====================================================================
        ' Procedure Name        : GenerateInformationSection (Below top menu)
        ' Purpose               : To generate Information section
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================
        'Addition done by SuchitraP on 13 Feb 2008
        Dim strPlotLink As String
        If CType(Session("ShowAllProjects_IB"), String) = "1" Then
            strPlotLink = "<A HREF=""Javascript:ShowOpenProj()"" Title=""Click to view Only Open Projects"" >Show Open Projects</A>"
        ElseIf CType(Session("ShowAllProjects_IB"), String) = "0" Then
            strPlotLink = "<A HREF=""Javascript:ShowAllProj()"" Title=""Click to view All Projects"" >Show All Projects</A>"
        Else
            strPlotLink = ""
        End If
        'End of addition by SuchitraP

        'Initialize Resource file for IssueList
        MyBase.InitializeResources("AppResources.IB_IssueList", "AppResources")

        'Information section for Issue list page
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        With cObjSectionTitle
            'Commented by AniruddhaD on 17 Nov 2005 for providing projects combo on issue list page (IssueID:685)
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), , , , , , , True))

            'Added by AniruddhaD on 17 Nov 2005 for providing projects combo on issue list page (IssueID:685)
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_Project_For_DA_New " & m_UserId, , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True), , , , , , True))
            'Modified by SandipL on 31 Jan 2006 -- IssueID 1820 & IssueID 2114 -- Showing Accessible projects to middle level resources
            If CommonFunctions.Application.ShowEvenReleaseFromProject Then
                'Comment and modification by SuchitraP on 13 Feb 2008
                'Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True), , , , , , True))
                If CType(Session("ShowAllProjects_IB"), String) = "NULL" Then
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True) + strPlotLink, , , , , , True))
                ElseIf CType(Session("ShowAllProjects_IB"), String) = "1" Then
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,1", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True) + strPlotLink, , , , , , True))
                Else
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',1," & CType(Session("intLoginID"), String) & ",0,0", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True) + strPlotLink, , , , , , True))
                End If
                'End of modification by SuchitraP 
            Else
                'Comment and modification by SuchitraP on 13 Feb 2008
                'Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',0," & CType(Session("intLoginID"), String) & ",0,1", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True), , , , , , True))
                If CType(Session("ShowAllProjects_IB"), String) = "NULL" Then
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',0," & CType(Session("intLoginID"), String) & ",0,1", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True) + strPlotLink, , , , , , True))
                ElseIf CType(Session("ShowAllProjects_IB"), String) = "1" Then
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',0," & CType(Session("intLoginID"), String) & ",0,1", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True) + strPlotLink, , , , , , True))
                Else
                    Response.Write(.GetSectionTitle(MyBase.GetResourceString("SHOWINFORMATION"), "DivOtherInfo", "ShowHideOtherInfo", , MyBase.GetResourceString("CUSTOMFIELDSLEGEND"), "Select Project : " + CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_AccessibleProjects_ForEmployee " & m_UserId & ",0,0,NULL,1,'" & m_LoginType & "',0," & CType(Session("intLoginID"), String) & ",0,0", , m_ProjectId.ToString, "onchange='javascript:ChangeProject()'", True, True) + strPlotLink, , , , , , True))
                End If
                'End of modification by SuchitraP 
            End If

            'End modification by SandipL on 31 Jan 2006 
        End With


        'Added by SandipL on 8 Feb 2006
        'If no project is selected then plot Combo and Exit
        If m_ProjectId = 0 Then Exit Sub

        'End addition by SandipL on 8 Feb 2006
        'Div for section title
        Response.Write("<div id='DivOtherInfo' style='height:70px;overflow:auto;'>")

        'Destroy the object
        cObjSectionTitle = Nothing

        'Query Applied
        Dim strQueryName As String = GetQueryName()
        If strQueryName Is Nothing Then
            strQueryName = MyBase.GetResourceString("NA")
        End If

        'Select Query Combo
        Dim strCombo As String
        Dim strSQL As String = "Exec Usp_Sel_tbl_IB_Query Null," + m_ProjectId.ToString + ",0,'','" + m_LoginType.ToString + "','A'"
        'Modified by SandipL on 9 Feb 2006 add sortby and sortorder
        'strCombo = CommonFunction.HTMLControls.DrawComboBox("cboSelectQuery", strSQL, 250, m_intQueryID.ToString, "onchange='javascript:cboSelectQuery_OnChange()'", True, True)
        strCombo = CommonFunction.HTMLControls.DrawComboBox("cboSelectQuery", strSQL, 250, m_intQueryID.ToString, "onchange='javascript:cboSelectQuery_OnChange(""" & CType(m_strSortBy, String) & """,""" & CType(m_strAscOrDesc, String) & """)'", True, True)
        'End Modification by SandipL on 9 Feb 2006

        Response.Write("<TABLE class=clsTable cellspacing=0 width='99.9%'>")

        'Select Query and Combobox containing queries
        ' Response.Write("<TR class=clsTrEven>")

        Response.Write("<TR class=clsTrEven valign='top'>")
        Response.Write("<TD width='10%' valign='top' noWrap>" & MyBase.GetResourceString("SELECTQUERY") & " : " & strCombo & "</TD>")

        Response.Write("<TD width='10%' valign='top' noWrap title=""" + m_strQuery + """>" + MyBase.GetResourceString("QUERYAPPLIED") & " : <B>'" & strQueryName & "'</B></TD>")
        Dim strViewName As String = GetViewName()

        Response.Write("<TD width='10%'  valign='top' noWrap title='" + m_FieldList + "'>" + MyBase.GetResourceString("VIEWAPPLIED") & " : <B>'" & strViewName & "'</B></TD>") 'ColSpan=2
        Response.Write("</TR>")




        'Issue List TextBox and Go button
        ' Dim strtxtIssueId As String = CommonFunctions.HTMLControls.DrawTextBox("txtIssueId", "txtIssueId", , 50, 8, , "Right", , False, False, , False, "onkeypress=txtIssueID_OnKeyPress(event)", True)

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Dim strtxtIssueId As String = CommonFunctions.HTMLControls.DrawTextBox("txtIssueId", "txtIssueId", , 50, 8, , "Right", , False, False, , False, "onkeypress=txtIssueID_OnKeyPress(event)", True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        'Commented and added by Vaijat K for HTML encoding Date:15/10/15
        ''Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0'>"
        Dim strtxtDummy As String = "<input Type='text' style='width:0;height:0;display:none'>"

        m_HistoryStatus = GetHistoryStatus()

        Response.Write("<TR class=clsTrEven>")
        ' Modified by Ganesh D on 16 Sep 2009 To change the name of "Show Details" to "Quick View"
        'Response.Write("<TD width='10%' ColSpan=2 noWrap><B>" + MyBase.GetResourceString("ISSUELIST") + "</B>&nbsp;&nbsp;" + strtxtIssueId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:GO_OnClick()><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:ShowDetails_OnClick()><B>" + MyBase.GetResourceString("SHOWDETAILS") + "</B></A>&nbsp;&nbsp;|&nbsp;<B>")
        Response.Write("<TD width='10%' ColSpan=2 noWrap><B>" + MyBase.GetResourceString("ISSUELIST") + "</B>&nbsp;&nbsp;" + strtxtIssueId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:GO_OnClick()><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:ShowDetails_OnClick()><B>Quick View</B></A>&nbsp;&nbsp;|&nbsp;<B>")
        ' End of addition/modification by GaneshD on 16 Sep 2009
        'Response.Write("<TD width='10%' ColSpan=2 noWrap><B>" + MyBase.GetResourceString("ISSUELIST") + "</B>&nbsp;&nbsp;" + strtxtIssueId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:GO_OnClick('" + m_PKToken + "')><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:ShowDetails_OnClick('" + m_PKToken + "')><B>" + MyBase.GetResourceString("SHOWDETAILS") + "</B></A>&nbsp;&nbsp;|&nbsp;<B>")
        'Response.Write("<TD width='10%' ColSpan=2 noWrap><B>" + MyBase.GetResourceString("ISSUELIST") + "</B>&nbsp;&nbsp;" + strtxtIssueId + strtxtDummy + "&nbsp;&nbsp;| <A style='cursor:hand;TEXT-DECORATION:none' href=javascript:GO_OnClick()><B>" + MyBase.GetResourceString("GO") + "</B></A>&nbsp;&nbsp;|&nbsp;<B>")
        If m_HistoryStatus = "ON" Then
            Response.Write(MyBase.GetResourceString("HISTORY") & " : " & MyBase.GetResourceString(m_HistoryStatus) & "</B></TD>")
        Else
            Response.Write("<font Size='1' Face='verdana' color='red'>" + MyBase.GetResourceString("HISTORY") & " : " & MyBase.GetResourceString(m_HistoryStatus) & "</B></FONT></TD>")
        End If

        'Current filter applied
        Dim strFilter As String
        strFilter = GetFilters()

        If Session("Filters").ToString = "" Then
            Response.Write("<TD width=10% rowspan=3 valign=top><B>" + System.Web.HttpUtility.HtmlEncode(strFilter) + " : </B>" + MyBase.GetResourceString("NONE") + "</TD>")
        Else
            If Len(Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "")) > 190 Then
                'Commented and added by Yogesh Jalamkar on 18-Aug-2016 For Html Encode
                '    Response.Write("<TD width=10% rowspan=3 valign=top title=""" + Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "") + """><B>" + System.Web.HttpUtility.HtmlEncode(strFilter) + " : </B>" + Left(Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", ""), 190) + "..." + "</TD>")
                'Else
                '    Response.Write("<TD width=10% rowspan=3 valign=top title=""" + Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "") + """><B>" + System.Web.HttpUtility.HtmlEncode(strFilter) + " : </B>" + Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "") + "</TD>")
                Response.Write("<TD width=10% rowspan=3 valign=top title=""" + System.Web.HttpUtility.HtmlEncode(Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "")) + """><B>" + System.Web.HttpUtility.HtmlEncode(strFilter) + " : </B>" + System.Web.HttpUtility.HtmlEncode(Left(Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", ""), 190)) + "..." + "</TD>")
            Else
                Response.Write("<TD width=10% rowspan=3 valign=top title=""" + System.Web.HttpUtility.HtmlEncode(Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "")) + """><B>" + System.Web.HttpUtility.HtmlEncode(strFilter) + " : </B>" + System.Web.HttpUtility.HtmlEncode(Replace(CommonFunction.General.UnBuildQueryString(Session("Filters").ToString) + "", "tbl_IB_Issue.", "")) + "</TD>")
                'End of addition by Yogesh Jalamkar on 18-Aug-2016 For Html Encode
            End If

        End If

        Response.Write("</TR>")

        Response.Write("</Table>")

        Response.Write("</DIV>")

    End Sub

    Private Sub PlotGrid(ByVal GridSQL As String)
        '=====================================================================
        ' Procedure Name        : PlotGrid()	
        ' Purpose               : To plot Issue List grid
        ' Description           : same as above
        ' Parameters Passed     : GridSQL as string - SQL Query for grid
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================

        Dim inti As Integer, ArrTemp() As String

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        ' Added By SujataK for WhizEnggSP6 for IssueID = 3697
        Dim intColCount As Integer
        ' End  of addition By SujataK
        'End Integration

        'generate Actual column headings array
        Dim ArrActualNameList As New ArrayList
        ArrActualNameList.Add("Attachments") 'No of attachments for Issue
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        'ArrActualNameList.Add("DA") 'DA for Issue
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ArrActualNameList.Add("Discussions") 'Discussion threads


        'added by VivekP on 2 Apr 2005 for copy issue functionality - add link on list page
        'If Application("ACCN-ISSUECOPY") Then

        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access

        'Modified By GaneshG on 15 nov 06 'For showing records in Follow-Up Issues Tab
        'If m_blnAddAccess = True Then
        If m_blnAddAccess = True And m_strDisplayMode.ToUpper <> "F" Then
            'End Modification By GaneshG
            ArrActualNameList.Add("Copy") 'Copy issue
        End If
        'End Of Modification - IssueID - 191

        'Added by ShraddhaM to add flag column
        ArrActualNameList.Add("FlagTo") ' FlagTo
        'Ended by ShraddhaM
        'End If
        'end of addition

        'Code Added by DipaliS 19 July 2004 to resolve issue 11944
        'Added by AniruddhaD on 19 may 2004 for IssueCode
        If Not m_blnIssueCodePresent Then
            m_FieldList = Replace("," + m_FieldList + ",", ",IssueCode,", "")
            m_FieldList = Left(m_FieldList, Len(m_FieldList) - 1)
        End If
        'End of addition
        'end Addition by DipaliS

        If Not m_blnIssueIdPresent Then
            m_FieldList = Replace("," + m_FieldList + ",", ",IssueID,", "")
            m_FieldList = Left(m_FieldList, Len(m_FieldList) - 1)
        End If

        'Code Commented By DipaliS 19 July 2004 to resolve issue 11944
        ''Added by AniruddhaD on 19 may 2004 for IssueCode
        'If Not m_blnIssueCodePresent Then
        '    m_FieldList = Replace("," + m_FieldList + ",", ",IssueCode,", "")
        '    m_FieldList = Left(m_FieldList, Len(m_FieldList) - 1)
        'End If
        ''End of addition

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        If m_strDisplayMode.ToUpper = "F" Then
            If InStr("," + m_FieldList + ",", ",Summary,", CompareMethod.Text) > 0 Then
                ReDim ArrTemp(2)
                ArrTemp(0) = "IssueID"
                ArrTemp(1) = "Summary"
                ArrTemp(2) = "LastDiscussionThread"
            Else
                ReDim ArrTemp(1)
                ArrTemp(0) = "IssueID"
                ArrTemp(1) = "LastDiscussionThread"
            End If
        Else
            ArrTemp = Split(m_FieldList, ",")
        End If
        'End Modification By GaneshG

        For inti = 0 To UBound(ArrTemp)
            If InStr(ArrTemp(inti), " AS ", CompareMethod.Text) > 0 Then
                ArrActualNameList.Add(Replace(Right(ArrTemp(inti), Len(ArrTemp(inti)) - InStr(ArrTemp(inti), " AS ") - 3).Trim, """", ""))
            Else
                ArrActualNameList.Add(ArrTemp(inti).Trim)
            End If
        Next inti

        'Added by ShraddhaM to add LastUpdatedDate column
        ArrActualNameList.Add("LastUpdatedDate") ' LastUpdatedDate
        'Ended by ShraddhaM

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_HistoryStatus = "ON" Then ArrActualNameList.Add("Show") 'History
        If m_HistoryStatus = "ON" And m_strDisplayMode.ToUpper <> "F" Then ArrActualNameList.Add("Show") 'History

        'ArrActualNameList.Add("") 'Delete
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrActualNameList.Add("") 'Delete
        End If
        'End Modification By GaneshG

        'Convert arraylist to actual array - Actual Column Names
        Dim ArrActualName(ArrActualNameList.Count - 1) As String
        ArrActualNameList.ToArray.CopyTo(ArrActualName, 0)
        ArrActualNameList = Nothing
        '---Actual column headings array generated

        '---------------------------------------------------------------

        'generate User Friendly column headings array
        Dim ArrColHeadingsList As New ArrayList
        ArrColHeadingsList.Add("<IMG border=0 src='../../Images/Pin.gif'>") 'Image for attachments
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' Timesheet column is removed for List
        'ArrColHeadingsList.Add("<IMG border=0 src='../../Images/TimeSheet.gif'>") 'Image for TimeSheet

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        ArrColHeadingsList.Add("<IMG border=0 src='../../Images/Discussions.gif'>") 'Image for Discussion threads


        'added by VivekP on 31 Mar 2005 for copy issue functionality - link on list page
        'If Application("ACCN-ISSUECOPY") = True Then
        'ArrColHeadingsList.Add("<IMG border=0 src='../../Images/Copy.jpg'>") 'Image for Copy
        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access

        'Modified By GaneshG on 15 nov 06 'For showing records in Follow-Up Issues Tab
        'If m_blnAddAccess = True then
        If m_blnAddAccess = True And m_strDisplayMode.ToUpper <> "F" Then
            'End Modification By GaneshG
            ArrColHeadingsList.Add("Copy") 'Caption for Copy
        End If
        'End Of Addition - IssueID - 191
        'Added by ShraddhaM to display FlagTo column
        ArrColHeadingsList.Add("<IMG border=0 src='../../Images/GrayFlag.gif'>") 'FlagTo
        'Ended by ShraddhaM
        'End If
        'end of adition


        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' All User Friendly names are brought through a single sp 

        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strUSerFriendlyFieldList As String

        'For inti = 0 To UBound(ArrTemp)
        '    If InStr(ArrTemp(inti), " AS ", CompareMethod.Text) > 0 Then
        '        ArrColHeadingsList.Add("$" + Replace(Right(ArrTemp(inti), Len(ArrTemp(inti)) - InStr(ArrTemp(inti), " AS ") - 3).Trim, """", "").Trim)
        '    Else
        '        ArrColHeadingsList.Add(GetUserFriendlyName((ArrTemp(inti).Trim)))
        '    End If
        'Next inti

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        If m_strDisplayMode.ToUpper <> "F" Then
            strSQL = "usp_Sel_tbl_IB_DataDictionary_UserFriendlyName '" + m_FieldList + "'"
            objDR = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

            If objDR.Read Then
                'Commented and Modified By JyotiG
                'Start
                'strUSerFriendlyFieldList = CType(objDR("UserFriendlyName"), String)
                strUSerFriendlyFieldList = CType(CommonFunction.Data.CheckIsDBNull(objDR("UserFriendlyName"), ""), String)
                'End  of modification by JyotiG
            End If
        Else
            If InStr("," + m_FieldList + ",", ",Summary,", CompareMethod.Text) > 0 Then
                strUSerFriendlyFieldList = "Issue ID,Summary,Last Discussion"
            Else
                strUSerFriendlyFieldList = "Issue ID,Last Discussion"
            End If
        End If
        'End Modification By GaneshG 

        CommonFunction.Data.DisposeDataReader(objDR)

        If strUSerFriendlyFieldList <> "" Then
            Dim strUserFriednlyFieldNameArray() As String

            strUserFriednlyFieldNameArray = Split(strUSerFriendlyFieldList, ",")

            For inti = 0 To UBound(strUserFriednlyFieldNameArray)
                ArrColHeadingsList.Add((strUserFriednlyFieldNameArray(inti).Trim))
            Next inti

        End If

        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Added by ShraddhaM to add LastUpdatedDate column
        ArrColHeadingsList.Add("Last Updated") ' LastUpdatedDate
        'Ended by ShraddhaM

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_HistoryStatus = "ON" Then ArrColHeadingsList.Add("History") 'History
        If m_HistoryStatus = "ON" And m_strDisplayMode.ToUpper <> "F" Then ArrColHeadingsList.Add("History") 'History

        'ArrColHeadingsList.Add("Delete") 'Delete
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrColHeadingsList.Add("Delete") 'Delete
        End If
        'End Modification By GaneshG

        'Convert arraylist to actual array - User Friendly column headings
        Dim ArrColHeadings(ArrColHeadingsList.Count - 1) As String
        ArrColHeadingsList.ToArray.CopyTo(ArrColHeadings, 0)
        ArrColHeadingsList = Nothing
        '--User friendly column headings array generated.

        '---------------------------------------------------------------

        'Generate RowLinks array
        Dim ArrRowLinkList As New ArrayList
        'integration by harshada d on 21 DEC 2005 for whiziblesem issue id 989
        '================'================'================'================'================'================
        'Modified By ManishK on 21 Nov 2005 for No of attachments attached to Issue , this is to Show link to Pin.Gif on th e Issue list page
        '================'================'================'================'================'================

        'ArrRowLinkList.Add("") 'No Link for attachments
        ArrRowLinkList.Add("Document_OnClick(ProjectID,IssueID)") 'Link for attachment of Issue

        '================'================'================'================'================'================
        'End of modification by ManishK On 21 Nov 2005 for No of attachments to Issue
        '================'================'================'================'================'================
        'end of integration by harshada d on 21 DEC 2005 for whiziblesem issue id 989

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        'ArrRowLinkList.Add("ShowDA_OnClick(IssueID)") 'Link for DA of Issue
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        ArrRowLinkList.Add("ShowDiscussions_OnClick(IssueID)") 'Link for DA of Issue

        'added by VivekP on 31 Mar 2005 for copy issue functionality - link on list page
        'If Application("ACCN-ISSUECOPY") = True Then
        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access

        'Modified By GaneshG on 15 nov 06 'For showing records in Follow-Up Issues Tab
        'If m_blnAddAccess = True Then
        If m_blnAddAccess = True And m_strDisplayMode.ToUpper <> "F" Then
            'End Modification By GaneshG
            ArrRowLinkList.Add("Copy(IssueID)") 'Link for copy Issue
        End If

        ArrRowLinkList.Add("Flag_OnClick(IssueID)") 'Flag To
        ' end of addition - issueid - 191

        'End If
        'end of addition

        'Modified and Commented By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If Not m_blnIssueIdPresent Then
        'ArrRowLinkList.Add("IssueDetails(IssueId)") 'Link for first column in the grid
        'For inti = 1 To UBound(ArrTemp)
        For inti = 0 To UBound(ArrTemp)
            ArrRowLinkList.Add("")
        Next inti
        ''Else
        ''    'Commented and Modified By jyotiG
        ''    'Date : 25-Oct-2006
        ''    'Issue Id : 7194
        ''    'Start
        ''    'For inti = 0 To UBound(ArrTemp)
        ''    '    If ArrTemp(inti).ToUpper = "ISSUEID" Then
        ''    '        ArrRowLinkList.Add("IssueDetails(IssueId)")
        ''    '    Else
        ''    '        ArrRowLinkList.Add("")
        ''    '    End If
        ''    'Next inti
        ''    If Session("intViewID").ToString = "" Then
        ''        For inti = 0 To UBound(ArrTemp)
        ''            If ArrTemp(inti).ToUpper = "ISSUEID" Then
        ''                ArrRowLinkList.Add("IssueDetails(IssueId)")
        ''            Else
        ''                ArrRowLinkList.Add("")
        ''            End If
        ''        Next inti
        ''    End If
        ''    'End of modification by JyotiG for Issue Id : 7194
        ''End If
        ''End Modification and Comment By GaneshG
        ArrRowLinkList.Add("")
        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_HistoryStatus = "ON" Then ArrRowLinkList.Add("ShowHistory_OnClick(IssueID)") 'Link for History column
        If m_HistoryStatus = "ON" And m_strDisplayMode.ToUpper <> "F" Then ArrRowLinkList.Add("ShowHistory_OnClick(IssueID)") 'Link for History column

        'ArrRowLinkList.Add("") 'No Link for Delete
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrRowLinkList.Add("") 'No Link for Delete
        End If
        'End Modification By GaneshG

        'Convert arraylist to actual array - User Friendly column headings
        Dim ArrRowLinks(ArrRowLinkList.Count - 1) As String
        ArrRowLinkList.ToArray.CopyTo(ArrRowLinks, 0)
        ArrRowLinkList = Nothing
        'Row links array generated

        '---------------------------------------------------------------

        'Generate Delete array
        Dim ArrDeleteList As New ArrayList
        ArrDeleteList.Add("") 'Attachments

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        'ArrDeleteList.Add("") 'DA
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        ArrDeleteList.Add("") 'Discussion threads

        'added by VivekP on 31 Mar 2005 for copy issue functionality - link on list page
        'If Application("ACCN-ISSUECOPY") = True Then

        'Modified By GaneshG on 15 nov 06 'For showing records in Follow-Up Issues Tab
        'ArrDeleteList.Add("") 'Copy issue
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrDeleteList.Add("") 'Copy issue
        End If
        'End Modification By GaneshG
        ArrDeleteList.Add("") 'Flag To
        ArrDeleteList.Add("") 'LastUpdated
        'End If
        'end of addition

        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4192
        'For inti = 0 To UBound(ArrTemp)
        '    ArrDeleteList.Add("")
        'Next inti


        'Added By SujataK on 12 May 2006 for WhizEnggSP6 for IssueID = 3697
        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_blnAddAccess = True Then
        If m_blnAddAccess = True Or m_strDisplayMode.ToUpper = "F" Then
            'End Modification By GaneshG
            intColCount = UBound(ArrTemp)
        Else
            intColCount = UBound(ArrTemp) - 1
        End If

        For inti = 0 To intColCount
            ArrDeleteList.Add("")
        Next inti
        'End of Addition By SujataK
        'End Integration

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_HistoryStatus = "ON" Then ArrDeleteList.Add("") 'History
        If m_HistoryStatus = "ON" And m_strDisplayMode.ToUpper <> "F" Then ArrDeleteList.Add("") 'History

        'ArrDeleteList.Add("chkDelete") 'Delete
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrDeleteList.Add("chkDelete") 'Delete
        End If
        'End Modification By GaneshG

        'Convert arraylist to actual array - User Friendly column headings
        Dim ArrDelete(ArrDeleteList.Count - 1) As String
        ArrDeleteList.ToArray.CopyTo(ArrDelete, 0)
        ArrDeleteList = Nothing
        'Delete array generated

        '---------------------------------------------------------------

        'Generate ArrChkDisableOnColumn array
        Dim ArrChkDisableOnColumnList As New ArrayList
        ArrChkDisableOnColumnList.Add("") 'Attachments

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        'ArrChkDisableOnColumnList.Add("") 'DA
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        ArrChkDisableOnColumnList.Add("") 'Discussion threads

        ArrChkDisableOnColumnList.Add("") 'FlagTo
        ArrChkDisableOnColumnList.Add("") 'LastUpdated
        'added by VivekP on 31 Mar 2005 for copy issue functionality - link on list page
        'If Application("ACCN-ISSUECOPY") = True Then

        'Modified By GaneshG on 15 nov 06 'For showing records in Follow-Up Issues Tab
        'ArrChkDisableOnColumnList.Add("") 'Copy issue
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrChkDisableOnColumnList.Add("") 'Copy issue
        End If
        'End Modification By GaneshG

        'End If
        'end of addition

        For inti = 0 To UBound(ArrTemp)
            ArrChkDisableOnColumnList.Add("")
        Next inti

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_HistoryStatus = "ON" Then ArrChkDisableOnColumnList.Add("") 'History
        If m_HistoryStatus = "ON" And m_strDisplayMode.ToUpper <> "F" Then ArrChkDisableOnColumnList.Add("") 'History

        'ArrChkDisableOnColumnList.Add("DAPresent") 'Delete
        If m_strDisplayMode.ToUpper <> "F" Then
            ArrChkDisableOnColumnList.Add("DAPresent") 'Delete
        End If
        'End Modification By GaneshG

        'Addition done by SuchitraP on 12 March 2008 for IssueID 17070
        'Purpose:to handle page crash when sorting is done on fields having datatype as text/ntext
        If m_FieldList.IndexOf("CustomFieldTextArea") <> -1 Then
            m_IsCustomFieldTextAreaPresentInView = True
        End If
        'End of addition by SuchitraP

        'Convert arraylist to actual array - ChkDisableOnColumn
        Dim ArrChkDisableOnColumn(ArrChkDisableOnColumnList.Count - 1) As String
        ArrChkDisableOnColumnList.ToArray.CopyTo(ArrChkDisableOnColumn, 0)
        ArrChkDisableOnColumnList = Nothing
        'ArrChkDisableOnColumn array generated

        '------------------------------------------------------------------
        'Dim arrIgnoreHTMLEncode() As String = {"1", "1", "1"}
        'Modiifed BY VarunA on 26-Sep-2008
        'Purpose : Security Issue
        'Dim arrIgnoreHTMLEncode() As String = {"1", "1", "1", "1"}
        Dim arrIgnoreHTMLEncode() As String = {"1", "1", "1"}
        'End BY VarunA on 26-Sep-2008

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   My Issues Feature
        'Date   :   29 June 2004
        'Requirement Number :   IB_PBN_ENT_03
        'Addition Made  :   If Login Type is employee then only draw the div
        'If m_LoginType.ToLower = "e" Then
        '    CommonFunction.General.WriteHTML("<div style=""width=100%;"">")
        'End If
        '********End Addition******

        'Plot Issue List grid 
        With objIssueGrid
            .ActualColumnArray = ArrActualName
            .UserFriendlyColumnArray = ArrColHeadings
            .RowLinkArray = ArrRowLinks
            .CheckBoxIDArray = ArrDelete
            .CheckboxDisableOnColumnArray = ArrChkDisableOnColumn

            'added by VivekP on 2 Apr 2005 for copy issue functionality - link on list page
            'If Application("ACCN-ISSUECOPY") = True Then

            'Modified Code For IssueID - 191
            'display Copy issue if user has add issue access

            'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
            'If m_blnAddAccess = True Then
            If m_blnAddAccess = True And m_strDisplayMode.ToUpper <> "F" Then
                'End Modification By GaneshG 
                .NoOfDataColumns = UBound(ArrTemp) + 6 '4
            Else
                .NoOfDataColumns = UBound(ArrTemp) + 5 '3
            End If
            'End Of addition - IssueID - 191

            'Else
            '.NoOfDataColumns = UBound(ArrTemp) + 4
            'End If
            'end of addition

            '.NoOfDataColumns = UBound(ArrTemp) + 4
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .PrimaryKey = "IssueId"
            .PageSize = m_PageSize
            .CurrentPage = m_intPageNumber
            .returnHTML = False
            .UseSQL = MyBase.UseSQL
            'Code Commented By DipaliS And Added the following
            '.DIVHeight = 400
            '****Code Added*******
            'By     :   DipaliS
            'Reason :   My Issues Feature
            'Date   :   29 June 2004
            'Requirement Number :   IB_PBN_ENT_03
            'Addition Made  :   If Login Type is employee then only end the div and the table
            'If m_LoginType.ToLower = "e" Then
            '    .DIVHeight = 10
            'Else
            .DIVHeight = 400
            'End If

            '**********End Addition********
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivIssueList"
            .DIVStyle = "Overflow:auto;width=99.9%"
            .SQL = GridSQL

            ' for sorting
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_OrderBy
            .SortOrder = m_Order
            .DrawGrid()
        End With



        If m_strIssueIdsOnPage = "" Then
            Session("IssueIdsOnPage") = ""
        Else
            Session("IssueIdsOnPage") = Left(m_strIssueIdsOnPage, Len(m_strIssueIdsOnPage) - 1)
        End If

        'Added by aniruddhad on 19 may for issuecode
        If m_strIssueCodesOnPage = "" Then
            Session("m_strIssueCodesOnPage") = ""
        Else
            Session("IssueCodesOnPage") = Left(m_strIssueCodesOnPage, Len(m_strIssueCodesOnPage) - 1)
        End If
        'end of addition

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   My Issues Feature
        'Date   :   29 June 2004
        'Requirement Number :   IB_PBN_ENT_03
        'Addition Made  :   If Login Type is employee then only end  the table

        If m_LoginType.ToLower = "e" Then
            CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
        End If

        '********End Addition******


        Response.Write("<BR>")

        'Display record count (Total number of Issues for qury applied)
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><td align=right>" + MyBase.GetResourceString("RECORDCOUNT") + " : " + m_intIssueCountForAppliedQuery.ToString + "</TD></TR></Table><BR>")

        'Destroy grid object
        ArrTemp = Nothing
        objIssueGrid = Nothing
    End Sub

    Private Sub DeleteIssues()
        '=====================================================================
        ' Procedure Name        : DeleteIssues()	
        ' Purpose               : To delete issues and its attachments, if any
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 5, 2004
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery, strIssueIdsTODelete, AttachmentPath As String

        Dim inti As Integer

        'Exit procedure if no issues to delete
        If MyBase.GetFormValue("chkDelete") Is Nothing Or MyBase.GetFormValue("chkDelete") = "" Then Exit Sub

        strIssueIdsTODelete = MyBase.GetFormValue("chkDelete")


        Dim IssueIds() As String

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        Dim strIssueIDNotDeleted As String = ""

        IssueIds = Split(strIssueIdsTODelete, ",")

        For inti = 0 To UBound(IssueIds)
            Dim strResult As String = ""
            'Delete Issue
            strSQLQuery = "EXEC usp_Del_IB_tbl_IB_Issue " + IssueIds(inti).ToString
            'CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            strResult = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL), ""), "")

            If strResult = "" Then
                'Delete attachments physically, if PhysicalDeletionOfDocuments app. variable is true
                If CommonFunction.Application.PhysicalDeletionOfDocuments Then 'Physically delete attachments 
                    Dim drAttachments As IDataReader
                    drAttachments = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_Attachment " + IssueIds(inti) + ",0", MyBase.UseSQL)
                    Do While drAttachments.Read

                        'Delete attachment
                        Dim strFilePath As String
                        Dim Attachment As System.IO.File
                        AttachmentPath = Server.MapPath("../../Attachments/BTS") + "\" + drAttachments("FilePath").ToString + ""

                        If Attachment.Exists(AttachmentPath) Then
                            Attachment.Delete(AttachmentPath)
                        End If
                    Loop
                    CommonFunction.Data.DisposeDataReader(drAttachments)
                End If
            Else
                strIssueIDNotDeleted = strIssueIDNotDeleted + "," + strResult
            End If


        Next inti

        If strIssueIDNotDeleted <> "" Then
            ' Remove extra comma at start 
            strIssueIDNotDeleted = Right(strIssueIDNotDeleted, Len(strIssueIDNotDeleted) - 1)

            MyBase.InitializeResources("AppResources.IB_IssueList", "AppResources")

            Response.Write("<script>")
            Response.Write("alert(""" + Replace((MyBase.GetResourceString("MSG_DELETE")), "<ISSUELIST>", "'" + strIssueIDNotDeleted + "'") + """);")
            Response.Write("</script>")

            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        End If
        ' End Modification By  NitinVS on 1 Aug 2005 for WhizibleSEM SP4 IssueID = 63 

    End Sub
    '====================================================================
    ' Procedure Name        :   GenerateTabSections
    ' Parameters Passed     :   None
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To Plot the Client Side Tabs for Default and My Issues
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   June 25, 2004
    ' Requirement No        :   IB_PBN_ENT_03
    ' Revisions             :
    '=====================================================================
    Private Sub GenerateTabSections()
        ''------------------------------------------------------------------------------------------
        ''Code added by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module  for Whiziblesem SP 7 Issue ID 5688 
        Dim strSQL As String = ""
        Dim blnDisableAllIssueTab As Boolean = False

        strSQL = "Exec usp_chk_AllIssueTabAccess " + m_ProjectId.ToString + ", " + m_UserId.ToString
        blnDisableAllIssueTab = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Boolean)

        If blnDisableAllIssueTab Then
            'Modified By GaneshG on 08 Nov 06 -- Flag setting for Issue
            Dim arrTabName() As String = {MyBase.GetResourceString("MYISSUES"), "Follow Up Issues"}
            Dim arrTabToolTip() As String = {MyBase.GetResourceString("MYISSUES_TOOLTIP"), "Follow Up Issues"}
            Dim arrTabOnClickFun() As String = {"Tab_OnClick(""" + "M" + """)", "Tab_OnClick(""" + "F" + """)"}
            'End Modification By GaneshG

            Dim objIssuesTab As WebPage.UI.cTabs
            objIssuesTab = New WebPage.UI.cTabs
            objIssuesTab.TabNameArray = arrTabName
            objIssuesTab.TooltipArray = arrTabToolTip
            objIssuesTab.TabOnclickFunctionArray = arrTabOnClickFun
            objIssuesTab.ReturnHTML = False
            objIssuesTab.Align = "Right"

            'Modified By GaneshG on 08 Nov 06 -- Flag setting for Issue
            'objIssuesTab.SelectedTab = MyBase.GetResourceString("MYISSUES")
            If m_strDisplayMode.ToLower.Trim = "m" Then
                objIssuesTab.SelectedTab = MyBase.GetResourceString("MYISSUES")
            Else
                objIssuesTab.SelectedTab = "Follow Up Issues"
            End If
            'End Modification By GaneshG

            CommonFunctions.General.WriteHTML(objIssuesTab.DrawTabs())
            objIssuesTab = Nothing
        Else
            Dim arrTabName() As String = {MyBase.GetResourceString("ALLISSUES"), MyBase.GetResourceString("MYISSUES")}
            Dim arrTabToolTip() As String = {MyBase.GetResourceString("ALLISSUES_TOOLTIP"), MyBase.GetResourceString("MYISSUES_TOOLTIP")}
            Dim arrTabOnClickFun() As String = {"Tab_OnClick(""" + "A" + """)", "Tab_OnClick(""" + "M" + """)"}

            'Added By GaneshG on 08 Nov 06 -- Flag setting for Issue
            If m_LoginType <> "C" Then
                ReDim Preserve arrTabName(2)
                ReDim Preserve arrTabToolTip(2)
                ReDim Preserve arrTabOnClickFun(2)

                arrTabName(2) = "Follow Up Issues"
                arrTabToolTip(2) = "Follow Up Issues"
                arrTabOnClickFun(2) = "Tab_OnClick(""" + "F" + """)"
            End If
            'End Addition By GaneshG

            Dim objIssuesTab As WebPage.UI.cTabs

            objIssuesTab = New WebPage.UI.cTabs
            objIssuesTab.TabNameArray = arrTabName
            objIssuesTab.TooltipArray = arrTabToolTip
            objIssuesTab.TabOnclickFunctionArray = arrTabOnClickFun
            objIssuesTab.ReturnHTML = False
            objIssuesTab.Align = "Right"
            ''ADDED BY NILESH G ON 11/11/2016 pURPOSE:SOLVED ISSUE
            objIssuesTab.TableStyle = "style='width:auto !important'"

            If m_strDisplayMode.ToLower.Trim = "a" Then
                objIssuesTab.SelectedTab = MyBase.GetResourceString("ALLISSUES")
                'Modified By GaneshG on 08 Nov 06 -- Flag setting for Issue
            ElseIf m_strDisplayMode.ToLower.Trim = "m" Then
                objIssuesTab.SelectedTab = MyBase.GetResourceString("MYISSUES")
            Else
                objIssuesTab.SelectedTab = "Follow Up Issues"
            End If
            'End Modification By GaneshG

            CommonFunctions.General.WriteHTML(objIssuesTab.DrawTabs())
            objIssuesTab = Nothing
        End If
        ''End of Code addition by RohiniK on 21 August 2006 for Role wise Access to All ISsues Tab in Issues Module
        ''------------------------------------------------------------------------------------------
    End Sub

#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call CreateGlobalObject() 'Create global object to get session variables and access rights

    End Sub
    'Added By Vidya J ON 1 Feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_Analysis_OnClick(MenuGroupID As String, EmployeeID As String) As String
        Dim m_PKToken_Analysis_OnClick As String
        m_PKToken_Analysis_OnClick = CommonFunctions.Security.Token.GetToken(CType(MenuGroupID, String) + CType(EmployeeID, String) + "0" + "0")

        Return m_PKToken_Analysis_OnClick

    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowHistory_OnClick(IssueId As String, EmployeeID As String) As String
        Dim m_PKToken_ShowDetails_Multiple As String
        m_PKToken_ShowDetails_Multiple = CommonFunctions.Security.Token.GetToken(CType(IssueId, String) + CType(EmployeeID, String) + "0" + "0")

        Return m_PKToken_ShowDetails_Multiple

    End Function
    'End Of Added By Vidya J ON 1 Feb 2016
    Private Sub objIssueGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles objIssueGrid.ColumnHeaderTD_BeforePrint

        'No sorting for text fields
        'Code Commented By DipaliS 19 July for hotfix 4.0.5
        'Purpose : Do not allow sorting on Text Area Fields
        'If InStr(Args.ColumnName, "TextArea") > 0 Then
        'Code Added By DipaliS 19 July for hotfix 4.0.5
        'Purpose : Do not allow sorting on Text Area Fields

        'Comment and modification by SuchitraP on 12 March 2008 for IssueID = 17070
        'Purpose:to handle page crash when sorting is done on fields having datatype as text/ntext
        'If Args.DataType.ToLower.Trim = "text" Or Args.DataType.ToLower.Trim = "ntext" Then
        'End Addition By DipaliS for HotFix 4.0.5
        'Args.ApplySorting = False
        'End If

        If Args.ColumnName.ToUpper = "DESCRIPTION" Then
            Args.ApplySorting = False
        End If

        If m_IsCustomFieldTextAreaPresentInView = True Then
            If m_FieldList.IndexOf("CustomFieldTextArea1 AS """ + Args.DataField + """") <> -1 Then
                Args.ApplySorting = False
            ElseIf m_FieldList.IndexOf("CustomFieldTextArea2 AS """ + Args.DataField + """") <> -1 Then
                Args.ApplySorting = False
            ElseIf m_FieldList.IndexOf("CustomFieldTextArea3 AS """ + Args.DataField + """") <> -1 Then
                Args.ApplySorting = False
            End If
        End If
        'End of modification by SuchitraP

        If Args.DataField.ToUpper() = "FLAGTO" Then
            If m_LoginType.ToUpper() = "C" Then
                Cancel = True
            Else
                'Args.TDStyle = " NoWrap title='FlagTo'"
                Args.ApplySorting = False
                ' Args.ColumnName = "<IMG border=0 src='../../Images/grayflag.gif'>"
                Args.ApplyHTMLEncode = False
            End If

        End If



        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'No sorting for first 3 columns (attachments, DA and Discussion threads)
        'If Args.ColIndex < 3 Then

        'added by VivekP on 2 Apr 2005 for copy issue functionality - link on list page
        Dim colIndex As Integer
        'If Application("ACCN-ISSUECOPY") = True Then 
        'colIndex = 4

        'Modified Code For IssueID - 191
        'display Copy issue if user has add issue access

        'Modified By GaneshG on 16 Nov 06 'For showing records in Follow-Up Issues Tab
        'If m_blnAddAccess = True Then
        If m_blnAddAccess = True And m_strDisplayMode.ToUpper <> "F" Then
            'End Modification By GaneshG
            colIndex = 4 '3
        Else
            colIndex = 2
        End If

        'Else colIndex = 3
        'end of addition

        ' End Modification  By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        If Args.ColIndex < colIndex Then
            Args.ApplySorting = False
        End If

        'Don't show delete column is no delete access
        If Args.ColumnName.ToUpper = "DELETE" And Not m_blnDeleteAccess Then Cancel = True

    End Sub

    Private Sub objIssueGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles objIssueGrid.DataRowTD_BeforePrint
        If Args.DataField.ToUpper = "ISSUEID" Then
            Args.ReplacementValue = FormatNumber(Args.DataReader("IssueID"), 0, TriState.False, TriState.False, TriState.False)
        End If

        'Added by SavitaS  on 19 Sept 2006 for Security Issue 6197
        Dim strSQL As String = ""
        Dim dr As IDataReader
        Dim intCount As String = "0"
        Dim StatusFlowCount As Integer = 0

        'Modified by SavitaS on 03 Oct  2006 for SP7 IssueID 6476
        Select Case Args.ColIndex
            Case 0

                Cancel = True
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strSQL = "SELECT COUNT(AttachmentId) AS AttachmentsCount FROM tbl_IB_Attachments WHERE IssueId = " & CType(Args.DataReader("IssueID"), String)
                strSQL = "usp_sel_tbl_IB_Attachments_Att " & CType(Args.DataReader("IssueID"), String)

                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If dr.Read Then
                    intCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("AttachmentsCount"), ""), String)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                If intCount <> "0" Then
                    Args.StringToBeInserted = "<td  vAlign=top nowrap title=" & intCount & ">" _
                                  & "<A href=""JavaScript:Document_OnClick(" & m_ProjectId.ToString & "," & CType(Args.DataReader("IssueID"), String) & " )""><IMG border=0 src='../../Images/Pin.gif' title=" & intCount & "></A></td>"
                Else
                    Args.StringToBeInserted = "<td  vAlign=top nowrap title=" & intCount & ">&nbsp;</td>"
                End If

                '--- End modification purvaj
                Args.ApplyHTMLEncode = False

            Case 1
                '--- Added By purvaj on 12 Aug 2009 Issue Status flow on discussion thread was not workign from list page as statusflowcount parameter was not provided
                StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_IB_GetStatusFlowCount " + CType(Args.DataReader("IssueID"), String) + "," + m_ProjectId.ToString, MyBase.UseSQL), "0"), Integer)
                '---end addition purvaj
                'If Args.DataField.ToUpper = "DISCUSSIONS" Then
                Cancel = True
                'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                'strSQL = "Select dbo.udf_DiscussionThreadsForIssue(" & CType(Args.DataReader("IssueID"), String) & ",'" & m_LoginType & "') as DiscussionCount"
                strSQL = "usp_sel_udf_DiscussionThreadsForIssue_DiscussionCount " & CType(Args.DataReader("IssueID"), String) & ",'" & m_LoginType & "' "
                'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If dr.Read Then
                    intCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("DiscussionCount"), ""), String)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                '--- Modified by purvaj on 12 Aug 2009 StatusFlowCount parameter added.
                Args.StringToBeInserted = "<TD vAlign=top Title=" + intCount + " style='width=5%' nowrap;>" _
                                   & "<A href=""JavaScript:ShowDiscussions_OnClick('" & CType(Args.DataReader("IssueID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "'," + StatusFlowCount.ToString + ")"">"
                Args.StringToBeInserted = Args.StringToBeInserted & "<IMG border=0 src='../../Images/Discussions.gif'></A></TD>"
                '--- End modification purvaj
                Args.ApplyHTMLEncode = False
                'End If
            Case 2
                'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
                Dim sbTDTitle As New System.Text.StringBuilder
                'If m_blnAddAccess = False Then
                If m_blnAddAccess = False Or m_strDisplayMode.ToUpper = "F" Then
                    Cancel = True

                    If m_strDisplayMode.ToUpper = "F" Then
                        If Args.DataField.ToUpper = "ISSUEID" Then
                            Dim strActualColumns As String()
                            Dim intCnt As Integer
                            strActualColumns = Split(Trim(m_FieldList), ",")
                            For intCnt = 0 To UBound(strActualColumns)
                                If InStr(strActualColumns(intCnt), " AS", CompareMethod.Text) > 0 Then
                                    strActualColumns(intCnt) = strActualColumns(intCnt).Remove(0, strActualColumns(intCnt).IndexOf(" AS") + 3).Replace("""", "").Trim
                                End If
                            Next
                            sbTDTitle.Append("")

                            intCnt = 0
                            While intCnt < strActualColumns.Length
                                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader(strActualColumns(intCnt)), "").ToString <> "" Then
                                    If Args.DataReader(strActualColumns(intCnt)).GetType.Name.ToUpper = "DATETIME" Then
                                        sbTDTitle.Append(strActualColumns(intCnt) + ": " + CommonFunctions.Dates.CGetDate(CType(Args.DataReader(strActualColumns(intCnt)), Date)) + vbCrLf)
                                    Else
                                        sbTDTitle.Append(strActualColumns(intCnt) + ": " + Server.HtmlEncode(CommonFunction.Data.CheckIsDBNull(Args.DataReader(strActualColumns(intCnt))).ToString) + vbCrLf)
                                    End If
                                Else
                                    sbTDTitle.Append(strActualColumns(intCnt) + ":" + vbCrLf)
                                End If
                                intCnt += 1
                            End While
                            Server.HtmlEncode(sbTDTitle.ToString)
                        End If
                    Else
                        sbTDTitle.Append(Args.ColumnName.ToString)
                    End If

                    m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top Title=" & Chr(34) & sbTDTitle.ToString & Chr(34) & " style='width=5%' nowrap;>" _
                                      & "<A href=""JavaScript:IssueDetails('" & CType(Args.DataReader("IssueID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')"">"
                    'Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("IssueID").ToString) & "</A></TD>"
                    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader(Args.DataField).ToString) & "</A></TD>"
                    Args.ApplyHTMLEncode = False
                    sbTDTitle = Nothing
                End If
                'End Modification By GaneshG 
            Case 3
                'Dim IssueID As Integer
                'IssueID = CType(Args.DataReader("IssueID"), Integer)
                ''If CType(Args.DataReader("FlagTo"), Integer) = 1 Then
                'If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "1" Then
                '    m_FlagStatus = "Review"
                '    'ElseIf CType(Args.DataReader("FlagTo"), Integer) = 0 Then
                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "0" Then
                '    m_FlagStatus = "Follow Up"
                'Else
                '    m_FlagStatus = "Flag To"
                'End If

                'Cancel = True
                'm_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")

                'If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "L" Then
                '    Args.StringToBeInserted = "<TD   align=center title='Flag'  ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "G" Then
                '    Args.StringToBeInserted = "<TD   align=center title='Flag'  ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/GreenFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "S" Then
                '    Args.StringToBeInserted = "<TD   align=center title='Flag'  ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                '    'Added By ShraddhaM on 7,Aug 2007
                '    'To Display Black flag for Completed Flaged requests
                'ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "B" Then
                '    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/BlackFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                '    'End of Addition By ShraddhaM on 7,Aug 2007
                'Else
                '    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/GrayFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                'End If
                'Integrated By AmitJ on 03-May-2010 For WhizibleSEM9 SP1 
                'Added by GokulP on 16 Feb 2010 for FourSoft IssueID : 24901 [IssueID Link not displayed on removing Add Access but having Edit Access]
                If (m_blnAddAccess = True Or m_blnEditAccess = True) And m_strDisplayMode.ToUpper <> "F" And Args.DataField.ToUpper = "ISSUEID" Then
                    Cancel = True
                    m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top Title=" & Args.ColumnName.ToString & " style='width=5%' nowrap;>" _
                                          & "<A href=""JavaScript:IssueDetails('" & CType(Args.DataReader("IssueID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')"">"
                    'Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("IssueID").ToString) & "</A></TD>"
                    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader(Args.DataField).ToString) & "</A></TD>"
                    Args.ApplyHTMLEncode = False
                End If
                'End of Addition by GokulP on 16 Feb 2010 for FourSoft IssueID : 24901 [IssueID Link not displayed on removing Add Access but having Edit Access]
                'End Of Integration by AmitJ
            Case 4
                ' If Args.DataField.ToUpper = "ISSUEID" Then
                'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
                'If m_blnAddAccess = True Then
                'Integrated By AmitJ on 03-May-2010 For WhizibleSEM9 SP1 
                'Modified by GokulP on 16 Feb 2010 for FourSoft IssueID : 24901 [IssueID Link not displayed on removing Add Access but having Edit Access]
                'If m_blnAddAccess = True And m_strDisplayMode.ToUpper <> "F" Then
                'Commented and added by NitinC on 19 Jan 2012 For WhizibleSEM 11.0 - Agile Module [Issue Fix : 58842]
                'If (m_blnAddAccess = True Or m_blnEditAccess = True) And m_strDisplayMode.ToUpper <> "F" And Args.DataField.ToUpper = "ISSUEID" Then
                If (m_blnAddAccess = True Or m_blnEditAccess = True) And m_strDisplayMode.ToUpper <> "F" Then
                    'End of Commented and added by NitinC on 19 Jan 2012 For WhizibleSEM 11.0 - Agile Module [Issue Fix : 58842]

                    'End of Modification by GokulP on 16 Feb 2010 for FourSoft IssueID : 24901 [IssueID Link not displayed on removing Add Access but having Edit Access]
                    ' 'End Of Integration by AmitJ
                    'End Modification By GaneshG 
                    Cancel = True
                    m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                    Args.StringToBeInserted = "<TD vAlign=top Title=" & Args.ColumnName.ToString & " style='width=5%' nowrap;>" _
                                          & "<A href=""JavaScript:IssueDetails('" & CType(Args.DataReader("IssueID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_PKToken) & "')"">"
                    'Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("IssueID").ToString) & "</A></TD>"
                    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader(Args.DataField).ToString) & "</A></TD>"
                    Args.ApplyHTMLEncode = False
                End If
        End Select
        'End of Modified by SavitaS on 03 Oct  2006 for SP7 IssueID 6476
        'End addition by SavitaS  on 19 Sept 2006 for Security Issue 6197

        'Modified By GaneshG on 15 Nov 06 'For showing records in Follow-Up Issues Tab
        If m_strDisplayMode.ToUpper = "F" Then
            If Args.ColIndex < 3 Then
                Args.TDStyle = "nowrap=true width='5%'"
            ElseIf Args.DataField.ToUpper = "LASTDISCUSSIONTHREAD" Then
                'Modified by PrashantD on 13 March 2007 for IssueID 11493
                'Args.TDStyle = "nowrap=false width='65%'"
                Dim strComments As String
                strComments = Args.DataReader("LASTDISCUSSIONTHREAD").ToString
                strComments = System.Web.HttpUtility.HtmlEncode(strComments)
                strComments = "<B>Reported By :</B> " + Args.DataReader("ReportedBy").ToString + "<BR><B>Reported Date :</B> " + Args.DataReader("ReportedDate").ToString + "<BR><B>Comment :</B> " + strComments
                Args.StringToBeInserted = "<TD><PRE>" & strComments & "</PRE></TD>"
                Cancel = True
                'End of modification by PrashantD on 13 March 2007
            ElseIf Args.ColumnName.ToUpper = "SUMMMARY" Then
                Args.TDStyle = "nowrap=false width='20%'"
            End If
        Else
            If Args.ColIndex < 3 Then
                Args.TDStyle = "nowrap"
            End If
        End If
        'End Modification By GaneshG

        'Don't show delete column is no delete access
        If Args.ColumnName.ToUpper = "DELETE" And Not m_blnDeleteAccess Then Cancel = True

        If Args.DataField.ToUpper() = "LASTUPDATEDDATE" Then
            Dim LastUpdateDate As String
            If IsDBNull(Args.DataReader("LastUpdatedDAte")) Then
                LastUpdateDate = "-"
            Else
                LastUpdateDate = CommonFunction.Dates.CGetDateTime(CType(Args.DataReader("LastUpdatedDAte"), DateTime))
            End If

            Cancel = True

            Args.StringToBeInserted = "<TD   align=center title='Last Updated on'  >" + LastUpdateDate + "</TD>"

        End If
        If Args.DataField.ToUpper() = "FLAGTO" Then
            If m_LoginType.ToUpper() = "C" Then
                Cancel = True
            Else
                Dim IssueID As Integer
                IssueID = CType(Args.DataReader("IssueID"), Integer)
                'If CType(Args.DataReader("FlagTo"), Integer) = 1 Then
                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "1" Then
                    m_FlagStatus = "Review"
                    'ElseIf CType(Args.DataReader("FlagTo"), Integer) = 0 Then
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagTo"), "2"), String) = "0" Then
                    m_FlagStatus = "Follow Up"
                Else
                    m_FlagStatus = "Flag To"
                End If

                Cancel = True
                ''COMMENTED AND ADDED BY nILESH G ON 2/2/2016 FOR url SECURITY iSSUE
                ''m_PKToken = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                '' m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_ProjectId, String) + CType(Args.DataReader("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0")
                m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_ProjectId, String) + CType(Session("intUserID"), String) + "0" + "0" + CType(Args.DataReader("IssueID"), String))

                If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "L" Then
                    Args.StringToBeInserted = "<TD   align=center title='Flag'  ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "G" Then
                    Args.StringToBeInserted = "<TD   align=center title='Flag'  ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/GreenFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "S" Then
                    Args.StringToBeInserted = "<TD   align=center title='Flag'  ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/YellowFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    'Added By ShraddhaM on 7,Aug 2007
                    'To Display Black flag for Completed Flaged requests
                ElseIf CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("FlagDateStatus"), "E"), String) = "B" Then
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/BlackFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
                    'End of Addition By ShraddhaM on 7,Aug 2007
                Else
                    Args.StringToBeInserted = "<TD vAlign=top align=center title='Flag' ><a href=""javascript:Flag_OnClick(" + IssueID.ToString + ",'" + m_PKToken + "' )""><IMG Border=0  SRC='../../Images/GrayFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"

                End If
            End If
        End If
    End Sub

    Private Sub objIssueGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objIssueGrid.DataRowTR_BeforePrint
        'Static inti As Long

        'If inti >= CommonFunction.Application.MaxItemsInIssueIDCombo Then Exit Sub

        m_strIssueIdsOnPage += Args.DataReader("IssueID").ToString + ","

        'Added by AniruddhaD on 19 may 2004 for Issuecode
        m_strIssueCodesOnPage += Args.DataReader("IssueCode").ToString + ","
        'end of addition
        'inti += 1

    End Sub

    Private Sub objIssueGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles objIssueGrid.DataRowTD_AfterPrint

    End Sub
    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    Public Sub ReadXML()
        If Request.QueryString("IsXMLHTTP") = "1" Then
            Response.Clear()
            Dim str As String = ""
            Dim strFromwhere As String = ""
            If Not Request.QueryString("IssueID") Is Nothing Then
                m_IssueID = CType(Request.QueryString("IssueID"), String)
            Else
                m_IssueID = ""
            End If

            If Not Request.QueryString("Fromwhere") Is Nothing Then
                strFromwhere = CType(Request.QueryString("Fromwhere"), String)
            Else
                strFromwhere = ""
            End If

            m_PKToken = CommonFunctions.Security.Token.GetToken(CType(m_IssueID, String) + CType(Session("intUserID"), String) + "0" + "0")

            str = m_IssueID & "," & strFromwhere & "," & m_PKToken

            If m_IssueID <> "" Then
                Response.Write(str)
            Else
                Response.Write("0")
            End If
            Response.End()
        End If
    End Sub
    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
End Class
