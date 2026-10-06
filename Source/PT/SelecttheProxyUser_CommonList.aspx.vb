'Added by SantoshK on 20th March 2006 (Proxy Timesheet)  - IssueID 2888
Imports CommonEngines.General.cEventHandlers
Public Class SelecttheProxyUser_CommonList
    Inherits CommonList
    Protected strFromWhere As String = ""


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

        Dim cObjSQL As CommonEngine.CommonList.cCLSQL
        cObjSQL = InitCLSQL()

        InitializeComponent()
    End Sub
    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)

        ''Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 
        Dim strUserID As String = Session("intUserID").ToString()
        ''End Of Added By Vidya Jadhav ON 20/04/2017 For Unauthenticated user can view this page. 

        'Commented by ShraddhaM on Date 14 July,2006 for WhizibleSEM Issue ID.4168
        'Handles MyBase.Load
        MyBase.strListPage = "SelecttheProxyUser_CommonList.aspx"
        MyBase.strFormPage = "ProxyUserMapping_CommonPage.aspx"
        'Put user code to initialize the page here
        strFromWhere = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("FromWhere"), ""), String)

        If strFromWhere = "" Then
            strFromWhere = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("FromWhere"), ""), String)
        End If
        MyBase.Page_Load(sender, e)
    End Sub
