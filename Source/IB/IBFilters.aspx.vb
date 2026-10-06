Public Class IB_Filters
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Protected WithEvents frmIBFilters As System.Web.UI.HtmlControls.HtmlForm

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

#Region " Form Level Variables Declaration "

    Private m_LoginId As Long
    Private m_LoginType As String
    Private m_RoleId As Long
    Private m_RoleLevel As Integer
    'Commented and modified by SuchitraP on 13-July-2007
    'Private m_ProjectId As Long
    Protected m_ProjectId As Long
    'End of comment and modification by SuchitraP on 13-July-2007

    Private m_UserId As Long
    Private m_UserName As String
    Private m_CultureId As Long

    Private m_strOrderByField As String
    Private m_strAscOrDesc As String
    Private m_intQueryId As Long

    Private strReportedFromDate As String = ""
    Private strReportedToDate As String = ""
    Private strDueFromDate As String = ""
    Private strDueToDate As String = ""
    Private strPriority As String = ""
    Private strType As String = ""
    Private strSubType As String = ""
    Private strSeverity As String = ""
    Private strReportedBy As String = ""
    Private strCodedBy As String = ""
    Private strAssignTo As String = ""
    Private strModule As String = ""
    Private strFoundInPhase As String = ""
    Private strFixedInPhase As String = ""
    Private strReportedInVersion As String = ""
    Private strCorrectedInVersion As String = ""
    Private strStatus As String = ""
    Private strProjectFromProjectGroup As String = ""
    Private strSourcePhase As String = ""
    'Addition by SuchitraP on 13-July-2007 for product related filters
    Private strCustomer As String = ""
    Private strProductVersion As String = ""
    Private strComponent As String = ""
    'End of addition by SuchitraP on 13-July-2007

    '****Code Added*******
    'By     :   DipaliS
    'Reason :   Root Cause Feature
    'Date   :   5 July 2004
    'Requirement Number :   IB_PBN_ENT_06
    'Addition Made  :   Added Declaration of variable for Root Cause
    Protected m_strRootCause As String = ""
    '********End Addition*******
    '****Code Added*******
    'By     :   DipaliS
    'Reason :   Deliverable
    'Date   :   19 Aug 2004
    'Requirement Number : 
    'Addition Made  :   Added Declaration of variable for Deliverable
    Protected m_strDeliverable As String = ""
    '********End Addition*******

    'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
    'Code Added By PradipK on 15 Feb 2006
    Private strComplexity As String = ""
    'End Addition By PradipK on 15 Feb 2006

    'Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
    Private IssueListSearchType As Int16
    Private IssueListSearchValue As String = "0"
    'Ended by ShraddhaM

    'Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)
    Protected m_intFlag As String = "0"
    Private strRelease As String = ""
    Private strIteration As String = ""
    Private strUserStory As String = ""
    'End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)


#End Region

