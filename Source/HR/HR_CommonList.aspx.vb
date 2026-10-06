Public Class HR_CommonList
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
    '===========================================================================
    ' This page is Called From :    1) Resources --> Bench and Traning Gannt View
    '                               Purpose : To remove Filter Legend and refresh Gantt view page.
    '                               2) Resources --> Resource Joining Pool
    '                               Purpose : To remove Filter Legend.
    '                               3) Resources --> Opportunity --> Show Approvers Link
    '                               Purpose : Show Approvers page is CL,To List out approvers needed 
    '                                         to call SP instead of view.
    '                               4)eDashboard--> Management Dashboard HR --> Reports
    '                               Purpose : To remove filter Legend.
    '                               5)Prijects-->Staffing Plan
    '                               Purpose:To remove filter legend
    '===========================================================================
    Private Const APP_TAG_HR_BenchAndTraining_Gantt As Long = 3867
    Private Const APP_TAG_HR_ResourceJoiningPool As Long = 3873
    Private Const APP_TAG_HR_Opportunity_Approvers As Long = 3912
    Private Const APP_TAG_ResourceManagementReports As Long = 3913
    Private Const APP_TAG_PM_StaffingPlan As Long = 3855
    Private IsDeleteOperation As Boolean = False
    Private Const APP_TAG_HR_ResourcePoolMaster As Long = 3900

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_CommonList.aspx"
        MyBase.strFormPage = "HR_CommonPage.aspx"

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If WhizGlobal.ParentTagID = 0 Then
            Select Case WhizGlobal.TagID
                Case APP_TAG_HR_BenchAndTraining_Gantt
                    IsDeleteOperation = True
            End Select
        End If
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If MyBase.m_objGlobal.ParentTagID = 0 Then
            Select Case MyBase.m_objGlobal.TagID
                Case APP_TAG_HR_BenchAndTraining_Gantt
                    Args.HTMLLegend = ""
                    Cancel = True
                Case APP_TAG_HR_ResourceJoiningPool
                    Args.HTMLLegend = ""
                    Cancel = True
                Case APP_TAG_ResourceManagementReports
                    Args.HTMLLegend = ""
                    Cancel = True
                Case APP_TAG_PM_StaffingPlan
                    Args.HTMLLegend = ""
                    Cancel = True
                Case APP_TAG_HR_ResourcePoolMaster
                    Args.HTMLLegend = ""
                    Cancel = True
            End Select
        End If
    End Sub

    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        If m_objGlobal.ParentTagID = 0 Then
            Select Case m_objGlobal.TagID
                Case APP_TAG_HR_BenchAndTraining_Gantt
                    If IsDeleteOperation = True Then
                        Dim sbScript As New System.Text.StringBuilder
                        sbScript.Append("<Script language=javascript>")
                        sbScript.Append("if(window.location.href.match(""Operation=DELETE"") == ""Operation=DELETE"")")
                        sbScript.Append("var strParentPage = new String();")
                        sbScript.Append("strParentPage = '../HR/HR_BenchAndTrainingGantt.aspx?MasterTagID=3867&FromWhere=RM'+'&PageNumber='+window.opener.document.getElementById('txtPageNumber').value;")
                        sbScript.Append("refreshParent('frmBenchAndTraining', 'HR_BenchAndTrainingGantt.aspx',strParentPage);")
                        sbScript.Append("</Script>")
                        Response.Write(sbScript.ToString)
                        sbScript = Nothing

                    End If

            End Select
        End If
    End Function

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cHR_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

End Class
Class cHR_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Private Const APP_TAG_HR_Opportunity_Approvers As Long = 3912
    Private Const APP_TAG_ResourceDemand_Reports As Long = 3913
    Private strOpportunityID As String
    Private Const APP_TAG_HR_ResourcePoolMaster As Long = 3900

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_GridSQL(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGridSQL, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Select Case m_objGlobal.TagID
            Case APP_TAG_HR_Opportunity_Approvers
                strOpportunityID = HttpContext.Current.Request.QueryString("OpportunityID")
                Args.GridSQL = "usp_Sel_tbl_RM_Opportunity_Approvers 'ApproversPage'," + strOpportunityID
                MyBase.LinkSQL = "usp_Sel_tbl_RM_Opportunity_Approvers_PagingCharacters " + strOpportunityID
            Case APP_TAG_ResourceDemand_Reports
                Args.GridSQL = "usp_sel_ResourceDemand_Reports " + HttpContext.Current.Session("intUserID").ToString()
        End Select

    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String

        'Select Case m_objGlobal.TagID
        Select Case objGlobal.TagID
            Case APP_TAG_HR_ResourcePoolMaster
                'If login user is not high or low level then display only created by resource pools and on which he is manager.
                If objGlobal.RoleLevel <> 1 Then
                    GetPageSpecificFilters += " AND ( CreatedBy = '" + HttpContext.Current.Session("strUserName").ToString() + "' "
                    GetPageSpecificFilters += "  OR ResourcePoolID IN(SELECT ResourcePoolID FROM tbl_PM_ResourcePoolManagers WHERE EmployeeID = " + HttpContext.Current.Session("intUserID").ToString() + " )) "
                End If
            Case Else
                GetPageSpecificFilters = MyBase.GetPageSpecificFilters(objGlobal)

        End Select

    End Function

End Class
'Addition by SuchitraP on 7-Mar-2008
'Purpose:To remove employeename link when record is not added from UI
Public Class cHR_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private Const APP_TAG_HR_BenchAndTraining_Gantt As Long = 3867

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Select Case WhizGlobal.TagID
            Case APP_TAG_HR_BenchAndTraining_Gantt
                If Args.DataField = "EmployeeName" Then
                    If CType(Args.DataReader("IsSystemInserted"), Boolean) = True Then
                        Cancel = True
                        Args.StringToBeInserted = "<TD align=left>" + Args.DataReader("EmployeeName").ToString + "</TD>"
                    End If

                End If
        End Select


    End Sub

End Class
'End of addition by SuchitraP