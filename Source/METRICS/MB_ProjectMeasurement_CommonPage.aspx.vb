Imports Whizible
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Security
Imports CommonEngines.General.cEventHandlers
'Imports Whizible

Public Class cMB_ProjectMeasurement_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(whizGlobal)
    End Sub
End Class

'Public Class cMB_ProjectMeasurement_CommonPageSubTagCLSQL
'    Inherits CommonEngine.CommonList.cSubTagCLSQL
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        'Assign the Parameter values to the local variables
'        Call MyBase.New(Global)
'    End Sub

'    Protected Overrides Sub After_AttachmentDelete(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub After_SaveAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub After_UploadAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_AttachmentDelete(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentDeleteFile, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_GetAttachmentFolderPath(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_SaveAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentSave, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_UploadAttachment(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentUpload, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub Before_ViewAttachment(ByRef Args As CommonEngines.EventHandlers.WAF_Attachment.WAF_AttachmentView, ByVal global As WebPages.Template.IGlobal)

'    End Sub

'    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

'    End Sub
'End Class
'Public Class cMB_ProjectMeasurement_CommonPageCPSQL
'    Inherits CommonEngine.CommonPage.cCPSQL
'    'Constructor
'    Public Sub New(ByVal Global As WebPages.Template.IGlobal)
'        Call MyBase.New(Global)
'    End Sub


'End Class
Public Class cMB_ProjectMeasurement_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal whizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(whizGlobal)
    End Sub


    'Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal whizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCaption(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal whizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterCaption As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotControlCell(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal whizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal whizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        'If Args.TagID = 2502 Then
        If Args.PrimaryKeyValue <> "" Then
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubTagFromCL"), "").ToString <> "" Then
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubTagFromCL"), "") = "1" And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MasterTagID"), "") = 2502 Then
                    Dim strsql As String
                    '  Dim strResult As String
                    Dim drMetric As IDataReader
                    Dim Del, Phase, Mil As Integer
                    Dim IsEnableForPMD As Integer
                    'strsql = "Select IsNull(IsDeliverableLevelMetric,0) as 'IsDeliverableLevelMetric',Isnull(IsMilestoneLevelMetric,0) as 'IsMilestoneLevelMetric',Isnull(IsPhaseLevelMetric,0) as 'IsPhaseLevelMetric'  FROM tbl_MET_MetricMaster WHERE tbl_MET_MetricMaster.MetricID =" + CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                    'Commented and added by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query
                    'strsql = "SELECT ISNULL(IsEnableForPMD,0) AS 'IsEnableForPMD' FROM tbl_MET_MetricMaster WITH (NOLOCK) WHERE tbl_MET_MetricMaster.MetricID = ( SELECT MetricID FROM v_tbl_MET_Metric_Project_BreakUp_Mapping WITH (NOLOCK) WHERE MetricProjectMappingID = " + CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0") + ")"
                    strsql = "usp_sel_tbl_MET_MetricMaster_IsEnableForPMD " + CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                    'End of addition by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query
                    drMetric = CommonFunction.Data.GetDataReader(strsql, True)
                    While drMetric.Read
                        'Del = drMetric("IsDeliverableLevelMetric")
                        'Phase = drMetric("IsPhaseLevelMetric")
                        'Mil = drMetric("IsMilestoneLevelMetric")
                        IsEnableForPMD = drMetric("IsEnableForPMD")
                    End While
                    If Args.ControlName.ToUpper = "CONSIDERFORDELIVERABLE" Then
                        If IsEnableForPMD = 0 Then 'Del = 0 Then
                            Args.Editable = False
                        End If
                    End If
                    If Args.ControlName.ToUpper = "CONSIDERFORPHASE" Then
                        If IsEnableForPMD = 0 Then 'Phase = 0 Then
                            Args.Editable = False
                        End If
                    End If
                    If Args.ControlName.ToUpper = "CONSIDERFORMILESTONE" Then
                        If IsEnableForPMD = 0 Then 'Mil = 0 Then
                            Args.Editable = False
                        End If
                    End If
                End If
            End If
            If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubTagFromCL"), "").ToString <> "" Then
                If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubTagFromCL"), "").ToString = "1" And CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MasterTagID").ToString, "") = "2501" Then

                    Dim strsql As String
                    '  Dim strResult As String
                    Dim drMetric As IDataReader
                    Dim Del, Phase, Mil As Integer
                    Dim CalculationUsing As String
                    'Commented and added by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query
                    strsql = "usp_sel_tbl_MET_Project_Measurements_Calculation " + CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                    '  strsql = "Select IsNull(IsDeliverableLevelMeasurement,0) as 'IsDeliverableLevelMeasurement',Isnull(IsMilestoneLevelMeasurement,0) as 'IsMilestoneLevelMeasurement',Isnull(IsPhaseLevelMeasurement,0) as 'IsPhaseLevelMeasurement'  FROM tbl_MET_Project_Measurements WHERE tbl_MET_Project_Measurements.MeasurementID =" + CommonFunction.General.CheckIsNothing(Args.PrimaryKeyValue, "0")
                    'End of addition by Tejal Deshmukh on 04-Aug-2016 To Remove Inline Query

                    drMetric = CommonFunction.Data.GetDataReader(strsql, True)
                    While drMetric.Read
                        Del = drMetric("IsDeliverableLevelMeasurement")
                        Phase = drMetric("IsPhaseLevelMeasurement")
                        Mil = drMetric("IsMilestoneLevelMeasurement")
                        CalculationUsing = drMetric("CalculationUsing")
                    End While
                    If Args.ControlName.ToUpper = "ISDELIVERABLELEVELMEASUREMENT" Then
                        If Del = 0 Then
                            Args.Editable = False
                        End If
                    End If
                    If Args.ControlName.ToUpper = "ISPHASELEVELMEASUREMENT" Then
                        If Phase = 0 Then
                            Args.Editable = False
                        End If
                    End If
                    If Args.ControlName.ToUpper = "ISMILESTONELEVELMEASUREMENT" Then
                        If Mil = 0 Then
                            Args.Editable = False
                        End If
                    End If

                    If Args.ControlName.ToUpper = "ISEDITABLE" Then
                        If CalculationUsing = "MN" Then
                            Args.Editable = False
                        End If
                    End If

                End If
            End If



        End If
        ' End If
    End Sub

    'Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal whizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal whizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    'End Sub

    'Protected Overrides Function GetCheckDuplicateSQL(ByVal strSQL As String, ByVal objGlobal As WebPages.Template.IGlobal) As String

    'End Function


    'Protected Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal whizGlobal As WebPages.Template.IGlobal)

    'End Sub
