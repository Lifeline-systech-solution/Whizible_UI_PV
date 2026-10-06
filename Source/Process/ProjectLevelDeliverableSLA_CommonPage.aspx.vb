Imports CommonEngines.General.cEventHandlers

Public Class cProjectLevelDeliverableSLA_CommonPage
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProjectLevelDeliverableSLA_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    'Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        'added by ShitalN
        Dim StrSQL As String
        ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
        ''StrSQL = "SELECT IsSLAApplicable  FROM tbl_PM_DeliverableSLA WHERE ProjectSLAID=" + PrimaryKey.ToString
        StrSQL = "usp_sel_tbl_PM_DeliverableSLA_IsSLAApplicable " + PrimaryKey.ToString
        If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
            Cancel = True
        End If
        'End of addition
    End Sub
End Class
Public Class cProjectLevelDeliverableSLA_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cProjectLevelDeliverableSLA_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


    'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    'Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    'End Sub

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)
        'Added By ShitalN
        'For Details Tag
        Dim StrSQL As String
        If WhizGlobal.ParentTagID <> 0 Then
            Select Case Args.ControlName.ToUpper
                Case "PRIORITYID"
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''StrSQL = "SELECT PriorityTracking  FROM tbl_PM_DeliverableSLA WHERE ProjectSLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_PM_DeliverableSLA_PriorityTracking " + Args.MasterPrimaryKeyValue.ToString
                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
                Case "SEVERITYID"
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''StrSQL = "SELECT SeverityTracking  FROM tbl_PM_DeliverableSLA WHERE ProjectSLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_PM_DeliverableSLA_SeverityTracking " + Args.MasterPrimaryKeyValue.ToString
                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
                Case "COMPLEXITYID"
                    ''Commented added By Abhijeet K on 5/8/2016 Purpose : Remove Inline Query
                    ''StrSQL = "SELECT ComplexityTracking  FROM tbl_PM_DeliverableSLA WHERE ProjectSLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_PM_DeliverableSLA_ComplexityTracking " + Args.MasterPrimaryKeyValue.ToString
                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
            End Select
        End If
        'End of addition by ShitalN
    End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
End Class


