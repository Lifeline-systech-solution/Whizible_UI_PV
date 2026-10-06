Imports CommonEngines.General.cEventHandlers

Public Class EmployeeAccess_CommonList
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)

        If Not HttpContext.Current.Request.QueryString("Action") Is Nothing Then
            If HttpContext.Current.Request.QueryString("Action").ToUpper = "SAVE" Then
                SaveLicences()
            End If
        End If

        MyBase.strListPage = "EmployeeAccess_CommonList.aspx"
        MyBase.strFormPage = "EmployeeAccess_CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New EmployeeAccess_cPlotGrid(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)
        Dim strRemainingLicences As String = ""
        Dim strShortName As String = ""

        If Not HttpContext.Current.Request.QueryString("RemainingLicences") Is Nothing Then
            strRemainingLicences = HttpContext.Current.Request.QueryString("RemainingLicences")
        Else
            strRemainingLicences = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("RemainingLicences"), "")
        End If

        If Not HttpContext.Current.Request.QueryString("ShortName") Is Nothing Then
            strShortName = HttpContext.Current.Request.QueryString("ShortName")
        Else
            strShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ShortName"), "")
        End If

        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("ShortName", "ShortName", , , , strShortName, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("RemainingLicences", "RemainingLicences", , , , strRemainingLicences, , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("AllLogins", "AllLogins", , , , "", , , , , , True, , True))
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("SelectedLogins", "SelectedLogins", , , , "", , , , , , True, , True))

        If Not HttpContext.Current.Request.QueryString("Action") Is Nothing Then
            If HttpContext.Current.Request.QueryString("Action").ToUpper = "SAVE" Then
                CommonFunction.General.WriteHTML("<script language=javascript> " + vbCrLf)
                CommonFunction.General.WriteHTML("RefreshWebFormDesigner();" + vbCrLf)
                CommonFunction.General.WriteHTML("</script>" + vbCrLf)
            End If
        End If

    End Sub

    Private Function SaveLicences()
        Dim strAllLogins As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("AllLogins"), "")
        Dim strSelectedLogins As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkAccess"), "")
        Dim strShortName As String = ""
        Dim strQuery As String = ""
        If Not HttpContext.Current.Request.QueryString("ShortName") Is Nothing Then
            strShortName = HttpContext.Current.Request.QueryString("ShortName")
        Else
            strShortName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ShortName"), "")
        End If

        If (strSelectedLogins <> "" And strAllLogins <> "") Then
            strSelectedLogins = strSelectedLogins + ","
            strAllLogins = "," + strAllLogins
        End If

        strQuery = "usp_ins_upd_tbl_PM_Login_AccessibleModules_Employee '" & strShortName & "','" & strAllLogins & "','" & strSelectedLogins & "'"
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        'CommonFunction.General.WriteHTML("<script language=javascript> " + vbCrLf)
        'CommonFunction.General.WriteHTML("RefreshWebFormDesigner();" + vbCrLf)
        ''CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
        'CommonFunction.General.WriteHTML("</script>" + vbCrLf)

        Return ""
    End Function

End Class

Public Class EmployeeAccess_cPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid
    Dim intSelectedCount As Integer = 0

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.DataField.ToUpper = "ISACTIVE" Then
            Cancel = True
            Args.StringToBeInserted = "<TD align=center>" + CommonFunction.HTMLControls.DrawCheckBox("chkAccess", "chkAccess", , Args.DataReader("IsActive"), Args.DataReader("LoginID"), , , True) + "</TD>"
            If Args.DataReader("IsActive") Then
                intSelectedCount += 1
            End If
        End If
    End Sub
    Protected Overrides Sub After_Grid_Print(ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("SelectedCount", "SelectedCount", , , , intSelectedCount, , , , , , True, , True))
    End Sub
End Class