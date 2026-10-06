Imports CommonEngines.General.cEventHandlers
Imports Whizible
Public Class cConfigureAttributes_21180_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cConfigureAttributes_21180_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    'Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class
Public Class cConfigureAttributes_21180_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cConfigureAttributes_21180_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim intProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
        Dim IsAgile As String = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_Is_AgileProject " + intProjectID + "", True))

        If IsAgile <> "1" Then
            If Args.ControlName.ToUpper = "ITERATIONORDERNO" Then
                Cancel = True
            End If
            If Args.ControlName.ToUpper = "RELEASEORDERNO" Then
                Cancel = True
            End If
          
        End If
        If IsAgile = "1" Then
            If Args.ControlName.ToUpper = "PHASEORDERNO" Then
                Cancel = True
            End If
        End If
    End Sub

    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal Whizglobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        Dim intProjectID As String = CStr(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0"))
        Dim IsAgile As String = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_Is_AgileProject " + intProjectID + "", True))

        If IsAgile <> "1" Then
            If Args.ControlName.ToUpper = "ITERATIONORDERNO" Then
                Cancel = True
            End If
            If Args.ControlName.ToUpper = "RELEASEORDERNO" Then
                Cancel = True
            End If

        End If
        If IsAgile = "1" Then
            If Args.ControlName.ToUpper = "PHASEORDERNO" Then
                Cancel = True
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub
End Class


Public Class ConfigureAttributes_21180_CommonPage
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
        MyBase.strListPage = "ConfigureAttributes_21180_CommonList.aspx"
        MyBase.strFormPage = "ConfigureAttributes_21180_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function




    'Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub

    'Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub



    'Protected Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Function AfterSave(ByVal Global As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal global As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        'Save the configuration settings:
        Dim SubprojectOrder As Integer = 0
        Dim ModuleOrder As Integer = 0
        'Dim PhaseOrder As Integer = 1
        Dim PhaseOrder As Integer = 0
        Dim IncrementOrder As Integer = 0
        Dim IterationOrder As Integer = 0
        Dim MilestoneOrder As Integer = 0
        Dim DeliverableOrder As Integer = 0
        Dim ReleaseOrder As Integer = 0
        Dim ProjectId As Integer = 0
        Dim ProcessGroupId As Integer = 0
        Dim strSQL As String

        If Not IsNothing(HttpContext.Current.Session("intProjectID")) Then
            ProjectId = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID")), Integer)
            'ProcessGroupId = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProcessGroupID")), Integer)
        End If

        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("SubprojectOrderNo"), ""), String).Trim <> "" Then
            SubprojectOrder = CType(ControlsHashTable("SubprojectOrderNo"), Integer)
        End If


        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("ModuleOrderNo"), ""), String).Trim <> "" Then
            ModuleOrder = CType(ControlsHashTable("ModuleOrderNo"), Integer)
        End If

        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("PhaseOrderNo"), ""), String).Trim <> "" Then
            PhaseOrder = CType(ControlsHashTable("PhaseOrderNo"), Integer)
        End If

        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("IncrementOrderNo"), ""), String).Trim <> "" Then
            IncrementOrder = CType(ControlsHashTable("IncrementOrderNo"), Integer)
        End If

        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("IterationOrderNo"), ""), String).Trim <> "" Then
            IterationOrder = CType(ControlsHashTable("IterationOrderNo"), Integer)
        End If

        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("MilestoneOrderNo"), ""), String).Trim <> "" Then
            MilestoneOrder = CType(ControlsHashTable("MilestoneOrderNo"), Integer)
        End If

        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("DeliverableOrderNo"), ""), String).Trim <> "" Then
            DeliverableOrder = CType(ControlsHashTable("DeliverableOrderNo"), Integer)
        End If

        'ReleaseOrder
        If CType(CommonFunctions.General.CheckIsNothing(ControlsHashTable("ReleaseOrderNo"), ""), String).Trim <> "" Then
            ReleaseOrder = CType(ControlsHashTable("ReleaseOrderNo"), Integer)
        End If

        'Modified By _ NileshVJ_18112005
        'If any of the attribute between S/M/P/I/I is not specified 
        'then add "NULL"(zero should not be added, that value will be NULL)

        strSQL = "usp_Ins_tbl_WPBN_PM_Overallschedule_Settings_New "

        If ProjectId <> 0 Then
            strSQL += ProjectId.ToString()
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If ProcessGroupId <> 0 Then
            strSQL += ProcessGroupId.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If SubprojectOrder <> 0 Then
            strSQL += SubprojectOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If ModuleOrder <> 0 Then
            strSQL += ModuleOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "


        If PhaseOrder <> 0 Then
            strSQL += PhaseOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "


        If IncrementOrder <> 0 Then
            strSQL += IncrementOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If IterationOrder <> 0 Then
            strSQL += IterationOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If MilestoneOrder <> 0 Then
            strSQL += MilestoneOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If DeliverableOrder <> 0 Then
            strSQL += DeliverableOrder.ToString
        Else
            strSQL += " NULL "
        End If
        strSQL += ", "

        If ReleaseOrder <> 0 Then
            strSQL += ReleaseOrder.ToString
        Else
            strSQL += " NULL "
        End If
        'ReleaseOrder
        CommonFunction.Data.InsertOrUpdateData(strSQL, True)

        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
        'END ___________________________________ NileshVJ_10112005

        ' Code added by SwapnilR on 20th July 2007
        ' Purpose : To create carry forwarded request

    End Function

    'Protected Overrides Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cConfigureAttributes_21180_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cConfigureAttributes_21180_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cConfigureAttributes_21180_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function
#Region "CPSQL"

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New MyCPSQL(MyBase.m_objGlobal)
    End Function

    Private Class MyCPSQL
        Inherits CommonEngine.CommonPage.cCPSQL
        'Constructor
        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        '    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String 'CLSQL, CPSQL, SubTagCPSQL
        '    End Function

        Protected Overrides Function GetUIPageWhereClause(ByVal objGlobal As WebPages.Template.IGlobal, ByVal TableName As String, ByVal PrimaryKey As String, Optional ByRef PrimaryKeyValue As String = "") As String
            'Start_Commented_And_Modified_By_RachanaG_on_10-May-2011
            'GetUIPageWhereClause = " WHERE ProjectID = " + HttpContext.Current.Session("intProjectID") + " AND ProcessGroupID = " + HttpContext.Current.Session("intProcessGroupID")
            GetUIPageWhereClause = " WHERE ProjectID = " + CommonFunction.General.CheckIsNothing(CStr(HttpContext.Current.Session("intProjectID")), "0")
            'End_Commented_And_Modified_By_RachanaG_on_10-May-2011
        End Function
    End Class

#End Region

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cConfigureAttributes_21180_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal Whizglobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cConfigureAttributes_21180_CommonPageSubTagCLSQL(Whizglobal)
    End Function
End Class
