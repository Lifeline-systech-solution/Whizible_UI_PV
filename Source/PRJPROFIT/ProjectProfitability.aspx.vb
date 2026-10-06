Public Class ProjectProfitability
    Inherits WebPage.Templates.WhizTemplate
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
    End Sub

#End Region

    Protected m_ProjectID As String = "0"
    Protected m_ProjectName As String = ""
    Protected m_ProjectStartDate As String = ""
    Protected m_ProjectEndDate As String = ""
    Protected m_ProjectActualStartDate As String = ""
    Protected m_projectActualEndDate As String = ""
    Protected m_CurrencySymbol As String = ""
    Protected m_ProjectValue As String = ""
    Protected m_contractType As String = ""
    Protected ObjdsProjectProfitability As DataSet
    'Protected ObjdsProjectResourceDetails As DataSet
    'Protected ObjdsProjectResources As DataSet
    Protected m_FromDate As String = ""
    Protected m_ToDate As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected strMenu As String
    Protected m_strFromPeriod As String = ""
    Protected m_strToPeriod As String = ""
    Protected m_strCommercialType As String = ""
    Protected m_strCostMethod As String = ""
    Protected m_strView As String = "2"

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Protected Sub Page_Init()
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        InitVariables()

        strMenu = InitializeMenu()
        'Top Menu
        CommonFunctions.General.WriteHTML(strMenu)

        CommonFunctions.General.WriteHTML("<br><TABLE id='tblNote'  cellspacing=0 cellpadding=0 Width='99.9%'    class=clsTable>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption>")
        CommonFunctions.General.WriteHTML("<TD align=Left width=50%><b>")
        CommonFunctions.General.WriteHTML("Project Profitability")
        CommonFunctions.General.WriteHTML("</B></TD>")

        CommonFunctions.General.WriteHTML("<TD align=right width=50%>")
        CommonFunctions.General.WriteHTML("(All figures in : " + m_CurrencySymbol + ")")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</Tr>")
        CommonFunctions.General.WriteHTML("</Table>")

        CommonFunctions.General.WriteHTML("<br>")
        Call DrawProjectDetails()
        CommonFunctions.General.WriteHTML("<br>")
        If m_strView = "1" Then
            Call DrawProfitability()
        ElseIf m_strView = "2" Then
            Call DrawPeriodicProfitability()
        Else
            Call DrawCumulativeProfitability()
        End If
        'Top Menu
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(strMenu)

    End Sub

    Protected Sub InitVariables()
        Dim objDr As IDataReader


        m_ProjectID = HttpContext.Current.Session("intProjectID").ToString()

        m_strFromPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboFromPeriod"))
        m_strToPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboToPeriod"))
        m_strView = CommonFunction.General.CheckIsNothing(Request.Form("cboViews"), "2")

        m_strCostMethod = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Corporate_CostMethod", MyBase.UseSQL)))

        objDr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_TaskCaseStructure " + m_ProjectID, MyBase.UseSQL)

        If objDr.Read Then
            m_ProjectName = CommonFunction.Data.CheckIsDBNull(objDr("ProjectName"), "").ToString()
            m_ProjectValue = CommonFunction.Data.CheckIsDBNull(objDr("ContractValue"), "0").ToString()

            m_strCommercialType = CType(CommonFunction.Data.CheckIsDBNull(objDr("NodeLabel"), "0"), String)

            m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(objDr("CurrencySymbol"), "").ToString()
            If m_CurrencySymbol = "" Then
                m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_SEL_Tbl_PM_Compnayinformation_Currency", MyBase.UseSQL), "").ToString()
            End If
            m_contractType = CommonFunction.Data.CheckIsDBNull(objDr("contractType"), "1").ToString()
            If Not IsNothing(objDr("ExpectedStartDate")) = True Then
                m_ProjectStartDate = CommonFunction.Dates.CGetDate(CType(objDr("ExpectedStartDate"), Date))
            Else
                m_ProjectStartDate = ""
            End If

            If Not IsNothing(objDr("ExpectedEndDate")) = True Then
                m_ProjectEndDate = CommonFunction.Dates.CGetDate(CType(objDr("ExpectedEndDate"), Date))
            Else
                m_ProjectEndDate = ""
            End If

            If Not IsDBNull(objDr("ActualStartDate")) = True Then
                m_ProjectActualStartDate = CommonFunction.Dates.CGetDate(CType(objDr("ActualStartDate"), Date))
            Else
                m_ProjectActualStartDate = ""
            End If

            If Not IsDBNull(objDr("ActualEndDate")) = True Then
                m_projectActualEndDate = CommonFunction.Dates.CGetDate(CType(objDr("ActualEndDate"), Date))
            Else
                m_projectActualEndDate = ""
            End If


        End If

        'If Not IsNothing(HttpContext.Current.Request.Form("fltFromDate")) = True Then
        If m_strFromPeriod <> "" Then
            m_FromDate = CommonFunctions.Dates.GetDate(CType(m_strFromPeriod, Date))
        Else
            m_FromDate = ""
        End If
        'Else
        'm_FromDate = ""
        'End If

        'If Not IsNothing(HttpContext.Current.Request.Form("fltToDate")) = True Then
        '    If HttpContext.Current.Request.Form("fltToDate").ToString() <> "" Then
        '        m_ToDate = CommonFunctions.Dates.GetDate(CType(HttpContext.Current.Request.Form("fltToDate"), Date))
        '    Else
        '        m_ToDate = ""
        '    End If

        'Else
        '    m_ToDate = ""
        'End If
        If m_strToPeriod <> "" Then
            m_ToDate = CommonFunctions.Dates.GetDate(CType(m_strToPeriod, Date))
        Else
            m_ToDate = ""
        End If

        CommonFunction.Data.DisposeDataReader(objDr)

        ObjdsProjectProfitability = CommonFunction.Data.GetDataSet("usp_SEL_Tbl_PM_ProjectProfitability " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString(), "Tbl_PM_ProjectProfitability", , , MyBase.UseSQL)
        'ObjdsProjectResourceDetails = CommonFunction.Data.GetDataSet("usp_SEL_Tbl_PM_ProjectProfitabilityResources " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString(), "Tbl_PM_ProjectProfitabilityResources", , , MyBase.UseSQL)
        'ObjdsProjectResources = CommonFunction.Data.GetDataSet("usp_SEL_Tbl_PM_ProjectProfitability_DistinctResources " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString(), "Tbl_PM_ProjectProfitabilityDistinctResources", , , MyBase.UseSQL)

    End Sub

    Private Sub DrawProjectDetails()
        ' Draw the Project Details. 
        CommonFunction.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding='1' style='width:99.99%' >")

        ' Project Name 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Project Name :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectName)
        CommonFunction.General.WriteHTML("</td>")
        'CommonFunction.General.WriteHTML("</tr>")

        ' Project Start Date 
        'CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Project Value :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_CurrencySymbol)
        CommonFunction.General.WriteHTML(" ")
        CommonFunction.General.WriteHTML(FormatNumber(m_ProjectValue, 2))
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Commercial Type :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_strCommercialType)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")

        ' Project Start Date 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Start Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectStartDate)
        CommonFunction.General.WriteHTML("</td>")

        ' Project Start Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("End Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectEndDate)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Cost Method :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_strCostMethod)
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")

        ' Project Actual Start Date 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Actual Start Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(m_ProjectActualStartDate)
        CommonFunction.General.WriteHTML("</td>")

        ' Project Actual End Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Actual End Date :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' colspan='3' >&nbsp;")
        CommonFunction.General.WriteHTML(m_projectActualEndDate)
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        ' Reporting Start Date 
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Reporting From :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("fltFromDate", "fltFromDate", , , m_FromDate, , "frmProjectProfit", Returnhtml:=True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboFromPeriod", "usp_Sel_ProjectProfitability_Periods " + m_ProjectID + ",'F'", 150, m_strFromPeriod, "onchange='javascript:showData()'", True, True))
        CommonFunction.General.WriteHTML("</td>")

        ' Reporting End Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Reporting To :")
        CommonFunction.General.WriteHTML("&nbsp;")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboToPeriod", "usp_Sel_ProjectProfitability_Periods " + m_ProjectID + ",'T'", 150, m_strToPeriod, "onchange='javascript:showData()'", True, True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("fltToDate", "fltToDate", , , m_ToDate, , "frmProjectProfit", Returnhtml:=True))
        'CommonFunction.General.WriteHTML("&nbsp;<input type='button' onclick=""showData()"" value=""Show"">")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td  style='text-align:right'>")
        CommonFunction.General.WriteHTML("Views :")
        CommonFunction.General.WriteHTML("&nbsp;")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboViews", "usp_Sel_Profitability_Views ", 120, m_strView, "onchange='javascript:View_OnChange(this)'", , True))
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("</table>")

    End Sub

    Private Sub DrawProfitability()

        Dim sbHTML As New System.Text.StringBuilder("")
        Dim NumberOfColumns As Long = 0
        Dim NoOfHeadings As Integer = 6
        Dim i As Integer = 0
      
        sbHTML.Append("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
        sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%;'>")
        ''
        sbHTML.Append("<thead class='clsTRColumnHeader'>")
        sbHTML.Append("<th  align='center' nowrap class='DivMain_Column'>&nbsp;</th>")
        sbHTML.Append("<th  align='center'  colspan='2' class='DivMain'>Actual Hours</th>")
        sbHTML.Append("<th  align='center'  colspan='2' class='DivMain'>People Costs </th>") ''( All Figures in : " + m_CurrencySymbol + " )
        sbHTML.Append("<th  align='center' colspan='2' class='DivMain'>Expenses & Direct Project Cost  </th>")
        sbHTML.Append("<th  align='center'  colspan='2' class='DivMain'>Accrued People Revenue </th>")
        sbHTML.Append("<th  align='center'  colspan='2' class='DivMain'>Accured Billable Expenses</th>")
        sbHTML.Append("<th  align='center'  colspan='2' class='DivMain'>Accrued GPM</th>")
        sbHTML.Append("<th  align='center'  colspan='2'class='DivMain'>Invoiced Revenue</th>")

        sbHTML.Append("</thead>")

        ''
        sbHTML.Append("<thead class='clsTRColumnHeader'>")
        sbHTML.Append("<th  align='right' nowrap class='DivMain_Column'>Reporting Date</th>")
        For i = 0 To NoOfHeadings
            sbHTML.Append("<th align='right' nowrap class='DivMain'>&nbsp;Periodic</th>")
            sbHTML.Append("<th  align='right' nowrap class='DivMain'>&nbsp;Cumulative</th>")
        Next

        sbHTML.Append("</thead>")

        For Each drDates As DataRow In ObjdsProjectProfitability.Tables(0).Select("", "ToDate asc")
            sbHTML.Append("<tr class='clsTRBlank' valign=top>")
            ''Period End Date
            sbHTML.Append("<td nowrap  style='text-align:right' class='Locked'>")
            sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(drDates("ToDate"), Date)))
            sbHTML.Append("</td>")

            ''Periodic Actual Hours
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("PeriodicAccruedActualHoursTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('ACTUALHOURS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedActualHoursTotal").ToString(), 2))
                sbHTML.Append("</a>")
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedActualHoursTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            ''Cumalitive Actual hours
            sbHTML.Append("<td nowrap style='text-align:right' >")
            If drDates("CumulativeAccruedActualHoursTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_ACTUALHOURS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedActualHoursTotal").ToString(), 2))
                sbHTML.Append("</a>")

            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedActualHoursTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")
            ''Periodic People Cost
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("PeriodicAccruedResourceCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('PEOPLECOSTS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")

            ''cumalitive People cost
            sbHTML.Append("<td nowrap style='text-align:right'>")
          
            If drDates("CumulativeAccruedResourceCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_PEOPLECOSTS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceCostTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")
            '''Periodic Expenses & Direct Project Cost 
            sbHTML.Append("<td nowrap style='text-align:right' >")

            If drDates("PeriodicOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicOtherCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            '''Cumalitive Expenses & Direct Project Cost 

            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("CumulativeOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeOtherCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            ''Periodic Accrued People Revenue 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("PeriodicAccruedResourceBillingTotal").ToString() <> "0" Then
                If m_contractType <> 1 Then
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('ACTUALCOST','")
                Else
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('MILESTONE_REVENUE','")
                End If
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceBillingTotal").ToString(), 2))
                sbHTML.Append("</a>")

            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceBillingTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")

            ''Cumalitive Accrued People Revenue 

            sbHTML.Append("<td nowrap style='text-align:right'>")
            
            If drDates("CumulativeAccruedResourceBillingTotal").ToString() <> "0" Then
                If m_contractType <> 1 Then
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_ACTUALCOST','")
                Else
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_MILESTONE_REVENUE','")
                End If

                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceBillingTotal").ToString(), 2))
                sbHTML.Append("</a>")

            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceBillingTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            ''Periodic Accured Billable Expenses
            sbHTML.Append("<td nowrap style='text-align:right'>")

            If drDates("PeriodicBillableOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('BILLABLE_EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicBillableOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")

            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicBillableOtherCostTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")

            ''Cumalitive Accured Billable Expenses
            sbHTML.Append("<td nowrap style='text-align:right'>")

            If drDates("CumulativeBillableOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_BILLABLE_EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeBillableOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")

            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeBillableOtherCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            ''Periodic Accrued GPM 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(drDates("PeriodicGPM_Project").ToString(), 2))
            sbHTML.Append("</td>")

            ''Cumalitive Accrued GPM 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(drDates("CumulativeGPM_Project").ToString(), 2))
            sbHTML.Append("</td>")

            ''Periodic Invoiced Revenue 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(drDates("PeriodicInvoiceBillingTotal").ToString(), 2))
            sbHTML.Append("</td>")

            ''Cumalitivie Invoiced Revenue 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(drDates("CumulativeInvoiceBillingTotal").ToString(), 2))
            sbHTML.Append("</td>")

            sbHTML.Append("</tr>")
        Next


        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub

    Private Sub DrawPeriodicProfitability()

        Dim sbHTML As New System.Text.StringBuilder("")
        Dim NumberOfColumns As Long = 0
        Dim NoOfHeadings As Integer = 6
        Dim i As Integer = 0
        Dim dblRevenueTotal As Double = 0.0
        Dim dblCostTotal As Double = 0.0
        Dim arrSumOfColumn(8) As Double


        sbHTML.Append("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
        sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%;'>")
        ''

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''
        sbHTML.Append("<thead class='clsTRColumnHeader'>")
        sbHTML.Append("<th  align='center' nowrap class='DivMain_Column'>&nbsp;</th>")
        sbHTML.Append("<th  align='center'  colspan='3' class='DivMain'> Revenue (A) </th>")
        sbHTML.Append("<th  align='center'  colspan='3' class='DivMain'> Cost (B) </th>")
        sbHTML.Append("<th  align='center'  colspan='1' class='DivMain'> GPM (A-B) </th>")
        sbHTML.Append("<th  align='center'  colspan='1' class='DivMain'>&nbsp; </th>")
        sbHTML.Append("<th  align='center'  colspan='1' class='DivMain'>&nbsp; </th>")

        sbHTML.Append("</thead>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        sbHTML.Append("<thead class='clsTRColumnHeader'>")
        sbHTML.Append("<th  align='center' nowrap class='DivMain_Column'>&nbsp;</th>")


        sbHTML.Append("<th  align='center'  class='DivMain'>Accrued People Revenue </th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>Accured Billable Expenses</th>")

        sbHTML.Append("<th  align='center'  class='DivMain'>Total</th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>People Costs </th>") ''( All Figures in : " + m_CurrencySymbol + " )
        sbHTML.Append("<th  align='center'  class='DivMain'>Expenses & Direct Project Cost  </th>")
        sbHTML.Append("<th  align='center'  class='DivMain'>Total</th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>Accrued GPM</th>")
        sbHTML.Append("<th  align='center'  class='DivMain'>Invoiced Revenue</th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>Actual Hours</th>")

        sbHTML.Append("</thead>")

        ''
        'sbHTML.Append("<thead class='clsTRColumnHeader'>")
        'sbHTML.Append("<th  align='right' nowrap class='DivMain_Column'>Reporting Date</th>")
        'For i = 0 To NoOfHeadings
        '    sbHTML.Append("<th align='right' nowrap class='DivMain'>&nbsp;Periodic</th>")
        '    ' sbHTML.Append("<th  align='right' nowrap class='DivMain'>&nbsp;Cumulative</th>")
        'Next

        'sbHTML.Append("</thead>")

        For Each drDates As DataRow In ObjdsProjectProfitability.Tables(0).Select("", "ToDate asc")
            dblRevenueTotal = 0.0
            dblCostTotal = 0.0

            sbHTML.Append("<tr class='clsTRBlank' valign=top>")
            ''Period End Date
            sbHTML.Append("<td nowrap  style='text-align:right' class='Locked'>")
            sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(drDates("ToDate"), Date)))
            sbHTML.Append("</td>")



            ''Periodic Accrued People Revenue 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("PeriodicAccruedResourceBillingTotal").ToString() <> "0" Then
                If m_contractType <> 1 Then
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('ACTUALCOST','")
                Else
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('MILESTONE_REVENUE','")
                End If
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceBillingTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblRevenueTotal += CType(drDates("PeriodicAccruedResourceBillingTotal"), Double)
                arrSumOfColumn(0) += CType(drDates("PeriodicAccruedResourceBillingTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceBillingTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")

            ''Cumalitive Accrued People Revenue 

            'sbHTML.Append("<td nowrap style='text-align:right'>")

            'If drDates("CumulativeAccruedResourceBillingTotal").ToString() <> "0" Then
            '    If m_contractType <> 1 Then
            '        sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_ACTUALCOST','")
            '    Else
            '        sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_MILESTONE_REVENUE','")
            '    End If

            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceBillingTotal").ToString(), 2))
            '    sbHTML.Append("</a>")

            'Else
            '    sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceBillingTotal").ToString(), 2))
            'End If
            'sbHTML.Append("</td>")
            ''Periodic Accured Billable Expenses
            sbHTML.Append("<td nowrap style='text-align:right'>")

            If drDates("PeriodicBillableOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('BILLABLE_EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicBillableOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblRevenueTotal += CType(drDates("PeriodicBillableOtherCostTotal"), Double)
                arrSumOfColumn(1) += CType(drDates("PeriodicBillableOtherCostTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicBillableOtherCostTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")

            ''Cumalitive Accured Billable Expenses
            'sbHTML.Append("<td nowrap style='text-align:right'>")

            'If drDates("CumulativeBillableOtherCostTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_BILLABLE_EXPENSES','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("CumulativeBillableOtherCostTotal").ToString(), 2))
            '    sbHTML.Append("</a>")

            'Else
            '    sbHTML.Append(FormatNumber(drDates("CumulativeBillableOtherCostTotal").ToString(), 2))
            'End If
            'sbHTML.Append("</td>")
            ''Periodic Invoiced Revenue 
           

            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(dblRevenueTotal, 2))
            sbHTML.Append("</td>")

            arrSumOfColumn(2) += dblRevenueTotal
            ''Cumalitivie Invoiced Revenue 
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'sbHTML.Append(FormatNumber(drDates("CumulativeInvoiceBillingTotal").ToString(), 2))
            'sbHTML.Append("</td>")

            ''Periodic People Cost
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("PeriodicAccruedResourceCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('PEOPLECOSTS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblCostTotal += CType(drDates("PeriodicAccruedResourceCostTotal"), Double)
                arrSumOfColumn(3) += CType(drDates("PeriodicAccruedResourceCostTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")

            ''cumalitive People cost
            'sbHTML.Append("<td nowrap style='text-align:right'>")

            'If drDates("CumulativeAccruedResourceCostTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_PEOPLECOSTS','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceCostTotal").ToString(), 2))
            '    sbHTML.Append("</a>")
            'Else
            '    sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceCostTotal").ToString(), 2))
            'End If

            'sbHTML.Append("</td>")
            '''Periodic Expenses & Direct Project Cost 
            sbHTML.Append("<td nowrap style='text-align:right' >")

            If drDates("PeriodicOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblCostTotal += CType(drDates("PeriodicOtherCostTotal"), Double)
                arrSumOfColumn(4) += CType(drDates("PeriodicOtherCostTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicOtherCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")

            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(dblCostTotal, 2))
            sbHTML.Append("</td>")
            arrSumOfColumn(5) += dblCostTotal
            '''Cumalitive Expenses & Direct Project Cost 

            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'If drDates("CumulativeOtherCostTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_EXPENSES','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("CumulativeOtherCostTotal").ToString(), 2))
            '    sbHTML.Append("</a>")
            'Else
            '    sbHTML.Append(FormatNumber(drDates("CumulativeOtherCostTotal").ToString(), 2))
            'End If
            'sbHTML.Append("</td>")

            ''Periodic Accrued GPM 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If CType(CommonFunction.Data.CheckIsDBNull(drDates("PeriodicGPM_Project"), "0"), Double) <= 0 Then
                sbHTML.Append("<font color='red'>")
                sbHTML.Append(FormatNumber(drDates("PeriodicGPM_Project").ToString(), 2))
                sbHTML.Append("</font>")
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicGPM_Project").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            arrSumOfColumn(6) += CType(CommonFunction.Data.CheckIsDBNull(drDates("PeriodicGPM_Project"), "0"), Double)
            ''Cumalitive Accrued GPM 
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'sbHTML.Append(FormatNumber(drDates("CumulativeGPM_Project").ToString(), 2))
            'sbHTML.Append("</td>")


            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(drDates("PeriodicInvoiceBillingTotal").ToString(), 2))
            sbHTML.Append("</td>")
            ' dblRevenueTotal -= CType(CommonFunction.Data.CheckIsDBNull(drDates("PeriodicInvoiceBillingTotal"), "0"), Double)
            arrSumOfColumn(7) += CType(CommonFunction.Data.CheckIsDBNull(drDates("PeriodicInvoiceBillingTotal"), "0"), Double)


            ''Periodic Actual Hours
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("PeriodicAccruedActualHoursTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('ACTUALHOURS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedActualHoursTotal").ToString(), 2))
                sbHTML.Append("</a>")
                arrSumOfColumn(8) += CType(CommonFunction.Data.CheckIsDBNull(drDates("PeriodicAccruedActualHoursTotal"), "0"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("PeriodicAccruedActualHoursTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            ''Cumalitive Actual hours
            'sbHTML.Append("<td nowrap style='text-align:right' >")
            'If drDates("CumulativeAccruedActualHoursTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_ACTUALHOURS','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("CumulativeAccruedActualHoursTotal").ToString(), 2))
            '    sbHTML.Append("</a>")

            'Else
            '    sbHTML.Append(FormatNumber(drDates("CumulativeAccruedActualHoursTotal").ToString(), 2))
            'End If

            'sbHTML.Append("</td>")

            sbHTML.Append("</tr>")
        Next
        sbHTML.Append("<tr class='clsTROdd' valign=top>")
        sbHTML.Append("<td nowrap  style='text-align:right' class='Locked'>")
        sbHTML.Append("Grand Total")
        sbHTML.Append("</td>")
        Dim j As Integer = 0
        For j = 0 To arrSumOfColumn.Length - 1
            sbHTML.Append("<td nowrap style='text-align:right'>")

            If j = 6 Then
                If arrSumOfColumn(j) <= 0 Then
                    sbHTML.Append("<font color='red'>")
                    sbHTML.Append(FormatNumber(arrSumOfColumn(j), 2))
                    sbHTML.Append("</font>")
                Else
                    sbHTML.Append(FormatNumber(arrSumOfColumn(j), 2))
                End If
            Else
                sbHTML.Append(FormatNumber(arrSumOfColumn(j), 2))
            End If

            sbHTML.Append("</td>")
        Next
        sbHTML.Append("</tr>")

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub
    Private Sub DrawCumulativeProfitability()

        Dim sbHTML As New System.Text.StringBuilder("")
        Dim NumberOfColumns As Long = 0
        Dim NoOfHeadings As Integer = 6
        Dim i As Integer = 0
        Dim dblRevenueTotal As Double = 0.0
        Dim dblCostTotal As Double = 0.0
        Dim arrSumOfColumn(8) As Double


        sbHTML.Append("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
        sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%;'>")
        ''

        ''''''''''''''''''''''''''''''''''''''''''''''''''''''
        sbHTML.Append("<thead class='clsTRColumnHeader'>")
        sbHTML.Append("<th  align='center' nowrap class='DivMain_Column'>&nbsp;</th>")
        sbHTML.Append("<th  align='center'  colspan='3' class='DivMain'> Revenue (A) </th>")
        sbHTML.Append("<th  align='center'  colspan='3' class='DivMain'> Cost (B) </th>")
        sbHTML.Append("<th  align='center'  colspan='1' class='DivMain'> GPM (A-B) </th>")
        sbHTML.Append("<th  align='center'  colspan='1' class='DivMain'>&nbsp; </th>")
        sbHTML.Append("<th  align='center'  colspan='1' class='DivMain'>&nbsp; </th>")

        sbHTML.Append("</thead>")
        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''

        sbHTML.Append("<thead class='clsTRColumnHeader'>")
        sbHTML.Append("<th  align='center' nowrap class='DivMain_Column'>&nbsp;</th>")


        sbHTML.Append("<th  align='center'  class='DivMain'>Accrued People Revenue </th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>Accured Billable Expenses</th>")
        sbHTML.Append("<th  align='center'  class='DivMain'>Total</th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>People Costs </th>") ''( All Figures in : " + m_CurrencySymbol + " )
        sbHTML.Append("<th  align='center'  class='DivMain'>Expenses & Direct Project Cost  </th>")
        sbHTML.Append("<th  align='center'  class='DivMain'>Total</th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>Accrued GPM</th>")
        sbHTML.Append("<th  align='center'  class='DivMain'>Invoiced Revenue</th>")
        sbHTML.Append("<th  align='center'   class='DivMain'>Actual Hours</th>")

        sbHTML.Append("</thead>")

        ''
        'sbHTML.Append("<thead class='clsTRColumnHeader'>")
        'sbHTML.Append("<th  align='right' nowrap class='DivMain_Column'>Reporting Date</th>")
        'For i = 0 To NoOfHeadings
        '    sbHTML.Append("<th align='right' nowrap class='DivMain'>&nbsp;Periodic</th>")
        '    ' sbHTML.Append("<th  align='right' nowrap class='DivMain'>&nbsp;Cumulative</th>")
        'Next

        'sbHTML.Append("</thead>")

        For Each drDates As DataRow In ObjdsProjectProfitability.Tables(0).Select("", "ToDate asc")
            dblRevenueTotal = 0.0
            dblCostTotal = 0.0

            sbHTML.Append("<tr class='clsTRBlank' valign=top>")
            ''Period End Date
            sbHTML.Append("<td nowrap  style='text-align:right' class='Locked'>")
            sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(drDates("ToDate"), Date)))
            sbHTML.Append("</td>")



            ''Periodic Accrued People Revenue 
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'If drDates("PeriodicAccruedResourceBillingTotal").ToString() <> "0" Then
            '    If m_contractType <> 1 Then
            '        sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('ACTUALCOST','")
            '    Else
            '        sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('MILESTONE_REVENUE','")
            '    End If
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceBillingTotal").ToString(), 2))
            '    sbHTML.Append("</a>")
            '    dblRevenueTotal += CType(drDates("PeriodicAccruedResourceBillingTotal"), Double)
            '    arrSumOfColumn(0) += CType(drDates("PeriodicAccruedResourceBillingTotal"), Double)
            'Else
            '    sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceBillingTotal").ToString(), 2))
            'End If

            'sbHTML.Append("</td>")

            ''Cumalitive Accrued People Revenue 

            sbHTML.Append("<td nowrap style='text-align:right'>")

            If drDates("CumulativeAccruedResourceBillingTotal").ToString() <> "0" Then
                If m_contractType <> 1 Then
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_ACTUALCOST','")
                Else
                    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_MILESTONE_REVENUE','")
                End If

                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceBillingTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblRevenueTotal += CType(drDates("CumulativeAccruedResourceBillingTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceBillingTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
            ''Periodic Accured Billable Expenses
            'sbHTML.Append("<td nowrap style='text-align:right'>")

            'If drDates("PeriodicBillableOtherCostTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('BILLABLE_EXPENSES','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("PeriodicBillableOtherCostTotal").ToString(), 2))
            '    sbHTML.Append("</a>")
            '    dblRevenueTotal += CType(drDates("PeriodicBillableOtherCostTotal"), Double)
            '    arrSumOfColumn(1) += CType(drDates("PeriodicBillableOtherCostTotal"), Double)
            'Else
            '    sbHTML.Append(FormatNumber(drDates("PeriodicBillableOtherCostTotal").ToString(), 2))
            'End If

            'sbHTML.Append("</td>")

            ''Cumalitive Accured Billable Expenses
            sbHTML.Append("<td nowrap style='text-align:right'>")

            If drDates("CumulativeBillableOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_BILLABLE_EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeBillableOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblRevenueTotal += CType(drDates("CumulativeBillableOtherCostTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeBillableOtherCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")
           

            'dblRevenueTotal -= CType(CommonFunction.Data.CheckIsDBNull(drDates("CumulativeInvoiceBillingTotal"), "0"), Double)


            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(dblRevenueTotal, 2))
            sbHTML.Append("</td>")


            ''Cumalitivie Invoiced Revenue 
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'sbHTML.Append(FormatNumber(drDates("CumulativeInvoiceBillingTotal").ToString(), 2))
            'sbHTML.Append("</td>")

            ''Periodic People Cost
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'If drDates("PeriodicAccruedResourceCostTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('PEOPLECOSTS','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceCostTotal").ToString(), 2))
            '    sbHTML.Append("</a>")
            '    dblCostTotal += CType(drDates("PeriodicAccruedResourceCostTotal"), Double)

            'Else
            '    sbHTML.Append(FormatNumber(drDates("PeriodicAccruedResourceCostTotal").ToString(), 2))
            'End If
            'sbHTML.Append("</td>")

            ''cumalitive People cost
            sbHTML.Append("<td nowrap style='text-align:right'>")

            If drDates("CumulativeAccruedResourceCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_PEOPLECOSTS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblCostTotal += CType(drDates("CumulativeAccruedResourceCostTotal"), Double)

            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedResourceCostTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")
            '''Periodic Expenses & Direct Project Cost 
            'sbHTML.Append("<td nowrap style='text-align:right' >")

            'If drDates("PeriodicOtherCostTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('EXPENSES','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("PeriodicOtherCostTotal").ToString(), 2))
            '    sbHTML.Append("</a>")
            '    dblCostTotal += CType(drDates("PeriodicOtherCostTotal"), Double)

            'Else
            '    sbHTML.Append(FormatNumber(drDates("PeriodicOtherCostTotal").ToString(), 2))
            'End If
            'sbHTML.Append("</td>")

           

            '''Cumalitive Expenses & Direct Project Cost 

            sbHTML.Append("<td nowrap style='text-align:right'>")
            If drDates("CumulativeOtherCostTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_EXPENSES','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeOtherCostTotal").ToString(), 2))
                sbHTML.Append("</a>")
                dblCostTotal += CType(drDates("CumulativeOtherCostTotal"), Double)
            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeOtherCostTotal").ToString(), 2))
            End If
            sbHTML.Append("</td>")

            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(dblCostTotal, 2))
            sbHTML.Append("</td>")

            ''Periodic Accrued GPM 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            If CType(CommonFunction.Data.CheckIsDBNull(drDates("CumulativeGPM_Project"), "0"), Double) <= 0 Then
                sbHTML.Append("<font color='red'>")
                sbHTML.Append(FormatNumber(drDates("CumulativeGPM_Project").ToString(), 2))
                sbHTML.Append("</font>")
            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeGPM_Project").ToString(), 2))
            End If
            sbHTML.Append("</td>")

            ''Cumalitive Accrued GPM 
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'sbHTML.Append(FormatNumber(drDates("CumulativeGPM_Project").ToString(), 2))
            'sbHTML.Append("</td>")



            ''Periodic Actual Hours
            'sbHTML.Append("<td nowrap style='text-align:right'>")
            'If drDates("PeriodicAccruedActualHoursTotal").ToString() <> "0" Then
            '    sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('ACTUALHOURS','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
            '    sbHTML.Append("','")
            '    sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
            '    sbHTML.Append("')>")
            '    sbHTML.Append(FormatNumber(drDates("PeriodicAccruedActualHoursTotal").ToString(), 2))
            '    sbHTML.Append("</a>")

            'Else
            '    sbHTML.Append(FormatNumber(drDates("PeriodicAccruedActualHoursTotal").ToString(), 2))
            'End If
            'sbHTML.Append("</td>")
            ''Periodic Invoiced Revenue 
            sbHTML.Append("<td nowrap style='text-align:right'>")
            sbHTML.Append(FormatNumber(drDates("CumulativeInvoiceBillingTotal").ToString(), 2))
            sbHTML.Append("</td>")

            ''Cumalitive Actual hours
            sbHTML.Append("<td nowrap style='text-align:right' >")
            If drDates("CumulativeAccruedActualHoursTotal").ToString() <> "0" Then
                sbHTML.Append("<a href=javascript:ResourceDetails_Onclick('CUMULATIVE_ACTUALHOURS','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("FromDate"), Date)))
                sbHTML.Append("','")
                sbHTML.Append(CommonFunctions.Dates.GetDate(CType(drDates("ToDate"), Date)))
                sbHTML.Append("')>")
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedActualHoursTotal").ToString(), 2))
                sbHTML.Append("</a>")

            Else
                sbHTML.Append(FormatNumber(drDates("CumulativeAccruedActualHoursTotal").ToString(), 2))
            End If

            sbHTML.Append("</td>")

            sbHTML.Append("</tr>")
        Next
        

        sbHTML.Append("</table>")
        sbHTML.Append("</div>")
        CommonFunction.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        If Not IsNothing(ObjdsProjectProfitability) = True Then
            ObjdsProjectProfitability = Nothing
        End If
        'If Not IsNothing(ObjdsProjectResourceDetails) = True Then
        '    ObjdsProjectResourceDetails = Nothing
        'End If
        'If Not IsNothing(ObjdsProjectResources) = True Then
        '    ObjdsProjectResources = Nothing
        'End If

    End Sub

    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""

        '--- added by purvaj on 26 Sept for report
        ArrMenuCaptionsList.Add("View Report")
        ArrMenuToolTipsList.Add("View Report")
        ArrClientSideFunctionsList.Add("ViewReport(" + m_ProjectID.ToString + ")")
        '--- End addition Purvaj

        ArrMenuCaptionsList.Add("?")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("OpenHelpPage('3940')")

        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        m_objMenu = New WebPage.Templates.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing
        Return strMenu
    End Function
    'Added By Vidya J ON 1 Feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ResourceDetails_Onclick(EmployeeID As String, CostType As String, Fromdate As String, Todate As String) As String
        Try
            Dim m_PKToken_ResourceDetails_Onclick As String
            m_PKToken_ResourceDetails_Onclick = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(CostType, String) + CType(Fromdate, String) + CType(Todate, String) + "0" + "0")

            Return m_PKToken_ResourceDetails_Onclick
        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    '<System.Web.Services.WebMethod> _
    'Public Shared Function GenrateURLToken_ViewReport(EmployeeID As String, ProjectID As String, ReportID As String) As String
    '    Dim m_PKToken_ViewReport As String
    '    m_PKToken_ViewReport = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(ProjectID, String) + CType(ReportID, String) + "0" + "0")

    '    Return m_PKToken_ViewReport
    'End Function
    'End Of Added By Vidya J ON 1 Feb 2016
End Class