'Added by AMIT MAHADIK on 21 Mar 2011 Purpose:To display the text properly for disussion thread.
Imports System.Web.HttpUtility
'end Added by AMIT MAHADIK on 21 Mar 2011 Purpose:To display the text properly for disussion thread.
Public Class CRM_RequestDetail
    Inherits WebPages.Template.WhizTemplate
    Private m_blnValidate As Boolean = True
    Protected m_strAction As String = ""
    Protected m_strMode As String = ""
    Protected m_strFromWhere As String = "SR" ' | SR | DB | AR
    Protected m_lngQueryID As Long
    Protected m_lngSubRequestTypeID As Long
    Protected m_dtmServerDate As Date
    ''Added by Amit Mahadik on 23 Mar 2011 Encore
    Protected m_strApprover As String = "0" '"1/0"
    ''end Added by Amit Mahadik on 23 Mar 2011 Encore
    Protected m_intShow As Integer = 1  'Added by Anju on 29 April 09
    Protected m_blnSLAAccess As Boolean 'Added by Anju on 29 April 09
    Protected Const TAB_REQUEST_DETAILS = 1
    Protected Const TAB_ATTACHMENT = 2
    Protected Const TAB_DISCUSSION_THREAD = 3
    Protected Const TAB_SLA = 4
    Protected Const TAB_ACTIVITY_LOG = 5

    Protected m_strSubject_Caption As String = "Subject"
    Protected m_strDescription_Caption As String = "Description"
    Protected m_strAssignTo_Caption As String = "Assign To"
    Protected m_strPriority_Caption As String = "Priority"
    Protected m_strExpectedResolvedDate_Caption As String = "Exp. Resolved Date"
    'Modified by PrashantD on 24 May 2007 for CleanUp Activity
    'Protected m_strCRMExpectedResolvedDate_Caption As String = "CRM's Exp. Resolved Date"
    Protected m_strCRMExpectedResolvedDate_Caption As String = "HRM's Exp. Resolved Date"
    'End of modification by PrashantD on 24 May 2007 for CleanUp Activity
    Protected m_strStatus_Caption As String = "Status"
    Protected m_strSubRequestType_Caption As String = "Sub Request Type"
    'Modified  by PrachiK on 9 Mar  2005 for IssueID 16727
    'Purpose:In Help Desk - combo's with caption Location and Target Location  are displayed
    Protected m_strTargetLocation_Caption As String = "Organization Unit"
    'Modification ended
    Protected m_strFunction_Caption As String = "Department"
    Protected m_strComments_Caption As String = "Comments"
    Protected m_strReasonsForRejection_Caption As String = "Reasons For Rejection"
    Protected m_intShowMandatoryAttachmentMsg As Integer = 0
    Protected m_strShowSubRequest As String = "False"
    Private m_lngEmployeeID As Long
    Protected m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Private m_blnAllowAttachmentDeletion As Boolean = True
    Private m_intDiscussionThreadCount As Integer = 0
    'added by harshada d on 03 feb 2006 for helpdesk enhancements
    Private m_lngRequestTypeId As Long
    Protected intIsTask_IssueCreated As Integer = 0
    Protected intIsAssignTo As Integer = 0
    'end of additiion by harshada d on 03 feb 2006    
    'Added by PrashantD on 24 May 2007 for CleanUp Activity
    Private m_strSubmittedDate As String
    'End of addition by PrashantD on 24 May 2007

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu

    ' Modified BY NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 
    Private m_lngStatusId As Integer
    ' End Modification BY NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 

    'Modified by PrajaktaR on 17th Feb 2007 for WhizibleSEM SP9 IssueID - 10295 to Disable all fields if the Status is closed 
    Protected intRequestStatus As Integer
    'END OF Modification by by PrajaktaR on 17th Feb 2007 for WhizibleSEM SP9 IssueID - 10295 to Disable all fields if the Status is closed 

    'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    'Added by SavitaS on 21 Nov  2005 for IssueID 1936
    Dim m_lngCRMID As Long
    'End Addition on 21 nov 2005
    'added by harshada d on 30 Nov 2005
    Protected m_intCustomer As Integer = 0
    'end of addition by harshada d
    'Adde by SavitaS on 01 Dec 2005 for IssueID 1936
    Protected m_strVal As String = ""
    Protected m_count As Integer = 0
    Protected WithEvents frmRequestDetails As System.Web.UI.HtmlControls.HtmlForm
    ''End of Added by SavitaS on 19th Dec 2005 
    'End Integration by SavitaS
    ''Added by Manishk On 11th jan 06 to add deliverable textbox on helpdesk page
    Protected m_strDeliverableID As String
    Protected lngFunctionID As Long = 0
    Protected blnViewAccessOrHRM As Integer = 0
    Protected dtmSubmittedDate As Date
    Protected strSubrequestType As String = ""
    ''End of Added by Manishk On 11th jan 06 to add deliverable textbox on helpdesk page
    'Added by ShraddhaM to display Deliverable Project name
    Protected m_strDelProjectID As String = ""
    Protected strDelProjectName As String = ""
    'Ended by ShraddhaM 
    'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
    'Code Added By PradipK for Help Desk SLA 
    'Added by Shraddha on 8th March 06 - SLA For HelpDesk

    Protected m_strStatusChangeDate As String = "Status Change Date"
    Protected m_strStatusChangeTime As String = "Status Change Time"

    Protected OldStatusChangeDate As String
    Protected OldStatusChangeTime As String

    Protected objStatusTime As String
    Protected objStatusDate As String
    Protected objCurrentDate As String
    Protected objCurrentTime As String
    Protected objOldStatus As String
    Protected objNewStatus As String

    'Code Commented by PrashantD on 19 Jun 2007 for CleanUp Activity
    'Protected strDate As String
    'Protected strTime As String
    'End of comment by PrashantD on 19 Jun 2007 for CleanUp Activity
    'Code Added by PrashantD on 19 Jun 2007 for CleanUp Activity
    Private m_strStatusChangeDateValue As String
    Private m_strStatusChangeTimeValue As String
    'End of addition by PrashantD on 19 Jun 2007 for CleanUp Activity

    'Dim drHelpDeskDetails As IDataReader



    'End of added by Shraddha on 8th March 06 - SLA For HelpDesk
    'End Addition By PradipK for Help Desk SLA 
    'End Integration

    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_PKToken_FromRequestDetail As String
    '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197

    Protected strFilter As String
    Protected strDept As String
    Protected strStatus As String

    'Added by PrashantSJ on 08 Nov 2006 for WhizibleSEM SP8 Build 1
    'Purpose: For storing Request Subject (which is passed to Flag tracker)
    Protected m_strSubject As String = ""
    'End of addition by PrashantSJ on 08 Nov 2006
    'Added by SrikanthY on 28 Dec 2006
    Protected m_lngLoginID As Long
    Protected m_strLoginName As String
    Protected m_blnIsClient As Boolean = False
    'Added by SrikanthY on 29 Dec 2006
    Protected m_intRequestedEmployee As Integer = 0
    Protected m_strRequestedEmployee As String = ""
    Protected m_strRequestedEmployeeUN As String = ""
    Protected m_intRequestedEmployeePost As Integer = 0
    Protected m_ChangedProduct As Integer = 0
    Protected m_ChangedModule As Integer = 0
    Protected m_ChangedProject As Integer = 0
    Protected m_ChangedLocation As Integer = 0
    Protected blnIsHRM As Integer = 0
    Protected m_FromList As Integer = 0
    Protected m_FilterData As Integer = 0
    Protected m_Filter As String = ""
    Protected m_Department As String = ""
    Protected m_Status As String = ""
    Protected m_RequeststrLoginType As String = "E"
    Protected m_strClienName As String

    Protected lngProductID As Long = -1
    Protected lngComponentID As Long = 0
    Dim strRequestorID As String = ""


    ' Added By NitinVS on 19 FEb 2007 for ISsue Id 10366
    Protected m_strSeverity_Caption As String = "Severity"
    'End Addition  By NitinVS on 19 FEb 2007 for ISsue Id 10366
    'Added By ShraddhaM on 13,July 2007 for CleanUp Activity
    Protected intAssignTo As Integer
    'End of Addition By ShraddhaM on 13,July 2007 for CleanUp Activity
    'Added By ShraddhaM on 13,July 2007 for CleanUp Activity
    Dim strAssignTo As String
    'End of Addition By ShraddhaM on 13,July 2007 for CleanUp Activity
    'Added by SonalD on 16th sept 2008

    Private strReportingTo As String
    Private strAprovalStatus As String

    'End of addition
    'Added by GaneshD on 09 Jun 2009 For Helpdesk Statusflow configuration
    Protected m_StatusFlowCount As Integer
    ' Addition end by GaneshD

    'Added by Amol Changle for Custom Field Functionality on 21 Jul 2009
    Protected strDefaultScript As String 'Script to store values of custom fields from another Controls
    Protected strClientSideScript As String 'Validation script for custom fields
    Protected declarevariables As String = "" 'Custom Fields objects Declaration script
    Private m_strCurrentType As String = ""
    Protected m_blnShowDefaults As Boolean = False 'Show defaults in add new mode only? 
    Protected m_strCustomFieldList As String = ""
    Protected m_strEnableControlScript As String = ""
    Private UserIDForCustomFields As Integer = 0
    Private m_strLoginTypeForCustomField As String = ""
    'End addition by Amol Changle on 21 Jul 2009

    Private m_IsOnbehalfCUST As Boolean = False
    Private m_IsOnbehalfEMP As Boolean = False
    Private m_IsOnbehalfSELF As Boolean = True
    'Added By AratiS on 23-Nov-09 For RequestID-23908
    Protected m_strProduct_Caption As String = "Product"
    Protected m_strModuleComponent_Caption As String = "Module/Component"
    Protected m_strSubmittedBy_Caption As String = "Requestor"
    Protected m_strCustomerID_Caption As String = "Submitted By"
    Protected m_strFeedBack_Caption As String = "Feedback"
    Protected m_strEscalationPeriod_Caption As String = "Escalation Period"
    Protected m_strParameterName_Caption As String = "ParameterName/FeedBack"
    Protected m_strRating_Caption As String = "Feedback Rating"
    Protected m_strSubmittedDate_Caption As String = "Requested On"
    Protected m_strClosedDate_Caption As String = "Closed Date"
    Protected m_strFeedbackComments_Caption As String = "Feedback Comments"
    Protected m_strRequestType_Caption As String = "Request Type"
    Protected m_strQueryID_Caption As String = "Request ID"
    'End:Added By AratiS on 23-Nov-09 For RequestID-23908
    ''Added by AMIT MAHADIK on 21 Mar 2011
    Private m_strSubmittedBy As String = ""
    Private m_strRowCount As Boolean = False
    Private m_blnIsRecordInGrid As Boolean
    ''End Added by AMIT MAHADIK on 21 Mar 2011
    ''Added by AMIT MAHADIK on 28 Mar 2011,17 Mar 2011
    Private m_blnIsAllowDeleteAtDeptLevel As Boolean
    ''END Added by AMIT MAHADIK on 28 Mar 2011,17 Mar 2011
    ''added by Nilesh g on 1/3/2016 for token generation
    Protected m_strToken As String = ""
    ''end of added by Nilesh g on 1/3/2016 for token generation

    ''Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
    Protected m_PKToken_Status As String
    Protected m_PKToken_OnBehalfOf As String
    ''End of addition by Dhanashri S on 18 Aug 2016 
    ''Added by Yogesh Jalamkar on 30-MAy-2017 Purpose: Page Refresh issue
    Protected strRequestMode As String = ""
    ''End of addition by Yogesh Jalamkar 



#Region "ModifyRegionVariables"
    Dim arrMenu() As String
    Dim arrMenuToolTip() As String
    Dim arrCSFunction() As String

    'End of addition by PrashantSJ on 08 Nov 2006
    Dim intComboSize As Integer = 170 '170
    Dim intWidth As Integer = 830
    Dim intPixelSize As Integer = 60

    Dim strMenu, strLegend As String
    Dim arrLegend() As String = {"Mandatory"}
    'Commented And Added By Vaijat K ON 07/12/2015
    'Dim arrLegendImage() As String = {"<img src='../../../responsive/images/star.gif'>"}
    Dim arrLegendImage() As String = {"<img src='../../Images/star.gif'>"}
    Dim dr As IDataReader
    Dim strSQL As String
    Dim blnDisableStatusCombo As Boolean = False
    Dim blnDisableFunctionCombo As Boolean = False
    Dim blnDisableSubRequestTypeCombo As Boolean = False
    ' added by harshada d on 03 Feb 2006 for help desk enhancements
    Dim strSQLCustomerName As String
    Dim drCustomerName As IDataReader
    Dim strCustomerName As String
    'end of additon by harshada d
    Dim blnDisbaledSubjectTextBox As Boolean = False
    Dim blnDisabledAssignToCombo As Boolean = False
    Dim blnReadOnlyComments As Boolean = False
    Dim arr() As String
    Dim intTemplateCount As Integer
    Dim strStyle As String
    Dim strRequestType As String = ""
    Dim strGuidelinesColumnName As String = ""
    Dim intRequestTypeID As Long = 0
    Dim strSubject As String = ""
    Dim strDescription As String = ""
    Dim intPriorityID As Integer = 0
    Dim strExpectedResolvedDate As String = ""
    Dim strCRMExpectedResolvedDate As String = ""
    Dim lngAssignTo As Long = 0
    Dim lngTargetLocationID As Long = 0
    Dim intStatusID As Integer = 0
    Dim intFeedbackID As Integer = 0
    Dim strFeedbackComments As String = ""
    Dim strComments As String = ""
    Dim strReasonsForRejection As String = ""
    'To Display Request ID and Requestor in Edit Mode
    Dim lngRequestID As Long = 0
    Dim strRequestor As String = ""
    Dim strRequestorName As String = ""
    'Modified By NitinVS on 19 FEb 2007 for IssueID 10366
    ' Add Field for Severity 
    Dim intSeverityID As Integer = 0
    'End Addition  By NitinVS on 19 FEb 2007 for IssueID 10366
    'Added By NitinVS on 16 Mar 2007 for WhizibleSEM SP 8 Regression Issue 
    Dim lngRequestTypeIdOld As Long = 0
    ' End Addition By NitinVS on 16 Mar 2007 for WhizibleSEM SP 8 Regression Issue 

    'Addition Ends
    'Added by SrikanthY on 04 Jan 07 For Integrating Product , Components in Request Screen
    Dim blnDisableProductCombo As Boolean = False
    Dim blnDisableModuleCombo As Boolean = False
    Dim blnDisableProjectCombo As Boolean = False
    Dim ShowProductCombo As String
#End Region


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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)

        Call Initialize()
        'Added By Shamkant on 30/12/2015
        'If m_lngQueryID.ToString <> "0" Then
        '    If m_PKToken_FromRequestDetail = "" Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '    ElseIf (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

        '    End If
        'ElseIf m_lngQueryID.ToString = "0" Or CommonFunction.General.CheckIsNothing(m_lngQueryID.ToString, "") = "" Then
        '    If Not Request.QueryString("Customer") Is Nothing And Request.QueryString("Customer") <> "" Then
        '        If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("Customer"), String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail : Add Request", 0, 0, "Query ID", "0")
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    ElseIf Request.QueryString("Customer") Is Nothing And Request.QueryString("Customer") = "" Then
        '        If (CommonFunctions.Security.Token.ValidateToken("0" + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail) = False) Then
        '            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail : Add On Behalf Of Customer", 0, 0, "Query ID", "0")
        '            'Token is Invalid now redirect to the Invalid Access Page
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If
        '    End If
        'End If
        'End  Added And Commented By Sanyogeeta R on 12-Aug-2016
        Call PerformActions()

    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        ''COMMENTED AND ADDED BY NILESH G ON 24/10/2016 PURPOSE : SECURITY  
        '' MyBase.ApplySecurity(True, 1, , , True)
        ''Commented and Added By Chakshuta H on 7th-Nov-2016 Purpose::Security Purpose (SQL injection and XSS)
        'MyBase.ApplySecurity(True)
        MyBase.ApplySecurity(True, 2, True, True, True)
        ''End OF Commented and Added By Chakshuta H on 7th-Nov-2016 Purpose::Security Purpose (SQL injection and XSS)
        ''END OF COMMENTED AND ADDED BY NILESH G ON 24/10/2016 PURPOSE : SECURITY
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 21,2004
        ' Revisions             :
        '=====================================================================
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_lngQueryID = CType(Request.QueryString("QueryID"), Long)
        Else
            m_lngQueryID = 0
        End If

        If Request.QueryString("PKToken") = "" Then
            If (Request.Form("txtPkToken") <> "") Then
                m_PKToken_FromRequestDetail = Request.Form("txtPkToken").ToString
            End If
        Else
            m_PKToken_FromRequestDetail = Trim(Request.QueryString("PKToken") & "")
        End If

        ''Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
        If Trim(Request.QueryString("Status") & "") <> "" Then
            m_PKToken_Status = Trim(Request.QueryString("Status") & "")
        End If
        If Trim(Request.QueryString("OnBehalfOf") & "") <> "" Then
            m_PKToken_OnBehalfOf = Trim(Request.QueryString("OnBehalfOf") & "")
        End If
        ''Added by Nilesh g on 31/8/2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
        If Trim(Request.QueryString("Mode") & "") <> "" Then
            m_strMode = Trim(Request.QueryString("Mode") & "")
        End If
        If Trim(Request.QueryString("Mode") & "") <> "" Then
            strRequestMode = Trim(Request.QueryString("Mode") & "")
        End If



        ''End of addition by Dhanashri S on 18 Aug 2016 

        'Added And Commented By Sanyogeeta R on 12-Aug-2016
        ''Added by Dhanashri S on 18 Aug 2016 Purpose:Mastercard NxtGen Upgrade Issue Fixing
        If (m_PKToken_Status = "" And m_PKToken_OnBehalfOf <> "CUST" And m_PKToken_OnBehalfOf <> "EMP" And m_strMode <> "NEW") Then
            ''End of addition by Dhanashri S on 18 Aug 2016 
            If (m_PKToken_FromRequestDetail = "" And HttpContext.Current.Session("intUserID") <> 0) Then
                m_blnValidate = False
            ElseIf m_lngQueryID.ToString = "0" And Request.QueryString("Customer") = "" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("Customer"), String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail) = False) Then
                    m_blnValidate = False
                End If
            ElseIf m_lngQueryID.ToString <> "0" Then
                'If (m_PKToken_FromRequestDetail = "" And HttpContext.Current.Session("intUserID") <> 0) Then
                'm_PKToken_Query_DT = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("QueryID"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
                If (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromRequestDetail) = False) Then
                    m_blnValidate = False
                End If
                'End If
            End If
        End If

        If (m_blnValidate = False) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End Added And Commented By Sanyogeeta R on 12-Aug-2016

        If m_lngQueryID.ToString <> "0" Then
            'Added And Commented By Sanyogeeta R on 16-Aug-2016
            'If Trim(Request.QueryString("PKToken")) = "" Then
            '    m_PKToken_FromRequestDetail = Request.Form("txtPkToken").ToString
            'Else
            '    m_PKToken_FromRequestDetail = Trim(Request.QueryString("PKToken") & "")
            'End If

            '''End of Comment and Addition by Sanyogeeta R on 16-Aug-2016
        End If
        If m_lngQueryID.ToString = "0" Then
            If Trim(Request.QueryString("PKToken") & "") <> "" Then
                m_PKToken_FromRequestDetail = Trim(Request.QueryString("PKToken") & "")
            End If

            If Not Request.QueryString("Customer") Is Nothing And Request.QueryString("Customer") <> "" Then
                m_PKToken_FromRequestDetail = CommonFunctions.Security.Token.GetToken(CType(Request.QueryString("Customer"), String) + CType(m_lngEmployeeID, String) + "0" + "0")
            Else
                m_PKToken_FromRequestDetail = CommonFunctions.Security.Token.GetToken("0" + CType(m_lngEmployeeID, String) + "0" + "0")
            End If
        End If

        ' Action of the page
        If Request.QueryString("FromList") = "1" Then
            HttpContext.Current.Session.Remove("Customer")
            HttpContext.Current.Session.Remove("RequestedEmployee")
        End If

        strFilter = Request.QueryString("Filter")
        strDept = Request.QueryString("Dept")
        strStatus = Request.QueryString("Status")

        'Added by Anju on 29 April 09
        ' Get selected tab 

        If Not Request.QueryString("Show") Is Nothing Then
            m_intShow = CType(Request.QueryString("Show"), Integer)
        ElseIf Not Request.Form("txtShowTab") Is Nothing Then
            m_intShow = CType(Request.Form("txtShowTab"), Integer)
        Else
            If m_intShow = 0 Then
                m_intShow = 1 ' By default set request details tab 
            End If
        End If
        ' End of modification by Anju on 29 April 09

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        ' Mode is either EDIT or NEW
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString
        Else
            m_strMode = ""
        End If

        ' Page is called from My E-Dashboard or E-Dashboard or Submitted requests or Assigned Requests    
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        Else
            m_strFromWhere = ""
        End If

        ' Request ID

        ''Addeed by Amit Mahadik 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver
        If Not Request.QueryString("Approver") Is Nothing Then
            m_strApprover = CType(Request.QueryString("Approver"), String)
        Else
            m_strApprover = "0"
        End If
        ''Addeed by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver

        'Added by Amit Mahadik on 28 Mar 2011 
        ''Purpose:Whizible SEM 10.0 ,option added at department level to allow delete discusion threads or not...
        ''so checking here if that option is enabled? 

        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''Dim strIsAllowDeleteAtDeptLevel As String = "SELECT isshowtocustomer FROM tbl_PM_DepartmentMaster WHERE Departmentid IN (SELECT FunctionID FROM tbl_CRM_Query_Master WHERE QueryID = " & m_lngQueryID.ToString() & ")"
        Dim strIsAllowDeleteAtDeptLevel As String = "usp_sel_tbl_PM_DepartmentMaster_isshowtocustomer " & m_lngQueryID.ToString()
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If m_strMode <> "NEW" Then
            m_blnIsAllowDeleteAtDeptLevel = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strIsAllowDeleteAtDeptLevel.ToString(), True), ""), ""), Boolean)
        End If

        '''''select isshowtocustomer from tbl_PM_DepartmentMaster where Departmentid in (select FunctionID from tbl_CRM_Query_Master where QueryID = 362)
        'END Added by Amit Mahadik on 28 Mar 2011 

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngLoginID = CType(Session("intLOGINID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        ' We can add requests only from SR mode (Submitted Requests)
        If UCase(Trim(m_strMode & "")) = "NEW" Then
            m_strFromWhere = "SR"
        End If

        ' Check  corporate setting - whether to display request type and sub request type is separate drop down or concatenated
        ' If Request Type and Sub Request Types are to be displayed concatenated then do not display Sub Request Type drop down
        If CommonFunction.Application.SplitRequestTypeSubType = True Then
            m_strShowSubRequest = "True"
        Else
            m_strShowSubRequest = "False"
        End If

        ' Check whether Employee ID is passed through "On Behalf of" page
        If Not Request.QueryString("Employee") Is Nothing And Request.QueryString("Employee") <> "" Then
            m_intRequestedEmployee = CType(Request.QueryString("Employee"), Integer)
            ' If Employee ID passed through "On Behalf of" page is same as one in session then request is being posted by logged in person
            If m_intRequestedEmployee = CType(m_lngEmployeeID, Integer) Then
                m_intRequestedEmployee = 0
            Else
                ' Otherwise request is being posted on behalf of other employee.
                ' So set that Employee ID in another session variable
                HttpContext.Current.Session("RequestedEmployee") = m_intRequestedEmployee
            End If
        ElseIf Not HttpContext.Current.Session("RequestedEmployee") Is Nothing Then
            ' This part is required for post back to re-initialize employee ID who has posted the request
            m_intRequestedEmployee = CType(HttpContext.Current.Session("RequestedEmployee"), Integer)
        End If

        ' Once you know Employee ID - Get his name, Role and User Name
        Dim drEmployee As IDataReader
        If m_intRequestedEmployee <> 0 Then
            Dim StrEmployee As String
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'StrEmployee = "Select EmployeeName,PostID,UserName From tbl_pm_employee where employeeid = " & m_intRequestedEmployee
            StrEmployee = "usp_sel_tbl_pm_employee_EmployeeName_PostID_UserName " & m_intRequestedEmployee
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            drEmployee = CommonFunctions.Data.GetDataReader(StrEmployee, m_blnUseSQL)
            If drEmployee.Read Then
                m_strRequestedEmployee = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("EmployeeName"), ""), String)
                m_intRequestedEmployeePost = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("PostID"), "0"), Integer)
                m_strRequestedEmployeeUN = CType(CommonFunctions.Data.CheckIsDBNull(drEmployee("UserName"), ""), String)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmployee)

        ' Check whether Customer ID is passed through "On Behalf of" page
        If Not Request.QueryString("Customer") Is Nothing And Request.QueryString("Customer") <> "" Then
            ' If found then initialize page level variable and also session 
            m_intCustomer = CType(Request.QueryString("Customer"), Integer)
            HttpContext.Current.Session("Customer") = m_intCustomer
        ElseIf Not HttpContext.Current.Session("Customer") Is Nothing Then
            ' This part is required for post back to re-initialize variables 
            m_intCustomer = CType(HttpContext.Current.Session("Customer"), Integer)
        Else
            ' If request is not by customer then remove customer ID
            m_intCustomer = 0
            HttpContext.Current.Session.Remove("m_intCustomer")
            HttpContext.Current.Session.Remove("m_strVal")
            HttpContext.Current.Session.Remove("Customer")
        End If

        'Added by Srikanth on 04 Jan 2006 To Integrate Product , Components on Request Screen
        If strStatus = "FUNCTION_CHANGE" Or strStatus = "PRODUCT_CHANGE" Or strStatus = "MODULE_CHANGE" Or strStatus = "SUBREQUESTTYPE_CHANGE" Or m_strAction = "SAVE" Then
        Else
            HttpContext.Current.Session.Remove("ChangedProduct")
        End If

        If CType(Request.QueryString("IsProductChange"), Integer) = 1 Then
            HttpContext.Current.Session.Remove("ChangedProduct")
        End If

        If Not Request.QueryString("Product") Is Nothing And Request.QueryString("Product") <> "" Then
            m_ChangedProduct = CType(Request.QueryString("Product"), Integer)
            HttpContext.Current.Session("ChangedProduct") = m_ChangedProduct
        Else
            If CType(HttpContext.Current.Session("ChangedProduct"), Integer) <> 0 Then
                m_ChangedProduct = CType(HttpContext.Current.Session("ChangedProduct"), Integer)
            End If
        End If

        ' Page is called from list page
        If Not Request.QueryString("FromList") Is Nothing And Request.QueryString("FromList") <> "" Then
            m_FromList = CType(Request.QueryString("FromList"), Integer)
        End If

        If m_FromList <> 1 Then
            If CType(HttpContext.Current.Session("ListFilterData"), Integer) = 1 Then
                m_FilterData = CType(HttpContext.Current.Session("ListFilterData"), Integer)
                m_Filter = CType(HttpContext.Current.Session("ListFilter"), String)
                m_Department = CType(HttpContext.Current.Session("ListFilterDepartment"), String)
                m_Status = CType(HttpContext.Current.Session("ListFilterStatus"), String)
            Else
                m_FilterData = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txtHiddenFilterState"), "0"), Integer)
                m_Filter = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txtHiddenFilter"), "0"), String)
                m_Department = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txtHiddenDepartment"), "0"), String)
                m_Status = CType(CommonFunctions.General.CheckIsNothing(Request.Form("txtHiddenStatus"), "0"), String)
            End If
            If m_FilterData = 1 Then
                HttpContext.Current.Session.Add("ListFilterData", m_FilterData)
                HttpContext.Current.Session.Add("ListFilter", m_Filter)
                HttpContext.Current.Session.Add("ListFilterDepartment", m_Department)
                HttpContext.Current.Session.Add("ListFilterStatus", m_Status)
            Else
                HttpContext.Current.Session.Remove("ListFilterData")
                HttpContext.Current.Session.Remove("ListFilter")
                HttpContext.Current.Session.Remove("ListFilterDepartment")
                HttpContext.Current.Session.Remove("ListFilterStatus")
            End If
        End If

        'Token will be generated from code below, when task is created and and without going to list page user continues with furthur actions



        ' When page is called from "On behalf of" page then selected value from "Customer", "Employee" or "Self" is passed
        If Not Request.QueryString("RTVal") Is Nothing Then
            m_strVal = Request.QueryString("RTVal").ToString
            HttpContext.Current.Session("RTVal") = m_strVal
        Else
            m_strVal = CType(HttpContext.Current.Session("RTVal"), String)
        End If

        ' Check whether logged in person is from HRM's or Department Head
        ' Customer is never an HRM 
        Dim strSQLViewAccess As String
        Dim drViewAccess As IDataReader

        If m_strLoginType = "E" Then ' Employee login
            'this for checking whether the logged in resource has got only view access or not
            If UCase(Trim(m_strMode & "")) = "NEW" Then
                strSQLViewAccess = "select CRMID from tbl_CRM_Function_CRMS "
                strSQLViewAccess += " WHERE CRMID =" & m_lngEmployeeID
                strSQLViewAccess += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID
            Else
                strSQLViewAccess = "select CRMID from tbl_CRM_Function_CRMS where FunctionID IN "
                strSQLViewAccess += "(SELECT FunctionID FROM tbl_CRM_Query_master where QueryID = " & m_lngQueryID.ToString & ")and CRMID =" & m_lngEmployeeID
                strSQLViewAccess += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID & " and DepartmentID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & m_lngQueryID.ToString & ")"

            End If

            drViewAccess = CommonFunctions.Data.GetDataReader(strSQLViewAccess, m_blnUseSQL)
            If drViewAccess.Read Then
                blnViewAccessOrHRM = 1 ' If logged in person is either HRM or Department Head
            Else
                blnViewAccessOrHRM = 0
            End If
            CommonFunctions.Data.DisposeDataReader(drViewAccess)
        Else ' Customer Login
            blnViewAccessOrHRM = 0
        End If

        ' To show the default department
        ' This code selects default values for functions / depts , request types , sub request types 
        Dim dr As IDataReader
        ' If it is first hit and not post back then it will show first record by default.
        If MyBase.GetFormValue("cbofunction") Is Nothing OrElse (Not Request.QueryString("OnBehalfOf") Is Nothing And Request.QueryString("OnBehalfOf") <> "") Then
            If Not Page.IsPostBack OrElse (Not Request.QueryString("OnBehalfOf") Is Nothing And Request.QueryString("OnBehalfOf") <> "") Then
                ' Get accessible departments of logged in person
                If m_strLoginType = "E" Then
                    If m_intCustomer <> 0 Then ' On behalf of customer
                        ''commented and added by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                        'dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_DepartmentMaster_ForCustomer ", m_blnUseSQL)
                        dr = CommonFunction.Data.GetDataReader("usp_Sel_Department_ForCustomer " + m_intCustomer.ToString, m_blnUseSQL)
                        ''End of comment and addition by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                    ElseIf m_intRequestedEmployee <> 0 Then ' On behalf of other employee
                        dr = CommonFunction.Data.GetDataReader("usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost, m_blnUseSQL)
                    Else ' Self
                        dr = CommonFunction.Data.GetDataReader("usp_CRM_GetFunctions_ForRole " & Session("intPostID").ToString, m_blnUseSQL)
                    End If
                Else
                    ' Request is by Customer
                    ''commented and added by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                    'dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_DepartmentMaster_ForCustomer ", m_blnUseSQL)
                    dr = CommonFunction.Data.GetDataReader("usp_Sel_Department_ForCustomer " + m_lngEmployeeID.ToString, m_blnUseSQL)
                    ''End of comment and addition by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                End If
                If dr.Read Then
                    lngFunctionID = CType(dr("DepartmentID"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                ' no Defaulting to be done for Request type Sub request Type 
                '''Dim strSQLRequestTypes As String = "usp_CRM_RequestTypes  " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0,0"
                '''dr = CommonFunction.Data.GetDataReader(strSQLRequestTypes, m_blnUseSQL)
                '''If dr.Read Then
                '''    m_lngRequestTypeId = CType(dr("RequestTypeID"), Long)
                '''End If
                '''CommonFunctions.Data.DisposeDataReader(dr)

                '''dr = CommonFunction.Data.GetDataReader("usp_CRM_RequestSubTypes  " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId, m_blnUseSQL)
                '''If dr.Read Then
                '''    m_lngSubRequestTypeID = CType(dr("SubRequestTypeID"), Long)
                '''End If
                '''CommonFunctions.Data.DisposeDataReader(dr)
                '''If CommonFunction.Application.SplitRequestTypeSubType = False Then
                '''    strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
                '''End If
                m_lngRequestTypeId = 0
                m_lngSubRequestTypeID = 0
                ' End Modification By NitinVs on 13 Mar 2007 for WhizibleSEM SP 8 Regression Isssue 11168 
            Else
                m_lngRequestTypeId = 0
                m_lngSubRequestTypeID = 0
            End If
        End If


        ' To get the whether logged in person has access rights for SLA page
        Dim objGlobal As WebPages.Template.IGlobal
        Dim objAccessRights As WebPages.Security.cAccessRights

        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject()

        objGlobal.TagID = 3821

        objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        objAccessRights.GetAccess()

        m_blnSLAAccess = objAccessRights.View


        ' To Display Client Details on Request Main Screen In case of Clients Login
        If m_strLoginType = "C" Then
            Call GetClientDetails()
        End If

    End Sub

    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 23,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String

        Dim lngPrevAssignTo As Long
        Dim strPrevStatus As String
        Dim dtmPrevDate As Date
        Dim lngCurrAssignTo As Long
        Dim strCurrStatus As String
        Dim dtmCurrDate As Date

        Select Case UCase(Trim(m_strAction & ""))

            Case "DELETE_ATTACHMENTS"
                'Added by NitinC on 16 March 2011 for deleting physical files for WhizibleSEM version 10.0
                Dim strSQLQuery As String, inti As Integer, drAttachments As IDataReader
                'Delete attachments physically
                Dim AttachmentPath As String
                Dim Attachment As System.IO.File

                'Split Attachment Ids in an array
                Dim AttachmentIds() As String = Split(MyBase.GetFormValue("chkDelete"), ",")

                'Loop through the array
                For inti = 0 To UBound(AttachmentIds)

                    'Get attachment details
                    drAttachments = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_CRM_Attachments " + AttachmentIds(inti).Trim, MyBase.UseSQL)
                    While drAttachments.Read

                        ' Delete the original file.
                        If drAttachments("OriginalFileName").ToString <> "" Then
                            AttachmentPath = Server.MapPath("../../Attachments/CRM/") + "\" & drAttachments("OriginalFileName").ToString
                            If Attachment.Exists(AttachmentPath) Then
                                Attachment.Delete(AttachmentPath)
                            End If
                        End If

                        ' Delete the copy of  file.
                        If drAttachments("SystemFileName").ToString <> "" Then
                            AttachmentPath = Server.MapPath("../../Attachments/CRM/") + "\" & drAttachments("SystemFileName").ToString
                            If Attachment.Exists(AttachmentPath) Then
                                Attachment.Delete(AttachmentPath)
                            End If
                        End If
                    End While
                    CommonFunction.Data.DisposeDataReader(drAttachments)
                Next
                'End of Added by NitinC on 16 March 2011 for WhizibleSEM version 10.0

                If Trim(MyBase.GetFormValue("chkDelete") & "") <> "" Then
                    strSQL = "usp_CRM_Delete_Attachment '" & MyBase.GetFormValue("chkDelete") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If
                'ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
            Case "DELETE_DISCUSSION"
                ' DELETE THE DISCUSSION THREAD
                Dim strDeleteIDS As String
                Dim strQuery As String
                strDeleteIDS = MyBase.GetFormValue("chkDiscussionThread")
                If Not strDeleteIDS Is Nothing And strDeleteIDS <> "" Then
                    strQuery = "usp_del_tbl_CRM_Query_Details '" + strDeleteIDS + "'"
                    CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                End If

                'END ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
            Case "SAVE"

                If UCase(Trim(m_strMode & "")) = "EDIT" Then

                    ' When the request is been rejected then again the mail should be fired.
                    Dim ApprovalStatusForEmail As String
                    dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
                    If dr.Read Then
                        ApprovalStatusForEmail = dr("ApprovalStatus").ToString()
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)

                    Dim strPrevDate As String = ""
                    Dim strPrevTargetLoc As String = ""
                    lngPrevAssignTo = CType(MyBase.GetFormValue("cboAssignToOld"), Long)

                    ''added by harshada d for helpdesk enhancements for whizible 6.0 for issue id 1936
                    'Dim strSQLAssignToValidation As String
                    'Dim drAssignTovalidation As IDataReader
                    'Dim lngRequestTypeID As Long
                    'Dim lngSubRequestTypeID As Long
                    'Dim lngAssignTo As Long
                    'Dim lngFormValueRequestTypeID As Long
                    'Dim lngFormValueSubRequestTypeID As Long
                    'Dim lngFormValueAssignToID As Long
                    'Dim strFormValueReqSubReqType As String
                    'Dim strReqSubReqType As String
                    'Dim blnReqTypeAssignTo As Integer
                    'strSQLAssignToValidation = "usp_SEL_RequestType_SubRequestType " & m_lngQueryID.ToString
                    'drAssignTovalidation = CommonFunctions.Data.GetDataReader(strSQLAssignToValidation, m_blnUseSQL)
                    'If drAssignTovalidation.Read Then
                    '    lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(drAssignTovalidation("AssignTo"), "0"), Long)
                    '    If Trim(MyBase.GetFormValue("cboAssignTo") & "") = "" Then
                    '        lngFormValueAssignToID = 0
                    '    Else
                    '        lngFormValueAssignToID = CType(Trim(MyBase.GetFormValue("cboAssignTo") & ""), Long)
                    '    End If

                    '    If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    '        lngRequestTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drAssignTovalidation("RequestTypeID"), "0"), Long)
                    '        lngSubRequestTypeID = CType(CommonFunctions.Data.CheckIsDBNull(drAssignTovalidation("SubRequestTypeID"), "0"), Long)

                    '        If Trim(MyBase.GetFormValue("cboRequestType") & "") = "" Then
                    '            lngFormValueRequestTypeID = 0
                    '        Else
                    '            lngFormValueRequestTypeID = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
                    '        End If

                    '        If Trim(MyBase.GetFormValue("cboSubRequestType") & "") = "" Then
                    '            lngFormValueSubRequestTypeID = 0
                    '        Else
                    '            lngFormValueSubRequestTypeID = CType(Trim(MyBase.GetFormValue("cboSubRequestType") & ""), Long)
                    '        End If
                    '        If m_strFromWhere = "DB" And lngFormValueAssignToID <> 0 And lngAssignTo = lngFormValueAssignToID And (lngFormValueRequestTypeID <> lngRequestTypeID Or lngFormValueSubRequestTypeID <> lngSubRequestTypeID) Then
                    '            blnReqTypeAssignTo = 1
                    '        Else
                    '            blnReqTypeAssignTo = 0
                    '        End If

                    '    Else
                    '        strReqSubReqType = CType(CommonFunctions.Data.CheckIsDBNull(drAssignTovalidation("ReqTypeSubRequestType"), "0"), String)
                    '        If Trim(MyBase.GetFormValue("cboSubRequestType") & "") = "" Then
                    '            strFormValueReqSubReqType = ""
                    '        Else
                    '            strFormValueReqSubReqType = MyBase.GetFormValue("cboSubRequestType")
                    '        End If
                    '        If m_strFromWhere = "DB" And lngFormValueAssignToID <> 0 And lngAssignTo = lngFormValueAssignToID And strFormValueReqSubReqType <> strReqSubReqType Then
                    '            blnReqTypeAssignTo = 1
                    '        Else
                    '            blnReqTypeAssignTo = 0
                    '        End If
                    '    End If
                    'End If
                    'CommonFunctions.Data.DisposeDataReader(drAssignTovalidation)

                    'If blnReqTypeAssignTo = 1 Then
                    '    With Response
                    '        .Write("<script language=javascript>")
                    '        .Write("alert('Please change the assigned person!');")
                    '        .Write("</script>")
                    '    End With

                    'Else
                    'end of addition by harshada d for helpdesk enhancements for issue id 1936

                    'modified by SachinR    on 15 Dec 2005
                    If MyBase.GetFormValue("txtResolutionDateOld") <> "" Then
                        strPrevDate = MyBase.GetFormValue("txtResolutionDateOld") + ""
                        dtmPrevDate = CType(MyBase.GetFormValue("txtResolutionDateOld"), Date)
                    End If
                    dtmCurrDate = dtmPrevDate

                    'added by SachinR   on 15 Dec 2005
                    If MyBase.GetFormValue("txtPrevTargetLoc") <> "" Then
                        strPrevTargetLoc = MyBase.GetFormValue("txtPrevTargetLoc") + ""
                    End If
                    'modification end   on 15 Dec 2005
                    'End Integration
                    '---------------------------------------------------------------------------------
                    strPrevStatus = MyBase.GetFormValue("cboStatusOld")

                    ' End Modification By NitinVS  on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2  
                    ' update
                    strSQL = " Exec usp_CRM_Update_RequestDetails "
                    strSQL += m_lngQueryID & ","
                    strSQL += MyBase.GetFormValue("cboFunction") & ","

                    'Added By SantoshK on 30th Nov 2004
                    If CommonFunction.Application.SplitRequestTypeSubType = True Then
                        strSQL += "'" & MyBase.GetFormValue("cboSubRequestType") & "|" & MyBase.GetFormValue("cboRequestType") & "',"
                    Else
                        strSQL += "'" & MyBase.GetFormValue("cboSubRequestType") & "',"
                    End If
                    'Addition Ends

                    strSQL += "'" & MyBase.GetFormValue("txtSubject") & "',"
                    strSQL += "'" & MyBase.GetFormValue("txtDescription") & "',"
                    If Trim(MyBase.GetFormValue("cboPriority") & "") = "" Then
                        strSQL += "NULL,"
                    Else
                        strSQL += MyBase.GetFormValue("cboPriority") & ","
                    End If

                    '----------------------------------------------------------------------------------------------
                    'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
                    'strSQL += "'" & MyBase.GetFormValue("txtResolutionDate") & "',"
                    'Added by SavitaS on1 14 Dec 2005 to disallow customers to view ResolutionDate
                    'Modified by SachinR
                    If m_strLoginType <> "E" Then
                        If strPrevDate <> "" Then
                            strSQL += "'" + strPrevDate + "',"
                        Else
                            'Modified By NitinVS on 10 Mar 2007 for WhizibleSEM SP8 IssueID 11482 
                            'Added , after Null 
                            strSQL += "NULL,"
                            'Modified By NitinVS on 10 Mar 2007 for WhizibleSEM SP8 IssueID 11482 
                        End If
                    Else
                        If Trim(MyBase.GetFormValue("txtResolutionDate") & "") <> "" Then
                            strSQL += "'" & MyBase.GetFormValue("txtResolutionDate") & "',"
                        Else
                            strSQL += "Null,"
                        End If
                    End If
                    'End Addition
                    'End Integration
                    '-------------------------------------------------------------------------------------------
                    'Commented By ShraddhaM on 13,July 2007
                    'If Trim(MyBase.GetFormValue("cboAssignTo") & "") = "" Then
                    '    strSQL += "NULL,"
                    'Else
                    '    strSQL += MyBase.GetFormValue("cboAssignTo") & ","
                    'End If
                    If Trim(MyBase.GetFormValue("hidtxtAssignTo") & "") = "" Then
                        strSQL += "NULL,"
                    Else
                        strSQL += MyBase.GetFormValue("hidtxtAssignTo") & ","
                    End If
                    'hidtxtAssignTo
                    'End of Comment By ShraddhaM on 13,July 2007
                    strSQL += MyBase.GetFormValue("cboStatus") & ","
                    '----------------------------------------------------------------------------------------------
                    'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
                    'strSQL += MyBase.GetFormValue("cboTargetLocation") & ","

                    'Added by SavitaS on 14 Dec 2005 to disallow customers to view ResolutionDate for IssueID 1936
                    'Modified by SachinR
                    If m_strLoginType <> "E" Then
                        If strPrevTargetLoc = "" Then
                            'Commented and added By ShraddhaM on 17,Sep 2007
                            'strSQL += "NULL,"
                            If Trim(MyBase.GetFormValue("cboTargetLocation") & "") <> "" Then
                                strSQL += MyBase.GetFormValue("cboTargetLocation") & ","
                            Else
                                strSQL += "Null,"
                            End If
                            'End of comment and addition By ShraddhaM on 17,Sep 2007
                        Else
                            strSQL += strPrevTargetLoc + ","
                        End If
                    Else
                        If Trim(MyBase.GetFormValue("cboTargetLocation") & "") <> "" Then
                            strSQL += MyBase.GetFormValue("cboTargetLocation") & ","
                        Else
                            strSQL += "Null,"
                        End If
                    End If
                    'End Addition by SavitaS on 14 Dec

                    'End Integration
                    '-------------------------------------------------------------------------------------------

                    If Trim(MyBase.GetFormValue("txtCRMResolutionDate") & "") <> "" Then
                        strSQL += "'" & MyBase.GetFormValue("txtCRMResolutionDate") & "'"
                    Else
                        strSQL += "Null"
                    End If
                    If Trim(MyBase.GetFormValue("txtComments") & "") <> "" Then
                        strSQL += ",'" & MyBase.GetFormValue("txtComments") & "'"
                    Else
                        strSQL += ",Null"
                    End If

                    If Trim(MyBase.GetFormValue("cboFeedback") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboFeedback")
                    Else
                        strSQL += ",Null"
                    End If
                    If Trim(MyBase.GetFormValue("txtFeedbackComments") & "") <> "" Then
                        strSQL += ",'" & MyBase.GetFormValue("txtFeedbackComments") & "'"
                    Else
                        strSQL += ",Null"
                    End If
                    '--------------------------------------------------------------------------------------------------------
                    'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
                    'added by harshada d on 28 Nov 2005 for HelpDesk "show history" option 
                    strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"
                    'end of addition by harshada d on 28 Nov 2005 for HelpDesk "show history" option 
                    'End Integration by SavitaS 
                    '--------------------------------------------------------------------------------------------------------

                    'Added by ManishK on 11th Jan 06 to add deliverable on helpdesk 
                    'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
                    'Purpose: added one condition for My e-Dashboard (MD)
                    'If CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "DB" Or CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "AR" Then

                    'Commented by ShraddhaM on 11,Sep 2007
                    'Deliverable control is plotted on SR also so no need of this if 
                    'If CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "DB" Or CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "AR" Or CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "MD" Then
                    'End of addition by PrashantSJ on 09 Nov 2006
                    'End of comment by ShraddhaM on 11,Sep 2007
                    If Trim(MyBase.GetFormValue("DeliverableID") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("DeliverableID")
                    Else
                        strSQL += ",Null"
                    End If
                    'End If
                    'end of Added by ManishK on 11th Jan 06 to add deliverable on helpdesk
                    'Commented by ShraddhaM on 11,Sep 2007
                    ''Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
                    ''Code Added By PradipK for Help Desk SLA 
                    ''For SR (Submitted Requests) Deliverable is not Plotted.
                    '    If CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), "")).ToUpper = "SR" Then
                    '        strSQL += ",NULL"
                    '    End If
                    'End of comment by ShraddhaM on 11,Sep 2007
                    'Date:18 May 2006
                    If Trim(MyBase.GetFormValue("txtchangedDate") & "") = "" Then
                        strSQL += ",NULL"
                    Else
                        strSQL += ",'" & MyBase.GetFormValue("txtchangedDate") & "'"
                    End If
                    If Trim(MyBase.GetFormValue("txtchangedTime") & "") = "" Then
                        strSQL += ",NULL"
                    Else
                        strSQL += ",'" & MyBase.GetFormValue("txtchangedTime") & "'"
                    End If
                    'End Addition By PradipK for Help Desk SLA 
                    'End Integration
                    'Added by SrikanthY on 09 Jan 2007 to pass Project,product,component details to updation sp..
                    If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboProject")
                    Else
                        strSQL += ",Null"
                    End If
                    If Trim(MyBase.GetFormValue("cboProduct") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboProduct")
                    Else
                        strSQL += ",Null"
                    End If
                    If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboModule")
                    Else
                        strSQL += ",Null"
                    End If
                    'End of addition by SrikanthY

                    'Added BY NitinVS on 19 Feb 2007 for WhizibleSEM SP9 IssueID 10366
                    'Added Field Severity
                    If Trim(MyBase.GetFormValue("cboSeverity") & "") <> "" Then
                        strSQL += "," + MyBase.GetFormValue("cboSeverity").ToString
                    Else
                        strSQL += ",NULL"
                    End If
                    'End Addition BY NitinVS on 19 Feb 2007 for WhizibleSEM SP9 IssueID 10366
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)

                    ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueId 2 
                    'dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
                    'If dr.Read Then
                    '    lngCurrAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
                    '    dtmCurrDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("ExpectedResolvedDate"), Now().ToString), Date)
                    '    strCurrStatus = dr("Status").ToString
                    'End If
                    'CommonFunctions.Data.DisposeDataReader(dr)

                    'Commented and Added By ShraddhaM on 13,July 2007 For Data CleanUp Activity
                    'If CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboAssignTo"), "") <> "" Then
                    '    lngCurrAssignTo = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboAssignTo"), "0"), Long)
                    'Else
                    '    lngCurrAssignTo = 0
                    'End If

                    If CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("hidtxtAssignTo"), "") <> "" Then
                        lngCurrAssignTo = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("hidtxtAssignTo"), "0"), Long)
                    Else
                        lngCurrAssignTo = 0
                    End If

                    'End of Comment and Addition By ShraddhaM on 13,July 2007  For Data CleanUp Activity
                    '--------------------------------------------------------------------------------------------------------
                    'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936

                    'Added by SavitaS on1 14 Dec 2005 for IssueID 1936
                    'Modified by SachinR
                    If m_strLoginType = "E" Then
                        If MyBase.GetFormValue("txtResolutionDate") <> "" Then
                            dtmCurrDate = CType(CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtResolutionDate"), Date.Now.ToString), Date)
                        End If
                    End If
                    'End Addition by SavitaS on 14 Dec 2005
                    'End Integration by SavitaS 
                    '--------------------------------------------------------------------------------------------------------
                    strCurrStatus = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboStatus"), "")

                    ' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2  

                    ' Assign To change mail
                    If lngCurrAssignTo <> 0 And lngCurrAssignTo <> lngPrevAssignTo Then
                        blnSendMail = False : blnShowPopup = False
                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 43", m_blnUseSQL)
                        If dr.Read Then
                            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)

                        If blnSendMail Then
                            If blnShowPopup Then
                                With Response
                                    .Write("<script language=javascript>")
                                    .Write("window.open (""../General/SendEmail.aspx?MessageID=43&MultipleRequests=0&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                    .Write("</script>")
                                End With
                            Else
                                ' silent mail
                                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID.ToString, False)
                                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            End If
                        End If
                    End If

                    ' Status change mail
                    If Trim(strCurrStatus & "") <> "" And Trim(strPrevStatus & "") <> Trim(strCurrStatus & "") Then
                        blnSendMail = False : blnShowPopup = False
                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 44", m_blnUseSQL)
                        If dr.Read Then
                            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)

                        If blnSendMail Then
                            If blnShowPopup Then
                                With Response
                                    .Write("<script language=javascript>")
                                    .Write("window.open (""../General/SendEmail.aspx?MessageID=44&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                    .Write("</script>")
                                End With
                            Else
                                ' silent mail
                                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            End If
                        End If
                    End If

                    ' Expected Resolved date change mail
                    If dtmCurrDate <> dtmPrevDate Then
                        blnSendMail = False : blnShowPopup = False
                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 45", m_blnUseSQL)
                        If dr.Read Then
                            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)

                        If blnSendMail Then
                            If blnShowPopup Then
                                With Response
                                    .Write("<script language=javascript>")
                                    .Write("window.open (""../General/SendEmail.aspx?MessageID=45&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" +(window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                    .Write("</script>")
                                End With
                            Else
                                ' silent mail
                                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID, "")
                                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                            End If
                        End If

                    End If

                    ' added by harshada d for whiziblesem 6.0 for helpdesk enhancements for issue id 1936
                    '  End If
                    'end of addition by harshada d for whiziblesem 6.0 for helpdesk enhancements for issue id 1936

                    'Added By VarunA on 28-Nov-2008 IssueID-24324
                    'Purpose : When the request is been rejected then again the mail should be fired.

                    blnSendMail = False : blnShowPopup = False
                    If strCurrStatus <> "2" Then


                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", m_blnUseSQL)

                        If dr.Read Then
                            blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                            blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                        If RTrim(LTrim(ApprovalStatusForEmail)) = "R" Then
                            If blnSendMail Then
                                If blnShowPopup Then
                                    With Response
                                        .Write("<script language=javascript>")
                                        'Code Modified by Vidyak on 04 Jun 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
                                        '.Write("window.open (""../General/SendEmail.aspx?MessageID=46&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                        .Write("window.open (""../General/SendEmail.aspx?MessageID=544&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                        'End Code Modified by Vidyak on 04 Jun 2010
                                        .Write("</script>")
                                    End With
                                Else
                                    ' silent mail
                                    'Commented and Added by ShraddhaM on 2,Oct 2008 for Line Manager aPproval Mails in Whiziblesem8
                                    'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                                    'Code Modified by Vidyak on 04 Jun 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
                                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_544(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID, "")
                                    'End Code Modified by Vidyak on 04 Jun 2010
                                    'End of comment and addition bby ShraddhaM
                                    CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)

                                End If
                            End If
                        End If
                    End If
                    'End by VarunA on 28-Nov-2008 IssueID-24324
                Else
                    ' insert
                    strSQL = " Exec usp_CRM_Insert_RequestDetails "
                    strSQL += MyBase.GetFormValue("cboFunction") & ","

                    'Added By SantoshK to Seperate Request Type and SubRequest Type
                    If CommonFunction.Application.SplitRequestTypeSubType = True Then
                        strSQL += "'" & MyBase.GetFormValue("cboSubRequestType") & "|" & MyBase.GetFormValue("cboRequestType") & "',"
                    Else
                        strSQL += "'" & MyBase.GetFormValue("cboSubRequestType") & "',"
                    End If

                    strSQL += "'" & MyBase.GetFormValue("txtSubject") & "',"
                    strSQL += "'" & MyBase.GetFormValue("txtDescription") & "',"
                    If Trim(MyBase.GetFormValue("cboPriority") & "") = "" Then
                        strSQL += "NULL,"
                    Else
                        strSQL += "" & MyBase.GetFormValue("cboPriority") & ","
                    End If
                    '----------------------------------------------------------------------------------------------
                    'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
                    'strSQL += "'" & MyBase.GetFormValue("txtResolutionDate") & "',"
                    'modified by SachinR on 15 Dec 2005
                    'strSQL += "'" & MyBase.GetFormValue("txtResolutionDate") & "',"

                    If MyBase.GetFormValue("txtResolutionDate").Trim <> "" Then
                        strSQL += "'" & MyBase.GetFormValue("txtResolutionDate") & "',"
                    Else
                        strSQL += "NULL,"
                    End If
                    'End Modification
                    'End Integration
                    '-------------------------------------------------------------------------------------------

                    If Trim(MyBase.GetFormValue("cboAssignTo") & "") = "" Then
                        strSQL += "NULL,"
                    Else
                        strSQL += MyBase.GetFormValue("cboAssignTo") & ","
                    End If
                    ' the status "open" has id = 1
                    strSQL += "1,"
                    '----------------------------------------------------------------------------------------------
                    'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
                    'strSQL += MyBase.GetFormValue("cboTargetLocation") & ","
                    'strSQL += "'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "',"
                    'strSQL += "'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    'Added by SavitaS on 14 Dec 2005 for IssueID 1936

                    If m_strLoginType <> "E" Then
                        strSQL += "NULL,"
                    Else
                        'End Addition by SavitaS on 14 Dec 2005
                        If Trim(MyBase.GetFormValue("cboTargetLocation") & "") <> "" Then
                            strSQL += MyBase.GetFormValue("cboTargetLocation") & ","
                        Else
                            strSQL += "Null,"
                        End If


                    End If
                    'added by harshada d on 20 Nov for HelpDesk Patch

                    'Added by SrikanthY on 08 Jan 2007 to capture module value from drop down
                    If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
                        m_ChangedModule = CType(Trim(MyBase.GetFormValue("cboModule")), Integer)
                    End If
                    'End of addition by SrikanthY
                    Dim drCustomer As IDataReader
                    Dim strCustomerShortName As String
                    Dim strCust As String
                    Dim strRequestType As String
                    Dim strClientID As String
                    Dim EmployeeName As String
                    'drCustomer = CommonFunctions.Data.GetDataReader("select CustomerID from tbl_pm_customer where Customer =" & m_intCustomer & "", m_blnUseSQL)
                    m_intCustomer = CType(HttpContext.Current.Session("Customer"), Integer)
                    strClientID = CType(HttpContext.Current.Session("intLoginID"), String)

                    'Modified by SavitaS on 15 Dec 2005 for IssueID 1936

                    '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    'strCust = "select CustomerID from tbl_pm_customer where Customer=" & m_intCustomer
                    strCust = "usp_sel_tbl_pm_customer_CustomerID " & m_intCustomer
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    'End Modification by SavitaS

                    drCustomer = CommonFunctions.Data.GetDataReader(strCust, m_blnUseSQL)

                    If drCustomer.Read Then
                        strCustomerShortName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomer("CustomerID"), "0"), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drCustomer)

                    strRequestType = m_strVal 'CType(HttpContext.Current.Session("RTVal"), String)

                    If (m_intCustomer <> 0) Then ' And strRequestType = "C"
                        strSQL += "'" & CommonFunctions.General.BuildQueryString(strCustomerShortName) & "',"
                        strSQL += "'C'"
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL += "'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "',"
                        Else
                            strSQL += "'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "',"
                        End If
                        strSQL += "'" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"
                    End If

                    'Added by SavitaS on 30 Nov 2005 to insert value for OnBehalfOfCustomer field for IssueID 1936
                    'If (m_intCustomer <> 0) And m_strLoginType = "E" Then
                    'Added by SrikanthY on 21 Dec 2006 to Get OnBehalf Employeeid
                    If ((m_intCustomer <> 0) Or (m_intRequestedEmployee <> 0)) And m_strLoginType = "E" Then
                        strSQL += "," & m_lngEmployeeID.ToString
                    Else
                        strSQL += ", Null"
                    End If

                    'End Addition by SavitaS
                    'End Integration by SavitaS
                    '-------------------------------------------------------------------------------------------

                    ' Modified By NitinVS on 4 Aug 2005 for WhizibleSEM SP4 IssueID 2 
                    'dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    'If dr.Read Then
                    '    m_lngQueryID = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestID"), "0"), Long)
                    'End If
                    'CommonFunctions.Data.DisposeDataReader(dr)

                    'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
                    'Code Added By PradipK for Help Desk SLA 
                    'Added by shraddhaM on 7th March 06 - SLA For HelpDesk
                    'Dim strSQL2 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"

                    'Dim strDate2 As String = CommonFunction.Data.GetDataScalar(strSQL2, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                    Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                    Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                    Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                    Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                    'strSQL += ",'" & strDate2 & "'"

                    strSQL += ",'" & strGetServerTime1 & "'"
                    'Stores default date in database
                    strSQL += ",'" & strGetServerDate1 & "'"
                    'strSQL += ",'" & Now() & "'"

                    ' Added by SrikanthY on 28 Dec 2006 To Insert Client Details on Request table In case of Clients Login
                    If m_blnIsClient = True Then
                        strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strLoginName) & "'"
                    Else
                        strSQL += ",Null "
                    End If
                    'End of Addition by SrikanthY

                    ' Added by SrikanthY on 05 Jan 2007 To Integrate Product,Component Details in Request table 

                    'If m_ChangedProduct <> 0 Then
                    '    strSQL += "," & m_ChangedProduct.ToString
                    'Else
                    '    strSQL += ",Null "
                    'End If
                    'If m_ChangedModule <> 0 Then
                    '    strSQL += "," & m_ChangedModule.ToString
                    'Else
                    '    strSQL += ",Null "
                    'End If
                    If Trim(MyBase.GetFormValue("cboProduct") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboProduct")
                    Else
                        strSQL += ",Null"
                    End If
                    If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboModule")
                    Else
                        strSQL += ",Null"
                    End If





                    If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboProject")
                    Else
                        strSQL += ",Null"
                    End If

                    'End of Addition by SrikanthY
                    ' Added by SrikanthY on 15 Jan 2007 To track Modifed By field seperately , issue no-9447 
                    strSQL += "," & "'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"
                    'End of Addition by SrikanthY
                    'Ended by shraddhaM on 7th March 06 - SLA For HelpDesk
                    'End Addition By PradipK for Help Desk SLA 
                    'End Integration

                    ' Added By NitinVs on 19 FEb 2007 for WhizibleSEM SP 9 IssueID 10366

                    If Trim(MyBase.GetFormValue("cboSeverity") & "") <> "" Then
                        strSQL += "," & MyBase.GetFormValue("cboSeverity")
                    Else
                        strSQL += ",Null"
                    End If
                    ' end Addition  By NitinVs on 19 FEb 2007 for WhizibleSEM SP 9 IssueID 10366
                    'Commented and Added by ShraddhaM on 2,Oct 2008 for Line Manager aPproval Mails in Whiziblesem8
                    'm_lngQueryID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL), "0"), "0"), Long)
                    Dim drApprovalStatus As IDataReader
                    Dim ApprovalStatusForEmail As String
                    drApprovalStatus = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If drApprovalStatus.Read() Then
                        m_lngQueryID = drApprovalStatus("RequestID").ToString()
                        ApprovalStatusForEmail = drApprovalStatus("ApprovalStatus").ToString()
                    End If

                    CommonFunctions.Data.DisposeDataReader(drApprovalStatus)

                    'End of addition by shraddhaM

                    m_strMode = "EDIT"
                    'if for the sub request type attachment is mandatory->display a msg
                    '   dr = CommonFunctions.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
                    '   If dr.Read Then
                    '       If CType(CommonFunctions.Data.CheckIsDBNull(dr("IsAttachmentMandatory"), "0"), Boolean) Then
                    '           m_intShowMandatoryAttachmentMsg = 1
                    '       End If
                    '   End If
                    '   CommonFunctions.Data.DisposeDataReader(dr)

                    m_intShowMandatoryAttachmentMsg = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_CRM_get_MandatoryAttachment " + m_lngQueryID.ToString, m_blnUseSQL), "0"), "0"), Integer)

                    blnSendMail = False : blnShowPopup = False
                    'Modified by Vidyak for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications) --added mailid=545 for ApprovalStatusForEmail = "S"
                    If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 545", m_blnUseSQL)
                    Else
                        dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", m_blnUseSQL)
                    End If
                    'dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 46", m_blnUseSQL)

                    If dr.Read Then
                        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                        blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)

                    If blnSendMail Then
                        If blnShowPopup Then
                            With Response
                                .Write("<script language=javascript>")
                                If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
                                    .Write("window.open (""../General/SendEmail.aspx?MessageID=545&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                Else
                                    .Write("window.open (""../General/SendEmail.aspx?MessageID=46&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                                End If
                                .Write("</script>")
                            End With
                        Else
                            ' silent mail
                            'Commented and Added by ShraddhaM on 2,Oct 2008 for Line Manager aPproval Mails in Whiziblesem8
                            'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                            If RTrim(LTrim(ApprovalStatusForEmail)) = "S" Then
                                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_545(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID, "")
                            Else
                                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID, "")
                            End If
                            'End of comment and addition bby ShraddhaM
                            CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)

                        End If
                    End If
                    'End - Modified by Vidyak for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications) --added mailid=545 for ApprovalStatusForEmail = "S"
                    'Response.Write("<Script language='javascript'>")
                    ' CommonFunctions.General.WriteHTML("window.opener.location.href=window.opener.location.href;" + vbCrLf)
                    ''CommonFunctions.General.WriteHTML("</Script>")
                End If

                'Added By Amol Changle On: 22 Jul 2009
                'Purpose: To save custom fields
                Dim strTypeInaccessibleCustomFieldList As String
                m_strCustomFieldList = HttpContext.Current.Request.Form("CustomFieldList")
                strTypeInaccessibleCustomFieldList = HttpContext.Current.Request.Form("TypeInaccessibleCustomFieldList")
                If m_strCustomFieldList <> "" Then
                    Dim arrCustomFields() As String = Split(m_strCustomFieldList, ",")
                    Dim intCount As Integer

                    If m_lngQueryID > 0 Then
                        strSQL = " Update Tbl_CRM_Query_Master set "
                        For intCount = 0 To arrCustomFields.Length - 1
                            If HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) Is Nothing Then
                                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form(arrCustomFields(intCount)) = "" Then
                                    strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                                Else
                                    strSQL = strSQL & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form(arrCustomFields(intCount))) + "',"
                                End If
                            Else
                                If InStr(1, arrCustomFields(intCount), "CustomFieldDate") > 0 And HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount)) = "" Then
                                    strSQL = strSQL & arrCustomFields(intCount) & "=NULL,"
                                Else
                                    strSQL = strSQL & arrCustomFields(intCount) & "='" & CommonFunctions.General.BuildQueryString(HttpContext.Current.Request.Form("Dummy" + arrCustomFields(intCount))) + "',"
                                End If
                            End If
                        Next
                        If strTypeInaccessibleCustomFieldList <> "" Then
                            Dim arrInaccessibleCustomFields() As String = Split(strTypeInaccessibleCustomFieldList, ",")
                            For intCount = 0 To arrInaccessibleCustomFields.Length - 1
                                strSQL = strSQL & arrInaccessibleCustomFields(intCount) & "=NULL,"
                            Next
                        End If
                        strSQL = strSQL.Substring(0, strSQL.Length - 1)
                        'If (m_strTaskIDList <> "" And Not m_strTaskIDList Is Nothing) Then
                        '    strSQL = strSQL + " where TaskID IN (" & m_strTaskIDList & ") OR TaskID IN (Select ParentTask_UID From tbl_PM_ProjectTasks Where TaskID IN (" & m_strTaskIDList & ")) OR ParentTask_UID  IN (" & m_strTaskIDList & ")"
                        'Else
                        '    strSQL = strSQL + " where TaskID = " & m_lngTaskId & " OR TaskID = (Select ParentTask_UID From tbl_PM_ProjectTasks Where TaskID = " & m_lngTaskId & ") OR ParentTask_UID = " & m_lngTaskId
                        'End If
                        strSQL = strSQL + " where QueryID = " & m_lngQueryID
                        CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    End If
                End If
                'End Addition By Amol Changle On: 22 Jul 2009

                'Added by SonalD on 23rd March 2009...strcloseChildWindow will be set to 1 in case of 'Save and Close' link
                Dim strcloseChildWindow As String
                strcloseChildWindow = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("closeChildWindow"), "")
                If strcloseChildWindow = "1" Then
                    Response.Write("<script language=javascript>")
                    Response.Write("window.close();")
                    Response.Write("</script>")
                End If
                'End of addition by SonalD on 23rd March 2009


                If (UCase(Trim(m_strMode & "")) = "EDIT" And m_lngQueryID > 0) Then

                    m_PKToken_FromRequestDetail = CommonFunctions.Security.Token.GetToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0")
                End If
                ''Added by Yogesh Jalamkar on 30-MAy-2017 Purpose: Page Refresh issue
                If UCase(Trim(strRequestMode & "")) = "NEW" Then
                    Response.Write("<script>")
                    Response.Write("if('" & m_strFromWhere & "' == 'SR')")
                    Response.Write("{")
                    Response.Write("if (window.opener != null && window.opener.location.href.match('CRM_RequestList.aspx') == 'CRM_RequestList.aspx')")
                    Response.Write("{")
                    Response.Write("window.opener.location.href='CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" & CommonFunction.General.CheckIsNothing(Request.QueryString("SRFilterID"), "") & "&StatusID=" & CommonFunction.General.CheckIsNothing(Request.QueryString("StatusID"), "") & "&SortBy=" & CommonFunction.General.CheckIsNothing(Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(Request.QueryString("SortOrder"), "") & "&PageNumber=" & CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") & "'")
                    Response.Write("}")
                    Response.Write("else")
                    Response.Write("{")
                    Response.Write("if(window.opener!= null)")
                    Response.Write("window.opener.location.href='CRM_RequestList.aspx?Action=SET_DEFAULT_FILTER&Mode=SR&FilterID=" & CommonFunction.General.CheckIsNothing(Request.QueryString("SRFilterID"), "") & "&StatusID=" & CommonFunction.General.CheckIsNothing(Request.QueryString("StatusID"), "") & "&SortBy=" & CommonFunction.General.CheckIsNothing(Request.QueryString("SortBy"), "") & "&SortOrder=" & CommonFunction.General.CheckIsNothing(Request.QueryString("SortOrder"), "") & "&PageNumber=" & CommonFunction.General.CheckIsNothing(Request.QueryString("PageNumber"), "") & "'")
                    Response.Write("}")
                    Response.Write("}")
                    Response.Write("</script>")
                End If

                ''  End of addition  by Yogesh Jalamkar on 30-MAy-2017 Purpose: Page Refresh issue
            Case Else
        End Select
    End Sub
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(DeliverableID As String, QueryID As String, FunctionID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(DeliverableID, String) + CType(QueryID, String) + CType(FunctionID, String) + "0" + "0")
        Return m_PKToken_Request_Multiple

    End Function
    'Protected Sub WritePage()
    '    '=====================================================================
    '    ' Procedure Name        : WritePage()	
    '    ' Purpose               : To write the page for adding report to user Dashboards
    '    ' Description           : same as above
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : module variables are set before this
    '    ' Dependencies          : 
    '    ' Author                : Rajanikant
    '    ' Created               :Feb 21,2004
    '    ' Revisions             :
    '    '=====================================================================
    '    ' Modified By NitinVS on 18 Aug 2005 For WhzibileSEM SP4 Helpdesk Performance 
    '    ' Added Link for Reject 
    '    '----------------------------------------------------------------------------------------------
    '    'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    '    'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
    '    'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
    '    'Modified by VidyaJ for IssueID - 16585
    '    'Dim arrCSFunction() As String = {"AssignTask_OnClick()", "AssignIssue_OnClick()", "DeleteAttachment_OnClick()", "AddAttachment_OnClick()", "Discussion_OnClick()", "Reject_Onclick()", "Save_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}


    '    'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE"), "Show History", MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
    '    'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Show History", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
    '    'Dim arrCSFunction() As String = {"AssignTask_OnClick()", "AssignIssue_OnClick()", "AddAttachment_OnClick()", "SelectAll_OnClick()", "DeleteAttachment_OnClick()", "Discussion_OnClick()", "Reject_Onclick()", "Save_OnClick()", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
    '    '-------------------------------------------------------------------------------------------
    '    'End
    '    ' End Modification By NitinVS on 18 Aug 2005 For WhzibileSEM SP4 Helpdesk Performance 

    '    ''Modified by ManishK on 10th Jan 06 For Deliverable Link Functionality ...
    '    'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE"), "Show History", MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
    '    'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Show History", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
    '    ''End of Modified by ManishK on 10th Jan 06 For Deliverable Link Functionality ...
    '    ''Modified by VidyaJ for IssueID - 16585
    '    'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "AddAttachment_OnClick()", "SelectAll_OnClick()", "DeleteAttachment_OnClick()", "Discussion_OnClick()", "Reject_Onclick()", "Save_OnClick()", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
    '    ''End Integration


    '    'Added by PrashantSJ on 08 Nov 2006 For WhizibleSEM SP8 Build 1
    '    'Purpose: To add one link called "Flag Request"

    '    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
    '    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS_TOOLTIP"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
    '    Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Reject_Onclick()", "ShowHistory_OnClick()", "Discussion_OnClick()", "AddAttachment_OnClick()", "DeleteAttachment_OnClick()", "SelectAll_OnClick()", "FlagRequest_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

    '    'End of addition by PrashantSJ on 08 Nov 2006

    '    Dim strMenu, strLegend As String

    '    Dim arrLegend() As String = {"Mandatory"}
    '    Dim arrLegendImage() As String = {"<img src='../../../responsive/images/star.gif'>"}

    '    Dim dr As IDataReader
    '    Dim strSQL As String
    '    Dim blnDisableStatusCombo As Boolean = False
    '    Dim blnDisableFunctionCombo As Boolean = False
    '    Dim blnDisableSubRequestTypeCombo As Boolean = False
    '    ' added by harshada d on 03 Feb 2006 for help desk enhancements
    '    Dim strSQLCustomerName As String
    '    Dim drCustomerName As IDataReader
    '    Dim strCustomerName As String
    '    'end of additon by harshada d
    '    Dim blnDisbaledSubjectTextBox As Boolean = False
    '    Dim blnDisabledAssignToCombo As Boolean = False
    '    Dim blnReadOnlyComments As Boolean = False
    '    Dim arr() As String
    '    Dim intTemplateCount As Integer
    '    Dim strStyle As String
    '    Dim strRequestType As String = ""
    '    Dim strGuidelinesColumnName As String = ""
    '    Dim intRequestTypeID As Long = 0
    '    Dim strSubject As String = ""
    '    Dim strDescription As String = ""
    '    Dim intPriorityID As Integer = 0
    '    Dim strExpectedResolvedDate As String = ""
    '    Dim strCRMExpectedResolvedDate As String = ""
    '    Dim lngAssignTo As Long = 0
    '    Dim lngTargetLocationID As Long = 0
    '    Dim intStatusID As Integer = 0
    '    Dim intFeedbackID As Integer = 0
    '    Dim strFeedbackComments As String = ""
    '    Dim strComments As String = ""
    '    Dim strReasonsForRejection As String = ""
    '    'Added By NitinVS on 16 Mar 2007 for WhizibleSEM SP 8 Regression Issue 
    '    Dim lngRequestTypeIdOld As Long = 0
    '    ' End Addition By NitinVS on 16 Mar 2007 for WhizibleSEM SP 8 Regression Issue 
    '    'To Display Request ID and Requestor in Edit Mode
    '    Dim lngRequestID As Long = 0
    '    Dim strRequestor As String = ""
    '    Dim strRequestorName As String = ""

    '    'Addition Ends
    '    'Added by SrikanthY on 04 Jan 07 For Integrating Product , Components in Request Screen
    '    Dim blnDisableProductCombo As Boolean = False
    '    Dim blnDisableModuleCombo As Boolean = False
    '    Dim blnDisableProjectCombo As Boolean = False
    '    'End of Addition by SrikanthY
    '    ' disable status combo?
    '    If Not Request("DisableStatuscombo") Is Nothing Then
    '        If Trim(Request("DisableStatuscombo") & "") = "1" Then blnDisableStatusCombo = True
    '    End If




    '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
    '        ' we'll get the request values from the database
    '        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
    '        If dr.Read Then
    '            m_intDiscussionThreadCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("DiscussionThreads"), "0"), Integer)
    '            lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FunctionID"), "0"), Long)

    '            'Added By SantoshK on 2nd Dec 2004
    '            'To Display requestID and Requestor in Edit Mode
    '            lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(dr("QueryID"), "0"), Long)
    '            strRequestor = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerID")), String)
    '            strRequestorName = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerName")), String)
    '            'Addition Ends

    '            'Added By SantoshK on 30th Nov 2004
    '            m_lngRequestTypeId = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0"), Long)
    '            lngRequestTypeIdOld = m_lngRequestTypeId
    '            'Addition Ends
    '            m_lngSubRequestTypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0"), Long)
    '            strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
    '            strSubject = dr("Subject").ToString
    '            'Added by PrashantSJ on 08 Nov 2006 for WhizibleSEM SP8 Build 1
    '            'Purpose: For storing Request Subject (which is passed to Flag tracker)
    '            m_strSubject = dr("Subject").ToString
    '            ' m_strSubject = m_strSubject.Replace("""", "&quot;")
    '            'End of addition by PrashantSJ on 08 Nov 2006

    '            strDescription = dr("Description").ToString
    '            intPriorityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("PriorityID"), "0"), Integer)
    '            If Not IsDBNull(dr("ExpectedResolvedDate")) Then
    '                strExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("ExpectedResolvedDate"), Date))
    '            End If
    '            If Not IsDBNull(dr("CRMExpectedResolvedDate")) Then
    '                strCRMExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("CRMExpectedResolvedDate"), Date))
    '            End If
    '            lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
    '            strComments = dr("Comments").ToString
    '            strReasonsForRejection = dr("ReasonsForRejection").ToString
    '            intStatusID = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusID"), "0"), Integer)
    '            lngTargetLocationID = CType(CommonFunctions.Data.CheckIsDBNull(dr("TargetLocationID"), "0"), Long)
    '            intFeedbackID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FeedbackID"), "0"), Integer)
    '            strFeedbackComments = dr("FeedbackComments").ToString

    '            ''Added by Manishk On 11th jan 06 to add deliverable textbox on helpdesk page
    '            m_strDeliverableID = dr("DeliverableID").ToString
    '            ''eND OF Added by Manishk On 11th jan 06 to add deliverable textbox on helpdesk page

    '            ' lets see if we can allow attachment deletion 
    '            If CType(CommonFunctions.Data.CheckIsDBNull(dr("IsAttachmentMandatory"), "0"), Boolean) And lngAssignTo <> 0 Then
    '                m_blnAllowAttachmentDeletion = False
    '            End If
    '            'Added by SrikanthY on 05 Jan 2007 To Get Values of Product,Components in Edit Mode
    '            m_ChangedProduct = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
    '            m_ChangedModule = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)
    '            m_ChangedProject = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectID"), "0"), Integer)
    '            'End of Addition by SrikanthY

    '            'Added by PrajaktaR on 17 Feb 2007 for WizibleSEM SP9 IssueID - 10295 to Disabling Status if marked as closed.
    '            intRequestStatus = intStatusID
    '            'End of Addition by PrajaktaR on 17 Feb 2007 for WizibleSEM SP9 IssueID - 10295 to Disabling Status if marked as closed.

    '            lngProductID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
    '            lngComponentID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)

    '        End If

    '        ' Added BY NitinVS on 9 Aug  2005 for WhizibleSEM SP4 IssueID 2
    '        m_lngStatusId = intStatusID
    '        ' End Addition BY NitinVS on 9 Aug  2005 for WhizibleSEM SP4 IssueID 2

    '        CommonFunctions.Data.DisposeDataReader(dr)
    '        blnDisableProductCombo = True
    '        blnDisableModuleCombo = True
    '        blnDisableFunctionCombo = True
    '        blnDisableSubRequestTypeCombo = True
    '        blnDisableSubRequestTypeCombo = True
    '        blnDisableProjectCombo = True
    '        If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
    '            blnDisbaledSubjectTextBox = True
    '        End If
    '        If UCase(Trim(m_strFromWhere & "")) = "AR" Then
    '            strGuidelinesColumnName = "GuidelinesForAssignee"
    '            blnReadOnlyComments = True
    '        ElseIf UCase(Trim(m_strFromWhere & "")) = "SR" Then
    '            strGuidelinesColumnName = "GuidelinesForRequestor"
    '        End If
    '        'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '        'Purpose: added one condition for My e-Dashboard (MD)
    '        'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
    '        If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
    '            'End of addition by PrashantSJ on 09 Nov 2006
    '            blnDisabledAssignToCombo = False
    '        Else
    '            blnDisabledAssignToCombo = True
    '        End If
    '    Else
    '        ' for "NEW" mode we'll use submitted values of form if any!
    '        If Trim(MyBase.GetFormValue("cboFunction") & "") <> "" Then
    '            lngFunctionID = CType(MyBase.GetFormValue("cboFunction"), Long)
    '        End If

    '        'Added By Santoshk on 1st Dec 2004
    '        'To Seperate TaskType and SubTaskType
    '        If CommonFunction.Application.SplitRequestTypeSubType = True Then
    '            If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
    '                m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
    '            End If
    '        End If
    '        'Addition Ends

    '        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
    '        If Trim(strSubrequestType & "") <> "" Then
    '            arr = Split(strSubrequestType, "|")
    '            If Trim(arr(0) & "") <> "" Then
    '                m_lngSubRequestTypeID = CType(arr(0), Long)
    '            End If
    '            'Added By JyotiG
    '            'Start_JG_9145_03-Jan-2007
    '            If CommonFunction.Application.SplitRequestTypeSubType = False Then
    '                If Trim(arr(1) & "") <> "" Then
    '                    m_lngRequestTypeId = CType(arr(1), Long)
    '                End If
    '            End If
    '            'End_JG_9145_03-Jan-2007

    '        End If
    '        'integrated by harshada d on 19092005 for issue id 295
    '        'Commented and Modified by ParagD on 14-Sept-2005
    '        'To avoid IssueID :21047 - Aspire
    '        'strSubject = Trim(MyBase.GetFormValue("txtSubject") & "")
    '        ' strDescription = Trim(MyBase.GetFormValue("txtDescription") & "")
    '        strSubject = Trim(Request.Form("txtSubject") & "")
    '        strDescription = Trim(Request.Form("txtDescription") & "")
    '        'Modification Ended by ParagD on 14-Sept-2005
    '        'end of integration by harshada d on 19092005 for issue id 295
    '        If Trim(MyBase.GetFormValue("cboPriority") & "") <> "" Then
    '            intPriorityID = CType(Trim(MyBase.GetFormValue("cboPriority") & ""), Integer)
    '        End If
    '        'SrikanthY on 08 Jan 2007 Added code to get the values of newly introduced drop downs
    '        If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
    '            m_ChangedModule = CType(Trim(MyBase.GetFormValue("cboModule")), Integer)
    '        End If
    '        If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
    '            m_ChangedProject = CType(Trim(MyBase.GetFormValue("cboProject")), Integer)
    '        End If
    '        If Trim(MyBase.GetFormValue("cboTargetLocation") & "") <> "" Then
    '            m_ChangedLocation = CType(Trim(MyBase.GetFormValue("cboTargetLocation")), Integer)
    '        End If
    '        'End of Addition By SriaknthY
    '        strExpectedResolvedDate = Trim(MyBase.GetFormValue("txtResolutionDate") & "")
    '        strCRMExpectedResolvedDate = Trim(MyBase.GetFormValue("txtCRMResolutionDate") & "")
    '        If Trim(MyBase.GetFormValue("cboAssignTo") & "") <> "" Then
    '            lngAssignTo = CType(Trim(MyBase.GetFormValue("cboAssignTo") & ""), Long)
    '        End If
    '        strComments = Trim(MyBase.GetFormValue("txtComments") & "")
    '        strReasonsForRejection = Trim(MyBase.GetFormValue("txtReasonsForRejection") & "")
    '        If Trim(MyBase.GetFormValue("cboStatus") & "") <> "" Then
    '            intStatusID = CType(Trim(MyBase.GetFormValue("cboStatus") & ""), Integer)
    '        End If
    '        lngTargetLocationID = GetEmployeeDepartment(m_lngEmployeeID)
    '        If Trim(MyBase.GetFormValue("cboFeedback") & "") <> "" Then
    '            intFeedbackID = CType(Trim(MyBase.GetFormValue("cboFeedback") & ""), Integer)
    '        End If
    '        strGuidelinesColumnName = "GuidelinesForRequestor"
    '        strFeedbackComments = Trim(MyBase.GetFormValue("txtFeedbackComments") & "")
    '    End If

    '    ' set the captions for the page
    '    Call SetCaptions()

    '    ' start the page
    '    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

    '    MyBase.InitializeResources("AppResources.CRM_RequestDetail", "AppResources")


    '    With Response

    '        ' menu
    '        .Write(strMenu)
    '        ' Modified By NitinVS on 9 Feb 2005 
    '        ' Displayed the Legends after Menu 
    '        'page legend
    '        strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
    '        '.Write(strLegend)
    '        ' End Addition By NitinVS on 9 Feb 2005 

    '        If UCase(Trim(m_strMode & "")) = "NEW" Then
    '            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_NEW_REQUEST")))
    '            .Write("<div id=divList style='overflow:auto;height:99.9%; width:99.9%'>")
    '        Else
    '            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_REQUEST_DETAILS")))
    '            .Write("<div id=divList style='overflow:auto;height:80%; width:99.9%'>")
    '        End If



    '        .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
    '        'Added By SantoshK on 2nd Dec 2004
    '        'Displaying RequestID and Requestor in Edit Mode
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
    '            'Request ID
    '            .Write("<TR class=clsTREven>")
    '            .Write("<TD align=right> Request ID </TD>")
    '            .Write("<TD>")

    '            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    '            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
    '            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    '            CommonFunctions.HTMLControls.DrawTextBox("txtRequestID", "txtRequestID", , , , lngRequestID.ToString, , , True, , , , , , True)
    '            '----------------------------------------------------------------------------------------------
    '            'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    '            'Added by SavitaS on 24 Nov 2005 to add a link "Move this request to another Department" 
    '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '            'Purpose: added one condition for My e-Dashboard (MD)
    '            'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
    '            If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
    '                'End of addition by PrashantSJ on 09 Nov 2006
    '                ' added by harshada d on 03 Feb 2006 for helpdesk Enhancements 
    '                Dim drIsTaskCreated As IDataReader
    '                Dim drAssignTo As IDataReader
    '                Dim strSQLIsTaskCreated As String

    '                strSQLIsTaskCreated = "select TaskID from tbl_pm_projectTasks where CRMQueryID = " & lngRequestID.ToString
    '                strSQLIsTaskCreated += " union all select IssueID from tbl_IB_issue where CRMQueryID = " & lngRequestID.ToString
    '                strSQLIsTaskCreated += " union all select DeliverableID from tbl_CRM_Query_Master where DeliverableID IS NOT NULL and QueryID = " & lngRequestID.ToString
    '                strSQLIsTaskCreated += " union all select AssignTo from tbl_CRM_Query_Master where AssignTo IS NOT NULL and AssignTo <> 0 and QueryID = " & lngRequestID.ToString
    '                'End Modification by SavitaS
    '                drIsTaskCreated = CommonFunctions.Data.GetDataReader(strSQLIsTaskCreated, m_blnUseSQL)
    '                Dim strIsTaskCreated As String
    '                If drIsTaskCreated.Read Then
    '                    strIsTaskCreated = CommonFunctions.Data.CheckIsDBNull(drIsTaskCreated("TaskID"), "0").ToString
    '                End If
    '                If Not strIsTaskCreated Is Nothing Then
    '                    If strIsTaskCreated = "0" Or strIsTaskCreated = "" Then
    '                        intIsTask_IssueCreated = 0
    '                    Else
    '                        intIsTask_IssueCreated = 1
    '                    End If
    '                End If

    '                CommonFunctions.Data.DisposeDataReader(drIsTaskCreated)
    '                'Added by Manishk on 25th Feb 06 For SP 6 issue
    '                Dim drForHrm As IDataReader
    '                Dim strSQLQuery As String
    '                Dim lngCRMID As Long = 0

    '                'strSQLQuery = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
    '                'drForHrm = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
    '                'If drForHrm.Read Then
    '                '    lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(drForHrm("EmployeeID"), "0"), Long)
    '                'End If
    '                'CommonFunctions.Data.DisposeDataReader(drForHrm)

    '                strSQLQuery = " SELECT CRMID FROM tbl_CRM_Function_CRMS Where CRMID = " & m_lngEmployeeID & " and FUNCTIONID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & lngRequestID.ToString & ")"
    '                strSQLQuery += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID & " and DepartmentID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & lngRequestID.ToString & ")"
    '                drForHrm = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
    '                If drForHrm.Read Then
    '                    lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(drForHrm("CRMID"), "0"), Long)
    '                End If
    '                CommonFunctions.Data.DisposeDataReader(drForHrm)

    '                If lngCRMID <> 0 Then
    '                    'end of addition by harshada d on  03 Feb 2006 for helpdesk enhancements
    '                    .Write("<font face=verdana;Arial size=1><A href='JavaScript:MoveToDept_OnClick()'><B>Move this request to another Department</B></A></font>")
    '                    'End If
    '                    'End Modification
    '                Else
    '                    .Write("Move this request to another Department")
    '                End If
    '                'End Added by Manishk on 25th Feb 06 For SP 6 issue

    '            End If
    '            'End Addition
    '            'End Integration by SavitaS 
    '            '-------------------------------------------------------------------------------------------
    '            .Write("</TD>")
    '            .Write("</TR>")
    '            'Requestor
    '            .Write("<TR class=clsTREven>")
    '            .Write("<TD align=right> Requestor </TD>")
    '            .Write("<TD>")
    '            CommonFunctions.HTMLControls.DrawTextBox("txtRequestor", "txtRequestor", , , , strRequestor, , , True, , , , , , True)
    '            .Write("</TD>")
    '            .Write("</TR>")
    '        End If
    '        'Addition Ends

    '        '---------------------------------------------------------------------------
    '        'Modified by SavitaS on 08 Jan 2006 for IssueID 1936
    '        If UCase(Trim(m_strMode & "")) = "NEW" Then
    '            If UCase(Trim(m_strFromWhere & "")) = "SR" Then
    '                'If m_strLoginType <> "E" Or m_intCustomer <> 0 Then 'Or m_strVal <> "I" 
    '                'Added by SrikanthY on 21 Dec 2006 To Display Departments according to Requested Employee
    '                If m_strLoginType <> "E" Or m_intCustomer <> 0 Or m_intRequestedEmployee <> 0 Then 'Or m_strVal <> "I" 
    '                    'End Modification by SavitaS
    '                    'added by harshada d on 07 feb 2006 for helpdesk enhancements
    '                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
    '                        strSQLCustomerName = "select CustomerName from tbl_pm_customer where Customer=" & CType(HttpContext.Current.Session("Customer"), Long)
    '                        drCustomerName = CommonFunctions.Data.GetDataReader(strSQLCustomerName, m_blnUseSQL)
    '                        If drCustomerName.Read Then
    '                            strCustomerName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomerName("CustomerName"), "0"), String)
    '                        End If
    '                        CommonFunctions.Data.DisposeDataReader(drCustomerName)
    '                        .Write("<b>")
    '                        .Write("<TR class=clsTREven align=center width='99.9%'> <FONT color=blue>" & MyBase.GetResourceString("CAPTION_ON_BEHALF_OFCUSTOMER") & strCustomerName & "</FONT> ")
    '                        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    '                        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
    '                        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    '                        .Write("</TR>")
    '                        .Write("</b>")
    '                        'Added By SrikanthY on 29 Dec 2006 For the New faeture to Add Requests on behalf of employees.
    '                    ElseIf m_intRequestedEmployee <> 0 Then
    '                        .Write("<b>")
    '                        .Write("<TR class=clsTREven align=center width='99.9%'> <FONT color=blue>" & "You are adding Request on behalf of Employee :" & m_strRequestedEmployee & "</FONT> ")
    '                        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
    '                        .Write("</TR>")
    '                        .Write("</b>")
    '                        'End of Addition by SrikanthY

    '                    End If
    '                End If
    '            Else
    '                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    '                CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
    '                '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    '            End If
    '        End If
    '        'end addition by harshada d
    '        '-----------------------------------------------------------------

    '        ' function
    '        .Write("<tr class=clsTREven>")
    '        .Write("<td  align=right width='30%'>" & m_strFunction_Caption & "</td>")
    '        .Write("<td  width='70%'>")
    '        '----------------------------------------------------------------------------------------------
    '        'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    '        'Integrated by SavitaS on 20 dec 2005 to show customers only those depts which are made accessible to them for IssueID 1936
    '        'added by harshada d on 19 Dec 2005 for Helpdesk
    '        'If (m_strVal <> "I") Or (Session("intPostID").ToString = "23") Then  'Commented by SavitaS on 30 Jan 2006 
    '        Dim strSQLRole As String
    '        Dim drRole As IDataReader
    '        Dim lngPostID As Long = 0
    '        ' to take postid of the employee at corporate level not from session
    '        drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
    '        If drRole.Read Then
    '            lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
    '        End If
    '        CommonFunctions.Data.DisposeDataReader(drRole)
    '        If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
    '            strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
    '            strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
    '            'strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where  "
    '        Else
    '            ' modified by harshada d for issue id 1936 for Whiziblesem 6.0 for helpdesk enhancements 
    '            ' strSQL = "usp_CRM_GetFunctions_ForRole " & Session("intPostID").ToString
    '            strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
    '            ' modified by harshada d for issue id 1936 for Whiziblesem 6.0 for helpdesk enhancements 
    '        End If
    '        'End Integration by SavitaS on 20 dec 2005
    '        'End Integration
    '        'commented by harshada d for whiziblesem 6.0 issue id 1936
    '        'If lngFunctionID = 0 Then
    '        '    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
    '        '    If dr.Read Then lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("DepartmentID"), "0"), Long)
    '        '    CommonFunctions.Data.DisposeDataReader(dr)
    '        'End If
    '        'end of commentation by harshada d for whiziblesem 6.0 issue id 1936
    '        If blnDisableFunctionCombo Then
    '            '----------------------------------------------------------------------------------------------
    '            'Commented and Added by SavitaS on 21 Dec 2005 for IssueID 1936
    '            'added by SachinR   on 14 Dec 2005
    '            If m_strLoginType <> "C" Then
    '                If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
    '                    strSQL += "," + lngRequestID.ToString
    '                End If
    '            End If
    '            CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, 0, lngFunctionID.ToString, " disabled ", True, , , True)
    '        Else
    '            If m_strLoginType <> "E" Then
    '                CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", 0, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, , , True)
    '            Else
    '                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
    '                    CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", 0, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, , , True)
    '                Else
    '                    'End Addition by SavitaS
    '                    CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, 0, lngFunctionID.ToString, "onchange=javascript:cboFunction_OnChange()", True, , , True)
    '                End If

    '            End If
    '            'End Integration by SavitaS
    '            '-------------------------------------------------------------------------------------------
    '        End If
    '        .Write("</td>")
    '        .Write("</tr>")

    '        '----------------------------------------------------------------------------
    '        'Integrated by SavitaS on 21 Dec 2005 for whiz2->Help Desk (IssueID 1936)
    '        'Added by SavitaS on 21 Nov 2005 for WhiziblesemSP4 enhancement
    '        'Purpose: To allow resources to change Request and SubRequestType in edit mode 
    '        'if that resource come under "Configuration->Department Master->Configure HRMs" tab

    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then

    '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '            'Purpose: added one condition for My e-Dashboard (MD)
    '            'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
    '            If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
    '                'End of addition by PrashantSJ on 09 Nov 2006

    '                strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
    '                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
    '                If dr.Read Then
    '                    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
    '                End If
    '                CommonFunction.Data.DisposeDataReader(dr)
    '                If m_lngCRMID <> 0 Then

    '                    blnDisableSubRequestTypeCombo = False 'To enable Request and Sub Request Type Combo

    '                    If CommonFunction.Application.SplitRequestTypeSubType = True Then
    '                        'To select matchfield for RequestType combo when SplitRequestTypeSubType is true
    '                        If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
    '                            m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
    '                        Else

    '                        End If

    '                        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
    '                        If Trim(strSubrequestType & "") <> "" Then
    '                            arr = Split(strSubrequestType, "|")
    '                            If Trim(arr(0) & "") <> "" Then
    '                                m_lngSubRequestTypeID = CType(arr(0), Long)
    '                            End If
    '                        End If
    '                        'Added by SavitaS on 16 Dec 2005 for IssueID 1936 to select matchfield for RequestType combo when SplitRequestTypeSubType is false 
    '                    Else
    '                        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
    '                        If Trim(strSubrequestType & "") = "" Then
    '                            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
    '                            If dr.Read Then
    '                                strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
    '                            End If
    '                            CommonFunction.Data.DisposeDataReader(dr)
    '                        End If
    '                        'End Addition by SavitaS on 16 Dec 2005
    '                    End If
    '                    'Added by Harshada D for whizible 6.0 helpdesk enhancements issue id 1936
    '                    ' if the person is non -HRM and has access to E= dashboard then the user is not allowed to change the assign to 
    '                Else
    '                    blnDisabledAssignToCombo = True
    '                    'end of Addition by Harshada D for whizible 6.0 helpdesk enhancements issue id 1936
    '                End If
    '            End If
    '        End If

    '        'End Addition by SavitaS for WhiziblesemSP4 enhancement
    '        'End Integration
    '        '----------------------------------------------------------------------------

    '        'Added By SantoshK on 30th Nov 2004
    '        'Seperate Request Type and SubRequest Type
    '        'request type
    '        'function Name need to be changed
    '        'if Applcation Variable is SET

    '        'Commented and Added by SavitaS on 21 Dec 2005 for IssueID 1936
    '        '--------------------------------------------------------------------------------------
    '        'If CommonFunction.Application.SplitRequestTypeSubType = True Then
    '        '.Write("<tr class=clsTREven>")
    '        '.Write("<td  align=right width='30%'> Request Type </td>")
    '        '.Write("<td  width='70%'>")

    '        ''added by  shubhadal
    '        'If (m_strLoginType = "C") Then
    '        '    lngFunctionID = 22
    '        'End If
    '        ''ended by  shubhadal

    '        'strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0"
    '        '' Modified By NitinVS on 13 Sep 2005 for CSL Customization IssueId 73 
    '        '' used seperate Bln Variable for Request Type and Sub Request Type 
    '        ''If blnDisableSubRequestTypeCombo Then
    '        'If blnDisableRequestTypeCombo Then
    '        '    ' end Modification By NitinVS on 13 Sep 2005 for CSL Customization IssueId 73 
    '        '    'ShubhadaL

    '        '    If (m_strLoginType = "C") Then
    '        '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, "28", " disabled ", True, , , True)
    '        '        'end by ShubhadaL
    '        '    Else
    '        '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, m_lngRequestTypeId.ToString, " disabled ", True, , , True)
    '        '    End If
    '        'Else
    '        '    'shubhadal
    '        '    If (m_strLoginType = "C") Then
    '        '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, "28", " disabled ", True, , , True)
    '        '        'end by ShubhadaL
    '        '    Else
    '        '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
    '        '    End If
    '        'End If

    '        '    'sub requst type
    '        '    .Write("<tr class=clsTREven>")
    '        '    .Write("<td  align=right width='30%'> " & m_strSubRequestType_Caption & " </td>")
    '        '    .Write("<td  width='70%'>")
    '        '    'added by shubhadal
    '        '    If (m_strLoginType = "C") Then
    '        '        lngFunctionID = 22
    '        '        m_lngRequestTypeId = 28
    '        '    End If
    '        '    'ended by shubhadal
    '        '    strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString)
    '        '    If blnDisableSubRequestTypeCombo Then
    '        '        'ShubhadaL
    '        '        If (m_strLoginType = "C") Then
    '        '            If m_lngSubRequestTypeID <> 101 Then
    '        '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, m_lngSubRequestTypeID.ToString, " disabled ", True, , , True)
    '        '            Else
    '        '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)
    '        '            End If

    '        '        Else 'end by ShubhadaL
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, m_lngSubRequestTypeID.ToString, " disabled ", True, , , True)
    '        '        End If
    '        '    Else
    '        '        'ShubhadaL
    '        '        If (m_strLoginType = "C") Then
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)
    '        '        Else 'End by ShubhadaL
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
    '        '        End If
    '        '    End If
    '        'Else
    '        '    'sub requst type
    '        '    .Write("<tr class=clsTREven>")
    '        '    .Write("<td  align=right width='30%'> Request Type </td>")
    '        '    .Write("<td  width='70%'>")
    '        '    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0"
    '        '    If blnDisableSubRequestTypeCombo Then
    '        '        'ShubhadaL
    '        '        If (m_strLoginType = "C") Then
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)

    '        '        Else 'end by ShubhadaL
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, strSubrequestType, " disabled ", True, , , True)
    '        '        End If
    '        '    Else
    '        '        'ShubhadaL
    '        '        If (m_strLoginType = "C") Then
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)
    '        '        Else 'End by ShubhadaL
    '        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
    '        '        End If
    '        '    End If 'ShubhadaL
    '        ' End If

    '        'Modification By NitinVS on 7 Mar 2007 for WhizibleSEM SP8 Regression Issue 11098
    '        'Set the width of Request Type,Sub Request Type to 300

    '        If CommonFunction.Application.SplitRequestTypeSubType = True Then

    '            .Write("<tr class=clsTREven>")
    '            .Write("<td  align=right width='30%'> Request Type </td>")
    '            .Write("<td  width='70%'>")

    '            If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
    '                strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
    '                strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
    '                strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
    '                strSQL += "  and RoleID =23 AND functionID = " & lngFunctionID
    '            Else
    '                'Modifed BY NitinVS on 16 MAr 2007 for WhizibleSEM SP Regression Issue 11342
    '                ' To Show existing Request type evenif the logged in role does not have access to it. 
    '                ' sub Request Type ID parameter added by harshada d for Whiziblesem 6.0 helpdesk enhancemnts issue id 1936
    '                strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
    '                ' sub Request Type ID parameter by harshada d for Whiziblesem 6.0 helpdesk enhancemnts issue id 1936
    '                'End Modifed BY NitinVS on 16 MAr 2007 for WhizibleSEM SP Regression Issue 11342
    '            End If


    '            If blnDisableSubRequestTypeCombo Then
    '                CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 300, m_lngRequestTypeId.ToString, " disabled ", True, , , True)
    '            Else
    '                CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 300, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
    '            End If
    '            'Amit
    '            'If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
    '            'm_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
    '            'Else

    '            'End If
    '            'Sub Requst Type
    '            .Write("<tr class=clsTREven>")
    '            .Write("<td  align=right width='30%'> " & m_strSubRequestType_Caption & " </td>")
    '            .Write("<td  width='70%'>")

    '            If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
    '                'commented by harshada d for whiziblesem 6 helpdesk issue id 1936 : as we provide the default values for function id and request type the following code is not necessary

    '                'If Trim(MyBase.GetFormValue("cboFunction") & "") = "" Then
    '                '    If lngFunctionID = 0 Then
    '                '        m_lngRequestTypeId = 0
    '                '    End If
    '                'End If

    '                'If Trim(MyBase.GetFormValue("cboRequestType") & "") = "" Then
    '                '    m_lngRequestTypeId = 0
    '                'End If
    '                ' end of commentation of harshada D


    '                strSQL = " select tbl_CRM_RequestType_SubRequestType.SubRequestTypeID ,tbl_CRM_SubRequestType.SubRequestType "
    '                strSQL += " from  tbl_CRM_RequestType_SubRequestType, tbl_CRM_SubRequestType  where "
    '                strSQL += " tbl_CRM_RequestType_SubRequestType.subRequestTypeID = tbl_CRM_SubRequestType.SubRequestTypeID "
    '                strSQL += " and tbl_CRM_RequestType_SubRequestType.RequestTypeID = " & m_lngRequestTypeId.ToString
    '            Else
    '                'Modified by SrikanthY on 15 Jan 2007 For issue 9442
    '                If m_intRequestedEmployee <> 0 Then
    '                    strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
    '                Else
    '                    strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
    '                End If
    '                'End of modification by SrikanthY

    '            End If
    '            If blnDisableSubRequestTypeCombo Then
    '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 300, m_lngSubRequestTypeID.ToString, " disabled ", True, , , True)
    '            Else
    '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 300, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
    '            End If
    '        Else
    '            'Sub Requst Type
    '            .Write("<tr class=clsTREven>")
    '            .Write("<td  align=right width='30%'> Request Type </td>")
    '            .Write("<td  width='70%'>")
    '            If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
    '                strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",null,'C',0"
    '            Else
    '                'Modified by SrikanthY on 15 Jan 2007 For issue 9442
    '                If m_intRequestedEmployee <> 0 Then
    '                    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
    '                Else
    '                    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
    '                End If
    '                'End of modification by SrikanthY
    '            End If
    '            ' this code is added by harshada d for whiziblesem 6.0 for helpdesk enhancements 1936
    '            ' if the combo should persist the value selected in the combo
    '            '''''''''''''''''''''' ***************************
    '            If Not Page.IsPostBack Then
    '                If CommonFunction.Application.SplitRequestTypeSubType = False Then
    '                    strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
    '                End If
    '                ''''''''''''''''''''''''''''''''''''''***************************
    '            End If

    '            If blnDisableSubRequestTypeCombo Then
    '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 300, strSubrequestType, " disabled ", True, , , True)
    '            Else
    '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 300, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
    '            End If

    '        End If

    '        'Set the width of Request Type,Sub Request Type to 300
    '        ' End Modification By NitinVS on 7 Mar 2007 for WhizibleSEM SP8 Regression Issue 11098


    '        '-----------------------------------------------------------------------------------------
    '        'Template
    '        If m_lngSubRequestTypeID <> 0 Then
    '            strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
    '            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
    '            If dr.Read Then
    '                intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
    '                Select Case intTemplateCount
    '                    Case 0 ' no templates
    '                        ' Commented by MonikaI on 14th Jul 2009 
    '                        ' RequestID 21655 Not able to download template attached with sub type if File server is different.
    '                        'Case 1 ' only one template
    '                        '    .Write("<font face=verdana;Arial size=1>")
    '                        '    .Write("<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateID"), "0"), Long)) & "' >" & vbCrLf)
    '                        '    .Write("<B>View Template</B>")
    '                        '    .Write("</A></font>")
    '                        ' End of modification by MonikaI on 14th Jul 2009
    '                    Case Else ' multiple templates
    '                        .Write("<font face=verdana;Arial size=1><A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><B> View Templates</B></A></font>")
    '                End Select
    '            End If
    '            CommonFunctions.Data.DisposeDataReader(dr)
    '        End If
    '        .Write("</td>")
    '        .Write("</tr>")

    '        ' Guidelines
    '        'added for Helpdesk Enhancements whizible 6.0 Issue ID 1936
    '        If UCase(Trim(m_strFromWhere & "")) <> "DB" Then
    '            'end of added for Helpdesk Enhancements whizible 6.0 Issue ID 1936
    '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '            'Purpose: added one condition for My e-Dashboard (MD)
    '            If UCase(Trim(m_strFromWhere & "")) <> "MD" Then
    '                'End of addition by PrashantSJ on 09 Nov 2006
    '                If Trim(m_lngSubRequestTypeID & "") <> "" Then
    '                    dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & m_lngSubRequestTypeID, m_blnUseSQL)
    '                    If dr.Read Then
    '                        If Trim(dr(strGuidelinesColumnName).ToString & "") <> "" Then
    '                            .Write("<TR class=clsTREven><td  align=right VAlign=Top>")
    '                            .Write(GetCaption(919, strGuidelinesColumnName))
    '                            .Write("</td>")
    '                            .Write("<td  VAlign=Top><PRE>")
    '                            .Write(dr(strGuidelinesColumnName).ToString & "</PRE>")
    '                            .Write("</td></tr>")
    '                        End If
    '                    End If
    '                    CommonFunction.Data.DisposeDataReader(dr)
    '                End If
    '                'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '                'Purpose: added one condition for My e-Dashboard (MD)
    '            End If
    '            'End of addition by PrashantSJ on 09 Nov 2006
    '        End If

    '        ' subject
    '        .Write("<TR class=clsTREven>")
    '        .Write("<TD align=right>" & m_strSubject_Caption & "</TD>")
    '        .Write("<TD>")
    '        CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 400, 100, strSubject, , , blnDisbaledSubjectTextBox, , , , , , True)
    '        .Write("</TD>")
    '        .Write("</TR>")

    '        ' Description
    '        .Write("<TR class=clsTREven>")
    '        .Write("<TD align=right vAlign=top>" & m_strDescription_Caption & "</TD>")
    '        .Write("<TD>")
    '        'Modified By ShraddhaM on 27 July 2006
    '        CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , 400, 100, , strDescription, , , , , , , , , , , , , , , "Soft", )
    '        .Write("</TD>")
    '        .Write("</TR>")

    '        ' priority
    '        .Write("<TR class=clsTREven>")
    '        .Write("<TD align=right>" & m_strPriority_Caption & "</TD>")
    '        .Write("<TD>")
    '        strSQL = "usp_CRM_Get_RequestPriority"
    '        'Modified By NitinVs on 13 Mar 2007 for WhizibleSEM SP 8 Issue 11168 
    '        'Priority added a blank row so in add new mode will not be defaulted for first time.
    '        CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, 0, intPriorityID.ToString, , True, , , True)
    '        'end Modification By nitinVS on 13 Mar 2007 for WhizibleSEM SP 8 Issue 11168 
    '        .Write("</TD>")
    '        .Write("</TR>")
    '        '''''''''''''''''


    '        '''shraddha 23June
    '        '.Write("<TR>")
    '        '.Write("<TD>")
    '        'CommonFunction.HTMLControls.DrawTextArea("txtFilterHidden", "txtFilterHidden", , , , "frmRequestDetails", , , 100, 100, , strFilter, , , , , , True, , , , , , , , , , )
    '        '.Write("</TD>")
    '        '.Write("<TD>")
    '        'CommonFunction.HTMLControls.DrawTextArea("txtDepartmentHidden", "txtDepartmentHidden", , , , "frmRequestDetails", , , 100, 100, , strDept, , , , , , True, , , , , , , , , , )
    '        '.Write("</TD>")
    '        '.Write("<TD>")
    '        'CommonFunction.HTMLControls.DrawTextArea("txtStatusHidden", "txtStatusHidden", , , , "frmRequestDetails", , , 100, 100, , strStatus, , , , , , True, , , , , , , , , , )
    '        '.Write("</TD>")
    '        '.Write("</TR>")
    '        ''Ended shraddha
    '        ' Exp. resolution date
    '        '----------------------------------------------------------------------------------------------
    '        'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    '        'added by Shubhadal
    '        'If (m_strLoginType <> "C") Then
    '        'Modified by SavitaS on 19 Dec 2005 to show Exp. Resolved Date in edit mode for IssueID 1936
    '        '===========================================================================
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then

    '            If m_strLoginType <> "C" Then
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
    '                .Write("<TD>")

    '                'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
    '                If UCase(Trim(m_strFromWhere & "")) = "AR" Then
    '                    ' an assignee can see the date as read-only
    '                    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)
    '                    .Write("</TD>")
    '                    .Write("</TR>")
    '                Else
    '                    ' admin/requestor ofcourse can change the date
    '                    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
    '                    .Write("</TD>")
    '                    .Write("</TR>")
    '                End If
    '            End If
    '        End If
    '        'End Modification by SavitaS on 19 Dec 2005
    '        '===========================================================================
    '        '----------------------------------------------------------------------------------------------
    '        'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    '        If UCase(Trim(m_strMode & "")) = "NEW" Then
    '            If m_strLoginType <> "C" And m_strVal <> "C" Then
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
    '                .Write("<TD>")
    '            End If
    '            'End If 'statement added by ShubhadaL

    '            'If UCase(Trim(m_strFromWhere & "")) = "AR" Then
    '            '    'added by ShubhadaL
    '            '    If (m_strLoginType = "C") Then

    '            '        CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , CommonFunctions.Dates.GetDate(Now()).ToString, , "frmRequestDetails", , , , , True, , , True, , , True)
    '            '        'end of addition by shubhadal
    '            '    Else
    '            '        ' an assignee can see the date as read-only
    '            '        CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)

    '            '    End If
    '            'Else
    '            '    ''added by ShubhadaL
    '            '    'If (m_strLoginType = "C") Then
    '            '    '    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , CommonFunctions.Dates.GetDate(Now()).ToString, , "frmRequestDetails", , , , , , , , True, , , True)
    '            '    'Else 'addition ends

    '            '    ' admin/requestor ofcourse can change the date
    '            '    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
    '            'End If
    '            'End If 'statement added by shubhadal
    '            'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
    '            If UCase(Trim(m_strFromWhere & "")) = "AR" Then
    '                ' an assignee can see the date as read-only
    '                CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)
    '                .Write("</TD>")
    '                .Write("</TR>")
    '            Else
    '                If m_strLoginType <> "C" And m_strVal <> "C" Then
    '                    ' admin/requestor ofcourse can change the date
    '                    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
    '                    .Write("</TD>")
    '                    .Write("</TR>")
    '                End If
    '            End If
    '        End If

    '        'End Integration
    '        '-------------------------------------------------------------------------------------------
    '        ' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old ResolutionDate
    '        CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True)
    '        ' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 
    '        '----------------------------------------------------------------------------------------------
    '        'Commented by by SavitaS on 21 Dec 2005 for IssueID 1936
    '        '.Write("</TD>")
    '        '.Write("</TR>")
    '        'End Commnet

    '        ' hidden dates
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
    '        'next two lines commeny=ted by ShubhadaL
    '        'CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, strExpectedResolvedDate, , , , , , True, , )
    '        'CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, strCRMExpectedResolvedDate, , , , , , True, , )
    '        'added by ShubhadaL
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , )
    '        'end of addition
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
    '            ' Exp. resolution date
    '            'added by ShubhadaL
    '            If (m_strLoginType <> "C") Then
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right>" & m_strCRMExpectedResolvedDate_Caption & "</TD>")
    '                .Write("<TD>")
    '            End If 'statement added by ShubhadaL
    '            '----------------------------------------------------------------------------------------------
    '            'Commented by by SavitaS on 21 Dec 2005 for IssueID 1936

    '            'If UCase(Trim(m_strFromWhere & "")) = "DB" Then
    '            '    'added by ShubhadaL
    '            '    If (m_strLoginType = "C") Then
    '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , , , , , , , , True)
    '            '        'addition ended
    '            '    Else
    '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails")
    '            '    End If
    '            'Else
    '            '    'added by ShubhadaL
    '            '    If (m_strLoginType = "C") Then
    '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True, , , , , , , True)
    '            '    Else 'addition ended
    '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True)
    '            '    End If
    '            '    .Write("</TD>")
    '            '    .Write("</TR>")
    '            'End If
    '            'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
    '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '            'Purpose: added one condition for My e-Dashboard (MD)
    '            'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
    '            If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
    '                'End of addition by PrashantSJ on 09 Nov 2006
    '                CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails")
    '                .Write("</TD>")
    '                .Write("</TR>")
    '            Else
    '                If m_strLoginType <> "C" Then
    '                    CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True)
    '                    .Write("</TD>")
    '                    .Write("</TR>")
    '                End If
    '            End If
    '            '.Write("</TD>")
    '            '.Write("</TR>")
    '            'End Integration
    '            '-------------------------------------------------------------------------------------------
    '        End If
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
    '            ' Assign TO
    '            If (m_strLoginType <> "C") Then ' addition by ShubhadaL
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right>" & m_strAssignTo_Caption & "</TD>")
    '                .Write("<TD>")
    '            End If 'statement added by shubhadal
    '            'modfied by harshada d for whiziblesem 6.0 for helodesk enhancements for issue id 1936 on 08 March 2006
    '            'strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",1," & lngAssignTo.ToString
    '            strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
    '            'end of modfied by harshada d for whiziblesem 6.0 for helodesk enhancements for issue id 1936 on 08 March 2006
    '            If blnDisabledAssignToCombo Then
    '                ' added by ShubhadaL
    '                If (m_strLoginType = "C") Then 'end of addition by ShubhadaL
    '                    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, 0, lngAssignTo.ToString, " disabled ", True, , , , , True)
    '                Else 'end of addition
    '                    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, 0, lngAssignTo.ToString, " disabled ", True)
    '                End If 'statement added  by ShubhadaL
    '                ' Modified By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old AssignTO & CSL ISssueID 79
    '                CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True)
    '                ' End Modification By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL ISssueID 79
    '            Else
    '                ' added by ShubhadaL
    '                If (m_strLoginType = "C") Then
    '                    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, 0, lngAssignTo.ToString, , True, , , , , True)
    '                    'end of addition by ShubhadaL

    '                Else

    '                    CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, 0, lngAssignTo.ToString, , True)
    '                End If
    '                'added by harshada d for whiziblesem 6 helpdesk enhancements issue ID 1936
    '                .Write("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
    '                'end of addition by harshada d for whiziblesem 6 for helpdesk enhancements issue ID 1936


    '                ' added by ShubhadaL
    '                '      If (m_strLoginType = "C") Then
    '                '     CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, , , , , , , , , , , , True)
    '                '    Else
    '                ' Modified By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old AssignTO & CSL ISssueID 79
    '                CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True)
    '                ' End Modification By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL ISssueID 79
    '                'End If 'added by Shubhadal
    '                CommonFunction.HTMLControls.DrawTextBox("txtSubmittedDate", "txtSubmittedDate", , , , lngAssignTo.ToString, DisplayNone:=True)
    '                .Write("</TD>")
    '                .Write("</TR>")
    '            End If 'statement added by ShubhadaL
    '            Select Case UCase(Trim(m_strFromWhere & ""))
    '                'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '                'Purpose: added one condition for My e-Dashboard (MD)
    '                'Case "DB", "AR"
    '                Case "DB", "AR", "MD"
    '                    'End of addition by PrashantSJ on 09 Nov 2006
    '                    ' CRM Comments
    '                    ' added by ShubhadaL
    '                    If (m_strLoginType <> "C") Then
    '                        .Write("<TR class=clsTREven>")
    '                        .Write("<TD align=right vAlign=top>" & m_strComments_Caption & "</TD>")
    '                        .Write("<TD >")
    '                    End If 'statement  by ShubhadaL

    '                    'added by ShubhadaL
    '                    If (m_strLoginType = "C") Then
    '                        'Modified By ShraddhaM on 27 July 2006
    '                        CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , 400, 100, , strComments, , , , blnReadOnlyComments, , , , , , , , , , True, "Soft", )
    '                    Else
    '                        'Modified By ShraddhaM on 27 July 2006
    '                        CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , 400, 100, , strComments, , , True, blnReadOnlyComments, , , , , , , , , , , "Soft", )
    '                    End If
    '                    .Write("</TD>")
    '                    .Write("</TR>")

    '                    'Modifed By nitinVS on 14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 
    '                    'To Persist value for  Reason for rejection when saved 

    '                    CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , , , , , , , True, "Soft", )

    '                    'End Modification BY nitinVs on  14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 

    '                Case "SR"
    '                    'Modifed By nitinVS on 14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 
    '                    'To Persist value for Comments when saved 

    '                    CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , 400, 100, , strComments, , , , blnReadOnlyComments, , , , , , , , , , True, "Soft", )

    '                    'End Modification BY nitinVs on  14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 
    '                    If intStatusID = 7 Then
    '                        ' Reasons for rejection
    '                        If (m_strLoginType <> "C") Then 'Statement added by Shubhadal
    '                            .Write("<TR class=clsTREven>")
    '                            .Write("<TD align=right vAlign=top>" & m_strReasonsForRejection_Caption & "</TD>")
    '                            .Write("<TD>")
    '                        End If 'Statement added by Shubhadal
    '                        'added by ShubhadaL
    '                        If (m_strLoginType = "C") Then
    '                            'Modified By ShraddhaM on 27 July 2006
    '                            CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , , , , , , , True, "Soft", )
    '                        Else
    '                            'Modified By ShraddhaM on 27 July 2006
    '                            CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , , , , , , , , , , , , "Soft", )
    '                            .Write("</TD>")
    '                            .Write("</TR>")
    '                        End If
    '                    End If 'statement added by Shubhadal


    '            End Select

    '            ' Status
    '            .Write("<TR class=clsTREven>")
    '            .Write("<TD align=right>" & m_strStatus_Caption & "</TD>")
    '            .Write("<TD>")
    '            strSQL = "usp_CRM_Get_RequestStatus"
    '            If blnDisableStatusCombo Then
    '                CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, 0, , " disabled ", , , , True)
    '            Else
    '                CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, 0, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , , , True)
    '            End If
    '            If intStatusID = 7 Then
    '                CommonFunctions.General.WriteHTML("<b><a href='javascript:ViewRejectionComments_OnClick()'>View Comments</a><b>")
    '            End If

    '            ' Modified By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 to store old status & CSL IssueID 79
    '            CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True)
    '            ' End Modification By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2  & CSL IssueID 79


    '            .Write("</TD>")
    '            .Write("</TR>")
    '        End If

    '        'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
    '        'Code Added By PradipK for Help Desk SLA 
    '        '18 May 2006
    '        Dim h As Integer
    '        Dim m As Integer
    '        'integreated by harshada d for whiziblesem sp7
    '        Dim strHour As String
    '        Dim strMinute As String
    '        'Addded By Amit J For PSPL IssueId - 22880    
    '        'Get Server Date & Time
    '        Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
    '        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
    '        Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
    '        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

    '        'strGetServerDate1 = CommonFunctions.Dates.CGetDate(CType(strGetServerDate1.ToString, Date))

    '        h = CType(Left(strGetServerTime1, 2), Integer)
    '        m = CType(Right(strGetServerTime1, 2), Integer)




    '        'End of Addition

    '        'commented By AmitJ For PSPL IsueId = 22880

    '        ' h = Now().Hour
    '        ' m = Now().Minute
    '        'End of Commenting

    '        If h < 10 Then
    '            strHour = "0" + h.ToString
    '        Else
    '            strHour = h.ToString

    '        End If
    '        If m < 10 Then
    '            strMinute = "0" + m.ToString
    '        Else
    '            strMinute = m.ToString
    '        End If
    '        'end of integration by harshada d for whiziblesem sp7

    '        'SrikanthY on 23 Jan 2007 Added New Hidden elements.Issues-9640,9650
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilterState", "txtHiddenFilterState", , 400, 100, m_FilterData.ToString, , , , , , True, , )
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilter", "txtHiddenFilter", , 400, 100, m_Filter.ToString, , , , , , True, , )
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenDepartment", "txtHiddenDepartment", , 400, 100, m_Department.ToString, , , , , , True, , )
    '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenStatus", "txtHiddenStatus", , 400, 100, m_Status.ToString, , , , , , True, , )
    '        'End of addition by SrikanthY


    '        If UCase(Trim(m_strMode & "")) = "NEW" Then

    '        Else
    '            Dim strDate As String
    '            Dim strTime As String
    '            strDate = "select ISNULL(REPLACE((convert(varchar(50),cast(StatusChangeDate as smallDatetime),106)) ,' ','-'),'') FROM tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
    '            strTime = "select ISNULL(StatusChangeTime,'') from tbl_CRM_Query_Master where QueryID=" & m_lngQueryID
    '            .Write("<TR class=clsTREven>")
    '            'shraddha 24 July 2006
    '            If m_strLoginType = "E" Then
    '                .Write("<td align=right>" & m_strStatusChangeDate & "</TD>")
    '            Else
    '                .Write("<td align=right> </TD>")
    '            End If

    '            .Write("<TD>")

    '            Dim strdt As String = CType(CommonFunctions.Data.GetDataScalar(strDate, True), String).ToString

    '            Dim strtm As String = CType(CommonFunctions.Data.GetDataScalar(strTime, True).ToString, String)

    '            'Hidden date control contains DateValue of particular status from database
    '            CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , strdt, , "frmRequestDetails", , , , , , , , False, , , True, )

    '            'control contains DateValue of particular status from database
    '            If m_strLoginType = "C" Then
    '                'shraddha 24 July 2006
    '                CommonFunction.HTMLControls.DrawTextBox("txtReadOnlychangedDate", "txtReadOnlychangedDate", , 80, , CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(strdt), , , , True, , True, , , False, , , ).ToString()

    '                CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , False, , , True)
    '            Else
    '                CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , True, , , )
    '            End If

    '            'CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , True, , , )

    '            ' .Write("</TD>")
    '            ' .Write("<td align=right>" & m_strStatusChangeTime & "</TD>")
    '            '.Write("       " & m_strStatusChangeTime)
    '            ' .Write("<TD>")

    '            'Modified by ShraddhaM on Date 16 June,2006 for WhizibleSEM Issue ID.4168

    '            'hidden time control contains TimeValue of particular status from database
    '            'Modified By ShraddhaM on 27 July 2006
    '            CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , strtm, , , , , , True, , , , , , , , True, "Soft", )


    '            'Ended by ShraddhaM on Date 16 June,2006 for WhizibleSEM Issue ID.4168

    '            'hidden time control contains TimeValue of particular status from database
    '            'CommonFunction.HTMLControls.DrawTextBox("txtchangedTimeHidden1", "txtchangedTimeHidden1", , , , strtm, , , , , , True, , , False, , , , )


    '            'control contains TimeValue of particular status from database     
    '            If m_strLoginType = "C" Then
    '                CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , True, , True, , , False, , , ).ToString()
    '            Else
    '                .Write("       " & m_strStatusChangeTime)
    '                CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , ).ToString()
    '            End If
    '            '  CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , ).ToString()

    '            .Write("</TD>")
    '            .Write("</TR>")
    '            'integrated by harshada d for whiziblesem sp7
    '            'commented by amit J for issueid 22880 - PSPL 

    '            'CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), , "frmRequestDetails", , , , , , , , False, , , True)

    '            'End of commenting
    '            'Added By AmitJ for issueid 22880 - PSPL 
    '            'CurrentDate field will hold date of server ,not  of client
    '            CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmRequestDetails", , , , , , , , False, , , True)
    '            CommonFunction.General.WriteHTML("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
    '            'End of addition

    '            CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True)
    '            'end of integration by harshada d
    '            Dim strCurrentHours As String
    '            Dim strCurrentTime As String

    '            strCurrentHours = Now.Hour.ToString
    '            If CType(Now.Hour.ToString, Integer) < 10 Then
    '                strCurrentHours = "0" + Now.Hour.ToString
    '            End If
    '            strCurrentTime = Now.Minute.ToString
    '            If CType(Now.Minute.ToString, Integer) < 10 Then
    '                strCurrentTime = "0" + Now.Minute.ToString
    '            End If

    '            Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strCurrentHours + ":" + strCurrentTime, IsHidden:=True))
    '            'CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , Now.Hour.ToString + ":" + Now.Minute.ToString, IsHidden:=True)

    '        End If
    '        'End Addition By PradipK for Help Desk SLA 
    '        'End Integration

    '        ' Target Location
    '        'added by ShubhadaL
    '        'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
    '            If (m_strLoginType <> "C") Then
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
    '                .Write("<TD>")
    '                ' End If 'statement added by ShubhadaL

    '                'Modified By SantoshK on 29Jan 2005
    '                'strSQL = "usp_CRM_Get_TargetLocations " & lngFunctionID
    '                'Issue 15474 - Helpdesk : Location drop down makes no sense to the user entering a new issue

    '                'Added by ShubhadaL
    '                'If (m_strLoginType = "C") Then
    '                '    CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , , , , True, , True)
    '                'Else
    '                '    CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , , , , True)
    '                'Modification Ends
    '                CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , True, , , True)
    '                .Write("</TD>")
    '                .Write("</TR>")
    '            End If 'statement added by ShubhadaL
    '        End If

    '        If UCase(Trim(m_strMode & "")) = "NEW" Then
    '            If m_strLoginType <> "C" And m_strVal <> "C" Then
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
    '                .Write("<TD>")
    '            End If

    '            'Modified By SantoshK on 29Jan 2005
    '            'strSQL = "usp_CRM_Get_TargetLocations " & lngFunctionID
    '            'Issue 15474 - Helpdesk : Location drop down makes no sense to the user entering a new issue
    '            If m_strLoginType <> "C" And m_strVal <> "C" Then
    '                CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , True, , , True)
    '                .Write("</TD>")
    '                .Write("</TR>")
    '            End If
    '        End If
    '        'End Integration by SavitaS


    '        ''Added by ManishK on 11th Jan 06 to add Deliverable Textbox on the Helpdesk Page

    '        'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
    '        'Purpose: added one condition for My e-Dashboard (MD)
    '        'If UCase(Trim(m_strMode & "")) = "EDIT" And (UCase(Trim(m_strFromWhere & "")) = "DB"  Or UCase(Trim(m_strFromWhere & "")) = "AR") Then
    '        If UCase(Trim(m_strMode & "")) = "EDIT" And (UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Or UCase(Trim(m_strFromWhere & "")) = "AR") Then
    '            'End of addition by PrashantSJ on 09 Nov 2006

    '            .Write("<TR class=clsTREven>")
    '            .Write("<TD align=right >Deliverable</td>")
    '            .Write("<TD>")

    '            Dim strDeliverableName As String = ""
    '            Dim drGetDeliverable As IDataReader
    '            'Dim strDeliverableID As String = MyBase.GetFormValue("DeliverableID")

    '            If m_strDeliverableID <> "" Then
    '                strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
    '                drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

    '                If drGetDeliverable.Read Then
    '                    strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
    '                End If

    '                CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
    '            End If

    '            If UCase(Trim(m_strFromWhere & "")) = "AR" Then
    '                Response.Write(CommonFunction.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , , , , True))
    '                'Response.Write("<Input  Type=Textbox  name='txtDeliverableName' id='txtDeliverableName' class='clsTextBoxReadOnly' style='width:250px'  maxlength=200 style='' value=" + strDeliverableName.ToString + " style='text-align:left'  disabled  readonly style='BACKGROUND-COLOR='>")
    '                CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , 200, 100, strDeliverableName.ToString, , , True)
    '            Else
    '                'Response.Write(CommonFunction.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , , , , True))
    '                'Modified by SavitaS on 28 Sept 2006 for SP7 IssueID 6486
    '                'As the textbox was disabled,the value of the DeliverableID was not getting while saving the request.
    '                'CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , True, , , True)
    '                CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , False, , , True)
    '                'End of Modified by SavitaS on 28 Sept 2006 for SP7 IssueID 6486
    '                CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , 200, 100, strDeliverableName.ToString, , , True)
    '                'Response.Write("<Input  Type=Textbox  name='txtDeliverableName' id='txtDeliverableName' class='clsTextBoxReadOnly' style='width:250px'  maxlength=200 style='' value=" + strDeliverableName.ToString + " style='text-align:left'  disabled  readonly style='BACKGROUND-COLOR='>")
    '                'Response.Write("&nbsp;<img Border=0 src = '../../../responsive/images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:SelectDeliverable()'>")
    '            End If
    '            .Write("</TD></TR>")

    '        End If

    '        'End of Added by ManishK on 11th Jan 06 to add Deliverable Textbox on the Helpdesk Page

    '        '-------------------------------------------------------------------------------------------

    '        'Added By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL IsssueID 79 
    '        'Added Facility and Extension Number in Edit Mode

    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then

    '            Dim strFacility As String
    '            Dim strExtensionNo As String
    '            'Added by ShubhadaL
    '            If (m_strLoginType <> "C") Then
    '                'Integrated by MonikaI for Whizible SP 7.2 Issue ID 4518
    '                'Added  t J on 3rd July For DSS Issue Id  2655
    '                'Page crash if username includes "'" e.g. Username = Dawood's
    '                strRequestor = Replace(strRequestor, "'", "''")
    '                'End of Additon
    '                'End of integration
    '                dr = CommonFunction.Data.GetDataReader("usp_sel_facility_extension '" & strRequestor + "'", m_blnUseSQL)
    '                If dr.Read Then
    '                    strFacility = dr("Facility").ToString
    '                    strExtensionNo = dr("ExtensionNo").ToString
    '                End If
    '                CommonFunctions.Data.DisposeDataReader(dr)
    '            End If
    '            'Facility
    '            'added by Shubhadal
    '            If (m_strLoginType <> "C") Then
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right >Facility</td>")
    '                .Write("<TD>")
    '            End If 'statement added by ShubhadaL
    '            'added by ShubhadaL
    '            If (m_strLoginType = "C") Then
    '                CommonFunctions.HTMLControls.DrawTextBox("txtFacility", "txtFacility", , , , strFacility, , , True, , , , , , , , , True)
    '            Else
    '                CommonFunctions.HTMLControls.DrawTextBox("txtFacility", "txtFacility", , , , strFacility, , , True)
    '                .Write("</TD></TR>")
    '            End If 'statement added by ShubhadaL
    '            'Extension
    '            If (m_strLoginType <> "C") Then 'statement added by ShubhadaL
    '                .Write("<TR class=clsTREven>")
    '                .Write("<TD align=right >Extension</td>")
    '                .Write("<TD>")
    '            End If 'Statement added by ShubhadaL
    '            'added by ShubhadaL
    '            If (m_strLoginType = "C") Then
    '                CommonFunctions.HTMLControls.DrawTextBox("txtExtension", "txtExtension", , , , strExtensionNo, , , True, , , , , , , , , True)
    '            Else
    '                CommonFunctions.HTMLControls.DrawTextBox("txtExtension", "txtExtension", , , , strExtensionNo, , , True)
    '                .Write("</TD></TR>")
    '            End If

    '        End If 'staetement added by ShubhadaL
    '        'Addition Ends

    '        .Write("</TD>")
    '        .Write("</TR>")

    '        'End Addition By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL IsssueID 79  

    '        'Modified By NitinVS on 13 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11691 
    '        ' After entering feedback comments , Whensaved from E Dashboard data is lost since the controls are not plotted
    '        ' Hence Plotting the controls in disabled mode from E
    '        'If UCase(Trim(m_strMode & "")) = "EDIT" And UCase(Trim(m_strFromWhere & "")) = "SR" Then
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then

    '            ' if the status is  "Closed" show feedback param
    '            If intStatusID <> 2 Then
    '                strStyle = " style='display:none' "
    '            End If
    '            Dim strIsFeedbackdisabled As String = ""
    '            If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
    '                strIsFeedbackdisabled = " disabled "
    '            Else
    '                strIsFeedbackdisabled = ""
    '            End If

    '            ' feeb back (submitted mode)
    '            .Write("<TR id=TRFeedback class=clsTREven " & strStyle & ">")
    '            .Write("<TD align=right>Feedback</TD>")
    '            .Write("<TD>")
    '            strSQL = "usp_CRM_Get_Feedback_ForCombo"
    '            CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, 0, intFeedbackID.ToString, strIsFeedbackdisabled, , , , True)
    '            .Write("</TD>")
    '            .Write("</TR>")

    '            .Write("<TR id=TRFeedbackComments class=clsTREven  " & strStyle & " >")
    '            .Write("<TD align=right vAlign=top>Feedback Comments </TD>")
    '            .Write("<TD>")
    '            'Modified By ShraddhaM on 27 July 2006
    '            CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , 400, 100, , strFeedbackComments, , , , , , , strIsFeedbackdisabled, , , , , , , , "Soft", )
    '            .Write("</TD>")
    '            .Write("</TR>")
    '        End If
    '        'End Modification By NitinVS on 13 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11691 
    '        .Write("</Table>")
    '        .Write("</div>")
    '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
    '            ' attachments grid
    '            .Write("<BR>")
    '            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ATTACHMENTS")))
    '            PlotAttachmentsGrid()
    '        End If
    '        .Write("<BR>")
    '        .Write(strMenu)
    '    End With

    'End Sub
    Protected Sub ModifyWritePage()

        If m_strFromWhere = "DB" Then
            InitializeVaiablesInDrawPageMethods()
            Call DrawPageForEDashboard()
            Exit Sub
        ElseIf m_strFromWhere = "SR" Then
            InitializeVaiablesInDrawPageMethods()
            Call DrawPageForSR()
            Exit Sub
        ElseIf m_strFromWhere = "AR" Then
            InitializeVaiablesInDrawPageMethods()
            Call DrawPageForAR()
            Exit Sub
        ElseIf m_strFromWhere = "MD" Then
            InitializeVaiablesInDrawPageMethods()
            Call DrawPageForMDB()
            Exit Sub
        End If
 
        'Commented by ShraddhaM on 1,Oct 2009
        'Following code never gets call.
        ''=====================================================================
        '' Procedure Name        : WritePage()	
        '' Purpose               : To Change UI of Request Detail Page.
        '' Description           : same as above
        '' Parameters Passed     : None
        '' Returns               : NA
        '' Parameters Affected   : 
        '' Assumptions           : module variables are set before this
        '' Dependencies          : 
        '' Author                : PradipK
        '' Created               :Feb 06,2007
        '' Revisions             :
        ''=====================================================================
        '' Modified By NitinVS on 18 Aug 2005 For WhzibileSEM SP4 Helpdesk Performance 
        '' Added Link for Reject 
        ''----------------------------------------------------------------------------------------------
        ''Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        ''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        ''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        ''Modified by VidyaJ for IssueID - 16585
        ''Dim arrCSFunction() As String = {"AssignTask_OnClick()", "AssignIssue_OnClick()", "DeleteAttachment_OnClick()", "AddAttachment_OnClick()", "Discussion_OnClick()", "Reject_Onclick()", "Save_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}


        ''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE"), "Show History", MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        ''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Show History", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        ''Dim arrCSFunction() As String = {"AssignTask_OnClick()", "AssignIssue_OnClick()", "AddAttachment_OnClick()", "SelectAll_OnClick()", "DeleteAttachment_OnClick()", "Discussion_OnClick()", "Reject_Onclick()", "Save_OnClick()", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
        ''-------------------------------------------------------------------------------------------
        ''End
        '' End Modification By NitinVS on 18 Aug 2005 For WhzibileSEM SP4 Helpdesk Performance 

        '''Modified by ManishK on 10th Jan 06 For Deliverable Link Functionality ...
        ''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE"), "Show History", MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        ''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), "Select All Attachments", MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Show History", MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        '''End of Modified by ManishK on 10th Jan 06 For Deliverable Link Functionality ...
        '''Modified by VidyaJ for IssueID - 16585
        ''Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "AddAttachment_OnClick()", "SelectAll_OnClick()", "DeleteAttachment_OnClick()", "Discussion_OnClick()", "Reject_Onclick()", "Save_OnClick()", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
        '''End Integration


        ''Added by PrashantSJ on 08 Nov 2006 For WhizibleSEM SP8 Build 1
        ''Purpose: To add one link called "Flag Request"

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS_TOOLTIP"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Reject_Onclick()", "ShowHistory_OnClick()", "Discussion_OnClick()", "AddAttachment_OnClick()", "DeleteAttachment_OnClick()", "SelectAll_OnClick()", "FlagRequest_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

        ''End of addition by PrashantSJ on 08 Nov 2006
        'Dim intComboSize As Integer = 170
        'Dim intWidth As Integer = 830
        'Dim intPixelSize As Integer = 60

        'Dim strMenu, strLegend As String
        'Dim arrLegend() As String = {"Mandatory"}
        'Dim arrLegendImage() As String = {"<img src='../../../responsive/images/star.gif'>"}
        'Dim dr As IDataReader
        'Dim strSQL As String
        'Dim blnDisableStatusCombo As Boolean = False
        'Dim blnDisableFunctionCombo As Boolean = False
        'Dim blnDisableSubRequestTypeCombo As Boolean = False
        '' added by harshada d on 03 Feb 2006 for help desk enhancements
        'Dim strSQLCustomerName As String
        'Dim drCustomerName As IDataReader
        'Dim strCustomerName As String
        ''end of additon by harshada d
        'Dim blnDisbaledSubjectTextBox As Boolean = False
        'Dim blnDisabledAssignToCombo As Boolean = False
        'Dim blnReadOnlyComments As Boolean = False
        'Dim arr() As String
        'Dim intTemplateCount As Integer
        'Dim strStyle As String
        'Dim strRequestType As String = ""
        'Dim strGuidelinesColumnName As String = ""
        'Dim intRequestTypeID As Long = 0
        'Dim strSubject As String = ""
        'Dim strDescription As String = ""
        'Dim intPriorityID As Integer = 0
        'Dim strExpectedResolvedDate As String = ""
        'Dim strCRMExpectedResolvedDate As String = ""
        'Dim lngAssignTo As Long = 0
        'Dim lngTargetLocationID As Long = 0
        'Dim intStatusID As Integer = 0
        'Dim intFeedbackID As Integer = 0
        'Dim strFeedbackComments As String = ""
        'Dim strComments As String = ""
        'Dim strReasonsForRejection As String = ""
        ''To Display Request ID and Requestor in Edit Mode
        'Dim lngRequestID As Long = 0
        'Dim strRequestor As String = ""
        'Dim strRequestorName As String = ""
        ''Modified By NitinVS on 19 FEb 2007 for IssueID 10366
        '' Add Field for Severity 
        'Dim intSeverityID As Integer = 0
        ''End Addition  By NitinVS on 19 FEb 2007 for IssueID 10366
        ''Added By NitinVS on 16 Mar 2007 for WhizibleSEM SP 8 Regression Issue 
        'Dim lngRequestTypeIdOld As Long = 0
        '' End Addition By NitinVS on 16 Mar 2007 for WhizibleSEM SP 8 Regression Issue 

        ''Addition Ends
        ''Added by SrikanthY on 04 Jan 07 For Integrating Product , Components in Request Screen
        'Dim blnDisableProductCombo As Boolean = False
        'Dim blnDisableModuleCombo As Boolean = False
        'Dim blnDisableProjectCombo As Boolean = False
        ''End of Addition by SrikanthY
        'Dim ShowProductCombo As String = ""
        'If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '    intWidth = 830
        'End If
        '' disable status combo?
        'If Not Request("DisableStatuscombo") Is Nothing Then
        '    If Trim(Request("DisableStatuscombo") & "") = "1" Then blnDisableStatusCombo = True
        'End If
        'If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '    ' we'll get the request values from the database
        '    dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
        '    If dr.Read Then
        '        m_intDiscussionThreadCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("DiscussionThreads"), "0"), Integer)
        '        lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FunctionID"), "0"), Long)
        '        'Added By SantoshK on 2nd Dec 2004
        '        'To Display requestID and Requestor in Edit Mode
        '        lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(dr("QueryID"), "0"), Long)
        '        strRequestor = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerID")), String)
        '        strRequestorName = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerName")), String)
        '        'Addition Ends
        '        'Added By SantoshK on 30th Nov 2004
        '        m_lngRequestTypeId = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0"), Long)
        '        lngRequestTypeIdOld = m_lngRequestTypeId
        '        'Addition Ends
        '        m_lngSubRequestTypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0"), Long)
        '        strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
        '        strSubject = dr("Subject").ToString
        '        'Added by PrashantSJ on 08 Nov 2006 for WhizibleSEM SP8 Build 1
        '        'Purpose: For storing Request Subject (which is passed to Flag tracker)
        '        m_strSubject = dr("Subject").ToString
        '        ' m_strSubject = m_strSubject.Replace("""", "&quot;")
        '        'End of addition by PrashantSJ on 08 Nov 2006
        '        strDescription = dr("Description").ToString
        '        intPriorityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("PriorityID"), "0"), Integer)
        '        If Not IsDBNull(dr("ExpectedResolvedDate")) Then
        '            strExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("ExpectedResolvedDate"), Date))
        '        End If
        '        If Not IsDBNull(dr("CRMExpectedResolvedDate")) Then
        '            strCRMExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("CRMExpectedResolvedDate"), Date))
        '        End If
        '        lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
        '        strComments = dr("Comments").ToString
        '        strReasonsForRejection = dr("ReasonsForRejection").ToString
        '        intStatusID = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusID"), "0"), Integer)
        '        lngTargetLocationID = CType(CommonFunctions.Data.CheckIsDBNull(dr("TargetLocationID"), "0"), Long)
        '        intFeedbackID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FeedbackID"), "0"), Integer)
        '        strFeedbackComments = dr("FeedbackComments").ToString

        '        ''Added by Manishk On 11th jan 06 to add deliverable textbox on helpdesk page
        '        m_strDeliverableID = dr("DeliverableID").ToString
        '        ''eND OF Added by Manishk On 11th jan 06 to add deliverable textbox on helpdesk page

        '        ' lets see if we can allow attachment deletion 
        '        If CType(CommonFunctions.Data.CheckIsDBNull(dr("IsAttachmentMandatory"), "0"), Boolean) And lngAssignTo <> 0 Then
        '            m_blnAllowAttachmentDeletion = False
        '        End If
        '        'Added by SrikanthY on 05 Jan 2007 To Get Values of Product,Components in Edit Mode
        '        m_ChangedProduct = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
        '        m_ChangedModule = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)
        '        m_ChangedProject = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectID"), "0"), Integer)


        '        m_RequeststrLoginType = CType(CommonFunctions.Data.CheckIsDBNull(dr("LoginType"), "0"), String)
        '        m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(dr("ClientName"), "0"), String)
        '        'End of Addition by SrikanthY

        '        lngProductID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
        '        If lngProductID = 0 Then
        '            lngProductID = -1
        '        End If
        '        lngComponentID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)

        '        'Modified By NitinVS on 19 FEb 2007 for IssueID 10366
        '        ' Add Field for Severity 
        '        intSeverityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SeverityID"), "0"), Integer)
        '        'End Addition  By NitinVS on 19 FEb 2007 for IssueID 10366

        '    End If

        '    ' Added BY NitinVS on 9 Aug  2005 for WhizibleSEM SP4 IssueID 2
        '    m_lngStatusId = intStatusID
        '    ' End Addition BY NitinVS on 9 Aug  2005 for WhizibleSEM SP4 IssueID 2

        '    'Added by PrajaktaR on 17 Feb 2007 for WizibleSEM SP9 IssueID - 10295 for Disabling Status if marked as closed.
        '    intRequestStatus = intStatusID
        '    'End of Addition by PrajaktaR on 17 Feb 2007 for WizibleSEM SP9 IssueID - 10295 for Disabling Status if marked as closed.

        '    CommonFunctions.Data.DisposeDataReader(dr)
        '    blnDisableProductCombo = True
        '    blnDisableModuleCombo = True
        '    blnDisableFunctionCombo = True
        '    blnDisableSubRequestTypeCombo = True
        '    blnDisableSubRequestTypeCombo = True
        '    blnDisableProjectCombo = True
        '    If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
        '        blnDisbaledSubjectTextBox = True
        '    End If
        '    If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '        strGuidelinesColumnName = "GuidelinesForAssignee"
        '        blnReadOnlyComments = True
        '    ElseIf UCase(Trim(m_strFromWhere & "")) = "SR" Then
        '        strGuidelinesColumnName = "GuidelinesForRequestor"
        '    End If
        '    'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '    'Purpose: added one condition for My e-Dashboard (MD)
        '    'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
        '    If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
        '        'End of addition by PrashantSJ on 09 Nov 2006
        '        blnDisabledAssignToCombo = False
        '    Else
        '        blnDisabledAssignToCombo = True
        '    End If

        '    If strStatus = "FUNCTION_CHANGE" Or strStatus = "PRODUCT_CHANGE" Or strStatus = "SUBREQUESTTYPE_CHANGE" Then
        '        If MyBase.GetFormValue("cboProduct") = "" Then
        '            lngProductID = -1
        '        Else
        '            lngProductID = CType(MyBase.GetFormValue("cboProduct"), Long)
        '        End If

        '        If MyBase.GetFormValue("cboModule") = "" Then
        '            lngComponentID = 0
        '        Else
        '            lngComponentID = CType(MyBase.GetFormValue("cboModule"), Long)
        '        End If
        '    End If

        'Else
        '    ' for "NEW" mode we'll use submitted values of form if any!
        '    If Trim(MyBase.GetFormValue("cboFunction") & "") <> "" Then
        '        lngFunctionID = CType(MyBase.GetFormValue("cboFunction"), Long)
        '    End If
        '    If Trim(MyBase.GetFormValue("cboProduct") & "") <> "" Then
        '        lngProductID = CType(MyBase.GetFormValue("cboProduct"), Long)
        '        '               lngComponentID()
        '    End If

        '    If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
        '        lngComponentID = CType(MyBase.GetFormValue("cboModule"), Long)
        '        '               lngComponentID()
        '    End If

        '    'Added By Santoshk on 1st Dec 2004
        '    'To Seperate TaskType and SubTaskType
        '    If CommonFunction.Application.SplitRequestTypeSubType = True Then
        '        If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
        '            m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
        '        End If
        '    End If
        '    'Addition Ends

        '    strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
        '    If Trim(strSubrequestType & "") <> "" Then
        '        arr = Split(strSubrequestType, "|")
        '        If Trim(arr(0) & "") <> "" Then
        '            m_lngSubRequestTypeID = CType(arr(0), Long)
        '        End If
        '        'Added By JyotiG
        '        'Start_JG_9145_03-Jan-2007
        '        If CommonFunction.Application.SplitRequestTypeSubType = False Then
        '            If Trim(arr(1) & "") <> "" Then
        '                m_lngRequestTypeId = CType(arr(1), Long)
        '            End If
        '        End If
        '        'End_JG_9145_03-Jan-2007
        '    End If
        '    'integrated by harshada d on 19092005 for issue id 295
        '    'Commented and Modified by ParagD on 14-Sept-2005
        '    'To avoid IssueID :21047 - Aspire
        '    'strSubject = Trim(MyBase.GetFormValue("txtSubject") & "")
        '    ' strDescription = Trim(MyBase.GetFormValue("txtDescription") & "")
        '    strSubject = Trim(Request.Form("txtSubject") & "")
        '    strDescription = Trim(Request.Form("txtDescription") & "")
        '    'Modification Ended by ParagD on 14-Sept-2005
        '    'end of integration by harshada d on 19092005 for issue id 295
        '    If Trim(MyBase.GetFormValue("cboPriority") & "") <> "" Then
        '        intPriorityID = CType(Trim(MyBase.GetFormValue("cboPriority") & ""), Integer)
        '    End If
        '    'SrikanthY on 08 Jan 2007 Added code to get the values of newly introduced drop downs
        '    If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
        '        m_ChangedModule = CType(Trim(MyBase.GetFormValue("cboModule")), Integer)
        '    End If
        '    If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
        '        m_ChangedProject = CType(Trim(MyBase.GetFormValue("cboProject")), Integer)
        '    End If
        '    If Trim(MyBase.GetFormValue("cboTargetLocation") & "") <> "" Then
        '        m_ChangedLocation = CType(Trim(MyBase.GetFormValue("cboTargetLocation")), Integer)
        '    End If
        '    'End of Addition By SriaknthY
        '    strExpectedResolvedDate = Trim(MyBase.GetFormValue("txtResolutionDate") & "")
        '    strCRMExpectedResolvedDate = Trim(MyBase.GetFormValue("txtCRMResolutionDate") & "")
        '    If Trim(MyBase.GetFormValue("cboAssignTo") & "") <> "" Then
        '        lngAssignTo = CType(Trim(MyBase.GetFormValue("cboAssignTo") & ""), Long)
        '    End If
        '    strComments = Trim(MyBase.GetFormValue("txtComments") & "")
        '    strReasonsForRejection = Trim(MyBase.GetFormValue("txtReasonsForRejection") & "")
        '    If Trim(MyBase.GetFormValue("cboStatus") & "") <> "" Then
        '        intStatusID = CType(Trim(MyBase.GetFormValue("cboStatus") & ""), Integer)
        '    End If
        '    lngTargetLocationID = GetEmployeeDepartment(m_lngEmployeeID)
        '    If Trim(MyBase.GetFormValue("cboFeedback") & "") <> "" Then
        '        intFeedbackID = CType(Trim(MyBase.GetFormValue("cboFeedback") & ""), Integer)
        '    End If
        '    strGuidelinesColumnName = "GuidelinesForRequestor"
        '    strFeedbackComments = Trim(MyBase.GetFormValue("txtFeedbackComments") & "")
        'End If

        '' set the captions for the page
        'Call SetCaptions()

        '' start the page
        'strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)

        'MyBase.InitializeResources("AppResources.CRM_RequestDetail", "AppResources")
        'With Response

        '    ' menu
        '    .Write(strMenu)
        '    ' Modified By NitinVS on 9 Feb 2005 
        '    ' Displayed the Legends after Menu 
        '    'page legend
        '    strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
        '    '.Write(strLegend)
        '    ' End Addition By NitinVS on 9 Feb 2005 

        '    If UCase(Trim(m_strMode & "")) = "NEW" Then
        '        .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_NEW_REQUEST")))
        '    Else

        '        '.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_REQUEST_DETAILS")))
        '        '  .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_REQUEST_DETAILS"), "Requestor " + lngRequestID.ToString, "mIDDEL"))
        '    End If
        '    .Write("<div id=divList style='overflow:auto'>")
        '    .Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
        '    'Added By SantoshK on 2nd Dec 2004
        '    'Displaying RequestID and Requestor in Edit Mode
        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        '----------------------------------------------------------------------------------------------                'Request ID
        '        .Write("<TR  class=clsTRPageCaption>")

        '        'If m_strLoginType = "C" Then

        '        '    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
        '        '        strSQLCustomerName = "select CustomerName from tbl_pm_customer where Customer=" & CType(HttpContext.Current.Session("Customer"), Long)
        '        '        drCustomerName = CommonFunctions.Data.GetDataReader(strSQLCustomerName, m_blnUseSQL)
        '        '        If drCustomerName.Read Then
        '        '            strCustomerName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomerName("CustomerName"), "0"), String)
        '        '        End If
        '        '        CommonFunctions.Data.DisposeDataReader(drCustomerName)

        '        '        .Write("<TD align=left colspan=2> Request Details: By </TD>")
        '        '    Else
        '        '        .Write("<TD align=left colspan=2> Request Details: </TD>")
        '        '    End If

        '        'End If
        '        'If m_RequeststrLoginType.ToUpper = "C" Then
        '        '    If m_strClienName = "0" Then
        '        '        .Write("<TD align=left colspan=2> Request Details : By Customer </TD>")
        '        '    Else
        '        '        .Write("<TD align=left colspan=2> Request Details : By Client</TD>")
        '        '    End If
        '        'Else
        '        '    .Write("<TD align=left colspan=2> Request Details : </TD>")
        '        'End If

        '        .Write("<TD align=left colspan=4> Request Details :: Requestor : ")


        '        'Requestor
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("<TR class=clsTREven>")

        '        '.Write("<TD align=right > Requestor : </TD>")
        '        '.Write("<TD>")



        '        'CommonFunctions.HTMLControls.DrawTextBox("txtRequestor", "txtRequestor", , , , strRequestor, , , True, , , , , , True)

        '        If m_RequeststrLoginType.ToUpper = "C" Then
        '            If m_strClienName = "0" Then
        '                .Write(strRequestor.ToString)
        '            Else
        '                If m_strClienName <> "" Then
        '                    .Write(strRequestor.ToString + " | " + m_strClienName)
        '                End If
        '            End If
        '        Else
        '            .Write(strRequestor.ToString)
        '        End If


        '        .Write("</TD>")
        '        .Write("<TD align=right> Request ID : </TD>")
        '        .Write("<TD>")
        '        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
        '        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '        '  CommonFunctions.HTMLControls.DrawTextBox("txtRequestID", "txtRequestID", , 50, , lngRequestID.ToString, , , True, , , , , , True)
        '        .Write(lngRequestID.ToString + "  ")
        '        'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        '        'Added by SavitaS on 24 Nov 2005 to add a link "Move this request to another Department" 
        '        'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '        'Purpose: added one condition for My e-Dashboard (MD)
        '        'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
        '        If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
        '            'End of addition by PrashantSJ on 09 Nov 2006
        '            ' added by harshada d on 03 Feb 2006 for helpdesk Enhancements 
        '            Dim drIsTaskCreated As IDataReader
        '            Dim drAssignTo As IDataReader
        '            Dim strSQLIsTaskCreated As String
        '            strSQLIsTaskCreated = "select TaskID from tbl_pm_projectTasks where CRMQueryID = " & lngRequestID.ToString
        '            strSQLIsTaskCreated += " union all select IssueID from tbl_IB_issue where CRMQueryID = " & lngRequestID.ToString
        '            strSQLIsTaskCreated += " union all select DeliverableID from tbl_CRM_Query_Master where DeliverableID IS NOT NULL and QueryID = " & lngRequestID.ToString
        '            strSQLIsTaskCreated += " union all select AssignTo from tbl_CRM_Query_Master where AssignTo IS NOT NULL and AssignTo <> 0 and QueryID = " & lngRequestID.ToString
        '            'End Modification by SavitaS
        '            drIsTaskCreated = CommonFunctions.Data.GetDataReader(strSQLIsTaskCreated, m_blnUseSQL)
        '            Dim strIsTaskCreated As String
        '            If drIsTaskCreated.Read Then
        '                strIsTaskCreated = CommonFunctions.Data.CheckIsDBNull(drIsTaskCreated("TaskID"), "0").ToString
        '            End If
        '            If Not strIsTaskCreated Is Nothing Then
        '                If strIsTaskCreated = "0" Or strIsTaskCreated = "" Then
        '                    intIsTask_IssueCreated = 0
        '                Else
        '                    intIsTask_IssueCreated = 1
        '                End If
        '            End If
        '            CommonFunctions.Data.DisposeDataReader(drIsTaskCreated)
        '            'Added by Manishk on 25th Feb 06 For SP 6 issue
        '            Dim drForHrm As IDataReader
        '            Dim strSQLQuery As String
        '            Dim lngCRMID As Long = 0
        '            'strSQLQuery = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
        '            'drForHrm = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
        '            'If drForHrm.Read Then
        '            '    lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(drForHrm("EmployeeID"), "0"), Long)
        '            'End If
        '            'CommonFunctions.Data.DisposeDataReader(drForHrm)
        '            strSQLQuery = " SELECT CRMID FROM tbl_CRM_Function_CRMS Where CRMID = " & m_lngEmployeeID & " and FUNCTIONID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & lngRequestID.ToString & ")"
        '            strSQLQuery += " UNION ALL select departmentHeadID from tbl_pm_departmentmaster Where departmentHeadID = " & m_lngEmployeeID & " and DepartmentID IN ( SELECT FunctionID FROM tbl_CRM_Query_Master Where QueryID = " & lngRequestID.ToString & ")"
        '            drForHrm = CommonFunctions.Data.GetDataReader(strSQLQuery, m_blnUseSQL)
        '            If drForHrm.Read Then
        '                lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(drForHrm("CRMID"), "0"), Long)
        '            End If
        '            CommonFunctions.Data.DisposeDataReader(drForHrm)
        '            If lngCRMID <> 0 Then
        '                'end of addition by harshada d on  03 Feb 2006 for helpdesk enhancements
        '                ' .Write("<font face=verdana;Arial size=1><A href='JavaScript:MoveToDept_OnClick()'><B>Move this request to another Department</B></A></font>")
        '                '.Write("<font face=verdana;Arial size=1><A href='JavaScript:MoveToDept_OnClick()'><B>Change Department</B></A></font>")
        '                '.Write("<A href='JavaScript:MoveToDept_OnClick()'><IMG Border=0  SRC='../../../responsive/images/RedFlag.gif' /> </A></font>")
        '                .Write("<A href='JavaScript:MoveToDept_OnClick()'><Image Border=0  src='../../../responsive/images/MoveImg.gif'   id ='view' title = 'Move this request to another Department'  > </A>")
        '                '.Write("<font face=verdana;Arial size=1><a href=""JavaScript:MoveToDept_OnClick()""><IMG Border=0  SRC='../../../responsive/images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a>")

        '                'Args.StringToBeInserted = "<TD vAlign=top title='Flag' style='TEXT_DECORATION:None' nowrap;><a href=""javascript:Flag_OnClick(" + m_Queryid.ToString + " )""><IMG Border=0  SRC='../../../responsive/images/RedFlag.gif'  title='" + m_FlagStatus + "' onclick="""" ></a></TD>"
        '                'End If
        '                'End Modification
        '            Else
        '                '.Write("Move this request to another Department")
        '                '.Write("Change Department")
        '            End If
        '            'End Added by Manishk on 25th Feb 06 For SP 6 issue
        '        End If
        '        'End Addition
        '        'End Integration by SavitaS 
        '        .Write("</TD>")
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("</TR>")
        '        '-------------------------------------------------------------------------------------------
        '        ''Requestor
        '        ''Code Commented By PradipK to Change UI of Help Desk Page
        '        ''.Write("<TR class=clsTREven>")
        '        '.Write("<TD align=right> Requestor </TD>")
        '        '.Write("<TD>")
        '        'CommonFunctions.HTMLControls.DrawTextBox("txtRequestor", "txtRequestor", , , , strRequestor, , , True, , , , , , True)
        '        '.Write("</TD>")
        '        '.Write("<TD></TD><TD></TD>")
        '        .Write("<TD></TD>")
        '        .Write("</TR>")
        '        ''If m_blnIsClient = True Then
        '        ''    strRequestorName = m_strLoginName
        '        ''End If
        '        'SrikanthY on 10 Jan 2007 Commented code to draw Requestor Name field , and will be uncommented later
        '        'SrikanthY_Comment_Start_100107
        '        'If UCase(Trim(m_strFromWhere & "")) = "SR" Or UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '        '    'Requestor Name
        '        '    'Code added on 21 dec 2006 by SajiU
        '        '    .Write("<TR class=clsTREven>")
        '        '    .Write("<TD align=right> Requestor Name </TD>")
        '        '    .Write("<TD>")
        '        '    If strRequestorName = "" Then
        '        '        CommonFunctions.HTMLControls.DrawTextBox("txtRequestorName", "txtRequestorName", , , , strRequestor, , , True, , , , , , True)
        '        '    Else
        '        '        CommonFunctions.HTMLControls.DrawTextBox("txtRequestorName", "txtRequestorName", , , , strRequestorName, , , True, , , , , , True)
        '        '    End If

        '        '    .Write("</TD>")
        '        '    .Write("</TR>")
        '        'End If
        '        'Addition Ends
        '        'SrikanthY_Comment_Start_100107
        '    End If
        '    '---------------------------------------------------------------------------


        '    'Added By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL IsssueID 79 
        '    'Added Facility and Extension Number in Edit Mode

        '    'If UCase(Trim(m_strMode & "")) = "EDIT" Then

        '    '    Dim strFacility As String
        '    '    Dim strExtensionNo As String
        '    '    'Added by ShubhadaL
        '    '    If (m_strLoginType <> "C") Then
        '    '        'Integrated by MonikaI for Whizible SP 7.2 Issue ID 4518
        '    '        'Added  Amit J on 3rd July For DSS Issue Id  2655
        '    '        'Page crash if username includes "'" e.g. Username = Dawood's
        '    '        strRequestor = Replace(strRequestor, "'", "''")
        '    '        'End of Additon
        '    '        'End of integration
        '    '        dr = CommonFunction.Data.GetDataReader("usp_sel_facility_extension '" & strRequestor + "'", m_blnUseSQL)
        '    '        If dr.Read Then
        '    '            strFacility = dr("Facility").ToString
        '    '            strExtensionNo = dr("ExtensionNo").ToString
        '    '        End If
        '    '        CommonFunctions.Data.DisposeDataReader(dr)
        '    '    End If
        '    '    'Facility
        '    '    'added by Shubhadal
        '    '    If (m_strLoginType <> "C") Then
        '    '        .Write("<TR class=clsTREven>")
        '    '        .Write("<TD align=right >Facility</td>")
        '    '        .Write("<TD>")
        '    '    End If 'statement added by ShubhadaL
        '    '    'added by ShubhadaL
        '    '    If (m_strLoginType = "C") Then
        '    '        CommonFunctions.HTMLControls.DrawTextBox("txtFacility", "txtFacility", , , , strFacility, , , True, , , , , , , , , True)
        '    '    Else
        '    '        CommonFunctions.HTMLControls.DrawTextBox("txtFacility", "txtFacility", , , , strFacility, , , True)
        '    '        'Code Commented By PradipK to Change UI of Help Desk Page
        '    '        '.Write("</TD></TR>")
        '    '        .Write("</TD>")
        '    '    End If 'statement added by ShubhadaL
        '    '    'Extension
        '    '    If (m_strLoginType <> "C") Then 'statement added by ShubhadaL
        '    '        'Code Commented By PradipK to Change UI of Help Desk Page
        '    '        '.Write("<TR class=clsTREven>")
        '    '        .Write("<TD align=right >Extension</td>")
        '    '        .Write("<TD>")
        '    '    End If 'Statement added by ShubhadaL
        '    '    'added by ShubhadaL
        '    '    If (m_strLoginType = "C") Then
        '    '        CommonFunctions.HTMLControls.DrawTextBox("txtExtension", "txtExtension", , , , strExtensionNo, , , True, , , , , , , , , True)
        '    '        .Write("</TD><TD></TD><TD><BR></TD></TR>")
        '    '        .Write("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")
        '    '    Else
        '    '        CommonFunctions.HTMLControls.DrawTextBox("txtExtension", "txtExtension", , , , strExtensionNo, , , True)
        '    '        .Write("</TD><TD></TD><TD><BR></TD></TR>")
        '    '        .Write("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")
        '    '    End If

        '    'End If 'staetement added by ShubhadaL
        '    'Addition Ends
        '    '*****************End of Row 2

        '    'Modified by SavitaS on 08 Jan 2006 for IssueID 1936
        '    If UCase(Trim(m_strMode & "")) = "NEW" Then
        '        If UCase(Trim(m_strFromWhere & "")) = "SR" Then
        '            'If m_strLoginType <> "E" Or m_intCustomer <> 0 Then 'Or m_strVal <> "I" 
        '            'Added by SrikanthY on 21 Dec 2006 To Display Departments according to Requested Employee
        '            If m_strLoginType <> "E" Or m_intCustomer <> 0 Or m_intRequestedEmployee <> 0 Then 'Or m_strVal <> "I" 
        '                'End Modification by SavitaS
        '                'added by harshada d on 07 feb 2006 for helpdesk enhancements
        '                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
        '                    strSQLCustomerName = "select CustomerName from tbl_pm_customer where Customer=" & CType(HttpContext.Current.Session("Customer"), Long)
        '                    drCustomerName = CommonFunctions.Data.GetDataReader(strSQLCustomerName, m_blnUseSQL)
        '                    If drCustomerName.Read Then
        '                        strCustomerName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomerName("CustomerName"), "0"), String)
        '                    End If
        '                    CommonFunctions.Data.DisposeDataReader(drCustomerName)
        '                    .Write("<b>")
        '                    .Write("<TR class=clsTREven align=center width='99.9%'> <FONT color=blue>" & MyBase.GetResourceString("CAPTION_ON_BEHALF_OFCUSTOMER") & strCustomerName & "</FONT> ")
        '                    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '                    CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
        '                    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '                    .Write("</TR>")
        '                    .Write("</b>")
        '                    'Added By SrikanthY on 29 Dec 2006 For the New faeture to Add Requests on behalf of employees.
        '                ElseIf m_intRequestedEmployee <> 0 Then
        '                    .Write("<b>")
        '                    .Write("<TR class=clsTREven align=center width='99.9%'> <FONT color=blue>" & "You are adding Request on behalf of Employee :" & m_strRequestedEmployee & "</FONT> ")
        '                    CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
        '                    .Write("</TR>")
        '                    .Write("</b>")
        '                    'End of Addition by SrikanthY

        '                End If
        '            End If
        '        Else
        '            '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, )
        '            '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        '        End If
        '    End If
        '    'end addition by harshada d
        '    '-----------------------------------------------------------------
        '    '*********************Row 3****************
        '    ' function
        '    .Write("<tr class=clsTREven>")
        '    ' .Write("<td  align=right width='30%'>" & m_strFunction_Caption & "</td>")
        '    .Write("<td  align=right >" & m_strFunction_Caption & "</td>")
        '    '.Write("<td  width='70%'>")
        '    .Write("<td>")
        '    '----------------------------------------------------------------------------------------------
        '    'Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        '    'Integrated by SavitaS on 20 dec 2005 to show customers only those depts which are made accessible to them for IssueID 1936
        '    'added by harshada d on 19 Dec 2005 for Helpdesk
        '    'If (m_strVal <> "I") Or (Session("intPostID").ToString = "23") Then  'Commented by SavitaS on 30 Jan 2006 
        '    Dim strSQLRole As String
        '    Dim drRole As IDataReader
        '    Dim lngPostID As Long = 0
        '    ' to take postid of the employee at corporate level not from session
        '    drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
        '    If drRole.Read Then
        '        lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
        '    End If
        '    CommonFunctions.Data.DisposeDataReader(drRole)
        '    If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
        '        strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
        '        strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
        '        'strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where  "
        '    ElseIf m_intRequestedEmployee <> 0 Then
        '        ' modified by harshada d for issue id 1936 for Whiziblesem 6.0 for helpdesk enhancements 
        '        ' strSQL = "usp_CRM_GetFunctions_ForRole " & Session("intPostID").ToString
        '        strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString

        '    Else
        '        ' modified by harshada d for issue id 1936 for Whiziblesem 6.0 for helpdesk enhancements 
        '        ' strSQL = "usp_CRM_GetFunctions_ForRole " & Session("intPostID").ToString
        '        strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
        '        ' modified by harshada d for issue id 1936 for Whiziblesem 6.0 for helpdesk enhancements 
        '    End If
        '    'End Integration by SavitaS on 20 dec 2005
        '    'End Integration
        '    'commented by harshada d for whiziblesem 6.0 issue id 1936
        '    'If lngFunctionID = 0 Then
        '    '    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        '    '    If dr.Read Then lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("DepartmentID"), "0"), Long)
        '    '    CommonFunctions.Data.DisposeDataReader(dr)
        '    'End If
        '    'end of commentation by harshada d for whiziblesem 6.0 issue id 1936

        '    If blnDisableFunctionCombo Then
        '        '----------------------------------------------------------------------------------------------
        '        'Commented and Added by SavitaS on 21 Dec 2005 for IssueID 1936
        '        'added by SachinR   on 14 Dec 2005
        '        If m_strLoginType <> "C" Then
        '            If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
        '                strSQL += "," + lngRequestID.ToString
        '            End If
        '        End If
        '        CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, " disabled ", True, , , True)
        '    Else
        '        If m_strLoginType <> "E" Then
        '            CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, , , True)
        '        Else
        '            If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
        '                CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, , , True)
        '            Else
        '                'End Addition by SavitaS
        '                CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, "onchange=javascript:cboFunction_OnChange()", True, , , True)
        '            End If

        '        End If
        '        'End Integration by SavitaS
        '        '-------------------------------------------------------------------------------------------
        '    End If
        '    .Write("</td>")
        '    'Code Commented By PradipK to Change UI of Help Desk Page
        '    '.Write("</tr>")
        '    '----------------------------------------------------------------------------
        '    'Integrated by SavitaS on 21 Dec 2005 for whiz2->Help Desk (IssueID 1936)
        '    'Added by SavitaS on 21 Nov 2005 for WhiziblesemSP4 enhancement
        '    'Purpose: To allow resources to change Request and SubRequestType in edit mode 
        '    'if that resource come under "Configuration->Department Master->Configure HRMs" tab

        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '        'Purpose: added one condition for My e-Dashboard (MD)
        '        'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
        '        If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
        '            'End of addition by PrashantSJ on 09 Nov 2006
        '            strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
        '            dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        '            If dr.Read Then
        '                m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
        '            End If
        '            CommonFunctions.Data.DisposeDataReader(dr)

        '            If m_lngCRMID <> 0 Then
        '                blnDisableSubRequestTypeCombo = False 'To enable Request and Sub Request Type Combo
        '                If CommonFunction.Application.SplitRequestTypeSubType = True Then
        '                    'To select matchfield for RequestType combo when SplitRequestTypeSubType is true
        '                    If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
        '                        m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
        '                    Else
        '                    End If
        '                    strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
        '                    If Trim(strSubrequestType & "") <> "" Then
        '                        arr = Split(strSubrequestType, "|")
        '                        If Trim(arr(0) & "") <> "" Then
        '                            m_lngSubRequestTypeID = CType(arr(0), Long)
        '                        End If
        '                    End If
        '                    'Added by SavitaS on 16 Dec 2005 for IssueID 1936 to select matchfield for RequestType combo when SplitRequestTypeSubType is false 
        '                Else
        '                    strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")

        '                    arr = Split(strSubrequestType, "|")
        '                    If Trim(arr(0) & "") <> "" Then
        '                        m_lngSubRequestTypeID = CType(arr(0), Long)
        '                    End If

        '                    If Trim(strSubrequestType & "") = "" Then
        '                        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
        '                        If dr.Read Then
        '                            strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
        '                        End If
        '                        CommonFunctions.Data.DisposeDataReader(dr)
        '                    End If
        '                    'End Addition by SavitaS on 16 Dec 2005
        '                End If
        '                'Added by Harshada D for whizible 6.0 helpdesk enhancements issue id 1936
        '                ' if the person is non -HRM and has access to E= dashboard then the user is not allowed to change the assign to 
        '            Else
        '                blnDisabledAssignToCombo = True
        '                'end of Addition by Harshada D for whizible 6.0 helpdesk enhancements issue id 1936
        '            End If
        '        End If
        '    End If
        '    'End Addition by SavitaS for WhiziblesemSP4 enhancement
        '    'End Integration
        '    '---------------------------------------------------------------------------
        '    'Added By SantoshK on 30th Nov 2004
        '    'Seperate Request Type and SubRequest Type
        '    'request type
        '    'function Name need to be changed
        '    'if Applcation Variable is SET

        '    'Commented and Added by SavitaS on 21 Dec 2005 for IssueID 1936
        '    '--------------------------------------------------------------------------------------
        '    'If CommonFunction.Application.SplitRequestTypeSubType = True Then
        '    '.Write("<tr class=clsTREven>")
        '    '.Write("<td  align=right width='30%'> Request Type </td>")
        '    '.Write("<td  width='70%'>")

        '    ''added by  shubhadal
        '    'If (m_strLoginType = "C") Then
        '    '    lngFunctionID = 22
        '    'End If
        '    ''ended by  shubhadal

        '    'strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0"
        '    '' Modified By NitinVS on 13 Sep 2005 for CSL Customization IssueId 73 
        '    '' used seperate Bln Variable for Request Type and Sub Request Type 
        '    ''If blnDisableSubRequestTypeCombo Then
        '    'If blnDisableRequestTypeCombo Then
        '    '    ' end Modification By NitinVS on 13 Sep 2005 for CSL Customization IssueId 73 
        '    '    'ShubhadaL

        '    '    If (m_strLoginType = "C") Then
        '    '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, "28", " disabled ", True, , , True)
        '    '        'end by ShubhadaL
        '    '    Else
        '    '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, m_lngRequestTypeId.ToString, " disabled ", True, , , True)
        '    '    End If
        '    'Else
        '    '    'shubhadal
        '    '    If (m_strLoginType = "C") Then
        '    '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, "28", " disabled ", True, , , True)
        '    '        'end by ShubhadaL
        '    '    Else
        '    '        CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 0, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
        '    '    End If
        '    'End If

        '    '    'sub requst type
        '    '    .Write("<tr class=clsTREven>")
        '    '    .Write("<td  align=right width='30%'> " & m_strSubRequestType_Caption & " </td>")
        '    '    .Write("<td  width='70%'>")
        '    '    'added by shubhadal
        '    '    If (m_strLoginType = "C") Then
        '    '        lngFunctionID = 22
        '    '        m_lngRequestTypeId = 28
        '    '    End If
        '    '    'ended by shubhadal
        '    '    strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString)
        '    '    If blnDisableSubRequestTypeCombo Then
        '    '        'ShubhadaL
        '    '        If (m_strLoginType = "C") Then
        '    '            If m_lngSubRequestTypeID <> 101 Then
        '    '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, m_lngSubRequestTypeID.ToString, " disabled ", True, , , True)
        '    '            Else
        '    '                CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)
        '    '            End If

        '    '        Else 'end by ShubhadaL
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, m_lngSubRequestTypeID.ToString, " disabled ", True, , , True)
        '    '        End If
        '    '    Else
        '    '        'ShubhadaL
        '    '        If (m_strLoginType = "C") Then
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)
        '    '        Else 'End by ShubhadaL
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
        '    '        End If
        '    '    End If
        '    'Else
        '    '    'sub requst type
        '    '    .Write("<tr class=clsTREven>")
        '    '    .Write("<td  align=right width='30%'> Request Type </td>")
        '    '    .Write("<td  width='70%'>")
        '    '    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0"
        '    '    If blnDisableSubRequestTypeCombo Then
        '    '        'ShubhadaL
        '    '        If (m_strLoginType = "C") Then
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)

        '    '        Else 'end by ShubhadaL
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, strSubrequestType, " disabled ", True, , , True)
        '    '        End If
        '    '    Else
        '    '        'ShubhadaL
        '    '        If (m_strLoginType = "C") Then
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, "101", " disabled ", True, , , True)
        '    '        Else 'End by ShubhadaL
        '    '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 0, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
        '    '        End If
        '    '    End If 'ShubhadaL
        '    ' End If
        '    If CommonFunction.Application.SplitRequestTypeSubType = True Then
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("<tr class=clsTREven>")
        '        '.Write("<td  align=right width='30%'> Request Type </td>")
        '        '.Write("<td  width='70%'>")
        '        .Write("<td  align=right > Request Type </td>")
        '        .Write("<td>")

        '        If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
        '            strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
        '            strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
        '            strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
        '            strSQL += "  and RoleID =23 AND functionID = " & lngFunctionID
        '        Else
        '            'Modifed BY NitinVS on 16 MAr 2007 for WhizibleSEM SP Regression Issue 11342
        '            ' To Show existing Request type evenif the logged in role does not have access to it. 
        '            'Passed  lngRequestTypeIdOld.ToString para

        '            'Modified by SrikanthY on 15 Jan 2007 For issue 9442
        '            ' sub Request Type ID parameter added by harshada d for Whiziblesem 6.0 helpdesk enhancemnts issue id 1936
        '            If m_intRequestedEmployee <> 0 Then
        '                strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
        '            Else
        '                strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
        '            End If

        '            ' sub Request Type ID parameter by harshada d for Whiziblesem 6.0 helpdesk enhancemnts issue id 1936
        '            'End of modification by SrikanthY
        '        End If


        '        If blnDisableSubRequestTypeCombo Then
        '            CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 300, m_lngRequestTypeId.ToString, " disabled ", True, , , True)
        '        Else
        '            CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 300, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)

        '        End If
        '        'Sub Requst Type
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("<tr class=clsTREven>")
        '        '.Write("<td  align=right width='30%'> " & m_strSubRequestType_Caption & " </td>")
        '        '.Write("<td  width='70%'>")
        '        .Write("<td  align=right> " & m_strSubRequestType_Caption & " </td>")
        '        .Write("<td>")


        '        If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
        '            'commented by harshada d for whiziblesem 6 helpdesk issue id 1936 : as we provide the default values for function id and request type the following code is not necessary

        '            'If Trim(MyBase.GetFormValue("cboFunction") & "") = "" Then
        '            '    If lngFunctionID = 0 Then
        '            '        m_lngRequestTypeId = 0
        '            '    End If
        '            'End If

        '            'If Trim(MyBase.GetFormValue("cboRequestType") & "") = "" Then
        '            '    m_lngRequestTypeId = 0
        '            'End If
        '            ' end of commentation of harshada D


        '            strSQL = " select tbl_CRM_RequestType_SubRequestType.SubRequestTypeID ,tbl_CRM_SubRequestType.SubRequestType "
        '            strSQL += " from  tbl_CRM_RequestType_SubRequestType, tbl_CRM_SubRequestType  where "
        '            strSQL += " tbl_CRM_RequestType_SubRequestType.subRequestTypeID = tbl_CRM_SubRequestType.SubRequestTypeID "
        '            strSQL += " and tbl_CRM_RequestType_SubRequestType.RequestTypeID = " & m_lngRequestTypeId.ToString
        '        Else
        '            'Modified by SrikanthY on 15 Jan 2007 For issue 9442
        '            If m_intRequestedEmployee <> 0 Then
        '                strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        '            Else
        '                strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
        '            End If
        '            'End of modification by SrikanthY

        '        End If
        '        If blnDisableSubRequestTypeCombo Then
        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, " disabled ", True, , , True)
        '        Else
        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
        '        End If
        '    Else
        '        'Sub Requst Type
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("<tr class=clsTREven>")
        '        .Write("<td  align=right > Request Type </td>")
        '        .Write("<td colspan=3>")
        '        If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
        '            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",null,'C',0"
        '        Else
        '            'Modified by SrikanthY on 15 Jan 2007 For issue 9442
        '            If m_intRequestedEmployee <> 0 Then
        '                strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
        '            Else
        '                strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
        '            End If
        '            'End of modification by SrikanthY
        '        End If
        '        ' this code is added by harshada d for whiziblesem 6.0 for helpdesk enhancements 1936
        '        ' if the combo should persist the value selected in the combo
        '        '''''''''''''''''''''' ***************************
        '        If Not Page.IsPostBack Then
        '            If CommonFunction.Application.SplitRequestTypeSubType = False Then
        '                strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
        '            End If
        '            ''''''''''''''''''''''''''''''''''''''***************************
        '        End If

        '        If blnDisableSubRequestTypeCombo Then
        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 300, strSubrequestType, " disabled ", True, , , True)
        '        Else
        '            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 300, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, , , True)
        '        End If
        '    End If
        '    '-----------------------------------------------------------------------------------------
        '    'Template
        '    If m_lngSubRequestTypeID <> 0 Then
        '        strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
        '        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        '        If dr.Read Then
        '            intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
        '            Select Case intTemplateCount
        '                Case 0 ' no templates
        '                    ' Commented by MonikaI on 14th Jul 2009 
        '                    ' RequestID 21655 Not able to download template attached with sub type if File server is different.
        '                    'Case 1 ' only one template
        '                    '    '.Write("<font face=verdana;Arial size=1>")
        '                    '    .Write("<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateID"), "0"), Long)) & "' >" & vbCrLf)
        '                    '    '.Write("<B>View Template</B>")
        '                    '    .Write("<Image Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'>")
        '                    '    .Write("</A>")
        '                    ' End of modification by MonikaI on 14th Jul 2009
        '                Case Else ' multiple templates
        '                    '.Write("<font face=verdana;Arial size=1><A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><B> View Templates</B></A></font>")
        '                    .Write("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'></A>")

        '                    '            Write("<A href='JavaScript:MoveToDept_OnClick()'><img src='../../../responsive/images/star.gif'> </A></font>")
        '            End Select
        '        End If
        '        CommonFunctions.Data.DisposeDataReader(dr)
        '    End If
        '    If CommonFunction.Application.SplitRequestTypeSubType = True Then
        '        .Write("</td>")
        '        .Write("</tr>")
        '    Else
        '        'Sub Request Type not Ploted..
        '        .Write("</td>")
        '        .Write("</tr>")
        '    End If
        '    '******************************End Row 3***************

        '    ' Guidelines
        '    'added for Helpdesk Enhancements whizible 6.0 Issue ID 1936
        '    If UCase(Trim(m_strFromWhere & "")) <> "DB" Then
        '        'end of added for Helpdesk Enhancements whizible 6.0 Issue ID 1936
        '        'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '        'Purpose: added one condition for My e-Dashboard (MD)
        '        If UCase(Trim(m_strFromWhere & "")) <> "MD" Then
        '            'End of addition by PrashantSJ on 09 Nov 2006
        '            If Trim(m_lngSubRequestTypeID & "") <> "" Then
        '                dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & m_lngSubRequestTypeID, m_blnUseSQL)
        '                If dr.Read Then
        '                    If Trim(dr(strGuidelinesColumnName).ToString & "") <> "" Then
        '                        .Write("<TR class=clsTREven><td  align=right VAlign=Top>")
        '                        .Write(GetCaption(919, strGuidelinesColumnName))
        '                        .Write("</td>")
        '                        .Write("<td  VAlign=Top colspan=5 ><PRE>")
        '                        .Write(dr(strGuidelinesColumnName).ToString & "</PRE>")
        '                        'Code Added By PradipK to Change UI of Help Desk Page
        '                        ' .Write("</td><td></td><td></td><td></td><td>")
        '                        .Write("</td></tr>")
        '                    End If
        '                End If
        '                CommonFunction.Data.DisposeDataReader(dr)
        '            End If
        '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '            'Purpose: added one condition for My e-Dashboard (MD)
        '        End If
        '        'End of addition by PrashantSJ on 09 Nov 2006
        '    End If

        '    ' subject
        '    .Write("<TR class=clsTREven>")
        '    .Write("<TD align=right>" & m_strSubject_Caption & "</TD>")
        '    .Write("<TD colspan=5>")
        '    CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , intWidth, intPixelSize, strSubject, , , blnDisbaledSubjectTextBox, , , , , , True)
        '    .Write("</TD>")
        '    'Code Added By PradipK to Change UI of Help Desk Page
        '    '.Write("<td></td><td></td><td></td><td></td>")
        '    .Write("</TR>")
        '    '.Write("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
        '    ' Description
        '    .Write("<TR class=clsTREven>")
        '    .Write("<TD align=right vAlign=top>" & m_strDescription_Caption & "</TD>")
        '    .Write("<TD colspan=5> ")
        '    'Modified By ShraddhaM on 27 July 2006
        '    CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , , , , , , , , "Soft", )
        '    .Write("</TD></TR>")
        '    'Code Added By PradipK to Change UI of Help Desk Page
        '    ' .Write("<td></td><td></td>")
        '    ' .Write("</TR></Table>")

        '    ''Product & Component
        '    ' Commented By NitinVS on 30 SEP 2009 datareader is redefined below 
        '    'dr = CommonFunction.Data.GetDataReader("If Exists( SELECT EnableProductExecution FROM  tbl_PM_companyinformation WHERE IsNULL(EnableProductExecution,0)=(SELECT ExposeToCustomer from tbl_PM_DepartmentMaster WHERE DepartmentID='" & lngFunctionID.ToString & "'   AND IsNULL(ExposeToCustomer,0)=1)) select 1 ", m_blnUseSQL)
        '    ' End comment by NitinVS on 30 sep 2009


        '    Dim drGetDepartmentID As IDataReader

        '    If (m_strLoginType = "C") And UCase(Trim(m_strMode & "")) = "NEW" And lngFunctionID = 0 Then
        '        drGetDepartmentID = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_DepartmentMaster_ForCustomer ", m_blnUseSQL)
        '        If drGetDepartmentID.Read Then

        '            dr = CommonFunction.Data.GetDataReader("If Exists( SELECT EnableProductExecution FROM  tbl_PM_companyinformation WHERE IsNULL(EnableProductExecution,0)=(SELECT ExposeToCustomer from tbl_PM_DepartmentMaster WHERE DepartmentID='" & CType(CommonFunctions.Data.CheckIsDBNull(drGetDepartmentID("DepartmentID"), "0"), String) & "'   AND IsNULL(ExposeToCustomer,0)=1)) select 1 ", m_blnUseSQL)
        '            If dr.Read Then
        '                ShowProductCombo = "1"
        '            End If
        '            CommonFunction.Data.DisposeDataReader(dr)
        '        End If
        '        CommonFunction.Data.DisposeDataReader(drGetDepartmentID)

        '    Else

        '    End If

        '    ' If showproductcombo is not set for new mode of onbehalf of customer 
        '    If ShowProductCombo <> "1" Then
        '        dr = CommonFunction.Data.GetDataReader("If Exists( SELECT EnableProductExecution FROM  tbl_PM_companyinformation WHERE IsNULL(EnableProductExecution,0)=(SELECT ExposeToCustomer from tbl_PM_DepartmentMaster WHERE DepartmentID='" & lngFunctionID.ToString & "'   AND IsNULL(ExposeToCustomer,0)=1))select 1 ", m_blnUseSQL)
        '        If dr.Read Then
        '            ShowProductCombo = "1"
        '        End If
        '        CommonFunction.Data.DisposeDataReader(dr)
        '    End If

        '    ' Modified By NitinVs on 14 Feb 2007 For SP9 
        '    ' Added Parameter QueryId to Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component
        '    ' and added HR tag 
        '    If ShowProductCombo = "1" Then
        '        If (m_intCustomer <> 0 And m_strLoginType = "E") Or m_strLoginType = "C" Or m_RequeststrLoginType.ToUpper = "C" Then

        '            .Write("<tr class=clsTREven><td colspan=6><HR></td></tr>")
        '            .Write("<tr class=clsTREven>")
        '            .Write("<td  align=right>" & "Product" & "</td>")
        '            'Modified by PrajaktaR on 17th Feb 2007 for WhizibleSEM SP9 UI not proper
        '            .Write("<td >")
        '            '.Write("<td>")
        '            'END OF Modification by PrajaktaR on 17th Feb 2007 for WhizibleSEM SP9 UI not proper


        '            If m_strLoginType = "C" Then
        '                CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, , , False)
        '            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then

        '                CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, , , False)
        '            Else
        '                dr = CommonFunction.Data.GetDataReader("SELECT Customer  FROM tbl_PM_Customer WHERE CustomerID='" & strRequestor & "'", m_blnUseSQL)
        '                If dr.Read Then
        '                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
        '                Else
        '                    strRequestorID = "0"
        '                End If
        '                CommonFunction.Data.DisposeDataReader(dr)
        '                CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, , , False)
        '            End If
        '            .Write("</td>")
        '            .Write("<td  align=right>" & "Module/Component" & "</td>")
        '            'Modified by PrajaktaR on 17th Feb 2007 for WhizibleSEM SP9 UI not proper
        '            .Write("<td  colspan='3'>")
        '            '.Write("<td>")
        '            'END OF Modification by PrajaktaR on 17th Feb 2007 for WhizibleSEM SP9 UI not proper
        '            If m_strLoginType = "C" Then
        '                CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, , , False)
        '            ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
        '                CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, , , False)
        '            Else
        '                dr = CommonFunction.Data.GetDataReader("SELECT Customer  FROM tbl_PM_Customer WHERE CustomerID='" & strRequestor & "'", m_blnUseSQL)
        '                If dr.Read Then
        '                    strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
        '                Else
        '                    strRequestorID = "0"
        '                End If
        '                CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, , , False)

        '                CommonFunction.Data.DisposeDataReader(dr)
        '            End If
        '            '.Write("</td><td></td><td></td></tr>")
        '            'Added by PrajaktaR - GUI was not proper
        '            '.Write("</td><td></td><td>")
        '            'End Of Addition by PrajaktaR - GUI was not proper
        '            .Write("</td></tr>")
        '            .Write("<tr  class=clsTREven><td colspan=6><HR></td></tr>")
        '        End If
        '    End If

        '    'End Modification By NitinVs on  14 Feb 2007 for SP9

        '    '*********Row 6***************
        '    ' priority
        '    .Write("<TR class=clsTREven>")
        '    .Write("<TD align=right>" & m_strPriority_Caption & "</TD>")
        '    .Write("<TD>")
        '    strSQL = "usp_CRM_Get_RequestPriority"
        '    'Modified By NitinVs on 13 Mar 2007 for WhizibleSEM SP 8 Issue 11168 
        '    'Priority added a blank row so in add new mode will not be defaulted for first time.
        '    CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, , True, , , True)
        '    'end Modification By nitinVS on 13 Mar 2007 for WhizibleSEM SP 8 Issue 11168 
        '    .Write("</TD>")
        '    'Modified By NitinVS on 19 FEb 2007 for IssueID 10366
        '    ' Add Field for Severity 
        '    .Write("<td align=right>" & m_strSeverity_Caption & "</TD>")
        '    .Write("<TD colspan=3>")
        '    strSQL = "usp_CRM_Get_RequestSeverity"
        '    CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, , True)
        '    .Write("</TD>")

        '    .Write("</tr>")
        '    'Code Commented By PradipK to Change UI of Help Desk Page
        '    ' .Write("</TR>")
        '    '''''''''''''''''
        '    '''shraddha 23June
        '    '.Write("<TR>")
        '    '.Write("<TD>")
        '    'CommonFunction.HTMLControls.DrawTextArea("txtFilterHidden", "txtFilterHidden", , , , "frmRequestDetails", , , 100, 100, , strFilter, , , , , , True, , , , , , , , , , )
        '    '.Write("</TD>")
        '    '.Write("<TD>")
        '    'CommonFunction.HTMLControls.DrawTextArea("txtDepartmentHidden", "txtDepartmentHidden", , , , "frmRequestDetails", , , 100, 100, , strDept, , , , , , True, , , , , , , , , , )
        '    '.Write("</TD>")
        '    '.Write("<TD>")
        '    'CommonFunction.HTMLControls.DrawTextArea("txtStatusHidden", "txtStatusHidden", , , , "frmRequestDetails", , , 100, 100, , strStatus, , , , , , True, , , , , , , , , , )
        '    '.Write("</TD>")
        '    '.Write("</TR>")
        '    ''Ended shraddha
        '    ' Exp. resolution date
        '    '----------------------------------------------------------------------------------------------
        '    'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        '    'added by Shubhadal
        '    'If (m_strLoginType <> "C") Then
        '    'Modified by SavitaS on 19 Dec 2005 to show Exp. Resolved Date in edit mode for IssueID 1936
        '    '===========================================================================

        '    ' Commented BY NitinVS on 19 Feb 2007 
        '    'If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '    '    If m_strLoginType <> "C" Then
        '    '        'Code Commented By PradipK to Change UI of Help Desk Page
        '    '        '.Write("<TR class=clsTREven>")
        '    '        .Write("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
        '    '        .Write("<TD>")
        '    '        'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
        '    '        If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '    '            ' an assignee can see the date as read-only
        '    '            CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)
        '    '            .Write("</TD>")
        '    '            'Code Commented By PradipK to Change UI of Help Desk Page
        '    '            '.Write("</TR>")
        '    '        Else
        '    '            ' admin/requestor ofcourse can change the date
        '    '            CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
        '    '            .Write("</TD>")
        '    '            'Code Commented By PradipK to Change UI of Help Desk Page
        '    '            ' .Write("</TR>")
        '    '        End If
        '    '    Else
        '    '        .Write("<TD></TD><TD></TD>")
        '    '    End If
        '    'End If
        '    ''End Modification by SavitaS on 19 Dec 2005
        '    ''===========================================================================
        '    ''----------------------------------------------------------------------------------------------
        '    ''Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        '    'If UCase(Trim(m_strMode & "")) = "NEW" Then
        '    '    If m_strLoginType <> "C" And m_strVal <> "C" Then
        '    '        'Code Commented By PradipK to Change UI of Help Desk Page
        '    '        ' .Write("<TR class=clsTREven>")
        '    '        .Write("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
        '    '        .Write("<TD>")
        '    '    Else
        '    '        'Code Added By PradipK to Change UI of Help Desk Page
        '    '        .Write("<TD></TD><TD></TD>")

        '    '    End If
        '    '    'End If 'statement added by ShubhadaL

        '    '    'If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '    '    '    'added by ShubhadaL
        '    '    '    If (m_strLoginType = "C") Then

        '    '    '        CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , CommonFunctions.Dates.GetDate(Now()).ToString, , "frmRequestDetails", , , , , True, , , True, , , True)
        '    '    '        'end of addition by shubhadal
        '    '    '    Else
        '    '    '        ' an assignee can see the date as read-only
        '    '    '        CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)

        '    '    '    End If
        '    '    'Else
        '    '    '    ''added by ShubhadaL
        '    '    '    'If (m_strLoginType = "C") Then
        '    '    '    '    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , CommonFunctions.Dates.GetDate(Now()).ToString, , "frmRequestDetails", , , , , , , , True, , , True)
        '    '    '    'Else 'addition ends

        '    '    '    ' admin/requestor ofcourse can change the date
        '    '    '    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
        '    '    'End If
        '    '    'End If 'statement added by shubhadal
        '    '    'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
        '    '    If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '    '        ' an assignee can see the date as read-only
        '    '        CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)
        '    '        .Write("</TD>")
        '    '        'Code Commented By PradipK to Change UI of Help Desk Page
        '    '        ' .Write("</TR>")
        '    '    Else
        '    '        If m_strLoginType <> "C" And m_strVal <> "C" Then
        '    '            ' admin/requestor ofcourse can change the date
        '    '            CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
        '    '            .Write("</TD>")
        '    '            'Code Commented By PradipK to Change UI of Help Desk Page
        '    '            ' .Write("</TR>")
        '    '        End If
        '    '    End If
        '    'End If
        '    ''End Integration
        '    ''-------------------------------------------------------------------------------------------
        '    '' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old ResolutionDate
        '    'CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, displaynone:=True)
        '    '' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 
        '    ''----------------------------------------------------------------------------------------------
        '    ''Commented by by SavitaS on 21 Dec 2005 for IssueID 1936
        '    ''.Write("</TD>")
        '    ''.Write("</TR>")
        '    ''End Commnet
        '    '' hidden dates
        '    CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
        '    ''next two lines commeny=ted by ShubhadaL
        '    ''CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, strExpectedResolvedDate, , , , , , True, , )
        '    ''CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, strCRMExpectedResolvedDate, , , , , , True, , )
        '    ''added by ShubhadaL
        '    'CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
        '    'CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
        '    'CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , )
        '    ''end of addition


        '    'If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '    '    ' Exp. resolution date
        '    '    'added by ShubhadaL
        '    '    If (m_strLoginType <> "C") Then
        '    '        ' .Write("<TR class=clsTREven>")
        '    '        .Write("<TD align=right>" & m_strCRMExpectedResolvedDate_Caption & "</TD>")
        '    '        .Write("<TD>")
        '    '    End If 'statement added by ShubhadaL
        '    '    '----------------------------------------------------------------------------------------------
        '    '    'Commented by by SavitaS on 21 Dec 2005 for IssueID 1936

        '    '    'If UCase(Trim(m_strFromWhere & "")) = "DB" Then
        '    '    '    'added by ShubhadaL
        '    '    '    If (m_strLoginType = "C") Then
        '    '    '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , , , , , , , , True)
        '    '    '        'addition ended
        '    '    '    Else
        '    '    '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails")
        '    '    '    End If
        '    '    'Else
        '    '    '    'added by ShubhadaL
        '    '    '    If (m_strLoginType = "C") Then
        '    '    '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True, , , , , , , True)
        '    '    '    Else 'addition ended
        '    '    '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True)
        '    '    '    End If
        '    '    '    .Write("</TD>")
        '    '    '    .Write("</TR>")
        '    '    'End If
        '    '    'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
        '    '    'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '    '    'Purpose: added one condition for My e-Dashboard (MD)
        '    '    'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
        '    '    If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
        '    '        'End of addition by PrashantSJ on 09 Nov 2006
        '    '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails")
        '    '        .Write("</TD>")
        '    '        'Code Added By PradipK to Change UI of Help Desk Page
        '    '        ' .Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '    '        .Write("</TR>")
        '    '    Else
        '    '        If m_strLoginType <> "C" Then
        '    '            CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True)
        '    '            .Write("</TD>")
        '    '            'Code Added By PradipK to Change UI of Help Desk Page
        '    '            ' .Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '    '            .Write("</TR>")
        '    '        Else
        '    '            .Write("<TD></TD><TD></TD>")
        '    '        End If
        '    '    End If
        '    '    '.Write("</TD>")
        '    '    '.Write("</TR>")
        '    '    'End Integration
        '    '    '-------------------------------------------------------------------------------------------
        '    'Else
        '    '    'Code Added By PradipK to Change UI of Help Desk Page
        '    '    .Write("<TD></TD><TD></TD>")
        '    '    .Write("</TR>")
        '    'End If

        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        '**********Row 5**********
        '        ' Status
        '        .Write("<TR class=clsTREven>")
        '        .Write("<TD align=right >" & m_strStatus_Caption & "</TD>")
        '        .Write("<TD >")
        '        strSQL = "usp_CRM_Get_RequestStatus"
        '        If blnDisableStatusCombo Then
        '            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, , " disabled ", , , , True)
        '        Else
        '            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , , , True)
        '        End If
        '        If intStatusID = 7 Then
        '            CommonFunctions.General.WriteHTML("<b><a href='javascript:ViewRejectionComments_OnClick()'>View Comments</a><b>")
        '        End If

        '        ' Modified By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 to store old status & CSL IssueID 79
        '        CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True)
        '        ' End Modification By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2  & CSL IssueID 79


        '        .Write("</TD>")
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("</TR>")
        '    End If

        '    'Integrated by MrugajaB for WhizibleSEM SP7 Issue ID.4262
        '    'Code Added By PradipK for Help Desk SLA 
        '    '18 May 2006
        '    Dim h As Integer
        '    Dim m As Integer
        '    'integreated by harshada d for whiziblesem sp7
        '    Dim strHour As String
        '    Dim strMinute As String
        '    'Addded By Amit J For PSPL IssueId - 22880    
        '    'Get Server Date & Time
        '    Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        '    Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        '    Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        '    Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        '    'strGetServerDate1 = CommonFunctions.Dates.CGetDate(CType(strGetServerDate1.ToString, Date))
        '    h = CType(Left(strGetServerTime1, 2), Integer)
        '    m = CType(Right(strGetServerTime1, 2), Integer)
        '    'End of Addition
        '    'commented By AmitJ For PSPL IsueId = 22880
        '    ' h = Now().Hour
        '    ' m = Now().Minute
        '    'End of Commenting

        '    If h < 10 Then
        '        strHour = "0" + h.ToString
        '    Else
        '        strHour = h.ToString

        '    End If
        '    If m < 10 Then
        '        strMinute = "0" + m.ToString
        '    Else
        '        strMinute = m.ToString
        '    End If
        '    'end of integration by harshada d for whiziblesem sp7

        '    'SrikanthY on 23 Jan 2007 Added New Hidden elements.Issues-9640,9650
        '    CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilterState", "txtHiddenFilterState", , 400, 100, m_FilterData.ToString, , , , , , True, , )
        '    CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilter", "txtHiddenFilter", , 400, 100, m_Filter.ToString, , , , , , True, , )
        '    CommonFunctions.HTMLControls.DrawTextBox("txtHiddenDepartment", "txtHiddenDepartment", , 400, 100, m_Department.ToString, , , , , , True, , )
        '    CommonFunctions.HTMLControls.DrawTextBox("txtHiddenStatus", "txtHiddenStatus", , 400, 100, m_Status.ToString, , , , , , True, , )
        '    'End of addition by SrikanthY


        '    If UCase(Trim(m_strMode & "")) = "NEW" Then

        '    Else
        '        Dim strDate As String
        '        Dim strTime As String
        '        strDate = "select ISNULL(REPLACE((convert(varchar(50),cast(StatusChangeDate as smallDatetime),106)) ,' ','-'),'') FROM tbl_CRM_Query_Master where QueryID='" & m_lngQueryID & "'"
        '        strTime = "select ISNULL(StatusChangeTime,'') from tbl_CRM_Query_Master where QueryID=" & m_lngQueryID
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        ' .Write("<TR class=clsTREven>")
        '        'Code Added By PradipK to Change UI of Help Desk Page
        '        '.Write("<TD class=clsTREven>")
        '        'shraddha 24 July 2006
        '        If m_strLoginType = "E" Then
        '            .Write("<td align=right >" & m_strStatusChangeDate & "</TD>")
        '        Else
        '            .Write("<td align=right > </TD>")
        '        End If

        '        .Write("<TD >")

        '        Dim strdt As String = CType(CommonFunctions.Data.GetDataScalar(strDate, True), String).ToString

        '        Dim strtm As String = CType(CommonFunctions.Data.GetDataScalar(strTime, True).ToString, String)

        '        'Hidden date control contains DateValue of particular status from database
        '        CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , strdt, , "frmRequestDetails", , , , , , , , False, , , True, )

        '        'control contains DateValue of particular status from database
        '        If m_strLoginType = "C" Then
        '            'shraddha 24 July 2006
        '            CommonFunction.HTMLControls.DrawTextBox("txtReadOnlychangedDate", "txtReadOnlychangedDate", , 80, , CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(strdt), , , , True, , True, , , False, , , ).ToString()

        '            CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , False, , , True)
        '        Else
        '            CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , True, , , )
        '        End If

        '        'CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , strdt, , "frmRequestDetails", , , , , , , , True, , , )

        '        ' .Write("</TD>")
        '        ' .Write("<td align=right>" & m_strStatusChangeTime & "</TD>")
        '        '.Write("       " & m_strStatusChangeTime)
        '        ' .Write("<TD>")

        '        'Modified by ShraddhaM on Date 16 June,2006 for WhizibleSEM Issue ID.4168

        '        'hidden time control contains TimeValue of particular status from database
        '        'Modified By ShraddhaM on 27 July 2006
        '        CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , strtm, , , , , , True, , , , , , , , True, "Soft", )


        '        'Ended by ShraddhaM on Date 16 June,2006 for WhizibleSEM Issue ID.4168

        '        'hidden time control contains TimeValue of particular status from database
        '        'CommonFunction.HTMLControls.DrawTextBox("txtchangedTimeHidden1", "txtchangedTimeHidden1", , , , strtm, , , , , , True, , , False, , , , )

        '        .Write("</TD>")
        '        If m_strLoginType = "E" Then
        '            .Write("<td align=right >" & m_strStatusChangeTime & "</TD>")
        '        Else
        '            .Write("<td align=right > </TD>")
        '        End If

        '        .Write("<TD >")

        '        If m_strLoginType = "C" Then
        '            CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , True, , True, , , False, , , ).ToString()
        '        Else
        '            CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , ).ToString()
        '        End If

        '        'control contains TimeValue of particular status from database     

        '        ''If m_strLoginType = "C" Then
        '        ''    CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , True, , True, , , False, , , ).ToString()
        '        ''Else
        '        ''    .Write("       " & m_strStatusChangeTime)
        '        ''    CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , ).ToString()
        '        ''End If


        '        '  CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , strtm, , , , , , , , , True, , , ).ToString()

        '        .Write("</TD>")
        '        .Write("</TR>")
        '        'integrated by harshada d for whiziblesem sp7
        '        'commented by amit J for issueid 22880 - PSPL 

        '        'CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), , "frmRequestDetails", , , , , , , , False, , , True)

        '        'End of commenting
        '        'Added By AmitJ for issueid 22880 - PSPL 
        '        'CurrentDate field will hold date of server ,not  of client
        '        CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmRequestDetails", , , , , , , , False, , , True)
        '        CommonFunction.General.WriteHTML("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
        '        'End of addition

        '        CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True)
        '        'end of integration by harshada d
        '        Dim strCurrentHours As String
        '        Dim strCurrentTime As String

        '        strCurrentHours = Now.Hour.ToString
        '        If CType(Now.Hour.ToString, Integer) < 10 Then
        '            strCurrentHours = "0" + Now.Hour.ToString
        '        End If
        '        strCurrentTime = Now.Minute.ToString
        '        If CType(Now.Minute.ToString, Integer) < 10 Then
        '            strCurrentTime = "0" + Now.Minute.ToString
        '        End If

        '        Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strCurrentHours + ":" + strCurrentTime, IsHidden:=True))
        '        'CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , Now.Hour.ToString + ":" + Now.Minute.ToString, IsHidden:=True)

        '    End If
        '    'End Addition By PradipK for Help Desk SLA 
        '    '**************Row 8***********
        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        Select Case UCase(Trim(m_strFromWhere & ""))
        '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '            'Purpose: added one condition for My e-Dashboard (MD)
        '            'Case "DB", "AR"
        '            Case "DB", "AR", "MD"
        '                'End of addition by PrashantSJ on 09 Nov 2006
        '                ' CRM Comments
        '                ' added by ShubhadaL
        '                If (m_strLoginType <> "C") Then
        '                    .Write("<TR class=clsTREven>")
        '                    .Write("<TD align=right vAlign=top>" & m_strComments_Caption & "</TD>")
        '                    .Write("<TD colspan=5>")
        '                End If 'statement  by ShubhadaL

        '                'added by ShubhadaL
        '                If (m_strLoginType = "C") Then
        '                    'Modified By ShraddhaM on 27 July 2006
        '                    CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , , blnReadOnlyComments, , , , , , , , , , True, "Soft", )
        '                Else
        '                    'Modified By ShraddhaM on 27 July 2006
        '                    CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , , , , , , , , "Soft", )
        '                End If
        '                'Modifed By nitinVS on 14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 
        '                'To Persist value for  Reason for rejection when saved 
        '                CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , , , , , , , True, "Soft", )
        '                'End Modification BY nitinVs on  14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 

        '                .Write("</TD>")
        '                'Code Added By PradipK to Change UI of Help Desk Page
        '                '.Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '                .Write("</TR>")
        '            Case "SR"
        '                'Modifed By nitinVS on 14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 
        '                'To Persist value for Comments when saved 
        '                CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , 400, 100, , strComments, , , , blnReadOnlyComments, , , , , , , , , , True, "Soft", )
        '                'End Modification BY nitinVs on  14 Mar 2007 for WhizibleSEMSP 8 IssueId 11691 

        '                If intStatusID = 7 Then
        '                    ' Reasons for rejection
        '                    If (m_strLoginType <> "C") Then 'Statement added by Shubhadal
        '                        .Write("<TR class=clsTREven>")
        '                        .Write("<TD align=right vAlign=top>" & m_strReasonsForRejection_Caption & "</TD >")
        '                        .Write("<TD colspan=5>")
        '                    End If 'Statement added by Shubhadal
        '                    'added by ShubhadaL
        '                    If (m_strLoginType = "C") Then
        '                        'Modified By ShraddhaM on 27 July 2006
        '                        CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , intWidth, intPixelSize, , strReasonsForRejection, , , , True, , , , , , , , , , True, "Soft", )
        '                    Else
        '                        'Modified By ShraddhaM on 27 July 2006
        '                        CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , intWidth, intPixelSize, , strReasonsForRejection, , , , True, , , , , , , , , , , "Soft", )
        '                        .Write("</TD>")
        '                        'Code Added By PradipK to Change UI of Help Desk Page
        '                        '.Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '                        .Write("</TR>")
        '                    End If
        '                End If 'statement added by Shubhadal
        '        End Select

        '    End If
        '    '            .Write("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")

        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        ' Assign TO
        '        If (m_strLoginType <> "C") Then ' addition by ShubhadaL
        '            'Code Commented By PradipK to Change UI of Help Desk Page
        '            .Write("<TR class=clsTREven>")
        '            .Write("<TD align=right>" & m_strAssignTo_Caption & "</TD>")
        '            .Write("<TD>")
        '        End If 'statement added by shubhadal
        '        'modfied by harshada d for whiziblesem 6.0 for helodesk enhancements for issue id 1936 on 08 March 2006
        '        'strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",1," & lngAssignTo.ToString
        '        strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString
        '        'end of modfied by harshada d for whiziblesem 6.0 for helodesk enhancements for issue id 1936 on 08 March 2006
        '        If blnDisabledAssignToCombo Then
        '            ' added by ShubhadaL
        '            If (m_strLoginType = "C") Then 'end of addition by ShubhadaL
        '                CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, " disabled ", True, , , , , True)
        '            Else 'end of addition
        '                CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, " disabled ", True)
        '            End If 'statement added  by ShubhadaL
        '            ' Modified By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old AssignTO & CSL ISssueID 79
        '            CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True)

        '            .Write("</TD>")
        '            'Code Commented By PradipK to Change UI of Help Desk Page

        '            ' End Modification By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL ISssueID 79
        '        Else
        '            ' added by ShubhadaL
        '            If (m_strLoginType = "C") Then
        '                CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, , True, , , , , True)
        '                'end of addition by ShubhadaL

        '            Else

        '                CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, , True)
        '            End If
        '            'added by harshada d for whiziblesem 6 helpdesk enhancements issue ID 1936
        '            .Write("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
        '            'end of addition by harshada d for whiziblesem 6 for helpdesk enhancements issue ID 1936


        '            ' added by ShubhadaL
        '            '      If (m_strLoginType = "C") Then
        '            '     CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, , , , , , , , , , , , True)
        '            '    Else
        '            ' Modified By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old AssignTO & CSL ISssueID 79
        '            CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True)
        '            ' End Modification By NitinVS on 3 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL ISssueID 79
        '            'End If 'added by Shubhadal
        '            CommonFunction.HTMLControls.DrawTextBox("txtSubmittedDate", "txtSubmittedDate", , , , lngAssignTo.ToString, DisplayNone:=True)
        '            .Write("</TD>")
        '            'Code Commented By PradipK to Change UI of Help Desk Page
        '            '.Write("</TR>")
        '            '.Write("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")
        '        End If 'statement added by ShubhadaL

        '        'Added By NitinVS for WhizibleSEM SP9 IssueDI 10366
        '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '            If m_strLoginType <> "C" Then
        '                'Code Commented By PradipK to Change UI of Help Desk Page
        '                '.Write("<TR class=clsTREven>")
        '                .Write("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
        '                .Write("<TD>")
        '                'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
        '                'Modified by SrikanthY on 27 Feb 2007 to Remove mandatory check for Exp Date field 
        '                If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '                    ' an assignee can see the date as read-only
        '                    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , False)
        '                    .Write("</TD>")
        '                    'Code Commented By PradipK to Change UI of Help Desk Page
        '                    '.Write("</TR>")
        '                Else
        '                    ' admin/requestor ofcourse can change the date
        '                    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , False)
        '                    .Write("</TD>")
        '                    'Code Commented By PradipK to Change UI of Help Desk Page
        '                    ' .Write("</TR>")
        '                End If
        '                'End of modification by SrikanthY on 27 Feb 2007
        '            Else
        '                .Write("<TD></TD><TD></TD>")
        '            End If
        '        End If
        '        ''End Modification by SavitaS on 19 Dec 2005
        '        ''===========================================================================
        '        ''----------------------------------------------------------------------------------------------
        '        ''Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        '        If UCase(Trim(m_strMode & "")) = "NEW" Then
        '            If m_strLoginType <> "C" And m_strVal <> "C" Then
        '                'Code Commented By PradipK to Change UI of Help Desk Page
        '                ' .Write("<TR class=clsTREven>")
        '                .Write("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
        '                .Write("<TD>")
        '            Else
        '                'Code Added By PradipK to Change UI of Help Desk Page
        '                .Write("<TD></TD><TD></TD>")

        '            End If
        '            'End If 'statement added by ShubhadaL

        '            'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
        '            If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '                ' an assignee can see the date as read-only
        '                CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , , True)
        '                .Write("</TD>")
        '                'Code Commented By PradipK to Change UI of Help Desk Page
        '                ' .Write("</TR>")
        '            Else
        '                If m_strLoginType <> "C" And m_strVal <> "C" Then
        '                    ' admin/requestor ofcourse can change the date
        '                    CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , , True)
        '                    .Write("</TD>")
        '                    'Code Commented By PradipK to Change UI of Help Desk Page
        '                    ' .Write("</TR>")
        '                End If
        '            End If
        '        End If
        '        ''End Integration
        '        ''-------------------------------------------------------------------------------------------
        '        '' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 Old ResolutionDate
        '        CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True)
        '        '' End Modification By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 
        '        ''----------------------------------------------------------------------------------------------
        '        ''Commented by by SavitaS on 21 Dec 2005 for IssueID 1936
        '        ''.Write("</TD>")
        '        ''.Write("</TR>")
        '        ''End Commnet
        '        '' hidden dates
        '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
        '        ''next two lines commeny=ted by ShubhadaL
        '        ''CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, strExpectedResolvedDate, , , , , , True, , )
        '        ''CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, strCRMExpectedResolvedDate, , , , , , True, , )
        '        ''added by ShubhadaL
        '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
        '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , )
        '        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , )
        '        ''end of addition


        '        If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '            ' Exp. resolution date
        '            'added by ShubhadaL
        '            If (m_strLoginType <> "C") Then
        '                ' .Write("<TR class=clsTREven>")
        '                .Write("<TD align=right>" & m_strCRMExpectedResolvedDate_Caption & "</TD>")
        '                .Write("<TD>")
        '            End If 'statement added by ShubhadaL
        '            '----------------------------------------------------------------------------------------------
        '            'Commented by by SavitaS on 21 Dec 2005 for IssueID 1936

        '            'If UCase(Trim(m_strFromWhere & "")) = "DB" Then
        '            '    'added by ShubhadaL
        '            '    If (m_strLoginType = "C") Then
        '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , , , , , , , , True)
        '            '        'addition ended
        '            '    Else
        '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails")
        '            '    End If
        '            'Else
        '            '    'added by ShubhadaL
        '            '    If (m_strLoginType = "C") Then
        '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True, , , , , , , True)
        '            '    Else 'addition ended
        '            '        CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True)
        '            '    End If
        '            '    .Write("</TD>")
        '            '    .Write("</TR>")
        '            'End If
        '            'Modified by SavitaS on 13 Dec 2005 for IssueID 1936 to disallow customers to view Exp. Resolution Date
        '            'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '            'Purpose: added one condition for My e-Dashboard (MD)
        '            'If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
        '            If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
        '                'End of addition by PrashantSJ on 09 Nov 2006
        '                CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails")
        '                .Write("</TD>")
        '                'Code Added By PradipK to Change UI of Help Desk Page
        '                ' .Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '                .Write("</TR>")
        '            Else
        '                If m_strLoginType <> "C" Then
        '                    CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", , , , True)
        '                    .Write("</TD>")
        '                    'Code Added By PradipK to Change UI of Help Desk Page
        '                    ' .Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '                    .Write("</TR>")
        '                Else
        '                    .Write("<TD></TD><TD></TD></tr>")
        '                End If
        '            End If
        '            '.Write("</TD>")
        '            '.Write("</TR>")
        '            'End Integration
        '            '-------------------------------------------------------------------------------------------
        '        Else
        '            'Code Added By PradipK to Change UI of Help Desk Page
        '            .Write("<TD></TD><TD></TD>")
        '            .Write("</TR>")
        '        End If
        '        'Added By NitinVS for WhizibleSEM SP9 IssueID 10366 

        '        '.Write("</TR>")
        '        .Write("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")
        '    Else
        '        'Code Added By PradipK to Change UI of Help Desk Page
        '        '.Write("<TD></TD><TD></TD>")
        '        '.Write("</TR>")
        '    End If
        '    '**********************End Row 7********
        '    ' Target Location
        '    'added by ShubhadaL
        '    'Commented and Integrated by SavitaS on 21 Dec 2005 for IssueID 1936
        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        If (m_strLoginType <> "C") Then
        '            .Write("<TR class=clsTREven>")
        '            .Write("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
        '            .Write("<TD>")
        '            ' End If 'statement added by ShubhadaL

        '            'Modified By SantoshK on 29Jan 2005
        '            'strSQL = "usp_CRM_Get_TargetLocations " & lngFunctionID
        '            'Issue 15474 - Helpdesk : Location drop down makes no sense to the user entering a new issue

        '            'Added by ShubhadaL
        '            'If (m_strLoginType = "C") Then
        '            '    CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , , , , True, , True)
        '            'Else
        '            '    CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , , , , True)
        '            'Modification Ends
        '            'Comment and modification by SUchitraP on 13 March 2008 for IssueID:17905
        '            'CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", intComboSize, lngTargetLocationID.ToString, , , , , True)
        '            CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", intComboSize, lngTargetLocationID.ToString, , True, , , True)
        '            'End of modification by SuchitraP
        '            .Write("</TD>")
        '            'Code Commented By PradipK to Change UI of Help Desk Page
        '            ' .Write("</TR>")
        '        End If 'statement added by ShubhadaL
        '    End If

        '    If UCase(Trim(m_strMode & "")) = "NEW" Then
        '        If m_strLoginType <> "C" And m_strVal <> "C" Then
        '            .Write("<TR class=clsTREven>")
        '            .Write("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
        '            .Write("<TD>")
        '        End If

        '        'Modified By SantoshK on 29Jan 2005
        '        'strSQL = "usp_CRM_Get_TargetLocations " & lngFunctionID
        '        'Issue 15474 - Helpdesk : Location drop down makes no sense to the user entering a new issue
        '        If m_strLoginType <> "C" And m_strVal <> "C" Then
        '            'CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", 0, lngTargetLocationID.ToString, , , , , True)
        '            'Comment and midification by SuchitraP on 13 March 2008 for ISsueID:17905
        '            'CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", intComboSize, m_ChangedLocation.ToString, , , , , True)
        '            CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "SELECT LocationID,Location FROM tbl_PM_Location", intComboSize, m_ChangedLocation.ToString, , True, , , True)
        '            'End of modification by SuchitraP
        '            .Write("</TD>")
        '            'Code Commented By PradipK to Change UI of Help Desk Page
        '            '.Write("</TR>")
        '        End If
        '    End If
        '    'End Integration by SavitaS


        '    ''Added by ManishK on 11th Jan 06 to add Deliverable Textbox on the Helpdesk Page

        '    'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '    'Purpose: added one condition for My e-Dashboard (MD)
        '    'If UCase(Trim(m_strMode & "")) = "EDIT" And (UCase(Trim(m_strFromWhere & "")) = "DB"  Or UCase(Trim(m_strFromWhere & "")) = "AR") Then


        '    If UCase(Trim(m_strMode & "")) = "EDIT" And (UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Or UCase(Trim(m_strFromWhere & "")) = "AR") Then
        '        'End of addition by PrashantSJ on 09 Nov 2006

        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        '.Write("<TR class=clsTREven>")
        '        .Write("<TD align=right >Deliverable</td>")
        '        .Write("<TD>")

        '        Dim strDeliverableName As String = ""
        '        Dim drGetDeliverable As IDataReader
        '        'Dim strDeliverableID As String = MyBase.GetFormValue("DeliverableID")

        '        If m_strDeliverableID <> "" Then
        '            strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
        '            drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        '            If drGetDeliverable.Read Then
        '                strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
        '            End If

        '            CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
        '        End If

        '        If UCase(Trim(m_strFromWhere & "")) = "AR" Then
        '            Response.Write(CommonFunction.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , , , , True))
        '            'Response.Write("<Input  Type=Textbox  name='txtDeliverableName' id='txtDeliverableName' class='clsTextBoxReadOnly' style='width:250px'  maxlength=200 style='' value=" + strDeliverableName.ToString + " style='text-align:left'  disabled  readonly style='BACKGROUND-COLOR='>")
        '            CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , 200, 100, strDeliverableName.ToString, , , True)
        '        Else
        '            'Response.Write(CommonFunction.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , , , , True))
        '            'Modified by SavitaS on 28 Sept 2006 for SP7 IssueID 6486
        '            'As the textbox was disabled,the value of the DeliverableID was not getting while saving the request.
        '            'CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , True, , , True)
        '            CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , False, , , True)
        '            'End of Modified by SavitaS on 28 Sept 2006 for SP7 IssueID 6486
        '            CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , , , strDeliverableName.ToString, , , True)

        '            ' CommonFunctions.HTMLControls.DrawTextBox("txtExtension", "txtExtension", , , , strExtensionNo, , , True)

        '            'Response.Write("<Input  Type=Textbox  name='txtDeliverableName' id='txtDeliverableName' class='clsTextBoxReadOnly' style='width:250px'  maxlength=200 style='' value=" + strDeliverableName.ToString + " style='text-align:left'  disabled  readonly style='BACKGROUND-COLOR='>")
        '            'Response.Write("&nbsp;<img Border=0 src = '../../../responsive/images/dblclick.gif' id ='imgValidationRules' title = '' height = '12px' width = '12px' onclick = 'Javascript:SelectDeliverable()'>")
        '        End If
        '        'Code Commented By PradipK to Change UI of Help Desk Page
        '        ' .Write("</TD></TR>")
        '        'Code Added By PradipK to Change UI of Help Desk Page
        '        .Write("</TD><TD></TD><TD></TD></TR>")
        '    Else
        '        'Code Added By PradipK to Change UI of Help Desk Page

        '        .Write("<TD></TD><TD></TD><TD></TD><TD></TD></TR>")
        '    End If

        '    'End of Added by ManishK on 11th Jan 06 to add Deliverable Textbox on the Helpdesk Page
        '    '-------------------------------------------------------------------------------------------
        '    '.Write("</TD>")
        '    '.Write("</TR>")
        '    'End Addition By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 & CSL IsssueID 79  

        '    'SrikanthY On 10 Jan 2007 Commneted Whole code to Draw new drop downs, for time being and later will be uncommented - SY_Comment_Start_100107
        '    'SrikanthY on 09 Jan 2007 Added code to enable project,product,component combos for hrms in edit mode
        '    'SY_Comment_Start_100107
        '    'Dim drHRM As IDataReader
        '    'Dim strHRM, strProd As String
        '    'Dim intProduct As Integer
        '    'blnIsHRM = 0
        '    'strHRM = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID.ToString
        '    'drHRM = CommonFunctions.Data.GetDataReader(strHRM, m_blnUseSQL)
        '    'If drHRM.Read Then
        '    '    blnIsHRM = 1
        '    'End If
        '    'strProd = "Select EnableProductExecution From tbl_pm_companyinformation"
        '    'intProduct = CType(CommonFunctions.Data.GetDataScalar(strProd, m_blnUseSQL), Integer)
        '    'SY_Comment_End_100107
        '    ' End of additon by SriaknthY
        '    'SrikanthY  on 08 Jan 2007 Added code to Draw project dropdown on Request Page for Whiziblesp9 Helpdesk Enhancements
        '    'SY_Comment_Start_100107
        '    'If m_strLoginType = "E" And m_intCustomer = 0 Then
        '    '    Dim strProject As String = "SELECT 0,'' UNION Select ProjectID,ProjectName FROM tbl_PM_Project"
        '    '    Dim StrInsert As String = ""
        '    '    If blnDisableProjectCombo = True And blnIsHRM = 0 Then
        '    '        StrInsert = "disabled"
        '    '    End If

        '    '    .Write("<TR class=clsTREven>")
        '    '    .Write("<TD align=right> Project </TD>")
        '    '    .Write("<TD>")
        '    '    CommonFunctions.HTMLControls.DrawComboBox("cboProject", strProject, 0, m_ChangedProject.ToString, StrInsert, , , , False)
        '    '    .Write("</TD>")
        '    '    .Write("</TR>")
        '    'End If
        '    ''End of Addition by SrikanthY
        '    'If intProduct <> 0 Then
        '    '    'SrikanthY On 04 Jan 2006 Added New Logic To Integrate Products,Components in Requests Screen
        '    '    .Write("<tr class=clsTREven>")
        '    '    .Write("<td  align=right width='30%'>" & "Product" & "</td>")
        '    '    .Write("<td  width='70%'>")
        '    '    Dim StrProduct As String
        '    '    Dim drProduct As IDataReader
        '    '    If m_strLoginType = "C" Then
        '    '        StrProduct = "Usp_Sel_Tbl_PRD_Customer_ProductVersion " + m_lngEmployeeID.ToString + ",Null,Null"
        '    '    ElseIf m_strLoginType = "E" Then
        '    '        If m_intCustomer <> 0 Then
        '    '            StrProduct = "Usp_Sel_Tbl_PRD_Customer_ProductVersion " + m_intCustomer.ToString + ",Null,Null"
        '    '        Else
        '    '            StrProduct = "Usp_Sel_Tbl_PRD_Customer_ProductVersion Null," + m_lngEmployeeID.ToString + ",Null"
        '    '        End If
        '    '    End If

        '    '    Dim StrInsertString As String = "Onchange=javascript:cboProduct_OnChange()"
        '    '    If blnDisableProductCombo = True And blnIsHRM = 0 Then
        '    '        StrInsertString = "disabled"
        '    '    End If
        '    '    CommonFunctions.HTMLControls.DrawComboBox("cboProduct", StrProduct, 0, m_ChangedProduct.ToString, StrInsertString, True, , , False)
        '    '    .Write("</td>")
        '    '    .Write("</tr>")

        '    '    Dim StrComponent As String = "Usp_Sel_Tbl_PRD_Customer_ProductVersion Null,Null," + m_ChangedProduct.ToString

        '    '    StrInsertString = ""
        '    '    If blnDisableModuleCombo = True And blnIsHRM = 0 Then
        '    '        StrInsertString = "disabled"
        '    '    End If

        '    '    .Write("<tr class=clsTREven>")
        '    '    .Write("<td  align=right width='30%'>" & "Module/Component" & "</td>")
        '    '    .Write("<td  width='70%'>")
        '    '    CommonFunctions.HTMLControls.DrawComboBox("cboModule", StrComponent, 0, m_ChangedModule.ToString, StrInsertString, True, , , False)
        '    '    .Write("</td>")
        '    '    .Write("</tr>")
        '    'End If
        '    'End of Addition by SrikanthY
        '    'SY_Comment_End_100107

        '    'Modified By NitinVS on 13 Mar 2007 for WhizibleSEM SP 8 Regression Issue 11691 
        '    ' After entering feedback comments , Whensaved from E Dashboard data is lost since the controls are not plotted
        '    ' Hence Plotting the controls in disabled mode from E
        '    'If UCase(Trim(m_strMode & "")) = "EDIT" And UCase(Trim(m_strFromWhere & "")) = "SR" Then
        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        ' if the status is  "Closed" show feedback param
        '        If intStatusID <> 2 Then
        '            strStyle = " style='display:none' "
        '        End If
        '        Dim strIsFeedbackdisabled As String = ""
        '        If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
        '            strIsFeedbackdisabled = " disabled "
        '        Else
        '            strIsFeedbackdisabled = ""
        '        End If

        '        ' feeb back (submitted mode)
        '        .Write("<TR id=TRFeedback class=clsTREven " & strStyle & ">")
        '        .Write("<TD align=right>Feedback</TD>")
        '        .Write("<TD>")
        '        strSQL = "usp_CRM_Get_Feedback_ForCombo"
        '        CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, , , , , True)
        '        .Write("</TD>")
        '        'Code Added By PradipK to Change UI of Help Desk Page
        '        .Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '        .Write("</TR>")

        '        .Write("<TR id=TRFeedbackComments class=clsTREven  " & strStyle & " >")
        '        .Write("<TD align=right vAlign=top>Feedback Comments </TD>")
        '        .Write("<TD colspan=5>")
        '        'Modified By ShraddhaM on 27 July 2006
        '        CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , , , , , , , , , , , , , "Soft", )
        '        .Write("</TD>")
        '        'Code Added By PradipK to Change UI of Help Desk Page
        '        '.Write("<TD></TD><TD></TD><TD></TD><TD></TD>")
        '        .Write("</TR>")
        '    End If
        '    .Write("</Table>")

        '    If UCase(Trim(m_strMode & "")) = "EDIT" Then
        '        ' attachments grid
        '        .Write("<BR>")
        '        .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ATTACHMENTS")))
        '        PlotAttachmentsGrid()
        '    End If

        '    .Write("</div>")

        '    .Write("<BR>")
        '    .Write(strMenu)
        'End With


    End Sub

    Private Sub InitializeMenu()

        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS_TOOLTIP"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Reject_Onclick()", "ShowHistory_OnClick()", "Discussion_OnClick()", "AddAttachment_OnClick()", "DeleteAttachment_OnClick()", "SelectAll_OnClick()", "FlagRequest_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}


        Select Case m_intShow
            Case TAB_REQUEST_DETAILS
                ', "Save_OnClick" is added by VarunA on 21-Mar-2009 IssueID-28534
                'Reject link removed by ShraddhaM on 17,Sep 2009 for WhizibleSem9.0
                'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), "Save and Close", MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save and Close", MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Save_OnClick(1)", "Reject_Onclick()", "ShowHistory_OnClick()", "FlagRequest_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
                ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver if from approver set all as READ ONLY
                If m_strApprover = "1" Then
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                    Dim arrCSFunction() As String = {"CloseOnClick()"}
                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                Else
                    'Modified By Ashwinim on 27-FEB-2013
                    'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                    'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                    'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Save_OnClick(1)", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
                    'Commented And Added By Bharat Tekade on 2nd-Feb-2015 fro JLT Asia Issue solving
                    'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help"), "Copy To Issue"}
                    'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP"), "Copy To Issue"}
                    'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Save_OnClick(1)", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')", "CopyToIssue_OnClick()"}

                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                    Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Save_OnClick(1)", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
                    'Ended By Bharat Tekade
                   
                    'End of Modified By Ashwinim on 27-FEB-2013

                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                End If
                ''end Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver if from approver set all as READ ONLY
                ''deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver if from approver set all as READ ONLY
                '''''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                '''''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), "Save and Close", MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                '''''Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Save_OnClick(1)", "ShowHistory_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

                '''''strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                ''end deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver if from approver sert all as READ ONLY
            Case TAB_ATTACHMENT
                ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver if from approver set all as READ ONLY
                If m_strApprover = "1" Then
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                    Dim arrCSFunction() As String = {"CloseOnClick()"}
                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                Else
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                    Dim arrCSFunction() As String = {"AddAttachment_OnClick()", "DeleteAttachment_OnClick()", "SelectAll_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                End If
                ''end Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request for approver if from approver set all as READ ONLY
                ''deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver sert all as READ ONLY
                '''''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                '''''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                '''''Dim arrCSFunction() As String = {"AddAttachment_OnClick()", "DeleteAttachment_OnClick()", "SelectAll_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

                '''''strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                ''end deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver set all as READ ONLY
            Case TAB_DISCUSSION_THREAD
                ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver set all as READ ONLY
                If m_strApprover = "1" Then
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                    Dim arrCSFunction() As String = {"CloseOnClick()"}
                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                Else

                    ''Added by Amit Mahadik on 28 July 2011 Purpose:WhizibleSEM10.0 IssueID :50823
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                    Dim arrCSFunction() As String = {"DeleteDiscussion_OnClick(" & m_lngQueryID & ")", "Discussion_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
                    ''End Added by Amit Mahadik on 28 July 2011 Purpose:WhizibleSEM10.0 IssueID :50823

                    ''Deleted by Amit Mahadik on 28 July 2011 Purpose:WhizibleSEM10.0 IssueID :50823
                    ''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                    ''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                    ''Dim arrCSFunction() As String = {"Discussion_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}
                    ''End Deleted  by Amit Mahadik on 28 July 2011 Purpose:WhizibleSEM10.0 IssueID :50823
                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                End If
                ''end Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver set all as READ ONLY

                ''deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver sert all as READ ONLY
                '''''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                '''''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                '''''Dim arrCSFunction() As String = {"DeleteDiscussion_OnClick(" & m_lngQueryID & ")", "Discussion_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

                '''''strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                ''end deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver sert all as READ ONLY
            Case TAB_SLA, TAB_ACTIVITY_LOG
                ''Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver set all as READ ONLY
                If m_strApprover = "1" Then
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")}
                    Dim arrCSFunction() As String = {"CloseOnClick()"}
                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                Else
                    Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                    Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                    Dim arrCSFunction() As String = {"CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}


                    strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                End If
                ''end Added by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver set all as READ ONLY

                ''deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver sert all as READ ONLY
                '''''Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
                '''''Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
                '''''Dim arrCSFunction() As String = {"CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

                '''''strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
                ''end deleted by Amit Mahadik on 29Mar2011 Purpose:WhizibleSEM10.0 Show details of request if from approver sert all as READ ONLY
        End Select

       
    End Sub

    Private Sub InitializeVaiablesInDrawPageMethods()


        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADDDELIVERABLE_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNTASK_TOOLTIP"), MyBase.GetResourceString("MENU_ASSIGNISSUE_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY_TOOLTIP"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD_TOOLTIP"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT_TOOLTIP"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS_TOOLTIP"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        'Dim arrCSFunction() As String = {"AddDeliverable_OnClick()", "AssignTask_OnClick()", "AssignIssue_OnClick()", "Save_OnClick()", "Reject_Onclick()", "ShowHistory_OnClick()", "Discussion_OnClick()", "AddAttachment_OnClick()", "DeleteAttachment_OnClick()", "SelectAll_OnClick()", "FlagRequest_OnClick()", "CloseOnClick()", "Help_OnClick('CRM_REQUESTDETAIL')"}

        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            intWidth = 830
        End If

        ' disable status combo?
        If Not Request("DisableStatuscombo") Is Nothing Then
            If Trim(Request("DisableStatuscombo") & "") = "1" Then blnDisableStatusCombo = True
        End If


        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            ' Get request details of current request from database
            'Added m_intShow by ShraddhaM to performance check for WhizibleSem9.0
            If m_intShow = 1 Then
                dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
                If dr.Read Then
                    strAssignTo = CommonFunctions.Data.CheckIsDBNull(dr("AssignedToEmployee"), "").ToString
                    intAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Integer)
                    'To display requested time along with date.
                    m_strSubmittedDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubmittedDate"), ""), String)
                    dtmSubmittedDate = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubmittedDate"), ""), Date)
                    m_intDiscussionThreadCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("DiscussionThreads"), "0"), Integer)
                    lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FunctionID"), "0"), Long)
                    'To Display requestID and Requestor in Edit Mode
                    lngRequestID = CType(CommonFunctions.Data.CheckIsDBNull(dr("QueryID"), "0"), Long)
                    strRequestor = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerID")), String)
                    strRequestorName = CType(CommonFunctions.Data.CheckIsDBNull(dr("CustomerName")), String)
                    m_lngRequestTypeId = CType(CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0"), Long)
                    lngRequestTypeIdOld = m_lngRequestTypeId
                    m_lngSubRequestTypeID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0"), Long)
                    strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
                    strSubject = dr("Subject").ToString
                    ' For storing Request Subject (which is passed to Flag tracker)
                    m_strSubject = dr("Subject").ToString
                    ' Security Issue
                    m_strSubject = m_strSubject.Replace("<", "&#60")
                    m_strSubject = m_strSubject.Replace(">", "&#62")
                    strDescription = dr("Description").ToString
                    intPriorityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("PriorityID"), "0"), Integer)
                    If Not IsDBNull(dr("ExpectedResolvedDate")) Then
                        strExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("ExpectedResolvedDate"), Date))
                    End If
                    If Not IsDBNull(dr("CRMExpectedResolvedDate")) Then
                        strCRMExpectedResolvedDate = CommonFunctions.Dates.GetDate(CType(dr("CRMExpectedResolvedDate"), Date))
                    End If
                    lngAssignTo = CType(CommonFunctions.Data.CheckIsDBNull(dr("AssignTo"), "0"), Long)
                    strComments = dr("Comments").ToString
                    strReasonsForRejection = dr("ReasonsForRejection").ToString
                    intStatusID = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusID"), "0"), Integer)
                    lngTargetLocationID = CType(CommonFunctions.Data.CheckIsDBNull(dr("TargetLocationID"), "0"), Long)
                    intFeedbackID = CType(CommonFunctions.Data.CheckIsDBNull(dr("FeedbackID"), "0"), Integer)
                    strFeedbackComments = dr("FeedbackComments").ToString
                    m_strDeliverableID = dr("DeliverableID").ToString
                    ' lets see if we can allow attachment deletion 
                    If CType(CommonFunctions.Data.CheckIsDBNull(dr("IsAttachmentMandatory"), "0"), Boolean) And lngAssignTo <> 0 Then
                        m_blnAllowAttachmentDeletion = False
                    End If
                    'Added by SrikanthY on 05 Jan 2007 To Get Values of Product,Components in Edit Mode
                    m_ChangedProduct = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
                    m_ChangedModule = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)
                    m_ChangedProject = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProjectID"), "0"), Integer)
                    m_RequeststrLoginType = CType(CommonFunctions.Data.CheckIsDBNull(dr("LoginType"), "0"), String)
                    m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(dr("ClientName"), "0"), String)
                    lngProductID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ProductID"), "0"), Integer)
                    If lngProductID = 0 Then
                        lngProductID = -1
                    End If
                    lngComponentID = CType(CommonFunctions.Data.CheckIsDBNull(dr("ComponentID"), "0"), Integer)
                    ' Add Field for Severity 
                    intSeverityID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SeverityID"), "0"), Integer)
                    m_strStatusChangeDateValue = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusChangeDate")), String)
                    m_strStatusChangeTimeValue = CType(CommonFunctions.Data.CheckIsDBNull(dr("StatusChangeTime")), String)
                    strReportingTo = CommonFunctions.Data.CheckIsDBNull(dr("ReportingToName"), "-")
                    strAprovalStatus = CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(dr("ApprovalStatus"), "-"), "")
                End If

                CommonFunctions.Data.DisposeDataReader(dr)

                ' Added BY NitinVS on 9 Aug  2005 for WhizibleSEM SP4 IssueID 2
                m_lngStatusId = intStatusID
                ' End Addition BY NitinVS on 9 Aug  2005 for WhizibleSEM SP4 IssueID 2

                'Added by PrajaktaR on 17 Feb 2007 for WizibleSEM SP9 IssueID - 10295 for Disabling Status if marked as closed.
                intRequestStatus = intStatusID
                'End of Addition by PrajaktaR on 17 Feb 2007 for WizibleSEM SP9 IssueID - 10295 for Disabling Status if marked as closed.

                blnDisableProductCombo = True
                blnDisableModuleCombo = True
                blnDisableFunctionCombo = True
                blnDisableSubRequestTypeCombo = True
                blnDisableSubRequestTypeCombo = True
                blnDisableProjectCombo = True

                Select Case UCase(Trim(m_strFromWhere & ""))
                    Case "SR"
                        strGuidelinesColumnName = "GuidelinesForRequestor"
                        blnDisabledAssignToCombo = True
                    Case "AR"
                        blnDisbaledSubjectTextBox = True
                        strGuidelinesColumnName = "GuidelinesForAssignee"
                        blnReadOnlyComments = True
                        blnDisabledAssignToCombo = True
                    Case "DB"
                        blnDisbaledSubjectTextBox = True
                        blnDisabledAssignToCombo = False
                    Case "MD"
                        blnDisbaledSubjectTextBox = True
                        blnDisabledAssignToCombo = False
                End Select

                ' Should be removed once above select case is tested
                'If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
                '    blnDisbaledSubjectTextBox = True
                'End If
                'If UCase(Trim(m_strFromWhere & "")) = "AR" Then
                '    strGuidelinesColumnName = "GuidelinesForAssignee"
                '    blnReadOnlyComments = True
                'ElseIf UCase(Trim(m_strFromWhere & "")) = "SR" Then
                '    strGuidelinesColumnName = "GuidelinesForRequestor"
                'End If
                ''Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
                ''Purpose: added one condition for My e-Dashboard (MD)
                ''If UCase(Trim(m_strFromWhere & "")) = "DB"  Then
                'If UCase(Trim(m_strFromWhere & "")) = "DB" Or UCase(Trim(m_strFromWhere & "")) = "MD" Then
                '    'End of addition by PrashantSJ on 09 Nov 2006
                '    blnDisabledAssignToCombo = False
                'Else
                '    blnDisabledAssignToCombo = True
                'End If

                If strStatus = "FUNCTION_CHANGE" Or strStatus = "PRODUCT_CHANGE" Or strStatus = "SUBREQUESTTYPE_CHANGE" Then
                    If MyBase.GetFormValue("cboProduct") = "" Then
                        lngProductID = -1
                    Else
                        lngProductID = CType(MyBase.GetFormValue("cboProduct"), Long)
                    End If

                    If MyBase.GetFormValue("cboModule") = "" Then
                        lngComponentID = 0
                    Else
                        lngComponentID = CType(MyBase.GetFormValue("cboModule"), Long)
                    End If
                End If

            End If ' End of m_intshow if
        Else
            If Not Request.Form("optOnBehalf") Is Nothing And Request.Form("optOnBehalf") <> "" Then

                If Request.Form("optOnBehalf") = "Customer" Then
                    m_IsOnbehalfCUST = True
                    m_IsOnbehalfEMP = False
                    m_IsOnbehalfSELF = False
                ElseIf Request.Form("optOnBehalf") = "Employee" Then
                    m_IsOnbehalfEMP = True
                    m_IsOnbehalfCUST = False
                    m_IsOnbehalfSELF = False
                ElseIf Request.Form("optOnBehalf") = "Self" Then
                    m_IsOnbehalfSELF = True
                    m_IsOnbehalfEMP = False
                    m_IsOnbehalfCUST = False
                End If
            End If

            If Not Request.QueryString("OnBehalfOf") Is Nothing And Request.QueryString("OnBehalfOf") <> "" Then

                If Request.QueryString("OnBehalfOf") = "CUST" Then
                    m_IsOnbehalfCUST = True
                    m_IsOnbehalfEMP = False
                    m_IsOnbehalfSELF = False
                ElseIf Request.QueryString("OnBehalfOf") = "EMP" Then
                    m_IsOnbehalfEMP = True
                    m_IsOnbehalfCUST = False
                    m_IsOnbehalfSELF = False
                ElseIf Request.QueryString("OnBehalfOf") = "SELF" Then
                    m_IsOnbehalfSELF = True
                    m_IsOnbehalfEMP = False
                    m_IsOnbehalfCUST = False
                End If
            End If

            ' for "NEW" mode we'll use submitted values of form if any!
            If Trim(MyBase.GetFormValue("cboFunction") & "") <> "" Then
                lngFunctionID = CType(MyBase.GetFormValue("cboFunction"), Long)
            End If
            If Trim(MyBase.GetFormValue("cboProduct") & "") <> "" Then
                lngProductID = CType(MyBase.GetFormValue("cboProduct"), Long)
            End If

            If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
                lngComponentID = CType(MyBase.GetFormValue("cboModule"), Long)
            End If

            'To Seperate TaskType and SubTaskType
            If CommonFunction.Application.SplitRequestTypeSubType = True Then
                If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
                    m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
                End If
            End If

            strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
            If Trim(strSubrequestType & "") <> "" Then
                arr = Split(strSubrequestType, "|")
                If Trim(arr(0) & "") <> "" Then
                    m_lngSubRequestTypeID = CType(arr(0), Long)
                End If
                If CommonFunction.Application.SplitRequestTypeSubType = False Then
                    If Trim(arr(1) & "") <> "" Then
                        m_lngRequestTypeId = CType(arr(1), Long)
                    End If
                End If
            End If

            strSubject = Trim(Request.Form("txtSubject") & "")
            strDescription = Trim(Request.Form("txtDescription") & "")
            If Trim(MyBase.GetFormValue("cboPriority") & "") <> "" Then
                intPriorityID = CType(Trim(MyBase.GetFormValue("cboPriority") & ""), Integer)
            End If
            'SrikanthY on 08 Jan 2007 Added code to get the values of newly introduced drop downs
            If Trim(MyBase.GetFormValue("cboModule") & "") <> "" Then
                m_ChangedModule = CType(Trim(MyBase.GetFormValue("cboModule")), Integer)
            End If
            If Trim(MyBase.GetFormValue("cboProject") & "") <> "" Then
                m_ChangedProject = CType(Trim(MyBase.GetFormValue("cboProject")), Integer)
            End If
            If Trim(MyBase.GetFormValue("cboTargetLocation") & "") <> "" Then
                m_ChangedLocation = CType(Trim(MyBase.GetFormValue("cboTargetLocation")), Integer)
            End If
            ' To show current date as 'Exp. Resolved Date' in add new mode
            If UCase(Trim(m_strMode & "")) = "NEW" Then
                strExpectedResolvedDate = CommonFunctions.Dates.GetDate(Now()).ToString()
            End If

            strCRMExpectedResolvedDate = Trim(MyBase.GetFormValue("txtCRMResolutionDate") & "")
            If Trim(MyBase.GetFormValue("cboAssignTo") & "") <> "" Then
                lngAssignTo = CType(Trim(MyBase.GetFormValue("cboAssignTo") & ""), Long)
            End If
            strComments = Trim(MyBase.GetFormValue("txtComments") & "")
            strReasonsForRejection = Trim(MyBase.GetFormValue("txtReasonsForRejection") & "")
            If Trim(MyBase.GetFormValue("cboStatus") & "") <> "" Then
                intStatusID = CType(Trim(MyBase.GetFormValue("cboStatus") & ""), Integer)
            End If
            lngTargetLocationID = GetEmployeeDepartment(m_lngEmployeeID)
            If Trim(MyBase.GetFormValue("cboFeedback") & "") <> "" Then
                intFeedbackID = CType(Trim(MyBase.GetFormValue("cboFeedback") & ""), Integer)
            End If
            strGuidelinesColumnName = "GuidelinesForRequestor"
            strFeedbackComments = Trim(MyBase.GetFormValue("txtFeedbackComments") & "")
        End If

        ' Initialize menus depending on selected tab
        Call InitializeMenu()

        ' set the captions for the page
        Call SetCaptions()

        MyBase.InitializeResources("AppResources.CRM_RequestDetail", "AppResources")
    End Sub

    Private Sub DrawPageForEDashboard()
        '=====================================================================
        ' Procedure Name        : DrawPageForEDashboard()	
        ' Purpose               : Draw UI for Detail page if it is called by E-Dashboard
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : May 21, 2007
        ' Revisions             :
        '=====================================================================
        Dim strHTML As System.Text.StringBuilder = New System.Text.StringBuilder

        'added by SonalD on 16th Sept 2008
        'strHTML.Append("<table cellPadding=0 cellspacing=0 class='clsTable' align='center' width=99.99% >" + vbCrLf)
        'strHTML.Append("<tr class='clsTRSectionHeader' align='left'>" + vbCrLf)
        'strHTML.Append("<td noWrap align='left' >" + vbCrLf)
        'strHTML.Append("<A href=Javascript:showHide_div('divNote')> <IMG border=0 id='imgGadget' Src='../../../responsive/images/minus.gif' Collapse='N' ></A>" + vbCrLf)
        'strHTML.Append("<div ID=divNote>" + vbCrLf)
        'strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
        'strHTML.Append("<TR class=clsTREven><td>")
        'strHTML.Append("&nbsp;&nbsp; Note : Assigned to,Convert Request in Deliverable , Assign Task & Issue Creation options will be available only to Help Request Manager or Department Head")
        'strHTML.Append("</td></TR>")
        ''strHTML.Append("<TR><td>")
        ''strHTML.Append("2.")
        ''strHTML.Append("</td></TR>")
        'strHTML.Append("</Table>")
        'strHTML.Append("</Div>")
        'strHTML.Append("</td></TR>")
        'strHTML.Append("</Table>")
        'strHTML.Append("<br>")
        'End of addition by SonalD on 16th Sept 2008



        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Display Header - Request ID, Requestor, Requested On
        ' ----------------------------------------------------------------------------------------------------------------------------

        'Addedby ShraddhaM for Performance Check Whizible9.0

        'If m_intShow <> 1 Then
        Dim strHeaderDtls As String
        Dim drDtls As IDataReader
        Dim FlagTo As String
        Dim FlagDateStatus As String
        Dim FlagStatus As String
        Dim FlagImage As String

        strHeaderDtls = "usp_Sel_RequestHeaderDetails " + m_lngQueryID.ToString + "," + Session("intUserID").ToString()

        drDtls = CommonFunction.Data.GetDataReader(strHeaderDtls, MyBase.UseSQL)
        lngRequestID = m_lngQueryID
        While drDtls.Read()
            strRequestor = drDtls("CustomerID").ToString()
            m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("ClientName"), "0"), String)
            'm_strSubmittedDate = CommonFunctions.Dates.GetDate(CType(drDtls("SubmittedDate"), Date)).ToString()
            m_strSubmittedDate = drDtls("SubmittedDate").ToString()
            FlagTo = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagTo"), "2"), String)
            FlagDateStatus = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagDateStatus"), "E"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drDtls)
        'End of addition by ShraddhaM
        'End If

        If FlagTo = "1" Then
            FlagStatus = "Review"

        ElseIf FlagTo = "0" Then
            FlagStatus = "Follow Up"
        Else
            FlagStatus = "Flag To"
        End If

        'Commented And Added By Vaijat K ON 07/12/2015
        'If FlagDateStatus = "L" Then
        '    FlagImage = "../../../responsive/images/RedFlag.gif"
        'ElseIf FlagDateStatus = "G" Then
        '    FlagImage = "../../../responsive/images/GreenFlag.gif"
        'ElseIf FlagDateStatus = "S" Then
        '    FlagImage = "../../../responsive/images/YellowFlag.gif"
        'ElseIf FlagDateStatus = "B" Then
        '    FlagImage = "../../../responsive/images/BlackFlag.gif"
        'Else
        '    FlagImage = "../../../responsive/images/GrayFlag.gif"
        'End If

        If FlagDateStatus = "L" Then
            FlagImage = "../../Images/RedFlag.gif"
        ElseIf FlagDateStatus = "G" Then
            FlagImage = "../../Images/GreenFlag.gif"
        ElseIf FlagDateStatus = "S" Then
            FlagImage = "../../Images/YellowFlag.gif"
        ElseIf FlagDateStatus = "B" Then
            FlagImage = "../../Images/BlackFlag.gif"
        Else
            FlagImage = "../../Images/GrayFlag.gif"
        End If

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtShowTab", "txtShowTab", , , , m_intShow.ToString(), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
        ' Request ID
        strHTML.Append("<TR  class=clsTRPageCaption>")

        If m_strLoginType = "E" Then
            strHTML.Append("<TD title='Flag' align=right width='10%'><a href=""javascript:Flag_OnClick(" + m_lngQueryID.ToString + " )""><IMG Border=0  SRC='" + FlagImage + "'  title='" + FlagStatus + "' onclick="""" ></a></TD>")
        End If

        strHTML.Append("<TD width='15%' align=center> <B>Request ID<BR> <Font size=4>" + lngRequestID.ToString + "</Font></B></td>")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15

        ' REaquestor
        strHTML.Append("<TD width='55%'> Requestor : ")
        ' Requestor can be customer or employee
        If m_RequeststrLoginType.ToUpper = "C" Then
            If m_strClienName = "0" Then
                strHTML.Append(strRequestor.ToString)
            Else
                If m_strClienName <> "" Then
                    strHTML.Append(strRequestor.ToString + " | " + m_strClienName)
                End If
            End If
        Else
            strHTML.Append(strRequestor.ToString)
        End If
        ' Requested on
        strHTML.Append(" | Requested on : " + m_strSubmittedDate)
        strHTML.Append("</TD>")

        strHTML.Append("<TD width='10%'>")
        ' Display icon to move request to another department
        Dim drIsTaskCreated As IDataReader
        'Dim drAssignTo As IDataReader
        Dim strSQLIsTaskCreated As String

        ' To check whether task or issue is created for the current request
        strSQLIsTaskCreated = "usp_Sel_CRM_IsTaskIssueDeliverableAssignToForRequest " + lngRequestID.ToString
        drIsTaskCreated = CommonFunctions.Data.GetDataReader(strSQLIsTaskCreated, m_blnUseSQL)

        ' Variable intIsTask_IssueCreated is used in ASPX page
        ' If Issue or task is created againt the request then alert is given on 'Move To Another Department' link as
        ' It is not possible to move the request since task or issue is created for theis request
        Dim strIsTaskCreated As String
        If drIsTaskCreated.Read Then
            strIsTaskCreated = CommonFunctions.Data.CheckIsDBNull(drIsTaskCreated("TaskID"), "0").ToString
        End If
        If Not strIsTaskCreated Is Nothing Then
            If strIsTaskCreated = "0" Or strIsTaskCreated = "" Then
                intIsTask_IssueCreated = 0
            Else
                intIsTask_IssueCreated = 1
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drIsTaskCreated)

        If blnViewAccessOrHRM = 1 Then
            'Commented And Added By Vaijat K ON 07/12/2015
            'strHTML.Append("<A href='JavaScript:MoveToDept_OnClick()'><Image Border=0  src='../../../responsive/images/MoveImg.gif'   id ='view' title = 'Move this request to another Department'  > </A>")
            strHTML.Append("<A href='JavaScript:MoveToDept_OnClick()'><Image Border=0  src='../../Images/MoveImg.gif'   id ='view' title = 'Move this request to another Department'  > </A>")
        End If
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")
        strHTML.Append("</TABLE>")
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Header
        ' ----------------------------------------------------------------------------------------------------------------------------


        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------
        Dim txtResult As New System.Text.StringBuilder
        Dim intSelectedTabValue As Integer
        intSelectedTabValue = m_intShow
        With txtResult
            .Append("<TABLE BORDER=0 cellpadding=0 cellspacing=0 width='99.9%' class='clsTable'><TR class=clsTRSectionHeader valign=middle>") '+ vbCrLf
            .Append("<TD nowrap class='mainTabsSectionEasyMenu'>")

            If intSelectedTabValue = TAB_REQUEST_DETAILS Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If intSelectedTabValue = TAB_ATTACHMENT Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If intSelectedTabValue = TAB_DISCUSSION_THREAD Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Discussion Thread'+ href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Discussion Thread' href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If m_blnSLAAccess = True Then
                If intSelectedTabValue = TAB_SLA Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='SLA'+ href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='SLA' href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If
            End If

            If intSelectedTabValue = TAB_ACTIVITY_LOG Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='ActivityLog'+ href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='ActivityLog' href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If
            .Append("</TD>")
            .Append("</TR></TABLE>")
        End With

        strHTML.Append(txtResult.ToString)

        txtResult = Nothing
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------


        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw details depending on selectd tab
        ' ----------------------------------------------------------------------------------------------------------------------------
        Select Case intSelectedTabValue
            Case TAB_REQUEST_DETAILS
                ' Menu specific to selected tab
                strHTML.Append(strMenu)
                ' Page legend
                strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
                strHTML.Append(strLegend)

                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)

                '********************* FIRST ROW *******************************************************************************************
                ' Department Name Caption
                strHTML.Append("<tr class=clsTREven>")
                strHTML.Append("<td  align=right width=5% >" & m_strFunction_Caption & "</td>")
                strHTML.Append("<td width=15%>")

                ' Department Combo
                Dim strSQLRole As String
                Dim drRole As IDataReader
                Dim lngPostID As Long = 0
                ' Take Role of the employee at corporate level and not from session

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
                drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If drRole.Read Then
                    lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(drRole)

                ' Populate only those department which are accessible to Role of the logged in person
                strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
                strSQL += "," + lngRequestID.ToString

                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, " disabled ", True, True, , True))
                strHTML.Append("</td>")

                ' Check whether logged in person in either HRM or department head 
                strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If dr.Read Then
                    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                If m_lngCRMID <> 0 Then
                    ' If logged in person IS HRM or Department head then 
                    ' ENABLE Request and Sub Request Type Combo
                    blnDisableSubRequestTypeCombo = False

                    ' Request Type and Sub Request Type are to be displayed in seperate drop downs
                    If CommonFunction.Application.SplitRequestTypeSubType = True Then

                        ' Split Request Type and Sub Request Type
                        If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
                            m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
                        End If
                        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
                        If Trim(strSubrequestType & "") <> "" Then
                            arr = Split(strSubrequestType, "|")
                            If Trim(arr(0) & "") <> "" Then
                                m_lngSubRequestTypeID = CType(arr(0), Long)
                            End If
                        End If
                    Else
                        ' Concatenate Request Type and Sub Request Types
                        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")

                        arr = Split(strSubrequestType, "|")
                        If Trim(arr(0) & "") <> "" Then
                            m_lngSubRequestTypeID = CType(arr(0), Long)
                        End If

                        If Trim(strSubrequestType & "") = "" Then
                            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
                            If dr.Read Then
                                strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
                            End If
                            CommonFunctions.Data.DisposeDataReader(dr)
                        End If
                    End If
                Else
                    ' If logged in person IS NOT HRM or Department head then 
                    ' DISABLE Request and Sub Request Type Combo
                    blnDisabledAssignToCombo = True
                End If

                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    ' If Request Type and Sub Request Types are to be displayed in separate drop downs
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right width=6%> Request Type </td
                    ' strHTML.Append("<td  align=right width=6%> " & m_strRequestType_Caption & "</td>") 
                    'Commented added by Shamkant S on 25 Nov 2015
                    strHTML.Append("<td  align=right width=7%> " & m_strRequestType_Caption & "</td>")
                    'Commented ended by Shamkant S on 25 Nov 2015
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908
                    strHTML.Append("<td width=15%>")
                    ' Get request types mapped to request department and which are accessible to role of logged in person
                    strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString

                    ' Show request type drop down enabled only for HRM's or department head
                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                    strHTML.Append("</td>")

                    'Sub Requst Type
                    ' strHTML.Append("<td  align=right width=8%> " & m_strSubRequestType_Caption & " </td>")
                    'Commented added by Shamkant S on 25 Nov 2015
                    strHTML.Append("<td  align=right width=9%> " & m_strSubRequestType_Caption & " </td>")
                    'Commented ended by Shamkant S on 25 Nov 2015
                    strHTML.Append("<td width=15%>")

                    ' Get sub request type accessible to logged in user
                    strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString

                    ' Show Sub Request Type drop down enabled only for HRM's or department head
                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                Else
                    ' If Request Type and Sub Request Types are to be displayed in concatenated

                    'Sub Requst Type
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right width=5% > Request Type </td>")
                    strHTML.Append("<td  align=right width=5% > " & m_strRequestType_Caption & " </td>")
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908

                    strHTML.Append("<td colspan=3 >")
                    ' Get request type and sub request type mapped to selected department and accessible to role of logged in person
                    strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString

                    If Not Page.IsPostBack Then
                        If CommonFunction.Application.SplitRequestTypeSubType = False Then
                            strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
                        End If
                    End If

                    ' Show Request type and Sub Request Type drop down enabled only for HRM's or department head
                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                End If
                '-----------------------------------------------------------------------------------------

                'Template
                If m_lngSubRequestTypeID <> 0 Then
                    ' If Sub Request Type is selected
                    ' Get Document Templates mapped to Sub Request Type (If Any)
                    ''added by  Nilesh g on 1/3/2016 for token generation
                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
                    strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
                    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    If dr.Read Then
                        intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                        Select Case intTemplateCount
                            Case 0 ' no templates
                                ' Commented by MonikaI on 14th Jul 2009 
                                ' RequestID 21655 Not able to download template attached with sub type if File server is different.
                                'Case 1 ' only one template
                                '    strHTML.Append("<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateID"), "0"), Long)) & "' >" & vbCrLf)
                                '    strHTML.Append("<Image Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'>")
                                '    strHTML.Append("</A>")
                                ' End of modification by MonikaI on 14th Jul 2009
                            Case Else ' multiple templates
                                'Commented And Added By Vaijat K ON 07/12/2015
                                'strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'></A>")
                                ''commented and Added by nilesh g  on 1-mar-2016 to validate Token
                                ''   strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                                strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                        End Select
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If
                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                Else
                    'Sub Request Type not Ploted..
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                End If


                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Subject
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strSubject_Caption & "</TD>")
                strHTML.Append("<TD colspan=5>")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , intWidth, intPixelSize, strSubject, , , blnDisbaledSubjectTextBox, , , , , True, True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")

                strHTML.Append("</TR>")


                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Description
                strHTML.Append("<TR class=clsTREven>")
                'Commented and Added BY Bharat T on 3rd-Dec-2015
                'strHTML.Append("<TD align=right vAlign=top>" & m_strDescription_Caption & "</TD>")
                strHTML.Append("<TD align=right style='vertical-align:top;'>" & m_strDescription_Caption & "</TD>")
                'End of Commented and Added BY Bharat T on 3rd-Dec-2015
                strHTML.Append("<TD colspan=5> ")
                ''Added by Amit mahadik on 29 Mar2011 whizible10.0 ,Conditional plot
                If m_strApprover = "0" Then
                    'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", ))
                    'Else
                    '    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , " disabled ", True, , , , , , , "Soft", ))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , " disabled ", True, , , , , , , "Soft", , EnableHTMLEncode:=True))
                    'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                End If
                ''end Added by Amit mahadik on 29 Mar2011 whizible10.0  ,Conditional plot
                '''''strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", ))
                strHTML.Append("</TD></TR>")


                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Product & Component
                ' If product execution is enabled at corporate level
                If CommonFunction.Application.EnableProductExecution = True Then
                    ' Check whether department is exposed to product execution

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    '''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
                    dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If dr.Read Then
                        ShowProductCombo = "1"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                End If

                If ShowProductCombo = "1" Then
                    ' Product Drop down
                    strHTML.Append("<tr class=clsTREven><td colspan=6><HR></td></tr>")
                    strHTML.Append("<tr class=clsTREven>")

                    'Added by GokulP on 13 May 2010 for Issue 23908
                    'strHTML.Append("<td  align=right>" & "Product" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strProduct_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue 23908

                    strHTML.Append("<td colspan=2>")

                    If (m_RequeststrLoginType = "E") Then
                        ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "SELECT ProductVersionID,Product + '-' + ProductVersion as Product FROM Tbl_PRD_ProductVersion A INNER JOIN tbl_PRD_Product B ON A.ProductID = B.ProductID order by Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    Else
                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'dr = CommonFunction.Data.GetDataReader("SELECT Customer  FROM tbl_PM_Customer WHERE CustomerID='" & strRequestor & "'", m_blnUseSQL)
                        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        If dr.Read Then
                            strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                        Else
                            strRequestorID = "0"
                        End If
                        CommonFunction.Data.DisposeDataReader(dr)
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                    End If
                    strHTML.Append("</td>")

                    ' Module/Compenent
                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Module/Component" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strModuleComponent_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908
                    strHTML.Append("<td  colspan='2'>")

                    If (m_RequeststrLoginType = "E") Then
                        ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                        'Modified by SonalD on 11th March for IssueID 28765

                        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        'End of modification by SonalD on 11th March 2009
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "USP_SEL_Tbl_PRD_ProductVersion_Component " + lngProductID.ToString + "," + strRequestorID, 250, lngComponentID.ToString, , True, True, , False))
                    End If

                    strHTML.Append("</td></tr>")
                    strHTML.Append("<tr  class=clsTREven><td colspan=6><HR></td></tr>")
                    'Purpose : Product and Module/Component value does not persist when ExposeTo Product Execution flag of related Dept. becomes off
                Else 'If (m_intCustomer <> 0 And m_strLoginType = "E") Or m_strLoginType = "C" Or m_RequeststrLoginType.ToUpper = "C" Then
                    strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=" + lngProductID.ToString + ">")
                    strHTML.Append("<INPUT type=hidden name='cboModule' id='cboModule' value=" + lngComponentID.ToString + ">")
                End If



                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Priority
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strPriority_Caption & "</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_RequestPriority"
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, , True, True, , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, " disabled ", True, True, , True))
                End If
                ''end Added by Amit mahadik on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                '''''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, , True, True, , True))

                ' Severity
                strHTML.Append("</TD>")
                strHTML.Append("<td align=right>" & m_strSeverity_Caption & "</TD>")
                strHTML.Append("<TD colspan=3>")
                strSQL = "usp_CRM_Get_RequestSeverity"
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, , True, True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, " disabled ", True, True))
                End If
                ''end Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                '''''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, , True, True))
                strHTML.Append("</TD>")
                strHTML.Append("</tr>")

                ' hidden dates
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Status
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right >" & m_strStatus_Caption & "</TD>")
                'Commented And Added By Vaijat K ON 07/12/2015
                'strHTML.Append("<TD>")
                strHTML.Append("<TD style='white-space:nowrap;'>")
                ' Modified by GaneshD on 05 Oct 2009 to show only the configured statuses of that subrequesttypeID
                'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0
                'If lngRequestID <> 0 Then
                '    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID.ToString & "','" & m_lngSubRequestTypeID.ToString & "'"
                'Else
                '    strSQL = "usp_CRM_Get_RequestStatus null"
                'End If

                Dim RoleId As String = Session("intPostId")

                If lngRequestID <> 0 Then
                    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID & "'," & RoleId
                Else
                    strSQL = "usp_CRM_Get_RequestStatus NULL," & RoleId
                End If

                'End of addition by GaneshD on 05 Oct 2009
                'End of Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0

                ''Added by AMIT MAHADIK on 29 March 2011 for WhizibleSEM 10.0
                If m_strApprover = "0" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , True, , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " disabled ", , True, , True))
                End If
                ''end Added by AMIT MAHADIK on 29 March 2011 for WhizibleSEM 10.0

                ''''' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , True, , True))
                ' Added by GaneshD on 09 Jun 2009 For HelpDesk StatusFlow Configuration
                ' Added by GaneshD on 09 Jun 2009 For HelpDesk StatusFlow Configuration
                m_StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(lngRequestID, String) + "", MyBase.UseSQL), "0"), Integer)
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                Dim strOldStatus As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(intStatusID, String), MyBase.UseSQL), "0"), String)
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True
                Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "'," + "1", DisplayNone:=True)) ', displaynone:=True
                ' Addition End by GaneshD 

                ' Rejection Comment
                'Commented by ShraddhaM on 17,Sep 2009 to remove reject Link
                'If intStatusID = 7 Then
                '    strHTML.Append("<b><a href='javascript:ViewRejectionComments_OnClick()'>View Comments</a><b>")
                'End If
                'Ended comment by ShraddhaM
                'Added by ShraddhaM to display changehistory of status on 17,Sep 2009
                strHTML.Append("<b><a href='javascript:ChangeHistory_OnClick()'>Status History</a><b>")

                'Call PlotFeedbackDiv()
                CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()
                'Ended by ShraddhaM


                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")

                Dim h As Integer
                Dim m As Integer

                Dim strHour As String
                Dim strMinute As String

                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                h = CType(Left(strGetServerTime1, 2), Integer)
                m = CType(Right(strGetServerTime1, 2), Integer)

                If h < 10 Then
                    strHour = "0" + h.ToString
                Else
                    strHour = h.ToString

                End If
                If m < 10 Then
                    strMinute = "0" + m.ToString
                Else
                    strMinute = m.ToString
                End If

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilterState", "txtHiddenFilterState", , 400, 100, m_FilterData.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilter", "txtHiddenFilter", , 400, 100, m_Filter.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenDepartment", "txtHiddenDepartment", , 400, 100, m_Department.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenStatus", "txtHiddenStatus", , 400, 100, m_Status.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                strHTML.Append("<td align=right >" & m_strStatusChangeDate & "</TD>")
                strHTML.Append("<TD >")

                'Hidden date control contains DateValue of particular status from database
                strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True, ))


                'control contains DateValue of particular status from database
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, True, , , ))
                Else
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , True, , , True, True, , , ))
                End If
                ''end Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                '''''strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, True, , , ))
                'strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , m_strStatusChangeTimeValue, , , , , , True, , True, , , , , , True, "Soft", ))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , m_strStatusChangeTimeValue, , , , , , True, , True, , , , , , True, "Soft", , EnableHTMLEncode:=True))
                strHTML.Append("</TD>")
                strHTML.Append("<td align=right >" & m_strStatusChangeTime & "</TD>")
                strHTML.Append("<TD >")
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then

                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , , , , , True, True, , , EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , True, , , , , True, True, , , EnableHTMLEncode:=True))
                End If
                'ended by Yogesh J for HTML encoding Date:05/10/15

                ''end Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                '''''strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , , , , , True, True, , , ))
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmRequestDetails", , , , , , , True, False, , , True))
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strCurrentHours + ":" + strCurrentTime, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15


                '****************************** CHANGE OF ROW ********************************************************************************************
                strHTML.Append("<TR class=clsTREven>")
                'Commented and Added BY Bharat T on 3rd-Dec-2015
                'strHTML.Append("<TD align=right vAlign=top>" & m_strComments_Caption & "</TD>")
                strHTML.Append("<TD align=right style='vertical-align:top;'>" & m_strComments_Caption & "</TD>")
                'End of Commented and Added BY Bharat T on 3rd-Dec-2015
                strHTML.Append("<TD colspan=5>")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , True, , , , , , , "Soft", ))
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , True, , , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", ))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Assign TO link will be enable only to HRM or department head
                If blnDisabledAssignToCombo Then
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right>" & m_strAssignTo_Caption & "</TD>")
                    strHTML.Append("<TD>")
                Else
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right><A Href='JavaScript:AssignTo_OnClick()' >" & m_strAssignTo_Caption & "</A></TD>")
                    strHTML.Append("<TD>")
                End If

                strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString

                If blnDisabledAssignToCombo Then
                    ' If not HRM or department head display disabled controls
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , intComboSize, , strAssignTo, IsDisabled:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")
                Else
                    ' If HRM or department head then display Assign To drop down and Show Schedule link
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , intComboSize, , strAssignTo, IsDisabled:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtSubmittedDate", "txtSubmittedDate", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")
                End If

                ' Expected date of resolution
                strHTML.Append("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
                strHTML.Append("<TD>")

                ' admin/requestor of course can change the date
                ' Make Mandatory for Exp.Resolution Date For CleanUp Activity
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , True, True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , True, , , True, True))
                End If
                ''end Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                '''''strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , True, True))
                strHTML.Append("</TD>")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                ' CRM Expected date of resolution
                If m_lngCRMID <> 0 Then
                    ' If logged in person is HRM or department head then display date control for CRM expected date of resolution
                    strHTML.Append("<TD align=right>" & m_strCRMExpectedResolvedDate_Caption & "</TD>")
                    strHTML.Append("<TD>")
                    'To Make Mandatory CRM Exp.Resolution Date
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", returnHTML:=True, IsMandatory:=True))
                    strHTML.Append("</TD>")
                    strHTML.Append("</TR>")
                Else
                    'CRM Exp resolution field gets cleared when submitter of the request saves it
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", returnHTML:=True, DisplayNone:=True))
                    strHTML.Append("<TD></TD><TD></TD></TR>")
                End If

                strHTML.Append("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Target Location

                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
                strHTML.Append("<TD>")
                'Inactive OU should not be displayed in Organisation Unit combo
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, , True, True, , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, " disabled ", True, True, , True))
                End If
                ''end Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                '''' strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, , True, True, , True))
                strHTML.Append("</TD>")
                strHTML.Append("<TD align=right >Deliverable</td>")
                strHTML.Append("<TD>")


                ' Deliverable
                Dim strDeliverableName As String = ""
                Dim drGetDeliverable As IDataReader


                If m_strDeliverableID <> "" Then
                    'Commented and added by ShraddhaM to display Deliverable Project Name
                    'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
                    strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drGetDeliverable.Read Then
                        strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                        m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                        strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
                    End If

                    CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , intComboSize, 200, m_strDeliverableID, , , False, , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , intComboSize, , strDeliverableName.ToString, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")
                strHTML.Append("<TD align=right >Project Name</td><TD>")
                'Added by ShraddhaM to display project name on 16 Sep 2009

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", , intComboSize, 200, m_strDelProjectID, , , False, , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", , intComboSize, , strDelProjectName, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                'Ended by ShraddhaM
                strHTML.Append("</TD></TR>")

                ' Feedback Parameters
                ' if the status is  "Closed" show feedback param
                If intStatusID <> 2 Then
                    strStyle = " style='display:none' "
                End If

                Dim strIsFeedbackdisabled As String = ""

                strIsFeedbackdisabled = " disabled "

                ' feeb back (submitted mode)
                strHTML.Append("<TR id=TRFeedback class=clsTREven " & strStyle & ">")
                strHTML.Append("<TD align=right>Feedback</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_Feedback_ForCombo"
                ''Commented And Added By Vaijat K ON 10/10/2016
                ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, " disabled", , True, , True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, strIsFeedbackdisabled, , True, , True))
                ''End of addition by Vaijat k
                strHTML.Append("</TD>")

                strHTML.Append("<TD></TD><TD></TD><TD></TD><TD></TD>")
                strHTML.Append("</TR>")

                strHTML.Append("<TR id=TRFeedbackComments class=clsTREven  " & strStyle & " >")
                'Commented and Added BY Bharat T on 3rd-Dec-2015
                'strHTML.Append("<TD align=right vAlign=top >Feedback Comments </TD>")
                strHTML.Append("<TD align=right style='vertical-align:top;' >Feedback Comments </TD>")
                'END OF Commented and Added BY Bharat T on 3rd-Dec-2015
                strHTML.Append("<TD colspan=5>")

                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , True, True, , , , True, True, , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , True, True, , , , True, True, , , , , , "Soft", , EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")
                strHTML.Append("</Table>")



                ' To persists Paging Number on List PAge after saving request in edit mode
                Dim strPageNumber As String
                strPageNumber = Request.QueryString("PageNumber")
                If strPageNumber Is Nothing OrElse strPageNumber = "" Then
                    strPageNumber = Request.Form("hidPageNumber")
                End If
                strHTML.Append("<INPUT type=hidden name='hidPageNumber' id='hidPageNumber' value=" + strPageNumber + ">")

                Response.Write(strHTML.ToString)

                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To Plot Custom Fields
                PlotCustomFields()
                'End Addition

            Case TAB_ATTACHMENT
                strHTML.Append(strMenu)
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)
                PlotAttachmentsGrid()
                Response.Write("</TABLE>")

            Case TAB_DISCUSSION_THREAD
                strHTML.Append(strMenu)
                'ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                ' Page legend
                If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
                    Dim arrLegendDiscussion() As String = {"Discussion thread in blue color indicates thread shown to customer"}
                    arrLegendImage.SetValue("", 0)
                    strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegendDiscussion, True)
                    strHTML.Append(strLegend)
                End If
                'END ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)

                strSQL = "usp_CRM_Discussions " & m_lngQueryID
                m_objGrid = New WebPages.Template.GenericGrid
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                Dim arrIgnoreHTMLEncode() As String = {"0"}
                'ended by Yogesh J for HTML encoding Date:05/10/15
                ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
                If m_strApprover = "0" Then
                    'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread", ""}
                    Dim arrUserFriendlyCols() As String = {"Submitted By", "Submitted Date", "Comment", "Select"}
                    Dim arrCheckBox() As String = {"", "", "", "chkDiscussionThread"}

                    'end Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    With m_objGrid
                        .NoOfDataColumns = 3
                        'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .PrimaryKey = "CRMQueryDetailid"
                        .CheckBoxIDArray = arrCheckBox
                        'END Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .UserFriendlyColumnArray = arrUserFriendlyCols
                        .ActualColumnArray = arrActualCols
                        .returnHTML = False
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        .SQL = strSQL
                        .UseSQL = m_blnUseSQL
                        .PrinterFriendlyVersion = True
                        .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing
                Else
                    'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread"}
                    Dim arrUserFriendlyCols() As String = {"Submitted By", "Submitted Date", "Comment"}
                    'end Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS


                    With m_objGrid
                        .NoOfDataColumns = 3
                        'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .PrimaryKey = "CRMQueryDetailid"
                        'END Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .UserFriendlyColumnArray = arrUserFriendlyCols
                        .ActualColumnArray = arrActualCols
                        .returnHTML = False
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        .SQL = strSQL
                        .UseSQL = m_blnUseSQL
                        .PrinterFriendlyVersion = True
                        .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing
                End If
                ''END Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot

                ''''''''''Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                '''''''''Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread", ""}
                '''''''''Dim arrUserFriendlyCols() As String = {"Submitted By", "Submitted Date", "Comment", "Select"}
                '''''''''Dim arrCheckBox() As String = {"", "", "", "chkDiscussionThread"}
                ''''''''''end Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                '''''''''With m_objGrid
                '''''''''    .NoOfDataColumns = 3
                '''''''''    'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                '''''''''    .PrimaryKey = "CRMQueryDetailid"
                '''''''''    .CheckBoxIDArray = arrCheckBox
                '''''''''    'END Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                '''''''''    .UserFriendlyColumnArray = arrUserFriendlyCols
                '''''''''    .ActualColumnArray = arrActualCols
                '''''''''    .returnHTML = False
                '''''''''    .SQL = strSQL
                '''''''''    .UseSQL = m_blnUseSQL
                '''''''''    .PrinterFriendlyVersion = True
                '''''''''    .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                '''''''''    .DrawGrid()
                '''''''''End With
                '''''''''m_objGrid = Nothing

                Response.Write("</TABLE>")

            Case TAB_SLA
                strHTML.Append(strMenu)
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)
                PlotSLAGrid()

            Case TAB_ACTIVITY_LOG
                strHTML.Append(strMenu)
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)
                PlotActivityLogGrid()


        End Select


        Response.Write("</div>")

        Response.Write("<BR>")
        Response.Write(strMenu)

    End Sub
    Private Sub DrawOnBehalfOptions(ByRef strHTML As System.Text.StringBuilder)
        'Dim strHTML As System.Text.StringBuilder = New System.Text.StringBuilder
        'Added by ShraddhaM on 19,Sep 2009 to change OnBehalf Functionality
        strHTML.Append("<div id=divObBehalf style='overflow:auto;width:99.9%'>" & vbCrLf)
        strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
        strHTML.Append("<TR class=clsTRSectionHeader>" & vbCrLf)
        strHTML.Append("<TD width=40%><B> Do you want to post Request on Behalf of ? </B>&nbsp;&nbsp;" & vbCrLf)

        'strHTML.Append("<TD>" & vbCrLf)
        strHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optOnBehalf", "optOnBehalf", , m_IsOnbehalfSELF, "Self", , "onclick=javascript:OnBehalfSelf_onClick()", True) & vbCrLf)
        strHTML.Append("&nbsp;Self" & vbCrLf)
        'strHTML.Append("</TD>" & vbCrLf)

        strHTML.Append("&nbsp;&nbsp; " & vbCrLf)
        strHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optOnBehalf", "optOnBehalf", , m_IsOnbehalfCUST, "Customer", , "onclick=javascript:OnBehalfCust_onClick()", True) & vbCrLf)
        strHTML.Append("&nbsp;Customer" & vbCrLf)
        'strHTML.Append("</TD>" & vbCrLf)

        If m_IsOnbehalfCUST = True Then
            strHTML.Append("&nbsp;<A id='CustomerLink' onclick=""javascript:SelectCustomer_onClick()""><u>Customer</u></A>" & vbCrLf)
        Else
            strHTML.Append("&nbsp;<A id='CustomerLink' style='display:none' onclick=""javascript:SelectCustomer_onClick()""><u>Customer</u></A>" & vbCrLf)
        End If


        strHTML.Append("&nbsp;&nbsp;" & vbCrLf)
        strHTML.Append(CommonFunction.HTMLControls.DrawOptionButton("optOnBehalf", "optOnBehalf", , m_IsOnbehalfEMP, "Employee", , "onclick=javascript:OnBehalfEmp_onClick()", True) & vbCrLf)
        strHTML.Append("&nbsp;Employee" & vbCrLf)


        'strHTML.Append("</TR>" & vbCrLf)

        'Second(Row)
        'strHTML.Append("<TR class=clsTRSectionHeader>" & vbCrLf)
        'strHTML.Append("<TD>" & vbCrLf)
        'strHTML.Append("&nbsp;<A id='CustomerLink' style='display:none' onclick=""javascript:SelectCustomer_onClick()""><u>Customer</u></A>" & vbCrLf)

        'strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOnBehalfCustomer", "txtOnBehalfCustomer", , 150, , , , , , , , , " style='display:none' ", True) & vbCrLf)

        'strHTML.Append("</TD>" & vbCrLf)

        'strHTML.Append("<TD>" & vbCrLf)
        If m_IsOnbehalfEMP = True Then
            strHTML.Append("&nbsp;<A id='EmployeeLink'  onclick=""javascript:SelectEmployee_onClick()""><u>Employee</u></A>" & vbCrLf)
        Else
            strHTML.Append("&nbsp;<A id='EmployeeLink' style='display:none' onclick=""javascript:SelectEmployee_onClick()""><u>Employee</u></A>" & vbCrLf)
        End If


        'strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtOnBehalfEmployee", "txtOnBehalfEmployee", , 150, , , , , , , , , " style='display:none' ", True) & vbCrLf)

        'strHTML.Append("</TD>" & vbCrLf)

        strHTML.Append("</TR>" & vbCrLf)


        strHTML.Append("</Table>" & vbCrLf)
        strHTML.Append("</div>" & vbCrLf)

        strHTML.Append("</BR>" & vbCrLf)


    End Sub
    Private Sub DrawPageForSR()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To Change UI of Request Detail Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : PradipK
        ' Created               :Feb 06,2007
        ' Revisions             :
        '=====================================================================
        Dim strHTML As System.Text.StringBuilder = New System.Text.StringBuilder

        If UCase(Trim(m_strMode & "")) = "NEW" Then
            strHTML.Append(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_NEW_REQUEST"), , , True))
        Else

        End If

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Display Header - Request ID, Requestor, Requested On
        ' ----------------------------------------------------------------------------------------------------------------------------
        'Addedby ShraddhaM for Performance Check Whizible9.0

        'If m_intShow <> 1 Then
        Dim strHeaderDtls As String
        Dim drDtls As IDataReader
        Dim FlagTo As String
        Dim FlagDateStatus As String
        Dim FlagStatus As String
        Dim FlagImage As String

        strHeaderDtls = "usp_Sel_RequestHeaderDetails " + m_lngQueryID.ToString + "," + Session("intUserID").ToString()

        drDtls = CommonFunction.Data.GetDataReader(strHeaderDtls, MyBase.UseSQL)
        lngRequestID = m_lngQueryID
        While drDtls.Read()
            strRequestor = drDtls("CustomerID").ToString()
            m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("ClientName"), "0"), String)
            'm_strSubmittedDate = CommonFunctions.Dates.GetDate(CType(drDtls("SubmittedDate"), Date)).ToString()
            m_strSubmittedDate = drDtls("SubmittedDate").ToString()
            FlagTo = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagTo"), "2"), String)
            FlagDateStatus = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagDateStatus"), "E"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drDtls)
        'End of addition by ShraddhaM
        '  End If

        If FlagTo = "1" Then
            FlagStatus = "Review"

        ElseIf FlagTo = "0" Then
            FlagStatus = "Follow Up"
        Else
            FlagStatus = "Flag To"
        End If

        'Commented And Added By Vaijat K ON 07/12/2015
        'If FlagDateStatus = "L" Then
        '    FlagImage = "../../../responsive/images/RedFlag.gif"
        'ElseIf FlagDateStatus = "G" Then
        '    FlagImage = "../../../responsive/images/GreenFlag.gif"
        'ElseIf FlagDateStatus = "S" Then
        '    FlagImage = "../../../responsive/images/YellowFlag.gif"
        'ElseIf FlagDateStatus = "B" Then
        '    FlagImage = "../../../responsive/images/BlackFlag.gif"
        'Else
        '    FlagImage = "../../../responsive/images/GrayFlag.gif"
        'End If

        If FlagDateStatus = "L" Then
            FlagImage = "../../Images/RedFlag.gif"
        ElseIf FlagDateStatus = "G" Then
            FlagImage = "../../Images/GreenFlag.gif"
        ElseIf FlagDateStatus = "S" Then
            FlagImage = "../../Images/YellowFlag.gif"
        ElseIf FlagDateStatus = "B" Then
            FlagImage = "../../Images/BlackFlag.gif"
        Else
            FlagImage = "../../Images/GrayFlag.gif"
        End If

        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            strHTML.Append("<TR  class=clsTRPageCaption>")


            If m_strLoginType.ToString.ToUpper = "E" And (m_intCustomer = 0 And m_intRequestedEmployee = 0) Then
                strHTML.Append("<TD title='Flag' align=right width='10%' ><a href=""javascript:Flag_OnClick(" + m_lngQueryID.ToString + " )""><IMG Border=0  SRC='" + FlagImage + "'  title='" + FlagStatus + "' onclick="""" ></a></TD>")
            End If

            strHTML.Append("<TD width='15%' align=center> <B>Request ID<BR> <Font size=4>" + lngRequestID.ToString + "</Font></B></td>")

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtShowTab", "txtShowTab", , , , m_intShow.ToString(), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
            strHTML.Append("<TD width='75%'> Requestor : ")
            If m_RequeststrLoginType.ToUpper = "C" Then
                If m_strClienName = "0" Then
                    strHTML.Append(strRequestor.ToString)
                Else
                    If m_strClienName <> "" Then
                        strHTML.Append(strRequestor.ToString + " | " + m_strClienName)
                    End If
                End If
            Else
                strHTML.Append(strRequestor.ToString)
            End If

            strHTML.Append(" | Requested on: " + m_strSubmittedDate)
            strHTML.Append("</TD></TR>")
            strHTML.Append("</TABLE>")
        End If
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Header
        ' ----------------------------------------------------------------------------------------------------------------------------

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Header for "On behalf of"
        ' ----------------------------------------------------------------------------------------------------------------------------
        If UCase(Trim(m_strMode & "")) = "NEW" Then

            If m_strLoginType <> "E" Or m_intCustomer <> 0 Or m_intRequestedEmployee <> 0 Then 'Or m_strVal <> "I" 
                If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''strSQLCustomerName = "select CustomerName from tbl_pm_customer where Customer=" & CType(HttpContext.Current.Session("Customer"), Long)
                    strSQLCustomerName = "usp_sel_tbl_PM_Customer_CustomerName '" & CType(HttpContext.Current.Session("Customer"), Long) & "'"
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    drCustomerName = CommonFunctions.Data.GetDataReader(strSQLCustomerName, m_blnUseSQL)
                    If drCustomerName.Read Then
                        strCustomerName = CType(CommonFunctions.Data.CheckIsDBNull(drCustomerName("CustomerName"), "0"), String)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drCustomerName)
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    strHTML.Append("<b>")
                    strHTML.Append("<TR class=clsTREven align=center width='99.9%'> <FONT color=blue>" & MyBase.GetResourceString("CAPTION_ON_BEHALF_OFCUSTOMER") & strCustomerName & "</FONT> ")
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtShowTab", "txtShowTab", , , , m_intShow.ToString(), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TR>")
                    strHTML.Append("</b>")
                    strHTML.Append("</Table>")
                ElseIf m_intRequestedEmployee <> 0 Then
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    strHTML.Append("<b>")
                    strHTML.Append("<TR class=clsTREven align=center width='99.9%'> <FONT color=blue>" & "You are adding Request on behalf of Employee :" & m_strRequestedEmployee & "</FONT> ")
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TR>")
                    strHTML.Append("</b>")
                    strHTML.Append("</Table>")
                End If
            End If
        End If
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Header for "On behalf of"
        ' ----------------------------------------------------------------------------------------------------------------------------

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------
        Dim txtResult As New System.Text.StringBuilder
        Dim intSelectedTabValue As Integer
        intSelectedTabValue = m_intShow

        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            'Added by Anju on 29 April 09
            'Draw Tabs
            With txtResult
                .Append("<TABLE BORDER=0 cellpadding=0 cellspacing=0 width='99.9%' class='clsTable'><TR class=clsTRSectionHeader valign=middle>") '+ vbCrLf

                .Append("<TD nowrap class='mainTabsSectionEasyMenu'>")

                If intSelectedTabValue = TAB_REQUEST_DETAILS Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If

                If intSelectedTabValue = TAB_ATTACHMENT Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If

                If intSelectedTabValue = TAB_DISCUSSION_THREAD Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Discussion Thread'+ href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Discussion Thread' href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If

                If m_strLoginType <> "C" Then ' Do not display SLA tab to customer 
                    If m_blnSLAAccess = True Then
                        If intSelectedTabValue = TAB_SLA Then
                            .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='SLA'+ href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                        Else
                            .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='SLA' href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                        End If
                    End If
                End If

                If m_strLoginType <> "C" Then ' Do not display Activity Log tab to customer
                    If intSelectedTabValue = TAB_ACTIVITY_LOG Then
                        .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='ActivityLog'+ href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    Else
                        .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='ActivityLog' href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    End If
                End If

                .Append("</TD></TR></TABLE>")
            End With

            strHTML.Append(txtResult.ToString)

            txtResult = Nothing
            'End of modification by Anju on 29 April 09
        End If
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw details depending on selectd tab
        ' ----------------------------------------------------------------------------------------------------------------------------
        Select Case intSelectedTabValue
            Case TAB_REQUEST_DETAILS
                ' menu
                strHTML.Append(strMenu)
                'page legend
                strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
                strHTML.Append(strLegend)

                If UCase(Trim(m_strMode & "")) = "NEW" Then
                    Dim strHRMSQL As String
                    Dim drHRM As IDataReader
                    Dim HRMOrDeptHead As String
                    strHRMSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID
                    drHRM = CommonFunctions.Data.GetDataReader(strHRMSQL, m_blnUseSQL)
                    If drHRM.Read Then
                        HRMOrDeptHead = CType(CommonFunctions.Data.CheckIsDBNull(drHRM("EmployeeID"), "0"), Long)
                    End If
                    CommonFunctions.Data.DisposeDataReader(drHRM)
                    If HRMOrDeptHead <> "" And m_strLoginType = "E" Then
                        Call DrawOnBehalfOptions(strHTML)
                    End If

                End If


                'Ended by ShraddhaM on 19,Sep 2009 to change OnBehalf Functionality
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)

                '********************* FIRST ROW *******************************************************************************************
                ' function/Department
                strHTML.Append("<tr class=clsTREven>")
                strHTML.Append("<td  align=right width=5% >" & m_strFunction_Caption & "</td>")
                strHTML.Append("<td width=15%>")

                Dim strSQLRole As String
                Dim drRole As IDataReader
                Dim lngPostID As Long = 0
                ' to take postid of the employee at corporate level not from session

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
                drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If drRole.Read Then
                    lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(drRole)
                If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
                    strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
                    strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
                ElseIf m_intRequestedEmployee <> 0 Then
                    strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
                Else
                    strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
                End If

                If blnDisableFunctionCombo Then
                    If m_strLoginType <> "C" Then
                        If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                            strSQL += "," + lngRequestID.ToString
                        End If
                    End If
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, " disabled ", True, True, , True))
                Else
                    If m_strLoginType <> "E" Then
                        ''commented and added by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_Department_ForCustomer " + m_lngEmployeeID.ToString, intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        ''End of comment and addition by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                    Else
                        If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                            ''commented and added by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                            'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_Department_ForCustomer " + m_intCustomer.ToString, intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                            ''End of comment and addition by NitinC on 15 March 2011 for WhizibleSEM version 10.0
                        Else
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, "onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        End If
                    End If
                End If
                strHTML.Append("</td>")

                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right width=6% > Request Type </td>")
                    ' strHTML.Append("<td  align=right width=6% > " & m_strRequestType_Caption & " </td>")
                    'Commented added  by Shamkant S on 25 Nov 2015
                    strHTML.Append("<td  align=right width=7% > " & m_strRequestType_Caption & " </td>")
                    'Commented ended by Shamkant S on 25 Nov 2015
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908
                    strHTML.Append("<td width=15%>")
                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
                        strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
                        strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
                        strSQL += "  and RoleID =23 AND functionID = " & lngFunctionID
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                        Else
                            strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                        End If
                    End If

                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                    strHTML.Append("</td>")
                    'strHTML.Append("<td  align=right width=8%> " & m_strSubRequestType_Caption & " </td>")
                    'Commented ended by Shamkant S on 25 Nov 2015
                    strHTML.Append("<td  align=right width=9%> " & m_strSubRequestType_Caption & " </td>")
                    'Commented ended by Shamkant S on 25 Nov 2015
                    strHTML.Append("<td width=15%>")

                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        Dim strSqlQuery_CustName As String

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'strSqlQuery_CustName = "SELECT CustomerID FROM tbl_pm_Customer WHERe Customer = " & HttpContext.Current.Session("Customer").ToString()
                        strSqlQuery_CustName = "usp_sel_tbl_pm_customer_CustomerID " & HttpContext.Current.Session("Customer").ToString()
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        m_strUserName = CType(CommonFunctions.Data.GetDataScalar(strSqlQuery_CustName, MyBase.UseSQL), String)

                        strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','C',0," & m_lngRequestTypeId.ToString & ",0"
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
                        Else
                            strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
                        End If
                    End If
                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                Else
                    'Sub Requst Type
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right > Request Type </td>")
                    strHTML.Append("<td  align=right > " & m_strRequestType_Caption & " </td>")
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908
                    strHTML.Append("<td colspan=3>")
                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        'Purpose:If Request is posted On Behalf of Customer when Split Request Type-Sub Type-Off at Corporate Level 
                        'and customer login is not created, still request can be put on behalf of this customer by the HRM login.
                        Dim strSqlQuery_CustName As String

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'strSqlQuery_CustName = CType(CommonFunctions.Data.GetDataScalar("SELECT CustomerID FROM tbl_pm_Customer WHERe Customer = " & HttpContext.Current.Session("Customer").ToString(), MyBase.UseSQL), String)
                        strSqlQuery_CustName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_pm_customer_CustomerID " & HttpContext.Current.Session("Customer").ToString(), MyBase.UseSQL), String)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(strSqlQuery_CustName) & "','C',0"
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                        Else
                            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                        End If
                    End If

                    If Not Page.IsPostBack Then
                        If CommonFunction.Application.SplitRequestTypeSubType = False Then
                            strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
                        End If
                    End If

                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                End If

                'Template
                If m_lngSubRequestTypeID <> 0 Then
                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")

                    strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
                    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    If dr.Read Then
                        intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                        Select Case intTemplateCount
                            Case 0 ' no templates
                                ' Commented by MonikaI on 14th Jul 2009 
                                ' RequestID 21655 Not able to download template attached with sub type if File server is different.
                                'Case 1 ' only one template

                                '    strHTML.Append("<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateID"), "0"), Long)) & "' >" & vbCrLf)
                                '    strHTML.Append("<Image Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'>")
                                '    strHTML.Append("</A>")
                                ' End of modification by MonikaI on 14th Jul 2009
                            Case Else ' multiple templates
                                'Commented And Added By Vaijat K ON 07/12/2015
                                'strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'></A>")
                                strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                        End Select
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If
                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                Else
                    'Sub Request Type not Ploted..
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                End If

                'Code added by vidyak on 31 may 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
                If UCase(Trim(m_strMode & "")) = "NEW" And Trim(m_lngSubRequestTypeID & "") <> "" And ((m_intCustomer = 0) Or (m_intRequestedEmployee <> 0)) And m_strLoginType = "E" Then
                    Dim IsApproval As String
                    IsApproval = CType(CommonFunctions.Data.GetDataScalar("usp_Sel_tbl_CRM_Function_RequestTypes_Approval " & lngFunctionID & "," & m_lngRequestTypeId & "," & m_lngSubRequestTypeID, MyBase.UseSQL), String)
                    If IsApproval = "1" Then
                        strHTML.Append("<TR class=clsTREven>")
                        strHTML.Append("<TD align=right></TD><td colspan=5><font color=red><b>")
                        strHTML.Append("This request will require Approval Of Reporting To.</b></font>")
                        strHTML.Append("</td></tr>")
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                End If
                'End Code added by vidyak on 31 may 2010 Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)



                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Guidelines
                If Trim(m_lngSubRequestTypeID & "") <> "" Then
                    dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & m_lngSubRequestTypeID, m_blnUseSQL)
                    If dr.Read Then
                        If Trim(dr(strGuidelinesColumnName).ToString & "") <> "" Then
                            strHTML.Append("<TR class=clsTREven><td  align=right VAlign=Top>")
                            strHTML.Append(GetCaption(919, strGuidelinesColumnName))
                            strHTML.Append("</td>")
                            ''Commented and added by Yogesh J on 22-Jan-2016
                            'strHTML.Append("<td  VAlign=Top colspan=5 ><PRE>")
                            'strHTML.Append(dr(strGuidelinesColumnName).ToString & "</PRE>")
                            strHTML.Append("<td  VAlign=Top colspan=5 ><P>")
                            strHTML.Append(dr(strGuidelinesColumnName).ToString & "</P>")
                            ''End of comment by Yogesh J on 22-jan-2016

                            strHTML.Append("</td></tr>")
                        End If
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                End If

                If strAprovalStatus <> "" Then
                    If Not strAprovalStatus Is Nothing And strAprovalStatus <> "-" And strAprovalStatus.Trim() <> "" Then

                        strHTML.Append("<TR class=clsTREven>")
                        strHTML.Append("<TD align=right></TD>")
                        strHTML.Append("<TD colspan=5><b>")

                        If strAprovalStatus.Trim() = "A" Then
                            strHTML.Append("Request has been approved by : " + strReportingTo)
                        ElseIf strAprovalStatus.Trim() = "R" Then
                            strHTML.Append("Request has been rejected by : " + strReportingTo)
                        Else
                            strHTML.Append("Request has been sent for approval to : " + strReportingTo)
                        End If
                        strHTML.Append("</b></TD>")
                        strHTML.Append("</TR>")
                    End If
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' subject
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strSubject_Caption & "</TD>")
                strHTML.Append("<TD colspan=5>")

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , intWidth, intPixelSize, strSubject, , , blnDisbaledSubjectTextBox, , , , , True, True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Description
                strHTML.Append("<TR class=clsTREven>")

                'Commented and Added BY Bharat T on 3rd-Dec-2015
                ' strHTML.Append("<TD align=right vAlign=top>" & m_strDescription_Caption & "</TD>")
                strHTML.Append("<TD align=right style='vertical-align:top;'>" & m_strDescription_Caption & "</TD>")
                'END OF Commented and Added BY Bharat T on 3rd-Dec-2015
                strHTML.Append("<TD colspan=5> ")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                strHTML.Append("</TD></TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ''Product & Component
                If CommonFunction.Application.EnableProductExecution = True Then

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
                    dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If dr.Read Then
                        ShowProductCombo = "1"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                End If

                If ShowProductCombo = "1" Then
                    strHTML.Append("<tr class=clsTREven><td colspan=6><HR></td></tr>")
                    strHTML.Append("<tr class=clsTREven>")
                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Product" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strProduct_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908
                    strHTML.Append("<td colspan=2 >")

                    If (m_intCustomer = 0 And m_strLoginType = "E") Then  ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "SELECT ProductVersionID,Product + '-' + ProductVersion as Product FROM Tbl_PRD_ProductVersion A INNER JOIN tbl_PRD_Product B ON A.ProductID = B.ProductID order by Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    ElseIf m_strLoginType = "C" Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                    ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                    End If
                    strHTML.Append("</td>")
                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Module/Component" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strModuleComponent_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908
                    strHTML.Append("<td  colspan='2' >")

                    If (m_intCustomer = 0 And m_strLoginType = "E") Then
                        ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                        'Modified by SonalD on 12th Nov 2008 for RequestID 9977
                        'Purpose : To sort Components
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString + " ORDER BY Component", 250, lngComponentID.ToString, , True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        'End of addition by SonalD on 12th Nov 2008
                    ElseIf m_strLoginType = "C" Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & CType(Session("intUserID"), String) & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))
                    ElseIf (m_intCustomer <> 0 And m_strLoginType = "E") Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & m_intCustomer.ToString & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))

                    End If
                    strHTML.Append("</td></tr>")
                    strHTML.Append("<tr  class=clsTREven><td colspan=6><HR></td></tr>")
                    'Purpose : Product and Module/Component value does not persist when ExposeTo Product Execution flag of related Dept. becomes off
                Else 'If (m_intCustomer <> 0 And m_strLoginType = "E") Or m_strLoginType = "C" Or m_RequeststrLoginType.ToUpper = "C" Then
                    strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=" + lngProductID.ToString + ">")
                    strHTML.Append("<INPUT type=hidden name='cboModule' id='cboModule' value=" + lngComponentID.ToString + ">")
                End If


                '****************************** CHANGE OF ROW ********************************************************************************************
                ' priority
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strPriority_Caption & "</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_RequestPriority"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, , True, True, , True))
                strHTML.Append("</TD>")

                strHTML.Append("<td align=right>" & m_strSeverity_Caption & "</TD>")
                strHTML.Append("<TD colspan=3>")
                strSQL = "usp_CRM_Get_RequestSeverity"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, , True, True))
                strHTML.Append("</TD>")
                strHTML.Append("</tr>")

                '' hidden dates
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                '****************************** CHANGE OF ROW ********************************************************************************************
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    ' Status
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right >" & m_strStatus_Caption & "</TD>")
                    strHTML.Append("<TD >")
                    'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0
                    '' Modified by GaneshD on 05 Oct 2009 for showing only those statuses which are configured.
                    '' strSQL = "usp_CRM_Get_RequestStatus"
                    'strSQL = "usp_CRM_Get_RequestStatus " + lngRequestID.ToString + "," + m_lngSubRequestTypeID.ToString
                    Dim RoleId As String = Session("intPostId")
                    strSQL = "usp_CRM_Get_RequestStatus '" & lngRequestID.ToString & "'," & RoleId

                    'End of modification by GaneshD 
                    'End of Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0
                    If blnDisableStatusCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, , " disabled ", , True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , True, , True))
                        ' Added by GaneshD on 09 Jun 2009 For HelpDesk StatusFlow Configuration
                        m_StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(lngRequestID, String) + "", MyBase.UseSQL), "0"), Integer)

                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True))
                        'ended by Yogesh J for HTML encoding Date:05/10/15
                        Dim strOldStatus As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(intStatusID, String), MyBase.UseSQL), "0"), String)
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))
                        'ended by Yogesh J for HTML encoding Date:05/10/15
                        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True
                        Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "'," + "1", DisplayNone:=True)) ', displaynone:=True
                        ' Addition End by GaneshD 
                    End If
                    'Commented by ShraddhaM on 17,Sep 2009 to remove reject Link
                    'If intStatusID = 7 Then
                    '    strHTML.Append("<b><a href='javascript:ViewRejectionComments_OnClick()'>View Comments</a><b>")
                    'End If
                    'Ended by ShraddhaM on 17,Sep 2009 to remove reject Link
                    'Added by ShraddhaM to display changehistory of status on 17,Sep 2009
                    strHTML.Append("<b><a href='javascript:ChangeHistory_OnClick()'>Status History</a><b>")
                    'Call PlotFeedbackDiv()
                    CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()
                    'Ended by ShraddhaM
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")

                End If


                Dim h As Integer
                Dim m As Integer

                Dim strHour As String
                Dim strMinute As String

                'Get Server Date & Time
                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


                h = CType(Left(strGetServerTime1, 2), Integer)
                m = CType(Right(strGetServerTime1, 2), Integer)


                If h < 10 Then
                    strHour = "0" + h.ToString
                Else
                    strHour = h.ToString
                End If
                If m < 10 Then
                    strMinute = "0" + m.ToString
                Else
                    strMinute = m.ToString
                End If

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilterState", "txtHiddenFilterState", , 400, 100, m_FilterData.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilter", "txtHiddenFilter", , 400, 100, m_Filter.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenDepartment", "txtHiddenDepartment", , 400, 100, m_Department.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenStatus", "txtHiddenStatus", , 400, 100, m_Status.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                If UCase(Trim(m_strMode & "")) = "NEW" Then

                Else
                    If m_strLoginType = "E" Then
                        strHTML.Append("<td align=right >" & m_strStatusChangeDate & "</TD>")
                    Else
                        strHTML.Append("<td align=right > </TD>")
                    End If

                    strHTML.Append("<TD >")

                    'Hidden date control contains DateValue of particular status from database
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True, ))

                    'control contains DateValue of particular status from database
                    If m_strLoginType = "C" Then
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtReadOnlychangedDate", "txtReadOnlychangedDate", , 80, , CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(m_strStatusChangeDateValue), , , , True, , True, , True, False, , , EnableHTMLEncode:=True))
                        'ended by Yogesh J for HTML encoding Date:05/10/15
                        If m_strMode = "EDIT" And intRequestStatus = 2 Then
                            strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , True, , , True, False, , , True))
                        Else
                            strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True))
                        End If

                    Else
                        If m_strMode = "EDIT" And intRequestStatus = 2 Then
                            strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , True, , , True, True, , , ))
                        Else
                            strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, True, , , ))
                        End If

                    End If

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , m_strStatusChangeTimeValue, , , , , , True, , True, , , , , , True, "Soft", ))

                    strHTML.Append("</TD>")
                    If m_strLoginType = "E" Then
                        strHTML.Append("<td align=right >" & m_strStatusChangeTime & "</TD>")
                    Else
                        strHTML.Append("<td align=right > </TD>")
                    End If

                    strHTML.Append("<TD >")

                    If m_strLoginType = "C" Then
                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , True, , True, , True, False, , , EnableHTMLEncode:=True))
                    Else
                        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , , , , , True, True, , , EnableHTMLEncode:=True))

                        'ended by Yogesh J for HTML encoding Date:05/10/15

                    End If

                    strHTML.Append("</TD>")
                    strHTML.Append("</TR>")

                    'CurrentDate field will hold date of server ,not  of client
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmRequestDetails", , , , , , , True, False, , , True))
                    strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")

                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    Dim strCurrentHours As String
                    Dim strCurrentTime As String

                    strCurrentHours = Now.Hour.ToString
                    If CType(Now.Hour.ToString, Integer) < 10 Then
                        strCurrentHours = "0" + Now.Hour.ToString
                    End If
                    strCurrentTime = Now.Minute.ToString
                    If CType(Now.Minute.ToString, Integer) < 10 Then
                        strCurrentTime = "0" + Now.Minute.ToString
                    End If
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strCurrentHours + ":" + strCurrentTime, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15

                End If


                '****************************** CHANGE OF ROW ********************************************************************************************
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , 400, 100, , strComments, , , , blnReadOnlyComments, , , , True, , , , , , True, "Soft", ))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , 400, 100, , strComments, , , , blnReadOnlyComments, , , , True, , , , , , True, "Soft", , EnableHTMLEncode:=True))
                    'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    If intStatusID = 7 Then
                        ' Reasons for rejection
                        If (m_strLoginType <> "C") Then
                            strHTML.Append("<TR class=clsTREven>")
                            strHTML.Append("<TD align=right vAlign=top>" & m_strReasonsForRejection_Caption & "</TD >")
                            strHTML.Append("<TD colspan=5>")
                        End If

                        If (m_strLoginType = "C") Then
                            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , intWidth, intPixelSize, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", ))
                            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , intWidth, intPixelSize, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", , EnableHTMLEncode:=True))
                            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                        Else
                            'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                            'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , intWidth, intPixelSize, , strReasonsForRejection, , , , True, , , , True, , , , , , , "Soft", ))
                            strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , intWidth, intPixelSize, , strReasonsForRejection, , , , True, , , , True, , , , , , , "Soft", ))
                            'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                            strHTML.Append("</TD>")
                            strHTML.Append("</TR>")
                        End If
                    End If
                End If


                strHTML.Append("<TR class=clsTREven>")

                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    ' Assign TO
                    If (m_strLoginType <> "C") Then
                        strHTML.Append("<TD align=right>" & m_strAssignTo_Caption & "</TD>")
                    End If

                    strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString

                    If blnDisabledAssignToCombo Then
                        strHTML.Append("<TD>")

                        If (m_strLoginType = "C") Then

                            'Commented and added by Yogesh J for HTML encoding Date:05/10/15

                            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , , , strAssignTo, IsDisabled:=True, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                        Else
                            strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , , , strAssignTo, IsDisabled:=True, returnHTML:=True, EnableHTMLEncode:=True))
                            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                        End If

                        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                        'ended by Yogesh J for HTML encoding Date:05/10/15
                        strHTML.Append("</TD>")
                    Else
                        strHTML.Append("<TD>")
                        If (m_strLoginType = "C") Then
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, , True, True, , , , True))
                        Else
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, , True, True))
                        End If

                        strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")

                        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

                        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtSubmittedDate", "txtSubmittedDate", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                        'ended by Yogesh J for HTML encoding Date:05/10/15
                        strHTML.Append("</TD>")
                    End If
                End If

                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    If m_strLoginType <> "C" And m_intCustomer = 0 Then

                        strHTML.Append("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
                        strHTML.Append("<TD>")
                        ' To Make Mandatory Exp.Resolution Date 
                        If intRequestStatus = 2 Then
                            strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , True, , , True, True))
                        Else
                            strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , True, True))
                        End If
                        strHTML.Append("</TD>")

                    Else
                        strHTML.Append("<TD></TD><TD></TD><TD></TD>")
                    End If
                End If

                If UCase(Trim(m_strMode & "")) = "NEW" Then
                    If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
                        strHTML.Append("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
                    Else
                        strHTML.Append("<TD></TD><TD></TD>")
                    End If

                    If m_strLoginType <> "C" And m_strVal <> "C" And m_intCustomer = 0 Then
                        ' admin/requestor of course can change the date
                        strHTML.Append("<TD>")
                        strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , True, True))
                        strHTML.Append("</TD><TD></TD><TD></TD><TD></TD><TD></TD>")

                    End If
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                'CRM Exp resolution field gets cleared when submitter of the request saves it
                strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", returnHTML:=True, DisplayNone:=True))

                If m_strMode = "EDIT" Then
                    strHTML.Append("<TD></TD><TD></TD></TR>")
                    strHTML.Append("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Target Location
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    If (m_strLoginType <> "C") Then
                        strHTML.Append("<TR class=clsTREven>")
                        strHTML.Append("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
                        strHTML.Append("<TD>")
                        'Inactive OU should not be displayed in Organisation Unit combo
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, , True, True, , True))
                        strHTML.Append("</TD>")
                        'Organization Unit getting blank when we save request by customer login
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, , True, True, , True, , True))
                    End If

                End If

                If UCase(Trim(m_strMode & "")) = "NEW" Then
                    If m_strLoginType <> "C" And m_strVal <> "C" Then
                        strHTML.Append("<TR class=clsTREven>")
                        strHTML.Append("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
                        strHTML.Append("<TD>")
                    End If

                    If m_strLoginType <> "C" And m_strVal <> "C" Then
                        'Inactive OU should not be displayed in Organisation Unit combo
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units 0", intComboSize, m_ChangedLocation.ToString, , True, True, , True))
                        strHTML.Append("</TD>")
                    End If
                End If

                ' To plot hidden deliverable field in SR mode to avoid problem of blank 
                ' Deliverable field after saving in SR mode. 
                Dim strDeliverableName As String = ""
                Dim drGetDeliverable As IDataReader

                If m_strDeliverableID <> "" Then
                    'Commented and added by ShraddhaM to display Deliverable Project Name
                    'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
                    strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID
                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drGetDeliverable.Read Then
                        strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                        m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                        strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
                    End If

                    CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , False, , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , , , strDeliverableName.ToString, , , True, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")
                'strHTML.Append("<TD align=right >Project Name</td><TD>")
                'Added by ShraddhaM to display project name on 16 Sep 2009
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", , 100, 100, m_strDelProjectID, , , False, , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", , , , strDelProjectName, , , True, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                'Ended by ShraddhaM
                strHTML.Append("</TD></TR>")

                'strHTML.Append("<TD></TD><TD></TD><TD></TD><TD></TD></TR>")

                If UCase(Trim(m_strMode & "")) = "EDIT" Then

                    If intStatusID <> 2 Then
                        strStyle = " style='display:none' "
                    End If
                    Dim strIsFeedbackdisabled As String = ""

                    strIsFeedbackdisabled = ""

                    ' feeb back (submitted mode)
                    strHTML.Append("<TR id=TRFeedback class=clsTREven " & strStyle & ">")
                    strHTML.Append("<TD align=right>Feedback</TD>")
                    strHTML.Append("<TD>")
                    strSQL = "usp_CRM_Get_Feedback_ForCombo"
                    ''Commented And Added By Vaijat K ON 10/10/2016
                    ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, " disabled", , True, , True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, strIsFeedbackdisabled, , True, , True))
                    ''End of addition by Vaijat k
                    strHTML.Append("</TD>")

                    strHTML.Append("<TD></TD><TD></TD><TD></TD><TD></TD>")
                    strHTML.Append("</TR>")

                    strHTML.Append("<TR id=TRFeedbackComments class=clsTREven  " & strStyle & " >")
                    strHTML.Append("<TD align=right vAlign=top>Feedback Comments </TD>")
                    strHTML.Append("<TD colspan=5>")
                    'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , True, True, , , , True, True, , , , , , "Soft", ))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , True, True, , , , True, True, , , , , , "Soft", , EnableHTMLEncode:=True))
                    'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                    strHTML.Append("</TD>")

                    strHTML.Append("</TR>")
                End If

                ' To persists Paging Number on List PAge after saving request in edit mode
                Dim strPageNumber As String
                strPageNumber = Request.QueryString("PageNumber")
                If strPageNumber Is Nothing OrElse strPageNumber = "" Then
                    strPageNumber = Request.Form("hidPageNumber")
                End If

                strHTML.Append("<INPUT type=hidden name='hidPageNumber' id='hidPageNumber' value=" + strPageNumber + ">")

                strHTML.Append("</Table>")
                Response.Write(strHTML.ToString)

                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To Plot Custom Fields


                If m_intCustomer > 0 Then
                    UserIDForCustomFields = m_intCustomer
                    m_strLoginTypeForCustomField = "C"
                ElseIf m_intRequestedEmployee > 0 Then
                    UserIDForCustomFields = m_intRequestedEmployee
                    m_strLoginTypeForCustomField = "E"
                Else
                    UserIDForCustomFields = CType(Session("intUserID"), Integer)
                    m_strLoginTypeForCustomField = m_strLoginType
                End If
                PlotCustomFields(UserIDForCustomFields, m_strLoginTypeForCustomField)
                'End Addition

            Case TAB_ATTACHMENT

                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    ' attachments grid
                    'strHTML.Append(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ATTACHMENTS"), , , True))
                    Response.Write(strHTML.ToString)
                    PlotAttachmentsGrid()
                    Response.Write("</TABLE>")
                End If

            Case TAB_DISCUSSION_THREAD
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    'ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                    ' Page legend
                    If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
                        Dim arrLegendDiscussion() As String = {"Discussion thread in blue color indicates thread shown to customer"}
                        arrLegendImage.SetValue("", 0)
                        strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegendDiscussion, True)
                        strHTML.Append(strLegend)
                    End If
                    'END ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    Response.Write(strHTML.ToString)

                    strSQL = "usp_CRM_Discussions " & m_lngQueryID
                    m_objGrid = New WebPages.Template.GenericGrid
                    'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread", ""}
                    Dim arrUserFriendlyCols() As String = {"Submitted By", "Submitted Date", "Comment", "Select"}
                    Dim arrCheckBox() As String = {"", "", "", "chkDiscussionThread"}
                    'end Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS

                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    Dim arrIgnoreHTMLEncode() As String = {"0"}
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    With m_objGrid
                        .NoOfDataColumns = 3
                        'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .PrimaryKey = "CRMQueryDetailid"
                        .CheckBoxIDArray = arrCheckBox
                        'END Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .UserFriendlyColumnArray = arrUserFriendlyCols
                        .ActualColumnArray = arrActualCols
                        .returnHTML = False
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        .SQL = strSQL
                        .UseSQL = m_blnUseSQL
                        .PrinterFriendlyVersion = True
                        .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing

                    Response.Write("</TABLE>")
                End If

            Case TAB_SLA
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    Response.Write(strHTML.ToString)
                    PlotSLAGrid()
                End If

            Case TAB_ACTIVITY_LOG
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    Response.Write(strHTML.ToString)
                    PlotActivityLogGrid()
                End If

        End Select


        Response.Write("</div>")
        Response.Write("<BR>")
        Response.Write(strMenu)

    End Sub

    Private Sub PlotAttachmentsGrid()
        '=====================================================================
        ' Procedure Name        : PlotAttachmentsGrid()	
        ' Purpose               : To plot the grid for attachments list for reuuest
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 23,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        ''Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot
        If m_strApprover = "0" Then
            Dim arrActualCols() As String = {"AttachmentID", "OriginalFileName", "AttachedBy", "Description", "Delete"}
            Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("COL_SRNO"), MyBase.GetResourceString("COL_FILENAME"), MyBase.GetResourceString("COL_ATTACHEDBY"), MyBase.GetResourceString("COL_DESCRIPTION"), MyBase.GetResourceString("COL_DELETE")}
            Dim arrCheckBox() As String = {"", "", "", "", "chkDelete"}
            'Commnted and Added by NitinC on 11 Nov 2011 for whizibleSEM 10.0
            'strSQL = "usp_CRM_Get_Attachments  " & m_lngQueryID
            strSQL = "usp_CRM_Get_Attachments  " & CType(m_lngQueryID, String) + ",'" + m_strLoginType + "'"
            'End of Commnted and Added by NitinC on 11 Nov 2011 for whizibleSEM 10.0
            m_objGrid = New WebPages.Template.GenericGrid
            With m_objGrid
                .NoOfDataColumns = 4
                .UserFriendlyColumnArray = arrUserFriendlyCols
                .ActualColumnArray = arrActualCols
                .CheckBoxIDArray = arrCheckBox
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                .returnHTML = False
                .SQL = strSQL
                .UseSQL = m_blnUseSQL
                .PrinterFriendlyVersion = True
                .PrimaryKey = "AttachmentID"
                .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                .DrawGrid()
            End With
            m_objGrid = Nothing
        Else
            Dim arrActualCols() As String = {"AttachmentID", "OriginalFileName", "AttachedBy", "Description"}
            Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("COL_SRNO"), MyBase.GetResourceString("COL_FILENAME"), MyBase.GetResourceString("COL_ATTACHEDBY"), MyBase.GetResourceString("COL_DESCRIPTION")}

            'Commnted and Added by NitinC on 11 Nov 2011 for whizibleSEM 10.0
            'strSQL = "usp_CRM_Get_Attachments  " & m_lngQueryID
            strSQL = "usp_CRM_Get_Attachments  " & CType(m_lngQueryID, String) + ",'" + m_strLoginType + "'"
            'End of Commnted and Added by NitinC on 11 Nov 2011 for whizibleSEM 10.0
            m_objGrid = New WebPages.Template.GenericGrid
            With m_objGrid
                .NoOfDataColumns = 4
                .UserFriendlyColumnArray = arrUserFriendlyCols
                .ActualColumnArray = arrActualCols
                .returnHTML = False
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                .SQL = strSQL
                .UseSQL = m_blnUseSQL
                .PrinterFriendlyVersion = True
                .PrimaryKey = "AttachmentID"
                .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                .DrawGrid()
            End With
            m_objGrid = Nothing
        End If
        ''end Added by AMIT MAHADIK on 29 Mar2011 WhizibleSEM10.0  ,Conditional plot


        '''''Dim arrActualCols() As String = {"AttachmentID", "OriginalFileName", "AttachedBy", "Description", "Delete"}
        '''''Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("COL_SRNO"), MyBase.GetResourceString("COL_FILENAME"), MyBase.GetResourceString("COL_ATTACHEDBY"), MyBase.GetResourceString("COL_DESCRIPTION"), MyBase.GetResourceString("COL_DELETE")}
        '''''Dim arrCheckBox() As String = {"", "", "", "", "chkDelete"}
        '''''strSQL = "usp_CRM_Get_Attachments  " & m_lngQueryID
        '''''m_objGrid = New WebPages.Template.GenericGrid
        '''''With m_objGrid
        '''''    .NoOfDataColumns = 4
        '''''    .UserFriendlyColumnArray = arrUserFriendlyCols
        '''''    .ActualColumnArray = arrActualCols
        '''''    .CheckBoxIDArray = arrCheckBox
        '''''    .returnHTML = False
        '''''    .SQL = strSQL
        '''''    .UseSQL = m_blnUseSQL
        '''''    .PrinterFriendlyVersion = True
        '''''    .PrimaryKey = "AttachmentID"
        '''''    .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
        '''''    .DrawGrid()
        '''''End With
        '''''m_objGrid = Nothing
    End Sub

    Private Sub PlotActivityLogGrid()
        Dim strQuery As String
        Dim strEmployeename As String
        Dim strActivity As String
        Dim strTimeSpent As String
        Dim strCreatedDate As String
        Dim strClass As String = "clsTREven"
        Dim dblTotalSpend As Double = 0.0
        Dim blnRecordPresent As Boolean = False

        Dim dr As IDataReader
        Dim sbHTML As New System.Text.StringBuilder("")

        Dim strSubject As String

        strSQL = "usp_Sel_EmployeeActivity " + m_lngQueryID.ToString
        dr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        sbHTML.Append("<table id='tblActivityDtls' cellpadding=0 cellspacing=1 class='clsGridTable'  width=99.9% >")
        sbHTML.Append("<TR class='clsTRColumnHeader' style='FONT-WEIGHT:bold' >")

        sbHTML.Append("<TD >Date</TD>" + vbCrLf)
        sbHTML.Append("<TD >Employee Name</TD>" + vbCrLf)
        sbHTML.Append("<TD > Activity Name</TD>" + vbCrLf)
        sbHTML.Append("<TD  align=right>Time Spent (Min)</TD>" + vbCrLf)

        sbHTML.Append("</TR>" + vbCrLf)

        While dr.Read()
            blnRecordPresent = True
            strEmployeename = dr("EmployeeName").ToString()
            strActivity = dr("Activity").ToString()
            strTimeSpent = dr("TimeSpent").ToString()
            strCreatedDate = CommonFunctions.Dates.CGetDate(CType(dr("CreatedDate"), Date))
            dblTotalSpend += CType(CommonFunction.Data.CheckIsDBNull(dr("TimeSpent"), "0"), Double)

            sbHTML.Append("<TR class=" + strClass + " > ")

            sbHTML.Append("<TD>" + strCreatedDate + "</TD>" + vbCrLf)

            sbHTML.Append("<TD>" + strEmployeename + "</TD>" + vbCrLf)
            sbHTML.Append("<TD>" + strActivity + "</TD>" + vbCrLf)
            sbHTML.Append("<TD align=right>" + strTimeSpent + "</TD>" + vbCrLf)

            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If

            sbHTML.Append("</TR>" + vbCrLf)


        End While

        If blnRecordPresent = False Then
            sbHTML.Append("<TR class=clsTREvenRow><TD align='center' colspan=11 Width=10%>There are no items to show in this view.</TD></TR>")
        End If

        sbHTML.Append("<TR class='clsTRGroupHeader' > ")
        sbHTML.Append("<TD align='left'>Total Time Spent</TD>" + vbCrLf)

        sbHTML.Append("<TD></TD>" + vbCrLf)
        sbHTML.Append("<TD></TD>" + vbCrLf)
        sbHTML.Append("<TD align='right' text-align='right'>")
        sbHTML.Append(FormatNumber(dblTotalSpend, 2))
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>" + vbCrLf)
        sbHTML.Append("</Table>" + vbCrLf)

        CommonFunction.Data.DisposeDataReader(dr)
        '        dr.Dispose()

        Response.Write(sbHTML.ToString)
        sbHTML = Nothing

    End Sub

    Private Sub PlotSLAGrid()

        Dim intCntSLADetails As Integer = 1
        Dim blnRecordPresent As Boolean = False
        Dim strTRstyleSLADetails As String
        Dim drSLADetails As IDataReader
        Dim strQueryID As String = ""
        Dim strDate As String = ""
        Dim m_intQueries As Integer = 0
        Dim m_intTotalRecords As Integer = 0
        Dim strSQL As String = ""

        strSQL = "usp_PM_CalculateSLAForHelpDesk_Query_Details " & m_lngQueryID.ToString
        drSLADetails = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        CommonFunctions.General.WriteHTML("<TABLE CELLSPACING='1' CELLPADDING='0' WIDTH='99.9%' BORDER='0' class='clsGridTable'>")
        CommonFunctions.General.WriteHTML("<THEAD class=clsTRColumnHeader>")

        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>S L A</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Norm</TH>")
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Actual</TH>")
        'Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on Request details page)
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Remaining</TH>")
        'End-Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on Request details page)
        CommonFunctions.General.WriteHTML("<TH ALIGN='center' class='divListTag' WIDTH=10%>Met/ NotMet</TH>")
        CommonFunctions.General.WriteHTML("</THEAD>")
        While drSLADetails.Read()
            m_intTotalRecords = m_intTotalRecords + 1
            blnRecordPresent = True
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("QueryID"), "").ToString <> strQueryID Then
                intCntSLADetails = 1
                m_intQueries = m_intQueries + 1
                strQueryID = CommonFunctions.Data.CheckIsDBNull(drSLADetails("QueryID"), "").ToString()
                'Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on Request details page)
                CommonFunctions.General.WriteHTML("<TR class=clsTRSectionHeader><TD colspan=5  ><b>" & strQueryID & ":-</b>")
                'End-Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on Request details page)
                CommonFunctions.General.WriteHTML(CommonFunctions.Data.CheckIsDBNull(drSLADetails("HelpDeskName"), "").ToString() & "<Br>")
                CommonFunctions.General.WriteHTML("<B> Priority:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Priority"), "").ToString())
                CommonFunctions.General.WriteHTML("<B> Request Type:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RequestType"), "").ToString())
                CommonFunctions.General.WriteHTML("<B> Sub Request Type:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubRequestType"), "").ToString())
                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedDate"), "").ToString() <> "" Then
                    strDate = CommonFunction.Dates.GetDate(CType(CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedDate"), "").ToString(), Date))
                End If

                If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString <> "" Then
                    CommonFunctions.General.WriteHTML("<BR><B> Submitted:-</B>" & strDate & " " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SubmittedTime"), "").ToString)
                Else
                    CommonFunctions.General.WriteHTML("<BR><B> Submitted:-</B>" & strDate)
                End If
                CommonFunctions.General.WriteHTML("<B> Requestor:-</B>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("Requester"), "").ToString() & " </TD></TR>")
            Else
                intCntSLADetails = intCntSLADetails + 1
            End If

            If (intCntSLADetails Mod 2) = 0 Then
                strTRstyleSLADetails = "clsTREvenRow"
            Else
                strTRstyleSLADetails = "clsTROdd"
            End If
            CommonFunctions.General.WriteHTML("<TR class=" & strTRstyleSLADetails & ">")

            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("SLAName"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("SLAName"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("strNorm"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("strNorm"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("strActualDuration"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("strActualDuration"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            'Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on Request details page)
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("RemainingHrsMin"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> <FONT color='red'>" & CommonFunctions.Data.CheckIsDBNull(drSLADetails("RemainingHrsMin"), "").ToString & "</FONT> </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD>")
            End If
            'End - Integrated by vidyak on 07-Jun-2010 for WhizibleSem9 SP1 - HotFix 9.0.048 (Addition of new column "Remaining Hrs" on SLA details page)
            If CommonFunctions.Data.CheckIsDBNull(drSLADetails("MetApplicable"), "").ToString <> "" Then
                CommonFunctions.General.WriteHTML("<TD align='left'   Width=10%> " & CommonFunctions.Data.CheckIsDBNull(drSLADetails("MetApplicable"), "").ToString & " </TD>")
            Else
                CommonFunctions.General.WriteHTML("<TD align='center'   Width=10%>&nbsp;</TD></TR>")
            End If

        End While
        If blnRecordPresent = False Then
            CommonFunctions.General.WriteHTML("<TR class=clsTREvenRow><TD align='center' colspan=11 Width=10%>There are no items to show in this view.</TD></TR>")
        End If
        CommonFunctions.General.WriteHTML("</TABLE>")

        CommonFunctions.Data.DisposeDataReader(drSLADetails)


    End Sub

    Private Sub DrawPageForAR()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To Change UI of Request Detail Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : PradipK
        ' Created               :Feb 06,2007
        ' Revisions             :
        '=====================================================================
        Dim strHTML As System.Text.StringBuilder = New System.Text.StringBuilder

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Display Header - Request ID, Requestor, Requested On
        ' ----------------------------------------------------------------------------------------------------------------------------
        'Addedby ShraddhaM for Performance Check Whizible9.0

        'If m_intShow <> 1 Then
        Dim strHeaderDtls As String
        Dim drDtls As IDataReader
        Dim FlagTo As String
        Dim FlagDateStatus As String
        Dim FlagStatus As String
        Dim FlagImage As String

        strHeaderDtls = "usp_Sel_RequestHeaderDetails " + m_lngQueryID.ToString + "," + Session("intUserID").ToString()

        drDtls = CommonFunction.Data.GetDataReader(strHeaderDtls, MyBase.UseSQL)
        lngRequestID = m_lngQueryID
        While drDtls.Read()
            strRequestor = drDtls("CustomerID").ToString()
            m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("ClientName"), "0"), String)
            'm_strSubmittedDate = CommonFunctions.Dates.GetDate(CType(drDtls("SubmittedDate"), Date)).ToString()
            m_strSubmittedDate = drDtls("SubmittedDate").ToString()

            FlagTo = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagTo"), "2"), String)
            FlagDateStatus = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagDateStatus"), "E"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drDtls)
        'End of addition by ShraddhaM
        'End If

        If FlagTo = "1" Then
            FlagStatus = "Review"

        ElseIf FlagTo = "0" Then
            FlagStatus = "Follow Up"
        Else
            FlagStatus = "Flag To"
        End If

        'Commented And Added By Vaijat K ON 07/12/2015
        'If FlagDateStatus = "L" Then
        '    FlagImage = "../../../responsive/images/RedFlag.gif"
        'ElseIf FlagDateStatus = "G" Then
        '    FlagImage = "../../../responsive/images/GreenFlag.gif"
        'ElseIf FlagDateStatus = "S" Then
        '    FlagImage = "../../../responsive/images/YellowFlag.gif"
        'ElseIf FlagDateStatus = "B" Then
        '    FlagImage = "../../../responsive/images/BlackFlag.gif"
        'Else
        '    FlagImage = "../../../responsive/images/GrayFlag.gif"
        'End If


        If FlagDateStatus = "L" Then
            FlagImage = "../../Images/RedFlag.gif"
        ElseIf FlagDateStatus = "G" Then
            FlagImage = "../../Images/GreenFlag.gif"
        ElseIf FlagDateStatus = "S" Then
            FlagImage = "../../Images/YellowFlag.gif"
        ElseIf FlagDateStatus = "B" Then
            FlagImage = "../../Images/BlackFlag.gif"
        Else
            FlagImage = "../../Images/GrayFlag.gif"
        End If

        strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
        strHTML.Append("<TR  class=clsTRPageCaption>")


        If m_strLoginType = "E" Then
            strHTML.Append("<TD   title='Flag' align=right width='10%'><a href=""javascript:Flag_OnClick(" + m_lngQueryID.ToString + " )""><IMG Border=0  SRC='" + FlagImage + "'  title='" + FlagStatus + "' onclick="""" ></a></TD>")
        End If

        strHTML.Append("<TD width='15%' align=center> <B>Request ID<BR> <Font size=4>" + lngRequestID.ToString + "</Font></B></td>")
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtShowTab", "txtShowTab", , , , m_intShow.ToString(), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:05/10/15
        strHTML.Append("<TD width='75%'> Requestor : ")
        If m_RequeststrLoginType.ToUpper = "C" Then
            If m_strClienName = "0" Then
                strHTML.Append(strRequestor.ToString)
            Else
                If m_strClienName <> "" Then
                    strHTML.Append(strRequestor.ToString + " | " + m_strClienName)
                End If
            End If
        Else
            strHTML.Append(strRequestor.ToString)
        End If
        strHTML.Append(" | Requested on: " + m_strSubmittedDate)
        strHTML.Append("</TD>")
        strHTML.Append("</TR>")
        strHTML.Append("</TABLE>")
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Header
        ' ----------------------------------------------------------------------------------------------------------------------------



        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------
        Dim txtResult As New System.Text.StringBuilder
        Dim intSelectedTabValue As Integer
        intSelectedTabValue = m_intShow

        With txtResult

            .Append("<TABLE BORDER=0 cellpadding=0 cellspacing=0 width='99.9%' class='clsTable'><TR class=clsTRSectionHeader valign=middle>") '+ vbCrLf

            .Append("<TD nowrap class='mainTabsSectionEasyMenu'>")

            If intSelectedTabValue = TAB_REQUEST_DETAILS Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If intSelectedTabValue = TAB_ATTACHMENT Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If intSelectedTabValue = TAB_DISCUSSION_THREAD Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Discussion Thread'+ href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Discussion Thread' href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If

            If m_blnSLAAccess = True Then
                If intSelectedTabValue = TAB_SLA Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='SLA'+ href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='SLA' href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If
            End If

            If intSelectedTabValue = TAB_ACTIVITY_LOG Then
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='ActivityLog'+ href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            Else
                .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='ActivityLog' href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
            End If


            .Append("</TD>")

            .Append("</TR></TABLE>")
        End With

        strHTML.Append(txtResult.ToString)
        txtResult = Nothing
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------



        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw details depending on selectd tab
        ' ----------------------------------------------------------------------------------------------------------------------------
        Select Case intSelectedTabValue
            Case TAB_REQUEST_DETAILS

                ' Menu specific to selected tab
                strHTML.Append(strMenu)
                'page legend
                strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
                strHTML.Append(strLegend)

                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)

                '********************* FIRST ROW *******************************************************************************************
                ' Deaprtment
                strHTML.Append("<tr class=clsTREven>")
                strHTML.Append("<td  align=right width=5%>" & m_strFunction_Caption & "</td>")
                strHTML.Append("<td width=15%>")

                Dim strSQLRole As String
                Dim drRole As IDataReader
                Dim lngPostID As Long = 0
                ' Take Role of the employee at corporate level and not from session

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
                drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If drRole.Read Then
                    lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(drRole)

                If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then ' Post ID 23 is for customer
                    ' If logged in person is customer then populate only those department which are exposed to customer
                    strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
                    strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
                ElseIf m_intRequestedEmployee <> 0 Then  ' If request is being posted on behalf of the customer then
                    ' Populate all the departments accessible logged in person
                    strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
                Else ' If request is by logged in employee
                    ' Populate all the departments accessible logged in person
                    strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
                End If


                If blnDisableFunctionCombo Then
                    If m_strLoginType <> "C" Then
                        If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                            strSQL += "," + lngRequestID.ToString
                        End If
                    End If
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, " disabled ", True, True, , True))
                Else
                    If m_strLoginType <> "E" Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                    Else
                        If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        Else

                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, "onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        End If

                    End If

                End If
                strHTML.Append("</td>")

                ' Request Type and Sub Request Type
                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right width=6% > Request Type </td>")
                    strHTML.Append("<td  align=right width=6% > " & m_strRequestType_Caption & " </td>")
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908
                    strHTML.Append("<td width=15%>")

                    ' Get request type and sub request type mapped to department and accessible to logged in person
                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        ' For custromer role
                        strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
                        strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
                        strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
                        strSQL += "  and RoleID =23 AND functionID = " & lngFunctionID
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                        Else
                            strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                        End If
                    End If

                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                    strHTML.Append("</td>")
                    strHTML.Append("<td  align=right width=8%> " & m_strSubRequestType_Caption & " </td>")
                    strHTML.Append("<td width=15%>")


                    ' Sub Request Type
                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        strSQL = " select tbl_CRM_RequestType_SubRequestType.SubRequestTypeID ,tbl_CRM_SubRequestType.SubRequestType "
                        strSQL += " from  tbl_CRM_RequestType_SubRequestType, tbl_CRM_SubRequestType  where "
                        strSQL += " tbl_CRM_RequestType_SubRequestType.subRequestTypeID = tbl_CRM_SubRequestType.SubRequestTypeID "
                        strSQL += " and tbl_CRM_RequestType_SubRequestType.RequestTypeID = " & m_lngRequestTypeId.ToString
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
                        Else
                            strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
                        End If
                    End If
                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                Else
                    'Sub Requst Type
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right > Request Type </td>")
                    strHTML.Append("<td  align=right > " & m_strRequestType_Caption & " </td>")
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908
                    strHTML.Append("<td colspan=3>")
                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",null,'C',0"
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                        Else
                            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                        End If

                    End If

                    If Not Page.IsPostBack Then
                        If CommonFunction.Application.SplitRequestTypeSubType = False Then
                            strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
                        End If

                    End If

                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                End If

                'Template
                If m_lngSubRequestTypeID <> 0 Then
                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
                    strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
                    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    If dr.Read Then
                        intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                        Select Case intTemplateCount
                            Case 0 ' no templates
                                ' Commented by MonikaI on 14th Jul 2009 
                                ' RequestID 21655 Not able to download template attached with sub type if File server is different.
                                'Case 1 ' only one template
                                '    strHTML.Append("<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateID"), "0"), Long)) & "' >" & vbCrLf)
                                '    strHTML.Append("<Image Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'>")
                                '    strHTML.Append("</A>")
                                ' End of modification by MonikaI on 14th Jul 2009
                            Case Else ' multiple templates
                                'Commented And Added By Vaijat K ON 07/12/2015
                                'strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'></A>")
                                ''commented and Added by nilesh g  on 1-mar-2016 to validate Token
                                '' strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                                strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                        End Select
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If
                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                Else
                    'Sub Request Type not Ploted..
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************

                ' Guidelines
                If Trim(m_lngSubRequestTypeID & "") <> "" Then
                    dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Guidelines " & m_lngSubRequestTypeID, m_blnUseSQL)
                    If dr.Read Then
                        If Trim(dr(strGuidelinesColumnName).ToString & "") <> "" Then
                            strHTML.Append("<TR class=clsTREven><td  align=right VAlign=Top>")
                            strHTML.Append(GetCaption(919, strGuidelinesColumnName))
                            strHTML.Append("</td>")
                            ''Commented by Yogesh J on 22-Jan-2016
                            'strHTML.Append("<td  VAlign=Top colspan=5 ><PRE>")
                            'strHTML.Append(dr(strGuidelinesColumnName).ToString & "</PRE>")
                            strHTML.Append("<td  VAlign=Top colspan=5 ><P>")
                            strHTML.Append(dr(strGuidelinesColumnName).ToString & "</P>")
                            ''End of Comment by Yogesh J on 22-Jan-2016

                            strHTML.Append("</td></tr>")
                        End If
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)
                End If


                ' subject
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strSubject_Caption & "</TD>")
                strHTML.Append("<TD colspan=5>")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , intWidth, intPixelSize, strSubject, , , blnDisbaledSubjectTextBox, , , , , True, True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")

                strHTML.Append("</TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************

                ' Description
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right vAlign=top>" & m_strDescription_Caption & "</TD>")
                strHTML.Append("<TD colspan=5> ")
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                strHTML.Append("</TD></TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************

                ''Product & Component
                ' Display product drop down only if product execution is embled at corporate level
                If CommonFunction.Application.EnableProductExecution = True Then
                    ' Check whether deaprtment support product execution

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
                    dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If dr.Read Then
                        ShowProductCombo = "1"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)

                End If

                'Added by SuchitraP on 2nd April 2009 for IssueID : 29820
                'Purpose: to handle single quote present in Requestor name
                strRequestor = Replace(strRequestor, "'", "''")
                'End of addition by SuchitraP on 2nd April

                If ShowProductCombo = "1" Then
                    strHTML.Append("<tr class=clsTREven><td colspan=6><HR></td></tr>")
                    strHTML.Append("<tr class=clsTREven>")
                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Product" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strProduct_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908

                    strHTML.Append("<td colspan=2>")

                    If (m_RequeststrLoginType = "E") Then
                        ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)

                        ''''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "SELECT ProductVersionID,Product + '-' + ProductVersion as Product FROM Tbl_PRD_ProductVersion A INNER JOIN tbl_PRD_Product B ON A.ProductID = B.ProductID order by Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    Else
                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''dr = CommonFunction.Data.GetDataReader("SELECT Customer  FROM tbl_PM_Customer WHERE CustomerID='" & strRequestor & "'", m_blnUseSQL)
                        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        If dr.Read Then
                            strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                        Else
                            strRequestorID = "0"
                        End If
                        CommonFunction.Data.DisposeDataReader(dr)
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                    End If
                    strHTML.Append("</td>")

                    ' Module Component Drop down
                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Module/Component" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strModuleComponent_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908
                    strHTML.Append("<td  colspan='2'>")

                    If (m_RequeststrLoginType = "E") Then
                        ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                        'Modified by SonalD on 11th March for IssueID 28765
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString + " ORDER BY Component", 250, lngComponentID.ToString, , True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        'End of modification by SonalD on 11th March 2009
                    Else
                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''dr = CommonFunction.Data.GetDataReader("SELECT Customer  FROM tbl_PM_Customer WHERE CustomerID='" & strRequestor & "'", m_blnUseSQL)
                        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        If dr.Read Then
                            strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                        Else
                            strRequestorID = "0"
                        End If
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))

                        CommonFunction.Data.DisposeDataReader(dr)
                    End If
                    strHTML.Append("</td></tr>")
                    strHTML.Append("<tr  class=clsTREven><td colspan=6><HR></td></tr>")

                    ' Product and Module/Component value does not persist when ExposeTo Product Execution flag of related Dept. becomes off
                Else 'If (m_intCustomer <> 0 And m_strLoginType = "E") Or m_strLoginType = "C" Or m_RequeststrLoginType.ToUpper = "C" Then
                    strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=" + lngProductID.ToString + ">")
                    strHTML.Append("<INPUT type=hidden name='cboModule' id='cboModule' value=" + lngComponentID.ToString + ">")
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' priority
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strPriority_Caption & "</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_RequestPriority"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, , True, True, , True))
                strHTML.Append("</TD>")

                ' Severity
                strHTML.Append("<td align=right>" & m_strSeverity_Caption & "</TD>")
                strHTML.Append("<TD colspan=3>")
                strSQL = "usp_CRM_Get_RequestSeverity"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, , True, True))
                strHTML.Append("</TD>")

                strHTML.Append("</tr>")

                '****************************** CHANGE OF ROW ********************************************************************************************

                ' Hidden Server dates


                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                ' Status
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right >" & m_strStatus_Caption & "</TD>")
                strHTML.Append("<TD >")

                'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0
                '' Modified by GaneshD on 05 Oct 2009 for showing only those statuses which are configured.
                '' strSQL = "usp_CRM_Get_RequestStatus"
                'strSQL = "usp_CRM_Get_RequestStatus " + lngRequestID.ToString + "," + m_lngSubRequestTypeID.ToString
                ''End of modification by GaneshD 

                Dim RoleId As String = Session("intPostId")
                strSQL = "usp_CRM_Get_RequestStatus " + lngRequestID.ToString + "," + RoleId

                'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0

                If blnDisableStatusCombo Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, , " disabled ", , True, , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , True, , True))
                    ' Added by GaneshD on 09 Jun 2009 For HelpDesk StatusFlow Configuration
                    m_StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(lngRequestID, String) + "", MyBase.UseSQL), "0"), Integer)
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    Dim strOldStatus As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(intStatusID, String), MyBase.UseSQL), "0"), String)
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True
                    Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "'," + "1", DisplayNone:=True)) ', displaynone:=True
                    ' Addition End by GaneshD 
                End If
                'Commented by ShraddhaM on 17,Sep 2009 to remove reject Link
                'If intStatusID = 7 Then
                '    strHTML.Append("<b><a href='javascript:ViewRejectionComments_OnClick()'>View Comments</a><b>")
                'End If
                'Ended by ShraddhaM on 17,Sep 2009 to remove reject Link
                'Added by ShraddhaM to display changehistory of status on 17,Sep 2009
                strHTML.Append("<b><a href='javascript:ChangeHistory_OnClick()'>Status History</a><b>")
                'Call PlotFeedbackDiv()
                CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()
                'Ended by ShraddhaM
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")

                Dim h As Integer
                Dim m As Integer
                Dim strHour As String
                Dim strMinute As String

                'Get Server Date & Time
                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

                h = CType(Left(strGetServerTime1, 2), Integer)
                m = CType(Right(strGetServerTime1, 2), Integer)

                'Hours formatting for two digits .. so for 8 hours it will format as 08 hours
                If h < 10 Then
                    strHour = "0" + h.ToString
                Else
                    strHour = h.ToString
                End If
                ' Minutes formatting for two digits .. so for 3 minutes it will format as 03 minutes
                If m < 10 Then
                    strMinute = "0" + m.ToString
                Else
                    strMinute = m.ToString
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilterState", "txtHiddenFilterState", , 400, 100, m_FilterData.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilter", "txtHiddenFilter", , 400, 100, m_Filter.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenDepartment", "txtHiddenDepartment", , 400, 100, m_Department.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenStatus", "txtHiddenStatus", , 400, 100, m_Status.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                If m_strLoginType = "E" Then
                    strHTML.Append("<td align=right >" & m_strStatusChangeDate & "</TD>")
                Else
                    strHTML.Append("<td align=right > </TD>")
                End If

                strHTML.Append("<TD >")

                'Hidden date control contains DateValue of particular status from database
                strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True, ))

                'control contains DateValue of particular status from database
                If m_strLoginType = "C" Then
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtReadOnlychangedDate", "txtReadOnlychangedDate", , 80, , CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(m_strStatusChangeDateValue), , , , True, , True, , True, False, , , EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True))
                Else
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, True, , , ))
                End If
                'strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , m_strStatusChangeTimeValue, , , , , , True, , True, , , , , , True, "Soft", ))
                strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , m_strStatusChangeTimeValue, , , , , , True, , True, , , , , , True, "Soft", EnableHTMLEncode:=True))
                strHTML.Append("</TD>")

                If m_strLoginType = "E" Then
                    strHTML.Append("<td align=right >" & m_strStatusChangeTime & "</TD>")
                Else
                    strHTML.Append("<td align=right > </TD>")
                End If

                strHTML.Append("<TD >")

                If m_strLoginType = "C" Then
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , True, , True, , True, False, , , EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , , , , , True, True, , , EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                End If
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                'CurrentDate field will hold date of server ,not  of client
                strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmRequestDetails", , , , , , , True, False, , , True))
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strCurrentHours + ":" + strCurrentTime, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                '****************************** CHANGE OF ROW ********************************************************************************************

                ' CRM Comments
                If (m_strLoginType <> "C") Then
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right vAlign=top>" & m_strComments_Caption & "</TD>")
                    strHTML.Append("<TD colspan=5>")
                End If

                If (m_strLoginType = "C") Then
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , , blnReadOnlyComments, , , , True, , , , , , True, "Soft", ))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , , blnReadOnlyComments, , , , True, , , , , , True, "Soft", , EnableHTMLEncode:=True))
                Else
                    'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , True, , , , , , , "Soft", ))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
                End If

                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", , EnableHTMLEncode:=True))
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************

                ' Assign TO
                If (m_strLoginType <> "C") Then

                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right>" & m_strAssignTo_Caption & "</TD>")
                    strHTML.Append("<TD>")
                End If

                strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString

                If blnDisabledAssignToCombo Then  ' Assign To link is disabled when person is not HRM or department head
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , , , strAssignTo, IsDisabled:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")

                    'To Add Exp.Resolution Date 
                    strHTML.Append("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
                    strHTML.Append("<TD>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , True, True, , True, False))
                    strHTML.Append("</TD>")
                    'Mail of Exp.resolution date changed fires when user clicks on Save link
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("<TD></TD><TD></TD><TD></TD><TD></TD>")
                Else ' If logged in person is HRM or department head then enable assign to drop down
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strSQL, intComboSize, lngAssignTo.ToString, , True, True))
                    strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtSubmittedDate", "txtSubmittedDate", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")

                    If UCase(Trim(m_strMode & "")) = "EDIT" Then
                        If m_strLoginType <> "C" Then
                            strHTML.Append("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
                            strHTML.Append("<TD>")

                            If UCase(Trim(m_strFromWhere & "")) = "AR" Then
                                strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , True, , True, False))
                                strHTML.Append("</TD>")
                            Else
                                strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , True, False))
                                strHTML.Append("</TD>")
                            End If

                        Else
                            strHTML.Append("<TD></TD><TD></TD>")
                        End If
                    End If

                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))

                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))

                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    ' Exp. resolution date

                    If (m_strLoginType <> "C") Then

                        strHTML.Append("<TD align=right>" & m_strCRMExpectedResolvedDate_Caption & "</TD>")
                        strHTML.Append("<TD>")
                    End If

                    strHTML.Append("</TD><TD></TD><TD></TD></tr>")
                    strHTML.Append("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************

                'Hidden CRMResolutionDate
                'CRM Exp resolution field gets cleared when submitter of the request saves it
                strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", returnHTML:=True, DisplayNone:=True))

                ' Target Location
                If (m_strLoginType <> "C") Then
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
                    strHTML.Append("<TD>")
                    'Inactive OU should not be displayed in Organisation Unit combo
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, , True, True, , True))
                    strHTML.Append("</TD>")
                End If

                ' Deliverable
                strHTML.Append("<TD align=right >Deliverable</td>")
                strHTML.Append("<TD>")

                Dim strDeliverableName As String = ""
                Dim drGetDeliverable As IDataReader

                If m_strDeliverableID <> "" Then
                    'Commented and added by ShraddhaM to display Deliverable Project Name
                    'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
                    strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drGetDeliverable.Read Then
                        strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                        m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                        strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
                    End If

                    CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , 200, 100, strDeliverableName.ToString, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")
                strHTML.Append("<TD align=right >Project Name</td><TD>")
                'Added by ShraddhaM to display project name on 16 Sep 2009
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", , 100, 100, m_strDelProjectID, , , False, , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", , , , strDelProjectName, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                'Ended by ShraddhaM
                strHTML.Append("</TD></TR>")

                If intStatusID <> 2 Then
                    strStyle = " style='display:none' "
                End If

                Dim strIsFeedbackdisabled As String = ""
                If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
                    strIsFeedbackdisabled = " disabled "
                Else
                    strIsFeedbackdisabled = ""
                End If

                ' feeb back (submitted mode)
                strHTML.Append("<TR id=TRFeedback class=clsTREven " & strStyle & ">")
                strHTML.Append("<TD align=right>Feedback</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_Feedback_ForCombo"
                ''Commented And Added By Vaijat K ON 10/10/2016
                ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, " disabled", , True, , True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, strIsFeedbackdisabled, , True, , True))
                ''End of addition by Vaijat k
                strHTML.Append("</TD>")

                strHTML.Append("<TD></TD><TD></TD><TD></TD><TD></TD>")
                strHTML.Append("</TR>")

                strHTML.Append("<TR id=TRFeedbackComments class=clsTREven  " & strStyle & " >")
                strHTML.Append("<TD align=right vAlign=top>Feedback Comments </TD>")
                strHTML.Append("<TD colspan=5>")
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , True, True, , , , True, True, , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , True, True, , , , True, True, , , , , , "Soft", , EnableHTMLEncode:=True))
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                'To persists Paging Number on List PAge after saving request in edit mode
                Dim strPageNumber As String
                strPageNumber = Request.QueryString("PageNumber")
                If strPageNumber Is Nothing OrElse strPageNumber = "" Then
                    strPageNumber = Request.Form("hidPageNumber")
                End If

                strHTML.Append("<INPUT type=hidden name='hidPageNumber' id='hidPageNumber' value=" + strPageNumber + ">")

                strHTML.Append("</Table>")
                Response.Write(strHTML.ToString)

                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To Plot Custom Fields
                PlotCustomFields()
                'End Addition

            Case TAB_ATTACHMENT

                strHTML.Append(strMenu)
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                ' attachments grid
                'strHTML.Append(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ATTACHMENTS"), , , True))
                Response.Write(strHTML.ToString)
                PlotAttachmentsGrid()
                Response.Write("</TABLE>")

            Case TAB_DISCUSSION_THREAD
                strHTML.Append(strMenu)
                'ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                ' Page legend
                If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
                    Dim arrLegendDiscussion() As String = {"Discussion thread in blue color indicates thread shown to customer"}
                    arrLegendImage.SetValue("", 0)
                    strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegendDiscussion, True)
                    strHTML.Append(strLegend)
                End If
                'END ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                Dim arrIgnoreHTMLEncode() As String = {"0"}
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strSQL = "usp_CRM_Discussions " & m_lngQueryID
                m_objGrid = New WebPages.Template.GenericGrid

                'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread", ""}
                Dim arrUserFriendlyCols() As String = {"Submitted By", "Submitted Date", "Comment", "Select"}
                Dim arrCheckBox() As String = {"", "", "", "chkDiscussionThread"}
                'end Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS

                With m_objGrid
                    .NoOfDataColumns = 3
                    'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    .PrimaryKey = "CRMQueryDetailid"
                    .CheckBoxIDArray = arrCheckBox
                    'END Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    .UserFriendlyColumnArray = arrUserFriendlyCols
                    .ActualColumnArray = arrActualCols
                    .returnHTML = False
                    .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                    .SQL = strSQL
                    .UseSQL = m_blnUseSQL
                    .PrinterFriendlyVersion = True
                    .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                    .DrawGrid()
                End With
                m_objGrid = Nothing

                Response.Write("</TABLE>")

            Case TAB_SLA
                strHTML.Append(strMenu)
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)
                PlotSLAGrid()

            Case TAB_ACTIVITY_LOG
                strHTML.Append(strMenu)
                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Response.Write(strHTML.ToString)
                PlotActivityLogGrid()

        End Select

        Response.Write("</div>")

        Response.Write("<BR>")
        Response.Write(strMenu)



    End Sub
    Private Sub DrawPageForMDB()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To Change UI of Request Detail Page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : PrashantD
        ' Created               : May 23,2007
        ' Revisions             :
        '=====================================================================
        Dim strHTML As System.Text.StringBuilder = New System.Text.StringBuilder

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Display Header - Request ID, Requestor, Requested On
        ' ----------------------------------------------------------------------------------------------------------------------------

        'Addedby ShraddhaM for Performance Check Whizible9.0

        ' If m_intShow <> 1 Then
        Dim strHeaderDtls As String
        Dim drDtls As IDataReader
        Dim FlagTo As String
        Dim FlagDateStatus As String
        Dim FlagStatus As String
        Dim FlagImage As String

        strHeaderDtls = "usp_Sel_RequestHeaderDetails " + m_lngQueryID.ToString + "," + Session("intUserID").ToString()

        drDtls = CommonFunction.Data.GetDataReader(strHeaderDtls, MyBase.UseSQL)
        lngRequestID = m_lngQueryID
        While drDtls.Read()
            strRequestor = drDtls("CustomerID").ToString()
            m_strClienName = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("ClientName"), "0"), String)
            'm_strSubmittedDate = CommonFunctions.Dates.GetDate(CType(drDtls("SubmittedDate"), Date)).ToString()
            m_strSubmittedDate = drDtls("SubmittedDate").ToString()
            FlagTo = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagTo"), "2"), String)
            FlagDateStatus = CType(CommonFunctions.Data.CheckIsDBNull(drDtls("FlagDateStatus"), "E"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drDtls)
        'End of addition by ShraddhaM
        ' End If

        If FlagTo = "1" Then
            FlagStatus = "Review"

        ElseIf FlagTo = "0" Then
            FlagStatus = "Follow Up"
        Else
            FlagStatus = "Flag To"
        End If

        'Commented And Added By Vaijat K ON 07/12/2015
        'If FlagDateStatus = "L" Then
        '    FlagImage = "../../../responsive/images/RedFlag.gif"
        'ElseIf FlagDateStatus = "G" Then
        '    FlagImage = "../../../responsive/images/GreenFlag.gif"
        'ElseIf FlagDateStatus = "S" Then
        '    FlagImage = "../../../responsive/images/YellowFlag.gif"
        'ElseIf FlagDateStatus = "B" Then
        '    FlagImage = "../../../responsive/images/BlackFlag.gif"
        'Else
        '    FlagImage = "../../../responsive/images/GrayFlag.gif"
        'End If


        If FlagDateStatus = "L" Then
            FlagImage = "../../Images/RedFlag.gif"
        ElseIf FlagDateStatus = "G" Then
            FlagImage = "../../Images/GreenFlag.gif"
        ElseIf FlagDateStatus = "S" Then
            FlagImage = "../../Images/YellowFlag.gif"
        ElseIf FlagDateStatus = "B" Then
            FlagImage = "../../Images/BlackFlag.gif"
        Else
            FlagImage = "../../Images/GrayFlag.gif"
        End If

        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            strHTML.Append("<TR  class=clsTRPageCaption>")

            If m_strLoginType = "E" Then
                strHTML.Append("<TD title='Flag' align=right width='10%'><a href=""javascript:Flag_OnClick(" + m_lngQueryID.ToString + " )""><IMG Border=0  SRC='" + FlagImage + "'  title='" + FlagStatus + "' onclick="""" ></a></TD>")
            End If

            strHTML.Append("<TD width='15%' align=center> <B>Request ID<BR> <Font size=4>" + lngRequestID.ToString + "</Font></B></td>")
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , True, , , , True, EnableHTMLEncode:=True))
            strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtShowTab", "txtShowTab", , , , m_intShow.ToString(), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
            'ended by Yogesh J for HTML encoding Date:05/10/15
            strHTML.Append("<TD width='65%'> Requestor : ")
            If m_RequeststrLoginType.ToUpper = "C" Then
                If m_strClienName = "0" Then
                    strHTML.Append(strRequestor.ToString)
                Else
                    If m_strClienName <> "" Then
                        strHTML.Append(strRequestor.ToString + " | " + m_strClienName)
                    End If
                End If
            Else
                strHTML.Append(strRequestor.ToString)
            End If

            strHTML.Append(" | Requested on: " + m_strSubmittedDate)
            strHTML.Append("</TD>")

            ' Icon to move request to another department
            ' 
            strHTML.Append("<TD width='10%'>")
            Dim drIsTaskCreated As IDataReader
            'Dim drAssignTo As IDataReader
            Dim strSQLIsTaskCreated As String

            ' To check whether task or issue is created for the current request
            strSQLIsTaskCreated = "usp_Sel_CRM_IsTaskIssueDeliverableAssignToForRequest " + lngRequestID.ToString

            ' Variable intIsTask_IssueCreated is used in ASPX page
            ' If Issue or task is created againt the request then alert is given on 'Move To Another Department' link as
            ' It is not possible to move the request since task or issue is created for theis request
            drIsTaskCreated = CommonFunctions.Data.GetDataReader(strSQLIsTaskCreated, m_blnUseSQL)
            Dim strIsTaskCreated As String
            If drIsTaskCreated.Read Then
                strIsTaskCreated = CommonFunctions.Data.CheckIsDBNull(drIsTaskCreated("TaskID"), "0").ToString
            End If
            If Not strIsTaskCreated Is Nothing Then
                If strIsTaskCreated = "0" Or strIsTaskCreated = "" Then
                    intIsTask_IssueCreated = 0
                Else
                    intIsTask_IssueCreated = 1
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drIsTaskCreated)

            If blnViewAccessOrHRM = 1 Then
                'Commented And Added By Vaijat K ON 07/12/2015
                'strHTML.Append("<A href='JavaScript:MoveToDept_OnClick()'><Image Border=0  src='../../responsive/images/MoveImg.gif'   id ='view' title = 'Move this request to another Department'  > </A>")
                strHTML.Append("<A href='JavaScript:MoveToDept_OnClick()'><Image Border=0  src='../../Images/MoveImg.gif'   id ='view' title = 'Move this request to another Department'  > </A>")
            End If

            strHTML.Append("</TD>")
            strHTML.Append("</TR></TABLE>")
        End If
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Header
        ' ----------------------------------------------------------------------------------------------------------------------------

        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------
        Dim txtResult As New System.Text.StringBuilder
        Dim intSelectedTabValue As Integer
        intSelectedTabValue = m_intShow

        If UCase(Trim(m_strMode & "")) = "EDIT" Then
            'Added by Anju on 29 April 09
            'Draw Tabs
            With txtResult
                .Append("<TABLE BORDER=0 cellpadding=0 cellspacing=0 width='99.9%' class='clsTable'><TR class=clsTRSectionHeader valign=middle>") '+ vbCrLf

                .Append("<TD nowrap class='mainTabsSectionEasyMenu'>")

                If intSelectedTabValue = TAB_REQUEST_DETAILS Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Request Details' href='javascript:RequestTab_OnClick(" + TAB_REQUEST_DETAILS.ToString + ")'>" + "Request Details</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If

                If intSelectedTabValue = TAB_ATTACHMENT Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Attachments' href='javascript:RequestTab_OnClick(" + TAB_ATTACHMENT.ToString + ")'>" + "Attachments</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If

                If intSelectedTabValue = TAB_DISCUSSION_THREAD Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='Discussion Thread'+ href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='Discussion Thread' href='javascript:RequestTab_OnClick(" + TAB_DISCUSSION_THREAD.ToString + ")'>" + "Discussion Thread</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If

                If m_blnSLAAccess = True Then
                    If intSelectedTabValue = TAB_SLA Then
                        .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='SLA'+ href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    Else
                        .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='SLA' href='javascript:RequestTab_OnClick(" + TAB_SLA.ToString + ")'>" + "S L A</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                    End If
                End If

                If intSelectedTabValue = TAB_ACTIVITY_LOG Then
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class='selectedTab'  Title='ActivityLog'+ href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                Else
                    .Append("&nbsp;&nbsp;&nbsp;&nbsp;<a class=''  Title='ActivityLog' href='javascript:RequestTab_OnClick(" + TAB_ACTIVITY_LOG.ToString + ")'>" + "Activity Log</a>&nbsp;&nbsp;&nbsp;&nbsp;")
                End If
                .Append("</TD>")
                .Append("</TR></TABLE>")
            End With

            strHTML.Append(txtResult.ToString)

            txtResult = Nothing
            'End of modification by Anju on 29 April 09
        End If
        ' ----------------------------------------------------------------------------------------------------------------------------
        ' End of Draw Tabs
        ' ----------------------------------------------------------------------------------------------------------------------------


        ' ----------------------------------------------------------------------------------------------------------------------------
        ' Draw details depending on selectd tab
        ' ----------------------------------------------------------------------------------------------------------------------------
        Select Case intSelectedTabValue
            Case TAB_REQUEST_DETAILS
                ' menu
                strHTML.Append(strMenu)
                'page legend
                strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend, True)
                strHTML.Append(strLegend)

                strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)

                '********************* FIRST ROW *******************************************************************************************
                ' function/Department
                strHTML.Append("<tr class=clsTREven>")
                strHTML.Append("<td  align=right width=5%>" & m_strFunction_Caption & "</td>")
                strHTML.Append("<td width=15%>")

                Dim strSQLRole As String
                Dim drRole As IDataReader
                Dim lngPostID As Long = 0
                ' to take postid of the employee at corporate level not from session

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'drRole = CommonFunctions.Data.GetDataReader("SELECT PostID FROM tbl_PM_Employee Where EmployeeID = " & m_lngEmployeeID.ToString, m_blnUseSQL)
                drRole = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_Employee_EmployeeIDwise_PostID " & m_lngEmployeeID.ToString, m_blnUseSQL)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If drRole.Read Then
                    lngPostID = CType(CommonFunctions.Data.CheckIsDBNull(drRole("Postid"), "0"), Long)
                End If
                CommonFunctions.Data.DisposeDataReader(drRole)
                If (m_intCustomer <> 0) Or (Session("intPostID").ToString = "23") Then
                    strSQL = "SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster where ExposeToCustomer =1"
                    strSQL += "  UNION SELECT DepartmentID , Department FROM tbl_PM_DepartmentMaster WHERE DepartmentID = " & lngFunctionID.ToString
                ElseIf m_intRequestedEmployee <> 0 Then
                    strSQL = "usp_CRM_GetFunctions_ForRole " & m_intRequestedEmployeePost.ToString
                Else
                    strSQL = "usp_CRM_GetFunctions_ForRole " & lngPostID.ToString
                End If

                If blnDisableFunctionCombo Then
                    If m_strLoginType <> "C" Then
                        If CType(HttpContext.Current.Session("Customer"), Long) = 0 Then
                            strSQL += "," + lngRequestID.ToString
                        End If
                    End If
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, " disabled ", True, True, , True))
                Else
                    If m_strLoginType <> "E" Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                    Else
                        If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", "usp_Sel_tbl_PM_DepartmentMaster_ForCustomer", intComboSize, lngFunctionID.ToString, "Onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        Else
                            strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFunction", strSQL, intComboSize, lngFunctionID.ToString, "onchange=javascript:cboFunction_OnChange()", True, True, , True))
                        End If
                    End If
                End If
                strHTML.Append("</td>")

                strSQL = "Exec usp_Sel_tbl_pm_Employee_HRMs " & m_lngEmployeeID & "," & lngFunctionID.ToString
                dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                If dr.Read Then
                    m_lngCRMID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), "0"), Long)
                End If
                CommonFunction.Data.DisposeDataReader(dr)
                If m_lngCRMID <> 0 Then
                    blnDisableSubRequestTypeCombo = False 'To enable Request and Sub Request Type Combo
                    If CommonFunction.Application.SplitRequestTypeSubType = True Then
                        'To select matchfield for RequestType combo when SplitRequestTypeSubType is true
                        If Trim(MyBase.GetFormValue("cboRequestType") & "") <> "" Then
                            m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboRequestType") & ""), Long)
                        End If
                        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
                        If Trim(strSubrequestType & "") <> "" Then
                            arr = Split(strSubrequestType, "|")
                            If Trim(arr(0) & "") <> "" Then
                                m_lngSubRequestTypeID = CType(arr(0), Long)
                            End If
                        End If
                    Else
                        strSubrequestType = Trim(MyBase.GetFormValue("cboSubRequestType") & "")
                        arr = Split(strSubrequestType, "|")
                        If Trim(arr(0) & "") <> "" Then
                            m_lngSubRequestTypeID = CType(arr(0), Long)
                        End If

                        If Trim(strSubrequestType & "") = "" Then
                            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestDetails " & m_lngQueryID, m_blnUseSQL)
                            If dr.Read Then
                                strSubrequestType = CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0").ToString & "|" & CommonFunctions.Data.CheckIsDBNull(dr("RequestTypeID"), "0").ToString
                            End If
                            CommonFunction.Data.DisposeDataReader(dr)
                        End If
                    End If

                    ' Disable AssignTo Link when status is closed
                    If intRequestStatus = 2 Then
                        blnDisabledAssignToCombo = True
                    End If
                Else
                    blnDisabledAssignToCombo = True
                End If

                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right width=6% > Request Type </td>")
                    strHTML.Append("<td  align=right width=6% > " & m_strRequestType_Caption & " </td>")
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908
                    strHTML.Append("<td width=15%>")

                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        strSQL = "select tbl_CRM_Function_Roles.RequestTypeID ,tbl_CRM_RequestType.RequestType from "
                        strSQL += " tbl_CRM_Function_Roles, tbl_CRM_RequestType "
                        strSQL += " where tbl_CRM_Function_Roles.RequestTypeID = tbl_CRM_RequestType.RequestTypeID"
                        strSQL += "  and RoleID =23 AND functionID = " & lngFunctionID
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                        Else
                            strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & lngRequestTypeIdOld.ToString
                        End If
                    End If


                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, intComboSize, m_lngRequestTypeId.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If

                    strHTML.Append("</td>")
                    strHTML.Append("<td  align=right width=8%> " & m_strSubRequestType_Caption & " </td>")
                    strHTML.Append("<td width=15%>")

                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        strSQL = " select tbl_CRM_RequestType_SubRequestType.SubRequestTypeID ,tbl_CRM_SubRequestType.SubRequestType "
                        strSQL += " from  tbl_CRM_RequestType_SubRequestType, tbl_CRM_SubRequestType  where "
                        strSQL += " tbl_CRM_RequestType_SubRequestType.subRequestTypeID = tbl_CRM_SubRequestType.SubRequestTypeID "
                        strSQL += " and tbl_CRM_RequestType_SubRequestType.RequestTypeID = " & m_lngRequestTypeId.ToString
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
                        Else
                            strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & m_lngRequestTypeId.ToString & "," & m_lngSubRequestTypeID.ToString
                        End If
                    End If
                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, m_lngSubRequestTypeID.ToString, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                Else
                    'Sub Requst Type
                    'Added by GokulP on 13 May 2010 for IssueID : 23908
                    'strHTML.Append("<td  align=right > Request Type </td>")
                    strHTML.Append("<td  align=right > " & m_strRequestType_Caption & " </td>")
                    'End of Addition by GokulP on 13 May 2010 for IssueID : 23908

                    strHTML.Append("<td colspan=3>")
                    If CType(HttpContext.Current.Session("Customer"), Long) <> 0 Then
                        strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",null,'C',0"
                    Else
                        If m_intRequestedEmployee <> 0 Then
                            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strRequestedEmployeeUN) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                        Else
                            strSQL = "usp_CRM_RequestTypes_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0 ," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString) & "," & m_lngSubRequestTypeID.ToString
                        End If
                    End If

                    If Not Page.IsPostBack Then
                        If CommonFunction.Application.SplitRequestTypeSubType = False Then
                            strSubrequestType = m_lngSubRequestTypeID.ToString + "|" + m_lngRequestTypeId.ToString
                        End If
                    End If

                    If blnDisableSubRequestTypeCombo Then
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, " disabled ", True, True, , True))
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, intComboSize, strSubrequestType, "onchange=javascript:cboSubRequestType_OnChange()", True, True, , True))
                    End If
                End If

                'Template ******************************td***************
                If m_lngSubRequestTypeID <> 0 Then
                    m_strToken = CommonFunctions.Security.Token.GetToken(CType(m_lngSubRequestTypeID, String) + "0" + "0")
                    strSQL = "usp_CRM_Get_Templates " & m_lngSubRequestTypeID
                    dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
                    If dr.Read Then
                        intTemplateCount = CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateCount"), "0"), Integer)
                        Select Case intTemplateCount
                            Case 0 ' no templates
                                ' Commented by MonikaI on 14th Jul 2009 
                                ' RequestID 21655 Not able to download template attached with sub type if File server is different.

                                'Case 1 ' only one template
                                '    strHTML.Append("<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM_ADMIN", CType(CommonFunctions.Data.CheckIsDBNull(dr("TemplateID"), "0"), Long)) & "' >" & vbCrLf)

                                '    strHTML.Append("<Image Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'>")
                                '    strHTML.Append("</A>")
                            Case Else ' multiple templates
                                'Commented And Added By Vaijat K ON 07/12/2015
                                'strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../../responsive/images/View.gif' id ='view' title = 'View Template'></A>")
                                ''commented and Added by nilesh g  on 1-mar-2016 to validate Token
                                ''   strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ")'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                                strHTML.Append("<A href='JavaScript:ViewTemplates_OnClick(" & m_lngSubRequestTypeID & ",""" & m_strToken & """)'><Image  Border=0 src='../../Images/View.gif' id ='view' title = 'View Template'></A>")
                        End Select
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If
                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                Else
                    'Sub Request Type not Ploted..
                    strHTML.Append("</td>")
                    strHTML.Append("</tr>")
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' subject
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strSubject_Caption & "</TD>")
                strHTML.Append("<TD colspan=5>")

                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtSubject", "txtSubject", , intWidth, intPixelSize, strSubject, , , blnDisbaledSubjectTextBox, , , , , True, True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")

                strHTML.Append("</TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Description
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right vAlign=top>" & m_strDescription_Caption & "</TD>")
                strHTML.Append("<TD colspan=5> ")

                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmRequestDetails", , , intWidth, intPixelSize, , strDescription, , , , , , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))
                strHTML.Append("</TD></TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ''Product & Component
                If CommonFunction.Application.EnableProductExecution = True Then

                    ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                    ''dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_PM_DepartMentMaster WHERE ISNULL(ExposeToProductExecution,0) = 1 AND DepartMentID = " + lngFunctionID.ToString, MyBase.UseSQL)
                    dr = CommonFunction.Data.GetDataReader("usp_tbl_PM_DepartMentMaster_DepartMentID_ExposeToProductExecution " + lngFunctionID.ToString, MyBase.UseSQL)
                    '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    If dr.Read Then
                        ShowProductCombo = "1"
                    End If
                    CommonFunction.Data.DisposeDataReader(dr)

                End If

                If ShowProductCombo = "1" Then
                    strHTML.Append("<tr class=clsTREven><td colspan=6><HR></td></tr>")
                    strHTML.Append("<tr class=clsTREven>")
                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Product" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strProduct_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908

                    strHTML.Append("<td colspan=2>")

                    If (m_RequeststrLoginType = "E") Then
                        ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)

                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "SELECT ProductVersionID,Product + '-' + ProductVersion as Product FROM Tbl_PRD_ProductVersion A INNER JOIN tbl_PRD_Product B ON A.ProductID = B.ProductID order by Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "usp_sel_Tbl_PRD_ProductVersion_ProductVersionID_Product", 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                    Else
                        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                        'dr = CommonFunction.Data.GetDataReader("SELECT Customer  FROM tbl_PM_Customer WHERE CustomerID='" & strRequestor & "'", m_blnUseSQL)
                        dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Customer_Customer '" & strRequestor & "'", m_blnUseSQL)
                        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                        If dr.Read Then
                            strRequestorID = CType(CommonFunctions.Data.CheckIsDBNull(dr("Customer"), "0"), String)
                        Else
                            strRequestorID = "0"
                        End If
                        CommonFunction.Data.DisposeDataReader(dr)
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboProduct", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "',NULL" + "," + m_lngQueryID.ToString, 250, lngProductID.ToString, "Onchange=javascript:cboProduct_OnChange()", True, True, , False))
                    End If
                    strHTML.Append("</td>")

                    'Added by GokulP on 13 May 2010 for Issue ID : 23908
                    'strHTML.Append("<td  align=right>" & "Module/Component" & "</td>")
                    strHTML.Append("<td  align=right>" & m_strModuleComponent_Caption & "</td>")
                    'End of Addition by GokulP on 13 May 2010 for Issue ID : 23908

                    strHTML.Append("<td  colspan='2'>")


                    If (m_RequeststrLoginType = "E") Then  ' if Login person is employee and he is posting the issue for self or onbehalf of employee ( not for behalf of customer)
                        'Modified by SonalD on 11th March for IssueID 28765
                        'strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))


                        ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "SELECT B.ComponentID,Component FROM Tbl_PRD_ProductVersion_Component A INNER JOIN Tbl_PRD_Component B ON A.ComponentID = B.ComponentID WHERE ProductVersionID = " + lngProductID.ToString + " ORDER BY Component", 250, lngComponentID.ToString, , True, True, , False))
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "usp_sel_Tbl_PRD_ProductVersion_Component_ComponentID " + lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))

                        'End of modification by SonalD on 11th March 2009
                    Else
                        strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboModule", "Usp_Sel_Tbl_PRD_Customer_ProductVersion_Component '" & strRequestorID.ToString & "'," & lngProductID.ToString, 250, lngComponentID.ToString, , True, True, , False))

                        CommonFunction.Data.DisposeDataReader(dr)
                    End If
                    strHTML.Append("</td></tr>")
                    strHTML.Append("<tr  class=clsTREven><td colspan=6><HR></td></tr>")

                    ' Product and Module/Component value does not persist when ExposeTo Product Execution flag of related Dept. becomes off
                Else 'If (m_intCustomer <> 0 And m_strLoginType = "E") Or m_strLoginType = "C" Or m_RequeststrLoginType.ToUpper = "C" Then
                    strHTML.Append("<INPUT type=hidden name='cboProduct' id='cboProduct' value=" + lngProductID.ToString + ">")
                    strHTML.Append("<INPUT type=hidden name='cboModule' id='cboModule' value=" + lngComponentID.ToString + ">")
                End If

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' priority
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right>" & m_strPriority_Caption & "</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_RequestPriority"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strSQL, intComboSize, intPriorityID.ToString, , True, True, , True))
                strHTML.Append("</TD>")

                ' Severity
                strHTML.Append("<td align=right>" & m_strSeverity_Caption & "</TD>")
                strHTML.Append("<TD colspan=3>")
                strSQL = "usp_CRM_Get_RequestSeverity"
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strSQL, intComboSize, intSeverityID.ToString, , True, True))
                strHTML.Append("</TD>")
                strHTML.Append("</tr>")


                '' hidden dates
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Status
                strHTML.Append("<TR class=clsTREven>")
                strHTML.Append("<TD align=right >" & m_strStatus_Caption & "</TD>")
                strHTML.Append("<TD >")
                'Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0

                '' Modified by GaneshD on 05 Oct 2009 for showing only those statuses which are configured.
                '' strSQL = "usp_CRM_Get_RequestStatus"
                'strSQL = "usp_CRM_Get_RequestStatus " + lngRequestID.ToString + "," + m_lngSubRequestTypeID.ToString
                ''End of modification by GaneshD 

                Dim RoleId As String = Session("intPostId")
                strSQL = "usp_CRM_Get_RequestStatus " + lngRequestID.ToString + "," + RoleId

                'End of Commented And Added by NitinC on 25 March 2011 for WhizibleSEM 10.0
                If blnDisableStatusCombo Then
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, , " disabled ", , True, , True))
                Else
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSQL, intComboSize, intStatusID.ToString, " onchange=javascript:cboStatus_OnChange() ", , True, , True))
                    ' Added by GaneshD on 09 Jun 2009 For HelpDesk StatusFlow Configuration
                    m_StatusFlowCount = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatusFlowCount " + CType(lngRequestID, String) + "", MyBase.UseSQL), "0"), Integer)
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("StatusFlowCount", "StatusFlowCount", , , , m_StatusFlowCount.ToString, IsHidden:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    Dim strOldStatus As String = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Exec usp_Sel_CRM_GetStatus " + CType(intStatusID, String), MyBase.UseSQL), "0"), String)
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , strOldStatus, IsHidden:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "',2,'" + strOldStatus + "'", DisplayNone:=True)) '--, displaynone:=True
                    Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_CRM_ValidateCRMStatus '" + m_lngSubRequestTypeID.ToString + "'," + "1", DisplayNone:=True)) ', displaynone:=True
                    ' Addition End by GaneshD 
                End If
                'Commented by ShraddhaM on 17,Sep 2009 to remove reject Link
                'If intStatusID = 7 Then
                '    strHTML.Append("<b><a href='javascript:ViewRejectionComments_OnClick()'>View Comments</a><b>")
                'End If
                'Ended by ShraddhaM on 17,Sep 2009 to remove reject Link
                'Added by ShraddhaM to display changehistory of status on 17,Sep 2009
                strHTML.Append("<b><a href='javascript:ChangeHistory_OnClick()'>Status History</a><b>")
                'Call PlotFeedbackDiv()
                CommonFunction.cDiv.ShowHelpDeskFeedbackDiv()
                'Ended by ShraddhaM
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboStatusOld", "cboStatusOld", , , , intStatusID.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append("</TD>")

                ' ReportingTo approval of a request in Whiziblesem8
                Dim h As Integer
                Dim m As Integer

                Dim strHour As String
                Dim strMinute As String

                'Get Server Date & Time
                Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
                Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
                Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString


                h = CType(Left(strGetServerTime1, 2), Integer)
                m = CType(Right(strGetServerTime1, 2), Integer)


                If h < 10 Then
                    strHour = "0" + h.ToString
                Else
                    strHour = h.ToString
                End If
                If m < 10 Then
                    strMinute = "0" + m.ToString
                Else
                    strMinute = m.ToString
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilterState", "txtHiddenFilterState", , 400, 100, m_FilterData.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenFilter", "txtHiddenFilter", , 400, 100, m_Filter.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenDepartment", "txtHiddenDepartment", , 400, 100, m_Department.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenStatus", "txtHiddenStatus", , 400, 100, m_Status.ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                If m_strLoginType = "E" Then
                    strHTML.Append("<td align=right >" & m_strStatusChangeDate & "</TD>")
                Else
                    strHTML.Append("<td align=right > </TD>")
                End If

                strHTML.Append("<TD >")

                'Hidden date control contains DateValue of particular status from database
                strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDatehidden1", "txtchangedDateHidden1", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True, ))

                'control contains DateValue of particular status from database
                If m_strLoginType = "C" Then
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtReadOnlychangedDate", "txtReadOnlychangedDate", , 80, , CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(m_strStatusChangeDateValue), , , , True, , True, , True, False, , , EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, False, , , True))
                Else
                    strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("txtchangedDate", "txtchangedDate", , , m_strStatusChangeDateValue, , "frmRequestDetails", , , , , , , True, True, , , ))
                End If

                strHTML.Append(CommonFunction.HTMLControls.DrawTextArea("txtchangedTimehidden1", "txtchangedTimehidden1", , , , "frmRequestDetails", , , , , , m_strStatusChangeTimeValue, , , , , , True, , True, , , , , , True, "Soft", ))

                strHTML.Append("</TD>")
                If m_strLoginType = "E" Then
                    strHTML.Append("<td align=right >" & m_strStatusChangeTime & "</TD>")
                Else
                    strHTML.Append("<td align=right > </TD>")
                End If

                strHTML.Append("<TD >")

                If m_strLoginType = "C" Then
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , True, , True, , True, False, , , EnableHTMLEncode:=True))
                Else
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtchangedTime", "txtchangedTime", , 50, , m_strStatusChangeTimeValue, , , , , , , , True, True, , , EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                End If

                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                'CurrentDate field will hold date of server ,not  of client
                strHTML.Append(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, , "frmRequestDetails", , , , , , , True, False, , , True))
                strHTML.Append("<input type=hidden name='CurrentDate' id='CurrentDate1' value=" + CType(strGetServerDate1, Date).ToString("d") + ">")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                Dim strCurrentHours As String
                Dim strCurrentTime As String

                strCurrentHours = Now.Hour.ToString
                If CType(Now.Hour.ToString, Integer) < 10 Then
                    strCurrentHours = "0" + Now.Hour.ToString
                End If
                strCurrentTime = Now.Minute.ToString
                If CType(Now.Minute.ToString, Integer) < 10 Then
                    strCurrentTime = "0" + Now.Minute.ToString
                End If
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strCurrentHours + ":" + strCurrentTime, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15
                '****************************** CHANGE OF ROW ********************************************************************************************
                If (m_strLoginType <> "C") Then
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right vAlign=top>" & m_strComments_Caption & "</TD>")
                    strHTML.Append("<TD colspan=5>")
                End If
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , True, , , , , , , "Soft", ))

                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strComments, , , True, blnReadOnlyComments, , , , True, , , , , , , "Soft", , EnableHTMLEncode:=True))

                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Reasons For Rejection", , , "frmRequestDetails", , , 400, 100, , strReasonsForRejection, , , , True, , , , True, , , , , , True, "Soft", , EnableHTMLEncode:=True))
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode

                strHTML.Append("</TD>")

                strHTML.Append("</TR>")


                ' Assign TO
                If blnDisabledAssignToCombo Then
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right>" & m_strAssignTo_Caption & "</TD>")
                    strHTML.Append("<TD>")
                Else
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right><A Href='JavaScript:AssignTo_OnClick()' >" & m_strAssignTo_Caption & "</A></TD>")
                    strHTML.Append("<TD>")
                End If

                strSQL = "usp_CRM_Get_FunctionEmployees " & lngFunctionID & ",0," & lngAssignTo.ToString

                If blnDisabledAssignToCombo Then
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , , , strAssignTo, IsDisabled:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")
                Else
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("cboAssignTo", "cboAssignTo", , , , strAssignTo, IsDisabled:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("hidtxtAssignTo", "hidtxtAssignTo", , , , intAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("<font face=verdana;Arial size=1><A href='JavaScript:ShowSchedule_OnClick()'><B>Show Schedule</B></A></font>")
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("cboAssignToOld", "cboAssignToOld", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtSubmittedDate", "txtSubmittedDate", , , , lngAssignTo.ToString, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append("</TD>")
                End If


                ' Expected Resolution Date 
                strHTML.Append("<TD align=right>" & m_strExpectedResolvedDate_Caption & "</TD>")
                strHTML.Append("<TD>")

                ' Make Mandatory Exp.Resolution Date For CleanUp Activity
                strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtResolutionDate", "txtResolutionDate", , , strExpectedResolvedDate, , "frmRequestDetails", , , , , , , True, True))
                strHTML.Append("</TD>")
                'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtResolutionDateOld", "txtResolutionDateOld", , , , strExpectedResolvedDate, DisplayNone:=True, returnHTML:=True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenServerDate", "txtHiddenServerDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenPrevResolutionDate", "txtHiddenPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenCRMPrevResolutionDate", "txtHiddenCRMPrevResolutionDate", , 400, 100, CommonFunctions.Dates.GetDate(Now()).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHiddenSubmittedDate", "txtHiddenSubmittedDate", , 400, 100, CommonFunctions.Dates.GetDate(dtmSubmittedDate).ToString, , , , , , True, , True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:05/10/15

                ' To Remove CRM Exp.Resolution Date 
                If m_lngCRMID <> 0 Then ' if m_lngCRMID is not 0 then logged user is HRM or Dept. Head
                    strHTML.Append("<TD align=right>" & m_strCRMExpectedResolvedDate_Caption & "</TD>")
                    strHTML.Append("<TD>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", returnHTML:=True, IsMandatory:=True))
                    strHTML.Append("</TD>")
                Else
                    'CRM Exp resolution field gets cleared when submitter of the request saves it
                    strHTML.Append(CommonFunctions.HTMLControls.DrawDateControl("txtCRMResolutionDate", "txtCRMResolutionDate", , , strCRMExpectedResolvedDate, , "frmRequestDetails", returnHTML:=True, DisplayNone:=True))
                    strHTML.Append("<TD></TD><TD></TD>")

                End If
                strHTML.Append("</TR>")
                strHTML.Append("<TR class=clsTREven><TD colspan=6><HR></TD></TR>")

                '****************************** CHANGE OF ROW ********************************************************************************************
                ' Target Location

                If (m_strLoginType <> "C") Then
                    strHTML.Append("<TR class=clsTREven>")
                    strHTML.Append("<TD align=right>" & m_strTargetLocation_Caption & "</TD>")
                    strHTML.Append("<TD>")
                    strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboTargetLocation", "usp_sel_Active_Organisation_Units " + lngTargetLocationID.ToString, intComboSize, lngTargetLocationID.ToString, , True, True, , True))
                    strHTML.Append("</TD>")
                End If

                strHTML.Append("<TD align=right >Deliverable</td>")
                strHTML.Append("<TD>")

                Dim strDeliverableName As String = ""
                Dim drGetDeliverable As IDataReader

                If m_strDeliverableID <> "" Then
                    'Commented and added by ShraddhaM to display Deliverable Project Name
                    'strSQL = "Select Title From tbl_PM_OtherSchedules Where ScheduleID = " + m_strDeliverableID
                    strSQL = "usp_Sel_Request_DeliverableDetails " + m_strDeliverableID

                    drGetDeliverable = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drGetDeliverable.Read Then
                        strDeliverableName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("Title"), "0"), String)
                        m_strDelProjectID = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectID"), "0"), String)
                        strDelProjectName = CType(CommonFunction.Data.CheckIsDBNull(drGetDeliverable("ProjectName"), "0"), String)
                    End If

                    CommonFunctions.Data.DisposeDataReader(drGetDeliverable)
                End If

                If UCase(Trim(m_strFromWhere & "")) = "AR" Then
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunction.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , , , , True, , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , 200, 100, strDeliverableName.ToString, , , True, returnHTML:=True, EnableHTMLEncode:=True))

                Else

                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DeliverableID", "DeliverableID", , 100, 100, m_strDeliverableID, , , False, , , True, , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableName", "txtDeliverableName", , , , strDeliverableName.ToString, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                End If

                If UCase(Trim(m_strFromWhere & "")) = "AR" Then
                    strHTML.Append("</TD>")
                    strHTML.Append("<TD align=right >Project Name</td><TD>")
                    'Added by ShraddhaM to display project name on 16 Sep 2009
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", , 100, 100, m_strDelProjectID, , , , , , True, , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", , , , strDelProjectName, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    'Ended by ShraddhaM
                    strHTML.Append("</TD></TR>")
                Else
                    'strHTML.Append("</TD><TD></TD><TD></TD></TR>")
                    strHTML.Append("</TD>")
                    strHTML.Append("<TD align=right >Project Name</td><TD>")
                    'Added by ShraddhaM to display project name on 16 Sep 2009
                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("DelProjectID", "DelProjectID", , 100, 100, m_strDelProjectID, , , False, , , True, , True, EnableHTMLEncode:=True))
                    strHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("txtDelProjectName", "txtDelProjectName", , , , strDelProjectName, , , True, returnHTML:=True, EnableHTMLEncode:=True))
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    'Ended by ShraddhaM
                    strHTML.Append("</TD></TR>")
                End If


                If intStatusID <> 2 Then
                    strStyle = " style='display:none' "
                End If
                Dim strIsFeedbackdisabled As String = ""
                If UCase(Trim(m_strFromWhere & "")) <> "SR" Then
                    strIsFeedbackdisabled = " disabled "
                Else
                    strIsFeedbackdisabled = ""
                End If

                ' feeb back (submitted mode)
                strHTML.Append("<TR id=TRFeedback class=clsTREven " & strStyle & ">")
                strHTML.Append("<TD align=right>Feedback</TD>")
                strHTML.Append("<TD>")
                strSQL = "usp_CRM_Get_Feedback_ForCombo"
                ''Commented And Added By Vaijat K ON 10/10/2016
                ''strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, " disabled", , True, , True))
                strHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboFeedback", strSQL, intComboSize, intFeedbackID.ToString, strIsFeedbackdisabled, , True, , True))
                ''End of addition by Vaijat k
                strHTML.Append("</TD>")

                strHTML.Append("<TD></TD><TD></TD><TD></TD><TD></TD>")
                strHTML.Append("</TR>")

                strHTML.Append("<TR id=TRFeedbackComments class=clsTREven  " & strStyle & " >")
                strHTML.Append("<TD align=right vAlign=top>Feedback Comments </TD>")
                strHTML.Append("<TD colspan=5>")

                'strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , , True, , , , True, True, , , , , , "Soft", ))
                strHTML.Append(CommonFunctions.HTMLControls.DrawTextArea("txtFeedbackComments", "txtFeedbackComments", "Feedback Comments", , , "frmRequestDetails", , , intWidth, intPixelSize, , strFeedbackComments, , , , True, , , , True, True, , , , , , "Soft", , EnableHTMLEncode:=True))
                strHTML.Append("</TD>")
                strHTML.Append("</TR>")

                ' To persists Paging Number on List PAge after saving request in edit mode
                Dim strPageNumber As String
                strPageNumber = Request.QueryString("PageNumber")
                If strPageNumber Is Nothing OrElse strPageNumber = "" Then
                    strPageNumber = Request.Form("hidPageNumber")
                End If

                strHTML.Append("<INPUT type=hidden name='hidPageNumber' id='hidPageNumber' value=" + strPageNumber + ">")

                strHTML.Append("</Table>")
                Response.Write(strHTML.ToString)

                'Added By Amol Changle On: 21 Jul 2009
                'Purpose: To Plot Custom Fields
                PlotCustomFields()
                'End Addition

            Case TAB_ATTACHMENT

                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    ' attachments grid
                    'strHTML.Append(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_ATTACHMENTS"), , , True))
                    Response.Write(strHTML.ToString)
                    PlotAttachmentsGrid()
                    Response.Write("</TABLE>")
                End If

            Case TAB_DISCUSSION_THREAD
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    'ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                    ' Page legend
                    If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
                        Dim arrLegendDiscussion() As String = {"Discussion thread in blue color indicates thread shown to customer"}
                        arrLegendImage.SetValue("", 0)
                        strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegendDiscussion, True)
                        strHTML.Append(strLegend)
                    End If
                    'END ADDED by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    Response.Write(strHTML.ToString)

                    'Commented and added by Yogesh J for HTML encoding Date:05/10/15
                    Dim arrIgnoreHTMLEncode() As String = {"0"}
                    'ended by Yogesh J for HTML encoding Date:05/10/15
                    strSQL = "usp_CRM_Discussions " & m_lngQueryID

                    m_objGrid = New WebPages.Template.GenericGrid
                    'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    Dim arrUserFriendlyCols() As String = {"Submitted By", "Submitted Date", "Comment", "Select"}
                    Dim arrActualCols() As String = {"SubmittedBy", "SubmittedDate", "DiscussionThread", ""}
                    Dim arrCheckBox() As String = {"", "", "", "chkDiscussionThread"}
                    'end Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                    With m_objGrid
                        .NoOfDataColumns = 3
                        'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .PrimaryKey = "CRMQueryDetailid"
                        .CheckBoxIDArray = arrCheckBox
                        'END Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
                        .UserFriendlyColumnArray = arrUserFriendlyCols
                        .ActualColumnArray = arrActualCols
                        .returnHTML = False
                        .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                        .SQL = strSQL
                        .UseSQL = m_blnUseSQL
                        .PrinterFriendlyVersion = True
                        .DIVStyle = " overflow:auto; height:19.9%; width:99.9% "
                        .DrawGrid()
                    End With
                    m_objGrid = Nothing

                    Response.Write("</TABLE>")
                End If

            Case TAB_SLA
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    Response.Write(strHTML.ToString)
                    PlotSLAGrid()
                End If

            Case TAB_ACTIVITY_LOG
                If UCase(Trim(m_strMode & "")) = "EDIT" Then
                    strHTML.Append(strMenu)
                    strHTML.Append("<div id=divList style='overflow:auto;width:99.9%'>")
                    strHTML.Append("<Table class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
                    Response.Write(strHTML.ToString)
                    PlotActivityLogGrid()
                End If

        End Select

        Response.Write("</div>")

        Response.Write("<BR>")
        Response.Write(strMenu)

    End Sub
    Private Sub SetCaptions()
        '=====================================================================
        ' Procedure Name        : SetCaptions()
        ' Description           : to set the captions for the sub request type
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 25,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader

        If m_lngSubRequestTypeID <> 0 Then
            dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_RequestSubType_Captions " & m_lngSubRequestTypeID, m_blnUseSQL)
            If dr.Read Then
                m_strSubject_Caption = dr("Subject").ToString & ""
                m_strDescription_Caption = dr("Description").ToString & ""
                m_strAssignTo_Caption = dr("AssignTo").ToString & ""
                m_strPriority_Caption = dr("Priority").ToString & ""
                m_strExpectedResolvedDate_Caption = dr("ExpectedResolvedDate").ToString & ""
                m_strStatus_Caption = dr("Status").ToString & ""
                m_strSubRequestType_Caption = dr("SubRequestType").ToString & ""
                m_strTargetLocation_Caption = dr("TargetLocation").ToString & ""
                m_strFunction_Caption = dr("Function").ToString & ""
                m_strCRMExpectedResolvedDate_Caption = dr("CRMExpectedResolvedDate").ToString & ""
                m_strComments_Caption = dr("Comments").ToString & ""
                m_strReasonsForRejection_Caption = dr("ReasonsForRejection").ToString & ""
                m_strSeverity_Caption = dr("Severity").ToString() & ""
                'Added By AratiS On 24-Nov-09 For RequestID-23908
                m_strProduct_Caption = dr("ProductID").ToString & ""
                m_strModuleComponent_Caption = dr("ComponentID").ToString & ""
                m_strFeedBack_Caption = dr("Feedback").ToString & ""
                m_strFeedbackComments_Caption = dr("FeedbackComments").ToString & ""
                m_strRequestType_Caption = dr("RequestType").ToString
                m_strSubmittedBy_Caption = dr("SubmittedBy").ToString & ""
                m_strSubmittedDate_Caption = dr("SubmittedDate").ToString & ""
                m_strQueryID_Caption = dr("QueryID").ToString & ""
                'End:Added By AratiS On 24-Nov-09 For RequestID-23908
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If

    End Sub

    Private Function GetEmployeeDepartment(ByVal EmployeeID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetEmployeeDepartment
        ' Description           : to get the employee locan.
        ' Purpose               : 
        ' Parameters Passed     : intEmployeeID
        ' Returns               : the location id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 21,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_EmployeeLocation " & EmployeeID, m_blnUseSQL)
        If dr.Read Then
            GetEmployeeDepartment = CType(CommonFunctions.General.CheckIsNothing(dr("LocationID"), "0"), Long)
        Else
            GetEmployeeDepartment = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetCaption(ByVal TagID As Long, ByVal ControlName As String) As String
        '=====================================================================
        ' Procedure Name        : GetCaption
        ' Description           : gets the caption for the control & tagid
        ' Purpose               : same as above
        ' Parameters Passed     : control name
        ' Returns               : the caption for the control name
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : usp_CRM_Get_Tag_Attribute_Caption
        ' Author                : Rajanikant
        ' Created               : Feb 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_Tag_Attribute_Caption  " & TagID & ",'" & CommonFunctions.General.BuildQueryString(ControlName) & "'", m_blnUseSQL)
        If dr.Read Then
            ' the caption returned by the sp
            GetCaption = dr("ControlCaption").ToString
        Else
            ' send the same name back
            GetCaption = ControlName
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Sub PlotFeedbackDiv()
        'Commnet Div
        Dim strSQL As String
        CommonFunction.General.WriteHTML("<DIV id='DivFeedBack' style='WIDTH: 10px;height:150px;DISPLAY:none;OVERFLOW:hidden;border:black 1px outset;;Z-INDEX: 10000'>" + vbCrLf)
        CommonFunction.General.WriteHTML("<Table class=clsTRSectionHeader cellspacing=0 cellpadding=0 >" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven ><td id='tdComment' colspan=2><b>Add Feedback</b></td></TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=right>Feedback</TD>" + vbCrLf)

        CommonFunction.General.WriteHTML("<TD>")
        strSQL = "usp_CRM_Get_Feedback_ForCombo"
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("cboFeedbackDiv", strSQL, 100, intFeedbackID.ToString, , , True, , True))
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD align=right>Feedback Comments</TD>")
        CommonFunction.General.WriteHTML("<TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtSubmitCommentsDiv", "txtSubmitCommentsDiv", , widthInPixel:=300, heightInPixel:=70, maxLength:=1000, returnHTML:=True) + vbCrLf)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextArea("txtSubmitCommentsDiv", "txtSubmitCommentsDiv", , widthInPixel:=300, heightInPixel:=70, maxLength:=1000, returnHTML:=True) + vbCrLf)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunction.General.WriteHTML("</TD>" + vbCrLf)
        CommonFunction.General.WriteHTML("</TR>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TR class=clsTREven>" + vbCrLf)
        CommonFunction.General.WriteHTML("<TD colspan=2 align=center><input type=button id= btnOK name= btnOK Value = '   OK   ' style ='font size=9 width=10pts' onClick = SubmitOK_Onclick()> <input type=button id= btnCancel name= btnCancel style ='font size=9' Value = CANCEL onClick = Cancel_OnClick()>" + vbCrLf)
        'CommonFunction.General.WriteHTML("<TD colspan=2 align=center><input type=button id= btnOK name= btnOK Value = '   OK   ' style ='font size=9 width=10pts' onClick = SubmitOK_Onclick()>" + vbCrLf)
        CommonFunction.General.WriteHTML("</td></tr>" + vbCrLf)
        CommonFunction.General.WriteHTML("</table>" + vbCrLf)
        CommonFunction.General.WriteHTML("</DIV>" + vbCrLf)
    End Sub
#Region "events"

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strTD As String = ""

        If m_intShow = TAB_ATTACHMENT Then
            If Args.ColIndex = 0 Then
                Cancel = True
                'If Args.NoOfRowsPrinted Mod 2 = 0 Then
                '    strTD = "<TR class=clsTROdd>"
                'Else
                '    strTD = "<TR class=clsTREven>"
                'End If
                strTD += "<TD align=right>" & Args.NoOfRowsPrinted + 1 & ".</TD>"
                Args.StringToBeInserted = strTD
            End If

            If Args.ColIndex = 1 Then
                ' provision to view attachment
                Cancel = True
                strTD += "<TD>"
                'Modified By VarunA on 3-Feb-2008 Whizible 7.1 Development & Release
                'strTD += "<A Target= '_newWindow' href='" & CommonFunction.General.funcReturnOriginalFileName("CRM", CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("AttachmentID"), "0"), Long)) & "' >" & vbCrLf
                strTD += "<A href=""JavaScript:Attachment_Onclick('" + Args.DataReader("SystemFileName").ToString + "','" + Args.DataReader("OriginalFileName").ToString + "')"">" & vbCrLf
                'End By VarunA on 3-Feb-2008
                strTD += Args.DataReader("OriginalFileName").ToString
                strTD += "</A>"
                strTD += "</TD>"
                Args.StringToBeInserted = strTD
            End If

            ' Show the attachment time along with user name
            If UCase(Trim(Args.DataField & "")) = "ATTACHEDBY" Then
                strTD = "<TD>" & Args.DataReader("AttachedBy").ToString & "[On " & Server.HtmlEncode(CommonFunctions.Dates.CGetDateTime(CType(Args.DataReader("DateAttached").ToString, Date)) & "") & "]" & "</TD>"
                Cancel = True
                Args.StringToBeInserted = strTD
            End If

            ' disable checkboxes of deletion?
            If Trim(Args.CheckBoxId & "") <> "" Then
                Args.IsCheckBoxDisabled = Not m_blnAllowAttachmentDeletion
            End If
        End If
        'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
        If m_intShow = TAB_DISCUSSION_THREAD Then
            Dim strComments As String
            strComments = Args.DataReader("DiscussionThread").ToString
            strComments = HtmlEncode(strComments)
            ''Commented and added by Yogesh J on 22-Jan-2016
            Args.StringToBeInserted = "<TD><PRE>" & strComments & "</PRE></TD>"
            'Args.StringToBeInserted = "<TD><P>" & strComments & "</P></TD>"
            ''End of comment by Yogesh J on 22-jan-2016
            Cancel = True

        End If
        'Modified by Amit Mahadik on 21Mar 2011 Purpose:Whizible SEM 10.0,DELETE DISCUSSIONS
    End Sub
    'Added by Amit Mahadik on 21 Mar 2011 Purpose:Whizible SEM 10.0
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

        If m_intShow = TAB_DISCUSSION_THREAD Then

            Dim ShowToCustFlag As Boolean
            Dim strTR As String
            Dim isValidDelete As Boolean

            ShowToCustFlag = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ISSHOWTOCUSTOMER"), "0"), Boolean)

            m_strSubmittedBy = Args.DataReader("SUBMITTEDBY").ToString
            ''user can delete comments if allow delete is enabled at department level.......
            If m_blnIsAllowDeleteAtDeptLevel = True Then
                ''user can delete only todays comments....
                If CType(Args.DataReader.Item("SUBMITTEDDATE"), Date).ToShortDateString() = CType(DateTime.Today, Date).ToShortDateString() Then
                    If m_strUserName = m_strSubmittedBy Then
                        isValidDelete = True
                    Else
                        isValidDelete = False
                    End If
                Else
                    isValidDelete = False
                End If
            Else
                isValidDelete = False
            End If
            If m_strRowCount = True Then
                m_strRowCount = False
            Else
                m_strRowCount = True
            End If

            If m_strRowCount = False Then
                strTR = "<TR class='clsTREven'> "
            Else
                strTR = "<TR class='clsTROdd'> "
            End If
            'Added by Amit Mahadik on 02 August 2011 Purpose:Whizible SEM 10.0,do not show in blue if query is not submitted by customer.
            Dim strSQLTemp As String = "SELECT LoginType FROM tbl_CRM_Query_Master WHERE QueryID='" & m_lngQueryID.ToString() & "'"
            Dim strLoginTypeTemp As String = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLTemp, MyBase.UseSQL), ""), ""), String)
            ''If strLoginTypeTemp <> "C" Then

            ''End If
            'End Added by Amit Mahadik on 02 August 2011 Purpose:Whizible SEM 10.0,do not show in blue if query is not submitted by customer.
            If CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") <> "C" And ShowToCustFlag = True And strLoginTypeTemp = "C" Then
                ''IF LoginType IS NOT C THEN SHOW IN BLUE COLOR
                strTR += "<TD vAlign=top title='User Name'><font color='BLUE'> " & CType(Args.DataReader.Item("SUBMITTEDBY"), String) & " </font></td>"
                strTR += "<TD vAlign=top title='Date'><font color='BLUE'> " & CType(Args.DataReader.Item("SUBMITTEDDATE"), Date) & " </font></td>"
                ''Commented and added by Yogesh J on 22-Jan-2016
                'strTR += "<TD vAlign=top title='Comments'><font color='BLUE'><PRE>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</PRE></font></TD>"
                strTR += "<TD vAlign=top title='Comments'><font color='BLUE'><PRE Style='color:blue'>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</PRE></font></TD>"
                'strTR += "<TD vAlign=top title='Comments'><font color='BLUE'><P>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "</P></font></TD>"
                ''End of comment by Yogesh J on 22-jan-2016
            Else
                ''IF LoginType IS C THEN SHOW IN NORMAL COLOR
                strTR += "<TD vAlign=top title='User Name'> " & CType(Args.DataReader.Item("SUBMITTEDBY"), String) & " </td>"
                strTR += "<TD vAlign=top title='Date'> " & CType(Args.DataReader.Item("SUBMITTEDDATE"), Date) & " </td>"
                '   strTR += "<TD vAlign=top title='Comments'><PRE>" & CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String) & "<PRE></TD>"'
                'comented added by shamkant S on 9 Nov 2015
                strTR += "<TD vAlign=top title='Comments'><PRE>" & HttpUtility.HtmlEncode(CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String)) & "<PRE></TD>"
                'Added by Shamkant s on 19 Dec 2015
                'strTR += "<TD vAlign=top title='Comments'>" & HttpUtility.HtmlEncode(CType(Args.DataReader.Item("DISCUSSIONTHREAD"), String)) & "</TD>"
                ''Ended by Shamkant S on 19 Dec 2015
            End If

            If isValidDelete Then
                strTR += "<TD  align=center>" & "<Input type=checkbox name='chkDiscussionThread' id='chkDiscussionThread' class='clsCheckBox' value='" & CType(Args.DataReader.Item("CRMQueryDetailid"), String) & "' >" & "</TD>"
            Else
                strTR += "<TD>&nbsp;</TD>"
            End If
            strTR += "</TR>"
            If Not (CommonFunctions.General.CheckIsNothing(Session("LoginType"), "") = "C" And ShowToCustFlag = False) Then
                Args.StringToBeInserted = strTR
            End If


            Cancel = True

            m_blnIsRecordInGrid = True
        End If
    End Sub
    Private Sub m_objGrid_NoDataCommentTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_NoDataCommentTR) Handles m_objGrid.NoDataCommentTR_BeforePrint
        If m_blnIsRecordInGrid = True Then
            Cancel = True
        End If
    End Sub
    '''END Added by Amit Mahadik on 21 Mar 2011 Purpose:Whizible SEM 10.0

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If UCase(Trim(m_strMode & "")) = "NEW" Then
            'In case of Add New mode display only "Save", "Close" and "Help"
            Select Case Args.LinkName
                Case MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help"), "Save and Close"

                Case Else : Cancel = True
            End Select
        Else
            Select Case UCase(Trim(m_strFromWhere & ""))
                Case "DB" 'When called from DB (E-Dashboard)
                    'If HRM rights are not there then do not show following links
                    '"Convert to deliverable", "Assign Task", "Assign Issue", "Delete Attachments", "Select All Attachments"
                    If blnViewAccessOrHRM = 0 Then
                        If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Then
                            Cancel = True
                        End If
                    Else 'Added by ShraddhaM to change link name when deliverable is created
                        If Not m_strDeliverableID Is Nothing And m_strDeliverableID <> "" And Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Then
                            Args.LinkName = "Converted To Deliverable"
                        End If
                    End If

                Case "MD" ' When called from MD (My Dashboard)
                    ' If HRM rights are not there then do not show following links
                    ' "Convert to deliverable", "Assign Task", "Assign Issue", "Delete Attachments", "Select All Attachments"
                    If blnViewAccessOrHRM = 0 Then
                        If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Then
                            Cancel = True
                        End If
                    End If

                    ' Do not display following links
                    ' "Add attachments", "Delete Attachments", "Select All Attachments", 
                    '"Convert to deliverable", "Assign Task", "Assign Issue", "Reject"
                    If Args.LinkName = MyBase.GetResourceString("MENU_ADD_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Or Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_REJECT") Then
                        Cancel = True
                    End If

                Case "AR" ' When called from AR (Assigned Request)
                    ' Do not display "Convert to deliverable" and "Assign Task" links 
                    ' If Args.MenuColIndex = 0 Or Args.MenuColIndex = 1 Then
                    If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Then
                        Cancel = True
                    End If

                    ' Do not show Reject Link 
                    If Args.LinkName.ToUpper = "REJECT" Then
                        Cancel = True
                    End If

                    ' Do not show "Assig Issue" link 
                    If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Then
                        Cancel = True
                    End If

                    ' Do not display "Save" link if status is closed or HRM rights are not there
                    If Args.LinkName = MyBase.GetResourceString("MENU_SAVE") Then
                        If m_lngStatusId = 2 And blnViewAccessOrHRM = 0 Then
                            Cancel = True
                        End If
                    End If

                Case "SR" ' When called from SR (Submitted Request)
                    ' Do not display "Convert to deliverable" and "Assign Task" links
                    ' If Args.MenuColIndex = 0 Or Args.MenuColIndex = 1 Then
                    If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Then
                        Cancel = True
                    End If

                    ' Do not show Reject Link 
                    If Args.LinkName.ToUpper = "REJECT" Then
                        Cancel = True
                    End If

                    ' Do not show "Assig Issue" link 
                    If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Then
                        Cancel = True
                    End If

                    ' To remove Flag For Follow Up Link If Request Posted on Behalf of Custome and Employee
                    If m_strLoginType.ToString.ToUpper = "E" And (m_intCustomer <> 0 Or m_intRequestedEmployee <> 0) Then
                        If Args.LinkName = MyBase.GetResourceString("MENU_FLAG_REQUEST") Then
                            Cancel = True
                        End If
                    End If
                    'Added by vidyaK on 04 June 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
                    If Args.LinkName.ToUpper = "SAVE" And strAprovalStatus = "R " Then
                        Args.LinkName = "Save & Resubmit"
                        Args.ToolTip = "Save & Resubmit"
                    End If

                    If Args.LinkName.ToUpper = "SAVE AND CLOSE" And strAprovalStatus = "R " Then
                        Args.LinkName = "Save-Resubmit & Close"
                        Args.ToolTip = "Save-Resubmit & Close"
                    End If
                    'End - Added by vidyaK on 04 June 2010 for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
            End Select

            ' Hiding menu depending on login type
            Select Case m_strLoginType.ToUpper
                Case "C"
                    ' Assign Issue link should not be available for user of type Customer
                    If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Then
                        Cancel = True
                    End If
                    ' Purpose: Flag Request link should be displayed only  to Employee login
                    If Args.LinkName = MyBase.GetResourceString("MENU_FLAG_REQUEST") Then
                        Cancel = True
                    End If
                Case "E"

            End Select


            ' Discussion threads
            ' If discussion threads are available then display number of discussion thread in bracket
            If Args.LinkName = MyBase.GetResourceString("MENU_DISCUSSIONTHREAD") Then
                If m_intDiscussionThreadCount = 0 Then
                    Args.LinkName = MyBase.GetResourceString("MENU_DISCUSSIONTHREAD")
                Else
                    Args.LinkName = MyBase.GetResourceString("MENU_DISCUSSIONTHREAD") & " (" & m_intDiscussionThreadCount & ")"
                End If
            End If

            ' Reject Link
            ' Do not show Rejecr link if task is created or request is closed or already rejected
            If Args.LinkName.ToUpper = "REJECT" Then
                Dim strSQL As String
                Dim blnTaskCreated As Boolean
                'strSQL = "IF EXISTS(SELECT  CRMQueryID  FROM tbl_PM_ProjectTasks WHERE CRMQueryID = " + m_lngQueryID.ToString + " Union  SELECT  CRMQueryID  FROM Tbl_IB_Issue WHERE CRMQueryID = " + m_lngQueryID.ToString + "  ) SELECT 1 ELSE 	 	SELECT 0 "
                strSQL = "usp_CheckTaskOrIssueCreated " + m_lngQueryID.ToString

                blnTaskCreated = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Boolean)

                If blnTaskCreated = True Then
                    Cancel = True
                End If
                ' if Status is Closed or Rejected hide Reject Link 
                If m_lngStatusId = 2 Or m_lngStatusId = 7 Then
                    Cancel = True
                End If
            End If

            ' If status is closed then do not display following links
            ' "Convert to deliverable", "Assign Task", "Assign Issue", "Delete Attachment", "Select All Attachments"
            If m_lngStatusId = 2 Then
                If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Then
                    Cancel = True
                End If
            End If

        End If
        '----------------------------------------------------------------------------------------------------------------------------------------
        '' Assign Task & Assign Issue links are only for CRM (coming from DB)
        ''If UCase(Trim(m_strFromWhere & "")) <> "DB" then
        'If UCase(Trim(m_strFromWhere & "")) <> "DB" Then
        '    'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '    'Purpose: added one condition for My e-Dashboard (MD)
        '    If UCase(Trim(m_strFromWhere & "")) <> "MD" Then
        '        'End of addition by PrashantSJ on 09 Nov 2006
        '        If Args.MenuColIndex = 0 Or Args.MenuColIndex = 1 Then
        '            Cancel = True
        '        End If
        '        ' Added By NitinVS on 9 Aug 2005 FOR WhizibleSEM SP4 IssueID 2 To Show Reject Link When Called from DB Only 
        '        If Args.LinkName.ToUpper = "REJECT" Then
        '            Cancel = True
        '        End If
        '        'Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        '        'Purpose: added one condition for My e-Dashboard (MD)
        '    End If
        '    'End of addition by PrashantSJ on 09 Nov 2006
        '    ' End Addition By NitinVS on 9 Aug 2005 FOR WhizibleSEM SP4 IssueID 2 To Show Reject Link When Called from DB Only 
        'End If
        '' Discussion threads
        ''modified by harshada D on 30 Jan 2006 for helpdesk enhancements .
        'If Args.LinkName = MyBase.GetResourceString("MENU_DISCUSSIONTHREAD") Then
        '    'If Args.MenuColIndex = 5 Then
        '    'end of modification by harshada D on 30 Jan 2006 for helpdesk enhancements .
        '    If m_intDiscussionThreadCount = 0 Then
        '        Args.LinkName = MyBase.GetResourceString("MENU_DISCUSSIONTHREAD")
        '    Else
        '        Args.LinkName = MyBase.GetResourceString("MENU_DISCUSSIONTHREAD") & " (" & m_intDiscussionThreadCount & ")"
        '    End If
        'End If

        '' Modified By NitinVS on 9 Aug 2005 for WhizibleSEM SP4 IssueID 2 To Show Reject Link 
        'If Args.LinkName.ToUpper = "REJECT" Then
        '    Dim strSQL As String
        '    Dim blnTaskCreated As Boolean
        '    'strSQL = "IF EXISTS(SELECT  CRMQueryID  FROM tbl_PM_ProjectTasks WHERE CRMQueryID = " + m_lngQueryID.ToString + " Union  SELECT  CRMQueryID  FROM Tbl_IB_Issue WHERE CRMQueryID = " + m_lngQueryID.ToString + "  ) SELECT 1 ELSE 	 	SELECT 0 "
        '    strSQL = "usp_CheckTaskOrIssueCreated " + m_lngQueryID.ToString

        '    blnTaskCreated = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, MyBase.UseSQL), "0"), "0"), Boolean)

        '    If blnTaskCreated = True Then
        '        Cancel = True
        '    End If
        '    ' if Status is Closed or Rejected hide Reject Link 
        '    If m_lngStatusId = 2 Or m_lngStatusId = 7 Then
        '        Cancel = True
        '    End If
        'End If
        'End If

        ''Assign Issue link should not be available for user of type Customer
        'If m_strLoginType.ToUpper = "C" Then
        '    If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Then
        '        Cancel = True
        '    End If
        'End If
        ''Added by PrashantD on 25 Feb 2006 for IssueID - 2480
        'If m_strFromWhere = "SR" Or m_strFromWhere = "AR" Then
        '    If Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Then
        '        Cancel = True
        '    End If
        'End If
        ''End of Addition by PrashantD
        ''Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        ''Purpose: added one condition for My e-Dashboard (MD)
        ''If blnViewAccessOrHRM = 0 And m_strFromWhere = "DB" Then
        'If blnViewAccessOrHRM = 0 And (m_strFromWhere = "DB" Or m_strFromWhere = "MD") Then
        '    'End of addition by PrashantSJ on 09 Nov 2006
        '    If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Then
        '        Cancel = True
        '    End If
        'End If

        ''Added and commented by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1
        ''Purpose: Flag Request link should be displayed only  to Employee login
        'If m_strLoginType.ToString.ToUpper <> "E" Then
        '    If Args.LinkName = MyBase.GetResourceString("MENU_FLAG_REQUEST") Then
        '        Cancel = True
        '    End If
        'End If
        ''Added By ShraddhaM on 6,Aug 2007 
        ''Purpose : To remove Flag For FolloeUp Link If Request Posted on Behalf of Custome and Employee
        ''And m_intCustomer <> 0
        'If m_strFromWhere = "SR" Then
        '    If m_strLoginType.ToString.ToUpper = "E" And (m_intCustomer <> 0 Or m_intRequestedEmployee <> 0) Then
        '        If Args.LinkName = MyBase.GetResourceString("MENU_FLAG_REQUEST") Then
        '            Cancel = True
        '        End If
        '    End If
        'End If

        ''End of addition By ShraddhaM on 6,Aug 2007 

        'If m_strFromWhere = "MD" Then
        '    'End of addition by PrashantSJ on 09 Nov 2006
        '    If Args.LinkName = MyBase.GetResourceString("MENU_ADD_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Or Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_REJECT") Then
        '        Cancel = True
        '    End If
        'End If
        '{MyBase.GetResourceString("MENU_ADDDELIVERABLE"), MyBase.GetResourceString("MENU_ASSIGNTASK"), MyBase.GetResourceString("MENU_ASSIGNISSUE"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_REJECT"), MyBase.GetResourceString("MENU_SHOWHISTORY"), MyBase.GetResourceString("MENU_DISCUSSIONTHREAD"), MyBase.GetResourceString("MENU_ADD_ATTACHMENT"), MyBase.GetResourceString("MENU_DELETE_ATTACHMENT"), MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS"), MyBase.GetResourceString("MENU_FLAG_REQUEST"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'End of addition by PrashantSJ on 09 Nov 2006
        'Added by PrajaktaR on 19th Feb 2007 for WhizibleSEM SP9
        'If m_lngStatusId = 2 Then
        '    'End of addition by PrashantSJ on 09 Nov 2006
        '    If Args.LinkName = MyBase.GetResourceString("MENU_ADDDELIVERABLE") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNTASK") Or Args.LinkName = MyBase.GetResourceString("MENU_ASSIGNISSUE") Or Args.LinkName = MyBase.GetResourceString("MENU_DELETE_ATTACHMENT") Or Args.LinkName = MyBase.GetResourceString("MENU_CRM_SELECTALLATTACHMENTS") Then
        '        Cancel = True
        '    End If
        'End If
        'END OF Addition by PrajaktaR on 19th Feb 2007 for WhizibleSEM SP9
        'Added by PrashantD on 13 Jun 2007 for CleanUp Activity
        'If m_strFromWhere = "AR" Then
        '    If Args.LinkName = MyBase.GetResourceString("MENU_SAVE") Then
        '        If m_lngStatusId = 2 And blnViewAccessOrHRM = 0 Then
        '            Cancel = True
        '        End If

        '    End If

        'End If
        '''''''''''''''PrashantSJ on 9 Sept 2009 To hide the SAVE link while saving.
        Select Case Args.LinkName.ToUpper
            Case MyBase.GetResourceString("MENU_SAVE").ToUpper
                If Cancel = False Then
                    Cancel = True
                    Args.StringToBeInserted = "<label id='lblSave'>| <A class='Menu' style='' onmouseover=""this.style.backgroundColor='#FFD695'"" onmouseout=""this.style.backgroundColor=''""  onclick=""Javascript:Save_OnClick()"" Title=""Save"" >Save</A></label>"
                End If
            Case "SAVE AND CLOSE"
                If Cancel = False Then
                    Cancel = True
                    Args.StringToBeInserted = "<label id='lblSave'>| <A class='Menu' style='' onmouseover=""this.style.backgroundColor='#FFD695'"" onmouseout=""this.style.backgroundColor=''""  onclick=""Javascript:Save_OnClick(1)"" Title=""Save and Close"" >Save and Close</A></label>"
                End If
        End Select
        '''''''''''''''End of addition by PrashantSJ on 9 Sept 2009

      
    End Sub

#End Region


    Private Sub m_objMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Menu) Handles m_objMenu.Initialize

    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        'If Page.IsPostBack Then
        'Else
        '    HttpContext.Current.Session.Remove("m_intCustomer")
        '    HttpContext.Current.Session.Remove("m_strVal")
        '    HttpContext.Current.Session.Remove("Customer")

        'End If

    End Sub
    ' Added by SrikanthY on 28 Dec 2006 To Display Client Details on Request main Screen In case of Clients Login
    Private Sub GetClientDetails()
        Dim strSQL As String
        Dim drClient As IDataReader
        strSQL = "USP_SEL_TBL_PM_LOGIN_CLIENTDETAILS " & CType(m_lngLoginID, String)
        drClient = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If drClient.Read Then
            m_strLoginName = CType(CommonFunctions.Data.CheckIsDBNull(drClient("LOGINNAME"), ""), String)
            m_blnIsClient = CType(CommonFunctions.Data.CheckIsDBNull(drClient("ISCREATEDBYCUSTOMER"), "0"), Boolean)
        End If
        CommonFunctions.Data.DisposeDataReader(drClient)
    End Sub
    'End of Addition by SrikanthY


    Private Sub PlotCustomFields(Optional ByVal UserID As Integer = 0, Optional ByVal LoginType As String = "")
        '=====================================================================
        ' Proceduere  Name	    :	PlotCustomFields
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To draw custom fields section
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Amol Changle
        ' Created				:	21 Jul 2009
        ' Revisions				:	
        '=====================================================================

        Dim ObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        With ObjCustomFieldsSection
            'Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFieldsSection", "HideShowCustomFieldsSection"))
            Response.Write(.GetSectionTitle("Custom Fields", "DivCustomFieldsSection", "HideShowCustomFieldsSection"))

            'Write ClientsideScript in order to show hide the section
            Response.Write("<SCRIPT Language=javascript>")
            Response.Write(.ClientsideScript)
            Response.Write("</SCRIPT>")
        End With
        Response.Write("<DIV id=DivCustomFieldsSection width='99.9%' style='overflow:auto'>")

        ''Dim strTaskID As String
        'Dim strDummyTask As String
        'Dim blnDummyDefaultValue As Boolean
        ''strTaskID = CommonFunction.General.CheckIsNothing(Request.QueryString("CopyTask"), "")
        'If m_lngQueryID <> 0 Then
        '    strDummyTask = strTaskID
        '    blnDummyDefaultValue = False
        'Else
        '    strDummyTask = m_lngTaskId.ToString()
        '    blnDummyDefaultValue = m_blnShowDefaults
        'End If

        Dim objCustomFields As New PM_CustomFields()

        With objCustomFields

            .EntityName = "Help-Desk"
            .FormName = "frmRequestDetails"
            .PrimaryKey = "QueryID"
            .PrimaryTable = "Tbl_CRM_Query_Master"
            .TypeID = m_lngSubRequestTypeID
            .IsAddNewMode = IIf(m_lngQueryID = 0, True, False)
            .PrimaryKeyValue = m_lngQueryID
            .QueryStringForTypeChange = "SubRequestTypeID"
            .m_lngProjectId = 0
            .PlotCustomFields(UserID, LoginType)
            declarevariables = .VariableDeclarationScript
            strClientSideScript = .ValidationScript
            strDefaultScript = .DefaultValueScript
            m_strCustomFieldList = .AccesibleCustomFields
        End With

        Response.Write("</DIV>")

        'Added By Amol Changle On: 22 Jul 2009
        'Purpose: To render Custom Field validations
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("<script language=javascript>")
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("function ValidateCustomFields(){")
        If Not declarevariables Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(declarevariables)
        End If
        If Not strClientSideScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strClientSideScript)
        End If
        If Not strDefaultScript Is Nothing Then
            CommonFunctions.General.WriteHTML(vbCrLf)
            CommonFunctions.General.WriteHTML(strDefaultScript)
        End If
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("return true;}")
        CommonFunctions.General.WriteHTML(vbCrLf)
        CommonFunctions.General.WriteHTML("</script>")
        'End Addition

    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
