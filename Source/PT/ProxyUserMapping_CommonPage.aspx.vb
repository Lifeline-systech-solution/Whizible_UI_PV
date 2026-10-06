'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
Imports CommonEngines.General.cEventHandlers
Public Class cProxyUserMapping_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cProxyUserMapping_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cProxyUserMapping_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub


End Class
Public Class cProxyUserMapping_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        If Args.ControlName.ToUpper = "NONDATABASE1" Then
            Dim strSQL As String
            Dim drProxy As IDataReader
            Dim strProxyID As String
            Dim strEmployeeName As String

            'disable the control
            Args.Editable = False

            If Args.IsEditMode Then
                ' If CType(Args.PrimaryKeyValue, String) = "" Then
                'strSQL = "Select ProxyID from tbl_CNF_ProxyUser_Mapping_Master Where UniqueID = " + HttpContext.Current.Request.QueryString("UniqueID_PK")
                'Else
                'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                'strSQL = "Select ProxyID from tbl_CNF_ProxyUser_Mapping_Master Where UniqueID = " + CType(Args.PrimaryKeyValue, String)
                strSQL = "usp_sel_tbl_CNF_ProxyUser_Mapping_Master_Proxy " + CType(Args.PrimaryKeyValue, String)
                'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


                'End If

                drProxy = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


                If drProxy.Read Then
                    strProxyID = CType(CommonFunction.Data.CheckIsDBNull(drProxy("ProxyID"), "0"), String)
                End If

                CommonFunction.Data.DisposeDataReader(drProxy)

                If strProxyID <> "0" Then
                    strSQL = "Select EmployeeName From tbl_PM_Employee Where EmployeeID = " + CType(strProxyID, String)
                    drProxy = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

                    If drProxy.Read Then
                        strEmployeeName = CType(CommonFunction.Data.CheckIsDBNull(drProxy("EmployeeName"), "0"), String)
                    End If
                    CommonFunction.Data.DisposeDataReader(drProxy)
                End If

                Args.IgnoreActualValue = True
                Args.NewValue = strEmployeeName

            End If
        End If
    End Sub

    Protected Overrides Sub After_PlotControl(ByVal Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertAfterControl As String = "")
        Dim temp As String = HttpContext.Current.Request("UniqueID_PK")
        Dim strDept As String = ""
        If temp <> "" Then
            'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
            'strDept = CType(CommonFunction.Data.GetDataScalar("SELECT TOP 1 DepartmentID FROM tbl_PM_Employee WHERE EmployeeID IN(SELECT OnSiteResourceID FROM tbl_CNF_ProxyUser_Mapping_Detail WHERE UniqueID=" + temp + ")", True), String)
            strDept = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_ProxyUser_Mapping_Detail " + temp + "", True), String)
            'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


        End If
        If Args.ControlName.ToUpper = "NONDATABASE1" Then
            Dim str As String = "<Input  type='hidden'  name='txtDept' id='txtDept' class='clsTextBox' style='' style='text-align:Left' Value='" + strDept + "'><Input  type='hidden'  name='txtUniqueID' id='txtUniqueID' class='clsTextBox' style='' style='text-align:Left' Value='" + temp + "'>"
            InsertAfterControl = str + "<Input  type='hidden'  name='txtHidEmployee' id='txtHidEmployee' class='clsTextBox' style='' value='17' style='text-align:Left'>&nbsp;<img Border=0 src = '../../images/dblclick.gif' id ='imgValidationRules' title = 'Select the proxy user..' height = '12px' width = '12px' onclick = 'Javascript:SelectEmployee()'>"
        End If
    End Sub
End Class


Public Class ProxyUserMapping_CommonPage
    Inherits CommonPage
#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "CommonList.aspx"
        MyBase.strFormPage = "ProxyUserMapping_CommonPage.aspx"


        MyBase.Page_Load(sender, e)



    End Sub
    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        'Put user code to initialize the page here
        Return New cProxyUserMapping_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New cProxyUserMapping_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cProxyUserMapping_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cProxyUserMapping_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL() As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New cProxyUserMapping_CommonPageSubTagCLSQL(MyBase.m_objGlobal)
    'End Function
    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim strScript As String
        Dim strMode As String

        strScript = "function SelectEmployee()"
        strScript += "{"
        strScript += "objProxyID = GetObjectReference('frmCommonPage','ProxyID');"
        strScript += "objDepID = GetObjectReference('frmCommonPage','txtDept');"
        strScript += "objUniqueID = GetObjectReference('frmCommonPage','txtUniqueID');"
        strMode = HttpContext.Current.Request.QueryString("Mode")
        'If condition added by MonikaI on 12-Sep-2006 IssueID : 6174
        If strMode = "ADD_NEW" Then
            strScript += "window.open('SelecttheProxyUser_CommonList.aspx?MasterTagID=3608&Mode=Add&FromWhere=Proxy&Unique='+ objUniqueID.value +'&Dept='+ objDepID.value +'&ProxyID=' + objProxyID.value,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');"
        Else
            strScript += "window.open('SelecttheProxyUser_CommonList.aspx?MasterTagID=3608&Mode=Edit&FromWhere=Proxy&Unique='+ objUniqueID.value +'&Dept='+ objDepID.value +'&ProxyID=' + objProxyID.value,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=' + (window.screen.width - 800)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=800,height=500');"
        End If
        'End by MonikaI
        strScript += "}"


        PageUIPreRender = strScript
        'Application standard return code
        strActionCode = ReturnCodes.ON_LOAD.ToString
    End Function

    'Public Overrides Function BeforeSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, ByRef PrimaryKey As String, Optional ByRef strActionCode As String = "", Optional ByRef RedirectToCL As Boolean = True) As String
    '    Dim strProxyUser As String = ControlsHashTable("NonDatabase1").ToString
    '    If strProxyUser = "" Then
    '        BeforeSave = "alert('\'Proxy User\' can not be left blank.');"
    '        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_SAVE.ToString
    '        RedirectToCL = False
    '    End If
    'End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.ClientSideFunctionName = "Back_OnClick" Then
            Args.ToBeInsertedInFunction = "window.location.href='ProxyUserMapping_CommonList.aspx?FromWhere=SM&MasterTagId=3604';"
            Args.ToBeInsertedInFunction += "return;"
        End If
        If Args.ClientSideFunctionName = "New_OnClick_Tab" Then
            Args.ToBeInsertedInFunction = "window.open('SelecttheOnSiteResources_CommonList.aspx?FromWhere=SM&MasterTagID=3605&UniqueID=" + CType(Args.MasterPrimaryKeyValue, String) + "','','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left=200,top=200,width=650,height=450');"
            Args.ToBeInsertedInFunction += "return;"
        End If

        If Args.ClientSideFunctionName = "Save_OnClick" Then
            Args.ToBeInsertedInFunction = "var objNonDatabase1=GetObjectReference('frmCommonPage','NonDatabase1');"
            Args.ToBeInsertedInFunction += "objNonDatabase1.disabled=false;"
            Args.ToBeInsertedInFunction += "if (objNonDatabase1.value == '')  "
            Args.ToBeInsertedInFunction += "{"
            Args.ToBeInsertedInFunction += "alert('\'Proxy User\' can not be left blank.');"
            Args.ToBeInsertedInFunction += "objNonDatabase1.disabled=true;"
            Args.ToBeInsertedInFunction += "return;}"
        End If
    End Sub

End Class
'Addition End by SantoshK on 20th March 2006