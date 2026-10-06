
Public Class RFI_ProjectExpensesSelection
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
    Public intRFIID As Integer
    Public strUserType As String

    Private m_objGlobal As WebPages.Template.IGlobal 'for global object
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objAdvGrid As New WebPage.Templates.AdvancedGrid ' to plot grid
    Private arrMenuList As New ArrayList       'To store the column Headings
    Private arrClientSideFunctionNames As New ArrayList
    Private arrMenuToolTipList As New ArrayList
    Private strMenu As String = ""
    Private m_strExpenseYear As String = ""
    Private m_strExpenseMonth As String = ""
    Private m_strCurrencyCode As String = ""
    Private m_intGroupNumber As Integer = -1
    Private m_strCostHead As String = ""
    Private m_strEmployeeName As String = ""
    Private m_GroupTotal As Double = 0
    Private m_dblExpMonthGroupTotal As Double = 0
    Private m_dblCostHead As Double = 0
    Private m_dblEmployeewise As Double = 0
    Private m_ExpenseYearGroupTotal As Double = 0
    Private m_blnTaskGridDataPresent As Boolean
    Private m_blnInitialGrid As Boolean
    Private m_blnSelectChk As Boolean
    Private m_blnChecked As Boolean
    Private m_sCurrencyCode As String = ""
    Public m_sExpensesEntryID As String = ""
    Private m_iExpenseEntryList As New ArrayList
    Private strQuery As String = ""
    Private iFilterCurrencyID As Integer
    Private iFilterCostHeadID As Integer
    Private m_iCurrencyGroup As Integer = 0
    Private m_iExpenseYearGroup As Integer = 0
    Private m_iExpenseMonthGroup As Integer = 0
    Private m_iCostHeadGroup As Integer = 0
    Private m_sExpenseYear As String
    Private m_sExpenseMonth As String = ""
    Private m_srCurrencyCode As String = ""
    Private m_dblTotalPrjExpenseAmount As Double = 0
    Private m_sCostHead As String = ""
    Private m_sEmployeeName As String = ""
    Private m_sProjectBillingCurrencyCode As String = ""
    Private m_dblConvertedToPrjCurGroupTotal As Double = 0
    Private m_strConverstionRateAlert As String = ""
    'Added by MonikaI on 18-Sep-2006 .IssueID : 6197 (Security)
    Protected m_strToken As String
    'm_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))

#End Region

