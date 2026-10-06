Imports CommonEngines.General.cEventHandlers
Public Class ChangeRequestMapping_CommonList
    Inherits CommonList

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
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New CRMapping_cPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "ChangeRequestMapping_CommonList.aspx"
        MyBase.strFormPage = "ChangeRequestMapping_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        m_strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID")
        m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        If Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
        

    End Sub


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SELECT_ONCLICK" Then

            Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../RM/ChangeRequestMapping_CommonList.aspx?FromWhere=PM&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&MasterTagId=3738&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf

        End If
        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID
        If Args.CustomLink <> "" Then
            Args.CustomLink = Args.CustomLink.Replace("<PROJECT_ID>", m_strProjectID)
        End If
        'End of Addition by PrashantD

    End Sub


    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")

        Dim strSelectedRequests As String
        Dim strScript As String
        Dim strSQL As String


        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strSelectedRequests = CommonFunctions.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))

            strSQL = "usp_RM_Ins_ChangeRequestMapping " + m_strProjectRequirementID + ",'" + strSelectedRequests + "'," + m_strProjectID + ","
            If Request.Form("ChangeStatus") = "" Then
                strSQL += "NULL"
            Else
                strSQL += "'" + Request.Form("ChangeStatus") + "'"
            End If
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            CommonFunction.General.WriteHTML("<Script language=javascript >")
            CommonFunction.General.WriteHTML("refreshParent('frmMapping','RM_ProjectRequirementMapping.aspx','RM_ProjectRequirementMapping.aspx?FromWhere=RM&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "');")
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")

        End If
    End Function
End Class
Public Class CRMapping_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private m_strSelectedID As String()
    Private m_strProjectRequirementID As String
    Private m_strProjectID As String

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strSQL As String
        m_strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID")
        m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")

        If HttpContext.Current.Request.Form("hidProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If
        If HttpContext.Current.Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = HttpContext.Current.Request.Form("hidProjectRequirementID")
        End If

        strSQL = "usp_RM_Sel_ChangeRequestMapping " + m_strProjectRequirementID

        m_strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim intcount As Integer
        If Args.ColumnName.ToUpper = "SELECT" Then
            For intcount = 0 To m_strSelectedID.Length - 1
                If m_strSelectedID(intcount) = Args.DataReader.Item("ChangeRequestID").ToString Then
                    Args.IsSelected = True
                    Exit For
                End If
            Next
        End If
        ' End If
    End Sub


End Class



