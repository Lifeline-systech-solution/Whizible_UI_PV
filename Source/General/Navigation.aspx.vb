Imports Authentication
Imports System.Threading
'Added Nov 15, 2004 RajeshB  R.No:WAF2_PB_46
Imports DynamicMenu
Imports Whizible
Imports System.Web.Hosting



'Addition Ends
Public Class Navigation
    Inherits WebPage.Templates.WhizTemplate
    Implements IMenuGroupEventHandler

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
    Public strPassword As String
    Public strLoginID As String
    Public dtClientDate As Date
    Public strQSParameters As String
    Public strFromWhere As String
    Public strMainPage As String
    Public strSubPage As String
    Public strProjectName As String
    Public strTitle As String
    Public strLogin As String
    Public strOrgLogin As String
    Public strOrgPassword As String
    Public strAuthenticationType As String
    Public strBTSSubString As String
    Public strFrameWidth As String
    Public intFrameWidth As Integer
    Public strMode As String
    Public intPMFlag As Integer
    Public strBTSMainString As String = ""
    Public strKMSubString As String = ""
    Public PM_PROJECT_LISTING As Long
    ' ***********************************************************************************
    ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    Public m_strLoginName As String = ""
    Public m_blnIsWindowsAuthenticated As Boolean = False
    Public m_blnIsValidDomain As Boolean = True
    'added by AniruddhaD on 4 Jan 2006 for common portal  login
    Public blnCalledFromPortal As Boolean = False
    Protected strShowUI As String = "1"
    Private strCSSID As String = ""
    ' ***********************************************************************************
    ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    ' ***********************************************************************************
    ' Added Nov 06, 2004 RajeshB  R.No:WAF2_PB_46
    ' ***********************************************************************************
    Public Shared m_blnDefaultNavigation As Boolean = False
    Public Delegate Sub MenuGroupEvents()
    Public m_MenuItem As EventMenuItem
    ' ***********************************************************************************
    ' End Addition  R.No:WAF2_PB_46
    ' ***********************************************************************************
    'Added Nov 20, 2004 RajeshB
    Public WithEvents m_GenerateTree As New CommonFunctions.GenerateTree
    'End Of Addition
    'For passing values
    Protected WithEvents link As System.Web.UI.HtmlControls.HtmlGenericControl
    'Passed value

    ' ***********************************************************************************
    ' Addd Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
    ' ***********************************************************************************
    Public Shared m_NavHashTable As Hashtable
    ' ***********************************************************************************
    ' End of Addition Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
    ' ***********************************************************************************
    '-------------------------------------------------------------------------------------------------------------
    'Added By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
    'Reason   - For Navigation Header Height.
    '-------------------------------------------------------------------------------------------------------------
    Protected m_sngNavigationFrameHeight As Single
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
    '-------------------------------------------------------------------------------------------------------------

    '-------------------------------------------------------------------------------------------------------------
    'Added By    - PushkarK On - Thursday, December 22, 2005 For Req.ID. - WAF3_GEN_2
    'Reason      - For Navigation Menu.
    '-------------------------------------------------------------------------------------------------------------
    Protected m_blnEnableNavMenuPane As Boolean
    Protected m_strScrollForNavPane As String = ""
    '-------------------------------------------------------------------------------------------------------------
    'Addition Ends By - PushkarK On - Thursday, December 22, 2005 For Req.ID. - WAF3_GEN_2
    '-------------------------------------------------------------------------------------------------------------
    'Added By VarunA on 10-June-2008 RequestID-13756
    'Purpose : To have default module when that role is not accessible to module (which is set at the time of Project Selected)
    Public strDefaultModule As String
    'End By VarunA on 10-June-2008 RequestID-13756

    'added by aniruddhad for jump to record functionality
    Protected strJumpURL As String = ""
    Private m_GlobalObject As WebPages.Template.IGlobal
    'end addition by aniruddhad
    Protected m_strChangeUser As String = ""
    Protected m_RoleDesc As String = ""
    Protected m_username As String = ""
    Protected strLogin1 As String = ""

    Protected m_strPasswordForEncrypt As String = ""

    ''Added By Vaijat K ON 03/11/2017 For Checking Version
    Protected m_ProductVersion As String = "1"
    Protected AllowVersionChange As String = "0"
    Public m_strAlertCount As String = "0"
    Public m_strNotificationCount As String = "0"
    Public m_strDiscussionCount As String = "0"
    Protected m_ShowChangeVersion As String = "0"
    'Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27
    'Added By Dipali V On 11th Aug 2023 For Check Login User Module Access
    Protected GProjectModuleAcess As String = "0"
    'End of Added By Dipali V On 11th Aug 2023 For Check Login User Module Access
    'End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27
    ''End Added By Vaijat K ON 03/11/2017
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ''Added By Dipali V on 1 Aug 2016 Purpose::To decrypt Password

        '' Response.Write("<Script>alert(" + Session("intUserID") + ")</Script>")
        'Response.Write("<Script>alert('" + Token.GetToken("Vaijat") + "')</Script>")
        'If CommonFunctions.General.CheckIsNothing(Session("RandomNumber"), "").ToString() <> CommonFunctions.General.CheckIsNothing(Request.Form("hdnRandom"), "").ToString() Then
        '    Response.Write("<Script>alert('" + Session("RandomNumber") + " // " + Request.Form("hdnRandom") + "')</Script>")
        'End If
        Dim strencryptedname As String
        Dim strencryptedlength As String
        Dim struniqueid As String
        Dim strflagSSO As String
        Dim strusername As String
        Dim isvalid As Boolean
        Dim strencryptedkey As String
        If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
            'strencryptedname = GetFormValue("txtEncryptedUserNameMobile")
            strencryptedname = GetFormValue("txtPasswordHideMobile")
            strencryptedlength = GetFormValue("txtEncryptedUserNameLengthMobile")
        Else
            'Commented & Added By Dipali V On 06th May 2026 For Token And Password Plaintext 
            'strencryptedname = GetFormValue("txtEncryptedUserName")
            strencryptedname = GetFormValue("txtPasswordHide")
            'End of Commented & Added By Dipali V On 06th May 2026 For Token And Password Plaintext 
            strencryptedlength = GetFormValue("txtEncryptedUserNameLength")
        End If
        ''------------------Coded by Nikhil  A on 15-June-2020 before giving to Vendor---
        'Dim DateToCompare As DateTime
        'Dim currentDate As DateTime
        'DateToCompare = "10/31/2021 8:30:52 AM"
        'currentDate = DateTime.Now

        'If currentDate > DateToCompare Then
        '    Throw New Exception()
        'End If

        ''-----------------End Of Added By Nikhil A -----------------------------

        'Added by swapnil aswale on 29/06/2016 for captcha
        If HttpContext.Current.Session("drawString") IsNot Nothing Then
            Dim drawStringCaptch As String = HttpContext.Current.Session("drawString")
            HttpContext.Current.Session("drawString") = Nothing
            Dim txtCaptch As String = GetFormValue("txtInput")

            If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
                txtCaptch = GetFormValue("txtInputM")
            Else
                txtCaptch = GetFormValue("txtInput")
            End If
            If drawStringCaptch <> txtCaptch Then
                'Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
                Dim strLoginName As String
                Dim strResult As String
                Dim strPwd1 As String

                strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(GetFormValue("txtLogin"), ""), "")
                'Commented & Added By Dipali V On 06th May 2026 For Token And Password Plaintext 
                ' strencryptedkey = strencryptedname.Substring(1, strencryptedlength)
                'Dim strpwd As String() = strencryptedname.Split("|")

                'For i As Integer = 0 To strpwd.Length - 2
                '    strPwd1 &= strpwd(i).Substring(0, 1)
                'Next
                'strPwd1 = StrReverse(strPwd1)
                strPwd1 = strencryptedname
                'End of Commented & Added By Dipali V On 06th May 2026 For Token And Password Plaintext 
                Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strPwd1)

                strPwd1 = objEncryptNewPassword.Encrypt()

                strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
                CommonFunctions.Data.GetDataScalar("Usp_Check_Upd_User_LoginDetails '" & strLoginName & "','" & strPwd1 & "','INVALIDCAPCHA'", True)))
                'End of Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization

                Response.Redirect("../../default.aspx?MES=INVALIDCAPCHA")
            End If


        End If

        'Ended by swapnil aswale

        ' Added By Nikhil Mane on 28th April 2026 to handle password change on MultiBrowser issue
        If Session("intLoginID") IsNot Nothing AndAlso Session("SecurityStamp") IsNot Nothing Then

            Dim strDBStamp As String = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_SecurityStamp_For_LoginID " & Session("intLoginID"), True), ""), "")

            Dim strSessionStamp As String = Session("SecurityStamp").ToString()

            ' Only kick if DB has a real stamp AND it differs
            If strDBStamp <> "" AndAlso strSessionStamp <> "" AndAlso strDBStamp <> strSessionStamp Then

                CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(Session("intLoginID").ToString())
                Session("intUserID") = Nothing
                Session.Abandon()
                RedirectToDefaultPage("Message=PASSWORDCHANGED")
            End If
        End If
        'End Of Added By Nikhil Mane on 28th April 2026 to handle password change on MultiBrowser issue

        '' Added By Vidya Jadhav ON 5 Oct 2016 For Mobile Responsive Issue
        If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
            strusername = MyBase.GetFormValue("txtLoginMobile", False)
        Else
            strusername = MyBase.GetFormValue("txtLogin", False)

        End If
        ''End Of Added By Vidya Jadhav ON 5 Oct 2016 For Mobile Responsive Issue

        ''Added By Vidya J ON 25 Aug 2016 For SSO Issue
        strLogin = CommonFunction.General.DecryptString(Request.QueryString("SWC"))

        m_strChangeUser = MyBase.GetFormValue("ChangeUser", False)
        If Not m_strChangeUser Is Nothing Then
            Session("FlagChangeUser") = m_strChangeUser
        Else
            m_strChangeUser = Session("FlagChangeUser")
        End If

        If m_strChangeUser = "" Or m_strChangeUser Is Nothing Then
            m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(strLogin, sender)
        Else
            m_blnIsWindowsAuthenticated = False
        End If
        'Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext 
        'UnCommented By Bharat T on 11th-Nov-2016 for MasterCard Upgrade Issue Fixing
        'If Not m_blnIsWindowsAuthenticated Then
        '    ''End Of Added By Vidya J ON 25 Aug 2016 For SSO Issue
        '    'Modified By Chakshuta H on 24th-May-2017 Purpose::UAT issue fixing
        '    'If Not strencryptedname Is Nothing Then
        '    If Not strencryptedname Is Nothing And strencryptedname <> "" Then
        '        'End of Modified By Chakshuta H on 24th-May-2017 Purpose::UAT issue fixing
        '        struniqueid = XMLHttp.m_LoginHashTable.Item(strusername)

        '        strencryptedkey = strencryptedname.Substring(1, strencryptedlength)
        '        Dim strpwd As String() = strencryptedname.Split("|")

        '        For i As Integer = 0 To strpwd.Length - 2
        '            m_strPasswordForEncrypt &= strpwd(i).Substring(0, 1)
        '        Next
        '        m_strPasswordForEncrypt = StrReverse(m_strPasswordForEncrypt)
        m_strPasswordForEncrypt = strencryptedname
        '        isvalid = Token.ValidateUserNameToken(struniqueid, strencryptedkey)
        '        If (isvalid = False) Then
        '            RedirectToDefaultPage("Message=INVALIDLOGIN")

        '        End If
        '    End If
        'End If
        'End of UnCommented By Bharat T on 11th-Nov-2016 for MasterCard Upgrade Issue Fixing
        ''End of Added By Dipali V on 1 Aug 2016 Purpose::To decrypt Password
        'End of Commented  By Dipali V On 06th May 2026 For Token And Password Plaintext 
        ''Commented By Vidya J
        ''Added By Vaijat K ON 11/06/2016  For Prevent multiple login
        If Request.Form("hdDefault") = 1 Then
            If Session("uniqueSessionID") IsNot Nothing Then
                Response.Redirect("../../default.aspx?LogOut=1")
            End If
        End If

        ''End of Addition By Vaijat K
        ' ***********************************************************************************
        ' Added  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login] on 14-12-2015
        ' ***********************************************************************************

        Dim strOrgLoginPrevious As String = ""
        Dim strLoginPrevious As String = ""
        Dim strPasswordPrevious As String = ""
        ''Added by swapnil A for ChangeUser [single sign on] on 14-12-2015
        m_strChangeUser = MyBase.GetFormValue("ChangeUser", False)

        ''Ended
        ''Added by swapnil A for session timeout expire on 18-1-2016
        'If Context.Session IsNot Nothing Then
        '    If Session.IsNewSession Then
        '        Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED")
        '    End If
        'End If
        ''Ended
        m_username = Request.QueryString("FORMAUTHGROUP_ID__")
        If m_username IsNot Nothing Then
            m_username = Token.DecryptString(m_username)
            strOrgLoginPrevious = m_username
            strLoginPrevious = m_username
            Dim Str As String = ""
            Str = "EXEC usp_ins_tbl_pm_Multilogin  '" & m_username & "',NULL,NULL,2"
            Str = Str.Replace("''", "'")
            Dim drValidateLogin As IDataReader
            drValidateLogin = CommonFunction.Data.GetDataReader(Str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Dim strUserLoginIDNew As String = ""
            If drValidateLogin.Read Then
                strPasswordPrevious = drValidateLogin("password").ToString
                CommonFunction.Data.InsertOrUpdateData("usp_ins_tbl_pm_Multilogin '" & strLoginPrevious & "',NULL,1,3", True)
            End If

        Else

            If Not m_blnIsWindowsAuthenticated And Not blnCalledFromPortal Then
                If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
                    Session("Mobile") = "Mobile"
                    strOrgLoginPrevious = MyBase.GetFormValue("txtLoginMobile", False)
                    strLoginPrevious = MyBase.GetFormValue("txtLoginMobile", False)
                    strPasswordPrevious = MyBase.GetFormValue("txtPasswordMobile")

                Else
                    'Call function to set the application variables
                    strOrgLoginPrevious = MyBase.GetFormValue("txtLogin", False)
                    strLoginPrevious = MyBase.GetFormValue("txtLogin", False)
                    strPasswordPrevious = m_strPasswordForEncrypt

                End If




            End If
        End If
        If strLoginPrevious <> "" And strPasswordPrevious <> "" Then
            strPasswordPrevious = strPasswordPrevious.Replace("''", "'")
            Dim objPW1 As PWEncryption = New PWEncryption(strOrgLoginPrevious, strPasswordPrevious)
            'Call encrypt method of object and return it
            strPasswordPrevious = objPW1.Encrypt.ToString
            Session("strLoginPrevious") = strLoginPrevious
            Session("strPasswordPrevious") = strPasswordPrevious
            Session("mobileResponsive") = MyBase.GetFormValue("mobileResponsive", False)

            ''Added By Vaijat K ON 24/0/2017 For Checking Token For CSRF Attack
            Dim strToken As String = Token.GetToken(strOrgLoginPrevious)
            If (strToken <> Request.Form("hdnToken")) Then
                RedirectToDefaultPage("Message=INVALIDLOGIN")
            End If
            ''Added By Vaijat K ON 24/0/2017 For Checking Token For CSRF Attack

        Else
            strOrgLoginPrevious = Session("strLoginPrevious")
            strLoginPrevious = Session("strLoginPrevious")
            strPasswordPrevious = Session("strPasswordPrevious")

        End If

        m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(m_strLoginName, sender)
        ''Added by swapnil A for ChangeUser [single sign on]
        If m_strChangeUser <> "" Then
            m_blnIsWindowsAuthenticated = False
        End If
        ''Ended

        If m_blnIsWindowsAuthenticated Then

        Else
            If strLoginPrevious = "" Or strPasswordPrevious = "" Then
                Response.Redirect("../../default.aspx")
            Else
                Dim Str As String = ""
                ''Added by swapnagandh K
                'Str = "EXEC usp_ValidateLogin '" & CommonFunction.General.BuildQueryString(strLoginPrevious) & "','" & Trim(strPasswordPrevious) & "'"
                Str = "EXEC usp_ValidateActiveLogin '" & CommonFunction.General.BuildQueryString(strLoginPrevious) & "','" & Trim(strPasswordPrevious) & "'"
                ''end by swapnagandh K
                Str = Str.Replace("''", "'")
                Dim drValidateLogin As IDataReader
                drValidateLogin = CommonFunction.Data.GetDataReader(Str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Dim strUserLoginIDNew As String = ""
                If drValidateLogin.Read Then
                    strUserLoginIDNew = drValidateLogin("LoginID").ToString
                End If
                Dim Value2 As ArrayList = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItemValue(strUserLoginIDNew)
                If Value2 IsNot Nothing Then
                    For i As Integer = 0 To Value2.Count - 1
                        ' If Value2.Item(i) <> Session.SessionID Then
                        ''Commented And Added By Vaijat K ON 11/06/2016 For Prevent multiple login
                        ''Commented By Vidya J
                        ''If Value2.Item(i) <> Session.SessionID Then
                        If Value2.Item(i) <> Session("SessionID") Then
                            '    ''End of Addition By Vaijat K

                            CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(strUserLoginIDNew)
                            Session("intUserID") = Nothing
                            Session.Abandon()
                            'Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED&strLogin=" & strLoginPrevious & "&strPass=" & IIf(MyBase.GetFormValue("mobileResponsive", False) = "Mobile", MyBase.GetFormValue("txtPasswordM"), MyBase.GetFormValue("txtPasswordHide")) & "")
                            If MyBase.GetFormValue("txtPasswordMobile") <> "" Or m_strPasswordForEncrypt <> "" Then
                                CommonFunction.Data.InsertOrUpdateData("usp_ins_tbl_pm_Multilogin '" & strLoginPrevious & "','" & IIf(MyBase.GetFormValue("mobileResponsive", False) = "Mobile", MyBase.GetFormValue("txtPasswordMobile"), m_strPasswordForEncrypt) & "',1,1", True)
                                ' Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED&strLogin=" & strLoginPrevious)
                                ' Server.Transfer("../../default.aspx&strLogin=" & strLoginPrevious)
                                ' HttpContext.Current.RewritePath("../../default.aspx?Message=SESSIONEXPIRED&strLogin=" & strLoginPrevious)
                                'Server.Transfer("../../default.aspx&strLogin=" & strLoginPrevious, True)


                                Response.Redirect("Navigation.aspx?FORMAUTHGROUP_ID__=" & Token.EncryptString(strLoginPrevious))

                                Exit Sub
                            Else
                                Response.Redirect("../../default.aspx?Message=SESSIONEXPIRED&Mode=M")
                            End If

                        End If
                    Next
                End If
                ' ***********************************************************************************
                ' Ended  Dec 1 2015 Swapnil A For Securtiy[Prevent multiple login]
                ' ***********************************************************************************

            End If

        End If



        'added by aniruddhad for jump to record functionality
        If Not Request("URL") Is Nothing Then
            If Request("URL") <> "" Then
                strJumpURL = Request("URL")
            End If
        End If
        'end addition by aniruddhad

        'added by AniruddhaD on 4 Jan 2005 for common NPP login
        If Request.QueryString("SWC") <> "" Then
            strShowUI = Request.QueryString("ShowUI")
            strLogin = CommonFunction.General.DecryptString(Request.QueryString("SWC"))
            Session("intUserID") = Nothing
            blnCalledFromPortal = True
            Session("CalledFromPortal") = True
            Session("WAF_StylesheetID") = strCSSID
        End If

        If Request.ServerVariables("HTTP_REFERER") = "" And blnCalledFromPortal Then
            Response.Clear()
            RedirectToDefaultPage("Message=PBNInvalidLogin" & strQSParameters)
        Else
            If blnCalledFromPortal Then
                Dim drLogin As IDataReader
                'check if passed username is valid in PBN
                drLogin = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & strLogin & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drLogin.Read Then 'Login found
                    If CType(drLogin("IsActiveLogin"), Boolean) = False Then 'login found, but not active
                        Response.Clear()
                        'RedirectToDefaultPage("Message=InvalidLogin" & strQSParameters)
                        Response.Redirect("../Portal/InvalidLogin.aspx")
                    End If
                Else 'login not found
                    'If Invalid login then redirect to the login page
                    Response.Clear()
                    'RedirectToDefaultPage("Message=InvalidLogin" & strQSParameters)
                    Response.Redirect("../Portal/InvalidLogin.aspx")
                End If
                CommonFunction.Data.DisposeDataReader(drLogin)
            End If
        End If
        ' Commented Nov 10 2005 RajK Hot Fix# 2.0.5-SP2-WAF
        ' this is being done at the end of the Page_load() sub
        ''Code Added:RajeshB 
        'Session("Navigation") = sender
        ''Addition Ends.
        ' End of Comment Nov 10 2005 RajK Hot Fix# 2.0.5-SP2-WAF


        ' ***********************************************************************************
        ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ***********************************************************************************
        ' set the Login name and Windows Authenticated flag

        If m_blnIsWindowsAuthenticated And Not m_blnIsValidDomain Then
            ' redirect to login page (default.aspx)
            Response.Redirect("../../Default.aspx?Message=InvalidDomain")
        End If
        ' ***********************************************************************************
        ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ***********************************************************************************

        'Call procedure to set the culture
        SetCulture()
        PM_PROJECT_LISTING = CommonFunction.Constants.PM_PROJECT_LISTING

        If Request.QueryString("ID") <> "" Then
            strQSParameters = "&ID=" & Request.QueryString("ID")
        End If

        If Trim(Request.QueryString("ProjectID_PK")) <> "" And Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            RedirectToDefaultPage("Message=InvalidLogin" & strQSParameters)
            'Response.Redirect("../../Default.aspx?Message=InvalidLogin" & strQSParameters)
        End If


        strFromWhere = Request.QueryString("FromWhere")
        strMainPage = Request.QueryString("MainPage")
        strSubPage = Request.QueryString("SubPage")
        '____________Modified By UmeshJ on 01 November 2004_______________
        'WHY:   Instead of retrieving the Project Name from the Query string get it from SQL
        '       This will avoid restrictions those we need to apply for the special characters in the Project Name
        strProjectName = ""

        'If Trim(Request.QueryString("ProjectID_PK")) <> "" Then
        'strProjectName = Replace(Replace(Request.QueryString("ProjectName") & "", "+", " "), "*", "&")
        ''Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''strProjectName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("SELECT ProjectName FROM tbl_PM_Project WHERE ProjectID = '" + Trim(Request.QueryString("ProjectID_PK")) + "'", MyBase.UseSQL), "")
        strProjectName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar("usp_sel_ProjectName_tbl_PM_Project '" + Trim(Request.QueryString("ProjectID_PK")) + "'", MyBase.UseSQL), "")
        ''end of Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        'End If
        If strProjectName <> "" Then Session("strProjectName") = strProjectName
        'End of modifications
        Session("strActiveModule") = strFromWhere

        If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
            If Request.Form.Item("txtLoginMobile") <> "" Then
                Session.Remove("intUserID")
                '************************************************************************
                'Code Added     :  RajeshB   19th Febuary 2005
                'Purpose        :   To check the last logon of the user
                '************************************************************************
                'If CType(CommonFunction.General.GetApplicationKeySetting("Environment"), String).ToUpper = "P" Then
                '    'Added by swapnil aswale on 2nd Sep 2015 for txtClientLoggedInAt control security problem [Add HtmlEncoding]
                '    Dim blnIsLastLogonValid As Boolean
                '    blnIsLastLogonValid = CType(CommonFunction.Data.GetDataScalar("EXEC usp_CheckLastLogon '" & CommonFunction.General.BuildQueryString(Request.Form.Item("txtLogin")) & "'," & System.DateTime.Now.Ticks(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                '    ''Ended
                '    If blnIsLastLogonValid = False Then RedirectToDefaultPage("Message=SessionExpired")
                'End If
            End If
        Else
            If Request.Form.Item("txtLogin") <> "" Then
                Session.Remove("intUserID")
                '************************************************************************
                'Code Added     :  RajeshB   19th Febuary 2005
                'Purpose        :   To check the last logon of the user
                '************************************************************************
                'If CType(CommonFunction.General.GetApplicationKeySetting("Environment"), String).ToUpper = "P" Then
                '    'Added by swapnil aswale on 2nd Sep 2015 for txtClientLoggedInAt control security problem [Add HtmlEncoding]
                '    Dim blnIsLastLogonValid As Boolean
                '    blnIsLastLogonValid = CType(CommonFunction.Data.GetDataScalar("EXEC usp_CheckLastLogon '" & CommonFunction.General.BuildQueryString(Request.Form.Item("txtLogin")) & "'," & System.DateTime.Now.Ticks(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
                '    ''Ended
                '    If blnIsLastLogonValid = False Then RedirectToDefaultPage("Message=SessionExpired")
                'End If
            End If
            '************************************************************************
            'End of Addition    :   RajeshB     19th Febuary 2005
            '************************************************************************

        End If
        ' ''Added By Vidya J ON 25 Aug 2016 For SSO Issue
        'If m_blnIsWindowsAuthenticated = True Or m_strChangeUser = "CU" Then
        '    Session("intUserID") = Nothing
        'End If
        ' ''End Of Added By Vidya J ON 25 Aug 2016 For SSO Issue
        'Session intUserID Null Start
        If (Session("intUserID") Is Nothing) Then
            ' ***********************************************************************************
            ' Added/Modified Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
            ' ***********************************************************************************
            If m_blnIsWindowsAuthenticated Then
                strLogin = m_strLoginName
                strPassword = ""
            Else
                'Integrated by MonikaI for Whizible SP 7.2 Issue ID 4518
                'Commented and Modified by SavitaS on 24 July 2006 for Sierra IssueID 2969 (Issue : Password Taking Special Characters)
                'strLogin = MyBase.FixString(MyBase.GetFormValue("txtLogin"), 30, False, True)
                'strLogin = MyBase.FixString(Request.Form("txtLogin"), 30, False, True)
                'End of Commented and Modified by SavitaS on 24 July 2006 for Sierra IssueID 2969 (Issue : Password Taking Special Characters)
                'added by AniruddhaD on 4 jan 2006 for common Portal login
                If blnCalledFromPortal = True Then
                    strLogin = MyBase.FixString(CommonFunction.General.DecryptString(Request.QueryString("SWC")), 30, False, True)
                Else
                    If m_username IsNot Nothing Then
                        strLogin = m_username
                        strOrgLogin = m_username
                        Dim Str As String = ""
                        Str = "EXEC usp_ins_tbl_pm_Multilogin  '" & m_username & "',NULL,NULL,2"
                        Str = Str.Replace("''", "'")
                        Dim drValidateLogin As IDataReader
                        drValidateLogin = CommonFunction.Data.GetDataReader(Str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                        Dim strUserLoginIDNew As String = ""
                        If drValidateLogin.Read Then
                            strPassword = drValidateLogin("password").ToString
                            CommonFunction.Data.InsertOrUpdateData("usp_ins_tbl_pm_Multilogin '" & strLoginPrevious & "',NULL,1,3", True)
                        End If
                    Else

                        If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
                            strLogin = MyBase.FixString(MyBase.GetFormValue("txtLoginMobile"), 30, False, True)
                            strOrgLogin = MyBase.GetFormValue("txtLoginMobile", False)
                            strPassword = MyBase.GetFormValue("txtPasswordMobile")
                            If strPassword = "" And strLogin <> "" Then
                                Dim Str As String = ""
                                Str = "EXEC usp_ins_tbl_pm_Multilogin  '" & strLogin & "',NULL,NULL,2"
                                Str = Str.Replace("''", "'")
                                Dim drValidateLogin As IDataReader
                                drValidateLogin = CommonFunction.Data.GetDataReader(Str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                Dim strUserLoginIDNew As String = ""
                                If drValidateLogin.Read Then
                                    strPassword = drValidateLogin("password").ToString
                                    CommonFunction.Data.InsertOrUpdateData("usp_ins_tbl_pm_Multilogin '" & strLoginPrevious & "',NULL,1,3", True)
                                End If
                            End If
                            strOrgPassword = CommonFunctions.General.UnBuildQueryString(strPassword)
                        Else
                            strLogin = MyBase.FixString(MyBase.GetFormValue("txtLogin"), 30, False, True)
                            strOrgLogin = MyBase.GetFormValue("txtLogin", False)
                            ' strPassword = MyBase.GetFormValue("txtPasswordHide")
                            strPassword = m_strPasswordForEncrypt
                            If strPassword = "" And strLogin <> "" Then
                                Dim Str As String = ""
                                Str = "EXEC usp_ins_tbl_pm_Multilogin  '" & strLogin & "',NULL,NULL,2"
                                Str = Str.Replace("''", "'")
                                Dim drValidateLogin As IDataReader
                                drValidateLogin = CommonFunction.Data.GetDataReader(Str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                                Dim strUserLoginIDNew As String = ""
                                If drValidateLogin.Read Then
                                    strPassword = drValidateLogin("password").ToString
                                    CommonFunction.Data.InsertOrUpdateData("usp_ins_tbl_pm_Multilogin '" & strLoginPrevious & "',NULL,1,3", True)
                                End If
                            End If

                            strOrgPassword = CommonFunctions.General.UnBuildQueryString(strPassword)
                        End If
                    End If
                End If

                'end of addition

                'commented by Aniruddhad on 4 Jan 2006 for common NPP login
                'strLogin = MyBase.FixString(MyBase.GetFormValue("txtLogin"), 30, False, True)

                'strOrgLogin = MyBase.GetFormValue("txtLogin", False)
                'strPassword = MyBase.GetFormValue("txtPasswordHide")
                'strOrgPassword = CommonFunctions.General.UnBuildQueryString(strPassword)
                'end of comment


                'strOrgPassword = CommonFunctions.General.UnBuildQueryString(strPassword)
                'End of integration
            End If
            ' ***********************************************************************************
            ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
            ' ***********************************************************************************

            'Call CommonFunction.General.GetCorporateSettings(False)

            'Call the Getauthentication type function get the authentication type
            strAuthenticationType = GetAuthenticatoinType()

            ' ***********************************************************************************
            ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
            ' ***********************************************************************************
            ' we don't need password for windows authentication
            If Not m_blnIsWindowsAuthenticated And Not blnCalledFromPortal Then
                'Call function to set the application variables
                strPassword = GetEncryptedPassword()
            End If
            ' ***********************************************************************************
            ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
            ' ***********************************************************************************


            'objCommonFunction.GetCorporateSettings(False)

            If Request("MultiLocation") = "1" Then 'Multilcoation If

                Dim drGetUserPW As IDataReader

                drGetUserPW = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login " & Request.QueryString("LoginID"), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drGetUserPW.Read Then
                    strLogin = CommonFunction.General.BuildQueryString(drGetUserPW("LoginName").ToString)
                    strPassword = CommonFunction.General.BuildQueryString(drGetUserPW("Password").ToString)
                End If '
                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                'drGetUserPW.Close()
                CommonFunction.Data.DisposeDataReader(drGetUserPW)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 


                'Call CommonFunction.General.GetCorporateSettings(False)

                'To Call the function to set the application variables
                'Call objCommonFunction.GetCorporateSettings(False)
                'Validate the login
                Call ValidatePBNLogin(1, strLogin, strPassword)

            Else 'Multilcoation else part
                'Data Reader
                Dim drLogin As IDataReader
                Dim strWhichLogin As String

                'Modified by MrugajaB for Whiziblesem SP7 on 17th Aug 2006
                'Purpose:When LoginName consists of single quote character ,page crashes
                'Find out the login Type
                'modifed by purvaj on 30 jun 2009 8.1 issue fixes.
                '"CommonFunction.General.BuildQueryString" removed from strLogin as getformvalue adjusts the single quote.
                '" due to this 'was getting appended multiple times. hence user was not able to login if login name contains single quote
                drLogin = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & strLogin & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'End Modification
                If drLogin.Read Then
                    strWhichLogin = drLogin("LoginType").ToString
                Else
                    'If Invalid login then redirect to the login page
                    Response.Clear()

                    'Response.Redirect("../../Default.aspx?Message=PBNInvalidLogin" & strQSParameters)
                    RedirectToDefaultPage("Message=PBNInvalidLogin" & strQSParameters)

                End If


                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                'drLogin.Close()
                'CommonFunction.Data.DisposeDataReader(drLogin)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                If blnCalledFromPortal = False Then 'if condition added by ANiruddhaD on 4 Jan 2005 for common NPP login
                    'strWhichLogin If
                    If strWhichLogin = "E" Then

                        Select Case strAuthenticationType
                            Case "N"   'LDAP Authentication Disabled
                                If m_blnIsWindowsAuthenticated Then
                                    ' if the user is valid
                                    Call ValidatePBNLogin(1, strLogin, strPassword)
                                Else
                                    Call ValidatePBNLogin(0, strLogin, strPassword)
                                End If

                            Case "Y" 'Ldap Authentication Successful
                                If CLng(VallidateLDAPLogin(strLogin, strOrgPassword)) = 1 Then
                                    Call ValidatePBNLogin(1, strLogin, strPassword)
                                Else
                                    Response.Clear()
                                    If Not strQSParameters Is Nothing Then
                                        RedirectToDefaultPage("Message=LDAPInvalidLogin" & strQSParameters.ToString)
                                        'Response.Redirect("../../Default.aspx?Message=LDAPInvalidLogin" & strQSParameters.ToString)
                                    Else
                                        RedirectToDefaultPage("Message=LDAPInvalidLogin")
                                        'Response.Redirect("../../Default.aspx?Message=LDAPInvalidLogin")
                                    End If
                                End If

                            Case "M" 'Validate Mix Login

                                Call ValidateMixedLogin(strLogin, strPassword, strOrgPassword)


                        End Select
                    Else
                        Call ValidatePBNLogin(0, strLogin, strPassword)
                    End If 'End If for strWhichLogin
                Else 'called from NPP Added by AniruddhaD on 4 Jan 2006 for common NPP login
                    If CType(drLogin("LoginType"), String) = "E" Then
                        Session("intUserID") = drLogin("EmployeeID")
                        Session("intPostID") = drLogin("RoleID")
                        Session("strUserName") = drLogin("UserName")
                        Session("LoginType") = "E"
                        Session("IsCreatedByCustomer") = False
                        Session("intLoginID") = drLogin("LoginID")
                        Session("LCID") = 1033
                        'Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                        'Commented By Amit Mahadik on 0-Mar-2013
                        'Session("strEmpName") = drLogin("DispalyName")
                        'End Commented By Amit Mahadik on 0-Mar-2013
                        'ENd Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                    Else
                        Session("LCID") = 1033
                        Session("intUserID") = drLogin("CustomerID")
                        Session("intPostID") = drLogin("RoleID")
                        'Replace customer name with login name for customer login
                        'modified by ashishr 17 sep 2001
                        Session("strUserName") = drLogin("CustomerName")
                        ''end
                        Session("LoginType") = "C"
                        Session("intLoginID") = drLogin("LoginID")
                        If CType(drLogin("IsCreatedByCustomer"), Boolean) = True Then
                            Session("IsCreatedByCustomer") = True
                            Session("CustomerCreatedLoginID") = drLogin("LoginID")
                        Else
                            Session("IsCreatedByCustomer") = False
                        End If
                        'Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                        'Commented By Amit Mahadik on 0-Mar-2013
                        'Session("strEmpName") = drLogin("DispalyName")
                        'End Commented By Amit Mahadik on 0-Mar-2013
                        'ENd Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                    End If
                End If

            End If 'Multilcoation End If

            'Set the client to the session variable    
            If Trim(CType(Session("ClientDate"), String)) = "" Then
                Session("ClientDate") = MyBase.GetFormValue("txtClientDate")
            End If

            'Call a procedure to set the default settings
            Call SetDefaultModuleAndProject()

            '-------------Added By Purvaj on 17 Dec 2008 Code moved here
            '-------------Demo evaluation will be checked only once when user logs in..
            'If IsDemoVersion() = True Then
            '    Dim strConString As String = "Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=" + CommonFunction.FileDirectory.CleanPath(Server.MapPath("../../Projects/")) + "Registration.mdb" + " ;Jet OLEDB:Database Password=indianpicaso"
            '    Dim objRegistration As New Registration.ProductRegistration
            '    objRegistration.ConnectionString = strConString
            '    objRegistration.InitializeDB()

            '    If objRegistration.IsProductRegister = False Then
            '        objRegistration.ExpireType = Registration.ProductRegistration.enumExpireType.FixedDate
            '        Dim mintRemDays As Long
            '        mintRemDays = 0
            '        If objRegistration.ValidateDemoValue(mintRemDays) = False Then
            '            objRegistration = Nothing
            '            Response.Clear()
            '            Server.Transfer("EvaluationExpiry.aspx")
            '        End If
            '    End If
            '    objRegistration = Nothing
            'End If
            '---------- End addition purvaj

        End If 'Session intUserID Null end

        If Request.QueryString("ProjectID_PK") <> "" Then ' Request PRojectID IF
            Session("intProjectID") = Request.QueryString("ProjectID_PK")
            'If CType(Application("Chanakya_ApplyProjectLevelRole"), Boolean) = True Then 'Application Project LEvel IF
            If CommonFunction.Application.ApplyProjectLevelRole = True Then   'Application Project LEvel IF
                If CType(Session("intRoleLevel"), Integer) = CommonFunction.Constants.ACCESS_LEVEL_LOW Or GetRole() = "Employee" Then

                    Dim drGetRole As IDataReader
                    drGetRole = CommonFunction.Data.GetDataReader("EXEC usp_Sel_EmployeeProjectRole " & CType(Session("intProjectID"), Long) & "," & CType(Session("intUserID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drGetRole.Read Then
                        Session("intLastPostID") = Session("intPostID")
                        Session("intPostID") = drGetRole(0)
                    End If
                    'Close the object
                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                    'Close the object
                    'drGetRole.Close()
                    CommonFunction.Data.DisposeDataReader(drGetRole)

                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                Else
                    If Trim(CType(Session("intLastPostID"), String)) <> "" Then Session("intPostID") = Session("intLastPostID")
                End If

            End If 'Application Project LEvel End IF
        End If   'Requset projectid end if
        '###### EVAL REGISTRATION CODE
        '--- Commented BY purvaj on 17 Dec 2008 for whiziblesem 8.0
        '--------------------Code moved to 'If (Session("intUserID") Is Nothing) Then'

        'If IsDemoVersion() = True Then
        '    Dim strConString As String = "Provider=Microsoft.Jet.OLEDB.4.0;Persist Security Info=False;Data Source=" + CommonFunction.FileDirectory.CleanPath(Server.MapPath("../../Projects/")) + "Registration.mdb" + " ;Jet OLEDB:Database Password=indianpicaso"
        '    Dim objRegistration As New Registration.ProductRegistration
        '    objRegistration.ConnectionString = strConString
        '    objRegistration.InitializeDB()

        '    If objRegistration.IsProductRegister = False Then
        '        objRegistration.ExpireType = Registration.ProductRegistration.enumExpireType.FixedDate
        '        Dim mintRemDays As Long
        '        mintRemDays = 0
        '        If objRegistration.ValidateDemoValue(mintRemDays) = False Then
        '            objRegistration = Nothing
        '            Response.Clear()
        '            Server.Transfer("EvaluationExpiry.aspx")
        '        End If
        '    End If
        '    objRegistration = Nothing
        'End If
        '----End comment purvaj

        '#######
        'Call a sub to store role level into the session
        ApplyRoleLevel()

        'To handle issue base direct access
        If CType(Session("strURLRequested"), String) <> "" Then 'IB

            Dim drDummy As IDataReader

            strSubPage = CType(Session("strURLRequested"), String)
            Session("strURLRequested") = ""

            ' Delete the entry from the database as well.
            If Request.QueryString("ID") <> "" Then

                drDummy = CommonFunction.Data.GetDataReader("Exec usp_Del_tbl_PM_URLRequests " & Request.QueryString("ID"), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'Close the object
                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                'Close the object
                'drDummy.Close()
                CommonFunction.Data.DisposeDataReader(drDummy)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

            End If

        End If 'IB
        ''Addded by swapnil aswale on 6-1-2016 for mobile responsive
        m_RoleDesc = GetRoleDesc()
        Session("RoleDesc") = m_RoleDesc
        ''Ended

        ' Modified Aug 24 2005 RajK  
        ' Moved the method call to GetSelectedModuleDetails() after the  WAF2_PB_57 code


        ' Modified Nov 7 2005 RajK Hot Fix# 2.0.4-SP2-WAF
        ' Commented the call to set QRB session variables
        ' ***this will be handled in CQuery Class' BuildQuery() method

        ' Added By Rajanikant Jan 15,2004
        ' Set the QRB session variables here
        'Call CommonFunctions.General.SetQRBSessionVariables()
        ' End Addition
        ' End of Modification Nov 7 2005 RajK Hot Fix# 2.0.4-SP2-WAF


        ' ***************************************************************************************
        ' Added Aug 26,2004 Rajanikant Khethawatt R.No.WAF2_PB_57  Application level stylesheet
        ' ***************************************************************************************
        ' check if user stylesheet is enabled in framework
        ''commented by PrashantSJ on 18th June 2009: SEM 8.1 Purpsoe: Following condition removed for portal
        ' If Not blnCalledFromPortal Then
        If CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_USER_STYLESHEET", "Enabled") Then
            ' check if user has set any stylesheet
            Dim dr As IDataReader
            dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_UI_UserSettings  " & Session("intLoginID").ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If dr.Read Then
                ' set the user app. wide stylesheet id in session
                Session("WAF_StylesheetID") = dr("StyleSheetID").ToString
            Else
                Session("WAF_StylesheetID") = ""
            End If
            ' dispose data reader obj.
            CommonFunctions.Data.DisposeDataReader(dr)
        End If
        ' End If
        ''end of comment by PrashantSJ on 18th June 2009: SEM 8.1 Purpsoe: Following condition removed for portal
        ' ***************************************************************************************
        ' End Addition Aug 26,2004 Rajanikant Khethawatt
        ' ***************************************************************************************

        Call GetSelectedModuleDetails(strFromWhere)

        ' End Modified Aug 24 2005 RajK


        ' Added Nov 10 2005 RajK Hot Fix# 2.0.5-SP2-WAF
        If Not m_blnDefaultNavigation Then
            ' ***********************************************************************************
            ' Modified Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
            ' ***********************************************************************************
            ' storing the Navigation object(sender) in hash table instead of Session
            m_NavHashTable = New Hashtable
            m_NavHashTable.Add("NAVIGATION", sender)
            'Session("Navigation") = sender
            ' ***********************************************************************************
            ' End of Modification Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
            ' ***********************************************************************************
        End If
        ' End of Addition Nov 10 2005 RajK Hot Fix# 2.0.5-SP2-WAF

        ''Added By Vaijat K On 17/12/2015 Purpose: MyQuickView
        'If Session("intUserID") IsNot Nothing Then
        '    If Not Global_asax.HashTables.Contains("ID" & Session("intUserID")) Then
        '        Global_asax.HashTables.Add("ID" & Session("intUserID"), Session("intUserID"))
        '    End If
        'End If
        'Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization 2016-17
        CommonFunctions.Data.InsertOrUpdateData("Usp_Upd_tbl_PM_Login_IsLocked " & Session("intLoginID"), True)
        'Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization 2016-17
        ''Commented by Vishal Mane on 07/07/2025 for SAML SSO Integration
        'If Session("strUserName") IsNot Nothing AndAlso Session("AuthToken") IsNot Nothing AndAlso Request.Cookies("AuthToken") IsNot Nothing Then
        '    If Not Session("AuthToken").ToString().Equals(Request.Cookies("AuthToken").Value) Then
        '        ' redirect to the login page in real application
        '        If Session("SAML") Is Nothing Then
        '            RedirectToDefaultPage("Message=INVALIDLOGIN")
        '        End If

        '    Else

        '    End If
        'Else
        '    RedirectToDefaultPage("Message=INVALIDLOGIN")
        'End If
        ''Commented by Vishal Mane on 07/07/2025 for SAML SSO Integration
        ''Added By Vaijat K ON 13/12/2017 For Theme And Count
        ''Added by Swapnagandha ON 2/20/2019 For Mobile view
        If MyBase.GetFormValue("mobileResponsive", False) = "Mobile" Then
            m_ProductVersion = "3"
        Else
            m_ProductVersion = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_NG2_UserThemeSettings " & HttpContext.Current.Session("intLoginID"), True), 1), "1")
        End If

        ' m_ProductVersion = "1"
        ''End by swapnagandha

        'm_ShowChangeVersion = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Chk_Ng2_tbl_NG2_ChangeVersion_Access " & HttpContext.Current.Session("intPostID"), True), 1), "1")
        Dim drCompany As IDataReader
        drCompany = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        If drCompany.Read() Then
            AllowVersionChange = CommonFunctions.Data.CheckIsDBNull(drCompany("AllowVersionChange"), "0")
        End If
        GetDataCount()
        'Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27
        'Added By Dipali V On 11th Aug 2023 For Check Login User Module Access
        Dim strSQLQuery As String
        Dim ProjectModuleAcess As String
        strSQLQuery = "EXEC usp_Whizible2_CheckEmployeeProjectModuleacess " & CType(HttpContext.Current.Session("intLoginID"), Long) & ", " & CType(HttpContext.Current.Session("intUserID"), Long) & ""
        ProjectModuleAcess = CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If ProjectModuleAcess <> "0" Or ProjectModuleAcess <> "" Then
            GProjectModuleAcess = ProjectModuleAcess
        End If
        'End of Added By Dipali V On 11th Aug 2023 For Check Login User Module Access
        'End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27
        ''End Added By Vaijat K ON 13/12/2017 For Theme And Count
    End Sub

    Public Function GetDataCount()
        ''Added method By Vaijat K ON 13/11/2017 For Count of alerts
        Dim dtCount As New DataTable
        dtCount = CommonFunctions.Data.GetDataTable("usp_NG2_SEL_tbl_NG2_HelpdeskAlertsCount " & Session("intUserID") & ",'" & Session("LoginType") & "'", True)
        For Each drow As DataRow In dtCount.Rows
            m_strAlertCount = CommonFunctions.Data.CheckIsDBNull(drow("AlertCount"))
            m_strNotificationCount = CommonFunctions.Data.CheckIsDBNull(drow("NotificationCount"))
            m_strDiscussionCount = CommonFunctions.Data.CheckIsDBNull(drow("DiscussionCount"))
        Next
    End Function
    Private Function IsDemoVersion() As Boolean

        Dim objCheckVersion As New ValidateVersion.Version
        Dim blnIsDemoVersion As Boolean = objCheckVersion.IsDemoVersion("?")
        objCheckVersion = Nothing
        Return blnIsDemoVersion

    End Function
    Protected Overrides Sub Finalize()
        ' ***********************************************************************************
        ' Modified Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
        ' ***********************************************************************************
        ' using the hash table instead of session variable
        'Session("Navigation") = Nothing
        m_NavHashTable = Nothing
        ' ***********************************************************************************
        ' End of Modification Nov 16 2005 RajK Hot Fix# 2.0.10-SP2-WAF
        ' ***********************************************************************************
        m_GenerateTree = Nothing
        MyBase.Finalize()
    End Sub


    Private Function GetEncryptedPassword() As String
        '=====================================================================
        ' Procedure Name		:	GetEncryptedPassword
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	Get the encrypted password
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	24 July , 2003
        ' Revisions				:	
        '=====================================================================
        '--- Added By purvaj on 30 Jun 2009 for 8.1 issue fixes
        '--- getformvalue replaces single quote with the double single quotes
        '--- hence '' replaced with ' here. wrong password was getting encrypted.
        strPassword = strPassword.Replace("''", "'")
        Dim objPW As PWEncryption = New PWEncryption(strOrgLogin, strPassword)
        'Call encrypt method of object and return it
        Dim strEncryptedPW As String = objPW.Encrypt.ToString
        objPW = Nothing
        Return strEncryptedPW

    End Function
    Private Function GetAuthenticatoinType() As String
        '=====================================================================
        ' Procedure Name		:	GetAuthenticatoinType
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	Get the 
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	Returns the authenitcation type -Mixed-LDAP-Disable
        ' Author				:	AshishR
        ' Created				:	4 May 2002
        ' Revisions				:	4 May 2002
        '=====================================================================

        Return CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString

    End Function

    Private Function CheckForMultipleLogins(ByVal strUserLoginID As String, ByVal strUserLoginName As String) As Boolean
        '-------------------------------------------------------------------------------------------------------------
        ' Method                : CheckForMultipleLogins
        ' Requirement Tag       : For WAF_PREVENT_MULTIPLE_LOGINS
        ' Description           : This method will insert the entry when a a user loggs in for the first time.
        '                         It will return true if the feture WAF_PREVENT_MULTIPLE_LOGINS is enabled And
        '                         the ushraser is trying to log in again, even when he has already logged in.
        '                         Else it will return false.
        ' Parameters Passed     : strUserLoginID As String - User's Login Id.
        ' Returns               : -
        ' Parameters Affected   : -
        ' Assumptions           : -
        ' Dependencies          : -
        ' Author                : PushkarK
        ' Created On            : 15-May-2008
        ' Revisions             : 
        '-------------------------------------------------------------------------------------------------------------
        Dim strLoginIdForAdmin As String
        Dim strActiveUserSessionValue As String = ""
        Dim blnUseActiveUserSessionCache As Boolean = False
        Dim blnReturnValue As Boolean = False
        blnUseActiveUserSessionCache = CommonFunctions.General.GetFrameworkSettings("WAF_PREVENT_MULTIPLE_LOGINS", "Enabled")
        'Check if Framework Key is enabled for the feature to prevent multiple logins or not.
        ''Commented By Vidya J
        ' ''Commented And Added By Vaijat K ON 11/06/2016 For Prevent Multiple Login
        If Session("uniqueSessionID") Is Nothing Then
            ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: Multiple Login validate
            ''Session("uniqueSessionID") = Session.SessionID
            Session("uniqueSessionID") = Session("SessionID")
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If
        ''END of Commented And Added By Vaijat K ON 11/06/2016 For Prevent Multiple Login

        'Check if Framework Key is enabled for the feature to prevent multiple logins or not.
        If blnUseActiveUserSessionCache = True Then
            ''Commented By Vidya J
            ' ''Commented And Added By Vaijat K ON 11/06/2016 For Prevent Multiple Login
            If Session("SessionID") Is Nothing Then
                Dim Manager As SessionIDManager = New SessionIDManager()
                Session("SessionID") = Manager.CreateSessionID(Context)
            End If
            ' ''End Commented And Added By Vaijat K ON 11/06/2016 For Prevent Multiple Login


            'Check whether there exist a cache entry for the logged in user or not.
            strActiveUserSessionValue = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItem(strUserLoginID)
            If strActiveUserSessionValue <> "" Then
                'If yes, then
                '1) the user has already logged in with valid session.
                '2) Or he might not have logged out using "Log Out" link. (Improper log out).
                'In either case he will have to wait for session to end or ask ADMIN to kill his session.
                'Modified by swapnil aswale on 1 dec 2015
                ' CommonEngines.HashTables.CreateHashTables.InsertUserSessionCacheItem(strUserLoginID + "-" + strUserLoginName, Session.SessionID)
                blnReturnValue = False 'Do not allow user to login
                ''Ended
            Else
                'Add into cahce for Logged in user : so use UserSessionCache
                'Now the Key passed will be LoginID-LoginName e.g. for ADMIN, it will be 139-ADMIN
                'It will be parsed in UserSessionCache to get the LoginID.
                'The Active Session Cache will be used for Administration-Page, where we need LoginName as well.
                'CommonEngines.HashTables.CreateHashTables.InsertUserSessionCacheItem(strUserLoginID + "-" + strUserLoginName, Session.SessionID)
                ''Commented By Vidya J
                CommonEngines.HashTables.CreateHashTables.InsertUserSessionCacheItem(strUserLoginID + "-" + strUserLoginName, Session("SessionID"))
                blnReturnValue = False 'Allow user to login
            End If

            'Handle Special Case for Admin
            strLoginIdForAdmin = CommonFunctions.Application.AllowedLoginIDForMultipleLogOns.ToString
            If strLoginIdForAdmin = strUserLoginID Then
                blnReturnValue = False 'Allow Admin user to login
            End If

        Else
            blnReturnValue = False 'Allow user to login
        End If

        Return blnReturnValue
    End Function
    'Private Function CheckForMultipleLogins(ByVal strUserLoginID As String, ByVal strUserLoginName As String) As Boolean
    '    '-------------------------------------------------------------------------------------------------------------
    '    ' Method                : CheckForMultipleLogins
    '    ' Requirement Tag       : For WAF_PREVENT_MULTIPLE_LOGINS
    '    ' Description           : This method will insert the entry when a a user loggs in for the first time.
    '    '                         It will return true if the feture WAF_PREVENT_MULTIPLE_LOGINS is enabled And
    '    '                         the ushraser is trying to log in again, even when he has already logged in.
    '    '                         Else it will return false.
    '    ' Parameters Passed     : strUserLoginID As String - User's Login Id.
    '    ' Returns               : -
    '    ' Parameters Affected   : -
    '    ' Assumptions           : -
    '    ' Dependencies          : -
    '    ' Author                : PushkarK
    '    ' Created On            : 15-May-2008
    '    ' Revisions             : 
    '    '-------------------------------------------------------------------------------------------------------------
    '    Dim strLoginIdForAdmin As String
    '    Dim strActiveUserSessionValue As String = ""
    '    Dim blnUseActiveUserSessionCache As Boolean = False
    '    Dim blnReturnValue As Boolean = False
    '    blnUseActiveUserSessionCache = CommonFunctions.General.GetFrameworkSettings("WAF_PREVENT_MULTIPLE_LOGINS", "Enabled")
    '    'Check if Framework Key is enabled for the feature to prevent multiple logins or not.
    '    If blnUseActiveUserSessionCache = True Then

    '        'Check whether there exist a cache entry for the logged in user or not.
    '        strActiveUserSessionValue = CommonEngines.HashTables.GetHashTableObject.GetUserSessionCacheItem(strUserLoginID)
    '        If strActiveUserSessionValue <> "" Then
    '            'If yes, then
    '            '1) the user has already logged in with valid session.
    '            '2) Or he might not have logged out using "Log Out" link. (Improper log out).
    '            'In either case he will have to wait for session to end or ask ADMIN to kill his session.
    '            'Modified by swapnil aswale on 1 dec 2015
    '            ' CommonEngines.HashTables.CreateHashTables.InsertUserSessionCacheItem(strUserLoginID + "-" + strUserLoginName, Session.SessionID)
    '            blnReturnValue = False 'Do not allow user to login
    '            ''Ended
    '        Else
    '            'Add into cahce for Logged in user : so use UserSessionCache
    '            'Now the Key passed will be LoginID-LoginName e.g. for ADMIN, it will be 139-ADMIN
    '            'It will be parsed in UserSessionCache to get the LoginID.
    '            'The Active Session Cache will be used for Administration-Page, where we need LoginName as well.
    '            CommonEngines.HashTables.CreateHashTables.InsertUserSessionCacheItem(strUserLoginID + "-" + strUserLoginName, Session.SessionID)
    '            blnReturnValue = False 'Allow user to login
    '        End If

    '        'Handle Special Case for Admin
    '        strLoginIdForAdmin = CommonFunctions.Application.AllowedLoginIDForMultipleLogOns.ToString
    '        If strLoginIdForAdmin = strUserLoginID Then
    '            blnReturnValue = False 'Allow Admin user to login
    '        End If

    '    Else
    '        blnReturnValue = False 'Allow user to login
    '    End If

    '    Return blnReturnValue
    'End Function

    'Modified By AshwiniM on 09-APR-2013 for LDAP Issue
    Sub ValidatePBNLogin(ByVal intHowToValidate As Integer, ByVal strLogin As String, ByVal strPassword As String)
        'Sub ValidatePBNLogin(ByVal intHowToValidate As Integer, ByVal strLogin As String, ByVal strPassword As String, Optional ByVal intFlag As Integer = 0)
        '=====================================================================
        ' Procedure Name		:	ValidatePBNLogin
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	Validate the Project By Netlogin
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	
        ' Author				:	AshishR
        ' Created				:	4 May 2002
        ' Revisions				:	4 May 2002
        '=====================================================================


        Dim drValidateLogin As IDataReader
        Dim strSQLQuery As String

        'Added By PushkarK On 15-May-2008 for WAF_PREVENT_Musp_ValidateLoginULTIPLE_LOGINS
        Dim strUserLoginID As String = ""
        Dim blnRedirectDueToMultipleLogins As Boolean = False
        'Addition Ends By PushkarK On 15-May-2008 for WAF_PREVENT_MULTIPLE_LOGINS

        Select Case intHowToValidate

            Case 0 'PBN Validation

                'Modified by MrugajaB for Whiziblesem SP7 on 17th Aug 2006
                'Purpose:When LoginName consists of single quote character ,page crashes
                'Constructing the SQL Query
                strSQLQuery = "EXEC usp_ValidateLogin '" & CommonFunction.General.BuildQueryString(strLogin) & "','" & Trim(strPassword) & "'"
                strSQLQuery = strSQLQuery.Replace("''", "'")
                'End Modification
                'Get the specific controls in the Page 
                drValidateLogin = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If Not drValidateLogin.Read Then

                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                    CommonFunction.Data.DisposeDataReader(drValidateLogin)

                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                    ' Modified by RajaniR on Thursday, May 22, 2003 17:17.
                    RedirectToDefaultPage("Message=InvalidLogin" & strQSParameters)
                    'Response.Redirect("../../Default.aspx?Message=InvalidLogin" & strQSParameters)
                    ' End Modification.
                    'Added by NikitaD
                    'intFlag = 0
                    'Added by NikitaD
                End If

                ' Added By Nikhil Mane on 28th April 2026 to handle password change on MultiBrowser issue
                Dim strStamp As String = ""
                Dim objStamp As Object = drValidateLogin("SecurityStamp")

                If objStamp IsNot Nothing AndAlso Not IsDBNull(objStamp) Then
                    strStamp = objStamp.ToString()  ' Safely converts Guid ? String e.g. "8A2012E3-624B-4433-AB4C-2D5CC5809D29"
                End If

                ' If somehow empty, generate a safe temporary one
                If strStamp = "" Then
                    strStamp = Guid.NewGuid().ToString()
                End If

                Session("SecurityStamp") = strStamp

                'End Of Added By Nikhil Mane on 28th April 2026 to handle password change on MultiBrowser issue

                'Added By PushkarK On 15-May-2008 for WAF_PREVENT_MULTIPLE_LOGINS
                strUserLoginID = drValidateLogin("LoginID").ToString
                blnRedirectDueToMultipleLogins = CheckForMultipleLogins(strUserLoginID, strLogin)
                If blnRedirectDueToMultipleLogins = True Then
                    'Dispose the DataReader Object
                    drValidateLogin.Dispose() : drValidateLogin = Nothing
                    'Redirect him to Default.aspx page
                    RedirectToDefaultPage("Message=ALREADY_LOGGEDIN" & strQSParameters)
                End If
                'Addition Ends By PushkarK On 15-May-2008 for WAF_PREVENT_MULTIPLE_LOGINS

                If CType(drValidateLogin("LoginType"), String) = "E" Then
                    Session("intUserID") = drValidateLogin("EmployeeID")
                    Session("intPostID") = drValidateLogin("RoleID")
                    Session("strUserName") = drValidateLogin("UserName")
                    Session("LoginType") = "E"
                    Session("IsCreatedByCustomer") = False
                    Session("intLoginID") = drValidateLogin("LoginID")


                    'Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                    'Commented By Amit Mahadik on 0-Mar-2013
                    'Session("strEmpName") = drValidateLogin("DispalyName")
                    'End Commented By Amit Mahadik on 0-Mar-2013
                    'ENd Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011

                Else
                    Session("intUserID") = drValidateLogin("CustomerID")
                    Session("intPostID") = drValidateLogin("RoleID")
                    'Replace customer name with login name for customer login
                    'modified by ashishr 17 sep 2001
                    Session("strUserName") = drValidateLogin("CustomerName")
                    ''end
                    Session("LoginType") = "C"
                    Session("intLoginID") = drValidateLogin("LoginID")
                    If CType(drValidateLogin("IsCreatedByCustomer"), Boolean) = True Then
                        Session("IsCreatedByCustomer") = True
                        Session("CustomerCreatedLoginID") = drValidateLogin("LoginID")
                    Else
                        Session("IsCreatedByCustomer") = False
                    End If
                    'Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                    'Commented By Amit Mahadik on 0-Mar-2013
                    'Session("strEmpName") = drValidateLogin("DispalyName")
                    'End Commented By Amit Mahadik on 0-Mar-2013
                    'ENd Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                End If
                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                CommonFunction.Data.DisposeDataReader(drValidateLogin)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
            Case 1 'LDAP Validation

                'Modified by MrugajaB for Whiziblesem SP7 on 17th Aug 2006
                'Purpose:When LoginName consists of single quote character ,page crashes
                'modifed by purvaj on 30 jun 2009 8.1 issue fixes.
                '"CommonFunction.General.BuildQueryString" removed from strLogin as getformvalue adjusts the single quote.
                '" due to this 'was getting appended multiple times. hence user was not able to login if login name contains single quote

                drValidateLogin = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & strLogin & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'End Modification



                If drValidateLogin.Read Then

                    'Added By PushkarK On 15-May-2008 for WAF_PREVENT_MULTIPLE_LOGINS

                    strUserLoginID = drValidateLogin("LoginID").ToString
                    blnRedirectDueToMultipleLogins = CheckForMultipleLogins(strUserLoginID, strLogin)
                    If blnRedirectDueToMultipleLogins = True Then
                        'Dispose the DataReader Object
                        drValidateLogin.Dispose() : drValidateLogin = Nothing
                        'Redirect him to Default.aspx page
                        RedirectToDefaultPage("Message=ALREADY_LOGGEDIN" & strQSParameters)
                    End If
                    'Addition Ends By PushkarK On 15-May-2008 for WAF_PREVENT_MULTIPLE_LOGINS


                    ''If Login Is Employee
                    If CType(drValidateLogin("LoginType"), String) = "E" Then
                        Session("intUserID") = drValidateLogin("EmployeeID")
                        Session("intPostID") = drValidateLogin("RoleID")
                        Session("strUserName") = drValidateLogin("UserName")
                        Session("LoginType") = "E"
                        Session("IsCreatedByCustomer") = False
                        Session("intLoginID") = drValidateLogin("LoginID")
                        'Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                        'Commented By Amit Mahadik on 0-Mar-2013
                        'Session("strEmpName") = drValidateLogin("DispalyName")
                        'End Commented By Amit Mahadik on 0-Mar-2013
                        'ENd Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                    Else
                        Session("intUserID") = drValidateLogin("CustomerID")
                        Session("intPostID") = drValidateLogin("RoleID")
                        'Replace customer name with login name for customer login
                        'modified by ashishr 17 sep 2001
                        Session("strUserName") = drValidateLogin("CustomerName")
                        ''end
                        Session("LoginType") = "C"
                        Session("intLoginID") = drValidateLogin("LoginID")
                        If CType(drValidateLogin("IsCreatedByCustomer"), Boolean) = True Then
                            Session("IsCreatedByCustomer") = True
                            Session("CustomerCreatedLoginID") = drValidateLogin("LoginID")
                        Else
                            Session("IsCreatedByCustomer") = False
                        End If
                        'Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                        'Commented By Amit Mahadik on 0-Mar-2013
                        'Session("strEmpName") = drValidateLogin("DispalyName")
                        'End Commented By Amit Mahadik on 0-Mar-2013
                        'ENd Added by NitinC For WhizibleSEM10.0 on 28 Sept 2011
                    End If
                Else
                    ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                    CommonFunction.Data.DisposeDataReader(drValidateLogin)

                    ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                    ' Modified by RajaniR on Thursday, May 22, 2003 17:17.
                    RedirectToDefaultPage("Message=PBNInvalidLogin" & strQSParameters)
                    'Response.Redirect("../../Default.aspx?Message=PBNInvalidLogin" & strQSParameters)
                    ' End Modification.
                    'Modified By AshwiniM on 09-APR-2013 for LDAP Issue
                    'intFlag = 1
                    'Modified By AshwiniM on 09-APR-2013 for LDAP Issue

                End If
                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                CommonFunction.Data.DisposeDataReader(drValidateLogin)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                '' createa a new GUID and save into the session
        End Select
        'Commented By Riddhesh Patil on 18 Nov 2024 to not to validate cookies
        'Dim guids As String = Guid.NewGuid().ToString
        'Session("AuthToken") = guids
        ''' now create a new cookie with this guid value


        'Response.Cookies.Add(New HttpCookie("AuthToken", guids))
        'Response.Cookies("AuthToken").HttpOnly = True
        'Response.Cookies("AuthToken").Secure = True
        'Response.Cookies("AuthToken").Path = "/; SameSite=Lax"

        'Response.Headers("Set-Cookie") &= "; SameSite=Strict"
        'End of Commented By Riddhesh Patil on 18 Nov 2024 to not to validate cookies

        'Return intFlag
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        ''close the object
        'If Not drValidateLogin.IsClosed Then
        '    drValidateLogin.Close()
        'End If

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
    End Sub
    Private Function VallidateLDAPLogin(ByVal strID As String, ByVal strPW As String) As Integer
        '=====================================================================
        ' Procedure Name		:	VallidateLDAPLogin
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	Validate the LDAP Sever login
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	LDAP Server
        ' Author				:	AshishR
        ' Created				:	4 May 2002
        ' Revisions				:	4 May 2002
        '=====================================================================
        ' ***********************************************************************************
        ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ***********************************************************************************
        If m_blnIsWindowsAuthenticated Then
            ' if the user is valid
            Return 1
        End If
        ' ***********************************************************************************
        ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ***********************************************************************************
        ''''Dim Objldap As LDAPAuthentication = New LDAPAuthentication("LDAP://" & strLDAPServer, strLogPath & strLogFileName)

        ''''Try
        ''''    'Validate the LDAP login
        ''''    Dim intResult As Integer = CInt(CType(Objldap.IsAuthenticated(Nothing, strID, strPW), Integer) + 2)
        ''''    Objldap = Nothing
        ''''    Return intResult

        ''''Catch ex As Exception
        ''''    Return 0
        ''''End Try
        Dim strLDAPServerList As String = CommonFunction.General.GetApplicationKeySetting("LDAPServerName").ToString
        Dim strLogFileName As String = CommonFunction.FileDirectory.GetLogFileName("LDAP").ToString
        Dim strLogPath As String = CommonFunction.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log"))
        'Code Modified  by NitinC on 17-Mar-2011 for WhizibleSEM version 10.0
        'Purpose : To support Multiple LDAP server and multiple Domain 
        Dim strDomain As String = CommonFunction.General.GetApplicationKeySetting("ValidDomains").ToString
        Dim strTempArray() As String
        Dim strLDAPArray() As String
        Dim intCtr As Integer = 0
        Dim intLDAPCtr As Integer = 0
        Dim intResult As Integer
        Dim strMessage As String = ""
        Dim strLDAPServer As String
        'Modified By AshwiniM on 10-APR-2013 for LDAP Issue
        '****************************************************************************************************************
        Dim drAuthenticationType As IDataReader
        Dim blnIsLDAPAuthentication As Boolean
        drAuthenticationType = CommonFunction.Data.GetDataReader("EXEC usp_Sel_UserAuthenticationType '" & strID & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drAuthenticationType.Read Then
            blnIsLDAPAuthentication = CType(drAuthenticationType("IsLDAPAuthentication"), Boolean)
            'IF Ldap authentcatin then
            If blnIsLDAPAuthentication = True Then
                '****************************************************************************************************************
                'End of Modified By AshwiniM on 10-APR-2013 for LDAP Issue

                If strLDAPServerList <> "" Then

                    'Instead of servername we are splitting domain name as LdapServerName is onlye one or SAME for 2 different domain.
                    strTempArray = Split(strDomain, "/")
                    strLDAPArray = Split(strLDAPServerList, "/")

                    For intLDAPCtr = 0 To strLDAPArray.Length - 1
                        strLDAPServer = strLDAPArray(intLDAPCtr)
                        For intCtr = 0 To strTempArray.Length - 1
                            If strTempArray(intCtr).Trim <> "" Then
                                strMessage = ""
                                Dim Objldap As LDAPAuthentication = New LDAPAuthentication("LDAP://" & strLDAPServer, strLogPath & strLogFileName)

                                Try
                                    'Validate the LDAP login
                                    'In below stmt domain name replaced with appropriate 'DomainName' instead of 'NOTHING' by AratiS on 25-May-2010
                                    intResult = CInt(CType(Objldap.IsAuthenticated(strTempArray(intCtr).Trim, strID, strPW), Integer) + 2)
                                    Objldap = Nothing
                                    'Return intResult
                                Catch ex As Exception

                                    strMessage = strMessage + " Error message : "
                                    strMessage = strMessage + ex.Message.ToString

                                    'Return 0
                                    intResult = 0

                                Finally
                                    strMessage = strMessage + " LdapServerName : " + strLDAPServer.ToString + vbCrLf
                                    strMessage = strMessage + " DomainName : " + strTempArray(intCtr).Trim.ToString + vbCrLf
                                    strMessage = strMessage + " UserName : " + strID + vbCrLf
                                    strMessage = strMessage + " Result : " + intResult.ToString + vbCrLf
                                    CommonFunctions.FileDirectory.WriteFileStream(strLogPath, strLogFileName, strMessage)

                                End Try
                            End If
                            'Modified by Amit Mahadik on 20-Mar-2013 for LDAP Issue
                            'If intResult <> 0 Then
                            If intResult = 1 Then
                                'End Modified by Amit Mahadik on 20-Mar-2013 for LDAP Issue
                                Return intResult
                            End If
                        Next
                    Next
                    If intResult = 0 Then
                        Return intResult
                    End If

                End If
                'End of Code Modified  by NitinC on 17-Mar-2011 for WhizibleSEM version 10.0


                'Modified By AshwiniM on 10-APR-2013 for LDAP Issue
                '****************************************************************************************************************
            Else
                intResult = 0
                Return intResult
            End If
        End If
        '****************************************************************************************************************
        'End of Modified By AshwiniM on 10-APR-2013 for LDAP Issue

    End Function
    '' ''    '   'Commented and Added by NitinC on 17-Mar-2011 for WhizibleSEM version 10.0
    Private Sub ValidateMixedLogin(ByVal strUserID As String, ByVal strPassword As String, ByVal strOrgPassword As String)
        '=====================================================================
        ' Procedure Name		:	ValidateMixedLogin
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	Validate the LDAP Sever login or PBN Login
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	LDAP Server
        ' Author				:	AshishR
        ' Created				:	23 Jan 2003
        ' Revisions				:	23 Jan 2003
        '=====================================================================
        Dim drAuthenticationType As IDataReader
        Dim blnIsLDAPAuthentication As Boolean
        Dim intFlg As Integer

        drAuthenticationType = CommonFunction.Data.GetDataReader("EXEC usp_Sel_UserAuthenticationType '" & strUserID & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drAuthenticationType.Read Then

            blnIsLDAPAuthentication = CType(drAuthenticationType("IsLDAPAuthentication"), Boolean)

            'IF Ldap authentcatin then
            If blnIsLDAPAuthentication = True Then

                'IF LDAP Authentication works	

                'Commented By AshwiniM on 09-April-2013 for LDAP Issue
                'If CLng(VallidateLDAPLogin(strLogin, strOrgPassword)) = 1 Then
                '    Call ValidatePBNLogin(1, strLogin, strPassword)
                'Call ValidatePBNLogin(1, strLogin, strPassword, intFlg)
                'If intFlg = 1 Then

                If CLng(VallidateLDAPLogin(strLogin, strOrgPassword)) <> 1 Then
                    'Commented and added by dhanashri s ON:19 MAR 2014 Purpose:ldap authontication
                    'Response.Clear()
                    'RedirectToDefaultPage("Message=LDAPInvalidLogin" & strQSParameters)
                    If m_blnIsWindowsAuthenticated Then
                        ' if the user is valid
                        Call ValidatePBNLogin(1, strLogin, strPassword)
                    Else
                        Call ValidatePBNLogin(0, strLogin, strPassword)
                    End If
                    'Call ValidatePBNLogin(1, strLogin, strPassword)
                    'End of Commented and added by dhanashri s ON:19 MAR 2014 Purpose:ldap authontication
                    'RedirectToDefaultPage("Message=LDAPInvalidLogin")
                Else
                    Call ValidatePBNLogin(1, strLogin, strPassword)
                End If
                ''Added by swapnil aswale on 5th Feb 2016 for [Mixed mode password is not validated]
                'If CLng(VallidateLDAPLogin(strLogin, strOrgPassword)) = 1 Then
                '    If m_blnIsWindowsAuthenticated Then
                '        ' if the user is valid
                '        Call ValidatePBNLogin(1, strLogin, strPassword)
                '    Else
                '        Call ValidatePBNLogin(0, strLogin, strPassword)
                '    End If
                '    'Call ValidatePBNLogin(1, strLogin, strPassword)
                'Else 'If LDAP authentication fails
                '    Response.Clear()
                '    ' Modified by RajaniR on Thursday, May 22, 2003 17:17.
                '    RedirectToDefaultPage("Message=LDAPInvalidLogin" & strQSParameters)
                '    'Response.Redirect("../../Default.aspx?Message=LDAPInvalidLogin" & strQSParameters)
                '    ' End Modification.
                'End If
                ''Ended

                'Else 'If LDAP authentication fails

                '    Response.Clear()
                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
                'End of Commented By AshwiniM on 09-April-2013 for LDAP Issue
                CommonFunction.Data.DisposeDataReader(drAuthenticationType)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                'Added by NitinC on 17 March 2011 for WhizibleSEM version 10.0
                'Call ValidatePBNLogin(0, strLogin, strPassword)
                'End of Added by NitinC on 17 March 2011 for WhizibleSEM version 10.0 

                'Commented by NitinC on 17 March 2011 for WhizibleSEM version 10.0
                '' Modified by RajaniR on Thursday, May 22, 2003 17:17.
                'RedirectToDefaultPage("Message=LDAPInvalidLogin" & strQSParameters)
                ''Response.Redirect("../../Default.aspx?Message=LDAPInvalidLogin" & strQSParameters)
                '' End Modification.
                'End of Commented by NitinC on 17 March 2011 for WhizibleSEM version 10.0 
                'End If

            Else 'PBN Authentication
                ' ***********************************************************************************
                ' Added/Modified Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
                ' ************               
                If m_blnIsWindowsAuthenticated Then
                    ' if the user is valid
                    Call ValidatePBNLogin(1, strLogin, strPassword)
                Else
                    Call ValidatePBNLogin(0, strLogin, strPassword)
                End If
                ' ***********************************************************************************
                ' End Addition/Modification Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
                ' ***********************************************************************************
            End If

        Else
            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

            CommonFunction.Data.DisposeDataReader(drAuthenticationType)

            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

            Response.Clear()
            RedirectToDefaultPage("Message=InvalidLogin" & strQSParameters)
            'Response.Redirect("../../Default.aspx?Message=InvalidLogin" & strQSParameters)

        End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        CommonFunction.Data.DisposeDataReader(drAuthenticationType)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
    End Sub

    Private Sub SetDefaultModuleAndProject()
        '=====================================================================
        ' Procedure Name		:	SetDefaultModuleAndProject
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To set the default user module/role module and default project
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	22 Apr 2002
        ' Revisions				:	22 APr 2002
        '=====================================================================


        Dim drDefaultModuleProject As IDataReader

        ' Added by RajaniR on Friday, May 16, 2003 16:45.
        Dim strSQLQuery As String

        ' If any specific URL has been requested, then...
        If Request.QueryString("ID") <> "" Then

            ' Get the details of the URL request.
            strSQLQuery = "usp_Sel_tbl_PM_URLRequests " & Request.QueryString("ID")
            drDefaultModuleProject = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drDefaultModuleProject.Read Then

                ' Check if the selected project and module are accessible to the user.
                ' Only if the project and module is accessible to the user, will the request be entertained. 
                ' Else, normal login process follows...
                If IsProjectAccessible(CType(drDefaultModuleProject("ProjectID"), Long)) Then

                    If IsModuleAccessible(CType(drDefaultModuleProject("DefaultModule"), String), CType(drDefaultModuleProject("ProjectID"), Long)) Then
                        ' Set the session Project ID.			
                        Session("intProjectID") = drDefaultModuleProject("ProjectID")
                        Session("strProjectName") = drDefaultModuleProject("ProjectName")

                        ' Set the session Module Name.			
                        Session("strActiveModule") = drDefaultModuleProject("DefaultModule")
                        strFromWhere = CType(Session("strActiveModule"), String)

                        ' Set the URL to be opened by default.			
                        Session("strURLRequested") = drDefaultModuleProject("URLRequested")

                    End If

                End If

            End If
            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
            'drDefaultModuleProject.Close()
            CommonFunction.Data.DisposeDataReader(drDefaultModuleProject)

            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 



        End If
        'Commented and added below by SavitaS on 21 Aug 2006 for SP7 Integration (Flexcel IssueID 2369)
        'drDefaultModuleProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_DefaultTabProject " & CType(Session("intLoginID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'End of Commented bySavitaS on 21 Aug 2006 for SP7 Integration (Flexcel IssueID 2369)
        ' End Modification.
        'Added by SavitaS on 22 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
        If ((CommonFunction.Application.ShowSetAsDefaultLink = True And CType(Session("LoginType"), String) = "C") Or (CType(Session("LoginType"), String) = "E")) Then
        Else
            If Not (Session("intUserID") Is Nothing Or Session("LoginType") Is Nothing) Then
                Dim strUserID As String = Session("intUserID").ToString
                Dim strLoginType As String = Session("LoginType").ToString
                Dim strSQL As String
                strSQL = "usp_Del_tbl_PM_DefaultTabProject " + strUserID + ", '" + strLoginType + "'"
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
        End If
        'Addition Ends by SavitaS

        'Added by SavitaS on 21 Aug 2006 for SP7 Integration (Flexcel IssueID 2369)
        drDefaultModuleProject = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_DefaultTabProject " & CType(Session("intLoginID"), Long), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'End of Added by SavitaS on 21 Aug 2006 for SP7 Integration (Flexcel IssueID 2369)
        If drDefaultModuleProject.Read Then

            If CType(drDefaultModuleProject("DefaultProject"), Long) <> 0 Then
                'If Session Project ID is not set then only set the project id
                If Session("intProjectID") Is Nothing Then
                    ''Added By AshishR to validate the project access
                    If IsProjectAccessible(CType(drDefaultModuleProject("DefaultProject"), Long)) Then
                        'Added by SavitaS on 22 June 2006 for Flexcel IssueID 2369 (Unable view Set default Link in customer login)
                        If ((CommonFunction.Application.ShowSetAsDefaultLink = True And CType(Session("LoginType"), String) = "C") Or (CType(Session("LoginType"), String) = "E")) Then
                            'Addition Ends by SavitaS
                            Session("intProjectID") = drDefaultModuleProject("DefaultProject")
                            Session("strProjectName") = drDefaultModuleProject("ProjectName")
                        End If
                    End If
                    ''End 
                End If

            End If
            'apply project level role	
            If CType(drDefaultModuleProject("ProjectRole"), Long) <> 0 Then
                Session("intPostID") = drDefaultModuleProject("ProjectRole")
            End If
            'if active module is not set then only set the active module		
            If CType(Session("strActiveModule"), String) = "" Then
                ''Added By AshishR to validate the module access
                If IsModuleAccessible(CType(drDefaultModuleProject("DefaultModule"), String), CType(Session("intProjectID"), Long)) Then
                    Session("strActiveModule") = Trim(CType(drDefaultModuleProject("DefaultModule"), String) & "")
                    strFromWhere = Trim(CType(drDefaultModuleProject("DefaultModule"), String) & "")
                    'Added By VarunA on 10-June-2008 RequestID-13756
                    'Purpose : To have default module when that role is not accessible to module (which is set at the time of Project Selected)
                Else
                    strDefaultModule = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_GetDefaultModuleNotAccessible " + CType(HttpContext.Current.Session("intPostID"), String), True), "0"), String)
                    Session("strActiveModule") = Trim(strDefaultModule & "")
                    strFromWhere = Trim(strDefaultModule & "")
                End If
                'End By VarunA on 10-June-2008 RequestID-13756
            End If

        End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
        'destroy the object
        'drDefaultModuleProject.Close()
        CommonFunction.Data.DisposeDataReader(drDefaultModuleProject)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
    End Sub

    Private Function IsProjectAccessible(ByVal intProjectID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        :	IsProjectAccessible
        ' Purpose               :	To check whether the project is accessible to the user. 
        ' Description           :	Same as above.
        ' Parameters Passed     :	intProjectID	:- The Project ID.
        ' Parameters Affected   :	None.
        ' Returns               :	True  :- If the user has access to the project.
        '							False :- If the user does not have access to the project.
        ' Assumptions           :	Same as above.
        ' Dependencies          :	None.
        ' Author                :	AshishR
        ' Created               :	Friday, July 24, 2003 17:56 
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery As String
        Dim drAccess As IDataReader

        IsProjectAccessible = False

        If Trim(intProjectID & "") <> "" Then

            ' Check if the user has access to the project specified.	
            strSQLQuery = "DECLARE @Accessible bit" & vbCrLf
            strSQLQuery = strSQLQuery & "Exec usp_Sel_tbl_PM_Employee_IsProjectAccessible " & CType(Session("intLoginID"), Long) & ", " & intProjectID & ", @Accessible OUTPUT" & vbCrLf
            strSQLQuery = strSQLQuery & "SELECT 'Accessible' = @Accessible" & vbCrLf
            drAccess = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drAccess.Read Then
                IsProjectAccessible = CType(drAccess("Accessible"), Boolean)
            End If
            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

            'drAccess.Close()
            CommonFunction.Data.DisposeDataReader(drAccess)

            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
        End If

    End Function
    Private Function IsModuleAccessible(ByVal strModuleName As String, ByVal intProjectID As Long) As Boolean
        '=====================================================================
        ' Procedure Name        :	IsModuleAccessible
        ' Purpose               :	To check whether the module is accessible to the user. 
        ' Description           :	Same as above.
        ' Parameters Passed     :	strModuleName	:- The Module Name.
        '							intProjectID	:- The Project ID.
        ' Parameters Affected   :	None.
        ' Returns               :	True  :- If the user has access to the module.
        '							False :- If the user does not have access to the module.
        ' Assumptions           :	Same as above.
        ' Dependencies          :	None.
        ' Author                :	AshishR
        ' Created               :	Thursday, May 22, 2003 17:06
        ' Revisions             :
        '=====================================================================

        Dim strSQLQuery As String
        Dim drAccess As IDataReader

        IsModuleAccessible = False

        If Trim(strModuleName & "") <> "" Then

            ' Check if the user has access to the module specified.	
            strSQLQuery = "DECLARE @Accessible bit" & vbCrLf
            strSQLQuery = strSQLQuery & "Exec usp_Sel_tbl_PM_Employee_IsModuleAccessible " & CType(Session("intLoginID"), Long) & ", '" & CommonFunction.General.BuildQueryString(strModuleName) & "' "
            If Trim(intProjectID & "") <> "" Then
                strSQLQuery = strSQLQuery & ", " & intProjectID
            Else
                strSQLQuery = strSQLQuery & ", NULL"
            End If
            strSQLQuery = strSQLQuery & ", @Accessible OUTPUT" & vbCrLf
            strSQLQuery = strSQLQuery & "SELECT 'Accessible' = @Accessible" & vbCrLf
            drAccess = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drAccess.Read Then
                IsModuleAccessible = CType(drAccess("Accessible"), Boolean)
            End If

            ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

            'drAccess.Close()
            CommonFunction.Data.DisposeDataReader(drAccess)

            ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 
        End If

    End Function
    Private Function GetRoleDesc() As String
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
        Dim drEmployeeCode As IDataReader
        Dim strSQL As String
        Dim strSQLEmployeeCode As String

        ''Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''strSQL = "Select RoleDescription FROM tbl_PM_Role WHERE RoleID=" & CType(Session("intPostID"), Long)
        strSQL = "usp_sel_tbl_PM_Role_RoleDescription " & CType(Session("intPostID"), Long)
        ''end of Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        ''strSQLEmployeeCode = "Select EmployeeCode FROM tbl_PM_Employee WHERE EmployeeID=" & CType(Session("intUserID"), Long)
        strSQLEmployeeCode = "usp_sel_tbl_PM_Employee_EmployeeCode " & CType(Session("intUserID"), Long)
        '  strSQL = strSQL & " AND EmployeeID=" & CType(Session("intUserID"), Long) & ")"
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        drRoleName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drRoleName.Read Then
            GetRoleDesc = CType(drRoleName("RoleDescription"), String) & ""
        End If

        drEmployeeCode = CommonFunction.Data.GetDataReader(strSQLEmployeeCode, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drEmployeeCode.Read Then
            Session("EmployeeCode") = CType(drEmployeeCode("EmployeeCode"), String) & ""
        End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        'drRoleName.Close()
        CommonFunction.Data.DisposeDataReader(drRoleName)
        CommonFunction.Data.DisposeDataReader(drEmployeeCode)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

    End Function
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

        ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        'strSQL = "Select RoleDescription FROM tbl_PM_Role WHERE RoleID=(SELECT TOP 1 Role FROM tbl_PM_ProjectEmployeeRole WHERE ProjectID=" & CType(Session("intProjectID"), Long)
        'strSQL = strSQL & " AND EmployeeID=" & CType(Session("intUserID"), Long) & ")"
        strSQL = "usp_sel_RoleDescription_tbl_PM_Role " & CType(Session("intProjectID"), Long) & "," & CType(Session("intUserID"), Long)
        ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
        drRoleName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drRoleName.Read Then
            GetRole = CType(drRoleName("RoleDescription"), String) & ""
        End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        'drRoleName.Close()
        CommonFunction.Data.DisposeDataReader(drRoleName)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

    End Function
    Private Sub ApplyRoleLevel()
        '=====================================================================
        ' Procedure Name		:	ApplyRoleLevel
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To set the role level in session
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	25 July 2003
        ' Revisions				:	
        '=====================================================================
        Dim drRole As IDataReader

        drRole = CommonFunction.Data.GetDataReader("EXEC usp_Sel_EmployeeRoleLevel " & CType(Session("intUserID"), Long) & ",'" & Session("LoginType").ToString & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drRole.Read Then
            Session("intRoleLevel") = drRole(0)
        Else 'Assing the default role 3 LOW LVEL
            Session("intRoleLevel") = 3
        End If
        ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

        'drRole.Close()
        CommonFunction.Data.DisposeDataReader(drRole)

        ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 


    End Sub

    Private Sub GetSelectedModuleDetails(ByVal strlFromWhere As String)
        '=====================================================================
        ' Procedure Name		:	GetSelectedModuleDetails
        ' Parameters Passed		:	strFromWhere
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To get the module details
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	
        ' Author				:	AshishR
        ' Created				:	30 Aug 2003
        ' Revisions				:	
        '=====================================================================
        ' ***********************************************************************************
        ' Code Modified Nov 06, 2004 RajeshB  R.No:WAF2_PB_46
        ' ***********************************************************************************
        'check the application settings for default navigation support
        Dim objFrameworkSetting As CommonEngines.HashTables.FrameWorkSettings

        'Added BY NileshD on 14 Oct 2005 REQID- WAF3_PB_8
        Dim strHashtableKey As String
        Dim strPath As String = System.AppDomain.CurrentDomain.BaseDirectory
        strPath = strPath.Replace("/", "\")
        'End of Addition BY NileshD on 14 Oct 2005 REQID- WAF3_PB_8

        '-------------------------------------------------------------------------------------------------------------
        'Added By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
        'Reason   - For Navigation Header Height.
        '-------------------------------------------------------------------------------------------------------------
        If CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_TABNAVIGATION", "Enabled") = True Then
            m_sngNavigationFrameHeight = 38
        Else
            m_sngNavigationFrameHeight = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Application.NavigationFrameHeight, "38"), Single)
        End If
        '-------------------------------------------------------------------------------------------------------------
        'Addition Ends By - PushkarK On - Thursday, December 15, 2005 For Req.ID. - WAF3_GEN_1
        '-------------------------------------------------------------------------------------------------------------


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




        'If m_blnDefaultNavigation = False Then
        '    Call Links.resetRADMenu()
        '    Call Links.createRADMenu(Me, strSubPage)
        If m_MenuItem Is Nothing Then
            m_MenuItem = New EventMenuItem
            m_MenuItem.Label = "Start"
            m_MenuItem.Category = "Generated"
            m_MenuItem.ID = strFromWhere
            ' Links.SetActiveMenu(m_MenuItem)
        End If
        'End If

        'Modification Ends
        Dim blnShowTree As Boolean
        'create the object of system modules
        Dim objSystemModules As CommonEngines.HashTables.SystemModules

        'check for default culture id and current thread culture id
        If CType(MyBase.DefaultUILCID, Integer) = CType(Session("LCID"), Integer) Then
            objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", strFromWhere)
        Else
            objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules" + Session("LCID").ToString, strFromWhere)
            If objSystemModules Is Nothing Then
                objSystemModules = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObject("SystemModules", strFromWhere)
            End If
        End If

        'Added By ShraddhaM on 25,Jun 2008 
        'Purpose : To display Project Information page if project is present in session else display 
        ' Project(Listing)
        Dim Sql As String
        Dim drReader As IDataReader
        Dim IsActive As Boolean
        Dim indexofTagID As String
        Dim strlen As String

        If Not objSystemModules Is Nothing Then
            If strSubPage = "" Then
                'Modofied By ShraddhaM on 25,Jun 2008 
                'Purpose : To display Project Information page if project is present in session else display 
                ' Project(Listing)                
                If strlFromWhere.ToString.Trim = "PM" And HttpContext.Current.Session("LoginType").ToString <> "C" Then
                    If Session("intProjectID") Is Nothing Then
                        strSubPage = objSystemModules.SubPageName
                    Else
                        ''Added and commented by PrashantSJ on 12th June 2009 Purpose: to call new Home page
                        'Sql = "usp_Sel_tbl_CNF_GadgetNodes_EmployeePreferences 27," + Session("intUserID").ToString()
                        'drReader = CommonFunction.Data.GetDataReader(Sql, True)
                        'If drReader.Read Then
                        '    IsActive = CType(drReader("Active"), Boolean)
                        'End If
                        'If IsActive = True Then
                        '    strSubPage = "Tab_Viewpage.aspx?MasterTagID=27"
                        'Else
                        '    strSubPage = "CommonPage.aspx?MasterTagID=27"
                        'End If


                        strSubPage = "../Home/Home.aspx"
                        ''End of comment and addition by PrashantSJ on 12th June 2009
                    End If
                Else
                    strSubPage = objSystemModules.SubPageName
                End If
            Else
                If HttpContext.Current.Session("LoginType").ToString <> "C" Then

                    If strlFromWhere.ToString.Trim = "PM" Then
                        'Sql = "usp_Sel_tbl_CNF_GadgetNodes_EmployeePreferences 27," + HttpContext.Current.Session("intUserID").ToString()
                        'drReader = CommonFunction.Data.GetDataReader(Sql, True)
                        'If drReader.Read Then
                        '    IsActive = CType(drReader("Active"), Boolean)
                        'End If
                        'If IsActive = True Then
                        'Args.Href = "../Source/General/Tab_Viewpage.aspx?FromWhere=PM&FromTagID=27&FromWhere=PM&MasterTagId=" + Args.TagID.ToString
                        ''strSubPage = "Tab_Viewpage.aspx"
                        strSubPage = "../Home/Home.aspx"
                        'End If
                    End If

                End If
                strSubPage = strSubPage & "?" & Mid(CommonFunction.General.GetQuerySrtingValues.ToString, InStr(1, CommonFunction.General.GetQuerySrtingValues.ToString, "&ProjectID", CompareMethod.Text) + 1)

                'end of modification By ShraddhaM on 25,Jun 2008 

            End If
            intFrameWidth = CType(objSystemModules.FrameWidth, Integer)
            strTitle = objSystemModules.Title
            blnShowTree = objSystemModules.ShowTree
            strMainPage = objSystemModules.MainPageName

        End If
        objSystemModules = Nothing

        'Code modified By VidyaJ - Favorites
        If CommonFunction.General.CheckIsNothing(strTitle, "") = "" Then
            strTitle = ""
            strSubPage = ""
            strMainPage = ""
        End If

        If strTitle.Trim <> "" Then
            If Microsoft.VisualBasic.InStr(strTitle, "<USERNAME>", CompareMethod.Text) > 0 Then
                strTitle = strTitle.Replace("<USERNAME>", Session("strUserName").ToString)
            End If
        End If

        Select Case strlFromWhere.ToString.Trim

            Case "CRM"
                Dim drDefaultMode As IDataReader
                ' get the default mode for the user
                ' login type condition added by harshada d on 22 11 2005 
                drDefaultMode = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & CType(Session("intUserID"), Long) & ",'DefaultMode','" & CommonFunctions.General.BuildQueryString(CType(Session("LoginType"), String)) & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'drDefaultMode = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultSettings	" & CType(Session("intUserID"), Long) & ",'DefaultMode'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drDefaultMode.Read Then
                    strMode = drDefaultMode("ItemValue").ToString
                Else
                    strMode = "SR"
                End If

                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                'drDefaultMode.Close()
                CommonFunction.Data.DisposeDataReader(drDefaultMode)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                If CType(Session("LoginType"), String) = "C" Then
                    'Added and commented by PrashantSJ on 09 Nov 2006 for WhizibleSEM SP8 Build 1
                    'Purpose: When we set the default mode as 'My e-Dashboard'; when we click Help-Desk 
                    'it automatically goes to My e-Dashboard

                    ' Modified May 06 2003 Rajanikant
                    'If UCase(Trim(strMode & "")) = "DB" Then
                    '    strSubPage = "../CRM/CRM_Dashboard.aspx"
                    'Else
                    '    strSubPage = "../CRM/CRM_RequestList.aspx"
                    'End If
                    ''If UCase(Trim(strMode & "")) = "DB" Then
                    ''    strSubPage = "../CRM/CRM_Dashboard.aspx"
                    ''ElseIf UCase(Trim(strMode & "")) = "MD" Then
                    ''    strSubPage = "../CRM/CRM_MyDashboard.aspx"
                    ''Else
                    ''    strSubPage = "../CRM/CRM_RequestList.aspx"
                    ''End If
                    strSubPage = "../Home/Home.aspx?FromWhere=CRM"
                    '* Code modification Ends
                    'End of addition by PrashantSJ on 09 Nov 2006
                ElseIf CType(Session("LoginType"), String) = "E" And CType(Session("intPostID"), Long) <> CommonFunction.Constants.ROLE_CRM Then
                    'Added and commented by PrashantSJ on 09 Nov 2006 for WhizibleSEM SP8 Build 1
                    'Purpose: When we set the default mode as 'My e-Dashboard'; when we click Help-Desk 
                    'it automatically goes to My e-Dashboard
                    ' Modified May 06 2003 Rajanikant
                    'If UCase(Trim(strMode & "")) = "DB" Then
                    '    strSubPage = "../CRM/CRM_Dashboard.aspx"
                    'Else
                    '    strSubPage = "../CRM/CRM_RequestList.aspx"
                    'End If
                    '* Code modification Ends
                    ''If UCase(Trim(strMode & "")) = "DB" Then
                    ''    strSubPage = "../CRM/CRM_Dashboard.aspx"
                    ''ElseIf UCase(Trim(strMode & "")) = "MD" Then
                    ''    strSubPage = "../CRM/CRM_MyDashboard.aspx"
                    ''Else
                    ''    strSubPage = "../CRM/CRM_RequestList.aspx"
                    ''End If
                    strSubPage = "../Home/Home.aspx?FromWhere=CRM"
                    'End of addition by PrashantSJ on 09 Nov 2006
                ElseIf CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_CRM Then
                    'Added and commented by PrashantSJ on 09 Nov 2006 for WhizibleSEM SP8 Build 1
                    'Purpose: When we set the default mode as 'My e-Dashboard'; when we click Help-Desk 
                    'it automatically goes to My e-Dashboard
                    ' Modified May 06 2003 Rajanikant
                    'If UCase(Trim(strMode & "")) = "DB" Then
                    '    strSubPage = "../CRM/CRM_Dashboard.aspx"
                    'Else
                    '    strSubPage = "../CRM/CRM_RequestList.aspx"
                    'End If
                    '* Code modification Ends
                    ''If UCase(Trim(strMode & "")) = "DB" Then
                    ''    strSubPage = "../CRM/CRM_Dashboard.aspx"
                    ''ElseIf UCase(Trim(strMode & "")) = "MD" Then
                    ''    strSubPage = "../CRM/CRM_MyDashboard.aspx"
                    ''Else
                    ''    strSubPage = "../CRM/CRM_RequestList.aspx"
                    ''End If
                    strSubPage = "../Home/Home.aspx?FromWhere=CRM"
                    'End of addition by PrashantSJ on 09 Nov 2006
                End If
                strFromWhere = "CRM&Mode=" & strMode
                ' End Modification/Addition May 14,2003

            Case "DA"
                If CommonFunctions.Application.ShowPhaseTimesheet = True Then
                    strSubPage = "../PM/PM_PhaseWiseTimeSheet.aspx"
                Else
                    strSubPage = "../PM/PM_DailyActivity.aspx"
                End If
            Case "DB"
                Dim drRoleDB As IDataReader
                drRoleDB = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Role_DashBoard " & CType(Session("IntPostID"), Long) & "," & CType(Session("intUserID"), Long) & ",'" & Session("LoginType").ToString & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drRoleDB.Read Then
                    strSubPage = Trim(CType(drRoleDB("PageName"), String))
                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                    'Reason   - For Dashboard Deletion. 
                    '-------------------------------------------------------------------------------------------------------------
                    If CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_PROGRAMMER Then
                        strTitle = "Developer Dashboard"
                    ElseIf CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_CUSTOMER Then
                        strTitle = "Customer Dashboard"
                    ElseIf CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_PROJECT_MANAGER Then
                        strTitle = "Project Manager Dashboard"
                    Else
                        strTitle = "Home"
                    End If
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                    '-------------------------------------------------------------------------------------------------------------
                Else
                    'strSubPage = "Introduction.aspx"  'Commented By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                    'Reason   - For Dashboard Deletion. Dashboard ID = 0 will be sent through the Query string for displaying only 
                    '           combobox of available dashboards on "CDB/CDB_Main.aspx" page
                    '-------------------------------------------------------------------------------------------------------------
                    strSubPage = "../CDB/CDB_Main.aspx?DashboardID=0"
                    strTitle = "Dashboards"
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                    '-------------------------------------------------------------------------------------------------------------
                End If
                ' Modified by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 

                'Close the object
                'drRoleDB.Close()

                CommonFunction.Data.DisposeDataReader(drRoleDB)

                ' End Modification by NitinVS on 18 Aug 2005 for WhizibleSEM SP4 IssueID 122 


                '-------------------------------------------------------------------------------------------------------------
                'Commented By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                'Reason       - For Dashboard Deletion.
                '-------------------------------------------------------------------------------------------------------------

                'If CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_PROGRAMMER Then
                '    strTitle = "Developer Dashboard"
                'ElseIf CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_CUSTOMER Then
                '    strTitle = "Customer Dashboard"
                'ElseIf CType(Session("intPostID"), Long) = CommonFunction.Constants.ROLE_PROJECT_MANAGER Then
                '    strTitle = "Project Manager Dashboard"
                'Else
                '    strTitle = "Executive Dashboard"
                'End If

                '-------------------------------------------------------------------------------------------------------------
                'Comment Ends By - PushkarK On - Tuesday, November 28, 2006 For WAF3_CDB_22
                '-------------------------------------------------------------------------------------------------------------
                'Added by Dhanashri S on 10 Mar 2015
                'Case "SM"
                'If CType(Session("LoginType"), String) = "E" And CType(Session("intPostID"), Long) <> CommonFunction.Constants.ROLE_CRM Then
                'strSubPage = "../Home/Home.aspx?FromWhere=SM"
                'End If
                'End of addition
            Case Else
                If strSubPage.Trim = "" Then strSubPage = "Introduction.aspx"
                If m_blnDefaultNavigation = False Then
                    'Code Added:RajeshB     25th Nov, 2004
                    'Set Start Sub Page
                    If InStr(strSubPage, "FromWhere=") = 0 Then
                        If InStr(strSubPage, "?") > 0 Then
                            strSubPage = strSubPage & "&FromWhere=" & strFromWhere
                        Else
                            strSubPage = strSubPage & "?FromWhere=" & strFromWhere
                        End If
                    End If
                End If
                'Addition Ends
        End Select
        'Code modified By VidyaJ - Favorites
        If strFromWhere = "FV" Then
            blnShowTree = True
        End If

        If blnShowTree = True Then
            If strMainPage.Trim = "" Then
                '-------------------------------------------------------------------------------------------------------------
                'Added By - PushkarK On - Thursday, December 22, 2005 For Req.ID. - WAF3_GEN_2
                'Reason   - For Navigation Menu.
                '-------------------------------------------------------------------------------------------------------------
                m_blnEnableNavMenuPane = CommonFunctions.General.GetFrameworkSettings("GEN_ENABLE_NAVMENU_PANE", "Enabled")
                If m_blnEnableNavMenuPane = False Or strlFromWhere = "KM" Then
                    m_strScrollForNavPane = "yes"
                    '-------------------------------------------------------------------------------------------------------------
                    'Addition Ends By - PushkarK On - Thursday, December 22, 2005 For Req.ID. - WAF3_GEN_2 for Navigation Menu
                    '-------------------------------------------------------------------------------------------------------------

                    If strlFromWhere = "KM" Then

                        'If client browser is IE then generate the XML tree
                        If CommonFunction.General.IsClientBrowserIE = True Then
                            If CommonFunction.General.GetApplicationKeySetting("KMTreeType").ToUpper = "HTML" Then
                                Call CommonFunction.GenerateTree.GenerateHTMLTreeForKM()
                                If strMainPage = "" Then strMainPage = "../../Reports/KMTree" & CType(Session("intUserID"), Long) & ".html"
                            Else
                                Call CommonFunction.GenerateTree.subGenerateXMLTreeForKM()
                                If strMainPage = "" Then strMainPage = "../../Reports/KMTree" & CType(Session("intUserID"), Long) & ".xml"
                            End If
                        Else
                            Call CommonFunction.GenerateTree.GenerateHTMLTreeForKM()
                            If strMainPage = "" Then strMainPage = "../../Reports/KMTree" & CType(Session("intUserID"), Long) & ".html"
                        End If

                        ' Modified By NitinVS on 24 Jan 2006 to draw menu for Favourits 
                    ElseIf strlFromWhere = "FV" Then
                        Dim strFavorites As String
                        strFavorites = FavoritesTree.FavoritesTree.DrawFavoritesHTMLTree()
                        strMainPage = "../../Reports/FA-" & CType(HttpContext.Current.Session("intUserId"), String) & "-" & CType(HttpContext.Current.Session("LoginType"), String) & ".html"

                        ' end Modification By NitinVS on 24 Jan 2006 to draw menu for Favourits 
                    Else


                        'Addition Ends
                        'Added BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                        If UCase(strFromWhere) <> "PM" Then
                            strHashtableKey = strFromWhere & "-" & CType(Context.Session("intUserId"), String) & "-" & CType(Context.Session("LoginType"), String)
                        Else
                            strHashtableKey = strFromWhere & "-" & CommonFunctions.General.CheckIsNothing(Context.Session("intProjectID"), "0") & "-" & CType(Context.Session("intUserId"), String) & "-" & CType(Context.Session("intPostID"), String) & "-" & CType(Context.Session("LoginType"), String)
                        End If
                        'End of Addition BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                        'Added By NileshD on 7 Nov 2005 REQID- WAF3_PB_8
                        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunction.General.GetApplicationKeySetting("IsExtUserUpdateEnabled"), "")) = "TRUE" Then
                            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Employee_Tree_HashTable_List " + CType(Context.Session("intUserId"), String))
                        End If
                        'End of Addition BY NileshD on 7 Nov 2005 REQID- WAF3_PB_8
                        'Added By NileshD on 7 Nov 2005 REQID- WAF3_PB_8
                        If UCase(CommonFunctions.General.CheckIsNothing(CommonFunction.General.GetApplicationKeySetting("IsExtUserUpdateEnabled"), "")) = "TRUE" Then
                            CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_User_Tree_HashTable_List " + CType(Context.Session("intUserId"), String))
                        End If
                        'End of Addition BY NileshD on 7 Nov 2005 REQID- WAF3_PB_8

                        'If client browser is IE then generate the XML tree
                        If CommonFunction.General.IsClientBrowserIE = True Then
                            'check even though client browser is IE and application settings is set to HTML then
                            'generate HTML
                            If m_blnDefaultNavigation = False Then
                                'Added BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                                If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                                    CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                                    Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long), m_blnDefaultNavigation, m_MenuItem, Me)
                                Else
                                    If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".html") = False Then
                                        Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long), m_blnDefaultNavigation, m_MenuItem, Me)
                                    End If
                                End If
                                If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".html"
                                'End of Addition BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                            Else
                                If CommonFunction.General.GetApplicationKeySetting("TreeType").ToUpper = "HTML" Then
                                    'Modified BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                                    If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                                        CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                                        Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                                    Else
                                        If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".html") = False Then
                                            Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                                        End If
                                    End If

                                    'If strMainPage = "" Then strMainPage = "../../Reports/Tree" & CType(Session("intUserID"), Long) & ".html"
                                    If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".html"
                                    'End of Modification BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                                Else
                                    'Modified BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                                    If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                                        CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                                        Call m_GenerateTree.GenerateXMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                                    Else
                                        If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".xml") = False Then
                                            Call m_GenerateTree.GenerateXMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                                        End If
                                    End If

                                    'If strMainPage = "" Then strMainPage = "../../Reports/Tree" & CType(Session("intUserID"), Long) & ".xml"
                                    If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".xml"
                                    'End of Modification BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                                End If
                            End If
                        Else
                            'Modified:RajeshB    Nov 20, 2004

                            'Modified BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8
                            If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                                CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                                ''Commented By Nikhil Adkar on 08-Apr-2026 for DB Null issue 
                                'Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long), m_blnDefaultNavigation, m_MenuItem, Me)
                                ''End of Commented By Nikhil Adkar on 08-Apr-2026 for DB Null issue 
                            Else
                                If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".html") = False Then
                                    ''Commented By Nikhil Adkar on 08-Apr-2026 for DB Null issue 
                                    'Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long), m_blnDefaultNavigation, m_MenuItem, Me)
                                    ''End of Commented By Nikhil Adkar on 08-Apr-2026 for DB Null issue 
                                End If
                            End If

                            'Modification Ends
                            'If client browser is not ie then generate only HTML tree
                            '                        Call CommonFunction.GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long), m_blnDefaultNavigation)
                            'If strMainPage = "" Then strMainPage = "../../Reports/Tree" & CType(Session("intUserID"), Long) & ".html"

                            If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".html"
                            'End of Modification BY NileshD on 5th Sep 2005 REQID- WAF3_PB_8

                        End If
                    End If

                    '-------------------------------------------------------------------------------------------------------------
                    'Added By - PushkarK On - Thursday, December 22, 2005 For Req.ID. - WAF3_GEN_2
                    'Reason   - For Navigation Menu.
                    '-------------------------------------------------------------------------------------------------------------
                Else
                    strMainPage = "NavigationMenu.aspx"
                    If strFromWhere = "FV" Then
                        strSubPage = "Introduction.aspx"
                        intFrameWidth = 230
                    End If

                    m_strScrollForNavPane = "no"
                End If
                '-------------------------------------------------------------------------------------------------------------
                'Addition Ends By - PushkarK On - Thursday, December 22, 2005 For Req.ID. - WAF3_GEN_2 for Navigation Menu
                '-------------------------------------------------------------------------------------------------------------
            End If
        End If

        'added by aniruddhad for junp to record functionality
        If (strJumpURL <> "") Then
            Session("strJumpURL") = strJumpURL
            ' Commented by GaneshD on 23 Sep 2009
            'Session("IssueProject") = "431"
            'End of modification by GaneshD
            'If strSubPage.EndsWith("&") Then
            '    strSubPage = strSubPage + "JumpURL=" + CommonFunction.General.BuildQueryString(strJumpURL)
            'Else
            '    strSubPage = strSubPage + "&JumpURL=" + CommonFunction.General.BuildQueryString(strJumpURL)
            'End If

        End If
        'end addition by aniruddhad
    End Sub

    Private Sub RedirectToDefaultPage(ByVal QueryString As String)
        '=====================================================================
        ' Procedure  Name		:	RedirectToDefaultPage
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	To redirect to the default page
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Sep 01, 2003
        ' Revisions				:	Sep 01, 2003
        '=====================================================================
        Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString

        If strRedirectToPage.Trim = "" Then
            Response.Redirect("../../Default.aspx?" & QueryString)
        Else
            Response.Redirect(strRedirectToPage & "?" & QueryString)
        End If

    End Sub
    Private Sub SetCulture()
        '=====================================================================
        ' Procedure  Name		:	SetCulture
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	To set the ui culture
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Sep 01, 2003
        ' Revisions				:	Sep 01, 2003
        '=====================================================================

        'If session LCID is nothing then
        If Session("LCID") Is Nothing Then
            'Check for web.config settigs for client UI culture
            ' Modified Dec 07,2004 Rajanikant Khethawatt-> For Windows authentication disallowing client culture
            If CommonFunctions.General.GetApplicationKeySetting("ApplyClientUICulture") = "Y" And m_blnIsWindowsAuthenticated = False Then

                Dim strCulture() As String = MyBase.GetFormValue("cboLanguage", False).Split(New Char() {"|"c})

                If strCulture.Length = 2 Then
                    Session("LCID") = strCulture(0)
                    Session("LanguageCode") = strCulture(1)
                End If
            Else
                'If disable then apply the default UI culture of the application
                'Get the object of commonengines.hashtables.culture class
                Dim objCulture As CommonEngines.HashTables.Culture =
                    CommonEngines.HashTables.Culture.GetDefaultCulture
                Session("LCID") = objCulture.LCID
                Session("LanguageCode") = objCulture.CultureID
                objCulture = Nothing
            End If

        End If

    End Sub
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Navigation->NotValidInput"
        Throw ex
    End Sub
    Private Sub Page_Error(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Error

    End Sub
    Sub New()
        MyBase.ApplySecurity(True, 2, True, True, False)

    End Sub

    ' ***********************************************************************************
    ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    Private Function IsWindowsAuthenticated(ByRef LoginName As String, ByVal sender As System.Object) As Boolean
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
        ''Commented And Added by Vaijat K For ADFS Custom SSO
        'If CType(sender, Navigation).User.Identity.IsAuthenticated Then
        '    IsWindowsAuthenticated = True
        '    LoginName = ExtractUserName(sender)
        'Else
        '    IsWindowsAuthenticated = False : LoginName = ""
        'End If
        Dim strString As String = ""
        If Request.QueryString("T") IsNot Nothing Then
            IsWindowsAuthenticated = True
            LoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
                CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_TokenLoginName " & CommonFunctions.General.DecryptString(Request.QueryString("T")) & "", True)))
            'Added By Vishal Mane on 07/07/2025 for SAML SSO Integration
        ElseIf Request.QueryString("SAML") IsNot Nothing Then
            Session("SAML") = Request.QueryString("SAML")
            strString = CommonFunctions.General.DecryptString(Request.QueryString("SAML"))
            IsWindowsAuthenticated = True
            LoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
                CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_TokenLoginName_AD '" & strString & "'", True)))
            ''End of Added By Vishal Mane on 07/07/2025 for SAML SSO Integration
        ElseIf Request.QueryString("AD") IsNot Nothing Then
            Session("AD") = Request.QueryString("AD")
            strString = CommonFunctions.General.DecryptString(Request.QueryString("AD"))
            'Session("AD") = Request.QueryString("AD")
            '' Session("AD") = strString
            IsWindowsAuthenticated = True
            LoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
                CommonFunctions.Data.GetDataScalar("usp_Whizible2_Sel_TokenLoginName_AD '" & strString & "'", True)))
            ''End of Code Added By SajiU For AD integration
        Else
            If CType(sender, Navigation).User.Identity.IsAuthenticated Then
                IsWindowsAuthenticated = True
                LoginName = ExtractUserName(sender)
            Else
                IsWindowsAuthenticated = False : LoginName = ""
            End If
        End If
        ''End of Commented And Added by Vaijat K For ADFS Custom SSO
    End Function

    Private Function ExtractUserName(ByVal sender As System.Object) As String
        '=====================================================================
        ' Procedure  Name		:	ExtractUserName
        ' Parameters Passed		:	By Val sender object(page)
        ' Returns				:	The user name
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	Domain is separated.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Rajanikant 
        ' Created				:	June 04,2004
        '=====================================================================
        Dim strUserName As String = ""
        strUserName = CType(sender, Navigation).User.Identity.Name.ToString
        strUserName = Replace(strUserName, "\", "/")
        ' see of the domain is valid
        m_blnIsValidDomain = IsValidDomain(strUserName)
        strUserName = strUserName.Substring(strUserName.LastIndexOf("/") + 1)

        Return strUserName
    End Function

    Private Function IsValidDomain(ByVal UserName As String) As Boolean
        '=====================================================================
        ' Procedure  Name		:	IsValidDomain
        ' Parameters Passed		:	By Val UserName with Domain Name
        ' Returns				:	The user name
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	Domain is separated.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Rajanikant 
        ' Created				:	June 04,2004
        ' Revisions             :   made the domain-name check case-insensitive
        '                           Rajanikant Khethawatt Dec 07,2004
        '=====================================================================
        Dim strDomain As String = ""
        Dim strValidDomains As String = ""

        ' the list of domains from web.config file
        strValidDomains = CommonFunction.General.GetApplicationKeySetting("ValidDomains")

        ' if domains are specified check within them
        If Trim(strValidDomains & "") <> "" Then
            IsValidDomain = False
            UserName = Replace(UserName, "\", "/")
            strDomain = Replace(UserName, UserName.Substring(UserName.LastIndexOf("/")), "")
            strDomain = strDomain.Substring(strDomain.LastIndexOf("/") + 1)
            If InStr("/" & UCase(Trim(strValidDomains & "")) & "/", "/" & UCase(Trim(strDomain & "")) & "/") > 0 Then
                IsValidDomain = True
            End If
        Else
            ' when no domains are sepcified..allow all domains
            IsValidDomain = True
        End If
    End Function

    ' ***********************************************************************************
    ' End Addition Oct 18,2004 R.No:WAF2_GEN_1 & WAF2_GEN_2
    ' ***********************************************************************************
    Public Sub PlotNavigationBody()
        If m_blnDefaultNavigation = False Then
            Dim sbNav As New System.Text.StringBuilder
            Dim intFrameBorder As Integer = 0
            Dim strFrameID As String = "link"
            Dim strFrameSrc As String = "Links.aspx?FromWhere=" & strFromWhere
            Dim strFrameWidth As String = "99.9%"
            Dim strFrameHeight As String = "99.9%"
            Dim strFrameName As String = "link"
            Dim strFrameScrolling As String = "no"
            Dim intMarginWidth As Integer = 0
            Dim intMarginHeight As Integer = 0
            sbNav.Append("<body topmargin=0  leftMargin=0 rightMargin=0 bottomMargin=0>")
            sbNav.Append("<iframe frameborder=" &
                    intFrameBorder & " name=" & strFrameName _
                   & " height=" & strFrameHeight & " width=" & strFrameWidth _
                   & "  scrolling=" & strFrameScrolling & " src=""Links.aspx?FromWhere=" & strFromWhere _
                   & """ marginwidth=""" & intMarginWidth & """ marginheight=""" & intMarginHeight & """>")

            sbNav.Append("</body>")
            Response.Write(sbNav.ToString)
        End If
    End Sub
    'Private Sub m_MenuGroup_BeforeAddItem(ByVal Cancel As Boolean, ByVal item As MenuItemDecorator) Implements IMenuGroupEventHandler.BeforeAddItem
    '    Call CommonEngine.General.CLCP_Events_Navigation.BeforeAddItem(Cancel, item)
    'End Sub
    'Private Sub m_MenuGroup_AfterAddItem(ByVal item As MenuItemDecorator) Implements IMenuGroupEventHandler.AfterAddItem
    '    Call CommonEngine.General.CLCP_Events_Navigation.AfterAddItem(item)
    'End Sub
    Private Sub BeforeChildItemAssign(ByRef Cancel As Boolean, ByRef item As MenuItemDecorator, ByRef [group] As MenuGroupDecorator) Implements IMenuGroupEventHandler.BeforeChildGroupAssign
        Dim args1 As EventMenuItem = DirectCast(item, EventMenuItem)
        Dim args2 As EventMenuGroup = DirectCast([group], EventMenuGroup)
        Dim blnCancel As Boolean = False
        Call CommonEngine.General.CLCP_Events_Navigation.BeforeChildItemAssign(blnCancel, args1, args2)
    End Sub
    Private Sub AfterChildItemAssign(ByRef item As MenuItemDecorator, ByRef [group] As MenuGroupDecorator) Implements IMenuGroupEventHandler.AfterChildGroupAssign
        Dim args1 As EventMenuItem = DirectCast(item, EventMenuItem)
        Dim args2 As EventMenuGroup = DirectCast([group], EventMenuGroup)

        Call CommonEngine.General.CLCP_Events_Navigation.AfterChildItemAssign(args1, args2)
    End Sub
    Private Sub m_MenuGroup_BeforeAddItem(ByRef Cancel As Boolean, ByRef item As MenuItemDecorator) Implements IMenuGroupEventHandler.BeforeAddItem
        Call CommonEngine.General.CLCP_Events_Navigation.BeforeAddItem(Cancel, item)
    End Sub
    Private Sub m_MenuGroup_AfterAddItem(ByRef item As MenuItemDecorator) Implements IMenuGroupEventHandler.AfterAddItem
        Call CommonEngine.General.CLCP_Events_Navigation.AfterAddItem(item)
    End Sub
    Private Sub m_GenerateTree_Initialize_Menu(ByRef Cancel As Boolean, ByRef Args As CommonFunctions.GenerateTree.WAF_HTMLMenu) Handles m_GenerateTree.Initialize_Menu
        Call CommonEngine.General.CLCP_Events_Navigation.Initialize_Menu_DefaultNavigation(Cancel, Args)
    End Sub

    Private Sub m_GenerateTree_Before_NodeAdd(ByRef Cancel As Boolean, ByRef Args As CommonFunctions.GenerateTree.WAF_HTMLMenuItem) Handles m_GenerateTree.Before_NodeAdd
        Call CommonEngine.General.CLCP_Events_Navigation.Before_NodeAdd_DefaultNavigation(Cancel, Args)
    End Sub

    ''Added By Vaijat  K ON 25/04/2016 For Graph Section
    <System.Web.Services.WebMethod>
    Public Shared Function DrawPieLeaveForMobile(EmployeeID As String) As String
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim dt As New DataTable()
        dt = CommonFunction.Data.GetDataTable("usp_sel_ApproveReject_Leaves " & CType(EmployeeID, Long), True)
        Dim str As String = GetSerialized(dt)
        Return str

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function DrawPieChartForMyApprovalMobile(Entity As String, EmployeeID As String) As String
        Entity = Utilities.Security.SecurityBuilder.CheckUserInput(Entity, 2, True, False, False)
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim dt As New DataTable()
        dt = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_WorkflowApprovalDetails '" & Entity & "'," & CType(EmployeeID, Long), True)
        Dim str As String = GetSerialized(dt)
        Return str

    End Function

    <System.Web.Services.WebMethod>
    Public Shared Function DrawChartForAllApproval(EmployeeID As String) As String
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim dt As New DataTable()
        dt = CommonFunction.Data.GetDataTable("usp_sel_PendingApprovalsCount " & CType(EmployeeID, Long), True)
        Dim str As String = GetSerialized(dt)
        Return str

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function DrawChartForLeaveApproval(EmployeeID As String) As String
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim dt As New DataTable()
        dt = CommonFunction.Data.GetDataTable("usp_sel_Leaves_PendingAndApprovedCount " & CType(EmployeeID, Long), True)
        Dim str As String = GetSerialized(dt)
        Return str

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function DrawChartForEntityApproval(EmployeeID As String) As String
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim dt As New DataTable()
        dt = CommonFunction.Data.GetDataTable("usp_sel_PendingEntityApprovalsCount " & CType(EmployeeID, Long), True)
        Dim str As String = GetSerialized(dt)
        Return str

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function DrawChartForExpenseApproval(EmployeeID As String) As String
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim dt As New DataTable()
        dt = CommonFunction.Data.GetDataTable("usp_sel_tbl_PM_ExpenseApprovalCount " & CType(EmployeeID, Long), True)
        Dim str As String = GetSerialized(dt)
        Return str

    End Function
    <System.Web.Services.WebMethod>
    Public Shared Function DrawChartForTimesheetApproval(EmployeeID As String) As String
        Try
            EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim dt As New DataTable()
            dt = CommonFunction.Data.GetDataTable("usp_sel_PendingTimeSheetApprovalsCount " & CType(EmployeeID, Long), True)
            Dim str As String = GetSerialized(dt)
            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmployeeImagePath(ByVal intEmployeeID As Integer) As String
        Try
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim strImageName As String = ""
            Dim strEmployeeImage As String
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''strImageName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT SystemFilename FROM tbl_RM_EmployeeMaintenance_Attachment  WHERE EmployeeID=" & intEmployeeID, True), ""))
            strImageName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_RM_EmployeeMaintenance_Attachment " & intEmployeeID, True), ""))
            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
            strEmployeeImage = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1)
            strEmployeeImage = strEmployeeImage.Replace("\", "/")
            strEmployeeImage = strEmployeeImage + "/Images/Photo/" + strImageName
            If strImageName = "" Then
                strEmployeeImage = ""
            End If
            Return strEmployeeImage
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetAllCount(ByVal intUserID As String)
        Try
            intUserID = Utilities.Security.SecurityBuilder.CheckUserInput(intUserID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim strCount As String
            strCount = CommonFunctions.Data.GetDataScalar("usp_sel_PendingApprovalsCountAll " & intUserID & "", True)
            Return strCount
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    Public Shared Function GetSerialized(dt As DataTable) As String
        Try
            Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))()
            Dim row As Dictionary(Of String, Object)
            For Each dr As DataRow In dt.Rows
                row = New Dictionary(Of String, Object)()
                For Each col As DataColumn In dt.Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Return serializer.Serialize(rows)
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition Vaijat K
    ''Added By Vaijat K ON 25/04/2016 For HelpDesk Approval Graph
    <System.Web.Services.WebMethod()>
    Public Shared Function GetHeplDeskApprovalDataCount(ByVal intUserID As String)
        Try
            intUserID = Utilities.Security.SecurityBuilder.CheckUserInput(intUserID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim dt As New DataTable()
            dt = CommonFunction.Data.GetDataTable("usp_CNT_LineManager_Approvals_MyApproval " & CType(intUserID, Long), True)
            Dim str As String = GetSerialized(dt)
            Return str
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of Addition Vaijat K
    Protected strPageName As String = ""
    Public Function GetLeftTree()
        Try
            Dim dtModules As New DataTable()
            dtModules = CommonFunctions.Data.GetDataTable("usp_NG2_GetHelpdeskModules", True)
            Dim intCounter As Integer = 0
            Dim strHTML As New StringBuilder()
            'Dim objSystemModulesAry() As CommonEngines.HashTables.SystemModules
            'If CType(MyBase.DefaultUILCID, Integer) = MyBase.CurrentThreadUICultureID Then
            '    objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            'Else
            '    objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules" + MyBase.CurrentThreadUICultureID.ToString)
            '    If objSystemModulesAry Is Nothing Then
            '        objSystemModulesAry = CommonEngines.HashTables.GetHashTableObject.GetHashTableSystemModulesObjectArray("SystemModules")
            '    End If
            'End If
            'If Not objSystemModulesAry Is Nothing Then
            '    For intCount As Integer = 0 To objSystemModulesAry.Length - 1
            '/*Changed By Yasmin on 12th July*/
            For Each dRow As DataRow In dtModules.Rows

                Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleTagID"))), CType(Session("intPostID"), Integer), CType(Session("intUserID"), Integer), Session("LoginType").ToString)
                'Create the object of GetAccess class
                Dim objGetAccess As New WebPage.Templates.AccessRights
                'Call method get access to get the access
                objGetAccess.GetAccess(objGlobal, True)

                If Not objGetAccess.Access Or (CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleName"))) = "Configuration" And CType(Session("IsCreatedByCustomer"), Boolean) = True) Then
                Else
                    If intCounter = 0 Or CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleName"))) = "Support" Then
                        strPageName = dRow("PageName")
                    End If
                    strHTML.Append("<li class='nav-item Module' id='" & CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleName"))) & "' onclick=ChangeTabs('" & dRow("PageName") & "') data-placement='right' data-toggle='tooltip' title='" & CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleName"))) & "'>")
                    strHTML.Append("<a class='nav-link' href='#' data-toggle=dropdown role=button>")
                    ''strHTML.Append("<i class='fa fa-pencil-square-o' aria-hidden='true'></i>")
                    If CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleTagID"))) = "405" Then
                        strHTML.Append("<div class='plotHDIcon'><label class='HelpDeskH'>H</label><label class='HelpDeskD'>D</label></div")
                    ElseIf CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleTagID"))) = "305" Then
                        strHTML.Append("<div class='plotHDIcon'><i class='fa fa-bar-chart-o faChart'></i></div")
                    Else
                        strHTML.Append("<img src='" & CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ImagePath"))) & "' alt='" & CommonFunction.General.FormatString(Server.HtmlEncode(dRow("ModuleName"))) & "' />")
                    End If
                    strHTML.Append("</a>")
                    'strHTML.Append(GetTreeNodes(CommonFunction.General.FormatString(Server.HtmlEncode(objSystemModulesAry(intCount).ShortName))))
                    strHTML.Append("</li>")
                    intCounter += 1
                End If
            Next
            '    Next
            'End If
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_GlobalObject = MyBase.GlobalObject()
    End Sub

    Dim drTree As DataTable
    Public Function GetTreeNodes(ByVal strModule As String)
        GetGlobalObject()
        drTree = New DataTable
        Dim strHTML As New StringBuilder
        Dim m_intUseNewUITree = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Usp_Sel_UseNewUITree", True), "0"), "0").ToString(), Integer)
        Dim m_strSQL As String = ""
        If strModule <> "KM" Then

            m_strSQL = "usp_Sel_AccessibleProjectTags_setup "

            m_strSQL += " NULL"

            m_strSQL = m_strSQL + ",NULL"

            m_strSQL = m_strSQL + "," & m_GlobalObject.UserID.ToString
            m_strSQL = m_strSQL + "," & m_GlobalObject.RoleID.ToString
            m_strSQL = m_strSQL + "," & m_GlobalObject.ProjectID.ToString
            m_strSQL = m_strSQL + ",'" & m_GlobalObject.LoginType & "'"

            m_strSQL += "," + strModule
            If CType(m_intUseNewUITree, Boolean) Then
                m_strSQL = m_strSQL + ",'N'"
            Else
                m_strSQL = m_strSQL + ",'O'"
            End If
        ElseIf strModule.ToUpper = "KM" Then
            m_strSQL = "usp_SEL_KM_Tree " & m_GlobalObject.UserID.ToString & ",'" & m_GlobalObject.LoginType & "'"

        End If
        Dim dtRow() As DataRow

        If strModule.ToUpper = "CRM" Or strModule.ToUpper = "DB" Then
            drTree = CommonFunction.Data.GetDataTable("usp_sel_Tree_forNewUI '" + strModule.ToUpper.ToString + "','" + m_GlobalObject.LoginType + "'", True)
            dtRow = drTree.Select("ParentItemID=0")
        Else
            drTree = CommonFunction.Data.GetDataTable(m_strSQL, True)
            dtRow = drTree.Select("ParentTagID=0")
        End If


        Dim strInnerHTML As New StringBuilder()
        For Each drRow As DataRow In dtRow
            strHTML.Append("<ul class='ulParent dropdown-menu' style='padding-top:0px;' >")

            If strModule.ToUpper = "CRM" Or strModule.ToUpper = "DB" Then
                strInnerHTML.Append(PlotRecursiveTree(drRow("ControlItemID"), strModule))
            Else
                strInnerHTML.Append(PlotRecursiveTree(drRow("TagID"), strModule))
            End If
            If GetTagAccessRights(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), 0)) = True Or CommonFunction.Data.CheckIsDBNull(drRow("TagID"), 0) = 0 Then
                If strInnerHTML.ToString() <> "" Then
                    strHTML.Append("<li class='clsParent' style='padding:0px;'><label class='tree-toggler nav-header' style='width:100%;background-color:#364660!important;color:white;padding:8px;'><i class='fa fa-caret-up' ></i>  " & drRow("TagDescription") & "</label>")
                    strHTML.Append("<ul class='tree'>")
                    strHTML.Append(strInnerHTML.ToString())
                    strHTML.Append("</ul>")
                    strHTML.Append("</li>")

                Else
                    strHTML.Append("<li>" & drRow("TagDescription") & "")
                    strHTML.Append("</li>")
                End If
            End If
            strHTML.Append("</ul>")
        Next
        Return strHTML.ToString()
    End Function

    Public Function PlotRecursiveTree(ByVal strTagID As String, ByVal strModule As String)
        Dim dtRow() As DataRow
        If strModule.ToUpper = "CRM" Or strModule.ToUpper = "DB" Then
            dtRow = drTree.Select("ParentItemID=" & strTagID)
        Else
            dtRow = drTree.Select("ParentTagID=" & strTagID)
        End If
        Dim strHTML As New StringBuilder()
        Dim strInnerHTML As New StringBuilder()
        For Each drRow As DataRow In dtRow
            If strModule.ToUpper = "CRM" Or strModule.ToUpper = "DB" Then
                strInnerHTML.Append(PlotRecursiveTree(drRow("ControlItemID"), strModule))
            Else
                strInnerHTML.Append(PlotRecursiveTree(drRow("TagID"), strModule))
            End If
            If GetTagAccessRights(CommonFunction.Data.CheckIsDBNull(drRow("TagID"), 0)) = True Or CommonFunction.Data.CheckIsDBNull(drRow("TagID"), 0) = 0 Then
                If strInnerHTML.ToString() <> "" Then
                    strHTML.Append("<li class='clsParent'><label class='tree-toggler nav-header'><i class='fa fa-caret-down' ></i>  " & drRow("TagDescription") & "</label>")
                    strHTML.Append("<ul class='tree'>")
                    strHTML.Append(strInnerHTML.ToString())
                    strHTML.Append("</ul>")
                    strHTML.Append("</li>")
                Else
                    strHTML.Append("<li>" & drRow("TagDescription") & "")
                    strHTML.Append("</li>")
                End If
            End If
        Next

        Return strHTML.ToString()
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeVersion(ByVal VersionID As String)
        Try
            VersionID = Utilities.Security.SecurityBuilder.CheckUserInput(VersionID, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            If CommonFunction.RateLimiter.CheckRateLimit(request) Then
                response.StatusCode = 429
                response.Write("Bad Request found")
                Return "Bad Request found"
            End If
            Dim strSql As String = "usp_INS_UPD_tbl_NG2_UserThemeSettings " & HttpContext.Current.Session("intLoginID").ToString() & "," & VersionID
            CommonFunctions.Data.InsertOrUpdateData(strSql, True)
            Return 1
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function


    Private Function GetTagAccessRights(ByVal lngTagID As Long, Optional ByVal IsModuleAccess As Boolean = True, Optional ByVal m_lngPostID As String = "") As Boolean
        '=====================================================================
        ' Function  Name		:	GetTagAccessRights()
        ' Parameters Passed		:	TagID
        ' Returns				:	boolean value whether tag is accessable or not
        ' Parameters Affected	:	None
        ' Purpose				:	To verify whether tag is accessable or not
        ' Description			:	Same as purpose
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	PrashantSJ
        ' Created				:	Feb 11 2009
        ' Revisions				:	
        '=====================================================================
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, lngTagID, m_GlobalObject.RoleID, CType(Session("intUserID"), Integer), Session("LoginType").ToString)
        'Create the object of GetAccess class
        Dim objGetAccess As New WebPage.Templates.AccessRights
        'Call method get access to get the access

        Dim IsAccessForNode As Boolean

        If lngTagID <= 0 Then
            IsAccessForNode = True
        Else
            ' m_GlobalObject.TagID = lngTagID
            'Get the Access Rights 

            objGetAccess.GetAccess(objGlobal, IsModuleAccess)

            If IsModuleAccess Then
                Return objGetAccess.Access()
            End If

            If objGetAccess.Add = True OrElse objGetAccess.Delete = True OrElse objGetAccess.Edit = True OrElse objGetAccess.View Then
                IsAccessForNode = True
            Else
                IsAccessForNode = False
            End If
        End If

        Return IsAccessForNode

    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function Get_AlertType(ByVal type As String, ByVal EmployeeId As String, ByVal ViewFlag As Integer, ByVal RecordFlag As Integer) As String
        '=====================================================================
        ' Procedure	Name	    :	Get_AlertType
        ' Purpose				:   To Update HelpDesk Message ViewFlag For current user
        ' Description			:	
        ' Parameters Passed     :   type [Alert Type - Discussions , Notification or Flag] ,EmployeeId , ViewFlag
        ' Returns               :   sbModalData [HTML Content of HelpDesk Message Details For Message Modal]
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vaijat K
        ' Created				:	Dec 14, 2017
        ' Revisions				:	
        '=====================================================================
        Try
            type = Utilities.Security.SecurityBuilder.CheckUserInput(type, 2, True, False, False)
            EmployeeId = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeId, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim sbModalData As String
            Select Case type
                Case "Discussions"
                    sbModalData = Get_TypeNotification(type, EmployeeId, ViewFlag, RecordFlag)
                Case "Notification"
                    sbModalData = Get_TypeNotification(type, EmployeeId, ViewFlag, RecordFlag)
                Case "Alert"
                    sbModalData = Get_TypeNotification(type, EmployeeId, ViewFlag, RecordFlag)
            End Select

            Return sbModalData
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    Public Shared Function Get_TypeNotification(ByVal notific As String, ByVal EmployeeId As String, ByVal ViewFlag As Integer, ByVal RecordFlag As Integer) As String
        '=====================================================================
        ' Procedure	Name	    :	Get_TypeNotification
        ' Purpose				:   To Fetch HelpDesk Notification Details For current user
        ' Description			:	
        ' Parameters Passed     :   notific [Discussions , Notification or Alert], EmployeeId, ViewFlag
        ' Returns               :   sbModalData [HTML Content of HelpDesk Notification Details For Notification Modal]
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Vaijat K
        ' Created				:	Dec 14, 2017
        ' Revisions				:	
        '=====================================================================
        Try
            Dim sbModalData As New StringBuilder()

            Dim cntRecord As Integer = 0
            Dim Str As String = ""
            Dim cntUnseen As Integer = 0
            Dim StrSelUnseenSP As String = ""
            Dim strShowLoadLink As String = "0"
            Dim dtDatatable As DataTable
            Dim intRowCount As Integer
            Dim intRowCountMax As Integer

            Dim strUpdateSQL As String = ""
            Str = "EXEC usp_NG2_SEL_tbl_NG2_HelpdeskAlerts " & EmployeeId & ",'" & notific & "','" & HttpContext.Current.Session("LoginType") & "'"
            Str = Str.Replace("''", "'")
            Dim drHelpdeskMessages As IDataReader

            dtDatatable = CommonFunction.Data.GetDataTable(Str, True)
            cntUnseen = dtDatatable.Rows.Count

            drHelpdeskMessages = CommonFunction.Data.GetDataReader(Str, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Dim strUserLoginIDNew As String = ""
            Dim strImage As String = ""
            If drHelpdeskMessages.Read = True Then
                If notific <> "Discussions" Then
                    'sbModalData.Append("<div class=list-group>")
                    sbModalData.Append("<div class=row>")
                    sbModalData.Append("<div class=comments-container>")
                    sbModalData.Append("<ul id=comments-list class=comments-list>")
                    Do
                        sbModalData.Append("<li>")
                        sbModalData.Append("<div class=comment-main-level>")
                        Dim strDuration As String = ""
                        Dim strArray() As String
                        strImage = Navigation.GetEmployeeImagePathAndUserName(CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("UserID"), 0), CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("LoginType"), "E"))
                        strArray = strImage.Split("|")
                        If strArray(0) = "" Then
                            ' If strImage = "" Then
                            strImage = "../../Images/Photo/no-photo.png"
                        Else
                            strImage = strArray(0)
                        End If
                        If notific = "Notification" Then
                            sbModalData.Append("<div class=comment-avatar title='Posted by : " & CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("UserName"), "") & "'><img src='" + strImage + "' alt='' class='imgEmployee' onerror=this.src='../../Images/Photo/no-photo.png'><label title='Request ID' class='lblRequestID'>" & drHelpdeskMessages("RequestID") & "</label></div>")
                        ElseIf notific = "Alert" Then
                            If drHelpdeskMessages("Entity").contains("come for Approval") Then
                                sbModalData.Append("<div class=comment-avatar title='Sent By : " & CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("UserName"), "") & "'><img src='" + strImage + "' alt='' class='imgEmployee' onerror=this.src='../../Images/Photo/no-photo.png'><label title='Request ID' class='lblRequestID'>" & drHelpdeskMessages("RequestID") & "</label></div>")
                            ElseIf drHelpdeskMessages("Entity").contains("Approved") Then
                                sbModalData.Append("<div class=comment-avatar title='Approved by : " & CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("UserName"), "") & "'><img src='" + strImage + "' alt='' class='imgEmployee' onerror=this.src='../../Images/Photo/no-photo.png'><label title='Request ID' class='lblRequestID'>" & drHelpdeskMessages("RequestID") & "</label></div>")
                            ElseIf drHelpdeskMessages("Entity").contains("Rejected") Then
                                sbModalData.Append("<div class=comment-avatar title='Rejected by : " & CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("UserName"), "") & "'><img src='" + strImage + "' alt='' class='imgEmployee' onerror=this.src='../../Images/Photo/no-photo.png'><label title='Request ID' class='lblRequestID'>" & drHelpdeskMessages("RequestID") & "</label></div>")
                            End If

                        End If

                        sbModalData.Append("<div class=comment-box>")
                        sbModalData.Append("<div class=comment-head>")
                        sbModalData.Append("<h6 class='comment-name by-author'><a href='#' title='Subject'>" & drHelpdeskMessages("Subject") & "</a></h6>")
                        sbModalData.Append("<span title='Submitted Date'>" & drHelpdeskMessages("RequestSubmittedDate") & "</span>")
                        sbModalData.Append("</div>")
                        sbModalData.Append("<div class=comment-content >")
                        sbModalData.Append(drHelpdeskMessages("Entity"))
                        sbModalData.Append("<label class='label label-danger' style='float:right;cursor:pointer;' onclick='GotoRequestDetail(" & drHelpdeskMessages("RequestID") & ")'>More details</label>")
                        sbModalData.Append("</div>")
                        sbModalData.Append("</div>")
                        sbModalData.Append("</div>")
                        '    sbModalData.Append("<a href='#' class='list-group-item list-group-item-action flex-column align-items-start active'>")
                        '    sbModalData.Append("<div class='d-flex w-100 justify-content-between'>")
                        '    sbModalData.Append("<h5 class='mb-1' style='text-decoration:underline;' title='Request ID'>" & drHelpdeskMessages("RequestID") & "</h5>")
                        '    sbModalData.Append("<small title='Submitted Date'>" & drHelpdeskMessages("RequestSubmittedDate") & "</small>")
                        '    sbModalData.Append("</div>")
                        '    sbModalData.Append("<p class='mb-1' title='Subject'>" & drHelpdeskMessages("Subject") & "</p> ")
                        '    sbModalData.Append("<small>" & drHelpdeskMessages("Entity") & "</small>")
                        '    sbModalData.Append("<label class='label label-danger' style='float:right;cursor:pointer;' onclick='GotoRequestDetail(" & drHelpdeskMessages("RequestID") & ")'>More details</label>")
                        '    sbModalData.Append("</a>")
                        cntRecord = cntRecord + 1
                    Loop While drHelpdeskMessages.Read = True

                    'sbModalData.Append("</div>")


                    sbModalData.Append(cntUnseen)
                Else

                    sbModalData.Append("<div class=row>")
                    sbModalData.Append("<div class=comments-container>")
                    sbModalData.Append("<ul id=comments-list class=comments-list>")

                    Do
                        sbModalData.Append("<li>")
                        sbModalData.Append("<div class=comment-main-level>")
                        Dim strDuration As String = ""
                        Dim strArray() As String
                        strImage = Navigation.GetEmployeeImagePathAndUserName(CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("UserID"), 0), CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("LoginType"), "E"))
                        strArray = strImage.Split("|")
                        If strArray(0) = "" Then
                            ' If strImage = "" Then
                            strImage = "../../Images/Photo/no-photo.png"
                        Else
                            strImage = strArray(0)
                        End If
                        sbModalData.Append("<div class=comment-avatar><img src='" + strImage + "' alt='' class='imgEmployee' onerror=this.src='../../Images/Photo/no-photo.png'></div>")
                        sbModalData.Append("<div class=comment-box>")
                        sbModalData.Append("<div class=comment-head>")
                        sbModalData.Append("<h6 class='comment-name by-author' title='Posted By'>" & drHelpdeskMessages("UserName") & "</h6>")
                        sbModalData.Append("<span title='Submitted Date'>" & CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("RequestSubmittedDate"), "") & "</span>")
                        sbModalData.Append("</div>")
                        sbModalData.Append("<div class=comment-content style='padding-top:0px;' ><div title='Request ID' style='display: inline-block;color:black;'>")
                        sbModalData.Append(drHelpdeskMessages("RequestID") & "</div>&nbsp;&nbsp;<div title='Subject' style='display: inline-block;color:black;'>" & CommonFunction.Data.CheckIsDBNull(drHelpdeskMessages("Subject")))
                        Dim DiscussionThread As String = ""
                        DiscussionThread = drHelpdeskMessages("DiscussionThread")
                        If DiscussionThread.Length < 50 Then
                            sbModalData.Append("</div><div title='Discussion'>" & drHelpdeskMessages("DiscussionThread") & "...")
                        Else
                            sbModalData.Append("</div><div title='Discussion'>" & drHelpdeskMessages("DiscussionThread").Substring(0, 50) & "...")
                        End If

                        sbModalData.Append("</div><label class='label label-danger' style='float:right;cursor:pointer;' onclick='GotoRequestDetail(" & drHelpdeskMessages("RequestID") & ")'>More details</label>")
                        sbModalData.Append("</div>")
                        sbModalData.Append("</div>")
                        sbModalData.Append("</div>")
                        cntRecord = cntRecord + 1
                    Loop While drHelpdeskMessages.Read = True
                    sbModalData.Append("</ul>")
                    sbModalData.Append("</div>")
                    sbModalData.Append("</div>")
                    sbModalData.Append(cntUnseen)
                End If

                If ViewFlag = 1 Then
                    strShowLoadLink = "0"
                ElseIf intRowCountMax <> intRowCount Then
                    strShowLoadLink = "1"
                End If

                sbModalData.Append("$$$")
                sbModalData.Append(strShowLoadLink)
            Else
                sbModalData.Append("<table>")
                sbModalData.Append("<tr><td>")
                sbModalData.Append("No Data Exists!!!")
                sbModalData.Append("<td><tr>")
                sbModalData.Append("</table>")
                sbModalData.Append(cntUnseen)
                sbModalData.Append("$$$")
                sbModalData.Append(strShowLoadLink)
            End If

            Return sbModalData.ToString()
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetEmployeeImagePathAndUserName(ByVal intEmployeeID As Integer, ByVal strLoginType As String) As String
        Try
            strLoginType = Utilities.Security.SecurityBuilder.CheckUserInput(strLoginType, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim strImageName As String = ""
            Dim strRoleDesc As String = ""
            Dim strEmployeeName As String = ""
            Dim strEmployeeDetails As String = ""
            Dim drEmployeeDetails As IDataReader
            Dim strEmployeeImage As String
            drEmployeeDetails = CommonFunctions.Data.GetDataReader("usp_Sel_NG2_tbl_RM_EmployeeMaintenance_Attachment " & intEmployeeID & ",'" & strLoginType & "'", True)
            While drEmployeeDetails.Read()
                strImageName = CommonFunctions.Data.CheckIsDBNull(drEmployeeDetails("SystemFilename"), "")
                strRoleDesc = CommonFunctions.Data.CheckIsDBNull(drEmployeeDetails("RoleDescription"), "")
                strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drEmployeeDetails("EmployeeName"), "")
            End While

            strEmployeeImage = strEmployeeImage + "../../Images/Photo/" + strImageName
            If strImageName = "" Then
                strEmployeeImage = "NoImage"
            End If
            If strRoleDesc = "" Then
                strRoleDesc = ""
            End If
            If strEmployeeName = "" Then
                strEmployeeName = ""
            End If
            strEmployeeDetails = strEmployeeImage + "|" + strRoleDesc + "|" + strEmployeeName
            Return strEmployeeDetails
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    <System.Web.Services.WebMethod()>
    Public Shared Function GetDataCountAJAX(ByVal id As String)
        Try
            id = Utilities.Security.SecurityBuilder.CheckUserInput(id, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            Dim nav As New Navigation
            nav.GetDataCount()
            Return nav.m_strAlertCount & "|" & nav.m_strNotificationCount & "|" & nav.m_strDiscussionCount
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function

    Protected Sub PlotThemes()
        Dim dtTable As New DataTable
        dtTable = CommonFunctions.Data.GetDataTable("usp_NG2_Sel_tbl_UI_StyleSheets " & Session("intLoginID"), True)
        Dim strHTML As New StringBuilder
        For Each dRow As DataRow In dtTable.Rows
            strHTML.Append("<li>")
            strHTML.Append("<a onclick='ChangeTheme(" & dRow("StyleSheetID") & ")'>" & dRow("StyleSheetUserFriendlyName") & "")
            If dRow("IsSelected") = 1 Then
                strHTML.Append("<i class='fa fa-check' style='color:black;display:inline-block;'></i>")
            End If
            strHTML.Append("</a>")
            strHTML.Append("</li>")
        Next

        CommonFunctions.General.WriteHTML(strHTML.ToString())
    End Sub
    <System.Web.Services.WebMethod()>
    Public Shared Function ChangeTheme(ByVal id As String)
        Try
            id = Utilities.Security.SecurityBuilder.CheckUserInput(id, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            If CommonFunction.RateLimiter.CheckRateLimit(request) Then
                response.StatusCode = 429
                response.Write("Bad Request found")
                Return "Bad Request found"
            End If
            Dim strSql As String = "usp_NG2_INS_UPD_tbl_UI_UserSettings " & HttpContext.Current.Session("intLoginID") & "," & id
            CommonFunctions.Data.InsertOrUpdateData(strSql, True)
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function MarkAllDiscussionAsRead(ByVal UserID As String, ByVal LoginType As String)
        Try
            UserID = Utilities.Security.SecurityBuilder.CheckUserInput(UserID, 2, True, False, False)
            LoginType = Utilities.Security.SecurityBuilder.CheckUserInput(LoginType, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            CommonFunction.Data.InsertOrUpdateData("EXEC usp_Ng2_MarkAllDiscussionAsRead " & UserID & ",'" & LoginType & "'", True)
            Return "1"
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GeneratePK_Token(ByVal ProjectID As String) As String
        ProjectID = Utilities.Security.SecurityBuilder.CheckUserInput(ProjectID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If

        Dim m_PKToken As String
        m_PKToken = CommonFunctions.Security.Token.GetToken(ProjectID + CType(HttpContext.Current.Session("intUserID"), String))

        Return m_PKToken
    End Function

    'commented And added by Aditya J. on 19-08-2026 for showing closed projects also in the session project dropdown
    'Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27
    'Added By Dipali V on 1st Aug 2023 For Session Project
    '<System.Web.Services.WebMethod()>
    'Public Shared Function GetSessionProject(ByVal UserID As String, ByVal LoginType As String)
    '    Dim dt As New DataTable()
    '    dt = CommonFunction.Data.GetDataTable("EXEC usp_Whizible2_Sel_AccessibleProjects_LoginResource " & UserID & ",'" & LoginType & "', 1, 0,'[Over] = ''0''','ProjectName ASC'", True)
    '    Dim str As String = GetSerialized(dt)
    '    Return str

    'End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSessionProject(ByVal UserID As String, ByVal LoginType As String)

        Dim dt As New DataTable()
        'Get currently selected project from Session
        Dim SessionProjectID As String =
        Convert.ToString(HttpContext.Current.Session("intProjectID"))

        'If SessionProjectID is empty, pass NULL to the SP
        If String.IsNullOrEmpty(SessionProjectID) OrElse SessionProjectID = "0" Then
            SessionProjectID = "NULL"
        End If

        'Get accessible projects.
        'If SessionProjectID is provided, the new SP will also include
        'the selected project even if it is closed/over.
        dt = CommonFunction.Data.GetDataTable(
        "EXEC usp_Whizible2_Sel_AccessibleProjects_WithSelected " &
        UserID & ",'" &
        LoginType & "',1,0,'[Over] = ''0''','ProjectName ASC'," &
        SessionProjectID,
        True
    )

        Dim str As String = GetSerialized(dt)
        Return str

    End Function
    'End Of commented And added by Aditya J. On 19-08-2026 For showing closed projects also In the session project dropdown

    <System.Web.Services.WebMethod()>
    Public Shared Function SetSessionProject(ByVal ProjectID As String, ByVal ProjectName As String, ByVal MasterTagId As String) As String
        Dim strSQLQuery As String
        Dim ProjectLevelRole As String
        HttpContext.Current.Session("intProjectID") = ProjectID
        HttpContext.Current.Session("strProjectName") = ProjectName

        strSQLQuery = "EXEC usp_Whizible2_Sel_EmployeeProjectRoleIRPIR " & ProjectID & ", " & CType(HttpContext.Current.Session("intUserID"), Long) & ""
        ProjectLevelRole = CommonFunctions.Data.GetDataScalar(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If ProjectLevelRole <> "" Then
            HttpContext.Current.Session("intPostID") = ProjectLevelRole
        End If

        Dim ModuleTagID As String
        Dim TemplateID As String
        Dim ParentTagID As String
        Dim drTagDetailsDetails As IDataReader
        If MasterTagId <> "0" Then
            drTagDetailsDetails = CommonFunctions.Data.GetDataReader("usp_GettagmasterDetails " & MasterTagId & "", True)
            While drTagDetailsDetails.Read()
                ModuleTagID = CommonFunctions.Data.CheckIsDBNull(drTagDetailsDetails("ModuleTagID"), "")
                ParentTagID = CommonFunctions.Data.CheckIsDBNull(drTagDetailsDetails("ParentTagID"), "")
                TemplateID = CommonFunctions.Data.CheckIsDBNull(drTagDetailsDetails("TemplateID"), "")
            End While
        End If

        Return ModuleTagID + "|" + TemplateID + "|" + ParentTagID
    End Function

    'End of Added By Dipali V on 1st Aug 2023 For Session Project
    'End of Added by Aditya J. on 18-05-2026 for integrating session project dropdown in W27

    'commented and added by Aditya J. on 09-06-2026 to show alert when set default project
    <System.Web.Services.WebMethod()>
    Public Shared Function SetDefaultProject() As String
        Try
            Dim strResult As String = CommonFunctions.General.CheckIsNothing(
            CommonFunctions.Data.CheckIsDBNull(
                CommonFunctions.Data.GetDataScalar(
                    "EXEC usp_Ins_Upd_tbl_PM_DefaultTabProject " & HttpContext.Current.Session("intUserID").ToString & "," &
                    HttpContext.Current.Session("intProjectID").ToString & ",Null,'" &
                    HttpContext.Current.Session("LoginType").ToString & "'",
                    CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0")
            Return strResult
        Catch ex As Exception
            Return "0"
        End Try
    End Function
    'End of commented and added by Aditya J. on 09-06-2026 to show alert when set default project

End Class
