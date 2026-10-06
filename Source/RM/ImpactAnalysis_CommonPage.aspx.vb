Imports CommonEngines.General.cEventHandlers
Public Class ImpactAnalysis_CommonPage
    Inherits CommonPage
    Private m_strProjectID As String
    Private m_strProjectRequirementID As String
    Private isUpperMenuPlotted As Boolean = False
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
        MyBase.strListPage = "ImpactAnalysis_CommonList.aspx"
        MyBase.strFormPage = "ImpactAnalysis_CommonPage.aspx"
        If Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = Request.QueryString("ProjectID")
        Else
            m_strProjectID = Request.Form("hidProjectID")
        End If
        If Request.QueryString("ProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        Else
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If


        MyBase.Page_Load(sender, e)

    End Sub

    Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
        ''''Dim strsql As String
        ''''Dim drImpact As IDataReader


        ''''Dim Classificaton As String
        ''''Dim ImpactAssessedBy As String
        ''''Dim ImpactAssessedDate As String
        ''''Dim DetailsOfChanges As String
        ''''Dim ImpactAnalysisApprovedBy As String
        ''''Dim ImpactAnalysisApprovedDate As String
        ''''Dim ImpactAnalysisApproverComments As String
        ''''Dim ImpactAnalysisApprovedByCustomer As String
        ''''Dim strProjectRequirement_ImpactId As String



        ''''Classificaton = CType(HttpContext.Current.Request.Form("Classificaton"), String)
        ''''ImpactAssessedBy = CType(HttpContext.Current.Request.Form("ImpactAssessedBy"), String)
        ''''ImpactAssessedDate = CType(HttpContext.Current.Request.Form("ImpactAssessedDate"), String)
        ''''DetailsOfChanges = CType(HttpContext.Current.Request.Form("DetailsOfChanges"), String)
        ''''ImpactAnalysisApprovedBy = CType(HttpContext.Current.Request.Form("ImpactAnalysisApprovedBy"), String)
        ''''ImpactAnalysisApproverComments = CType(HttpContext.Current.Request.Form("ImpactAnalysisApproverComments"), String)
        ''''ImpactAnalysisApprovedDate = CType(HttpContext.Current.Request.Form("ImpactAnalysisApprovedDate"), String)
        ''''ImpactAnalysisApprovedByCustomer = CType(HttpContext.Current.Request.Form("ImpactAnalysisApprovedByCustomer"), String)

        ''''strsql = "Select ProjectRequirement_ImpactId from tbl_RM_ProjectReqImpactAnalysis where ProjectRequirementId=" + m_strProjectRequirementID
        ''''drImpact = CommonFunction.Data.GetDataReader(strsql, MyBase.UseSQL)
        ''''If drImpact.Read() Then
        ''''    strProjectRequirement_ImpactId = CStr(CommonFunctions.Data.CheckIsDBNull(drImpact("ProjectRequirement_ImpactId"), ""))

        ''''End If
        ''''CommonFunctions.Data.DisposeDataReader(drImpact)
        ''''strsql = "usp_Upd_tbl_RM_ProjectReqImpactAnalysis " + m_strProjectID + "," + strProjectRequirement_ImpactId + ",'" + Classificaton + "','" + ImpactAssessedBy + "','" + ImpactAssessedDate + "','" + DetailsOfChanges + "','" + ImpactAnalysisApprovedBy + "','" + ImpactAnalysisApprovedDate + "','" + ImpactAnalysisApproverComments + "','" + ImpactAnalysisApprovedByCustomer + "'"
        ''''CommonFunction.Data.InsertOrUpdateData(strsql, MyBase.UseSQL)

    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")

        Return New cImpactAnalysis_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cImpactAnalysis_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cImpactAnalysis_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)

        Dim strbuildstring As String
        Dim strSQL As String
        Dim strRequirementTitle As String
        Dim drRequirement As IDataReader

        'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSQL = "Select ReqTitle from tbl_RM_ProjectRequirements Where ProjectRequirementID=" + m_strProjectRequirementID
        strSQL = "usp_sel_tbl_RM_ProjectRequirements_ReqTitle " + m_strProjectRequirementID
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        drRequirement = CommonFunctions.Data.GetDataReader(strSQL, True)
        If drRequirement.Read Then
            strRequirementTitle = CStr(drRequirement.Item("ReqTitle"))
            strbuildstring = "Requirement Title : " + strRequirementTitle
            Args.RightPageCaption = strbuildstring
        End If
        CommonFunctions.Data.DisposeDataReader(drRequirement)
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID
        If Args.CustomLink <> "" Then
            Args.CustomLink = Args.CustomLink.Replace("<PROJECT_ID>", m_strProjectID)
        End If
        'End of Addition by PrashantD
    End Sub

    Protected Overrides Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If isUpperMenuPlotted = False And Request.QueryString("SubTagFromCL") <> "1" Then
            isUpperMenuPlotted = True
            RM_CommonFunction.Genereal.DrawRequirementHeaderNavigation("Impact", m_strProjectRequirementID, m_strProjectID, Args.PrimaryKeyValue)
        End If
    End Sub
End Class
Public Class cImpactAnalysis_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cImpactAnalysis_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cImpactAnalysis_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cImpactAnalysis_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private m_strProjectID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If

    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID

        If Args.AdditionalInformation <> "" Then
            Args.AdditionalInformation = Args.AdditionalInformation.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.AddNewRelativeSource <> "" Then
            Args.AddNewRelativeSource = Args.AddNewRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.DropDownEditSQL <> "" Then
            Args.DropDownEditSQL = Args.DropDownEditSQL.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.EditRelativeSource <> "" Then
            Args.EditRelativeSource = Args.EditRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If



        'End of addition by PrashantD
    End Sub
End Class
