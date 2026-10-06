Public Class FA_Invoice
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	FA_Invoice
    ' Purpose				:	The class generates the invoice in pdf format
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	Rajanikant
    ' Created				:	Mar 22, 2004
    ' Revisions				:	
    '=====================================================================
    Private WithEvents oRpt As AdHocReports.Report.AdHocReport
    Private m_lngReportID As Long
    Private Const INVOICE_DETAIL As Long = 997
    Private Const INVOICE_TEAMBILLING As Long = 998
    Private Const INVOICE_SUMMARY As Long = 999
    Private Const INVOICE_MILESTONE As Long = 1005
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.ApplySecurity(True)
        'End of Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection

        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strFileName As String
        Dim strFilePath As String
        Dim strFormat As String
        Dim strSQL As String
        Dim strInvoiceType As String

        Dim lngInvoiceID As Long
        Dim dr As IDataReader
        Dim blnUseSQL As Boolean

        ' the report id
        lngInvoiceID = CType(Request.QueryString("InvoiceID"), Long)

        ' use sql?
        blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        ' we need pdf only
        strFormat = "PDF"

        dr = CommonFunctions.Data.GetDataReader("usp_Get_InvoiceType " & lngInvoiceID, blnUseSQL)
        If dr.Read Then
            strInvoiceType = dr(0).ToString
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        Select Case UCase(Trim(strInvoiceType & ""))
            Case "M" ' Milestone
                strSQL = "usp_rpt_Invoice_Milestone " & lngInvoiceID
                m_lngReportID = INVOICE_MILESTONE
            Case "S" ' Summary
                strSQL = "usp_rpt_invoice2 " & lngInvoiceID
                m_lngReportID = INVOICE_SUMMARY
            Case "D", "T" ' Detail
                strSQL = "usp_rpt_invoice1 " & lngInvoiceID
                m_lngReportID = INVOICE_DETAIL
            Case "F" ' Team Billing
                strSQL = "usp_rpt_Invoice_TeamBilling " & lngInvoiceID
                m_lngReportID = INVOICE_TEAMBILLING
            Case Else
                Exit Sub
        End Select

        ' The reports are created in the "Reports" folder
        strFilePath = CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Reports/"))

        ' get a unique file name
        strFileName = CommonFunctions.FileDirectory.GetUniqueFileName.Trim
        ' add extn to file name based on format requested
        strFileName += ".pdf"

        ' create object of Adhoc reports
        oRpt = New AdHocReports.Report.AdHocReport(m_lngReportID, strSQL, CommonFunctions.Application.ConnectionString, strFilePath + strFileName, CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))
        With oRpt
            .UseMSSQL = blnUseSQL
            .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
            .LCID = MyBase.CurrentThreadUICultureID
            If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                .UseHashTables = True
            Else
                .UseHashTables = False
            End If
            .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
            .CompanyName = CommonFunctions.Application.CompanyName
            .GraphImageGenerationAbsolutePath = Server.MapPath("../../Images/")

            ' generate the report in requested format
            .GenerateReport(AdHocReports.Format.PDF)
        End With
        oRpt = Nothing

        ' redirect the output
        With Response
            'Added and commented by PrashantD on 21 Aug 2007 for WhizFrameWork SP8
            '.Redirect("../CRW/CRW_ReportOutput.aspx?filename=" + strFileName, True)
            .Redirect("../CRW/CRW_ReportExport.aspx?FileName=" + strFileName, True)
            'End of addition by PrashantD on 21 Aug 2007
        End With

    End Sub
