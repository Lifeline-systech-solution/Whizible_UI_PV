Public Class IB_BatchUpdate
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

#Region " Constants Used in the Class "
    Private Const FIELD_SUBTYPE As String = "SubType"
    Private Const FIELD_STATUS As String = "Status"
    Private Const FIELD_TYPE As String = "Type"
    'This fieldname is used while retrieving the Field caption.
    Private Const FIELD_CODEBYNAME As String = "CodedByName"
    Private Const FIELD_ASSIGNTONAME As String = "AssignToName"
    'This field is used while updation.
    Private Const FIELD_CODEBY As String = "CodedBy"
    Private Const FIELD_ASSIGNTO As String = "AssignTo"

    Private Const FIELD_PRIORITY As String = "Priority"
    Private Const FIELD_SEVERITY As String = "Severity"
    '--Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
    'Code Added By PradipK on 15 Feb 2006
    Private Const FIELD_COMPLEXITY As String = "Complexity"
    'End Addition By PradipK on 15 Feb 2006

    Private Const FIELD_REPORTEDINVERSION As String = "ReportedInVersion"
    Private Const FIELD_CORRECTEDINVERSION As String = "CorrectedInVersion"
    Private Const FIELD_PHASE As String = "Phase"
    Private Const FIELD_FOUNDINPHASE As String = "FoundInPhase"
    Private Const FIELD_FIXEDINPHASE As String = "FixedInPhase"

    '****Code Added*******
    'By     :   DipaliS
    'Reason :   Root Cause Feature
    'Date   :   5 July 2004
    'Requirement No.:IB_PBN_ENT_06
    'Addition   : Added Declaration for the RootCause String
    Private Const FIELD_ROOTCAUSE As String = "RootCauseID"
    '******End Addition********
    '****Code Added*******
    'By     :   DipaliS
    'Reason :   Deliverable Feature
    'Date   :   19 Aug 2004
    'Addition   : Added Declaration for the Deliverable String
    Private Const FIELD_DELIVERABLE As String = "DeliverableID"
    '******End Addition********

    '' START : Added by ParagD 19-Sept-2006 : Security Issue 6197
    Protected m_PKToken_BatchUpdate As String
    '' START : Added by ParagD 19-Sept-2006 : Security Issue 6197

    Protected Const ACTION_UPDATE As String = "Update"
    Protected Const ACTION_CLEARALL As String = "Clear"
    Protected Const ACTION_UPDATE_SUCCESSFUL As String = "Update_Successful"
    Protected Const ACTION_UPDATE_FAIL As String = "Update_Fail"

    Private Enum MenuIndex
        UPDATE
        CLEAR_ALL
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 4
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    'Grid
    'Addition done by SuchitraP on 24-MAY-2007
    Dim WithEvents objGrid As New WebPage.Templates.GenericGrid
    Protected m_intNumberOfRecordsOfQuery As Integer = 0
    Dim m_strHtml As String = ""
    'End of Addition done by SuchitraP on 24-MAY-2007
    'Added by GaneshD to get the Query for the batch update [StatusFlow]
    Dim m_StrQueryForBatchUpdate As String = ""

    ' End of addition by GaneshD on 17 Aug 2009
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Private m_strPageTitle As String = ""
    Protected m_strAction As String = ""
    Private m_lngProjectId As Long = 0
    Private m_strLoginType As String = ""

    Private m_lngQueryId As Long = 0
    Private m_strSubType As String = ""
    Private m_strStatus As String = ""
    Private m_strCodedBy As String = ""
    Private m_strAssignTo As String = ""
    Private m_strPriority As String = ""
    Private m_strSeverity As String = ""

    'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
    'Added By PradipK
    Private m_strComplexity As String = ""

    Private m_strReportedVersion As String = ""
    Private m_strCorrectedInVersion As String = ""
    Private m_strPhase As String = ""
    Private m_strFoundInPhase As String = ""
    Private m_strFixedInPhase As String = ""
    '*********Code Added*********
    'By     :   DipaliS
    'Reason :   Apply Role Level Security
    'Date   :   25 June 2004
    'Requirement No.:IB_PBN_ENT_01
    'Changes Made: Added Variable for RoleID
    Private m_lngRoleID As Long
    '*********End Addition*********
    'By     :   DipaliS
    'Reason :   Root Cause Feature
    'Date   :   5 July 2004
    'Requirement No.:IB_PBN_ENT_06
    'Addition Made:Added the declaration for Root Cause
    Private m_strRootCause As String = ""
    '*****End addition********
    'By     :   DipaliS
    'Reason :   Deliverable Feature
    'Date   :   19 Aug 2004
    'Addition Made:Added the declaration for Deliverable
    Private m_strDeliverable As String = ""
    '*****End addition********
    'Added by PrashantD on 17 March 2007 for IssueID 11592
    Private m_blnUpdateLinkAccess As Boolean = True