Public Class ProjectLevelDeliverableSLA_CommonPage
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
        'Put user code to initialize the page here
        'Get this property from HashTable.
        'MyBase.strListPage = "CommonList.aspx"
        MyBase.strListPage = "ProjectLevelDeliverableSLA_CommonList.aspx"
        MyBase.strFormPage = "ProjectLevelDeliverableSLA_CommonPage.aspx"
        MyBase.ApplySecurity(True)

        MyBase.Page_Load(sender, e)



    End Sub

    'Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String


    'End Function

    'Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    'End Function




    'Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub

    'Protected Overrides Sub Before_ExecutingAction(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)

    'End Sub



    'Protected Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Sub Section_Title_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_SectionTitle, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataGrid(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    'Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLink_Print(ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_NavLinks_Print(ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub After_Paging_Print(ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

    'End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'For Master Page
        If WhizGlobal.ParentTagID = 0 Then
            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                'New Values of IsApplicalble,PriorityTracking,ComplexityTracking,SeverityTracking
                Args.ToBeInsertedInFunction += "var objNewChk = GetObjectReference('frmCommonPage','IsSLAApplicable');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objNewPriority = GetObjectReference('frmCommonPage','PriorityTracking');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objNewComplexity = GetObjectReference('frmCommonPage','ComplexityTracking');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objNewSeverity = GetObjectReference('frmCommonPage','SeverityTracking');" + vbCrLf
                'Old Values of IsApplicalble,PriorityTracking,ComplexityTracking,SeverityTracking 
                Args.ToBeInsertedInFunction += "var objOldChk = GetObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objOldPriority = GetObjectReference('frmCommonPage','NonDatabase2');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objOldSeverity = GetObjectReference('frmCommonPage','NonDatabase3');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objOldComplexity = GetObjectReference('frmCommonPage','NonDatabase4');" + vbCrLf
                'Count of Norms 
                Args.ToBeInsertedInFunction += "var objNormCount = GetObjectReference('frmCommonPage','NonDatabase5');" + vbCrLf
                Args.ToBeInsertedInFunction += "var blnSPCChanged;blnSPCChanged=0;" + vbCrLf

                'Validation : if SLA is applicable ,then at least one tracking parameter shuld present. 
                Args.ToBeInsertedInFunction += "if(objNewChk.checked==true)" + vbCrLf
                Args.ToBeInsertedInFunction += "{ if(objNewPriority.checked==false && objNewSeverity.checked==false && objNewComplexity.checked==false)" + vbCrLf
                Args.ToBeInsertedInFunction += " {  alert('Please select at least one tracking parameter if SLA is applicable for Deliverable type');" + vbCrLf
                Args.ToBeInsertedInFunction += " return; " + vbCrLf
                Args.ToBeInsertedInFunction += " } } " + vbCrLf
                'Validation : If IsSLAApplicable is unchecked ,then delete all norms 
                Args.ToBeInsertedInFunction += "if((objNewChk.checked==false) && (objOldChk.value == 'True') && (objNormCount.value>0))" + vbCrLf
                Args.ToBeInsertedInFunction += "{if (confirm('Making Customer level SLA Definition as Non-SLA will remove the SLA Norm data.\r\nDo you want to continue?') == false)" + vbCrLf
                Args.ToBeInsertedInFunction += " return; " + vbCrLf
                Args.ToBeInsertedInFunction += " }" + vbCrLf


                'Args.ToBeInsertedInFunction += "alert(objNewSeverity.checked)" + vbCrLf
                'Args.ToBeInsertedInFunction += "alert(objOldSeverity.value)" + vbCrLf
                'Args.ToBeInsertedInFunction += "alert(objNewPriority.checked)" + vbCrLf
                'Args.ToBeInsertedInFunction += "alert(objOldPriority.value)" + vbCrLf
                'Args.ToBeInsertedInFunction += "alert(objNewComplexity.checked)" + vbCrLf
                'Args.ToBeInsertedInFunction += "alert(objOldComplexity.value)" + vbCrLf




                Args.ToBeInsertedInFunction += "if ( ((objNewSeverity.checked==true) && (objOldSeverity.value== 'False' )) || ((objNewSeverity.checked==false) && (objOldSeverity.value=='True')) )" + vbCrLf
                Args.ToBeInsertedInFunction += "{ blnSPCChanged=1;  }" + vbCrLf
                Args.ToBeInsertedInFunction += "if ( ((objNewPriority.checked==true) && (objOldPriority.value=='False') )  ||((objNewPriority.checked==false) && (objOldPriority.value=='True')) )" + vbCrLf
                Args.ToBeInsertedInFunction += "{ blnSPCChanged=1;  }" + vbCrLf
                Args.ToBeInsertedInFunction += "if (((objNewComplexity.checked==true) && (objOldComplexity.value=='False')) || ((objNewComplexity.checked==false) && (objOldComplexity.value=='True')))" + vbCrLf
                Args.ToBeInsertedInFunction += " { blnSPCChanged=1; }" + vbCrLf

                Args.ToBeInsertedInFunction += "if((objNormCount.value>0) && blnSPCChanged==1 && objNewChk.checked== true && (objNewPriority.checked==true || objNewSeverity.checked==true || objNewComplexity.checked==true))" + vbCrLf
                Args.ToBeInsertedInFunction += "{if (confirm('Changing the SLA tracking values will remove the SLA definition data.\r\nDo you want to continue?') == false)" + vbCrLf
                Args.ToBeInsertedInFunction += "return ; }" + vbCrLf

            End If
            'Else
            'For Detail Page
            'If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
            '    Args.ToBeInsertedInFunction += "var objNorm= GetObjectReference('frmCommonPage','Norm');" + vbCrLf
            '    Args.ToBeInsertedInFunction += "if (objNorm.value < 0.1 )"

            'End If

        End If


    End Sub

    'Protected Overrides Sub Before_NavLink_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLink, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_NavLinks_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_NavLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PagingLink, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub BeforePlotTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_Tab, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function

    'Protected Overrides Sub DataRowTD_AfterPrint(ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_AfterPrint(ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub

    'Protected Overrides Sub InitializeTAB_SubTag(ByRef Cancel As Boolean, ByRef Args As Tab.WAF_TabSettings, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Section_Title_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_SectionLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cProjectLevelDeliverableSLA_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProjectLevelDeliverableSLA_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProjectLevelDeliverableSLA_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '  Return New cProjectLevelDeliverableSLA_CommonPageDataManagement(MyBase.m_objGlobal)

    'End Function

    'Protected Overrides Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cProjectLevelDeliverableSLA_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function


    Protected Overloads Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cProjectLevelDeliverableSLA_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function
    Public Class cProjectLevelDeliverableSLA_CommonPageDataManagement
        Inherits CommonEngine.CommonPage.cDataManagement
        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub
    End Class

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProjectLevelDeliverableSLA_CommonPageDataManagement(MyBase.m_ObjGlobal)
    End Function

    'Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function
End Class
