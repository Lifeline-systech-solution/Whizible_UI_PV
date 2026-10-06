Imports CommonFunctions.General 'Added By Bharat T on 26th-Oct-2016 for Euronet Customization
Public Class SM_ChangePassword
    Inherits WebPages.Template.WhizTemplate

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

    '=====================================================================
    ' Page Name             : PM_ChangePassword
    ' Purpose               : To change the password of the user
    ' Description           : This page is called from the Default.aspx page
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js, CommonValidations.js
    ' Author                : AbhijeetD
    ' Created               : 17th March 2004
    ' Revisions             : 
    '=====================================================================

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

    Private m_strLoginName As String = ""
    Private m_strPassword As String = ""
    Private m_strMode As String = ""
    Private m_strStatus As String = ""

    'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    'Added By ShrikantB On 06-SEP-2010 For Password Policy 
    Private m_strPageNote As String
    Private m_strFirstTimeLoginNote As String
    Public m_blnAllowSameLoginPwd As Boolean = False
    Public strAuthenticationType As String
    Public blnFirstTimeLogin As Boolean
    'Addition End By ShrikantB On 06-SEP-2010 For Password Policy 
    ''  Added by SujitG on 03 Sep 2010
    Public m_blnEnablePassLength As Boolean = False
    Public m_intMinPassLen As Integer = 0
    Public m_intMaxPassLen As Integer = 0
    Public m_blnEnableAlphaNumSpeChar As Boolean = False
    Public m_intNumberOfAlpha As Integer = 0
    Public m_intNumberOfNumerals As Integer = 0
    Public m_intNumberOfSpecialChars As Integer = 0
    'Public m_blnAllowSameLoginPwd As Boolean = True
    ''  End of addition by SujitG on 03 Sep 2010
    Public m_blnEnablePassPharsesDays As Boolean = False
    Public m_intPassPharsesDays As Integer = 0
    Public m_blnEnablePreviousPassCheck As Boolean = False
    Public m_intPreviousPassCount As Integer = 0
    Public m_blnEnablePassLockoutDuration As Boolean = False
    Public m_intPassLockoutDuration As Integer = 0
    Public m_blnEnableLockUserID As Boolean = False
    Public m_intPassLockingCount As Integer = 0
    Public m_intPassCaptchaCount As Integer = 0
    'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Commented and Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
        'm_strLoginName = Request.QueryString("LoginName")
        'm_strPassword = Request.QueryString("Password")
        'm_strMode = Request.QueryString("Mode")

        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        m_strLoginName = HttpUtility.HtmlEncode(Request.QueryString("LoginName"))
        m_strPassword = HttpUtility.HtmlEncode(Request.QueryString("Password"))
        m_strMode = HttpUtility.HtmlEncode(Request.QueryString("Mode"))
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
            End If
            If drCompanyInfo.IsClosed = False Then
                drCompanyInfo.Close()
            End If
            strAuthenticationType = CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString
        Catch ex As Exception
            Err.Raise(Err.Number, "SM_ChangePassword->Page_Load", ex.Message)
        Finally
            If Not drCompanyInfo Is Nothing Then
                drCompanyInfo.Dispose()
            End If
        End Try
        'End of Commented and  Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

    End Sub

    Public Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit
        ' Purpose               : Entry to the page
        ' Description           : Called from within the <Form> Tag
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 17th March 2004
        ' Revisions             :
        '=====================================================================
        If MyBase.Page.IsPostBack Then
            Select Case m_strMode
                Case "SetPassword"
                    SetPassword()
            End Select
        End If

        'Plot the page
        DrawPage()
    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        'Commented and Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
        'MyBase.ApplySecurity(True)
        MyBase.ApplySecurity(True, 2, True, True, True)
        'End of Commented and Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

        'End of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.SM_ChangePassword", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Change Password -> Invalid Input" + UserInput + Cause
        Throw ex
    End Sub

    Private Sub DrawPage()
        '=====================================================================
        ' Procedure Name        : DrawPage
        ' Purpose               : Renders the UI
        ' Description           : This function generates the html for the page
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 17th March 2004
        ' Revisions             :
        '=====================================================================

        Dim strMenu As String

        Select Case m_strMode
            Case "SetPassword"
                Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
                If (m_strStatus = "1") Then
                    'password changed successfully.
                    'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunction.General.WriteHTML("<TABLE class=clsTABLE Width='99.9%' Height='100%'>")
                    'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

                    'Added By Bharat T on 28th-Oct-2016 for Euronet Password Policy Customization
                    If CheckIsNothing(Request.QueryString("FirstTimeLogin")) = "1" Then
                        CommonFunction.General.WriteHTML("<TR><TD align=Center class=clsTDGroupFooter><B>" + MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY") + ".</B><p><B>Do You Want To Login,<a href='#' onclick='LoginAgain_OnClick();' >Click Here </a></B></p></TD></TR>")
                    Else
                        CommonFunction.General.WriteHTML("<TR><TD align=Center class=clsTDGroupFooter><B>" + MyBase.GetResourceString("PASSWORD_HAS_BEEN_CHANGED_SUCCESSFULLY") + ".</B></TD></TR>")
                    End If

                    'CommonFunction.General.WriteHTML("<TR><TD align=Center class=clsTDGroupFooter></TD></TR></TABLE>")
                    'End of Added By Bharat T on 28th-Oct-2016 for Euronet Password Policy Customization
                Else
                    'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunction.General.WriteHTML("<TABLE class=clsTABLE Width='99.9%' Height='100'")
                    'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    CommonFunction.General.WriteHTML("<TR><TD align=center class=clsTDGroupFooter><B>" + MyBase.GetResourceString("INVALID_LOGIN_NAME") + "!!!</B></TD></TR>")
                    CommonFunction.General.WriteHTML("<TR><TD align=center class=clsTDGroupFooter><B>" + MyBase.GetResourceString("TRY_AGAIN") + "!!!</B></TD></TR></TABLE>")
                End If
                Response.Write("</DIV>")

            Case Else
                'Render the Top Menu
                strMenu = DrawMenu()
                Response.Write(strMenu + "<br>")

                'Render the PageCaption
                CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , True))
                'CommonFunction.General.WriteHTML("<BR>")

                'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
                'Render note for first time login
                Dim strFirstTimeLogin As String = CheckIsNothing(Request.QueryString("FirstTimeLogin"))
                If strFirstTimeLogin = "1" Then
                    m_strPageNote = MyBase.GetResourceString("PAGE_NOTE")
                    'Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
                    'm_strFirstTimeLoginNote = MyBase.GetResourceString("FIRST_TIME_LOGIN_CHANGE_PASSWORD_NOTE")
                    m_strFirstTimeLoginNote = "You are login first time or your password has been reset/expired, As per password policy you are enforced to Change Password "
                    'End of Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
                    WriteHTML("<TABLE  Width='100%' cellspacing=0 class=clsTable><TR class=clsTRPageHeader><TD><STRONG>")
                    WriteHTML(m_strPageNote)
                    WriteHTML("</STRONG><FONT class=font0>")
                    WriteHTML(m_strFirstTimeLoginNote)
                    WriteHTML(":</FONT></TD></TR></TABLE><BR>")
                End If
                'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

                Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
                DrawUIControls()
                Response.Write("</DIV>")

                'Render the Bottom Menu
                ''Commented and Added by Dhanashri S on 4 Dec 2015
                ''Response.Write("<br>" + strMenu) 
                Response.Write(strMenu)

                'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
                CheckFirsttimelogin()
                'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization

                ''End of Comment and Addition by Dhanashri S 
        End Select

    End Sub

    Private Sub DrawUIControls()
        '=====================================================================
        ' Procedure Name        : DrawUIControls
        ' Purpose               : Renders the UI controls for getting input values
        ' Description           : None
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 17th March 2004
        ' Revisions             :
        '=====================================================================
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<TABLE class='clsTable' width='99.9%' cellspacing=0 cellpadding=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right' noWrap valign='top'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LOGIN_NAME"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
        'Render the Loin Name textbox
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        ''Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'CommonFunction.HTMLControls.DrawTextBox("txtLoginName", "txtLoginName", , 100, 30, , , , , , , , , , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtLoginName", "txtLoginName", , 150, 30, , , , , , , , "autocomplete='off'", , True, EnableHTMLEncode:=True)
        ''End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        'Render the Old Password textbox
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right' noWrap valign='top'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("OLD_PASSWORD"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        ''Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'CommonFunction.HTMLControls.DrawTextBox("txtOldPassword", "txtOldPassword", , 100, 30, , , , , , , , , , True, , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtOldPassword", "txtOldPassword", , 150, 30, , , , , , , , "autocomplete='off'", , True, , True, EnableHTMLEncode:=True)
        ''End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        'Render the New Password textbox
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right' noWrap valign='top'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("NEW_PASSWORD"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        ''Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'CommonFunction.HTMLControls.DrawTextBox("txtNewPassword", "txtNewPassword", , 100, 30, , , , , , , , , , True, , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtNewPassword", "txtNewPassword", , 150, 30, , , , , , , , "autocomplete='off'", , True, , True, EnableHTMLEncode:=True)
        ''End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        'Render the Confirm Password textbox
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right' noWrap valign='top'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("CONFIRM_PASSWORD"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        ''Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'CommonFunction.HTMLControls.DrawTextBox("txtConfirmPassword", "txtConfirmPassword", , 100, 30, , , , , , , , , , True, , True, EnableHTMLEncode:=True)
        CommonFunction.HTMLControls.DrawTextBox("txtConfirmPassword", "txtConfirmPassword", , 150, 30, , , , , , , , , , True, , True, EnableHTMLEncode:=True)
        ''End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</TABLE>")
        ''Commented and added by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization
        CommonFunction.General.WriteHTML("<TABLE class='clsTable' width='99.9%' cellspacing=0 cellpadding=0>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='middle' noWrap valign='top'>")
        CommonFunction.General.WriteHTML("<label id=lblError></label>")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</TABLE>")
        ''End of addition by Yogesh Jalamkar on 27-OCT-2016 Purpose:Euronet Customization

    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : AbhijeetD
        ' Created               : 24th Feb, 2004   
        ' Revisions             :
        '=====================================================================
        MyBase.InitializeResources("AppResources.SM_ChangePassword", "AppResources")
        'Comment and modification by SuchitraP on 11-Mar-2009 for IssueID 28369 for Whiziblesem7.2
        'Purpose :  After clicking on help link it throws session expired error,so help link removed
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrClientSideFunctions() As String = {"SetPassword_OnClick()", "Close_OnClick()", "Help_OnClick('ChangePassword')"}
        'Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        'Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenu() As String = {"Change Password"}
        Dim arrMenuToolTip() As String = {"Change Password"}
        'End of Commented and Added By Bharat T on 9th-Nov-2016 for Master card Pwd policy Integration

        Dim arrClientSideFunctions() As String = {"SetPassword_OnClick()"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        'End of comment and modification by SuchitraP

        Return (strMenu)

    End Function

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

        Dim strOldPassword As String = MyBase.GetFormValue("txtOldPassword")
        Dim strNewPassword As String = MyBase.GetFormValue("txtNewPassword")
        Dim strCount As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("NonDatabase3"))
        Dim strencryptedkey As String = ""
        Dim strencryptedlength As String = ""
        Dim struniqueid As String = ""
        Dim IsValid As Boolean = False


        'Added By Bharat T on 30th-Nov-2016 for Euronet Pwd Policy Changes For Checking LDAP Login
        struniqueid = XMLHttp.m_LoginHashTable.Item(MyBase.GetFormValue("txtLoginName"))
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


        Dim objEncryptOldPassword As New Authentication.PWEncryption(MyBase.GetFormValue("txtLoginName"), strOldPassword)
        Dim objEncryptNewPassword As New Authentication.PWEncryption(MyBase.GetFormValue("txtLoginName"), strNewPassword)
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
        strSQL += "EXEC usp_ChangePassword '" + MyBase.GetFormValue("txtLoginName") + "', '" + strEncryptedOldPassword + "','" + strEncryptedNewPassword + "', " + "@intReturn OUTPUT" + vbCrLf
        strSQL += "SELECT 'Status' = @intReturn"

        m_strStatus = CType(CommonFunction.Data.GetDataScalar(strSQL, m_blnUseSQL), String)
        'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
        'Added By ShrikantB On 06-SEP-2010 For Password Policy
        If (m_strStatus = "1") Then
            strSQL = "EXEC usp_Upd_ChangeIsloginforfirsttime_False '" + CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtLoginName")) + "','" + strEncryptedNewPassword + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
        End If
        'Addition End By ShrikantB On 06-SEP-2010 For Password Policy
        'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    End Sub
    'Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
    Private Sub CheckFirsttimelogin()
        '=====================================================================
        ' Procedure Name        : CheckFirsttimelogin
        ' Purpose               : Check The First Time Login 
        ' Description           : None
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : ShrikantB
        ' Created               : 06-SEP-2010
        ' Revisions             :
        '=====================================================================
        ' ***********************************************************************************
        ' Modified Apr 23,2015 RajK R.No: P2-SEC-1
        ' ***********************************************************************************
        Dim strLoginName As String = HttpUtility.HtmlEncode(Replace(CommonFunctions.General.CheckIsNothing(Request.QueryString.Get("LoginName")), "'", "''"))
        Dim strFirstTimeLogin As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("FirstTimeLogin"))

        If strLoginName <> "" Then
            Response.Write("<script language='javascript'>")
            Response.Write("var objtxtLoginName = GetObjectReference('','txtLoginName'); ")
            Response.Write(" if(objtxtLoginName != null) {")
            Response.Write(" objtxtLoginName.value='" + strLoginName + "';")
            If strFirstTimeLogin = "1" Then
                Response.Write(" objtxtLoginName.disabled=true; } ")
                Response.Write(" GetObjectReference('','txtOldPassword').focus();")
            Else
                Response.Write(" } ")
            End If
            Response.Write(" </script> ")
        End If
    End Sub
    'End of Added By Bharat T on 26th-Oct-2016 for Euronet Pwd Mngmt Customization
End Class
