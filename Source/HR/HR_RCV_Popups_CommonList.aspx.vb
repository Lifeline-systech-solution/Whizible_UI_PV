Public Class HR_RCV_Popups_CommonList
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
    Private strEmployeeID As String
    Private Const APP_TAG_PROJECTALLOCATION As Long = 3902
    Private Const APP_TAG_LEAVEDETAILS As Long = 3906
    Private Const APP_TAG_SKILLDETAILS As Long = 3910

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        MyBase.strListPage = "HR_RCV_Popups_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"


        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New c_HR_RCV_Popups_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        If MyBase.m_objGlobal.ParentTagID = 0 Then  'Main Tag
            Select Case MyBase.m_objGlobal.TagID

                Case APP_TAG_PROJECTALLOCATION, APP_TAG_LEAVEDETAILS, APP_TAG_SKILLDETAILS
                    Dim strEmployeeName As String
                    Dim strPageCaption As String
                    Dim strUserName As String
                    Dim strRole As String
                    Dim dr As IDataReader

                    Dim strQuery As String

                    strEmployeeID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), "0"), String)

                    If Request.Form("hidPageCaption") Is Nothing OrElse Request.Form("hidPageCaption") = "" Then
                        strQuery = "usp_Sel_tbl_PM_Employee_ProjectEmployeeInfo " & strEmployeeID
                        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                        If dr.Read Then
                            strEmployeeName = dr("EmployeeName").ToString
                            strUserName = dr("UserName").ToString
                            strRole = dr("RoleDescription").ToString
                        End If
                        CommonFunction.Data.DisposeDataReader(dr)
                        strPageCaption = "Resource" + " : " + strUserName + " - " + strEmployeeName + "[" + strRole + "]"
                    End If


                    If strPageCaption Is Nothing Or strPageCaption = "" Then
                        strPageCaption = Request.Form("hidPageCaption")
                    End If

                    'HiddenControl for strPageCaption
                    CommonFunctions.General.WriteHTML("<Input Type=Hidden name=hidPageCaption id=hidPageCaption value='" + strPageCaption + "' >")

                    Args.RightPageCaption = strPageCaption
            End Select
        End If

      
    End Sub
    'Addition done by SuchitraP on 22-Jan-2007 to remove filter legend
    Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)
        If MyBase.m_objGlobal.ParentTagID = 0 Then  'Main Tag
            Select Case MyBase.m_objGlobal.TagID
                Case APP_TAG_PROJECTALLOCATION, APP_TAG_LEAVEDETAILS, APP_TAG_SKILLDETAILS
                    Args.HTMLLegend = ""
                    Cancel = True
            End Select
        End If
       
    End Sub
    'End of addition by SuchitraP

    Protected Overrides Sub Before_PlotRelatedDataGrid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataGrid, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")
        If MyBase.m_objGlobal.ParentTagID = 0 Then  'Main Tag
            Select Case MyBase.m_objGlobal.TagID
                Case APP_TAG_LEAVEDETAILS
                    Args.GridSQL = "usp_Sel_FinincialMonthwise_LeaveCount " & strEmployeeID
            End Select
        End If
    End Sub
End Class
Public Class c_HR_RCV_Popups_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Private Const APP_TAG_PROJECTALLOCATION As Long = 3902
    Private Const APP_TAG_LEAVEDETAILS As Long = 3906
    Private Const APP_TAG_SKILLDETAILS As Long = 3910
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If WhizGlobal.ParentTagID = 0 Then  'Main Tag
            Select Case WhizGlobal.TagID
                Case APP_TAG_LEAVEDETAILS
                    Dim strLeaveTypeID As String
                    Dim strQuery As String
                    Dim strEmployeeID As String
                    Dim fltLeaveCount As Double

                    If Args.ColumnName.ToUpper() = "LEAVES TAKEN IN FINANCIAL YEAR" Then
                        strLeaveTypeID = CType(Args.DataReader("LeaveTypeID"), String)
                        strEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID")

                        strQuery = "usp_Sel_tbl_PM_GetLeaveCount_LeaveTypeWise NULL,NULL," & strEmployeeID & "," & strLeaveTypeID
                        fltLeaveCount = CType(CommonFunctions.Data.GetDataScalar(strQuery, True), Double)

                        Cancel = True
                        Args.StringToBeInserted = "<TD align='right'>" + fltLeaveCount.ToString() + "</TD>"

                    End If
            End Select
        End If

    End Sub
End Class
