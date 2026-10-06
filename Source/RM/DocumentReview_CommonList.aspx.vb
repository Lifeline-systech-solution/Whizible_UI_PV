Imports CommonEngines.General.cEventHandlers
Public Class DocumentReview_CommonList
    Inherits CommonList

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

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "DocumentReview_CommonList.aspx"
        MyBase.strFormPage = "DocumentReview_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If

        If Request.QueryString("ProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")
        Else
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If

        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cDocumentReview_CommonList(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "UPLOAD" Then
            Args.ToBeInsertedInFunction += "window.open ('../RM/RM_Attachment.aspx?FromWhere=PM&MasterTagID=3721&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "', '', 'resizable=yes,scrollbars=yes,menubar=no,toolbar=no,statusbar=no,left=' + ((window.screen.width - 600)/2) + ',top=' + ((window.screen.height - 400)/2) + ',width=650,height=300');" + vbCrLf
            Args.ToBeInsertedInFunction += "return;"
        End If
    End Sub

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

        Dim strSQL As String
        Dim drReqTitle As IDataReader

        ''Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
        'strSQL = "Select ReqTitle From tbl_RM_ProjectRequirements Where ProjectRequirementID=" + m_strProjectRequirementID
        strSQL = "usp_sel_tbl_RM_ProjectRequirements_ReqTitle " + m_strProjectRequirementID
        'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

        drReqTitle = CommonFunctions.Data.GetDataReader(strSQL, True)

        If drReqTitle.Read Then
            Args.RightPageCaption = "Requirement: " + CStr(drReqTitle.Item("ReqTitle"))
        End If

        CommonFunction.Data.DisposeDataReader(drReqTitle)
    End Sub

    Protected Overrides Sub Before_Menu_Print(ByRef Cancel As Boolean, ByRef Args As WAF_MenuLinks, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If isUpperMenuPlotted = False Then
            isUpperMenuPlotted = True
            RM_CommonFunction.Genereal.DrawRequirementHeaderNavigation("Documents", m_strProjectRequirementID, m_strProjectID)
        End If
    End Sub
End Class

Public Class cDocumentReview_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid
    Protected m_strPrevDoc As String
    Protected m_strUpdatedDate As String
    Private m_strProjectID As String
    Private m_strProjectRequirementID As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If
        If HttpContext.Current.Request.QueryString("ProjectRequirementID") <> "" Then
            m_strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID")
        Else
            m_strProjectRequirementID = HttpContext.Current.Request.Form("hidProjectRequirementID")
        End If
    End Sub
    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strSQL As String
        Dim drDoc As IDataReader
        Dim strProjectDocumentRefTypeID As String
        Dim bitORiginal As Integer

        strProjectDocumentRefTypeID = CStr(Args.DataReader("ProjectDocumentRefTypeID"))


        bitORiginal = CInt(Args.DataReader("Original"))

        If bitORiginal = 0 Then
            Cancel = True
        End If

    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
    End Sub
End Class