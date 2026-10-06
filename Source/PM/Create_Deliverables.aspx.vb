#Region "Imports"
Imports WebPages.Template
Imports CommonFunctions
Imports CommonFunctions.HTMLControls
#End Region


Public Class Create_Deliverables
    Inherits WebPages.Template.WhizTemplate

    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Protected m_strWindowTitle As String
    Protected m_strAction As String = ""
    Protected m_strMode As String = ""
    Protected m_strObjArray As String
    Protected m_strObj_captions As String
    Protected arrActualColumns() As String
    Protected m_strFromWhere As String
    Protected strScheduleID As String
    Protected m_intProjectID As Integer
    Protected m_intFunctionID As Integer
    Protected strProjectID As String
    'added by harshada d on 06 Feb 2006 for Helpdesk
    Protected m_intChangeRequestID As Integer
    Protected m_intIssueID As Integer
    Protected m_intQueryID As Integer
    Protected m_blnCodeTempleteEditable As Boolean = False
    Protected m_lngEstimatedEfforts As Long
    Protected StrTitleList As String
    Protected StrCodeTemplate As String
    Protected intScheduleID As Long
    Public m_strProjectsOnHold As String
	Protected strOnloadClientScript As String
    'end of addition by harshada d on 06 Feb 2006 for Helpdesk
    'Protected strScheduleID As String
    Protected m_lngQueryID As String
    Protected m_TokenKEY As String
    Protected m_PKToken_FromDT As String = ""
    '' START : Modified BY ParagD On 5-Sept-2006
    '' Purpose : Whizible SP7 Issue : To persist ShowToCustomer flag for Issue
    Protected m_ShowToCustomer As String
    '' END : Modified BY ParagD On 5-Sept-2006

    'Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_strIssueID As String
    Protected m_PKToken As String
    'End of Added by SavitaS on 20 Sept 2006 for Security Issue 6197
    Protected m_DeliverableID As String
    Protected m_FunctionID As String
    'Addition by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
    Protected m_blnDisabled As Boolean

    Private m_strCustomFieldText1 As String
    Private m_strCustomFieldText2 As String
    Private m_strCustomFieldText3 As String
    Private m_strCustomFieldText4 As String
    Private m_strCustomFieldText5 As String

    Private m_strCustomFieldDate1 As String
    Private m_strCustomFieldDate2 As String
    Private m_strCustomFieldDate3 As String
    Private m_strCustomFieldDate4 As String
    Private m_strCustomFieldDate5 As String

    Private m_strCustomFieldNumeric1 As String
    Private m_strCustomFieldNumeric2 As String
    Private m_strCustomFieldNumeric3 As String
    Private m_strCustomFieldNumeric4 As String
    Private m_strCustomFieldNumeric5 As String

    Private m_strScheduledStartDate As String
    Private m_strEarliestCompletionDate As String
    Private m_strLatestCompletionDate As String
    Private m_strEfforts As String
    Private m_strPriority As String
    Private m_strComplexity As String
    Private m_strDeliverableSize As String
    Private m_strDeliverableSizeUnit As String
    Private m_strStatus As String
    Private m_strProjectSite As String
    Private m_strWorkPackage As String
    Private m_strDepartment As String
    Private m_strIncludeInMeasurement As String
    Private m_strRequestedBy As String
    Private m_strResponsiblePerson As String
    Private m_strAcceptanceTestingRequired As String
    Private m_strTitle As String
    Private m_strDescription As String
    Private m_strDocumentNo As String
    Protected m_strProjectName As String
    Private m_strCustomerRefNo As String
    'End by SuchitraP

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()

    End Sub

