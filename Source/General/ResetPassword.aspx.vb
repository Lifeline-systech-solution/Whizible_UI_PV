Imports System.Globalization
Imports System.Threading
Imports System.Text
Imports System.Xml
Imports PbNIT
Imports Authentication
'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
Imports System.Web
Imports System.Web.Security
Public Class WebForm1
    Inherits WebPage.Templates.WhizTemplate
    Protected strLogo As String = ""
    Protected IsActivetoken As String = "0"
    Public Link As String
    'PassWordPolicy
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
    Public strAuthenticationType As String
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
    Protected m_blnEnableCaptcha As Boolean = False
    Protected M_AutoServiceID As String = ""
    Public blnFirstTimeLogin As Boolean = False
    Public blnShowVirtualKeyboard As Boolean = False
    Public blnEnablePwdOnReset As Boolean = False
    'End of PassWordPolicy
    Public strbuildpassword As String
    'Public globalUserName As String
    Protected globalUserName As String = ""
    Protected strOldPassword As String = ""
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        Dim strQuery As String
        Dim IntLoginID As String
        Dim EmployeeID As String
        Dim CustomerID As String
        Dim LoginID As String
        Dim UserID As String
        Dim LoginType As String
        Dim UniqueKey As String
        Dim GenaratedKey As String
        Dim Password As String
        Dim PwdLenght As String
        Dim dr As IDataReader
        Dim QuerystrGenratedKey As String
        Dim strUserName As String
        ' Dim Link As String
        Dim stOriginHost As String
        Dim strVirtutalDirectoryName As String
        Dim CreatedDate As String
        Dim IsSameDay As String
        strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString
        'strLogin = CommonFunction.General.DecryptString(Request.QueryString("SWC"))
        MyBase.InitializeResources("AppResources.Default", "AppResources")
        IntLoginID = CommonFunction.General.DecryptString(Request.QueryString("MSID"))
        'strbuildpassword = Request.QueryString("strbuildpassword")
        QuerystrGenratedKey = Request.QueryString("Key")
        stOriginHost = CommonFunctions.General.GetApplicationKeySetting("HostName").ToString
        strVirtutalDirectoryName = CommonFunction.General.GetApplicationKeySetting("VirtualDirectoryName").ToString
        ''Commented and Modified by Nikhil A on 12-march-2020 for Send Email issue on forget Password in Denail of Service attack
        If HttpContext.Current.Request.IsSecureConnection Then
            Link = "https://" & stOriginHost.ToString & "/" & strVirtutalDirectoryName & "/Default.aspx"
        Else
            Link = "http://" & stOriginHost.ToString & "/" & strVirtutalDirectoryName & "/Default.aspx"
        End If
        ''Link = "http://" & stOriginHost.ToString & "/" & strVirtutalDirectoryName & "/Default.aspx"
        ''End of commnetd and Modified by Nikhil A on 12-march-2020 for Send Email issue on forget Password in Denail of Service attack
        strQuery = " EXEC usp_Sel_GetCompanyInfo"
        dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While dr.Read
            strLogo = CommonFunctions.Data.CheckIsDBNull(dr.Item("SystemFileName"), "").ToString
        End While
        CommonFunctions.Data.DisposeDataReader(dr)
        Dim IsLinkUsed As String = "0"
        strQuery = "usp_CheckLinkAccess " & IntLoginID & ""
        IsLinkUsed = CommonFunctions.Data.GetDataScalar(strQuery, True)
        strQuery = "EXEC usp_Sel_ValidateToken " & IntLoginID & ""
        dr = CommonFunctions.Data.GetDataReader(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While dr.Read
            IsActivetoken = "1"
            UniqueKey = CommonFunctions.Data.CheckIsDBNull(dr.Item("UniqueKey"), "").ToString
            GenaratedKey = CommonFunctions.Data.CheckIsDBNull(dr.Item("GenaratedKey"), "").ToString
            strUserName = CommonFunctions.Data.CheckIsDBNull(dr.Item("LoginName"), "").ToString
            Password = CommonFunctions.Data.CheckIsDBNull(dr.Item("Password"), "").ToString
            LoginID = CommonFunctions.Data.CheckIsDBNull(dr.Item("LoginID"), "").ToString
            LoginType = CommonFunctions.Data.CheckIsDBNull(dr.Item("LoginType"), "").ToString
            EmployeeID = CommonFunctions.Data.CheckIsDBNull(dr.Item("EmployeeID"), "").ToString
            CustomerID = CommonFunctions.Data.CheckIsDBNull(dr.Item("CustomerID"), "").ToString
            PwdLenght = CommonFunctions.Data.CheckIsDBNull(dr.Item("PwdLenght"), "").ToString
            CreatedDate = CommonFunctions.Data.CheckIsDBNull(dr.Item("CreatedDate"), "").ToString
            IsSameDay = CommonFunctions.Data.CheckIsDBNull(dr.Item("IsSameDay"), "").ToString
        End While
        strPassword = Password
        globalUserName = strUserName
        strbuildpassword = PwdLenght
        Dim drloginInfo As IDataReader
        drloginInfo = CommonFunction.Data.GetDataReader("usp_cus_getlogindetails '" + CommonFunctions.General.CheckIsNothing(globalUserName, "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drloginInfo.Read Then
            strOldPassword = Trim(drloginInfo("Password").ToString)
        End If
        'strEncryptedOldPassword = strOldPassword
        'Dim objDecOldPassword As New Authentication.PWEncryption(globalUserName, strOldPassword,)
        strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString 'Added By ShrikantB On 02-SEP-2010 For Password Policy
        strCompanyName = CommonFunction.Application.CompanyNames
        strProductVersion = CommonFunction.Application.ProductVersions
        strShowPasswordLinks = CommonFunction.Application.IsShowPasswordLinks
        strCompanyDetails = CommonFunction.Application.DefaultDataOfPage
        strShortCompanyName = CommonFunction.Application.ShortCompanyNames
        M_AutoServiceID = CommonFunction.Application.IsAutoServiceForPassword.ToString
        Dim drCompanyInfo As IDataReader
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
            'strCompanyLogo = CommonFunction.Data.CheckIsDBNull(drCompanyInfo("SystemFileName"), "")
        End If
        If drCompanyInfo.IsClosed = False Then
            drCompanyInfo.Close()
        End If
        Dim m_strMode As String
        m_strMode = HttpUtility.HtmlEncode(Request.QueryString("Mode"))
        If IsLinkUsed = "1" And m_strMode <> "" Then
            IsActivetoken = "1"
            Try
                If IsActivetoken = "1" Then
                    If LoginType = "C" Then
                        UserID = CustomerID
                    Else
                        UserID = EmployeeID
                    End If
                    Dim NewstrValidateKey As String
                    'Dim NewstrValidateKey As String
                    'strGetGenratedKey = strUserName + Password.ToString + UniqueKey
                    'Dim NewstrGenratedKey As PWEncryption = New PWEncryption(strGetGenratedKey, strbuildpassword)
                    'NewstrValidateKey = NewstrGenratedKey.Encrypt.ToString
                    Dim strNewGenUserName As String
                    Dim strNewgenUniuqeID As String
                    ''for UserName
                    Dim strGenUserName As PWEncryption = New PWEncryption(strUserName, PwdLenght)
                    strNewGenUserName = strGenUserName.Encrypt.ToString
                    ''for UniqueID
                    Dim strgenUniuqeID As PWEncryption = New PWEncryption(UniqueKey, PwdLenght)
                    strNewgenUniuqeID = strgenUniuqeID.Encrypt.ToString
                    ''Key Genrated(UName + PW + Key)
                    'Dim source As String = QuerystrGenratedKey
                    'For index As Integer = 0 To 2
                    '    If index = 0 Then
                    '        strNewGenUserName = source.Substring(0, 8)
                    '    ElseIf index = 2 Then
                    '        strNewgenUniuqeID = source.Substring(17, QuerystrGenratedKey.Length)
                    '    End If
                    'Next
                    NewstrValidateKey = strNewGenUserName + Password.ToString + strNewgenUniuqeID
                    If IsSameDay = "1" Then
                        If QuerystrGenratedKey = NewstrValidateKey Then
                            If m_strMode <> "" Then
                                strQuery = "usp_Upd_tbl_PM_ResetPasswordDetails " & IntLoginID & ""
                                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                            End If
                        Else
                            IsActivetoken = "0"
                        End If
                    Else
                        IsActivetoken = "0"
                    End If
                Else
                    IsActivetoken = "0"
                End If
                Select Case m_strMode
                    Case "ResetPassword"
                        SetPassword()
                        'strQuery = "usp_Upd_tbl_PM_ResetPasswordDetails " & IntLoginID & ""
                        'CommonFunctions.Data.InsertOrUpdateData(strQuery, True)
                End Select
            Catch ex As Exception
                Response.Redirect(Link)
            End Try
        ElseIf IsLinkUsed = "1" Then
            IsActivetoken = "0"
        ElseIf IsLinkUsed = "0" Then
            IsActivetoken = "1"
        End If
    End Sub
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
        ' Author                :Dipali V
        ' Created               :4th Jan 2020
        ' Revisions             :
        '=====================================================================
        'Encrypt the password
        'Dim strOldPassword As String = strPassword
        Dim strNewPassword As String = Request.Form("txtNewPassword")
        Dim strCount As String = ValidateUserName(globalUserName)
        Dim strencryptedkey As String = ""
        Dim strencryptedlength As String = ""
        Dim struniqueid As String = ""
        Dim IsValid As Boolean = False
        ' struniqueid = XMLHttp.m_LoginHashTable.Item(Request.Form("txtLoginName"))
        'Dim stringlenght As Integer = strCount.Length
        'strencryptedkey = strNewPassword.Substring(1, stringlenght)
        Dim strpwd1 As String() = strNewPassword.Split("|")
        strNewPassword = ""
        For i As Integer = 0 To strpwd1.Length - 2
            strNewPassword &= strpwd1(i).Substring(0, 1)
        Next
        strNewPassword = StrReverse(strNewPassword)
        'Dim strpwd2 As String() = strOldPassword.Split("|")
        ''strOldPassword = ""
        'For i As Integer = 0 To strpwd2.Length - 2
        '    strOldPassword &= strpwd2(i).Substring(0, 1)
        'Next
        'strOldPassword = StrReverse(strOldPassword)
        ' Dim objEncryptOldPassword As New Authentication.PWEncryption(globalUserName, strOldPassword)
        Dim objEncryptNewPassword As New Authentication.PWEncryption(globalUserName, strNewPassword)
        Dim strEncryptedOldPassword As String
        Dim strEncryptedNewPassword As String
        Dim strSQL As String
        Dim drloginInfo As IDataReader
        drloginInfo = CommonFunction.Data.GetDataReader("usp_cus_getlogindetails '" + CommonFunctions.General.CheckIsNothing(globalUserName, "") + "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drloginInfo.Read Then
            strOldPassword = Trim(drloginInfo("Password").ToString)
        End If
        ' strEncryptedOldPassword = objEncryptOldPassword.Encrypt()
        strEncryptedOldPassword = strOldPassword
        strEncryptedNewPassword = objEncryptNewPassword.Encrypt()
        objEncryptNewPassword = Nothing
        Dim m_strStatus As String
        strSQL = "DECLARE @intReturn INT" + vbCrLf
        strSQL += "EXEC usp_ChangePassword '" + globalUserName + "', '" + strEncryptedOldPassword + "','" + strEncryptedNewPassword + "', " + "@intReturn OUTPUT" + vbCrLf
        strSQL += "SELECT 'Status' = @intReturn"
        m_strStatus = CType(CommonFunction.Data.GetDataScalar(strSQL, True), String)
        If (m_strStatus = "1") Then
            strSQL = "EXEC usp_Upd_ChangeIsloginforfirsttime_False '" + CommonFunctions.General.CheckIsNothing(globalUserName, "") + "','" + strEncryptedNewPassword + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        End If
        Response.Write("<input type='hidden' id='hidChangePassword' value='" & m_strStatus & "'/>")
        'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, globalUserName, strNewPassword)
        'Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
        If (m_strStatus = 1) Then
            Link = Link & "?ResetPwd=" & m_strStatus & ""
            Response.Redirect(Link)
        Else
        End If
    End Sub
    Public Function ValidateUserName(ByVal UserName As String)
        Dim strResult As String = ""
        Dim strUniuqeID As String
        Dim strSQL As String
        Try
            Dim strEncryptedUniuqeID As String
            strUniuqeID = Guid.NewGuid().ToString
            strEncryptedUniuqeID = Token.GetUserNameToken(strUniuqeID)
            strResult = strEncryptedUniuqeID
            Dim strToken As String = Token.GetToken(UserName)
            If XMLHttp.m_LoginHashTable.ContainsKey(UserName) Then
                XMLHttp.m_LoginHashTable.Remove(UserName)
            End If
            XMLHttp.m_LoginHashTable.Add(UserName, strUniuqeID)
            Return strResult
        Catch ex As Exception
            XMLHttp.m_LoginHashTable = Nothing
            Return strResult
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ValidateUName(ByVal UserName As String)
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            UserName = Utilities.Security.SecurityBuilder.CheckUserInput(UserName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strResult As String = ""
            Dim strUniuqeID As String
        Dim strSQL As String
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
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetEncyNewPwd(ByVal strNewPass As String, ByVal UserName As String)
        Try
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            strNewPass = Utilities.Security.SecurityBuilder.CheckUserInput(strNewPass, 2, True, False, False)
            UserName = Utilities.Security.SecurityBuilder.CheckUserInput(UserName, 2, True, False, False)
            Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
            'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
            '    response.StatusCode = 429
            '    response.Write("Bad Request found")
            '    Return "Bad Request found"
            'End If
            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
            Dim strResult As String = ""
            Dim objEncryptNewPassword As New Authentication.PWEncryption(UserName, strNewPass)
            Dim strEncryptedNewPassword As String
            strEncryptedNewPassword = objEncryptNewPassword.Encrypt()
            Return strEncryptedNewPassword
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
End Class