#Region " Private Procedures "

    Private Sub GeneratePageCaption()
        '=====================================================================
        ' Function Name         : GeneratePageCaption()	
        ' Purpose               : To generate Page caption for Issues Filter page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 31, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize resource file 
        MyBase.InitializeResources("AppResources.IB_Filters", "AppResources")

        Dim strCaptionFromResource As String = MyBase.GetResourceString("PAGECAPTION")
        'Modified by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        Response.Write(WebPage.Templates.PageCaption.GetPageCaptions(, strCaptionFromResource, "Project: " + strProjectName, , False))
        'End Modification by SandipL

    End Sub 'Generate page caption HTML String

    Private Sub GenerateCommonFieldsSection()
        '=====================================================================
        ' Procedure Name        : GenerateCommonFieldsSection
        ' Purpose               : To generate section for common fields
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 31, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize Resource file 
        MyBase.InitializeResources("AppResources.IB_Filters", "AppResources")

        'Common Fields section 
        Dim cObjCommonFieldsSection As New WebPage.Templates.SectionTitle
        With cObjCommonFieldsSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("COMMONFIELDS"), "DivCommonFields", "ShowHideCommonFields"))
        End With

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        ' Changed Height to 200
        'Div for section title
        HttpContext.Current.Response.Write("<DIV Id='DivCommonFields' Style='Overflow:auto;width=99.9%;HEIGHT:200px;'>")
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Destroy the object
        cObjCommonFieldsSection = Nothing

        'Add Common Fields in the section

        'Dim strCommonFieldsHTML As String
        Response.Write("<TABLE class=clsTable width=99.9% cellspacing=0 cellpadding=0>")
        Response.Write("<TR class=clsTREven>")

        'Project
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("ProjectName"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboProjects As String = CommonFunction.HTMLControls.DrawComboBox("cboProject", "usp_Sel_tbl_IB_GetListOfSharedProjects_ProjectName " + m_ProjectId.ToString, 150, strProjectFromProjectGroup, , True, True)
        Response.Write(strCboProjects)
        Response.Write("</TD>")

        'Type
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("Type"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")

        'Code Commented By DipaliS on 25 June 2004 and added following
        'Dim strCboType As String = CommonFunction.HTMLControls.DrawComboBox("cboType", "Usp_Sel_tbl_IB_Project_Sub_Type_TYPE " + m_ProjectId.ToString, 150, strType, "onchange = cboType_OnChange()", True, True)

        '*********Code Added *********
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   25 June 2004
        'Requirement No.:IB_PBN_ENT_01
        'Changes Made: Added One More parameter RoleID to the SP that fetches the Types    
        Dim strCboType As String = CommonFunction.HTMLControls.DrawComboBox("cboType", "Usp_Sel_tbl_IB_Project_Sub_Type_TYPE " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, strType, "onchange = cboType_OnChange()", True, True)
        '*********End Addition*********

        Response.Write(strCboType)
        Response.Write("</TD>")

        'SubType
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("SubType"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboSubType As String = CommonFunction.HTMLControls.DrawComboBox("cboSubType", "usp_Sel_tbl_IB_Project_Sub_Type_SUB_TYPE " + m_ProjectId.ToString, 150, strSubType, "onchange = cboType_OnChange()", True, True)
        Response.Write(strCboSubType)
        Response.Write("</TD>")

        'Status
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("Status"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")

        'Code Commented By DipaliS on 28 June 2004 and added following
        'Dim strCboStatus As String = CommonFunction.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_IB_Project_Type_Status_Status " + m_ProjectId.ToString, 150, strStatus, "onchange = cboStatus_OnChange()", True, True)

        '*********Code Added *********
        'By     :   DipaliS
        'Reason :   Apply Role Level Security
        'Date   :   28 June 2004
        'Requirement No.:IB_PBN_ENT_01
        'Changes Made: Added One More parameter RoleID to the SP that fetches the Status    
        Dim strCboStatus As String = CommonFunction.HTMLControls.DrawComboBox("cboStatus", "usp_Sel_tbl_IB_Project_Type_Status_Status " + m_ProjectId.ToString + "," + m_RoleId.ToString, 150, strStatus, "onchange = cboStatus_OnChange()", True, True)
        '*********End Addition*********

        Response.Write(strCboStatus)
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("<TR class=clsTREven>")

        'Reported From 
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(MyBase.GetResourceString("REPORTEDFROM"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strdtmReportedFrom As String = CommonFunction.HTMLControls.DrawDateControl("txtReportedFromDate", "txtReportedFromDate", , , strReportedFromDate, , "frmIBFilters", , , , , , , True)
        Response.Write(strdtmReportedFrom)
        Response.Write("</TD>")

        'Reported To
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(MyBase.GetResourceString("REPORTEDTO"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strdtmReportedTo As String = CommonFunction.HTMLControls.DrawDateControl("txtReportedToDate", "txtReportedToDate", , , strReportedToDate, , "frmIBFilters", , , , , , , True)
        Response.Write(strdtmReportedTo)
        Response.Write("</TD>")

        'Due date from 
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(MyBase.GetResourceString("DUEDATEFROM"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strdtmDueDateFrom As String = CommonFunction.HTMLControls.DrawDateControl("txtDueDateFrom", "txtDueDateFrom", , , strDueFromDate, , "frmIBFilters", , , , , , , True)
        Response.Write(strdtmDueDateFrom)
        Response.Write("</TD>")

        'Due date To
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(MyBase.GetResourceString("DUEDATETO"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strdtmDueDateTo As String = CommonFunction.HTMLControls.DrawDateControl("txtDueDateTo", "txtDueDateTo", , , strDueToDate, , "frmIBFilters", , , , , , , True)
        Response.Write(strdtmDueDateTo)
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("<TR class=clsTREven>")

        'Reported By
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("ReportedBy"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboReportedBy As String = CommonFunction.HTMLControls.DrawComboBox("cboReportedBy", "Usp_Sel_IB_ReportedBy " + m_ProjectId.ToString, 150, strReportedBy, , True, True)
        Response.Write(strCboReportedBy)
        Response.Write("</TD>")

        'Coded By
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("CodedByName"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboCodedBy As String = CommonFunction.HTMLControls.DrawComboBox("cboCodedBy", "Usp_Sel_IB_Project_Resources_ProjectGroup " + m_ProjectId.ToString, 150, strCodedBy, , True, True)
        Response.Write(strCboCodedBy)
        Response.Write("</TD>")

        'Responsible Person
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("AssignToName"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboResponsiblePerson As String = CommonFunction.HTMLControls.DrawComboBox("cboResponsiblePerson", "Usp_Sel_IB_Project_Resources_ProjectGroup " + m_ProjectId.ToString, 150, strAssignTo, , True, True)
        Response.Write(strCboResponsiblePerson)
        Response.Write("</TD>")

        'Module Name
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("ModuleName"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        
        ' Added By MahendraV On 11:09 AM 5/21/2007
        ' IssueID : 13360,Modules: Closed Modules are not displayed in the Filters of Issue Base.
        'Dim strCboModuleName As String = CommonFunction.HTMLControls.DrawComboBox("cboModuleName", "Usp_Sel_tbl_PM_Module_ProjectGroup " + m_ProjectId.ToString, 150, strModule, , True, True)
        ' Start_MV_5/21/2007
        Dim strCboModuleName As String = CommonFunction.HTMLControls.DrawComboBox("cboModuleName", "usp_Sel_tbl_PM_Module_Filter_And_Query " + m_ProjectId.ToString, 150, strModule, , True, True)

        ' End_MV_5/21/2007
        Response.Write(strCboModuleName)
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("<TR class=clsTREven>")

        'Priority
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("Priority"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboPriority As String = CommonFunction.HTMLControls.DrawComboBox("cboPriority", "Usp_Sel_tbl_IB_Project_Priorities " + m_ProjectId.ToString, 150, strPriority, , True, True)
        Response.Write(strCboPriority)
        Response.Write("</TD>")

        'Severity
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("Severity"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboSeverity As String = CommonFunction.HTMLControls.DrawComboBox("cboSeverity", "Usp_Sel_tbl_IB_Project_Severity " + m_ProjectId.ToString, 150, strSeverity, , True, True)
        Response.Write(strCboSeverity)
        Response.Write("</TD>")

        'Reported in version
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("ReportedInVersion"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboReportedInVersion As String = CommonFunction.HTMLControls.DrawComboBox("cboReportedInVersion", "Usp_Sel_tbl_IB_Project_Version_ProjectGroup " + m_ProjectId.ToString, 150, strReportedInVersion, , True, True)
        Response.Write(strCboReportedInVersion)
        Response.Write("</TD>")

        'Corrected in version
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("CorrectedInVersion"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboCorrectedInVersion As String = CommonFunction.HTMLControls.DrawComboBox("cboCorrectedInVersion", "Usp_Sel_tbl_IB_Project_Version_ProjectGroup " + m_ProjectId.ToString, 150, strCorrectedInVersion, , True, True)
        Response.Write(strCboCorrectedInVersion)
        Response.Write("</TD>")

        Response.Write("</TR>")
        Response.Write("<TR class=clsTREven>")

        'Source Phase
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("Phase"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboSourcePhase As String = CommonFunction.HTMLControls.DrawComboBox("cboSourcePhase", "Usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString, 150, strSourcePhase, , True, True)
        Response.Write(strCboSourcePhase)
        Response.Write("</TD>")

        'Found in Phase
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("FoundInPhase"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        CommonFunction.HTMLControls.DrawComboBox("cboFoundInPhase", "Usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString, 150, strFoundInPhase, , True)
        Response.Write("</TD>")

        'Fixed in Phase
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("FixedInPhase"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        CommonFunction.HTMLControls.DrawComboBox("cboFixedInPhase", "Usp_Sel_tbl_IB_Project_Phases_ProjectGroup " + m_ProjectId.ToString, 150, strFixedInPhase, , True)
        Response.Write("</TD>")

        'Placeholder
        Response.Write("<TD align=Right style='width:10%'>")
        '*******Code Added*******
        'By     :   DipaliS
        'Reason :   Root Cause Feature
        'Date   :   5 July 2004
        'Requirement No.:IB_PBN_ENT_06
        'Addition   :   Added the Code To Display the Root Cause Combo Box
        Response.Write(GetUserFriendlyName("RootCauseID"))
        '*******End Addition****

        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        '*******Code Added*******
        'By     :   DipaliS
        'Reason :   Root Cause Feature
        'Date   :   5 July 2004
        'Requirement No.:IB_PBN_ENT_06
        'Addition   :   Added the Code To Display the Root Cause Combo Box
        CommonFunction.HTMLControls.DrawComboBox("cboRootCause", "usp_Sel_tbl_IB_Project_RootCause " + m_ProjectId.ToString, 150, m_strRootCause, , True)
        '*******End Addition****
        Response.Write("</TD>")

        '*******Code Added*******
        'By     :   DipaliS
        'Reason :   Deliverable Feature
        'Date   :   19 Aug 2004
        'Addition   :   Added the Code To Display the Deliverable Combo Box
        Response.Write("</TR>")
        Response.Write("<TR class=clsTREven>")
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("DeliverableID"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        CommonFunction.HTMLControls.DrawComboBox("cboDeliverable", "usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString, 150, m_strDeliverable, , True)
        Response.Write("</TD>")

        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
        'Code Added By PradipK on 15 Feb 2006
        'Response.Write("<TD>")
        'Response.Write("</TD>")
        'Response.Write("<TD>")
        'Response.Write("</TD>")
        'Complexity
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(GetUserFriendlyName("Complexity"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strCboComplexity As String = CommonFunction.HTMLControls.DrawComboBox("cboComplexity", "Usp_Sel_tbl_IB_Project_Complexity " + m_ProjectId.ToString, 150, strComplexity, , True, True)
        Response.Write(strCboComplexity)
        Response.Write("</TD>")



        'End Addition By PradipK on 15 Feb 2006

        Response.Write("<TD>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        Response.Write("</TD>")
        Response.Write("<TD>")
        Response.Write("</TD>")
        Response.Write("</TR>")
        '*******End Addition****

        'Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        If m_intFlag = "1" Then
            Response.Write("<TR class=clsTREven>")

            'Release
            Response.Write("<TD align=Right style='width:10%'>")
            Response.Write("Release")
            Response.Write("</TD>")
            Response.Write("<TD align=left style='width:15%'>")
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'CommonFunction.HTMLControls.DrawComboBox("CmbRelease", "SELECT ReleaseName FROM tbl_PM_ScrumRelease WITH(NOLOCK) WHERE ProjectID = " & m_ProjectId.ToString, 160, strRelease, , True, , , False)
            CommonFunction.HTMLControls.DrawComboBox("CmbRelease", "usp_sel_tbl_PM_ScrumRelease_Release " & m_ProjectId.ToString, 160, strRelease, , True, , , False)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

            'Response.Write(strCboSourcePhase)
            Response.Write("</TD>")

            'Iteration
            Response.Write("<TD align=Right style='width:10%'>")
            Response.Write("Iteration")
            Response.Write("</TD>")
            Response.Write("<TD align=left style='width:15%'>")
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'CommonFunction.HTMLControls.DrawComboBox("CmbIteration", "SELECT IterationName FROM tbl_PM_ScrumIteration WITH(NOLOCK) WHERE ProjectID = " & m_ProjectId.ToString, 160, strIteration, , True, , , False)
            CommonFunction.HTMLControls.DrawComboBox("CmbIteration", "usp_sel_tbl_PM_ScrumIteration_IterationName  " & m_ProjectId.ToString, 160, strIteration, , True, , , False)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

            Response.Write("</TD>")

            'User Story
            Response.Write("<TD align=Right style='width:10%'>")
            Response.Write("User Story")
            Response.Write("</TD>")
            Response.Write("<TD align=left style='width:15%'>")
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'CommonFunction.HTMLControls.DrawComboBox("CmbUserStory", "SELECT UserStoryName FROM tbl_PM_ScrumUserStory WITH(NOLOCK) WHERE ReleaseID IS NOT NULL AND  ProjectID = " & m_ProjectId.ToString, 160, strUserStory, , True, , , False)
            CommonFunction.HTMLControls.DrawComboBox("CmbUserStory", "usp_sel_tbl_PM_ScrumUserStory_UserStoryName " & m_ProjectId.ToString, 160, strUserStory, , True, , , False)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            Response.Write("</TD>")

            Response.Write("</TR>")
        End If
        'End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)

        Response.Write("</TABLE>")

        Response.Write("</DIV>")

    End Sub 'Generate and plot Common Fields section

    Private Sub CreateGlobalObject()
        '=====================================================================
        ' Procedure Name        : CreateGlobalObject()	
        ' Purpose               : To get global object and set form level variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 2, 2004
        ' Revisions             :
        '=====================================================================

        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        m_LoginId = objGlobal.LoginID
        m_LoginType = objGlobal.LoginType
        m_RoleId = objGlobal.RoleID
        m_RoleLevel = objGlobal.RoleLevel

        'commented by AniruddhaD on 18 Nov 2005 for providing project combo on issue list page(IssueID:685)
        'm_ProjectId = objGlobal.ProjectID

        'Added by AniruddhaD on 18 Nov 2005 for providing project combo on issue list page(IssueID:685)
        m_ProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("IssueProject").ToString, "0"), Long)
        'Code Added By JyotiG
        'Issue Id: 7193
        'Date : 26-Oct-2006
        'Start
        'Code added by SandipL on 17 Feb 2006 --IssueID 2137 AND 2138 -- Whizsem_whiz2 sp6
        Dim intCorporateRoleLevel As Integer
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = (select PostId from tbl_PM_Employee where EmployeeID=" & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
        'Commented and Added By Chakshuta H on 9th-Aug-2016 Purpose:Qa issue fixing
        'intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_RoleID " & CType(Session("intUserID"), String) & ")", MyBase.UseSQL), Integer)
        intCorporateRoleLevel = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_RoleID " & CType(Session("intUserID"), String), MyBase.UseSQL), Integer)
        'End Of Commented and Added By Chakshuta H on 9th-Aug-2016 Purpose:Qa issue fixing
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        If intCorporateRoleLevel <> 1 And intCorporateRoleLevel <> 2 And m_ProjectId <> 0 Then
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'm_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("Select ISnull(Role,0) from tbl_PM_ProjectEmployeeRole where ProjectID=" & CType(m_ProjectId, String) & " And EmployeeID=" & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
            m_RoleId = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_ProjectEmployeeRole_Role " & CType(m_ProjectId, String) & "," & CType(Session("intUserID"), String), MyBase.UseSQL), "0"), Long)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

            If Not m_RoleId > 0 Then
                m_RoleId = CType(Session("intPostID"), Long)
            End If
            If m_RoleId <> 0 Then
                objGlobal.RoleID = m_RoleId
            End If
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'm_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ISNULL([Level],0) from  tbl_PM_Role where RoleID = " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            m_RoleLevel = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Role_Level " & CType(m_RoleId, String), MyBase.UseSQL)), Integer)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

            If m_RoleLevel <> 0 Then
                objGlobal.RoleLevel = m_RoleLevel
            End If
        End If
        'End addition by SandipL on 17 Feb 2006
        'End of modification By JyotiG
        m_UserId = objGlobal.UserID
        m_UserName = objGlobal.UserName
        m_CultureId = objGlobal.LCID
    End Sub 'Get all session variable values

    Private Sub ApplyFilter()
        '=====================================================================
        ' Procedure Name        : ApplyFilter()	
        ' Purpose               : TO generate filter criteria and apply on Issue List
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 2, 2004
        ' Revisions             :
        '=====================================================================

        Dim strFiltersList As New System.Text.StringBuilder(""), blnInsertAnd As Boolean = False

        'Reported From Date
        If Trim(MyBase.GetFormValue("txtReportedFromDate")) <> "" Then
            Session("ReportedFromDate") = Replace(Trim(MyBase.GetFormValue("txtReportedFromDate")), "+", " ")
            strFiltersList.Append("ReportedDate >= " + Chr(39) + Session("ReportedFromDate").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("ReportedFromDate") = ""
        End If

        'Reported To Date
        If Trim(MyBase.GetFormValue("txtReportedToDate")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("ReportedToDate") = Replace(Trim(MyBase.GetFormValue("txtReportedToDate")), "+", " ")
            strFiltersList.Append("ReportedDate <= " + Chr(39) + Session("ReportedToDate").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("ReportedToDate") = ""
        End If

        'Due From Date
        If Trim(MyBase.GetFormValue("txtDueFromDate")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("DueFromDate") = Replace(Trim(MyBase.GetFormValue("txtDueFromDate")), "+", " ")
            strFiltersList.Append("DueDate >= " + Chr(39) & Session("DueFromDate").ToString & Chr(39))
            blnInsertAnd = True
        Else
            Session("DueFromDate") = ""
        End If

        'Due to Date
        If Trim(MyBase.GetFormValue("txtDueToDate")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("DueToDate") = Replace(Trim(MyBase.GetFormValue("txtDueToDate")), "+", " ")
            strFiltersList.Append("DueDate <= " + Chr(39) + Session("DueToDate").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("DueToDate") = ""
        End If

        'Priority
        If Trim(MyBase.GetFormValue("cboPriority")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("Priority") = Replace(Trim(MyBase.GetFormValue("cboPriority")), "+", " ")
            strFiltersList.Append("Priority = " + Chr(39) + Session("Priority").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("Priority") = ""
        End If

        'Type	To differentiate the Type and the Sub Type while parsing , put extra comments at the start
        If Trim(MyBase.GetFormValue("cboType")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("Type") = Replace(Trim(MyBase.GetFormValue("cboType")), "+", " ")
            strFiltersList.Append("Type = " + Chr(39) + Session("Type").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("Type") = ""
        End If

        'Sub Type 
        If Trim(MyBase.GetFormValue("cboSubType")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("SubType") = Replace(Trim(MyBase.GetFormValue("cboSubType")), "+", " ")
            strFiltersList.Append("SubType = " + Chr(39) + Session("SubType").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("SubType") = ""
        End If

        'Status
        If Trim(MyBase.GetFormValue("cboStatus")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("Status") = Replace(Trim(MyBase.GetFormValue("cboStatus")), "+", " ")
            strFiltersList.Append("Status = " + Chr(39) + Session("Status").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("Status") = ""
        End If

        'Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)
        m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
        If m_intFlag = "1" Then
            'Release
            If Trim(MyBase.GetFormValue("CmbRelease")) <> "" Then
                If blnInsertAnd Then strFiltersList.Append(" AND ")
                Session("Release") = Replace(Trim(MyBase.GetFormValue("CmbRelease")), "+", " ")
                strFiltersList.Append("Release = " + Chr(39) + Session("Release").ToString + Chr(39))
                blnInsertAnd = True
            Else
                Session("Release") = ""
            End If
            'Iteration
            If Trim(MyBase.GetFormValue("CmbIteration")) <> "" Then
                If blnInsertAnd Then strFiltersList.Append(" AND ")
                Session("Iteration") = Replace(Trim(MyBase.GetFormValue("CmbIteration")), "+", " ")
                strFiltersList.Append("Iteration = " + Chr(39) + Session("Iteration").ToString + Chr(39))
                blnInsertAnd = True
            Else
                Session("Iteration") = ""
            End If
            'UserStory
            If Trim(MyBase.GetFormValue("CmbUserStory")) <> "" Then
                If blnInsertAnd Then strFiltersList.Append(" AND ")
                Session("UserStory") = Replace(Trim(MyBase.GetFormValue("CmbUserStory")), "+", " ")
                strFiltersList.Append("UserStory = " + Chr(39) + Session("UserStory").ToString + Chr(39))
                blnInsertAnd = True
            Else
                Session("UserStory") = ""
            End If
        End If
        'End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)


        'Reported By
        If Trim(MyBase.GetFormValue("cboReportedBy")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("ReportedBy") = Replace(Trim(MyBase.GetFormValue("cboReportedBy")), "+", " ")
            strFiltersList.Append("ReportedBy = " + Chr(39) + Session("ReportedBy").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("ReportedBy") = ""
        End If

        'Coded By
        If Trim(MyBase.GetFormValue("cboCodedBy")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("CodedBy") = Replace(Trim(MyBase.GetFormValue("cboCodedBy")), "+", " ")
            strFiltersList.Append("CodedByName = " + Chr(39) + Session("CodedBy").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("CodedBy") = ""
        End If

        'Assign To
        If Trim(MyBase.GetFormValue("cboResponsiblePerson")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("AssignTo") = Replace(Trim(MyBase.GetFormValue("cboResponsiblePerson")), "+", " ")
            strFiltersList.Append("AssignToName = " + Chr(39) + Session("AssignTo").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("AssignTo") = ""
        End If

        'ModuleName
        If Trim(MyBase.GetFormValue("cboModuleName")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("ModuleName") = Replace(Trim(MyBase.GetFormValue("cboModuleName")), "+", " ")
            strFiltersList.Append("ModuleName = " + Chr(39) + Session("ModuleName").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("ModuleName") = ""
        End If

        'Source Phase
        If Trim(MyBase.GetFormValue("cboSourcePhase")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("SourcePhase") = Replace(Trim(MyBase.GetFormValue("cboSourcePhase")), "+", " ")
            strFiltersList.Append("Phase = " + Chr(39) + Session("SourcePhase").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("SourcePhase") = ""
        End If

        'FoundInPhase
        If Trim(MyBase.GetFormValue("cboFoundInPhase")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("FoundInPhase") = Replace(Trim(MyBase.GetFormValue("cboFoundInPhase")), "+", " ")
            strFiltersList.Append("FoundInPhase = " + Chr(39) + Session("FoundInPhase").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("FoundInPhase") = ""
        End If

        'FixedInPhase
        If Trim(MyBase.GetFormValue("cboFixedInPhase")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("FixedInPhase") = Replace(Trim(MyBase.GetFormValue("cboFixedInPhase")), "+", " ")
            strFiltersList.Append("FixedInPhase = " + Chr(39) + Session("FixedInPhase").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("FixedInPhase") = ""
        End If

        'ReportedInVersion
        If Trim(MyBase.GetFormValue("cboReportedInVersion")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("ReportedInVersion") = Replace(Trim(MyBase.GetFormValue("cboReportedInVersion")), "+", " ")
            strFiltersList.Append("ReportedInVersion = " + Chr(39) + Session("ReportedInVersion").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("ReportedInVersion") = ""
        End If

        'CorrectedInVersion
        If Trim(MyBase.GetFormValue("cboCorrectedInVersion")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("CorrectedInVersion") = Replace(Trim(MyBase.GetFormValue("cboCorrectedInVersion")), "+", " ")
            strFiltersList.Append("CorrectedInVersion = " + Chr(39) + Session("CorrectedInVersion").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("CorrectedInVersion") = ""
        End If

        'Severity
        If Trim(MyBase.GetFormValue("cboSeverity")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("Severity") = Replace(Trim(MyBase.GetFormValue("cboSeverity")), "+", " ")
            strFiltersList.Append("Severity = " + Chr(39) + Session("Severity").ToString + Chr(39))

            'Integrated by MrugajaB on 30th APr 2005 for Whiziblesem SP3

            'Added by PrajaktaR on 1st Feb 2005 , for IssueID 11693 of Jopasna (Hot Fix ID 4.0.105) , 
            'When common field 'Severity' & 1 custom field is selected for the filter , then error is occuring 
            '& then issuebase for that particular project is inaccessible for that session for the user .
            ' This Error is occuring because there is no 'AND' After the Severity
            blnInsertAnd = True
            'End of Addition

        Else
            Session("Severity") = ""
        End If

        '*******Code Added*******
        'By     :   DipaliS
        'Reason :   Root Cause Feature
        'Date   :   5 July 2004
        'Requirement No.:IB_PBN_ENT_06
        'Addition   :   Added the Code To Append the query for Root Cause

        'Root Cause
        If Trim(MyBase.GetFormValue("cboRootCause")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            'Get the RootCause for the selected ID
            Dim strRootCause As String = CType(CommonFunctions.Data.GetDataScalar("Exec usp_Sel_tbl_IB_Project_RootCause " + m_ProjectId.ToString + "," + Replace(Trim(MyBase.GetFormValue("cboRootCause")), "+", " ") _
                                        , MyBase.UseSQL), String)

            Session("RootCause") = Replace(Trim(MyBase.GetFormValue("cboRootCause")), "+", " ")
            strFiltersList.Append(" RootCause = " + Chr(39) + CommonFunctions.General.BuildQueryString(strRootCause) + Chr(39))
            blnInsertAnd = True
        Else
            Session("RootCause") = ""
        End If


        '******End Addition******

        '*******Code Added*******
        'By     :   DipaliS
        'Reason :   Deliverable Feature
        'Date   :   19 Aug 2004
        'Addition   :   Added the Code To Append the query for Deliverable

        'Deliverable
        If Trim(MyBase.GetFormValue("cboDeliverable")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            'Get the RootCause for the selected ID
            Dim strDeliverable As String = CType(CommonFunctions.Data.GetDataScalar("Exec usp_sel_tbl_PM_OtherSchedules_ForIB " + m_ProjectId.ToString + "," + Replace(Trim(MyBase.GetFormValue("cboDeliverable")), "+", " ") _
                                        , MyBase.UseSQL), String)

            Session("Deliverable") = Replace(Trim(MyBase.GetFormValue("cboDeliverable")), "+", " ")
            strFiltersList.Append(" Deliverable = " + Chr(39) + CommonFunctions.General.BuildQueryString(strDeliverable) + Chr(39))
            blnInsertAnd = True
        Else
            Session("Deliverable") = ""
        End If


        '******End Addition******
        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
        'Code Added By PradipK on 15 Feb 2006
        If Trim(MyBase.GetFormValue("cboComplexity")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("Complexity") = Replace(Trim(MyBase.GetFormValue("cboComplexity")), "+", " ")
            strFiltersList.Append("Complexity = " + Chr(39) + Session("Complexity").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("Complexity") = ""
        End If
        'End Addition By PradipK on 15 Feb 2006


        'Append Custom Fields to the filter
        Dim strSQL As String = "Exec usp_Sel_tbl_IB_CustomFields_Master_For_Filter " & m_ProjectId
        Dim drCustomFields As IDataReader
        drCustomFields = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Do While drCustomFields.Read
            If Request(drCustomFields("DatabaseFieldName").ToString) <> "" Then
                If blnInsertAnd Then strFiltersList.Append(" AND ")
                strFiltersList.Append(drCustomFields("DatabaseFieldName").ToString + " /* " + drCustomFields("UserGivenCaption").ToString + " */ ='" & CommonFunctions.General.BuildQueryString(Replace(Request(drCustomFields("DatabaseFieldName").ToString), "+", " ")) & "'")
                Session(drCustomFields("DatabaseFieldName").ToString) = CommonFunctions.General.BuildQueryString(Replace(Request(drCustomFields("DatabaseFieldName").ToString), "+", " "))
                blnInsertAnd = True
            Else
                Session(drCustomFields("DatabaseFieldName").ToString) = ""
            End If
        Loop

        'Destroy the object	
        CommonFunctions.Data.DisposeDataReader(drCustomFields)

        'Project
        If Trim(MyBase.GetFormValue("cboProject")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            Session("ProjectFromProjectGroup") = Replace(Trim(MyBase.GetFormValue("cboProject")), "+", " ")
            strFiltersList.Append("ProjectName = " + Chr(39) + Session("ProjectFromProjectGroup").ToString + Chr(39))
            blnInsertAnd = True
        Else
            Session("ProjectFromProjectGroup") = ""
        End If

        'Added by SuchitraP on 13 July 2007 for adding Product releated Filters 
        'Customer
        'Addition done by SuchitraP on 23-July-2007 
        Dim dreader As IDataReader
        Dim sql As String = ""
        Dim blnIsProductdevelopementProject As Boolean
        Dim sqlQuery As String
        Dim str As String
        Dim blnDeliverableLevelCustomer As Boolean

        'End of addition by SuchitraP on 23-July-2007 
        If Trim(MyBase.GetFormValue("CustomerID")) <> "" Then
            'Addition done by SuchitraP on 23-July-2007 
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'sql = "SELECT IsProductdevelopementProject,DeliverableLevelCustomer FROM tbl_PM_Project WHERE ProjectID=" + CType(m_ProjectId, String)
            sql = "usp_sel_tbl_PM_Project_IsProductdevelopementProject " + CType(m_ProjectId, String)
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

            dreader = CommonFunction.Data.GetDataReader(sql, True)
            If dreader.Read Then
                blnIsProductdevelopementProject = CType(CommonFunctions.Data.CheckIsDBNull(dreader("IsProductdevelopementProject"), "0"), Boolean)
                blnDeliverableLevelCustomer = CType(CommonFunctions.Data.CheckIsDBNull(dreader("DeliverableLevelCustomer"), "0"), Boolean)
            End If
            If blnIsProductdevelopementProject = True And Trim(MyBase.GetFormValue("ProductVersionID")) <> "" Then
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'sqlQuery = "SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=" + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ")
                sqlQuery = "usp_sel_tbl_PM_Customer_CustomerNameC " + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ")
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                str = CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.GetDataScalar(sqlQuery, True), String))
                Session("Customer") = str
            ElseIf blnDeliverableLevelCustomer = True And Session("LoginType").ToString <> "C" Then
                If blnInsertAnd Then strFiltersList.Append(" AND ")
                '---------------------------------------------------------------
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'sqlQuery = "SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=" + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ")
                sqlQuery = "usp_sel_tbl_PM_Customer_CustomerNameC " + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ")
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                str = CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.GetDataScalar(sqlQuery, True), String))
                Session("Customer") = str
                strFiltersList.Append("Customer = '" + Session("Customer").ToString + "'")
                blnInsertAnd = True
            ElseIf blnDeliverableLevelCustomer = True And Session("LoginType").ToString = "C" Then
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'sqlQuery = "SELECT CustomerName FROM tbl_PM_Customer WHERE Customer=" + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ")
                sqlQuery = "usp_sel_tbl_PM_Customer_CustomerNameC " + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ")
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                str = CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.GetDataScalar(sqlQuery, True), String))
                Session("Customer") = str
            Else
                Session("Customer") = ""
            End If
        Else
            Session("Customer") = ""
        End If
        CommonFunction.Data.DisposeDataReader(dreader)
        'End of addition by SuchitraP on 23-July-2007 

        'Product
        If Trim(MyBase.GetFormValue("ProductVersionID")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            '-----------------------------------------------------------------------
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'sqlQuery = "SELECT 	[ProductVersion] = Product + ' - ' + ProductVersion FROM v_Tbl_PRD_Customer_ProductVersion WHERE Customer =" + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ") + " And ProductVersionID =" + Replace(Trim(MyBase.GetFormValue("ProductVersionID")), "+", " ")
            sqlQuery = "usp_sel_v_Tbl_PRD_Customer_ProductVersion " + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ") + "," + Replace(Trim(MyBase.GetFormValue("ProductVersionID")), "+", " ")
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            str = CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.GetDataScalar(sqlQuery, True), String))
            Session("ProductVersion") = str
            strFiltersList.Append("ProductVersion = '" + Session("ProductVersion").ToString + "'")
            blnInsertAnd = True
        Else
            Session("ProductVersion") = ""
        End If

        'Component
        If Trim(MyBase.GetFormValue("ComponentID")) <> "" Then
            If blnInsertAnd Then strFiltersList.Append(" AND ")
            '-----------------------------------------------------------------------
            'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            'sqlQuery = "SELECT Component FROM V_Tbl_PRD_Customer_ProductVersionComponents WHERE ProductVersionID =" + Replace(Trim(MyBase.GetFormValue("ProductVersionID")), "+", " ") + " AND CustomerID =" + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ") + " AND ComponentID = " + Replace(Trim(MyBase.GetFormValue("ComponentID")), "+", " ")
            sqlQuery = "usp_sel_V_Tbl_PRD_Customer_ProductVersionComponents " + Replace(Trim(MyBase.GetFormValue("ProductVersionID")), "+", " ") + "," + Replace(Trim(MyBase.GetFormValue("CustomerID")), "+", " ") + "," + Replace(Trim(MyBase.GetFormValue("ComponentID")), "+", " ")
            'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            str = CommonFunction.General.BuildQueryString(CType(CommonFunction.Data.GetDataScalar(sqlQuery, True), String))
            Session("Component") = str
            strFiltersList.Append("Component = '" + Session("Component").ToString + "'")
            blnInsertAnd = True
        Else
            Session("Component") = ""
        End If

        'End of addition by SuchitraP on 13 July 2007

        'Set the session variables 
        'Set the Filter in the session 
        Session("Filters") = strFiltersList.ToString

        'Set the Filter On Query = 1 if the option Filter On Query is applied and Session Filter is not blank
        If Session("Filters").ToString = "" Then
            Session("intFilterOnQuery") = ""
        Else
            Session("intFilterOnQuery") = MyBase.GetFormValue("OptFilter")
        End If

        'Redirect to the main page that will show the Issue List after application of the filter
        'Response.Redirect("IBIssueList.aspx?cboQuery=" & Session("intQueryID").ToString & "&OrderBy=" & m_strOrderByField & "&ASCDESC=" & m_strAscOrDesc) 
    End Sub 'Apply filter

    Private Sub ClearFilter()
        '=====================================================================
        ' Procedure Name        : ClearFilter()	
        ' Purpose               : To clear previously applied filter
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 2, 2004
        ' Revisions             :
        '=====================================================================

        'Clear the filter
        Session("intFilterOnQuery") = ""
        Session("Filters") = ""

        'Go to issue list page
        'Response.Redirect("IBIssueList.aspx?cboQuery=" + Session("intQueryID").ToString + "&OrderBy=" + m_strOrderByField + "&ASCDESC=" + m_strAscOrDesc)

    End Sub 'Clear filter

    Private Sub SetSessionVariables()
        '=====================================================================
        ' Procedure Name        : SetSessionVariables()	
        ' Purpose               : To set session variables
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 2, 2004
        ' Revisions             :
        '=====================================================================

        'By default set the Apply Filter on the Query option selected
        If Session("intFilterOnQuery") Is Nothing Then
            Session("intFilterOnQuery") = ""
        End If

        'If the filter is applied in this session then get the different filter values
        If Session("Filters").ToString <> "" Then

            If Session("ReportedFromDate").ToString <> "" Then strReportedFromDate = Session("ReportedFromDate").ToString
            If Session("ReportedToDate").ToString <> "" Then strReportedToDate = Session("ReportedToDate").ToString
            If Session("DueFromDate").ToString <> "" Then strDueFromDate = Session("DueFromDate").ToString
            If Session("DueToDate").ToString <> "" Then strDueToDate = Session("DueToDate").ToString
            If Session("Priority").ToString <> "" Then strPriority = Replace(Session("Priority").ToString, "''", "'")
            If Session("Type").ToString <> "" Then strType = Replace(Session("Type").ToString, "''", "'")
            If Session("SubType").ToString <> "" Then strSubType = Replace(Session("SubType").ToString, "''", "'")
            If Session("Severity").ToString <> "" Then strSeverity = Replace(Session("Severity").ToString, "''", "'")
            If Session("ReportedBy").ToString <> "" Then strReportedBy = Replace(Session("ReportedBy").ToString, "''", "'")
            If Session("CodedBy").ToString <> "" Then strCodedBy = Session("CodedBy").ToString
            If Session("AssignTo").ToString <> "" Then strAssignTo = Session("AssignTo").ToString
            If Session("ModuleName").ToString <> "" Then strModule = Replace(Session("ModuleName").ToString, "''", "'")
            If Session("FoundInPhase").ToString <> "" Then strFoundInPhase = Replace(Session("FoundInPhase").ToString, "''", "'")
            If Session("FixedInPhase").ToString <> "" Then strFixedInPhase = Replace(Session("FixedInPhase").ToString, "''", "'")
            If Session("ReportedInVersion").ToString <> "" Then strReportedInVersion = Replace(Session("ReportedInVersion").ToString, "''", "'")
            If Session("CorrectedInVersion").ToString <> "" Then strCorrectedInVersion = Replace(Session("CorrectedInVersion").ToString, "''", "'")
            If Session("Status").ToString <> "" Then strStatus = Replace(Session("Status").ToString, "''", "'")

            'Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)
            m_intFlag = CType(CommonFunction.Data.GetDataScalar("Usp_Sel_ProjectTypeInfo " + m_ProjectId.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), String)
            If m_intFlag = "1" Then
                If Session("Release").ToString <> "" Then strRelease = Replace(Session("Release").ToString, "''", "'")
                If Session("Iteration").ToString <> "" Then strIteration = Replace(Session("Iteration").ToString, "''", "'")
                If Session("UserStory").ToString <> "" Then strUserStory = Replace(Session("UserStory").ToString, "''", "'")
            End If

            'End of Added by NitinC on 29 Dec 2011 For WhizibleSEM 11.0-Agile Module (Issue Fix: 57901)

            'Addition done by SuchitraP on 13-July-2007 for Product related filters
            If Session("Customer").ToString <> "" Then
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'strCustomer = CType(CommonFunction.Data.GetDataScalar("SELECT Customer FROM tbl_PM_Customer WHERE CustomerName = '" + Replace(Session("Customer").ToString, "''", "'") + "'", MyBase.UseSQL), String)
                strCustomer = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Customer_Name '" + Replace(Session("Customer").ToString, "''", "'") + "'", MyBase.UseSQL), String)
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            Else
                strCustomer = ""
            End If
            If Session("ProductVersion").ToString <> "" And strCustomer <> "" Then
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'strProductVersion = CType(CommonFunction.Data.GetDataScalar("SELECT ProductVersionID FROM v_Tbl_PRD_Customer_ProductVersion WHERE Customer =" + strCustomer + " AND (Product+' - '+ ProductVersion )='" + Replace(Session("ProductVersion").ToString, "''", "'") + "'", MyBase.UseSQL), String)
                strProductVersion = CType(CommonFunction.Data.GetDataScalar("usp_sel_v_Tbl_PRD_Customer_ProductVersion_ProductVersionID " + strCustomer + ",'" + Replace(Session("ProductVersion").ToString, "''", "'") + "'", MyBase.UseSQL), String)
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            Else
                strProductVersion = ""
            End If
            If Session("Component").ToString <> "" And strProductVersion <> "" And strCustomer <> "" Then
                'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
                'strComponent = CType(CommonFunction.Data.GetDataScalar("SELECT ComponentID FROM V_Tbl_PRD_Customer_ProductVersionComponents WHERE ProductVersionId = " + strProductVersion + " AND CustomerID = " + strCustomer + " AND Component = '" + Replace(Session("Component").ToString, "''", "'") + "'", MyBase.UseSQL), String)
                strComponent = CType(CommonFunction.Data.GetDataScalar("usp_sel_V_Tbl_PRD_Customer_ProductVersionComponents_Component " + strProductVersion + "," + strCustomer + ",'" + Replace(Session("Component").ToString, "''", "'") + "'", MyBase.UseSQL), String)
                'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
            Else
                strComponent = ""
            End If
            'End of addition by SuchitraP on 13-July-2007

            'Consider Projects in the Project Group for the filter
            If Session("ProjectFromProjectGroup").ToString <> "" Then strProjectFromProjectGroup = Replace(Session("ProjectFromProjectGroup").ToString, "''", "'")
            If Session("SourcePhase").ToString <> "" Then strSourcePhase = Replace(Session("SourcePhase").ToString, "''", "'")

            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Root Cause Feature
            'Date   :   5 July 2004
            'Requirement No.:IB_PBN_ENT_06
            'Addition   :   Added the Code To Set variable for Root Cause
            If Session("RootCause").ToString <> "" Then m_strRootCause = Replace(Session("RootCause").ToString, "''", "'")
            '******End Addition******

            '*******Code Added*******
            'By     :   DipaliS
            'Reason :   Deliverable Feature
            'Date   :   19 Aug 2004
            'Addition   :   Added the Code To Set variable for Deliverable
            If Session("Deliverable").ToString <> "" Then m_strDeliverable = Replace(Session("Deliverable").ToString, "''", "'")
            '******End Addition******

        Else
            'Append Custom Fields to the filter
            Dim strSQL As String = "Exec usp_Sel_tbl_IB_CustomFields_Master_For_Filter " & m_ProjectId
            Dim drCustomFields As IDataReader
            drCustomFields = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            Do While (drCustomFields.Read)
                Session(drCustomFields("DatabaseFieldName").ToString) = ""
            Loop

            'Destroy the object	
            CommonFunction.Data.DisposeDataReader(drCustomFields)
        End If

    End Sub 'Set session variables
    'Addition done by SuchitraP on 12-July-2007
    'Purpose:To show Product Fields
    Private Sub GenerateProductFieldSection()
        '=====================================================================
        ' Procedure Name        : GenerateProductFieldSection
        ' Purpose               : To generate section for product fields
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : SuchitraP
        ' Created               : July 12, 2007
        ' Revisions             :
        '=====================================================================

        'Initialize Resource file 
        MyBase.InitializeResources("AppResources.IB_Filters", "AppResources")

        'Product Fields section 
        Dim cObjProductFieldsSection As New WebPage.Templates.SectionTitle
        With cObjProductFieldsSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("PRODUCTFIELDS"), "DivProductFields", "ShowHideProductFields"))
        End With

        'Div for Product title
        Response.Write("<DIV Id='DivProductFields' Style='Overflow:Auto;width=99.9%;HEIGHT:40px;'>")

        'Destroy the object
        cObjProductFieldsSection = Nothing

        'Add Product Fields in the section
        Response.Write("<TABLE class=clsTable width=99.9% cellspacing=0 cellpadding=0>")
        Response.Write("<TR class=clsTREven>")

        'Customer
        Dim dr As IDataReader
        Dim blnSupportProject As Boolean
        Dim strQuery As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strQuery = "SELECT CustomerID,DeliverableLevelCustomer FROM tbl_PM_Project WHERE ProjectID=" + CType(m_ProjectId, String)
        strQuery = "usp_sel_tbl_PM_Project_DeliverableLevelCustomer_CustomerID " + CType(m_ProjectId, String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        dr = CommonFunctions.Data.GetDataReader(strQuery, True)
        If dr.Read Then
            blnSupportProject = CType(CommonFunctions.Data.CheckIsDBNull(dr("DeliverableLevelCustomer"), "0"), Boolean)
            If Session("LoginType").ToString = "C" Then
                strCustomer = CType(dr("CustomerID"), String)
                Response.Write("<input type=hidden name=CustomerID id=CustomerID value=" + strCustomer + " >")
            ElseIf blnSupportProject = True Then
                Response.Write("<TD align=Right style='width:10%'>")
                Response.Write(MyBase.GetResourceString("CUSTOMER"))
                Response.Write("</TD>")
                Response.Write("<TD align=left style='width:15%'>")
                CommonFunction.HTMLControls.DrawComboBox("CustomerID", "usp_Sel_tbl_PM_Customer_ProductExecution", 200, strCustomer, "onchange=Customer_OnChange()", True)

                Response.Write("</TD>")
            Else
                If strCustomer Is Nothing OrElse strCustomer = "" Then
                    strCustomer = CType(dr("CustomerID"), String)
                End If
                Response.Write("<input type=hidden name=CustomerID id=CustomerID value=" + strCustomer + " >")
            End If
        End If
        CommonFunction.Data.DisposeDataReader(dr)

        'Product
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(MyBase.GetResourceString("PRODUCT"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strSql As String = ""


        strSql = "EXEC usp_Sel_tbl_PRD_ProductVersion_CustomerWise " + m_UserId.ToString + " , '" + m_LoginType + "' ," + CType(Session("intLoginID"), String) + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 ")) + ",Null  " + CStr(IIf(strCustomer <> "" And strCustomer <> "0", " , " + strCustomer, " , Null ")) + " , Null "
        CommonFunction.HTMLControls.DrawComboBox("ProductVersionID", strSql, 200, strProductVersion, "onchange=ProductVersion_OnChange()", True)

        Response.Write("</TD>")

        'Module/Component
        Response.Write("<TD align=Right style='width:10%'>")
        Response.Write(MyBase.GetResourceString("COMPONENT"))
        Response.Write("</TD>")
        Response.Write("<TD align=left style='width:15%'>")
        Dim strQuerys As String = ""
        strQuerys = "EXEC USP_SEL_Tbl_PRD_ProductVersion_Component " + CStr(IIf(strProductVersion <> "" And IsNothing(strProductVersion) = False, strProductVersion, " 0 ")) + " , " + CStr(IIf(strCustomer <> "", strCustomer, " Null ")) + " , " + CStr(IIf(m_ProjectId <> 0, m_ProjectId.ToString, " Null ")) + " , " + m_UserId.ToString + " , '" + m_LoginType + "' ," + CType(Session("intLoginID"), String) + CStr(IIf(CommonFunctions.Application.ShowEvenReleaseFromProject, ",1", " ,0 "))
        CommonFunction.HTMLControls.DrawComboBox("ComponentID", strQuerys, 200, strComponent, , True)

        Response.Write("</TD>")
        Response.Write("</TR>")
        Response.Write("</TABLE>")
        Response.Write("</DIV>")

    End Sub
    'End of addition done by SuchitraP on 12-July-2007
    Private Sub GenerateCustomFieldsSection()
        '=====================================================================
        ' Procedure Name        : GenerateCustomFieldsSection
        ' Purpose               : To generate section for custom fields
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 31, 2004
        ' Revisions             :
        '=====================================================================

        'Initialize Resource file 
        MyBase.InitializeResources("AppResources.IB_Filters", "AppResources")

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
        'strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString
        strSQLForCustom = "Exec usp_sel_tbl_IB_RoleCustomFieldSecurity " + m_ProjectId.ToString + "," + m_RoleId.ToString + ",NULL," + m_LoginType.ToString
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

        'Common Fields section 
        Dim cObjCustomFieldsSection As New WebPage.Templates.SectionTitle
        With cObjCustomFieldsSection
            Response.Write(.GetSectionTitle(MyBase.GetResourceString("CUSTOMFIELDS"), "DivCustomFields", "ShowHideCustomFields"))
        End With

        'Div for section title
        HttpContext.Current.Response.Write("<DIV Id='DivCustomFields' Style='Overflow:Auto;width=100%;HEIGHT:175px;'>")

        'Destroy the object
        cObjCustomFieldsSection = Nothing

        'add custom fields in the section
        Response.Write("<TABLE class=clsTable width=99.9% cellspacing=0 cellpadding=0>")
        Response.Write("<TR class=clsTREven>")

        'Get the Max Row Number and Column Number
        Dim strSQL As String, intMaxRow, intMaxCol As Integer
        Dim drCustomFields As IDataReader
        strSQL = "EXEC usp_Sel_IB_CustomFields_Max_Positon " & m_ProjectId & ", 1"
        drCustomFields = CommonFunction.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drCustomFields.Read Then
            intMaxRow = CType(drCustomFields("RowNumber"), Integer)
            intMaxCol = CType(drCustomFields("ColumnNumber"), Integer)
        End If

        'destroy datareader
        CommonFunction.Data.DisposeDataReader(drCustomFields)

        strSQL = "Exec usp_Sel_tbl_IB_CustomFields_Master_For_Filter " & m_ProjectId
        drCustomFields = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If Not drCustomFields.Read Then 'If datareader is empty
            'Display message : No custom fields have been defined 
            Response.Write("<TD><B>" + MyBase.GetResourceString("NOCUSTOMFIELDS") + "</B></TD></TR></TABLE>")
        Else
            'Draw all custom fields in the section
            Dim intRow, intCol, intCurrentCellNumber, intNextCellNumber As Integer
            Dim intWidth, intMaxlength As Integer, strStyle As String
            Do
                For intRow = 1 To intMaxRow
                    Response.Write("<TR class=clsTREven>")
                    For intCol = 1 To intMaxCol
                        intCurrentCellNumber = (intRow * intMaxCol) + intCol
                        intNextCellNumber = (CType(drCustomFields("RowNumber"), Integer) * intMaxCol) + CType(drCustomFields("ColumnNumber"), Integer)
                        If intCurrentCellNumber < intNextCellNumber Then
                            Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                        ElseIf intCurrentCellNumber = intNextCellNumber Then
                            'Get the Control Width if any						
                            intWidth = CType(CommonFunction.Data.CheckIsDBNull(drCustomFields("ControlWidth"), "100"), Integer)

                            strStyle = ""

                            'Get the Control Max length if any
                            intMaxlength = CType(CommonFunction.Data.CheckIsDBNull(drCustomFields("MaxLength"), "100"), Integer)

                            'Control Label
                            Response.Write("<TD align=right>" + drCustomFields("UserGivenCaption").ToString & "</TD>")

                            'Control Data
                            Response.Write("<TD>")


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
                                                CType(CommonFunction.General.CheckIsNothing(drCustomFields("UniqueId")), String).ToLower.Trim Then
                                        blnShowControl = True
                                    End If

                                    intCounter = intCounter + 1

                                End While

                            Else
                                'Commented By DipaliS To Ensure that the Custom Field will not be visible unless and untill access is set explicitly for it.
                                'blnShowControl = True
                            End If

                            'If control is not to be shown show it as "Not Applicable
                            If blnShowControl = True Then

                                '*****End Addition*******


                                If InStr(1, UCase(drCustomFields("DatabaseFieldName").ToString), "CUSTOMFIELDTEXT", CompareMethod.Binary) <> 0 Then
                                    'Text Box


                                    'Commented and added by Yogesh J for HTML encoding Date:07/10/15
                                    Response.Write(CommonFunction.HTMLControls.DrawTextBox(drCustomFields("DatabaseFieldName").ToString, drCustomFields("DatabaseFieldName").ToString, , intWidth, intMaxlength, Session(drCustomFields("DatabaseFieldName").ToString).ToString, , , , , , , , False, EnableHTMLEncode:=True))
                                    'ended by Yogesh J for HTML encoding Date:07/10/15
                                ElseIf InStr(1, UCase(drCustomFields("DatabaseFieldName").ToString), "CUSTOMFIELDDATE", CompareMethod.Binary) <> 0 Then
                                    'date field
                                    Response.Write(CommonFunction.HTMLControls.DrawDateControl(drCustomFields("DatabaseFieldName").ToString, drCustomFields("DatabaseFieldName").ToString, , , Session(drCustomFields("DatabaseFieldName").ToString).ToString, , "frmIBFilters", , , , , , , False))
                                ElseIf InStr(1, UCase(drCustomFields("DatabaseFieldName").ToString), "CUSTOMFIELDCOMBO", CompareMethod.Binary) <> 0 Then
                                    'Combo
                                    strSQL = "EXEC Usp_Sel_tbl_IB_CustomFields_Details '" & drCustomFields("DatabaseFieldName").ToString + "'," + m_ProjectId.ToString
                                    Dim strcomboname As String = drCustomFields("DatabaseFieldName").ToString
                                    Response.Write(CommonFunction.HTMLControls.DrawComboBox(strcomboname, strSQL, intWidth, Session(drCustomFields("DatabaseFieldName").ToString).ToString, , True, False))
                                End If
                                '****Code Added*******
                                'By     :   DipaliS
                                'Reason :   Apply Role Level Security to custom fields
                                'Date   :   6 July 2004
                                'Requirement No.:IB_PBN_ENT_05
                                'Addition   :  End of condition added above
                            Else
                                Response.Write("( " + MyBase.GetResourceString("NOTAPPLICABLE") + " )")
                            End If

                            '*******End Addition
                            Response.Write("</TD>")

                            If Not drCustomFields.Read() Then
                                Dim i As Integer
                                For i = intCol To intMaxCol - 1
                                    Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        Else
                            Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                            If Not drCustomFields.Read() Then
                                Dim i As Integer
                                For i = intCol To intMaxCol - 1
                                    Response.Write("<td valign=top align=right colspan=2>&nbsp;</td>")
                                Next
                                Exit For
                            End If
                        End If
                    Next
                    Response.Flush()
                    Response.Write("</TR>")
                Next
            Loop While drCustomFields.Read
        End If

        Response.Write("</TABLE>")

        Response.Write("</DIV>")

        CommonFunction.Data.DisposeDataReader(drCustomFields)

    End Sub 'Generate and plot Custom fields section

#End Region

#Region " Public Procedures "

    Public Sub PlotPageHeadTag()
        '=====================================================================
        ' Procedure Name         : PlotPageHeadTag()	
        ' Purpose               : To plot page head tag 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 28, 2004
        ' Revisions             :
        '=====================================================================
        Call CommonFunction.General.PlotPageHeadTag("Issues - Filters")
    End Sub 'Plot Page Head tag

    Public Sub BuildPage()
        '=====================================================================
        ' Procedure Name        : BuildPage()	
        ' Purpose               : To build Issues Filter page
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Feb 2, 2004
        ' Revisions             :
        '=====================================================================

        Call CreateGlobalObject()

        Dim strMenu As String

        'Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
        If Not Request.QueryString("IssueListSearchType") Is Nothing And Request.QueryString("IssueListSearchType") <> "" Then
            IssueListSearchType = CType(Request.QueryString("IssueListSearchType"), Int16)
        Else
            IssueListSearchType = CType(Request.Form("IssueListSearchType"), Int16)
        End If

        If Not Request.QueryString("IssueListSearchValue") Is Nothing And Request.QueryString("IssueListSearchValue") <> "" Then
            IssueListSearchValue = CType(Request.QueryString("IssueListSearchValue"), String)
        Else
            IssueListSearchValue = CType(Request.Form("IssueListSearchValue"), String)
        End If
        'Ended by ShraddhaM

        m_strOrderByField = Request("OrderBy")
        m_strAscOrDesc = Request("ASCDESC")

        Select Case UCase(Request("Operation")).Trim
            Case "APPLY_FILTER"
                Call ApplyFilter()
            Case "CLEAR_FILTER"
                Call ClearFilter()
        End Select

        Call SetSessionVariables()

        'Generate Manu
        strMenu = GenerateMenu()

        'Write menu (Top of page)
        Response.Write(strMenu)

        Response.Write("<BR>")

        'Generate page caption
        GeneratePageCaption()
        Response.Write("<BR>")

        'Main div 
        Response.Write("<DIV id='DivMain' style='Overflow:auto;width:100%;Height:500px'>")

        Dim blnExcludingQuerySelected As Boolean = False

        'Radio buttons (Including query and excluding query)
        If Session("intFilterOnQuery").ToString = "0" Or Session("intFilterOnQuery").ToString = "" Then
            blnExcludingQuerySelected = True
        End If

        Dim optExcludingQuery As String = CommonFunction.HTMLControls.DrawOptionButton("OptFilter", "OptFilter", , blnExcludingQuerySelected, "0", , "", True) + MyBase.GetResourceString("FILTEREXCLUDINGQUERY")
        Dim optOnQuery As String = CommonFunction.HTMLControls.DrawOptionButton("OptFilter", "OptFilter", , Not blnExcludingQuerySelected, "1", , "", True) + MyBase.GetResourceString("FILTERONQUERY")

        Dim strHTML As String = "<TABLE class=clstable width=99.9%><TR class=clsTREven align=center><TD>" + optExcludingQuery + "&nbsp;&nbsp;" + optOnQuery + "</TD></TR></TABLE>"
        Response.Write(strHTML)
        Response.Write("<BR>")

        'Section for Common Fields
        Call GenerateCommonFieldsSection()

        Response.Write("<BR>")

        'Addition done by SuchitraP on 12-July-2007
        'Purpose:To show Product fields
        Dim strSQL As String = ""
        Dim dreader As IDataReader
        Dim blnSupportProject As Boolean
        Dim blnProdEnggProject As Boolean
        Dim blnIsProductExecutionProject As Boolean
        If CommonFunction.Application.EnableProductExecution = True Then
            strSQL = "usp_Sel_IsProductExecutionProject_DeliverableLevelCustomer_IsProductDevelopementProject " + CType(m_ProjectId, String)
            dreader = CommonFunctions.Data.GetDataReader(strSQL, True)

            If dreader.Read Then
                blnIsProductExecutionProject = CType(CommonFunctions.Data.CheckIsDBNull(dreader("IsProductExecutionProject"), "0"), Boolean)
                blnSupportProject = CType(CommonFunctions.Data.CheckIsDBNull(dreader("DeliverableLevelCustomer"), "0"), Boolean)
                blnProdEnggProject = CType(CommonFunctions.Data.CheckIsDBNull(dreader("IsProductDevelopementProject"), "0"), Boolean)
                If blnIsProductExecutionProject = True Then
                   


                    If (blnSupportProject = True) OrElse (blnProdEnggProject = True) Then
                        Call GenerateProductFieldSection()
                        Response.Write("<BR>")
                    End If

                End If
            End If
        End If

        CommonFunctions.Data.DisposeDataReader(dreader)

        'End of addition done by SuchitraP on 12-July-2007

        'Section for Custome Fields
        Call GenerateCustomFieldsSection()


        'Added by ShraddhaM on 23,Jul 2009 for search fuctionality of IssueList page
        Response.Write("<input type=hidden name='IssueListSearchType' id='IssueListSearchType' value='" + IssueListSearchType.ToString() + "' >")
        Response.Write("<input type=hidden name='IssueListSearchValue' id='IssueListSearchValue' value='" + IssueListSearchValue + "' >")
        'Ended by ShraddhaM

        Response.Write("</DIV>")

        'Write menu (Bottom of page)
        Response.Write(strMenu)

    End Sub 'Main procedure to build the page

    Public Sub New()
        '=====================================================================
        ' Procedure Name        : New()	
        ' Purpose               : Constructor for the page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 31, 2004
        ' Revisions             :
        '=====================================================================

        'Apply security
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016

        'Initialize standard menu resource file 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub 'Constructor for page

#End Region

#Region " Private Functions "
    Private Function GenerateMenu() As String
        '=====================================================================
        ' Function Name         : GenerateMenu()	
        ' Purpose               : To generate Menu for the Issue Filters page
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 31, 2004
        ' Revisions             :
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips

        'Apply Filter
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_APPLYFILTER"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_APPLYFILTER_TOOLTIP"))
        ArrClientSideFunctionsList.Add("ApplyFilter_OnClick()")

        'Clear Filter
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_IB_CLEARFILTER"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_IB_CLEARFILTER_TOOLTIP"))
        ArrClientSideFunctionsList.Add("ClearFilter_OnClick()")

        'Back
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_CLOSE"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"))
        ArrClientSideFunctionsList.Add("Close_OnClick()")

        'Help 
        ArrMenuCaptionsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrMenuToolTipsList.Add(MyBase.GetResourceString("MENU_HELP"))
        ArrClientSideFunctionsList.Add("Help_OnClick('IB_FILTER')")

        'Convert arraylist to array - Menu captions
        Dim ArrMenuCaptions(ArrMenuCaptionsList.Count - 1) As String
        ArrMenuCaptionsList.ToArray.CopyTo(ArrMenuCaptions, 0)
        ArrMenuCaptionsList = Nothing

        'Convert arraylist to array - Client side functions
        Dim ArrClientSideFunctions(ArrClientSideFunctionsList.Count - 1) As String
        ArrClientSideFunctionsList.ToArray.CopyTo(ArrClientSideFunctions, 0)
        ArrClientSideFunctionsList = Nothing

        'Convert arraylist to array - Menu tooltips
        Dim ArrMenuToolTips(ArrMenuToolTipsList.Count - 1) As String
        ArrMenuToolTipsList.ToArray.CopyTo(ArrMenuToolTips, 0)
        ArrMenuToolTipsList = Nothing

        'Generate menu string and return
        Return WebPage.Templates.StaticMenu.DrawMenu(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)

    End Function 'Menu generation




    Private Function GetUserFriendlyName(ByVal strFieldName As String) As String
        '=====================================================================
        ' Procedure Name        : GetUserFriendlyName()	
        ' Purpose               : To get user friendly field name for given field
        ' Description           : same as above
        ' Parameters Passed     : strFieldName - Actual Field name
        ' Returns               : user friendly field name (string)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : AniruddhaD
        ' Created               : Jan 31, 2004
        ' Revisions             :
        '=====================================================================
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Dim strSQL As String

        'If CommonEngines.HashTables.Culture.GetDefaultCulture.LCID = m_CultureId Then
        '    strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'"
        'Else
        '    strSQL = "EXEC usp_Sel_tbl_IB_DataDictionary_Culture '" + Trim(strFieldName) + "'," + m_CultureId.ToString
        'End If

        Dim drUserFriendlyName As IDataReader

        drUserFriendlyName = CommonFunction.Data.GetDataReader("EXEC usp_Sel_tbl_IB_DataDictionary '" + Trim(strFieldName) + "'", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drUserFriendlyName.Read Then
            'Return drUserFriendlyName("USerFriendlyName").ToString
            GetUserFriendlyName = drUserFriendlyName("USerFriendlyName").ToString
        Else
            'Return "Not Specified"
            GetUserFriendlyName = "Not Specified"
        End If
        CommonFunctions.Data.DisposeDataReader(drUserFriendlyName)
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

    End Function 'Get user friendly name for field

#End Region


    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub
End Class
