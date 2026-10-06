#Region "Imports"
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
Imports System.Globalization
Imports System.Text
Imports Authentication
Imports System.Net
#End Region

Public Class Approvals
    Inherits WebPages.Template.WhizTemplate


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.ID = "frm_Approvals"

    End Sub
    Protected WithEvents divTbl As System.Web.UI.HtmlControls.HtmlGenericControl
    Protected WithEvents txtPassword As System.Web.UI.HtmlControls.HtmlInputText
    Protected WithEvents txtLogin As System.Web.UI.HtmlControls.HtmlInputText
    Protected WithEvents chkRememberPassword As System.Web.UI.HtmlControls.HtmlInputCheckBox
    Protected WithEvents txtInvalidLogin As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents txtIsCookiesExist As System.Web.UI.HtmlControls.HtmlInputHidden
    Protected WithEvents txtContentTab As System.Web.UI.HtmlControls.HtmlInputHidden
    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Event Variables Declaretions"
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu    'This variable is used for plotting static menu. 
    Private WithEvents m_objLeavesGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objIRGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objExpenseGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objProjectGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objProjectTimeSheetGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objResourceTimeSheetGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSectionTitleLeave As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleIR As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleExpense As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleProject As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleProjectTimeSheet As New WebPage.Templates.SectionTitle
    Private WithEvents m_objSectionTitleResourceTimeSheet As New WebPage.Templates.SectionTitle
#End Region
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
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Private m_dsGrid As DataSet
    Private m_GridName As StructGridName = New StructGridName
    Private m_IsCurrentCookiesExist As Boolean = False
    Private m_blnIsApprover As Boolean = False



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

#Region " initialize the page here - Page_Load"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If txtContentTab.Value <> "" Then
            m_strContentTab = Server.UrlDecode(txtContentTab.Value)
        Else
            m_strContentTab = m_GridName.LEAVE
        End If


        Dim blnChangeUserFlag As Boolean = False
        If Not Session("LoginTime") Is Nothing Then
            Dim dtmLoginTime As DateTime
            dtmLoginTime = CType(Session("LoginTime"), DateTime)
            If dtmLoginTime.AddMinutes(m_dblSessionTimeOut) < DateTime.Now Then
                Session.Abandon()
                Call RemovePreviousLogin()
                Response.Clear()
                Session("LoginTime") = Nothing
                RedirectToDefaultPage("Message=SessionExpired")
            End If
        End If

        Call IsCookiesExist()
        Call IsCurrentCookiesExist()
        Call InitilizeGlobalVariable(sender)
        If m_blnIsWindowsAuthenticated And Not m_blnIsValidDomain Then
            RedirectToDefaultPage("Approvals.aspx?Message=InvalidDomain")
        End If

        If HttpContext.Current.Request.QueryString("MODE") Is Nothing Then
            If HttpContext.Current.Request.QueryString("Message") Is Nothing Then
                If Not HttpContext.Current.Request.QueryString("FromWhere") Is Nothing Then
                    If HttpContext.Current.Request.QueryString("FromWhere").ToUpper() = "LOGOUT" Then
                        Session.Abandon()
                        Call RemovePreviousLogin()
                        Response.Clear()
                        RedirectToDefaultPage("Message=Logout")
                    End If

                    If (Session("intUserID") Is Nothing) Then
                        If HttpContext.Current.Request.QueryString("FromWhere").ToUpper() = "LOGIN" Then
                            Call LoginPanel()
                        End If
                    End If

                End If
                If HttpContext.Current.Request.QueryString.Count = 0 Then
                    Call AutomaticallyLogin()
                End If

            Else

                Session.Abandon()
                Call RemovePreviousLogin()
                Response.Clear()
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "SPAINVALIDLOGIN" Then
                    blnChangeUserFlag = True
                    txtInvalidLogin.Value = "SPAInvalidLogin"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "SESSIONEXPIRED" Then
                    txtInvalidLogin.Value = "SessionExpired"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "LDAPINVALIDLOGIN" Then
                    blnChangeUserFlag = True
                    txtInvalidLogin.Value = "LDAPInvalidLogin"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "INVALIDDOMAIN" Then
                    txtInvalidLogin.Value = "InvalidDomain"
                End If
                If HttpContext.Current.Request.QueryString("Message").ToUpper = "LOGOUT" Then
                    txtInvalidLogin.Value = ""
                End If

            End If
        End If

        If ((Not HttpContext.Current.Request.Cookies.Get("RememberMe") Is Nothing) And (Not HttpContext.Current.Request.Cookies.Get("SPAUserName") Is Nothing)) Then
            Dim getCookies As HttpCookie
            Dim getCurrentCookies As HttpCookie
            Dim strCurrentCookiesValue As String
            getCookies = HttpContext.Current.Request.Cookies.Get("RememberMe")
            getCurrentCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
            strCurrentCookiesValue = DecryptString(getCurrentCookies.Value)
            Dim strUserName As String = strCurrentCookiesValue.Substring(0, strCurrentCookiesValue.IndexOf("<=>"))
            If DecryptString(getCookies.Value) = "True" Then
                If blnChangeUserFlag = False Then
                    txtLogin.Value = strUserName
                    chkRememberPassword.Checked = True
                End If

            End If
        End If


       

    End Sub

#End Region

#Region " General Function Definition"
    Private Function IsCurrentCookiesExist() As Boolean
        If Not (HttpContext.Current.Request.Cookies.Get("SPAUserName") Is Nothing) Then
            m_IsCurrentCookiesExist = True
        Else
            m_IsCurrentCookiesExist = False
        End If
    End Function
    Private Function IsCookiesExist() As Boolean
        If (txtIsCookiesExist.Value.ToUpper() <> "NOTEXIST") Then
            m_IsCookiesExist = True
        Else
            m_IsCookiesExist = False
        End If
    End Function
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

        Dim drRoleName As IDataReader
        Dim strSQL As String

        strSQL = "EXEC usp_Sel_tbl_PM_Role " & CType(Session("intPostID"), Long)
        drRoleName = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drRoleName.Read Then
            GetRole = CType(drRoleName("RoleDescription"), String) & ""
        End If
        CommonFunction.Data.DisposeDataReader(drRoleName)


    End Function
    Private Function GenerateMenu() As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top and bottom menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 9:57 AM 9/17/2007
        ' Revisions             :
        '=====================================================================
        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList
     
        ArrTopMenuCaptionsList.Add("Approve")
        ArrTopMenuToolTipsList.Add("Approve")
        ArrTopMenuFunctionsList.Add("Approve_OnClick()")

        ArrTopMenuCaptionsList.Add("Select All")
        ArrTopMenuToolTipsList.Add("Select All")
        ArrTopMenuFunctionsList.Add("SelectAll_OnClick()")

        ArrTopMenuCaptionsList.Add("Clear All")
        ArrTopMenuToolTipsList.Add("Claer All")
        ArrTopMenuFunctionsList.Add("ClearAllOnClick()")

        ArrTopMenuCaptionsList.Add("Close")
        ArrTopMenuToolTipsList.Add("Close")
        ArrTopMenuFunctionsList.Add("Close_OnClick()")

        ArrTopMenuCaptionsList.Add("Help")
        ArrTopMenuToolTipsList.Add("Help")

        If m_strContentTab.ToUpper = m_GridName.LEAVE.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('LeaveHelp')")
        End If
        If m_strContentTab.ToUpper = m_GridName.RESOURCE_TIMESHEET.ToUpper Then
            ArrTopMenuFunctionsList.Add("Help_OnClick('ResourceTimesheetHelp')")
        End If

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing
        Return m_objMenu.DrawMenuWithEvents(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)
    End Function
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

        Dim objPW As PWEncryption = New PWEncryption(m_strOrgLogin, m_strPassword)
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

        Return CommonFunction.General.GetApplicationKeySetting("AuthenticationType").ToString

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
        strUserName = CType(sender, Approvals).User.Identity.Name.ToString
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

        Dim drAccess As IDataReader
        Dim strQuery As String
        Dim strSql As String
        Dim strCount As String
        Dim blnResult As Boolean
        strSql = "USP_GET_Valid_ExpenseSheetApprover " & strExpenseSheetID & "," & m_objGlobal.UserID & ",1"
        strCount = CType(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL), String)
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

        Dim strLDAPServer As String = CommonFunction.General.GetApplicationKeySetting("LDAPServerName").ToString
        Dim strLogFileName As String = CommonFunction.FileDirectory.GetLogFileName("LDAP").ToString
        Dim strLogPath As String = CommonFunction.FileDirectory.CleanPath(Server.MapPath("Attachments/Log"))
        Dim Objldap As LDAPAuthentication = New LDAPAuthentication("LDAP://" & strLDAPServer, strLogPath & strLogFileName)


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
        If CType(sender, Approvals).User.Identity.IsAuthenticated Then
            IsWindowsAuthenticated = True
            LoginName = ExtractUserName(sender)
        Else
            IsWindowsAuthenticated = False : LoginName = ""
        End If
    End Function

