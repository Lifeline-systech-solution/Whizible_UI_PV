Option Strict Off
Public Class HR_ResourceCalendarView
    Inherits WebPages.Template.WhizTemplate

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
#Region "Variable Declaration"

    Private m_blnUseSQL, m_blnSetProjectFilter As Boolean
    Private m_strPageCaption As String
    Protected m_intListNumber As Integer = 0
    Protected m_strDB_PageName As String
    Protected m_strPageTitle As String
    Protected m_strOrganizationUnit As String
    Protected m_strDeliveryUnit As String
    Protected m_strDeliveryTeam As String
    Protected m_strEmployeeID As String
    Private m_strEmployee As String
    Private m_strBGID As String
    Private m_strOUID As String
    Private m_strRoleID As String
    Private m_strDesignationID As String
    Private m_strSkillID As String
    Private m_strDUID As String
    Private m_strDTID As String
    Private m_strEmpTypeID As String

    Private m_strDepartmentID As String
    Private m_strDeployable As String
    Private m_strResourcePoolID As String

    Protected m_intPageNumber As Integer = 1
    Private m_intTotalNoOfRows As Integer
    'Protected m_strYear As String
    Protected m_strHoliDate As String
    Public m_PageMode As String
    Protected m_intMonth As Integer
    Protected m_intYear As Integer

    Protected m_CurrYear As Integer
    Protected strProjectName As String
    Protected intProjectID As Integer
    Protected dblResourcePrecentage As Double
    Protected ProjectStartDate As DateTime
    Protected ProjectEndDate As DateTime
    Protected fltEmpTask As Double
    Protected fltWorkingHrs As Double
    Protected fltTotalWorkingHrs As Double
    Protected intProjectEmployeeRoleID As Integer
    Protected blnSendMail As Boolean = False
    Protected strFromWhere As String
    Private strFrom As String
    Private strResourcePoolID As String
    Private strAppliedFilters As String = "None"
    Private strResourcePoolName As String
    Private strHelpID As String
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
        m_strDB_PageName = "../HR/HR_ResourceCalendarView.aspx"
        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Select Case Request.QueryString("From")
                Case "BG"
                    Response.Write(GetBGwiseOU())
                Case "OU"
                    Response.Write(GetOUWiseDU())
                Case "DU"
                    Response.Write(GetDUWiseDT())
            End Select
            Response.End()
        Else
            'MyBase.Page_Load(sender, e)
            Call Initialize()
        End If

        ''Added by Yogesh J on 29-Jan-2016 for to generate and validate Token		



    End Sub

    Private Sub Initialize()
        '=====================================================================
        ' Function Name         : Initialize
        ' Purpose               : Initializes the varaibles used in the page
        ' Description           : Also gets the various User Preferences from the Database
        ' Parameters Passed     : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : CommonFunction.vb, CommonFunctions.js,GenericCalender
        ' Author                : ShraddhaM
        ' Created               : 17 Dec, 2007
        ' Revisions             : 
        '=====================================================================

        '-- Procedure to Initialize all the page level settings/variables
        If Request.QueryString("Month") <> "" Then
            m_intMonth = CType(Request.QueryString("Month"), Integer)
            m_intYear = CType(Request.QueryString("Year"), Integer)
        Else
            m_intMonth = Now.Month
            m_intYear = Now.Year
        End If

        Dim drLocation As IDataReader
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''  Dim strSql As String = "SELECT LocationID FROM tbl_PM_Employee WHERE EmployeeID=" + Session("intUserID").ToString
        Dim strSql As String = "usp_sel_tbl_PM_Employee_LocationID " + Session("intUserID").ToString
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        Dim strLocationID As String

        drLocation = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

        While drLocation.Read
            strLocationID = CType(CommonFunctions.Data.CheckIsDBNull(drLocation("LocationID"), "0"), Integer)
        End While
        CommonFunctions.Data.DisposeDataReader(drLocation)


        If Request.QueryString("OrganizationUnitID") <> "" Then
            m_strOrganizationUnit = CType(Request.QueryString("OrganizationUnitID"), String)
        Else
            m_strOrganizationUnit = strLocationID
        End If

        'm_strDeliveryUnit = "NULL"
        'm_strDeliveryTeam = "NULL"


        'EmployeeID
        If Request.Form("txtResource") <> "" Then
            m_strEmployeeID = CType(Request.Form("txtResource"), String)
            m_strEmployee = m_strEmployeeID
            'strAppliedFilters = "Resource : " & m_strEmployeeID
        Else
            m_strEmployeeID = "NULL"
            m_strEmployee = ""
        End If

        'Role ID
        If Request.Form("cboRole") <> "" Then
            m_strRoleID = CType(Request.Form("cboRole"), String)
            'strAppliedFilters = "Role : " & m_strRoleID
        Else
            m_strRoleID = "NULL"
        End If

        'DesignationID
        If Request.Form("cboDesignation") <> "" Then
            m_strDesignationID = CType(Request.Form("cboDesignation"), String)
            'strAppliedFilters = "Designation : " & m_strDesignationID
        Else
            m_strDesignationID = "NULL"
        End If

        'Skill ID
        If Request.Form("cboSkill") <> "" Then
            m_strSkillID = CType(Request.Form("cboSkill"), String)
            'strAppliedFilters = "Skill : " & m_strSkillID
        Else
            m_strSkillID = "NULL"
        End If


        'BG ID
        If Request.Form("cboBG") <> "" Then
            m_strBGID = CType(Request.Form("cboBG"), String)
            'strAppliedFilters = "BG : " & m_strBGID
        Else
            m_strBGID = "NULL"
        End If
        'OU ID
        If Request.Form("cboOU") <> "" Then
            m_strOUID = CType(Request.Form("cboOU"), String)
            'strAppliedFilters = "OU : " & m_strOUID
        Else
            m_strOUID = "NULL"
        End If

        'DU
        If Request.Form("cboDU") <> "" Then
            m_strDUID = CType(Request.Form("cboDU"), String)
            'strAppliedFilters = "DU : " & m_strDUID
        Else
            m_strDUID = "NULL"
        End If
        'DT
        If Request.Form("cboDT") <> "" Then
            m_strDTID = CType(Request.Form("cboDT"), String)
            'strAppliedFilters = "DT : " & m_strDTID
        Else
            m_strDTID = "NULL"
        End If
        'Employee Type
        If Request.Form("cboEmpType") <> "" Then
            m_strEmpTypeID = CType(Request.Form("cboEmpType"), String)
            'strAppliedFilters = "Employee Type : " & m_strEmpTypeID
        Else
            m_strEmpTypeID = ""
        End If

        ' page number
        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If
        'm_strDepartmentID

        If Request.Form("cboDepartment") <> "" Then
            m_strDepartmentID = CType(Request.Form("cboDepartment"), String)
            'strAppliedFilters = "Department : " & m_strDepartmentID
        Else
            m_strDepartmentID = "NULL"
        End If

        'Deployable
        m_strDeployable = CType(Request.Form("cboDeployable"), String)

        If m_strDeployable = "D" Then
            'strAppliedFilters = "Deployable : Yes"
        End If

        If m_strDeployable Is Nothing Then
            m_strDeployable = ""
        End If

        'Resource Pool ID
        'ResourcePoolID
        m_strResourcePoolID = CType(Request.QueryString("ResourcePoolID"), String)
        If m_strResourcePoolID Is Nothing Then
            m_strResourcePoolID = CType(Request.Form("cboResourcePool"), String)
        End If

        'strAppliedFilters = "Resource Pool : " & m_strResourcePoolID

        If m_strResourcePoolID Is Nothing Or m_strResourcePoolID = "" Then
            m_strResourcePoolID = "NULL"
        End If

        If m_intYear = 0 Then
            m_intYear = DateTime.Now.Year
        End If
        If m_intMonth = 0 Then
            m_intMonth = DateTime.Now.Month
        End If
        If m_intMonth = 13 Then
            m_intMonth = 1
            m_intYear = m_intYear + 1
        End If

        m_CurrYear = Now.Year



    End Sub
