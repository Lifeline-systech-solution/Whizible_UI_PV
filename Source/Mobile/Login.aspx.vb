
Partial Class Login
    Inherits System.Web.UI.MobileControls.MobilePage

#Region " Constants Variables Declaretions"

    Private Const MODE_APPROVE As String = "APPROVE"
    Private Const m_dblSessionTimeOut As Double = 20
    Private Enum GridIndex
        LEAVE = 1
        'IR = 2
        'EXPENSE = 3
        'PROJECT = 4
        'PROJECT_TIMESHEET = 5
        RESOURCE_TIMESHEET = 6
        TOTAL_GRID = 6
    End Enum
#End Region

#Region " Structure Declaretions"
    Public Structure StructGridName
        Dim strDumy As String
        Private Const TotalGrid As Integer = 6

        Public ReadOnly Property LEAVE() As String
            Get
                LEAVE = "Leave"
            End Get

        End Property
        'Public ReadOnly Property IR() As String
        '    Get
        '        IR = "IR"
        '    End Get

        'End Property
        'Public ReadOnly Property EXPENSE() As String
        '    Get
        '        EXPENSE = "Expense"
        '    End Get

        'End Property
        'Public ReadOnly Property PROJECT() As String
        '    Get
        '        PROJECT = "Project"
        '    End Get

        'End Property
        'Public ReadOnly Property PROJECT_TIMESHEET() As String
        '    Get
        '        PROJECT_TIMESHEET = "Project TimeSheet"
        '    End Get

        'End Property
        Public ReadOnly Property RESOURCE_TIMESHEET() As String
            Get
                RESOURCE_TIMESHEET = "Resource TimeSheet"
            End Get

        End Property

    End Structure
#End Region

#Region " Private Variables Declaretions "

    Private m_intTotalNoOfRows As Integer
    Private strsql As String
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private m_dsGrid As System.Data.DataSet
    Private m_GridName As StructGridName = New StructGridName
    Private m_IsCurrentCookiesExist As Boolean = False
    Private m_blnIsApprover As Boolean = False
    Private objWhizTemplate As New WebPages.Template.WhizTemplate
    Private m_blnLoginValid As Boolean

#End Region
#Region " Protected Variables Declaretions "
    Protected m_intLeaveTotalNoOfRows As Integer = 0
    Protected m_intIRTotalNoOfRows As Integer = 0
    Protected m_intExpenseTotalNoOfRows As Integer = 0
    Protected m_intProjectTotalNoOfRows As Integer = 0
    Protected m_intProjectTimeSheetTotalNoOfRows As Integer = 0
    Protected m_intResourceTimeSheetTotalNoOfRows As Integer = 0
    Protected m_intLeavePageNumber As Integer = 1
    Protected m_intIRPageNumber As Integer = 1
    Protected m_intExpensePageNumber As Integer = 1
    Protected m_intProjectPageNumber As Integer = 1
    Protected m_intProjectTimeSheetPageNumber As Integer = 1
    Protected m_intResourceTimeSheetPageNumber As Integer = 1
    Protected m_intPageSize As Integer = 20
    Protected m_intDivHieght As Integer = 280
    Protected m_lngTagId As Long = 0
    Protected m_IsCookiesExist As Boolean = False
    Protected m_strContentTab As String = ""


#End Region
#Region " Public Variables Declaretions "
    Public m_strOriginalFileName As String = ""
    Public m_blnIsWindowsAuthenticated As Boolean = False
    Public m_strLoginName As String = ""
    Public m_blnIsValidDomain As Boolean = True
    Public m_strLogin As String
    Public m_strPassword As String
    Public m_strOrgLogin As String
    Public m_strOrgPassword As String
    Public m_strAuthenticationType As String
    Public m_strHostName As String
    Public m_blnAutomaticallyLoginFlag As Boolean = False
#End Region

    'Code Section   
    Private Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If txtContentTab.Text <> "" Then
            m_strContentTab = Server.UrlDecode(txtContentTab.Text)
        Else
            m_strContentTab = m_GridName.LEAVE
        End If


        Dim blnChangeUserFlag As Boolean = False
        If Not Session("LoginTime") Is Nothing Then
            Dim dtmLoginTime As DateTime
            dtmLoginTime = CType(Session("LoginTime"), DateTime)
            If dtmLoginTime.AddMinutes(m_dblSessionTimeOut) < DateTime.Now Then
                Session.Abandon()
                'Call RemovePreviousLogin()
                Response.Clear()
                Session("LoginTime") = Nothing
                RedirectToDefaultPage("Message=SessionExpired")
                ActiveForm = frmApprovals
                lblError.Text = "Session Expired !!"
                m_blnLoginValid = False
            End If
        End If

        Call InitilizeGlobalVariable(sender)
        If m_blnIsWindowsAuthenticated And Not m_blnIsValidDomain Then
            RedirectToDefaultPage("Mobile_Approvals.aspx?Message=InvalidDomain")
            ActiveForm = frmApprovals
            lblError.Text = "Invalid Domain !!"
            m_blnLoginValid = False
        End If

        If HttpContext.Current.Request.QueryString("MODE") Is Nothing Then
            If HttpContext.Current.Request.QueryString("Message") Is Nothing Then
                If Not HttpContext.Current.Request.QueryString("FromWhere") Is Nothing Then
                    If HttpContext.Current.Request.QueryString("FromWhere").ToUpper() = "LOGOUT" Then
                        Session.Abandon()
                        'Call RemovePreviousLogin()
                        Response.Clear()
                        RedirectToDefaultPage("Message=Logout")
                        ActiveForm = frmApprovals
                    End If

                    If (Session("intUserID") Is Nothing) Then
                        If HttpContext.Current.Request.QueryString("FromWhere").ToUpper() = "LOGIN" Then
                            Call LoginPanel()
                        End If
                    End If

                End If
                'If HttpContext.Current.Request.QueryString.Count = 0 Then
                '    Call AutomaticallyLogin()
                'End If

            Else

                Session.Abandon()
                'Call RemovePreviousLogin()
                Response.Clear()
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "SPAINVALIDLOGIN" Then
                    blnChangeUserFlag = True
                    txtInvalidLogin.Text = "SPAInvalidLogin"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "SESSIONEXPIRED" Then
                    txtInvalidLogin.Text = "SessionExpired"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "LDAPINVALIDLOGIN" Then
                    blnChangeUserFlag = True
                    txtInvalidLogin.Text = "LDAPInvalidLogin"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "INVALIDDOMAIN" Then
                    txtInvalidLogin.Text = "InvalidDomain"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "LOGOUT" Then
                    txtInvalidLogin.Text = ""
                End If

            End If
        End If

        'If ((Not HttpContext.Current.Request.Cookies.Get("RememberMe") Is Nothing) And (Not HttpContext.Current.Request.Cookies.Get("SPAUserName") Is Nothing)) Then
        '    Dim getCookies As HttpCookie
        '    Dim getCurrentCookies As HttpCookie
        '    Dim strCurrentCookiesValue As String
        '    getCookies = HttpContext.Current.Request.Cookies.Get("RememberMe")
        '    getCurrentCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
        '    strCurrentCookiesValue = CommonFunctions.General.DecryptString(getCurrentCookies.Value)
        '    Dim strUserName As String = strCurrentCookiesValue.Substring(0, strCurrentCookiesValue.IndexOf("<=>"))
        '    If CommonFunctions.General.DecryptString(getCookies.Value) = "True" Then
        '        If blnChangeUserFlag = False Then
        '            txtLogin.Text = strUserName
        '        End If

        '    End If
        'End If



    End Sub


