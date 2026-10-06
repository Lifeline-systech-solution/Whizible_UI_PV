Imports CommonEngines.General.cEventHandlers
Public Class RTM_DeliverableMapping_CommonList
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

    Public Class DeliverableMapping_cPlotGrid   'Child Class
        Inherits CommonEngine.CommonList.cPlotGrid

        Private m_strReqTRPhaseID As String
        Private strSelectedID() As String

        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
            Dim strSQL As String

            m_strReqTRPhaseID = HttpContext.Current.Request.QueryString("ReqTRPhaseID") + ""

            If HttpContext.Current.Request.Form("hidReqTRPhaseID") <> "" Then
                m_strReqTRPhaseID = HttpContext.Current.Request.Form("hidReqTRPhaseID")
            End If


            strSQL = "usp_RTM_Sel_DeliverableMapping " + m_strReqTRPhaseID
            strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)

        End Sub

        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

            Dim intcount As Integer

            If Args.ColumnName.ToUpper = "SELECT" Then

                For intcount = 0 To strSelectedID.Length - 1
                    If strSelectedID(intcount) = Args.DataReader.Item("DeliverableID").ToString Then
                        Args.IsSelected = True
                    End If
                Next
            End If

        End Sub

    End Class

    Private m_strProjectID As String
    Private m_strProjectRequirementID, m_strReqTRPhaseID As String

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New DeliverableMapping_cPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "RTM_DeliverableMapping_CommonList.aspx"
        MyBase.strFormPage = "../General/CommonPage.aspx"

        'Put user code to initialize the page here
        m_strProjectID = Request.QueryString("ProjectID") + ""
        m_strProjectRequirementID = Request.QueryString("ProjectRequirementID") + ""
        m_strReqTRPhaseID = Request.QueryString("ReqTRPhaseID") + ""

        If Request.Form("hidProjectID") <> "" Then
            m_strProjectID = Request.Form("hidProjectID")
        End If
        If Request.Form("hidProjectRequirementID") <> "" Then
            m_strProjectRequirementID = Request.Form("hidProjectRequirementID")
        End If
        If Request.Form("hidReqTRPhaseID") <> "" Then
            m_strReqTRPhaseID = Request.Form("hidReqTRPhaseID")
        End If


        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidReqTRPhaseID id=hidReqTRPhaseID value=" + m_strReqTRPhaseID + ">")

        Dim strSelectedDeliverables As String
        Dim strScript As String
        Dim strSQL As String



        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            strSelectedDeliverables = CommonFunctions.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))

            strSQL = "usp_RTM_Ins_DeliverableMapping " + m_strReqTRPhaseID + "," + m_strProjectRequirementID + ",'" + strSelectedDeliverables + "'," + m_strProjectID + ","
            If Request.Form("DeliverableTypeID") = "" Then
                strSQL += "NULL"
            Else
                strSQL += Request.Form("DeliverableTypeID")
            End If
            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)


            CommonFunction.General.WriteHTML("<Script language=javascript >" & vbCrLf)
            CommonFunction.General.WriteHTML("refreshParent('frmTRMapping','RTM_ProjectRqmtTraceMapping.aspx','RTM_ProjectRqmtTraceMapping.aspx?FromWhere=RM&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID" + m_strReqTRPhaseID + "');" & vbCrLf)
            CommonFunction.General.WriteHTML("window.close();" & vbCrLf)
            CommonFunction.General.WriteHTML("</Script>")

        End If
    End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SELECT_ONCLICK" Then

            Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            'Comment and addition by SuchitraP on 13 Sept 2007
            'Args.ToBeInsertedInFunction += "objForm.action='../RM/RTM_DeliverableMapping_CommonList.aspx?FromWhere=PM&MasterTagId=10063&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID" + m_strReqTRPhaseID + "&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../RM/RTM_DeliverableMapping_CommonList.aspx?FromWhere=PM&MasterTagId=3843&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID" + m_strReqTRPhaseID + "&Save=True'" + vbCrLf
            'End of Comment and addition by SuchitraP on 13 Sept 2007
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

