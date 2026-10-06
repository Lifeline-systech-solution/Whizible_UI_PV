Public Class HR_CommonPage
    Inherits CommonPage
    '=====================================================================
    ' Class	Name	        :	HR_CommonPage
    ' Purpose				:	Page for HR 
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Feb 01, 2008
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
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Private Const APP_TAG_HR_BenchAndTraining_Gantt As Long = 3867
    Private Const APP_TAG_HR_ResourcePoolMaster As Long = 3900
    Private IsSaveOperation As Boolean = False

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_CommonList.aspx"
        MyBase.strFormPage = "HR_CommonPage.aspx"


        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        If WhizGlobal.ParentTagID = 0 Then
            Select Case WhizGlobal.TagID
                Case APP_TAG_HR_BenchAndTraining_Gantt
                    IsSaveOperation = True
                    RedirectToCL = False
            End Select
        End If
    End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        If m_objGlobal.ParentTagID = 0 Then
            Select Case m_objGlobal.TagID
                Case APP_TAG_HR_BenchAndTraining_Gantt
                    If IsSaveOperation = True Then
                        Dim sbScript As New System.Text.StringBuilder
                        sbScript.Append("<Script Laguage=javascript>")
                        sbScript.Append("var strParentPage;" + vbCrLf)
                        sbScript.Append("strParentPage = '../HR/HR_BenchAndTrainingGantt.aspx?MasterTagID=3867&FromWhere=RM'+'&PageNumber='+window.opener.document.getElementById('txtPageNumber').value;" + vbCrLf)
                        sbScript.Append("refreshParent('frmBenchAndTraining', 'HR_BenchAndTrainingGantt.aspx',strParentPage);" + vbCrLf)
                        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Operation")).ToUpper = "SAVE" And HttpContext.Current.Request.QueryString("SubOperation") = "" And HttpContext.Current.Request.QueryString("Mode") = "ADD_NEW" Then
                            sbScript.Append("window.close();" + vbCrLf)
                        End If
                        sbScript.Append("</Script>")
                        Response.Write(sbScript.ToString)
                        sbScript = Nothing
                    End If
            End Select
        End If
    End Function
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cHR_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

End Class
Public Class cHR_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private Const APP_TAG_HR_BenchAndTraining_Gantt As Long = 3867
    Private Const APP_TAG_HR_ResourcePoolMaster As Long = 3900
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Sub Before_PlotControlCaption(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeCaption As String = "")
        Select Case WhizGlobal.TagID
            Case APP_TAG_HR_ResourcePoolMaster
                If Args.ControlName.ToUpper() = "NONDATABASE1" Then
                    Dim m_objAccess As WebPage.Templates.AccessRights = New WebPage.Templates.AccessRights
                    'Get the Access Rights 
                    m_objAccess.GetAccess(WhizGlobal)
                    If m_objAccess.Edit = False And m_objAccess.Add = False Then
                        Args.HREF_URL = ""
                        Args.HREF_Parameters = ""
                    End If
                End If
        End Select
    End Sub


End Class
