'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise
' Module Name      :    Resource Allocation Details
' Purpose          :    More list of resources to assign for the Project.
'                       User can change the filter criterias
' Description      :    <Description>
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    April 14, 2004
' Revisions        :    
'******************************************************************

Public Class PM_ShowMoreResources
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
        ''Added by Yogesh J on 15-Feb-2016 to validate Token
        If Request.QueryString("ProjectID") IsNot Nothing And Request.QueryString("RequestID") IsNot Nothing And Request.QueryString("Token") IsNot Nothing Then
            If Request.QueryString("FromWhere") = "PM" Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("ProjectID"), String) + CType(Request.QueryString("RequestID"), String) + CType(0, String) + CType(0, String), Request.QueryString("Token")) = False) Then
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If

            End If
        End If
        ''End of addition by Yogesh J on on 15-Feb-2016 to validate Token
    End Sub

#End Region

#Region " Constants Used in the Class "
    Private ALLOCATION_LEVEL_CORPORATE As String = "Corporate"
    Private ALLOCATION_LEVEL_BUSINESSGROUP As String = "Business Group"
    Private ALLOCATION_LEVEL_ODC As String = "ODC"

    Protected ACTION_ALLOCATE As String = "Allocate"
    Protected ACTION_SEARCH As String = "Search"

    Protected TYPE_TH As String = "TH"
    Protected TYPE_P As String = "P"
    Protected TYPE_HPD As String = "HPD"

    Private Const TEAM_MANAGER As String = ",TM,"
    Private Const RESOURCE_MANAGER As String = ",RM,"
    Private Const OU_MANAGER As String = ",OUM,"
    Private Const BG_MANAGER As String = ",BGM,"
    Private Const GLOBAL_RESOURCE_MANAGER As String = ",GRM,"
    Private Const ADMIN As String = ",ADMIN,"

    Private Enum MenuIndex
        SEARCH
        ALLOCATE
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 4
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objResourceGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objSkillGrid As New WebPages.Template.GenericGrid
    'Menu
    Private m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Private m_lngTagId As Long = 0
    Protected m_lngProjectId As Long = 0
    Private m_lngUserId As Long = 0
    Private m_strUserName As String = ""
    Protected m_lngRequestId As Long = 0
    Private m_strAction As String = ""

    Private m_strProjectStartDate As String = ""
    Private m_strProjectEndDate As String = ""
    Private m_dblProjectWorkHours As Double = 0
    Protected m_lngRequestTeamID As Long = 0

    Protected m_strType As String = ""
    Private m_lngRoleId As Long = 0
    Private m_lngLocationId As Long = 0
    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Protected m_dblWorkHours As Double = 0
    Protected m_dblTotalWorkHours As Double = 0
    Protected m_dblPercentage As Double = 0
    Private m_dblWorkHoursForFilter As Double = -1
    Private m_lngDepartmentId As Long = 0
    Protected m_intTotalResourcesAssigned As Integer = 0
    Protected m_intTotalResourcesRequested As Integer = 0
    Private m_blnUseProjectPool As Boolean = False
    Private m_intSelectEmployeeType As Integer = 0
    Private m_strSkillIDs As String = ""
    Protected m_strClientSideScript As String = ""

    'Added By JayavantK, On 30-Aug-2004
    Private m_lngProjectRoleID As Long = 0
    'End Addition

    Private m_lngBusinessGroupId As Long = 0
    Private m_lngResourceGroupId As Long = 0
    ' Whether logged in user is Team manager / Resource Manager / Global Resource Manager
    Private m_strUserType As String = ""

    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""
    'Added by TruptiK on 12-Mar-2008
    'Private strEmployeeIDs As String
    Protected m_ResourceAllocationPercent As String = ""
    'End of addition by TruptiK
    'Resource Allocation Level
    Private m_strResourceAllocationLevel As String = ""
    'Added By VarunA on 5-Sep-2008
    'Added by TruptiK on 21-Jan-09
    Private m_status As String = ""
    'End of addition by TruptiK on 21-Jan-09
    'Purpose : To check if To date is greater than Request To Date and From date should not be less than Request From Date
    Private strReqFromDate As String = ""
    Private strReqToDate As String = ""
    Dim drRequestDetails As IDataReader
    Dim strSQLQuery As String = ""
    'End By VarunA on 5-Sep-2008
    Private strClass As String = "clsTROdd"
    Private m_EmployeeID As Integer
#End Region

