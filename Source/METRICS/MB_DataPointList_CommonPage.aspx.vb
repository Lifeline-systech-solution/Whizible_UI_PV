Imports CommonFunctions
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports CommonFunctions.HTMLControls
Imports System.Text
'Imports Whizible

Imports CommonEngines.General.cEventHandlers

Public Class MB_DataPointList_CommonPage
    Inherits CommonPage

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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "../General/CommonList.aspx"
        MyBase.strFormPage = "MB_DataPointList_CommonPage.aspx"
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

    'Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
    '    'If you want to execute any client side script before the HTML of page is rendered,
    '    'then this is the right place to do it
    '    'The script returned will be placed after html <form> tag and will be included in <script> tag.
    '    'There is no need to return the JS script with Script tags.
    'End Function

    'Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
    '    'If you want to execute any client side script after all the HTML of page is rendered,
    '    'then this is the right place to do it
    '    'The script returned will be placed before html </form> tag and will be included in <script> tag..
    '    'There is no need to return the JS script with Script tags.
    'End Function

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

#Region "Navigation and Paging Links"

    'Protected Overrides Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub
    'Protected Overrides Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

    'Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub
    'Protected Overrides Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub
    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)
    'End Sub

#End Region

#Region "Save, Delete and Other Dynamic Actions"

    'Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
    'End Sub
    'Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
    'End Sub

    'Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
    'End Function
    'Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
    'End Function

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    'End Function
    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    'End Function

#End Region

#Region "Sections"

    'Protected Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

    'Protected Overrides Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub

#End Region

#Region "Graph and Related Data"

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

#End Region


#Region "Lgend, Page Caption and HeaderFooter"

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
    'End Sub
#End Region

#Region "Filter"

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)
    'End Sub
    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)
    'End Sub

#End Region

#Region "CPSQL"

    'Protected Overrides Function InitCPSQL() As Whiz.CommonEngine.CommonPage.cCPSQL
    '    Return New MyCPSQL(MyBase.m_objGlobal)
    'End Function

    'Private Class MyCPSQL

    '    Inherits Whiz.CommonEngine.CommonPage.cCPSQL
    '    'Constructor
    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String 'CLSQL, CPSQL, SubTagCPSQL
    '    End Function

    '    Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
    '    End Function

    'End Class

#End Region

#Region "SubTagCPSQL"

    'Protected Overrides Function InitSubTagCPSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As Whiz.CommonEngine.CommonPage.cSubTagCPSQL
    '    Return New MySubTagCPSQL(m_objSubTagGlobal)
    'End Function

    'Private Class MySubTagCPSQL
    '    Inherits Whiz.CommonEngine.CommonPage.cSubTagCPSQL

    '    Public Sub New(ByVal WhizSubTagGlobal As WebPages.Template.IGlobal)
    '        MyBase.New(WhizSubTagGlobal)
    '    End Sub

    '    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '    End Function

    '    Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
    '    End Function

    'End Class

#End Region

#Region "SubTag CLSQL"

    'Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As Whiz.CommonEngine.CommonList.cSubTagCLSQL
    '    Return New MySubTagCLSQL(WhizGlobal)
    'End Function

    'Public Class MySubTagCLSQL
    '    Inherits Whiz.CommonEngine.CommonList.cSubTagCLSQL
    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        'Assign the Parameter values to the local variables
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Protected Overrides Sub Initialize_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_Attachment.WAF_AttachmentDeleteInitialize, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub
    '    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    End Sub

    '    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    '    End Sub
    'End Class

#End Region

#Region "SubTag PlotGrid"

    '    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As Whiz.CommonEngine.CommonList.cPlotGrid
    '        Return New MyPlotGrid(m_objSubTagGlobal)
    '    End Function

    '    Private Class MyPlotGrid
    '        Inherits Whiz.CommonEngine.CommonList.cPlotGrid

    '        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '            'Assign the Parameter values to the local variables
    '            Call MyBase.New(WhizGlobal)
    '        End Sub

    '        Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub

    '        Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub
    '        Protected Overrides Sub After_GridColumnHeaderTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub

    '        Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub
    '        Protected Overrides Sub After_GridColumnHeaderTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub

    '        Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub
    '        Protected Overrides Sub After_GridDataRowTR_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub

    '        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub
    '        Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub

    '        Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        End Sub

    '        Protected Overrides Function IsSpecialCaseEditMode_UIPage(ByVal objGlobal As WebPages.Template.IGlobal) As Boolean
    '        End Function

    '        Protected Overrides Function FormatUIPageHrefTag(ByVal objGlobal As WebPages.Template.IGlobal) As String
    '        End Function

    '        Protected Overrides Sub InitializeListPage_SubTag(ByRef Cancel As Boolean, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
    '        End Sub

    '        Protected Overrides Sub BeforePrintListPage_SubTag(ByRef Cancel As Boolean, ByRef Args As EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal PrimaryKey As String)
    '        End Sub

    '#Region "For MultiInsert Subtag"

    '        'Protected Overrides Sub Initialize_Controls(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_InitializeControls, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ControlCollection As CommonEngines.HashTables.UIControlTagMaster())
    '        'End Sub

    '        'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
    '        'End Sub
    '        'Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing)
    '        'End Sub

    '        'Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
    '        'End Sub
    '        'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
    '        'End Sub

    '        'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String
    '        '    Return MyBase.GetCheckDuplicateSQL(strSQL, objGlobal)
    '        'End Function

    '#End Region

    '    End Class

#End Region

#Region "Sub Tag - Tab and Multi Insert"

    'Protected Overrides Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

    'Protected Overrides Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub
    'Protected Overrides Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    'End Sub

