'============================================================================================================================
' ASPX Modified By          :	Ninad
' Purpose                   :   Not to allow to save if value selected form source and destination combo is same(for role and group access)
' Added                     :	11 Oct, 2006 
' Req     ID                :   2.0.42-SP4-WAF

'Modified on                :   3 April 2008
'Purpose                    :   To addSave And Close link, following functions are modified, ACTION parameter is added,
'                               1. InheritSave_OnClick 2. TagSave_OnClick 3. Save_OnClick
'Issue ID                   :   14871
'=============================================================================================================================

Imports CommonFunctions

Public Class RoleAccess
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_GROUP_ACCESS As String = "GROUP"
    Protected CONST_ROLE_ACCESS As String = "ROLE"
    Protected CONST_TAG_ACCESS As String = "TAG"
    Protected CONST_SUBNODE_ACCESS As String = "SUBNODE"
    Protected CONST_SUBNODE_ACCESS_GROUP As String = "SUBNODEG"
    Protected CONST_INHERIT_ACCESS As String = "INHERIT"
    Protected CONST_INHERIT_ACCESS_GROUP As String = "INHERITG"
    Protected CONST_TABCOLLECTION_ROLE_ACCESS As String = "TABCOLLECTION_ROLE" 'Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
    Protected CONST_TABCOLLECTION_GROUP_ACCESS As String = "TABCOLLECTION_GROUP" 'Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
    Protected CONST_ACTION_SAVE As String = "1"
    Protected CONST_ACTION_SAVE_AND_CLOSE As String = "2" 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link 

    Protected m_strMode As String
    Protected m_strMasterTagID As String
    Protected m_strFromWhere As String
    Protected m_lngTagID As Long
    Private m_strModule As String
    Protected m_strTemplateID As String
    Private m_strParentList As String
    Protected m_lngUserAccessID As Long
    Protected m_lngRoleID As Long
    Protected m_strWindowTitle As String
    Private m_arlSubTagIDList As New ArrayList

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
    'Reason   - Role Access page was showing Save link even if the user with specified role has only view access.
    '-------------------------------------------------------------------------------------------------------------
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccess As WebPage.Templates.AccessRights
    Private m_lngCurrentUserRoleID As Long
    Private m_blnIsAdmin As Boolean = False
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
    '-------------------------------------------------------------------------------------------------------------

    'Added By - PushkarK On - Monday, July 24, 2006 For Support Request ID. - 141
    Protected m_strSubMode As String
    'Addition Ends By - PushkarK On - Monday, July 24, 2006 For Support Request ID. - 141
    '============================================================================================================================
    ' Modified By     		    :	Ninad
    ' Purpose                   :   To hold validation message,(not to allow to save if value selected form source and destination combo is same(for role and group access))
    ' Added                     :	11 Oct, 2006 
    ' Req     ID                :   2.0.42-SP4-WAF
    '=============================================================================================================================
    Public m_strValidationMsgSourceDestinationSame As String
    '============================================================================================================================
    'End Modification By Ninad, Date : 28 Sept 2006, Request ID : 2.0.42-SP4-WAF
    '=============================================================================================================================
    'WAF3_PB_42 April 10, 2007 UmeshJ START
    Private m_blnIsDropdownMenuEnabled As Boolean
    Protected m_intDivFillFactor As Short
    'WAF3_PB_42 April 10, 2007 UmeshJ END

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load ', Me.Load 'Commented By PushkarK For WAF3_QRB_14
        'Put user code to initialize the page here
        If Request.QueryString("Mode").ToUpper = CONST_INHERIT_ACCESS Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_INHERIT_ROLE") + ""
            m_strValidationMsgSourceDestinationSame = MyBase.GetResourceString("VALIDATION_MSG_SOURCE_DESTINATION_SAME_ROLE")
        ElseIf Request.QueryString("Mode").ToUpper = CONST_INHERIT_ACCESS_GROUP Then
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_INHERIT_GROUP") + ""
            m_strValidationMsgSourceDestinationSame = MyBase.GetResourceString("VALIDATION_MSG_SOURCE_DESTINATION_SAME_GROUP")
        ElseIf Request.QueryString("Mode").ToUpper = CONST_GROUP_ACCESS Or Request.QueryString("Mode").ToUpper = CONST_SUBNODE_ACCESS_GROUP Then 'Modified By Ninad on 24 March 2009 IssueID-27641
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_GROUP_ACCESS") + ""
            m_strValidationMsgSourceDestinationSame = MyBase.GetResourceString("VALIDATION_MSG_SOURCE_DESTINATION_SAME_GROUP")
        ElseIf Request.QueryString("Mode").ToUpper = CONST_TABCOLLECTION_ROLE_ACCESS Or Request.QueryString("Mode").ToUpper = CONST_TABCOLLECTION_GROUP_ACCESS Then 'Added By Ninad on 10 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
            m_strWindowTitle = MyBase.GetResourceString("PAGE_CAPTION_TABCOLLECTION") + ""
        Else
            m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE") + ""
            m_strValidationMsgSourceDestinationSame = MyBase.GetResourceString("VALIDATION_MSG_SOURCE_DESTINATION_SAME_ROLE")
        End If

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
        'Reason   - Role Access page was showing Save link even if the user with specified role has only view access.
        '-------------------------------------------------------------------------------------------------------------
        m_lngCurrentUserRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), "0"), Long)
        If m_lngCurrentUserRoleID <> CommonFunctions.Constants.ROLE_ADMINISTRATOR Then
            m_blnIsAdmin = False
            GetGlobalObject()
            GetAccessRights()
        Else
            m_blnIsAdmin = True
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
        '-------------------------------------------------------------------------------------------------------------
        'WAF3_PB_42 April 06, 2007 UmeshJ START
        If CommonFunctions.General.GetFrameworkSettings("GEN_ACTION_NAVIGATION_DROPDOWNMENU", "Enabled") = False Then
            m_blnIsDropdownMenuEnabled = False
            m_intDivFillFactor = 40 'Used in window onload and on resize
        Else
            m_blnIsDropdownMenuEnabled = True
            m_intDivFillFactor = 10 'Used in window onload and on resize
        End If
        'WAF3_PB_42 April 06, 2007 UmeshJ END
    End Sub
    Public Sub New()
        'MyBase.ApplySecurity()
        ''Added by SwapnilA on 18-10-2016 for Applysecurity for SQLInjection and XSS injection
        MyBase.ApplySecurity(True, 2, True, True, True)
        ''Ended by SwapnilA
        'initialize the resource file for query list.
        MyBase.InitializeResources("Resources.RoleAccess", "Resources")
    End Sub
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception()
        ex.Source = "Role Access ->InvalidInput"
        Throw ex
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML body tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 16 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim arrSeparator As System.Collections.ArrayList 'WAF3_PB_42 April 16, 2007 UmeshJ

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        'Reason   - To show Images for static menu. 
        '-------------------------------------------------------------------------------------------------------------
        Dim arrImagePaths As System.Collections.ArrayList
        Dim arrstrImagePaths() As String
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
        '-------------------------------------------------------------------------------------------------------------


        Dim arrstrMenu() As String
        Dim arrstrMenuToolTip() As String
        Dim arrstrClientSideFunctions() As String
        Dim strMenu As String
        Dim strAction As String
        Dim strSQL As String
        Dim objHeader As WebPage.Templates.HeaderFooter
        Dim objDR As IDataReader
        Dim strRoleDesc As String
        Dim strTagName As String
        Dim arrstrSeparator() As Boolean  'WAF3_PB_42 April 16, 2007 UmeshJ
        '---------------------------------------------------------------------------------------------------------------------------------------------
        'Added By Shrikant B On 18 Aug 2008 For Issue ID 21889
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {CommonFunction.HTMLControls.DrawMandatoryImage(, True)}
        'Addition End By Shrikant B On 18 Aug 2008 For Issue ID 21889
        '---------------------------------------------------------------------------------------------------------------------------------------------

        'Added By - PushkarK On - Monday, July 24, 2006 For Support Request ID. - 141
        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        m_strSubMode = HttpUtility.HtmlEncode(Request.QueryString("SubMode") & "")
        'Addition Ends By - PushkarK On - Monday, July 24, 2006 For Support Request ID. - 141
        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        m_strMode = HttpUtility.HtmlEncode(Request.QueryString("Mode") + "")
        m_strMasterTagID = Request.QueryString("MasterTagID") + ""
        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        m_strFromWhere = HttpUtility.HtmlEncode(Request.QueryString("FromWhere") + "")
        m_lngUserAccessID = CType(Request.QueryString("RoleID"), Long)

        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        strAction = HttpUtility.HtmlEncode(Request.QueryString("Action") + "")
        'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
        If strAction = "CONST_ACTION_SAVE" Then
            strAction = "1"
        ElseIf strAction = "CONST_ACTION_SAVE_AND_CLOSE" Then
            strAction = "2"
        End If
        'End Addition By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
        If Request.QueryString("TagID") <> "" Then
            m_lngTagID = CType(Request.QueryString("TagID"), Long)
        Else
            m_lngTagID = 0
        End If

        'Request ID 244, UmeshJ 19 June 2007 persist for post back..Required in the GetGlobalObject()
        If m_blnIsAdmin = False Then Response.Write("<Input Type='hidden' id='MasterTagID' name='MasterTagID' value='" + m_objGlobal.TagID.ToString + "'>")

        If m_lngUserAccessID > 0 Then
            'get the Role name and editable tag list for the userAccessID from the database
            strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
            objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                If Not IsDBNull(objDR("RoleID")) Then
                    m_lngRoleID = CType(objDR("RoleID"), Long)
                Else
                    m_lngRoleID = 0
                End If
                If Not IsDBNull(objDR("RoleDescription")) Then
                    strRoleDesc = objDR("RoleDescription").ToString + ""
                Else
                    strRoleDesc = ""
                End If

            End If
            objDR.Close()
            objDR.Dispose()
            objDR = Nothing
        End If


        'get the default module for the selected role from the database for the first time
        'Modified by    SachinR     on 3 Apr 2004
        If m_strMode = CONST_SUBNODE_ACCESS Or m_strMode = CONST_SUBNODE_ACCESS_GROUP Then
            'added by SachinR   on 17 Jul 2004
            'issue 11987
            ' ***********************************************************************************
            ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
            ' ***********************************************************************************
            m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID") + "")
            'addition end
        ElseIf m_strMode <> CONST_INHERIT_ACCESS And m_strMode <> CONST_INHERIT_ACCESS_GROUP Then
            If Not IsPostBack Then
                m_strTemplateID = MyBase.GetFormValue("cboModule") + ""
                If m_strTemplateID = "" Then
                    strSQL = "usp_Sel_tbl_Pm_Role_DefaultModule " + m_lngRoleID.ToString
                    m_strTemplateID = Data.CheckIsDBNull(Data.GetDataScalar(strSQL, MyBase.UseSQL).ToString, "").ToString
                End If
            Else
                ' ***********************************************************************************
                ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
                ' ***********************************************************************************
                m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID")) + ""
                If m_strTemplateID = "" Then
                    m_strTemplateID = MyBase.GetFormValue("cboModule") + ""
                End If
            End If
            ' Added By Rajanikant Khethawatt Dec 31,2004 
            If m_strMode = CONST_TAG_ACCESS Or m_strMode = CONST_ROLE_ACCESS Then
                If Not Request.QueryString("ModuleID") Is Nothing Then
                    ' ***********************************************************************************
                    ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
                    ' ***********************************************************************************
                    m_strTemplateID = HttpUtility.HtmlEncode(Request.QueryString("ModuleID").ToString)
                End If
            End If
            ' End Addition Dec 31,2004
        End If
        'modification end
        ' ***End comment Dec 31,2004



        If m_strMode.ToUpper = CONST_ROLE_ACCESS Then
            If m_strTemplateID = "" Then m_strTemplateID = "PM" 'default module is Project
        Else
            If m_strTemplateID = "" Then m_strTemplateID = "SM"
        End If

        Select Case (m_strMode.ToUpper)

            Case CONST_ROLE_ACCESS, CONST_GROUP_ACCESS

                If strAction <> "" Then
                    Call performAction(strAction, m_lngUserAccessID)
                End If

                '****************************************************************************************
                'Initialize the standard menu class of resource assebmbly
                MyBase.InitializeResources("Resources.StandardMenu", "Resources")
                'create menu for role list 
                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths = New System.Collections.ArrayList
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator = New System.Collections.ArrayList 'WAF3_PB_42 April 16, 2007 UmeshJ  

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                'Reason   - Role Access page was showing Save link even if the user with specified role has only view access.
                '-------------------------------------------------------------------------------------------------------------
                If m_blnIsAdmin OrElse (m_objAccess.Add Or m_objAccess.Edit Or m_objAccess.Delete) Then
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                    '-------------------------------------------------------------------------------------------------------------
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick('CONST_ACTION_SAVE')") 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick('CONST_ACTION_SAVE_AND_CLOSE')") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrMenu.Add(MyBase.GetResourceString("MENU_SELECT_ALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELET_ALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLEAR_ALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP")) : arrClientSideFunctions.Add("ClearAll_OnClick()")

                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrImagePaths.Add("../../Images/cssImages/Link images/save.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/saveclose.gif") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrImagePaths.Add("../../Images/cssImages/Link images/selectall.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/clearall.gif")
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    '-------------------------------------------------------------------------------------------------------------
                    arrSeparator.Add(False) : arrSeparator.Add(True) : arrSeparator.Add(False) : arrSeparator.Add(True)  'WAF3_PB_42 April 16, 2007 UmeshJ  ,'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                End If
                'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF

                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('312')")

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths.Add("../../Images/cssImages/Link images/close.gif")
                arrImagePaths.Add("../../Images/cssImages/Link images/help.gif")
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator.Add(True) : arrSeparator.Add(False)  'WAF3_PB_42 April 16, 2007 UmeshJ  

                'copy all the element to string array
                ReDim arrstrMenu(arrMenu.Count - 1)
                ReDim arrstrMenuToolTip(arrMenuToolTip.Count - 1)
                ReDim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1)
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                ReDim arrstrImagePaths(arrImagePaths.Count - 1)
                arrImagePaths.CopyTo(arrstrImagePaths)
                arrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                ReDim arrstrSeparator(arrSeparator.Count - 1) : arrSeparator.CopyTo(arrstrSeparator) : arrSeparator = Nothing
                'WAF3_PB_42 April 16, 2006 UmeshJ END
                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu, added parameter - arrstrImagePaths
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                ''Commented By Vaijat K ON 11/09/2017 For Plotting Buttons 
                'If m_blnIsDropdownMenuEnabled = False Then
                '    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, , , arrstrImagePaths)
                'Else
                '    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, "", "", arrstrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 130, arrstrSeparator) 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                'End If
                ''End Commented By Vaijat K ON 11/09/2017 For Plotting Buttons 
                arrstrSeparator = Nothing 'WAF3_PB_42 April 16, 2006 UmeshJ 
                'WAF3_PB_42 April 16, 2006 UmeshJ END
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - Set the arrays to nothing. 
                '-------------------------------------------------------------------------------------------------------------
                arrstrMenu = Nothing
                arrstrMenuToolTip = Nothing
                arrstrClientSideFunctions = Nothing
                arrstrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                '****************************************************************************************
                strMenu = ""

                'strMenu += "<div class='divBtn'>"
                'strMenu += "<button type='button' class='btn btn-primary btn-flat' onclick=Save_OnClick('CONST_ACTION_SAVE')>" & MyBase.GetResourceString("MENU_SAVE") & "</button>"
                'strMenu += "<button type='button' class='btn btn-primary btn-flat' onclick=Save_OnClick('CONST_ACTION_SAVE_AND_CLOSE')>" & MyBase.GetResourceString("MENU_SAVEANDCLOSE") & "</button>"
                'strMenu += "<button type='button' class='btn btn-primary btn-flat' onclick=SelectAll_OnClick()>" & MyBase.GetResourceString("MENU_SELECT_ALL") & "</button>"
                'strMenu += "<button type='button' class='btn btn-primary btn-flat' onclick=ClearAll_OnClick()>" & MyBase.GetResourceString("MENU_CLEAR_ALL") & "</button>"
                'strMenu += "<button type='button' class='btn btn-primary btn-flat' onclick=Close_OnClick()>" & MyBase.GetResourceString("MENU_CLOSE") & "</button>"
                'strMenu += "<button type='button' class='btn btn-primary btn-flat' onclick=Help_OnClick('312')>" & MyBase.GetResourceString("MENU_HELP") & "</button>"
                'strMenu += "</div>"

                strMenu += "<div class='all-req'>"
                strMenu += "<div class='dropdown' style='position:relative'>"
                strMenu += "<button class='btn btn-primary dropdown-toggle' type='button' data-toggle='dropdown'>Menu"
                strMenu += "<i><span class='caret'></span></i></button>"
                strMenu += "<ul class='dropdown-menu'>"
                strMenu += "<li><a  onclick=Save_OnClick('CONST_ACTION_SAVE')>" & MyBase.GetResourceString("MENU_SAVE") & "</a></li>"
                strMenu += "<li><a  onclick=Save_OnClick('CONST_ACTION_SAVE_AND_CLOSE')>" & MyBase.GetResourceString("MENU_SAVEANDCLOSE") & "</a></li>"
                strMenu += "<li><a  onclick=SelectAll_OnClick()>" & MyBase.GetResourceString("MENU_SELECT_ALL") & "</a></li>"
                strMenu += "<li><a onclick=ClearAll_OnClick()>" & MyBase.GetResourceString("MENU_CLEAR_ALL") & "</a></li>"
                strMenu += "<li><a onclick=Close_OnClick()>" & MyBase.GetResourceString("MENU_CLOSE") & "</a></li>"
                strMenu += "<li><a  onclick=Help_OnClick('312')>" & MyBase.GetResourceString("MENU_HELP") & "</a></li>"
                strMenu += "</ul>"
                strMenu += "</div>"
                strMenu += "</div>"

                'draw upper menu
                'Commented By Vaijat K ON 12/09/2017
                'General.WriteHTML(strMenu)
                'General.WriteHTML("<BR>")
                'End Commented By Vaijat K ON 12/09/2017
                'initialize the resource file for entityAccess page.
                MyBase.InitializeResources("Resources.RoleAccess", "Resources")

                'draw page caption with entity name
                'If m_strMode.ToUpper = CONST_GROUP_ACCESS Then
                '    'WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_GROUP_ACCESS") + "", "<B>" + MyBase.GetResourceString("CAP_GROUP") + " : </B>" + strRoleDesc.Trim)
                '    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_GROUP_ACCESS") + "", "<B>" + MyBase.GetResourceString("CAP_GROUP") + " : </B>" + Server.HtmlEncode(strRoleDesc.Trim), , True) 'Modified By ShrikantB on 19-Jun-2008 IssueID 20608 
                'Else
                '    'WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") + "", "<B>" + MyBase.GetResourceString("CAP_ROLE") + " : </B>" + strRoleDesc.Trim)
                '    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") + "", "<B>" + MyBase.GetResourceString("CAP_ROLE") + " : </B>" + Server.HtmlEncode(strRoleDesc.Trim),,True) 'Modified By ShrikantB on 19-Jun-2008 IssueID 20608 
                'End If
                Dim strHTML As New StringBuilder
                strHTML.Append("<div class=help-desk>")
                strHTML.Append("<div class=row>")
                strHTML.Append("<table style='width:98%;'>")
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
               
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                If m_strMode.ToUpper = CONST_GROUP_ACCESS Then
                    strHTML.Append("<label class='label label-info'>" & MyBase.GetResourceString("PAGE_CAPTION_GROUP_ACCESS") & "</label>")
                Else
                    strHTML.Append("<label class='label label-info'>" & MyBase.GetResourceString("PAGE_CAPTION") & "</label>")
                End If
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                strHTML.Append(strMenu)
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                If m_strMode.ToUpper = CONST_GROUP_ACCESS Then
                    strHTML.Append("<label class='label label-info'>" & MyBase.GetResourceString("CAP_GROUP") & " : " & Server.HtmlEncode(strRoleDesc.Trim) & "</label>")
                Else
                    strHTML.Append("<label class='label label-info'>" & MyBase.GetResourceString("CAP_ROLE") & " : " & Server.HtmlEncode(strRoleDesc.Trim) & "</label>")
                End If
                strHTML.Append("</td>")
                strHTML.Append("<td style='text-align:right;font-size:12px;'>")
                strHTML.Append(MyBase.GetResourceString("CAP_SELECTMODULE") + "&nbsp;")
                strHTML.Append("</td>")

 
                Dim strEditableTagList As String

                Dim objLink As WebPage.UI.cDynamicLink
             

                'get the Role name and editable tag list for the userAccessID from the database
                strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
                objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDr.Read Then
                    If Not IsDBNull(objDr("EditableTagList")) Then
                        strEditableTagList = objDr("EditableTagList").ToString + ""
                    Else
                        strEditableTagList = ""
                    End If
                End If
                objDr.Close()
                objDr.Dispose()
                objDr = Nothing

                'create link object
                objLink = New WebPage.UI.cDynamicLink()
                objLink.cssClass = ""
                objLink.ReturnHTML = True

                strHTML.Append("<TD align='right' nowrap>")

                'if page is called for group access then display only those 
                'modules which are group configurable else display all the modules.
                If m_strMode.ToUpper = CONST_ROLE_ACCESS Then
                    strSQL = "usp_Sel_Modules"
                ElseIf m_strMode.ToUpper = CONST_GROUP_ACCESS Then
                    strSQL = "usp_Sel_Modules '1'"
                End If
                
                strHTML.Append(HTMLControls.DrawComboBox("cboModule", strSQL, 230, m_strTemplateID, " onchange='javascript:Module_OnChange()'", False, True, "form-control") + "</TD>")
                
                If m_strMode <> CONST_GROUP_ACCESS Then
                    If m_strTemplateID <> "" Then
                        Dim strModuleTagID As String = ""
                        'get the moduleTagID of the module for the templateID
                        'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                        Dim objSystemModules As CommonEngines.HashTables.SystemModules
                        objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", m_strTemplateID.Trim)
                        strModuleTagID = objSystemModules.ModuleTagID.ToString
                        objSystemModules = Nothing
                        'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access

                        strSQL = "usp_sel_v_tbl_UI_Module_OtherLinks_SystemModuleGroup '" + strModuleTagID.Trim + "'"
                        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                        If objDR.Read Then
                            strHTML.Append("<TD align='right' >") 'Modified By Shrikant B On 16 Jan 2009 For Issue ID 26606
                            objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
                            objLink.LinkName = MyBase.GetResourceString("LINK_OTHERLINK_ACCESS") + ""
                            objLink.Tooltip = MyBase.GetResourceString("LINK_OTHERLINK_ACCESS_TOOLTIP") + ""
                            objLink.FunctionName = "OtherLink_OnClick()"
                            strHTML.Append(" | " + objLink.GetDynamicLink() + " | ")
                            objLink.LinkStyle = ""
                            strHTML.Append("</TD>") 'Modified By Shrikant B On 16 Jan 2009 For Issue ID 26606
                        End If
                        Data.DisposeDataReader(objDR)
                    End If
                End If
                strHTML.Append("</tr>")
                strHTML.Append("</table>")
                strHTML.Append("</div>")
                strHTML.Append("</div>")

                General.WriteHTML(strHTML.ToString())
                'General.WriteHTML(strMenu)
                'General.WriteHTML("<BR>")

                'draw the grid 
                Call plotGrid(m_strTemplateID)


            Case CONST_SUBNODE_ACCESS, CONST_SUBNODE_ACCESS_GROUP

                If strAction <> "" Then
                    Call performSubnodeAction(strAction, m_lngUserAccessID)
                End If

                '****************************************************************************************
                'Initialize the standard menu class of resource assebmbly
                MyBase.InitializeResources("Resources.StandardMenu", "Resources")
                'create menu for role list 
                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths = New System.Collections.ArrayList
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                arrSeparator = New System.Collections.ArrayList 'WAF3_PB_42 April 16, 2007 UmeshJ 
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                'Reason   - Role Access page was showing Save link even if the user with specified role has only view access.
                '-------------------------------------------------------------------------------------------------------------
                If m_blnIsAdmin OrElse (m_objAccess.Add Or m_objAccess.Edit Or m_objAccess.Delete) Then
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                    '-------------------------------------------------------------------------------------------------------------

                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick('CONST_ACTION_SAVE')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick('CONST_ACTION_SAVE_AND_CLOSE')") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrMenu.Add(MyBase.GetResourceString("MENU_SELECT_ALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELET_ALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLEAR_ALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP")) : arrClientSideFunctions.Add("ClearAll_OnClick()")

                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrImagePaths.Add("../../Images/cssImages/Link images/save.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/saveclose.gif") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrImagePaths.Add("../../Images/cssImages/Link images/selectall.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/clearall.gif")
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    '-------------------------------------------------------------------------------------------------------------
                    arrSeparator.Add(False) : arrSeparator.Add(True) : arrSeparator.Add(False) : arrSeparator.Add(True)  'WAF3_PB_42 April 16, 2007 UmeshJ  ,'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                End If
                'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF

                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('312')")

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths.Add("../../Images/cssImages/Link images/close.gif")
                arrImagePaths.Add("../../Images/cssImages/Link images/help.gif")
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator.Add(True) : arrSeparator.Add(False)  'WAF3_PB_42 April 16, 2007 UmeshJ  

                'copy all the element to string array
                ReDim arrstrMenu(arrMenu.Count - 1)
                ReDim arrstrMenuToolTip(arrMenuToolTip.Count - 1)
                ReDim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1)
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing


                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                ReDim arrstrImagePaths(arrImagePaths.Count - 1)
                arrImagePaths.CopyTo(arrstrImagePaths)
                arrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                ReDim arrstrSeparator(arrSeparator.Count - 1) : arrSeparator.CopyTo(arrstrSeparator) : arrSeparator = Nothing
                'WAF3_PB_42 April 16, 2006 UmeshJ END

                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu, added parameter - arrstrImagePaths
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                If m_blnIsDropdownMenuEnabled = False Then
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, , , arrstrImagePaths)
                Else
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, "", "", arrstrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 130, arrstrSeparator) 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                End If
                arrstrSeparator = Nothing 'WAF3_PB_42 April 16, 2006 UmeshJ 
                'WAF3_PB_42 April 16, 2006 UmeshJ END
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - Set the arrays to nothing. 
                '-------------------------------------------------------------------------------------------------------------
                arrstrMenu = Nothing
                arrstrMenuToolTip = Nothing
                arrstrClientSideFunctions = Nothing
                arrstrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------


                '****************************************************************************************

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")
                'initialize the resource file for entityAccess page.
                MyBase.InitializeResources("Resources.RoleAccess", "Resources")

                'draw page caption with entity name
                If m_strMode.ToUpper = CONST_SUBNODE_ACCESS_GROUP Then
                    ' WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_GROUP_ACCESS") + "", "<B>" + MyBase.GetResourceString("CAP_GROUP") + " : </B>" + strRoleDesc.Trim)
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_GROUP_ACCESS") + "", "<B>" + MyBase.GetResourceString("CAP_GROUP") + " : </B>" + Server.HtmlEncode(strRoleDesc.Trim)) 'Modified By ShrikantB on 19 June 2008 IssueID 20608 
                Else
                    ' WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") + "", "<B>" + MyBase.GetResourceString("CAP_ROLE") + " : </B>" + strRoleDesc.Trim)
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION") + "", "<B>" + MyBase.GetResourceString("CAP_ROLE") + " : </B>" + Server.HtmlEncode(strRoleDesc.Trim)) 'Modified By Shrikant B on 19 June 2008 IssueID 20608 
                End If
                General.WriteHTML("<BR>")

                'draw the grid 
                Call plotSubnodeGrid(m_lngTagID, m_lngUserAccessID)

            Case CONST_TAG_ACCESS

                If strAction <> "" Then
                    Call performSingleTagAction(strAction, m_lngTagID, m_lngUserAccessID)
                End If

                '****************************************************************************************
                'Initialize the standard menu class of resource assebmbly
                MyBase.InitializeResources("Resources.StandardMenu", "Resources")
                'create menu for role list 
                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths = New System.Collections.ArrayList
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator = New System.Collections.ArrayList 'WAF3_PB_42 April 16, 2007 UmeshJ 
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                'Reason   - Role Access page was showing Save link even if the user with specified role has only view access.
                '-------------------------------------------------------------------------------------------------------------
                If m_blnIsAdmin OrElse (m_objAccess.Add Or m_objAccess.Edit Or m_objAccess.Delete) Then
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                    '-------------------------------------------------------------------------------------------------------------
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("TagSave_OnClick('CONST_ACTION_SAVE')") 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE_TOOLTIP")) : arrClientSideFunctions.Add("TagSave_OnClick('CONST_ACTION_SAVE_AND_CLOSE')") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrImagePaths.Add("../../Images/cssImages/Link images/save.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/saveclose.gif") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    '-------------------------------------------------------------------------------------------------------------
                    arrSeparator.Add(False) : arrSeparator.Add(True)  'WAF3_PB_42 April 16, 2007 UmeshJ  ,'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                End If
                'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF


                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('312')")

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths.Add("../../Images/cssImages/Link images/close.gif")
                arrImagePaths.Add("../../Images/cssImages/Link images/help.gif")
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator.Add(True) : arrSeparator.Add(False)  'WAF3_PB_42 April 16, 2007 UmeshJ  
                'copy all the element to string array
                ReDim arrstrMenu(arrMenu.Count - 1)
                ReDim arrstrMenuToolTip(arrMenuToolTip.Count - 1)
                ReDim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1)
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                ReDim arrstrImagePaths(arrImagePaths.Count - 1)
                arrImagePaths.CopyTo(arrstrImagePaths)
                arrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                ReDim arrstrSeparator(arrSeparator.Count - 1) : arrSeparator.CopyTo(arrstrSeparator) : arrSeparator = Nothing
                'WAF3_PB_42 April 16, 2006 UmeshJ END

                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu, added parameter - arrstrImagePaths
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                If m_blnIsDropdownMenuEnabled = False Then
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, , , arrstrImagePaths)
                Else
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, "", "", arrstrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 130, arrstrSeparator) 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                End If
                arrstrSeparator = Nothing 'WAF3_PB_42 April 16, 2006 UmeshJ 
                'WAF3_PB_42 April 16, 2006 UmeshJ END
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - Set the arrays to nothing. 
                '-------------------------------------------------------------------------------------------------------------
                arrstrMenu = Nothing
                arrstrMenuToolTip = Nothing
                arrstrClientSideFunctions = Nothing
                arrstrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                '****************************************************************************************

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for entityAccess page.
                MyBase.InitializeResources("Resources.RoleAccess", "Resources")

                'get the parent tag name to display it 
                strSQL = "usp_sel_tbl_UI_TagMaster " + m_lngTagID.ToString
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then
                    If Not IsDBNull(objDR("TagDescription")) Then
                        strTagName = objDR("TagDescription").ToString + ""
                    Else
                        strTagName = ""
                    End If
                End If
                objDR.Close()
                objDR.Dispose()
                objDR = Nothing

                'draw page caption with Tag name
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_NODE") + "", "<B>" + MyBase.GetResourceString("CAP_PARENT_TAG") + " : </B>" + strTagName.Trim)
                General.WriteHTML("<BR>")

                'draw the grid 
                Call plotSingleTagGrid(m_lngTagID, m_lngUserAccessID)

                'refresh the parent window
                If strAction <> "" Then
                    General.WriteHTML("<Script language=javascript>")
                    'Modified by SachinR    on 18 Nov 2004
                    'Issue Id   13839
                    ' Modified Rajanikant Khethawatt Dec 31 2004
                    ' Send the template ID to be persisted on the parent after refresh  

                    General.WriteHTML("try {") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                    'General.WriteHTML("opener.location.href='RoleAccess.aspx?ModuleID=" + m_strTemplateID + "&Mode=" + CONST_ROLE_ACCESS + "&RoleID=" + m_lngUserAccessID.ToString + "&MasterTagID=" + m_strMasterTagID + "&FromWhere=" + m_strFromWhere + "&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1';")
                    General.WriteHTML("RefreshParent();")
                    General.WriteHTML("} catch(e) { } ") 'Added by Vinay on 11 DEC. 2008 WAF3_GEN_18
                    ' End Modification Dec 31,2004
                    'modification end
                    General.WriteHTML("</Script>")
                End If

            Case CONST_INHERIT_ACCESS, CONST_INHERIT_ACCESS_GROUP

                Dim strSourceRole As String
                Dim strDestinationRole As String

                If strAction <> "" Then

                    strSourceRole = MyBase.FixString(MyBase.GetFormValue("cboSourceRole"), 9, True, True) + ""
                    strDestinationRole = MyBase.FixString(MyBase.GetFormValue("cboDestinationRole"), 9, True, True) + ""

                    If strSourceRole <> "" And strDestinationRole <> "" Then
                        'update data base to transfer role access
                        strSQL = "usp_Upd_tbl_UserAccess_InheritRoleAccess " + strSourceRole.Trim + "," + strDestinationRole.Trim
                        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                        'UJ_12052006 Issue ID: 128
                        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()

                        'clear the hashtable entries for all the user who have selected role.
                        If UCase(m_strMode) = CONST_INHERIT_ACCESS Then
                            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'R','" + m_strTemplateID.Trim + "'," + strDestinationRole.ToString)
                        ElseIf UCase(m_strMode) = CONST_INHERIT_ACCESS_GROUP Then
                            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'U',null,null,null,null," + strDestinationRole.ToString)
                        End If
                        'UJ_12052006 Issue ID: 128

                    End If

                End If

                '****************************************************************************************
                'Initialize the standard menu class of resource assebmbly
                MyBase.InitializeResources("Resources.StandardMenu", "Resources")
                'create menu for role list 
                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths = New System.Collections.ArrayList
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator = New System.Collections.ArrayList 'WAF3_PB_42 April 16, 2007 UmeshJ 
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                'Reason   - Role Access page was showing Save link even if the user with specified role has only view access.
                '-------------------------------------------------------------------------------------------------------------
                If m_blnIsAdmin OrElse (m_objAccess.Add Or m_objAccess.Edit Or m_objAccess.Delete) Then
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                    '-------------------------------------------------------------------------------------------------------------

                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("InheritSave_OnClick('CONST_ACTION_SAVE')") 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE_TOOLTIP")) : arrClientSideFunctions.Add("InheritSave_OnClick('CONST_ACTION_SAVE_AND_CLOSE')") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    'Reason   - To show Images for static menu. 
                    '-------------------------------------------------------------------------------------------------------------
                    arrImagePaths.Add("../../Images/cssImages/Link images/save.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/saveclose.gif") 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                    '-------------------------------------------------------------------------------------------------------------
                    arrSeparator.Add(False) : arrSeparator.Add(True)  'WAF3_PB_42 April 16, 2007 UmeshJ  ,Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                    'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
                End If
                'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF

                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('312')")
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                arrImagePaths.Add("../../Images/cssImages/Link images/close.gif")
                arrImagePaths.Add("../../Images/cssImages/Link images/help.gif")
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                arrSeparator.Add(True) : arrSeparator.Add(False)  'WAF3_PB_42 April 16, 2007 UmeshJ  
                'copy all the element to string array
                ReDim arrstrMenu(arrMenu.Count - 1)
                ReDim arrstrMenuToolTip(arrMenuToolTip.Count - 1)
                ReDim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1)
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu. 
                '-------------------------------------------------------------------------------------------------------------
                ReDim arrstrImagePaths(arrImagePaths.Count - 1)
                arrImagePaths.CopyTo(arrstrImagePaths)
                arrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                ReDim arrstrSeparator(arrSeparator.Count - 1) : arrSeparator.CopyTo(arrstrSeparator) : arrSeparator = Nothing
                'WAF3_PB_42 April 16, 2006 UmeshJ END

                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - To show Images for static menu, added parameter - arrstrImagePaths
                '-------------------------------------------------------------------------------------------------------------
                'WAF3_PB_42 April 16, 2006 UmeshJ START
                If m_blnIsDropdownMenuEnabled = False Then
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, , , arrstrImagePaths)
                Else
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, "", "", arrstrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 130, arrstrSeparator) 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                End If
                arrstrSeparator = Nothing 'WAF3_PB_42 April 16, 2006 UmeshJ 
                'WAF3_PB_42 April 16, 2006 UmeshJ END
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                'Reason   - Set the arrays to nothing. 
                '-------------------------------------------------------------------------------------------------------------
                arrstrMenu = Nothing
                arrstrMenuToolTip = Nothing
                arrstrClientSideFunctions = Nothing
                arrstrImagePaths = Nothing
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Tuesday, July 18, 2006 For Req. ID. -  WAF3_GEN_7
                '-------------------------------------------------------------------------------------------------------------

                '****************************************************************************************

                'draw upper menu
                General.WriteHTML(strMenu)
                '-------------------------------------------------------------------------------------------------------------
                'Added By Shrikant B On 18 Aug 2008 For Issue ID 21889 To Draw Legend
                CommonFunction.General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend))
                arrLegend = Nothing
                arrLegendImage = Nothing
                'Addition End By Shrikant B On 18 Aug 2008 For Issue ID 21889 To Draw Legend
                '-------------------------------------------------------------------------------------------------------------

                'initialize the resource file for entityAccess page.
                MyBase.InitializeResources("Resources.RoleAccess", "Resources")

                'draw page caption with entity name
                If m_strMode.ToUpper = CONST_INHERIT_ACCESS Then
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_INHERIT_ROLE") + "")
                Else
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_INHERIT_GROUP") + "")
                End If
                General.WriteHTML("<BR>")

                'plot the screen
                Call plotInheritRoleAccessScreen()
                'Added By Ninad on 10 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
            Case CONST_TABCOLLECTION_ROLE_ACCESS, CONST_TABCOLLECTION_GROUP_ACCESS
                If strAction <> "" Then
                    Call PerformTabCollectionAction(m_lngUserAccessID)
                End If
                'Initialize the standard menu class of resource assebmbly
                MyBase.InitializeResources("Resources.StandardMenu", "Resources")
                'create menu for role list 
                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList
                arrImagePaths = New System.Collections.ArrayList
                arrSeparator = New System.Collections.ArrayList

                If m_blnIsAdmin OrElse (m_objAccess.Add Or m_objAccess.Edit Or m_objAccess.Delete) Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick('CONST_ACTION_SAVE')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVEANDCLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick('CONST_ACTION_SAVE_AND_CLOSE')")
                    arrMenu.Add(MyBase.GetResourceString("MENU_SELECT_ALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SELET_ALL_TOOLTIP")) : arrClientSideFunctions.Add("SelectAll_OnClick()")
                    arrMenu.Add(MyBase.GetResourceString("MENU_CLEAR_ALL")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLEAR_ALL_TOOLTIP")) : arrClientSideFunctions.Add("ClearAll_OnClick()")

                    arrImagePaths.Add("../../Images/cssImages/Link images/save.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/saveclose.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/selectall.gif")
                    arrImagePaths.Add("../../Images/cssImages/Link images/clearall.gif")
                    arrSeparator.Add(False) : arrSeparator.Add(True) : arrSeparator.Add(False) : arrSeparator.Add(True)
                End If

                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('312')")

                arrImagePaths.Add("../../Images/cssImages/Link images/close.gif")
                arrImagePaths.Add("../../Images/cssImages/Link images/help.gif")
                arrSeparator.Add(True) : arrSeparator.Add(False)

                'copy all the element to string array
                ReDim arrstrMenu(arrMenu.Count - 1)
                ReDim arrstrMenuToolTip(arrMenuToolTip.Count - 1)
                ReDim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1)
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing
                ReDim arrstrImagePaths(arrImagePaths.Count - 1)
                arrImagePaths.CopyTo(arrstrImagePaths)
                arrImagePaths = Nothing

                ReDim arrstrSeparator(arrSeparator.Count - 1) : arrSeparator.CopyTo(arrstrSeparator) : arrSeparator = Nothing

                If m_blnIsDropdownMenuEnabled = False Then
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, , , arrstrImagePaths)
                Else
                    strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True, "", "", arrstrImagePaths, WebPages.Template.StaticMenu.DynamicAction_NavigationSchema.DROPDOWN, 130, arrstrSeparator) 'Modified By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                End If
                arrstrSeparator = Nothing
                arrstrMenu = Nothing
                arrstrMenuToolTip = Nothing
                arrstrClientSideFunctions = Nothing
                arrstrImagePaths = Nothing

                'draw upper menu
                General.WriteHTML(strMenu)
                General.WriteHTML("<BR>")

                'initialize the resource file for entityAccess page.
                MyBase.InitializeResources("Resources.RoleAccess", "Resources")

                'draw page caption with entity name
                If m_strMode.ToUpper = CONST_TABCOLLECTION_GROUP_ACCESS Then
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_TABCOLLECTION") + "", "<B>" + MyBase.GetResourceString("CAP_GROUP") + " : </B>" + Server.HtmlEncode(strRoleDesc.Trim))
                Else
                    WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_TABCOLLECTION") + "", "<B>" + MyBase.GetResourceString("CAP_ROLE") + " : </B>" + Server.HtmlEncode(strRoleDesc.Trim))
                End If
                General.WriteHTML("<BR>")

                'draw the grid 
                Call PlotTabCollectionGrid()
                If strAction <> "" Then
                    General.WriteHTML("<Script language=javascript>")
                    ' Send the template ID to be persisted on the parent after refresh  
                    General.WriteHTML("try {")
                    'General.WriteHTML("opener.location.href=opener.location.href;")
                    General.WriteHTML("RefreshParent();")
                    General.WriteHTML("} catch(e) { } ")
                    General.WriteHTML("</Script>")
                End If
                'End Addition By Ninad on 10 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
            Case Else
                General.WriteHTML("<Div id='DivList'></Div>")
        End Select
        'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
        If strAction = CONST_ACTION_SAVE_AND_CLOSE Then
            Response.Write("<script>window.close(); </script>")
        End If
        'End Addition By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
        'plot the bottom menu
        'WAF3_PB_42 April 16, 2006 UmeshJ START
        If m_blnIsDropdownMenuEnabled = False Then
            General.WriteHTML("<BR>")
            'General.WriteHTML(strMenu)
        End If
        'WAF3_PB_42 April 16, 2006 UmeshJ ENDB

        'Added By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF
        If Not m_blnIsAdmin Then
            ClearGlobalObjects()
        End If
        'Addition Ends By - PushkarK On - Monday, June 19, 2006 For Hotfix ID. - 2.0.15-SP4-WAF


    End Sub

    '=====================================================================
    ' Procedure Name		:	plotGrid
    ' Parameters Passed		:	strTemplateID - string - Template ID 
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the grid of tag and subtag list and Access type check boxes
    ' Description			:	This procedure will plot the grid of Tag and subtag for the tag for the selected
    '                           module. Here grid class is not used, as grid class doesnt support the 
    '                           requirements so grid is plotted manually with check boxes for access types.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 16 2004
    ' Revisions				:	By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
    ' Revisions				:	By Ninad on 18 May 2009 IssueID-30417
    '=====================================================================
    Private Sub plotGrid(ByVal strTemplateID As String)
        Dim strSQL As String
        Dim objDrParent As IDataReader
        Dim objDrSubTag As IDataReader
        Dim objDr As IDataReader
        Dim lngTagID As Long
        Dim lngSubTagID As Long
        Dim blnAdd As Boolean
        Dim blnEdit As Boolean
        Dim blnDelete As Boolean
        Dim blnView As Boolean
        Dim blnAccess As Boolean
        Dim strModuleName As String = ""
        Dim strEditableTagList As String
        Dim blnCheckboxDisabled As Boolean
        Dim objLink As WebPage.UI.cDynamicLink
        Dim intCnter As Integer
        Dim intRowCount As Integer
        Dim intTRCount As Integer 'Added By Ninad on 18 May 2009 IssueID-30417
        Dim blnIsParent As Boolean

        'get the Role name and editable tag list for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("EditableTagList")) Then
                strEditableTagList = objDr("EditableTagList").ToString + ""
            Else
                strEditableTagList = ""
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'create link object
        objLink = New WebPage.UI.cDynamicLink()
        objLink.cssClass = ""
        objLink.ReturnHTML = True

        'display the role name and module name list combo
        'Commented And Added By Vaijat K ON 11/09/2017 For Table Style


        'General.WriteHTML("<Table class='clsGridTable' width='100%' cellspacing=1 cellpading=0>")
        ''End Commented And Added By Vaijat K ON 11/09/2017 For Table Style
        'General.WriteHTML("<TR class='clsTREven'>")
        'General.WriteHTML("<TD align='right' nowrap>")
        'General.WriteHTML(MyBase.GetResourceString("CAP_SELECTMODULE") + "&nbsp;")
        ''if page is called for group access then display only those 
        ''modules which are group configurable else display all the modules.
        'If m_strMode.ToUpper = CONST_ROLE_ACCESS Then
        '    strSQL = "usp_Sel_Modules"
        'ElseIf m_strMode.ToUpper = CONST_GROUP_ACCESS Then
        '    strSQL = "usp_Sel_Modules '1'"
        'End If
        ' ''Commented And Added By Vaijat K ON 11/09/2017 For Combobox Style
        ' ''General.WriteHTML(HTMLControls.DrawComboBox("cboModule", strSQL, 250, m_strTemplateID, " onchange='javascript:Module_OnChange()'", False, True) + "</TD>")
        'General.WriteHTML(HTMLControls.DrawComboBox("cboModule", strSQL, 250, m_strTemplateID, " onchange='javascript:Module_OnChange()'", False, True, "form-control") + "</TD>")
        ' ''End of Commented And Added By Vaijat K ON 11/09/2017 For Combobox Style
        ''display link to configure the links of the group(Page) in the module
        ''Modified by   :   SachinR     On  14 Apr 2004

        'If m_strMode <> CONST_GROUP_ACCESS Then
        '    If m_strTemplateID <> "" Then
        '        Dim strModuleTagID As String = ""
        '        'get the moduleTagID of the module for the templateID
        '        'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        '        Dim objSystemModules As CommonEngines.HashTables.SystemModules
        '        objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", m_strTemplateID.Trim)
        '        strModuleTagID = objSystemModules.ModuleTagID.ToString
        '        objSystemModules = Nothing
        '        'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access

        '        strSQL = "usp_sel_v_tbl_UI_Module_OtherLinks_SystemModuleGroup '" + strModuleTagID.Trim + "'"
        '        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        '        If objDr.Read Then
        '            General.WriteHTML("<TD align='right' >") 'Modified By Shrikant B On 16 Jan 2009 For Issue ID 26606
        '            objLink.LinkStyle = "FONT-WEIGHT: bold; TEXT-DECORATION: none"
        '            objLink.LinkName = MyBase.GetResourceString("LINK_OTHERLINK_ACCESS") + ""
        '            objLink.Tooltip = MyBase.GetResourceString("LINK_OTHERLINK_ACCESS_TOOLTIP") + ""
        '            objLink.FunctionName = "OtherLink_OnClick()"
        '            General.WriteHTML(" | " + objLink.GetDynamicLink() + " | ")
        '            objLink.LinkStyle = ""
        '            General.WriteHTML("</TD>") 'Modified By Shrikant B On 16 Jan 2009 For Issue ID 26606
        '        End If
        '        Data.DisposeDataReader(objDr)
        '    End If
        'End If

        'General.WriteHTML("</TR></Table>")
        'Modification end


        'display table
        '******************************************************************************************
        General.WriteHTML("<BR>")
        General.WriteHTML("<Div id='DivList' style='overflow: auto;' width='100%' height='90%' >")
        'Added By NileshD on 17 Jan 2006 REQID: WAF3_PB_14
        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsStaticHeaderStyle"), "ON")) = "ON" Then
            CommonFunction.General.WriteHTML(CommonFunctions.General.PlotStaticHeaderStyle("DivList"))
        End If
        'End Of Addition By NileshD on 17 Jan 2006 REQID: WAF3_PB_14
        General.WriteHTML("<Table class='clsGridTable' width=100% cellspacing=1 cellpadding=0>")

        'display column headers
        'Added By NileshD on 17 Jan 2006 REQID: WAF3_PB_14
        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsStaticHeaderStyle"), "ON")) = "ON" Then
            General.WriteHTML("<THead class='clsTRColumnHeader'>")
            General.WriteHTML("<TH class='DivList' align=left>" + MyBase.GetResourceString("COL_ACCESSIBLE_COMPONENTS") + "</TH>")
            'General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_TAB_COLL") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_SUBTAG") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_ACCESS") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_ADD") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_EDIT") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_DELETE") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center>" + MyBase.GetResourceString("COL_VIEW") + "</TH>")
            General.WriteHTML("</THead>")
        Else
            General.WriteHTML("<TR class='clsTRColumnHeader'>")
            General.WriteHTML("<TD align=left>" + MyBase.GetResourceString("COL_ACCESSIBLE_COMPONENTS") + "</TD>")
            'General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_TAB_COLL") + "</TD>")
            General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_SUBTAG") + "</TD>")
            General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ACCESS") + "</TD>")
            General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ADD") + "</TD>")
            General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_EDIT") + "</TD>")
            General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_DELETE") + "</TD>")
            General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_VIEW") + "</TD>")
            General.WriteHTML("</TR>")
        End If
        'End Of Addition By NileshD on 17 Jan 2006 REQID: WAF3_PB_14

        'start displaying the data
        strSQL = "usp_Sel_tbl_UI_TagMaster_AllParents " + m_strTemplateID.Trim
        'Added By Ninad on 19 May 2009 IssueID-30432
        If General.GetFrameworkSettings("PB_DO_NOT_SHOW_SYSTEM_WEB_FORMS_IN_ROLE_ACCESS", "Enabled") Then
            strSQL += ",0"
        End If
        'End Addition By Ninad on 19 May 2009 IssueID-30432
        objDrParent = Data.GetDataReader(strSQL, MyBase.UseSQL)

        intRowCount = 0
        intTRCount = 0
        Dim objhtTagMaster As CommonEngines.HashTables.UITagMaster 'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        Dim objhtSubTagMaster As CommonEngines.HashTables.SubUITagMaster() 'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        While objDrParent.Read
            If Not IsDBNull(objDrParent("ModuleID")) Then
                strModuleName = objDrParent("ModuleDescription").ToString + ""
            Else
                strModuleName = ""
            End If
            If Not IsDBNull(objDrParent("TagID")) Then
                lngTagID = CType(objDrParent("TagID"), Long)
            Else
                lngTagID = 0
            End If

            General.WriteHTML("<TR class='clsTRSectionHeader'>")

            General.WriteHTML("<TD align=left><B>" + strModuleName.Trim + "</B></TD>")

            'check if user has access to Tag
            blnCheckboxDisabled = False
            If (UserHasAccessToTag(lngTagID, strEditableTagList)) Then
                blnAccess = True
                blnCheckboxDisabled = False
            Else
                blnAccess = False
                blnCheckboxDisabled = True
            End If
            'dont display the configure Tab Collection link for parent tag.
            'General.WriteHTML("<TD align='left'>&nbsp;</TD>")
            'dont display the configure subtag link for parent tag.
            General.WriteHTML("<TD aline='left'></TD>")
            intRowCount += 1 'Modified By Ninad on 18 May 2009 IssueID-30417
            intTRCount += 1 'Modified By Ninad on 18 May 2009 IssueID-30417
            'if it is ShowAccessLinks flag is on then only show Add.Edit,Delete,View checkboxes for the tag.
            If CType(objDrParent("ShowAccessLinks"), Boolean) = True Then

                'get all the Access (Add,Edit,Delete,View) for the tag
                'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                Dim blnValues As Boolean()
                blnValues = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_lngRoleID.ToString + "-0-" + lngTagID.ToString)
                If Not blnValues Is Nothing Then
                    blnAdd = blnValues(0)
                    blnEdit = blnValues(1)
                    blnDelete = blnValues(2)
                    blnView = blnValues(3)
                Else
                    blnAdd = False
                    blnEdit = False
                    blnDelete = False
                    blnView = False
                End If
                'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access

                ''Commented And Added By Vaijat K ON 11/09/2017 For Changing checkbox style
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ",event)", True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")


                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess" & lngTagID, "regular-checkbox", blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(event," + intTRCount.ToString + ")", True) + "<label for='chkAccess" & lngTagID & "'></label></TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd" & lngTagID, "regular-checkbox", blnAdd, lngTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkAdd" & lngTagID & "'></label></TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit" & lngTagID, "regular-checkbox", blnEdit, lngTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkEdit" & lngTagID & "'></label></TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete" & lngTagID, "regular-checkbox", blnDelete, lngTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkDelete" & lngTagID & "'></label></TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView" & lngTagID, "regular-checkbox", blnView, lngTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkView" & lngTagID & "'></label></TD>")

                ''End of Commented And Added By Vaijat K ON 11/09/2017 For Changing checkbox style


                General.WriteHTML("</TR>")
            Else

                'Commented by swapnil aswale on 10th sep 2015
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess" + intTRCount.ToString, "chkAccess" + intTRCount.ToString, , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(event)", True) + "</TD>") 'Modified By Ninad on 18 May 2009 IssueID-30417
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(event," + intTRCount.ToString + ")", True) + "</TD>") 'Modified By Ninad on 18 May 2009 IssueID-30417
                'Added by swapnil aswale on 10th sep 2015
                ''Commented And Added By Vaijat K ON 11/09/2017 For Changing checkbox style

                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ",event)", True) + "</TD>")
                ''Ended
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , , "", True, , True, , , , True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , , "", True, , True, , , , True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , , "", True, , True, , , , True) + "</TD>")
                'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView", , , "", True, , True, , , , True) + "</TD>")


                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess" & lngTagID, "regular-checkbox", blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ")", True) + "<label for='chkAccess" & lngTagID & "'></label></TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd", "regular-checkbox", , "", True, , True, , , , True) + "</TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit", "regular-checkbox", , "", True, , True, , , , True) + "</TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete", "regular-checkbox", , "", True, , True, , , , True) + "</TD>")
                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView", "regular-checkbox", , "", True, , True, , , , True) + "</TD>")


                ''End of Commented And Added By Vaijat K ON 11/09/2017 For Changing checkbox style

                General.WriteHTML("</TR>")
            End If

            'display the Subtag list
            If strModuleName = "" Then
                strSQL = "EXEC usp_Sel_UserAccessControls Null," + lngTagID.ToString
            Else
                strSQL = "EXEC usp_Sel_UserAccessControls '" + strTemplateID.Trim + "'," + lngTagID.ToString
            End If
            'Added By Ninad on 19 May 2009 IssueID-30432
            If General.GetFrameworkSettings("PB_DO_NOT_SHOW_SYSTEM_WEB_FORMS_IN_ROLE_ACCESS", "Enabled") Then
                strSQL += ",0"
            End If
            'End Addition By Ninad on 19 May 2009 IssueID-30432
            objDrSubTag = Data.GetDataReader(strSQL, MyBase.UseSQL)

            intCnter = 1
            While objDrSubTag.Read

                If Not IsDBNull(objDrSubTag("TagID")) Then
                    lngSubTagID = CType(objDrSubTag("TagID"), Long)
                End If

                'get the tag info
                objhtTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngSubTagID)
                If Not objhtTagMaster Is Nothing AndAlso objhtTagMaster.ModuleIdentifier.Trim.ToUpper <> "R" Then 'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                    'if the tag is parent tag then dont show 
                    blnIsParent = objhtTagMaster.IsParent
                    If blnIsParent = False Then
                        If (UserHasAccessToTag(lngSubTagID, strEditableTagList)) Then
                            blnAccess = True
                            blnCheckboxDisabled = False
                        Else
                            blnAccess = False
                            blnCheckboxDisabled = True
                        End If

                        If intCnter Mod 2 <> 0 Then
                            General.WriteHTML("<TR class='clsTROdd' id='chkAccess" + intTRCount.ToString + "TR' name='chkAccess" + intTRCount.ToString + "TR' >") 'Modified By Ninad on 18 May 2009 IssueID-30417
                        Else
                            General.WriteHTML("<TR class='clsTREvenRow' id='chkAccess" + intTRCount.ToString + "TR' name='chkAccess" + intTRCount.ToString + "TR' >") 'Modified By Ninad on 18 May 2009 IssueID-30417
                        End If

                        'display the link in the first column depending on the blnAccess
                        If blnAccess = True AndAlso Not CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngSubTagID) Then
                            objLink.LinkName = strModuleName.Trim + "-->" + objDrSubTag("ModuleDescription").ToString + ""
                            objLink.FunctionName = "Link_OnClick('" + lngTagID.ToString + "','" + lngSubTagID.ToString + "')"
                            objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
                            General.WriteHTML("<TD align='left'>" + objLink.GetDynamicLink() + "</TD>")
                        Else
                            General.WriteHTML("<TD align='left'>" + strModuleName.Trim + "-->" + objDrSubTag("ModuleDescription").ToString + "</TD>")
                        End If
                        ''Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
                        'If CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngSubTagID) AndAlso blnAccess = True Then
                        '    objLink.LinkName = MyBase.GetResourceString("COL_TABCOLL_LINK") + ""
                        '    objLink.FunctionName = "ConfigureTabCollection_OnClick('" + lngSubTagID.ToString + "','" + strTemplateID + "')"
                        '    objLink.Tooltip = MyBase.GetResourceString("COL_TABCOLL_LINK") + ""
                        '    General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")
                        'Else
                        '    General.WriteHTML("<TD align='center'>&nbsp;</TD>")
                        'End If
                        ''End Addition By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement

                        'check if tag has subtag and display link accordingly in the second column
                        'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                        objhtSubTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(lngSubTagID)
                        If Not objhtSubTagMaster Is Nothing AndAlso blnAccess = True Then
                            'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                            objLink.LinkName = MyBase.GetResourceString("COL_SUBTAG_LINK") + ""
                            objLink.FunctionName = "ConfigureSubtag_OnClick('" + lngSubTagID.ToString + "')"
                            objLink.Tooltip = MyBase.GetResourceString("COL_SUBTAG_LINK_TOOLTIP") + ""
                            General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")
                        Else
                            General.WriteHTML("<TD align='center'>&nbsp;</TD>")
                        End If
                        'get all the Access (Add,Edit,Delete,View) for the tag
                        Dim blnValues As Boolean()
                        blnValues = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_lngRoleID.ToString + "-0-" + lngSubTagID.ToString)
                        If Not blnValues Is Nothing Then
                            blnAdd = blnValues(0)
                            blnEdit = blnValues(1)
                            blnDelete = blnValues(2)
                            blnView = blnValues(3)
                            'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
                        Else
                            blnAdd = False
                            blnEdit = False
                            blnDelete = False
                            blnView = False
                        End If

                        'display the check boxes
                        ''Commented and Modified by swapnil aswale on 01-Oct-2015 Purpose:Initiative issue fixing
                        ''General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(event,'')", True))

                        'Commented And Added By Vaijat K ON 11/09/2017 For CheckBox Style
                        'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ",event)", True))
                        General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess" & lngSubTagID.ToString, "regular-checkbox", blnAccess, lngSubTagID.ToString, , "onclick=javascript:Access_OnClick(" + intRowCount.ToString + ",event)", True) & "<label for='chkAccess" & lngSubTagID.ToString & "'></label></TD>")
                        'End Commented And Added By Vaijat K ON 11/09/2017 For CheckBox Style

                        ''End of Commented and Modified by swapnil aswale on 01-Oct-2015 Purpose:Initiative issue fixing
                        'Added By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
                        If CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngSubTagID) Then
                            General.WriteHTML("<TD colspan=4 align='center'>")
                            If blnAccess = True Then
                                objLink.LinkName = MyBase.GetResourceString("COL_TABCOLL_LINK") + ""
                                objLink.FunctionName = "ConfigureTabCollection_OnClick('" + lngSubTagID.ToString + "','" + strTemplateID + "')"
                                objLink.Tooltip = MyBase.GetResourceString("COL_TABCOLL_LINK") + ""
                                General.WriteHTML(objLink.GetDynamicLink())
                            End If
                            ''"regular-checkbox"
                            'Commented And Added By Vaijat K ON 11/09/2017 For CheckBox Style
                            'General.WriteHTML(HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            'General.WriteHTML(HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            'General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            'General.WriteHTML(HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))

                            General.WriteHTML(HTMLControls.DrawCheckBox("chkAdd", "chkAdd", "regular-checkbox", blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            General.WriteHTML(HTMLControls.DrawCheckBox("chkEdit", "chkEdit", "regular-checkbox", blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete", "chkDelete", "regular-checkbox", blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            General.WriteHTML(HTMLControls.DrawCheckBox("chkView", "chkView", "regular-checkbox", blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                            'End Commented And Added By Vaijat K ON 11/09/2017 For CheckBox Style
                            General.WriteHTML("</TD>")
                        Else
                            'End Addition By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement

                            'Commented And Added By Vaijat K ON 11/09/2017 For CheckBox Style
                            'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")

                            General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd" & lngSubTagID.ToString, "regular-checkbox", blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkAdd" & lngSubTagID.ToString & "'></label></TD>")
                            General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit" & lngSubTagID.ToString, "regular-checkbox", blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkEdit" & lngSubTagID.ToString & "'></label></TD>")
                            General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete" & lngSubTagID.ToString, "regular-checkbox", blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkDelete" & lngSubTagID.ToString & "'></label></TD>")
                            General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView" & lngSubTagID.ToString, "regular-checkbox", blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkView" & lngSubTagID.ToString & "'></label></TD>")
                            'End Commented And Added By Vaijat K ON 11/09/2017 For CheckBox Style
                        End If
                        intRowCount += 1
                        General.WriteHTML("</TR>")
                        intCnter += 1
                    End If
                End If
            End While
            objDrSubTag.Close()
            objDrSubTag.Dispose()
            objDrSubTag = Nothing
        End While
        objhtSubTagMaster = Nothing 'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        objhtTagMaster = Nothing 'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        objDrParent.Close()
        objDrParent.Dispose()
        objDrParent = Nothing

        General.WriteHTML("</Table>")
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , intRowCount.ToString, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtParentRowCount", "hdtxtParentRowCount", , , , intTRCount.ToString, , , , , , True)
        General.WriteHTML("</Div>")
        '******************************************************************************************
    End Sub
    Private Sub PlotTabCollectionGrid()
        '=====================================================================
        ' Procedure Name		:	PlotTabCollectionGrid
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw the grid of tag and subtag list and Access type check boxes for perticular Tab Collection
        ' Description			:	This procedure will plot the grid of Tag and subtag for the tag for the selected
        '                           Tab Collection. Here grid class is not used, as grid class doesnt support the 
        '                           requirements so grid is plotted manually with check boxes for access types.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' RequirementID         :   WAF3_PB_74 Tab Collection enhancement
        ' Author				:	NinadP
        ' Created				:	9 July 2009
        ' Revisions				:	
        '=====================================================================
        'Added By Ninad on 10 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
        'End Addition By Ninad on 10 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement

        Dim strSQL As String
        'Dim objDrParent As IDataReader
        'Dim objDrSubTag As IDataReader
        Dim objDr As IDataReader
        Dim lngTagID As Long
        'Dim lngTagID As Long
        Dim blnAdd As Boolean
        Dim blnEdit As Boolean
        Dim blnDelete As Boolean
        Dim blnView As Boolean
        Dim blnAccess As Boolean
        Dim strModuleName As String = ""
        Dim strEditableTagList As String
        Dim blnCheckboxDisabled As Boolean
        Dim objLink As WebPage.UI.cDynamicLink
        Dim intCnter As Integer
        Dim intRowCount As Integer
        Dim intTRCount As Integer
        Dim blnIsParent As Boolean
        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        Dim strTemplateID As String = HttpUtility.HtmlEncode(Request.QueryString("ModuleID").ToString)
        lngTagID = CType(Request("TagID"), Long)
        General.WriteHTML("<Table class='clsGridTable' width='100%' cellspacing=1 cellpading=0>")
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD align='left' width=50%>")
        General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_TABCOLLECTION") + " : </B>" + CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID).TagDescription + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'get the Role name and editable tag list for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("EditableTagList")) Then
                strEditableTagList = objDr("EditableTagList").ToString + ""
            Else
                strEditableTagList = ""
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'create link object
        objLink = New WebPage.UI.cDynamicLink()
        objLink.cssClass = ""
        objLink.ReturnHTML = True


        'display table
        '******************************************************************************************
        General.WriteHTML("<BR>")
        General.WriteHTML("<Div id='DivList' style='overflow: auto;' width='100%' height='90%' >")
        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsStaticHeaderStyle"), "ON")) = "ON" Then
            CommonFunction.General.WriteHTML(CommonFunctions.General.PlotStaticHeaderStyle("DivList"))
        End If
        General.WriteHTML("<Table class='clsGridTable' width=100% cellspacing=1 cellpadding=0>")

        'display column headers
        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("IsStaticHeaderStyle"), "ON")) = "ON" Then
            General.WriteHTML("<THead class='clsTRColumnHeader'>")
            General.WriteHTML("<TH class='DivList' align=left nowrap='nowrap' >" + MyBase.GetResourceString("COL_ACCESSIBLE_COMPONENTS") + "</TH>")
            'General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_TAB_COLL") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_SUBTAG") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_ACCESS") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_ADD") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_EDIT") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_DELETE") + "</TH>")
            General.WriteHTML("<TH class='DivList' align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_VIEW") + "</TH>")
            General.WriteHTML("</THead>")
        Else
            General.WriteHTML("<TR class='clsTRColumnHeader'>")
            General.WriteHTML("<TD align=left nowrap='nowrap' >" + MyBase.GetResourceString("COL_ACCESSIBLE_COMPONENTS") + "</TD>")
            'General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_TAB_COLL") + "</TD>")
            General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_SUBTAG") + "</TD>")
            General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_ACCESS") + "</TD>")
            General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_ADD") + "</TD>")
            General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_EDIT") + "</TD>")
            General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_DELETE") + "</TD>")
            General.WriteHTML("<TD align=center nowrap='nowrap' >" + MyBase.GetResourceString("COL_VIEW") + "</TD>")
            General.WriteHTML("</TR>")
        End If



        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD align=left><B>" + CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID).TagDescription + "</B></TD>")

        'check if user has access to Tag
        blnCheckboxDisabled = False
        If (UserHasAccessToTag(lngTagID, strEditableTagList)) Then
            blnAccess = True
            blnCheckboxDisabled = False
        Else
            blnAccess = False
            blnCheckboxDisabled = True
        End If
        'dont display the configure Tab Collection link for parent tag.
        'General.WriteHTML("<TD align='left'>&nbsp;</TD>")
        'dont display the configure subtag link for parent tag.
        General.WriteHTML("<TD aline='left'></TD>")
        intRowCount += 1
        intTRCount += 1


        ''Commented by swapnil aswale on 10th sep 2015
        'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(event,'')", True))
        ''Modified by swapnil aswale on 10th sep 2015
        General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick(" + intTRCount.ToString + ",event)", True))
        'Ended

        General.WriteHTML(HTMLControls.DrawTextBox("txtAccess", "txtAccess", , , , lngTagID.ToString, , , , , , True) + "</TD>")
        General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd" + lngTagID.ToString, "chkAdd" + lngTagID.ToString, , blnAccess, lngTagID.ToString, False, , True, , , , True) + "</TD>")
        General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit" + lngTagID.ToString, "chkEdit" + lngTagID.ToString, , blnAccess, lngTagID.ToString, False, , True, , , , True) + "</TD>")
        General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete" + lngTagID.ToString, "chkDelete" + lngTagID.ToString, , blnAccess, lngTagID.ToString, False, , True, , , , True) + "</TD>")
        General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView" + lngTagID.ToString, "chkView" + lngTagID.ToString, , blnAccess, lngTagID.ToString, False, , True, , , , True) + "</TD>")

        General.WriteHTML("</TR>")




        Dim lngTabCollectionID As Long = CommonEngines.HashTables.GetHashTableObject.GetHashTableTabCollectionID(lngTagID)
        Dim objTabCollectionTabs() As CommonEngines.HashTables.Tabs
        Dim objTabCollectionTab As CommonEngines.HashTables.Tabs
        objTabCollectionTabs = CommonEngines.HashTables.GetHashTableObject.GetHashTableTabCollectionTabs(lngTabCollectionID)
        intCnter = 1
        Dim objhtTagMaster As CommonEngines.HashTables.UITagMaster
        Dim objhtSubTagMaster() As CommonEngines.HashTables.SubUITagMaster

        For Each objTabCollectionTab In objTabCollectionTabs
            'get the tag info
            lngTagID = objTabCollectionTab.TagID
            objhtTagMaster = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID)
            If Not (General.GetFrameworkSettings("PB_DO_NOT_SHOW_SYSTEM_WEB_FORMS_IN_ROLE_ACCESS", "Enabled") AndAlso objhtTagMaster.IsSystemWebForm) Then
                If Not objhtTagMaster Is Nothing AndAlso objhtTagMaster.ModuleIdentifier.Trim.ToUpper <> "R" Then
                    If CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngTagID) Or objhtTagMaster.ApplyRoleLevelAccess Then
                        'if the tag is parent tag then dont show 
                        blnIsParent = objhtTagMaster.IsParent
                        If blnIsParent = False Then
                            If (UserHasAccessToTag(lngTagID, strEditableTagList)) Then
                                blnAccess = True
                                blnCheckboxDisabled = False
                            Else
                                blnAccess = False
                                blnCheckboxDisabled = True
                            End If

                            If intCnter Mod 2 <> 0 Then
                                General.WriteHTML("<TR class='clsTROdd' id='chkAccess" + "TR' name='chkAccess" + "TR' >") 'Modified By Ninad on 18 May 2009 IssueID-30417
                            Else
                                General.WriteHTML("<TR class='clsTREvenRow' id='chkAccess" + "TR' name='chkAccess" + "TR' >") 'Modified By Ninad on 18 May 2009 IssueID-30417
                            End If

                            'display the link in the first column depending on the blnAccess
                            If blnAccess = True AndAlso Not CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngTagID) Then
                                objLink.LinkName = objhtTagMaster.TagDescription
                                objLink.FunctionName = "TabCollectionLink_OnClick('" + strTemplateID + "','" + lngTagID.ToString + "')"
                                objLink.Tooltip = MyBase.GetResourceString("LINK_SHOW_TOOLTIP") + ""
                                General.WriteHTML("<TD align='left'>" + objLink.GetDynamicLink() + "</TD>")
                            Else
                                General.WriteHTML("<TD align='left'>" + objhtTagMaster.TagDescription + "</TD>")
                            End If

                            'check if tag has subtag and display link accordingly in the second column
                            objhtSubTagMaster = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(lngTagID)
                            If Not objhtSubTagMaster Is Nothing AndAlso blnAccess = True Then
                                objLink.LinkName = MyBase.GetResourceString("COL_SUBTAG_LINK") + ""
                                objLink.FunctionName = "TabCollectionConfigureSubtag_OnClick('" + strTemplateID + "','" + lngTagID.ToString + "')"
                                objLink.Tooltip = MyBase.GetResourceString("COL_SUBTAG_LINK_TOOLTIP") + ""
                                General.WriteHTML("<TD align='center'>" + objLink.GetDynamicLink() + "</TD>")
                            Else
                                General.WriteHTML("<TD align='center'>&nbsp;</TD>")
                            End If
                            'get all the Access (Add,Edit,Delete,View) for the tag
                            Dim blnValues As Boolean()
                            blnValues = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_lngRoleID.ToString + "-0-" + lngTagID.ToString)
                            If Not blnValues Is Nothing Then
                                blnAdd = blnValues(0)
                                blnEdit = blnValues(1)
                                blnDelete = blnValues(2)
                                blnView = blnValues(3)
                            Else
                                blnAdd = False
                                blnEdit = False
                                blnDelete = False
                                blnView = False
                            End If

                            'display the check boxes
                            General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , blnAccess, lngTagID.ToString, , "onclick=javascript:Access_OnClick('" + intRowCount.ToString + "',event)", True))
                            General.WriteHTML(HTMLControls.DrawTextBox("txtAccess", "txtAccess", , , , lngTagID.ToString, , , , , , True) + "</TD>")
                            If CommonEngines.HashTables.GetHashTableObject.IsTabCollectionTag(lngTagID) Then
                                General.WriteHTML("<TD colspan=4 align='center'>")
                                If blnAccess = True Then
                                    objLink.LinkName = MyBase.GetResourceString("COL_TABCOLL_LINK") + ""
                                    objLink.FunctionName = "ConfigureTabCollection_OnClick('" + lngTagID.ToString + "','" + strTemplateID + "')"
                                    objLink.Tooltip = MyBase.GetResourceString("COL_TABCOLL_LINK") + ""
                                    General.WriteHTML(objLink.GetDynamicLink())
                                End If
                                General.WriteHTML(HTMLControls.DrawCheckBox("chkAdd" + lngTagID.ToString, "chkAdd" + lngTagID.ToString, , blnAdd, lngTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                                General.WriteHTML(HTMLControls.DrawCheckBox("chkEdit" + lngTagID.ToString, "chkEdit" + lngTagID.ToString, , blnEdit, lngTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                                General.WriteHTML(HTMLControls.DrawCheckBox("chkDelete" + lngTagID.ToString, "chkDelete" + lngTagID.ToString, , blnDelete, lngTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                                General.WriteHTML(HTMLControls.DrawCheckBox("chkView" + lngTagID.ToString, "chkView" + lngTagID.ToString, , blnView, lngTagID.ToString, blnCheckboxDisabled, , True, , , , True))
                                General.WriteHTML("</TD>")
                            Else
                                'End Addition By Ninad on 8 July 2009 ReqID-WAF3_PB_74 Tab Collection enhancement
                                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd" + lngTagID.ToString, "chkAdd" + lngTagID.ToString, , blnAdd, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit" + lngTagID.ToString, "chkEdit" + lngTagID.ToString, , blnEdit, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete" + lngTagID.ToString, "chkDelete" + lngTagID.ToString, , blnDelete, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                                General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView" + lngTagID.ToString, "chkView" + lngTagID.ToString, , blnView, lngTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                            End If
                            intRowCount += 1
                            General.WriteHTML("</TR>")
                            intCnter += 1
                        End If
                    End If
                End If
            End If
        Next
        General.WriteHTML("</Table>")
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , intRowCount.ToString, , , , , , True)
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtParentRowCount", "hdtxtParentRowCount", , , , intTRCount.ToString, , , , , , True)
        General.WriteHTML("</Div>")
        '******************************************************************************************
    End Sub
    '=====================================================================
    ' Procedure Name		:	UserHasAccessToTag
    ' Parameters Passed		:	lngTagID - Long
    '                           strEditableTagIDList - string
    ' Returns				:	boolean, True if Tag id Present in the list
    ' Parameters Affected	:	None
    ' Purpose				:	To check if given tagid is there in the list of tag id's.
    ' Description			:	This function will check the existence of the TagID in the 
    '                           given tag id list in strEditableTagIDList by spliting the quama seperated list 
    '                           and returns true if Tag id present in the list.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 17 2004
    ' Revisions				:	
    '=====================================================================
    Private Function UserHasAccessToTag(ByVal lngTagID As Long, ByVal strEditableTagIDList As String) As Boolean
        Dim arrTagID() As String
        Dim intCnt As Integer
        Dim blnReturn As Boolean = False

        If strEditableTagIDList <> "" Then
            arrTagID = Split(strEditableTagIDList, ",")

            For intCnt = 0 To arrTagID.Length - 1
                If lngTagID.ToString.Trim = arrTagID(intCnt).Trim Then
                    blnReturn = True
                    Exit For
                End If
            Next
        Else
            blnReturn = False
        End If

        UserHasAccessToTag = blnReturn
    End Function

    '=====================================================================
    ' Procedure Name		:	performAction
    ' Parameters Passed		:	strAction - string 
    '                           lngUserAccessID - long
    '                           
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database based on the action parameter
    ' Description			:	This procedure will update the database for access for the 
    '                           UserAccessID passed to it.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 19 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performAction(ByVal strAction As String, ByVal lngUserAccessID As Long)
        Dim arrAccessTagIDList() As String
        Dim strAccessTagID As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim i As Integer
        Dim strAddAccess As String
        Dim strEditAccess As String
        Dim strDeleteAccess As String
        Dim strViewAccess As String

        Select Case (strAction)
            Case CONST_ACTION_SAVE, CONST_ACTION_SAVE_AND_CLOSE 'Added By Ninad On 3 April 2008 IssueID 14871 - Add Save and Close link
                'get the list of all tagID's of parents

                strAccessTagID = MyBase.GetFormValue("chkAccess") + ""
                If strAccessTagID = "" Then

                    strSQL = "usp_udt_tbl_UserAccess '" + General.BuildQueryString(m_strTemplateID.Trim) + "'," + lngUserAccessID.ToString + ",Null"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                Else
                    m_strParentList = ""

                    'here parent tag ID list is created for giving access as if subtag has access
                    'then parent tag gets the access.
                    arrAccessTagIDList = Split(strAccessTagID, ",")
                    For i = 0 To arrAccessTagIDList.Length - 1
                        Call getParentTagIDList(CType(arrAccessTagIDList(i).Trim, Long))
                    Next

                    'update the database for parent Tag access
                    If m_strTemplateID = "" Then
                        If strAccessTagID = "" Then
                            strSQL = "usp_udt_tbl_UserAccess Null," + lngUserAccessID.ToString + ",Null"
                        Else
                            strSQL = "usp_udt_tbl_UserAccess Null," + lngUserAccessID.ToString + ",'" + m_strParentList.Trim + "'"
                        End If
                    Else
                        If strAccessTagID = "" Then
                            strSQL = "usp_udt_tbl_UserAccess '" + General.BuildQueryString(m_strTemplateID.Trim) + "'," + lngUserAccessID.ToString + ",Null"
                        Else
                            strSQL = "usp_udt_tbl_UserAccess '" + General.BuildQueryString(m_strTemplateID.Trim) + "'," + lngUserAccessID.ToString + ",'" + m_strParentList.Trim + "'"
                        End If
                    End If

                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'get the RoleId for UserAccessID
                    strSQL = "usp_Sel_RoleForUserAccessID " + lngUserAccessID.ToString
                    objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDR.Read Then
                        If Not IsDBNull(objDR("RoleID")) Then
                            m_lngRoleID = CType(objDR("RoleID"), Long)
                        Else
                            m_lngRoleID = 0
                        End If

                    End If
                    objDR.Close()
                    objDR.Dispose()
                    objDR = Nothing

                    'check if there is no entry in the node access table for the role then make entry
                    'in the node access table for the role
                    strSQL = "Exec usp_Ins_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + m_strParentList.Trim + "'"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'update the user access table for add,edit,delete and view access
                    strAddAccess = MyBase.GetFormValue("chkAdd") + ""
                    strEditAccess = MyBase.GetFormValue("chkEdit") + ""
                    strDeleteAccess = MyBase.GetFormValue("chkDelete") + ""
                    strViewAccess = MyBase.GetFormValue("chkView") + ""

                    'Set/Reset the access rights for Add
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strAddAccess.Trim + "','A','" + General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'set/reset access for Edit
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strEditAccess.Trim + "','E','" + General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'set/reset access for Delete
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strDeleteAccess.Trim + "','D','" + General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                    'set/reset access for View
                    strSQL = "EXEC usp_Upd_tbl_UI_NodeAccess " + m_lngRoleID.ToString + ",'" + strViewAccess.Trim + "','V','" + General.BuildQueryString(m_strTemplateID.Trim) + "'"
                    Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                End If
            Case Else
        End Select

        'Added by PrasannaP 14th June 2005 For RL_CH_01
        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()

        'Added BY NileshD on 6th Sep 2005 ReqID-WAF3_PB_8
        'clear the hashtable entries for all the user who have selected role.
        If UCase(m_strMode) = CONST_ROLE_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'R','" + m_strTemplateID.Trim + "'," + m_lngRoleID.ToString)
        ElseIf UCase(m_strMode) = CONST_GROUP_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'U',null,null,null,null," + m_lngRoleID.ToString)
        End If
        'End Of Addition BY NileshD on 6th Sep 2005 ReqID-WAF3_PB_8

    End Sub

    '=====================================================================
    ' Procedure Name		:	GetParentList
    ' Parameters Passed		:	TagID - long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	to get the list of parent Tag ID of the passed Tag ID.
    ' Description			:	This procedure will get tag id and check it in the other 
    '                           array of Tag ID for presence. If not present the add to that
    '                           list and check if it has any parent.If it has any parent then
    '                           for that parent TagID also same procedure will be called in recursion.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 19 2004
    ' Revisions				:	By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
    '=====================================================================
    Private Sub getParentTagIDList(ByVal lngTagID As Long)
        Dim blnPresent As Boolean
        Dim arrParentTagIDList() As String
        Dim i As Integer
        Dim lngTempTagID As Long
        'Dim objDR As IDataReader

        blnPresent = False
        arrParentTagIDList = Split(m_strParentList, ",")
        For i = 0 To arrParentTagIDList.Length - 1
            If lngTagID.ToString.Trim = arrParentTagIDList(i).Trim Then
                blnPresent = True
                Exit For
            End If
        Next
        If blnPresent = False Then
            m_strParentList += lngTagID.ToString + ","
        End If
        lngTempTagID = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID).ParentTagID
        If lngTempTagID <> 0 Then
            Call getParentTagIDList(lngTempTagID)
        End If
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotSubnodeGrid
    ' Parameters Passed		:	lngTagID - long - Tag ID 
    '                           lngRoleID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the grid of sub tag and Access type check boxes
    ' Description			:	This procedure will plot the grid of Sub Tag for the tagID passed to it
    '                           Here grid class is not used, as grid class doesn't support the 
    '                           requirements so grid is plotted manually with check boxes for access types.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 17 2004
    ' Revisions				:	By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
    '=====================================================================
    Private Sub plotSubnodeGrid(ByVal lngTagID As Long, ByVal lngUserAccessID As Long)
        Dim strSQL As String
        'Dim objDrSubTag As IDataReader
        Dim objDr As IDataReader
        Dim lngSubTagID As Long
        Dim blnAdd As Boolean
        Dim blnEdit As Boolean
        Dim blnDelete As Boolean
        Dim blnView As Boolean
        Dim blnAccess As Boolean
        Dim blnCheckboxDisabled As Boolean
        Dim objLink As WebPage.UI.cDynamicLink
        Dim intRowCount As Integer
        Dim strModuleName As String
        Dim strParentTagName As String
        Dim objhtSubTagMasters As CommonEngines.HashTables.SubUITagMaster()
        Dim objhtSubTagMaster As CommonEngines.HashTables.SubUITagMaster

        'get the Role name for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("RoleID")) Then
                m_lngRoleID = CType(objDr("RoleID"), Long)
            Else
                m_lngRoleID = 0
            End If
        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'get the module name to display it in the table header
        'Modified By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        strModuleName = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", m_strTemplateID.Trim).ModuleName
        'get the parent tag name to display it 
        strParentTagName = CommonEngines.HashTables.GetHashTableObject.GetHashTableUITagMasterObject(lngTagID).TagDescription
        'End Modification By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access

        'display the role name and module name list combo
        General.WriteHTML("<Table class='clsGridTable' width='100%' cellspacing=1 cellpading=0>")
        General.WriteHTML("<TR class='clsTROdd'>")
        General.WriteHTML("<TD align='left' width=50%>")
        General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_PARENT_TAG") + " : </B>" + strParentTagName.Trim + "</TD>")
        General.WriteHTML("<TD align='Right' width=50%>")
        General.WriteHTML("<B>" + MyBase.GetResourceString("CAP_MODULE") + " : </B>" + strModuleName.Trim + "</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</Table>")

        'display table
        '******************************************************************************************
        General.WriteHTML("<BR>")
        General.WriteHTML("<Div id='DivList' style='overflow: auto;' width='100%' height='90%' >")
        General.WriteHTML("<Table class='clsGridTable' width=100% cellspacing=1 cellpadding=0>")

        'display column headers
        General.WriteHTML("<TR class='clsTRColumnHeader'>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ACCESS") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_ADD") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_EDIT") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_DELETE") + "</TD>")
        General.WriteHTML("<TD align=center>" + MyBase.GetResourceString("COL_VIEW") + "</TD>")
        General.WriteHTML("</TR>")

        'start displaying the data
        intRowCount = 0
        'Added By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        objhtSubTagMasters = CommonEngines.HashTables.GetSubTagHashTableObjects.GetHashTableUISubTagMasterObject(lngTagID)
        If Not objhtSubTagMasters Is Nothing Then
            For Each objhtSubTagMaster In objhtSubTagMasters
                If objhtSubTagMaster.ApplyRoleLevelAccess Then 'Addded By Ninad on 14 July 2009
                    intRowCount += 1

                    lngSubTagID = objhtSubTagMaster.SubTagID
                    m_arlSubTagIDList.Add(lngSubTagID)
                    'get all the Access (Add,Edit,Delete,View) for the tag
                    Dim blnValues As Boolean()
                    blnValues = CommonEngines.HashTables.GetHashTableObject.GetHashTableRoleAccessCacheRole(m_lngRoleID.ToString + "-" + lngTagID.ToString + "-" + lngSubTagID.ToString)
                    If Not blnValues Is Nothing Then
                        blnAdd = blnValues(0)
                        blnEdit = blnValues(1)
                        blnDelete = blnValues(2)
                        blnView = blnValues(3)
                    Else
                        blnAdd = False
                        blnEdit = False
                        blnDelete = False
                        blnView = False
                    End If

                    If intRowCount Mod 2 <> 0 Then
                        General.WriteHTML("<TR class='clsTROdd' >")
                    Else
                        General.WriteHTML("<TR class='clsTREven' >")
                    End If

                    General.WriteHTML("<TD align='left'>" + objhtSubTagMaster.TagDescription + "</TD>")
                    'display the check boxes

                    'Commented And Added By Vaijat K ON 11/09/2017 For Checkbox Style
                    'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd", , blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                    'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit", , blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                    'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete", , blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")
                    'General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView", , blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "</TD>")

                    General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkAdd", "chkAdd" & lngSubTagID, "regular-checkbox", blnAdd, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkAdd" & lngSubTagID.ToString & "'></label></TD>")
                    General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkEdit", "chkEdit" & lngSubTagID, "regular-checkbox", blnEdit, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkEdit" & lngSubTagID.ToString & "'></label></TD>")
                    General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkDelete", "chkDelete" & lngSubTagID, "regular-checkbox", blnDelete, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkDelete" & lngSubTagID.ToString & "'></label></TD>")
                    General.WriteHTML("<TD align=center>" + HTMLControls.DrawCheckBox("chkView", "chkView" & lngSubTagID, "regular-checkbox", blnView, lngSubTagID.ToString, blnCheckboxDisabled, , True) + "<label for='chkView" & lngSubTagID.ToString & "'></label></TD>")
                    'End Commented And Added By Vaijat K ON 11/09/2017 For Checkbox Style
                    General.WriteHTML("</TR>")
                End If
            Next
            objhtSubTagMasters = Nothing
            objhtSubTagMaster = Nothing
        End If
        'End Addition By Ninad on 12 May 2009 WAF3_GEN_20 Redesign Role Access
        General.WriteHTML("</Table>")
        CommonFunctions.HTMLControls.DrawTextBox("hdtxtRowCount", "hdtxtRowCount", , , , intRowCount.ToString, , , , , , True)
        General.WriteHTML("</Div>")
    End Sub

    '=====================================================================
    ' Procedure Name		:	performSubnodeAction
    ' Parameters Passed		:	lngTagID - long - Tag ID 
    '                           lngRoleID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the data for access to subtag for the RoleID and TagID.
    ' Description			:	This procedure will update the data in the subnodeaccess for access
    '                           settings.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 20 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performSubnodeAction(ByVal strAction As String, ByVal lngUserAccessID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim i As Integer
        Dim blnPresent As Boolean
        Dim strAddAccess As String
        Dim strEditAccess As String
        Dim strDeleteAccess As String
        Dim strViewAccess As String
        Dim strUniqueSubTagIDList As String
        Dim arrList() As String

        'get the Role name for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            If Not IsDBNull(objDR("RoleID")) Then
                m_lngRoleID = CType(objDR("RoleID"), Long)
            Else
                m_lngRoleID = 0
            End If
        End If
        objDR.Close()
        objDR.Dispose()
        objDR = Nothing

        'get the subTagId list for Add,Edit,Delete and View
        strAddAccess = MyBase.GetFormValue("chkAdd") + ""
        strEditAccess = MyBase.GetFormValue("chkEdit") + ""
        strDeleteAccess = MyBase.GetFormValue("chkDelete") + ""
        strViewAccess = MyBase.GetFormValue("chkView") + ""

        'create a list of SubTagID's for which entries are to be made for access
        Dim strTempList As String
        Dim arrTempList() As String
        Dim j As Integer

        strTempList = strAddAccess.Trim + "," + strEditAccess.Trim + "," + strDeleteAccess.Trim + "," + strViewAccess.Trim
        arrTempList = Split(strTempList, ",")
        strUniqueSubTagIDList = ""

        For i = 0 To arrTempList.Length - 1
            arrList = Split(strUniqueSubTagIDList.Trim, ",")
            blnPresent = False
            For j = 0 To arrList.Length - 1
                If arrTempList(i).Trim = arrList(j).Trim Then
                    blnPresent = True
                    Exit For
                End If
            Next
            arrList = Nothing   'free the memory

            If blnPresent = False Then
                strUniqueSubTagIDList += arrTempList(i).Trim + ","
            End If
        Next

        'first delete all the records from the tbl_UI_subnodeaccess table for this 
        'roleID and SubTagID's of this TagID
        strSQL = "usp_del_tbl_ui_subnodeaccess " + m_lngTagID.ToString + "," + m_lngRoleID.ToString
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'to insert record in the tbl_ui_subnodeaccess first check whether there is 
        'already record present for this subtagID and RoleId or not. If not present then
        'insert new reocrd for this RoleID and subtagID and then update that record for access.
        strSQL = "usp_ins_tbl_ui_subnodeaccess '" + strUniqueSubTagIDList.Trim + "'," + m_lngRoleID.ToString
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


        'update the records for the Add access settings
        strSQL = "usp_upd_tbl_ui_subnodeaccess '" + strAddAccess.Trim + "'," + m_lngRoleID.ToString + ",'A'"
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update the records for the edit access settings
        strSQL = "usp_upd_tbl_ui_subnodeaccess '" + strEditAccess.Trim + "'," + m_lngRoleID.ToString + ",'E'"
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update the records for the Delete access settings
        strSQL = "usp_upd_tbl_ui_subnodeaccess '" + strDeleteAccess.Trim + "'," + m_lngRoleID.ToString + ",'D'"
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'update the records for the View access settings
        strSQL = "usp_upd_tbl_ui_subnodeaccess '" + strViewAccess.Trim + "'," + m_lngRoleID.ToString + ",'V'"
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        'Added by PrasannaP 14th June 2005 For RL_CH_01
        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()

        Dim dr As IDataReader
        Dim strUserID As String
        dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Role " + m_lngRoleID.ToString, MyBase.UseSQL)
        While dr.Read
            strUserID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), ""), String)
            CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(strUserID + "-E-SUBTAG-" + m_lngTagID.ToString)
            If m_lngRoleID.ToString = "23" Then
                CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(strUserID + "-C-SUBTAG-" + m_lngTagID.ToString)
            End If
        End While

        dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_Employee_Group " + m_lngTagID.ToString, MyBase.UseSQL)
        While dr.Read
            strUserID = CType(CommonFunctions.Data.CheckIsDBNull(dr("EmployeeID"), ""), String)
            CommonEngines.HashTables.GetHashTableObject.ClearUPFHashTable(strUserID + "-SUBTAG-" + m_lngTagID.ToString)
        End While

        dr = Nothing
        'End Addition

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotSingleTagGrid
    ' Parameters Passed		:	lngTagID - long - Tag ID 
    '                           lngUserAccessID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To plot the grid for user access types for single Tag.
    ' Description			:	same as above
    '                           settings.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 21 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotSingleTagGrid(ByVal lngTagID As Long, ByVal lngUserAccessID As Long)
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim objGrid As WebPage.Templates.GenericGrid

        Dim arrColHeader() As String = {MyBase.GetResourceString("COL_ACCESS_TYPES"), MyBase.GetResourceString("COL_APPLY")}
        Dim arrAN() As String = {"AccessType", ""}
        Dim arrCheckBox() As String = {"", "chkAccess"}
        Dim arrCheckBoxCheck() As String = {"", "Checked"}
        Dim arrTDStyle() As String = {"align='left'", "align='center'"}

        'Dim arrRowLink() As String = {"Attribute_OnClick(AttributeID)", "", ""}

        'get the Role name for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + lngUserAccessID.ToString
        objDr = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDr.Read Then
            If Not IsDBNull(objDr("RoleID")) Then
                m_lngRoleID = CType(objDr("RoleID"), Long)
            Else
                m_lngRoleID = 0
            End If

        End If
        objDr.Close()
        objDr.Dispose()
        objDr = Nothing

        'display table
        '******************************************************************************************

        strSQL = "usp_sel_nodeaccess_GridForSingleTag " + lngTagID.ToString + "," + m_lngRoleID.ToString

        'create Grid object and set the properties
        objGrid = New WebPage.Templates.GenericGrid

        objGrid.ActualColumnArray = arrAN
        objGrid.UserFriendlyColumnArray = arrColHeader
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.CheckboxCheckOnColumnArray = arrCheckBoxCheck
        objGrid.TDStyleArray = arrTDStyle
        objGrid.PrimaryKey = "AccessID"
        objGrid.DIVID = "DivList"
        objGrid.DIVHeight = 200
        objGrid.DIVStyle = "overflow: auto"
        objGrid.NoOfDataColumns = 1
        objGrid.PrinterFriendlyVersion = False
        objGrid.VerticalDisplay = False
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.returnHTML = False
        objGrid.EmptyValueReplacement = "-"

        objGrid.SQL = strSQL
        objGrid.UseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        'plot the grid 
        objGrid.DrawGrid()

        objGrid = Nothing
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotSingleTagGrid
    ' Parameters Passed		:	strAction   - string
    '                           lngTagID - long - Tag ID 
    '                           lngUserAccessID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the user access by updating the nodeaccess table.
    ' Description			:	same as above
    '                           settings.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 21 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performSingleTagAction(ByVal strAction As String, ByVal lngTagID As Long, ByVal lngUserAccessID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strAccess As String
        Dim arrAccessType() As String
        Dim intAdd As Integer = 0
        Dim intEdit As Integer = 0
        Dim intDelete As Integer = 0
        Dim intView As Integer = 0

        'get the Role name for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            If Not IsDBNull(objDR("RoleID")) Then
                m_lngRoleID = CType(objDR("RoleID"), Long)
            Else
                m_lngRoleID = 0
            End If
        End If
        objDR.Close()
        objDR.Dispose()
        objDR = Nothing

        strAccess = MyBase.GetFormValue("chkAccess") + ""
        If strAccess <> "" Then
            arrAccessType = Split(strAccess, ",")
            Dim i As Integer
            For i = 0 To arrAccessType.Length - 1
                If arrAccessType(i).Trim = "1" Then
                    intAdd = 1
                ElseIf arrAccessType(i).Trim = "2" Then
                    intEdit = 1
                ElseIf arrAccessType(i).Trim = "3" Then
                    intDelete = 1
                ElseIf arrAccessType(i).Trim = "4" Then
                    intView = 1
                End If
            Next
        End If

        'reset the entries in the NodeAccess table for this RoleID and TagID
        strSQL = "usp_upd_tbl_ui_nodeaccess_Reset '" + lngTagID.ToString + "'," + m_lngRoleID.ToString
        strSQL += ",'" + intAdd.ToString + "','" + intEdit.ToString + "','" + intDelete.ToString + "','" + intView.ToString + "'"
        Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Monday, July 24, 2006 For Support Request ID. - 141
        'Reason   - Role Access changes were not reflected as the Cache was not refreshed. 
        '-------------------------------------------------------------------------------------------------------------
        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()

        'clear the hashtable entries for all the user who have selected role.
        If (m_strSubMode & "").Trim.ToUpper = CONST_ROLE_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'R','" + m_strTemplateID.Trim + "'," + m_lngRoleID.ToString)
        ElseIf (m_strSubMode & "").Trim.ToUpper = CONST_GROUP_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'U',null,null,null,null," + m_lngRoleID.ToString)
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Monday, July 24, 2006 For Support Request ID. - 141
        '-------------------------------------------------------------------------------------------------------------


    End Sub
    Private Sub PerformTabCollectionAction(ByVal lngUserAccessID As Long)
        '=====================================================================
        ' Procedure Name		:	PerformTabCollectionAction
        ' Parameters Passed		:	lngUserAccessID - Long
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To update the user access by updating the nodeaccess table for Tab Collection.
        ' Description			:	same as above
        '                           settings.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	NinadP
        ' Created				:	13 July 2009
        ' Revisions				:	
        '=====================================================================
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strTagAccess As String
        Dim arrTagAccess() As String
        Dim strAdd As String
        Dim strEdit As String
        Dim strDelete As String
        Dim strView As String
        'get the Role name for the userAccessID from the database
        strSQL = "usp_Sel_RoleForUserAccessID " + m_lngUserAccessID.ToString
        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
        If objDR.Read Then
            If Not IsDBNull(objDR("RoleID")) Then
                m_lngRoleID = CType(objDR("RoleID"), Long)
            Else
                m_lngRoleID = 0
            End If
        End If
        objDR.Close()
        objDR.Dispose()
        objDR = Nothing

        strTagAccess = MyBase.GetFormValue("txtAccess") + ""
        If strTagAccess <> "" Then
            arrTagAccess = Split(strTagAccess, ",")
            Dim i As Integer
            For i = 0 To arrTagAccess.Length - 1
                strTagAccess = arrTagAccess(i)
                strAdd = "0"
                strEdit = "0"
                strDelete = "0"
                strView = "0"
                If strTagAccess = MyBase.GetFormValue("chkAdd" + strTagAccess) Then
                    strAdd = "1"
                End If
                If strTagAccess = MyBase.GetFormValue("chkEdit" + strTagAccess) Then
                    strEdit = "1"
                End If
                If strTagAccess = MyBase.GetFormValue("chkDelete" + strTagAccess) Then
                    strDelete = "1"
                End If
                If strTagAccess = MyBase.GetFormValue("chkView" + strTagAccess) Then
                    strView = "1"
                End If
                'reset the entries in the NodeAccess table for this RoleID and TagID
                strSQL = "usp_ins_upd_tbl_ui_nodeaccess_For_TabCollection '" + strTagAccess + "'," + m_lngRoleID.ToString
                strSQL += ",'" + strAdd.ToString + "','" + strEdit.ToString + "','" + strDelete.ToString + "','" + strView.ToString + "'"
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next
        End If

        CommonEngines.HashTables.GetHashTableObject.ClearRoleHashTable()

        'clear the hashtable entries for all the user who have selected role.
        If (m_strSubMode & "").Trim.ToUpper = CONST_ROLE_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'R','" + m_strTemplateID.Trim + "'," + m_lngRoleID.ToString)
        ElseIf (m_strSubMode & "").Trim.ToUpper = CONST_GROUP_ACCESS Then
            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'U',null,null,null,null," + m_lngRoleID.ToString)
        End If
    End Sub
    '=====================================================================
    ' Procedure Name		:	plotInheritRoleAccessScreen
    ' Parameters Passed		:	lngEntityID  - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw the screen for showing the Inherit access 
    '                           screen 
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Jan 21 2003
    ' Revisions				:	
    '=====================================================================
    Private Sub plotInheritRoleAccessScreen()
        Dim strSql As String
        Dim objDR As IDataReader

        'plot the controls
        General.WriteHTML("<Div id='DivList' style='overflow: auto;' width='100%' height='90%' >")

        'WAF3_PB_42 April 13, 2007 UmeshJ Moved the note from below to this position
        General.WriteHTML("<table class='clsTable' width=100% cellspacing=1 cellpadding=0>") 'Change class to clsTable
        'display note
        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=100% align='left' colspan=2>")
        If m_strMode.ToUpper = CONST_INHERIT_ACCESS Then
            General.WriteHTML("<B>" + MyBase.GetResourceString("NOTE") + " : </B>" + MyBase.GetResourceString("NOTE_INHERIT_ACCESS"))
        Else
            General.WriteHTML("<B>" + MyBase.GetResourceString("NOTE") + " : </B>" + MyBase.GetResourceString("NOTE_INHERIT_ACCESS_GROUP"))
        End If
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("<TR><TD colspan=2><BR></TD></TR>") 'WAF3_PB_42 April 13, 2007 UmeshJ
        'WAF3_PB_42 April 13, 2007 UmeshJ END

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=50% align='left'>")
        If m_strMode.ToUpper = CONST_INHERIT_ACCESS Then
            General.WriteHTML(MyBase.GetResourceString("CAP_SOURCE_ROLE") + "&nbsp;</TD>")
            General.WriteHTML("<TD width=50% align='left'>")
            General.WriteHTML(MyBase.GetResourceString("CAP_DESTINATION_ROLE") + "&nbsp;</TD>")
            'set the SP to populate the combo for Role list
            strSql = "usp_sel_tbl_PM_Role_InheritRoleAccess"
        Else
            General.WriteHTML(MyBase.GetResourceString("CAP_SOURCE_GROUP") + "&nbsp;</TD>")
            General.WriteHTML("<TD width=50% align='left'>")
            General.WriteHTML(MyBase.GetResourceString("CAP_DESTINATION_GROUP") + "&nbsp;</TD>")
            'set the SP to populate the combo for group list
            strSql = "usp_sel_tbl_PM_Role_InheritGroupAccess"
        End If

        General.WriteHTML("</TR>")

        General.WriteHTML("<TR class='clsTREven'>")
        General.WriteHTML("<TD width=50% align='left'>")
        General.WriteHTML(HTMLControls.DrawComboBox("cboSourceRole", strSql, 210, , , True, True, , True) + "</TD>")
        General.WriteHTML("<TD width=50% align='left'>")
        General.WriteHTML(HTMLControls.DrawComboBox("cboDestinationRole", strSql, 210, , , True, True, , True) + "</TD>")
        General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("</div>")

    End Sub

    Private Sub GetGlobalObject()
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : GetGlobalObject
        ' Requirement Tag       : Hotfix ID. - 2.0.15-SP4-WAF
        ' Description           : Get Page Specific WhizGlobal Object
        ' Parameters Passed     : -
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Monday, June 19, 2006
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        'Create the WhizGlobal class object
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))

        'Get the WhizGlobal object
        m_objGlobal = MyBase.GlobalObject

        'Any Page specific changes......such as for Tag ID 27...get details for tag ID 32 (Project Information)
        Call CommonEngine.General.cPageSpecificBehavior.GetPageSpecificGlobalObject(m_objGlobal)

        'Apply Security 'Request ID: 244 Commented By UmeshJ 19 June 2007
        'MyBase.ApplySecurity(True,  2, , , True, m_objGlobal.TagID, 0)
    End Sub

    Private Sub GetAccessRights()
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : 
        ' Requirement Tag       : Hotfix ID. - 2.0.15-SP4-WAF
        ' Description           : 
        ' Parameters Passed     : 
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Monday, June 19, 2006
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        'Create Object of the Access Rights class from the ProjectByNet Template
        m_objAccess = New WebPage.Templates.AccessRights

        'Get the Access Rights 
        m_objAccess.GetAccess(m_objGlobal)
    End Sub

    Private Sub ClearGlobalObjects()
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : ClearGlobalObjects
        ' Requirement Tag       : Hotfix ID. - 2.0.15-SP4-WAF
        ' Description           : To clear the WhizGlobal objects of Access Rights and WhizGlobal
        ' Parameters Passed     : -
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Monday, June 19, 2006
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------

        'Cleare the WhizGlobal Objects
        m_objAccess = Nothing
        m_objGlobal = Nothing

    End Sub

End Class
