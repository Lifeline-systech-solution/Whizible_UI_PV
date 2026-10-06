Public Class CRM_FilterList
    Inherits WebPages.Template.WhizTemplate

    Protected m_strAction As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    Protected m_strAlphabet As String = "-1"
    Protected m_strFromWhere As String = ""
    Protected m_intRefresh As Integer = 0

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

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
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()
        Call PerformActions()

    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        '' MyBase.ApplySecurity(False, 2)
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 25,2004
        ' Revisions             :
        '=====================================================================

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing Then
            m_strAlphabet = Request.QueryString("PageNumber").ToString
        End If
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        ' from where?? DB/SR/AR
        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        Else
            m_strFromWhere = ""
        End If

        ' Sort by of the page
        If Not Request.QueryString("SortBy") Is Nothing Then
            m_strSortBy = Request.QueryString("SortBy").ToString
        Else
            m_strSortBy = "FilterName"
        End If
        ' Sort order of the page
        If Not Request.QueryString("SortOrder") Is Nothing Then
            m_strSortOrder = Request.QueryString("SortOrder").ToString
        Else
            m_strSortOrder = "ASC"
        End If

        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub


    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 25,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Select Case UCase(Trim(m_strAction & ""))
            Case "DELETE"
                If Trim(MyBase.GetFormValue("chkDelete") & "") <> "" Then
                    strSQL = "usp_CRM_Delete_Filters  '" & CommonFunctions.General.BuildQueryString(MyBase.GetFormValue("chkDelete") & "") & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                    m_intRefresh = 1
                End If
            Case "SET_DEFAULT"
                If Not Request.QueryString("DefaultFilterID") Is Nothing Then
                    ' Login Type Condition Added by Harshada D on 22 11 2005
                    strSQL = "usp_CRM_SetDefaultFilter   " & m_lngEmployeeID & ",'" & Request.QueryString("DefaultFilterID") & "','" & CommonFunctions.General.BuildQueryString(m_strFromWhere & "") & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "'"

                    CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                End If
            Case Else

        End Select

    End Sub


    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 25,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_ADD_NEW"), MyBase.GetResourceString("MENU_DELETE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_ADD_NEW_TOOLTIP"), MyBase.GetResourceString("MENU_DELETE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunction() As String = {"AddNew_OnClick()", "Delete_OnClick()", "Close_OnClick()", "Help_OnClick('CRM_FILTERS')"}
        Dim strSQL As String
        Dim strPaging As String
        Dim strFromWhere As String

        MyBase.InitializeResources("AppResources.CRM_FilterList", "AppResources")

        Dim arrActualCols() As String = {"FilterID", "FilterName", "CreatedDate", "FilterText", MyBase.GetResourceString("LINK_SETASDEFAULT")}
        Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("COL_FILTERID"), MyBase.GetResourceString("COL_FILTERNAME"), MyBase.GetResourceString("COL_CREATEDON"), MyBase.GetResourceString("COL_FILTER"), MyBase.GetResourceString("COL_SETASDEFAULT"), MyBase.GetResourceString("COL_DELETE")}
        Dim arrRowLink() As String = {"", "Filter_OnClick(FilterID)", "", "", "SetAsDefault_OnClick(FilterID)"}
        Dim arrChkBox() As String = {"", "", "", "", "", "chkDelete"}

        ' get the paging string
        strPaging = WebPages.Template.Paging.DrawPaging(m_strAlphabet, "usp_sel_tbl_CRM_Filters_Paging " & m_lngEmployeeID, "", "Page_OnClick", "FilterName")

        ' menu
        WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False, strPaging)

        Response.Write("<BR>")

        MyBase.InitializeResources("AppResources.CRM_RequestList", "AppResources")
        Select Case UCase(Trim(m_strFromWhere & ""))
            Case "SR" : strFromWhere = MyBase.GetResourceString("SUBMITTED_REQUESTS_CAPTION")
            Case "AR" : strFromWhere = MyBase.GetResourceString("ASSIGNED_REQUESTS_CAPTION")
            Case "DB" : strFromWhere = MyBase.GetResourceString("EDASHBOARD_CAPTION")
                'Added by PrashantSJ on 09 Nov 2006 For WhizibleSEM SP8 Build 1 Enhacements
                'Purpose: Page caption having name My e-Dashboard.
            Case "MD" : strFromWhere = MyBase.GetResourceString("MYEDASHBOARD_CAPTION")
                'End of addition by PrashantSJ on09 Nov 2006
            Case Else : strFromWhere = ""
        End Select

        MyBase.InitializeResources("AppResources.CRM_FilterList", "AppResources")
        'page caption
        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("FILTERS_CAPTION") & " [" & strFromWhere & "]"))
        Response.Write("<BR>")


        ' sql for grid
        strSQL = "usp_sel_tbl_CRM_Filters  null," & m_lngEmployeeID
        If Trim(m_strSortBy & "") <> "" Then
            strSQL &= ",'" & CommonFunctions.General.BuildQueryString(m_strSortBy) & "'"
        Else
            strSQL &= strSQL & ",null"
        End If

        If Trim(m_strSortOrder & "") <> "" Then
            strSQL &= ",'" & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
        Else
            strSQL &= ",null"
        End If
        ' ->using double build querystring for single qoutes( in the sp sql is string built)
        strSQL &= ",'" & CommonFunctions.General.BuildQueryString(CommonFunctions.General.BuildQueryString(m_strAlphabet)) & "'"
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        ' grid
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            .NoOfDataColumns = 4
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .RowLinkArray = arrRowLink
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .CheckBoxIDArray = arrChkBox
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DIVHeight = 300
            .DIVStyle = "overflow:auto"
            .DIVID = "divList"
            .PrimaryKey = "FilterID"
            .DrawGrid()
        End With
        m_objGrid = Nothing

        WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip, False)


    End Sub


#Region "events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        ' dont show the "Set as default" link if already is a default for the current mode
        If Args.ColIndex = 4 Then
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("IsDefault_" & UCase(Trim(m_strFromWhere & ""))), "0"), Boolean) Then
                Cancel = True
                Args.StringToBeInserted = "<TD></TD>"
            End If
        End If
    End Sub
    'Integrated by ShraddhaM on 13,Nov for Whiziblesem7.1
    'Added by PrajaktaR on 12th Nov 2007 
    'Page Crashes when clicked to sort on Filter Text.
    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColumnName = MyBase.GetResourceString("COL_FILTER") Then
            Args.ApplySorting = False
        End If
    End Sub
    'END : Added by PrajaktaR on 12th Nov 2007 
    'End of integration
#End Region


End Class
