#Region "Imports"
Imports WebPages.Template
Imports CommonFunctions
Imports CommonFunctions.HTMLControls
#End Region

Public Class CRM_AccessList
    Inherits WebPages.Template.WhizTemplate

    Protected m_strAction As String = ""
    Protected m_strSortBy As String = ""
    Protected m_strSortOrder As String = ""
    Protected m_strAlphabet As String = "-1"
    Protected m_strFromWhere As String = ""
    Protected m_intRefresh As Integer = 0
    Private lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Protected lngEmployeeAccessID As Long
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objSectionTitle As New WebPage.Templates.SectionTitle
    Private strEmployee As String
    Private strEmailID As String
    Protected strMenu As String
    'Private WithEvents m_objGrid As New WebPages.Template.GenericGrid

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

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ''commented by nilesh g on 31/12/2015 for Security
        If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
            Response.Write(vbCrLf + "<script>")
            Response.Write(vbCrLf + "		if (window.opener == null)")
            Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
            If strRedirectToPage.Trim = "" Then
                Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
            Else
                Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
            End If
            Response.Write(vbCrLf + "</script>")
        End If
        ''end of commented by nilesh g on 31/12/2015 for Security
        Call Initialize()
        If Not Request.QueryString("EmployeeAccessID") Is Nothing Then
            lngEmployeeAccessID = CType(Request.QueryString("EmployeeAccessID"), Long)
        End If
    End Sub
    Public Sub New()
        ''  MyBase.ApplySecurity()
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
    Private Sub Initialize()
        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

    End Sub
    Protected Sub WriteGrid()
        '=====================================================================
        ' Procedure Name        : WriteGrid()	
        ' Issue ID              : 1936 (Help desk enhancements)
        ' Purpose               : 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Harshada Deshpande
        ' Created               : Feb 16,2006
        ' Revisions             :
        '=====================================================================

        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrCSFunction() As String = {"CloseOnClick()", "Help_OnClick('CRM_ACCESSLIST')"}
        Dim strMenu, strLegend As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        Response.Write(strMenu)
        MyBase.InitializeResources("AppResources.CRM_AccessList", "AppResources")
        Call writePage()
        With Response
            Call WriteGridDept()
            Call WriteGridCust()
            Dim strSQLOnBehalfOfCustomer As String
            ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQLOnBehalfOfCustomer = "SELECT CRMID FROM tbl_CRM_Function_CRMs WHERE CRMID =" & lngEmployeeID
            strSQLOnBehalfOfCustomer = "usp_sel_tbl_CRM_Function_CRMs_CRMID " & lngEmployeeID
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            Dim drOnBehalfOfCustomer As IDataReader = CommonFunction.Data.GetDataReader(strSQLOnBehalfOfCustomer, m_blnUseSQL)
            If drOnBehalfOfCustomer.Read Then
                Call WriteGridBehalfOfCustomer()
            End If
            CommonFunctions.Data.DisposeDataReader(drOnBehalfOfCustomer)
            MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
            .Write(strMenu)
        End With

    End Sub
    Private Sub writePage()
        '=====================================================================
        ' Procedure Name        : writePage()	
        ' Issue ID              : 1936 (Help desk enhancements)
        ' Purpose               : 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Harshada Deshpande
        ' Created               : Feb 16,2006
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim drEmployee As IDataReader
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT EmployeeID ,EmployeeName , EmailID FROM v_tbl_CRM_EmployeeAccess Where EmployeeAccessID = " & lngEmployeeAccessID
        strSQL = "Exec usp_sel_v_tbl_CRM_EmployeeAccess " & lngEmployeeAccessID
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        drEmployee = CommonFunction.Data.GetDataReader(strSQL, m_blnUseSQL)
        If drEmployee.Read Then
            If Trim(drEmployee("EmployeeName").ToString & "") <> "" Then
                strEmployee = drEmployee("EmployeeName").ToString & ""
            End If
            If Trim(drEmployee("EmailID").ToString & "") <> "" Then
                strEmailID = drEmployee("EmailID").ToString & ""
            End If
            If Trim(drEmployee("EmployeeID").ToString & "") <> "" Then
                lngEmployeeID = CType(drEmployee("EmployeeID").ToString, Long)
            End If
        End If
        CommonFunctions.General.WriteHTML("<BR>")
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Helpdesk Access Configuration Details", , , True))
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION"), "Resource : " + strEmployee, , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'With Response
        '    .Write("<table width='100%' class=clsTable cellpadding=0 cellspacing=0><tr class=clsTREven>")
        '    .Write("<TR class=clsTROdd>")
        '    .Write("<TD align=right>Employee</TD>")
        '    .Write("<TD>")
        '    CommonFunctions.HTMLControls.DrawTextBox("txtEmployeeName", "txtEmployeeName", , 300, 500, strEmployee, , , True, , , , , , True)
        '    .Write("</td>")
        '    .Write("</tr>")
        '    .Write("<TR class=clsTROdd>")
        '    .Write("<TD align=right>Email Address</TD>")
        '    .Write("<TD>")
        '    CommonFunctions.HTMLControls.DrawTextBox("txtEmailID", "txtEmailID", , 300, 500, strEmailID, , , True, , , , , , True)
        '    .Write("</td>")
        '    .Write("</tr>")
        '    .Write("</table>")
        'End With
        CommonFunctions.Data.DisposeDataReader(drEmployee)
    End Sub
    Private Sub WriteGridCust()
        '=====================================================================
        ' Procedure Name        : WriteGridCust()	
        ' Issue ID              : 1936 (Help desk enhancements)
        ' Purpose               : 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Harshada Deshpande
        ' Created               : Feb 16,2006
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strPaging As String
        Dim strFromWhere As String
        Dim arrActualCols() As String = {"Customer"}
        Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("CAP_ACCESSIBLE_CUSTS")}

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15

        Dim arrRowLink() As String = {""}


        strSQL = "usp_sel_employee_Accessible_DepartmentsCustomer " & lngEmployeeAccessID & " , 1"
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            ' .DIVHeight = 100
            .DIVID = "divListCust"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .DIVStyle = "overflow:auto; width:100%;"
            .NoOfDataColumns = 1
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DrawGrid()
        End With
        m_objGrid = Nothing

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168


        General.WriteHTML("<TABLE  Width='99.9%' cellspacing=0 class=clsTable>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class=clsTRPageHeader><TD align=Left> <b> Note:")
        General.WriteHTML("</b>")
        General.WriteHTML(MyBase.GetResourceString("CAP_NOTE_CUST"))
        General.WriteHTML("</TD></TR></TABLE>")
        Response.Write("<BR>")
    End Sub
    Private Sub WriteGridBehalfOfCustomer()
        '=====================================================================
        ' Procedure Name        : WriteGridBehalfOfCustomer()	
        ' Issue ID              : 1936 (Help desk enhancements)
        ' Purpose               : 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Harshada Deshpande
        ' Created               : Feb 16,2006
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim strPaging As String
        Dim strFromWhere As String
        Dim arrActualCols() As String = {"BhCustomers"}
        Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("CAP_ACCESSIBLE_ONBEHALFOFCUST")}

        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        Dim arrRowLink() As String = {""}


        strSQL = "usp_sel_employee_Accessible_DepartmentsCustomer " & lngEmployeeAccessID & " , 2"
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            ' .DIVHeight = 300
            .DIVID = "divListBHCustomer"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .DIVStyle = "overflow:auto; width:100%;"
            .NoOfDataColumns = 1
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DrawGrid()
        End With
        m_objGrid = Nothing

        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<TABLE  Width='99.9%' cellspacing=0 class=clsTable>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class=clsTRPageHeader><TD align=Left> <b> Note:")
        General.WriteHTML("</b>")
        General.WriteHTML(MyBase.GetResourceString("CAP_NOTE_ONBEHALFOFCUST"))
        General.WriteHTML("</TD></TR></TABLE>")
        Response.Write("<BR>")

    End Sub
    Private Sub WriteGridDept()
        '=====================================================================
        ' Procedure Name        : WriteGridDept()	
        ' Issue ID              : 1936 (Help desk enhancements)
        ' Purpose               : 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Harshada Deshpande
        ' Created               : Feb 16,2006
        ' Revisions             :
        '=====================================================================

        Dim strSQL As String
        Dim strPaging As String
        Dim strFromWhere As String
        Dim arrActualCols() As String = {"Department"}
        Dim arrUserFriendlyCols() As String = {MyBase.GetResourceString("CAP_ACCESSIBLE_DEPTS")}
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        'Dim arrIgnoreHTMLEncode() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:05/10/15
        Dim arrRowLink() As String = {""}




        strSQL = "usp_sel_employee_Accessible_DepartmentsCustomer " & lngEmployeeAccessID & " , 0"
        ' grid
        m_objGrid = New WebPages.Template.GenericGrid
        With m_objGrid
            '.DIVHeight = 100
            .DIVID = "divListDept"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .DIVStyle = "overflow:auto; width:100%;"
            .NoOfDataColumns = 1
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .SQL = strSQL
            .UseSQL = m_blnUseSQL
            .DrawGrid()
        End With
        m_objGrid = Nothing
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TABLE  Width='99.9%' cellspacing=0 class=clsTable>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        General.WriteHTML("<TR class=clsTRPageHeader><TD align=Left> <b> Note:")
        General.WriteHTML("</b>")
        General.WriteHTML(MyBase.GetResourceString("CAP_NOTE_DEPT"))
        General.WriteHTML("</TD></TR></TABLE>")
        General.WriteHTML("<BR>")

    End Sub
#Region "events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
    End Sub
#End Region


End Class
