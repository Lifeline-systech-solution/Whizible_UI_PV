Imports CommonFunctions
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports CommonFunctions.HTMLControls
Imports System.Text
Imports CommonEngines.General.cEventHandlers
'Imports Whizible


Public Class MB_PublishMeasurement_CommonList
    'Inherits Whiz.CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "
    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "MB_PublishMeasurement_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

#Region "WhizForm_Init, GetPageSpecificGlobalObject and GetPageSpecificAccessRights"

    'Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
    '    'This method can be used for changing the database connection
    '    'If for better performance the Whiz Framework Metadata and Actual Application Data are stord on
    '    'different databases, then by changing the connection id i.e. m_intConnectionID variable value,
    '    'The appplication data can be shown on commonpage.
    '    'All the operations will be performed on this dataase.
    '    'Note: the connection id should be present in tbl_QRB_Connection_Master table with valid connection string

    'End Sub

    'Protected Overrides Sub GetPageSpecificGlobalObject(ByRef objGlobal As WebPages.Template.IGlobal)
    '    'This method can be used to set the global object used in Whiz Framework to know which page's
    '    'metadata should be loaded.
    '    'You can change the TagID and/or ParentTagID depending upon certain condition to load different pages.
    '    'You need to use the variables objGlobal.TagID and/or objGlobal.ParentTagID for that
    'End Sub

    'Protected Overrides Sub GetPageSpecificAccessRights(ByVal objGlobal As WebPages.Template.IGlobal, ByRef objAccess As Whiz.WebPage.Templates.AccessRights)
    '    'This method can be used to set the different/conditional access rights apart from the access rights set from Role Access Page.
    '    'You can use following boolean variables for that
    '    '   objGlobal.Add
    '    '   objGlobal.Edit
    '    '   objGlobal.Delete
    '    '   objGlobal.View
    'End Sub

#End Region

#Region "Page Render"

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    'If you want to execute any client side script before the HTML of sub tag list is rendered,
    '    'then this is the right place to do it
    '    'The script returned will be included in <script> tag.
    '    'There is no need to return the JS script with Script tags.
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    'If you want to execute any client side script after the HTML of sub tag list is rendered,
    '    'then this is the right place to do it
    '    'The script returned will be included in <script> tag.
    '    'There is no need to return the JS script with Script tags.
    'End Function


#End Region

#Region "CLSQL"

    'Protected Overrides Function InitCLSQL() As Whiz.CommonEngine.CommonList.cCLSQL
    '    Return New cMyCLSQL(MyBase.m_objGlobal)
    'End Function

    'Private Class cMyCLSQL
    '    Inherits Whiz.CommonEngine.CommonList.cCLSQL

    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        'Assign the Parameter values to the local variables
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    End Function

    '    Protected Overrides Function GetUIPageURL(ByVal FunctionName As String, ByVal objGlobal As WebPages.Template.IGlobal, ByVal blnEditMode_UIPageOpenInWindow As Boolean, ByVal strUIPage As String) As String
    '    End Function

    '    Protected Overridable Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    'End Class

#End Region

#Region "PlotGrid"

    'Protected Overrides Function InitPlotGrid() As Whiz.CommonEngine.CommonList.cPlotGrid
    '    Return New cMyPlotGrid(MyBase.m_objGlobal)
    'End Function

    'Private Class cMyPlotGrid
    '    Inherits Whiz.CommonEngine.CommonList.cPlotGrid

    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        'Assign the Parameter values to the local variables
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_GridColumnHeaderTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Function IsSpecialCaseEditMode_UIPage(ByVal objGlobal As WebPages.Template.IGlobal) As Boolean
    '    End Function

    '    Protected Overrides Function FormatUIPageHrefTag(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    End Function

    '    Protected Overrides Sub InitializeListPage_SubTag(ByRef Cancel As Boolean, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
    '    End Sub

    '    Protected Overrides Sub BeforePrintListPage_SubTag(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
    '    End Sub

    '    '#Region "For MultiInsert Subtag"

    '    '        'Protected Overrides Sub Initialize_Controls(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_InitializeControls, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ControlCollection As CommonEngines.HashTables.UIControlTagMaster())
    '    '        'End Sub

    '    '        'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
    '    '        'End Sub
    '    '        'Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
    '    '        'End Sub

    '    '        'Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
    '    '        'End Sub
    '    '        'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
    '    '        'End Sub

    '    ''Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    ''    Return MyBase.GetCheckDuplicateSQL(strSQL, objGlobal)
    '    ''End Function

    '    '#End Region

    'End Class

#End Region

#Region "Dynamic Filters"

    'Protected Overrides Function InitDynamicFilters() As Whiz.CommonEngine.CommonList.cDynamicFilters
    '    Return New cMyDynamicFilters(MyBase.m_objGlobal)
    'End Function

    'Private Class cMyDynamicFilters
    '    Inherits Whiz.CommonEngine.CommonList.cDynamicFilters

    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        'Assign the Parameter values to the local variables
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Protected Overrides Sub Initialize_Filters(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFiltersTable, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_Filter_Print(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    'End Class

#End Region

#Region "Datamanagement"

    'Protected Overrides Function InitDataManagement() As Whiz.CommonEngine.CommonPage.cDataManagement
    '    Return New cMyDataManagement(MyBase.m_objGlobal)
    'End Function

    'Private Class cMyDataManagement
    '    Inherits Whiz.CommonEngine.CommonPage.cDataManagement

    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        'Assign the Parameter values to the local variables
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Public Overrides Function GeneratePrimaryKeyValue(ByVal ControlsHashTable As Hashtable, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal strDataType As String, Optional ByVal intMaxLength As Integer = 0, Optional ByVal intPrevMax As Long = 0) As String
    '        MyBase.GeneratePrimaryKeyValue(ControlsHashTable, WhizGlobal, strDataType, intMaxLength, intPrevMax)
    '    End Function

    'End Class

#End Region

#Region "Delete"

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    'End Function
    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    'End Function

#End Region

#Region "Menu and Links"

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'You can change the look and feel of menu being plotted, by using this method.
    '    'You can use various proprties of Args for that.
    '    'E.g. By using Args.Action_NavigationSchema you can plot either Dropdown menu or classical menu.

    '    'You can change the access rights for the menu by setting properties Add, Edit, Delete and View of Args.
    '    'This will help in cancelling the links that needs specific access.
    '    'E.g. If Args.Add and Args.Edit is set to false then Save link will not be displayed

    '    'You can also cancel the plotting of menu by setting Cancel=True
    'End Sub

    'Protected Overrides Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'You can change the type, display position of the menu.
    '    'You can insert any html before the menu html table is plotted using - Args.ToBeInserted
    '    'You can also cancel the plotting of menu by setting Cancel=True
    'End Sub
    'Protected Overrides Sub After_Menu_Print(ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'You can insert any html after the menu html table is plotted using - Args.ToBeInserted
    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'You can change the look and feel of menu-link being plotted, by using this method.
    '    'You can use various proprties of Args for that.

    '    'You can also cancel the plotting of a perticular menu-link by setting Cancel=True
    '    '
    'End Sub
    'Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

#End Region

#Region "Filters"

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)
    'End Sub
    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)
    'End Sub


#End Region

#Region "Paging Links"

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub
    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
    'End Sub

#End Region

#Region "Legend, Page Caption and HeaderFooter"

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)
    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)
    'End Sub

#End Region

#Region "Section"

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

#End Region

#Region "Graph and Related Data"

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

#End Region

End Class