End Class


Public Class MB_ProjectMeasurement_CommonPage
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
        MyBase.strFormPage = "MB_ProjectMeasurement_CommonPage.aspx"


        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        '-- commented by purvaj on 23 Apr 2010 new page created for getlatest version
        'Dim strSQLQuery As String
        'If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode1"), "").ToString.ToUpper = "GETLATEST" Then
        '    strSQLQuery = "Exec usp_upd_tbl_MET_MetricMaster_GetLatest " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MetricID"), "").ToString + ",'" + CommonFunctions.General.CheckIsNothing(Session("strUserName")) + "'"
        '    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        '    strSQLQuery = "Exec USP_INS_TBL_PRS_METRICHISTORY_CALCULATION_QUEUE " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MetricID"), "").ToString
        '    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
        'End If
        '---end comment purvaj
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

    Public Overrides Function AfterSave(ByVal whizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        '=====================================================================
        ' Procedure Name        :	AfterSave
        ' Purpose               :	Update database on Save
        ' Description           :	Same as above
        ' Parameters Passed     :	None.
        ' Parameters Affected   :	None.
        ' Returns               :	None
        ' Assumptions           :	None.
        ' Dependencies          :	None.
        ' Author                :	SandeepA
        ' Created               :	October 06, 2005
        ' Revisions             :
        '=====================================================================

        'For Subtag (AfterSave) TagID=1541
        'If whizGlobal.TagID = 1541 Then
        Dim strProjectMeasurementID As String
        Dim strIsEditable As String
        Dim strMeasurementID As String
        Dim strProjectID As String
        Dim strConnectionString As String
        Dim strConnectionID As String
        Dim strSQL As String
        Dim blnUseSQL As Boolean
        Dim strMetricID As String
        blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)
        strProjectMeasurementID = ControlsHashTable.Item("ProjectMeasurementID")
        strIsEditable = ControlsHashTable.Item("IsEditable")
        strMeasurementID = ControlsHashTable.Item("MeasurementID")
        strProjectID = ControlsHashTable.Item("ProjectID")
        strMetricID = PrimaryKey
        If strIsEditable = "" Then
            strIsEditable = "0"
        Else
            If strIsEditable = "on" Then
                strIsEditable = "1"
            End If
        End If

        'Added By SandeepA on 25 Oct,2005 for Try Catch block
        Try
            ''Get the Encrypted connection strin from Web.config
            'strConnectionString = CType(CommonFunctions.General.GetApplicationKeySetting("OtherDatabaseConnectionString"), String)
            ''decrypt the connection string
            'strConnectionString = CStr(CommonFunctions.General.BuildConnectionString(strConnectionString))
            ''End of addition  by SandeepA on 10 Oct,2004

            If IsEditMode = True Then
                'Update table
                strSQL = "UPDATE tbl_MET_Project_Measurements SET MeasurementID=" & strMeasurementID & ", IsEditable=" & strIsEditable & " Where ProjectMeasurementID=" & strProjectMeasurementID & ""
            Else
                'Insert into table
                'strSQL = "If Exists(Select ProjectID from tbl_MET_Project_Measurements where ProjectMeasurementID=" & PrimaryKey & ")(Select ProjectID from tbl_MET_Project_Measurements where ProjectMeasurementID=" & PrimaryKey & ")Else Select 0"
                'strProjectID = CommonFunctions.Data.GetDataScalar(strSQL, blnUseSQL)
                'strSQL = "INSERT INTO tbl_MET_Project_Measurements (ProjectID,MeasurementID,IsEditable) VALUES(" & strProjectID & "," & strMeasurementID & "," & strIsEditable & ")"

                strSQL = "usp_MET_GetDPForMetrics " + strMetricID
            End If
            'CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL, strConnectionString)
            CommonFunctions.Data.InsertOrUpdateData(strSQL, blnUseSQL)

            'Added By SandeepA on 25 Oct,2005 for try catch block.
        Catch ex As Exception
            'Code for managing the error occured
        End Try
        'End of Addition by SandeepA on 25 Oct,2005 for try catch block.

        '  End If


    End Function

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
        Return New cMB_ProjectMeasurement_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cMB_ProjectMeasurement_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitSubTag_PlotGrid(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cPlotGrid
        Return New cMB_ProjectMeasurement_CommonPagePlotGrid(m_objSubTagGlobal)
    End Function

    'Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
    '    Return New cMB_ProjectMeasurement_CommonPageCPSQL(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
    '    Return New cMB_ProjectMeasurement_CommonPageDataManagement(MyBase.m_objGlobal)
    'End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cMB_ProjectMeasurement_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function

    'Public Overrides Function BeforeSave(ByVal Global As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
    'End Function

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)
    '    'If Args.LinkName.ToUpper = "BACK" Then
    '    '    Args.ClientSideFunctionName = "Back_OnClick_PRS"
    '    '    HttpContext.Current.Response.Write("<script> function Back_OnClick_PRS(){Form1.document.location.href = ""../../Source/General/CommonList.aspx?FromWhere=MB&MasterTagId=2139""}</script>")
    '    'End If

    'End Sub