#End Region

    Public Sub PageInit()
        '######### Page Code starts here
        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        If UCase(Trim(m_strFromWhere & "")) = "CRM" Then
            'Addition by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
            If CommonFunction.General.CheckIsNothing(Request.QueryString("DeliverableID"), "") <> "" Then
                strScheduleID = Request.QueryString("DeliverableID")
                m_blnDisabled = True
                GetData()
            End If
            'End by SuchitraP

            'If (m_intQueryID.ToString <> "0" And m_PKToken = "") Or (m_intQueryID.ToString <> "0" And CommonFunctions.Security.Token.ValidateToken(CType(m_intQueryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
            '    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk D eliverables", 0, 0, "Query ID", CType(m_intQueryID, String))
            '    'Token is Invalid now redirect to the Invalid Access Page
            '    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            'End If

            If m_strAction <> "SAVE" Then
                WritePage()
            End If

            SaveData()

            If m_strAction = "SAVE" Then
                If CommonFunction.General.CheckIsNothing(intScheduleID, "") <> "" And intScheduleID <> "0" Then
                    strScheduleID = intScheduleID
                    m_blnDisabled = True
                    GetData()
                    WritePage()
                End If
            End If
            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197 
            ' Added by SavitaS 20 Sept 2006 for Security Issue 6197
        ElseIf UCase(Trim(m_strFromWhere & "")) = "IB" Then

            If Not Request.QueryString("IssueID") Is Nothing Then
                m_strIssueID = Request.QueryString("IssueID").ToString
            Else
                m_strIssueID = "0"
            End If


            'If Not Request.QueryString("PKToken") Is Nothing Then
            '    m_PKToken = Request.QueryString("PKToken").ToString
            'End If
            If Request.QueryString("PKToken") <> "" Then
                m_PKToken = CType(Request.QueryString("PKToken"), String)
                '    Else
                '        m_PKToken = Request.QueryString("PKToken").ToString
                '    End If
            End If





            If Request.QueryString("FromWhere") = "IB" Then
                If ((m_PKToken <> "") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken) = False)) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Issue : Create Deliverable", 0, 0, "Issue ID", CType(m_strIssueID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                ''  End of Added by SavitaS 20 Sept 2006 for Security Issue 6197

            End If
            SaveData()
            WritePage()

        Else
            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197 
            WritePage()
            SaveData()
            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197 
        End If
    End Sub
    Private Sub GetData()
        Dim strSQL As String
        Dim drDeliverableDetails As IDataReader

        strSQL = "usp_get_tbl_PM_OtherSchedules " + strScheduleID.ToString
        drDeliverableDetails = CommonFunction.Data.GetDataReader(strSQL, MyBase.UseSQL)

        If drDeliverableDetails.Read Then
            m_strScheduledStartDate = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("StartDate"), ""), String)
            m_strEarliestCompletionDate = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("EndDate"), ""), String)
            m_strLatestCompletionDate = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("EstimatedReleaseDate"), ""), String)
            m_strPriority = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("Priority"), ""), String)
            m_strEfforts = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("EsimtatedEfforts"), ""), String)
            m_strTitle = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("Title"), ""), String)
            m_strDescription = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("Description"), ""), String)
            strScheduleID = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("ScheduleTypeID"), ""), String)

            strProjectID = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("ProjectID"), ""), String)
            m_strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("ProjectName"), ""), String)
            m_strCustomerRefNo = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomerRefNo"), ""), String)
            m_strDocumentNo = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("DocumentNo"), ""), String)
            m_strComplexity = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("Complexity"), ""), String)
            m_strDeliverableSize = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("DeliverableSize"), ""), String)
            m_strDeliverableSizeUnit = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("DeliverableSizeUnit"), ""), String)
            m_strStatus = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("Status"), ""), String)
            m_strProjectSite = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("ProjectSiteID"), ""), String)
            m_strWorkPackage = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("PackageID"), ""), String)
            m_strDepartment = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("DepartmentID"), ""), String)
            m_strIncludeInMeasurement = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("IncludeInMeasurement"), ""), String)
            m_strRequestedBy = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("RequestedBy"), ""), String)
            m_strResponsiblePerson = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("ResponsiblePerson"), ""), String)
            m_strAcceptanceTestingRequired = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("AcceptanceTestingRequired"), ""), String)

            m_strCustomFieldDate1 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldDate1"), ""), String)
            m_strCustomFieldDate2 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldDate2"), ""), String)
            m_strCustomFieldDate3 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldDate3"), ""), String)
            m_strCustomFieldDate4 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldDate4"), ""), String)
            m_strCustomFieldDate5 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldDate5"), ""), String)

            m_strCustomFieldText1 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldText1"), ""), String)
            m_strCustomFieldText2 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldText2"), ""), String)
            m_strCustomFieldText3 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldText3"), ""), String)
            m_strCustomFieldText4 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldText4"), ""), String)
            m_strCustomFieldText5 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldText5"), ""), String)

            m_strCustomFieldNumeric1 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldNumeric1"), ""), String)
            m_strCustomFieldNumeric2 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldNumeric2"), ""), String)
            m_strCustomFieldNumeric3 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldNumeric3"), ""), String)
            m_strCustomFieldNumeric4 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldNumeric4"), ""), String)
            m_strCustomFieldNumeric5 = CType(CommonFunctions.Data.CheckIsDBNull(drDeliverableDetails("CustomFieldNumeric5"), ""), String)
        End If
        ' Added by GaneshD on 14 Sep 2009 for disposing the object [Cleanup activity]
        CommonFunction.Data.DisposeDataReader(drDeliverableDetails)
        ' End of addition by GaneshD
    End Sub
    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub
    Protected Sub WritePage()

        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
        'Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        'Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        'Dim arrCSFunction() As String = {"Save_OnClick()", "CloseOnClick()", "Help_OnClick('Create_Deliverables')"}
        Dim arrMenu() As String
        Dim arrMenuToolTip() As String
        Dim arrCSFunction() As String

        If m_blnDisabled = True Then
            Dim m_arrMenu() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
            Dim m_arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
            Dim m_arrCSFunction() As String = {"CloseOnClick()", "Help_OnClick('Create_Deliverables')"}
            arrMenu = m_arrMenu
            arrMenuToolTip = m_arrMenuToolTip
            arrCSFunction = m_arrCSFunction
        Else
            Dim m_arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
            Dim m_arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
            Dim m_arrCSFunction() As String = {"Save_OnClick()", "CloseOnClick()", "Help_OnClick('Create_Deliverables')"}
            arrMenu = m_arrMenu
            arrMenuToolTip = m_arrMenuToolTip
            arrCSFunction = m_arrCSFunction
        End If
        'End by SuchitraP

        Dim strMenu, strLegend As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}

        'code added by harshada d on 31 march 2006 for having different helps for issues , helpdesk , and change management
        Select Case UCase(Trim(m_strFromWhere & ""))
            Case "PM"
                arrCSFunction(2) = "Help_OnClick('CREATE_DELIVERABLES_PM')"
            Case "IB"
                If m_blnDisabled = True Then
                    arrCSFunction(1) = "Help_OnClick('CREATE_DELIVERABLES_IB')"
                Else
                    arrCSFunction(2) = "Help_OnClick('CREATE_DELIVERABLES_IB')"
                End If
                'arrCSFunction(2) = "Help_OnClick('CREATE_DELIVERABLES_IB')"
            Case "CRM"
                If m_blnDisabled = True Then
                    arrCSFunction(1) = "Help_OnClick('CREATE_DELIVERABLES_CRM')"
                Else
                    arrCSFunction(2) = "Help_OnClick('CREATE_DELIVERABLES_CRM')"
                End If
        End Select


        strMenu = m_objMenu.DrawMenuWithEvents(arrMenu, arrCSFunction, arrMenuToolTip)
        With Response
            ' menu  
            .Write("<div id=divList style='overflow:auto'>")
            .Write(strMenu)
            strLegend = WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)
            CommonFunctions.General.WriteHTML("<BR>")
            '.Write("<div id=divList style='overflow:auto' height=500px>")
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "Create Deliverables", , , True))
            CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, "", , , True))

            .Write("<Table id='tbl_Page' class=clsTable width ='99.9%' cellpadding=0 cellspacing=0>" & vbCrLf)
            WriteDefaultfields()
            If strScheduleID <> "0" Then
                writeMandatoryFields()
                WriteCustomfields()
            End If

            .Write("<TR class=clsTREven>")
            .Write("<TD align=right>")

            If intScheduleID = 0 Then
            Else
                intScheduleID = CType(MyBase.GetFormValue("txtDeliverableID"), Long)
            End If
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableID", "txtDeliverableID", , , , intScheduleID.ToString, , , , , , True, EnableHTMLEncode:=True)
            'Added by SavitaS on 20 Sept 2006
            CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken, , , , , , , , , , , , True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            'End Addition by SvaitaS
            .Write("</TD>")
            .Write("<TD align=right>")
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''CommonFunctions.HTMLControls.DrawComboBox("cboTitle", "select title from tbl_PM_OtherSchedules", , , , True, , , True, , True)
            CommonFunctions.HTMLControls.DrawComboBox("cboTitle", "usp_sel_tbl_PM_OtherSchedules_title", , , , True, , , True, , True)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
            .Write("</TD>")
            'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
            'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
            '           request to deliverable layout not seen proper.
            .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></TR>")
            'End of Addition by SuchitraP
            .Write("</TABLE>")
            .Write("</div>")
            .Write("<BR>")
            .Write(strMenu)
        End With
        If Right(m_strObjArray, 1) = "," Then
            m_strObjArray = m_strObjArray.Substring(0, Len(m_strObjArray) - 1)
            m_strObj_captions = m_strObj_captions.Substring(0, Len(m_strObj_captions) - 1)
        End If
    End Sub
    Protected Sub WriteDefaultfields()
        Dim strSQLDefaultValues As String
        Dim drGetDefaultValues As IDataReader
        Dim strTitle As String
        Dim strDescription As String

        Dim drProjectsOnHold As IDataReader
        Dim strSQLProjectsOnHoldQuery As String

        m_strProjectsOnHold = ""
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQLProjectsOnHoldQuery = " Select ProjectID From tbl_PM_Project where ProjectStatusID in ( Select ProjectStatusID From tbl_CNF_ProjectStatus Where MaptoProjectOnHold=1) "
        strSQLProjectsOnHoldQuery = " usp_sel_tbl_PM_Project_ProjectID_MaptoProjectOnHold"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        drProjectsOnHold = CommonFunction.Data.GetDataReader(strSQLProjectsOnHoldQuery, MyBase.UseSQL)
        While drProjectsOnHold.Read
            m_strProjectsOnHold = m_strProjectsOnHold & "," & CType(CommonFunction.Data.CheckIsDBNull(drProjectsOnHold("ProjectID"), "0"), String) & ","

        End While

        CommonFunction.Data.DisposeDataReader(drProjectsOnHold)

        'Addition of if condition by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
        If m_blnDisabled <> True Then
            strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("ProjectID")).ToString()
            strProjectID = MyBase.GetFormValue("cboProject")
            If strProjectID = "" Then
                strProjectID = "0"
            End If
        End If
        'End by SuchitraP

        With Response
            '.Write("<Table id='tbl_Default' class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            .Write("<TR class=clsTREven width=100%>")
            .Write("<TD align=right> Project </TD>")
            .Write("<TD >")
            If m_strFromWhere = "PM" Then ' if called from Projects
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLDefaultValues = "select ChangeRequestSummary,ChangeRequestDescription,ChangeRequestDate FROM tbl_pm_changeRequest_master Where ChangeRequestID =" & m_intChangeRequestID
                strSQLDefaultValues = "usp_sel_tbl_pm_changeRequest_master_Summary_Description_Date " & m_intChangeRequestID
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strProjectID = m_intProjectID.ToString

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Select ProjectID,Projectname from Tbl_PM_Project ", , m_intProjectID.ToString, "disabled", True, , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_tbl_PM_Project_cboProject", , m_intProjectID.ToString, "disabled", True, , , True)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            ElseIf m_strFromWhere = "IB" Then 'if called from IB

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLDefaultValues = "SELECT Summary , Description ,ReportedDate FROM tbl_ib_Issue Where IssueID =" & m_intIssueID
                strSQLDefaultValues = "usp_sel_tbl_ib_Issue_Summary_Description_ReportedDate " & m_intIssueID
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                strProjectID = Session("IssueProject").ToString

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''CommonFunctions.HTMLControls.DrawComboBox("cboProject", "Select ProjectID,Projectname from Tbl_PM_Project ", , strProjectID.ToString, "disabled", True, , , True)
                CommonFunctions.HTMLControls.DrawComboBox("cboProject", "usp_sel_tbl_PM_Project_cboProject", , strProjectID.ToString, "disabled", True, , , True)
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Else 'if called from CRM

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                'strSQLDefaultValues = "select subject , description from tbl_CRM_Query_Master where QueryID = " & m_intQueryID
                strSQLDefaultValues = "usp_tbl_CRM_Query_Master_subject_description " & m_intQueryID
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                If m_intFunctionID = 0 Then
                    m_intFunctionID = CType(Session("FunctionID"), Integer)
                End If

                'Addition of if condition by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                If m_blnDisabled <> True Then
                    strProjectID = MyBase.GetFormValue("cboProject")
                    If strProjectID = "" Then
                        strProjectID = "0"
                    End If
                    If strProjectID = "0" Then
                        strProjectID = CType(GetDefaultProject(m_intFunctionID), String)
                    End If
                End If
                'End by SuchitraP

                Dim strFunction As String = "EXEC usp_CRM_ProjectList_ForFunction " & m_intFunctionID & ", " & strProjectID.ToString  '"select ProjectID,ProjectName from v_tbl_CRM_Function_Projects where functionid = " + m_intFunctionID.ToString + ""
                'If CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboProject")) = "" Then
                '    'Get Default Project
                '    Dim strDefaultProject As String
                '    strDefaultProject = "select ISNULL(ProjectID,0) as ProjectID from tbl_CRM_Function_projects Where FunctionID=" & m_intFunctionID & "  And IsDefaultProject=1 "

                '    strProjectID = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strDefaultProject, True), "0"), String)

                'End If

                'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                'CommonFunctions.HTMLControls.DrawComboBox("cboProject", strFunction, , strProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                If m_blnDisabled = True Then
                    .Write(" : " + m_strProjectName)
                Else
                    CommonFunctions.HTMLControls.DrawComboBox("cboProject", strFunction, , strProjectID.ToString, "onchange=javascript:cboProject_OnChange()", True, , , True)
                End If
                'End by SuchitraP


            End If
            drGetDefaultValues = CommonFunctions.Data.GetDataReader(strSQLDefaultValues, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))


            If drGetDefaultValues.Read Then
                'Addition of if condition by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                If m_blnDisabled <> True Then
                    strTitle = CType(CommonFunction.Data.CheckIsDBNull(drGetDefaultValues(0), ""), String)
                    strDescription = CType(CommonFunction.Data.CheckIsDBNull(drGetDefaultValues(1), ""), String)
                End If
                'End by SuchitraP
            End If
            CommonFunction.Data.DisposeDataReader(drGetDefaultValues)

            m_strObjArray = m_strObjArray + "cboProject,"
            m_strObj_captions = " Project , "
            .Write("</td>")
            'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
            'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
            '           request to deliverable layout not seen proper.
            .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
            'End of Addition by SuchitraP

            .Write("<TR class=clsTREven width=100%>")
            .Write("<TD align=right> Deliverable Type </TD>")
            .Write("<TD >")

            'Addition of if condition by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
            If m_blnDisabled <> True Then
                strScheduleID = MyBase.GetFormValue("cboDeliverableType")
            End If
            'End by SuchitraP

            If strScheduleID = "" Then
                strScheduleID = "0"
            End If

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'Dim strSql_DeliverableType As String = "Select Distinct A.ScheduleID, B.LabelSchedule	From tbl_PM_ProjectSchedules As A Inner Join tbl_PM_CompanySchedules As B On A.ScheduleID=B.ScheduleID Where(A.ProjectID =" + strProjectID + ")"
            Dim strSql_DeliverableType As String = "usp_sel_tbl_PM_ProjectSchedules_ScheduleID_LabelSchedule " + strProjectID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
            'CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", strSql_DeliverableType, , strScheduleID.ToString, "onchange=javascript:cboDeliverableType_OnChange()", True, , , True)
            If m_blnDisabled = True Then
                Dim dr As IDataReader
                dr = CommonFunction.Data.GetDataReader(strSql_DeliverableType, MyBase.UseSQL)
                If dr.Read Then
                    .Write(" : " + CType(dr("LabelSchedule"), String))
                End If
                ' Added by GaneshD on 14 Sep 2009 for disposing the object [Cleanup activity]
                CommonFunction.Data.DisposeDataReader(dr)
                ' End of addition by GaneshD
            Else
                CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableType", strSql_DeliverableType, , strScheduleID.ToString, "onchange=javascript:cboDeliverableType_OnChange()", True, , , True)
            End If
            'End by SuchitraP



            .Write("</td>")
            'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
            'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
            '           request to deliverable layout not seen proper.
            .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
            'End of Addition by SuchitraP

            m_strObjArray = m_strObjArray + "cboDeliverableType,"
            m_strObj_captions = m_strObj_captions + "Deliverable Type,"

            'Dim strScheduleID As String
            Dim strSQLQuery As String
            Dim intResult As Integer
            Dim blnUseSQL As Boolean
            Dim strLabel_Title As String = "Title"
            Dim drGetDefaultFields As IDataReader
            Dim strSql_captions As String = "select * from tbl_CNF_ScheduleFieldConfig  where mandatory = 1 and applicable = 1 and fieldname IN "
            strSql_captions += "( 'Title','Client Reference Number','Document No') and ScheduleTypeID =" + strScheduleID + " order by fieldname"

            If strScheduleID <> "0" Then
                Dim strSQLQuery_DocumentNo As String
                Dim intResult_DocumentNo As Integer
                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQLQuery_DocumentNo = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1) Else Select 0"
                strSQLQuery_DocumentNo = "usp_sel_tbl_PM_CompanySchedules_IsCodeTemplateEditable " & strScheduleID
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                intResult_DocumentNo = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery_DocumentNo, True), "0"), Integer)
                'if intResult is 1 -Show 'CodeTemplate' in Editable Mode with Mandatory, Else dont show the control
                If intResult_DocumentNo = 1 Then
                    .Write("<TR class=clsTREven width=100%>")
                    .Write("<TD align=right>Code Template </TD>")
                    .Write("<TD >")

                    'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                    'CommonFunctions.HTMLControls.DrawTextBox("txtDocumentNo", "txtDocumentNo", , 300, 500, , , , False, , , , , , True, "../../images/star.gif")
                    If m_blnDisabled = True Then
                        .Write(" : " + m_strDocumentNo)
                    Else
                        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        CommonFunctions.HTMLControls.DrawTextBox("txtDocumentNo", "txtDocumentNo", , 300, 500, , , , False, , , , , , True, "../../images/star.gif", EnableHTMLEncode:=True)
                        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                    End If
                    'End by SuchitraP

                    .Write("</td>")
                    'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                    'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                    '           request to deliverable layout not seen proper.
                    .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                    'End of Addition by SuchitraP
                    m_strObjArray = m_strObjArray + "txtDocumentNo,"
                    m_strObj_captions = m_strObj_captions + " Code Template ,"
                End If
                blnUseSQL = CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)
                drGetDefaultFields = CommonFunctions.Data.GetDataReader(strSql_captions, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
                While drGetDefaultFields.Read
                    Dim strFieldName As String = CType(CommonFunction.Data.CheckIsDBNull(drGetDefaultFields("FieldName"), "0"), String)
                    Dim strLabel As String = CType(CommonFunction.Data.CheckIsDBNull(drGetDefaultFields("Label"), "0"), String)
                    Select Case strFieldName
                        Case "Client Reference Number"
                            .Write("<TR class=clsTREven width=100%>")
                            .Write("<TD align=right>" & strLabel & "</TD>")
                            .Write("<TD>")
                            'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                            'CommonFunctions.HTMLControls.DrawTextBox("txtClientRefNo", "txtClientRefNo", , 300, 500, , , , False, , , , , , True)
                            If m_blnDisabled = True Then
                                .Write(" : " + m_strCustomerRefNo)
                            Else
                                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                                CommonFunctions.HTMLControls.DrawTextBox("txtClientRefNo", "txtClientRefNo", , 300, 500, , , , False, , , , , , True, EnableHTMLEncode:=True)
                                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            End If
                            'End by SuchitraP
                            'Addition of <TD> by SuchitraP on 22-Apr-2009 for IssueID : 29993
                            'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                            '           request to deliverable layout not seen proper.
                            .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></TR>")
                            'End of Addition by SuchitraP

                            m_strObjArray = m_strObjArray + "txtClientRefNo,"
                            m_strObj_captions = m_strObj_captions + strLabel + ","
                        Case "Title"
                            strLabel_Title = strLabel
                    End Select
                End While
            End If
            'Comment and added by PrashantD on 27 Feb 2006 IssueID 1936
            If Request.Form("txtTitle") <> "" Then
                'If MyBase.GetFormValue("txtTitle") <> "" Then
                'Commented and modified by MonikaI on 13-Sep-2006. IssueID : 4790
                'strTitle = CommonFunctions.General.BuildQueryString(Request.Form("txtTitle")) 'MyBase.GetFormValue("txtTitle")
                strTitle = Request.Form("txtTitle")
                'End by MonikaI
                'end Of addition by PrashantD
            Else
            End If
            .Write("<TR class=clsTREven width=100%>")
            .Write("<TD align=right>" & strLabel_Title & "</TD>")
            .Write("<TD >")

            'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
            'CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", , 400, 200, strTitle, , , False, , , , , , True)
            If m_blnDisabled = True Then
                .Write(" : " + m_strTitle)
            Else
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txtTitle", "txtTitle", , 400, 200, strTitle, , , False, , , , , , True, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            End If
            'End by SuchitraP

            m_strObjArray = m_strObjArray + "txtTitle,"
            m_strObj_captions = m_strObj_captions + strLabel_Title + ","
            .Write("</td>")
            'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
            'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
            '           request to deliverable layout not seen proper.
            .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
            'End of Addition by SuchitraP
            'Comment and added by PrashantD on 27 Feb 2006 IssueID 1936
            'If MyBase.GetFormValue("txtDescription") <> "" Then
            If Request.Form("txtDescription") <> "" Then
                strDescription = Request.Form("txtDescription") 'MyBase.GetFormValue("txtDescription")
                'end Of addition by PrashantD
            Else
            End If
            .Write("<TR class=clsTREven width=100%>")
            'Commented And Added By Vaijat K On 04/11/2015
            '.Write("<TD align=right> Description </TD>")
            .Write("<TD align=right style='vertical-align:top !important;'> Description </TD>")
            .Write("<TD >")
            'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
            'CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", , , , "frmCreate_Deliverables", "../../images/zoomin.gif", , 400, 100, 1000, strDescription)
            If m_blnDisabled = True Then
                .Write(" : " + m_strDescription)
            Else
                'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
                'CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmCreate_Deliverables", "../../images/zoomin.gif", , 400, 100, 1000, strDescription)
                CommonFunctions.HTMLControls.DrawTextArea("txtDescription", "txtDescription", "Description", , , "frmCreate_Deliverables", "../../images/zoomin.gif", , 400, 100, 1000, strDescription, EnableHTMLEncode:=True)
                'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
            End If
            'End by SuchitraP

            CommonFunction.Data.DisposeDataReader(drGetDefaultFields)
            .Write("</td>")
            'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
            'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
            '           request to deliverable layout not seen proper.
            .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
            'End of Addition by SuchitraP

            Dim strSQL As String
            Dim dtmExpectedStartDate As Date
            Dim dtmExpectedEndDate As Date

            Dim drProjectDates As IDataReader

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT ExpectedStartDate , ExpectedEndDate,EstimatedEfforts FROM tbl_PM_Project where ProjectID = " & strProjectID
            strSQL = "usp_sel_tbl_PM_Project_ExpectedStartDate_ExpectedEndDate_EstimatedEfforts " & strProjectID
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016


            drProjectDates = CommonFunctions.Data.GetDataReader(strSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            If drProjectDates.Read Then
                dtmExpectedStartDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDates("ExpectedStartDate"), ""), Date)
                dtmExpectedEndDate = CType(CommonFunction.Data.CheckIsDBNull(drProjectDates("ExpectedEndDate"), ""), Date)
                m_lngEstimatedEfforts = CType(CommonFunction.Data.CheckIsDBNull(drProjectDates("EstimatedEfforts"), ""), Long)

                .Write("<TR class=clsTREven>")
                .Write("<TD align=right> ")
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txtProjectStartDate", "txtProjectStartDate", , 300, 500, CommonFunctions.Dates.GetDate(dtmExpectedStartDate), , , False, , , True, , False, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                .Write("</td>")
                .Write("<TD align=right>")
                'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                CommonFunctions.HTMLControls.DrawTextBox("txtProjectEndDate", "txtProjectEndDate", , 300, 500, CommonFunctions.Dates.GetDate(dtmExpectedEndDate), , , False, , , True, , , False, EnableHTMLEncode:=True)
                'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                .Write("</td>")
                'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                '           request to deliverable layout not seen proper.
                .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                'End of Addition by SuchitraP
            End If
            CommonFunctions.Data.DisposeDataReader(drProjectDates)
            '  .Write("</table>")
        End With
    End Sub
    Protected Sub writeMandatoryFields()
        Dim strSql_DeliverableType As String
        Dim strSql_MandatoryFields As String
        Dim strSql_Status As String
        Dim strSql_ProjectSites As String
        Dim strSql_WorkPackage As String
        Dim strsql As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSql_MandatoryFields = "select * from tbl_CNF_ScheduleFieldConfig  where mandatory = 1 and applicable = 1 and fieldname not like 'customfield%' and ScheduleTypeID =" + strScheduleID + "" ' order by fieldname"
        strSql_MandatoryFields = "usp_sel_tbl_CNF_ScheduleFieldConfig_MandatoryCustomfield " + strScheduleID + "" ' order by fieldname"
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Dim drGetMandatoryFields As IDataReader
        drGetMandatoryFields = CommonFunctions.Data.GetDataReader(strSql_MandatoryFields, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        With Response
            ' .Write("<Table id='tbl_Mandatory' class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            While drGetMandatoryFields.Read
                Dim strFieldName As String = CType(CommonFunction.Data.CheckIsDBNull(drGetMandatoryFields("FieldName"), "0"), String)
                Dim strLabel As String = CType(CommonFunction.Data.CheckIsDBNull(drGetMandatoryFields("Label"), "0"), String)
                '.Write("<Table id='tbl_Mandatory' class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
                Select Case strFieldName
                    'Case "Client Reference Number"
                    '    .Write("<TR class=clsTROdd>")
                    '    .Write("<TD align=right>" & strLabel & "</TD>")
                    '    .Write("<TD>")
                    '    CommonFunctions.HTMLControls.DrawTextBox("txtClientRefNo", "txtClientRefNo", , 300, 500, , , , False, , , , , , True)
                    '    m_strObjArray = m_strObjArray + "txtClientRefNo,"
                    '    m_strObj_captions = m_strObj_captions + strLabel + ","
                    '    .Write("</td>")
                    '    .Write("</tr>")

                    'Case "Document No"
                    '    Dim strSQLQuery As String
                    '    Dim intResult As Integer
                    '    strSQLQuery = "If Exists(Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1)Select (Select 1 from tbl_PM_CompanySchedules where ScheduleID=" & strScheduleID & " and IsCodeTemplateEditable=1) Else Select 0"
                    '    intResult = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSQLQuery, True), "0"), Integer)
                    '    'if intResult is 1 -Show 'CodeTemplate' in Editable Mode with Mandatory, Else dont show the control
                    '    If intResult = 1 Then
                    '        .Write("<TR class=clsTROdd>")
                    '        .Write("<TD align=right>" & strLabel & "</TD>")
                    '        .Write("<TD>")
                    '        m_blnCodeTempleteEditable = True
                    '        CommonFunctions.HTMLControls.DrawTextBox("txtDocumentNo", "txtDocumentNo", , 300, 500, , , , False, , , , , , True, "../../images/star.gif")
                    '        m_strObjArray = m_strObjArray + "txtDocumentNo,"
                    '        m_strObj_captions = m_strObj_captions + strLabel + ","
                    '        .Write("</td>")
                    '        .Write("</tr>")
                    '    End If

                    Case "Scheduled Start Date"

                        Dim dmtScheduledStartDate As String
                        dmtScheduledStartDate = MyBase.GetFormValue("txtScheduledStartDate")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtScheduledStartDate", "txtScheduledStartDate", , , dmtScheduledStartDate, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strScheduledStartDate))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtScheduledStartDate", "txtScheduledStartDate", , , dmtScheduledStartDate, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtScheduledStartDate,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "Earliest Completion Date"
                        Dim dmtEarliestCompletionDate As String
                        dmtEarliestCompletionDate = MyBase.GetFormValue("txtEarliestCompletionDate")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtEarliestCompletionDate", "txtEarliestCompletionDate", , , dmtEarliestCompletionDate, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strEarliestCompletionDate))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtEarliestCompletionDate", "txtEarliestCompletionDate", , , dmtEarliestCompletionDate, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtEarliestCompletionDate,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "Latest Completion Date"
                        Dim dmtLatestCompletionDate As String
                        dmtLatestCompletionDate = MyBase.GetFormValue("txtLatestCompletionDate")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtLatestCompletionDate", "txtLatestCompletionDate", , , dmtLatestCompletionDate, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strLatestCompletionDate))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtLatestCompletionDate", "txtLatestCompletionDate", , , dmtLatestCompletionDate, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtLatestCompletionDate,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "Efforts"

                        Dim strEfforts As String
                        strEfforts = MyBase.GetFormValue("txtEfforts")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", , 100, 100, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strEfforts)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtEfforts", "txtEfforts", , 100, 100, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP


                        m_strObjArray = m_strObjArray + "txtEfforts,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Priority"

                        Dim strPriority As String
                        strPriority = MyBase.GetFormValue("cboPriority")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Sel_tbl_CRM_Priority_ForDeliverable", , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strPriority)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboPriority", "usp_Sel_tbl_CRM_Priority_ForDeliverable", , strPriority, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboPriority,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "Complexity"

                        Dim strComplexity As String
                        strComplexity = MyBase.GetFormValue("cboComplexity")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_Sel_tbl_PM_ComplexityMaster_ForDeliverable", , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strComplexity)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboComplexity", "usp_Sel_tbl_PM_ComplexityMaster_ForDeliverable", , strComplexity, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboComplexity,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "Deliverable Size"
                        Dim strDeliverableSize As String
                        strDeliverableSize = MyBase.GetFormValue("txtDeliverableSize")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Modified By NitinVS on 6 July 2007 for WhizibleSEM 7 
                        'set Max length to 8 since it is integer field

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableSize", "txtDeliverableSize", , 100, 9, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strDeliverableSize)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableSize", "txtDeliverableSize", , 100, 9, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        'End Modification By NitinVS on 6 July 2007 for WhizibleSEM 7 

                        .Write("</TD>")
                        Dim strDeliverableSizeUnit As String

                        strDeliverableSizeUnit = MyBase.GetFormValue("cboDeliverableSizeUnit")
                        .Write("<TD align=left> Deliverable Size Unit</TD>")
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("<TD >")
                        '  CommonFunctions.HTMLControls.DrawTextBox("txtDeliverableSizeUnit", "txtDeliverableSizeUnit", , 100, 100, , , , False, , , , , , True)

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableSizeUnit", "usp_sel_tbp_PM_SizeUnits", , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strDeliverableSizeUnit)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboDeliverableSizeUnit", "usp_sel_tbp_PM_SizeUnits", , strDeliverableSizeUnit, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtDeliverableSize,cboDeliverableSizeUnit,"
                        m_strObj_captions = m_strObj_captions + "Deliverable Size Unit " + ","
                        .Write("</td>")
                        .Write("</tr>")

                    Case "Deliverable Size Unit"

                    Case "Status"

                        strSql_Status = "usp_Sel_tbl_IB_Project_Type_Status_Deliverables " + strScheduleID.Trim + ", " + strProjectID
                        Dim strStatus As String
                        strStatus = MyBase.GetFormValue("cboStatus")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSql_Status, , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strStatus)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboStatus", strSql_Status, , strStatus, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboStatus,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Project Site"

                        strSql_ProjectSites = "usp_Sel_tbl_PM_ProjectSites_ForDeliverable " + strProjectID
                        Dim strProjectSites As String
                        strProjectSites = MyBase.GetFormValue("cboProjectSites")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboProjectSites", strSql_ProjectSites, , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strProjectSite)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboProjectSites", strSql_ProjectSites, , strProjectSites, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboProjectSites,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Work Package"

                        strSql_WorkPackage = "usp_Sel_tbl_PM_ProjectPackages " + strProjectID
                        Dim strWorkPackage As String
                        strWorkPackage = MyBase.GetFormValue("cboWorkPackage")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboWorkPackage", strSql_WorkPackage, , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strWorkPackage)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboWorkPackage", strSql_WorkPackage, , strWorkPackage, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboWorkPackage,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "Department"

                        Dim strDepartment As String
                        strDepartment = MyBase.GetFormValue("cboDepartment")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_tbl_PM_DepartmentMaster_ForDeliverable", , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strDepartment)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", "usp_Sel_tbl_PM_DepartmentMaster_ForDeliverable", , strDepartment, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboDepartment,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Include In Measurement"

                        Dim strIncludeInMeasurement As String
                        strIncludeInMeasurement = MyBase.GetFormValue("chkIncludeInMeasurement")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawCheckBox("chkIncludeInMeasurement", "chkIncludeInMeasurement", , False, "0", , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strIncludeInMeasurement)
                        Else
                            'Commented and modified by GaneshD on 27 Aug 2009 For Whziblesem 9.0 IssueID-32668
                            'CommonFunctions.HTMLControls.DrawCheckBox("chkIncludeInMeasurement", "chkIncludeInMeasurement", , False, "0", , , , True)
                            CommonFunctions.HTMLControls.DrawCheckBox("chkIncludeInMeasurement", "chkIncludeInMeasurement", , False, "0", , , , )
                            ' End of Modification by GaneshD
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "chkIncludeInMeasurement,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Requested By"

                        Dim strRequestedBy As String
                        strRequestedBy = MyBase.GetFormValue("cboRequestedBy")
                        strsql = "usp_sel_RequestedBy_ForDeliverable " + strProjectID
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboRequestedBy", strsql, , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strRequestedBy)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboRequestedBy", strsql, , strRequestedBy, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboRequestedBy,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Responsible Person"

                        strsql = ""
                        strsql += "Select Distinct E.EmployeeID, E.UserName "
                        strsql += "From	tbl_PM_ProjectEmployeeRole P, tbl_PM_Employee E"
                        strsql += " Where	P.ProjectID = " + strProjectID + " And P.EmployeeID = "
                        strsql += " E.EmployeeID and IsNull(P.ActualEndDate,'') = ''"
                        strsql += "Order By E.UserName"
                        Dim strResponsiblePerson As String
                        strResponsiblePerson = MyBase.GetFormValue("cboResponsiblePerson")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawComboBox("cboResponsiblePerson", strsql, , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strResponsiblePerson)
                        Else
                            CommonFunctions.HTMLControls.DrawComboBox("cboResponsiblePerson", strsql, , strResponsiblePerson, , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "cboResponsiblePerson,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "Acceptance Testing Required"

                        Dim strAcceptanceTestingRequired As String
                        strAcceptanceTestingRequired = MyBase.GetFormValue("chkAcceptanceTestingRequired")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawCheckBox("chkAcceptanceTestingRequired", "chkAcceptanceTestingRequired", , False, "0")
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strAcceptanceTestingRequired)
                        Else
                            CommonFunctions.HTMLControls.DrawCheckBox("chkAcceptanceTestingRequired", "chkAcceptanceTestingRequired", , False, "0")
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "chkAcceptanceTestingRequired,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("</TD><TD>&nbsp;</TD><TD>&nbsp;</TD></TR>")
                        'End of Addition by SuchitraP
                End Select
            End While
            '.Write("</TABLE>")

            ' close the drGetMandatoryFields
            CommonFunction.Data.DisposeDataReader(drGetMandatoryFields)
        End With
    End Sub
    Protected Sub WriteCustomfields()
        Dim strSQL_Customfields As String

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        'strSQL_Customfields = "select * from tbl_CNF_ScheduleFieldConfig  where mandatory = 1 and applicable = 1 and fieldname like 'customfield%' and ScheduleTypeID =" + strScheduleID + " order by fieldname"
        strSQL_Customfields = "usp_sel_tbl_CNF_ScheduleFieldConfig_MandatoryCustomfield_fieldname " + strScheduleID
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        Dim drGetCustomFields As IDataReader
        With Response
            ' .Write("<Table id='tbl_Custom' class=clsTable width ='100%' cellpadding=0 cellspacing=0>" & vbCrLf)
            '  If strScheduleID <> "0" Then
            drGetCustomFields = CommonFunctions.Data.GetDataReader(strSQL_Customfields, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
            While drGetCustomFields.Read
                Dim strFieldName As String = CType(CommonFunction.Data.CheckIsDBNull(drGetCustomFields("FieldName"), "0"), String)
                Dim strLabel As String = CType(CommonFunction.Data.CheckIsDBNull(drGetCustomFields("Label"), "0"), String)
                Select Case strFieldName
                    Case "CustomFieldText1"
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText1", "txtCustomFieldText1", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldText1)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText1", "txtCustomFieldText1", , 300, 100, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldText1,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "CustomFieldText2"
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText2", "txtCustomFieldText2", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldText2)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText2", "txtCustomFieldText2", , 300, 100, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldText2,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "CustomFieldText3"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText3", "txtCustomFieldText3", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldText3)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText3", "txtCustomFieldText3", , 300, 100, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldText3,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "CustomFieldText4"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText4", "txtCustomFieldText4", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldText4)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText4", "txtCustomFieldText4", , 300, 100, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldText4,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "CustomFieldText5"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText5", "txtCustomFieldText5", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldText5)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldText5", "txtCustomFieldText5", , 300, 100, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldText5,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldDate1"

                        Dim dmtCustomFieldDate1 As String
                        dmtCustomFieldDate1 = MyBase.GetFormValue("txtCustomFieldDate1")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate1", "txtCustomFieldDate1", , , dmtCustomFieldDate1, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strCustomFieldDate1))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate1", "txtCustomFieldDate1", , , dmtCustomFieldDate1, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldDate1,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "CustomFieldDate2"

                        Dim dmtCustomFieldDate2 As String
                        dmtCustomFieldDate2 = MyBase.GetFormValue("txtCustomFieldDate2")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate2", "txtCustomFieldDate2", , , dmtCustomFieldDate2, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strCustomFieldDate2))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate2", "txtCustomFieldDate2", , , dmtCustomFieldDate2, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldDate2,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldDate3"

                        Dim dmtCustomFieldDate3 As String
                        dmtCustomFieldDate3 = MyBase.GetFormValue("txtCustomFieldDate3")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate3", "txtCustomFieldDate3", , , dmtCustomFieldDate3, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strCustomFieldDate3))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate3", "txtCustomFieldDate3", , , dmtCustomFieldDate3, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldDate3,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldDate4"

                        Dim dmtCustomFieldDate4 As String
                        dmtCustomFieldDate4 = MyBase.GetFormValue("txtCustomFieldDate4")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate4", "txtCustomFieldDate4", , , dmtCustomFieldDate4, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strCustomFieldDate4))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate4", "txtCustomFieldDate4", , , dmtCustomFieldDate4, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldDate4,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldDate5"

                        Dim dmtCustomFieldDate5 As String
                        dmtCustomFieldDate5 = MyBase.GetFormValue("txtCustomFieldDate5")
                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate5", "txtCustomFieldDate5", , , dmtCustomFieldDate5, , "frmCreate_Deliverables", , , , , True, , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + CommonFunction.Dates.CGetDate(m_strCustomFieldDate5))
                        Else
                            CommonFunctions.HTMLControls.DrawDateControl("txtCustomFieldDate5", "txtCustomFieldDate5", , , dmtCustomFieldDate5, , "frmCreate_Deliverables", , , , , True, , , True)
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldDate5,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldNumeric1"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric1", "txtCustomFieldNumeric1", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldNumeric1)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric1", "txtCustomFieldNumeric1", , 300, 500, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldNumeric1,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                    Case "CustomFieldNumeric2"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric2", "txtCustomFieldNumeric2", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldNumeric2)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric2", "txtCustomFieldNumeric2", , 300, 500, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldNumeric2,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldNumeric3"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric3", "txtCustomFieldNumeric3", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldNumeric3)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric3", "txtCustomFieldNumeric3", , 300, 500, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldNumeric3,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldNumeric4"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric4", "txtCustomFieldNumeric4", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldNumeric4)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric4", "txtCustomFieldNumeric4", , 300, 500, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldNumeric4,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP

                    Case "CustomFieldNumeric5"

                        .Write("<TR class=clsTREven width=100%>")
                        .Write("<TD align=right>" & strLabel & "</TD>")
                        .Write("<TD >")

                        'Comment and Modification by SuchitraP on 19-Sep-2008 to diaplay details as labels in edit mode
                        'CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric5", "txtCustomFieldNumeric5", , 300, 500, , , , False, , , , , , True)
                        If m_blnDisabled = True Then
                            .Write(" : " + m_strCustomFieldNumeric5)
                        Else
                            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                            CommonFunctions.HTMLControls.DrawTextBox("txtCustomFieldNumeric5", "txtCustomFieldNumeric5", , 300, 500, , , , False, , , , , , True, EnableHTMLEncode:=True)
                            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
                        End If
                        'End by SuchitraP

                        m_strObjArray = m_strObjArray + "txtCustomFieldNumeric5,"
                        m_strObj_captions = m_strObj_captions + strLabel + ","
                        .Write("</td>")
                        'Addition of <TD> by SuchitraP on 9-Apr-2009 for IssueID : 29993
                        'Purpose : Helpdesk --> Convert To Del : When all the fileds are mapped to the deliverable type while converting the the help desk 
                        '           request to deliverable layout not seen proper.
                        .Write("<TD>&nbsp;</TD><TD>&nbsp;</TD></tr>")
                        'End of Addition by SuchitraP
                End Select
                '.Write("</td>")
                '.Write("</tr>")
            End While
            CommonFunction.Data.DisposeDataReader(drGetCustomFields)
            '    .Write("</table>")
        End With

    End Sub


    Protected Sub SaveData()
        Dim strSQL As New System.Text.StringBuilder

        If m_strAction = "SAVE" Then
            If strScheduleID <> "0" Then
                'Save data
                strSQL.Append(" Insert Into tbl_PM_otherSchedules")
                strSQL.Append(" (")
                strSQL.Append("ScheduleTypeID,ProjectID,DepartmentID,DocumentNo,CustomerRefNo,Title,DeliverableLCE, ")
                strSQL.Append("StartDate,EarliestStartDate,LatestCompletionDate,")

                strSQL.Append("ProjectSiteID,Priority,DeliverableSize,DeliverableSizeUnitID,ComplexityID,IncludeInMeasurement,")
                strSQL.Append("RequestedBy,ResponsiblePerson,Status,IsAcceptanceTestingRequired,PackageID , ")
                strSQL.Append("CustomFieldText1,CustomFieldText2,CustomFieldText3,CustomFieldText4,")
                strSQL.Append("CustomFieldText5,CustomFieldNumeric1,CustomFieldNumeric2,CustomFieldNumeric3,CustomFieldNumeric4,CustomFieldNumeric5,")
                strSQL.Append("CustomFieldDate1, CustomFieldDate2, CustomFieldDate3, CustomFieldDate4, CustomFieldDate5, Description")
                strSQL.Append(")")
                strSQL.Append("values(")

                If Trim(MyBase.GetFormValue("cboDeliverableType") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append("" & MyBase.GetFormValue("cboDeliverableType") & "")
                End If
                If m_strFromWhere.ToUpper = "PM" Then
                    strSQL.Append("," & CType(Session("intProjectID"), String) & "")
                ElseIf m_strFromWhere.ToUpper = "IB" Then
                    strSQL.Append("," & CType(Session("IssueProject"), String) & "")
                Else
                    If Trim(MyBase.GetFormValue("cboProject") & "") = "" Then
                        strSQL.Append(",null")
                    Else
                        strSQL.Append("," & MyBase.GetFormValue("cboProject") & "")
                    End If
                End If
                If Trim(MyBase.GetFormValue("cboDepartment") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append("," & MyBase.GetFormValue("cboDepartment") & "")
                End If

                If Trim(MyBase.GetFormValue("txtDocumentNo") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtDocumentNo") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtClientRefNo") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtClientRefNo") & "'")
                End If
                ' to handle single quote 
                '' 5-Sept-2006
                If Trim(Request.Form("txtTitle") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & CommonFunctions.General.BuildQueryString(Trim(Request.Form("txtTitle") & "")) & "'")
                End If

                If Trim(MyBase.GetFormValue("txtEfforts") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtEfforts") & "'")
                End If


                If Trim(MyBase.GetFormValue("txtScheduledStartDate") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtScheduledStartDate") & "'")
                End If


                If Trim(MyBase.GetFormValue("txtEarliestCompletionDate") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtEarliestCompletionDate") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtLatestCompletionDate") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtLatestCompletionDate") & "'")
                End If

                If Trim(MyBase.GetFormValue("cboProjectSites") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append("," & MyBase.GetFormValue("cboProjectSites") & "")
                End If

                If Trim(MyBase.GetFormValue("cboPriority") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append("," & MyBase.GetFormValue("cboPriority") & "")
                End If

                If Trim(MyBase.GetFormValue("txtDeliverableSize") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtDeliverableSize") & "'")
                End If

                If Trim(MyBase.GetFormValue("cboDeliverableSizeUnit") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("cboDeliverableSizeUnit") & "'")
                End If

                If Trim(MyBase.GetFormValue("cboComplexity") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("cboComplexity") & "'")
                End If
                If Trim(MyBase.GetFormValue("chkIncludeInMeasurement") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("chkIncludeInMeasurement") & "'")
                End If
                If Trim(MyBase.GetFormValue("cboRequestedBy") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("cboRequestedBy") & "'")
                End If
                If Trim(MyBase.GetFormValue("cboResponsiblePerson") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("cboResponsiblePerson") & "'")
                End If

                If Trim(MyBase.GetFormValue("cboStatus") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("cboStatus") & "'")
                End If
                If Trim(MyBase.GetFormValue("chkAcceptanceTestingRequired") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("chkAcceptanceTestingRequired") & "'")
                End If

                If Trim(MyBase.GetFormValue("cboWorkPackage") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("cboWorkPackage") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtCustomFieldText1") & "") = "" Then
                    strSQL.Append(",null")

                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldText1") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldText2") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldText2") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldText3") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldText3") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtCustomFieldText4") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldText4") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtCustomFieldText5") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldText5") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtCustomFieldNumeric1") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldNumeric1") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtCustomFieldNumeric2") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldNumeric2") & "'")
                End If

                If Trim(MyBase.GetFormValue("txtCustomFieldNumeric3") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldNumeric3") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldNumeric4") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldNumeric4") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldNumeric5") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldNumeric5") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldDate1") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldDate1") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldDate2") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldDate2") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldDate3") & "") = "" Then
                    strSQL.Append(",null")
                Else

                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldDate3") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldDate4") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldDate4") & "'")

                End If
                If Trim(MyBase.GetFormValue("txtCustomFieldDate5") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtCustomFieldDate5") & "'")
                End If
                If Trim(MyBase.GetFormValue("txtDescription") & "") = "" Then
                    strSQL.Append(",null")
                Else
                    strSQL.Append(",'" & MyBase.GetFormValue("txtDescription") & "'")
                End If
                strSQL.Append(")")
                strSQL.Append(" Select SCOPE_IDENTITY()")

                intScheduleID = CType(CommonFunction.Data.GetDataScalar(strSQL.ToString, MyBase.UseSQL), Long)
            End If
            If m_strFromWhere.ToUpper = "PM" Then ' called from Projects - Change management 
                Dim strSQLChangeMgmt As String
                strSQLChangeMgmt = " UPDATE tbl_PM_ChangeRequest_Master SET DeliverableID =" & intScheduleID
                strSQLChangeMgmt += " where ChangeRequestID =" & m_intChangeRequestID
                CommonFunctions.Data.InsertOrUpdateData(strSQLChangeMgmt, MyBase.UseSQL)

				'Send mail - New Issue posted JP_21Aug2006
                Call SendMail(472, m_intChangeRequestID)
            ElseIf m_strFromWhere.ToUpper = "IB" Then                 ' called from issue 
                Dim strSQLIB As String
                strSQLIB = " UPDATE tbl_IB_Issue SET DeliverableID =" & intScheduleID
                strSQLIB += " where IssueID =" & m_intIssueID
                CommonFunctions.Data.InsertOrUpdateData(strSQLIB, MyBase.UseSQL)
   				'Send mail - New Issue posted JP_21Aug2006
                Call SendMail(473, m_intIssueID)

            ElseIf m_strFromWhere.ToUpper = "CRM" Then ' called from Help Desk
                '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
                If (m_intQueryID.ToString <> "0" And m_PKToken = "") Or (m_intQueryID.ToString <> "0" And CommonFunctions.Security.Token.ValidateToken(CType(m_intQueryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken) = False) Then
                    Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk D eliverables", 0, 0, "Query ID", CType(m_intQueryID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
                Dim strSQLCRM As String
                'Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
                'strSQLCRM = " UPDATE tbl_CRM_Query_Master SET DeliverableID =" & intScheduleID
                'strSQLCRM += " where QueryID =" & m_intQueryID
                Dim strSessionUserName As String
                strSessionUserName = CType(Session("strUserName"), String).Replace("'", "''")
                strSQLCRM = " UPDATE tbl_CRM_Query_Master SET DeliverableID =" & intScheduleID
                strSQLCRM += ",ModifiedBy='" & strSessionUserName & "'"
                strSQLCRM += ",ModifiedDate=GETDATE() "
                strSQLCRM += " where QueryID =" & m_intQueryID
                'End of Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master

                CommonFunctions.Data.InsertOrUpdateData(strSQLCRM, MyBase.UseSQL)
                '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197   
            End If

            If m_blnCodeTempleteEditable = False Then
                Dim strSQLCodeTemplete As String
                strSQLCodeTemplete = " usp_upd_tbl_PM_OtherSchedule_CodeTemplate " & intScheduleID
                CommonFunctions.Data.InsertOrUpdateData(strSQLCodeTemplete, MyBase.UseSQL)
            End If
            'Commented By JyotiG
            'Start_JG_CR_7146_09-Nov-2006
            'CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>" + vbCrLf)
            'CommonFunctions.General.WriteHTML("var objTitle=GetObjectReference('frmCreate_Deliverables','txtTitle');" + vbCrLf)
            'End_JG_CR_7146_09-Nov-2006
            'CommonFunctions.General.WriteHTML("window.opener.opener.location.href=window.opener.opener.location.href;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("alert(<%=intScheduleID%>);" + vbCrLf)
            'Commented By JyotiG
            'Start_JG_CR_7146_09-Nov-2006
            'CommonFunctions.General.WriteHTML("window.opener.document.forms['frmRequestDetails'].elements['DeliverableID'].value = <%=intScheduleID%>;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("	window.opener.document.forms['frmRequestDetails'].elements['txtDeliverableName'].value =objTitle.value ;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.opener.location.href=window.opener.location.href;" + vbCrLf)
            'CommonFunctions.General.WriteHTML("window.close();" + vbCrLf)
            'CommonFunctions.General.WriteHTML("</script>" + vbCrLf)
            'End_JG_CR_7146_09-Nov-2006
        End If

        'CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>" + vbCrLf)
        'CommonFunctions.General.WriteHTML("var strParentPage;")
        'CommonFunctions.General.WriteHTML("try" + vbCrLf)
        'CommonFunctions.General.WriteHTML("{" + vbCrLf)
        'CommonFunctions.General.WriteHTML("strParentPage = new String();" + vbCrLf)
        'CommonFunctions.General.WriteHTML("strParentPage = opener.location.href;" + vbCrLf)
        'CommonFunctions.General.WriteHTML("alert(strParentPage);" + vbCrLf)
        'CommonFunctions.General.WriteHTML("// If the document loaded in the parent window is the PM_DailyActivityMatrix.aspx, then refresh the page." + vbCrLf)
        ''CommonFunctions.General.WriteHTML("if (strParentPage.toUpperCase().indexOf('PM_DAILYACTIVITYMATRIX.ASPX', 0) != -1)" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("{" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("window.opener.frmRequestDetails.action = opener.location.href;" + vbCrLf)
        ''CommonFunctions.General.WriteHTML("window.opener.frmRequestDetails.submit();" + vbCrLf)
        'CommonFunctions.General.WriteHTML("}" + vbCrLf)
    End Sub

 ' JP_21AUG2006
    Private Sub SendMail(ByVal MessageId As Integer, ByVal intConvertTypeID As Long)
        '=====================================================================
        ' Procedure Name        : SendMail()	
        ' Purpose               : To send mail for given messageId and ChangeRequestID
        ' Description           : same as above
        ' Parameters Passed     : none
        ' Returns               : none
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : JijeshP
        ' Created               : 21, Aug 2006
        ' Revisions             :
        '=====================================================================

        Dim drEmailMessage As IDataReader
        Dim blnSendEmail, blnShowPopup As Boolean
        Dim strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage As String

        Select Case MessageId
            Case 472 'ChangeRequest to Deliverable
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 472", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                'Destroy data reader
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                'Exit procedure if no mail is to be send
                If Not blnSendEmail Then Exit Sub

                'If popup window to be shown before sending mail
                If blnShowPopup Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=472&ChangeRequestID=" + intConvertTypeID.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                Else
                    'If mail is to be send silently
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_472(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intConvertTypeID)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
            Case 473 'Issue to Deliverable
                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 473", MyBase.UseSQL)
                If drEmailMessage.Read Then
                    blnSendEmail = CType(drEmailMessage("SendMail"), Boolean)
                    blnShowPopup = CType(drEmailMessage("ShowPopup"), Boolean)
                End If
                'Destroy data reader
                CommonFunction.Data.DisposeDataReader(drEmailMessage)

                'Exit procedure if no mail is to be send
                If Not blnSendEmail Then Exit Sub

                'If popup window to be shown before sending mail
                If blnShowPopup Then
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=473&IssueID=" + intConvertTypeID.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                Else
                    'If mail is to be send silently
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_473(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intConvertTypeID)
                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
                End If
        End Select
    End Sub
    ' JP_21AUG2006
    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Added by Shamkant S on 18-Jan-2016 to Generate and Validate Token
        If Request.QueryString("FromWhere").ToUpper = "CRM" Then
            If Not Request.QueryString("QueryID") Is Nothing Then
                m_lngQueryID = CType(Request.QueryString("QueryID"), String)
            Else
                m_lngQueryID = 0
            End If

            If Not Request.QueryString("DeliverableID") Is Nothing Then
                m_DeliverableID = CType(Request.QueryString("DeliverableID"), String)
            End If

            If Not Request.QueryString("FunctionID") Is Nothing Then
                m_FunctionID = CType(Request.QueryString("FunctionID"), String)
            End If

            If Not Request.QueryString("PKToken") Is Nothing Then
                '  m_TokenKEY = CType(Request.QueryString("PKToken"), String)
                m_PKToken_FromDT = Trim(Request.QueryString("PKToken") & "")

            End If
            If m_PKToken_FromDT <> "" Then
                If m_DeliverableID <> "" Then
                    If (CommonFunctions.Security.Token.ValidateToken(CType(m_DeliverableID, String) + CType(m_lngQueryID, String) + CType(m_FunctionID, String) + "0" + "0", m_PKToken_FromDT) = False) Then
                        '' Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
                        'Token is Invalid now redirect to the Invalid Access Page
                        System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                    End If
                ElseIf (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + CType(Session("intUserID"), String) + "0" + "0", m_PKToken_FromDT) = False) Then
                    ''Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(m_lngQueryID, String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")

                End If
            End If

        End If
        ''Added by Chakshuta H on 1st-Aug-2016 Purpose:To validate the token
        If (Request.QueryString("FromWhere") = "IB") Then
            If (Request.QueryString("PkConvert2DelivarableToken") <> "" And Request.QueryString("IssueID") <> "") Then
                If (CommonFunctions.Security.Token.ValidateToken(CType(Request.QueryString("IssueID"), String) + CType(Session("intUserID"), String) + "0" + "0", Request.QueryString("PkConvert2DelivarableToken")) = False) Then
                    'Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Request Detail", 0, 0, "Query ID", CType(Request.QueryString("Year"), String))
                    'Token is Invalid now redirect to the Invalid Access Page
                    System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
                End If
            End If
        End If
        ''End OF Added by Chakshuta H on 1st-Aug-2016 Purpose:To validate the token

        

        'End of addition by Shamkant S on 18-Jan-2016 to Generate and Validate Token
        '' START : Modified BY ParagD On 5-Sept-2006
        '' Purpose : Whizible SP7 Issue : To persist ShowToCustomer flag for Issue
        If Not Request.QueryString("ShowToCustomer") Is Nothing Then
            m_ShowToCustomer = Request.QueryString("ShowToCustomer").ToString
        Else
            m_ShowToCustomer = "0"
        End If
        '' END : Modified BY ParagD On 5-Sept-2006
        ' JP_ Check the  Mode
        If Not Request.QueryString("Mode") Is Nothing Then
            m_strMode = Request.QueryString("Mode").ToString + ""
        Else
            m_strMode = ""
        End If
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        If Not Request.QueryString("FromWhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("FromWhere").ToString
        Else
            m_strFromWhere = ""
        End If

        m_intProjectID = CInt(Session("intProjectID"))

        If Not Request.QueryString("FunctionID") Is Nothing Then
            m_intFunctionID = CType(Request.QueryString("FunctionID"), Integer)
            Session("FunctionID") = m_intFunctionID
        Else
            m_intFunctionID = 0
        End If
        If Not Request.QueryString("ChangeRequestID") Is Nothing Then
            m_intChangeRequestID = CType(Request.QueryString("ChangeRequestID"), Integer)
        Else
            m_intChangeRequestID = 0
        End If


        If Not Request.QueryString("IssueID") Is Nothing Then
            m_intIssueID = CType(Request.QueryString("IssueID"), Integer)
        Else
            m_intIssueID = 0
        End If
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_intQueryID = CType(Request.QueryString("QueryID"), Integer)
        Else
            m_intQueryID = 0
        End If

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If UCase(Trim(m_strFromWhere & "")) = "CRM" Then
            If Trim(Request.QueryString("PKToken") & "") <> "" Then
                m_PKToken = Request.QueryString("PKToken")
            Else
                m_PKToken = Request.Form("txtPkToken").ToString
            End If
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197


        Dim StrSQL As String = "usp_SEL_Deliverables_Details"
        Dim drDeliverables As IDataReader
        drDeliverables = CommonFunctions.Data.GetDataReader(StrSQL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If drDeliverables.Read Then

            'StrTitleList = CType(CommonFunction.Data.CheckIsDBNull(drDeliverables(0), ""), String)
            StrTitleList = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drDeliverables(0), ""), String))
            ''StrTitleList = Replace(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drDeliverables(0), ""), "").ToString(), "'", "\'")

            'StrCodeTemplate = CType(CommonFunction.Data.CheckIsDBNull(drDeliverables(1), ""), String)
            StrCodeTemplate = CommonFunctions.General.BuildQueryString(CType(CommonFunction.Data.CheckIsDBNull(drDeliverables(1), ""), String))
            'StrCodeTemplate = Replace(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(drDeliverables(1), ""), "").ToString(), "'", "\'")

        End If
        CommonFunction.Data.DisposeDataReader(drDeliverables)
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload

    End Sub
    Private Function GetDefaultProject(ByVal FunctionID As Long) As Long
        '=====================================================================
        ' Procedure Name        : GetDefaultProject
        ' Description           : to get the employee department
        ' Purpose               : 
        ' Parameters Passed     : Function ID
        ' Returns               : the department id of employee
        ' Parameters Affected   : None
        ' Assumptions           :
        ' Dependencies          :
        ' Author                : Rajanikant
        ' Created               : Feb 19,2004
        ' Revisions             :
        '=====================================================================
        Dim dr As IDataReader
        ' get the function id of the CRM	
        dr = CommonFunction.Data.GetDataReader("usp_CRM_Get_DefaultProject " & FunctionID, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))
        If dr.Read Then
            GetDefaultProject = CType(CommonFunctions.General.CheckIsNothing(dr("ProjectID"), "0"), Long)
        Else
            GetDefaultProject = 0
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
    End Function

End Class
