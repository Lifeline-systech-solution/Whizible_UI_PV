Imports CommonEngines.General.cEventHandlers
Public Class HR_OpportunityDetails_CommonList
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
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_OpportunityDetails_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)


    End Sub

    Public Sub PlotHeader()
        ''Commented by SuchitraP on 15 Feb 2008
        'CommonFunctions.General.WriteHTML("<TABLE cellpadding=0 cellspacing=0 class=clsTableNavLinks width='100%'>")
        'CommonFunctions.General.WriteHTML("<TR class=clsTRNavLinks valign=middle>")
        'CommonFunctions.General.WriteHTML("<TD noWrap>")
        'CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsSelected'  Title='Opportunity Details' href='javascript:ItemTab_OnClick(""Opportunity"")'>Opportunity Details</a>")
        ''CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;<a class='clsNavTab'  Title='Resource Allocation' href='javascript:ItemTab_OnClick(""RA"")' >Resource Allocation</a>")
        'CommonFunctions.General.WriteHTML("</TD> </TR>")
        'CommonFunctions.General.WriteHTML("</TABLE>")
        ''End of comment by SuchitraP
    End Sub
#End Region
    Private objDF As cHR_OpportunityDetails_DynamicFilters
    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        PlotHeader()
    End Function
    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        objDF = New cHR_OpportunityDetails_DynamicFilters(MyBase.m_objGlobal)
        Return objDF
    End Function
    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
        Dim strScript As New System.Text.StringBuilder
        strScript.Append("<Script language=javascript>" + vbCrLf)

        strScript.Append("if (GetObjectReference('frmCommonList','BusinessGroupID')!=null)" + vbCrLf)
        strScript.Append("{ GetObjectReference('frmCommonList','BusinessGroupID').onchange=BG_OnChange;}" + vbCrLf)
        strScript.Append("function BG_OnChange() {" + vbCrLf)
        strScript.Append("GetObjectReference('frmCommonList','LocationID').value= ''" + vbCrLf)
        strScript.Append("GetObjectReference('frmCommonList','LocationID_UserFriendlyValue').value='';" + vbCrLf)
        strScript.Append("objfrm = GetFormReference('frmCommonList');" + vbCrLf)
        strScript.Append("objfrm.action = ""HR_OpportunityDetails_CommonList.aspx?SetFilter=1"";" + vbCrLf)
        strScript.Append("objfrm.submit();}" + vbCrLf)
        strScript.Append("</Script> " + vbCrLf)
        HttpContext.Current.Response.Write(strScript.ToString)
    End Function

    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        Args.HTMLLegend = ""
        Cancel = True
    End Sub
End Class

Public Class cHR_OpportunityDetails_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters

    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub
    Public m_strLocationID As String

    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim BGID As String
        Dim LocID As String

        Dim hid_BGID As String
        Dim drFilter As IDataReader
        Dim strSQL As String
        Dim intUserID As String = CStr(HttpContext.Current.Session("intUserID"))
        Dim strLoginType As String = CStr(HttpContext.Current.Session("LoginType"))
        Dim blnUseSQL As Boolean = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)

        BGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("BusinessGroupID"), "")
        LocID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("LocationID"), "")

        If Args.FilterName.ToUpper = "LOCATIONID" Then
            If BGID <> "" Or BGID Is Nothing Then
                Args.SQL = " SELECT tbl_PM_Location.LocationID,Location " + vbCrLf
                Args.SQL += " FROM tbl_PM_Location" + vbCrLf
                Args.SQL += " INNER JOIN tbl_CNF_BusinessGroup_OUPools ON tbl_CNF_BusinessGroup_OUPools.OUPoolID=tbl_PM_Location.LocationID" + vbCrLf
                Args.SQL += " WHERE BusinessGroupID = " + BGID + vbCrLf
                Args.SQL += " ORDER BY Location" + vbCrLf
            Else
                ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
                ''  Args.SQL = "SELECT tbl_PM_Location.LocationID,Location FROM tbl_PM_Location ORDER BY Location"
                Args.SQL = "usp_sel_tbl_PM_Location_Location"
                ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
            End If
        End If

    End Sub
End Class
