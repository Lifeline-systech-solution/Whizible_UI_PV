Public Class Profitability_ResourcePool
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

    Protected m_ResourcePoolID As String = "0"
    Protected m_ProjectID As String = "0"
    Protected m_ProjectName As String = ""
    Protected m_RoleID As String = "0"
    Protected m_Role As String = ""
    Protected ObjdsProjRes As DataSet
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected strMenu As String

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        InitVariables()
    End Sub

    Protected Sub InitPage()
        'Dim cObjSectionTitle As New WebPage.Templates.SectionTitle
        


        Dim arrMenu() As String = {"Close", "?"}
        Dim arrMenuToolTip() As String = {"Close", "Help"}
        Dim arrCSFunction() As String = {"Close_OnClick()", "OpenHelpPage('Resource Contribution')"}
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        'Top Menu
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Resource Contribution", , , True))

        CommonFunctions.General.WriteHTML("<br>")

        Call DrawFilters()
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML("<div id='DivMain' style='width:99.99%;overflow:auto;'>")
        Call DrawProjectProfitability_ResPool()
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(strMenu)


    End Sub

    Protected Sub DrawFilters()
        'CommonFunction.General.WriteHTML("<div id='DivDetails' style='width:99.99%;height:20%;overflow:auto;'>")
        CommonFunction.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding='1' style='width:99.99%' >")

        'Project Filter
        CommonFunction.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Project Name :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("lstProjectName", "usp_Sel_ProfitabilityAccess_Project " + m_ResourcePoolID, 200, m_ProjectID, "onchange = javascript:Filter_Onclick()", True, True))
        CommonFunction.General.WriteHTML("</td>")

        'Role Filter
        CommonFunction.General.WriteHTML("<td style='text-align:right' >")
        CommonFunction.General.WriteHTML("Role :")
        CommonFunction.General.WriteHTML("</td>")
        CommonFunction.General.WriteHTML("<td style='text-align:left' >&nbsp;")
        CommonFunction.General.WriteHTML(CommonFunctions.HTMLControls.DrawComboBox("lstRole", "usp_Sel_ProfitabilityAccess_Role " + m_ResourcePoolID, 200, m_RoleID, "onchange = javascript:Filter_Onclick()", True, True))
        CommonFunction.General.WriteHTML("</td>")

        CommonFunction.General.WriteHTML("</tr>")

        CommonFunction.General.WriteHTML("</table>")
        'CommonFunction.General.WriteHTML("</div>")

    End Sub
    Protected Sub InitVariables()
     
        If Not IsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID")) = True Then
            If HttpContext.Current.Request.QueryString("ResourcePoolID").ToString() <> "" Then
                m_ResourcePoolID = HttpContext.Current.Request.QueryString("ResourcePoolID")
            Else
                m_ResourcePoolID = HttpContext.Current.Request.Form("txtResourcePoolID")
            End If
        End If
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtResourcePoolID", "txtResourcePoolID", , , , m_ResourcePoolID, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding

        If Not Request.QueryString("RoleID") Is Nothing AndAlso Request.QueryString("RoleID") <> "" Then
            m_RoleID = Request.QueryString("RoleID")
        ElseIf Not Request.Form("lstRole") Is Nothing AndAlso Request.Form("lstRole") <> "" Then
            m_RoleID = Request.Form("lstRole")
        Else
            m_RoleID = "null"
        End If

        If Not Request.QueryString("ProjectID") Is Nothing AndAlso Request.QueryString("ProjectID") <> "" Then
            m_ProjectID = Request.QueryString("ProjectID")
        ElseIf Not Request.Form("lstProjectName") Is Nothing AndAlso Request.Form("lstProjectName") <> "" Then
            m_ProjectID = Request.Form("lstProjectName")
        Else
            m_ProjectID = "null"
        End If

        ObjdsProjRes = CommonFunction.Data.GetDataSet("usp_sel_ResourcePool_ProjectProfitability " + m_ResourcePoolID + "," + m_ProjectID + "," + m_RoleID, "tbl_PM_Project", , , MyBase.UseSQL)

    End Sub
    Public Sub DrawProjectProfitability_ResPool()

        Dim strEmployeeName As String = ""
        Dim strProjectName As String = ""
        Dim sbHTML As New System.Text.StringBuilder("")
        Dim NumberOfColumns As Long = 0
        Dim TotalCost As Double
        Dim strfilterstring As String = ""
        Dim strfilteroption As String = ""

        sbHTML.Append("<table  class='clsGridTable'cellpadding=0 cellspacing=1 style='width:99.99%'>")
        sbHTML.Append("<tr class='clsTRColumnHeader'>")

        If CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0") = "0" Or Request.QueryString("ProjectID") = "" Then
            strfilterstring = "Resource"
            strfilteroption = "EmployeeName"
        Else
            strfilterstring = "Project"
            strfilteroption = "ProjectName"
        End If

        sbHTML.Append("<td nowrap style='text-align:Left'  >")
        sbHTML.Append(strfilterstring)
        sbHTML.Append("</td>")

        sbHTML.Append("<td nowrap  style='text-align:Left' >")
        If strfilterstring = "Resource" Then
            sbHTML.Append("Project")
        Else
            sbHTML.Append("Resource")
        End If
        sbHTML.Append("</td>")

        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Efforts (hrs)")
        sbHTML.Append("</td>")


        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Accrued Revenue")
        sbHTML.Append("</td>")

        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Accrued Cost")
        sbHTML.Append("</td>")

        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Contribution")
        sbHTML.Append("</td>")

        sbHTML.Append("<td nowrap  style='text-align:right' >")
        sbHTML.Append("Contribution %")
        sbHTML.Append("</td>")

        sbHTML.Append("</tr>")

        If ObjdsProjRes.Tables(0).Select("", "EmployeeName asc").Length <> 0 Then
            For Each drCost As DataRow In ObjdsProjRes.Tables(0).Select("", "EmployeeName asc")

                If strEmployeeName <> drCost(strfilteroption).ToString Then
                    sbHTML.Append("<tr class=clsTREven>")
                    sbHTML.Append("<td nowrap  style='text-align:left' colspan=7 >")
                    sbHTML.Append(drCost(strfilteroption))
                    sbHTML.Append("</td>")
                    sbHTML.Append("</tr>")
                    sbHTML.Append("<tr class=clsTROdd>")
                Else
                    sbHTML.Append("<tr class=clsTROdd>")
                End If
                sbHTML.Append("<td nowrap  style='text-align:left' >")
                sbHTML.Append("&nbsp;")
                sbHTML.Append("</td>")


                sbHTML.Append("<td nowrap  style='text-align:left' >")
                If strfilterstring = "Resource" Then
                    sbHTML.Append(drCost("ProjectName"))
                Else
                    sbHTML.Append(drCost("EmployeeName"))
                End If
                sbHTML.Append("</td>")

                sbHTML.Append("<td nowrap  style='text-align:right' >")
                sbHTML.Append(FormatNumber(CommonFunction.Data.CheckIsDBNull(drCost("AccruedEfforts"), "0"), 2))

                sbHTML.Append("</td>")

                sbHTML.Append("<td nowrap  style='text-align:right' >")
                sbHTML.Append(drCost("CurrencySymbol").ToString() + " " + FormatNumber(CommonFunction.Data.CheckIsDBNull(drCost("AccruedRevenue"), "0"), 2) + " ")
                'sbHTML.Append(drCost("CurrencySymbol"))
                sbHTML.Append("</td>")

                sbHTML.Append("<td nowrap  style='text-align:right' >")
                sbHTML.Append(drCost("CurrencySymbol").ToString() + " " + FormatNumber(CommonFunction.Data.CheckIsDBNull(drCost("ResourceCurrencyCost"), "0"), 2) + " ")
                'sbHTML.Append(drCost("CurrencySymbol"))
                sbHTML.Append("</td>")

                sbHTML.Append("<td nowrap  style='text-align:right' >")
                sbHTML.Append(drCost("CurrencySymbol").ToString() + " " + FormatNumber(CommonFunction.Data.CheckIsDBNull(drCost("ResourceContribution"), "0"), 2) + " ")
                'sbHTML.Append(drCost("CurrencySymbol"))
                sbHTML.Append("</td>")


                sbHTML.Append("<td nowrap  style='text-align:right' >")

                If CType(CommonFunction.Data.CheckIsDBNull(drCost("AccruedRevenue"), "0"), Double) <> 0 Then
                    sbHTML.Append(FormatNumber(CommonFunction.Data.CheckIsDBNull(drCost("ResourceContributionPercent"), "0"), 2) + " ")
                Else
                    sbHTML.Append(" 0.00")
                End If

                sbHTML.Append("</td>")

                strEmployeeName = drCost(strfilteroption).ToString

            Next
        Else
            sbHTML.Append("<tr class=clsTREven>")
            sbHTML.Append("<td nowrap align=center colspan=7>")
            sbHTML.Append("There are no items to show in this view.")
            sbHTML.Append("</td>")
        End If

        sbHTML.Append("</tr>")
        sbHTML.Append("</table>")
        CommonFunction.General.WriteHTML(sbHTML.ToString)
        ObjdsProjRes = Nothing
    End Sub

End Class

