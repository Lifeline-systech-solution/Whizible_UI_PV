Public Class HR_ResourceDeamnd_ActivityPlan
    Inherits WebPages.Template.WhizTemplate

    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected m_strpaging As String
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

    Private m_strRoleID As String
    Private m_strSkillID As String
    Private strAppliedFilters As String = "None"
    Private m_strBGID As String
    Private m_strOUID As String
    Private m_strMode As String
    Protected IsRoleBase As String = "0"


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : Calls the private class ReportUI to generate the
        '                         UI for the report
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : ArchanaN
        ' Created               : 22 Dec 2007
        ' Revisions             :
        '=====================================================================

        If Request.QueryString("FromXML") = "1" Then
            Response.Clear()
            Response.Write(getToolTipInfo())
            Response.End()
        Else
            Initialize()
            If m_strMode = "" Then
                DrawTabs()
            Else

                Dim sbHTMLExcel As New StringBuilder
                IsRoleBase = CommonFunction.General.CheckIsNothing(Request.QueryString("ISRoleBase").ToString(), "0")
                sbHTMLExcel.Append("<div id='PageDiv' style='width:99.99%;height:450px;overflow:auto'>")
                sbHTMLExcel.Append("<table id='tbl_rad' style ='width:100%'  CellSpacing=1 CellPadding=0  class='clsGridTable' >")
                sbHTMLExcel.Append("<thead class='clsTRColumnHeader'>")
                sbHTMLExcel.Append("<th style='text-align:left'>Staffing Plan</th>")
                sbHTMLExcel.Append("</thead></table>")
                sbHTMLExcel.Append("<BR>")

                sbHTMLExcel.Append("<BR>")
                sbHTMLExcel.Append(DisplayGrid("1"))


                sbHTMLExcel.Append("</div>")
                ExporttoExcel(sbHTMLExcel.ToString)
                Response.End()
                sbHTMLExcel = Nothing
            End If
        End If


    End Sub
    Private Sub Initialize()
        If Request.QueryString("RoleID") <> "" Then
            m_strRoleID = CType(Request.QueryString("RoleID"), String)
        Else
            m_strRoleID = "NULL"
        End If
        'Skill ID
        If Request.QueryString("SkillID") <> "" Then
            m_strSkillID = CType(Request.QueryString("SkillID"), String)
        Else
            m_strSkillID = "NULL"
        End If

        If Not Request.Form("cboBG") Is Nothing OrElse Request.Form("cboBG") <> "" Then
            m_strBGID = Request.Form("cboBG")
        Else
            m_strBGID = "NULL"
        End If
        If m_strBGID = "" Then
            m_strBGID = "NULL"
        End If

        If Not Request.Form("cboOU") Is Nothing OrElse Request.Form("cboOU") <> "" Then
            m_strOUID = Request.Form("cboOU")
        Else
            m_strOUID = "NULL"
        End If
        If m_strOUID = "" Then
            m_strOUID = "NULL"
        End If
        If Request.QueryString("MODE") <> "" Then
            m_strMode = Request.QueryString("MODE")
        Else
            m_strMode = ""
        End If

        m_strpaging = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Paging"), "-1").ToUpper

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
        ' Author                : ArchanaN
        ' Created               : 17,Dec 2007
        ' Revisions             :
        '=====================================================================
        Dim objPaging As WebPage.Templates.Paging
        Dim strPagingHTML As String
        Dim strSQL As String

        CommonFunctions.General.WriteHTML("<table class='clsGridTable' cellspacing='0' cellpadding=0 border=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTRMenu' width=99.9% >")
        '--  Draw Paging with Menu 
        CommonFunctions.General.WriteHTML("<TD align=left>")
        Dim strAlpha As String = m_strpaging
        If strAlpha <> "" Then
            If strAlpha.ToUpper = "AND" Then
                strAlpha = "&"
            End If
        End If
        If Request.QueryString("RoleID") <> "" Then
            m_strRoleID = CType(Request.QueryString("RoleID"), String)
        Else
            m_strRoleID = "NULL"
        End If
        'Skill ID
        If Request.QueryString("SkillID") <> "" Then
            m_strSkillID = CType(Request.QueryString("SkillID"), String)
        Else
            m_strSkillID = "NULL"
        End If

        'Added by ShraddhaM on 15,Feb 2008
        'Purpose : When we apply filters then paging not getting change.
        m_strRoleID = CommonFunctions.General.CheckIsNothing(Request.Form("cboRole"), "NULL")
        m_strSkillID = CommonFunctions.General.CheckIsNothing(Request.Form("cboSkill"), "NULL")

        If m_strRoleID = "" Then
            m_strRoleID = "NULL"
        End If
        If m_strSkillID = "" Then
            m_strSkillID = "NULL"
        End If
        'Commented and modified by SanaS on 23-Oct-2009
        If Not Request.Form("optRoleBase") Is Nothing OrElse Request.Form("optRoleBase") <> "" Then
            IsRoleBase = Request.Form("optRoleBase").ToString()
        End If
        'strSQL = "usp_Sel_Month_tbl_RM_Pipeline_paging " & m_strRoleID & "," & m_strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID
        strSQL = "usp_Sel_Month_tbl_RM_Pipeline_paging " & m_strRoleID & "," & m_strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBase
        'End Comment and modification by SanaS on 23-Oct-2009
        'display the paging links on the menu bar
        objPaging = New WebPage.Templates.Paging
        strPagingHTML = objPaging.DrawPaging(strAlpha, strSQL, "Select", "Page_OnClick", "Role", True)
        CommonFunctions.General.WriteHTML(strPagingHTML)
        objPaging = Nothing
        CommonFunctions.General.WriteHTML("</TD>")

        CommonFunctions.General.WriteHTML("<TD align=right>")

        CommonFunctions.General.WriteHTML("|&nbsp;<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter' onclick='showFilters(1)'/>&nbsp;")
        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' href=javascript:Export_OnClick()>")
        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black>" + "|Export To Excel</font>")
        CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")
        CommonFunctions.General.WriteHTML("<a style='TEXT-DECORATION:None' href=javascript:Help_OnClick(3899)>")
        CommonFunctions.General.WriteHTML("<Font Size=1 face=Arial;verdana color=Black>" + "|&nbsp;?</font>")
        CommonFunctions.General.WriteHTML("</a>&nbsp;<Font Size=1 face=Arial;verdana color=black>|")
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")
        CommonFunctions.General.WriteHTML("<BR>")

        'Filter Table 
        ''Commented and added by Nilesh G on 16/11/2015 for issue id 2278
        ''CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")
        CommonFunctions.General.WriteHTML("<TABLE id='tblFilter' style='display:none;width:99.99%;' class='clsGridTable' cellspacing='1' cellpadding='1'>")
        'For BG Filter 
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class=clsTRPageCaption align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Business Group")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=left >")
        CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_sel_BusinessGroups_LevelWise_PassI_II " + Session("intUserID").ToString, 200, m_strBGID, "onChange= BG_onChange()", True)
        CommonFunctions.General.WriteHTML("</td>")
        'For OU Filter 
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Organization Unit")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;' align=Left >")

        If m_strBGID <> "" Then
            CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_PassI_II " + m_strBGID + "," + Session("intUserID").ToString, 200, m_strOUID, , True)
        Else
            CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_sel_OrganizationUnits_LevelWise_PassI_II NULL, " + "," + Session("intUserID").ToString, 200, m_strOUID, , True)
        End If
        CommonFunctions.General.WriteHTML("</td></TR>")
        'Fo Role Filter
        CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class='clsTRPageCaption' align='Right'>")
        CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Role")
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left>")
        ''CommonFunctions.HTMLControls.DrawComboBox("cboRole", "select RoleID,RoleDescription from tbl_PM_Role where IsNull(IsUserGroup, 0) = 0 AND RoleID <> 23 Order by RoleDescription", 200, m_strRoleID.ToString, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_sel_IsUserGroup_tbl_PM_Role", 200, m_strRoleID.ToString, , True)
        CommonFunctions.General.WriteHTML("</td>")
        'For PrimarySkills
        'CommonFunctions.General.WriteHTML("<TR width=99.9% colspan=6 class='clsTRPageCaption' align='Right'>")


        If IsRoleBase = 0 Then
            CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right>Skill")
            CommonFunctions.General.WriteHTML("</td>")
            CommonFunctions.General.WriteHTML("<td style='width:25%' align=Left >")
            CommonFunctions.HTMLControls.DrawComboBox("cboSkill", "usp_Sel_tbl_PM_Tools", 200, m_strSkillID.ToString, , True)
            CommonFunctions.General.WriteHTML("</td>")
        Else
            CommonFunctions.General.WriteHTML("<td style='width:25%;text-align:right' align=right colspan=2>")
            CommonFunctions.General.WriteHTML("</td>")

        End If
        CommonFunctions.General.WriteHTML("</TR>")




        'Apply Button
        CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'><td colspan='4'  style='text-align:center;' width=4% height=15%>")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:applyFilter()' ><Font Size=1>Apply</Font></a>&nbsp;&nbsp;&nbsp;&nbsp;")
        'CommonFunctions.General.WriteHTML("<a style='text-align:center' class='clsHrefButton' style='border-style:outset;border-color:white;border-width:thin;' href='javascript:ClearFilter()' ><Font Size=1>Clear</Font></a></TD>")

        'CommonFunctions.General.WriteHTML("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        CommonFunctions.General.WriteHTML("<input type=button id=btnApply onclick='applyFilter()' value=""Apply"">")
        CommonFunctions.General.WriteHTML("<input type=button id=btnClear onclick='ClearFilter()' value=""Clear""></TD>")


        CommonFunctions.General.WriteHTML("</TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")

        Call DisplayAppliedFilters()

        DisplayGrid("0")

        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</Table>")


        Response.Write("</DIV>")

    End Sub

    Private Function getToolTipInfo() As String


        Dim strPipeline As String
        Dim strRoleID As String
        Dim strSkillID As String
        Dim strMonth As String
        Dim IsRoleBaseAjax As String

        Dim m_opportunityID As String
        If Request.QueryString("Pipeline") <> "" Then
            strPipeline = CType(Request.QueryString("Pipeline"), String)
        Else
            strPipeline = "NULL"
        End If

        If Request.QueryString("Month") <> "" Then
            strMonth = CType(Request.QueryString("Month"), String)
        Else
            strMonth = "NULL"
        End If

        If Request.QueryString("intRoleID") <> "" Then
            strRoleID = CType(Request.QueryString("intRoleID"), String)
        Else
            strRoleID = "NULL"
        End If
        'Skill ID
        If Request.QueryString("intSkillID") <> "" Then
            strSkillID = CType(Request.QueryString("intSkillID"), String)
        Else
            strSkillID = "NULL"
        End If

        If Request.QueryString("intBGID") <> "" Then
            m_strBGID = CType(Request.QueryString("intBGID"), String)
        End If

        If Request.QueryString("intOUID") <> "" Then
            m_strOUID = CType(Request.QueryString("intOUID"), String)
        End If

        If Request.QueryString("IsRoleBase") <> "" Then
            IsRoleBaseAjax = Request.QueryString("IsRoleBase").ToString()
        End If

        If strPipeline.ToUpper = "OPPORTUNITY" Then
            getToolTipInfo = DemandPipeLineToolTipInfo(strSkillID, strRoleID, strMonth, m_strBGID, m_strOUID, IsRoleBaseAjax)
        ElseIf strPipeline.ToUpper = "SOFT BOOKING" Then
            getToolTipInfo = SoftBookingToolTipInfo(strSkillID, strRoleID, strMonth, m_strBGID, m_strOUID, IsRoleBaseAjax)
        ElseIf strPipeline.ToUpper = "STAFFING PLAN" Then
            getToolTipInfo = ExecutionPipeLineToolTipInfo(strSkillID, strRoleID, strMonth, m_strBGID, m_strOUID, IsRoleBaseAjax)
        ElseIf strPipeline.ToUpper = "TOTAL EMPLOYEE" Then
            getToolTipInfo = TotalAvailableStrengthToolTipInfo(strSkillID, strRoleID, strMonth, IsRoleBaseAjax)
        ElseIf strPipeline.ToUpper = "AVAILABLE STRENGTH" Then
            getToolTipInfo = AvailableStrengthToolTipInfo(strSkillID, strRoleID, strMonth, IsRoleBaseAjax)
        ElseIf strPipeline.ToUpper = "ALLOCATED ON PROJECT" Then
            getToolTipInfo = AllocatedStrengthToolTipInfo(strSkillID, strRoleID, strMonth, IsRoleBaseAjax)
        ElseIf strPipeline.ToUpper = "ALLOCATION" Then
            getToolTipInfo = ExecutionAllocationToolTipInfo(strSkillID, strRoleID, strMonth, m_strBGID, m_strOUID, IsRoleBaseAjax)
            'ElseIf strPipeline.ToUpper = "REQUIRED ON PROJECT" Then
            'getToolTipInfo = RequiredStrengthToolTipInfo(strSkillID, strRoleID, strMonth)
        End If

    End Function
    Private Function SoftBookingToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal m_strBGID As String, ByVal m_strOUID As String, ByVal IsRoleBaseForToolTip As String)
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strProspect As String
        Dim strOldProspect As String = ""
        Dim strEmployeeName As String
        Dim strResourceInDate As Date
        Dim strResourceOutDate As Date
        Dim strSQL As String
        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        Dim CurrentDate As String
        Dim CurrentDateForSP As DateTime
        Dim srno As Integer = 1
        Dim strRoleName As String
        Dim strskillName As String
        CurrentDate = Request.QueryString("currentDate")
        CurrentDateForSP = Request.QueryString("currentDate")

        DivWidth = "690px"
        DivHt = "190px"

        strSQL = "usp_Sel_SoftBookingToolTipInfo '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & ",'" & CurrentDate & "'," & CurrentDateForSP.DaysInMonth(CurrentDateForSP.Year, CurrentDateForSP.Month) & "," & IsRoleBaseForToolTip
        dr = CommonFunction.Data.GetDataReader(strSQL, True)

        ''strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
        strRoleName = CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_RoleDescription " + strRoleID.ToString, True)
        If strSkillID <> "0" Then
            strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
        End If
        sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")
        sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
        If strSkillID <> "0" Then
            sbHtml.Append(strskillName + "-->")
        End If
        sbHtml.Append("Softbooked Employees</TD></TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("<BR>")

        sbHtml.Append("<table id='tbl_Div' width=99.9% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
        sbHtml.Append("<TR class='clsTRColumnHeader'>")
        sbHtml.Append("<TD  align='Left'>Sr.No.</TD>")
        sbHtml.Append("<TD  align='Left'>Prospect</TD>")
        sbHtml.Append("<TD  align='Left'>Resource</TD>")
        sbHtml.Append("<TD  align='Left'>Resource In Date</TD>")
        sbHtml.Append("<TD  align='Left'>Resource Out Date</TD>")
        sbHtml.Append("</TR>")

        While dr.Read
            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
            strProspect = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("Prospect"), String), ""), "")
            strEmployeeName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("EmployeeName"), String), ""), "")
            strResourceInDate = CType(dr("ResourceInDate"), Date)
            strResourceOutDate = CType(dr("ResourceOutDate").ToString(), Date)

            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
            sbHtml.Append("<td align=right>" + srno.ToString + "</td>")
            If strOldProspect <> strProspect Then
                sbHtml.Append("<td align=left>" + strProspect)
                sbHtml.Append("</td>")
            Else
                sbHtml.Append("<td align=left>&nbsp;</td>")
            End If

            sbHtml.Append("<td align=left>" + strEmployeeName)
            sbHtml.Append("</td>")

            sbHtml.Append("<td align=left>" + CommonFunction.Dates.CGetDate(strResourceInDate))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align=left>" + CommonFunction.Dates.CGetDate(strResourceOutDate))
            sbHtml.Append("</td>")

            sbHtml.Append("</TR>")
            strOldProspect = strProspect
            srno = srno + 1
        End While

        sbHtml.Append("</Table>")

        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        SoftBookingToolTipInfo = sbHtml.ToString
    End Function
    Private Function TotalAvailableStrengthToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal IsRoleBaseForToolTip As String) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim strEmployeeName As String
        Dim strBGName As String
        Dim strOUName As String
        'Dim strDesignation As String
        Dim strPrimarySkills As String
        Dim dblExp As Double
        Dim CurrentDate As String
        Dim CurrentDateForSP As DateTime


        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        Dim SRNO As Integer = 1
        Dim strRoleName As String
        Dim strskillName As String
        CurrentDate = Request.QueryString("currentDate")
        CurrentDateForSP = Request.QueryString("currentDate")


        DivWidth = "690px"
        DivHt = "190px"




        strSQL = "usp_Sel_TotalAvailableStrengthToolTipInfo " + strRoleID + "," & strSkillID & "," & Session("intUserID").ToString() & ",'" & CurrentDate & "'" & "," & CurrentDateForSP.DaysInMonth(CurrentDateForSP.Year, CurrentDateForSP.Month) & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
        dr = CommonFunction.Data.GetDataReader(strSQL, True)


        strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
        If strSkillID <> "0" Then
            strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
        End If
        sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")
        sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
        If strSkillID <> "0" Then
            sbHtml.Append(strskillName + "-->")
        End If
        sbHtml.Append("Total Employees</TD></TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("<BR>")

        sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
        sbHtml.Append("<TR class='clsTRColumnHeader'>")
        sbHtml.Append("<TD  align='Left'>Sr. No.</TD>")
        sbHtml.Append("<TD  align='Left'>Resource Name</TD>")
        sbHtml.Append("<TD  align='Left'>Business Group</TD>")
        sbHtml.Append("<TD  align='Left'>Organization Unit</TD>")
        sbHtml.Append("<TD  align='Left'>Primary Skills</TD>")
        sbHtml.Append("<TD  align='right'>Total Experience (yy.mm)</TD>")
        sbHtml.Append("</TR>")
        While dr.Read
            strEmployeeName = dr("EmployeeName").ToString
            strBGName = dr("BusinessGroup").ToString
            strOUName = dr("Location").ToString
            strPrimarySkills = dr("Primaryskills").ToString
            dblExp = CType(dr("TotalExp"), Double)

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If

            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
            sbHtml.Append("<TD align=right width=10%>" + SRNO.ToString + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strEmployeeName + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strBGName + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strOUName + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strPrimarySkills + "</TD>")
            sbHtml.Append("<TD align=right width=10%>" + dblExp.ToString + "</TD>")
            sbHtml.Append("</TR>")
            SRNO = SRNO + 1
        End While

        sbHtml.Append("</table>")
        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        TotalAvailableStrengthToolTipInfo = sbHtml.ToString

    End Function

    Private Function AvailableStrengthToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal IsRoleBaseForToolTip As String) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim strEmployeeName As String
        Dim strBGName As String
        Dim strOUName As String
        'Dim strDesignation As String
        Dim strPrimarySkills As String
        Dim dblExp As Double
        Dim CurrentDate As String
        Dim CurrentDateForSP As DateTime
        Dim srno As Integer = 1
        Dim strRoleName As String
        Dim strskillName As String

        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String

        CurrentDateForSP = Request.QueryString("currentDate")
        CurrentDate = Request.QueryString("currentDate")

        DivWidth = "690px"
        DivHt = "190px"

        strSQL = "usp_Sel_AvailableStrengthToolTipInfo " + strRoleID + "," & strSkillID & "," & Session("intUserID").ToString() & ",'" & CurrentDate & "'" & "," & CurrentDateForSP.DaysInMonth(CurrentDateForSP.Year, CurrentDateForSP.Month) & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
        dr = CommonFunction.Data.GetDataReader(strSQL, True)
        strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
        If strSkillID <> "0" Then
            strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
        End If
        sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")
        sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
        If strSkillID <> "0" Then
            sbHtml.Append(strskillName + "-->")
        End If
        sbHtml.Append("Available Employees</TD></TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("<BR>")

        sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
        sbHtml.Append("<TR class='clsTRColumnHeader'>")
        sbHtml.Append("<TD  align='Left'>Sr. No.</TD>")
        sbHtml.Append("<TD  align='Left'>Resource Name</TD>")
        sbHtml.Append("<TD  align='Left'>Business Group</TD>")
        sbHtml.Append("<TD  align='Left'>Organization Unit</TD>")
        sbHtml.Append("<TD  align='Left'>Primary Skills</TD>")
        sbHtml.Append("<TD  align='right'>Total Experience (yy.mm)</TD>")
        sbHtml.Append("</TR>")
        While dr.Read
            strEmployeeName = dr("EmployeeName").ToString
            strBGName = dr("BusinessGroup").ToString
            strOUName = dr("Location").ToString
            strPrimarySkills = dr("Primaryskills").ToString
            dblExp = CType(dr("TotalExp"), Double)

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If

            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
            sbHtml.Append("<TD align=right width=10%>" + srno.ToString + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strEmployeeName + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strBGName + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strOUName + "</TD>")
            sbHtml.Append("<TD align=left width=20%>" + strPrimarySkills + "</TD>")
            sbHtml.Append("<TD align=right width=10%>" + dblExp.ToString + "</TD>")
            sbHtml.Append("</TR>")
            srno = srno + 1
        End While

        sbHtml.Append("</table>")
        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        AvailableStrengthToolTipInfo = sbHtml.ToString

    End Function
    Private Function RequiredStrengthToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal IsRoleBaseForToolTip As String) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim strEmployeeName As String
        Dim CNT As String
        Dim strBGName As String
        Dim strOUName As String
        'Dim strDesignation As String
        Dim strPrimarySkills As String
        Dim strProjectName As String
        'Dim strEmployeeName As String
        Dim intResources As Double
        Dim dtStartDate As String
        Dim dtEndDate As String
        Dim dblExp As Double
        Dim CurrentDate As String

        CurrentDate = Request.QueryString("currentDate")

        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        DivWidth = "690px"
        DivHt = "190px"

        strSQL = "usp_Sel_ProjectRequiredResources_ToolTipInfo '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
        dr = CommonFunction.Data.GetDataReader(strSQL, True)

        sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")
        'sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        'sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>Project Resources</TD></TR>")
        'sbHtml.Append("</TABLE>")
        'sbHtml.Append("<BR>")

        sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
        sbHtml.Append("<TR class='clsTRColumnHeader'>")
        sbHtml.Append("<TD  align='Left'>Project</TD>")
        sbHtml.Append("<TD  align='Left'>Required Resources</TD>")

        sbHtml.Append("</TR>")

        While dr.Read
            strProjectName = dr("ProjectName").ToString
            CNT = dr("AllocatedeCNT").ToString

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")

            sbHtml.Append("<TD align=left>" + strProjectName + "</TD>")
            sbHtml.Append("<TD align=Right>" + CNT + "</TD>")

            sbHtml.Append("</TR>")
        End While


        sbHtml.Append("</table>")
        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        RequiredStrengthToolTipInfo = sbHtml.ToString

    End Function
    Private Function AllocatedStrengthToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal IsRoleBaseForToolTip As String) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim strEmployeeName As String
        Dim strBGName As String
        Dim strOUName As String
        'Dim strDesignation As String
        Dim strPrimarySkills As String
        Dim strProjectName As String
        'Dim strEmployeeName As String
        Dim strOldEmployeeName As String = ""
        Dim strNewEmployeeName As String
        Dim dblResourcePer As Double
        Dim intResources As Double
        Dim dtStartDate As String
        Dim dtEndDate As String
        Dim dblExp As Double
        Dim SrNo As Integer = 0
        Dim CurrentDate As String
        Dim CurrentDateForSP As DateTime
        Dim strRoleName As String
        Dim strskillName As String
        CurrentDate = Request.QueryString("currentDate")
        CurrentDateForSP = Request.QueryString("currentDate")

        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        DivWidth = "720px"
        DivHt = "200px"

        strSQL = "usp_Sel_ExecutionPipeLineToolTipInfo_ProjectAllocation '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & CurrentDateForSP.DaysInMonth(CurrentDateForSP.Year, CurrentDateForSP.Month) & ",'" & CurrentDate & "'" & "," & IsRoleBaseForToolTip
        dr = CommonFunction.Data.GetDataReader(strSQL, True)

        strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
        If strSkillID <> "0" Then
            strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
        End If
        sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")
        sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
        If strSkillID <> "0" Then
            sbHtml.Append(strskillName + "-->")
        End If
        sbHtml.Append("Allocated Employees</TD></TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("<BR>")



        sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
        sbHtml.Append("<TR class='clsTRColumnHeader'>")
        sbHtml.Append("<TD  align='Left'>Sr. No</TD>")
        sbHtml.Append("<TD  align='Left'>Resource</TD>")
        sbHtml.Append("<TD  align='Left'>Project</TD>")
        sbHtml.Append("<TD  align='Left'>% Allocation</TD>")
        sbHtml.Append("<TD  align='Left'>Start Date</TD>")
        sbHtml.Append("<TD  align='Left'>End Date</TD>")
        sbHtml.Append("</TR>")

        While dr.Read
            strProjectName = dr("ProjectName").ToString
            strEmployeeName = dr("EmployeeName").ToString
            dtStartDate = CType(dr("ExpectedStartDate"), Date)
            dtEndDate = CType(dr("ExpectedEndDate"), Date)
            dblResourcePer = CType(dr("ResourcePercentage"), Double)

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
            If strOldEmployeeName <> strEmployeeName Then
                SrNo = SrNo + 1
                sbHtml.Append("<TD align=right>" + SrNo.ToString + "</TD>")
                sbHtml.Append("<TD align=left>" + strEmployeeName + "</TD>")
            Else
                sbHtml.Append("<TD align=left></TD>")
                sbHtml.Append("<TD align=left></TD>")
            End If
            sbHtml.Append("<TD align=left>" + strProjectName + "</TD>")
            sbHtml.Append("<TD align=right>" + dblResourcePer.ToString + "</TD>")
            sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtStartDate) + "</TD>")
            sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtEndDate) + "</TD>")

            sbHtml.Append("</TR>")
            strOldEmployeeName = strEmployeeName

        End While


        sbHtml.Append("</table>")
        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        AllocatedStrengthToolTipInfo = sbHtml.ToString

    End Function
    Private Function ExecutionPipeLineToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal m_strBGID As String, ByVal m_strOUID As String, ByVal IsRoleBaseForToolTip As String) As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strProjectName As String
        Dim dtResourceInDate As Date
        Dim dtResourceOutDate As Date
        Dim strEngProb As String
        Dim strDistribution As String
        Dim DivWidth As String
        Dim DivHt As String
        ' Dim strProjectName As String
        Dim strEmployeeName As String
        Dim intResources As Double
        Dim dtStartDate As String
        Dim dtEndDate As String
        Dim strRoleName As String
        Dim strskillName As String
        DivWidth = "690px"
        DivHt = "190px" '"154px"

        If (CommonFunction.Application.AllowResourceAllocation = False) Then

            strSQL = "usp_Sel_ExecutionPipeLineToolTipInfo '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
            dr = CommonFunction.Data.GetDataReader(strSQL, True)
            strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
            If strSkillID <> "0" Then
                strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
            End If
            sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")
            sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
            sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
            If strSkillID <> "0" Then
                sbHtml.Append(strskillName + "-->")
            End If
            sbHtml.Append("Staffing Plan</TD></TR>")
            sbHtml.Append("</TABLE>")
            sbHtml.Append("<BR>")

            sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
            sbHtml.Append("<TR class='clsTRColumnHeader'>")
            sbHtml.Append("<TD  align='Left'>Project</TD>")
            sbHtml.Append("<TD  align='Left'>Resource - In Date</TD>")
            sbHtml.Append("<TD  align='Left'>Resource - Out Date</TD>")

            'sbHtml.Append("<TD  align='Right'>Engagement Probability</TD>")

            sbHtml.Append("<TD  align='Right'>FTE</TD>")
            'sbHtml.Append("<TD  align='Left'>UnSelect</TD>")
            sbHtml.Append("</TR>")

            While dr.Read
                strProjectName = dr("ProjectName").ToString
                dtResourceInDate = CType(dr("TentativeStartDate"), Date)
                dtResourceOutDate = CType(dr("TentativeEndDate"), Date)
                'strEngProb = dr("EngagementProbability").ToString
                strDistribution = dr("Distribution").ToString

                If strClass = "clsTREven" Then
                    strClass = "clsTROdd"
                Else
                    strClass = "clsTREven"
                End If
                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")

                sbHtml.Append("<TD align=left>" + strProjectName + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtResourceInDate) + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtResourceOutDate) + "</TD>")
                'sbHtml.Append("<TD align=right>" + strEngProb + "</TD>")
                sbHtml.Append("<TD align=right>" + strDistribution + "</TD>")
                sbHtml.Append("</TR>")
            End While
            sbHtml.Append("</table>")
            sbHtml.Append("<BR>")
        End If
        '''''''''to Plot Project Request'''''''''''''''''''''''''''''''''''''''''''
        strClass = "clsTROdd"
        If (CommonFunction.Application.AllowResourceAllocation) Then

            sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
            sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>Project Request</TD></TR>")
            sbHtml.Append("</TABLE>")

            sbHtml.Append("<BR>")

            strSQL = "usp_Sel_ExecutionPipeLineToolTipInfo_ProjectRequest '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
            dr = CommonFunction.Data.GetDataReader(strSQL, True)

            sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
            sbHtml.Append("<TR class='clsTRColumnHeader'>")
            sbHtml.Append("<TD  align='Left'>Project</TD>")
            sbHtml.Append("<TD  align='Left'>Start Date</TD>")
            sbHtml.Append("<TD  align='Left'>End Date</TD>")
            sbHtml.Append("<TD  align='Right'>No of Resources</TD>")
            sbHtml.Append("</TR>")

            While dr.Read
                strProjectName = dr("ProjectName").ToString
                intResources = CType(dr("NoOfResources"), Double)
                dtStartDate = CType(dr("FromDate"), Date)
                dtEndDate = CType(dr("ToDate"), Date)

                If strClass = "clsTREven" Then
                    strClass = "clsTROdd"
                Else
                    strClass = "clsTREven"
                End If
                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")

                sbHtml.Append("<TD align=left>" + strProjectName + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtStartDate) + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtEndDate) + "</TD>")
                sbHtml.Append("<TD align=Right>" + intResources.ToString() + "</TD>")

                sbHtml.Append("</TR>")
            End While

            sbHtml.Append("</table>")

        End If ' End of Project Resource Allocation

        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        ExecutionPipeLineToolTipInfo = sbHtml.ToString
    End Function

    Private Function DemandPipeLineToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal m_strBGID As String, ByVal m_strOUID As String, ByVal IsRoleBaseForToolTip As String) As String

        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strTitle As String
        Dim strProspect As String
        Dim IdentifiedBy As String
        Dim Probability As String
        Dim Distribution As String
        Dim ApproxStartDate As Date
        Dim ApproxDuration As String
        Dim stropportunityID As String
        Dim strCustID As String
        Dim strSQL As String
        Dim dr As IDataReader
        Dim DivWidth As String
        Dim DivHt As String
        Dim strRoleName As String
        Dim strskillName As String
        DivWidth = "690px"
        DivHt = "190px"

        strSQL = "usp_Sel_DemandPipeLineToolTipInfo '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
        dr = CommonFunction.Data.GetDataReader(strSQL, True)
        strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
        If strSkillID <> "0" Then
            strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
        End If
        sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")


        sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
        sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
        If strSkillID <> "0" Then
            sbHtml.Append(strskillName + "-->")
        End If
        sbHtml.Append("Opportunities</TD></TR>")
        sbHtml.Append("</TABLE>")
        sbHtml.Append("<BR>")
        sbHtml.Append("<table id='tbl_Div' width=99.9% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
        sbHtml.Append("<TR class='clsTRColumnHeader'>")
        sbHtml.Append("<TD  align='Left'>Prospect/Customer</TD>")
        sbHtml.Append("<TD  align='Left'>Title</TD>")
        'commented by SanaS on 27-Oct-2009
        'sbHtml.Append("<TD  align='Right'>Engagement Probability</TD>")
        'end comment by SanaS on 27-Oct-2009
        sbHtml.Append("<TD  align='Left'>Approx. Start Date</TD>")
        sbHtml.Append("<TD  align='Right'>Approx. Duration</TD>")
        sbHtml.Append("<TD  align='Left'>Identified By</TD>")
        sbHtml.Append("<TD  align='Right'>FTE</TD>")
        'sbHtml.Append("<TD  align='Left'>Deselect</TD>")
        sbHtml.Append("</TR>")

        While dr.Read

            If strClass = "clsTREven" Then
                strClass = "clsTROdd"
            Else
                strClass = "clsTREven"
            End If
            stropportunityID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("OpportunityID"), String), ""), "")
            strProspect = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("Prospect"), String), ""), "")
            strTitle = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("Title"), String), ""), "")
            IdentifiedBy = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("IdentifiedBy"), String), ""), "")
            Probability = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("EngagementProbability"), String), ""), "")
            Distribution = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("Distribution"), String), ""), "")
            ApproxStartDate = CType(dr("ApproxStartDate"), Date)
            ApproxDuration = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("ApproxDuration"), String), " "), " ")
            strCustID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CType(dr("CustomerID"), String), " "), " ")

            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")

            If strCustID <> "NULL" Then
                sbHtml.Append("<td align=left> <font style='color:blue'>" + strProspect + " </font>")
            Else
                sbHtml.Append("<td align=left>" + strProspect)
            End If
            'sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Title_" + m_opportunityID.ToString, "Title_" + intcnt.ToString, , 100, , m_strTitle, , , , , , True, , True))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align=left>" + strTitle)
            'sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("Title_" + m_opportunityID.ToString, "Title_" + intcnt.ToString, , 100, , m_strTitle, , , , , , True, , True))
            sbHtml.Append("</td>")
            'Commented by SanaS on 27-Oct-2009
            'sbHtml.Append("<td align=right>" + Probability)
            'sbHtml.Append("</td>")
            'End Comment by SanaS  on 27-Oct-2009


            sbHtml.Append("<td align=left>" + CommonFunction.Dates.CGetDate(ApproxStartDate))
            sbHtml.Append("</td>")



            sbHtml.Append("<td align=right>" + ApproxDuration)
            'sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("m_ApproxEndDate" + m_opportunityID.ToString, "m_ApproxEndDate" + intcnt.ToString, , 100, , m_ApproxEndDate, , , , , , True, , True))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align=left>" + IdentifiedBy)
            'sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("m_IdentifiedBy" + m_opportunityID.ToString, "m_IdentifiedBy" + intcnt.ToString, , 100, , m_IdentifiedBy, , , , , , True, , True))
            sbHtml.Append("</td>")

            sbHtml.Append("<td align=right>" + Distribution)
            sbHtml.Append("</td>")

            'sbHtml.Append("<td align=center>")
            'sbHtml.Append(CommonFunction.HTMLControls.DrawCheckBox("chkDemand", "chkDemand", "clsCheckBox", True, stropportunityID, , , True))
            'sbHtml.Append("</td")

            sbHtml.Append("</TR>")

        End While


        sbHtml.Append("</Table>")



        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        DemandPipeLineToolTipInfo = sbHtml.ToString

    End Function
    Private Function ExecutionAllocationToolTipInfo(ByVal strSkillID As String, ByVal strRoleID As String, ByVal strMon As String, ByVal m_strBGID As String, ByVal m_strOUID As String, ByVal IsRoleBaseForToolTip As String) As String
        '=====================================================================
        ' Procedure Name        : ExecutionAllocationToolTipInfo()
        ' Purpose               : To generate Info for Allocated Resources through Staffing Plan
        '                         the .aspx page
        ' Description           : To dispaly details of resources allocated
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SanaS
        ' Created               : 23 Oct 2009
        ' Revisions             :
        '=====================================================================
        Dim sbHtml As New System.Text.StringBuilder
        Dim strClass As String = "clsTROdd"
        Dim strSQL As String
        Dim dr As IDataReader
        Dim strEmployeeName As String
        Dim strProjectName As String
        Dim dtResourceInDate As Date
        Dim dtResourceOutDate As Date

        Dim DivWidth As String
        Dim DivHt As String
        Dim srno As Integer = 1
        Dim intResources As Double
        Dim dtStartDate As String
        Dim dtEndDate As String
        Dim strRoleName As String
        Dim strskillName As String
        DivWidth = "690px"
        DivHt = "190px" '"154px"



        If (CommonFunction.Application.AllowResourceAllocation = False) Then

            strSQL = "usp_Sel_ExecutionAllocationPipeLineToolTipInfo '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
            dr = CommonFunction.Data.GetDataReader(strSQL, True)

            strRoleName = CommonFunctions.Data.GetDataScalar("Select RoleDescription FROM tbl_PM_Role where Roleid=" + strRoleID.ToString, True)
            If strSkillID <> "0" Then
                strskillName = CommonFunctions.Data.GetDataScalar("Select Description FROM tbl_PM_Tools where Toolid=" + strSkillID.ToString, True)
            End If
            sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")


            sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
            sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left> " + strRoleName + "-->")
            If strSkillID <> "0" Then
                sbHtml.Append(strskillName + "-->")
            End If
            sbHtml.Append("Allocation against Staffing Plan</TD></TR>")
            sbHtml.Append("</TABLE>")
            sbHtml.Append("<BR>")

            sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
            sbHtml.Append("<TR class='clsTRColumnHeader'>")
            sbHtml.Append("<TD  align='Left'>Sr. No.</TD>")
            sbHtml.Append("<TD  align='Left'>Resource</TD>")
            sbHtml.Append("<TD  align='Left'>Project Name</TD>")
            sbHtml.Append("<TD  align='Left'>Expected Start Date</TD>")
            sbHtml.Append("<TD  align='Left'>Expected End Date</TD>")

            sbHtml.Append("</TR>")

            While dr.Read
                strEmployeeName = dr("EmployeeName").ToString
                strProjectName = dr("ProjectName").ToString
                dtResourceInDate = CType(dr("ExpectedStartDate"), Date)
                dtResourceOutDate = CType(dr("ExpectedEndDate"), Date)


                If strClass = "clsTREven" Then
                    strClass = "clsTROdd"
                Else
                    strClass = "clsTREven"
                End If
                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                sbHtml.Append("<TD align=right>" + srno.ToString + "</TD>")
                sbHtml.Append("<TD align=left>" + strEmployeeName + "</TD>")
                sbHtml.Append("<TD align=left>" + strProjectName + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtResourceInDate) + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtResourceOutDate) + "</TD>")

                sbHtml.Append("</TR>")
                srno = srno + 1
            End While
            sbHtml.Append("</table>")
            sbHtml.Append("<BR>")
        End If
        '''''''''to Plot Project Request'''''''''''''''''''''''''''''''''''''''''''
        strClass = "clsTROdd"
        If (CommonFunction.Application.AllowResourceAllocation) Then

            strSQL = "usp_Sel_ExecutionAllocationPipeLineToolTipInfo_ProjectRequest '" & strMon & "'," & strRoleID & "," & strSkillID & "," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBaseForToolTip
            dr = CommonFunction.Data.GetDataReader(strSQL, True)

            'sbHtml.Append("<Div style=""height:" + DivHt + ";overflow:auto;POSITION: relative;"">")

            sbHtml.Append("<TABLE cellspacing=0 cellpadding=0 Width='99.9%' class=clsTable>")
            sbHtml.Append("<TR class=clsTRPageCaption><TD align=Left>Allocated Resources</TD></TR>")
            sbHtml.Append("</TABLE>")
            sbHtml.Append("<BR>")

            sbHtml.Append("<table id='tbl_Div' width=99.99% CellPadding=0 CellSpacing=1 class='clsGridTable' >")
            sbHtml.Append("<TR class='clsTRColumnHeader'>")
            sbHtml.Append("<TD  align='Left'>Sr. No.</TD>")
            sbHtml.Append("<TD  align='Left'>Resource</TD>")
            sbHtml.Append("<TD  align='Left'>Project Name</TD>")
            sbHtml.Append("<TD  align='Left'>Expected Start Date</TD>")
            sbHtml.Append("<TD  align='Left'>Expected Start Date</TD>")

            sbHtml.Append("</TR>")

            While dr.Read
                strProjectName = dr("ProjectName").ToString
                strEmployeeName = dr("EmployeeName").ToString
                dtResourceInDate = CType(dr("ExpectedStartDate"), Date)
                dtResourceOutDate = CType(dr("ExpectedEndDate"), Date)


                If strClass = "clsTREven" Then
                    strClass = "clsTROdd"
                Else
                    strClass = "clsTREven"
                End If
                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                sbHtml.Append("<TD align=right>" + srno.ToString + "</TD>")
                sbHtml.Append("<TD align=left>" + strEmployeeName + "</TD>")
                sbHtml.Append("<TD align=left>" + strProjectName + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtResourceInDate) + "</TD>")
                sbHtml.Append("<TD align=left>" + CommonFunction.Dates.CGetDate(dtResourceOutDate) + "</TD>")

                sbHtml.Append("</TR>")
                srno = srno + 1
            End While
            sbHtml.Append("</table>")
            sbHtml.Append("<BR>")
        End If
        sbHtml.Append("</Div>")

        'To Plot Buttons
        sbHtml.Append("<Table style='Z-INDEX: 1001;' width=100%>")
        sbHtml.Append("<tr class='clsTRPageCaption'><td style='text-align:center;' width=4% height=15%>")
        'sbHtml.Append("<input type=button id=btnApply onclick='applyDiv()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;")
        'sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close"">&nbsp;&nbsp;&nbsp;&nbsp;</TD>")
        sbHtml.Append("<input type=button id=btnClose onclick='CloseDiv()' value=""Close""></TD>")
        sbHtml.Append("</TR>")
        sbHtml.Append("</Table>")

        CommonFunction.Data.DisposeDataReader(dr)

        ExecutionAllocationToolTipInfo = sbHtml.ToString
    End Function

    Private Sub DisplayAppliedFilters()
        Dim IsRoleSelected As Boolean
        Dim IsSkillSelected As Boolean

        If Not Request.Form("optRoleBase") Is Nothing OrElse Request.Form("optRoleBase") <> "" Then
            IsRoleBase = Request.Form("optRoleBase").ToString()
        End If



        If IsRoleBase = "1" Then
            IsRoleSelected = True
            IsSkillSelected = False
        Else
            IsRoleSelected = False
            IsSkillSelected = True
        End If


        'For Applied Filters
        Call BuildFilterString()

        If strAppliedFilters.Length > 50 Then
            strAppliedFilters = strAppliedFilters.Substring(0, 50) + " ..."
        End If

        CommonFunctions.General.WriteHTML("<TABLE id='tblAppliedFilter' width=99.9% cellspacing=0 style='border-bottom: 1px solid gray;' >")
        CommonFunctions.General.WriteHTML("<TR width=99.9% class='clsTRPageCaption' align='left'>")

        If strAppliedFilters = "None" Then
            CommonFunctions.General.WriteHTML("<td align=left colspan=14 >Current Filter : None</TD>")
        Else
            CommonFunctions.General.WriteHTML("<td align=left colspan=14 >Current Filter : <A href='javascript:showFilters(1)' >" + strAppliedFilters + "</A>")
            If strAppliedFilters <> "None" Then
                CommonFunctions.General.WriteHTML("<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
            End If
            CommonFunctions.General.WriteHTML("</td>")
        End If


        CommonFunctions.General.WriteHTML("<td align=right> View ")
        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("optRoleBase", "optRoleBase", , IsRoleSelected, "1", , "onclick=javascript:OptRoleSkill_OnChange(1)", True))
        CommonFunctions.General.WriteHTML(" Role Based &nbsp;&nbsp;&nbsp;&nbsp;")
        CommonFunctions.General.WriteHTML(CommonFunction.HTMLControls.DrawOptionButton("optRoleBase", "optRoleBase", , IsSkillSelected, "0", , "onclick=javascript:OptRoleSkill_OnChange(0)", True))
        CommonFunctions.General.WriteHTML("Skill Based </td >")

        CommonFunctions.General.WriteHTML("</TR></TABLE>")
    End Sub

    Private Sub BuildFilterString()

        Dim strFilterQuery As String
        Dim dr As IDataReader

        strFilterQuery = "usp_Sel_AppliedFilterString_ForStaffingPlan " & m_strRoleID & "," & m_strSkillID & "," & m_strBGID & "," & m_strOUID

        dr = CommonFunction.Data.GetDataReader(strFilterQuery, MyBase.UseSQL)
        While dr.Read
            strAppliedFilters = CType(dr("FilterString"), String)
        End While

        If strAppliedFilters = "" Then
            strAppliedFilters = "None"
        End If
        CommonFunction.Data.DisposeDataReader(dr)
    End Sub
    Private Function DisplayGrid(ByVal intExport) As String
        '=====================================================================
        ' Procedure Name        : DisplayGrid()
        ' Purpose               : To generate the New UI and is called from
        '                         the .aspx page
        ' Description           : UI for the staffing Plan
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SanaS
        ' Created               : 23 Oct 2009
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        Dim intCnt As Integer = 1
        Dim strPipeLine As String
        Dim strRole As String
        Dim strSkill As String
        Dim intRoleID As Integer
        Dim intSkillID As Integer
        Dim strSQL As String
        Dim sbHtml As New System.Text.StringBuilder
        Dim curDate As String
        Dim strHead As String
        Dim intmonth As Integer
        Dim intMonval As Double
        Dim intAvial As Double

        Dim intAvialJan As Double = 0
        Dim intAvialFeb As Double = 0
        Dim intAvialMar As Double = 0
        Dim intAvialApr As Double = 0
        Dim intAvialMay As Double = 0
        Dim intAvialJun As Double = 0
        Dim intAvialJul As Double = 0
        Dim intAvialAug As Double = 0
        Dim intAvialSep As Double = 0
        Dim intAvialOct As Double = 0
        Dim intAvialNov As Double = 0
        Dim intAvialDec As Double = 0

        Dim intEXEJan As Double
        Dim intEXEFeb As Double = 0
        Dim intEXEMar As Double = 0
        Dim intEXEApr As Double = 0
        Dim intEXEMay As Double = 0
        Dim intEXEJun As Double = 0
        Dim intEXEJul As Double = 0
        Dim intEXEAug As Double = 0
        Dim intEXESep As Double = 0
        Dim intEXEOct As Double = 0
        Dim intEXENov As Double = 0
        Dim intEXEDec As Double = 0


        If Not Request.Form("optRoleBase") Is Nothing OrElse Request.Form("optRoleBase") <> "" Then
            IsRoleBase = Request.Form("optRoleBase").ToString()
        End If

        If Request.QueryString("RoleID") <> "" Then
            m_strRoleID = CType(Request.QueryString("RoleID"), String)
        Else
            m_strRoleID = "NULL"
        End If
        'Skill ID
        If Request.QueryString("SkillID") <> "" Then
            m_strSkillID = CType(Request.QueryString("SkillID"), String)
        Else
            m_strSkillID = "NULL"
        End If

        If m_strpaging <> "-1" Then
            strSQL = "usp_Sel_Month_tbl_RM_Pipeline " & m_strRoleID & "," & m_strSkillID & ",'" & CommonFunction.General.BuildQueryString(m_strpaging.ToString) & "'," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBase
        Else
            '            strSQL = "usp_Sel_Month_tbl_RM_Pipeline " & m_strRoleID & "," & m_strSkillID & ",NULL," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBase
            strSQL = "usp_Sel_Month_tbl_RM_Pipeline " & m_strRoleID & "," & m_strSkillID & ",NULL," & Session("intUserID").ToString() & "," & m_strBGID & "," & m_strOUID & "," & IsRoleBase


        End If

        dr = CommonFunction.Data.GetDataReader(strSQL, True)
        Dim dtDate As Date

        'comment added by Shamkant s
        ' sbHtml.Append("<div ID=divTblGrid style='overflow:scroll; width:100%;height:380px'>")

        sbHtml.Append("<div ID=divTblGrid style='overflow:scroll; width:100%;'>")
        'comment Ended by Shamkant S
        sbHtml.Append("<Table name='Plan' id='Plan' class='clsGridTable' width=120% cellspacing=1 cellpadding=0><THead class='clsTRColumnHeader'>" + vbCrLf)


        sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>Role</TH>")
        If IsRoleBase = "0" Then
            sbHtml.Append("<TH class='FixedTD' align='Left' style='width:20px;'>Skill</TH>")
        End If
        sbHtml.Append("<TH class='FixedTD' align='Left' style='width:50px;'nowrap > &nbsp;</TH>")

        curDate = CommonFunction.Dates.GetDate(Now()).ToString
        'MonthName(
        intCnt = 1
        While intCnt <= 12
            dtDate = CDate(curDate)
            intmonth = Month(dtDate)
            strHead = Left(MonthName(intmonth), 3)
            curDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, 1, CDate(curDate)))
            sbHtml.Append("<TH class='FixedTD' align='right' style='width:50px;' nowrap>" + strHead + "</TH>")
            intCnt = intCnt + 1
        End While
        sbHtml.Append("</THead>")
        ' gRID
        Dim newRole As String = ""
        Dim newSkill As String = ""
        Dim ColCnt As Integer
        Dim strClass As String = "clsTROdd"
        curDate = CommonFunction.Dates.GetDate(Now()).ToString
        If IsRoleBase = 0 Then
            ColCnt = 15
        Else
            ColCnt = 14
        End If
        While dr.Read

            strRole = CType(dr("Role"), String)
            strSkill = CType(dr("Skill"), String)
            intRoleID = CType(dr("RoleID"), Integer)
            If IsRoleBase = "0" Then
                intSkillID = CType(dr("SkillID"), Integer)
            End If
            strPipeLine = CType(dr("Pipeline"), String)
            If strPipeLine <> "Required on Project" And strPipeLine <> "Opportunity" And strPipeLine <> "Staffing Plan" Then
                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                If newRole = strRole Then
                    sbHtml.Append("<td align=left>&nbsp;</TD>")
                Else
                    sbHtml.Append("<td align=left><b><i>" + CType(strRole, String) + "</b></i></TD>")
                End If

                If IsRoleBase = "0" Then

                    If newSkill = strSkill And newRole = strRole Then
                        sbHtml.Append("<td align=left>&nbsp;</TD>")
                    Else
                        sbHtml.Append("<td align=left><b><i>" + CType(strSkill, String) + "</b></i></TD>")
                    End If
                    intCnt = 1
                    If newRole <> strRole Or newSkill <> strSkill Then
                        While intCnt <= 13
                            sbHtml.Append("<td align=right >&nbsp;</TD>")
                            intCnt += 1
                        End While
                        sbHtml.Append("</tr>")
                    End If
                Else

                    intCnt = 1
                    If newRole <> strRole Then
                        While intCnt <= 13
                            sbHtml.Append("<td align=right >&nbsp;</TD>")
                            intCnt += 1
                        End While
                        sbHtml.Append("</tr>")
                    End If
                End If
            End If

            If strPipeLine = "Opportunity" Or strPipeLine = "Staffing Plan" Then

                sbHtml.Append("<tr class='" + strClass + "'><td align=left'></TD>")
                If IsRoleBase = 0 Then
                    sbHtml.Append("<td align=left'></TD>")
                End If
                If strPipeLine = "Opportunity" Then
                    sbHtml.Append("<td align=Center'> <b><i>Opportunity</b></i> </TD>")
                ElseIf strPipeLine = "Staffing Plan" Then
                    sbHtml.Append("<td align=Center'> <b><i>Project Requests</b></i> </TD>")
                End If

                intCnt = 1
                While intCnt <= 12
                    sbHtml.Append("<td align=right >&nbsp;</TD>")
                    intCnt += 1
                End While
                sbHtml.Append("</tr>")
            End If
            If strPipeLine <> "Required on Project" Then
                If strPipeLine <> "Opportunity" And strPipeLine <> "Staffing Plan" Then
                    If IsRoleBase = 0 Then
                        If newRole <> strRole Or newSkill <> strSkill Then
                            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                            sbHtml.Append("<td align=left>&nbsp;</TD>")
                            sbHtml.Append("<td align=left>&nbsp;</TD>")
                        End If
                    Else
                        If newRole <> strRole Then
                            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                            sbHtml.Append("<td align=left>&nbsp;</TD>")
                        End If
                    End If

                Else
                    If IsRoleBase = 0 Then
                        sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                        sbHtml.Append("<td align=left>&nbsp;</TD>")
                        sbHtml.Append("<td align=left>&nbsp;</TD>")

                    Else

                        sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                        sbHtml.Append("<td align=left>&nbsp;</TD>")
                    End If
                End If


                sbHtml.Append("<td align=left style='height=15%;'>" + CType(strPipeLine, String) + "</TD>")
            End If

            If strPipeLine = "Total Employee" Then
                If strClass = "clsTREven" Then
                    strClass = "clsTROdd"
                Else
                    strClass = "clsTREven"
                End If
            End If
            intCnt = 1
            curDate = CommonFunction.Dates.GetDate(Now()).ToString
            While intCnt <= 12
                dtDate = CDate(curDate)
                intmonth = Month(dtDate)
                strHead = Left(MonthName(intmonth), 3)

                intMonval = CType(CommonFunctions.Data.CheckIsDBNull(dr(strHead), "0"), Double)
                If strPipeLine <> "Required on Project" Then
                    If m_strMode.ToUpper <> "PRINT" Then
                        If intMonval > 0 Then
                            If strPipeLine <> "Remaining" Then
                                sbHtml.Append("<td align=right style='text-decoration:underline ; CURSOR:hand' onclick=""JavaScript:Display_onClick(event,'" + CType(strPipeLine, String) + "','" + strHead + "'," + CType(intRoleID, String) + "," + CType(intSkillID, String) + ",'" + m_strBGID + "','" + m_strOUID + "'," + intmonth.ToString() + ",'" + curDate.ToString() + "')"">" + CType(intMonval, String) + "</td>")
                            Else
                                sbHtml.Append("<td align=right>" + CType(intMonval, String) + "</td>")
                            End If

                        Else
                            sbHtml.Append("<td align=right>" + CType(intMonval, String) + "</td>")
                        End If
                    Else
                        sbHtml.Append("<td align=right>" + CType(intMonval, String) + "</td>")
                    End If
                End If

                curDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, 1, CDate(curDate)))
                'Soft Booking
                'If strPipeLine <> "Total Employee" And strPipeLine <> "Available Strength" And strPipeLine <> "Soft Booking" And strPipeLine <> "Allocated on Project" And strPipeLine <> "Execution Pipeline" Then
                If strPipeLine <> "Total Employee" And strPipeLine <> "Available Strength" And strPipeLine <> "Soft Booking" And strPipeLine <> "Allocated on Project" And strPipeLine <> "Staffing Plan" Then
                    'If strPipeLine = "Exectuion Pipeline" OrElse strPipeLine = "Opportunity" Then
                    If strHead.ToUpper = "JAN" Then
                        intEXEJan += intMonval
                    End If
                    If strHead.ToUpper = "FEB" Then
                        intEXEFeb += intMonval
                    End If
                    If strHead.ToUpper = "MAR" Then
                        intEXEMar += intMonval
                    End If
                    If strHead.ToUpper = "APR" Then
                        intEXEApr += intMonval
                    End If
                    If strHead.ToUpper = "MAY" Then
                        intEXEMay += intMonval
                    End If
                    If strHead.ToUpper = "JUN" Then
                        intEXEJun += intMonval
                    End If
                    If strHead.ToUpper = "JUL" Then
                        intEXEJul += intMonval
                    End If
                    If strHead.ToUpper = "AUG" Then
                        intEXEAug += intMonval
                    End If
                    If strHead.ToUpper = "SEP" Then
                        intEXESep += intMonval
                    End If
                    If strHead.ToUpper = "OCT" Then
                        intEXEOct += intMonval
                    End If
                    If strHead.ToUpper = "NOV" Then
                        intEXENov += intMonval
                    End If
                    If strHead.ToUpper = "DEC" Then
                        intEXEDec += intMonval
                    End If
                End If
                intCnt += 1

            End While

            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
            intCnt = 1
            If strPipeLine = "Available Strength" Then
                While intCnt <= 12
                    dtDate = CDate(curDate)
                    intmonth = Month(dtDate)
                    strHead = Left(MonthName(intmonth), 3)
                    curDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, 1, CDate(curDate)))
                    intMonval = CType(CommonFunctions.Data.CheckIsDBNull(dr(strHead), "0"), Double)

                    intAvial = CType(CommonFunctions.Data.CheckIsDBNull(dr(strHead), "0"), Double)
                    If strHead.ToUpper = "JAN" Then
                        intAvialJan = intAvial - intEXEJan
                    End If
                    If strHead.ToUpper = "FEB" Then
                        intAvialFeb = intAvial - intEXEFeb
                    End If
                    If strHead.ToUpper = "MAR" Then
                        intAvialMar = intAvial - intEXEMar
                    End If
                    If strHead.ToUpper = "APR" Then
                        intAvialApr = intAvial - intEXEApr
                    End If
                    If strHead.ToUpper = "MAY" Then
                        intAvialMay = intAvial - intEXEMay
                    End If
                    If strHead.ToUpper = "JUN" Then
                        intAvialJun = intAvial - intEXEJun
                    End If
                    If strHead.ToUpper = "JUL" Then
                        intAvialJul = intAvial - intEXEJul
                    End If
                    If strHead.ToUpper = "AUG" Then
                        intAvialAug = intAvial - intEXEAug
                    End If
                    If strHead.ToUpper = "SEP" Then
                        intAvialSep = intAvial - intEXESep
                    End If
                    If strHead.ToUpper = "OCT" Then
                        intAvialOct = intAvial - intEXEOct
                    End If
                    If strHead.ToUpper = "NOV" Then
                        intAvialNov = intAvial - intEXENov
                    End If
                    If strHead.ToUpper = "DEC" Then
                        intAvialDec = intAvial - intEXEDec
                    End If

                    intCnt += 1
                End While
            End If
            '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

            If strPipeLine <> "Required on Project" Then
                sbHtml.Append("</tr>")
            End If

            newRole = CType(dr("Role"), String)

            If IsRoleBase = "0" Then
                newSkill = CType(dr("Skill"), String)
            End If


            'If strPipeLine = "Execution Pipeline" Then
            If strPipeLine = "Remaining" Then
                sbHtml.Append("<tr class='clsTRPageCaption'><td align=left'></td>")

                intCnt = 1

                While intCnt <= ColCnt - 1
                    sbHtml.Append("<td align=right >&nbsp;</td>")
                    intCnt += 1
                End While
            End If
        End While
        newRole = ""
        strRole = ""
        newSkill = ""
        strSkill = ""
        sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
        If IsRoleBase = 0 Then
            sbHtml.Append("<td align=left colspan=15><b>Summary</b></td>")
        Else
            sbHtml.Append("<td align=left colspan=14><b>Summary</b></td>")
        End If
        sbHtml.Append("</TR>")
        If dr.NextResult Then
            While dr.Read
                strPipeLine = CType(dr("Pipeline"), String)
                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                sbHtml.Append("<td align=left>&nbsp;</td>")
                If IsRoleBase = 0 Then
                    sbHtml.Append("<td align=left>&nbsp;</td>")
                End If

                If strPipeLine = "Opportunity" Then
                    sbHtml.Append("<td align=Center'> <b><i>Opportunity</b></i> </td>")
                    intCnt = 1
                    While intCnt <= 12
                        sbHtml.Append("<td align=right >&nbsp;</td>")
                        intCnt += 1
                    End While
                ElseIf strPipeLine = "Staffing Plan" Then
                    sbHtml.Append("<td align=Center'> <b><i>Project Requests</b></i> </td>")
                    intCnt = 1
                    While intCnt <= 12
                        sbHtml.Append("<td align=right >&nbsp;</td>")
                        intCnt += 1
                    End While
                End If



                If strPipeLine <> "Required on Project" Then
                    If strPipeLine <> "Opportunity" And strPipeLine <> "Staffing Plan" Then
                        If IsRoleBase = 0 Then
                            If newRole <> strRole Or newSkill <> strSkill Then
                                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                                sbHtml.Append("<td align=left>&nbsp;</td>")
                                sbHtml.Append("<td align=left>&nbsp;</td>")
                            End If
                        Else
                            If newRole <> strRole Then
                                sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                                sbHtml.Append("<td align=left>&nbsp;</td>")
                            End If
                        End If

                    Else
                        If IsRoleBase = 0 Then
                            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                            sbHtml.Append("<td align=left>&nbsp;</td>")
                            sbHtml.Append("<td align=left>&nbsp;</td>")

                        Else

                            sbHtml.Append("<TR class='" + strClass + "' align='Left' nowrap >")
                            sbHtml.Append("<td align=left>&nbsp;</td>")
                        End If
                    End If


                    sbHtml.Append("<td align=left style='height=15%;'><i>" + CType(strPipeLine, String) + "</i></td>")
                End If

                If strPipeLine = "Total Employee" Then
                    If strClass = "clsTREven" Then
                        strClass = "clsTROdd"
                    Else
                        strClass = "clsTREven"
                    End If
                End If
                intCnt = 1
                curDate = CommonFunction.Dates.GetDate(Now()).ToString
                While intCnt <= 12
                    dtDate = CDate(curDate)
                    intmonth = Month(dtDate)
                    strHead = Left(MonthName(intmonth), 3)

                    intMonval = CType(CommonFunctions.Data.CheckIsDBNull(dr(strHead), "0"), Double)
                    If strPipeLine <> "Required on Project" Then
                        sbHtml.Append("<td align=right>" + CType(intMonval, String) + "</TD>")

                    Else
                        sbHtml.Append("<td align=right>" + CType(intMonval, String) + "</TD>")
                    End If


                    curDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, 1, CDate(curDate)))
                    'Soft Booking
                    'If strPipeLine <> "Total Employee" And strPipeLine <> "Available Strength" And strPipeLine <> "Soft Booking" And strPipeLine <> "Allocated on Project" And strPipeLine <> "Execution Pipeline" Then
                    If strPipeLine <> "Total Employee" And strPipeLine <> "Available Strength" And strPipeLine <> "Soft Booking" And strPipeLine <> "Allocated on Project" And strPipeLine <> "Staffing Plan" Then
                        'If strPipeLine = "Exectuion Pipeline" OrElse strPipeLine = "Opportunity" Then
                        If strHead.ToUpper = "JAN" Then
                            intEXEJan += intMonval
                        End If
                        If strHead.ToUpper = "FEB" Then
                            intEXEFeb += intMonval
                        End If
                        If strHead.ToUpper = "MAR" Then
                            intEXEMar += intMonval
                        End If
                        If strHead.ToUpper = "APR" Then
                            intEXEApr += intMonval
                        End If
                        If strHead.ToUpper = "MAY" Then
                            intEXEMay += intMonval
                        End If
                        If strHead.ToUpper = "JUN" Then
                            intEXEJun += intMonval
                        End If
                        If strHead.ToUpper = "JUL" Then
                            intEXEJul += intMonval
                        End If
                        If strHead.ToUpper = "AUG" Then
                            intEXEAug += intMonval
                        End If
                        If strHead.ToUpper = "SEP" Then
                            intEXESep += intMonval
                        End If
                        If strHead.ToUpper = "OCT" Then
                            intEXEOct += intMonval
                        End If
                        If strHead.ToUpper = "NOV" Then
                            intEXENov += intMonval
                        End If
                        If strHead.ToUpper = "DEC" Then
                            intEXEDec += intMonval
                        End If
                    End If
                    intCnt += 1

                End While

                '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                intCnt = 1
                If strPipeLine = "Available Strength" Then
                    While intCnt <= 12
                        dtDate = CDate(curDate)
                        intmonth = Month(dtDate)
                        strHead = Left(MonthName(intmonth), 3)
                        curDate = CommonFunction.Dates.GetDate(DateAdd(DateInterval.Month, 1, CDate(curDate)))
                        intMonval = CType(CommonFunctions.Data.CheckIsDBNull(dr(strHead), "0"), Double)

                        intAvial = CType(CommonFunctions.Data.CheckIsDBNull(dr(strHead), "0"), Double)
                        If strHead.ToUpper = "JAN" Then
                            intAvialJan = intAvial - intEXEJan
                        End If
                        If strHead.ToUpper = "FEB" Then
                            intAvialFeb = intAvial - intEXEFeb
                        End If
                        If strHead.ToUpper = "MAR" Then
                            intAvialMar = intAvial - intEXEMar
                        End If
                        If strHead.ToUpper = "APR" Then
                            intAvialApr = intAvial - intEXEApr
                        End If
                        If strHead.ToUpper = "MAY" Then
                            intAvialMay = intAvial - intEXEMay
                        End If
                        If strHead.ToUpper = "JUN" Then
                            intAvialJun = intAvial - intEXEJun
                        End If
                        If strHead.ToUpper = "JUL" Then
                            intAvialJul = intAvial - intEXEJul
                        End If
                        If strHead.ToUpper = "AUG" Then
                            intAvialAug = intAvial - intEXEAug
                        End If
                        If strHead.ToUpper = "SEP" Then
                            intAvialSep = intAvial - intEXESep
                        End If
                        If strHead.ToUpper = "OCT" Then
                            intAvialOct = intAvial - intEXEOct
                        End If
                        If strHead.ToUpper = "NOV" Then
                            intAvialNov = intAvial - intEXENov
                        End If
                        If strHead.ToUpper = "DEC" Then
                            intAvialDec = intAvial - intEXEDec
                        End If

                        intCnt += 1
                    End While
                End If
                '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

                If strPipeLine <> "Required on Project" Then
                    sbHtml.Append("</tr>")
                End If



            End While
        End If

        CommonFunction.Data.DisposeDataReader(dr)

        If intExport = "0" Then
            CommonFunction.General.WriteHTML(sbHtml.ToString)
        Else
            DisplayGrid = sbHtml.ToString
        End If


    End Function
    Protected Sub ExporttoExcel(ByVal strCode As String)
        Dim strCode1 As String
        Dim intSearchCount As Integer
        Dim strcodeBuilder As New StringBuilder
        Dim m_strWindowTitle As String
        strCode1 += ("</TR></tABLE></Center>")

        m_strWindowTitle = "Staffing Plan"
        Dim strsearch As String = "<td class=clsTDColumnSeparator  rowspan=" + intSearchCount.ToString + " width=1pt></td>"
        strcodeBuilder.Append(strCode)
        strcodeBuilder = strcodeBuilder.Replace("<Table", "<TABLE style=""FONT-SIZE: 8pt"" border=1 ")
        strcodeBuilder = strcodeBuilder.Replace("<img src='../../Images/minus.gif' border=0>", "")
        strcodeBuilder = strcodeBuilder.Replace(strsearch, "")
       
        Dim intStart, intEnd, intLength As Integer
        strCode = strcodeBuilder.ToString
        strcodeBuilder.Remove(0, strcodeBuilder.Length)
        PrintExcelDoc(strCode1 + strCode)
    End Sub
    Protected Sub PrintExcelDoc(ByVal query As String)
        '====================================================================
        ' Procedure Name        : PrintExcelDoc
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : To export the report in Excel Format
        ' Description           : To export the report in Excel Format
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : SanaS
        ' Created               : 24 Jun 2009
        ' Revisions             :
        '=====================================================================
        Dim strBody As New System.Text.StringBuilder("")


        strBody.Append("<html " & _
          "xmlns:o='urn:schemas-microsoft-com:office:office' " & _
          "xmlns:w='urn:schemas-microsoft-com:office:Excel'" & _
          "xmlns='http://www.w3.org/TR/REC-html40'>" & _
          "<head><title>Time</title>")

        'The setting specifies document's view after it is downloaded as Print instead of the default Web Layout
        strBody.Append("<!--[if gte mso 9]>" & _
         "<xml>" & _
         "<w:ExcelDocument>" & _
         "<w:View>Print</w:View>" & _
         "<w:Zoom>90</w:Zoom>" & _
         "<w:DoNotOptimizeForBrowser/>" & _
         "</w:ExcelDocument>" & _
         "</xml>" & _
         "<![endif]-->")

        strBody.Append("<style>" & _
           "<!-- /* Style Definitions */" & _
           "@page Section1" & _
           "   {size:8.5in 12in; " & _
           "   margin:0.5in 0.5in 0.5in 0.5in ; " & _
           "   mso-header-margin:.5in; " & _
           "   mso-footer-margin:.5in; mso-paper-source:0;size:landscape;}" & _
           " div.Section1" & _
           "   {page:Section1;}" & _
           "-->" & _
          "</style></head>")

        strBody.Append("<body lang=EN-US style='tab-interval:.5in'>" & _
          "<div class=Section1><font face='Verdana' size=10><pre>" & query.ToString & "</pre></font></div></body></html>")
        strBody = strBody.Replace("–", "-")
        strBody = strBody.Replace("‘", "'")
        strBody = strBody.Replace("’", "'")
        Dim m_filepath As String
        Dim Logfile As String
        m_filepath = Server.MapPath("../../Reports/")
        Logfile = CommonFunctions.FileDirectory.GetUniqueFileName("XLS")
        CommonFunctions.FileDirectory.WriteFileStream(m_filepath, Logfile, strBody.ToString)


        CommonFunctions.General.WriteHTML("<Script language=javascript>")
        CommonFunctions.General.WriteHTML("window.open(""../CRW/CRW_ReportOutput.aspx?filename=" + Logfile + ""","""",""menubar=no,resizable=yes,scrollbars=yes,left=50,top=50,width=500,height=500"");")
        CommonFunctions.General.WriteHTML("window.close();")
        CommonFunctions.General.WriteHTML("</Script>")
    End Sub
End Class



