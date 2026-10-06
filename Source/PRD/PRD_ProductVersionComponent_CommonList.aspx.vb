Imports CommonEngines.General.cEventHandlers
Public Class ProductVersion_Component
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
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "PRD_ProductVersionComponent_CommonList.aspx"
        'MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region


    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function
    'Modified BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 
    'Moved code to Whizform_Init
    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    Dim StrselectedComponenets As String = ""
    '    Dim strProductVersionID As String = "0"
    '    Dim IsSave As String = ""
    '    StrselectedComponenets = HttpContext.Current.Request.Form("ChkDelete")
    '    strProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProductVersionID"), "0")
    '    IsSave = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ISSAVE"), "0")
    '    If IsSave = "1" And strProductVersionID <> "0" Then
    '        CommonFunction.Data.InsertOrUpdateData("USP_INS_Tbl_PRD_ProductVersion_Component " + strProductVersionID + " , '" + StrselectedComponenets + "'", MyBase.UseSQL)
    '    End If

    'End Function
    'End Modified BY NitinVS on 28 Jun 2007 for WhizibleSEM 7 

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cProductVersion_Component_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cProductVersion_Component_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    'Added By NitinVS on 28 Jun 2007 for WhizibleSEM 7 
    Protected Overrides Sub WhizForm_Init(ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef m_intConnectionID As Integer)
        Dim StrselectedComponenets As String = ""
        Dim strProductVersionID As String = "0"
        Dim IsSave As String = ""
        StrselectedComponenets = HttpContext.Current.Request.Form("ChkDelete")
        strProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProductVersionID"), "0")
        IsSave = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ISSAVE"), "0")
        If IsSave = "1" And strProductVersionID <> "0" Then
            CommonFunction.Data.InsertOrUpdateData("USP_INS_Tbl_PRD_ProductVersion_Component " + strProductVersionID + " , '" + StrselectedComponenets + "'", MyBase.UseSQL)
        End If


    End Sub
    'End Added By NitinVS on 28 Jun 2007 for WhizibleSEM 7 
End Class

Public Class cProductVersion_Component_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub





    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "SELECT" Then

            Dim strProductVersionID As String = "0"
            strProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProductVersionID"), "0")

            If CStr(CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProductVersionID"), "")) = strProductVersionID Then
                Args.IsSelected = True
            End If

        End If

    End Sub
End Class


Class cProductVersion_Component_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        '***************************************************************************
        'Added By SandeepA on 6 Jan,2006
        'Purpose: Apply Project Access Filter.
        '***************************************************************************
        'Apply Role Access Filter for Project List
        Dim strProductVersionID As String = "0"
        strProductVersionID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProductVersionID"), "0")

        GetPageSpecificFilters = ""

        If strProductVersionID <> "" Then
            GetPageSpecificFilters += " AND ( ProductVersionID = " + strProductVersionID + " OR ( ProductVersionID is Null AND "
            GetPageSpecificFilters += "componentID not in (Select ComponentId From Tbl_PRD_ProductVersion_Component "
            GetPageSpecificFilters += " WHERE ProductVersionID = " + strProductVersionID + " )  ) ) "
        End If
        '***************************************************************************
        'End of addition by SandeepA on 6 Jan,2005
        '***************************************************************************

    End Function
End Class