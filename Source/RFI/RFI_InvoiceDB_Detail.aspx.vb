Public Class RFI_InvoiceDB_Detail
    Inherits WebPages.Template.WhizTemplate

    Protected m_lngSalesPeriodID As Long = 0
    Protected m_lngCompanyId As Long = 0
    Protected m_strBusinessUnitID As String = "'"
    Protected m_strOUID As String = ""
    Protected m_lngCompanyBaseCurrencyID As Long = 0
    Protected m_lngCustomerID As Long = 0
    Protected m_intType As Integer
    Protected m_strQ As String = ""
    Protected drDB As IDataReader
    Protected m_sCompanyBaseCurrencyCode As String = ""

    Private m_blnUseSQL As Boolean
    Private m_strCurrencySymbol As String = ""
    Private m_strMode As String = ""
    Protected strProjectFilter As String = ""

    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objInfoGrid As WebPages.Template.GenericGrid
    Private WithEvents m_objInvoiceGrid As WebPages.Template.GenericGrid

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
        ' Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
    End Sub

#End Region


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Call Initialize()
    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Page Name             : Intialize()
        ' Purpose               : Intializes the variables for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Webpage
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("SalesPeriodID"), "") = "" Then
            m_lngSalesPeriodID = 0
        Else
            m_lngSalesPeriodID = CType(Request.QueryString("SalesPeriodID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("CompanyID"), "") = "" Then
            m_lngCompanyId = 0
        Else
            m_lngCompanyId = CType(Request.QueryString("CompanyID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("BUID"), "0") = "0" Then
            m_strBusinessUnitID = " NULL"
        Else
            m_strBusinessUnitID = CType(Request.QueryString("BUID"), String)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("OUID"), "0") = "0" Then
            m_strOUID = " NULL"
        Else
            m_strOUID = CType(Request.QueryString("OUID"), String)
        End If

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Type"), "") = "" Then
            m_intType = 0
        Else
            m_intType = CType(Request.QueryString("Type"), Integer)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("CustomerID"), "") = "" Then
            m_lngCustomerID = 0
        Else
            m_lngCustomerID = CType(Request.QueryString("CustomerID"), Long)
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("Mode"), "") = "" Then
            m_strMode = "CUSTOMER"
        Else
            m_strMode = Request.QueryString("Mode").ToString
        End If
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("CompanyBaseCurrencyID"), "") = "" Then
            m_lngCompanyBaseCurrencyID = 0
        Else
            m_lngCompanyBaseCurrencyID = CType(Request.QueryString("CompanyBaseCurrencyID"), Long)
        End If

        ' the base currency symbol

        If m_lngCompanyBaseCurrencyID <> 0 Then
            m_strQ = "usp_Sel_tbl_PM_CurrencyMaster_CurrencyCodes " & m_lngCompanyBaseCurrencyID
            drDB = CommonFunctions.Data.GetDataReader(m_strQ, MyBase.UseSQL)
            If drDB.Read Then
                m_strCurrencySymbol = CType(CommonFunction.Data.CheckIsDBNull(drDB("CurrencyCode"), ""), String)
            End If
            CommonFunction.Data.DisposeDataReader(drDB)
        Else
            m_strCurrencySymbol = GetCurrencySymbol()
        End If

        strProjectFilter = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
        Dim strRemove As String = "ProjectID IN"

        If strProjectFilter <> "" Then
            strProjectFilter = strProjectFilter.Remove(0, strRemove.Length)
            strProjectFilter = strProjectFilter.Replace("'", "")
            strProjectFilter = strProjectFilter.Replace("(", "")
            strProjectFilter = strProjectFilter.Replace(")", "")
        End If
    End Sub

    Protected Sub WriteUI()
        '=====================================================================
        ' Page Name             : WriteUI
        ' Purpose               : writes the html for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Webpage
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Call WriteMenu()

        MyBase.InitializeResources("AppResources.RFI_InvoiceDB_Detail", "AppResources")

        ' sales period combo box
        With Response
            .Write("<BR>")
            Call WebPages.Template.PageCaption.GetPageCaptions(, GetPageCaption)
            .Write("<BR>")
            .Write("<BR>")
            .Write("<div id=divList style='overflow:none;width=100%'>")
            ' grid 
            Call WriteInfoGrid()
            .Write("<BR>")
            If UCase(Trim(m_strMode & "")) = "CUSTOMER" Then
                Call WriteCustomerGrid()
            Else
                Call WriteInvoiceGrid()
            End If
            .Write("</div>")
            .Write("<BR>")
        End With

        Call WriteMenu()

    End Sub

    Private Sub WriteInfoGrid()
        '=====================================================================
        ' Page Name             : WriteInfoGrid
        ' Purpose               : writes the grid for the invoice status info
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : GenericGrid
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Dim arrActualColumns() As String = {"Customer", "Company", "BusinessUnit", "OU", "SalesPeriod"}
        'Dim arrActualColumns() As String = {"Customer", "Company", "SalesPeriod"}
        Dim arrUserFriendlyColumns() As String = {MyBase.GetResourceString("COL_CUSTOMER"), MyBase.GetResourceString("COL_COMPANY"), MyBase.GetResourceString("COL_BUSINESS_UNIT"), MyBase.GetResourceString("COL_OU"), MyBase.GetResourceString("COL_PERIOD")}
        'Dim arrUserFriendlyColumns() As String = {MyBase.GetResourceString("COL_CUSTOMER"), MyBase.GetResourceString("COL_COMPANY"), MyBase.GetResourceString("COL_PERIOD")}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objInfoGrid = New WebPages.Template.GenericGrid
        With m_objInfoGrid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumns
            .NoOfDataColumns = 5 '4
            .SQL = "usp_Get_InvoiceDB_GridDetails " & m_lngSalesPeriodID & "," & m_lngCompanyId & "," & m_strBusinessUnitID & "," & m_strOUID & "," & m_lngCustomerID
            .EmptyValueReplacement = ""
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 0
            .returnHTML = False
            .UseSQL = m_blnUseSQL
            .VerticalDisplay = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objInfoGrid = Nothing

    End Sub


    Private Sub WriteCustomerGrid()
        '=====================================================================
        ' Page Name             : WriteCustomerGrid
        ' Purpose               : writes the grid for the invoice status
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : GenericGrid
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Dim arrActualColumns() As String = {"CustomerName", "NoOfDocuments", "Amount"}
        Dim strTypeCaption As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        Dim sSQL As String = "usp_Get_InvoiceDB_CustomerDetails " & m_lngSalesPeriodID & "," & m_lngCompanyId & "," & m_strBusinessUnitID & "," & m_strOUID & "," & m_intType & "," & m_lngCompanyBaseCurrencyID

        If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0"), Integer) <> 1 Then
            sSQL = sSQL & ",'" & strProjectFilter & "'"
        End If

        If m_intType <> 1 Then
            strTypeCaption = "No.Of Invoices"
        Else
            strTypeCaption = "No.Of IRs"
        End If
        Dim arrUserFriendlyColumns() As String = {MyBase.GetResourceString("COL_CUSTOMER"), strTypeCaption, Replace(MyBase.GetResourceString("COL_EQUIVALENT_AMT"), "<CURR_SYMBOL>", m_strCurrencySymbol)}
        Dim arrSummaryFunction() As String = {"", "SUM", "SUM"}
        m_objGrid = New WebPages.Template.GenericGrid

        With m_objGrid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumns
            .NoOfDataColumns = 3
            .SQL = sSQL
            .EmptyValueReplacement = ""
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 320
            .DIVID = "divListGrid"
            .DIVStyle = "overflow:scroll;width=100%"
            .ShowSummaryFunctions = True
            .SummaryFunctions = arrSummaryFunction
            .returnHTML = False
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing

    End Sub

    Private Sub WriteInvoiceGrid()
        '=====================================================================
        ' Page Name             : WriteInvoiceGrid
        ' Purpose               : writes the grid for the invoice status
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : GenericGrid
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Dim arrActualColumns() As String = {"InvoiceNumber", "InvoiceDate", "RFITypeName", "CurrencyCode", "BaseAmount", "Amount"}
        Dim arrUserFriendlyColumns() As String = {MyBase.GetResourceString("COL_INVOICE_NO"), MyBase.GetResourceString("COL_INVOICE_DATE"), MyBase.GetResourceString("COL_DESCRIPTION"), MyBase.GetResourceString("COL_CURRENCY"), MyBase.GetResourceString("COL_AMOUNT"), Replace(MyBase.GetResourceString("COL_EQUIVALENT_AMT"), "<CURR_SYMBOL>", m_strCurrencySymbol)}
        Dim arrSummaryFunction() As String = {"", "", "", "", "", "SUM"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objInvoiceGrid = New WebPages.Template.GenericGrid

        Dim sSQL As String = "usp_Get_InvoiceDB_InvoiceDetails " & m_lngCustomerID & "," & m_lngSalesPeriodID & "," & m_lngCompanyId & "," & m_strBusinessUnitID & "," & m_strOUID & "," & m_intType & "," & m_lngCompanyBaseCurrencyID
        If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0"), Integer) <> 1 Then
            sSQL = sSQL & ",'" & strProjectFilter & "'"
        End If

        With m_objInvoiceGrid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumns
            .NoOfDataColumns = 6
            .SQL = sSQL
            .EmptyValueReplacement = ""
            .ColNameToolTipOnEachRow = True
            .DIVHeight = 300
            .DIVID = "divListGrid"
            .DIVStyle = "overflow:scroll;width=100%"
            .ShowSummaryFunctions = True
            .SummaryFunctions = arrSummaryFunction
            .returnHTML = False
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objInvoiceGrid = Nothing

    End Sub

    Private Function GetPageCaption() As String
        '=====================================================================
        ' Page Name             : GetPageCaption
        ' Purpose               : to get the page caption based on from where
        '                         detail is requested
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : AppResources.dll
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Select Case m_intType.ToString
            Case "1" : Return MyBase.GetResourceString("COL_RFI_MADE")
            Case "2" : Return MyBase.GetResourceString("CAP_INVOICES_MADE")
            Case "3" : Return MyBase.GetResourceString("CAP_PDF_FILES_SENT")
            Case "4" : Return MyBase.GetResourceString("CAP_PHY_INV_DISPATCHED")
            Case "5" : Return MyBase.GetResourceString("CAP_SOFTEX_FORMS_REQD")
                'Coded Modified by VidyaJ on 2nd Feb 2004
                'Changed resource String
            Case "6" : Return MyBase.GetResourceString("CAP_SOFTEXT_FORMS_SENT")
            Case Else : Return MyBase.GetResourceString("CAP_DETAILS")
        End Select
    End Function


    Private Sub WriteMenu()
        '=====================================================================
        ' Page Name             : WriteMenu
        ' Purpose               : writes the menu html for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Webpage, Resources.dll
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")


        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Close_OnClick()", "Help_OnClick('INVOICEDB_DETAILS')"}
        Dim strMenu As String = WebPage.Templates.StaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Response.Write(strMenu)
    End Sub

    Private Function GetDefaultSalesPeriod() As Long
        '=====================================================================
        ' Page Name             : GetDefaultSalesPeriod
        ' Purpose               : Gets the default sales period --the first one
        ' Description           : This is required when user comes to the page
        '                         for the first time.
        ' Parameters Passed     : None
        ' Returns               : Long Sales Period ID
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Commonfunctions
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader
        dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_SalesPeriodMaster", m_blnUseSQL)
        If dr.Read Then
            m_lngSalesPeriodID = CType(CommonFunction.Data.CheckIsDBNull(dr("SalesPeriodID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

    Private Function GetCurrencySymbol() As String
        '=====================================================================
        ' Page Name             : GetCurrencyCode
        ' Purpose               : Gets the BASE CURRENCY code
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : Long Sales Period ID
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : Commonfunctions
        ' Author                : Rajanikant Khethawatt
        ' Created               : Aug 10, 2004
        ' Revisions             : 
        '=====================================================================
        Dim dr As IDataReader

        GetCurrencySymbol = ""
        dr = CommonFunctions.Data.GetDataReader("usp_InvoiceDB_GetBaseCurrencyInfo", m_blnUseSQL)
        If dr.Read Then
            GetCurrencySymbol = dr("CurrencyCode").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

    End Function

#Region "events"

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD><A href='javascript:Customer_OnClick(" & Args.DataReader("Customer").ToString & ")'><b>" & Server.HtmlEncode(Args.DataReader("CustomerName").ToString) & "</B></A></TD>"
        End If
    End Sub

    Private Sub m_objGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objGrid.SummaryFunctionsTR_BeforePrint
        Args.StringToBeInserted = "<tr bgcolor=black><td colspan=4></td></tr>"
    End Sub
    Private Sub m_objGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD><B>" & MyBase.GetResourceString("CAP_TOTAL") & "</B></TD>"
        ElseIf Args.ColIndex = 1 Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=right><B>" & FormatNumber(Args.SummaryValue, 0) & "</B></TD>"
        End If
    End Sub


    Private Sub m_objInfoGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objInfoGrid.ColumnHeaderTD_BeforePrint
        If UCase(Trim(m_strMode & "")) = "CUSTOMER" Then
            If Args.ColIndex = 0 Then
                Cancel = True
            End If
        End If
    End Sub

    Private Sub m_objInfoGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objInfoGrid.DataRowTD_BeforePrint
        If UCase(Trim(m_strMode & "")) = "CUSTOMER" Then
            If Args.ColIndex = 0 Then
                Cancel = True
            End If
        End If
    End Sub


    Private Sub m_objInvoiceGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objInvoiceGrid.SummaryFunctionsTR_BeforePrint
        Args.StringToBeInserted = "<tr bgcolor=black><td colspan=6></td></tr>"
    End Sub

    Private Sub m_objInvoiceGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objInvoiceGrid.SummaryFunctionsTD_BeforePrint
        If Args.ColIndex = 4 Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=right><B>" & MyBase.GetResourceString("CAP_TOTAL_AMOUNT") & "</B></TD>"
        End If
    End Sub

    Private Sub m_objInvoiceGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objInvoiceGrid.ColumnHeaderTD_BeforePrint
        If UCase(Trim(m_strMode & "")) = "INVOICE" And m_intType = 1 Then
            Select Case Args.ColIndex
                Case 0
                    Args.ColumnName = MyBase.GetResourceString("COL_RFI_ID")
                Case 1
                    Args.ColumnName = MyBase.GetResourceString("COL_RFI_RAISED_ON")
                Case Else
            End Select
        End If

    End Sub
#End Region

End Class
