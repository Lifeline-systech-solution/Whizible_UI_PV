Public Class AuditTrail
    Inherits WebPages.Template.WhizTemplate

    Private m_strTagID As String
    Private m_strIsSubTagID As String
    Private m_strUniqueID As String
    Private m_strProjectID As String

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
    Public Sub PageInit()

        'Retrieve the page parameters
        m_strTagID = Request.QueryString("TagID")
        m_strIsSubTagID = Request.QueryString("IsSubTag")
        m_strUniqueID = Request.QueryString("UniqueID")
        If (Request.QueryString("ProjectID") = "" Or Request.QueryString("ProjectID") = "0") Then
            m_strProjectID = "NULL"
        Else
            m_strProjectID = Request.QueryString("ProjectID")
        End If

        'Store the parameters in hidden controls
        CommonFunction.HTMLControls.DrawTextBox("paramTagID", "paramTagID", , , , Request.QueryString("TagID"), , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("paramIsSubTag", "paramIsSubTag", , , , Request.QueryString("IsSubTag"), , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("paramProjectID", "paramProjectID", , , , Request.QueryString("ProjectID"), , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("paramUniqueID", "paramUniqueID", , , , Request.QueryString("UniqueID"), , , , , , True)

        'Draw Menu
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick(" + "'AUDIT_TRAIL'" + ")"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrToolTip)
        CommonFunction.General.WriteHTML(strMenu)

        'Initialize page specific resources
        'MyBase.InitializeResources("Resources.PB_Controls", "Resources")

        CommonFunction.General.WriteHTML("<BR>")

        'Draw Page Caption
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        objGlobal = MyBase.GlobalObject
        If (m_strIsSubTagID = "1") Then
            objGlobal.ParentTagID = 1
            objGlobal.TagID = CType(m_strTagID, Long)
        Else
            objGlobal.TagID = CType(m_strTagID, Long)
        End If
        CommonFunction.General.WriteHTML(WebPage.Templates.PageCaption.GetPageCaptions(objGlobal, , "AUDIT_TRAIL_PAGE_CAPTION", , True) + "<BR>")
        objGlobal = Nothing

        'Render UI
        If Not m_strTagID = "" Then
            PlotUI()
        End If

        'Draw Menu
        CommonFunction.General.WriteHTML("<BR>" + strMenu)
    End Sub

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'Initializing the resources
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")

    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception()
        ex.Source = "Invalid Input: " + UserInput + "Cause: " + Cause
        Throw ex
    End Sub

    Private Sub PlotUI()
        ''=====================================================================
        '' Function  Name		:	PlotUI
        '' Parameters Passed	:	None
        '' Returns				:	None
        '' Parameters Affected	:	None
        '' Purpose				:	To plot the UI for the page
        '' Description			:	
        '' Assumptions			:	None
        '' Dependencies			:	None
        '' Author				:	AbhijeetD
        '' Created				:	8 Jan 2004
        '' Revisions			:	
        ''=====================================================================


        'Render the grid
        Dim objGrid As New WebPages.Template.GenericGrid
        Dim arrUFN() As String = {"Modified Field", "Modified Date", "Value", "Modified By"}
        Dim arrAN() As String = {"FieldName", "Date", "Value", "ModifiedBy"}
        Dim arrCheckBox() As String = {"", "", "", ""}
        Dim arrTDStyle() As String = {"", "", "", ""}
        Dim strGRID As String
        Dim strSortBy, strSortOrder As String

        If Not Request.QueryString("sortby") Is Nothing Then
            strSortBy = Request.QueryString("sortby")
        Else
            strSortBy = "Date"
        End If

        If Not Request.QueryString("sortorder") Is Nothing Then
            strSortOrder = Request.QueryString("sortorder")
        Else
            strSortOrder = "DESC"
        End If

        objGrid.UserFriendlyColumnArray = arrUFN
        objGrid.ActualColumnArray = arrAN
        objGrid.NoOfDataColumns = 4
        objGrid.ClientSideSortFunctionName = "Sort_OnClick" ' without param. and brackets
        objGrid.TDStyleArray = arrTDStyle
        objGrid.CheckBoxIDArray = arrCheckBox
        objGrid.DIVStyle = "overflow:scroll"
        objGrid.DIVHeight = 300
        objGrid.DIVID = "DivList"
        objGrid.PrimaryKey = "LogID" ' Primary key for check boxes

        If (m_strIsSubTagID = "1") Then
            objGrid.SQL = "usp_Sel_tbl_PM_SubTagAuditTrail " + m_strTagID + ", " + m_strUniqueID + ", " + m_strProjectID + ", '" + strSortBy + "', '" + strSortOrder + "'" ' Any SQL
        Else
            objGrid.SQL = "usp_Sel_tbl_PM_AuditTrail " + m_strTagID + ", " + m_strUniqueID + ", " + m_strProjectID + ", '" + strSortBy + "', '" + strSortOrder + "'"   ' Any SQL
        End If
        objGrid.SortOrder = strSortOrder
        objGrid.SortBy = strSortBy
        objGrid.returnHTML = False '| true
        objGrid.BooleanFalseHTML = "No" '|false | <img src='../../images/cross.gif'>
        objGrid.BooleanTrueHTML = "Yes" '|true | <img src='../../images/check.gif'>
        objGrid.UseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        objGrid.ColNameToolTipOnEachRow = True
        objGrid.DrawGrid() ' Called from within the section below
        objGrid = Nothing

    End Sub

End Class