End Class


Public Class cMB_ProjectMeasurement_CommonPagePlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strDrawTextBox As String
        Dim IsLatest As String
        If Args.DataField.ToUpper() = "NAME" Then
            If Args.DataReader("MetricLevel").ToString <> "Corporate" Then
                Cancel = True
                Args.StringToBeInserted = "<td><A href='javascript:OpenNewlyAdded(" + Args.DataReader("MetricID").ToString() + "," + HttpContext.Current.Session("intProjectID").ToString + ")' title='" + Args.DataReader("Name").ToString() + "' class='style4'>" + Args.DataReader("Name").ToString() + "</A></td>"
            End If
        End If

        If Args.DataField.ToUpper() = "GET LATEST/PUBLISH" Then
            If Args.DataReader("MetricLevel").ToString = "Corporate" Then

                Cancel = True
                IsLatest = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_MET_Metric_Project_Mapping  " + Args.DataReader("MetricProjectMappingID").ToString() + ",1", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), String)
                '  Args.IgnoreActualValue = True
                'Args.StringToBeInserted = ""
                If IsLatest = "1" Then
                    Args.StringToBeInserted = "<td align='center'><A href='javascript:GetLatestRevision(" + Args.DataReader("MetricProjectMappingID").ToString() + ")' title='Get Latest Revision'>" + "Get Latest Revision" + "</A></td>"
                Else
                    Args.StringToBeInserted = "<td align='center'><FONT color='RED'>" + "Latest" + "</FONT></td>"
                End If

            Else
                Cancel = True
                IsLatest = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_tbl_MET_Metric_Project_Mapping  " + Args.DataReader("MetricProjectMappingID").ToString() + ",0", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), String)
                'Args.IgnoreActualValue = True
                If IsLatest = "1" Then
                    Args.StringToBeInserted = "<td align='center'><A href='javascript:Publish(" + Args.DataReader("MetricProjectMappingID").ToString() + "," + Args.DataReader("RevisionNo").ToString() + ")' title='Publish'>" + "Publish" + "</A></td>"
                ElseIf IsLatest = "2" Then
                    Args.StringToBeInserted = "<td align='center'><FONT color='RED'>" + "-" + "</FONT></td>"
                Else
                    Args.StringToBeInserted = "<td align='center'><FONT color='RED'>" + "Published" + "</FONT></td>"
                End If


                '  Args.StringToBeInserted = "<td><A href='javascript:Publish(" + Args.DataReader("MetricProjectMappingID").ToString() + ")' title='Publish'>" + "Publish" + "</A></td>"
                'Args.ReplacementValue = "<td><A href='javascript:Publish(" + Args.DataReader("MetricProjectMappingID").ToString() + ")' title='Publish' class='style4'>" + "Publish" + "</A></td>"
            End If
        End If
        'If Args.DataReader("MetricLevel").ToString = "Corporate" Then
        '    If Args.DataField.ToUpper() = "GET LATEST REVISION" Then
        '        Args.IgnoreActualValue = True
        '        Args.ReplacementValue = "<td><A href='javascript:GetLatestRevision(" + Args.DataReader("MetricProjectMappingID").ToString() + ")' title='Get Latest Revision' class='style4'>" + "Get Latest Revision" + "</A></td>"
        '    End If
        'Else

        'End If
      


        'If Args.DataField.ToUpper() = "PUBLISH" Then
        '    Args.DataField = "GET"
        '    Args.
        '    'Args.ColumnName = "Publish"
        'End If

        'If Args.DataReader("IsCorporate").ToString() = "" Then
        '    If Args.DataField.ToUpper() = "GET LATEST REVISION" Then
        '        Args.ColumnName = "Publish"
        '    End If
        'End If

        'If Args.DataField.ToUpper() = "PARAMETERRATING" Then
        '    Args.IgnoreActualValue = True
        '    strDrawTextBox = ""
        '    strDrawTextBox = CommonFunctions.HTMLControls.DrawTextBox("ParameterRating", "ParameterRating", , 80, , 1, "Center", , , , , , , True, True)
        '    strDrawTextBox += CommonFunctions.HTMLControls.DrawTextBox("hdCSIParameterID", "hdCSIParameterID", , 35, , "1", "Right", , , , , True, , True)
        '    Args.ReplacementValue = strDrawTextBox
        'End If

        'If Args.DataField.ToUpper() = "COMMENTS" Then
        '    Args.IgnoreActualValue = True
        '    strDrawTextBox = ""
        '    strDrawTextBox = CommonFunctions.HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , , "Right", , 250, 40, 999, "3", , , , , , , , True, False)
        '    Args.ReplacementValue = strDrawTextBox
        'End If

    End Sub

    Protected Overrides Sub After_GridDataRowTD_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'CommonFunctions.HTMLControls.DrawTextBox("ParameterRating", "ParameterRating", , 80, , strDefaultRating, "Center", , , , , , , True, True)

    End Sub

    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    ' If HttpContext.Current.Request.QueryString("Mode") <> "ADD_NEW" And HttpContext.Current.Request.QueryString("Operation") <> "SAVE" Then

    '    CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 width='99.9%'><TR class='clsTROdd' valign=top><TD width='10%' align='left'>Remarks</TD><TD width='90%' align='left'>")

    '    Dim strQuery As String = ""
    '    Dim strRemarks As String = ""
    '    If HttpContext.Current.Request.QueryString("CSIID_PK") <> "" Then
    '        strQuery = "Select Remarks from tbl_PM_CSI where CSIID=" & HttpContext.Current.Request.QueryString("CSIID_PK").ToString()
    '        strRemarks = CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, True), "").ToString()
    '    End If

    '    CommonFunctions.HTMLControls.DrawTextArea("txtRemarks", "txtRemarks", "Remarks", , , , "Right", , 350, 50, 999, strRemarks, , , , , , , , , False)
    '    '    CommonFunctions.HTMLControls.DrawTextArea("Remarks", "Remarks", , , , , , , 450, 50, 999, , , "width:94%", , , , , , True)
    '    '+ "</TD>")
    '    CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")



    '    'ARgs. = "<TABLE class=clsTable cellpadding=0 cellspacing=0 width='100%'><TR class=clsTREven><TD width='50%' align='right'>"
    '    ' Args.StringToBeInserted += CommonFunctions.HTMLControls.DrawTextArea("Remarks", "Remarks", "Remarks", , , , "Right", , , , , , , , , , , , , , True)
    '    ' Args.StringToBeInserted += "</TD></TR></TABLE>"
    '    '  End If

    'End Sub
End Class


