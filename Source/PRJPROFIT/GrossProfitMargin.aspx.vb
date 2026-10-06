Public Partial Class GrossProfitMargin
    Inherits WebPage.Templates.WhizTemplate
    Protected m_strProjectID As String = ""
    Protected m_ProjectName As String = ""
    Protected m_ProjectValue As String = ""
    Protected m_CurrencySymbol As String = ""
    Protected m_BaseCurrencySymbol As String = ""
    Protected m_ProjectStartDate As String = ""
    Protected m_ProjectEndDate As String = ""
    Protected m_ProjectActualStartDate As String = ""
    Protected m_projectActualEndDate As String = ""
    Protected m_FromDate As String
    Protected m_ToDate As String
    Protected m_FromWhere As String = ""
    Private WithEvents objMenu As New WebPages.Template.StaticMenu
    Protected m_strCommercialType As String = ""
    Protected m_strCostMethod As String = ""

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        ''Added by Yogesh J on 10-Feb-2016 to validate Token
        If Request.QueryString("PKToken") <> "" And Request.QueryString("ProjectID") <> "" Then
            If Request.QueryString("FromWhere") = "BGOU" Or Request.QueryString("FromWhere") = "Customer" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(Request.QueryString("ProjectID"), String) + CType(0, String) + CType(0, String), Request.QueryString("PKToken")) = False) Then
                    ' Call CommonFunctions.General.WriteLog_InvalidRecordAccess(" Process Assetes", 0, 0, "ProjectID", CType(Request.QueryString("ProjectID"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If

            End If
        End If
        ''End of addition by Yogesh J on on 10-Feb-2016 to validate Token
    End Sub
    Protected Sub WritePage()
        Initialize()
        writeMenu()
        Response.Write("<br>")
        CreateCaption()
        Response.Write("<br>")
        DrawProjectDetails()
        Response.Write("<br>")
        WriteGrid()
        Response.Write("<br>")
        writeMenu()
    End Sub
    Protected Sub Initialize()
        m_strProjectID = CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0")
        m_FromWhere = CommonFunction.General.CheckIsNothing(Request.QueryString("FromWhere"), "PM")

        If m_strProjectID = "" Or m_strProjectID = "0" Then
            m_strProjectID = HttpContext.Current.Session("intProjectID").ToString()
        End If

        m_strCostMethod = Convert.ToString(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Sel_Corporate_CostMethod", MyBase.UseSQL)))

        Dim objDr As IDataReader

        objDr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_TaskCaseStructure " + m_strProjectID, True)

        If objDr.Read Then
            m_ProjectName = CommonFunction.Data.CheckIsDBNull(objDr("ProjectName"), "").ToString()
            m_ProjectValue = CommonFunction.Data.CheckIsDBNull(objDr("ContractValue"), "0").ToString()

            m_strCommercialType = CType(CommonFunction.Data.CheckIsDBNull(objDr("NodeLabel"), "0"), String)

            m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(objDr("CurrencySymbol"), "").ToString()
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

        If Not IsNothing(HttpContext.Current.Request.Form("fltFromDate")) = True Then
            If HttpContext.Current.Request.Form("fltFromDate").ToString() <> "" Then
                m_FromDate = CommonFunctions.Dates.GetDate(CType(HttpContext.Current.Request.Form("fltFromDate"), Date))
            Else
                m_FromDate = ""
            End If
        Else
            m_FromDate = ""
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("fltToDate")) = True Then
            If HttpContext.Current.Request.Form("fltToDate").ToString() <> "" Then
                m_ToDate = CommonFunctions.Dates.GetDate(CType(HttpContext.Current.Request.Form("fltToDate"), Date))
            Else
                m_ToDate = ""
            End If
        Else
            m_ToDate = ""
        End If
        CommonFunction.Data.DisposeDataReader(objDr)

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


        ' Project Start Date 
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Project Value :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")

        CommonFunction.General.WriteHTML(m_CurrencySymbol)
        CommonFunction.General.WriteHTML(" ")
        If Not IsNothing(m_ProjectValue) = True Then

            If m_ProjectValue <> "" Then
                CommonFunction.General.WriteHTML(FormatNumber(m_ProjectValue, 2))
            Else
                CommonFunction.General.WriteHTML(FormatNumber("0", 2))
            End If
        Else
            CommonFunction.General.WriteHTML(FormatNumber("0", 2))
        End If
        
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
        CommonFunction.General.WriteHTML("</table>")

    End Sub
    Protected Sub WriteGrid()

        Dim sbHTML As New System.Text.StringBuilder("")
        Dim objDR As IDataReader
        Dim strSQL As String = ""
        Dim strBaseCurrencySymbol As String = ""

        Dim strPeopleRevenue As String = ""
        Dim strAccuredBillableExpenses As String = ""
        Dim strTotal As String = "0"
        Dim strClass As String = ""
        Dim strCostHead As String = ""
        Dim strCostHeadCost As String = ""
        Dim strPeopleCost As String = ""
        Dim strTotalCost As String = "0"
        Dim strReportedOn As String = ""

        Dim strBasePeopleRevenue As String = ""
        Dim strBaseAccuredBillableExpenses As String = ""
        Dim strBaseTotal As String = "0"
        Dim strBaseClass As String = ""
        Dim strBaseCostHead As String = ""
        Dim strBaseCostHeadCost As String = ""
        Dim strBasePeopleCost As String = ""
        Dim strBaseTotalCost As String = "0"

        Dim intGPM As Decimal = 0
        Dim ccGPM As Decimal = 0
        Dim strGPM As String = "0"
        Dim strGPMInWords As String = ""
        intGPM = 0

        strSQL = "usp_SEL_Tbl_PM_ProjectProfitability_GPM  " + m_strProjectID
        objDR = CommonFunction.Data.GetDataReader(strSQL, True)

        If m_FromWhere <> "BGOU" And m_FromWhere <> "Customer" Then

            sbHTML.Append("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
            sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%;'>")

            sbHTML.Append("<tr class='clsTRColumnHeader'>")
            sbHTML.Append("<td colspan=2>")
            sbHTML.Append("&nbsp; <b>Accrued Revenue</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            sbHTML.Append("<tr class='ClsTROdd' >")
            sbHTML.Append("<td align:left width=50%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;People Revenue")
            sbHTML.Append("</td>")

            ' sbHTML.Append("</td>")
            If objDR.Read() Then
                strPeopleRevenue = CommonFunction.Data.CheckIsDBNull(objDR("PeopleRevenue"), "").ToString()
                strAccuredBillableExpenses = CommonFunction.Data.CheckIsDBNull(objDR("AccuredBillableExpenses"), "").ToString()
                strTotal = CommonFunction.Data.CheckIsDBNull(objDR("Total"), "").ToString()
                strPeopleCost = CommonFunction.Data.CheckIsDBNull(objDR("PeopleCost"), "").ToString()
                strTotalCost = CommonFunction.Data.CheckIsDBNull(objDR("TotalCost"), "0").ToString()
                'strReportedOn  =

                If Not IsDBNull(objDR("ToDate")) = True Then
                    strReportedOn = CommonFunction.Dates.CGetDate(CType(objDR("ToDate"), Date))
                Else
                    strReportedOn = ""
                End If
            End If
            sbHTML.Append("<td align=right width=50%>")
            If Not IsNothing(strPeopleRevenue) = True Then

                If strPeopleRevenue <> "" Then
                    sbHTML.Append(FormatNumber(strPeopleRevenue, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</td>")


            sbHTML.Append("</tr>")



            sbHTML.Append("<tr class='ClsTREven' >")
            sbHTML.Append("<td align:left width=50%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;Accured Billable Expenses  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=33%>")
            'sbHTML.Append(FormatNumber(strAccuredBillableExpenses, 2))
            If Not IsNothing(strAccuredBillableExpenses) = True Then

                If strAccuredBillableExpenses <> "" Then
                    sbHTML.Append(FormatNumber(strAccuredBillableExpenses, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            sbHTML.Append("<tr class='ClsTROdd' >")
            sbHTML.Append("<td align:left width=50%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;<b>Total Revenue</b>  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=50%>")
            sbHTML.Append("<b>")
            sbHTML.Append(m_CurrencySymbol + " ")
            If Not IsNothing(strTotal) = True Then

                If strTotal <> "" Then
                    sbHTML.Append(FormatNumber(strTotal, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            CommonFunction.Data.DisposeDataReader(objDR)
            'objDR = Nothing
            strSQL = Nothing

            strSQL = "usp_SEL_Tbl_PM_ProjectProfitabilityExpenses_CostHead  " + m_strProjectID
            objDR = CommonFunction.Data.GetDataReader(strSQL, True)

            sbHTML.Append("<tr class='clsTRColumnHeader'>")
            sbHTML.Append("<td colspan=2>")
            sbHTML.Append("&nbsp; <b>Accrued Cost</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            strClass = "clsTROdd"

            sbHTML.Append("<tr class=" & strClass & ">")
            sbHTML.Append("<td align=left width=50%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;People Cost  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=50%>")
            'sbHTML.Append(FormatNumber(strPeopleCost, 2))

            If Not IsNothing(strPeopleCost) = True Then

                If strPeopleCost <> "" Then
                    sbHTML.Append(FormatNumber(strPeopleCost, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If

            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            strClass = "clsTREven"
            While objDR.Read()

                sbHTML.Append("<tr class=" & strClass & ">")

                sbHTML.Append("<td align=left width=50% >")
                strCostHead = CommonFunction.Data.CheckIsDBNull(objDR("CostHead"), "").ToString()
                sbHTML.Append("&nbsp;&nbsp;&nbsp;" + strCostHead)
                sbHTML.Append("</td>")


                sbHTML.Append("<td align=right width=50%>")
                strCostHeadCost = CommonFunction.Data.CheckIsDBNull(objDR("CostHeadCost"), "").ToString()
                'sbHTML.Append(FormatNumber(strCostHeadCost, 2))

                If Not IsNothing(strCostHeadCost) = True Then

                    If strCostHeadCost <> "" Then
                        sbHTML.Append(FormatNumber(strCostHeadCost, 2))
                    Else
                        sbHTML.Append(FormatNumber("0", 2))
                    End If
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If

                sbHTML.Append("</td>")
                sbHTML.Append("</tr>")

                If strClass = "clsTROdd" Then
                    strClass = "clsTREven"
                Else
                    strClass = "clsTROdd"
                End If
            End While

            CommonFunction.Data.DisposeDataReader(objDR)

            sbHTML.Append("<tr class=" & strClass & ">")
            sbHTML.Append("<td align=left width=50%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;<b>Total Cost</b>  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=50%>")
            sbHTML.Append("<b>")

            sbHTML.Append(m_CurrencySymbol + " ")

            If Not IsNothing(strTotalCost) = True Then

                If strTotalCost <> "" Then
                    sbHTML.Append(FormatNumber(strTotalCost, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")

            If strTotal = "" Or strTotal = Nothing Then
                strTotal = "0"
            End If
            If strTotalCost = "" Or strTotalCost = Nothing Then
                strTotalCost = "0"
            End If
            If strGPM = "" Or strGPM = Nothing Then
                strGPM = "0"
            End If
            If strTotal <> "" And strTotalCost <> "" Then
                intGPM = CType(strTotal, Decimal) - CType(strTotalCost, Decimal)
            Else
                intGPM = 0
            End If
            strGPM = intGPM.ToString()
            strGPM = FormatNumber(strGPM, 2)
            If strGPM <> "" Then
                intGPM = CType(strGPM, Decimal)
            End If

            sbHTML.Append("<br>")
            sbHTML.Append("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")
            sbHTML.Append("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
            sbHTML.Append("<td style='width:99.99%;text-align:center'><B>Gross Profit Margin ")
            sbHTML.Append(" (as on : ")
            sbHTML.Append(strReportedOn)
            sbHTML.Append(" )")
            sbHTML.Append(" =  Total Revenue - Total Cost")

            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            'sbHTML.Append("</TABLE>")

            'sbHTML.Append("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")
            sbHTML.Append("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
            If intGPM >= 0 Then
                ' sbHTML.Append("<td style='width:99.99%;text-align:left'><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gross Profit Margin  =  " + strTotal + " - " + strTotalCost + " = " + FormatNumber(intGPM.ToString, 2) + m_CurrencySymbol + "")
                sbHTML.Append("<td style='width:99.99%;text-align:center'><B>Gross Profit Margin  =  " + m_CurrencySymbol + " " + FormatNumber(strTotal, 2) + " - " + m_CurrencySymbol + " " + FormatNumber(strTotalCost, 2) + " = " + m_CurrencySymbol + " " + FormatNumber(intGPM.ToString, 2) + "")
            Else
                'sbHTML.Append("<td style='width:99.99%;text-align:left'><B>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Gross Profit Margin  =  " + FormatNumber(strTotal, 2) + " - " + FormatNumber(strTotalCost, 2) + " = <font color='#ff0000'>(" + FormatNumber(intGPM.ToString, 2) + ")&nbsp;" + m_CurrencySymbol + "</font>" + "")
                sbHTML.Append("<td style='width:99.99%;text-align:center'><B>Gross Profit Margin  =  " + m_CurrencySymbol + " " + FormatNumber(strTotal, 2) + " - " + m_CurrencySymbol + " " + FormatNumber(strTotalCost, 2) + " = <font color='#ff0000'>(" + m_CurrencySymbol + " " + FormatNumber(intGPM.ToString, 2) + ")&nbsp;&nbsp;" + "</font>" + "")
            End If

            sbHTML.Append("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
            sbHTML.Append("<td style='width:99.99%;text-align:center'><B>Gross Profit Margin % = ")

            If strTotal <> "0" Then
                'Commented And Added By Usha Pandit On 18.05.2020 For getting correct GPM value
                'Dim GPMPercentage As Double = (CType(strTotal, Double) - CType(strTotalCost, Double)) / CType(strTotal, Double) * 100
                Dim GPMPercentage As Double = 0.0
                If CType(strTotalCost, Double) > CType(strTotal, Double) Then
                    GPMPercentage = 0
                Else
                    GPMPercentage = (CType(strTotal, Double) - CType(strTotalCost, Double)) / CType(strTotal, Double) * 100
                End If
                'End Of Added By Usha Pandit On 18.05.2020 For getting correct GPM value
                If GPMPercentage >= 0 Then
                    sbHTML.Append(FormatNumber(GPMPercentage, 2))
                Else
                    sbHTML.Append("<font color='#ff0000'>" + FormatNumber(GPMPercentage, 2) + "</font>")
                End If
            Else
                sbHTML.Append(" 0 ")
            End If

                sbHTML.Append("</td>")
                sbHTML.Append("</tr>")

                'sbHTML.Append("</td>")
                'sbHTML.Append("</tr>")

                sbHTML.Append("</TABLE>")
                sbHTML.Append("</div>")
                'Condition Ended By PiyushB on 11-Aug-2008
            End If
        If m_FromWhere = "BGOU" Or m_FromWhere = "Customer" Then
            'Condition Added By PiyushB on 11-Aug-2008
            'Purpose : To display Figures in Base Currency only
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strBaseCurrencySymbol = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select CurrencySymbol  FROM tbl_PM_CurrencyMaster INNER JOIN tbl_PM_CompanyInformation ON tbl_PM_CurrencyMaster.CurrencyID = tbl_PM_CompanyInformation.BaseCurrencyID", True), "-")
            strBaseCurrencySymbol = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CurrencyMaster_Currency", True), "-")
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            sbHTML.Append("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
            sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%;'>")

            sbHTML.Append("<tr  class='clsTRColumnHeader'>")
            sbHTML.Append("<td  align:left width=40% >")
            sbHTML.Append("&nbsp; <b>Accrued Revenue</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("<td  style='text-align:right' width=30% >")
            sbHTML.Append("&nbsp; <b>Project Currency &nbsp;(" + m_CurrencySymbol + ")</b> ")
            sbHTML.Append("</td>")
            sbHTML.Append("<td  style='text-align:right' width=30%>")
            sbHTML.Append("&nbsp; <b>Corporate Base Currency &nbsp;(" + strBaseCurrencySymbol + ")</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            sbHTML.Append("<tr class='ClsTROdd' >")
            sbHTML.Append("<td align:left width=40%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;People Revenue")
            sbHTML.Append("</td>")

            ' sbHTML.Append("</td>")
            If objDR.Read() Then
                strPeopleRevenue = CommonFunction.Data.CheckIsDBNull(objDR("PeopleRevenue"), "").ToString()
                strAccuredBillableExpenses = CommonFunction.Data.CheckIsDBNull(objDR("AccuredBillableExpenses"), "").ToString()
                strTotal = CommonFunction.Data.CheckIsDBNull(objDR("Total"), "").ToString()
                strPeopleCost = CommonFunction.Data.CheckIsDBNull(objDR("PeopleCost"), "").ToString()
                strTotalCost = CommonFunction.Data.CheckIsDBNull(objDR("TotalCost"), "0").ToString()
                strBasePeopleRevenue = CommonFunction.Data.CheckIsDBNull(objDR("BasePeopleRevenue"), "").ToString()
                strBaseAccuredBillableExpenses = CommonFunction.Data.CheckIsDBNull(objDR("BaseAccuredBillableExpenses"), "").ToString()
                strBaseTotal = CommonFunction.Data.CheckIsDBNull(objDR("BaseTotal"), "").ToString()
                strBasePeopleCost = CommonFunction.Data.CheckIsDBNull(objDR("BasePeopleCost"), "").ToString()
                strBaseTotalCost = CommonFunction.Data.CheckIsDBNull(objDR("BaseTotalCost"), "0").ToString()

                If Not IsDBNull(objDR("ToDate")) = True Then
                    strReportedOn = CommonFunction.Dates.CGetDate(CType(objDR("ToDate"), Date))
                Else
                    strReportedOn = ""
                End If

            End If
            sbHTML.Append("<td align=right width=30%>")

            If Not IsNothing(strPeopleRevenue) = True Then

                If strPeopleRevenue <> "" Then
                    sbHTML.Append(FormatNumber(strPeopleRevenue, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            If Not IsNothing(strBasePeopleRevenue) = True Then
                If strBasePeopleRevenue <> "" Then
                    sbHTML.Append(FormatNumber(strBasePeopleRevenue, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")



            sbHTML.Append("<tr class='ClsTREven' >")

            sbHTML.Append("<td align:left width=40%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;Accured Billable Expenses  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            'sbHTML.Append(FormatNumber(strAccuredBillableExpenses, 2))
            If Not IsNothing(strAccuredBillableExpenses) = True Then

                If strAccuredBillableExpenses <> "" Then
                    sbHTML.Append(FormatNumber(strAccuredBillableExpenses, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</td>")


            sbHTML.Append("<td align=right width=30%>")
            'sbHTML.Append(FormatNumber(strAccuredBillableExpenses, 2))
            If Not IsNothing(strBaseAccuredBillableExpenses) = True Then

                If strBaseAccuredBillableExpenses <> "" Then
                    sbHTML.Append(FormatNumber(strBaseAccuredBillableExpenses, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")


            sbHTML.Append("<tr class='ClsTROdd' >")
            sbHTML.Append("<td align:left width=40%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;<b>Total Revenue</b>  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            sbHTML.Append("<b>")
            If Not IsNothing(strTotal) = True Then
                sbHTML.Append(m_CurrencySymbol + " ")
                If strTotal <> "" Then
                    sbHTML.Append(FormatNumber(strTotal, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</b>")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            sbHTML.Append("<b>")
            If Not IsNothing(strBaseTotal) = True Then
                sbHTML.Append(strBaseCurrencySymbol + " ")
                If strBaseTotal <> "" Then
                    sbHTML.Append(FormatNumber(strBaseTotal, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</b>")
            sbHTML.Append("</td>")

            sbHTML.Append("</tr>")
            CommonFunction.Data.DisposeDataReader(objDR)
            'objDR = Nothing
            strSQL = Nothing
            strSQL = "usp_SEL_Tbl_PM_ProjectProfitabilityExpenses_CostHead  " + m_strProjectID
            objDR = CommonFunction.Data.GetDataReader(strSQL, True)

            sbHTML.Append("<tr class='clsTRColumnHeader'>")
            sbHTML.Append("<td  align:left width=40% >")
            sbHTML.Append("&nbsp; <b>Accrued Cost</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("<td  align:left width=30% >")
            sbHTML.Append("&nbsp;")
            sbHTML.Append("</td>")
            sbHTML.Append("<td  align:left width=30%>")
            sbHTML.Append("&nbsp; ")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")

            strClass = "clsTROdd"

            sbHTML.Append("<tr class=" & strClass & ">")
            sbHTML.Append("<td align=left width=40%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;People Cost  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            'sbHTML.Append(FormatNumber(strPeopleCost, 2))

            If Not IsNothing(strPeopleCost) = True Then

                If strPeopleCost <> "" Then
                    sbHTML.Append(FormatNumber(strPeopleCost, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If

            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            'sbHTML.Append(FormatNumber(strPeopleCost, 2))

            If Not IsNothing(strBasePeopleCost) = True Then

                If strBasePeopleCost <> "" Then
                    sbHTML.Append(FormatNumber(strBasePeopleCost, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If

            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")


            strClass = "clsTREven"
            While objDR.Read()

                sbHTML.Append("<tr class=" & strClass & ">")
                sbHTML.Append("<td align=left width=40% >")
                strCostHead = CommonFunction.Data.CheckIsDBNull(objDR("CostHead"), "").ToString()
                sbHTML.Append("&nbsp;&nbsp;&nbsp;" + strCostHead)
                sbHTML.Append("</td>")

                sbHTML.Append("<td align=right width=30%>")
                strCostHeadCost = CommonFunction.Data.CheckIsDBNull(objDR("CostHeadCost"), "").ToString()
                'sbHTML.Append(FormatNumber(strCostHeadCost, 2))

                If Not IsNothing(strCostHeadCost) = True Then

                    If strCostHeadCost <> "" Then
                        sbHTML.Append(FormatNumber(strCostHeadCost, 2))
                    Else
                        sbHTML.Append(FormatNumber("0", 2))
                    End If
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If

                sbHTML.Append("</td>")
                'Check this td
                sbHTML.Append("<td align=right width=30%>")
                strCostHeadCost = CommonFunction.Data.CheckIsDBNull(objDR("CumulativeBaseCurrencyCost"), "").ToString()
                'sbHTML.Append(FormatNumber(strCostHeadCost, 2))

                If Not IsNothing(strCostHeadCost) = True Then

                    If strCostHeadCost <> "" Then
                        sbHTML.Append(FormatNumber(strCostHeadCost, 2))
                    Else
                        sbHTML.Append(FormatNumber("0", 2))
                    End If
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If

                sbHTML.Append("</td>")
                'End of check this td


                sbHTML.Append("</tr>")
                If strClass = "clsTROdd" Then
                    strClass = "clsTREven"
                Else
                    strClass = "clsTROdd"
                End If
            End While

            sbHTML.Append("<tr class=" & strClass & ">")
            sbHTML.Append("<td align=left width=40%>")
            sbHTML.Append("&nbsp;&nbsp;&nbsp;<b>Total Cost</b>  &nbsp;")
            sbHTML.Append("</td>")

            sbHTML.Append("<td align=right width=30%>")
            sbHTML.Append("<b>")


            If Not IsNothing(strTotalCost) = True Then
                sbHTML.Append(m_CurrencySymbol + " ")
                If strTotalCost <> "" Then
                    sbHTML.Append(FormatNumber(strTotalCost, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</b>")
            sbHTML.Append("</td>")

            'Check this td
            sbHTML.Append("<td align=right width=30%>")
            sbHTML.Append("<b>")
            sbHTML.Append(strBaseCurrencySymbol + " ")

            If Not IsNothing(strBaseTotalCost) = True Then

                If strBaseTotalCost <> "" Then
                    sbHTML.Append(FormatNumber(strBaseTotalCost, 2))
                Else
                    sbHTML.Append(FormatNumber("0", 2))
                End If
            Else
                sbHTML.Append(FormatNumber("0", 2))
            End If
            sbHTML.Append("</b>")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")


            'End of Check this td
            If strTotal = "" Or strTotal = Nothing Then
                strTotal = "0"
            End If
            If strTotalCost = "" Or strTotalCost = Nothing Then
                strTotalCost = "0"
            End If
            If strBaseTotal = "" Or strBaseTotal = Nothing Then
                strBaseTotal = "0"
            End If
            If strBaseTotalCost = "" Or strBaseTotalCost = Nothing Then
                strBaseTotalCost = "0"
            End If

            intGPM = CType(strTotal, Decimal) - CType(strTotalCost, Decimal)
            ccGPM = CType(strBaseTotal, Decimal) - CType(strBaseTotalCost, Decimal)
            strGPM = intGPM.ToString()
            strGPM = FormatNumber(strGPM, 2)
            intGPM = CType(strGPM, Decimal)
            sbHTML.Append("<tr class=clsTRColumnHeader>")
            'sbHTML.Append("<td align=left width=40% ><B>Gross Profit Margin  =  Total Revenue - Total Cost</b>")
            sbHTML.Append("<td style='width:99.99%;text-align:center'><B>Gross Profit Margin ")
            sbHTML.Append(" (as on : ")
            sbHTML.Append(strReportedOn)
            sbHTML.Append(" )")
            sbHTML.Append(" =  Total Revenue - Total Cost</b>")
            sbHTML.Append("</td>")

            sbHTML.Append("<td style='width:30%;text-align:right'><B>" + m_CurrencySymbol + " " + FormatNumber(intGPM.ToString, 2))
            sbHTML.Append("</B></td>")
            sbHTML.Append("<td style='width:30%;text-align:right'><B>" + strBaseCurrencySymbol + " " + FormatNumber(ccGPM.ToString, 2))
            sbHTML.Append("</B></td>")
            sbHTML.Append("</tr>")

            sbHTML.Append("</table>")

            sbHTML.Append("</div>")


            CommonFunction.Data.DisposeDataReader(objDR)

        End If
        CommonFunction.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub


    Protected Sub CreateCaption()
        CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=1 class=clsTRPageCaption align='left'>")
        CommonFunctions.General.WriteHTML("<td style='width:17%;text-align:left'><B>&nbsp;Gross Profit Margin</B>")
        CommonFunctions.General.WriteHTML("</td>")
        If m_FromWhere <> "BGOU" And m_FromWhere <> "Customer" Then
            CommonFunctions.General.WriteHTML("<td style='width:17%;text-align:right; FONT-WEIGHT: normal;'>&nbsp;( All Figures In :  " + m_CurrencySymbol + " )")
            CommonFunctions.General.WriteHTML("</td>")
        End If

        CommonFunctions.General.WriteHTML("</tr>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub
    Protected Sub writeMenu()
        Dim ShowLink As String
        Dim ShowLinkToolTip As String
        Dim ShowLinkFunction As String
        objMenu = New WebPage.Templates.StaticMenu
        If m_FromWhere <> "BGOU" And m_FromWhere <> "Customer" Then
            'Dim arrMenu() As String = {"<img id='imgHelp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Help.gif'>"}
            Dim arrMenu() As String = {"?"}
            Dim arrMenuToolTip() As String = {"Help"}
            Dim arrCSFunction() As String = {"Help_OnClick('3942')"}
            objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)
        Else
            'Dim arrMenu() As String = {"<img id='imgClose' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Close.gif'> Close", "<img id='imgHelp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Help.gif'>"}
            Dim arrMenu() As String = {"Close", "?"}
            Dim arrMenuToolTip() As String = {"Close", "Help"}
            Dim arrCSFunction() As String = {"Close_OnClick()", "Help_OnClick('3942')"}
            objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)
        End If

    End Sub

End Class