Public Class PRO_ProjectAccess
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ''Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Added By Vaijat K ON 19/04/2017 For Unauthenticated user can view this page.
    End Sub

#End Region

#Region " Form level variables declaration "
    Private m_LoginId As Long 'Login Id
    Private m_LoginType As String 'Login type
    Private m_RoleId As Long 'Role Id
    Private m_RoleLevel As Integer 'Role level
    Protected m_ProjectId As Long 'Project Id
    Private m_UserId As Long 'User Id
    Private m_UserName As String 'User Name
    Private m_CultureId As Long 'Culture Id
    Protected m_FromWhere As String 'From where ?

    Private m_blnAddAccess As Boolean = False 'user has Add Access ?
    Private m_blnDeleteAccess As Boolean = False 'User has Delete Access ?
    Private m_blnEditAccess As Boolean = False 'User has Edit Access ?

    Protected blnShowAll As Boolean = False
    'Modified by MrugajaB on Date 03 Jully,2006 for WhizibleSEM Issue ID.4168
    Protected strMode As String

    Protected intEmployeeID As Integer
    Protected strEmployeeName As String
    'Global object
    Protected m_objGlobal As WebPages.Template.IGlobal

#End Region

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

    End Sub 'Constructor for the page

    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : Main procedure to build page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================
        Dim strMenu As String

        Call CreateGlobalObject()

        Call SetVariables()

        If strMode.ToUpper = "SAVE" Then
            Call SaveSQAAssignment()
        End If

        strMenu = GenerateMenu()

        Response.Write(strMenu)

        Response.Write("<DIV id=DivMain>")
        Response.Write("<BR>")

        Call GeneratePageCaption()

        Response.Write("<BR>")

        Call GeneratePageheader()

        Response.Write("<BR>")

        Select Case strMode.ToUpper
            Case "EDIT"

                Call ShowListBoxes()

            Case Else
                Call PlotGrid()
        End Select

        Response.Write("</DIV >")

        Response.Write("<BR>" + strMenu)
        'm_objGlobal = Nothing

    End Sub 'Main procedure to build page

    Private Sub GeneratePageheader()

        'Initialize standard menu resource file 
        'MyBase.InitializeResources("AppResources.PRO_ProjectAccess", "AppResources")

        Dim objHeader As New WebPage.Templates.HeaderFooter
        objHeader.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeader.DrawHeaderFooter(m_objGlobal)
        objHeader = Nothing

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Private Sub GeneratePageCaption()

        Dim objcaption As New WebPage.Templates.PageCaption
        objcaption.GetPageCaptions(m_objGlobal)
        objcaption = Nothing
    End Sub

    Private Sub SaveSQAAssignment()

        If MyBase.GetFormValue("lstAccessibleProjects") Is Nothing Then Exit Sub

        Dim strSQL As String, inti As Integer

        'Delete records for EMployee
        strSQL = "EXEC usp_del_ProjectAccess " + intEmployeeID.ToString
        CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
        strSQL = Nothing

        If MyBase.GetFormValue("lstAccessibleProjects") = "" Then Exit Sub

        'Insert new records
        Dim ProjectIds() As String
        ProjectIds = Split(MyBase.GetFormValue("lstAccessibleProjects"), ",")

        For inti = 0 To UBound(ProjectIds)
            strSQL = "EXEC usp_PM_ProjectAccess " + intEmployeeID.ToString + "," + ProjectIds(inti).ToString
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            strSQL = Nothing
        Next

        ProjectIds = Nothing

    End Sub

    Private Sub PlotGrid()
        Dim objSQAGrid As New WebPage.Templates.GenericGrid

        Dim ArrActualColumnNames() As String = {"EmployeeName", "RoleDescription"}
        Dim ArrUserFriendlyColumnNames() As String = {"Employee Name", "Designation"}
        Dim ArrRowLinks() As String = {"EditAccess(EmployeeId,'EmployeeName')"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        With objSQAGrid
            .ActualColumnArray = ArrActualColumnNames
            .UserFriendlyColumnArray = ArrUserFriendlyColumnNames
            .RowLinkArray = ArrRowLinks
            .NoOfDataColumns = 2
            .DIVID = "DivList"
            .DIVStyle = "overflow:auto;width:100%"
            .SQL = "usp_Sel_tbl_PM_Employee_SQAAssignment"
            .UseSQL = MyBase.UseSQL
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .DrawGrid()
        End With

        objSQAGrid = Nothing
        ArrActualColumnNames = Nothing
        ArrUserFriendlyColumnNames = Nothing
        ArrRowLinks = Nothing

    End Sub

    Private Sub ShowListBoxes()

        Dim strAllProjectsSQL, strAccessibleProjectSQL As String

        If Not blnShowAll Then
            strAllProjectsSQL = "usp_PM_ProjectUserAccess_AllProjects 1," + intEmployeeID.ToString
            strAccessibleProjectSQL = "EXEC usp_PM_Assigned_ProjectUserAccess 1," + intEmployeeID.ToString
        Else
            strAllProjectsSQL = "usp_PM_ProjectUserAccess_AllProjects 0," + intEmployeeID.ToString
            strAccessibleProjectSQL = "EXEC usp_PM_Assigned_ProjectUserAccess 0," + intEmployeeID.ToString
        End If

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.PRO_ProjectAccess", "AppResources")

        ''display Page Caption
        'Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGEHEADER") + " " + strEmployeeName))
        'Response.Write("<BR>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE class=clstable cellspacing=0 cellpadding=0 width=99.9%>")
        Response.Write("<TR class=clsTREven>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'All Projects
        Response.Write("<TD align=center >")
        Response.Write(MyBase.GetResourceString("ALLPROJECTS"))
        Response.Write("</TD>")

        Response.Write("<TD align=center >")
        Response.Write("</TD>")


        'Accessible project
        Response.Write("<TD align=center >")
        Response.Write(MyBase.GetResourceString("ACCESSIBLEPROJECTS"))
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("</TABLE>")

        Response.Write("<br>")

        'Disaply list boxes
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        Response.Write("<TABLE class=clstable cellspacing=0 cellpadding=0 width=99.9%>")
        Response.Write("<TR class=clsTREven>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'All Projects
        Response.Write("<TD align=center valign=center>")
        CommonFunction.HTMLControls.DrawListBox("lstAllProjects", strAllProjectsSQL, 250, 385, , "ondblclick=javascript:GrantAccess_OnClick()")
        Response.Write("</TD>")

        'Links
        Response.Write("<TD align=center valign=center>")
        Response.Write("<a HREF='javascript:GrantAccess_OnClick()'><img id='lnkGrantAccess' border=0 src='../../images/right.gif' LANGUAGE='javascript' WIDTH=18 HEIGHT=14></a>")
        Response.Write("<BR><BR><BR>")
        Response.Write("<a HREF='javascript:RevokeAccess_OnClick()'><img id='lnkRevokeAccess' border=0 src='../../images/left.gif' LANGUAGE='javascript' WIDTH=18 HEIGHT=14></a>")
        Response.Write("</TD>")

        'Accessible Projects
        Response.Write("<TD align=center valign=center>")
        CommonFunction.HTMLControls.DrawListBox("lstAccessibleProjects", strAccessibleProjectSQL, 250, 385, , "ondblclick=javascript:RevokeAccess_OnClick()")
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("</TABLE>")


    End Sub

    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the Issue Filters page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : menu string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        If strMode.ToUpper = "EDIT" Then

            'Initialize standard menu resource file 
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

            'Save
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SAVE"))
            ArrClientSideFunctionsList.Add("Save_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP"))

            'Initialize standard menu resource file 
            MyBase.InitializeResources("AppResources.PRO_ProjectAccess", "AppResources")

            'Show All Projects
            If blnShowAll Then
                'Show PMP Ready Projects
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOWPMPREADYPROJECTS"))
                ArrClientSideFunctionsList.Add("ShowPMPReady_OnClick()")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOWPMPREADYPROJECTS_TOOLTIP"))
            Else
                'Show All Projects
                ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_SHOWALLPROJECTS"))
                ArrClientSideFunctionsList.Add("ShowAll_OnClick()")
                ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_SHOWALLPROJECTS_TOOLTIP"))

            End If

            'Initialize standard menu resource file 
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

            'Back
            ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_BACK"))
            ArrClientSideFunctionsList.Add("Back_OnClick()")
            ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_BACK_TOLTIP"))
        End If

        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('469')")
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP"))

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function

    Private Sub SetVariables()

        'Status
        If Not Request.QueryString("Show") Is Nothing Then
            If Request.QueryString("Show").ToUpper = "ALL" Then
                blnShowAll = True
            Else
                blnShowAll = False
            End If
        Else
            blnShowAll = False
        End If

        'Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode") <> "" Then
                strMode = Request.QueryString("Mode")
            Else
                strMode = ""
            End If
        Else
            strMode = ""
        End If

        'Employee ID
        If Not Request.QueryString("EmployeeID") Is Nothing Then
            If Request.QueryString("EmployeeID") <> "" Then
                intEmployeeID = CType(Request.QueryString("EmployeeID"), Integer)
            Else
                intEmployeeID = 0
            End If
        Else
            intEmployeeID = 0
        End If

        'Employee Name
        If Not Request.QueryString("EmployeeName") Is Nothing Then
            If Request.QueryString("EmployeeName") <> "" Then
                strEmployeeName = Request.QueryString("EmployeeName").ToString
            Else
                strEmployeeName = ""
            End If
        Else
            strEmployeeName = ""
        End If
    End Sub

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 24, 2004
        ' Revisions             :
        '=====================================================================


        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        m_objGlobal = MyBase.GlobalObject
        With m_objGlobal
            m_LoginId = .LoginID
            m_LoginType = .LoginType
            m_RoleId = .RoleID
            m_RoleLevel = .RoleLevel
            m_ProjectId = .ProjectID
            m_UserId = .UserID
            m_UserName = .UserName
            m_CultureId = .LCID
            m_FromWhere = .FromWhere
        End With

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(m_objGlobal)

        m_blnAddAccess = objAccess.Add 'If user has AddNew Access
        m_blnDeleteAccess = objAccess.Delete 'If User has Delete Access
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        'objAccess = Nothing
    End Sub 'Get all session variable values

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGlobal = Nothing
    End Sub
End Class
