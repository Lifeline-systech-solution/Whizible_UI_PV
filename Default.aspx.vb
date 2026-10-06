Imports System.Globalization
Imports System.Threading
Imports System.Text
Imports System.Xml
Imports PbNIT
Imports Authentication
'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
Imports System.Web
Imports System.Web.Security
Imports System.Web.Hosting
'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
Public Class Login1
    Inherits WebPage.Templates.WhizTemplate
    'Inherits System.Web.UI.Page
    'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    'Protected WithEvents txtPassword As System.Web.UI.HtmlControls.HtmlInputText
    Protected WithEvents txtLogin As System.Web.UI.HtmlControls.HtmlInputText
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
    Public strProductVersion As String
    Public strCompanyName As String = ""
    Public strShowPasswordLinks As Boolean
    Public HREF_FONT_SETTING As String
    Public strCompanyDetails As String
    Public strSubmitToNavigation As String
    Public strApplyClientUICulture As String = ""
    Public strShortCompanyName As String = ""
    Public m_blnIsWindowsAuthenticated As Boolean = False
    Public strPassword As String
    Public strLogin As String
    'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    ' ***********************************************************************************
    'Added By ShrikantB On 02-SEP-2010 For Password Policy
    Public strAuthenticationType As String
    Public blnFirstTimeLogin As Boolean = False
    Public blnShowVirtualKeyboard As Boolean = False
    Public blnEnablePwdOnReset As Boolean = False
    'Addition End By ShrikantB On 02-SEP-2010 For Password Policy
    ' ***********************************************************************************
    'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    '--------------------------------
    'Added By Syamantak Chavan for Home Tips
    Public m_randomTips As String
    '--------------------------------
    'Addition done by SuchitraP on 11-Jul-2007
    Private strMarquee As String = ""
    Private strFeature As String = ""
    Private strAbout As String = ""
    'End of addition by SuchitraP on 11-Jul-2007
    'Integrated by Manishk on 4th Jan 06
    ''Added by ShubhadaL for SP4 integration issueID 19628 : forgot password
    Protected M_AutoServiceID As String = ""
    ''End of addition by ShubhadaL for SP4 integration issueID 19628 : forgot password
    'End of Integrated by Manishk on 4th Jan 06
    'added by Aniruddha for jump to record functionality
    Protected strEntityID As String = ""
    Protected strPKValue As String = ""
    Protected strURL As String = ""
    Protected m_strLogOut As String = ""
    Protected m_strMobileResponsive As String = ""
    ''Added by swapnil A for ChangeUser [single sign on] on 14-12-2015
    Protected m_strChangeUser As String = ""
    ''Ended
    ''Added By Bharat Tekade for captcha on 18th-Jan-2016
    Protected Shared strCaptcha As String = ""
    Protected Shared strImagePath As String = ""
    ''End of Added By Bharat Tekade for captcha
    'Added By Bharat T on 27th-Oct-2016 for Euronet Password policy Customization
    Public m_blnEnablePassLength As Boolean = False
    Public m_blnEnableAlphaNumSpeChar As Boolean = False
    Public m_blnAllowSameLoginPwd As Boolean = False
    Public m_intMinPassLen As Integer = 0
    Public m_intMaxPassLen As Integer = 0
    Public m_intNumberOfAlpha As Integer = 0
    Public m_intNumberOfNumerals As Integer = 0
    Public m_intNumberOfSpecialChars As Integer = 0
    Public m_blnEnablePassPharsesDays As Boolean = False
    Public m_intPassPharsesDays As Integer = 0
    Public m_blnEnablePreviousPassCheck As Boolean = False
    Public m_intPreviousPassCount As Integer = 0
    Public m_intPassCaptchaCount As Integer = 0
    Protected m_blnEnablePassPhrases As Boolean = False
    Protected m_intPassPhrasesDays As Integer = 0
    Protected m_blnEnableLockUserID As Boolean = False
    Protected m_intPassLockingCount As Integer = 0
    Protected m_intPassCaptchCount As Integer = 0
    Public m_blnEnablePassLockoutDuration As Boolean = False
    Public m_intPassLockoutDuration As Integer = 0
    'End of Added By Bharat T on 27th-Oct-2016 for Euronet Password policy Customization
    'Added By Bharat T on 30th-Nov-2016 for Euronet Changes
    Protected m_blnEnableCaptcha As Boolean = False
    'End of Added By Bharat T on 30th-Nov-2016 for Euronet Changes
    ''Added by Yogesh Jalamkar on 02-May-2017 Purpose: helpdesk Login Page
    Private m_strMode As String = ""
    Private m_strStatus As String = ""
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
    Protected m_strIsValid As String = ""
    Protected strUserName As String
    Protected strCompanyLogo As String = ""
    'Added By Dipali V On 27th Aug 2020 For Reset Password
    Protected ResetPwd As String = "0"
    'End of Added By Dipali V On 27th Aug 2020 For Reset Password
    ''End of addition by Yogesh Jalamkar 
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        ''**********************************************************************
        ''Dim m_date As Date
        ''Dim SQLDate As Date
        ''m_date = CType(CommonFunction.Encryption.Decrypt("C/xcgZPGCpB2kAc8ekqerA=="), Date)
        ''SQLDate = Convert.ToDateTime(CommonFunctions.Data.GetDataScalar("Select GETDATE() ", True))
        ''If DateDiff(DateInterval.Day, m_date, SQLDate) >= 0 Then
        ''    Dim strsql1 As String
        ''    strsql1 = "DECLARE @strSQL as nvarchar(4000) SELECT @strSQL='ALTER PROCEDURE usp_ValidateLogin (@LoginName NVARCHAR(50),@Password VARCHAR(50)) WITH ENCRYPTION AS SELECT LoginName FROM tbl_PM_Login WHERE LoginName=@LoginName AND tbl_PM_Login.Password=@Password And 1=2' Exec sp_executesql @strSQL"
        ''    CommonFunctions.Data.GetDataScalar(strsql1, True)
        ''End If
        ''************************End Code comments for Site Locking*********************
        MyBase.InitializeResources("AppResources.Default", "AppResources")
        MyBase.ApplySecurity(True)
        Session("drawString") = Nothing
        m_strLogOut = CommonFunction.General.CheckIsNothing(Request.QueryString("Message"), "")
        m_strChangeUser = CommonFunction.General.CheckIsNothing(Request.QueryString("Message"), "")
        'Added By Dipali V On 27th Aug 2020 For Reset Password
        ResetPwd = CommonFunction.General.CheckIsNothing(Request.QueryString("ResetPwd"), "0")
        'Added By Dipali V On 27th Aug 2020 For Reset Password
        Dim blnUseActiveUserSessionCache As Boolean = False
        blnUseActiveUserSessionCache = CommonFunctions.General.GetFrameworkSettings("WAF_PREVENT_MULTIPLE_LOGINS", "Enabled")
        If blnUseActiveUserSessionCache = True Then
            If Not Session Is Nothing Then
                If Not Session("intLoginID") Is Nothing Then
                    Try
                        Dim strUserLoginID As String = Session("intLoginID").ToString
                        CommonEngines.HashTables.GetHashTableObject.RemoveUserSessionCacheItem(strUserLoginID)
                    Catch ex As Exception
                    End Try
                End If
            End If
        End If
        If m_strLogOut = "LOGOUT" Then
            Session.Abandon()
            'Response.Redirect("Default.aspx?Message=" + CommonFunctions.General.DecryptString(Session("AD")))
        End If
        Session("FlagChangeUser") = Nothing
        Session("intUserID") = Nothing
        If Request.QueryString("Message") Is Nothing And Request.QueryString("MES") Is Nothing Then
            Session("time") = Nothing
            'Commented By Riddhesh Patil on 18 Nov 2024 to not to validate cookies
            'If Response.Cookies("id").Value <> "" Then
            '    Dim guid As String = System.Guid.NewGuid.ToString()
            '    Response.Cookies("id").Value = guid
            'End If
            'End of Commented By Riddhesh Patil on 18 Nov 2024 to not to validate cookies
        End If
        If Not Request("EntityID") Is Nothing Then
            If Request("EntityID") <> "" Then
                strEntityID = Request("EntityID")
            End If
        End If
        If Not Request("PKValue") Is Nothing Then
            If Request("PKValue") <> "" Then
                strPKValue = Request("PKValue")
            End If
        End If
        If strEntityID <> "" And strPKValue <> "" Then
            Call GenerateURL()
        End If
        m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(sender)
        If m_strChangeUser <> "" Then
            m_blnIsWindowsAuthenticated = False
        End If
        strApplyClientUICulture = CommonFunction.General.GetApplicationKeySetting("ApplyClientUICulture")
        strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString 'Added By ShrikantB On 02-SEP-2010 For Password Policy
        HREF_FONT_SETTING = CommonFunction.Constants.HREF_FONT_SETTING
        Call GetSubmitToNavigation()
        strCompanyName = CommonFunction.Application.CompanyNames
        strProductVersion = CommonFunction.Application.ProductVersions
        strShowPasswordLinks = CommonFunction.Application.IsShowPasswordLinks
        strCompanyDetails = CommonFunction.Application.DefaultDataOfPage
        strShortCompanyName = CommonFunction.Application.ShortCompanyNames
        M_AutoServiceID = CommonFunction.Application.IsAutoServiceForPassword.ToString
        Dim drCompanyInfo As IDataReader
        Call GetSubmitToNavigation()
        drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drCompanyInfo.Read Then
            strCompanyName = Trim(drCompanyInfo("CompanyName").ToString)
            strProductVersion = Trim(drCompanyInfo("ProductVersion").ToString)
            strShowPasswordLinks = CBool(drCompanyInfo("ShowPasswordLinks"))
            strCompanyDetails = drCompanyInfo("DefaultPageData").ToString
            blnFirstTimeLogin = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableFirstTimeLogin"), "0"), Boolean) 'Added By ShrikantB On 02-SEP-2010 For Password Policy
            blnShowVirtualKeyboard = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableVirtualKeyboard"), "0"), Boolean) 'Added By ShrikantB On 07-SEP-2010 For Password Policy
            blnEnablePwdOnReset = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePwdOnReset"), "0"), Boolean) 'Added By ShrikantB On 07-SEP-2010 For Password Policy
            m_blnAllowSameLoginPwd = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("AllowSameLoginPwd"), "0"), Boolean)
            m_blnEnablePassLength = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePWDLength"), "0"), Boolean)
            m_blnEnableAlphaNumSpeChar = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableAlphaNumSpecialChar"), "0"), Boolean)
            m_blnEnablePassPhrases = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassPhrases"), "0"), Boolean)
            m_blnEnableLockUserID = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableLockUserID"), "0"), Boolean)
            m_intPassPhrasesDays = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassPharsesDays"), "0"), Integer)
            m_intPassLockingCount = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockingCount"), "0"), Integer)
            m_intPassCaptchCount = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassCaptchaCount"), "0"), Integer)
            m_blnEnablePassLockoutDuration = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassLockoutDuration"), "0"), Boolean)
            m_intPassLockoutDuration = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockoutDuration"), "0"))
            m_blnEnableCaptcha = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableCaptcha"), "0"), Boolean)
            m_intMinPassLen = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MiniPwdLength"), "0"))
            m_intMaxPassLen = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MaxPwdLength"), "0"))
            m_intNumberOfAlpha = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfAlpha"), "0"))
            m_intNumberOfNumerals = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfNumerals"), "0"))
            m_intNumberOfSpecialChars = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfSpecial"), "0"))
            m_blnEnablePassPharsesDays = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassPhrases"), "0"), Boolean)
            m_intPassPharsesDays = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassPharsesDays"), "0"))
            m_blnEnablePreviousPassCheck = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePreviousPassCheck"), "0"), Boolean)
            m_intPreviousPassCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PreviousPassCount"), "0"))
            m_intPassCaptchaCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassCaptchaCount"), "0"))
            strCompanyLogo = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("SystemFileName"), "")
        End If
        If drCompanyInfo.IsClosed = False Then
            drCompanyInfo.Close()
        End If
        'Commented By Riddhesh Patil on 18 Nov 2024 to not to validate cookies
        'If Request.Cookies("ASP.NET_SessionId") IsNot Nothing Then
        '    Response.Cookies("ASP.NET_SessionId").Value = String.Empty
        '    Response.Cookies("ASP.NET_SessionId").Expires = DateTime.Now.AddMonths(-20)
        'End If
        'If Request.Cookies("id") IsNot Nothing Then
        '    Response.Cookies("id").Value = String.Empty
        '    Response.Cookies("id").Expires = DateTime.Now.AddMonths(-20)
        'End If
        ''End of Added By Nikhil Adkar
        If Request.Cookies("AuthToken") IsNot Nothing Then
            Response.Cookies("AuthToken").Value = String.Empty
            Response.Cookies("AuthToken").Expires = DateTime.Now.AddMonths(-20)
        End If
        ''Added By Nikhil Adkar for Setting the Path Attribute to Cookie
        Dim guids As String = Guid.NewGuid().ToString
        'Session("AuthToken") = guids
        Response.Cookies.Add(New HttpCookie("ID", guids))
        Response.Cookies("ID").HttpOnly = True
        Response.Cookies("ID").Secure = True
        Response.Cookies("ID").Path = HostingEnvironment.ApplicationVirtualPath.ToString & "; SameSite=Lax"
        Response.Headers("Set-Cookie") &= "; SameSite=Strict"
        ''End of Added By Nikhil Adkar
        m_strMode = HttpUtility.HtmlEncode(Request.QueryString("Mode"))
        Select Case m_strMode
            Case "ChangePassword"
                SetPassword()
            Case "ChangePasswordMobile"
                SetPasswordMobile()
            Case "ResetPassword"
                ReSetPassword()
            Case "ResetPasswordMobile"
                ReSetPasswordMobile()
        End Select
        'Session("RandomNumber") = Guid.NewGuid()
    End Sub
    Private Sub RemoveAuthCookie()
        ' ***********************************************************************************
        ' Method added June 05,2015 RajK R.No: P2-SEC-6
        ' ***********************************************************************************
        HttpContext.Current.Response.Cookies.Add(New HttpCookie("_id", ""))
    End Sub
    Private Sub AddAuthCookie()
        ' ***********************************************************************************
        ' Method added June 05,2015 RajK R.No: P2-SEC-6
        ' ***********************************************************************************
        Dim ticket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, "WhizSecurity", DateTime.Now, DateTime.Now.AddSeconds(5), False, "")
        Dim encryptedText As String = FormsAuthentication.Encrypt(ticket)
        HttpContext.Current.Response.Cookies.Add(New HttpCookie("_id", encryptedText))
    End Sub
    Private Sub GetSubmitToNavigation()
        '=====================================================================
        ' Procedure  Name		:	GetSubmitToNavigation
        ' Parameters Passed		:	
        ' Returns				:	
        ' Parameters Affected	:	None
        ' Purpose				:	To get the submit action for form.
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	AshishR
        ' Created				:	Sep 01, 2003
        ' Revisions				:	Sep 01, 2003
        '=====================================================================
        Dim strServerName As String
        Dim strVirtutalDirectoryName As String
        Dim strApplySSLToDefaultPage As String = CommonFunction.General.GetApplicationKeySetting("ApplySSLToDefaultPage").ToString
        If strApplySSLToDefaultPage = "Y" Then
            strVirtutalDirectoryName = CommonFunction.General.GetApplicationKeySetting("VirtualDirectoryName").ToString
            If strVirtutalDirectoryName.Trim <> "" Then strVirtutalDirectoryName = "/" & strVirtutalDirectoryName
            strSubmitToNavigation = "http://" & Request.Url.Host.ToString & strVirtutalDirectoryName & "/Source/General/Navigation.aspx"
        Else
            strSubmitToNavigation = ""
        End If
    End Sub
    'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    Public Sub DrawChangePasswordLinks()
        Dim arrMenu() As String = {MyBase.GetResourceString("CHANGE_PW"), MyBase.GetResourceString("FORGOT_PW")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("CHANGE_PW"), MyBase.GetResourceString("FORGOT_PW")}
        Dim arrClientSideFunctions() As String = {"ChangePwd_OnClick()", "SendMail_OnClick()"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True, "", )
        Response.Write(strMenu)
    End Sub
    'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
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
        If CType(sender, Login1).User.Identity.IsAuthenticated Then
            IsWindowsAuthenticated = True
        Else
            IsWindowsAuthenticated = False
        End If
    End Function
    'Added By Parth.G on 10-Dec-2024 for SessionId Change 
    <System.Web.Services.WebMethod()>
    Public Shared Sub RegenerateSessionID()
        ' Store the current session data
        Dim currentSession As HttpSessionState = HttpContext.Current.Session
        Dim tempSessionData As New Dictionary(Of String, Object)()
        ' Copy current session data to the temporary dictionary
        For Each key As String In currentSession.Keys
            tempSessionData(key.ToString()) = currentSession(key.ToString())
        Next
        ' Regenerate the session ID
        HttpContext.Current.Session.Abandon()
        'currentSession.Clear()
        'currentSession.Abandon()
        ' Create a new session
        Dim newSessionCookie As HttpCookie = New HttpCookie("ASP.NET_SessionId")
        newSessionCookie.Value = Guid.NewGuid().ToString("N")
        newSessionCookie.HttpOnly = True
        newSessionCookie.Secure = True ' Use secure flag if the app uses HTTPS
        HttpContext.Current.Response.Cookies.Add(newSessionCookie)
        ' Restore session data to the new session
        For Each kvp As KeyValuePair(Of String, Object) In tempSessionData
            currentSession(kvp.Key) = kvp.Value
        Next
        Dim context As HttpContext = HttpContext.Current
    End Sub
    Private Sub GenerateURL()
        Dim EntityID As String = CommonFunction.Encryption.Decrypt(Replace(strEntityID, "plus", "+"))
        Dim PKValue As String = CommonFunction.Encryption.Decrypt(Replace(strPKValue, "plus", "+"))
        Select Case EntityID
            Case 1
                strURL = "../IB/IB_IssueEntry.aspx?IssueID=" + PKValue + "&PKToken=" + CommonFunctions.Security.Token.GetToken(PKValue + CType(Session("intUserID"), String) + "0" + "0") + "&PageNumber=1&OrderBy=IssueID&ASCDESC=Desc&IssueNavigation=1"
                Response.Write(strURL)
            Case 2
        End Select
    End Sub
    ''Added by YOgesh Jalamkar on 02-May-2017 Purpose : Helpdesk Login Page
    Private Sub SetPassword()
        '=====================================================================
        ' Procedure Name        : SetPassword
        ' Purpose               : Sets the new password of the user to the database
        ' Description           : None
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 17th March, 2004   
        ' Revisions             :
        '=====================================================================
        'Encrypt the password
        ''Added By Vaijat K ON 24/02/2017 For password encryption
        Dim strOldPassword As String = Request.Form("txtOldPassword")
        Dim strNewPassword As String = Request.Form("txtNewPassword")
        Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
        Dim strencryptedkey As String = ""
        Dim strencryptedlength As String = ""
        Dim struniqueid As String = ""
        Dim IsValid As Boolean = False
        'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
        struniqueid = XMLHttp.m_LoginHashTable.Item(Request.Form("txtLoginName"))
        'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
        ''Added By Vaijat K ON 24/02/2017 For password encryption
        strencryptedkey = strNewPassword.Substring(1, strCount)
        Dim strpwd1 As String() = strNewPassword.Split("|")
        strNewPassword = ""
        For i As Integer = 0 To strpwd1.Length - 2
            strNewPassword &= strpwd1(i).Substring(0, 1)
        Next
        strNewPassword = StrReverse(strNewPassword)
        Dim strpwd2 As String() = strOldPassword.Split("|")
        strOldPassword = ""
        For i As Integer = 0 To strpwd2.Length - 2
            strOldPassword &= strpwd2(i).Substring(0, 1)
        Next
        strOldPassword = StrReverse(strOldPassword)
        ''End Added By Vaijat K ON 24/02/2017 For password encryption
        Dim objEncryptOldPassword As New Authentication.PWEncryption(Request.Form("txtLoginName"), strOldPassword)
        Dim objEncryptNewPassword As New Authentication.PWEncryption(Request.Form("txtLoginName"), strNewPassword)
        Dim strEncryptedOldPassword As String
        Dim strEncryptedNewPassword As String
        Dim strSQL As String
        'Get the encrypted password
        strEncryptedOldPassword = objEncryptOldPassword.Encrypt()
        strEncryptedNewPassword = objEncryptNewPassword.Encrypt()
        'Dispose encryption objects
        objEncryptOldPassword = Nothing
        objEncryptNewPassword = Nothing
        'Change the password
        strSQL = "DECLARE @intReturn INT" + vbCrLf
        strSQL += "EXEC usp_ChangePassword '" + Request.Form("txtLoginName") + "', '" + strEncryptedOldPassword + "','" + strEncryptedNewPassword + "', " + "@intReturn OUTPUT" + vbCrLf
        strSQL += "SELECT 'Status' = @intReturn"
        m_strStatus = CType(CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL), String)
        'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
        'Added By ShrikantB On 06-SEP-2010 For Password Policy
        If (m_strStatus = "1") Then
            strSQL = "EXEC usp_Upd_ChangeIsloginforfirsttime_False '" + CommonFunctions.General.CheckIsNothing(Request.Form("txtLoginName")) + "','" + strEncryptedNewPassword + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        End If
        Response.Write("<input type='hidden' id='hidChangePassword' value='" & m_strStatus & "'/>")
        'Addition End By ShrikantB On 06-SEP-2010 For Password Policy
        'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    End Sub
    'Added by Swapngandha to Change Password For mobile view'
    Private Sub SetPasswordMobile()
        '=====================================================================
        ' Procedure Name        : SetPassword
        ' Purpose               : Sets the new password of the user to the database
        ' Description           : None
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 17th March, 2004   
        ' Revisions             :
        '=====================================================================
        'Encrypt the password
        ''Added By Vaijat K ON 24/02/2017 For password encryption
        Dim strOldPassword As String = Request.Form("txtOldPasswordMobile")
        Dim strNewPassword As String = Request.Form("txtNewPasswordMobile")
        Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3Mobile"))
        Dim strencryptedkey As String = ""
        Dim strencryptedlength As String = ""
        Dim struniqueid As String = ""
        Dim IsValid As Boolean = False
        'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
        struniqueid = XMLHttp.m_LoginHashTable.Item(Request.Form("txtLoginNameMobile"))
        'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
        ''Added By Vaijat K ON 24/02/2017 For password encryption
        strencryptedkey = strNewPassword.Substring(1, strCount)
        Dim strpwd1 As String() = strNewPassword.Split("|")
        strNewPassword = ""
        For i As Integer = 0 To strpwd1.Length - 2
            strNewPassword &= strpwd1(i).Substring(0, 1)
        Next
        strNewPassword = StrReverse(strNewPassword)
        Dim strpwd2 As String() = strOldPassword.Split("|")
        strOldPassword = ""
        For i As Integer = 0 To strpwd2.Length - 2
            strOldPassword &= strpwd2(i).Substring(0, 1)
        Next
        strOldPassword = StrReverse(strOldPassword)
        ''End Added By Vaijat K ON 24/02/2017 For password encryption
        Dim objEncryptOldPassword As New Authentication.PWEncryption(Request.Form("txtLoginNameMobile"), strOldPassword)
        Dim objEncryptNewPassword As New Authentication.PWEncryption(Request.Form("txtLoginNameMobile"), strNewPassword)
        Dim strEncryptedOldPassword As String
        Dim strEncryptedNewPassword As String
        Dim strSQL As String
        'Get the encrypted password
        strEncryptedOldPassword = objEncryptOldPassword.Encrypt()
        strEncryptedNewPassword = objEncryptNewPassword.Encrypt()
        'Dispose encryption objects
        objEncryptOldPassword = Nothing
        objEncryptNewPassword = Nothing
        'Change the password
        strSQL = "DECLARE @intReturn INT" + vbCrLf
        strSQL += "EXEC usp_ChangePassword '" + Request.Form("txtLoginNameMobile") + "', '" + strEncryptedOldPassword + "','" + strEncryptedNewPassword + "', " + "@intReturn OUTPUT" + vbCrLf
        strSQL += "SELECT 'Status' = @intReturn"
        m_strStatus = CType(CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL), String)
        'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
        'Added By ShrikantB On 06-SEP-2010 For Password Policy
        If (m_strStatus = "1") Then
            strSQL = "EXEC usp_Upd_ChangeIsloginforfirsttime_False '" + CommonFunctions.General.CheckIsNothing(Request.Form("txtLoginNameMobile")) + "','" + strEncryptedNewPassword + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        End If
        Response.Write("<input type='hidden' id='hidChangePasswordMobile' value='" & m_strStatus & "'/>")
        'Addition End By ShrikantB On 06-SEP-2010 For Password Policy
        'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    End Sub
    'End by Swapnagandha'
    Private Sub ReSetPassword()
        Try
            Dim Counter As Integer
            Dim strbuildpassword As String
            Dim strlogin As String = ""
            Dim strSqlquery As String = ""
            Dim strToEmailId As String
            Dim strCCToEmailId As String
            Dim strSubject As String
            Dim strEmailMessage As String
            Dim StrRndNumber As String = CStr(Int(Rnd() * 10))
            Dim strloginName As String = Request.Form("txtFUserID")
            For Counter = 1 To 1 Step 1
                StrRndNumber += StrRndNumber + CStr(Int(Rnd() * 1000))
            Next
            'strbuildpassword = Left$(Request.Form("txtFUserID"), 3) + StrRndNumber
            Dim objCreateNewPassword As New CreateNewPassword()
            strbuildpassword = objCreateNewPassword.CreatePassword()
            ''Password get Encrypted 
            Dim objPW As PWEncryption = New PWEncryption(strloginName, strbuildpassword)
            Dim strEncryptedPW As String = objPW.Encrypt.ToString
            objPW = Nothing
            Dim strmailstatus As String = ""
            Dim m_strvalidemailID As String = ""
            Dim dr As IDataReader
            Dim stremailstatusquery As String = " Exec usp_Sel_GetLoginUserEmailInfo '" + Trim(Request.Form("txtFUserID")) + "'"
            dr = CommonFunctions.Data.GetDataReader(stremailstatusquery, True)
            While dr.Read
                strmailstatus = CommonFunctions.Data.CheckIsDBNull(dr.Item("EmailID"), "").ToString
                strUserName = CommonFunctions.Data.CheckIsDBNull(dr.Item("UserName"), "").ToString
            End While
            CommonFunctions.Data.DisposeDataReader(dr)
            'Response.Write("<input type='hidden' id='hidForgetPassword' value='4'/>")
            ''Added by swapnagandh K
            'Commented and added by Chetan M on 31 Dec 2020 for Incorrect User ID
            'If Trim(Request.Form("txtEmailID").ToString) <> Trim(strmailstatus) Then
            '    Response.Write("<input type='hidden' id='hidForgetPassword' value='4'/>")
            '    Exit Sub
            'End If
            If strmailstatus <> "" Then
                If Trim(Request.Form("txtEmailID").ToString) <> Trim(strmailstatus) Then
                    Response.Write("<input type='hidden' id='hidForgetPassword' value='4'/>")
                    Exit Sub
                End If
            End If
            'End of Commented and added by Chetan M 
            ''end by swapnagandh K
            If Trim(Request.Form("txtFUserID").ToString) <> Trim(strUserName) Then
                Response.Write("<input type='hidden' id='hidForgetPassword' value='2'/>")
                Exit Sub
            End If
            '' If logged used having the EmailID then update his login details
            If strmailstatus.Length <> 0 Then
                strSqlquery = "DECLARE @intReturn INT" + vbCrLf
                ''Added by swapnagandh K
                'strSqlquery += "EXEC usp_upd_password '" + Request.Form("txtFUserID") + "','" + strEncryptedPW.ToString + "'," + "@intReturn OUTPUT" + vbCrLf
                strSqlquery += "EXEC usp_upd_ActivePassword '" + Request.Form("txtFUserID") + "','" + strEncryptedPW.ToString + "'," + "@intReturn OUTPUT" + vbCrLf
                ''end by swapnagandh K
                strSqlquery += "SELECT 'Status' = @intReturn"
                m_strIsValid = CType(CommonFunctions.Data.GetDataScalar(strSqlquery, True), String)
                m_strvalidemailID = "1"
            Else
                strSqlquery = "DECLARE @intReturn INT" + vbCrLf
                strSqlquery += "EXEC usp_sel_validlogin '" + Request.Form("txtFUserID") + "'," + "@intReturn OUTPUT" + vbCrLf
                strSqlquery += "SELECT 'Status' = @intReturn"
                m_strIsValid = CType(CommonFunctions.Data.GetDataScalar(strSqlquery, True), String)
                m_strvalidemailID = "0"
            End If
            ''If logged used is valid and having the EmailID the silent mail has been send to his Email Account
            If m_strIsValid.ToString = "1" And m_strvalidemailID = "1" Then
                Dim strFromEmailId As String
                Dim blnSendMail As Boolean = False
                Dim blnShowPopUp As Boolean = False
                ''Get the details of the Email Subject,Body and other related message details 
                Dim strSQL As String = "usp_Sel_tbl_PM_EmailMessages 443"
                Dim objDr As IDataReader
                Try
                    objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDr.Read Then
                        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                        blnShowPopUp = CType(CommonFunctions.Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(objDr)
                    'Added by Dipali V On 27th Aug 2020 for Reset password Cust
                    Dim strGenratedKey As String
                    Dim strUniuqeID As String
                    Dim strToken As String
                    strUniuqeID = Guid.NewGuid().ToString
                    Dim strGetGenratedKey As String
                    Dim strNewGenUserName As String
                    Dim strNewgenUniuqeID As String
                    ''for UserName
                    strbuildpassword = objCreateNewPassword.CreatePassword()
                    Dim strGenUserName As PWEncryption = New PWEncryption(strUserName, strbuildpassword)
                    strNewGenUserName = strGenUserName.Encrypt.ToString
                    ''for UniqueID
                    Dim strGenUniuqeID As PWEncryption = New PWEncryption(strUniuqeID, strbuildpassword)
                    strNewgenUniuqeID = strGenUniuqeID.Encrypt.ToString
                    ''Key Genrated(UName + PW + Key)
                    strGenratedKey = strNewGenUserName + strEncryptedPW.ToString + strNewgenUniuqeID
                    strGetGenratedKey = strGenratedKey
                    'Call for silent Email
                    Dim logo As String
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessageRes_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword, strGetGenratedKey, logo)
                    Call CommonFunction.Emails.AppSendEmailWithAttachmentCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage, logo)
                    strSQL = "usp_Ins_tbl_PM_ResetPasswordDetails '" + strEncryptedPW.ToString + "','" + strUniuqeID.ToString + "','" + strUserName.ToString + "','" + strGetGenratedKey + "','" + strbuildpassword + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    ''End of Added by Dipali V On 27th Aug 2020 for Reset password Cust 
                    'Call for silent Email
                    'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword)
                    'Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
                    ''On success or failure of login messages are dispalyed
                    Response.Write("<input type='hidden' id='hidForgetPassword' value='1'/>")
                Catch
                    Response.Write("<input type='hidden' id='hidForgetPassword' value='0'/>")
                End Try
                ''Checkes for valid user
            ElseIf m_strIsValid <> "1" Then
                Response.Write("<input type='hidden' id='hidForgetPassword' value='2'/>")
                'check for available EmailID for logged user
            ElseIf m_strvalidemailID = "0" And m_strIsValid = "1" Then
                '' This alert gives message for the login name who don't have Email Account
                Response.Write("<input type='hidden' id='hidForgetPassword' value='3'/>")
            End If
        Catch ex As Exception
            Response.Redirect("Default.aspx")
        End Try
    End Sub
    'Added by Swapnagandha For Mobile Forget password
    Private Sub ReSetPasswordMobile()
        Try
            Dim Counter As Integer
            Dim strbuildpassword As String
            Dim strlogin As String = ""
            Dim strSqlquery As String = ""
            Dim strToEmailId As String = ""
            Dim strCCToEmailId As String = ""
            Dim strSubject As String = ""
            Dim strEmailMessage As String = ""
            Dim StrRndNumber As String = CStr(Int(Rnd() * 10))
            Dim strloginName As String = Request.Form("txtFUserIDMobile")
            For Counter = 1 To 1 Step 1
                StrRndNumber += StrRndNumber + CStr(Int(Rnd() * 1000))
            Next
            'strbuildpassword = Left$(Request.Form("txtFUserID"), 3) + StrRndNumber
            Dim objCreateNewPassword As New CreateNewPassword()
            strbuildpassword = objCreateNewPassword.CreatePassword()
            ''Password get Encrypted 
            Dim objPW As PWEncryption = New PWEncryption(strloginName, strbuildpassword)
            Dim strEncryptedPW As String = objPW.Encrypt.ToString
            objPW = Nothing
            Dim strmailstatus As String = ""
            Dim m_strvalidemailID As String = ""
            Dim dr As IDataReader
            Dim stremailstatusquery As String = " Exec usp_Sel_GetLoginUserEmailInfo '" + Trim(Request.Form("txtFUserIDMobile")) + "'"
            dr = CommonFunctions.Data.GetDataReader(stremailstatusquery, True)
            While dr.Read
                strmailstatus = CommonFunctions.Data.CheckIsDBNull(dr.Item("EmailID"), "").ToString
                strUserName = CommonFunctions.Data.CheckIsDBNull(dr.Item("UserName"), "").ToString
            End While
            CommonFunctions.Data.DisposeDataReader(dr)
            If Trim(Request.Form("txtFUserIDMobile").ToString) <> Trim(strUserName) Then
                Response.Write("<input type='hidden' id='hidForgetPasswordMobile' value='2'/>")
                Exit Sub
            End If
            'Added By swapnagandha K.
            If strmailstatus <> "" Then
                If Trim(Request.Form("txtEmailIDMobile").ToString) <> Trim(strmailstatus) Then
                    Response.Write("<input type='hidden' id='hidForgetPasswordMobile' value='4'/>")
                    Exit Sub
                End If
            End If
            'End By swapnagandha K.
            '' If logged used having the EmailID then update his login details
            If strmailstatus.Length <> 0 Then
                strSqlquery = "DECLARE @intReturn INT" + vbCrLf
                'commented & added by dipali v on 15th Jan 2021 for Reset Pwd 
                ''Added by swapnagandh K
                ''strSqlquery += "EXEC usp_upd_password '" + Request.Form("txtFUserIDMobile") + "','" + strEncryptedPW.ToString + "'," + "@intReturn OUTPUT" + vbCrLf
                strSqlquery += "EXEC usp_upd_ActivePassword '" + Request.Form("txtFUserIDMobile") + "','" + strEncryptedPW.ToString + "'," + "@intReturn OUTPUT" + vbCrLf
                ''end by swapnagandh K
                'End of commented & added by dipali v on 15th Jan 2021 for Reset Pwd 
                strSqlquery += "SELECT 'Status' = @intReturn"
                m_strIsValid = CType(CommonFunctions.Data.GetDataScalar(strSqlquery, True), String)
                m_strvalidemailID = "1"
            Else
                strSqlquery = "DECLARE @intReturn INT" + vbCrLf
                strSqlquery += "EXEC usp_sel_validlogin '" + Request.Form("txtFUserIDMobile") + "'," + "@intReturn OUTPUT" + vbCrLf
                strSqlquery += "SELECT 'Status' = @intReturn"
                m_strIsValid = CType(CommonFunctions.Data.GetDataScalar(strSqlquery, True), String)
                m_strvalidemailID = "0"
            End If
            'added by dipali v on 15th Jan 2021 for Reset Pwd 
            ''If logged used is valid and having the EmailID the silent mail has been send to his Email Account
            If m_strIsValid.ToString = "1" And m_strvalidemailID = "1" Then
                Dim strFromEmailId As String
                Dim blnSendMail As Boolean = False
                Dim blnShowPopUp As Boolean = False
                ''Get the details of the Email Subject,Body and other related message details 
                Dim strSQL As String = "usp_Sel_tbl_PM_EmailMessages 443"
                Dim objDr As IDataReader
                Try
                    objDr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                    If objDr.Read Then
                        blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                        blnShowPopUp = CType(CommonFunctions.Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                    End If
                    CommonFunctions.Data.DisposeDataReader(objDr)
                    ''Call for silent Email
                    'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword)
                    'Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
                    ''End If
                    ''End If
                    '''On success or failure of login messages are dispalyed
                    '''
                    'Added by Dipali V On 27th Aug 2020 for Reset password Cust
                    Dim strGenratedKey As String
                    Dim strUniuqeID As String
                    Dim strToken As String
                    strUniuqeID = Guid.NewGuid().ToString
                    Dim strGetGenratedKey As String
                    Dim strNewGenUserName As String
                    Dim strNewgenUniuqeID As String
                    ''for UserName
                    strbuildpassword = objCreateNewPassword.CreatePassword()
                    Dim strGenUserName As PWEncryption = New PWEncryption(strUserName, strbuildpassword)
                    strNewGenUserName = strGenUserName.Encrypt.ToString
                    ''for UniqueID
                    Dim strGenUniuqeID As PWEncryption = New PWEncryption(strUniuqeID, strbuildpassword)
                    strNewgenUniuqeID = strGenUniuqeID.Encrypt.ToString
                    ''Key Genrated(UName + PW + Key)
                    strGenratedKey = strNewGenUserName + strEncryptedPW.ToString + strNewgenUniuqeID
                    strGetGenratedKey = strGenratedKey
                    'Call for silent Email
                    Dim logo As String
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessageRes_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword, strGetGenratedKey, logo)
                    Call CommonFunction.Emails.AppSendEmailWithAttachmentCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage, logo)
                    strSQL = "usp_Ins_tbl_PM_ResetPasswordDetails '" + strEncryptedPW.ToString + "','" + strUniuqeID.ToString + "','" + strUserName.ToString + "','" + strGetGenratedKey + "','" + strbuildpassword + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, True)
                    ''End of Added by Dipali V On 27th Aug 2020 for Reset password Cust 
                    Response.Write("<input type='hidden' id='hidForgetPasswordMobile' value='1'/>")
                Catch
                    Response.Write("<input type='hidden' id='hidForgetPasswordMobile' value='0'/>")
                End Try
                ''Checkes for valid user
            ElseIf m_strIsValid <> "1" Then
                Response.Write("<input type='hidden' id='hidForgetPasswordMobile' value='2'/>")
                'check for available EmailID for logged user
            ElseIf m_strvalidemailID = "0" And m_strIsValid = "1" Then
                '' This alert gives message for the login name who don't have Email Account
                Response.Write("<input type='hidden' id='hidForgetPasswordMobile' value='3'/>")
            End If
            'End of added by dipali v on 15th Jan 2021 for Reset Pwd 
        Catch ex As Exception
            Response.Redirect("Default.aspx")
        End Try
    End Sub
    'End By Swapnagandha 
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateUserName(ByVal UserName As String)
        Dim strResult As String = ""
        Dim strUniuqeID As String
        Dim strSQL As String
        Try
            '''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            'UserName = Utilities.Security.SecurityBuilder.CheckUserInput(UserName, 2, True, False, False)
            'Dim request = HttpContext.Current.Request
            'Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            '''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strEncryptedUniuqeID As String
            strUniuqeID = Guid.NewGuid().ToString
            strEncryptedUniuqeID = Token.GetUserNameToken(strUniuqeID)
            strResult = strEncryptedUniuqeID
            Dim strToken As String = Token.GetToken(UserName)
            If XMLHttp.m_LoginHashTable.ContainsKey(UserName) Then
                XMLHttp.m_LoginHashTable.Remove(UserName)
            End If
            XMLHttp.m_LoginHashTable.Add(UserName, strUniuqeID)
            Return strResult & "||" & strToken
        Catch ex As Exception
            XMLHttp.m_LoginHashTable = Nothing
            Return strResult
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function CHECKLASTENTEREDPWDS(ByVal LoginName As String, ByVal NewPassword As String, ByVal AuthNo As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
        NewPassword = Utilities.Security.SecurityBuilder.CheckUserInput(NewPassword, 2, True, False, False)
        AuthNo = Utilities.Security.SecurityBuilder.CheckUserInput(AuthNo, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim strResult As String
        Dim strencryptedkey As String = ""
        Dim strencryptedlength As String = ""
        Dim struniqueid As String = ""
        Dim IsValid As Boolean = False
        strencryptedlength = CommonFunctions.General.CheckIsNothing(AuthNo, "0")
        struniqueid = XMLHttp.m_LoginHashTable.Item(LoginName)
        strencryptedkey = NewPassword.Substring(1, strencryptedlength)
        Dim strpwd1 As String() = NewPassword.Split("|")
        NewPassword = ""
        For i As Integer = 0 To strpwd1.Length - 2
            NewPassword &= strpwd1(i).Substring(0, 1)
        Next
        NewPassword = StrReverse(NewPassword)
        Dim objEncryptNewPassword As New Authentication.PWEncryption(LoginName, NewPassword)
        NewPassword = objEncryptNewPassword.Encrypt()
        strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
        CommonFunctions.Data.GetDataScalar("Usp_Check_LastEnteredPwds '" & LoginName & "','" & NewPassword & "'", True)))
        Return strResult
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetPwdChangeDays(ByVal LoginName As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim strLoginName As String
        Dim strResult As String = ""
        strLoginName = CommonFunctions.General.CheckIsNothing(LoginName, "")
        strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
        CommonFunctions.Data.GetDataScalar("Usp_sel_ChangePwd_Days '" & strLoginName & "'", True)))
        Return strResult
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ForcefullyChangePassword(ByVal LoginName As String, ByVal strPassword As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strPassword = Utilities.Security.SecurityBuilder.CheckUserInput(strPassword, 2, True, False, False)
        LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim blnFlgIsFristTimeLogIn As Boolean
        Dim strSQL As String
        Dim strLoginName As String = Replace(CommonFunctions.General.CheckIsNothing(LoginName, ""), "'", "''")
        Dim strPWD As String = Replace(CommonFunctions.General.CheckIsNothing(strPassword, ""), "'", "''")
        ForcefullyChangePassword = "0"
        Dim objPW As PWEncryption = New PWEncryption(strLoginName, strPWD)
        strPWD = objPW.Encrypt.ToString
        objPW = Nothing
        strSQL = "usp_Sel_tbl_PM_Login_Isfirsttimelogin '" + strLoginName + "','" + strPWD + "'"
        blnFlgIsFristTimeLogIn = CType(CommonFunction.Data.GetDataScalar(strSQL, True), Boolean)
        If blnFlgIsFristTimeLogIn = True Then
            ForcefullyChangePassword = "1" 'User has logged in first time
        End If
    End Function
End Class