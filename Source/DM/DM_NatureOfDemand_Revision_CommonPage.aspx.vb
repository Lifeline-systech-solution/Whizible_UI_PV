Imports CommonEngines.General.cEventHandlers
Public Class cDM_NatureOfDemand_Revision_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cDM_NatureOfDemand_Revision_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cDM_NatureOfDemand_Revision_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cDM_NatureOfDemand_Revision_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class


Public Class DM_NatureOfDemand_Revision_CommonPage
    Inherits CommonPage
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
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "DM_NatureOfDemand_Revision_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        Dim strSQL As String
        'Dim strRevisionNo As String
        'strSQL = "usp_Ins_upd_Tbl_IM_NatureOfDemand_Workflow " + CommonFunction.Data.CheckIsDBNull(ControlsHashTable("NatureOfDemandId"), "") + ", '" + HttpContext.Current.Session("strUSerName") + "'"
        'strRevisionNo = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(ControlsHashTable("RevisionNo"), "1"), "1")

        'Modified By NitinVS on 21 MAr 06 for NatureofDemand Revision 
        '' Update Publised status and Revision Details 
        'strSQL = "Update Tbl_IM_NatureOfDemand SET Published = 1 , RevisionID = " + PrimaryKey + ", RevisionNo = " + CommonFunction.Data.CheckIsDBNull(ControlsHashTable("RevisionNo"), "") + "WHERE NatureOfDemandID = " + CommonFunction.Data.CheckIsDBNull(ControlsHashTable("NatureOfDemandId"), "")
        'CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

        AfterSave = ""

        If PrimaryKey <> "" Then
            strSQL = "usp_ins_Tbl_IM_NatureOfDemand_Published " + PrimaryKey
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            'If strRevisionNo <> "1" Then
            '    AfterSave += "window.open('../DM/DM_ProcessValidation.aspx?NatureOfDemandID=" + CType(CommonFunction.Data.CheckIsDBNull(ControlsHashTable("NatureOfDemandId"), ""), String) + "&MODE=VALIDATE_REVISION&ACTION=SAVE' , '', 'resizable=yes,scrollbars=no,left=' + (window.screen.width - 550)/2 + ',top=' + (window.screen.height - 400)/2 + ',width=550,height=400');"
            'End If
            AfterSave += "opener.location.href='../General/CommonList.aspx?FromWhere=SM&MasterTagId=3928';" + vbCrLf
            AfterSave += vbCrLf + "window.close();"
        Else
            AfterSave = ""
        End If

        ' End Modification By NitinVS on 21 MAr 06 for NatureofDemand Revision 

        RedirectToCL = False
        strActionCode = ReturnCodes.ON_LOAD.ToString
    End Function


    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String

        RedirectToCL = False

        'BeforeSave = " window.opener.href=winow.opener.href; "
        'BeforeSave += " window.close();"
    End Function


    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cDM_NatureOfDemand_Revision_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cDM_NatureOfDemand_Revision_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cDM_NatureOfDemand_Revision_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cDM_NatureOfDemand_Revision_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

End Class
