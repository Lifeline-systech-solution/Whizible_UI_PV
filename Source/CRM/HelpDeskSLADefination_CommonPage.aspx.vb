Imports CommonEngines.General.cEventHandlers

Public Class HelpDeskSLADefination_CommonPage
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
        MyBase.strListPage = "HelpDeskSLADefination_CommonList.aspx"
        MyBase.strFormPage = "HelpDeskSLADefination_CommonPage.aspx"
        'MyBase.strSubTagFormPage = "../General/CommonPage.aspx"

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

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

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
        Return New cHelpDeskSLADefination_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cHelpDeskSLADefination_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cHelpDeskSLADefination_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cHelpDeskSLADefination_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cHelpDeskSLADefination_CommonPageSubTagCLSQL(m_objSubTagGlobal)
    End Function


    '  Protected Overloads Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '     Return New cHelpDeskSLADefination_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    ' End Function
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cMyPlotSubTagGrid1(m_objSubTagGlobal)
    End Function

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strScript As String
        Dim strCustomerID As String
        Dim strTypeID As String
        Dim strSQL As String

        'Added by SavitaS on 13 Sept 2006 for SP7 IssueID 4690
        If Request.QueryString("FromCombo") & "" <> "" Then
            strActionCode = ReturnCodes.IGNORE_SAVE.ToString
            Exit Function
        End If
        'End Addition by SavitaS on 13 Sept 2006 for SP7 IssueID 4690

        If WhizGlobal.ParentTagID = 0 Then  'For Master Page..
            If PrimaryKey.ToString = "" Then 'Add Mode
                strCustomerID = CType(ControlsHashTable("CustomerID"), String)
                strTypeID = CType(ControlsHashTable("SubRequestTypeID"), String)

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQL = "SELECT Count(SLAID) FROM tbl_CNF_HelpdeskSLA WHERE CustomerID='" + strCustomerID + "'  AND SubRequestTypeID='" + strTypeID + "'"
                strSQL = "usp_sel_tbl_CNF_HelpdeskSLA_CountSLAID '" + strCustomerID + "','" + strTypeID + "'"
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If CType(CommonFunctions.Data.GetDataScalar(strSQL, True), String) <> "0" Then
                    strScript = "<script language = javascript>"
                    strScript += "alert('SLA is already defined for this customer.');"
                    strScript += "</script>"
                    CommonFunction.General.WriteHTML(strScript)
                    strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                End If
            End If
        End If
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'If WhizGlobal.ParentTagID = 0 Then
        '    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

        '        Args.ToBeInsertedInFunction += "var objNewChk = GetObjectReference('frmCommonPage','IsSLAApplicable');" + vbCrLf
        '        Args.ToBeInsertedInFunction += "var objOldChk = GetObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf
        '        Args.ToBeInsertedInFunction += "var objNormCount = GetObjectReference('frmCommonPage','NonDatabase2');" + vbCrLf
        '        Args.ToBeInsertedInFunction += "if( (objNewChk.checked==false) &&(objOldChk.value == 'True') && (objNormCount.value>0))" + vbCrLf
        '        Args.ToBeInsertedInFunction += "{if (confirm('Making Customer level SLA Definition as Non-SLA will remove the SLA Norm data.\r\nDo you want to continue?') == false)" + vbCrLf
        '        Args.ToBeInsertedInFunction += " return; " + vbCrLf
        '        Args.ToBeInsertedInFunction += " }" + vbCrLf
        '    End If
        'Else
        '    'For Detail Page
        '    If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
        '        Args.ToBeInsertedInFunction += "var objNorm= GetObjectReference('frmCommonPage','Norm');" + vbCrLf
        '        Args.ToBeInsertedInFunction += "if (objNorm.value < 0.1 )"

        '    End If

        'End If
    End Sub
End Class


