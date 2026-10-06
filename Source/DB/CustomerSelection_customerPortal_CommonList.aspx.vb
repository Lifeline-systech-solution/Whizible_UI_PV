Imports CommonEngines.General.cEventHandlers
Public Class CustomerSelection_customerPortal_CommonList
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CustomerSelection_customerPortal_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
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
    ''added by ninad ' Requirement Tag :WAF3_PB_33 
    'Protected Overrides Sub WhizForm_Init()

    'End Sub
    'addition end by ninad ' Requirement Tag :WAF3_PB_33 
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cCustomerSelection_customerPortal_CommonListSQL(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cCustomerSelection_customerPortal_CommonListGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class cCustomerSelection_customerPortal_CommonListGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private m_ParentTagID As Integer
    Private m_Customer As Integer
    Private m_CustomerName As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "CUSTOMERNAME" Then
            Cancel = True

            'm_ParentTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Integer)
            m_Customer = CType(Args.DataReader("Customer"), Integer)
            m_CustomerName = CType(Args.DataReader("CustomerName"), String)

            Args.StringToBeInserted = "<TD align=left Title='Customer Name'>"

            Args.StringToBeInserted += "<A href=""javascript:CustomerName_OnClick(" + m_Customer.ToString + "," + "'" + m_CustomerName + "'" + " )"">"

            Args.StringToBeInserted += CType(Args.DataReader("CustomerName"), String) + "</A>"
            Args.StringToBeInserted += "</TD>"
        End If
        Dim dr As IDataReader
        Dim strSQL As String
        Dim strDrawTable As String

        ' replace the TD with TD having palette color sequence 
        If UCase(Trim(Args.DataField & "")) = "COLOR" Then
            Cancel = True
            Args.EnableLink = False
            strSQL = "usp_sel_AlertLevel " + CommonFunctions.Data.CheckIsDBNull((Args.DataReader("AlertID")), "0").ToString
            dr = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

            strDrawTable = "<TD><table cellpadding=""1"" cellspacing=""1"" bordercolor=""BLACK"" bgColor=""black"" ><tr>"
            Do While dr.Read()
                strDrawTable += "<td bgcolor=" & dr.Item("Color").ToString & " width=40 height=12 ></td>"
            Loop
            CommonFunctions.Data.DisposeDataReader(dr)
            strDrawTable += "</tr></table></TD>"

            Args.StringToBeInserted = strDrawTable
        End If
    End Sub
    'End Sub
  
    'Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
    '    Return New cRFI_Contract_Details_CommonListDynamicFilters(MyBase.m_objGlobal)
    'End Function
End Class
Public Class cCustomerSelection_customerPortal_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal WhizGlobal As WebPages.Template.IGlobal) As String
        Dim strQuery As String
        Dim m_RoleLevel As String
        Dim drCustomerlist As IDataReader
        Dim strFilterCondition As String
        Dim bitCustomerRecordExists As Boolean = False

        strQuery = "select level from tbl_pm_employee inner join tbl_pm_role on tbl_pm_employee.PostID=tbl_pm_role.RoleID where employeeid=" + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0"), String)
       
        m_RoleLevel = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar(strQuery, True), 0)

        strQuery = "usp_sel_Customer " + CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intUserID"), "0"), String) & "," & 0 & "," + m_RoleLevel

        drCustomerlist = CommonFunctions.Data.GetDataReader(strQuery, True)

        strFilterCondition = " AND Customer in ("
        While drCustomerlist.Read
            bitCustomerRecordExists = True
            strFilterCondition = strFilterCondition + CType(CommonFunctions.Data.CheckIsDBNull(drCustomerlist("customer")), String) + ","
        End While
        CommonFunction.Data.DisposeDataReader(drCustomerlist)
        strFilterCondition = strFilterCondition.Substring(0, strFilterCondition.Length - 1)

        strFilterCondition = strFilterCondition + ")"

        If bitCustomerRecordExists = True Then
            GetPageSpecificFilters = strFilterCondition
        Else
            GetPageSpecificFilters = " Where Customer=0"
        End If
        
    End Function

End Class

