Imports CommonEngines.General.cEventHandlers
Public Class CRM_AddCustomerSLA_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

        'Added By Varun on 28-May-2007 For Service Level Agreement
        Dim strCustID As String = ""
        Dim strDeptID As String = ""
        Dim strReqTypeID As String = ""
        Dim strSubReqTypeID As String = ""
        Dim strSLAMasterID As String = ""
        Dim strSLAID As String = ""
        Dim strSql As String = ""
        Dim strSLAIDList As String = ""
        Dim strActualValue As String()
        Dim icount As Integer
        If HttpContext.Current.Request.QueryString("Action") = "Apply" Then
            strSLAIDList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "")
            Dim strArray As String() = strSLAIDList.Split(","c)
            Dim strScript As String = ""
            strSLAMasterID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSLAName"), "")
            Dim strSessionUserName As String
            strSessionUserName = CType(Session("strUserName"), String).Replace("'", "''")

            For icount = 0 To strArray.Length() - 1
                strActualValue = strArray(icount).Split("|"c)
                strCustID = strActualValue(0)
                strDeptID = strActualValue(1)
                strReqTypeID = strActualValue(2)
                strSubReqTypeID = strActualValue(3)
                If strCustID.ToString() <> "" And strDeptID.ToString() <> "" And strReqTypeID.ToString() <> "" And strSubReqTypeID.ToString() <> "" Then
                    strSql = "usp_Ins_tbl_CNF_ApplyCustomerSLA " + strCustID + "," + strDeptID + "," + strReqTypeID + "," + strSubReqTypeID + "," + strSLAMasterID + ",'" + strSessionUserName + "'"
                    strSLAID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)), String)
                End If
            Next
            'Added by VarunA on 4-June-2007 For Whizible Regression Project Issue-13474
            'Purpose : To refresh the parent page while apply customer SLA
            strScript = vbCrLf + "<Script language=javascript>"
            strScript += vbCrLf + "window.opener.document.forms[0].action='../CRM/HelpDeskSLADefination_CommonList.aspx?FromWhere=SM&MasterTagId=3625';"
            strScript += vbCrLf + "window.opener.document.forms[0].submit();"
            strScript += vbCrLf + "</Script>"
            CommonFunction.General.WriteHTML(strScript)
            'End by VarunA on 4-June-2007
        End If

        'End by VarunA on 28-May-2007

        MyBase.strListPage = "CRM_AddCustomerSLA_CommonList.aspx"
        MyBase.strFormPage = "CRM_AddCustomerSLA_CommonList.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        ''Added by VarunA on 30-May-2007 For Service Level Aggrement
        Dim strScript As New System.Text.StringBuilder
        strScript.Append("<Script language=javascript>" + vbCrLf)
        strScript.Append("function SLANameOnChange() {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/CRM_AddCustomerSLA_CommonList.aspx?"";" + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }" + vbCrLf)
        strScript.Append("function txtCustomerName_OnKeyPress(e) {" + vbCrLf)
        strScript.Append("var code; " + vbCrLf)
        strScript.Append("if (e.keyCode)" + vbCrLf)
        strScript.Append("code = e.keyCode;" + vbCrLf)
        strScript.Append("else" + vbCrLf)
        strScript.Append("if (e.which)" + vbCrLf)
        strScript.Append("code = e.which; " + vbCrLf)
        strScript.Append("if(code==13) {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/CRM_AddCustomerSLA_CommonList.aspx?""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }}" + vbCrLf)
        strScript.Append("function txtRequestType_OnKeyPress(e) {" + vbCrLf)
        strScript.Append("var code; " + vbCrLf)
        strScript.Append("if (e.keyCode)" + vbCrLf)
        strScript.Append("code = e.keyCode;" + vbCrLf)
        strScript.Append("else" + vbCrLf)
        strScript.Append("if (e.which)" + vbCrLf)
        strScript.Append("code = e.which; " + vbCrLf)
        strScript.Append("if(code==13) {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/CRM_AddCustomerSLA_CommonList.aspx?""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }}" + vbCrLf)
        strScript.Append("function txtSubRequestType_OnKeyPress(e) {" + vbCrLf)
        strScript.Append("var code; " + vbCrLf)
        strScript.Append("if (e.keyCode)" + vbCrLf)
        strScript.Append("code = e.keyCode;" + vbCrLf)
        strScript.Append("else" + vbCrLf)
        strScript.Append("if (e.which)" + vbCrLf)
        strScript.Append("code = e.which; " + vbCrLf)
        strScript.Append("if(code==13) {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/CRM_AddCustomerSLA_CommonList.aspx?""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }}" + vbCrLf)
        strScript.Append("</Script>" + vbCrLf)
        HttpContext.Current.Response.Write(strScript.ToString)
        ''End By VarunA on 30-May-2007

    End Function

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

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CRM_AddCustomerSLA_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New CRM_AddCustomerSLA_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        ''Added By VarunA on 23-May-2007 For Service Level Aggrement
        If Args.SectionID = 1 Then
            Dim strCustomerName As String = ""
            Dim strSLANumber As String = ""
            Dim strRequestType As String = ""
            Dim strSubRequestType As String = ""
            Dim strSLAName As String = ""

            strSLANumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSLAName"), "")
            strCustomerName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCustomerName"), "")
            strRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRequestType"), "")
            strSubRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubRequestType"), "")

            Dim strHtml As String
            Dim strHeader As String
            strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
            strHtml += "<tr class=clsTREven><td align=right>SLA &nbsp;</td><td align=left>"
            strHtml += CommonFunction.HTMLControls.DrawComboBox("cboSLAName", "usp_Sel_tbl_CNF_SLAMaster ", 150, strSLANumber, "onChange='SLANameOnChange()'", True, True)
            strHtml += "</td><td align=left colspan=4>"
            ''Added By VarunA on 1-June-2007 For having label for which customer SLA is not applied
            If strSLANumber <> "" Then
                strSLAName = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select SLADetail from tbl_CNF_SLAMaster WHERE SLADetailID=" & strSLANumber, MyBase.UseSQL), ""))
                strHtml += "For Customer displayed below SLA "
                strHtml += strSLAName + " is not applied"
            End If
            strHtml += "</td></tr>"

            ''End By VarunA on 1-June-2007

            strHtml += "<tr class=clsTREven>"
            strHtml += "<td align=right title='Starts with'>Customer &nbsp;</td><td align=left>"
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strHtml += CommonFunction.HTMLControls.DrawTextBox("txtCustomerName", "txtCustomerName", "clsTextBox", 150, 20, strCustomerName, "left", , False, False, , False, "Title='Starts with' onkeypress=txtCustomerName_OnKeyPress(event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            strHtml += "</td>"
            strHtml += "<td align=right title='Starts with'>Request Type &nbsp;</td><td align=left>"

            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strHtml += CommonFunction.HTMLControls.DrawTextBox("txtRequestType", "txtRequestType", "clsTextBox", 150, 20, strRequestType, "left", , False, False, , False, "Title='Starts with' onkeypress=txtRequestType_OnKeyPress(event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            strHtml += "</td>"
            strHtml += "<td align=right title='Starts with'>Sub Request Type &nbsp;</td><td align=left>"
            'Commented and added by Yogesh J for HTML encoding Date:05/10/15
            strHtml += CommonFunction.HTMLControls.DrawTextBox("txtSubRequestType", "txtSubRequestType", "clsTextBox", 150, 20, strSubRequestType, "left", , False, False, , False, "Title='Starts with' onkeypress=txtSubRequestType_OnKeyPress(event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:05/10/15
            strHtml += "</td></tr></table><br>"
            CommonFunction.General.WriteHTML(strHtml)

        End If

        ''End By VarunA on 23-May-2007
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added by VarunA on 4-June-2007 For Service Level Aggrement
        'Purpose : To make the parent page refresh Issue-13474 Whizible Regression Project
        If Args.LinkName = "Apply SLA" Then
            Args.ToBeInsertedInFunction = "var objSLA = GetObjectReference('frmCommonPage','cboSLAName');"
            Args.ToBeInsertedInFunction += "var objChkDelete = GetObjectReference('frmCommonPage','chkDelete',true);"
            Args.ToBeInsertedInFunction += "var icount;"
            Args.ToBeInsertedInFunction += "if (disallowBlank(objSLA,'Please select SLA',true)) {"
            Args.ToBeInsertedInFunction += "objSLA.focus();  return;  }"
            Args.ToBeInsertedInFunction += "for(icount=0;icount<objChkDelete.length;icount++)  {"
            Args.ToBeInsertedInFunction += " if(objChkDelete[icount].checked==true)   break; }"
            Args.ToBeInsertedInFunction += "if(icount==objChkDelete.length) {"
            Args.ToBeInsertedInFunction += "alert('Please select one record to apply SLA');  return;  }"
            Args.ToBeInsertedInFunction += "objfrm.action=""../CRM/CRM_AddCustomerSLA_CommonList.aspx?FromWhere=SM&MasterTagID=3744&Action=Apply"";"
            Args.ToBeInsertedInFunction += "objfrm.submit();  return;"
        End If
        'End by VarunA on 4-June-2007
    End Sub
End Class


Public Class CRM_AddCustomerSLA_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Added By VarunA on 23-May-2007 For Service Level Aggrement
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If
        ''End By VarunA on 23-May-2007
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Added By VarunA on 28-May-2007 For Service Level Aggrement
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
            'Commented and added by Chetan M on 4 Jan 2021 for Selecting one checkbox at a time
            'Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete' class='clsCheckBox' value=" + Args.DataReader("Customer").ToString + "|" + Args.DataReader("DepartmentID").ToString + "|" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "></td>"
            Args.StringToBeInserted = "<td  align='center'><Input type='checkbox' name='chkDelete' id='chkDelete" + Args.DataReader("Customer").ToString + "|" + Args.DataReader("DepartmentID").ToString + "|" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "' class='clsCheckBox' value=" + Args.DataReader("Customer").ToString + "|" + Args.DataReader("DepartmentID").ToString + "|" + Args.DataReader("RequestTypeID").ToString + "|" + Args.DataReader("SubRequestTypeID").ToString + "></td>"
            'End of Commented and added by Chetan M on 4 Jan 2021 for Selecting one checkbox at a time
        End If
        ''End By VarunA on 23-May-2007
    End Sub

    'Protected Overrides Sub Before_GridColumnHeaderTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub
End Class


Class CRM_AddCustomerSLA_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ''Added By VarunA on 24-May-2007 For Service Level Aggrement
        Dim strCustomerName As String
        Dim strSLANumber As String = ""
        Dim strRequestType As String = ""
        Dim strSubRequestType As String = ""

        Dim strMode As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "")
        strSLANumber = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboSLAName"), "")
        strCustomerName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCustomerName"), "")
        strRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRequestType"), "")
        strSubRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubRequestType"), "")

        If strMode = "First" Then
            'Commented By Usha Pandit On 30.12.2020 For showing list of all customers when SLA is not selected
            'If strSLANumber = "" Then
            '    GetPageSpecificFilters += "AND ( 1 =  2 )"
            'End If
            'End Of Commented By Usha Pandit On 30.12.2020 For showing list of all customers when SLA is not selected
        End If

        If Not strSLANumber Is Nothing And strSLANumber <> "" Then
            GetPageSpecificFilters += " AND (SLADetailID =" + strSLANumber + " )"
        Else
            'Commented By Usha Pandit On 30.12.2020 For showing list of all customers when SLA is not selected
            'GetPageSpecificFilters += "AND ( 1 =  2 )"
            'End Of Commented By Usha Pandit On 30.12.2020 For showing list of all customers when SLA is not selected
        End If


        If Not strCustomerName Is Nothing And strCustomerName <> "" Then
            GetPageSpecificFilters += "AND (CustomerName Like '" + strCustomerName + "%')"
        End If

        If Not strRequestType Is Nothing And strRequestType <> "" Then
            GetPageSpecificFilters += "AND (RequestType Like '" + strRequestType + "%')"
        End If

        If Not strSubRequestType Is Nothing And strSubRequestType <> "" Then
            GetPageSpecificFilters += "AND (SubRequestType Like '" + strSubRequestType + "%')"
        End If

        ''End By VarunA on 24-May-2007

    End Function
End Class