#Region " Page and Class Events "
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        InitPageMenu()

        GetUserType()
        GetResourceAllocationLevel()

        m_lngTagId = m_objGlobal.TagID
        m_lngUserId = m_objGlobal.UserID
        m_strUserName = m_objGlobal.UserName
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("ProjectID"), "0"), Long)
        m_lngRequestId = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("RequestID"), "0"), Long)
        m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        If m_strSortBy = "" Then m_strSortBy = "Role"
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"

        'Added By JayavantK, On 30-Aug-2004
        m_lngProjectRoleID = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboProjectRole"), "0"), Long)
        'End Addition
        'Added by TruptiK on 21-Jan-09
        m_status = CommonFunctions.General.CheckIsNothing("" & MyBase.GetFormValue("cboStatus"), "")
        'End of addition by TruptiK
        'End Addition
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        GetProjectInformation()
        GetRequestInformation()
        If m_strAction = ACTION_ALLOCATE Then
            'COMMENTED by TruptiK on 13-Mar-2008
            'Purpose:-ThirdWare Change of Resource Allocation Percentage.
            'If Request.Params("FromXML") = "1" Then
            '    Response.Clear()
            'Response.Write(GetResourcePercent)
            '    Response.End()
            'End If    
            'End of COMMENTED by TrupitK on 13-Mar-2008
            AllocateResourcesAgainstRequest()
            'Get the latest details about the Request.
            m_strAction = ""
            'GetRequestInformation()
        End If

        'Added By NileshD on 10 Jan 2005
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidRequestFromDate", "txthidRequestFromDate", value:=m_strFromDate, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidRequestToDate", "txthidRequestToDate", value:=m_strToDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        'End Of Addition
        'Added By VarunA on 5-Sep-2008
        'Purpose : To check if To date is greater than Request To Date and From date should not be less than Request From Date
        If CType(m_lngRequestId, String) <> "" Then
            strSQLQuery = "EXEC usp_sel_tbl_PM_ResourceRequestDetails " & m_lngRequestId.ToString()
            drRequestDetails = CommonFunctions.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drRequestDetails) <> "" Then
                If drRequestDetails.Read() Then
                    strReqFromDate = drRequestDetails.Item("FromDate").ToString()
                    strReqFromDate = CommonFunctions.Dates.GetDate(CType(strReqFromDate, Date))
                    strReqToDate = drRequestDetails.Item("ToDate").ToString()
                    strReqToDate = CommonFunctions.Dates.GetDate(CType(strReqToDate, Date))
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drRequestDetails)
        End If
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidReqFromDate", "txthidReqFromDate", value:=strReqFromDate, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidReqToDate", "txthidReqToDate", value:=strReqToDate, IsHidden:=True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        'End By VarunA on 5-Sep-2008

    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objResourceGrid = Nothing
        m_objSkillGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Public Sub PageInit()
        Dim ObjSectionTitle As WebPages.Template.SectionTitle
        Dim strQuery As String = ""
        Dim strMenu As String = ""
        Dim strRightCaption As String = ""
        'Dim m_strType As String
        Dim m_strdblWorkHrs As Double

        'Check whether logged in user is Team Head or not. If Team Head then its Team.
        Dim lngGroupID As Long = 0

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
        'Commented by SanaS on 13-Aug-2009 Removed from PAge Caption and added in request details table
        'Display the Page Caption
        'strRightCaption = MyBase.GetResourceString("REQUESTED") & " : "
        'strRightCaption &= m_intTotalResourcesRequested.ToString() & "   &nbsp;"
        'strRightCaption &= MyBase.GetResourceString("ASSIGNED") & " : "
        'strRightCaption &= m_intTotalResourcesAssigned.ToString()
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ASSIGN_REQUESTED_RESOURCES"), strRightCaption, , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Page Div
        CommonFunctions.General.WriteHTML("<div id='PageDiv' style='overflow:auto;width:100%'>")
        'Added by SanaS on 13-Aug-2009

        'Display Request Details
        drRequestDetails = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_ResourceRequestDetails  Null ,'A.RequestID=" + m_lngRequestId.ToString + "'", MyBase.UseSQL)
        If drRequestDetails.Read Then
            CommonFunctions.General.WriteHTML("<TABLE class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD><b>Project</b></TD><TD width=2>&nbsp;:&nbsp;</TD><TD align='left'>")
            CommonFunctions.General.WriteHTML(CommonFunctions.General.UnBuildQueryString(CommonFunctions.General.CheckIsNothing(drRequestDetails.Item("Project"), "")))
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD><b>Role</b></TD><TD width=2>&nbsp;:&nbsp;</TD><TD align='left'>")
            CommonFunctions.General.WriteHTML(CommonFunctions.General.UnBuildQueryString(CommonFunctions.General.CheckIsNothing(drRequestDetails.Item("Role"), "")))
            CommonFunctions.General.WriteHTML("</TD>")
            If MyBase.GetFormValue("optType") Is Nothing Then
                m_strType = CommonFunctions.General.UnBuildQueryString(CommonFunctions.General.CheckIsNothing(drRequestDetails.Item("Type"), ""))
            Else
                m_strType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optType"))
            End If

            m_dblTotalWorkHours = (CType(CommonFunctions.Data.CheckIsDBNull(drRequestDetails.Item("TotalRequestedHrs"), "0"), Double))
            m_dblPercentage = CType(CommonFunctions.Data.CheckIsDBNull(drRequestDetails.Item("PercentageAllocation"), "0"), Double)
            If m_strType = TYPE_HPD Then
                m_dblWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drRequestDetails.Item("WorkHours"), "0"), Double)
            ElseIf m_strType = TYPE_P Then
                m_dblWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drRequestDetails.Item("PercentageAllocation"), "0"), Double)
            Else
                m_dblWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drRequestDetails.Item("TotalRequestedHrs"), "0"), Double)
            End If
            If MyBase.GetFormValue("txtHours") Is Nothing Then
                m_dblWorkHoursForFilter = m_dblWorkHours
            End If
            CommonFunctions.General.WriteHTML("<TD><b>")
            If m_strType = TYPE_P Then
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("WORK_HOURS") & " (%)")
            ElseIf m_strType = TYPE_TH Then
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TOTAL_WORK_HOURS"))
            Else
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("WORK_HOURS"))
            End If
            CommonFunctions.General.WriteHTML("</b></TD><TD width=2>&nbsp;:&nbsp;</TD><TD align='left'>")
            CommonFunctions.General.WriteHTML(m_dblWorkHours.ToString)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("</TD></tr>")
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD><b>" + MyBase.GetResourceString("REQUESTED") + "</b></TD><TD width=2>&nbsp;:&nbsp;</TD><TD align='left'>")
            CommonFunctions.General.WriteHTML(m_intTotalResourcesRequested.ToString)
            CommonFunctions.General.WriteHTML("</TD>")
            CommonFunctions.General.WriteHTML("<TD><b>" + MyBase.GetResourceString("ASSIGNED") + "</b></TD><TD width=2>&nbsp;:&nbsp;</TD><TD align='left'>")
            CommonFunctions.General.WriteHTML(m_intTotalResourcesAssigned.ToString)
            CommonFunctions.General.WriteHTML("</TD><TD colspan=3></td>")
            CommonFunctions.General.WriteHTML("</TR></table><br>")
        End If
        CommonFunction.Data.DisposeDataReader(drRequestDetails)
        'End addition by SanaS on 13-Aug-2009
        'Display the Control used to filter the list of resources.
        CommonFunctions.General.WriteHTML("<TABLE class='clsTable' cellpadding=0 cellspacing=0 width=99.9%>")
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        'Role Combo
        CommonFunctions.General.WriteHTML("<TD width='10%' align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("EMPLOYEE_ROLE"))
        CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left'>")
        strQuery = "Exec usp_Sel_tbl_PM_ProjectRoles_New"
        CommonFunctions.HTMLControls.DrawComboBox("cboRole", strQuery, 150, m_lngRoleId.ToString(), , True)
        CommonFunctions.General.WriteHTML("</TD>")
        ''Office Combo
        'CommonFunctions.General.WriteHTML("<TD width='10%' align='Right'>")
        ''CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OFFICE"))
        'CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left'>")
        ''strQuery = "EXEC usp_Sel_tbl_PM_Location"
        ''CommonFunctions.HTMLControls.DrawComboBox("cboOffice", strQuery, 150, m_lngLocationId.ToString(), , True)
        'CommonFunctions.General.WriteHTML("</TD>")

        ''Department Combo
        'CommonFunctions.General.WriteHTML("<TD width='10%' align='Right'>")
        ''CommonFunctions.General.WriteHTML(MyBase.GetResourceString("DEPARTMENT"))

        CommonFunctions.General.WriteHTML("<TD width='15%' align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_TYPE"))
        CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left' nowrap>")
        CommonFunctions.HTMLControls.DrawOptionButton("optType", "optPerDay", , (m_strType = TYPE_HPD Or m_strType = ""), TYPE_HPD, , "OnClick='Type_OnClick();'")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PER_DAY"))
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;")
        CommonFunctions.HTMLControls.DrawOptionButton("optType", "optTotalWorkHour", , (m_strType = TYPE_TH), TYPE_TH, , "OnClick='Type_OnClick();'")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TOTAL_HOURS"))
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;")
        CommonFunctions.HTMLControls.DrawOptionButton("optType", "optPercent", , (m_strType = TYPE_P), TYPE_P, , "OnClick='Type_OnClick();'")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PERCENT_OF_DAY"))
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left'></td><TD width='23%' align='Left'></TD>")
        CommonFunctions.General.WriteHTML("</TR>")

        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        'From Date
        CommonFunctions.General.WriteHTML("<TD width='10%' align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FROM_DATE"))
        CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left'>")
        CommonFunctions.HTMLControls.DrawDateControl("txtFromDate", "txtFromDate", , , m_strFromDate, , "frmPM_ShowMoreResources", IsMandatory:=True)
        CommonFunctions.General.WriteHTML("</TD>")
        'To Date
        CommonFunctions.General.WriteHTML("<TD width='10%' align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TO_DATE"))
        CommonFunctions.General.WriteHTML("</TD><TD width='15%' align='Left'>")
        CommonFunctions.HTMLControls.DrawDateControl("txtToDate", "txtToDate", , , m_strToDate, , "frmPM_ShowMoreResources", IsMandatory:=True)
        CommonFunctions.General.WriteHTML("</TD>")
        'Work Hours
        CommonFunctions.General.WriteHTML("<TD width='15%' align='Right' ID='tdWorkHours'>")
        If m_strType = TYPE_P Then
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("WORK_HOURS") & " (%)")
        ElseIf m_strType = TYPE_TH Then
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("TOTAL_WORK_HOURS"))
        Else
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("WORK_HOURS"))
        End If
        CommonFunctions.General.WriteHTML("</TD><TD width='23%' align='Left'>")
        If (m_dblWorkHoursForFilter = -1) Then
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours", , 50, 4, "", "Right", EnableHTMLEncode:=True)
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        Else
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtHours", "txtHours", , 50, 4, m_dblWorkHoursForFilter.ToString(), "Right", EnableHTMLEncode:=True)
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        ObjSectionTitle = New WebPages.Template.SectionTitle
        With ObjSectionTitle
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("PROJECT_SKILLS"), "divSectionSkills", "ShowHide_divSectionSkills", , , , , ))
            Response.Write(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
            Response.Write(.ClientsideScript())
            Response.Write(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
        End With
        ObjSectionTitle = Nothing
        ''CommonFunctions.General.WriteHTML("<DIV Id='divSectionSkills' Style='HEIGHT:75px;'>")
        CommonFunctions.General.WriteHTML("<DIV Id='divSectionSkills' Style='HEIGHT:100px;'>")
        'Display the List of Skills for the Project
        DisplaySkillsList()
        CommonFunctions.General.WriteHTML("</DIV>")

        ObjSectionTitle = New WebPages.Template.SectionTitle
        With ObjSectionTitle
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("SEARCH_RESULT"), "divSectionResources", "ShowHide_divSectionResources", , , , , ))
            Response.Write(System.Environment.NewLine + "<SCRIPT language=javascript>" + System.Environment.NewLine)
            Response.Write(.ClientsideScript())
            Response.Write(System.Environment.NewLine + "</SCRIPT>" + System.Environment.NewLine)
        End With
        ObjSectionTitle = Nothing
        CommonFunctions.General.WriteHTML("<DIV Id='divSectionResources' Style='HEIGHT:120px;'>")

        'Added By JayavantK, On 30-Aug-2004
        ' Display the Project Role Combo
        CommonFunctions.General.WriteHTML("<TABLE class='clsSubTagTable' width=99.9% cellpadding=0 cellspacing=0>")
        CommonFunctions.General.WriteHTML("<Tr class='clsTREven'><Td allign=right width=10%>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_ROLE"))
        'CommonFunctions.General.WriteHTML("</Td><Td align=left width=90%>")

        'strQuery = "usp_Sel_tbl_PM_Role_PopulateCombo"
        'CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole", strQuery, , m_lngProjectRoleID.ToString(), , True, False, , True)
        CommonFunctions.General.WriteHTML("&nbsp;")
        strQuery = "usp_Sel_tbl_PM_Role_PopulateCombo"
        CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole", strQuery, 250, m_lngProjectRoleID.ToString(), , True, False, , True)
        'CommonFunctions.General.WriteHTML("</Td></Tr></Table><BR>")
        'CommonFunctions.General.WriteHTML("</Td>")
        'Added by TruptiK on 21-Jan-09
        'CommonFunctions.General.WriteHTML("<Td width=10%>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp; Resource Status")
        'CommonFunctions.General.WriteHTML("</Td><Td width=90%>")
        CommonFunctions.General.WriteHTML("&nbsp;")
        strQuery = "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable"
        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strQuery, 250, m_status.ToString(), , True, False, , True)
        CommonFunctions.General.WriteHTML("</Td></Tr><Tr height='10px'><Td colspan=2></Td></Tr><Tr><Td colspan=2>")
        'End Addition

        'Display the List of resources retrieved after applying the filter
        DisplayResourceList()
        'Added by Harshk for resource joining date validation whiziblesemsp4 issueid 120,121 
        Dim strQuery1 As String
        strQuery1 = "usp_tbl_PM_Employee_GetResourceJoiningDate"
        CommonFunctions.HTMLControls.DrawComboBox("cboJoiningDate", strQuery1, , , , , , , , , True)
        'End Added by Harshk for resource joining date validation whiziblesemsp4 issueid 120,121 
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE></DIV>")
        CommonFunctions.General.WriteHTML("</DIV>")

        'Display the Menu at Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)

        'The Hidden Fields Dim strQuery As String
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectFromDate", "txthidProjectFromDate", value:=m_strProjectStartDate, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectToDate", "txthidProjectToDate", value:=m_strProjectEndDate, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidProjectWorkHours", "txthidProjectWorkHours", value:=m_dblProjectWorkHours.ToString(), IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidToday", "txthidToday", value:=CommonFunctions.Dates.GetDate(Now()), IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSkillIdList", "txthidSkillIdList", value:=m_strSkillIDs, IsHidden:=True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
        CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        'Added by TruptiK on 11-Mar-2008
        strQuery = "Exec usp_sel_ResourcePercentage_tbl_sem_settings"
        m_ResourceAllocationPercent = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
    End Sub

    Public Sub New()
        '  MyBase.ApplySecurity()
        'Added by Tejal D date 10/10/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by tejal Deshmukh date 10/10/2016 For SQL Injection,Cross Scripting

        MyBase.InitializeResources("AppResources.PM_ShowMoreResources", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Common Functions or Procedures "
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ShowMoreResources : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub InitPageMenu()
        '====================================================================
        ' Procedure Name        : InitPageMenu
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Builds the arrays required to display the Menu.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SEARCH) = MyBase.GetResourceString("MENU_SEARCH")
        m_arrMenuTooltip(MenuIndex.SEARCH) = MyBase.GetResourceString("MENU_SEARCH_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SEARCH) = "Search_OnClick()"

        m_arrMenuItem(MenuIndex.ALLOCATE) = MyBase.GetResourceString("MENU_ALLOCATE_RESOURCE")
        m_arrMenuTooltip(MenuIndex.ALLOCATE) = MyBase.GetResourceString("MENU_ALLOCATE_RESOURCE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.ALLOCATE) = "Allocate_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('SHOWMORERESOURCES')"

        MyBase.InitializeResources("AppResources.PM_ShowMoreResources", "AppResources")
    End Sub

    Private Function BuildFilterQuery() As String
        '====================================================================
        ' Procedure Name        : BuildFilterQuery
        ' Parameters Passed     : None
        ' Returns               : The built Query.
        ' Parameters Affected   : None
        ' Purpose               : This function build the SQL query to fetch the Resources from Database 
        '                         Which satisfies the filter criteria.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 15, 2004
        ' Revisions             :
        '=====================================================================
        Dim strTempQuery As String = ""
        Dim drSkills As IDataReader
        Dim strQuery As String = ""
        Dim arrSkillID() As String
        Dim intCnt As Integer = 0
        Dim strName As String = ""
        Dim intExpYrs, intExpMonths, intRating As Integer
        'Following are the strings containing comma seperated values entered by user for filters 
        'corresponding to the skills
        Dim strSkillIds As String = ""
        Dim strExpYrs As String = ""
        Dim strExpMonths As String = ""
        Dim strRatings As String = ""

        strQuery = "Exec usp_Sel_GetResourcesForAllocation " & m_lngRequestId.ToString()
        'Logged in Users ID
        If m_lngUserId <> 0 Then
            strQuery &= "," & m_lngUserId.ToString()
        Else
            strQuery &= ", null"
        End If
        'Sorting
        strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
        strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"

        If m_intSelectEmployeeType = 3 Then
            strQuery &= ",1,1"
        Else
            strQuery &= ",0,1"
        End If
        If m_lngRoleId <> 0 Then
            strQuery &= "," & m_lngRoleId.ToString()
        Else
            strQuery &= ", NULL"
        End If
        If m_lngLocationId <> 0 Then 'm_objGlobal.RoleLevel <> 1 And 
            strQuery &= "," & m_lngLocationId.ToString()
        Else
            strQuery &= ", NULL"
        End If

        strQuery &= ",'" & m_strFromDate & "'"
        strQuery &= ",'" & m_strToDate & "'"

        If m_dblWorkHoursForFilter <> -1 Then
            strQuery &= "," & m_dblWorkHoursForFilter.ToString()

        Else
            strQuery &= ", -1"
        End If
        If m_strType <> "" Then
            strQuery &= ",'" & m_strType & "'"
        Else
            strQuery &= ", NULL"
        End If

        'Need to remove the following line when department filter is there
        m_lngDepartmentId = 0 ' Added as department filter is removed.
        If m_lngDepartmentId <> 0 Then
            strQuery &= "," & m_lngDepartmentId.ToString()
        Else
            strQuery &= ", 0"
        End If
        If Page.IsPostBack = True Then
            strSkillIds = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSkillIdList"))
            If strSkillIds <> "" Then
                arrSkillID = strSkillIds.Split(CType(",", Char))
                strSkillIds = ""
                For intCnt = 0 To arrSkillID.Length - 2
                    strName = "cboYears_" & arrSkillID(intCnt)
                    intExpYrs = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue(strName), "0"), Integer)
                    strName = "cboMonths_" & arrSkillID(intCnt)
                    intExpMonths = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue(strName), "0"), Integer)
                    strName = "cboRating_" & arrSkillID(intCnt)
                    intRating = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue(strName), "0"), Integer)
                    If Not (intRating = 0 And intExpYrs = 0 And intExpMonths = 0) Then
                        strSkillIds &= arrSkillID(intCnt) & ","
                        strExpYrs &= intExpYrs.ToString() & ","
                        strExpMonths &= intExpMonths.ToString() & ","
                        strRatings &= intRating.ToString() & ","
                    End If
                Next
            End If
        Else
            'Fetch from database
            strTempQuery = "EXEC usp_Sel_tbl_PM_ResourceRequestDetails_Skills " & m_lngRequestId.ToString()
            drSkills = CommonFunctions.Data.GetDataReader(strTempQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drSkills) <> "" Then
                While drSkills.Read()
                    intExpYrs = CType(CommonFunctions.Data.CheckIsDBNull(drSkills.Item("ExpYrs"), "0"), Integer)
                    intExpMonths = CType(CommonFunctions.Data.CheckIsDBNull(drSkills.Item("ExpMonths"), "0"), Integer)
                    intRating = CType(CommonFunctions.Data.CheckIsDBNull(drSkills.Item("Rating"), "0"), Integer)
                    If Not (intRating = 0 And intExpYrs = 0 And intExpMonths = 0) Then
                        strSkillIds &= CType(CommonFunctions.Data.CheckIsDBNull(drSkills.Item("SkillID"), "0"), Integer) & ","
                        strExpYrs &= intExpYrs.ToString() & ","
                        strExpMonths &= intExpMonths.ToString() & ","
                        strRatings &= intRating.ToString() & ","
                    End If
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(drSkills)
        End If
        strQuery &= ",'" & strSkillIds & "'"
        strQuery &= ",'" & strExpYrs & "'"
        strQuery &= ",'" & strExpMonths & "'"
        strQuery &= ",'" & strRatings & "'"

        'Business Group
        If m_lngBusinessGroupId <> 0 Then
            strQuery &= "," & m_lngBusinessGroupId.ToString()
        Else
            strQuery &= ", null"
        End If

        'Resource Group
        If m_lngResourceGroupId <> 0 Then
            strQuery &= "," & m_lngResourceGroupId.ToString()
        Else
            strQuery &= ", null"
        End If

        Return strQuery
    End Function

    Private Sub GetUserType()
        '====================================================================
        ' Procedure Name       : GetUserType
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Get the logged in users type whether it is Team Manager / Resource Manager /
        '                        Global Resource Manager / Others
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : July 03, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""

        strQuery = "DECLARE @strType VARCHAR(30)" & vbCrLf
        strQuery &= " Exec usp_Sel_GetUserType " & m_objGlobal.UserID.ToString() & ", @strType OUT" & vbCrLf
        strQuery &= " SELECT @strType"
        m_strUserType = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
    End Sub

    Private Sub GetResourceAllocationLevel()
        '====================================================================
        ' Procedure Name       : GetResourceAllocationLevel
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Get the Resource allocation level
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : Aug 24, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT ResourceAllocationLevel FROM tbl_Pm_CompanyInformation"
        strQuery = "usp_sel_tbl_PM_CompanyInformation_ResourceAllocationLevel"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        m_strResourceAllocationLevel = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
    End Sub
