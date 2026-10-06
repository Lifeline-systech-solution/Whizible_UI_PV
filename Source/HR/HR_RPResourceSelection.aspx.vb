Public Class HR_RPResourceSelection
    Inherits WebPage.Templates.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Private WithEvents m_objGrid As WebPages.Template.AdvancedGrid
    Private BGID As String
    Private OUID As String
    Private DUID As String
    Private DTID As String
    Private RoleID As String
    Private DesignationID As String
    Private DeptID As String
    Private GradeID As String
    Private SkillID As String
    Private Exp As String
    Private ExpOperator As String
    Private CertificationID As String
    Private QualificationID As String
    Private ProjectID As String
    Protected ResourcePoolID As String
    Private PassportID As String
    Private VisaCountryID As String
    Private VisaTypeID As String
    Private Passport As Boolean
    Private WhereClause As String = ""
    Protected strResourcePoolID As String
    Private strEmployeeIDs As String
    Private strAction As String
    Private strRPEmplyeeIDs As String
    Protected IsSelected As String = "0"
    Private strUIEmployeeIDs As String
    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    Private strAppliedFilters As String = "None"

    Public Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

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
        'Put user code to initialize the page here
    End Sub
    Protected Sub WritePage()

        strResourcePoolID = CType(Request.QueryString("ResourcePoolID"), String)
        strEmployeeIDs = CType(Request.QueryString("EmployeeIDs"), String)
        strAction = CType(Request.QueryString("Action"), String)

        IsSelected = CType(Request.QueryString("IsSelected"), String)

        If IsSelected Is Nothing Or IsSelected = "" Then
            IsSelected = Request.Form("IsSelected")
        End If

        If strResourcePoolID Is Nothing Or strResourcePoolID = "" Then
            strResourcePoolID = Request.Form("hidResourcePoolID")
        End If

        If strEmployeeIDs Is Nothing Or strEmployeeIDs = "" Then
            strEmployeeIDs = Request.Form("hidEmployeeIDs")
        End If

        If Not strAction Is Nothing Or strAction <> "" Then
            If strAction.ToUpper() = "SAVE" Then
                SaveRecords()
            End If
        End If

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        CommonFunctions.General.WriteHTML("<input type=hidden name='hidResourcePoolID' id='hidResourcePoolID' value=" + strResourcePoolID + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidEmployeeIDs' id='hidEmployeeIDs' value=" + strEmployeeIDs + ">")
        CommonFunctions.General.WriteHTML("<input type=hidden name='IsSelected' value=" + IsSelected + ">")

        strRPEmplyeeIDs = CType(CommonFunctions.Data.GetDataScalar("usp_sel_ResourcePoolResources " + strResourcePoolID + ",'RES'", True), String)

        'hidResourcePoolID
        InitFilterVariables()
        writeMenu(True)
        GetWhereClause()
        DrawNumericPaging()
        GenerateFilterMenu()
        Response.Write("<br>")
        WriteGrid()
        Response.Write("<br>")
        writeMenu(False)
    End Sub
    Private Sub SaveRecords()
        Dim strQuery As String
        Dim strSessionUserName As String
        strSessionUserName = CType(HttpContext.Current.Session("strUserName"), String).Replace("'", "''")

        strQuery = "usp_Ins_tbl_PM_ResourcePool_Resources " + strResourcePoolID + ",'" + strEmployeeIDs + "','" + strSessionUserName + "','" + CType(Request.Form("hidUIEmployeeIDs"), String) + "'"

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

    End Sub
    Private Sub InitFilterVariables()

        BGID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboBG"), ""), String)
        OUID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboOU"), ""), String)
        DUID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboDU"), ""), String)
        DTID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboDT"), ""), String)
        RoleID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboRole"), ""), String)
        DesignationID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboDesignation"), ""), String)
        DeptID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboDepartment"), ""), String)
        GradeID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboGrade"), ""), String)
        SkillID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboSkill"), ""), String)
        Exp = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboExp"), ""), String)
        ExpOperator = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboCompareFactor"), ""), String)
        CertificationID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboCertification"), ""), String)
        QualificationID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboQualification"), ""), String)
        ProjectID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboProject"), ""), String)
        ResourcePoolID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboResourcePool"), ""), String)
        VisaCountryID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboVisaCountry"), ""), String)
        VisaTypeID = CType(CommonFunctions.General.CheckIsNothing(Request.Form("cboVisaType"), ""), String)

        Passport = False

        If Not Request.Form("chkhasPassport") Is Nothing Then
            If Request.Form("chkhasPassport") = "1" Then
                Passport = True
            End If
        End If

    End Sub
    Private Sub writeMenu(ByVal isUp As Boolean)
        Dim ShowLink As String
        Dim ShowLinkToolTip As String
        Dim ShowLinkFunction As String
        Dim strImage As String

        If IsSelected = "0" Then
            ShowLink = "Show Selected Resources"
            ShowLinkToolTip = "Show Selected Resources"
            ShowLinkFunction = "ShowSelected_onClick()"
        Else
            ShowLink = "Show All Resources"
            ShowLinkToolTip = "Show All Resources"
            ShowLinkFunction = "ShowAll_onClick()"
        End If

        If isUp Then
            strImage = "<img id='imgFilterUp' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'"
        Else
            strImage = "<img id='imgFilterDown' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'"
        End If

        'Dim arrMenu() As String = {strImage, ShowLink, "Select All", "Clear All", "Save", "Save and Close", "Close", "?"}
        'Dim arrMenuToolTip() As String = {"Filters", ShowLinkToolTip, "Select All", "Clear All", "Save", "Save and Close", "Close", "Help"}
        'Dim arrCSFunction() As String = {"Filters_OnClick('1')", ShowLinkFunction, "SelectAll_OnClick('frmHR_RPResourceSelection','chkSelect')", "ClearAll_OnClick('frmHR_RPResourceSelection','chkSelect')", "Save_onClick()", "SaveAndClose_onClick()", "Close_OnClick()", "Help_OnClick()"}
        Dim arrMenu() As String = {strImage, ShowLink, "Select", "Close", "?"}
        Dim arrMenuToolTip() As String = {"Filters", ShowLinkToolTip, "Select", "Close", "Help"}
        Dim arrCSFunction() As String = {"Filters_OnClick('1')", ShowLinkFunction, "Save_onClick()", "Close_OnClick()", "Help_OnClick()"}

        Dim objMenu As New WebPage.Templates.StaticMenu
        objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip, False)

    End Sub
    Private Sub WriteGrid()

        Dim dr As IDataReader
        Dim strSQL As String = ""
        'Modified By VarunA on 30-July-2008 RequestID-14317
        'Purpose : To have the user name of an employee
        'Dim arrUserFriendlyCols() As String = {"Resource Name", "Role", "Total Experience (Yrs)", "Experience with us (Yrs)", "Primary Skills", "Select"}
        'Dim arrActualCols() As String = {"EmployeeName", "RoleDescription", "TotalExp", "CurrentExp", "PrimarySkills", "Select"}
        Dim arrUserFriendlyCols() As String = {"Resource Name", "User Name", "Employee Code", "Role", "Total Experience (Yrs)", "Experience with us (Yrs)", "Primary Skills", "Select"}
        Dim arrActualCols() As String = {"EmployeeName", "UserName", "EmployeeCode", "RoleDescription", "TotalExp", "CurrentExp", "PrimarySkills", "Select"}
        'End By VarunA on 30-July-2008 RequestID-14317



        strSQL = "SELECT * FROM v_tbl_PM_EmployeeHistory_Skills WHERE 1 = 1 " + WhereClause
        'dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        m_objGrid = New WebPages.Template.AdvancedGrid

        CommonFunctions.General.PlotStaticHeaderStyle("divGrid")

        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        With m_objGrid

            .NoOfDataColumns = arrUserFriendlyCols.Length
            .UserFriendlyColumnArray = arrUserFriendlyCols
            .ActualColumnArray = arrActualCols
            .returnHTML = False
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode

            .SQL = strSQL
            .UseSQL = True
            .DIVID = "divGrid"
            .DIVStyle = "overflow:auto;width:100%;"
            'Commented by Yogesh J on 08/12/2015 issue id=2668
            '  .DIVHeight = 300
            'End of comment by Yogesh J on 08/12/2015 issue id=2668
            .ColNameToolTipOnEachRow = True
            .EmptyValueReplacement = "-"
            .SortBy = "EmployeeName"

            .PageSize = 20
            .CurrentPage = m_intPageNumber
            '.CheckboxCheckOnColumnArray = arrCheckboxArray
            .DrawGrid()

        End With
        CommonFunctions.General.WriteHTML("<input type=hidden name='hidUIEmployeeIDs' id='hidUIEmployeeIDs' value=" + strUIEmployeeIDs + ">")


        m_objGrid = Nothing

    End Sub

    Private Sub GetWhereClause()
        Dim strInWhereClause As String = ""
        Dim strWhereClause As String = ""

        'Main View
        If BGID <> "" Then
            strWhereClause = strWhereClause + " AND BusinessGroupID = " + BGID
        End If

        If OUID <> "" Then
            strWhereClause = strWhereClause + " AND LocationID = " + OUID
        End If

        If DUID <> "" Then
            strWhereClause = strWhereClause + " AND ResourcePoolID = " + DUID
        End If

        If DTID <> "" Then
            strWhereClause = strWhereClause + " AND GroupID = " + DTID
        End If

        If RoleID <> "" Then
            strWhereClause = strWhereClause + " AND PostID = " + RoleID
        End If
        If DesignationID <> "" Then
            strWhereClause = strWhereClause + " AND DesignationID = " + DesignationID
        End If

        If DeptID <> "" Then
            strWhereClause = strWhereClause + " AND DepartmentID = " + DeptID
        End If

        If GradeID <> "" Then
            strWhereClause = strWhereClause + " AND GradeID = " + GradeID
        End If

        If Exp <> "" And ExpOperator <> "" Then
            strWhereClause = strWhereClause + " AND TotalExp " + ExpOperator + " " + Exp
        End If

        If Passport = True Then
            strWhereClause = strWhereClause + " AND PassportNumber IS NOT NULL "
        End If



        'For Skill view
        If SkillID <> "" Then
            strInWhereClause = strInWhereClause + " AND ToolID = " + SkillID
        End If

        If ProjectID <> "" Then
            strInWhereClause = strInWhereClause + " AND ProjectID = " + ProjectID
        End If

        If CertificationID <> "" Then
            strInWhereClause = strInWhereClause + " AND CertificationID = " + CertificationID
        End If

        If QualificationID <> "" Then
            strInWhereClause = strInWhereClause + " AND QualificationID = " + QualificationID
        End If
        If ResourcePoolID <> "" Then
            strInWhereClause = strInWhereClause + " AND ResourcePoolID = " + ResourcePoolID
        End If

        If VisaTypeID <> "" Then
            strInWhereClause = strInWhereClause + " AND VisaTypeID = " + VisaTypeID
        End If

        If VisaCountryID <> "" Then
            strInWhereClause = strInWhereClause + " AND CountryID = " + VisaCountryID
        End If

        If strInWhereClause <> "" Then
            strInWhereClause = " AND EmployeeID IN(SELECT DISTINCT EmployeeID FROM v_tbl_PM_ReosurcePool_ResourceSelection_Filter WHERE 1=1 " + strInWhereClause + ")"
        End If

        WhereClause = strWhereClause + strInWhereClause

        'If show selected resource 
        If IsSelected = "1" Then
            WhereClause = WhereClause + " AND EmployeeID IN (SELECT EmployeeID FROM tbl_PM_ResourcePoolDetail WHERE ResourcePoolID = " + strResourcePoolID + ")"
        End If
    End Sub

    Private Sub GenerateFilterMenu()

        'Filter Table 
        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:0' class='clsGridTable' cellspacing='0' cellpadding='0'>")

        'CommonFunctions.General.WriteHTML("<TR class=clsTRPageCaption><TD align=right>Filter</TD><TD align=left>")
        'CommonFunctions.HTMLControls.DrawTextBox("txtFilter", "txtFilter", "clsTextBox", 600, , , , , , , , , , False, True)
        'CommonFunctions.General.WriteHTML("</TD><TD></TD><TD></TD></TR>")
        ''Commented by Nilesh G on 17/11/2015 for issue id 1983
        ''CommonFunctions.General.WriteHTML("<tr class=clsTRPageCaption><TD colspan=4><HR></TD></TR>")

        'BG combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Business Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        'To show all inactive BG
        'CommonFunctions.HTMLControls.DrawComboBox("cboBG", "select BusinessGroupID,BusinessGroup,Active FROM tbl_CNF_BusinessGroups WHERE Active = 1 ORDER BY BusinessGroup", 200, BGID, , True)
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboBG", "select BusinessGroupID,BusinessGroup,Active FROM tbl_CNF_BusinessGroups ORDER BY BusinessGroup", 200, BGID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_tbl_CNF_BusinessGroups_Active", 200, BGID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'OU combo 
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Organization Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        'To show all inactive OU
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        'CommonFunctions.HTMLControls.DrawComboBox("cboOU", "select LocationID,Location FROM tbl_PM_Location WHERE Active = 1 ORDER BY Location", 200, OUID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_tbl_PM_Location_Location", 200, OUID, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")

        'DU Combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Delivery Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        'To show all inactive DU
        'CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select ResourcePoolID, ResourcePoolName	From tbl_PM_ResourcePool WHERE Active = 1 Order By ResourcePoolName", 200, DUID, , True)
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select ResourcePoolID, ResourcePoolName	From tbl_PM_ResourcePool Order By ResourcePoolName", 200, DUID, True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_sel_tbl_PM_ResourcePool_ResourcePoolID", 200, DUID, True, True)
        CommonFunctions.General.WriteHTML("</td>")

        'DT Combo
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Delivery Team")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")
        'To show all inactive DT
        'CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Select GroupID,GroupName From tbl_PM_GroupMaster WHERE Active = 1 Order By GroupName", 200, DTID, , True)
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Select GroupID,GroupName From tbl_PM_GroupMaster Order By GroupName", 200, DTID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDT", "usp_sel_tbl_PM_GroupMaster_GroupID", 200, DTID, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")

        'Role combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Role")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left>")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, RoleID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_RoleID_tbl_PM_Role", 200, RoleID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Designation combo
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Designation")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "select DesignationID,DesignationName from tbl_PM_DesignationMaster ORDER BY DesignationName", 200, DesignationID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "usp_sel_tbl_PM_DesignationMaster_DesignationName", 200, DesignationID, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")



        'Department combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Department")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "SELECT DepartmentID,Department FROM tbl_pm_Departmentmaster ORDER BY Department", 200, DeptID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_sel_Department_tbl_pm_Departmentmaster", 200, DeptID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Grade combo
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Grade")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboGrade", "SELECT GradeID,Grade From tbl_PM_GradeMaster ORDER BY Grade", 200, GradeID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboGrade", "usp_sel_tbl_PM_GradeMaster_GradeID", 200, GradeID, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")

        'Skill combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Skill")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "select ToolID,[Description] from tbl_PM_Tools  WHERE ISSkill = 1 ORDER BY [Description]", 200, SkillID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "usp_sel_tbl_PM_Tools_ToolID_Description", 200, SkillID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Experience combo
        'usp_Sel_WorkExperience
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Experience")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboCompareFactor", "SELECT '>' UNION SELECT '<' UNION SELECT '>=' UNION SELECT '<='", 50, ExpOperator, , True)
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;")
        CommonFunctions.HTMLControls.DrawComboBox("cboExp", "usp_Sel_WorkExperience", 80, Exp, , True)
        CommonFunctions.General.WriteHTML("</td></tr>")

        'Certification combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Certification")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboCertification", "SELECT CertificationID,CertificationName FROM tbl_PM_Certifications ORDER BY CertificationName", 200, CertificationID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboCertification", "usp_sel_tbl_PM_Certifications_CertificationName", 200, CertificationID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Qualification Combo
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Qualification")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboQualification", "select QualificationID,QualificationName from tbl_PM_Qualifications ORDER BY QualificationName", 200, QualificationID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboQualification", "usp_sel_tbl_PM_Qualifications_QualificationID", 200, QualificationID, , True)
        CommonFunctions.General.WriteHTML("</td></tr>")
        ''Commented by Nilesh G on 17/11/2015 for issue id 1983
        ''CommonFunctions.General.WriteHTML("<tr class=clsTRPageCaption ><TD colspan=4><HR></TD></TR>")

        'Project Name combo
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Project")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''CommonFunctions.HTMLControls.DrawComboBox("cboProject", "SELECT ProjectID,ProjectName FROM tbl_PM_Project WHERE ([Over]=0 OR ActualEndDate IS NOT NULL) ORDER BY ProjectName", 200, ProjectID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_tbl_PM_Project_ProjectName_hr", 200, ProjectID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Resource Pool Combo
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Resource Pool")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "SELECT ResourcePoolID,ResourcePoolName FROM tbl_PM_ResourcePoolMaster ORDER BY ResourcePoolName", 200, ResourcePoolID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "usp_sel_tbl_PM_ResourcePoolMaster_ResourcePoolID", 200, ResourcePoolID, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")
        ''Commented by Nilesh G on 17/11/2015 for issue id 1983
        '' CommonFunctions.General.WriteHTML("<tr class=clsTRPageCaption><TD colspan=4><HR></TD></TR>")

        'Has passport
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Passport")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawCheckBox("chkhasPassport", "chkhasPassport", "clsCheckBox", Passport, "1", , )
        CommonFunctions.General.WriteHTML("</td><td></td><td></td></tr>")


        'Visa Country
        'select CountryID,CountryName from tbl_pm_countrymaster ORDER BY CountryName
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Visa Country")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboVisaCountry", "select CountryID,CountryName from tbl_pm_countrymaster ORDER BY CountryName", 200, VisaCountryID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboVisaCountry", "usp_sel_tbl_pm_countrymaster_CountryName", 200, VisaCountryID, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Visa Type
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Visa Type")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboVisaType", "SELECT VisaTypeID,VisaType FROM tbl_PM_VisaTypeMaster ORDER BY VisaType", 200, VisaTypeID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboVisaType", "usp_sel_tbl_PM_VisaTypeMaster_VisaType", 200, VisaTypeID, , True)
        CommonFunctions.General.WriteHTML("</td></tr>")

        'Apply and close buttons
        'CommonFunction.General.WriteHTML("<TABLE id='tblButton' class='clsGridTable' cellspacing='0' cellpadding='0'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:Apply_OnClick()' ><Font Size=1>Apply</Font></a>&nbsp;&nbsp;&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:Clear_OnClick()' ><Font Size=1>Clear</Font></a></TD>")

        CommonFunctions.General.WriteHTML("<input type=button id=btnApply onclick='Apply_OnClick()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("<input type=button id=btnClose onclick='Clear_OnClick()' value=""Clear""></TD>")

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")


    End Sub
    Private Sub DrawNumericPaging()

        Dim intRecordCount As Integer
        'Dim strPaging As String = WebPages.Template.Paging.DrawPaging(m_intPageNumber.ToString, PagingSQL, MyBase.GetResourceString("PAGING_CAPTION"), "Page_OnClick", "", True, , , True, 20)
        Dim strPaging As String = ""
        Dim strPagingSQL As String

        strPagingSQL = "SELECT COUNT(*) FROM v_tbl_PM_EmployeeHistory_Skills WHERE 1 = 1 " + WhereClause


        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strPagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event)", returnHTML:=True, EnableHTMLEncode:=True)
            'ended by Shamkant s  for HTML encoding Date:06/10/15

        End If

        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> "
        strPaging += "<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString + ">"

        strPaging += " of " + (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString
        strPaging += "|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All<B></A>"
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        strPaging += CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / 20)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        'For Applied Filters
        Call BuildFilterString()
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'>")

        If Trim(strAppliedFilters & "") <> "" Then
            If strAppliedFilters.Length > 50 Then
                strAppliedFilters = strAppliedFilters.Substring(0, 50)
            End If

            If strAppliedFilters = "None" Then
                Response.Write("<td align=left>Current Filter : None")
            Else
                Response.Write("<td align=left>Current Filter : <A href='javascript:Filters_OnClick(1)' >" + strAppliedFilters + "</A>")
                If strAppliedFilters <> "None" Then
                    Response.Write("<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='Clear_OnClick()'/>")
                End If
                Response.Write("</td>")
            End If

        End If
        'End of filter

        If Trim(strPaging & "") <> "" Then
            'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            Response.Write("<td align=right>" + strPaging + "</TD>")
        End If

        Response.Write("</TR></TABLE>")

    End Sub
    Private Sub BuildFilterString()

        Dim strFilterQuery As String
        Dim dr As IDataReader

        ',,, ,   , , ,,,,,, ,  ,   ,,  ,
        If RoleID = "" Then
            RoleID = "NULL"
        End If
        If DesignationID = "" Then
            DesignationID = "NULL"
        End If
        If SkillID = "" Then
            SkillID = "NULL"
        End If
        If BGID = "" Then
            BGID = "NULL"
        End If
        If OUID = "" Then
            OUID = "NULL"
        End If
        If DUID = "" Then
            DUID = "NULL"
        End If
        If DTID = "" Then
            DTID = "NULL"
        End If
        If DeptID = "" Then
            DeptID = "NULL"
        End If
        If ResourcePoolID = "" Then
            ResourcePoolID = "NULL"
        End If
        If GradeID = "" Then
            GradeID = "NULL"
        End If
        If Exp = "" Then
            Exp = "NULL"
        End If
        If ExpOperator = "" Then
            ExpOperator = "NULL"
        End If
        If CertificationID = "" Then
            CertificationID = "NULL"
        End If
        If QualificationID = "" Then
            QualificationID = "NULL"
        End If
        If ProjectID = "" Then
            ProjectID = "NULL"
        End If

        If VisaTypeID = "" Then
            VisaTypeID = "NULL"
        End If
        If VisaCountryID = "" Then
            VisaCountryID = "NULL"
        End If

        strFilterQuery = "usp_Sel_AppliedFilterString_ResourcePool " & RoleID & "," & DesignationID _
                            & "," & SkillID & "," & BGID & "," & OUID & "," & DUID _
                            & "," & DTID & "," & DeptID & "," & ResourcePoolID & "," & GradeID _
                            & ",'" & Exp & "','" & ExpOperator & "'," & CertificationID & "," & QualificationID _
                            & "," & ProjectID & ",'" & Passport & "'," & VisaTypeID & "," & VisaCountryID

        dr = CommonFunction.Data.GetDataReader(strFilterQuery, MyBase.UseSQL)

        While dr.Read
            strAppliedFilters = CType(dr("FilterString"), String)
        End While

        If strAppliedFilters = "" Then
            strAppliedFilters = "None"
        End If
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strEmployeeID As String
        Dim isChecked As Boolean = False

        If Args.ColumnName.ToUpper() = "SELECT" Then
            Cancel = True
            strEmployeeID = CType(Args.DataReader("EmployeeID"), String)
            If strRPEmplyeeIDs.IndexOf("," + strEmployeeID.Trim + ",") <> -1 Then
                isChecked = True
            End If
            Args.StringToBeInserted = "<TD align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , isChecked, strEmployeeID, , , True) + "</TD>"

            strUIEmployeeIDs = strUIEmployeeIDs + strEmployeeID + ","

        End If

    End Sub


    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        'If Args.ColumnName.ToUpper() = "SELECT" Then

        'End If

    End Sub

End Class
