Option Strict Off
Public Class ProjectDrillDowns
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
    Protected m_FromDate As String = ""
    Protected m_ToDate As String = ""
    Protected m_dtTodate As String = ""
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected strMenu As String
    Protected m_CostType As String = ""
    Protected m_ProjectName As String = ""
    Protected ObjdsResourceDtls As DataSet
    Protected m_CurrencySymbol As String = ""
    Protected strCostColumnName As String = ""
    Protected strNote As String = ""
    Protected m_PKTokenValue As String = ""
    Protected m_PKTokenCostType As String = ""
    Protected m_PKTokenFromDate As String = ""
    Protected m_PKTokenTodate As String = ""
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        ''Added By Vidya J ON 1 Feb 2016
        If Not Request.QueryString("PKToken") Is Nothing Then
            m_PKTokenValue = Request.QueryString("PKToken").ToString
        End If
        If Not Request.QueryString("CostType") Is Nothing Then
            m_PKTokenCostType = Trim(Request.QueryString("CostType").ToString)
        End If
        If Not Request.QueryString("Fromdate") Is Nothing Then
            m_PKTokenFromDate = Trim(Request.QueryString("Fromdate").ToString)
        End If
        If Not Request.QueryString("Todate") Is Nothing Then
            m_PKTokenTodate = Trim(Request.QueryString("Todate").ToString)
        End If
        If m_PKTokenValue <> "" Then

            If (CommonFunctions.Security.Token.ValidateToken(CType(Session("intUserID"), String) + CType(m_PKTokenCostType, String) + CType(m_PKTokenFromDate, String) + CType(m_PKTokenTodate, String) + CType(0, String) + CType(0, String), m_PKTokenValue) = False) Then

                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue Attachment", 0, 0, "Issue ID", CType(m_PKTokenCostType, String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If

        End If
        ''End Of Addition By Vidya J ON 1 Feb 2016
        InitVariables()
    End Sub
    Protected Sub InitVariables()
        Dim objDr As IDataReader

        m_ProjectID = HttpContext.Current.Session("intProjectID").ToString()
        m_ProjectName = CType(HttpContext.Current.Session("StrProjectName"), String)

        objDr = CommonFunction.Data.GetDataReader("usp_sel_tbl_PM_Project_TaskCaseStructure " + m_ProjectID, MyBase.UseSQL)

        If objDr.Read Then
            m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(objDr("CurrencySymbol"), "").ToString()
        End If
        If m_CurrencySymbol = "" Then
            m_CurrencySymbol = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_SEL_Tbl_PM_Compnayinformation_Currency", MyBase.UseSQL), "").ToString()
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("FromDate")) = True Then
            If HttpContext.Current.Request.QueryString("FromDate").ToString() <> "" Then
                m_FromDate = HttpContext.Current.Request.QueryString("FromDate")
            Else
                m_FromDate = ""
            End If
        Else
            m_FromDate = ""
        End If

        If Not IsNothing(HttpContext.Current.Request.QueryString("ToDate")) = True Then
            If HttpContext.Current.Request.QueryString("ToDate").ToString() <> "" Then
                m_ToDate = HttpContext.Current.Request.QueryString("ToDate")
            Else
                m_ToDate = ""
            End If

        Else
            m_ToDate = ""
        End If


        m_CostType = HttpContext.Current.Request.QueryString("CostType")
        CommonFunction.Data.DisposeDataReader(objDr)
        If m_CostType = "ACTUALHOURS" Then
            strCostColumnName = "Actual Hours"
        End If

        If m_CostType = "ACTUALCOST" Then
            strCostColumnName = "Accrued Revenue"
        End If

        If m_CostType = "PEOPLECOSTS" Then
            strCostColumnName = "People Cost"
        End If

        If m_CostType = "EXPENSES" Then
            strCostColumnName = "Expenses and Direct Project Cost"
        End If

        If m_CostType = "BILLABLE_EXPENSES" Then
            strCostColumnName = "Accrued Billable Expenses"
        End If

        If m_CostType = "CUMULATIVE_ACTUALHOURS" Then
            strCostColumnName = "Actual Hours"
        End If

        If m_CostType = "CUMULATIVE_ACTUALCOST" Then
            strCostColumnName = "Accrued Revenue"
        End If

        If m_CostType = "CUMULATIVE_PEOPLECOSTS" Then
            strCostColumnName = "People Cost"
        End If

        If m_CostType = "CUMULATIVE_EXPENSES" Then
            strCostColumnName = "Expenses and Direct Project Cost"
        End If

        If m_CostType = "CUMULATIVE_BILLABLE_EXPENSES" Then
            strCostColumnName = "Accrued Billable Expenses"
        End If


        If m_CostType = "CUMULATIVE_MILESTONE_REVENUE" Then
            strCostColumnName = "Accrued Revenue"
        End If

        If m_CostType = "MILESTONE_REVENUE" Then
            strCostColumnName = "Accrued Revenue"
        End If

        ObjdsResourceDtls = CommonFunction.Data.GetDataSet("usp_sel_Resource_Profitability_Details " + m_ProjectID + "," + IIf(m_FromDate = "", "Null", "'" + m_FromDate + "'").ToString() + "," + IIf(m_ToDate = "", "Null", "'" + m_ToDate + "'").ToString() + ",'" + m_CostType + "'", "CostHead", , , MyBase.UseSQL)

    End Sub

    Protected Sub InitPage()
        '        Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        

        Dim sbHTML As New System.Text.StringBuilder("")

        strMenu = InitializeMenu()

        'Top Menu
        sbHTML.Append(strMenu)


        sbHTML.Append("<br><TABLE id='tblNote'  cellspacing=0 cellpadding=0 Width='99.9%'    class=clsTable>")
        sbHTML.Append("<TR class=clsTRodd>")

        sbHTML.Append("<TD align=left>")
        If m_CostType.StartsWith("CUMULATIVE") Then
            sbHTML.Append("Period : Upto " + m_ToDate)
        Else
            sbHTML.Append("Period : " + m_FromDate + " To " + m_ToDate)
        End If
        sbHTML.Append("</TD>")

        If m_CostType <> "ACTUALHOURS" And m_CostType <> "CUMULATIVE_ACTUALHOURS" Then
            sbHTML.Append("<TD align=right >")
            sbHTML.Append("(All figures in project currency: " + m_CurrencySymbol + " )")
            sbHTML.Append("</TD>")
        End If

        sbHTML.Append("</Tr>")
        sbHTML.Append("</Table>")

        sbHTML.Append("<br>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString)

        Call ResourceDetails()

        sbHTML.Remove(0, sbHTML.Length)
        sbHTML.Append(strMenu)

        CommonFunctions.General.WriteHTML(sbHTML.ToString)

        'BOTTOM Menu

    End Sub




    Private Function InitializeMenu() As String
        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""


        ArrMenuCaptionsList.Add("Close")
        ArrMenuToolTipsList.Add("Close")
        ArrClientSideFunctionsList.Add("Close_OnClick()")

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

    Private Function GenerateNote() As String

        'Select Case m_CostType.ToUpper.Trim
        '    Case "ACTUALHOURS", "CUMULATIVE_ACTUALHOURS"
        '        strNote = "Actual Hours = Actual hour(s) filled by specific resouce(s) for the above period"

        '    Case "PEOPLECOSTS", "CUMULATIVE_PEOPLECOSTS"

        '        'strNote = "<br> People Cost = Actual hour(s) filled by specific resouce(s) for the above period *  Rate as per the cost method for the above period  * Project Currency conversion rate for the above period "
        '        strNote = "<br>Actual hours = Actual hour(s) filled by specific resouce(s) for the above period.<br>"
        '        strNote += "Rate = Rate as per the cost method(i.e. Standard Role Cost,Standard Resource Cost etc) for the above period.<br> "
        '        strNote += "People Cost = Actual hours * Rate * Project Currency conversion rate for the above period "

        '    Case "EXPENSES", "CUMULATIVE_EXPENSES"

        '        'strNote = "[ Expenses and Direct Project Cost = Billable and non-billable expense amount clamied against respective cost head which is  approved by finance approver for the above period * Project Currency conversion rate for the above period"

        '        strNote = "<br>Expense amount = Billable and non-billable expense amount clamied against respective cost head which is  approved by "
        '        strNote += "<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;finance approver for the above period."
        '        strNote += "<br>Expenses and Direct Project Cost = Expense amount * Project Currency conversion rate for the above period"


        '    Case "ACTUALCOST", "CUMULATIVE_ACTUALCOST"

        '        'strNote = "As per project commericial type (i.e.T&M By Role,T&M By Resource etc.) accrued revenue will be calculated. <br>"
        '        strNote = "<br>Actual Hours = Approved project timesheet hour(s) filled by specific resource(s) for the above period. <br>"
        '        strNote += "Rate = As per project commerical type (i.e.T&M By Role,T&M By Resource etc.) rate defined for specific resource(s). <br>"
        '        strNote += "Accrued Revenue = Actual Hours * Rate  * Project Currency conversion rate for the above period."

        '    Case "BILLABLE_EXPENSES", "CUMULATIVE_BILLABLE_EXPENSES"

        '        strNote = "<br>Expenses amount = Billable expense(s) amount clamied against respective cost head which is  approved by <br>finance approver for the above period."
        '        strNote += "<br> Accrued Billable Expenses = Expenses amount * Project Currency conversion rate for the above period"


        'End Select


        Select Case m_CostType.ToUpper.Trim
            Case "ACTUALHOURS", "CUMULATIVE_ACTUALHOURS"
                strNote = "Actual Hours = Actual hour(s) filled by specific resource(s) for the above period"

            Case "PEOPLECOSTS", "CUMULATIVE_PEOPLECOSTS"

                strNote = "<TABLE cellspacing=0 cellpadding=0 Width='99.9%'class=clsTable><TR class=clsTRPageHeader><TD>Actual hours</TD><TD> = Actual hour(s) filled by specific resource(s) for the above period.</TD></TR>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Rate</TD><TD valign=top> = Rate as per the cost method(i.e. Standard Role Cost,Standard Resource Cost etc) for the above period.</TD></TR> "
                strNote += "<TR class=clsTRPageHeader><TD valign=top>People Cost</TD><TD valign=top> = Actual hours * Rate * Project Currency conversion rate for the above period </TD></TR>"
                strNote += "</TABLE>"

            Case "EXPENSES", "CUMULATIVE_EXPENSES"

                strNote = "<TABLE cellspacing=0 cellpadding=0 Width='99.9%'class=clsTable>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Expense amount</TD><TD valign=top> = Billable and non-billable expense amount clamied against respective cost head which is  approved by &nbsp;&nbsp;&nbsp;finance approver for the above period.</TD></TR>"
                'strNote += "&nbsp;&nbsp;&nbsp;&nbsp;finance approver for the above period.</TD></TR>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Expenses and <BR>Direct Project Cost </TD><TD valign=top>= Expense amount * Project Currency conversion rate for the above period</TD></TR>"
                strNote += "</TABLE>"

            Case "ACTUALCOST", "CUMULATIVE_ACTUALCOST"

                strNote = "<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Actual Hours</TD><TD valign=top> = Approved project timesheet hour(s) filled by specific resource(s) for the above period.</TD></TR>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Rate</TD><TD valign=top>= As per project commerical type (i.e.T&M By Role,T&M By Resource etc.) rate defined for specific resource(s).</TD></TR>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Accrued Revenue</TD><TD valign=top> = Actual Hours * Rate  * Project Currency conversion rate for the above period.</TD></TR>"
                strNote += "</TABLE>"

            Case "BILLABLE_EXPENSES", "CUMULATIVE_BILLABLE_EXPENSES"

                strNote = "<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>"
                strNote = "<TR class=clsTRPageHeader><TD valign=top>Expenses amount</TD><TD valign=top> = Billable expense(s) amount clamied against respective cost head which is  approved by finance &nbsp;&nbsp;&nbsp; approver for the above period.</TD></TR>"
                strNote += "<TR class=clsTRPageHeader><TD valign=top>Accrued Billable<BR> Expenses</TD><TD valign=top> = Expenses amount * Project Currency conversion rate for the above period</TD></TR>"
                strNote += "</TABLE>"

        End Select



        GenerateNote = strNote

    End Function

    Private Sub ResourceDetails()
        Dim strClass As String = "clsTREven"
        Dim sbHTML As New System.Text.StringBuilder("")
        Dim decTotalCost As Decimal
        Dim dtToDate As String
        decTotalCost = 0

        sbHTML.Append("<TABLE id='tblDtl'  cellspacing=0 cellpadding=0 Width='99.9%'class=clsTable>")
        sbHTML.Append("<TR class=clsTREven width=99.9%>")
        sbHTML.Append("<TD align=left width=25%> ")
        sbHTML.Append("Project Name : ")
        'sbHTML.Append("<TD align=Left> ")
        sbHTML.Append(m_ProjectName)
        sbHTML.Append("</TD>")
        sbHTML.Append("</TR>")
        sbHTML.Append("</TABLE>")
        sbHTML.Append("<BR>")

        ''CommonFunctions.General.WriteHTML("<TR class=clsTREven width=99.9%>")
        ''CommonFunctions.General.WriteHTML("<TD align=right> ")
        ''CommonFunctions.General.WriteHTML(strCostColumnName)
        ''CommonFunctions.General.WriteHTML(" As On : ")
        ''CommonFunctions.General.WriteHTML("</TD>")

        ''CommonFunctions.General.WriteHTML("<TD align=Left>")
        ''CommonFunctions.General.WriteHTML(CommonFunctions.Dates.CGetDate(CType(m_ToDate, Date)))
        ''CommonFunctions.General.WriteHTML("</TD>")
        ''CommonFunctions.General.WriteHTML("</TR>")



        sbHTML.Append("<TABLE id='tblDtl1'  cellspacing=0 cellpadding=0 Width='99.9%'class=clsTable>")
        sbHTML.Append("<TR class=clsTRPageHeader width=99.9%>")
        sbHTML.Append("<TD align=Left colspan=2> ")
        sbHTML.Append("<B>Note : </B> " + GenerateNote())
        sbHTML.Append("</TD></TR>")


        sbHTML.Append("</TABLE>")
        sbHTML.Append("<BR>")
        sbHTML.Append("<BR>")

        sbHTML.Append("<div id='DivMain' style='width:99.99%;height:90.9%;overflow:auto;'>")
        sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%'>")
        sbHTML.Append("<tr class='clsTRColumnHeader'>")

        sbHTML.Append("<td nowrap align=left >")
        If m_CostType = "EXPENSES" Or m_CostType = "BILLABLE_EXPENSES" Or m_CostType = "CUMULATIVE_EXPENSES" Or m_CostType = "CUMULATIVE_BILLABLE_EXPENSES" Then
            sbHTML.Append("Cost Heads")
        ElseIf m_CostType = "MILESTONE_REVENUE" Or m_CostType = "CUMULATIVE_MILESTONE_REVENUE" Then
            sbHTML.Append("Milestones")
        Else
            sbHTML.Append("Resources")
        End If
        sbHTML.Append("</td>")

        sbHTML.Append("<td nowrap align=right >")

        sbHTML.Append(strCostColumnName)
        sbHTML.Append("</td>")
        sbHTML.Append("</tR>")

        For Each drRes As DataRow In ObjdsResourceDtls.Tables(0).Select("", "ToDate asc")
            sbHTML.Append("<tr class=" + strClass + ">")
            sbHTML.Append("<td nowrap align=left >")
            If m_CostType = "EXPENSES" Or m_CostType = "BILLABLE_EXPENSES" Or m_CostType = "CUMULATIVE_EXPENSES" Or m_CostType = "CUMULATIVE_BILLABLE_EXPENSES" Then
                sbHTML.Append(drRes("CostHeads"))
            ElseIf m_CostType = "MILESTONE_REVENUE" Or m_CostType = "CUMULATIVE_MILESTONE_REVENUE" Then
                sbHTML.Append(drRes("Milestone"))
            Else
                sbHTML.Append(drRes("EmployeeName"))
            End If
            sbHTML.Append("</td>")

            sbHTML.Append("<td nowrap align=right >")
            If m_CostType = "EXPENSES" Or m_CostType = "BILLABLE_EXPENSES" Or m_CostType = "CUMULATIVE_EXPENSES" Or m_CostType = "CUMULATIVE_BILLABLE_EXPENSES" Then
                sbHTML.Append(FormatNumber(drRes("Expense")))
                decTotalCost = decTotalCost + CType(drRes("Expense"), Decimal)
            ElseIf m_CostType = "MILESTONE_REVENUE" Or m_CostType = "CUMULATIVE_MILESTONE_REVENUE" Then
                sbHTML.Append(FormatNumber(drRes("MilestoneCost")))
                decTotalCost = decTotalCost + CType(drRes("MilestoneCost"), Decimal)
            Else
                sbHTML.Append(FormatNumber(drRes("ResourceCost"), 2))
                decTotalCost = decTotalCost + CType(drRes("ResourceCost"), Decimal)
            End If

            sbHTML.Append("</td>")

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
        Next
        sbHTML.Append("</tr>")
        sbHTML.Append("<tr class='clsTRColumnHeader'>")
        sbHTML.Append("<td nowrap align=left width=25%><b>Total</b>  ")
        sbHTML.Append("</td>")
        sbHTML.Append("<td nowrap align=right width=25%><b>")
        If m_CostType <> "ACTUALHOURS" Then
            sbHTML.Append(m_CurrencySymbol)
        End If
        sbHTML.Append(" ")
        sbHTML.Append(FormatNumber(decTotalCost.ToString()))
        sbHTML.Append("</b></td>")
        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        sbHTML.Append("<BR>")
        sbHTML.Append("</div>")


        CommonFunction.General.WriteHTML(sbHTML.ToString())
        sbHTML = Nothing
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        If Not IsNothing(ObjdsResourceDtls) = True Then
            ObjdsResourceDtls = Nothing
        End If
    End Sub
End Class
