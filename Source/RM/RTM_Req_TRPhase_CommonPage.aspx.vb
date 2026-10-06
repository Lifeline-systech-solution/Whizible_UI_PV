Imports CommonEngines.General.cEventHandlers
Public Class cRTM_Req_TRPhase_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cRTM_Req_TRPhase_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cRTM_Req_TRPhase_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL

    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cRTM_Req_TRPhase_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private m_strProjectID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)

    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")

    End Sub
End Class


Public Class RTM_Req_TRPhase_CommonPage
    Inherits CommonPage
#Region "Global Variables"
    Protected m_strProjectRequirementID As String
#End Region
    Private m_strProjectID As String
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
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "RTM_Req_TRPhase_CommonList.aspx"
        MyBase.strFormPage = "RTM_Req_TRPhase_CommonPage.aspx"
        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cRTM_Req_TRPhase_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cRTM_Req_TRPhase_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cRTM_Req_TRPhase_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function


    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function

    Protected Overrides Sub After_ExecutingAction(ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_DynamicLinkExecution, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "", Optional ByVal ControlsHashTable As System.Collections.Hashtable = Nothing)
    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String

        Dim ProjectRequirementID As String = ""
        Dim strAction As String = ""
        ProjectRequirementID = Request.QueryString("ProjectRequirementID").ToString.Trim
        strAction = "ProjectRequirements_CommonPage.aspx?MasterTagID=3714&FromWhere=PM&ProjectRequirementID_PK=" & ProjectRequirementID
        'Response.Write("<script> window.opener.location.href = '" & strAction & "'; </script>")
        Response.Write("<script>")
        Response.Write("    var strOld, strNew; ")
        Response.Write("    strOld = window.opener.location.href; ")
        Response.Write("    strNew = strOld.replace('Operation=DELETE&Mode=&', ''); ")
        Response.Write("    window.opener.frmCommonPage.action = strNew; ")
        Response.Write("    window.opener.frmCommonPage.submit(); ")
        Response.Write("</script>")
    End Function
End Class
