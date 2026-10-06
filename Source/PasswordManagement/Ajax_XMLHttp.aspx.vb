
Imports System.Xml
Imports WhizTemplate
Imports System.Text
Imports PbNIT
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports Authentication
Imports Whizible.CommonFunction


Public Class Ajax_XMLHttp
    Inherits WebPages.Template.WhizTemplate

#Region "Member Declaration"
    Protected m_strFlag As String = ""
    Protected m_strAction As String = ""
    Protected m_lngProjectID As Long = 0
    Private m_objDTFI As New Globalization.DateTimeFormatInfo
#End Region

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_strFlag = CheckIsNothing(Request.QueryString("Flag"), "")
        m_strAction = CheckIsNothing(Request.QueryString("Action"), "")
        m_lngProjectID = CType(Session("intProjectID"), Long)

        'Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
        If m_strAction.ToUpper = "GETPWDCHANGEDAYS" Then
            Dim strLoginName As String
            Dim strResult As String

            strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("Usp_sel_ChangePwd_Days '" & strLoginName & "'", True)))

            Response.Clear()
            Response.Write(strResult)
            Response.End()
            Exit Sub
        End If

        If m_strAction.ToUpper = "CHECKLASTENTEREDPWDS" Then
            Dim strLoginName As String
            Dim strResult As String
            Dim strNewPwd As String

            Dim strencryptedkey As String = ""
            Dim strencryptedlength As String = ""
            Dim struniqueid As String = ""
            Dim IsValid As Boolean = False
            strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")
            strNewPwd = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("NewPassword"), ""), "")

            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedlength = CommonFunctions.General.CheckIsNothing(Request.QueryString("AuthNo"), "0")
            ''End  Added By Vaijat K ON 24/02/2017 For password encryption
            'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
            'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedkey = strNewPwd.Substring(1, strencryptedlength)

            Dim strpwd1 As String() = strNewPwd.Split("|")
            strNewPwd = ""
            For i As Integer = 0 To strpwd1.Length - 2
                strNewPwd &= strpwd1(i).Substring(0, 1)
            Next
            strNewPwd = StrReverse(strNewPwd)
            ''End Added By Vaijat K ON 24/02/2017 For password encryption

            Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strNewPwd)

            strNewPwd = objEncryptNewPassword.Encrypt()

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("Usp_Check_LastEnteredPwds '" & strLoginName & "','" & strNewPwd & "'", True)))

            Response.Clear()
            Response.Write(strResult)
            Response.End()
            Exit Sub
        End If
        'If m_strAction.ToUpper = "CHECKVALIDUSER" Then
        '    Dim strLoginName As String
        '    Dim strResult As String

        '    strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")

        '    strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
        '    CommonFunctions.Data.GetDataScalar("Usp_Check_Valid_User '" & strLoginName & "'", True)))

        '    Response.Clear()
        '    Response.Write(strResult)
        '    Response.End()
        '    Exit Sub
        'End If
        If m_strAction.ToUpper = "CHECKUPDLOGINDETAILS" Then
            Dim strLoginName As String
            Dim strResult As String
            Dim strPwd As String

            Dim m_strToEmailID As String = ""
            Dim m_strCCEmailID As String = ""
            Dim m_strSubject As String = ""
            Dim m_strMessage As String = ""
            Dim m_strFromEmailID As String = ""
            Dim m_strSendMailTo As String = ""
            Dim drCompanyInfo As IDataReader
            Dim m_blnEnableLockUserID As Boolean = False

            Dim strReturnFlag As String
            Dim strUserIsLocked As String = ""
            Dim strSQL As String = ""
            Dim IsLockedTimeIsOver As String = ""

            Dim strencryptedkey As String = ""
            Dim strencryptedlength As String = ""
            Dim struniqueid As String = ""
            Dim IsValid As Boolean = False
            strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")
            strPwd = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("AuthCR"), ""), "")
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedlength = CommonFunctions.General.CheckIsNothing(Request.QueryString("AuthNo"), "0")
            ''End  Added By Vaijat K ON 24/02/2017 For password encryption
            'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
            'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedkey = strPwd.Substring(1, strencryptedlength)

            IsValid = Token.ValidateUserNameToken(struniqueid, strencryptedkey)
            If (IsValid = False) Then
                Response.Clear()
                Response.Write("2")
                Response.End()
            End If
            Dim strpwd1 As String() = strPwd.Split("|")
            strPwd = ""
            For i As Integer = 0 To strpwd1.Length - 2
                strPwd &= strpwd1(i).Substring(0, 1)
            Next
            strPwd = StrReverse(strPwd)
            ''End  Added By Vaijat K ON 24/02/2017 For password encryption
            strReturnFlag = VallidateLDAPLogin(strLoginName, strPwd)
            Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strPwd)

            strPwd = objEncryptNewPassword.Encrypt()

            'Added(if condition only) By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            If strReturnFlag <> 1 Then
                strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
                CommonFunctions.Data.GetDataScalar("Usp_Check_Upd_User_LoginDetails '" & strLoginName & "','" & strPwd & "'", True)))
            End If

            strUserIsLocked = CheckUser_IsLocked(strLoginName)
            'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login

            drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            drCompanyInfo.Read()

            m_blnEnableLockUserID = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableLockUserID"), "0"), Boolean)

            'Added By Bharat T on 29th-Nov-2016 for Password policy issue fixing
            If strReturnFlag = 1 Then
                If strUserIsLocked = "1" Then
                    strSQL = "Usp_Chk_LockOut_Duration '" & strLoginName & "'"
                    IsLockedTimeIsOver = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "")
                End If
            End If

            If m_blnEnableLockUserID = True And strLoginName <> "ADMIN" Then
                If strReturnFlag = 1 Then
                    If strUserIsLocked = "1" Then
                        If IsLockedTimeIsOver = "1" Then

                        Else
                            strResult = 1
                            Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20031(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strLoginName)
                            Call CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                        End If
                    End If
                Else
                    If strResult = "1" Then
                        Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20031(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strLoginName)
                        Call CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                    End If
                End If
            End If
            'End of Added By Bharat T on 29th-Nov-2016 for Password policy issue fixing
            Response.Clear()
            Response.Write(strResult)
            Response.End()
            Exit Sub
        End If
        If m_strAction.ToUpper = "GETNEWPASSWORD" Then

            Dim strNewPassword As String = ""
            Dim objNewPassowrd As New CreateNewPassword()

            strNewPassword = objNewPassowrd.CreatePassword()

            Response.Clear()
            Response.Write(strNewPassword)
            Response.End()
        End If
        'End of Added By Bharat T on 27th-Oct-2016 for Euronet Password Policy Customization
        'Added By Bharat T on 21st-nov-2016 for Euronet Password Policy Customization
        If m_strAction.ToUpper = "GETCOMPANYINFORMATIONDETAILS" Then
            Dim m_blnEnablePassLength As Boolean = False
            Dim m_intMinPassLen As Integer = 0
            Dim m_intMaxPassLen As Integer = 0
            Dim m_blnEnableAlphaNumSpeChar As Boolean = False
            Dim m_intNumberOfAlpha As Integer = 0
            Dim m_intNumberOfNumerals As Integer = 0
            Dim m_intNumberOfSpecialChars As Integer = 0

            Dim m_blnEnablePassPharsesDays As Boolean = False
            Dim m_intPassPharsesDays As Integer = 0
            Dim m_blnEnablePreviousPassCheck As Boolean = False
            Dim m_intPreviousPassCount As Integer = 0
            Dim m_blnEnablePassLockoutDuration As Boolean = False
            Dim m_intPassLockoutDuration As Integer = 0
            Dim m_blnEnableLockUserID As Boolean = False
            Dim m_intPassLockingCount As Integer = 0
            Dim m_intPassCaptchaCount As Integer = 0
            Dim m_blnIsAutoPasswordCreation As Boolean = False

            Dim m_strPageNote As String
            Dim m_strFirstTimeLoginNote As String
            Dim m_blnAllowSameLoginPwd As Boolean = False
            Dim strAuthenticationType As String
            Dim blnFirstTimeLogin As Boolean
            Dim strResult As String = ""

            Dim drCompanyInfo As IDataReader
            'Get data reader Object    
            Try
                drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drCompanyInfo.Read Then
                    m_blnAllowSameLoginPwd = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("AllowSameLoginPwd"), "0"), Boolean)
                    blnFirstTimeLogin = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableFirstTimeLogin"), "0"), Boolean)
                    m_blnEnablePassLength = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePWDLength"), "0"), Boolean)
                    m_intMinPassLen = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MiniPwdLength"), "0"))
                    m_intMaxPassLen = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("MaxPwdLength"), "0"))
                    m_blnEnableAlphaNumSpeChar = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableAlphaNumSpecialChar"), "0"), Boolean)
                    m_intNumberOfAlpha = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfAlpha"), "0"))
                    m_intNumberOfNumerals = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfNumerals"), "0"))
                    m_intNumberOfSpecialChars = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("NumOfSpecial"), "0"))


                    'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
                    m_blnEnablePassPharsesDays = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassPhrases"), "0"), Boolean)
                    m_intPassPharsesDays = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassPharsesDays"), "0"))
                    m_blnEnablePreviousPassCheck = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePreviousPassCheck"), "0"), Boolean)
                    m_intPreviousPassCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PreviousPassCount"), "0"))
                    m_blnEnablePassLockoutDuration = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnablePassLockoutDuration"), "0"), Boolean)
                    m_intPassLockoutDuration = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockoutDuration"), "0"))
                    m_blnEnableLockUserID = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableLockUserID"), "0"), Boolean)
                    m_intPassLockingCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassLockingCount"), "0"))
                    m_intPassCaptchaCount = CInt(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("PassCaptchaCount"), "0"))
                    'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
                    'Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
                    m_blnIsAutoPasswordCreation = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("IsAutoPasswordCreation"), "0"), Boolean)
                    'End of Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
                End If
                If drCompanyInfo.IsClosed = False Then
                    drCompanyInfo.Close()
                End If
                strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString

                strResult = strAuthenticationType & "$$" & m_blnAllowSameLoginPwd & "$$" & m_blnEnablePassLength & "$$" & m_intMinPassLen & "$$" & m_intMaxPassLen _
                    & "$$" & m_blnEnableAlphaNumSpeChar & "$$" & m_intNumberOfAlpha & "$$" & m_intNumberOfNumerals & "$$" & m_intNumberOfSpecialChars & "$$" &
                    m_blnEnablePreviousPassCheck & "$$" & m_intPreviousPassCount & "$$" & m_blnIsAutoPasswordCreation

                Response.Clear()
                Response.Write(strResult)
                Response.End()

            Catch ex As Exception

            Finally
                If Not drCompanyInfo Is Nothing Then
                    drCompanyInfo.Dispose()
                End If
            End Try
        End If
        'End of Added By Bharat T on  21st-nov-2016 for Euronet Password Policy Customization
        'Added By Bharat T on 29th-Nov-2016 for Password policy issue fixing
        If m_strAction.ToUpper = "CHECKOLDNEWPWD" Then
            Dim strSQL As String = ""
            Dim strResult As String = ""
            Dim strLoginName As String
            Dim strNewPwd As String

            strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")
            strNewPwd = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("NewPassword"), ""), "")

            Dim strencryptedkey As String = ""
            Dim strencryptedlength As String = ""
            Dim struniqueid As String = ""
            Dim IsValid As Boolean = False
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedlength = CommonFunctions.General.CheckIsNothing(Request.QueryString("AuthNo"), "0")
            ''End  Added By Vaijat K ON 24/02/2017 For password encryption
            'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
            'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedkey = strNewPwd.Substring(1, strencryptedlength)


            Dim strpwd1 As String() = strNewPwd.Split("|")
            strNewPwd = ""
            For i As Integer = 0 To strpwd1.Length - 2
                strNewPwd &= strpwd1(i).Substring(0, 1)
            Next
            strNewPwd = StrReverse(strNewPwd)
            ''End Added By Vaijat K ON 24/02/2017 For password encryption

            Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strNewPwd)

            strNewPwd = objEncryptNewPassword.Encrypt()

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("Usp_Chk_Old_New_Password '" & strLoginName & "','" & strNewPwd & "'", True)))

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        'End of Added By Bharat T on 30th-Nov-2016 for Password policy issue fixing
        'Added By Bharat T on 29th-Nov-2016 for Password policy issue fixing
        If m_strAction.ToUpper = "CHECKISLOCKED" Then
            Dim strResult As String = ""
            Dim strLoginName As String = ""

            strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")
            strResult = CheckUser_IsLocked(strLoginName)

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        'End of Added By Bharat T on 30th-Nov-2016 for Password policy issue fixing
        ''Added B y Nikhil A on 29-May-2020 for Checking the duplicate Login NAME
        If m_strAction.ToUpper = "CHECKDUPLICATELOGIN" Then
            Dim strLoginName As String
            Dim strResult As String = ""
            strLoginName = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(Request.QueryString("LoginName"), ""), "")

            strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(
            CommonFunctions.Data.GetDataScalar("usp_chk_DuplicateLoginName '" & strLoginName & "'", True)))

            Response.Clear()
            Response.Write(strResult)
            Response.End()
        End If
        ''End of added By Nikhil A on 29-May-2020 for Checking the duplicate Login NAME
    End Sub
    Protected Function CheckUser_IsLocked(strLoginName) As String
        Dim strSQL As String = ""
        Dim strResult As String = ""

        strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
       CommonFunctions.Data.GetDataScalar("Usp_Chk_User_IsLocked '" & strLoginName & "'", True), ""), "")

        CheckUser_IsLocked = strResult
    End Function
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
        ' Author				:	Bharat T.
        ' Created				:	30 Nov 2016
        ' Revisions				:	
        '=====================================================================
        ' ***********************************************************************************
        ' Added Oct 18,2004 Rajanikant R.No:WAF2_GEN_1 & WAF2_GEN_2
        ' ***********************************************************************************
        'If m_blnIsWindowsAuthenticated Then
        '    ' if the user is valid
        '    Return 1
        'End If

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

    'Added By Bharat T on 17th-May-2017 for Password Policy for Responsive View
    ''Added by YOgesh Jalamkar on 02-May-2017 Purpose : Helpdesk Login Page
    <System.Web.Services.WebMethod()>
    Public Shared Function CheckUpdLoginDetails(ByVal LoginName As String, ByVal AuthCR As String, ByVal AuthNo As String)

        Dim strLoginName As String
        Dim strResult As String = ""
        Dim strPwd As String

        Dim m_strToEmailID As String = ""
        Dim m_strCCEmailID As String = ""
        Dim m_strSubject As String = ""
        Dim m_strMessage As String = ""
        Dim m_strFromEmailID As String = ""
        Dim m_strSendMailTo As String = ""
        Dim drCompanyInfo As IDataReader
        Dim m_blnEnableLockUserID As Boolean = False

        Dim strReturnFlag As String
        Dim strUserIsLocked As String = ""
        Dim strSQL As String = ""
        Dim IsLockedTimeIsOver As String = ""

        Dim strencryptedkey As String = ""
        Dim strencryptedlength As String = ""
        Dim struniqueid As String = ""
        Dim IsValid As Boolean = False
        Dim objAjax_XMLHttp As New Ajax_XMLHttp()
        '''Added by Ajit L  on 25/11/2025 for Rate Limiting for Login  
        'Call ApplySecurity to invoke RateLimit logic from Template Solution
        objAjax_XMLHttp.ApplySecurity(True)
        ''End of Added by Ajit L  on 25/11/2025 for Rate Limiting for Login  
        ''Added By Nikhil Adkar on 28-Apr-2026 for SQL Injection in Login Page
        LoginName = Utilities.Security.SecurityBuilder.CheckUserInput(LoginName, 2, True, False, False)
        ''End of Added By Nikhil Adkar on 28-Apr-2026 for SQL Injection 
        Try
        Dim request = HttpContext.Current.Request
            Dim response = HttpContext.Current.Response
            ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page

            AuthCR = Utilities.Security.SecurityBuilder.CheckUserInput(AuthCR, 2, True, False, False)
            AuthNo = Utilities.Security.SecurityBuilder.CheckUserInput(AuthNo, 2, True, False, False)

            ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page

            ' Call rate limiter
            ''Added By Nikhil Adkar on 28-Apr-2026 for SQL Injection in Login Page
            If CommonFunction.RateLimiter.CheckRateLimit(request) Then
                response.StatusCode = 429
                response.Write("Bad Request found")
                'response.End()
                Return response
            End If
            ''End of Added By Nikhil Adkar on 28-Apr-2026 for SQL Injection 
            strLoginName = CommonFunctions.General.CheckIsNothing(LoginName, "")
            strPwd = CommonFunctions.General.CheckIsNothing(AuthCR, "")
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedlength = CommonFunctions.General.CheckIsNothing(AuthNo)
            ''End  Added By Vaijat K ON 24/02/2017 For password encryption
            'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            struniqueid = XMLHttp.m_LoginHashTable.Item(strLoginName)
            'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            ''Added By Vaijat K ON 24/02/2017 For password encryption
            strencryptedkey = strPwd.Substring(1, strencryptedlength)

            IsValid = Token.ValidateUserNameToken(struniqueid, strencryptedkey)
            If (IsValid = False) Then
                strResult = "2"
            End If
            Dim strpwd1 As String() = strPwd.Split("|")
            strPwd = ""
            For i As Integer = 0 To strpwd1.Length - 2
                strPwd &= strpwd1(i).Substring(0, 1)
            Next
            strPwd = StrReverse(strPwd)
            ''End  Added By Vaijat K ON 24/02/2017 For password encryption

            strReturnFlag = objAjax_XMLHttp.VallidateLDAPLogin(strLoginName, strPwd)
            Dim objEncryptNewPassword As New Authentication.PWEncryption(strLoginName, strPwd)

            strPwd = objEncryptNewPassword.Encrypt()

            'Added(if condition only) By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
            If strReturnFlag <> 1 Then
                strResult = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull( _
                CommonFunctions.Data.GetDataScalar("Usp_Check_Upd_User_LoginDetails '" & strLoginName & "','" & strPwd & "'", True)))
            End If

            strUserIsLocked = objAjax_XMLHttp.CheckUser_IsLocked(strLoginName)
            'End of Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login

            drCompanyInfo = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            drCompanyInfo.Read()

            m_blnEnableLockUserID = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInfo("EnableLockUserID"), "0"), Boolean)

            'Added By Bharat T on 29th-Nov-2016 for Password policy issue fixing
            If strReturnFlag = 1 Then
                If strUserIsLocked = "1" Then
                    strSQL = "Usp_Chk_LockOut_Duration '" & strLoginName & "'"
                    IsLockedTimeIsOver = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSQL, True), "")
                End If
            End If

            If m_blnEnableLockUserID = True And strLoginName <> "ADMIN" Then
                If strReturnFlag = 1 Then
                    If strUserIsLocked = "1" Then
                        If IsLockedTimeIsOver = "1" Then

                        Else
                            strResult = "1"
                            Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20031(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strLoginName)
                            Call CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                        End If
                    End If
                Else
                    If strResult = "1" Then
                        Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20031(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strLoginName)
                        Call CommonFunction.Emails.AppSendEmailWithCC(m_strToEmailID, m_strCCEmailID, m_strFromEmailID, m_strSubject, m_strMessage)
                    End If
                End If
            End If
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
        'End of Added By Bharat T on 29th-Nov-2016 for Password policy issue fixing


    End Function
    'End of Added By Bharat T on 17th-May-2017 for Password Policy for Responsive View
End Class