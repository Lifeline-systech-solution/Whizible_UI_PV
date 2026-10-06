Imports CommonEngines.General.cEventHandlers
Public Class RTM_TaskMapping_CommonList
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

    Class List_Print    'CHILD CLASS
        Inherits CommonEngine.CommonList.cPlotGrid
        Private m_strReqTRPhaseID As String
        Private strSelectedID() As String
        'Protected m_strProjectRequirementID As String
        Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
            Call MyBase.New(WhizGlobal)
        End Sub

        Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
            m_strReqTRPhaseID = HttpContext.Current.Request.QueryString("ReqTRPhaseID") + ""

            If HttpContext.Current.Request.Form("hidReqTRPhaseID") <> "" Then
                m_strReqTRPhaseID = HttpContext.Current.Request.Form("hidReqTRPhaseID")
            End If

            Dim strSQL As String

            strSQL = "usp_RTM_Sel_TaskMapping " + m_strReqTRPhaseID
            strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)
        End Sub

        Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)

            Dim intcount As Integer

            If Args.ColumnName.ToUpper = "SELECT" Then
                For intcount = 0 To strSelectedID.Length - 1
                    If strSelectedID(intcount) = Args.DataReader.Item("TaskID").ToString Then
                        Args.IsSelected = True
                    End If
                Next
            End If

        End Sub
    End Class

    Private m_strProjectRequirementID, m_strReqTRPhaseID As String
    Private m_strProjectID As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "RTM_TaskMapping_CommonList.aspx"
        MyBase.strFormPage = "../General/CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"

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

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New List_Print(MyBase.m_objGlobal)

    End Function

    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    ''Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    ''    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    ''End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidProjectRequirementID id=hidProjectRequirementID value=" + m_strProjectRequirementID + ">")
        CommonFunction.General.WriteHTML("<INPUT type=hidden name=hidReqTRPhaseID id=hidReqTRPhaseID value=" + m_strReqTRPhaseID + ">")


        Dim strSelectedTasks As String
        Dim strScript As String
        Dim strSQL As String


        If HttpContext.Current.Request.QueryString("Save") = "True" Then
            Dim dr As IDataReader

            'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            'dr = CommonFunction.Data.GetDataReader("SELECT 1 FROM tbl_RM_ProjectRequirements A INNER JOIN tbl_RM_ReuirementStatus B ON A.StatusID = B.StatusID AND MappedToClose = 1 WHERE ProjectRequirementID = " + m_strProjectRequirementID, MyBase.UseSQL)
            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_RM_ProjectRequirements " + m_strProjectRequirementID, MyBase.UseSQL)
            'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
            If dr.Read Then
                CommonFunction.General.WriteHTML("<SCRIPT>alert('Task can not be mapped to this requirement because status of requirement is closed.');</SCRIPT>")
                Exit Function
            End If
            CommonFunction.Data.DisposeDataReader(dr)
            strSelectedTasks = CommonFunctions.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))

            strSQL = "usp_RTM_Ins_TaskMapping " + m_strReqTRPhaseID + "," + m_strProjectRequirementID + ",'" + strSelectedTasks + "'," + m_strProjectID + ","
            If Request.Form("TaskTypeID") = "" Then
                strSQL += "NULL,"
            Else
                strSQL += Request.Form("TaskTypeID") + ","
            End If

            If Request.Form("Priority") = "" Then
                strSQL += "NULL,"
            Else
                strSQL += Request.Form("Priority") + ","
            End If
            If Request.Form("PagingAlphabet") <> "-1" Then
                strSQL += "'" + Request.Form("PagingAlphabet") + "'"
            Else
                strSQL += "'" + Request.Form("EmployeeName") + "'"
            End If


            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            CommonFunction.General.WriteHTML("<Script language=javascript >")
            CommonFunction.General.WriteHTML("refreshParent('frmTRMapping','RTM_ProjectRqmtTraceMapping.aspx','RTM_ProjectRqmtTraceMapping.aspx?FromWhere=RM&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID" + m_strReqTRPhaseID + "');")
            'Added by PrashantD for refreshing opener's opener page to do proper validation of close status

            CommonFunction.General.WriteHTML("if (window.opener)")
            CommonFunction.General.WriteHTML("if (window.opener.opener)")
            CommonFunction.General.WriteHTML("if (window.opener.opener.document.getElementById('hidURL'))")
            CommonFunction.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.document.getElementById('hidURL').value;")

            'End of addition by PrashantD
            CommonFunction.General.WriteHTML("window.close();")
            CommonFunction.General.WriteHTML("</Script>")


        End If

    End Function

    ''Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    ''    strActionCode = ReturnCodes.DO_NOTHING.ToString
    ''End Function


    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SAVE_TEST" Then
            Args.ToBeInsertedInFunction = "var objForm;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            'Comment and addition by SuchitraP on 13 Sept 2007
            'Args.ToBeInsertedInFunction += "objForm.action='../RM/RTM_TaskMapping_CommonList.aspx?FromWhere=PM&MasterTagId=10062&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID" + m_strReqTRPhaseID + "&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../RM/RTM_TaskMapping_CommonList.aspx?FromWhere=PM&MasterTagId=3842&ProjectID=" + m_strProjectID + "&ProjectRequirementID=" + m_strProjectRequirementID + "&ReqTRPhaseID" + m_strReqTRPhaseID + "&Save=True'" + vbCrLf
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

