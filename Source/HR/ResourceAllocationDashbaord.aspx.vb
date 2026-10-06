Imports System.Text
Public Class ResourceAllocationDashbaord
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region


#Region "Form Variables"
    Protected m_FinancialPeriod As String '= "M" 'commented by RohiniK on 7 Sep 09 for S2 Customization : Export to Excel Feature
    Protected m_fromDate As String = CommonFunction.Dates.GetDate(Date.Today.Date)
    Protected m_ToDate As String = CommonFunction.Dates.GetDate(Date.Today.Date)

    Protected m_EmployeeId As String = "0"
    Protected m_FinancialPeriodCount As Long = 0
    Protected m_PageNo As Integer = 1
    Protected m_PageSize As Integer = 100
    Protected m_MaxPageno As Integer = 0
    Protected m_MaxRows As Integer = 0
    Dim intcntDistinctTitle As Integer = 0
    Dim dsRAD As DataSet
    Dim dsResourceDetails As DataSet
    Dim m_strMode As String = ""
    Dim strEmployeeName As String = ""
    Protected M_BusinessGroupID As String = "0"
    Protected M_LocationID As String = "0"
    Protected M_roleID As String = "0"
    Protected M_GradeId As String = "0"
    Protected M_EmployeeName As String = ""
    Protected M_Deployable As String = ""
    Protected M_AllocationPercentage As String = ""
    Protected m_specificDate As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
        ''Added by Shamkant S  on 16/02/2016 to validate Token
        If (Request.QueryString("Token") <> "" And Request.QueryString("EmployeeID") <> "" And Request.QueryString("FinancialPeriodCount") <> "" And Request.QueryString("SpecificDate") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("FinancialPeriodCount"), String) + CType(Request.QueryString("SpecificDate"), String) + "0" + "0", Request.QueryString("Token")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''Added by Nilesh g on 3/3/2016 for validate Token 
        If Request.QueryString("FROM") = "RESOURCE" Then
            If (Request.QueryString("PKToken") <> "" And Request.QueryString("EmployeeId") <> "" And Request.QueryString("FinancialType") <> "" And Request.QueryString("FinancialPeriodCount") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("EmployeeID"), String) + CType(Request.QueryString("FinancialType"), String) + CType(Request.QueryString("FinancialPeriodCount"), String) + "0" + "0", Request.QueryString("PKToken")) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("EmployeeId"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        ''end of Added by Nilesh g on 3/3/2016 for validate Token 
        ''End of addiotion by Shamkant S  on 16/02/2016 to validate Token
        ' ''commented by nilesh g on 31/12/2015 for Security
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''end of commented by nilesh g on 31/12/2015 for Security

    End Sub
    '' added by Nilesh g on 29-Jan-2016 to generate token	
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_RequestShow_TaskType(employeeId As String, FinancialPeriod As String, FinancialPeriodCount As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        employeeId = Utilities.Security.SecurityBuilder.CheckUserInput(employeeId, 2, True, False, False)
        FinancialPeriod = Utilities.Security.SecurityBuilder.CheckUserInput(FinancialPeriod, 2, True, False, False)
        FinancialPeriodCount = Utilities.Security.SecurityBuilder.CheckUserInput(FinancialPeriodCount, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(employeeId, String) + CType(FinancialPeriod, String) + CType(FinancialPeriodCount, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_EmployeeId(stremployeeid As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        stremployeeid = Utilities.Security.SecurityBuilder.CheckUserInput(stremployeeid, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(stremployeeid, String) + "0" + "0")
            Return m_PKToken_Request_Multiple

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''End of  added by Nilesh g on 29-Jan-2016 to generate token

    Protected Sub InitVariables()
        Dim dr As IDataReader
        Dim sbstrSQL As New StringBuilder
        Dim strCurrentEmployee As String = ""

        If Not IsNothing(HttpContext.Current.Request.QueryString("Mode")) = True Then
            m_strMode = HttpContext.Current.Request.QueryString("Mode").ToString()
        Else
            m_strMode = ""
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboFinancialType")) = True Then
            m_FinancialPeriod = HttpContext.Current.Request.Form("cboFinancialType").ToString()
        ElseIf Not IsNothing(HttpContext.Current.Request.QueryString("FinancialType")) = True Then
            m_FinancialPeriod = HttpContext.Current.Request.QueryString("FinancialType").ToString()
        Else
            ''added by RohiniK on 3 Sep 09 for S2 Customization : Export to Excel Feature
            If m_FinancialPeriod = "" Then
                m_FinancialPeriod = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("EXEC usp_SEL_DefaultFinancialType", MyBase.UseSQL), ""))
            End If
            ''End of addition by RohiniK on 3 Sep 09 for S2 Customization : Export to Excel Feature

        End If

        If Not IsNothing(HttpContext.Current.Request.Form("TxtFinancialPeriodCount")) = True Then
            m_FinancialPeriodCount = HttpContext.Current.Request.Form("TxtFinancialPeriodCount").ToString()
        ElseIf Not IsNothing(HttpContext.Current.Request.QueryString("FinancialPeriodCount")) = True Then
            m_FinancialPeriodCount = HttpContext.Current.Request.QueryString("FinancialPeriodCount").ToString()
        Else
            m_FinancialPeriodCount = 0
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboEmployee")) = True Then
            m_EmployeeId = HttpContext.Current.Request.Form("cboEmployee").ToString()
        ElseIf Not IsNothing(HttpContext.Current.Request.QueryString("EmployeeId")) = True Then
            m_EmployeeId = HttpContext.Current.Request.QueryString("EmployeeId").ToString()
        Else
            m_EmployeeId = 0
        End If


        If Not IsNothing(HttpContext.Current.Request.QueryString("SpecificDate")) = True Then
            m_specificDate = HttpContext.Current.Request.QueryString("SpecificDate").ToString()
            'If m_FinancialPeriodCount <> 0 Then
            '    m_specificDate = ""
            'End If
        End If
        'ElseIf Not IsNothing(HttpContext.Current.Request.Form("txtFromDate")) = True Then
        '    m_specificDate = HttpContext.Current.Request.Form("txtFromDate").ToString()
        '    If m_FinancialPeriodCount = 0 Then
        '        m_specificDate = ""
        '    End If
        'End If

        dr = CommonFunction.Data.GetDataReader("usp_SEL_FromAndToDates_ForReasourceAllocation '" + m_FinancialPeriod.ToString() + "','" + m_FinancialPeriodCount.ToString() + "'" + IIf(m_specificDate = "", " , null ", ",'" + m_specificDate + "'"), MyBase.UseSQL)


        If dr.Read() Then
            m_fromDate = CommonFunction.Dates.GetDate(dr("FromDate"))
            m_ToDate = CommonFunction.Dates.GetDate(dr("ToDate"))
            intcntDistinctTitle = dr("DistinctDays")
        End If

        CommonFunction.Data.DisposeDataReader(dr)

        If Not IsNothing(HttpContext.Current.Request.Form("TxtPageNo")) = True Then
            m_PageNo = HttpContext.Current.Request.Form("TxtPageNo").ToString()
        Else
            m_PageNo = 1
        End If

        ' Collect Filters
        If Not IsNothing(HttpContext.Current.Request.Form("cboBusinessGroup")) = True Then
            M_BusinessGroupID = HttpContext.Current.Request.Form("cboBusinessGroup")
        Else
            M_BusinessGroupID = "0"
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboLocation")) = True Then
            M_LocationID = HttpContext.Current.Request.Form("cboLocation")
        Else
            M_LocationID = "0"
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboRole")) = True Then
            M_roleID = HttpContext.Current.Request.Form("cboRole")
        Else
            M_roleID = "0"
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboGrade")) = True Then
            M_GradeId = HttpContext.Current.Request.Form("cboGrade")
        Else
            M_GradeId = "0"
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("txtEmployeeName")) = True Then
            M_EmployeeName = HttpContext.Current.Request.Form("txtEmployeeName")
        Else
            M_EmployeeName = ""
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboDeployable")) = True Then
            M_Deployable = HttpContext.Current.Request.Form("cboDeployable")
        Else
            M_Deployable = ""
        End If

        If Not IsNothing(HttpContext.Current.Request.Form("cboAllocationPercentage")) = True Then
            M_AllocationPercentage = HttpContext.Current.Request.Form("cboAllocationPercentage")
        Else
            M_AllocationPercentage = "0"
        End If

        ' end Collect Filters

        '' commented and added by RohiniK on 1 Sep 09 for S1 Customization
        'If m_strMode = "" Then
        If m_strMode = "" Or (m_strMode.ToUpper = "PRINT" And m_EmployeeId = "0") Then
            '' End of comment and addition by RohiniK on 1 Sep 09 for S1 Customization
            sbstrSQL.Append("usp_SEL_ResourceAllocation_Dashboard ")
        ElseIf m_strMode = "RESOURCE" Then
            sbstrSQL.Append("usp_SEL_ResourceAllocation_Dashboard_ResourceDetails ")
            ''added by RohiniK on 1 Sep 09 for S1 Customization
        ElseIf m_EmployeeId <> "0" Then
            sbstrSQL.Append("usp_SEL_ResourceAllocation_Dashboard_ResourceDetails ")
            ''End of addition  by RohiniK on 1 Sep 09 for S1 Customization
        End If

        sbstrSQL.Append(HttpContext.Current.Session("intUserID").ToString())
        sbstrSQL.Append(",'")

        sbstrSQL.Append(HttpContext.Current.Session("LoginType").ToString())
        sbstrSQL.Append("','")

        sbstrSQL.Append(CommonFunction.General.BuildQueryString(HttpContext.Current.Session("strUserName").ToString()))
        sbstrSQL.Append("',")

        sbstrSQL.Append(HttpContext.Current.Session("intLoginID").ToString())
        sbstrSQL.Append(",'")
        sbstrSQL.Append(m_FinancialPeriod)
        sbstrSQL.Append("','")
        sbstrSQL.Append(m_fromDate)
        sbstrSQL.Append("','")
        sbstrSQL.Append(m_ToDate)
        sbstrSQL.Append("'")
        ''commented and added by RohiniK on 1 Sep 09 for S1 Customization
        'If m_strMode = "" Then
        If m_strMode = "" Or (m_strMode.ToUpper = "PRINT" And m_EmployeeId = "0") Then
            ''End of comment and addition by RohiniK on 1 Sep 09 for S1 Customization

            sbstrSQL.Append(",")
            If M_BusinessGroupID = "0" Or M_BusinessGroupID = "" Then
                sbstrSQL.Append(" Null ")
            Else
                sbstrSQL.Append(M_BusinessGroupID)
            End If

            sbstrSQL.Append(",")
            If M_LocationID = "0" Or M_LocationID = "" Then
                sbstrSQL.Append(" Null ")
            Else
                sbstrSQL.Append(M_LocationID)
            End If

            sbstrSQL.Append(",")
            If M_roleID = "0" Or M_roleID = "" Then
                sbstrSQL.Append(" Null ")
            Else
                sbstrSQL.Append(M_roleID)
            End If

            sbstrSQL.Append(",")
            If M_GradeId = "0" Or M_GradeId = "" Then
                sbstrSQL.Append(" Null ")
            Else
                sbstrSQL.Append(M_GradeId)
            End If

            If Trim(M_EmployeeName) = "" Then
                sbstrSQL.Append(",")
                sbstrSQL.Append(" Null ")
                sbstrSQL.Append(" ")
            Else
                sbstrSQL.Append(",'")
                sbstrSQL.Append(Trim(CommonFunction.General.BuildQueryString(M_EmployeeName)))
                sbstrSQL.Append("'")
            End If

            If M_Deployable = "" Then
                sbstrSQL.Append(",")
                sbstrSQL.Append(" Null ")

            Else
                sbstrSQL.Append(",'")
                sbstrSQL.Append(M_Deployable)
                sbstrSQL.Append("'")
            End If

            sbstrSQL.Append(",")
            If M_AllocationPercentage = "0" Or M_AllocationPercentage = "" Then
                sbstrSQL.Append(" Null ")
            Else
                sbstrSQL.Append(M_AllocationPercentage)
            End If
        Else ' Resource Details View 
            sbstrSQL.Append(",")
            sbstrSQL.Append(m_EmployeeId)
        End If

        ''added by RohiniK on 1 Sep 09 for S1 Customization
        If m_strMode = "" Then
            Session("GridSQL") = sbstrSQL
        End If
        
        If m_strMode.ToUpper = "PRINT" Then
            If Session("GridSQL").ToString <> "" And m_EmployeeId = "0" Then
                sbstrSQL = CType(Session("GridSQL"), StringBuilder)
            End If
        End If
        ''End of addition by RohiniK on 1 Sep 09 for S1 Customization
        'Added by SanaS on 17-Nov-2009 for Export to excel issue from Probable resources Link
        If Session("GridSQL") Is Nothing Then
            Session("GridSQL") = sbstrSQL
        ElseIf Session("GridSQL").ToString = "" Then
            Session("GridSQL") = sbstrSQL
        End If
        'End Addition by SanaS on 17-Nov-2009 for Export to excel issue from Probable resources Link
        '        If m_strMode = "" Then
        dsRAD = CommonFunction.Data.GetDataSet(sbstrSQL.ToString(), "RAD", m_MaxRows, (m_PageNo - 1) * m_PageSize * intcntDistinctTitle, m_PageSize * intcntDistinctTitle, MyBase.UseSQL)
        If m_MaxRows <> 0 Then
            m_MaxPageno = Math.Ceiling((m_MaxRows / (m_PageSize * intcntDistinctTitle)))
        End If
        'ElseIf m_strMode = "RESOURCE" Then
        'dsRAD = CommonFunction.Data.GetDataSet(sbstrSQL.ToString(), "RAD", m_MaxRows, m_PageNo, m_PageSize, MyBase.UseSQL)
        'If m_MaxRows <> 0 Then
        '    m_MaxPageno = Math.Ceiling((m_MaxRows / (m_PageSize)))
        'End If

        'End If

        strEmployeeName = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_SEL_Tbl_PM_employeeName " + m_EmployeeId.ToString(), MyBase.UseSQL), ""))

        sbstrSQL = Nothing
    End Sub
    '' added by RohiniK on 1 Sep 09 for S1 Customization
    Protected Sub ExporttoExcel(ByVal sbHTML As StringBuilder)
        '====================================================================
        ' Procedure Name        : ExporttoExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export the report in Excel Format
        ' Description           : To export the report in Excel Format
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RohiniK
        ' Created               : 1 Sep 2009
        ' Revisions             :
        '=====================================================================
        Dim strCode, strCode1 As String
        Dim intSearchCount As Integer
        Dim strcodeBuilder As New StringBuilder

        strCode = sbHTML.ToString
        Dim strsearch As String = "<td class=clsTDColumnSeparator width=1pt></td>"
        strcodeBuilder.Append(strCode)
        strcodeBuilder = strcodeBuilder.Replace("<table", "<TABLE style=""FONT-SIZE: 8pt"" border=1 ")
        strcodeBuilder = strcodeBuilder.Replace("<img src='../../Images/minus.gif' border=0>", "")
        strcodeBuilder = strcodeBuilder.Replace(strsearch, "")
        strcodeBuilder = strcodeBuilder.Replace("<TD  align=left ", "<TD  align=left ><B")
        strcodeBuilder = strcodeBuilder.Replace("<TD  align=right ", "<TD  align=right ><B")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=7 align=center>", "<TD colspan=7 align=center><B>")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=3 align=center>", "<TD colspan=3 align=center><B>")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=8 align=center>", "<TD colspan=8 align=center><B>")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=2 align=center>", "<TD colspan=2 align=center><B>")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=6 align=center>", "<TD colspan=6 align=center><B>")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=1 align=center>", "<TD colspan=1 align=center><B>")
        strcodeBuilder = strcodeBuilder.Replace("<TD colspan=1 align=left>", "<TD colspan=29 align=left><B>")
        Dim intStart, intEnd, intLength As Integer
        strCode = strcodeBuilder.ToString
        strcodeBuilder.Remove(0, strcodeBuilder.Length)
        PrintExcelDoc(strCode)
    End Sub
    Protected Sub PrintExcelDoc(ByVal query As String)
        '====================================================================
        ' Procedure Name        : PrintExcelDoc
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export the report in Excel Format
        ' Description           : To export the report in Excel Format
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RohiniK
        ' Created               : 1 Sep 2009
        ' Revisions             :
        '=====================================================================
        Dim strBody As New System.Text.StringBuilder("")


        strBody.Append("<html " & _
          "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
          "xmlns:w='urn:schemas-microsoft-com:office:Excel'" & _
          "xmlns='http://www.w3.org/TR/REC-html40'>" & _
          "<head><title>Time</title>")

        'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
        strBody.Append("<!--[if gte mso 9]>" & _
         "<xml>" & _
         "<w:ExcelDocument>" & _
         "<w:View>Print</w:View>" & _
         "<w:Zoom>90</w:Zoom>" & _
         "<w:DoNotOptimizeForBrowser/>" & _
         "</w:ExcelDocument>" & _
         "</xml>" & _
         "<![endif]-->")

        strBody.Append("<style>" & _
           "<!-- /* Style Definitions */" & _
           "@page Section1" & _
           "   {size:8.5in 12in; " & _
           "   margin:0.5in 0.5in 0.5in 0.5in ; " & _
           "   mso-header-margin:.5in; " & _
           "   mso-footer-margin:.5in; mso-paper-source:0;size:landscape;}" & _
           " div.Section1" & _
           "   {page:Section1;}" & _
           "-->" & _
          "</style></head>")

        strBody.Append("<body lang=EN-US style='tab-interval:.5in'>" & _
          "<div class=Section1><font face='Verdana' size=10><pre>" & query.ToString & "</pre></font></div></body></html>")
        strBody = strBody.Replace("�", "-")
        strBody = strBody.Replace("�", "'")
        strBody = strBody.Replace("�", "'")
        Dim m_filepath As String
        Dim Logfile As String
        m_filepath = Server.MapPath("../../Reports/")
        Logfile = CommonFunctions.FileDirectory.GetUniqueFileName("XLS")
        CommonFunctions.FileDirectory.WriteFileStream(m_filepath, Logfile, strBody.ToString)

        CommonFunctions.General.WriteHTML("<Script language=javascript>")
        CommonFunctions.General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + Logfile + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"");")
        CommonFunctions.General.WriteHTML("window.close();")
        CommonFunctions.General.WriteHTML("</Script>")
    End Sub
    Protected Sub drawAllResourceViewExcel(ByRef sbHTML As StringBuilder)
        '====================================================================
        ' Procedure Name        : drawAllResourceViewExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To draw All Resource View for exporting to Excel file
        ' Description           : To draw All Resource View for exporting to Excel file
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RohiniK
        ' Created               : 1 Sep 2009
        ' Revisions             :
        '=====================================================================
        Dim strCurrentTitle As String = ""
        Dim strCurrentEmployee As String = ""
        Dim intRowCount As Long = 0
        Dim strCurrentEmployeeId As String = ""
        Dim projectTotal As String

        If dsRAD.Tables(0).Rows.Count <> 0 Then

            sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTML.Append("<thead class='clsTRColumnHeader'>")
            sbHTML.Append("<th style='text-align:left'>")
            sbHTML.Append("Employee Name")
            sbHTML.Append("</th>")

            For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("", "StartDate")
                If strCurrentTitle <> RADRowvalues("Title").ToString() Then
                    sbHTML.Append("<th  style='text-align:right'>")
                    sbHTML.Append(RADRowvalues("Title").ToString())
                    sbHTML.Append("</th>")
                    strCurrentTitle = RADRowvalues("Title").ToString()
                End If
            Next

            sbHTML.Append("<th style='text-align:right'>")
            sbHTML.Append("Average")
            sbHTML.Append("</th>")

            sbHTML.Append("</thead>")

            strCurrentEmployee = ""
            strCurrentTitle = ""
            For Each RADRow As DataRow In dsRAD.Tables(0).Select("", "EmployeeName")

                If strCurrentEmployeeId <> RADRow("EmployeeID").ToString() Then
                    If strCurrentEmployeeId <> "" Then
                        projectTotal = dsRAD.Tables(0).Compute("avg(ResourcePercentage)", "EmployeeId='" + strCurrentEmployeeId + "'")
                    End If

                    strCurrentEmployee = RADRow("EmployeeName").ToString()
                    strCurrentEmployeeId = RADRow("EmployeeId").ToString()
                    strCurrentTitle = ""
                    If intRowCount = 0 Then
                        sbHTML.Append("<tr class='clsTREvenRow'>")
                        intRowCount += 1
                    Else

                        sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentEmployee).Append("""> ")
                        If projectTotal <> "" And projectTotal <> "0" Then
                            sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False).ToString())
                        Else
                            sbHTML.Append("0")
                        End If
                        sbHTML.Append(" </td>")

                        sbHTML.Append("</tr>" + vbCrLf)
                        If intRowCount Mod 2 = 0 Then
                            sbHTML.Append("<tr class='clsTREvenRow'>")
                        Else
                            sbHTML.Append("<tr class='clsTREvenRow'>")
                        End If
                        intRowCount += 1
                    End If

                    sbHTML.Append("<td> ")
                    ' sbHTML.Append("<a href=""javascript:showResourceDetails(")
                    'sbHTML.Append(RADRow("EmployeeID").ToString())
                    'sbHTML.Append(",'")
                    'sbHTML.Append(m_FinancialPeriod)
                    'sbHTML.Append("','")
                    'sbHTML.Append(m_FinancialPeriodCount)
                    'sbHTML.Append("'")
                    'sbHTML.Append(")"">")
                    sbHTML.Append(RADRow("EmployeeName").ToString())
                    sbHTML.Append("</a>")
                    sbHTML.Append(" </td>")
                End If

                For Each RADRowtitle As DataRow In dsRAD.Tables(0).Select("EmployeeID='" + CommonFunction.General.BuildQueryString(strCurrentEmployeeId) + "'", "StartDate")

                    If strCurrentTitle <> RADRow("Title").ToString() Then
                        strCurrentTitle = RADRow("Title").ToString()

                        For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("EmployeeID='" + CommonFunction.General.BuildQueryString(strCurrentEmployeeId) + "' AND Title ='" + CommonFunction.General.BuildQueryString(strCurrentTitle) + "'", "Title")
                            sbHTML.Append(" <td   style='text-align:right' title=""").Append(strCurrentEmployee).Append("-").Append(strCurrentTitle).Append("""> ")
                            If RADRowvalues("ResourcePercentage") <> 0 Then
                                sbHTML.Append(FormatNumber(RADRowvalues("ResourcePercentage"), 2, TriState.False, TriState.False, TriState.False))

                            Else
                                sbHTML.Append("0 ")

                            End If
                            sbHTML.Append(" </td>")
                        Next

                    End If
                Next

            Next

            If strCurrentEmployeeId <> "" Then
                projectTotal = dsRAD.Tables(0).Compute("avg(ResourcePercentage)", "EmployeeId='" + strCurrentEmployeeId + "'")
            End If

            sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentEmployee).Append("""> ")
            If projectTotal <> "" And projectTotal <> "0" Then
                sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False).ToString())
            Else
                sbHTML.Append("0")
            End If
            sbHTML.Append(" </td>")

            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
        Else
            sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTML.Append("<tr class='clsTREvenRow'>")
            sbHTML.Append("<td style='text-align:center'>")
            sbHTML.Append("There are no items to show in this view.")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
        End If
    End Sub
    Protected Sub drawFilterExcel(ByRef sbhtml As StringBuilder)
        '====================================================================
        ' Procedure Name        : drawFilterExcel
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To draw Filter for exporting to Excel file
        ' Description           : To draw Filter for exporting to Excel file
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : RohiniK
        ' Created               : 1 Sep 2009
        ' Revisions             :
        '=====================================================================
        Dim view As String = ""
        Dim BG As String = ""
        Dim OU As String = ""
        Dim Role As String = ""
        Dim Grade As String = ""
        Dim Deployable As String = ""
        Dim Allocation As String = ""

        If Session("hdnView") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'view = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select FinancialType = CASE '" + Session("hdnView") + "' WHEN 'D' then 'Day' WHEN 'W' THEN 'Week' WHEN 'M' THEN 'Month' WHEN 'Q' THEN 'Quarter' END", MyBase.UseSQL), ""))
            view = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_FinancialType_View " + Session("hdnView"), MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If
        If Session("hdnBG") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'BG = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select BusinessGroup from tbl_CNF_BusinessGroups where BusinessGroupId= " + Session("hdnBG").ToString, MyBase.UseSQL), ""))
            BG = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_BusinessGroups_BusinessGroup " + Session("hdnBG").ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If
        If Session("hdnLocation") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            '  OU = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select Location from Tbl_PM_Location where LocationID= " + Session("hdnLocation").ToString, MyBase.UseSQL), ""))
            OU = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_Location_Tbl_PM_Location " + Session("hdnLocation").ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If
        If Session("hdnRole") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'Role = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select RoleDescription from Tbl_PM_role where RoleId=" + Session("hdnRole").ToString, MyBase.UseSQL), ""))
            Role = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_pm_role_RoleDescription " + Session("hdnRole").ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If
        If Session("hdnGrade") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'Grade = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select Grade from Tbl_PM_GradeMaster where GradeId=" + Session("hdnGrade").ToString, MyBase.UseSQL), ""))
            Grade = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_Tbl_PM_GradeMaster_Grade " + Session("hdnGrade").ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If
        If Session("hdnDeployable") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            '            Deployable = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select Description = CASE '" + Session("hdnDeployable") + "' WHEN 'N' then 'No' WHEN 'D' THEN 'Yes'  END", MyBase.UseSQL), ""))
            Deployable = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_Description " + Session("hdnDeployable"), MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If
        If Session("hdnAllocation") <> "" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            ' Allocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select AllocationPercentValue = CASE '" + Session("hdnAllocation") + "' WHEN 10 then '0 To 10' WHEN 20 THEN '10 To 20' WHEN 30 THEN '20 To 30' WHEN 40 THEN '30 To 40' WHEN 50 THEN '40 To 50' WHEN 60 then '50 To 60' WHEN 70 THEN '60 To 70' WHEN 80 THEN '70 To 80' WHEN 90 THEN '80 To 90' WHEN 100 THEN '90 To 100' END", MyBase.UseSQL), ""))
            Allocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_AllocationPercentValueCASE " + Session("hdnAllocation"), MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
        End If

        sbhtml.Append("<table id='tbl_rad_Filter' style ='width:99.99%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")
        sbhtml.Append("<tr class='clsTREven'>")

        'sbhtml.Append("<td style='text-align:right' >")
        'sbhtml.Append("View")
        'sbhtml.Append("</td>")
        'sbhtml.Append("<td  style='text-align:left' >" & view & "</td>")
        sbhtml.Append("<td style='text-align:right' ><B>Period</B></TD>")
        sbhtml.Append("<td style='text-align:left' >From " & CommonFunction.Dates.CGetDate(m_fromDate) & " - To " & CommonFunction.Dates.CGetDate(m_ToDate) & "</B></td>")

        If m_strMode = "" Or m_strMode.ToUpper = "PRINT" Then
            sbhtml.Append("<td style='text-align:right' ><B>Employee Name</td>")
            If m_EmployeeId <> "" And m_EmployeeId <> "0" Then
                sbhtml.Append("<td  style='text-align:left' >" & strEmployeeName & "</td>")
            Else
                sbhtml.Append("<td  style='text-align:left' >" & Session("hdnEmpName").ToString() & "</td>")
            End If
        End If

        sbhtml.Append("</tr>")
        sbhtml.Append("</table>")
        sbhtml.Append("</br>")

        If m_strMode = "" Or m_strMode.ToUpper = "PRINT" Then
            ' Draw Advance Filter 
            ''COMMENTED BY NILESH G ON 6/11/2015 FOR ISSUE ID 1955
            ''sbhtml.Append("<div id='divFilter' style='width:99.99%;position:absolute;border:solid 1 black;display:none'>")
            sbhtml.Append("<div id='divFilter' style='width:99.99%;border:solid 1 black;display:none'>")
            ''END OF COMMENTED BY NILESH G ON 6/11/2015 FOR ISSUE ID 1955
            sbhtml.Append("<table id='tblFilter' style='width:99.99%' cellpadding='0' cellspacing='0'>")
            sbhtml.Append("<tr class='clsTREven'>")

            sbhtml.Append("<td style='text-align:right' ><B>Business Group</B></td>")
            sbhtml.Append("<td  style='text-align:left' >" & BG & "</td>")

            sbhtml.Append("<td style='text-align:right' ><B>Organization Unit</B></td>")
            sbhtml.Append("<td  style='text-align:left' >" & OU & "</td>")
            sbhtml.Append("</tr>")

            sbhtml.Append("<tr class='clsTREven'>")
            sbhtml.Append("<td style='text-align:right' ><B>Role</B></td>")
            sbhtml.Append("<td  style='text-align:left' >" & Role & "</td>")

            sbhtml.Append("<td style='text-align:right' ><B>Grade</B></td>")
            sbhtml.Append("<td  style='text-align:left' >" & Grade & "</td>")
            sbhtml.Append("</tr>")

            sbhtml.Append("<tr class='clsTREven'>")
            sbhtml.Append("<td style='text-align:right' ><B>Deployable</B></td>")
            sbhtml.Append("<td  style='text-align:left' >" & Deployable & "</td>")

            sbhtml.Append("<td style='text-align:right' ><B>Allocation Percentage</B></td>")
            sbhtml.Append("<td  style='text-align:left' >" & Allocation & "</td>")
            sbhtml.Append("</tr>")

            sbhtml.Append("</table>")
            sbhtml.Append("</div>")

        End If
    End Sub

    Protected Sub drawCurrentFilter(ByRef sbhtml As StringBuilder)
        Dim CurrentFilter As String = ""

        Dim BG As String = ""
        Dim OU As String = ""
        Dim Role As String = ""
        Dim Grade As String = ""
        Dim Deployable As String = ""
        Dim Allocation As String = ""

        If M_BusinessGroupID <> "" And M_BusinessGroupID <> "0" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            '  BG = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select BusinessGroup from tbl_CNF_BusinessGroups where BusinessGroupId= " + M_BusinessGroupID.ToString, MyBase.UseSQL), ""))
            BG = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_BusinessGroups_BusinessGroup " + M_BusinessGroupID.ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            CurrentFilter = CurrentFilter & " Business Group: " + BG
        End If
        If M_LocationID <> "" And M_LocationID <> "0" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'OU = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select Location from Tbl_PM_Location where LocationID= " + M_LocationID.ToString, MyBase.UseSQL), ""))
            OU = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_Location_Tbl_PM_Location " + M_LocationID.ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            If CurrentFilter <> "" Then
                CurrentFilter = CurrentFilter & ","
            End If
            CurrentFilter = CurrentFilter & " Organization Unit: " + OU
        End If
        If M_roleID <> "" And M_roleID <> "0" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'Role = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select RoleDescription from Tbl_PM_role where RoleId=" + M_roleID.ToString, MyBase.UseSQL), ""))
            Role = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_pm_role_RoleDescription " + M_roleID.ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            If CurrentFilter <> "" Then
                CurrentFilter = CurrentFilter & ","
            End If
            CurrentFilter = CurrentFilter & " Role: " + Role
        End If
        If M_GradeId.ToString <> "" And M_GradeId <> "0" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'Grade = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select Grade from Tbl_PM_GradeMaster where GradeId=" + M_GradeId.ToString, MyBase.UseSQL), ""))
            Grade = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_Sel_Tbl_PM_GradeMaster_Grade " + M_GradeId.ToString, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            If CurrentFilter <> "" Then
                CurrentFilter = CurrentFilter & ","
            End If
            CurrentFilter = CurrentFilter & " Grade: " + Grade
        End If
        If M_Deployable <> "" And M_Deployable <> "0" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'Deployable = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select Description = CASE '" + M_Deployable + "' WHEN 'N' then 'No' WHEN 'D' THEN 'Yes'  END", MyBase.UseSQL), ""))
            Deployable = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_Description " + M_Deployable, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            If CurrentFilter <> "" Then
                CurrentFilter = CurrentFilter & ","
            End If
            CurrentFilter = CurrentFilter & " Deployable: " + Deployable
        End If
        If M_AllocationPercentage <> "" And M_AllocationPercentage <> "0" Then
            ''''Commented and Added by Vidya Jadhav on 8 Aug 2016 Purpose: inline to SP conversion
            'Allocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("select AllocationPercentValue = CASE '" + M_AllocationPercentage + "' WHEN 10 then '0 To 10' WHEN 20 THEN '10 To 20' WHEN 30 THEN '20 To 30' WHEN 40 THEN '30 To 40' WHEN 50 THEN '40 To 50' WHEN 60 then '50 To 60' WHEN 70 THEN '60 To 70' WHEN 80 THEN '70 To 80' WHEN 90 THEN '80 To 90' WHEN 100 THEN '90 To 100' WHEN 110 THEN '100 To 110' WHEN 120 THEN '110 To 120' END", MyBase.UseSQL), ""))
            Allocation = CommonFunction.Data.CheckIsDBNull(CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_AllocationPercentValue " + M_AllocationPercentage, MyBase.UseSQL), ""))
            '''End of Comment and Addition by Vidya Jadhav  on 8 Aug 2016
            If CurrentFilter <> "" Then
                CurrentFilter = CurrentFilter & ","
            End If
            CurrentFilter = CurrentFilter & " Allocation Percentage: " + Allocation
        End If

        sbhtml.Append("<table id='tbl_CurrentFilter' style ='width:100%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")
        sbhtml.Append("<tr class='clsTRColumnHeader'>")
        If m_strMode = "" Then
            sbhtml.Append("<td style='text-align:left' width='10%'>Current Filter : </td>")
            '''Commented and Added by Vaijat K ON 12/10/2015
            'sbhtml.Append("<td style='text-align:left' width='80%'>" & CurrentFilter & "  ")
            sbhtml.Append("<td style='text-align:left' width='70%'>" & CurrentFilter & "  ")
            If CurrentFilter <> "" Then
                sbhtml.Append("<img id='imgFilter' style='text-decoration:none;'border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
                'sbhtml.Append("<a class='clsHrefButton' href='javascript:ClearFilter()'>Clear Filter</a>")
            End If
            sbhtml.Append("</td>")
        End If



        sbhtml.Append("<td style='text-align:right'>")
        'Added by SanaS on 11-sep-2009
        sbhtml.Append("<a id='lnkRefresh' style=""text-decoration:none"" href=""javascript:RefreshView()"">Refresh </a> |")
        'End Addition by SanaS on 11-sep-2009
        sbhtml.Append("<a id='lnkExportToExcel' style=""text-decoration:none"" href=""javascript:ExportToExcel(" & m_EmployeeId.ToString & ")"">Export To Excel</a>")
        sbhtml.Append("</td></tr></table>")

    End Sub
    ''End of addition by RohiniK on 1 Sep 09 for S1 Customization
    Protected Sub drawFilter(ByRef sbhtml As StringBuilder)
        sbhtml.Append("<table id='tbl_rad_Filter' style ='width:99.99%'  CellSpacing=0 CellPadding=0  class='clsGridTable' >")
        sbhtml.Append("<tr class='clsTREven'>")

        sbhtml.Append("<td style='text-align:right' >")
        sbhtml.Append("View")
        sbhtml.Append("</td>")
        sbhtml.Append("<td  style='text-align:left' >")
        sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboFinancialType", "usp_SEL_FinancialType", 200, m_FinancialPeriod, "onchange=FinancialPeriodChange()", , True))
        sbhtml.Append("</td>")
        sbhtml.Append("<td style='text-align:right' >")
        sbhtml.Append("<img src='../../Images/cssImages/NumNavPreviousEnable.gif' onclick='Navigate(").Append(m_FinancialPeriodCount - 1).Append(")'>")
        sbhtml.Append("</td>")
        sbhtml.Append("<td style='text-align:center' >")
        sbhtml.Append("From ")
        sbhtml.Append(CommonFunction.Dates.CGetDate(m_fromDate))
        sbhtml.Append(" To ")
        sbhtml.Append(CommonFunction.Dates.CGetDate(m_ToDate))
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        sbhtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtFromDate", "txtFromDate", , , , CommonFunction.Dates.GetDate(m_fromDate), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        sbhtml.Append("</td>")
        sbhtml.Append("<td style='text-align:left' >")
        sbhtml.Append("<img src='../../Images/cssImages/NumNavNextEnable.gif' onclick='Navigate(").Append(m_FinancialPeriodCount + 1).Append(")'>")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        sbhtml.Append(CommonFunction.HTMLControls.DrawTextBox("TxtFinancialPeriodCount", "TxtFinancialPeriodCount", , , , m_FinancialPeriodCount.ToString(), , , , , , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        sbhtml.Append("</td>")



        sbhtml.Append("<td style='text-align:right;vertical-align:middle' >")

        If m_PageNo = 1 Or m_MaxPageno <= 1 Then
            sbhtml.Append("<img src='../../Images/cssImages/NavFirstDisable.gif'>")
            sbhtml.Append("<img src='../../Images/cssImages/NavPreviousDisable.gif'>")
        Else
            sbhtml.Append("<img src='../../Images/cssImages/NavFirstEnable.gif' onclick='NavigatePage(1)'>")
            sbhtml.Append("<img src='../../Images/cssImages/NavPreviousEnable.gif' onclick='NavigatePage(").Append(m_PageNo - 1).Append(")'>")
        End If
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        sbhtml.Append(CommonFunction.HTMLControls.DrawTextBox("TxtPageNo", "TxtPageNo", , 20, , m_PageNo.ToString(), , , , True, , , , True, EnableHTMLEncode:=True))
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        If m_PageNo = m_MaxPageno Or m_MaxPageno <= 1 Then
            sbhtml.Append("<img src='../../Images/cssImages/NavNextDisable.gif' >")
            sbhtml.Append("<img src='../../Images/cssImages/NavLastDisable.gif' >")
        Else
            sbhtml.Append("<img src='../../Images/cssImages/NavNextEnable.gif' onclick='NavigatePage(").Append(m_PageNo + 1).Append(")'>")
            sbhtml.Append("<img src='../../Images/cssImages/NavLastEnable.gif' onclick='NavigatePage(").Append(m_MaxPageno).Append(")'>")
        End If

        sbhtml.Append("</td>")

        If m_strMode = "" Then

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Employee Name")
            sbhtml.Append("</td>")
            sbhtml.Append("<td  style='text-align:left' >")
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            sbhtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", , 50, 50, M_EmployeeName, , , , , , , "onblur='javascript:ApplyFilter()' onkeypress='javascript:KeyPressOnClick(event)'", True, EnableHTMLEncode:=True))
            'ended by Shamkant s  for HTML encoding Date:06/10/15
            sbhtml.Append("</td>")

            sbhtml.Append("<td  style=""text-decoration:none;vertical-align:middle"">")
            sbhtml.Append("<a id='lnkFilter' style=""text-decoration:none"" href=""javascript:AdvanceFilters()""><img src='..\..\Images\cssImages\Link images\filter.gif' border='0' style=""text-decoration:none;vertical-align:middle"">Filter</a>")
            sbhtml.Append("</td>")
        End If

        sbhtml.Append("</tr>")
        sbhtml.Append("</table>")
        sbhtml.Append("</br>")

        If m_strMode = "" Then
            ' Draw Advance Filter 
            ''COMMENTED BY NILESH G ON 6/11/2015 FOR ISSUE ID 1955
            ''sbhtml.Append("<div id='divFilter' style='width:99.99%;position:absolute;border:solid 1 black;display:none'>")
            sbhtml.Append("<div id='divFilter' style='width:99.99%;border:solid 1 black;display:none'>")
            ''END OF COMMENTED BY NILESH G ON 6/11/2015 FOR ISSUE ID 1955
            sbhtml.Append("<table id='tblFilter' style='width:99.99%' cellpadding='0' cellspacing='0'>")
            sbhtml.Append("<tr class='clsTREven'>")

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Business Group")
            sbhtml.Append("</td>")
            sbhtml.Append("<td  style='text-align:left' >")
            sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboBusinessGroup", "usp_Sel_tbl_CNF_BusinessGroup 1", 200, M_BusinessGroupID, "onchange='javascript:BusinessGroup_Change(0,"""")'", True, True))
            sbhtml.Append("</td>")

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Organization Unit")
            sbhtml.Append("</td>")
            sbhtml.Append("<td  style='text-align:left' >")
            sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboLocation", "usp_SEL_Tbl_PM_Location", 200, M_LocationID, , True, True))
            sbhtml.Append("</td>")

            sbhtml.Append("</tr>")

            sbhtml.Append("<tr class='clsTREven'>")

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Role")
            sbhtml.Append("</td>")
            sbhtml.Append("<td  style='text-align:left' >")
            sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboRole", "usp_SEL_Tbl_PM_role ", 200, M_roleID, , True, True))
            sbhtml.Append("</td>")

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Grade")
            sbhtml.Append("</td>")
            sbhtml.Append("<td  style='text-align:left' >")
            sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboGrade", "usp_SEL_Tbl_PM_GradeMaster ", 200, M_GradeId, , True, True))
            sbhtml.Append("</td>")

            sbhtml.Append("</tr>")

            sbhtml.Append("<tr class='clsTREven'>")

            'sbhtml.Append("<td style='text-align:right' >")
            'sbhtml.Append("Employee Name")
            'sbhtml.Append("</td>")
            'sbhtml.Append("<td  style='text-align:left' >")
            'sbhtml.Append(CommonFunction.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", , 200, 50, M_EmployeeName, , , , , , , , True))
            'sbhtml.Append("</td>")

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Deployable")
            sbhtml.Append("</td>")
            sbhtml.Append("<td  style='text-align:left' >")
            sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboDeployable", "usp_Sel_Employee_Deployable ", 50, M_Deployable, , True, True))
            sbhtml.Append("</td>")

            sbhtml.Append("<td style='text-align:right' >")
            sbhtml.Append("Allocation Percentage")
            sbhtml.Append("</td>")

            sbhtml.Append("<td  style='text-align:left' >")
            sbhtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboAllocationPercentage", "usp_SEL_AllocationBand ", 200, M_AllocationPercentage, , True, True))
            sbhtml.Append("</td>")
            '
            sbhtml.Append("</tr>")
            sbhtml.Append("<tr class='clsTREven'>")
            sbhtml.Append("<td style='text-align:center' colspan='2' >")
            sbhtml.Append("<a class='clsHrefButton' href='javascript:ApplyFilter()'>Apply Filter</a>")
            sbhtml.Append("<td style='text-align:center' colspan='2' >")
            sbhtml.Append("<a class='clsHrefButton' href='javascript:ClearFilter()'>Clear Filter</a>")
            sbhtml.Append("</td>")

            sbhtml.Append("</tr>")
            sbhtml.Append("</table>")

            sbhtml.Append("</div>")
            sbhtml.Append("<script type=""text/javascript"">")
            sbhtml.Append(CommonFunction.OrganizationStructure.GetDependantLocationScript(False, "frmRAD", "cboBusinessGroup", "cboLocation"))
            sbhtml.Append("</script>")
        End If
    End Sub

    Protected Sub WritePage()
        Dim sbHTML As New StringBuilder
        Dim strFromWhere As String = ""
        Call InitVariables()

        '''Added By GaneshG On 07-Sep-09 
        ''strFromWhere = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"))

        '''draw page caption 
        ''If strFromWhere.ToUpper = "MDB" Then
        ''    sbHTML.Append(WebPage.Templates.PageCaption.GetPageCaptions(, "Resource Allocation View", "<a id='lnkSwitch' align='right' href=""javascript:SwitchToScheduleMode()"">Switch To Schedule Mode</a>", IIf(strEmployeeName <> "", "Employee Name : " + strEmployeeName, ""), True))
        ''Else
        sbHTML.Append(WebPage.Templates.PageCaption.GetPageCaptions(, "Resource Allocation View", IIf(strEmployeeName <> "", "Employee Name : " + strEmployeeName, ""), "", True))
        ''End If
        '''End Addition By GaneshG

        sbHTML.Append("<BR>")

        ''RK
        Call drawCurrentFilter(sbHTML)
        ''RK End

        ''added by RohiniK on 1 Sep 09 for S1 Customization
        'sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
        'sbHTML.Append("<thead class='clsTRColumnHeader'>")
        'sbHTML.Append("<th style='text-align:right'>")
        'sbHTML.Append("<a id='lnkExportToExcel' style=""text-decoration:none"" href=""javascript:ExportToExcel(" & m_EmployeeId.ToString & ")"">Export To Excel</a>")
        'sbHTML.Append("</th></thead></table>")
        ''End of addition by RohiniK on 1 Sep 09 for S1 Customization
        Call drawFilter(sbHTML)

        sbHTML.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")

        If m_strMode = "" Then

            Call drawAllResourceView(sbHTML)

            ''added by RohiniK on 1 Sep 09 for S1 Customization
            ''Plot hidden
            Session("hdnView") = m_FinancialPeriod
            Session("hdnEmpName") = M_EmployeeName
            Session("hdnBG") = M_BusinessGroupID
            Session("hdnLocation") = M_LocationID
            Session("hdnRole") = M_roleID
            Session("hdnGrade") = M_GradeId
            Session("hdnDeployable") = M_Deployable
            Session("hdnAllocation") = M_AllocationPercentage
            ''End of addition by RohiniK on 1 Sep 09 for S1 Customization

        ElseIf m_strMode = "RESOURCE" Then
            Call DrawResourceDetailView(sbHTML)
            ''added by RohiniK on 1 Sep 09 for S1 Customization
        ElseIf m_strMode.ToUpper = "PRINT" Then
            Dim sbHTMLExcel As New StringBuilder

            sbHTMLExcel.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")

            sbHTMLExcel.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTMLExcel.Append("<thead class='clsTRColumnHeader'>")
            sbHTMLExcel.Append("<th style='text-align:left'>Resource Allocation View</th>")
            sbHTMLExcel.Append("</thead></table>")
            sbHTMLExcel.Append("<BR>")

            Call drawFilterExcel(sbHTMLExcel)
            sbHTMLExcel.Append("<BR>")

            If m_EmployeeId <> "" And m_EmployeeId <> "0" Then
                Call DrawResourceDetailView(sbHTMLExcel)
            Else
                Call drawAllResourceViewExcel(sbHTMLExcel)
            End If

            sbHTMLExcel.Append("</div>")
            ExporttoExcel(sbHTMLExcel)
            Response.End()
            sbHTMLExcel = Nothing
            ''End of addition by RohiniK on 1 Sep 09 for S1 Customization
        End If

        sbHTML.Append("</div>")

        CommonFunction.General.WriteHTML(sbHTML.ToString())


        sbHTML = Nothing
        dsRAD.Dispose()
    End Sub

    Protected Sub drawAllResourceView(ByRef sbHTML As StringBuilder)
        Dim strCurrentTitle As String = ""
        Dim strCurrentEmployee As String = ""
        Dim intRowCount As Long = 0
        Dim strCurrentEmployeeId As String = ""
        Dim projectTotal As String

        If dsRAD.Tables(0).Rows.Count <> 0 Then

            sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTML.Append("<thead class='clsTRColumnHeader'>")
            sbHTML.Append("<th style='text-align:left'>")
            sbHTML.Append("Employee Name")
            sbHTML.Append("</th>")
            If CommonFunction.Application.AllowResourceAllocation = False Then
                sbHTML.Append("<th style='text-align:left'>")
                sbHTML.Append("Allocate on Project")
                sbHTML.Append("</th>")
            End If

            For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("", "StartDate")
                If strCurrentTitle <> RADRowvalues("Title").ToString() Then
                    sbHTML.Append("<th  style='text-align:right'>")
                    sbHTML.Append(RADRowvalues("Title").ToString())
                    sbHTML.Append("</th>")
                    strCurrentTitle = RADRowvalues("Title").ToString()
                End If
            Next

            sbHTML.Append("<th style='text-align:right'>")
            sbHTML.Append("Average")
            sbHTML.Append("</th>")

            sbHTML.Append("</thead>")

            strCurrentEmployee = ""
            strCurrentTitle = ""
            For Each RADRow As DataRow In dsRAD.Tables(0).Select("", "EmployeeName")

                If strCurrentEmployeeId <> RADRow("EmployeeID").ToString() Then
                    If strCurrentEmployeeId <> "" Then
                        projectTotal = dsRAD.Tables(0).Compute("avg(ResourcePercentage)", "EmployeeId='" + strCurrentEmployeeId + "'")
                    End If

                    strCurrentEmployee = RADRow("EmployeeName").ToString()
                    strCurrentEmployeeId = RADRow("EmployeeId").ToString()
                    strCurrentTitle = ""
                    If intRowCount = 0 Then
                        sbHTML.Append("<tr class='clsTREvenRow'>")
                        intRowCount += 1
                    Else
                        ''Commented and Added by NitinC on 25 Jan 2012 For WhizibleSEM 11.0
                        'sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentEmployee).Append("""> ")
                        If CType(projectTotal, Integer) > 100 Then
                            sbHTML.Append(" <td  class='clsTDRedColumnHeader' style='text-align:right' title=""").Append(strCurrentEmployee).Append("""> ")
                        Else
                            sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentEmployee).Append("""> ")
                        End If
                        ''End of Commented and Added by NitinC on 25 Jan 2012 For WhizibleSEM 11.0

                        If projectTotal <> "" And projectTotal <> "0" Then
                            sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False).ToString())
                        Else
                            sbHTML.Append("0")
                        End If
                        sbHTML.Append(" </td>")

                        sbHTML.Append("</tr>" + vbCrLf)
                        If intRowCount Mod 2 = 0 Then
                            sbHTML.Append("<tr class='clsTREvenRow'>")
                        Else
                            sbHTML.Append("<tr class='clsTREvenRow'>")
                        End If
                        intRowCount += 1
                    End If
                    sbHTML.Append("<td> ")
                    sbHTML.Append("<a href=""javascript:showResourceDetails(")
                    sbHTML.Append(RADRow("EmployeeID").ToString())
                    sbHTML.Append(",'")
                    sbHTML.Append(m_FinancialPeriod)
                    sbHTML.Append("','")
                    sbHTML.Append(m_FinancialPeriodCount)
                    sbHTML.Append("'")
                    sbHTML.Append(")"">")
                    sbHTML.Append(RADRow("EmployeeName").ToString())
                    sbHTML.Append("</a>")
                    sbHTML.Append(" </td>")
                    If CommonFunction.Application.AllowResourceAllocation = False Then
                        sbHTML.Append("<td align=center style='text-decoration:underline ; CURSOR:hand' onclick=""JavaScript:Allocate_onClick('" + CType(strCurrentEmployeeId, String) + "')"">Allocate</TD>")
                    End If
                End If

                For Each RADRowtitle As DataRow In dsRAD.Tables(0).Select("EmployeeID='" + CommonFunction.General.BuildQueryString(strCurrentEmployeeId) + "'", "StartDate")

                    If strCurrentTitle <> RADRow("Title").ToString() Then
                        strCurrentTitle = RADRow("Title").ToString()

                        For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("EmployeeID='" + CommonFunction.General.BuildQueryString(strCurrentEmployeeId) + "' AND Title ='" + CommonFunction.General.BuildQueryString(strCurrentTitle) + "'", "Title")
                            ''Commented and Added by NitinC on 25 Jan 2012 For WhizibleSEM 11.0
                            'sbHTML.Append(" <td   style='text-align:right' title=""").Append(strCurrentEmployee).Append("-").Append(strCurrentTitle).Append("""> ")
                            If CType(RADRow("ResourcePercentage").ToString(), Integer) > 100 Then
                                sbHTML.Append(" <td   style='text-align:right;color:red' title=""").Append(strCurrentEmployee).Append("-").Append(strCurrentTitle).Append("""> ")
                            Else
                                sbHTML.Append(" <td   style='text-align:right' title=""").Append(strCurrentEmployee).Append("-").Append(strCurrentTitle).Append("""> ")
                            End If
                            ''End of Commented and Added by NitinC on 25 Jan 2012 For WhizibleSEM 11.0
                            If RADRowvalues("ResourcePercentage") <> 0 Then
                                sbHTML.Append(FormatNumber(RADRowvalues("ResourcePercentage"), 2, TriState.False, TriState.False, TriState.False))

                            Else
                                sbHTML.Append("0 ")

                            End If
                            sbHTML.Append(" </td>")
                        Next

                    End If
                Next

            Next

            If strCurrentEmployeeId <> "" Then
                projectTotal = dsRAD.Tables(0).Compute("avg(ResourcePercentage)", "EmployeeId='" + strCurrentEmployeeId + "'")
            End If
            sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentEmployee).Append("""> ")
            If projectTotal <> "" And projectTotal <> "0" Then
                sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False).ToString())
            Else
                sbHTML.Append("0")
            End If
            sbHTML.Append(" </td>")

            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
        Else
            sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTML.Append("<tr class='clsTREvenRow'>")
            sbHTML.Append("<td style='text-align:center'>")
            sbHTML.Append("There are no items to show in this view.")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
        End If
    End Sub

    Protected Sub DrawResourceDetailView(ByRef sbHTML As StringBuilder)

        Dim strCurrentTitle As String = ""
        Dim strCurrentProject As String = ""
        Dim strCurrentProjectID As String = ""
        Dim intRowCount As Long = 0
        Dim projectTotal As String
        Dim strCurrentAllocation As String = ""
        Dim strPkToken As String
        Dim strCurrentEmployeeroleId As String = ""
        If dsRAD.Tables(0).Rows.Count <> 0 Then

            sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTML.Append("<thead class='clsTRColumnHeader'>")
            sbHTML.Append("<th style='text-align:left'>")
            sbHTML.Append("Project Name")
            sbHTML.Append("</th>")
            sbHTML.Append("<th style='text-align:left'>")
            sbHTML.Append("Start Date")
            sbHTML.Append("</th>")
            sbHTML.Append("<th style='text-align:left'>")
            sbHTML.Append("End Date")
            sbHTML.Append("</th>")

            'sbHTML.Append("<th style='text-align:left'>")
            'sbHTML.Append("Allocation")
            'sbHTML.Append("</th>")

            For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("", "StartDate")

                If strCurrentTitle <> RADRowvalues("Title").ToString() Then
                    sbHTML.Append("<th  style='text-align:right'>")
                    sbHTML.Append(RADRowvalues("Title").ToString())
                    sbHTML.Append("</th>")
                    strCurrentTitle = RADRowvalues("Title").ToString()
                End If
            Next

            sbHTML.Append("<th style='text-align:right'>")
            sbHTML.Append("Average")
            sbHTML.Append("</th>")

            sbHTML.Append("</thead>")

            strCurrentProject = ""
            strCurrentTitle = ""
            strCurrentEmployeeroleId = ""
            For Each RADRow As DataRow In dsRAD.Tables(0).Select("", "ProjectName")

                If strCurrentProjectID <> RADRow("ProjectID").ToString() Or strCurrentAllocation <> RADRow("AllocationType").ToString() Or strCurrentEmployeeroleId <> RADRow("ProjectemployeeRoleID").ToString() Then
                    If strCurrentProjectID <> "" Then
                        projectTotal = dsRAD.Tables(0).Compute("avg(ResourcePercentage)", "ProjectID='" + strCurrentProjectID + "' AND AllocationType ='" + strCurrentAllocation + "'")
                    End If


                    If intRowCount = 0 Then
                        sbHTML.Append("<tr class='clsTREvenRow'>")
                        intRowCount += 1
                    Else
                        sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentProject).Append("""> ")
                        If projectTotal <> "" And projectTotal <> "0" Then
                            sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False).ToString())
                        Else
                            sbHTML.Append("<span  style='visibility:hidden' >00.0</span>")
                            sbHTML.Append("0")
                        End If
                        sbHTML.Append(" </td> ")
                        sbHTML.Append("</tr>" + vbCrLf)

                        If intRowCount Mod 2 = 0 Then
                            sbHTML.Append("<tr class='clsTREvenRow'>")
                        Else
                            sbHTML.Append("<tr class='clsTREvenRow'>")
                        End If

                        intRowCount += 1
                    End If

                    strCurrentProject = RADRow("ProjectName").ToString()
                    strCurrentProjectID = RADRow("ProjectID").ToString()
                    strCurrentEmployeeroleId = RADRow("ProjectemployeeRoleID").ToString()

                    strCurrentTitle = ""
                    sbHTML.Append("<td> ")
                    'Commented and Modified by SanaS on 11-sep-2009 for allowing Resource allocation change from this page
                    ' sbHTML.Append(RADRow("ProjectName").ToString())
                    If strCurrentEmployeeroleId <> 0 Then
                        strPkToken = CommonFunctions.Security.Token.GetToken(strCurrentEmployeeroleId.ToString + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "1019")
                        sbHTML.Append("<a href=""javascript:showProjectResourceDetails(")
                        sbHTML.Append(strCurrentEmployeeroleId.ToString())
                        sbHTML.Append(",")
                        sbHTML.Append(strCurrentProjectID.ToString)
                        sbHTML.Append(",'")
                        sbHTML.Append(strPkToken)
                        sbHTML.Append("')"">")
                        sbHTML.Append(RADRow("ProjectName").ToString())
                        sbHTML.Append("</a>")
                    Else
                        sbHTML.Append(RADRow("ProjectName").ToString())
                    End If
                    'End Comment and Modification by Sana on 11-sep-2009 for allowing Resource allocation change from this page
                    sbHTML.Append(" </td>")

                    sbHTML.Append("<td> ")
                    If Not IsDBNull(RADRow("ExpectedStartDate")) = True Then
                        sbHTML.Append(CommonFunction.Dates.CGetDate(RADRow("ExpectedStartDate")).ToString())
                    Else
                        sbHTML.Append(" ")
                    End If

                    sbHTML.Append(" </td>")

                    sbHTML.Append("<td> ")
                    If Not IsDBNull(RADRow("ExpectedEndDate")) = True Then
                        sbHTML.Append(CommonFunction.Dates.CGetDate(RADRow("ExpectedEndDate")).ToString())
                    Else
                        sbHTML.Append(" ")
                    End If
                    sbHTML.Append(" </td>")
                    'sbHTML.Append("<td> ")
                    'sbHTML.Append(RADRow("AllocationType").ToString())
                    'sbHTML.Append(" </td>")

                    strCurrentAllocation = RADRow("AllocationType").ToString()

                End If


                For Each RADRowtitle As DataRow In dsRAD.Tables(0).Select("ProjectID='" + CommonFunction.General.BuildQueryString(strCurrentProjectID) + "' AND AllocationType ='" + strCurrentAllocation + "' AND ProjectEmployeeRoleID = '" + strCurrentEmployeeroleId + "'", "StartDate")

                    If strCurrentTitle <> RADRow("Title").ToString() Then
                        strCurrentTitle = RADRow("Title").ToString()

                        For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("ProjectID='" + CommonFunction.General.BuildQueryString(strCurrentProjectID) + "' AND AllocationType ='" + strCurrentAllocation + "' AND Title ='" + CommonFunction.General.BuildQueryString(strCurrentTitle) + "'" + " AND ProjectEmployeeRoleID = '" + strCurrentEmployeeroleId + "'", "Title")
                            sbHTML.Append(" <td   style='text-align:right' title=""").Append(strCurrentProject).Append("-").Append(strCurrentTitle).Append("""> ")
                            If RADRowvalues("ResourcePercentage") <> 0 Then
                                sbHTML.Append(FormatNumber(RADRowvalues("ResourcePercentage"), 2, TriState.False, TriState.False, TriState.False))

                            Else
                                sbHTML.Append("<span  style='visibility:hidden' >00.0</span>")
                                sbHTML.Append("0 ")

                            End If
                            sbHTML.Append(" </td>")
                        Next

                    End If
                Next

            Next

            projectTotal = dsRAD.Tables(0).Compute("avg(ResourcePercentage)", "ProjectID=" + CommonFunction.General.BuildQueryString(strCurrentProjectID) + " AND AllocationType ='" + strCurrentAllocation + "' AND ProjectEmployeeRoleID = '" + strCurrentEmployeeroleId + "'")
            sbHTML.Append(" <td  class='clsTDColumnHeader' style='text-align:right' title=""").Append(strCurrentProject).Append("""> ")
            If projectTotal <> "" And projectTotal <> "0" Then
                sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False))
            Else
                sbHTML.Append("<span  style='visibility:hidden' >00.0</span>")
                sbHTML.Append("0")
            End If
            sbHTML.Append(" </td>")

            sbHTML.Append("</tr>")

            ' Show Total for Each month 
            sbHTML.Append("<tr class='clsTRGroupHeader'>")
            sbHTML.Append("<td style='text-align:left' colspan='3'>")
            sbHTML.Append("Total")
            sbHTML.Append("</td>")

            strCurrentTitle = ""

            For Each RADRowvalues As DataRow In dsRAD.Tables(0).Select("", "StartDate")
                If strCurrentTitle <> RADRowvalues("Title").ToString() Then
                    strCurrentTitle = RADRowvalues("Title").ToString()
                    sbHTML.Append("<td  style='text-align:right'>")
                    projectTotal = dsRAD.Tables(0).Compute("sum(ResourcePercentage)", "Title ='" + CommonFunction.General.BuildQueryString(strCurrentTitle) + "'")
                    If projectTotal <> "" And projectTotal <> "0" Then
                        sbHTML.Append(FormatNumber(projectTotal, 2, TriState.False, TriState.False, TriState.False))
                    Else
                        sbHTML.Append("<span  style='visibility:hidden' >00.0</span>")
                        sbHTML.Append("0")
                    End If
                    sbHTML.Append("")
                    sbHTML.Append("</td>")

                End If
            Next

            sbHTML.Append("<td  style='text-align:right'>")
            projectTotal = dsRAD.Tables(0).Compute("sum(ResourcePercentage)", "")

            If projectTotal <> "" And projectTotal <> "0" Then
                projectTotal = (CDbl(projectTotal) / intcntDistinctTitle).ToString
            End If

            sbHTML.Append(FormatNumber(projectTotal, 2, TriState.True, TriState.False, TriState.False))

            sbHTML.Append("</td>")

            sbHTML.Append("</tr>")

            sbHTML.Append("</table>")
        Else
            sbHTML.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
            sbHTML.Append("<tr class='clsTREvenRow'>")
            sbHTML.Append("<td style='text-align:center'>")
            sbHTML.Append("There are no items to show in this view.")
            sbHTML.Append("</td>")
            sbHTML.Append("</tr>")
            sbHTML.Append("</table>")
        End If
    End Sub
End Class
