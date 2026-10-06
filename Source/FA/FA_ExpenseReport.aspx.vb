'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  Whizible
' Module Name           :  FA_ExpenseReport.aspx
' Purpose               :  
' Description           :  To print the Expense Report.
' Dependencies          :  None
' Author                :  PrakashR
' Reviewed              :  
' Tested                :  
' Created               :  April 27, 2004
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports System.Text
Imports WebPages.Template
Imports WebPages.Security
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports AdHocReports.Report
#End Region

Public Class FA_ExpenseReport
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_strProjectName As String = ""
    Private m_strEntryDate As String = ""
    Private m_strProjName As String = ""
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Protected m_strWindowTitle As String = ""
    Private m_strReportHeader As String = ""
    Private m_strDaily As String = ""
    Private m_strWeekly As String = ""
    Private m_strBiWeekly As String = ""
    Private m_strBiMonthly As String = ""
    Private m_strDateRange As String = ""
    Protected m_strDADate As String = ""
    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Private WithEvents m_objExpenseReportGrid As New GenericGrid
    Private WithEvents m_objStaticMenu As New StaticMenu
#End Region

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.FA_ExpenseReport", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strType As String = Request("rdPeriod")

        'This will set the title of the popup window.
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE")

        If strType <> "" Then
            Session("StrType") = strType
            Session("DateFrom") = Nothing
            Session("DateTo") = Nothing
        Else
            strType = Session("StrType").ToString
        End If

        Select Case strType
            Case "Daily" : m_strDaily = "Checked"
            Case "Weekly" : m_strWeekly = "Checked"
            Case "BiWeekly" : m_strBiWeekly = "Checked"
            Case "BiMonthly" : m_strBiMonthly = "Checked"
            Case "DateRange" : m_strDateRange = "Checked"
        End Select

        m_strDADate = Request("DADate")
        If m_strDADate <> "" Then Session("DADate") = m_strDADate

        m_strFromDate = Request("DateFrom")
        m_strToDate = Request("DateTo")
        If m_strFromDate <> "" Then Session("DateFrom") = m_strFromDate
        If m_strToDate <> "" Then Session("DateTo") = m_strToDate
    End Sub

    Private Sub m_objExpenseReportGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) _
                    Handles m_objExpenseReportGrid.ColumnHeaderTD_BeforePrint
        'We do not render the Entry Date column, but add a table cell there to keep the table proportionate
        If Args.ColIndex = 0 Then
            Cancel = True
            Args.StringToBeInserted = "<TD></TD>"
        End If
    End Sub

    Private Sub m_objExpenseReportGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) _
                    Handles m_objExpenseReportGrid.DataRowTD_BeforePrint

        'Since the generic grid does not handle grouping on multiple rows,
        'we handle the rendering of the two rows ourself.
        If Args.ColIndex = 0 Or Args.ColIndex = 1 Then
            'Do not render the two rows of EntryDate and ProjectName
            Cancel = True
            Args.StringToBeInserted = "<td></td>"
        End If

        Select Case Args.ColumnName
            Case "Cash", "Cheque", "Credit", "Credit Card"
                Cancel = True
            Case Else
                Return
        End Select

        If Args.ColumnName = "Cash" And Args.DataReader("PaymentMode").ToString = "Cash" Then
            Args.StringToBeInserted = "<TD align=right>" & FormatNumber(Args.DataReader("Amount").ToString, 2) & "</TD>"
        ElseIf Args.ColumnName = "Cheque" And Args.DataReader("PaymentMode").ToString = "Cheque" Then
            Args.StringToBeInserted = "<TD align=right>" & FormatNumber(Args.DataReader("Amount").ToString, 2) & "</TD>"
        ElseIf Args.ColumnName = "Credit" And Args.DataReader("PaymentMode").ToString = "Credit" Then
            Args.StringToBeInserted = "<TD align=right>" & FormatNumber(Args.DataReader("Amount").ToString, 2) & "</TD>"
        ElseIf Args.ColumnName = "Credit Card" And Args.DataReader("PaymentMode").ToString = "Credit Card" Then
            Args.StringToBeInserted = "<TD align=right>" & FormatNumber(Args.DataReader("Amount").ToString, 2) & "</TD>"
        Else
            Args.StringToBeInserted = "<TD align=right>0</TD>"
        End If

    End Sub

    Private Sub m_objExpenseReportGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) _
                    Handles m_objExpenseReportGrid.DataRowTR_BeforePrint
        Dim strInsertString As String
        Dim strPrevEntryDate As String = m_strEntryDate
        Dim strPrevProjectName As String = m_strProjectName

        'If the Entry Date has changed, save it.
        If m_strEntryDate <> Args.DataReader.Item("EntryDate").ToString Then
            m_strEntryDate = Args.DataReader.Item("EntryDate").ToString
        End If

        'If the Project Name has changed, save it.
        If m_strProjectName <> Args.DataReader.Item("ProjectName").ToString Then
            m_strProjectName = Args.DataReader.Item("ProjectName").ToString
        End If

        'If the Entry Date has changed, we need to render both the Entry Date and the Project Name rows.
        If strPrevEntryDate <> m_strEntryDate Then
            strInsertString = "<TR class='clsTRSectionHeader'><TD colspan=10 width=100%>" & CommonFunctions.Dates.CGetDate(Date.Parse(m_strEntryDate)) & "</TD></TR>" & _
                              "<TR><TD colspan=10 width=100%></TD></TR>" & _
                              "<TR class='clsTRSectionHeader'><TD colspan=10 width=100%>&nbsp;&nbsp;&nbsp;&nbsp;" & m_strProjectName & "</TD></TR>"
            Args.StringToBeInserted = strInsertString
            Exit Sub
        End If

        'If the Project Name changes, we leave out the Entry Date and print the Project Name only.
        If strPrevProjectName <> m_strProjectName Then
            strInsertString = "<TR class='clsTRSectionHeader'><TD colspan=10 width=100%>&nbsp;&nbsp;&nbsp;&nbsp;" & m_strProjectName & "</TD></TR>"
            Args.StringToBeInserted = strInsertString
            Exit Sub
        End If

    End Sub

