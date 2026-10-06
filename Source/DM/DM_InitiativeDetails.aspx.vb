Public Class DM_InitiativeDetails
    Inherits WebPages.Template.WhizTemplate

    Private m_intWFInstanceID As Integer
    Private m_intTagID As Integer
    Private m_intuniqueID As Integer
    Protected WithEvents m_objMenu As New WebPage.Templates.StaticMenu
    Protected WithEvents m_objGrid As New WebPage.Templates.GenericGrid
    '-- Added By PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition
    Protected m_strFrom As String = ""
    Protected m_intNatureofDemandID As Integer
    Protected m_intNatureofdemandStageID As Integer
    Protected strHtml As New System.Text.StringBuilder
    ''Added By Nilesh g on 20/1/2016 for URL security
    Protected m_StrTokenStagStatus As String = ""
    Protected ForWorkflowFrom As String = ""

    '-- End Addition PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition
    ''Added by Dhanashri S on 11 Aug 2016 2016 Pktoken 
    Protected m_blnValidate As Boolean = "True"
    Protected m_intEmployeeID As String
    ''End of Addition by Dhanashri S on 11 Aug 2016


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
        'Put user code to initialize the page here
        InitialiseVariables()


        ''Added By Nilesh g on 20/1/2016 for URL security
        'If (m_StrTokenStagStatus <> "") Then
        '    If (ForWorkflowFrom = "WF") Then
        '        If (m_StrTokenStagStatus = "" Or CommonFunctions.Security.Token.ValidateToken(CType(m_intWFInstanceID, String) + "0" + "0", m_StrTokenStagStatus) = False) Then
        '            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        '        End If

        '    ElseIf (m_StrTokenStagStatus <> "" And CommonFunctions.Security.Token.ValidateToken(CType(m_intWFInstanceID, String) + CType(m_intTagID, String) + CType(m_intuniqueID, String) + "0" + "0", m_StrTokenStagStatus) = False) Then
        '        Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Multiple Tasks", 0, 0, "Query ID", "0")
        '        'Token is Invalid now redirect to the Invalid Access Page
        '        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

        '    End If
        'End If
        ''endded By Nilesh g on 20/1/2016 for URL security

        ''Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation


        If (ForWorkflowFrom = "WF") Then
            If (((m_StrTokenStagStatus = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_intWFInstanceID, String) + CType(m_intEmployeeID, String) + "0" + "0", m_StrTokenStagStatus) = False)) Then
                m_blnValidate = "False"
            End If
        ElseIf (ForWorkflowFrom = "flag") Then
            'Added By tejal Deshmukh on 13/8/2016 purpose pk token validate
            If (((m_StrTokenStagStatus = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_intuniqueID, String) + CType(m_intEmployeeID, String) + "0" + "0" + CType(m_intTagID, String) + CType(m_intWFInstanceID, String), m_StrTokenStagStatus) = False)) Then
                'End Of Addition by tejal Deshmukh on 13/8/2016 purpose pk token validate
                ' If (((m_StrTokenStagStatus = "") And (HttpContext.Current.Session("intUserID").ToString <> "0")) Or (CommonFunctions.Security.Token.ValidateToken(CType(m_intuniqueID, String) + CType(m_intEmployeeID, String) + CType(m_intTagID, String) + "0" + "0" + CType(m_intWFInstanceID, String), m_StrTokenStagStatus) = False)) Then
                m_blnValidate = "False"
            End If
        End If


        If (m_blnValidate = "False") Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If


        ''End of Addition by Dhanashri S on 11 Aug 2016

        MyBase.InitializeResources("AppResources.DM_InitiativeDetails", "AppResources")
    End Sub
    Protected Sub PageInit()
        '=====================================================================
        ' Procedure Name        : PageInit()
        ' Purpose               : To generate the UI and is called from
        '                         the .aspx page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : 11 Jun 2008
        ' Revisions             :
        '=====================================================================

        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        Draw_Page()
    End Sub
    Protected Sub InitialiseVariables()
        '=====================================================================
        ' Procedure Name        : InitialiseVariables()
        ' Purpose               : To Initialise variables
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : 11 Jun 2008
        ' Revisions             :
        '=====================================================================
        m_intWFInstanceID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("WFInstanceID"), 0), Integer)
        m_intTagID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("TagID"), 0), Integer)
        m_intEmployeeID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("EmployeeID"), 0), Integer)

        'Added by GokulP on 08 Sept 2009 for IssueID 33068
        Dim drTagID As IDataReader
        If m_intTagID = 0 And m_intWFInstanceID <> 0 Then
            drTagID = CommonFunction.Data.GetDataReader("SELECT ISNULL(TagID,0) AS TagID FROM tbl_IM_WorkflowInstance WITH (NOLOCK) WHERE WorkflowInstanceID = " + m_intWFInstanceID.ToString, True)
            If drTagID.Read Then
                m_intTagID = CType(CommonFunction.Data.CheckIsDBNull(drTagID("TagID"), 0), Integer)
            End If
            CommonFunction.Data.DisposeDataReader(drTagID)
        End If
        'Added by GokulP on 08 Sept 2009 for IssueID 33068

        m_intuniqueID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("UniqueID"), 0), Integer)
        m_strFrom = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Fromwhere"), "").ToString
        m_intNatureofDemandID = CType(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureofDemandID"), 0), Integer)
        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        ''Added By Nilesh g on 20/1/2016 for URL security
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_StrTokenStagStatus = Request.QueryString("PKToken")
        End If
        If Trim(Request.QueryString("ForWorkflowFrom") & "") <> "" Then
            ForWorkflowFrom = Request.QueryString("ForWorkflowFrom")
        End If


        ''endded By Nilesh g on 20/1/2016 for URL security

    End Sub
    Protected Sub Draw_Page()
        '=====================================================================
        ' Procedure Name        : Draw_Page()
        ' Purpose               : To Draw UI of Page
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : 11 Jun 2008
        ' Revisions             :
        '=====================================================================
        Dim drInitiativeDetails As IDataReader
        Dim blnIsFirst As Boolean = True
        Dim intRowCount As Integer
        Dim intOrderNumber As Integer
        'Dim strHtml As New System.Text.StringBuilder
        Dim strStartDate As String = ""
        Dim strPlannedEndDate As String = ""
        Dim strProjectedEndDate As String = ""
        Dim strNatureofDemand As String = ""
        Dim strRequestStage As String = ""
        Dim strFillColor As String = "ClearedStage_R.gif" '"PaleGreen"
        Dim strInstanceID As String = ""

        Dim blnIsCurrentStage As Boolean
        Dim blnIsCurrentStagePassed As Boolean = False
        Dim strMenu As String = ""
        Dim strApproverList As String = ""
        Dim strWidth As String = ""
        Dim intIsDelayed As Integer
        Dim strRequestStageID As String = ""
        Dim strOrganizationUnit As String = ""
        Dim strBusinessGroup As String = ""
        Dim strProjectType As String = ""
        Dim strProjectName As String = ""
        Dim strTitle As String = ""
        Dim StartDate As String = ""
        Dim EndDate As String = ""
        Dim strDeliverableType As String = ""
        Dim strChangeCategory As String = ""
        Dim strChangePriority As String = ""
        Dim strClass As String = ""
        Dim drEntityDetails As IDataReader
        Dim strcaption As String = ""

        strClass = "border-style: none; height: 55px; vertical-align: middle; text-align: center; "
        strClass += "font-family: Verdana,Arial; font-size: 8pt; padding: 0px 15px 0px 15px; "
        strClass += "background-image: url(../../Images/cssImages/Workflow/WF_SubmitStageBG.gif); background-repeat: no-repeat;"

        drEntityDetails = CommonFunction.Data.GetDataReader("usp_sel_EntityDetails_GenericWorkflowStatus " + m_intWFInstanceID.ToString + "," + m_intuniqueID.ToString + "," + m_intTagID.ToString, True)
        If drEntityDetails.Read() Then

            Select Case m_intTagID.ToString
                Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ExpectedStartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ExpectedEndDate"), "")
                    ' Modified by GaneshD on 27 Aug 2009 for Whziblesem issueid-32686
                    ' strOrganizationUnit = CommonFunction.Data.CheckIsDBNull(drEntityDetails("Location"), "")
                    strBusinessGroup = CommonFunction.Data.CheckIsDBNull(drEntityDetails("BusinessGroup"), "")
                    ' End of modification by Ganeshd
                    strProjectType = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectType"), "")
                    strcaption = CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("CAP_PROJ_DTLS"), "").ToString

                Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("Milestone"), "")
                    strcaption = CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("CAP_MILE_DTLS"), "").ToString

                Case CommonFunction.Constants.APP_TAG_MODULES

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ModuleName"), "")
                    strcaption = CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("CAP_MOD_DTLS"), "").ToString

                Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangeRequestDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangeRequestSummary"), "")
                    strChangeCategory = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangeCategory"), "")
                    strChangePriority = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ChangePriority"), "")
                    strcaption = CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("CAP_CR_DTLS"), "").ToString

                    'Commented & Added by GokulP on 08 Sept 2009 for IssueID : 33068
                    'Case CommonFunction.Constants.APP_TAG_DELIVERABLES
                Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                    'End of Comment & Addition by GokulP on 08 Sept 2009 for IssueID : 33068

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("Title"), "")
                    strDeliverableType = CommonFunction.Data.CheckIsDBNull(drEntityDetails("DeliverableType"), "")
                    strcaption = CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("CAP_DEL_DTLS"), "").ToString

                Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS

                    strProjectName = CommonFunction.Data.CheckIsDBNull(drEntityDetails("ProjectName"), "")
                    StartDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("StartDate"), "")
                    EndDate = CommonFunction.Data.CheckIsDBNull(drEntityDetails("EndDate"), "")
                    strTitle = CommonFunction.Data.CheckIsDBNull(drEntityDetails("SubProjectName"), "")
                    strcaption = CommonFunction.General.CheckIsNothing(MyBase.GetResourceString("CAP_SUBP_DTLS"), "").ToString

            End Select
        End If

        'Added By PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition
        If m_strFrom.ToUpper.ToString = "WORKFLOW" Then
            drInitiativeDetails = CommonFunction.Data.GetDataReader("usp_sel_WorkflowDetails_forGrahicalUI " + m_intNatureofDemandID.ToString, True)
        Else
            'End addition PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition
            drInitiativeDetails = CommonFunction.Data.GetDataReader("usp_Get_WorkflowEntity_Details " + m_intWFInstanceID.ToString + "," + m_intuniqueID.ToString + "," + m_intTagID.ToString, True)
        End If


        'drInitiativeDetails = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataReader("usp_Get_WorkflowEntity_Details " + m_intWFInstanceID.ToString + "," + m_intuniqueID.ToString + "," + m_intTagID.ToString, True), "")

        strMenu = DrawMenu()

        Response.Write(strMenu)

        'Commented and Added By Bharat T on 15th-Oct-2015
        'strHtml.Append("<div ID=PageDiv style='overflow:auto;width:100%;height:200px'>")
        strHtml.Append("<div ID=PageDiv style='width:100%;height:544px'>")
        'End of Commented and Added By Bharat T on 15th-Oct-2015
        strHtml.Append("<BR><TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>" + vbCrLf)
        strHtml.Append("<TR class=clsTRPageCaption><TD align=Left>" + strcaption.ToString + "</TD></TR></TABLE><BR>" + vbCrLf)

        intRowCount = drInitiativeDetails.GetSchemaTable.Rows.Count
        strWidth = (100 / intRowCount)

        While drInitiativeDetails.Read

            strRequestStage = CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("RequestStage"), "")
            strRequestStageID = CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("RequestStageID"), "")
            blnIsCurrentStage = CType(CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("IsCurrentStage"), False), Boolean)
            intIsDelayed = CType(CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("IsDelayed"), 0), Integer)

            strApproverList = CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("ApproverList"), "")
            If strApproverList <> "" Then
                strApproverList = strApproverList.Substring(0, strApproverList.Length - 2)
            End If

            If m_strFrom.ToUpper.ToString = "WORKFLOW" Then
                m_intNatureofdemandStageID = CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("NatureofDemandStageID"), "")
            End If


            intOrderNumber = CType(CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("OrderNo"), 0), Integer)

            If blnIsFirst Then
                strNatureofDemand = CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("NatureofDemand"), "")
                strInstanceID = CommonFunctions.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drInitiativeDetails("InstanceID"), ""), "")

                If strInstanceID = "" Then
                    strFillColor = "Stage_Not_Reached_R.gif"
                End If

                If m_strFrom.ToUpper.ToString <> "WORKFLOW" Then

                    Select Case m_intTagID.ToString
                        Case CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING
                            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strProjectName)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_LOCATION").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strBusinessGroup)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_STARTDATE").ToString + "</B></td><td align=left> &nbsp;")
                            strHtml.Append(StartDate)
                            strHtml.Append("</td>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_ENDDATE").ToString + "</B></td><td align=left > &nbsp;")
                            strHtml.Append(EndDate)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            ' Modified by GaneshD on 27 Aug 2009 for Whiziblesem 9.0 Issue ID-32686
                            'strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_PROJTYPE").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append("<td align='right'><B>Practice</B></td><td align=left colspan=3> &nbsp;")
                            ' End of modification by GaneshD on 27 Aug 2009
                            strHtml.Append(strProjectType)
                            strHtml.Append("</td>")
                            strHtml.Append("</TR></TABLE>")

                        Case CommonFunction.Constants.APP_TAG_MILESTONE_DETAILS

                            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_MIL_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strTitle)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strProjectName)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_MIL_STARTDATE").ToString + "</B></td><td align=left> &nbsp;")
                            strHtml.Append(StartDate)
                            strHtml.Append("</td>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_MIL_ENDDATE").ToString + "</B></td><td align=left > &nbsp;")
                            strHtml.Append(EndDate)
                            strHtml.Append("</td>")
                            strHtml.Append("</TR></TABLE>")
                        Case CommonFunction.Constants.APP_TAG_MODULES
                            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_MOD_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strTitle)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strProjectName)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_MOD_STARTDATE").ToString + "</B></td><td align=left> &nbsp;")
                            strHtml.Append(StartDate)
                            strHtml.Append("</td>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_MOD_ENDDATE").ToString + "</B></td><td align=left > &nbsp;")
                            strHtml.Append(EndDate)
                            strHtml.Append("</td>")
                            strHtml.Append("</TR></TABLE>")

                        Case CommonFunction.Constants.APP_TAG_CHANGE_MANAGEMENT

                            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_CR_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strTitle)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strProjectName)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_CR_CATEGORY").ToString + "</B></td><td align=left> &nbsp;")
                            strHtml.Append(strChangeCategory)
                            strHtml.Append("</td>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_CR_PRIORITY").ToString + "</B></td><td align=left > &nbsp;")
                            strHtml.Append(strChangePriority)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_CR_DATE").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(StartDate)
                            strHtml.Append("</td>")
                            strHtml.Append("</TR></TABLE>")

                            'Commented & Added by GokulP on 08 Sept 2009 for IssueID : 33068
                            'Case CommonFunction.Constants.APP_TAG_DELIVERABLES
                        Case CommonFunction.Constants.APP_TAG_CONFIGURE_DELIVERABLE
                            'End of Comment & Addition by GokulP on 08 Sept 2009 for IssueID : 33068

                            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_DEL_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strTitle)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strProjectName)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_DEL_STARTDATE").ToString + "</B></td><td align=left> &nbsp;")
                            strHtml.Append(StartDate)
                            strHtml.Append("</td>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_DEL_ENDDATE").ToString + "</B></td><td align=left > &nbsp;")
                            strHtml.Append(EndDate)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_DEL_DELIVERABLETYPE").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strDeliverableType)
                            strHtml.Append("</td>")
                            strHtml.Append("</TR></TABLE>")

                        Case CommonFunction.Constants.APP_TAG_SUB_PROJECTS
                            strHtml.Append("<TABLE id='tblCap02182'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_SUBP_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strTitle)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_PROJ_NAME").ToString + "</B></td><td align=left colspan=3> &nbsp;")
                            strHtml.Append(strProjectName)
                            strHtml.Append("</td></tr><tr align=Left class='clsTREven'>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_SUBP_STARTDATE").ToString + "</B></td><td align=left> &nbsp;")
                            strHtml.Append(StartDate)
                            strHtml.Append("</td>")
                            strHtml.Append("<td align='right'><B>" + MyBase.GetResourceString("CAP_SUBP_ENDDATE").ToString + "</B></td><td align=left > &nbsp;")
                            strHtml.Append(EndDate)
                            strHtml.Append("</td>")
                            strHtml.Append("</TR></TABLE>")
                    End Select

                    strHtml.Append("<BR><BR><TABLE style='font-size: 10pt; background-image: none; font-family: Verdana, Arial; background-color: transparent; width:99.9%;' CellSpacing=0 BORDER=0 class='clsTable'><TR align=Left class='clsTREven'><td align='Left'><B>Note :</B></td><td align='Left' bgcolor='00CC00' width='3%' style='border-color:black; border-width:1px; border-style:solid'>&nbsp;</td><td align='Left'>&nbsp;Cleared Stage</td>")
                    strHtml.Append("<td style='border-color:black; border-width:1px; border-style:solid' align='Left' bgcolor='orange' width='3%'>&nbsp;</td><td align='Left'>&nbsp;Current Stage</td><td align='Left' bgcolor='Tomato' width='3%' style='border-color:black; border-width:1px; border-style:solid'>&nbsp;</td><td align='Left'>&nbsp;Delayed Current Stage</td><td align='Left' bgcolor='FFFF66'width='3%' style='border-color:black; border-width:1px; border-style:solid'>&nbsp;</td><td align='Left'>&nbsp;Stage not reached yet</td></tr></Table><br>")

                End If

                strHtml.Append("<table width=90% cellspacing=3 cellpadding=1 align=center valign=middle >") 'style='border-color:black; border-width:1px; border-style:solid'

                strHtml.Append("<tr class=clsTRPageCaption>")
                strHtml.Append("<td style='border-color:black; border-width:1px; border-style:solid' bgcolor=blue colspan=" + intRowCount.ToString + " align=center valign=middle>")
                strHtml.Append("<font color='white'>" + strNatureofDemand + "</font>")
                strHtml.Append("</td></tr>")

                strHtml.Append("<tr align=center valign=middle style='font-family: Verdana, Arial; font-size: 8pt; color: #000000;border-color:black; border-width:1px; border-style:solid'>")

                blnIsFirst = False
            End If

            If blnIsCurrentStage = True Then
                If intIsDelayed <> 0 And strRequestStageID <> "3" Then
                    'strFillColor = "Tomato"
                    strFillColor = "Delayed_CurrentStage_R.gif"
                ElseIf strRequestStageID = "3" Then
                    strFillColor = "ClearedStage_R.gif"
                Else
                    strFillColor = "CurrentStage_R.gif"
                End If
                blnIsCurrentStagePassed = True
            End If

            If Not blnIsCurrentStage And blnIsCurrentStagePassed Then
                strFillColor = "Stage_Not_Reached_R.gif"
            End If
            strHtml.Append("<td style='border-left-color: white; border-right-color: black; border-top-color: white; border-bottom-color: black; border-width:1px; border-style:solid' width='" + strWidth.ToString + "%' align=center background='../../Images/DB/" + strFillColor + "'; background-streatch: true; background-width='100%'; background-height='100%'; >")

            strHtml.Append(intOrderNumber.ToString + ". " + strRequestStage)

            If m_strFrom.ToUpper.ToString = "WORKFLOW" Then
                If strRequestStageID <> "3" And strRequestStageID <> "1" Then
                    strHtml.Append("<BR><IMG align=center border= 0 style='cursor:pointer;' src='../../Images/WF_UserStage_Last.gif' onclick='javascript:add_Approvers(" + strRequestStageID + "," + m_intNatureofDemandID.ToString + "," + m_intNatureofdemandStageID.ToString + ")'>")
                End If
            End If


            If blnIsCurrentStage = True And intIsDelayed <> 0 And strRequestStageID <> "3" Then
                strHtml.Append("<BR>(Delayed by : " + intIsDelayed.ToString + " days)")
            End If
            If m_strFrom.ToUpper.ToString <> "WORKFLOW" Then
                If strApproverList <> "" And strApproverList.ToUpper <> "STAKE HOLDERS" Then
                    strHtml.Append("<BR><br><b>" + MyBase.GetResourceString("CAP_APPROVERS").ToString + " : </b><br>")
                    strHtml.Append(strApproverList)
                    strHtml.Append("</td>")
                End If
            End If
        End While

        '  strHtml.Append("</tr></table><br>")
        strHtml.Append("</tr>")

        'Modified By PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition
        If m_strFrom.ToUpper.ToString = "WORKFLOW" Then
            DrawApprovers_forStages()
        End If
        'End Modification PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition

        strHtml.Append("</table><br>")


        CommonFunction.General.WriteHTML(strHtml.ToString)

        'Draw_InitiativeHistory()

        'Modified By PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition
        If m_strFrom.ToUpper.ToString <> "WORKFLOW" Then
            Draw_InitiativeHistory()
        End If
        'End modification PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition

        CommonFunction.General.WriteHTML("</div>")

        Response.Write(strMenu)
        strHtml = Nothing
        CommonFunction.Data.DisposeDataReader(drInitiativeDetails)
        CommonFunction.Data.DisposeDataReader(drEntityDetails)
    End Sub

    Protected Sub Draw_InitiativeHistory()
        '=====================================================================
        ' Procedure Name        : Draw_InitiativeHistory()
        ' Purpose               : To Draw UI of Page for displaying Initiative History
        ' Description           : 
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : 11 Jun 2008
        ' Revisions             :
        '=====================================================================
        'Dim strHtml As String
        Dim strSQL As String
        Dim drHistory As IDataReader
        Dim cObjFilterDetails As New WebPage.Templates.SectionTitle
        Dim arrActualColumns() As String = {"EventTime", "ActionType", "FromStage", "ToStage", "UserName", "Comments"}
        Dim arrUserFriendlyColumn() As String = {"Event Time", "Action Taken", "From Stage", "To Stage", "Approver/Sender", "Comments"}
        Dim arrWidthArray() As String = {"align=left", "align=left", "align=left", "align=left", "align=left", "align=left"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "usp_Sel_WorkflowApproval_History '" + m_intWFInstanceID.ToString + "'," + m_intuniqueID.ToString + "," + m_intTagID.ToString
        drHistory = CommonFunction.Data.GetDataReader(strSQL, True)
        If drHistory.Read Then
            With cObjFilterDetails
                CommonFunctions.General.WriteHTML(.GetSectionTitle("<B>Workflow Approval History</B>", "DivRelatedData", "ShowHideData"))
                CommonFunctions.General.WriteHTML("<br><TABLE cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
                CommonFunctions.General.WriteHTML("<TR class=clsTROdd><TD align=Left>")
                CommonFunctions.General.WriteHTML("Only those stages on which the stakeholders have taken an action will be displayed here.") 'Stages approved by the system - for the usage of Jump to function and/or Rule definition will not be displayed.
                CommonFunctions.General.WriteHTML("</TD></TR></TABLE><BR>")
                CommonFunctions.General.WriteHTML("<SCRIPT Language=javascript>")
                CommonFunctions.General.WriteHTML(.ClientsideScript)
                CommonFunctions.General.WriteHTML("</SCRIPT>")
            End With
            CommonFunctions.General.WriteHTML("<div ID='DivRelatedData' style='overflow:auto;width:99.9%;height:250px'>")

            With m_objGrid
                .ActualColumnArray = arrActualColumns
                .UserFriendlyColumnArray = arrUserFriendlyColumn
                .UseSQL = True
                .EmptyValueReplacement = "&nbsp;"
                .SQL = strSQL
                .NoOfDataColumns = 6
                .DIVID = "DivList1"
                'Commented and Added By Bharat T on 15th-Oct-2015
                '.DIVHeight = 245
                .DIVHeight = 240
                'End of Commented and Added By Bharat T on 15th-Oct-2015
                .DIVStyle = "overflow:auto;width:99.99%;"
                .returnHTML = True
                'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                .IgnoreHTMLEncode = arrIgnoreHTMLEncode
                'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.General.WriteHTML("<br>" + .DrawGrid())
            End With
            CommonFunctions.General.WriteHTML("</div>")
        End If
        CommonFunction.Data.DisposeDataReader(drHistory)
    End Sub

    Private Function DrawMenu() As String
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : String (Menu)
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : PurvaJ
        ' Created               : 11 Jun 2008
        ' Revisions             :
        '=====================================================================

        'Dim arrMenu() As String = {"Close", "<img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}
        'Dim arrMenuToolTip() As String = {"Close", "Help"}
        'Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('DBInitiativeDetails')"}

        'Dim strMenu As String = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        'Return strMenu

        'Modified By PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition

        Dim strMenu As String = ""

        If m_strFrom.ToUpper.ToString = "WORKFLOW" Then
            Dim arrMenu() As String = {"Select Stages", "Close", "<img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}
            Dim arrMenuToolTip() As String = {"Select Stages", "Close", "Help"}
            Dim arrClientSideFunctions() As String = {"SelectStages_OnClick(" + m_intNatureofDemandID.ToString + ")", "Close_OnClick()", "OpenHelpPage('DBInitiativeDetails')"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        Else
            Dim arrMenu() As String = {"Close", "<img Border=0 src='../../Images/cssImages/Link images/help.gif'>"}
            Dim arrMenuToolTip() As String = {"Close", "Help"}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('DBInitiativeDetails')"}
            strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrClientSideFunctions, arrMenuToolTip, True)
        End If

        Return strMenu
        'End Modification PurvaJ 12 Aug 2008 New Graphical UI for Workflow Definition

    End Function

    Private Sub DrawApprovers_forStages()
        Dim Dr As IDataReader
        Dim intOldStageID As Integer = 0
        Dim intNewStageID As Integer = 0
        Dim i As Integer = 1
        Dim intRequeststageID As Integer

        Dr = CommonFunction.Data.GetDataReader("usp_sel_WorkflowRuleDetails_GraphicalUI " + m_intNatureofDemandID.ToString, True)
        strHtml.Append("<TR class='clsTROdd'>")
        strHtml.Append("<TD align = 'Left'>")
        strHtml.Append("<Table Border=0 cellspacing=0 cellpadding=0 width='99.9%'>")
        While Dr.Read()
            intRequeststageID = CommonFunction.Data.CheckIsDBNull(Dr("RequestStageID"), "0")
            intOldStageID = intNewStageID
            intNewStageID = CommonFunction.Data.CheckIsDBNull(Dr("RequestStageID"), "-")

            If intOldStageID <> intNewStageID And intOldStageID <> 0 Then
                strHtml.Append("</table>")
                strHtml.Append("</TD>")
                strHtml.Append("<TD align = 'Left'>")
                strHtml.Append("<Table Border=0 cellspacing=0 cellpadding=0 width='99.9%'>")
                i = 1
            End If
            strHtml.Append("<TR class='clsTROdd'>")
            strHtml.Append("<TD>")
            If intRequeststageID.ToString <> "1" And intRequeststageID.ToString <> "3" Then
                strHtml.Append(i.ToString + ". ")
            End If

            strHtml.Append(CommonFunction.Data.CheckIsDBNull(Dr("RoleDescription"), "") + "</TD>")
            strHtml.Append("<TD style='Cursor:pointer;' onclick='ShowRule_OnClick(" + CommonFunction.Data.CheckIsDBNull(Dr("ApproverID"), "0").ToString + "," + CommonFunction.Data.CheckIsDBNull(Dr("RequeststageID"), "0").ToString + "," + m_intNatureofDemandID.ToString + ")'><u>" + CommonFunction.Data.CheckIsDBNull(Dr("UserFriendlyRuleDetails"), "") + "</u></TD>")
            'strHtml.Append("<TD>" + CommonFunction.Data.CheckIsDBNull(Dr("UserFriendlyRuleDetails"), "") + "</TD>")
            strHtml.Append("</TR>")
            i = i + 1
        End While
        strHtml.Append("</table>")
        strHtml.Append("</TD>")
        strHtml.Append("</TR>")
        CommonFunction.Data.DisposeDataReader(Dr)


    End Sub
End Class
