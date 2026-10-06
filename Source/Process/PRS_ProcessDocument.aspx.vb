Public Class PRS_ProcessDocument
    Inherits WebPages.Template.WhizTemplate

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
    Private m_strHTML As New System.Text.StringBuilder
    Private strComanyName As String
    Private strCity As String
    Private strComanyShortName As String
    Private strProcessID As String
    Private cntNo As Integer = 6
    Private strDocumentCode As String


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        '' Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        'Put user code to initialize the page here
        strComanyName = CommonFunction.Application.CompanyNames
        strCity = CommonFunction.Application.City
        strComanyShortName = CommonFunction.Application.ShortCompanyName
        strProcessID = Request.QueryString("ProcessID")


    End Sub
    Public Sub DrawPage()
        Dim strQuery As String
        Dim drHeadings As IDataReader
        Dim strProcessName As String

        Dim strRefNo As String
        Dim strVersionNo As String
        Dim Iterator As Integer


        strQuery = "usp_sel_ProcessHeadings " + strProcessID
        drHeadings = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While drHeadings.Read()
            strProcessName = CType(drHeadings("ProcessName"), String)
            'strProcessName = Left(CType(drHeadings("ProcessName"), String), strProcessName.Length - 7)
            strVersionNo = CType(drHeadings("VersionNo"), String)
        End While
        CommonFunction.Data.DisposeDataReader(drHeadings)
        strProcessName = strProcessName.Trim()
        strDocumentCode = strProcessName.Chars(0)

        For Iterator = 1 To strProcessName.Length - 1
            If strProcessName.Chars(Iterator) = " " Then
                If strProcessName.Chars(Iterator + 1) <> " " Then
                    strDocumentCode += strProcessName.Chars(Iterator + 1)

                End If
            End If
        Next
        strDocumentCode = strDocumentCode.ToUpper
        strRefNo = "Doc ID : " + strComanyShortName + "/PROC/" + Left(strDocumentCode, strDocumentCode.Length - 1) + "/V" + strVersionNo

        m_strHTML.Append("<H3 align=center>" + strComanyName + "," + strCity + "</H3>")

        m_strHTML.Append("<H2 align=center>" + strProcessName + "</H2>")
        m_strHTML.Append("<H4 align=center>" + strRefNo + "</H4>")



        m_strHTML.Append("<BR><BR><BR><BR>")
        'To Draw Revision History
        Call DrawRevisionHistory()
        'End of Revision Hhistory

        Call ProcessDetails()

        'Response.Write(m_strHTML)


        ExportDoc()

    End Sub
    Private Sub DrawRevisionHistory()
        Dim drGrid As IDataReader
        Dim strQuery As String


        strQuery = "usp_sel_ProcedureDetails " + strProcessID
        drGrid = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        m_strHTML.Append("<H4 align=left><I>Revision History</I></H4><BR>")
        m_strHTML.Append("<TABLE class='clsGridTable' border=1 cellpadding=0 cellspacing=0 style='margin-left:.45in; border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt; mso-padding-alt:0in 5.4pt 0in 5.4pt'>")
        m_strHTML.Append("<TR  class='clsTRPageCaption' width=99.9%>")
        m_strHTML.Append("<TH>Ver.No</TH>")
        m_strHTML.Append("<TH>Date of Release</TH>")
        m_strHTML.Append("<TH>Prepared By</TH>")

        m_strHTML.Append("<TH>Reviewed/Approved By</TH>")
        m_strHTML.Append("<TH>List of changes from Previous Version</TH>")
        m_strHTML.Append("</TR>")

        While drGrid.Read()

            m_strHTML.Append("<TR  class='clsTREven' width=99.9% valign=top>")
            m_strHTML.Append("<TD>" & CType(drGrid("VerNo"), String) & "</TD>")
            m_strHTML.Append("<TD>" & CType(drGrid("DateOfRelease"), String) & "</TD>")
            m_strHTML.Append("<TD>" & CType(drGrid("PreparedBy"), String) & "</TD>")
            m_strHTML.Append("<TD>" & CType(drGrid("ApprovedBy"), String) & "</TD>")
            m_strHTML.Append("<TD>" & CType(drGrid("PreviousVersionDetails"), String) & "</TD>")
            m_strHTML.Append("</TR>")
        End While
        CommonFunction.Data.DisposeDataReader(drGrid)
        m_strHTML.Append("</TABLE>")
    End Sub
    Private Sub ProcessDetails()
        Dim drGrid As IDataReader
        Dim strQuery As String


        strQuery = "usp_sel_tbl_PRS_Process_Draft " + strProcessID
        drGrid = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)

        While drGrid.Read()
            m_strHTML.Append("<H4 align=left><I>1.1 Purpose & Scope</I></H4>")
            m_strHTML.Append(CType(drGrid("Purpose"), String))

            m_strHTML.Append("<H4 align=left><I>1.2 Responsibility</I></H4>")
            m_strHTML.Append(CType(drGrid("Responsibility"), String))

            m_strHTML.Append("<H4 align=left><I>1.3 Brief Description</I></H4>")
            m_strHTML.Append(CType(drGrid("Description"), String))
            'To disolay Related Processes
            Call RelatedProcess()
            'To display Activities
            Call ActivityDetails()
            'End of Activity
            m_strHTML.Append("<H4 align=left><I>" + "1." + CType(cntNo, String) + " Tailoring Options</I></H4>")
            m_strHTML.Append(CType(drGrid("TailoringOptions"), String))

            cntNo = cntNo + 1

            m_strHTML.Append("<H4 align=left><I>" + "1." + CType(cntNo, String) + " Retention of Outputs and Records</I></H4>")
            m_strHTML.Append(CType(drGrid("OutputRetention"), String))

        End While
        CommonFunction.Data.DisposeDataReader(drGrid)
    End Sub

    Private Sub RelatedProcess()
        Dim drGrid As IDataReader
        Dim strSQL As String

        strSQL = "Usp_Sel_RelatedProcesses " + strProcessID
        drGrid = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        m_strHTML.Append("<H4 align=left><I>1.4 Related Processes</I></H4>")
        While drGrid.Read()
            m_strHTML.Append("<LI>" + CType(drGrid("ProcessName"), String) + "</LI>")
        End While
        CommonFunction.Data.DisposeDataReader(drGrid)
    End Sub
    Private Sub ActivityDetails()
        Dim drGrid As IDataReader
        Dim drGrid_List As IDataReader
        Dim strQuery As String

        Dim ProcCount As Integer
        Dim iActivityCount As Integer = 1

        strQuery = "usp_sel_tbl_PRS_Activity_Draft " + strProcessID
        drGrid = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        drGrid_List = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        ProcCount = drGrid_List.FieldCount
        m_strHTML.Append("<H4 align=left><I>1.5 List of Procedures </I></H4>")
        While drGrid_List.Read()
            m_strHTML.Append(iActivityCount.ToString + ". " + CType(drGrid_List("Title"), String) + "<BR>")
            iActivityCount += 1
        End While
        CommonFunction.Data.DisposeDataReader(drGrid_List)
        While drGrid.Read()
            m_strHTML.Append("<H4 align=left><I>" + "1." + CType(cntNo, String) + " " + CType(drGrid("Title"), String) + "</I></H4><BR>")
            m_strHTML.Append("<TABLE border=1 cellpadding=0 cellspacing=0 style='margin-left:.45in; border-collapse:collapse;border:none;mso-border-alt:solid windowtext .5pt; mso-padding-alt:0in 5.4pt 0in 5.4pt'")
            m_strHTML.Append("<TR><TD valign=top>Entry Criteria</TD><TD>" + CType(drGrid("InputCriteria"), String) + "</TD></TR>")
            m_strHTML.Append("<TR><TD valign=top>Inputs</TD><TD>" + CType(drGrid("Inputs"), String) + "</TD></TR>")
            m_strHTML.Append("<TR><TD valign=top>Steps</TD><TD>" + CType(drGrid("Description"), String) + "</TD></TR>")
            m_strHTML.Append("<TR><TD valign=top>Outputs</TD><TD>" + CType(drGrid("Objective"), String) + "</TD></TR>")
            m_strHTML.Append("<TR><TD valign=top>Exit Criteria</TD><TD>" + CType(drGrid("ExitCriteria"), String) + "</TD></TR>")
            m_strHTML.Append("</TABLE>")
            cntNo += 1
        End While
        CommonFunction.Data.DisposeDataReader(drGrid)
    End Sub

    Private Sub ExportDoc()
        Dim strBody As New System.Text.StringBuilder("")

        strBody.Append("<html " & _
                "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
                "xmlns:w='urn:schemas-microsoft-com:office:word'" & _
                "xmlns='http://www.w3.org/TR/REC-html40'>" & _
                "<head><title>Time</title>")

        'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
        strBody.Append("<!--[if gte mso 9]>" & _
                                 "<xml>" & _
                                 "<w:WordDocument>" & _
                                 "<w:View>Print</w:View>" & _
                                 "<w:Zoom>90</w:Zoom>" & _
                                 "<w:DoNotOptimizeForBrowser/>" & _
                                 "</w:WordDocument>" & _
                                 "</xml>" & _
                                 "<![endif]-->")

        strBody.Append("<style>" & _
                                "<!-- /* Style Definitions */" & _
                                "@page Section1" & _
                                "   {size:8.5in 11.0in; " & _
                                "   margin:1.0in 1.25in 1.0in 1.25in ; " & _
                                "   mso-header-margin:.5in; " & _
                                "   mso-footer-margin:.5in; mso-paper-source:0;}" & _
                                " div.Section1" & _
                                "   {page:Section1;}" & _
                                "-->" & _
                               "</style></head>")

        strBody.Append("<body lang=EN-US style='tab-interval:.5in'>" & _
                                "<div class=Section1>" + m_strHTML.ToString + "</div></body></html>")

        'Force this content to be downloaded as a Word document with the name of your choice
        Response.ClearHeaders()
        Response.AppendHeader("Content-Type", "application/msword")
        Response.AppendHeader("Content-disposition", _
                               "attachment; filename=Process_" + strDocumentCode.Trim + ".doc")
        Response.Clear()
        Response.Write(strBody)
    End Sub

End Class