#End Region


    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function

    Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
        'CommonFunctions.General.WriteHTML("<script language='javascript'>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("function Employee_OnClick(EmployeeID,EmpName)" + vbCrLf)
        'CommonFunctions.General.WriteHTML("{" + vbCrLf)
        'CommonFunctions.General.WriteHTML("var str,intPer;" + vbCrLf)
        'CommonFunctions.General.WriteHTML("var strEmpName = EmpName;" + vbCrLf)

        ''Modified by nitinvs on 10 Aug 2007 for WhizibleSEM 7 
        '' if filter is appliend the FromWhere need to be read from form
        'CommonFunctions.General.WriteHTML("if('" + CType(HttpContext.Current.Request.QueryString("FromWhere"), String) + "'=='Proxy')" + vbCrLf)
        'CommonFunctions.General.WriteHTML("{" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("alert(EmployeeID);" + vbCrLf)

        ''Modified by ShraddhaM on Date 08 June,2006 for WhizibleSEM Issue ID.4168

        'CommonFunctions.General.WriteHTML("GetParentObjectReference('frmCommonPage','NonDatabase1').value=strEmpName;" + vbCrLf)
        'CommonFunctions.General.WriteHTML("GetParentObjectReference('frmCommonPage','txtHidEmployee').value=EmployeeID;" + vbCrLf)
        'CommonFunctions.General.WriteHTML("GetParentObjectReference('frmCommonPage','ProxyID').value=EmployeeID;" + vbCrLf)
        ''Ended by ShraddhaM on Date 08 June,2006 for WhizibleSEM Issue ID.4168

        ''CommonFunctions.General.WriteHTML("alert('IB');" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("alert(EmployeeID);" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("alert(strEmpName);" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("}" + vbCrLf)

        'CommonFunctions.General.WriteHTML("}" + vbCrLf)
        'CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
        'CommonFunctions.General.WriteHTML("}" + vbCrLf)
        'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
    End Function

    Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If Args.LinkName.ToUpper = "ADD" Then
            Cancel = True
        End If
        If Args.LinkName.ToUpper = "DELETE" Then
            Cancel = True
        End If
        If Args.LinkName.ToUpper = "SELECT ALL" Then
            Cancel = True
        End If
        If Args.ClientSideFunctionName.ToUpper = "CLOSE_ONCLICK" Then
            Args.ToBeInsertedInFunction = "window.close(); return;"
        End If
    End Sub
    Protected Overrides Function InitPlotGrid() As CommonEngine.CommonList.cPlotGrid
        Return New cSelecttheProxyUser_CommonListPlotGrid(MyBase.m_objGlobal)
    End Function
    Protected Overrides Function InitCLSQL() As CommonEngine.CommonList.cCLSQL
        Return New cSelecttheProxyUser_CommonListSQL(MyBase.m_objGlobal)
    End Function
End Class
Public Class cSelecttheProxyUser_CommonListPlotGrid
    Inherits CommonEngine.CommonList.cPlotGrid

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub

    Protected Overrides Sub Initialize_Grid(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_InitializeGrid, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strid As String
        Dim strUniqueID As String
        If HttpContext.Current.Request.QueryString("Dept") Is Nothing Then
            strid = HttpContext.Current.Request.Form("txtDeptID")
        Else
            strid = HttpContext.Current.Request.QueryString("Dept")
        End If
        If HttpContext.Current.Request.QueryString("Unique") Is Nothing Then
            strUniqueID = HttpContext.Current.Request.Form("txtUniqueID")
        Else
            strUniqueID = HttpContext.Current.Request.QueryString("Unique")
        End If
        Args.ToBeInserted = "<Input  type='hidden'  name='txtDeptID' id='txtDeptID' class='clsTextBox' style='' style='text-align:Left' Value='" + strid + "'><Input  type='hidden'  name='txtUniqueID' id='txtUniqueID' class='clsTextBox' style='' style='text-align:Left' Value='" + strUniqueID + "'>"
    End Sub

    Protected Overrides Sub Before_GridColumnHeaderTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_ColumnHeaderTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        Dim strProxyID As String
        If (Args.ColumnName.ToUpper = "DELETE") Then
            Cancel = True
        End If
    End Sub


    Protected Overrides Sub Before_GridDataRowTD_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Grid.WAF_DataRowTD, ByVal WhizGlobal As WebPages.Template.IGlobal)
        If (Args.ColumnName.ToUpper = "DELETE") Then
            Cancel = True
        End If
        Dim strProxyID As String
        If CType(HttpContext.Current.Request.QueryString("ProxyID"), String) = "" Then
            strProxyID = "0"
        Else
            strProxyID = CType(HttpContext.Current.Request.QueryString("ProxyID"), String)
        End If

        'If Args.DataField.ToUpper = "EMPLOYEENAME" Then
        '    Cancel = True
        '    Dim strProxy As String = ""
        '    Dim strTemp As String
        '    If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EMPLOYEENAME"), ""), String) <> "" Then
        '        strProxy = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EMPLOYEENAME"), ""), String)
        '        strTemp = Replace(strProxy, "'", "\'")
        '    End If

        '    If (Not (HttpContext.Current.Request.Form("ProxyID")) Is Nothing) Then
        '        If (HttpContext.Current.Request.Form("ProxyID") = "") Then
        '            strProxyID = "0"
        '        Else
        '            strProxyID = CType(HttpContext.Current.Request.Form("ProxyID"), String)
        '        End If
        '    Else
        '        strProxyID = CType(HttpContext.Current.Request.QueryString("ProxyID"), String)
        '    End If
        '    Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='40%'><A href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + strTemp + "');"">" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String) + "</A></td>"
        '    If strProxyID <> "" Then
        '        If CType(strProxyID, Long) = _
        '            CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), Long) Then
        '            'Modified by SiddharthS on 4 Apr 2005 for IssueID 16903
        '            Args.StringToBeInserted = "<TD nowrap vAlign=top title='Title' width='20%'><A style='' href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + strTemp + "');"">" + strProxy + "</A></td>"
        '            'End modification.
        '        End If
        '    End If
        'End If
        If Args.DataField.ToUpper = "EMPLOYEENAME" Then
            Cancel = True
            Dim strProxy As String = ""
            Dim strTemp As String
            If CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String) <> "" Then
                strProxy = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String)
                strTemp = Replace(strProxy, "'", "\'")
            End If

            If (Not (HttpContext.Current.Request.Form("ProxyID")) Is Nothing) Then
                If (HttpContext.Current.Request.Form("ProxyID") = "") Then
                    strProxyID = "0"
                Else
                    strProxyID = CType(HttpContext.Current.Request.Form("ProxyID"), String)
                End If
            Else
                strProxyID = CType(HttpContext.Current.Request.QueryString("ProxyID"), String)
            End If
            Args.StringToBeInserted = "<TD  nowrap vAlign=top title='Title' width='30%'><A href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + strTemp + "');"">" + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeName"), ""), String) + "</A></td>"
            If strProxyID <> "" Then
                If CType(strProxyID, Long) = _
                    CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), Long) Then
                    'Modified by SiddharthS on 4 Apr 2005 for IssueID 16903
                    Args.StringToBeInserted = "<TD nowrap vAlign=top title='Title' width='20%'><A style='' href=""JavaScript:Employee_OnClick('" + CType(Args.DataReader("EmployeeID"), String) + "','" + strTemp + "');"">" + strProxy + "</A></td>"
                    'End modification.
                End If
            End If
        End If
        If (Not (HttpContext.Current.Request.Form("ProxyID")) Is Nothing) Then
            If (HttpContext.Current.Request.Form("ProxyID") = "") Then
                strProxyID = "0"
            Else
                strProxyID = CType(HttpContext.Current.Request.Form("ProxyID"), String)
            End If
        Else
            strProxyID = CType(HttpContext.Current.Request.QueryString("ProxyID"), String)
        End If

        If strProxyID <> "" Then
            'End Addition
            'Added By JayavantK on 21-Sep-2004
            If CType(strProxyID, Long) = _
                CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), "0"), Long) Then
                'Args.TDStyle = "style='color=blue'"
            End If
        End If
    End Sub
