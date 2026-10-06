Public Class RDB_DrillDownSettings
    Inherits WebPages.Template.WhizTemplate

    Protected m_strType As String = ""  ' | BR - Business Radar, PR - Project Radar
    Protected m_lngParameterID As Long = 0
    Private m_lngEmployeeID As Long = 0
    Private m_strUserName As String = ""
    Private m_strLoginType As String = ""
    Private m_blnUseSQL As Boolean
    Private m_strAction As String = ""
    Protected arrIgnoreHTMLEncode() As String = {"0"}
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
        ' MyBase.ApplySecurity(False, 2)
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
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        ' TODO : replace with session values
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
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("ParameterID")) <> "" Then
            m_lngParameterID = CType(Request.QueryString("ParameterID"), Long)
        End If

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
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        If UCase(Trim(m_strAction & "")) = "SAVE" Then
            ' get the submitted values
            strSQL = "usp_upd_tbl_RDB_DrillDown_UserSettings_ShowDrillDown " & m_lngParameterID
            strSQL += "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
            strSQL += ",'" & MyBase.GetFormValue("chkSelect") & "'"

            ' update
            CommonFunctions.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
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
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_BACK"), MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrCSFunction() As String = {"Back_OnClick()", "Save_OnClick()", "Close_OnClick()", "Help_OnClick('RDB_PARAMETER_DRILLDOWNS')"}
        Dim strMenu As String
        Dim strSQL As String

        MyBase.InitializeResources("AppResources.RDB_DrillDownSettings", "AppResources")

        ' grid related variables
        Dim objGrid As WebPages.Template.GenericGrid
        Dim arrColumn() As String = {"DrillDownType", "ShowDrillDown"}
        Dim arrUFColumn() As String = {MyBase.GetResourceString("LBL_DRILLDOWN"), MyBase.GetResourceString("LBL_SELECT")}
        Dim arrLink() As String = {"DrillDownParameter_OnClick('SystemDrillDownType')"}
        Dim arrChkBox() As String = {"", "chkSelect"}
        Dim arrChkBoxCheckedOn() As String = {"", "ShowDrillDown"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)


        strSQL = "usp_sel_tbl_RDB_DrillDown_UserSettings " & m_lngParameterID & "," & m_lngEmployeeID & ",'" & m_strLoginType & "'"
        With Response
            .Write(strMenu)
            .Write("<BR>")
            ' title
            .Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAP_DRILLDOWN_SETTINGS") & GetParameterName(m_lngParameterID), , , False))
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
                .SQL = strSQL
                .returnHTML = False
                .UseSQL = m_blnUseSQL
                .PrimaryKey = "UniqueID"
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
        ' Created               : May 10,2004
        ' Revisions             :
        '=====================================================================
        CommonFunctions.Data.DisposeDataReader(dr)
    End Sub

    Private Function GetParameterName(ByVal ParameterID As Long) As String
        '=====================================================================
        ' Procedure Name        : GetParameterName()	
        ' Purpose               : To get the parameter name
        ' Description           : same as above
        ' Parameters Passed     : Parameter ID
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : commonfunctions.data
        ' Author                : Rajanikant Khethawatt
        ' Created               : Apr 23,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim strSQL As String
        GetParameterName = ""
        strSQL = "usp_sel_tbl_RDB_Parameter_UserSettings " & m_lngEmployeeID & ",'" & m_strLoginType & "'," & ParameterID & ",'" & CommonFunctions.General.BuildQueryString(m_strType) & "'"
        dr = CommonFunctions.Data.GetDataReader(strSQL, m_blnUseSQL)
        If dr.Read Then
            GetParameterName = dr("ParameterName").ToString
        End If
        DisposeDataDeader(dr)
    End Function
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class





