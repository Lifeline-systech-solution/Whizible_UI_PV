Imports System
Imports CommonEngines.General.cEventHandlers
Public Class RFI_SalesPeriod_CommonList
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

        MyBase.strListPage = "RFI_SalesPeriod_CommonList.aspx"
        'MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_RFI_SalesPeriod_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Public Class c_RFI_SalesPeriod_CommonListPlotGrid
        Inherits CommonEngine.CommonList.cPlotGrid
        'Commented By VidyaJ - IssueID - 11162
        ' Private m_lngTagID As Long
        Protected m_intCreditDays As Integer = 0

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub
        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
            If Args.DataField.ToUpper = "SALESPERIODYEAR" Then
                Cancel = True
                Args.IgnoreActualValue = True
                Dim strSQL As String
                Dim drSalesPeriod As IDataReader
                Dim m_strSalesPeriod As String
                Dim m_strSPStartDate As String = ""
                Dim m_strSPEndDate As String = ""
                Dim m_strInvoiceDate As String = ""
                Dim m_strDueDate As String = ""

                m_strSalesPeriod = Args.DataReader("SalesPeriodYear").ToString + "/" + Args.DataReader("SalesPeriodMonth").ToString

                Args.StringToBeInserted = "<TD align=left Title='Sales Period Year'>"

                If CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), ""), String) = "FA" Then

                    m_intCreditDays = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CreditDays"), "0"), Integer)

                    m_strSPStartDate = CommonFunction.Dates.GetDate(CType(Args.DataReader("SalesPeriodStartDate"), Date)).ToString
                    m_strSPEndDate = CommonFunction.Dates.GetDate(CType(Args.DataReader("SalesPeriodEndDate"), Date)).ToString

                    If DateDiff(DateInterval.Day, CType(Args.DataReader("SalesPeriodEndDate"), Date), Date.Now) > 0 Then
                        m_strInvoiceDate = CommonFunction.Dates.GetDate(CType(Args.DataReader("SalesPeriodEndDate"), Date)).ToString
                    ElseIf DateDiff(DateInterval.Day, CType(Args.DataReader("SalesPeriodStartDate"), Date), Date.Now) < 0 Then
                        m_strInvoiceDate = CommonFunction.Dates.GetDate(CType(Args.DataReader("SalesPeriodStartDate"), Date)).ToString
                    Else
                        m_strInvoiceDate = CommonFunction.Dates.GetDate(Date.Now).ToString()
                    End If

                    m_strDueDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Day, m_intCreditDays, CType(m_strInvoiceDate, Date))).ToString

                    'm_strSPStartDate = CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(CommonFunction.Dates.GetDate(CType(Args.DataReader("SalesPeriodStartDate"), Date)).ToString)
                    'm_strSPEndDate = CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(CommonFunction.Dates.GetDate(CType(Args.DataReader("SalesPeriodEndDate"), Date)).ToString)
                    m_strInvoiceDate = CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(m_strInvoiceDate)
                    m_strDueDate = CommonFunctions.HTMLControls.ConvertDateTo_InputDateFormat(m_strDueDate)
                    Args.StringToBeInserted += "<A href=""JavaScript:SalesPeriodYear_OnClick('" + CType(Args.DataReader("SalesPeriodID"), String) + "','" + m_strSalesPeriod + "','" + m_strSPStartDate + "','" + m_strSPEndDate + "','" + m_strInvoiceDate + "','" + m_strDueDate + "')"">"
                Else
                    Args.StringToBeInserted += "<A href=""JavaScript:SalesPeriodYear_OnClick('" + CType(Args.DataReader("SalesPeriodID"), String) + "','" + m_strSalesPeriod + "')"">"
                End If



                Args.StringToBeInserted += CType(Args.DataReader("SalesPeriodYear"), String) + "</A>"
                Args.StringToBeInserted += "</TD>"
            End If
        End Sub

    End Class

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
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cRFI_SalesPeriod_CommonListSQL(MyBase.m_objGlobal)
    End Function

    Public Class cRFI_SalesPeriod_CommonListSQL
        Inherits CommonEngine.CommonList.cCLSQL

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        Protected Overrides Function GetPageSpecificFilters(ByVal WhizGlobal As WebPages.Template.IGlobal) As String

            GetPageSpecificFilters = " AND ISOpen =1 "


        End Function

    End Class
End Class
