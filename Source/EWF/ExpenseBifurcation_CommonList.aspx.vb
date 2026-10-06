Imports CommonEngines.General.cEventHandlers
Public Class ExpenseBifurcation_CommonList
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
        'Dim m_strPKToken_Expense_Bbifurcation As String
        'Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)

        'm_strPKToken_Expense_Bbifurcation = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Session("intProjectID"), String) + intUserID + "0" + CType(3093, String))

        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid()
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "ExpenseBifurcation_CommonList.aspx"
        MyBase.strFormPage = "ExpenseBifurcation_CommonPage.aspx"
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

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim m_strPKToken_Expense_ADDNEW As String
        Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)

        m_strPKToken_Expense_ADDNEW = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Session("intProjectID"), String) + intUserID + "0" + CType(3093, String))

        If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then

            Args.ToBeInsertedInFunction = "window.open (""../EWF/EWF_Bifurcation.aspx?MODE=0&PkToken=" + m_strPKToken_Expense_ADDNEW + "&FromWhere=DT&MasterTagId=3093"",""_self""); return; "
        End If

        If Args.ClientSideFunctionName.ToUpper = "EDIT_ONCLICK" Then
            Args.ToBeInsertedInFunction = "var objchkDelete = GetObjectReference('frmCommonList','chkDelete',1);" + vbCrLf
            Args.ToBeInsertedInFunction += "var atleastoneSelected = 0; " + vbCrLf
            Args.ToBeInsertedInFunction += " for(i=0;i< objchkDelete.length;i++ ){" + vbCrLf
            Args.ToBeInsertedInFunction += "if (objchkDelete[i].disabled==false && objchkDelete[i].checked==true)	" + vbCrLf
            Args.ToBeInsertedInFunction += " { atleastoneSelected=1 ; } }" + vbCrLf
            Args.ToBeInsertedInFunction += " if (atleastoneSelected == 0){ alert('Please select at least one expense Entry'); return; } " + vbCrLf
            'modified by harshada d for expense workflow for whiziblesem 6 on 4 April 2006
            'Args.ToBeInsertedInFunction += " objfrm.action=""../General/CommonList.aspx?FromWhere=SM&MasterTagID=3108&BIFURCATION=1"";"
            Args.ToBeInsertedInFunction += " objfrm.action=""../EWF/ExpenseBifurcation_CommonList.aspx?MasterTagID=3598&FromWhere=SM&BIFURCATION=1"";"
            'end of addition by ahrshada d for whizblesem 6 on 4 April 2006
            Args.ToBeInsertedInFunction += " objfrm.submit(); return;" + vbCrLf

        End If
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cExpenseBifurcation_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    'added by harshada d for whiziblesem 6 issue id 2318 for expenses workflow on 18 th April 2006.
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cExpenseBifurcation_CommonListSQL(MyBase.m_objGlobal)
    End Function
    'end of addition by harshada d for whiziblesem 6 issue id 2318 for expenses workflow on 18 th April 2006.
