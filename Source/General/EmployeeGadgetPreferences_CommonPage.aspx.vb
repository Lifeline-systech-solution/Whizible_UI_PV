Public Partial Class EmployeeGadgetPreferences_CommonPage
    Inherits CommonPage

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "EmployeeGadgetPreferences_CommonPage.aspx"
        MyBase.Page_Load(sender, e)

    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strQuery As String
        Dim dr As IDataReader
        Dim ModuleID As String
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        '' strQuery = "SELECT Module FROM v_tbl_CNF_GadgetNodes_EmployeePreferences WHERE PreferenceID = " + PrimaryKey
        strQuery = "usp_sel_v_tbl_CNF_GadgetNodes_EmployeePreferences " + PrimaryKey
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        dr = CommonFunction.Data.GetDataReader(strQuery, MyBase.UseSQL)

        If dr.Read() Then
            ModuleID = dr("Module").ToString()
        End If
        CommonEngines.HashTables.GetHashTableObject.RemoveUserTreeKeys("usp_Sel_WHIZ_Tree_HashTable_List 'E','" + ModuleID + "',NULL," + CType(HttpContext.Current.Session("intUserID"), String) + ",NULL,NULL")
        CommonFunction.Data.DisposeDataReader(dr)
        'Return MyBase.AfterSave(WhizGlobal, ControlsHashTable, PrimaryKey, strActionCode, IsEditMode, RedirectToCL)
    End Function
End Class