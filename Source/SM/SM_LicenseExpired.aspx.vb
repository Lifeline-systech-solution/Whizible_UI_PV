Imports PbNIT
Public Class SM_LicenseExpired
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
    ' Page Name             : SM_LicenseExpired
    ' Purpose               : To display message to the user when the no. of logins are exceeded
    ' Description           : This page is called from the Add Mode page of Employee Login Maintenance
    ' Parameters Passed     : 
    ' Assumptions           : 
    ' Dependencies          : CommonFunction.vb, CommonFunctions.js, CommonValidations.js
    ' Author                : AbhijeetD
    ' Created               : 18th March 2004
    ' Revisions             : 
    '=====================================================================

    Private WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Private m_strclsTRColHeader As String = "'clsTRColumnHeader'"
    Private m_strClsTREven As String = "'clsTREven'"
    Private m_strClsTROdd As String = "'clsTROdd'"
    Protected WithEvents frmLicenseExpired As System.Web.UI.HtmlControls.HtmlForm
    Private m_blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

    Private m_strFromWhere As String

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

        Dim strMenu As String
        Dim strPageCaption As String

        'Retrieve the querystring parameters
        m_strFromWhere = CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"))

        'Render the Top Menu
        strMenu = DrawMenu()
        Response.Write(strMenu + "<br>")

        'Render the PageCaption
        If (m_strFromWhere = "E") Then
            strPageCaption = MyBase.GetResourceString("PAGE_CAPTION_EMPLOYEE")
        Else
            strPageCaption = MyBase.GetResourceString("PAGE_CAPTION_CUSTOMER")
        End If
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(, strPageCaption, , , True))
        CommonFunction.General.WriteHTML("<BR>")

        Response.Write("<DIV ID='PageDiv' Style='Height:300px;WIDTH:100%;OVERFLOW:auto;'>")
        DrawPage()
        Response.Write("</DIV>")

        'Render the Bottom Menu
        Response.Write("<br>" + strMenu)

    End Sub

    Public Sub New()
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "License Expired -> Invalid Input" + UserInput + Cause
        Throw ex
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
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_HELP")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrClientSideFunctions() As String = {"Help_OnClick()"}
        ' Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick()"}
        Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)

        MyBase.InitializeResources("AppResources.SM_LicenseExpired", "AppResources")
        Return (strMenu)
    End Function

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

        Dim drCompanyInformation As IDataReader
        Dim objValidatePW As Authentication.PWEncryption
        Dim intNoOfUsers As Integer
        Dim strEncryptedNoOfUsers As String
        Dim strEncryptedLicenseCode As String
        Dim intLicenseCode As Integer
        Dim strCSPLEmail As String
        Dim strEncryptedResult As String
        Dim blnCInfoManipulated As Boolean
        Dim intAllowedNoOfUsers As Integer
        Dim intActualNoOfUsers As Integer
        Dim blnRestrictExcessLogins As Boolean

        ' Get the number of licensed users as stored in the database.
        drCompanyInformation = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_CompanyInformation_For_Login", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drCompanyInformation.Read Then
            intNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("NoOfUsers")), Integer)
            strEncryptedNoOfUsers = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedUserNo")).ToString.Trim
            intLicenseCode = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("LicenseCode")), Integer)
            strEncryptedLicenseCode = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("EncryptedLicenseCode")).ToString.Trim
            strCSPLEmail = CommonFunction.Data.CheckIsDBNull(drCompanyInformation("CSPLEmail")).ToString.Trim
        End If
        CommonFunction.Data.DisposeDataReader(drCompanyInformation)

        'Check if the no of users is manipulated
        objValidatePW = New Authentication.PWEncryption("PBN", intNoOfUsers.ToString)
        strEncryptedResult = objValidatePW.Encrypt
        objValidatePW = Nothing

        ' Compare the actual value with the encrypted value.
        If strEncryptedResult <> strEncryptedNoOfUsers Then blnCInfoManipulated = True

        'Check if the license code is manipulated
        objValidatePW = New Authentication.PWEncryption("PBN", intLicenseCode.ToString)
        strEncryptedResult = objValidatePW.Encrypt()
        objValidatePW = Nothing

        ' Compare the actual value with the encrypted value.
        If strEncryptedResult <> strEncryptedLicenseCode Then blnCInfoManipulated = True

        drCompanyInformation = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_UserLicenseInformation", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drCompanyInformation.Read Then
            intAllowedNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("AllowedNoOfUsers")), Integer)
            intActualNoOfUsers = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("ActualNoOfUsers")), Integer)
            blnRestrictExcessLogins = CType(CommonFunction.Data.CheckIsDBNull(drCompanyInformation("RestrictExcessLogins")), Boolean)
        End If
        CommonFunction.Data.DisposeDataReader(drCompanyInformation)
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<table class='clsTable' width=99.9% height=100%>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        CommonFunction.General.WriteHTML("<tr>")
        CommonFunction.General.WriteHTML("<td valign=center align=center class=clsTDOdd>")
        If blnCInfoManipulated Then
            CommonFunction.General.WriteHTML("<B>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("NUMBER_OF_LICENSED_USERS_CANNOT_BE_MANIPULATED_AT_YOUR_END") + " !!")
            CommonFunction.General.WriteHTML("<BR><BR>")
            CommonFunction.General.WriteHTML("Contact:")
            If strCSPLEmail <> "projectbynet@compulnk.com" Then
                CommonFunction.General.WriteHTML("<A href='mailto:" + strCSPLEmail + "'><FONT size=2 color=blue face=Arial><B>" + strCSPLEmail + "</B></FONT></A>")
            End If
            ' CommonFunction.General.WriteHTML("<A href='mailto:projectbynet@compulnk.com'><FONT size=2 color=blue face=Arial><B>projectbynet@compulnk.com</B></FONT></A>")
            CommonFunction.General.WriteHTML("</B>")
        ElseIf blnRestrictExcessLogins Then
            CommonFunction.General.WriteHTML("<B>")
            CommonFunction.General.WriteHTML(MyBase.GetResourceString("YOU_HAVE_BEEN_GIVEN_A_LICENSE_FOR").Replace("<USER_COUNT>", intAllowedNoOfUsers.ToString))
            If intAllowedNoOfUsers <= intActualNoOfUsers Then
                CommonFunction.General.WriteHTML(MyBase.GetResourceString("YOU_HAVE_ALREADY_ADDED_USERS").Replace("<USER_COUNT>", intActualNoOfUsers.ToString))
            End If
            If intAllowedNoOfUsers < intActualNoOfUsers Then
                CommonFunction.General.WriteHTML("<BR><BR>" + MyBase.GetResourceString("YOU_HAVE_EXCEEDED_THE_LIMIT") + " !!")
            End If
            CommonFunction.General.WriteHTML("<BR><BR>")
            CommonFunction.General.WriteHTML("Contact:")
            If strCSPLEmail <> "projectbynet@compulnk.com" Then
                CommonFunction.General.WriteHTML("<A href='mailto:" + strCSPLEmail + "'><FONT size=2 color=blue face=Arial><B>" + strCSPLEmail + "</B></FONT></A>")
            End If
            'CommonFunction.General.WriteHTML("<A href='mailto:projectbynet@compulnk.com'><FONT size=2 color=blue face=Arial><B>projectbynet@compulnk.com</B></FONT></A>")
            CommonFunction.General.WriteHTML("</B>")
        End If
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")
        CommonFunction.General.WriteHTML("</table>")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
