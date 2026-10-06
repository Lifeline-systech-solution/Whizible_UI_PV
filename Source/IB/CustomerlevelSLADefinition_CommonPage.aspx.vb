Imports CommonEngines.General.cEventHandlers
Public Class CustomerlevelSLADefinition_CommonPage
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
        MyBase.strListPage = "CustomerlevelSLADefinition_CommonList.aspx"
        MyBase.strFormPage = "CustomerlevelSLADefinition_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub


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
        Dim strTypeID As String
        Dim strSQL As String
        If PrimaryKey.ToString = "" Then 'Add Mode
            strCustomerID = CType(ControlsHashTable("CustomerID"), String)
            strTypeID = CType(ControlsHashTable("TypeID"), String)
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'strSQL = "SELECT Count(SLAID) FROM tbl_cnf_CustomerSLA WHERE CustomerID='" + strCustomerID + "'  AND TypeID='" + strTypeID + "'"
            strSQL = "usp_sel_tbl_cnf_CustomerSLA '" + strCustomerID + "','" + strTypeID + "'"
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            If CType(CommonFunctions.Data.GetDataScalar(strSQL, True), String) <> "0" Then
                'strScript = "<script language = javascript>"
                strScript = " alert('SLA is already defined for this customer for selected issue type.');" + vbCrLf
                strScript += " return false; "
                'strScript += "</script>"
                'CommonFunction.General.WriteHTML(strScript)
                BeforeSave = strScript
                strActionCode = ReturnCodes.IGNORE_SAVE.ToString
                'RedirectToCL = False
            End If
        End If

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
        Return New cCustomerlevelSLADefinition_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cCustomerlevelSLADefinition_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cCustomerlevelSLADefinition_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cCustomerlevelSLADefinition_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cCustomerlevelSLADefinition_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cCustomerlevelSLADefinition_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        'Dim strScript As String
        'Dim strCustomerID As String
        'Dim strTypeID As String
        'Dim strSQL As String
        'If strPrimaryKey.ToString = "" Then 'Add Mode
        '    strCustomerID = HttpContext.Current.Request.QueryString("CustomerID")  'CType(ControlsHashTable("CustomerID"), String)
        '    strTypeID = HttpContext.Current.Request.QueryString("TypeID") ' CType(ControlsHashTable("TypeID"), String)
        '    strSQL = "SELECT Count(SLAID) FROM tbl_cnf_CustomerSLA WHERE CustomerID='" + strCustomerID + "'  AND TypeID='" + strTypeID + "'"
        '    If CType(CommonFunctions.Data.GetDataScalar(strSQL, True), String) <> "0" Then
        '        'strScript = "<script language = javascript>"
        '        strScript = " alert('SLA is already defined for this customer for selected issue type.');" + vbCrLf
        '        strScript += " return false; "
        '        'strScript += "</script>"
        '        'CommonFunction.General.WriteHTML(strScript)
        '        PageUIPostRender = strScript
        '        strActionCode = ReturnCodes.IGNORE_SAVE.ToString
        '        'RedirectToCL = False
        '    End If
        'End If
    End Function
End Class

Public Class cCustomerlevelSLADefinition_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cCustomerlevelSLADefinition_CommonPageSubTagCLSQL
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
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'StrSQL = "SELECT IsSLAApplicable  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + PrimaryKey.ToString
        StrSQL = "usp_sel_tbl_CNF_CustomerSLA_IsSLAApplicable " + PrimaryKey.ToString
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
            Cancel = True
        End If
    End Sub
End Class
Public Class cCustomerlevelSLADefinition_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cCustomerlevelSLADefinition_CommonPagePlotControls
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
    '    'If Norms are present for Customer SLA Defination ,then Make Customer & Issue Combo Non-editable.
    '    Dim StrSQL As String
    '    'For Master Tag
    '    If WhizGlobal.ParentTagID = 0 Then
    '        'Edit Mode
    '        If Args.PrimaryKeyValue.ToString <> "" Then
    '            If Args.ControlName.ToUpper = "CUSTOMERID" Or Args.ControlName.ToUpper = "TYPEID" Then
    '                StrSQL = "SELECT Count(*)  FROM tbl_CNF_SLADetails  WHERE SLAID= '" + Args.PrimaryKeyValue.ToString + "'"
    '                If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) <> "0" Then
    '                    Args.Editable = False
    '                End If
    '            End If
    '        End If
    '    End If
    'End Sub



    'Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    'End Sub




    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)
        'For Details Tag
        Dim StrSQL As String
        If WhizGlobal.ParentTagID <> 0 Then
            Select Case Args.ControlName.ToUpper
                Case "PRIORITYID"
                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'StrSQL = "SELECT PriorityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_CNF_CustomerSLA_PriorityTracking " + Args.MasterPrimaryKeyValue.ToString
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
                Case "SEVERITYID"
                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'StrSQL = "SELECT SeverityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_CNF_CustomerSLA_SeverityTracking " + Args.MasterPrimaryKeyValue.ToString
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                    If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                        Cancel = True
                    End If
                Case "COMPLEXITYID"
                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'StrSQL = "SELECT ComplexityTracking  FROM tbl_CNF_CustomerSLA WHERE SLAID=" + Args.MasterPrimaryKeyValue.ToString
                    StrSQL = "usp_sel_tbl_CNF_CustomerSLA_ComplexityTracking " + Args.MasterPrimaryKeyValue.ToString
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
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


