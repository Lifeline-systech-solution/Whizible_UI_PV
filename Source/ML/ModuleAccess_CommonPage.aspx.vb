Imports CommonEngines.General.cEventHandlers

Public Class cModuleAccess_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cModuleAccess_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

  
End Class
Public Class cModuleAccess_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cModuleAccess_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls

    Private strXMLPath As String = HttpContext.Current.Server.MapPath("../GENERAL/").ToString + "WhizModules.xml"
    Protected strModule() As String = {}
    Protected strLicences() As String = {}

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        InitArray()
    End Sub

    Private Sub InitArray()
        Dim dXMLSet As New DataSet()
        Dim dXMLRdr As DataTableReader
        Dim i As Integer = 0
        Try
            If CommonFunctions.FileDirectory.IsFileExists(strXMLPath) Then
                dXMLSet.ReadXml(strXMLPath)
                dXMLRdr = dXMLSet.CreateDataReader()
                While dXMLRdr.Read()
                    ReDim Preserve strModule(UBound(strModule) + 1)
                    ReDim Preserve strLicences(UBound(strLicences) + 1)
                    strLicences(i) = MLCommonFunction.ML_CommonFunction.Decrypt(dXMLRdr("Licences_Text").ToString())
                    strModule(i) = strLicences(i).Substring(strLicences(i).IndexOf("/") + 1, strLicences(i).LastIndexOf("/") - (strLicences(i).IndexOf("/") + 1))
                    strLicences(i) = strLicences(i).Substring(strLicences(i).LastIndexOf("/") + 1)
                    If strLicences(i) = "" Then
                        strLicences(i) = 0
                    End If
                    i = i + 1
                End While
            End If
        Catch ex As Exception
            HttpContext.Current.Response.Write(ex.Message)
        Finally
        End Try
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If WhizGlobal.ParentTagID = 0 Then

            If Args.ControlName.ToUpper = "ISSUEDLICENCES" Then
                Args.IgnoreActualValue = True
                Args.NewValue = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT COUNT(LoginID) FROM tbl_PM_Login_AccessibleModules WHERE ModuleID = " + Args.PrimaryKeyValue + " AND IsActive = 1", True), "0")
            End If
            If Args.ControlName.ToUpper = "AVAILABLELICENCES" Then
                Dim intCount As Integer = 0
                For intCount = 0 To strLicences.Length - 1
                    If Args.PrimaryKeyValue = strModule(intCount) Then
                        Args.IgnoreActualValue = True
                        Args.NewValue = strLicences(intCount)
                    End If
                Next
            End If
            If Args.ControlName.ToUpper = "REMAININGLICENCES" Then

                'Dim i As Integer = 0
                'Dim intRemLiv As Integer
                'For i = 0 To strModule.Length - 1
                '    If Args.DataReader("ModuleTagId") = strModule(i) Then
                '        Args.ReplacementValue = strLicences(i) - CommonFunction.Data.CheckIsDBNull(Args.DataReader("IssuedLicences"), 0)
                '    End If
                'Next
                Dim intCount As Integer = 0
                For intCount = 0 To strLicences.Length - 1
                    If Args.PrimaryKeyValue = strModule(intCount) Then
                        Args.IgnoreActualValue = True
                        Args.NewValue = strLicences(intCount) - CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT COUNT(LoginID) FROM tbl_PM_Login_AccessibleModules WHERE ModuleID = " + Args.PrimaryKeyValue + " AND IsActive = 1", True), "0")
                    End If
                Next
                'Args.StringToBeInserted = "<TD align=center><a href=""Javascript:EmployeeAccess(" + intRemLiv.ToString + ",'" + Args.DataReader("Shortname") + "')"">Employee Access</TD>"
            End If
        End If

    End Sub
End Class


Public Class ModuleAccess_CommonPage
    Inherits CommonPage
    Protected m_strIsAddValid As String = "0"

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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "ModuleAccess_CommonList.aspx"
        MyBase.strFormPage = "ModuleAccess_CommonPage.aspx"

        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cModuleAccess_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cModuleAccess_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cModuleAccess_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cModuleAccess_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
        Return New cModuleAccess_CommonPageSubTagCLSQL(WhizGlobal)
    End Function


    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim m_SubTagID As String
        Dim strSQL As String
        Dim intIssuedLicences As Integer = 0
        Dim strModuleID As String = ""
        Dim intAvailableLicences As Integer = 0
        m_SubTagID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("SubTagID"), "")

        If m_SubTagID = "20042" Then
            strModuleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request("ModuleTagId"), "0")
            intIssuedLicences = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT COUNT(LoginID) FROM tbl_PM_Login_AccessibleModules WHERE ModuleID = " + strModuleID + " AND IsActive = 1", True), "0")

            CommonFunction.General.WriteHTML("<script>")
            CommonFunction.General.WriteHTML("window.document.forms['frmCommonPage'].IssuedLicences.value=" & intIssuedLicences & ";")
            CommonFunction.General.WriteHTML("</script>")
        End If
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.DO_NOTHING.ToString
    End Function

End Class
