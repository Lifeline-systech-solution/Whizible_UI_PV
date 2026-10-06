Imports CommonEngines.General.cEventHandlers
Public Class PM_Checklist_CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid()

        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "PM_Checklist_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSQL As String
        Dim arrComma As Char() = {","c}
        Dim strChecklistDeletionList As String() = DeletedIDList.Split(arrComma)
        Dim strChecklistResponseID As String
        For Each strChecklistResponseID In strChecklistDeletionList
            strSQL = "usp_del_SDLC_CheckListItems " + strChecklistResponseID
            CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Next
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

        If Args.ClientSideFunctionName.ToUpper = "DELETE_ONCLICK" Then
            If Not HttpContext.Current.Request.QueryString("ProcessID") Is Nothing Then
                Session("ProcessSelected") = HttpContext.Current.Request.QueryString("ProcessID").ToString
            End If
        End If

        If Args.ClientSideFunctionName.ToUpper = "NEW_ONCLICK" Then
            Args.ToBeInsertedInFunction = "var objForm;"
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');"
            Args.ToBeInsertedInFunction += "objForm.action='../PV/CheckListResponses.aspx?Mode=ADDNEW&SDLCID=" + HttpContext.Current.Request.QueryString("SDLCID").ToString + "&ProcessID=" + CType(IIf(HttpContext.Current.Request.QueryString("ProcessID") Is Nothing, Session("ProcessSelected"), HttpContext.Current.Request.QueryString("ProcessID")), String) + "'; "
            Args.ToBeInsertedInFunction += "objForm.submit();"
            Args.ToBeInsertedInFunction += "return;"
        End If
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cPM_Checklist_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

End Class

Public Class cPM_Checklist_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "TITLE" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=Center Title='" + CType(Args.DataReader("Title"), String) + "'>"
            Args.StringToBeInserted += "<A href='../PV/CheckListResponses.aspx?Mode=Edit&SDLCID=" + CType(Args.DataReader("sdlcid"), String) + "&ProcessID=" + CType(Args.DataReader("ProcessID"), String) + "&ChecklistID=" + CType(Args.DataReader("ChecklistID"), String) + "&Revision=" + CType(Args.DataReader("Revision"), String) + "&UniqueID=" + CType(Args.DataReader("UniqueID"), String) + "'>"
            Args.StringToBeInserted += CType(Args.DataReader("Title"), String) + "</A>"
            Args.StringToBeInserted += "</TD>"
        End If
    End Sub
End Class
