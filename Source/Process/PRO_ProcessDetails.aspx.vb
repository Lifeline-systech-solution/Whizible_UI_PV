Public Class PRO_ProcessDetails
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
    Private m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Private m_lngProcessId As Long = 0
#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        InitPageMenu()
        m_lngProcessId = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("ProcessId"), "0"), Long)
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PRO_ProcessDetails : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(656)"

        MyBase.InitializeResources("AppResources.PRO_ProcessDetails", "AppResources")
    End Sub

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strListCaption As String = ""
        Dim strQuery As String = ""
        Dim strProcessName As String = ""
        Dim drRevision As IDataReader

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PROCESS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Display The List Header
        strQuery = "Exec usp_Sel_Prs_ShowProcessRevision " & m_lngProcessId.ToString()
        drRevision = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If (CommonFunctions.General.CheckIsNothing(drRevision)) <> "" Then
            If drRevision.Read() Then
                strProcessName = drRevision.Item("ProcessName").ToString()
                strProcessName = CommonFunctions.General.UnBuildQueryString(strProcessName)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drRevision)
        strListCaption = MyBase.GetResourceString("PROCESS_NAME")
        strListCaption &= " : " & Server.HtmlEncode(strProcessName)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, strListCaption, , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the List of Process Revision
        Display_ProcessRevision_List()

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
    End Sub

    Private Sub Display_ProcessRevision_List()
        Dim strQuery As String = ""

        'Grid Related Variables
        Dim arrUserFriendlyFieldNames() As String = {MyBase.GetResourceString("REVISION_NO"), _
                                                     MyBase.GetResourceString("REVISION_DATE"), _
                                                     MyBase.GetResourceString("REVISION_BY"), _
                                                     MyBase.GetResourceString("APPROVED_BY"), _
                                                     MyBase.GetResourceString("REASON")}
        Dim arrActualFieldNames() As String = {"RevisionNo", "RevisionDate", "RevisedBy", "ApprovedBy", "Reason"}
        Dim arrTDStyle() As String = {"width='10%' valign= top align=left", "width='10%' nowrap valign= top align=left", _
                                      "width='10%' valign= top align=left", "width='10%' valign= top align=left", _
                                      "width='10%' valign= top align=left"}
        'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
        Dim arrIgnoreHtml() As String = {"0"}
        'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

        'Build the Query for Grid
        strQuery = "Exec usp_Sel_Prs_ShowProcessRevision " & m_lngProcessId.ToString()
        With m_objGrid
            .ActualColumnArray = arrActualFieldNames
            .UserFriendlyColumnArray = arrUserFriendlyFieldNames
            .TDStyleArray = arrTDStyle
            .NoOfDataColumns = 5
            .DIVID = "PageDiv"
            .DIVStyle = "overflow:auto;width:100%"
            .DIVHeight = 300
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .returnHTML = False
            'Added by Nilesh Gundhecha on 6/10/2015 for HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHtml
            'Ended by Nilesh Gundhecha on 6/10/2015 for HTML Encoding

            .DrawGrid()
        End With
    End Sub

End Class
