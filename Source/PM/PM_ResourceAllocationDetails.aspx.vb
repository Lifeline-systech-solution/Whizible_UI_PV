'******************************************************************
'           CSPL Code Header
' Project Name     :    PBNIT Enterprise
' Module Name      :    Resource Allocation Details
' Purpose          :    Displays the List of resources which are liable to allocate depending upon the 
'                       request selected to the Resource Allocator.
' Description      :    <Description>
' Assumptions      :    <Assumptions>
' Dependencies     :    <Dependencies>
' Author           :    JayavantK
' Reviewed         :    
' Tested           :    
' Created          :    April 09, 2004
' Revisions        :    
'******************************************************************
Imports System.Text

Public Class PM_ResourceAllocationDetails
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Constants Used in the Class "
    Private ALLOCATION_LEVEL_CORPORATE As String = "Corporate"
    Private ALLOCATION_LEVEL_BUSINESSGROUP As String = "Business Group"

    Private ALLOCATION_LEVEL_ODC As String = "ODC"

    Protected SEPERATOR As String = "|"
    Protected ACTION_ALLOCATE As String = "Allocate"
    Protected ACTION_DECLINE_REQUEST As String = "Decline_Request"
    Protected ACTION_SAVE_CONFIGUREDAYS As String = "Save_Configure_Days"

    Private TAB_SKILLS As Integer = 0
    Private TAB_ALLOCATED_RESOURCES As Integer = 1
    Private TAB_SIMILAR_REQUESTS As Integer = 2
    Private TAB_DECLINE_REQUEST As Integer = 3
    Protected TAB_PROBABLE_RESOURCES As Integer = 4
    Private TAB_CONFIGURE_DAYS As Integer = 5

    Protected TYPE_PER_DAY As String = "HPD"
    Protected TYPE_TOTAL_WORKHOURS As String = "TH"
    Protected TYPE_PERCENT_WORKHOURS As String = "P"

    Private Const TEAM_MANAGER As String = ",TM,"
    Private Const RESOURCE_MANAGER As String = ",RM,"
    Private Const OU_MANAGER As String = ",OUM,"
    Private Const BG_MANAGER As String = ",BGM,"
    Private Const GLOBAL_RESOURCE_MANAGER As String = ",GRM,"
    Private Const ADMIN As String = ",ADMIN,"
    Private strAvailableField As String = ""
    Private SUBTAB_HEIGHT As Integer = 175
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights

    Private m_lngTagId As Long = 0
    Protected m_lngRequestProjectId As Long = 0
    Private m_strProjectName As String = ""
    Private m_strProjectStartDate As String = ""
    Private m_strProjectEndDate As String = ""
    Private m_dblProjectWorkHours As Double = 0
    Protected m_lngRequestTeamID As Long = 0
    Protected m_lngRequestId As Long = 0
    Private m_strStatus As String = ""
    Private m_blnIsEscalatedFromTeam As Boolean = False
    Private m_blnIsEscalatedFromResourcePool As Boolean = False
    Private m_blnIsEscalatedFromOUPool As Boolean = False
    Private m_blnIsEscalatedFromBGPool As Boolean = False
    Private m_strRejectComments As String = ""
    Private m_strAction As String = ""
    Protected m_intTotalResourcesAssigned As Integer = 0
    Protected m_intTotalResourcesRequested As Integer = 0
    Private m_strFromDate As String = ""
    Private m_strToDate As String = ""
    Protected m_dblRequestedWorkHours As Double = 0
    Protected m_strType As String = ""
    Protected m_strClientSideScript As String = ""
    Protected strRequestor As String = ""
    Protected strRequestDate As String = ""
    Private m_intConfigureDays As Integer = 0
    'Added By JayavantK, On 30-Aug-2004
    Private m_lngProjectRoleID As Long = 0
    'Added by TruptiK on 21-Jan-09
    Private m_status As String = ""
    'End of addition by TruptiK on 21-Jan-09

    'End Addition
    'Added by TruptiK on 12-Mar-2008
    'Private strEmployeeIDs As String
    Protected m_ResourceAllocationPercent As String = ""
    'End of addition by TruptiK
    'Tabs variables
    Private m_objTabs As WebPages.Template.ClientSideTabs
    Protected m_intSelectedTab As Integer = 0

    'Grid Objects
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid       'Probable Resources Grid
    Private m_objSkillsGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objAllocatedResourcesGrid As New WebPages.Template.GenericGrid
    Private m_objSimilarRequestsGrid As New WebPages.Template.GenericGrid

    ' Whether logged in user is Team manager / Resource Manager / Global Resource Manager
    Private m_strUserType As String = ""

    Private m_strSortBy As String = ""
    Private m_strSortOrder As String = ""
    Private m_EmployeeID As Long
    Private strClass As String = "clsTRodd"

    'Resource Allocation Level
    Private m_strResourceAllocationLevel As String = ""
#End Region

