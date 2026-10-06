Imports CommonEngines.General.cEventHandlers
Public Class TestCaseSection_CommonList
    Inherits CommonList


    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cTest_Section_Grid_CommonList(MyBase.m_objGlobal)
    End Function

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
    Private m_strProjectRequirementID As String
    Private m_strProjectID As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "TestCaseSection_CommonList.aspx"
        MyBase.strFormPage = "TestCaseSection_CommonPage.aspx"
        m_strProjectID = Request.QueryString("ProjectID")
        m_strProjectRequirementID = Request.QueryString("ProjectRequirementID")

        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        If Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If

        'MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")

        Dim strSelectedTestCase As String
        Dim strScript As String
        Dim strSQL As String


        Dim StrInput As String
        Dim drreader As IDataReader



        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strSelectedTestCase = CommonFunctions.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))

            If Request.Form("ProjectTestSetID") <> "" Then
                strSQL = "usp_RM_Ins_TestCaseMapping " + m_strProjectRequirementID + ",'" + strSelectedTestCase + "'," + m_strProjectID + "," + Request.Form("ProjectTestSetID")
            Else
                strSQL = "usp_RM_Ins_TestCaseMapping " + m_strProjectRequirementID + ",'" + strSelectedTestCase + "'," + m_strProjectID + ",NULL"
            End If
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            CommonFunction.General.WriteHTML("<Script language=javascript >")
            CommonFunction.General.WriteHTML("refreshParent('frmMapping','RM_ProjectRequirementMapping.aspx','RM_ProjectRequirementMapping.aspx?FromWhere=RM&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "');")


            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")


        End If
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SAVE_ONSELECT" Then
            Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../RM/TestCaseSection_CommonList.aspx?ProjectID=" + m_strProjectID + "&FromWhere=PM&ProjectRequirementID=" + m_strProjectRequirementID + "&MasterTagId=3736&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf

        End If
        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID
        If Args.CustomLink <> "" Then
            Args.CustomLink = Args.CustomLink.Replace("<PROJECT_ID>", m_strProjectID)
        End If
        'End of Addition by PrashantD

    End Sub
End Class
Public Class cTest_Section_Grid_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid
    Private m_strProjectID As String
    Private m_strProjectRequirementID As String
    Private m_strSelectedID As String()
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)


    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        m_strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID")
        If HttpContext.Current.Request.Form("hidProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If
        If HttpContext.Current.Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = HttpContext.Current.Request.Form("hidProjectRequirementID")
        End If

        Dim strSQL As String


        strSQL = "usp_RM_Sel_TestCaseMapping " + m_strProjectRequirementID

        m_strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)

    End Sub



    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

        Dim strSQL As String
        Dim intcount As Integer
        Dim strProjectRequirementID As String
        Dim strChkDelete As String


        If Args.ColumnName.ToUpper = "SELECT" Then

            For intcount = 0 To m_strSelectedID.Length - 1
                If m_strSelectedID(intcount) = Args.DataReader.Item("ProjectTestCaseID").ToString Then
                    Args.IsSelected = True
                End If
            Next
        End If
        ' End If
    End Sub




End Class