#Region " General Function Definition"
    'Private Function IsCurrentCookiesExist() As Boolean
    '    If Not (HttpContext.Current.Request.Cookies.Get("SPAUserName") Is Nothing) Then
    '        m_IsCurrentCookiesExist = True
    '    Else
    '        m_IsCurrentCookiesExist = False
    '    End If
    'End Function
    'Private Function IsCookiesExist() As Boolean
    '    If (txtIsCookiesExist.Text.ToUpper() <> "NOTEXIST") Then
    '        m_IsCookiesExist = True
    '    Else
    '        m_IsCookiesExist = False
    '    End If
    'End Function

    Public Function GetTick() As Long
        '=====================================================================
        ' Procedure  Name		:	GetTick()
        ' Parameters Passed		:	None
        ' Returns				:	Long values representing the current tick
        ' Parameters Affected	:	None
        ' Purpose				:	To get the current tick
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	5:53 PM 10/3/2007
        '=====================================================================
        GetTick = System.DateTime.Now.Ticks()

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
        ' Author				:	MahendraV
        ' Created				:	9:58 AM 10/3/2007
        ' Revisions				:	
        '=====================================================================

        Dim drRoleName As System.Data.IDataReader
        Dim strSQL As String

        strSQL = "EXEC usp_Sel_tbl_PM_Role " & CType(Session("intPostID"), Long)
        drRoleName = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drRoleName.Read Then
            GetRole = CType(drRoleName("RoleDescription"), String) & ""
        End If
        CommonFunctions.Data.DisposeDataReader(drRoleName)

    End Function

    'Private Function GenerateMenu() As String
    '    '=====================================================================
    '    ' function Name         : GenerateTopMenu()	
    '    ' Purpose               : To generate top and bottom menu
    '    ' Description           : same as above
    '    ' Parameters Passed     : none
    '    ' Returns               : none
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 9:57 AM 9/17/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim ArrTopMenuCaptionsList As New ArrayList
    '    Dim ArrTopMenuToolTipsList As New ArrayList
    '    Dim ArrTopMenuFunctionsList As New ArrayList

    '    ArrTopMenuCaptionsList.Add("Approve")
    '    ArrTopMenuToolTipsList.Add("Approve")
    '    ArrTopMenuFunctionsList.Add("Approve_OnClick()")

    '    ArrTopMenuCaptionsList.Add("Select All")
    '    ArrTopMenuToolTipsList.Add("Select All")
    '    ArrTopMenuFunctionsList.Add("SelectAll_OnClick()")

    '    ArrTopMenuCaptionsList.Add("Clear All")
    '    ArrTopMenuToolTipsList.Add("Claer All")
    '    ArrTopMenuFunctionsList.Add("ClearAllOnClick()")

    '    ArrTopMenuCaptionsList.Add("Close")
    '    ArrTopMenuToolTipsList.Add("Close")
    '    ArrTopMenuFunctionsList.Add("Close_OnClick()")

    '    ArrTopMenuCaptionsList.Add("Help")
    '    ArrTopMenuToolTipsList.Add("Help")

    '    If m_strContentTab.ToUpper = m_GridName.LEAVE.ToUpper Then
    '        ArrTopMenuFunctionsList.Add("Help_OnClick('LeaveHelp')")
    '    End If
    '    If m_strContentTab.ToUpper = m_GridName.RESOURCE_TIMESHEET.ToUpper Then
    '        ArrTopMenuFunctionsList.Add("Help_OnClick('ResourceTimesheetHelp')")
    '    End If

    '    Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
    '    ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
    '    ArrTopMenuCaptionsList = Nothing

    '    Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
    '    ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
    '    ArrTopMenuToolTipsList = Nothing

    '    Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
    '    ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
    '    ArrTopMenuFunctionsList = Nothing
    '    Return m_objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
    'End Function

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
        ' Author				:	MahendraV
        ' Created				:	11:38 AM 9/27/2007
        ' Revisions				:	
        '=====================================================================

        Dim objPW As Authentication.PWEncryption = New Authentication.PWEncryption(m_strOrgLogin, m_strPassword)
        'Call encrypt method of object and return it
        If Not (objPW Is Nothing) Then
            Dim strEncryptedPW As String = objPW.Encrypt().ToString()
            objPW = Nothing
            Return strEncryptedPW
        Else
            Return ""
        End If


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
        ' Author				:	MahendraV
        ' Created				:	11:37 AM 9/27/2007
        '=====================================================================

        Return CommonFunctions.General.GetApplicationKeySetting("AuthenticationType").ToString

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
        ' Author				:	MahendraV
        ' Created				:	4:33 PM 9/28/2007
        ' Revisions             :   
        '=====================================================================
        Dim strDomain As String = ""
        Dim strValidDomains As String = ""

        ' the list of domains from web.config file
        strValidDomains = CommonFunctions.General.GetApplicationKeySetting("ValidDomains")

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
    Private Function GetDivHieght(ByVal intNoOfRecords As Integer) As Integer
        '=====================================================================
        ' Procedure  Name		:	GetDivHieght
        ' Parameters Passed		:	By Val intNoOfRecords with number of records for grid
        ' Returns				:	Div Hieght
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	it will return Div Hieght.
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	4:33 PM 9/28/2007
        ' Revisions             :   
        '=====================================================================

        Dim intDisplayedDivRows As Integer
        Dim intDivHieght As Integer
        Dim i As Integer
        intDisplayedDivRows = CType((m_intDivHieght / 35), Integer)

        If intNoOfRecords > intDisplayedDivRows Then
            Return m_intDivHieght
        Else
            For i = 1 To intNoOfRecords
                If i = intNoOfRecords Then
                    intDivHieght = i * 35
                End If
                If intNoOfRecords = 1 Then
                    intDivHieght = intDivHieght + 20
                End If
            Next
            Return (intDivHieght)
        End If
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
        ' Author				:	MahendraV
        ' Created				:	4:35 PM 9/28/2007
        '=====================================================================
        Dim strUserName As String = ""
        strUserName = sender.User.Identity.Name.ToString
        strUserName = Replace(strUserName, "\", "/")
        ' see of the domain is valid
        m_blnIsValidDomain = IsValidDomain(strUserName)
        strUserName = strUserName.Substring(strUserName.LastIndexOf("/") + 1)

        Return strUserName
    End Function
    Private Function CheckApproverAccess(ByVal strExpenseSheetID As String) As Boolean
        '=====================================================================
        ' Procedure  Name		:	CheckApproverAccess
        ' Parameters Passed		:	By Val strExpenseSheetID
        ' Returns				:	the Approver Access(True or False)
        ' Parameters Affected	:	None
        ' Purpose				:	
        ' Description			:	Return the Approver Access(True or False)
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	4:35 PM 9/28/2007
        '=====================================================================

        Dim drAccess As System.Data.IDataReader
        Dim strQuery As String
        Dim strSql As String
        Dim strCount As String
        Dim blnResult As Boolean
        strSql = "USP_GET_Valid_ExpenseSheetApprover " & strExpenseSheetID & "," & m_objGlobal.UserID & ",1"
        strCount = CType(CommonFunctions.Data.GetDataScalar(strSql, True), String)
        If strCount = "1" Then
            blnResult = True
            CheckApproverAccess = blnResult
        Else
            blnResult = False
            CheckApproverAccess = blnResult
        End If
        CommonFunctions.Data.DisposeDataReader(drAccess)
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
        ' Author				:	MahendraV
        ' Created				:	11:55 AM 9/27/2007
        ' Revisions				:	
        '=====================================================================
        If m_blnIsWindowsAuthenticated Then
            ' if the user is valid
            Return 1
        End If

        Dim strLDAPServer As String = CommonFunctions.General.GetApplicationKeySetting("LDAPServerName").ToString
        Dim strLogFileName As String = CommonFunctions.FileDirectory.GetLogFileName("LDAP").ToString
        Dim strLogPath As String = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("Attachments/Log"))
        Dim Objldap As Authentication.LDAPAuthentication = New Authentication.LDAPAuthentication("LDAP://" & strLDAPServer, strLogPath & strLogFileName)


        Try
            'Validate the LDAP login
            Dim intResult As Integer = CInt(CType(Objldap.IsAuthenticated(Nothing, strID, strPW), Integer) + 2)
            Objldap = Nothing
            Return intResult
        Catch ex As Exception
            Return 0
        End Try

    End Function
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
        ' Author				:	MahendraV
        ' Created				:	11:16 AM 9/27/2007
        '=====================================================================
        If sender.User.Identity.IsAuthenticated Then
            IsWindowsAuthenticated = True
            LoginName = ExtractUserName(sender)
        Else
            IsWindowsAuthenticated = False : LoginName = ""
        End If
    End Function

