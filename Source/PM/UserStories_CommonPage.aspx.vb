Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions.General
Imports CommonFunctions.Data
Public Class cUserStories_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cUserStories_CommonPageSubTagCLSQL
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
Public Class cUserStories_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cUserStories_CommonPagePlotControls
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

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If Args.ControlName = "EntityStateID" Then
            Dim strSql As String
            Dim IsFinal As String
            'Commented and Added by Chakshuta H on 8th-Aug-2016 
            'strSql = "SELECT ISNULL(Final,0) FROM tbl_PM_ScrumUserStory INNER JOIN tbl_PM_ScrumEntityState ON tbl_PM_ScrumUserStory.EntityStateID = tbl_PM_ScrumEntityState.EntityStateID"
            'strSql += " WHERE UserStoryId = " + Args.PrimaryKeyValue
            strSql = " usp_sel_tbl_PM_ScrumUserStory_Final " + Args.PrimaryKeyValue
            'End Of Commented and Added by Chakshuta H on 8th-Aug-2016 
            IsFinal = CType(CommonFunctions.Data.GetDataScalar(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            If IsFinal = "True" Then
                Args.DisableInEditMode = True
            End If
        End If
    End Sub

    'Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal global As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub
End Class


Public Class UserStories_CommonPage
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
        MyBase.strListPage = "UserStories_CommonList.aspx"
        MyBase.strFormPage = "UserStories_CommonPage.aspx"

        
        MyBase.Page_Load(sender, e)



    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If Not Request.QueryString("From") Is Nothing Then
            Response.Write("<input type=hidden name='hidFromDailyProg' id='hidFromDailyProg' value=" + Request.QueryString("From").ToString + " >")
        Else
            Response.Write("<input type=hidden name='hidFromDailyProg' id='hidFromDailyProg' value=''>")
        End If
        'Added by NitinC on 04 Jan 2011 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 57667)
        If Not Request.QueryString("ReleaseID") Is Nothing Then
            Response.Write("<input type=hidden name='hidReleaseID' id='hidReleaseID' value=" + Request.QueryString("ReleaseID").ToString + " >")
        Else
            Response.Write("<input type=hidden name='hidReleaseID' id='hidReleaseID' value=''>")
        End If
        If CheckIsNothing(Request.QueryString("Frm"), "") = "DailyProgress" Then
            Response.Write("<script language=javascript>")
            Response.Write("refreshParent('frmDailyProgress','PM_DailyProgress.aspx','../PM/PM_DailyProgress.aspx?ReleaseID=" + Request.QueryString("DailyProgressReleaseID").ToString + "&StoryOrBug=User Story');")
            Response.Write("</script>")
        End If
        'End of added by NitinC on 04 Jan 2011 for WhizibleSEM 11.0 - Agile Module (Issue Fix : 57667)
    End Function

    'Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    'End Function




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

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

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

    'Public Overrides Function BeforeSave(ByVal Global As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

    'End Function

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
        Return New cUserStories_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cUserStories_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cUserStories_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cUserStories_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cUserStories_CommonPageSubTagCLSQL(WhizGlobal)
    End Function
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cUserStories_CommonPagecPlotGrid(m_objSubTagGlobal)
    End Function
End Class
Public Class cUserStories_CommonPagecPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        MyBase.Before_GridColumnHeaderTD_Print(Cancel, Args, WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.TagID = "3365" Then
            If Args.DataReader("IsActive").ToString = "Void" Then
                Args.clsTR = "clsScrumTROdd"
            End If
        End If
    End Sub
End Class