#End Region

#Region " Database Related Procedures "
    Private Sub GetProjectInformation()
        '====================================================================
        ' Procedure Name        : GetProjectInformation
        ' Parameters Passed     : None
        ' Returns               : None 
        ' Parameters Affected   : None
        ' Purpose               : This procedure fetch the project related information from database.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================

        Dim drProject As IDataReader
        Dim strQuery As String = ""

        strQuery = "EXEC usp_Sel_tbl_PM_ProjectExpectedDates " & m_lngProjectId.ToString()
        drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
            If drProject.Read() Then
                m_strProjectStartDate = drProject.Item("ExpectedStartDate").ToString()
                m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
                m_strProjectEndDate = drProject.Item("ExpectedEndDate").ToString()
                m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date))
                m_lngRequestTeamID = CType(CommonFunctions.Data.CheckIsDBNull(drProject.Item("ResourceGroupID"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        strQuery = "Exec usp_Sel_tbl_PM_GetWorkingHours " & m_lngProjectId.ToString()
        'Modified by TruptiK on 1-Jun-09
        '  strQuery = "Exec usp_Sel_tbl_PM_Location_WorkHours_ForRequest " & m_lngProjectId.ToString()
        'End of modification by TruptiK on 1-Jun-09
        m_dblProjectWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)
    End Sub

    Private Sub GetRequestInformation()
        '====================================================================
        ' Procedure Name        : GetRequestInformation
        ' Parameters Passed     : None
        ' Returns               : None 
        ' Parameters Affected   : None
        ' Purpose               : This procedure assigns the request related information to variables.
        ' Description           : When page is rendered to itself then the request information is fetched from
        '                         controls else from database.
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================

        Dim drRequest As IDataReader
        Dim strQuery As String = ""

        If m_strAction = "" Then
            strQuery = "EXEC usp_sel_tbl_PM_ResourceRequestDetails " & m_lngRequestId.ToString()
            drRequest = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drRequest) <> "" Then
                If drRequest.Read() Then
                    m_lngRoleId = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("RoleID"), "0"), Long)
                    m_lngLocationId = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("LocationID"), "0"), Long)
                    m_strFromDate = drRequest.Item("FromDate").ToString()
                    m_strFromDate = CommonFunctions.Dates.GetDate(CType(m_strFromDate, Date))
                    m_strToDate = drRequest.Item("ToDate").ToString()
                    m_strToDate = CommonFunctions.Dates.GetDate(CType(m_strToDate, Date))
                    m_dblWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("WorkHours"), "0"), Double)
                    m_strType = CommonFunctions.General.UnBuildQueryString(drRequest.Item("Type").ToString())
                    m_intTotalResourcesAssigned = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("TotalAssignedResources"), "0"), Integer)
                    m_intTotalResourcesRequested = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("NoOfResources"), "0"), Integer)
                    m_lngDepartmentId = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("DepartmentID"), "0"), Long)
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drRequest)
        Else
            m_lngRoleId = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboRole"), "0"), Long)
            m_lngLocationId = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboOffice"), "0"), Long)
            m_strFromDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFromDate"))
            If m_strFromDate <> "" Then
                m_strFromDate = CommonFunctions.Dates.GetDate(CType(m_strFromDate, Date))
            End If
            m_strToDate = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtToDate"))
            If m_strToDate <> "" Then
                m_strToDate = CommonFunctions.Dates.GetDate(CType(m_strToDate, Date))
            End If

            If ("" & Trim(MyBase.GetFormValue("txtHours") & "") <> "") Then
                m_dblWorkHoursForFilter = CType(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtHours"), "0"), Double)
            Else
                m_dblWorkHoursForFilter = -1
            End If

            m_strType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optType"))
            m_intTotalResourcesAssigned = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("txthidAssignedResources"), "0"), Integer)
            m_intTotalResourcesRequested = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("txthidRequestedResources"), "0"), Integer)
            m_lngDepartmentId = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboDepartmentID"), "0"), Long)
            m_intSelectEmployeeType = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboEmployeeType"), "0"), Integer)
            m_lngBusinessGroupId = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboBusinessGroup"), "0"), Long)
            m_lngResourceGroupId = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboResourceGroup"), "0"), Long)
        End If

        If m_intTotalResourcesAssigned = 0 Then
            m_intTotalResourcesAssigned = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("AssignedResources"), "0"), Integer)
        End If
        If m_intTotalResourcesRequested = 0 Then
            m_intTotalResourcesRequested = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("RequestedResources"), "0"), Integer)
        End If

        strQuery = "Exec usp_Sel_tbl_PM_CompanyInformation "
        drRequest = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drRequest) <> "" Then
            If drRequest.Read() Then
                m_blnUseProjectPool = CType(CommonFunctions.Data.CheckIsDBNull(drRequest.Item("UseProjectPool"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drRequest)
        If m_blnUseProjectPool Then
            If m_intSelectEmployeeType = 0 Then m_intSelectEmployeeType = 3
        End If
    End Sub

    Private Sub AllocateResourcesAgainstRequest()
        '====================================================================
        ' Procedure Name        : AllocateResourcesAgainstRequest
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Allocates the resource against the request.
        ' Description           : When a Employee is allocated against the request then a Email is also send to the requestor.
        ' Assumptions           :
        ' Dependencies          :    
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================

        Dim strQuery As String = ""
        Dim intCtrl As Integer = 0
        Dim strTemp As String = ""
        Dim arrIdsToAssign() As String
        Dim strEmployeeIdList As String = ""
        Dim lngEmployeeId As Long = 0
        Dim blnShowPopup As Boolean = False
        Dim blnSendEmail As Boolean = False
        Dim drEmail As IDataReader
        Dim strToEmailID, strCCToEmailID, strFromEmailID, strMailSubject, strEmailMessage As String

        'Send Emails.
        m_strClientSideScript = ""
        strQuery = "Exec usp_Sel_tbl_PM_EmailMessages 76"
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)

        strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("chkAssign"))
        strEmployeeIdList = strTemp
        If strTemp <> "" Then
            arrIdsToAssign = strTemp.Split(CType(",", Char))
            For intCtrl = 0 To arrIdsToAssign.Length - 1
                lngEmployeeId = CType(CommonFunctions.General.CheckIsNothing(arrIdsToAssign(intCtrl), "0"), Long)
                strQuery = "Exec usp_Ins_tbl_PM_AssignedResources " & m_lngRequestId.ToString()
                strQuery &= ", " & m_lngProjectId.ToString()
                strQuery &= ", " & lngEmployeeId.ToString()

                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(m_strFromDate) & "'"
                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(m_strToDate) & "'"
                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(m_dblWorkHoursForFilter.ToString()) & "'"
                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optType")) & "'"
                'Added By JayavantK, On 30-Aug-2004
                strQuery &= ", " & m_lngProjectRoleID.ToString()
                'End Addition
                'Added by TruptiK on 21-Jan-09
                strQuery &= ",'" & m_status & "'"
                'end of addition by TruptiK
                strTemp = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
                If strTemp <> "" Then
                    m_strClientSideScript &= "alert('" & strTemp & "');" & vbCrLf
                End If
            Next
        End If
        If strEmployeeIdList <> "" Then
            'Send Emails
            m_strClientSideScript &= "window.opener.location=window.opener.location;" & vbCrLf
            If blnSendEmail = True Then
                If blnShowPopup = True Then
                    m_strClientSideScript &= "window.open(""../General/SendEmail.aspx?MessageID=76&RequestID=" & m_lngRequestId.ToString()
                    m_strClientSideScript &= "&EmployeeIDS=" & strEmployeeIdList & """ ,'',"
                    m_strClientSideScript &= "'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='"
                    m_strClientSideScript &= " + (window.screen.width - 600)/2 + ',top='"
                    m_strClientSideScript &= " + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf
                Else
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_76(strFromEmailID, strToEmailID, strCCToEmailID, strMailSubject, strEmailMessage, m_lngRequestId, strEmployeeIdList)
                    CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strMailSubject, strEmailMessage)
                End If
            End If
            m_intTotalResourcesAssigned = m_intTotalResourcesAssigned + arrIdsToAssign.Length()
            If m_intTotalResourcesRequested = m_intTotalResourcesAssigned Then
                m_strClientSideScript &= "window.close();" & vbCrLf
            End If
        End If
    End Sub
#End Region

#Region " List Related Procedures "
    Private Sub DisplaySkillsList()
        '====================================================================
        ' Procedure Name        : DisplaySkillsList
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This Procedure displays the skills for the Project.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim intColumnsToShow As Integer = 4
        Dim arrActualColumns() As String = {"Description", "ExpYrs", "ExpMonths", "Rating"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("SKILL"), _
                                                 MyBase.GetResourceString("EXPERIENCE") & " (" & MyBase.GetResourceString("YEARS") & ")", _
                                                 MyBase.GetResourceString("EXPERIENCE") & " (" & MyBase.GetResourceString("MONTHS") & ")", _
                                                 MyBase.GetResourceString("PROFICIENCY")}
        Dim arrstrTDStyle() As String = {"align='left' width=40%", "align='center' width=20%", _
                                         "align='center' width=20%", "align='center' width=20%"}

        m_strSkillIDs = ""
        'Build the Query using filter values.
        strQuery = "EXEC usp_Sel_tbl_PM_ProjectSkills " & m_lngProjectId.ToString() & ", " & m_lngRequestId.ToString()
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Set the Advanced Grid Properties
        With m_objSkillGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .PrimaryKey = "ToolID"
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divSkillList"
            ''commented by Nilesh g on 5/12/2015 for issue id 2637
            '.DIVHeight = 120
            .DIVHeight = 100
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

    Private Sub DisplayResourceList()
        '====================================================================
        ' Procedure Name        : DisplayResourceList
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This Procedure displays the resources which satisfied the filter criteria.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 14, 2004
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim intColumnsToShow As Integer = 8 '7
        'Dim arrActualColumns() As String = {"EmployeeName", "Office", "Department", "BusinessGroup", "Role", _
        '                            "FreeHours", "WorkHoursPerDay", MyBase.GetResourceString("RESUME"), _
        '                            MyBase.GetResourceString("RESOURCE_LOADING"), ""}



        Dim arrActualColumns() As String = {"EmployeeName", "Office", "Department", "Role", _
                                         "FreeHours", "WorkHoursPerDay", "FreePercentage", "", ""}

        'Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE_NAME"), MyBase.GetResourceString("OFFICE"), _
        '                                         MyBase.GetResourceString("DEPARTMENT"), MyBase.GetResourceString("BUSINESSGROUP"), _
        '                                         MyBase.GetResourceString("ROLE"), MyBase.GetResourceString("FREE_HRS"), _
        '                                         MyBase.GetResourceString("FREE_HRS_PER_DAY"), MyBase.GetResourceString("RESUME"), _
        'MyBase.GetResourceString("RESOURCE_LOADING"), MyBase.GetResourceString("ALLOCATE")}


        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE_NAME"), "BG/OU", _
                                              MyBase.GetResourceString("DEPARTMENT"), MyBase.GetResourceString("ROLE"), _
                                              "Total Free Hrs", "Free Hrs/Day", _
                                              "Free %", "Max ", MyBase.GetResourceString("ALLOCATE")}

        'Dim arrCheckboxID() As String = {"", "", "", "", "", "", "", "", "", "chkAssign"}


        Dim arrCheckboxID() As String = {"", "", "", "", "", "", "", "", "chkAssign"}

        Dim arrstrTDStyle() As String = {"align='left' width=20%", "align='left' width=25%", _
                                         "align='left' width=15%", "align='left' width=14%", _
                                         "align='Right' width=7%", "align='Right' width=7%", _
                                         "align='Right' width=7%", "align='right' width=7%,align=' right' width=5%"}
        'Dim arrRowLink() As String = {"", "", "", "", "", "", "", "ShowResume(EmployeeID)", "ShowResourceLoading(EmployeeID)"}

        'Dim arrRowLink() As String = {"", "", "", "", "", "", "", "", "", ""}

        If m_strType = TYPE_P Then
            arrUserFriendlyColumn(7) = arrUserFriendlyColumn(7) & "Free %"
        ElseIf m_strType = TYPE_HPD Then
            arrUserFriendlyColumn(7) = arrUserFriendlyColumn(7) & "Free Hrs/Day"
        End If

        'Build the Query using filter values.
        strQuery = BuildFilterQuery()
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Set the Advanced Grid Properties
        With m_objResourceGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .CheckBoxIDArray = arrCheckboxID
            '.RowLinkArray = arrRowLink
            .PrimaryKey = "EmployeeID"
            .EmptyValueReplacement = "&nbsp;"
            .SortBy = m_strSortBy
            .SortOrder = m_strSortOrder
            .ClientSideSortFunctionName = "Sort_OnClick"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divResourcesList"
            ''commented by Nilesh g on 5/12/2015 for issue id 2637
            ''.DIVHeight = 250
            .DIVHeight = 180
            ''end of commented by Nilesh g on 5/12/2015 for issue id 2637
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub
#End Region

#Region " Grid Event Handlers "
    Private Sub m_objSkillGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objSkillGrid.DataRowTD_BeforePrint
        Dim lngSkillID As Long = 0
        Dim strHTML As String = ""
        Dim strQuery As String = ""
        Dim strName As String = ""
        Dim strValue As String = ""

        lngSkillID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("ToolID"), "0"), Long)
        Select Case Args.ColIndex
            Case 1  'Experience Years
                m_strSkillIDs &= lngSkillID.ToString() & ","
                strName = "cboYears_" & lngSkillID.ToString()
                If Page.IsPostBack = True Then
                    strValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strName))
                Else
                    strValue = Args.DataFieldValue.ToString()
                End If
                strQuery = "Exec usp_Sel_GetYears 0,30"
                strHTML = CommonFunctions.HTMLControls.DrawComboBox(strName, strQuery, 50, strValue, , , True)
                Args.DataFieldValue = strHTML
                Args.ApplyHTMLEncode = False
                Args.ApplyDataTypeBasedFormatting = False

            Case 2  'Experience Months
                strName = "cboMonths_" & lngSkillID.ToString()
                If Page.IsPostBack = True Then
                    strValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strName))
                Else
                    strValue = Args.DataFieldValue.ToString()
                End If
                strQuery = "Exec usp_Sel_GetYears 0,11"
                strHTML = CommonFunctions.HTMLControls.DrawComboBox(strName, strQuery, 50, strValue, , , True)
                Args.DataFieldValue = strHTML
                Args.ApplyHTMLEncode = False
                Args.ApplyDataTypeBasedFormatting = False

            Case 3  'Rating / Proficiency
                strName = "cboRating_" & lngSkillID.ToString()
                If Page.IsPostBack = True Then
                    strValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strName))
                Else
                    strValue = Args.DataFieldValue.ToString()
                End If
                strQuery = "Exec usp_Sel_tbl_HR_Parameters 7"
                strHTML = CommonFunctions.HTMLControls.DrawComboBox(strName, strQuery, 150, strValue, , True, True)
                Args.DataFieldValue = strHTML
                Args.ApplyHTMLEncode = False
                Args.ApplyDataTypeBasedFormatting = False
        End Select
    End Sub

    Private Sub m_objResourceGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objResourceGrid.DataRowTD_BeforePrint
        Dim WorkHrs As Double = 0
        Dim hrsperday As Double = 0
        Dim lngEmployeeID_NEW As Long = 0

        Select Case Args.ColIndex
            'modified by harshk on 29/08/2005 sp4 issueid=120,121 
            Case 1
                Dim lngTeamID As Long = 0
                Dim strEmployeeName As String = ""
                Dim lngEmployeeID As Long = 0

                lngEmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeID"), "0"), Long)

                'lngTeamID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TeamID"), "0"), Long)
                strEmployeeName = CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("EmployeeName"), "")
                'Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidTeamID_" + lngEmployeeID.ToString(), "txthidTeamID_" + lngEmployeeID.ToString(), , , , lngTeamID.ToString(), IsHidden:=True, returnHTML:=True)
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidEmployeeName_" + lngEmployeeID.ToString(), "txthidEmployeeName_" + lngEmployeeID.ToString(), , , , strEmployeeName, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                'End modified by harshk on 29/08/2005 sp4 issueid=120,121 

                'Case 3  'Team
                '    Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Then
                '    '    Cancel = True
                '    'End If

                'Case 4  'Resource Pool
                '    Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Then
                '    '    Cancel = True
                '    'End If

                'Case 5  'OU Pool
                '    If m_strResourceAllocationLevel <> ALLOCATION_LEVEL_ODC Or m_strUserType = OU_MANAGER Then Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
                '    '    m_strUserType = OU_MANAGER Then
                '    '    Cancel = True
                '    'End If

                'Case 6  'BG Pool
                '    If m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Or m_strUserType = BG_MANAGER Then Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
                '    '    m_strUserType = OU_MANAGER Or m_strUserType = BG_MANAGER Then
                '    '    Cancel = True
                '    'End If
                'Added by TruptiK on 09-Feb-09
                'Purpose:-ThirdWare Change of Resource Allocation Percentage.
            Case 6
                lngEmployeeID_NEW = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeID"), "0"), Long)
                WorkHrs = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("Freehours"), "0"), Double)
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("hid_txtFreehours_" + lngEmployeeID_NEW.ToString(), "hid_txtFreehours_" + lngEmployeeID_NEW.ToString(), , , , WorkHrs.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Case 7
                lngEmployeeID_NEW = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeID"), "0"), Long)
                hrsperday = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("WorkHoursPerDay"), "0"), Double)
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("hid_txtWorkFreehours_" + lngEmployeeID_NEW.ToString(), "hid_txtWorkFreehours_" + lngEmployeeID_NEW.ToString(), , , , hrsperday.ToString, , , , , , IsHidden:=True, EnableHTMLEncode:=True)
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

                If m_strType = TYPE_HPD Or m_strType = TYPE_P Then

                    Dim sbHTML As New System.Text.StringBuilder
                    Dim strSQL, strControlName As String
                    Dim drMinAllocation As IDataReader
                    Dim MinAllocation As Double

                    strControlName = "txtMinAllocation_" & m_lngRequestId.ToString() & "_" & m_EmployeeID.ToString()
                    strSQL = "usp_Sel_MinAllocation_For_Employee " & m_EmployeeID.ToString & ",'" & m_strFromDate & "','" & m_strToDate & "'," & m_lngProjectId
                    drMinAllocation = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                    If drMinAllocation.Read() Then
                        If m_strType = TYPE_HPD Then
                            MinAllocation = CType(drMinAllocation.Item("MinAvailablePerDayHrs"), Double)
                        ElseIf m_strType = TYPE_P Then
                            MinAllocation = CType(drMinAllocation.Item("MinAvailablePercentage"), Double)
                        End If
                    End If

                    CommonFunction.Data.DisposeDataReader(drMinAllocation)

                    sbHTML.Append("<TD valign='top' align='right'>")
                    sbHTML.Append(MinAllocation.ToString())
                    'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                    sbHTML.Append(CommonFunctions.HTMLControls.DrawTextBox(strControlName, strControlName, , 50, , MinAllocation.ToString(), "Right", IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
                    'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                    sbHTML.Append("</TD>")
                    Args.StringToBeInserted += sbHTML.ToString()

                End If

                Cancel = True

            Case 0
                Dim intTotalCol As Integer = 11
                Dim sbHTML As New System.Text.StringBuilder
                'm_Queryid = CType(Args.DataReader("QueryID"), Integer)
                m_EmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeID"), "0"), Integer)
                sbHTML.Append("<TD>")
                sbHTML.Append("<TABLE ID='EmployeeName'  Width=99.9% class=clsGridTable cellspacing=0 cellpadding=0>")
                sbHTML.Append("<tr class=").Append(strClass).Append(">")
                sbHTML.Append("<TD>")
                'Args.TDStyle = " NoWrap title='EmployeeID'"
                'sbHTML.Append("<TD id= " + m_EmployeeID.ToString() + " name=" + m_EmployeeID.ToString() + " vAlign=top title='RquestID' nowrap;><a href=""javascript:EmployeeName_onClick(" + m_EmployeeID.ToString + " )""><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='RequestID' onclick="""" ID='imgEmployeeShowHide" & CType(m_EmployeeID, String) & "' name='imgEmployeeShowHide" & CType(m_EmployeeID, String) & "'></a>")
                'sbHTML.Append("&nbsp;&nbsp;&nbsp")
                'sbHTML.Append(Server.HtmlEncode(Args.DataReader(Args.DataField).ToString) & "</TD></TR>")
                sbHTML.Append(Server.HtmlEncode(Args.DataReader(Args.DataField).ToString) & "</TD></TR>")


                'sbHTML.Append("<TR class=").Append(strClass).Append(" id='Employee").Append(CType(m_EmployeeID, String)).Append("' name='Employee").Append(CType(m_EmployeeID, String)).Append("' width=99.9% style=""display:none"">")
                'sbHTML.Append("<TD align=left colspan=").Append(intTotalCol.ToString()).Append(">")
                'sbHTML.Append("<DIV id=EmployeeID").Append(CType(m_EmployeeID, String)).Append(" name=EmployeeID").Append(CType(m_EmployeeID, String)).Append(" style=""overflow:auto;display:none;width=99.9%;"">")

                'sbHTML.Append("<TABLE ID='EmployeeID'  Width=99.9% class=clsGridTable cellspacing=0 cellpadding=0>")
                sbHTML.Append("<tr class=").Append(strClass).Append(">")
                sbHTML.Append("<TD valign=middle align='left' id=Resume").Append(CType(m_EmployeeID, String)).Append(">")
                sbHTML.Append("<A href=""javascript:ShowResume(").Append(m_EmployeeID.ToString).Append(" )"" ><B>Resume</B></A>")
                'sbHTML.Append("</TD>")
                sbHTML.Append("&nbsp;&nbsp;|&nbsp")
                'sbHTML.Append("<tr class=").Append(strClass).Append(">")
                'sbHTML.Append("<TD valign=middle align='left' id=Resume").Append(CType(m_EmployeeID, String)).Append(">")
                sbHTML.Append("<A href=""javascript:ShowResourceLoading(").Append(m_EmployeeID.ToString).Append(" )"" ><B>Resource Loading</B></A>")
                'sbHTML.Append("</TD></TR></TABLE></DIV>")
                'sbHTML.Append("</TD></TR></TABLE>")

                'Added By nitinVS on 28 Aug 2009 
                ' to show Daily veiw of resource allocation     
                sbHTML.Append("&nbsp;|&nbsp")
                sbHTML.Append("<A href=""javascript:ShowResourceAllocation(").Append(m_EmployeeID.ToString).Append(",'").Append(m_strFromDate).Append("' )"" ><B>Resource Allocation</B></A>")
                ' End Added By nitinVS on 28 Aug 2009 

                sbHTML.Append("</TD></TR></TABLE></td>")
                Args.StringToBeInserted += sbHTML.ToString()
                Cancel = True
        End Select
        'End of addition by TruptiK on 09-Feb-09
    End Sub
    'Added by TruptiK on 12-Mar-2008
    'Purpose:-To add alert for Resource Percentage.
    Private Function GetResourcePercent() As String
        Dim objDrResourcePercentage As IDataReader
        Dim arrIdsToAssign() As String
        Dim strSQL As String
        Dim strtemp As String
        Dim strEmployeeIdList As String
        Dim intCtrl As Integer = 0
        Dim lngEmployeeId As Long = 0
        Dim ResourcePercent As Double = 0
        Dim sbHtml As System.Text.StringBuilder = New System.Text.StringBuilder
        Dim strHtml As String
        Dim arrResourceToAssign() As String
        Dim intcnt As Integer


        strtemp = Request.Params("SelectedResources")

        If strtemp <> "" Then
            strtemp = strtemp.Substring(0, strtemp.Length - 1)
            arrIdsToAssign = strtemp.Split(CType(",", Char))

            For intCtrl = 0 To arrIdsToAssign.Length - 1
                arrResourceToAssign = arrIdsToAssign(intCtrl).Split(CType("|", Char))
                strSQL = "usp_sel_ResourcePercent " & arrResourceToAssign(0).ToString
                strSQL &= ", '" & arrResourceToAssign(1).ToString & "'"
                strSQL &= ", '" & arrResourceToAssign(2).ToString & "'"
                strSQL &= ", " & m_lngProjectId.ToString()
                strSQL &= "," & arrResourceToAssign(3).ToString
                strSQL &= "," & m_lngRequestId.ToString()
                objDrResourcePercentage = CommonFunction.Data.GetDataReader(strSQL, True)
                If CommonFunctions.General.CheckIsNothing(objDrResourcePercentage) <> "" Then
                    objDrResourcePercentage.Read()
                    sbHtml.Append(objDrResourcePercentage("EmployeeID").ToString)
                    sbHtml.Append("$")
                    sbHtml.Append(objDrResourcePercentage("EmployeeName").ToString)
                    sbHtml.Append("$")
                    sbHtml.Append(CType(CommonFunction.Data.CheckIsDBNull(objDrResourcePercentage("ResourcePercentage"), "0"), Double))
                    sbHtml.Append("|")
                End If
                CommonFunctions.Data.DisposeDataReader(objDrResourcePercentage)
            Next
        End If
        CommonFunctions.Data.DisposeDataReader(objDrResourcePercentage)
        strHtml = sbHtml.ToString
        sbHtml = Nothing
        Return strHtml
    End Function
    Private Sub m_objResourceGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objResourceGrid.ColumnHeaderTD_BeforePrint
        Select Case Args.ColIndex
            'Case 3  'Team
            '    Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Then
            '    '    Cancel = True
            '    'End If

            'Case 4  'Resource Pool
            '    Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Then
            '    '    Cancel = True
            '    'End If

            'Case 5  'OU Pool
            '    If m_strResourceAllocationLevel <> ALLOCATION_LEVEL_ODC Or m_strUserType = OU_MANAGER Then Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
            '    '    m_strUserType = OU_MANAGER Then
            '    '    Cancel = True
            '    'End If

            'Case 6  'BG Pool
            '    If m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Or m_strUserType = BG_MANAGER Then Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
            '    '    m_strUserType = OU_MANAGER Or m_strUserType = BG_MANAGER Then
            '    '    Cancel = True
            '    'End If
            Case 7 ' Max Allocation
                If m_strType <> TYPE_HPD And m_strType <> TYPE_P Then
                    Cancel = True
                End If
        End Select
    End Sub
#End Region

End Class
