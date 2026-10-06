

'Added by NageshM
'=====================================================================
'Purpose        : Page is created for sending the silent mail with resetting the password of valid login user
'Description    : same as above
'author         : NageshM
'Created on     : 13 th jul 2005
'Modified By    : NageshM
'Modified Date  : 15 th Jul 2005
'=====================================================================	

Imports Authentication
Public Class SM_ForgotPassword
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmForgotPassword As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

    Private m_strLoginName As String = ""
    Private m_strPassword As String = ""
    Private m_strMode As String = ""
    Protected m_strIsValid As String = ""
    'Protected m_strSMTPServerPort As String
    'Protected m_strSMTPServer As String

    Protected strUserName As String

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        m_strLoginName = Request.QueryString("LoginName")
        m_strMode = Request.QueryString("Mode")

    End Sub

    Public Sub PageInit()
        If MyBase.Page.IsPostBack Then
            Select Case m_strMode
                Case "ResetPassword"
                    ReSetPassword()
            End Select
        End If
        'Plot the page
        DrawPage()
    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.SM_ForgotPassword", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "Change Password -> Invalid Input" + UserInput + Cause
        Throw ex
    End Sub

    ''code to draw the menu's and page 
    Private Sub DrawPage()

        Dim strMenu As String

        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")
        ' Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        Response.Write("<DIV ID='PageDiv' Style='Height:100%;WIDTH:100%;OVERFLOW:auto;'>")
        DrawUIControls()
        ''Commented and Added by Dhanashri S on 7 Dec 2015
        ''Response.Write("<BR>" + strMenu)
        Response.Write(strMenu)
        ''End of Comment and Addition by Dhanashri S on 7 Dec 2015
        Response.Write("</DIV>")

    End Sub

    Private Sub DrawUIControls()
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<TABLE class='clsTable' height ='73%' width='99.9%'  cellspacing=0 cellpadding=0>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("<td align='right' noWrap valign='top'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("LOGIN_NAME"))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td align='left' noWrap valign='top'>")

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtLoginName", "txtLoginName", , 100, 30, , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr class=" + m_strClsTREven + ">")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</TABLE>")
    End Sub
    ''Actual menu contents are declared here 
    '' The item(RESET_PASSWORD etc.) are collected fro SM_ForgorPassword AppResource
    Private Function DrawMenu() As String
        'Comment and modification by SuchitraP on 11-Mar-2009 for IssueID 28369 for Whiziblesem7.2
        'Purpose :  After clicking on help link it throws session expired error,so help link removed
        'Dim arrMenu() As String = {MyBase.GetResourceString("RESET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_CAP_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("RESET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        'Dim arrClientSideFunctions() As String = {"ReSetPassword_OnClick()", "Close_OnClick()", "Help_OnClick('ForgotPassHelp')"}

        Dim arrMenu() As String = {MyBase.GetResourceString("RESET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("RESET_PASSWORD"), MyBase.GetResourceString("MENU_CLOSE")}
        Dim arrClientSideFunctions() As String = {"ReSetPassword_OnClick()", "Close_OnClick()"}
        'End of comment and modification by SuchitraP
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        Return (strMenu)

    End Function

    'Purpose        :   The function is added for generating the password for the login user
    '                   Also this function create the silent mail and mail will be send to the login user with his newly created password
    'Created by     :   By NageshM           
    'Modified By    :

    Private Sub ReSetPassword()
        Dim Counter As Integer
        Dim strbuildpassword As String
        Dim strlogin As String = ""
        Dim strSqlquery As String = ""
        Dim strToEmailId As String
        Dim strCCToEmailId As String
        Dim strSubject As String
        Dim strEmailMessage As String
        Dim StrRndNumber As String = CStr(Int(Rnd() * 10))
        Dim strloginName As String = MyBase.GetFormValue("txtLoginName")

        '' loop is used by considering the future use to create the more than 5 digit random number
        '' now this loop is able to generate the five digit number only 
        For Counter = 1 To 1 Step 1
            StrRndNumber += StrRndNumber + CStr(Int(Rnd() * 1000))
        Next

        'Commented and Added By Bharat Tekade on 8th-Nov-2016 for Password Policy Customization
        'strbuildpassword = Left$(MyBase.GetFormValue("txtLoginName"), 3) + StrRndNumber
        Dim objCreateNewPassword As New CreateNewPassword()
        strbuildpassword = objCreateNewPassword.CreatePassword()
        'End of Commented and Added By Bharat Tekade on 8th-Nov-2016 for Password Policy Customization
        ''Password get Encrypted 
        Dim objPW As PWEncryption = New PWEncryption(strloginName, strbuildpassword)
        Dim strEncryptedPW As String = objPW.Encrypt.ToString
        objPW = Nothing

        Dim strmailstatus As String = ""
        Dim m_strvalidemailID As String = ""
        Dim dr As IDataReader

        Dim stremailstatusquery As String = " Exec usp_Sel_GetLoginUserEmailInfo '" + Trim(MyBase.GetFormValue("txtLoginName")) + "'"
        dr = CommonFunctions.Data.GetDataReader(stremailstatusquery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        While dr.Read
            strmailstatus = CommonFunctions.Data.CheckIsDBNull(dr.Item("EmailID"), "").ToString
            strUserName = CommonFunctions.Data.CheckIsDBNull(dr.Item("UserName"), "").ToString
        End While
        CommonFunctions.Data.DisposeDataReader(dr)

        If Trim(MyBase.GetFormValue("txtLoginName").ToString) <> Trim(strUserName) Then
            CommonFunction.General.WriteHTML("<SCRIPT>")
            CommonFunction.General.WriteHTML("alert('" + MyBase.GetResourceString("TRY_AGAIN") + "');" + vbCrLf)
            CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunction.General.WriteHTML("</SCRIPT>")
            Exit Sub
        End If
        'End Modified  by ManishK on 1st Feb 06 for Whiz6.0 issues
        '' If logged used having the EmailID then update his login details
        If strmailstatus.Length <> 0 Then
            strSqlquery = "DECLARE @intReturn INT" + vbCrLf
            strSqlquery += "EXEC usp_upd_password '" + MyBase.GetFormValue("txtLoginName") + "','" + strEncryptedPW.ToString + "'," + "@intReturn OUTPUT" + vbCrLf
            strSqlquery += "SELECT 'Status' = @intReturn"
            m_strIsValid = CType(CommonFunction.Data.GetDataScalar(strSqlquery, m_blnUseSQL), String)
            m_strvalidemailID = "1"

        Else
            strSqlquery = "DECLARE @intReturn INT" + vbCrLf
            strSqlquery += "EXEC usp_sel_validlogin '" + MyBase.GetFormValue("txtLoginName") + "'," + "@intReturn OUTPUT" + vbCrLf
            strSqlquery += "SELECT 'Status' = @intReturn"
            m_strIsValid = CType(CommonFunction.Data.GetDataScalar(strSqlquery, m_blnUseSQL), String)
            m_strvalidemailID = "0"
        End If
        '''If logged used is valid and having the EmailID the silent mail has been send to his Email Account
        If m_strIsValid.ToString = "1" And m_strvalidemailID = "1" Then
            Dim strFromEmailId As String
            Dim blnSendMail As Boolean = False
            Dim blnShowPopUp As Boolean = False

            ''Get the details of the Email Subject,Body and other related message details 
            Dim strSQL As String = "usp_Sel_tbl_PM_EmailMessages 443"
            Dim objDr As IDataReader
            Try
                objDr = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDr.Read Then
                    blnSendMail = CType(CommonFunction.Data.CheckIsDBNull(objDr("SendMail"), "0"), Boolean)
                    blnShowPopUp = CType(CommonFunction.Data.CheckIsDBNull(objDr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunction.Data.DisposeDataReader(objDr)

                'Commented By ManishK On 1st Feb 2006 as mail was not get fired 
                'If blnSendMail Then
                '  If blnShowPopUp = False Then
                'End of Commented By ManishK On 1st Feb 2006 as mail was not get fired 
                'Call for silent Email
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(strFromEmailId, strToEmailId, strSubject, strEmailMessage, strloginName, strbuildpassword)
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
                'End If
                'End If
                '''On success or failure of login messages are dispalyed
                CommonFunction.General.WriteHTML("<SCRIPT>")
                CommonFunction.General.WriteHTML("alert('" + MyBase.GetResourceString("PASSWORD_SEND") + "');" + vbCrLf)
                CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>")
            Catch
                CommonFunction.General.WriteHTML("<SCRIPT>")
                CommonFunction.General.WriteHTML("alert('" + MyBase.GetResourceString("VALIDATION_MSG6") + "');" + vbCrLf)
                CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
                CommonFunction.General.WriteHTML("</SCRIPT>")
            End Try


            ''Checkes for valid user
        ElseIf m_strIsValid <> "1" Then
            CommonFunction.General.WriteHTML("<SCRIPT>")
            CommonFunction.General.WriteHTML("alert('" + MyBase.GetResourceString("TRY_AGAIN") + "');" + vbCrLf)
            CommonFunction.General.WriteHTML("</SCRIPT>")

            'check for available EmailID for logged user
        ElseIf m_strvalidemailID = "0" And m_strIsValid = "1" Then
            '' This alert gives message for the login name who don't have Email Account
            CommonFunction.General.WriteHTML("<SCRIPT>")
            CommonFunction.General.WriteHTML("alert('" + MyBase.GetResourceString("INVALID_EMAILID") + "');" + vbCrLf)
            CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunction.General.WriteHTML("</SCRIPT>")

        End If
    End Sub
End Class
'''''''''End of the code addition for the page by NageshM