#End Region

#Region "SubTag Dynamic Filters"

    'Protected Overrides Function InitSubTag_DynamicFileters(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As Whiz.CommonEngine.CommonList.cSubTagDynamicFilters
    '    Return New MySubTagDynamicFilters(m_objSubTagGlobal)
    'End Function

    'Private Class MySubTagDynamicFilters
    '    Inherits Whiz.CommonEngines.CommonList.cSubTagDynamicFilters

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

#Region "Plot Control"

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New MyPlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New MyPlotControls(MyBase.m_objGlobal)
    End Function

    Private Class MyPlotControls
        Inherits CommonEngine.CommonPage.cPlotControls

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            ''Assign the Parameter values to the local variables
            Call MyBase.New(WhizGlobal)
        End Sub

        'Protected Overrides Sub Initialize_Controls(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_InitializeControls, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef ControlCollection As CommonEngines.HashTables.UIControlTagMaster())
        'End Sub

        '    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)
        '    End Sub
        '    Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)
        '    End Sub

        Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
            If Args.IsEditMode = True AndAlso Args.ControlCaption = "Function Name" Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drControls.Item("CalculationUsing"), "FN"), String) = "SP" Then
                    Args.IgnoreActualValue = True
                    Args.ControlCaption = "Procedure Name"
                End If
            End If

        End Sub
        '    Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")
        '    End Sub

        Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
            'Case CommonFunction.Constants.APP_TAG_DATAPOINTLIST
            If Args.IsEditMode = True AndAlso Args.ControlName = "FunctionName" Then
                If CType(CommonFunctions.Data.CheckIsDBNull(drControls.Item("CalculationUsing"), "FN"), String) = "SP" Then
                    Args.IgnoreActualValue = True
                    'Args.NewValue = HttpContext.Current.Server.HtmlEncode(CommonFunction.Data.CheckIsDBNull(drControls.Item("FormulaSP")))
                    Args.NewValue = CommonFunction.Data.CheckIsDBNull(drControls.Item("FormulaSP"))
                Else
                    Args.IgnoreActualValue = True
                    'Args.NewValue = HttpContext.Current.Server.HtmlEncode(CommonFunction.Data.CheckIsDBNull(drControls.Item("FunctionName")))
                    Args.NewValue = CommonFunction.Data.CheckIsDBNull(drControls.Item("FunctionName"))

                End If
            End If

            ''''Added by Dhanashri S on 14 Oct 2015 Purpose::Whizible NxtGen Issue Fixing
            If Args.ControlName.ToUpper = "MEASUREMENTCATEGORYID" Then
                Dim mode As String = ""
                mode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")
                If mode.ToUpper = "ADD_NEW" Then
                    'Commented and added by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query
                    ' Args.AdditionalInformation = "Select MeasurementCategoryID,MeasurementCategory   From  tbl_PRS_MeasurementCategory  Where MeasurementCategoryID NOT IN   (Select MeasurementCategoryID from tbl_PRS_Measurements Where MeasurementID='')   Order by MeasurementCategory ASC"
                    Args.AdditionalInformation = "usp_sel_tbl_PRS_MeasurementCategory"


                Else
                    ' Args.AdditionalInformation = "Select MeasurementCategoryID,MeasurementCategory   From  tbl_PRS_MeasurementCategory  Where MeasurementCategoryID NOT IN   (Select MeasurementCategoryID from tbl_PRS_Measurements Where MeasurementID=<UNIQUE_ID>)   Order by MeasurementCategory ASC"
                    Args.AdditionalInformation = "usp_sel_tbl_PRS_MeasurementCategory_MeasurementCategory <UNIQUE_ID>"

                End If

            End If
            '''End of Addition by Dhanashri S on 14 Oct 2015
            '''  'End of addition by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query
        End Sub
        Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

        End Sub

        'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String
        '    Return strSQL
        'End Function

        '    Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
        '    End Sub
    End Class

#End Region

#Region "Data Management"

    'Protected Overrides Function InitDataManagement() As Whiz.CommonEngine.CommonPage.cDataManagement
    '    Return New MyDataManagement(MyBase.m_objGlobal)
    'End Function

    'Public Class MyDataManagement
    '    Inherits Whiz.CommonEngine.CommonPage.cDataManagement
    '    'Constructor
    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        Call MyBase.New(WhizGlobal)
    '    End Sub

    '    Public Overrides Function GeneratePrimaryKeyValue(ByVal ControlsHashTable As Hashtable, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal strDataType As String, Optional ByVal intMaxLength As Integer = 0, Optional ByVal intPrevMax As Long = 0) As String
    '        MyBase.GeneratePrimaryKeyValue(ControlsHashTable, WhizGlobal, strDataType, intMaxLength, intPrevMax)
    '    End Function

    'End Class

#End Region

#Region "SubTag Datamanagement"

    'Protected Overridable Function InitSubTagDataManagement() As Whiz.CommonEngine.CommonPage.cSubTagDataManagement
    '        Return New MySubTagDataManagement(MyBase.m_objGlobal)
    'End Function

    'Public Class MySubTagDataManagement
    '    Inherits Whiz.CommonEngines.CommonPage.cSubTagDataManagement

    '    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
    '        MyBase.New(WhizGlobal)
    '    End Sub

    '    Public Overrides Sub SaveData(ByVal ControlsHashTable As System.Collections.Hashtable, ByVal IsEditMode As Boolean)
    '        MyBase.SaveData(ControlsHashTable, IsEditMode)
    '    End Sub

    'End Class

#End Region

End Class