#Region "Functions and Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   PrakashR
        ' Created               :   April 27, 2004
        ' Revisions             :   
        '=====================================================================
        Call GetGlobalObject()
        If Request("Mode") = "Print" Then
            Call DrawPrintPreview()
            WriteHTML("<BR>")
            Call DrawGrid()
            Exit Sub
        End If

        Call DrawMenu()
        WriteHTML("<BR>")
        WriteHTML(PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("CAPTION"), , , True))
        WriteHTML("<BR>")
        Call DrawOptionButtons()
        WriteHTML("<BR>")
        If Session("StrType").ToString = "DateRange" Then
            Call DrawDateRangeControls()
        End If
        Call DrawGrid()
        WriteHTML("<BR>")
        Call DrawMenu()
        WriteHTML("<BR>")
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub DrawMenu()
        '====================================================================
        ' Procedure Name        :  DrawMenu
        ' Parameters Passed     :  None 
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  Initialization of the menu
        ' Description           :  This function renders the menu for report generation in various formats
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             : 
        '=====================================================================
        Dim strMenu As String
        If Session("StrType").ToString = "DateRange" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("VIEW_REPORT"), MyBase.GetResourceString("PRINT_PREVIEW")}
            Dim arrMenuTooltip() As String = {MyBase.GetResourceString("VIEW_REPORT_TOOLTIP"), _
                                              MyBase.GetResourceString("PRINT_PREVIEW_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"ViewReport_OnClick()", "PrintPreview_OnClick(" & Request("ReportType") & ")"}
            m_objStaticMenu = New StaticMenu
            strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)
        Else
            Dim arrMenu() As String = {MyBase.GetResourceString("PRINT_PREVIEW")}
            Dim arrMenuTooltip() As String = {MyBase.GetResourceString("PRINT_PREVIEW_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"PrintPreview_OnClick(" & Request("ReportType") & ")"}
            m_objStaticMenu = New StaticMenu
            strMenu = m_objStaticMenu.DrawMenu(arrMenu, arrClientSideFunctions, arrMenuTooltip, True)
        End If
        WriteHTML(strMenu)
    End Sub

    Private Sub DrawOptionButtons()
        '====================================================================
        ' Procedure Name        :  DrawOptionButtons
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the option buttons
        ' Description           :  This sub-routine renders the option buttons 
        '                                  needed for the type of task reports.                     
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             :  
        '=====================================================================
        Dim objHeader As HeaderFooter
        Dim strOptionButtons As New StringBuilder

        strOptionButtons.Append("<center>")
        strOptionButtons.Append(HTMLControls.DrawOptionButton("rdPeriod", "rdPeriod", , , "Daily", , m_strDaily & " onclick=Radio_OnClick(1)", True))
        strOptionButtons.Append(" <B>" & MyBase.GetResourceString("DAILY") & "<B>&nbsp;&nbsp;&nbsp;")
        strOptionButtons.Append(HTMLControls.DrawOptionButton("rdPeriod", "rdPeriod", , , "Weekly", , m_strWeekly & " onclick=Radio_OnClick(2)", True))
        strOptionButtons.Append(" <B>" & MyBase.GetResourceString("WEEKLY") & "<B>&nbsp;&nbsp;&nbsp;")
        strOptionButtons.Append(HTMLControls.DrawOptionButton("rdPeriod", "rdPeriod", , , "BiWeekly", , m_strBiWeekly & " onclick=Radio_OnClick(3)", True))
        strOptionButtons.Append(" <B>" & MyBase.GetResourceString("BI_WEEKLY") & "<B>&nbsp;&nbsp;&nbsp;")
        strOptionButtons.Append(HTMLControls.DrawOptionButton("rdPeriod", "rdPeriod", , , "BiMonthly", , m_strBiMonthly & " onclick=Radio_OnClick(4)", True))
        strOptionButtons.Append(" <B>" & MyBase.GetResourceString("BI_MONTHLY") & "<B>&nbsp;&nbsp;&nbsp;")
        strOptionButtons.Append(HTMLControls.DrawOptionButton("rdPeriod", "rdPeriod", , , "DateRange", , m_strDateRange & " onclick=Radio_OnClick(5)", True))
        strOptionButtons.Append(" <B>" & MyBase.GetResourceString("DATE_RANGE") & "<B>&nbsp;&nbsp;&nbsp;")
        strOptionButtons.Append("</center>")

        objHeader = New HeaderFooter
        objHeader.HeaderFooter = strOptionButtons.ToString()
        WriteHTML(objHeader.DrawHeaderFooter(m_objGlobal, True))
    End Sub

    Private Sub DrawDateRangeControls()
        '====================================================================
        ' Procedure Name        :  DrawDateRangeControls
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the Date controls
        ' Description           :  This sub-routine renders the date range controls
        '                                  required for Date Range option
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             :  
        '=====================================================================
        Dim strDateRange As New StringBuilder
        Dim objHeader As HeaderFooter

        WriteHTML("<TABLE width=99.9% cellpadding=0 cellspacing=0 border=0 class=clsTable>")
        WriteHTML("<TR class=clsTREven>")
        WriteHTML("<TD align=right class=clsTDOdd>")
        WriteHTML(MyBase.GetResourceString("DATE_FROM"))
        If Not (Session("DateFrom") Is Nothing) Then
            WriteHTML(HTMLControls.DrawDateControl("DateFrom", "DateFrom", , , Session("DateFrom").ToString, , "frmFA_ExpenseReport"))
        Else
            WriteHTML(HTMLControls.DrawDateControl("DateFrom", "DateFrom", , , Request("DateFrom"), , "frmFA_ExpenseReport"))
        End If
        WriteHTML("</TD>")
        WriteHTML("<TD align=right class=clsTDOdd>&nbsp;")
        WriteHTML("</TD>")
        WriteHTML("<TD align=left class=clsTDOdd>")
        WriteHTML(MyBase.GetResourceString("DATE_TO"))
        If Not (Session("DateTo") Is Nothing) Then
            WriteHTML(HTMLControls.DrawDateControl("DateTo", "DateTo", , , Session("DateTo").ToString, , "frmFA_ExpenseReport"))
        Else
            WriteHTML(HTMLControls.DrawDateControl("DateTo", "DateTo", , , Request("DateTo"), , "frmFA_ExpenseReport"))
        End If
        WriteHTML("<TD>")
        WriteHTML("</TR>")
        WriteHTML("</TABLE>")
        WriteHTML("<BR>")
    End Sub

    Private Sub DrawPrintPreview()
        '====================================================================
        ' Procedure Name        :  DrawPrintPreview
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the PrintPreview mode
        ' Description           :  same
        ' Assumptions           :  none
        ' Dependencies          :  none
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             :  
        '=====================================================================
        Dim drDataReader As IDataReader
        drDataReader = GetDataReader("EXEC usp_sel_DailyActivityEmployeeInfo " & Session("intUserID").ToString, True)

        drDataReader.Read()

        'Company Name
        WriteHTML("<TABLE width=99.9% cellpadding=0 cellspacing=0 border=0 class=clsTable>")
        WriteHTML("<TR width=100% class=clsTREven>")
        WriteHTML("<TD width=50% align=right class=clsTDOdd>")
        WriteHTML("<B><FONT SIZE=2>Company Name : </FONT></B>")
        WriteHTML("</TD>")
        WriteHTML("<TD width=50% align=left class=clsTDOdd>")
        WriteHTML("<FONT SIZE=2>" & drDataReader.Item("CompanyName").ToString & "</FONT>")
        WriteHTML("</TD>")
        WriteHTML("</TR>")
        'Employee Name
        WriteHTML("<TR width=100% class=clsTREven>")
        WriteHTML("<TD width=50% align=right class=clsTDOdd>")
        WriteHTML("<B><FONT SIZE=2>Employee Name : </FONT></B>")
        WriteHTML("</TD>")
        WriteHTML("<TD width=50% align=left class=clsTDOdd>")
        WriteHTML("<FONT SIZE=2>" & drDataReader.Item("EmployeeName").ToString & "</FONT>")
        WriteHTML("</TD>")
        WriteHTML("</TR>")
        'Department
        WriteHTML("<TR width=100% class=clsTREven>")
        WriteHTML("<TD width=50% align=right class=clsTDOdd>")
        WriteHTML("<B><FONT SIZE=2>Department : </FONT></B>")
        WriteHTML("</TD>")
        WriteHTML("<TD width=50% align=left class=clsTDOdd>")
        WriteHTML("<FONT SIZE=2>" & drDataReader.Item("Department").ToString & "</FONT>")
        WriteHTML("</TD>")
        WriteHTML("</TR>")
        'Designation
        WriteHTML("<TR width=100% class=clsTREven>")
        WriteHTML("<TD width=50% align=right class=clsTDOdd>")
        WriteHTML("<B><FONT SIZE=2>Role Description : </FONT></B>")
        WriteHTML("</TD>")
        WriteHTML("<TD width=50% align=left class=clsTDOdd>")
        WriteHTML("<FONT SIZE=2>" & drDataReader.Item("Roledescription").ToString & "</FONT>")
        WriteHTML("</TD>")
        WriteHTML("</TR>")
        WriteHTML("</TABLE>")
        CommonFunction.Data.DisposeDataReader(drDataReader)
    End Sub

    Private Sub DrawBackPrint()
        '====================================================================
        ' Procedure Name        :  DrawBackPrint()
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the Back and Print links.
        ' Description           :  This Sub-routine renders the Back and Print 
        '                               links whenever the reports are viewed in 
        '                               Print Preview Mode.
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             :  
        '=====================================================================
        Dim objBackLink As WebPages.UI.cDynamicLink
        Dim objPrintLink As WebPages.UI.cDynamicLink

        objBackLink = New WebPages.UI.cDynamicLink
        objBackLink.LinkName = MyBase.GetResourceString("BACK")
        objBackLink.FunctionName = "Back_OnClick(" & Request("ReportType") & ")"
        objBackLink.ReturnHTML = True

        objPrintLink = New WebPages.UI.cDynamicLink
        objPrintLink.LinkName = MyBase.GetResourceString("PRINT")
        objPrintLink.FunctionName = "Print_OnClick()"
        objPrintLink.ReturnHTML = True

        WriteHTML("<TABLE width=99.9% cellpadding=0 cellspacing=0 border=0 class=clsTable>")
        WriteHTML("<TR width=100% class=clsTREven>")
        WriteHTML("<TD width=50% align=right class=clsTDOdd>")
        WriteHTML(objBackLink.GetDynamicLink() & "&nbsp;&nbsp;&nbsp;")
        WriteHTML("</TD>")
        WriteHTML("<TD width=50% align=left class=clsTDOdd>")
        WriteHTML(objPrintLink.GetDynamicLink())
        WriteHTML("</TD>")
        WriteHTML("</TR>")
        WriteHTML("</TABLE>")
    End Sub

    Private Sub DrawGrid()
        '====================================================================
        ' Procedure Name        :  DrawGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To render the grid
        ' Description           :  This sub-routine renders the grid to show the expense report
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PrakashR
        ' Created               :  April 27, 2004
        ' Revisions             :  
        '=====================================================================

        Dim arrSummaryFunctions() As String = {"", "", "", "", "", "", "", "", "SUM"}
        Dim strGridHTML As String
        Dim drTotal As IDataReader
        Dim decTotalAmount As Decimal = 0

        Dim arrUserFriendlyNames() As String = {"", MyBase.GetResourceString("PROJECT_NAME"), _
                                                MyBase.GetResourceString("SUB_ITEM_NAME"), _
                                                MyBase.GetResourceString("DESCRIPTION"), _
                                                MyBase.GetResourceString("CASH"), _
                                                MyBase.GetResourceString("CHEQUE"), _
                                                MyBase.GetResourceString("CREDIT"), _
                                                MyBase.GetResourceString("CREDIT_CARD"), _
                                                MyBase.GetResourceString("AMOUNT")}
        Dim arrActualNames() As String = {"EntryDate", "ProjectName", "SubItemName", "Description", "PaymentMode", "PaymentMode", "PaymentMode", "PaymentMode", "Amount"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        With m_objExpenseReportGrid
            .ActualColumnArray = arrActualNames
            .UserFriendlyColumnArray = arrUserFriendlyNames
            .SummaryFunctions = arrSummaryFunctions
            .NoOfDataColumns = 9
            .EmptyValueReplacement = " "
            .ColumnHeaderAlignment = "right"

            If Session("StrType").ToString = "DateRange" Then
                If Session("DateFrom") Is Nothing Or Session("DateTo") Is Nothing Then
                    .SQL = "EXEC usp_Expense_DailyActivityReports 5, '" & Request("DateFrom") & "', " & Session("intUserID").ToString & ", '" & Request("DateTo") & "'"
                Else
                    .SQL = "EXEC usp_Expense_DailyActivityReports 5, '" & Session("DateFrom").ToString & "', " & Session("intUserID").ToString & ", '" & Session("DateTo").ToString & "'"
                End If
            Else
                .SQL = "EXEC usp_Expense_DailyActivityReports " & Request("ReportType").ToString & ", '" & Session("DADate").ToString & "', " & Session("intUserID").ToString & ",''"
            End If

            .DIVHeight = 0
            .ColNameToolTipOnEachRow = True

            .returnHTML = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            strGridHTML = .DrawGrid
        End With

        drTotal = GetDataReader(m_objExpenseReportGrid.SQL, True)

        m_objExpenseReportGrid = Nothing

        If Request("Mode") <> "Print" Then WriteHTML("<DIV id='PageDiv' style='width:100%;overflow:auto;'>")
        WriteHTML(strGridHTML)

        While drTotal.Read
            decTotalAmount = decTotalAmount + Decimal.Parse(drTotal("Amount").ToString)
        End While
        CommonFunction.Data.DisposeDataReader(drTotal)
        'Here we calculate the Total hours of work for the selected tasks
        Dim strTotal As String
        strTotal = MyBase.GetResourceString("TOTAL_AMOUNT") & FormatNumber(decTotalAmount, 2)
        WriteHTML(PageCaption.GetPageCaptions(m_objGlobal, , strTotal, , True))
        WriteHTML("<BR>")
        WriteHTML("</DIV>")
        If Request("Mode") = "Print" Then Call DrawBackPrint()
    End Sub

#End Region

End Class
