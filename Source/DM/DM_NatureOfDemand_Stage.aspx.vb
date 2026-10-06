
'=====================================================================
'                       CSPL Code Header                              
' Project Name          :  WhizibleSEM 8.0
' Module Name           :  DM_NatureOfDemand_Stage.aspx
' Purpose               :  
' Description           :  
' Dependencies          :  None
' Author                :  PurvaJ
' Reviewed              :  25 april 2008
' Tested                :  
' Created               :  
' Revisions             :  
'=====================================================================

#Region "Imports"
Imports CommonFunctions
Imports CommonFunctions.Application
Imports CommonFunctions.Data
Imports CommonFunctions.General
Imports WebPages.Template
Imports WebPages.Security
#End Region

Public Class DM_NatureOfDemand_Stage
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.

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
        InitializeComponent()
    End Sub

#End Region

#Region "Member Variables"
    Private m_objGlobal As IGlobal
    Private m_objAccessRights As cAccessRights
    Protected m_lngTagId As Long = 0
    Private WithEvents m_objstageGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objstakeholderGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As WebPages.Template.StaticMenu

    Protected m_strNatureOfDemandID As String
    Protected m_strNatureOfDemand As String
    Protected m_strRequeststageID As String
    Protected m_strNatureOfDemandStageID As String = ""
    Protected m_strStage As String

    Protected m_StrMode As String
    Protected m_strAction As String
    Protected m_stageWithoutApprover As String
    Private m_strSQL As String = ""
    Private strPageAlphabets As String = ""
    Protected m_strPageNumber As String = ""

    Protected m_strTagID As String = ""

    Protected m_strROLID As String = ""
    Protected m_strBGID As String = ""
    Protected m_strOUID As String = ""
    Protected m_strPKIDList As String = ""
    Protected m_strAttributeID As String = ""
    Protected m_strFromWhere As String = ""
    Protected m_strApprover As String = ""
#End Region

