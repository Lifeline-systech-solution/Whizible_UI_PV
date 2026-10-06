Public Class SM_CCToList
    'Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose
    'Inherits System.Web.UI.Page
    Inherits WebPages.Template.WhizTemplate
    'End Of Commented and Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected WithEvents m_objMenu As WebPage.Templates.StaticMenu
    Protected m_strMode As String = ""
    Protected m_ConfigureID As String = ""
    Protected m_ConfigureFor As String = ""
    Protected m_strAction As String = ""
    Protected WithEvents frmSM_CCToList As System.Web.UI.HtmlControls.HtmlForm
    Protected m_strProjectID As String = ""

    Protected m_strRoleID As String = "0"
    Protected m_strDesignationName As String = ""
    Protected m_strDepartment As String = ""
    Protected m_strBusinessGroupID As String = "0"
    Protected m_strLocation As String = ""
    Protected m_strEmployeeName As String = ""

    Protected m_strPaging As String = ""
    Protected m_strPageAlphabets As String = ""

    Protected m_strChecked As String = ""
    Protected m_strUnchecked As String = ""

    Protected m_strCorporateCCList As String = ""

    'Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
    Protected m_strExcludeRoleList As String = ""
    Protected m_strRoleDescription As String = ""
    'End Addition

    Protected m_strSortOrder As String
    Protected m_strSortBy As String
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
        'Put user code to initialize the page here
    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To Initialize the Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 25, 2006
        ' Revisions             :
        '=====================================================================
        'Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)
        MyBase.ApplySecurity(True)
        'End Of Added By Chakshuta H on 10th-Oct-2016 Purpose::Security purpose( XSS and SQL Injection)

        Initialise()
        If m_strMode = "DISPLAY" Or m_strMode = "PROJECT" Then
            Draw_Page()
        End If
        If m_strMode = "SAVE" Then
            Perform_Action()
            If m_strAction = "PROJECT" Then
                CommonFunctions.General.WriteHTML("<script language= javascript> " + vbCrLf)
                'CommonFunctions.General.WriteHTML("refreshParent('frmSM_CCToList','SM_CCToList.aspx','../SM/SM_CCToList.aspx');" + vbCrLf)
                CommonFunctions.General.WriteHTML(" if (window.opener != null)" + vbCrLf)
                CommonFunctions.General.WriteHTML("window.opener.location.href=window.opener.location.href;" + vbCrLf)
                CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
                CommonFunctions.General.WriteHTML("</script>")
            End If
            If m_strAction = "CC" Then
                CommonFunctions.General.WriteHTML("<script language= javascript> " + vbCrLf)
                CommonFunctions.General.WriteHTML("refreshParent('frmCommonPage','TSMailerConfiguration_CommonPage.aspx','../SM/TSMailerConfiguration_CommonPage.aspx?MasterTagID=3649');" + vbCrLf)
                CommonFunctions.General.WriteHTML("window.close();")
                CommonFunctions.General.WriteHTML("</script>")
            End If
        End If
    End Sub
    Protected Sub Initialise()
        '=====================================================================
        ' Procedure Name        : Initialise()
        ' Purpose               : To Initialise the variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct. 25,2006
        ' Revisions             :
        '=====================================================================
        m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToUpper
        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Action"), "").ToUpper
        m_ConfigureFor = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Entity"), "").ToUpper
        m_strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), "")
        m_strPaging = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Paging"), "-1").ToUpper

        m_strChecked = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("List"), "")
        m_strUnchecked = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Unchecked"), "")

        m_strRoleID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRole"), "")
        m_strDesignationName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboDesignationName"), "")
        m_strDepartment = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboDepartment"), "")
        m_strBusinessGroupID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboBusinessGroupID"), "")
        m_strLocation = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboLocation"), "")
        m_strEmployeeName = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("EmployeeName"), "")

        m_strCorporateCCList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CorporateCC"), "")

        'Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
        m_strExcludeRoleList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExcludeRoleList"), "")
        m_strRoleDescription = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("RoleDescription"), "")
        'End Addition

        'Code For Sorting Column
        ' Sort by of the page
        If Not Request.QueryString("SortBy") Is Nothing Then
            m_strSortBy = Request.QueryString("SortBy").ToString
        Else
            If m_ConfigureFor = "EXCLUDEROLE" Then
                m_strSortBy = "ROLEDESCRIPTION"
            Else
                m_strSortBy = "EMPLOYEENAME"
            End If
        End If
        ' Sort order of the page
        If Not Request.QueryString("SortOrder") Is Nothing Then
            m_strSortOrder = Request.QueryString("SortOrder").ToString
        Else
            m_strSortOrder = "ASC"
        End If

        Dim strQuery As String

        'If m_ConfigureFor = "CORPORATE" Then
        If m_ConfigureFor = "CORPORATE" Or m_ConfigureFor = "BG" Or m_ConfigureFor = "OU" _
                Or m_ConfigureFor = "DU" Or m_ConfigureFor = "DT" Then
            'Code For Display Paging
            strQuery = "usp_Sel_tbl_PM_Resource_Selection "
            If m_strRoleID <> "" Then
                strQuery += m_strRoleID + ","
            Else
                strQuery += "Null,"
            End If

            If m_strDesignationName <> "" Then
                strQuery += m_strDesignationName + ","
            Else
                strQuery += "Null,"
            End If

            If m_strDepartment <> "" Then
                strQuery += m_strDepartment + ","
            Else
                strQuery += "Null,"
            End If

            If m_strBusinessGroupID <> "" Then
                strQuery += m_strBusinessGroupID + ","
            Else
                strQuery += "Null,"
            End If

            If m_strLocation <> "" Then
                strQuery += m_strLocation + ","
            Else
                strQuery += "Null,"
            End If

            If m_strEmployeeName <> "" Then
                strQuery += "'" + CommonFunction.General.BuildQueryString(m_strEmployeeName) + "',"
            Else
                strQuery += "Null,"
            End If

            'If m_strPaging <> "-1" Then
            '    strQuery += "'" + CommonFunction.General.BuildQueryString(m_strPaging) + "'"
            'Else
            '    strQuery += "Null"
            'End If
            strQuery += "Null"

            strQuery += ",1"
        ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
            strQuery = "usp_Sel_tbl_PM_Role_Selection "

            If m_strRoleDescription <> "" Then
                strQuery += "'" + CommonFunction.General.BuildQueryString(m_strRoleDescription) + "',"
            Else
                strQuery += "Null,"
            End If

            'If m_strPaging <> "-1" Then
            '    strQuery += "'" + CommonFunction.General.BuildQueryString(m_strPaging) + "'"
            'Else
            '    strQuery += "Null"
            'End If
            strQuery += "Null"

            strQuery += ",1"

        End If

        m_strPageAlphabets = DrawPaging(strQuery)

        If m_strMode = "DISPLAY" Or m_strMode = "PROJECT" Then
            Select Case m_ConfigureFor
                Case "BG"
                    m_ConfigureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("BusinessGroupID"), "")
                Case "OU"
                    m_ConfigureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LocationID"), "")
                Case "DU"
                    m_ConfigureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResourcePoolID"), "")
                Case "DT"
                    m_ConfigureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("GroupID"), "")
            End Select
            If m_strProjectID <> "" Then
                m_ConfigureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ID"), "")
            End If
        Else
            m_ConfigureID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ID"), "")
        End If

        If m_ConfigureID = "" Then
            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
            ''m_ConfigureID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select Top 1 TSMailerID from tbl_CNF_TSMailerConfiguration ", True), "")
            m_ConfigureID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration", True), "")
            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
        End If
        'When Page is Called From Project Configuration - > Configure CC Link
        If m_ConfigureFor = "CC" Then
            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
            ''m_ConfigureID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select Top 1 TSMailerID from tbl_CNF_TSMailerConfiguration ", True), "")
            m_ConfigureID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("usp_sel_tbl_CNF_TSMailerConfiguration ", True), "")
            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        End If
    End Sub
    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct. 25,2006
        ' Revisions             :
        '=====================================================================
        DrawMenu(True)
        'CommonFunction.General.WriteHTML("<div ID=PageDiv style='overflow:auto;width:100%;height:200px'>")
        Dim strEntityName As String = ""
        Dim strEntity As String = ""
        Dim strProjectName As String = ""
        Select Case m_ConfigureFor
            Case "BG"
                ''Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                ''strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select BusinessGroup From Tbl_CNF_BusinessGroups Where BusinessGroupID = " + m_ConfigureID, True), "").ToString
                strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_CNF_BusinessGroups_BusinessGroup " + m_ConfigureID, True), "").ToString

                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                strEntity = "Business Group"
            Case "OU"
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                'strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select Location From Tbl_PM_Location Where LocationID = " + m_ConfigureID, True), "").ToString
                strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PM_Location_LocationID " + m_ConfigureID, True), "").ToString

                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                strEntity = "Organization Unit"
            Case "DU"
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                'strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select ResourcePoolName From Tbl_PM_ResourcePool Where ResourcePoolID = " + m_ConfigureID, True), "").ToString
                strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PM_ResourcePool_ResourcePoolName " + m_ConfigureID, True), "").ToString
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                strEntity = "Delivery Unit"
            Case "DT"
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                ''strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select GroupName From tbl_PM_GroupMaster Where GroupID = " + m_ConfigureID, True), "").ToString
                strEntityName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_GroupMaster_GroupName " + m_ConfigureID, True), "").ToString

                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                strEntity = "Delivery Team"
        End Select
        If m_strProjectID <> "" Then
            'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
            ''strProjectName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select ProjectName From Tbl_PM_Project Where ProjectID= " + m_strProjectID, True), "").ToString
            strProjectName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_PM_Project_ProjectID" + m_strProjectID, True), "").ToString
            'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

        End If

        'Modified by MrugajaB on 23rd Nov 2006 for exclude Role List feature
        If m_strMode = "DISPLAY" Then

            Dim sbHtml As New System.Text.StringBuilder
            sbHtml.Append("<BR><TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'>")

            'If m_ConfigureFor = "CORPORATE" Then
            If m_ConfigureFor = "CORPORATE" Or m_ConfigureFor = "BG" Or m_ConfigureFor = "OU" _
                Or m_ConfigureFor = "DU" Or m_ConfigureFor = "DT" Then
                'Code For Display Filter  

                sbHtml.Append("<TR align=Left class='clsTREven'>")
                sbHtml.Append("<TD align=right>Role</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                '' sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboRole", "select RoleID, RoleDescription from tbl_PM_Role WHERE IsUserGroup=0 Order By RoleDescription ", 200, m_strRoleID, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboRole", "usp_sel_tbl_PM_Role_IsUserGroup ", 200, m_strRoleID, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                sbHtml.Append("</TD>")

                sbHtml.Append("<TD align=right>Designation</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                ''sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboDesignationName", "select DesignationID, DesignationName from tbl_PM_DesignationMaster Order By DesignationName ", 200, m_strDesignationName, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboDesignationName", "usp_sel_tbl_PM_DesignationMaster_DesignationName ", 200, m_strDesignationName, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                sbHtml.Append("</TD>")
                sbHtml.Append("<TD align=right>Department</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                ''sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboDepartment", "select DepartmentID, department from tbl_PM_DepartmentMaster Order By department ", 200, m_strDepartment, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboDepartment", "usp_sel_tbl_PM_DepartmentMaster_DepartmentMaster ", 200, m_strDepartment, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                sbHtml.Append("</TD>")
                sbHtml.Append("</TR>")

                sbHtml.Append("<TR align=Left class='clsTREven'>")
                sbHtml.Append("<TD align=right>Business Group</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")
                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                ''sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboBusinessGroupID", "SELECT BusinessGroupID, BusinessGroup FROM tbl_CNF_BusinessGroups Order By BusinessGroup", 200, m_strBusinessGroupID, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboBusinessGroupID", "usp_sel_tbl_CNF_BusinessGroups_BusinessGroupID ", 200, m_strBusinessGroupID, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                sbHtml.Append("</TD>")
                sbHtml.Append("<TD align=right>Organization Unit</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")

                'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                ''sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboLocation", "select LocationID, Location from tbl_PM_Location Order By Location", 200, m_strLocation, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                sbHtml.Append(CommonFunction.HTMLControls.DrawComboBox("cboLocation", "usp_sel_tbl_PM_LocationID ", 200, m_strLocation, "onchange='javascript:Filter_OnChange(event,false)'", True, True))
                'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                sbHtml.Append("</TD>")
                sbHtml.Append("<TD align=right>Resource Name</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("EmployeeName", "EmployeeName", , 200, 50, m_strEmployeeName, , , , , , , "onkeypress='javascript:Filter_OnChange(event,true)'", True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
                sbHtml.Append("</TD>")
                sbHtml.Append("</TR>")
            ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
                sbHtml.Append("<TR align=Left class='clsTREven'>")
                sbHtml.Append("<TD align=right>Role Description</TD>")
                sbHtml.Append("<TD align=left>&nbsp;")
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                sbHtml.Append(CommonFunction.HTMLControls.DrawTextBox("RoleDescription", "RoleDescription", , 200, 50, m_strRoleDescription, , , , , , , "onkeypress='javascript:Filter_OnChange(event,true)'", True, EnableHTMLEncode:=True))
                'ended by Yogesh J for HTML encoding Date:06/10/15
                sbHtml.Append("</TD>")
            End If
            sbHtml.Append("</Table>")

            'End of Filter Code
            CommonFunction.General.WriteHTML(sbHtml.ToString)
            sbHtml = Nothing
        End If
        'End Modification By MrugajaB


        CommonFunction.General.WriteHTML("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")

        'Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
        'If m_ConfigureFor = "CORPORATE" Then
        If m_ConfigureFor = "CORPORATE" Or m_ConfigureFor = "BG" Or m_ConfigureFor = "OU" _
                Or m_ConfigureFor = "DU" Or m_ConfigureFor = "DT" Then
            CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Configure CC</TD>")
        Else
            CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Exclude Roles</TD>")
        End If
        'End Addition

        If strProjectName <> "" Then
            CommonFunction.General.WriteHTML("<TD align=Right>Project :</TD><TD align=Left>&nbsp;" + strProjectName + "</TD>")
        End If
        If m_ConfigureFor = "CORPORATE" Then
            CommonFunction.General.WriteHTML("<TD align=Right>Corporate Settings</TD>")
        ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
            CommonFunction.General.WriteHTML("<TD align=Right>Corporate Settings</TD>")
        Else
            CommonFunction.General.WriteHTML("<TD align=Right>" + strEntity + "&nbsp;:&nbsp;" + strEntityName + "</TD>")
        End If
        CommonFunction.General.WriteHTML("</TR></TABLE><BR>")


        'If m_ConfigureFor = "CORPORATE" Then
        If m_ConfigureFor = "CORPORATE" Or m_ConfigureFor = "BG" Or m_ConfigureFor = "OU" _
                Or m_ConfigureFor = "DU" Or m_ConfigureFor = "DT" Then
            DrawEmployeeGrid()
        ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
            'Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
            DrawRoleGrid()
            'End Addition
        End If

        If strProjectName <> "" Then
            CommonFunction.General.WriteHTML("</br><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD><B>Note :&nbsp;</B>Names shown in <Font color=blue>BLUE</Font> color are Project Resources.</td></TR></Table><BR>")
            'ElseIf m_ConfigureFor = "CORPORATE" Then
        ElseIf m_ConfigureFor <> "EXCLUDEROLE" Then
            CommonFunction.General.WriteHTML("</br><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD><B>Note :&nbsp;</B>'Inactive Resources' are not displayed on this page.</td></TR></Table><BR>")
        End If

        'End If
        If m_strMode = "PROJECT" Then
            CommonFunction.General.WriteHTML("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
            CommonFunction.General.WriteHTML("<TR class=clsTRPageCaption><TD align=Left>Project Configuration</TD>")
            CommonFunction.General.WriteHTML("<TD align=Right>" + strEntity + "&nbsp;:&nbsp;" + strEntityName + "</TD>")
            CommonFunction.General.WriteHTML("</TR></TABLE><BR>")
            DrawProjectGrid()
            'CommonFunction.General.WriteHTML("</br><Table class=clsTable width='99.9%' cellpadding=0 cellspacing=0><TR class='clsTREven'><TD><B>Note :&nbsp;</B>Records shown in <Font color=green>GREEN</Font> color are Timesheet Mailer Configured.</td></TR></Table><BR>")
        End If
        'CommonFunction.General.WriteHTML("</Div>")
        DrawMenu(False)
        m_objGrid = Nothing
    End Sub

    Protected Function DrawPaging(ByVal strQuery As String) As String
        '=====================================================================
        ' Procedure Name        : DrawPaging()
        ' Purpose               : To Built Paging String 
        ' Description           : 
        '                         
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Nov 15,2006
        ' Revisions             :
        '=====================================================================
        Dim drPaging As IDataReader
        Dim sbPaging As New System.Text.StringBuilder
        drPaging = CommonFunction.Data.GetDataReader(strQuery, True)
        sbPaging.Append("Select ")
        While drPaging.Read
            sbPaging.Append("<A class='PagingNormal' HREF='JavaScript:Page_Onclick(""")
            If drPaging(0).ToString = "'" Then
                sbPaging.Append((drPaging(0).ToString).Replace("'", "&#39;"))
            Else
                sbPaging.Append(drPaging(0))
            End If
            sbPaging.Append(""")'>")
            If m_strPaging = drPaging(0).ToString Then
                sbPaging.Append("<B>" + drPaging(0).ToString + "</B>")
            Else
                sbPaging.Append(drPaging(0))
            End If

            sbPaging.Append("</A>|")
        End While
        sbPaging.Append("<A class='PagingNormal' HREF='JavaScript:Page_Onclick(""")
        sbPaging.Append(-1)
        If m_strPaging = "-1" Then
            sbPaging.Append(""")'><B>ALL</B></A>")
        Else
            sbPaging.Append(""")'>ALL</A>")
        End If

        CommonFunction.Data.DisposeDataReader(drPaging)
        DrawPaging = sbPaging.ToString
        sbPaging = Nothing
    End Function

    Protected Sub DrawEmployeeGrid()
        '=====================================================================
        ' Procedure Name        : DrawEmployeeGrid()	
        ' Purpose               : Draw grid for High and Middle level Employees
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 25,2006
        ' Revisions             :
        '=====================================================================
        'Dim strQuery As String = "usp_Sel_High_Middle_Project_Resorce "
        Dim strQuery As String = "usp_Sel_tbl_PM_Resource_Selection "
        If m_strRoleID <> "" Then
            strQuery += m_strRoleID + ","
        Else
            strQuery += "Null,"
        End If

        If m_strDesignationName <> "" Then
            strQuery += m_strDesignationName + ","
        Else
            strQuery += "Null,"
        End If

        If m_strDepartment <> "" Then
            strQuery += m_strDepartment + ","
        Else
            strQuery += "Null,"
        End If

        If m_strBusinessGroupID <> "" Then
            strQuery += m_strBusinessGroupID + ","
        Else
            strQuery += "Null,"
        End If

        If m_strLocation <> "" Then
            strQuery += m_strLocation + ","
        Else
            strQuery += "Null,"
        End If

        If m_strEmployeeName <> "" Then
            strQuery += "'" + CommonFunction.General.BuildQueryString(m_strEmployeeName) + "',"
        Else
            strQuery += "Null,"
        End If

        If m_strPaging <> "-1" Then
            strQuery += "'" + CommonFunction.General.BuildQueryString(m_strPaging) + "',"
        Else
            strQuery += "Null,"
        End If

        strQuery += "null,'" + m_strSortBy + "','" + m_strSortOrder + "'"

        'If m_strProjectID <> "" Then
        '    strQuery += m_strProjectID
        'End If
        'Dim arrActualColumns() As String = {"EmployeeName"}
        'Dim arrUserFriendlyColumn() As String = {"Employee Name", "Select"}
        'Dim arrTDStyle() As String = {"align=left"}
        'Dim arrCheckBox() As String = {"", "chkApplicable"}

        Dim arrActualColumns() As String = {"EmployeeName", "Department", "BusinessGroup", "Location", "RoleDescription", "DesignationName"}
        Dim arrUserFriendlyColumn() As String = {"Resource Name", "Department", "Business Group", "Organization Unit", "Role", "Designation", "Select"}
        Dim arrTDStyle() As String = {"align=left"}
        Dim arrCheckBox() As String = {"", "", "", "", "", "", "chkApplicable"}

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Set the Generic Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .PrimaryKey = "EmployeeID"
            .CheckBoxIDArray = arrCheckBox
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuery
            .DIVID = "PageDiv"
            .DIVHeight = 380
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 6
            .UseSQL = True
            .returnHTML = False
            .DrawGrid()
        End With

    End Sub

    Protected Sub DrawProjectGrid()
        '=====================================================================
        ' Procedure Name        : DrawProjectGrid()	
        ' Purpose               : Draw grid for List of Project
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 25,2006
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = "usp_Sel_ProjectList '" + m_ConfigureFor.ToUpper + "'," + m_ConfigureID
        Dim arrActualColumns() As String = {"ProjectName", "Configure CC"}
        Dim arrUserFriendlyColumn() As String = {"Project", "Configure CC"}
        Dim arrTDStyle() As String = {"align=left"}
        Dim arrRowLink() As String = {"", "ConfigureCC_Onclick(ProjectID)"}
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "ProjectID"
            '   .CheckBoxIDArray = arrCheckBox
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuery
            .RowLinkArray = arrRowLink
            .DIVID = "PageDiv"
            .DIVHeight = 380
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 2
            .UseSQL = True
            .returnHTML = False
            .DrawGrid()
        End With

    End Sub

    Protected Sub DrawRoleGrid()

        '=====================================================================
        ' Procedure Name        : DrawRoleGrid()	
        ' Purpose               : Draw grid for List of Roles on the organization
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MrugajaB
        ' Created               : Nov 24,2006
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = "usp_Sel_tbl_PM_Role_Selection "

        If m_strRoleDescription <> "" Then
            strQuery += "'" + CommonFunction.General.BuildQueryString(m_strRoleDescription) + "',"
        Else
            strQuery += "Null,"
        End If

        If m_strPaging <> "-1" Then
            strQuery += "'" + CommonFunction.General.BuildQueryString(m_strPaging) + "',"
        Else
            strQuery += "Null,"
        End If

        strQuery += "null,'" + m_strSortBy + "','" + m_strSortOrder + "'"

        Dim arrActualColumns() As String = {"RoleDescription"}
        Dim arrUserFriendlyColumn() As String = {"Role Description", "Select"}
        Dim arrTDStyle() As String = {"align=left"}
        Dim arrCheckBox() As String = {"", "chkApplicable"}
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15


        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .EmptyValueReplacement = "&nbsp;"
            .PrimaryKey = "RoleID"
            .CheckBoxIDArray = arrCheckBox
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SQL = strQuery
            .DIVID = "PageDiv"
            .DIVHeight = 380
            .DIVStyle = "overflow:auto;width:99.99%;"
            .NoOfDataColumns = 1
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .UseSQL = True
            .returnHTML = False
            .DrawGrid()
        End With
    End Sub
    Protected Sub Perform_Action()
        '=====================================================================
        ' Procedure Name        : Perform_Action()
        ' Purpose               : To Save the Selected List
        ' Description           : 
        '                         
        ' Parameters Passed     : 
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 25,2006
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String = ""
        Dim strSelectedID As String = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkApplicable"), "0")

        strSelectedID = GetCCList()
        'Added By KapilGK on 4-Dec-2006 for SP8 IssueID - 7808 - SP gives error when CCList have too many names.
        'Now CC List is restricted to 20 Names
        Dim arrCheckLengthOfCCList() As String = strSelectedID.Split(","c)
        If arrCheckLengthOfCCList.Length > 21 And m_ConfigureFor <> "EXCLUDEROLE" Then
            CommonFunction.General.WriteHTML("<Script language=javascript> alert('CC List should not have more than 20 names.'); window.close(); </Script>")
            arrCheckLengthOfCCList = Nothing
            Return
        End If
        'End of addition By KapilKG
        If m_ConfigureFor = "CORPORATE" Then
            Dim strSelectedName As String
            strSelectedName = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_EmployeeNameList '" + strSelectedID + "'", True), "").ToString
            CommonFunction.General.WriteHTML("<Script language=javascript >" + vbCrLf)
            CommonFunction.General.WriteHTML("var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase1');" + vbCrLf)
            CommonFunction.General.WriteHTML(" if (objNDB1 == null) { window.close();   alert('You do Not have access to Configure a CC List.'); } " + vbCrLf)
            CommonFunction.General.WriteHTML(" else { " + vbCrLf)
            CommonFunction.General.WriteHTML("objNDB1.value="""";" + vbCrLf)
            CommonFunction.General.WriteHTML("objNDB1.value=""" + strSelectedName.Trim + """;" + vbCrLf)
            CommonFunction.General.WriteHTML("var objCC = GetParentObjectReference('frmCommonPage','CorporateCCList');" + vbCrLf)
            CommonFunction.General.WriteHTML("objCC.value="""";" + vbCrLf)
            CommonFunction.General.WriteHTML("objCC.value=""" + strSelectedID.Trim + """;" + vbCrLf)
            CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunction.General.WriteHTML(" } " + vbCrLf)

            CommonFunction.General.WriteHTML("</Script>")

            'Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
        ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
            Dim strSelectedRole As String
            strSelectedRole = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_Get_RoleList '" + strSelectedID + "'", True), "").ToString
            CommonFunction.General.WriteHTML("<Script language=javascript >" + vbCrLf)
            CommonFunction.General.WriteHTML("var objNDB1 = GetParentObjectReference('frmCommonPage','NonDatabase3');" + vbCrLf)
            CommonFunction.General.WriteHTML(" if (objNDB1 == null) { window.close();   alert('You do Not have access to Configure a CC List.'); } " + vbCrLf)
            CommonFunction.General.WriteHTML(" else { " + vbCrLf)
            CommonFunction.General.WriteHTML("objNDB1.value="""";" + vbCrLf)
            CommonFunction.General.WriteHTML("objNDB1.value=""" + strSelectedRole.Trim + """;" + vbCrLf)
            CommonFunction.General.WriteHTML("var objCC = GetParentObjectReference('frmCommonPage','ExcludeRoleList');" + vbCrLf)
            CommonFunction.General.WriteHTML("objCC.value="""";" + vbCrLf)
            CommonFunction.General.WriteHTML("objCC.value=""" + strSelectedID.Trim + """;" + vbCrLf)
            CommonFunction.General.WriteHTML("window.close();" + vbCrLf)
            CommonFunction.General.WriteHTML(" } " + vbCrLf)

            CommonFunction.General.WriteHTML("</Script>")
            'End Addition
        Else
            If m_strAction = "CC" Then
                strSQL = "usp_Ins_Upd_TSConfiguration '" + strSelectedID + "'," + m_ConfigureID
            End If

            If m_strAction = "PROJECT" Then
                strSQL = "usp_Ins_Upd_TSConfigurationProject '" + strSelectedID + "'," + m_ConfigureID + "," + m_strProjectID
            End If

            Select Case m_ConfigureFor
                Case "BG"
                    strSQL += ",'BG'"
                Case "OU"
                    strSQL += ",'OU'"
                Case "DU"
                    strSQL += ",'DU'"
                Case "DT"
                    strSQL += ",'DT'"
            End Select
            CommonFunction.Data.InsertOrUpdateData(strSQL, True)
        End If
    End Sub
    Private Function GetCCList() As String
        '=====================================================================
        ' Function Name         : GetCCList
        ' Purpose               : 
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : String Actual CC List
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Nov 20, 2006
        ' Revisions             :
        '=====================================================================
        Dim i As Integer
        Dim j As Integer
        Dim intNewCount As Integer = 0
        Dim arrNewList() As String
        Dim strCurrentCCList As String = ""
        Dim strTableName As String = ""
        Dim strID As String = ""
        Dim arrCurrentCC() As String
        Dim arrChecked() As String
        Dim arrUnchecked() As String
        Select Case m_ConfigureFor
            Case "BG"
                strTableName = "Tbl_CNF_TSMailerBGConfiguration"
                strID = "BusinessGroupID"
            Case "OU"
                strTableName = "Tbl_CNF_TSMailerOUConfiguration"
                strID = "LocationID"
            Case "DU"
                strTableName = "Tbl_CNF_TSMailerDUConfiguration"
                strID = "ResourcePoolID"
            Case "DT"
                strTableName = "Tbl_CNF_TSMailerDTConfiguration"
                strID = "ResourceGroupID"
        End Select
        If m_ConfigureFor = "CORPORATE" Then
            'strCurrentCCList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select CorporateCCList From Tbl_CNF_TSMailerConfiguration ", True), "")
            strCurrentCCList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("CorporateCC"), "")

            'Added by MrugajaB on 23rd Nov 2006 for exclude Role List feature
        ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
            'strCurrentCCList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select CorporateCCList From Tbl_CNF_TSMailerConfiguration ", True), "")
            strCurrentCCList = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ExcludeRoleList"), "")
            'End Addition
        Else
            strCurrentCCList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select CCList From " + strTableName + " Where " + strID + " = " + m_ConfigureID, True), "")
        End If
        If strCurrentCCList = "" Then strCurrentCCList = "0"
        'strCurrentCCList = CommonFunction.General.CheckIsNothing(CommonFunction.Data.GetDataScalar("Select CCList From " + strTableName + " Where " + strID + " = " + m_ConfigureID, True), "")

        If strCurrentCCList <> "" Then
            arrCurrentCC = strCurrentCCList.Split(","c)
            arrChecked = m_strChecked.Split(","c)
            arrUnchecked = m_strUnchecked.Split(","c)
            For i = 0 To arrChecked.Length - 1
                For j = 0 To arrCurrentCC.Length - 1
                    If arrChecked(i) = arrCurrentCC(j) Then
                        Exit For
                    End If
                Next
                If j = arrCurrentCC.Length Then strCurrentCCList = strCurrentCCList + "," + arrChecked(i)
            Next
            arrCurrentCC = strCurrentCCList.Split(","c)

            For i = 0 To arrUnchecked.Length - 1
                For j = 0 To arrCurrentCC.Length - 1
                    If arrUnchecked(i) = arrCurrentCC(j) Then
                        arrCurrentCC(j) = "-1"
                    End If
                Next
            Next
            strCurrentCCList = ""

            For i = 0 To arrCurrentCC.Length - 1
                If arrCurrentCC(i) <> "-1" Then
                    strCurrentCCList = strCurrentCCList + arrCurrentCC(i) + ","
                End If
            Next
            strCurrentCCList = strCurrentCCList.Substring(0, strCurrentCCList.Length - 1)
            GetCCList = strCurrentCCList
        End If
    End Function

    Private Sub DrawMenu(ByVal IsTopMenu As Boolean)
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Draws Menu for the page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Oct 25,2006
        ' Revisions             :
        '=====================================================================
        Dim strSaveLink As String = ""
        Dim strSaveToolTip As String = ""
        If (m_ConfigureFor = "CORPORATE") Then
            strSaveLink = "Select"
            strSaveToolTip = "Select"
        ElseIf (m_ConfigureFor = "EXCLUDEROLE") Then
            strSaveLink = "Exclude"
            strSaveToolTip = "Exclude"
        Else
            strSaveLink = "Save"
            strSaveToolTip = "Save"
        End If
        If m_strMode = "DISPLAY" Then
            Dim arrMenu() As String = {strSaveLink, "Select All", "Clear All", "Close", "?"}
            Dim arrMenuToolTip() As String = {strSaveToolTip, "Select All", "Clear All", "Close", "Help"}
            Dim arrClientSideFunctions() As String = {"Save_OnClick()", "SelectAll_OnClick()", "ClearAll_OnClick()", "Close_OnClick()", "OpenHelpPage('TSMail')"}
            m_objMenu = New WebPage.Templates.StaticMenu
            If IsTopMenu Then
                CommonFunction.General.WriteHTML(m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True, m_strPageAlphabets))
            Else
                CommonFunction.General.WriteHTML(m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))
            End If

        Else
            Dim arrMenu() As String = {"Close", "?"}
            Dim arrMenuToolTip() As String = {"Close", "Help"}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('TSMail')"}
            m_objMenu = New WebPage.Templates.StaticMenu
            CommonFunction.General.WriteHTML(m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True))
        End If
    End Sub
    Protected Function Print_Title() As String
        '=====================================================================
        ' Procedure Name        : Print_Title()
        ' Purpose               : To Initialize the Page Title
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : KapilGK
        ' Created               : Sept 29, 2006
        ' Revisions             :
        '=====================================================================

        m_strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "").ToUpper
        m_ConfigureFor = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Entity"), "").ToUpper
        If m_strMode = "PROJECT" Then
            Print_Title = "Project Configuration"
        ElseIf m_ConfigureFor = "CORPORATE" Or m_ConfigureFor = "BG" Or m_ConfigureFor = "OU" Or m_ConfigureFor = "DU" Or m_ConfigureFor = "DT" Then
            Print_Title = "Configure CC"
        ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
            Print_Title = "Exclude Roles"
        End If
    End Function

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If m_strProjectID <> "" Then
            If Args.ColumnName.ToUpper = "RESOURCE NAME" Then
                If Args.DataReader("IsProjectResource").ToString = "1" Then
                    Cancel = True
                    Args.StringToBeInserted = "<TD  vAlign=top ><Font color='blue'>" + Args.DataReader("EmployeeName").ToString + "</Font></td>"
                End If
            End If
        End If
        Dim intTagID As Integer



        'If Args.ColumnName.ToUpper = "CONFIGURE CC" Then
        '    If CheckRoleAccess(intTagID, 3649) = False Then
        '        Cancel = True
        '        Args.StringToBeInserted = "<TD  vAlign=top>" + Args.DataReader(2).ToString + "</td>"
        '    End If
        '    'If Args.DataReader("IsTSMConfigured").ToString = "1" Then
        '    '    Cancel = True
        '    '    'Args.StringToBeInserted = "<TD  vAlign=top ><Font color='green'>" + Args.DataReader(2).ToString + "</Font></td>"
        '    '    Args.StringToBeInserted = "<TD  vAlign=top><A href='JavaScript:ConfigureCC_Onclick(" + Args.DataReader(0).ToString + ")'><Font color='green'>" + Args.DataReader(2).ToString + "</Font></A></td></TR>"
        '    'End If
        'End If


        'If m_strMode = "PROJECT" Then
        '    If Args.ColumnName.ToUpper = "PROJECT" Then
        '        If Args.DataReader("IsTSMConfigured").ToString = "1" Then
        '            Cancel = True
        '            'Args.StringToBeInserted = "<TD  vAlign=top ><Font color='green'>" + Args.DataReader(2).ToString + "</Font></td>"
        '            Args.StringToBeInserted = "<TD  vAlign=top><Font color='green'>" + Args.DataReader(1).ToString + "</Font></A></td>"
        '        End If
        '    End If
        '    If Args.ColumnName.ToUpper = "CONFIGURE CC" Then
        '        If Args.DataReader("IsTSMConfigured").ToString = "1" Then
        '            Cancel = True
        '            'Args.StringToBeInserted = "<TD  vAlign=top ><Font color='green'>" + Args.DataReader(2).ToString + "</Font></td>"
        '            Args.StringToBeInserted = "<TD  vAlign=top><A href='JavaScript:ConfigureCC_Onclick(" + Args.DataReader(0).ToString + ")'><Font color='green'>" + Args.DataReader(2).ToString + "</Font></A></td></TR>"
        '        End If
        '    End If
        'End If

        If Args.ColumnName.ToUpper = "SELECT" Then
            Dim strSQL As String = ""
            Dim strSelectedID() As String
            Dim intCount As Integer
            If m_strProjectID = "" Then
                Select Case m_ConfigureFor
                    Case "BG"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        ' strSQL = "Select CCList From Tbl_CNF_TSMailerBGConfiguration Where BusinessGroupID = " + m_ConfigureID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerBGConfiguration " + m_ConfigureID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                    Case "OU"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        ''strSQL = "Select CCList From Tbl_CNF_TSMailerOUConfiguration Where LocationID = " + m_ConfigureID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerOUConfiguration " + m_ConfigureID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    Case "DU"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        ''strSQL = "Select CCList From Tbl_CNF_TSMailerDUConfiguration Where ResourcePoolID = " + m_ConfigureID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerDUConfiguration " + m_ConfigureID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    Case "DT"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        ''strSQL = "Select CCList From Tbl_CNF_TSMailerDTConfiguration Where ResourceGroupID = " + m_ConfigureID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerDTConfiguration " + m_ConfigureID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                End Select
            Else
                Select Case m_ConfigureFor
                    Case "BG"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'strSQL = "Select CCList From Tbl_CNF_TSMailerBGProject Where BusinessGroupID = " + m_ConfigureID + " And ProjectID = " + m_strProjectID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerBGProject " + m_ConfigureID + "," + m_strProjectID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    Case "OU"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'strSQL = "Select CCList From Tbl_CNF_TSMailerOUProject Where LocationID = " + m_ConfigureID + " And ProjectID = " + m_strProjectID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerOUProject " + m_ConfigureID + "," + m_strProjectID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    Case "DU"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'strSQL = "Select CCList From Tbl_CNF_TSMailerDUProject Where ResourcePoolID = " + m_ConfigureID + " And ProjectID = " + m_strProjectID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerDUProject " + m_ConfigureID + "," + m_strProjectID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    Case "DT"
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'strSQL = "Select CCList From Tbl_CNF_TSMailerDTProject Where ResourceGroupID = " + m_ConfigureID + " And ProjectID = " + m_strProjectID
                        strSQL = "usp_sel_Tbl_CNF_TSMailerDTProject " + m_ConfigureID + "," + m_strProjectID
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                End Select
            End If
            'Modified by MrugajaB on 23rd Nov 2006 for exclude Role List feature
            If strSQL <> "" Then
                strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)
                If strSelectedID.Length = 1 And strSelectedID(0) = "" Then
                    If m_ConfigureFor = "CORPORATE" Then
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'strSQL = "Select Top 1 CorporateCCList from tbl_CNF_TSMailerConfiguration"
                        strSQL = "usp_sel_tbl_CNF_TSMailerConfiguration_CorporateCCList "
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
                        'Commented and added by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query
                        'strSQL = "Select Top 1 ExcludeRoleList from tbl_CNF_TSMailerConfiguration"
                        strSQL = "usp_sel_tbl_CNF_TSMailerConfiguration_ExcludeRoleList "
                        'End of addition by Sanyogeeta Raorane on 04-Aug-2016 To Remove Inline Query

                    End If

                    strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)
                End If
            Else
                If m_ConfigureFor = "CORPORATE" Then
                    'Modified For Displaying Check box as Checked which are Selected though not Saved in Corporate Level.
                    'strSQL = "Select Top 1 CorporateCCList from tbl_CNF_TSMailerConfiguration"
                    'strSelectedID = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, True), ""), "").Split(","c)
                    strSelectedID = m_strCorporateCCList.Split(","c)
                ElseIf m_ConfigureFor = "EXCLUDEROLE" Then
                    strSelectedID = m_strExcludeRoleList.Split(","c)
                End If
                'End Modification by MrugajaB
            End If

            For intCount = 0 To strSelectedID.Length - 1
                If strSelectedID(intCount) = Args.DataReader(0).ToString Then
                    Args.IsCheckBoxChecked = True
                End If
            Next
        End If
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
        If Not IsNothing(m_objGrid) Then m_objGrid = Nothing
        If Not IsNothing(m_objMenu) Then m_objMenu = Nothing
        If Not IsNothing(m_strMode) Then m_strMode = Nothing
        If Not IsNothing(m_ConfigureID) Then m_ConfigureID = Nothing
        If Not IsNothing(m_ConfigureFor) Then m_ConfigureFor = Nothing
        If Not IsNothing(m_strAction) Then m_strAction = Nothing
        If Not IsNothing(m_strProjectID) Then m_strProjectID = Nothing
        If Not IsNothing(m_strRoleID) Then m_strRoleID = Nothing
        If Not IsNothing(m_strDesignationName) Then m_strDesignationName = Nothing
        If Not IsNothing(m_strDepartment) Then m_strDepartment = Nothing
        If Not IsNothing(m_strBusinessGroupID) Then m_strBusinessGroupID = Nothing
        If Not IsNothing(m_strLocation) Then m_strLocation = Nothing
        If Not IsNothing(m_strEmployeeName) Then m_strEmployeeName = Nothing
        If Not IsNothing(m_strPaging) Then m_strPaging = Nothing
        If Not IsNothing(m_strPageAlphabets) Then m_strPageAlphabets = Nothing
        If Not IsNothing(m_strChecked) Then m_strChecked = Nothing
        If Not IsNothing(m_strUnchecked) Then m_strUnchecked = Nothing
        If Not IsNothing(m_strCorporateCCList) Then m_strCorporateCCList = Nothing
        If Not IsNothing(m_strCorporateCCList) Then m_strExcludeRoleList = Nothing
        If Not IsNothing(m_strRoleDescription) Then m_strRoleDescription = Nothing
        If Not IsNothing(m_strSortOrder) Then m_strSortOrder = Nothing
        If Not IsNothing(m_strSortBy) Then m_strSortBy = Nothing
    End Sub
End Class
