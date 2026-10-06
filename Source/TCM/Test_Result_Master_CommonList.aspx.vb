Imports CommonEngines.General.cEventHandlers
Public Class Test_Result_Master_CommonList
    Inherits CommonList
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New Display_Color_Grid(MyBase.m_objGlobal)
    End Function

    Class Display_Color_Grid
        Inherits CommonEngine.CommonList.cPlotGrid
        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub


        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

            If Args.DataField.ToString() = "ColorCode" Then
                Cancel = True
                Dim Strbgcolor As String
                ' Modified by nitinvs on 5 july 2007 for whizibleSEM 7 To Handle null value 
                Strbgcolor = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader.Item("ColorCode"), ""), String)
                ' End Modified by nitinvs on 5 july 2007 for whizibleSEM 7 To Handle null value 

                Args.StringToBeInserted = "<TD><table width= 20% cellpadding=1  cellspacing=1><tr><td bgcolor= " & Strbgcolor & " width=100 height=12 ></td></tr></table></TD>"

            End If

        End Sub
    End Class

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
        MyBase.strListPage = "Test_Result_Master_CommonList.aspx"
        MyBase.strFormPage = "Test_Result_Master_CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

   
End Class
