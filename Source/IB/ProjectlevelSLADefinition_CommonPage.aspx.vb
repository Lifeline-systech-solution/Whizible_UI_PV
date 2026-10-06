Imports CommonEngines.General.cEventHandlers
Public Class ProjectlevelSLADefinition_CommonPage
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
        MyBase.strListPage = "ProjectlevelSLADefinition_CommonList.aspx"
        MyBase.strFormPage = "ProjectlevelSLADefinition_CommonPage.aspx"


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

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String

        'Code Added By PradipK on 7 June 2006
        'If DeliverableLevelCustomer is True for that Project & ShowTOCustomer is true for that Discussion Thread then  fire Mail to Customer(CustomerID in tbl_IB_Issue) 
        'Previously mail goes to Project Customer.
        Dim strSQL As String
        ' Dim objDr As IDataReader
        Dim blnUseSQL As Boolean = True
        Dim strUserName As String
        'Dim blnIssueCustomer As Boolean
        ' Dim blnShowToCustomer As Boolean = False

        'strSQL = "SELECT IsProductExecutionProject,DeliverableLevelCustomer,CustomerID FROM tbl_PM_Project INNER JOIN tbl_PRS_ProjectTypes ON tbl_PM_Project.ProjectType=tbl_PRS_ProjectTypes.ProjectType WHERE  tbl_PM_Project.ProjectID='" + HttpContext.Current.Session("intProjectID").ToString + "'"
        'objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
        'If objDr.Read Then
        '    If objDr("DeliverableLevelCustomer").ToString = "True" And objDr("IsProductExecutionProject").ToString = "True" Then

        '    Else
        '        strSQL = "UPDATE tbl_PM_ProjectSLA  set CustomerID='" + objDr("CustomerID").ToString + "'   WHERE ProjectSLAID='" + PrimaryKey + "'"
        '        CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
        '    End If
        'Else
        'Commented and Modified By JyotiG
        'Start_JG_11556_12-Apr-2007
        'strSQL = "UPDATE tbl_PM_ProjectSLA  set CustomerID=(SELECT CUSTOMERID FROM tbl_PM_Project WHERE ProjectID='" + HttpContext.Current.Session("intProjectID").ToString + "')   WHERE ProjectSLAID='" + PrimaryKey + "'"
        strUserName = CommonFunctions.General.CheckIsNothing(m_objGlobal.UserName, "").ToString()
        strSQL = "UPDATE tbl_PM_ProjectSLA  set CustomerID=(SELECT CUSTOMERID FROM tbl_PM_Project WHERE ProjectID='" + HttpContext.Current.Session("intProjectID").ToString + "' ), ModifyBy='" + strUserName + "' WHERE ProjectSLAID='" + PrimaryKey + "'"
        'End_JG_11556_12-Apr-2007
        CommonFunction.Data.SQLInsertOrUpdateData(strSQL)
        'End If
        ' CommonFunctions.Data.DisposeDataReader(objDr)

    End Function

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
                Args.ToBeInsertedInFunction += " {  alert('Please select at least one tracking parameter if SLA is applicable for issue type');" + vbCrLf
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

                'End Addition By PradipK on 13 March 2006 for SLA Management
            End If




        Else
            ''For Detail Page
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

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strScript As String
        Dim strCustomerID As String
        Dim strType As String
        Dim strSQL As String
        Dim lngProjectID As Long
        lngProjectID = CType(CommonFunction.General.CheckIsNothing("0" & HttpContext.Current.Session("intProjectID").ToString, "0"), Long)
        If PrimaryKey.ToString = "" Then 'Add Mode
            strCustomerID = CType(ControlsHashTable("CustomerID"), String)
            strType = CType(ControlsHashTable("TYPE"), String)
            'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
            'strSQL = "SELECT Count(ProjectSLAID) FROM tbl_PM_ProjectSLA  WHERE CustomerID='" + strCustomerID + "'  AND Type='" + strType + "' AND ProjectID='" + lngProjectID.ToString + "'"
            strSQL = "usp_sel_tbl_PM_ProjectSLA_SLA '" + strCustomerID + "','" + strType + "','" + lngProjectID.ToString + "'"
            'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

            If CType(CommonFunctions.Data.GetDataScalar(strSQL, True), String) <> "0" Then
                strScript = "<script language = javascript>"
                strScript += "alert('SLA is already defined for this customer for selected issue type.');"
                strScript += "</script>"
                CommonFunction.General.WriteHTML(strScript)
                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
            End If
        End If

        'End Addition By PradipK on 13 March 2006 for SLA Management
    End Function

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
        Return New cProjectlevelSLADefinition_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProjectlevelSLADefinition_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProjectlevelSLADefinition_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProjectlevelSLADefinition_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cProjectlevelSLADefinition_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function
    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cProjectlevelSLADefinition_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function