Public Class cMyPlotSubTagGrid1
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim StrSQL As String
        'If WhizGlobal.ParentTagID = 0 Then
        '    Dim intSLAID As String
        '    intSLAID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SLAID_PK")).ToString
        '    If intSLAID = "" Then
        '        intSLAID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SLAID")).ToString
        '    End If
        '    Select Case Args.ColumnName.ToUpper
        '        Case "PRIORITY"
        '            StrSQL = "SELECT PriorityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + intSLAID
        '            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
        '                Cancel = True
        '            End If
        '        Case "SEVERITY"
        '            StrSQL = "SELECT SeverityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + intSLAID
        '            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
        '                Cancel = True
        '            End If
        '        Case "COMPLEXITY"
        '            StrSQL = "SELECT ComplexityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + intSLAID
        '            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
        '                Cancel = True
        '            End If
        '    End Select
        'End If
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim StrSQL As String
        'If WhizGlobal.ParentTagID = 0 Then
        '    Dim intSLAID As String
        '    intSLAID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SLAID_PK")).ToString
        '    If intSLAID = "" Then
        '        intSLAID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SLAID")).ToString
        '    End If
        '    Select Case Args.ColumnName.ToUpper
        '        Case "PRIORITY"
        '            StrSQL = "SELECT PriorityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + intSLAID
        '            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
        '                Cancel = True
        '            End If
        '        Case "SEVERITY"
        '            StrSQL = "SELECT SeverityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + intSLAID
        '            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
        '                Cancel = True
        '            End If
        '        Case "COMPLEXITY"
        '            StrSQL = "SELECT ComplexityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + intSLAID
        '            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
        '                Cancel = True
        '            End If
        '    End Select
        'End If
    End Sub
End Class
Public Class cHelpDeskSLADefination_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cHelpDeskSLADefination_CommonPageSubTagCLSQL
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

    'Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
    '    Dim StrSQL As String
    '    StrSQL = "SELECT IsSLAApplicable  FROM tbl_CNF_HelpdeskSLA WHERE SLAID=" + PrimaryKey.ToString
    '    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
    '        Cancel = True
    '    End If
    'End Sub
