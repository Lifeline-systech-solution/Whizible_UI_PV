
Imports Whizible
Imports CommonEngines.General.cEventHandlers
Public Class cAttributeMappingForm_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal Whizglobal As WebPages.Template.IGlobal)
        Call MyBase.New(Whizglobal)
    End Sub
End Class
Public Class cAttributeMappingForm_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal Whizglobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(Whizglobal)
    End Sub
End Class
Public Class cAttributeMappingForm_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal Whizglobal As WebPages.Template.IGlobal)
        Call MyBase.New(Whizglobal)
    End Sub
End Class
Public Class cAttributeMappingForm_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal Whizglobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(Whizglobal)
    End Sub

End Class


Public Class AttributeMappingForm_CommonPage
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
        MyBase.strListPage = "AttributeMappingForm_CommonList.aspx"
        MyBase.strFormPage = "AttributeMappingForm_CommonPage.aspx"


        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Sub GetPageSpecificAccessRights(ByVal objGlobal As WebPages.Template.IGlobal, ByRef objAccess As PbNIT.WebPage.Templates.AccessRights)
    '    MyBase.GetPageSpecificAccessRights(objGlobal, objAccess)
    '    'Dim strSQL As String
    '    'Dim drAccess As IDataReader
    '    'strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & 8056 & "," & CType(HttpContext.Current.Session("intPostID"), Integer) & "," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & CType(HttpContext.Current.Session("LoginType"), String) & "'"
    '    'drAccess = CommonFunctions.Data.GetDataReader(strSQL, True)
    '    ''   If CType(drAccess.Item("A"), Boolean) = True And CType(drAccess.Item("D"), Boolean) = True And CType(drAccess.Item("E"), Boolean) = True Then
    '    ''If drAccess.Read() Then
    '    ''    objAccess.Add = drAccess.Item("A")
    '    ''    objAccess.Edit = drAccess.Item("E")
    '    ''    objAccess.Delete = drAccess.Item("D")
    '    ''    objAccess.View = drAccess.Item("V")
    '    ''End If

    '    'objAccess.Add = False
    '    'objAccess.Edit = False
    '    'objAccess.Delete = False
    '    'objAccess.View = False
    '    'drAccess.Close()
    '    'drAccess.Dispose()

    'End Sub
    'Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    'End Function

    'Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    'End Function




    'Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub

    'Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub



    'Protected Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    Public Overrides Function AfterSave(ByVal Whizglobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        If PrimaryKey <> "" Then
            'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MasterTagID"), "") = 20053 Then
            CommonFunction.General.WriteHTML("<Script>")
            CommonFunction.General.WriteHTML("window.opener.location.href='../IB/FCI_IntegrationSetup.aspx?Action=Attribute&FromCL=1';")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")
            'End If
        End If
    End Function

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal Whizglobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal Whizglobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "SAVE" Then
            Dim strSQL As String
            Dim drAccess As IDataReader
            strSQL = "Exec usp_Sel_tbl_UI_NodeAccess " & 8056 & "," & CType(HttpContext.Current.Session("intPostID"), Integer) & "," & CType(HttpContext.Current.Session("intUserID"), Integer) & ",'" & CType(HttpContext.Current.Session("LoginType"), String) & "'"
            drAccess = CommonFunctions.Data.GetDataReader(strSQL, True)
            If drAccess.Read() Then
                If CType(drAccess.Item("A"), Boolean) = False And CType(drAccess.Item("E"), Boolean) = False Then
                    Cancel = True
                End If
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal Whizglobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Function BeforeSave(ByVal Whizglobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function

    'Protected Overrides Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal Whizglobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal Whizglobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cAttributeMappingForm_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cAttributeMappingForm_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cAttributeMappingForm_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cAttributeMappingForm_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal Whizglobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cAttributeMappingForm_CommonPageSubTagCLSQL(Whizglobal)
    End Function
End Class
