Imports CommonEngines.General.cEventHandlers

Public Class CustomerSelection_CommonList
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
    'Addition done by SuchitraP on 17-Dec-2007 
    Protected strPTag As String
    'End of addition by SuchitraP on 17-Dec-2007 
    Protected m_OnBehalf As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CustomerSelection_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here

        'Addition done by SuchitraP on 17-Dec-2007 
        strPTag = Request.QueryString("PTagID")
        If strPTag Is Nothing OrElse strPTag = "" Then
            strPTag = HttpContext.Current.Request.Form("hidParentTagID")
        End If

        'End of addition by SuchitraP on 17-Dec-2007

        m_OnBehalf = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("For"), ""), String)
        If m_OnBehalf = "" Then
            m_OnBehalf = Request.Form("hidOnBehalf")
        End If

        MyBase.Page_Load(sender, e)


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
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cCustomerSelection_CommonListGrid(MyBase.m_objGlobal)
    End Function
    'Addition done by SuchitraP on 17-Dec-2007 
    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidParentTagID' id='hidParentTagID' value='" + strPTag + "'>")
        'Added by ShraddhaM for Helpdesk on Behalf of employee and Customer on 15,Oct 2009
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidOnBehalf' value='" + m_OnBehalf + "'>")
        'Ended by ShraddhaM for Helpdesk on Behalf of employee and Customer on 15,Oct 2009
    End Function
    'End of addition done by SuchitraP on 17-Dec-2007 
End Class
Public Class cCustomerSelection_CommonListGrid
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

            Dim strSql As String
            Dim IsloginCreated As Integer = 0

            m_ParentTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("PTagID"), "0"), Integer)
            m_Customer = CType(Args.DataReader("Customer"), Integer)
            m_CustomerName = CType(Args.DataReader("CustomerName"), String)

            'Added by TruptiK on 20,May 2009 
            'To give alert when customer login is not created and in helpdesk anyone is trying to add request on behalf of that customer.
            ''Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            ''strSql = "SELECT 1 From tbl_PM_Login WHERE IsCreatedByCustomer = 0 AND IsActiveLogin = 1 AND customerid =" + m_Customer.ToString
            strSql = "usp_sel_tbl_PM_Login_IsCreatedByCustomer " + m_Customer.ToString
            ''End of Commented and Added by Nilesh g on 5/8/2016 Purpose : Inline Query Removal
            IsloginCreated = CType(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strSql, True), "0"), Integer)
            'Ended by TruptiK

            Args.StringToBeInserted = "<TD align=left Title='Customer Name'>"
            'Modified By VarunA on 6-Jan-2009 IssueID-26287
            'Purpose : To handle the single quote in customer name.
            'Args.StringToBeInserted += "<A href=""javascript:CustomerName_OnClick(" + m_Customer.ToString + "," + "'" + m_CustomerName + "'" + "," + "'" + m_ParentTagID.ToString + "'" + " )"">"
            Args.StringToBeInserted += "<A href=""javascript:CustomerName_OnClick(" + m_Customer.ToString + "," + "'" + Replace(m_CustomerName, "'", "\'") + "'" + "," + "'" + m_ParentTagID.ToString + "'," + IsloginCreated.ToString + " )"">"
            'End By VarunA on 6-Jan-2009 IssueID-26287

            Args.StringToBeInserted += CType(Args.DataReader("CustomerName"), String) + "</A>"
            Args.StringToBeInserted += "</TD>"
        End If
    End Sub
End Class