Public Class RM_CommonPage
    Inherits CommonPage
    '=====================================================================
    ' Class	Name	        :	RM_CommonPage
    ' Purpose				:	Page for report Metrics
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Jan 26, 2008
    ' Revisions				:	
    '=====================================================================
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
    Private Const APP_TAG_RM_ResourceUtilization_Filters As Long = 3903
    Private IsSaveOperation As Boolean = False
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "RM_CommonList.aspx"
        MyBase.strFormPage = "RM_CommonPage.aspx"


        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        If WhizGlobal.ParentTagID = 0 Then
            Select Case WhizGlobal.TagID
                Case APP_TAG_RM_ResourceUtilization_Filters
                    IsSaveOperation = True
                    RedirectToCL = False
            End Select
        End If


    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If m_objGlobal.ParentTagID = 0 Then
            Select Case m_objGlobal.TagID
                Case APP_TAG_RM_ResourceUtilization_Filters
                    If IsSaveOperation = True Then
                        Dim sbScript As New System.Text.StringBuilder
                        sbScript.Append("<Script Laguage=javascript>")
                        sbScript.Append("var strParentPage = new String();")
                        sbScript.Append("strParentPage = '../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FilterID='+window.opener.document.getElementById('cboAppliedView').value;")
                        sbScript.Append("strParentPage = strParentPage + '&MasterTagID=3904&FromWhere=MR'+'&DateRangeID='+window.opener.document.getElementById('cboDateRange').value;")
                        sbScript.Append("refreshParent('frmResourceUtilizationFilters', 'RM_ResourceUtilizationReport_Filters.aspx',strParentPage);")
                        sbScript.Append("</Script>")
                        Response.Write(sbScript.ToString)
                        sbScript = Nothing
                    End If

            End Select
        End If
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cRM_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

End Class
Public Class cRM_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If CType(HttpContext.Current.Session("intRoleLevel"), Integer) = 3 Then
            Select Case Args.ControlName.ToUpper()
                Case "BUSINESSGROUPID", "ORGANIZATIONUNITID", "DELIVERYUNITID", "DELIVERYTEAMID", "ROLEID", "DESIGNATIONID", "DEPARTMENTID", "GRADEID", "TOOLID", "TOTALEXP", "TOTALEXPCOND", "CERTIFICATIONID", "QUALIFICATIONID"
                    'Args.DisableInEditMode = True
                    Args.Editable = False

            End Select
        End If
    End Sub
End Class

