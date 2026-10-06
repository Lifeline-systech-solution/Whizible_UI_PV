Imports CommonEngines.General.cEventHandlers

Public Class HelpDeskSLADefination_CommonList
    Inherits CommonList

    Private objCLSQL As HelpDeskSLADefination_CommonListCLSQL

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

        'Added By VarunA on 25-May-2007 Service Level Aggrement
        Dim strCustID As String = ""
        Dim strDeptID As String = ""
        Dim strReqTypeID As String = ""
        Dim strSubReqTypeID As String = ""
        Dim strSLAID As String = ""
        Dim m_PKToken As String = ""
        Dim strSql As String = ""
        Dim strSessionUserName As String

        If HttpContext.Current.Request.QueryString("Action") = "Apply" Then
            strCustID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CustomerID"), "")
            strDeptID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("DepartmentID"), "")
            strReqTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestTypeID"), "")
            strSubReqTypeID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("SubRequestTypeID"), "")
            If strDeptID.ToString() <> "" And strReqTypeID.ToString() <> "" And strSubReqTypeID.ToString() <> "" Then
                If strCustID = "" Then
                    strCustID = "NULL"
                End If

                strSessionUserName = CType(Session("strUserName"), String).Replace("'", "''")
                strSql = "usp_Ins_tbl_CNF_HelpDeskSLA " + strCustID + "," + strDeptID + "," + strReqTypeID + "," + strSubReqTypeID + ",'" + strSessionUserName + "'"
                strSLAID = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)), String)
            End If
            m_PKToken = CommonFunctions.Security.Token.GetToken(CType(strSLAID, String) + CType(Session("intUserID"), String) + "0" + "3625")
            System.Web.HttpContext.Current.Response.Redirect("../CRM/HelpDeskSLADefination_CommonPage.aspx?SLAID_PK=" + strSLAID + "&PKToken=" + m_PKToken + "&MasterTagID=3625&FromWhere=SM&PagingAlphabet=&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1")
        End If
        'End By VarunA on 25-May-2007

        MyBase.strListPage = "HelpDeskSLADefination_CommonList.aspx"
        MyBase.strFormPage = "HelpDeskSLADefination_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cMYPlotGrid1(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        objCLSQL = New HelpDeskSLADefination_CommonListCLSQL(MyBase.m_objGlobal)
        Return objCLSQL
    End Function

    Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        ''Added By VarunA on 29-May-2007 For Service Level Aggrement
        ''Purpose : To have two dropdown for type and customer
        If Args.SectionID = 1 Then
            Dim strCustomerName As String = ""
            Dim strType As String = ""
            Dim strDepartmentName As String = ""
            Dim strRequestType As String = ""
            Dim strSubRequestType As String = ""
            strCustomerName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCustomerName"), "")
            strType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboType"), "")
            strDepartmentName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtDepartmentName"), "")
            strRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRequestType"), "")
            strSubRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubRequestType"), "")

            If strCustomerName = "" Then
                strCustomerName = objCLSQL.m_strCustNameFilter
            End If

            If strType = "" Then
                strType = objCLSQL.m_strTypeFilter
            End If

            If strDepartmentName = "" Then
                strDepartmentName = objCLSQL.m_strDepartmentFilter
            End If

            If strRequestType = "" Then
                strRequestType = objCLSQL.m_strRequestTypeFilter
            End If

            If strSubRequestType = "" Then
                strSubRequestType = objCLSQL.m_strSubRequestTypeFilter
            End If


            Dim strHtml As String
            strHtml = "<table class=clsTable CellSpacing=0 width=100%>"
            strHtml += "<tr class=clsTREven><td align=right>Type &nbsp;</td><td align=left>"
            strHtml += CommonFunction.HTMLControls.DrawComboBox("cboType", "usp_Sel_SLAType ", 90, strType, "onChange='Type_OnChange()'", False, True)
            strHtml += "</td>"
            ''Modified by VarunA on 1-June-2007 For having textbox depending on Type
            ''Purpose : To have textboxes for RequestType, SubRequestType, Department and Customer for filter.
            If strType = "Internal" Then
                strHtml += "<td align=right title='Starts with'>Department &nbsp;</td><td align=left>"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                strHtml += CommonFunction.HTMLControls.DrawTextBox("txtDepartmentName", "txtDepartmentName", "clsTextBox", 200, 20, strDepartmentName, "left", , False, False, , False, "Title='Starts with' onkeypress=txtDepartmentName_OnKeyPress(event)", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            Else
                strHtml += "<td align=right title='Starts with'>Customer &nbsp;</td><td align=left>"
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                strHtml += CommonFunction.HTMLControls.DrawTextBox("txtCustomerName", "txtCustomerName", "clsTextBox", 200, 20, strCustomerName, "left", , False, False, , False, "Title='Starts with' onkeypress=txtCustomerName_OnKeyPress(event)", True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
            End If
            strHtml += "</td></tr>"
            strHtml += "<tr class=clsTREven><td align=right title='Starts with'>Request Type &nbsp;</td><td align=left>"
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strHtml += CommonFunction.HTMLControls.DrawTextBox("txtRequestType", "txtRequestType", "clsTextBox", 200, 20, strRequestType, "left", , False, False, , False, "Title='Starts with' onkeypress=txtRequestType_OnKeyPress(event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            strHtml += "</td>"
            strHtml += "<td align=right title='Starts with'>Sub Request Type &nbsp;</td><td align=left>"
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            strHtml += CommonFunction.HTMLControls.DrawTextBox("txtSubRequestType", "txtSubRequestType", "clsTextBox", 200, 20, strSubRequestType, "left", , False, False, , False, "Title='Starts with' onkeypress=txtSubRequestType_OnKeyPress(event)", True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
            strHtml += "</td></tr></table><br>"
            ''End by VarunA on 1-June-2007

            CommonFunction.General.WriteHTML(strHtml)
        End If

        ''End By VarunA on 29-May-2007

    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ''Added by VarunA on 30-May-2007 For Service Level Aggrement

        Dim strScript As New System.Text.StringBuilder
        strScript.Append("<Script language=javascript>" + vbCrLf)
        strScript.Append("function Type_OnChange() {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/HelpDeskSLADefination_CommonList.aspx?PagingNumber=1""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }" + vbCrLf)
        ''Comment By VarunA on 1-June-2007 As Customer is taken as textbox
        'strScript.Append("function CustName_OnChange() {" + vbCrLf)
        'strScript.Append("objfrm.action=""../CRM/HelpDeskSLADefination_CommonList.aspx?""; " + vbCrLf)
        'strScript.Append("objfrm.submit();" + vbCrLf)
        'strScript.Append("return; }" + vbCrLf)
        ''End by VarunA on 1-June-2007

        'Added By VarunA on 1-June-2007 taking customer and department as textbox
        strScript.Append("function txtCustomerName_OnKeyPress(e) {" + vbCrLf)
        strScript.Append("var code; " + vbCrLf)
        strScript.Append("if (e.keyCode)" + vbCrLf)
        strScript.Append("code = e.keyCode;" + vbCrLf)
        strScript.Append("else" + vbCrLf)
        strScript.Append("if (e.which)" + vbCrLf)
        strScript.Append("code = e.which; " + vbCrLf)
        strScript.Append("if(code==13) {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/HelpDeskSLADefination_CommonList.aspx?PagingNumber=1""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }}" + vbCrLf)
        strScript.Append("function txtDepartmentName_OnKeyPress(e) {" + vbCrLf)
        strScript.Append("var code; " + vbCrLf)
        strScript.Append("if (e.keyCode)" + vbCrLf)
        strScript.Append("code = e.keyCode;" + vbCrLf)
        strScript.Append("else" + vbCrLf)
        strScript.Append("if (e.which)" + vbCrLf)
        strScript.Append("code = e.which; " + vbCrLf)
        strScript.Append("if(code==13) {" + vbCrLf)
        strScript.Append("objfrm.action=""../CRM/HelpDeskSLADefination_CommonList.aspx?PagingNumber=1""; " + vbCrLf)
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
        strScript.Append("objfrm.action=""../CRM/HelpDeskSLADefination_CommonList.aspx?PagingNumber=1""; " + vbCrLf)
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
        strScript.Append("objfrm.action=""../CRM/HelpDeskSLADefination_CommonList.aspx?PagingNumber=1""; " + vbCrLf)
        strScript.Append("objfrm.submit();" + vbCrLf)
        strScript.Append("return; }}" + vbCrLf)
        'End By VarunA on 1-June-2007
        strScript.Append("</Script>" + vbCrLf)
        HttpContext.Current.Response.Write(strScript.ToString)

        ''End By VarunA on 30-May-2007
    End Function
End Class

Public Class cMYPlotGrid1
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim blnAddRight As Boolean
    Dim blnEditRight As Boolean
    Dim objAccess As New WebPage.Templates.AccessRights
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        'Added By VarunA on 25-June-2007 Whizible Regression Project Issue-14006
        'Purpose : To check the access rights
        objAccess.GetAccess(WhizGlobal)
        blnAddRight = objAccess.Add
        blnEditRight = objAccess.Edit
        'End By VarunA on 25-June-2007 Issue-14006
    End Sub
    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added By VarunA on 25-May-2007 Service Level Aggrement
        If Args.ColumnName = "SLA" Then
            Dim strSLA As String = ""
            strSLA = Args.DataReader("SLA_Grid").ToString
            If (strSLA = "Apply") Then
                If blnAddRight = True Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD align='Left'><A href=../CRM/HelpDeskSLADefination_CommonList.aspx?Action=Apply&CustomerID=" + Args.DataReader("CustomerID").ToString + "&DepartmentID=" + Args.DataReader("DepartmentID").ToString + "&RequestTypeID=" + Args.DataReader("RequestTypeID").ToString + "&SubRequestTypeID=" + Args.DataReader("SubRequestTypeID").ToString + ">Apply</A></TD>"
                Else
                    Cancel = True
                    Args.StringToBeInserted = "<TD>-</TD>"
                End If

            End If
            If strSLA = "Edit" Then
                If blnEditRight = False Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD>-</TD>"
                End If
            End If
        End If
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
        End If
        'End By VarunA on 25-May-2007
    End Sub
    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Added By VarunA on 25-May-2007 For Service Level Aggrement
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
        End If
        ''End By VarunA on 25-May-2007
    End Sub
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
End Class


Class HelpDeskSLADefination_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Public m_strCustNameFilter As String = ""
    Public m_strTypeFilter As String = ""
    Public m_strDepartmentFilter As String = ""
    Public m_strRequestTypeFilter As String = ""
    Public m_strSubRequestTypeFilter As String = ""

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        ''Added By VarunA on 29-May-2007 For Service Level Aggrement
        Dim strCustomerName As String
        Dim strType As String = ""
        Dim strCust As String = "Customer"
        Dim strDepartmentName As String = ""
        Dim strRequestType As String = ""
        Dim strSubRequestType As String = ""
        Dim drFilter As IDataReader
        Dim intUserID As String = CStr(HttpContext.Current.Session("intUserID"))
        Dim strLoginType As String = CStr(HttpContext.Current.Session("LoginType"))
        Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
        Dim strSql As String = ""


        strType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboType"), "")
        strCustomerName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCustomerName"), "")
        strDepartmentName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtDepartmentName"), "")
        strRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtRequestType"), "")
        strSubRequestType = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtSubRequestType"), "")

        ''Added by VarunA on 5-June-2007 For whizile Regression Project, Issue-13478
        ''Purpose : To persists the value of the filters
        If HttpContext.Current.Request.Form("cboType") Is Nothing Then
            drFilter = CommonFunctions.Data.GetDataReader("SELECT ControlName, FixedValue FROM tbl_UI_EmployeeFilterSettings_FieldDetails WHERE TagID=3625 AND UserID=" + intUserID, blnUseSQL)
            While drFilter.Read
                Select Case drFilter(0).ToString
                    Case "Type"
                        m_strTypeFilter = drFilter(1).ToString
                        strType = drFilter(1).ToString
                    Case "Department"
                        m_strDepartmentFilter = drFilter(1).ToString
                        strDepartmentName = drFilter(1).ToString
                    Case "Customer"
                        m_strCustNameFilter = drFilter(1).ToString
                        strCustomerName = drFilter(1).ToString
                    Case "RequestType"
                        m_strRequestTypeFilter = drFilter(1).ToString
                        strRequestType = drFilter(1).ToString
                    Case "SubRequestType"
                        m_strSubRequestTypeFilter = drFilter(1).ToString
                        strSubRequestType = drFilter(1).ToString
                End Select
            End While
            CommonFunction.Data.DisposeDataReader(drFilter)
        Else
            strSql = "usp_InsUpd_HelpDeskSLADefinition_FilterSettings "
            If strType = "" Then
                strSql += "NULL,"
            Else
                strSql += "'" + strType + "',"
            End If
            If strCustomerName = "" Then
                strSql += "NULL,"
            Else
                strSql += "'" + strCustomerName + "',"
            End If
            If strDepartmentName = "" Then
                strSql += "NULL,"
            Else
                strSql += "'" + strDepartmentName + "',"
            End If
            If strRequestType = "" Then
                strSql += "NULL,"
            Else
                strSql += "'" + strRequestType + "',"
            End If
            If strSubRequestType = "" Then
                strSql += "NULL,"
            Else
                strSql += "'" + strSubRequestType + "',"
            End If
            strSql += intUserID + ","
            strSql += "'" + strLoginType + "'"
            CommonFunction.Data.InsertOrUpdateData(strSql, blnUseSQL)
        End If
        ''End By VarunA on 5-June-2007

        If Not strType Is Nothing And strType <> "" Then
            GetPageSpecificFilters += " AND (SLATYPE_Grid='" + strType + "')"

        Else
            GetPageSpecificFilters += " AND (SLATYPE_Grid='" + strCust + "')"
        End If

        If strType <> "Internal" Then
            If Not strCustomerName Is Nothing And strCustomerName <> "" Then
                GetPageSpecificFilters += "AND (CustomerName Like '" + strCustomerName + "%')"
            End If
        End If

        If strType <> "Customer" Then
            If Not strDepartmentName Is Nothing And strDepartmentName <> "" Then
                GetPageSpecificFilters += "AND (Department Like '" + strDepartmentName + "%')"
            End If
        End If

        If Not strRequestType Is Nothing And strRequestType <> "" Then
            GetPageSpecificFilters += "AND (RequestType Like '" + strRequestType + "%')"
        End If

        If Not strSubRequestType Is Nothing And strSubRequestType <> "" Then
            GetPageSpecificFilters += "AND (SubRequestType Like '" + strSubRequestType + "%')"
        End If

        ''End By VarunA on 29-May-2007

    End Function
End Class