End Class
Public Class cHelpDeskSLADefination_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cHelpDeskSLADefination_CommonPagePlotControls
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
        Dim StrSQL As String

        If WhizGlobal.ParentTagID <> 0 Then

            If Args.ControlName.ToUpper = "PRIORITYID" Then

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''StrSQL = "SELECT ISSLAApplicable FROM tbl_CNF_HelpdeskSLA WHERE SLAID=" + Args.MasterPrimaryKeyValue.ToString
                StrSQL = "usp_sel_tbl_CNF_HelpdeskSLA_ISSLAApplicable " + Args.MasterPrimaryKeyValue.ToString
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then

                    Cancel = True

                End If



            End If

        End If

    End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

        If WhizGlobal.ParentTagID = 0 Then

            Select Case (HttpContext.Current.Request.QueryString("FromCombo") & "").ToUpper
                Case "DEPARTMENT"
                    Select Case Args.ControlName.ToUpper
                        Case "SLATYPE"
                            If Args.PrimaryKeyValue <> "" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form("SLAType")
                            Else
                                Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("SLAType")
                            End If
                        Case "DEPARTMENTID"
                            If Args.PrimaryKeyValue <> "" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form("DepartMentID")
                            Else
                                Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("DepartMentID")
                            End If
                        Case "CUSTOMERID"
                            Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("CustomerID")
                        Case "REQUESTTYPEID"
                            Args.IgnoreActualValue = True
                            Args.AdditionalInformation = "Select DISTINCT tbl_CRM_RequestType.RequestTypeID,RequestType " + _
                            " from tbl_CRM_Function_RequestTypes 	inner join tbl_CRM_RequestType on tbl_CRM_Function_RequestTypes.RequestTypeID = tbl_CRM_RequestType.RequestTypeID " + _
                            " where FunctionID = " + "0" + HttpContext.Current.Request.Form("DepartMentID")
                            Args.DropDownEditSQL = Args.AdditionalInformation
                        Case "SUBREQUESTTYPEID"
                            Args.IgnoreActualValue = True

                    End Select
                Case "REQUESTTYPE"
                    Select Case Args.ControlName.ToUpper
                        Case "SLATYPE"
                            If Args.PrimaryKeyValue <> "" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form("SLAType")
                            Else
                                Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("SLAType")
                            End If
                        Case "DEPARTMENTID"
                            If Args.PrimaryKeyValue <> "" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form("DepartMentID")
                            Else
                                Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("DepartMentID")
                            End If
                        Case "CUSTOMERID"
                            Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("CustomerID")
                        Case "REQUESTTYPEID"
                            If Args.PrimaryKeyValue <> "" Then
                                Args.IgnoreActualValue = True
                                Args.NewValue = HttpContext.Current.Request.Form("RequestTypeID")
                            Else
                                Args.DefaultValue = "1-" + HttpContext.Current.Request.Form("RequestTypeID")
                            End If
                            Args.AdditionalInformation = "Select DISTINCT tbl_CRM_RequestType.RequestTypeID,RequestType " + _
                            " from tbl_CRM_Function_RequestTypes 	inner join tbl_CRM_RequestType on tbl_CRM_Function_RequestTypes.RequestTypeID = tbl_CRM_RequestType.RequestTypeID " + _
                            " where FunctionID = " + "0" + HttpContext.Current.Request.Form("DepartMentID")
                            Args.DropDownEditSQL = Args.AdditionalInformation
                        Case "SUBREQUESTTYPEID"
                            Args.IgnoreActualValue = True
                            If HttpContext.Current.Request.Form("RequestTypeID") & "" <> "" Then
                                Args.AdditionalInformation = "usp_Sel_tbl_CRM_SubRequestType_SLA NULL"

                                If HttpContext.Current.Request.Form("CustomerID") & "" <> "" Then
                                    Args.AdditionalInformation += "," + HttpContext.Current.Request.Form("CustomerID")
                                Else
                                    Args.AdditionalInformation += ",NULL"
                                End If
                                Args.AdditionalInformation += "," + HttpContext.Current.Request.Form("DepartMentID")

                                Args.AdditionalInformation += "," + HttpContext.Current.Request.Form("RequestTypeID")
                                Args.AdditionalInformation += ",'" + HttpContext.Current.Request.Form("SLAType") + "'"
                                Args.DropDownEditSQL = Args.AdditionalInformation
                            End If


                    End Select
                Case "" 'Edit mode Without Postback from any Combo. First Hit
                    If Args.PrimaryKeyValue <> "" Then
                        Select Case Args.ControlName.ToUpper
                            Case "REQUESTTYPEID"
                                Dim strDepartmentID As String = CommonFunction.Data.GetDataScalar("Select DepartmentID from tbl_CNF_HelpdeskSLA where SLAID = " + Args.PrimaryKeyValue, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
                                Args.DropDownEditSQL = "Select DISTINCT tbl_CRM_RequestType.RequestTypeID,RequestType " + _
                                " from tbl_CRM_Function_RequestTypes 	inner join tbl_CRM_RequestType on tbl_CRM_Function_RequestTypes.RequestTypeID = tbl_CRM_RequestType.RequestTypeID " + _
                                " where FunctionID = " + "0" + strDepartmentID
                            Case "SUBREQUESTTYPEID"
                                Args.DropDownEditSQL = "usp_Sel_tbl_CRM_SubRequestType_SLA " + Args.PrimaryKeyValue
                        End Select


                    End If




            End Select
            Select Case Args.ControlName.ToUpper
                Case "ISSLAAPPLICABLE", "PRIORITYTRACKING"
                    Args.ToBeInserted = "checked"
                Case "NONDATABASE1"

                    If HttpContext.Current.Request.QueryString("FromCombo") & "" = "" Then
                        Args.DefaultValue = Args.DefaultValue + HttpContext.Current.Request.RawUrl()
                    Else
                        Dim str_url As String = HttpContext.Current.Request.RawUrl()
                        str_url = str_url.Substring(0, str_url.LastIndexOf("&FromCombo"))
                        Args.DefaultValue = Args.DefaultValue + str_url
                    End If

                Case "CUSTOMERID"
                    Args.ValidationRules = ""

            End Select
        End If


    End Sub
End Class



