Imports CommonEngines.General.cEventHandlers

Public Class cPRD_Component_CommonPage
    Inherits CommonPage
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "PRD_Component_CommonList.aspx"
        MyBase.strFormPage = "PRD_Component_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Addition By KapilGK on 9 June 2006 for Roamware Customization
        If WhizGlobal.ParentTagID = 0 Then
            If Args.ClientSideFunctionName.ToUpper = "SAVE_ONCLICK" Or Args.ClientSideFunctionName.ToUpper = "SAVEADD_ONCLICK" Then
                Args.ToBeInsertedInFunction = "var objNewChk = GetObjectReference('frmCommonPage','IsExternalComponent');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objOldChk = GetObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf
                Args.ToBeInsertedInFunction += "var objAMCCount = GetObjectReference('frmCommonPage','NonDatabase2');" + vbCrLf
                Args.ToBeInsertedInFunction += "if((objNewChk.checked==false) && (objOldChk.value== 'True') && (objAMCCount.value>0))" + vbCrLf
                Args.ToBeInsertedInFunction += "{if (confirm('Making Component as Non External Component will remove all AMC details.\r\nDo you want to continue?') == false)" + vbCrLf
                Args.ToBeInsertedInFunction += " return; " + vbCrLf
                Args.ToBeInsertedInFunction += " }" + vbCrLf
            End If
        End If
        'End Addition By KapilGK on 9 June 2006 for Roamware Customization
    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cPRD_Component_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cPRD_Component_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cPRD_Component_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cPRD_Component_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cCustomerlevelSLADefinition_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal m_objSubTagGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cPRD_Component_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    End Function


End Class

Public Class cPRD_Component_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

Public Class cPRD_Component_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub BeforePrintDetails_SubTag(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_SubTag, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        'Addition By KapilGK on 9 June 2006 for Roamware Customization
        Const intSubTagID As Integer = 3201
        If Args.SubTagID = intSubTagID Then
            Dim StrSQL As String
            ''Commented added By Abhijeet K on 8/8/2016 Purpose : Remove Inline Query
            ''StrSQL = "SELECT IsExternalComponent FROM tbl_PRD_Component WHERE ComponentID=" + PrimaryKey.ToString
            StrSQL = "usp_sel_tbl_PRD_Component_IsExternalComponent " + PrimaryKey.ToString

            If CType(CommonFunctions.Data.GetDataScalar(StrSQL, True), String) = "False" Then
                Cancel = True
            End If
        End If
        'End of Addition By KapilGK on 9 June 2006 for Roamware Customization
    End Sub
End Class

Public Class cPRD_Component_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

Public Class cPRD_Component_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
End Class

