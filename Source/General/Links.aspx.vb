Imports Microsoft.VisualBasic
Imports System.Data
Imports Whizible
Imports DynamicMenu
Public Class Links
    Inherits WebPage.Templates.WhizTemplate
    Implements IMenuGroupEventHandler
    ' Added By ShraddhaM for WhizibleSEM8_Whiz3 on 3,July 2008 
    ' Purpose : To remove ModuleNames and add in logout link row.
    Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules
    ' End of Addition by ShraddhaM

    Public intFrameWidth As Integer
    ' ***********************************************************************************
    ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    Public m_blnIsWindowsAuthenticated As Boolean = False
    ' ***********************************************************************************
    ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    ' ***********************************************************************************
    ' Added Nov 06, 2004 RajeshB  R.No:WAF2_PB_46
    ' ***********************************************************************************
    Public m_blnDefaultNavigation As Boolean = False
    Private Shared WithEvents m_RADMenu As DynamicMenu.EventMenu
    Dim m_InlineFrame As New DynamicMenu.InlineFrame
    'Protected WithEvents frmLink As System.Web.UI.HtmlControls.HtmlForm
    Private Shared m_MenuGroup As New DynamicMenu.EventMenuGroup
    Private Shared m_ActiveMenu As DynamicMenu.EventMenuItem
    Public Shared m_CSSFile As String
    Public Const HTML_ENCODE As Boolean = False
    Private strSubPage As String

    ' ***********************************************************************************
    ' Modified Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
    ' ***********************************************************************************
    ' commented the default value assignment
    Private objNavigation As Navigation   '= CType(HttpContext.Current.Handler, Navigation)
    ' ***********************************************************************************
    ' End of Modification Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
    ' ***********************************************************************************

    ' ***********************************************************************************
    ' End Addition  R.No:WAF2_PB_46
    ' ***********************************************************************************

    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
    'Reason   - For getting keys from framework settings.
    '-------------------------------------------------------------------------------------------------------------
    Protected m_blnEnableTabNavigation As Boolean = False
    Protected m_blnShowLogoOnNavigationPage As Boolean = True
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
    '-------------------------------------------------------------------------------------------------------------
    '-------------------------------------------------------------------------------------------------------------
    'Added By - PrashantSJ On - Thursday, May 28, 2009 For WhizibleSEM 8.1
    'Reason      - To plot all the links in one div.
    '-------------------------------------------------------------------------------------------------------------
    Protected sbHTML As New StringBuilder("")
    Protected sbSQL As New StringBuilder("")
    Protected lngOrderNumber As Double = 0.0
    Protected blnEarliarNavigationStyle As Boolean = False
    Protected drUserSetting As IDataReader
    'Added By Nikhil A on 8-July-2020 for Modular
    Private strXMLPath As String = Server.MapPath("../GENERAL/").ToString + "WhizModules.xml"
    '-------------------------------------------------------------------------------------------------------------
    'Ended By - PrashantSJ On - Thursday, May 28, 2009 For WhizibleSEM 8.1
    '-------------------------------------------------------------------------------------------------------------

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
        'Reason   - For getting keys from framework settings.
        '-------------------------------------------------------------------------------------------------------------
        m_blnEnableTabNavigation = CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_TABNAVIGATION", "Enabled")
        m_blnShowLogoOnNavigationPage = CommonFunctions.General.GetFrameworkSettings("GEN_SHOW_LOGO_ON_NAVIGATIONFRAME", "Enabled")
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
        '-------------------------------------------------------------------------------------------------------------

        ' ***********************************************************************************
        ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ******************************************************

        m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(sender)
        ' ***********************************************************************************
        ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ***********************************************************************************

        ' ***********************************************************************************
        ' Modified Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
        ' ***********************************************************************************

        'Code Added:RajeshB     27th December, 2004
        'Issue resolved by UmeshJ   
        ' getting the framework setting from the hash tables rather than from Navigation class
        'm_blnDefaultNavigation = Navigation.m_blnDefaultNavigation
        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("GEN_DEFAULT_NAVIGATION")
        m_blnDefaultNavigation = False
        If Not objFrameworkSetting Is Nothing Then
            If objFrameworkSetting.ValidateStatus() = True Then
                If UCase(Trim(objFrameworkSetting.Status & "")) = "ENABLED" Then
                    m_blnDefaultNavigation = True
                End If
            End If
        End If
        'Addition Ends

        ' Modified Nov 10 2005 RajK Hot Fix# 2.0.5-SP2-WAF
        ' checking for the default navigation flag to be enabled
        If Not m_blnDefaultNavigation Then
            ' getting the Navigation object from hashtable
            objNavigation = CType(Navigation.m_NavHashTable("NAVIGATION"), Navigation)
            'objNavigation = CType(Session("Navigation"), Navigation)
        End If
        ' End of Modification Nov 10 2005 RajK Hot Fix# 2.0.5-SP2-WAF
        ' ***********************************************************************************
        ' End of Modification Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
        ' ***********************************************************************************
        '***************************************************************
        'Added by PrashantSJ on 9th June 2009 Purpose:To Get User setting details (Navigation style)
        '****************************************************************
        'Dim strSQL As String = "usp_Sel_LoggedInUser_Settings " & Session("intLoginID").ToString

        'drUserSetting = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drUserSetting.Read Then
        '    blnEarliarNavigationStyle = CType(CommonFunction.Data.CheckIsDBNull(drUserSetting("EarlierNavigationStyle"), "0"), Boolean)
        'End If

        'CommonFunction.Data.DisposeDataReader(drUserSetting)

        '***************************************************************
        'End of addition by PrashantSJ on 9th June 2009 Purpose:To Get User setting details (Navigation style)
        '***************************************************************
    End Sub
    Private Function GetRole() As String
        '=====================================================================
        ' Procedure Name		:	GetRole
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To set the loggied users role
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	22 Apr 2002
        ' Revisions				:	22 APr 2002
        '=====================================================================

        Dim drRoleName As IDataReader
        Dim strSQL As String

        'Added By Chakshuta H on 29th-Oct-2015
        '--------------------------------------------------------------------------------------------------------------------------------
        'Modifed By Shrikant B On 3 Dec 2008 For WAF3_GEN_18
        If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = CType(Session("LCID"), Long) Then
            strSQL = "EXEC usp_Sel_tbl_PM_Role_Culture " & CType(Session("intPostID"), Long)
        Else
            strSQL = "EXEC usp_Sel_tbl_PM_Role_Culture " & CType(Session("intPostID"), Long) & "," & CType(Session("LCID"), Long)
        End If
        GetRole = CType(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        'Modification End By Shrikant B On 3 Dec 2008 For WAF3_GEN_18
        'Ended By Chakshuta H on 29th-Oct-2015
        'Added By Chakshuta H on 29th-Oct-2015
        'Commented By Shrikant B On 3 Dec 2008 For WAF3_GEN_18 


        'strSQL = "EXEC usp_Sel_tbl_PM_Role " & CType(Session("intPostID"), Long)
        'drRoleName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'If drRoleName.Read Then
        '    GetRole = CType(drRoleName("RoleDescription"), String) & ""
        'End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
        'drRoleName.Close()
        'Comment End by Shriaknt B On 3 Dec 2008 For WAF3_GEN_18
        '--------------------------------------------------------------------------------------------------------------------------------
        'End Of Addition By Chakshuta H on 29th-Oct-2015

        CommonFunction.Data.DisposeDataReader(drRoleName)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 


    End Function
    'Added By VarunA on 9-May-2008
    Private Function SetMyProjectLink() As String
        '==================================================================
        ' Procedure Name		: SetMyProjectLink
        ' Description           : Set My Project 
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set My Project
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : VarunA
        ' Created               : 9 May ,2008
        '=====================================================================

        If CType(Session("LoginType"), String) = "E" Then
            Return "<TD class=clsLinkPageHeaderInner width='100%' align='Right'>|&nbsp;<A class=SetAsDefault STYLE=TEXT-DECORATION:NONE HRef=" & Chr(34) & "JavaScript:MyProject_OnClick()" & Chr(34) & ">Project Selection</A>&nbsp;"
        Else
            Return "<TD class=clsLinkPageHeaderInner width='100%' align='Right'>"
        End If

    End Function
    'End By VarunA on 9-May-2008
    Private Function SetDefaultProjectLink() As String
        '==================================================================
        ' Procedure Name		: SetDefaultProjectLink
        ' Description           : Set Default Project Link
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set Default Project "Link"
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshsihR
        ' Created               : 22 Apr ,2002
        ' Revisions             : 22 Apr ,2002
        '=====================================================================

        'Modified by NitinC on 28 Sept 2011 for WhizibleSEM10.0 (alignment)
        'If Project is not selected then don't show the link
        If Not Session("intProjectID") Is Nothing Then
            'Commented & Modified By VarunA on 9-May-2008
            'Return "<TD class=clsLinkPageHeaderInner width='100%' align='Right'>|" & MyBase.GetResourceString("SET_AS_DEFAULT") & "&nbsp;<A class=SetAsDefault HRef=" & Chr(34) & "JavaScript:SetDefaultProject()" & Chr(34) & ">" & MyBase.GetResourceString("PROJECT") & "</A>/"

            'Added by Dhanashri
            Return "|&nbsp;" & MyBase.GetResourceString("SET_AS_DEFAULT") & "&nbsp;<A class=SetAsDefault style=font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:SetDefaultProject()" & Chr(34) & ">" & MyBase.GetResourceString("PROJECT") & "</A>/"
        Else
            'Return "<TD class=clsLinkPageHeaderInner width='100%' align='Right'>| " & MyBase.GetResourceString("SET_AS_DEFAULT") & "&nbsp;"
            Return "|&nbsp;" & MyBase.GetResourceString("SET_AS_DEFAULT") & "&nbsp;"

            'Ended by Dhanashri

            'End By VarunA on 9-May-2008
        End If
        'END Modified by NitinC on 28 Sept 2011 for WhizibleSEM10.0 (alignment)


    End Function
    Private Function ResetDefaultLink() As String
        '==================================================================
        ' Procedure Name		: ResetDefaultLink
        ' Description           : Render the Reset Default link
        ' Purpose               : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML for rendering the Reset Default link
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 26th March 2004
        ' Revisions             : 
        '=====================================================================

        'Modified by NitinC on 28 Sept 2011 for WhizibleSEM10.0 (alignment)
        Dim strSQL As String
        Dim strLink As String
        'If the UserID and LoginType are available in the session
        If Not (Session("intUserID") Is Nothing Or Session("LoginType") Is Nothing) Then
            'Display the link only if the defaults for project of tab exist
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''strSQL = "SELECT EmployeeID FROM tbl_PM_DefaultTabProject WHERE EmployeeID =" + Session("intUserID").ToString + " AND LoginType ='" + Session("LoginType").ToString + "'"
            strSQL = "usp_sEL_tbl_PM_DefaultTabProject_EmployeeID " + Session("intUserID").ToString + ",'" + Session("LoginType").ToString + "'"
            ''eND OF Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            If Not (CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)) Is Nothing) Then

                'Added by Dhanashri on 5 Mar 2015
                ''strLink = "&nbsp;<br>&nbsp;|&nbsp;<A class=SetAsDefault style=font-size:11px;font-weight:bolder HRef=" + Chr(34) + "JavaScript:ResetDefault()" + Chr(34) + ">" + "<u>" + MyBase.GetResourceString("RESET_DEFAULTS") + "</u>" + "</A>&nbsp;|&nbsp;"
                ' ADDED BY PUNEET M ON 23-06-2015. PURPOSE: 
                'Commeted & Added By Dipali V On 27th Aug 2020 For Theme Remove
                'strLink = "&nbsp;&nbsp;|&nbsp;<A class=SetAsDefault style=font-size:11px;font-weight:bolder HRef=" + Chr(34) + "JavaScript:ResetDefault()" + Chr(34) + ">" + "<u>" + MyBase.GetResourceString("RESET_DEFAULTS") + "</u>" + "</A>&nbsp;|&nbsp;"
                strLink = "&nbsp;&nbsp;|&nbsp;<A class=SetAsDefault style=font-size:11px;font-weight:bolder HRef=" + Chr(34) + "JavaScript:ResetDefault()" + Chr(34) + ">" + "<u>" + MyBase.GetResourceString("RESET_DEFAULTS") + "</u>" + "</A>&nbsp;"
                'End of Commeted & Added By Dipali V On 27th Aug 2020 For Theme Remove
                'Ended by dhanashri

            End If
            Return (strLink)
        End If
        'End Modified by NitinC on 28 Sept 2011 for WhizibleSEM10.0 (alignment)
    End Function
    Private Function SetDefaultModuleLink() As String
        '==================================================================
        ' Procedure Name		: SetDefaultModuleLink
        ' Description           : Set Default Modul link
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set Default module "Link"
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshsihR
        ' Created               : 22 Apr ,2002
        ' Revisions             : 22 Apr ,2002
        '=====================================================================

        'Modified by NitinC on 28 Sept 2011 for WhizibleSEM10.0 (alignment)

        'Added by Dhanashri on 5 Mar 2015
        If Not Session("intProjectID") Is Nothing Then
            Return ("<A class=SetAsDefault style=font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:SetDefaultModule()" & Chr(34) & ">" & "<u>" & MyBase.GetResourceString("TAB") & "</u>" & "</A>&nbsp;|")
        Else
            Return ("<A class=SetAsDefault style=font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:SetDefaultModule()" & Chr(34) & ">" & "<u>" & MyBase.GetResourceString("TAB") & "</u>" & "</A>&nbsp;|")
        End If
        'Ended by Dhanashri

        'End Modified by NitinC on 28 Sept 2011 for WhizibleSEM10.0 (alignment)

    End Function
    Private Function SetMyProfileLink() As String
        '==================================================================
        ' Procedure Name		: SetMyProfileLink
        ' Description           : Set My Profile Link
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set My Profile "Link"
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshsihR
        ' Created               : 1 May ,2002
        ' Revisions             : 1 May ,2002
        '=====================================================================

        'Check for the show profile flag
        If CommonFunctions.Application.ShowMyProfile = True Then
            'Modified by MrugajaB on 10th Nov 2006
            'Change reverted back
            'Commendted and Modified By JyotiG
            'Start_JG_CR_7172_06-Nov-2006

            'Added by Dhanashri on 5 Mar 2015
            Return "<A class=SetAsDefault STYLE=TEXT-DECORATION:NONE;font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:MyProfile_OnClick()" & Chr(34) & ">" & "<u>" & MyBase.GetResourceString("MY_PROFILE") & "</u>" & "</A>&nbsp;|"
            'Ended by Dhanashri 

            'Return "<A Title='My Profile' class=SetAsDefault STYLE=TEXT-DECORATION:NONE HRef=" & Chr(34) & "JavaScript:MyProfile_OnClick()" & Chr(34) & "><img border=0 src='../DB/Images/Profile2.gif' ></A>&nbsp;|"
            'End_JG_06-Nov-2006
            'End
        Else
            Return ""
        End If


    End Function

    Private Function SetMyTheme() As String
        '==================================================================
        ' Procedure Name		: SetMyTheme
        ' Description           : Set My Theme
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set My Theme
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : NileshD
        ' Created               : 7 September ,2004
        ' Revisions             : 7 September ,2004
        '=====================================================================

        'Check for the show profile flag
        If CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_USER_STYLESHEET", "ENABLED") Then
            'Modified by MrugajaB on 10th Nov 2006
            'Change reverted back
            'Commented and Modified By JyotiG
            'Start_JG_CR_7172_06-Nov-2006
            'Commented BY Dipali V On 27th Aug 2020 For Remove Theme Link
            'Added by Dhanashri on 5 Mar 2015
            'Return "<A class=SetAsDefault STYLE=TEXT-DECORATION:NONE;font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:MyTheme_OnClick()" & Chr(34) & ">" & MyBase.GetResourceString("MY_THEME") & "</A>&nbsp;|"
            'Ended by Dhanashri
            'End of Commented BY Dipali V On 27th Aug 2020 For Remove Theme Link
            'Return "<A Title ='My Theme' class=SetAsDefault STYLE=TEXT-DECORATION:NONE HRef=" & Chr(34) & "JavaScript:MyTheme_OnClick()" & Chr(34) & "><img border=0 src='../DB/Images/Palette.gif' ></A>&nbsp;|"
            'End_JG_06-Nov-2006
            'End 
        Else
            Return ""
        End If


    End Function
    Private Function DocumentDownLoad() As String
        '==================================================================
        ' Procedure Name		: DocumentDownLoad
        ' Description           : Set My Theme
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set My Theme
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : NileshD
        ' Created               : 7 September ,2004
        ' Revisions             : 7 September ,2004
        '=====================================================================
        Dim strSQLQuery As String
        Dim intaccess As String

        strSQLQuery = "usp_Documents_AllowedToView " & Session("intPostID")
        intaccess = CType(CommonFunction.Data.GetDataScalar(strSQLQuery, True), String)

        'If (Args.LinkName.ToUpper = "SAVE") And (intCapDefinationEditAccess = "" Or intIfUsed = "1") Then
        'Check for the show profile flag
        'If CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_USER_STYLESHEET", "ENABLED") Then
        'Modified by MrugajaB on 10th Nov 2006
        'Change reverted back
        'Commented and Modified By JyotiG
        'Start_JG_CR_7172_06-Nov-2006

        'Added by Dhanashri on 5 Mar 2015
        Return "<A class=SetAsDefault STYLE=TEXT-DECORATION:NONE;font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:Documents_OnClick()" & Chr(34) & ">" & "Documents" & "</A>&nbsp;|"
        'Ended by Dhanashri

        'Return "<A Title ='My Theme' class=SetAsDefault STYLE=TEXT-DECORATION:NONE HRef=" & Chr(34) & "JavaScript:MyTheme_OnClick()" & Chr(34) & "><img border=0 src='../DB/Images/Palette.gif' ></A>&nbsp;|"
        'End_JG_06-Nov-2006
        'End 
        'Else
        'Return ""
        'End If


    End Function
    'Added By Chakshuta H on 29th-Oct-2015
    Private Function SetMySiteMap() As String
        '==================================================================
        ' Procedure Name		: SetMySiteMap
        ' Description           : Set My SiteMap
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : Set My SiteMap
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Vinay 
        ' Created               : 25 Aug,2008
        ' Revisions             : 25 Aug,2008
        '=====================================================================

        'Check for the show profile flag
        If CommonFunctions.General.GetFrameworkSettings("GEN_SAAS", "ENABLED") Then
            Return "<A class=SetAsDefault STYLE=TEXT-DECORATION:NONE HRef= " & Chr(34) & "JavaScript:MySiteMap_OnClick()" & Chr(34) & "> " & MyBase.GetResourceString("MY_SITEMAP") & "</A>&nbsp;|"
        Else
            Return ""
        End If


    End Function
    'Ended By Chakshuta H on 29th-Oct-2015
    Private Function GetFileWhatsNew() As String
        '==================================================================
        ' Procedure Name		: GetFile
        ' Description           : Get the size of the specified file.
        ' Purpose               : Get the size of the specified file.
        ' Parameters Passed     : strFileName - Full Path of the File.
        ' Returns               : File Size
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshsihR
        ' Created               : 10 Sept.,2001
        ' Revisions             : 10 Sept.,2001
        '=====================================================================
        'check for file existance
        Dim strFileName As String
        strFileName = Server.MapPath("../../Attachments") & "\" & "WhatsNew.pdf"

        If CommonFunction.FileDirectory.IsFileExists(strFileName) = True Then

            Return "|<A STYLE=TEXT-DECORATION:NONE HRef='../../Attachments/WhatsNew.pdf' target=_new><B>" & MyBase.GetResourceString("WHATS_NEW") & " |</A>&nbsp;&nbsp;</tD>"
        Else
            Return ""

        End If

    End Function
    Private Sub SetDefaultProject()
        '==================================================================
        ' Procedure Name		: SetDefaultProject
        ' Description           : Set Default Project for the user
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshsihR
        ' Created               : 22 Apr ,2002
        ' Revisions             : 22 Apr ,2002
        '=====================================================================

        Dim lngCount As Long

        lngCount = CommonFunction.Data.SQLInsertOrUpdateData("EXEC usp_Ins_Upd_tbl_PM_DefaultTabProject " & Session("intUserID").ToString & "," & Session("intProjectID").ToString & ",Null,'" & Session("LoginType").ToString & "'")

    End Sub
    Private Sub SetDefaultTab()
        '==================================================================
        ' Procedure Name		: SetDefaultTab
        ' Description           : Set Default tabe for the user
        ' Purpose               : 
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AshsihR
        ' Created               : 22 Apr ,2002
        ' Revisions             : 22 Apr ,2002
        '=====================================================================

        Dim lngCount As Long

        lngCount = CommonFunction.Data.SQLInsertOrUpdateData("EXEC usp_Ins_Upd_tbl_PM_DefaultTabProject " & Session("intUserID").ToString & ",Null," & "'" & Session("strActiveModule").ToString & "','" & Session("LoginType").ToString & "'")

    End Sub

    Private Sub ResetDefault()
        '==================================================================
        ' Procedure Name		: ResetDefault
        ' Description           : Reset the default settings for the user
        ' Purpose               : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 26th March 2004
        ' Revisions             : 
        '=====================================================================
        If Not (Session("intUserID") Is Nothing Or Session("LoginType") Is Nothing) Then
            Dim strUserID As String = Session("intUserID").ToString
            Dim strLoginType As String = Session("LoginType").ToString
            Dim strSQL As String

            'Delete the record for the user identified by UserID and LoginType from tbl_PM_DefaultTabProject
            strSQL = "usp_Del_tbl_PM_DefaultTabProject " + strUserID + ", '" + strLoginType + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If

    End Sub
    Public Sub GetNavigationLinkForSelectedTab(ByVal strShortName As String, ByVal intWidth As Integer, _
                ByVal strModuleName As String)
        If m_blnDefaultNavigation = True Then
            'intFrameWidth = CType(objSystemModulesAry(intCount).FrameWidth, Integer)
            intFrameWidth = intWidth
            'Response.Write("clsTDSelected ID=ignore ")
            Response.Write("<span id='selected'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode(strModuleName)))
            Response.Write("</span>")

        Else
            'If m_RADMenu Is Nothing Then
            '    m_RADMenu = New EventMenu(New InheritableMenu)
            '    m_RADMenu.ID = "menu1"




            '    m_MenuGroup = New EventMenuGroup
            '    m_MenuGroup.EventHandler = Me
            '    m_RADMenu.RootGroup = m_MenuGroup
            '    m_MenuGroup.Flow = "vertical"

            '    m_RADMenu.ImagesBaseDir = "../../Images"

            'End If

            Dim objMenuItem As New EventMenuItem
            If (strShortName.Equals(m_ActiveMenu.ID)) Then
                objMenuItem = m_ActiveMenu

            Else
                objMenuItem.ID = strShortName
            End If
            objMenuItem.StatusBarTip = strShortName
            objMenuItem.DefaultGroupScrollHeight = m_RADMenu.DefaultGroupScrollHeight
            m_RADMenu.RootGroup.AddItem(objMenuItem)
            objMenuItem.Label = strModuleName


        End If

    End Sub
    Public Sub GetNavigationLinkForSelectedTab(ByVal objSystemModule As CommonEngines.HashTables.SystemModules)
        '-------------------------------------------------------------------------------------------------------------
        ' Requirement Tag       : WAF3_GEN_1
        ' Procedure Name        : GetNavigationLinkForSelectedTab
        ' Description           : This procedure overloads above procedure to pass hashtable object
        '                         instead of passing number of arguments.
        ' Purpose               : Same as above
        ' Parameters Passed     : CommonEngines.HashTables.SystemModules object
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Thursday, December 15, 2005
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------
        Dim sbScript As New StringBuilder("")

        If m_blnDefaultNavigation = True Then
            'intFrameWidth = CType(objSystemModulesAry(intCount).FrameWidth, Integer)
            intFrameWidth = CType(objSystemModule.FrameWidth, Integer)
            'Response.Write("clsTDSelected ID=ignore ")
            If m_blnEnableTabNavigation = True Then
                ' Response.Write("<span ")
                sbScript.Append("<span ")
                If CommonFunctions.General.CheckIsNothing(objSystemModule.CSSClassNameForSelectedTab, "") = "" Then
                    ' Response.Write("id='selected'>")
                    sbScript.Append("id='selected'>")
                Else
                    ' Response.Write("id='" + objSystemModule.CSSClassNameForSelectedTab + "'>")
                    sbScript.Append("id='" + objSystemModule.CSSClassNameForSelectedTab + "'>")
                End If
                If objSystemModule.HideModuleNameOnTab = False Then
                    ' Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
                    sbScript.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
                End If
                '  Response.Write("</span>")
                sbScript.Append("</span>")
            Else
                'Response.Write("<a ")
                sbScript.Append("<a ")
                If CommonFunctions.General.CheckIsNothing(objSystemModule.CSSClassNameForSelectedTab, "") = "" Then
                    '  Response.Write("class='clsSelected' ")
                    sbScript.Append("class='clsSelected' ")
                Else
                    ' Response.Write("class='" + objSystemModule.CSSClassNameForSelectedTab + "'")
                    sbScript.Append("class='" + objSystemModule.CSSClassNameForSelectedTab + "'")
                End If
                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                'Reason      - To plot all the links in one TD tag.
                '-------------------------------------------------------------------------------------------------------------
                ' Response.Write(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ToolTip)) & "' ")
                sbScript.Append(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ToolTip)) & "' ")

                ' Response.Write("href='javascript:Tab_OnClick(" & Chr(34) & objSystemModule.ShortName & Chr(34) & ")'>")
                sbScript.Append("href='javascript:Tab_OnClick(" & Chr(34) & objSystemModule.ShortName & Chr(34) & ")'>")

                If objSystemModule.HideModuleNameOnTab = False Then
                    ' Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
                    sbScript.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
                End If
                ' Response.Write("</a>")
                sbScript.Append("</a>")

                If objSystemModule.HideModuleNameOnTab = False Then
                    '  Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")
                    sbScript.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
                End If
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                '-------------------------------------------------------------------------------------------------------------
            End If
            Response.Write(sbScript.ToString)
        Else
            'If m_RADMenu Is Nothing Then
            '    m_RADMenu = New EventMenu(New InheritableMenu)
            '    m_RADMenu.ID = "menu1"

            '    m_MenuGroup = New EventMenuGroup
            '    m_MenuGroup.EventHandler = Me
            '    m_RADMenu.RootGroup = m_MenuGroup
            '    m_MenuGroup.Flow = "vertical"

            '    m_RADMenu.ImagesBaseDir = "../../Images"

            'End If


            Dim objMenuItem As New EventMenuItem
            If (objSystemModule.ShortName.Equals(m_ActiveMenu.ID)) Then
                objMenuItem = m_ActiveMenu

            Else
                objMenuItem.ID = objSystemModule.ShortName
            End If
            objMenuItem.StatusBarTip = objSystemModule.ShortName
            objMenuItem.DefaultGroupScrollHeight = m_RADMenu.DefaultGroupScrollHeight
            m_RADMenu.RootGroup.AddItem(objMenuItem)
            objMenuItem.Label = objSystemModule.ModuleName

        End If

        If Not blnEarliarNavigationStyle Then
            sbSQL.Append(" SELECT " + objSystemModule.OrderNumber.ToString + ",'" + CommonFunction.General.BuildQueryString(sbScript.ToString) + "' UNION ")
        End If

        sbScript = Nothing
    End Sub

    Public Sub GetNavigationLinkForTab(ByVal strShortName As String, ByVal strModuleName As String)
        If m_blnDefaultNavigation = True Then
            'Response.Write("clsTDNormal ")
            '<a class='navtab' href='javascript:Tab_OnClick("RM")'>RESOURCES</a>
            Response.Write("<a class='navtab' href='javascript:Tab_OnClick(" & Chr(34) & strShortName & Chr(34) & ")'>")
            Response.Write(CommonFunction.General.FormatString(Server.HtmlEncode(strModuleName)))
            Response.Write("</a>")

        Else
            'If m_RADMenu Is Nothing Then
            '    m_RADMenu = New EventMenu(New InheritableMenu)
            '    m_RADMenu.ID = "menu1"
            '    m_MenuGroup = New EventMenuGroup
            '    m_MenuGroup.EventHandler = Me
            '    m_RADMenu.RootGroup = m_MenuGroup
            '    m_MenuGroup.Flow = "horizontal"
            '    m_RADMenu.ImagesBaseDir = "../../Images"
            'End If
            Dim objMenuItem As New EventMenuItem
            If (strShortName.Equals(m_ActiveMenu.ID)) Then
                objMenuItem = m_ActiveMenu

            Else
                objMenuItem.ID = strShortName
            End If
            objMenuItem.StatusBarTip = strShortName
            objMenuItem.DefaultGroupScrollHeight = m_RADMenu.DefaultGroupScrollHeight
            m_RADMenu.RootGroup.AddItem(objMenuItem)
            objMenuItem.Label = strModuleName
        End If

    End Sub

    Public Sub GetNavigationLinkForTab(ByVal objSystemModule As CommonEngines.HashTables.SystemModules)
        '-------------------------------------------------------------------------------------------------------------
        ' Requirement Tag       : WAF3_GEN_1
        ' Procedure Name        : GetNavigationLinkForTab
        ' Description           : This procedure overloads above procedure to pass hashtable object
        '                         instead of passing number of arguments.
        ' Purpose               : Same as above
        ' Parameters Passed     : CommonEngines.HashTables.SystemModules object
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : Thursday, December 15, 2005
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------
        Exit Sub

        Dim sbScript As New StringBuilder

        If objSystemModule.HideModuleNameOnTab Then
            Exit Sub
        End If

        'If Not blnEarliarNavigationStyle And (objSystemModule.ShortName.ToUpper = "SM" Or objSystemModule.ShortName.ToUpper = "RM" Or objSystemModule.ShortName.ToUpper = "PRO" Or objSystemModule.ShortName.ToUpper = "BTS" Or objSystemModule.ShortName.ToUpper = "DT") Then
        '    Exit Sub
        'End If




        If m_blnDefaultNavigation = True Then
            'Response.Write("clsTDNormal ")
            '<a class='navtab' href='javascript:Tab_OnClick("RM")'>RESOURCES</a>
            sbScript.Append("<a ")
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            'Reason      - For applying new navigation theme.
            '-------------------------------------------------------------------------------------------------------------
            If m_blnEnableTabNavigation = True Then
                If CommonFunctions.General.CheckIsNothing(objSystemModule.CSSClassName, "") = "" Then
                    sbScript.Append("class='navtab' ")
                Else
                    sbScript.Append("class='" + objSystemModule.CSSClassName + "' ")
                End If
                sbScript.Append("href='javascript:Tab_OnClick(" & Chr(34) & objSystemModule.ShortName & Chr(34) & ")'>")
                If objSystemModule.HideModuleNameOnTab = False Then
                    sbScript.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
                End If
                sbScript.Append("</a>")
            Else
                If CommonFunctions.General.CheckIsNothing(objSystemModule.CSSClassName, "") = "" Then
                    sbScript.Append("class='clsNavTab' ")
                Else
                    sbScript.Append("class='" + objSystemModule.CSSClassName + "' ")
                End If
                '-------------------------------------------------------------------------------------------------------------
                'Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                'Reason      - To plot all the links in one TD tag.
                '-------------------------------------------------------------------------------------------------------------
                sbScript.Append(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ToolTip)) & "' ")

                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
                '-------------------------------------------------------------------------------------------------------------

                sbScript.Append("href='javascript:Tab_OnClick(" & Chr(34) & objSystemModule.ShortName & Chr(34) & ")'>")
                If objSystemModule.HideModuleNameOnTab = False Then
                    sbScript.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
                End If
                sbScript.Append("</a>")
                If objSystemModule.HideModuleNameOnTab = False Then
                    sbScript.Append("&nbsp;&nbsp;&nbsp;&nbsp;")
                End If
            End If
            '-------------------------------------------------------------------------------------------------------------
            'Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
            '-------------------------------------------------------------------------------------------------------------

            '-------------------------------------------------------------------------------------------------------------
            'Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            '-------------------------------------------------------------------------------------------------------------

        Else
            'If m_RADMenu Is Nothing Then
            '    m_RADMenu = New EventMenu(New InheritableMenu)
            '    m_RADMenu.ID = "menu1"
            '    m_MenuGroup = New EventMenuGroup
            '    m_MenuGroup.EventHandler = Me
            '    m_RADMenu.RootGroup = m_MenuGroup
            '    m_MenuGroup.Flow = "horizontal"
            '    m_RADMenu.ImagesBaseDir = "../../Images"
            'End If
            Dim objMenuItem As New EventMenuItem
            If (objSystemModule.ShortName.Equals(m_ActiveMenu.ID)) Then
                objMenuItem = m_ActiveMenu
            Else
                objMenuItem.ID = objSystemModule.ShortName
            End If
            objMenuItem.StatusBarTip = objSystemModule.ShortName
            objMenuItem.DefaultGroupScrollHeight = m_RADMenu.DefaultGroupScrollHeight
            m_RADMenu.RootGroup.AddItem(objMenuItem)
            objMenuItem.Label = objSystemModule.ModuleName
        End If

        If Not blnEarliarNavigationStyle Then
            Response.Write(sbScript.ToString)
        Else
            sbSQL.Append(" SELECT " + objSystemModule.OrderNumber.ToString + ",'" + CommonFunction.General.BuildQueryString(sbScript.ToString) + "' UNION ")
        End If

        sbScript = Nothing
    End Sub
    ''Added by swapnil A for ChangeUser [single sign on] on 14-12-2015
    Public Sub PlotChangeUser()


        CommonFunction.General.WriteHTML("<TD style=font-size:11px;font-weight:bolder nowrap title='Change User'>")

        ''Commented And Added By Vaijat k ON 10/02/2016 for space between text(Change User)
        ''CommonFunction.General.WriteHTML("&nbsp;&nbsp;<a class='navtab' style=font-size:11px;font-weight:bolder;margin-right:10px;matgin-bottom:5px href='javascript:changeUser()'>ChangeUser</a>")
        CommonFunction.General.WriteHTML("&nbsp;&nbsp;<a class='navtab' style=font-size:11px;font-weight:bolder;margin-right:10px;matgin-bottom:5px href='javascript:changeUser()'>Change User</a>")

        CommonFunction.General.WriteHTML("</TD>")

        ''Added By Bharat T on 18th-Aug-2017 for Whzible Wrapper Changes
        CommonFunction.General.WriteHTML("<TD style=font-size:11px;font-weight:bolder nowrap title='Whizible Wrapper'>")

        CommonFunction.General.WriteHTML("&nbsp;&nbsp;<a class='navtab' style=font-size:11px;font-weight:bolder;margin-right:10px;matgin-bottom:5px href='javascript:OpenWrapperSite()'>Whizible Wrapper</a>")

        CommonFunction.General.WriteHTML("</TD>")
        ''End of Added By Bharat T on 18th-Aug-2017 for Whzible Wrapper Changes


    End Sub
    ''Ended by swapnil A for ChangeUser [single sign on] on 14-12-2015


    Public Sub PlotTabsTable()
        If m_blnDefaultNavigation = True Then
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            'Reason      - For applying new navigation theme.
            '-------------------------------------------------------------------------------------------------------------
            If m_blnEnableTabNavigation = True Then
                CommonFunction.General.WriteHTML("<TABLE BORDER=0 cellspacing=0 width=99.9% cellpadding=0>")
                CommonFunction.General.WriteHTML("<TR>")

                CommonFunction.General.WriteHTML("<TD valign=bottom align=right>")
                CommonFunction.General.WriteHTML("<TABLE valign=bottom BORDER=0 class=clsTable cellspacing=0 width=100 height=22>")
                CommonFunction.General.WriteHTML("<TR>")
            Else
                'Dhanashri
                CommonFunction.General.WriteHTML("<TABLE cellspacing=0 width=99.9% cellpadding=0 class=clsTableBannerFrame>")
                CommonFunction.General.WriteHTML("<TR class=clsTRBanner>")
                CommonFunction.General.WriteHTML("<TD valign=middle align=left height=30px>")

                'For Image Frame
                Dim intCount As Integer
                CommonFunction.General.WriteHTML("<TABLE valign=middle width=99.9% class=clsTableBannerFrame cellpadding=0 cellspacing=0>")
                CommonFunction.General.WriteHTML("<TR>")
                ''PrashantSJ on 4th June 2009
                If blnEarliarNavigationStyle Then
                    CommonFunction.General.WriteHTML("<TD width=90px height=30px valign=middle align=left nowrap>")
                    If m_blnShowLogoOnNavigationPage = True Then
                        '-------------------------------------------------------------------------------------------------------------
                        'Added By - PrashantSJ On - Thursday, May 28, 2009 For WhizibleSEM 8.1
                        'Reason      - To plot all the links in one div.
                        '-------------------------------------------------------------------------------------------------------------

                        'CommonFunction.General.WriteHTML("<img alt=""Site Logo"" src=""../../images/symbol.gif"" onclick='javascript:ShowModuleDiv(event)' style='cursor:hand;'>")

                        '-------------------------------------------------------------------------------------------------------------
                        'Ended By - PrashantSJ On - Thursday, May 28, 2009 For WhizibleSEM 8.1
                        '-------------------------------------------------------------------------------------------------------------
                        CommonFunction.General.WriteHTML("<img alt=""Site Logo"" src=""../../images/symbol.gif"">")
                    End If
                    CommonFunction.General.WriteHTML("</TD>")
                End If
                ''PrashantSJ on 4th June 2009

                ' Added By ShraddhaM for WhizibleSEM8_Whiz3 on 3,July 2008 
                ' Purpose : To remove ModuleNames and add in logout link row.
                'Dhanashri
                CommonFunction.General.WriteHTML("<TD>")
                CommonFunction.General.WriteHTML("<TABLE cellpadding=0 align=right cellspacing=0 class=clsTableNavLinks width=99.9%>")
                CommonFunction.General.WriteHTML("<TR class=clsTRNavLinks valign=middle height=30px>")

                'If Not blnEarliarNavigationStyle Then
                '    CommonFunction.General.WriteHTML("<TD noWrap>")
                '    CommonFunction.General.WriteHTML("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousModule()"" Title=""Previous Modules"" onmouseover=""window.status='Previous Modules';return true;"" onmouseout=""window.status=' ';return true;"">")
                '    CommonFunction.General.WriteHTML("<Img Border=0 src='../../Images/Home/roundleft.gif' align='top'></A>")
                '    CommonFunction.General.WriteHTML("</TD>")
                '    CommonFunction.General.WriteHTML("<TD id='tdModule' noWrap>")
                'Else
                CommonFunction.General.WriteHTML("<TD  noWrap>")
                'End If

                Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")
                ' ***********************************************************************************
                ' Modification Ends Nov 06, 2004 RajeshB  R.No:WAF2_PB_46
                ' ***********************************************************************************
                Dim intCurrPostID As Integer
                Dim intProjectRoleID As Integer
                Dim intCorpRoleID As Integer
                Dim intProjectID As Integer

                If Not objSystemModulesAry Is Nothing Then
                    For intCount = 0 To objSystemModulesAry.Length - 1
                        'Modified by MrugajaB on 9th March 2006 for WhizibleSEM 6.0 (Issue ID.685)
                        'Purpose:When issues module is to be plotted and Role level for logged in user is 'low' then ,display of issues module will depend upon other projects assigned to the esource
                        intCurrPostID = CType(Session("intPostID"), Integer)
                        If (objSystemModulesAry(intCount).ModuleTagID = 5) And (CType(Session("intRoleLevel"), Integer) = 3) And (intCurrPostID <> 23) Then
                            intProjectID = CType(CommonFunction.General.CheckIsNothing(Session("intProjectID"), "0"), Integer)
                            intCurrPostID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_sel_IssuesModule_Role " + CType(intProjectID, String) + "," + CType(Session("intUserID"), String), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), Integer)
                        End If
                        'End Modification
                        'Create the object of global class
                        'Dim objGlobal As New WebPage.Templates.Global(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)

                        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(intCurrPostID, Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                        'Create the object of GetAccess class
                        Dim objGetAccess As New WebPage.Templates.AccessRights
                        'Call method get access to get the access
                        objGetAccess.GetAccess(objGlobal, True)

                        Dim dXMLSet As New DataSet()
                        Dim dXMLRdr As DataTableReader
                        Dim strModule, strLicences As String
                        Dim m_strModuleID As Integer

                        'Call CommonFunction.Data.InsertOrUpdateData("Exec usp_sel_rolewise_ModuleAccess", MyBase.UseSQL)
                        'If MLCommonFunction.ML_CommonFunction.Validate_Modulexml(strXMLPath) = True Then
                        Try
                            If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                                dXMLSet.ReadXml(strXMLPath)
                                dXMLRdr = dXMLSet.CreateDataReader()
                                While dXMLRdr.Read()
                                    strLicences = MLCommonFunction.ML_CommonFunction.Decrypt(dXMLRdr("Licences_Text").ToString())
                                    strModule = strLicences.Substring(strLicences.IndexOf("/") + 1, strLicences.LastIndexOf("/") - (strLicences.IndexOf("/") + 1))
                                    strLicences = strLicences.Substring(strLicences.LastIndexOf("/") + 1)
                                    If strLicences = "" Or strLicences = "0" Then
                                        Call CommonFunction.Data.InsertOrUpdateData("Update tbl_PM_Login_AccessibleModules Set IsActive= 0  Where ModuleID=" & strModule.ToString, MyBase.UseSQL)
                                    End If

                                End While
                            End If
                        Catch ex As Exception
                            Response.Write(ex.Message)
                        Finally
                        End Try
                        'End of Addition
                        'Integration by Shraddha M on 12,Apr
                        'added by Sanas
                        Dim ModuleAccess As Boolean
                        ModuleAccess = CommonFunction.Data.GetDataScalar("usp_sel_employee_accessibleModule_ModuleLicensing " + Session("intLoginID").ToString + "," + objSystemModulesAry(intCount).ModuleTagID.ToString + "," + Session("LoginType").ToString, True)
                        'Commented by Sanas


                        'If objGetAccess.Access = True Then
                        If ModuleAccess = True Then
                            'If customer created login is there then ignore the configuration tab.
                            'If objSystemModulesAry(intCount).ShortName = "SM" And CType(Session("IsCreatedByCustomer"), Boolean) = True Then
                            '    Else
                            'Code Added By PradipK  for IssueID 4601 
                            'Comments Removed By AmitJ For FourSoft IssueId 4601 => Client login can create client logins which is wrong
                            If objSystemModulesAry(intCount).ShortName = "SM" And CType(Session("IsCreatedByCustomer"), Boolean) = True Then
                            Else
                                'End of Modification By AmitJ

                                '-------------------------------------------------------------------------------------------------------------
                                'Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                                'Reason      - To plot all the links in one TD tag.
                                '-------------------------------------------------------------------------------------------------------------
                                If m_blnEnableTabNavigation = True Then

                                    PlotTabTD(objSystemModulesAry(intCount).ToolTip, objSystemModulesAry(intCount).ShortName)
                                End If
                                '-------------------------------------------------------------------------------------------------------------
                                'Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                                '-------------------------------------------------------------------------------------------------------------


                                '-------------------------------------------------------------------------------------------------------------
                                'Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1 - Images for Module Tabs
                                'Reason      - To pass hashtable object instead of passing number of arguments.
                                '-------------------------------------------------------------------------------------------------------------
                                If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                                    'GetNavigationLinkForSelectedTab(objSystemModulesAry(intCount).ShortName, CType(objSystemModulesAry(intCount).FrameWidth, Integer), objSystemModulesAry(intCount).ModuleName)
                                    GetNavigationLinkForSelectedTab(objSystemModulesAry(intCount))

                                    lngOrderNumber = objSystemModulesAry(intCount).OrderNumber

                                Else

                                    'GetNavigationLinkForTab(objSystemModulesAry(intCount).ShortName, objSystemModulesAry(intCount).ModuleName)
                                    '-------------------------------------------------------------------------------------------------------------
                                    'Added By - PrashantSJ On - Wednesday, June 03, 2009 For WhizibleSEM 8.1
                                    'Reason      - To plot all the links in one div.
                                    '-------------------------------------------------------------------------------------------------------------
                                    GetNavigationLinkForTab(objSystemModulesAry(intCount))
                                    '-------------------------------------------------------------------------------------------------------------
                                    'Ended By - PrashantSJ On - Wednesday, June 03, 2009 For WhizibleSEM 8.1
                                    '-------------------------------------------------------------------------------------------------------------
                                End If
                                '-------------------------------------------------------------------------------------------------------------
                                'Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1 - Images for Module Tabs
                                '-------------------------------------------------------------------------------------------------------------

                                '-------------------------------------------------------------------------------------------------------------
                                'Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                                'Reason      - To plot all the links in one TD tag.
                                '-------------------------------------------------------------------------------------------------------------
                                If m_blnEnableTabNavigation = True Then

                                    PlotTabTDEnd()
                                End If
                                '-------------------------------------------------------------------------------------------------------------
                                'Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                                '-------------------------------------------------------------------------------------------------------------
                                'Added By AmitJ For FourSoft IssueId 4601 => Client login can create client logins which is wrong
                            End If
                            'End OF Addition By AmitJ


                        End If
                        objGlobal = Nothing
                        objGetAccess = Nothing
                    Next
                End If
                objSystemModulesAry = Nothing



                'Response.Write(sbHTML.ToString)


                If Not blnEarliarNavigationStyle Then
                    If sbSQL.Length > 0 Then
                        sbSQL.Remove(sbSQL.Length - 6, 6)
                    End If
                    sbSQL.Append(" ORDER BY 1 ")

                    'CommonFunction.General.WriteHTML("<TD noWrap>")
                    'CommonFunction.General.WriteHTML("<A style='TEXT-DECORATION:NONE'  HREF=""Javascript:ShowNextModule()""  onmousedown=""ScrollTillEnd()"" Title=""Next Modules"" onmouseover=""window.status='Next Modules';return true;"" onmouseout=""window.status=' ';return true;"">")
                    'CommonFunction.General.WriteHTML("<Img Border=0 src='../../Images/Home/roundright.gif' align='top'></A>")
                    'CommonFunction.General.WriteHTML("</TD>")

                    PlotTabEnd1()
                End If
                '-------------------------------------------------------------------------------------------------------------
                'Ended By - PrashantSJ On - Thursday, May 28, 2009 For WhizibleSEM 8.1
                '-------------------------------------------------------------------------------------------------------------
                ''Commented by PrashantSJ on 16th June 2009 Purpose: This tab is now moved to Home tab Version : SEM 8.1
                'Added by SrikanthY on 23 Nov 2006
                'If Session("LoginType").ToString = "E" Then
                '    Response.Write("<TD valign=middle align=right width=99% nowrap><a class=clsNavTab Title='Alerts' href='javascript:Alerts_OnClick()'>Alerts</a>&nbsp;&nbsp;<TD>")
                'End If
                ' End of Addition by ShraddhaM
                ''Comment end by PrashantSJ on 16th June 2009
                'Added by KIRAN K K  For DocumentDownloadLink.
                ''*****************************************************************************
                Dim RoleIdForDocumentDownload = CType(Session("intPostID"), Integer)
                Dim strSQLQuery As New System.Text.StringBuilder
                Dim IsAuthorizedForLink As Integer

                'If RoleIdForDocumentDownload Then
                strSQLQuery = New StringBuilder()
                strSQLQuery.Append("Exec usp_IsAuthoriseToViewDocument ")
                strSQLQuery.Append(RoleIdForDocumentDownload)
                IsAuthorizedForLink = CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString, MyBase.UseSQL)
                'strSQLQuery = New StringBuilder()
                'strSQLQuery.Append("Exec usp_Is_AllowedToView ")
                'strSQLQuery.Append(RoleIdForDocumentDownload)
                'IsAuthorizedForLink = CommonFunctions.Data.GetDataScalar(strSQLQuery.ToString, MyBase.UseSQL)
                'End If
                If (IsAuthorizedForLink = 1) Then
                    CommonFunction.General.WriteHTML("<TD Width=50%>")
                    '''''' Args.StringToBeInserted = "<td  align=center><A Title=DownloadLink  HREF=javascript:Download_OnClick(" + DocumentID.ToString + ") id=DownloadLink" + DocumentID.ToString + "  class=clsGridTable value=" + DocumentID.ToString + ">Download</A>"
                    '''' Args.StringToBeInserted &= "</TD>"
                    'CommonFunction.General.WriteHTML("<a class='SetAsDefault' href='javascript:DocumentDownloadLink_OnClick(" & Chr(34) & RoleIdForDocumentDownload & Chr(34) & ")'>Document Download</a>") 'RoleIdForDocumentDownload
                    CommonFunction.General.WriteHTML("<a class='SetAsDefault' STYLE=TEXT-DECORATION:NONE;font-size:11px;font-weight:bolder!important href='javascript:Download_OnClick(" & Chr(34) & RoleIdForDocumentDownload & Chr(34) & ")'>Document Download</a>") 'RoleIdForDocumentDownload
                    'CommonFunction.General.WriteHTML("<a class='SetAsDefault' href='javascript:Download_OnClick(" & Chr(34) & "235" & Chr(34) & ")'>Document Download</a>") 'RoleIdForDocumentDownload
                    'CommonFunction.General.WriteHTML("<A class=SetAsDefault STYLE=TEXT-DECORATION:NONE;font-size:11px;font-weight:bolder HRef=" & Chr(34) & "JavaScript:Documents_OnClick()" & Chr(34) & ">" & "Document Download" & "</A>&nbsp;|")

                    CommonFunction.General.WriteHTML("</TD>")
                End If

                '*****************************************************************************
                'Added End by KIRAN K K  For DocumentDownloadLink.

                ''Added by swapnil A for ChangeUser [single sign on] on 14-12-2015
                Dim strAuthenticationType As String = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString
                If strAuthenticationType = "M" And m_blnIsWindowsAuthenticated = True Then

                    PlotChangeUser()

                Else
                    Dim strLogoutPage As String = CommonFunction.General.GetLogOutPage
                    If strLogoutPage = "" Then strLogoutPage = "../../Default1.aspx"

                    'Code Added By VidyaJ - For Favorites
                    'Call PlotFavoritesTD("Favorites")

                    PlotLogoutTD(strLogoutPage)
                End If
                ''Ended by swapnil A for ChangeUser [single sign on] on 14-12-2015


                CommonFunction.General.WriteHTML("</TR>")
                CommonFunction.General.WriteHTML("</TABLE>")

                CommonFunction.General.WriteHTML("</TD>")
                CommonFunction.General.WriteHTML("</TR>")

                'If Not blnEarliarNavigationStyle Then
                '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboModules", sbSQL.ToString, , , , , True, , , , True))
                '    CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("hidTxtModuleON", "hidTxtModuleON", , , , lngOrderNumber, , , , , , True))
                'End If

                ' Commented By ShraddhaM for WhizibleSEM8_Whiz3 on 3,July 2008 
                ' Purpose : To remove ModuleNames and add in logout link row.
                'CommonFunction.General.WriteHTML("<TR>")


                '''''CommonFunction.General.WriteHTML("<TD valign=bottom align=left>")
                '''''CommonFunction.General.WriteHTML("<TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width=99.9%>")
                '''''CommonFunction.General.WriteHTML("<TR class=clsTRNavLinks valign=middle>")
                ''''''-------------------------------------------------------------------------------------------------------------
                ''''''Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                ''''''Reason      - To plot all the links in one TD tag.
                ''''''-------------------------------------------------------------------------------------------------------------
                ''''''CommonFunctions.General.WriteHTML("<TD noWrap>&nbsp&nbsp</TD>")
                '''''CommonFunction.General.WriteHTML("<TD noWrap>")
                '''''Response.Write("&nbsp;&nbsp;&nbsp;&nbsp;")
                ''''''-------------------------------------------------------------------------------------------------------------
                ''''''Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
                ''''''-------------------------------------------------------------------------------------------------------------
                ''''End of Commnet by ShraddhaM
            End If
            '-------------------------------------------------------------------------------------------------------------
            'Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            '-------------------------------------------------------------------------------------------------------------
            'CommonFunction.General.WriteHTML("<TR onmouseover='changeTo(" & Chr(34) & "clsTDMouseOver" & Chr(34) & "," & Chr(34) & "white" & Chr(34) & ",event)' onmouseout='changeBack(" & Chr(34) & "clsTDNormal" & Chr(34) & "," & Chr(34) & "white" & Chr(34) & ",event)'>")
        End If
    End Sub
    Public Sub PlotModuleDiv(ByVal objSystemModule As CommonEngines.HashTables.SystemModules)
        '-------------------------------------------------------------------------------------------------------------
        ' Requirement Tag       : WhizibleSEM 8.1
        ' Procedure Name        : PlotModuleDiv
        ' Description           : To plat module div
        ' Purpose               : Same as above
        ' Parameters Passed     : CommonEngines.HashTables.SystemModules object
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PrashantSJ
        ' Created On            : Thursday, May 27, 2009
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------
        'sbHTML.Append("<tr class='clsTRBlank' valign='left'>")
        sbHTML.Append("<td align='left' class='clsTDBlank' >")


        sbHTML.Append("<a style='text-decoration:none;' ")

        'If m_blnEnableTabNavigation = True Then
        '    If CommonFunctions.General.CheckIsNothing(objSystemModule.CSSClassName, "") = "" Then
        '        sbHTML.Append("class='navtab' ")
        '    Else
        '        sbHTML.Append("class='" + objSystemModule.CSSClassName + "' ")
        '    End If
        'Else
        '    If CommonFunctions.General.CheckIsNothing(objSystemModule.CSSClassName, "") = "" Then
        '        sbHTML.Append("class='clsNavtab' ")
        '    Else
        '        sbHTML.Append("class='" + objSystemModule.CSSClassName + "' ")
        '    End If
        'End If

        sbHTML.Append("href='javascript:Tab_OnClick(" & Chr(34) & objSystemModule.ShortName & Chr(34) & ")'>")
        ' If objSystemModule.HideModuleNameOnTab = False Then
        sbHTML.Append(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModule.ModuleName)))
        'End If
        sbHTML.Append("</a>")
        sbHTML.Append("</td>")
        'sbHTML.Append("</tr>")

    End Sub

    Public Sub PlotTabTD(ByVal strToolTip As String, ByVal strModuleName As String)
        If m_blnDefaultNavigation = True Then
            'Response.Write("<TD noWrap class=")
            '-------------------------------------------------------------------------------------------------------------
            'Added By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            'Reason   - For applying new navigation theme.
            '-------------------------------------------------------------------------------------------------------------
            'If m_blnEnableTabNavigation = False Then
            '    Response.Write("<TD noWrap></TD>")
            'End If
            '-------------------------------------------------------------------------------------------------------------
            'Addition Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            '-------------------------------------------------------------------------------------------------------------
            Response.Write("<TD noWrap ")
            Response.Write(" Title='" & CommonFunction.General.FormatString(Server.HtmlEncode(strToolTip)) & "'>")
        End If
        'Response.Write(" style=" & Chr(34) & "border-right: 1 solid #FFFFFF" & Chr(34) & " onclick='Tab_OnClick(" & Chr(34) & strModuleName & Chr(34) & ")'>")

    End Sub
    Public Sub PlotLogoutTD(ByVal strLogoutPage As String)
        If m_blnDefaultNavigation = True Then
            'CommonFunction.General.WriteHTML("<TD class=clsTDNormal style='border-right: 1 solid #FFFFFF' onclick='Logout(" & Chr(34) & strLogoutPage & Chr(34) & ")' Title=" & MyBase.GetResourceString("LOGOUT_TOOLTIP") & ">")
            'CommonFunction.General.WriteHTML("<P style='margin-left: 4; margin-right: 4; margin-top: 2; margin-bottom: 2'>")
            'Response.Write("<TD noWrap Title='" & MyBase.GetResourceString("LOGOUT_TOOLTIP") & "'>")

            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
            'Reason      - For applying new navigation theme.
            '-------------------------------------------------------------------------------------------------------------

            'added by Aniruddha on 30 Jul 2007 for NPP common login
            If CType(Session("CalledFromPortal"), Boolean) = True Then
                strLogoutPage = CommonFunction.General.GetApplicationKeySetting("LogOutURL") ''& "/Source/General/Navigation.aspx?FromWhere=WST&SWC=" & Session("strUserName")
            End If
            'end of addition by Aniruddha on 30 Jul 2007 for NPP common login

            'Added By Chakshuta H on 29th-Oct-2015
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On - Monday, December 12, 2005 For Req.ID. - WAF3_GEN_1
            'Reason      - For applying new navigation theme.
            '-------------------------------------------------------------------------------------------------------------
            '---------------------------------------------------------------------------------------------------------------------
            'Modified By - Shrikant B On 2 Dec 2008 For WAF3_GEN_18
            Dim strRTLDirection As String = ""
            If CommonFunctions.General.CheckIsRTLCultureSupported = True Then
                strRTLDirection = "dir='rtl'"
            Else
                strRTLDirection = ""
            End If
            'Modification End  By - Shrikant B On 2 Dec 2008 For WAF3_GEN_18
            '---------------------------------------------------------------------------------------------------------------------
            'Ended By Chakshuta H on 29th-Oct-2015

            ''Commented and Added By Aniruddh Gujar on 04-Dec-2018 Purpose::To remove change version link
            Dim AllowVersionChange As String
            AllowVersionChange = "0"
            Dim drCompany As IDataReader
            drCompany = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
            If drCompany.Read() Then
                AllowVersionChange = CommonFunctions.Data.CheckIsDBNull(drCompany("AllowVersionChange"), "0")
            End If
            If AllowVersionChange = "1" Then
                ''''Added By Vaijat K ON 03/11/2017 For Changing Version
                Response.Write("<td><a class='clsNavTab' Style='white-space: nowrap;font-size:11px;font-weight:bolder;margin-right:10px;matgin-bottom:5px' title='Change Version' href='javascript:toggleToOldVersion(2)'>Change Version</a></td>")
                ''''End Added By Vaijat K ON 03/11/2017 For Changing Version
            End If
            ''End of Commented and Added By Aniruddh Gujar on 04-Dec-2018 Purpose::To remove change version link

            If m_blnEnableTabNavigation = True Then

                    'Added by Dhanashri S on 5 Mar 2015
                    Response.Write("<TD style=font-size:11px;font-weight:bolder nowrap title='" & MyBase.GetResourceString("LOGOUT_TOOLTIP") & "'>")
                    'Ended by Dhanashri

                    'Added by Dhanashri on 5 Mar 2015
                    Response.Write("&nbsp;&nbsp;<a class='navtab' style=font-size:11px;font-weight:bolder;margin-right:10px;matgin-bottom:5px href='javascript:Logout(" & Chr(34) & strLogoutPage & Chr(34) & ")'>")
                    'Ended by Dhanashri 
                Else
                    Response.Write("<TD style=font-size:11px;font-weight:bolder valign=middle align=right  nowrap>")        '' Removed width=99%

                    'Added by Dhanashri on 5 Mar 2015
                    Response.Write("<a class='clsNavTab' Style=font-size:11px;font-weight:bolder;margin-right:10px;matgin-bottom:5px title='" & MyBase.GetResourceString("LOGOUT_TOOLTIP") & "' href='javascript:Logout(" & Chr(34) & strLogoutPage & Chr(34) & ")'>")
                    'Ended by Dhanashri

                End If
                '-------------------------------------------------------------------------------------------------------------
                'Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
                '-------------------------------------------------------------------------------------------------------------
                CommonFunction.General.WriteHTML((MyBase.GetResourceString("LOGOUT")))
                Response.Write("</a>")
                CommonFunction.General.WriteHTML("</TD>")
            Else
                Dim mnu_Logout As New EventMenuItem
            mnu_Logout.Href = "javascript:Logout(\'" & strLogoutPage & "\')"   'strLogoutPage
            mnu_Logout.Label = MyBase.GetResourceString("LOGOUT")
            m_RADMenu.RootGroup.AddItem(mnu_Logout)
        End If


    End Sub
    Public Sub PlotFavoritesTD(ByVal strFavorites As String)
        If m_blnDefaultNavigation = True Then

            If m_blnEnableTabNavigation = True Then
                'Response.Write("<TD nowrap title='" & MyBase.GetResourceString("LOGOUT_TOOLTIP") & "'>")
                Response.Write("<TD nowrap title='" & "Favorites" & "'>")
                Response.Write("<a class='navtab' href='javascript:Tab_OnClick(""FV"")'>")
            Else
                Response.Write("<TD valign=middle align=right width=99% nowrap>")
                Response.Write("<a class='clsNavTab' title='" & "Favorites" & "' href='javascript:Tab_OnClick(""FV"")'>")
            End If
            CommonFunction.General.WriteHTML(("Favorites"))
            Response.Write("</a>")
            CommonFunction.General.WriteHTML("</TD>")
        Else
            'Dim mnu_Logout As New EventMenuItem
            'mnu_Logout.Href = "javascript:Logout(\'" & strLogoutPage & "\')"   'strLogoutPage
            'mnu_Logout.Label = MyBase.GetResourceString("LOGOUT")
            'm_RADMenu.RootGroup.AddItem(mnu_Logout)
        End If


    End Sub
    Private Sub PlotIFrame()
        Dim blnCancel As Boolean = False
        Call CommonEngine.General.CLCP_Events_Navigation.BeforeMenuTargetFramePlot(blnCancel, m_InlineFrame)
        If blnCancel = False Then
            Response.Write(m_InlineFrame.GetIFrameHTML)

        End If
        'Call frame after plot
        Call CommonEngine.General.CLCP_Events_Navigation.AfterMenuTargetFramePlot(m_InlineFrame)
    End Sub
    Public Sub PlotTabEnd()
        If m_blnDefaultNavigation = True Then
            '-------------------------------------------------------------------------------------------------------------
            'Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
            'Reason      - To plot all the links in one TD tag.
            '-------------------------------------------------------------------------------------------------------------
            If m_blnEnableTabNavigation = False Then
                CommonFunction.General.WriteHTML("</TD>")
            End If
            '-------------------------------------------------------------------------------------------------------------
            'Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
            '-------------------------------------------------------------------------------------------------------------
            CommonFunction.General.WriteHTML("</TR>")
            CommonFunction.General.WriteHTML("</TABLE>")
            CommonFunction.General.WriteHTML("</TD>")
            CommonFunction.General.WriteHTML("</TR>")
            If blnEarliarNavigationStyle Then
                CommonFunction.General.WriteHTML("<TR>")
            Else
                CommonFunction.General.WriteHTML("<TR style='display:none;'>")
            End If

            CommonFunction.General.WriteHTML("<TD valign=top>")

        Else
            'Add Events
            Dim blnCancel As Boolean = False

            Call m_RADMenu_BeforePlotMenu(blnCancel, m_RADMenu)
            If blnCancel = False Then
                If m_RADMenu.RootGroup.Flow = "Top" Then
                    'm_RADMenu.AbsolutePositioning = True
                    'm_RADMenu.RootGroup.Flow = "Horizontal"
                    'Response.Write(m_RADMenu.GetDecodedMenuHTML)
                    'm_RADMenu.RootGroup.Flow = "Top"

                End If

            End If
            'Call m_RADMenu_AfterPlotMenu(m_RADMenu)
            'Return
        End If
        ' ***********************************************************************************
        ' Added Nov 19, 2004 RajeshB  R.No:WAF2_PB_46
        ' Width of table should be 100% if the navigation schema is 
        ' dynamic menu
        ' ***********************************************************************************
        If m_blnDefaultNavigation = True Then
            'Plot Default Setting Links
            CommonFunction.General.WriteHTML("<TABLE valign='top' align='left' width='99.9%' cellspacing=0>")
        Else
            CommonFunction.General.WriteHTML("<TABLE valign='top' align='left' width='99.9%' height='100%' cellspacing=0>")
        End If
        'Logo
        CommonFunction.General.WriteHTML("<TR height=30px>")

        'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
        Select Case Request.QueryString("Mode")

            Case "SetDefaultProject"
                'Call the function to set the default project
                SetDefaultProject()

            Case "SetDefaultModule"
                'Call the function to set the default Module
                SetDefaultTab()


                'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
                '--------Added by AbhijeeD on 31st March 2004-----------
            Case "ResetDefault"
                'Call the function to Reset the default settings
                ResetDefault()
                '------------------End addition-----------------



        End Select


        'remove this after testing
        'If m_RADMenu.RootGroup.Flow <> "Bottom" Then
        'Modified by MrugajaB on 10th Feb 2006
        'Purpose:Added Null check for project Name
        If CType(CommonFunction.Data.CheckIsDBNull(Session("strProjectName"), ""), String) = "" Then 'Project Name IF
            'End Modification
            'If CType(CommonFunction.Data.CheckIsDBNull(Session("strProjectName"), ""), String) = "" Then

            CommonFunction.General.WriteHTML("<TD  class=clsLinkPageHeaderInner  width='50%' align='Left'>")
            If intFrameWidth <> 0 Then Call SetTreeHideLink()
            '____________Modified By UmeshJ on 01 November 2004_______________
            'WHY:   Instead of retrieving the Project Name from the Query string get it from SQL
            '       This will avoid restrictions those we need to apply for the special characters in the Project Name
            'Modified by NitinC For WhizibleSEM10.0 on 28 Sept 2011
            'CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")</B>")
            'Commented And Added by Chakshuta H on 29th-Oct-2015
            'CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")</B>")
            'Added By Ninad on 5 Aug 2008 SaaS Implementation
            If CommonFunctions.General.GetFrameworkSettings("GEN_SAAS", "ENABLED") = True Then
                Response.Write("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(")
                If Not CommonFunctions.General.CheckIsNothingOrEmpty(Session("TenantID")) Then
                    If CommonFunctions.General.CheckIsNothing(Session("TenantID")) = CommonFunctions.General.CheckIsNothing(Session("SubTenantID")) Then
                        Response.Write(MyBase.GetResourceString("Tenant"))
                    Else
                        Response.Write(MyBase.GetResourceString("USER"))
                    End If
                    Response.Write(")")
                Else
                    Response.Write(HttpContext.Current.Server.HtmlEncode(GetRole()) + ")")
                End If
            Else
                CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")</B>")
            End If
            'End Addition By Ninad on 5 Aug 2008 SaaS Implementation
            'End Of Commented And Added by Chakshuta H on 29th-Oct-2015
            'End Modified by NitinC For WhizibleSEM10.0 on 28 Sept 2011
            'End of modifications
            CommonFunction.General.WriteHTML("</TD>")
            ''Integrated by AmitJ for whizible SP 7.2 Issue ID 
            'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            If CommonFunction.Application.ShowSetAsDefaultLink = False And CType(Session("LoginType"), String) = "C" Then
                ResetDefault()
            End If
            'End of  'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'End OF integration By AmitJ
            'Integrated by AmitJ for whizible SP 7.2 Issue ID     
            'Commented and Modified by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'If CType(Session("LoginType"), String) = "E" Then
            If CType(Session("LoginType"), String) = "E" Or CType(Session("LoginType"), String) = "C" Then
                'Added By VarunA on 9-May-2008
                Response.Write(SetMyProjectLink())
                'End By VarunA on 9-May-2008
                If CommonFunction.Application.ShowSetAsDefaultLink = True Or CType(Session("LoginType"), String) = "E" Then
                    'End Modification by SavitaS for Flexcel IssueID 2369 
                    'End OF integration By AmitJ
                    Response.Write(SetDefaultProjectLink())
                    Response.Write(SetDefaultModuleLink())

                    'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
                    Response.Write(ResetDefaultLink())
                    'End Of Addition
                    'Integrated by AmitJ for whizible SP 7.2 Issue ID 
                    'Added by SavitaS on 26 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                Else
                    Response.Write("<TD class=clsLinkPageHeaderInner width='100%' align='Right'>|")
                End If
                'End of Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                'End OF integration By AmitJ

                '' START : Modified By ParagD On 28-Aug-2006
                '' Purpose : "My Profile" is not to be shown to Customer.
                If CType(Session("LoginType"), String) <> "C" Then
                    Response.Write(SetMyProfileLink())
                End If
                '' END : Modified By ParagD On 28-Aug-2006

                Response.Write(SetMyTheme())
                'Chakshuta
                'Response.Write(DocumentDownLoad())

                'Chakshuta
                'Added By Chakshuta H on 29th-Oct-2015
                'Added By Vinay on 25 Aug 2008
                'Added By Ninad on 26 Aug 2008 SaaS Implementation
                If CommonFunctions.General.GetFrameworkSettings("GEN_SAAS", "ENABLED") = True Then
                    If Not CommonFunctions.General.CheckIsNothingOrEmpty(Session("TenantID")) Then
                        If CommonFunctions.General.CheckIsNothing(Session("TenantID")) = CommonFunctions.General.CheckIsNothing(Session("SubTenantID")) Then
                            Response.Write(SetMySiteMap())
                        End If
                    End If
                End If
                'End Added By Ninad on 26 Aug 2008 SaaS Implementation
                'Addition End By Vinay
                'Ended By Chakshuta H on 29th-Oct-2015
                Response.Write(GetFileWhatsNew())
            End If
            CommonFunction.General.WriteHTML("</TABLE>")
        Else 'Project Name else
            'Commented and Modified By JyotiG
            'Start_JG_CR_7172_06-Nov-2006
            'CommonFunction.General.WriteHTML("<TD  class=clsLinkPageHeaderInner width='50%' align='Left'>")
            CommonFunction.General.WriteHTML("<TD  nowrap class=clsLinkPageHeaderInner width='50%' align='Left'>")
            'End_JG_06-Nov-2006
            If intFrameWidth <> 0 Then Call SetTreeHideLink()
            'CommonFunction.General.WriteHTML("<FONT Face='Verdana' Size='1' Color='#FFCC00'>")
            '____________Modified By UmeshJ on 01 November 2004_______________
            'WHY:   Instead of retrieving the Project Name from the Query string get it from SQL
            '       This will avoid restrictions those we need to apply for the special characters in the Project Name
            'Modified by NitinC on 28 Sept 2011 For WhizibleSEM 10.0 
            'CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")| " & MyBase.GetResourceString("PROJECT") & ": " & HttpContext.Current.Server.HtmlEncode(CType(Session("strProjectName"), String)))
            CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")| " & MyBase.GetResourceString("PROJECT") & ": " & HttpContext.Current.Server.HtmlEncode(CType(Session("strProjectName"), String)))
            'End Modified by NitinC on 28 Sept 2011 For WhizibleSEM 10.0
            'End of modifications
            'End of modifications
            CommonFunction.General.WriteHTML("</B>")
            CommonFunction.General.WriteHTML("</TD>")
            'Integrated by AmitJ for whizible SP 7.2 Issue ID 
            'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            If CommonFunction.Application.ShowSetAsDefaultLink = False And CType(Session("LoginType"), String) = "C" Then
                ResetDefault()
            End If
            'End of Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'Integrated by AmitJ for whizible SP 7.2 Issue ID 
            'Commented and Modified by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'If CType(Session("LoginType"), String) = "E" Then
            If CType(Session("LoginType"), String) = "E" Or CType(Session("LoginType"), String) = "C" Then
                'End Modification by SavitaS for Flexcel IssueID 2369 
                'End OF integration By AmitJ
                'Added By VarunA on 9-May-2008
                Response.Write(SetMyProjectLink())
                'End By VarunA on 9-May-2008
                If CommonFunction.Application.ShowSetAsDefaultLink = True Or CType(Session("LoginType"), String) = "E" Then

                    'If CType(Session("LoginType"), String) = "E" Then
                    Response.Write(SetDefaultProjectLink())
                    Response.Write(SetDefaultModuleLink())

                    'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
                    Response.Write(ResetDefaultLink())
                    'End Of Addition
                    'Integrated by AmitJ for whizible SP 7.2 Issue ID 
                    'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                Else
                    Response.Write("<TD class=clsLinkPageHeaderInner width='100%' align='Right'>|")
                End If
                'End of Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                'End OF integration By AmitJ

                '' START : Modified By ParagD On 28-Aug-2006
                '' Purpose : "My Profile" is not to be shown to Customer.
                If CType(Session("LoginType"), String) <> "C" Then
                    Response.Write(SetMyProfileLink())
                End If
                '' END : Modified By ParagD On 28-Aug-2006

                Response.Write(SetMyTheme())
                'Chakshuta
                'Response.Write(DocumentDownLoad())

                'Chakshuta
                'Added By Chakshuta H on 29th-Oct-2015
                'Added By Vinay on 25 Aug 2008
                Response.Write(SetMySiteMap())
                'Addition End By Vinay
                'Ended By Chakshuta H on 29th-Oct-2015

                Response.Write(GetFileWhatsNew())
            End If

            CommonFunction.General.WriteHTML("</TD></TR>")


        End If 'Project Name End IF
        'remove this after testing
        'End If
        '==================================================================
        'Plot IFrame

        If m_blnDefaultNavigation = False Then
            strSubPage = objNavigation.strSubPage
        End If
        If m_blnDefaultNavigation = False Then
            Select Case m_RADMenu.RootGroup.Flow
                Case "Left"
                    'dhanashri
                    CommonFunction.General.WriteHTML("<TR height=30px>")
                    CommonFunction.General.WriteHTML("<TD colspan=2 halign=left valign=top height='100%' width='100%'>")
                    CommonFunction.General.WriteHTML("<TABLE border=0 width=99.9% height=100%><TR><TD halign=left valign=top height=100%>")
                    CommonFunction.General.WriteHTML(m_RADMenu.GetDecodedMenuHTML)
                    'CommonFunction.General.WriteHTML("</TD><TD width=100% height=100%>")
                    'CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & " height=100% frameborder=0 marginwidth=0 marginheight=0 width=100% name=Sub id=Sub></iframe>")
                    'CommonFunction.General.WriteHTML("</TD></TR>")
                    m_InlineFrame.Width = 100
                    CommonFunction.General.WriteHTML("</TD><TD width=100% height=100%>")
                    CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & " height=100% frameborder=0 topMargin=0 rightMargin=0 leftMargin=0 bottomMargin=0 marginwidth=0 marginheight=0 width=100% name=Sub id=Sub></iframe><TD></TR></TABLE>")
                Case "Right"
                    CommonFunction.General.WriteHTML("<TR><TD width=100% Height=100%>")
                    m_InlineFrame.Width = 50
                    'PlotIFrame()
                    CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & " height=100% name=Sub id=Sub>")
                    CommonFunctions.General.WriteHTML("</TD>")

                    CommonFunction.General.WriteHTML("<TD halign=right width=100% valign=top height=100%>")
                    CommonFunction.General.WriteHTML(m_RADMenu.GetDecodedMenuHTML)
                    CommonFunction.General.WriteHTML("</TD></TR>")
                Case "Bottom"
                    CommonFunction.General.WriteHTML("<TR height='100%'>")
                    If CommonFunction.General.IsClientBrowserIE = True Then
                        CommonFunction.General.WriteHTML("<TD colspan=2 height=100% width=100%>")
                    Else
                        'netscape TD height workaround.
                        CommonFunction.General.WriteHTML("<TD colspan=2 style='width:100%;height:100%'>")
                    End If
                    CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & "  style='width:100%;height:100%' frameborder=0 marginwidth=0 marginheight=0  name=Sub id=Sub></iframe>")
                    'Code Modified:RajeshB          Remove TD formatting
                    'CommonFunctions.General.WriteHTML("</TD></TR><TR><TD background=""../../images/topbar.gif"" bgcolor=""#97B0E9"" colspan=2>")
                    CommonFunctions.General.WriteHTML("</TD></TR><TR><TD class=clsMenuTD colspan=2>")
                    'Modification Ends
                    Dim m_StartItem As New EventMenuItem
                    m_StartItem.Label = m_RADMenu.StartMenuLabel
                    m_StartItem.Image = m_RADMenu.StartMenuImage
                    m_StartItem.ImageOver = m_RADMenu.StartMenuImageOver
                    m_StartItem.MenuItem.CssClass = ""
                    m_StartItem.MenuItem.CssClassOver = ""
                    m_StartItem.MenuItem.CssClassClicked = ""
                    Dim m_StartItemChild As MenuGroupDecorator
                    m_StartItemChild = m_RADMenu.RootGroup
                    m_StartItemChild.ExpandDirection = "Up"
                    m_RADMenu.RootGroup = New EventMenuGroup
                    DirectCast(m_RADMenu.RootGroup, EventMenuGroup).EventHandler = DirectCast(m_StartItemChild, EventMenuGroup).EventHandler
                    m_RADMenu.RootGroup.Flow = "vertical"
                    m_RADMenu.RootGroup.AddItem(m_StartItem)
                    m_StartItem.ChildGroup = m_StartItemChild
                    Dim logoItem As New EventMenuItem
                    logoItem.Image = "topbar.gif"
                    m_StartItemChild.Items.Insert(0, logoItem.MenuItem)
                    m_RADMenu.RootGroup.CssClass = ""

                    'm_StartItemChild.AddItem(logoItem)
                    logoItem.CssClassOver = ""
                    logoItem.ImageOver = ""
                    logoItem.CssClass = ""
                    m_StartItemChild.CssClass = ""

                    CommonFunctions.General.WriteHTML(m_RADMenu.GetDecodedMenuHTML)
                    'Added 26 nov
                    'CommonFunctions.General.WriteHTML("<TD width=100%>")
                    ' CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")</B>")
                    ' 'End of modifications
                    '' CommonFunction.General.WriteHTML("</TD>")

                    ' If CType(Session("LoginType"), String) = "E" Then
                    '     Response.Write(SetDefaultProjectLink())
                    '     Response.Write(SetDefaultModuleLink())
                    '     Response.Write(SetMyProfileLink())
                    '     Response.Write(SetMyTheme())
                    '     Response.Write(GetFileWhatsNew())
                    ' End If
                    ' 'Addition Ends
                    m_RADMenu.RootGroup.Flow = "Bottom"
                    CommonFunctions.General.WriteHTML("</TD></TR>")

                Case "Top"
                    m_RADMenu.AbsolutePositioning = True
                    m_RADMenu.RootGroup.Flow = "Horizontal"
                    CommonFunction.General.WriteHTML("<TR><TD width='100%' colspan=2 >")
                    Response.Write(m_RADMenu.GetDecodedMenuHTML)
                    CommonFunction.General.WriteHTML("</TD></TR>")
                    m_RADMenu.RootGroup.Flow = "Top"
                    'Simply plot the frame.
                    CommonFunction.General.WriteHTML("<TR><TD width='100%' colspan=2 height=100%>")
                    CommonFunctions.General.WriteHTML("<iframe onLoad=""showRequestedMenu()""   src=" & strSubPage & " height=100% frameborder=0 marginwidth=0 marginheight=0 width=100% name=Sub id=Sub></iframe>")
                    CommonFunction.General.WriteHTML("</TD></TR>")
                Case Else

            End Select



            'CommonFunction.General.WriteHTML("<TR><TD width='100%' colspan=2 height=100%>")

            'm_InlineFrame = New DynamicMenu.InlineFrame
            'm_InlineFrame.FrameBorder = 0
            'm_InlineFrame.FrameID = "Sub"
            'm_InlineFrame.FrameName = "Sub"
            'm_InlineFrame.FrameSrc = """"
            'm_InlineFrame.Height = 100
            'm_InlineFrame.Width = 100
            'm_InlineFrame.FrameScrolling = False
            'm_InlineFrame.MarginHeight = 0
            'm_InlineFrame.MarginWidth = 0
            'Call Frame Before Plot


            Dim sbNav As New System.Text.StringBuilder
            Dim intFrameBorder As Integer = 0
            Dim strFrameID As String = "Sub"
            Dim strFrameSrc As String = """"""
            Dim strFrameWidth As String = """100%"""
            Dim strFrameHeight As String = """100%"""
            Dim strFrameName As String = "Sub"
            Dim strFrameScrolling As String = "no"
            Dim intMarginWidth As Integer = 0
            Dim intMarginHeight As Integer = 0
            'sbNav.Append("<body>")
            sbNav.Append("<iframe frameborder=" & _
                    intFrameBorder & " name=" & strFrameName _
                    & "  scrolling=" & strFrameScrolling & " src=" & strFrameSrc _
                  & " marginwidth=""" & intMarginWidth & """ marginheight=""" & intMarginHeight & """>")
            '& " height=" & ht & " width=" & strFrameWidth _
            '            PlotIFrame()
            'sbNav.Append("</body>")
            'Response.Write(sbNav.ToString)
        End If
        '==================================================================
        'CommonFunction.General.WriteHTML("</TABLE>")
        'If m_blnDefaultNavigation = True Then
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</TABLE>")
        ' End If

        'Select Case Request.QueryString("Mode")

        '    Case "SetDefaultProject"
        '        'Call the function to set the default project
        '        SetDefaultProject()

        '    Case "SetDefaultModule"
        '        'Call the function to set the default Module
        '        SetDefaultTab()


        '        '    'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
        '        '    '--------Added by AbhijeeD on 31st March 2004-----------
        '        'Case "ResetDefault"
        '        '    'Call the function to Reset the default settings
        '        '    ResetDefault()
        '        '    '------------------End addition-----------------



        'End Select
        If Session("intProjectID") Is Nothing And Session("strActiveModule").ToString = "PM" Then
            CommonFunction.General.WriteHTML("<SCRIPT Language=JavaScript>")
            CommonFunction.General.WriteHTML("window.status='" & MyBase.GetResourceString("WINDOW_STATUS") & " ';")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If


    End Sub
    Public Sub PlotTabEnd1()
        'If m_blnDefaultNavigation = True Then
        '    '-------------------------------------------------------------------------------------------------------------
        '    'Modified By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
        '    'Reason      - To plot all the links in one TD tag.
        '    '-------------------------------------------------------------------------------------------------------------
        '    If m_blnEnableTabNavigation = False Then
        '        CommonFunction.General.WriteHTML("</TD>")
        '    End If
        '    '-------------------------------------------------------------------------------------------------------------
        '    'Modification Ends By - PushkarK On - Wednesday, December 21, 2005 For Req.ID. - WAF3_GEN_1
        '    '-------------------------------------------------------------------------------------------------------------
        '    CommonFunction.General.WriteHTML("</TR>")
        '    CommonFunction.General.WriteHTML("</TABLE>")
        '    CommonFunction.General.WriteHTML("</TD>")
        '    CommonFunction.General.WriteHTML("</TR>")

        '    CommonFunction.General.WriteHTML("<TR >")
        '    CommonFunction.General.WriteHTML("<TD valign=top>")

        'Else
        '    'Add Events
        '    Dim blnCancel As Boolean = False

        '    Call m_RADMenu_BeforePlotMenu(blnCancel, m_RADMenu)
        '    If blnCancel = False Then
        '        If m_RADMenu.RootGroup.Flow = "Top" Then
        '            'm_RADMenu.AbsolutePositioning = True
        '            'm_RADMenu.RootGroup.Flow = "Horizontal"
        '            'Response.Write(m_RADMenu.GetDecodedMenuHTML)
        '            'm_RADMenu.RootGroup.Flow = "Top"

        '        End If

        '    End If
        '    'Call m_RADMenu_AfterPlotMenu(m_RADMenu)
        '    'Return
        'End If
        '' ***********************************************************************************
        '' Added Nov 19, 2004 RajeshB  R.No:WAF2_PB_46
        '' Width of table should be 100% if the navigation schema is 
        '' dynamic menu
        '' ***********************************************************************************
        'If m_blnDefaultNavigation = True Then
        '    'Plot Default Setting Links
        '    CommonFunction.General.WriteHTML("<TABLE valign='top' align='left' width='99.9%' cellspacing=0>")
        'Else
        '    CommonFunction.General.WriteHTML("<TABLE valign='top' align='left' width='99.9%' height='100%' cellspacing=0>")
        'End If
        ''Logo
        'CommonFunction.General.WriteHTML("<TR>")

        ''Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
        'Select Case Request.QueryString("Mode")

        '    Case "SetDefaultProject"
        '        'Call the function to set the default project
        '        SetDefaultProject()

        '    Case "SetDefaultModule"
        '        'Call the function to set the default Module
        '        SetDefaultTab()


        '        'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
        '        '--------Added by AbhijeeD on 31st March 2004-----------
        '    Case "ResetDefault"
        '        'Call the function to Reset the default settings
        '        ResetDefault()
        '        '------------------End addition-----------------



        'End Select

        Dim strUserName As String = HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String))
        'If strUserName.Length > 5 Then
        '    strUserName = strUserName.Substring(0, 5) + ".."
        'End If

        'remove this after testing
        'If m_RADMenu.RootGroup.Flow <> "Bottom" Then
        'Modified by MrugajaB on 10th Feb 2006
        'Purpose:Added Null check for project Name
        If CType(CommonFunction.Data.CheckIsDBNull(Session("strProjectName"), ""), String) = "" Then 'Project Name IF
            'End Modification
            'If CType(CommonFunction.Data.CheckIsDBNull(Session("strProjectName"), ""), String) = "" Then

            'Added by Dhanashri S on 9 Mar 2015
            CommonFunction.General.WriteHTML("<TD width='60%' valign=middle align=left style=font-size:11px font-weight:bolder class=clsLinkPageHeaderInner nowrap>") '---<font color='white'  size='1pt'>
            'Ended by Dhanashri

            'If intFrameWidth <> 0 Then Call SetTreeHideLink()
            '____________Modified By UmeshJ on 01 November 2004_______________
            'WHY:   Instead of retrieving the Project Name from the Query string get it from SQL
            '       This will avoid restrictions those we need to apply for the special characters in the Project Name
            'Modified by NitinC on 28 Sept 2011 For WhizibleSEM10.0 
            'CommonFunction.General.WriteHTML("" & MyBase.GetResourceString("USER") & " : " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) + "'>" + strUserName + "</label>" & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")")
            'Commented And Added By Vaijat K ON 03/02/2016
            'CommonFunction.General.WriteHTML("|" & MyBase.GetResourceString("USER") & " : " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) + "'>" + HttpContext.Current.Server.HtmlEncode(CType(Session("strEmpName"), String)) + "</label>" & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")&nbsp;|")
            CommonFunction.General.WriteHTML("|" & MyBase.GetResourceString("USER") & " : " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) + "'>" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Server.HtmlEncode(CType(Session("strEmpName"), String)), HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String))) + "</label>" & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")&nbsp;|")
            'Ended
            'ENd Modified by NitinC on 28 Sept 2011 For WhizibleSEM10.0 
            'End of modifications
            CommonFunction.General.WriteHTML("</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
            ''Integrated by AmitJ for whizible SP 7.2 Issue ID 
            'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'If CommonFunction.Application.ShowSetAsDefaultLink = False And CType(Session("LoginType"), String) = "C" Then
            '    ResetDefault()
            'End If
            'End of  'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'End OF integration By AmitJ
            'Integrated by AmitJ for whizible SP 7.2 Issue ID     
            'Commented and Modified by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'If CType(Session("LoginType"), String) = "E" Then
            If CType(Session("LoginType"), String) = "E" Or CType(Session("LoginType"), String) = "C" Then
                'Added By VarunA on 9-May-2008
                ' Response.Write(SetMyProjectLink())

                'Added by Dhanashri S on 9 Mar 2015
                Response.Write("<TD valign=middle style='align:right;text-align:right;font-size:11px;font-weight:bolder' class=clsLinkPageHeaderInner  nowrap>&nbsp;") '--<font color='white'  size='1pt'>
                'Ended by Dhanashri

                'End By VarunA on 9-May-2008
                If CommonFunction.Application.ShowSetAsDefaultLink = True Or CType(Session("LoginType"), String) = "E" Then
                    'End Modification by SavitaS for Flexcel IssueID 2369 
                    'End OF integration By AmitJ
                    Response.Write(SetDefaultProjectLink())
                    Response.Write(SetDefaultModuleLink())

                    'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
                    Response.Write(ResetDefaultLink())
                    'End Of Addition
                    'Integrated by AmitJ for whizible SP 7.2 Issue ID 
                    'Added by SavitaS on 26 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                Else
                    Response.Write("<TD valign=middle style='align:right;text-align:right;' class=clsLinkPageHeaderInner nowrap>") '---<font color='white'  size='1pt'>
                End If
                'End of Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                'End OF integration By AmitJ

                '' START : Modified By ParagD On 28-Aug-2006
                '' Purpose : "My Profile" is not to be shown to Customer.
                If CType(Session("LoginType"), String) <> "C" Then
                    '   Response.Write(SetMyProfileLink())
                End If
                '' END : Modified By ParagD On 28-Aug-2006

                Response.Write(SetMyTheme())
                'Chakshuta
                'Response.Write(DocumentDownLoad())

                'Chakshuta
                Response.Write(GetFileWhatsNew())
            End If
            'CommonFunction.General.WriteHTML("</TABLE>")
        Else 'Project Name else
            'Commented and Modified By JyotiG
            'Start_JG_CR_7172_06-Nov-2006
            'CommonFunction.General.WriteHTML("<TD  class=clsLinkPageHeaderInner width='50%' align='Left'>")
            CommonFunction.General.WriteHTML("<TD width='60%' valign=middle align=left class=clsLinkPageHeaderInner nowrap>") '--<font color='white' size='1pt'>
            '  CommonFunction.General.WriteHTML("<a class=clsNavTab href='#'>")
            'End_JG_06-Nov-2006
            'If intFrameWidth <> 0 Then Call SetTreeHideLink()
            'CommonFunction.General.WriteHTML("<FONT Face='Verdana' Size='1' Color='#FFCC00'>")
            '____________Modified By UmeshJ on 01 November 2004_______________
            'WHY:   Instead of retrieving the Project Name from the Query string get it from SQL
            '       This will avoid restrictions those we need to apply for the special characters in the Project Name
            Dim strProjectName As String = HttpContext.Current.Server.HtmlEncode(CType(Session("strProjectName"), String))

            'If strProjectName.Length > 10 Then
            '    strProjectName = strProjectName.Substring(0, 10) + ".."
            'End If


            'Modified by NitinC on 28 Sept 2011 For WhizibleSEM v10.0
            'CommonFunction.General.WriteHTML("" & MyBase.GetResourceString("USER") & " : " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) + "'>" + strUserName + "</label>" & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")| " & MyBase.GetResourceString("PROJECT") & ": " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strProjectName"), String)) + "'>" + strProjectName + "</lable>")
            CommonFunction.General.WriteHTML("| " & MyBase.GetResourceString("USER") & " : " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) + "'>" + HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) + "</label>" & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")&nbsp;|<br>| " & MyBase.GetResourceString("PROJECT") & ": " & "<label title='" + HttpContext.Current.Server.HtmlEncode(CType(Session("strProjectName"), String)) + "'>" + strProjectName + "</lable>&nbsp;|")
            'End Modified by NitinC on 28 Sept 2011 For WhizibleSEM v10.0
            'End of modifications
            ' CommonFunction.General.WriteHTML("</B>")
            ' CommonFunction.General.WriteHTML("</a>")
            CommonFunction.General.WriteHTML("</font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
            'Integrated by AmitJ for whizible SP 7.2 Issue ID 
            'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            If CommonFunction.Application.ShowSetAsDefaultLink = False And CType(Session("LoginType"), String) = "C" Then
                ResetDefault()
            End If
            'End of Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'Integrated by AmitJ for whizible SP 7.2 Issue ID 
            'Commented and Modified by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
            'If CType(Session("LoginType"), String) = "E" Then
            If CType(Session("LoginType"), String) = "E" Or CType(Session("LoginType"), String) = "C" Then
                'End Modification by SavitaS for Flexcel IssueID 2369 
                'End OF integration By AmitJ
                'Added By VarunA on 9-May-2008
                '  Response.Write(SetMyProjectLink())
                Response.Write("<TD valign=middle style='align:right;text-align:right;' class=clsLinkPageHeaderInner nowrap>&nbsp;") '---<font color='white'  size='1pt'>
                'End By VarunA on 9-May-2008
                If CommonFunction.Application.ShowSetAsDefaultLink = True Or CType(Session("LoginType"), String) = "E" Then

                    'If CType(Session("LoginType"), String) = "E" Then
                    Response.Write(SetDefaultProjectLink())
                    Response.Write(SetDefaultModuleLink())

                    'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
                    Response.Write(ResetDefaultLink())
                    'End Of Addition
                    'Integrated by AmitJ for whizible SP 7.2 Issue ID 
                    'Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                Else
                    Response.Write("<TD valign=middle style='align:right;text-align:right;' class=clsLinkPageHeaderInner nowrap>") '---<font color='white'  size='1pt'>
                End If
                'End of Added by SavitaS on 13 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                'End OF integration By AmitJ

                '' START : Modified By ParagD On 28-Aug-2006
                '' Purpose : "My Profile" is not to be shown to Customer.
                If CType(Session("LoginType"), String) <> "C" Then
                    '  Response.Write(SetMyProfileLink())
                End If
                '' END : Modified By ParagD On 28-Aug-2006

                Response.Write(SetMyTheme())
                'Chakshuta
                'Response.Write(DocumentDownLoad())

                'Chakshuta
                Response.Write(GetFileWhatsNew())
            End If

            CommonFunction.General.WriteHTML("</font></TD>")


        End If 'Project Name End IF
        'remove this after testing
        'End If
        '==================================================================
        'Plot IFrame

        If m_blnDefaultNavigation = False Then
            strSubPage = objNavigation.strSubPage
        End If
        'If m_blnDefaultNavigation = False Then
        '    Select Case m_RADMenu.RootGroup.Flow
        '        Case "Left"

        '            CommonFunction.General.WriteHTML("<TR>")
        '            CommonFunction.General.WriteHTML("<TD colspan=2 halign=left valign=top height='100%' width='100%'>")
        '            CommonFunction.General.WriteHTML("<TABLE border=0 width=99.9% height=100%><TR><TD halign=left valign=top height=100%>")
        '            CommonFunction.General.WriteHTML(m_RADMenu.GetDecodedMenuHTML)
        '            'CommonFunction.General.WriteHTML("</TD><TD width=100% height=100%>")
        '            'CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & " height=100% frameborder=0 marginwidth=0 marginheight=0 width=100% name=Sub id=Sub></iframe>")
        '            'CommonFunction.General.WriteHTML("</TD></TR>")
        '            m_InlineFrame.Width = 100
        '            CommonFunction.General.WriteHTML("</TD><TD width=100% height=100%>")
        '            CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & " height=100% frameborder=0 topMargin=0 rightMargin=0 leftMargin=0 bottomMargin=0 marginwidth=0 marginheight=0 width=100% name=Sub id=Sub></iframe><TD></TR></TABLE>")
        '        Case "Right"
        '            CommonFunction.General.WriteHTML("<TR><TD width=100% Height=100%>")
        '            m_InlineFrame.Width = 50
        '            'PlotIFrame()
        '            CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & " height=100% name=Sub id=Sub>")
        '            CommonFunctions.General.WriteHTML("</TD>")

        '            CommonFunction.General.WriteHTML("<TD halign=right width=100% valign=top height=100%>")
        '            CommonFunction.General.WriteHTML(m_RADMenu.GetDecodedMenuHTML)
        '            CommonFunction.General.WriteHTML("</TD></TR>")
        '        Case "Bottom"
        '            CommonFunction.General.WriteHTML("<TR height='100%'>")
        '            If CommonFunction.General.IsClientBrowserIE = True Then
        '                CommonFunction.General.WriteHTML("<TD colspan=2 height=100% width=100%>")
        '            Else
        '                'netscape TD height workaround.
        '                CommonFunction.General.WriteHTML("<TD colspan=2 style='width:100%;height:100%'>")
        '            End If
        '            CommonFunctions.General.WriteHTML("<iframe src=" & strSubPage & "  style='width:100%;height:100%' frameborder=0 marginwidth=0 marginheight=0  name=Sub id=Sub></iframe>")
        '            'Code Modified:RajeshB          Remove TD formatting
        '            'CommonFunctions.General.WriteHTML("</TD></TR><TR><TD background=""../../images/topbar.gif"" bgcolor=""#97B0E9"" colspan=2>")
        '            CommonFunctions.General.WriteHTML("</TD></TR><TR><TD class=clsMenuTD colspan=2>")
        '            'Modification Ends
        '            Dim m_StartItem As New EventMenuItem
        '            m_StartItem.Label = m_RADMenu.StartMenuLabel
        '            m_StartItem.Image = m_RADMenu.StartMenuImage
        '            m_StartItem.ImageOver = m_RADMenu.StartMenuImageOver
        '            m_StartItem.MenuItem.CssClass = ""
        '            m_StartItem.MenuItem.CssClassOver = ""
        '            m_StartItem.MenuItem.CssClassClicked = ""
        '            Dim m_StartItemChild As MenuGroupDecorator
        '            m_StartItemChild = m_RADMenu.RootGroup
        '            m_StartItemChild.ExpandDirection = "Up"
        '            m_RADMenu.RootGroup = New EventMenuGroup
        '            DirectCast(m_RADMenu.RootGroup, EventMenuGroup).EventHandler = DirectCast(m_StartItemChild, EventMenuGroup).EventHandler
        '            m_RADMenu.RootGroup.Flow = "vertical"
        '            m_RADMenu.RootGroup.AddItem(m_StartItem)
        '            m_StartItem.ChildGroup = m_StartItemChild
        '            Dim logoItem As New EventMenuItem
        '            logoItem.Image = "topbar.gif"
        '            m_StartItemChild.Items.Insert(0, logoItem.MenuItem)
        '            m_RADMenu.RootGroup.CssClass = ""

        '            'm_StartItemChild.AddItem(logoItem)
        '            logoItem.CssClassOver = ""
        '            logoItem.ImageOver = ""
        '            logoItem.CssClass = ""
        '            m_StartItemChild.CssClass = ""

        '            CommonFunctions.General.WriteHTML(m_RADMenu.GetDecodedMenuHTML)
        '            'Added 26 nov
        '            'CommonFunctions.General.WriteHTML("<TD width=100%>")
        '            ' CommonFunction.General.WriteHTML("<B>" & MyBase.GetResourceString("USER") & " : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")</B>")
        '            ' 'End of modifications
        '            '' CommonFunction.General.WriteHTML("</TD>")

        '            ' If CType(Session("LoginType"), String) = "E" Then
        '            '     Response.Write(SetDefaultProjectLink())
        '            '     Response.Write(SetDefaultModuleLink())
        '            '     Response.Write(SetMyProfileLink())
        '            '     Response.Write(SetMyTheme())
        '            '     Response.Write(GetFileWhatsNew())
        '            ' End If
        '            ' 'Addition Ends
        '            m_RADMenu.RootGroup.Flow = "Bottom"
        '            CommonFunctions.General.WriteHTML("</TD></TR>")

        '        Case "Top"
        '            m_RADMenu.AbsolutePositioning = True
        '            m_RADMenu.RootGroup.Flow = "Horizontal"
        '            CommonFunction.General.WriteHTML("<TR><TD width='100%' colspan=2 >")
        '            Response.Write(m_RADMenu.GetDecodedMenuHTML)
        '            CommonFunction.General.WriteHTML("</TD></TR>")
        '            m_RADMenu.RootGroup.Flow = "Top"
        '            'Simply plot the frame.
        '            CommonFunction.General.WriteHTML("<TR><TD width='100%' colspan=2 height=100%>")
        '            CommonFunctions.General.WriteHTML("<iframe onLoad=""showRequestedMenu()""   src=" & strSubPage & " height=100% frameborder=0 marginwidth=0 marginheight=0 width=100% name=Sub id=Sub></iframe>")
        '            CommonFunction.General.WriteHTML("</TD></TR>")
        '        Case Else

        '    End Select



        '    'CommonFunction.General.WriteHTML("<TR><TD width='100%' colspan=2 height=100%>")

        '    'm_InlineFrame = New DynamicMenu.InlineFrame
        '    'm_InlineFrame.FrameBorder = 0
        '    'm_InlineFrame.FrameID = "Sub"
        '    'm_InlineFrame.FrameName = "Sub"
        '    'm_InlineFrame.FrameSrc = """"
        '    'm_InlineFrame.Height = 100
        '    'm_InlineFrame.Width = 100
        '    'm_InlineFrame.FrameScrolling = False
        '    'm_InlineFrame.MarginHeight = 0
        '    'm_InlineFrame.MarginWidth = 0
        '    'Call Frame Before Plot


        '    Dim sbNav As New System.Text.StringBuilder
        '    Dim intFrameBorder As Integer = 0
        '    Dim strFrameID As String = "Sub"
        '    Dim strFrameSrc As String = """"""
        '    Dim strFrameWidth As String = """100%"""
        '    Dim strFrameHeight As String = """100%"""
        '    Dim strFrameName As String = "Sub"
        '    Dim strFrameScrolling As String = "no"
        '    Dim intMarginWidth As Integer = 0
        '    Dim intMarginHeight As Integer = 0
        '    'sbNav.Append("<body>")
        '    sbNav.Append("<iframe frameborder=" & _
        '            intFrameBorder & " name=" & strFrameName _
        '            & "  scrolling=" & strFrameScrolling & " src=" & strFrameSrc _
        '          & " marginwidth=""" & intMarginWidth & """ marginheight=""" & intMarginHeight & """>")
        '    '& " height=" & ht & " width=" & strFrameWidth _
        '    '            PlotIFrame()
        '    'sbNav.Append("</body>")
        '    'Response.Write(sbNav.ToString)
        'End If
        ''==================================================================
        ''CommonFunction.General.WriteHTML("</TABLE>")
        ''If m_blnDefaultNavigation = True Then
        'CommonFunction.General.WriteHTML("</TD>")
        'CommonFunction.General.WriteHTML("</TR>")
        'CommonFunction.General.WriteHTML("</TABLE>")
        ' End If

        'Select Case Request.QueryString("Mode")

        '    Case "SetDefaultProject"
        '        'Call the function to set the default project
        '        SetDefaultProject()

        '    Case "SetDefaultModule"
        '        'Call the function to set the default Module
        '        SetDefaultTab()


        '        '    'Code Added By VidyaJ - For IssueID - 2124 - Whizible 6.0
        '        '    '--------Added by AbhijeeD on 31st March 2004-----------
        '        'Case "ResetDefault"
        '        '    'Call the function to Reset the default settings
        '        '    ResetDefault()
        '        '    '------------------End addition-----------------



        'End Select
        If Session("intProjectID") Is Nothing And Session("strActiveModule").ToString = "PM" Then
            CommonFunction.General.WriteHTML("<SCRIPT Language=JavaScript>")
            CommonFunction.General.WriteHTML("window.status='" & MyBase.GetResourceString("WINDOW_STATUS") & " ';")
            CommonFunction.General.WriteHTML("</SCRIPT>")
        End If


    End Sub
    Public Sub PlotTabTDEnd()
        If m_blnDefaultNavigation = True Then
            Response.Write("</TD>")
        End If

    End Sub
    Public Sub PageInit()
        'Code added:RajeshB     24th December, 2004
        'NavigationFromWhere error
        'Commented Out:RajeshB  
        'For Wipro
        If m_blnDefaultNavigation = False Then
            createRADMenu()
        End If
        '' commented By ShraddhaM for WhizibleSEM8_Whiz3 on 3,July 2008 
        ' Purpose : To remove ModuleNames and add in logout link row.
        'Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules
        ' End of Comment by ShraddhaM
        Dim intCount As Integer

        Dim strSQL As String

        'Check the default culture id and current thread system id
        If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
        Else
            objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            If objSystemModulesAry Is Nothing Then
                objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            End If
        End If
        ' ***********************************************************************************
        ' Code Modified Nov 06, 2004 RajeshB  R.No:WAF2_PB_46
        ' ***********************************************************************************
        'check the application settings for default navigation support
        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings
        objFrameworkSetting = CommonEngines.HashTables.GetHashTableObject.GetHashTableFrameWorkSettingsObject("GEN_DEFAULT_NAVIGATION")
        If Not objFrameworkSetting Is Nothing Then
            If objFrameworkSetting.ValidateStatus() = True Then
                If UCase(Trim(objFrameworkSetting.Status & "")) = "ENABLED" Then
                    m_blnDefaultNavigation = True
                Else
                    m_blnDefaultNavigation = False
                End If
            Else
                m_blnDefaultNavigation = False
            End If
        Else
            m_blnDefaultNavigation = False
        End If
        '######################################
        'To remove after testing
        'm_blnDefaultNavigation = False
        ' End of To remove
        If m_blnDefaultNavigation = False Then
            If Request.QueryString("Mode") <> "" Then
                'Code Added:RajeshB     24th Nov, 2004  R.No:WAF2_PB_46
                createRADMenu()
                'Addition Ends.
            End If
        End If
        PlotTabsTable()

        'Added By Chakshuta H on 29th-Oct-2015
        ' ***********************************************************************************
        ' Modification Ends Nov 06, 2004 RajeshB  R.No:WAF2_PB_46
        ' ***********************************************************************************
        If Not objSystemModulesAry Is Nothing Then
            For intCount = 0 To objSystemModulesAry.Length - 1
                'Create the object of WhizGlobal class
                Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, objSystemModulesAry(intCount).ModuleTagID, CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                'Create the object of GetAccess class
                Dim objGetAccess As New WebPage.Templates.AccessRights
                'Call method get access to get the access
                objGetAccess.GetAccess(objGlobal, True)

                If objGetAccess.Access = True Then
                    '-------------------------------------------------------------------------------------------------------------
                    'Modified By - PushkarK On - Monday, December 12, 2005 For Req.ID. - WAF3_GEN_1 - Images for Module Tabs
                    'Reason      - To pass hashtable object instead of passing number of arguments.
                    '-------------------------------------------------------------------------------------------------------------
                    If m_blnEnableTabNavigation = True Then
                        PlotTabTD(objSystemModulesAry(intCount).ToolTip, objSystemModulesAry(intCount).ShortName)
                    End If
                    If CType(Session("strActiveModule"), String) = objSystemModulesAry(intCount).ShortName Then
                        'GetNavigationLinkForSelectedTab(objSystemModulesAry(intCount).ShortName, CType(objSystemModulesAry(intCount).FrameWidth, Integer), objSystemModulesAry(intCount).ModuleName)
                        GetNavigationLinkForSelectedTab(objSystemModulesAry(intCount))
                    Else
                        'GetNavigationLinkForTab(objSystemModulesAry(intCount).ShortName, objSystemModulesAry(intCount).ModuleName)
                        GetNavigationLinkForTab(objSystemModulesAry(intCount))
                    End If
                    If m_blnEnableTabNavigation = True Then
                        PlotTabTDEnd()
                    End If
                    '-------------------------------------------------------------------------------------------------------------
                    'Modification Ends By - PushkarK On - Monday, December 12, 2005 For Req.ID. - WAF3_GEN_1 - Images for Module Tabs
                    '-------------------------------------------------------------------------------------------------------------
                End If
                objGlobal = Nothing
                objGetAccess = Nothing
            Next
        End If
        objSystemModulesAry = Nothing
        'Ended By Chakshuta H on 29th-Oct-2015

        'Loop
        '-------------------------------------------------------------------------------------------------------------
        'Modified By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
        'Reason      - For applying new navigation theme.
        '-------------------------------------------------------------------------------------------------------------

        If m_blnEnableTabNavigation = True Then
            'call commonfunction function GetLogoutPage 
            Dim strLogoutPage As String = CommonFunction.General.GetLogOutPage

            ' ***********************************************************************************
            ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
            ' ***********************************************************************************
            If strLogoutPage = "" Then strLogoutPage = "../../Default1.aspx"
            ''If strLogoutPage = "" Then strLogoutPage = "../../Default.aspx"

            'CType(Session("CalledFromPortal"), Boolean) = True  condition added by AniruddhaD on 4 Jan 2006 for common NPP login
            'original code in else part

            If CType(Session("CalledFromPortal"), Boolean) = True Then
                strLogoutPage = CommonFunction.General.GetApplicationKeySetting("LogOutURL") & "/Source/General/Navigation.aspx?FromWhere=WST&SWC=" & Session("strUserName")
            Else
                strLogoutPage = CommonFunction.General.GetLogOutPage
            End If

            If strLogoutPage = "" Then
                strLogoutPage = "../../Default1.aspx"
            End If
            ' ***********************************************************************************
            ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
            ' ***********************************************************************************


            If m_blnIsWindowsAuthenticated Then
                strLogoutPage = strLogoutPage & "?Message=LoggedOut"
            End If
            'Code Added By VidyaJ - For Favorites
            'Call PlotFavoritesTD("Favorites")

            PlotLogoutTD(strLogoutPage)

        End If
        '-------------------------------------------------------------------------------------------------------------
        'Modification Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
        '-------------------------------------------------------------------------------------------------------------
        '' Commented By ShraddhaM for WhizibleSEM8_Whiz3 on 3,July 2008 
        ' Purpose : To remove ModuleNames and add in logout link row.
        ''''''''Added by SrikanthY on 23 Nov 2006
        '''''If Session("LoginType").ToString = "E" Then
        '''''    Response.Write("<TD noWrap><a class=clsNavTab Title='Alerts' href='javascript:Alerts_OnClick()'>Alerts</a><TD>")
        '''''End If
        '''''' End of addition by SrikanthY
        'End of Commnet by ShraddhaM
        PlotTabEnd()

    End Sub

    'Modified BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 Swaped the Img1 and Img2
    Private Sub SetTreeHideLink()
        Response.Write("<A HRef=" & Chr(34) & "JavaScript:hideshowtree()" & Chr(34) & "><Image ID=ImgID BORDER=0 src='..\..\images\TreeOff.gif' alt='" & MyBase.GetResourceString("SHOW_HIDE_TREE_TOOLTIP") & "'></A>")
    End Sub
    'End Modification BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 Swaped the Img1 and Img2

    Sub New()
        MyBase.InitializeResources("Resources.Links", "Resources")

    End Sub
    ' ***********************************************************************************
    ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    Private Function IsWindowsAuthenticated(ByVal sender As System.Object) As Boolean
        '=====================================================================
        ' Procedure  Name		:	IsWindowsAuthenticated
        ' Parameters Passed		:	By Ref Login Name, By Val sender object(page)
        ' Returns				:	True/False
        ' Parameters Affected	:	None
        ' Purpose				:	To check if windows security is enabled
        ' Description			:	If the windows security is enabled Login Name is set
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Rajanikant 
        ' Created				:	June 04,2004
        '=====================================================================
        IsWindowsAuthenticated = CType(sender, Links).User.Identity.IsAuthenticated
    End Function
    ' ***********************************************************************************
    ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************

    Public Sub SetActiveMenu(ByRef m_ActMenu As EventMenuItem)
        m_ActiveMenu = m_ActMenu
        m_ActiveMenu.DefaultGroupScrollHeight = m_RADMenu.DefaultGroupScrollHeight
        m_ActiveMenu.MenuItem.RightLogo = m_RADMenu.DefaultItemRightLogo
        m_ActiveMenu.MaxItemsInGroup = m_RADMenu.MaxItemsInGroup
    End Sub
    Public Sub resetRADMenu()
        m_ActiveMenu = Nothing
        ' m_RADMenu.RootGroup = Nothing
        m_RADMenu = Nothing
        m_MenuGroup = Nothing
    End Sub
    Public Sub setSubPage(ByVal strPage As String)
        strSubPage = strPage
    End Sub
    Public Sub createRADMenu()

        strSubPage = objNavigation.strSubPage
        Dim objHashTableMenu As CommonEngines.HashTables.MenuSetting
        objHashTableMenu = CommonEngines.HashTables.GetHashTableObject.GetHashTableMenuSettingsObject()
        m_RADMenu = New EventMenu(New InheritableMenu)
        m_RADMenu.AbsolutePositioning = objHashTableMenu.AbsolutePositioning
        m_RADMenu.AbsoluteX = objHashTableMenu.AbsoluteX
        m_RADMenu.AbsoluteY = objHashTableMenu.AbsoluteY
        m_RADMenu.CausesValidation = objHashTableMenu.CausesValidation
        m_RADMenu.ClickToOpen = objHashTableMenu.ClickToOpen
        m_RADMenu.Company = objHashTableMenu.Company
        m_RADMenu.ContentFile = objHashTableMenu.ContentFile
        m_RADMenu.ContextHtmlElementID = objHashTableMenu.ContextHtmlElementID
        m_RADMenu.CssFile = objHashTableMenu.CssFile
        m_RADMenu.DefaultDisabledItemCss = objHashTableMenu.DefaultDisabledItemCss
        m_RADMenu.DefaultExpandEffectDuration = objHashTableMenu.DefaultExpandEffectDuration
        m_RADMenu.DefaultGroupCss = objHashTableMenu.DefaultGroupCss
        m_RADMenu.DefaultItemClickedCss = objHashTableMenu.DefaultItemClickedCss
        m_RADMenu.DefaultItemCss = objHashTableMenu.DefaultItemCss
        m_RADMenu.DefaultItemHeight = objHashTableMenu.DefaultItemHeight
        m_RADMenu.DefaultItemOverCss = objHashTableMenu.DefaultItemOverCss
        m_RADMenu.EnableViewState = objHashTableMenu.EnableViewState
        m_RADMenu.GroupHideDelay = objHashTableMenu.GroupHideDelay
        m_RADMenu.Height = objHashTableMenu.Height
        m_RADMenu.HTMLFindValue = objHashTableMenu.HTMLFindValue
        m_RADMenu.HTMLReplaceValue = objHashTableMenu.HTMLReplaceValue
        m_RADMenu.ID = objHashTableMenu.ID
        m_RADMenu.ImagesBaseDir = objHashTableMenu.ImagesBaseDir
        m_RADMenu.IsContext = objHashTableMenu.IsContext
        m_RADMenu.LicenseFile = objHashTableMenu.LicenseFile
        m_RADMenu.LicenseKey = objHashTableMenu.LicenseKey
        m_RADMenu.OnClientClick = objHashTableMenu.OnClientClick
        m_RADMenu.OnClientItemHighlight = objHashTableMenu.OnClientItemHighlight
        m_RADMenu.Opacity = objHashTableMenu.Opacity
        m_RADMenu.Overlay = objHashTableMenu.Overlay
        m_RADMenu.OverrideDefaultTDCss = objHashTableMenu.OverrideDefaultTDCss
        m_RADMenu.PathToJavaScript = objHashTableMenu.PathToJavaScript
        m_RADMenu.ScrollCssClass = objHashTableMenu.ScrollCssClass
        m_RADMenu.ScrollDownDisabledImage = objHashTableMenu.ScrollDownDisabledImage
        m_RADMenu.ScrollDownImage = objHashTableMenu.ScrollDownImage
        m_RADMenu.ScrollOverCssClass = objHashTableMenu.ScrollOverCssClass
        m_RADMenu.ScrollSpeed = objHashTableMenu.ScrollSpeed
        m_RADMenu.ScrollUpDisabledImage = objHashTableMenu.ScrollUpDisabledImage
        m_RADMenu.ScrollUpImage = objHashTableMenu.ScrollUpImage
        m_RADMenu.ShadowColor = objHashTableMenu.ShadowColor
        m_RADMenu.ShadowWidth = objHashTableMenu.ShadowWidth
        m_RADMenu.ShowPath = objHashTableMenu.ShowPath
        m_RADMenu.ToolTip = objHashTableMenu.ToolTip
        m_RADMenu.TabIndex = CType(objHashTableMenu.TabIndex, Short)
        m_RADMenu.Visible = objHashTableMenu.Visible
        m_RADMenu.Width = objHashTableMenu.Width
        m_RADMenu.DefaultGroupScrollHeight = objHashTableMenu.DefaultGroupScrollHeight
        m_RADMenu.StartMenuImage = objHashTableMenu.StartMenuImage
        m_RADMenu.StartMenuImageOver = objHashTableMenu.StartMenuImageOver
        m_RADMenu.StartMenuLabel = objHashTableMenu.StartMenuLabel
        m_RADMenu.MaxItemsInGroup = objHashTableMenu.MaxItemsInGroup
        'Code Added:RajeshB 20th Nov, 2004 WAF2_PB_46
        m_CSSFile = m_RADMenu.CssFile

        'Addition Ends.

        m_MenuGroup = New EventMenuGroup
        m_MenuGroup.Flow = objHashTableMenu.BasicLayout
        m_MenuGroup.ExpandEffect = objHashTableMenu.ExpandEffect
        m_MenuGroup.EventHandler = CType(objNavigation, IMenuGroupEventHandler)
        m_RADMenu.RootGroup = m_MenuGroup
        m_RADMenu.DefaultItemRightLogo = objHashTableMenu.DefaultItemRightLogo
        SetActiveMenu(objNavigation.m_MenuItem)
        Call CommonEngine.General.CLCP_Events_Navigation.AfterMenuInitialize(m_RADMenu)
        'objNavigation.m_MenuItem = New EventMenuItem
        'objNavigation.m_MenuItem.Label = "Start"
        'objNavigation.m_MenuItem.Category = "Generated"
        'objNavigation.m_MenuItem.ID = objNavigation.strFromWhere
        'm_RADMenu = New EventMenu(New InheritableMenu)
        'm_RADMenu.ID = "menu1"
        'm_RADMenu.Overlay = True
        'm_RADMenu.ImagesBaseDir = "../../Images"
        'm_RADMenu.CssFile = "../../Common/Styles.css"
        'm_MenuGroup = New EventMenuGroup
        'm_MenuGroup.EventHandler = objEventHandler
        'm_RADMenu.RootGroup = m_MenuGroup
        'm_RADMenu.RootGroup.Flow = "horizontal"
        'm_RADMenu.AbsolutePositioning = True
        'm_RADMenu.AbsoluteX = 100
        'm_RADMenu.AbsoluteY = 10
        'm_RADMenu.OnClientItemHighlight = "ProcessClientHover"
        'm_RADMenu.ShowPath = True
        'm_RADMenu.ShadowColor = "Red"
        'm_RADMenu.ShadowWidth = 10
        ''m_RADMenu.RootGroup.ScrollHeight = 20
        'm_RADMenu.Opacity = 100
        'm_RADMenu.RootGroup.ExpandEffectDuration = 5000
        'm_RADMenu.RootGroup.ExpandDirection = "Right"
        'm_RADMenu.RootGroup.ExpandEffectDuration = 5000




    End Sub
    Private Shared Sub m_RADMenu_AfterMenuHTMLReplace(ByRef objComp As DynamicMenu.EventMenu) Handles m_RADMenu.AfterMenuHTMLReplace
        Call CommonEngine.General.CLCP_Events_Navigation.AfterMenuHTMLReplace(objComp)
    End Sub
    Private Sub BeforeChildItemAssign(ByRef Cancel As Boolean, ByRef item As MenuItemDecorator, ByRef [group] As MenuGroupDecorator) Implements IMenuGroupEventHandler.BeforeChildGroupAssign
        Dim args1 As EventMenuItem = DirectCast(item, EventMenuItem)
        Dim args2 As EventMenuGroup = DirectCast([Group], EventMenuGroup)
        Dim blnCancel As Boolean = False
        Call CommonEngine.General.CLCP_Events_Navigation.BeforeChildItemAssign(blnCancel, args1, args2)
    End Sub
    Private Sub AfterChildItemAssign(ByRef item As MenuItemDecorator, ByRef [group] As MenuGroupDecorator) Implements IMenuGroupEventHandler.AfterChildGroupAssign
        Dim args1 As EventMenuItem = DirectCast(item, EventMenuItem)
        Dim args2 As EventMenuGroup = DirectCast([Group], EventMenuGroup)

        Call CommonEngine.General.CLCP_Events_Navigation.AfterChildItemAssign(args1, args2)
    End Sub
    Private Shared Sub m_RADMenu_BeforeMenuHTMLReplace(ByRef Cancel As Boolean, ByRef objComp As DynamicMenu.EventMenu) Handles m_RADMenu.BeforeMenuHTMLReplace
        Call CommonEngine.General.CLCP_Events_Navigation.BeforeMenuHTMLReplace(Cancel, objComp)
    End Sub
    Private Shared Sub m_RADMenu_BeforePlotMenu(ByRef Cancel As Boolean, ByRef objComp As DynamicMenu.EventMenu)
        Call CommonEngine.General.CLCP_Events_Navigation.BeforePlotMenu(Cancel, objComp)
    End Sub
    Private Shared Sub m_RADMenu_AfterPlotMenu(ByRef objComp As DynamicMenu.EventMenu)
        Call CommonEngine.General.CLCP_Events_Navigation.AfterPlotMenu(objComp)
    End Sub
    Private Sub m_MenuGroup_BeforeAddItem(ByRef Cancel As Boolean, ByRef item As MenuItemDecorator) Implements IMenuGroupEventHandler.BeforeAddItem
        Call CommonEngine.General.CLCP_Events_Navigation.BeforeAddItem(Cancel, item)
    End Sub
    Private Sub m_MenuGroup_AfterAddItem(ByRef item As MenuItemDecorator) Implements IMenuGroupEventHandler.AfterAddItem
        Call CommonEngine.General.CLCP_Events_Navigation.AfterAddItem(item)
    End Sub


    'Added By Bharat T on 18th-Aug-2017 for Whzible Wrapper Changes
    <System.Web.Services.WebMethod()>
    Public Shared Sub ApplyWrapperSitePage()
        Try
            Dim strSQL As String = ""
            Dim strProjectID As String = ""

            strProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")).ToString

            If strProjectID = "" Then
                strProjectID = "NULL"
            End If
            strSQL = "Usp_App_ApplyWrapperSitePage_ToShow " & HttpContext.Current.Session("intUserID").ToString & "," & HttpContext.Current.Session("CurrentPageTagID").ToString & "," & strProjectID
            CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
        Catch ex As Exception
            ''Return "Bad Request Found"
        End Try
    End Sub
    'End of Added By Bharat T on 18th-Aug-2017 for Whzible Wrapper Changes
End Class