End Class

Public Class cProjectlevelSLADefinition_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProjectlevelSLADefinition_CommonPageSubTagCLSQL
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
        Dim StrSQL As String
        'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
        ' StrSQL = "SELECT IsSLAApplicable  FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" + PrimaryKey.ToString
        StrSQL = "usp_sel_Applicable_tbl_PM_ProjectSLA " + PrimaryKey.ToString
        'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

        If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
            Cancel = True
        End If
    End Sub
End Class
Public Class cProjectlevelSLADefinition_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cProjectlevelSLADefinition_CommonPagePlotControls
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

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim lngProjectID As Long
        Dim strSQL As String
        Dim objDr As IDataReader
        Dim blnUseSQL As Boolean = True
        Dim blnIssueCustomer As Boolean
        Dim blnShowToCustomer As Boolean = False

        lngProjectID = CType(CommonFunction.General.CheckIsNothing("0" & HttpContext.Current.Session("intProjectID").ToString, "0"), Long)

        If WhizGlobal.ParentTagID = 0 Then
            Select Case Args.ControlName.ToUpper



                Case "CUSTOMERID"
                    'Code Added By PradipK on 7 June 2006
                    'If DeliverableLevelCustomer is True for that Project & ShowTOCustomer is true for that Discussion Thread then  fire Mail to Customer(CustomerID in tbl_IB_Issue) 
                    'Previously mail goes to Project Customer.

                    'strSQL = "SELECT IsProductExecutionProject,DeliverableLevelCustomer FROM tbl_PM_Project INNER JOIN tbl_PRS_ProjectTypes ON tbl_PM_Project.ProjectType=tbl_PRS_ProjectTypes.ProjectType WHERE  tbl_PM_Project.ProjectID='" + HttpContext.Current.Session("intProjectID").ToString + "'"
                    'objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
                    'If objDr.Read Then
                    '    If objDr("DeliverableLevelCustomer").ToString = "True" And objDr("IsProductExecutionProject").ToString = "True" Then
                    '    Else
                    '        Cancel = True
                    '    End If
                    'Else
                    '    Cancel = True
                    'End If
                    'CommonFunctions.Data.DisposeDataReader(objDr)
                    Cancel = True
                    'Code Added By PradipK on 7 June 2006


                Case "TYPE"
                    If lngProjectID > 0 Then
                        Args.AdditionalInformation = "SELECT DISTINCT Type from tbl_IB_Project_Sub_Type WHERE Projectid=" & lngProjectID.ToString & "  AND Type NOT IN (SELECT Type FROM tbl_PM_ProjectSLA WHERE ProjectID= " & lngProjectID.ToString & "   )  order by Type "
                    End If
            End Select
        Else
            'For Detail Page.
            Select Case Args.ControlName.ToUpper
                Case "SEVERITYID"
                    If lngProjectID > 0 Then
                        If Args.PrimaryKeyValue = "" Then
                            Args.AdditionalInformation = "select  ProjectSeverityID, Severity FROM tbl_IB_Project_Severity WHERE ProjectID=" & lngProjectID.ToString & " order by Severity  "
                        Else
                            Args.DropDownEditSQL = "select  ProjectSeverityID, Severity FROM tbl_IB_Project_Severity WHERE ProjectID=" & lngProjectID.ToString & " order by Severity  "
                        End If

                    End If
                Case "PRIORITYID"
                    If lngProjectID > 0 Then
                        If Args.PrimaryKeyValue = "" Then
                            Args.AdditionalInformation = "select  PriorityID, Priority FROM tbl_IB_Project_Priorities WHERE ProjectID=" & lngProjectID.ToString & " order by Priority"
                        Else
                            Args.DropDownEditSQL = "select  PriorityID, Priority FROM tbl_IB_Project_Priorities WHERE ProjectID=" & lngProjectID.ToString & " order by Priority"
                        End If

                    End If
                Case "COMPLEXITYID"
                    If lngProjectID > 0 Then
                        If Args.PrimaryKeyValue = "" Then
                            Args.AdditionalInformation = "select  ComplexityID,Complexity FROM tbl_IB_ProjectComplexityMaster WHERE ProjectID=" & lngProjectID.ToString & " order by Complexity"
                        Else
                            Args.AdditionalInformation = "select  ComplexityID,Complexity FROM tbl_IB_ProjectComplexityMaster WHERE ProjectID=" & lngProjectID.ToString & " order by Complexity"
                        End If

                    End If
                Case "STATUSFROMID"
                    If lngProjectID > 0 Then
                        If Args.PrimaryKeyValue = "" Then  'Add Mode
                            Args.AdditionalInformation = "SELECT ProjecttypeStatusID,Status FROM tbl_IB_Project_Type_Status WHERE Type=(SELECT Type FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" & Args.MasterPrimaryKeyValue.ToString & "  )  AND PROJECTID= " & lngProjectID.ToString & ""
                        Else 'Edit Mode
                            Args.DropDownEditSQL = "SELECT ProjecttypeStatusID,Status FROM tbl_IB_Project_Type_Status WHERE Type=(SELECT Type FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" & Args.MasterPrimaryKeyValue.ToString & "  )  AND PROJECTID= " & lngProjectID.ToString & ""
                        End If
                    End If
                Case "STATUSTOID"
                    If lngProjectID > 0 Then
                        If Args.PrimaryKeyValue = "" Then
                            Args.AdditionalInformation = "SELECT ProjecttypeStatusID,Status FROM tbl_IB_Project_Type_Status WHERE Type=(SELECT Type FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" & Args.MasterPrimaryKeyValue.ToString & "  )  AND PROJECTID= " & lngProjectID.ToString & ""
                        Else
                            Args.DropDownEditSQL = "SELECT ProjecttypeStatusID,Status FROM tbl_IB_Project_Type_Status WHERE Type=(SELECT Type FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" & Args.MasterPrimaryKeyValue.ToString & "  )  AND PROJECTID= " & lngProjectID.ToString & ""
                        End If
                    End If

            End Select
        End If
    End Sub

    'Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    'End Sub

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

        'For Details Tag
        Dim StrSQL As String
        If WhizGlobal.ParentTagID = 0 Then
            Select Case Args.ControlName.ToUpper
                Case "CUSTOMERID"
                    'Code Added By PradipK on 7 June 2006
                    'If DeliverableLevelCustomer is True for that Project & ShowTOCustomer is true for that Discussion Thread then  fire Mail to Customer(CustomerID in tbl_IB_Issue) 
                    'Previously mail goes to Project Customer.
                    '' Dim strSQL As String
                    'Dim objDr As IDataReader
                    'Dim blnUseSQL As Boolean = True
                    'Dim blnIssueCustomer As Boolean
                    'Dim blnShowToCustomer As Boolean = False

                    'StrSQL = "SELECT IsProductExecutionProject,DeliverableLevelCustomer FROM tbl_PM_Project INNER JOIN tbl_PRS_ProjectTypes ON tbl_PM_Project.ProjectType=tbl_PRS_ProjectTypes.ProjectType WHERE  tbl_PM_Project.ProjectID='" + HttpContext.Current.Session("intProjectID").ToString + "'"
                    'objDr = CommonFunctions.Data.GetDataReader(strSQL, blnUseSQL)
                    'If objDr.Read Then
                    '    If objDr("DeliverableLevelCustomer").ToString = "True" And objDr("IsProductExecutionProject").ToString = "True" Then
                    '    Else
                    '        Cancel = True
                    '    End If
                    'Else
                    '    Cancel = True
                    'End If
                    'CommonFunctions.Data.DisposeDataReader(objDr)
                    Cancel = True
                    'Code Added By PradipK on 7 June 2006
            End Select


        Else

            Select Case Args.ControlName.ToUpper
                Case "PRIORITYID"
                    'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                    ' StrSQL = "SELECT PriorityTracking  FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_PM_ProjectSLA_Priority " + Args.MasterPrimaryKeyValue.ToString
                    'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
                Case "SEVERITYID"
                    'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                    'StrSQL = "SELECT SeverityTracking  FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_Severity_tbl_PM_ProjectSLA " + Args.MasterPrimaryKeyValue.ToString

                    'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
                Case "COMPLEXITYID"
                    'Commented and added by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query
                    ' StrSQL = "SELECT ComplexityTracking  FROM tbl_PM_ProjectSLA WHERE ProjectSLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_Complexity_PM_ProjectSLA " + Args.MasterPrimaryKeyValue.ToString
                    'End of addition by Tejal Deshmukh on 08-Aug-2016 To Remove Inline Query

                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
            End Select
        End If


    End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
End Class


