Imports CommonEngines.General.cEventHandlers
Imports CommonFunctions
Imports PbNIT
Imports CommonFunctions.General
Imports CommonFunctions.Data
Imports CommonFunctions.HTMLControls
Imports System.Text
Public Class CRM_RoleStatusMapping_CommonList
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
#End Region
    Dim RoleId As Integer = 0
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CRM_RoleStatusMapping_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here

        If Request.QueryString("flag") = "SAVE" Then
            SaveALL()
        End If

        MyBase.Page_Load(sender, e)
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal global As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

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

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        RoleId = CheckIsNothing(Request.QueryString("RoleId"), 0)
        If RoleId = 0 Then
            RoleId = CheckIsNothing(HttpContext.Current.Request.Form("hdn_RoleId"), 0)
        End If
        If RoleId <> 0 Then
            'Commented and Added by Yogesh J on 15 oct 2015 for hidden field issue
            'CommonFunctions.General.WriteHTML("<intput type='hidden' id='hdn_RoleId' name='hdn_RoleId' value='" + RoleId.ToString() + "'>")
            CommonFunctions.General.WriteHTML("<input type='hidden' id='hdn_RoleId' name='hdn_RoleId' value='" + RoleId.ToString() + "'>")
            'End of addition by Yogesh J on 15 oct 2015 for hidden field issue
        End If


    End Function

    Private Sub SaveALL()

        Dim Roleid_string As String = ""
        Dim CatgoryId As String
        Dim StatusId_String As String
        Dim i As Integer
        Dim j As Integer
        Dim arr_length As Integer
        Dim strSQL As String = ""
        Dim Status_Flag As String = ""
        Dim StatusId_arr() As String
        Roleid_string = CheckIsNothing(Request.QueryString("RoleId"), 0)
        Dim UserId As String = Convert.ToString(Session("intUserId"))
        StatusId_String = CheckIsNothing(HttpContext.Current.Request.Form("chkflag"))

        strSQL = "EXEC usp_ins_tbl_crm_rolestatus " + Roleid_string + "," + UserId + ",'" + StatusId_String + "'"
        InsertOrUpdateData(strSQL, True)

        'PKToken
        CommonFunction.General.WriteHTML("<script>function GetParentObjectReference(frm,ctrl){return window.opener.document.forms[frm].elements[ctrl];}")
        CommonFunction.General.WriteHTML("var obj=GetParentObjectReference('frmCommonPage','PKToken');var token=obj.value;")
        'Dim s As String = "opener.location = '../General/CommonPage.aspx?RoleId_PK=" + Roleid_string + "&PKToken='+token+'&MasterTagId=53&FromWhere=PM';"
        CommonFunction.General.WriteHTML("opener.location = '../General/CommonPage.aspx?RoleId_PK=" & Roleid_string & "&PKToken=' + token + '&MasterTagId=53&FromWhere=PM'; window.close();")
        'CommonFunction.General.WriteHTML("alert(token);")
        'CommonFunction.General.WriteHTML("window.location.href='../CRM/CRM_RoleStatusMapping_CommonList.aspx?MasterTagId=20101&RoleId=" + Roleid_string + "';")
        CommonFunction.General.WriteHTML("</script>")

    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CRM_RoleStatusMapping_CommonList_cMyPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

        Dim strSQL As String
        Dim objDr As IDataReader
        Dim RoleName As String
        Dim Roleid_string As String
        Roleid_string = CheckIsNothing(Request.QueryString("RoleId"), 0)

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "Select RoleDescription From tbl_pm_role where RoleId=" + Roleid_string
        strSQL = "usp_sel_tbl_pm_role_RoleDescription " + Roleid_string
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        RoleName = Data.GetDataScalar(strSQL, True)
        Args.RightPageCaption = "Role : " + RoleName
    End Sub

End Class

Public Class CRM_RoleStatusMapping_CommonList_cMyPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal Whizglobal As WebPages.Template.IGlobal)
        '  Assign the Parameter values to the local variables
        Call MyBase.New(Whizglobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ColumnName.ToUpper = "SELECT" Then
            Cancel = True
            Dim LinkUrl As String
            Dim StatusId As String = Convert.ToString(Args.DataReader("StatusId"))
            If (Convert.ToString(Args.DataReader("RoleId")) = HttpContext.Current.Request.QueryString("RoleId").ToString) Then
                If (Convert.ToString(Args.DataReader("StatusFlag")).ToUpper = "TRUE") Then
                    LinkUrl = "<input type='checkbox' class='clsCheckBox' id='chkflag' value='" + StatusId + "' name='chkflag' checked >"
                Else
                    LinkUrl = "<input type='checkbox' class='clsCheckBox' id='chkflag' value='" + StatusId + "' name='chkflag' >"
                End If
                ' Args.StringToBeInserted = "<td nowrap  align=Left><Input  Type=hidden  name='hdn_StatusId' id='hdn_StatusId' class='clsTextBox' style='width:100px  ; text-align:right' maxlength=10 value='" + StatusId + "'  >" + LinkUrl + "</td>"
                Args.StringToBeInserted = "<td nowrap  align=center>" + LinkUrl + "</td>"
            End If
        End If
    End Sub
End Class