#Region "Functions and Procedures"
    Public Sub PageInit()
        '=====================================================================
        ' Function Name   :   PageInit
        ' Purpose       :   To Display the Expenses
        ' Description   :   Same as above
        ' Dependencies  :   Resource file for the same
        ' Author        :   PrashantSJ
        ' Created       :   20 June 2006
        ' Revisions     :
        '######### Page Code starts here
        '========================================================================

        DrawPage()

        DisposeObjects()

    End Sub

    Public Sub New()

        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.RFI_ProjectExpensesSelection", "AppResources")
    End Sub

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AmitD
        ' Created               : Jul 10, 2004
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    '=====================================================================
    ' Procedure Name        : GetGlobalObject()	
    ' Purpose               : Function To Fill Global Object
    ' Description           : same as above
    ' Parameters Passed     : None
    ' Returns               : None
    ' Parameters Affected   : None
    ' Assumptions           : None
    ' Dependencies          : None
    ' Author                : DipaliS
    ' Created               : July 29, 2004
    ' Revisions             :
    '=====================================================================

    Private Sub GetGlobalObject()
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim m_strUserType As String
        m_strUserType = Trim(Request.QueryString("UserType"))
        m_strToken = ""
        If Request.Form("txtHiddenToken") Is Nothing Then
            m_strToken = Request.QueryString("PKToken") & ""
        Else
            m_strToken = Request.Form("txtHiddenToken")
        End If
        'm_strToken = HttpContext.Current.Request.QueryString("PKToken").ToString
        If m_strUserType = "Initiator" Then
            If CommonFunctions.Security.Token.ValidateToken(HttpContext.Current.Request.QueryString("RFIID").ToString + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String), m_strToken) = False Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("IR/PIR", CType(2044, Long), CType(0, Long), "RFIID", HttpContext.Current.Request.QueryString("RFIID").ToString)

                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        Initialize()
    End Sub
    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page.
        ' Description           : Also gets the various User Preferences from the Database and 
        '                         information from the Querystring
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js
        ' Author                : PrashantSJ
        ' Created               : 20th June 2006
        ' Revisions             : 
        '=====================================================================
        'To Get the Global object like..ProjectID
        GetGlobalObject()

        intRFIID = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RFIID"), "0"), Integer)

        strUserType = CommonFunction.General.CheckIsNothing(Request.QueryString("UserType"), "").ToString


        m_sExpensesEntryID = CommonFunction.General.CheckIsNothing(Request.QueryString("ExpensesEntryID"), "").ToString

        strQuery = "usp_Sel_tbl_PM_Project_Billing_Currency " & m_objGlobal.ProjectID.ToString
        m_sProjectBillingCurrencyCode = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), String)

        If CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboCurrency"), "") <> "" Then
            iFilterCurrencyID = CType(MyBase.GetFormValue("cboCurrency"), Integer)
        Else
            iFilterCurrencyID = 0
        End If

        If CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboCostHead"), "") <> "" Then
            iFilterCostHeadID = CType(MyBase.GetFormValue("cboCostHead"), Integer)
        Else
            iFilterCostHeadID = 0
        End If

        If Request.QueryString("Mode") = "true" Then

            strQuery = "usp_IRExpenseItem_ConverstionRate_Validation " & intRFIID.ToString & ",'" & CommonFunctions.General.BuildQueryString(m_sExpensesEntryID.ToString) & "'"
            m_strConverstionRateAlert = CType(CommonFunction.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), ""), ""), String)
            Response.Write("<script LANGUAGE=javascript>")

            If m_strConverstionRateAlert.ToUpper = "NO_IRCOMPANY_BASE_CONVERSRIONRATE" Then
                Response.Write("alert('Currently, no billing (expense currency) to IR company base conversion is rate defined. Please define it !');")
            ElseIf m_strConverstionRateAlert.ToUpper = "NO_CORPORATE_BASE_CONVERSRIONRATE" Then
                Response.Write("alert('Currently, no billing (expense currency) to corporate base conversion rate is defined. Please define it ! ');")
            Else
                strQuery = ""
                strQuery = " Exec usp_Ins_ProjectExpenses_RFIItems " & m_objGlobal.ProjectID.ToString & "," & intRFIID.ToString & ",'" & CommonFunctions.General.BuildQueryString(m_sExpensesEntryID.ToString) & "' ,'" & CommonFunctions.General.BuildQueryString(m_objGlobal.UserName) & "'"
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                'Response.Write("window.opener.location.href=""RFI_RFI.aspx?Mode=Edit&UserType=" & strUserType & "&RFIID=" & intRFIID & """;")
                Response.Write("window.opener.location.href=""RFI_RFI.aspx?Mode=Edit&UserType=" & strUserType & "&RFIID=" & intRFIID & "&PKToken=" & m_strToken & """;")
                Response.Write("window.close();")
            End If
            Response.Write("</script>")
        End If


    End Sub
    Private Sub DrawPage()
        '=====================================================================
        ' Function Name         : DrawPage
        ' Purpose               : Displays the page depending on the Action required
        ' Description           : 
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PrashantSJ 
        ' Created               : 20 June 2006
        ' Revisions             : 
        '=====================================================================
        DrawMenu()
        CommonFunction.General.WriteHTML(strMenu)
        Response.Write("<BR>")

        DrawHeader()
        Response.Write("<BR>")
        PlotFilters()
        Response.Write("<BR>")
        'Display the grid depending upon the Action

        DisplayGrid()
        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

    End Sub
    Private Sub DisposeObjects()
        '====================================================================
        ' Procedure Name        : DisposeObjects
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Dispose all the objects
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : PrashantSJ 
        ' Created               : 20th June 2006
        ' Revisions             :
        '=====================================================================
        m_objGlobal = Nothing
        m_objAdvGrid = Nothing
        m_objMenu = Nothing

    End Sub
    Private Sub DrawMenu()
        'm_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
        arrMenuList.Add(MyBase.GetResourceString("MENU_CREATE_INVOICE_ITEM")) '("Create Invoice Item")
        arrMenuList.Add(MyBase.GetResourceString("MENU_CLOSE")) '"Close")
        arrMenuList.Add("?")
        arrClientSideFunctionNames.Add("CreateInvoiceItem_OnClick()")
        arrClientSideFunctionNames.Add("Close_OnClick()")
        arrClientSideFunctionNames.Add("Help_OnClick()")
        arrMenuToolTipList.Add(MyBase.GetResourceString("TOOLTIP_CREATE_INVOICE_ITEM"))
        arrMenuToolTipList.Add(MyBase.GetResourceString("TOOLTIP_CLOSE"))
        arrMenuToolTipList.Add("Help")

        strMenu = m_objMenu.DrawMenuWithEvents(GetArray(arrMenuList), GetArray(arrClientSideFunctionNames), GetArray(arrMenuToolTipList), True)

    End Sub
    Private Sub DrawHeader()
        '====================================================================
        ' Procedure Name        : DrawHeader
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Draws the page Header thr' global object
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : PrashantSJ
        ' Created               : 20th June 2006
        ' Revisions             :
        '=====================================================================
        Response.Write(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), , , ))
        Response.Write("<BR>")
    End Sub

    Private Sub DisplayGrid()
        PlotOtherHiddenControls()
        Dim strSQLQuery As String = ""
        Dim strWhereClause As String = ""
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQLQuery = "usp_Sel_ProjectExpenses_IR " & m_objGlobal.ProjectID.ToString & "," & intRFIID.ToString & "," & iFilterCurrencyID.ToString & "," & iFilterCostHeadID.ToString

        Dim arrActualColumns() As String = {"ExpensesEntryID", "CurrencyCode", "ExpenseYear", "ExpenseMonth", "CostHead", "EmployeeName", "Description", "Amount", ""}
        Dim arrUserFriendlyColumn() As String = {"ExpensesEntry ID", "Currency ", "Expenses Year", "Expenses Month", "Cost Head", "Employee Name", "Description", "Amount", "Select"}
        Dim arrChkBox() As String = {"", "", "", "", "", "", "", "", "chkSelect"}
        Dim arrGroupOnFunction() As String = {"", "1", "", "", "", "", "", "", ""}
        '  Dim ArrTDStyle() As String = {"", "align=left width=10%", "align=left width=10%", "align=left width=10%", "align=left width=15%", "align=left width=15%", "align=left width=20%", "align=right width=3%", "align=center width=5%"}
        ' Dim arrGroupOnFunction() As String = {"", "Currency Code", "Expense Year", "Expense Month", "Cost Head", "Employee Name", "", "", ""}
        Dim arrGroupSummaryFunc() As String = {"", "", "", "", "", "", "SUM", ""}
        Dim summaryfunction() As String = {"", "", "", "", "", "", "SUM", ""}
        'Set the Advanced Grid Properties
        Dim dr As IDataReader
        dr = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
        If dr.Read Then
            m_blnTaskGridDataPresent = True
        End If

        CommonFunction.Data.DisposeDataReader(dr)

        With m_objAdvGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrChkBox
            '  .TDStyleArray = ArrTDStyle
            .SQL = strSQLQuery
            .DIVID = "divList"
            .DIVHeight = 400
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = arrActualColumns.Length - 1 '8
            .ColNameToolTipOnEachRow = True
            .UseSQL = MyBase.UseSQL
            .PrimaryKey = "ExpensesEntryID"
            .GroupOnColumn = arrGroupOnFunction
            .GroupSummaryFunc = arrGroupSummaryFunc
            .SummaryFunctions = summaryfunction
            '.ShowSummaryFunctions = True
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML(.DrawGrid())

        End With
    End Sub

    Public Sub PlotFilters()

        Dim strSQL As String
        strSQL = "usp_Sel_ProjectExpenses_Currency_CostHead " & m_objGlobal.ProjectID.ToString & "," & intRFIID.ToString & ", 1"
        CommonFunctions.General.WriteHTML("<TABLE cellspacing='0' cellpadding='0' Width='100%' class='clsTable'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='left'><b>" & MyBase.GetResourceString("FILTER_CURRENCY_HEADING") & " </b>&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboCurrency", strSQL, , iFilterCurrencyID.ToString, "onChange=ApplyCurrencyFilter();", True)
        CommonFunctions.General.WriteHTML("</td>")
        strSQL = "usp_Sel_ProjectExpenses_Currency_CostHead " & m_objGlobal.ProjectID.ToString & "," & intRFIID.ToString & ", 2"
        CommonFunctions.General.WriteHTML("<td align='left'><B>" & MyBase.GetResourceString("FILTER_COSTHEAD_HEADING") & "</b>&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboCostHead", strSQL, , iFilterCostHeadID.ToString, "onChange=ApplyCostHeadFilter();", True)
        CommonFunctions.General.WriteHTML("</B></td>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
    End Sub


#End Region
#Region "Grid Events"

    Private Sub m_objAdvGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objAdvGrid.ColumnHeaderTD_BeforePrint
        'To Hide the ExpensesEntryID Column Header
        If Args.ColIndex = 0 Then
            Cancel = True
        End If
    End Sub

    Private Sub m_objAdvGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objAdvGrid.DataRowTD_BeforePrint


        If Args.ColIndex = 0 Then
            Cancel = True 'hide the ExpensesEntryID
        ElseIf Args.ColIndex = 1 Then
            'Determine stylesheet for row
            If Args.NoOfRowsPrinted Mod 2 = 0 Then
                'While cancelling TD, TR will also get cancelled. hence add <TR>, grid class will close it.
                Args.StringToBeInserted = "<TR class='clsTREven'><TD align='left'></TD>"
            Else
                Args.StringToBeInserted = "<TR class='clsTROdd'><TD align='left'></TD>"
            End If
            Cancel = True
        ElseIf Args.ColIndex = 2 Or Args.ColIndex = 3 Or Args.ColIndex = 4 Or Args.ColIndex = 5 Then
            Args.StringToBeInserted = "<TD align='left'></TD>"
            Cancel = True
        ElseIf Args.ColIndex = 8 Then
            'To plot the Select Checkbox
            Args.StringToBeInserted = "<TD align='center'>" & CommonFunction.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , , Args.DataReader("ExpensesEntryID").ToString, , " onclick='javascript:chkExpensesEntryID_Click(this)'", True) & "</TD>"
            'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted += "<TD align='left'>" & CommonFunction.HTMLControls.DrawTextBox("txtCurrency" + Args.DataReader("ExpensesEntryID").ToString, "txtCurrency" + Args.DataReader("ExpensesEntryID").ToString, , , , Args.DataReader("CurrencyCode").ToString, , , , , , True, , True, EnableHTMLEncode:=True) & " </TD>"
            'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
            Cancel = True
        End If

    End Sub

    Private Sub m_objAdvGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objAdvGrid.DataRowTR_BeforePrint

        m_blnTaskGridDataPresent = True
        'Total Project Expenses amount
        If CType(Args.DataReader("ConversionRate"), Double) > 0 Then
            m_dblTotalPrjExpenseAmount += (CType(Args.DataReader("Amount"), Double) * CType(Args.DataReader("ConversionRate"), Double))
        Else
            m_dblTotalPrjExpenseAmount += 0

        End If

        'Currency Group
        If m_strCurrencyCode <> Args.DataReader("CurrencyCode").ToString.Trim + "" Then



            If m_blnInitialGrid = True Then
                If m_GroupTotal >= 0 Then
                    'Insert sum for the Currency Code
                    'm_dblConvertedToPrjCurGroupTotal

                    Args.StringToBeInserted += "<TR class='clsTRGroupHeader' ><TD align='left' colspan=6><FONT color=blue>" & MyBase.GetResourceString("TOTAL_CURRENCY_AMOUNT") & "&nbsp;" & m_strCurrencyCode & "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD><TD align='left'></TD></TR>"
                    ' Args.StringToBeInserted += "<TR class='clsTRGroupHeader' ><TD align='left' colspan=6><FONT color=blue>" & MyBase.GetResourceString("TOTAL_CURRENCY_AMOUNT") & "&nbsp;" & m_sProjectBillingCurrencyCode & "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_dblConvertedToPrjCurGroupTotal, 2).ToString + "</FONT></TD><TD align='left'></TD></TR>"
                End If
            End If
            m_blnInitialGrid = True
            'Initialize GroupSum to 0 for next group
            m_GroupTotal = 0
            m_dblConvertedToPrjCurGroupTotal = 0
            'reset CurrencyCode
            m_strCurrencyCode = Args.DataReader("CurrencyCode").ToString + ""
            'Insert TR which will have group value
            'Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left' colspan=9>" + Args.DataReader("CurrencyCode").ToString + "</FONT></TD></TR>"
            Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left'>" + Args.DataReader("CurrencyCode").ToString + "</FONT></TD>"

            m_GroupTotal += CType(Args.DataReader("Amount"), Double)

            If CType(Args.DataReader("ConversionRate"), Double) > 0 Then
                m_dblConvertedToPrjCurGroupTotal += (CType(Args.DataReader("Amount"), Double) * CType(Args.DataReader("ConversionRate"), Double))
            Else
                m_dblConvertedToPrjCurGroupTotal += 0
            End If

            m_strExpenseYear = ""
            m_strExpenseMonth = ""
            m_strCostHead = ""
            m_strEmployeeName = ""
            m_iCurrencyGroup += 1
            m_iCostHeadGroup = 0
            m_iExpenseMonthGroup = 0
            m_iExpenseYearGroup = 0
        Else
            'update GroupSum
            m_GroupTotal += CType(Args.DataReader("Amount"), Double)

            If CType(Args.DataReader("ConversionRate"), Double) > 0 Then
                m_dblConvertedToPrjCurGroupTotal += (CType(Args.DataReader("Amount"), Double) * CType(Args.DataReader("ConversionRate"), Double))
            Else
                m_dblConvertedToPrjCurGroupTotal += 0
            End If
        End If

        'Expenses Year Group
        If m_strExpenseYear <> Args.DataReader("ExpenseYear").ToString.Trim + "" Then

            If m_strExpenseYear <> Args.DataReader("ExpenseYear").ToString.Trim And m_strCurrencyCode = Args.DataReader("CurrencyCode").ToString.Trim Then
                If m_iCurrencyGroup = 1 Then
                    m_iCurrencyGroup = 0
                    Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("ExpenseYear").ToString + "</TD>"
                Else
                    Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left'>" + Args.DataReader("ExpenseYear").ToString + "</TD>"
                End If
            Else
                Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("ExpenseYear").ToString + "</TD>"
            End If

            m_strExpenseYear = Args.DataReader("ExpenseYear").ToString + ""

            m_strExpenseMonth = ""
            m_strCostHead = ""
            m_strEmployeeName = ""
            m_iExpenseYearGroup += 1
            m_iCostHeadGroup = 0
            m_iExpenseMonthGroup = 0

        End If

        'Expenses Month Group    
        If m_strExpenseMonth <> Args.DataReader("ExpenseMonth").ToString.Trim + "" Then

            If m_strExpenseMonth <> Args.DataReader("ExpenseMonth").ToString.Trim And m_strExpenseYear = Args.DataReader("ExpenseYear").ToString.Trim And m_strCurrencyCode = Args.DataReader("CurrencyCode").ToString.Trim Then
                If m_iExpenseYearGroup = 1 Then
                    m_iExpenseYearGroup = 0
                    Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("ExpenseMonth").ToString + "</TD>"
                Else
                    Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left'></TD><TD align='left'>" + Args.DataReader("ExpenseMonth").ToString + "</TD>"
                End If
            Else
                Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("ExpenseMonth").ToString + "</TD>"
            End If

            m_strExpenseMonth = Args.DataReader("ExpenseMonth").ToString + ""
            m_strCostHead = ""
            m_strEmployeeName = ""
            m_iExpenseMonthGroup += 1
            m_iCostHeadGroup = 0
        End If

        'Cost Head Group
        If m_strCostHead <> Args.DataReader("CostHead").ToString.Trim + "" Then
            If m_strCostHead <> Args.DataReader("CostHead").ToString.Trim And m_strExpenseMonth = Args.DataReader("ExpenseMonth").ToString.Trim And m_strExpenseYear = Args.DataReader("ExpenseYear").ToString.Trim And m_strCurrencyCode = Args.DataReader("CurrencyCode").ToString.Trim Then
                If m_iExpenseMonthGroup = 1 Then
                    m_iExpenseMonthGroup = 0
                    Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("CostHead").ToString + "</TD>"
                Else
                    Args.StringToBeInserted += "<TR class='clsTRSectionHeader' ><TD align='left'></TD><TD align='left'></TD><TD align='left'></TD><TD align='left'>" + Args.DataReader("CostHead").ToString + "</TD>"
                End If
            Else
                Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("CostHead").ToString + "</TD>"
            End If

            m_strCostHead = Args.DataReader("CostHead").ToString + ""
            m_iCostHeadGroup += 1
            m_strEmployeeName = ""
        End If

        'Employee Name Group
        If m_strEmployeeName <> Args.DataReader("EmployeeName").ToString.Trim + "" Then

            If m_strCostHead = Args.DataReader("CostHead").ToString.Trim And m_strEmployeeName <> Args.DataReader("EmployeeName").ToString Then
                If m_iCostHeadGroup = 1 Then
                    m_iCostHeadGroup = 0
                    Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("EmployeeName").ToString + "</TD><TD align='left'></TD><TD align='left'></TD><TD align='left'></TD></TR>"
                Else
                    Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left'></TD><TD align='left'></TD><TD align='left'></TD><TD align='left'></TD><TD align='left'>" + Args.DataReader("EmployeeName").ToString + "</TD><TD align='left'></TD><TD align='left'></TD><TD align='left'></TD></TR>"
                End If
            Else
                Args.StringToBeInserted += "<TD align='left'>" + Args.DataReader("EmployeeName").ToString + "</TD><TD align='left'></TD><TD align='left'></TD><TD align='left'></TD></TR>"
            End If
            m_strEmployeeName = Args.DataReader("EmployeeName").ToString + ""

        End If
    End Sub

    Private Sub m_objAdvGrid_SummaryFunctionsTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTR) Handles m_objAdvGrid.SummaryFunctionsTR_BeforePrint

        If m_blnTaskGridDataPresent = True Then
            'Currency Group Total
            If m_GroupTotal >= 0 Then
                'm_dblConvertedToPrjCurGroupTotal
                Args.StringToBeInserted += "<TR class='clsTRGroupHeader'><TD align='left' colspan=6><FONT color=blue>" & MyBase.GetResourceString("TOTAL_CURRENCY_AMOUNT") & "&nbsp;" & m_strCurrencyCode & "</FONT></TD><TD align=right width=15% colspan=1><FONT color=blue>" + FormatNumber(m_GroupTotal, 2).ToString + "</FONT></TD><TD align='left'></TD></TR>"
                ' Args.StringToBeInserted += "<TR class='clsTRGroupHeader'><TD align='left' colspan=6><FONT color=blue>" & MyBase.GetResourceString("TOTAL_CURRENCY_AMOUNT") & "&nbsp;" & m_sProjectBillingCurrencyCode & "</FONT></TD><TD align=right width=15% colspan=1><FONT color=blue>" + FormatNumber(m_dblConvertedToPrjCurGroupTotal, 2).ToString + "</FONT></TD><TD align='left'></TD></TR>"
            Else
                Cancel = Not m_blnTaskGridDataPresent
            End If
            'Total Project Expenses Amount (Converted in Project Currency)
            'strQuery = "usp_Sel_ProjectTotalExpenses  " & m_objGlobal.ProjectID.ToString & "," & m_dblTotalPrjExpenseAmount.ToString & "," & intRFIID.ToString
            'm_dblTotalPrjExpenseAmount = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)

            If m_dblTotalPrjExpenseAmount >= 0 Then
                'Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=6><FONT color=blue>" & MyBase.GetResourceString("TOTAL_PROJECT_CURRENCY_AMOUNT") & "</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_dblTotalPrjExpenseAmount, 2).ToString + "</FONT></TD><TD align='left'></TD></TR>"
                Args.StringToBeInserted += "<TR class='clsTRSectionHeader'><TD align='left' colspan=6><FONT color=blue>Total Expense Amount In Project Currency (" & m_sProjectBillingCurrencyCode & ")</FONT></TD></TD><TD align=right width=15%><FONT color=blue>" + FormatNumber(m_dblTotalPrjExpenseAmount, 2).ToString + "</FONT></TD><TD align='left'></TD></TR>"
                'm_sProjectBillingCurrencyCode
            Else
                Cancel = Not m_blnTaskGridDataPresent
            End If
        Else
            Cancel = True
        End If

    End Sub
    Private Sub PlotOtherHiddenControls()
        m_strToken = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Request.QueryString("RFIID"), String) + HttpContext.Current.Session("intUserID").ToString + CType(2044, String) + CType(0, String) + CType(HttpContext.Current.Session("intProjectID"), String))
        'Modified By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtHiddenToken", "txtHiddenToken", , , , m_strToken, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 6th-Oct-2015 Purpose::HTML Encoding
    End Sub
    Private Sub m_objAdvGrid_SummaryFunctionsTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_SummaryFunctionsTD) Handles m_objAdvGrid.SummaryFunctionsTD_BeforePrint
        If m_blnTaskGridDataPresent = True Then
            If Args.ColIndex = 7 Then
                Cancel = True
                Args.StringToBeInserted = "<TD align='left'></TD>" 'Replace Select column with this TD for Formating
            End If
        End If
    End Sub
#End Region


End Class
