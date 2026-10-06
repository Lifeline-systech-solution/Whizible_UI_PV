Public Class HR_ResourceDemand_CommonList
    Inherits CommonList

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_ResourceDemand_CommonList.aspx"
        MyBase.strFormPage = "HR_ResourceDemand_CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_ResourceDemand_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

End Class
Class cHR_ResourceDemand_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strQuery As String
        Dim dr As IDataReader
        Dim strLevel As String
        Dim IDs As String
        Dim strRaisedBy As String
        strRaisedBy = CType(HttpContext.Current.Session("intUserID"), String)

        strQuery = "Exec usp_Sel_Accessible_BG_OU " + strRaisedBy
        dr = CommonFunctions.Data.GetDataReader(strQuery, True)

        If dr.Read() Then
            strLevel = CType(dr("Level"), String)
            IDs = CType(dr("ID"), String)
        End If
        While dr.Read()
            strLevel = CType(dr("Level"), String)
            IDs = IDs + "," + CType(dr("ID"), String)
        End While
        'When resource is Middle level and has access for BG thru middle level access
        If strLevel = "BG" Then
            GetPageSpecificFilters += " AND (BusinessGroupID IN(" + IDs + ") OR RaisedBy = " + strRaisedBy + ")"
            'When resource is Middle level and has access for OU thru middle level access
        ElseIf strLevel = "OU" Then
            GetPageSpecificFilters += " AND (LocationID IN(" + IDs + ") OR RaisedBy = " + strRaisedBy + ")"
            'When resource is Middle level  and no access for BG or OU thru middle level access
        ElseIf strLevel = "MLR" Then
            GetPageSpecificFilters += " AND RaisedBy = " + strRaisedBy
            'When resource is Low level
        ElseIf strLevel = "LLR" Then
            GetPageSpecificFilters += " AND RaisedBy = " + strRaisedBy
        End If
        CommonFunction.Data.DisposeDataReader(dr)
    End Function

End Class
