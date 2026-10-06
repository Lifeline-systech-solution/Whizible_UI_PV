'DECLARATION: THIS IS A FRAMEWORK CODE ITEM. IT IS NOT EXPECTED TO MODIFY THIS AT THE APPLICATION LEVEL
Public Class CommonPage
    Inherits WebPages.Template.WhizTemplate
#Region "variables"
    'const
    Public Const FORM_NAME As String = "frmCommonPage"
    'Code Added:RajeshB             12 Jan 2005
    ' Purpose: Client ID for form element
    Public Const FORM_ID As String = "frmCommonPage"
    'Code Added:RajeshB         17 Jan 2005
    'Purpose:CommonList object
    Protected strListPage As String = "CommonList.aspx"
    Protected strFormPage As String = "CommonPage.aspx"
    Protected strSubTagFormPage As String = "CommonPage.aspx"
    'Addition Ends
    Public Const FocusOn_SUBTAG As String = "SUBTAG"
    'Local variables
    Protected m_objGlobal As WebPages.Template.IGlobal
    Private m_strRightCaption As String = ""
    Private m_strMiddleCaption As String = ""
    Private m_strHeaderFooter As String = ""
    Private m_strDivTag As String = "divPage"
    Private m_objAccess As WebPage.Templates.AccessRights
    'Create the object of cCLSQL class
    Private m_cObjCPSQL As CommonEngine.CommonPage.cCPSQL
    'Parameters to be persisted
    Private m_strFromCL As String = ""
    Private m_strCommonQueryString As String = ""
    Private m_strPrimaryKeyValue As String
    Private m_strClientsideScript As String = ""
    Private m_strNewPK As String = ""
    Private m_blnRedirectToCL As Boolean = True
    Private m_strQuerystringDefaultParameters As String = ""
    'Added By UmeshJ on 5th July 2004
    Private m_strParentTagQuerystringDefaultParameters As String = ""
    'End of Addition
    Private Const m_strFormValidationFunctionHeaderSection As String = "ValidateForm_HeaderSection"
    Private Const m_strFormValidationFunctionFooterSection As String = "ValidateForm_FooterSection"
    Private Const m_strEnabledControlsFunctionHeaderSection As String = "EnableControlsHeaderSection"
    Private Const m_strEnabledControlsFunctionFooterSection As String = "EnableControlsFooterSection"
    Private Const CLCP_SET_FOCUS_FUNCTION As String = "focusOnFirstControl()"
    Private Const m_strexpandSectionsFunction As String = "expandSections"
    Private m_strMode As String = ""
    Private m_strOperation As String = ""
    Private m_strSectionClientsideScript As String = ""
    Private m_strPagingAlphabet As String = ""
    Private m_strEnabledControls As String = ""
    Private m_strFormVariables As String = ""
    Private m_strInformativeMessage As String = ""
    'Added By Chakshuta H on 30th-Oct-2015
    Private m_strConcurrencyMessage As String = ""
    'Ended By Chakshuta H on 30th-Oct-2015
    Private m_strClientFunctionBody As String = ""
    Private m_strSetFocusOnControl As String = ""
    Private m_lngCurrentSubTagID As Long
    Private m_blnIgnoreSave As Boolean = False
    Private m_blnRefreshCL As Boolean = False
    Private m_blnExit As Boolean = False
    'Sub Tag Related constants
    Private Const TAB_ONCLICK_FUNCTION As String = "TabOnClick"
    Private Const m_strSubTagPagingFunction As String = "SubTagPage_Onclick"
    Private Const m_strSubTagSortFunction As String = "SubTagSortBy"
    Private Const m_strSubTagFilterFunction As String = "setSubTagFilter"
    Private Const m_strSubTagEditOnclick As String = "SubTagEditOnclick"
    'Sub Tag Related variables
    Private m_objSubTagGlobal As WebPages.Template.IGlobal
    Private m_objSubTagCLSQL As CommonEngine.CommonList.cSubTagCLSQL
    Private m_objSubTagCPSQL As CommonEngine.CommonPage.cSubTagCPSQL
    Private m_objSubTagAccess As WebPage.Templates.AccessRights
    Private m_objSubTagFilters As CommonEngine.CommonList.cSubTagDynamicFilters
    Private m_strSubTagFromCL As String = ""
    Private m_strSubTagPagingAlphabet As String = ""
    Private m_strSubTagSortBy As String = ""
    Private m_strSubTagSortOrder As String = ""
    Private m_strSubTagUserFilter As String = ""
    Private m_lngSubTagID As Long = 0
    Private m_blnIsSubTag As Boolean = False
    Private m_strSubTagCommonQueryString As String = ""
    Private m_strForeignKeyValue As String = ""
    Private m_strSubTagSectionTag As String = ""
    Private m_strSubTagDisplayType As String
    Private m_blnIsSingleColumnerTab As Boolean
    'Sub Tag CP properties
    Private Const m_strSubTagFormValidationFunctionHeaderSection As String = "SubTagValidateFormHeaderSection"
    Private Const m_strSubTagFormValidationFunctionFooterSection As String = "SubTagValidateFormFooterSection"
    Private Const m_strSubTagEnabledControlsFunctionHeaderSection As String = "SubTagEnableControlsHeaderSection"
    Private Const m_strSubTagEnabledControlsFunctionFooterSection As String = "SubTagEnableControlsFooterSection"
    Private m_strSubTagClientsideScript As String = ""
    Private m_strSubTagSectionClientsideScript As String = ""
    Private m_strSubTagexpandSectionsFunction As String = "expandSections"
    Private m_strSubTagEnabledControls As String = ""
    Private m_strSubTagClientFunctionBody As String = ""
    Private m_blnIgnoreDelete As Boolean = False
    Private m_strSubTagCLSectionClientsideScript As String = ""
    Private Const SUBTAG_USER_VALIDATIONS_HEADER_SECTION As String = "SubTag_UserValidations_HeaderSection"
    Private Const SUBTAG_USER_VALIDATIONS_FOOTER_SECTION As String = "SubTag_UserValidations_FooterSection"
    Private Const SUBTAG_FUNCTION_NAME_EXPAND_SECTION As String = "SubTag_ExpandSection"
    Private DELETION_CHECKBOX_NAME As String = "chkDelete"
    'Added By UmeshJ on 23 Nov 2004
    Private Const VALIDATE_FILTER As String = "validateTabFilter"
    'End
    Private WithEvents m_cObjMenu As WebPage.Templates.DynamicMenu
    Private WithEvents m_cObjPageCaption As WebPage.Templates.PageCaption
    Private WithEvents m_cObjHeaderFooter As WebPage.Templates.HeaderFooter
    Private WithEvents m_cObjPageLegends As WebPage.Templates.PageLegends
    Private WithEvents m_cObjSectionTitle As WebPage.Templates.SectionTitle
    Private WithEvents m_cobjTabs As WebPage.UI.cTabs
    Private m_objGeneral As EventHandlers.WAF_General
    Private WithEvents m_objGrid As WebPage.Templates.GenericGrid
    'Added By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
    Private m_intPagingNo As Integer = 1
    'End Addition By NileshD on 21 Sep 2005 ReqID -  WAF3_PB_10
    '==========================================================================================================
    'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
    '==========================================================================================================
    Protected m_strConnectionString As String = ""
    Protected m_intConnectionID As Integer
    '==========================================================================================================
    ' Addition End By : Ninad   Req Id : WAF3_PB_33
    '==========================================================================================================
    Private m_strSectionDivID As String = ""

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    'Reason   - For showing contetx menu in grid.
    '-------------------------------------------------------------------------------------------------------------
    Private m_blnConsiderContextMenu As Boolean = False
    Private m_strContextMenuJsFunction As String = ""
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
    '-------------------------------------------------------------------------------------------------------------
    Protected m_blnIsDesignMode As Boolean 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 29 May 2007
    'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
    Private m_strShortcutsAndFunction(0), m_strTagID(0) As String
    Dim blnIsSubTag(0) As Boolean
    'strKeyboardShortcutsAndFunctions : - This variable is provided for specifying shortcut for custom objects such as button, link etc in inherited page
    'developer must set this variable before plotting menu
    'This variable contains Keyboard shortcut followed by Event handler (with parameter if any)
    'Note: Specify supported shortcuts only.
    'e.g Alt + I, OpenMyPage1('www.yahoo.com'),Shift + F2, OpenMyPage2('www.rediffmail.com')  
    Protected strKeyboardShortcutsAndFunctions As String = ""
    'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
    'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
    Private m_blnHasMultiInsertSubTag As Boolean = False
    Private m_cObjSubTagCPSQL As CommonEngine.CommonPage.cCPSQL
    Private m_arrLstMultiInsertSubTagDeletionIDs As New ArrayList
    Dim m_sbMultiInsertSubTagEnabledControls As New System.Text.StringBuilder("")
    Private DELETION_CHECKBOX_NAME_MULTI_INSERT_SUBTAG As String = "chkDelete"
    Dim m_arrSubTagList As Long()
    'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
    Protected m_strControlListForNavAlert As String = "" 'Added By Ninad on 3 Mar 2008, SRID 19375 - Show alerts
    'Added By Chakshuta H on 30th-Oct-2015

    Protected m_strInsertInFormTag As String = "" 'Added On Behalf of NinadP By PushkarK On 17-Feb-2009 for providing the facility to insert attributes in form tag
    'Added By ShrikantB On 11-AUG-2010 For Concurrency Control
    Private blnMaintainConcurrency As Boolean




    Public Overridable Property MaintainConcurrency() As Boolean
        Get
            Return blnMaintainConcurrency
        End Get
        Set(ByVal value As Boolean)
            blnMaintainConcurrency = value
        End Set
    End Property
    'Addition End By ShrikantB On 11-AUG-2010 For Concurrency Control
    '==========================================================================================
    'Added By Abhijeet Nikam On 21-July-2010 For Transaction Control
    '==========================================================================================
    Private blnMaintainTransHistory As Boolean

    Public Overridable Property MaintainTransactionHistory() As Boolean
        Get
            Return blnMaintainTransHistory
        End Get
        Set(ByVal value As Boolean)
            blnMaintainTransHistory = value
        End Set
    End Property
    '===========================================================================================
    'Addition Ended By Abhijeet Nikam On 21-July-2010 For Transaction Control
    '===========================================================================================

    'Added By NikhilM 16 Nov 2010 for language support functionality
    Private m_bIsLangEnabled As Boolean = False
    'Addition End By NikhilM 16 Nov 2010 for language support functionality
    'Ended By Chakshuta H on 30th-Oct-2015

#End Region

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

    Protected Overridable Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' ***********************************************************************************
        ' Added  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
        ' ***********************************************************************************
        'Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(Session("intLoginID"))
        'If Value2 IsNot Nothing Then
        '    For i As Integer = 0 To Value2.Count - 1
        '        If Value2.Item(i) <> Session.SessionID Then
        '            CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(Session("intLoginID"))
        '            Session("intUserID") = Nothing
        '            Session.Abandon()
        '            'Response.Redirect("../../Default.aspx?Message=SESSIONEXPIRED")
        '        End If
        '    Next
        'End If
        ' ***********************************************************************************
        ' Ended  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
        ' ***********************************************************************************
        'Get the WhizGlobal object details
        ''Added By Vaijat K ON 28-Feb-2017 For Mastercard Security
      
        Call GetGlobalObject()
        'Added By NileshD on 15 Nov 2005
        '==========================================================================================================
        'Added By NinadP :	16 Nov 2006 : Requirement Tag - WAF3_PB_33 
        '==========================================================================================================
        GetConnection()
        '==========================================================================================================
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Put user code to initialize the page here
        Call GetParameters()
        'Get the Access Rights for the Tag / Sub tag
        Call GetAccessRights()
        'Get the Tag / Sub Tag Details from the Database
        Call GetCPSQL()
        'Added By Chakshuta H on 30th-Oct-2015
        Call WritePluginScriptBlock(True)
        'Ended By Chakshuta H on 30th-Oct-2015

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsSubTag")) <> "1" Then
            'For Master Tag
            If m_strOperation = CommonFunction.Constants.OPERATION_SAVE Then
                'Save the Data
                Dim strForeignKeyValue As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ForeignKeyValue"))
                Call Page_BeforeSave()
                'If the Ignore save is false then save the data
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''If m_blnIgnoreSave = False Then Call SaveData()
                'Added By ShrikantB On 26-JUL-2010 For Concurrency Control 
                If blnMaintainConcurrency = True Then
                    If m_objGlobal.ParentTagID <> 0 Then
                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("SubTagCurrentTimeStamp")).ToString <> Request(m_cObjCPSQL.Concurrency_UpdatedDate + "_Timestamp") Then
                            Response.Redirect("../General/CommonPage.aspx?MasterTagId=1836&FromWhere=1", True)
                        End If
                    Else
                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("CurrentTimeStamp")).ToString <> Request(m_cObjCPSQL.Concurrency_UpdatedDate + "_Timestamp") Then
                            Response.Redirect("../General/CommonPage.aspx?MasterTagId=1836&FromWhere=1", True)
                        End If
                    End If

                End If
                'Addition End By ShrikantB On 26-JUL-2010 For Concurrency Control 
                Call SaveData() 'modified by NinadP on 28 June 2009 IssueID-31439 
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
                Call Page_AfterSave()
                'In case of ADD_NEW mode redirect to the CommonList
                Call RedirectToCommonList()
            ElseIf m_strOperation = CommonFunction.Constants.OPERATION_DYNAMIC_LINK Then
                'Execute the Dynamic Action
                Call ExecuteDynamicLinkAction()
            End If
        End If
        If m_blnExit = False Then
            'Form and Page Controls
            Call PageDetails()
        End If
        'Clean up the objects from the memory
        Call MemoryCleanUp()
    End Sub
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
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================

        'Create the WhizGlobal class object
        If Not Request("ParentTagID") Is Nothing Then
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"), , CType(Request("ParentTagID"), Long))
            If CType(Request("ParentTagID"), Long) <> 0 Then m_blnIsSubTag = True
        Else
            MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        End If
        'Get the WhizGlobal object
        m_objGlobal = MyBase.GlobalObject
        m_blnIsDesignMode = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(CLng(IIf(m_objGlobal.ParentTagID <> 0, m_objGlobal.ParentTagID, m_objGlobal.TagID))).IsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 28 May 2007
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                    "GetPageSpecificGlobalObject")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cPageSpecificBehavior", _
                    "GetPageSpecificGlobalObject", ExtensionArgs)

            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Any Page specific changes......such as for Tag ID 27...get details for tag ID 32 (Project Information)
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.cPageSpecificBehavior.GetPageSpecificGlobalObject(m_objGlobal)
            Call GetPageSpecificGlobalObject(m_objGlobal)
            'Addition Ends
        End If
        'addition ends.
        'Apply Security
        MyBase.ApplySecurity(True, 2, True, True, True, m_objGlobal.TagID, m_objGlobal.ParentTagID)
        'added by ninad ' Requirement Tag :WAF3_PB_33 
        Call WhizForm_Init(m_objGlobal, m_intConnectionID)
        'addition end by ninad ' Requirement Tag :WAF3_PB_33 

        'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007 
        'check whether tag have any multi insert type subtag
        'bcoz in that case we need to plot only multi insert subtags
        If m_objGlobal.ParentTagID = 0 Then
            Dim objSubUITagMasters() As CommonEngines.HashTables.SubUITagMaster
            objSubUITagMasters = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(m_objGlobal.TagID)
            If Not objSubUITagMasters Is Nothing Then
                Dim objSubUITagMaster As CommonEngines.HashTables.SubUITagMaster
                For Each objSubUITagMaster In objSubUITagMasters
                    If objSubUITagMaster.IsMultiInsertSubTag Then
                        m_blnHasMultiInsertSubTag = True
                        objSubUITagMasters = Nothing
                        objSubUITagMaster = Nothing
                        Exit For
                    End If
                Next
            End If
        End If
        'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
    End Sub
    Protected Overridable Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        '=====================================================================
        ' Procedure Name        :	WebFormInit
        ' Purpose               :	This method will call the WhizForm_Init event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	Friday, Nov 11, 2003 
        ' Requirement Tag       :   WAF3_PB_33 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.WhizForm_Init(m_objGlobal, "FORM", m_intConnectionID)
        cobjEventHndlr = Nothing
    End Sub
    Private Sub GetConnection()
        '=====================================================================
        ' Procedure Name        :	GetConnection
        ' Purpose               :	This method will give call to the shared method GetConnectionID of cCLSQL class, 
        '                           if user has not set the value of m_intConnectionID. This method will return the ConnectionID, that will be set to the variable m_intConnectionID. 
        '                           If the value of this variable is not nothing then, connection string value will be retrieved from this connection id and will be assigned to the variable m_strConnectionString 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	Thursday, Nov 16, 2003 
        ' Requirement Tag       :   WAF3_PB_33 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        If m_intConnectionID = 0 Then
            'check weather it is a tag or subtag
            If m_objGlobal.ParentTagID = 0 Then
                m_intConnectionID = CommonEngines.CommonList.cCLSQL.GetConnectionID(CommonFunctions.General.CheckIsNothing(m_objGlobal.TagID))
            Else
                m_intConnectionID = CommonEngines.CommonList.cCLSQL.GetConnectionID(CommonFunctions.General.CheckIsNothing(m_objGlobal.ParentTagID))
            End If
        End If
        If m_intConnectionID <> 0 Then
            m_strConnectionString = CommonFunctions.General.CheckIsNothing(CommonEngines.HashTables.GetHashTableObject.GetHashTableConnection(CommonFunctions.General.CheckIsNothing(m_intConnectionID)))
        End If
    End Sub
    Protected Overridable Sub GetPageSpecificGlobalObject(ByRef objGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.cPageSpecificBehavior.GetPageSpecificGlobalObject(objGlobal)
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
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If Not Request("PagingAlphabet") Is Nothing Then m_strPagingAlphabet = CommonFunctions.General.CheckIsNothing(Microsoft.VisualBasic.Strings.Replace(Replace(Microsoft.VisualBasic.Strings.Replace(Request("PagingAlphabet").ToString, CommonFunction.Constants.PAGING_SPECIAL_CHAR_AND, "&"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_HASH, "#"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")) 'WAF3_PB_38     
        ' ***********************************************************************************
        ' Modified Apr 10,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************

        If Not Request("PagingAlphabet") Is Nothing Then m_strPagingAlphabet = CommonFunctions.General.CheckIsNothing(Microsoft.VisualBasic.Strings.Replace(Replace(Microsoft.VisualBasic.Strings.Replace(HttpUtility.HtmlEncode(Request("PagingAlphabet").ToString), CommonFunction.Constants.PAGING_SPECIAL_CHAR_AND, "&"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_HASH, "#"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")) 'WAF3_PB_38     
        ' ***********************************************************************************
        ' Modified Apr 10,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
        'FromCL
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If Not Request("FromCL") Is Nothing Then m_strFromCL = Request("FromCL").ToString.Trim
        If Not Request("FromCL") Is Nothing Then m_strFromCL = HttpUtility.HtmlEncode(Request("FromCL").ToString.Trim)
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
        'Mode
        ''Commented And Added By Chakshuta H on 30th-Oct-2015
        ''If Not Request("Mode") Is Nothing Then m_strMode = Request("Mode").ToString.Trim.ToUpper
        If Not Request("Mode") Is Nothing Then m_strMode = HttpUtility.HtmlEncode(Request("Mode").ToString.Trim.ToUpper)
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
        If Not Request("Operation") Is Nothing Then m_strOperation = Request("Operation").ToString.Trim.ToUpper
        'Sub Tag Details**********************************
        If Not Request("ForeignKeyValue") Is Nothing Then m_strForeignKeyValue = Request("ForeignKeyValue").ToString
        If Not Request("SubTagID") Is Nothing Then m_lngCurrentSubTagID = CType(Request("SubTagID"), Long)
        If Not Request("SubTagFromCL") Is Nothing Then m_strSubTagFromCL = Request("SubTagFromCL").ToString.Trim
        If Not Request("SubTagPagingAlphabet") Is Nothing Then m_strSubTagPagingAlphabet = CommonFunctions.General.CheckIsNothing(Microsoft.VisualBasic.Strings.Replace(Replace(Microsoft.VisualBasic.Strings.Replace(Request("SubTagPagingAlphabet").ToString, CommonFunction.Constants.PAGING_SPECIAL_CHAR_AND, "&"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_HASH, "#"), CommonFunction.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")) 'WAF3_PB_38     
        If Not Request("SubTagSortBy") Is Nothing Then m_strSubTagSortBy = Request("SubTagSortBy").ToString
        If Not Request("SubTagSortOrder") Is Nothing Then m_strSubTagSortOrder = Request("SubTagSortOrder").ToString
        'Execute Dynamic Action
        If CommonFunction.General.CheckIsNothing(Request("TAB_DYNAMIC_ACTION"), "") = "1" Then
            'Action executed
            Dim strMsgActionExecuted As String = MyBase.GetResourceString("ACTION_EXECUTED")
            m_strInformativeMessage = "window.status='" + strMsgActionExecuted + "';"
        End If
        'If CommonFunction.General.CheckIsNothing(Request.QueryString("IsListPageLink")) <> "1" Then
        m_strQuerystringDefaultParameters = CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
        'Added By UmeshJ on 5th July 2004
        '_____________Consider the Master Tags Default Query string Filter parameters while refreshing the master page
        If m_blnIsSubTag = True Then
            Call GetQueryStringDefaultParametersForParentTag()
            m_strQuerystringDefaultParameters += m_strParentTagQuerystringDefaultParameters
        End If
        'End of Addition
        'Added By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10
        If Not Request("PagingNumber") Is Nothing Then
            m_intPagingNo = CType(CommonFunctions.General.CheckIsNothing(Request("PagingNumber"), "1"), Integer)
        End If
        'End Of Addition By NileshD on 22 Sep 2005 ReqID -  WAF3_PB_10

    End Sub
    Private Sub GetQueryStringDefaultParametersForParentTag()
        '=====================================================================
        ' Procedure Name        :	GetQueryStringDefaultParametersForParentTag
        ' Purpose               :	Get the Master Tags Default Query string Filter parameters while refreshing the master page
        ' Description           :	Get the Master Tags Default Query string Filter parameters while refreshing the master page
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	July 05, 2004
        ' Revisions             :
        '=====================================================================
        Dim tmpParentTagID As Long = m_objGlobal.ParentTagID
        Dim tmpTagID As Long = m_objGlobal.TagID
        m_objGlobal.ParentTagID = 0
        m_objGlobal.TagID = tmpParentTagID
        m_strParentTagQuerystringDefaultParameters = CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
        m_objGlobal.ParentTagID = tmpParentTagID
        m_objGlobal.TagID = tmpTagID
    End Sub
    Protected Overridable Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New CommonEngine.CommonPage.cCPSQL(m_objGlobal)
    End Function

    Private Sub GetCPSQL()
        '=====================================================================
        ' Procedure Name        :	GetCPSQL
        ' Purpose               :	Get the Page Details from the database
        ' Description           :	This method access the cCPSQL class to retrieve 
        '                           the page details required to plot the Common Page 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        If m_strNewPK.Trim = "" And m_cObjCPSQL Is Nothing Then
            If m_objGlobal.ParentTagID = 0 Then
                'Parent Tag = 0....get settings for the Master Page
                'Code Modified:RajeshB          28th Jan 2005
                'CommonPage as an Object
                m_cObjCPSQL = InitCPSQL()
                'Modification ends
                '==========================================================================================================
                'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
                '==========================================================================================================
                m_cObjCPSQL.ConnectionString = m_strConnectionString
                '==========================================================================================================
                ' Addition End By : Ninad   Req Id : WAF3_PB_33
                '==========================================================================================================

                'If applied then get the Advance filter from the session variable  forh the Tag ID and pass it to cCPSQL class
                Dim strAdvanceFilter As String = ""
                If m_objGlobal.ParentTagID = 0 Then
                    strAdvanceFilter = CommonFunction.General.CheckIsNothing(Session("AdvanceFilter" + m_objGlobal.TagID.ToString))
                    If strAdvanceFilter.Trim <> "" Then strAdvanceFilter = " and (" + strAdvanceFilter + ")"
                End If
                m_cObjCPSQL.AdvancedFilter = strAdvanceFilter

            Else
                'Code Modified:RajeshB          28th Jan 2005
                'CommonPage as an Object
                'The tag is Details Tag....get details for the Sub Tag
                m_cObjCPSQL = InitSubTagCPSQL(m_objGlobal) 'New CommonEngine.CommonPage.cSubTagCPSQL(m_objGlobal)

            End If
        Else
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''m_strMode = ""
            If m_strNewPK.Trim = "" Then 'Added by Ninad on 11 Aug 2009 IssueID-32383 if PK is blank then it should be always add new mode
                m_strMode = "ADD_NEW"
            Else
                m_strMode = ""
            End If
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            m_cObjCPSQL.PrimaryKeyValue = m_strNewPK.Trim
        End If

        With m_cObjCPSQL
            'MODE
            If m_strMode = "ADD_NEW" Then
                .IsEditMode = False
            Else
                .IsEditMode = True
            End If
            .GetSettings()
            'Added By Chakshuta H on 30th-Oct-2015
            blnMaintainConcurrency = m_cObjCPSQL.MaintainConcurrency 'Added By ShrikantB On 11-AUG-2010 For Concurrency Control
            blnMaintainTransHistory = m_cObjCPSQL.MaintainTransHistory 'Added By Abhijeet Nikam On 11 -AUG-2010 For Transaction History
            'Ended By Chakshuta H on 30th-Oct-2015

        End With

        'Consider Role Level Access flag for the Page
        If m_cObjCPSQL.ApplyRoleLevelAccess = False Then
            'if the Role Level Access flag is false then set all access rights as TRUE
            m_objAccess.Add = True
            m_objAccess.Delete = True
            m_objAccess.Edit = True
            m_objAccess.View = True
        Else
            Call CheckPageAccess()
        End If
        'WAF3_PB_26
        Dim strPKToken As String = ValidateToken()

        'Common Query String
        'Modified By NileshD on 26 Sep 2005 WAF3_PB_10
        'Added PagingNumber parameter 
        'WAF3_PB_26
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''m_strCommonQueryString = "Mode=" + m_strMode + "&" + m_cObjCPSQL.PrimaryKey + "=" + m_cObjCPSQL.PrimaryKeyValue + strPKToken + "&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&AccessFirstTime=0&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&PagingNumber=" + m_intPagingNo.ToString + m_strQuerystringDefaultParameters 'WAF3_PB_26
        ' ***********************************************************************************
        ' Modified Apr 10,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************

        m_strCommonQueryString = "Mode=" + m_strMode + "&" + m_cObjCPSQL.PrimaryKey + "=" + m_cObjCPSQL.PrimaryKeyValue + strPKToken + "&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&AccessFirstTime=0&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&PagingNumber=" + m_intPagingNo.ToString + m_strQuerystringDefaultParameters 'WAF3_PB_26
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        'End Of Modification By NileshD on 26 Sep 2005 WAF3_PB_10
        'm_strCommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&FromCL=1" + m_strQuerystringDefaultParameters
    End Sub
    Private Sub GetCPSQL_MultiInsertSubTag()
        '=====================================================================
        ' Procedure Name        :	GetCPSQL_MultiInsertSubTag
        ' Purpose               :	Get the Page Details from the database for multi insert type subtag
        ' Description           :	This method access the cCPSQL class to retrieve 
        '                           the page details required to plot the Common Page 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Req ID                :   WAF3_PB_55
        ' Author                :	NinadP
        ' Created               :	Nov 5, 2007
        ' Revisions             :
        '=====================================================================

        m_objSubTagCPSQL = InitSubTagCPSQL(m_objGlobal)
        With m_objSubTagCPSQL
            .GetSettings()
            .ConnectionString = m_strConnectionString
        End With
        'Consider Role Level Access flag for the Page
        If m_objSubTagCPSQL.ApplyRoleLevelAccess = False Then
            'if the Role Level Access flag is false then set all access rights as TRUE
            m_objAccess.Add = True
            m_objAccess.Delete = True
            m_objAccess.Edit = True
            m_objAccess.View = True
        Else
            Call CheckPageAccess()
        End If
    End Sub

    Private Function ValidateToken() As String
        'WAF3_PB_26
        ValidateToken = ""
        If m_cObjCPSQL.PKToken_IsValid = True Then
            ValidateToken = "&PKToken=" + m_cObjCPSQL.PKToken_Value
        Else
            'Insert Record into the log table
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess(m_cObjCPSQL.PageCaption, m_objGlobal.TagID, m_objGlobal.ParentTagID, m_cObjCPSQL.PrimaryKey, m_cObjCPSQL.PrimaryKeyValue)
            'Security Alert...Token check failed
            Call MemoryCleanUp()
            'Redirect to User Friendly Message Page
            Dim strRedirectPagePath As String = "" & strFormPage & "?MasterTagId=1836&FromWhere=1"
            Response.Redirect(strRedirectPagePath)
        End If
    End Function

    Private Sub CheckPageAccess()
        '=====================================================================
        ' Procedure Name        :	CheckPageAccess
        ' Purpose               :	Check if the user has Page Access (A,E,D or V)
        ' Description           :	If user do not have access then redirect to the invalid access page 
        ' Parameters Passed     :   None
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Saturday, November 06, 2004
        ' Revisions             :
        '=====================================================================
        If m_objAccess.Access = False Then
            'Write the Log in the database
            Call CommonFunctions.General.WriteLog_InvalidAccess(m_cObjCPSQL.PageCaption, m_objGlobal.TagID, m_objGlobal.ParentTagID)
            'Clean the objects from memory
            Call MemoryCleanUp()
            'Rediret to the Message page: EXIT
            Dim strRedirectPagePath As String = "" & strFormPage & "?MasterTagId=" + CommonFunctions.Constants.TAG_INVALID_ACCESS.ToString + "&FromWhere=1"
            '_________Modified By UmeshJ on 19 Nov 2004______________Issue ID : 14067
            'HttpContext.Current.Server.Transfer(strRedirectPagePath)
            Response.Redirect(strRedirectPagePath)
            'End of modifications
        End If
    End Sub

    Private Sub SaveData()
        '=====================================================================
        ' Procedure Name        :	SaveData
        ' Purpose               :	Save the Page Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 10, 2003 
        ' Revisions             :
        '=====================================================================
        If m_blnIsSubTag = False Then
            'Save the Master Tag Data
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''Call SaveTagData()
            If m_blnIgnoreSave = False Then Call SaveTagData() 'modified by NinadP on 28 June 2009 IssueID-31439 
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
            'After saving tag data, save multiinsert subtags data
            If m_blnHasMultiInsertSubTag Then
                Save_MultiInsert_SubTagData()
            End If
            'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
            If m_cObjCPSQL.SmartNavigation_IsEnabled = True Then Call RefreshCL() 'WAF3_PB_41 UJ 20 Mar 2007
        Else
            'Save the Sub Tag Data
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''Call SaveSubTagData()
            If m_blnIgnoreSave = False Then Call SaveSubTagData() 'modified by NinadP on 28 June 2009 IssueID-31439 
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        End If
    End Sub
    Protected Overridable Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New CommonEngine.CommonPage.cDataManagement(m_objGlobal)
    End Function
    Private Sub RefreshCL()
        'WAF3_PB_41 UJ 20 Mar 2007
        'Refresh Common List Page after Saving the current record 
        Response.Write("<script language=javascript>")
        Response.Write("parent.frames['whizFRMECL'].location.href=""" + strListPage + "?" + m_strCommonQueryString + "&RefreshList=1" + """")
        Response.Write("</script>")
    End Sub
    Private Sub SaveTagData()
        '=====================================================================
        ' Procedure Name        :	SaveTagData
        ' Purpose               :	Save the Page Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 10, 2003 
        ' Revisions             :
        '=====================================================================
        Dim IsEditMode As Boolean = True
        'Mode ADD or EDIT
        If m_strMode = "ADD_NEW" Then IsEditMode = False
        'Code Modified:RajeshB      28th Jan 2005
        'Purpose: CommonPage as an Object
        Dim objSave As CommonEngine.CommonPage.cDataManagement
        objSave = InitDataManagement()
        'Modification ends
        With objSave
            'Main Properties
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .PrimaryKey = m_cObjCPSQL.PrimaryKey
            .PrimaryKeyValue = m_cObjCPSQL.PrimaryKeyValue
            .TableName = m_cObjCPSQL.TableName
            'Added By Chakshuta H on 30th-Oct-2015
            '-----------------------------------------------------------------------
            'Added By Abhijeet Nikam On 21 July 2010 For Transaction History
            '-----------------------------------------------------------------------
            .MaintainTransHistory = blnMaintainTransHistory
            '-----------------------------------------------------------------------
            'Addition Ended By Abhijeet Nikam  On 21 July 2010 For Transaction History
            '------------------------------------------------------------------------
            'Ended By Chakshuta H on 30th-Oct-2015

            'Audit Trail Related Properties
            .MaintainAuditTrail = m_cObjCPSQL.MaintainAuditTrail
            .AuditTrialField_CreatedBy = m_cObjCPSQL.AuditTrialField_CreatedBy
            .AuditTrialField_CreatedDate = m_cObjCPSQL.AuditTrialField_CreatedDate
            .AuditTrialField_UpdatedBy = m_cObjCPSQL.AuditTrialField_UpdatedBy
            .AuditTrialField_UpdatedDate = m_cObjCPSQL.AuditTrialField_UpdatedDate
            'Added By Chakshuta H on 30th-Oct-2015
            '-----------------------------------------------------------------------------
            'Added By ShrikantB On 21-JUL-2010 For Concurrency Control
            '-----------------------------------------------------------------------------
            .MaintainConcurrency = blnMaintainConcurrency
            .Concurrency_UpdatedDate = m_cObjCPSQL.Concurrency_UpdatedDate
            .Concurrency_UpdatedBy = m_cObjCPSQL.Concurrency_UpdatedBy
            .CurrentTimeStampValue = Request(m_cObjCPSQL.Concurrency_UpdatedDate + "_Timestamp")
            '-----------------------------------------------------------------------------
            'Addition End By ShrikantB On 21-JUL-2010 For Concurrency Control
            '-----------------------------------------------------------------------------
            'Ended By Chakshuta H on 30th-Oct-2015

            'Set Indentity On always
            .IsIdentityOn = m_cObjCPSQL.IsIdentityOn
            'Pass the controls in the Form collection hash table
            .SaveData(MyBase.GetFormCollectionHashTable, IsEditMode)
            m_strNewPK = .PrimaryKeyValue
            'Added By Chakshuta H on 30th-Oct-2015
            If (objSave.ShowConcurrencyMsg = False AndAlso blnMaintainConcurrency = True) Then
                m_cObjCPSQL.CurrentTimeStampValue = objSave.CurrentTimeStampValue
            End If
            'Ended By Chakshuta H on 30th-Oct-2015

        End With
        objSave = Nothing
        'Message : Data saved successfully
        Dim strMsgRecordsSaved As String = MyBase.GetResourceString("DATA_SAVED")
        m_strInformativeMessage = "window.status='" + strMsgRecordsSaved + "';"
        'Added By Chakshuta H on 30th-Oct-2015
        ''-----------------------------------------------------------------------------
        ''Added By ShrikantB On 21-JUL-2010 For Concurrency Control
        ''-----------------------------------------------------------------------------
        'If objSave.ShowConcurrencyMsg Then
        '    strMsgRecordsSaved = MyBase.GetResourceString("CONCURRENCY_MSG")
        '    strMsgRecordsSaved = strMsgRecordsSaved.Replace("<USER_NAME>", objSave.Concurrency_UpdatedUser)
        '    m_strConcurrencyMessage = "window.status='" + strMsgRecordsSaved + "';"
        '    m_strInformativeMessage = "window.status='" + strMsgRecordsSaved + "';"
        'End If
        ''-----------------------------------------------------------------------------
        ''Addition End By ShrikantB On 21-JUL-2010 For Concurrency Control
        ''-----------------------------------------------------------------------------

        'Ended By Chakshuta H on 30th-Oct-2015

        'Added By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If m_cObjCPSQL.ShowRecordSavedMsg Then
        ''    If CommonFunction.General.CheckIsNothing(Request("SubOperation")) <> "ADD" AndAlso CommonFunction.General.CheckIsNothing(Request("SubOperation")) <> "CLOSE" Then
        ''        m_strInformativeMessage += " alert('" + strMsgRecordsSaved + "');"
        ''    End If
        ''End If
        '-----------------------------------------------------------------------------
        'Modified By ShrikantB On 22-JUL-2010 For Concurrency Control
        '-----------------------------------------------------------------------------
        If m_cObjCPSQL.ShowRecordSavedMsg AndAlso objSave.ShowConcurrencyMsg = False Then
            If CommonFunction.General.CheckIsNothing(Request("SubOperation")) <> "ADD" AndAlso CommonFunction.General.CheckIsNothing(Request("SubOperation")) <> "CLOSE" Then
                m_strInformativeMessage += " ShowWhizAlert('" + strMsgRecordsSaved + "');" 'Modified by Ninad for integrating DPopup 
            End If
        Else
            'If objSave.ShowConcurrencyMsg Then
            '    m_strConcurrencyMessage += " alert('" + strMsgRecordsSaved + "');"
            'End If
        End If
        '-----------------------------------------------------------------------------
        'Modification End By ShrikantB On 22-JUL-2010 For Concurrency Control
        '-----------------------------------------------------------------------------
        'End Addition By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
        objSave = Nothing
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        'End Addition By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
    End Sub
    Protected Overridable Function InitSubTagDataManagement() As CommonEngine.CommonPage.cSubTagDataManagement
        If Not m_objSubTagGlobal Is Nothing Then
            Return New CommonEngine.CommonPage.cSubTagDataManagement(m_objSubTagGlobal)
        Else
            Return New CommonEngine.CommonPage.cSubTagDataManagement(m_objGlobal)
        End If
    End Function
    Private Sub SaveSubTagData()
        '=====================================================================
        ' Procedure Name        :	SaveSubTagData
        ' Purpose               :	Save the Page Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 10, 2003 
        ' Revisions             :
        '=====================================================================
        Dim IsEditMode As Boolean = True
        'Mode ADD or EDIT
        If m_strMode = "ADD_NEW" Then IsEditMode = False
        'Code Modified:RajeshB          28 Jan 2005
        'Purpose: CP as an Object
        Dim objSave As CommonEngine.CommonPage.cSubTagDataManagement
        objSave = InitSubTagDataManagement() 'New CommonEngine.CommonPage.cSubTagDataManagement(m_objGlobal)
        'Modification Ends
        With objSave
            'Main Properties
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .PrimaryKey = m_cObjCPSQL.PrimaryKey
            .PrimaryKeyValue = m_cObjCPSQL.PrimaryKeyValue
            .TableName = m_cObjCPSQL.TableName
            'Added By Chakshuta H on 30th-Oct-2015
            '-----------------------------------------------------------------------
            'Added By Abhijeet Nikam On 21 July 2010 For Transaction History
            '-----------------------------------------------------------------------
            .MaintainTransHistory = blnMaintainTransHistory
            '-----------------------------------------------------------------------
            'Addition Ended By Abhijeet Nikam  On 21 July 2010 For Transaction History
            '------------------------------------------------------------------------
            'Ended By Chakshuta H on 30th-Oct-2015

            'Audit Trail Related Properties
            .MaintainAuditTrail = m_cObjCPSQL.MaintainAuditTrail
            .AuditTrialField_CreatedBy = m_cObjCPSQL.AuditTrialField_CreatedBy
            .AuditTrialField_CreatedDate = m_cObjCPSQL.AuditTrialField_CreatedDate
            .AuditTrialField_UpdatedBy = m_cObjCPSQL.AuditTrialField_UpdatedBy
            .AuditTrialField_UpdatedDate = m_cObjCPSQL.AuditTrialField_UpdatedDate
            'Added By Chakshuta H on 30th-Oct-2015
            '-----------------------------------------------------------------------------
            'Added By ShrikantB On 21-JUL-2010 For Concurrency Control
            '-----------------------------------------------------------------------------
            .MaintainConcurrency = blnMaintainConcurrency
            .Concurrency_UpdatedDate = m_cObjCPSQL.Concurrency_UpdatedDate
            .Concurrency_UpdatedBy = m_cObjCPSQL.Concurrency_UpdatedBy
            .CurrentTimeStampValue = Request(m_cObjCPSQL.Concurrency_UpdatedDate + "_Timestamp")
            '-----------------------------------------------------------------------------
            'Addition End By ShrikantB On 21-JUL-2010 For Concurrency Control
            '-----------------------------------------------------------------------------
            'Ended By Chakshuta H on 30th-Oct-2015

            'Set Indentity On always
            .IsIdentityOn = m_cObjCPSQL.IsIdentityOn
            'Pass the controls in the Form collection hash table
            .SaveData(MyBase.GetFormCollectionHashTable, IsEditMode)
            m_strNewPK = .PrimaryKeyValue
        End With
        objSave = Nothing
        'Message : Data saved successfully
        Dim strMsgRecordsSaved As String = MyBase.GetResourceString("DATA_SAVED")
        m_strInformativeMessage = "window.status='" + strMsgRecordsSaved + "';"
        'Added By Chakshuta H on 30th-Oct-2015
        '-----------------------------------------------------------------------------
        'Added By ShrikantB On 21-JUL-2010 For Concurrency Control
        '-----------------------------------------------------------------------------
        'If objSave.ShowConcurrencyMsg Then
        '    strMsgRecordsSaved = MyBase.GetResourceString("CONCURRENCY_MSG")
        '    strMsgRecordsSaved = strMsgRecordsSaved.Replace("<USER_NAME>", objSave.Concurrency_UpdatedUser)
        '    m_strConcurrencyMessage = "window.status='" + strMsgRecordsSaved + "';"
        '    m_strInformativeMessage = "window.status='" + strMsgRecordsSaved + "';"
        'End If

        'If objSave.ShowConcurrencyMsg Then
        '    m_strConcurrencyMessage += " alert(""" + strMsgRecordsSaved + """);"
        '    m_blnRedirectToCL = False
        'End If
        'objSave = Nothing
        '-----------------------------------------------------------------------------
        'Addition End By ShrikantB On 21-JUL-2010 For Concurrency Control
        '-----------------------------------------------------------------------------

        'Ended By Chakshuta H on 30th-Oct-2015

    End Sub
    Private Sub Save_MultiInsert_SubTagData()
        '=====================================================================
        ' Procedure Name        :	Save_MultiInsert_SubTagData
        ' Purpose               :	Save the Multi Insert Subtag Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Req ID                :   WAF3_PB_55
        ' Author                :	NinadP
        ' Created               :	November 5, 2007 
        ' Revisions             :
        '=====================================================================
        Dim objSave As CommonEngine.CommonPage.cSubTagDataManagement
        Dim objSubUITagMasters() As CommonEngines.HashTables.SubUITagMaster
        objSubUITagMasters = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(m_objGlobal.TagID)
        Dim objSubUITagMaster As CommonEngines.HashTables.SubUITagMaster
        'iterate the loop for each multi insert type sub tag
        m_blnRedirectToCL = False
        For Each objSubUITagMaster In objSubUITagMasters
            If objSubUITagMaster.IsMultiInsertSubTag Then
                MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
                m_objSubTagGlobal = MyBase.GlobalObject
                m_objSubTagGlobal.ParentTagID = objSubUITagMaster.TagID
                m_objSubTagGlobal.TagID = objSubUITagMaster.SubTagID
                SubTag_GetAccessRights()
                'Destroy object if exists
                If Not m_objSubTagCPSQL Is Nothing Then m_objSubTagCPSQL = Nothing
                m_objSubTagCPSQL = InitSubTagCPSQL(m_objSubTagGlobal)
                m_objSubTagCPSQL.ConnectionString = m_strConnectionString
                m_strForeignKeyValue = m_strNewPK
                With m_objSubTagCPSQL
                    .ForeignKeyValue = m_strForeignKeyValue
                    .IsMultiInsertSubTag = True
                    .GetSettings()
                End With
                'Consider Role Level Access flag for the Page
                If m_objSubTagCPSQL.ApplyRoleLevelAccess = False Then
                    'if the Role Level Access flag is false then set all access rights as TRUE
                    m_objSubTagAccess.Add = True
                    m_objSubTagAccess.Delete = True
                    m_objSubTagAccess.Edit = True
                    m_objSubTagAccess.View = True
                End If

                If m_strOperation = CommonFunction.Constants.OPERATION_SAVE Then
                    If m_objSubTagAccess.Delete Then
                        'Get the deletion ID for subtag
                        Dim strDeletionID As String = ""
                        Dim strTemp As String = ""
                        Dim strDeletionIDs As String()
                        If Not Request.Form(m_objSubTagCPSQL.PrimaryKey) Is Nothing Then
                            'get the primary keys of all the record on page
                            strDeletionIDs = CommonFunctions.General.CheckIsNothing(Request.Form(m_objSubTagCPSQL.PrimaryKey)).Split(","c)
                        End If

                        'Modified By - PushkarK On 13-Mar-2008 For Whizible Sem Issue ID - 19646
                        'Modification - Added single-quote before and after the Primary Key as well as Foreign Key
                        'because those can be of data type 'Unique Identifier'
                        If Not strDeletionIDs Is Nothing Then
                            For Each strTemp In strDeletionIDs
                                strTemp = strTemp.Trim
                                If strTemp <> "" Then
                                    If strDeletionID.Trim <> "" Then
                                        strDeletionID += ",'" + strTemp + "'"
                                    Else
                                        strDeletionID += "'" + strTemp + "'"
                                    End If
                                End If
                            Next
                        End If
                        'get only those ID which are on not in form and but in DB
                        'means such kind of records are deleted by user
                        If strDeletionID.Trim <> "" Then
                            strDeletionID = "SELECT " + m_objSubTagCPSQL.PrimaryKey + " FROM " + objSubUITagMaster.TableName + " WHERE " + m_objSubTagCPSQL.ForeignKey + " = '" + m_strForeignKeyValue + "' AND " + m_objSubTagCPSQL.PrimaryKey + " NOT IN (" + strDeletionID + ")"
                        Else
                            'All the records are deleted by user
                            strDeletionID = "SELECT " + m_objSubTagCPSQL.PrimaryKey + " FROM " + objSubUITagMaster.TableName + " WHERE " + m_objSubTagCPSQL.ForeignKey + " = '" + m_strForeignKeyValue + "'"
                        End If

                        Dim drDeletionID As IDataReader = CommonFunction.Data.GetDataReader(strDeletionID, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
                        strDeletionID = ""
                        Do While drDeletionID.Read()
                            If strDeletionID.Trim <> "" Then
                                strDeletionID += ",'" + drDeletionID(m_objSubTagCPSQL.PrimaryKey).ToString + "'"
                            Else
                                strDeletionID += "'" + drDeletionID(m_objSubTagCPSQL.PrimaryKey).ToString + "'"
                            End If
                        Loop
                        'Modification Ends By - PushkarK On 13-Mar-2008 For Whizible Sem Issue ID - 19646
                        CommonFunctions.Data.DisposeDataReader(drDeletionID)
                        'Add SubtagID and its deletion ID list to array list
                        'it is required to delete records while plotting grid
                        m_arrLstMultiInsertSubTagDeletionIDs.Add(objSubUITagMaster.SubTagID)
                        m_arrLstMultiInsertSubTagDeletionIDs.Add(strDeletionID)
                    End If
                End If

                'check whether there is any row for sub tag
                If Not Request.Form(m_objSubTagCPSQL.PrimaryKey) Is Nothing Then
                    Dim strPrimaryKeyArray As String() = Request.Form(m_objSubTagCPSQL.PrimaryKey).Split(","c)
                    Dim intNoOfRows As Integer = strPrimaryKeyArray.Length
                    Dim intIndex As Integer
                    Dim intSaveIndex As Integer = 0
                    For intIndex = 1 To intNoOfRows
                        'if ther is primary key for the row then it is in update mode
                        If intIndex <= strPrimaryKeyArray.Length Then
                            m_objSubTagCPSQL.PrimaryKeyValue = strPrimaryKeyArray(intIndex - 1)
                        Else
                            m_objSubTagCPSQL.PrimaryKeyValue = ""
                        End If
                        If (Not m_objSubTagAccess.Edit) And m_objSubTagCPSQL.PrimaryKeyValue.Trim <> "" Then
                            'get the next record
                            Continue For
                        End If
                        intSaveIndex += 1
                        'Execute Before Save event
                        'Added By Chakshuta H on 30th-Oct-2015
                        m_blnIgnoreSave = False 'Added By Ninad on 28 June 2009 IssueID-31439 
                        'Ended By Chakshuta H on 30th-Oct-2015

                        Call SubTag_CPPage_BeforeSave(True)
                        If m_blnIgnoreSave = False Then
                            'Save Data 
                            Dim IsEditMode As Boolean = True
                            If CommonFunction.General.CheckIsNothing(m_objSubTagCPSQL.PrimaryKeyValue) = "" Then IsEditMode = False
                            objSave = InitSubTagDataManagement()
                            With objSave
                                .ConnectionString = m_strConnectionString
                                .PrimaryKey = m_objSubTagCPSQL.PrimaryKey
                                .PrimaryKeyValue = m_objSubTagCPSQL.PrimaryKeyValue
                                .TableName = m_objSubTagCPSQL.TableName
                                .MaintainAuditTrail = m_objSubTagCPSQL.MaintainAuditTrail
                                .AuditTrialField_CreatedBy = m_objSubTagCPSQL.AuditTrialField_CreatedBy
                                .AuditTrialField_CreatedDate = m_objSubTagCPSQL.AuditTrialField_CreatedDate
                                .AuditTrialField_UpdatedBy = m_objSubTagCPSQL.AuditTrialField_UpdatedBy
                                .AuditTrialField_UpdatedDate = m_objSubTagCPSQL.AuditTrialField_UpdatedDate
                                .IsIdentityOn = m_objSubTagCPSQL.IsIdentityOn
                                .ForeignKeyValue = m_strForeignKeyValue
                                'Added By Chakshuta H on 30th-Oct-2015
                                .MaintainTransHistory = m_objSubTagCPSQL.MaintainTransHistory 'Added By Abhijeet Nikam On 12 Aug 2010 For Transaction History 
                                'Ended By Chakshuta H on 30th-Oct-2015
                                'Apply Security for Sub Tag Master to get the controls for it
                                MyBase.ApplySecurity(intSaveIndex - 1, True, 2, , , True, m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID)
                                .SaveData(MyBase.GetFormCollectionHashTable, IsEditMode)
                            End With
                            objSave = Nothing
                        End If
                        'Execute After Save event
                        Call SubTag_CPPage_AfterSave()
                    Next
                End If
            End If
        Next
        objSubUITagMasters = Nothing
        objSubUITagMaster = Nothing
    End Sub
    Private Sub RedirectToCommonList()
        '=====================================================================
        ' Procedure Name        :	RedirectToCommonList
        ' Purpose               :	This method will be called for SAVE operation
        ' Description           :	It will redirect control to the CommonList page
        '                           if the mode is ADD_NEW and the CommonPage is 
        '                           accessed from the CommonList
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 29, 2003 
        ' Revisions             :
        '=====================================================================
        Dim strSubOperation As String = CommonFunction.General.CheckIsNothing(Request("SubOperation"))
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If strSubOperation.ToUpper = "CLOSE" Then
        If strSubOperation.ToUpper = "CLOSE" AndAlso Not m_blnHasMultiInsertSubTag Then 'Modified By Ninad on 17 March 2009 IssueID-29406
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            Call MemoryCleanUp()
            Call CloseWindow()
            m_blnExit = True
            Exit Sub
        End If

        If m_blnIsSubTag = False And m_strOperation = CommonFunction.Constants.OPERATION_SAVE And m_strFromCL = "1" Then
            '##MASTER TAG....
            If m_strMode = "ADD_NEW" Then
                'For INSERT mode
                If m_strNewPK.Trim <> "" And (m_cObjCPSQL.HasSubTags = True Or m_blnRedirectToCL = False) Then
                    'HAS SUB TAGS
                    If strSubOperation = "ADD" Then
                        '##SAVE n ADD
                        'The link is Save and Add.....save the record and open the window in ADD_NEW mode
                        Call AfterSaveGetCPSQL()
                    Else
                        Call GetCPSQL()
                    End If
                Else
                    'NO SUB TAGS
                    If m_cObjCPSQL.AddMode_UIPageOpenInWindow = False Then
                        'NOT OPENED IN NEW WINDOW
                        If strSubOperation = "ADD" Then
                            '##SAVE n ADD
                            'The link is Save and Add.....save the record and open the window in ADD_NEW mode
                            Call AfterSaveGetCPSQL()
                        Else
                            'Redirect to CommonList 
                            '_________Modified By UmeshJ on 19 Nov 2004______________Issue ID : 14067
                            'Server.Transfer("" & strListPage & "?" + m_strCommonQueryString, False)
                            '########### WAF3_PB_41 Uj 20 Mar 2007
                            If m_cObjCPSQL.SmartNavigation_IsEnabled = False Then
                                'Added By Ninad on 6 Feb 2008, it redirects to CL even if RedirectToCL is set to false
                                If m_blnRedirectToCL Then
                                    Call MemoryCleanUp()
                                    Response.Redirect("" & strListPage & "?" + m_strCommonQueryString)
                                Else
                                    Call GetCPSQL()
                                End If
                                'End Addition By Ninad on 6 Feb 2008
                            Else
                                Call GetCPSQL()
                            End If
                            '_________End of Modification By UmeshJ on 19 Nov 2004___Issue ID : 14067
                        End If
                    Else
                        'OPENED IN NEW WINDOW
                        'UI Page is opened in a child window..so refresh the parent
                        m_blnRefreshCL = True
                        Call RedirectAfterSave(strSubOperation)
                    End If
                End If
            Else
                'For EDIT mode
                If m_cObjCPSQL.EditMode_UIPageOpenInWindow = True Then
                    'OPENED IN NEW WINDOW
                    'UI Page is opened in a child window..so refresh the parent
                    m_blnRefreshCL = True
                    ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                    ''Call RedirectAfterSave(strSubOperation)
                    If Not m_blnHasMultiInsertSubTag Then Call RedirectAfterSave(strSubOperation) 'Modified By Ninad on 17 March 2009 IssueID-29406
                    ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
                Else
                    'NOT OPENED IN NEW WINDOW
                    If strSubOperation = "ADD" Then
                        '##SAVE n ADD
                        'The link is Save and Add.....save the record and open the window in ADD_NEW mode
                        Call AfterSaveGetCPSQL()
                    End If
                End If
            End If 'Mode
        ElseIf m_blnIsSubTag = True And _
               m_strOperation = CommonFunction.Constants.OPERATION_SAVE And _
               m_strSubTagFromCL = "1" And _
               m_blnRedirectToCL = True Then
            '##DETAILS TAG
            Call RedirectAfterSave(strSubOperation, True)
        End If
    End Sub

    Private Sub AfterSaveGetCPSQL()
        '=====================================================================
        ' Procedure Name        :	RedirectAfterSave
        ' Purpose               :	Redirect to page After Save
        ' Description           :	Same as above 
        ' Parameters Passed     :	none
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 20, 2004
        ' Revisions             :
        '=====================================================================
        m_strMode = "ADD_NEW"
        m_strNewPK = ""
        m_cObjCPSQL = Nothing
        Call GetCPSQL()
    End Sub

    Private Sub RedirectAfterSave(ByVal strSubOperation As String, Optional ByVal IsSubTag As Boolean = False)
        '=====================================================================
        ' Procedure Name        :	RedirectAfterSave
        ' Purpose               :	Redirect to page After Save
        ' Description           :	Same as above 
        ' Parameters Passed     :	strOperation - Operation Type
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 20, 2004
        ' Revisions             :
        '=====================================================================
        If strSubOperation = "ADD" Then
            'The link is Save and Add.....save the record and open the window in ADD_NEW mode
            Call AfterSaveGetCPSQL()
        Else
            'Refresh parent page 
            Call CreateForm("", False)
            If IsSubTag = True Then
                Call SubTag_WriteClientsideScript_RefreshParent()
            Else
                Call WriteClientsideScript_RefreshParent()
            End If
            'Close the window
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''Call CloseWindow()
            'Added By NikhilM on 21 Oct. 2010 for Modal Dialog Popup
            ' To be displayed only if Framework key for the same is enabled.
            If (CBool(CommonFunctions.General.GetFrameworkSettings("PB_SHOW_MODAL_POPUP", "Enabled")) = True) Then
                Call CloseModalWindow()
            Else
                Call CloseWindow()
            End If
            'Addition End By NikhilM for Modal Dialog Popup
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 

            Call EndForm()
            m_blnExit = True
        End If
    End Sub
    Private Sub CloseWindow()
        'Close the window
        CommonFunction.General.WriteHTML("<SCRIPT languange=javascript>")
        CommonFunction.General.WriteHTML("  window.close();")
        CommonFunction.General.WriteHTML("</SCRIPT>")
    End Sub
    'Added By Chakshuta H on 30th-Oct-2015
    Private Sub CloseModalWindow()
        '=====================================================================
        ' Procedure Name        :	CloseModalWindow
        ' Purpose               :	This function is used to close the Modal Dialog Popup
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	The Framework Key for the same must be enabled.
        ' Dependencies          :	None.
        ' Author                :	NikhilM
        ' Created               :	October 21, 2010
        ' Revisions             :
        '=====================================================================
        'Close the modal popup
        If m_blnIsSubTag Then
            CommonFunction.General.WriteHTML("<SCRIPT languange=javascript>")
            CommonFunction.General.WriteHTML("  RefreshParentFromModalPopup('" + FORM_NAME + "','" & strFormPage & "','" & strFormPage & "?SubTagID=" + m_objGlobal.TagID.ToString + "&FocusOn=" + FocusOn_SUBTAG + "&PagingNumber=" + m_intPagingNo.ToString + m_strParentTagQuerystringDefaultParameters + "');")
            CommonFunction.General.WriteHTML("  CloseDivForModalPopUp(true);")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        Else
            'Added By ShrikantB On 16-NOV-2010 For Filter The QueryString Parameter Data
            Dim m_strQuerystringParameters As String = CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
            If m_strQuerystringParameters.StartsWith("&") Then
                m_strQuerystringParameters = "?" + m_strQuerystringParameters.Remove(0, 1).ToString()
            End If
            CommonFunction.General.WriteHTML("<SCRIPT languange=javascript>")
            CommonFunction.General.WriteHTML("  RefreshParentFromModalPopup('frmCommonList','" & strListPage & "','" & strListPage & m_strQuerystringParameters & "');")
            CommonFunction.General.WriteHTML("  CloseDivForModalPopUp(true);")
            CommonFunction.General.WriteHTML("</SCRIPT>")

            'Addition End By ShrikantB On 16-NOV-2010 For Filter The QueryString Parameter Data

        End If
    End Sub
    'Ended By Chakshuta H on 30th-Oct-2015

    Private Sub Page_PreRender()
        '=====================================================================
        ' Procedure Name        :	Page_PreRender
        ' Purpose               :	This method will call the Pre render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 29, 2003 
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_strForeignKeyValue
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPreRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPreRender", ExtensionArgs)
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.PageUIPreRender(m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = PageUIPreRender(m_objGlobal, strActionCode, m_cObjCPSQL.PrimaryKeyValue)
            cobjEventHndlr.ActionCode = strActionCode
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.


        cobjEventHndlr = Nothing

    End Sub
    Protected Overridable Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Changed By NileshD on 30 Nov 2005
        'PageUIPreRender = cobjEventHndlr.PageUIPreRender(m_objGlobal)
        PageUIPreRender = cobjEventHndlr.PageUIPreRender(m_objGlobal, strPrimaryKey)
        'End of changes By NileshD on 30 Nov 2005
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub Page_PostRender()
        '=====================================================================
        ' Procedure Name        :	Page_PostRender
        ' Purpose               :	This method will call the Post render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 06, 2004
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_strForeignKeyValue
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPostRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPostRender", ExtensionArgs)

            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************

            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.PageUIPostRender(m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = PageUIPostRender(m_objGlobal, strActionCode, m_cObjCPSQL.PrimaryKeyValue)
            cobjEventHndlr.ActionCode = strActionCode
            'addition ends.
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        cobjEventHndlr = Nothing

    End Sub
    Protected Overridable Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Changed By NileshD on 30 Nov 2005
        'PageUIPostRender = cobjEventHndlr.PageUIPostRender(m_objGlobal)
        PageUIPostRender = cobjEventHndlr.PageUIPostRender(m_objGlobal, strPrimaryKey)
        'End of changes By NileshD on 30 Nov 2005
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub Page_BeforeSave()
        '=====================================================================
        ' Procedure Name        :	Page_BeforeSave
        ' Purpose               :	This method will call the before save event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, November 10, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_strForeignKeyValue
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeSave")
        If blnCheckEventCall = True Then
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.ControlsHashTable = MyBase.GetFormCollectionHashTable
            ExtensionArgs.RedirectToCL = m_blnRedirectToCL

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeSave", ExtensionArgs)

            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
            m_blnRedirectToCL = ExtensionArgs.RedirectToCL
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.BeforeSave(m_objGlobal, MyBase.GetFormCollectionHashTable, m_cObjCPSQL.PrimaryKeyValue, m_blnRedirectToCL)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = BeforeSave(m_objGlobal, MyBase.GetFormCollectionHashTable, m_cObjCPSQL.PrimaryKeyValue, strActionCode, m_blnRedirectToCL)
            m_strNewPK = m_cObjCPSQL.PrimaryKeyValue
            cobjEventHndlr.ActionCode = strActionCode
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends
        cobjEventHndlr = Nothing
    End Sub
    Public Overridable Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        'Modified by PrasannaP on 15-Jul-2005 to pass on the the Primary Key of the main tag
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_strForeignKeyValue
        'End Modification
        BeforeSave = cobjEventHndlr.BeforeSave(m_objGlobal, MyBase.GetFormCollectionHashTable, PrimaryKey, m_blnRedirectToCL)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function

    Private Sub Page_AfterSave()
        '=====================================================================
        ' Procedure Name        :	Page_AfterSave
        ' Purpose               :	This method will call the after save event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, November 10, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        Dim IsEditMode As Boolean = True
        'Added by PrasannaP on 9th May 2005 to store the tag list from the CLCacheTagIDList parameter.
        'Requirement ID = CL_CH_01
        Dim strTagList As String()
        Dim strTag As String
        Dim strWebConfigSettingForCLCache As String = CommonFunctions.General.GetApplicationKeySetting("CLCacheTagIDList")
        'End Addition
        If m_strMode = "ADD_NEW" Then IsEditMode = False
        cobjEventHndlr.MasterPrimaryKey = m_strForeignKeyValue

        'Added by PrasannaP on 6th May 2005 to set the dirty bit which will refill the Hashtable while plotting.
        'Requirement ID = CL_CH_01
        If CommonFunctions.General.GetFrameworkSettings("CL_CACHING", "Enabled") Then
            If Not IsNothing(strWebConfigSettingForCLCache) Then
                strTagList = Split(strWebConfigSettingForCLCache.ToString().Trim(), ",")
                For Each strTag In strTagList
                    If InStr(Trim(Split(strTag, "-")(0)), m_objGlobal.TagID.ToString(), CompareMethod.Text) > 0 Then
                        CommonEngines.HashTables.CreateHashTables.CreateHashTableCLDirtyBit(m_objGlobal.TagID.ToString(), "1")
                        Exit For
                    End If

                    If InStr("|" + strTag + "|", "|" + m_objGlobal.TagID.ToString() + "|", CompareMethod.Text) > Split(strTag, "-")(0).Length Then
                        CommonEngines.HashTables.CreateHashTables.CreateHashTableCLDirtyBit(Trim(Split(strTag, "-")(0)), "1")
                        Exit For
                    End If
                Next
            End If
        End If
        'End Addition


        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterSave")
        If blnCheckEventCall = True Then
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************   
            ' Modified Apr 29 2005 Rajanikant Khethawatt
            ' The primary key is not available in m_cObjCPSQL for ADD_NEW mode
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            If m_strMode = "ADD_NEW" Then
                ExtensionArgs.PrimaryKey = m_strNewPK
            Else
                ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
            End If
            ' End Modification Apr 29 2005 Rajanikant Khethawatt
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.IsEditMode = IsEditMode
            ExtensionArgs.ControlsHashTable = MyBase.GetFormCollectionHashTable
            ExtensionArgs.RedirectToCL = m_blnRedirectToCL

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterSave", ExtensionArgs)
            IsEditMode = ExtensionArgs.IsEditMode
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
            m_blnRedirectToCL = ExtensionArgs.RedirectToCL
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'cobjEventHndlr.Message = "Do you want to map review tasks to existing MPP tasks?"
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.AfterSave(m_objGlobal, MyBase.GetFormCollectionHashTable, m_strNewPK, IsEditMode, m_blnRedirectToCL)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString

            Dim strAction As String = AfterSave(m_objGlobal, MyBase.GetFormCollectionHashTable, m_cObjCPSQL.PrimaryKeyValue, strActionCode, IsEditMode, m_blnRedirectToCL)
            m_strNewPK = m_cObjCPSQL.PrimaryKeyValue
            cobjEventHndlr.ActionCode = strActionCode
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If

        'Added by PrasannaP on 14th June 2005
        'Requirement ID: RL_CH_01
        If m_objGlobal.ParentTagID <> 0 And CommonFunction.Constants.APP_TAG_TAB_GROUP_ACCESS = m_objGlobal.TagID Then
            CommonEngines.HashTables.CreateHashTables.CreateHashTableRoleAccessCacheGroup()
        End If


        'addition ends.
        cobjEventHndlr = Nothing
    End Sub
    Public Overridable Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_strForeignKeyValue
        AfterSave = cobjEventHndlr.AfterSave(m_objGlobal, MyBase.GetFormCollectionHashTable, m_strNewPK, IsEditMode, m_blnRedirectToCL)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub ExecuteDynamicLinkAction()
        '=====================================================================
        ' Procedure Name        :	ExecuteDynamicLinkAction
        ' Purpose               :	This method is used to execute the action 
        '                           for the selected dynamic link and if the link
        '                           is on the List page then redirect to list page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 01, 2003 
        ' Revisions             :
        '=====================================================================
        'WAF3_PB_26 START added by UmeshJ on 21st Aug 2006
        If m_cObjCPSQL.PKSecurity_IsEnabled = True Then
            'URL
            Dim PK As String = CommonFunction.General.CheckIsNothing(Request.QueryString("UniqueValue"))
            Dim URL As String
            Dim TGID As Long
            Dim PTGID As Long
            Dim strPKToken_Value As String
            Dim strIsListPageLink As String = CommonFunction.General.CheckIsNothing(Request.QueryString("IsListPageLink"))

            If ((strIsListPageLink = "1" And PK = "") Or (strIsListPageLink = "0" And Request("Mode") = "ADD_NEW")) Then
                'For list link if PK is not specified then do not validate
            Else
                If CType(Request("IsSubTagDynamicLink"), Long) <> 1 Or (CType(Request("IsSubTagDynamicLink"), Long) = 1 And strIsListPageLink <> "1") Then
                    URL = PK + m_objGlobal.UserID.ToString + m_objGlobal.ParentTagID.ToString + m_objGlobal.TagID.ToString
                    TGID = m_objGlobal.TagID
                    PTGID = m_objGlobal.ParentTagID
                    strPKToken_Value = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PKToken"))
                Else
                    'Sub Tag List Action
                    URL = PK + m_objGlobal.UserID.ToString + m_objGlobal.TagID.ToString + m_lngCurrentSubTagID.ToString
                    TGID = m_lngCurrentSubTagID
                    PTGID = m_objGlobal.TagID
                    strPKToken_Value = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("SubActionPKToken"))
                End If
                'PK Security is Enabled Hence Validate the Token
                Dim blnPKValid As Boolean = False
                If strPKToken_Value <> "" Then
                    If CommonFunctions.Security.Token.ValidateToken(URL, strPKToken_Value) = True Then
                        'VALID PK
                        blnPKValid = True
                    End If
                End If
                'Invalid PK
                If blnPKValid = False Then
                    'Insert Record into the log table
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess(m_cObjCPSQL.PageCaption, TGID, PTGID, m_cObjCPSQL.PrimaryKey & "-Dynamic Action", PK)
                    'Security Alert...Token check failed
                    Call MemoryCleanUp()
                    'Redirect to User Friendly Message Page
                    Dim strRedirectPagePath As String = "" & strFormPage & "?MasterTagId=1836&FromWhere=1"
                    Response.Redirect(strRedirectPagePath)
                End If
            End If
        End If
        'WAF3_PB_26 END added by UmeshJ on 21st Aug 2006

        If CType(Request("IsSubTagDynamicLink"), Long) <> 1 Then
            'Execute Master Tag Dynamic Link Action
            Call ExecuteTagDynamicLinkAction()
        Else
            'Execute Details Tag Dynamic Link Action
            Call ExecuteSubTagDynamicLinkAction()
            'm_blnExit = True
        End If
    End Sub
    Private Sub ExecuteTagDynamicLinkAction()
        '=====================================================================
        ' Procedure Name        :	ExecuteTagDynamicLinkAction
        ' Purpose               :	This method is used to execute the action 
        '                           for the selected dynamic link and if the link
        '                           is on the List page then redirect to list page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 13, 2003 
        ' Revisions             :
        '=====================================================================
        Dim strDynamicLinkID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("DYNAMIC_LINK_ID"))
        'If the dynamic link ID is not specified then exit
        If strDynamicLinkID.Trim = "" Then Return
        Dim strIsListPageLink As String = CommonFunction.General.CheckIsNothing(Request.QueryString("IsListPageLink"))
        Dim strAction As String = ""
        Dim strUniqueValue As String = CommonFunction.General.CheckIsNothing(Request.QueryString("UniqueValue"))
        Dim blnCancelAction As Boolean = False
        Dim objLink As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution
        'Action executed
        Dim strMsgActionExecuted As String = MyBase.GetResourceString("ACTION_EXECUTED")

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Retrieve the link action from the Hashtable
        Dim objDynamicLinksHashTable As CommonEngines.HashTables.DynamicLinks()
        Dim intIndex As Integer
        Dim intLength As Integer

        If strIsListPageLink = "1" Then
            'Get the Link details for the selected Page
            objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCLObject(m_objGlobal.TagID)
        Else
            objDynamicLinksHashTable = CommonEngines.HashTables.GetHashTableObject.GetHashTableDynamicLinkCPObject(m_objGlobal.TagID)
        End If
        intLength = objDynamicLinksHashTable.Length
        For intIndex = 0 To intLength - 1
            If objDynamicLinksHashTable(intIndex).UniqueID.ToString = strDynamicLinkID Then
                'SP to execute as Action
                strAction = CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SpToExecute, "")
                strAction = ReplacePlaceHolders(strAction, strUniqueValue, m_objGlobal)
                'Prepare the Link Object
                objLink = PrepareDynamicLinkObject(objDynamicLinksHashTable(intIndex).AccessRights, objDynamicLinksHashTable(intIndex).ClientSideFunctionName, objDynamicLinksHashTable(intIndex).ConditionClause, objDynamicLinksHashTable(intIndex).CreatedBy, objDynamicLinksHashTable(intIndex).CreatedDate, objDynamicLinksHashTable(intIndex).CustomLink, objDynamicLinksHashTable(intIndex).DisplayPosition, _
                        objDynamicLinksHashTable(intIndex).Identifier, objDynamicLinksHashTable(intIndex).ImageURL, objDynamicLinksHashTable(intIndex).LinkName, objDynamicLinksHashTable(intIndex).LinkToolTip, objDynamicLinksHashTable(intIndex).LinkType, objDynamicLinksHashTable(intIndex).ListPageOrderNumber, objDynamicLinksHashTable(intIndex).OrderNumber, strAction, _
                        objDynamicLinksHashTable(intIndex).SystemLinkType, objDynamicLinksHashTable(intIndex).TagID, objDynamicLinksHashTable(intIndex).UniqueID, m_strCommonQueryString, strIsListPageLink, m_strMode, strMsgActionExecuted)
                Exit For
            End If
        Next
        objDynamicLinksHashTable = Nothing

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_ExecutingAction")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.Cancel = blnCancelAction
            ExtensionArgs.m_LinkExecution = objLink
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = strUniqueValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_ExecutingAction", ExtensionArgs)
            blnCancelAction = ExtensionArgs.Cancel
            objLink = ExtensionArgs.m_LinkExecution
            m_objSubTagGlobal = ExtensionArgs.m_global
            strUniqueValue = ExtensionArgs.PrimaryKey


            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************

            'Before executing the action Call the event
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_ExecutingAction(blnCancelAction, objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            Call Before_ExecutingAction(blnCancelAction, objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            'Addition Ends

            HttpContext.Current.Response.Write(objLink.ToBeInserted)
        End If
        'addition ends.
        'If Action Exists then Execute it
        If blnCancelAction = False And objLink.SpToExecute <> "" Then
            'If Cancel = false then execute the action
            CommonFunction.Data.InsertOrUpdateData(objLink.SpToExecute, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
            If objLink.SystemLinkType = "USER_MODE" Or objLink.SystemLinkType = "DESIGN_MODE" Then
                CommonEngines.HashTables.CreateHashTables.CreateUITagMasterHashTable(m_objGlobal.TagID)
                m_cObjCPSQL.IsDesignMode = Not m_cObjCPSQL.IsDesignMode 'bcoz IsDesignMode toggle
                m_blnIsDesignMode = Not m_blnIsDesignMode
                If objLink.IsListPageLink = "0" And m_cObjCPSQL.SmartNavigation_IsEnabled = True Then Call RefreshCL() 'WAF3_PB_48 NinadP 18 June 2007
            End If
            'End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
        End If
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised

        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "After_ExecutingAction")
        If blnCheckEventCall = True Then
            objLink.ToBeInserted = ""
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.m_LinkExecution = objLink
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = strUniqueValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "After_ExecutingAction", ExtensionArgs)

            objLink = ExtensionArgs.m_LinkExecution
            m_objGlobal = ExtensionArgs.m_global
            strUniqueValue = ExtensionArgs.PrimaryKey
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************

            'After executing the action Call the event

            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_ExecutingAction(objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            Call After_ExecutingAction(objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            HttpContext.Current.Response.Write(objLink.ToBeInserted)
        End If
        'addition ends.
        m_strInformativeMessage = "window.status='" + objLink.MsgActionExecuted + "';"

        If (m_strMode = "ADD_NEW" And m_cObjCPSQL.AddMode_UIPageOpenInWindow = True) Or (m_strMode <> "ADD_NEW" And m_cObjCPSQL.EditMode_UIPageOpenInWindow = True) Then
            m_blnRefreshCL = True
        End If
        'If the Link belongs to Commonlist then return to that page
        If objLink.IsListPageLink = "1" Then
            Call MemoryCleanUp()
            '_________Modified By UmeshJ on 19 Nov 2004______________Issue ID : 14067
            'Server.Transfer("" & strListPage & "?DYNAMIC_ACTION=1&" + objLink.CommonQueryString)
            Response.Redirect("" & strListPage & "?DYNAMIC_ACTION=1&" + objLink.CommonQueryString)
            '_________End of Modification By UmeshJ on 19 Nov 2004___Issue ID : 14067
        End If
        objLink = Nothing

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As Hashtable = Nothing)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_ExecutingAction(Cancel, Args, WhizGlobal, PrimaryKey, ControlsHashTable)
    End Sub
    Protected Overridable Sub After_ExecutingAction(ByRef Args As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As Hashtable = Nothing)
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_ExecutingAction(Args, WhizGlobal, PrimaryKey, MyBase.GetFormCollectionHashTable)
    End Sub
    Private Function PrepareDynamicLinkObject(ByVal AccessRights As String, ByVal ClientSideFunctionName As String, ByVal ConditionClause As String, ByVal CreatedBy As String, ByVal CreatedDate As String, ByVal CustomLink As String, ByVal DisplayPosition As String, ByVal Identifier As String, ByVal ImageURL As String, ByVal LinkName As String, ByVal LinkToolTip As String, ByVal LinkType As String, ByVal ListPageOrderNumber As Long, ByVal OrderNumber As Long, ByVal SpToExecute As String, ByVal SystemLinkType As String, ByVal TagID As Long, ByVal UniqueID As Long, ByVal CommonQueryString As String, ByVal IsListPageLink As String, ByVal Mode As String, ByVal MsgActionExecuted As String) As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution
        '=====================================================================
        ' Procedure Name        :	PrepareDynamicLinkObject
        ' Purpose               :	Prepare Dynamic Link Object for events
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 11, 2004
        ' Revisions             :
        '=====================================================================
        Dim objLink As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution
        With objLink
            .AccessRights = AccessRights
            .ClientSideFunctionName = ClientSideFunctionName
            .ConditionClause = ConditionClause
            .CreatedBy = CreatedBy
            .CreatedDate = CreatedDate
            .CustomLink = CustomLink
            .DisplayPosition = DisplayPosition
            .Identifier = Identifier
            .ImageURL = ImageURL
            .LinkName = LinkName
            .LinkToolTip = LinkToolTip
            .LinkType = LinkType
            .ListPageOrderNumber = ListPageOrderNumber
            .OrderNumber = OrderNumber
            .SpToExecute = SpToExecute
            .SystemLinkType = SystemLinkType
            .TagID = TagID
            .UniqueID = UniqueID
            .CommonQueryString = CommonQueryString
            .IsListPageLink = IsListPageLink
            .Mode = Mode
            .MsgActionExecuted = MsgActionExecuted
            .MasterPrimaryKey = m_strForeignKeyValue
            .ToBeInserted = ""
        End With
        PrepareDynamicLinkObject = objLink
    End Function

    Private Sub ExecuteSubTagDynamicLinkAction()
        '=====================================================================
        ' Procedure Name        :	ExecuteSubTagDynamicLinkAction
        ' Purpose               :	This method is used to execute the action 
        '                           for the selected dynamic link and if the link
        '                           is on the List page then redirect to list page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 1, 2003 
        ' Revisions             :
        '=====================================================================
        Dim strDynamicLinkID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("DYNAMIC_LINK_ID"))
        'If the dynamic link ID is not specified then exit
        If strDynamicLinkID.Trim = "" Then Return
        Dim strIsListPageLink As String = CommonFunction.General.CheckIsNothing(Request.QueryString("IsListPageLink"))
        Dim strAction As String = ""
        Dim strUniqueValue As String = CommonFunction.General.CheckIsNothing(Request.QueryString("UniqueValue"))
        Dim blnCancelAction As Boolean = False
        Dim objLink As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution
        'Action executed
        Dim strMsgActionExecuted As String = MyBase.GetResourceString("ACTION_EXECUTED")
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Retrieve the link action from the Hashtable
        Dim objDynamicLinksHashTable As CommonEngines.HashTables.DynamicLinks()
        Dim intIndex As Integer
        Dim intLength As Integer

        If strIsListPageLink = "1" Then
            'Get the Link details for the selected Page
            objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCLObject(m_lngCurrentSubTagID)
        Else
            objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCPObject(m_objGlobal.TagID)
        End If
        intLength = objDynamicLinksHashTable.Length
        For intIndex = 0 To intLength - 1
            If objDynamicLinksHashTable(intIndex).UniqueID.ToString = strDynamicLinkID Then
                'SP to execute as Action
                strAction = CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SpToExecute, "")
                strAction = ReplacePlaceHolders(strAction, strUniqueValue, m_objGlobal)
                'Prepare the Link Object
                objLink = PrepareDynamicLinkObject(objDynamicLinksHashTable(intIndex).AccessRights, objDynamicLinksHashTable(intIndex).ClientSideFunctionName, objDynamicLinksHashTable(intIndex).ConditionClause, objDynamicLinksHashTable(intIndex).CreatedBy, objDynamicLinksHashTable(intIndex).CreatedDate, objDynamicLinksHashTable(intIndex).CustomLink, objDynamicLinksHashTable(intIndex).DisplayPosition, _
                        objDynamicLinksHashTable(intIndex).Identifier, objDynamicLinksHashTable(intIndex).ImageURL, objDynamicLinksHashTable(intIndex).LinkName, objDynamicLinksHashTable(intIndex).LinkToolTip, objDynamicLinksHashTable(intIndex).LinkType, objDynamicLinksHashTable(intIndex).ListPageOrderNumber, objDynamicLinksHashTable(intIndex).OrderNumber, strAction, _
                        objDynamicLinksHashTable(intIndex).SystemLinkType, objDynamicLinksHashTable(intIndex).TagID, objDynamicLinksHashTable(intIndex).UniqueID, m_strCommonQueryString, strIsListPageLink, m_strMode, strMsgActionExecuted)
                Exit For
            End If
        Next
        objDynamicLinksHashTable = Nothing

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_ExecutingAction")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.Cancel = blnCancelAction
            ExtensionArgs.m_LinkExecution = objLink
            ExtensionArgs.m_global = m_objSubTagGlobal
            ExtensionArgs.PrimaryKey = strUniqueValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_ExecutingAction", ExtensionArgs)

            blnCancelAction = ExtensionArgs.Cancel
            objLink = ExtensionArgs.m_LinkExecution
            m_objSubTagGlobal = ExtensionArgs.m_global
            strUniqueValue = ExtensionArgs.PrimaryKey


            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************

            'Before executing the action Call the event
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_ExecutingAction(blnCancelAction, objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            Call Before_ExecutingAction(blnCancelAction, objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            'Addition Ends
            HttpContext.Current.Response.Write(objLink.ToBeInserted)
        End If
        'addition ends.
        'If Action Exists then Execute it
        If blnCancelAction = False And objLink.SpToExecute <> "" Then
            'If Cancel = false then execute the action
            CommonFunction.Data.InsertOrUpdateData(objLink.SpToExecute, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised

        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "After_ExecutingAction")
        If blnCheckEventCall = True Then
            objLink.ToBeInserted = ""
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.m_LinkExecution = objLink
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = strUniqueValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "After_ExecutingAction", ExtensionArgs)

            objLink = ExtensionArgs.m_LinkExecution
            m_objGlobal = ExtensionArgs.m_global
            strUniqueValue = ExtensionArgs.PrimaryKey
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'After executing the action Call the event

            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_ExecutingAction(objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            After_ExecutingAction(objLink, m_objGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            'Addition Ends

            HttpContext.Current.Response.Write(objLink.ToBeInserted)
        End If
        'addition ends.
        m_strInformativeMessage = "window.status='" + objLink.MsgActionExecuted + "';"

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Private Sub GetFormVariables()
        '=====================================================================
        ' Procedure Name        :	GetFormVariables
        ' Purpose               :	Get Form Variables
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 21, 2003 
        ' Revisions             :
        '=====================================================================
        Dim objFrmVar() As CommonEngines.HashTables.UIFormVariables
        'Create object for Tag Form Variables hash table
        If m_blnIsSubTag = False Then
            objFrmVar = CommonEngines.HashTables.GetHashTableObject.GetHashTableFormVariableObject(m_objGlobal.TagID)
        Else
            objFrmVar = CommonEngines.HashTables.GetHashTableObject.GetHashTableFormVariableObject(m_objGlobal.ParentTagID)
        End If
        'No Form variables then exit
        If objFrmVar Is Nothing Then Return
        Dim sbFormVars As New System.Text.StringBuilder
        Dim intLength As Integer = objFrmVar.Length - 1
        Dim intIndex As Integer
        For intIndex = 0 To intLength
            If objFrmVar(intIndex).Type = CommonFunction.Constants.FORM_VARIABLE_TYPE_DYNAMIC Then
                'Prepare SQL
                Dim objWhereClause() As CommonEngines.HashTables.UIFormVariablesWhereClause
                Dim sbSQL As New System.Text.StringBuilder("SELECT " + objFrmVar(intIndex).SelectFields + " FROM " + objFrmVar(intIndex).DataSource + " WHERE 1=1 ")
                objWhereClause = CommonEngines.HashTables.GetHashTableObject.GetHashTableFormVariableObject(m_objGlobal.TagID.ToString + "-" + objFrmVar(intIndex).FormVariableID.ToString)
                If Not objWhereClause Is Nothing Then
                    Dim intWhereClauseLength As Integer = objWhereClause.Length - 1
                    Dim intWhereClauseIndex As Integer
                    For intWhereClauseIndex = 0 To intWhereClauseLength
                        sbSQL.Append(" AND " + objWhereClause(intWhereClauseIndex).FieldName + "='" + CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session(CommonFunction.General.CheckIsNothing(objWhereClause(intWhereClauseIndex).SessionVariable))).ToString) + "'")
                    Next
                End If
                'Assign the value of dynamic query to the form variable
                Dim drValue As IDataReader = CommonFunction.Data.GetDataReader(sbSQL.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim intCurrent As Integer
                Dim intLast As Integer = drValue.FieldCount - 1
                Dim strValue(intLast) As String
                Dim blnIsDefined As Boolean = False
                'variable declaration
                For intCurrent = 0 To intLast
                    If blnIsDefined = False Then
                        sbFormVars.Append(vbCrLf + " var " + drValue.GetName(intCurrent).ToString() + ";")
                    End If
                Next
                Do While drValue.Read
                    For intCurrent = 0 To intLast
                        'Assign values to the temp arrays
                        If drValue.GetDataTypeName(intCurrent).ToUpper = "DATETIME" Or drValue.GetDataTypeName(intCurrent).ToUpper = "SMALLDATETIME" Then
                            'For date fields get the date value in proper format
                            strValue(intCurrent) += CommonFunction.Dates.GetDate(CType(CommonFunction.General.CheckIsNothing(drValue(intCurrent)), Date)) + ","
                        Else
                            strValue(intCurrent) += CommonFunction.General.CheckIsNothing(drValue(intCurrent)) + ","
                        End If
                    Next
                Loop
                'Assign values to the variables
                For intCurrent = 0 To intLast
                    sbFormVars.Append(vbCrLf + drValue.GetName(intCurrent).ToString() + "=" + Chr(34) + Left(strValue(intCurrent), strValue(intCurrent).Length - 1) + Chr(34) + ";")
                Next
                'Destroy object
                drValue.Close()
                drValue.Dispose()
                drValue = Nothing
                objWhereClause = Nothing
                sbSQL = Nothing
            Else

                If CommonFunction.General.CheckIsNothing(objFrmVar(intIndex).SelectFields, "") <> "" Then
                    If objFrmVar(intIndex).Type = CommonFunction.Constants.FORM_VARIABLE_TYPE_SESSION Then
                        'Assign the value of session variable to the form variable
                        sbFormVars.Append(vbCrLf + "var " + objFrmVar(intIndex).SelectFields.ToString + "=" + Chr(34) + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session(objFrmVar(intIndex).SelectFields.ToString)).ToString + Chr(34) + ";")
                    Else
                        'Assign the value of Place holder to the form variable
                        sbFormVars.Append(vbCrLf + "var " + Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(objFrmVar(intIndex).SelectFields.ToString, "<", ""), ">", "") + "=" + Chr(34) + ReplacePlaceHolders(objFrmVar(intIndex).SelectFields.ToString, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal).ToString + Chr(34) + ";")
                    End If
                End If
            End If
        Next
        m_strFormVariables = sbFormVars.ToString
        'Destroy the object
        sbFormVars = Nothing
        objFrmVar = Nothing
    End Sub
    Public Function ReplacePlaceHolders(ByVal strInput As String, ByVal strUniqueValue As String, ByVal WhizGlobal As WebPages.Template.IGlobal) As String
        '=====================================================================
        ' Procedure Name        :	ReplacePlaceHolders
        ' Purpose               :	Replace the Place Holders by actual values
        ' Description           :	Same as above
        ' Parameters Passed     :	strInput- input string, strUniqueValue - unique value
        ' Parameters Affected   :	None.
        ' Returns               :	String with actual values for the place holders
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Thursday, September 11, 2003 
        ' Revisions             :
        '=====================================================================
        If strInput = "" Then Return ""
        strInput = CommonFunction.General.ReplacePlaceHolders(strInput)
        'Replace By Unique Value
        strInput = Microsoft.VisualBasic.Replace(strInput, "<UNIQUE_ID>", strUniqueValue)
        'Replace By Master PK Value
        strInput = Microsoft.VisualBasic.Replace(strInput, "<MASTER_PK>", m_cObjCPSQL.PrimaryKeyValue)
        'Replace by Server Date
        strInput = Microsoft.VisualBasic.Replace(strInput, "<SERVER_DATE>", CommonFunction.Dates.GetDate(Date.Now).ToString)
        If m_objGlobal.ParentTagID <> 0 Then
            strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", m_objGlobal.ParentTagID.ToString)
            strInput = Microsoft.VisualBasic.Replace(strInput, "<SUBTAG_ID>", m_objGlobal.TagID.ToString)
        Else
            strInput = Microsoft.VisualBasic.Replace(strInput, "<TAG_ID>", m_objGlobal.TagID.ToString)
        End If
        'Query string place holders 'UJ_14_Feb-2007
        If InStr(strInput, "<#", CompareMethod.Text) <> 0 Then
            'For these place holders check the syntax <#PLACE_HOLDER>
            'Place holder exists e.g. usp_sel 4545,<#DataId>,<#Data2>
            Dim arrInput() As String = Split(strInput, "<")
            Dim intIndex As Integer
            Dim intLastIndex As Integer = arrInput.Length - 1
            For intIndex = 0 To intLastIndex
                'For each item in the array
                If Left(arrInput(intIndex), 1) = "#" Then
                    'if first character is # then it is a Query String Place holder
                    Dim arrPlaceHolder() As String = Split(arrInput(intIndex), ">")
                    If arrPlaceHolder.Length = 2 Then
                        'First item will be #PLACE_HOLDER and Second will be some string
                        'PrasannaP 13th July 2005
                        arrPlaceHolder(0) = "'" + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request(Right(arrPlaceHolder(0), arrPlaceHolder(0).Length - 1))) + "'"
                        'End Modification
                        arrInput(intIndex) = Join(arrPlaceHolder, "")
                    Else
                        'Not a valid Place holder
                        If intIndex > 0 Then arrInput(intIndex) = "<" + Join(arrPlaceHolder, ">")
                    End If
                Else
                    If intIndex > 0 Then
                        'Not a valid Place holder
                        arrInput(intIndex) = "<" + arrInput(intIndex)
                    End If
                End If
            Next
            'Recreate the query
            strInput = Join(arrInput, "")
        End If
        Return strInput
    End Function
    Private Sub FillGeneralObject()
        'Prepare General Object
        With m_objGeneral
            .IsListPage = False
            .MasterPrimaryKeyValue = m_strForeignKeyValue
            .PrimaryKeyValue = m_cObjCPSQL.PrimaryKeyValue
        End With
    End Sub
    Private Sub PageDetails()
        '=====================================================================
        ' Procedure Name        :	PageDetails
        ' Purpose               :	This is a main function to plot the Page Details
        ' Description           :	This function internally calls different functions 
        '                           to plot the page details
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 29, 2003 
        ' Revisions             :
        '=====================================================================
        Call FillGeneralObject()
        'Get Navigation Links
        ' Added By NinadP :	14 Feb 2007 : Requirement Tag - WAF3_PB_33 
        m_cObjCPSQL.ConnectionString = m_strConnectionString
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        If m_cObjCPSQL.DisplayNavigationLinks = True Then m_cObjCPSQL.GetNavigationLinks()
        'Page Start....<HTML><HEAD><BODY><FORM>
        Call CreateForm(m_cObjCPSQL.PageCaption)
        'Refresh Parent for Master Tag
        Call WriteClientsideScript_RefreshParent()
        'Refresh Parent..for details tag
        Call SubTag_WriteClientsideScript_RefreshParent()
        'Get the form variables
        Call GetFormVariables()
        'Page PreRender
        Call Page_PreRender()
        'Presist the data
        Call CreateHiddenParameters()
        'Header Menu
        Call GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.UI_HEAD, True)
        'Legends
        Call PlotPageLegends()
        'Plot Page Caption
        If m_blnIsSubTag = False Then
            Call PlotPageCaption(m_cObjCPSQL.PageCaption, m_cObjCPSQL.GetRightsidePageCaption)
        Else
            Call PlotPageCaption(m_cObjCPSQL.PageCaption, "")
        End If
        'Page Header
        Call PlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER, m_cObjCPSQL.PageHeader)
        If m_cObjCPSQL.PageHeader.Trim <> "" Then Response.Write("<BR>")
        'Sections
        If m_blnIsSubTag = False Then
            Call PlotSections()
        Else
            Call PlotSubTagSections()
        End If
        Response.Write("<BR>")
        'Page Footer
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''Call PlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER, m_cObjCPSQL.PageFooter)
        If CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            Call PlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER, m_cObjCPSQL.PageFooter)
        End If
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        If m_cObjCPSQL.PageFooter.Trim <> "" Then Response.Write("<BR>")
        'Footer MEnu
        'WAF3_PB_42 April 03, 2007 UJ START
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
        If (m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL AndAlso CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled")) Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            Call GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.UI_FOOT, False)
        End If
        'WAF3_PB_42 April 03, 2007 UJ END
        'Added By Chakshuta H on 30th-Oct-2015
        'Added By NikhilM on 21 Oct. 2010 for Modal Dialog Popup
        ' To be displayed only if Framework key for the same is enabled.
        If CBool(CommonFunctions.General.GetFrameworkSettings("PB_SHOW_MODAL_POPUP", "Enabled")) = True Then
            Call PlotDivForModalDialog()
        End If
        'Addition End By NikhilM for Modal Dialog Popup

        'Ended By Chakshuta H on 30th-Oct-2015

        'Client side script
        Call WriteClientsideScript()
        'Page Post Render Event
        Call Page_PostRender()
        'Added By Chakshuta H on 30th-Oct-2015
        'Added By Ninad on 17 March 2009 IssueID-29406
        If m_blnHasMultiInsertSubTag AndAlso ((CommonFunction.General.CheckIsNothing(Request("SubOperation")).ToUpper = "CLOSE") Or (m_strOperation = CommonFunction.Constants.OPERATION_SAVE AndAlso m_cObjCPSQL.EditMode_UIPageOpenInWindow)) Then
            'Added By ShrikantB on 17 NOV  2010 for Modal Dialog Popup
            ' To be displayed only if Framework key for the same is enabled.
            If (CBool(CommonFunctions.General.GetFrameworkSettings("PB_SHOW_MODAL_POPUP", "Enabled")) = True) Then
                Call CloseModalWindow()
            Else
                Call CloseWindow()
            End If
            'Addition End By ShrikantB on 17 NOV  2010 for Modal Dialog Popup
        End If
        'End Added By Ninad on 17 March 2009 IssueID-29406
        'Ended By Chakshuta H on 30th-Oct-2015

        'Page End....</FORM></BODY></HTML>
        Call EndForm()
        'Added By Chakshuta H on 30th-Oct-2015
        WriteClientsideScript_InformativeMessage()
        'Ended By Chakshuta H on 30th-Oct-2015

    End Sub
    'Added By Chakshuta H on 30th-Oct-2015
    Private Sub PlotDivForModalDialog()
        '=====================================================================
        ' Procedure Name        :	PlotDivForModalDialog
        ' Purpose               :	This function is used to plot the Modal Dialog Popup
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	The Framework Key for the same must be enabled.
        ' Dependencies          :	None.
        ' Author                :	NikhilM
        ' Created               :	October 21, 2010
        ' Revisions             :
        '=====================================================================

        Dim sbHTMLForModalDialogDivs As New System.Text.StringBuilder

        With sbHTMLForModalDialogDivs

            'Lookup Div - This Div will show up as a popup

            .AppendLine("<div id=""dModal"" class=""clsDivModalDialog"" style=""display:none;position:absolute;"" title=""Double Click to Drag"" ondragend=""ShowMousePos()"" ondblclick=""SelectText(this)"">")
            .AppendLine("    <table id=""tblModal"" class=""clsTableModalDlg"">")
            .AppendLine("       <tr>")
            .AppendLine("           <td id=""tdFirstRow"" width=""95%"" class=""clsTDFirstRow"">")
            .AppendLine("               <span id=""wndCaption"" class=""clsMdlDlgCaption""></span>")
            .AppendLine("           </td>")
            .AppendLine("           <td width=""5%"" class=""clsTDClose"">")
            .AppendLine("                <img src='../../Images/mdlclose.gif' onclick=""CloseDivForModalPopUp()"" />")
            .AppendLine("           </td>")
            .AppendLine("       </tr>")
            .AppendLine("       <tr>")
            .AppendLine("           <td colspan='2'>")
            .AppendLine("               <iframe id=""iFrmMdl"" width=100% frameborder=""0"" scrolling=""no"" onload=""calcHeight(this)"">")
            .AppendLine("               </iframe>")
            .AppendLine("           </td>")
            .AppendLine("       </tr>")
            .AppendLine("   </table>")
            .AppendLine("</div>")

            'Masking Div - This Div will apply the opaque mask onto the frame.

            .AppendLine("<div id=""MaskedDiv"" class=""clsMaskDiv"" style=""display:none;position:absolute;"">")
            .AppendLine("</div>")

        End With


        Response.Write(sbHTMLForModalDialogDivs.ToString)

        sbHTMLForModalDialogDivs = Nothing

    End Sub

    'Ended By Chakshuta H on 30th-Oct-2015

    Private Sub PlotSections()
        '=====================================================================
        ' Procedure Name        :	PlotSections
        ' Purpose               :	This function is used to plot the Page Sections
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 29, 2003 
        ' Revisions             :
        '=====================================================================
        Dim sbClientsideScript As New System.Text.StringBuilder("")
        Dim sbEnabledControls As New System.Text.StringBuilder("")
        Dim sbExpandSections As New System.Text.StringBuilder(vbCrLf + " function " + m_strexpandSectionsFunction + "() { ")
        Dim intLength As Integer
        Dim intIndex As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        Dim intNoOfActiveSections As Integer = 0
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Added By Chakshuta H on 30th-Oct-2015
        Try 'Added By Ninad on 17 March 2009 IssueID-29406

            'Ended By Chakshuta H on 30th-Oct-2015
            'Tag Sections
            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
                'Local culture ID is same as the default culture id
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-0")
            Else
                'Culture ID is other than the default culture id
                'Check if the Culture is supported by the system
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-0")
                If objSection Is Nothing Then
                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                    objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-0")
                End If
            End If
            If objSection Is Nothing Then Return
            intLength = objSection.Length - 1

            'Modified by PrasannaP on 30/5/2005
            'Issue Id: 18888
            'HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:400px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            Dim intHeight As Integer = 450
            If CommonFunctions.General.IsClientBrowserIE = True Then
                intHeight += 50
            End If

            HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:" + CStr(intHeight) + "px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")

            'If CommonFunctions.General.IsClientBrowserIE = True Then
            '    HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:500px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            'Else
            '    HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:450px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            'End If


            'Get the Number of active sections
            For intIndex = 0 To intLength
                'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
                'Do not plot subtag section if there is any multi insert type subtag 
                If m_blnHasMultiInsertSubTag And objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_SUBTAG Then
                    objSection(intIndex).IsActive = False
                End If
                'End AdditionBy - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
                If objSection(intIndex).IsActive = True Then intNoOfActiveSections += 1
            Next

            For intIndex = 0 To intLength
                If objSection(intIndex).IsActive = True And IsSubTagSectionAccessible(objSection(intIndex).SectionID) Then
                    'If the Div Height is not specified in the div style then apply it from the
                    'value specified in the Height property
                    Dim lngDivHeight As Long
                    Dim strDivStyle As String = "OVERFLOW:auto; WIDTH:100%;"
                    Dim strSectionTag As String = "divSection" + objSection(intIndex).SectionID.ToString
                    Dim strFunctionName As String = "showHide_" + strSectionTag

                    Dim blnCancelSection As Boolean = False
                    'Create object of the Section Structure
                    Dim Section As EventHandlers.WAF_Section = PrepareSectionObject(objSection(intIndex).SectionID, objSection(intIndex).TagSectionID, objSection(intIndex).Height, objSection(intIndex).OrderNumber, objSection(intIndex).IsActive, objSection(intIndex).ShowSectionTitle, objSection(intIndex).SectionTitle, objSection(intIndex).SectionTitleAlignment, strSectionTag, strFunctionName)
                    'Code Added:RajeshB	14 October, 2004

                    'Purpose: Check if event is to be raised
                    Dim blnCheckEventCall As Boolean
                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSection")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                        ExtensionArgs.m_Section = Section
                        ExtensionArgs.Cancel = blnCancelSection
                        ExtensionArgs.m_global = m_objGlobal
                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSection", ExtensionArgs)
                        blnCancelSection = ExtensionArgs.Cancel
                        Section = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************

                        'Call the Before plot section event...pass the section structure by ref
                        '--Code Modified:RajeshB            15th Jan 2005
                        '-- Purpose: Wrap the event call in function to allow the inheriting
                        ' class to delegate it anywhere
                        'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSection(blnCancelSection, Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        Call Before_PlotSection(blnCancelSection, Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        'Addition Ends
                    End If
                    'addition ends.
                    'If the only one section present then directly plot the controls
                    If blnCancelSection = False And intNoOfActiveSections > 1 And (CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Or objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_FOOTER) Then
                        sbExpandSections.Append(vbCrLf + Section.FunctionName + "(""none"");")
                        'For each Section - Plot Section Header
                        'Create object of the Section Structure for sectionTitle
                        Dim SectionTitle As EventHandlers.WAF_Section = PrepareSectionObject(Section.SectionID, Section.TagSectionID, Section.Height, Section.OrderNumber, Section.IsActive, Section.ShowSectionTitle, Section.SectionTitle, Section.SectionTitleAlignment, Section.DivSectionTag, Section.FunctionName)
                        Dim blnCancelSectionTitle As Boolean = False
                        'Code Added:RajeshB	14 October, 2004
                        'Purpose: Check if event is to be raised
                        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                            "Before_PlotSectionTitle")
                        If blnCheckEventCall = True Then
                            ' WAF_PB_17
                            '*******************************************************************    
                            ' Code Added:RajeshB                    7th October, 2004
                            ' Purpose: Handle all applicable extensions.
                            '*******************************************************************
                            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                            ExtensionArgs.Cancel = blnCancelSectionTitle
                            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                            ExtensionArgs.m_Section = SectionTitle
                            ExtensionArgs.m_global = m_objGlobal

                            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                            "Before_PlotSectionTitle", ExtensionArgs)

                            blnCancelSectionTitle = ExtensionArgs.Cancel
                            SectionTitle = ExtensionArgs.m_Section
                            m_objGlobal = ExtensionArgs.m_global
                            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                            '*******************************************************************    
                            ' Addition Ends - RajeshB
                            '******************************************************************
                            'Call the Before plot sectionTitle event...pass the sectionTitle structure by ref
                            '--Code Modified:RajeshB            15th Jan 2005
                            '-- Purpose: Wrap the event call in function to allow the inheriting
                            ' class to delegate it anywhere
                            'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                            Call Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                            'Addition Ends
                        End If
                        'addition ends.
                        If blnCancelSectionTitle = False Then
                            ''If objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_FOOTER And m_strMode = "ADD_NEW" Then
                            ''    sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False))
                            ''Else
                            ''    sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID))
                            ''End If
                            If objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_FOOTER And m_strMode = "ADD_NEW" Then
                                If (CommonFunction.General.GetFrameworkSettings("GEN_SHOW_HEADER_FOOTER_SUBTAG_SECTIONTITLE", "Enabled") = True) Then
                                    sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False))
                                End If
                            Else
                                If (objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_HEADER _
                                    OrElse objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_FOOTER _
                                    OrElse objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_SUBTAG) Then
                                    If (CommonFunction.General.GetFrameworkSettings("GEN_SHOW_HEADER_FOOTER_SUBTAG_SECTIONTITLE", "Enabled") = True) Then
                                        sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID))
                                    End If
                                Else
                                    sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID))
                                End If
                            End If
                            'Modification End By ShrikantB On 15-NOV-2010 For Hide Header-Footer-SubTag Section Title

                        End If
                        'Code Added:RajeshB	14 October, 2004
                        'Purpose: Check if event is to be raised

                        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                            "After_PlotSectionTitle")
                        If blnCheckEventCall = True Then
                            ' WAF_PB_17
                            '*******************************************************************    
                            ' Code Added:RajeshB                    7th October, 2004
                            ' Purpose: Handle all applicable extensions.
                            '*******************************************************************
                            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                            ExtensionArgs.m_Section = SectionTitle
                            ExtensionArgs.m_global = m_objGlobal

                            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                            "After_PlotSectionTitle", ExtensionArgs)

                            blnCancelSection = ExtensionArgs.Cancel
                            SectionTitle = ExtensionArgs.m_Section
                            m_objGlobal = ExtensionArgs.m_global
                            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                            '*******************************************************************    
                            ' Addition Ends - RajeshB
                            '******************************************************************

                            'Call after print event for Section Title
                            '--Code Modified:RajeshB            15th Jan 2005
                            '-- Purpose: Wrap the event call in function to allow the inheriting
                            ' class to delegate it anywhere
                            'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSectionTitle(SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                            Call After_PlotSectionTitle(SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                            'Addition Ends
                        End If
                        'addition ends.
                        SectionTitle = Nothing
                    End If

                    'Show/Hide the section according to user preferences
                    If blnCancelSection = False And (intLength = 0 Or (intLength >= 1 And Section.SectionID <> CommonFunction.Constants.SECTION_FOOTER And m_strMode = "ADD_NEW") Or (intLength > 0 And GetSectionPreferences(Section.SectionID) = 1)) Then

                        'If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Or Section.SectionID = CommonFunction.Constants.SECTION_FOOTER Then 'WAF3_PB_44 Commented By UmeshJ 14 May 2007
                        lngDivHeight = Section.Height
                        If lngDivHeight <> 0 Then
                            strDivStyle += "HEIGHT:" & lngDivHeight.ToString.Trim & "px; "
                        End If
                        HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                        'End If 'WAF3_PB_44 Commented By UmeshJ 14 May 2007

                        'Show the Section
                        Select Case Section.SectionID
                            Case CommonFunction.Constants.SECTION_HEADER, CommonFunction.Constants.SECTION_FOOTER
                                'For two UI control section different function names for sub function
                                If Section.SectionID = CommonFunction.Constants.SECTION_HEADER Then
                                    m_strSectionDivID = Section.DivSectionTag
                                    sbEnabledControls.Append(vbCrLf + " function " + m_strEnabledControlsFunctionHeaderSection + "() {")
                                ElseIf Section.SectionID = CommonFunction.Constants.SECTION_FOOTER Then
                                    sbEnabledControls.Append(vbCrLf + " function " + m_strEnabledControlsFunctionFooterSection + "() {")
                                End If
                                'Plot Header or Footer Section Controls
                                sbEnabledControls.Append(PlotPageControls(Section.SectionID))
                                'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
                                'plot multi insert subtag in header section of tag
                                If m_blnHasMultiInsertSubTag And Section.SectionID = CommonFunction.Constants.SECTION_HEADER Then
                                    PlotSubTags_MultiInsert()
                                    sbEnabledControls.Append(m_sbMultiInsertSubTagEnabledControls.ToString)
                                    m_arrLstMultiInsertSubTagDeletionIDs = Nothing
                                    m_sbMultiInsertSubTagEnabledControls = Nothing
                                End If
                                'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
                                sbEnabledControls.Append(vbCrLf + "}" + vbCrLf)
                            Case CommonFunction.Constants.SECTION_SUBTAG
                                m_strSubTagSectionTag = strSectionTag
                                If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Then
                                    'Show Tabs in EDIT mode only : Plot Sub Tags
                                    If Not m_blnHasMultiInsertSubTag Then 'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
                                        Call PlotSubTags()
                                    End If
                                End If
                            Case CommonFunction.Constants.SECTION_GRAPH
                                'Plot graph section
                                If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Then
                                    'Show Tabs in EDIT mode only : Plot Graphs
                                    Call PlotGraphs()
                                End If
                            Case CommonFunction.Constants.SECTION_RELATED_DATA
                                'Plot Related Data
                                'If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Then
                                'Show Tabs in EDIT mode only : Plot Related Data
                                Call PlotRelatedData()
                                'End If
                        End Select
                        'If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Or Section.SectionID = CommonFunction.Constants.SECTION_FOOTER Then 'WAF3_PB_44 Commented By UmeshJ 14 May 2007
                        HttpContext.Current.Response.Write("</DIV>")
                        'End If 'WAF3_PB_44 Commented By UmeshJ 14 May 2007
                    End If
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised

                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSection")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                        ExtensionArgs.m_Section = Section
                        ExtensionArgs.m_global = m_objGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSection", ExtensionArgs)

                        Section = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'After plotting the section call the After Print Event
                        '--Code Modified:RajeshB            15th Jan 2005
                        '-- Purpose: Wrap the event call in function to allow the inheriting
                        ' class to delegate it anywhere
                        'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSection(Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        Call After_PlotSection(Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        'Addition Ends
                    End If
                    'addition ends.
                    Section = Nothing
                End If
            Next
            sbExpandSections.Append(vbCrLf + "}" + vbCrLf)
            HttpContext.Current.Response.Write("</DIV>")
            m_strEnabledControls = sbEnabledControls.ToString
            m_strSectionClientsideScript = sbExpandSections.ToString + sbClientsideScript.ToString
            'Added By Chakshuta H on 30th-Oct-2015
        Catch ex As Exception
            Throw ex
        Finally
            'Ended By Chakshuta H on 30th-Oct-2015
            sbClientsideScript = Nothing
            sbExpandSections = Nothing
            objSection = Nothing
            sbEnabledControls = Nothing
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            'Added By Chakshuta H on 30th-Oct-2015
        End Try
        'Ended By Chakshuta H on 30th-Oct-2015
    End Sub
    Protected Overridable Sub After_PlotSection(ByVal Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.After_PlotSection(Args, WhizGlobal, PrimaryKey)
    End Sub

    Protected Overridable Sub After_PlotSectionTitle(ByVal Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.After_PlotSectionTitle(Args, WhizGlobal, PrimaryKey)
    End Sub
    Protected Overridable Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSectionTitle(Cancel, Args, WhizGlobal, PrimaryKey)
    End Sub
    Protected Overridable Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSection(Cancel, Args, WhizGlobal, PrimaryKey)
    End Sub
    Private Function PrepareSectionObject(ByVal SectionID As Long, ByVal TagSectionID As Long, ByVal Height As Long, ByVal OrderNumber As Long, ByVal IsActive As Boolean, ByVal ShowSectionTitle As Boolean, ByVal SectionTitle As String, ByVal SectionTitleAlignment As String, ByVal DivSectionTag As String, ByVal FunctionName As String, Optional ByVal DisplayPosition As Integer = CommonFunctions.Constants.SECTION_DISPLAY_POSITION_UI) As EventHandlers.WAF_Section
        '=====================================================================
        ' Procedure Name        :	PrepareSectionObject
        ' Purpose               :	Prepare Section Object will be used for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	Section Object
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 09, 2004
        ' Revisions             :
        '=====================================================================
        Dim Section As EventHandlers.WAF_Section
        With Section
            .TagSectionID = TagSectionID
            .SectionID = SectionID
            .OrderNumber = OrderNumber
            .Height = Height
            .ShowSectionTitle = ShowSectionTitle
            .IsActive = IsActive
            If ShowSectionTitle = True Then
                .SectionTitle = SectionTitle
            Else
                .SectionTitle = ""
            End If
            .SectionTitleAlignment = SectionTitleAlignment
            .DivSectionTag = DivSectionTag
            .FunctionName = FunctionName
            .DisplayPosition = DisplayPosition
        End With
        'Return the object 
        PrepareSectionObject = Section
    End Function

    Private Sub PlotSubTagSections()
        '=====================================================================
        ' Procedure Name        :	PlotSubTagSections
        ' Purpose               :	This function is used to plot the Sub Page Sections
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 29, 2003 
        ' Revisions             :
        '=====================================================================
        Dim sbClientsideScript As New System.Text.StringBuilder
        Dim sbEnabledControls As New System.Text.StringBuilder
        Dim sbExpandSections As New System.Text.StringBuilder(vbCrLf + " function " + m_strexpandSectionsFunction + "() { ")
        Dim intLength As Integer
        Dim intIndex As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        Dim intNoOfActiveSections As Integer = 0
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Sub Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objGlobal.TagID, String) + "-0")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-0")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objGlobal.TagID, String) + "-0")
            End If
        End If
        If objSection Is Nothing Then Return
        intLength = objSection.Length - 1

        'Modified by PrasannaP on 30th May 2005
        'Issue ID 18888
        'HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:400px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
        HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:500px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")

        'Get the Number of active sections
        For intIndex = 0 To intLength
            If objSection(intIndex).IsActive = True Then intNoOfActiveSections += 1
        Next

        For intIndex = 0 To intLength
            If objSection(intIndex).IsActive = True Then
                'If the Div Height is not specified in the div style then apply it from the
                'value specified in the Height property
                Dim lngDivHeight As Long
                Dim strDivStyle As String = "OVERFLOW:auto; WIDTH:100%;"
                Dim strSectionTag As String = "divSection" + objSection(intIndex).SectionID.ToString
                Dim strFunctionName As String = "showHide_" + strSectionTag

                Dim blnCancelSection As Boolean = False
                'Create object of the Section Structure
                Dim Section As EventHandlers.WAF_Section = PrepareSectionObject(objSection(intIndex).SectionID, objSection(intIndex).TagSectionID, objSection(intIndex).Height, objSection(intIndex).OrderNumber, objSection(intIndex).IsActive, objSection(intIndex).ShowSectionTitle, objSection(intIndex).SectionTitle, objSection(intIndex).SectionTitleAlignment, strSectionTag, strFunctionName)
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "Before_PlotSection")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                    ExtensionArgs.m_Section = Section
                    ExtensionArgs.Cancel = blnCancelSection
                    ExtensionArgs.m_global = m_objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "Before_PlotSection", ExtensionArgs)
                    blnCancelSection = ExtensionArgs.Cancel
                    Section = ExtensionArgs.m_Section
                    m_objGlobal = ExtensionArgs.m_global
                    m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    'Call the Before plot section event...pass the section structure by ref
                    '--Code Modified:RajeshB            15th Jan 2005
                    '-- Purpose: Wrap the event call in function to allow the inheriting
                    ' class to delegate it anywhere
                    'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSection(blnCancelSection, Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    Call Before_PlotSection(blnCancelSection, Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    'Addition Ends
                End If
                'addition ends.
                'If the only one section present then directly plot the controls
                If blnCancelSection = False And intNoOfActiveSections > 1 And (CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Or objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_FOOTER) Then
                    sbExpandSections.Append(vbCrLf + Section.FunctionName + "(""none"");")

                    'Create object of the Section Structure for sectionTitle
                    Dim SectionTitle As EventHandlers.WAF_Section = PrepareSectionObject(Section.SectionID, Section.TagSectionID, Section.Height, Section.OrderNumber, Section.IsActive, Section.ShowSectionTitle, Section.SectionTitle, Section.SectionTitleAlignment, Section.DivSectionTag, Section.FunctionName)
                    Dim blnCancelSectionTitle As Boolean = False
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised

                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSectionTitle")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.Cancel = blnCancelSectionTitle
                        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                        ExtensionArgs.m_Section = SectionTitle
                        ExtensionArgs.m_global = m_objGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSectionTitle", ExtensionArgs)

                        blnCancelSectionTitle = ExtensionArgs.Cancel
                        SectionTitle = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'Call the Before plot sectionTitle event...pass the sectionTitle structure by ref
                        '--Code Modified:RajeshB            15th Jan 2005
                        '-- Purpose: Wrap the event call in function to allow the inheriting
                        ' class to delegate it anywhere
                        'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        Call Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        'Addition Ends
                    End If
                    'addition ends.
                    If blnCancelSectionTitle = False Then
                        'For each Section - Plot Section Header
                        If objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_FOOTER And m_strMode = "ADD_NEW" Then
                            sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False))
                        Else
                            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                            ''sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False)) 'Request ID: 198 'As the preferences for Sub Tag are not implemented, the preferences links will not be shown for now
                            'Modified By ShrikantB On 15-NOV-2010 For Hide Header-Footer-SubTag Section Title
                            If (objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_HEADER) Then
                                If (CommonFunction.General.GetFrameworkSettings("GEN_SHOW_HEADER_FOOTER_SUBTAG_SECTIONTITLE", "Enabled") = True) Then
                                    sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False)) 'Request ID: 198 'As the preferences for Sub Tag are not implemented, the preferences links will not be shown for now
                                End If
                            Else
                                'Modification End By ShrikantB On 15-NOV-2010 For Hide Header-Footer-SubTag Section Title
                                sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False)) 'Request ID: 198 'As the preferences for Sub Tag are not implemented, the preferences links will not be shown for now
                            End If
                            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 

                        End If
                    End If
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised

                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSectionTitle")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '******************************************************************* 
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                        ExtensionArgs.m_Section = SectionTitle
                        ExtensionArgs.m_global = m_objGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSectionTitle", ExtensionArgs)

                        blnCancelSection = ExtensionArgs.Cancel
                        SectionTitle = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'Call after print event for Section Title
                        '--Code Modified:RajeshB            15th Jan 2005
                        '-- Purpose: Wrap the event call in function to allow the inheriting
                        ' class to delegate it anywhere
                        'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSectionTitle(SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        Call After_PlotSectionTitle(SectionTitle, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                        'Addition Ends


                    End If
                    'addition ends.
                    SectionTitle = Nothing
                End If

                If blnCancelSection = False Then
                    'Plot the Section
                    lngDivHeight = Section.Height
                    If lngDivHeight <> 0 Then
                        strDivStyle += "HEIGHT:" & lngDivHeight.ToString.Trim & "px; "
                    End If

                    HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                    Select Case objSection(intIndex).SectionID
                        Case CommonFunction.Constants.SECTION_HEADER, CommonFunction.Constants.SECTION_FOOTER
                            'For two UI control section different function names for sub function
                            If Section.SectionID = CommonFunction.Constants.SECTION_HEADER Then
                                sbEnabledControls.Append(vbCrLf + " function " + m_strEnabledControlsFunctionHeaderSection + "() {")
                            ElseIf Section.SectionID = CommonFunction.Constants.SECTION_FOOTER Then
                                sbEnabledControls.Append(vbCrLf + " function " + m_strEnabledControlsFunctionFooterSection + "() {")
                            End If
                            sbEnabledControls.Append(PlotPageControls(Section.SectionID))
                            sbEnabledControls.Append(vbCrLf + "}")
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "" Then
                                'Show Tabs in EDIT mode only
                                'Call TAB_PlotSubTags()
                            End If
                        Case CommonFunction.Constants.SECTION_GRAPH
                            Call SubTag_PlotGraph()
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            Call SubTag_PlotRelatedData()
                    End Select
                    HttpContext.Current.Response.Write("</DIV>")
                End If 'Cancel section
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised

                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                    ExtensionArgs.m_Section = Section
                    ExtensionArgs.m_global = m_objGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection", ExtensionArgs)

                    Section = ExtensionArgs.m_Section
                    m_objGlobal = ExtensionArgs.m_global
                    m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    'After plotting the section call the After Print Event
                    '--Code Modified:RajeshB            15th Jan 2005
                    '-- Purpose: Wrap the event call in function to allow the inheriting
                    ' class to delegate it anywhere
                    'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSection(Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    Call After_PlotSection(Section, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    'Addition Ends.
                End If
                'addition ends

                Section = Nothing
            End If
        Next
        sbExpandSections.Append(vbCrLf + "}" + vbCrLf)
        HttpContext.Current.Response.Write("</DIV>")
        m_strEnabledControls = sbEnabledControls.ToString
        m_strSubTagSectionClientsideScript = sbExpandSections.ToString + sbClientsideScript.ToString
        sbClientsideScript = Nothing
        sbExpandSections = Nothing
        objSection = Nothing
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New CommonEngine.CommonPage.cPlotControls(m_objGlobal)
    End Function

    Private Function PlotPageControls(ByVal SectionID As Long) As String
        '=====================================================================
        ' Procedure Name        :	PlotPageControls
        ' Purpose               :	Plot Page Controls
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	Enabled Control Scripts
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 05, 2003 
        ' Revisions             :
        '=====================================================================
        'Plot Controls
        PlotPageControls = ""
        'Code Modified:RajeshB              27 Jan 2005
        ' Purpose: Allow inheritance of cPlotControls
        Dim cobjPlotControls As CommonEngine.CommonPage.cPlotControls
        cobjPlotControls = InitPlotControls()
        'Modification Ends.
        Dim IsEditMode As Boolean = True
        'Is Edit Mode ????? or Insert !! 
        If m_strMode = "ADD_NEW" Then IsEditMode = False
        With cobjPlotControls
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            .ConnectionID = m_intConnectionID
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .FormName = FORM_NAME
            If m_objAccess.Add = False And m_objAccess.Edit = False And m_objAccess.View = True Then
                .IsReadOnly = True
            Else
                .IsReadOnly = False
            End If
            .clsTRSectionHeader = "clsTRGroupHeader" 'Group Header css class
            .FormControlSQL = m_cObjCPSQL.FormSQL
            .PrimaryKeyValue = m_cObjCPSQL.PrimaryKeyValue
            'Yes - No values
            .ValueForYes = MyBase.GetResourceString("YES")
            .ValueForNo = MyBase.GetResourceString("NO")
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 1 June 2007
            .EnableHTMLEncode = m_cObjCPSQL.EnableHTMLEncode
            .ShowNavigationAlert = m_cObjCPSQL.ShowNavigationAlert 'Added By Ninad on 3 Mar 2008, SRID 19375 - Show alerts
            If m_blnIsSubTag = False Then
                If SectionID = CommonFunction.Constants.SECTION_HEADER Then
                    'Header section validations..plot header section controls
                    .PlotControls(SectionID, IsEditMode, m_strFormValidationFunctionHeaderSection)
                Else
                    'Footer section validations..plot footer section controls
                    .PlotControls(SectionID, IsEditMode, m_strFormValidationFunctionFooterSection)
                End If
                If m_cObjCPSQL.ShowNavigationAlert Then m_strControlListForNavAlert += .ControlListForNavAlert 'Added By Ninad on 3 Mar 2008, SRID 19375 - Show alerts
            Else
                .MasterPrimaryKeyValue = m_strForeignKeyValue
                If SectionID = CommonFunction.Constants.SECTION_HEADER Then
                    'Header section validations..plot header section controls
                    .PlotSubTagControls(SectionID, IsEditMode, m_strFormValidationFunctionHeaderSection)
                Else
                    'Footer section validations..plot footer section controls
                    .PlotSubTagControls(SectionID, IsEditMode, m_strFormValidationFunctionFooterSection)
                End If
            End If
            'Client side script
            m_strClientsideScript += .ClientsideScript
            'Control specific functions..will be executed on control events
            m_strClientFunctionBody += .ClientFunctionBody
            'Set focus on the first control
            If m_strSetFocusOnControl.Trim = "" Then m_strSetFocusOnControl = .SetFocusOnControl
            'Enable Controls
            PlotPageControls = .EnableControlsScript
        End With
        'Destroy the object
        cobjPlotControls = Nothing
    End Function
     Private Sub GetAccessRights(Optional ByVal obGlobal As Whiz.WebPage.Templates.AccessRights = Nothing)
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================

        'Create Object of the Access Rights class from the ProjectByNet Template
        m_objAccess = New WebPage.Templates.AccessRights
        'Get the Access Rights 
        m_objAccess.GetAccess(m_objGlobal)
        '__________________Added By PrasannaP on 27-June-2005
        ' Requirement ID        : AR_EV_01
        'Get Page Speicific Access Rights
        Call GetPageSpecificAccessRights(m_objGlobal, m_objAccess)
        '__________________End of modificaton
    End Sub

    Protected Overridable Sub GetPageSpecificAccessRights(ByVal objGlobal As WebPages.Template.IGlobal, ByRef objAccess As WebPage.Templates.AccessRights)
        '=====================================================================
        ' Procedure Name        :	GetPageSpecificAccessRights
        ' Purpose               :	This overridable function overrides the current access rights
        '                           and triggers a event in the Page Specific Behaviour
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	PrasannaP
        ' Created               :	June 27, 2005
        ' Revisions             :
        ' Requirement ID        : AR_EV_01
        '=====================================================================
        Call CommonEngine.General.cPageSpecificBehavior.GetPageSpecificAccessRights(objGlobal, objAccess)
    End Sub

    Public Sub GetMenu(ByVal enmDisplayPosition As WebPage.Templates.DynamicMenu.LinkDisplayPosition, ByVal blnReturnClientsideScript As Boolean)
        '=====================================================================
        ' Procedure Name        :	GetMenu
        ' Purpose               :	Plot the Menu using the DynamicMenu class
        ' Description           :	Same as above
        ' Parameters Passed     :	blnEnablePaging - If Enable Paging then 
        '                           also plot the paging details  
        '                           blnReturnClientsideScript - If true then 
        '                           Return Clientside Script for the dynamic links
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        Dim blnShowBackLink As Boolean = False
        If m_blnIsSubTag = False Then
            'For Sub Tag check back link
            If m_strFromCL = "1" Then blnShowBackLink = True
        Else
            'For master tag check back link
            If m_strSubTagFromCL = "1" Then blnShowBackLink = True
        End If

        m_cObjMenu = New WebPage.Templates.DynamicMenu
        'Code Added:RajeshB         18 Jan 2005
        m_cObjMenu.CommonListPage = strListPage
        m_cObjMenu.CommonFormPage = strFormPage
        'Addition Ends
        Dim strNavigationLinkNames As String()
        Dim strNavigationLinkTooltips As String()
        Dim strNavigationLinkFunctions As String()
        Dim strNavLinks As String() = {"FIRST", "PREVIOUS", "NEXT", "LAST"}

        With m_cObjMenu
            '==========================================================================================================
            'Added By NinadP :	16 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionID = m_intConnectionID
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .CommonQueryString = m_strCommonQueryString
            Dim ValidationRules As String = ""
            Dim EnabledControls As String = ""
            Dim blnHeaderSectionEnabled As Boolean = False
            Dim blnFooterSectionEnabled As Boolean = False

            'Validation function call for Header section
            If m_strMode = "ADD_NEW" Or GetSectionPreferences(CommonFunction.Constants.SECTION_HEADER) = 1 Then ' Request ID: 198 Umesh 09-Feb-07
                ValidationRules += vbCrLf + "if (!" + m_strFormValidationFunctionHeaderSection + "()) { return;}"
                EnabledControls += vbCrLf + m_strEnabledControlsFunctionHeaderSection + "();"
                blnHeaderSectionEnabled = True
            End If
            'Validation function call for Footer section
            If GetSectionPreferences(CommonFunction.Constants.SECTION_FOOTER) = 1 Then
                ValidationRules += vbCrLf + "if (!" + m_strFormValidationFunctionFooterSection + "()) { return;}"
                EnabledControls += vbCrLf + m_strEnabledControlsFunctionFooterSection + "();"
                blnFooterSectionEnabled = True
            End If
            .ValidationRules = ValidationRules '+ UserValidations
            .EnabledControls = EnabledControls
            .IsListPageLink = False
            .UniqueID = m_cObjCPSQL.PrimaryKeyValue
            .MasterPrimaryKeyValue = m_strForeignKeyValue
            .AddNewMode_UIPageOpenInWindow = m_cObjCPSQL.AddMode_UIPageOpenInWindow
            .EditMode_UIPageOpenInWindow = m_cObjCPSQL.EditMode_UIPageOpenInWindow
            .AddNewMode_UIPage = CommonList.ReplaceParameters(m_cObjCPSQL.AddNewMode_UIPage)   '02-July-2007 UmeshJ Request ID: 257
            If m_blnIsSubTag = False Then
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''.AddNewLinkOnUI_CommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&AccessFirstTime=0&FromCL=1" + m_strQuerystringDefaultParameters
                .AddNewLinkOnUI_CommonQueryString = "MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString + "&AccessFirstTime=0&FromCL=1" + m_strQuerystringDefaultParameters
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            Else
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''.AddNewLinkOnUI_CommonQueryString = "SubTagFromCL=1&ForeignKey=" + CommonFunction.General.CheckIsNothing(Request("ForeignKey")) + "&ForeignKeyValue=" + m_strForeignKeyValue + "&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&STAccessFirstTime=0&SubTagPagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strSubTagPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString
                .AddNewLinkOnUI_CommonQueryString = "SubTagFromCL=1&ForeignKey=" + CommonFunction.General.CheckIsNothing(Request("ForeignKey")) + "&ForeignKeyValue=" + m_strForeignKeyValue + "&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&STAccessFirstTime=0&SubTagPagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strSubTagPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            End If
            If m_cObjCPSQL.PrimaryKeyValue <> "" Then
                'For Edit mode
                If blnHeaderSectionEnabled = True Or blnFooterSectionEnabled = True Then
                    .ShowSaveLink = True
                Else
                    .ShowSaveLink = False
                End If
            Else
                .ShowSaveLink = True
            End If
            .ReturnClientsideScript = blnReturnClientsideScript
            .Displayposition = enmDisplayPosition
            'Navigation Details
            .DisplayNavigationLinks = m_cObjCPSQL.DisplayNavigationLinks
            If m_cObjCPSQL.DisplayNavigationLinks = True Then
                'Get Navigation link details
                Call GetNavigationDetails(strNavLinks, strNavigationLinkNames, strNavigationLinkTooltips, strNavigationLinkFunctions)
                .NavigationLinkSysNames = strNavLinks
                .NavigationLinkNames = strNavigationLinkNames
                .NavigationLinkFunctions = strNavigationLinkFunctions
                .NavigationLinkTooltips = strNavigationLinkTooltips
            End If
            'WAF3_PB_42 April 03, 2007 UJ START
            If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.CLASSICAL
            Else
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.DROPDOWN
                .DropdownMenu_HideControls = m_cObjCPSQL.DropdownMenu_HideControls
                .DropdownMenu_EnclosingDiv = ""
                .DropdownMenu_Width = m_cObjCPSQL.DropdownMenu_Width
                .DropdownMenu_TopFillFactor = 1
            End If
            'WAF3_PB_42 April 03, 2007 UJ END
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
            'm_cObjCPSQL
            Response.Write(.DrawMenu(m_objGlobal, m_objAccess.Add, m_objAccess.Edit, m_objAccess.Delete, m_objAccess.View, blnShowBackLink, False, "", True))
            'Clientside script
            'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
            Dim strClientsideScript As String
            strClientsideScript = .ClientsideScript
            'The ClientsideScript now returns the <ACTION_LINK_KEYBOARD_SHORTCUTS>...</ACTION_LINK_KEYBOARD_SHORTCUTS> node which contains the keyboard shortcuts and the corresponding function calls
            If strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>") <> -1 Then
                ReDim Preserve m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0) + 1)
                ReDim Preserve m_strTagID(m_strTagID.GetUpperBound(0) + 1)
                ReDim Preserve blnIsSubTag(blnIsSubTag.GetUpperBound(0) + 1)
                m_strTagID(m_strTagID.GetUpperBound(0)) = m_objGlobal.TagID.ToString
                blnIsSubTag(blnIsSubTag.GetUpperBound(0)) = m_blnIsSubTag
                m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0)) = strClientsideScript.Substring(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>")).Replace("<ACTION_LINK_KEYBOARD_SHORTCUTS>", "").Replace("</ACTION_LINK_KEYBOARD_SHORTCUTS>", "")
                strClientsideScript = strClientsideScript.Remove(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>"))
            End If
            Response.Write(strClientsideScript)
            'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        End With
        'Destroy the object
        m_cObjMenu = Nothing
    End Sub
    Private Sub GetNavigationDetails(ByRef strNavLinks As String(), ByRef strNavigationLinkNames As String(), ByRef strNavigationLinkTooltips As String(), ByRef strNavigationLinkFunctions As String())
        '=====================================================================
        ' Procedure Name        :	GetNavigationDetails
        ' Purpose               :	Get the Navigation links details 
        ' Description           :	This method will prepare the array for the 
        '                           Navigation Links to be dispalyed
        ' Parameters Passed     :	strNavLinks - Four Navigation links
        ' Parameters Affected   :	Following arrays will be set
        '                               strNavigationLinkNames
        '                               strNavigationLinkTooltips
        '                               strNavigationLinkFunctions
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        If m_cObjCPSQL.NavigationLinkSysNames Is Nothing Then Return
        'Dim intLength As Integer = m_cObjCPSQL.NavigationLinkSysNames.Length - 1
        Dim intIndex As Integer
        Dim arrListRowLink As New System.Collections.ArrayList
        Dim arrListRowLinkTooltips As New System.Collections.ArrayList
        Dim arrListRowLinkFunctions As New System.Collections.ArrayList
        Dim intLength As Integer = strNavLinks.Length - 1
        For intIndex = 0 To intLength
            If m_cObjCPSQL.NavigationLinkSysNames.IndexOf(m_cObjCPSQL.NavigationLinkSysNames, strNavLinks(intIndex)) <> -1 Then
                Select Case strNavLinks(intIndex)
                    Case "FIRST"
                        Dim strFilePath As String = "../../Images/NavFirstEnable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_FIRST").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_FIRST"))
                        Else
                            arrListRowLink.Add(">")
                        End If
                        arrListRowLinkFunctions.Add("nav_first_click()")
                        arrListRowLinkTooltips.Add(MyBase.GetResourceString("NAV_LINK_TOOLTIP_FIRST"))
                    Case "PREVIOUS"
                        Dim strFilePath As String = "../../Images/NavPreviousEnable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_PREVIOUS").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_PREVIOUS"))
                        Else
                            arrListRowLink.Add(">")
                        End If
                        arrListRowLinkFunctions.Add("nav_previous_click()")
                        arrListRowLinkTooltips.Add(MyBase.GetResourceString("NAV_LINK_TOOLTIP_PREVIOUS"))
                    Case "NEXT"
                        Dim strFilePath As String = "../../Images/NavNextEnable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_NEXT").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_NEXT"))
                        Else
                            arrListRowLink.Add(">")
                        End If
                        arrListRowLinkFunctions.Add("nav_next_click()")
                        arrListRowLinkTooltips.Add(MyBase.GetResourceString("NAV_LINK_TOOLTIP_NEXT"))
                    Case "LAST"
                        Dim strFilePath As String = "../../Images/NavLastEnable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_LAST").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_LAST"))
                        Else
                            arrListRowLink.Add(">|")
                        End If
                        arrListRowLinkFunctions.Add("nav_last_click()")
                        arrListRowLinkTooltips.Add(MyBase.GetResourceString("NAV_LINK_TOOLTIP_LAST"))
                End Select
            Else
                Dim strStatus As String
                Select Case strNavLinks(intIndex)
                    Case "FIRST"
                        Dim strFilePath As String = "../../Images/NavFirstDisable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_FIRST").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_FIRST"))
                        Else
                            arrListRowLink.Add(">")
                        End If
                        strStatus = MyBase.GetResourceString("NAV_FIRST")
                    Case "PREVIOUS"
                        Dim strFilePath As String = "../../Images/NavPreviousDisable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_PREVIOUS").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_PREVIOUS"))
                        Else
                            arrListRowLink.Add(">")
                        End If
                        strStatus = MyBase.GetResourceString("NAV_FIRST")
                    Case "NEXT"
                        Dim strFilePath As String = "../../Images/NavNextDisable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_NEXT").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_NEXT"))
                        Else
                            arrListRowLink.Add(">")
                        End If
                        strStatus = MyBase.GetResourceString("NAV_LAST")
                    Case "LAST"
                        Dim strFilePath As String = "../../Images/NavLastDisable.gif"
                        If CommonFunction.FileDirectory.IsFileExists(HttpContext.Current.Server.MapPath(strFilePath)) = True Then
                            'Display image
                            arrListRowLink.Add("<Img Border=0 src='" + strFilePath + "'>")
                        ElseIf MyBase.GetResourceString("NAV_LINK_NAME_LAST").ToString.Trim <> "" Then
                            arrListRowLink.Add(MyBase.GetResourceString("NAV_LINK_NAME_LAST"))
                        Else
                            arrListRowLink.Add(">|")
                        End If
                        strStatus = MyBase.GetResourceString("NAV_LAST")
                End Select
                arrListRowLinkFunctions.Add("")
                arrListRowLinkTooltips.Add(strStatus)
            End If
        Next

        'Convert ArrayList into String Array
        Dim strLinkArrayTemp(arrListRowLink.Count - 1) As String
        arrListRowLink.ToArray.CopyTo(strLinkArrayTemp, 0)
        strNavigationLinkNames = strLinkArrayTemp

        'Convert ArrayList into String Array
        Dim strLinkFunctionArrayTemp(arrListRowLinkFunctions.Count - 1) As String
        arrListRowLinkFunctions.ToArray.CopyTo(strLinkFunctionArrayTemp, 0)
        strNavigationLinkFunctions = strLinkFunctionArrayTemp

        'Convert ArrayList into String Array
        Dim strLinkTooltipArrayTemp(arrListRowLinkTooltips.Count - 1) As String
        arrListRowLinkTooltips.ToArray.CopyTo(strLinkTooltipArrayTemp, 0)
        strNavigationLinkTooltips = strLinkTooltipArrayTemp

        arrListRowLink = Nothing
        arrListRowLinkTooltips = Nothing
        arrListRowLinkFunctions = Nothing

    End Sub
    Private Sub CreateForm(Optional ByVal PageCaption As String = "", Optional ByVal ApplyWindowFunctions As Boolean = True)
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
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        ' commented by miiint 23/12/2014
        ' Response.Write("<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0 Transitional//EN'>")
        ' added by miint 23/12/2014
        Response.Write("<!DOCTYPE HTML>")
        Response.Write("<HTML>")
         'Added By Ninad 28 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        Dim strInsertInHEADTag As String = ""
        'Write client side script to show navigation alerts
        strInsertInHEADTag = WriteClientsideScript_ToShowNavigationAlerts()
        strInsertInHEADTag += CommonList.GetStringToBeInsertedInHEADTag(m_objGlobal)
        'Added By Chakshuta H on 30th-Oct-2015

        'Added by NikhilM 16 nov 2010 for Language Support functionality
        If m_bIsLangEnabled Then
            strInsertInHEADTag += WritePluginHeadTagBlock()
        End If
        'Addition End By NikhilM for language support functionality

        'Ended By Chakshuta H on 30th-Oct-2015

        'End Addition By Ninad 28 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert

        'Head Tag
        ' ***************************************************************************************
        ' Modified Aug 27,2004 Rajanikant Khethawatt R.No.WAF2_PB_32
        ' ***************************************************************************************
        If m_blnIsSubTag = False Then
            Response.Write(CommonFunction.General.PlotPageHeadTag(PageCaption, , , , strInsertInHEADTag, True, m_objGlobal.TagID))
        Else
            Response.Write(CommonFunction.General.PlotPageHeadTag(PageCaption, , , , strInsertInHEADTag, True, m_objGlobal.ParentTagID))
        End If
        ' ***************************************************************************************
        ' End Modification Aug 27,2004 Rajanikant Khethawatt
        ' ***************************************************************************************
        'Modified By NileshD 5 Jan 2006 REQID:WAF3_PB_14
        '######### WAF3_PB_41 UJ 23-Mar-2007
        Dim strclsBody As String = "clsPageBody"

        If CommonFunctions.General.CheckIsRTLCultureSupported Then strclsBody = "clsPageBodyRTL" 'Modified By NinadP: Added new class for R to L culture

        If m_cObjCPSQL.SmartNavigation_IsEnabled = True Then
            If m_cObjCPSQL.SmartNavigation_Schema = "V" Then
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''strclsBody = "clsVerticalNavPageBody"
                If CommonFunctions.General.CheckIsRTLCultureSupported Then 'Modified By NinadP: Added new class for R to L culture
                    strclsBody = "clsVerticalNavPageBodyRTL"
                Else
                    strclsBody = "clsVerticalNavPageBody"
                End If
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            Else
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''strclsBody = "clsHorizontalNavPageBody"
                If CommonFunctions.General.CheckIsRTLCultureSupported Then 'Modified By NinadP: Added new class for R to L culture
                    strclsBody = "clsHorizontalNavPageBodyRTL"
                Else
                    strclsBody = "clsHorizontalNavPageBody"
                End If
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            End If
        End If
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''Response.Write("<BODY class='" + strclsBody + "' ")
        'Modified By PushkarK (on Behalf of NinadP): Added Dir for R to L culture
        Dim strDir As String = ""
        If CommonFunctions.General.CheckIsRTLCultureSupported Then
            strDir = " dir='rtl' "
        End If

        Response.Write("<BODY style='overflow:auto;' class='" + strclsBody + "' ") 'Modified by Ninad on 2 june 2009 IssueID-30784
        Response.Write(strDir)
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
        '######### WAF3_PB_41 UJ 23-Mar-2007
        If ApplyWindowFunctions = True Then Response.Write("onload='CP_window_onload()' onresize='CP_window_onresize()'  onresize='CL_window_onresize()' onkeyup='try{OnBodyKeyUp(event);} catch(e){}' ") 'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        'Code Modified:RajeshB      12th Jan 2005
        ' Purpose: Assign ID to a form since netscape works on ID rather than name attribute.
        Response.Write(">")
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''Response.Write("<FORM id='" + FORM_ID + "' name='" + FORM_NAME + "' method=post>")
        'Modified On Behalf of NinadP By PushkarK On 17-Feb-2009 for providing the facility to insert attributes in form tag
        Response.Write("<FORM " + strDir + " id='" + FORM_ID + "' name='" + FORM_NAME + "' " + m_strInsertInFormTag + " method=post>")
        'Modification Ends.

        'Modification Ends By PushkarK (on Behalf of NinadP): Added Dir for R to L culture
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
        'Modification Ends.
    End Sub

    Private Sub EndForm()
        'Form End Tag
        'Added By Chakshuta H on 30th-Oct-2015
        'Added by NikhilM for language support functionality 16 Nov 2010
        WritePluginScriptBlock(False)
        'Addition End by NikhilM 16 Nov 2010
        'Ended By Chakshuta H on 30th-Oct-2015

        Response.Write("</FORM></BODY></HTML>")
    End Sub

    'Added By Chakshuta H on 30th-Oct-2015
    Private Function WritePluginHeadTagBlock() As String
        Dim sbPluginHeadTag As New System.Text.StringBuilder

        sbPluginHeadTag.Append(vbCrLf + " <!-- License Code-->")
        sbPluginHeadTag.Append(vbCrLf + " <OBJECT classid=CLSID:5220cb21-c88d-11cf-b347-00aa00a28331 id=Microsoft_Licensed_Class_Manager_1_0>")
        sbPluginHeadTag.Append(vbCrLf + " <PARAM NAME=""LPKPath"" VALUE=""../IE/iPluginU.lpk"">")
        sbPluginHeadTag.Append(vbCrLf + "</OBJECT>")
        sbPluginHeadTag.Append(vbCrLf + "<!--iPlugin Code-->")
        sbPluginHeadTag.Append(vbCrLf + "<OBJECT id=IPlugin1 style=""LEFT: 0px; TOP: 0px"" codeBase=../IE/Cab/iPluginU.cab classid=clsid:863F1335-1E76-4E41-BA34-CDAFCCE6F561 name=IPlugin1 VIEWASTEXT>")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_Version"" VALUE=""65536"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_ExtentX"" VALUE=""2646"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_ExtentY"" VALUE=""1323"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_StockProps"" VALUE=""0"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""KeyBoard"" VALUE="""">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""Script"" VALUE="""">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""ScriptKey"" VALUE="""">")
        sbPluginHeadTag.Append(vbCrLf + "</OBJECT>")
        sbPluginHeadTag.Append(vbCrLf + "<!--Toolbar-->")
        sbPluginHeadTag.Append(vbCrLf + " <OBJECT classid= ""CLSID:A4831898-C67F-4E66-9D2E-739AD89A1CC7"" codeBase=""../IE/Cab/iToolbar.Cab"" id=""Toolbar"" name=""Toolbar"" style=""LEFT: 0px; TOP: 0px"" VIEWASTEXT>")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_Version"" VALUE=""131072"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_ExtentX"" VALUE=""2646"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_ExtentY"" VALUE=""1323"">")
        sbPluginHeadTag.Append(vbCrLf + "<PARAM NAME=""_StockProps"" VALUE=""0"">")
        sbPluginHeadTag.Append(vbCrLf + "</OBJECT>")
        Return sbPluginHeadTag.ToString
    End Function

    Private Sub WritePluginScriptBlock(ByVal bIsFromPageLoad As Boolean)
        '=====================================================================
        ' Procedure Name        :	WritePluginScriptBlock
        ' Purpose               :	To write the script block for each control for which the language support property is enabled
        '                           in control properties
        ' Description           :	same as above
        ' Parameters Passed     :	indicates whether the script block is to be written onto page or not 
        ' Parameters Affected   :	
        ' Returns               :	
        ' Assumptions           :	None
        ' Dependencies          :	None.
        ' Author                :	NikhilM
        ' Created               :	16 Nov 2010
        ' Revisions             :
        '=====================================================================
        Dim arrSubTagIDs() As Long

        If Not m_blnIsSubTag Then
            WritePluginScriptBlock(bIsFromPageLoad, m_objGlobal.TagID, False)
            If m_blnHasMultiInsertSubTag Then
                arrSubTagIDs = GetSubTagList(m_blnHasMultiInsertSubTag)
                For Each lngSubTagID As Long In arrSubTagIDs
                    WritePluginScriptBlock(bIsFromPageLoad, lngSubTagID, True)
                Next
            End If
        Else
            WritePluginScriptBlock(bIsFromPageLoad, m_objGlobal.TagID, True)
        End If


    End Sub

    Private Sub WritePluginScriptBlock(ByVal bIsFromPageLoad As Boolean, ByVal TagID As Long, ByVal bIsSubTag As Boolean)
        '=====================================================================
        ' Procedure Name        :	WritePluginScriptBlock
        ' Purpose               :	To write the script block for each control for which the language support property is enabled
        '                           in control properties
        ' Description           :	Overload of method of same name, this overloaded method does the actual job of writing the 
        '                           script block
        ' Parameters Passed     :	indicates whether the script block is to be written onto page or not 
        '                           TagID-the tag/subtagid of the current page
        '                           bIsSubTag - indicates whether page is subtag.
        ' Parameters Affected   :	
        ' Returns               :	
        ' Assumptions           :	None
        ' Dependencies          :	None.
        ' Author                :	NikhilM
        ' Created               :	16 Nov 2010
        ' Revisions             :
        '=====================================================================

        Dim arrUICtrlTagMaster() As CommonEngines.HashTables.UIControlTagMaster
        Dim sbBlurFocusScriptBlock As New System.Text.StringBuilder
        Dim strFunctionNameToBeInserted(1) As String


        Const ONBLUR_LANGSUPPORT_FUNCTIONNAME As String = "plugin_close();"
        Const ONFOCUS_LANGSUPPORT_FUNCTIONNAME As String = "plugin_open();"



        If bIsSubTag Then
            arrUICtrlTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubControlTagMasterCPObject(CType(TagID, Long))
        Else
            arrUICtrlTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCPObject(CType(TagID, Long))
        End If



        sbBlurFocusScriptBlock.AppendLine("<script type=text/javascript>")

        'Modified By NikhilM 19 Nov 2010 added Nothing check
        If arrUICtrlTagMaster IsNot Nothing Then
            For Each objUICtrlTagMaster As CommonEngines.HashTables.UIControlTagMaster In arrUICtrlTagMaster
                If objUICtrlTagMaster.ShowInForm AndAlso objUICtrlTagMaster.LanguageSupportID = "1" Then '1 - IPlugin
                    m_bIsLangEnabled = True

                    If bIsFromPageLoad Then
                        Exit Sub
                    Else

                        Dim sbOnBlurCode As New System.Text.StringBuilder
                        Dim sbOnFocusCode As New System.Text.StringBuilder

                        sbBlurFocusScriptBlock.AppendLine(" var obj" + objUICtrlTagMaster.ControlName + " = document.getElementsByName('" + objUICtrlTagMaster.ControlName + "');")
                        sbBlurFocusScriptBlock.AppendLine(" for(var iCnt=0;iCnt<obj" + objUICtrlTagMaster.ControlName + ".length;iCnt++)")
                        sbBlurFocusScriptBlock.AppendLine(" {")

                        sbOnBlurCode.AppendLine("   if(obj" + objUICtrlTagMaster.ControlName + "[iCnt]!=null)")
                        sbOnBlurCode.AppendLine("   {")
                        sbOnBlurCode.AppendLine("       obj" + objUICtrlTagMaster.ControlName + "[iCnt].onblur=function(){ ")

                        sbOnBlurCode.AppendLine(ONBLUR_LANGSUPPORT_FUNCTIONNAME)
                        sbOnFocusCode.AppendLine("  if(obj" + objUICtrlTagMaster.ControlName + "[iCnt]!=null)")
                        sbOnFocusCode.AppendLine("   {")
                        sbOnFocusCode.AppendLine("      obj" + objUICtrlTagMaster.ControlName + "[iCnt].onfocus=function(){ ")
                        sbOnFocusCode.AppendLine(ONFOCUS_LANGSUPPORT_FUNCTIONNAME)

                        If TryParseFunctionCallForControl(CommonFunctions.General.CheckIsNothing(objUICtrlTagMaster.FunctionCall), strFunctionNameToBeInserted) Then
                            sbOnBlurCode.AppendLine(strFunctionNameToBeInserted(0))
                            sbOnFocusCode.AppendLine(strFunctionNameToBeInserted(1))
                        End If
                        sbOnBlurCode.AppendLine("       }") : sbOnFocusCode.AppendLine("        }")
                        sbOnBlurCode.AppendLine("   }") : sbOnFocusCode.AppendLine("    }")
                        sbBlurFocusScriptBlock.AppendLine(sbOnBlurCode.ToString)
                        sbBlurFocusScriptBlock.AppendLine(sbOnFocusCode.ToString)
                        sbBlurFocusScriptBlock.AppendLine("}")
                        sbBlurFocusScriptBlock.AppendLine("")

                        sbOnBlurCode = Nothing
                        sbOnFocusCode = Nothing
                    End If
                End If
            Next
        End If
        'Modification End NikhilM 19 Nov 2010 for Nothing check

        sbBlurFocusScriptBlock.AppendLine("</script>")

        If m_bIsLangEnabled AndAlso bIsFromPageLoad = False Then
            Response.Write(sbBlurFocusScriptBlock.ToString)
        End If

        sbBlurFocusScriptBlock = Nothing
        arrUICtrlTagMaster = Nothing
        strFunctionNameToBeInserted = Nothing

    End Sub

    Private Function TryParseFunctionCallForControl(ByVal strFunctionCall As String, ByRef result() As String) As Boolean
        '=====================================================================
        ' Procedure Name        :	TryParseFunctionCallForControl
        ' Purpose               :	To check if the function call in control properties contains usage of onblur/onfocus,
        '                           parse it, and return the appropriate handler code for those functions
        ' Description           :	same as above
        ' Parameters Passed     :	strFunctionCall contains the function call from ControlProperties 
        ' Parameters Affected   :	result paramter is passed ByRef and hence it will now contain the actual result of parsing of function call.
        ' Returns               :	result of parsing (ByRef) and true/false depending on parse result.
        ' Assumptions           :	None
        ' Dependencies          :	None.
        ' Author                :	NikhilM
        ' Created               :	16 Nov 2010
        ' Revisions             :
        '=====================================================================

        Dim bIsSuccess As Boolean = False

        Dim strFunctionCallLowerCase As String = strFunctionCall.ToLower

        If strFunctionCallLowerCase.Trim <> "" Then
            Dim arrEventAndHandler As String()
            Dim iCnt, iArrIdx As Integer
            'Dim iEqualOpPos() As Integer
            'Dim strTemp As String, strThatRemains As String
            Dim arrSeparators() As String = {"="}
            arrEventAndHandler = strFunctionCallLowerCase.Split(arrSeparators, StringSplitOptions.RemoveEmptyEntries)

            result(0) = ""
            result(1) = ""

            If strFunctionCallLowerCase.Contains("onblur") OrElse strFunctionCallLowerCase.Contains("onfocus") Then

                'Dim regExOnBlur As New Regex("(onblur=|onfocus=)", RegexOptions.ECMAScript)
                'Dim matchedCollection As MatchCollection
                If System.Text.RegularExpressions.Regex.IsMatch(strFunctionCallLowerCase, "(onblur|onfocus)") Then
                    'matchedCollection = Regex.Matches(strFunctionCallLowerCase, "[a-zA-Z0-9 ]+[=]+[\042\047]?[a-zA-Z0-9_ ]+[();]?[\047]?[a-zA-Z0-9_ ]*[\047]?[(); ]?[(); ]?[\042\047]?")
                    'matchedCollection = Regex.Matches(strFunctionCallLowerCase, "on(?!(blur|focus))[.,a-zA-Z0-9 =();\042\047_ ]*")

                    'The RegEx for replace is meant to replace any event=handler code in function call string with blank, if the event under consideration
                    'is not onblur/onfocus
                    strFunctionCall = System.Text.RegularExpressions.Regex.Replace(strFunctionCall, "on(?!(blur|focus))[.,a-zA-Z0-9 =();\042\047_ ]*", "")
                    arrEventAndHandler = System.Text.RegularExpressions.Regex.Split(strFunctionCall, "(onblur|onfocus)", System.Text.RegularExpressions.RegexOptions.IgnoreCase)
                End If

            Else
                Return bIsSuccess
            End If

            If arrEventAndHandler IsNot Nothing AndAlso arrEventAndHandler.Length <> 0 Then
                For iCnt = 1 To arrEventAndHandler.Length - 1 Step 2
                    Select Case arrEventAndHandler(iCnt).Trim.ToLower
                        Case "onblur"
                            result(0) = result(0) + vbCrLf + Replace(arrEventAndHandler(iCnt + 1).Trim.TrimStart(CChar("=")).Trim(CChar("'")), ControlChars.Quote, "")

                        Case "onfocus"
                            result(1) = result(1) + vbCrLf + Replace(arrEventAndHandler(iCnt + 1).Trim.TrimStart(CChar("=")).Trim(CChar("'")), ControlChars.Quote, "")
                    End Select
                Next

                If result(0).Trim <> "" OrElse result(1).Trim <> "" Then
                    If Not result(0).EndsWith(";") Then
                        result(0) = result(0) + ";"
                    End If

                    If Not result(1).EndsWith(";") Then
                        result(1) = result(1) + ";"
                    End If
                    bIsSuccess = True
                End If

            End If
        End If

        Return bIsSuccess
    End Function
    'Ended By Chakshuta H on 30th-Oct-2015

    Private Sub WriteNoItemsToShow(ByVal intSectionID As Integer)
        '=====================================================================
        ' Procedure Name        :	WriteNoItemsToShow
        ' Purpose               :	Write user friendly message as No Items To Show
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - section ID
        ' Parameters Affected   :	None.
        ' Returns               :	none
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 08, 2003
        ' Revisions             :
        '=====================================================================
        Dim strUserMessage As String
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        Select Case intSectionID
            Case CommonFunction.Constants.SECTION_SUBTAG
                'Message for Sub Tag
                strUserMessage = MyBase.GetResourceString("NO_RECORDS")
            Case CommonFunction.Constants.SECTION_GRAPH
                'Message for Graph
                strUserMessage = MyBase.GetResourceString("NO_RECORDS")
            Case CommonFunction.Constants.SECTION_RELATED_DATA
                'Message for Related Data
                strUserMessage = MyBase.GetResourceString("NO_RECORDS")
        End Select
        MyBase.InitializeResources("Resources.CommonPage", "Resources")
        'Plot table to inform the user that there are no record
        'Modified by PrasannaP on 30th May 2005
        'Issue ID 28888
        'CommonFunction.General.WriteHTML("<Table class=clsTable width='100%' cellspacing=0 border=0>")
        CommonFunction.General.WriteHTML("<Table class=clsTable width='99.9%' cellspacing=0 border=0>")
        'End Modification
        CommonFunction.General.WriteHTML("<TR class=clsTROdd><TD align=center>" + strUserMessage)
        CommonFunction.General.WriteHTML("</TD></TR></Table>")
    End Sub
    Private Function GetSectionPreferences(ByVal lngSectionID As Long) As Byte
        '=====================================================================
        ' Procedure Name        :	GetSectionPreferences
        ' Purpose               :	Get Section Preferences
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - section ID
        ' Parameters Affected   :	None.
        ' Returns               :	User Preferences for the section(0-hide,1-show)
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        GetSectionPreferences = 0
        Dim intIndex As Integer
        Dim intLength As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        If m_blnIsSubTag = False Then
            'Master.............>TAG
            'Tag Sections
            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
                'Local culture ID is same as the default culture id
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-0")
            Else
                'Culture ID is other than the default culture id
                'Check if the Culture is supported by the system
                objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-0")
                If objSection Is Nothing Then
                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                    objSection = CommonEngines.HashTables.GetHashTableObject.GetHashTableUISectionObject(CType(m_objGlobal.TagID, String) + "-0")
                End If
            End If
            If objSection Is Nothing Then Return 0
            intLength = objSection.Length - 1
            For intIndex = 0 To intLength
                If objSection(intIndex).SectionID = lngSectionID And objSection(intIndex).IsActive = True Then
                    'The section is active
                    Select Case lngSectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(0)
                            Exit For
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(1)
                            Exit For
                        Case CommonFunction.Constants.SECTION_GRAPH
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(2)
                            Exit For
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(3)
                            Exit For
                        Case CommonFunction.Constants.SECTION_FOOTER
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(4)
                            Exit For
                    End Select
                End If
            Next
        Else
            'Details.............>SUB TAG

            'Tag Sections
            If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
                'Local culture ID is same as the default culture id
                 objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objGlobal.TagID, String) + "-0")
            Else
                'Culture ID is other than the default culture id
                'Check if the Culture is supported by the system
                objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(m_objGlobal.TagID.ToString & CType(m_objGlobal.LCID, String) + "-0")
                If objSection Is Nothing Then
                    'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                    objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objGlobal.TagID, String) + "-0")
                End If
            End If
            If objSection Is Nothing Then Return 0
            intLength = objSection.Length - 1
            For intIndex = 0 To intLength
                If objSection(intIndex).SectionID = lngSectionID And objSection(intIndex).IsActive = True Then
                    Select Case lngSectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(0)
                            Exit For
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(1)
                            Exit For
                        Case CommonFunction.Constants.SECTION_GRAPH
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(2)
                            Exit For
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(3)
                            Exit For
                        Case CommonFunction.Constants.SECTION_FOOTER
                            GetSectionPreferences = m_cObjCPSQL.SectionPreferences(4)
                            Exit For
                    End Select
                End If
            Next
        End If
        'Destroy the object
        objSection = Nothing
    End Function
    Private Function WriteClientsideScript_ToShowNavigationAlerts() As String
        '=====================================================================
        ' Procedure Name        : WriteClientsideScript_ToShowNavigationAlerts
        ' Purpose               : Write Clientside Script To Show Navigation Alerts
        ' Description           : Same as above
        ' Parameters Passed     : None.
        ' Parameters Affected   : None.
        ' Returns               : string as script block
        ' Assumptions           : None.
        ' Dependencies          : None.
        ' Author                : NinadP
        ' Created               : 28 May 2008
        ' Req ID                : WAF3_PB_64
        ' Revisions :
        '=====================================================================
        Dim sbNavigationAlertScript As New System.Text.StringBuilder
        Try
            sbNavigationAlertScript.Append(vbCrLf)
            sbNavigationAlertScript.Append("<SCRIPT Language=javascript>")
            sbNavigationAlertScript.Append(vbCrLf)
            sbNavigationAlertScript.Append("var blnShowNavigationAlert = false;")
            sbNavigationAlertScript.Append(vbCrLf)
            sbNavigationAlertScript.Append("var strControlsToExcludeFrmNavigationAlert='';")
            sbNavigationAlertScript.Append(vbCrLf)
            sbNavigationAlertScript.Append("var blnNavigate = null;")
            sbNavigationAlertScript.Append(vbCrLf)
            sbNavigationAlertScript.Append("var strContainerDivs='';")
            sbNavigationAlertScript.Append(vbCrLf)
            If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then
                If (m_objGlobal.ParentTagID <> 0) Then
                    If CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_objGlobal.ParentTagID).ShowNavigationAlert Then
                        sbNavigationAlertScript.Append("window.onbeforeunload = confirmExit;")
                        sbNavigationAlertScript.Append(vbCrLf)
                        sbNavigationAlertScript.Append("blnShowNavigationAlert = true;")
                        sbNavigationAlertScript.Append(vbCrLf)
                        sbNavigationAlertScript.Append("strContainerDivs = 'divSection1';")
                    End If
                Else
                    If CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(m_objGlobal.TagID).ShowNavigationAlert Then
                        sbNavigationAlertScript.Append("window.onbeforeunload = confirmExit;")
                        sbNavigationAlertScript.Append(vbCrLf)
                        sbNavigationAlertScript.Append("blnShowNavigationAlert = true;")
                        sbNavigationAlertScript.Append(vbCrLf)
                        sbNavigationAlertScript.Append("strContainerDivs = 'divSection1,divSection5';")
                    End If
                End If
            End If
            sbNavigationAlertScript.Append(vbCrLf)
            sbNavigationAlertScript.Append("</SCRIPT>")
            sbNavigationAlertScript.Append(vbCrLf)
            Return sbNavigationAlertScript.ToString
        Catch ex As Exception
        Finally
            sbNavigationAlertScript = Nothing
        End Try
    End Function




    
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
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        'Create the form object...will be used throughout the clientside scripts
        Response.Write(vbCrLf + "   var objfrm;")
        Response.Write(vbCrLf + "   var objdivlist;")
        Response.Write(vbCrLf + "   objfrm = GetFormReference('" + FORM_NAME + "')")
        Response.Write(vbCrLf + "   objdivlist=GetObjectReference('" + FORM_NAME + "','" + m_strDivTag + "')" + vbCrLf)
        'Added By Ninad on 3 Mar 2008, SRID 19375 - Show alerts
        'If m_cObjCPSQL.ShowNavigationAlert Then
        '    Response.Write(vbCrLf + "strControlsForNavAlerts=strControlsForNavAlerts + '" + m_strControlListForNavAlert + "';" + vbCrLf)
        'End If
        'End Addition By Ninad on 3 Mar 2008, SRID 19375 - Show alerts
        If m_strInformativeMessage.Trim <> "" Then
            Response.Write(vbCrLf + m_strInformativeMessage)
        Else
            Response.Write(vbCrLf + "window.status='';")
        End If
        'Form Variables
        If m_strFormVariables.Trim <> "" Then Response.Write(vbCrLf + m_strFormVariables + vbCrLf)
        'Window_OnResize and Window_OnReload
        Call WriteClientsideScript_WindowOnload_Resize()
        'Added By Chakshuta H on 30th-Oct-2015
        WriteClientsideScript_SetTabCollectionBodyStyle() 'Added By Ninad on 3 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
        'Ended By Chakshuta H on 30th-Oct-2015

        'Section script
        Response.Write(vbCrLf + m_strSectionClientsideScript)
        'Enable Controls
        Response.Write(vbCrLf + m_strEnabledControls)
        'Get the form validation script
        Response.Write(vbCrLf + m_strClientsideScript)
        'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
        'write validation script for multi insert subtag
        If m_blnHasMultiInsertSubTag Then
            Response.Write(vbCrLf + m_strSubTagClientsideScript)
            'set the intitial record count on tab of subtag
            If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
                Response.Write(vbCrLf + "SetMultiInsertSubTabInitialRecordCount();")
            End If
        End If
        'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
        'Control Specific Functions
        Response.Write(vbCrLf + m_strClientFunctionBody)
        'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
        'write function body for multi insert subtag
        If m_blnHasMultiInsertSubTag Then
            Response.Write(vbCrLf + m_strSubTagClientFunctionBody)
        End If
        'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
        If Not m_blnIsDesignMode Then 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 29 May 2007
            If CommonFunction.General.CheckIsNothing(Request("FocusOn")) = FocusOn_SUBTAG And m_strSubTagSectionTag.Trim <> "" Then
                Call WriteClientsideScript_SetFocus(m_strSubTagSectionTag)
                'Set focus on first control
                Call WriteClientsideScript_SetFocusOnControl(False)
            Else
                'Set focus on first control
                Call WriteClientsideScript_SetFocusOnControl(True)
            End If
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
        'Reason   - For showing contetx menu in grid.
        '-------------------------------------------------------------------------------------------------------------
        If m_blnConsiderContextMenu AndAlso CommonFunctions.General.CheckIsNothing(m_strContextMenuJsFunction) <> "" Then
            Response.Write(vbCrLf)
            Response.Write(m_strContextMenuJsFunction)
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
        '-------------------------------------------------------------------------------------------------------------

        'WAF3_PB_35
        If CType(CommonFunction.General.GetApplicationKeySetting("Environment"), String) = "P" Then Response.Write(vbCrLf + "disableRightClick();")
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
        'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        If strKeyboardShortcutsAndFunctions.Trim <> "" Then
            'Remove the last comma if specified
            If strKeyboardShortcutsAndFunctions.Trim.Substring(strKeyboardShortcutsAndFunctions.Length - 1) = "," Then
                strKeyboardShortcutsAndFunctions = strKeyboardShortcutsAndFunctions.Trim.Remove(strKeyboardShortcutsAndFunctions.Length - 1)
            End If
            'Remove the first comma if specified
            If strKeyboardShortcutsAndFunctions.Trim.Substring(0, 1) = "," Then
                strKeyboardShortcutsAndFunctions = strKeyboardShortcutsAndFunctions.Trim.Remove(0, 1)
            End If
            'Attach the shortcut to the Tags Shortcut and functions list
            m_strShortcutsAndFunction(0) += strKeyboardShortcutsAndFunctions
        End If
        CommonFunctions.General.WriteKeyboardShortcuts_FunctionCall(m_strShortcutsAndFunction, blnIsSubTag, m_strTagID, m_blnHasMultiInsertSubTag And m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR)
        m_strShortcutsAndFunction = Nothing
        blnIsSubTag = Nothing
        m_strTagID = Nothing
        'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
    End Sub
    'Added By Chakshuta H on 30th-Oct-2015
    Private Sub WriteClientsideScript_InformativeMessage()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_InformativeMessage
        ' Purpose               :	Write Clientside Script to alert using Dpopup(Dpopup Integration) 
        ' Description           :	It needs to call JS function to show Dpopup only after </HTML> tag is closed
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	31 July 2009
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" + vbCrLf)
        If m_strInformativeMessage.Trim <> "" Then
            Response.Write(vbCrLf + m_strInformativeMessage)
        Else
            Response.Write(vbCrLf + "window.status='';")
        End If
        Response.Write(vbCrLf + "</SCRIPT>")
    End Sub
    'Ended By Chakshuta H on 30th-Oct-2015

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
        If m_blnRefreshCL = True Then
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''Response.Write(vbCrLf + "<Script language=javascript>")
            ''Response.Write(vbCrLf + "   refreshParent('frmCommonList','" & strListPage & "','" & strListPage & "');")
            'Added By ShrikantB On 16-NOV-2010 For Filter The QueryString Parameter Data
            Dim m_strQuerystringParameters As String = CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
            If m_strQuerystringParameters.StartsWith("&") Then
                m_strQuerystringParameters = "?" + m_strQuerystringParameters.Remove(0, 1).ToString()
            End If
            'Addition End By ShrikantB On 16-NOV-2010 For Filter The QueryString Parameter Data
            Response.Write(vbCrLf + "<Script language=javascript>")
            Response.Write(vbCrLf + "try { ") 'Added by Vinay on 12 DEC. 2008 WAF3_GEN_18
            Response.Write(vbCrLf + "   refreshParent('frmCommonList','" & strListPage & "','" & strListPage & m_strQuerystringParameters & "');") 'Modified By ShriakntB On 16-NOV-2010 For Filter The QueryString Parameter Data
            Response.Write(vbCrLf + "} catch(e) { } ") 'Added by Vinay on 12 DEC. 2008 WAF3_GEN_18
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
            Response.Write(vbCrLf + "</Script>" + vbCrLf)
        End If
    End Sub
    Private Function WriteClientsideScript_SectionShowHide(ByVal lngSectionID As Long, ByVal functionName As String) As String
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SectionShowHide
        ' Purpose               :	Write Clientside Script for section hide show
        ' Description           :	Same as above
        ' Parameters Passed     :	SectionID and functionName
        ' Parameters Affected   :	None.
        ' Returns               :	WriteClientsideScript for SectionShowHide
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 26, 2003
        ' Revisions             :
        '=====================================================================
        Dim bytValue As Byte = 0
        Dim sbSection As New System.Text.StringBuilder(vbCrLf + " function " + functionName + "() {")
        'Get the User Preference for the section
        bytValue = GetSectionPreferences(lngSectionID)
        'If the previous section preference is show then new section preference will be hide
        If bytValue = 1 Then
            bytValue = 0
        Else
            bytValue = 1
        End If
        'Prepare action accordingly
        If m_strCommonQueryString.Trim = "" Then
            sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strFormPage & "?Operation=SHOW_HIDE&SectionID=" + lngSectionID.ToString + "&SectionIDValue=" + bytValue.ToString & Chr(34))
        Else
            sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strFormPage & "?Operation=SHOW_HIDE&SectionID=" + lngSectionID.ToString + "&SectionIDValue=" + bytValue.ToString + "&" & m_strCommonQueryString & Chr(34))
        End If
 If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then sbSection.Append(vbCrLf + "if(ShowNavigationAlert()==false) return;" + vbCrLf) 'Added By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        sbSection.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
        sbSection.Append(vbCrLf + "}")
        WriteClientsideScript_SectionShowHide = sbSection.ToString
        sbSection = Nothing
    End Function
    Private Sub WriteClientsideScript_SetFocusOnControl(ByVal setFocus As Boolean)
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SetFocusOnControl
        ' Purpose               :	Write Clientside Script for set focus on control
        ' Description           :	Same as above
        ' Parameters Passed     :	setFocus - boolean
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 11, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + " function " + CLCP_SET_FOCUS_FUNCTION + " {")
        If setFocus = True Then Response.Write(vbCrLf + m_strSetFocusOnControl)
        Response.Write(vbCrLf + "}")
    End Sub
    Private Sub WriteClientsideScript_SetFocus(ByVal controlID As String)
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SetFocus
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :   Modified by UmeshJ Nov 14, 2006 '2.0.02-SP5-WAF
        '=====================================================================
        'Response.Write(vbCrLf + "var scAlign=''; if (navigator.appName != 'Microsoft Internet Explorer'){scAlign=false;}")
        Response.Write(vbCrLf + " function setFocusOnTab() {")
        Response.Write(vbCrLf + "  objDiv=GetObjectReference('" + FORM_NAME + "','SubTag" + m_lngCurrentSubTagID.ToString + "')" + vbCrLf)
        Response.Write(vbCrLf + "if (objDiv != null) { ")
        Response.Write(vbCrLf + "  objDiv.scrollIntoView(false);}")
        Response.Write(vbCrLf + "else {")
        'For Sub Tag tabular view set focus on the selected sub tag
        Response.Write(vbCrLf + "  objDiv=GetObjectReference('" + FORM_NAME + "','" + controlID + "')" + vbCrLf)
        Response.Write(vbCrLf + "  if (objDiv != null) { ")
        Response.Write(vbCrLf + "    objDiv.scrollIntoView(false);}")
        Response.Write(vbCrLf + "}}")
    End Sub
    Private Sub WriteClientsideScript_WindowOnload_Resize()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_WindowOnload_Resize
        ' Purpose               :	Write Clientside Script 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 18, 2003
        ' Revisions             :
        '=====================================================================
        Dim intHeightFactor As Integer = 37 'This value is 42 for Whiz 2.0 due to different Navigation schema WAF3_PB_42 April 09, 2007 UmeshJ
        If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PageHeader).Trim <> "" Then intHeightFactor += 10
        If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PageFooter).Trim <> "" Then intHeightFactor += 10
        If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.CPLegend).Trim <> "" Then intHeightFactor += 10
        'If CommonFunction.General.CheckIsNothing(m_cObjCPSQL.SubTagDisplayType).Trim = "C" Then
        '    'For the columner tab display increase the div height. Decrease the deductable intHeightFactor
        '    intHeightFactor -= 50
        'End If
        'WAF3_PB_42 April 06, 2007 UmeshJ
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.DROPDOWN Then intHeightFactor = intHeightFactor - 30
        If (m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.DROPDOWN OrElse CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") = False) Then intHeightFactor = intHeightFactor - 30 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu

        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 

        'WAF3_PB_42 April 06, 2007 UmeshJ
        Response.Write(vbCrLf + "//window resize for Common Page")
        'Added By Chakshuta H on 30th-Oct-2015
        'Added by Ninad on 2 Sept 2008 WAF_GEN_17 TabCollection
        Response.Write(vbCrLf + "var divHeightFactor=" + intHeightFactor.ToString + ";")
        Response.Write(vbCrLf + "try{ if(window.parent.blnTabCollectionExists==true) divHeightFactor = divHeightFactor + 12; }catch(ex){}") 'Modified by Ninad on 2 june 2009 IssueID-30784 
        'End Added by Ninad on 2 Sept 2008 WAF_GEN_17 TabCollection
        'Ended By Chakshuta H on 30th-Oct-2015

        Response.Write(vbCrLf + "	function CP_window_onresize()")
        Response.Write(vbCrLf + "	{")
        Response.Write(vbCrLf + "		var intDivHeight ;")
        Response.Write(vbCrLf + "		var intDivHeightRisk;")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On - Tuesday, July 18, 2006 For  WAF3_GEN_NE_16_06_2006
        'Reason      - For Support Req. ID. - 139
        '              In mozilla based browsers, instead of document.body.offsetHeight, use window.innerHeight.
        '-------------------------------------------------------------------------------------------------------------
        Response.Write(vbCrLf + "		if (navigator.appName == 'Microsoft Internet Explorer'){")

        ''Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - divHeightFactor;") 'Modified by Ninad on 2 Sept 2008 WAF_GEN_17 TabCollection


        Response.Write(vbCrLf + "		}")

        Response.Write(vbCrLf + "		else{")
        ''Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlist.offsetTop - divHeightFactor;") 'Modified by Ninad on 2 Sept 2008 WAF_GEN_17 TabCollection

        Response.Write(vbCrLf + "		}")
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006 
        '                       Support Req. ID. - 139
        '-------------------------------------------------------------------------------------------------------------


        Response.Write(vbCrLf + "		if (intDivHeight < 100)")
        ''Response.Write(vbCrLf + "			intDivHeight = 100;")
        Response.Write(vbCrLf + "			intDivHeight = '100';")

        Response.Write(vbCrLf + "				")
        ''COMMENTED AND added by Nilesh g on 24/11/2015
        '' Response.Write(vbCrLf + "		objdivlist.style.height = intDivHeight + 'px';")
        Response.Write(vbCrLf + "		objdivlist.style.height = intDivHeight-3 + 'px';")
        ''end of COMMENTED AND added by Nilesh g on 24/11/2015
        Response.Write(vbCrLf + "	try{hideAll();} catch(e){}}")

        'Modified by swapnil aswale on 21-1-2016 for browser compatibility issue [url copying security]

        Response.Write(vbCrLf + "	//window onload for Common list")
        Response.Write(vbCrLf + "	function CP_window_onload()")
        Response.Write(vbCrLf + "	{ var brw = isIE(); if(brw=='FF') ")
        Response.Write(vbCrLf + "	{")
        'Added BY NileshD on 24 Oct 2005 for Support REQID:43
        'UJ_24032006 : Conditionally check http referer based on web config file key, implemented for req.for WSS
        'Dim blnValidate_HTTP_REFERER As Boolean = CommonFunction.General.GetFrameworkSettings("GENERAL_VALIDATE_HTTP_REFERER", "Enabled")
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            ' Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
        End If
        Response.Write(vbCrLf + "	} else {  ")
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
        End If
        Response.Write(vbCrLf + "	}  ")
        ''Ended
        'End Of Addition BY NileshD on 24 Oct 2005 Support REQID:43
        Response.Write(vbCrLf + "		var intDivHeight ;")
        Response.Write(vbCrLf + "		var intDivHeightRisk;")
        Response.Write(vbCrLf + "		var lc;")
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On - Tuesday, July 18, 2006 For  WAF3_GEN_NE_16_06_2006
        'Reason      - For Support Req. ID. - 139
        '              In mozilla based browsers, instead of document.body.offsetHeight, use window.innerHeight.
        '-------------------------------------------------------------------------------------------------------------
        Response.Write(vbCrLf + "		if (navigator.appName == 'Microsoft Internet Explorer'){")

        ''Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        Response.Write(vbCrLf + "		intDivHeight = document.body.offsetHeight - objdivlist.offsetTop - divHeightFactor;") 'Modified by Ninad on 2 Sept 2008 WAF_GEN_17 TabCollection


        Response.Write(vbCrLf + "		}")
        Response.Write(vbCrLf + "		else{")
        ''Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlist.offsetTop - " & intHeightFactor & ";")
        Response.Write(vbCrLf + "		intDivHeight = window.innerHeight - objdivlist.offsetTop - divHeightFactor;") 'Modified by Ninad on 2 Sept 2008 WAF_GEN_17 TabCollection

        Response.Write(vbCrLf + "		}")
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. - WAF3_GEN_NE_16_06_2006 
        '                       Support Req. ID. - 139
        '-------------------------------------------------------------------------------------------------------------

        Response.Write(vbCrLf + "		if (intDivHeight < 100)")
        Response.Write(vbCrLf + "			intDivHeight = 100;")
        'Modified by Miiint on 16-Feb-2015 to append px to height
        'Response.Write(vbCrLf + "		objdivlist.style.height = intDivHeight	;")
        ''COMMENTED AND added by Nilesh g on 24/11/2015
        '' Response.Write(vbCrLf + "		objdivlist.style.height = intDivHeight + 'px';")
        Response.Write(vbCrLf + "		objdivlist.style.height = intDivHeight-3 + 'px';")
        ''end of COMMENTED AND added by Nilesh g on 24/11/2015
        If Not m_blnIsDesignMode Then 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 29 May 2007
            Response.Write(vbCrLf + CLCP_SET_FOCUS_FUNCTION)
            If CommonFunction.General.CheckIsNothing(Request("FocusOn")) = FocusOn_SUBTAG And m_strSubTagSectionTag.Trim <> "" Then
                Response.Write(vbCrLf + "	setFocusOnTab();")
                'Added By Chakshuta H on 30th-Oct-2015
            Else
                'on  16 DEC. 2008
                Response.Write(";")
                'Ended By Chakshuta H on 30th-Oct-2015

            End If
        End If
        'Added By Chakshuta H on 30th-Oct-2015
        If m_bIsLangEnabled Then
            Response.Write("plugin_load();")
        End If
        'Ended By Chakshuta H on 30th-Oct-2015

        Response.Write(vbCrLf + "	}")
    End Sub
    'Added By Chakshuta H on 30th-Oct-2015
    Private Sub WriteClientsideScript_SetTabCollectionBodyStyle()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_SetTabCollectionBodyStyle
        ' Purpose               :	Write Clientside Script to set Body Style for page if it is opened in TabCollection 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	NinadP
        ' Created               :	3 July 2009
        ' ReqID                 :   WAF3_PB_74 Tab Collection enhancement
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "   SetTabCollectionBodyStyle(" + CStr(IIf(m_cObjCPSQL.SmartNavigation_IsEnabled, "1", "0")) + ");")
    End Sub
    'Ended By Chakshuta H on 30th-Oct-2015

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
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjPageLegends = New WebPage.Templates.PageLegends
        Dim strHTMLTagImageArray As String() = {CommonFunction.HTMLControls.DrawMandatoryImage(, True)}
        Dim strHTMLTagCaptionArray As String() = {MyBase.GetResourceString("Mandatory")}
        'If No page Legends then add a <BR>
        If strHTMLTagImageArray.Length = 0 And strHTMLTagCaptionArray.Length = 0 Then Response.Write("<BR>")
        Response.Write(m_cObjPageLegends.DrawPageLegendsWithEvents(m_objGlobal, strHTMLTagImageArray, strHTMLTagCaptionArray, False, m_cObjCPSQL.CPLegend))
        'Destroy the object
        m_cObjPageLegends = Nothing
    End Sub
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
        ' Created               :	October 12, 2003
        ' Revisions             :   Modified by PrasannaP on 30th May 2005
        '                           Issue ID= 28888, Added ID field to each hidden control
        '=====================================================================
        'hidden Controls to hold the parameter values 
        Response.Write("<INPUT type=hidden id='MasterTagID' name='MasterTagID' value='" & m_objGlobal.TagID & "'>")
        Response.Write("<INPUT type=hidden id='ParentTagID' name='ParentTagID' value='" & m_objGlobal.ParentTagID & "'>")
        Response.Write("<INPUT type=hidden id='FromWhere' name='FromWhere' value='" & m_objGlobal.FromWhere & "'>")
        Response.Write("<INPUT type=hidden id='FromCL' name='FromCL' value='" & m_strFromCL & "'>")
        Response.Write("<INPUT type=hidden id='" + m_cObjCPSQL.PrimaryKey + "_PK' name='" + m_cObjCPSQL.PrimaryKey + "_PK' value='" & m_cObjCPSQL.PrimaryKeyValue & "'>")
        Response.Write("<INPUT type=hidden id='PagingAlphabet' name='PagingAlphabet' value='" & m_strPagingAlphabet & "'>")
        'Added by Ninad on 22 Nov 2007 Req ID WAF3_PB_55
        If Not m_blnHasMultiInsertSubTag Then
            'write foreign key which is required for multi insert sub tags
            Response.Write("<INPUT type=hidden id='ForeignKeyValue' name='ForeignKeyValue' value='" & m_strForeignKeyValue & "'>")
        End If
        'End Addition by Ninad on 22 Nov 2007 Req ID WAF3_PB_55
        Response.Write("<INPUT type=hidden id='ForeignKey' name='ForeignKey' value='" + CommonFunction.General.CheckIsNothing(Request("ForeignKey")) + "'>")
        Response.Write("<INPUT type=hidden id='SubTagFromCL' name='SubTagFromCL' value='" + m_strSubTagFromCL + "'>")
        Response.Write("<INPUT type=hidden id='STAccessFirstTime' name='STAccessFirstTime' value='0'>")
        Response.Write(CommonFunctions.HTMLControls.DrawTextBox("thisIsADummyControl", "thisIsADummyControl", , , , , , " display:none; ", , , , , "TabIndex=-1", True)) 'Added by Ninad on 15 Feb 2008, To plot dummy control for filter text box, to avoid submiting page, now removed from Whiz.WebForm
        'WAF3_PB_26 UmeshJ 22nd Aug 2006
        If m_cObjCPSQL.PKToken_IsValid = True Then
            HttpContext.Current.Response.Write("<Input Type='hidden' id='PKToken' name='PKToken' value='" + m_cObjCPSQL.PKToken_Value + "'>")
        End If
        'Added By Chakshuta H on 30th-Oct-2015
        '*******************************************************************    
        'Added By ShrikantB On 21-JUL-2010 For Concurrency
        '*******************************************************************    
        If blnMaintainConcurrency = True Then
            If m_objGlobal.ParentTagID <> 0 Then
                HttpContext.Current.Session("SubTagCurrentTimeStamp") = m_cObjCPSQL.CurrentTimeStampValue
            Else
                HttpContext.Current.Session("CurrentTimeStamp") = m_cObjCPSQL.CurrentTimeStampValue
            End If
            Response.Write("<INPUT type=hidden id='" + m_cObjCPSQL.Concurrency_UpdatedDate + "_Timestamp' name='" + m_cObjCPSQL.Concurrency_UpdatedDate + "_Timestamp' value='" & m_cObjCPSQL.CurrentTimeStampValue & "'>")
        End If
        '*******************************************************************    
        'Addition End By ShrikantB On 21-JUL-2010 For Concurrency
        '*******************************************************************    

        'Ended By Chakshuta H on 30th-Oct-2015

    End Sub

    Private Sub PlotPageHeaderFooter(ByVal enmDisplayPosition As WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition, ByVal HeaderFooter As String)
        '=====================================================================
        ' Procedure Name        :	PlotPageHeaderFooter
        ' Purpose               :	Plot the Page Header / Footer
        ' Description           :	Same as above
        ' Parameters Passed     :	enmDisplayPosition - Display Position,
        '                           HeaderFooter - Header/Footer string 
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjHeaderFooter = New WebPage.Templates.HeaderFooter
        With m_cObjHeaderFooter
            .DisplayPosition = enmDisplayPosition
            .HeaderFooter = HeaderFooter
            Response.Write(.DrawHeaderFooter(m_objGlobal))
        End With
        'Destroy the object
        m_cObjHeaderFooter = Nothing
    End Sub

    Private Sub PlotPageCaption(Optional ByVal strLeftCaption As String = "", Optional ByVal strRightCaption As String = "", Optional ByVal strMiddleCaption As String = "")
        '=====================================================================
        ' Procedure Name        :	PlotPageCaption
        ' Purpose               :	Plot the Page Caption
        ' Description           :	Same as above
        ' Parameters Passed     :	strLeftCaption , strRightCaption , strMiddleCaption
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjPageCaption = New WebPage.Templates.PageCaption
        'WAF3_PB_40 Start
        'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        Dim Args As New WebPage.Templates.PageCaption.PageCaptionArgs
        If m_blnIsSubTag = True Then
            Args.RightPageCaption = ""
            Args.ShowCaptionWithNavigation = False
        Else
            Args.RightPageCaption = strRightCaption
            Args.ShowCaptionWithNavigation = True
        End If
        Args.LeftPageCaption = strLeftCaption
        Args.MiddlePageCaption = strMiddleCaption
        Args.ReturnHTML = True
        Args.IsDesignMode = m_blnIsDesignMode
        Dim strPageCaption As String = m_cObjPageCaption.GetPageCaptionsWithEvents(m_objGlobal, Args)
        Args = Nothing
        'End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        'WAF3_PB_40 End
        If strPageCaption <> "" Then Response.Write(strPageCaption + "<BR>")
        'Destroy the object
        m_cObjPageCaption = Nothing
    End Sub

    Private Function PlotSectionTitle(ByVal strSectionTitle As String, ByVal divID_SectionTag As String, ByVal FunctionName As String, ByVal Alignment As String, ByVal SectionID As Long, Optional ByVal blnSaveUserPreferences As Boolean = True, Optional ByVal AllowHideShow As Boolean = True) As String
        '=====================================================================
        ' Procedure Name        :	PlotSectionTitle
        ' Purpose               :	Plot the Section Title
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Dim strLeftSectionTitle As String
        Dim strRightSectionTitle As String
        Dim strMiddleSectionTitle As String
        'According to the Section Title Alignment set the Section Title as LEFT/RIGHT/CENTER
        Select Case Alignment.ToUpper
            Case "LEFT" : strLeftSectionTitle = strSectionTitle
            Case "RIGHT" : strRightSectionTitle = strSectionTitle
            Case "CENTER" : strMiddleSectionTitle = strSectionTitle
            Case Else : strLeftSectionTitle = strSectionTitle
        End Select
        'Create object of the Section Title class from the Templates
        m_cObjSectionTitle = New WebPage.Templates.SectionTitle

        With m_cObjSectionTitle
            If blnSaveUserPreferences = False Then
                Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, , , , , , , AllowHideShow))
                PlotSectionTitle = .ClientsideScript
            Else
                If GetSectionPreferences(SectionID) = 1 Then
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, , , , , , True))
                Else
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, "../../Images/plus.gif", , , , , True))
                End If
                PlotSectionTitle = WriteClientsideScript_SectionShowHide(SectionID, FunctionName)
            End If
        End With
        'Destroy the object
        m_cObjSectionTitle = Nothing
    End Function

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
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Destroy the exists objects
        If Not m_objAccess Is Nothing Then m_objAccess = Nothing
        If Not m_objGlobal Is Nothing Then m_objGlobal = Nothing
        If Not m_cObjCPSQL Is Nothing Then m_cObjCPSQL = Nothing
        'Sub Tag Objects
        If Not m_objSubTagGlobal Is Nothing Then m_objSubTagGlobal = Nothing
        If Not m_objSubTagCLSQL Is Nothing Then m_objSubTagCLSQL = Nothing
        If Not m_objSubTagAccess Is Nothing Then m_objSubTagAccess = Nothing
        If Not m_objSubTagFilters Is Nothing Then m_objSubTagFilters = Nothing
        If Not m_objSubTagCPSQL Is Nothing Then m_objSubTagCPSQL = Nothing
    End Sub

    Public Sub New()
        'Common Page Resource File
        MyBase.InitializeResources("Resources.CommonPage", "Resources")
    End Sub

    '--------------------------------------------------------------------------
    '### Changed By NileshD on 5th Aug 2005 IssueID - 20585
    'Added parameter to function. Pass subtag WhizGlobal object.
    Protected Overridable Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New CommonEngine.CommonList.cSubTagCLSQL(m_objSubTagGlobal)
    End Function
    '### End of chnaged BY NileshD on 5th Aug 2005 IssueID - 20585

    Private Function GetSubTagList(Optional ByVal blnIsMultiInsertSubTag As Boolean = False) As Long()
        '=====================================================================
        ' Procedure Name        :	GetSubTagList
        ' Purpose               :	Get Sub Tag List for the CommonPage
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	Sub Tag array
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 15, 2004
        ' Revisions             :   By - Ninad : Req ID - WAF3_PB_55 - Is Multi Insert Subtag : Dt 1 Nov 2007
        '                           Optional parameter blnIsMultiInsertSubTag is added to signature, it decides the type of subtag
        '=====================================================================
        'Code Modified:RajeshB  28 Jan 2005
        'Purpose CP as an object
        Dim objSubTagCLSQL As CommonEngine.CommonList.cSubTagCLSQL 'New CommonEngine.CommonList.cSubTagCLSQL(m_objGlobal)
        '### Changed By NileshD on 5th Aug 2005 IssueID - 20585
        'Added parameter to function. Pass subtag WhizGlobal object.
        objSubTagCLSQL = InitSubTagCLSQL(m_objGlobal)
        '### End of chnaged NileshD on 5th Aug 2005 IssueID - 20585
        'Modification Ends
        With objSubTagCLSQL
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .ForeignKeyValue = m_cObjCPSQL.PrimaryKeyValue
            'Common Page Sub Tags only
            .IsCPTag = True
            'if blnIsMultiInsertSubTag is true then it will return list of multi insert type subtags
            .GetSubTagList(, blnIsMultiInsertSubTag) 'Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 1 Nov 2007
            GetSubTagList = .SubTagIDArray
        End With
        objSubTagCLSQL = Nothing
    End Function
    Private Sub PlotSubTags()
        '=====================================================================
        ' Procedure Name        :	PlotSubTags
        ' Purpose               :	Plot Sub Tags
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 15, 2003 
        ' Revisions             :
        '=====================================================================
        'Get the SubTag Display Type
        m_strSubTagDisplayType = m_cObjCPSQL.SubTagDisplayType
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            m_lngSubTagID = m_lngCurrentSubTagID
            'Tabular view
            Call PlotSubTagDetails()
            'Added By Chakshuta H on 30th-Oct-2015
            If CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
                Response.Write("<BR>")
            End If

            'Ended By Chakshuta H on 30th-Oct-2015

            ''Response.Write("<BR>")
        Else
            'Columner view
            'Get the Sub Tag list
            Dim arrSubTagList As Long() = GetSubTagList()
            'If no sub tags then exit
            If arrSubTagList Is Nothing Then Return
            'else plot each sub tag in tabular view
            Dim intIndex As Integer
            Dim intLastIndex As Integer = arrSubTagList.Length - 1
            If intLastIndex = 0 Then m_blnIsSingleColumnerTab = True
            For intIndex = 0 To intLastIndex
                'Assign Sub Tag ID as Current
                m_lngSubTagID = arrSubTagList(intIndex)
                Call PlotSubTagDetails()
                ''Response.Write("<BR>")
                If CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
                    Response.Write("<BR>")
                End If
            Next
        End If
        Call FillGeneralObject()
    End Sub
    Private Sub PlotSubTags_MultiInsert()
        '=====================================================================
        ' Procedure Name        :	PlotSubTags_MultiInsert
        ' Purpose               :	Plot Multi Insert Sub Tags
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Req ID                :   WAF3_PB_55
        ' Author                :	NinadP
        ' Created               :	November 1, 2007 
        ' Revisions             :
        '=====================================================================
        'Get the SubTag Display Type
        'write the foreign key value, which is used while inserting new record of multiinsert subtag
        Response.Write("<input type=hidden id=""ForeignKeyValue"" name=""ForeignKeyValue"" value=""" + m_cObjCPSQL.PrimaryKeyValue + """ />")
        m_strSubTagDisplayType = m_cObjCPSQL.SubTagDisplayType
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_COLUMNAR Then
            Response.Write("<BR>")
        End If
        'strSubTagIDs hold the comma seperated subtag IDs in a hidden field, it is required to iterate through loop to show and hide subtag(by clicking on subtag tab)
        Dim strSubTagIDs As String = ""
        'Get the Sub Tag list
        m_arrSubTagList = GetSubTagList(True)
        'If no sub tags then exit
        If m_arrSubTagList Is Nothing Then Return
 Dim strControlsToExcludeFrmNavigationAlert As String = "" 'Added By Ninad 30 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        'else plot each sub tag in tabular view
        Dim intIndex As Integer
        Dim intLastIndex As Integer = m_arrSubTagList.Length - 1
        If intLastIndex = 0 Then m_blnIsSingleColumnerTab = True
        For intIndex = 0 To intLastIndex
            'Assign Sub Tag ID as Current
            m_lngSubTagID = m_arrSubTagList(intIndex)
	strControlsToExcludeFrmNavigationAlert += "," + DELETION_CHECKBOX_NAME_MULTI_INSERT_SUBTAG + m_lngSubTagID.ToString 'Added By Ninad 30 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
            If intIndex = 0 Then
                m_lngCurrentSubTagID = m_lngSubTagID
            End If
            Call PlotSubTagDetails(True)
            If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
                If strSubTagIDs.Trim = "" Then
                    strSubTagIDs = m_lngSubTagID.ToString
                Else
                    strSubTagIDs += "," + m_lngSubTagID.ToString
                End If
            Else
                Response.Write("<BR>")
            End If
        Next
        'write comma seperated list of plotted multiinsert subtags
        'it is required to show hide subtag, when user click on subtags tab
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            Response.Write("<input type=hidden id=""SubTagIDs"" name=""SubTagIDs"" value=""" + strSubTagIDs + """ />")
        End If
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''Response.Write("<script language=javascript> strControlsToExcludeFrmNavigationAlert=strControlsToExcludeFrmNavigationAlert + '," + strControlsToExcludeFrmNavigationAlert + "'; </script>") 'Added By Ninad 30 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        'Added By Ninad on 27 Jan 2009, IssueID-26668 
        If CommonFunctions.General.GetFrameworkSettings("GEN_GRID_FIRSTCOLUMN_EXCELLIKE", "Enabled") Then
            Response.Write("<input type=hidden id=""blnShowFirstColExcelLike"" name=""blnShowFirstColExcelLike"" value=""True"" />")
        End If
        'End Addition By Ninad on 27 Jan 2009, IssueID-26668
        Response.Write("<script language=javascript> strControlsToExcludeFrmNavigationAlert=strControlsToExcludeFrmNavigationAlert + '," + strControlsToExcludeFrmNavigationAlert + "'; </script>") 'Added By Ninad 30 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert

        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 


        Call FillGeneralObject()
        m_arrSubTagList = Nothing
    End Sub
    Private Sub PlotSubTagDetails(Optional ByVal blnIsMultiInsertSubTag As Boolean = False)
        '=====================================================================
        ' Procedure Name        :	PlotSubTagDetails
        ' Purpose               :	Plot Sub Tag Details
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 15, 2004
        ' Revisions             :   By - Ninad : Req ID - WAF3_PB_55 - Is Multi Insert Subtag : Dt 1 Nov 2007
        '                           Optional parameter blnIsMultiInsertSubTag is added to signature, it decides the type of subtag
        '=====================================================================
        'Create Sub Tag high level details
        If SubTag_GetCLSQL(blnIsMultiInsertSubTag) = False Then Return 'Added By - Ninad : Req ID - WAF3_PB_55 - Is Multi Insert Subtag : Dt 1 Nov 2007
        'Deletion Checkbox names different for different Sub Tags
        ''DELETION_CHECKBOX_NAME += m_lngSubTagID.ToString
        DELETION_CHECKBOX_NAME = "chkDelete" + m_lngSubTagID.ToString 'Modified By Ninad on 7 Aug 2009 IssueID-32162


        'Create the WhizGlobal class object
        Call SubTag_FillGlobalObject()
        'Get the Sub Tag Access Details
        Call SubTag_GetAccessRights()

        If m_objSubTagCLSQL.IsCommonPageTab = False Then
            'Plot Sub Tag CommonList
            If Not blnIsMultiInsertSubTag Then 'Added By - Ninad : Req ID - WAF3_PB_55 - Is Multi Insert Subtag : Dt 1 Nov 2007
                Call SubTag_PlotCommonList()
            Else
                Call SubTag_PlotMultiInsertCommonList()
            End If
        Else
            'Plot Sub Tag CommonPage
            Call SubTag_PlotCommonPage()
        End If
    End Sub
    Private Sub PlotTabs()
        '=====================================================================
        ' Procedure Name        :	PlotTabs
        ' Purpose               :	Plot Tabs
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 15, 2003 
        ' Revisions             :
        '=====================================================================
        m_cobjTabs = New WebPage.UI.cTabs
        With m_cobjTabs
            .TabNameArray = m_objSubTagCLSQL.TabNameArray
            .TooltipArray = m_objSubTagCLSQL.TabTooltipArray
            .TabOnclickFunctionArray = m_objSubTagCLSQL.TabFunctionArray
            .TabInformationArray = m_objSubTagCLSQL.TabInformationArray
            .cssClass = "navtab"
            .SelectedTab = m_objSubTagCLSQL.SelectedTab
            .Align = "right"
            .ShowTabInformationOnSameRow = True
            .NoWrap = True
            .ReturnHTML = True
            'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 10 Dec 2007
            If m_objSubTagCLSQL.IsMultiInsertSubTag Then
                .TabTDIds = m_arrSubTagList 'these IDs requiredto assign to subtag table(required to show and hide table)
                Response.Write(.DrawMultiInsertTabs)
            Else
                'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 10 Dec 2007
                Response.Write(.DrawTabs)
            End If
        End With
        m_cobjTabs = Nothing
    End Sub
    Private Function SubTag_GetCLSQL(Optional ByVal blnIsMultiInsertSubTag As Boolean = False) As Boolean
        '=====================================================================
        ' Procedure Name        :	SubTag_GetCLSQL
        ' Purpose               :	Get the Page Details from the database
        ' Description           :	This method access the cSubTagCLSQL class to retrieve 
        '                           the page details required to plot the Sub tag Common List 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :   By - Ninad : Req ID - WAF3_PB_55 - Is Multi Insert Subtag : Dt 1 Nov 2007
        '                           Optional parameter blnIsMultiInsertSubTag is added to signature, it decides the type of subtag
        '=====================================================================
        SubTag_GetCLSQL = True
        If Not m_objSubTagCLSQL Is Nothing Then m_objSubTagCLSQL = Nothing
        '### Changed By NileshD on 5th Aug 2005 IssueID - 20585
        'Added parameter to function InitSubTagCLSQL. Pass subtag WhizGlobal object.
        m_objSubTagCLSQL = InitSubTagCLSQL(m_objGlobal)  'New CommonEngine.CommonList.cSubTagCLSQL(m_objGlobal)
        'End of changed by NileshD on 5th Aug 2005 IssueID - 20585
        With m_objSubTagCLSQL
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .SubTagId = m_lngSubTagID
            'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
            If blnIsMultiInsertSubTag And m_cObjCPSQL.PrimaryKeyValue.Trim = "" Then
                .ForeignKeyValue = "-1"
            Else
                .ForeignKeyValue = m_cObjCPSQL.PrimaryKeyValue
            End If
            If blnIsMultiInsertSubTag Then
                .TabOnclickFunction = "MultiInsertSub" + TAB_ONCLICK_FUNCTION
            Else
                .TabOnclickFunction = TAB_ONCLICK_FUNCTION + m_objGlobal.TagID.ToString
            End If
            .IsMultiInsertSubTag = blnIsMultiInsertSubTag
            'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 6 Nov 2007
            .EditClickFunction = m_strSubTagEditOnclick '+ m_lngSubTagID.ToString
            .MasterDataSource = m_cObjCPSQL.TableName
            .GetSubTagDetails()
            m_lngSubTagID = .SubTagId
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 1 June 2007
        End With
        '__________UmeshJ (13th Aug 2004) : If the Sub Tags exists and the user do not have access
        '__________For any of the Sub Tag then do not show any sub tag
        'If the Sub Tag data is insufficient then show the Message and exit
        If m_objSubTagCLSQL.TabNameArray Is Nothing Then
            If Not blnIsMultiInsertSubTag Then 'Added By Ninad on 18 Mar 2008, WAF3_PB_62 - UI Design Template, do not show msg on filter page
                Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_SUBTAG)
            End If
            SubTag_GetCLSQL = False
        ElseIf m_objSubTagCLSQL.TabNameArray.Length = 0 Then
            If Not blnIsMultiInsertSubTag Then 'Added By Ninad on 18 Mar 2008, WAF3_PB_62 - UI Design Template, do not show msg on filter page
                Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_SUBTAG)
            End If
            SubTag_GetCLSQL = False
        End If
        '__________UmeshJ (13th Aug 2004) : End of modification
    End Function

    Private Sub SubTag_GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	SubTag_GetAccessRights
        ' Purpose               :	Get the Access Details for the Sub Tag 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 18, 2003 
        ' Revisions             :
        '=====================================================================
        'Create Object of the Access Rights class from the ProjectByNet Template
        m_objSubTagAccess = New WebPage.Templates.AccessRights
        'Get the Access Rights 
        m_objSubTagAccess.GetAccess(m_objSubTagGlobal)
        '__________________Added By PrasannaP on 27-June-2005
        ' Requirement ID        : AR_EV_01
        'Get Page Speicific Access Rights
        Call GetPageSpecificAccessRights(m_objSubTagGlobal, m_objSubTagAccess)
        '__________________End of modificaton
    End Sub
    Private Sub SubTag_FillGlobalObject()
        '=====================================================================
        ' Procedure Name        :	SubTag_FillGlobalObject
        ' Purpose               :	Fill the sub tag WhizGlobal object
        ' Description           :	same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 24, 2003 
        ' Revisions             :
        '=====================================================================
        'Fill the Sub tag WhizGlobal object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        m_objSubTagGlobal = MyBase.GlobalObject
        m_objSubTagGlobal.ParentTagID = m_objGlobal.TagID
        m_objSubTagGlobal.TagID = m_objSubTagCLSQL.SubTagId
    End Sub
    Private Sub SubTag_GetCLSQLDetails()
        '=====================================================================
        ' Procedure Name        :	SubTag_GetCLSQLDetails
        ' Purpose               :	Get the Sub Tag Details from the database
        ' Description           :	This method access the cSubTagCLSQL class to retrieve 
        '                           the page details required to plot the Sub tag Common List 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Sub Tag as Common List
        With m_objSubTagCLSQL
            .Add = m_objSubTagAccess.Add
            .Edit = m_objSubTagAccess.Edit
            .Delete = m_objSubTagAccess.Delete
            .View = m_objSubTagAccess.View
            If m_lngCurrentSubTagID = m_lngSubTagID Then
                .PagingAlphabet = m_strSubTagPagingAlphabet
                .SortBy = m_strSubTagSortBy
                .SortOrder = m_strSubTagSortOrder
            End If
            .FilterClause = m_objSubTagFilters.FilterClause
            .GetSettings()
            'Added By NIleshD on 10 Oct 2005 REQID WAF3_PB_10
            If .PagingColumnName <> "" Then
                If m_strSubTagPagingAlphabet.Trim <> "" Then
                    .PagingAlphabet = m_strSubTagPagingAlphabet
                End If
            Else
                .PagingAlphabet = "-1"
            End If
            'End Of Addition By NIleshD on 10 Oct 2005 REQID WAF3_PB_10
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToUpper = CommonFunction.Constants.OPERATION_DELETE And m_lngCurrentSubTagID = m_lngSubTagID Then
                'Commented by PrasannaP on 26th May 2005
                'If .IsIdentityOn = False Then
                '.DeletionIDList = CommonFunctions.General.ConvertCommaSepNumbersToString(CommonFunctions.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)))
                'Else
                .DeletionIDList = CommonFunctions.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME))
                'End If
                '==========================================================================================================
                'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
                '==========================================================================================================
                .ConnectionString = m_strConnectionString
                '==========================================================================================================
                ' Addition End By : Ninad   Req Id : WAF3_PB_33
                '==========================================================================================================
                Call SubTag_BeforeDelete()
                'If Ignore Delete flag is set the do not delete
                If m_blnIgnoreDelete = False Then .DeleteRecords()
                Call SubTag_AfterDelete()
                'After Records Deletion get the Sub Tag Details for new recotrd Count after deletion
                .EditClickFunction = m_strSubTagEditOnclick
                .GetSubTagDetails()

                'Added by PrasannaP on 14th June 2005
                'Requirement ID: RL_CH_01
                If CommonFunction.Constants.APP_TAG_TAB_GROUP_ACCESS = m_lngSubTagID Then
                    CommonEngines.HashTables.CreateHashTables.CreateHashTableRoleAccessCacheGroup()
                End If
            End If
            .GetGridSQL()
            'Modified By NileshD on 23 Jan 2006 Support ReqID:81
            m_strSubTagPagingAlphabet = .PagingAlphabet
            'End Of Modification By NileshD on 23 Jan 2006 Support ReqID:81
            'Added By UmeshJ on 4 Nov 2004 WAF2_PB_15
            HttpContext.Current.Session("CLCP_ExportSQL") = .ExportDataSQL
            HttpContext.Current.Session("CLCP_ExportId") = m_objGlobal.TagID.ToString + CommonFunctions.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS + m_lngSubTagID.ToString
            'End of addition
        End With
        '####___________Added By UmeshJ on 17th May, 2004____________IssueID : 11154
        'Consider Role Level Access flag for the Page
        If m_objSubTagCLSQL.ApplyRoleLevelAccess = False Then
            'if the Role Level Access flag is false then set all access rights as TRUE
            m_objSubTagAccess.Add = True
            m_objSubTagAccess.Delete = True
            m_objSubTagAccess.Edit = True
            m_objSubTagAccess.View = True
        End If
        '_____________________________________________________________
    End Sub
    Private Sub SubTag_GetMultiInsertSubTagCLSQLDetails()
        '=====================================================================
        ' Procedure Name        :	SubTag_GetMultiInsertSubTagCLSQLDetails
        ' Purpose               :	Get the Sub Tag Details from the database for the multi insert subtags
        ' Description           :	This method access the cSubTagCLSQL class to retrieve 
        '                           the page details required to plot the Sub tag Common List 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Req ID                :   WAF3_PB_55
        ' Author                :	NinadP
        ' Created               :	2 Nov 2007
        ' Revisions             :
        '=====================================================================
        'Sub Tag as Common List
        With m_objSubTagCLSQL
            .Add = m_objSubTagAccess.Add
            .Edit = m_objSubTagAccess.Edit
            .Delete = m_objSubTagAccess.Delete
            .View = m_objSubTagAccess.View
            'for add new mode set ForeignKeyValue = -1
            If m_cObjCPSQL.PrimaryKeyValue.Trim = "" Then
                .ForeignKeyValue = "-1"
            End If
            .GetSettings()
            If .PagingColumnName <> "" Then
                If m_strSubTagPagingAlphabet.Trim <> "" Then
                    .PagingAlphabet = m_strSubTagPagingAlphabet
                End If
            Else
                .PagingAlphabet = "-1"
            End If
            'End Of Addition By NIleshD on 10 Oct 2005 REQID WAF3_PB_10 
            If m_strOperation = CommonFunction.Constants.OPERATION_SAVE Then
                Dim strDeletionID As String = ""
                Dim intIndex As Integer
                For intIndex = 0 To m_arrLstMultiInsertSubTagDeletionIDs.Count - 1 Step 2
                    'get the Deletion IDs for the multi insert subtag
                    If CLng(m_arrLstMultiInsertSubTagDeletionIDs(intIndex)) = m_objSubTagCLSQL.SubTagId Then
                        strDeletionID = m_arrLstMultiInsertSubTagDeletionIDs(intIndex + 1).ToString
                        Exit For
                    End If
                Next
                If strDeletionID <> "" Then
                    .DeletionIDList = strDeletionID
                    .ConnectionString = m_strConnectionString
                    Call SubTag_BeforeDelete()
                    'If Ignore Delete flag is set the do not delete
                    If m_blnIgnoreDelete = False Then .DeleteRecords()
                    Call SubTag_AfterDelete()
                    .GetSubTagDetails()
                    If CommonFunction.Constants.APP_TAG_TAB_GROUP_ACCESS = m_lngSubTagID Then
                        CommonEngines.HashTables.CreateHashTables.CreateHashTableRoleAccessCacheGroup()
                    End If
                End If
            End If
            .GetGridSQL()

            m_strSubTagPagingAlphabet = .PagingAlphabet
        End With
        If m_objSubTagCLSQL.ApplyRoleLevelAccess = False Then
            'if the Role Level Access flag is false then set all access rights as TRUE
            m_objSubTagAccess.Add = True
            m_objSubTagAccess.Delete = True
            m_objSubTagAccess.Edit = True
            m_objSubTagAccess.View = True
        End If
        '_____________________________________________________________
    End Sub
    Private Sub SubTag_PlotCommonList()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotCommonList
        ' Purpose               :	This method will Plot the sub tag CommonList
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, November 27, 2003 
        ' Revisions             :
        '=====================================================================
        'Plot User Filters and get the Filter clause
        Call SubTag_GetUserFilter()
        'Get Sub Tag Details
        Call SubTag_GetCLSQLDetails()
        m_objGeneral.IsListPage = True
        'Call Page PreRender Event
        Call SubTag_Page_PreRender()
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            'Plot Tabs
            Call PlotTabs()

            'Modified by PrasannaP on 30th May 2005
            'Issue ID 28888
            'Response.Write("<Table width='100%' class='clsSubTagTable' cellspacing='0' ><TR><TD>")
            Response.Write("<Table width='99.9%' class='clsSubTagTable' cellspacing='0' ><TR><TD>")
            'End Modification
        Else
            If m_blnIsSingleColumnerTab = False Then
                ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                ''Dim strClientsideFunction As String = PlotSectionTitle(m_objSubTagCLSQL.PageCaption, "SubTag" + m_lngSubTagID.ToString, "showHideSubTag" + m_lngSubTagID.ToString, "LEFT", 0, False, True)
                ' ''Client side Show hide function
                ''CommonFunction.General.WriteHTML("<Script Language=Javascript>")
                ''CommonFunction.General.WriteHTML(strClientsideFunction)
                ''CommonFunction.General.WriteHTML("</Script>")
                'Modified By ShrikantB On 15-NOV-2010 For Hide Header Section Title
                If (CommonFunction.General.GetFrameworkSettings("GEN_SHOW_HEADER_FOOTER_SUBTAG_SECTIONTITLE", "Enabled") = True) Then
                    Dim strClientsideFunction As String = PlotSectionTitle(m_objSubTagCLSQL.PageCaption, "SubTag" + m_lngSubTagID.ToString, "showHideSubTag" + m_lngSubTagID.ToString, "LEFT", 0, False, True)
                    'Client side Show hide function
                    CommonFunction.General.WriteHTML("<Script Language=Javascript>")
                    CommonFunction.General.WriteHTML(strClientsideFunction)
                    CommonFunction.General.WriteHTML("</Script>")
                End If
                'Modification End  By ShrikantB On 15-NOV-2010 For Hide Header Section Title
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
                'Div Tag
                CommonFunction.General.WriteHTML("<DIV Id='SubTag" + m_lngSubTagID.ToString + "'  Style=" & Chr(34) + "OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            End If
        End If
        'Common Query String
        'Modified By NileshD on 26 Sep 2005 REQID-WAF3_PB_10
        'm_strSubTagCommonQueryString = "SubTagFromCL=1&ForeignKey=" + m_objSubTagCLSQL.ForeignKey + "&ForeignKeyValue=" + m_objSubTagCLSQL.ForeignKeyValue + "&MasterTagID=" + m_objSubTagGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&SubTagPagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strSubTagPagingAlphabet) + "&ParentTagID=" + m_objSubTagGlobal.ParentTagID.ToString + "&SubTagSortBy=" + m_strSubTagSortBy + "&STAccessFirstTime=0&SubTagSortOrder=" + m_strSubTagSortOrder + CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
        ''Commented And Added By Chakshuta H on 30th-Oct-2015
        ''m_strSubTagCommonQueryString = "SubTagFromCL=1&ForeignKey=" + m_objSubTagCLSQL.ForeignKey + "&ForeignKeyValue=" + m_objSubTagCLSQL.ForeignKeyValue + "&MasterTagID=" + m_objSubTagGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&SubTagPagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strSubTagPagingAlphabet) + "&ParentTagID=" + m_objSubTagGlobal.ParentTagID.ToString + "&SubTagSortBy=" + m_strSubTagSortBy + "&STAccessFirstTime=0&SubTagSortOrder=" + m_strSubTagSortOrder + "&PagingNumber=" + m_intPagingNo.ToString + CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
        ' ***********************************************************************************
        ' Modified Apr 10,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************

        m_strSubTagCommonQueryString = "SubTagFromCL=1&ForeignKey=" + m_objSubTagCLSQL.ForeignKey + "&ForeignKeyValue=" + m_objSubTagCLSQL.ForeignKeyValue + "&MasterTagID=" + m_objSubTagGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&SubTagPagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strSubTagPagingAlphabet) + "&ParentTagID=" + m_objSubTagGlobal.ParentTagID.ToString + "&SubTagSortBy=" + m_strSubTagSortBy + "&STAccessFirstTime=0&SubTagSortOrder=" + m_strSubTagSortOrder + "&PagingNumber=" + m_intPagingNo.ToString + CommonFunction.General.GetQueryStringDefaultParameters(m_objGlobal)
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        'End Of Modification By NileshD on 26 Sep 2005 REQID-WAF3_PB_10

        'By UmeshJ on 21-July-2006 Request ID: 145
        'Change 1st parameter from IsPagingEnabled to enmDisplayPosition
        Call SubTag_GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.LIST_HEAD, True)
        'Legends
        Call SubTag_PlotPageLegends()
        'Filters
        Call SubTag_PlotUserFilters()
        'Page caption
        Call SubTag_PlotCaption()
        'Header
        If CommonFunction.General.CheckIsNothing(m_objSubTagCLSQL.PageHeader).Trim <> "" Then
            Call SubTag_PlotHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER, m_objSubTagCLSQL.PageHeader)
            Response.Write("<BR>")
        End If
        'Plot grid
        'Call SubTag_PlotGrid()
        Call SubTag_PlotSections()
        Response.Write("<BR>")
        'Total records
        If m_objSubTagCLSQL.ShowRecordCountOnCL = True Then Call SubTag_WriteTotalRecords()
        'Footer
        If CommonFunction.General.CheckIsNothing(m_objSubTagCLSQL.PageFooter).Trim <> "" Then
            ''Commented And Added By Chakshuta H on 30th-Oct-2015
            ''Call SubTag_PlotHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER, m_objSubTagCLSQL.PageFooter)
            ''Response.Write("<BR>")
            If CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
                Call SubTag_PlotHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER, m_objSubTagCLSQL.PageFooter)
                Response.Write("<BR>")
            End If
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        End If
        'Menu
        'By UmeshJ on 21-July-2006 Request ID: 145
        'Change 1st parameter from IsPagingEnabled to enmDisplayPosition
        'WAF3_PB_42 April 03, 2007 UJ START
        ''If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
        If (m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL AndAlso CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") = True) Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            Call SubTag_GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.LIST_FOOT, False)
        End If
        'WAF3_PB_42 April 03, 2007 UJ END
        'Client side script
        Call SubTag_WriteClientsideScript()
        'If Deletion Result is specified then display it
        If m_objSubTagCLSQL.DeletionResult.Trim <> "" Then Call WriteClientsideScript_DeletionResult()
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            'For Tabular Form only
            Response.Write("</TD></TR></Table>")
        Else
            If m_blnIsSingleColumnerTab = False Then HttpContext.Current.Response.Write("</DIV>")
        End If
        'Call Page PostRender Event
        Call SubTag_Page_PostRender()

    End Sub

    Private Sub SubTag_PlotMultiInsertCommonList()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotMultiInsertCommonList
        ' Purpose               :	This method will Plot the sub tag Multi Insert Grid
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Req ID                :   WAF3_PB_55 - Is Multi Insert Subtag
        ' Author                :	NinadP
        ' Created               :	November 1, 2007 
        ' Revisions             :
        '=====================================================================
        'Get Sub Tag Details
        Call SubTag_GetMultiInsertSubTagCLSQLDetails()
        m_objGeneral.IsListPage = True
        'Call Page PreRender Event
        Call SubTag_Page_PreRender()
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            'Plot Tabs
            If m_lngSubTagID = m_lngCurrentSubTagID Then
                Call PlotTabs()
            End If
            Response.Write("<Table ")
            'hide the rest of subtag, i.e. other than first one
            If m_lngSubTagID <> m_lngCurrentSubTagID Then
                Response.Write("Style = ""display:none;""")
            End If
            Response.Write(" width='99.9%' class='clsSubTagTable' id='clsSubTagTable" + m_lngSubTagID.ToString + "' name='clsSubTagTable" + m_lngSubTagID.ToString + "' cellspacing='0' ><TR><TD>")
        Else
            If m_blnIsSingleColumnerTab = False Then
                ''Commented And Added By Chakshuta H on 30th-Oct-2015
                ''Dim strClientsideFunction As String = PlotSectionTitle(m_objSubTagCLSQL.PageCaption, "SubTag" + m_lngSubTagID.ToString, "showHideSubTag" + m_lngSubTagID.ToString, "LEFT", 0, False, True)
                ' ''Client side Show hide function
                ''CommonFunction.General.WriteHTML("<Script Language=Javascript>")
                ''CommonFunction.General.WriteHTML(strClientsideFunction)
                ''CommonFunction.General.WriteHTML("</Script>")
                'Modified By ShrikantB On 15-NOV-2010 For Hide Header Section Title
                If (CommonFunction.General.GetFrameworkSettings("GEN_SHOW_HEADER_FOOTER_SUBTAG_SECTIONTITLE", "Enabled") = True) Then
                    Dim strClientsideFunction As String = PlotSectionTitle(m_objSubTagCLSQL.PageCaption, "SubTag" + m_lngSubTagID.ToString, "showHideSubTag" + m_lngSubTagID.ToString, "LEFT", 0, False, True)
                    'Client side Show hide function
                    CommonFunction.General.WriteHTML("<Script Language=Javascript>")
                    CommonFunction.General.WriteHTML(strClientsideFunction)
                    CommonFunction.General.WriteHTML("</Script>")
                End If
                '  'Modification End By ShrikantB On 15-NOV-2010 For Hide Header Section Title
                'Div Tag
                ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
                'Div Tag
                CommonFunction.General.WriteHTML("<DIV Id='SubTag" + m_lngSubTagID.ToString + "'  Style=" & Chr(34) + "OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            End If
        End If
        'Common Query String
        Call SubTag_GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.LIST_HEAD, True)
        'Legends
        Call SubTag_PlotPageLegends()
        'for only columnar style, plot Page Caption
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_COLUMNAR Then
            'Page caption
            Call SubTag_PlotCaption()
        End If
        'Header
        If CommonFunction.General.CheckIsNothing(m_objSubTagCLSQL.PageHeader).Trim <> "" Then
            Call SubTag_PlotHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER, m_objSubTagCLSQL.PageHeader)
            Response.Write("<BR>")
        End If

        Call SubTag_PlotMultiInsertGrid()
        Response.Write("<BR>")
        'Total records
        If m_objSubTagCLSQL.ShowRecordCountOnCL = True Then Call SubTag_WriteTotalRecords()
        'Footer
        If CommonFunction.General.CheckIsNothing(m_objSubTagCLSQL.PageFooter).Trim <> "" Then
            ''Commented And Added By Chakshuta H on 30th-Oct-2015
            ''Call SubTag_PlotHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER, m_objSubTagCLSQL.PageFooter)
            ''Response.Write("<BR>")
            If CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
                Call SubTag_PlotHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER, m_objSubTagCLSQL.PageFooter)
                Response.Write("<BR>")
            End If
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
        End If
        'Menu
        'WAF3_PB_42 April 03, 2007 UJ START
        ''If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
        If (m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL AndAlso CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") = True) Then
            Call SubTag_GetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.LIST_FOOT, False)
        End If
        'If Deletion Result is specified then display it
        If m_objSubTagCLSQL.DeletionResult.Trim <> "" Then Call WriteClientsideScript_DeletionResult()
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            'For Tabular Form only
            Response.Write("</TD></TR></Table>")
        Else
            If m_blnIsSingleColumnerTab = False Then HttpContext.Current.Response.Write("</DIV>")
        End If
        'Call Page PostRender Event
        Call SubTag_Page_PostRender()

    End Sub
    Private Sub SubTag_BeforeDelete()
        '=====================================================================
        ' Procedure Name        :	SubTag_BeforeDelete
        ' Purpose               :	This method will call the before delete event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 27, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_cObjCPSQL.PrimaryKeyValue
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeDelete")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.DeletedIDList = CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME))
            ExtensionArgs.m_global = m_objSubTagGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeDelete", ExtensionArgs)

            m_blnIgnoreDelete = ExtensionArgs.Cancel
            m_objSubTagGlobal = ExtensionArgs.m_global
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB                      17th January, 2005
            'Purpose: Wrap the call into an overridable function.
            '******************************************************************
            'Dim strAction As String = cobjEventHndlr.BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
            ''Dim strActionCode As String
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString 'Modified by Ninad on 20 May 2009 IssueID - 30437 
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015
            Dim strAction As String = BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal, strActionCode)
            'This is referred to in the ExecuteAction function
            cobjEventHndlr.ActionCode = strActionCode
            '*******************************************************************    
            ' Modification Ends - RajeshB
            '******************************************************************
            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.
        cobjEventHndlr = Nothing
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Modified by NileshD on 6-Sep-2005 
        'to pass on the the Primary Key of the main tag
        cobjEventHndlr.MasterPrimaryKey = m_cObjCPSQL.PrimaryKeyValue
        'Pass the subtag's WhizGlobal object insted of tag's WhizGlobal object
        'BeforeDelete = cobjEventHndlr.BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
        BeforeDelete = cobjEventHndlr.BeforeDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objSubTagGlobal)
        'End Of Modification by NileshD on 6-Sep-2005 
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString

    End Function
    Public Sub WriteClientsideScript_ExecuteAction(ByRef cobjEventHndlr As CommonEngine.General.cEventHandlers, ByVal strAction As String)
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_ExecuteAction
        ' Purpose               :	WriteClientsideScript for Executing event Action
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, Feb 23, 2004
        ' Revisions             :
        '=====================================================================
        ' ***************************************************************************************
        ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
        ' ***************************************************************************************
        ' calling a common procedure to write the actions
        Select Case cobjEventHndlr.ActionCode
            Case cobjEventHndlr.ReturnCodes.ON_LOAD.ToString        '#######    EXECUTE SCRIPT IN WINDOW ON LOAD
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.WRITE)

            Case cobjEventHndlr.ReturnCodes.OPEN_WINDOW.ToString    '#######    OPEN NEW WINDOW  
                WriteActionClientSideScript(strAction, ActionType.OPEN)

            Case cobjEventHndlr.ReturnCodes.REDIRECT.ToString       '#######    REDIRECT 
                WriteActionClientSideScript(strAction, ActionType.REDIRECT)

            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE.ToString  '#######    IGNORE DELETE
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.WRITE)
                'Ignore Delete
                m_blnIgnoreDelete = True

            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE.ToString    '##### IGNORE SAVE
                'Ignore save
                m_blnIgnoreSave = True

                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.WRITE)

            Case cobjEventHndlr.ReturnCodes.DO_NOTHING.ToString     '#######    DO NOTHING

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
                ' ***************************************************************************************
            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE_AND_ON_LOAD.ToString
                'Ignore save
                m_blnIgnoreSave = True

                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.WRITE)

            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE_AND_OPEN_WINDOW.ToString
                'Ignore save
                m_blnIgnoreSave = True

                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.OPEN)

            Case cobjEventHndlr.ReturnCodes.IGNORE_SAVE_AND_REDIRECT.ToString
                'Ignore save
                m_blnIgnoreSave = True

                'Execute the Action
                WriteActionClientSideScript(strAction, ActionType.REDIRECT)

            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE_AND_ON_LOAD.ToString
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.WRITE)
                'Ignore Delete
                m_blnIgnoreDelete = True

            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE_AND_OPEN_WINDOW.ToString
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.OPEN)
                'Ignore Delete
                m_blnIgnoreDelete = True
            Case cobjEventHndlr.ReturnCodes.IGNORE_DELETE_AND_REDIRECT.ToString
                'Execute action
                WriteActionClientSideScript(strAction, ActionType.REDIRECT)
                'Ignore Delete
                m_blnIgnoreDelete = True
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
                ' ***************************************************************************************
        End Select
        ' ***************************************************************************************
        ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
        ' ***************************************************************************************
    End Sub

    ' ***************************************************************************************
    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
    ' ***************************************************************************************
    Private Enum ActionType
        OPEN
        REDIRECT
        WRITE
    End Enum

    Private Sub WriteActionClientSideScript(ByVal strAction As String, ByVal ActionType As ActionType)
        '=====================================================================
        ' Procedure Name        :	WriteActionClientSideScript
        ' Purpose               :	This proc is used to write the action script
        '                           based on action type
        ' Description           :	Same as above 
        ' Parameters Passed     :	Action, Action Type
        ' Parameters Affected   :	None
        ' Returns               :	NA
        ' Assumptions           :	
        ' Dependencies          :	
        ' Author                :	Rajanikant Khethawatt
        ' Created               :	Monday, Aug 30, 2004
        ' Revisions             :
        '=====================================================================
        If Trim(strAction & "") = "" Then Exit Sub
        CommonFunction.General.WriteHTML("<Script Laguage=javascript>")
        Select Case ActionType
            Case ActionType.OPEN : CommonFunction.General.WriteHTML("	window.open (" + Chr(34) + strAction + Chr(34) + ",null,""resizable=yes,scrollbars=yes,left="" + (window.screen.width - 600) / 2 + "",top="" + (window.screen.height - 350) / 2 + "",width=600,height=350"");")
            Case ActionType.REDIRECT : CommonFunction.General.WriteHTML("	window.location.href=" + Chr(34) + strAction + Chr(34))
            Case ActionType.WRITE : CommonFunction.General.WriteHTML(strAction)
        End Select
        CommonFunction.General.WriteHTML("</Script>")
    End Sub

    ' ***************************************************************************************
    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_39
    ' ***************************************************************************************
    Public Sub SubTag_AfterDelete()
        '=====================================================================
        ' Procedure Name        :	SubTag_AfterDelete
        ' Purpose               :	This method will call the After delete event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 27, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        cobjEventHndlr.MasterPrimaryKey = m_cObjCPSQL.PrimaryKeyValue
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterDelete")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.DeletedIDList = CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME))
            ExtensionArgs.m_global = m_objSubTagGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterDelete", ExtensionArgs)

            m_objSubTagGlobal = ExtensionArgs.m_global
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '******************************************************************
            'Code Modified:RajeshB                      17th January, 2005
            'Purpose: Wrap the call into an overridable function.
            '******************************************************************
            'Dim strAction As String = cobjEventHndlr.AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objSubTagGlobal)
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            'Dim strActionCode As String
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString 'Modified by Ninad on 20 May 2009 IssueID - 30437 
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            Dim strAction As String = AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal, strActionCode)
            'This is referred to in the ExecuteAction function
            cobjEventHndlr.ActionCode = strActionCode
            '*******************************************************************    
            ' Modification Ends - RajeshB
            '******************************************************************
            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addtion ends.
        cobjEventHndlr = Nothing
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        'Modified by NileshD on 6-Sep-2005 
        'to pass on the the Primary Key of the main tag
        cobjEventHndlr.MasterPrimaryKey = m_cObjCPSQL.PrimaryKeyValue
        'Pass the subtag's WhizGlobal object insted of tag's WhizGlobal object
        'AfterDelete = cobjEventHndlr.AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objGlobal)
        AfterDelete = cobjEventHndlr.AfterDelete(CommonFunction.General.CheckIsNothing(Request.Form(DELETION_CHECKBOX_NAME)), m_objSubTagGlobal)
        'End Of Modification by NileshD on 6-Sep-2005 
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub SubTag_Page_PreRender()
        '=====================================================================
        ' Procedure Name        :	SubTag_Page_PreRender
        ' Purpose               :	This method will call the Pre render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 29, 2003 
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageListPreRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.m_global = m_objSubTagGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageListPreRender", ExtensionArgs)

            m_objSubTagGlobal = ExtensionArgs.m_global
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.PageListPreRender(m_objSubTagGlobal)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = PageListPreRender(m_objSubTagGlobal, strActionCode)
            cobjEventHndlr.ActionCode = strActionCode
            '--Modification Ends.
            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends
        cobjEventHndlr = Nothing
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        PageListPreRender = cobjEventHndlr.PageListPreRender(m_objGlobal)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub SubTag_Page_PostRender()
        '=====================================================================
        ' Procedure Name        :	SubTag_Page_PostRender
        ' Purpose               :	This method will call the Post render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 06, 2004
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageListPostRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.m_global = m_objSubTagGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageListPostRender", ExtensionArgs)


            m_objSubTagGlobal = ExtensionArgs.m_global
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.PageListPostRender(m_objSubTagGlobal)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = PageListPostRender(m_objSubTagGlobal, strActionCode)
            cobjEventHndlr.ActionCode = strActionCode
            '--Modification Ends.
            ' Modification Ends.
            'Execute action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.
        cobjEventHndlr = Nothing
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers
        PageListPostRender = cobjEventHndlr.PageListPostRender(m_objGlobal)
        'Return code set in the shared event handler.
        strActionCode = cobjEventHndlr.ActionCode.ToString
    End Function
    Private Sub SubTag_GetUserFilter()
        '=====================================================================
        ' Procedure Name        :	SubTag_GetUserFilter
        ' Purpose               :	Get User Filter details
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 21, 2003 
        ' Revisions             :
        '=====================================================================
        'Create object of the dynamic filters
        'Changed By NileshD on 1st Sep 2005 for IssueID: 20947
        'm_objSubTagFilters = New CommonEngine.CommonList.cSubTagDynamicFilters(m_objSubTagGlobal)
        m_objSubTagFilters = InitSubTag_DynamicFileters(m_objSubTagGlobal)
        'End of Changed By NileshD on 1st Sep 2005 IssueID: 20947
        With m_objSubTagFilters
            .MasterPrimaryKey = m_cObjCPSQL.PrimaryKeyValue
            'Save the filter settings for the Selected Sub Tag
            If HttpContext.Current.Request.QueryString("SubTagSetFilter") = "1" And m_lngCurrentSubTagID = m_lngSubTagID Then
                .SaveUserFilter(MyBase.GetFormCollectionHashTable)
            End If
            .ReturnHTML = True
            .FunctionName = m_strSubTagFilterFunction + m_lngSubTagID.ToString
            'Added By UmeshJ on 23 Nov 2004
            .FormName = "frmCommonPage"
            .ValidationFunction = VALIDATE_FILTER
            'End
            '==========================================================================================================
            'Added By NinadP :	15 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 29 May 2007
            m_strSubTagUserFilter = .PlotFilters()
            'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
            If m_strSubTagUserFilter.Trim <> "" Then
                .GetFilterClause()
            End If
            'End Addition By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
            'Code Added:RajeshB	14 October, 2004
            'Purpose: Check if event is to be raised
            Dim blnCheckEventCall As Boolean
            blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                "After_Getting_FilterClause")
            If blnCheckEventCall = True Then
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                ExtensionArgs.FilterClause = m_objSubTagFilters.FilterClause

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                        "After_Getting_FilterClause", ExtensionArgs)

                If Not ExtensionArgs Is Nothing Then
                    ExtensionArgs = Nothing
                End If
                'Modification Ends.
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                Call After_Getting_FilterClause(m_objSubTagFilters.FilterClause)
            End If
            'Addition Ends
        End With
    End Sub

    Private Sub SubTag_PlotUserFilters()
        '=====================================================================
        ' Procedure Name        :	PlotUserFilters
        ' Purpose               :	Plot User Filters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 21, 2003 
        ' Revisions             :
        '=====================================================================
        If m_strSubTagUserFilter.Trim <> "" Then
            Response.Write(m_strSubTagUserFilter)
            Response.Write("<BR>")
        End If
    End Sub

    Private Sub SubTag_CreateHiddenParameters()
        '=====================================================================
        ' Procedure Name        :	SubTag_CreateHiddenParameters
        ' Purpose               :	Create hidden Controls to hold the parameter 
        '                           values for which state needs to be persisted
        ' Description           :	Same as above (This func is not in use)
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 18, 2003
        ' Revisions             :   PrasannaP on 30th May 2005
        '                           Issue ID = 28888.... Added ID for each hidden control
        '=====================================================================
        'hidden Controls to hold the parameter values 
        'Response.Write("<INPUT type=hidden name='SubTagID' value='" & m_objSubTagCLSQL.SubTagId & "'>")
        Response.Write("<INPUT type=hidden id='SubTagID' name='SubTagID' value='" & m_lngSubTagID & "'>")
        Response.Write("<INPUT type=hidden id='SubTagPagingAlphabet' name='SubTagPagingAlphabet' value='" & m_objSubTagCLSQL.PagingAlphabet & "'>")
        Response.Write("<INPUT type=hidden id='SubTagSortBy' name='SubTagSortBy' value='" & m_objSubTagCLSQL.SortBy & "'>")
        Response.Write("<INPUT type=hidden id='SubTagSortOrder' name='SubTagSortOrder' value='" & m_objSubTagCLSQL.SortOrder & "'>")
    End Sub

    Private Function SubTag_GetQuerystringParameters(Optional ByVal blnDefaultFilters As Boolean = True, Optional ByVal blnPaging As Boolean = True, Optional ByVal blnSorting As Boolean = True) As String
        '=====================================================================
        ' Procedure Name        :	SubTag_GetQuerystringParameters
        ' Purpose               :	Get SubTag Querystring Parameters
        ' Description           :	Same as above
        ' Parameters Passed     :	Flags whta to include : blnDefaultFilters, blnPaging ,blnSorting
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	January 15, 2003
        ' Revisions             :
        '=====================================================================
        SubTag_GetQuerystringParameters = ""
        'Append Sub Tag Parameter
        SubTag_GetQuerystringParameters += "SubTagID=" + m_lngSubTagID.ToString

        'If Paging is required to be specified in the Query string then get its value and append to the string
        If blnPaging = True Then
            'Append Paging Parameter
            SubTag_GetQuerystringParameters += "&SubTagPagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_objSubTagCLSQL.PagingAlphabet)
        End If

        'If Sorting is required to be specified in the Query string then get its value and append to the string
        If blnSorting = True Then
            'Append Paging Parameter
            SubTag_GetQuerystringParameters += "&SubTagSortBy=" + m_objSubTagCLSQL.SortBy + "&SubTagSortOrder=" + m_objSubTagCLSQL.SortOrder
        End If

        'If Default Filters is required to be specified in the Query string then get its value and append to the string
        'If blnDefaultFilters = True Then
        '    'Append Default Filters
        '    SubTag_GetQuerystringParameters += m_strQuerystringDefaultParameters
        'End If

    End Function

    Private Sub SubTag_GetMenu(ByVal enmDisplayPosition As WebPage.Templates.DynamicMenu.LinkDisplayPosition, ByVal blnReturnClientsideScript As Boolean)
        'Private Sub SubTag_GetMenu(ByVal blnEnablePaging As Boolean, ByVal blnReturnClientsideScript As Boolean)
        '=====================================================================
        ' Procedure Name        :	SubTag_GetMenu
        ' Purpose               :	Plot the Menu using the DynamicMenu class
        ' Description           :	Same as above
        ' Parameters Passed     :	enmDisplayPosition
        '                           blnReturnClientsideScript - If true then 
        '                           Return Clientside Script for the dynamic links
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :   By UmeshJ on 21-July-2006 Request ID: 145
        '                           Change 1st parameter from IsPagingEnabled to enmDisplayPosition
        '=====================================================================
        Dim blnEnablePaging As Boolean = False
        m_cObjMenu = New WebPage.Templates.DynamicMenu
        With m_cObjMenu
            '==========================================================================================================
            'Added By NinadP :	16 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionID = m_intConnectionID
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            'Code Added:RajeshB     17 Feb 2005
            .CommonFormPage = strFormPage
            .CommonListPage = strListPage
            'Addition Ends.
            .CommonQueryString = m_strCommonQueryString + "&" + SubTag_GetQuerystringParameters()
            .SubTagCommonQueryString = m_strSubTagCommonQueryString
            .SubTagID = m_lngSubTagID.ToString
            'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 4 Dec 2007
            If m_objSubTagCLSQL.IsMultiInsertSubTag Then
                .EnabledControls = m_strSubTagEnabledControlsFunctionHeaderSection + m_lngSubTagID.ToString + "();"
            Else
                .EnabledControls = ""
            End If
            'End Addition By - Ninad : Req ID - WAF3_PB_55 : Dt 4 Dec 2007
            .ValidationRules = ""
            .IsListPageLink = True
            .PagingFunctionName = m_strSubTagPagingFunction + m_lngSubTagID.ToString
            .ReturnClientsideScript = blnReturnClientsideScript
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            .MessageForDeleteConfirm = MyBase.GetResourceString("DELETE_CONFIRM")
            .MessageForPagingSelect = MyBase.GetResourceString("SELECT")
            'Added By UmeshJ on 27th August 2004. WAF2 Build 1.  WAF2_PB_2
            If SubTag_GetSectionPreferences(CommonFunctions.Constants.SECTION_HEADER) = 1 Then
                .ShowDeleteLink = m_objSubTagCLSQL.ShowDeleteColumn
            Else
                .ShowDeleteLink = False
            End If
            'End of addition
            'Added By UmeshJ on 27th August 2004. WAF2 Build 1.  WAF2_PB_5
            .ShowConfimationforDelete = m_objSubTagCLSQL.ShowConfimationforDelete
            'End of addition
            'Common Page Resource File
            MyBase.InitializeResources("Resources.CommonPage", "Resources")
            .RecordCount = m_objSubTagCLSQL.RecordCount
            .AddNewMode_UIPage = m_objSubTagCLSQL.AddNewMode_UIPage
            If m_objSubTagCLSQL.IsMultiInsertSubTag Then
                .DeletionCheckboxName = DELETION_CHECKBOX_NAME_MULTI_INSERT_SUBTAG + m_lngSubTagID.ToString
            Else
                .DeletionCheckboxName = DELETION_CHECKBOX_NAME
            End If
            'Added BY NIleshD on 10 Oct 2005 REQID WAF3_PB_10
            .PagingColumnName = m_objSubTagCLSQL.PagingColumnName
            'End Of Addition BY NIleshD on 10 Oct 2005 REQID WAF3_PB_10
            'Modified by UmeshJ on 21-July-2006 Request ID: 145
            'Paging is Optional; Hence if Paging Column is blank then DO NOT PLOT paging
            If enmDisplayPosition.ToString = WebPages.Template.DynamicMenu.LinkDisplayPosition.LIST_HEAD.ToString And m_objSubTagCLSQL.PagingColumnName <> "" Then
                blnEnablePaging = True
                .LinkSQL = m_objSubTagCLSQL.LinkSQL
            End If
            .Displayposition = enmDisplayPosition
            'End Of Addition by UmeshJ on 21-July-2006 Request ID: 145
            .MasterPrimaryKeyValue = m_cObjCPSQL.PrimaryKeyValue
            'WAF3_PB_42 April 03, 2007 UJ START
            If m_objSubTagCLSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.CLASSICAL
            Else
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.DROPDOWN
                .DropdownMenu_HideControls = m_objSubTagCLSQL.DropdownMenu_HideControls
                .DropdownMenu_EnclosingDiv = m_strDivTag
                .DropdownMenu_Width = m_objSubTagCLSQL.DropdownMenu_Width
                If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
                    'Modified By Ninad on 28 Dec 2007 ReqID WAF3_PB_55 
                    If m_blnHasMultiInsertSubTag Then
                        If m_arrSubTagList.Length > 1 Then
                            .DropdownMenu_TopFillFactor = 158
                        Else
                            .DropdownMenu_TopFillFactor = 154
                        End If
                    Else
                        .DropdownMenu_TopFillFactor = 31
                    End If
                Else
                    'For columner its 1
                    If m_blnHasMultiInsertSubTag Then
                        If m_arrSubTagList.Length > 1 Then
                            .DropdownMenu_TopFillFactor = -1
                        Else
                            .DropdownMenu_TopFillFactor = 135
                        End If
                    Else
                        .DropdownMenu_TopFillFactor = -1
                    End If
                    'End Modification By Ninad on 28 Dec 2007 ReqID WAF3_PB_55
                End If
            End If
            'WAF3_PB_42 April 03, 2007 UJ END
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 25 May 2007
            .IsMultiInsertSubTag = m_objSubTagCLSQL.IsMultiInsertSubTag 'Added By - Ninad : Req ID - WAF3_PB_55 : Dt 2 Nov 2007
            .PagingAlphabets = m_objSubTagCLSQL.PagingAlphabets 'Added By Ninad on 7 Feb 2008, Req ID WAF3_PB_59 - Avoid Link SQL - Use Dataset and calculate the paging alphabets
            Response.Write(.DrawMenu(m_objSubTagGlobal, m_objSubTagAccess.Add, m_objSubTagAccess.Edit, m_objSubTagAccess.Delete, m_objSubTagAccess.View, False, blnEnablePaging, m_objSubTagCLSQL.PagingAlphabet, True, m_objSubTagCLSQL.WindowHeight, m_objSubTagCLSQL.WindowWidth))
            'Response.Write(.ClientsideScript)
            'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
            Dim strClientsideScript As String
            strClientsideScript = .ClientsideScript
            If strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>") <> -1 Then
                ReDim Preserve m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0) + 1)
                ReDim Preserve m_strTagID(m_strTagID.GetUpperBound(0) + 1)
                ReDim Preserve blnIsSubTag(blnIsSubTag.GetUpperBound(0) + 1)
                m_strTagID(m_strTagID.GetUpperBound(0)) = m_objSubTagCLSQL.SubTagId.ToString
                blnIsSubTag(blnIsSubTag.GetUpperBound(0)) = True
                m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0)) = strClientsideScript.Substring(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>")).Replace("<ACTION_LINK_KEYBOARD_SHORTCUTS>", "").Replace("</ACTION_LINK_KEYBOARD_SHORTCUTS>", "")
                strClientsideScript = strClientsideScript.Remove(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>"))
            End If
            Response.Write(strClientsideScript)
            'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        End With
        'Destroy the object
        m_cObjMenu = Nothing
    End Sub
    Private Sub SubTag_PlotPageLegends()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotPageLegends
        ' Purpose               :	Plot the Page Legends
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjPageLegends = New WebPage.Templates.PageLegends
        'If No page Legends then add a <BR>
        Dim strLegend As String = m_cObjPageLegends.DrawPageLegendsWithEvents(m_objSubTagGlobal, , , True, m_objSubTagCLSQL.CLLegend)
        If strLegend.Trim = "" Then Response.Write("<BR>")
        Response.Write(strLegend)
        'Destroy the object
        m_cObjPageLegends = Nothing
    End Sub

    Private Sub SubTag_PlotHeaderFooter(ByVal enmDisplayPosition As WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition, ByVal HeaderFooter As String)
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotHeaderFooter
        ' Purpose               :	Plot the Sub Page Header / Footer
        ' Description           :	Same as above
        ' Parameters Passed     :	enmDisplayPosition - Display Position,
        '                           HeaderFooter - Header/Footer string 
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 19, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjHeaderFooter = New WebPage.Templates.HeaderFooter
        With m_cObjHeaderFooter
            .DisplayPosition = enmDisplayPosition
            .HeaderFooter = HeaderFooter
        End With
        Response.Write(m_cObjHeaderFooter.DrawHeaderFooter(m_objSubTagGlobal))
        'Destroy the object
        m_cObjHeaderFooter = Nothing
    End Sub
    Private Function SubTag_PlotCaption() As String
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotCaption
        ' Purpose               :	Plot the Sub Page Caption
        ' Description           :	Same as above
        ' Parameters Passed     :	returnHTML.
        ' Parameters Affected   :	None.
        ' Returns               :	Sub Tag caption
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 19, 2003
        ' Revisions             :   Changed by UmeshJ to remove optional parameter returnHTML
        '=====================================================================
        m_cObjPageCaption = New WebPage.Templates.PageCaption
        'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        Dim Args As New WebPage.Templates.PageCaption.PageCaptionArgs
        Args.LeftPageCaption = m_objSubTagCLSQL.PageCaption
        Args.RightPageCaption = ""
        Args.MiddlePageCaption = ""
        Args.ReturnHTML = True
        Args.IsDesignMode = m_blnIsDesignMode
        Dim strPageCaption As String = m_cObjPageCaption.GetPageCaptionsWithEvents(m_objSubTagGlobal, Args)
        Args = Nothing
        If strPageCaption <> "" Then Response.Write(strPageCaption + "<BR>")
        'End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        'Destroy the object
        m_cObjPageCaption = Nothing
    End Function
    Private Sub SubTag_PlotGrid()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotGrid
        ' Purpose               :	Plot the CommonList Grid using the cSubTag_PlotGrid class
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        'Create the object of main CPlotGrid class
        'Changed By NileshD on 1st Sep. 2005 IssueID: 20947
        'Dim cObjGrid As New CommonEngine.CommonList.cPlotGrid(m_objSubTagGlobal)
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitSubTag_PlotGrid(m_objSubTagGlobal)
        'End Of changed By NileshD on 1st Sep. 2005 IssueID: 20947
        With cObjGrid
            'Form Property values
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .GridSQL = m_objSubTagCLSQL.GridSQL
            .PrimaryKey = m_objSubTagCLSQL.PrimaryKey
            .SortBy = m_objSubTagCLSQL.SortBy
            .SortOrder = m_objSubTagCLSQL.SortOrder
            .CommonQueryString = m_strCommonQueryString
            .RecordCount = m_objSubTagCLSQL.RecordCount
            .GroupHeader = m_objSubTagCLSQL.GroupHeader
            'Use the Statndard Message Resource File
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            .MessageForNoRecords = MyBase.GetResourceString("NO_RECORDS")
            'Common Page Resource File
            MyBase.InitializeResources("Resources.CommonPage", "Resources")
            'From Parameter values
            .ActualColumnArray = m_objSubTagCLSQL.ActualColumnArray
            If m_objSubTagCLSQL.IsAttachmentTab = True Then
                Dim strUFCols() As String = {MyBase.GetResourceString("SR_NO"), MyBase.GetResourceString("FILE_NAME"), MyBase.GetResourceString("FILE_SIZE"), MyBase.GetResourceString("ATTACHED_BY"), MyBase.GetResourceString("ATTACHED_DATE"), MyBase.GetResourceString("ATTACHED_DESCRIPTION")}
                .SrNoColumn = True
                .IsAttachmentGrid = True
                .AttachmentFolderPath = m_objSubTagCLSQL.AttachmentFolderPath
                .UserFriendlyColumnArray = strUFCols
            Else
                .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
                .IsAttachmentGrid = False
                .UserFriendlyColumnArray = m_objSubTagCLSQL.UserFriendlyColumnArray
            End If
            .RowLinkArray = m_objSubTagCLSQL.RowLinkArray
            .RowLinkToolTipArray = m_objSubTagCLSQL.RowLinkToolTipArray
            .FieldDataTypeArray = m_objSubTagCLSQL.FieldDataTypeArray
            .ColumnAlignmentArray = m_objSubTagCLSQL.ColumnAlignmentArray
            .ColumnNoWrapArray = m_objSubTagCLSQL.ColumnNoWrapArray
            .Delete = m_objSubTagAccess.Delete
            .DivHeight = m_objSubTagCLSQL.DivHeight
            .ReturnHTML = False
            'ProjectBtNet Template Common Grid Properties
            .ColumnNameTooltipOnEachRow = True
            .clsColumnHeader = "clsTRColumnHeader"
            'Changed By NileshD on 14 Sep 2005 For IssueID:20886
            .clsTable = "clsGridTable"
            'End of changed By NileshD on 14 Sep 2005 For IssueID:20886
            'Modified By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
            'Use base class CSS classes
            '.clsTREven = "clsTREven"
            '.clsTROdd = "clsTROdd"
            'End of modification By NileshD on 11 Jan 2006 REQID:WAF3_PB_14
            .clsTRGroupHeader = "clsTRSectionHeader"
            .clsSortingColumn = "clsTDSortColHeader"

            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On 15-May-2007 For Requirement ID - WAF3_PB_47
            'Reason      - Set the div id to blank. In the PlotGrid, the DivID will be set to divListTag.
            '              No need to pass the div style.
            '-------------------------------------------------------------------------------------------------------------
            .DivID = "" '"divList"
            ''Modified by PrasannaP on 30th May 2005
            ''Issue ID 28888
            ''.DivStyle = "OVERFLOW:auto; WIDTH:100%"
            '.DivStyle = "OVERFLOW:auto; WIDTH:99.9%"
            ''End Modification
            '-------------------------------------------------------------------------------------------------------------
            'Modification Ends By - PushkarK On 15-May-2007 For Requirement ID - WAF3_PB_47
            '-------------------------------------------------------------------------------------------------------------

            .SortingFunctionName = m_strSubTagSortFunction + m_lngSubTagID.ToString
            .SortByImage = "../../Images/SortBy.gif"
            .SortDownImage = "../../Images/Sort_Down.gif"
            .SortUpImage = "../../Images/Sort_up.gif"
            .TableStyle = "cellspacing=0 cellpadding=0"
            .BoolTrueHTML = MyBase.GetResourceString("YES")
            .BoolFalseHTML = MyBase.GetResourceString("NO")
            .DeletionCheckboxName = DELETION_CHECKBOX_NAME
            .PrimaryColumn = m_objSubTagCLSQL.LinkColumn
            .ShowPrimaryColumnTooltipOnEachRow = True
            'WAF2_PB_2: Added By UmeshJ on 27th August 2004 
            'If m_objSubTagCLSQL.CaptionofDeleteColumn.Trim <> "" Then
            .CaptionForDeleteColumn = m_objSubTagCLSQL.CaptionofDeleteColumn.Trim
            'Else
            '.CaptionForDeleteColumn = MyBase.GetResourceString("DELETE_COLUMN")
            'End If
            .ApplySorting = m_objSubTagCLSQL.EnableSorting
            .EnableHTMLEncode = m_objSubTagCLSQL.EnableHTMLEncode
            .ShowDeleteColumn = m_objSubTagCLSQL.ShowDeleteColumn
            .ShowDeleteColumnFirst = m_objSubTagCLSQL.ShowDeleteColumnFirst 'Added By - Ninad : Req ID - WAF3_PB_58 : Dt 28 Jan 2008
            'End of Addition
            'WAF2_PB_6: Sorting Column array
            .ColumnSortingArray = m_objSubTagCLSQL.ColumnSortingArray
            'WAF2_PB_6: End of Addtion
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: Added By UmeshJ on 1st Sept 2004 for WAF2 Build1
            .ListActionForControlArray = m_objSubTagCLSQL.ListActionForControlArray
            .ListConditionalControlValueArray = m_objSubTagCLSQL.ListConditionalControlValueArray
            .ListConditionClauseArray = m_objSubTagCLSQL.ListConditionClauseArray
            'WAF2_PB_7, WAF2_PB_8, WAF2_PB_9: End of addition
            'WAF2_PB_4: Added By UmeshJ on 6th Sep 2004 for Summary Functions
            .SummaryFuncActualColumnArray = m_objSubTagCLSQL.SummaryFuncActualColumnArray
            .SummaryFuncLevelArray = m_objSubTagCLSQL.SummaryFuncLevelArray
            .SummaryFuncNameArray = m_objSubTagCLSQL.SummaryFuncNameArray
            .SummaryGroupTitle = m_objSubTagCLSQL.SummaryGroupTitle
            .SummaryTotalTitle = m_objSubTagCLSQL.SummaryTotalTitle
            'WAF2_PB_4: End of addition
            'WAF2_PB_68: Added By UmeshJ on 17th Nov 2004 for Optional Tooltip
            .ShowColumnTooltip = m_objSubTagCLSQL.ShowColumnTooltip
            'WAF2_PB_68: End of addition
            'Added By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .IsStaticColumn = m_objSubTagCLSQL.IsStaticColumn
            'End Of Addition By NileshD on 2 Mar 2006 ReqID -  WAF3_PB_17
            .GridDataRows = m_objSubTagCLSQL.GridDataRows 'WAF3_PB_38

            '-------------------------------------------------------------------------------------------------------------
            'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            'Reason   - For showing context menu in the grid. 
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0 : Removed the code for setting m_blnConsiderContextMenu
            .EnableContextMenu = m_objSubTagCLSQL.EnableContextMenu
            .ShowInContextMenuArray = m_objSubTagCLSQL.ShowInContextMenuArray
            .ContextMenuLinkColumn = m_objSubTagCLSQL.ContextMenuLinkColumn  'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            '-------------------------------------------------------------------------------------------------------------
            Response.Write(.PlotGrid())

            'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47
            m_strContextMenuJsFunction += .ContextMenuJsFunction
            m_blnConsiderContextMenu = .EnableContextMenu Or m_blnConsiderContextMenu
            'Addition Ends By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0

        End With
        'Destroy the object    
        cObjGrid = Nothing
    End Sub
    Private Sub SubTag_PlotMultiInsertGrid()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotMultiInsertGrid
        ' Purpose               :	Plot the Sub Tag Multi insert Grid using the cSubTag_PlotGrid class
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Req ID                :   WAF3_PB_55 - Is Multi Insert Subtag
        ' Author                :	Ninad
        ' Created               :	1, 2007 
        ' Revisions             :
        '=====================================================================
        'Create the object of main CPlotGrid class
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitSubTag_PlotGrid(m_objSubTagGlobal)
        With cObjGrid
            .ConnectionString = m_strConnectionString
            .GridSQL = m_objSubTagCLSQL.GridSQL
            .PrimaryKey = m_objSubTagCLSQL.PrimaryKey
            .SortBy = ""
            .SortOrder = ""
            .CommonQueryString = m_strCommonQueryString
            .RecordCount = m_objSubTagCLSQL.RecordCount
            .GroupHeader = m_objSubTagCLSQL.GroupHeader
            'Use the Statndard Message Resource File
            MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            .MessageForNoRecords = MyBase.GetResourceString("NO_RECORDS")
            'Common Page Resource File
            MyBase.InitializeResources("Resources.CommonPage", "Resources")
            'From Parameter values
            .ActualColumnArray = m_objSubTagCLSQL.ActualColumnArray
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
            .IsAttachmentGrid = False
            .UserFriendlyColumnArray = m_objSubTagCLSQL.UserFriendlyColumnArray
            .RowLinkArray = m_objSubTagCLSQL.RowLinkArray
            .RowLinkToolTipArray = m_objSubTagCLSQL.RowLinkToolTipArray
            .FieldDataTypeArray = m_objSubTagCLSQL.FieldDataTypeArray
            .ColumnAlignmentArray = m_objSubTagCLSQL.ColumnAlignmentArray
            .ColumnNoWrapArray = m_objSubTagCLSQL.ColumnNoWrapArray
            .HiddenColumn = m_objSubTagCLSQL.HiddenColumn
            .Delete = m_objSubTagAccess.Delete
            .DivHeight = m_objSubTagCLSQL.DivHeight
            .ReturnHTML = False
            .ColumnNameTooltipOnEachRow = True
            .clsColumnHeader = "clsTRColumnHeader"
            .clsTable = "clsGridTable"
            .clsTRGroupHeader = "clsTRSectionHeader"
            .clsSortingColumn = "clsTDSortColHeader"
            .DivID = "divListTag" + m_objSubTagCLSQL.SubTagId.ToString   '"divList"
            .SortingFunctionName = ""
            .SortByImage = ""
            .SortDownImage = ""
            .SortUpImage = ""
            .TableStyle = "cellspacing=0 cellpadding=0"
            .BoolTrueHTML = MyBase.GetResourceString("YES")
            .BoolFalseHTML = MyBase.GetResourceString("NO")
            .DeletionCheckboxName = DELETION_CHECKBOX_NAME_MULTI_INSERT_SUBTAG + m_lngSubTagID.ToString
            .PrimaryColumn = m_objSubTagCLSQL.LinkColumn
            .ShowPrimaryColumnTooltipOnEachRow = True
            .CaptionForDeleteColumn = m_objSubTagCLSQL.CaptionofDeleteColumn.Trim
            .ApplySorting = False
            .EnableHTMLEncode = m_objSubTagCLSQL.EnableHTMLEncode
            .ShowDeleteColumn = m_objSubTagCLSQL.ShowDeleteColumn
            .ShowDeleteColumnFirst = m_objSubTagCLSQL.ShowDeleteColumnFirst 'Added By - Ninad : Req ID - WAF3_PB_58 : Dt 28 Jan 2008
            .ColumnSortingArray = Nothing
            .ListActionForControlArray = Nothing
            .ListConditionalControlValueArray = Nothing
            .ListConditionClauseArray = Nothing
            .SummaryFuncActualColumnArray = m_objSubTagCLSQL.SummaryFuncActualColumnArray
            .SummaryFuncLevelArray = m_objSubTagCLSQL.SummaryFuncLevelArray
            .SummaryFuncNameArray = m_objSubTagCLSQL.SummaryFuncNameArray
            .SummaryGroupTitle = m_objSubTagCLSQL.SummaryGroupTitle
            .SummaryTotalTitle = m_objSubTagCLSQL.SummaryTotalTitle
            .ShowColumnTooltip = m_objSubTagCLSQL.ShowColumnTooltip
            .SummaryColumnWidthArray = m_objSubTagCLSQL.SummaryColumnWidthArray
            .IsStaticColumn = m_objSubTagCLSQL.IsStaticColumn
            .GridDataRows = m_objSubTagCLSQL.GridDataRows 'WAF3_PB_38
            .EnableContextMenu = False
            .ShowInContextMenuArray = Nothing
            .ContextMenuLinkColumn = m_objSubTagCLSQL.ContextMenuLinkColumn  'Added By - PushkarK On 09-May-2007 For Requirement ID - WAF3_PB_47.0
            .IsMultiInsertSubTag = True
            .FormName = "frmCommonPage"
            .ShowDisabledInEditMode = Not m_objSubTagAccess.Edit
            Response.Write(.PlotGrid())
            m_strSubTagClientsideScript += .ClientsideScript
            m_sbMultiInsertSubTagEnabledControls.Append(vbCrLf)
            m_sbMultiInsertSubTagEnabledControls.Append(.EnableControlsScript)
            m_strSubTagClientFunctionBody += .ClientFunctionBody
            m_blnConsiderContextMenu = False
            Response.Write("<INPUT type=hidden id='ShowDeleteColumnFirst" + m_objSubTagCLSQL.SubTagId.ToString + "' name='ShowDeleteColumnFirst" + m_objSubTagCLSQL.SubTagId.ToString + "' value='" + m_objSubTagCLSQL.ShowDeleteColumnFirst.ToString + "'>")
        End With
        'Destroy the object    
        cObjGrid = Nothing
    End Sub
    Private Sub SubTag_WriteTotalRecords()
        'Display Total Records at the end
        'Use the Statndard Message Resource File
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        CommonFunction.General.WriteHTML(CommonFunction.General.WriteTotalRecordsHTML(m_objSubTagCLSQL.RecordCount, MyBase.GetResourceString("TOTAL_RECORDS"), , "clsTREven", , "RecordCountOnGrid" + m_objSubTagCLSQL.SubTagId.ToString)) 'Modified By - Ninad : Req ID - WAF3_PB_55 : Dt 5 Nov 2007
        'Common Page Resource File
        MyBase.InitializeResources("Resources.CommonPage", "Resources")
        'WAF3_PB_42 April 06, 2007 UmeshJ START
        If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then Response.Write("<BR>")
    End Sub
    Private Sub SubTag_WriteClientsideScript()
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
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        Call SubTag_WriteClientsideScript_TabClick()
        Call SubTag_WriteClientsideScript_Filter()
        Call SubTag_WriteClientsideScript_EditLink()
        Call SubTag_WriteClientsideScript_Paging()
        Call SubTag_WriteClientsideScript_Sorting()
        HttpContext.Current.Response.Write(vbCrLf + m_strSubTagCLSectionClientsideScript)
        If m_objSubTagCLSQL.RecordCount > 0 Then Call SubTag_WriteClientsideScript_Links()
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
    End Sub
    Private Sub SubTag_WriteClientsideScript_TabClick()
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_TabClick
        ' Purpose               :	Write Clientside Script for Tab click
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + m_objSubTagCLSQL.TabOnclickFunction + "(lngSubTabID)")
        Response.Write(vbCrLf + "{")
        'Added By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
        'Dim objResources = New WebPages.Template.WhizTemplate
        'Modified By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        'Dim strResourceName As String = MyBase.ResourceName
        'Dim strResourceAssemblyName As String = MyBase.ResourceAssemblyName
        'MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        'Response.Write(vbCrLf + "if (isFormDataChanged('" + MyBase.GetResourceString("MSG_PAGE_DATA_NOT_SAVED") + "')==true) return;")
        'MyBase.InitializeResources(strResourceName, strResourceAssemblyName)
        If CommonFunctions.General.GetFrameworkSettings("PB_SHOW_NAVIGATION_ALERTS", "Enabled") Then Response.Write(vbCrLf + "if(ShowNavigationAlert()==false) return;")
        'End Modification By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        'objResources = Nothing
        'End Addition By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
        'Modified By UmeshJ on 2nd July 2004
        'Append the Default Query string parameters
        Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?FocusOn=" + FocusOn_SUBTAG + "&SubTagPagingAlphabet=&SubTagSortBy=&SubTagSortOrder=&SubTagID=""+ lngSubTabID + """ + m_strQuerystringDefaultParameters + """")
        'End of modification
        Response.Write(vbCrLf + "   objfrm.submit();")
        Response.Write(vbCrLf + "}")
    End Sub
    Private Sub SubTag_WriteClientsideScript_Filter()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_Filter
        ' Purpose               :	Write Clientside Script for Page Filters
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " & m_strSubTagFilterFunction + m_lngSubTagID.ToString + "(strHiddenControlName,e,IsText)")
        Response.Write(vbCrLf + "{")
        Response.Write(vbCrLf + "	if (IsText==false) {")
        Response.Write(vbCrLf + "	    objControl = GetObjectEvent(e);")
        Response.Write(vbCrLf + "	    objHiddenControl = GetObjectReference('frmCommonPage',strHiddenControlName);")
        Response.Write(vbCrLf + "	    if (objHiddenControl != null) ")
        Response.Write(vbCrLf + "			{")
        Response.Write(vbCrLf + "				objHiddenControl.value = objControl.options[objControl.selectedIndex].innerText;")
        Response.Write(vbCrLf + "	        }")
        Response.Write(vbCrLf + "	}")
        Response.Write(vbCrLf + "	else {")
        Response.Write(vbCrLf + "	    var code;")
        Response.Write(vbCrLf + "	    if (e.keyCode) code = e.keyCode;")
        Response.Write(vbCrLf + "	    else if (e.which) code = e.which;")
        Response.Write(vbCrLf + "	    if(code==13) {")
        'Added By UmeshJ on 23 Nov 2004
        Response.Write(vbCrLf + "	        if(" + VALIDATE_FILTER + "()==false){return};")
        'End
        Response.Write(vbCrLf + "	        objControl = GetObjectEvent(e);")
        Response.Write(vbCrLf + "	        objHiddenControl = GetObjectReference('frmCommonPage',strHiddenControlName);")
        Response.Write(vbCrLf + "	        if (objHiddenControl != null) ")
        Response.Write(vbCrLf + "	        {objHiddenControl.value = objControl.value;}")
        Response.Write(vbCrLf + "	    }")
        Response.Write(vbCrLf + "	    else {return;}")
        Response.Write(vbCrLf + "	}")
	Response.Write(vbCrLf + "if(ShowNavigationAlert()==false) return;") 'Added By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        Dim strToBeInsertedInFilterFunction As String = ""

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                    "Before_Applying_Filter")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.ToBeInsertedInFunction = strToBeInsertedInFilterFunction

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicFilters", _
                    "Before_Applying_Filter", ExtensionArgs)

            strToBeInsertedInFilterFunction = ExtensionArgs.ToBeInsertedInFunction

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            Call Before_Applying_Filter(strToBeInsertedInFilterFunction)
        End If
        'addition ends.
        If strToBeInsertedInFilterFunction.Trim <> "" Then
            Response.Write(vbCrLf + strToBeInsertedInFilterFunction.Trim)
        End If
        Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?FocusOn=" + FocusOn_SUBTAG + "&SubTagSetFilter=1&" + m_strCommonQueryString + "&" + SubTag_GetQuerystringParameters() + """")
        Response.Write(vbCrLf + "	objfrm.submit();")
        Response.Write(vbCrLf + "}" + vbCrLf)
    End Sub
    Private Sub SubTag_WriteClientsideScript_EditLink()
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_EditLink
        ' Purpose               :	Write Clientside Script for grid links
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        'Added By Chakshuta H on 30th-Oct-2015
        'Added By Vinay B On 07 July 2008 For Issue 21459
        Dim lngWindowWidth As Long
        Dim lngWindowHeight As Long
        'Addiion End By Vinay B On 07 July 2008 For Issue 21459

        'Ended By Chakshuta H on 30th-Oct-2015

        Response.Write(vbCrLf + "function " + m_strSubTagEditOnclick + m_lngSubTagID.ToString + "(strUniqueID,PKToken) {")  'WAF3_PB_26
        If m_objSubTagCLSQL.IsAttachmentTab = True Then
            'For attachment tab
            'Changed By NileshD on 21 June 2005
            '==========================================================================================================
            'Added By NinadP :	17 Nov 2006 : Requirement Tag - WAF3_PB_33 original commented below
            'Response.Write(vbCrLf + "     window.open(" + Chr(34) + "../General/CLCP_Attachment.aspx?Operation=" + CommonFunction.Constants.OPERATION_VIEW_ATTACHMENT + "&" + m_objSubTagCLSQL.PrimaryKey + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + ", ""_popup"");" + vbCrLf) 'WAF3_PB_26
            Dim strEncConnectionID As String = "" '
            If (m_intConnectionID <> 0) Then strEncConnectionID = CommonFunctions.General.EncryptString(CommonFunctions.General.CheckIsNothing(m_intConnectionID))
            Response.Write(vbCrLf + "     window.open(" + Chr(34) + "../General/CLCP_Attachment.aspx?ConnectionID=" + strEncConnectionID + "&Operation=" + CommonFunction.Constants.OPERATION_VIEW_ATTACHMENT + "&" + m_objSubTagCLSQL.PrimaryKey + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + ", ""_popup"");" + vbCrLf) 'WAF3_PB_26
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            'End OF changed NileshD on 21 June 2005
        Else
            'Added By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
           'Added By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
            'Dim strResourceName As String = MyBase.ResourceName
            'Dim strResourceAssemblyName As String = MyBase.ResourceAssemblyName
            ''MyBase.InitializeResources("Resources.StandardMessages", "Resources")
            'MyBase.InitializeResources("Resources.StandardMessages", "Resources")
           'Response.Write(vbCrLf + "if (isFormDataChanged('" + MyBase.GetResourceString("MSG_PAGE_DATA_NOT_SAVED") + "')==true) return;")
            'MyBase.InitializeResources(strResourceName, strResourceAssemblyName)
            Response.Write(vbCrLf + "blnNavigate = false;")
            'End Addition By Ninad 20 May 2008, Req ID - WAF3_PB_64 - - Show Navigation Alert

            'End Addition By Ninad on 29 Feb 2008, SRID 19375 - Show alerts after save
            Dim strPKSuffix As String = ""
            If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim.ToUpper, "" & strSubTagFormPage & "", CompareMethod.Text) <> 0 Then
                strPKSuffix = "_PK"
            End If

            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''If m_strSubTagCommonQueryString.Trim = "" Then
            ''    If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
            ''        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "?" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_objSubTagCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_objSubTagCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_objSubTagCLSQL.WindowWidth.ToString + ",height=" + m_objSubTagCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
            ''    Else
            ''        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "&" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_objSubTagCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_objSubTagCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_objSubTagCLSQL.WindowWidth.ToString + ",height=" + m_objSubTagCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
            ''    End If
            ''Else
            ''    If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim.Trim, "?", CompareMethod.Text) = 0 Then
            ''        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "?" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_objSubTagCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_objSubTagCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_objSubTagCLSQL.WindowWidth.ToString + ",height=" + m_objSubTagCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
            ''    Else
            ''        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "&" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + m_objSubTagCLSQL.WindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + m_objSubTagCLSQL.WindowHeight.ToString + ")/2) + "",width=" + m_objSubTagCLSQL.WindowWidth.ToString + ",height=" + m_objSubTagCLSQL.WindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26
            ''    End If
            ''End If
            'Added By Vinay B ON 07 July 2008 For Issue ID 21459
            lngWindowWidth = m_objSubTagCLSQL.WindowWidth
            lngWindowHeight = m_objSubTagCLSQL.WindowHeight
            If (lngWindowWidth.ToString = "" Or lngWindowWidth.ToString = "0") Then
                lngWindowWidth = 600
            End If
            If (lngWindowHeight.ToString = "" Or lngWindowHeight.ToString = "0") Then
                lngWindowHeight = 400
            End If

            ''Addition End By Vinay B On 07 July 2008 For Issue ID 21459

            'Added & Modified By NikhilM on 09 Nov. 2010 for Modal Dialog Popup to be displayed on edit mode of subtag.
            ' To be displayed only if Framework key for the same is enabled.
            If CBool(CommonFunctions.General.GetFrameworkSettings("PB_SHOW_MODAL_POPUP", "Enabled")) = True Then
                If m_strSubTagCommonQueryString.Trim = "" Then
                    If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
                        Response.Write(vbCrLf + "SetModalPopupParams(" & Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "?" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + "," + lngWindowWidth.ToString + "," + lngWindowHeight.ToString + ",70,'',true,6)" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    Else
                        Response.Write(vbCrLf + "SetModalPopupParams(" & Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "&" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + "," + lngWindowWidth.ToString + "," + lngWindowHeight.ToString + ",70,'',true,6)" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    End If
                Else
                    If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim.Trim, "?", CompareMethod.Text) = 0 Then
                        Response.Write(vbCrLf + "SetModalPopupParams(" & Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "?" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + "," + lngWindowWidth.ToString + "," + lngWindowHeight.ToString + ",70,'',true,6)" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    Else
                        Response.Write(vbCrLf + "SetModalPopupParams(" & Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "&" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + "," + lngWindowWidth.ToString + "," + lngWindowHeight.ToString + ",70,'',true,6)" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    End If
                End If
            Else
                If m_strSubTagCommonQueryString.Trim = "" Then
                    If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim, "?", CompareMethod.Text) = 0 Then
                        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "?" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    Else
                        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "&" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + " & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    End If
                Else
                    If InStr(1, m_objSubTagCLSQL.EditMode_UIPage.Trim.Trim, "?", CompareMethod.Text) = 0 Then
                        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "?" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    Else
                        Response.Write(vbCrLf + "     window.open(" + Chr(34) + m_objSubTagCLSQL.EditMode_UIPage.Trim + "&" + m_objSubTagCLSQL.PrimaryKey + strPKSuffix + "="" + strUniqueID + ""&PKToken="" + PKToken  + ""&" + m_strSubTagCommonQueryString & Chr(34) + ", ""_popup"", ""resizable=yes,scrollbars=no,left="" + ((window.screen.width - " + lngWindowWidth.ToString + ")/2) + "",top="" + ((window.screen.height - " + lngWindowHeight.ToString + ")/2) + "",width=" + lngWindowWidth.ToString + ",height=" + lngWindowHeight.ToString + """);" + vbCrLf) 'WAF3_PB_26 Modified By Vinay B On 07 July 2008 For Issue Id 21459
                    End If
                End If
            End If
            'Modification End by NikhilM on 9 Nov 2010 for Modal Dialog Popup to be displayed on edit mode of subtag.
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        End If
        Response.Write(vbCrLf + "}")
    End Sub
    Private Sub SubTag_WriteClientsideScript_RefreshParent()
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_RefreshParent
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
        ' Revisions             :   2.0.02-SP5-WAF
        '=====================================================================
        If m_blnIsSubTag = True And (m_strOperation = CommonFunction.Constants.OPERATION_SAVE Or m_strOperation = CommonFunction.Constants.OPERATION_DYNAMIC_LINK) And m_strSubTagFromCL = "1" Then
            Response.Write(vbCrLf + "<Script language=javascript>")
            'Modified By NileshD on 26 Sep 2005 REQID WAF3_PB_10
            'Modified By UmeshJ on 5th July 2004
            'Added By Chakshuta H on 30th-Oct-2015
            Response.Write(vbCrLf + "try { ") 'Added by Vinay on 12 DEC. 2008 WAF3_GEN_18 included try catch block
            'Ended By Chakshuta H on 30th-Oct-2015

            Response.Write(vbCrLf + "   refreshParent('" + FORM_NAME + "','" & strFormPage & "','" & strFormPage & "?SubTagID=" + m_objGlobal.TagID.ToString + "&FocusOn=" + FocusOn_SUBTAG + "&PagingNumber=" + m_intPagingNo.ToString + m_strParentTagQuerystringDefaultParameters + "');")
            'End of modifications
            'Added By Chakshuta H on 30th-Oct-2015
            Response.Write(vbCrLf + "}catch(e) { } ") 'Added by Vinay on 12 DEC. 2008 WAF3_GEN_18 included try catch block
            'Ended By Chakshuta H on 30th-Oct-2015
            'End Of Modification By NileshD on 26 Sep 2005 REQID WAF3_PB_10
            Response.Write(vbCrLf + "</Script>")
        End If
    End Sub
    Private Sub SubTag_WriteClientsideScript_Paging()
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_Paging
        ' Purpose               :	Write Clientside Script for Paging
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + m_strSubTagPagingFunction + m_lngSubTagID.ToString + "(strPagingAlphabet)")
        Response.Write(vbCrLf + "{")
 Response.Write(vbCrLf + "blnNavigate = false;") 'Added By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?FocusOn=" + FocusOn_SUBTAG + "&" + m_strCommonQueryString + "&" + SubTag_GetQuerystringParameters(True, False, True) + "&SubTagPagingAlphabet="" + strPagingAlphabet")
        Response.Write(vbCrLf + "   objfrm.submit();")
        Response.Write(vbCrLf + "}")
    End Sub
    Private Sub SubTag_WriteClientsideScript_Sorting()
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_Sorting
        ' Purpose               :	Write Clientside Script for sorting
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "function " + m_strSubTagSortFunction + m_lngSubTagID.ToString + "(strFieldName,strAscDesc)")
        Response.Write(vbCrLf + "{")
		Response.Write(vbCrLf + "   blnNavigate = false;") 'Added By Ninad 20 May 2008, Req ID - WAF3_PB_64 - Show Navigation Alert
        Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?FocusOn=" + FocusOn_SUBTAG + "&" + m_strCommonQueryString + "&" + SubTag_GetQuerystringParameters(True, True, False) + "&SubTagSortBy="" + strFieldName + ""&SubTagSortOrder="" + strAscDesc ")
        Response.Write(vbCrLf + "   objfrm.submit();")
        Response.Write(vbCrLf + "}")
    End Sub

    Private Sub WriteClientsideScript_DeletionResult()
        '=====================================================================
        ' Procedure Name        :	WriteClientsideScript_DeletionResult
        ' Purpose               :	Write Clientside Script for Deletion Result
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 20, 2003
        ' Revisions             :
        '=====================================================================
        'Delete Message
        If Trim(m_objSubTagCLSQL.DeletionResult) <> "" Then
            Dim strResultMsgArray As String()
            Dim intIndex As Integer
            Dim strMsg As String = ""
            strResultMsgArray = Split(m_objSubTagCLSQL.DeletionResult, "<CR>")
            Dim intUBound As Integer = strResultMsgArray.GetUpperBound(0) - 1
            strMsg = strMsg + Chr(34)
            For intIndex = 0 To intUBound
                If intIndex = intUBound Then
                    strMsg = strMsg + Microsoft.VisualBasic.Strings.Replace(strResultMsgArray(intIndex), """", "\""")
                Else
                    strMsg = strMsg + Microsoft.VisualBasic.Strings.Replace(strResultMsgArray(intIndex), """", "\""") + "\r\n"
                End If
            Next
            strMsg = strMsg + Chr(34)
            Response.Write(vbCrLf + "<Script Laguage=javascript>" + vbCrLf)
            If strMsg.Trim <> "" Then Response.Write("alert (" & strMsg & ");")
            Response.Write(vbCrLf + "</Script>" + vbCrLf)
        End If
    End Sub

    Private Sub SubTag_WriteClientsideScript_Links()
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_Links
        ' Purpose               :	Write Clientside Script for grid links
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :   By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43, to get link details from hash table
        '=====================================================================
        'Get all the Links Details (Dynamic links and hyperlink controls)
        'Dim strSQL As String = "usp_Sel_v_tbl_UI_SubControlTagMaster_List_Links " & m_objSubTagGlobal.TagID
        'Dim drLinks As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'Dim objLinks As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function
        'Do While drLinks.Read()

        '    'Prepare Grid links object
        '    With objLinks
        '        .AccessRights = CommonFunction.Data.CheckIsDBNull(drLinks("AccessRights")).ToString.Trim
        '        .ClientSideFunctionName = CommonFunction.Data.CheckIsDBNull(drLinks("ClientSideFunctionName")).ToString.Trim
        '        .HREF_Parameters = CommonFunction.Data.CheckIsDBNull(drLinks("HREF_Parameters")).ToString.Trim
        '        .HREF_URL = CommonFunction.Data.CheckIsDBNull(drLinks("HREF_URL")).ToString.Trim
        '        .Identifier = CommonFunction.Data.CheckIsDBNull(drLinks("Identifier")).ToString.Trim
        '        If drLinks("Type").ToString = "DYNAMIC_LINK" Then
        '            .IsHyperlink = False
        '        Else
        '            .IsHyperlink = True
        '        End If
        '        .LinkType = CommonFunction.Data.CheckIsDBNull(drLinks("LinkType")).ToString.Trim
        '        .SPToExecute = CommonFunction.Data.CheckIsDBNull(drLinks("SpToExecute")).ToString.Trim
        '        .UniqueID = CType(CommonFunction.Data.CheckIsDBNull(drLinks("UniqueID"), "0"), Long)
        '        .ToBeInserted = CommonFunction.Data.CheckIsDBNull(drLinks("InsertInFunction")).ToString.Trim
        '    End With

        'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
        Dim objLinks As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function
        Dim objArrListLinksForClientSideScripts As CommonEngines.HashTables.ListLinksForClientSideScripts()
        objArrListLinksForClientSideScripts = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableListLinksSubTagMasterHashTable_ForClientSideScripts(m_objSubTagGlobal.TagID)
        If Not objArrListLinksForClientSideScripts Is Nothing Then
            Dim objListLinksForClientSideScripts As CommonEngines.HashTables.ListLinksForClientSideScripts
            For Each objListLinksForClientSideScripts In objArrListLinksForClientSideScripts
                'Prepare Grid links object
                With objLinks
                    .AccessRights = objListLinksForClientSideScripts.AccessRights
                    .ClientSideFunctionName = objListLinksForClientSideScripts.ClientSideFunctionName
                    .HREF_Parameters = objListLinksForClientSideScripts.HREF_Parameters
                    .HREF_URL = objListLinksForClientSideScripts.HREF_URL
                    .Identifier = objListLinksForClientSideScripts.Identifier
                    If objListLinksForClientSideScripts.Type = "DYNAMIC_LINK" Then
                        .IsHyperlink = False
                    Else
                        .IsHyperlink = True
                    End If
                    .LinkType = objListLinksForClientSideScripts.LinkType
                    .SPToExecute = objListLinksForClientSideScripts.SpToExecute
                    .UniqueID = objListLinksForClientSideScripts.UniqueID
                    .ToBeInserted = objListLinksForClientSideScripts.InsertInFunction
                End With
                'End Addition By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
                Dim blnCancel As Boolean = False

                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                        "Before_GridLinksFunction_Print")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                    ExtensionArgs.Cancel = blnCancel
                    ExtensionArgs.m_gridlinks_Function = objLinks
                    ExtensionArgs.m_global = m_objSubTagGlobal


                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                        "Before_GridLinksFunction_Print", ExtensionArgs)

                    blnCancel = ExtensionArgs.Cancel
                    objLinks = ExtensionArgs.m_gridlinks_Function
                    m_objSubTagGlobal = ExtensionArgs.m_global

                    If Not ExtensionArgs Is Nothing Then
                        ExtensionArgs = Nothing
                    End If
                    'Modification Ends.
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    'Call before print event
                    'Code Modified:RajeshB          19 Jan 2005
                    ' Purpose: Wrap the call into overridable function
                    'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_GridLinksFunction_Print(blnCancel, objLinks, m_objSubTagGlobal)
                    'Changed By NileshD on 1 Dec 2005
                    'Call Before_GridLinksFunction_Print(blnCancel, objLinks, m_objGlobal)
                    Call Before_GridLinksFunction_Print(blnCancel, objLinks, m_objSubTagGlobal)
                    'End of changed By NileshD on 1 Dec 2005
                End If
                'addition ends.
                If blnCancel = False Then
                    If objLinks.IsHyperlink = False Then
                        Response.Write(vbCrLf + "function " & Microsoft.VisualBasic.Strings.Replace(Microsoft.VisualBasic.Strings.Replace(Replace(objLinks.ClientSideFunctionName, " ", ""), "[", ""), "]", "") & "(lngUniqueID,PKToken) {")  'WAF3_PB_26
                        Response.Write(vbCrLf + objLinks.ToBeInserted)
                        If objLinks.LinkType = "D" Then
                            Response.Write(vbCrLf + "window.open (" & Chr(34) & ReplacePlaceHolders(objLinks.HREF_URL, """ + lngUniqueID + ""&PKToken="" + PKToken + """, m_objSubTagGlobal) & Chr(34) & ");" & vbCrLf) 'WAF3_PB_26
                        Else
                            '___________________Modified By UmeshJ on 28th May 2004 for Issue ID : 11305________________
                            'Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?SubTagID=" + m_lngSubTagID.ToString + "&IsSubTagDynamicLink=1&Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objLinks.UniqueID.ToString + "&UniqueValue="" + lngUniqueID + ""&IsListPageLink=1&" + m_strSubTagCommonQueryString + """")
                            Response.Write(vbCrLf + "   objfrm.action = """ & strFormPage & "?FocusOn=SUBTAG&SubTagID=" + m_lngSubTagID.ToString + "&IsSubTagDynamicLink=1&Operation=DYNAMIC_LINK&DYNAMIC_LINK_ID=" + objLinks.UniqueID.ToString + "&UniqueValue="" + lngUniqueID + ""&SubActionPKToken="" + PKToken + ""&IsListPageLink=1""") 'WAF3_PB_26
                            '___________________End of modification_____________________________________________________'
                            Response.Write(vbCrLf + "   objfrm.submit();")
                        End If
                        Response.Write(vbCrLf + "}")
                    Else
                        Response.Write(vbCrLf + "function " & Microsoft.VisualBasic.Strings.Replace(objLinks.ClientSideFunctionName, " ", "") & "(")
                        Dim strURL As String = objLinks.HREF_URL
                        Dim sbURL As New System.Text.StringBuilder
                        If objLinks.HREF_Parameters <> "" And InStr(strURL, "<PARAMETERS>") <> 0 Then
                            'If the parametrs are specified then prepare the function definition and URL accordingly
                            Dim strParametersArray As String() = Split(objLinks.HREF_Parameters, CommonFunction.Constants.DELIMITER_FOR_HYPERLINK_PARAMETERS)
                            Dim intIndex As Integer
                            Dim intUBound As Integer = strParametersArray.GetUpperBound(0)
                            For intIndex = 0 To intUBound
                                Response.Write(strParametersArray(intIndex))
                                If intIndex < intUBound Then Response.Write(",")
                                'More than 1 parameters    
                                If intIndex > 0 Then sbURL.Append(" + ""&")
                                sbURL.Append("" + strParametersArray(intIndex) + "="" + " & strParametersArray(intIndex))
                            Next
                            'Replace the place holder <PARAMETERS> by actual values
                            strURL = Microsoft.VisualBasic.Strings.Replace(strURL, "<PARAMETERS>", sbURL.ToString)
                        End If
                        strURL = ReplacePlaceHolders(strURL, m_strForeignKeyValue, m_objSubTagGlobal) 'Added By - NinadP On - 25 Feb 2008 Support Req. ID. - 19143
                        Response.Write(")")
                        Response.Write(vbCrLf + "{")
                        Response.Write(vbCrLf + objLinks.ToBeInserted)
                        Response.Write(vbCrLf + "window.open (" + Chr(34) + strURL + ");")
                        Response.Write(vbCrLf + "}")
                        'Destroy the object
                        sbURL = Nothing
                    End If
                End If
                'Loop
            Next
            objListLinksForClientSideScripts = Nothing  'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
        End If
        'drLinks.Dispose()
        'drLinks.Close()
        'drLinks = Nothing
        objArrListLinksForClientSideScripts = Nothing  'Added By - NinadP On - 2 April 2007 Req. ID. - WAF3_PB_43
        objLinks = Nothing
    End Sub
    Public Overridable Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Changed By NileshD on 1 Dec 2005
        'CommonEngine.General.CLCP_Events_DynamicActions.Before_GridLinksFunction_Print(Cancel, Args, m_objGlobal)
        CommonEngine.General.CLCP_Events_DynamicActions.Before_GridLinksFunction_Print(Cancel, Args, WhizGlobal)
        'End of changed By NileshD on 1 Dec 2005
    End Sub
    '--------------------------------------------------------------------------
    'SUB COMMON PAGE
    Private Sub SubTag_PlotCommonPage()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotCommonPage
        ' Purpose               :	This method will Plot the sub tag CommonPage
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, November 27, 2003 
        ' Revisions             :
        '=====================================================================
        'SQL Details
        Call SubTag_CPGetSQL()
        m_objGeneral.IsListPage = False
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            'Plot Tabs

            Call PlotTabs()


            'Plot Border for Tabular view only
            'Modified by PrasannaP on 30th May 2005
            'Issue ID 28888
            'Response.Write("<Table width='100%' class='clsSubTagTable' cellspacing='0' ><TR><TD>")
            Response.Write("<Table width='99.9%' class='clsSubTagTable' cellspacing='0' ><TR><TD>")
            'End Modification
        Else
            If m_blnIsSingleColumnerTab = False Then
                Dim strClientsideFunction As String = PlotSectionTitle(m_objSubTagCLSQL.PageCaption, "SubTag" + m_lngSubTagID.ToString, "showHideSubTag" + m_lngSubTagID.ToString, "LEFT", 0, False, True)
                'Client side Show hide function
                CommonFunction.General.WriteHTML("<Script Language=Javascript>")
                CommonFunction.General.WriteHTML(strClientsideFunction)
                CommonFunction.General.WriteHTML("</Script>")
                'Div Tag
                CommonFunction.General.WriteHTML("<DIV Id='SubTag" + m_lngSubTagID.ToString + "' Style=" & Chr(34) + "OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")
            End If
        End If
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("IsSubTag")) = "1" And m_lngCurrentSubTagID = m_lngSubTagID Then
            If m_strOperation = CommonFunction.Constants.OPERATION_SAVE Then
                'Save the Record
                Dim strForeignKeyValue As String = m_cObjCPSQL.PrimaryKeyValue
                'Execute Before Save event
                Call SubTag_CPPage_BeforeSave()
                If m_blnIgnoreSave = False Then
                    'Save Data
                    Call SubTag_CPSaveData()
                End If
                'Execute After Save event
                Call SubTag_CPPage_AfterSave()
            ElseIf m_strOperation = CommonFunction.Constants.OPERATION_DYNAMIC_LINK Then
                'Execute Dynamic Action
                Call SubTag_CPExecuteDynamicLinkAction()
            End If
        End If
        'Execute the Page PreRender event
        Call SubTagCP_Page_PreRender()
        'Menu
        Call SubTag_CPGetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.UI_HEAD, True)
        Response.Write("<BR>")
        'Page Caption
        Call SubTag_CPPlotPageCaption()
        'Header
        Call SubTag_CPPlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.UI_HEADER, m_objSubTagCPSQL.PageHeader)
        If m_objSubTagCPSQL.PageHeader.Trim <> "" Then Response.Write("<BR>")
        Call SubTag_CPPlotSubTagSections()
        Response.Write("<BR>")
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''Call SubTag_CPPlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER, m_objSubTagCPSQL.PageFooter)
        If (CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") = True) Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            Call SubTag_CPPlotPageHeaderFooter(WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition.UI_FOOTER, m_objSubTagCPSQL.PageFooter)
        End If
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
        If m_objSubTagCPSQL.PageFooter.Trim <> "" Then Response.Write("<BR>")
        'WAF3_PB_42 April 03, 2007 UJ START
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''If m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
        If (m_cObjCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL AndAlso CommonFunction.General.GetFrameworkSettings("GEN_ENABLE_FOOTERMENU", "Enabled") = True) Then 'Modified By ShrikantB On 20-AUG-2010 For Hide Footer Menu
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            Call SubTag_CPGetMenu(WebPage.Templates.DynamicMenu.LinkDisplayPosition.UI_FOOT, False)
        End If
        'WAF3_PB_42 April 03, 2007 UJ END
        Call SubTag_CPWriteClientsideScript()
        If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
            'For Tabular view only
            Response.Write("</TD></TR></Table>")
        Else
            If m_blnIsSingleColumnerTab = False Then HttpContext.Current.Response.Write("</DIV>")
        End If
        'Call Page Post Render Event
        Call SubTagCP_Page_PostRender()
    End Sub
    Protected Overridable Function InitSubTagCPSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonPage.cSubTagCPSQL
        Return New CommonEngine.CommonPage.cSubTagCPSQL(m_objSubTagGlobal)
    End Function
    Private Sub SubTag_CPGetSQL()
        '=====================================================================
        ' Procedure Name        :	SubTag_CPGetSQL
        ' Purpose               :	Get the Page Details from the database
        ' Description           :	This method access the cSubTagCPSQL class to retrieve 
        '                           the page details required to plot the Common Page 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 29, 2003 
        ' Revisions             :
        '=====================================================================
        'Destroy object if exists
        If Not m_objSubTagCPSQL Is Nothing Then m_objSubTagCPSQL = Nothing
        'Create new object of Sub Tag CP SQL
        'Code Modified:RajeshB      28 Jan 2005
        'Purpose: CP as an Object
        m_objSubTagCPSQL = InitSubTagCPSQL(m_objSubTagGlobal) 'New CommonEngine.CommonPage.cSubTagCPSQL(m_objSubTagGlobal)
        '==========================================================================================================
        'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
        '==========================================================================================================
        m_objSubTagCPSQL.ConnectionString = m_strConnectionString
        '==========================================================================================================
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Modification Ends.
        With m_objSubTagCPSQL
            .ForeignKeyValue = m_cObjCPSQL.PrimaryKeyValue
            .GetSettings()
        End With
        '####___________Added By UmeshJ on 17th May, 2004____________IssueID : 11154
        'Consider Role Level Access flag for the Page
        If m_objSubTagCPSQL.ApplyRoleLevelAccess = False Then
            'if the Role Level Access flag is false then set all access rights as TRUE
            m_objSubTagAccess.Add = True
            m_objSubTagAccess.Delete = True
            m_objSubTagAccess.Edit = True
            m_objSubTagAccess.View = True
        End If
        '_____________________________________________________________
        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
        ''m_strSubTagCommonQueryString = "FocusOn=" + FocusOn_SUBTAG + "&IsSubTag=1&ForeignKey=" + m_cObjCPSQL.PrimaryKey + "&ForeignKeyValue=" + m_cObjCPSQL.PrimaryKeyValue + "&Mode=" + m_strMode + "&" + m_cObjCPSQL.PrimaryKey + "=" + m_cObjCPSQL.PrimaryKeyValue + "&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + CType(Request("FromWhere"), String) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString
        ' ***********************************************************************************
        ' Modified Apr 10,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************

        '_____________________________________________________________
        m_strSubTagCommonQueryString = "FocusOn=" + FocusOn_SUBTAG + "&IsSubTag=1&ForeignKey=" + m_cObjCPSQL.PrimaryKey + "&ForeignKeyValue=" + m_cObjCPSQL.PrimaryKeyValue + "&Mode=" + m_strMode + "&" + m_cObjCPSQL.PrimaryKey + "=" + m_cObjCPSQL.PrimaryKeyValue + "&MasterTagID=" + m_objGlobal.TagID.ToString + "&FromWhere=" + HttpUtility.HtmlEncode(CType(Request("FromWhere"), String)) + "&PagingAlphabet=" + HttpContext.Current.Server.UrlEncode(m_strPagingAlphabet) + "&ParentTagID=" + m_objGlobal.ParentTagID.ToString
        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
    End Sub
    Private Sub SubTag_CPGetMenu(ByVal enmDisplayPosition As WebPage.Templates.DynamicMenu.LinkDisplayPosition, ByVal blnReturnClientsideScript As Boolean)
        '=====================================================================
        ' Procedure Name        :	SubTag_CPGetMenu
        ' Purpose               :	Plot the Menu using the DynamicMenu class
        ' Description           :	Same as above
        ' Parameters Passed     :	enmDisplayPosition - display position  
        '                           blnReturnClientsideScript - If true then 
        '                           Return Clientside Script for the dynamic links
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 13, 2003 
        ' Revisions             :
        '=====================================================================
        m_cObjMenu = New WebPage.Templates.DynamicMenu

        With m_cObjMenu
            .CommonQueryString = m_strSubTagCommonQueryString + "&" + SubTag_GetQuerystringParameters()
            .SubTagID = m_lngSubTagID.ToString
            Dim ValidationRules As String = ""
            Dim EnabledControls As String = ""
            Dim blnHeaderSectionEnabled As Boolean = False
            Dim blnFooterSectionEnabled As Boolean = False

            'Validation function call for Header section
            If SubTag_CPGetSectionPreferences(CommonFunction.Constants.SECTION_HEADER) = 1 Then
                ValidationRules += vbCrLf + "if (!" + m_strSubTagFormValidationFunctionHeaderSection + "()) { return;}"
                EnabledControls += vbCrLf + m_strSubTagEnabledControlsFunctionHeaderSection + "();"
                blnHeaderSectionEnabled = True
            End If
            'Validation function call for Footer section
            If SubTag_CPGetSectionPreferences(CommonFunction.Constants.SECTION_FOOTER) = 1 Then
                ValidationRules += vbCrLf + "if (!" + m_strSubTagFormValidationFunctionFooterSection + "()) { return;}"
                EnabledControls += vbCrLf + m_strSubTagEnabledControlsFunctionFooterSection + "();"
                blnFooterSectionEnabled = True
            End If
            .ValidationRules = ValidationRules '+ UserValidations
            .EnabledControls = EnabledControls
            .IsListPageLink = False
            .UniqueID = m_objSubTagCPSQL.PrimaryKeyValue
            '.MasterPrimaryKeyValue = m_strForeignKeyValue 'Added by Ninad on 31 Jan 2008 WAF3_PB_58. to replace <MASTER_PK> in condition clause of Action Link
            .EditMode_UIPageOpenInWindow = m_objSubTagCPSQL.EditMode_UIPageOpenInWindow
            If m_objSubTagCPSQL.PrimaryKeyValue.Trim <> "" Then
                'For Edit mode only
                If blnHeaderSectionEnabled = True Or blnFooterSectionEnabled = True Then
                    .ShowSaveLink = True
                Else
                    .ShowSaveLink = False
                End If
            Else
                .ShowSaveLink = True
            End If
            .ReturnClientsideScript = blnReturnClientsideScript
            .Displayposition = enmDisplayPosition
            'WAF3_PB_42 April 03, 2007 UJ START
            If m_objSubTagCPSQL.Action_NavigationSchema = CommonEngines.CommonList.cCLSQL.DynamicAction_NavigationSchema.CLASSICAL Then
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.CLASSICAL
            Else
                .Action_NavigationSchema = WebPages.Template.DynamicMenu.DynamicAction_NavigationSchema.DROPDOWN
                .DropdownMenu_HideControls = m_objSubTagCPSQL.DropdownMenu_HideControls
                .DropdownMenu_EnclosingDiv = m_strDivTag
                .DropdownMenu_Width = m_objSubTagCPSQL.DropdownMenu_Width
                If m_strSubTagDisplayType = CommonFunction.Constants.CLCP_SUB_TAG_DISPLAY_TYPE_TABUALAR Then
                    .DropdownMenu_TopFillFactor = 31
                Else
                    'For columner its 1
                    .DropdownMenu_TopFillFactor = 1
                End If
            End If
            'WAF3_PB_42 April 03, 2007 UJ END
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 5 June 2007
            Response.Write(.DrawMenu(m_objSubTagGlobal, m_objSubTagAccess.Add, m_objSubTagAccess.Edit, m_objSubTagAccess.Delete, m_objSubTagAccess.View, False, False, "", True))
            'Modified by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
            Dim strClientsideScript As String
            strClientsideScript = .ClientsideScript
            If strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>") <> -1 Then
                ReDim Preserve m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0) + 1)
                ReDim Preserve m_strTagID(m_strTagID.GetUpperBound(0) + 1)
                ReDim Preserve blnIsSubTag(blnIsSubTag.GetUpperBound(0) + 1)
                m_strTagID(m_strTagID.GetUpperBound(0)) = m_objSubTagCPSQL.TagID.ToString
                blnIsSubTag(blnIsSubTag.GetUpperBound(0)) = True
                m_strShortcutsAndFunction(m_strShortcutsAndFunction.GetUpperBound(0)) = strClientsideScript.Substring(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>")).Replace("<ACTION_LINK_KEYBOARD_SHORTCUTS>", "").Replace("</ACTION_LINK_KEYBOARD_SHORTCUTS>", "")
                strClientsideScript = strClientsideScript.Remove(strClientsideScript.IndexOf("<ACTION_LINK_KEYBOARD_SHORTCUTS>"))
            End If
            Response.Write(strClientsideScript)
            'End Modification by Ninad on 19 Oct 2007 for WAF3_PB_53, Keyboard Shortcuts
        End With
        'Destroy the object
        m_cObjMenu = Nothing
    End Sub
    Private Function SubTag_CPGetSectionPreferences(ByVal lngSectionID As Long) As Byte
        '=====================================================================
        ' Procedure Name        :	SubTag_CPGetSectionPreferences
        ' Purpose               :	Get Section Preferences
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - section ID
        ' Parameters Affected   :	None.
        ' Returns               :	User Preferences for the section(0-hide,1-show)
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        SubTag_CPGetSectionPreferences = 0
        Dim intLength As Integer
        Dim intIndex As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections

        'Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objSubTagGlobal.LCID Then
            'Local culture ID is same as the default culture id
             objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objSubTagGlobal.TagID, String) + "-0")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(m_objSubTagGlobal.TagID.ToString & CType(m_objSubTagGlobal.LCID, String) + "-0")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objSubTagGlobal.TagID, String) + "-0")
            End If
        End If
        If objSection Is Nothing Then Return SubTag_CPGetSectionPreferences
        intLength = objSection.Length - 1
        For intIndex = 0 To intLength
            If objSection(intIndex).SectionID = lngSectionID And objSection(intIndex).IsActive = True Then
                Select Case lngSectionID
                    Case CommonFunction.Constants.SECTION_HEADER
                        SubTag_CPGetSectionPreferences = m_objSubTagCPSQL.SectionPreferences(0)
                        Exit For
                    Case CommonFunction.Constants.SECTION_SUBTAG
                        SubTag_CPGetSectionPreferences = m_objSubTagCPSQL.SectionPreferences(1)
                        Exit For
                    Case CommonFunction.Constants.SECTION_GRAPH
                        SubTag_CPGetSectionPreferences = m_objSubTagCPSQL.SectionPreferences(2)
                        Exit For
                    Case CommonFunction.Constants.SECTION_RELATED_DATA
                        SubTag_CPGetSectionPreferences = m_objSubTagCPSQL.SectionPreferences(3)
                        Exit For
                    Case CommonFunction.Constants.SECTION_FOOTER
                        SubTag_CPGetSectionPreferences = m_objSubTagCPSQL.SectionPreferences(4)
                        Exit For
                End Select
            End If
        Next
        objSection = Nothing
    End Function
    Private Sub SubTag_CPPlotPageHeaderFooter(ByVal enmDisplayPosition As WebPage.Templates.HeaderFooter.HeaderFooterDisplayPosition, ByVal HeaderFooter As String)
        '=====================================================================
        ' Procedure Name        :	SubTag_CPPlotPageHeaderFooter
        ' Purpose               :	Plot the Page Header / Footer
        ' Description           :	Same as above
        ' Parameters Passed     :	enmDisplayPosition - Display Position,
        '                           HeaderFooter - Header/Footer string 
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        m_cObjHeaderFooter = New WebPage.Templates.HeaderFooter
        With m_cObjHeaderFooter
            .DisplayPosition = enmDisplayPosition
            .HeaderFooter = HeaderFooter
            Response.Write(.DrawHeaderFooter(m_objSubTagGlobal))
        End With
        'Destroy the object
        m_cObjHeaderFooter = Nothing
    End Sub

    Private Function SubTag_CPPlotPageCaption() As String
        '=====================================================================
        ' Procedure Name        :	SubTag_CPPlotPageCaption
        ' Purpose               :	Plot the Page Caption
        ' Description           :	Same as above
        ' Parameters Passed     :	None 
        ' Parameters Affected   :	None.
        ' Returns               :	Page Caption
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :   Changed by UmeshJ to remove optional parameter returnHTML
        '=====================================================================
        SubTag_CPPlotPageCaption = ""
        m_cObjPageCaption = New WebPage.Templates.PageCaption
        'WAF3_PB_40 Start
        'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        Dim Args As New WebPage.Templates.PageCaption.PageCaptionArgs
        Args.LeftPageCaption = m_objSubTagCPSQL.PageCaption
        Args.RightPageCaption = ""
        Args.MiddlePageCaption = ""
        Args.ReturnHTML = True
        Args.IsDesignMode = m_blnIsDesignMode
        Dim strPageCaption As String = m_cObjPageCaption.GetPageCaptionsWithEvents(m_objSubTagGlobal, Args)
        Args = Nothing
        'End Addition By - Ninad : Req ID - WAF3_PB_48 : Dt 31 May 2007
        'WAF3_PB_40 End
        If strPageCaption <> "" Then Response.Write(strPageCaption + "<BR>")
        'Destroy the object
        m_cObjPageCaption = Nothing
    End Function

    Private Sub SubTag_CPPlotSubTagSections()
        '=====================================================================
        ' Procedure Name        :	SubTag_CPPlotSubTagSections
        ' Purpose               :	This function is used to plot the Sub Page Sections
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 29, 2003 
        ' Revisions             :
        '=====================================================================
        Dim sbClientsideScript As New System.Text.StringBuilder
        Dim sbEnabledControls As New System.Text.StringBuilder
        Dim sbExpandSections As New System.Text.StringBuilder(vbCrLf + " function " + m_strSubTagexpandSectionsFunction + "() { ")
        Dim intLength As Integer
        Dim intIndex As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        Dim intNoOfActiveSections As Integer = 0

        'Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objSubTagGlobal.LCID Then
            'Local culture ID is same as the default culture id
             objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objSubTagGlobal.TagID, String) + "-0")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(m_objSubTagGlobal.TagID.ToString & CType(m_objSubTagGlobal.LCID, String) + "-0")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_objSubTagGlobal.TagID, String) + "-0")
            End If
        End If
        If objSection Is Nothing Then Return
        intLength = objSection.Length - 1
        HttpContext.Current.Response.Write("<DIV Id=" + m_strDivTag + " Style=" & Chr(34) + "HEIGHT:" + m_objSubTagCLSQL.DivHeight.ToString + "px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")

        'Get the Number of active sections
        For intIndex = 0 To intLength
            If objSection(intIndex).IsActive = True Then intNoOfActiveSections += 1
        Next

        For intIndex = 0 To intLength
            If objSection(intIndex).IsActive = True Then
                'If the Div Height is not specified in the div style then apply it from the
                'value specified in the Height property
                Dim lngDivHeight As Long
                Dim strDivStyle As String = "OVERFLOW:auto; WIDTH:100%;"
                Dim strSectionTag As String = "divSection" + objSection(intIndex).SectionID.ToString
                Dim strFunctionName As String = "SubTagshowHide_" + strSectionTag

                Dim blnCancelSection As Boolean = False
                'Create object of the Section Structure
                Dim Section As EventHandlers.WAF_Section = PrepareSectionObject(objSection(intIndex).SectionID, objSection(intIndex).TagSectionID, objSection(intIndex).Height, objSection(intIndex).OrderNumber, objSection(intIndex).IsActive, objSection(intIndex).ShowSectionTitle, objSection(intIndex).SectionTitle, objSection(intIndex).SectionTitleAlignment, strSectionTag, strFunctionName)
                'Call the Before plot section event...pass the section structure by ref
                'Code Modified:RajeshB      19 Jan 2005
                ' Purpose:Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSection(blnCancelSection, Section, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                Call Before_PlotSection(blnCancelSection, Section, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                'Addition Ends
                'If the only one section present then directly plot the controls
                If blnCancelSection = False And intNoOfActiveSections > 1 Then
                    sbExpandSections.Append(vbCrLf + Section.FunctionName + "(""none"");")
                    'Create object of the Section Structure for sectionTitle
                    Dim SectionTitle As EventHandlers.WAF_Section = PrepareSectionObject(Section.SectionID, Section.TagSectionID, Section.Height, Section.OrderNumber, Section.IsActive, Section.ShowSectionTitle, Section.SectionTitle, Section.SectionTitleAlignment, Section.DivSectionTag, Section.FunctionName)
                    Dim blnCancelSectionTitle As Boolean = False
                    'Call the Before plot sectionTitle event...pass the sectionTitle structure by ref
                    'Code Modified:RajeshB      19 Jan 2005
                    ' Purpose: Wrap the call into an overridable function
                    'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                    Call Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                    'Addition Ends
                    If blnCancelSectionTitle = False Then
                        'For each Section - Plot Section Header
                        sbClientsideScript.Append(PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID))
                    End If
                    'Call after print event for Section Title
                    'Code Modified:RajeshB      19 Jan 2005
                    ' Purpose: Wrap the call into an overridable function
                    'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSectionTitle(SectionTitle, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                    Call After_PlotSectionTitle(SectionTitle, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                    SectionTitle = Nothing
                End If

                If blnCancelSection = False Then
                    lngDivHeight = Section.Height
                    If lngDivHeight <> 0 Then
                        strDivStyle += "HEIGHT:" & lngDivHeight.ToString.Trim & "px; "
                    End If

                    HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                    Select Case Section.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER, CommonFunction.Constants.SECTION_FOOTER
                            If Section.SectionID = CommonFunction.Constants.SECTION_HEADER Then
                                sbEnabledControls.Append(vbCrLf + " function " + m_strSubTagEnabledControlsFunctionHeaderSection + "() {")
                            Else
                                sbEnabledControls.Append(vbCrLf + " function " + m_strSubTagEnabledControlsFunctionFooterSection + "() {")
                            End If
                            sbEnabledControls.Append(SubTag_CPPlotPageControls(Section.SectionID))
                            sbEnabledControls.Append(vbCrLf + "}" + vbCrLf)
                        Case CommonFunction.Constants.SECTION_SUBTAG
                            'Show Tabs in EDIT mode only
                            Call PlotSubTags()
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'call SubTagCP_PlotGraph()
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'call SubTagCP_PlotRelatedData()
                    End Select
                    HttpContext.Current.Response.Write("</DIV>")
                End If

                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection")
                If blnCheckEventCall = True Then

                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised

                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSection")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

                        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
                        ExtensionArgs.m_Section = Section
                        ExtensionArgs.m_global = m_objGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSection", ExtensionArgs)

                        Section = ExtensionArgs.m_Section
                        m_objGlobal = ExtensionArgs.m_global
                        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

                        If Not ExtensionArgs Is Nothing Then
                            ExtensionArgs = Nothing
                        End If
                        'Modification Ends.
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'After plotting the section call the After Print Event
                        'Code Modified:RajeshB      19 Jan 2005
                        ' Purpose: Wrap the call into an overridable function
                        'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSection(Section, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                        Call After_PlotSection(Section, m_objGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
                        'Addition Ends
                    End If
                    'addition ends.
                End If
                'addition ends.
                Section = Nothing
            End If
        Next
        sbExpandSections.Append(vbCrLf + "}" + vbCrLf)
        HttpContext.Current.Response.Write("</DIV>")
        'Enable Controls Client side script
        m_strSubTagEnabledControls = sbEnabledControls.ToString
        'Sub Tag Sections Client side script
        m_strSubTagSectionClientsideScript = sbExpandSections.ToString + sbClientsideScript.ToString
        sbClientsideScript = Nothing
        sbExpandSections = Nothing
        objSection = Nothing
    End Sub
    Protected Overridable Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New CommonEngine.CommonPage.cPlotControls(m_objSubTagGlobal)
    End Function

    Private Function SubTag_CPPlotPageControls(ByVal SectionID As Long) As String
        '=====================================================================
        ' Procedure Name        :	SubTag_CPPlotPageControls
        ' Purpose               :	Plot Page Controls
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	Enabled Control Scripts
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 05, 2003 
        ' Revisions             :
        '=====================================================================
        'Plot Controls
        SubTag_CPPlotPageControls = ""
        'Code Modified:RajeshB              27 Jan 2005
        ' Purpose: Allow inheritance of cPlotControls
        Dim cobjPlotControls As CommonEngine.CommonPage.cPlotControls
        cobjPlotControls = InitSubTagPlotControls()
        '==========================================================================================================
        'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
        '==========================================================================================================
        cobjPlotControls.ConnectionString = m_strConnectionString
        '==========================================================================================================
        ' Addition End By : Ninad   Req Id : WAF3_PB_33
        '==========================================================================================================
        'Dim cobjPlotControls As New CommonEngine.CommonPage.cPlotControls(m_objSubTagGlobal)
        'Modification Ends.
        Dim IsEditMode As Boolean = True
        If CommonFunction.General.CheckIsNothing(m_objSubTagCPSQL.PrimaryKeyValue).Trim = "" Then IsEditMode = False

        With cobjPlotControls
            .FormName = FORM_NAME
            If m_objSubTagAccess.Add = False And m_objSubTagAccess.Edit = False And m_objSubTagAccess.View = True Then
                .IsReadOnly = True
            Else
                .IsReadOnly = False
            End If
            .clsTRSectionHeader = "clsTRGroupHeader"
            If InStr(1, m_objSubTagCPSQL.FormSQL, " WHERE ", CompareMethod.Text) = 0 Then
                'If no where clause is specified then append it
                .FormControlSQL = m_objSubTagCPSQL.FormSQL + " WHERE " + m_objSubTagCPSQL.PrimaryKey + "='" + CommonFunction.General.BuildQueryString(m_cObjCPSQL.PrimaryKeyValue) + "'"
            Else
                .FormControlSQL = m_objSubTagCPSQL.FormSQL
            End If
            .PrimaryKeyValue = m_objSubTagCPSQL.PrimaryKeyValue
            .MasterPrimaryKeyValue = m_cObjCPSQL.PrimaryKeyValue
            'Yes - No values
            .ValueForYes = MyBase.GetResourceString("YES")
            .ValueForNo = MyBase.GetResourceString("NO")
            .IsDesignMode = m_blnIsDesignMode 'Added By - Ninad : Req ID - WAF3_PB_48 : Dt 5 June 2007
            .EnableHTMLEncode = m_objSubTagCPSQL.EnableHTMLEncode 'Added By Shrikant  on 5 June 2008 IssueID 20608 
            If SectionID = CommonFunction.Constants.SECTION_HEADER Then
                .PlotSubTagControls(SectionID, IsEditMode, m_strSubTagFormValidationFunctionHeaderSection)
            Else
                .PlotSubTagControls(SectionID, IsEditMode, m_strSubTagFormValidationFunctionFooterSection)
            End If
            m_strSubTagClientsideScript += .ClientsideScript
            SubTag_CPPlotPageControls = .EnableControlsScript
            m_strSubTagClientFunctionBody += .ClientFunctionBody
        End With
        cobjPlotControls = Nothing
    End Function
    Private Sub SubTag_CPWriteClientsideScript()
        '=====================================================================
        ' Procedure Name        :	SubTag_CPWriteClientsideScript
        ' Purpose               :	Write Clientside Script
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Response.Write(vbCrLf + "<SCRIPT Language=javascript>" & vbCrLf)
        Call SubTag_WriteClientsideScript_TabClick()
        'Section script
        Response.Write(vbCrLf + m_strSubTagSectionClientsideScript)
        'Enable Controls
        Response.Write(vbCrLf + m_strSubTagEnabledControls)
        'Get the form validation script
        Response.Write(vbCrLf + m_strSubTagClientsideScript)
        'Control Specific Functions
        Response.Write(vbCrLf + m_strSubTagClientFunctionBody)
        Response.Write(vbCrLf + "</SCRIPT>" & vbCrLf)
    End Sub
    Private Sub SubTag_CPSaveData()
        '=====================================================================
        ' Procedure Name        :	SubTag_CPSaveData
        ' Purpose               :	Save the Sub Tag Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 29, 2003 
        ' Revisions             :
        '=====================================================================
        Dim IsEditMode As Boolean = True
        If CommonFunction.General.CheckIsNothing(m_objSubTagCPSQL.PrimaryKeyValue) = "" Then IsEditMode = False
        Dim objSave As CommonEngine.CommonPage.cSubTagDataManagement
        objSave = InitSubTagDataManagement() 'New CommonEngine.CommonPage.cSubTagDataManagement(m_objSubTagGlobal)
        With objSave
            '==========================================================================================================
            'Added By NinadP :	10 Nov 2006 : Requirement Tag - WAF3_PB_33 
            '==========================================================================================================
            .ConnectionString = m_strConnectionString
            '==========================================================================================================
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            .PrimaryKey = m_objSubTagCPSQL.PrimaryKey
            .PrimaryKeyValue = m_objSubTagCPSQL.PrimaryKeyValue
            .TableName = m_objSubTagCPSQL.TableName
            .MaintainAuditTrail = m_objSubTagCPSQL.MaintainAuditTrail
            .AuditTrialField_CreatedBy = m_objSubTagCPSQL.AuditTrialField_CreatedBy
            .AuditTrialField_CreatedDate = m_objSubTagCPSQL.AuditTrialField_CreatedDate
            .AuditTrialField_UpdatedBy = m_objSubTagCPSQL.AuditTrialField_UpdatedBy
            .AuditTrialField_UpdatedDate = m_objSubTagCPSQL.AuditTrialField_UpdatedDate
            .IsIdentityOn = m_objSubTagCPSQL.IsIdentityOn
            'Apply Security for Sub Tag Master to get the controls for it
            MyBase.ApplySecurity(True, 2, , , True, m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID)
            .SaveData(MyBase.GetFormCollectionHashTable, IsEditMode)
        End With
        objSave = Nothing
        'Get the Primary Key Value for the inserted record
        If IsEditMode = False And m_objSubTagCLSQL.IsCommonPageTab = True Then
            m_objSubTagCPSQL.GetPrimaryKeyValue()
        End If
        'Message : Data saved successfully
        Dim strMsgRecordsSaved As String = MyBase.GetResourceString("DATA_SAVED")
        m_strInformativeMessage = "window.status='" + strMsgRecordsSaved + "';"

    End Sub
    Private Sub SubTag_CPPage_BeforeSave(Optional ByVal blnIsMultiInsertSubTag As Boolean = False)
        '=====================================================================
        ' Procedure Name        :	SubTag_CPPage_BeforeSave
        ' Purpose               :	This method will call the before save event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, December 1, 2003 
        ' Revisions             :   By Ninad on 6 Dec 2007, Req ID - WAF3_PB_55, blnIsMultiInsertSubTag is added to signiture
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeSave")
        If blnCheckEventCall = True Then
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_objSubTagCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objSubTagGlobal
            ExtensionArgs.ControlsHashTable = MyBase.GetFormCollectionHashTable
            ExtensionArgs.RedirectToCL = m_blnRedirectToCL

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "BeforeSave", ExtensionArgs)

            m_objSubTagCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
            m_blnRedirectToCL = ExtensionArgs.RedirectToCL
            m_objSubTagGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.BeforeSave(m_objSubTagGlobal, MyBase.GetFormCollectionHashTable, m_objSubTagCPSQL.PrimaryKeyValue, m_blnRedirectToCL)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = BeforeSave(m_objSubTagGlobal, MyBase.GetFormCollectionHashTable, m_objSubTagCPSQL.PrimaryKeyValue, strActionCode, m_blnRedirectToCL)
            cobjEventHndlr.ActionCode = strActionCode
            'Added By Ninad on 6 Dec 2007, Req ID - WAF3_PB_55 
            If Not blnIsMultiInsertSubTag Then
                m_strNewPK = m_objSubTagCPSQL.PrimaryKeyValue
            End If
            'Added By Ninad on 6 Dec 2007, Req ID - WAF3_PB_55
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.
        cobjEventHndlr = Nothing
    End Sub
    Private Sub SubTag_CPPage_AfterSave()
        '=====================================================================
        ' Procedure Name        :	SubTag_CPPage_AfterSave
        ' Purpose               :	This method will call the after save event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, December 1, 2003 
        ' Revisions             :
        '=====================================================================
        'If the Before Delete event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterSave")
        If blnCheckEventCall = True Then
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objSubTagGlobal
            ExtensionArgs.IsEditMode = False
            ExtensionArgs.ControlsHashTable = MyBase.GetFormCollectionHashTable
            ExtensionArgs.RedirectToCL = m_blnRedirectToCL

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "AfterSave", ExtensionArgs)

            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
            m_blnRedirectToCL = ExtensionArgs.RedirectToCL
            m_objSubTagGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Dim strAction As String = cobjEventHndlr.AfterSave(m_objSubTagGlobal, MyBase.GetFormCollectionHashTable, m_objSubTagCPSQL.PrimaryKeyValue, , m_blnRedirectToCL)
            Dim strActionCode As String = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
            Dim strAction As String = AfterSave(m_objSubTagGlobal, MyBase.GetFormCollectionHashTable, m_objSubTagCPSQL.PrimaryKeyValue, strActionCode, , m_blnRedirectToCL)
            'm_strNewPK = m_cObjCPSQL.PrimaryKeyValue
            cobjEventHndlr.ActionCode = strActionCode

            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends
        cobjEventHndlr = Nothing
    End Sub
    Private Sub SubTagCP_Page_PreRender()
        '=====================================================================
        ' Procedure Name        :	SubTagCP_Page_PreRender
        ' Purpose               :	This method will call the Pre render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, October 29, 2003 
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPreRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_objSubTagCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objSubTagGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPreRender", ExtensionArgs)

            m_objSubTagCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
            m_objSubTagGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            Dim strAction As String = cobjEventHndlr.PageUIPreRender(m_objSubTagGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.
        cobjEventHndlr = Nothing

    End Sub
    Private Sub SubTagCP_Page_PostRender()
        '=====================================================================
        ' Procedure Name        :	SubTagCP_Page_PostRender
        ' Purpose               :	This method will call the Post render event 
        '                           from the page event handler class
        ' Description           :	Same as above 
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 06, 2004
        ' Revisions             :
        '=====================================================================
        'If the prerender event is enabled then call it
        Dim cobjEventHndlr As New CommonEngine.General.cEventHandlers

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPostRender")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.PrimaryKey = m_objSubTagCPSQL.PrimaryKeyValue
            ExtensionArgs.m_global = m_objSubTagGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.cEventHandlers", _
                            "PageUIPostRender", ExtensionArgs)

            m_objSubTagCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
            m_objSubTagGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            Dim strAction As String = cobjEventHndlr.PageUIPostRender(m_objSubTagGlobal, m_objSubTagCPSQL.PrimaryKeyValue)
            'Execute the Action
            Call WriteClientsideScript_ExecuteAction(cobjEventHndlr, strAction)
        End If
        'addition ends.

        cobjEventHndlr = Nothing

    End Sub

    Private Sub SubTag_CPExecuteDynamicLinkAction()
        '=====================================================================
        ' Procedure Name        :	SubTag_CPExecuteDynamicLinkAction
        ' Purpose               :	This method is used to execute the action 
        '                           for the selected dynamic link and if the link
        '                           is on the List page then redirect to list page
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 1, 2003 
        ' Revisions             :
        '=====================================================================
        Dim strDynamicLinkID As String = CommonFunction.General.CheckIsNothing(Request.QueryString("DYNAMIC_LINK_ID"))
        'If the dynamic link ID is not specified then exit
        If strDynamicLinkID.Trim = "" Then Return
        Dim strAction As String = ""
        Dim strUniqueValue As String = CommonFunction.General.CheckIsNothing(Request.QueryString("UniqueValue"))
        Dim blnCancelAction As Boolean = False
        Dim objLink As EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution
        Dim strMsgActionExecuted As String = MyBase.GetResourceString("ACTION_EXECUTED")
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        If m_objGlobal.UseHashTable = "N" Then
            'Retrieve the link action from the database
            Dim strSQL As String = " usp_Sel_tbl_UI_SubTag_Dynamic_Links null,null,'" + strDynamicLinkID + "'"
            Dim drLink As IDataReader = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drLink.Read Then
                'SP to execute as Action
                strAction = CommonFunction.Data.CheckIsDBNull(drLink("SpToExecute")).ToString
                strAction = ReplacePlaceHolders(strAction, strUniqueValue, m_objSubTagGlobal)
                'Prepare the Link Object
                objLink = PrepareDynamicLinkObject(CommonFunction.Data.CheckIsDBNull(drLink("AccessRights")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("ClientSideFunctionName")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("ConditionClause")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("CreatedBy")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("CreatedDate")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("CustomLink")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("DisplayPosition")).ToString, _
                        CommonFunction.Data.CheckIsDBNull(drLink("Identifier")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("ImageURL")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("LinkName")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("LinkToolTip")).ToString, CommonFunction.Data.CheckIsDBNull(drLink("LinkType")).ToString, CType(CommonFunction.Data.CheckIsDBNull(drLink("ListPageOrderNumber"), "0"), Long), CType(CommonFunction.Data.CheckIsDBNull(drLink("OrderNumber"), "0"), Long), CommonFunction.Data.CheckIsDBNull(drLink("SpToExecute")).ToString, _
                        CommonFunction.Data.CheckIsDBNull(drLink("SystemLinkType")).ToString, CType(CommonFunction.Data.CheckIsDBNull(drLink("TagID"), "0"), Long), CType(CommonFunction.Data.CheckIsDBNull(drLink("UniqueID"), "0"), Long), m_strCommonQueryString, "0", m_strMode, strMsgActionExecuted)
            End If
            'dispose data reader
            CommonFunction.Data.DisposeDataReader(drLink)
        Else
            'Retrieve the link action from the Hashtable
            Dim objDynamicLinksHashTable As CommonEngines.HashTables.DynamicLinks()
            Dim intIndex As Integer
            Dim intLength As Integer

            objDynamicLinksHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableDynamicLinkCPObject(m_objSubTagGlobal.TagID)
            intLength = objDynamicLinksHashTable.Length
            For intIndex = 0 To intLength - 1
                If objDynamicLinksHashTable(intIndex).UniqueID.ToString = strDynamicLinkID Then
                    'SP to execute as Action
                    strAction = CommonFunction.General.CheckIsNothing(objDynamicLinksHashTable(intIndex).SpToExecute, "")
                    strAction = ReplacePlaceHolders(strAction, strUniqueValue, m_objGlobal)
                    'Prepare the Link Object
                    objLink = PrepareDynamicLinkObject(objDynamicLinksHashTable(intIndex).AccessRights, objDynamicLinksHashTable(intIndex).ClientSideFunctionName, objDynamicLinksHashTable(intIndex).ConditionClause, objDynamicLinksHashTable(intIndex).CreatedBy, objDynamicLinksHashTable(intIndex).CreatedDate, objDynamicLinksHashTable(intIndex).CustomLink, objDynamicLinksHashTable(intIndex).DisplayPosition, _
                            objDynamicLinksHashTable(intIndex).Identifier, objDynamicLinksHashTable(intIndex).ImageURL, objDynamicLinksHashTable(intIndex).LinkName, objDynamicLinksHashTable(intIndex).LinkToolTip, objDynamicLinksHashTable(intIndex).LinkType, objDynamicLinksHashTable(intIndex).ListPageOrderNumber, objDynamicLinksHashTable(intIndex).OrderNumber, strAction, _
                            objDynamicLinksHashTable(intIndex).SystemLinkType, objDynamicLinksHashTable(intIndex).TagID, objDynamicLinksHashTable(intIndex).UniqueID, m_strCommonQueryString, "0", m_strMode, strMsgActionExecuted)
                    Exit For
                End If
            Next
            objDynamicLinksHashTable = Nothing
        End If

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_ExecutingAction")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.Cancel = blnCancelAction
            ExtensionArgs.m_LinkExecution = objLink
            ExtensionArgs.m_global = m_objSubTagGlobal
            ExtensionArgs.PrimaryKey = strUniqueValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "Before_ExecutingAction", ExtensionArgs)

            blnCancelAction = ExtensionArgs.Cancel
            objLink = ExtensionArgs.m_LinkExecution
            m_objSubTagGlobal = ExtensionArgs.m_global
            strUniqueValue = ExtensionArgs.PrimaryKey
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Before executing the action Call the event
            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_ExecutingAction(blnCancelAction, objLink, m_objSubTagGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            Call Before_ExecutingAction(blnCancelAction, objLink, m_objSubTagGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            'Addition Ends
            HttpContext.Current.Response.Write(objLink.ToBeInserted)
        End If
        'addition ends.
        'If Action Exists then Execute it
        If blnCancelAction = False And objLink.SpToExecute <> "" Then
            'If Cancel = false then execute the action
            CommonFunction.Data.InsertOrUpdateData(objLink.SpToExecute, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised

        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "After_ExecutingAction")
        If blnCheckEventCall = True Then
            objLink.ToBeInserted = ""
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            ExtensionArgs.m_LinkExecution = objLink
            ExtensionArgs.m_global = m_objSubTagGlobal
            ExtensionArgs.PrimaryKey = strUniqueValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                "After_ExecutingAction", ExtensionArgs)

            objLink = ExtensionArgs.m_LinkExecution
            m_objSubTagGlobal = ExtensionArgs.m_global
            strUniqueValue = ExtensionArgs.PrimaryKey
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'After executing the action Call the event

            '--Code Modified:RajeshB            15th Jan 2005
            '-- Purpose: Wrap the event call in function to allow the inheriting
            ' class to delegate it anywhere
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_ExecutingAction(objLink, m_objSubTagGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            Call After_ExecutingAction(objLink, m_objSubTagGlobal, strUniqueValue, MyBase.GetFormCollectionHashTable)
            'Addition Ends
            HttpContext.Current.Response.Write(objLink.ToBeInserted)
        End If
        'addition ends.
        'Action executed
        m_strInformativeMessage = "window.status='" + strMsgActionExecuted + "';"
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    '-----------------------------------------------------------------------
    ' START :  GET FOREIGN KEY AS - RIGHT SIDE PAGE CAPTION FOR THE SUB TAG
    '-----------------------------------------------------------------------
    Private Function SubTag_GetRightPageCaption(ByVal strValue As String, ByVal lngSubTagId As Long) As String
        '=====================================================================
        ' Procedure Name        :	SubTag_GetRightPageCaption
        ' Purpose               :	get the right side page caption
        ' Description           :	Same as above
        ' Parameters Passed     :	strControlCaption - ControlCaption
        '                           intControlTypeID - Data Type
        '                           strValue - Field Value to be formatted
        '                           strSQL - SQL query
        ' Parameters Affected   :	None
        ' Returns               :	strRightPageCaption
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 1, 2003 
        ' Revisions             :   UmeshJ 24 Feb 2004..(currently not in use)
        '=====================================================================
        SubTag_GetRightPageCaption = ""
        Dim strControlCaption As String
        Dim intControlTypeID As Integer
        Dim strSQL As String
        Dim strQuery As String = "usp_Sel_v_tbl_UI_SubControlTagMaster_FieldDetails " + lngSubTagId.ToString + ",'*','IsForeignKey=1'"
        Dim drFKDetails As IDataReader = CommonFunction.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drFKDetails.Read() Then
            If Not IsDBNull(drFKDetails("ControlCaption")) Then strControlCaption = drFKDetails("ControlCaption").ToString
            If Not IsDBNull(drFKDetails("ControlTypeID")) Then intControlTypeID = CType(drFKDetails("ControlTypeID"), Integer)
            If Not IsDBNull(drFKDetails("AdditionalInformation")) Then strSQL = drFKDetails("AdditionalInformation").ToString
            'Control Type ID
            Select Case intControlTypeID
                Case CommonFunction.Constants.CONTROL_TYPE_COMBO_BOX
                    'Replace the Place holder by actual value
                    strSQL = Microsoft.VisualBasic.Strings.Replace(strSQL, "<MASTER_PK>", strValue)
                    SubTag_GetRightPageCaption = CommonFunction.General.GetDisplayValue(strSQL, strValue, True)
                Case CommonFunction.Constants.CONTROL_TYPE_LIST_BOX
                    'Replace the Place holder by actual value
                    strSQL = Microsoft.VisualBasic.Strings.Replace(strSQL, "<MASTER_PK>", strValue)
                    SubTag_GetRightPageCaption = CommonFunction.General.GetDisplayValue(strSQL, strValue, False)
                Case Else
                    'Get the Value in proper format
                    SubTag_GetRightPageCaption = FormatValue(strValue, intControlTypeID)
            End Select
            'If the Right Page caption is blank then do not show it else add suffix as control caption
            If SubTag_GetRightPageCaption.Trim <> "" Then
                SubTag_GetRightPageCaption = strControlCaption + ": " + SubTag_GetRightPageCaption
            End If
        End If
        'Destroy the object
        drFKDetails.Close()
        drFKDetails.Dispose()
        drFKDetails = Nothing

    End Function
    Private Function FormatValue(ByVal strValue As String, ByVal intControlTypeID As Integer) As String
        '=====================================================================
        ' Procedure Name        :	FormatValue
        ' Purpose               :	Return the Grid Column Value in proper format
        ' Description           :	Same as above
        ' Parameters Passed     :	strValue - Field Value to be formatted
        '                           intControlTypeID - Data Type
        ' Parameters Affected   :	None.
        ' Returns               :	string for (<TD>..</TD>) with the formated value
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Wednesday, October 2, 2003 
        ' Revisions             :
        '=====================================================================
        FormatValue = ""
        If strValue = "" Then Return ""
        Select Case intControlTypeID
            Case CommonFunction.Constants.CONTROL_TYPE_DATE
                FormatValue = CommonFunction.Dates.CGetDate(CType(strValue, Date))
            Case CommonFunction.Constants.CONTROL_TYPE_CHECK_BOX
                'Common Page Resource File
                MyBase.InitializeResources("Resources.StandardMessages", "Resources")
                If UCase(strValue) = "TRUE" Then
                    FormatValue = MyBase.GetResourceString("YES") '"Yes"
                Else
                    FormatValue = MyBase.GetResourceString("NO") '"No"
                End If
                'Common Page Resource File
                MyBase.InitializeResources("Resources.CommonPage", "Resources")
            Case Else
                FormatValue = HttpContext.Current.Server.HtmlEncode(strValue)
        End Select
    End Function
    '-----------------------------------------------------------------------
    ' END :  GET FOREIGN KEY AS - RIGHT SIDE PAGE CAPTION FOR THE SUB TAG
    '-----------------------------------------------------------------------
    Private Function IsSubTagSectionAccessible(ByVal lngSectionID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        :	IsSubTagSectionAccessible
        ' Purpose               :	Check Is the Sub Tag Section Accessible to the Role
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - Section ID
        ' Parameters Affected   :	None.
        ' Returns               :	True - if the Role has access of any of the Sub Tags
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Monday, August 16, 2004
        ' Revisions             :
        '=====================================================================
        'For Sections other than Sub Tag..return TRUE
        If lngSectionID <> CommonFunctions.Constants.SECTION_SUBTAG Then Return True
        'For Sub Tag Section ..check the access

        IsSubTagSectionAccessible = False

        'UJ_12102006 START : Event Added to customize the Access check for the Sub Tag Section  
        Dim Cancel As Boolean
        IsSubTagSectionAccessible = CommonEngine.General.CLCP_Events_SubTag.BeforeCheck_IsSubTagSectionAccessible(Cancel, m_objGlobal)
        If Cancel = True Then Return IsSubTagSectionAccessible
        'UJ_12102006 END

        Dim SubTagHashtable() As CommonEngines.HashTables.SubUITagMaster
        Dim SubTagObject As CommonEngines.HashTables.SubUITagMaster
        Dim blnAccess As Boolean
        Dim intSubTagCnt As Integer = 0
        Dim intCnt As Integer
        Dim intSubCnt As Integer = 0

        SubTagHashtable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(m_objGlobal.TagID)
        If Not SubTagHashtable Is Nothing Then
            Dim lngSubTag(SubTagHashtable.Length - 1) As Long

            For Each SubTagObject In SubTagHashtable
                If SubTagObject.ApplyRoleLevelAccess = True Then
                    lngSubTag(intSubTagCnt) = SubTagObject.SubTagID
                    intSubTagCnt += 1
                    '##### Added By AshishR on 21 June 2005
                    'If any sub tag having ApplyRoleLevel Access FALSE then function should return True
                Else
                    SubTagObject = Nothing
                    SubTagHashtable = Nothing
                    IsSubTagSectionAccessible = True
                    Exit Function
                    '########## End OF addition
                End If
            Next

            SubTagObject = Nothing
            SubTagHashtable = Nothing

            For intCnt = 0 To intSubTagCnt - 1
                For Each blnAccess In CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_objGlobal.RoleID.ToString + "-" + _
                                       m_objGlobal.TagID.ToString + "-" + lngSubTag(intCnt).ToString)
                    If blnAccess = True Then
                        IsSubTagSectionAccessible = True
                        Exit Function
                    End If
                Next
            Next

            Dim strGroups() As String = Split(CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheGroup(m_objGlobal.UserID.ToString + "-" + m_objGlobal.LoginType), ",")

            For intCnt = 0 To strGroups.Length - 1
                If strGroups(intCnt) <> "" Then
                    For intSubCnt = 0 To lngSubTag.Length - 1
                        For Each blnAccess In CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(strGroups(intCnt) + "-" + _
                                                           m_objGlobal.TagID.ToString + "-" + lngSubTag(intSubCnt).ToString)
                            If blnAccess = True Then
                                IsSubTagSectionAccessible = True
                                Exit Function
                            End If
                        Next
                    Next
                End If
            Next

            strGroups = Nothing
        End If


        'Dim strSQL As String = "usp_Sel_tbl_UI_SubNodeAccess_ForRole " + m_objGlobal.RoleID.ToString + "," + m_objGlobal.TagID.ToString
        'If CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString = "1" Then
        '    IsSubTagSectionAccessible = True
        'End If
    End Function
#Region "RELATED DATA"

    Private Sub PlotRelatedData()
        '=====================================================================
        ' Procedure Name        :	PlotRelatedData
        ' Purpose               :	Plot the section : Related Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003 
        ' Revisions             :
        '=====================================================================
        'Create Hash Table object for Related Data
        Dim objDataHashTable() As CommonEngines.HashTables.UIRelatedData
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Same Culture ID as default
            objDataHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIRelatedDataObject(m_objGlobal.TagID)
        Else
            'Culture ID is different 
            objDataHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIRelatedDataObject(m_objGlobal.TagID + m_objGlobal.LCID)
            If objDataHashTable Is Nothing Then
                'Culture not supported ...use default
                objDataHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIRelatedDataObject(m_objGlobal.TagID)
            End If
        End If

        If objDataHashTable Is Nothing Then
            ' ***************************************************************************************
            ' Commented Sep 03,2004 Rajanikant Khethawatt WAF2 (Bhagirath Phase II)
            ' ***************************************************************************************
            '       When related data section is added to a page with no items for related data..
            '       the "no data" comment was shown! This is commented because its not required.

            ' Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_RELATED_DATA)

            ' ***************************************************************************************
            ' End Of Comment 30,2004 Rajanikant Khethawatt WAF2 (Bhagirath Phase II)
            ' ***************************************************************************************
            Return
        End If

        Dim intIndex As Integer
        Dim intLastIndex As Integer = objDataHashTable.Length - 1
        For intIndex = 0 To intLastIndex
            If objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_UI.ToString Or objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_BOTH.ToString Then 'Added By Ninad on 2 April 2008 Issue ID 19793
                If (InStr(objDataHashTable(intIndex).DataGridSQL, "<UNIQUE_ID>") <> 0 And CommonFunction.General.CheckIsNothing(m_cObjCPSQL.PrimaryKeyValue) <> "") _
                    Or (InStr(objDataHashTable(intIndex).DataGridSQL, "<UNIQUE_ID>") = 0) Then
                    Dim RelatedDataDivID As String = "RelatedData_DivList" + intIndex.ToString

                    'Data Header
                    Dim objHeader As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
                    Dim blnCancelHeader As Boolean = False
                    objHeader = PrepareRelatedDataHeaderObject(objDataHashTable(intIndex).DataHeader.Trim, objDataHashTable(intIndex).DataHeaderAlignment.Trim, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).UniqueID)

                    ' ***************************************************************************************
                    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                    ' ***************************************************************************************
                    ' set the condition clause of the object
                    objHeader.ConditionClause = objDataHashTable(intIndex).ConditionClause
                    'Added By UmeshJ Aug 03, 2007
                    objHeader.ConditionClause = ReplacePlaceHolders(objHeader.ConditionClause, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)
                    'End of Addition
                    ' ***************************************************************************************
                    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                    ' ***************************************************************************************
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.

                    ExtensionArgs.Cancel = blnCancelHeader
                    ExtensionArgs.m_RelatedDataHeader = objHeader
                    ExtensionArgs.m_global = m_objGlobal
                    ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                            "Before_PlotRelatedDataHeader", ExtensionArgs)

                    objHeader = ExtensionArgs.m_RelatedDataHeader
                    blnCancelHeader = ExtensionArgs.Cancel
                    m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                    m_objGlobal = ExtensionArgs.m_global
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    'Call the Before Print Event for Related Data Header
                    '--Code Modified:RajeshB            15th Jan 2005
                    '-- Purpose: Wrap the event call in function to allow the inheriting
                    ' class to delegate it anywhere
                    'Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    Call Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    'Addition Ends
                    ' ***************************************************************************************
                    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                    ' ***************************************************************************************

                    ' Check the condition to plot the related data info.
                    Dim dr As IDataReader
                    Dim blnPlotHeader As Boolean = True

                    If Trim(objHeader.ConditionClause & "") <> "" Then
                        '==========================================================================================================
                        'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                        dr = CommonFunctions.Data.GetDataReader(objHeader.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
                        ' Addition End By : Ninad   Req Id : WAF3_PB_33
                        '==========================================================================================================
                        If dr.Read Then
                            blnPlotHeader = True
                        Else
                            blnPlotHeader = False
                        End If
                        CommonFunctions.Data.DisposeDataReader(dr)
                    End If

                    ' Plot the header only when there are some rows returned by execution of the condition clause sql
                    If blnPlotHeader Then
                        If blnCancelHeader = False Then Call RelatedData_Header(objHeader.DataHeader, objHeader.DataHeaderAlignment)
                    End If
                    ' ***************************************************************************************
                    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                    '***************************************************************************************
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.m_RelatedDataHeader = objHeader
                    ExtensionArgs.m_global = m_objGlobal
                    ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                            "After_PlotRelatedDataHeader", ExtensionArgs)

                    objHeader = ExtensionArgs.m_RelatedDataHeader
                    m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
                    m_objGlobal = ExtensionArgs.m_global
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    'Call the After Print Event for Related Data Header
                    'Code Modified:RajeshB          19 Jan 2005
                    ' Purpose:Wrap the event call into a function
                    'Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataHeader(objHeader, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    Call After_PlotRelatedDataHeader(objHeader, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                    objHeader = Nothing

                    'Related Data Grid
                    ' ***************************************************************************************
                    ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                    ' ***************************************************************************************
                    Dim gridSQL As String = ReplacePlaceHolders(objDataHashTable(intIndex).DataGridSQL, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)
                    ' Passing the condition clause to the routine to plot grid
                    Call RelatedData_Grid(gridSQL, RelatedDataDivID, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).UniqueID, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).ConditionClause, Not (objDataHashTable(intIndex).VerticalDisplay))
                    ' ***************************************************************************************
                    ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                    ' ***************************************************************************************

                    'Separator HTML Tag
                    If intIndex < intLastIndex Then Response.Write(CommonFunction.General.CheckIsNothing(objDataHashTable(intIndex).SeperatorHTMLTag))
                End If
            End If
        Next
        'Destroy the object
        objDataHashTable = Nothing

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataHeader(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotRelatedDataHeader(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataHeader(Args, WhizGlobal, "")
    End Sub
    Private Sub RelatedData_Header(ByVal DataHeader As String, ByVal Align As String)
        '=====================================================================
        ' Procedure Name        :	RelatedData_Header
        ' Purpose               :	Related Data Header
        ' Description           :	Same as above
        ' Parameters Passed     :	DataHeader, AlignMent
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003
        ' Revisions             :
        '=====================================================================
        If DataHeader.Trim = "" Then Return
        Dim cObjPageCaption As New WebPages.UI.cPageCaption
        Dim WhizGlobal As New WebPages.Template.WhizGlobal
        'Added By Chakshuta H on 30th-Oct-2015
        'Added by Vinay on 13 Aug 2008 issue id->21865
        Response.Write("<BR>")
        'Addition End by Vinay on 13 Aug 2008 issue id->21865

        'Ended By Chakshuta H on 30th-Oct-2015

        WhizGlobal.TagID = -1
        WhizGlobal.ParentTagID = -1
        With cObjPageCaption
            .clsTable = "clsTable"
            .clsTR = "clsTRPageCaption"
            .returnHTML = True
            .LeftPageCaption = "" : .RightPageCaption = "" : .MiddlePageCaption = ""
            Select Case CommonFunction.General.CheckIsNothing(Align.ToUpper)
                Case "LEFT"
                    'Plot Left Data Header
                    .LeftPageCaption = DataHeader
                Case "RIGHT"
                    'Plot Right Data Header
                    .RightPageCaption = DataHeader
                Case "CENTER"
                    'Plot Center Data Header
                    .MiddlePageCaption = DataHeader
                Case ""
                    'No caption
                Case Else
                    'Plot Left Data Header
                    .LeftPageCaption = DataHeader
            End Select
            Response.Write(.DrawPageCaption())
        End With
        Response.Write("<BR>")
        'Destroy the object
        WhizGlobal = Nothing
        cObjPageCaption = Nothing
    End Sub

    Private Function PrepareRelatedDataHeaderObject(ByVal DataHeader As String, ByVal DataHeaderAlignment As String, ByVal OrderNumber As Long, ByVal QRBQueryID As Long, ByVal UniqueID As Long) As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
        '=====================================================================
        ' Procedure Name        :	PrepareRelatedDataHeaderObject
        ' Purpose               :	Prepare Related Data Header Object for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim objDataHeader As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
        With objDataHeader
            .DataHeader = DataHeader
            .DataHeaderAlignment = DataHeaderAlignment
            .OrderNumber = OrderNumber
            .QRBQueryID = QRBQueryID
            .UniqueID = UniqueID
        End With
        PrepareRelatedDataHeaderObject = objDataHeader
    End Function

    Private Function PrepareRelatedDataGridObject(ByVal GridSQL As String, ByVal ActualColumnArray As String(), ByVal UserFriendlyColumnArray As String(), ByVal TDStyleArray As String(), ByVal TableStyle As String, ByVal OrderNumber As Long, ByVal QRBQueryID As Long, ByVal UniqueID As Long, ByVal BooleanFalseHTML As String, ByVal BooleanTrueHTML As String, ByVal ColNameToolTipOnEachRow As Boolean, ByVal DivID As String, ByVal DivHeight As Integer, ByVal DivStyle As String, ByVal NoDataComment As String, ByVal NoOfDataColumns As Integer, ByVal VerticalDisplay As Boolean, ByVal DisplayPosition As String) As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid
        '=====================================================================
        ' Procedure Name        :	PrepareRelatedDataGridObject
        ' Purpose               :	Prepare Related Data Grid Object for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim objDataGrid As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid
        With objDataGrid
            .GridSQL = GridSQL
            .ActualColumnArray = ActualColumnArray
            .UserFriendlyColumnArray = UserFriendlyColumnArray
            .TableStyle = TableStyle
            .TDStyleArray = TDStyleArray
            .NoOfDataColumns = NoOfDataColumns
            .BooleanFalseHTML = BooleanFalseHTML
            .BooleanTrueHTML = BooleanTrueHTML
            .ColNameToolTipOnEachRow = ColNameToolTipOnEachRow
            .DivID = DivID
            .DIVHeight = DivHeight
            .DIVStyle = DivStyle
            .OrderNumber = OrderNumber
            .QRBQueryID = QRBQueryID
            .UniqueID = UniqueID
            .NoDataComment = NoDataComment
            .VerticalDisplay = VerticalDisplay
            .DisplayPosition = DisplayPosition
        End With
        PrepareRelatedDataGridObject = objDataGrid
    End Function

    Private Sub RelatedData_Grid(ByVal GridSQL As String, ByVal RelatedDataDivID As String, ByVal OrderNumber As Long, ByVal UniqueID As Long, ByVal QRBQueryID As Long, ByVal ConditionClause As String, Optional ByVal VerticalDisplay As Boolean = True, Optional ByVal DisplayPosition As String = "0")
        '=====================================================================
        ' Procedure Name        :	RelatedData_Grid
        ' Purpose               :	Plot Related Data Grid
        ' Description           :	Same as above
        ' Parameters Passed     :	GridSQL - SQL to plot the grid
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003
        ' Revisions             :   Aug 30,2004 Rajanikant Khethawatt
        '                           Added param cond. clause WAF2_PB_43
        '=====================================================================

        'Plot Grid
        Dim strGRID As String = ""
        Dim strSortBy As String = ""
        Dim strSortOrder As String = ""
        Dim intDataColumns As Integer
        'Arraylist columns
        Dim arrListUFName As New System.Collections.ArrayList
        Dim arrListActualName As New System.Collections.ArrayList
        Dim arrListCheckBox As New System.Collections.ArrayList
        Dim arrListTDStyle As New System.Collections.ArrayList
      
  'Added By Shrikant On 20 June 2008 for SRID: 287 and IssueID: 16575
        'Used DataSet and DataTable instead of DataReader so that the grid-sql will be fired only once
        'The same data table will be used for both, to get columns and to pass to the Grid-component.
        Dim dsGrid As DataSet = CommonFunction.Data.GetDataSet(GridSQL, "_RelatedDataGrid", , , CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
        Dim dtGrid As DataTable = dsGrid.Tables("_RelatedDataGrid")
        dsGrid.Dispose() : dsGrid = Nothing
        intDataColumns = dtGrid.Columns.Count()
        Dim intIndex As Integer
        Dim intLastIndex As Integer = intDataColumns - 1
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Added By Chakshuta H on 30th-Oct-2015
        'Added by Vinay on 2 DEC. 2008 WAF3_GEN_18
        'Purpose:-For Releted Data Grid Get Value from Culture Table if it exsits otherwise select english entry
        Dim strCombinedSQL As String = ""
        Dim strActualColumn As String = ""
        Dim blnRTLCultureSupported As Boolean = False
        If CommonFunctions.General.CheckIsRTLCultureSupported = True Then
            blnRTLCultureSupported = True
        End If
        'Ended By Chakshuta H on 30th-Oct-2015

        For intIndex = 0 To intLastIndex
            'User Friendly Column Name
            ''Commented And Added By Chakshuta H on 30th-Oct-2015 
            ''arrListUFName.Add(dtGrid.Columns(intIndex).ColumnName)
            If blnRTLCultureSupported = True Then
                strCombinedSQL = "usp_sel_tbl_UI_TagReletedData_GetControlName " + UniqueID.ToString + "," + dtGrid.Columns(intIndex).ColumnName
                strActualColumn = CStr(CommonFunctions.Data.GetDataScalar(strCombinedSQL, True))
                If strActualColumn Is Nothing Then
                    strActualColumn = dtGrid.Columns(intIndex).ColumnName
                End If
            Else
                strActualColumn = dtGrid.Columns(intIndex).ColumnName
            End If

            arrListUFName.Add(strActualColumn)
            'Modification End by Vinay on 02 DEC. 2008 WAF3_GEN_18
            ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
            'Actual Column Name
            arrListActualName.Add(dtGrid.Columns(intIndex).ColumnName)
            'Check Box ...blank entry
            arrListCheckBox.Add("")
            'TD Style
            arrListTDStyle.Add(" align=" + CommonList.RelatedData_GetAlignmentByType(dtGrid.Columns(intIndex).DataType.ToString()) + " ")
        Next
  'Get Grid Columns
      ''==========================================================================================================
        ''Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
        'Dim drGrid As IDataReader = CommonFunction.Data.GetDataReader(GridSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
        '' Addition End By : Ninad   Req Id : WAF3_PB_33
        ''==========================================================================================================

        'intDataColumns = drGrid.FieldCount()
	'Dim intIndex As Integer
        'Dim intLastIndex As Integer = intDataColumns - 1
        ''Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        'Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'For intIndex = 0 To intLastIndex
        '    'User Friendly Column Name
        '    arrListUFName.Add(drGrid.GetName(intIndex))
        '    'Actual Column Name
        '    arrListActualName.Add(drGrid.GetName(intIndex))
        '    'Check Box ...blank entry
        '    arrListCheckBox.Add("")
        '    'TD Style
        '    arrListTDStyle.Add(" align=" + RelatedData_GetAlignment(CType(drGrid.GetDataTypeName(intIndex), String)) + " ")
        'Next
        'Comment Ends By Shrikant  On 20 June 2008 for SRID: 287 and IssueID: 16575


        'Convert ArrayList into String Array : User Friendly Column Names
        Dim arrUFName(arrListUFName.Count - 1) As String
        arrListUFName.ToArray.CopyTo(arrUFName, 0)

        'Actual Column Name
        Dim arrActualName(arrListActualName.Count - 1) As String
        arrListActualName.ToArray.CopyTo(arrActualName, 0)

        'Check Box
        Dim arrCheckBox(arrListCheckBox.Count - 1) As String
        arrListCheckBox.ToArray.CopyTo(arrCheckBox, 0)

        'TD Style
        Dim arrTDStyle(arrListTDStyle.Count - 1) As String
        arrListTDStyle.ToArray.CopyTo(arrTDStyle, 0)

         ''Destroy the object
        'CommonFunction.Data.DisposeDataReader(drGrid) Comment Ends By Shrikant  On 20 June 2008 for SRID: 287 and IssueID: 16575
        arrListUFName = Nothing
        arrListActualName = Nothing
        arrListCheckBox = Nothing
        arrListTDStyle = Nothing

        'Call Before Print event for Grid
        Dim DataGrid As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid
        Dim blnCancelGrid As Boolean = False
        MyBase.InitializeResources("Resources.StandardMessages", "Resources")
        DataGrid = PrepareRelatedDataGridObject(GridSQL, arrActualName, arrUFName, arrTDStyle, "cellspacing=0 cellpadding=0", OrderNumber, QRBQueryID, UniqueID, MyBase.GetResourceString("No"), MyBase.GetResourceString("Yes"), True, RelatedDataDivID, 300, "overflow:auto", MyBase.GetResourceString("NO_RECORDS"), intDataColumns, VerticalDisplay, DisplayPosition)
        ' ***************************************************************************************
        ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************
        ' replace the place-holders in the condition clause 
        DataGrid.ConditionClause = ReplacePlaceHolders(ConditionClause, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)
        ' ***************************************************************************************
        ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************

        MyBase.InitializeResources("Resources.CommonPage", "Resources")
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        ExtensionArgs.Cancel = blnCancelGrid
        ExtensionArgs.m_RelatedDataGrid = DataGrid
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                "Before_PlotRelatedDataGrid", ExtensionArgs)

        DataGrid = ExtensionArgs.m_RelatedDataGrid
        blnCancelGrid = ExtensionArgs.Cancel
        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
        m_objGlobal = ExtensionArgs.m_global
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call the Before Print event for the Grid
        'Code Modified:RajeshB          19 Jan 2005
        ' Purpose:Wrap the event call into a function
        'Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataGrid(blnCancelGrid, DataGrid, m_objGlobal, m_cObjCPSQL.PrimaryKey)
        Call Before_PlotRelatedDataGrid(blnCancelGrid, DataGrid, m_objGlobal, m_cObjCPSQL.PrimaryKey)

        ' ***************************************************************************************
        ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************
        ' Check the condition to plot the related data info.
        Dim dr As IDataReader
        Dim blnPlotGrid As Boolean = True

        If Trim(DataGrid.ConditionClause & "") <> "" Then
            '==========================================================================================================
            'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
            dr = CommonFunctions.Data.GetDataReader(DataGrid.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
            ' Addition End By : Ninad   Req Id : WAF3_PB_33
            '==========================================================================================================
            If dr.Read Then
                blnPlotGrid = True
            Else
                blnPlotGrid = False
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
        End If

        ' Plot the grids only when there are some rows returned by executin of the condition clause sql
        If blnPlotGrid Then
            ' ***************************************************************************************
            ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
            ' ***************************************************************************************
            'Plot the grid
            m_objGrid = New WebPage.Templates.GenericGrid
            With m_objGrid
                '==========================================================================================================
                'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                .ConnectionString = m_strConnectionString
                ' Addition End By : Ninad   Req Id : WAF3_PB_33
                '==========================================================================================================
                .UserFriendlyColumnArray = DataGrid.UserFriendlyColumnArray
                .ActualColumnArray = DataGrid.ActualColumnArray
                .NoOfDataColumns = DataGrid.NoOfDataColumns
                .TDStyleArray = DataGrid.TDStyleArray
                .SQL = DataGrid.GridSQL
                .CheckBoxIDArray = arrCheckBox
                .DIVStyle = DataGrid.DIVStyle
                .DIVHeight = DataGrid.DIVHeight
                .DIVID = DataGrid.DivID
                .ColNameToolTipOnEachRow = DataGrid.ColNameToolTipOnEachRow
                .VerticalDisplay = DataGrid.VerticalDisplay
                .BooleanFalseHTML = DataGrid.BooleanFalseHTML  '|false | <img src='../../images/cross.gif'>
                .BooleanTrueHTML = DataGrid.BooleanTrueHTML  '|true | <img src='../../images/check.gif'>

                .PrinterFriendlyVersion = True
                .ColumnHeaderAlignment = "" 'Take alignment from the as of the row
                .SortOrder = strSortOrder
                .SortBy = strSortBy
                .ClientSideSortFunctionName = "" '"RelatedData_Sort_OnClick" ' without param. and brackets
                .returnHTML = True '| true
                .UseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
 			If GridSQL.ToUpper.Trim = DataGrid.GridSQL.ToUpper.Trim Then 'Added By Shrikant on 20 June 08 IssueID 20608
                    .GridDataTable = dtGrid 'Added By Shrikant  On 20-June-2008 for SRID: 287 and IssueID: 16575
                End If
                If blnCancelGrid = False Then strGRID = m_objGrid.DrawGrid() ' Called from within the section below
            End With
            m_objGrid = Nothing
            CommonFunction.General.WriteHTML(strGRID)

            ' ***************************************************************************************
            ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
            ' ***************************************************************************************
        End If
        ' ***************************************************************************************
        ' End Adddition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
        ' ***************************************************************************************
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        ExtensionArgs.m_RelatedDataGrid = DataGrid
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                "After_PlotRelatedDataGrid", ExtensionArgs)

        DataGrid = ExtensionArgs.m_RelatedDataGrid

        m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey
        m_objGlobal = ExtensionArgs.m_global
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call the Before Print event for the Grid
        'Code Modified:RajeshB          19 Jan 2005
        ' Purpose:Wrap the event call into a function
        'Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataGrid(DataGrid, m_objGlobal, m_cObjCPSQL.PrimaryKey)
        Call After_PlotRelatedDataGrid(DataGrid, m_objGlobal, m_cObjCPSQL.PrimaryKey)
        DataGrid = Nothing

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub


    Private Function RelatedData_GetAlignment(ByVal strDataType As String) As String
        '=====================================================================
        ' Procedure Name        :	RelatedData_GetAlignment
        ' Purpose               :	Determine the Column Alignment for the Datatype
        ' Description           :	Same as above
        ' Parameters Passed     :	DataType.
        ' Parameters Affected   :	None.
        ' Returns               :	Alignment
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003 
        ' Revisions             :
        '=====================================================================
        RelatedData_GetAlignment = "Left"
        Select Case strDataType.Trim.ToUpper
            Case "FLOAT", "INT", "DECIMAL", "NUMERIC", "SMALLMONEY", "BIGINT", "REAL", "MONEY", "TINYINT", "SMALLINT"
                'number are align right
                RelatedData_GetAlignment = "Right"
            Case "DATETIME", "BIT", "CHAR", "NCHAR", "SMALLDATETIME", "TIMESTAMP"
                'date..bit..align center
                RelatedData_GetAlignment = "Center"
            Case Else
                'Includes --> "VARCHAR" ,"NVARCHAR"  ,"IMAGE" ,"TEXT" ,"UNIQUEIDENTIFIER" ,"SQL_VARIANT" ,"NTEXT" ,"VARBINARY" ,"BINARY"  ,"SYSNAME"
                RelatedData_GetAlignment = "Left"
        End Select
    End Function

    Private Sub SubTag_PlotRelatedData()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotRelatedData
        ' Purpose               :	Plot the section for Sub Tag Related Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 10, 2004
        ' Revisions             :
        '=====================================================================
        'Create Hash Table object for Related Data
        Dim objDataHashTable() As CommonEngines.HashTables.SubTagUIInformation
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Same Culture ID as default
            objDataHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIRelatedDataObject(m_objGlobal.TagID)
        Else
            'Culture ID is different 
            objDataHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIRelatedDataObject(m_objGlobal.TagID.ToString + m_objGlobal.LCID.ToString)
            If objDataHashTable Is Nothing Then
                'Culture not supported ...use default
                objDataHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIRelatedDataObject(m_objGlobal.TagID)
            End If
        End If

        If objDataHashTable Is Nothing Then
            Return
        End If

        Dim intIndex As Integer
        Dim intLastIndex As Integer = objDataHashTable.Length - 1
        For intIndex = 0 To intLastIndex

            If objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_UI.ToString Or objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_BOTH.ToString Then

                Dim RelatedDataDivID As String = "SubRelatedData_DivList" + intIndex.ToString

                'Data Header
                Dim objHeader As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
                Dim blnCancelHeader As Boolean = False
                objHeader = PrepareRelatedDataHeaderObject(objDataHashTable(intIndex).DataHeader.Trim, objDataHashTable(intIndex).DataHeaderAlignment.Trim, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).UniqueID)

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' set the condition clause of the object
                objHeader.ConditionClause = objDataHashTable(intIndex).ConditionClause
                'Added By UmeshJ Aug 03, 2007
                objHeader.ConditionClause = ReplacePlaceHolders(objHeader.ConditionClause, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)
                'End of Addition
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                ExtensionArgs.Cancel = blnCancelHeader
                ExtensionArgs.m_RelatedDataHeader = objHeader
                ExtensionArgs.m_global = m_objSubTagGlobal
                ExtensionArgs.PrimaryKey = ""

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                        "Before_PlotRelatedDataHeader", ExtensionArgs)

                objHeader = ExtensionArgs.m_RelatedDataHeader
                blnCancelHeader = ExtensionArgs.Cancel
                m_objSubTagGlobal = ExtensionArgs.m_global
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************
                'Call the Before Print Event for Related Data Header
                'Code Modified:RajeshB          19 Jan 2005
                ' Purpose:Wrap the event call into a function
                ' Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, "")
                Call Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, "")
                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************

                ' Check the condition to plot the related data info.
                Dim dr As IDataReader
                Dim blnPlotHeader As Boolean = True

                If Trim(objHeader.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(objHeader.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================
                    If dr.Read Then
                        blnPlotHeader = True
                    Else
                        blnPlotHeader = False
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If

                ' Plot the header only when there are some rows returned by execution of the condition clause sql
                If blnPlotHeader Then
                    If blnCancelHeader = False Then Call RelatedData_Header(objHeader.DataHeader, objHeader.DataHeaderAlignment)
                End If
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                '***************************************************************************************
                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                ExtensionArgs.m_RelatedDataHeader = objHeader
                ExtensionArgs.m_global = m_objGlobal
                ExtensionArgs.PrimaryKey = ""

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                        "After_PlotRelatedDataHeader", ExtensionArgs)

                objHeader = ExtensionArgs.m_RelatedDataHeader
                m_objGlobal = ExtensionArgs.m_global
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************

                'Call the After Print Event for Related Data Header
                'Code Modified:RajeshB          19 Jan 2005
                ' Purpose:Wrap the event call into a function
                'Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataHeader(objHeader, m_objGlobal, "")
                Call After_PlotRelatedDataHeader(objHeader, m_objGlobal, "")
                'Addition Ends
                objHeader = Nothing

                'Related Data Grid
                ' ***************************************************************************************
                ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                Dim gridSQL As String = ReplacePlaceHolders(objDataHashTable(intIndex).DataGridSQL, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)
                ' Passing the condition clause to the routine to plot grid
                Call RelatedData_Grid(gridSQL, RelatedDataDivID, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).UniqueID, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).ConditionClause, Not (objDataHashTable(intIndex).VerticalDisplay), objDataHashTable(intIndex).DisplayPosition)
                ' ***************************************************************************************
                ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                'Separator HTML Tag
                If intIndex < intLastIndex Then Response.Write(CommonFunction.General.CheckIsNothing(objDataHashTable(intIndex).SeperatorHTMLTag))
            End If
        Next
        'Destroy the object
        objDataHashTable = Nothing

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    Protected Overridable Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataGrid(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotRelatedDataGrid(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataGrid(Args, WhizGlobal, "")
    End Sub
    Private Sub SubTag_RelatedData_Grid(ByVal GridSQL As String, ByVal RelatedDataDivID As String, ByVal OrderNumber As Long, ByVal UniqueID As Long, ByVal QRBQueryID As Long, ByVal ConditionClause As String, Optional ByVal VerticalDisplay As Boolean = True)
        '=====================================================================
        ' Procedure Name        :	SubTag_RelatedData_Grid
        ' Purpose               :	Plot Related Data Grid for Sub Tag
        ' Description           :	Same as above
        ' Parameters Passed     :	GridSQL - SQL to plot the grid
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 10, 2004
        ' Revisions             :   
        '=====================================================================

    End Sub

#End Region

#Region "GRAPH"
    Private Sub PlotGraphs()
        '=====================================================================
        ' Procedure Name        :	PlotGraphs
        ' Purpose               :	Plot the section : Graphs
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	December 03, 2003 
        ' Revisions             :
        '=====================================================================
        'Create Hash Table object for graph
        Dim objGraphHashTable() As CommonEngines.HashTables.UIGraphs
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Same Culture ID as default
            objGraphHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIGraphObject(m_objGlobal.TagID)
        Else
            'Culture ID is different 
            objGraphHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIGraphObject(m_objGlobal.TagID + m_objGlobal.LCID)
            If objGraphHashTable Is Nothing Then
                'Culture not supported ...use default
                objGraphHashTable = CommonEngines.HashTables.GetUIInformationHashTableObjects.GetHashTableUIGraphObject(m_objGlobal.TagID)
            End If
        End If

        'Sorry..object is not supported
        If objGraphHashTable Is Nothing Then
            Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_GRAPH)
            Return
        End If
        Dim intIndex As Integer
        Dim intLastIndex As Integer = objGraphHashTable.Length - 1
        Dim objGraph As Graph.Graph 'Modified By PushkarK On 03-Oct-2007
        Dim strVirtualImgPath As String = ""
        Dim strImageFileName As String = ""
        Dim intRowGraphCnt As Integer = 0
        'Modified by PrasannaP on 30th May 2005
        'Issue ID: 28888
        'CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0>")
        CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0 width='99.9%'>")
        'End Modification
        CommonFunction.General.WriteHTML("<TR><TD")
        For intIndex = 0 To intLastIndex
            If objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_UI.ToString Or objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_BOTH.ToString Then
                'Plot graph on same row or next row
                'If intIndex > 0 Then
                If (intRowGraphCnt Mod 2 = 0) Then
                    intRowGraphCnt = 1
                    If intIndex > 0 Then CommonFunction.General.WriteHTML("</TD></TR><TR><TD")

                    If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                        CommonFunction.General.WriteHTML(" colspan=2 ")
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                Else
                    If objGraphHashTable(intIndex - 1).WidthInPixel > 500 Then
                        'Next Line
                        CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                            intRowGraphCnt = 2
                        Else
                            intRowGraphCnt = 1
                        End If
                    Else
                        'Same line
                        CommonFunction.General.WriteHTML("</TD><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Then
                            CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                        End If
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                End If
                'End If
                'Modified By NileshD on 9 Jan 2006
                'Added more elements in the array.
                Dim arrType As String() = {objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type}
                'Image Path
                strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName
                strVirtualImgPath = CommonFunction.Constants.CLCP_IMAGES_FOLDER_PATH + "/" + strImageFileName
                Dim ChartAreaGradientStyle As String
                Dim PieChartLabelStyle As String
                If objGraphHashTable(intIndex).Type.ToUpper = "PIE" Then
                    ChartAreaGradientStyle = "Center"
                    PieChartLabelStyle = objGraphHashTable(intIndex).PiChartLabelStyle
                Else
                    ChartAreaGradientStyle = "TopBottom"
                    PieChartLabelStyle = ""
                End If

                Dim blnCancelGraph As Boolean = False
                Dim oGraph As EventHandlers.WAF_Graph
                oGraph = PrepareGraphObject(arrType, ReplacePlaceHolders(objGraphHashTable(intIndex).StoredProcedure, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal), strVirtualImgPath, _
                    Server.MapPath(strVirtualImgPath), m_strConnectionString, "white", objGraphHashTable(intIndex).BorderStyle, objGraphHashTable(intIndex).ChartAreaColor, _
                    objGraphHashTable(intIndex).ChartBackColor, objGraphHashTable(intIndex).Enable3D, "white", objGraphHashTable(intIndex).BorderColor, "white", "TopBottom", "TopBottom", _
                    ChartAreaGradientStyle, PieChartLabelStyle, objGraphHashTable(intIndex).Title, New System.Drawing.Font(objGraphHashTable(intIndex).GraphTitleFont, 9, System.Drawing.FontStyle.Bold), "black", _
                    CType(objGraphHashTable(intIndex).WidthInPixel, Integer), CType(objGraphHashTable(intIndex).HeightInPixel, Integer), objGraphHashTable(intIndex).LegendCaptionColor, _
                    New System.Drawing.Font(objGraphHashTable(intIndex).LegendFont, 9, System.Drawing.FontStyle.Bold), "excel", objGraphHashTable(intIndex).ShowExplodedPiChart, objGraphHashTable(intIndex).ShowLegends, objGraphHashTable(intIndex).DisplayPosition)

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                oGraph.ConditionClause = ReplacePlaceHolders(objGraphHashTable(intIndex).ConditionClause, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************

                'Call Before plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Graph.Before_PlotGraph(blnCancelGraph, oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                Call Before_PlotGraph(blnCancelGraph, oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                ' Check the condition to plot the graph.
                Dim dr As IDataReader
                Dim blnPlotGraph As Boolean = True

                If Trim(oGraph.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(oGraph.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), oGraph.ConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================
                    If dr.Read Then
                        blnPlotGraph = True
                    Else
                        blnPlotGraph = False
                    End If
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If

                ' Plot the grpah only when there are some rows returned by executin of the condition clause sql
                If blnPlotGraph Then
                    ' ***************************************************************************************
                    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                    ' ***************************************************************************************
                    objGraph = New Graph.Graph 'Added By PushkarK On 03-Oct-2007
                    With objGraph
                        'Main properties
                        ''==========================================================================================================
                        ''Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                        '.ExternalDBConnectionString = m_strConnectionString
                        '.ExternalDBUseSQL = True
                        '' Addition End By : Ninad   Req Id : WAF3_PB_33
                        ''==========================================================================================================
                        .ChartType = oGraph.ChartType
                        .SQL = oGraph.SQL
                        .VirtualImagePath = oGraph.VirtualImagePath
                        .AbsoluteImagePath = oGraph.AbsoluteImagePath
                        .ConnectionString = oGraph.ConnectionString
                        .LegendBackColor = "white"
                        'Other Properties
                        .BorderColor = oGraph.BorderColor
                        .BorderStyle = oGraph.BorderStyle
                        .ChartAreaColor = oGraph.ChartAreaColor
                        .ChartBackColor = oGraph.ChartBackColor
                        .Enable3D = oGraph.Enable3D
                        .ChartAreaGradientColor = oGraph.ChartAreaGradientColor
                        .BorderGradientColor = oGraph.BorderGradientColor
                        .ChartBackGradientColor = oGraph.ChartBackGradientColor
                        .ChartBackGradientStyle = oGraph.ChartBackGradientStyle
                        .BorderGradientStyle = oGraph.BorderGradientStyle
                        .ChartAreaGradientStyle = oGraph.ChartAreaGradientStyle
                        .PieChartLabelStyle = oGraph.PieChartLabelStyle
                        'Title Properties
                        .GraphTitle = oGraph.GraphTitle
                        .TitleFont = oGraph.TitleFont
                        .GraphTitleColor = oGraph.GraphTitleColor
                        .Width = oGraph.Width
                        .Height = oGraph.Height
                        .LegendCaptionColor = oGraph.LegendCaptionColor
                        .LegendFont = oGraph.LegendFont
                        .PalleteStyle = oGraph.PalletStyle
                        .ShowExplodedPie = oGraph.ShowExplodedPie
                        .ShowLegends = oGraph.ShowLegends
                        .EnableSmartLabels = oGraph.EnableSmartLabels
                        .ShowCaptions = oGraph.ShowCaptions
                        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
                        .XAxisInterval = 1
                        If blnCancelGraph = False Then
                            If oGraph.ChartType(0).ToUpper = "STACKEDBAR" Or oGraph.ChartType(0).ToUpper = "STACKEDCOLUMN" Then
                                .GenerateStackedGraphImage()
                            Else
                                .GenerateImage()
                            End If
                        End If
                    End With
                    If blnCancelGraph = False Then CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawImage(strVirtualImgPath + ".png", , , , , , , True))
                    objGraph.Dispose() : objGraph = Nothing 'Added By PushkarK On 03-Oct-2007
                    ' ***************************************************************************************
                    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                    ' ***************************************************************************************
                End If
                ' ***************************************************************************************
                ' End Adddition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                'Call After plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Graph.After_PlotGraph(oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                Call After_PlotGraph(oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            End If
        Next
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        'Destroy the object
        objGraph = Nothing
        objGraphHashTable = Nothing
    End Sub

    Protected Overridable Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Graph.Before_PlotGraph(Cancel, Args, WhizGlobal, "")
    End Sub
    Protected Overridable Sub After_PlotGraph(ByVal Args As EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_Graph.After_PlotGraph(Args, WhizGlobal, "")
    End Sub
    Private Function PrepareGraphObject(ByVal ChartType As String(), ByVal SQL As String, ByVal VirtualImagePath As String, ByVal AbsoluteImagePath As String, ByVal ConnectionString As String, ByVal BorderColor As String, ByVal BorderStyle As String, ByVal ChartAreaColor As String, ByVal ChartBackColor As String, ByVal Enable3D As Boolean, ByVal ChartAreaGradientColor As String, ByVal BorderGradientColor As String, ByVal ChartBackGradientColor As String, ByVal ChartBackGradientStyle As String, ByVal BorderGradientStyle As String, ByVal ChartAreaGradientStyle As String, ByVal PieChartLabelStyle As String, ByVal GraphTitle As String, ByVal TitleFont As System.Drawing.Font, ByVal GraphTitleColor As String, ByVal Width As Integer, ByVal Height As Integer, ByVal LegendCaptionColor As String, ByVal LegendFont As System.Drawing.Font, ByVal PalletStyle As String, ByVal ShowExplodedPie As Boolean, ByVal ShowLegends As Boolean, ByVal DisplayPosition As String) As EventHandlers.WAF_Graph
        '=====================================================================
        ' Procedure Name        :	PrepareGraphObject
        ' Purpose               :	Prepare Graph Object for Events
        ' Description           :	Same as above
        ' Parameters Passed     :	
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	Feb 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim objGraph As EventHandlers.WAF_Graph
        With objGraph
            .AbsoluteImagePath = AbsoluteImagePath
            .BorderColor = BorderColor
            .BorderGradientColor = BorderGradientColor
            .BorderGradientStyle = BorderGradientStyle
            .BorderStyle = BorderStyle
            .ChartAreaColor = ChartAreaColor
            .ChartAreaGradientColor = ChartAreaGradientColor
            .ChartAreaGradientStyle = ChartAreaGradientStyle
            .ChartBackColor = ChartBackColor
            .ChartBackGradientColor = ChartBackGradientColor
            .ChartBackGradientStyle = ChartBackGradientStyle
            .ChartType = ChartType
            .ConnectionString = ConnectionString
            .Enable3D = Enable3D
            .GraphTitle = GraphTitle
            .GraphTitleColor = GraphTitleColor
            .Height = Height
            .LegendCaptionColor = LegendCaptionColor
            .LegendFont = LegendFont
            .PalletStyle = PalletStyle
            .PieChartLabelStyle = PieChartLabelStyle
            .ShowExplodedPie = ShowExplodedPie
            .ShowLegends = ShowLegends
            .SQL = SQL
            .TitleFont = TitleFont
            .VirtualImagePath = VirtualImagePath
            .Width = Width
            .EnableSmartLabels = True
            .ShowCaptions = True
            .DisplayPosition = DisplayPosition
        End With
        PrepareGraphObject = objGraph
    End Function
    Private Sub SubTag_PlotGraph()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotGraph
        ' Purpose               :	Plot Graphs for the Sub Tag UI
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 10, 2004
        ' Revisions             :
        '=====================================================================
        'Create Hash Table object for graph
        Dim objGraphHashTable() As CommonEngines.HashTables.SubTagUIGraphs
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Same Culture ID as default
            objGraphHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIGraphObject(m_objGlobal.TagID)
        Else
            'Culture ID is different 
            objGraphHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIGraphObject(m_objGlobal.TagID + m_objGlobal.LCID)
            If objGraphHashTable Is Nothing Then
                'Culture not supported ...use default
                objGraphHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIGraphObject(m_objGlobal.TagID)
            End If
        End If

        'Sorry..object is not supported
        If objGraphHashTable Is Nothing Then
            Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_GRAPH)
            Return
        End If
        Dim intIndex As Integer
        Dim intLastIndex As Integer = objGraphHashTable.Length - 1
        Dim objGraph As Graph.Graph 'Modified By PushkarK On 03-Oct-2007
        Dim strVirtualImgPath As String = ""
        Dim strImageFileName As String = ""
        Dim intRowGraphCnt As Integer = 0
        'Modified by PrasannaP on 30th May 2005
        'Issue ID: 18888
        CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0 width='99.9%'>")
        'CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0>")
        'End Modification
        CommonFunction.General.WriteHTML("<TR><TD")
        For intIndex = 0 To intLastIndex
            'Graphs for UI Only
            If objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_UI.ToString Or objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_BOTH.ToString Then
                'Plot graph on same row or next row
                'If intIndex > 0 Then
                If (intRowGraphCnt Mod 2 = 0) Then
                    intRowGraphCnt = 1
                    If intIndex > 0 Then CommonFunction.General.WriteHTML("</TD></TR><TR><TD")

                    If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                        CommonFunction.General.WriteHTML(" colspan=2 ")
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                Else
                    If objGraphHashTable(intIndex - 1).WidthInPixel > 500 Then
                        'Next Line
                        CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                            intRowGraphCnt = 2
                        Else
                            intRowGraphCnt = 1
                        End If
                    Else
                        'Same line
                        CommonFunction.General.WriteHTML("</TD><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Then
                            CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                        End If
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                End If
                'End If
                Dim arrType As String() = {objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type}
                'Image Path
                strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName
                strVirtualImgPath = CommonFunction.Constants.CLCP_IMAGES_FOLDER_PATH + "/" + strImageFileName
                Dim ChartAreaGradientStyle As String
                Dim PieChartLabelStyle As String
                If objGraphHashTable(intIndex).Type.ToUpper = "PIE" Then
                    ChartAreaGradientStyle = "Center"
                    PieChartLabelStyle = objGraphHashTable(intIndex).PiChartLabelStyle
                Else
                    ChartAreaGradientStyle = "TopBottom"
                    PieChartLabelStyle = ""
                End If

                Dim blnCancelGraph As Boolean = False
                Dim oGraph As EventHandlers.WAF_Graph
                oGraph = PrepareGraphObject(arrType, ReplacePlaceHolders(objGraphHashTable(intIndex).StoredProcedure, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal), strVirtualImgPath, _
                    Server.MapPath(strVirtualImgPath), m_strConnectionString, "white", objGraphHashTable(intIndex).BorderStyle, objGraphHashTable(intIndex).ChartAreaColor, _
                    objGraphHashTable(intIndex).ChartBackColor, objGraphHashTable(intIndex).Enable3D, "white", objGraphHashTable(intIndex).BorderColor, "white", "TopBottom", "TopBottom", _
                    ChartAreaGradientStyle, PieChartLabelStyle, objGraphHashTable(intIndex).Title, New System.Drawing.Font(objGraphHashTable(intIndex).GraphTitleFont, 9, System.Drawing.FontStyle.Bold), "black", _
                    CType(objGraphHashTable(intIndex).WidthInPixel, Integer), CType(objGraphHashTable(intIndex).HeightInPixel, Integer), objGraphHashTable(intIndex).LegendCaptionColor, _
                    New System.Drawing.Font(objGraphHashTable(intIndex).LegendFont, 9, System.Drawing.FontStyle.Bold), "excel", objGraphHashTable(intIndex).ShowExplodedPiChart, objGraphHashTable(intIndex).ShowLegends, objGraphHashTable(intIndex).DisplayPosition)

                oGraph.ConditionClause = ReplacePlaceHolders(objGraphHashTable(intIndex).ConditionClause, m_cObjCPSQL.PrimaryKeyValue, m_objGlobal)

                'Call Before plot graph event
                'Call After plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Graph.Before_PlotGraph(blnCancelGraph, oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                Call Before_PlotGraph(blnCancelGraph, oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                'Modification Ends
                ' Check the condition to plot the graph.
                Dim dr As IDataReader
                Dim blnPlotGraph As Boolean = True

                If Trim(oGraph.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(oGraph.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), oGraph.ConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================
                    blnPlotGraph = dr.Read
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If

                ' Plot the grpah only when there are some rows returned by executin of the condition clause sql
                If blnPlotGraph Then
                    objGraph = New Graph.Graph 'Added By PushkarK On 03-Oct-2007
                    With objGraph
                        'Main properties
                        ''==========================================================================================================
                        ''Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                        '.ExternalDBConnectionString = m_strConnectionString
                        '.ExternalDBUseSQL = True
                        '' Addition End By : Ninad   Req Id : WAF3_PB_33
                        ''==========================================================================================================
                        .ChartType = oGraph.ChartType
                        .SQL = oGraph.SQL
                        .VirtualImagePath = oGraph.VirtualImagePath
                        .AbsoluteImagePath = oGraph.AbsoluteImagePath
                        .ConnectionString = oGraph.ConnectionString
                        .LegendBackColor = "white"
                        'Other Properties
                        .BorderColor = oGraph.BorderColor
                        .BorderStyle = oGraph.BorderStyle
                        .ChartAreaColor = oGraph.ChartAreaColor
                        .ChartBackColor = oGraph.ChartBackColor
                        .Enable3D = oGraph.Enable3D
                        .ChartAreaGradientColor = oGraph.ChartAreaGradientColor
                        .BorderGradientColor = oGraph.BorderGradientColor
                        .ChartBackGradientColor = oGraph.ChartBackGradientColor
                        .ChartBackGradientStyle = oGraph.ChartBackGradientStyle
                        .BorderGradientStyle = oGraph.BorderGradientStyle
                        .ChartAreaGradientStyle = oGraph.ChartAreaGradientStyle
                        .PieChartLabelStyle = oGraph.PieChartLabelStyle
                        'Title Properties
                        .GraphTitle = oGraph.GraphTitle
                        .TitleFont = oGraph.TitleFont
                        .GraphTitleColor = oGraph.GraphTitleColor
                        .Width = oGraph.Width
                        .Height = oGraph.Height
                        .LegendCaptionColor = oGraph.LegendCaptionColor
                        .LegendFont = oGraph.LegendFont
                        .PalleteStyle = oGraph.PalletStyle
                        .ShowExplodedPie = oGraph.ShowExplodedPie
                        .ShowLegends = oGraph.ShowLegends
                        .EnableSmartLabels = oGraph.EnableSmartLabels
                        .ShowCaptions = oGraph.ShowCaptions
                        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
                        .XAxisInterval = 1
                        If blnCancelGraph = False Then
                            If oGraph.ChartType(0).ToUpper = "STACKEDBAR" Or oGraph.ChartType(0).ToUpper = "STACKEDCOLUMN" Then
                                .GenerateStackedGraphImage()
                            Else
                                .GenerateImage()
                            End If
                        End If
                    End With
                    If blnCancelGraph = False Then CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawImage(strVirtualImgPath + ".png", , , , , , , True))
                    objGraph.Dispose() : objGraph = Nothing 'Added By PushkarK On 03-Oct-2007
                End If
                'Call After plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Graph.After_PlotGraph(oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
                Call After_PlotGraph(oGraph, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            End If
        Next
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        'Destroy the object
        objGraph = Nothing
        objGraphHashTable = Nothing
    End Sub
#End Region

    '###################################################################################################
    '____________________________ADDED BY UMESHJ ON 5 NOV 2004....PLOT SUB TAG GRAPH AND RELATED DATA ON LIST
    '###################################################################################################
#Region "PLOT SUB TAG LIST SECTIONS"
    Private Sub SubTag_PlotSections()
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotSections
        ' Purpose               :	This function is used to plot the Sub Tag List Sections
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 29, 2003 
        ' Revisions             :
        '=====================================================================
        Dim sbClientsideScript As New System.Text.StringBuilder("")
        Dim sbExpandSections As New System.Text.StringBuilder(vbCrLf + " function " + SUBTAG_FUNCTION_NAME_EXPAND_SECTION + "() { ")
        Dim intLength As Integer
        Dim intIndex As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        Dim intNoOfActiveSections As Integer = 0

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        'Sub Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_lngSubTagID, String) + "-1")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(m_lngSubTagID.ToString & CType(m_objGlobal.LCID, String) + "-1")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_lngSubTagID, String) + "-1")
            End If
        End If
        If objSection Is Nothing Then Return
        intLength = objSection.Length - 1
        'HttpContext.Current.Response.Write("<DIV Id=" + DIV_TAG + " Style=" & Chr(34) + "HEIGHT:400px;OVERFLOW:auto; WIDTH:100%" + Chr(34) + ">")

        'Get the Number of active sections
        For intIndex = 0 To intLength
            '_________##### Number of active LIST page sections
            If objSection(intIndex).IsActiveCL = True And objSection(intIndex).DisplayPosition <> CommonFunctions.Constants.SECTION_DISPLAY_POSITION_UI.ToString Then intNoOfActiveSections += 1
        Next

        For intIndex = 0 To intLength
            If objSection(intIndex).IsActiveCL = True Then '_________##### If it is a LIST page SECTION
                'If the Div Height is not specified in the div style then apply it from the
                'value specified in the Height property
                Dim lngDivHeight As Long
                Dim strDivStyle As String = "OVERFLOW:auto; WIDTH:100%;"
                Dim strSectionTag As String = "divSTSection" + objSection(intIndex).SectionID.ToString
                Dim strFunctionName As String = "showHide_" + strSectionTag

                Dim blnCancelSection As Boolean = False
                'Create object of the Section Structure
                Dim Section As EventHandlers.WAF_Section = PrepareSectionObject(objSection(intIndex).SectionID, objSection(intIndex).TagSectionID, objSection(intIndex).HeightCL, objSection(intIndex).OrderNumberCL, objSection(intIndex).IsActiveCL, objSection(intIndex).ShowSectionTitleCL, objSection(intIndex).SectionTitleCL, objSection(intIndex).SectionTitleAlignmentCL, strSectionTag, strFunctionName, CommonFunctions.Constants.SECTION_DISPLAY_POSITION_LIST)
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised
                Dim blnCheckEventCall As Boolean
                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "Before_PlotSection")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.PrimaryKey = ""
                    ExtensionArgs.m_Section = Section
                    ExtensionArgs.Cancel = blnCancelSection
                    ExtensionArgs.m_global = m_objSubTagGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "Before_PlotSection", ExtensionArgs)

                    blnCancelSection = ExtensionArgs.Cancel
                    Section = ExtensionArgs.m_Section
                    m_objSubTagGlobal = ExtensionArgs.m_global
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************

                    'Call the Before plot section event...pass the section structure by ref
                    'Code Modified:RajeshB              19 Jan 2005
                    ' Purpose: Wrap the call into an overridable function
                    'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSection(blnCancelSection, Section, m_objGlobal, "")
                    Call Before_PlotSection(blnCancelSection, Section, m_objSubTagGlobal, "")
                    'Modification Ends
                End If
                'addition ends.
                'If the only one section present then directly plot the grid
                If blnCancelSection = False And intNoOfActiveSections > 1 Then
                    sbExpandSections.Append(vbCrLf + Section.FunctionName + "(""none"");")
                    'For each Section - Plot Section Header
                    'Create object of the Section Structure for sectionTitle
                    Dim SectionTitle As EventHandlers.WAF_Section = PrepareSectionObject(Section.SectionID, Section.TagSectionID, Section.Height, Section.OrderNumber, Section.IsActive, Section.ShowSectionTitle, Section.SectionTitle, Section.SectionTitleAlignment, Section.DivSectionTag, Section.FunctionName, CommonFunctions.Constants.SECTION_DISPLAY_POSITION_LIST)
                    Dim blnCancelSectionTitle As Boolean = False
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised
                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSectionTitle")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.Cancel = blnCancelSectionTitle
                        ExtensionArgs.PrimaryKey = ""
                        ExtensionArgs.m_Section = SectionTitle
                        ExtensionArgs.m_global = m_objSubTagGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "Before_PlotSectionTitle", ExtensionArgs)

                        blnCancelSectionTitle = ExtensionArgs.Cancel
                        SectionTitle = ExtensionArgs.m_Section
                        m_objSubTagGlobal = ExtensionArgs.m_global
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************
                        'Call the Before plot sectionTitle event...pass the sectionTitle structure by ref
                        'Code Modified:RajeshB              19 Jan 2005
                        ' Purpose: Wrap the call into an overridable function
                        'Call CommonEngine.General.CLCP_Events_Sections.Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objGlobal, "")
                        Call Before_PlotSectionTitle(blnCancelSectionTitle, SectionTitle, m_objSubTagGlobal, "")
                        'Modification Ends
                    End If
                    'addition ends.
                    If blnCancelSectionTitle = False Then
                        ''Commented And Added By Chakshuta H on 30th-Oct-2015 
                        ''sbClientsideScript.Append(SubTag_PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False)) 'Request ID: 198 'As the preferences for Sub Tag are not implemented properly - add new is displayed if section is hidden etc., the preferences links will not be shown for now Umesh 09-Feb-07
                        'Modified By ShrikantB On 15-NOV-2010 For Hide Header-Footer-SubTag Section Title
                        If (objSection(intIndex).SectionID = CommonFunction.Constants.SECTION_HEADER) Then
                            If (CommonFunction.General.GetFrameworkSettings("GEN_SHOW_HEADER_FOOTER_SUBTAG_SECTIONTITLE", "Enabled") = True) Then
                                sbClientsideScript.Append(SubTag_PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False)) 'Request ID: 198 'As the preferences for Sub Tag are not implemented properly - add new is displayed if section is hidden etc., the preferences links will not be shown for now Umesh 09-Feb-07
                            End If
                        Else
                            sbClientsideScript.Append(SubTag_PlotSectionTitle(SectionTitle.SectionTitle, SectionTitle.DivSectionTag, SectionTitle.FunctionName, SectionTitle.SectionTitleAlignment, SectionTitle.SectionID, False, False)) 'Request ID: 198 'As the preferences for Sub Tag are not implemented properly - add new is displayed if section is hidden etc., the preferences links will not be shown for now Umesh 09-Feb-07
                        End If
                        'Modification End By ShrikantB On 15-NOV-2010 For Hide Header-Footer-SubTag Section Title
                        ''End Of Commented And Added By Chakshuta H on 30th-Oct-2015 
                    End If
                    'Code Added:RajeshB	14 October, 2004
                    'Purpose: Check if event is to be raised

                    blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSectionTitle")
                    If blnCheckEventCall = True Then
                        ' WAF_PB_17
                        '*******************************************************************    
                        ' Code Added:RajeshB                    7th October, 2004
                        ' Purpose: Handle all applicable extensions.
                        '*******************************************************************
                        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                        ExtensionArgs.PrimaryKey = ""
                        ExtensionArgs.m_Section = SectionTitle
                        ExtensionArgs.m_global = m_objSubTagGlobal

                        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                        "After_PlotSectionTitle", ExtensionArgs)

                        blnCancelSection = ExtensionArgs.Cancel
                        SectionTitle = ExtensionArgs.m_Section
                        m_objSubTagGlobal = ExtensionArgs.m_global
                        '*******************************************************************    
                        ' Addition Ends - RajeshB
                        '******************************************************************

                        'Call after print event for Section Title
                        'Code Modified:RajeshB              19 Jan 2005
                        ' Purpose: Wrap the call into an overridable function
                        'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSectionTitle(SectionTitle, m_objGlobal, "")
                        Call After_PlotSectionTitle(SectionTitle, m_objSubTagGlobal, "")
                        'Modification Ends,
                    End If
                    'addition ends.
                    SectionTitle = Nothing
                End If

                'Show/Hide the section according to user preferences
                If blnCancelSection = False And SubTag_GetSectionPreferences(Section.SectionID) = 1 Then

                    lngDivHeight = Section.Height
                    If lngDivHeight <> 0 Then
                        strDivStyle += "HEIGHT:" & lngDivHeight.ToString.Trim & "px; "
                    End If
                    'UJ_05062006 Resolved issue of div mismatch
                    'HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")

                    '-------------------------------------------------------------------------------------------------------------
                    'Modified By - PushkarK On 15-May-2007 For Requirement ID - WAF3_PB_47
                    'Reason      - The DIV closing tag for subtag's grid should be and will be plotted in the cPlotGrids's
                    '              PlotGrid method. Hence commented the last line and included it in each case,
                    '              except the subtag's SECTION_HEADER 
                    '-------------------------------------------------------------------------------------------------------------
                    'Show the Section
                    Select Case Section.SectionID
                        Case CommonFunction.Constants.SECTION_HEADER
                            Call SubTag_PlotGrid()
                        Case CommonFunction.Constants.SECTION_GRAPH
                            'Plot graph section
                            HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                            Call SubTagLIST_PlotGraphs()
                            HttpContext.Current.Response.Write("</DIV>") 'WAF3_PB_47
                        Case CommonFunction.Constants.SECTION_RELATED_DATA
                            'Plot Related Data
                            HttpContext.Current.Response.Write("<DIV Id=" + Section.DivSectionTag + " Style=" & Chr(34) + strDivStyle + Chr(34) + ">")
                            Call SubTagLIST_PlotRelatedData()
                            HttpContext.Current.Response.Write("</DIV>") 'WAF3_PB_47
                    End Select
                    'HttpContext.Current.Response.Write("</DIV>") 'WAF3_PB_47
                    '-------------------------------------------------------------------------------------------------------------
                    'Modification Ends By - PushkarK On 15-May-2007 For Requirement ID - WAF3_PB_47
                    '-------------------------------------------------------------------------------------------------------------


                End If
                'Code Added:RajeshB	14 October, 2004
                'Purpose: Check if event is to be raised

                blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection")
                If blnCheckEventCall = True Then
                    ' WAF_PB_17
                    '*******************************************************************    
                    ' Code Added:RajeshB                    7th October, 2004
                    ' Purpose: Handle all applicable extensions.
                    '*******************************************************************
                    'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                    ExtensionArgs.PrimaryKey = ""
                    ExtensionArgs.m_Section = Section
                    ExtensionArgs.m_global = m_objSubTagGlobal

                    CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objSubTagGlobal.TagID, m_objSubTagGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                                    "After_PlotSection", ExtensionArgs)

                    Section = ExtensionArgs.m_Section
                    m_objSubTagGlobal = ExtensionArgs.m_global
                    '*******************************************************************    
                    ' Addition Ends - RajeshB
                    '******************************************************************
                    'After plotting the section call the After Print Event
                    'Code Modified:RajeshB              19 Jan 2005
                    ' Purpose: Wrap the call into an overridable function
                    'Call CommonEngine.General.CLCP_Events_Sections.After_PlotSection(Section, m_objGlobal, "")
                    Call After_PlotSection(Section, m_objSubTagGlobal, "")
                    'Modification Ends,
                End If
                'addition ends.
                Section = Nothing
            End If
        Next
        sbExpandSections.Append(vbCrLf + "}" + vbCrLf)
        'HttpContext.Current.Response.Write("</DIV>")
        m_strSubTagCLSectionClientsideScript = sbExpandSections.ToString + sbClientsideScript.ToString
        sbClientsideScript = Nothing
        sbExpandSections = Nothing
        objSection = Nothing

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub

    Private Function SubTag_PlotSectionTitle(ByVal strSectionTitle As String, ByVal divID_SectionTag As String, ByVal FunctionName As String, ByVal Alignment As String, ByVal SectionID As Long, Optional ByVal blnSaveUserPreferences As Boolean = True, Optional ByVal AllowHideShow As Boolean = True) As String
        '=====================================================================
        ' Procedure Name        :	SubTag_PlotSectionTitle
        ' Purpose               :	Plot the Sub Tag List Section Title
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        Dim strLeftSectionTitle As String
        Dim strRightSectionTitle As String
        Dim strMiddleSectionTitle As String
        'According to the Section Title Alignment set the Section Title as LEFT/RIGHT/CENTER
        Select Case Alignment.ToUpper
            Case "LEFT" : strLeftSectionTitle = strSectionTitle
            Case "RIGHT" : strRightSectionTitle = strSectionTitle
            Case "CENTER" : strMiddleSectionTitle = strSectionTitle
            Case Else : strLeftSectionTitle = strSectionTitle
        End Select
        'Create object of the Section Title class from the Templates
        m_cObjSectionTitle = New WebPage.Templates.SectionTitle

        With m_cObjSectionTitle
            If blnSaveUserPreferences = False Then
                Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, , , , , , , AllowHideShow))
                SubTag_PlotSectionTitle = .ClientsideScript
            Else
                If SubTag_GetSectionPreferences(SectionID) = 1 Then
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, , , , , , True))
                Else
                    Response.Write(.GetSectionTitle(strLeftSectionTitle, divID_SectionTag, FunctionName, , strRightSectionTitle, strMiddleSectionTitle, "../../Images/plus.gif", , , , , True))
                End If
                SubTag_PlotSectionTitle = SubTag_WriteClientsideScript_SectionShowHide(SectionID, FunctionName)
            End If
        End With
        'Destroy the object
        m_cObjSectionTitle = Nothing
    End Function

    Private Function SubTag_GetSectionPreferences(ByVal lngSectionID As Long) As Byte
        '=====================================================================
        ' Procedure Name        :	SubTag_GetSectionPreferences
        ' Purpose               :	Get Sub Tag Section Preferences
        ' Description           :	Same as above
        ' Parameters Passed     :	lngSectionID - section ID
        ' Parameters Affected   :	None.
        ' Returns               :	User Preferences for the section(0-hide,1-show)
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	October 12, 2003
        ' Revisions             :
        '=====================================================================
        SubTag_GetSectionPreferences = 0
        Dim intIndex As Integer
        Dim intLength As Integer
        Dim objSection() As CommonEngines.HashTables.UITagSections
        'Details.............>TAB
        'Tag Sections
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            'Local culture ID is same as the default culture id
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_lngSubTagID, String) + "-1")
        Else
            'Culture ID is other than the default culture id
            'Check if the Culture is supported by the system
            objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(m_lngSubTagID.ToString & CType(m_objGlobal.LCID, String) + "-1")
            If objSection Is Nothing Then
                'No. Culture is NOT supported. Retrieve the data from the defualt culture 
                objSection = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagSectionObject(CType(m_lngSubTagID, String) + "-1")
            End If
        End If
        If objSection Is Nothing Then Return 0
        intLength = objSection.Length - 1
        For intIndex = 0 To intLength
            If objSection(intIndex).SectionID = lngSectionID And objSection(intIndex).IsActiveCL = True Then
                Select Case lngSectionID
                    Case CommonFunction.Constants.SECTION_HEADER
                        SubTag_GetSectionPreferences = m_objSubTagCLSQL.SectionPreferences(0)
                        Exit For
                    Case CommonFunction.Constants.SECTION_GRAPH
                        SubTag_GetSectionPreferences = m_objSubTagCLSQL.SectionPreferences(2)
                        Exit For
                    Case CommonFunction.Constants.SECTION_RELATED_DATA
                        SubTag_GetSectionPreferences = m_objSubTagCLSQL.SectionPreferences(3)
                        Exit For
                End Select
            End If
        Next
        'Destroy the object
        objSection = Nothing

    End Function

    Private Function SubTag_WriteClientsideScript_SectionShowHide(ByVal lngSectionID As Long, ByVal functionName As String) As String
        '=====================================================================
        ' Procedure Name        :	SubTag_WriteClientsideScript_SectionShowHide
        ' Purpose               :	Write Clientside Script for section hide show
        ' Description           :	Same as above
        ' Parameters Passed     :	SectionID and functionName
        ' Parameters Affected   :	None.
        ' Returns               :	WriteClientsideScript for SectionShowHide
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	UmeshJ
        ' Created               :	November 26, 2003
        ' Revisions             :
        '=====================================================================
        Dim bytValue As Byte = 0
        Dim sbSection As New System.Text.StringBuilder(vbCrLf + " function " + functionName + "() {")
        'Get the User Preference for the section
        bytValue = SubTag_GetSectionPreferences(lngSectionID)
        'If the previous section preference is show then new section preference will be hide
        If bytValue = 1 Then
            bytValue = 0
        Else
            bytValue = 1
        End If
        'Prepare action accordingly
        If m_strCommonQueryString.Trim = "" Then
            sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strFormPage & "?FocusOn=SUBTAG&Operation=SHOW_HIDE&TABListSectionID=" + lngSectionID.ToString + "&TABListSectionIDValue=" + bytValue.ToString & Chr(34))
            'sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strFormPage & "?FocusOn=SUBTAG&Operation=SHOW_HIDE&TABListSectionID=" + lngSectionID.ToString + "&TABListSectionIDValue=" + bytValue.ToString + "&SubTagID=" & m_lngCurrentSubTagID & Chr(34))
        Else
            sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strFormPage & "?FocusOn=SUBTAG&Operation=SHOW_HIDE&TABListSectionID=" + lngSectionID.ToString + "&TABListSectionIDValue=" + bytValue.ToString + "&" & m_strCommonQueryString & Chr(34))
            'sbSection.Append(vbCrLf & "objfrm.action=" & Chr(34) & "" & strFormPage & "?FocusOn=SUBTAG&Operation=SHOW_HIDE&TABListSectionID=" + lngSectionID.ToString + "&TABListSectionIDValue=" + bytValue.ToString + "&" & m_strCommonQueryString + "&SubTagID=" & m_lngCurrentSubTagID & Chr(34))
        End If
        sbSection.Append(vbCrLf & "objfrm.submit()" & vbCrLf)
        sbSection.Append(vbCrLf + "}")
        SubTag_WriteClientsideScript_SectionShowHide = sbSection.ToString
        sbSection = Nothing
    End Function
    '###################################################################################################
    '____________________________END OF ADDITION 
    '###################################################################################################


    ' **************************************************************************
    ' Added Nov 06,2004 Rajanikant Khethawatt R.No. WAF2_PB_41, WAF2_PB_42
    ' **************************************************************************
    Private Sub SubTagLIST_PlotGraphs()
        '=====================================================================
        ' Procedure Name        :	SubTagLIST_PlotGraphs
        ' Purpose               :	Plot the section : Graphs
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Umesh Joshi/Rajanikant Khethawatt
        ' Created               :	November 06, 2004 
        ' Revisions             :
        '=====================================================================
        Dim objGraphHashTable() As CommonEngines.HashTables.SubTagUIGraphs

        ' get hash table object here
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            objGraphHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIGraphObject(m_lngSubTagID)
        Else
            objGraphHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIGraphObject(m_lngSubTagID.ToString + m_objGlobal.LCID.ToString)
            If objGraphHashTable Is Nothing Then
                objGraphHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIGraphObject(m_lngSubTagID)
            End If
        End If

        ' check valid hash table object
        If objGraphHashTable Is Nothing Then
            Call WriteNoItemsToShow(CommonFunction.Constants.SECTION_GRAPH)
            Return
        End If

        Dim intIndex As Integer
        Dim intLastIndex As Integer = objGraphHashTable.Length - 1
        Dim objGraph As Graph.Graph 'Modified By PushkarK On 03-Oct-2007
        Dim strVirtualImgPath As String = ""
        Dim strImageFileName As String = ""
        Dim intRowGraphCnt As Integer = 0

        'Modified by PrasannaP on 30th May 2005
        'Issue ID: 18888
        'CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0>")
        CommonFunction.General.WriteHTML("<Table class=clsTable cellspacing=1 cellpadding=0 border=0 width='99.9%'>")
        'End Modification
        CommonFunction.General.WriteHTML("<TR><TD")
        For intIndex = 0 To intLastIndex
            If objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_LIST.ToString Or objGraphHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_GRAPH_DISPLAYPOSITION_BOTH.ToString Then
                'Plot graph on same row or next row
                If (intRowGraphCnt Mod 2 = 0) Then
                    intRowGraphCnt = 1
                    If intIndex > 0 Then CommonFunction.General.WriteHTML("</TD></TR><TR><TD")

                    If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                        CommonFunction.General.WriteHTML(" colspan=2 ")
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                Else
                    If objGraphHashTable(intIndex - 1).WidthInPixel > 500 Then
                        'Next Line
                        CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Or intIndex = intLastIndex Then
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                            intRowGraphCnt = 2
                        Else
                            intRowGraphCnt = 1
                        End If
                    Else
                        'Same line
                        CommonFunction.General.WriteHTML("</TD><TD")
                        If objGraphHashTable(intIndex).WidthInPixel > 500 Then
                            CommonFunction.General.WriteHTML("</TD></TR><TR><TD")
                            CommonFunction.General.WriteHTML(" colspan=2 ")
                        End If
                        intRowGraphCnt = 2
                    End If
                    CommonFunction.General.WriteHTML(">")
                End If
                'End If
                Dim arrType As String() = {objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type, objGraphHashTable(intIndex).Type}
                'Image Path
                strImageFileName = CommonFunction.FileDirectory.GetUniqueFileName
                strVirtualImgPath = CommonFunction.Constants.CLCP_IMAGES_FOLDER_PATH + "/" + strImageFileName
                Dim ChartAreaGradientStyle As String
                Dim PieChartLabelStyle As String
                If objGraphHashTable(intIndex).Type.ToUpper = "PIE" Then
                    ChartAreaGradientStyle = "Center"
                    PieChartLabelStyle = objGraphHashTable(intIndex).PiChartLabelStyle
                Else
                    ChartAreaGradientStyle = "TopBottom"
                    PieChartLabelStyle = ""
                End If

                Dim blnCancelGraph As Boolean = False
                Dim oGraph As EventHandlers.WAF_Graph
                oGraph = PrepareGraphObject(arrType, ReplacePlaceHolders(objGraphHashTable(intIndex).StoredProcedure, "", m_objSubTagGlobal), strVirtualImgPath, _
                    Server.MapPath(strVirtualImgPath), m_strConnectionString, "white", objGraphHashTable(intIndex).BorderStyle, objGraphHashTable(intIndex).ChartAreaColor, _
                    objGraphHashTable(intIndex).ChartBackColor, objGraphHashTable(intIndex).Enable3D, "white", objGraphHashTable(intIndex).BorderColor, "white", "TopBottom", "TopBottom", _
                    ChartAreaGradientStyle, PieChartLabelStyle, objGraphHashTable(intIndex).Title, New System.Drawing.Font(objGraphHashTable(intIndex).GraphTitleFont, 9, System.Drawing.FontStyle.Bold), "black", _
                    CType(objGraphHashTable(intIndex).WidthInPixel, Integer), CType(objGraphHashTable(intIndex).HeightInPixel, Integer), objGraphHashTable(intIndex).LegendCaptionColor, _
                    New System.Drawing.Font(objGraphHashTable(intIndex).LegendFont, 9, System.Drawing.FontStyle.Bold), "excel", objGraphHashTable(intIndex).ShowExplodedPiChart, objGraphHashTable(intIndex).ShowLegends, objGraphHashTable(intIndex).DisplayPosition)

                oGraph.ConditionClause = ReplacePlaceHolders(objGraphHashTable(intIndex).ConditionClause, "", m_objSubTagGlobal)
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************

                'Call Before plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Graph.Before_PlotGraph(blnCancelGraph, oGraph, m_objSubTagGlobal, m_cObjCPSQL.PrimaryKeyValue)
                Call Before_PlotGraph(blnCancelGraph, oGraph, m_objSubTagGlobal, m_cObjCPSQL.PrimaryKeyValue)
                'Modification Ends


                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                Dim dr As IDataReader
                Dim blnPlotGraph As Boolean = True
                ' Check the condition to plot the graph.
                If Trim(oGraph.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(oGraph.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), oGraph.ConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================
                    blnPlotGraph = dr.Read
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If
                ' Plot the grpah only when there are some rows returned by executin of the condition clause sql
                If blnPlotGraph Then
                    ' ***************************************************************************************
                    ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                    ' ***************************************************************************************
                    objGraph = New Graph.Graph 'Added By PushkarK On 03-Oct-2007
                    With objGraph
                        'Main properties
                        .ChartType = oGraph.ChartType
                        .SQL = oGraph.SQL
                        .VirtualImagePath = oGraph.VirtualImagePath
                        .AbsoluteImagePath = oGraph.AbsoluteImagePath
                        .ConnectionString = oGraph.ConnectionString
                        .LegendBackColor = "white"
                        'Other Properties
                        .BorderColor = oGraph.BorderColor
                        .BorderStyle = oGraph.BorderStyle
                        .ChartAreaColor = oGraph.ChartAreaColor
                        .ChartBackColor = oGraph.ChartBackColor
                        .Enable3D = oGraph.Enable3D
                        .ChartAreaGradientColor = oGraph.ChartAreaGradientColor
                        .BorderGradientColor = oGraph.BorderGradientColor
                        .ChartBackGradientColor = oGraph.ChartBackGradientColor
                        .ChartBackGradientStyle = oGraph.ChartBackGradientStyle
                        .BorderGradientStyle = oGraph.BorderGradientStyle
                        .ChartAreaGradientStyle = oGraph.ChartAreaGradientStyle
                        .PieChartLabelStyle = oGraph.PieChartLabelStyle
                        'Title Properties
                        .GraphTitle = oGraph.GraphTitle
                        .TitleFont = oGraph.TitleFont
                        .GraphTitleColor = oGraph.GraphTitleColor
                        .Width = oGraph.Width
                        .Height = oGraph.Height
                        .LegendCaptionColor = oGraph.LegendCaptionColor
                        .LegendFont = oGraph.LegendFont
                        .PalleteStyle = oGraph.PalletStyle
                        .ShowExplodedPie = oGraph.ShowExplodedPie
                        .ShowLegends = oGraph.ShowLegends
                        .EnableSmartLabels = oGraph.EnableSmartLabels
                        .ShowCaptions = oGraph.ShowCaptions
                        objGraph.LegendFont = New System.Drawing.Font("verdana", 7, System.Drawing.FontStyle.Regular)
                        .XAxisInterval = 1
                        If blnCancelGraph = False Then
                            If oGraph.ChartType(0).ToUpper = "STACKEDBAR" Or oGraph.ChartType(0).ToUpper = "STACKEDCOLUMN" Then
                                .GenerateStackedGraphImage()
                            Else
                                .GenerateImage()
                            End If
                        End If
                    End With
                    If blnCancelGraph = False Then CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawImage(strVirtualImgPath + ".png", , , , , , , True))
                    objGraph.Dispose() : objGraph = Nothing 'Added By PushkarK On 03-Oct-2007
                    ' ***************************************************************************************
                    ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                    ' ***************************************************************************************
                End If
                ' ***************************************************************************************
                ' End Adddition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_44
                ' ***************************************************************************************
                'Call After plot graph event
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_Graph.After_PlotGraph(oGraph, m_objSubTagGlobal, m_cObjCPSQL.PrimaryKeyValue)
                Call After_PlotGraph(oGraph, m_objSubTagGlobal, m_cObjCPSQL.PrimaryKeyValue)
                'Modification Ends,
            End If
        Next
        CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
        'Destroy the object
        objGraph = Nothing
        objGraphHashTable = Nothing

    End Sub

    Private Sub SubTagLIST_PlotRelatedData()
        '=====================================================================
        ' Procedure Name        :	SubTagLIST_PlotRelatedData
        ' Purpose               :	Plot the section : Related Data
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Umesh Joshi/Rajanikant Khethawatt
        ' Created               :	November 06, 2004 
        ' Revisions             :
        '=====================================================================
        'Create Hash Table object for Related Data
        Dim objDataHashTable() As CommonEngines.HashTables.SubTagUIInformation
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_objGlobal.LCID Then
            objDataHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIRelatedDataObject(m_lngSubTagID)
        Else
            objDataHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIRelatedDataObject(m_lngSubTagID.ToString + m_objGlobal.LCID.ToString)
            If objDataHashTable Is Nothing Then
                objDataHashTable = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableSubTagUIRelatedDataObject(m_lngSubTagID)
            End If
        End If

        If objDataHashTable Is Nothing Then
            Return
        End If

        Dim intIndex As Integer
        Dim intLastIndex As Integer = objDataHashTable.Length - 1
        For intIndex = 0 To intLastIndex
            If objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_LIST.ToString Or objDataHashTable(intIndex).DisplayPosition = CommonFunctions.Constants.CLCP_RELATEDDATA_DISPLAYPOSITION_BOTH.ToString Then
                Dim RelatedDataDivID As String = "SubRelatedData_DivList" + intIndex.ToString

                'Data Header
                Dim objHeader As EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader
                Dim blnCancelHeader As Boolean = False
                objHeader = PrepareRelatedDataHeaderObject(objDataHashTable(intIndex).DataHeader.Trim, objDataHashTable(intIndex).DataHeaderAlignment.Trim, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).UniqueID)

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' set the condition clause of the object
                objHeader.ConditionClause = objDataHashTable(intIndex).ConditionClause
                'Added By UmeshJ Aug 03, 2007
                objHeader.ConditionClause = ReplacePlaceHolders(objHeader.ConditionClause, "", m_objGlobal)
                'End of Addition
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************


                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                ExtensionArgs.Cancel = blnCancelHeader
                ExtensionArgs.m_RelatedDataHeader = objHeader
                ExtensionArgs.m_global = m_objSubTagGlobal
                ExtensionArgs.PrimaryKey = ""

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                        "Before_PlotRelatedDataHeader", ExtensionArgs)

                objHeader = ExtensionArgs.m_RelatedDataHeader
                blnCancelHeader = ExtensionArgs.Cancel
                m_objSubTagGlobal = ExtensionArgs.m_global
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************

                'Call the Before Print Event for Related Data Header
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_RelatedData.Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, "")
                Call Before_PlotRelatedDataHeader(blnCancelHeader, objHeader, m_objGlobal, "")
                'Modification Ends,

                ' ***************************************************************************************
                ' Added Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                ' Check the condition to plot the related data header
                Dim dr As IDataReader
                Dim blnPlotHeader As Boolean = True
                If Trim(objHeader.ConditionClause & "") <> "" Then
                    '==========================================================================================================
                    'Added By NinadP :	20 Nov 2006 : Requirement Tag - WAF3_PB_33 
                    dr = CommonFunctions.Data.GetDataReader(objHeader.ConditionClause, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean), m_strConnectionString)
                    ' Addition End By : Ninad   Req Id : WAF3_PB_33
                    '==========================================================================================================
                    blnPlotHeader = dr.Read
                    CommonFunctions.Data.DisposeDataReader(dr)
                End If
                ' Plot the header only when there are some rows returned by execution of the condition clause sql
                If blnPlotHeader Then
                    If blnCancelHeader = False Then Call RelatedData_Header(objHeader.DataHeader, objHeader.DataHeaderAlignment)
                End If
                ' ***************************************************************************************
                ' End Addition Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                '***************************************************************************************

                ' WAF_PB_17
                '*******************************************************************    
                ' Code Added:RajeshB                    7th October, 2004
                ' Purpose: Handle all applicable extensions.
                '*******************************************************************
                'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
                ExtensionArgs.m_RelatedDataHeader = objHeader
                ExtensionArgs.m_global = m_objGlobal
                ExtensionArgs.PrimaryKey = ""

                CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                        "After_PlotRelatedDataHeader", ExtensionArgs)

                objHeader = ExtensionArgs.m_RelatedDataHeader
                m_objGlobal = ExtensionArgs.m_global
                '*******************************************************************    
                ' Addition Ends - RajeshB
                '******************************************************************

                'Call the After Print Event for Related Data Header
                'Code Modified:RajeshB              19 Jan 2005
                ' Purpose: Wrap the call into an overridable function
                'Call CommonEngine.General.CLCP_Events_RelatedData.After_PlotRelatedDataHeader(objHeader, m_objGlobal, "")
                Call After_PlotRelatedDataHeader(objHeader, m_objGlobal, "")
                'Modification Ends.
                objHeader = Nothing

                'Related Data Grid
                ' ***************************************************************************************
                ' Modified Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************
                Dim gridSQL As String = ReplacePlaceHolders(objDataHashTable(intIndex).DataGridSQL, "", m_objGlobal)
                ' Passing the condition clause to the routine to plot grid
                Call RelatedData_Grid(gridSQL, RelatedDataDivID, objDataHashTable(intIndex).OrderNumber, objDataHashTable(intIndex).UniqueID, objDataHashTable(intIndex).QRBQueryID, objDataHashTable(intIndex).ConditionClause, Not (objDataHashTable(intIndex).VerticalDisplay), objDataHashTable(intIndex).DisplayPosition)
                ' ***************************************************************************************
                ' End Modification Aug 30,2004 Rajanikant Khethawatt R.No.WAF2_PB_43
                ' ***************************************************************************************

                'Separator HTML Tag
                If intIndex < intLastIndex Then Response.Write(CommonFunction.General.CheckIsNothing(objDataHashTable(intIndex).SeperatorHTMLTag))
            End If
        Next
        'Destroy the object
        objDataHashTable = Nothing

        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
    End Sub
    ' **************************************************************************
    ' End Addition Nov 06,2004 Rajanikant Khethawatt R.No. WAF2_PB_41, WAF2_PB_42
    ' **************************************************************************
#End Region


    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

#Region "EVENTS"

#Region "PAGE LEGENDS EVENTS"
    Private Sub m_cObjPageLegends_Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends) Handles m_cObjPageLegends.Initialize_Legend
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        ExtensionArgs.Cancel = Cancel

        ExtensionArgs.m_InitializeLegends = Args
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.m_WAFGeneral = m_objGeneral

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_PageLegends", _
                "Initialize_Legend", ExtensionArgs)

        Cancel = ExtensionArgs.Cancel
        Args = ExtensionArgs.m_InitializeLegends
        m_objGeneral = ExtensionArgs.m_WAFGeneral
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Code Modified:RajeshB              19 Jan 2005
        ' Purpose: Wrap the call into an overridable function
        'Call CommonEngine.General.CLCP_Events_PageLegends.Initialize_Legend(Cancel, Args, m_objGlobal, m_objGeneral)
        Call Initialize_Legend(Cancel, Args, m_objGlobal, m_objGeneral)
        'Modification Ends
    End Sub
    Protected Overridable Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
        Call CommonEngine.General.CLCP_Events_PageLegends.Initialize_Legend(Cancel, Args, WhizGlobal, Gen)
    End Sub
    Protected Overridable Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
        Call CommonEngine.General.CLCP_Events_PageLegends.Before_Legend_Print(Cancel, Args, WhizGlobal, Gen)
    End Sub

    Private Sub m_cObjPageLegends_Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends) Handles m_cObjPageLegends.Before_Legend_Print
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        ExtensionArgs.Cancel = Cancel
        ExtensionArgs.m_Legends = Args
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.m_WAFGeneral = m_objGeneral

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_PageLegends", _
                "Before_Legend_Print", ExtensionArgs)

        Cancel = ExtensionArgs.Cancel
        Args = ExtensionArgs.m_Legends
        m_objGeneral = ExtensionArgs.m_WAFGeneral
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Code Modified:RajeshB              19 Jan 2005
        ' Purpose: Wrap the call into an overridable function
        'Call CommonEngine.General.CLCP_Events_PageLegends.Before_Legend_Print(Cancel, Args, m_objGlobal, m_objGeneral)
        Call Before_Legend_Print(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
#End Region

#Region "PAGE CAPTION EVENTS"
    Private Sub m_cObjPageCaption_Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption) Handles m_cObjPageCaption.Before_Page_Caption_Print
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        ExtensionArgs.Cancel = Cancel
        ExtensionArgs.m_PageCaption = Args
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.m_WAFGeneral = m_objGeneral

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_PageCaption", _
                "Before_Page_Caption_Print", ExtensionArgs)

        Cancel = ExtensionArgs.Cancel
        Args = ExtensionArgs.m_PageCaption
        m_objGeneral = ExtensionArgs.m_WAFGeneral
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call CommonEngine.General.CLCP_Events_PageCaption.Before_Page_Caption_Print(Cancel, Args, m_objGlobal, m_objGeneral)
        Call Before_Page_Caption_Print(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
    Protected Overridable Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
        Call CommonEngine.General.CLCP_Events_PageCaption.Before_Page_Caption_Print(Cancel, Args, WhizGlobal, Gen)
    End Sub

#End Region

#Region "PAGE HEADER FOOTER EVENTS"
    Private Sub m_cObjHeaderFooter_Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter) Handles m_cObjHeaderFooter.Before_Header_Footer_Print
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        ExtensionArgs.Cancel = Cancel
        ExtensionArgs.m_HeaderFooter = Args
        ExtensionArgs.m_global = m_objGlobal
        ExtensionArgs.m_WAFGeneral = m_objGeneral

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_HeaderFooter", _
                "Before_Header_Footer_Print", ExtensionArgs)

        Cancel = ExtensionArgs.Cancel
        Args = ExtensionArgs.m_HeaderFooter
        m_objGeneral = ExtensionArgs.m_WAFGeneral
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call CommonEngine.General.CLCP_Events_HeaderFooter.Before_Header_Footer_Print(Cancel, Args, m_objGlobal, m_objGeneral)
        Call Before_Header_Footer_Print(Cancel, Args, m_objGlobal, m_objGeneral)
    End Sub
    Protected Overridable Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As EventHandlers.WAF_General)
        Call CommonEngine.General.CLCP_Events_HeaderFooter.Before_Header_Footer_Print(Cancel, Args, WhizGlobal, Gen)
    End Sub
#End Region

#Region "SECTION"
    Private Sub m_cObjSectionTitle_Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks) Handles m_cObjSectionTitle.Section_Title_Before_Link_Print
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        ExtensionArgs.Cancel = Cancel
        ExtensionArgs.m_SectionLinks = Args
        ExtensionArgs.m_global = m_objGlobal

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                "Section_Title_Before_Link_Print", ExtensionArgs)

        Cancel = ExtensionArgs.Cancel
        Args = ExtensionArgs.m_SectionLinks
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Call CommonEngine.General.CLCP_Events_Sections.Section_Title_Before_Link_Print(Cancel, Args, m_objGlobal)
        Call Section_Title_Before_Link_Print(Cancel, Args, m_objGlobal)
    End Sub
    Protected Overridable Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_Sections.Section_Title_Before_Link_Print(Cancel, Args, WhizGlobal)
    End Sub
    Private Sub m_cObjSectionTitle_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle) Handles m_cObjSectionTitle.Initialize
        ' WAF_PB_17
        '*******************************************************************    
        ' Code Added:RajeshB                    7th October, 2004
        ' Purpose: Handle all applicable extensions.
        '*******************************************************************
        'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
        Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

        ExtensionArgs.Cancel = Cancel
        ExtensionArgs.m_SectionTitle = Args
        ExtensionArgs.m_global = m_objGlobal

        CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_Sections", _
                "Section_Title_Initialize", ExtensionArgs)

        Cancel = ExtensionArgs.Cancel
        Args = ExtensionArgs.m_SectionTitle
        m_objGlobal = ExtensionArgs.m_global

        If Not ExtensionArgs Is Nothing Then
            ExtensionArgs = Nothing
        End If
        'Modification Ends.
        '*******************************************************************    
        ' Addition Ends - RajeshB
        '******************************************************************
        'Code Modified:RajeshB      15th Jan 2005
        '        Call CommonEngine.General.CLCP_Events_Sections.Section_Title_Initialize(Cancel, Args, m_objGlobal)
        Call Section_Title_Initialize(Cancel, Args, m_objGlobal)
        'Modification Ends
    End Sub
    Protected Overridable Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_Sections.Section_Title_Initialize(Cancel, Args, WhizGlobal)
    End Sub
#End Region

#Region "DYNAMIC MENU EVENTS"

    'DYNAMIC MENU EVENTS
    Private Sub m_cObjMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_Link_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Link_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_DynamicMenuLink = Args
            ExtensionArgs.m_global = WhizGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Link_Print", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_DynamicMenuLink
            WhizGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Link_Print(Cancel, Args, WhizGlobal)
            Call Before_Link_Print(Cancel, Args, WhizGlobal)
            'Addition Ends
        End If
        'addition ends
    End Sub
    Protected Overridable Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Link_Print(Cancel, Args, WhizGlobal)
    End Sub

    Private Sub m_cObjMenu_Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_NavLinks_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_NavLinks_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_NavLinks = Args
            ExtensionArgs.m_global = WhizGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_NavLinks_Print", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_NavLinks
            WhizGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            Call Before_NavLinks_Print(Cancel, Args, WhizGlobal)
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_NavLinks_Print(Cancel, Args, WhizGlobal)
            'Modification Ends,
        End If
        'addition ends
    End Sub
    Protected Overridable Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_NavLinks_Print(Cancel, Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_Link_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_Link_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_DynamicMenuLink = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_Link_Print", ExtensionArgs)

            Args = ExtensionArgs.m_DynamicMenuLink
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_Link_Print(Args, WhizGlobal)
            Call After_Link_Print(Args, WhizGlobal)
            'Modification Ends.
        End If
        'addition ends

    End Sub
    Protected Overridable Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_Link_Print(Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_NavLink_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_NavLink_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_NavLink = Args
            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_NavLink_Print", ExtensionArgs)

            Args = ExtensionArgs.m_NavLink
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_NavLink_Print(Args, WhizGlobal)
            Call After_NavLink_Print(Args, WhizGlobal)
        End If
        'addition ends.
    End Sub
    Protected Overridable Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_NavLink_Print(Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_NavLinks_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_NavLinks_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_NavLinks = Args
            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_NavLinks_Print", ExtensionArgs)


            Args = ExtensionArgs.m_NavLinks
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_NavLinks_Print(Args, WhizGlobal)
            Call After_NavLinks_Print(Args, WhizGlobal)
            'Modification Ends.
        End If
    End Sub
    Protected Overridable Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_NavLinks_Print(Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_Paging_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_Paging_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.DynamicMenuPaging = Args
            ExtensionArgs.m_global = WhizGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_Paging_Print", ExtensionArgs)


            Args = ExtensionArgs.DynamicMenuPaging
            WhizGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.After_Paging_Print(Args, WhizGlobal)
            Call After_Paging_Print(Args, WhizGlobal)
            'Modification Ends
        End If
        'addition ends
    End Sub
    Protected Overridable Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.After_Paging_Print(Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_NavLink_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_NavLink_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_NavLink = Args
            ExtensionArgs.m_global = m_objGlobal

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_NavLink_Print", ExtensionArgs)

            Args = ExtensionArgs.m_NavLink
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_NavLink_Print(Cancel, Args, WhizGlobal)
            Call Before_NavLink_Print(Cancel, Args, WhizGlobal)
        End If
        'addition ends
    End Sub
    Protected Overridable Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_NavLink_Print(Cancel, Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging) Handles m_cObjMenu.Before_Paging_Link_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Link_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_PagingLink = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.DynamicMenuPaging = Paging

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Link_Print", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Paging = ExtensionArgs.DynamicMenuPaging
            Args = ExtensionArgs.m_PagingLink
            m_objGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
            Call Before_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
        End If
        'addition ends.
    End Sub
    Protected Overridable Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
    End Sub
    Private Sub m_cObjMenu_Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_Paging_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.DynamicMenuPaging = Args
            ExtensionArgs.m_global = WhizGlobal
            ExtensionArgs.DynamicMenuPaging = Args

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Print", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.DynamicMenuPaging
            WhizGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Paging_Print(Cancel, Args, WhizGlobal)
            Call Before_Paging_Print(Cancel, Args, WhizGlobal)
            'Modification Ends.,
        End If
        'addition ends.
    End Sub
    Protected Overridable Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Paging_Print(Cancel, Args, WhizGlobal)
    End Sub
    Private Sub m_cObjMenu_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Initialize
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Paging_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_global = WhizGlobal
            ExtensionArgs.m_DynamicMenu = Args

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Initialize", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_DynamicMenu
            WhizGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Initialize(Cancel, Args, WhizGlobal)
        End If
        'addition ends
    End Sub

    Protected Overridable Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Initialize
        Call CommonEngine.General.CLCP_Events_DynamicActions.Initialize(Cancel, Args, WhizGlobal)
    End Sub

    Private Sub m_cObjMenu_Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging) Handles m_cObjMenu.Initialize_Paging_Link_Print
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Initialize_Paging_Link_Print")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_WAFPaging = Args
            ExtensionArgs.m_global = WhizGlobal
            ExtensionArgs.m_WAFPaging = Args
            ExtensionArgs.DynamicMenuPaging = Paging

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Initialize_Paging_Link_Print", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Paging = ExtensionArgs.DynamicMenuPaging
            Args = ExtensionArgs.m_WAFPaging
            WhizGlobal = ExtensionArgs.m_global

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_DynamicActions.Initialize_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
            Call Initialize_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
            'Modification ends

        End If
        'addition ends
    End Sub
    Protected Overridable Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
        Call CommonEngine.General.CLCP_Events_DynamicActions.Initialize_Paging_Link_Print(Cancel, Args, WhizGlobal, Paging)
    End Sub

#Region "Menu Print Event Sections"
    'Added By PrasannaP on 26th April 2005
    'This event is triggered before/after printing links
    'You can put the Display position of the link.
    'If you want to plot it on both the positions then don't set it.
    'Args.DisplayPosition = "UI_HEAD"/"UI_FOOT"
    Protected Overridable Sub After_Menu_Print(ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.After_Menu_Print
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "After_Menu_Print")
        If blnCheckEventCall = True Then
            'Call After_Menu_Print(Args, WhizGlobal)
            Call CommonEngine.General.CLCP_Events_DynamicActions.After_Menu_Print(Args, WhizGlobal)
        End If
    End Sub

    Protected Overridable Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal) Handles m_cObjMenu.Before_Menu_Print
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_DynamicActions", _
                    "Before_Menu_Print")
        If blnCheckEventCall = True Then
            'Call Before_Menu_Print(Cancel, Args, WhizGlobal)
            Call CommonEngine.General.CLCP_Events_DynamicActions.Before_Menu_Print(Cancel, Args, WhizGlobal)
        End If
    End Sub
    'End Addition
#End Region

#End Region

#Region "RELATED DATA"
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "ColumnHeaderTD_BeforePrint")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_GenericColumnHeaderTD = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "ColumnHeaderTD_BeforePrint", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_GenericColumnHeaderTD
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_RelatedData.ColumnHeaderTD_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends
        End If
        'addition ends
    End Sub
    Protected Overridable Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.ColumnHeaderTD_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "ColumnHeaderTR_BeforePrint")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_GenericColumnHeaderTR = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "ColumnHeaderTR_BeforePrint", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_GenericColumnHeaderTR
            m_objGlobal = ExtensionArgs.m_global
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_RelatedData.ColumnHeaderTR_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call ColumnHeaderTR_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends.
        End If
        'addition ends
    End Sub
    Protected Overridable Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.ColumnHeaderTR_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTD_BeforePrint")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_GenericDataRowTD = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTD_BeforePrint", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_GenericDataRowTD
            m_objGlobal = ExtensionArgs.m_global
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTD_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call DataRowTD_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
        End If
        'addition ends
    End Sub
    Protected Overridable Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTD_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub

    Private Sub m_objGrid_DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_AfterPrint
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTD_AfterPrint")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_GenericDataRowTD = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.m_WAFGeneral = m_objGeneral
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTD_AfterPrint", ExtensionArgs)

            Args = ExtensionArgs.m_GenericDataRowTD
            m_objGeneral = ExtensionArgs.m_WAFGeneral
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTD_AfterPrint(Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call DataRowTD_AfterPrint(Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends

        End If
        'addition ends
    End Sub
    Protected Overridable Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTD_AfterPrint(Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTR_BeforePrint")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_GenericDataRowTR = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.m_WAFGeneral = m_objGeneral
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTR_BeforePrint", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_GenericDataRowTR
            m_objGeneral = ExtensionArgs.m_WAFGeneral
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTR_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call DataRowTR_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends.
        End If
        'addition ends
    End Sub
    Protected Overridable Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTR_BeforePrint(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
    Private Sub m_objGrid_DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_AfterPrint
        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTR_AfterPrint")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.m_GenericDataRowTR = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.m_WAFGeneral = m_objGeneral
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_RelatedData", _
                    "DataRowTR_AfterPrint", ExtensionArgs)

            Args = ExtensionArgs.m_GenericDataRowTR
            m_objGeneral = ExtensionArgs.m_WAFGeneral
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTR_AfterPrint(Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call DataRowTR_AfterPrint(Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends,
        End If
        'addition ends
    End Sub
    Protected Overridable Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_RelatedData.DataRowTR_AfterPrint(Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
#End Region

#Region "TAB"
    Private Sub m_cobjTabs_Initialize(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings) Handles m_cobjTabs.Initialize

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_SubTag", _
                    "InitializeTAB_SubTag")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_TabSettings = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_SubTag", _
                    "InitializeTAB_SubTag", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_TabSettings
            m_objGlobal = ExtensionArgs.m_global
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_SubTag.InitializeTAB_SubTag(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call InitializeTAB_SubTag(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends.
        End If
        'addition ends.
    End Sub
    Protected Overridable Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_SubTag.InitializeTAB_SubTag(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
    Private Sub m_cobjTabs_Tab_BeforePlot(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab) Handles m_cobjTabs.Tab_BeforePlot

        'Code Added:RajeshB	14 October, 2004
        'Purpose: Check if event is to be raised
        Dim blnCheckEventCall As Boolean
        blnCheckEventCall = EventChecker.CheckEventCallFlag(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_SubTag", _
                    "BeforePlotTAB_SubTag")
        If blnCheckEventCall = True Then
            ' WAF_PB_17
            '*******************************************************************    
            ' Code Added:RajeshB                    7th October, 2004
            ' Purpose: Handle all applicable extensions.
            '*******************************************************************
            'Code Modified to replace shared variables with class properties. by NiranjanS - 14-JUL-2005.
            Dim ExtensionArgs As New CommonEngines.General.ExtensionArgs

            ExtensionArgs.Cancel = Cancel
            ExtensionArgs.m_Tab = Args
            ExtensionArgs.m_global = m_objGlobal
            ExtensionArgs.PrimaryKey = m_cObjCPSQL.PrimaryKeyValue

            CommonEngines.HashTables.CLCPExtensionHandler.handleEvent(m_objGlobal.TagID, m_objGlobal.ParentTagID, "Whiz.CommonEngine.General.CLCP_Events_SubTag", _
                    "BeforePlotTAB_SubTag", ExtensionArgs)

            Cancel = ExtensionArgs.Cancel
            Args = ExtensionArgs.m_Tab
            m_objGlobal = ExtensionArgs.m_global
            m_cObjCPSQL.PrimaryKeyValue = ExtensionArgs.PrimaryKey

            If Not ExtensionArgs Is Nothing Then
                ExtensionArgs = Nothing
            End If
            'Modification Ends.
            '*******************************************************************    
            ' Addition Ends - RajeshB
            '******************************************************************
            'Code Modified:RajeshB              19 Jan 2005
            ' Purpose: Wrap the call into an overridable function
            'Call CommonEngine.General.CLCP_Events_SubTag.BeforePlotTAB_SubTag(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            Call BeforePlotTAB_SubTag(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
            'Modification Ends.
        End If

        'addition ends
    End Sub
    Protected Overridable Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        Call CommonEngine.General.CLCP_Events_SubTag.BeforePlotTAB_SubTag(Cancel, Args, m_objGlobal, m_cObjCPSQL.PrimaryKeyValue)
    End Sub

    'Added By NileshD on 1st Sep 2005 for IssueID: 20947
    Protected Overridable Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New CommonEngine.CommonList.cPlotGrid(m_objSubTagGlobal)
    End Function

    Protected Overridable Function InitSubTag_DynamicFileters(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagDynamicFilters
        Return New CommonEngine.CommonList.cSubTagDynamicFilters(m_objSubTagGlobal)
    End Function
    'End of Addition By NileshD on 1st Sep 2005 for IssueID: 20947
#End Region

#Region "FILTER"
    'Private -> Protected Overridable
    Protected Overridable Sub After_Getting_FilterClause(ByRef FilterClause As String)
        Call CommonEngine.General.CLCP_Events_DynamicFilters.After_Getting_FilterClause(m_objSubTagGlobal, FilterClause, m_cObjCPSQL.PrimaryKeyValue)
    End Sub
    'Private -> Protected Overridable
    Protected Overridable Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

        Call CommonEngine.General.CLCP_Events_DynamicFilters.Before_Applying_Filter(m_objGlobal, ToBeInsertedInFunction, m_cObjCPSQL.PrimaryKeyValue, m_lngSubTagID)

    End Sub
#End Region

#End Region

End Class