#Region "Functions and Sub-Procedures"

    Public Sub PageInit()
        '====================================================================
        ' Procedure Name        :   PageInit
        ' Parameters Passed     :   None
        ' Returns               :   None
        ' Parameters Affected   :   None
        ' Purpose               :   To draw all controls on the page
        ' Description           :   This is main procedure on this page which actually draw the page with its 
        '                           controls on it. This procedure is called from the HTML body tag of the page.
        '                           this procedure gives the call to other procedures and functions in the class.
        ' Assumptions           :   None
        ' Dependencies          :   None
        ' Author                :   
        ' Created               :   
        ' Revisions             :   
        '=====================================================================



        Call GetGlobalObject()

        'Call setVariables()
        m_strPKIDList = CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtPKIDList")))

        If Not IsNothing(HttpContext.Current.Request.QueryString("ACTION")) Then
            Call PerformAction()
        End If

        Call DrawMenu()

        CommonFunction.General.WriteHTML("<input type=hidden id=txtFromWhere name=txtFromWhere value=" + m_strFromWhere.ToString + ">")

        If m_StrMode = "STAGE" Then
            CommonFunctions.General.WriteHTML("<br>")
            'Commented And Added By Vaijat K ON 10/11/2015
            'WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_STAGE"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + m_strNatureOfDemand)
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_STAGE"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + HttpUtility.HtmlEncode(m_strNatureOfDemand))
            CommonFunction.General.WriteHTML("<br>")
        ElseIf m_StrMode = "STAKEHOLDER" Then
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_STAKEHOLDER"), MyBase.GetResourceString("CAP_NAUREOFDEMANDSTAGE") + m_strStage)
            CommonFunction.General.WriteHTML("<br>")
            CommonFunction.General.WriteHTML("<TABLE class='clsTable' width='99.9%'><TR class='clsTREven'><TD> Role")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtApprover", "txtApprover", , 200, , m_strApprover, , , , , , , "javascript:'onkeypress=Filter_OnKeyPress(event)' ", True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
            CommonFunction.General.WriteHTML("<br>")
            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot caption for Stakeholder and Approver at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" Then
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_STAKEHOLDER"), MyBase.GetResourceString("CAP_NAUREOFDEMANDSTAGE") + m_strStage)
            CommonFunction.General.WriteHTML("<br>")
            CommonFunction.General.WriteHTML("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='100%'><TR class='clsTRPageFilters'><TD> Role")
            'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtApprover", "txtApprover", , 200, , m_strApprover, , , , , , , "javascript:'onkeypress=Filter_OnKeyPress(event)' ", True, EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunction.General.WriteHTML("</TD></TR></TABLE>")
            CommonFunction.General.WriteHTML("<br>")

        ElseIf m_StrMode.ToUpper() = "PROJECT_APPROVER" Then
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_APPROVERS"), MyBase.GetResourceString("CAP_NAUREOFDEMANDSTAGE") + m_strStage)
            CommonFunction.General.WriteHTML("<br>")
            CommonFunction.General.WriteHTML(DrawFilters())
            CommonFunction.General.WriteHTML("<br>")
            ' End_MV_29-April-2008
        ElseIf m_StrMode = "PENDINGINITIATIVES" Then
            CommonFunction.General.WriteHTML("<BR>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_PENDINGINITIATIVE"))
            CommonFunction.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("CAP_NAUREOFDEMAND") + m_strNatureOfDemand, MyBase.GetResourceString("CAP_NAUREOFDEMANDSTAGE") + m_strStage)
            CommonFunction.General.WriteHTML("<BR>")
            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot caption for Stages at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAGE" Then
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_STAGE"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + m_strNatureOfDemand)
            CommonFunction.General.WriteHTML("<br>")
            ' End_MV_29-April-2008
            'Addition done by SuchitraP on 16 July 2008 for CRM Workflow stages
        ElseIf m_StrMode.ToUpper = "CRM_PROJECT_STAGE" Then
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_STAGE"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + m_strNatureOfDemand)
            CommonFunction.General.WriteHTML("<br>")
            'End by SuchitraP
        ElseIf m_StrMode.ToUpper() = "PROJECT_OWNER" Then
            CommonFunctions.General.WriteHTML("<br>")
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("PAGE_CAPTION_PROJECT_OWNER"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + m_strNatureOfDemand)
            CommonFunction.General.WriteHTML("<br>")
        ElseIf m_StrMode.ToUpper() = "CORPORATE_APPROVER" Then
            MyBase.InitializeResources("AppResources.DM_NatureOfDemand_Stage", "AppResources")
            CommonFunctions.General.WriteHTML("<br>")
            'Commented And Added By Vaijat K ON 10/11/2015
            'WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("COL_DEFAULT_APPROVER"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + m_strNatureOfDemand)
            WebPages.Template.PageCaption.GetPageCaptions(m_objGlobal, MyBase.GetResourceString("COL_DEFAULT_APPROVER"), MyBase.GetResourceString("CAP_NAUREOFDEMAND") + HttpUtility.HtmlEncode(m_strNatureOfDemand))
            CommonFunction.General.WriteHTML("<br>")
            CommonFunction.General.WriteHTML(DrawFilters())
            CommonFunction.General.WriteHTML("<br>")

        End If

        CommonFunction.General.WriteHTML("<DIV Id=PageDiv name =PageDiv Style='HEIGHT:325px;OVERFLOW:auto; WIDTH:99.99%'>" + vbCrLf)
        If m_StrMode = "STAGE" Then
            Call drawStageGrid()
        ElseIf m_StrMode = "STAKEHOLDER" Then
            Call DrawStakeHolder_Grid()
            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot Grid for Stakeholder and Approver at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" Then
            Call DrawProjectStakeHolderGrid()

        ElseIf m_StrMode.ToUpper() = "PROJECT_APPROVER" Then
            Call DrawProjectApproverGrid()
            ' End_MV_29-April-2008
        ElseIf m_StrMode = "PENDINGINITIATIVES" Then
            Call drawPendingInitiatives()
            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot Grid for Stages at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAGE" Then
            Call drawProjectStageGrid()
            ' End_MV_29-April-2008
            'Addition done by SuchitraP on 16 July 2008 for CRM Workflow stages
        ElseIf m_StrMode.ToUpper = "CRM_PROJECT_STAGE" Then
            Call drawCRMStageGrid()
            'End of addition done by SuchitraP
            '------ Added By PurvaJ on 8 May 2008 for project owners
        ElseIf m_StrMode.ToUpper() = "PROJECT_OWNER" Then
            Call drawProjectOwnerGrid()
            '------- End Addition PurvaJ
        ElseIf m_StrMode.ToUpper() = "CORPORATE_APPROVER" Then
            Call drawCorporateAlternateApproverGrid()
        End If

        CommonFunction.General.WriteHTML("</DIV>")
        '  m_strPKIDList = m_strPKIDList.Substring(0, m_strPKIDList.Length - 1)
        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        General.WriteHTML(HTMLControls.DrawTextBox("txtPKIDList", "txtPKIDList", , , , m_strPKIDList.Trim, , , , , , True, , True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        '----Footer Note
        'CommonFunctions.General.WriteHTML("<Table width='100%'><TR class='clsTREven'><TD><I>")
        'If m_StrMode = "STAKEHOLDER" Then
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE") + vbCrLf)
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_APPROVER_ADDITION_EFFECT") + vbCrLf)
        '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_APPROVER_DELETION") + vbCrLf)
        '    ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
        '    ' Purpose : To write note for Stakeholder and Approver at Project level
        '    ' Start_MV_29-April-2008
        '    'ElseIf m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" Then
        '    '    ' CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE") + vbCrLf)
        '    '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_APPROVER_ADDITION_EFFECT") + vbCrLf)
        '    '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_APPROVER_DELETION") + vbCrLf)

        '    'ElseIf m_StrMode.ToUpper() = "PROJECT_APPROVER" Then
        '    '    'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE") + vbCrLf)
        '    '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_APPROVER_ADDITION_EFFECT") + vbCrLf)
        '    '    CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_APPROVER_DELETION") + vbCrLf)

        '    ' End_MV_29-April-2008
        'ElseIf m_StrMode = "PENDINGINITIATIVES" Then
        '    'CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NOTE_PENDINGINITIATIVES"))
        'Else
        '    CommonFunctions.General.WriteHTML("&nbsp;")
        'End If
        'CommonFunctions.General.WriteHTML("</I><TD><TR></Table>")
        '-------------


        Call DrawMenu(False)
    End Sub

    Private Function DrawFilters() As String
        Dim m_SBHTML As New System.Text.StringBuilder



        m_SBHTML.Append("<TABLE id='tblFilter' CellSpacing=0 BORDER=0 class='clsTable' width='100%'>")
        m_SBHTML.Append("<TR align=Left class='clsTRPageFilters'>")
        ''''BG
        m_SBHTML.Append("<TD align=right>")
        m_SBHTML.Append(MyBase.GetResourceString("COL_FILTERHEADER_BG") + "&nbsp;")
        m_SBHTML.Append("</TD>")
        m_SBHTML.Append("<TD align=left>")
        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboBG", "usp_Sel_tbl_CNF_BusinessGroups", 200, m_strBGID, "onChange=Filter_OnChange();", True, True))
        m_SBHTML.Append("</TD>")

        '''OU
        m_SBHTML.Append("<TD align=right>")
        m_SBHTML.Append(MyBase.GetResourceString("COL_FILTERHEADER_OU") + "&nbsp;")
        m_SBHTML.Append("</TD>")
        m_SBHTML.Append("<TD align=left>")
        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboOU", "usp_Sel_GetOrganizationUnit " + m_strBGID, 200, m_strOUID, "onChange=Filter_OnChange();", True, True))
        m_SBHTML.Append("</TD></TR>")

        ''''Role
        m_SBHTML.Append("<TR align=Left class='clsTRPageFilters'><TD align=right>")
        m_SBHTML.Append(MyBase.GetResourceString("COL_ROLE") + "&nbsp;")
        m_SBHTML.Append("</TD>")
        m_SBHTML.Append("<TD align=left>")
        m_SBHTML.Append(CommonFunctions.HTMLControls.DrawComboBox("cboRole", "usp_Sel_tbl_PM_Role", 200, m_strROLID, "onChange=Filter_OnChange();", True, True))
        m_SBHTML.Append("</TD>")
        
        ''' Alternate approver name
        m_SBHTML.Append("<TD align=right>")
        m_SBHTML.Append("Alternate Approver " + "&nbsp;")
        m_SBHTML.Append("</TD>")
        m_SBHTML.Append("<TD align=left>")

        'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        m_SBHTML.Append(CommonFunction.HTMLControls.DrawTextBox("txtApprover", "txtApprover", , 200, , m_strApprover, , , , , , , "javascript:'onkeypress=Filter_OnKeyPress(event)' ", True, EnableHTMLEncode:=True))
        'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
        m_SBHTML.Append("</TD>")
        m_SBHTML.Append("</TR>")
        m_SBHTML.Append("</TABLE>")

        DrawFilters = m_SBHTML.ToString
        m_SBHTML = Nothing
    End Function

    Protected Sub DrawHeader()
        Call setVariables()

        If m_StrMode.ToUpper = "STAGE" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_STAGE"))
        ElseIf m_StrMode.ToUpper = "STAKEHOLDER" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_STAKEHOLDER"))
            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot Page Header for Stakeholder and Approvers at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_STAKEHOLDER"))
        ElseIf m_StrMode.ToUpper() = "PROJECT_APPROVER" Then
            CommonFunctions.General.PlotPageHeadTag("Select Project Approvers")
            ' End_MV_29-April-2008
        ElseIf m_StrMode.ToUpper = "PENDINGINITIATIVES" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_PENDINGINITIATIVE"))
            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot Page Header for Stages at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAGE" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_STAGE"))
            'Addition by SuchitraP on 16 July 2008 for CRM Workflow satges
        ElseIf m_StrMode.ToUpper() = "CRM_PROJECT_STAGE" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_STAGE"))
            'End by SuchitraP
            ' End_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_OWNER" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_PROJECT_OWNER"))
        ElseIf m_StrMode.ToUpper() = "CORPORATE_APPROVER" Then
            CommonFunctions.General.PlotPageHeadTag(MyBase.GetResourceString("PAGE_CAPTION_CORPORATE_APPROVERS"))

        End If
    End Sub
    Private Sub setVariables()
        '====================================================================
        ' Procedure Name        :  setVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stage selection 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  
        ' Created               : 
        ' Revisions             :  
        '=====================================================================
        ' Modified By MahendraV On 29-April-2008 for WhizibleSEM8.0
        ' Purpose : To set variables for Stages for Project level as well as corporate level
        ' Start_MV_29-April-2008

        'm_strNatureOfDemandID = HttpContext.Current.Request.QueryString("NatureOfDemandID")
        'm_strNatureOfDemandStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandStageID"), "")

        m_strROLID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboRole"))
        m_strBGID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboBG"))
        m_strOUID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboOU"))

        If Not HttpContext.Current.Request.QueryString("NatureOfDemandID") Is Nothing Then
            m_strNatureOfDemandID = HttpContext.Current.Request.QueryString("NatureOfDemandID")
        End If

        If Not HttpContext.Current.Request.QueryString("ProjectNatureOfDemandID") Is Nothing Then
            m_strNatureOfDemandID = HttpContext.Current.Request.QueryString("ProjectNatureOfDemandID")
        End If

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandStageID"), "") <> "" Then
            m_strNatureOfDemandStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("NatureOfDemandStageID"), "")
        End If

        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectNatureOfDemandStageID"), "") <> "" Then
            m_strNatureOfDemandStageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectNatureOfDemandStageID"), "")
        End If

        m_strRequeststageID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestStageID"), "")

        m_StrMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("MODE"), "").ToUpper

        m_strApprover = CommonFunction.General.CheckIsNothing(Request.Form("txtApprover"), "").ToString

        'Added mode CRM_PROJECT_STAGE by SuchitraP on 16 July 2008 for CRM Workflow Stages
        If m_StrMode = "PROJECT_STAGE" Or m_StrMode = "PROJECT_OWNER" Or m_StrMode = "PROJECT_APPROVER" Or m_StrMode = "PROJECT_STAKEHOLDER" Or m_StrMode = "CRM_PROJECT_STAGE" Then
            m_strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT NatureOfDemand FROM Tbl_IM_ProjectNatureOfDemand WHERE ProjectNatureOfDemandID = " + m_strNatureOfDemandID, MyBase.UseSQL), "")
        Else
            m_strNatureOfDemand = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT NatureOfDemand FROM Tbl_IM_NatureOfDemand WHERE NatureOfDemandID = " + m_strNatureOfDemandID, MyBase.UseSQL), "")
        End If
        ' End_MV_29-April-2008
        If m_strRequeststageID <> "" Then
            m_strStage = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT RequestStage FROM Tbl_IM_RequestStage WHERE RequestStageID = " + m_strRequeststageID, MyBase.UseSQL), "")
        End If

        m_strAction = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ACTION"), "").ToUpper

        '''''''''''''
        m_strPageNumber = CommonFunctions.General.CheckIsNothing(Request("PageNumber"))
        m_strPageNumber = CommonFunctions.General.UnBuildQueryString(m_strPageNumber)
        If m_strPageNumber = "" Then
            m_strPageNumber = "-1"
        Else
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_AND, "&")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_HASH, "#")
            m_strPageNumber = Replace(m_strPageNumber, CommonFunctions.Constants.PAGING_SPECIAL_CHAR_PLUS, "+")
        End If
        ''''''''''''

        If m_StrMode = "STAGE" Then
            m_strAttributeID = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AttributeID FROM Tbl_IM_NatureOfDemand WHERE NatureOfDemandID = " + m_strNatureOfDemandID, MyBase.UseSQL), "")
            'Added mode CRM_PROJECT_STAGE by SuchitraP on 16 July 2008 for CRM Workflow Stages
        ElseIf m_StrMode = "PROJECT_STAGE" Or m_StrMode = "CRM_PROJECT_STAGE" Then
            m_strAttributeID = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT AttributeID FROM Tbl_IM_ProjectNatureOfDemand WHERE ProjectNatureOfDemandID = " + m_strNatureOfDemandID, MyBase.UseSQL), "")
        End If

        'Addition by SuchitraP on 4-Aug-2008 for CRM Workflow
        If CommonFunctions.General.CheckIsNothing(Request.QueryString("MasterTagID"), "") <> "" Then
            m_strTagID = Request.QueryString("MasterTagID")
        End If
        'End by SuchitraP


        If CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "") <> "" Then
            m_strFromWhere = CommonFunctions.General.CheckIsNothing(Request.QueryString("FromWhere"), "")
        End If
        If m_strFromWhere = "" Then
            m_strFromWhere = CommonFunctions.General.CheckIsNothing(Request.Form("txtFromWhere"), "")
        End If


        ' m_stageWithoutApprover = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_Tbl_IM_NatureofDemand_Without_stageApprover " + m_strNatureOfDemandID, MyBase.UseSQL), "0"), "0")
    End Sub

    Private Sub DrawMenu(Optional ByVal blnShowPaging As Boolean = True)
        '=====================================================================
        ' Procedure Name        : DrawMenu
        ' Purpose               : Returns Menu as string for the page
        ' Description           : NOTE: Access Rights are handled in the Menu events
        ' Parameters Passed     : None
        ' Returns               : 
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : NitinVS
        ' Created               : 16 Dec 2005
        ' Revisions             :
        '=====================================================================
        Dim arrCMenu() As String
        Dim arrCMenuToolTip() As String
        Dim arrCClientSideFunctions() As String
        Dim m_SQLSB As System.Text.StringBuilder
        If m_StrMode = "STAGE" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;" + MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SelectStage_OnClick()", "Close_OnClick()", "OpenHelpPage('3928-3329')"}

            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)


        ElseIf m_StrMode = "STAKEHOLDER" Then
            ''''''''''
            m_strSQL = "usp_Sel_tbl_IM_NatureOfDemand_Stage_stakeHolders_Paging " & m_strNatureOfDemandStageID
            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, MyBase.GetResourceString("MENU_SELECT"), , "Alphabet", True)

            ''''''''''''''''
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SelectStakeholder_OnClick()", "Close_OnClick()", "OpenHelpPage('3928-3329')"}

            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)

            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot Menu for Stakeholder and Approvers at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" Then
            m_strSQL = "usp_Sel_tbl_IM_ProjectNatureOfDemand_Stage_stakeHolders_Paging " & m_strNatureOfDemandStageID

            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, MyBase.GetResourceString("MENU_SELECT"), , "Alphabet", True)

            If CommonFunction.General.CheckIsNothing(Request.QueryString("MasterTagID"), "").ToString <> "8036" Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunctions() As String = {"SelectProjectStakeholder_OnClick()", "Close_OnClick()", "OpenHelpPage('3934-3333')"}

                ReDim arrCMenu(arrMenu.Length - 1)
                ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
                ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

                arrMenu.CopyTo(arrCMenu, 0)
                arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
                arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
            Else
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('3934-3333')"}

                ReDim arrCMenu(arrMenu.Length - 1)
                ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
                ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

                arrMenu.CopyTo(arrCMenu, 0)
                arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
                arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
            End If

        ElseIf m_StrMode.ToUpper() = "PROJECT_APPROVER" Then
            m_SQLSB = New System.Text.StringBuilder

            m_SQLSB.Append("usp_Sel_Tbl_IM_ProjectNatureOfDemand_StageDetails_Paging ")
            m_SQLSB.Append(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), -1))
            m_SQLSB.Append(",")
            m_SQLSB.Append(m_strNatureOfDemandStageID)
            If m_strROLID <> "" Then
                m_SQLSB.Append("," + m_strROLID)
            Else
                m_SQLSB.Append(",NULL")
            End If
            If m_strBGID <> "" Then
                m_SQLSB.Append("," + m_strBGID)
            Else
                m_SQLSB.Append(",NULL")
            End If
            If m_strOUID <> "" Then
                m_SQLSB.Append("," + m_strOUID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            m_strSQL = m_SQLSB.ToString
            m_SQLSB = Nothing

            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, MyBase.GetResourceString("MENU_SELECT"), , "Alphabet", True)

            If CommonFunction.General.CheckIsNothing(Request.QueryString("MasterTagID"), "").ToString <> "8036" Then
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunctions() As String = {"SelectProjectApprovers_OnClick()", "Close_OnClick()", "OpenHelpPage('3934-3333')"}

                ReDim arrCMenu(arrMenu.Length - 1)
                ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
                ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

                arrMenu.CopyTo(arrCMenu, 0)
                arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
                arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
            Else
                Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
                Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
                Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('3934-3333')"}

                ReDim arrCMenu(arrMenu.Length - 1)
                ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
                ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

                arrMenu.CopyTo(arrCMenu, 0)
                arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
                arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
            End If
            

            ' End_MV_29-April-2008
        ElseIf m_StrMode = "PENDINGINITIATIVES" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"Close_OnClick()", "OpenHelpPage('3928-3329')"}

            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)

            ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
            ' Purpose : To plot Menu for Stages at Project level
            ' Start_MV_29-April-2008
        ElseIf m_StrMode.ToUpper() = "PROJECT_STAGE" Then
            ''MyBase.GetResourceString("MENU_SELECT"), 
            'MyBase.GetResourceString("MENU_BACK_TOOLTIP"),
            ''"SelectProjectStage_OnClick()", 

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;" + MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SelectProjectStage_OnClick()", "Close_OnClick()", "OpenHelpPage('3934-3333')"}

            ' End_MV_29-April-2008
            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
            'Addition done by SuchitraP on 16 July 2008 for CRM Workflow stages
        ElseIf m_StrMode.ToUpper() = "CRM_PROJECT_STAGE" Then
            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), "<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>&nbsp;" + MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SelectCRMStage_OnClick()", "Close_OnClick()", "OpenHelpPage('8036-3346')"}

            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
            'End of addition by SuchitraP
            '-------- Added By PurvaJ 8 May 2008 Project Owners
        ElseIf m_StrMode.ToUpper() = "PROJECT_OWNER" Then
            m_SQLSB = New System.Text.StringBuilder

            m_SQLSB.Append("usp_sel_tbl_IM_ProjectNatureofDemandOwners_Paging ")
            m_SQLSB.Append(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), -1))
            m_SQLSB.Append(",")
            m_SQLSB.Append(m_strNatureOfDemandID)
            If m_strROLID <> "" Then
                m_SQLSB.Append("," + m_strROLID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            If m_strBGID <> "" Then
                m_SQLSB.Append("," + m_strBGID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            If m_strOUID <> "" Then
                m_SQLSB.Append("," + m_strOUID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            m_strSQL = m_SQLSB.ToString
            m_SQLSB = Nothing

            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, MyBase.GetResourceString("MENU_SELECT"), , "Alphabet", True)

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SelectProjectOwners_OnClick()", "Close_OnClick()", "OpenHelpPage('3934-3333')"}

            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
        ElseIf m_StrMode.ToUpper() = "CORPORATE_APPROVER" Then
            m_SQLSB = New System.Text.StringBuilder

            m_SQLSB.Append("usp_Sel_Tbl_IM_NatureOfDemand_Approvers_Paging ")

            m_SQLSB.Append(m_strNatureOfDemandStageID)
            If m_strROLID <> "" Then
                m_SQLSB.Append("," + m_strROLID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            If m_strBGID <> "" Then
                m_SQLSB.Append("," + m_strBGID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            If m_strOUID <> "" Then
                m_SQLSB.Append("," + m_strOUID)
            Else
                m_SQLSB.Append(",NULL")
            End If

            m_strSQL = m_SQLSB.ToString
            m_SQLSB = Nothing

            strPageAlphabets = WebPages.Template.Paging.DrawPaging(m_strPageNumber, m_strSQL, MyBase.GetResourceString("MENU_SELECT"), , "Alphabet", True)

            Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SELECT"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP")}
            Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_BACK_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
            Dim arrClientSideFunctions() As String = {"SelectCorporateApprovers_OnClick()", "Close_OnClick()", "OpenHelpPage('3934-3333')"}

            ReDim arrCMenu(arrMenu.Length - 1)
            ReDim arrCMenuToolTip(arrMenuToolTip.Length - 1)
            ReDim arrCClientSideFunctions(arrClientSideFunctions.Length - 1)

            arrMenu.CopyTo(arrCMenu, 0)
            arrMenuToolTip.CopyTo(arrCMenuToolTip, 0)
            arrClientSideFunctions.CopyTo(arrCClientSideFunctions, 0)
        End If


        If strPageAlphabets = "" Then m_strPageNumber = "-1"
        Dim strmenu As String = ""
        m_objMenu = New WebPages.Template.StaticMenu
        If blnShowPaging Then
            strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True, strPageAlphabets)
        Else
            strmenu = m_objMenu.DrawMenuWithEvents(arrCMenu, arrCClientSideFunctions, arrCMenuToolTip, True)
        End If

        CommonFunctions.General.WriteHTML(strmenu)

        m_objMenu = Nothing

    End Sub
    Private Sub PerformAction()
        '====================================================================
        ' Procedure Name        :  PerformAction
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stage selection 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  
        ' Created               : 
        ' Revisions             :  
        '=====================================================================
        'Dim strOrderNumber() As String
        Dim strSelectedStage() As String
        Dim strCheckListValue As String = ""

        Dim strChkETLvalue As String = ""
        Dim strChkEOHLvalue As String = ""
        Dim strChkESLvalue As String = ""

        'Dim strCompletionDays() As String
        Dim intCounter As Integer

        Dim txtSQL As System.Text.StringBuilder
        Dim strSQL As String
        Dim strOrderNumberValue As String = ""
        Dim strSelectedStageStageValue As String = ""

        Dim strCompletionDaysValue As String = ""


        If m_StrMode = "STAGE" And m_strAction = "SAVE" Then

            'strOrderNumber = HttpContext.Current.Request.Form("txtOrderNo").Split(","c)
            strSelectedStage = HttpContext.Current.Request.Form("chkSelect").Split(","c)
            'strCompletionDays = HttpContext.Current.Request.Form("txtCompletionDays").Split(","c)
            strSelectedStageStageValue = HttpContext.Current.Request.Form("chkSelect")

            For intCounter = 0 To strSelectedStage.Length - 1

                strOrderNumberValue = strOrderNumberValue + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo" + CStr(strSelectedStage(intCounter))), "") + ","
                '---- Commented By Purvaj on 15 Sept 2008 Days for completion and Enablesavelink columns removed
                'strCompletionDaysValue = strCompletionDaysValue + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCompletionDays" + CStr(strSelectedStage(intCounter))), "0") + ","
                strCompletionDaysValue = strCompletionDaysValue + "0,"
                '---- End Commented By Purvaj on 15 Sept 2008 Days for completion and Enablesavelink columns removed
                strCheckListValue = strCheckListValue + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCheckList" + CStr(strSelectedStage(intCounter))), "0") + ","


                If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkETL" + CStr(strSelectedStage(intCounter))), "0")) = "" Then
                    strChkETLvalue = strChkETLvalue + "1" + ","
                Else
                    strChkETLvalue = strChkETLvalue + "0" + ","
                End If
                If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkEOHL" + CStr(strSelectedStage(intCounter))), "0")) = "" Then
                    strChkEOHLvalue = strChkEOHLvalue + "1" + ","
                Else
                    strChkEOHLvalue = strChkEOHLvalue + "0" + ","
                End If
                '---- Commented By Purvaj on 15 Sept 2008 Days for completion and Enablesavelink columns removed
                'If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkESL" + CStr(strSelectedStage(intCounter))), "0")) = "" Then
                '    strChkESLvalue = strChkESLvalue + "1" + ","
                'Else
                '    strChkESLvalue = strChkESLvalue + "0" + ","
                'End If

                strChkESLvalue = strChkESLvalue + "0" + ","
                '---- End Commented By Purvaj on 15 Sept 2008 Days for completion and Enablesavelink columns removed
            Next

            ' Remove last Comma 
            strOrderNumberValue = strOrderNumberValue.Substring(0, strOrderNumberValue.Length - 1)
            strCompletionDaysValue = strCompletionDaysValue.Substring(0, strCompletionDaysValue.Length - 1)
            strCheckListValue = strCheckListValue.Substring(0, strCheckListValue.Length - 1)
            strChkETLvalue = strChkETLvalue.Substring(0, strChkETLvalue.Length - 1)
            strChkEOHLvalue = strChkEOHLvalue.Substring(0, strChkEOHLvalue.Length - 1)
            strChkESLvalue = strChkESLvalue.Substring(0, strChkESLvalue.Length - 1)

            If strOrderNumberValue <> "" Then
                txtSQL = New System.Text.StringBuilder
                txtSQL.Append("usp_Ins_tbl_IM_NatureOfDemand_stage ")
                txtSQL.Append(m_strNatureOfDemandID)
                txtSQL.Append(" , '")
                txtSQL.Append(strSelectedStageStageValue)
                txtSQL.Append("' , N'")
                txtSQL.Append(strOrderNumberValue)
                txtSQL.Append("' , N'")
                txtSQL.Append(strCheckListValue)
                txtSQL.Append("' , N'")
                txtSQL.Append(strCompletionDaysValue)
                txtSQL.Append("'")
                txtSQL.Append(",'" + strChkESLvalue + "'")
                txtSQL.Append(",'" + strChkETLvalue + "'")
                txtSQL.Append(",'" + strChkEOHLvalue + "'")
                txtSQL.Append(", N'")
                txtSQL.Append(Session("strUserName"))
                txtSQL.Append("'")

            strSQL = txtSQL.ToString

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            txtSQL = Nothing
        End If


        End If

        If m_StrMode = "STAKEHOLDER" And m_strAction = "SAVE" Then

            Dim strStakeHolders As String = m_strPKIDList 'HttpContext.Current.Request.Form("chkSelect")
            Dim strCheckList As String = "" '= HttpContext.Current.Request.Form("cboCheckList")
            'Dim strStakeHolder As String
            'Dim strChecklistID As String
            Dim strDefaultApprover As String = "" '= CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDefaultApprover"), "")

            txtSQL = New System.Text.StringBuilder

            strSQL = ""
            txtSQL.Append(" usp_INS_UPD_tbl_IM_NatureOfDemand_StageDetails ")
            txtSQL.Append(m_strNatureOfDemandID)
            txtSQL.Append(" ,  '")
            txtSQL.Append(m_strRequeststageID)
            txtSQL.Append("' ,  '")
            txtSQL.Append(strStakeHolders)
            txtSQL.Append("' , N'")
            txtSQL.Append(strCheckList)
            txtSQL.Append("' , N'")
            ' Added Column DefaultApprover 
            txtSQL.Append(strDefaultApprover)
            txtSQL.Append("' , N'")
            txtSQL.Append(Session("strUserName"))
            txtSQL.Append("' , '")
            txtSQL.Append(Session("intUserID"))
            txtSQL.Append("'")
            strSQL = txtSQL.ToString

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ' Clean up Memory 
            txtSQL = Nothing
            'Next
        End If

        If m_StrMode.ToUpper() = "CORPORATE_APPROVER" And m_strAction.ToUpper() = "SAVE" Then
            Dim strStakeHolders As String = m_strPKIDList 'HttpContext.Current.Request.Form("chkSelect")
            Dim strCheckList As String = ""
            Dim strStakeHolder As String
            Dim strChecklistID As String
            Dim strDefaultApprover As String = ""

            txtSQL = New System.Text.StringBuilder

            strSQL = ""
            txtSQL.Append(" usp_INS_UPD_tbl_IM_NatureOfdemand_Approvers ")
            txtSQL.Append(m_strNatureOfDemandID)
            txtSQL.Append(" ,  '")
            txtSQL.Append(m_strRequeststageID)
            txtSQL.Append("' ,  '")
            txtSQL.Append(strStakeHolders)
            txtSQL.Append("' ,N'")
            txtSQL.Append(Session("strUserName"))
            txtSQL.Append("'")
            strSQL = txtSQL.ToString

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ' Clean up Memory 
            txtSQL = Nothing
        End If

        ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
        ' Purpose : To insert stages for Stages at Project level
        ' Start_MV_29-April-2008
        'Comment and modification by SuchitraP on 16 July 2008 for CRM Workflow stages
        'If m_StrMode.ToUpper() = "PROJECT_STAGE" And m_strAction.ToUpper() = "SAVE" Then
        If (m_StrMode.ToUpper() = "PROJECT_STAGE" And m_strAction.ToUpper() = "SAVE") Or (m_StrMode.ToUpper() = "CRM_PROJECT_STAGE" And m_strAction.ToUpper() = "SAVE") Then
            'End of modification by SuchitraP

            ''strOrderNumber = HttpContext.Current.Request.Form("txtOrderNo").Split(","c)
            strSelectedStage = HttpContext.Current.Request.Form("chkSelect").Split(","c)
            '''strCompletionDays = HttpContext.Current.Request.Form("txtCompletionDays").Split(","c)
            strSelectedStageStageValue = HttpContext.Current.Request.Form("chkSelect")

            For intCounter = 0 To strSelectedStage.Length - 1

                strOrderNumberValue = strOrderNumberValue + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtOrderNo" + CStr(strSelectedStage(intCounter))), "0") + ","
                '---- Commented By Purvaj on 15 Sept 2008 Days for completion and Enablesavelink columns removed
                'strCompletionDaysValue = strCompletionDaysValue + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("txtCompletionDays" + CStr(strSelectedStage(intCounter))), "0") + ","
                strCompletionDaysValue = strCompletionDaysValue + "0,"
                '----End Commented By Purvaj on 15 Sept 2008 Days for completion and Enablesavelink columns removed
                strCheckListValue = strCheckListValue + CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("cboCheckList" + CStr(strSelectedStage(intCounter))), "0") + ","
                'If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkETL" + CStr(strSelectedStage(intCounter))), "0")) = "" Then
                '    strChkETLvalue = strChkETLvalue + "1" + ","
                'Else
                '    strChkETLvalue = strChkETLvalue + "0" + ","
                'End If
                'If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkEOHL" + CStr(strSelectedStage(intCounter))), "0")) = "" Then
                '    strChkEOHLvalue = strChkEOHLvalue + "1" + ","
                'Else
                '    strChkEOHLvalue = strChkEOHLvalue + "0" + ","
                'End If
                'If CStr(CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkESL" + CStr(strSelectedStage(intCounter))), "0")) = "" Then
                '    strChkESLvalue = strChkESLvalue + "1" + ","
                'Else
                '    strChkESLvalue = strChkESLvalue + "0" + ","
                'End If
            Next

            ' Remove last Comma 
            strOrderNumberValue = strOrderNumberValue.Substring(0, strOrderNumberValue.Length - 1)
            strCompletionDaysValue = strCompletionDaysValue.Substring(0, strCompletionDaysValue.Length - 1)
            strCheckListValue = strCheckListValue.Substring(0, strCheckListValue.Length - 1)
            'strChkETLvalue = strChkETLvalue.Substring(0, strChkETLvalue.Length - 1)
            'strChkEOHLvalue = strChkEOHLvalue.Substring(0, strChkEOHLvalue.Length - 1)
            'strChkESLvalue = strChkESLvalue.Substring(0, strChkESLvalue.Length - 1)

            If strOrderNumberValue <> "" Then
                txtSQL = New System.Text.StringBuilder
                txtSQL.Append("usp_Ins_tbl_IM_ProjectNatureOfDemand_Stage ")
                txtSQL.Append(m_strNatureOfDemandID)
                txtSQL.Append(" , '")
                txtSQL.Append(strSelectedStageStageValue)
                txtSQL.Append("' , N'")
                txtSQL.Append(strOrderNumberValue)
                txtSQL.Append("' , N'")
                txtSQL.Append(strCheckListValue)
                txtSQL.Append("' , N'")
                txtSQL.Append(strCompletionDaysValue)
                txtSQL.Append("'")
                'txtSQL.Append(",'" + strChkESLvalue + "'")
                'txtSQL.Append(",'" + strChkETLvalue + "'")
                'txtSQL.Append(",'" + strChkEOHLvalue + "'")
                txtSQL.Append(" , N'")
                txtSQL.Append(Session("strUserName"))
                txtSQL.Append("'")

                strSQL = txtSQL.ToString

                CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                txtSQL = Nothing
            End If
        End If
        ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
        ' Purpose : To insert Stakeholder and Approvers at Project level
        ' Start_MV_29-April-2008
        If m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" And m_strAction.ToUpper() = "SAVE" Then
            Dim strStakeHolders As String = m_strPKIDList 'HttpContext.Current.Request.Form("chkSelect")
            Dim strCheckList As String = ""
            'Dim strStakeHolder As String
            'Dim strChecklistID As String
            Dim strDefaultApprover As String = ""

            txtSQL = New System.Text.StringBuilder

            strSQL = ""
            txtSQL.Append(" usp_INS_UPD_tbl_IM_ProjectNatureOfDemand_StageDetails ")
            txtSQL.Append(m_strNatureOfDemandID)
            txtSQL.Append(" ,  '")
            txtSQL.Append(m_strRequeststageID)
            txtSQL.Append("' ,  '")
            txtSQL.Append(strStakeHolders)
            txtSQL.Append("' , N'")
            txtSQL.Append(strCheckList)
            txtSQL.Append("' , N'")
            ' Added Column DefaultApprover 
            txtSQL.Append(strDefaultApprover)
            txtSQL.Append("' , N'")
            txtSQL.Append(Session("strUserName"))
            txtSQL.Append("' , '")
            txtSQL.Append(Session("intUserID"))
            txtSQL.Append("'")
            strSQL = txtSQL.ToString

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ' Clean up Memory 
            txtSQL = Nothing
        End If
        If m_StrMode.ToUpper() = "PROJECT_APPROVER" And m_strAction.ToUpper() = "SAVE" Then
            Dim strStakeHolders As String = m_strPKIDList 'HttpContext.Current.Request.Form("chkSelect")
            Dim strCheckList As String = ""
            'Dim strStakeHolder As String
            'Dim strChecklistID As String
            Dim strDefaultApprover As String = ""

            txtSQL = New System.Text.StringBuilder

            strSQL = ""
            txtSQL.Append(" usp_INS_UPD_tbl_IM_ProjectApproversNatureOfDemand_StageDetails ")
            txtSQL.Append(m_strNatureOfDemandID)
            txtSQL.Append(" ,  '")
            txtSQL.Append(m_strRequeststageID)
            txtSQL.Append("' ,  '")
            txtSQL.Append(strStakeHolders)
            txtSQL.Append("' ,N'")
            txtSQL.Append(Session("strUserName"))
            txtSQL.Append("'")
            strSQL = txtSQL.ToString

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ' Clean up Memory 
            txtSQL = Nothing
        End If

        ' End_MV_29-April-2008

        '------- Added By PurvaJ on 8 May 2008 for Project Owners
        If m_StrMode.ToUpper() = "PROJECT_OWNER" And m_strAction.ToUpper() = "SAVE" Then
            Dim strStakeHolders As String = m_strPKIDList 'HttpContext.Current.Request.Form("chkSelect")
            Dim strCheckList As String = ""
            'Dim strStakeHolder As String
            'Dim strChecklistID As String
            Dim strDefaultApprover As String = ""

            txtSQL = New System.Text.StringBuilder

            strSQL = ""
            txtSQL.Append(" usp_INS_UPD_tbl_IM_ProjectNatureofDemandOwners ")
            txtSQL.Append(m_strNatureOfDemandID)
            txtSQL.Append(" ,  '")
            txtSQL.Append(strStakeHolders)
            txtSQL.Append("' ,N'")
            txtSQL.Append(Session("strUserName"))
            txtSQL.Append("'")
            strSQL = txtSQL.ToString

            CommonFunction.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

            ' Clean up Memory 
            txtSQL = Nothing
        End If
        '-------- End ADddition PurvaJ

        ' Added By MahendraV On 29-April-2008 for WhizibleSEM8.0
        ' Purpose : To Refresh parent at Project level
        ' Start_MV_29-April-2008
        ' Refresh PArent Page
        If m_StrMode.ToUpper() = "PROJECT_STAGE" Or m_StrMode.ToUpper() = "PROJECT_STAKEHOLDER" Or m_StrMode.ToUpper() = "PROJECT_APPROVER" Or m_StrMode.ToUpper() = "PROJECT_OWNER" Then
            'Added by SuchitraP on 4-Aug-2008 for CRM Workflow
            If m_strTagID <> "" Then
                Response.Write(vbCrLf + "<Script language=javascript>")
                'Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?ProjectNatureofDemandID_PK=" + m_strNatureOfDemandID + "&MasterTagID=20024&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
                Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?ProjectNatureofDemandID_PK=" + m_strNatureOfDemandID + "&MasterTagID=8036&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
                Response.Write(" window.close();")
                Response.Write(vbCrLf + "</Script>")
            Else
                Response.Write(vbCrLf + "<Script language=javascript>")
                Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?ProjectNatureofDemandID_PK=" + m_strNatureOfDemandID + "&MasterTagID=3934&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
                Response.Write(" window.close();")
                Response.Write(vbCrLf + "</Script>")
            End If
            'Addition by SuchitraP on 16 July 2008 for CRM Workflow Stages
        ElseIf m_StrMode.ToUpper() = "CRM_PROJECT_STAGE" Then
            Response.Write(vbCrLf + "<Script language=javascript>")
            'Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?ProjectNatureofDemandID_PK=" + m_strNatureOfDemandID + "&MasterTagID=20024&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
            Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?ProjectNatureofDemandID_PK=" + m_strNatureOfDemandID + "&MasterTagID=8036&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
            Response.Write(" window.close();")
            Response.Write(vbCrLf + "</Script>")
            'End by SuchitraP
        Else
            ' End_MV_29-April-2008
            If CommonFunction.General.CheckIsNothing(Request.Form("txtFromWhere"), "").ToUpper = "WORKFLOW" Then
                'm_strAttributeID
                Response.Write(vbCrLf + "<Script language=javascript>")
                Response.Write(vbCrLf + "   refreshParent('frm_DM_InitiativeDetails','DM_InitiativeDetails.aspx','../DM/DM_InitiativeDetails.aspx?Fromwhere=WORKFLOW&TagID=" + m_strAttributeID.ToString + "&NatureofdemandID=" + m_strNatureOfDemandID + "&MasterTagID=3928&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
                Response.Write(" window.close();")
                Response.Write(vbCrLf + "</Script>")
            Else
                Response.Write(vbCrLf + "<Script language=javascript>")
                Response.Write(vbCrLf + "   refreshParent('frmCommonPage','DemandTypes_CommonPage.aspx','DemandTypes_CommonPage.aspx?NatureofDemandID_PK=" + m_strNatureOfDemandID + "&MasterTagID=3928&FromWhere=DM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1');")
                'Commented By Usha Pandit On 13.05.2020 For not closing popup on selecting approvers
                'Response.Write(" window.close();")
                'End Of Commented By Usha Pandit On 13.05.2020 For not closing popup on selecting approvers
                Response.Write(vbCrLf + "</Script>")
            End If


        End If

            strSQL = Nothing


            Dim objWorkFlowHashTable As New WorkFlowCommonEngine.HashTables.CreateProcessDefinationHashTables
            objWorkFlowHashTable.CreateProcessMasterHashTable("C6FCF802-8FB7-49DB-A4D2-1EB521BBEE84")
            objWorkFlowHashTable = Nothing
    End Sub

    Private Sub GetGlobalObject()
        '====================================================================
        ' Procedure Name        :  GetGlobalObject
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To get an instance of the global object
        ' Description           :  This sub-routine fills the global object and 
        '                          gets the Tag ID
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngTagId = m_objGlobal.TagID
    End Sub

    Private Sub drawCorporateAlternateApproverGrid()
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"", "", "", "", "align=left", "align=center width=10%"}
        ' Dim arrColRowLinks() As String = {"", "onchange='SetProjectApprover_OnClick(this)'"}
        Dim arrCheckBoxIDs() As String = {"", "", "", "", "", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", "", "", "", "", "Selected"}
        Dim arrGroupOnColumn() As String = {"1", "", "", "", "", ""}
        '' Set EmployeeID to 0 if not found so that no error occurs.
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        txtSQLQuery.Append("usp_Sel_Tbl_IM_NatureOfDemand_Approvers ")
        txtSQLQuery.Append(m_strNatureOfDemandStageID)
        If m_strROLID <> "" Then
            txtSQLQuery.Append("," + m_strROLID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        If m_strBGID <> "" Then
            txtSQLQuery.Append("," + m_strBGID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        If m_strOUID <> "" Then
            txtSQLQuery.Append("," + m_strOUID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        txtSQLQuery.Append(",N'" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'")

        'Added by GaneshD on 07 Sep 2009 to remove crash where approver has single quote.
        m_strApprover = m_strApprover.Replace("'", "''")
        'Ended by GaneshD

        txtSQLQuery.Append(",'" + m_strApprover.ToString + "'")

        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Role")
        arrColumnHeadingList.Add("Employee Name")
        arrColumnHeadingList.Add("User Name")
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_FILTERHEADER_BG"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_FILTERHEADER_OU"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("RoleDescription")
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("UserName")
        arrActualColumnNames.Add("BusinessGroup")
        arrActualColumnNames.Add("Location")
        arrActualColumnNames.Add("")

        With m_objstakeholderGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            '.RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .GroupOnColumn = arrGroupOnColumn
            .NoOfDataColumns = arrActualColumnNames.Count - 1
            .PrimaryKey = "EmployeeID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .StaticHeaderStyle = STATIC_HEADER_STYLE.DISABLED
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory
        m_objstakeholderGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        'arrColRowLinks = Nothing
    End Sub
    Public Sub drawCRMStageGrid()
        '====================================================================
        ' Procedure Name        :  drawStageGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stage selection 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  SuchitraP
        ' Created               :  16-July-2008
        ' Revisions             :  
        '=====================================================================
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"align=left", "align=center", "align=center", "align=center", "align=center"}
        Dim arrCheckBoxIDs() As String = {"", "", "", "chkSelect"}
        Dim arrdisabledCheckbox() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        strSQLQuery = "usp_Sel_tbl_IM_ProjectNatureOfDemand_Stage " + m_strNatureOfDemandID.ToString

        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_STAGE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ORDERNO"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_CHECKLIST"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_DAYS_TO_COMPLATE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("RequestStage")
        arrActualColumnNames.Add("OrderNo")
        arrActualColumnNames.Add("CheckListID")
        arrActualColumnNames.Add("CompletionDays")
        arrActualColumnNames.Add("")

        With m_objstageGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Count - 1
            .PrimaryKey = "RequestStageID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
            .CheckboxDisableOnColumnArray = arrdisabledCheckbox
        End With

        m_objstageGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
    End Sub
    Public Sub drawProjectStageGrid()
        '====================================================================
        ' Procedure Name        :  drawStageGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stage selection 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  29-April-2008
        ' Revisions             :  
        '=====================================================================
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"align=center", "align=center", "align=left", "align=center", "align=center"}
        ' Dim arrColRowLinks() As String = {"ProjectCurrentInitiative(ProjectNatureOfDemandID,RequestStageID)", "", "", ""}
        Dim arrCheckBoxIDs() As String = {"chkSelect", "", "", ""}
        Dim arrdisabledCheckbox() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        '' Set EmployeeID to 0 if not found so that no error occurs.

        txtSQLQuery.Append("usp_Sel_tbl_IM_ProjectNatureOfDemand_Stage ")
        txtSQLQuery.Append(m_strNatureOfDemandID)
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ORDERNO"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_STAGE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_CHECKLIST"))

        'arrColumnHeadingList.Add(MyBase.GetResourceString("COL_DAYS_TO_COMPLATE"))
        'arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ESL"))

        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ETL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_EOHL"))


        arrActualColumnNames.Add("")
        arrActualColumnNames.Add("OrderNo")
        arrActualColumnNames.Add("RequestStage")
        arrActualColumnNames.Add("CheckListID")

        'arrActualColumnNames.Add("CompletionDays")
        'arrActualColumnNames.Add("EnableSaveLink")

        arrActualColumnNames.Add("EnableTimesheetLink")
        arrActualColumnNames.Add("EnableOnHoldLink")


        With m_objstageGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Count - 1
            .PrimaryKey = "RequestStageID"
            .TDStyleArray = arrWidthArray
            ''.RowLinkArray = arrColRowLinks
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
            .CheckboxDisableOnColumnArray = arrdisabledCheckbox
        End With

        ' Clear Memory
        m_objstageGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        ' arrColRowLinks = Nothing

    End Sub

    Public Sub drawProjectOwnerGrid()
        '====================================================================
        ' Procedure Name        :  DrawProjectApproverGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for project approver selection 
        ' Description           :  This sub-routine draws the grid for Stake holder selection 
        ' Assumptions           :  None
        ' Dependencies          :  None 
        ' Author                :  MahendraV
        ' Created               : 29-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"", "", "", "", "align=left", "align=center width=10%"}
        ' Dim arrColRowLinks() As String = {"", "onchange='SetProjectApprover_OnClick(this)'"}
        Dim arrCheckBoxIDs() As String = {"", "", "", "", "", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", "", "", "", "", "Selected"}
        Dim arrGroupOnColumn() As String = {"1", "", "", "", "", ""}
        '' Set EmployeeID to 0 if not found so that no error occurs.
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        txtSQLQuery.Append("usp_sel_tbl_IM_ProjectNatureofDemandOwners ")
        txtSQLQuery.Append(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), -1))
        txtSQLQuery.Append(",")
        txtSQLQuery.Append(m_strNatureOfDemandID)
        If m_strROLID <> "" Then
            txtSQLQuery.Append("," + m_strROLID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        If m_strBGID <> "" Then
            txtSQLQuery.Append("," + m_strBGID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        If m_strOUID <> "" Then
            txtSQLQuery.Append("," + m_strOUID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        txtSQLQuery.Append(",N'" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'")

        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Role")
        arrColumnHeadingList.Add("Employee Name")
        arrColumnHeadingList.Add("User Name")
        arrColumnHeadingList.Add("Business Group")
        arrColumnHeadingList.Add("Organization Unit")
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("RoleDescription")
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("UserName")
        arrActualColumnNames.Add("BusinessGroup")
        arrActualColumnNames.Add("Location")
        arrActualColumnNames.Add("")

        With m_objstakeholderGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            '.RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .GroupOnColumn = arrGroupOnColumn
            .NoOfDataColumns = arrActualColumnNames.Count - 1
            .PrimaryKey = "EmployeeID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .StaticHeaderStyle = STATIC_HEADER_STYLE.DISABLED
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory
        m_objstakeholderGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        'arrColRowLinks = Nothing
    End Sub
    Public Sub drawStageGrid()
        '====================================================================
        ' Procedure Name        :  drawStageGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stage selection 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  
        ' Created               : 
        ' Revisions             :  
        '=====================================================================
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        '-- Commented By Purvaj on 15 Sept 2008 Days for completion and enable save link columns removed.
        'Dim arrWidthArray() As String = {"align=left", "align=center", "align=center", "align=center", "align=center", "align=center", "align=center"}
        'Dim arrColRowLinks() As String = {"CurrentInitiative(NatureOfDemandID,RequestStageID)", "", "", "", "", "", ""}
        'Dim arrCheckBoxIDs() As String = {"", "", "", "", "", "", "chkSelect"}
        '-- End Commented By Purvaj on 15 Sept 2008
        Dim arrWidthArray() As String = {"align=center", "align=center", "align=left", "align=center", "align=center"}
        Dim arrColRowLinks() As String = {"", "", "CurrentInitiative(NatureOfDemandID,RequestStageID)", "", ""}
        Dim arrCheckBoxIDs() As String = {"chkSelect", "", "", "", ""}

        Dim arrdisabledCheckbox() As String = {"1"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        '' Set EmployeeID to 0 if not found so that no error occurs.

        txtSQLQuery.Append("usp_Sel_tbl_IM_NatureOfDemand_Stage ")
        txtSQLQuery.Append(m_strNatureOfDemandID)
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ORDERNO"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_STAGE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_CHECKLIST"))

        '-- Commented By Purvaj on 15 Sept 2008 Days for completion and enable save link columns removed.
        'arrColumnHeadingList.Add(MyBase.GetResourceString("COL_DAYS_TO_COMPLATE"))
        'arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ESL"))
        '--End Commented By Purvaj on 15 Sept 2008 Days for completion and enable save link columns removed.

        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ETL"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_EOHL"))

        arrActualColumnNames.Add("")
        arrActualColumnNames.Add("OrderNo")
        arrActualColumnNames.Add("RequestStage")
        arrActualColumnNames.Add("CheckListID")

        '-- Commented By Purvaj on 15 Sept 2008 Days for completion and enable save link columns removed.
        'arrActualColumnNames.Add("CompletionDays")
        'arrActualColumnNames.Add("EnableSaveLink")
        '-- Commented By Purvaj on 15 Sept 2008 Days for completion and enable save link columns removed.

        arrActualColumnNames.Add("EnableTimesheetLink")
        arrActualColumnNames.Add("EnableOnHoldLink")


        With m_objstageGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = arrActualColumnNames.Count - 1 '2
            .PrimaryKey = "RequestStageID"
            .TDStyleArray = arrWidthArray
            '.RowLinkArray = arrColRowLinks
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
            .CheckboxDisableOnColumnArray = arrdisabledCheckbox
        End With

        ' Clear Memory
        m_objstageGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        arrColRowLinks = Nothing

    End Sub


    Public Sub drawPendingInitiatives()
        '====================================================================
        ' Procedure Name        :  drawPendingInitiatives
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for list of pending Initiatives for the selected stage and Nature of Initaitive 
        ' Description           :  This sub-routine draws the grid for Stage selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  
        ' Created               :  
        ' Revisions             :  
        '=====================================================================
        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left"}
        Dim arrColRowLinks() As String = {""}
        Dim arrCheckBoxIDs() As String = {""}
        Dim arrIgnoreHTMLEncode() As String = {"0"}


        ' Draw Header Table 

        txtSQLQuery.Append("usp_Sel_tbl_IM_NatureOfDemand_StageInitiatives ")
        txtSQLQuery.Append(m_strNatureOfDemandID)
        txtSQLQuery.Append(",")
        txtSQLQuery.Append(m_strRequeststageID)
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_INITIATIVETITLE"))

        arrActualColumnNames.Add("Title")

        With m_objstageGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            .NoOfDataColumns = 1
            .PrimaryKey = "IdeaID"
            .TDStyleArray = arrWidthArray
            .RowLinkArray = arrColRowLinks
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 250
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory

        m_objstageGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        arrColRowLinks = Nothing

    End Sub

    Public Sub DrawProjectStakeHolderGrid()
        '====================================================================
        ' Procedure Name        :  DrawProjectStakeHolderGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stake holder selection 
        ' Description           :  This sub-routine draws the grid for Stake holder selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               : 29-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"align=left", "align=center width=10%"}
        ' Dim arrColRowLinks() As String = {"", "onchange='SetProjectStakeholder_OnClick(this)'"}
        Dim arrCheckBoxIDs() As String = {"", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", "Selected"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        m_strApprover = CommonFunction.General.CheckIsNothing(Request.Form("txtApprover"), "").ToString



        '' Set EmployeeID to 0 if not found so that no error occurs.


        txtSQLQuery.Append("usp_Sel_tbl_IM_ProjectNatureOfDemand_Stage_stakeHolders ")
        txtSQLQuery.Append(m_strNatureOfDemandStageID)
        txtSQLQuery.Append(",N'" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'")
        'Added by GaneshD on 07 Sep 2009 to remove crash where approver has single quote.
        m_strApprover = m_strApprover.Replace("'", "''''")
        'Ended by GaneshD
        txtSQLQuery.Append(",'" & CommonFunctions.General.BuildQueryString(m_strApprover) & "'")
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ROLE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("Role")
        arrActualColumnNames.Add("")

        With m_objstakeholderGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .NoOfDataColumns = 1
            .PrimaryKey = "RoleID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory
        m_objstakeholderGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        ' arrColRowLinks = Nothing


    End Sub

    Public Sub DrawProjectApproverGrid()
        '====================================================================
        ' Procedure Name        :  DrawProjectApproverGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for project approver selection 
        ' Description           :  This sub-routine draws the grid for Stake holder selection 
        ' Assumptions           :  None
        ' Dependencies          :  None 
        ' Author                :  MahendraV
        ' Created               : 29-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        'To store the link details while clicking on Links in grid
        Dim arrWidthArray() As String = {"", "", "", "", "align=left", "align=center width=10%"}
        ' Dim arrColRowLinks() As String = {"", "onchange='SetProjectApprover_OnClick(this)'"}
        Dim arrCheckBoxIDs() As String = {"", "", "", "", "", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", "", "", "", "", "Selected"}
        Dim arrGroupOnColumn() As String = {"1", "", "", "", "", ""}
        '' Set EmployeeID to 0 if not found so that no error occurs.
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        txtSQLQuery.Append("usp_Sel_Tbl_IM_ProjectNatureOfDemand_StageDetails ")
        txtSQLQuery.Append(CommonFunction.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), -1))
        txtSQLQuery.Append(",")
        txtSQLQuery.Append(m_strNatureOfDemandStageID)
        If m_strROLID <> "" Then
            txtSQLQuery.Append("," + m_strROLID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        If m_strBGID <> "" Then
            txtSQLQuery.Append("," + m_strBGID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        If m_strOUID <> "" Then
            txtSQLQuery.Append("," + m_strOUID)
        Else
            txtSQLQuery.Append(",NULL")
        End If
        txtSQLQuery.Append(",N'" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'")

        'Added by ShraddhM on 24,Aug 2009 to remove crash where approver has single quote.
        m_strApprover = m_strApprover.Replace("'", "''")
        'Ended by ShraddhaM
        txtSQLQuery.Append(",'" + m_strApprover.ToString + "'")

        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add("Role")
        arrColumnHeadingList.Add("Employee Name")
        arrColumnHeadingList.Add("User Name")
        arrColumnHeadingList.Add("Business Group")
        arrColumnHeadingList.Add("Organization Unit")
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("RoleDescription")
        arrActualColumnNames.Add("EmployeeName")
        arrActualColumnNames.Add("UserName")
        arrActualColumnNames.Add("BusinessGroup")
        arrActualColumnNames.Add("Location")
        arrActualColumnNames.Add("")

        With m_objstakeholderGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            '.RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs
            .GroupOnColumn = arrGroupOnColumn
            .NoOfDataColumns = arrActualColumnNames.Count - 1
            .PrimaryKey = "EmployeeID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .StaticHeaderStyle = STATIC_HEADER_STYLE.DISABLED
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With

        ' Clear Memory
        m_objstakeholderGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        'arrColRowLinks = Nothing


    End Sub
    Public Sub DrawStakeHolder_Grid()
        '====================================================================
        ' Procedure Name        :  DrawStakeHolder_Grid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the grid for Stake holder selection 
        ' Description           :  This sub-routine draws the grid for Stake holder selection 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  
        ' Created               : 
        ' Revisions             :  
        '=====================================================================

        Dim txtSQLQuery As New System.Text.StringBuilder
        Dim strSQLQuery As String
        Dim arrColumnHeadingList As New ArrayList       'To store the column Headings
        Dim arrActualColumnNames As New ArrayList
        Dim arrWidthArray() As String = {"align=left", "align=center width=10%"}
        Dim arrCheckBoxIDs() As String = {"", "chkSelect"}
        Dim arrSelectedCheckBoxIDs() As String = {"", "Selected"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}




        '' Set EmployeeID to 0 if not found so that no error occurs.
        txtSQLQuery.Append("usp_Sel_tbl_IM_NatureOfDemand_Stage_stakeHolders ")
        txtSQLQuery.Append(m_strNatureOfDemandStageID)
        txtSQLQuery.Append(",N'" & CommonFunctions.General.BuildQueryString(m_strPageNumber) & "'")
        'Added by GaneshD on 07 Sep 2009 to remove crash where approver has single quote.
        m_strApprover = m_strApprover.Replace("'", "''''")
        'Ended by GaneshD
        txtSQLQuery.Append(",'" & CommonFunctions.General.BuildQueryString(m_strApprover) & "'")
        strSQLQuery = txtSQLQuery.ToString
        txtSQLQuery = Nothing

        ''Plots the Table for Daily Activity.
        ''-------------------------------------------------------------------
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_ROLE"))
        arrColumnHeadingList.Add(MyBase.GetResourceString("COL_SELECT"))

        arrActualColumnNames.Add("Role")
        arrActualColumnNames.Add("")

        With m_objstakeholderGrid
            .ActualColumnArray = GetArray(arrActualColumnNames)
            .UserFriendlyColumnArray = GetArray(arrColumnHeadingList)
            .CheckBoxIDArray = arrCheckBoxIDs
            ' .RowLinkArray = arrColRowLinks
            .CheckboxCheckOnColumnArray = arrSelectedCheckBoxIDs

            .NoOfDataColumns = 1
            '.GroupOnColumn = arrGroupOn
            .PrimaryKey = "RoleID"
            .TDStyleArray = arrWidthArray
            .DIVStyle = "overflow:none"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 275
            .DIVStyle = "overflow:auto"
            .SQL = strSQLQuery
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With



        ' Clear Memory
        m_objstakeholderGrid = Nothing
        arrActualColumnNames = Nothing
        arrColumnHeadingList = Nothing
        arrWidthArray = Nothing
        ' arrColRowLinks = Nothing


    End Sub
#End Region

    Private Function GetArray(ByVal arrList As ArrayList) As String()
        '=====================================================================
        ' Procedure Name        : GetArray()	
        ' Purpose               : Generic function to get the array from the ArrayList.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : System.Array (String())
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : 
        ' Created               : 
        ' Revisions             :
        '=====================================================================
        Dim arrElements(arrList.Count - 1) As String
        arrList.ToArray.CopyTo(arrElements, 0)
        Return arrElements

    End Function

    Public Sub New()
        ' Added By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        'MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        MyBase.InitializeResources("AppResources.DM_NatureOfDemand_Stage", "AppResources")
    End Sub
#Region "Grid Events"
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objstageGrid.DataRowTD_BeforePrint
        Dim blnIsReadOnly As Boolean = True
        Dim strDisabled As String = "disabled"
        Dim strRequestStageID As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RequestStageID"), 0), String)

        If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Selected"), 0), Integer) = 1 Then
            blnIsReadOnly = False
            strDisabled = ""
        End If

        If Args.DataField.ToUpper = "CHECKLISTID" Then


            Cancel = True
            Args.ApplyHTMLEncode = True
            Dim strCheckListID As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataFieldValue, ""), String)

            Args.StringToBeInserted = "<TD   align=Center >" + vbCrLf
            '+ Args.DataReader("NatureOfDemandStageID").ToString
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawComboBox("cboCheckList" + strRequestStageID, "usp_sel_tbl_Q_Questionnaire", 300, strCheckListID, strDisabled, True, True)
            Args.StringToBeInserted += "</TD>"

        End If
        If Args.DataField.ToUpper = "ORDERNO" Then
            Cancel = True
            Dim strOrderNo As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataFieldValue, ""), String)

            Args.StringToBeInserted = "<TD   align=Center >" + vbCrLf
            If m_StrMode = "PROJECT_STAGE" Then
                'Modified By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtOrderNo" + strRequestStageID, "txtOrderNo" + strRequestStageID, , 30, 2, IIf(Args.DataReader("SELECTED") = 3 Or Args.DataReader("SELECTED") = 4, "", strOrderNo), "right", , IIf(Args.DataReader("SELECTED") = 0 Or Args.DataReader("SELECTED") = 3 Or Args.DataReader("SELECTED") = 4 Or Args.DataReader("Used") = 1 Or Args.DataReader("SELECTED") = 1, True, False), returnHTML:=True, EnableHTMLEncode:=True)
            Else
                Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtOrderNo" + strRequestStageID, "txtOrderNo" + strRequestStageID, , 30, 2, IIf(Args.DataReader("SELECTED") = 3 Or Args.DataReader("SELECTED") = 4, "", strOrderNo), "right", , IIf(Args.DataReader("SELECTED") = 0 Or Args.DataReader("SELECTED") = 3 Or Args.DataReader("SELECTED") = 4 Or Args.DataReader("Used") = 1, True, False), blnIsReadOnly, , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            End If
            '
            Args.StringToBeInserted += "</TD>"
        End If

        If Args.DataField.ToUpper = "COMPLETIONDAYS" Then
            Cancel = True
            Dim strCompletionDays As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataFieldValue, ""), String)
            Args.StringToBeInserted = "<TD   align=Center >" + vbCrLf
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawTextBox("txtCompletionDays" + strRequestStageID, "txtCompletionDays" + strRequestStageID, , 30, 2, strCompletionDays, "right", , , blnIsReadOnly, , , , True, EnableHTMLEncode:=True)
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            Args.StringToBeInserted += "</TD>"
        End If
        If Args.ColumnName = MyBase.GetResourceString("COL_SELECT") Then
            Dim blnCC As Boolean
            Dim blnCD As Boolean

            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Selected"), "0"), Integer) = 0 Or _
                CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Selected"), "0"), Integer) = 3 Or _
            CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Selected"), "0"), Integer) = 4 Then
                blnCC = True
                blnCD = True
            End If

            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Selected"), "0"), Integer) = 1 Then
                blnCC = True

            End If

            If m_StrMode = "PROJECT_STAGE" Then
                blnCD = True
            End If

            If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Used"), "0"), Integer) = 1 Then
                blnCD = True
            End If

            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnCC, strRequestStageID, blnCD, " onclick=javascript:chkRS_OnClick(this)", True) + "</td>"
            Cancel = True

        End If

        If m_StrMode = "PROJECT_STAGE" Then
            strDisabled = "disabled"
        End If

        If Args.DataField.ToUpper.Trim = "ENABLETIMESHEETLINK" Then
            If CType(Args.DataReader("AttributeID"), Long) = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING Then
                Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkETL" + strRequestStageID, "chkETL" + strRequestStageID, , IIf(CBool(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EnableTimesheetLink"), "0")), True, False), , IIf(CBool(strDisabled = ""), False, True), , True) + "</td>"
            End If
            Cancel = True
        End If
        If Args.DataField.ToUpper.Trim = "ENABLEONHOLDLINK" Then
            If CType(Args.DataReader("AttributeID"), Long) = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING Then
                Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkEOHL" + strRequestStageID, "chkEOHL" + strRequestStageID, , IIf(CBool(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EnableOnHoldLink"), "0")), True, False), , IIf(CBool(strDisabled = ""), False, True), , True) + "</td>"
            End If
            Cancel = True
        End If
        If Args.DataField.ToUpper.Trim = "ENABLESAVELINK" Then
            'If CType(Args.DataReader("AttributeID"), Long) = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING Then
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkESL" + strRequestStageID, "chkESL" + strRequestStageID, , IIf(CBool(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EnableSaveLink"), "0")), True, False), , IIf(CBool(strDisabled = ""), False, True), , True) + "</td>"
            'End If
        Cancel = True
        End If
    End Sub

    Private Sub m_objstakeholderGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objstakeholderGrid.DataRowTD_BeforePrint
        Dim blnChecked As Boolean = False

        If Args.DataField.ToUpper = "CHECKLISTID" Then

            Cancel = True
            Dim strCheckListID As String = CType(CommonFunction.Data.CheckIsDBNull(Args.DataFieldValue, ""), String)
            Dim strDisabled As String = ""



            Args.StringToBeInserted = "<TD   align=Center >" + vbCrLf
            Args.StringToBeInserted += CommonFunction.HTMLControls.DrawComboBox("cboCheckList", "usp_sel_tbl_Q_Questionnaire", 300, strCheckListID, strDisabled, True, True)
            Args.StringToBeInserted += "</TD>"

        End If
        If Args.ColumnName.ToUpper = MyBase.GetResourceString("COL_SELECT").ToUpper Then
            Dim strPrimaryKeyValue As String = ""

            Select Case m_StrMode.ToUpper
                Case "STAKEHOLDER", "PROJECT_STAKEHOLDER"
                    strPrimaryKeyValue = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("RoleID"), ""), String)
                   
                Case "PROJECT_APPROVER", "PROJECT_OWNER", "CORPORATE_APPROVER"
                    strPrimaryKeyValue = CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("EmployeeID"), ""), String)
            End Select
            If Not IsPostBack Then
                If CType(CommonFunction.Data.CheckIsDBNull(Args.DataReader("Selected"), ""), Boolean) Then
                    If m_strPKIDList = "" Then
                        m_strPKIDList = ","
                    End If
                    m_strPKIDList = m_strPKIDList + strPrimaryKeyValue + ","
                    blnChecked = True
                End If
            Else
                If m_strPKIDList.IndexOf("," + strPrimaryKeyValue.Trim + ",") <> -1 Then
                    blnChecked = True
                End If
            End If
            Args.StringToBeInserted = "<td align=center>" + CommonFunctions.HTMLControls.DrawCheckBox("chkSelect", "chkSelect", , blnChecked, strPrimaryKeyValue, , " onclick=javascript:chkSelect_OnClick(this)", True) + "</td>"
            Cancel = True
        End If
    End Sub
#End Region

    Private Sub m_objstakeholderGrid_Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_Grid) Handles m_objstakeholderGrid.Initialize
        ' Args.StaticHeaderStyle = STATIC_HEADER_STYLE.DISABLED
    End Sub


    Private Sub m_objstageGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objstageGrid.ColumnHeaderTD_BeforePrint
        If m_strAttributeID <> CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING.ToString Then
            If Args.DataField.ToUpper.Trim = "ENABLETIMESHEETLINK" Or Args.DataField.ToUpper.Trim = "ENABLEONHOLDLINK" Then
                Cancel = True
            End If
        End If
    End Sub

End Class
