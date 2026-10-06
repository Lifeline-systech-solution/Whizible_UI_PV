Imports CommonEngines.General.cEventHandlers
Public Class TestCaseTemplates_CommonList
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
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "TestCaseTemplates_CommonList.aspx"
        MyBase.strFormPage = "TestCaseTemplates_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

   
    Protected Overrides Sub After_Link_Print(ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        '  Response.Write("<script>window.open('../General/ViewAttachment.aspx?FromWhere=DXU%5CTemplates%5C&FileName=" + strCreatedFileName + "', '_popup')</script>")
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTestCaseTemplates_CommonList(MyBase.m_objGlobal)
    End Function


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)
    '    Dim strSQL As String
    '    Dim strFileName As String
    '    Dim drfile As IDataReader
    '    If Args.ClientSideFunctionName.ToUpper = "HYPERLINK1" Then
    '        strSQL = "Select SystemFileName From  v_tbl_DXU_template"
    '        drfile = CommonFunctions.Data.GetDataReader(strSQL, True)
    '        If drfile.Read Then
    '            strFileName = CStr(drfile("SystemFileName"))
    '            Args.HREF_URL = " ../General/ViewAttachment.aspx?FromWhere=DXU&FileName=" + strFileName + """"
    '        End If
    '    End If
    'End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    'Addition By NitinVS on 6 Sug 2007 for WhizibleSEM 7 
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cTestCaseTemplates_CommonListSQL(MyBase.m_objGlobal)
    End Function
    'End Addition By NitinVS on 6 Sug 2007 for WhizibleSEM 7 
End Class
Public Class cTestCaseTemplates_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid
    Public Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub


    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        '    'If Args.DataField.ToUpper = "HYPERLINK1" Then

        '    '    Args.StringToBeInserted = "<TD align=left Title=""Download""><A href=javascript:ViewUploadedFile(""" & CStr(Args.DataReader("SystemFileName")) & """) ></A></TD>"
        '    'End If
    End Sub
End Class

Public Class cTestCaseTemplates_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    'Addition By NitinVS on 6 Sug 2007 for WhizibleSEM 7 
    ' NOTE: Need to update the filter condition when a new template is to be added for project or Config level test set
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        If Not IsNothing(HttpContext.Current.Request.QueryString("FromWhere")) Then

            If HttpContext.Current.Request.QueryString("FromWhere") = "PM" Then
                GetPageSpecificFilters += " AND TemplateID = 7 "
            Else
                GetPageSpecificFilters += " AND TemplateID = 4 "
            End If
        End If

    End Function
    'End Addition By NitinVS on 6 Sug 2007 for WhizibleSEM 7 
End Class