End Class

Public Class cSelecttheProxyUser_CommonListSQL
    Inherits CommonEngine.CommonList.cCLSQL

    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
    Protected Overrides Function GetPageSpecificFilters(ByVal objGlobal As WebPages.Template.IGlobal) As String
        GetPageSpecificFilters = ""
        Dim strDepartmentID As String
        Dim strUniqueID As String
        'Added by MonikaI on 12-Sep-2006 IssueID : 6174
        If HttpContext.Current.Request.QueryString("Mode") = "Edit" Then
            'End by MonikaI
            If HttpContext.Current.Request.QueryString("Dept") Is Nothing Then
                strDepartmentID = HttpContext.Current.Request.Form("txtDeptID")
            Else
                strDepartmentID = HttpContext.Current.Request.QueryString("Dept")
            End If
            If HttpContext.Current.Request.QueryString("Unique") Is Nothing Then
                strUniqueID = HttpContext.Current.Request.Form("txtUniqueID")
            Else
                strUniqueID = HttpContext.Current.Request.QueryString("Unique")
            End If
            Dim temp As String
            If strUniqueID <> "" Then
                'Commented and added by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query
                'temp = CType(CommonFunction.Data.GetDataScalar("SELECT TOP 1 DepartmentID FROM tbl_PM_Employee WHERE EmployeeID IN(SELECT OnSiteResourceID FROM tbl_CNF_ProxyUser_Mapping_Detail WHERE UniqueID=" + strUniqueID + ")", True), String
                temp = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_ProxyUser_Mapping_Detail " + strUniqueID, True), String)
                'End of addition by Tejal Deshmukh on 05-Aug-2016 To Remove Inline Query


            End If
            If temp <> "" Then
                If strDepartmentID <> "" Then
                    'Commented By Vivek On 7 Nov 2005 For SCS
                    'Purpose - Commenting this statement after requirement changes 
                    ' GetPageSpecificFilters += " AND DepartmentID=" + strDepartmentID
                End If
            End If
        End If

    End Function
End Class
'Addition End by SantoshK on 20th March 2006