#Region " Page and Class Events "
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load

        ' RequestID:"<%=m_lngRequestID%>",ResRequested:"<%=m_intTotalResourcesRequested%>",ResAssigned:"<%=m_intTotalResourcesAssigned%>"

        If (Request.QueryString("Token") <> "" And Request.QueryString("RequestID") <> "" And Request.QueryString("ResAssigned") <> "") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("RequestID"), String) + CType(Request.QueryString("ResRequested"), String) + CType(Request.QueryString("ResAssigned"), String) + "0" + "0", Request.QueryString("Token")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("RequestID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If

        End If
        ''Added by Shamkant S  on 16/02/2016 to validate Token
        If (Request.QueryString("Token") <> "" And Request.QueryString("RequestID") <> "" And Request.QueryString("Mode1") <> "DeclineRequest") Then
            If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("RequestID"), String) + "0" + "0", Request.QueryString("Token")) = False) Then
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("RequestID"), String))
                'Token is Invalid now redirect to the Invalid Access Page
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")


            End If

        End If
        ''End of addiotion by Shamkant S  on 16/02/2016 to validate Token
        ' ''commented by nilesh g on 31/12/2015 for Security
        'If Trim(Request.ServerVariables("HTTP_REFERER")) = "" Then
        '    Response.Write(vbCrLf + "<script>")
        '    Response.Write(vbCrLf + "		if (window.opener == null)")
        '    Dim strRedirectToPage As String = CommonFunction.General.GetLogOutPage.ToString
        '    If strRedirectToPage.Trim = "" Then
        '        Response.Write(vbCrLf + "		    window.open('../../Default.aspx?Message=InvalidLogin','_top');")
        '    Else
        '        Response.Write(vbCrLf + "		    window.open('" + strRedirectToPage + "','_top');")
        '    End If
        '    Response.Write(vbCrLf + "</script>")
        'End If
        ' ''end of commented by nilesh g on 31/12/2015 for Security
        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()

        GetUserType()
        GetResourceAllocationLevel()
        m_lngTagId = m_objGlobal.TagID
        m_lngRequestProjectId = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("ProjectID"), "0"), Long)
        m_lngRequestId = CType(CommonFunctions.General.CheckIsNothing("0" & Request.QueryString("RequestID"), "0"), Long)
        m_strSortBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortBy"), "")
        m_strSortBy = CommonFunctions.General.UnBuildQueryString(m_strSortBy)
        m_strSortOrder = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txthidSortOrder"), "")
        If m_strSortBy = "" Then m_strSortBy = "Role"
        If m_strSortOrder = "" Then m_strSortOrder = "ASC"

        'Added By JayavantK, On 30-Aug-2004
        m_lngProjectRoleID = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("cboProjectRole"), "0"), Long)
        'Added by TruptiK on 21-Jan-09
        m_status = CommonFunctions.General.CheckIsNothing("" & MyBase.GetFormValue("cboStatus"), "")
        'End of addition by TruptiK
        'End Addition

        'Get the Selected Tab Index
        m_intSelectedTab = CType(CommonFunctions.General.CheckIsNothing("0" & MyBase.GetFormValue("txthidSelectedTabIndex"), "0"), Integer)
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))

        If m_strAction = ACTION_ALLOCATE Then
            m_intSelectedTab = TAB_PROBABLE_RESOURCES
            'Addition 
            'Commented by TruptiK on 9-Feb-09
            'Purpose:-ThirdWare Change of Resource Allocation Percentage.
            'If Request.Params("FromXML") = "1" Then
            '    Response.Clear()
            '    Response.Write(GetResourcePercent)
            '    Response.End()
            'End If
            'End of commented by TrupitK
            AllocateResourcesAgainstRequest()
        ElseIf m_strAction = ACTION_DECLINE_REQUEST Then
            m_intSelectedTab = TAB_DECLINE_REQUEST
            DeclineTheRequest()
            m_strClientSideScript += "var strParentPage;" + vbCrLf
            m_strClientSideScript += "strParentPage = new String();" + vbCrLf
            m_strClientSideScript += "strParentPage = window.opener.location.href;" + vbCrLf
            m_strClientSideScript += "if (strParentPage.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
            m_strClientSideScript += "{ window.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
            m_strClientSideScript += "window.opener.document.forms['frmPM_ResourceAllocation'].submit();}" + vbCrLf
            m_strClientSideScript += "else" + vbCrLf
            m_strClientSideScript += "{ var strParentPages;" + vbCrLf
            m_strClientSideScript += "strParentPages = new String();" + vbCrLf
            m_strClientSideScript += "strParentPages = window.opener.opener.location.href;" + vbCrLf
            m_strClientSideScript += "if (strParentPages.toUpperCase().indexOf('PM_RESOURCEALLOCATION.ASPX') != -1)" + vbCrLf
            m_strClientSideScript += "{ window.opener.opener.document.forms['frmPM_ResourceAllocation'].action = '../PM/PM_ResourceAllocation.aspx?FromWhere=RM&MasterTagID=1225';" + vbCrLf
            m_strClientSideScript += "window.opener.opener.document.forms['frmPM_ResourceAllocation'].submit();" + vbCrLf
            m_strClientSideScript += "window.opener.close();}}" + vbCrLf
            m_strClientSideScript += "window.close();" + vbCrLf
            m_strClientSideScript += "</script>"
            'm_strClientSideScript = "window.opener.location=window.opener.location;" & vbCrLf
            'm_strClientSideScript &= "window.close();"
        ElseIf m_strAction = ACTION_SAVE_CONFIGUREDAYS Then
            m_intSelectedTab = TAB_CONFIGURE_DAYS
            Save_ConfigureDays()
        End If

    End Sub
    ''Added By Shamkant S on 16 feb 2016
    <System.Web.Services.WebMethod> _
    Public Shared Function Resume_OnClick(EmployeeID As String) As String
        Try
            Dim m_PKToken_Request_Task As String
            m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + "0" + "0")

            Return m_PKToken_Request_Task
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''Added By Shamkant S on 16 feb 2016

    <System.Web.Services.WebMethod> _
    Public Shared Function DeclineRequest_OnClick(RequestID As String, ResRequested As String, ResAssigned As String) As String
        Try
            Dim m_PKToken_Request_Task As String
            m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken(CType(RequestID, String) + CType(ResRequested, String) + CType(ResAssigned, String) + "0" + "0")

            Return m_PKToken_Request_Task
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ResourceLoad_OnClick(EmployeeID As String, Year As String) As String
        Try
            Dim m_PKToken_Request_Task As String
            m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(Year, String) + "0" + "0")

        Return m_PKToken_Request_Task
        Catch ex As Exception
        Return "Bad Request Found"
        End Try
    End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function ResourceAlloc_OnClick(EmployeeID As String, FinancialPeriodCount As String, SpecificDate As String) As String
        Try
            Dim m_PKToken_Request_Task As String
            m_PKToken_Request_Task = CommonFunctions.Security.Token.GetToken(CType(EmployeeID, String) + CType(FinancialPeriodCount, String) + CType(SpecificDate, String) + "0" + "0")

            Return m_PKToken_Request_Task
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    'Ended By Shamkant S on 16 Feb 2016
    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objSkillsGrid = Nothing
        m_objAllocatedResourcesGrid = Nothing
        m_objSimilarRequestsGrid = Nothing

        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Public Sub PageInit()
        Dim strRightCaption As String = ""
        Dim strcentercaption As String = ""
        Dim strHeaderHTML As String = ""
        Dim strQuery As String = ""
        'Dim objHeaderFooter As WebPages.Template.HeaderFooter
        'Added By NileshD on 10 Jan 2005
        'Added by TruptiK on 11-Mar-2008

        If CommonFunctions.General.CheckIsNothing(Request.QueryString("mode1"), "") <> "" Then
            DisplayDeclineRequestTab()
        End If

        strQuery = "Exec usp_sel_ResourcePercentage_tbl_sem_settings"
        m_ResourceAllocationPercent = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
        'CommonFunctions.HTMLControls.DrawTextBox("txthidResourcePercentage", "txthidResourcePercentage", , , , m_ResourceAllocationPercent, , , , , , True)
        'End of addition by TrupitK on 11-Mar-2008
        If m_strAction <> ACTION_DECLINE_REQUEST Then
            If CommonFunctions.General.CheckIsNothing(Request.QueryString("mode1"), "") = "" Then
                'Get the Request details in HTML Tags
                strHeaderHTML = GetRequestDetails()
                'Get the Projects information
                GetProjectInformation()

                'Display the Menu
                CommonFunctions.General.WriteHTML(DisplayMenu())
                CommonFunctions.General.WriteHTML("<BR>")

                'Display the Page Caption
                'strRightCaption = MyBase.GetResourceString("PROJECT") & " : " & m_strProjectName.ToString()

                'strRightCaption = "Requested By" & " : " & strRequestor.ToString()
                'strcentercaption = "Request ID" & " : " & m_lngRequestId.ToString()
                'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_TITLE"), strRightCaption, strcentercaption, True))
                CommonFunctions.General.WriteHTML("<Table class='clsTable' width='99.9%' border=0 cellpadding=0 cellspacing=0>")
                CommonFunctions.General.WriteHTML("<Tr class='clsTREven'>")
                CommonFunctions.General.WriteHTML("<TD width=30%><b>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PAGE_TITLE"))
                CommonFunctions.General.WriteHTML("</b>")
                'CommonFunctions.General.WriteHTML("<TD width=15%><b>")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<b>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("REQUESTID"))
                'CommonFunctions.General.WriteHTML("</b></TD><TD width=15% nowrap=false><b>")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp:")
                CommonFunctions.General.WriteHTML("</b>&nbsp;&nbsp;&nbsp<b>")
                CommonFunctions.General.WriteHTML(m_lngRequestId.ToString())
                'CommonFunctions.General.WriteHTML("</b></TD>")
                CommonFunctions.General.WriteHTML("</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp<b>")
                'CommonFunctions.General.WriteHTML("</TD>")
                'CommonFunctions.General.WriteHTML("<TD width=15>")
                CommonFunctions.General.WriteHTML("Requested on")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp:")
                CommonFunctions.General.WriteHTML("</b>&nbsp;&nbsp;&nbsp<b>")
                CommonFunctions.General.WriteHTML(strRequestDate)
                'CommonFunctions.General.WriteHTML("</TD>")
                'CommonFunctions.General.WriteHTML("<TD width=15>")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp")
                CommonFunctions.General.WriteHTML("Requested By")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp:")
                CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;")
                CommonFunctions.General.WriteHTML(strRequestor)
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR></table>")

                CommonFunctions.General.WriteHTML("<BR>")

                CommonFunctions.General.WriteHTML("<DIV ID='PageDiv' style='overflow:auto;width:100%'>")
                CommonFunctions.General.WriteHTML(strHeaderHTML)
                CommonFunctions.General.WriteHTML("<BR>")
                'GetResourcePercent()
                'Create the Tabs
                CreateTabs()
                CommonFunctions.General.WriteHTML("</DIV>")

                'Display the Menu at Bottom
                CommonFunctions.General.WriteHTML("<BR>")
                CommonFunctions.General.WriteHTML(DisplayMenu())

                'The Hidden Fields
                Dim TotalHours As Double

                ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strQuery = "select sum(workhours) from tbl_pm_assignedresources where requestid=" & m_lngRequestId
                strQuery = "usp_tbl_pm_assignedresources_workhours " & m_lngRequestId
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                TotalHours = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)

                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txthidProjectFromDate", "txthidProjectFromDate", value:=m_strProjectStartDate, IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidProjectToDate", "txthidProjectToDate", value:=m_strProjectEndDate, IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidProjectWorkHours", "txthidProjectWorkHours", value:=m_dblProjectWorkHours.ToString(), IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidSelectedTabIndex", "txthidSelectedTabIndex", value:=m_intSelectedTab.ToString(), IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidSortBy", "txthidSortBy", , , , m_strSortBy, , , , , , True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidSortOrder", "txthidSortOrder", , , , m_strSortOrder, , , , , , True, EnableHTMLEncode:=True)

                CommonFunctions.HTMLControls.DrawTextBox("txthidRequestFromDate", "txthidRequestFromDate", value:=m_strFromDate, IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidRequestToDate", "txthidRequestToDate", value:=m_strToDate, IsHidden:=True, EnableHTMLEncode:=True)

                CommonFunctions.HTMLControls.DrawTextBox("txthidResourceRequested", "txthidResourceRequested", value:=m_intTotalResourcesRequested.ToString, IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidResourceAssigned", "txthidResourceAssigned", value:=m_intTotalResourcesAssigned.ToString, IsHidden:=True, EnableHTMLEncode:=True)
                CommonFunctions.HTMLControls.DrawTextBox("txthidTotalHrs", "txthidTotalHrs", value:=TotalHours.ToString, IsHidden:=True, EnableHTMLEncode:=True)
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                'End Of Addition
            End If
        End If

    End Sub

    Public Sub New()
        ''Commented and Added by Dhanashri S on 10 Oct 2016 For SQL Injection,Cross Scripting
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Comment and Addition by Dhanashri S on 10 Oct 2016
        MyBase.InitializeResources("AppResources.PM_ResourceAllocationDetails", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
#End Region

#Region " Common Functions or Procedures "
    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ResourceAllocationDetails : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Function DisplayMenu(Optional ByVal intTabID As Integer = -1) As String
        '====================================================================
        ' Procedure Name        : DisplayMenu
        ' Parameters Passed     : intTabID is the Tab number.
        ' Returns               : The HTML string for Menu.
        ' Parameters Affected   : None
        ' Purpose               : Depending upon the intTabID the specific menu string is generated.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 09, 2004
        ' Revisions             : 22nd June 2004.
        '=====================================================================
        Dim strReturn As String = ""
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim intNoMenuItems As Integer = 0
        Dim intTemp As Integer = 0

        'Added By VarunA on 15-Mar-2008
        'Purpose : To have different help for Sub Tabs and Main Page Help
        If intTabID = -1 Then
            m_lngTagId = 2345
        Else
            m_lngTagId = 2346
        End If
        'End By VarunA on 15-Mar-2008

        If intTabID = TAB_SKILLS Then
            intNoMenuItems = 1
        ElseIf intTabID = TAB_ALLOCATED_RESOURCES Then
            intNoMenuItems = 1
        ElseIf intTabID = TAB_SIMILAR_REQUESTS Then
            intNoMenuItems = 1
        ElseIf intTabID = TAB_DECLINE_REQUEST Then
            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                intNoMenuItems = 2
            Else
                intNoMenuItems = 1
            End If
        ElseIf intTabID = TAB_PROBABLE_RESOURCES Then
            'Commented and modified by SanaS for hiding Search by name 17-Nov-2009
            'intNoMenuItems = 4
            intNoMenuItems = 3
            'End Comment and modification by SanaS for hiding Search by name 17-Nov-2009

        ElseIf intTabID = TAB_CONFIGURE_DAYS Then
            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                intNoMenuItems = 2
            Else
                intNoMenuItems = 1
            End If
        Else    'Menu for Main Page
            If m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC Then
                If m_intTotalResourcesAssigned = m_intTotalResourcesRequested Then
                    intNoMenuItems = 2
                Else
                    If m_blnIsEscalatedFromOUPool = True Then
                        intNoMenuItems = 5
                    Else
                        intNoMenuItems = 4
                    End If
                End If
            ElseIf m_strResourceAllocationLevel = ALLOCATION_LEVEL_BUSINESSGROUP Then
                If m_intTotalResourcesAssigned = m_intTotalResourcesRequested Then
                    intNoMenuItems = 2
                Else
                    intNoMenuItems = 4
                End If
            ElseIf m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Then
                If m_intTotalResourcesAssigned = m_intTotalResourcesRequested Then
                    intNoMenuItems = 2
                Else
                    intNoMenuItems = 3
                End If
            End If
        End If

        '    Select Case m_strUserType
        '        Case GLOBAL_RESOURCE_MANAGER
        '            intNoMenuItems = 6 - intTemp

        '        Case ADMIN
        '            If m_blnIsEscalatedFromBGPool = True Then
        '                intNoMenuItems = 6 - intTemp
        '            ElseIf m_blnIsEscalatedFromOUPool = True Then
        '                intNoMenuItems = 5 - intTemp
        '            ElseIf m_blnIsEscalatedFromResourcePool = True Then
        '                intNoMenuItems = 4
        '            ElseIf m_blnIsEscalatedFromTeam = True Then
        '                intNoMenuItems = 3
        '            Else
        '                intNoMenuItems = 2
        '            End If

        '        Case TEAM_MANAGER
        '            If m_intTotalResourcesAssigned = m_intTotalResourcesRequested And m_blnIsEscalatedFromTeam = False Then
        '                intNoMenuItems = 2
        '            Else
        '                intNoMenuItems = 3
        '            End If

        '        Case RESOURCE_MANAGER
        '            If m_intTotalResourcesAssigned = m_intTotalResourcesRequested And m_blnIsEscalatedFromResourcePool = False Then
        '                intNoMenuItems = 3
        '            Else
        '                intNoMenuItems = 4
        '            End If

        '        Case OU_MANAGER
        '            If m_intTotalResourcesAssigned = m_intTotalResourcesRequested And m_blnIsEscalatedFromOUPool = False Then
        '                intNoMenuItems = 4 - intTemp
        '            Else
        '                intNoMenuItems = 5 - intTemp
        '            End If

        '        Case BG_MANAGER
        '            If m_intTotalResourcesAssigned = m_intTotalResourcesRequested And m_blnIsEscalatedFromBGPool = False Then
        '                intNoMenuItems = 5 - intTemp
        '            Else
        '                intNoMenuItems = 6 - intTemp
        '            End If
        '    End Select
        'End If

        Dim arrMenuItem(intNoMenuItems - 1) As String
        Dim arrMenuTooltip(intNoMenuItems - 1) As String
        Dim arrClientSideFunctions(intNoMenuItems - 1) As String
        Dim intMenuIndex As Integer = 0

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        If intTabID = TAB_DECLINE_REQUEST Then
            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_DECLINE_REQUEST")
                arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_DECLINE_REQUEST_TOOLTIP")
                arrClientSideFunctions(intMenuIndex) = "DeclineRequest()"
                intMenuIndex = intMenuIndex + 1
            End If
        ElseIf intTabID = TAB_PROBABLE_RESOURCES Then

            'arrMenuItem(intMenuIndex) = "Search By Name"
            'arrMenuTooltip(intMenuIndex) = "Search By Name"
            'arrClientSideFunctions(intMenuIndex) = "SearchByName_OnClick()"
            'intMenuIndex = intMenuIndex + 1

            arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_SHOW_MORE")
            arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_SHOW_MORE")
            arrClientSideFunctions(intMenuIndex) = "ShowMore_OnClick()"
            intMenuIndex = intMenuIndex + 1

            arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ALLOCATE_RESOURCE")
            arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ALLOCATE_RESOURCE_TOOLTIP")
            arrClientSideFunctions(intMenuIndex) = "Allocate_OnClick()"
            intMenuIndex = intMenuIndex + 1

        ElseIf intTabID = TAB_CONFIGURE_DAYS Then
            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_SAVE")
                arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_SAVE_TOOLTIP")
                arrClientSideFunctions(intMenuIndex) = "SaveConfigureDays_OnClick()"
                intMenuIndex = intMenuIndex + 1
            End If
        ElseIf intTabID = -1 Then  'Menu for Main page
            'arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_RESOURCES_PROJECT_LOCATION")
            'arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_RESOURCES_PROJECT_LOCATION_TOOLTIP")
            'arrClientSideFunctions(intMenuIndex) = "ResourceAtProjectLocation_OnClick()"
            'intMenuIndex = intMenuIndex + 1

            'If m_blnIsEscalatedFromTeam = False Then
            '    If m_intTotalResourcesAssigned <> m_intTotalResourcesRequested And m_strUserType = TEAM_MANAGER Then
            '        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_TM")
            '        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_TM_TOOLTIP")
            '        arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OnClick()"
            '        intMenuIndex = intMenuIndex + 1
            '    End If
            'Else
            '    arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_TM_ESCALATE_COMMENTS")
            '    arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_TM_ESCALATE_COMMENTS_TOOLTIP")
            '    arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OnClick()"
            '    intMenuIndex = intMenuIndex + 1
            'End If
            'If m_strUserType <> TEAM_MANAGER Then
            '    If m_blnIsEscalatedFromResourcePool = False Then
            '        If m_intTotalResourcesAssigned <> m_intTotalResourcesRequested And m_strUserType = RESOURCE_MANAGER Then
            '            arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_RM")
            '            arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_RM_TOOLTIP")
            '            arrClientSideFunctions(intMenuIndex) = "EscalateRequest_RM_OnClick()"
            '            intMenuIndex = intMenuIndex + 1
            '        End If
            '    Else
            '        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_RM_ESCALATE_COMMENTS")
            '        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_RM_ESCALATE_COMMENTS_TOOLTIP")
            '        arrClientSideFunctions(intMenuIndex) = "EscalateRequest_RM_OnClick()"
            '        intMenuIndex = intMenuIndex + 1
            '    End If

            '    If m_strUserType <> RESOURCE_MANAGER Then
            '        If m_blnIsEscalatedFromOUPool = False Then
            '            If m_intTotalResourcesAssigned <> m_intTotalResourcesRequested And m_strUserType = OU_MANAGER Then
            '                arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_OUM")
            '                arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_OUM_TOOLTIP")
            '                arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OUM_OnClick()"
            '                intMenuIndex = intMenuIndex + 1
            '            End If
            '        Else
            '            arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_OUM_ESCALATE_COMMENTS")
            '            arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_OUM_ESCALATE_COMMENTS_TOOLTIP")
            '            arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OUM_OnClick()"
            '            intMenuIndex = intMenuIndex + 1
            '        End If

            '        If m_strUserType <> OU_MANAGER Then
            '            If m_blnIsEscalatedFromBGPool = False Then
            '                If m_intTotalResourcesAssigned <> m_intTotalResourcesRequested And m_strUserType = BG_MANAGER Then
            '                    arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_BGM")
            '                    arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_BGM_TOOLTIP")
            '                    arrClientSideFunctions(intMenuIndex) = "EscalateRequest_BGM_OnClick()"
            '                    intMenuIndex = intMenuIndex + 1
            '                End If
            '            Else
            '                arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_BGM_ESCALATE_COMMENTS")
            '                arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_BGM_ESCALATE_COMMENTS_TOOLTIP")
            '                arrClientSideFunctions(intMenuIndex) = "EscalateRequest_BGM_OnClick()"
            '                intMenuIndex = intMenuIndex + 1
            '            End If
            '        End If
            '    End If
            'End If

            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_DECLINE_REQUEST")
                arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_DECLINE_REQUEST_TOOLTIP")
                arrClientSideFunctions(intMenuIndex) = "DeclineRequest()"
                intMenuIndex = intMenuIndex + 1

            End If

            'Added by TruptiK on 11-Nov-08
            'Purpose:-To set the alert if approver is not set.
            Dim strsql As String
            Dim m_Manager As String
            Dim level As String
            Dim BusinessGroup As String
            Dim drManager As IDataReader
            strsql = "exec usp_sel_approvers " & m_lngRequestId & ",'" & m_strResourceAllocationLevel & "'"
            drManager = CommonFunctions.Data.GetDataReader(strsql, MyBase.UseSQL)
            If drManager.Read Then
                m_Manager = CType(CommonFunctions.Data.CheckIsDBNull(drManager("Employeename"), ""), String)
                level = CType(CommonFunctions.Data.CheckIsDBNull(drManager("Level"), ""), String)
                BusinessGroup = CType(CommonFunctions.Data.CheckIsDBNull(drManager("BusinessGroup"), ""), String)
            End If

            CommonFunction.Data.DisposeDataReader(drManager)

            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                If m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC Then
                    If m_blnIsEscalatedFromOUPool = False Then
                        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_OUM")
                        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_OUM_TOOLTIP")
                        'arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OUM_OnClick()"

                        arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OUM_OnClick(1,'" + m_Manager + "','" + level + "','" + BusinessGroup + "')"
                        intMenuIndex = intMenuIndex + 1
                    Else
                        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_OUM_ESCALATE_COMMENTS")
                        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_OUM_ESCALATE_COMMENTS_TOOLTIP")
                        arrClientSideFunctions(intMenuIndex) = "EscalateRequest_OUM_OnClick(0,'" + m_Manager + "','" + level + "','" + BusinessGroup + "')"
                        intMenuIndex = intMenuIndex + 1
                    End If
                End If


                If (m_strResourceAllocationLevel = ALLOCATION_LEVEL_ODC And m_blnIsEscalatedFromOUPool = True) Or _
                    m_strResourceAllocationLevel = ALLOCATION_LEVEL_BUSINESSGROUP Then
                    If m_blnIsEscalatedFromBGPool = False Then
                        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_BGM")
                        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_ESCALATE_REQUEST_BGM_TOOLTIP")
                        'arrClientSideFunctions(intMenuIndex) = "EscalateRequest_BGM_OnClick()"
                        arrClientSideFunctions(intMenuIndex) = "EscalateRequest_BGM_OnClick(1,'" + m_Manager + "','" + level + "')"
                        intMenuIndex = intMenuIndex + 1
                    Else
                        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_BGM_ESCALATE_COMMENTS")
                        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_VIEW_BGM_ESCALATE_COMMENTS_TOOLTIP")
                        'arrClientSideFunctions(intMenuIndex) = "EscalateRequest_BGM_OnClick()"
                        arrClientSideFunctions(intMenuIndex) = "EscalateRequest_BGM_OnClick(0,'" + m_Manager + "','" + level + "')"
                        intMenuIndex = intMenuIndex + 1
                    End If
                End If
            End If

            arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_CLOSE")
            arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
            If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
                ' arrClientSideFunctions(intMenuIndex) = "CloseWindow()"
                arrClientSideFunctions(intMenuIndex) = "Close_OnClick()"

            Else
                '  arrClientSideFunctions(intMenuIndex) = "Close_OnClick()"
                arrClientSideFunctions(intMenuIndex) = "CloseWindow()"

            End If
            intMenuIndex = intMenuIndex + 1
        End If

        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_HELP")
        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunctions(intMenuIndex) = "Help_OnClick(" & m_lngTagId.ToString() & ")"

        strReturn = objMenu.DrawMenuWithEvents(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True)

        MyBase.InitializeResources("AppResources.PM_ResourceAllocationDetails", "AppResources")

        Return strReturn
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
        '''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strQuery = "SELECT ResourceAllocationLevel FROM tbl_Pm_CompanyInformation"
        strQuery = "usp_sel_tbl_PM_CompanyInformation_ResourceAllocationLevel"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        m_strResourceAllocationLevel = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
    End Sub
#End Region

#Region " Functions / Procedures related to Tabs "
    Private Sub CreateTabs()
        '====================================================================
        ' Procedure Name       : CreateTabs
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Create the Tabs by assigning values to the properties of Tabs objects
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 21, 2004
        ' Revisions            : 
        '=====================================================================
        'Dim arrTabName() As String = {MyBase.GetResourceString("SKILLS"), _
        '                              MyBase.GetResourceString("ALLOCATED_RESOURCES"), _
        '                              'MyBase.GetResourceString("SIMILAR_REQUESTS"), _
        ''MyBase.GetResourceString("DECLINE_REQUEST"), _
        '                              MyBase.GetResourceString("PROBABLE_RESOURCES"), _
        '                              MyBase.GetResourceString("CONFIGURE_DAYS")}

        'Modified by Sanas To remove Decline request Subtab 8-Oct-2009 As Decline request Link is already there
        'Dim arrTabName() As String = {MyBase.GetResourceString("SKILLS"), _
        '                              MyBase.GetResourceString("ALLOCATED_RESOURCES"), _
        '                              MyBase.GetResourceString("SIMILAR_REQUESTS"), _
        '                              MyBase.GetResourceString("DECLINE_REQUEST"), _
        '                              MyBase.GetResourceString("PROBABLE_RESOURCES"), _
        '                              MyBase.GetResourceString("CONFIGURE_DAYS")}
        'Dim arrTabToolTip() As String = {MyBase.GetResourceString("SKILLS"), _
        '                              MyBase.GetResourceString("ALLOCATED_RESOURCES"), _
        '                                 MyBase.GetResourceString("SIMILAR_REQUESTS"), _
        '                                 MyBase.GetResourceString("DECLINE_REQUEST"), _
        '                            MyBase.GetResourceString("PROBABLE_RESOURCES"), _
        '                                 MyBase.GetResourceString("CONFIGURE_DAYS")}
        'Dim arrDIVID() As String = {"divSkills", "divAllocatedResources", "divSimilarRequests", _
        '                            "divDeclineRequest", "divProbableResources", "divConfigureDays"}

        Dim arrTabName() As String = {MyBase.GetResourceString("SKILLS"), _
                                     MyBase.GetResourceString("ALLOCATED_RESOURCES"), _
                                     MyBase.GetResourceString("SIMILAR_REQUESTS"), _
                                     MyBase.GetResourceString("PROBABLE_RESOURCES"), _
                                     MyBase.GetResourceString("CONFIGURE_DAYS")}
        Dim arrTabToolTip() As String = {MyBase.GetResourceString("SKILLS"), _
                                      MyBase.GetResourceString("ALLOCATED_RESOURCES"), _
                                         MyBase.GetResourceString("SIMILAR_REQUESTS"), _
                                    MyBase.GetResourceString("PROBABLE_RESOURCES"), _
                                         MyBase.GetResourceString("CONFIGURE_DAYS")}
        Dim arrDIVID() As String = {"divSkills", "divAllocatedResources", "divSimilarRequests", _
                                     "divProbableResources", "divConfigureDays"}
        'End Modified by Sanas To remove Decline request Subtab 8-Oct-2009 As Decline request Link is already there
        'create Tab object
        m_objTabs = New WebPage.Templates.ClientSideTabs
        With m_objTabs
            .TabNameArray = arrTabName
            .TooltipArray = arrTabToolTip
            .TabOnclickFunctionName = "Tab_OnClick"
            .ReturnHTML = False
            .Align = "RIGHT"
            .FormName = "frmPM_ResourceAllocationDetails"
            .SelectedTab = arrTabName(0)
            .DIVIDArray = arrDIVID
            CommonFunctions.General.WriteHTML(.DrawTabs())
            Response.Write(.ClientSideScript)
        End With
        m_objTabs = Nothing

        'Plot the Contents of Tabs
        CommonFunctions.General.WriteHTML("<Table class=clsSubTagTable width=99.9% cellpadding=0 cellspacing=0>")
        CommonFunctions.General.WriteHTML("<Tr><Td>")
        'Skills Tab
        CommonFunctions.General.WriteHTML("<div id=divSkills style='overflow:auto;'>")
        DisplaySkillsTab()
        CommonFunctions.General.WriteHTML("</div>")
        'Allocated Resources Tab
        CommonFunctions.General.WriteHTML("<div id=divAllocatedResources style='overflow:auto;display:None'>")
        DisplayAllocatededResourcesTab()
        CommonFunctions.General.WriteHTML("</div>")
        'Similar requests Tab
        CommonFunctions.General.WriteHTML("<div id=divSimilarRequests style='overflow:auto;display:None'>")
        DisplaySimilarRequestsTab()
        CommonFunctions.General.WriteHTML("</div>")
        'Commented by Sanas To remove Decline request Subtab 8-Oct-2009 As Decline request Link is already there
        'Decline request Tab
        'CommonFunctions.General.WriteHTML("<div id=divDeclineRequest style='overflow:auto;display:None'>")
        'DisplayDeclineRequestTab()
        'CommonFunctions.General.WriteHTML("</div>")
        'End Commented by Sanas To remove Decline request Subtab 8-Oct-2009
        'Probable Resources Tab
        CommonFunctions.General.WriteHTML("<div id=divProbableResources style='overflow:auto;display:None'>")
        DisplayProbableResourcesTab()
        'Added by Harshk for resource joining date validation whiziblesemsp4 issueid 120,121 
        Dim strQuery As String
        strQuery = "usp_tbl_PM_Employee_GetResourceJoiningDate"
        CommonFunctions.HTMLControls.DrawComboBox("cboJoiningDate", strQuery, , , , , , , , , True)
        'End Added by Harshk for resource joining date validation whiziblesemsp4 issueid 120,121 
        CommonFunctions.General.WriteHTML("</div>")
        'Configure Days Tab
        CommonFunctions.General.WriteHTML("<div id=divConfigureDays style='overflow:auto;display:None'>")
        DisplayConfigureDaysTab()
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("</Td></Tr></Table>")
    End Sub

    Private Sub DisplaySkillsTab()
        '====================================================================
        ' Procedure Name       : DisplaySkillsTab
        ' Parameters Passed    : None
        ' Returns              : Displays the List of Skills of the Request.
        ' Parameters Affected  : None
        ' Purpose              : 
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 21, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim intColumnsToShow As Integer = 4
        Dim arrActualColumns() As String = {"Description", "ExpYrs", "ExpMonths", "ParameterValue"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("SKILL"), _
                                                 MyBase.GetResourceString("EXPERIENCE") & " (" & MyBase.GetResourceString("YEARS") & ")", _
                                                 MyBase.GetResourceString("EXPERIENCE") & " (" & MyBase.GetResourceString("MONTHS") & ")", _
                                                 MyBase.GetResourceString("PROFICIENCY")}
        Dim arrstrTDStyle() As String = {"align='left' width=30%", "align='right' width=20%", "align='right' width=20%", _
                                         "align='center' width=30%"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_SKILLS))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the SubTag Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SKILLS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        strQuery = "EXEC usp_Sel_tbl_PM_ResourceRequestDetails_Skills " & m_lngRequestId.ToString()
        'Set the Advanced Grid Properties
        With m_objSkillsGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .PrimaryKey = "UniqueID"
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divSkillList"
            .DIVHeight = SUBTAB_HEIGHT
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_SKILLS))

    End Sub

    Private Sub DisplayAllocatededResourcesTab()
        '====================================================================
        ' Procedure Name       : DisplayAllocatededResourcesTab
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Shows the Assigned Resources against the request.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 22, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim intColumnsToShow As Integer = 6
        Dim arrActualColumns() As String = {"EmployeeName", "AssignmentDate", "FromDate", _
                                    "ToDate", "WorkHours", "Status"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE_NAME"), MyBase.GetResourceString("ASSIGNMENT_DATE"), _
                                                 MyBase.GetResourceString("FROM_DATE"), MyBase.GetResourceString("TO_DATE"), _
                                                 MyBase.GetResourceString("WORK_HOURS"), MyBase.GetResourceString("STATUS")}
        Dim arrstrTDStyle() As String = {"align='left' width=30%", "align='left' width=15% NoWrap", "align='left' width=15% NoWrap", _
                                         "align='left' width=15% NoWrap", "align='Right' width=10%", "align='center' width=15% NoWrap"}
        Dim arrRowLink() As String = {"", "", "", "", "", "ShowRejectComments(AssignmentID)"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_ALLOCATED_RESOURCES))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the SubTag Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("ALLOCATED_RESOURCES"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        strQuery = "Exec usp_Sel_tbl_PM_AssignedResources " & m_lngRequestId.ToString()
        'Set the Advanced Grid Properties
        With m_objAllocatedResourcesGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .RowLinkArray = arrRowLink
            .PrimaryKey = "AssignmentID"
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divAllocatedResourcesList"
            .DIVHeight = SUBTAB_HEIGHT
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_ALLOCATED_RESOURCES))
    End Sub

    Private Sub DisplaySimilarRequestsTab()
        '====================================================================
        ' Procedure Name       : DisplaySimilarRequestsTab
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Displays the list of requests similar the selected one.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 22, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""
        Dim intColumnsToShow As Integer = 2
        Dim arrActualColumns() As String = {"Projects", "Request Details"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("PROJECT"), _
                                                 MyBase.GetResourceString("REQUEST_DETAILS")}
        Dim arrstrTDStyle() As String = {"align='left' width=30%", "align='Left' width=70%"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_SIMILAR_REQUESTS))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the SubTag Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SIMILAR_REQUESTS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        strQuery = "EXEC usp_Sel_SimilarRequests " & m_lngRequestId.ToString() & ", " & m_objGlobal.UserID.ToString()
        'Set the Advanced Grid Properties
        With m_objSimilarRequestsGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .PrimaryKey = "Projects"
            .EmptyValueReplacement = "&nbsp;"
            .SQL = strQuery
            .UseSQL = MyBase.UseSQL
            .DIVID = "divSimilarRequestsList"
            .DIVHeight = SUBTAB_HEIGHT
            .DIVStyle = "overflow:auto;width:100%;"
            .NoOfDataColumns = intColumnsToShow
            .TDStyleArray = arrstrTDStyle
            .ColNameToolTipOnEachRow = True
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With

        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_SIMILAR_REQUESTS))
    End Sub

    Private Sub DisplayDeclineRequestTab()
        '====================================================================
        ' Procedure Name       : DisplayDeclineRequestTab
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Displays the Text area for inputing the comments while declining the request.
        '                        or if already declined then shows the declined comments in the text area.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 22, 2004
        ' Revisions            : 
        '=====================================================================
        'Modified by TrutpiK on 29-MAy-09
        'Purpose:-UI changes.
        Dim sbHTML As New StringBuilder("")
        Dim strTemp As String = ""
        Dim objMenu As New WebPages.Template.StaticMenu
        Dim intNoMenuItems As Integer = 0
        Dim intTotalResourcesAssigned As Integer
        Dim intTotalResourcesRequested As Integer


        If Not HttpContext.Current.Request.QueryString("ResRequested") Is Nothing AndAlso HttpContext.Current.Request.QueryString("ResRequested") <> "" Then
            intTotalResourcesRequested = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResRequested"), "0"), Integer)
        End If

        If Not HttpContext.Current.Request.QueryString("ResAssigned") Is Nothing AndAlso HttpContext.Current.Request.QueryString("ResAssigned") <> "" Then
            intTotalResourcesAssigned = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ResAssigned"), "0"), Integer)
        End If

        If intTotalResourcesAssigned < intTotalResourcesRequested Then
            intNoMenuItems = 3
        Else
            intNoMenuItems = 2
        End If

        'Display the Menu on this Tab
        'CommonFunctions.General.WriteHTML(DisplayMenu(TAB_DECLINE_REQUEST))
        'CommonFunctions.General.WriteHTML("<br>")

        'Display the SubTag Caption
        'CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("DECLINE_REQUEST"), , , True))
        'CommonFunctions.General.WriteHTML("<BR>")
        Dim arrMenuItem(intNoMenuItems - 1) As String
        Dim arrMenuTooltip(intNoMenuItems - 1) As String
        Dim arrClientSideFunctions(intNoMenuItems - 1) As String
        Dim intMenuIndex As Integer = 0
        Dim PageTile As String
        PageTile = "Decline Request"

        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")


        If intTotalResourcesAssigned < intTotalResourcesRequested Then
            arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_DECLINE_REQUEST")
            arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_DECLINE_REQUEST_TOOLTIP")
            arrClientSideFunctions(intMenuIndex) = "DeclineRequest_OnClick()"
            intMenuIndex = intMenuIndex + 1
        End If


        arrMenuItem(intMenuIndex) = "Close"
        arrMenuTooltip(intMenuIndex) = "Close"
        arrClientSideFunctions(intMenuIndex) = "close_OnClick()"
        intMenuIndex = intMenuIndex + 1

        arrMenuItem(intMenuIndex) = MyBase.GetResourceString("MENU_HELP")
        arrMenuTooltip(intMenuIndex) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        arrClientSideFunctions(intMenuIndex) = "Help_OnClick(" & m_lngTagId.ToString() & ")"

        intMenuIndex = intMenuIndex + 1

        CommonFunctions.General.WriteHTML(objMenu.DrawMenuWithEvents(arrMenuItem, arrClientSideFunctions, arrMenuTooltip, True))

        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, PageTile))
        CommonFunctions.General.WriteHTML("<BR>")

        ''Added by Dhanashri S on 9 Dec 2015 for IssueID:2667
        sbHTML.Append("<Div id='divDeclineRequestComments' style='overflow:auto'>")
        ''End of Addition by Dhanashri S on 9 Dec 2015

        ''sbHTML.Append("<Table class='clsTable' width='99.9%' border=0 cellpadding=0 cellspacing=0>")
        sbHTML.Append("<Table class='clsTable' width='99.9%' border=0 cellpadding=0 cellspacing=0>")
        sbHTML.Append("<Tr class='clsTReven'>")
        sbHTML.Append("<TD width=20% align='right' valign=top>")
        sbHTML.Append("Comments")
        sbHTML.Append("</TD><TD width='80%' align=left>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'strTemp = CommonFunctions.HTMLControls.DrawTextArea("txtDeclineComments", "txtDeclineComments", , , , "frmPM_ResourceAllocationDetails", , , 350, 100, 1500, m_strRejectComments, returnHTML:=True, IsMandatory:=True)
        strTemp = CommonFunctions.HTMLControls.DrawTextArea("txtDeclineComments", "txtDeclineComments", , , , "frmPM_ResourceAllocationDetails", , , 350, 100, 1500, m_strRejectComments, returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        sbHTML.Append(strTemp)
        sbHTML.Append("</TD>")
        sbHTML.Append("</Tr>")
        sbHTML.Append("</Table>")
        ''Added by Dhanashri S on 9 Dec 2015 for IssueID:2667
        sbHTML.Append("</Div>")
        ''End of Addition by Dhanashri S on 9 Dec 2015

        CommonFunctions.General.WriteHTML(sbHTML.ToString())
        'End of modification by TruptiK on 29-MAy-09
        'Display the Menu on this Tab
        'CommonFunctions.General.WriteHTML("<br>")

        ''UnCommented by Dhanashri S on 9 Dec 2015 for IssueID:2667
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_DECLINE_REQUEST))
        ''End of uncomment by Dhanashri S on 9 Dec 2015
    End Sub

    Private Sub DisplayConfigureDaysTab()
        '====================================================================
        ' Procedure Name       : DisplayConfigureDaysTab
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Displays the text field of configured days, to accept its value.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 22, 2004
        ' Revisions            : 
        '=====================================================================
        Dim sbHTML As New StringBuilder("")
        Dim strTemp As String = ""
        Dim strQuery As String = ""

        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_CONFIGURE_DAYS))
        CommonFunctions.General.WriteHTML("<br>")

        'Display the SubTag Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CONFIGURE_DAYS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")

        'Get Default value of Number of Days
        If m_intConfigureDays = 0 Then
            strQuery = "Exec usp_sel_tbl_PM_ResourceRequest_configuredDays " & m_lngRequestId.ToString()
            m_intConfigureDays = CType(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Integer)
        End If

        sbHTML.Append("<Div id='divConfigureDaysDetails' style='overflow:auto;width=100%;height:" & SUBTAB_HEIGHT.ToString() & "'>")
        sbHTML.Append("<Table class='clsTable' width='99.9%' border=0 cellpadding=0 cellspacing=0>")
        sbHTML.Append("<Tr class='clsTROdd'>")
        sbHTML.Append("<TD colspan=2><b>")
        sbHTML.Append(MyBase.GetResourceString("CONFIGURE_DAYS_COMMENTS"))
        sbHTML.Append("</b></TD>")
        sbHTML.Append("</Tr>")
        sbHTML.Append("<Tr class='clsTREven'>")
        sbHTML.Append("<TD width=20% align='right'>")
        sbHTML.Append(MyBase.GetResourceString("NO_DAYS"))
        sbHTML.Append("</TD><TD width='80%' align=left>")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        strTemp = CommonFunctions.HTMLControls.DrawTextBox("txtNoOfDays", "txtNoOfDays", , 30, 2, m_intConfigureDays.ToString(), "Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        sbHTML.Append(strTemp)
        sbHTML.Append("</TD>")
        sbHTML.Append("</Tr>")
        sbHTML.Append("</Table>")
        sbHTML.Append("</div>")

        CommonFunctions.General.WriteHTML(sbHTML.ToString())

        'Display the Menu on this Tab
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunctions.General.WriteHTML(DisplayMenu(TAB_CONFIGURE_DAYS))
    End Sub

    Private Sub DisplayProbableResourcesTab()
        '====================================================================
        ' Procedure Name        : DisplayProbableResourcesTab
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : This Procedure displays the resources which satisfied the requested conditions.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 09, 2004
        ' Revisions             :
        '=====================================================================
        Dim strQuery As String = ""
        Dim drCompanyInformation As IDataReader
        Dim intColumnsToShow As Integer = 11 '10
        'Dim arrActualColumns() As String = {"EmployeeName", "Office", "Department", "BusinessGroup", "Role", _
        '                            "FreeHours", "WorkHoursPerDay", "Role", "Role", _
        '                            "Role", MyBase.GetResourceString("RESUME"), _
        '                            MyBase.GetResourceString("RESOURCE_LOADING"), ""}
        'Modified by TrutpiK on 01-Jun-09
        'Purpose:-to change ui if probable resource.

        MyBase.InitializeResources("AppResources.PM_ResourceAllocationDetails", "AppResources")

        Dim arrActualColumns() As String = {"EmployeeName", "Office", "Department", "Role", _
                                          "FreeHours", "WorkHoursPerDay", "FreePercentage", "FreePercentage", "Role", "Role", _
                                          "Role", ""}

        'Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE_NAME"), MyBase.GetResourceString("OFFICE"), _
        '                                         MyBase.GetResourceString("DEPARTMENT"), MyBase.GetResourceString("BUSINESSGROUP"), MyBase.GetResourceString("ROLE"), _
        '                                         MyBase.GetResourceString("FREE_HOURS"), MyBase.GetResourceString("FREE_HOURS_PER_DAY"), _
        '                                         MyBase.GetResourceString("FROM_DATE"), MyBase.GetResourceString("TO_DATE"), _
        '                                         MyBase.GetResourceString("WORK_HOURS"), MyBase.GetResourceString("ALLOCATE")}



        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("RESOURCE_NAME"), "BG/OU", _
                                                 MyBase.GetResourceString("DEPARTMENT"), MyBase.GetResourceString("ROLE"), _
                                                  "Total Free Hrs", MyBase.GetResourceString("FREE_HOURS_PER_DAY"), _
                                                 "Free %", "Max ", MyBase.GetResourceString("FROM_DATE"), MyBase.GetResourceString("TO_DATE"), _
                                                 MyBase.GetResourceString("WORK_HOURS"), MyBase.GetResourceString("ALLOCATE")}

        Dim arrCheckboxID() As String = {"", "", "", "", "", "", "", "", "", "", "", "chkAssign"}

        'Dim arrstrTDStyle() As String = {"align='left' width=21%", "align='left' width=20% NoWrap", _
        '                                 "align='left' width=0%", "align='left' width=7%", "align='right' width=5%", _
        '                                 "align='Right' width=5%", "align='right' width=5%", _
        '                                 "align='center' width=10%  NoWrap", "align='center' width=10% NoWrap", _
        '                                 "align='left' width=5%", "align='Left' width=5%", _
        '                                 "align='Left' width=4%", "align='Center' width=3%"}
        'Dim arrRowLink() As String = {"", "", "", "", "", "", "", "", "", ""}

        Dim arrIgnoreHTMLEncode() As String = {"1", "0", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1"}
        ''cOMMENTED AND ADDED BY Nilesh G on 9/11/2015 for issue id 2075
        'Dim arrstrTDStyle() As String = {"align='left' width=15%", "align='left' width=10% NoWrap", _
        '                                 "align='left' width=10%", "align='left' width=10%", "align='left' width=10%", _
        '                                 "align='Right' width=7%", "align='Right' width=7%", "align='Right' width=7%", "align='Right' width=7%", _
        '                                 "align='center' width=15%  NoWrap", "align='center' width=15% NoWrap", _
        '                                 "align='left' width=10%", "align='Left' width=10%", _
        '                                 "align='Left' width=10%", "align='Center' width=10%"}
        Dim arrstrTDStyle() As String = {"align='left' width=15%", "align='left' width=10% NoWrap", _
                                        "align='left' width=10%", "align='left' width=10%", "align='left' width=10%", _
                                        "align='Right' width=7%", "align='Right' width=7%", "align='Right' width=16%", "align='center' width=17% NoWrap", _
                                        "align='center' width=17%  NoWrap", "align='center' width=15% NoWrap", _
                                        "align='left' width=10%", "align='Left' width=10%", _
                                        "align='Left' width=10%", "align='Center' width=10%"}
        ''end of COMMENTED AND ADDED BY Nilesh G on 9/11/2015 for issue id 2075
        Dim arrRowLink() As String = {"", "", "", "", "", "", "", "", "", "", "", ""}

        If m_intTotalResourcesAssigned < m_intTotalResourcesRequested Then
            'Added By JayavantK, On- 16-Jul-2004  (IssueID = 11937)- Start
            If m_strType = TYPE_PERCENT_WORKHOURS Then
                arrUserFriendlyColumn(7) = arrUserFriendlyColumn(7) & "Free %"
                arrUserFriendlyColumn(10) = arrUserFriendlyColumn(10) & " (%)"
            ElseIf m_strType = TYPE_TOTAL_WORKHOURS Then
                arrUserFriendlyColumn(10) = MyBase.GetResourceString("TOTAL_WORKHOURS")
            ElseIf m_strType = TYPE_PER_DAY Then
                arrUserFriendlyColumn(7) = arrUserFriendlyColumn(7) & MyBase.GetResourceString("FREE_HOURS_PER_DAY")
            End If
            'Added By JayavantK, On- 16-Jul-2004  (IssueID = 11937)- End

            'Display the Menu on this Tab
            CommonFunctions.General.WriteHTML(DisplayMenu(TAB_PROBABLE_RESOURCES))
            'CommonFunctions.General.WriteHTML("<br>")

            'Display the SubTag Caption
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PROBABLE_RESOURCES"), , , True))
            CommonFunctions.General.WriteHTML("<BR>")

            'Added By JayavantK, On 30-Aug-2004
            ' Display the Project Role Combo
            CommonFunctions.General.WriteHTML("<Table class='clsTable' cellpadding=0 cellspacing=0 width=99.9%><Tr class='clsTRPageCaption'><Td allign=Right width=20%>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_ROLE"))
            CommonFunctions.General.WriteHTML("</Td><Td align=left width=90%>")
            strQuery = "usp_Sel_tbl_PM_Role_PopulateCombo"
            CommonFunctions.HTMLControls.DrawComboBox("cboProjectRole", strQuery, 250, m_lngProjectRoleID.ToString(), , True, False, , True)

            'Added by TruptiK on 21-Jan-09

            CommonFunctions.General.WriteHTML("&nbsp;&nbsp; Resource Status")

            CommonFunctions.General.WriteHTML("&nbsp;")
            strQuery = "usp_Sel_tbl_PM_ProjectGroupResources_WhyNonBillable"
            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strQuery, 250, m_status.ToString(), , True, False, , True)
            CommonFunctions.General.WriteHTML("</Td></Tr></Table><BR>")
            'End of addition by TruptiK
            'End Addition

            strQuery = "Exec usp_Sel_GetResourcesForAllocation " & m_lngRequestId.ToString()
            If m_objGlobal.UserID > 0 Then
                strQuery &= ", " & m_objGlobal.UserID
            Else
                strQuery &= ", NULL"
            End If
            'Sorting
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strSortBy) & " "
            strQuery &= CommonFunctions.General.BuildQueryString(m_strSortOrder) & "'"

            drCompanyInformation = CommonFunctions.Data.GetDataReader("Exec usp_Sel_tbl_PM_CompanyInformation", MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drCompanyInformation) <> "" Then
                If drCompanyInformation.Read() Then
                    If CType(CommonFunctions.Data.CheckIsDBNull(drCompanyInformation.Item("UseProjectPool"), "False"), Boolean) = True Then
                        strQuery &= ", 1"
                    End If
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drCompanyInformation)

            'Set the Advanced Grid Properties
            With m_objGrid
                .UserFriendlyColumnArray = arrUserFriendlyColumn
                .ActualColumnArray = arrActualColumns
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                .CheckBoxIDArray = arrCheckboxID
                .RowLinkArray = arrRowLink
                .PrimaryKey = "EmployeeID"
                .EmptyValueReplacement = "&nbsp;"
                .SortBy = m_strSortBy
                .SortOrder = m_strSortOrder
                .ClientSideSortFunctionName = "Sort_OnClick"
                .SQL = strQuery
                .UseSQL = MyBase.UseSQL
                .DIVID = "divProbableResourcesList"
                .DIVHeight = SUBTAB_HEIGHT
                .DIVStyle = "overflow:auto;width:100%;"
                .NoOfDataColumns = intColumnsToShow
                .TDStyleArray = arrstrTDStyle
                .ColNameToolTipOnEachRow = True
                .returnHTML = True

                CommonFunctions.General.WriteHTML(.DrawGrid())
            End With
            'End of modification by TrutpiK
            'Display the Menu on this Tab
            CommonFunctions.General.WriteHTML("<br>")
            CommonFunctions.General.WriteHTML(DisplayMenu(TAB_PROBABLE_RESOURCES))
        Else
            CommonFunctions.General.WriteHTML("<Div id='divProbableResourcesList' style='overflow:auto;width=100%;height:" & (SUBTAB_HEIGHT + 20).ToString() & "'>")
            CommonFunctions.General.WriteHTML("<table cellSpacing='1' cellPadding='0' width='99.9%' class='clsTable'>")
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<td align='center'>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("ALREADY_ASSIGNED_ALL_REQUIRED_RESOURCES"))
            CommonFunctions.General.WriteHTML("</td></tr></table>")
            CommonFunctions.General.WriteHTML("</div>")
        End If
    End Sub
    'Added by TruptiK on 12-Mar-2008
    'Purpose:-To add alert for Resource Percentage.
    Private Function GetResourcePercent() As String
        Dim objDrResourcePercentage As IDataReader
        Dim arrIdsToAssign() As String
        Dim strSQL As String
        Dim strtemp As String
        Dim strEmployeeIdList As String
        Dim strControlName As String
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
                strSQL &= ", " & m_lngRequestProjectId.ToString()
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
    'End of addition by TruptiK
#End Region

#Region " Database Related functions / Procedures "
    Private Function GetRequestDetails() As String
        '====================================================================
        ' Procedure Name        : GetRequestDetails
        ' Parameters Passed     : None
        ' Returns               : Request Details String.
        ' Parameters Affected   : None
        ' Purpose               : This function builds the request details string.
        ' Description           :
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : JayavantK
        ' Created               : April 09, 2004
        ' Revisions             :
        '=====================================================================
        Dim drTemp As IDataReader
        Dim strQuery As String = ""
        Dim strWhereClause As String = ""
        Dim sbReturn As New StringBuilder("")
        Dim strValue As String = ""
        Dim strRole As String = ""
        Dim strOffice As String = ""
        Dim strBG As String = ""
        'Dim strRequestDate As String = ""
        Dim strPriority As String = ""
        Dim strSpecialRequest As String = ""
        'Dim strRequestor As String = ""

        If m_lngRequestProjectId <> 0 Then
            strWhereClause = " A.ProjectId = " & m_lngRequestProjectId.ToString()
            strWhereClause = strWhereClause & "  And A.RequestID=" & m_lngRequestId.ToString()
        Else
            strWhereClause = "  A.RequestID=" & m_lngRequestId.ToString()
        End If
        If strWhereClause <> "" Then
            strQuery = "Exec usp_sel_tbl_PM_ResourceRequestDetails  Null ,'" & strWhereClause & "'"
        Else
            strQuery = "Exec usp_sel_tbl_PM_ResourceRequestDetails"
        End If

        drTemp = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTemp) <> "" Then
            If drTemp.Read() Then
                'Get the Request details
                m_lngRequestProjectId = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("ProjectID"), "0"), Long)
                m_strProjectName = CommonFunctions.General.CheckIsNothing(drTemp.Item("Project"), "")
                m_strProjectName = CommonFunctions.General.UnBuildQueryString(m_strProjectName)
                m_strStatus = CommonFunctions.General.CheckIsNothing(drTemp.Item("Status"), "")
                m_strStatus = CommonFunctions.General.UnBuildQueryString(m_strStatus)
                m_strRejectComments = CommonFunctions.General.CheckIsNothing(drTemp.Item("RejectComment"), "")
                m_strRejectComments = CommonFunctions.General.UnBuildQueryString(m_strRejectComments)
                m_strType = CommonFunctions.General.CheckIsNothing(drTemp.Item("Type"), "")
                m_strType = CommonFunctions.General.UnBuildQueryString(m_strType)
                If m_strType = "TH" Then
                    strAvailableField = "FreeHours"
                    m_dblRequestedWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("TotalRequestedHrs"), "0"), Double)
                ElseIf m_strType = "P" Then
                    strAvailableField = "FreePercentage"
                    m_dblRequestedWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("PercentageAllocation"), "0"), Double)
                Else
                    strAvailableField = "WorkHoursPerDay"
                    m_dblRequestedWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("WorkHours"), "0"), Double)
                End If
                m_strFromDate = CommonFunctions.General.UnBuildQueryString(drTemp.Item("FromDate").ToString())
                m_strFromDate = CommonFunctions.Dates.GetDate(CType(m_strFromDate, Date))
                m_strToDate = CommonFunctions.General.UnBuildQueryString(drTemp.Item("ToDate").ToString())
                m_strToDate = CommonFunctions.Dates.GetDate(CType(m_strToDate, Date))
                m_intTotalResourcesRequested = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("NoOfResources"), "0"), Integer)
                m_intTotalResourcesAssigned = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("TotalAssignedResources"), "0"), Integer)
                strRole = CommonFunctions.General.CheckIsNothing(drTemp.Item("Role"), "")
                strRole = CommonFunctions.General.UnBuildQueryString(strRole)
                strOffice = CommonFunctions.General.CheckIsNothing(drTemp.Item("Office"), "")
                strOffice = CommonFunctions.General.UnBuildQueryString(strOffice)
                m_intConfigureDays = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("ConfiguredMaxDays"), "0"), Integer)
                strRequestDate = CommonFunctions.General.UnBuildQueryString(drTemp.Item("RequestDate").ToString())
                strRequestDate = CommonFunctions.Dates.GetDate(CType(strRequestDate, Date))
                strPriority = CommonFunctions.General.CheckIsNothing(drTemp.Item("PriorityName"), "")
                strPriority = CommonFunctions.General.UnBuildQueryString(strPriority)
                strSpecialRequest = CommonFunctions.General.CheckIsNothing(drTemp.Item("SpecialRequest"), "")
                strSpecialRequest = CommonFunctions.General.UnBuildQueryString(strSpecialRequest)
                strRequestor = CommonFunctions.General.CheckIsNothing(drTemp.Item("Requestor"), "")
                strRequestor = CommonFunctions.General.UnBuildQueryString(strRequestor)
                m_blnIsEscalatedFromTeam = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("IsEscalatedFromTeam"), "false"), Boolean)
                m_blnIsEscalatedFromResourcePool = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("IsEscalatedFromResourcePool"), "false"), Boolean)
                m_blnIsEscalatedFromOUPool = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("IsEscalatedFromOUPool"), "false"), Boolean)
                m_blnIsEscalatedFromBGPool = CType(CommonFunctions.Data.CheckIsDBNull(drTemp.Item("IsEscalatedFromBGPool"), "false"), Boolean)
                'Added by Sanas on 13-Aug-2009
                strBG = CommonFunctions.General.CheckIsNothing(drTemp.Item("BusinessGroup"), "")
                strBG = CommonFunctions.General.UnBuildQueryString(strBG)
                'End Addition by Sanas on 13-Aug-2009
                'Modified by TrutpiK on 29-MAy-09
                'Purpose:-UI changes.
                sbReturn.Append("<Table class='clsTable' width='99.9%' border=0 cellpadding=0 cellspacing=0>")
                sbReturn.Append("<Tr class='clsTREven'>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append(MyBase.GetResourceString("PROJECT"))
                sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD>")
                sbReturn.Append("<TD>")
                sbReturn.Append(m_strProjectName)
                sbReturn.Append("</TD>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append(MyBase.GetResourceString("ROLE"))
                sbReturn.Append("<b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                sbReturn.Append(strRole)
                sbReturn.Append("</TD>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append(MyBase.GetResourceString("REQUESTED_RESOURCES"))
                sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                sbReturn.Append(m_intTotalResourcesRequested)
                sbReturn.Append("</TD>")
                If m_strType = TYPE_PER_DAY Then
                    sbReturn.Append("<TD><b>")
                    sbReturn.Append(MyBase.GetResourceString("PERDAY_WORKHOURS"))
                    sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD>")
                ElseIf m_strType = TYPE_TOTAL_WORKHOURS Then
                    sbReturn.Append("<TD><b>")
                    sbReturn.Append(MyBase.GetResourceString("TOTAL_WORKHOURS"))
                    sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD>")
                ElseIf m_strType = TYPE_PERCENT_WORKHOURS Then
                    sbReturn.Append("<TD><b>")
                    sbReturn.Append(MyBase.GetResourceString("PERCENT_WORKHOURS"))
                    sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD>")
                End If
                sbReturn.Append("<TD>")
                sbReturn.Append(m_dblRequestedWorkHours)
                sbReturn.Append("</TD>")
                sbReturn.Append("</Tr>")


                sbReturn.Append("<Tr class='clsTREven'>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append("Business Group")
                sbReturn.Append("<b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                ' Modified by Sanas on 13-Aug-2009
                'sbReturn.Append("BG1")
                sbReturn.Append(strBG)
                'End Modification by by Sanas on 13-Aug-2009
                sbReturn.Append("</TD>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append(MyBase.GetResourceString("FROM_DATE"))
                sbReturn.Append("<b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                sbReturn.Append(m_strFromDate)
                sbReturn.Append("</TD>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append(MyBase.GetResourceString("ASSIGNED_RESOURCES"))
                sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD colspan=4>")
                sbReturn.Append(m_intTotalResourcesAssigned)
                sbReturn.Append("</TD>")
                sbReturn.Append("</Tr>")

                sbReturn.Append("<Tr class='clsTREven'>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append("Organization Unit")
                sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                sbReturn.Append(strOffice)
                sbReturn.Append("</TD>")
                sbReturn.Append("<TD><b>")
                sbReturn.Append(MyBase.GetResourceString("TO_DATE"))
                sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD colspan=7>")
                sbReturn.Append(m_strToDate)
                sbReturn.Append("</TD>")
                sbReturn.Append("</Tr>")


                sbReturn.Append("<Tr class='clsTREven'>")
                sbReturn.Append("<TD VALIGN=TOP><b>")
                sbReturn.Append(MyBase.GetResourceString("SPECIAL_REQUEST"))
                sbReturn.Append("</b></TD><TD VALIGN=TOP width=5>&nbsp;:&nbsp;</TD><TD colspan=10>")
                'Commented And Added By Vaijat K ON 18/11/2015
                'sbReturn.Append(strSpecialRequest)
                sbReturn.Append(HttpUtility.HtmlEncode(strSpecialRequest))
                sbReturn.Append("</TD>")
                sbReturn.Append("</Tr>")


                'sbReturn.Append(MyBase.GetResourceString("REQUESTID"))
                'sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD width=16% nowrap=false><b>")
                'sbReturn.Append(m_lngRequestId.ToString())
                'sbReturn.Append("</b></TD>")
                'sbReturn.Append("<TD width=150>")
                'sbReturn.Append(MyBase.GetResourceString("REQUEST_DATE"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD width='16%' nowrap=false>")
                'sbReturn.Append(strRequestDate)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("<TD width=140>")
                'sbReturn.Append(MyBase.GetResourceString("REQUESTOR"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD width='16%' nowrap=false>")
                'sbReturn.Append(strRequestor)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("</Tr>")

                'sbReturn.Append("<Tr class='clsTREven'>")
                'sbReturn.Append("<TD>")
                'sbReturn.Append(MyBase.GetResourceString("ROLE"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                'sbReturn.Append(strRole)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("<TD>")
                'sbReturn.Append(MyBase.GetResourceString("OFFICE"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                'sbReturn.Append(strOffice)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("<TD>")
                'sbReturn.Append(MyBase.GetResourceString("PRIORITY"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                'sbReturn.Append(strPriority)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("</Tr>")

                'sbReturn.Append("<Tr class='clsTREven'>")
                'sbReturn.Append("<TD>")
                'sbReturn.Append(MyBase.GetResourceString("FROM_DATE"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                'sbReturn.Append(m_strFromDate)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("<TD>")
                'sbReturn.Append(MyBase.GetResourceString("TO_DATE"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                'sbReturn.Append(m_strToDate)
                'sbReturn.Append("</TD>")
                'If m_strType = TYPE_PER_DAY Then
                '    sbReturn.Append("<TD>")
                '    sbReturn.Append(MyBase.GetResourceString("PERDAY_WORKHOURS"))
                '    sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD>")
                'ElseIf m_strType = TYPE_TOTAL_WORKHOURS Then
                '    sbReturn.Append("<TD>")
                '    sbReturn.Append(MyBase.GetResourceString("TOTAL_WORKHOURS"))
                '    sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD>")
                'ElseIf m_strType = TYPE_PERCENT_WORKHOURS Then
                '    sbReturn.Append("<TD>")
                '    sbReturn.Append(MyBase.GetResourceString("PERCENT_WORKHOURS"))
                '    sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD>")
                'End If
                'sbReturn.Append("<TD>")
                'sbReturn.Append(m_dblRequestedWorkHours)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("</Tr>")

                'sbReturn.Append("<Tr class='clsTREven'>")
                'sbReturn.Append("<TD><b>")
                'sbReturn.Append(MyBase.GetResourceString("REQUESTED_RESOURCES"))
                'sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD><b>")
                'sbReturn.Append(m_intTotalResourcesRequested)
                'sbReturn.Append("</b></TD>")
                'sbReturn.Append("<TD><b>")
                'sbReturn.Append(MyBase.GetResourceString("ASSIGNED_RESOURCES"))
                'sbReturn.Append("</b></TD><TD width=5>&nbsp;:&nbsp;</TD><TD><b>")
                'sbReturn.Append(m_intTotalResourcesAssigned)
                'sbReturn.Append("</b></TD>")
                'sbReturn.Append("<TD>")
                'sbReturn.Append(MyBase.GetResourceString("CONFIGURED_DAYS"))
                'sbReturn.Append("</TD><TD width=5>&nbsp;:&nbsp;</TD><TD>")
                'sbReturn.Append(m_intConfigureDays.ToString())
                'sbReturn.Append("</TD>")
                'sbReturn.Append("</Tr>")

                'sbReturn.Append("<Tr class='clsTREven'>")
                'sbReturn.Append("<TD VALIGN=TOP>")
                'sbReturn.Append(MyBase.GetResourceString("SPECIAL_REQUEST"))
                'sbReturn.Append("</TD><TD VALIGN=TOP width=5>&nbsp;:&nbsp;</TD><TD colspan=7>")
                'sbReturn.Append(strSpecialRequest)
                'sbReturn.Append("</TD>")
                'sbReturn.Append("</Tr>")
                sbReturn.Append("</Table>")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drTemp)
        'End of modification by TruptiK on 29-MAy-09
        Return (sbReturn.ToString())
    End Function

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

        strQuery = "EXEC usp_Sel_tbl_PM_ProjectExpectedDates " & m_lngRequestProjectId.ToString()
        drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
            If drProject.Read() Then
                'Commented AND Added by KIRAN K K For IssueId:2695
                m_strProjectStartDate = drProject.Item("ExpectedStartDate").ToString()
                'm_strProjectStartDate = Format(CType(FormatDateTime(CType(drProject.Item("ExpectedStartDate").ToString, Date), DateFormat.ShortDate), Date), "MM/dd/yyyy")
                'Commented AND Added End by KIRAN K K For IssueId:2695  
                m_strProjectStartDate = CommonFunctions.Dates.GetDate(CType(m_strProjectStartDate, Date))
                'Commented AND Added by KIRAN K K For IssueId:2695  
                m_strProjectEndDate = drProject.Item("ExpectedEndDate").ToString()
                'm_strProjectEndDate = Format(CType(FormatDateTime(CType(drProject.Item("ExpectedEndDate").ToString, Date), DateFormat.ShortDate), Date), "MM/dd/yyyy")

                ' m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(m_strProjectEndDate, Date)) 
                m_strProjectEndDate = CommonFunctions.Dates.GetDate(CType(drProject.Item("ExpectedEndDate").ToString, Date))
                'Commented AND Added  End by KIRAN K K For IssueId:2695
                m_lngRequestTeamID = CType(CommonFunctions.Data.CheckIsDBNull(drProject.Item("ResourceGroupID"), "0"), Long)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        strQuery = "Exec usp_Sel_tbl_PM_GetWorkingHours " & m_lngRequestProjectId.ToString()
        m_dblProjectWorkHours = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL), "0"), Double)
    End Sub

    Private Sub AllocateResourcesAgainstRequest()
        '====================================================================
        ' Procedure Name        : m_intRequestID
        ' Parameters Passed     : None
        ' Returns               : None
        ' Parameters Affected   : None
        ' Purpose               : Allocate the resources against the request.
        ' Description           : When a Employee is allocated against the request then a Email is also send to the requestor.
        ' Assumptions           :
        ' Dependencies          :    
        ' Author                : JayavantK
        ' Created               : April 12, 2004
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
                strQuery &= ", " & m_lngRequestProjectId.ToString()
                strQuery &= ", " & lngEmployeeId.ToString()

                strTemp = "txtFromDate_" & m_lngRequestId.ToString() & "_" & lngEmployeeId.ToString()
                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strTemp)) & "'"

                strTemp = "txtToDate_" & m_lngRequestId.ToString() & "_" & lngEmployeeId.ToString()
                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strTemp)) & "'"

                strTemp = "txtWorkHours_" & m_lngRequestId.ToString() & "_" & lngEmployeeId.ToString()
                strQuery &= ", '" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strTemp)) & "'"

                'Added By JayavantK, On 30-Aug-2004
                strQuery &= ", NULL, " & m_lngProjectRoleID.ToString()
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
        End If
    End Sub

    Private Sub DeclineTheRequest()
        '====================================================================
        ' Procedure Name       : DeclineTheRequest
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : In this procedure the status of the request is changed to declined. 
        '                        And the Decline comments are added against that request in the DB.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 23, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""

        'Added by sonalD on 14th Nov 2008 for issue id 16783
        'Purpose:To send Mail to requestor when request is declined
        Dim strSQL As String
        Dim drEmail As IDataReader
        Dim blnSendEmail As Boolean
        Dim blnShowPopup As Boolean
        Dim strEmployeeIdList As String = ""
        Dim strToEmailID, strCCToEmailID, strFromEmailID, strMailSubject, strEmailMessage As String
        Dim script As New System.Text.StringBuilder
        strSQL = "Exec usp_Sel_tbl_PM_EmailMessages 539"
        drEmail = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)
        'End of addition by SonalD


        m_strRejectComments = MyBase.GetFormValue("txtDeclineComments")
        m_strRejectComments = CommonFunctions.General.UnBuildQueryString(m_strRejectComments)
        m_strRejectComments = MyBase.FixString(m_strRejectComments, 1500, False, True)
        strQuery = "usp_Upd_tbl_PM_ResourceRequest " & m_lngRequestId.ToString
        strQuery += ", '" & CommonFunctions.General.BuildQueryString(m_strRejectComments) & "'"
        strQuery += ", 'REJECT'"

        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

        'Added by sonalD on 14th Nov 2008 for issue id 16783
        'Send Emails
        If blnSendEmail = True Then
            If blnShowPopup = True Then
                script.Append("<script>")
                script.Append("window.open(""../General/SendEmail.aspx?MessageID=539&RequestID=" & m_lngRequestId.ToString())
                script.Append("&EmployeeIDS=" & strEmployeeIdList & """ ,'',")
                script.Append("'resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='")
                script.Append(" + (window.screen.width - 600)/2 + ',top='")
                script.Append(" + (window.screen.height - 500)/2 + ',width=600,height=500')" & vbCrLf)
                script.Append("</script>")
            Else
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_539(strFromEmailID, strToEmailID, strCCToEmailID, strMailSubject, strEmailMessage, m_lngRequestId, strEmployeeIdList)
                CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strMailSubject, strEmailMessage)
            End If
        End If

        CommonFunction.General.WriteHTML(script.ToString)
        'End of addition by SonalD

    End Sub

    Private Sub Save_ConfigureDays()
        '====================================================================
        ' Procedure Name       : Save_ConfigureDays
        ' Parameters Passed    : None
        ' Returns              : None
        ' Parameters Affected  : None
        ' Purpose              : Saves the Configure Days in the Database.
        ' Description          : 
        ' Assumptions          : 
        ' Dependencies         : 
        ' Author               : JayavantK
        ' Created              : June 23, 2004
        ' Revisions            : 
        '=====================================================================
        Dim strQuery As String = ""

        m_intConfigureDays = CType(CommonFunction.Data.CheckIsDBNull(MyBase.GetFormValue("txtNoOfDays"), "0"), Integer)
        If m_intConfigureDays > 0 Then
            strQuery = "Exec usp_Upd_tbl_PM_ResourceRequest_ConfiguredDays " & m_lngRequestId.ToString() & "," & m_intConfigureDays.ToString()
            CommonFunction.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        End If
    End Sub
#End Region

#Region " Grid Event Handlers "

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strTemp As String = ""
        Dim m_strAvailable As String
        'Dim lngEmployeeID As Long = 0
        Dim strControlName As String = ""
        Dim strControlName1 As String = ""
        Dim strFieldValue As String = ""
        Dim strWorkHrs As Double

        m_EmployeeID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeID"), "0"), Long)
        Select Case Args.ColIndex
            'modified by harshk sp4 issueid 120,121 
            Case 1
                Dim lngTeamID As Long = 0
                Dim strEmployeeName As String = ""

                'lngTeamID = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TeamID"), "0"), Long)
                strEmployeeName = CommonFunctions.General.CheckIsNothing(Args.DataReader.Item("EmployeeName"), "")
                'Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidTeamID_" + lngEmployeeID.ToString(), "txthidTeamID_" + lngEmployeeID.ToString(), , , , lngTeamID.ToString(), IsHidden:=True, returnHTML:=True)
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Args.StringToBeInserted &= CommonFunctions.HTMLControls.DrawTextBox("txthidEmployeeName_" + m_EmployeeID.ToString(), "txthidEmployeeName_" + m_EmployeeID.ToString(), , , , strEmployeeName, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                'End modified by harshk sp4 issueid 120,121 

                'Case 2  'Team
                '    Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Then
                '    '    Cancel = True
                '    'End If

                'Case 3  'Resource Pool
                '    Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Then
                '    '    Cancel = True
                '    'End If

                'Case 4  'OU Pool
                '    If m_strResourceAllocationLevel <> ALLOCATION_LEVEL_ODC Or m_strUserType = OU_MANAGER Then Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
                '    '    m_strUserType = OU_MANAGER Then
                '    '    Cancel = True
                '    'End If

                'Case 5  'BG Pool
                '    If m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Or m_strUserType = BG_MANAGER Then Cancel = True
                '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
                '    '    m_strUserType = OU_MANAGER Or m_strUserType = BG_MANAGER Then
                '    '    Cancel = True
                '    'End If

            Case 8 '7   'From Date
                strTemp = ""
                strControlName = "txtFromDate_" & m_lngRequestId.ToString() & "_" & m_EmployeeID.ToString()
                If CommonFunctions.General.CheckIsNothing(Request.QueryString("Sort"), "") <> "" Then
                    strFieldValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strControlName), "")
                    strTemp = CommonFunctions.HTMLControls.DrawDateControl(strControlName, strControlName, , , strFieldValue, , "frmPM_ResourceAllocationDetails", returnHTML:=True, IsMandatory:=True)
                Else
                    strTemp = CommonFunctions.HTMLControls.DrawDateControl(strControlName, strControlName, , , m_strFromDate, , "frmPM_ResourceAllocationDetails", returnHTML:=True, IsMandatory:=True)
                End If
                Args.DataFieldValue = strTemp
                Args.ApplyHTMLEncode = False

            Case 9 '8   'To Date
                'Case 9
                strTemp = ""
                strControlName = "txtToDate_" & m_lngRequestId.ToString() & "_" & m_EmployeeID.ToString()
                If CommonFunctions.General.CheckIsNothing(Request.QueryString("Sort"), "") <> "" Then
                    strFieldValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strControlName), "")
                    strTemp = CommonFunctions.HTMLControls.DrawDateControl(strControlName, strControlName, , , strFieldValue, , "frmPM_ResourceAllocationDetails", returnHTML:=True, IsMandatory:=True)
                Else
                    strTemp = CommonFunctions.HTMLControls.DrawDateControl(strControlName, strControlName, , , m_strToDate, , "frmPM_ResourceAllocationDetails", returnHTML:=True, IsMandatory:=True)
                End If
                Args.DataFieldValue = strTemp
                Args.ApplyHTMLEncode = False

            Case 10 '9   'Work Hours
                'Case 10
                strTemp = ""
                m_strAvailable = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item(strAvailableField), "0"), String)
                strControlName = "txtWorkHours_" & m_lngRequestId.ToString() & "_" & m_EmployeeID.ToString()
                strControlName1 = "txtWorkHourshid_" & m_lngRequestId.ToString() & "_" & m_EmployeeID.ToString()
                If CommonFunctions.General.CheckIsNothing(Request.QueryString("Sort"), "") <> "" Then
                    strFieldValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strControlName), "")
                    'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                    strTemp = CommonFunctions.HTMLControls.DrawTextBox(strControlName, strControlName, , 50, 4, strFieldValue, "Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
                    strTemp = strTemp + CommonFunctions.HTMLControls.DrawTextBox(strControlName1, strControlName1, , 50, 4, m_strAvailable, "Right", returnHTML:=True, IsMandatory:=False, IsHidden:=True, EnableHTMLEncode:=True)
                    'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                Else
                    'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                    strTemp = CommonFunctions.HTMLControls.DrawTextBox(strControlName, strControlName, , 50, 4, m_dblRequestedWorkHours.ToString(), "Right", returnHTML:=True, IsMandatory:=True, EnableHTMLEncode:=True)
                    strTemp = strTemp + CommonFunctions.HTMLControls.DrawTextBox(strControlName1, strControlName1, , 50, 4, m_strAvailable, "Right", returnHTML:=True, IsMandatory:=False, IsHidden:=True, EnableHTMLEncode:=True)
                    'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                End If
                Args.DataFieldValue = strTemp
                Args.ApplyHTMLEncode = False
            Case 2

                Cancel = True
                'Added by TrutpiK on 01-Jun-09
                'Purpose:-to change ui if probable resource.
            Case 0
                Dim intTotalCol As Integer = 11
                Dim sbHTML As New StringBuilder
                sbHTML.Append("<TD>")
                sbHTML.Append("<TABLE ID='EmployeeName'  Width=99.9% class=clsGridTable cellspacing=0 cellpadding=0>")
                sbHTML.Append("<tr class=").Append(strClass).Append(">")
                'sbHTML.Append("<tr>")
                sbHTML.Append("<TD>")
                sbHTML.Append(Server.HtmlEncode(Args.DataReader(Args.DataField).ToString) & "</TD></TR>")
                sbHTML.Append("<tr class=").Append(strClass).Append(">")
                'sbHTML.Append("<tr>")
                sbHTML.Append("<TD valign=middle align='left' id=Resume").Append(CType(m_EmployeeID, String)).Append(">")
                sbHTML.Append("<A href=""javascript:ShowResume(").Append(m_EmployeeID.ToString).Append(" )"" ><B>Resume</B></A>")
                sbHTML.Append("&nbsp;|&nbsp")
                sbHTML.Append("<A href=""javascript:ShowResourceLoading(").Append(m_EmployeeID.ToString).Append(" )"" ><B>Resource Loading</B></A>")
                ' Added By nitinVS on 28 Aug 2009 
                ' to show Daily veiw of resource allocation     
                sbHTML.Append("&nbsp;|&nbsp")
                sbHTML.Append("<A href=""javascript:ShowResourceAllocation(").Append(m_EmployeeID.ToString).Append(",'").Append(m_strFromDate).Append("' )"" ><B>Resource Allocation</B></A>")
                ' End Added By nitinVS on 28 Aug 2009 
                sbHTML.Append("</TD></TR></TABLE></td>")
                Args.StringToBeInserted += sbHTML.ToString()
                Cancel = True
                'End of addition by TrutpiK

                'Added By GaneshG On 27-Aug-09 
            Case 7 ' Max Allocation

                If m_strType = TYPE_PER_DAY Or m_strType = TYPE_PERCENT_WORKHOURS Then

                    Dim sbHTML As New StringBuilder
                    Dim strSQL As String
                    Dim drMinAllocation As IDataReader
                    Dim MinAllocation As Double

                    strControlName = "txtMinAllocation_" & m_lngRequestId.ToString() & "_" & m_EmployeeID.ToString()
                    strSQL = "usp_Sel_MinAllocation_For_Employee " & m_EmployeeID.ToString & ",'" & m_strFromDate & "','" & m_strToDate & "'," & m_lngRequestProjectId
                    drMinAllocation = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)

                    If drMinAllocation.Read() Then
                        If m_strType = TYPE_PER_DAY Then
                            MinAllocation = CType(drMinAllocation.Item("MinAvailablePerDayHrs"), Double)
                        ElseIf m_strType = TYPE_PERCENT_WORKHOURS Then
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
                'End Addition By GaneshG
        End Select
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        Select Case Args.ColIndex
            'Case 2  'Team
            '    Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Then
            '    '    Cancel = True
            '    'End If

            'Case 3  'Resource Pool
            '    Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Then
            '    '    Cancel = True
            '    'End If

            'Case 4  'OU Pool
            '    If m_strResourceAllocationLevel <> ALLOCATION_LEVEL_ODC Or m_strUserType = OU_MANAGER Then Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
            '    '    m_strUserType = OU_MANAGER Then
            '    '    Cancel = True
            '    'End If

            'Case 5  'BG Pool
            '    If m_strResourceAllocationLevel = ALLOCATION_LEVEL_CORPORATE Or m_strUserType = BG_MANAGER Then Cancel = True
            '    'If m_strUserType = "" Or m_strUserType = TEAM_MANAGER Or m_strUserType = RESOURCE_MANAGER Or _
            '    '    m_strUserType = OU_MANAGER Or m_strUserType = BG_MANAGER Then
            '    '    Cancel = True
            '    'End If
            Case 8, 9, 10  '7, 8, 9    ' FromDate, ToDate, WorkHours
                Args.ApplySorting = False
            Case 2
                Cancel = True

                'Added By GaneshG On 27-Aug-09
            Case 7
                If m_strType <> TYPE_PER_DAY And m_strType <> TYPE_PERCENT_WORKHOURS Then
                    Cancel = True
                End If
                'End Addition By GaneshG
        End Select
    End Sub

    Private Sub m_objAllocatedResourcesGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objAllocatedResourcesGrid.DataRowTD_BeforePrint
        Select Case Args.ColIndex
            Case 5  'Status
                Dim strStatus As String = ""

                Args.EnableLink = False
                strStatus = CommonFunctions.General.CheckIsNothing(Args.DataFieldValue, "")
                strStatus = strStatus.Trim().ToUpper()
                If strStatus = "A" Then
                    Args.DataFieldValue = MyBase.GetResourceString("ALLOCATED")
                ElseIf strStatus = "R" Then
                    Args.EnableLink = True
                    Args.DataFieldValue = MyBase.GetResourceString("REJECTED")
                ElseIf strStatus = "L" Then
                    Args.DataFieldValue = MyBase.GetResourceString("ASSIGNED_TO_PROJECT")
                ElseIf strStatus = "REVERT" Then
                    Args.DataFieldValue = MyBase.GetResourceString("REVERTED")
                End If
        End Select
    End Sub
    ''Added by Yogesh J on 15-Feb-2016 for to generate and validate Token		
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken_ShowMore_OnClick(ProjectID As String, RequestID As String) As String
        Try
            Dim m_PKToken_Request_Multiple As String
            m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(ProjectID, String) + CType(RequestID, String) + "0" + "0")

            Return m_PKToken_Request_Multiple
        Catch ex As Exception
            Return "Bad Request Found"
        End Try
    End Function
    ''End of addition by Yogesh J on 15-Feb-2016
#End Region



    'Added by TruptiK on 11-Mar-2008
    'Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint

    '    strEmployeeIDs = strEmployeeIDs + CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeID"), "0"), String) + ","

    'End Sub
    'End of addition by TrupitK
End Class