#Region "report writer events"

    Private Sub oRpt_Section_BeforePrint(ByVal sender As Object, ByVal e As System.EventArgs, ByVal Report As DataDynamics.ActiveReports.ActiveReport) Handles oRpt.Section_BeforePrint
        Dim section As DataDynamics.ActiveReports.Section
        Dim i As Integer
        Static blnLinePrinted As Boolean = False
        Static blnSet As Boolean = False
        Static strBankName As String
        Static strBkAccountNo As String
        Static strBankToAddress As String
        Static strRSwiftNo As String
        Static strGreeting As String
        Static dblAmount As Double
        Static dblDiscount As Double = 0
        section = CType(sender, DataDynamics.ActiveReports.Section)
        Select Case UCase(Trim(section.Name & ""))
            Case "REPORTFOOTER"
                For i = 0 To section.Controls.Count - 1
                    Select Case UCase(Trim(section.Controls(i).GetType.ToString & ""))
                        Case "DATADYNAMICS.ACTIVEREPORTS.TEXTBOX"
                            Select Case UCase(Trim(CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text & ""))
                                Case "BANKNAME" : CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = strBankName
                                Case "BKACCOUNTNO" : CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = strBkAccountNo
                                Case "BANKTOADDRESS" : CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = strBankToAddress
                                Case "RSWIFTNO" : CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = strRSwiftNo
                                Case "GREETINGMESSAGE" : CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = strGreeting
                                    ' Milestone Invoice Report ID 1005 specific controls
                                Case "DISCOUNT"
                                    If dblDiscount > 0 Then
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = " Discount " & FormatNumber(dblDiscount, 2) & " %:"
                                    Else
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Visible = False
                                    End If
                                Case "DISCOUNT_AMOUNT"
                                    If dblDiscount > 0 Then
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = FormatNumber(dblDiscount / 100 * dblAmount, 2)
                                    Else
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Visible = False
                                    End If
                                Case "GRAND_TOTAL"
                                    If dblDiscount > 0 Then
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = FormatNumber(dblAmount - (dblDiscount / 100 * dblAmount), 2)
                                    Else
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = FormatNumber(dblAmount, 2)
                                    End If
                                Case "TOTAL"
                                    If dblDiscount > 0 Then
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = CommonFunctions.General.NumToWord(dblAmount - (dblDiscount / 100 * dblAmount), "", "")
                                    Else
                                        CType(section.Controls(i), DataDynamics.ActiveReports.TextBox).Text = CommonFunctions.General.NumToWord(dblAmount, "", "")
                                    End If
                            End Select
                        Case "DATADYNAMICS.ACTIVEREPORTS.LINE"
                            If Not blnLinePrinted Then
                                section.Controls(i).Visible = True
                            Else
                                section.Controls(i).Visible = False
                            End If
                            blnLinePrinted = True
                    End Select
                Next
            Case "DETAIL"
                If Not blnSet Then
                    strBankName = Report.Fields("BankName").Value.ToString
                    strBkAccountNo = Report.Fields("BkAccountNo").Value.ToString
                    strBankToAddress = Report.Fields("BankToAddress").Value.ToString
                    strRSwiftNo = Report.Fields("RSwiftNo").Value.ToString
                    strGreeting = Report.Fields("GreetingMessage").Value.ToString
                    If m_lngReportID = INVOICE_MILESTONE Then
                        dblDiscount = CType(CommonFunctions.Data.CheckIsDBNull(Report.Fields("Discount").Value, "0"), Double)
                    End If
                    If Trim(strBankName & "") = "" Then strBankName = "___"
                    If Trim(strRSwiftNo & "") = "" Then strRSwiftNo = "___"
                End If
                blnSet = True

                ' get the total amount
                If Trim(Report.Fields("Amount").Value.ToString & "") <> "" Then
                    dblAmount += CType(Report.Fields("Amount").Value, Double)
                End If
        End Select
    End Sub

    Private Sub oRpt_Control_BeforePlot(ByRef Cancel As Boolean, ByRef Args As AdHocReports.WAF_Control) Handles oRpt.Control_BeforePlot
        If UCase(Trim(Args.ControlName & "")) = "<REPORT_COMPANYNAME>" Then
            Args.ControlText = "INVOICE"
        End If
    End Sub
#End Region

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class

