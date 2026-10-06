Imports CommonEngines.General.cEventHandlers
Public Class WorkProducts_CommonList
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
        MyBase.strListPage = "WorkProducts_CommonList.aspx"
        MyBase.strFormPage = "WorkProducts_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cWorkProducts_CommonList(MyBase.m_objGlobal)
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
            Args.ToBeInsertedInFunction += "objForm.action='../RM/WorkProducts_CommonList.aspx?FromWhere=PM&MasterTagID=3716&Save=True'" + vbCrLf
            Args.ToBeInsertedInFunction += "objForm.submit();" + vbCrLf
            Args.ToBeInsertedInFunction += "return;" + vbCrLf
            'End If

        End If
    End Sub

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSQL As String
        Dim workprod_type As String
        Dim workprod_id As Integer
        Dim strselectedworkprod As String
        Dim drworkprod As IDataReader
        Dim strscript As String
        Dim strid As String
        Dim arrComma As Char() = {","c}
        strcurrProjectRequirementid = CStr(HttpContext.Current.Request.QueryString("ProjectRequirementID"))

        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strcurrProjectRequirementid = Request.Form("txthidCurrentworkproductID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkproductID", "txthidCurrentworkproductID", , , , strcurrProjectRequirementid, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strcurrProjectRequirementid = CType(HttpContext.Current.Request.QueryString("ProjectRequirementID"), String)

            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkproductID", "txthidCurrentworkproductID", , , , strcurrProjectRequirementid, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If

        If strcurrProjectRequirementid = "" Then
            strcurrProjectRequirementid = CType(HttpContext.Current.Request.Form("txtProjectRequirementID"), String) + ""
        End If

        If CStr(HttpContext.Current.Request.QueryString("Save")) = "True" Then

            ' strselectedworkprod = CommonFunction.General.BuildQueryString(CType(HttpContext.Current.Request.Form("chkDelete"), String))
            strselectedworkprod = CType(HttpContext.Current.Request.Form("chkDelete"), String)
            If strselectedworkprod <> "" Then
                Dim strlist As String() = strselectedworkprod.Split(arrComma)
                For Each strid In strlist
                    strSQL = "usp_RM_ins_WorkProdSchedule " + strid + ", " + strcurrProjectRequirementid.ToString
                    CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                Next
                strscript = vbCrLf + "<Script language=javascript>"
                strscript += vbCrLf + "    refreshParent('frmCommonPage','ProjectRequirements_CommonPage.aspx?','ProjectRequirements_CommonPage.aspx?FromWhere=PM&MasterTagID=3714&SubTagID=10072&ProjectRequirementID=" + strcurrProjectRequirementid.ToString + "');"
                strscript += vbCrLf + "    window.close();"
                strscript += vbCrLf + "</Script>"
                CommonFunction.General.WriteHTML(strscript)
            End If
        End If
    End Function
End Class
Public Class cWorkProducts_CommonList
    Inherits CommonEngine.CommonList.cPlotGrid
    Protected m_sbValidationScript As String
    Dim m_strprevsection As String
    'Dim m_strprevsectionID As String
    Dim m_intCount As Integer
    Dim m_strsectionheader As String
    Dim m_CheckboxIDs As String
    Dim m_strTestCaseIDs As String
    Dim strstrTestCaseIdBox As String



    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Common Page is accessed from CommonList
        Dim strWhere As String
        Dim strProjectRequirementID As String
        strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementID") + ""


        If strProjectRequirementID = "" Then
            strProjectRequirementID = HttpContext.Current.Request.Form("txtProjectRequirementID") + ""
        End If

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtProjectRequirementID", "txtProjectRequirementID", , , , strProjectRequirementID.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        If HttpContext.Current.Request.QueryString("SetFilter") = "1" Then
            strProjectRequirementID = HttpContext.Current.Request.Form("txthidCurrentworkprodID").ToString
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkprodID", "txthidCurrentworkprodID", , , , strProjectRequirementID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        Else
            strProjectRequirementID = CType(HttpContext.Current.Request.QueryString("ProjectRequirementID"), String)
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            CommonFunctions.HTMLControls.DrawTextBox("txthidCurrentworkprodID", "txthidCurrentworkprodID", , , , strProjectRequirementID, , , , , , True, EnableHTMLEncode:=True)
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        If strProjectRequirementID <> "" Then
            strWhere = " AND WorkProductId Not in (Select WorkProductId from tbl_RM_ReqWorkProd "
            strWhere += " Where ProjectRequirementID = " + strProjectRequirementID + ")"
        Else
            strWhere = " AND WorkProductId Not in (Select WorkProductId from tbl_RM_ReqWorkProd )"
        End If
        Args.GridSQL = Replace(Args.GridSQL, "ORDER", strWhere + " ORDER ")

    End Sub
End Class