#End Region
#Region " General Procedure Definition"

    Protected Sub DrawGo()
        '=====================================================================
        ' Procedure Name        : DrawGo()	
        ' Purpose               : Draw the Submit button for login page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 3:51 PM 9/13/2007
        ' Revisions             : 
        '=====================================================================



        Dim strHTML As New StringBuilder
        strHTML.Append("<IMG class='go' name='Go' id='Go' height='17' src='images/nextbutton1.gif' width='17' tabindex='4' onclick='login()' onkeypress=Password_OnKeyPress(event) >")
        Response.Write(strHTML.ToString)
        strHTML = Nothing

    End Sub
    Protected Sub TabContent()

        '=====================================================================
        ' Procedure Name        : TabContent()	
        ' Purpose               : Draw the tab button for detail page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 4:10 PM 10/10/2007
        ' Revisions             : 
        '=====================================================================

        CommonFunctions.General.WriteHTML("<ul id='countrytabs' class='shadetabs' valign='top'>")

        If m_strContentTab.ToUpper = m_GridName.LEAVE.ToUpper Then
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.LEAVE) + """)' id=""" + m_GridName.LEAVE + """ class = selected>" + m_GridName.LEAVE + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.LEAVE) + """)' id=""" + m_GridName.LEAVE + """ >" + m_GridName.LEAVE + " </a></li>&nbsp;")
        End If
        'If m_strContentTab.ToUpper = m_GridName.IR.ToUpper Then
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.IR) + """)' id=""" + m_GridName.IR + """ class = selected>" + m_GridName.IR + " </a></li>&nbsp;")
        'Else
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.IR) + """)' id=""" + m_GridName.IR + """ >" + m_GridName.IR + " </a></li>&nbsp;")
        'End If
        'If m_strContentTab.ToUpper = m_GridName.EXPENSE.ToUpper Then
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.EXPENSE) + """)' id=""" + m_GridName.EXPENSE + """ class = selected>" + m_GridName.EXPENSE + " </a></li>&nbsp;")
        'Else
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.EXPENSE) + """)' id=""" + m_GridName.EXPENSE + """ >" + m_GridName.EXPENSE + " </a></li>&nbsp;")
        'End If
        'If m_strContentTab.ToUpper = m_GridName.PROJECT.ToUpper Then
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT) + """)' id=""" + m_GridName.PROJECT + """ class = selected>" + m_GridName.PROJECT + " </a></li>&nbsp;")
        'Else
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT) + """)' id=""" + m_GridName.PROJECT + """ >" + m_GridName.PROJECT + " </a></li>&nbsp;")
        'End If
        'If m_strContentTab.ToUpper = m_GridName.PROJECT_TIMESHEET.ToUpper Then
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT_TIMESHEET) + """)' id=""" + m_GridName.PROJECT_TIMESHEET + """ class = selected>" + m_GridName.PROJECT_TIMESHEET + " </a></li>&nbsp;")
        'Else
        '    CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.PROJECT_TIMESHEET) + """)' id=""" + m_GridName.PROJECT_TIMESHEET + """ >" + m_GridName.PROJECT_TIMESHEET + " </a></li>&nbsp;")
        'End If
        If m_strContentTab.ToUpper = m_GridName.RESOURCE_TIMESHEET.ToUpper Then
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.RESOURCE_TIMESHEET) + """)' id=""" + m_GridName.RESOURCE_TIMESHEET + """ class = selected>" + m_GridName.RESOURCE_TIMESHEET + " </a></li>&nbsp;")
        Else
            CommonFunctions.General.WriteHTML("<li><a href='javascript:ContentTab(""" + Server.UrlEncode(m_GridName.RESOURCE_TIMESHEET) + """)' id=""" + m_GridName.RESOURCE_TIMESHEET + """ >" + m_GridName.RESOURCE_TIMESHEET + " </a></li>&nbsp;")
        End If



        CommonFunctions.General.WriteHTML("</ul>")

    End Sub
    Protected Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build the page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV 
        ' Created               : 3:51 PM 9/13/2007
        ' Revisions             : 
        '=====================================================================
        Dim blnNoItemsFoundFlag As Boolean = True

        If Not HttpContext.Current.Request.QueryString("Message") Is Nothing Then
            Session.Abandon()
            RedirectToDefaultPage("Message=SessionExpired")
        End If
        If Not (Session("intUserID") Is Nothing) Then

            Call GetGlobalObject()
            Call PlotPageHeadTag()
            Response.Write(GenerateMenu())
            Dim intTotalNoOfGrid As Integer = GridIndex.TOTAL_GRID
            Dim intCount As Integer = 1
            Call Initialize()
            CommonFunction.General.WriteHTML("<TABLE border=0 cellspacing =0 width=99.9%><TR class='clsTRPageHeader'><TD valign='middle' align='left' nowrap width='50%'  height='0.4%'><B>User : " & HttpContext.Current.Server.HtmlEncode(CType(Session("strUserName"), String)) & "(" & HttpContext.Current.Server.HtmlEncode(GetRole()) & ")</B></TD>")
            CommonFunctions.General.WriteHTML("<TD valign='middle' align='right' nowrap width='50%'  height='0.4%'><b>Note :</b> Please select a record to enter Comment.</TD></TR><TR><TD valign='middle' align='left' nowrap width='100%'  height='2%' colspan='2'>&nbsp;</TD></TR>")
            CommonFunctions.General.WriteHTML("<TR class='clsTRPageHeader'><TD valign='middle' align='left' nowrap width='100%'  height='0.4%' colspan='2'><B>Pending Approvals </B></TD></TR></TABLE>")

            Call TabContent()
            CommonFunctions.General.WriteHTML("<div style='border:1px solid gray; width ='100%' padding: 10px'>")
            CommonFunctions.General.WriteHTML("<DIV id='PageDiv' style='overflow:auto;height=440;Width:100%;'>")
            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
            While intTotalNoOfGrid >= intCount

                Select Case intCount
                    Case GridIndex.LEAVE
                        ' To plot Leave Approvals Grid
                        If m_intLeaveTotalNoOfRows > 0 And m_strContentTab = m_GridName.LEAVE Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTREven'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.LEAVE + " Approvals </B></TD></TR></Table>")
                            blnNoItemsFoundFlag = False
                            If m_intLeaveTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.LEAVE, GridIndex.LEAVE)
                            End If
                            Call PlotLeavesGrid()
                            'CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                            CommonFunctions.General.WriteHTML("<TABLE  class='clsGridTable' border=0 cellspacing =1 width=99.9% ><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%'>Total Records :" + CType(m_intLeaveTotalNoOfRows, String) + "</TD></TR></TABLE>")
                        End If
                        'Case GridIndex.IR
                        '    ' To plot IR Approvals Grid
                        '    If m_intIRTotalNoOfRows > 0 Then
                        '         blnNoItemsFoundFlag = False
                        '        If m_intIRTotalNoOfRows > m_intPageSize Then
                        '            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTREven'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.IR + " Approvals </B></TD></TR></Table>")
                        '            Call WritePaging(m_GridName.IR, GridIndex.IR)
                        '        Else
                        '            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTREven'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.IR + " Approvals </B></TD></TR></Table>")
                        '        End If
                        '        Call PlotIRGrid()
                        '        CommonFunctions.General.WriteHTML("<TABLE border=0 cellspacing =0 width=99.9%><TR class=clsTRPageHeader><TD align='right' width = '100%'height='0.4%'>Total Records :" + CType(m_intIRTotalNoOfRows, String) + "</TD></TR></TABLE>")
                        '    End If
                        'Case GridIndex.EXPENSE
                        '    ' To plot Expense Approvals Grid
                        '    If m_intExpenseTotalNoOfRows > 0 Then
                        '         blnNoItemsFoundFlag = False
                        '        If m_intExpenseTotalNoOfRows > m_intPageSize Then
                        '            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTREven'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.EXPENSE + " Approvals </B></TD></TR></Table>")
                        '            Call WritePaging(m_GridName.EXPENSE, GridIndex.EXPENSE)
                        '        Else
                        '            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTREven'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.EXPENSE + " Approvals </B></TD></TR></Table>")
                        '        End If
                        '        Call PlotExpenseApprovals()
                        '        CommonFunctions.General.WriteHTML("<TABLE border=0 cellspacing =0 width=99.9%><TR class=clsTRPageHeader><TD align='right' width = '100%'height='0.4%'>Total Records :" + CType(m_intExpenseTotalNoOfRows, String) + "</TD></TR></TABLE>")
                        '    End If

                        'Case GridIndex.PROJECT
                        '    ' To plot Project Approvals Grid
                        '    If m_intProjectTotalNoOfRows > 0 And m_strContentTab = m_GridName.PROJECT Then
                        '        blnNoItemsFoundFlag = False
                        '        CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTREven'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.PROJECT + " Approvals </B></TD></TR></Table>")
                        '        If m_intProjectTotalNoOfRows > m_intPageSize Then
                        '            Call WritePaging(m_GridName.PROJECT, GridIndex.PROJECT)
                        '        End If
                        '        Call PlotProjectGrid()
                        '        'CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                        '        CommonFunctions.General.WriteHTML("<TABLE  class='clsGridTable' border=0 cellspacing =1 width=99.9% ><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%'>Total Records :" + CType(m_intProjectTotalNoOfRows, String) + "</TD></TR></TABLE>")

                        '    End If
                        'Case GridIndex.PROJECT_TIMESHEET
                        '    ' To plot Project TimeSheet Approvals Grid
                        '    If m_intProjectTimeSheetTotalNoOfRows > 0 Then
                        '         blnNoItemsFoundFlag = False
                        '        If m_intProjectTimeSheetTotalNoOfRows > m_intPageSize Then
                        '            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTREven'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.PROJECT_TIMESHEET + " Approvals </B></TD></TR></Table>")
                        '            Call WritePaging(m_GridName.PROJECT_TIMESHEET, GridIndex.PROJECT_TIMESHEET)
                        '        Else
                        '            CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='1'><TR class='clsTREven'><TD align='left' width = '100%'height='0.4%'><B>" + m_GridName.PROJECT_TIMESHEET + " Approvals </B></TD></TR></Table>")

                        '        End If

                        '        Call PlotProjectTimeSheetGrid()
                        '        CommonFunctions.General.WriteHTML("<TABLE border=0 cellspacing =0 width=99.9%><TR class=clsTRPageHeader><TD align='right' width = '100%'height='0.4%'>Total Records :" + CType(m_intProjectTimeSheetTotalNoOfRows, String) + "</TD></TR></TABLE>")
                        '    End If

                    Case GridIndex.RESOURCE_TIMESHEET
                        ' To plot Resource TimeSheet Approvals Grid
                        If m_intResourceTimeSheetTotalNoOfRows > 0 And m_strContentTab = m_GridName.RESOURCE_TIMESHEET Then
                            CommonFunctions.General.WriteHTML("<Table class='clsGridTable' width=99.9% cellpadding=0 CELLSPACING='1' ><TR class='clsTREven'><TD align='left' width = '100%' height='0.4%'><B>" + m_GridName.RESOURCE_TIMESHEET + " Approvals </B></TD></TR></Table>")
                            blnNoItemsFoundFlag = False
                            If m_intResourceTimeSheetTotalNoOfRows > m_intPageSize Then
                                Call WritePaging(m_GridName.RESOURCE_TIMESHEET, GridIndex.RESOURCE_TIMESHEET)
                            End If
                            Call PlotResourceTimeSheetGrid()
                            'CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                            CommonFunctions.General.WriteHTML("<TABLE  class='clsGridTable' border=0 cellspacing =1 width=99.9% ><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%'>Total Records :" + CType(m_intResourceTimeSheetTotalNoOfRows, String) + "</TD></TR></TABLE>")
                        End If

                End Select
                intCount += 1
            End While
            If blnNoItemsFoundFlag = True Then
                CommonFunctions.General.WriteHTML("<Table class='clsTable' width=99.9% cellpadding=0 CELLSPACING='0' ><TR><TD width='100%'  height='2%' >&nbsp;</TD></TR></Table>")
                CommonFunctions.General.WriteHTML("<TABLE class='clsGridTable' border=0 cellspacing =1 width=99.9%><TR class='clsTREven'><TD align='center' width = '100%' height='0.4%' >There are no items to show in this view.</TD></TR></TABLE>")
            End If
            CommonFunctions.General.WriteHTML("</DIV>")
        Else
            Response.Redirect("Approvals.aspx?Message=SessionExpired")
        End If
        CommonFunctions.General.WriteHTML("</div>")
    End Sub
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
            m_intLeaveTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.LEAVE, , , MyBase.UseSQL)).Tables(m_GridName.LEAVE).Rows.Count
        End If

        'm_intIRTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_Sel_tbl_PM_Rfis_Approval " + m_objGlobal.UserID.ToString(), m_GridName.IR, , , MyBase.UseSQL)).Tables(m_GridName.IR).Rows.Count
        'm_intExpenseTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_tbl_PM_Expensesheet_Expensesheets_For_Approval " + m_objGlobal.UserID.ToString(), m_GridName.EXPENSE, , , MyBase.UseSQL)).Tables(m_GridName.EXPENSE).Rows.Count
        'If m_strContentTab = m_GridName.PROJECT Then
        '    Dim strQuery As String = "EXEC usp_Sel_tbl_PM_Role_IsApprover " + CommonFunction.General.CheckIsNothing(m_objGlobal.UserID, "0").ToString()
        '    m_blnIsApprover = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
        '    If m_blnIsApprover = True Then
        '        m_intProjectTotalNoOfRows = (CommonFunction.Data.GetDataSet("Usp_Sel_tbl_PM_ProjectRevision_Pending_Approval '" + m_objGlobal.UserID.ToString() + "'", m_GridName.PROJECT, , , MyBase.UseSQL)).Tables(m_GridName.PROJECT).Rows.Count
        '    End If
        'End If
        'm_intProjectTimeSheetTotalNoOfRows = (CommonFunction.Data.GetDataSet("usp_sel_tbl_PM_ProjectTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.PROJECT_TIMESHEET, , , MyBase.UseSQL)).Tables(m_GridName.PROJECT_TIMESHEET).Rows.Count
        If m_strContentTab = m_GridName.RESOURCE_TIMESHEET Then
            m_intResourceTimeSheetTotalNoOfRows = (CommonFunction.Data.GetDataSet("usp_sel_tbl_PM_ResourceTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString(), m_GridName.RESOURCE_TIMESHEET, , , MyBase.UseSQL)).Tables(m_GridName.RESOURCE_TIMESHEET).Rows.Count
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


        Dim drLogin As IDataReader
        Dim strWhichLogin As String
        Dim strLoginID As String


        If Request.Form.Item("txtLogin") <> "" Then
            Session.Remove("intUserID")
            Dim blnIsLastLogonValid As Boolean
            blnIsLastLogonValid = CType(CommonFunction.Data.GetDataScalar("EXEC usp_CheckLastLogon '" & CommonFunction.General.BuildQueryString(Request.Form.Item("txtLogin")) & "'," & Request.Form.Item("txtClientLoggedInAt"), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), Boolean)
            If blnIsLastLogonValid = False Then RedirectToDefaultPage("Message=SessionExpired")
        End If

        'Session intUserID Null Start
        If (Session("intUserID") Is Nothing) Then
            If m_blnIsWindowsAuthenticated Then
                m_strLogin = m_strLoginName
                m_strPassword = ""
            Else
                m_strLogin = MyBase.FixString(txtLogin.Value.ToString(), 30, False, True)
                m_strOrgLogin = CommonFunctions.General.UnBuildQueryString(txtLogin.Value.ToString())
                m_strPassword = txtPassword.Value.ToString()
                m_strOrgPassword = CommonFunctions.General.UnBuildQueryString(m_strPassword)

            End If
        End If
        m_strAuthenticationType = GetAuthenticatoinType()

        If Not m_blnIsWindowsAuthenticated Then
            'Call function to set the application variables
            m_strPassword = GetEncryptedPassword()
        End If

        drLogin = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & CommonFunction.General.BuildQueryString(m_strLogin) & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drLogin.Read Then
            strWhichLogin = drLogin("LoginType").ToString()
        Else
            'If Invalid login then redirect to the login page
            Response.Clear()

            RedirectToDefaultPage("Message=SPAInvalidLogin")



        End If
        CommonFunction.Data.DisposeDataReader(drLogin)
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
        Dim drAuthenticationType As IDataReader
        Dim blnIsLDAPAuthentication As Boolean

        drAuthenticationType = CommonFunction.Data.GetDataReader("EXEC usp_Sel_UserAuthenticationType '" & strUserID & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        If drAuthenticationType.Read Then

            blnIsLDAPAuthentication = CType(drAuthenticationType("IsLDAPAuthentication"), Boolean)

            'IF LDAP authentcatin then
            If blnIsLDAPAuthentication = True Then
                'IF LDAP Authentication works	
                If CLng(VallidateLDAPLogin(m_strLogin, strOrgPassword)) = 1 Then
                    Call ValidateSPALogin(1, m_strLogin, strPassword)
                Else 'If LDAP authentication fails
                    Response.Clear()
                    CommonFunction.Data.DisposeDataReader(drAuthenticationType)
                    RedirectToDefaultPage("Message=LDAPInvalidLogin")
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
            CommonFunction.Data.DisposeDataReader(drAuthenticationType)
            Response.Clear()
            RedirectToDefaultPage("Message=SPAInvalidLogin")
        End If
        CommonFunction.Data.DisposeDataReader(drAuthenticationType)
    End Sub
    Private Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name        : PlotPageHeadTag()	
        ' Purpose               : Plot the header tag for Show Pending Approvals page
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
        Dim strLogoutPage As String = "Approvals.aspx?FromWhere=Logout"
        CommonFunctions.General.WriteHTML("<TABLE hieght='200' valign=middle class=clsTableBannerFrame cellpadding=0 cellspacing=0 width='99.9%' bgcolor='#6b88c7'> ")
        CommonFunctions.General.WriteHTML("<TR>")
        CommonFunctions.General.WriteHTML("<TD valign='middle' align='left' nowrap width='50%' >")
        CommonFunctions.General.WriteHTML("<img alt=""Site Logo"" src=""images/symbol.gif"">")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("<TD nowrap title='Logout' align='right' width='50%' >")
        CommonFunctions.General.WriteHTML("<A class='navtab' href='javascript:Logout(" & Chr(34) & strLogoutPage & Chr(34) & ")'> ")
        CommonFunctions.General.WriteHTML("Logout")
        CommonFunctions.General.WriteHTML("</A>")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")



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
            IsCookiesExist()
            ' m_strHostName = HttpContext.Current.Request.ServerVariables.Get("REMOTE_HOST").ToString() + "-" + HttpContext.Current.Request.ServerVariables.Get("REMOTE_ADDR").ToString()
            m_blnIsWindowsAuthenticated = IsWindowsAuthenticated(m_strLoginName, sender)

        Catch ex As Exception

            Dim LOG_ERROR As String
            Dim strLogPath As String

            strLogPath = CommonFunction.FileDirectory.CleanPath(Server.MapPath("Attachments/Log"))
            LOG_ERROR = CommonFunctions.FileDirectory.GetLogFileName("SPA_LOGGED_ERROR")
            CommonFunctions.FileDirectory.WriteFileStream(strLogPath, LOG_ERROR, "*********************************************************" + vbCrLf + "Error (Desciption): " + ex.Message.ToString() + vbCrLf + "Error (Trace)" + ex.StackTrace.ToString() + vbCrLf + "*********************************************************")

        End Try
    End Sub
    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  12:08 PM 9/17/2007
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub
    Private Sub PlotLeavesGrid()
        '=====================================================================
        ' Procedure Name        : PlotLeavesGrid()
        ' Purpose               : To generate the Grid For Leave Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 11:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intLeavePageNumber > 0 Then
            strNumPag = "," + m_intLeavePageNumber.ToString
        Else
            strNumPag = ",0"
        End If
        strsql = "Usp_Sel_tbl_PM_EmployeeLeaveDetails_Pending_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"EmployeeName", "FromDate", "ToDate", "LeaveType", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Employee Name", "From Date", "To Date", "Leave Type", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "chkLeaveApprove"}
        With m_objLeavesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "LeaveID"
            .CheckBoxIDArray = arrCheckBox
            .PageSize = m_intPageSize
            .CurrentPage = m_intLeavePageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            .SortBy = "EmployeeName"
            .SortOrder = "ASC"
            .DIVID = "DivLeaves"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .DrawGrid()
        End With
        m_objLeavesGrid = Nothing
        m_dsGrid = Nothing
    End Sub
    'Private Sub PlotIRGrid()
    '    '=====================================================================
    '    ' Procedure Name        : PlotIRGrid()
    '    ' Purpose               : To generate the Grid For IR Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 6:21 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strNumPag As String
    '    If m_intIRPageNumber > 0 Then
    '        strNumPag = "," + m_intIRPageNumber.ToString
    '    Else
    '        strNumPag = ",0"
    '    End If
    '    strsql = "Usp_Sel_tbl_PM_Rfis_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
    '    m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

    '    Dim arrActualColumns() As String = {"ProjectName", "CustomerName", "RFITypeName", "Amount", "", ""}
    '    Dim arrUserFriendlyColumn() As String = {"Project Name", "Customer Name", "Type", "Amount", "Comment", "Select"}
    '    Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
    '    Dim arrCheckBox() As String = {"", "", "", "", "", "chkExpenseApprove"}
    '    Dim arrstrGroupOnColumn() As String = {"0"}
    '    With m_objIRGrid
    '        .GroupOnColumn = arrstrGroupOnColumn
    '        .UserFriendlyColumnArray = arrUserFriendlyColumn
    '        .ActualColumnArray = arrActualColumns
    '        .CheckBoxIDArray = arrCheckBox
    '        .TDStyleArray = arrTDStyle
    '        .EmptyValueReplacement = "&nbsp;"
    '        .PrimaryKey = "UniqueID"
    '        .PageSize = m_intPageSize
    '        .CurrentPage = m_intIRPageNumber
    '        .GridDataTable = m_dsGrid.Tables(0)
    '        .UseSQL = MyBase.UseSQL
    '        .DIVID = "DivIR"
    '        .DIVHeight = m_intDivHieght
    '        .DIVStyle = "overflow:auto;width:99.99%;"
    '        .NoOfDataColumns = 4
    '        .DrawGrid()
    '    End With

    '    m_objIRGrid = Nothing
    '    m_dsGrid = Nothing

    'End Sub
    'Private Sub PlotExpenseApprovals()
    '    '=====================================================================
    '    ' Procedure Name        : PlotExpenseApprovals()
    '    ' Purpose               : To generate the Grid For Expense Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 2:24 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strNumPag As String
    '    If m_intExpensePageNumber > 0 Then
    '        strNumPag = "," + m_intExpensePageNumber.ToString
    '    Else
    '        strNumPag = ",0"
    '    End If

    '    strsql = "Usp_tbl_PM_Expensesheet_Expensesheets_For_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
    '    m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

    '    Dim arrActualColumns() As String = {"Title", "SubmittedBy", "CurrencySymbol", "TotalAmount", "StatusDate", "", ""}
    '    Dim arrUserFriendlyColumn() As String = {"Title", "Submitted By", "CurrencySymbol", "TotalAmount", "Status Change Date", "Comment", "Select"}
    '    Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
    '    Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkExpenseApprove"}
    '    With m_objExpenseGrid
    '        .UserFriendlyColumnArray = arrUserFriendlyColumn
    '        .ActualColumnArray = arrActualColumns
    '        .TDStyleArray = arrTDStyle
    '        .EmptyValueReplacement = "&nbsp;"
    '        .PrimaryKey = "ExpenseSheetID"
    '        .CheckBoxIDArray = arrCheckBox
    '        .PageSize = m_intPageSize
    '        .CurrentPage = m_intExpensePageNumber
    '        .GridDataTable = m_dsGrid.Tables(0)
    '        .UseSQL = MyBase.UseSQL
    '        .DIVID = "DivExpense"
    '        .DIVHeight = m_intDivHieght
    '        .DIVStyle = "overflow:auto;width:99.99%;"
    '        .NoOfDataColumns = 5
    '        .DrawGrid()
    '    End With
    '    m_objExpenseGrid = Nothing
    '    m_dsGrid = Nothing
    'End Sub
    'Private Sub PlotProjectGrid()
    '    '=====================================================================
    '    ' Procedure Name        : PlotProjectGrid()
    '    ' Purpose               : To generate the Grid For Project Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 12:15 PM 9/14/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strNumPag As String
    '    If m_intProjectPageNumber > 0 Then
    '        strNumPag = "," + m_intProjectPageNumber.ToString
    '    Else
    '        strNumPag = ",0"
    '    End If

    '    strsql = "Usp_Sel_tbl_PM_ProjectRevision_Pending_Approval  '" + m_objGlobal.UserID.ToString() + "' " + strNumPag
    '    m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

    '    Dim arrActualColumns() As String = {"ProjectName", "ProjectType", "ExpectedStartDate", "ExpectedEndDate", "", ""}
    '    Dim arrUserFriendlyColumn() As String = {"Project Name", "Practice", "Start Date", "End Date", "Comment", "Select"}
    '    Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
    '    Dim arrCheckBox() As String = {"", "", "", "", "", "chkProjectApprove"}
    '    With m_objProjectGrid
    '        .UserFriendlyColumnArray = arrUserFriendlyColumn
    '        .ActualColumnArray = arrActualColumns
    '        .CheckBoxIDArray = arrCheckBox
    '        .TDStyleArray = arrTDStyle
    '        .EmptyValueReplacement = "&nbsp;"
    '        .PrimaryKey = "ProjectID"
    '        .PageSize = m_intPageSize
    '        .CurrentPage = m_intProjectPageNumber
    '        .GridDataTable = m_dsGrid.Tables(0)
    '        .UseSQL = MyBase.UseSQL
    '        .DIVID = "DivProject"
    '        .DIVHeight = m_intDivHieght
    '        .DIVStyle = "overflow:auto;width:99.99%;"
    '        .NoOfDataColumns = 4
    '        .DrawGrid()
    '    End With

    '    m_objProjectGrid = Nothing
    '    m_dsGrid = Nothing

    'End Sub
    'Private Sub PlotProjectTimeSheetGrid()
    '    '=====================================================================
    '    ' Procedure Name        : PlotProjectGrid()
    '    ' Purpose               : To generate the Grid For Project TimeSheet Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 12:55 PM 9/14/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strNumPag As String
    '    If m_intProjectTimeSheetPageNumber > 0 Then
    '        strNumPag = "," + m_intProjectTimeSheetPageNumber.ToString
    '    Else
    '        strNumPag = ",0"
    '    End If

    '    strsql = "usp_sel_tbl_PM_ProjectTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
    '    m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

    '    Dim arrActualColumns() As String = {"CreatedDate1", "ProjectName", "FromDate", "ToDate", "", ""}
    '    Dim arrUserFriendlyColumn() As String = {"Date", "Project Name", "From Date", "To Date", "Comment", "Select"}
    '    Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
    '    Dim arrCheckBox() As String = {"", "", "", "", "", "chkProjectTimesheetApprover"}
    '    With m_objProjectTimeSheetGrid
    '        .UserFriendlyColumnArray = arrUserFriendlyColumn
    '        .ActualColumnArray = arrActualColumns
    '        .CheckBoxIDArray = arrCheckBox
    '        .TDStyleArray = arrTDStyle
    '        .EmptyValueReplacement = "&nbsp;"
    '        .PrimaryKey = "TimeSheetNo"
    '        .PageSize = m_intPageSize
    '        .CurrentPage = m_intProjectTimeSheetPageNumber
    '        .GridDataTable = m_dsGrid.Tables(0)
    '        .UseSQL = MyBase.UseSQL
    '        .DIVID = "DivProjectTimeSheet"
    '        .DIVHeight = m_intDivHieght
    '        .DIVStyle = "overflow:auto;width:99.99%;"
    '        .NoOfDataColumns = 4
    '        .DrawGrid()
    '    End With

    '    m_objProjectTimeSheetGrid = Nothing
    '    m_dsGrid = Nothing

    'End Sub
    Private Sub PlotResourceTimeSheetGrid()
        '=====================================================================
        ' Procedure Name        : PlotResourceTimeSheetGrid()
        ' Purpose               : To generate the Grid For Resource TimeSheet Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:18 PM 9/14/2007
        ' Revisions             :
        '=====================================================================
        Dim strNumPag As String
        If m_intResourceTimeSheetPageNumber > 0 Then
            strNumPag = "," + m_intResourceTimeSheetPageNumber.ToString
        Else
            strNumPag = ",0"
        End If

        strsql = "usp_sel_tbl_PM_ResourceTimesheet_Pending_Approval " + m_objGlobal.UserID.ToString() + "" + strNumPag
        m_dsGrid = CommonFunctions.Data.GetDataSet(strsql, "default", , , Me.UseSQL)

        Dim arrActualColumns() As String = {"EmployeeName", "FromDate", "ToDate", "TotalAMH", "", ""}
        Dim arrUserFriendlyColumn() As String = {"Employee Name", "From Date", "To Date", "Actual Work(hrs)", "Comment", "Select"}
        Dim arrTDStyle() As String = {"align=left", "align=left", "align=left", "align=left", "align=center", "align=center"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "chkResourceTimesheetApprover"}
        With m_objResourceTimeSheetGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckBox
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "TimesheetID"
            .PageSize = m_intPageSize
            .CurrentPage = m_intResourceTimeSheetPageNumber
            .GridDataTable = m_dsGrid.Tables(0)
            .UseSQL = MyBase.UseSQL
            .SortBy = "EmployeeName"
            .SortOrder = "ASC"
            .DIVID = "DivResourceTimeSheet"
            .DIVHeight = m_intDivHieght
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 4
            .DrawGrid()

        End With

        m_objResourceTimeSheetGrid = Nothing
        m_dsGrid = Nothing

    End Sub
    Private Sub AutomaticallyLogin()
        '=====================================================================
        ' Procedure Name        : AutomaticallyLogin()	
        ' Purpose               : If session has not been expired then it will allow to user for Automatically Login
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

        If m_IsCurrentCookiesExist Then

            Dim dtmLoginTime As DateTime
            Dim objCurrentCookies As HttpCookie
            Dim strCurrentCookiesValue As String
            m_blnAutomaticallyLoginFlag = True
            objCurrentCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
            strCurrentCookiesValue = DecryptString(objCurrentCookies.Value)
            dtmLoginTime = CType(strCurrentCookiesValue.Substring(strCurrentCookiesValue.LastIndexOf("<=>") + 3), DateTime)
            dtmLoginTime = dtmLoginTime.AddMinutes(m_dblSessionTimeOut)
            If dtmLoginTime < DateTime.Now Then
                If (Session("intUserID") Is Nothing) Then
                    RedirectToDefaultPage("Message=SessionTimeOut")
                End If

            Else
                If (Session("intUserID") Is Nothing) Then

                    txtLogin.Value = strCurrentCookiesValue.Substring(0, strCurrentCookiesValue.IndexOf("<=>"))
                    Dim startIndex As Integer = strCurrentCookiesValue.IndexOf("<=>") + 3
                    Dim endIndex As Integer = strCurrentCookiesValue.LastIndexOf("<=>")
                    Dim strPass As String = strCurrentCookiesValue.Substring(startIndex, endIndex - startIndex)
                    txtPassword.Value = strPass
                    chkRememberPassword.Checked = True
                    LoginPanel()
                End If
            End If
        End If
    End Sub
    Private Sub RemovePreviousLogin()
        '=====================================================================
        ' Procedure Name        : RemovePreviousLogin()	
        ' Purpose               : If session has been expired then it will remove the previous login entry form Application variable
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

        If m_IsCurrentCookiesExist Then
            Dim objCurrentCookies As HttpCookie
            Dim strCurrentCookiesValue As String
            Dim dtmLoginTime As DateTime
            Dim timespan As TimeSpan
            Dim strLoginTime As String
            objCurrentCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
            strCurrentCookiesValue = DecryptString(objCurrentCookies.Value)
            dtmLoginTime = CType(strCurrentCookiesValue.Substring(strCurrentCookiesValue.LastIndexOf("<=>") + 3), DateTime)
            strLoginTime = dtmLoginTime.AddMinutes(-m_dblSessionTimeOut).ToString()
            strLoginTime = strCurrentCookiesValue.Substring(0, strCurrentCookiesValue.LastIndexOf("<=>")).ToString() + "<=>" + strLoginTime
            Dim cookies As New HttpCookie("SPAUserName", EncryptString(strLoginTime))
            cookies.Expires = DateTime.Now.AddYears(100)
            HttpContext.Current.Response.Cookies.Add(cookies)

        End If



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
        ' Author				:	MahendraV
        ' Created				:	11:47 AM 9/27/2007
        ' Revisions				:	
        '=====================================================================
        Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        If strRedirectToPage.Trim = "" Then
            Response.Clear()
            Response.Redirect("Approvals.aspx?" & QueryString, True)
        Else
            Response.Redirect(strRedirectToPage & "?" & QueryString, True)
        End If

    End Sub
    Private Sub WritePaging(ByVal strGridName As String, ByVal intGridNo As Integer)
        '=====================================================================
        ' function Name         : WritePaging(ByVal strGridName As String, ByVal intGridNo As Integer)
        ' Purpose               : To write the paging for the request grid
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                :  MahendraV
        ' Created               : 11:10 AM 9/17/2007
        ' Revisions             :
        '=====================================================================

        Dim strSectionTag As String = strGridName + "divGrid"
        Dim strFunctionName As String = strGridName + "ShowHide_divGrid"
        Dim intRecordCount As Integer
        Dim dsObject As DataSet
        Dim strPaging As String = ""

        strPaging = "<TABLE border='0' cellspacing = '1' width = '100%' height='0.4%' class='clsGridTable'><TR class='clsTREven'><TD align='right' width = '100%' height='0.4%' colspan = '2' >"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage(" + CType(intGridNo, String) + ")"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage(" + CType(intGridNo, String) + ")""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='Images/NumNavPreviousEnable.gif' align='top'></A>"

        Select Case intGridNo
            Case GridIndex.LEAVE
                m_intTotalNoOfRows = m_intLeaveTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intLeavePageNumber Then
                    m_intLeavePageNumber = 1
                End If

                If m_intLeavePageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                    'Else
                    '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intLeavePageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True, EnableHTMLEncode:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intLeavePageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True, EnableHTMLEncode:=True)
                    ''end of Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                End If

                'Case GridIndex.IR
                '    m_intTotalNoOfRows = m_intIRTotalNoOfRows
                '    If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intIRPageNumber Then
                '        m_intIRPageNumber = 1
                '    End If
                '    If m_intIRPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    Else
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intIRPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    End If
                'Case GridIndex.EXPENSE
                '    m_intTotalNoOfRows = m_intExpenseTotalNoOfRows
                '    If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intExpensePageNumber Then
                '        m_intExpensePageNumber = 1
                '    End If
                '    If m_intExpensePageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    Else
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intExpensePageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    End If
                'Case GridIndex.PROJECT
                '    m_intTotalNoOfRows = m_intProjectTotalNoOfRows
                '    If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intProjectPageNumber Then
                '        m_intProjectPageNumber = 1
                '    End If
                '    If m_intProjectPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    Else
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intProjectPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    End If
                'Case GridIndex.PROJECT_TIMESHEET
                '    m_intTotalNoOfRows = m_intProjectTimeSheetTotalNoOfRows
                '    If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intProjectTimeSheetPageNumber Then
                '        m_intProjectTimeSheetPageNumber = 1
                '    End If
                '    If m_intProjectTimeSheetPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    Else
                '        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intProjectTimeSheetPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                '    End If
            Case GridIndex.RESOURCE_TIMESHEET
                m_intTotalNoOfRows = m_intResourceTimeSheetTotalNoOfRows
                If Math.Ceiling(m_intTotalNoOfRows / m_intPageSize) < m_intResourceTimeSheetPageNumber Then
                    m_intResourceTimeSheetPageNumber = 1
                End If
                If m_intResourceTimeSheetPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
                    ''Commented and added by Nilesh g on 3/8/2016 for Html Encoding
                    '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                    'Else
                    '    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intResourceTimeSheetPageNumber.ToString, "right", tobeinserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True)
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True, EnableHTMLEncode:=True)
                Else
                    strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber" + CType(intGridNo, String), "txtPageNumber" + CType(intGridNo, String), , 50, 4, m_intResourceTimeSheetPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event," + CType(intGridNo, String) + ")", returnHTML:=True, EnableHTMLEncode:=True)

                End If
        End Select

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage(" + CType(intGridNo, String) + ")"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage(" + CType(intGridNo, String) + ")"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages" + CType(intGridNo, String) + " value=" + (Math.Ceiling(m_intTotalNoOfRows / m_intPageSize)).ToString + ">"
        strPaging += "of " + (Math.Ceiling(m_intTotalNoOfRows / m_intPageSize)).ToString
        strPaging += " |<A href='javascript:NumPage_OnClick(""-1""," + CType(intGridNo, String) + ")' TITLE='Show All Records'><B>All</B> </A>"
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages" + CType(intGridNo, String), "txtNoOfPages" + CType(intGridNo, String), , , , (Math.Ceiling(m_intTotalNoOfRows / m_intPageSize)).ToString, returnhtml:=True, displaynone:=True)
        strPaging += "</TD></TR></TABLE>"

        Select Case intGridNo
            Case GridIndex.LEAVE
                Response.Write(m_objSectionTitleLeave.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleLeave.ClientsideScript & "</script>")
                'Case GridIndex.IR
                '    Response.Write(m_objSectionTitleIR.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                '    Response.Write("<script language=javascript>" & m_objSectionTitleIR.ClientsideScript & "</script>")

                'Case GridIndex.EXPENSE
                '    Response.Write(m_objSectionTitleExpense.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                '    Response.Write("<script language=javascript>" & m_objSectionTitleExpense.ClientsideScript & "</script>")

                'Case GridIndex.PROJECT
                '    Response.Write(m_objSectionTitleProject.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                '    Response.Write("<script language=javascript>" & m_objSectionTitleProject.ClientsideScript & "</script>")

                'Case GridIndex.PROJECT_TIMESHEET
                '    Response.Write(m_objSectionTitleProjectTimeSheet.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                '    Response.Write("<script language=javascript>" & m_objSectionTitleProjectTimeSheet.ClientsideScript & "</script>")

            Case GridIndex.RESOURCE_TIMESHEET
                Response.Write(m_objSectionTitleResourceTimeSheet.GetSectionTitle(MyBase.GetResourceString("REQUESTS_CAPTION"), strSectionTag, strFunctionName, , strPaging, , , , , , , , False, False))
                Response.Write("<script language=javascript>" & m_objSectionTitleResourceTimeSheet.ClientsideScript & "</script>")

        End Select
        dsObject = Nothing

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
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                'Case GridIndex.IR

                '    Dim drDetails As IDataReader
                '    Dim intProjectID As Integer
                '    strQuery = "EXEC usp_Sel_tbl_PM_RFIs " & strUniqueID
                '    drDetails = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                '    If drDetails.Read Then
                '        intProjectID = CType(CommonFunctions.General.CheckIsNothing(drDetails.Item("ProjectID"), "0"), Integer)
                '    End If
                '    CommonFunctions.Data.DisposeDataReader(drDetails)
                '    ' Build query to update the RFI status and insert the Status History record.
                '    strQuery = "EXEC usp_Upd_tbl_PM_RFIs_ChangeRFIStatus " & strUniqueID & ", " & intProjectID
                '    strQuery = strQuery & ", '" & CommonFunctions.General.BuildQueryString("Approved") & "'"
                '    strQuery = strQuery & ", '" & CommonFunctions.General.BuildQueryString(strComment) & "'"
                '    strQuery = strQuery & ", '" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                '    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                'Case GridIndex.EXPENSE

                '    Dim drExpensesEntryID As IDataReader
                '    Dim m_blnisValidExpenses As Boolean = False
                '    Dim strExpensesEntryIds As String = ""
                '    Dim strExpenseEntryCommentsList As String = ""

                '    strQuery = "SELECT ExpensesEntryID FROM tbl_PM_ExpenseSheet_Details WHERE ExpenseSheetID = " + strUniqueID
                '    drExpensesEntryID = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                '    While drExpensesEntryID.Read()
                '        strExpensesEntryIds = strExpensesEntryIds + CType(CommonFunctions.Data.CheckIsDBNull(drExpensesEntryID("ExpensesEntryID"), "0"), String) + ","
                '        strExpenseEntryCommentsList = strExpenseEntryCommentsList + strComment + ":#:"
                '    End While
                '    CommonFunctions.Data.DisposeDataReader(drExpensesEntryID)

                '    strExpensesEntryIds = strExpensesEntryIds.Substring(0, strExpensesEntryIds.LastIndexOf(","))
                '    If m_objGlobal.UserID.ToString() <> "" And strUniqueID <> "" Then
                '        strQuery = "EXEC usp_Sel_CheckValidExpenseEntries " & m_objGlobal.UserID.ToString() & ", 1," & strUniqueID & ",'" & strExpensesEntryIds & ",'"
                '        m_blnisValidExpenses = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Boolean)
                '    End If

                '    If m_blnisValidExpenses = False Or CheckApproverAccess(strUniqueID) = False Then
                '        'action to take on invalid login
                '        Session.Abandon()
                '        Response.Write("<script language=javascript>" & vbCrLf)
                '        Response.Write("	window.open(""../../Approvals.aspx?Message=SessionExpired"",""_self"");" & vbCrLf)
                '        Response.Write("</script>" & vbCrLf)
                '        Response.End()
                '    Else
                '        strQuery = "usp_upd_tbl_PM_ExpenseEntry_Approved "
                '        strQuery += strUniqueID + ", '" + strExpensesEntryIds + "' , '"
                '        strQuery += strExpenseEntryCommentsList + "', "
                '        strQuery += m_objGlobal.UserID.ToString() + ",1"
                '        CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
                '    End If


                'Case GridIndex.PROJECT

                '    strQuery = "EXEC usp_Ins_tbl_PM_Project_BaselineRevisionReason "
                '    strQuery = strQuery & "'" & CType(strUniqueID, String) & "',"
                '    strQuery = strQuery & "'" & CommonFunction.General.BuildQueryString(strComment) & "',"
                '    strQuery = strQuery & "'" & CommonFunction.General.BuildQueryString(CommonFunction.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()) & "','A' "
                '    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)


                'Case GridIndex.PROJECT_TIMESHEET

                '    strQuery = "EXEC usp_Upd_tbl_PM_TimeSheetInvoice '" & strUniqueID & "',"
                '    strQuery = strQuery & "'" & CommonFunction.General.BuildQueryString(strComment) & "'"
                '    strQuery = strQuery & ",'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                '    CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            Case GridIndex.RESOURCE_TIMESHEET

                Dim drVerify As IDataReader
                Dim m_drTimesheet As IDataReader
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
                m_drTimesheet = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

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
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                Loop

                'Change Status to Verified in tbl_PM_ResourceTimesheetStatus table
                strSQLQuery = "Exec usp_Upd_tbl_PM_ResourceTimesheetStatus " & strUniqueID & "," & CType(intVerifiedBy, String) & "," & "'V'"
                CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                CommonFunctions.Data.DisposeDataReader(drVerify)


                'If Resource TimeSheet are verified then change the status to 'verified' 
                strSQLQuery = "Exec usp_Sel_ResourceTimesheet_GetVerifiedTasksStatus " & CType(strUniqueID, String)
                drVerify = CommonFunctions.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

                If drVerify.Read = False Then
                    strSQLQuery = "Exec usp_Upd_ResouceTimesheetStatus " & CType(strUniqueID, String) & ",'V'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                End If

                CommonFunctions.Data.DisposeDataReader(drVerify)
                CommonFunctions.Data.DisposeDataReader(m_drTimesheet)
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

        Dim drValidateLogin As IDataReader
        Dim strSQLQuery As String
        Select Case intHowToValidate
            Case 0 'SPA Validation
                'Constructing the SQL Query
                strSQLQuery = "EXEC usp_ValidateLogin '" & CommonFunction.General.BuildQueryString(m_strLogin) & "','" & Trim(m_strPassword) & "'"
                drValidateLogin = CommonFunction.Data.GetDataReader(strSQLQuery, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            Case 1 'LDAP Validation
                drValidateLogin = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_PM_Login_For_LoginName '" & CommonFunction.General.BuildQueryString(m_strLogin) & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

        End Select

        If Not drValidateLogin.Read Then

            RedirectToDefaultPage("Message=SPAInvalidLogin")

        Else
            If CType(drValidateLogin("LoginType"), String) = "E" Then
                Session("intUserID") = drValidateLogin("EmployeeID")
                Session("strUserName") = drValidateLogin("UserName")
                Session("strLoginName") = drValidateLogin("LoginName")
                Session("intLoginID") = drValidateLogin("LoginID")
                Session("intPostID") = drValidateLogin("RoleID")
            Else
                Session("intUserID") = drValidateLogin("CustomerID")
                Session("strUserName") = drValidateLogin("CustomerName")
                Session("strLoginName") = drValidateLogin("LoginName")
                Session("intLoginID") = drValidateLogin("LoginID")
                Session("intPostID") = drValidateLogin("RoleID")
            End If
            Session("LoginTime") = DateTime.Now.ToString()

            If (chkRememberPassword.Checked = True) Then
                If m_blnAutomaticallyLoginFlag = False Then

                    Dim cookies As HttpCookie
                    Dim strUserName As String = Session("strLoginName").ToString()
                    Dim strUserPassword As String = txtPassword.Value.ToString()
                    Dim strUserLoginTime As String = System.DateTime.Now.ToString()
                    Dim strCurrentCookiesInfo As String = EncryptString(strUserName + "<=>" + strUserPassword + "<=>" + strUserLoginTime)

                    cookies = New HttpCookie("SPAUserName", strCurrentCookiesInfo)
                    cookies.Expires = DateTime.Now.AddYears(100)
                    Context.Current.Response.Cookies.Add(cookies)
                    cookies = Nothing

                    cookies = New HttpCookie("RememberMe", EncryptString("True"))
                    cookies.Expires = DateTime.Now.AddYears(100)
                    Context.Current.Response.Cookies.Add(cookies)
                    cookies = Nothing

                    Dim getCookies As HttpCookie
                    getCookies = HttpContext.Current.Request.Cookies.Get("SPAUserName")
                    Dim strCookiesInfo As String = DecryptString(getCookies.Value)
                    Dim strLoginName As String = strCookiesInfo.Substring(0, strCookiesInfo.IndexOf("<=>"))
                    Dim strLoginTime As String = strCookiesInfo.Substring(strCookiesInfo.LastIndexOf("<=>") + 3)
                    strLogPath = CommonFunction.FileDirectory.CleanPath(Server.MapPath("Attachments/Log"))
                    LOG_FILE = CommonFunctions.FileDirectory.GetLogFileName("SPA_LOGGED_INFO")
                    CommonFunctions.FileDirectory.WriteFileStream(strLogPath, LOG_FILE, "*********************************************************" + vbCrLf + "User Name : " + strLoginName + vbCrLf + "Login Time :" + strLoginTime + vbCrLf + "*********************************************************")

                    getCookies = Nothing
                Else
                    m_blnAutomaticallyLoginFlag = False
                End If
            Else
                Dim cookies As HttpCookie
                cookies = New HttpCookie("RememberMe", EncryptString("False"))
                cookies.Expires = DateTime.Now.AddYears(100)
                Context.Current.Response.Cookies.Add(cookies)
            End If
        End If



        CommonFunction.Data.DisposeDataReader(drValidateLogin)
    End Sub

#End Region

#Region " General Events Definition"
    Private Sub m_objLeavesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objLeavesGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objLeavesGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For Leaves Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intLeaveID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strEmployeeName As String
        intLeaveID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), Integer)
        strUniqueID = CType(intLeaveID, String)
        strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
        strEmployeeName = strEmployeeName.Replace("'", "").Trim()

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strEmployeeName + " for " + m_GridName.LEAVE + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkLeaveShow", "chkLeaveShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intLeaveID"",1) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + "'  src='Images/SPA/Details.gif' expand='true' onclick='javascript:DisplayComment(1,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("LeaveID"), "0"), String) + ")'> <IMG src='Images/Star.gif' border=0> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If

    End Sub
    'Private Sub m_objIRGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objIRGrid.DataRowTD_BeforePrint
    '    '=====================================================================
    '    ' Procedure Name        : m_objIRGrid_DataRowTD_BeforePrint()
    '    ' Purpose               : To modify the Grid For IR Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 2:24 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strUniqueID As String
    '    Dim strTxtName As String
    '    Dim intUniqueID As Integer
    '    Dim blnIsChecked As Boolean = False
    '    Dim strProjectName As String
    '    Dim strAmmount As String
    '    intUniqueID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), Integer)
    '    strProjectName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
    '    strAmmount = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Amount"), ""), String)
    '    strProjectName = strProjectName.Replace("'", "")
    '    strAmmount = strAmmount.Replace("'", "").Trim()
    '    strUniqueID = CType(intUniqueID, String)
    '    If Args.ColumnName.ToUpper = "SELECT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strProjectName + " of Ammount " + strAmmount + " for " + m_GridName.IR + " Aprrovals'>"
    '        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkIRShow", "chkIRShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intUniqueID"",2) ", True)
    '        Args.StringToBeInserted &= "</TD>"
    '    End If
    '    If Args.ColumnName.ToUpper = "COMMENT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + "'  src='Images/SPA/Details.gif' expand='true' onclick='javascript:DisplayComment(2,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("UniqueID"), "0"), String) + ")'> <IMG src='Images/Star.gif' border=0> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
    '    End If
    'End Sub
    'Private Sub m_objExpenseGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objExpenseGrid.ColumnHeaderTD_BeforePrint
    '    '=====================================================================
    '    ' Procedure Name        : m_objExpenseGrid_ColumnHeaderTD_BeforePrint()
    '    ' Purpose               : To modify the Grid For Expense Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 2:24 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================

    '    If Args.ColumnName = "CurrencySymbol" Then
    '        Cancel = True
    '        Args.ApplySorting = False
    '        Args.StringToBeInserted = ""
    '    End If
    '    If Args.ColumnName = "TotalAmount" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD nowrap colspan=2 align=center Title=""""ID : 51 Column Name : Total Amount""><B>" + Args.ColumnName + "</B></TD>"

    '    End If
    'End Sub
    'Private Sub m_objExpenseGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objExpenseGrid.DataRowTD_BeforePrint
    '    '=====================================================================
    '    ' Procedure Name        : m_objExpenseGrid_ColumnHeaderTD_BeforePrint()
    '    ' Purpose               : To modify the Grid For Expense Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 2:24 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strUniqueID As String
    '    Dim strTxtName As String
    '    Dim intExpenseSheetID As Integer
    '    Dim blnIsChecked As Boolean = False
    '    Dim strTitle As String
    '    intExpenseSheetID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), Integer)
    '    strTitle = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Title"), ""), String)
    '    strUniqueID = CType(intExpenseSheetID, String)
    '    strTitle = strTitle.Replace("'", "").Trim()

    '    If Args.ColumnName.ToUpper = "SELECT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strTitle + " for " + m_GridName.EXPENSE + " Approvals'>"
    '        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkExpenseShow", "chkExpenseShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intExpenseSheetID"",3) ", True)
    '        Args.StringToBeInserted &= "</TD>"
    '    End If
    '    If Args.ColumnName.ToUpper = "COMMENT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + "'  src='Images/SPA/Details.gif' expand='true' onclick='javascript:DisplayComment(3,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), String) + ")'> <IMG src='Images/Star.gif' border=0> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
    '    End If
    'End Sub
    'Private Sub m_objProjectGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objProjectGrid.DataRowTD_BeforePrint
    '    '=====================================================================
    '    ' Procedure Name        : m_objProjectGrid_DataRowTD_BeforePrint()
    '    ' Purpose               : To modify the Grid For Project Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 2:24 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strUniqueID As String
    '    Dim strTxtName As String
    '    Dim intProjectID As Integer
    '    Dim blnIsChecked As Boolean = False
    '    Dim strProjectName As String
    '    intProjectID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), Integer)
    '    strProjectName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
    '    strProjectName = strProjectName.Replace("'", "").Trim()
    '    strUniqueID = CType(intProjectID, String)
    '    If Args.ColumnName.ToUpper = "SELECT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strProjectName + " for " + m_GridName.PROJECT + " Approvals'>"
    '        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkProjectShow", "chkProjectShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intProjectID"",4) ", True)
    '        Args.StringToBeInserted &= "</TD>"
    '    End If
    '    If Args.ColumnName.ToUpper = "COMMENT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + "'  src='Images/SPA/Details.gif' expand='true' onclick='javascript:DisplayComment(4,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("ProjectID"), "0"), String) + ")'> <IMG src='Images/Star.gif' border=0> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
    '    End If
    'End Sub
    'Private Sub m_objProjectTimeSheetGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objProjectTimeSheetGrid.DataRowTD_BeforePrint
    '    '=====================================================================
    '    ' Procedure Name        : m_objProjectTimeSheetGrid_DataRowTD_BeforePrint()
    '    ' Purpose               : To modify the Grid For Project TimeSheet Approvals
    '    ' Parameters Passed     : None
    '    ' Returns               : NA
    '    ' Parameters Affected   : 
    '    ' Assumptions           : 
    '    ' Dependencies          : 
    '    ' Author                : MahendraV
    '    ' Created               : 2:24 PM 9/13/2007
    '    ' Revisions             :
    '    '=====================================================================
    '    Dim strUniqueID As String
    '    Dim strTxtName As String
    '    Dim intTimeSheetNo As Integer
    '    Dim blnIsChecked As Boolean = False
    '    Dim strProjectName As String
    '    intTimeSheetNo = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), Integer)
    '    strProjectName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectName"), ""), String)
    '    strProjectName = strProjectName.Replace("'", "").Trim()
    '    strUniqueID = CType(intTimeSheetNo, String)
    '    If Args.ColumnName.ToUpper = "SELECT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strProjectName + " for " + m_GridName.PROJECT_TIMESHEET + " Approvals'>"
    '        Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkProjectTimeSheetShow", "chkProjectTimeSheetShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intTimeSheetNo"",5) ", True)
    '        Args.StringToBeInserted &= "</TD>"
    '    End If
    '    If Args.ColumnName.ToUpper = "COMMENT" Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + "'  src='Images/SPA/Details.gif' expand='true' onclick='javascript:DisplayComment(5,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimeSheetNo"), "0"), String) + ")'> <IMG src='Images/Star.gif' border=0> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
    '    End If
    'End Sub
    Private Sub m_objResourceTimeSheetGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objResourceTimeSheetGrid.DataRowTD_BeforePrint
        '=====================================================================
        ' Procedure Name        : m_objResourceTimeSheetGrid_DataRowTD_BeforePrint()
        ' Purpose               : To modify the Grid For Resource TimeSheet Approvals
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : 2:24 PM 9/13/2007
        ' Revisions             :
        '=====================================================================
        Dim strUniqueID As String
        Dim strTxtName As String
        Dim intTimesheetID As Integer
        Dim blnIsChecked As Boolean = False
        Dim strEmployeeName As String
        intTimesheetID = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), Integer)
        strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
        strEmployeeName = strEmployeeName.Replace("'", "").Trim()
        strUniqueID = CType(intTimesheetID, String)
        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align='center'> <input type='hidden' id='Title_" + strUniqueID + "' name='Title_" + strUniqueID + "' value = '" + strEmployeeName + " for " + m_GridName.RESOURCE_TIMESHEET + " Approvals'>"
            Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawCheckBox("chkResourceTimeSheetShow", "chkResourceTimeSheetShow", , blnIsChecked, strUniqueID, , "language=Javascript OnClick=chkShow_OnClick(""intTimesheetID"",6) ", True)
            Args.StringToBeInserted &= "</TD>"
        End If
        If Args.ColumnName.ToUpper = "COMMENT" Then
            Cancel = True
            Args.StringToBeInserted = "<td align='center' style='border-width:1px; CURSOR: hand;'><img id='img_" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + "'  src='Images/SPA/Details.gif' expand='true' onclick='javascript:DisplayComment(6,event," + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + ")' alt='Click to add Comment' onfocus:'javascript:Comment_onFocus(" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TimesheetID"), "0"), String) + ")'> <IMG src='Images/Star.gif' border=0> <input type='hidden' id='txt_" + strUniqueID + "' name='txt_" + strUniqueID + "'</td>"
        End If
    End Sub
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        '=====================================================================
        ' Procedure Name        : m_objMenu_Before_Link_Print()
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
        If Not HttpContext.Current.Request.QueryString("MODE") Is Nothing Then
            If HttpContext.Current.Request.QueryString("MODE").ToUpper = "APPROVED" Then
                If Args.FunctionName.ToUpper = "APPROVE_ONCLICK()" Then
                    Dim UniqueID As String
                    Dim m_strUniqueIDs As String = ""
                    Dim strGetUniqueID As String
                    Dim strComment As String
                    Dim intTotalNoOfGrid As Integer = GridIndex.TOTAL_GRID
                    Dim intCount As Integer = 1
                    While intTotalNoOfGrid >= intCount

                        Select Case intCount
                            Case GridIndex.LEAVE
                                m_strUniqueIDs = Request.Form("chkLeaveShow")
                                AprrovedSelectedRow(m_strUniqueIDs, GridIndex.LEAVE)
                                'Case GridIndex.IR
                                '    m_strUniqueIDs = Request.Form("chkIRShow")
                                '    AprrovedSelectedRow(m_strUniqueIDs, GridIndex.IR)
                                'Case GridIndex.EXPENSE
                                '    m_strUniqueIDs = Request.Form("chkExpenseShow")
                                '    AprrovedSelectedRow(m_strUniqueIDs, GridIndex.EXPENSE)
                                'Case GridIndex.PROJECT
                                '    m_strUniqueIDs = Request.Form("chkProjectShow")
                                '    AprrovedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT)
                                'Case GridIndex.PROJECT_TIMESHEET
                                '    m_strUniqueIDs = Request.Form("chkProjectTimeSheetShow")
                                '    AprrovedSelectedRow(m_strUniqueIDs, GridIndex.PROJECT_TIMESHEET)
                            Case GridIndex.RESOURCE_TIMESHEET
                                m_strUniqueIDs = Request.Form("chkResourceTimeSheetShow")
                                AprrovedSelectedRow(m_strUniqueIDs, GridIndex.RESOURCE_TIMESHEET)
                        End Select
                        intCount += 1
                    End While
                End If
            End If
        End If
    End Sub

#End Region
End Class