#End Region
#Region " General Procedure Definition"

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : Initialize procedure to Initialize the page class level variable
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 10:20 AM 9/21/2007
        ' Revisions             : 
        '=====================================================================
        If Not HttpContext.Current.Request.QueryString("LeavePageNumber") Is Nothing Then
            m_intLeavePageNumber = CType(HttpContext.Current.Request.QueryString("LeavePageNumber"), Integer)
        End If
        'If Not HttpContext.Current.Request.QueryString("IRPageNumber") Is Nothing Then
        '    m_intIRPageNumber = CType(HttpContext.Current.Request.QueryString("IRPageNumber"), Integer)
        'End If
        'If Not HttpContext.Current.Request.QueryString("ExpensePageNumber") Is Nothing Then
        '    m_intExpensePageNumber = CType(HttpContext.Current.Request.QueryString("ExpensePageNumber"), Integer)
        'End If
        'If Not HttpContext.Current.Request.QueryString("ProjectPageNumber") Is Nothing Then
        '    m_intProjectPageNumber = CType(HttpContext.Current.Request.QueryString("ProjectPageNumber"), Integer)
        'End If
        'If Not HttpContext.Current.Request.QueryString("ProjectTimeSheetPageNumber") Is Nothing Then
        '    m_intProjectTimeSheetPageNumber = CType(HttpContext.Current.Request.QueryString("ProjectTimeSheetPageNumber"), Integer)
        'End If

        If Not HttpContext.Current.Request.QueryString("ResourceTimeSheetPageNumber") Is Nothing Then
            m_intResourceTimeSheetPageNumber = CType(HttpContext.Current.Request.QueryString("ResourceTimeSheetPageNumber"), Integer)
        End If

        If m_strContentTab = m_GridName.LEAVE Then
            m_intLeaveTotalNoOfRows = (CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.LEAVE, , , True)).Tables(m_GridName.LEAVE).Rows.Count
        End If

        'm_intIRTotalNoOfRows = (CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_Rfis_Approval " + m_objGlobal.UserID.ToString(), m_GridName.IR, , , objWhizTemplate.UseSQL)).Tables(m_GridName.IR).Rows.Count
        'm_intExpenseTotalNoOfRows = (CommonFunctions.Data.GetDataSet("Usp_tbl_PM_Expensesheet_Expensesheets_For_Approval " + m_objGlobal.UserID.ToString(), m_GridName.EXPENSE, , , objWhizTemplate.UseSQL)).Tables(m_GridName.EXPENSE).Rows.Count
        'If m_strContentTab = m_GridName.PROJECT Then
        '    Dim strQuery As String = "EXEC usp_Sel_tbl_PM_Role_IsApprover " + CommonFunctions.General.CheckIsNothing(m_objGlobal.UserID, "0").ToString()
        '    m_blnIsApprover = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
        '    If m_blnIsApprover = True Then
        '        m_intProjectTotalNoOfRows = (CommonFunctions.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_Pending_Approval '" + m_objGlobal.UserID.ToString() + "'", m_GridName.PROJECT, , , objWhizTemplate.UseSQL)).Tables(m_GridName.PROJECT).Rows.Count
        '    End If
        'End If
        'm_intProjectTimeSheetTotalNoOfRows = (CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ProjectTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.PROJECT_TIMESHEET, , , objWhizTemplate.UseSQL)).Tables(m_GridName.PROJECT_TIMESHEET).Rows.Count
        If m_strContentTab = m_GridName.RESOURCE_TIMESHEET Then
            m_intResourceTimeSheetTotalNoOfRows = (CommonFunctions.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.RESOURCE_TIMESHEET, , , True)).Tables(m_GridName.RESOURCE_TIMESHEET).Rows.Count
        End If

    End Sub
    Private Sub LoginPanel()
        '=====================================================================
        ' Procedure Name        : LoginPanel()	
        ' Purpose               : Validate the login 
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 10:20 AM 9/21/2007
        ' Revisions             : 
        '=====================================================================


        Dim drLogin As System.Data.IDataReader
        Dim strWhichLogin As String
        Dim strLoginID As String

        If Request.Form.Item("txtLogin") <> "" Then
            Session.Remove("intUserID")
            Dim blnIsLastLogonValid As Boolean
            blnIsLastLogonValid = CType(CommonFunctions.Data.GetDataScalar("EXEC usp_CheckLastLogon '" & txtLogin.Text & "'," & GetTick(), CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
            If blnIsLastLogonValid = False Then
                RedirectToDefaultPage("Message=SessionExpired")
                ActiveForm = frmApprovals
                lblError.Text = "Session Expired !!"
                m_blnLoginValid = False
            End If

        End If

        'Session intUserID Null Start
        If (Session("intUserID") Is Nothing) Then
            If m_blnIsWindowsAuthenticated Then
                m_strLogin = m_strLoginName
                m_strPassword = ""
            Else
                m_strLogin = objWhizTemplate.FixString(txtLogin.Text.ToString(), 30, False, True)
                m_strOrgLogin = CommonFunctions.General.UnBuildQueryString(txtLogin.Text.ToString())
                m_strPassword = txtPassword.Text.ToString()
                m_strOrgPassword = CommonFunctions.General.UnBuildQueryString(m_strPassword)

            End If
        End If
        m_strAuthenticationType = GetAuthenticatoinType()

        If Not m_blnIsWindowsAuthenticated Then
            'Call function to set the application variables
            m_strPassword = GetEncryptedPassword()
        End If

        drLogin = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & CommonFunctions.General.BuildQueryString(m_strLogin) & "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drLogin.Read Then
            strWhichLogin = drLogin("LoginType").ToString()
        Else
            'If Invalid login then redirect to the login page
            Response.Clear()

            RedirectToDefaultPage("Message=SPAInvalidLogin")
            ActiveForm = frmApprovals
            lblError.Text = "Invalid Login !!"
            m_blnLoginValid = False

        End If
        CommonFunctions.Data.DisposeDataReader(drLogin)
        If strWhichLogin = "E" Then
            Select Case m_strAuthenticationType
                Case "N"   'LDAP Authentication Disabled
                    Call ValidateSPALogin(0, m_strLogin, m_strPassword)
                Case "Y"   'LDAP Authentication Successful
                    If CLng(VallidateLDAPLogin(m_strLogin, m_strOrgPassword)) = 1 Then
                        Call ValidateSPALogin(1, m_strLogin, m_strPassword)
                    Else
                        Response.Clear()
                        RedirectToDefaultPage("Message=LDAPInvalidLogin")
                        ActiveForm = frmApprovals
                        lblError.Text = "Invalid Login !!"
                        m_blnLoginValid = False
                    End If
                Case "M" 'Validate Mix Login
                    Call ValidateMixedLogin(m_strLogin, m_strPassword, m_strOrgPassword)

            End Select
        Else
            Call ValidateSPALogin(0, m_strLogin, m_strPassword)
        End If 'End If for strWhichLogin



    End Sub
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
        ' Author				:	MahendraV
        ' Created				:	4:50 PM 10/3/2007
        ' Revisions				:	
        '=====================================================================
        Dim drAuthenticationType As System.Data.IDataReader
        Dim blnIsLDAPAuthentication As Boolean

        drAuthenticationType = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_UserAuthenticationType '" & strUserID & "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drAuthenticationType.Read Then

            blnIsLDAPAuthentication = CType(drAuthenticationType("IsLDAPAuthentication"), Boolean)

            'IF LDAP authentcatin then
            If blnIsLDAPAuthentication = True Then
                'IF LDAP Authentication works	
                If CLng(VallidateLDAPLogin(m_strLogin, strOrgPassword)) = 1 Then
                    Call ValidateSPALogin(1, m_strLogin, strPassword)
                Else 'If LDAP authentication fails
                    Response.Clear()
                    CommonFunctions.Data.DisposeDataReader(drAuthenticationType)
                    RedirectToDefaultPage("Message=LDAPInvalidLogin")
                    ActiveForm = frmApprovals
                    lblError.Text = "Invalid Login !!"
                    m_blnLoginValid = False
                End If

            Else 'PBN Authentication
                If m_blnIsWindowsAuthenticated Then
                    ' if the user is valid
                    Call ValidateSPALogin(1, m_strLogin, strPassword)
                Else
                    Call ValidateSPALogin(0, m_strLogin, strPassword)
                End If
            End If

        Else
            CommonFunctions.Data.DisposeDataReader(drAuthenticationType)
            Response.Clear()
            RedirectToDefaultPage("Message=SPAInvalidLogin")
            ActiveForm = frmApprovals
            lblError.Text = "Invalid Login !!"
            m_blnLoginValid = False
        End If
        CommonFunctions.Data.DisposeDataReader(drAuthenticationType)
    End Sub

    Private Sub InitilizeGlobalVariable(ByVal sender As System.Object)
        '=====================================================================
        ' Procedure Name        : InitilizeGlobalVariable()	
        ' Purpose               : To initialized global variable
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 10:20 AM 9/21/2007
        ' Revisions             : 
        '=====================================================================
        Try
            'IsCookiesExist()
            ' m_strHostName = HttpContext.Current.Request.ServerVariables.Get("REMOTE_HOST").ToString() + "-" + HttpContext.Current.Request.ServerVariables.Get("REMOTE_ADDR").ToString()
            m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(m_strLoginName, sender)

        Catch ex As Exception

            Dim LOG_ERROR As String
            Dim strLogPath As String

            strLogPath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("Attachments/Log"))
            LOG_ERROR = CommonFunctions.FileDirectory.GetLogFileName("SPA_LOGGED_ERROR")
            CommonFunctions.FileDirectory.WriteFileStream(strLogPath, LOG_ERROR, "*********************************************************" + vbCrLf + "Error (Desciption): " + ex.Message.ToString() + vbCrLf + "Error (Trace)" + ex.StackTrace.ToString() + vbCrLf + "*********************************************************")

        End Try
    End Sub

    'Private Sub GetGlobalObject()
    '    '====================================================================
    '    ' Procedure Name        :  GetGlobalObject
    '    ' Parameters Passed     :  None
    '    ' Returns               :  None
    '    ' Parameters Affected   :  None
    '    ' Purpose               :  To get an instance of the global object
    '    ' Description           :  This sub-routine fills the global object and 
    '    '                          gets the Tag ID
    '    ' Assumptions           :  None
    '    ' Dependencies          :  None
    '    ' Author                :  MahendraV
    '    ' Created               :  12:08 PM 9/17/2007
    '    ' Revisions             :  
    '    '=====================================================================
    '    objWhizTemplate.FillGlobalObject(objWhizTemplate.CurrentThreadUICultureID)
    '    m_objGlobal = objWhizTemplate.GlobalObject()
    '    m_objAccessRights = New cAccessRights(m_objGlobal)
    '    m_objAccessRights.GetAccess()
    '    m_lngTagId = m_objGlobal.TagID
    'End Sub


    'Private Sub AutomaticallyLogin()
    '    '=====================================================================
    '    ' Procedure Name        : AutomaticallyLogin()	
    '    ' Purpose               : If session has not been expired then it will allow to user for Automatically Login
    '    ' Description           : same as above
    '    ' Parameters Passed     : none
    '    ' Returns               : none
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV 
    '    ' Created               : 10:20 AM 9/21/2007
    '    ' Revisions             : 
    '    '=====================================================================

    '    If m_IsCurrentCookiesExist Then

    '        Dim dtmLoginTime As DateTime
    '        Dim objCurrentCookies As HttpCookie
    '        Dim strCurrentCookiesValue As String
    '        m_blnAutomaticallyLoginFlag = True
    '        objCurrentCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
    '        strCurrentCookiesValue = CommonFunctions.General.DecryptString(objCurrentCookies.Value)
    '        dtmLoginTime = CType(strCurrentCookiesValue.Substring(strCurrentCookiesValue.LastIndexOf("<=>") + 3), DateTime)
    '        dtmLoginTime = dtmLoginTime.AddMinutes(m_dblSessionTimeOut)
    '        If dtmLoginTime < DateTime.Now Then
    '            If (Session("intUserID") Is Nothing) Then
    '                'RedirectToDefaultPage("Message=SessionTimeOut")
    '                ActiveForm = frmApprovals
    '                lblError.Text = "Session Time Out"
    '                m_blnLoginValid = False
    '            End If

    '        Else
    '            If (Session("intUserID") Is Nothing) Then

    '                txtLogin.Text = strCurrentCookiesValue.Substring(0, strCurrentCookiesValue.IndexOf("<=>"))
    '                Dim startIndex As Integer = strCurrentCookiesValue.IndexOf("<=>") + 3
    '                Dim endIndex As Integer = strCurrentCookiesValue.LastIndexOf("<=>")
    '                Dim strPass As String = strCurrentCookiesValue.Substring(startIndex, endIndex - startIndex)
    '                txtPassword.Text = strPass
    '                LoginPanel()
    '            End If
    '        End If
    '    End If
    'End Sub

    'Private Sub RemovePreviousLogin()
    '    '=====================================================================
    '    ' Procedure Name        : RemovePreviousLogin()	
    '    ' Purpose               : If session has been expired then it will remove the previous login entry form Application variable
    '    ' Description           : same as above
    '    ' Parameters Passed     : none
    '    ' Returns               : none
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV 
    '    ' Created               : 10:20 AM 9/21/2007
    '    ' Revisions             : 
    '    '=====================================================================

    '    If m_IsCurrentCookiesExist Then
    '        Dim objCurrentCookies As HttpCookie
    '        Dim strCurrentCookiesValue As String
    '        Dim dtmLoginTime As DateTime
    '        Dim timespan As TimeSpan
    '        Dim strLoginTime As String
    '        objCurrentCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
    '        strCurrentCookiesValue = CommonFunctions.General.DecryptString(objCurrentCookies.Value)
    '        dtmLoginTime = CType(strCurrentCookiesValue.Substring(strCurrentCookiesValue.LastIndexOf("<=>") + 3), DateTime)
    '        strLoginTime = dtmLoginTime.AddMinutes(-m_dblSessionTimeOut).ToString()
    '        strLoginTime = strCurrentCookiesValue.Substring(0, strCurrentCookiesValue.LastIndexOf("<=>")).ToString() + "<=>" + strLoginTime
    '        Dim cookies As New HttpCookie("SPAUserName", CommonFunctions.General.EncryptString(strLoginTime))
    '        cookies.Expires = DateTime.Now.AddYears(100)
    '        HttpContext.Current.Response.Cookies.Add(cookies)

    '    End If



    'End Sub

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
        ' Author				:	MahendraV
        ' Created				:	11:47 AM 9/27/2007
        ' Revisions				:	
        '=====================================================================
        'Dim strRedirectToPage As String = CommonFunctions.General.GetLogOutPage.ToString
        'If strRedirectToPage.Trim = "" Then
        Response.Clear()
        Response.Redirect("Login.aspx", True)
        'Else
        'Response.Redirect(strRedirectToPage & "?" & QueryString, True)
        'End If

    End Sub

    Private Sub AprrovedSelectedRow(ByVal m_strUniqueIDs As String, ByVal intGridIndex As Integer)
        '=====================================================================
        ' Procedure Name        : AprrovedSelectedRow()
        ' Purpose               : To find the index of selected Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 8:12 PM 9/19/2007
        ' Revisions             :
        '=====================================================================

        Dim strComment As String
        Dim strUniqueID As String
        Dim strGetUniqueID As String
        While (m_strUniqueIDs <> "")

            If m_strUniqueIDs.LastIndexOf(",") <> m_strUniqueIDs.Length - 1 Then

                strUniqueID = m_strUniqueIDs
                If m_strUniqueIDs.LastIndexOf(",") = -1 Then
                    strGetUniqueID = m_strUniqueIDs
                    strComment = Request.Form("txt_" & strGetUniqueID)
                    m_strUniqueIDs = ""
                End If

                m_strUniqueIDs = m_strUniqueIDs.Substring(m_strUniqueIDs.LastIndexOf(",") + 1)
                If m_strUniqueIDs <> "" Then
                    strGetUniqueID = m_strUniqueIDs
                    strComment = Request.Form("txt_" & strGetUniqueID)
                    strUniqueID = strUniqueID.Replace("," + m_strUniqueIDs, "")
                    m_strUniqueIDs = strUniqueID
                End If

            End If
            Approved(strGetUniqueID, strComment, intGridIndex)
        End While
    End Sub

    Private Sub Approved(ByVal strUniqueID As String, ByVal strComment As String, ByVal intGridIndex As Integer)
        '=====================================================================
        ' Procedure Name        : Approved()
        ' Purpose               : To Approve the Leave,IR,Expense,Project,Project TimeSheet and Resourse TimeSheet
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 8:12 PM 9/19/2007
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String
        Select Case intGridIndex
            Case GridIndex.LEAVE

                Dim lngLeaveStatusID As Long = 2
                strQuery = "usp_Upd_tbl_PM_EmployeeLeaveDetails_AND_Master " & strUniqueID
                strQuery &= ", " & lngLeaveStatusID.ToString()
                strQuery &= ", " & m_objGlobal.UserID.ToString()
                strQuery &= ", '" & CommonFunctions.General.BuildQueryString(strComment) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

            Case GridIndex.RESOURCE_TIMESHEET

                Dim drVerify As System.Data.IDataReader
                Dim m_drTimesheet As System.Data.IDataReader
                Dim intVerifiedBy As Long
                Dim intDailyActivityID As Integer
                Dim intVerified As Integer
                Dim strSQLQuery As String
                Dim strRemarks As String
                Dim dtVerificationDate As String
                Dim strFromDate As String
                Dim strToDate As String

                dtVerificationDate = CType(Now(), String)
                intVerifiedBy = m_objGlobal.UserID
                strSQLQuery = "usp_Sel_ResourceTimesheetDADetails " & strUniqueID & "," & CType(intVerifiedBy, String)
                m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                'Get Activity record details for the resource timesheet
                Do While m_drTimesheet.Read()
                    strFromDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("FromDate"), CType(Now(), String)), String)
                    strToDate = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("ToDate"), CType(Now(), String)), String)
                    intDailyActivityID = CType(CommonFunctions.Data.CheckIsDBNull(m_drTimesheet("DailyActivityEntryID"), "0"), Integer)
                    intVerified = 1
                    strRemarks = ""

                    '--- Execute sp to update verification details to Daily Activity Table
                    strSQLQuery = "Exec usp_Upd_PM_ResourceTimesheetVerification " + CType(intDailyActivityID, String) + "," + CType(intVerified, String)
                    strSQLQuery = strSQLQuery + "," + CType(intVerifiedBy, String) + ",'" + CType(dtVerificationDate, String) + "','" + strRemarks + "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Loop

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & strUniqueID & "," & CType(intVerifiedBy, String) & "," & "'V'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                CommonFunctions.Data.DisposeDataReader(drVerify)


                'If Resource TimeSheet are verified then change the status to 'verified' 
                strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(strUniqueID, String)
                drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drVerify.Read = False Then
                    strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(strUniqueID, String) & ",'V'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If
                CommonFunctions.Data.DisposeDataReader(drVerify)
        End Select

    End Sub


    Private Sub ValidateSPALogin(ByVal intHowToValidate As Integer, ByVal m_strLogin As String, ByVal m_strPassword As String)
        '=====================================================================
        ' Procedure Name		:	ValidateSPALogin
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	Validate the Project By Netlogin
        ' Description			:	
        ' Assumptions			:	None
        ' Dependencies			:	
        ' Author				:	MahendraV
        ' Created				:	11:55 AM 9/27/2007
        ' Revisions				:	
        '=====================================================================


        Dim LOG_FILE As String
        Dim strLogPath As String

        Dim drValidateLogin As System.Data.IDataReader
        Dim strSQLQuery As String
        Select Case intHowToValidate
            Case 0 'SPA Validation
                'Constructing the SQL Query
                strSQLQuery = "EXEC usp_ValidateLogin '" & CommonFunctions.General.BuildQueryString(m_strLogin) & "','" & Trim(m_strPassword) & "'"
                drValidateLogin = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            Case 1 'LDAP Validation
                drValidateLogin = CommonFunctions.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & CommonFunctions.General.BuildQueryString(m_strLogin) & "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        End Select

        If Not drValidateLogin.Read Then

            '  RedirectToDefaultPage("Message=SPAInvalidLogin")
            ActiveForm = frmApprovals
            lblError.Text = "Invalid Login !!"
            m_blnLoginValid = False
        Else
            If CType(drValidateLogin("LoginType"), String) = "E" Then
                Session("intUserID") = drValidateLogin("EmployeeID")
                Session("strUserName") = drValidateLogin("UserName")
                Session("strLoginName") = drValidateLogin("LoginName")
                Session("intLoginID") = drValidateLogin("LoginID")
                Session("intPostID") = drValidateLogin("RoleID")
                Session("LoginType") = drValidateLogin("LoginType")
            Else
                Session("intUserID") = drValidateLogin("CustomerID")
                Session("strUserName") = drValidateLogin("CustomerName")
                Session("strLoginName") = drValidateLogin("LoginName")
                Session("intLoginID") = drValidateLogin("LoginID")
                Session("intPostID") = drValidateLogin("RoleID")
                Session("LoginType") = drValidateLogin("LoginType")
            End If
            Session("LoginTime") = DateTime.Now.ToString()


            'Dim cookies As HttpCookie
            'cookies = New HttpCookie("RememberMe", CommonFunctions.General.EncryptString("False"))
            'cookies.Expires = DateTime.Now.AddYears(100)
            'Context.Current.Response.Cookies.Add(cookies)
        End If



        CommonFunctions.Data.DisposeDataReader(drValidateLogin)
    End Sub

