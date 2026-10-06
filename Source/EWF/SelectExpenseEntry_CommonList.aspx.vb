Imports CommonEngines.General.cEventHandlers
Public Class SelectExpenseEntry_CommonList
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
        MyBase.strListPage = "SelectExpenseEntry_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region
    ' Modified bY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
    ' Database update need to be moved in WhizForm_Init due to DataSet RElated Changes

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function
    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim ExpensesheetID As String
        'Dim strSQL As String
        Dim strSelectedExpenseEntry As String
        Dim strToBeInserted As String

        strSelectedExpenseEntry = CommonFunction.General.CheckIsNothing(CType(HttpContext.Current.Request.Form("chkDelete"), String), "")

        ExpensesheetID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpenseSheetID"), "")

        If ExpensesheetID <> "" And strSelectedExpenseEntry <> "" Then

            'strSQL = "usp_ins_tbl_PM_ExpenseSheet_Details " + ExpensesheetID + " , '" + strSelectedExpenseEntry + "' "

            'CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))


            'Modified By VarunA on 22-Sep-2008 IssueID-22505
            'Purpose : It wasn't getting refreshed in FireFox.
            'strToBeInserted = "opener.frmEWF_ExpenseSheet.txtCommand.value=""-1"";" + vbCrLf
            strToBeInserted += "opener.frmEWF_ExpenseSheet.txtCommand.value=""-1"";" + vbCrLf
            strToBeInserted = " opener.location.href= opener.location.href; " + vbCrLf
            'End By VarunA on 22-Sep-2008 IssueID-22505
            '  strToBeInserted += "opener.frmEWF_ExpenseSheet.submit();" + vbCrLf
            strToBeInserted += " window.close();" + vbCrLf


            strActionCode = ReturnCodes.ON_LOAD.ToString
        ElseIf strSelectedExpenseEntry = "" Then
            strToBeInserted = " alert('Please select atleast one entry!'); " + vbCrLf
        End If
        PageListPreRender = strToBeInserted
        ' End Addition By NitinVS on 24 May 2005 for Expense Workflow Implementation

    End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function
    ' End Modification bY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
    ' Database update need to be moved in WhizForm_Init due to DataSet RElated Changes

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "ADD_EXPENSEENTRY" Then
            Dim ExpenseSheetId As String = ""
            ExpenseSheetId = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpenseSheetID"), "")


            '***********************************
            Args.ToBeInsertedInFunction += "  var atleastoneSelected = 0;"
            Args.ToBeInsertedInFunction += " var objchkDelete = GetObjectReference('Form1','chkDelete',1);"
            'Validate at least one entry is selected 
            Args.ToBeInsertedInFunction += "  for(i=0;i<objchkDelete.length;i++) {" + vbCrLf

            Args.ToBeInsertedInFunction += "  if (objchkDelete[i].checked==true) {" + vbCrLf

            Args.ToBeInsertedInFunction += "  atleastoneSelected=1 ; } }" + vbCrLf

            Args.ToBeInsertedInFunction += "  if (atleastoneSelected == 0 ) {" + vbCrLf

            Args.ToBeInsertedInFunction += "  alert('Please select atleast one entry');" + vbCrLf
            Args.ToBeInsertedInFunction += "  return; "
            Args.ToBeInsertedInFunction += "  } else {" + vbCrLf
            Args.ToBeInsertedInFunction += "  objfrm.action = ""../EWF/SelectExpenseEntry_Commonlist.aspx?FromWhere=SM&MasterTagID=3594&ExpenseSheetID=" + ExpenseSheetId + """;" + vbCrLf
            Args.ToBeInsertedInFunction += " objfrm.submit(); " + vbCrLf
            Args.ToBeInsertedInFunction += " return; }"
            Args.ToBeInsertedInFunction += "  return true;"
            '*************

        End If

        If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
            Args.ToBeInsertedInFunction = "window.close(); return;" + vbCrLf
        End If

        If Args.ClientSideFunctionName.ToUpper = "CLEARALL_ONCLICK" Then
            Args.ToBeInsertedInFunction = " ClearAll_OnClick('frmCommonList','chkDelete'); return;"
        End If
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cSelectExpenseEntry_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    ' Modified bY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
    ' Database update need to be moved in WhizForm_Init due to DataSet RElated Changes

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)

        Dim ExpensesheetID As String
        Dim strSQL As String
        Dim strSelectedExpenseEntry As String
        Dim strToBeInserted As String

        strSelectedExpenseEntry = CommonFunction.General.CheckIsNothing(CType(HttpContext.Current.Request.Form("chkDelete"), String), "")

        ExpensesheetID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExpenseSheetID"), "")

        If ExpensesheetID <> "" And strSelectedExpenseEntry <> "" Then

            strSQL = "usp_ins_tbl_PM_ExpenseSheet_Details " + ExpensesheetID + " , '" + strSelectedExpenseEntry + "' "

            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        End If

        ' End Addition By NitinVS on 24 May 2005 for Expense Workflow Implementation

    End Sub
    ' Database update need to be moved in WhizForm_Init due to DataSet RElated Changes
    ' End Modification bY NitinVS on 28 Jun 2007 for WhizibleSEM 7 


End Class
Public Class cSelectExpenseEntry_CommonListPlotGrid
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
        If Args.DataField.ToUpper = "COSTHEAD" Then
            Args.EnableLink = False
        End If
    End Sub
End Class