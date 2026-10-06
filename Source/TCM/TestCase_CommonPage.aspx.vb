Imports CommonEngines.General.cEventHandlers



Public Class TestCase_CommonPage
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
        MyBase.strListPage = "TestCase_CommonList.aspx"
        MyBase.strFormPage = "TestCase_CommonPage.aspx"


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

    'Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    'Put user code to initialize the page here
    '    Return New c < PAGE_NAME > PlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New c < PAGE_NAME > PlotControls(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New c < PAGE_NAME > CPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New c < PAGE_NAME > DataManagement(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New c < PAGE_NAME > SubTagCLSQL(WhizGlobal)
    'End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New TestCase_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strscript As String
        If HttpContext.Current.Request.QueryString("COPYDATA") = "1" Then
            If Args.LinkName.ToUpper = "SAVE" Then

                Args.ToBeInsertedInFunction = "var objTestSection,objBriefScenario,objScenario,objTestData;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPriority,objSeverity,objPlannedStaffTime;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPreconditionsAndSetup,objTestProcedure,objVerificationProcedure;" & vbCrLf

                Args.ToBeInsertedInFunction += "objTestSection=GetObjectReference('frmCommonPage','TestSection');" & vbCrLf
                Args.ToBeInsertedInFunction += "objBriefScenario=GetObjectReference('frmCommonPage','BriefScenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objScenario=GetObjectReference('frmCommonPage','Scenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestData=GetObjectReference('frmCommonPage','TestData');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPriority=GetObjectReference('frmCommonPage','Priority');" & vbCrLf
                Args.ToBeInsertedInFunction += "objSeverity=GetObjectReference('frmCommonPage','Severity');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPlannedStaffTime=GetObjectReference('frmCommonPage','PlannedStaffTime');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPreconditionsAndSetup=GetObjectReference('frmCommonPage','PreconditionsAndSetup');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestProcedure=GetObjectReference('frmCommonPage','TestProcedure');" & vbCrLf
                Args.ToBeInsertedInFunction += "objVerificationProcedure=GetObjectReference('frmCommonPage','VerificationProcedure');" & vbCrLf


                Args.ToBeInsertedInFunction += " objForm = GetFormReference('frmCommonPage');" + vbCrLf
                Args.ToBeInsertedInFunction += "        objForm.action='../TCM/TestCase_CommonPage.aspx?Operation=SAVE&Mode=ADD_NEW&FromWhere=SM&PagingAlphabet=-1&ParentTagID=0&COPYDATA=1&TestCaseID=" + HttpContext.Current.Request.QueryString("TestCaseID") + "&TestSetID=" + HttpContext.Current.Request.QueryString("TestSetID") + "&MasterTagID=3655';" + vbCrLf
                Args.ToBeInsertedInFunction += "        objForm.submit();" + vbCrLf
                '  Args.ToBeInsertedInFunction += "window.close();" & vbCrLf
                Args.ToBeInsertedInFunction += "        return;" + vbCrLf


            End If
        ElseIf HttpContext.Current.Request.QueryString("COPYDATA") <> "1" Then


            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then

                Args.ToBeInsertedInFunction = "var objTestSection,objBriefScenario,objScenario,objTestData;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPriority,objSeverity,objPlannedStaffTime;" & vbCrLf
                Args.ToBeInsertedInFunction += "var objPreconditionsAndSetup,objTestProcedure,objVerificationProcedure;" & vbCrLf

                Args.ToBeInsertedInFunction += "objTestSection=GetObjectReference('frmCommonPage','TestSection');" & vbCrLf
                Args.ToBeInsertedInFunction += "objBriefScenario=GetObjectReference('frmCommonPage','BriefScenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objScenario=GetObjectReference('frmCommonPage','Scenario');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestData=GetObjectReference('frmCommonPage','TestData');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPriority=GetObjectReference('frmCommonPage','Priority');" & vbCrLf
                Args.ToBeInsertedInFunction += "objSeverity=GetObjectReference('frmCommonPage','Severity');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPlannedStaffTime=GetObjectReference('frmCommonPage','PlannedStaffTime');" & vbCrLf
                Args.ToBeInsertedInFunction += "objPreconditionsAndSetup=GetObjectReference('frmCommonPage','PreconditionsAndSetup');" & vbCrLf
                Args.ToBeInsertedInFunction += "objTestProcedure=GetObjectReference('frmCommonPage','TestProcedure');" & vbCrLf
                Args.ToBeInsertedInFunction += "objVerificationProcedure=GetObjectReference('frmCommonPage','VerificationProcedure');" & vbCrLf

            End If
        End If
    End Sub

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim objcopy As New CopyData
        Dim COPYDATA As String
        Dim UniqueID As Integer = 0
        Dim strTobeInserted As String
        COPYDATA = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("COPYDATA"), ""), String)
        If COPYDATA <> "" Then
            UniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TestCaseID"), "0"), Integer)
        End If
        If COPYDATA <> "" And UniqueID <> 0 Then
            strTobeInserted = objcopy.CopyData(3655, CInt(HttpContext.Current.Request.QueryString("TestCaseID")), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            PageUIPostRender = strTobeInserted
            strActionCode = ReturnCodes.ON_LOAD.ToString
        End If
    End Function



    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        'Dim strscript As String
        'Dim intTestSetId As Integer
        'intTestSetId = CInt(HttpContext.Current.Request.QueryString("TestSetID"))
        'If IsEditMode = False Then
        '    AfterSave = "opener.location.href='../TCM/TestCase_CommonList.aspx?FromWhere=PM&MasterTagId=3655&TestSetID=" + CStr(intTestSetId) + "';"
        '    AfterSave += vbCrLf + "window.close();"
        '    RedirectToCL = False
        '    strActionCode = ReturnCodes.ON_LOAD.ToString
        'End If
    End Function
End Class
Public Class TestCase_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strSQL As String
        Dim strTestCaseCode As String
        Dim drTest As IDataReader
        Dim intTestSetId As Integer
        Dim intTestSectionId As Integer

        intTestSetId = CType(HttpContext.Current.Request.QueryString("TestSetId"), Integer)
        If Args.ControlName.ToUpper = "TESTCASECODE" Then
            If Args.PrimaryKeyValue = "" Then
                Args.IgnoreActualValue = True
                strSQL = "EXEC usp_sel_tbl_TestCode " & intTestSetId

                drTest = CommonFunctions.Data.GetDataReader(strSQL, True)
                If drTest.Read Then
                    strTestCaseCode = CStr(CommonFunctions.General.CheckIsNothing(drTest("GeneratedCode")))
                End If
                CommonFunction.Data.DisposeDataReader(drTest)
                Args.NewValue = strTestCaseCode
            End If
        End If
        If Args.ControlName.ToUpper = "TESTSECTIONID" Then
            Args.AdditionalInformation = "usp_Sel_tbl_TCM_TestSection  " + CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
            Args.DropDownEditSQL = "usp_Sel_tbl_TCM_TestSection  " + CType(HttpContext.Current.Request.QueryString("TestSetID"), String)
        End If

    End Sub
End Class

'Public Class c<PAGE_NAME>DataManagement
'    Inherits CommonEngine.CommonPage.cDataManagement
'    'Constructor
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub
'End Class
'Public Class c<PAGE_NAME>SubTagCLSQL
'    Inherits CommonEngine.CommonList.cSubTagCLSQL
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        'Assign the Parameter values to the local variables
'        Call MyBase.New(WhizGlobal)
'    End Sub

'    Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

'    End Sub
'End Class
'Public Class c<PAGE_NAME>CPSQL
'    Inherits CommonEngine.CommonPage.cCPSQL
'    'Constructor
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        Call MyBase.New(WhizGlobal)
'    End Sub


'End Class
'Public Class c<PAGE_NAME>PlotControls
'    Inherits CommonEngine.CommonPage.cPlotControls
'    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
'        ''Assign the Parameter values to the local variables
'        Call MyBase.New(WhizGlobal)
'    End Sub


'    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

'    End Sub

'    Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

'    End Sub

'    Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

'    End Sub

'    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

'    End Sub

'    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

'    End Sub

'    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

'    End Sub

'    Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

'    End Function


'    Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

'    End Sub
'End Class

