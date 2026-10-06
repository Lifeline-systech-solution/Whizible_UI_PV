Imports CommonEngines.General.cEventHandlers
Public Class HR_BenchAndTraining_CommonList
    Inherits CommonList

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

    'Private m_strJoiningDateFrom As String
    'Private m_strJoiningDateTo As String

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        Dim strEmpID As String
        Dim arrEmployeeID() As String
        Dim strSQL As String
        Dim cnt As Integer
        Dim strAvailDate As String

        strEmpID = Request.Form("hidEmployeeIDs")

        If Request.QueryString("Save") = "1" Then
            arrEmployeeID = strEmpID.Split(CType(",", Char))
            For cnt = 0 To arrEmployeeID.Length - 2
                strAvailDate = "'" + (Request.Form("AvailabilityFrom" + arrEmployeeID(cnt))).Trim + "'"
                If strAvailDate = "''" Then
                    strAvailDate = "NULL"
                End If
                strSQL = "usp_upd_tbl_PM_Employee_OnBench " + strAvailDate + "," + arrEmployeeID(cnt)
                CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
            Next

        End If

        'm_strJoiningDateFrom = Request.Form("JoiningDateFrom")
        'If m_strJoiningDateFrom Is Nothing OrElse m_strJoiningDateFrom = "" Then
        '    m_strJoiningDateFrom = HttpContext.Current.Request.Form("hidJoiningDateFrom")
        'End If

        'm_strJoiningDateTo = Request.Form("JoiningDateTo")
        'If m_strJoiningDateTo Is Nothing OrElse m_strJoiningDateTo = "" Then
        '    m_strJoiningDateTo = HttpContext.Current.Request.Form("hidJoiningDateTo")
        'End If

        MyBase.strListPage = "HR_BenchAndTraining_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"


        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cHR_BenchAndTraining_CommonListGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDynamicFilters() As CommonEngine.CommonList.cDynamicFilters
        Return New cHR_BenchAndTraining_DynamicFilters(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cHR_BenchAndTraining_CommonListCLSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strJoiningDateFrom As String
        Dim strJoiningDateTo As String
        strJoiningDateFrom = Request.Form("JoiningDateFrom")
        strJoiningDateTo = Request.Form("JoiningDateTo")


        CommonFunction.General.WriteHTML("<TABLE id='DateFilter' cellspacing=0 cellpadding=0 Width=99.9% class=clsTable>")
        CommonFunction.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunction.General.WriteHTML("<TD align=Right>Joining Date From</TD><TD align=left>")
        'CommonFunction.HTMLControls.DrawDateControl("JoiningDateFrom", "JoiningDateFrom", , , m_strJoiningDateFrom, , "frmCommonList", , , , , , , False)
        CommonFunction.HTMLControls.DrawDateControl("JoiningDateFrom", "JoiningDateFrom", , , strJoiningDateFrom, , "frmCommonList", , , , , , , False)
        CommonFunction.General.WriteHTML("</TD>")
        CommonFunction.General.WriteHTML("<TD align=Right>Joining Date To</TD><TD align=left>")
        'CommonFunction.HTMLControls.DrawDateControl("JoiningDateTo", "JoiningDateTo", , , m_strJoiningDateTo, , "frmCommonList", , , , , , , False)
        CommonFunction.HTMLControls.DrawDateControl("JoiningDateTo", "JoiningDateTo", , , strJoiningDateTo, , "frmCommonList", , , , , , , False)
        CommonFunction.General.WriteHTML("</TD><TD>")
        CommonFunction.General.WriteHTML("|<B><A style='' HREF='Javascript:Filter_Onclick()' Title='Apply Filter' >Apply Filter</A></B>|</TD>")
        CommonFunction.General.WriteHTML("</TR></TABLE><BR>")
    End Sub

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidJoiningDateFrom' id='hidJoiningDateFrom' value='" + m_strJoiningDateFrom + "'>")
    '    CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidJoiningDateTo' id='hidJoiningDateTo' value='" + m_strJoiningDateTo + "'>")
    'End Function
End Class
Public Class cHR_BenchAndTraining_CommonListGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected strEmployeeIDs As String

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Dim strAvailabilityFrom As String
        'strAvailabilityFrom = HttpContext.Current.Request.Form("AvailabilityFrom" + Args.DataReader("EmployeeID").ToString)
        'If strAvailabilityFrom Is Nothing Then
        '    strAvailabilityFrom = ""
        'End If


        If Args.ColumnName = "Availability From" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=center>" + CommonFunction.HTMLControls.DrawDateControl("AvailabilityFrom" + Args.DataReader("EmployeeID").ToString, "AvailabilityFrom" + Args.DataReader("EmployeeID").ToString, , , Args.DataReader("CustomFieldDate5").ToString, , "frmCommonList", , , , , , , True) + "</TD>"

            'CustomFieldDate5
        End If
    End Sub

    Protected Overrides Sub Before_GridDataRowTR_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTR, ByVal WhizGlobal As WebPages.Template.IGlobal)
        strEmployeeIDs += Args.DataReader("EmployeeID").ToString + ","

    End Sub

    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonFunction.General.WriteHTML("<INPUT type=hidden name='hidEmployeeIDs' id='hidEmployeeIDs' value='" + strEmployeeIDs + "'>")
    End Sub

End Class
Public Class cHR_BenchAndTraining_DynamicFilters
    Inherits CommonEngine.CommonList.cDynamicFilters

    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Protected Overrides Sub Before_Filter_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicFilters.WAF_PlotDynamicFilter, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strPostDate As String
        If HttpContext.Current.Request.Form("PostDate") Is Nothing Then
            strPostDate = ""
        Else
            strPostDate = HttpContext.Current.Request.Form("PostDate")
        End If

        If Args.FilterName = "BusinessGroupID" Then
            Cancel = True
            Args.ToBeInserted = "<TD align=right title='Post Availabilty From to all selected employees'>Availability From </TD><TD align=left>" + CommonFunction.HTMLControls.DrawDateControl("PostDate", "PostDate", , , strPostDate, , "frmCommonList", , , , , , , True) + " |<B><A style='' HREF='Javascript:Post_Onclick()' Title='Apply To All' >Apply To All</A></B>|<input type=hidden name=BusinessGroupID value=''></TD>"
            ''Args.ToBeInsertedInControl = "<TD align=right title='Post Availabilty From to all selected employees'> Here Will be date </TD><TD><input type=button value=Post></TD>"
        End If


    End Sub

End Class
Public Class cHR_BenchAndTraining_CommonListCLSQL
    Inherits CommonEngine.CommonList.cCLSQL
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(objGlobal)
    End Sub

    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        Dim strJoiningDateFrom As String
        Dim strJoiningDateTo As String
        Dim strSQL As String

        strJoiningDateFrom = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("JoiningDateFrom"), "")
        strJoiningDateTo = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("JoiningDateTo"), "")

        If strJoiningDateFrom <> "" And strJoiningDateTo <> "" Then
            GetPageSpecificFilters += " AND " + "JoiningDate BETWEEN '" + strJoiningDateFrom + "' AND '" + strJoiningDateTo + "'"
        End If



    End Function
End Class
