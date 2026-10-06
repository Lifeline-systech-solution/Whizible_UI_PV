Imports CommonEngines.General.cEventHandlers
Public Class TestSet_TestSession_CommonList
    Inherits CommonList
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New List_Print(MyBase.m_objGlobal)
        
    End Function
   




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
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "TestSet_TestSession_CommonList.aspx"
        MyBase.strFormPage = "TestSet_TestSession_CommonPage.aspx"
        'MyBase.strSubTagPage = "../TCM/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        ' Modified By MahendraV On 9:34 AM 6/29/2007 
        ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes For Whiziblesem 7
        ' Commented code moved from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        Dim strSelectedTestSet As String
        Dim strScript As String
        'Dim strSQL As String
        'Dim drstrSelectedTestSet As String
        'Dim intTestSessionID As Integer
        'Dim StrInput As String
        'Dim drreader As IDataReader
        'Dim strCurrTestSessionId As String
        'strCurrTestSessionId = HttpContext.Current.Request.QueryString("TestSessionID")

        'If strCurrTestSessionId = "" Then
        '    strCurrTestSessionId = CType(HttpContext.Current.Request.Form("txtTestSessionID"), String) + ""
        'End If

        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            ' intTestSessionID = CType(HttpContext.Current.Request.QueryString("TestSessionId"), Integer)

            strSelectedTestSet = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            If strSelectedTestSet <> "" Then

                'strSQL = "usp_TCM_Sel_TestSession_TestSet " + CStr(strCurrTestSessionId) + ",'" + strSelectedTestSet + "'"
                'drreader = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                CommonFunction.General.WriteHTML("<Script language=javascript >")
                CommonFunction.General.WriteHTML("refreshParent('frmCommonPage','Test_Session_CommonPage.aspx','../TCM/Test_Session_CommonPage.aspx?FocusOn=SUBTAG',true);")


                CommonFunction.General.WriteHTML("window.close();")
                CommonFunction.General.WriteHTML("</Script>")
            Else
                strScript = vbCrLf + "<Script language=javascript>"
                strScript += vbCrLf + "    alert('Select a Test Set');"
                'strScript += vbCrLf + "    return;"
                strScript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strScript)
            End If

        End If
        ' End_MV_6/29/2007
    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function


    Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SAVE_TEST" Then
            'Dim intTestSessionID As Integer
            ' intTestSessionID = CType(HttpContext.Current.Request.QueryString("TestSessionId"), Integer)
            Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../TCM/TestSet_TestSession_CommonList.aspx?FromWhere=PM&MasterTagId=3670&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf

        End If
    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        ' Modified By MahendraV On 9:34 AM 6/29/2007 For WhizibleSEM 7
        ' Database update need to be moved in WhizForm_Init due to DataSet Related Changes
        ' Commented code moved from PageListPreRender To WhizForm_Init
        ' Start_MV_6/29/2007
        Dim strSelectedTestSet As String
        Dim strSQL As String
        'Dim drstrSelectedTestSet As String
        'Dim intTestSessionID As Integer
        'Dim StrInput As String
        'Dim drreader As IDataReader
        Dim strCurrTestSessionId As String
        strCurrTestSessionId = HttpContext.Current.Request.QueryString("TestSessionID")

        If strCurrTestSessionId = "" Then
            strCurrTestSessionId = CType(HttpContext.Current.Request.Form("txtTestSessionID"), String) + ""
        End If

        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            ' intTestSessionID = CType(HttpContext.Current.Request.QueryString("TestSessionId"), Integer)
            strSelectedTestSet = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            If strSelectedTestSet <> "" Then
                strSQL = "usp_TCM_Sel_TestSession_TestSet " + CStr(strCurrTestSessionId) + ",'" + strSelectedTestSet + "'"
                'drreader = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            End If

        End If
        ' End_MV_6/29/2007
    End Sub
End Class
Class List_Print
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)

        'Common Page is accessed from CommonList
        Dim strWhere As String
        Dim strTestSessionID As String
        strTestSessionID = HttpContext.Current.Request.QueryString("TestSessionID") + ""

        If strTestSessionID = "" Then
            strTestSessionID = HttpContext.Current.Request.Form("txtTestSessionID") + ""
        End If
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtTestSessionID", "txtTestSessionID", , , , strTestSessionID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15


        If strTestSessionID <> "" Then
            strWhere = " AND ProjectTestSetId Not in (Select ProjectTestSetId from tbl_TCM_ProjectTestSessionTestSet "

            strWhere += " Where TestSessionId = " + strTestSessionID + ")"

        Else
            strWhere = " AND ProjectTestSetId Not in (Select ProjectTestSetId from tbl_TCM_ProjectTestSessionTestSet )"

        End If
        Args.GridSQL = Replace(Args.GridSQL, "ORDER", strWhere + " ORDER ")


    End Sub


    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

    End Sub
End Class