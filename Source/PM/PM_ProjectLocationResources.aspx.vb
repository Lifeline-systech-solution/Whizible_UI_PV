'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise Version
' Module Name      :    Resource Allocation
' Purpose          :    To display the list of resources at the selected projects' location
' Description      :    <Description>
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    May 18, 2004
' Revisions        :    
'******************************************************************

Public Class PM_ProjectLocationResources
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

#Region " Constants Used in the Class "
    Private Enum MenuIndex
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 2
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_lngTagId As Long = 0
    Protected m_lngRequestProjectID As Long = 0
    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""
    Protected m_strPageNumber As String = ""
#End Region

#Region " Page / Class Event Handlers "
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        m_lngTagId = m_objGlobal.TagID
        m_lngRequestProjectID = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("ProjectID"), "0"), Long)

        m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        If m_strSortBy = "" Then m_strSortBy = "EmployeeName"
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"

        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request.QueryString("PageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If

    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_ProjectLocationResources", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strRightCaption As String = ""
        Dim strPageAlphabets As String = ""
        Dim strQuery As String = ""

        'Build the Query for the Paging
        strQuery = "Exec usp_Sel_ProjectLocationResources " & m_lngRequestProjectID.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"
        strQuery &= ", 1"

        'By Default Paging Alphbet is the First Character
        If Not Page.IsPostBack Then
            m_strPageNumber = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
            If m_strPageNumber = "" Then m_strPageNumber = "-1"
        End If

        strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, strQuery, MyBase.GetResourceString("SELECT") & " ", , "Alphabet", True)
        If strPageAlphabets = "" Then m_strPageNumber = "-1"

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False, strPageAlphabets)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Page Caption
        strRightCaption = MyBase.GetResourceString("PROJECT_LOCATION") & " : "
        strRightCaption &= GetProjectLocation()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), strRightCaption, , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the List of liable resources
        DisplayResourceList()

        'Display the Menu at Bottom
        m_objMenu = Nothing
        m_objMenu = New WebPages.Template.StaticMenu
        m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, False)

        'Hidden Controls
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
    End Sub
#End Region

#Region " Common Procedures / Functions "
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ProjectLocationResources : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        '====================================================================
        ' Procedure Name        : InitPageMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Builds the arrays required to display the Menu.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : May 18, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngTagId.ToString() & ")"

        MyBase.InitializeResources("AppResources.PM_ProjectLocationResources", "AppResources")
    End Sub
#End Region

    Private Sub DisplayResourceList()
        '====================================================================
        ' Procedure Name       : DisplayResourceList
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Shows the List of Resources working at same location that of Project Location 
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 18, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim strWhereClause As String = ""
        Dim intColumnsToShow As Integer = 5
        Dim arrActualColumns() As String = {"EmployeeName", "UserName", "RoleDescription", "Department", "EmailID"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("EMPLOYEE_NAME"), MyBase.GetResourceString("USER_NAME"), _
                                                 MyBase.GetResourceString("ROLE"), MyBase.GetResourceString("DEPARTMENT"), _
                                                 MyBase.GetResourceString("EMAIL_ID")}
        Dim arrstrTDStyle() As String = {"align='left' width=20%", "align='left' width=20%", "align='left' width=20%", _
                                         "align='left' width=20%", "align='left' width=20%"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Build the Query for the grid
        strQuery = "Exec usp_Sel_ProjectLocationResources " & m_lngRequestProjectID.ToString()
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'"

        'Set the Advanced Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .PrimaryKey = "EmployeeID"
            .EmptyValueReplacement = "&nbsp;"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "PageDiv"
            .DIVHeight = 220
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .ClientSideSortFunctionName = "Sort_OnClick"
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Function GetProjectLocation() As String
        '====================================================================
        ' Procedure Name       : GetProjectLocation
        ' Parameters Passed    : None
        ' Returns              : The Location of the Project.
        ' Parameters Affected  : None
        ' Purpose              : This function fetch the Location of the Project from the DB for the Selected 
        '                        Project. And return it.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : May 18, 2004
        ' Revisions            : 
        '=====================================================================

        Dim strQuery As String = ""
        Dim strReturn As String = ""

        strQuery = "Exec usp_Sel_GetProjectLocation " & m_lngRequestProjectID.ToString()
        strReturn = CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL).ToString()
        strReturn = CommonFunctions.General.UnBuildQueryString(strReturn)

        Return (strReturn)
    End Function
End Class
