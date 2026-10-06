Imports CommonEngines.General.cEventHandlers
Public Class InheritWorkflows_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "InheritWorkflows_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSQL As String = ""
        If DeletedIDList <> "" Then
            strSQL = "usp_INS_tbl_IM_ProjectNatureOfDemand_InheritWorkflows "
            strSQL = strSQL + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), 0).ToString
            strSQL = strSQL + ",'" + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("strUserName"), "").ToString
            strSQL = strSQL + "','" + DeletedIDList.ToString + "'"
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            CommonFunction.General.WriteHTML(vbCrLf + "<Script language=javascript>")
            CommonFunction.General.WriteHTML(" window.close();")
            'Commented And Added By Usha Pandit On 19.08.2020 For duplicate workflow inherit issue
            'CommonFunction.General.WriteHTML("window.opener.location.href=window.opener.location.href;" + vbCrLf) 'refreshParent('frmCommonList','DemandTypes_CommonList.aspx','../DM/DemandTypes_CommonList.aspx?FromWhere=PM&MasterTagId=3934'
            CommonFunction.General.WriteHTML(" window.opener.location.href = '../DM/DemandTypes_CommonList.aspx?MasterTagID=3934&FromWhere=PM;' ")
            'End Of Added By Usha Pandit On 19.08.2020 For duplicate workflow inherit issue
            'CommonFunction.General.WriteHTML(" refreshParent('frmCommonList','DemandTypes_CommonList.aspx','DemandTypes_CommonList.aspx?MasterTagID=3934&FromWhere=PM');")
            'CommonFunction.General.WriteHTML(vbCrLf + "   refreshParent('frmCommonList','DemandTypes_CommonList.aspx','DemandTypes_CommonList.aspx?MasterTagID=3934&FromWhere=PM');")
            CommonFunction.General.WriteHTML(vbCrLf + "</Script>")
        End If

        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'Commented By Usha Pandit On 19.08.2020 For duplicate workflow inherit issue
        'Response.Write(vbCrLf + "<Script language=javascript>")
        'Response.Write(vbCrLf + "   refreshParent('frmCommonList','DemandTypes_CommonList.aspx','DemandTypes_CommonList.aspx?MasterTagID=3934&FromWhere=PM');")
        'Response.Write(vbCrLf + "</Script>")
        'End Of Commented By Usha Pandit On 19.08.2020 For duplicate workflow inherit issue
    End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal global As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal global As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal global As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New InheritWorkflows_CommonList_cCLSQL(MyBase.GlobalObject)
    End Function
End Class
Public Class InheritWorkflows_CommonList_cCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        GetPageSpecificFilters = " AND NatureofdemandID NOT IN (SELECT distinct NatureofdemandID FROM tbl_IM_ProjectNatureofdemand WHERE ProjectID = " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), 0).ToString + ")"
        GetPageSpecificFilters += " AND IsActive=1" + vbCrLf
        GetPageSpecificFilters += "	AND NatureofDemandID IN (	SELECT DISTINCT NDM.NatureOfDemandID " + vbCrLf
        GetPageSpecificFilters += "	FROM tbl_IM_NatureofDemand_Mapping NDM " + vbCrLf
        GetPageSpecificFilters += "	INNER JOIN tbl_PM_Project  PR " + vbCrLf


        '---- Commented and Modified By Purvaj on 24 Sept 2008 
        '---- OR Condition Replaced with AND
        'GetPageSpecificFilters += "	ON  NDM.BusinessGroupID=PR.BusinessGroupID" + vbCrLf
        'GetPageSpecificFilters += "	OR NDM.LocationID IS NOT NULL AND ISNULL(NDM.LocationID,0)=ISNULL(PR.LocationID,0)" + vbCrLf
        'GetPageSpecificFilters += "	OR  NDM.DeliveryUnitID IS NOT NULL AND ISNULL(NDM.DeliveryUnitID,0)=ISNULL(PR.ResourcePoolID,0)" + vbCrLf
        'GetPageSpecificFilters += "	OR NDM.DeliveryTeamID IS NOT NULL AND ISNULL(NDM.DeliveryTeamID,0)=ISNULL(PR.ResourceGroupID,0)" + vbCrLf
        'GetPageSpecificFilters += "	OR  NDM.ProjectTypeID IS NOT NULL AND ISNULL(NDM.ProjectTypeID,0)=ISNULL(PR.ProjectTypeID,0)" + vbCrLf
        'GetPageSpecificFilters += "	WHERE" + vbCrLf
        'GetPageSpecificFilters += "	PR.ProjectID= " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), 0).ToString + vbCrLf
        'GetPageSpecificFilters += "	UNION" + vbCrLf
        'GetPageSpecificFilters += "	SELECT	DISTINCT NatureOfDemandID" + vbCrLf
        'GetPageSpecificFilters += "	FROM tbl_IM_NatureofDemand " + vbCrLf
        'GetPageSpecificFilters += "	WHERE" + vbCrLf
        'GetPageSpecificFilters += "	NatureOfDemandID NOT IN (SELECT NatureOfDemandID FROM tbl_IM_NatureofDemand_Mapping)" + vbCrLf
        'GetPageSpecificFilters += "	)" + vbCrLf

        GetPageSpecificFilters += "	ON ( (NDM.BusinessGroupID IS NULL OR  NDM.BusinessGroupID=PR.BusinessGroupID ) " + vbCrLf
        GetPageSpecificFilters += "	AND (NDM.LocationID IS NULL OR ISNULL(NDM.LocationID,0)=ISNULL(PR.LocationID,0))" + vbCrLf
        GetPageSpecificFilters += "	AND (NDM.DeliveryUnitID IS NULL OR ISNULL(NDM.DeliveryUnitID,0)=ISNULL(PR.ResourcePoolID,0))" + vbCrLf
        GetPageSpecificFilters += "	AND (NDM.DeliveryTeamID IS NULL OR ISNULL(NDM.DeliveryTeamID,0)=ISNULL(PR.ResourceGroupID,0)) " + vbCrLf
        GetPageSpecificFilters += "	AND (NDM.ProjectTypeID IS NULL OR ISNULL(NDM.ProjectTypeID,0)=ISNULL(PR.ProjectTypeID,0))" + vbCrLf
        GetPageSpecificFilters += "	)  WHERE " + vbCrLf
        GetPageSpecificFilters += "	PR.ProjectID= " + CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), 0).ToString + vbCrLf
        GetPageSpecificFilters += " AND v_tbl_IM_NatureofDemand_Inherit.AttributeID <> 8035" + vbCrLf
        GetPageSpecificFilters += "	)" + vbCrLf


        '---- End comment and addition


    End Function
End Class

