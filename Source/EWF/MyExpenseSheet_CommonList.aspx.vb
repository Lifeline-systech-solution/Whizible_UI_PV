Imports CommonEngines.General.cEventHandlers
Public Class MyExpenseSheet_CommonList
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
        MyBase.strListPage = "MyExpenseSheet_CommonList.aspx"
        'MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        'Dim m_lngTagId As Long = 3593
        'Dim m_strPKToken_Expense_Sheet_ForADDNEW As String
        'Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)
        'm_strPKToken_Expense_Sheet_ForADDNEW = CommonFunctions.Security.Token.GetToken(CType(Session("intProjetcID"), String) + intUserID + "0" + CType(m_lngTagId, String))

        MyBase.Page_Load(sender, e)


    End Sub
#End Region

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim m_lngTagId As Long = 3593
        Dim m_strPKToken_Expense_Sheet_ForADDNEW As String
        Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)
        m_strPKToken_Expense_Sheet_ForADDNEW = CommonFunctions.Security.Token.GetToken(CType(Session("intProjectID"), String) + intUserID + "0" + CType(m_lngTagId, String))

        If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then

            Args.ToBeInsertedInFunction += " objfrm.action=""../EWF/EWF_ExpenseSheet.aspx?Mode=ADD&MasterTagID=3593&PkToken=" + m_strPKToken_Expense_Sheet_ForADDNEW + "&ExpenseSheetID=&Actor=0"";" + vbCrLf
            Args.ToBeInsertedInFunction += " objfrm.submit(); return;" + vbCrLf

        End If
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cMyExpenseSheet_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class cMyExpenseSheet_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "CURRENCYSYMBOL" Then Args.ColumnName = ""
        ' commented by harshada d for  whiziblesem 6 issue id 2318 expenses workflow 
        'Or Args.ColumnName.ToUpper = "AMOUNT DETAILS" 

    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strTitle As String
        Dim strExpenseSheetID As String
        Dim m_lngCurrencyCount As Long
        'Modified By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197
        Dim m_strPKToken_Expense_Sheet As String
        'If Args.ColumnName.ToUpper = "COST HEAD" Then
        '    Cancel = True
        '    m_strPKToken_Expense_EntryList = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpenseSheetID"), String) + CType(Session("intUserID"), String) + "0" + CType(m_lngTagId, String))

        '    Args.StringToBeInserted = "<TD vAlign=top Title='Task Name' style='width=225' nowrap;>" _
        '                                     & "<A href=""JavaScript:Edit_OnClick('" & CType(Args.DataReader("ExpensesEntryID"), String) & "','" & CommonFunctions.General.CheckIsNothing(m_strPKToken_Expense_EntryList) & "')"">"
        '    Args.StringToBeInserted = Args.StringToBeInserted & Server.HtmlEncode(Args.DataReader("CostHead").ToString) & "</A></TD>"

        '    Args.ApplyHTMLEncode = False
        'End If
        'Ended By ShraddhaM on 19, Sep 2006 for SP7 Issue ID : 6197

        If Args.DataField.ToUpper = "TITLE" Then


            strTitle = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Title"), ""), ""), String)
            strExpenseSheetID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpenseSheetID"), "0"), "0"), String)
            Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)
            Dim m_lngTagId As Long = 3593

            m_strPKToken_Expense_Sheet = CommonFunctions.Security.Token.GetToken(CType(Args.DataReader("ExpenseSheetID"), String) + intUserID + "0" + CType(m_lngTagId, String))

            Args.IgnoreActualValue = True
            Args.EnableLink = False
            ''Commented and Added By Nikhil A on 22-dec-2015 for handling the HTML encoding
            ''Args.ReplacementValue = "<A href=""JavaScript:Edit_OnClick('" + strExpenseSheetID + "' ,'0','" + m_strPKToken_Expense_Sheet + "')"">" + strTitle + "</A>"
            Args.ReplacementValue = "<A href=""JavaScript:Edit_OnClick('" + strExpenseSheetID + "' ,'0','" + m_strPKToken_Expense_Sheet + "')"">" + HttpContext.Current.Server.HtmlEncode(strTitle) + "</A>"
            ''End of Commented and Added By Nikhil A on 22-dec-2015 for handling the HTML encoding

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

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strToBeInserted As String
        strToBeInserted = " <SCRIPT> " + vbCrLf
        strToBeInserted += " function Edit_OnClick(ExpenseSheetID , Actor ,strPkToken) " + vbCrLf
        strToBeInserted += " {" + vbCrLf
        strToBeInserted += " objfrm.action=""../EWF/EWF_ExpenseSheet.aspx?Mode=EDIT&MasterTagID=3593&PkToken="" + strPkToken + ""&ExpenseSheetID="" + ExpenseSheetID + ""&Actor="" + Actor ;" + vbCrLf

        strToBeInserted += " objfrm.submit();" + vbCrLf
        strToBeInserted += " }" + vbCrLf
        strToBeInserted += " </SCRIPT> " + vbCrLf
        Args.ToBeInserted = strToBeInserted
    End Sub
End Class