#End Region

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Initialize the Global Objects

        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()

        ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        m_PKToken_BatchUpdate = Trim(Request.QueryString("PKToken") & "")
        If Request.QueryString("Action") <> "Clear" Then
            If (((Request.QueryString("PKToken") = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(Session("IssueProject"), String) + CType(m_objGlobal.UserID, String) + "0" + "0", m_PKToken_BatchUpdate) = False)) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If
        ''End of Addition by Dhanashri S on 11 Aug 2016

        If Trim(Request.QueryString("PKToken")) = "" Then
            'm_PKToken_BatchUpdate = CommonFunctions.Security.Token.GetToken(CType(Session("IssueProject"), String) + CType(m_objGlobal.UserID, String) + "0" + "0")
            'Modified by SavitaS on 25 Sept 2006 for Security Issue 6197
            m_PKToken_BatchUpdate = Request.Form("txtPkToken").ToString
            'Modified by SavitaS on 25 Sept 2006 for Security Issue 6197
        Else
            m_PKToken_BatchUpdate = Trim(Request.QueryString("PKToken") & "")
        End If
        ''Commented by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
        ''If (m_PKToken_BatchUpdate <> "" And CommonFunctions.Security.Token.ValidateToken(CType(Session("IssueProject"), String) + CType(m_objGlobal.UserID, String) + "0" + "0", m_PKToken_BatchUpdate)) = True Then
        ''End of Comment by Dhanashri S on 11 Aug 2016

        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

        InitPageMenu()
        m_strPageTitle = MyBase.GetResourceString("PAGE_TITLE")

        'commented by AniruddhaD on 18 Nov 2005 for providing project combo on issue list page(IssueID:685)
        'm_lngProjectId = m_objGlobal.ProjectID

        'Added by AniruddhaD on 18 Nov 2005 for providing project combo on issue list page(IssueID:685)
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("IssueProject").ToString, "0"), Long)

        m_strLoginType = m_objGlobal.LoginType
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        '*********Code Added*********
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   25 June 2004
        'Requirement No.:IB_PBN_ENT_01
        'Changes Made: Added Variable for RoleID
        m_lngRoleID = CType(Session("intPostID"), Long)

        '*********End Addition*********
        'Code Added By JyotiG
        'Issue Id: 7193
        'Date : 26-Oct-2006
        'Start
        'Code added by SandipL on 17 Feb 2006 --IssueID 2137 AND 2138 -- Whizsem_whiz2 sp6
        Dim intCorporateRoleLevel As Integer

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level_RoleID " & CType(Session("intUserID"), String) & "", MyBase.UseSQL), Integer)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_lngProjectId <> 0 Then
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'Added by PrashantD on 10 April 2007 IssueId 11594
            'If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("SELECT ApplyProjectLevelRole FROM tbl_PM_CompanyInformation", MyBase.UseSQL), "0"), Boolean) = True Then
            If CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_ApplyProjectLevelRole", MyBase.UseSQL), "0"), Boolean) = True Then
                'End of addition by PrashantD on 10 April 2007
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                'm_lngRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_lngProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                m_lngRoleID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_lngProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
                'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                If Not m_lngRoleID > 0 Then
                    m_lngRoleID = CType(Session("intPostID"), Long)
                End If
                'Added by PrashantD on 10 April 2007 IssueId 11594
            Else
                m_lngRoleID = CType(Session("intPostID"), Long)
            End If
            'End of addition by PrashantD on 10 April 2007

            If m_lngRoleID <> 0 Then
                m_objGlobal.RoleID = m_lngRoleID
            End If
        End If
        'Added by PrashantD on 17 March 2007 for IssueID 11592
        'Purpose: If user has IssueEntry edit access then only show update link in batch update page.
        Dim dr As IDataReader

        dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_UI_NodeAccess 5," + m_lngRoleID.ToString, MyBase.UseSQL)
        If dr.Read Then
            If CBool(dr("E")) = True Then
                m_blnUpdateLinkAccess = True
            Else
                m_blnUpdateLinkAccess = False
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        'End of addition by PrashantD on 17 March 2007
        'End addition by SandipL on 17 Feb 2006
        'End of modification By JyotiG
        GetFieldValues()
        If m_strAction = ACTION_UPDATE Then
            Update_Issues()
        End If

        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197


        'Else
        'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issues : Batch Update", 0, 0, "IssueID", "0")
        ''Token is Invalid now redirect to the Invalid Access Page
        'System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        'End If
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objMenu = Nothing
        m_objGlobal = Nothing
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_BatchUpdate", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "IB_BatchUpdate : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(m_strPageTitle)
    End Sub

    Private Sub WritePageLegend()
        Dim arrLegends(0) As String
        Dim arrLegendImg(0) As String
        arrLegends(0) = "&nbsp;" & MyBase.GetResourceString("MANDATORY")
        arrLegendImg(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)
        CommonFunctions.General.WriteHTML(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImg, arrLegends, True))
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        
        m_arrMenuItem(MenuIndex.UPDATE) = MyBase.GetResourceString("MENU_UPDATE")
        m_arrMenuTooltip(MenuIndex.UPDATE) = MyBase.GetResourceString("MENU_UPDATE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.UPDATE) = "Update_OnClick()"

        m_arrMenuItem(MenuIndex.CLEAR_ALL) = MyBase.GetResourceString("MENU_CLEARALL")
        m_arrMenuTooltip(MenuIndex.CLEAR_ALL) = MyBase.GetResourceString("MENU_CLEARALL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLEAR_ALL) = "ClearAll_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('IB_BATCHUPDATE')"

        MyBase.InitializeResources("AppResources.IB_BatchUpdate", "AppResources")
    End Sub

    Public Sub WritePage()
        Dim strMenu As String = ""
        Dim strHeader As String = ""
        Dim objHeaderFooter As WebPages.Template.HeaderFooter

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)

        'Display The Legend 
        WritePageLegend()

        'Display Page Caption
        'Modified by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(m_lngProjectId, String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectName_ID " + CType(m_lngProjectId, String), True), String)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("BATCH_UPDATE"), "Project: " + strProjectName, , True))
        'End Modification by SandipL
        CommonFunctions.General.WriteHTML("<br>")

        'Display Page Header
        strHeader = MyBase.GetResourceString("NOTE")
        strHeader = Replace(strHeader, "<=>", GetUserFriendlyName(FIELD_SUBTYPE))
        strHeader = Replace(strHeader, "<==>", GetUserFriendlyName(FIELD_STATUS))
        strHeader = Replace(strHeader, "<===>", GetUserFriendlyName(FIELD_TYPE))

        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.HeaderFooter = strHeader
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter()
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<br>")

     
        'Display Page Body
        Display_BatchUpdatePageBody()

        

        'Display Menu at Footer
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Private Sub Display_BatchUpdatePageBody()
        Dim strQuery As String = ""

        'Display the Select Query Combo
        CommonFunctions.General.WriteHTML("<Table class=clsTable width='99.9%'cellpadding=0 cellspacing=0><Tr class='clsTREven'><Td>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SELECT_QUERY") & " ")
        strQuery = "Exec Usp_Sel_tbl_IB_Query Null," & m_lngProjectId.ToString() & ",0" & ",'','"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "','A'"
        'Addition done by SuchitraP on 30-May-2007 for IB Batch Update
        'CommonFunctions.HTMLControls.DrawComboBox("cboQuery", strQuery, 320, m_lngQueryId.ToString(), , True, False, , True)
        CommonFunctions.HTMLControls.DrawComboBox("cboQuery", strQuery, 320, m_lngQueryId.ToString(), "onChange='QueryOnChange()'", True, False, , True)
        'End of addition by SuchitraP on 30-May-2007 for IB Batch Update
        'CommonFunctions.General.WriteHTML("</Td>")


        'Addition done by SuchitraP on 24-MAY-2007
        'CommonFunctions.General.WriteHTML("<TD>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp;&nbsp;&nbsp;")
        'Commented And Added By Vaijat K ON 30/12/2015 Purpose: text-decoration:underline link
        ' CommonFunctions.General.WriteHTML("<a Href=""Javascript:Execute_OnClick()"" > Execute </a>")
        CommonFunctions.General.WriteHTML("<a Href=""Javascript:Execute_OnClick()"" style='text-decoration:underline !important' > Execute </a>")
        CommonFunctions.General.WriteHTML("</TD>")
        'End of addition done by SuchitraP on 24-MAY-2007

        CommonFunctions.General.WriteHTML("</Tr></Table>")
        CommonFunctions.General.WriteHTML("<Br>")

        CommonFunctions.General.WriteHTML("<div id='divList' style='overflow:auto;height:600;width:100%;'>")

        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 style='width:100%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTROdd'><td>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("COMMON_FIELDS") & "</b>")
        CommonFunctions.General.WriteHTML("</td></tr></table>")

        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 style='width:100%'>")
        'Sub Type and Status combos
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_SUBTYPE))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' style='15%'>")
        strQuery = "Exec usp_Sel_IB_BU_SubType " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboSubType", strQuery, 200, m_strSubType, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_STATUS))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")

        'Code commented By DipaliS 28 June 2004 and added the following
        'strQuery = "Exec usp_Sel_IB_BU_TypeStatus " & m_lngProjectId.ToString() 

        '*********Code Added *********
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   28 June 2004
        'Requirement No.:IB_PBN_ENT_01
        'Changes Made: Added One More parameter RoleID to the SP that fetches the Status    
        strQuery = "Exec usp_Sel_IB_BU_TypeStatus " & m_lngProjectId.ToString() + "," + m_lngRoleID.ToString
        '*********End Addition*********

        CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strQuery, 200, m_strStatus, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Coded By Name' and 'Assign To Name' combos
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_CODEBYNAME))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' style='15%'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectResources " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboCodedBy", strQuery, 200, m_strCodedBy, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_ASSIGNTONAME))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectResources " & m_lngProjectId.ToString() & ", 1"
        CommonFunctions.HTMLControls.DrawComboBox("cboAssignTo", strQuery, 200, m_strAssignTo, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Priority and Severity combos
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_PRIORITY))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' style='15%'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectPriorities " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboPriority", strQuery, 200, m_strPriority, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_SEVERITY))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectSeverity " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboSeverity", strQuery, 200, m_strSeverity, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Reported In Version' and 'Corrected In Version' combos
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_REPORTEDINVERSION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' style='15%'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectVersions " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboReportedInVersion", strQuery, 200, m_strReportedVersion, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_CORRECTEDINVERSION))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectVersions " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboCorrectedInVersion", strQuery, 200, m_strCorrectedInVersion, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Phase and 'Found In Phase' combos
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_PHASE))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left' style='15%'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectPhases " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboSourcePhase", strQuery, 200, m_strPhase, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_FOUNDINPHASE))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectPhases " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboFoundInPhase", strQuery, 200, m_strFoundInPhase, , True)
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("</tr>")

        'Fixed In Phase' combo
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_FIXEDINPHASE))
        CommonFunctions.General.WriteHTML("</td>")
        'Code Commented By DipaliS 5 July 2004 And Added the following
        'CommonFunctions.General.WriteHTML("<td align='left' style='15%' colspan=3>")

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Root Cause Feature
        'Date   :   5 July 2004
        'Requirement No.:IB_PBN_ENT_06
        'Addition   : Removed the Colspan to draw the Root Cause Combo
        CommonFunctions.General.WriteHTML("<td align='left' style='15%'>")
        '*******End Addition*****

        strQuery = "Exec usp_Sel_IB_BU_ProjectPhases " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboFixedInPhase", strQuery, 200, m_strFixedInPhase, , True)
        CommonFunctions.General.WriteHTML("</td>")

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Root Cause Feature
        'Date   :   5 July 2004
        'Requirement No.:IB_PBN_ENT_06
        'Addition   : Draw the Root Cause Combo box
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_ROOTCAUSE))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_tbl_IB_Project_RootCause_ForProject " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboRootCause", strQuery, 200, m_strRootCause, , True)
        CommonFunctions.General.WriteHTML("</td>")


        '*****End Addition*******

        CommonFunctions.General.WriteHTML("</tr>")

        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Deliverable Feature
        'Date   :   19 Aug 2004
        'Addition   : Draw the Deliverable Combo box
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<td align='right' style='10%'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_DELIVERABLE))
        CommonFunctions.General.WriteHTML("</td>")

        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_sel_tbl_PM_OtherSchedules_ForBatch " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboDeliverable", strQuery, 200, m_strDeliverable, , True)
        CommonFunctions.General.WriteHTML("</td>")

        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
        'Code Added By Pradipk on 15 Feb 2006 to Add complexity Combo
        CommonFunctions.General.WriteHTML("<td align='right'>")
        CommonFunctions.General.WriteHTML(GetUserFriendlyName(FIELD_COMPLEXITY))
        CommonFunctions.General.WriteHTML("</td>")
        CommonFunctions.General.WriteHTML("<td align='left'>")
        strQuery = "Exec usp_Sel_IB_BU_ProjectComplexity " & m_lngProjectId.ToString()
        CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", strQuery, 200, m_strComplexity, , True)
        CommonFunctions.General.WriteHTML("</td>")
        'End Addition By PradipK on 15 Feb 2006

        CommonFunctions.General.WriteHTML("</tr>")
        '*****End Addition*******
        CommonFunctions.General.WriteHTML("</table>")


        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 style='width:100%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTROdd'><td>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("CUSTOME_FIELDS") & "</b>")
        CommonFunctions.General.WriteHTML("</td></tr></table>")

        'Display the Custom Fields
        Display_CustomFields()
        'Added by SavitaS on 25 Sept 2006 for Security Issue 6197
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_BatchUpdate, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:07/10/15
        'End Addition by SavitaS on 25 Sept 2006 for Security Issue 6197
        CommonFunctions.General.WriteHTML("</div>")
    End Sub

    Private Sub Display_CustomFields()
        '****Code Added*******
        'By     :   DipaliS
        'Reason :   Apply Role Level Security to custom fields
        'Date   :   6 July 2004
        'Requirement No.:IB_PBN_ENT_05
        'Addition   :  Added the code to check if security is set for given projectID and RoleID

        Dim drCustomAccess As IDataReader
        Dim strSQLForCustom As String
        Dim strCustomFieldIDs() As String
        Dim intCount As Integer
        'Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration
        'Commented and Modified by SavitaS on 20 July for Nucleus IssueID 22977
        'Issue : Issue status removes information from some fields
        ' strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleID.ToString
        strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_lngProjectId.ToString + "," + m_lngRoleID.ToString + ",NULL," + m_strLoginType.ToString
        'End of Commented and Modified by SavitaS on 20 July for Nucleus IssueID 22977
        'End of Integrated by SavitaS on 17 Aug 2006 for SP-7 Integration

        drCustomAccess = CommonFunction.Data.GetDataReader(strSQLForCustom, MyBase.UseSQL)

        While drCustomAccess.Read
            ReDim Preserve strCustomFieldIDs(intCount)
            strCustomFieldIDs(intCount) = CType(CommonFunction.General.CheckIsNothing(drCustomAccess("CustomFieldID")), String)
            intCount += 1
        End While

        CommonFunction.Data.DisposeDataReader(drCustomAccess)

        '*****End Addition*******

        Dim drTempWork As IDataReader
        Dim strQuery As String = ""
        Dim blnHasRecord As Boolean = False
        Dim intMaxRow As Integer = 0
        Dim intMaxColumn As Integer = 0
        Dim intRow As Integer = 0
        Dim intColumn As Integer = 0
        Dim intCurrentCellNumber As Integer = 0
        Dim intNextCellNumber As Integer = 0
        'Custom Field Related variables
        Dim strCustomFieldCaption As String = ""
        Dim strCustomFieldName As String = ""
        Dim intCustomFieldWidth As Integer = 0
        Dim intCustomFieldMaxLength As Integer = 0
        Dim intCustomFieldRowNumber As Integer = 0
        Dim intCustomFieldColumnNumber As Integer = 0
        Dim strStyle As String = ""
        Dim strValue As String = ""

        'Get the Max Row Number and Column Number
        strQuery = "EXEC usp_Sel_IB_CustomFields_Max_Positon " & m_lngProjectId.ToString() & ",1"
        drTempWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
            If drTempWork.Read() Then
                intMaxRow = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("RowNumber"), "0"), Integer)
                intMaxColumn = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("ColumnNumber"), "0"), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drTempWork)

        'CommonFunctions.General.WriteHTML("<div id='divCustomFields' style='overflow:auto;height:200;width:100%;'>")
        CommonFunctions.General.WriteHTML("<div id='divCustomFields' style='overflow:auto;width:100%;'>")
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 style='width:100%'>")

        strQuery = "Exec usp_Sel_tbl_IB_CustomFields_Master " & m_lngProjectId.ToString()
        drTempWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drTempWork) <> "" Then
            If drTempWork.Read() Then
                blnHasRecord = True
                'Display all Custom Field Controls
                For intRow = 1 To intMaxRow
                    CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
                    For intColumn = 1 To intMaxColumn
                        If blnHasRecord = True Then
                            strCustomFieldCaption = drTempWork.Item("UserGivenCaption").ToString()
                            strCustomFieldCaption = CommonFunctions.General.UnBuildQueryString(strCustomFieldCaption)
                            strCustomFieldName = drTempWork.Item("DatabaseFieldName").ToString()
                            strCustomFieldName = CommonFunctions.General.UnBuildQueryString(strCustomFieldName)
                            intCustomFieldWidth = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("ControlWidth"), "0"), Integer)
                            intCustomFieldMaxLength = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("MaxLength"), "0"), Integer)
                            intCustomFieldRowNumber = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("RowNumber"), "0"), Integer)
                            intCustomFieldColumnNumber = CType(CommonFunctions.Data.CheckIsDBNull(drTempWork.Item("ColumnNumber"), "0"), Integer)
                            If m_strAction = ACTION_CLEARALL Then
                                strValue = ""
                            Else
                                strValue = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strCustomFieldName))
                                strValue = CommonFunctions.General.UnBuildQueryString(strValue)
                            End If
                            intCurrentCellNumber = (intRow * intMaxColumn) + intColumn
                            intNextCellNumber = (intCustomFieldRowNumber * intMaxColumn) + intCustomFieldColumnNumber
                            If intCurrentCellNumber = intNextCellNumber Then
                                CommonFunctions.General.WriteHTML("<td align=right>" & Server.HtmlEncode(strCustomFieldCaption) & "</td>")
                                CommonFunctions.General.WriteHTML("<td>")
                                '****Code Added*******
                                'By     :   DipaliS
                                'Reason :   Apply Role Level Security to custom fields
                                'Date   :   6 July 2004
                                'Requirement No.:IB_PBN_ENT_05
                                'Addition   :  Added the code to check if security is set for given projectID and RoleID
                                Dim blnShowControl As Boolean = False
                                Dim intCounter As Integer

                                intCounter = 0
                                'If length of array is greater than 0 that means security is explicitly set
                                'In that case check if it is accessible ,if yes then show the control, 
                                'otherwise show it as not applicable
                                If intCount > 0 Then

                                    While intCounter < intCount
                                        'Check if the current Custom Field ID is in the array
                                        If strCustomFieldIDs(intCounter).ToLower.Trim = _
                                                    CType(CommonFunction.General.CheckIsNothing(drTempWork("UniqueId")), String).ToLower.Trim Then
                                            blnShowControl = True
                                        End If

                                        intCounter = intCounter + 1

                                    End While

                                Else
                                    'Commented By DipaliS To Ensure that the Custom Field will not be visible unless and untill access is set explicitly for it.
                                    'blnShowControl = True
                                End If

                                If blnShowControl = True Then

                                    '*****End Addition*******


                                    If InStr(UCase(strCustomFieldName), "CUSTOMFIELDTEXT", CompareMethod.Text) <> 0 Then
                                        If intCustomFieldWidth <> 0 Then strStyle = "style='Width:" & intCustomFieldWidth.ToString() & "'"
                                        ' Maxlength for text is 100
                                        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                                        CommonFunctions.HTMLControls.DrawTextBox(strCustomFieldName, strCustomFieldName, , , 100, strValue, , strStyle, EnableHTMLEncode:=True)
                                        'ended by Yogesh J for HTML encoding Date:07/10/15
                                    ElseIf InStr(UCase(strCustomFieldName), "CUSTOMFIELDDATE", CompareMethod.Text) <> 0 Then
                                        CommonFunctions.HTMLControls.DrawDateControl(strCustomFieldName, strCustomFieldName, , , strValue, , "frmBatchUpdate")
                                    ElseIf InStr(UCase(strCustomFieldName), "CUSTOMFIELDCOMBO", CompareMethod.Text) <> 0 Then
                                        strQuery = "EXEC Usp_Sel_tbl_IB_CustomFields_Details '"
                                        strQuery &= CommonFunctions.General.BuildQueryString(strCustomFieldName) & "', " & m_lngProjectId.ToString()
                                        CommonFunctions.HTMLControls.DrawComboBox(strCustomFieldName, strQuery, , strValue, , True)
                                    End If

                                    '********Code Added********
                                    'By     :   DipaliS
                                    'Reason :   Apply Role Level Security to custom fields
                                    'Date   :   6 July 2004
                                    'Requirement No.:IB_PBN_ENT_05
                                    'Addition   :  End of condition added above
                                Else
                                    Response.Write("( " + MyBase.GetResourceString("NOTAPPLICABLE") + " )")
                                End If
                                '******End Addition

                                CommonFunctions.General.WriteHTML("</td>")
                                If drTempWork.Read() Then
                                    blnHasRecord = True
                                Else
                                    blnHasRecord = False
                                End If

                            ElseIf intCurrentCellNumber < intNextCellNumber Then
                                CommonFunctions.General.WriteHTML("<td valign=top align=right colspan=2>&nbsp;</td>")

                            ElseIf intCurrentCellNumber > intNextCellNumber Then
                                CommonFunctions.General.WriteHTML("<td valign=top align=right colspan=2>&nbsp;</td>")
                                If drTempWork.Read() Then
                                    blnHasRecord = True
                                Else
                                    blnHasRecord = False
                                End If
                            End If
                        Else
                            CommonFunctions.General.WriteHTML("<td valign=top align=right colspan=2>&nbsp;</td>")
                        End If
                    Next
                    CommonFunctions.General.WriteHTML("</tr>")
                Next
            Else
                'No custom fields for the project		
                CommonFunctions.General.WriteHTML("<tr class='clsTREven'>")
                CommonFunctions.General.WriteHTML("<td align='center' valign='center'><b>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_CUSTOM_FIELDS_DEFINED"))
                CommonFunctions.General.WriteHTML("</b></td></tr>")
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drTempWork)

        CommonFunctions.General.WriteHTML("</table>")
        CommonFunctions.General.WriteHTML("</div>")

        'Addition done by SuchitraP on 24-MAY-2007 for IssueBase BatchUpdate
        'Display Ouery Output
        If Request.QueryString("Action") = "EXECUTE" Then
            Display_BatchUpdateQueryOutput()
        End If
        CommonFunctions.General.WriteHTML("<div id='divQueryOutput' style='overflow:auto'>")
        CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 style='width:100%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTROdd'><td>")
        CommonFunctions.General.WriteHTML("<b>Query Output</b>")
        'CommonFunctions.General.WriteHTML("</td></tr></table>")
        'CommonFunctions.General.WriteHTML("</div>")

        'CommonFunctions.General.WriteHTML("<div id='divNumberOfRecords' style='overflow:auto'>")
        'CommonFunctions.General.WriteHTML("<table class='clsTable' cellspacing='0' cellpadding=0 style='width:100%'>")
        If Request.QueryString("Action") = "EXECUTE" Then
            CommonFunctions.General.WriteHTML("<td align='right'>")
            CommonFunctions.General.WriteHTML("<b>Number of records:" + CType(m_intNumberOfRecordsOfQuery, String) + "</b>")
            CommonFunctions.General.WriteHTML("</td>")
        End If
        CommonFunctions.General.WriteHTML("</tr></table>")
        CommonFunctions.General.WriteHTML("</div>")

        If Not Request.Form("isExecute") Is Nothing AndAlso Request.QueryString("Action") <> ACTION_UPDATE Then
            CommonFunctions.General.WriteHTML("<input type=hidden name='isExecute' id='isExecute' value=" + Request.Form("isExecute") + ">")
        Else
            CommonFunctions.General.WriteHTML("<input type=hidden name='isExecute' id='isExecute' value=0>")
        End If

        If Request.QueryString("Action") = "EXECUTE" Then
            Response.Write(m_strHtml)
        End If

        'End of Addition done by SuchitraP on 24-MAY-2007 IssueBase BatchUpdate

    End Sub

    Private Sub GetFieldValues()
        '==================================================================================
        ' Procedure Name		:	GetFieldValues
        ' Purpose				:	To Get the Values of the variables from the Fields used in the form.
        ' Description			:	If the Action is 'Clear all Fields' then set variables value to default.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Jayavant
        ' Created				:	10-Mar-2004
        ' Revisions				:	
        '==================================================================================

        m_lngQueryId = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboQuery")), Long)
        If m_lngQueryId = 0 And m_strAction <> ACTION_UPDATE Then
            m_lngQueryId = CType(Session.Item("intQueryID"), Long)
        End If
        If m_strAction = ACTION_CLEARALL Then
            m_strSubType = ""
            m_strStatus = ""
            m_strCodedBy = ""
            m_strAssignTo = ""
            m_strPriority = ""
            m_strSeverity = ""
            m_strReportedVersion = ""
            m_strCorrectedInVersion = ""
            m_strPhase = ""
            m_strFoundInPhase = ""
            m_strFixedInPhase = ""
            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Root Cause Feature
            'Date   :   5 July 2004
            'Requirement No.:IB_PBN_ENT_06
            'Addition Made : Added Code to clear the Root Cause
            m_strRootCause = ""
            '******End addition*******
            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Deliverable Feature
            'Date   :   19 Aug 2004
            'Addition Made : Added Code to clear the Deliverable
            m_strDeliverable = ""
            '******End addition*******
            

        Else
            m_strSubType = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSubType"))
            m_strSubType = CommonFunctions.General.UnBuildQueryString(m_strSubType)
            m_strStatus = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboStatus"))
            m_strStatus = CommonFunctions.General.UnBuildQueryString(m_strStatus)
            m_strCodedBy = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCodedBy"))
            m_strCodedBy = CommonFunctions.General.UnBuildQueryString(m_strCodedBy)
            m_strAssignTo = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboAssignTo"))
            m_strAssignTo = CommonFunctions.General.UnBuildQueryString(m_strAssignTo)
            m_strPriority = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboPriority"))
            m_strPriority = CommonFunctions.General.UnBuildQueryString(m_strPriority)
            m_strSeverity = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSeverity"))
            m_strSeverity = CommonFunctions.General.UnBuildQueryString(m_strSeverity)

            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
            'Code Added By PradipK on 15 Feb 2006
            m_strComplexity = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboComplexity"))
            m_strComplexity = CommonFunctions.General.UnBuildQueryString(m_strComplexity)
            'End Addition By PradipK on 15 Feb 2006

            m_strReportedVersion = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboReportedInVersion"))
            m_strReportedVersion = CommonFunctions.General.UnBuildQueryString(m_strReportedVersion)
            m_strCorrectedInVersion = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboCorrectedInVersion"))
            m_strCorrectedInVersion = CommonFunctions.General.UnBuildQueryString(m_strCorrectedInVersion)
            m_strPhase = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboSourcePhase"))
            m_strPhase = CommonFunctions.General.UnBuildQueryString(m_strPhase)
            m_strFoundInPhase = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboFoundInPhase"))
            m_strFoundInPhase = CommonFunctions.General.UnBuildQueryString(m_strFoundInPhase)
            m_strFixedInPhase = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboFixedInPhase"))
            m_strFixedInPhase = CommonFunctions.General.UnBuildQueryString(m_strFixedInPhase)

            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Root Cause Feature
            'Date   :   5 July 2004
            'Requirement No.:IB_PBN_ENT_06
            'Addition Made : Added Code to clear the Root Cause
            m_strRootCause = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboRootCause"))
            m_strRootCause = CommonFunctions.General.UnBuildQueryString(m_strRootCause)

            '*****End addition********

            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Deliverable Feature
            'Date   :   19 Aug 2004
            'Addition Made : Added Code to clear the Deliverable
            m_strDeliverable = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("cboDeliverable"))
            m_strDeliverable = CommonFunctions.General.UnBuildQueryString(m_strDeliverable)
            '*****End addition********

            
        End If
    End Sub

    Private Function GetUserFriendlyName(ByVal strFieldName As String) As String
        '==================================================================================
        ' Procedure Name		:	GetUserFriendlyName
        ' Parameters Passed		:	strFieldName :- The field name whose user friendly name must be returned.
        ' Returns				:	Returns the User Friendly name of the field specified.
        ' Parameters Affected	:	None.
        ' Purpose				:	To return the user friendly name of the database field passed.
        ' Description			:	Same as above.
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Jayavant
        ' Created				:	10-Mar-2004
        ' Revisions				:	
        '==================================================================================

        Dim drField As IDataReader
        Dim strQuery As String = ""
        Dim strReturn As String = ""

        GetUserFriendlyName = ""
        strQuery = "Exec usp_Sel_tbl_IB_DataDictionary '" & CommonFunctions.General.BuildQueryString(strFieldName) & "'"

        drField = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drField) <> "" Then
            If drField.Read() Then
                strReturn = drField.Item("UserFriendlyName").ToString()
                strReturn = CommonFunctions.General.UnBuildQueryString(strReturn)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drField)
        Return (strReturn)
    End Function

    Private Sub Update_Issues()
        '==================================================================================
        ' Procedure Name		:	Update_Issues
        ' Purpose				:	This procedure is updating the issues with the current parameters.
        ' Description			:	
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Jayavant
        ' Created				:	10-Mar-2004
        ' Revisions				:	
        '==================================================================================
        

        Dim strQuery As String = ""
        Dim strUpdateSQL As String = ""
        Dim strWhereClause As String = ""
        Dim drWork As IDataReader
        Dim strDatabaseFieldName As String = ""
        'Added by GaneshD on 17 Aug 2009 for Issue Batch update based on [Statusflow confoguration]
        Dim strInvalidIssueList As String = ""
        Dim strSQLForInvalidIssueID As String = ""
        ' End of addition by GaneshD 

        'Set the action to Fail. After successful update change it to successful.
        m_strAction = ACTION_UPDATE_FAIL

        ' query id & Project id is must for the batch update
        If m_lngQueryId <> 0 And m_lngProjectId <> 0 Then
            '-----------------------------------------------------------------
            ' 1) Get the where clause to be applied from the selected query
            '-----------------------------------------------------------------
            drWork = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_IB_Query " & m_lngQueryId.ToString(), MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If drWork.Read() Then
                    strWhereClause = drWork.Item("QueryText").ToString()
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            '-----------------------------------------------------------------
            ' 2) Append the project id
            '-----------------------------------------------------------------
            If strWhereClause.Trim() <> "" Then
                strWhereClause = " (" & strWhereClause.Trim() & ")" & " AND ProjectID=" & m_lngProjectId.ToString()
            Else
                strWhereClause = " ProjectID =" & m_lngProjectId.ToString()
            End If
            ' Added by GAneshD on 17 Aug 2009 for batch update [to check statusflow]
            m_StrQueryForBatchUpdate = "SELECT IssueID,ProjectID,[Type],Status,0 FROM v_tbl_IB_Issue WHERE 1=1 "
            If Trim(strWhereClause & "") <> "" Then
                m_StrQueryForBatchUpdate &= " AND " & strWhereClause
            End If
            m_StrQueryForBatchUpdate = CommonFunctions.General.BuildQueryString(m_StrQueryForBatchUpdate)

            'End of addition by GaneshD on 17 Aug 2009 ***********************************************
            '-----------------------------------------------------------------		
            ' 3) Build the update query for the parameters except "Type Status", "Sub Type" & "Custom Fields"  	
            '-----------------------------------------------------------------
            strUpdateSQL = ""

            ' Coded By
            BuildUpdateQuery(FIELD_CODEBY, m_strCodedBy, strUpdateSQL)

            ' Assign To
            BuildUpdateQuery(FIELD_ASSIGNTO, m_strAssignTo, strUpdateSQL)

            ' Reported In Version 
            BuildUpdateQuery(FIELD_REPORTEDINVERSION, m_strReportedVersion, strUpdateSQL)

            ' Corrected In Version 
            BuildUpdateQuery(FIELD_CORRECTEDINVERSION, m_strCorrectedInVersion, strUpdateSQL)

            ' Priority
            BuildUpdateQuery(FIELD_PRIORITY, m_strPriority, strUpdateSQL)

            ' Severity
            BuildUpdateQuery(FIELD_SEVERITY, m_strSeverity, strUpdateSQL)

            'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA     
            'Code Added By PradipK on 15 Feb 2006
            'Complexity
            BuildUpdateQuery(FIELD_COMPLEXITY, m_strComplexity, strUpdateSQL)
            'End Addition By PradipK on 15 Feb 2006


            ' Phase
            BuildUpdateQuery(FIELD_PHASE, m_strPhase, strUpdateSQL)

            ' FoundInPhase
            BuildUpdateQuery(FIELD_FOUNDINPHASE, m_strFoundInPhase, strUpdateSQL)

            ' FixedInPhase
            BuildUpdateQuery(FIELD_FIXEDINPHASE, m_strFixedInPhase, strUpdateSQL)


            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Root Cause Feature
            'Date   :   5 July 2004
            'Requirement No.:IB_PBN_ENT_06
            'Addition Made : Added Code to append the qeury for Root Cause
            BuildUpdateQuery(FIELD_ROOTCAUSE, m_strRootCause, strUpdateSQL)
            '****End addition******
            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Deliverable Feature
            'Date   :   19 Aug 2004
            'Addition Made : Added Code to append the qeury for Deliverable
            BuildUpdateQuery(FIELD_DELIVERABLE, m_strDeliverable, strUpdateSQL)
            '****End addition******

            '-----------------------------------------------------------------
            ' 4) Build the update query for the parameter "Type Status"
            '-----------------------------------------------------------------
            BuildUpdateQuery(FIELD_STATUS, m_strStatus, strUpdateSQL)

            '-----------------------------------------------------------------			
            ' 5) Build the update query for the parameter "Sub Type"
            '-----------------------------------------------------------------
            BuildUpdateQuery(FIELD_SUBTYPE, m_strSubType, strUpdateSQL)

            '-----------------------------------------------------------------
            ' 6) Building update query for "custom fields"
            '-----------------------------------------------------------------
            drWork = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_IB_CustomFields_Master " & m_lngProjectId.ToString(), MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                While drWork.Read()
                    strDatabaseFieldName = drWork.Item("DatabaseFieldName").ToString()
                    BuildUpdateQuery(strDatabaseFieldName, CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strDatabaseFieldName)), strUpdateSQL)
                End While
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)

            'Added By VarunA on 26-Nov-2008 RequestID-21028
            'Purpose : To have ClosedDate while updating status as closed from BatchUpdate.
            Dim drIssueID As IDataReader
            Dim strIssueID As String = ""
            If Trim(strUpdateSQL & "") <> "" Then
                strQuery = " SELECT IssueID FROM V_tbl_IB_Issue WHERE"

                ' append where clause
                If Trim(strWhereClause & "") <> "" Then
                    strQuery &= strWhereClause
                End If

                ' type filter
                If m_strSubType.Trim() <> "" Then
                    strQuery &= " AND (Type IN (Select Distinct(Type) FROM tbl_IB_Project_Sub_Type WHERE SubType = '"

                    'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
                    strQuery &= CommonFunctions.General.BuildQueryString(m_strSubType) & "' AND ProjectID=" & Session("IssueProject").ToString & " ) )"
                End If

                ' status filter
                If m_strStatus.Trim() <> "" Then
                    strQuery &= " AND (Type IN (Select Distinct(Type) FROM tbl_IB_Project_Type_status WHERE Status = '"

                    'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
                    strQuery &= CommonFunctions.General.BuildQueryString(m_strStatus) & "' AND ProjectID=" & Session("IssueProject").ToString & ") )"
                End If

                '*******Code Added*********
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   25 June 2004
                'Requirement No.:IB_PBN_ENT_01
                'Addition Done : Added clause for Accessible types For Given Role For Given Project
                'Append the Query for applying the Role Level Security for Type
                'Check if there is any Security applied for given Role for given projectID.
                Dim drTypeAccess As IDataReader
                Dim strSQLForRole As String
                Dim strListOfTypes As String

                strListOfTypes = ""

                'Get the Types accessible for 
                strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & m_lngProjectId & "," & m_lngRoleID & ",0,@strTypeList OUTPUT" & vbCrLf
                drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

                'If any record found that means security is explicitly set for the Role for that project
                While drTypeAccess.Read
                    strListOfTypes = strListOfTypes + "'" + CommonFunctions.General.BuildQueryString(CType(CommonFunctions.General.CheckIsNothing(drTypeAccess.Item("TypeName")), String)) + "',"
                End While

                'Remove the last comma
                If strListOfTypes <> "" Then
                    strListOfTypes = Left(strListOfTypes, strListOfTypes.Length - 1)
                End If
                CommonFunctions.Data.DisposeDataReader(drTypeAccess)

                If strListOfTypes.Trim <> "" Then
                    strQuery = strQuery + " AND Type in (" + strListOfTypes + ")"
                End If
                '*******End Addition***********

                ' update the Issues

                drIssueID = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
                While drIssueID.Read
                    strIssueID = strIssueID + "," + drIssueID("IssueID").ToString
                End While
                If strIssueID <> "" Then
                    strIssueID = strIssueID.Substring(1, strIssueID.Length - 1)
                End If
                drIssueID.Dispose()
                drIssueID.Close()
            End If
            'End By VarunA on 26-Nov-2008 RequestID-21028


            '-----------------------------------------------------------------
            ' 7) Updating the issues
            '-----------------------------------------------------------------
            If Trim(strUpdateSQL & "") <> "" Then
                strQuery = " UPDATE V_tbl_IB_Issue SET "
                strQuery &= strUpdateSQL

                'Integrated by NitinVS on 13 Aug 2007 for WhizibleSEM 7
                'Added by PrajaktaR on 13th Aug 2007 for Nucleus RequestID - 7512
                If strUpdateSQL.IndexOf("Status") > 0 Then
                    Dim strCurrentHours As String
                    Dim strCurrentTime As String

                    strCurrentHours = Now.Hour.ToString
                    If CType(Now.Hour.ToString, Integer) < 10 Then
                        strCurrentHours = "0" + Now.Hour.ToString
                    End If
                    strCurrentTime = Now.Minute.ToString
                    If CType(Now.Minute.ToString, Integer) < 10 Then
                        strCurrentTime = "0" + Now.Minute.ToString
                    End If

                    strQuery &= ", StatusChangeDate = '" & CommonFunction.Dates.GetDate(Now()) & "'"
                    strQuery &= ", StatusChangeTime = '" & strCurrentHours + ":" + strCurrentTime & "'"
                    ' Added by GaneshD on 17 Aug 2009 For StatusFlow in batch update
                    strSQLForInvalidIssueID = "USP_Sel_InValidIssueIDsForBatchUpdate '" & m_StrQueryForBatchUpdate & "','" & m_strStatus & "'"
                    strInvalidIssueList = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLForInvalidIssueID, MyBase.UseSQL), ""))
                    ' End of addition by GaneshD

                End If
                'END : Added by PrajaktaR on 13th Aug 2007 for Nucleus RequestID - 7512
                'End Integration by NitinVS on 13 Aug 2007 for WhizibleSEM 7

                'strSQL = strSQL & ", CreatorOrModifier = '" & session("strUserName") & "' WHERE 1=1 "
                strQuery &= ", CreatorOrModifier = '" & CommonFunctions.General.BuildQueryString(Session("strUserName").ToString) & "'  WHERE 1=1 "

                ' append where clause
                If Trim(strWhereClause & "") <> "" Then
                    strQuery &= " AND " & strWhereClause
                End If

                ' type filter
                If m_strSubType.Trim() <> "" Then
                    strQuery &= " AND (Type IN (Select Distinct(Type) FROM tbl_IB_Project_Sub_Type WHERE SubType = '"

                    'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
                    strQuery &= CommonFunctions.General.BuildQueryString(m_strSubType) & "' AND ProjectID=" & Session("IssueProject").ToString & " ) )"
                End If

                ' status filter
                If m_strStatus.Trim() <> "" Then
                    strQuery &= " AND (Type IN (Select Distinct(Type) FROM tbl_IB_Project_Type_status WHERE Status = '"

                    'Session("intProjectID") replaced by Session("IssueProject") by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list page(IssueID:685)
                    strQuery &= CommonFunctions.General.BuildQueryString(m_strStatus) & "' AND ProjectID=" & Session("IssueProject").ToString & ") )"
                End If

                '*******Code Added*********
                'By     :   DipaliS
                'Reason :   Apply Role Level Security
                'Date   :   25 June 2004
                'Requirement No.:IB_PBN_ENT_01
                'Addition Done : Added clause for Accessible types For Given Role For Given Project
                'Append the Query for applying the Role Level Security for Type
                'Check if there is any Security applied for given Role for given projectID.
                Dim drTypeAccess As IDataReader
                Dim strSQLForRole As String
                Dim strListOfTypes As String

                strListOfTypes = ""

                'Get the Types accessible for 
                strSQLForRole = "DECLARE @strTypeList varchar(7000) " & vbCrLf
                strSQLForRole = strSQLForRole + "Exec usp_sel_tbl_ib_typerolesecurity_project " & m_lngProjectId & "," & m_lngRoleID & ",0,@strTypeList OUTPUT" & vbCrLf
                drTypeAccess = CommonFunctions.Data.GetDataReader(strSQLForRole, MyBase.UseSQL)

                'If any record found that means security is explicitly set for the Role for that project
                While drTypeAccess.Read
                    strListOfTypes = strListOfTypes + "'" + CommonFunctions.General.BuildQueryString(CType(CommonFunctions.General.CheckIsNothing(drTypeAccess.Item("TypeName")), String)) + "',"
                End While

                'Remove the last comma
                If strListOfTypes <> "" Then
                    strListOfTypes = Left(strListOfTypes, strListOfTypes.Length - 1)
                End If
                CommonFunctions.Data.DisposeDataReader(drTypeAccess)

                If strListOfTypes.Trim <> "" Then
                    strQuery = strQuery + " AND Type in (" + strListOfTypes + ")"
                End If
                '*******End Addition***********
                ' Added by GaneshD on 18 Aug 2009 for Statusflow abtch update
                If strInvalidIssueList <> "" Then
                    strQuery = strQuery + " AND IssueID NOT in (" + strInvalidIssueList + ")"
                End If
                ' End of addition by GaneshD
                ' update the Issues
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

                m_strAction = ACTION_UPDATE_SUCCESSFUL
            End If

            'Added By VarunA on 26-Nov-2008 RequestID-21028
            'Purpose : To have ClosedDate while updating status as closed from BatchUpdate.
            Dim strIssueStatusID As String = ""
            If strIssueID <> "" Then
                If strUpdateSQL.IndexOf("Status") > 0 Or strUpdateSQL.IndexOf("DeliverableID") > 0 Then
                    Dim strSQLIssueQuery As String
                    'Commented and modified by GaneshD on 20 Aug 2009 For WSEM BAtch Update issue ID-32623
                    'strSQLIssueQuery = "usp_Upd_Issue_BatchUpdate_ChangeStatus '" & strIssueID & "','" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'," & m_lngProjectId & ",'" & CommonFunctions.General.BuildQueryString(m_strDeliverable) & "'"
                    If strInvalidIssueList = "" Then
                        strInvalidIssueList = "0"
                    End If
                    strSQLIssueQuery = "usp_Upd_Issue_BatchUpdate_ChangeStatus '" & strIssueID & "','" & CommonFunctions.General.BuildQueryString(m_strStatus) & "'," & m_lngProjectId & ",'" & CommonFunctions.General.BuildQueryString(m_strDeliverable) & "','" & strInvalidIssueList & "'"
                    ' End of modification by GaneshD
                    CommonFunctions.Data.InsertOrUpdateData(strSQLIssueQuery, MyBase.UseSQL)
                End If
            End If
            'End By VarunA on 26-Nov-2008 RequestID-21028

        End If
    End Sub

    Private Sub BuildUpdateQuery(ByVal strFieldName As String, ByVal strFieldValue As String, _
                                 ByRef strUpdateSQL As String)
        '==================================================================================
        ' Procedure Name		:	BuildUpdateQuery
        ' Purpose				:	This procedure Builds the Update query depending upon the value of the
        '                           Field.
        ' Parameters            :
        '   Param-1             :   strFieldName - The database name of the Custom Field.
        '   Param-2             :   strFieldValue - The Value of the Custom Field.
        '   Param-3             :   strUpdateSQL - The Builded query.
        ' Description			:	
        ' Assumptions			:	
        ' Dependencies			:	None
        ' Author				:	Jayavant
        ' Created				:	10-Mar-2004
        ' Revisions				:	
        '==================================================================================
        Const strStringToAppend As String = ","

        Select Case strFieldValue.Trim().ToUpper()
            Case ""
                'Do Nothing

            Case "[BLANK]"
                If Trim(strUpdateSQL) <> "" Then
                    strUpdateSQL &= strStringToAppend
                Else
                    strUpdateSQL = strUpdateSQL
                End If
                strUpdateSQL &= " " & strFieldName & " = NULL"

            Case Else
                If Trim(strUpdateSQL) <> "" Then
                    strUpdateSQL &= strStringToAppend
                Else
                    strUpdateSQL = strUpdateSQL
                End If
                If InStr(strFieldName, "CUSTOMFIELDCOMBO", CompareMethod.Text) <> 0 Then
                    ' taking only first 100 chars for custom combo box
                    'Modified By VarunA on 7-July-2008 IssueID-21538
                    'Purpose : To have single Quotes in Custom fields.
                    'strUpdateSQL &= " " & CommonFunctions.General.BuildQueryString(strFieldName) & " = '" & CommonFunctions.General.BuildQueryString(Left(strFieldValue, 100)) & "'"
                    strUpdateSQL &= " " & CommonFunctions.General.BuildQueryString(strFieldName) & " = '" & Left(strFieldValue, 100) & "'"
                    'End By VarunA on 7-July-2008 IssueID-21538
                Else
                    'Modified By VarunA on 7-July-2008 IssueID-21538
                    'strUpdateSQL &= " " & CommonFunctions.General.BuildQueryString(strFieldName) & " = '" & CommonFunctions.General.BuildQueryString(strFieldValue) & "'"
                    strUpdateSQL &= " " & CommonFunctions.General.BuildQueryString(strFieldName) & " = '" & strFieldValue & "'"
                    'End By VarunA on 7-July-2008 IssueID-21538
                End If
        End Select
    End Sub

    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        'Added by PrashantD on 17 March 2007 for IssueID 11592
        'Purpose: If user has IssueEntry edit access then only show update link in batch update page.
        If m_blnUpdateLinkAccess = False And Args.LinkName.ToUpper = "UPDATE" Then
            Cancel = True
        End If
        'End of addition by PrashantD on 17 March 2007
    End Sub
    'Addition done by SuchitraP on 24-MAY-2007 for IssueBase BatchUpdate
    Private Sub Display_BatchUpdateQueryOutput()
        Dim dr As IDataReader
        Dim strWhereClause As String
        'Dim strViewID As String
        'strViewID = CType(Session("intViewID"), String)
        'usp_sel_v_tbl_IB_Issue


        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'UnCommented By Chakshuta H on 9th-Aug-2016 Purpose::Qa issue fixing
        Dim strQuerySQL As String = "SELECT * FROM v_tbl_IB_Issue WHERE 1=1 "
        'End Of UnCommented By Chakshuta H on 9th-Aug-2016 Purpose::Qa issue fixing
        'Dim strQuerySQL As String = "usp_sel_v_tbl_IB_Issue"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        If m_lngQueryId = 0 Then
            Exit Sub
        End If

        If m_lngQueryId <> 0 And m_lngProjectId <> 0 Then
            '-----------------------------------------------------------------
            ' 1) Get the where clause to be applied from the selected query
            '-----------------------------------------------------------------
            dr = CommonFunctions.Data.GetDataReader("usp_Sel_tbl_IB_Query " & m_lngQueryId.ToString(), MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(dr) <> "" Then
                If dr.Read() Then
                    strWhereClause = dr.Item("QueryText").ToString()
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(dr)
            If strWhereClause.Trim() <> "" Then
                strWhereClause = " (" & strWhereClause.Trim() & ")" & " AND ProjectID=" & m_lngProjectId.ToString()
            Else
                strWhereClause = " ProjectID =" & m_lngProjectId.ToString()
            End If

            ' append where clause
            If Trim(strWhereClause & "") <> "" Then
                strQuerySQL &= " AND " & strWhereClause
            End If

        End If
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        ' Added by GAneshD on 17 Aug 2009 for batch update [to check statusflow]
        m_StrQueryForBatchUpdate = "SELECT IssueID,ProjectID,[Type],Status,0 FROM v_tbl_IB_Issue WHERE 1=1 "
        'm_StrQueryForBatchUpdate = "usp_sel_v_tbl_IB_Issue_IssueID"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        If Trim(strWhereClause & "") <> "" Then
            m_StrQueryForBatchUpdate &= " AND " & strWhereClause
        End If

        ' End of additon by GaneshD
        Dim alActualColumns As New ArrayList
        Dim aluserfriendlycol As New ArrayList
        Dim strViewSQL As String = ""
        Dim strViewID As String
        strViewID = CType(Session("intViewID"), String)

        If strViewID Is Nothing OrElse strViewID = "" Then
            strViewSQL = "usp_Sel_GetCorporateView_IssueBaseBatchUpdate  NULL"
        Else
            strViewSQL = "usp_Sel_GetCorporateView_IssueBaseBatchUpdate " + strViewID
        End If

        dr = CommonFunction.Data.GetDataReader(strViewSQL, True)

        While dr.Read
            Dim strColCaption As String
            strColCaption = dr(0).ToString
            Select Case strColCaption
                Case "IssueID"
                    alActualColumns.Add("IssueID") : aluserfriendlycol.Add("Issue ID")
                Case "ImportID"
                    alActualColumns.Add("ImportID") : aluserfriendlycol.Add("Import ID")
                Case "ProjectID"
                    alActualColumns.Add("ProjectID") : aluserfriendlycol.Add("Project ID")
                Case "Type"
                    alActualColumns.Add("Type") : aluserfriendlycol.Add("Type")
                Case "SubType"
                    alActualColumns.Add("SubType") : aluserfriendlycol.Add("Sub Type")
                Case "Priority "
                    alActualColumns.Add("Priority") : aluserfriendlycol.Add("Priority")
                Case "Status"
                    alActualColumns.Add("Status") : aluserfriendlycol.Add("Status")
                Case "Severity"
                    alActualColumns.Add("Severity") : aluserfriendlycol.Add("Severity")
                Case "ReportedBy"
                    alActualColumns.Add("ReportedBy") : aluserfriendlycol.Add("Reported By")
                Case "AssignTo"
                    alActualColumns.Add("AssignTo") : aluserfriendlycol.Add("Assign To")
                Case "ReportedDate"
                    alActualColumns.Add("ReportedDate") : aluserfriendlycol.Add("Reported Date")
                Case "CreatedDate"
                    alActualColumns.Add("CreatedDate") : aluserfriendlycol.Add("Created Date")
                Case "CustomerIssueID"
                    alActualColumns.Add("CustomerIssueID") : aluserfriendlycol.Add("Customer IssueID")
                Case "ReportedInVersion"
                    alActualColumns.Add("ReportedInVersion") : aluserfriendlycol.Add("Reported InVersion")
                Case "CorrectedInVersion"
                    alActualColumns.Add("CorrectedInVersion") : aluserfriendlycol.Add("Corrected InVersion")
                Case "Summary"
                    alActualColumns.Add("Summary") : aluserfriendlycol.Add("Summary")
                Case "Description"
                    alActualColumns.Add("Description") : aluserfriendlycol.Add("Description")
                Case "ModuleName"
                    alActualColumns.Add("ModuleName") : aluserfriendlycol.Add("Module Name")
                Case "OS"
                    alActualColumns.Add("OS") : aluserfriendlycol.Add("Operating System")
                Case "Hardware"
                    alActualColumns.Add("Hardware") : aluserfriendlycol.Add("Hardware")
                Case "Kernel"
                    alActualColumns.Add("Kernel") : aluserfriendlycol.Add("Kernel")
                Case "Duration"
                    alActualColumns.Add("Duration") : aluserfriendlycol.Add("Duration")
                Case "Duedate"
                    alActualColumns.Add("Duedate") : aluserfriendlycol.Add("Due date")
                Case "Phase"
                    alActualColumns.Add("Phase") : aluserfriendlycol.Add("Phase")
                Case "FoundInPhase"
                    alActualColumns.Add("FoundInPhase") : aluserfriendlycol.Add("Found InPhase")
                Case "FixedInPhase"
                    alActualColumns.Add("FixedInPhase") : aluserfriendlycol.Add("Fixed InPhase")
                Case "CodedBy"
                    alActualColumns.Add("CodedBy") : aluserfriendlycol.Add("Coded By")
                Case "ShowToCustomer"
                    alActualColumns.Add("ShowToCustomer") : aluserfriendlycol.Add("Show To Customer")
                Case "Keywords"
                    alActualColumns.Add("Keywords") : aluserfriendlycol.Add("Keywords")
                Case "CreatorOrModifier"
                    alActualColumns.Add("CreatorOrModifier") : aluserfriendlycol.Add("Creator Or Modifier")
                Case "ClosedDate"
                    alActualColumns.Add("ClosedDate") : aluserfriendlycol.Add("ClosedDate")
                Case "LoginType"
                    alActualColumns.Add("LoginType") : aluserfriendlycol.Add("Login Type")
                Case "ReviewActionID"
                    alActualColumns.Add("ReviewActionID") : aluserfriendlycol.Add("Review ActionID")
                Case "ChangeRequestID"
                    alActualColumns.Add("ChangeRequestID") : aluserfriendlycol.Add("Change RequestID")
                Case "CRMQueryID"
                    alActualColumns.Add("CRMQueryID") : aluserfriendlycol.Add("CRM QueryID")
                Case "IssueCode"
                    alActualColumns.Add("IssueCode") : aluserfriendlycol.Add("Issue Code")
                Case "ReportedTime"
                    alActualColumns.Add("ReportedTime") : aluserfriendlycol.Add("Reported Time")
                Case "RootCauseID"
                    alActualColumns.Add("RootCauseID") : aluserfriendlycol.Add("Root CauseID")
                Case "DeliverableID"
                    alActualColumns.Add("DeliverableID") : aluserfriendlycol.Add("Deliverable ID")
                Case "EmpIDForTask"
                    alActualColumns.Add("EmpIDForTask") : aluserfriendlycol.Add("EmpID ForTask")
                Case "Complexity"
                    alActualColumns.Add("Complexity") : aluserfriendlycol.Add("Complexity")
                Case "StatusChangeTime"
                    alActualColumns.Add("StatusChangeTime") : aluserfriendlycol.Add("Status Change Time")

                Case "StatusChangeDate"
                    alActualColumns.Add("StatusChangeDate") : aluserfriendlycol.Add("Status Change Date")
                Case "ProductVersionID"
                    alActualColumns.Add("ProductVersionID") : aluserfriendlycol.Add("Product VersionID")
                Case "ComponentID"
                    alActualColumns.Add("ComponentID") : aluserfriendlycol.Add("Component ID")
                Case "CustomerID"
                    alActualColumns.Add("CustomerID") : aluserfriendlycol.Add("Customer ID")

            End Select
        End While
        ' Added by GaneshD on 17 Sep 2009 for clean-up activity
        CommonFunctions.Data.DisposeDataReader(dr)
        ' End of addtion by GaneshD

        Dim arrActualColumns(alActualColumns.Count - 1) As String
        Dim arrUserfriendlyColNames(aluserfriendlycol.Count - 1) As String
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:07/10/15

        alActualColumns.CopyTo(arrActualColumns)
        aluserfriendlycol.CopyTo(arrUserfriendlyColNames)

        With objGrid
            .ActualColumnArray = arrActualColumns
            .UserFriendlyColumnArray = arrUserfriendlyColNames
            .NoOfDataColumns = arrActualColumns.Length
            .DIVID = "divPage"
            .DIVHeight = 280
            .DIVStyle = "overflow:auto"
            '.returnHTML = False
            .returnHTML = True

            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strQuerySQL
            .UseSQL = CBool(CommonFunctions.General.CheckIsNothing(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), "True"))
            .ConnectionString = CommonFunctions.Application.ConnectionString
            '.DrawGrid 
            m_strHtml = objGrid.DrawGrid()
            'Response.Write(strHtml)


        End With
        'End of addition done by SuchitraP on 24-MAY-2007 for IssueBase BatchUpdate

    End Sub

    Private Sub objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles objGrid.DataRowTR_BeforePrint
        m_intNumberOfRecordsOfQuery += 1

    End Sub

    
End Class
