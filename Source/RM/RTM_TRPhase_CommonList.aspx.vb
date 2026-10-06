Imports CommonEngines.General.cEventHandlers
Public Class RTM_TRPhase_CommonList
    Inherits CommonList

    Protected strcurrProjectRequirementid As String

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
        MyBase.strListPage = "RTM_TRPhase_CommonList.aspx"
        MyBase.strFormPage = "RTM_TRPhase_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cRTM_TRPhase_CommonList(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If Args.HTMLLegend.ToUpper = "RED COLOR INDICATES APPLIED FILTER" Then
            Cancel = True
        End If
    End Sub

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName.ToUpper = "SELECT_ONCLICK" Then
            Args.ToBeInsertedInFunction = "var objForm,intItems,intCtr,blnSelected,strCheckboxIDs;" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm = GetFormReference('frmCommonList');" + vbCrLf
            'Comment and addition done by SuchitraP on on 13 Sept 2007
            'Args.ToBeInsertedInFunction += "objForm.action='../RM/RTM_TRPhase_CommonList.aspx?FromWhere=PM&MasterTagID=10059&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.action='../RM/RTM_TRPhase_CommonList.aspx?FromWhere=PM&MasterTagID=3840&Save=True'" + vbCrLf
            'End of Comment and addition done by SuchitraP on on 13 Sept 2007
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf
            'End If
        End If

        If Args.ClientSideFunctionName.ToUpper = "INHERITFROMPROJECT" Then
            Dim strProjectID As String
            Dim strSQL As String

            If Not Request.QueryString("ProjectID") Is Nothing Then
                strProjectID = Request.QueryString("ProjectID").Trim.ToString
            End If

            Dim blnShowLinkCheck As Boolean = False
            Dim drCheckValidations As IDataReader

            strSQL = "EXEC usp_Chk_tbl_RTM_TRPhase " & strProjectID
            drCheckValidations = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
            If drCheckValidations.Read() Then
                blnShowLinkCheck = CType(drCheckValidations("ShowLink"), Boolean)
            End If
            CommonFunctions.Data.DisposeDataReader(drCheckValidations)

            If blnShowLinkCheck = True Then
                Dim strIsClicked As String
                If Not Request.QueryString("DYNAMIC_ACTION") Is Nothing Then
                    strIsClicked = Request.QueryString("DYNAMIC_ACTION").Trim.ToString
                End If

                If strIsClicked = "1" Then
                    Dim strUpdateSQL As String = ""
                    If strProjectID <> "" Then
                        strUpdateSQL = " EXEC usp_Ins_tbl_RTM_TRPhase " & strProjectID
                        CommonFunction.Data.InsertOrUpdateData(strUpdateSQL, True)

                        Response.Write("<script LANGUAGE=javascript>" + vbCrLf)
                        Response.Write(" window.location.href = window.location.href ; ")
                        Response.Write("</script>")

                        Cancel = True
                    End If
                End If
            Else
                Cancel = True
            End If
        End If
    End Sub

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    'End Function
End Class
Public Class cRTM_TRPhase_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    'Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
    'End Sub
End Class