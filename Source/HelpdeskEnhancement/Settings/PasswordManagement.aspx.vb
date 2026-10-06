Public Class PasswordManagement
    Inherits WebPages.Template.WhizTemplate
#Region "Member Declaration"
    Private Shared m_objAccess As WebPage.Templates.AccessRights
    Private m_objGlobal As WebPages.Template.IGlobal    'This variable is of global object inteface.
    Protected Shared TagID As String = ""
    Protected Shared m_intRoleID As Integer = 0
    Protected Shared strLoginType = ""

    Public txtSQLQuery As New System.Text.StringBuilder
    Public strSQLQuery As String
    Public arrColumnHeadingList As New ArrayList       'To store the column Headings
    Public arrActualColumnNames As New ArrayList
    Public arrWidthArray() As String = {"align=left", "align=center width=10%"}
    Public arrCheckBoxIDs() As String = {"", "chkSelect"}
    Public arrSelectedCheckBoxIDs() As String = {"", ""}
    Protected arrIgnoreHTMLEncode() As String = {"0"}
    Protected WithEvents m_objGrid As New WebPages.Template.GenericGrid
#End Region
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        MyBase.ApplySecurity(True)
        m_intRoleID = CType(CommonFunctions.General.CheckIsNothing(Session("intPostID"), 0), Long)
        TagID = CommonFunctions.General.CheckIsNothing(CType(Request.QueryString("MasterTagID"), Integer), 0)
        strLoginType = CommonFunctions.General.CheckIsNothing(CType(Session("LoginType"), String), 0)
        'GetAccessRights()
    End Sub
    Private Sub GetAccessRights()
        '=====================================================================
        ' Procedure Name        :	GetAccessRights
        ' Purpose               :	Get the Access Details for the Page 
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	Yogesh Jalamkar
        ' Created               :	08-DEC-2017
        ' Revisions             :
        '=====================================================================

        m_objAccess = New WebPage.Templates.AccessRights
        Dim objGlobal As New WebPage.Templates.WhizGlobal(Session("strUserName").ToString, TagID, m_intRoleID, CType(Session("intUserID"), Integer), strLoginType)
        m_objAccess.GetAccess(objGlobal)
        m_objGlobal = objGlobal
        GetAccessRights()
    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()	
        ' Purpose               : the main function to initialize the page.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                :Yogesh Jalamkar
        ' Created               : 11-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strPageHTML As New StringBuilder("")

        strPageHTML.Append("")

        strPageHTML.Append("<div class='row'>")

        'strPageHTML.Append("<div class='form-group'><div class='col-sm-12'>")
        'strPageHTML.Append("<div class='left'></div>")
        'strPageHTML.Append("<div class='right'>")
        ''If m_objAccess.Edit Then
        'strPageHTML.Append("<button type='button' id='btnSave'onclick='Save_Data()' class='btn btn-default save'>Save</button>")
        ''End If
        'strPageHTML.Append("<button type='button' id='btnCancel'class='btn btn-default save'  onclick='Clear_Data()'  >Clear</button>")
        'strPageHTML.Append("</div>")
        'strPageHTML.Append("</div>")
        'strPageHTML.Append("</div>")

        strPageHTML.Append("<div class='table-responsive ' id='formSection'>")

        'strPageHTML.Append("<div class='type-top-bar top-bar' id='EmployeeFilter'>")
        'strPageHTML.Append("    <ul class='left'>")
        'strPageHTML.Append(" <li class='left search-bar'>")
        'strPageHTML.Append("<div class='left search-bar'>")
        'strPageHTML.Append("<i class='fa fa-search faSettingSearch'  aria-hidden='true'></i>")
        'strPageHTML.Append("<input type='text' id='txtSearchHistory'   placeholder='Search in table' title='Type here to search '>")
        'strPageHTML.Append("</div>")
        'strPageHTML.Append("</li>")
        'strPageHTML.Append("</ul>")             
        'strPageHTML.Append(" </div>")

        strPageHTML.Append(PlotPasswordManagement())
        strPageHTML.Append("</div>")
        strPageHTML.Append("</div>")

        CommonFunctions.General.WriteHTML(strPageHTML.ToString)
    End Sub
    Protected Function PlotPasswordManagement(Optional ByVal Flag As String = "") As String
        '=====================================================================
        ' Procedure Name        : PlotPasswordManagement()	
        ' Purpose               : the Plotting of Password Management 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : YOgesh Jalamkar
        ' Created               : 11-DEC-2017
        ' Revisions             : None
        '=====================================================================
        Dim strPageHTML As New StringBuilder("")



        Dim Str As String = ""
        Dim EnableFirstTimeLogin As String = ""

        Dim EnablePwdOnReset As String = ""
        Dim EnablePwdLength As String = ""
        Dim MiniPwdLength As String = ""
        Dim MaxPwdLength As String = ""
        Dim EnableAlphaNumSpecialChar As String = ""
        Dim NumOfAlpha As String = ""
        Dim NumOfNumerals As String = ""
        Dim NumOfSpecial As String = ""
        Dim AllowSameLoginPwd As String = ""
        Dim EnablePassPhrases As String = ""
        Dim PassPharsesDays As String = ""
        Dim EnablePreviousPassCheck As String = ""
        Dim PreviousPassCount As String = ""
        Dim EnablePassLockoutDuration As String = ""
        Dim PassLockoutDuration As String = ""
        Dim EnableLockUserID As String = ""
        Dim PassLockingCount As String = ""
        Dim PassCaptchaCount As String = ""
        Dim EnableCaptcha As String = ""
        Dim IsAutoPasswordCreation As String = ""


        Str = "EXEC usp_NG2_Sel_tbl_PM_CompanyInformation "
        'Str = Str.Replace("''", "'")
        Dim drValidateLogin As IDataReader
        drValidateLogin = CommonFunctions.Data.GetDataReader(Str, True)
        Dim strUserLoginIDNew As String = ""
        If drValidateLogin.Read Then
            EnableFirstTimeLogin = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableFirstTimeLogin").ToString, "")
            EnablePwdOnReset = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePwdOnReset").ToString, "")
            EnablePwdLength = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePwdLength").ToString, "")
            MiniPwdLength = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("MiniPwdLength").ToString, "")
            MaxPwdLength = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("MaxPwdLength").ToString, "")
            EnableAlphaNumSpecialChar = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableAlphaNumSpecialChar").ToString, "")
            NumOfAlpha = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("NumOfAlpha").ToString, "")
            NumOfNumerals = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("NumOfNumerals").ToString, "")
            NumOfSpecial = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("NumOfSpecial").ToString, "")
            AllowSameLoginPwd = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("AllowSameLoginPwd").ToString, "")
            EnablePassPhrases = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePassPhrases").ToString, "")
            PassPharsesDays = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassPharsesDays").ToString, "")
            EnablePreviousPassCheck = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePreviousPassCheck").ToString, "")
            PassLockoutDuration = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassLockoutDuration").ToString, "")
            EnableLockUserID = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableLockUserID").ToString, "")
            PassLockingCount = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassLockingCount").ToString, "")
            PassCaptchaCount = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassCaptchaCount").ToString, "")
            EnableCaptcha = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableCaptcha").ToString, "")
            IsAutoPasswordCreation = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("IsAutoPasswordCreation").ToString, "")
            PreviousPassCount = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PreviousPassCount").ToString, "")
            EnablePassLockoutDuration = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePassLockoutDuration").ToString, "")
        End If





        strPageHTML.Append("<div class='box bottom-bar' id='MainDiv'>")


        strPageHTML.Append("<table class='clsTable'>")
        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")

        If EnableFirstTimeLogin = "True" Then
            strPageHTML.Append("<tr>") '1st Tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableFirstTimeLogin'  class='' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:97%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce user to change the password while logged-in first time? [recommended]</label>")
            strPageHTML.Append("</td>")


            'strPageHTML.Append("<div class='form-group'>")
            'strPageHTML.Append("<div class='col-sm-4' id='savebtn'>") 'col-sm-offset-3
            'strPageHTML.Append("<button type='button' class='btn btn-primary btn-block' onclick=""Save_Data()"" >Save</button>")
            'strPageHTML.Append("</div>")
            'strPageHTML.Append("</div>")
            strPageHTML.Append("</tr>")
        Else
            strPageHTML.Append("<tr>") '1st Tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableFirstTimeLogin'  class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:97%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce user to change the password while logged-in first time ? [recommended]</label>")
            strPageHTML.Append("</td>")


            'strPageHTML.Append("<div class='form-group'>")
            'strPageHTML.Append("<div class='col-sm-4' id='savebtn'>") 'col-sm-offset-3
            'strPageHTML.Append("<button type='button' class='btn btn-primary btn-block' onclick=""Save_Data()"" >Save</button>")
            'strPageHTML.Append("</div>")
            'strPageHTML.Append("</div>")
            strPageHTML.Append("</tr>")

        End If


        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '2nd tr
        If EnablePwdOnReset = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePwdOnReset'  class='' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:97%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce user to change the password after administrator resets it ? [recommended]</label>")
            strPageHTML.Append("</td>")
            ' strPageHTML.Append("</tr>")
        Else
            'strPageHTML.Append("<tr>") '2nd tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePwdOnReset'  class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:97%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce user to change the password after administrator resets it ? [recommended]</label>")
            strPageHTML.Append("</td>")

        End If

        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>") '3rd tr
        If EnablePwdLength = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePwdLength'  class='' onclick='EnablePWD(this)' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6'style='width:97%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce minimum or maximum character length of password ? [recommended]</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")

        Else
            'strPageHTML.Append("<tr>") '3rd tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePwdLength'  class='' onclick='EnablePWD(this)'>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6'style='width:97%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce minimum or maximum character length of password ? [recommended]</label>")
            strPageHTML.Append("</td>")



        End If
        strPageHTML.Append("</tr>")

        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>") '9rd tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")

        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>Minimum Length</label>")
        strPageHTML.Append("</td>")
        If MiniPwdLength <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("MiniPwdLength", "MiniPwdLength", "form-control", 140, 50, MiniPwdLength, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")

        Else
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("MiniPwdLength", "MiniPwdLength", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")


        End If


        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>Maximum Length</label>")
        strPageHTML.Append("</td>")

        If MaxPwdLength <> "" Then
            strPageHTML.Append("<td  style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("MaxPwdLength", "MaxPwdLength", "form-control", 140, 50, MaxPwdLength, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td  style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("MaxPwdLength", "MaxPwdLength", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")

        End If
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>") '5th tr
        If EnableAlphaNumSpecialChar = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableAlphaNumSpecialChar'  onclick='EnablePWD(this)' checked class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce strong password policy ? [recommended]</label>")
            strPageHTML.Append("</td>")
            ' strPageHTML.Append("</tr>")


        Else
            'strPageHTML.Append("<tr>") '5th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableAlphaNumSpecialChar'  class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label  class='lblHeading'>Do you want the system to enforce strong password policy ? [recommended]</label>")
            strPageHTML.Append("</td>")
        End If
        strPageHTML.Append("</tr>")

        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>") '3rd tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>Alphabet(s)</label>")
        strPageHTML.Append("</td>")


        If NumOfAlpha <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NumOfAlpha", "NumOfAlpha", "form-control", 140, 50, NumOfAlpha, , , , , , , "", True, , , , , , True))
            'strPageHTML.Append("<label>(a-z or A-Z )</label></td>")
            strPageHTML.Append("</td>")
        Else
            '
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NumOfAlpha", "NumOfAlpha", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            'strPageHTML.Append("<label>(a-z or A-Z )</label></td>")
            strPageHTML.Append("</td>")
        End If

        strPageHTML.Append("<td><label>(a-z or A-Z )</label></td>")

        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>Numeral(s)</label>")
        strPageHTML.Append("</td>")


        If NumOfNumerals <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NumOfNumerals", "NumOfNumerals", "form-control", 140, 50, NumOfNumerals, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NumOfNumerals", "NumOfNumerals", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        End If

        strPageHTML.Append("<td style='width:15%'><label>(0-9)</label></td>")
        strPageHTML.Append("</tr>")


        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '6th tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td style='text-align:center;width:15%'><label>Special Character(s)</label>")
        strPageHTML.Append("</td>")

        If NumOfSpecial <> "" Then
            strPageHTML.Append("<td>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NumOfSpecial", "NumOfSpecial", "form-control", 140, 50, NumOfSpecial, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("NumOfSpecial", "NumOfSpecial", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")

        End If

        strPageHTML.Append("<td style='width:15%'><label>(@,# etc)</label></td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>") '7th tr
        If AllowSameLoginPwd = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='AllowSameLoginPwd'  class='' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce password not to be same as the Login Name ? [recommended]</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")



        Else
            'strPageHTML.Append("<tr>") '7th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='AllowSameLoginPwd'  class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce password not to be same as the Login Name ? [recommended]</label>")
            strPageHTML.Append("</td>")
        End If
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>") '8th tr
        If EnablePassPhrases = "True" Then
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePassPhrases'  class=''  onclick='EnablePWD(this)' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce change user Passwords/Passphrases at least once everyDay ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        Else
            'strPageHTML.Append("<tr>") '8th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePassPhrases'  class=''  onclick='EnablePWD(this)'>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce change user Passwords/Passphrases at least once everyDay ?</label>")
            strPageHTML.Append("</td>")


        End If
        strPageHTML.Append("</tr>")


        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '9rd tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        'strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>Minimum Length</label>")
        'strPageHTML.Append("</td>")
        If PassPharsesDays <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassPharsesDays", "PassPharsesDays", "form-control", 140, 50, PassPharsesDays, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassPharsesDays", "PassPharsesDays", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")

        End If

        strPageHTML.Append("<td style='text-align:left;width:15%'><label>Day's</label></td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '10th tr
        If EnablePreviousPassCheck = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePreviousPassCheck'  class='' onclick='EnablePWD(this)' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce user to submit a new Password/Passphrases that is the same as any of the last 4(eg)Passwords/passphrases used ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        Else
            'strPageHTML.Append("<tr>") '10th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePreviousPassCheck'  class='' onclick='EnablePWD(this)'>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce user to submit a new Password/Passphrases that is the same as any of the last 4(eg)Passwords/passphrases used ?</label>")
            strPageHTML.Append("</td>")

        End If
        strPageHTML.Append("</tr>")

        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '11rd tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>Count</label>")
        strPageHTML.Append("</td>")

        If PreviousPassCount <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PreviousPassCount", "PreviousPassCount", "form-control", 140, 50, PreviousPassCount, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PreviousPassCount", "PreviousPassCount", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        End If

        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '12th tr
        If EnablePassLockoutDuration = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePassLockoutDuration'  class='' onclick='EnablePWD(this)' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce lockout duration to a minimum duration or until an administrator enables the user ID ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        Else

            ' strPageHTML.Append("<tr>") '12th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnablePassLockoutDuration'  class='' onclick='EnablePWD(this)'>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>Do you want the system to enforce lockout duration to a minimum duration or until an administrator enables the user ID ?</label>")
            strPageHTML.Append("</td>")


        End If
        strPageHTML.Append("</tr>")


        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '13th tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td style='text-align:center;width:15%'><label>Duration	</label>")
        strPageHTML.Append("</td>")

        If PassLockoutDuration <> "" Then
            strPageHTML.Append("<td>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassLockoutDuration", "PassLockoutDuration", "form-control", 140, 50, PassLockoutDuration, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassLockoutDuration", "PassLockoutDuration", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        End If

        strPageHTML.Append("<td style='width:15%'><label>Minutes</label></td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '14th tr
        If EnableLockUserID = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableLockUserID'  class='' onclick='EnablePWD(this)' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce repeated access attempts by locking out the user ID after not more than specified attempts ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        Else
            ' strPageHTML.Append("<tr>") '14th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableLockUserID'  class='' onclick='EnablePWD(this)'>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want the system to enforce repeated access attempts by locking out the user ID after not more than specified attempts ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        End If
        strPageHTML.Append("</tr>")


        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '15rd tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>For Locking</label>")
        strPageHTML.Append("</td>")

        If PassLockingCount <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassLockingCount", "PassLockingCount", "form-control", 140, 50, PassLockingCount, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassLockingCount", "PassLockingCount", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        End If

        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '16th tr
        If EnableCaptcha = "True" Then

            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableCaptcha'  class='' onclick='EnablePWD(this)' checked>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want system to enforce captcha after specified invalid attempts ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        Else
            'strPageHTML.Append("<tr>") '16th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='EnableCaptcha'  class='' onclick='EnablePWD(this)'>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want system to enforce captcha after specified invalid attempts ?</label>")
            strPageHTML.Append("</td>")

        End If
        strPageHTML.Append("</tr>")


        'strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        'strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        'strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '17rd tr
        strPageHTML.Append("<td>")
        'strPageHTML.Append("<input type='checkbox' id='chklgtpwd'  class=''>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("<td style='text-align:center;width:15%'><label class='clsalign'>For Captcha	</label>")
        strPageHTML.Append("</td>")

        If PassCaptchaCount <> "" Then
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassCaptchaCount", "PassCaptchaCount", "form-control", 140, 50, PassCaptchaCount, , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        Else
            strPageHTML.Append("<td style='width:15%'>")
            strPageHTML.Append(CommonFunctions.HTMLControls.DrawTextBox("PassCaptchaCount", "PassCaptchaCount", "form-control", 140, 50, , , , , , , , "", True, , , , , , True))
            strPageHTML.Append("</td>")
        End If

        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")


        strPageHTML.Append("<tr>") '18th tr
        If IsAutoPasswordCreation = "True" Then
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='IsAutoPasswordCreation'  checked class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want system to enforce auto password creation ?</label>")
            strPageHTML.Append("</td>")
            'strPageHTML.Append("</tr>")
        Else
            'strPageHTML.Append("<tr>") '18th tr
            strPageHTML.Append("<td>")
            strPageHTML.Append("<input type='checkbox' id='IsAutoPasswordCreation'  class=''>")
            strPageHTML.Append("</td>")
            strPageHTML.Append("<td colspan='6' style='width:15%'>")
            strPageHTML.Append("<label class='lblHeading'>	Do you want system to enforce auto password creation ?</label>")
            strPageHTML.Append("</td>")

        End If
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr class='clsTRSectionHeader'>")
        strPageHTML.Append("<td colspan='100%' valign='middle'> </td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("<tr>")
        strPageHTML.Append("<td colspan='9'>")
        strPageHTML.Append("<div class='form-group'><div class='col-sm-12'>")
        strPageHTML.Append("<div class='left'></div>")
        strPageHTML.Append("<div class='right' id='idbuttonsection'>")
        'If m_objAccess.Edit Then
        strPageHTML.Append("<button type='button' id='btnSave'onclick='Save_Data()'  class='btn btn-default save'>Save</button>")
        'End If
        'strPageHTML.Append(" <button type='button' id='idShowHistory' onclick='ShowHistory()' title='Show History' class='btn btn-default save' >Show History</button>")
        strPageHTML.Append("<button type='button' id='btnCancel'class='btn btn-default save'  onclick='Clear_Data()'  >Clear</button>")
        strPageHTML.Append("</div>")
        strPageHTML.Append("</div>")
        strPageHTML.Append("</div>")
        strPageHTML.Append("</td>")
        strPageHTML.Append("</tr>")

        strPageHTML.Append("</table'>")
        strPageHTML.Append("</div>")



        Return strPageHTML.ToString

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function SaveData(ByVal Firsttimelogin As String, ByVal EnablePwdOnReset As String, ByVal EnablePwdLength As String, ByVal MiniPwdLength As String, ByVal MaxPwdLength As String, ByVal EnableAlphaNumSpecialChar As String, ByVal NumOfAlpha As String, ByVal NumOfNumerals As String, ByVal NumOfSpecial As String, ByVal AllowSameLoginPwd As String, ByVal EnablePassPhrases As String, ByVal PassPharsesDays As String, ByVal EnablePreviousPassCheck As String, ByVal PreviousPassCount As String, ByVal EnablePassLockoutDuration As String, ByVal PassLockoutDuration As String, ByVal EnableLockUserID As String, ByVal PassLockingCount As String, ByVal EnableCaptcha As String, ByVal PassCaptchaCount As String, ByVal IsAutoPasswordCreation As String)
        Try

            Dim objRealTBG As New PasswordManagement

            Dim strReturnHTML As New StringBuilder("")
            Dim strBGID As String = ""
            'If Customer = "" Then
            '    Customer = "Null"
            'End If
            strBGID = "usp_NG2_Upd_tbl_PM_CompanyInformation_ForPwdMngment " & Firsttimelogin & "," & EnablePwdOnReset & "," & EnablePwdLength & "," & MiniPwdLength & "," & MaxPwdLength & "," & EnableAlphaNumSpecialChar & "," & NumOfAlpha & "," & NumOfNumerals & "," & NumOfSpecial & "," & AllowSameLoginPwd & "," & EnablePassPhrases & "," & PassPharsesDays & "," & EnablePreviousPassCheck & "," & PreviousPassCount & "," & EnablePassLockoutDuration & "," & PassLockoutDuration & "," & EnableLockUserID & "," & PassLockingCount & "," & EnableCaptcha & "," & PassCaptchaCount & "," & IsAutoPasswordCreation & ""
            CommonFunctions.Data.InsertOrUpdateData(strBGID, True)
            strReturnHTML.Append(objRealTBG.PlotPasswordManagement("flag"))

            Return strReturnHTML.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ClearData() As String
        '=====================================================================
        ' Procedure Name        : RefreshGrid
        ' Purpose               : To Refresh Grid
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : HTML
        ' Parameters Affected   : None
        ' Assumptions           : None
        ' Dependencies          : None
        ' Author                : Chakshuta H
        ' Created Date           : 8th-Dec-2017
        '=====================================================================
        Try

            Dim EnablePwdOnReset As String = ""
            Dim EnablePwdLength As String = ""
            Dim MiniPwdLength As String = ""
            Dim MaxPwdLength As String = ""
            Dim EnableAlphaNumSpecialChar As String = ""
            Dim NumOfAlpha As String = ""
            Dim NumOfNumerals As String = ""
            Dim NumOfSpecial As String = ""
            Dim AllowSameLoginPwd As String = ""
            Dim EnablePassPhrases As String = ""
            Dim PassPharsesDays As String = ""
            Dim EnablePreviousPassCheck As String = ""
            Dim PreviousPassCount As String = ""
            Dim EnablePassLockoutDuration As String = ""
            Dim PassLockoutDuration As String = ""
            Dim EnableLockUserID As String = ""
            Dim PassLockingCount As String = ""
            Dim PassCaptchaCount As String = ""
            Dim EnableCaptcha As String = ""
            Dim IsAutoPasswordCreation As String = ""
            Dim EnableFirstTimeLogin As String = ""
            Dim Str As String


            Str = "EXEC usp_NG2_Sel_tbl_PM_CompanyInformation "
            'Str = Str.Replace("''", "'")
            Dim drValidateLogin As IDataReader
            drValidateLogin = CommonFunctions.Data.GetDataReader(Str, True)
            Dim strUserLoginIDNew As String = ""
            If drValidateLogin.Read Then
                EnableFirstTimeLogin = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableFirstTimeLogin").ToString, "")
                EnablePwdOnReset = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePwdOnReset").ToString, "")
                EnablePwdLength = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePwdLength").ToString, "")
                MiniPwdLength = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("MiniPwdLength").ToString, "")
                MaxPwdLength = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("MaxPwdLength").ToString, "")
                EnableAlphaNumSpecialChar = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableAlphaNumSpecialChar").ToString, "")
                NumOfAlpha = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("NumOfAlpha").ToString, "")
                NumOfNumerals = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("NumOfNumerals").ToString, "")
                NumOfSpecial = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("NumOfSpecial").ToString, "")
                AllowSameLoginPwd = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("AllowSameLoginPwd").ToString, "")
                EnablePassPhrases = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePassPhrases").ToString, "")
                PassPharsesDays = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassPharsesDays").ToString, "")
                EnablePreviousPassCheck = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePreviousPassCheck").ToString, "")
                PassLockoutDuration = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassLockoutDuration").ToString, "")
                EnableLockUserID = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableLockUserID").ToString, "")
                PassLockingCount = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassLockingCount").ToString, "")
                PassCaptchaCount = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PassCaptchaCount").ToString, "")
                EnableCaptcha = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnableCaptcha").ToString, "")
                IsAutoPasswordCreation = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("IsAutoPasswordCreation").ToString, "")
                PreviousPassCount = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("PreviousPassCount").ToString, "")
                EnablePassLockoutDuration = CommonFunctions.Data.CheckIsDBNull(drValidateLogin("EnablePassLockoutDuration").ToString, "")
            End If

            Return EnableFirstTimeLogin & "#$#" & EnablePwdOnReset & "#$#" & EnablePwdLength & "#$#" & MiniPwdLength & "#$#" & MaxPwdLength & "#$#" & EnableAlphaNumSpecialChar & "#$#" & NumOfAlpha & "#$#" & NumOfNumerals & "#$#" & NumOfSpecial & "#$#" & AllowSameLoginPwd & "#$#" & EnablePassPhrases & "#$#" & PassPharsesDays & "#$#" & EnablePreviousPassCheck & "#$#" & PassLockoutDuration & "#$#" & EnableLockUserID & "#$#" & PassLockingCount & "#$#" & PassCaptchaCount & "#$#" & EnableCaptcha & "#$#" & IsAutoPasswordCreation & "#$#" & PreviousPassCount & "#$#" & EnablePassLockoutDuration & ""

            'Return strResult.ToString
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function ShowMailHistoryDetails(ByVal UniqueID As Integer)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryDetails                              '
        ' Purpose				:   Call ShowMailHistoryGrid function                   '
        ' Parameters Passed     :   None                                                '
        ' Returns               :                                                       '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Try

            Dim objSetting As New PasswordManagement
            Dim strHTML As New StringBuilder("")
            Dim str As String = objSetting.ShowMailHistoryGrid(UniqueID, "")
            strHTML.Append(str)
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Public Function ShowMailHistoryGrid(ByVal UniqueID As Integer, Optional ByVal storedprocedure As String = Nothing)
        '*******************************************************************************'
        ' Function Name	        :	ShowMailHistoryGrid                                 '
        ' Purpose				:   Plotting the grid                                   '
        ' Parameters Passed     :   UniqueID                                            '
        ' Returns               :   grid                                                '
        ' Author                :   Varsha Jorwekar                                     '
        '*******************************************************************************'
        Dim strHTML As New StringBuilder("")

        If (storedprocedure = Nothing) Then
            txtSQLQuery.Append("EXEC usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory '" & 1969 & "','" & 1 & "'")
        Else
            txtSQLQuery.Append(storedprocedure)
        End If

        strSQLQuery = txtSQLQuery.ToString

        arrColumnHeadingList.Add("Modified Date")
        arrColumnHeadingList.Add("Field Modified")
        arrColumnHeadingList.Add("Modified By")
        arrColumnHeadingList.Add("Value")

        arrActualColumnNames.Add("Date")
        arrActualColumnNames.Add("FieldName")
        arrActualColumnNames.Add("ModifiedBy")
        arrActualColumnNames.Add("Value")
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 4
            .PrimaryKey = "LogID"
            .TDStyleArray = arrWidthArray
            .ColNameToolTipOnEachRow = False
            .DIVID = "ShowHistoryGrid"
            .DIVStyle = ""
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            strHTML.Append(.DrawGrid())
        End With

        Return strHTML.ToString()

    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function FilteredHistory(ByVal newModifiedField As String, ByVal MessageID As Integer, ByVal newModifiedBy As String)
        '================================================================================
        ' Procedure Name        : FilteredHistory()	
        ' Purpose               : Get Email setting details for selected filter
        ' Description           : Get Email setting details for selected filter
        ' Parameters Passed     : newModifiedField
        ' Returns               : Datatable (String format)
        ' Parameters Affected   : None.
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Varsha Jorwekar
        ' Created               : 01-Dec-2017
        ' Revisions             :
        '===============================================================================
        Try

            Dim strSQL As String
            Dim strResult As String
            Dim dt As DataTable
            Dim objSetting As New PasswordManagement
            If newModifiedBy = "" Then
                newModifiedBy = "null"
            End If
            If newModifiedField = "" Then
                newModifiedField = "null"
            End If
            strSQL = "usp_NG2_sel_tbl_PM_AuditTrail_MailSettinghistory 1969, '" & 1 & "','" & newModifiedField & "','" & newModifiedBy & "'"

            Dim str As String = objSetting.ShowMailHistoryGrid(1, strSQL)

            Return str
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    Public Function GetArray(ByVal arrList As ArrayList) As String()
        '================================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : tejal D
        ' Created               : 
        ' Revisions             :
        '===============================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function
End Class