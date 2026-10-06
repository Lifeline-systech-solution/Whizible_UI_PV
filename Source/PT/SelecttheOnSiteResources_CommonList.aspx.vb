
'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888*/
Imports CommonEngines.General.cEventHandlers
Public Class SelecttheOnSiteResources_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        Dim cObjGrid As CommonEngine.CommonList.cPlotGrid
        cObjGrid = InitPlotGrid()

        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "SelecttheOnSiteResources_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
#End Region


    Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        Dim strSQL As String
        Dim arrComma As Char() = {","c}
        Dim strEmployeeList As String

        strEmployeeList = HttpContext.Current.Request.Form("txtHidEmpList")
        strEmployeeList += "," + HttpContext.Current.Request.Form("chkDelete")
        strEmployeeList = "," + strEmployeeList + ","

        Dim strChecklistSectionList As String() = strEmployeeList.Split(arrComma)
        Dim strSectionID As String
        For Each strSectionID In strChecklistSectionList
            If strSectionID <> "" Then
                strSQL = "usp_Del_tbl_CNF_ProxyUser_Mapping_Detail " + strSectionID + "," + HttpContext.Current.Request.Form("txtUniqueID")
                CommonFunction.Data.InsertOrUpdateData(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
            End If
        Next
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    End Function

    Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        AfterDelete = "var opnerpath=window.opener.location;" + vbCrLf
        'AfterDelete += "alert(opnerpath);" + vbCrLf
        'Code modified by vidyaJ - issueID - 6197 - Security patch changes
        Dim strtoken As String
        strtoken = CommonFunctions.Security.Token.GetToken(HttpContext.Current.Request.Form("txtUniqueID") + CType(HttpContext.Current.Session("intUserID"), String) + "0" + "3604")

        AfterDelete += "var opnerpathttmp=opnerpath+""&UniqueID=" + HttpContext.Current.Request.QueryString("UniqueID") + """;" + vbCrLf
        AfterDelete += "var opnerpathttmp=""ProxyUserMapping_CommonPage.aspx?PKToken=" + strtoken + "&MasterTagID=3604&FromWhere=SM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&UniqueID_PK=" + HttpContext.Current.Request.Form("txtUniqueID") + """;" + vbCrLf
        AfterDelete += "window.opener.location=opnerpathttmp;" + vbCrLf

        'AfterDelete += " refreshParent('frmCommonPage','CommonPage.aspx','CommonPage.aspx?FocusOn=SUBTAG',true);"

        AfterDelete += "window.close();" + vbCrLf
        strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.ON_LOAD.ToString
    End Function
    Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        strActionCode = ReturnCodes.DO_NOTHING.ToString
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "ADD" Then
            Cancel = True
        End If
        If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
            Args.ToBeInsertedInFunction = "window.close(); return;"
        End If
        If Args.LinkName.ToUpper = "DELETE" Then
            Args.LinkName = "Save"
            Dim strDeptID As String = HttpContext.Current.Request.QueryString("DepartmentID")
            Dim strUniqueID As String = HttpContext.Current.Request.QueryString("UniqueID")
            'Added By Dhanashri S on 2nd Nov 2015 Purpose::QA issue fixing
            Args.ToBeInsertedInFunction += "var objfrm = GetFormReference('frmCommonList')" & vbCrLf
            'End Of Addition By Dhanashri S on 2nd Nov 2015 Purpose::QA issue fixing
            Args.ToBeInsertedInFunction += "objfrm.action=""SelecttheOnSiteResources_CommonList.aspx?DepartmentID=" + strDeptID + "&Operation=DELETE&MasterTagID=3605&FromWhere=&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&UniqueID=" + strUniqueID + """;" + vbCrLf
            Args.ToBeInsertedInFunction += "objfrm.submit();" & vbCrLf
            Args.ToBeInsertedInFunction += "return;" & vbCrLf
        End If
    End Sub

    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cSelecttheOnSiteResources_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
End Class
Public Class cSelecttheOnSiteResources_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strEmployeeList As String
        strEmployeeList = HttpContext.Current.Request.Form("txtHidEmpList")
        strEmployeeList += "," + HttpContext.Current.Request.Form("chkDelete")
        Dim uniqueid As String
        If HttpContext.Current.Request.QueryString("UniqueID") Is Nothing Then
            uniqueid = HttpContext.Current.Request.Form("txtUniqueID")
        Else
            uniqueid = HttpContext.Current.Request.QueryString("UniqueID")
        End If
        Dim str As String = "<Input  type='hidden'  name='txtUniqueID' id='txtUniqueID' class='clsTextBox' style='' style='text-align:Left' Value='" + uniqueid + "'>"
        Args.ToBeInserted = str + "<Input  type='hidden'  name='txtHidEmpList' id='txtHidEmpList' class='clsTextBox' style='' style='text-align:Left' Value='" + strEmployeeList + "'>"
    End Sub

    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Select Case Args.DataField.ToUpper
            Case "EMPLOYEENAME"
                Args.EnableLink = False
        End Select

        If (Args.ColumnName.ToUpper = "DELETE") Then

            Dim strEmployeeList As String

            strEmployeeList = HttpContext.Current.Request.Form("txtHidEmpList")
            strEmployeeList += "," + HttpContext.Current.Request.Form("chkDelete")
            strEmployeeList = "," + strEmployeeList + ","

            If InStr(strEmployeeList, "," + CType(Args.DataReader("EmployeeID"), String) + ",") > 0 Then
                Args.IsSelected = True
                'Args.IgnoreActualValue = True
            End If

        End If
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If (Args.ColumnName.ToUpper = "DELETE") Then
            Args.ColumnName = "Select"
        End If
    End Sub
End Class
'Addition End by SantoshK on 20th March 2006