#Region "Draw Page"
    Public Sub DrawPage()
        '=====================================================================
        ' Page Name             : DrawPage
        ' Purpose               : The Main functions which draw the Page are called here 
        ' Description           : this fn. is called from within the Form Tag
        ' Parameters Passed     : 
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShraddhaM
        ' Created               : 17 Dec,2007
        ' Revisions             : 
        '=====================================================================
        '  DropdownMenu


        Dim strAccess As String

        '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
        Dim dtStartDate As New Date(m_intYear, m_intMonth, 1)
        Dim dtTodaysDate As Date
        dtTodaysDate = Now

        'Whether page is opened from Employee Maintenance , My Team or from Resource Pool
        strFromWhere = CType(Request.QueryString("From"), String)
        If strFromWhere Is Nothing Or strFromWhere = "" Then
            strFromWhere = CType(Request.Form("hidFromWhere"), String)
        End If

        If strFromWhere.ToUpper() = "EMPLOYEE" Then
            strFrom = 0
            strHelpID = "EMP_RCV"
        ElseIf strFromWhere.ToUpper() = "MYTEAM" Then
            strFrom = 1
            strHelpID = "MYTEAM_RCV"
        ElseIf strFromWhere.ToUpper() = "RPOOL" Then
            strFrom = 2
            strHelpID = "RPOOL_RCV"
        ElseIf strFromWhere.ToUpper() = "MYCALENDAR" Then
            strFrom = 3
            strHelpID = "MYCALENDAR_RCV"
        End If

        strResourcePoolID = CType(Request.QueryString("ResourcePoolID"), String)
        If strResourcePoolID Is Nothing Or strResourcePoolID = "" Then
            strResourcePoolID = CType(Request.Form("cboResourcePool"), String)
        End If
        If strResourcePoolID = "" Then
            strResourcePoolID = "NULL"
        End If
        Response.Write("<input type=hidden name='hidFromWhere' id='hidFromWhere' value='" + strFromWhere + "'>")

        'End of FromWhere


        Response.Write("<Div id='divContextMenu' class='DropdownMenu'>")
        Response.Write("<Table cellspacing='0' cellpadding='3' >")
        'Commented and added by Nilesh P on 24 Mar 2020  Issue ID:23020 For pointer css
        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.style='cursor:pointer;' onmouseout =this.className='MenuSelected_Normal'>")
        'Commented and added by Nilesh P on 24 Mar 2020 Issue ID:23020 For pointer css
        Response.Write("<td class='CtMn_LeftFill' ></td>")
        Response.Write("<td id='tdShowTasks' title='Show Tasks' >&nbsp;&nbsp;&nbsp;Show All Tasks")
        Response.Write("</td></tr>")
        Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        Response.Write("<td class='CtMn_Hr'></td></tr>")
        'Commented and added by Nilesh P on 24 Mar 2020  Issue ID:23020 For pointer css
        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.style='cursor:pointer;' onmouseout =this.className='MenuSelected_Normal'>")
        'Commented and added by Nilesh P on 24 Mar 2020 Issue ID:23020 For pointer css
        Response.Write("<td class='CtMn_LeftFill' ></td>")
        Response.Write("<td id='tdResourceUtilization' title='Resource Utilization' >&nbsp;&nbsp;&nbsp;Resource Utilization")
        Response.Write("</td></tr>")
        Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        Response.Write("<td class='CtMn_Hr'></td></tr>")
        'Commented and added by Nilesh P on 24 Mar 2020  Issue ID:23020 For pointer css
        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.style='cursor:pointer;' onmouseout =this.className='MenuSelected_Normal'>")
        'Commented and added by Nilesh P on 24 Mar 2020 Issue ID:23020 For pointer css
        Response.Write("<td class='CtMn_LeftFill' ></td>")
        Response.Write("<td id='tdProjectAllocation' title='Project Allocation' >&nbsp;&nbsp;&nbsp;Project Allocation")
        Response.Write("</td></tr>")
        Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        Response.Write("<td class='CtMn_Hr'></td></tr>")
        'Commented and added by Nilesh P on 24 Mar 2020  Issue ID:23020 For pointer css
        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.style='cursor:pointer;' onmouseout =this.className='MenuSelected_Normal'>")
        'Commented and added by Nilesh P on 24 Mar 2020 Issue ID:23020 For pointer css
        Response.Write("<td class='CtMn_LeftFill' ></td>")
        Response.Write("<td id='tdSkillView' title='Gantt View' >&nbsp;&nbsp;&nbsp;Skill Details")
        Response.Write("</td></tr>")
        Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        Response.Write("<td class='CtMn_Hr'></td></tr>")
        'Commented and added by Nilesh P on 24 Mar 2020  Issue ID:23020 For pointer css
        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.style='cursor:pointer;' onmouseout =this.className='MenuSelected_Normal'>")
        'Commented and added by Nilesh P on 24 Mar 2020 Issue ID:23020 For pointer css
        Response.Write("<td class='CtMn_LeftFill' ></td>")
        Response.Write("<td id='tdLeavDetails' title='Leave Details' >&nbsp;&nbsp;&nbsp;Leave Details")
        Response.Write("</td></tr>")
        Response.Write("</table></Div>")

        Response.Write("<DIV Id='divPage' Style='height:100%; overflow:auto; width:99.99%' >")

        Call DrawTabs()

    End Sub
    Private Sub DrawTabs()
        '=====================================================================
        ' Procedure Name        : DrawTabs
        ' Purpose               : Draws the Menu-like Tabs 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ShraddhaM
        ' Created               : 17,Dec 2007
        ' Revisions             :
        '=====================================================================
        'Dim BGID As String
        'Dim OUID As String
        'Dim DUID As String
        'Dim DTID As String

        'If Request.Form("cboBG") <> "" Then
        '    BGID = Request.Form("cboBG")
        'Else
        '    BGID = "'NULL'"
        'End If

        'If Request.Form("cboOU") <> "" Then
        '    OUID = Request.Form("cboOU")
        'Else
        '    OUID = "'NULL'"
        'End If

        'If Request.Form("cboDU") <> "" Then
        '    DUID = Request.Form("cboDU")
        'Else
        '    DUID = "'NULL'"
        'End If

        'If Request.Form("cboDT") <> "" Then
        '    DTID = Request.Form("cboDT")
        'Else
        '    DTID = "'NULL'"
        'End If


        Dim strTabs As String
        Dim strSql As String
        Dim days1() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        '-----------------Added on 19th Jan 06 as Employee Combo was showing employee whose leaveing date is less than curr date
        Dim intYear, intMonth As Integer
        intYear = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Year"), 0.ToString))
        intMonth = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Month"), 0.ToString))

        If intMonth > 12 Then
            intMonth = 1
            intYear += 1
        End If

        If intYear = 0 Or intMonth = 0 Then
            intYear = m_intYear
            intMonth = m_intMonth
        End If

        '--- Check for Leap Year
        'If ((((intYear Mod 4) = 0) And ((intYear Mod 100) <> 0)) Or ((intYear Mod 400) = 0)) Then
        If DateTime.IsLeapYear(intYear) Then
            days1(2) = 29
        Else
            days1(2) = 28
        End If

        '    '--- Get Leaves for that Employee
        Dim dtStartDate As New Date(intYear, intMonth, 1)
        Dim dtEndDate As New Date(intYear, intMonth, days1(intMonth))

        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% >")
        CommonFunctions.General.WriteHTML("<TD align=right>")

        CommonFunctions.General.WriteHTML("|<a class='Menu' style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML("title='Previous Month' href='javascript:PreviousMonth_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;" + "" & MyBase.GetResourceString("CAP_PREVIOUS_MONTH") & "" + "")
        CommonFunctions.General.WriteHTML("</a>|")

        CommonFunctions.General.WriteHTML("<a class='Menu' style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML("title='Next Month' Href='javascript:NextMonth_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;" + "" & MyBase.GetResourceString("CAP_NEXT_MONTH") & " ")
        CommonFunctions.General.WriteHTML("</a>&nbsp;")

        'If strFromWhere.ToUpper() = "MYTEAM" Then
        CommonFunctions.General.WriteHTML("|<a class='Menu' style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML("title='Project Allocation' Href='javascript:ProjectAllocation_clicked(""" + dtStartDate.ToString("dd-MMM-yyyy") + """,""" + dtEndDate.ToString("dd-MMM-yyyy") + """)'>")
        'CommonFunctions.General.WriteHTML("title='Project Allocation' Href='javascript:ProjectAllocation_clicked()'>")
        CommonFunctions.General.WriteHTML("&nbsp;Project Allocation")
        CommonFunctions.General.WriteHTML("</a>&nbsp;")
        'End If

        CommonFunctions.General.WriteHTML("|&nbsp;<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='showFilters(1)'/>")

        If strFromWhere.ToUpper() = "RPOOL" Then
            CommonFunctions.General.WriteHTML("<a class='Menu' style='TEXT-DECORATION:None' title='Close' href=javascript:Close_OnClick()>")
            CommonFunctions.General.WriteHTML("|&nbsp;Close")
            CommonFunctions.General.WriteHTML("</a>")
        End If

        CommonFunctions.General.WriteHTML("<a class='Menu' style='TEXT-DECORATION:None' title='Help' href=javascript:Help_OnClick('" + strHelpID + "')>")
        CommonFunctions.General.WriteHTML("|&nbsp;" + MyBase.GetResourceString("MENU_QUESTION_MARK"))
        CommonFunctions.General.WriteHTML("</a>&nbsp;|")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("<BR>")

        'Filter Table 
        ''Commented and added by Nilesh G on 4/11/2015 for issue id 1984
        ''CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='0' cellpadding='1'>")
        'Note
        CommonFunctions.General.WriteHTML("<TR width=99.9%  class=clsTRPageCaption>")
        CommonFunctions.General.WriteHTML("<TD colspan=4 >Note : " + MyBase.GetResourceString("CAP_CORPORATEDAYS") + "</TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")

        'strSql = "usp_Sel_AllResources_ForCombo '" & dtStartDate & "','" & dtEndDate & "'," & Session("intUserID").ToString & "," & strFrom & "," & strResourcePoolID

        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right'align=right>Resource")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left title='Starts with' >")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtResource", "txtResource", , 200, 50, m_strEmployee, , , , , , , , , , , , , , EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSql, 200, m_strEmployeeID.ToString, True, True)
        'Grouping on combo SQL
        'Dim GroupingColName As CommonFunctions.HTMLControls.WAF_DropDown = New CommonFunctions.HTMLControls.WAF_DropDown
        'GroupingColName.DropdownGroupingColumn = "ReportingName"
        'GroupingColName.MatchFieldID = m_strEmployeeID
        'GroupingColName.WidthInPixel = 200
        'GroupingColName.ToBeInserted = True
        'GroupingColName.InsertBlankRow = True

        'CommonFunctions.HTMLControls.DrawComboBox("cboEmployee", strSql, GroupingColName)

        CommonFunctions.General.WriteHTML("</td>")
        'Fo Role Filter
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Role")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left>")
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID.ToString, True, True)
        CommonFunctions.General.WriteHTML("</td></TR>")
        'For Designation Filter
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Designation")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "select DesignationID,DesignationName from tbl_PM_DesignationMaster ORDER BY DesignationName", 200, m_strDesignationID.ToString, True, True)
        CommonFunctions.General.WriteHTML("</td>")
        'For PrimarySkills
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Skill")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "select distinct T.ToolID,[Description] from tbl_PM_Tools T ORDER BY [Description]", 200, m_strSkillID.ToString, True, True)
        CommonFunctions.General.WriteHTML("</td></TR>")
        'For BG Filter 
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Business Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_BusinessGroups_LevelWise_RCV " + Session("intUserID").ToString, 200, m_strBGID, "onChange= BG_onChange()", True)
        CommonFunctions.General.WriteHTML("</td>")
        'For OU Filter 
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Organization Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_RCV " + m_strBGID + "," + Session("intUserID").ToString, 200, m_strOUID, "onChange=OU_onChange()", True)
        CommonFunctions.General.WriteHTML("</td></TR>")
        'For DU Filter
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Delivery Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_sel_DeliveryUnits_LevelWise_RCV " + m_strBGID + "," + m_strOUID + "," + Session("intUserID").ToString, 200, m_strDUID, "onChange=DU_onChange()", True)
        CommonFunctions.General.WriteHTML("</td>")
        'For DT Filter
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Delivery Team")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboDT", "usp_sel_DeliveryTeams_LevelWise_RCV " + m_strBGID + "," + m_strOUID + "," + m_strDUID + "," + Session("intUserID").ToString, 200, m_strDTID, True, True)
        CommonFunctions.General.WriteHTML("</td></TR>")
        'Employee Type
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Employee Type")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmpType", "usp_Sel_tbl_RTS_ProjectSpecificControlData  'EmployeeType'", 200, m_strEmpTypeID.ToString, True, True)
        CommonFunctions.General.WriteHTML("</td>")
        'SELECT DepartmentID,Department FROM tbl_pm_Departmentmaster ORDER BY Department
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Department")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "SELECT DepartmentID,Department FROM tbl_pm_Departmentmaster ORDER BY Department", 200, m_strDepartmentID.ToString, True, True)
        CommonFunctions.General.WriteHTML("</td></TR>")

        'Deployable
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Deployable")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "SELECT 'N','No' UNION SELECT 'D','Yes' order by 2", 200, m_strDeployable, True, True)
        CommonFunctions.General.WriteHTML("</td>")
        'Resource Pool
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Resource Pool")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        If strFrom = 2 Then
            CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "usp_Sel_tbl_PM_ResourcePoolMaster " + Session("intUserID").ToString(), 200, m_strResourcePoolID, " disabled ", True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "usp_Sel_tbl_PM_ResourcePoolMaster " + Session("intUserID").ToString(), 200, m_strResourcePoolID, , True)
        End If

        CommonFunctions.General.WriteHTML("</td></TR>")
        'Apply Button
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter()' ><Font Size=1>Apply</Font></a>&nbsp;&nbsp;&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:ClearFilter()' ><Font Size=1>Clear</Font></a></TD>")
        CommonFunctions.General.WriteHTML("<input type=button id=btnApply onclick='applyFilter()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("<input type=button id=btnClose onclick='ClearFilter()' value=""Clear""></TD>")


        CommonFunctions.General.WriteHTML("</TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")
        ''Here Previous page and Next Page links are plot
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing=0 border=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<tr class=clsTRPageCaption width=99.9%>")

        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_MONTH"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=1% align=left >")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtMonth", "txtMonth", , 30, 2, m_intMonth.ToString, "right", EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td width=2% align=right>" & MyBase.GetResourceString("CAP_YEAR"))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td width=2% align=left >")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtYear", "txtYear", , 40, 4, m_intYear.ToString, "right", EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15

        CommonFunctions.General.WriteHTML("</td>")

        'Here show link will plot

        CommonFunctions.General.WriteHTML("<td width=6% align=Left id='objTDCell'>&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("|<a style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" href='javascript:Show_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;<b>Show</b>")
        CommonFunctions.General.WriteHTML("</a>|</td>")

        'To Build applied Filters string 
        'Call BuildFilterString()
        'CommonFunctions.General.WriteHTML("<TD width=6% Title='" & strAppliedFilters & "' >Filters</TD>")
        'End of building Applied Filter



        'CommonFunctions.General.WriteHTML("<TD align='Right' onMouseOver=this.style.cursor='hand' onclick='showLegendMenu(event,this) >")
        CommonFunctions.General.WriteHTML("<TD align='Right' >")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CAP_LEGENDS") & ":&nbsp;</TD>")

        ''For Legends Context Menu

        'Response.Write("<Div id='divLegendsContextMenu' class='DropdownMenu'>")
        'Response.Write("<Table cellspacing='0' cellpadding='3' >")
        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'Response.Write("<td class='CtMn_LeftFill' ><img src = '../../Images/Calender Images/LegendHoliday.gif' Title='Holiday' style='border: 1px solid gray;width: auto' ></td>")
        'Response.Write("<td id='tdHoliday' title='Holiday' >&nbsp;&nbsp;&nbsp;Holiday")
        'Response.Write("</td></tr>")
        'Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        'Response.Write("<td class='CtMn_Hr'></td></tr>")

        'Response.Write("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        'Response.Write("<td class='CtMn_LeftFill' ><img src = '../../Images/Calender Images/LegendHoliday.gif' Title='Holiday' style='border: 1px solid gray;width: auto' ></td>")
        'Response.Write("<td id='tdHoliday' title='Holiday' >&nbsp;&nbsp;&nbsp;Holiday")
        'Response.Write("</td></tr>")
        'Response.Write("<TR><td class='CtMn_LeftFill' ></td>")
        'Response.Write("<td class='CtMn_Hr'></td></tr>")

        ''End of Legends Context menu

        'CommonFunctions.General.WriteHTML("<TD width=6% align='Right'>" & MyBase.GetResourceString("CAP_HOLIDAYS") & " &nbsp;</TD>")
        'CommonFunctions.General.WriteHTML("<TD  height=5px width=2.5 Title='Holiday' background = '../../Images/Calender Images/LegendHoliday.gif' ></TD>")
        CommonFunctions.General.WriteHTML("<TD align=left ><img src = '../../Images/Calender Images/LegendHoliday.gif' Title='Holiday' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendWFH.gif' Title='Work From Home' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendLeave.gif' Title='Leave' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendHalfDay.gif' Title='Half Day' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/Pattern1.jpg' Title='Planned Day' style='border: 1px solid gray;width: auto;height:15px;width:28px' >")
        'CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPHoliday.jpg' Title='Planned and Holiday' >")
        'CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPWFH.jpg' Title='Planned and Work From Home' >")
        'CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPLeave.jpg' Title='Planned and Leave' >")
        'CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPHalfDay.jpg' Title='Planned and Half Day' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPHoliday.gif' Title='Planned and Holiday' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPWFH.gif' Title='Planned and Work From Home' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPLeave.gif' Title='Planned and Leave' style='border: 1px solid gray;width: auto' >")
        CommonFunctions.General.WriteHTML("<img src = '../../Images/Calender Images/LegendPHalfDay.gif' Title='Planned and Half Day' style='border: 1px solid gray;width: auto' >")

        CommonFunctions.General.WriteHTML("</TD>")


        CommonFunctions.General.WriteHTML("</tr></table>")
        CommonFunctions.General.WriteHTML("<BR>")

        Call DisplayGrid()


        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% >")
        CommonFunctions.General.WriteHTML("<TD align=right>")

        CommonFunctions.General.WriteHTML("|<a class='Menu'  style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" title='Previous Month' href='javascript:PreviousMonth_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;" + "" & MyBase.GetResourceString("CAP_PREVIOUS_MONTH") & "" + "")
        CommonFunctions.General.WriteHTML("</a>|")

        CommonFunctions.General.WriteHTML("<a class='Menu'  style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML(" title='Next Month' Href='javascript:NextMonth_clicked()' >")
        CommonFunctions.General.WriteHTML("&nbsp;" + "" & MyBase.GetResourceString("CAP_NEXT_MONTH") & " ")
        CommonFunctions.General.WriteHTML("</a>&nbsp;")

        'If strFromWhere.ToUpper() = "MYTEAM" Then
        CommonFunctions.General.WriteHTML("|<a class='Menu' style='TEXT-DECORATION:None' ")
        CommonFunctions.General.WriteHTML("title='Project Allocation' Href='javascript:ProjectAllocation_clicked(""" + dtStartDate.ToString("dd-MMM-yyyy") + """,""" + dtEndDate.ToString("dd-MMM-yyyy") + """)'>")
        CommonFunctions.General.WriteHTML("&nbsp;Project Allocation")
        CommonFunctions.General.WriteHTML("</a>&nbsp;")
        'End If

        If strFromWhere.ToUpper() = "RPOOL" Then

            CommonFunctions.General.WriteHTML("<a class='Menu' title='Close' style='TEXT-DECORATION:None' href=javascript:Close_OnClick()>")
            CommonFunctions.General.WriteHTML("|&nbsp;Close")
            CommonFunctions.General.WriteHTML("</a>")
        End If

        '<Font Size=1 face=Arial;verdana color=black>
        CommonFunctions.General.WriteHTML("<a class='Menu' style='TEXT-DECORATION:None' title='Help' href=javascript:Help_OnClick('" + strHelpID + "')>")
        CommonFunctions.General.WriteHTML("|&nbsp;" + MyBase.GetResourceString("MENU_QUESTION_MARK"))
        CommonFunctions.General.WriteHTML("</a>&nbsp;|")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")

        Response.Write("</DIV>")

    End Sub

    Private Sub DisplayGrid()
        '=====================================================================
        ' Page Name             : PrepareSections
        ' Purpose               : Calls to the 4 Grids in the Top Section for the 4 grids
        ' Description           : Called from PrepareSections() function
        ' Parameters Passed     : NA
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ManishK
        ' Created               : Dec 6, 2005
        ' Revisions             : 
        '=====================================================================
        Dim strSql As String
        Dim drForGrid, drForEmployee, drStartDayOfWeek As IDataReader
        Dim strEmployeeID As String
        Dim strEmployeeName As String
        Dim intStartingDayOfWeek, intNoOfWeekDays As Integer
        Dim intRowCount As Integer
        Dim drHolidays As IDataReader
        Dim strCalenderHTML, strDate As String
        Dim intYear, intMonth As Integer
        Dim HolidayArray() As Integer = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12}
        Dim strLeaves As String
        Dim strLeavesArray As String()
        Dim intMonthDays As Integer = 0
        Dim intCounter As Integer = 0
        Dim intIterator As Integer = 0
        Dim intLoop As Integer = 0
        Dim strList As String
        Dim strMode As String
        Dim dtDate As Date
        Dim days() As String = {0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31}
        Dim HalfDay As String
        Dim HalfDayArray() As String

        Dim ActualHrs As String
        Dim drActualHrs As IDataReader
        Dim ActualHrsArray() As String
        Dim PlannedColor As String
        Dim arrPlannedColor() As String
        Dim intEmployeeID As String
        Dim strWorkingHrs As String
        Dim intReportingID As Integer
        Dim intReportingID_old As Integer = 0
        Dim strReportingName As String
        Dim m_strPKToken_ResorceAllocation As String
        Dim ReadCount As Integer
        'Added By Sanyogeeta Raorane 29-Dec-2016
        Dim StatusColor As String
        Dim arrStatusColor() As String
        Dim PlotStatusArray() As Integer
        'End of Added By Sanyogeeta Raorane 29-Dec-2016
        strSql = "SELECT weekDays,StartingDayOfWeek FROM tbl_PM_CompanyInformation"

        Try
            drStartDayOfWeek = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

            While drStartDayOfWeek.Read
                intNoOfWeekDays = CType(CommonFunctions.Data.CheckIsDBNull(drStartDayOfWeek("WeekDays"), "0"), Integer)
                intStartingDayOfWeek = CType(CommonFunctions.Data.CheckIsDBNull(drStartDayOfWeek("StartingDayOfWeek"), "0"), Integer) + 1
            End While
            CommonFunctions.Data.DisposeDataReader(drStartDayOfWeek)

            If intStartingDayOfWeek = 8 Then
                intStartingDayOfWeek = 1
            End If

            Dim objCalender As New GenericCalender.GenericCalender(intStartingDayOfWeek, intNoOfWeekDays)

            '-- Get the Year and Month ('Previous' or 'Next' clicked)
            intYear = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Year"), 0.ToString))
            intMonth = CInt(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Month"), 0.ToString))
            'intEmployeeID = HttpContext.Current.Request.QueryString("EmployeeID")
            intEmployeeID = HttpContext.Current.Request.Form("txtResource")

            If intMonth > 12 Then
                intMonth = 1
                intYear += 1
            End If

            If intYear = 0 Or intMonth = 0 Then
                intYear = m_intYear
                intMonth = m_intMonth
            End If

            '--- Check for Leap Year
            'If ((((intYear Mod 4) = 0) And ((intYear Mod 100) <> 0)) Or ((intYear Mod 400) = 0)) Then
            If DateTime.IsLeapYear(intYear) Then
                days(2) = 29
            Else
                days(2) = 28
            End If

            '    '--- Get Leaves for that Employee
            Dim dtStartDate As New Date(intYear, intMonth, 1)
            Dim dtEndDate As New Date(intYear, intMonth, days(intMonth))
            Dim LeavesArray() As Integer '= {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            Dim dtHoliDate As New Date(intYear, intMonth, 1)
            Dim strTemp As String = ""

            '--- Get Holidays for OU
            HolidayArray.Clear(HolidayArray, 0, 12)

            'Paging SQL for Count of Records


            If intEmployeeID Is Nothing Then
                intEmployeeID = ""
            End If

            strSql = "usp_Sel_Count_OrganizationResources '" & intEmployeeID & "','" & dtStartDate & "','" & dtEndDate & "'," & m_strBGID & "," & m_strOUID & "," & m_strRoleID & "," & m_strDesignationID & "," & m_strSkillID & "," & m_strDUID & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID & "," & Session("intUserID").ToString & "," & strFrom & "," & strResourcePoolID & ",'" & m_strDeployable & "'"
            'To Build applied Filters string 
            Call BuildFilterString()
            'CommonFunctions.General.WriteHTML("<TD width=6% Title='" & strAppliedFilters & "' >Filters</TD>")
            'End of building Applied Filter
            Call WritePaging(strSql)

            strSql = "usp_Sel_OrganizationResources " & m_intPageNumber.ToString() & ",'" & intEmployeeID & "','" & dtStartDate & "','" & dtEndDate & "'," & m_strBGID & "," & m_strOUID & "," & m_strRoleID & "," & m_strDesignationID & "," & m_strSkillID & "," & m_strDUID & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID & "," & Session("intUserID").ToString & "," & strFrom & "," & strResourcePoolID & ",'" & m_strDeployable & "'"

            ''Commented and Added by Dhanashri S on 7 Dec 2015 For IssueID : 2030
            ''Response.Write("<DIV Id='divContainer' Style='height:410px; overflow:auto; width:100%' >")
            Response.Write("<DIV Id='divContainer' Style=overflow:auto; width:100%' >")
            ''End of Comment and Addition by Dhanashri S on 7 Dec 2015
            Response.Write(" <STYLE type=text/css> {TABLE  {TABLE-LAYOUT: fixed;} ")
            Response.Write(" TR TD.DivSub1Tag {POSITION: relative;} ")
            Response.Write(" TR TD.DivSub1Tag {Z-INDEX: 10; ; TOP:expression(document.getElementById('divContainer').scrollTop -1)} ")
            Response.Write(" </STYLE>")
            CommonFunctions.General.WriteHTML("<table id='tblHeader' cellSpacing=1 bgcolor='#a9a9a9' cellPadding=0  width=100% border='0' Height=30px>")
            strTemp = "Resource Name"
            CommonFunctions.General.WriteHTML("" + objCalender.PlotCalenderForALLResourceHeadings(m_intMonth, m_intYear, "" + strTemp + "") + "")

            'here objCalender is set to Nothing so that GC will collect it
            objCalender = Nothing

            drForGrid = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)

            If m_intPageNumber > 0 Then
                For ReadCount = 1 To (20 * (m_intPageNumber - 1))
                    drForGrid.Read()
                Next
            End If

            While (drForGrid.Read)
                'Here we are plotting the Empty Calender control
                Dim objEmptyCalender As New GenericCalender.GenericCalender(intStartingDayOfWeek, intNoOfWeekDays)

                strEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeID"), " "), String)
                strEmployeeName = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("EmployeeName"), "0"), String)
                intReportingID = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ReportingTo"), "0"), Integer)
                strReportingName = CType(CommonFunctions.Data.CheckIsDBNull(drForGrid("ReportingName"), " "), String)

                'Token Security
                m_strPKToken_ResorceAllocation = CommonFunctions.Security.Token.GetToken(CType(intProjectEmployeeRoleID, String) + Session("intUserID").ToString + "0" + "1019")
                'End of Token Security
                strSql = "usp_Sel_MonthlyTasks_ForAllResources " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
                drActualHrs = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                While drActualHrs.Read
                    ActualHrs = CType(drActualHrs("ActualHrs"), String)
                    ActualHrsArray = ActualHrs.Split(",")
                End While

                ''***************************For holiday *********************************

                'strSql = "usp_sel_Holidays '" & dtHoliDate & "'"
                'usp_sel_Holidays_For_OU
                strSql = "usp_sel_Holidays_For_OU '" & dtHoliDate & "'," & strEmployeeID
                drHolidays = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
                intCounter = 0
                While drHolidays.Read
                    HolidayArray(intCounter) = CInt(CommonFunctions.Data.CheckIsDBNull(drHolidays.Item("Holidays"), "0"))
                    objEmptyCalender.DaysForResource(HolidayArray(intCounter)).mstrCellBackColor += "|" + "#cc0000"
                    intCounter += 1
                End While
                CommonFunctions.Data.DisposeDataReader(drHolidays)

                ''***************************End of Holiday*********************************

                strSql = "usp_Sel_MonthlyTasksColor_ForAllResources " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"

                PlannedColor = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                arrPlannedColor = PlannedColor.Split(",")
                Dim icolor As Integer

                For icolor = 0 To arrPlannedColor.Length - 1
                    ReDim Preserve LeavesArray(icolor)

                    If arrPlannedColor(icolor) = "2" Or arrPlannedColor(icolor) = "1" Then
                        objEmptyCalender.DaysForResource(icolor + 1).mstrCellBackColor += "|" + "#DDA0DD"
                    End If
                Next
                '*******************************************End of Color*********************
                ReDim LeavesArray(-1)
                ''''''''********''''''This is for Employee Leaves****************************
                strSql = "usp_Get_EmployeeLeaves_ForCalender " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'," & "'L'"
                strLeaves = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                strLeavesArray = strLeaves.Split(",")

                For intIterator = 0 To strLeavesArray.Length - 1

                    ReDim Preserve LeavesArray(intIterator)
                    'Here "-1" is checked to control the Employee name cell color 
                    If strLeavesArray(intIterator) = "" Or strLeavesArray(intIterator) = "-1" Or strLeavesArray(intIterator) = "0" Then
                        LeavesArray(intIterator) = 0
                    Else
                        LeavesArray(intIterator) = CInt(strLeavesArray(intIterator))
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).mstrCellBackColor += "|" + "BlueViolet"
                    End If
                Next

                'For Half Day
                strSql = "usp_Get_HalfDay " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
                HalfDay = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                HalfDayArray = HalfDay.Split(",")
                Dim i As Integer

                For i = 0 To HalfDayArray.Length - 1
                    ReDim Preserve LeavesArray(i)
                    If HalfDayArray(i) = "" Or HalfDayArray(i) = "-1" Or HalfDayArray(i) = "0" Then
                        LeavesArray(i) = 0
                    Else
                        LeavesArray(i) = CInt(HalfDayArray(i))
                        objEmptyCalender.DaysForResource(LeavesArray(i)).mstrCellBackColor += "|" + "CC0099"
                    End If
                Next

                '''''''********''''''This is for Employee Work From Home Request(WFH) ****************************
                strSql = "usp_Get_EmployeeLeaves_ForCalender " & strEmployeeID & ",'" & dtStartDate & "','" & dtEndDate & "'"
                strLeaves = CommonFunctions.Data.GetDataScalar(strSql, MyBase.UseSQL)
                strLeavesArray = strLeaves.Split(",")
                For intIterator = 0 To strLeavesArray.Length - 1
                    ReDim Preserve LeavesArray(intIterator)
                    If strLeavesArray(intIterator) = "" Or strLeavesArray(intIterator) = "-1" Or strLeavesArray(intIterator) = "0" Then
                        LeavesArray(intIterator) = 0
                    Else
                        LeavesArray(intIterator) = CInt(strLeavesArray(intIterator))
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).mstrCellBackColor += "|" + "#00cc33"
                        objEmptyCalender.DaysForResource(LeavesArray(intIterator)).Text = "<TABLE width=99.9% style='border:1px solid green'><TR><TD ></TD></TR></TABLE>" ' "<Table width=99.9%><TR><TD align='Left'><Font size=1>B</Font></TD></TR></TABLE>"
                    End If
                Next
                ''***************************End Planed Day Color *********************************


                If intReportingID = intReportingID_old Then
                    CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotALLResourceHoursCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", "" & ActualHrs & "", CType(strEmployeeID, Integer), blnSendMail, 0, "0", "" & PlannedColor & "", "" & m_strPKToken_ResorceAllocation & "") + "")
                Else
                    CommonFunctions.General.WriteHTML("" + objEmptyCalender.PlotALLResourceHoursCalender(m_intMonth, m_intYear, "" & strEmployeeName & "", "" & ActualHrs & "", CType(strEmployeeID, Integer), blnSendMail, intReportingID, "" & strReportingName & "", "" & PlannedColor & "", "" & m_strPKToken_ResorceAllocation & "") + "")
                End If
                intReportingID_old = intReportingID

                objEmptyCalender = Nothing
            End While
            CommonFunctions.General.WriteHTML("</table>")
        Catch ex As Exception

        End Try
        CommonFunctions.Data.DisposeDataReader(drForGrid)
        CommonFunctions.General.WriteHTML("</TABLE>")
        Response.Write("</DIV>")
    End Sub

    Private Sub WritePaging(ByVal PagingSQL As String)

        Dim intRecordCount As Integer
        Dim strPaging As String = ""

        m_intTotalNoOfRows = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(PagingSQL, MyBase.UseSQL), ""), ""), Integer)

        If Math.Ceiling(m_intTotalNoOfRows / 20) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        strPaging = "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>"
        strPaging += "<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">"
        strPaging += "<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>"

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Commented and added by Shamkant s for HTML encoding Date:06/10/15
            'Commented and added By Bharat T on 28th-Oct-2015
            'strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", " ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event) ", returnHTML:=True, EnableHTMLEncode:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", "vertical-align:text-top; margin-top:0px;", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event) ", returnHTML:=True, EnableHTMLEncode:=True)
        Else
            'strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event) ", returnHTML:=True, EnableHTMLEncode:=True)
            strPaging += CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", "vertical-align:text-top; margin-top:0px;", ToBeInserted:="onkeypress=txtPageNumber_KeyPress(event) ", returnHTML:=True, EnableHTMLEncode:=True)
            'End of Commented and added By Bharat T on 28th-Oct-2015
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

        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'>")

        'For Applied Filters
        If Trim(strAppliedFilters & "") <> "" Then
            If strAppliedFilters.Length > 50 Then
                strAppliedFilters = strAppliedFilters.Substring(0, 50) + "..."
            End If

            If strAppliedFilters = "None" Then
                Response.Write("<td align=left  >Current Filter : None")
            Else
                Response.Write("<td align=left  >Current Filter : <A href='javascript:showFilters(1)' >" + HttpUtility.HtmlEncode(strAppliedFilters) + "</A>")
                If strAppliedFilters <> "None" Then
                    Response.Write("<img id='imgFilter' style='text-decoration:none;' onMouseOver=this.style.cursor='hand' border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
                End If
                Response.Write("</td>")
            End If

        End If
        If strFrom = 2 Then
            Response.Write("<td>Resource Pool : ")
            Response.Write(strResourcePoolName)
            Response.Write("</td>")
        End If
        'End of Applied Filters
        If Trim(strPaging & "") <> "" Then
            'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            Response.Write("<td align=right>" + strPaging + "</TD>")
        End If

        Response.Write("</TR></TABLE>")

    End Sub
    Private Function GetBGwiseOU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strBGID As String
        Dim strJscript As String = "BG"
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If
        strQuery = "usp_sel_OrganizationUnits_LevelWise_RCV " + strBGID + "," + Session("intUserID").ToString
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("LocationID"), String) + "$___#" + CType(dr("Location"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetOUWiseDU() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strOUID As String
        Dim strBGID As String
        Dim strJscript As String = "OU"

        If Request.QueryString("OUID") Is Nothing OrElse Request.QueryString("OUID") = "" Then
            strOUID = "NULL"
        Else
            strOUID = Request.QueryString("OUID")
        End If
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If

        strQuery = "usp_sel_DeliveryUnits_LevelWise_RCV " + strBGID + "," + strOUID + "," + Session("intUserID").ToString
        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("ResourcePoolID"), String) + "$___#" + CType(dr("ResourcePoolName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Private Function GetDUWiseDT() As String
        Dim dr As IDataReader
        Dim strQuery As String
        Dim strDUID As String
        Dim strOUID As String
        Dim strBGID As String

        Dim strJscript As String = "DU"
        If Request.QueryString("DUID") Is Nothing OrElse Request.QueryString("DUID") = "" Then
            strDUID = "NULL"
        Else
            strDUID = Request.QueryString("DUID")
        End If
        If Request.QueryString("OUID") Is Nothing OrElse Request.QueryString("OUID") = "" Then
            strOUID = "NULL"
        Else
            strOUID = Request.QueryString("OUID")
        End If
        If Request.QueryString("BGID") Is Nothing OrElse Request.QueryString("BGID") = "" Then
            strBGID = "NULL"
        Else
            strBGID = Request.QueryString("BGID")
        End If


        strQuery = "usp_sel_DeliveryTeams_LevelWise_RCV " + strBGID + "," + strOUID + "," + strDUID + "," + Session("intUserID").ToString

        dr = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        While dr.Read
            strJscript = strJscript + "$___#" + CType(dr("GroupID"), String) + "$___#" + CType(dr("GroupName"), String)
        End While

        CommonFunctions.Data.DisposeDataReader(dr)
        Return strJscript
    End Function
    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.HR_ResourceCalendarView", "AppResources")
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")
        m_strPageCaption = MyBase.GetResourceString("PAGE_CAPTION")
    End Sub
#End Region
    Private Sub BuildFilterString()

        Dim strFilterQuery As String
        Dim dr As IDataReader

        strFilterQuery = "usp_Sel_AppliedFilterString '" & m_strEmployeeID & "'," & m_strRoleID & "," & m_strDesignationID _
                            & "," & m_strSkillID & "," & m_strBGID & "," & m_strOUID & "," & m_strDUID _
                            & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID _
                            & ",'" & m_strDeployable & "'," & m_strResourcePoolID & ",'" & strFrom & "'"

        dr = CommonFunction.Data.GetDataReader(strFilterQuery, MyBase.UseSQL)
        While dr.Read
            strAppliedFilters = CType(dr("FilterString"), String)
            strResourcePoolName = CType(CommonFunction.Data.CheckIsDBNull(dr("ResourcePoolName"), ""), String)
        End While
        CommonFunctions.Data.DisposeDataReader(dr)
        If strAppliedFilters = "" Then
            strAppliedFilters = "None"
        End If

    End Sub
    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    ''Added by Yogesh J on 05-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_LoadHrsDetails_OnClick(EmployeeID As String, StartDate As String, EndDate As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        StartDate = Utilities.Security.SecurityBuilder.CheckUserInput(StartDate, 2, True, False, False)
        EndDate = Utilities.Security.SecurityBuilder.CheckUserInput(EndDate, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page

        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(StartDate, String) + CType(EndDate, String) + "0" + "0")
            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of addition by Yogesh J on 05-Feb-2016
    ''Added by Dhanashri S on 28 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateTaskToken(EmployeeID As String, FromDate As String, ToDate As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        FromDate = Utilities.Security.SecurityBuilder.CheckUserInput(FromDate, 2, True, False, False)
        ToDate = Utilities.Security.SecurityBuilder.CheckUserInput(ToDate, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(FromDate, String) + CType(ToDate, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of Addition by Dhanashri S on 28 Mar 2016
    ''Added by Dhanashri S on 28 Mar 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateResUtilToken(EmployeeID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request found"
        End Try


    End Function
    ''End of Addition by Dhanashri S on 28 Mar 2016

    ''Added by Dhanashri S on 2 Aug 2016 Purpose:to generate and validate Token
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateProjectAllocationToken(EmployeeID As String, BGID As String, OUID As String, DUID As String, DTID As String, DeptID As String, RoleID As String, DesignationID As String, SkillID As String, ResourcePoolID As String) As String
        ''Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        EmployeeID = Utilities.Security.SecurityBuilder.CheckUserInput(EmployeeID, 2, True, False, False)
        BGID = Utilities.Security.SecurityBuilder.CheckUserInput(BGID, 2, True, False, False)
        OUID = Utilities.Security.SecurityBuilder.CheckUserInput(OUID, 2, True, False, False)
        DUID = Utilities.Security.SecurityBuilder.CheckUserInput(DUID, 2, True, False, False)
        DTID = Utilities.Security.SecurityBuilder.CheckUserInput(DTID, 2, True, False, False)
        DeptID = Utilities.Security.SecurityBuilder.CheckUserInput(DeptID, 2, True, False, False)
        RoleID = Utilities.Security.SecurityBuilder.CheckUserInput(RoleID, 2, True, False, False)
        DesignationID = Utilities.Security.SecurityBuilder.CheckUserInput(DesignationID, 2, True, False, False)
        SkillID = Utilities.Security.SecurityBuilder.CheckUserInput(SkillID, 2, True, False, False)
        ResourcePoolID = Utilities.Security.SecurityBuilder.CheckUserInput(ResourcePoolID, 2, True, False, False)
        Dim request = HttpContext.Current.Request
        Dim response = HttpContext.Current.Response
        'Commented by Vishal Mane on 03/06/2026 to apply Rate Limit on Save/Update/Delete methods only
        'If CommonFunction.RateLimiter.CheckRateLimit(request) Then
        '    response.StatusCode = 429
        '    response.Write("Bad Request found")
        '    Return "Bad Request found"
        'End If
        ''End of Added By Vyankat B. on 28th April 2026 for SQL Injection and Rate Limiting in Login Page
        Try

            Dim m_GenrateProjectAllocationToken As String
            m_GenrateProjectAllocationToken = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(BGID, String) + CType(OUID, String) + CType(DUID, String) + CType(DTID, String) + CType(DeptID, String) + CType(RoleID, String) + CType(DesignationID, String) + CType(SkillID, String) + CType(ResourcePoolID, String) + "0" + "0")

            Return m_GenrateProjectAllocationToken

        Catch ex As Exception
            Return "Bad Request found"
        End Try

    End Function
    ''End of Addition by Dhanashri S on 2 Aug 2016
End Class
