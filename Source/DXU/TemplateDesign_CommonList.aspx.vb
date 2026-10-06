Imports CommonEngines.General.cEventHandlers
Public Class TemplateDesign_CommonList
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
        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "TemplateDesign_CommonList.aspx"
        MyBase.strFormPage = "TemplateDesign_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub
#End Region


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTemplateDesign_CommonList_PlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class cTemplateDesign_CommonList_PlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal ObjGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(ObjGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ColumnName.ToUpper = "DELETE" Then
            Dim drTemplate As IDataReader
            Dim strSQL As String

            ''strSQL = "select templateID from tbl_DXU_UploadRequestsQueue where templateID = '" + Args.DataReader("TemplateID").ToString + "'"
            strSQL = "usp_sel_tbl_DXU_UploadRequestsQueue_TemplateWiseTemplateID '" + Args.DataReader("TemplateID").ToString + "'"

            drTemplate = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drTemplate.Read Then
                Args.IsCheckBoxDisabled = True
            End If
            CommonFunction.Data.DisposeDataReader(drTemplate)
        End If
    End Sub
End Class