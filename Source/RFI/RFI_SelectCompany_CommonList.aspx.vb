Imports CommonEngines.General.cEventHandlers
Public Class RFI_SelectCompany_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim StrCompanyID As String = ""
        Dim StrCompanyIDs As String
        Dim strCurrencyConverionAlert As String = ""

        If HttpContext.Current.Request.QueryString("Action") = "Save" Then
            Dim strRequiredIDArray As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"))
            StrCompanyID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCompanyName"), "")
            Dim strSQL As String
            strSQL = "usp_Validation_CurrencyConversionRate_Migration " + StrCompanyID + ", '" + strRequiredIDArray + "'"
            strCurrencyConverionAlert = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), String)
            If strCurrencyConverionAlert <> "" Then
                CommonFunction.General.WriteHTML("<script LANGUAGE=javascript>")
                CommonFunction.General.WriteHTML("alert('" + strCurrencyConverionAlert + "');")
                CommonFunction.General.WriteHTML("</script>")
            Else

                strSQL = "usp_INS_tbl_PM_RFIs_Company " + StrCompanyID + ", '" + strRequiredIDArray + "'"

                'strSQL += "," + strSalesPeriodID.Trim + "," + strCompanyID.Trim
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
        End If
        MyBase.strListPage = "RFI_SelectCompany_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region
    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    'Dim strScript As New System.Text.StringBuilder
    '    'strScript.Append("<Script language=javascript>" + vbCrLf)
    '    'strScript.Append("function CompanyNameOnChange() {" + vbCrLf)
    '    'strScript.Append("objfrm.action=""../RFI/RFI_SelectCustomer_CommonList.aspx?"";" + vbCrLf)
    '    'strScript.Append("objfrm.submit();" + vbCrLf)
    '    'strScript.Append("return; }" + vbCrLf)
    '    'strScript.Append("</Script>")
    '    'HttpContext.Current.Response.Write(strScript.ToString)
    'End Function
    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    Dim strScript As New System.Text.StringBuilder
    '    strScript.Append("<Script language=javascript>" + vbCrLf)
    '    strScript.Append("function CompanyNameOnChange(){" + vbCrLf)
    '    strScript.Append("alert('hi');")
    '    'strScript.Append("objfrm.action=""../RFI/RFI_SelectCompany_CommonList.aspx"";" + vbCrLf)
    '    'strScript.Append("objfrm.submit();" + vbCrLf)
    '    strScript.Append("return; }")
    '    HttpContext.Current.Response.Write(strScript.ToString)
    'End Function
    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
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

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

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
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New RFI_SelectCustomer_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New RFI_SelectCustomer_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

        If Args.SectionID = 1 Then
            Dim strCompanyID As String = ""
            strCompanyID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCompanyName"), "")
            Dim strHtml As String
            Dim strHeader As String
            strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
            strHtml += "<tr class=clsTREven><td align=right>Company &nbsp;</td><td align=left>"
            strHtml += CommonFunction.HTMLControls.DrawComboBox("cboCompanyName", "usp_Sel_tbl_PM_CompanyMaster", , strCompanyID, , True, True, , True)
            strHtml += "</td></tr></table>"
            CommonFunction.General.WriteHTML(strHtml)

        End If


    End Sub
    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Select Case Args.SystemLinkType.ToUpper
            Case "ADD_NEW", "DELETE"
                Cancel = True
        End Select
        If Args.LinkName = "Save" Then
            Args.ToBeInsertedInFunction = "var objCompanyName = GetObjectReference('frmCommonPage','cboCompanyName');"
            Args.ToBeInsertedInFunction += "var objChkDelete = GetObjectReference('frmCommonPage','chkDelete',true);"
            Args.ToBeInsertedInFunction += "var icount;"
            Args.ToBeInsertedInFunction += "if (disallowBlank(objCompanyName,'Please select Company',true)) {"
            Args.ToBeInsertedInFunction += "objCompanyName.focus();  return;  }"
            Args.ToBeInsertedInFunction += "for(icount=0;icount<objChkDelete.length;icount++)  {"
            Args.ToBeInsertedInFunction += " if(objChkDelete[icount].checked==true)   break; }"
            Args.ToBeInsertedInFunction += "if(icount==objChkDelete.length) {"
            Args.ToBeInsertedInFunction += "alert('Please select at least one record');  return;  }"
            Args.ToBeInsertedInFunction += "objfrm.action=""../RFI/RFI_SelectCompany_CommonList.aspx?FromWhere=SM&MasterTagID=3817&Action=Save"";"
            Args.ToBeInsertedInFunction += "objfrm.submit(); return;"
        End If

    End Sub
End Class
Public Class RFI_SelectCustomer_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If

    End Sub

End Class

Class RFI_SelectCustomer_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strCompanyName As String
        strCompanyName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("CboCompanyName"), "")
    End Function
End Class





