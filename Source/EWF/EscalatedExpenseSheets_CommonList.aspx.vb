Imports CommonEngines.General.cEventHandlers
Public Class EscalatedExpenseSheets_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid()

        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "EscalatedExpenseSheets_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cEscalatedExpenseSheets_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
End Class

Public Class cEscalatedExpenseSheets_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    ' Code added by SwapnilR on 17th Oct 2006
    ' Purpose : 1. In approval page having one combobox called ExpenseSheet IDs which 
    '           includes only those record Which is available on CL page
    '           2. Also add tokenids to the session for the security purpose    
    '           (PrashantSJ's code integration along with security patch)
    Public strExpenseSheetIDList As String = ""
    Public strTokenIDList As String = ""
    ' End of code addition by SwapnilR on 17th Oct 2006
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
        End If

        If Args.DataField.ToUpper = "CURRENCYSYMBOL" Or Args.ColumnName.ToUpper = "AMOUNT DETAILS" Then
            Cancel = True
            Args.ApplySorting = False
            Args.StringToBeInserted = ""
        End If

        If Args.DataField.ToUpper = "TOTALAMOUNT" Then
            Cancel = True
            Args.StringToBeInserted = "<TD nowrap colspan=3 align=center Title=""""ID : 51 Column Name : Total Amount"">" + Args.ColumnName + "</TD>"
        End If

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strToBeInserted As String
        strToBeInserted = " <SCRIPT> " + vbCrLf
        strToBeInserted += " function Edit_OnClick(ExpenseSheetID , Actor , strPkToken) " + vbCrLf
        strToBeInserted += " {" + vbCrLf
        'strToBeInserted += " objfrm.action=""../EWF/EWF_ExpenseSheet.aspx?Mode=EDIT&ExpenseSheetID="" + ExpenseSheetID + ""&Actor="" + Actor ;" + vbCrLf
        strToBeInserted += " objfrm.action=""../EWF/EWF_ExpenseSheet.aspx?Mode=EDIT&MasterTagID=3596&PkToken="" + strPkToken + ""&ExpenseSheetID="" + ExpenseSheetID + ""&Actor="" + Actor ;" + vbCrLf
        strToBeInserted += " objfrm.submit();" + vbCrLf
        strToBeInserted += " }" + vbCrLf
        strToBeInserted += " </SCRIPT> " + vbCrLf
        Args.ToBeInserted = strToBeInserted

        ' Code added by SwapnilR on 17th Oct 2006
        ' Purpose : 1. In approval page having one combobox called ExpenseSheet IDs which includes only 
        '           those record Which is available on CL page
        '           2. Also added TokenIDs to the session variable for security purpose        
        '           (PrashantSJ's code integration along with security patch)
        HttpContext.Current.Session("ExpenseSheetIDList") = ""
        HttpContext.Current.Session("TokenForExpences") = ""
        HttpContext.Current.Session("ExpenseSheetIDList") = strExpenseSheetIDList
        HttpContext.Current.Session("TokenForExpences") = strTokenIDList
        ' End of code addition by SwapnilR on 17th Oct 2006

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strTitle As String
        Dim strExpenseSheetID As String
        Dim m_lngCurrencyCount As Long

        If Args.DataField.ToUpper = "TITLE" Then

            strTitle = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Title"), ""), ""), String)
            strExpenseSheetID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), "0"), String)

            'Modified By ShraddhaM on 20,Sep 2006 For SP7 Issue ID : 6197

            Dim m_lngTagId As Long = 3596
            Dim m_strPKToken_Expense_Sheet_Escalated As String
            Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)

            m_strPKToken_Expense_Sheet_Escalated = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpenseSheetID"), String) + intUserID + "0" + CType(m_lngTagId, String))

            Args.IgnoreActualValue = True
            Args.EnableLink = False
            Args.ReplacementValue = "<A href=""JavaScript:Edit_OnClick('" + strExpenseSheetID + "' ,'2','" + m_strPKToken_Expense_Sheet_Escalated + "')"">" + strTitle + "</A>"

            'Ended By ShraddhaM on 20,Sep 2006 For SP7 Issue ID : 6197
            'Args.IgnoreActualValue = True
            'Args.EnableLink = False
            'Args.ReplacementValue = "<A href=""JavaScript:Edit_OnClick('" + strExpenseSheetID + "' ,'2')"">" + strTitle + "</A>"

        End If

        If Args.ColumnName.ToUpper = "DELETE" Then
            Cancel = True
        End If

        If Args.DataField.ToUpper = "EXPENSESHEETID" Then
            Args.EnableLink = False
        End If

        ' if the Currency Count is more than 1 then down show the Currency And Amount 
        m_lngCurrencyCount = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("CurrencyCount"), "0"), "0"), Long)

        If m_lngCurrencyCount > 1 Then
            ' modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
            If Args.DataField.ToUpper = "CURRENCYSYMBOL" Then
                Args.IgnoreActualValue = True
                Args.ReplacementValue = "-"
                '<TD   align=Left Title="ID : 51 Column Name : Amount Details"><A href="Javascript:Hyperlink1(&quot;61&quot;,&quot;51&quot;)" Title="Click to View Amount Distribution Per Currency"></A></TD>
            ElseIf Args.ColumnName.ToUpper = "TOTAL AMOUNT" Then
                Args.IgnoreActualValue = True
                Args.ReplacementValue = "-"
                '  ElseIf Args.ColumnName.ToUpper = "AMOUNT DETAILS" Then
                'Args.IgnoreActualValue = True
                'Args.EnableLink = False
                'Args.ReplacementValue = "</TD><TD><A href=""Javascript:Hyperlink1(&quot;" + Args.DataReader("EmployeeId").ToString + "&quot;,&quot;" + Args.DataReader("ExpenseSheetID").ToString + "&quot;)"" Title=""Click to View Amount Distribution Per Currency""> Amount Details </A></TD><TD>&nbsp;"

            End If
            ' end of modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
        Else
            ' modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
            If Args.ColumnName.ToUpper = "AMOUNT DETAILS" Then
                Args.IgnoreActualValue = True
                Args.EnableLink = False
                Args.ReplacementValue = "-"
                ' end of modified by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 

            End If

        End If
    End Sub
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        ' Code added by SwapnilR on 17th Oct 2006
        ' Purpose : 1. In approval page having one combobox called ExpenseSheet IDs which includes only 
        '           those record Which is available on CL page
        '           2. Also Added TokenIDs to the session variable for security purpose
        '           (PrashantSJ's code integration along with security patch)
        strExpenseSheetIDList += Args.DataReader("ExpensesheetID").ToString + ","
        strTokenIDList += CType(Args.DataReader("ExpenseSheetID"), String).Trim + "+" + CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpenseSheetID"), String) + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "3596").Trim + "#"
        ' End of code addition by SwapnilR on 17th Oct 2006
    End Sub
End Class