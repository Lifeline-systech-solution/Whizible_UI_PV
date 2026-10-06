Public Class Helpdesk_Dashboard
    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
    End Sub
#Region "Jquery AJAX Web Methods"
    <System.Web.Services.WebMethod> _
    Public Shared Function GetOverallGraphData(ByVal GraphParamters As Object) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetOverallGraphData
        ' Description           : To Get Overall Graph Data
        ' Created Date          : 10th-Nov-2017
        ' Author                 : Bharat T.
        '=====================================================================
        Try
            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")
            strGraphSQL = "USP_NG2_SEL_tbl_CRM_Query_Master_Count_Status " & GraphParamters("FilterType") & "," & GraphParamters("Time") & "," & strUserID & ",'" & strLoginType & "'"
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)
            strResult = GetSerialized(dtGraphTable)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GetAssignedToMeGraphData(ByVal GraphParamters As Object) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        '=====================================================================
        ' Procedure Name        : GetAssignedToMeGraphData
        ' Description           : To Get Assigned To Me Graph Data
        ' Created Date          : 10th-Nov-2017
        ' Author                : Bharat T.
        '=====================================================================
        Try
            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")
            strGraphSQL = "usp_NG2_sel_tbl_CRM_Query_Master_AssignedToMe " & GraphParamters("FilterType") & "," & GraphParamters("Time") & "," & strUserID & ",'" & strLoginType & "'"
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)
            strResult = GetSerialized(dtGraphTable)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetParetoAnalysisGraphData(ByVal strGraphFilter As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strGraphFilter = Utilities.Security.SecurityBuilder.CheckUserInput(strGraphFilter, 2, True, False, False)
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
            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")
            strGraphSQL = "usp_NG2_GetHelpDeskRequest_ParetoAnalysis " & strUserID & ",'" & strLoginType & "'," & strGraphFilter
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)
            strResult = GetSerialized(dtGraphTable)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetInOutRateGraphData(ByVal strGraphFilter As String, ByVal strDuration As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strGraphFilter = Utilities.Security.SecurityBuilder.CheckUserInput(strGraphFilter, 2, True, False, False)
        strDuration = Utilities.Security.SecurityBuilder.CheckUserInput(strDuration, 2, True, False, False)
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
            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            If strGraphFilter = "" Then
                strGraphFilter = "Null"
            End If
            If strDuration = "" Then
                strDuration = "Null"
            End If
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")
            strGraphSQL = "usp_NG2_sel_tbl_CRM_Query_Master_InrateOutrateCurrentMonth " & strGraphFilter & "," & strDuration & "," & strUserID & ",'" & strLoginType & "'"
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)
            strResult = GetSerialized(dtGraphTable)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetTimeScaleGraphData(ByVal strGraphFilter As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        strGraphFilter = Utilities.Security.SecurityBuilder.CheckUserInput(strGraphFilter, 2, True, False, False)
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
            Dim strGraphSQL As String = ""
            Dim strUserID As String
            Dim strLoginType As String
            Dim dtGraphTable As DataTable
            Dim strResult As String = ""
            If strGraphFilter = "" Then
                strGraphFilter = "Null"
            End If
            strUserID = HttpContext.Current.Session("intUserID")
            strLoginType = HttpContext.Current.Session("LoginType")
            strGraphSQL = "usp_NG2_sel_tbl_CRM_Query_Master_AreaChartInrateOutrate " & strGraphFilter & "," & strUserID & ",'" & strLoginType & "'"
            dtGraphTable = CommonFunctions.Data.GetDataTable(strGraphSQL, True)
            strResult = GetSerialized(dtGraphTable)
            Return strResult
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    <System.Web.Services.WebMethod()>
    Public Shared Function GetSLAData(ByVal IsExternal As String, ByVal strDuration As String)
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        IsExternal = Utilities.Security.SecurityBuilder.CheckUserInput(IsExternal, 2, True, False, False)
        strDuration = Utilities.Security.SecurityBuilder.CheckUserInput(strDuration, 2, True, False, False)
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
            Dim strSql As String = "usp_NG2_HelpdeskSLA_Dashboard " & HttpContext.Current.Session("intUserID") & ",'" & HttpContext.Current.Session("LoginType") & "'," & IsExternal & "," & strDuration
            Dim dtSLA As New DataTable
            dtSLA = CommonFunctions.Data.GetDataTable(strSql, True)
            Dim strHTML As New StringBuilder
            strHTML.Append("<table class='table'>")
            strHTML.Append("<tr>")
            strHTML.Append("<th>")
            strHTML.Append("Type")
            strHTML.Append("</th>")
            strHTML.Append("<th>")
            strHTML.Append("Met(%)")
            strHTML.Append("</th>")
            strHTML.Append("<th>")
            strHTML.Append("Not Met(%)")
            strHTML.Append("</th>")
            strHTML.Append("<th>")
            strHTML.Append("Not Acknowledge(%)")
            strHTML.Append("</th>")
            strHTML.Append("<th>")
            strHTML.Append("Not Occured(%)")
            strHTML.Append("</th>")
            strHTML.Append("</tr>")
            For i As Integer = 0 To dtSLA.Rows.Count - 1
                strHTML.Append("<tr>")
                strHTML.Append("<td>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSLA.Rows(i)("Type")))
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSLA.Rows(i)("Met")))
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSLA.Rows(i)("NotMet")))
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSLA.Rows(i)("NotAcknowledge")))
                strHTML.Append("</td>")
                strHTML.Append("<td>")
                strHTML.Append(CommonFunctions.Data.CheckIsDBNull(dtSLA.Rows(i)("NotOccured")))
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
            Next
            If dtSLA.Rows.Count = 0 Then
                strHTML.Append("<tr>")
                strHTML.Append("<td colspan=5>")
                strHTML.Append("There are no items to show in this view.")
                strHTML.Append("</td>")
                strHTML.Append("</tr>")
            End If
            strHTML.Append("</table>|||")
            strHTML.Append(GetSerialized(dtSLA))
            Return strHTML.ToString()
        Catch ex As Exception
            Return "Bad Request found"
        End Try
    End Function
    Public Shared Function GetSerialized(dt As DataTable) As String
        Dim serializer As New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))()
        Dim row As Dictionary(Of String, Object)
        Dim jsonString As String = ""
        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)()
            For Each col As DataColumn In dt.Columns
                If col.DataType = GetType(DateTime) Then
                    col.DateTimeMode = DataSetDateTime.Unspecified
                End If
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        jsonString = serializer.Serialize(rows)
        Return jsonString
    End Function
#End Region
End Class