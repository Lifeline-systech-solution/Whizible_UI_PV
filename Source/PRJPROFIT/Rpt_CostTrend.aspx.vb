Public Class Rpt_CostTrend
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
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
    Protected ObjdsCostHeads As DataSet
    Protected ObjdsResCost As DataSet
    Protected ObjdsProjCost As DataSet
    Protected objdsTotalCost As DataSet

    Protected m_FromDate As String = ""
    Protected m_ToDate As String = ""

    Protected m_strFromPeriod As String = ""
    Protected m_strToPeriod As String = ""

    Protected m_strCommercialType As String = ""
    Protected m_strCostMethod As String = ""

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub

    Protected Sub InitPage()
        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        InitVariables()
        ' CommonFunctions.General.WriteHTML("<br>")
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Cost Trends", "( Note : All figures are in " + m_CurrencySymbol + ")", , True))
        'CommonFunctions.General.WriteHTML("<TABLE id='tblCap'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTREven><TD align=Left> <B>Note:</B> All figures are in Rs. Currency</TD></TR></TABLE><br>")
        Call DrawMenu()
        ' Dim sbHTML As New System.Text.StringBuilder("")
        CommonFunctions.General.WriteHTML("<br><TABLE id='tblNote'  cellspacing=0 cellpadding=0 Width='99.9%'    class=clsTable>")
        CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption>")
        CommonFunctions.General.WriteHTML("<TD align=Left width=50%><b>")
        CommonFunctions.General.WriteHTML("Cost Trends")
        CommonFunctions.General.WriteHTML("</B></TD>")
        'CommonFunctions.General.WriteHTML("</Tr>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRodd>")
        CommonFunctions.General.WriteHTML("<TD align=right width=50%>")
        CommonFunctions.General.WriteHTML("(All figures in : " + m_CurrencySymbol + ")")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</Tr>")
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("<br>")

        With cObjSectionTitle
            CommonFunctions.General.WriteHTML(.GetSectionTitle("Project Details", "DivDetails", "ShowHideDivDetails", , ))
            CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>" + vbCrLf)
            CommonFunctions.General.WriteHTML(.ClientsideScript)
            CommonFunctions.General.WriteHTML("</SCRIPT>")
        End With
        CommonFunctions.General.WriteHTML("<br>")

        Call DrawProjectDetails()
        CommonFunctions.General.WriteHTML("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
        Call DrawCostTrend()
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<br>")
        Call DrawMenu()
    End Sub
    Private Sub DrawMenu()
        '=====================================================================
        ' Procedure Name        : DrawMenu()	
        ' Purpose               : This function is to plot menu.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : SEP 15 2008
        ' Revisions             :
        '=====================================================================
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        ' arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('3941')")

        'copy all the element to string array
        Dim arrstrMenu(arrMenu.Count - 1) As String
        Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
        Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
        arrMenu.CopyTo(arrstrMenu)
        arrMenuToolTip.CopyTo(arrstrMenuToolTip)
        arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
        arrMenu = Nothing
        arrMenuToolTip = Nothing
        arrClientSideFunctions = Nothing

        strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)
        'draw upper menu
        CommonFunction.General.WriteHTML(strMenu)

    End Sub
    Protected Sub InitVariables()
        Dim objDr As IDataReader

        m_ProjectID = HttpContext.Current.Session("intProjectID").ToString()
        m_strFromPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboFromPeriod"))
        m_strToPeriod = CommonFunction.General.CheckIsNothing(Request.Form("cboToPeriod"))

        m_strCostMethod = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Corporate_CostMethod", MyBase.UseSQL)))

        objDr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_TaskCaseStructure " + m_ProjectID, MyBase.UseSQL)

        If objDr.Read Then
            m_ProjectName = CommonFunction.Data.CheckIsDBNull(objDr("ProjectName"), "").ToString()
            m_ProjectValue = CommonFunction.Data.CheckIsDBNull(objDr("ContractValue"), "0").ToString()
            m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(objDr("CurrencySymbol"), "").ToString()

            m_strCommercialType = CType(CommonFunction.Data.CheckIsDBNull(objDr("NodeLabel"), "0"), String)

            If m_CurrencySymbol = "" Then
                m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_SEL_Tbl_PM_Compnayinformation_Currency", MyBase.UseSQL), "").ToString()
            End If
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

        ObjdsCostHeads = CommonFunction.Data.GetDataSet("usp_CRW_Profitability_Cost_Head " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString(), "CostHead", , , MyBase.UseSQL)
        ObjdsResCost = CommonFunction.Data.GetDataSet("usp_CRW_Profitability_ResourceCost " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString(), "ResourceCost", , , MyBase.UseSQL)
        ObjdsProjCost = CommonFunction.Data.GetDataSet(" usp_CRW_Profitability_Cost_Trend " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString(), "ExpenseCost", , , MyBase.UseSQL)
    End Sub

    Private Sub DrawProjectDetails()
        ' Draw the Project Details. 
        CommonFunction.General.WriteHTML("<div id='DivDetails' style='width:99.99%;height:20%;overflow:auto;'>")
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
        CommonFunction.General.WriteHTML("<td style='text-align:left' colspan='3'>&nbsp;")
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
        CommonFunction.General.WriteHTML("<td style='text-align:left' colspan='3'>&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawComboBox("cboToPeriod", "usp_Sel_ProjectProfitability_Periods " + m_ProjectID + ",'T'", 150, m_strToPeriod, "onchange='javascript:showData()'", True, True))
        'CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawDateControl("fltToDate", "fltToDate", , , m_ToDate, , "frmProjectProfit", Returnhtml:=True))
        'CommonFunction.General.WriteHTML("&nbsp;<input type='button' onclick=""showData()"" value=""Show"">")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")

    End Sub
    Public Sub DrawCostTrend()
        Dim drRpt As IDataReader
        Dim strSQL As String
        Dim sbHTML As New System.Text.StringBuilder("")
        Dim strPrevCostHead As String = ""
        Dim NumberOfColumns As Long = 0
        Dim TotalCost As Double



        sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%;'>")
        sbHTML.Append("<tr class='clsTRColumnHeader'>")

        sbHTML.Append("<td nowrap >")
        sbHTML.Append("As On")
        sbHTML.Append("</td>")
        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Resource Cost")
        sbHTML.Append("</td>")

        For Each drHead As DataRow In ObjdsCostHeads.Tables(0).Select("", "CostHead asc")
            NumberOfColumns += 1
            If strPrevCostHead <> drHead("CostHead").ToString Then
                sbHTML.Append("<td nowrap  style='text-align:right' >")
                sbHTML.Append(drHead("CostHead"))
                sbHTML.Append("</td>")
            End If
            strPrevCostHead = drHead("CostHead").ToString
        Next
        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Total Cost")
        sbHTML.Append("</td>")

        sbHTML.Append("</tr>")


        For Each drResCost As DataRow In ObjdsResCost.Tables(0).Select("", "Fromdate asc")
            sbHTML.Append("<tr class='clstreven'>")
            sbHTML.Append("<td nowrap >")
            sbHTML.Append(CommonFunctions.Dates.CGetDate(CType(drResCost("AsOn"), Date)))
            sbHTML.Append("</td>")
            sbHTML.Append("<td nowrap style='text-align:right' >")
            sbHTML.Append(m_CurrencySymbol)
            sbHTML.Append(" ")
            'Added & Commented By Dipali V On 10th Dec 2020 For Pagecrash
            'sbHTML.Append(FormatNumber(drResCost("ResourceCost"), 2))
            sbHTML.Append(FormatNumber(CommonFunction.Data.CheckIsDBNull(drResCost("ResourceCost"), 2), 0))
            'End of Added & Commented By Dipali V On 10th Dec 2020 For Pagecrash


            sbHTML.Append("</td>")

            If ObjdsCostHeads.Tables(0).Select().Length > 0 Then
                'If NumberOfColumns <> 0 Then
                For Each drProjCost As DataRow In ObjdsCostHeads.Tables(0).Select("", "CostHead")
                    If ObjdsProjCost.Tables(0).Select(" CostHeadid = '" + drProjCost("CostHeadID").ToString() + "' and ToDate='" + drResCost("ToDate").ToString() + "'", "CostHead asc").Length > 0 Then
                        For Each drProjectCostHead As DataRow In ObjdsProjCost.Tables(0).Select(" CostHeadid = '" + drProjCost("CostHeadID").ToString() + "' and ToDate='" + drResCost("ToDate").ToString() + "'", "CostHead asc")
                            sbHTML.Append("<td nowrap  style='text-align:right' >")
                            sbHTML.Append(m_CurrencySymbol)
                            sbHTML.Append(" ")
                            sbHTML.Append(FormatNumber(drProjectCostHead("ProjectCost"), 2))
                            sbHTML.Append("</td>")
                        Next
                    Else
                        sbHTML.Append("<td nowrap >")
                        sbHTML.Append("&nbsp;")
                        sbHTML.Append("</td>")
                    End If
                Next
            End If
            TotalCost = CType(drResCost("TotalCost"), Double)
            'If TotalCost <> 0.0 Then
            sbHTML.Append("<td nowrap style='text-align:right' >")
            sbHTML.Append(m_CurrencySymbol)
            sbHTML.Append(" ")
            sbHTML.Append(FormatNumber(drResCost("TotalCost"), 2))
            sbHTML.Append("</td>")
            'Else
            '    sbHTML.Append("<td nowrap style='text-align:right' >")
            '    sbHTML.Append("&nbsp;")
            '    sbHTML.Append("</td>")
            'End If
            sbHTML.Append("</tr>")
            'End If

        Next


        sbHTML.Append("</table>")

        CommonFunction.General.WriteHTML(sbHTML.ToString)

    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.standardMenu", "AppResources")
        'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        'MyBase.ApplySecurity(False, 2)
        MyBase.ApplySecurity(True, 2)
        'End of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
    End Sub
End Class
