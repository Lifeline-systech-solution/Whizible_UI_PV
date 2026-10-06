Public Class RFI_InvoiceDB
    Inherits WebPages.Template.WhizTemplate

    Protected m_strDB_PageName As String
    Private m_lngUserID As Long = 0
    Private m_lngPostID As Long = 0
    Private m_lngSalesPeriodID As Long = 0
    Private m_blnUseSQL As Boolean
    Private WithEvents m_objGrid As WebPages.Template.GenericGrid
    Private m_strCompanyName As String = ""
    Private m_strCurrencyCode As String = ""
    Private m_sCompanyBaseCurrencyCode As String = ""
    Private m_iCompanyBaseCurrencyID As Integer = 0
    Private m_dblCompanyBaseCurrencyAmount As Double = 0.0
    Private m_sSQL As String = ""
    Protected m_strBUId As String
    Protected m_strOUId As String
    Protected m_strSQL As String = ""
    Protected m_strMode As String = ""
    Protected m_txtHidMode As String = ""
    Protected drDB As IDataReader
    Protected strProjectFilter As String = ""



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
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting

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
        m_lngUserID = CType(Session("intUserID"), Long)
        m_lngPostID = CType(Session("intPostID"), Long)

        ' the current page name
        m_strDB_PageName = "../RFI/RFI_InvoiceDB.aspx"
        m_blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        m_strSQL = "usp_Get_InvoiceDB_Details "
        m_sSQL = " usp_Get_CompanyBaseCurrencyAmount_Details "

        m_strMode = CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        'If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0"), Integer) = 2 Then
        strProjectFilter = CommonFunction.General.CheckIsNothing(WebPage.Templates.RoleLevelAccessFilters.GetAccessFilters(CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean), , "ProjectID", CommonFunction.Application.ShowEvenReleaseFromProject), "")
        Dim strRemove As String = "ProjectID IN"

        If strProjectFilter <> "" Then
            strProjectFilter = strProjectFilter.Remove(0, strRemove.Length)
            strProjectFilter = strProjectFilter.Replace("'", "")
            strProjectFilter = strProjectFilter.Replace("(", "")
            strProjectFilter = strProjectFilter.Replace(")", "")
        End If

        If CommonFunctions.General.CheckIsNothing(Request.Form("cboSalesPeriod"), "") = "" Then
            m_lngSalesPeriodID = 0
        Else
            m_lngSalesPeriodID = CType(Request.Form("cboSalesPeriod"), Long)
        End If
        If m_lngSalesPeriodID = 0 Then
            m_lngSalesPeriodID = GetDefaultSalesPeriod()
        End If

        m_strSQL = m_strSQL & m_lngSalesPeriodID
        m_sSQL = m_sSQL & m_lngSalesPeriodID
        '=========================================================================================
        '   Business Unit
        '=========================================================================================
        If CommonFunction.General.CheckIsNothing(Request("cboBUID"), "") <> "" Then
            m_strBUId = Request("cboBUID")
            m_strSQL = m_strSQL & "," & m_strBUId
            m_sSQL = m_sSQL & "," & m_strBUId
        Else
            m_strBUId = "0"
            m_strSQL = m_strSQL & ",NULL"
            m_sSQL = m_sSQL & ",NULL"
        End If

        '=========================================================================================
        '   Organization Unit
        '=========================================================================================
        If CommonFunction.General.CheckIsNothing(Request("cboOUID"), "") <> "" Then
            m_strOUId = Request("cboOUID")
            m_strSQL = m_strSQL & "," & m_strOUId
            m_sSQL = m_sSQL & "," & m_strOUId
        Else
            m_strOUId = "0"
            m_strSQL = m_strSQL & ",NULL"
            m_sSQL = m_sSQL & ",NULL"
        End If

        If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intRoleLevel"), "0"), Integer) <> 1 Then
            m_strSQL = m_strSQL & ",'" & strProjectFilter & "'"
            m_sSQL = m_sSQL & ",'" & strProjectFilter & "'"
        Else
            m_sSQL = m_sSQL & ",NULL"
        End If



        m_strCurrencyCode = GetCurrencyCode()



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
        Dim strSQL As String

        Call WriteMenu()

        MyBase.InitializeResources("AppResources.RFI_InvoiceDB", "AppResources")

        ' sales period combo box
        With Response
            ' Write the Combo for e-Dashboard selections
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            If m_strMode <> "MDB" Then
                '--- Added By purvaj on 15 Jul 2009
                Dim m_blnHideCombo As Boolean = False
                Dim m_strDashboardID As String = ""
                '--- Added By purvaj on 15 Jul 2009
                m_strDashboardID = CommonFunction.General.CheckIsNothing(Request.QueryString("DashboardID"), "0")

                If m_strDashboardID = "" Or m_strDashboardID = "0" Then
                    m_strDashboardID = CommonFunction.General.CheckIsNothing(Request.Form("txtDashboardID"), "0")
                End If

                If m_strDashboardID.ToString <> "" And m_strDashboardID.ToString <> "0" Then
                    m_blnHideCombo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_ShowOrHide_DashboardCombo " + m_strDashboardID.ToString, True), False), False)
                End If

                'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtDashboardID", "txtDashboardID", , , , m_strDashboardID, , , , , , True, , True, EnableHTMLEncode:=True))
                'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
                '--- End addition purvaj
                '--- Condition added by purvaj on 15 Jul 2009 display combo only for old UI
                If m_blnHideCombo = False Then
                    '--- End addition purvaj
                    .Write("<TABLE Class=clsTable Width=99.9%>")
                    'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
                    .Write("<TR class=clsTREven>")
                    .Write("<TD>")

                    .Write("<b>")
                    .Write(MyBase.GetResourceString("CAP_DASHBOARD"))

                    ' Combo box to select the Type of e-Dashboard
                    If m_lngPostID <> 0 Then
                        strSQL = "usp_CDB_GetUserDashboardsForCombo  " & m_lngUserID & "," & m_lngPostID
                    Else
                        strSQL = "usp_CDB_GetUserDashboardsForCombo  " & m_lngUserID
                    End If
                    CommonFunctions.HTMLControls.DrawComboBox("cboDashboard", strSQL, , Trim(m_strDB_PageName & "") & "|0", "OnChange='JavaScript:cboDashboard_OnChange()'")
                    .Write("</TD>")
                    .Write("</TR>")
                    .Write("</TABLE>")
                    .Write("<BR>")
                End If
            End If
            ' sales period
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            .Write("<table class=clsTable width='99.9%'>")
            'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
            .Write("<tr class=clsTRPageFilters><TD align=left valign=top>") 'clsTREven
            .Write("<B>" & MyBase.GetResourceString("CAP_SALES_PERIOD") & " </B>")
            'Commented and added by TruptiK on 19-Dec-08
            'CommonFunctions.HTMLControls.DrawComboBox("cboSalesPeriod", "usp_Sel_tbl_PM_SalesPeriodMaster", , m_lngSalesPeriodID.ToString, " onchange=javascript:cboSalesPeriod_OnChange() ")
            CommonFunctions.HTMLControls.DrawComboBox("cboSalesPeriod", "usp_Sel_tbl_PM_SalesPeriodMaster_Dashboard", , m_lngSalesPeriodID.ToString, " onchange=javascript:cboSalesPeriod_OnChange() ")
            'End of addition by TruptiK on 19-Dec-08
            .Write("</td>")
            .Write("<TD align='right'><B>" & MyBase.GetResourceString("COL_BUSINESS_UNIT") & "</B></TD>")
            .Write("<TD align=left >")
            'Display Business Unit Combo
            CommonFunctions.HTMLControls.DrawComboBox("cboBUID", "usp_Sel_tbl_CNF_BusinessGroup", 200, m_strBUId, "" + " Langugage=JavaScript OnChange=cboBU_change()", True, , , )
            .Write("</TD>")
            .Write("<TD align='right'><B>" & MyBase.GetResourceString("COL_OU") & "</B></TD>")
            .Write("<TD align=left >")

            'Display Organization Unit Combo
            CommonFunctions.HTMLControls.DrawComboBox("cboOUID", "usp_Sel_tbl_PM_Location_For_BG " & m_strBUId, 200, m_strOUId, "" + " Langugage=JavaScript OnChange=cboOU_change()", True, , , )

            .Write("</TD>")
            .Write("</TR></table>")
            .Write("<BR>")
            ' grid 
            Call WriteGrid()
        End With

        Call WriteMenu()
    End Sub

    Private Sub WriteGrid()
        '=====================================================================
        ' Page Name             : WriteGrid
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
        'Dim arrActualColumns() As String = {"Company", "BusinessUnit", "TotalRFI", "RFIAmount", "InvoiceCount", "InvoiceAmount", "PDFFilesSent", "PDFFilesSentAmount", "PhysicalInvoicesCount", "PhysicalInvoicesAmount", "SoftexFormsRequired", "SoftexFormsAmount", "SoftexFormsSent", "SoftexFormsSentAmount"}
        Dim arrActualColumns() As String = {"Company", "CompanyCurrencies", "TotalRFI", "RFIAmount", "InvoiceCount", "InvoiceAmount", "PDFFilesSent", "PDFFilesSentAmount", "PhysicalInvoicesCount", "PhysicalInvoicesAmount", "SoftexFormsRequired", "SoftexFormsAmount", "SoftexFormsSent", "SoftexFormsSentAmount"}
        'Dim arrUserFriendlyColumns() As String = {"", "", "No", "Amount", "No", "Amount", "No", "Amount", "No", "Amount", "No", "Amount", "No", "Amount"}
        Dim arrUserFriendlyColumns() As String = {"", "", "No", "Amount", "No", "Amount", "No", "Amount", "No", "Amount", "No", "Amount", "No", "Amount"}
        Dim arrSummaryFunction() As String = {"", "", "", "SUM", "", "SUM", "", "SUM", "", "SUM", "", "SUM", "", "SUM"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_objGrid = New WebPages.Template.GenericGrid
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'Response.Write("<table cellpadding=0 cellspacing=0 bordercolor=black border=2 width='99.9%'><tr><td width='100%'>")
        Response.Write("<table cellpadding=0 cellspacing=0  border=1 width='99.9%' class=clsTable><tr><td width='100%'>")
        '<TABLE cellspacing=0; cellpadding=0 class=clsTable width='99.9%'>
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        With m_objGrid
            '--Columns in the Grid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserFriendlyColumns
            .NoOfDataColumns = arrActualColumns.Length  '14
            .ColumnHeaderAlignment = "center"
            .SQL = m_strSQL '"usp_Get_InvoiceDB_Details " & m_lngSalesPeriodID & " , " & m_strBUId & "," & m_strOUId
            .EmptyValueReplacement = ""
            .ColNameToolTipOnEachRow = True
            '.ShowSummaryFunctions = False
            '.SummaryFunctions = arrSummaryFunction
            '-- Properties for Sorting
            .DIVHeight = 300
            .DIVID = "divList"
            .DIVStyle = "overflow:auto;width=100%"
            .returnHTML = False
            .UseSQL = m_blnUseSQL
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing

        Response.Write("</td></tr></table>")
    End Sub

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


        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunctions() As String = {"Help_OnClick('INVOICEDB_DETAILS')"}
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
        dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_PM_SalesPeriodMaster_Dashboard ", m_blnUseSQL)
        If dr.Read Then
            m_lngSalesPeriodID = CType(CommonFunction.Data.CheckIsDBNull(dr("SalesPeriodID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        GetDefaultSalesPeriod = m_lngSalesPeriodID
    End Function

    Private Function GetCurrencyCode() As String
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

        GetCurrencyCode = ""
        dr = CommonFunctions.Data.GetDataReader("usp_InvoiceDB_GetBaseCurrencyInfo", m_blnUseSQL)
        If dr.Read Then
            GetCurrencyCode = dr("CurrencyCode").ToString
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

    End Function

#Region "events"

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub m_objGrid_ColumnHeaderTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTR) Handles m_objGrid.ColumnHeaderTR_BeforePrint
        Dim strTR As String
        strTR = "<tr class=clsTrColumnHeader>" & vbCrLf
        strTR += ("<td  Align='left'><b>" & MyBase.GetResourceString("COL_COMPANY") & "</b></td>" & vbCrLf)
        strTR += ("<td  Align='center'><b>Rotate Currencies</b></td>" & vbCrLf)
        strTR += ("<td  Align='center' Colspan=2><b>" & MyBase.GetResourceString("COL_RFI_MADE") & "</b></td>" & vbCrLf)
        strTR += ("<td  Align='center' Colspan=2><b>" & MyBase.GetResourceString("COL_INVOICES_MADE") & "</b></td>" & vbCrLf)
        strTR += ("<td  Align='center' Colspan=2><b>" & MyBase.GetResourceString("COL_PDF_FILES_SENT") & "</b></td>" & vbCrLf)
        strTR += ("<td  Align='center' Colspan=2><b>" & MyBase.GetResourceString("COL_PHY_INV_DISPATCHED") & "</b></td>" & vbCrLf)
        strTR += ("<td  Align='center' Colspan=2><b>" & MyBase.GetResourceString("COL_SOFTEX_FORMS_REQD") & "</b></td>" & vbCrLf)
        strTR += ("<td  Align='center' Colspan=2><b>" & MyBase.GetResourceString("COL_SOFTEX_FORMS_SENT") & "</b></td>" & vbCrLf)
        strTR += ("</tr>" & vbCrLf)
        Args.StringToBeInserted = strTR
        'Args.clsColumnHeader = "clsTREven"
        Args.clsColumnHeader = "clsTRSectionHeader"
    End Sub

    Private Sub m_objGrid_Table_BeforePrint(ByRef Args As WAF_Table) Handles m_objGrid.Table_BeforePrint
        Args.TableStyle = "cellpadding=1 cellspacing=1 class='clsTable'"

    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Args.TDStyle = "align='center' nowrap"

        If Args.ColIndex = 0 Or Args.ColIndex = 1 Then
            Args.ColumnName = ""
        End If

        'If UCase(Trim(Args.ColumnName & "")) = "AMOUNT" Then
        '    Args.ColumnName = MyBase.GetResourceString("COL_AMOUNT") & " (" + m_strCurrencyCode + ")"
        'End If
        'If UCase(Trim(Args.ColumnName & "")) = "NO" Then
        '    Args.ColumnName = MyBase.GetResourceString("COL_NO")
        'End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim m_strQ As String
        Select Case Trim(UCase(Args.DataField) & "")
            Case "COMPANYCURRENCIES"
                m_sCompanyBaseCurrencyCode = ""
                If CommonFunction.General.CheckIsNothing(Request("cboCompanyCur_" & Args.DataReader("CompanyID").ToString), "") <> "" Then
                    m_iCompanyBaseCurrencyID = CType(Request("cboCompanyCur_" & Args.DataReader("CompanyID").ToString), Integer)
                    m_strQ = "usp_Sel_tbl_PM_CurrencyMaster_CurrencyCodes " & m_iCompanyBaseCurrencyID
                    drDB = CommonFunctions.Data.GetDataReader(m_strQ, MyBase.UseSQL)
                    If drDB.Read Then
                        m_sCompanyBaseCurrencyCode = CType(CommonFunction.Data.CheckIsDBNull(drDB("CurrencyCode"), ""), String)
                    End If
                    m_strQ = ""
                    CommonFunction.Data.DisposeDataReader(drDB)
                Else
                    m_iCompanyBaseCurrencyID = 0
                End If

                Cancel = True
                Args.StringToBeInserted = "<TD align=center width=79>" & CommonFunction.HTMLControls.DrawComboBox("cboCompanyCur_" + Args.DataReader("CompanyID").ToString, " usp_Sel_CompanyBaseCurrencies " & Args.DataReader("CompanyID").ToString, 80, m_iCompanyBaseCurrencyID.ToString, " onchange=javascript:cboCompanyCur_OnChange() ", True, True) & "</TD>"

            Case "TOTALRFI"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("TotalRFI"), "0").ToString = "0" Then
                    Args.DataFieldValue = ""
                    Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & "," & Args.DataReader("BusinessUnitID").ToString & ",1" & ")><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("TotalRFI"), 0) & "</b></font></A></TD>"
                    Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & ",1)><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("TotalRFI"), 0) & "</b></font></A></TD>"
                End If
            Case "INVOICECOUNT"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("InvoiceCount"), "0").ToString = "0" Then
                    Args.DataFieldValue = "" : Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & "," & Args.DataReader("BusinessUnitID").ToString & ",2" & ")><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("InvoiceCount"), 0) & "</b></font></A></TD>"
                    Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & ",2)><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("InvoiceCount"), 0) & "</b></font></A></TD>"
                End If
            Case "PDFFILESSENT"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PDFFilesSent"), "0").ToString = "0" Then
                    Args.DataFieldValue = "" : Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & "," & Args.DataReader("BusinessUnitID").ToString & ",3" & ")><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("PDFFilesSent"), 0) & "</b></font></A></TD>"
                    Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & ",3)><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("PDFFilesSent"), 0) & "</b></font></A></TD>"
                End If
            Case "PHYSICALINVOICESCOUNT"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("PhysicalInvoicesCount"), "0").ToString = "0" Then
                    Args.DataFieldValue = "" : Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & "," & Args.DataReader("BusinessUnitID").ToString & ",4" & ")><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("PhysicalInvoicesCount"), 0) & "</b></font></A></TD>"
                    Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & ",4)><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("PhysicalInvoicesCount"), 0) & "</b></font></A></TD>"
                End If
            Case "SOFTEXFORMSREQUIRED"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SoftexFormsRequired"), "0").ToString = "0" Then
                    Args.DataFieldValue = "" : Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & "," & Args.DataReader("BusinessUnitID").ToString & ",5" & ")><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("SoftexFormsRequired"), 0) & "</b></font></A></TD>"
                    Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & ",5)><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("SoftexFormsRequired"), 0) & "</b></font></A></TD>"
                End If
            Case "SOFTEXFORMSSENT"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader("SoftexFormsSent"), "0").ToString = "0" Then
                    Args.DataFieldValue = "" : Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    'Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & "," & Args.DataReader("BusinessUnitID").ToString & ",6" & ")><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("SoftexFormsSent"), 0) & "</b></font></A></TD>"
                    Args.StringToBeInserted = "<TD align=right><A href=javascript:Detail_OnClick(" & Args.DataReader("CompanyID").ToString & ",6)><font face='verdana,arial'size=0 color=blue><b>" & FormatNumber(Args.DataReader("SoftexFormsSent"), 0) & "</b></font></A></TD>"
                End If


            Case "COMPANY"
                ' don't repeat the company name..for grouping effect
                If UCase(Trim(m_strCompanyName & "")) <> UCase(Trim(Args.DataReader("Company").ToString & "")) Then
                    Args.DataFieldValue = "<B>" & Args.DataFieldValue.ToString & "</b>"
                    Args.ApplyDataTypeBasedFormatting = False : Args.ApplyHTMLEncode = False
                Else
                    Args.DataFieldValue = ""
                    Args.ApplyDataTypeBasedFormatting = False
                End If
                'Case "BUSINESSUNIT"
                '    Args.DataFieldValue = "<B>" & Args.DataFieldValue.ToString & "</b>"
                '    Args.ApplyDataTypeBasedFormatting = False : Args.ApplyHTMLEncode = False

            Case "RFIAMOUNT", "INVOICEAMOUNT", "PDFFILESSENTAMOUNT", "PHYSICALINVOICESAMOUNT", "SOFTEXFORMSAMOUNT", "SOFTEXFORMSSENTAMOUNT"
                If CommonFunctions.Data.CheckIsDBNull(Args.DataReader(Args.DataField), "0").ToString = "0" Then
                    Args.DataFieldValue = "" : Args.ApplyDataTypeBasedFormatting = False
                Else
                    Cancel = True
                    m_dblCompanyBaseCurrencyAmount = CType(Args.DataFieldValue, Double)
                    If m_iCompanyBaseCurrencyID <> 0 Then
                        m_strQ = m_sSQL & "," & Args.DataReader("CompanyID").ToString() & "," & m_iCompanyBaseCurrencyID.ToString & ",'" & Trim(UCase(Args.DataField) & "") & "'"
                        m_dblCompanyBaseCurrencyAmount = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(m_strQ, MyBase.UseSQL), "0"), Double)
                        m_strQ = ""
                    End If
                    Args.StringToBeInserted = "<TD align=right  nowrap=true>" & FormatNumber(m_dblCompanyBaseCurrencyAmount, 2) & " " + CType(IIf(CType(m_sCompanyBaseCurrencyCode = "", Boolean), m_strCurrencyCode, m_sCompanyBaseCurrencyCode), String) + "" & "</TD>"

                End If

            Case Else
        End Select


        ' set the company name variable with curr value
        m_strCompanyName = Args.DataReader("Company").ToString


    End Sub

#End Region


    'Private Sub m_objGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objGrid.SummaryFunctionsTD_BeforePrint
    '    If Args.ColIndex = 0 Then
    '        Cancel = True
    '        Args.StringToBeInserted = "<TD align=left><B> Total </B></TD>"
    '    End If
    'End Sub
End Class
