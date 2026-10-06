Public Class RM_CommonList
    Inherits CommonList
    '=====================================================================
    ' Class	Name	        :	RM_CommonList
    ' Purpose				:	Page for ReportMatrics
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Jan 26,2008
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
    Private IsDeleteOperation As Boolean = False


    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

        MyBase.strListPage = "RM_CommonList.aspx"
        MyBase.strFormPage = "RM_CommonPage.aspx"


        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If MyBase.m_objGlobal.ParentTagID = 0 Then
            Select Case MyBase.m_objGlobal.TagID
                Case APP_TAG_RM_ResourceUtilization_Filters
                    Args.HTMLLegend = ""
                    Cancel = True
            End Select
        End If
        
    End Sub

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If WhizGlobal.ParentTagID = 0 Then
            Select Case WhizGlobal.TagID
                Case APP_TAG_RM_ResourceUtilization_Filters
                    IsDeleteOperation = True
            End Select
        End If

    End Function

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If m_objGlobal.ParentTagID = 0 Then
            Select Case m_objGlobal.TagID
                Case APP_TAG_RM_ResourceUtilization_Filters
                    If IsDeleteOperation = True Then
                        Dim sbScript As New System.Text.StringBuilder

                        sbScript.Append("<Script language=javascript>")
                        sbScript.Append("if(window.location.href.match(""Operation=DELETE"") == ""Operation=DELETE"")")
                        sbScript.Append("{var strParentPage = new String();")
                        sbScript.Append("strParentPage = '../REPORTANDMETRICS/RM_ResourceUtilizationReport_Filters.aspx?FilterID='+window.opener.document.getElementById('cboAppliedView').value;")
                        sbScript.Append("strParentPage = strParentPage + '&MasterTagID=3904&FromWhere=MR'+'&DateRangeID='+window.opener.document.getElementById('cboDateRange').value;")
                        sbScript.Append("refreshParent('frmResourceUtilizationFilters', 'RM_ResourceUtilizationReport_Filters.aspx',strParentPage);}")
                        sbScript.Append("</Script>")
                        Response.Write(sbScript.ToString)
                        sbScript = Nothing

                    End If

            End Select
        End If

    End Function
End Class