#End Region



 





    'Protected Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs)

    '    Dim drLeaves As System.Data.IDataReader
    '    Dim strDetails As New StringBuilder()


    '    'drLeaves = CommonFunctions.Data.GetDataReader("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), True)

    '    'While drLeaves.Read()
    '    '    Dim objLink As New Web.UI.MobileControls.Link()
    '    '    Dim objTextView As New Web.UI.MobileControls.TextView()

    '    '    objLink.ID = "lnkLeave_" + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()
    '    '    objLink.NavigateUrl = "LeaveApproval.aspx?LeaveID=" + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()
    '    '    objLink.Text = CommonFunctions.Data.CheckIsDBNull(drLeaves("EmployeeName"), "").ToString()

    '    '    objTextView.ID = "txtLeave_" + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()

    '    '    strDetails.Append("From: ")
    '    '    If CommonFunctions.Data.CheckIsDBNull(drLeaves("FromDate"), "").ToString() <> "" Then
    '    '        strDetails.Append(CommonFunctions.Dates.GetDate(drLeaves("FromDate")) & " ")
    '    '    Else
    '    '        strDetails.Append("- ")
    '    '    End If

    '    '    strDetails.Append("To: ")
    '    '    If CommonFunctions.Data.CheckIsDBNull(drLeaves("ToDate"), "").ToString() <> "" Then
    '    '        strDetails.Append(CommonFunctions.Dates.GetDate(drLeaves("ToDate")) & " ")
    '    '    Else
    '    '        strDetails.Append("- ")
    '    '    End If

    '    '    strDetails.Append("Leave Type: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveType"), "").ToString() & " ")
    '    '    strDetails.Append("Leave Balance: ") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveBalance"), "0.0").ToString() & " ")
    '    '    strDetails.Append("Half day:") : strDetails.Append(CommonFunctions.Data.CheckIsDBNull(drLeaves("HalfDay"), "No").ToString() & " ")

    '    '    'objTextView.Text = CommonFunctions.Data.CheckIsDBNull(drLeaves("FromDate"), "").ToString() + " " + CommonFunctions.Data.CheckIsDBNull(drLeaves("ToDate"), "").ToString() + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveType"), "").ToString()
    '    '    objTextView.Text = strDetails.ToString()
    '    '    strDetails.Length = 0
    '    '    Page.FindControl("frmLeaveApproval").Controls.Add(objLink)
    '    '    Page.FindControl("frmLeaveApproval").Controls.Add(objTextView)

    '    'End While
    '    'strDetails = Nothing
    '    'drLeaves = Nothing

    '    'If Not IsPostBack Then

    '    Dim arrLeave As New ArrayList()
    '    Dim strEmployeeName As String = ""
    '    Dim strFrom As String = ""
    '    Dim strTo As String = ""
    '    Dim strLeaveType As String = ""
    '    Dim strBalance As String = ""
    '    Dim strIsHalfDay As String = ""


    '    drLeaves = CommonFunctions.Data.GetDataReader("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0").ToString(), True)
    '    While drLeaves.Read()
    '        Dim objTxtArea As New Web.UI.MobileControls.TextBox()

    '        objTxtArea.ID = "txtLeave_" + CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveID"), "0").ToString()

    '        strEmployeeName = CommonFunctions.Data.CheckIsDBNull(drLeaves("EmployeeName"), "").ToString()
    '        If CommonFunctions.Data.CheckIsDBNull(drLeaves("FromDate"), "").ToString() <> "" Then
    '            strFrom = CommonFunctions.Dates.GetDate(drLeaves("FromDate"))
    '        End If
    '        If CommonFunctions.Data.CheckIsDBNull(drLeaves("ToDate"), "").ToString() <> "" Then
    '            strTo = CommonFunctions.Dates.GetDate(drLeaves("ToDate"))
    '        End If
    '        strLeaveType = CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveType"), "").ToString()
    '        strBalance = CommonFunctions.Data.CheckIsDBNull(drLeaves("LeaveBalance"), "0.0").ToString()
    '        strIsHalfDay = CommonFunctions.Data.CheckIsDBNull(drLeaves("HalfDay"), "No").ToString()

    '        arrLeave.Add(New cLeave _
    '        (strEmployeeName, strFrom, strTo, strLeaveType, strBalance, strIsHalfDay))

    '        LeaveApprovalList.DataSource = arrLeave
    '        LeaveApprovalList.DataBind()

    '        LeaveApprovalList.TableFields = "EmployeeName;From;ToDate;LeaveType;LeaveBalance" ';IsHalfDay"
    '        LeaveApprovalList.LabelField = "EmployeeName"

    '        Page.FindControl("frmLeaveApproval").FindControl("LeaveApprovalList").Controls.Add(objTxtArea)
    '    End While
    '    'End If

    'End Sub


    '    ' Structure for ArrayList records
    '    Private Class cLeave
    '        ' A private class for the Grocery List
    '        Private _EmployeeName, _From, _ToDate, _LeaveType, _LeaveBalance, _IsHalfDay As String

    '        Public Sub New(ByVal strEmployeeName As String, _
    '            ByVal strFrom As String, ByVal strTo As String, ByVal strLeaveType As String, _
    '            ByVal strLeaveBalance As String, ByVal strIsHalfDay As String)

    '            _EmployeeName = strEmployeeName
    '            _From = strFrom
    '            _ToDate = strTo
    '            _LeaveType = strLeaveType
    '            _LeaveBalance = strLeaveBalance
    '            _IsHalfDay = strIsHalfDay

    '        End Sub

    '        Public ReadOnly Property EmployeeName() As String
    '            Get
    '                Return _EmployeeName
    '            End Get
    '        End Property
    '        Public ReadOnly Property From() As String
    '            Get
    '                Return _From
    '            End Get
    '        End Property
    '        Public ReadOnly Property ToDate() As String
    '            Get
    '                Return _ToDate
    '            End Get
    '        End Property
    '        Public ReadOnly Property LeaveType() As String
    '            Get
    '                Return _LeaveType
    '            End Get
    '        End Property
    '        Public ReadOnly Property LeaveBalance() As String
    '            Get
    '                Return _LeaveBalance
    '            End Get
    '        End Property
    '        Public ReadOnly Property IsHalfDay() As String
    '            Get
    '                Return _IsHalfDay
    '            End Get
    '        End Property
    '    End Class


    '    ' Command event for buttons
    '    Private Sub LeaveApprovalList_Click(ByVal sender As Object, _
    '        ByVal e As ObjectListCommandEventArgs)

    '    End Sub

    '    ' Count items in each department
    '    Private Sub LeaveApprovalList_ItemDataBind(ByVal sender As Object, ByVal e As ObjectListDataBindEventArgs)

    '    End Sub

    '</script>

   
   



    Protected Sub cmdLogin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdLogin.Click
        If Page.IsValid Then
            lblError.Text = ""
            Session.Remove("intUserID")
            If (Session("intUserID") Is Nothing) Then
                m_blnLoginValid = True
                Call LoginPanel()
                If m_blnLoginValid Then
                    'ActiveForm = frmApprovalMenu
                    Response.Redirect("Mobile_Approvals.aspx")
                End If
            End If
        End If
    End Sub
End Class
