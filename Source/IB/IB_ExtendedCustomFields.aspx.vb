Public Class IB_ExtendedCustomFields
    Inherits WebPages.Template.WhizTemplate
    'WebPages.Template.ProjectByNetTemplate

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

#Region " Form level variables declareation "

    'Enum for display style of controls
    Private Enum IB_ControlDisplayStyle As Integer
        CONTROLS_IN_TABS = 1
        CONTROLS_IN_SECTIONS = 2
    End Enum

    'Private RANGE As Double = CType(CommonFunction.Application.MaxItemsInIssueIDCombo, Integer) / 2

    Private m_DisplayStyle As IB_ControlDisplayStyle

    Private m_UseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Private m_LoginId As Long
    Protected m_intDeliverableID As Integer
    Protected m_LoginType As String
    Protected m_IsIssueSLAApplicable As Boolean = False
    Private m_RoleId As Long
    Private m_RoleLevel As Integer
    Protected m_ProjectId As Long
    Private m_UserId As Long
    Private m_UserName As String
    Private m_CultureId As Long
    Protected m_FromWhere As String


    'Added by Dhanashri S on 26 Feb 2015 for Issue fixing of ExtendedCustom Fields 
    Protected m_blnFields As Boolean = False
    'End of Addition by Dhanashri S on 26 Feb 2015

    'Private m_blnExtCustomFieldsExists As Boolean = False

    Private m_blnAddAccess As Boolean = False 'user has Add Access ?
    Private m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Private m_blnEditAccess As Boolean = False 'User has Edit Access ?

    '(values set in )
    Protected m_intPageNumber As Integer  'Currently Selected page number
    Protected m_lngIssueId As Long = 0 'Currently Selected IssueId

    '(Values set in GetProjectIdAndRoleId)
    Private m_blnShareIBWithinProjectGroup As Boolean = False 'Share Issue in project group ?
    Protected m_blnAssignIssueToResponsiblePerson As Boolean = False 'Assign issue to responsible person ?
    Private m_blnIsProjectOver As Boolean = False 'Is Project Over ? 
    Private m_blnSendResponsiblePersonMail As Boolean = False 'Send mail to responsible person ?

    '(Values set in GetSortingDetails)
    Protected m_strSortField As String = "" 'Sort field
    Protected m_strSortOrder As String = "" 'SortOrder

    '(Values set in GetDisplayMode)
    Private m_blnShowDefaults As Boolean = False 'Show defaults ?
    Private m_blnShowFormContents As Boolean = False 'Show FOrm contents ? 
    Private m_blnShowRecordSetContents As Boolean = False 'Show recordset contents ?

    '(Values set in GetDisaplyMode)
    Protected m_strMode As String = "" 'Mode to open the issue entry page
    Protected m_strAction As String = "" 'Action to be performed
    'Added by SandipL to solve IssueID 2131
    Protected m_blnProjectChanged As Boolean = False
    'End addition by SandipL 
    '(Values set in GetTImeSheetDetailsForIssue)
    Private m_blnShowTimesheetDetails As Boolean = False

    '(Value set in GetTimeSheetDetailsForIssue)
    Protected m_blnIssueNavigation As Boolean = False

    '' ParagD 5-Sept-2006
    Protected m_strblnShowToCustomer As String
    '' END : ParagD On 5-Sept-2006

    '(value set in GetIssueDetails)
    Private drExtIssueCustomFieldDetails As IDataReader

    '(value set in GetCurrentType)
    Private m_strCurrentType As String = ""

    '(value assigned in GetIssueLayout)
    Private m_intLayoutID As Long
    Private m_intMaxRows As Integer
    Private m_intMaxCols As Integer
    Private m_blnShowIssueAssignmentLink As Boolean = False

    Private m_intDiscussionThread_Count As Integer

    Private ArrCtlAttr(20) As String

    Protected dblDefaultWork As Double = 0
    Private blnReportedByCustomer As Boolean = False 'Reported by Customer ?

    Protected strOnloadClientScript As String

    Private strFieldValue As String = ""

    'Added By GaneshG on 08 Nov 06 -- Flag setting for Issue
    Protected m_strIssueSummary As String = ""
    'End Addition By GaneshG 
    ''Commented and added by nilesh g on 9/10/2015 for change size of array
    ''Private arrValidationMessages(30) As String

    ''Commented and Added by Dhanashri S on 27 Nov 2015
    ''Private arrValidationMessages(50) As String
    Private arrValidationMessages(100) As String
    ''End of Comment and Addition by Dhanashri S on 27 Nov 2015

    ''end of Commented and added by nilesh g on 9/10/2015 for change size of array

    Protected strEnableControlsScript As String

    Private arrEventHandlers(50, 3) As String

    Private strEventHandlers As String

    Protected strDefaultScript As String

    Protected strClientSideScript As String

    Private m_IssuePresent As Boolean = False

    Private m_blnAssignToChanged As Boolean = False

    Private m_blnShowToCustomer As Boolean = False

    Protected declarevariables As String = ""

    Private WithEvents objAttachmentsGrid As New WebPage.Templates.GenericGrid

    'Modified By PrachiK on 17 Feb 2005 for Issue ID. 15334
    'Purpose: Not allow to do any activity if Project is not baselined 
    Protected m_blnIsProjectCreationWorkflowReqd As Boolean = False
    Protected m_intBaselineNumber As Integer = 0

    'Addtion ended

    'added by VivekP on 2 Apr 2005 for copy functionality
    Private m_lngCopyIssueId As Long
    'end of addition
    'Added by HarshK for sp4 issueid 539
    Private m_strEmployeeID As String = "0"
    'End Added by HarshK for sp4 issueid 539

    'Added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through issue and review (IssueID: 683)
    Private blnCalledFromReview As Boolean = False
    Protected intReviewStatisticsID As Integer = 0
    Protected intReviewActionID As Integer = 0
    Private strProjectPhase As String = ""
    Private strReviewer As String = ""
    Private strReviewee As String = ""
    Private intEmployeeID As Integer = 0
    Private strReviewDate As String = ""
    Private strReviewType As String = ""
    Private m_intModuleID As Integer = 0
    Private strModuleName As String = ""
    Private strCause As String = ""
    Private strReviewAction As String = ""
    Private strSeverity As String = ""
    Private strCauseId As String = ""
    Private intDeliverableID As Integer = 0

    'Added by MrugajaB on 2nd Feb 2006 for multiple reviewees feature
    Private strIssueIDs As String = ""
    Private drEmployee As IDataReader
    Private intAssignTo As Integer
    Protected strIssueAddedFrom As String
    'End Addition
    'Integrated by SandipL SP8 to SP9

    'Integrated by PrashantD on 2 March 2007 for Product Execution Project
    ' Added By NitinVS on 25 May 2006 for Roamware Customization
    ' Implementing Product execution

    Protected m_EnableProductExecution As Boolean = False
    Protected m_ProductVersionID As String = "0"
    Protected m_CustomerId As String = "0"
    Protected m_ComponentId As String = "0"
    Protected m_CustomerAtDeliverable As Boolean = False
    Protected m_ProductExecutionPractice As Boolean = False

    ' End Addition By NitinVS on 25 May 2006 for Roamware Customization
    'End of Integration by PrashantD on 2 March 2007

    'End Integration by SandipL SP8 to SP9
    'Integrated by AmitJ on 16 Aug 2006 for whizible SP 7.2 IssueID 2002
    'Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
    Protected intIsCustomerChecked As String = "0"
    'End Integration by SavitaS
    'End Integration by AmitJ

    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197

    Protected m_strToken As String = ""
    Protected m_PKTokenIssueID As String = ""
    Protected m_strToken_AddNewMode As String = ""
    Protected m_strIssueID As String = ""
    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    'Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
    Protected m_FromReview As String = "0"
    Protected m_strFromReview As String = "0"
    'Integrated by SandipL SP8 to SP9
    'Added by SrikanthY on 26 Dec 2006
    Protected m_PKQueryToken As String
    Protected m_Queryid As String
    Protected m_Count As Integer = 0
    'End of Addition by SrikanthY
    'Added by SrikanthY on 22 Jan 2007
    Protected m_QuerySortBy As String
    Protected m_QuerySortOrder As String
    'End Integration by SandipL SP8 to SP9
    Protected m_EnableProjectProductExecution As Boolean
    'Added by PrashantD on 13 July 2007 for Hiding Save link when clicked
    Dim WithEvents m_objMenu As WebPage.Templates.StaticMenu
    'End of additon by PrashantD on 13 July 2007 

    '''Server Date Time Related Variables
    ''Dim h As Integer = 0
    ''Dim m As Integer = 0
    ''Dim strHour As String = ""
    ''Dim strMinute As String = ""
    ''Dim strGetServerTimeSQL1 As String = ""
    ''Dim strGetServerTime1 As String = ""
    ''Dim strGetServerDateSQL1 As String = ""
    ''Dim strGetServerDate1 As String = ""

#End Region ' Form level variables declaration

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag("Extended Custom Fields")
    End Sub

    Public Sub BuildPage()

        Call InitializeVariables()

        Call CheckExistanceOfCustomFields()

        'Added by Dhanashri S on 26 Feb 2015 for Issue Fixing of Extended custom Fields
        Call GetAvailableCustomFields()
        'End of Addition by Dhanashri S on 26 Feb 2015

        If m_strAction.ToUpper = "SAVE" Then

            Call SaveIssue()
            m_blnShowDefaults = False
            m_blnShowRecordSetContents = True

            'CommonFunction.Data.DisposeDataReader(drExtIssueCustomFieldDetails)
            'Call GetExtendedIssueCustomFields()  'Get details of newly saved / edited extended issue custom fields
        End If

        If m_blnShowRecordSetContents = True Then
            Call GetExtendedIssueCustomFields()
        End If

        Dim strMenu As String
        'Added by Dhanashri S on 26 Feb 2015 for Issue Fixing of Extended custom Fields
        If m_blnFields = True Then
            'End of Addition by Dhanashri S on 28 Jan 2015
            strMenu = GenerateMenu()
            'Added by Dhanashri S on 26 Feb 2015 for Issue Fixing of Extended custom Fields
        Else
            strMenu = GenerateMenu2()
        End If
        'End of Addition by Dhanashri S on 28 Jan 2015

        Call GetValidationRules()

        Response.Write(strMenu)
        Response.Write("<BR>")
        Response.Write("<DIV id=divList style='overflow:auto;width:99.9%;height:485px'>")
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, " Extended Custom Fields", " Issue ID: " + m_lngIssueId.ToString, , False))
        Call PlotExtendedCustomFields()
        Response.Write("</DIV>")
        Response.Write(strMenu)

        If m_blnShowRecordSetContents = True Then
            CommonFunction.Data.DisposeDataReader(drExtIssueCustomFieldDetails)
        End If

    End Sub

    Private Sub InitializeVariables()

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("IssueID")) <> "" Then
            m_lngIssueId = CType(Request.QueryString("IssueID"), Long)
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("PKToken")) <> "" Then
            m_strToken = Request.QueryString("PKToken").ToString
        End If

        If ((m_strToken = "") And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + "0" + "0", m_strToken) = False)) Then
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Extended Issue Custom Fields", 0, 0, "Issue ID", CType(m_lngIssueId, String))
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action")
        Else
            m_strAction = ""
        End If

        m_strEmployeeID = CStr(Session("intUserID"))

        Call CreateGlobalObject()

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ProjectID")) <> "" Then
            m_ProjectId = CType(Request.QueryString("ProjectID"), Long)
        End If

        Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngIssueId.ToString + ",'Type'"
        m_strCurrentType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString

    End Sub

    Private Sub CheckExistanceOfCustomFields()

        Dim strSQL As String
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strSQL = "select IssueID from tbl_IB_Issue_ExtendedCustomFields where IssueID = " & m_lngIssueId.ToString
        strSQL = "usp_sel_tbl_IB_Issue_ExtendedCustomFields_IssueID " & m_lngIssueId.ToString
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        If (CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, MyBase.UseSQL)) <> "") Then
            m_blnShowRecordSetContents = True
        Else
            m_blnShowDefaults = True
        End If

    End Sub
    'Added by Dhanashri S on 26 Feb 2015 for Issue Fixing of Extended custom Fields
    Private Sub GetAvailableCustomFields()

        Dim strSQL As String
        Dim drFields As IDataReader
        If m_strCurrentType <> "" Then
            strSQL = "usp_Sel_tbl_IB_ExtendedCustomFields " + m_ProjectId.ToString + ", NULL, 1 , N'" + m_strCurrentType + "'"
        Else
            strSQL = "usp_Sel_tbl_IB_ExtendedCustomFields " + m_ProjectId.ToString + ", NULL, 1"
        End If
        drFields = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If drFields.Read Then
            If drFields("IsCustomFieldAssigned").ToString = "1" Then
                m_blnFields = True
            Else
                m_blnFields = False
            End If
        End If
    End Sub


    Private Function GenerateMenu2() As String

        Dim arrMenu() As String = {"Close", "?"}
        Dim arrMenuToolTip() As String = {"Close", "Help"}
        Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick('ExtendedCustomFields')"}

        m_objMenu = New WebPage.Templates.StaticMenu
        Return m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        m_objMenu = Nothing

    End Function

    'End of Addition by Dhanashri S on 26 Feb 2015

    Private Function GenerateMenu() As String

        Dim arrMenu() As String = {"Save", "Close", "?"}
        Dim arrMenuToolTip() As String = {"Save", "Close", "Help"}
        Dim arrCSFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('ExtendedCustomFields')"}

        m_objMenu = New WebPage.Templates.StaticMenu
        Return m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        m_objMenu = Nothing

    End Function

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
        ' Created               : Feb 7, 2004
        ' Revisions             :
        '=====================================================================

        'Global object

        Dim objGlobal As WebPages.Template.IGlobal

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        With objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            'm_ProjectId = .ProjectID

            ''If Not Request.QueryString("ProjectID") Is Nothing Then
            ''    If Request.QueryString("ProjectID") <> "" Then
            ''        If CType(Request.QueryString("ProjectID"), Long) > 0 Then
            ''            m_ProjectId = CType(Request.QueryString("ProjectID"), Long)

            ''            If CType(Session("IssueProject"), Long) <> m_ProjectId Then
            ''                m_blnProjectChanged = True
            ''                Session("IssueProject") = m_ProjectId
            ''                Session("intViewID") = ""
            ''                Session("intQueryID") = 0
            ''                Session("intFilterOnQuery") = ""
            ''                Session("Filters") = ""
            ''                Session("UnsavedQuery") = ""
            ''            End If
            ''            'End Addition

            ''        End If
            ''    End If
            ''Else
            ''    m_ProjectId = CType(Session("IssueProject"), Long)
            ''End If

            'end of addition

            m_UserId = .UserID
            m_UserName = .UserName
            ''m_CultureId = .LCID
            ''m_FromWhere = .FromWhere
            ''.TagID = 5

            'Code added by SandipL on 17 Feb 2006 --IssueID 2137 AND 2138 -- Whizsem_whiz2 sp6
            Dim intCorporateRoleLevel As Integer
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
            intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_RoleID " & CType(Session("intUserID"), String) & "", MyBase.UseSQL), Integer)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then


                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'Added by PrashantD on 10 April 2007 IssueId 11594
                'If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ApplyProjectLevelRole FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "0"), Boolean) = True Then
                If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_ApplyProjectLevelRole", MyBase.UseSQL), "0"), Boolean) = True Then
                    'End of addition by PrashantD on 10 April 2007
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_ProjectId, String) & "," & CType(m_UserId, String), MyBase.UseSQL), "0"), Long)
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                    If Not m_RoleId > 0 Then
                        m_RoleId = CType(Session("intPostID"), Long)
                    End If
                    'Added by PrashantD on 10 April 2007 IssueId 11594
                Else
                    m_RoleId = CType(Session("intPostID"), Long)
                End If
                'End of addition by PrashantD on 10 April 2007
                If m_RoleId <> 0 Then
                    objGlobal.RoleID = m_RoleId
                End If

                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'm_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
                m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level  " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                If m_RoleLevel <> 0 Then
                    objGlobal.RoleLevel = m_RoleLevel
                End If
            End If
            'End addition by SandipL on 17 Feb 2006
        End With

        ''Dim objAccess As New WebPage.Templates.AccessRights
        ''objAccess.GetAccess(objGlobal)
        ''m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        ''m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        ''m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        ''objAccess = Nothing
    End Sub 'Get all session variable values

    Private Sub PlotExtendedCustomFields()
        '==================================================================================
        ' Procedure Name		:	PlotExtendedCustomFields
        ' Parameters Passed	    :	To plot Extended Custom Fields for Issue
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	GaneshG
        ' Created				:	03-Aug-09
        ' Revisions			    :	
        '==================================================================================

        MyBase.InitializeResources("AppResources.IB_IssueEntry", "AppResources")

        Dim strSQLQuery As String
        Dim intRow, intCol, intNextCellNumber As Integer
        Dim intCurrentCellRow, intCurrentCellCol, intRecordRow, intRecordCol, intRecordCellNumber, intCurrentCellNumber As Integer
        Dim intDestinationIndex, intSourceIndex As Integer

        Dim drLayout As IDataReader
        Dim drCustomAccess As IDataReader
        Dim strSQLForCustom As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer

        strSQLForCustom = "Exec usp_sel_tbl_IB_RoleExtendedCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + "," + m_strEmployeeID + "," + m_LoginType.ToString
        drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)

        While drCustomAccess.Read
            ReDim Preserve strCustomFieldIDs(intCount)
            strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            intCount += 1
        End While

        CommonFunction.Data.DisposeDataReader(drCustomAccess)

        ' Get the layout ID for the person who has currently logged in, if the Layout is role-specific.

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strSQLQuery = "SELECT 'MaxRows' = ISNull(MAX(RowNumber),0), 'MaxCols' = IsNull(MAX(ColumnNumber),0) FROM tbl_IB_CustomFields WHERE ProjectID = " + m_ProjectId.ToString + " AND Active = 1"
        strSQLQuery = "usp_sel_tbl_IB_CustomFields_RowNumber  " + m_ProjectId.ToString + ""
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If drLayout.Read Then
            m_intMaxRows = CType(drLayout("MaxRows"), Integer)
            m_intMaxCols = CType(drLayout("MaxCols"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        Response.Write("<TABLE width=99.9% cellSpacing=0 class=clsTable>")

        'added by VivekP On 2 Apr 2005 for copy functionality (original code is in else part)
        Dim IssueType As String = ""
        ''If m_strAction.ToUpper = "COPYISSUE" Then
        ''    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",'Type'"
        ''    IssueType = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
        ''    strSQLQuery = "usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ", NULL, 1"
        ''    '' SnehalV 5-Oct-2006 
        ''    '' If IssueType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + IssueType + "'"
        ''    If IssueType.Trim <> "" Then strSQLQuery = strSQLQuery + ",N'" + IssueType + "'"
        ''    'MODIFIED BY CHRISTINA T ON 27/06/2006
        ''    drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        ''Else
        strSQLQuery = "usp_Sel_tbl_IB_ExtendedCustomFields " + m_ProjectId.ToString + ", NULL, 1"
        If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",N'" + CommonFunctions.General.BuildQueryString(m_strCurrentType) + "'"

        drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        ''End If
        'end of addition on 2 Apr 2005 for copy functionality

        'strSQLQuery = "usp_Sel_tbl_IB_CustomFields_Master " + m_ProjectId.ToString + ", NULL, 1"
        'If m_strCurrentType.Trim <> "" Then strSQLQuery = strSQLQuery + ",'" + m_strCurrentType + "'"
        'drLayout = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drLayout.Read Then
            Call ClearAttributes(ArrCtlAttr)
            For intRow = 1 To m_intMaxRows
                ''declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('frmIssueExtendedCustomFields','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                Response.Write("<TR class=clsTREven>")
                For intCol = 1 To m_intMaxCols
                    declarevariables = declarevariables + "var obj" + drLayout("DatabaseFieldName").ToString.Trim + "= GetObjectReference('frmIssueExtendedCustomFields','" + drLayout("DatabaseFieldName").ToString.Trim + "');" + vbCrLf
                    intCurrentCellNumber = (intRow * m_intMaxCols) + intCol
                    intNextCellNumber = (CType(drLayout("RowNumber"), Integer) * m_intMaxCols) + CType(drLayout("ColumnNumber"), Integer)

                    If intCurrentCellNumber < intNextCellNumber Then
                        Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                    ElseIf intCurrentCellNumber >= intNextCellNumber Then
                        Response.Write("<td valign=top align=right style='width:10%'>")

                        '''''Added By VivekP On 2 Apr 2005 for Copy Functionality
                        ''''If m_strAction.ToUpper = "COPYISSUE" Then
                        ''''    Dim strSQL As String = "usp_sel_GetFieldValueForIssue " + m_lngCopyIssueId.ToString + ",N'" + drLayout("DatabaseFieldName").ToString.Trim + "'"
                        ''''    'MODIFIED BY CHRISTINA T ON 26/07/2006
                        ''''    strFieldValue = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL)).ToString
                        ''''Else
                        ''''    'End Of Addition On 2 Apr 2005 for Copy Functionality

                        ''''    'get value form

                        If m_blnShowRecordSetContents = True Then
                            strFieldValue = Trim(drExtIssueCustomFieldDetails(drLayout("DatabaseFieldName").ToString).ToString)
                        Else
                            strFieldValue = ""
                        End If

                        ''''    'Added By VivekP On 2 Apr 2005 for Copy Functionality
                        ''''End If
                        '''''End Of Addition On 2 Apr 2005 for Copy Functionality


                        ' Retrieve the attributes of the control to be displayed.
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = drLayout("DatabaseFieldName").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION) = CommonFunction.Data.CheckIsDBNull(drLayout("UserGivenCaption"), "").ToString
                        'Commented And Modified By ChaitraliH On 27 Mat 10
                        'Purpose:Extra Quote (') gets appended when entered the data containing Quote(')
                        'ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = CommonFunction.General.BuildQueryString(strFieldValue)
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = strFieldValue
                        'End:Commented And Modified By ChaitraliH On 27 Mat 10
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlHeight"), "0").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = CommonFunction.Data.CheckIsDBNull(drLayout("ControlWidth"), "0").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("DefaultValue"), "").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxLength"), "2000").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = CommonFunction.Data.CheckIsDBNull(drLayout("ValidationRules"), "").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MIN_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MinValue"), "0").ToString
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_VALUE) = CommonFunction.Data.CheckIsDBNull(drLayout("MaxValue"), "0").ToString

                        ' Set the control type depending on the name of the custom field to be displayed.
                        ' For Text Box custom fields...
                        If InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "CustomFieldTextArea") > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString

                            ' Set the maxlengths of the textareas.
                            If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "CustomFieldTextArea3" Then

                                'If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) Then
                                'ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "3800"
                                'ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) > 3800 Then
                                '    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "3800"
                                'End If

                                If InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
                                End If
                            End If

                            intDestinationIndex = 30 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldTextArea") + 1, 1))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

                        ElseIf InStr(drLayout("DatabaseFieldName").ToString, "CustomFieldText", CompareMethod.Text) > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString

                            ' Set the maxlengths of the textboxes.
                            If Not IsNumeric(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "100"
                            ElseIf CInt(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) > 100 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) = "100"
                            End If

                            If InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
                            End If

                            ' If the date validation rule is applied on the text box control, then the control is to be transformed to a date control.
                            If InStr(1, "," + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), ",2,") <> 0 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"
                            End If

                            intDestinationIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldText") + 1, 2))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

                            ' For Combo Box custom fields...									
                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldCombo", CompareMethod.Text) > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY) = "Exec usp_Sel_tbl_IB_ExtendedCustomFields_Details N'" + CommonFunction.General.BuildQueryString(drLayout("DatabaseFieldName").ToString.Trim) + "', " + m_ProjectId.ToString

                            If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES), "12,") = 0 Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES) + "12,"
                            End If

                            intDestinationIndex = 15 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldCombo") + 1, 2))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

                            ' For Date Control custom fields...								
                        ElseIf InStr(drLayout("DatabaseFieldName").ToString.Trim, "CustomFieldDate") > 0 Then

                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH) = "80"

                            intDestinationIndex = 40 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), Len("CustomFieldDate") + 1, 1))
                            arrEventHandlers(intDestinationIndex, 0) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
                            arrEventHandlers(intDestinationIndex, 1) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)
                            ' For Text Area custom fields...                        
                        End If

                        ' If the not blank validation rule has been set for a control, then, the show as mandatory flag must be shown.
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "False"
                        If InStr("," + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES).ToString.Trim, ",1,") <> 0 Then
                            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                        End If

                        ''' If the default value is to be retrieved from one of the common fields or custom fields, then...
                        ''If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) <> "" And CommonFunction.Data.CheckIsDBNull(drLayout("DefaultType"), "").ToString.Trim = "F" Then

                        ''    ' If the default value is to be retrieved from one of the CUSTOM fields, then the OnChange Event must be written.
                        ''    If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE).ToString, "CustomField") <> 0 And (ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) <> ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) Then

                        ''        ' Get the index of the custom fields.
                        ''        If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE).ToString, "CustomFieldTextArea") <> 0 Then
                        ''            ' Text Area Range	: 26 - 28.
                        ''            intSourceIndex = 25 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldTextArea") + 1, 1))
                        ''        ElseIf InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE).ToString, "CustomFieldText") <> 0 Then
                        ''            ' Text box Range	: 1 - 10.
                        ''            intSourceIndex = 0 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldText") + 1, 2))
                        ''        ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), "CustomFieldCombo") <> 0 Then
                        ''            ' Combo box Range	: 11 - 20.
                        ''            intSourceIndex = 10 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldCombo") + 1, 2))
                        ''        ElseIf InStr(1, ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), "CustomFieldDate") <> 0 Then
                        ''            ' Date control Range: 21 - 25.
                        ''            intSourceIndex = 20 + CInt(Mid(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE), Len("CustomFieldDate") + 1, 1))
                        ''        End If

                        ''        strEventHandlers = ""
                        ''        strEventHandlers = strEventHandlers + "		var objSource = GetObjectReference('frmIssueExtendedCustomFields','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                        ''        strEventHandlers = strEventHandlers + "		var objDestination = GetObjectReference('frmIssueExtendedCustomFields','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "');" + vbCrLf
                        ''        strEventHandlers = strEventHandlers + "		If (Trim(objDestination.value) == """")" + vbCrLf + "{"

                        ''        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                        ''            strEventHandlers = strEventHandlers + "		objDestination.value = objSource.value;" + vbCrLf
                        ''        Else
                        ''            strEventHandlers = strEventHandlers + "		objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                        ''        End If

                        ''        strEventHandlers = strEventHandlers + "}" + vbCrLf

                        ''        arrEventHandlers(intSourceIndex, 2) = arrEventHandlers(intSourceIndex, 2) + strEventHandlers

                        ''    End If

                        ''    strDefaultScript = strDefaultScript + "var objSource = GetObjectReference('frmIssueExtendedCustomFields','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) + "');" + vbCrLf
                        ''    strDefaultScript = strDefaultScript + "var objDestination = GetObjectReference('frmIssueExtendedCustomFields','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "');" + vbCrLf
                        ''    strDefaultScript = strDefaultScript + "if ((objSource!=null)&&(objDestination!=null)){" + vbCrLf
                        ''    strDefaultScript = strDefaultScript + "if(Trim(objDestination.value) == """")" + vbCrLf

                        ''    'If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE) <> CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
                        ''    strDefaultScript = strDefaultScript + "	objDestination.value = objSource.value;" + vbCrLf
                        ''    'Else
                        ''    '    strDefaultScript = strDefaultScript + "	objDestination.value = funcGetDate(objSource.value);" + vbCrLf
                        ''    'End If

                        ''    strDefaultScript = strDefaultScript + "}" + vbCrLf
                        ''    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) = ""

                        ''End If

                        Response.Write(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))

                        Response.Write("</td>")
                        Response.Write("<td valign=top style='width:15%'>")

                        'Reason :   Apply Role Level Security to custom fields
                        'Addition   :  Added the code to check if security is set for given projectID and RoleID
                        Dim blnShowControl As Boolean = False
                        Dim intCounter As Integer

                        intCounter = 0
                        'If length of array is greater than 0 that means security is explicitly set
                        'In that case check if it is accessible ,if yes then show the control, 
                        'otherwise show it as not applicable
                        If intCount > 0 Then

                            While intCounter < intCount
                                'Check if the current Custom Field ID is in the array
                                If strCustomFieldIDs(intCounter).ToLower.Trim = _
                                            CType(CommonFunction.General.CheckIsNothing(drLayout("UniqueId")), String).ToLower.Trim Then
                                    blnShowControl = True
                                End If

                                intCounter = intCounter + 1

                            End While
                        End If

                        'Reason     : Apply Role Level Security to custom fields
                        'Addition   : Added one more condition to the IF to display the control
                        If drLayout("IsCustomFieldAssigned").ToString = "1" And blnShowControl = True Then
                            Call DrawControl(ArrCtlAttr)
                            Call ClearAttributes(ArrCtlAttr)
                        Else

                            If m_blnShowDefaults = True Then
                                ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
                            End If

                            'The Custom Field is not defined for the Current Type
                            Response.Write("( " + MyBase.GetResourceString("NOTAPPLICABLE") + " )")

                            'Do not save value if the Custom Field is not applicable
                            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                            CommonFunction.HTMLControls.DrawTextBox(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), , , , ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE), IsHidden:=True, EnableHTMLEncode:=True)
                            'ended by Yogesh J for HTML encoding Date:06/10/15
                            'reset value of inactive custom fields before saving.
                            strClientSideScript = strClientSideScript + vbCrLf + "obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ".value = """";" + vbCrLf
                        End If
                        Response.Write("</TD>")
                        If Not drLayout.Read() Then
                            Dim i As Integer
                            For i = intCol To m_intMaxCols - 1
                                Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                            Next
                            Exit For
                        End If
                    Else
                        Response.Write("<td valign=top align=right colspan=2 style='width:25%'>&nbsp;</td>")
                        If Not drLayout.Read() Then
                            Dim i As Integer
                            For i = intCol To m_intMaxCols - 1
                                Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                            Next
                            Exit For
                        End If
                    End If
                Next
                Response.Write("</TR>")
            Next

            ''Response.Write("<SCRIPT language=javaScript>" + vbCrLf)
            ''CommonFunction.Data.DisposeDataReader(drLayout)

            ''Dim intCtr As Integer
            ''' Loop through the array to check if any event handlers need to be printed.
            ''For intCtr = LBound(arrEventHandlers) To UBound(arrEventHandlers)
            ''    If arrEventHandlers(intCtr, 0) <> "" And arrEventHandlers(intCtr, 2) <> "" Then
            ''        If arrEventHandlers(intCtr, 1) = CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString Then
            ''            Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnPropertyChange(){" + vbCrLf)
            ''        Else
            ''            Response.Write("	function " + arrEventHandlers(intCtr, 0) + "_OnChange(){" + vbCrLf)
            ''        End If
            ''        Response.Write(arrEventHandlers(intCtr, 2))
            ''        Response.Write("}" + vbCrLf)
            ''    End If
            ''Next
            ''Response.Write("</SCRIPT>" + vbCrLf)
        Else
            Response.Write("<tr class=clsTREven>")
            Response.Write("<td align=center valign=center>")
            Response.Write("<b>" + MyBase.GetResourceString("NOCUSTOMFIELDS") + "</b>")

            Response.Write("</td>")
            Response.Write("</tr>")
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)

        Response.Write("</TABLE>")

    End Sub

    Private Sub DrawControl(ByRef ArrCtlAttr() As String)
        '==================================================================================
        ' Procedure Name		:	DrawControl
        ' Parameters Passed		:	arrCtlAttr : This array contains the attributes of the control to be drawn.
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets modified.
        ' Purpose				:	To actually draw the control as per the specifications in the array.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 10, 2004
        ' Revisions				:	
        '==================================================================================		

        Dim strToBeInserted As String = ""
        Dim strProperty As String
        Dim intCtr As Integer

        Dim strControlName As String
        Dim strControlValue As String = ""
        Dim SQLQuey As String
        Dim intControlWidth, intControlHeight, intControlMaxLength As Integer
        Dim blnReadOnly As Boolean = False
        Dim blnIsMandatory As Boolean = False
        Dim blnIsDisabled As Boolean = False

        ' If the default values have to be shown, then... (When the page is loaded for the first time.)
        If m_blnShowDefaults = True Then
            ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
        End If

        If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) Is Nothing Then
            strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)

            'Code Added By VidyaJ for IssueID - 15703
            'Set Default Value if default value is set for the control
            If strControlValue = "" Then
                If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE) Is Nothing Then
                    strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_DEFAULT_VALUE)
                    'Added By AmitJ For Cashtech IssueId 3324 : If Issue status contains special char like "'" e.g. 
                    'status = won't fix then page crashes in Add & Edit Mode
                    If strControlValue <> "" Then
                        strControlValue = Replace(strControlValue, "'", "''")
                    End If
                    'End Of Addition
                End If
            End If
            'End Of Addition
        Else
            strControlValue = ""
        End If

        'Control Name
        strControlName = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)

        ' control width 
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH)) <> "" Then
            intControlWidth = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_WIDTH), Integer)
        End If

        'Cotrol Height
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT)) <> "" Then
            intControlHeight = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_HEIGHT), Integer)
        End If

        ' Read Only
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True" Then
            blnReadOnly = True
            strToBeInserted = strToBeInserted & " disabled "
            blnIsDisabled = True
        Else
            blnReadOnly = False
            blnIsDisabled = False
        End If

        ' additional information.
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO)) <> "" Then
            strToBeInserted = strToBeInserted + Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_OTHER_INFO)) + " "
        End If

        ' maxlength 
        If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then
            intControlMaxLength = CType(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH), Integer)
            'strToBeInserted = strToBeInserted + " maxlength=" + Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) + " "
        End If

        ' mandatory 
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True" Then
            blnIsMandatory = True
        Else
            blnIsMandatory = False
        End If
        'Added By shraddhaM on 8,Mar 2007 for CashTech IssueID : 4637 IssueID - 11547
        'Purpose : Hide extra * on Page
        If strControlName.ToUpper() = "STATUSCHANGETIME" And ((m_LoginType = "C") Or (m_IsIssueSLAApplicable = False)) Then
            blnIsMandatory = False
        End If

        'End of Addition By shraddhaM on 8,Mar 2007 for CashTech IssueID : 4637 IssueID - 11547

        ' Depending on the control type, draw the control.
        Select Case ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE)

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_BOX.ToString  ' Draw the text box.
                If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "DeliverableID" Then

                    Dim strDeliverableName As String
                    Dim drGetDeliverable As IDataReader
                    Dim strSQL As String


                    'end of addition on 2 Apr 2005 for Copy functionality

                    If strControlValue <> "" Then
                        'Added by MonikaI on 10th Oct 2006 IssueID : 6940
                        m_intDeliverableID = CType(strControlValue, Integer)
                        'End of addition by MonikaI
                        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                        'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + CType(strControlValue, String)
                        strSQL = "usp_sel_tbl_PM_OtherSchedules_Title_ID " + CType(strControlValue, String)
                        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                        drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                        If drGetDeliverable.Read Then
                            '' START : Modified BY ParagD On 5-Sept-2006
                            '' Purpose : Whizible SP7 Issue : Select Deliverable when contain quotes within it.
                            strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                            '' END : Modified BY ParagD On 5-Sept-2006
                        End If

                        CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                    End If
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", True, strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    '' START : Modified BY ParagD On 5-Sept-2006
                    '' Purpose : Whizible SP7 Issue : Select Deliverable when contain quotes within it.

                    '' Response.Write("<Input  Type=Textbox  name='txtDeliverableName' id='txtDeliverableName' class='clsTextBoxReadOnly' style='width:150px'  maxlength=100 value='" & strDeliverableName + "' disabled  readonly style='BACKGROUND-COLOR='>")
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", "clsTextBoxReadOnly", , 100, strDeliverableName, "Left", , True, blnReadOnly, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                    '' END : Modified BY ParagD On 5-Sept-2006

                    Response.Write("&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:JavaScript:SelectDeliverable()'>")

                Else
                    'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(strControlName, strControlName, , intControlWidth, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:06/10/15
                End If


            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_COMBO_BOX.ToString
                SQLQuey = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SQL_QUERY)
                Response.Write(CommonFunction.HTMLControls.DrawComboBox(strControlName, SQLQuey, intControlWidth, strControlValue, strToBeInserted, True, , , blnIsMandatory))

                'Assign Issue button
                If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) = "AssignTo" And m_lngIssueId <> 0 And ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                    'Added following condition by PrashantD on 16 March 2007 for IssueID 11594
                    'Purpose:When user has edit access then only show Assign Task link
                    If m_blnEditAccess = True And m_lngIssueId > 0 Then
                        Response.Write("&nbsp;<a Href='javascript:AssignIssue_OnClick()'><image BORDER=0 src='..\..\images\dblclick.gif' alt='Click here to assign the issue...'></a>")
                    End If

                End If

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_TEXT_AREA.ToString  ' Draw the text area.
                'Modified by Shraddham on 8th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIssueExtendedCustomFields", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, wrap:="Soft"))
                Response.Write(CommonFunction.HTMLControls.DrawTextArea(strControlName, strControlName, , , , "frmIssueExtendedCustomFields", , , intControlWidth, intControlHeight, intControlMaxLength, strControlValue, , , , blnReadOnly, "", , strToBeInserted, , blnIsMandatory, Wrap:="Soft", EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_CHECK_BOX.ToString  ' Draw the check box.

                If Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)) = "True" Or Trim(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)) = "1" Then
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "1"
                Else
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = "0"
                End If
                strControlValue = ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE)

                'If m_strAction.ToUpper = "TYPECHANGE" Then strControlValue = "1"

                'Added by SavitaS on 26 Sept for SP7 IssueID 4887
                If (m_LoginType = "C") And strControlName.ToUpper = "SHOWTOCUSTOMER" Then
                    'If logged in user is Customer then draw hidden control
                    Response.Write(CommonFunction.HTMLControls.DrawCheckBox(strControlName, strControlName, , CType(strControlValue, Boolean), , , strToBeInserted, , blnIsMandatory, , True, True))
                Else
                    Response.Write(CommonFunction.HTMLControls.DrawCheckBox(strControlName, strControlName, , CType(strControlValue, Boolean), , , strToBeInserted, , blnIsMandatory, , True))
                End If
                'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887

            Case CommonFunction.Constants.IB_ControlTypes.APP_CONTROL_TYPE_DATE_FIELD.ToString  ' Draw the date field.
                If Not ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) Is Nothing Then
                    If Not IsDate(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE).Trim) Then
                        ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                    End If
                Else
                    ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_VALUE) = ""
                End If

                If strControlValue <> "" Then

                    'Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
                    'Purpose:When logintype is customer or Project level issue SLA is not applicable then do not display status change date field
                    If ((strControlName = "StatusChangeDate") And (m_LoginType = "C")) Or ((strControlName = "StatusChangeDate") And (m_IsIssueSLAApplicable = False)) Then
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmIssueExtendedCustomFields", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted, True))
                    Else
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, CommonFunction.Dates.GetDate(CType(strControlValue, Date)), , "frmIssueExtendedCustomFields", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    End If
                Else
                    If ((strControlName = "StatusChangeDate") And (m_LoginType = "C")) Or ((strControlName = "StatusChangeDate") And (m_IsIssueSLAApplicable = False)) Then
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmIssueExtendedCustomFields", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted, True))
                    Else
                        Response.Write(CommonFunction.HTMLControls.DrawDateControl(strControlName, strControlName, , intControlWidth, , , "frmIssueExtendedCustomFields", , , , blnIsDisabled, blnReadOnly, "", , blnIsMandatory, , strToBeInserted))
                    End If
                End If
                'End Modification
            Case Else
                Response.Write("&nbsp;")

        End Select

        ''Commented and Added by Dhanashri S on 27 Nov 2015
        ''Dim arrtemp(30) As String
        Dim arrtemp(100) As String
        ''End of Comment and Addition by Dhanashri S on 27 Nov 2015
        arrValidationMessages.CopyTo(arrtemp, 0)

        'Generate the client side validation scripts for the control.		
        Call GenerateValidationScript(ArrCtlAttr, arrtemp)
        'Response.Write(ArrCtlAttr(ATTR_CONTROL_NAME) + ArrCtlAttr(ATTR_READ_ONLY))

        ' If the control is disabled, then enable it before submitting.
        If ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "True" Then
            If InStr(ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME).ToString.Trim, "Keywords") <> 0 Then
                strEnableControlsScript = "var obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "= GetObjectReference('frmIssueExtendedCustomFields','" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "',1);" + vbCrLf
                For intCtr = 0 To 4
                    'Modified by SantoshK on Date June 7, 2006 for WhizibleSEM Issue ID.4168
                    'Purpose : Firefox Support, Changed () to []
                    strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + "[" + intCtr.ToString + "].disabled = false;" + vbCrLf
                    'Modification Ends by SantoshK on June 7, 2006
                Next
            Else
                strEnableControlsScript = strEnableControlsScript + "obj" + ArrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ".disabled = false;" + vbCrLf
            End If
        End If

    End Sub 'Draw the control 

    Private Sub GetExtendedIssueCustomFields()
        '=====================================================================
        ' Procedure Name        : GetIssueDetails()	
        ' Purpose               : to get issue details
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 10, 2004
        ' Revisions             :
        '=====================================================================

        ' Get the details of the current IssueID.
        ' NOTE : If the IssueID = 0, then a blank recordset will be returned.
        drExtIssueCustomFieldDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue_ExtendedCustomFields " + m_lngIssueId.ToString, MyBase.UseSQL)
        drExtIssueCustomFieldDetails.Read()

        'CommonFunction.Data.DisposeDataReader(drExtIssueCustomFieldDetails)
    End Sub 'Issue Details

    Private Sub ClearAttributes(ByRef arrCtlAttr As String())
        '==================================================================================
        ' Procedure Name		:	IsValidField
        ' Parameters Passed		:	arrCtlAttr : This array has to be re-initialised for each control
        ' Returns				:	No return Value.
        ' Parameters Affected	:	arrCtlAttr :- The array gets reinitialised.
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2004
        ' Revisions				:	
        '==================================================================================		

        Dim intCtr As Integer

        For intCtr = 0 To 14
            arrCtlAttr(intCtr) = ""
        Next

        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False"

    End Sub 'Clear control Atributes

    Private Sub GenerateValidationScript(ByRef arrCtlAttr() As String, ByVal arrValidations() As String)
        '==================================================================================
        ' Procedure Name		:	GenerateValidationScript
        ' Parameters Passed		:	arrCtlAttr : This array contains all the attributes of the control to be drawn.
        '							arrValidationMessages : The array containing the validation messages.
        ' Returns				:	No Return Value
        ' Parameters Affected	:	arrCtlAttr [if the Not blank validation rule is set, then the Show As Mandatofy flag is set.]
        ' Purpose				:	To generate the client side validation script depending on the validation rules set for that control.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 17, 2004
        ' Revisions				:	
        '==================================================================================

        Dim strValidation As String = ""
        Dim intCtr As Integer = 0
        Dim arrRules As String()
        Dim intValidationID As Integer

        ' Get the validation rule IDs in an array.
        strValidation = ""

        arrRules = Split(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_VALIDATION_RULES).Trim, ",")

        If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "Keywords") <> 0 Then
            Exit Sub
        End If

        ' For each validation rule to be applied, generate the client side validation script.
        For intCtr = LBound(arrRules) To UBound(arrRules)
            If arrRules(intCtr) <> "" Then
                intValidationID = CType(arrRules(intCtr), Integer)
                'If IsNumeric(intValidationID) Then
                intValidationID = CInt(intValidationID)
                arrValidations(intValidationID) = Replace(arrValidations(intValidationID), "<ID>", arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_CAPTION))
                'End If
            End If


            Dim strControlName As String = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)
            Dim strMinValue As String = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MIN_VALUE)
            Dim strMaxValue As String = arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_VALUE)

            Select Case intValidationID.ToString

                Case "1" ' Not Blank.														

                    '''Modified By ShraddhaM on 29 Sep 2006
                    ''If strControlName = "StatusChangeDate" Then
                    ''    If m_LoginType <> "C" And m_IsIssueSLAApplicable = True Then
                    ''        strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf

                    ''        If InStr(strControlName, "CustomField") <> 0 Then
                    ''            strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''            'select tab if not selected
                    ''            If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''                strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''                'Expand section if collapsed
                    ''            ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''                strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''            End If
                    ''        Else
                    ''            strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''            'select tab if not selected
                    ''            If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''                strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''                'Expand section if collapsed
                    ''            ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''                strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''            End If
                    ''        End If

                    ''        If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                    ''            strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    ''        End If
                    ''        strValidation = strValidation + "return;" + vbCrLf
                    ''        strValidation = strValidation + "}" + vbCrLf
                    ''        arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                    ''    End If
                    ''Else
                    ''Ended By ShraddhaM on 29 Sep 2006
                    strValidation = strValidation + "if(disallowBlank(obj" + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME) + ",'" + CommonFunction.General.FormatString(arrValidations(1), False) + "',false)){" + vbCrLf

                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If

                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf
                    arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_SHOW_AS_MANDATORY) = "True"
                    ''End If


                Case "2" ' Valid Date.	

                    strValidation = strValidation + "if(!isDate(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(2), False) + "',false){" + vbCrLf

                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "3" ' Numeric Data.

                    strValidation = strValidation + "if(disallowNonNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(3), False) + "',false)){" + vbCrLf

                    'strValidation = strValidation + "	alert( """ + arrValidations(3) + """);" + vbCrLf
                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "9" ' Only Alphabets.

                    strValidation = strValidation + "if(disallowNonAlphabets(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(9), False) + "',false)){" + vbCrLf

                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "12" ' Max Length
                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_TYPE).ToString.ToUpper = "APP_CONTROL_TYPE_TEXT_AREA" Then
                        If Trim(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)) <> "" Then

                            strValidation = strValidation + "if(disallowMaxlengthViolation(obj" + strControlName + "," + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(12), "<LENGTH>", arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH)), False) + "',false)){" + vbCrLf

                            strValidation = strValidation + "	obj" + strControlName + ".value = Left(Trim(obj" + strControlName + ".value), " + arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_MAX_LENGTH) + ");" + vbCrLf
                            ''If InStr(strControlName, "CustomField") <> 0 Then
                            ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                            ''    'select tab if not selected
                            ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                            ''        'Expand section if collapsed
                            ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                            ''    End If
                            ''Else
                            ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                            ''    'select tab if not selected
                            ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                            ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                            ''        'Expand section if collapsed
                            ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                            ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                            ''    End If
                            ''End If
                            If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                                strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                            End If
                            strValidation = strValidation + "return false;" + vbCrLf
                            strValidation = strValidation + "}" + vbCrLf
                        End If
                    End If

                Case "13" ' Positive Numeric Data.				

                    ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
                    ' Changed validation from disallowNegativeInteger to disallowNegativeNumeric

                    'strValidation = strValidation + "if (disallowNegativeInteger(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    strValidation = strValidation + "if (disallowNegativeNumeric(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(13), False) + "',false)){" + vbCrLf
                    ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

                    'strValidation = strValidation + "	alert( """ + arrValidations(13) + """);" + vbCrLf
                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If

                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "14" ' Check Duplication.
                    ' Not Processed !!

                Case "15" ' Restrict Special characters.

                    strValidation = strValidation + "if(disallowSpecialCharacters(obj" + strControlName + ",'" + CommonFunction.General.FormatString(arrValidations(15), False) + "',false)){" + vbCrLf

                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If

                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "16" ' Minimum Value Check.

                    strValidation = strValidation + "if(disallowMinValueViolation(obj" + strControlName + ", " + strMinValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(16), "<VALUE>", strMinValue), False) + "',false)){" + vbCrLf

                    ''If InStr(strControlName, "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If

                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "17" ' Maximum Value Check.

                    strValidation = strValidation + "if(disallowMaxValueViolation(obj" + strControlName + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(17), "<VALUE>", strMaxValue), False) + "',false)){" + vbCrLf

                    ''If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If

                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case "18" ' Value Range.

                    strValidation = strValidation + "if(disallowValueRangeViolation(obj" + strControlName + ", " + strMinValue + ", " + strMaxValue + ",'" + CommonFunction.General.FormatString(Replace(arrValidations(18), "<RANGE>", strMinValue + " - " + strMaxValue), False) + "',false)){" + vbCrLf

                    ''If InStr(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME), "CustomField") <> 0 Then
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(1);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCustomFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''Else
                    ''    strValidation += "ShowHideIssueDetails(""none"");" + vbCrLf
                    ''    'select tab if not selected
                    ''    If m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_TABS Then
                    ''        strValidation = strValidation + "	Tab_OnClick(0);" + vbCrLf
                    ''        'Expand section if collapsed
                    ''    ElseIf m_DisplayStyle = IB_ControlDisplayStyle.CONTROLS_IN_SECTIONS Then
                    ''        strValidation = strValidation + "	HideShowCommonFieldsSection(""none"");" + vbCrLf
                    ''    End If
                    ''End If

                    If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
                        strValidation = strValidation + "	setFocus(obj" + strControlName + ");" + vbCrLf
                    End If
                    strValidation = strValidation + "return false;" + vbCrLf
                    strValidation = strValidation + "}" + vbCrLf

                Case Else
            End Select
        Next

        ' if the control is editable, only then apply the validation rules.
        If Right(strValidation, 2) = ";;" Then
            strValidation = Left(strValidation, Len(strValidation) - 1)
        End If
        If arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_READ_ONLY) = "False" Then
            strClientSideScript = strClientSideScript + strValidation
            'Integrated by SandipL SP8 to SP9
            'Integrated by PrashantD on 2 March 2007 for Product Execution Project
            ' Modified By NitinVs on 28 May 2006 for Roamware Customization 
            ' Add case for Product 
        ElseIf UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "SUMMARY" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "REPORTEDBY" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "DESCRIPTION" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "PRODUCTVERSIONID" Or UCase(arrCtlAttr(CommonFunction.Constants.IB_ControlAttributes.APP_IB_ATTR_CONTROL_NAME)) = "CUSTOMERID" Then
            strClientSideScript = strClientSideScript + strValidation
        End If
        ' End Modification By NitinVs on 28 May 2006 for Roamware Customization 
        'End of Integration by PrashantD on 2 March 2007

        'End Integration by SandipL SP8 to SP9

    End Sub

    Private Sub GetValidationRules()
        '==================================================================================
        ' Procedure Name		:	GetValidationRules
        ' Parameters Passed		:	To get all the validation messages in an array
        ' Returns				:	none
        ' Parameters Affected	:	none
        ' Purpose				:	
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	AniruddhaD
        ' Created				:	Feb 12, 2003
        ' Revisions				:	
        '==================================================================================		

        Dim drValidationRules As IDataReader

        ' Retrieve all the validation messages.
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'drValidationRules = CommonFunction.Data.GetDataReader("SELECT * FROM tbl_UI_Validation ORDER BY ValidationID", MyBase.UseSQL)
        drValidationRules = CommonFunction.Data.GetDataReader("usp_sel_tbl_UI_Validation_ValidationID", MyBase.UseSQL)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        'Save all these validation messages in array
        Do While drValidationRules.Read
            arrValidationMessages(CType(drValidationRules("ValidationID"), Integer)) = drValidationRules("ValidationMessage").ToString.Trim
        Loop

        'Dispose data reader
        CommonFunction.Data.DisposeDataReader(drValidationRules)
    End Sub 'Get all validation rules and generate array

    Private Sub SaveIssue()
        '=====================================================================
        ' Procedure Name        : SaveIssue()	
        ' Purpose               : To save / import issue
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 16, 2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL, strDatabaseQuery, strFieldList, strValueList As String
        Dim drIssueFields As IDataReader, IssueId As Long
        Dim intUpperBound As Integer

        m_blnAssignToChanged = False

        ' Retrieve the list of fields in the Extended Issue Custom Fields Table for generating Hash Table
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT * FROM tbl_IB_Issue_ExtendedCustomFields WHERE 1=2"
        strSQL = "usp_sel_tbl_IB_Issue_ExtendedCustomFields_1"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        'Generate Hash table.
        Dim ht As New System.Collections.Hashtable
        ht = CommonFunctions.Data.GetSchema(strSQL, MyBase.UseSQL)

        strDatabaseQuery = ""

        ' New Issue - Generate Insert Query 
        If m_blnShowRecordSetContents = False Then

            'm_blnShowToCustomer = False

            ' Generate the Insert Query.
            strDatabaseQuery = strDatabaseQuery & "INSERT INTO tbl_IB_Issue_ExtendedCustomFields "

            'Modified by MrugajaB on 25th Feb 2006 for Isue ID.2395
            'When Issue is added through reviews using 'Add Issue' link then ReviewActionID was not getting added
            strFieldList = "IssueID, CreatedBy, CreatedDate"
            strValueList = m_lngIssueId.ToString + ", N'" + CommonFunction.General.BuildQueryString(m_UserName) + "','" + Now.Today.ToString + "'"

            'MODIFIED BY CHRISTINA T ON 27/06/2006
            'End Modification

            'No hash table to be created as no data present in sql for txtWorkInHours (Appended last in form conditionally)
            'Hence determine upper bound
            Dim inti As Integer
            'If Not MyBase.GetFormValue("txtWorkInHours") Is Nothing Then
            intUpperBound = Request.Form.AllKeys.Length - 1
            'Else
            'intUpperBound = Request.Form.AllKeys.Length
            'End If

            ' loop through each element in the form 
            'Omit first 5 controls on the form as they are static and no hash table can be created for them.

            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
            'Added By PradipK on 13 March 2006 for SLA Management
            '  For inti = 8 To intUpperBound   'Value of inti changed from 6 to 8 by MrugajaB on 11th May 2005
            'Modified by SantoshK on Date June 6, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support
            Dim iCounter As Integer = 1
            ''If InStr(CType(Request.ServerVariables("HTTP_USER_AGENT"), String), "Internet Explorer") > 0 Then
            ''    iCounter = 14
            ''Else
            ''    iCounter = 12
            ''End If
            'Modification Ends by SantoshK on June 6, 2006

            For inti = iCounter To intUpperBound

                'End Addition By PradipK on 13 March 2006 for SLA Management
                'Do nothing for "PriorityFixInDays", "txtOldAssignedTo" and "txtWorkInHours" as they are static and hidden 
                'Controls add in the form and no hash table to be crated for them as no data is available in SQL for these controls
                'Code For ignoring dummy date control added by SandipL on 3 Dec 2005 --IssueID 672 
                'Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                'If Request.Form.GetKey(inti).ToUpper = "TXTOLDSTATUS" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                If Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                    inti += 1
                    'Exit loop if counter exceeds upperbound
                    If inti > intUpperBound Then Exit For
                End If

                '''Added by SavitaS on 26 Sept for SP7 IssueID 4887
                ''If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" And m_LoginType = "C" Then
                ''    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                ''    inti += 1
                ''    'Exit loop if counter exceeds upperbound
                ''    If inti > intUpperBound Then Exit For
                ''    'Added by SavitaS on 27 Sept 2006 for SP7 IssueID 4887
                ''    'If Show to Customer checkbox is checked and save the issue Page crashes
                ''    If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                ''        inti += 1
                ''        'exit loop if counter excceds upper bound
                ''        If inti > intUpperBound Then
                ''            Exit For
                ''        End If
                ''    End If
                ''    'End Addition by SavitaS on 27 Sept 2006
                ''End If
                'End of Added by SavitaS on 26 Sept for SP7 IssueID 4887
                ''' Added By Nikhil A on 02-december-2015 for page crash on Extended custome field link
                If Request.Form.GetKey(inti) = "__VIEWSTATEGENERATOR" Or Request.Form.GetKey(inti) = "__VIEWSTATEENCRYPTED" Then
                    Continue For
                End If
                ''' Added By Nikhil A on 02-december-2015 for page crash on Extended custome field link
                'Generate schema for the control, containing details about, like fieldname, datatype, size etc.
                Dim objSchema As New CommonFunction.Data.Schema
                objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)

                '''Check if Responsible person is changed
                ''If Request.Form.GetKey(inti) = "AssignTo" Then
                ''    m_blnAssignToChanged = True
                ''End If

                'omit IssueId from query, as it is identity key in the table. 
                ''If Request.Form.GetKey(inti) <> "IssueID" Then

                ' If the "ShowToCustomer" check box is found in the form, set the flag to indicate the same.
                ''If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" Then
                ''    m_blnShowToCustomer = True
                ''End If

                ' Check if the name of the form item, is a valid field in the Issue table. If yes, then proceed.
                ''If IsValidField(drIssueFields, Request.Form.GetKey(inti)) Then
                'Added by Harshada D on 04 June 2005 Jubilant Issue Id 19220
                ''If CheckCustomFieldAccess(Request.Form.GetKey(inti)) Then
                'end of Addition by Harshada D on 04 June 2005 Jubilant Issue Id 18796
                ' Get the field name.
                strFieldList = strFieldList + ", " + Request.Form.GetKey(inti)

                ' Get the field value.
                If MyBase.GetFormValue(Request.Form.GetKey(inti)) = "" Then
                    ' If the field value is blank, then insert NULL.
                    strValueList += ", NULL"

                    ' If the field is any of the following, then their corporate values must be stored as well.

                    'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                    'Code Added By PradipK for Complexity
                    ''If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                    ''    strFieldList = strFieldList + ", Corporate" + Request.Form.GetKey(inti)
                    ''    strValueList = strValueList + ", N'" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                    ''    'MODIFIED BY CHRISTINA T ON 27/06/2006
                    ''End If
                Else
                    ' If the field data-type is either integer/boolean/double, then...
                    If objSchema.DataType.Trim.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.Trim.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.Trim.ToUpper = "SYSTEM.DOUBLE" Then
                        'Set value for ShowToCustomer
                        'Code Commented By DipaliS 19 July 2004 to resolve issue 11990 and added the following
                        'Added the check..if it is the check box for Show To Customer , then only append 1
                        'else append the form value
                        'If m_blnShowToCustomer Then
                        ''If m_blnShowToCustomer And Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" Then
                        ''    'End Addition by DipaliS
                        ''    strValueList = strValueList + ", 1"
                        ''Else
                        'Added by PrachiK on 17 Mar  2005 for IssueID 16918
                        'Purpose:Issue Entry Page crashes while assigning task to responsible person if EmployeeID  is greater than 1000
                        'strValueList = strValueList + ", " + FormatNumber(MyBase.GetFormValue(Request.Form.GetKey(inti)))
                        strValueList = strValueList + ", " + (MyBase.GetFormValue(Request.Form.GetKey(inti)))
                        'Addtion ended
                        ''End If
                    Else 'For other data types
                        If InStr(Request.Form.GetKey(inti).Trim, "CustomFieldCombo") <> 0 Then
                            strValueList = strValueList + ", N'" + Left(MyBase.GetFormValue(Request.Form.GetKey(inti)), CType(objSchema.ColumnSize, Integer)) + "'"
                        Else
                            strValueList = strValueList + ", N'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                            'MODIFIED BY CHRISTINA T ON 27/06/2006
                        End If

                        ' If the field is any of the following, then their corporate values must be stored as well.

                        '''Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                        '''Code Added By PradipK for Complexity
                        ''If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                        ''    strFieldList = strFieldList + ", Corporate" + Request.Form.GetKey(inti)
                        ''    strValueList = strValueList + ", N'" & GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) & "'"
                        ''End If
                    End If
                End If
                ''End If
                ''End If
                ''End If
                objSchema = Nothing
            Next

            ''' If the ShowToCustomer control was not displayed, then
            ''If m_blnShowToCustomer = False Then
            ''    strFieldList = strFieldList + ", ShowToCustomer"
            ''    ' If the customer has logged in, then by default this value must be set to True.
            ''    If m_LoginType = "C" Then
            ''        strValueList = strValueList + ", 1"
            ''    Else
            ''        strValueList = strValueList + ", 0"
            ''    End If
            ''End If

            'generate database query to be executed, from fields list and values list
            strDatabaseQuery = strDatabaseQuery + "( " + strFieldList + " ) VALUES ( " + strValueList + " )"

            'append for getting Issue Id of newly created Issue
            'strDatabaseQuery += "; Select SCOPE_IDENTITY()"

            'Get newly added IssueId by executing the query.
            CommonFunction.Data.GetDataScalar(strDatabaseQuery, MyBase.UseSQL)

            '------------------------------------------------------------------------------------
            'Added by AniruddhaD on 16 Nov 2005 for having common page for issue entry through issue and review (IssueID: 683)
            'Update review actions table with new IssueID
            ''CommonFunction.Data.InsertOrUpdateData("usp_upd_tbl_PM_ReviewActions_IssueID " + intReviewActionID.ToString + "," + IssueId.ToString, MyBase.UseSQL)

            '''Checking if this page is called from Add issue or Save as Issue Link.    
            ''If blnCalledFromReview = True Then
            ''    If strIssueAddedFrom = "FTR" Then
            ''        'Refresh parent 
            ''        strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=2191&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
            ''    ElseIf strIssueAddedFrom = "Reviews" Then

            ''        'Refresh parent 
            ''        strOnloadClientScript = strOnloadClientScript + vbCrLf + "		refreshParent('frmCommonPage','CommonPage.aspx','../general/CommonPage.aspx?MasterTagID=1026&FromWhere=PM&FromCL=1&FocusOn=SUBTAG&ReviewStatisticsID_PK=" + intReviewStatisticsID.ToString + "');"
            ''    End If
            ''End If
            '''end addition by AniruddhaD on 16 Nov 2005 for having common page for issue entru through issue and review
            '------------------------------------------------------------------------------------

            'Send mail - New Issue posted
            'Integrated by SandipL SP8 to SP9
            ''Call FreshParent()
            'End Integration by SandipL SP8 to SP9
            ''Call SendMail(8, IssueId)

            'Reset IssueID - To get details of new Issue and refresh the page after saving.
            'm_lngIssueId = IssueId



            'Call GenerateIssueCode(m_lngIssueId)

        Else 'Update existing extended Issue custom fields

            Dim drProject, drDummy As IDataReader, strSQLQuery As String

            '''Determine if History of the project is enabled.
            ''drProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Project " + m_ProjectId.ToString, MyBase.UseSQL)
            ''If drProject.Read Then
            ''    If CType(drProject("IBHistoryOn"), Boolean) = True Then
            ''        ' If the Description field has changed, then log the changes in the History table.			

            ''        ' Modified By NitinVS on 18 Oct 2005 for WhizibleSEM SP4 IssueID 502 
            ''        ' Added Checkisnothing 
            ''        If StrComp(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtOldDescription"), "").Trim, CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("Description"), "")) <> 0 Then
            ''            ' End Modification By NitinVS on 18 Oct 2005 for WhizibleSEM SP4 IssueID 502 

            ''            strSQLQuery = "Exec usp_Ins_tbl_IB_History_InsertTextFields " + m_lngIssueId.ToString + ", 'Description', N'" + CommonFunction.General.BuildQueryString(m_UserName) + "', N'" + MyBase.GetFormValue("txtOldDescription") + "', N'" + MyBase.GetFormValue("Description") + "'"
            ''            'MODIFIED BY CHRISTINA T ON 26/07/2006
            ''            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
            ''        End If
            ''    End If
            ''End If
            ''CommonFunction.Data.DisposeDataReader(drProject)

            ' Generate the Update Query.
            strDatabaseQuery = strDatabaseQuery & "UPDATE tbl_IB_Issue_ExtendedCustomFields SET ModifiedBy = N'" & CommonFunction.General.BuildQueryString(m_UserName) & "'"
            strDatabaseQuery = strDatabaseQuery & ", ModifiedDate = '" + Now.Today.ToString + "'"
            'MODIFIED BY CHRISTINA T ON 27/06/2006

            Dim drStatus, drEmailMessage As IDataReader
            Dim inti As Integer
            ''If Not MyBase.GetFormValue("txtWorkInHours") Is Nothing Then
            'No hash table to be created as no data present in sql for txtWorkInHours (Appended last in form conditionally)
            intUpperBound = Request.Form.AllKeys.Length - 1
            ''Else
            ''    intUpperBound = Request.Form.AllKeys.Length
            ''End If

            'Omit first 6 controls on the form as they are static and no hash table can be created for them.

            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
            'Code Added By PradipK on 17 Feb 2006
            'Value of initi is changed from 7 to 11 as CurrentDate & CurrentTime is plotted as hidden.
            'For inti = 7 To intUpperBound

            'Modified by SantoshK on Date June 6, 2006 for WhizibleSEM Issue ID.4168
            'Purpose : Firefox Support
            Dim iCounter As Integer = 1
            ''If InStr(CType(Request.ServerVariables("HTTP_USER_AGENT"), String), "MSIE") > 0 Then
            ''    iCounter = 14
            ''Else
            ''    iCounter = 12
            ''End If
            'Modification Ends by SantoshK on June 6, 2006

            For inti = iCounter To intUpperBound

                'Code For ignoring dummy date control added by SandipL on 3 Dec 2005 --IssueID 672 
                'Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                'If Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                If Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                    inti += 1
                    'exit loop if counter excceds upper bound
                    If inti > intUpperBound Then Exit For
                End If

                '''Added by SavitaS on 26 Sept for SP7 IssueID 4887
                ''If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" And m_LoginType = "C" Then
                ''    'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                ''    inti += 1
                ''    'Exit loop if counter exceeds upperbound
                ''    If inti > intUpperBound Then
                ''        Exit For
                ''    End If
                ''    'Added by SavitaS on 27 Sept 2006 for SP7 IssueID 4887
                ''    'If Show to Customer checkbox is checked and save the issue Page crashes
                ''    If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                ''        'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                ''        inti += 1
                ''        'exit loop if counter excceds upper bound
                ''        If inti > intUpperBound Then
                ''            Exit For
                ''        End If
                ''    End If
                ''    'End Addition by SavitaS on 27 Sept 2006 
                ''End If
                '''End of Added by SavitaS on 26 Sept for SP7 IssueID 4887
                ''' Added By Nikhil A on 02-december-2015 for page crash on Extended custome field link
                If Request.Form.GetKey(inti) = "__VIEWSTATEGENERATOR" Or Request.Form.GetKey(inti) = "__VIEWSTATEENCRYPTED" Then
                    Continue For
                End If
                ''' Added By Nikhil A on 02-december-2015 for page crash on Extended custome field link
                'Generate schema for the control, containing details about, like fieldname, datatype, size etc.
                Dim objSchema As New CommonFunction.Data.Schema
                objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)

                ''If Request.Form.GetKey(inti) = "AssignTo" Then
                ''    m_blnAssignToChanged = True
                ''End If

                '''Check whether status of current Issue has been changed
                ''If Request.Form.GetKey(inti) = "Status" Then
                ''    If MyBase.GetFormValue("txtOldStatus") <> MyBase.GetFormValue(Request.Form.GetKey(inti)) Then
                ''        strSQLQuery = "SELECT * FROM tbl_IB_Project_Type_Status WHERE ProjectID = " + m_ProjectId.ToString + " AND Type = N'" + MyBase.GetFormValue("Type") + "' "
                ''        'MODIFIED BY CHRISTINA T ON 27/06/2006
                ''        'modified by SnehalV for For SP7 BFT Issues Integration on 3rd Oct 2006
                ''        'Commented And Modified By JyotiG
                ''        'SearchKey : JG_7198_26-Oct-2006
                ''        'Start
                ''        'strSQLQuery = strSQLQuery + "AND Status = '" + CommonFunctions.General.BuildQueryString(MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                ''        strSQLQuery = strSQLQuery + "AND Status = N'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                ''        'MODIFIED BY CHRISTINA T ON 27/06/2006
                ''        'End Of Modication By JyotiG
                ''        'end of modification
                ''        drStatus = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
                ''        If drStatus.Read Then
                ''            'Send mail if mail has to be changed and status has been changed
                ''            If CType(drStatus("SendMail"), Boolean) = True Then
                ''                'Integrated by SandipL SP8 to SP9
                ''                Call FreshParent()
                ''                'End Integration by SandipL SP8 to SP9
                ''                Call SendMail(34, m_lngIssueId) 'Issue status changed
                ''            End If
                ''        End If
                ''        CommonFunction.Data.DisposeDataReader(drStatus)
                ''    End If
                ''End If

                'omit IssueId from query, as it is identity key in the table. 
                ''If Request.Form.GetKey(inti) <> "IssueID" And Request.Form.GetKey(inti) <> "cboIssue" Then

                ''If Request.Form.GetKey(inti).ToUpper = "SHOWTOCUSTOMER" Then
                ''    m_blnShowToCustomer = True
                ''    inti += 1
                ''    'exit loop if counter excceds upper bound
                ''    If inti > intUpperBound Then
                ''        Exit For
                ''    Else
                ''        'Modified by SavitaS on 27 Sept 2006 for SP7 IssueID 4887
                ''        'If Show to Customer checkbox is checked and save the issue Page crash
                ''        If Request.Form.GetKey(inti).ToUpper = "TXTPKTOKEN" Or Request.Form.GetKey(inti).ToUpper = "PRIORITYFIXINDAYS" Or Request.Form.GetKey(inti).ToUpper = "TXTOLDASSIGNTO" Or Request.Form.GetKey(inti).ToUpper = "TXTWORKINHOURS" Or Request.Form.GetKey(inti).ToUpper = "CHKDELETE" Or Request.Form.GetKey(inti).ToUpper.StartsWith("FFE29587WHIZ_") Then
                ''            'End of Commented and Added by SavitaS on 25 Sept 2006  for Security Issue 6197 
                ''            inti += 1
                ''            'exit loop if counter excceds upper bound
                ''            If inti > intUpperBound Then
                ''                Exit For
                ''            End If
                ''        End If
                ''        objSchema = Nothing
                ''        objSchema = CType(ht(Request.Form.GetKey(inti)), CommonFunction.Data.Schema)
                ''    End If
                ''End If

                'End of Commented and Modified by SavitaS on 27 Sept 2006

                ' Check if the name of the form item, is a valid field in the Issue table. If yes, then proceed.
                ''If IsValidField(drIssueFields, Request.Form.GetKey(inti)) Then
                'Added by Harshada D on 04 June 2005 Jubilant Issue Id 19220
                ''If CheckCustomFieldAccess(Request.Form.GetKey(inti)) Then
                'end of Addition by Harshada D on 04 June 2005 Jubilant Issue Id 18796
                ' Get the field name.
                strDatabaseQuery = strDatabaseQuery + ", " + Request.Form.GetKey(inti) + " = "

                ' If the field value is blank, then insert NULL.
                If Not MyBase.GetFormValue(Request.Form.GetKey(inti)) Is Nothing Then
                    If MyBase.GetFormValue(Request.Form.GetKey(inti)) = "" Then
                        strDatabaseQuery = strDatabaseQuery & "NULL"
                    Else
                        ' If the field data-type is either integer/boolean/double, then...

                        If objSchema.DataType.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.ToUpper = "SYSTEM.DOUBLE" Then
                            'Added by PrachiK on 17 Mar  2005 for IssueID 16918
                            'Purpose:Issue Entry Page crashes while assigning task to responsible person if EmployeeID  is greater than 1000

                            'strDatabaseQuery = strDatabaseQuery + FormatNumber(MyBase.GetFormValue(Request.Form.GetKey(inti)))
                            strDatabaseQuery = strDatabaseQuery + MyBase.GetFormValue(Request.Form.GetKey(inti))
                            'Addtion Ended
                        Else

                            ''    'For other data types
                            ''    strDatabaseQuery = strDatabaseQuery + "N'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                            ''    'MODIFIED BY CHRISTINA T ON 27/06/2006

                            If InStr(Request.Form.GetKey(inti), "CustomFieldCombo") <> 0 Then
                                strDatabaseQuery = strDatabaseQuery + "N'" + Left(MyBase.GetFormValue(Request.Form.GetKey(inti)), CType(objSchema.ColumnSize, Integer)) + "'"
                            Else

                                strDatabaseQuery = strDatabaseQuery & "N'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"

                                'MODIFIED BY CHRISTINA T ON 27/06/2006
                            End If
                        End If
                    End If
                Else
                    strDatabaseQuery = strDatabaseQuery & "NULL"
                End If

                ' If the field is any of the following, then their corporate values must be stored as well.

                'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                'Code Added By PradipK To Save Complexity
                'Code Commented By PradipK
                'If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Then
                'Code Added By PradipK on 15 Feb 2006
                ''If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                ''    strDatabaseQuery = strDatabaseQuery + ", Corporate" + Request.Form.GetKey(inti) + " = N'" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                ''    'MODIFIED BY CHRISTINA T ON 27/06/2006
                ''End If
                ''End If
                ''Else
                ' If the field data-type is either integer/bit, then...
                ''If objSchema.DataType.ToUpper = "SYSTEM.INT32" Or objSchema.DataType.ToUpper = "SYSTEM.BOOLEAN" Or objSchema.DataType.ToUpper = "SYSTEM.DOUBLE" Then
                ''    strDatabaseQuery = strDatabaseQuery + FormatNumber(MyBase.GetFormValue(Request.Form.GetKey(inti)))
                ''    ' Else, ...
                ''Else
                ''    If InStr(Request.Form.GetKey(inti), "CustomFieldCombo") <> 0 Then
                ''        strDatabaseQuery = strDatabaseQuery + "N'" + Left(MyBase.GetFormValue(Request.Form.GetKey(inti)), CType(objSchema.ColumnSize, Integer)) + "'"
                ''    Else
                ''        strDatabaseQuery = strDatabaseQuery & "N'" + MyBase.GetFormValue(Request.Form.GetKey(inti)) + "'"
                ''        'MODIFIED BY CHRISTINA T ON 27/06/2006
                ''    End If
                ''End If
                ' If the field is any of the following, then their corporate values must be stored as well.

                'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                'Code Added By PradipK To Save Complexity
                ' If the field is any of the following, then their corporate values must be stored as well.
                ''If Request.Form.GetKey(inti) = "Type" Or Request.Form.GetKey(inti) = "SubType" Or Request.Form.GetKey(inti) = "Status" Or Request.Form.GetKey(inti) = "Priority" Or Request.Form.GetKey(inti) = "Severity" Or Request.Form.GetKey(inti) = "Complexity" Then
                ''    strDatabaseQuery = strDatabaseQuery + ", Corporate" + Request.Form.GetKey(inti) + " = N'" + GetCorporateValue(Request.Form.GetKey(inti), MyBase.GetFormValue(Request.Form.GetKey(inti))) + "'"
                ''End If
                ''End If
                ''End If
                ''End If

                'Dispose the object schema
                objSchema = Nothing


            Next

            'Dispose hash table
            ht = Nothing



            ''' If the ShowToCustomer control was not displayed, then...
            ''strDatabaseQuery = strDatabaseQuery + ", ShowToCustomer = "


            'Intigrated by HarshK on 02/09/2005 for sp4 isueid 155 If the ShowToCustomer Control is not in the layout
            '**************************************************************************
            'Addition by Harshada D for Navionics issue 18636 
            'For issue id 18301 ShowToCustomer becomes 0 If the ShowToCustomer Control is not in the layout
            'Code Added by AmolG on 17th May 2005 

            ''Dim drLayout As IDataReader
            ''Dim intLayoutID As Integer
            ''' Get the layout ID to be applied. since we want the Layout for the Type which is in the combobox selected.
            ''drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_GetIssueLayoutToBeApplied " + m_ProjectId.ToString + ", " + m_RoleId.ToString + ", N'" + CommonFunctions.General.BuildQueryString(Request.Form("Type")) + "'", MyBase.UseSQL)
            '''modified by Christina T ON 25/07/2006

            ''If drLayout.Read Then
            ''    ' Get the layout ID.
            ''    intLayoutID = CType(drLayout("LayoutID"), Integer)
            ''End If
            ''CommonFunction.Data.DisposeDataReader(drLayout)

            '''Checking if ShowToCustomer is displayed in the layout or not
            ''strSQLQuery = "SELECT Count(*) as ShowToCustomerInLayout From tbl_IB_IssueEntry_Layout_Details where layoutid = " + intLayoutID.ToString + " AND UNIQUEID = 34 AND Active = 1"
            '''Added by PrashantD on 12 April 2007 for IssueID 11365
            ''strSQLQuery += " AND ShowInEditMode = 1"
            '''End of addition by PrashantD on 12 April 2007
            ''Dim intShowToCustomerInLayout As Integer = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)), Integer)

            ''If m_blnShowToCustomer = False Then
            ''    ' If the customer has logged in, then by default this value must be set to True.
            ''    'if condition (m_LoginType.ToUpper = "C") added on 22 april
            ''    If m_LoginType.ToUpper = "C" Then
            ''        strDatabaseQuery = strDatabaseQuery + "1"
            ''    Else
            ''        'For Issue Id 20699 ShowToCustomer becomes 0 If the ShowToCustomer Control is not in the layout
            ''        'Code Added by PradeepD on 19th Aug 2005 
            ''        If intShowToCustomerInLayout = 0 Then
            ''            Dim intShowToCustomer As Integer
            ''            strSQLQuery = "SELECT CAST( ShowToCustomer as integer) as ShowToCustomer FROM tbl_IB_Issue WHERE IssueID =  " + m_lngIssueId.ToString
            ''            intShowToCustomer = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLQuery, MyBase.UseSQL)), Integer)
            ''            strDatabaseQuery = strDatabaseQuery + intShowToCustomer.ToString
            ''        ElseIf intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") Is Nothing Then

            ''            '' START : Added By ParagD On 5-Sept-2006    
            ''            If m_strblnShowToCustomer = "1" Then
            ''                strDatabaseQuery = strDatabaseQuery + "1"
            ''            Else
            ''                strDatabaseQuery = strDatabaseQuery + "0"
            ''            End If
            ''            '' END : ParagD On 5-Sept-2006
            ''        ElseIf intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") = "1" Then
            ''            strDatabaseQuery = strDatabaseQuery + "1"
            ''        End If

            ''        '' START : Commented By ParagD On 5-Sept-2006
            ''        '' Purpose : Code is not in use.
            ''        'Integrated by AmitJ on 16 Aug 2006 for  whizible SP 7.2 IssueID 2002
            ''        'Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
            ''        'Added by ShubhadaL on 23 Feb 2006 for FourSoft - 927
            ''        ' ShowToCustomer Checkbox goes blank when parent gets refreshed from DiscussionThread_Save click

            ''        ''intIsCustomerChecked = CommonFunction.General.CheckIsNothing(Request.QueryString("IsCustomerChecked"), "0")
            ''        ''If intIsCustomerChecked <> "0" Then
            ''        ''    strDatabaseQuery = strDatabaseQuery + "1"
            ''        ''Else
            ''        ''    strDatabaseQuery = strDatabaseQuery + "0"
            ''        ''End If
            ''        'End of addition by ShubhadaL on 23 Feb 2006 for FourSoft - 927
            ''        'End Integration by SavitaS
            ''        'End Integration by AmitJ

            ''        '' END : Commented By ParagD On 5-Sept-2006

            ''    End If
            ''Else
            ''    If m_LoginType.ToUpper = "C" Then
            ''        strDatabaseQuery = strDatabaseQuery + "1"
            ''    Else
            ''        If intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") Is Nothing Then
            ''            '' START : ParagD On 5-Sept-2006    
            ''            If m_strblnShowToCustomer = "1" Then
            ''                strDatabaseQuery = strDatabaseQuery + "1"
            ''            Else
            ''                strDatabaseQuery = strDatabaseQuery + "0"
            ''            End If
            ''            '' END : ParagD On 5-Sept-2006

            ''        ElseIf intShowToCustomerInLayout = 1 And Request.Form("ShowToCustomer") = "0" Then
            ''            strDatabaseQuery = strDatabaseQuery + "1"
            ''        ElseIf Request.Form("ShowToCustomer") = "1" Then
            ''            strDatabaseQuery = strDatabaseQuery + "1"
            ''        End If
            ''    End If
            ''    'strDatabaseQuery = strDatabaseQuery + "1"
            ''End If
            '''End Addition  For Issue Id  20699 ShowToCustomer becomes 0 If the ShowToCustomer Control is not in the layout
            '''END : Code Added by PradeepD on 19th Aug 2005 
            '''**************************************************************************
            '''END Intigration by HarshK on 02/09/2005 for sp4 isueid 155
            '''Add IssueId in where condition (update selected issue)


            strDatabaseQuery = strDatabaseQuery + " WHERE IssueID = " + m_lngIssueId.ToString

            ' Execute the update query.	
            CommonFunction.Data.InsertOrUpdateData(strDatabaseQuery, MyBase.UseSQL)

            'Generate Issue Code
            'Call GenerateIssueCode(m_lngIssueId)
        End If

        '''Determine if responsible person is changed
        ''If m_blnAssignToChanged = True Then
        ''    If MyBase.GetFormValue("txtOldAssignTo").Trim.ToUpper <> MyBase.GetFormValue("AssignTo").Trim.ToUpper Then
        ''        If MyBase.GetFormValue("AssignTo") <> "" Then

        ''            'Assign Issue to responsible person, if project has this setting
        ''            If m_blnAssignIssueToResponsiblePerson = True Then
        ''                Call AssignIssueToEmployee(m_lngIssueId, MyBase.GetFormValue("txtOldAssignTo").ToString.Trim, MyBase.GetFormValue("AssignTo").ToString.Trim)
        ''            End If

        ''            'Send mail to responsible person, if project has this setting
        ''            If m_blnSendResponsiblePersonMail = True Then
        ''                'Integrated by SandipL SP8 to SP9
        ''                Call FreshParent()
        ''                'End Integration by SandipL SP8 to SP9
        ''                Call SendMail(41, m_lngIssueId) 'Assigned as responsible person
        ''            End If
        ''        End If
        ''    End If
        ''End If

        '''Modified by SavitaS on 25 Sept 2006 for Whiziblesem SP7 Issue ID.6197
        ''If (m_strAction = "Save") And (m_strToken = "") And (m_lngIssueId > 0) Then
        ''    m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngIssueId, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String))
        ''End If
        '''End Modification

        '''Integrated by SandipL SP8 to SP9
        '''Added by SrikanthY on 26 Dec 2006 To refresh parent Helpdeskpage on saving issue
        ''If m_FromWhere = "HDB" Then
        ''    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.close();"
        ''    If m_Count = 0 Then
        ''        Call FreshParent()
        ''    End If
        ''End If
        '''End of Addition by SrikanthY
        '''End Integration by SandipL SP8 to SP9
    End Sub 'Save / Update / Import Issue

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
