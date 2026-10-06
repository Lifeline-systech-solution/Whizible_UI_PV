
Public Class HR_BenchAndTrainingGantt
    Inherits WebPage.Templates.WhizTemplate
    '=====================================================================
    ' Class	Name	        :	HR_BenchAndTrainingGantt
    ' Purpose				:	Page for Bench and training gantt
    ' Description			:	Same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SuchitraP
    ' Created				:	Jan 29,2008
    ' Revisions				:	
    '=====================================================================
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

    Private tblHTML As System.Text.StringBuilder = New System.Text.StringBuilder
    Private ExpectedStartDate As String = ""
    Private ExpectedEndDate As String = ""
    Private arrStartDate As ArrayList
    Private arrEndDate As ArrayList
    Private strRecPKID As String
    Private arrBTStartDate As ArrayList
    Private arrBTEndDate As ArrayList
    Private arrBTtype As ArrayList
    Private m_intTotalNoOfRows As Integer
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
    Private strAppliedFilters As String = "None"
    Private YearIncrement As Integer

    Protected m_intPageNumber As Integer = 1
    Protected m_strEmployeeID As String
    Protected m_CurrYear As Integer

    

    Protected Sub BuildPage()
        Call SetVariables()
        Response.Write(GenerateMenu(True))
        Response.Write("<BR>")
        Call GenerateFilterMenu()
        Response.Write("<BR>")
        Response.Write(GenerateLegends())
        Response.Write("<BR>")
        Call DiplayTables()
        Response.Write(GenerateMenu(False))

    End Sub
    Private Sub SetVariables()
        '=====================================================================
        ' Procedure Name        : SetVariables()	
        ' Purpose               : Set variable values (QueryString and form references)
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Jan 10, 2008
        ' Revisions             :
        '=====================================================================

        If Request.Form("YearIncr") Is Nothing Then
            YearIncrement = 0
        Else
            YearIncrement = CType(Request.Form("YearIncr"), Integer)
        End If

        'EmployeeID
        If Request.Form("txtResource") <> "" Then
            m_strEmployeeID = CType(Request.Form("txtResource"), String)
        Else
            m_strEmployeeID = ""
        End If

        'Role ID
        If Request.Form("cboRole") <> "" Then
            m_strRoleID = CType(Request.Form("cboRole"), String)
        Else
            m_strRoleID = "NULL"
        End If

        'DesignationID
        If Request.Form("cboDesignation") <> "" Then
            m_strDesignationID = CType(Request.Form("cboDesignation"), String)
        Else
            m_strDesignationID = "NULL"
        End If

        'Skill ID
        If Request.Form("cboSkill") <> "" Then
            m_strSkillID = CType(Request.Form("cboSkill"), String)
        Else
            m_strSkillID = "NULL"
        End If


        'BG ID
        If Request.Form("cboBG") <> "" Then
            m_strBGID = CType(Request.Form("cboBG"), String)
        Else
            m_strBGID = "NULL"
        End If
        'OU ID
        If Request.Form("cboOU") <> "" Then
            m_strOUID = CType(Request.Form("cboOU"), String)
        Else
            m_strOUID = "NULL"
        End If

        'DU
        If Request.Form("cboDU") <> "" Then
            m_strDUID = CType(Request.Form("cboDU"), String)
        Else
            m_strDUID = "NULL"
        End If
        'DT
        If Request.Form("cboDT") <> "" Then
            m_strDTID = CType(Request.Form("cboDT"), String)
        Else
            m_strDTID = "NULL"
        End If
        'Employee Type
        If Request.Form("cboEmpType") <> "" Then
            m_strEmpTypeID = CType(Request.Form("cboEmpType"), String)
        Else
            m_strEmpTypeID = ""
        End If

        'm_strDepartmentID

        If Request.Form("cboDepartment") <> "" Then
            m_strDepartmentID = CType(Request.Form("cboDepartment"), String)
        Else
            m_strDepartmentID = "NULL"
        End If

        'Deployable
        m_strDeployable = CType(Request.Form("cboDeployable"), String)

        If m_strDeployable Is Nothing Then
            m_strDeployable = ""
        End If

        'ResourcePoolID
        If Request.Form("cboResourcePool") <> "" Then
            m_strResourcePoolID = CType(Request.Form("cboResourcePool"), String)
        Else
            m_strResourcePoolID = "NULL"
        End If

        If Not Request.QueryString("PageNumber") Is Nothing AndAlso Request.QueryString("PageNumber") <> "" Then
            m_intPageNumber = CType(Request.QueryString("PageNumber"), Integer)
        End If

        tblHTML.Append("<input type=hidden name=YearIncr id=YearIncr value=" + YearIncrement.ToString + ">")

        'Context menu 
        CommonFunction.General.WriteHTML("<Div id='divContextMenu' class='DropdownMenu'>")
        CommonFunction.General.WriteHTML("<Table cellspacing='0' cellpadding='3' >")
        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdResourceUtilization' title='Resource Utilization' >&nbsp;&nbsp;&nbsp;Resource Utilization")
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")

        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdProjectAllocation' title='Project Allocation' >&nbsp;&nbsp;&nbsp;Project Allocation")
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")

        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdSkillView' title='Gantt View' >&nbsp;&nbsp;&nbsp;Skill Details")
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("<TR><td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td class='CtMn_Hr'></td></tr>")

        CommonFunction.General.WriteHTML("<tr class='MenuSelected_Normal' onMouseOver=this.className='MenuSelected_hover' onmouseout =this.className='MenuSelected_Normal'>")
        CommonFunction.General.WriteHTML("<td class='CtMn_LeftFill' ></td>")
        CommonFunction.General.WriteHTML("<td id='tdViewDetails' title='View Details' >&nbsp;&nbsp;&nbsp;View Details")
        CommonFunction.General.WriteHTML("</td></tr>")
        CommonFunction.General.WriteHTML("</table></Div>")
    End Sub

    Private Function GenerateLegends() As String
        CommonFunction.General.WriteHTML("<Table id=tblLegend class='clsTable' border = 0 width=100% cellspacing=0 cellpadding = 0>")
        CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption colspan=13>")
        CommonFunction.General.WriteHTML("<TD align=left>Bench And Training Gantt</TD>")
        CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD>&nbsp;</TD>")
        CommonFunction.General.WriteHTML("<TD align=left>Legends : </TD>")
        CommonFunction.General.WriteHTML("<TD align=right bgcolor='#0000dc' width=6px height=3px></TD>")
        CommonFunction.General.WriteHTML("<TD align=left>Allocated</TD>")
        CommonFunction.General.WriteHTML("<TD align=right bgcolor='#ca38d6' width=6px height=3px></TD>")
        CommonFunction.General.WriteHTML("<TD align=left>Training</TD>")
        CommonFunction.General.WriteHTML("<TD align=right bgcolor='SeaGreen' width=6px height=3px></TD>")
        CommonFunction.General.WriteHTML("<TD align=left>Bench</TD>")
        'CommonFunction.General.WriteHTML("<TD align=right bgcolor='#cb1d3f' width=6px height=3px></TD>")
        'CommonFunction.General.WriteHTML("<TD align=left>Leave</TD>")
        CommonFunction.General.WriteHTML("</TR>")
        CommonFunction.General.WriteHTML("</Table>")

    End Function

    Private Sub GenerateFilterMenu()
        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")

        'Resource text
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right'align=right>Resource")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        'Commented and added by Shamkant s for HTML encoding Date:06/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtResource", "txtResource", , 200, 50, m_strEmployeeID, EnableHTMLEncode:=True)
        'ended by Shamkant s  for HTML encoding Date:06/10/15
        CommonFunctions.General.WriteHTML("</td>")

        'For Role Filter
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Role")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left>")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboRole", "Select RoleID, RoleDescription From tbl_PM_Role Where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_RoleID_tbl_PM_Role", 200, m_strRoleID.ToString, , True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td></TR>")

        'For Designation Filter
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Designation")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "select DesignationID,DesignationName from tbl_PM_DesignationMaster ORDER BY DesignationName", 200, m_strDesignationID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDesignation", "usp_sel_tbl_PM_DesignationMaster_DesignationName", 200, m_strDesignationID.ToString, , True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td>")

        'For PrimarySkills
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Skill")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "select distinct T.ToolID,[Description] from tbl_PM_Tools T ORDER BY [Description]", 200, m_strSkillID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "usp_sel_tbl_PM_Tools_ToolID_Description", 200, m_strSkillID.ToString, , True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td></TR>")

        'For BG Filter 
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Business Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboBG", "select BusinessGroupID,BusinessGroup,Active FROM tbl_CNF_BusinessGroups  ORDER BY BusinessGroup", 200, m_strBGID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_tbl_CNF_BusinessGroups_Active", 200, m_strBGID.ToString, , True)
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td>")

        'For OU Filter 
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Organization Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboOU", "select LocationID,Location FROM tbl_PM_Location  ORDER BY Location", 200, m_strOUID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_tbl_PM_Location_Location", 200, m_strOUID.ToString, , True)
        ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td></TR>")

        'For DU Filter
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Delivery Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboDU", "Select ResourcePoolID, ResourcePoolName	From tbl_PM_ResourcePool Order By ResourcePoolName", 200, m_strDUID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDU", "usp_sel_tbl_PM_ResourcePool_ResourcePoolID", 200, m_strDUID.ToString, , True)
        ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td>")

        'For DT Filter
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Delivery Team")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        '' CommonFunctions.HTMLControls.DrawComboBox("cboDT", "Select GroupID,GroupName From tbl_PM_GroupMaster Order By GroupName", 200, m_strDTID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDT", "usp_sel_tbl_PM_GroupMaster_GroupID", 200, m_strDTID.ToString, , True)
        CommonFunctions.General.WriteHTML("</td></TR>")
        ''end of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        'Employee Type
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Employee Type")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboEmpType", "usp_Sel_tbl_RTS_ProjectSpecificControlData  'EmployeeType'", 200, m_strEmpTypeID.ToString, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'For Department
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Department")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "SELECT DepartmentID,Department FROM tbl_pm_Departmentmaster ORDER BY Department", 200, m_strDepartmentID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_sel_Department_tbl_pm_Departmentmaster", 200, m_strDepartmentID.ToString, , True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td></TR>")

        'Deployable
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Deployable")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboDeployable", "SELECT 'N','No' UNION SELECT 'D','Yes' ORDER BY 2", 200, m_strDeployable, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Resource Pool
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' >Resource Pool")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
        ''Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        ''CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "SELECT ResourcePoolID,ResourcePoolName FROM tbl_PM_ResourcePoolMaster ORDER BY ResourcePoolName", 200, m_strResourcePoolID, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboResourcePool", "usp_sel_tbl_PM_ResourcePoolMaster_ResourcePoolID", 200, m_strResourcePoolID, , True)
        ''End of Commented and added by Nilesh g on 8/8/2016 Purpose:Remove Inline Query
        CommonFunctions.General.WriteHTML("</td></TR>")

        'Apply Button
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        CommonFunctions.General.WriteHTML("<input type=button id=btnApply onclick='applyFilter()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML("<input type=button id=btnClose onclick='ClearFilter()' value=""Clear""></TD>")
        CommonFunctions.General.WriteHTML("</TR></TABLE>")




    End Sub
    Private Function GenerateMenu(ByVal pos As Boolean) As String
        '=====================================================================
        ' function Name         : GenerateTopMenu()	
        ' Purpose               : To generate top menu
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : Jan 31, 2008
        ' Revisions             :
        '=====================================================================

        Dim ArrTopMenuCaptionsList As New ArrayList
        Dim ArrTopMenuToolTipsList As New ArrayList
        Dim ArrTopMenuFunctionsList As New ArrayList

        ArrTopMenuCaptionsList.Add("Previous")
        ArrTopMenuToolTipsList.Add("Previous")
        ArrTopMenuFunctionsList.Add("Previous_OnClick()")

        ArrTopMenuCaptionsList.Add("Next")
        ArrTopMenuToolTipsList.Add("Next")
        ArrTopMenuFunctionsList.Add("Next_OnClick()")

        If pos Then
            ArrTopMenuCaptionsList.Add("<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif'")
            ArrTopMenuToolTipsList.Add("Filter")
            ArrTopMenuFunctionsList.Add("showFilters(1)")
        End If

        ArrTopMenuCaptionsList.Add("Add")
        ArrTopMenuToolTipsList.Add("Add")
        ArrTopMenuFunctionsList.Add("Add_OnClick()")

        ArrTopMenuCaptionsList.Add("?")
        ArrTopMenuToolTipsList.Add("Help")
        ArrTopMenuFunctionsList.Add("Help_OnClick('3867')")

        Dim ArrTopMenuCaptions(ArrTopMenuCaptionsList.Count - 1) As String
        ArrTopMenuCaptionsList.ToArray.CopyTo(ArrTopMenuCaptions, 0)
        ArrTopMenuCaptionsList = Nothing

        Dim ArrTopMenuToolTips(ArrTopMenuToolTipsList.Count - 1) As String
        ArrTopMenuToolTipsList.ToArray.CopyTo(ArrTopMenuToolTips, 0)
        ArrTopMenuToolTipsList = Nothing

        Dim ArrTopMenuFunctions(ArrTopMenuFunctionsList.Count - 1) As String
        ArrTopMenuFunctionsList.ToArray.CopyTo(ArrTopMenuFunctions, 0)
        ArrTopMenuFunctionsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrTopMenuCaptions, ArrTopMenuFunctions, ArrTopMenuToolTips, True)

    End Function

    Private Sub DiplayTables()

        Dim drMonth As IDataReader
        Dim drBench As IDataReader
        Dim Iterator As Integer
        Dim strMonthQuery As String
        Dim GantView_StartDt As Date
        Dim GantView_EndDt As Date
        Dim Record_StartDt As Date
        Dim Record_EndDt As Date
        Dim StartMonth As Integer
        Dim EndMonth As Integer
        Dim StartYear As Integer
        Dim EndYear As Integer
        Dim counter As Integer = 0
        Dim strSQLPer As String
        Dim strSQLBT As String
        Dim strSQL As String
        Dim ReadCount As Integer
        Dim strEmployeeID As String
        Dim drProjEmpRole As IDataReader
        Dim drBenchTrain As IDataReader
        Dim strFirstColumnHTML As String
        Dim MonDiff As Integer
        Dim strClass As String = "clsTREven"


        strEmployeeID = HttpContext.Current.Request.Form("txtResource")

        strMonthQuery = "usp_Sel_BenchAndTraining_YrIncrement " + YearIncrement.ToString

        drMonth = CommonFunctions.Data.GetDataReader(strMonthQuery, MyBase.UseSQL)

        If drMonth.Read Then
            GantView_StartDt = CType(drMonth("StartDate"), Date)
            GantView_EndDt = CType(drMonth("EndDate"), Date)
            MonDiff = CType(drMonth("MonDiff"), Integer)
        End If


        StartMonth = GantView_StartDt.Month
        EndMonth = GantView_EndDt.Month


        tblHTML.Append("<DIV id=divList style=""width:100%;height:360;OverFlow:auto"" >")
        tblHTML.Append("<table style=""border-right: thin solid gray;border-bottom: thin solid gray;border-left: thin solid gray;border-top: thin solid gray""  id='tblMain' border = 0 width=100% cellspacing=0 cellpadding = 0 >" + vbCrLf)
        tblHTML.Append("<TR class='clsTRColumnHeader' >")
        tblHTML.Append("<TD id='Resource' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray""> Resource </TD>" + vbCrLf)
        Iterator = 1

        StartYear = GantView_StartDt.Year

        While Iterator <= MonDiff
            Select Case StartMonth
                Case 1
                    tblHTML.Append("<TD id='Month1' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Jan(" + StartYear.ToString + ") </TD>" + vbCrLf)
                Case 2
                    tblHTML.Append("<TD id='Month2' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Feb(" + StartYear.ToString + ") </TD>" + vbCrLf)
                Case 3
                    tblHTML.Append("<TD id='Month3' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Mar(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 4
                    tblHTML.Append("<TD id='Month4' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Apr(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 5
                    tblHTML.Append("<TD id='Month5' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > May(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 6
                    tblHTML.Append("<TD id='Month6' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Jun(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 7
                    tblHTML.Append("<TD id='Month7' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Jul(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 8
                    tblHTML.Append("<TD id='Month8' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Aug(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 9
                    tblHTML.Append("<TD id='Month9' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Sep(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 10
                    tblHTML.Append("<TD id='Month10' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Oct(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 11
                    tblHTML.Append("<TD id='Month11' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Nov(" + StartYear.ToString + ")</TD>" + vbCrLf)
                Case 12
                    tblHTML.Append("<TD id='Month12' align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > Dec(" + StartYear.ToString + ")</TD>" + vbCrLf)
            End Select
            If StartMonth = 12 Then
                StartMonth = 1
                StartYear += 1
            Else
                StartMonth = StartMonth + 1
            End If
            Iterator += 1
        End While

        tblHTML.Append("</TR>" + vbCrLf)

        strSQL = "usp_Sel_Count_Resources_BenchAndTraining '" & strEmployeeID & "'," & m_strRoleID & "," & m_strDesignationID & "," & m_strSkillID & "," & m_strBGID & "," & m_strOUID & "," & m_strDUID & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID & ",'" & m_strDeployable & "'," & m_strResourcePoolID & ",'" & GantView_StartDt & "','" & GantView_EndDt & "'"

        'To Build applied Filters string 
        Call BuildFilterString()

        Call WritePaging(strSQL)
        strSQL = "usp_Sel_Resources_BenchAndTraining " & m_intPageNumber.ToString() & ",'" & strEmployeeID & "'," & m_strRoleID & "," & m_strDesignationID & "," & m_strSkillID & "," & m_strBGID & "," & m_strOUID & "," & m_strDUID & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID & ",'" & m_strDeployable & "'," & m_strResourcePoolID & ",'" & GantView_StartDt & "','" & GantView_EndDt & "'"

        drBench = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If m_intPageNumber > 0 Then
            For ReadCount = 1 To (20 * (m_intPageNumber - 1))
                drBench.Read()
            Next
        End If

        While drBench.Read()
            strRecPKID = CType(drBench("EmployeeID"), String)
            strFirstColumnHTML = CType(drBench("EmployeeName"), String)
            Record_StartDt = GantView_StartDt
            Record_EndDt = GantView_EndDt

            'To view records of Employee allocated on projects
            strSQLPer = "usp_Sel_tbl_PM_ProjectEmployeeRole_BenchTraining " + CType(drBench("EmployeeID"), String)
            drProjEmpRole = CommonFunction.Data.GetDataReader(strSQLPer, MyBase.UseSQL)
            arrStartDate = New ArrayList
            arrEndDate = New ArrayList
            While drProjEmpRole.Read
                arrStartDate.Add(CType(drProjEmpRole("ExpectedStartDate"), Date))
                arrEndDate.Add(CType(drProjEmpRole("ExpectedEndDate"), Date))

            End While
            CommonFunction.Data.DisposeDataReader(drProjEmpRole)
            'To view records of Bench and Training employee's
            'Commented to consider bench history records also
            'strSQLBT = "SELECT FromDate,ToDate,Type FROM tbl_PM_BenchAndTraining WHERE EmployeeID=" + CType(drBench("EmployeeID"), String)
            strSQLBT = "usp_sel_tbl_PM_BenchResources_FromToDate " + CType(drBench("EmployeeID"), String)
            drBenchTrain = CommonFunction.Data.GetDataReader(strSQLBT, MyBase.UseSQL)
            arrBTStartDate = New ArrayList
            arrBTEndDate = New ArrayList
            arrBTtype = New ArrayList
            While drBenchTrain.Read
                arrBTStartDate.Add(CType(CommonFunction.Data.CheckIsDBNull(drBenchTrain("FromDate"), ""), Date))
                arrBTEndDate.Add(CType(CommonFunction.Data.CheckIsDBNull(drBenchTrain("ToDate"), GantView_EndDt.ToString), Date))
                arrBTtype.Add(CType(drBenchTrain("Type"), String))
            End While
            CommonFunction.Data.DisposeDataReader(drBenchTrain)
            StartMonth = GantView_StartDt.Month
            EndMonth = GantView_EndDt.Month
            StartYear = GantView_StartDt.Year
            EndYear = GantView_EndDt.Year
            'StartMonth = Record_StartDt.Month
            'EndMonth = Record_EndDt.Month
            Dim year As Integer = StartYear

            If strClass = "clsTROdd" Then
                strClass = "clsTREven"
            Else
                strClass = "clsTROdd"
            End If
            tblHTML.Append("<TR class='" + strClass + "' style='PADDING-RIGHT: 0pt; PADDING-LEFT: 0pt; PADDING-BOTTOM: 0pt; PADDING-TOP: 0pt;height=25px' >")

            tblHTML.Append(DrawFirstColumn(strFirstColumnHTML))
            'tblHTML.Append("<TD align=center style=""border-right: thin solid gray;border-bottom: thin solid gray"" > " + strRole + " <BR> " + strSkill + " </TD>" + vbCrLf)

            Iterator = 1

            While Iterator <= MonDiff
                'tblHTML.Append("<TD style=""border-bottom: thin solid gray"" id='MonthValues" + CType(jMonCounter, String) + "'>" + vbCrLf)
                tblHTML.Append("<TD >" + vbCrLf)
                'Jan

                Select Case StartMonth
                    Case 1
                        Call DrawJan(strRecPKID, year)
                    Case 2
                        Call DrawFeb(strRecPKID, year)
                    Case 3
                        Call DrawMar(strRecPKID, year)
                    Case 4
                        Call DrawApr(strRecPKID, year)
                    Case 5
                        Call DrawMay(strRecPKID, year)
                    Case 6
                        Call DrawJun(strRecPKID, year)
                    Case 7
                        Call DrawJul(strRecPKID, year)
                    Case 8
                        Call DrawAug(strRecPKID, year)
                    Case 9
                        Call DrawSep(strRecPKID, year)
                    Case 10
                        Call DrawOct(strRecPKID, year)
                    Case 11
                        Call DrawNov(strRecPKID, year)
                    Case 12
                        Call DrawDec(strRecPKID, year)
                End Select
                'jMonCounter += 1
                tblHTML.Append("</TD>" + vbCrLf)

                If StartMonth = 12 Then
                    year = year + 1
                    StartMonth = 1
                Else
                    StartMonth = StartMonth + 1
                End If
                Iterator += 1

            End While 'End of Month while Loop

            tblHTML.Append("</TR>" + vbCrLf)

            arrStartDate = Nothing
            arrEndDate = Nothing
            arrBTStartDate = Nothing
            arrBTEndDate = Nothing
            arrBTtype = Nothing

        End While



        'End of While loop

        tblHTML.Append("</Table>" + vbCrLf)
        tblHTML.Append("</DIV>" + vbCrLf)

        CommonFunctions.General.WriteHTML(tblHTML.ToString())
        CommonFunctions.Data.DisposeDataReader(drProjEmpRole)
        CommonFunctions.Data.DisposeDataReader(drMonth)
        CommonFunctions.Data.DisposeDataReader(drBench)
        CommonFunctions.Data.DisposeDataReader(drBenchTrain)
        tblHTML = Nothing

    End Sub
    Private Function DrawFirstColumn(ByVal strColumnHTML As String, Optional ByVal stringTobeInsertedInTD As String = "align=center style='border-right: thin solid gray;border-bottom: thin solid gray'") As String
        'DrawFirstColumn = "<TD " + stringTobeInsertedInTD + " nowrap=false style='TEXT-ALIGN: left'> <A  HREF=""Javascript:ShowContextMenu(event,this," + strRecPKID + ")"" >" + strColumnHTML + "</A> </TD>" + vbCrLf
        DrawFirstColumn = "<TD " + stringTobeInsertedInTD + " nowrap=false style='TEXT-ALIGN: left' onMouseOver=this.style.cursor='hand' onclick='ShowContextMenu(event,this," + strRecPKID + ")'><U>" + strColumnHTML + "</U></TD>" + vbCrLf

    End Function
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
        ''ended by Shamkant s  for HTML encoding Date:06/10/15
        Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'>")

        'For Applied Filters
        If Trim(strAppliedFilters & "") <> "" Then
            If strAppliedFilters.Length > 50 Then
                strAppliedFilters = strAppliedFilters.Substring(0, 50)
            End If

            If strAppliedFilters = "None" Then
                Response.Write("<td align=left>Current Filter : None")
            Else
                Response.Write("<td align=left>Current Filter : <A href='javascript:showFilters(1)' >" + strAppliedFilters + "</A>")
                If strAppliedFilters <> "None" Then
                    Response.Write("<img id='imgFilter' style='text-decoration:none;cursor:hand;' border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
                End If
                Response.Write("</td>")
            End If

        End If
        'End of Applied Filters


        If Trim(strPaging & "") <> "" Then
            'Response.Write("<Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTRMenu'><td align=right>" + strPaging + "</TD></TR></Table>")
            Response.Write("<td align=right>" + strPaging + "</TD>")
        End If

        Response.Write("</TR></TABLE>")

    End Sub
    Private Sub BuildFilterString()
        Dim strFilterQuery As String
        Dim dr As IDataReader

        strFilterQuery = "usp_Sel_AppliedFilter_BenchAndTraining '" & m_strEmployeeID & "'," & m_strRoleID & "," & m_strDesignationID _
                            & "," & m_strSkillID & "," & m_strBGID & "," & m_strOUID & "," & m_strDUID _
                            & "," & m_strDTID & ",'" & m_strEmpTypeID & "'," & m_strDepartmentID _
                            & ",'" & m_strDeployable & "'," & m_strResourcePoolID

        dr = CommonFunction.Data.GetDataReader(strFilterQuery, MyBase.UseSQL)
        While dr.Read
            strAppliedFilters = CType(dr("FilterString"), String)

        End While
        CommonFunction.Data.DisposeDataReader(dr)
        If strAppliedFilters = "" Then
            strAppliedFilters = "None"
        End If

    End Sub
    Private Sub DrawJan(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer
        Dim i As Integer

        'Table to show working details
        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<TR>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 1, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If

        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 1, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next
        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)
        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)

        tblHTML.Append("<TR>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 1, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If

        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 1, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next
        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<TR>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 1, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If

        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 1, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If

                TodaysDate = Nothing
            Next
        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

    End Sub

    Private Sub DrawFeb(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim FebDays As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'For Leap Year
        If Date.IsLeapYear(Year) Then
            FebDays = 29
        Else
            FebDays = 28
        End If

        'Table to show leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<TR>" + vbCrLf)

        For cntDay = 1 To FebDays
            TodaysDate = New Date(Year, 2, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If

        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=" + CType(FebDays, String) + "></td>" + vbCrLf)
        Else
            For cntDay = 1 To FebDays
                TodaysDate = New Date(Year, 2, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<TR>" + vbCrLf)

        For cntDay = 1 To FebDays
            TodaysDate = New Date(Year, 2, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing

            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=" + CType(FebDays, String) + "></td>" + vbCrLf)
        Else
            For cntDay = 1 To FebDays
                TodaysDate = New Date(Year, 2, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<TR>" + vbCrLf)

        For cntDay = 1 To FebDays
            TodaysDate = New Date(Year, 2, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing

            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=" + CType(FebDays, String) + "></td>" + vbCrLf)
        Else
            For cntDay = 1 To FebDays
                TodaysDate = New Date(Year, 2, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        
    End Sub

    Private Sub DrawMar(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show Leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 3, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing

            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 3, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next
        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 3, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 3, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 3, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing

            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 3, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        
    End Sub

    Private Sub DrawApr(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer


        'Table for Leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 4, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing

            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 4, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)
        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 4, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 4, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)
        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 4, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 4, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)



    End Sub

    Private Sub DrawMay(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)
        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 5, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 5, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 5, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 5, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 5, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 5, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        
    End Sub

    Private Sub DrawJun(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show Leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 6, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 6, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)


        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 6, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 6, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)


        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 6, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 6, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        

    End Sub

    Private Sub DrawJul(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31

            TodaysDate = New Date(Year, 7, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD

            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 7, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)


        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 7, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 7, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If

                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 7, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 7, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        
    End Sub
    Private Sub DrawAug(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details
        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 8, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 8, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 8, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD

            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 8, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 8, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 8, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        

    End Sub

    Private Sub DrawSep(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details
        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 9, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 9, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 9, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 9, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%' ></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 9, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 9, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        
    End Sub
    Private Sub DrawOct(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 10, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 10, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 10, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 10, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 10, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 10, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        

    End Sub
    Private Sub DrawNov(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details

        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 11, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 11, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 11, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 11, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 30
            TodaysDate = New Date(Year, 11, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=30></td>" + vbCrLf)
        Else
            For cntDay = 1 To 30
                TodaysDate = New Date(Year, 11, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        


    End Sub

    Private Sub DrawDec(ByVal strPKID As String, ByVal Year As Integer)
        Dim cntDay As Integer
        Dim strFillColor As String = "white"
        Dim TodaysDate As Date
        Dim cntStartDate As Integer
        Dim counter As Integer

        'Table to show leave details
        tblHTML.Append("<TABLE id='tblWork' height='80%' border=0 width=100% cellpadding='0' cellspacing='0'>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 12, cntDay)
            strFillColor = "white"
            For cntStartDate = 0 To arrStartDate.Count - 1
                If CType(arrStartDate(cntStartDate), Date) <= TodaysDate And CType(arrEndDate(cntStartDate), Date) >= TodaysDate Then
                    strFillColor = "#0000dc"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#0000dc" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 12, cntDay)
                strFillColor = "white"
                For counter = 0 To arrStartDate.Count - 1
                    If CType(arrStartDate(counter), Date) <= TodaysDate And CType(arrEndDate(counter), Date) >= TodaysDate Then
                        strFillColor = "#0000dc"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show training details
        'tblHTML.Append("<TABLE id='tblTrain' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 12, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Train" Then
                    strFillColor = "#ca38d6"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "#ca38d6" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='20%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 12, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Train" Then
                        strFillColor = "#ca38d6"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)

        'Table to show Bench details
        'tblHTML.Append("<TABLE id='tblBench' border=0 width=100% cellspacing=0>" + vbCrLf)

        'tblHTML.Append("<TR width=33% Year='" + Year.ToString + "' height=2px>" + vbCrLf)
        'tblHTML.Append("<table width='100%' height = '60%' cellpadding='0' cellspacing='0'>")
        tblHTML.Append("<tr>" + vbCrLf)

        For cntDay = 1 To 31
            TodaysDate = New Date(Year, 12, cntDay)
            strFillColor = "white"

            For cntStartDate = 0 To arrBTStartDate.Count - 1
                If CType(arrBTStartDate(cntStartDate), Date) <= TodaysDate And CType(arrBTEndDate(cntStartDate), Date) >= TodaysDate And CType(arrBTtype(cntStartDate), String) = "Bench" Then
                    strFillColor = "SeaGreen"
                    Exit For
                End If
            Next
            'Added by PrashantD
            If strFillColor = "SeaGreen" Then
                Exit For
            End If
            'End of addition by PrashantD
            TodaysDate = Nothing
            'If strFillColor = "white" Then
            '    tblHTML.Append("<td height='60%'></td>" + vbCrLf)
            'Else
            '    tblHTML.Append("<TD height='60%' bgcolor=" + strFillColor + "></TD>" + vbCrLf)
            'End If
        Next
        If strFillColor = "white" Then
            tblHTML.Append("<td height='20%' colspan=31></td>" + vbCrLf)
        Else
            For cntDay = 1 To 31
                TodaysDate = New Date(Year, 12, cntDay)
                strFillColor = "white"
                For counter = 0 To arrBTStartDate.Count - 1
                    If CType(arrBTStartDate(counter), Date) <= TodaysDate And CType(arrBTEndDate(counter), Date) >= TodaysDate And CType(arrBTtype(counter), String) = "Bench" Then
                        strFillColor = "SeaGreen"
                        Exit For
                    End If
                Next
                If strFillColor <> "white" Then
                    tblHTML.Append("<TD height='20%' bgcolor='" + strFillColor + "'></TD>" + vbCrLf)
                Else
                    tblHTML.Append("<td height='20%'></td>" + vbCrLf)
                End If
                TodaysDate = Nothing
            Next

        End If
        tblHTML.Append("</tr>" + vbCrLf)
        tblHTML.Append("<tr><td height='20%'></td></tr>" + vbCrLf)
        tblHTML.Append("</table>" + vbCrLf)

        

    End Sub

End Class