End Class
Public Class cExpenseBifurcation_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Args.ColumnName = "Select"
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strTitle As String
        Dim strExpenseSheetID As String
        Dim m_lngCurrencyCount As Long
        Dim m_strPKToken_Expense_ADDNEW As String
        Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)

        m_strPKToken_Expense_ADDNEW = CommonFunctions.Security.Token.GetToken(CType(HttpContext.Current.Session("intProjectID"), String) + intUserID + "0" + CType(3093, String))

        'Dim intUserID As String = CType(HttpContext.Current.Session("intUserID"), String)

        If Args.DataField.ToUpper = "TITLE" Then
            Cancel = True
            strTitle = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Title"), ""), ""), String)
            strExpenseSheetID = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ExpensesEntryID"), "0"), "0"), String)
            'Modified By ShraddhaM on 20,Sep 2006 For SP7 Issue ID : 6197

            Dim m_lngTagId As Long = 3598
            Dim m_strPKToken_Expense_Bbifurcation As String

            m_strPKToken_Expense_Bbifurcation = CommonFunctions.Security.Token.GetToken(strExpenseSheetID + intUserID + "0" + CType(m_lngTagId, String))

            ' Args.IgnoreActualValue = True
            'Args.EnableLink = False
            'Args.ReplacementValue = "<td><A href=""JavaScript:Title('" + strExpenseSheetID + "','" + m_strPKToken_Expense_Bbifurcation + "')"">" + strTitle + "</A></td>"
            'Args.StringToBeInserted = "<td><A href='javascript: var objChild= window.open(""../PM/EWF_Bifurcation.aspx?MasterTagID=3598&PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ExpensesEntryID=" + strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>"" + strTitle + ""</A></td>"
            'Args.StringToBeInserted = "<td><A href='javascript: var objChild= window.open(""../EXF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&ExpensesEntryID="+ strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");"'>"" + strTitle + ""</A></td>"
            'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../EXF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&ExpensesEntryID=" + strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation + ,_self,""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>" + strTitle + "</a> </TD>"
            'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var objChild= window.open(""../EXF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&ExpensesEntryID=" + strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation + ",_self,"");'>" + strTitle + "</a> </TD>"

            'Args.StringToBeInserted = "<TD Align='Center'><A href='javascript: var window.location.href=../EXF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&ExpensesEntryID=" + strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation + ";'>" + strTitle + "</a> </TD>"
            Args.StringToBeInserted = "<TD Align='Center'><A href=../EWF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&ExpensesEntryID=" + strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation + ">" + strTitle + "</a> </TD>"

            ' window.open ("EWF_Bifurcation.aspx?MODE=2&FILTERTYPE=C&ExpensesEntryID=" + ExpensesEntryID + "&Title=" + Title,"_self");

            'Dim str As String
            'str = "../EXF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&ExpensesEntryID=" + strExpenseSheetID + "&PkToken=" + m_strPKToken_Expense_Bbifurcation + ",self,"""









            '""","""",
            'window.open("../EWF/EWF_ExpenseEntry.aspx?Mode=EDIT&MasterTagID=3556&ExpensesEntryID="+ ExpensesEntryID + "&PkToken=" + strPKToken + "&txtDate=" + objtxtDate.value ,"Expense" ,"resizable=yes,scrollbars=no,left=" + (window.screen.width - 720)/2 + ",top=" + (window.screen.height - 420)/2 + ",width=700,height=375");
            Args.ApplyHTMLEncode = False
            'javascript: var objChild= window.open(""../PM/PM_TaskAssignment.aspx?MasterTagID=1038&FromWhere=PM&ProjectID=" + CType(HttpContext.Current.Session("intProjectID"), String) + "&ReviewActionID=" + strActionID + "&TaskID=" + intParentTaskID.ToString + "&PkToken=" + m_strToken + ""","""",""left="" + (window.screen.width-700)/2 + "",top="" + (window.screen.height-500)/2 + "",width=700,height=500"");'>
        End If

        If Args.DataField.ToUpper = "EXPENSESENTRYID" Then
            Args.EnableLink = False
        End If


    End Sub


    'Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    'Dim strToBeInserted As String
    '    'strToBeInserted = " <SCRIPT> " + vbCrLf
    '    'strToBeInserted += " function Title(ExpenseSheetID , strPkToken) " + vbCrLf
    '    'strToBeInserted += " {" + vbCrLf
    '    'strToBeInserted += " objfrm.action=""../EWF/EWF_Bifurcation.aspx?Mode=2&MasterTagID=3598&PkToken="" + strPkToken + ""&ExpensesEntryID="" + ExpenseSheetID  ;" + vbCrLf

    '    ''strToBeInserted += " objfrm.action=""../EWF/EWF_ExpenseSheet.aspx?Mode=EDIT&MasterTagID=3595PkToken="" + strPkToken ""&ExpenseSheetID="" + ExpenseSheetID + ""&Actor="" + Actor ;" + vbCrLf
    '    'strToBeInserted += " objfrm.submit();" + vbCrLf
    '    'strToBeInserted += " }" + vbCrLf
    '    'strToBeInserted += " </SCRIPT> " + vbCrLf
    '    'Args.ToBeInserted = strToBeInserted
    'End Sub
End Class
Public Class cExpenseBifurcation_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strSQL As String
        Dim drProjectType As IDataReader
        Dim intProjectTypeID As Integer
        Dim strFilter As String

        ' Added By NitinVS on 24 May 2005 for Expense Workflow Implementation
        GetPageSpecificFilters &= " AND FPCenterID IN (SELECT FPCenterID FROM tbl_CNF_financeProcessingCenter_Details WHERE EmployeeID = " + CType(HttpContext.Current.Session("intUserID"), String) + ")"
        ' End Addition By NitinVS on 24 May 2005 for Expense Workflow Implementation 

    End Function
End Class