Imports CommonEngines.General.cEventHandlers
Public Class CRM_ConfigureAccess_CommonList
    Inherits CommonList

    Protected m_strAction As String
    Protected m_strCustomFieldID As String
    Public Shared m_strEntityName As String
    'Added by NitinC on 28 April 2011 for WhizibleSEM 10.0
    Public Shared m_SavedFlag As Integer = 0

    'End - 'Added by NitinC on 28 April 2011 for WhizibleSEM 10.0

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cCRM_ConfigureAccessCLSQL(MyBase.m_objGlobal)
    End Function

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CRM_ConfigureAccess_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        CommonFunctions.HTMLControls.DrawTextBox("TxtHidCustomFieldID", "TxtHidCustomFieldID", value:=m_strCustomFieldID, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("TxtHidEntityName", "TxtHidEntityName", value:=m_strEntityName, IsHidden:=True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = Whiz.CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Added by NitinC on 28 April 2011 for WhizibleSEM 10.0
    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        If Args.LeftPageCaption = "Configure Access" Then
            CommonFunctions.General.WriteHTML("<TABLE id='tblMessagePrint' CellSpacing=0 width='100%' class=clsTable>")
            CommonFunctions.General.WriteHTML("<TR class=clsTRBlank><TD align='Left'>")
            CommonFunctions.General.WriteHTML("<IMG Border=0 style='display:none' SRC='../../Images/TemporaryImages/ajax-loader.gif' title='Loading.....' onclick='' ID='imgLoader' name='imgLoader' height='35' width='40'>")
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunctions.General.WriteHTML("<TR class=clsTRBlank><TD align='Left'><B><font Face='Verdana' color='blue' size='1'>")
            CommonFunctions.General.WriteHTML("<label for=""lblAlertMessage"" id=""lblAlertMessage"" style='display:none'>Loading...</label>")
            CommonFunctions.General.WriteHTML("</FONT></B>")
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunctions.General.WriteHTML("<TR class=clsTRBlank><TD align='Left'><B><font Face='Verdana' color='green' size='1'>")
            CommonFunctions.General.WriteHTML("<label for=""lblSavedMessage"" id=""lblSavedMessage"" style='display:none'>Record Saved Successfully...</label>")
            CommonFunctions.General.WriteHTML("</FONT></B>")
            CommonFunctions.General.WriteHTML("<br></TD></TR></TABLE>")


            'CommonFunctions.General.WriteHTML("<label for=""lblMessage"" style=""color:red"">Record Saved Successfully...</label>")
            'CommonFunctions.General.WriteHTML("<br>")
            'CommonFunctions.HTMLControls.DrawTextBox("TxtHidCustomFieldID", "TxtHidCustomFieldID", value:=m_strCustomFieldID, IsHidden:=True)
        End If
    End Sub
    'End - Added by NitinC on 28 April 2011 for WhizibleSEM 10.0

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
    ''added by ninad ' Requirement Tag :WAF3_PB_33 
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action")).ToString()
        m_strCustomFieldID = CommonFunctions.General.CheckIsNothing(Request.QueryString("CustomFieldID")).ToString()
        m_strEntityName = CommonFunctions.General.CheckIsNothing(Request.QueryString("EntityName")).ToString()

        If m_strCustomFieldID = "" Then
            m_strCustomFieldID = CommonFunctions.General.CheckIsNothing(Request.Form("TxtHidCustomFieldID")).ToString()
        End If
        If m_strEntityName = "" Then
            m_strEntityName = CommonFunctions.General.CheckIsNothing(Request.Form("TxtHidEntityName")).ToString()
        End If

        If m_strAction.ToLower() = "save" Then
            SaveCustomFieldRoleAccess(MyBase.m_objGlobal)
        End If
    End Sub
    ''addition end by ninad ' Requirement Tag :WAF3_PB_33 

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CRM_ConfigureAccess_CommonList_CPlotGrid(MyBase.m_objGlobal)
    End Function

    Private Sub SaveCustomFieldRoleAccess(ByRef WhizGlobal As WebPages.Template.IGlobal)
        '=====================================================================
        ' Proceduere  Name	    :	SaveCustomFieldRoleAccess
        ' Parameters Passed		:	None
        ' Returns				:	None
        ' Parameters Affected	:	None
        ' Purpose				:	To save custom fields role acess for Help-Desk
        ' Description			:	
        ' Assumptions			:	None.
        ' Dependencies			:	None.
        ' Author				:	Amol Changle
        ' Created				:	22 Jul 2009
        ' Revisions				:	
        '=====================================================================

        Dim strSQL As New StringBuilder()
        Dim strFromNewUI As String = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromNewUI")).ToString()
        'first delete all the entries for current project and custom field ID, then insert new 
        strSQL.Append("usp_del_tbl_PM_RoleCustomFieldSecurity ")
        'Added by Chetan M on 13th Jan 2020 for saving the project entity custom field access data
        If strFromNewUI = 1 Then
            If m_strEntityName.ToLower() = "help-desk" Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Added "Sub projects" and "projects" condition by NitinC on 20 April 2011 for WhizibleSEM 10.0 for custom field
                strSQL.Append("0")
            Else
                strSQL.Append(WhizGlobal.ProjectID.ToString)
            End If
        Else
            'End of added by Chetan M on 13th Jan 2020
            If m_strEntityName.ToLower() = "help-desk" Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Added "Sub projects" and "projects" condition by NitinC on 20 April 2011 for WhizibleSEM 10.0 for custom field
                strSQL.Append("0")
            Else
                strSQL.Append(WhizGlobal.ProjectID.ToString)
            End If

        End If
        'If m_strEntityName.ToLower() = "help-desk" Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Added "Sub projects" and "projects" condition by NitinC on 20 April 2011 for WhizibleSEM 10.0 for custom field
        '    strSQL.Append("0")
        'Else
        '    strSQL.Append(WhizGlobal.ProjectID.ToString)
        'End If
        strSQL.Append(",")
        strSQL.Append(m_strCustomFieldID)
        strSQL.Append(",'")
        strSQL.Append(CommonFunctions.General.BuildQueryString(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request("PagingAlphabet"), "-1")))
        strSQL.Append("',N'")
        strSQL.Append(m_strEntityName)
        strSQL.Append("'")
        CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


        'insert new records for the selected custom field for current project and RoleIDs
        Dim strRoles As String() = Split(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete")), ",")
        Dim strRoleID As String
        For Each strRoleID In strRoles
            If strRoleID <> "" Then
                strSQL.Length = 0
                strSQL.Append("usp_ins_tbl_PM_RoleCustomFieldSecurity ")
                'Modified by syamantak Chavan On 05-Oct-2011 for whizible 10.0
                If m_strEntityName.ToLower() = "help-desk" Then
                    strSQL.Append("0")
                Else
                    strSQL.Append(WhizGlobal.ProjectID.ToString())
                End If
                'End Modified by syamantak Chavan On 05-Oct-2011 for whizible 10.0
                strSQL.Append(",")
                strSQL.Append(m_strCustomFieldID.Trim)
                strSQL.Append(",")
                strSQL.Append(strRoleID.Trim)
                strSQL.Append(",N'")
                strSQL.Append(m_strEntityName)
                strSQL.Append("'")
                'Added m_SavedFlag veriable in below line  by NitinC on 28 April 2011 for WhizibleSEM 10.0
                m_SavedFlag = CommonFunctions.Data.InsertOrUpdateData(strSQL.ToString(), CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                'End - 'Added m_SavedFlag veriable in below line  by NitinC on 28 April 2011 for WhizibleSEM 10.0
            End If
        Next
    End Sub


    Private Class CRM_ConfigureAccess_CommonList_CPlotGrid
        Inherits CommonEngine.CommonList.cPlotGrid

        Protected m_strCustomFieldID As String
        Protected m_strEntityName As String
        Private dsRoleSecurity As DataSet

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            MyBase.New(WhizGlobal)

            m_strCustomFieldID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomFieldID")).ToString()
            m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EntityName")).ToString()

            If m_strCustomFieldID = "" Then
                m_strCustomFieldID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TxtHidCustomFieldID")).ToString()
            End If
            If m_strEntityName = "" Then
                m_strEntityName = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TxtHidEntityName")).ToString()
            End If

            Dim strSQL As New StringBuilder()
            strSQL.Append("Usp_SEL_tbl_PM_RoleCustomFieldSecurity_ConfigureAccess ")
            'Commented by syamantak Chavan On 05-Oct-2011 for whizible 10.0
            If m_strEntityName.ToLower() = "help-desk" Then 'Or m_strEntityName.ToLower() = "sub projects" Or m_strEntityName.ToLower() = "projects" Or m_strEntityName.ToLower() = "resource master" Or m_strEntityName.ToLower() = "global project" Then 'Added "Sub projects" and "projects" condition by NitinC on 20 April 2011 for WhizibleSEM 10.0 for custom field
                strSQL.Append("0,")
            Else
                strSQL.Append(WhizGlobal.ProjectID.ToString())
                strSQL.Append(",")
            End If

            strSQL.Append(m_strCustomFieldID)
            strSQL.Append(",NULL,'")
            strSQL.Append(m_strEntityName)
            strSQL.Append("'")

            dsRoleSecurity = CommonFunctions.Data.GetDataSet(strSQL.ToString(), "Tbl_ConfigureAccess", UseSQL:=True)

            strSQL = Nothing


        End Sub

        'Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'End Sub
        'Added by NitinC on 28 April 2011 for WhizibleSEM 10.0
        Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If m_SavedFlag = -1 Then
                CommonFunctions.General.WriteHTML("<script language=""javascript"">")
                CommonFunctions.General.WriteHTML("var objImgLoader = GetObjectReference('frmCommonList','imgLoader');")
                CommonFunctions.General.WriteHTML("objImgLoader.style.display = ""none"";")
                CommonFunctions.General.WriteHTML("var objlblAlertMessage = GetObjectReference('frmCommonList','lblAlertMessage');")
                CommonFunctions.General.WriteHTML("objlblAlertMessage.style.display = ""none"";")
                CommonFunctions.General.WriteHTML("var objlblSavedMessage = GetObjectReference('frmCommonList','lblSavedMessage');")
                CommonFunctions.General.WriteHTML("objlblSavedMessage.style.display = """";")
                CommonFunctions.General.WriteHTML("</script>")
                m_SavedFlag = 0
            End If

        End Sub
        'End of Added by NitinC on 28 April 2011 for WhizibleSEM 10.0
        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If Args.ColumnName.ToLower() = "select" Then
                'If the Access is set for the Project Role, then show the status as SELECTED
                If dsRoleSecurity.Tables(0).Select("RoleID=" + CommonFunctions.Data.CheckIsDBNull(Args.DataReader("RoleID"), "0").ToString()).Length > 0 Then
                    Args.IsSelected = True
                End If
            End If
        End Sub

    End Class

End Class
'Added By Syamantak Chavan On 05-Oct-2011 for Whizible 10.0 for Custom Fields
Public Class cCRM_ConfigureAccessCLSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ''Commented by NitinC 19 March 2012 for WhizibleSEM 11.0 [Issue Fix 60632]
        ''Purpose : No need to set filter for entities like Sub Project,project and resource master
        'Dim strCsvRoleIDs As String
        'Dim strSQL As String

        'strSQL = "Usp_SEL_tbl_pm_projectemployeerole_RoleID " & objGlobal.ProjectID.ToString()

        'strCsvRoleIDs = CType(CommonFunctions.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        'Dim objAccessRights As WebPages.Security.cAccessRights
        'objAccessRights = New WebPages.Security.cAccessRights(objGlobal)
        'If CRM_ConfigureAccess_CommonList.m_strEntityName.ToUpper <> "TASK" And CRM_ConfigureAccess_CommonList.m_strEntityName.ToUpper <> "HELP-DESK" Then
        '    GetPageSpecificFilters &= "  AND RoleID IN (23," + strCsvRoleIDs + ")"
        'End If
        ''End of Commented by NitinC 19 March 2012 for WhizibleSEM 11.0 [Issue Fix 60632]
    End Function
End Class
'End Added By Syamantak Chavan On 05-Oct-2011 for Whizible 10.0 for Custom Fields
