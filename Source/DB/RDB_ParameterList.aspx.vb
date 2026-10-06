Public Class RDB_ParameterList
    Inherits WebPages.Template.WhizTemplate

    Protected m_strType As String = ""  ' | BR - Business Radar, PR - Project Radar
    Protected m_intRefreshParent As Integer
    Protected m_lngDepartmentID As Long = 0
    Protected m_lngLocationID As Long = 0
    Private m_lngEmployeeID As Long = 0
    Private m_strUserName As String = ""
    Private m_strLoginType As String = ""
    Private m_blnUseSQL As Boolean
    Private m_strAction As String = ""


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
        MyBase.ApplySecurity(True)
        Call Initialize()
        If Page.IsPostBack Then
            Call PeformActions()
        End If
    End Sub

    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        'MyBase.ApplySecurity(False, 2)
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True, 2)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the variables for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 28,2004
        ' Revisions             :
        '=====================================================================
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString
        m_lngEmployeeID = CType(Session("intUserID"), Long)

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("type")) <> "" Then
            m_strType = Request.QueryString("type").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")) <> "" Then
            m_strAction = Request.QueryString("Action").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("LocationID")) <> "" Then
            m_lngLocationID = CType(Request.QueryString("LocationID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("DepartmentID")) <> "" Then
            m_lngDepartmentID = CType(Request.QueryString("DepartmentID"), Long)
        End If
        m_intRefreshParent = 0
    End Sub

    Private Sub PeformActions()
        '=====================================================================
        ' Procedure Name        : PeformActions()	
        ' Purpose               : To perform the actions on the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Commonfunctions namespace
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 29,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strSelectedParameters As String

        If UCase(Trim(m_strAction & "")) = "SAVE" Then
            ' the comma-separated list of selected items
            strSelectedParameters = MyBase.GetFormValue("chkSelect", False)
            ' update the settings
            strSQL = "usp_upd_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "','" & strSelectedParameters & "'"
            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
            m_intRefreshParent = 1
        End If

    End Sub


    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for the Radar DB
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 28,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT_ALL"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SELECT_ALL_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"SelectAll_OnClick('frm','chkSelect')", "Save_OnClick()", "Close_OnClick()", "Help_OnClick('RDB_PARAMETER_LIST')"}
        Dim strMenu As String

        MyBase.InitializeResources("AppResources.RDB_ParameterList", "AppResources")

        ' grid related variables
        Dim objGrid As WebPages.Template.GenericGrid
        Dim arrColumn() As String = {"ParameterName", "IsVisible"}
        Dim arrUFColumn() As String = {MyBase.GetResourceString("LBL_PARAMETER"), MyBase.GetResourceString("LBL_SELECT")}
        Dim arrLink() As String = {"Parameter_OnClick(ParameterID)"}
        Dim arrChkBox() As String = {"", "chkSelect"}
        Dim arrChkBoxCheckedOn() As String = {"", "IsVisible"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)

        With Response
            ' menu
            .Write(strMenu)

            .Write("<BR>")


            ' title
            .Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_PARAMETER_LIST"), , , False))

            .Write("<BR>")

            ' grid 
            objGrid = New WebPages.Template.GenericGrid
            With objGrid
                .ActualColumnArray = arrColumn
                .UserFriendlyColumnArray = arrUFColumn
                .CheckBoxIDArray = arrChkBox
                .CheckboxCheckOnColumnArray = arrChkBoxCheckedOn
                .RowLinkArray = arrLink
                .NoOfDataColumns = 1
                .DIVID = "divList"
                .DIVStyle = "overflow:auto"
                .DIVHeight = 300
                .SQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "',null,'" & CommonFunctions.General.BuildQueryString(m_strType) & "'"
                .returnHTML = False
                .UseSQL = m_blnUseSQL
                .PrimaryKey = "ParameterID"
                'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .DrawGrid()
            End With
            objGrid = Nothing

            .Write(strMenu)
        End With
    End Sub

#Region "Other Procedures"
    Private Sub DisposeDataDeader(ByRef dr As IDataReader)
        '=====================================================================
        ' Procedure Name        : DisposeDataDeader()	
        ' Purpose               : To dispose the data reader object
        ' Description           : same as above
        ' Parameters Passed     : by ref data-reader object
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : None
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 28,2004
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class




