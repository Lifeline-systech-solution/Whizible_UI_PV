' Project Name          :  WhizibleSEM 8.0
' Module Name           :  Project (DM_WorkFlowApprovals.aspx)
' Purpose               :  To show workflow approvals for Project,Milestone,Module,SubProject,Change Request and Deliverable.
' Description           :  same as above
' Dependencies          :  None
' Author                :  MahendraV
' Reviewed              :  
' Tested                :  MahendraV
' Created               :  05 May 2008
' Revisions             :  
'=====================================================================
#Region "WorkFlow Approval Class "
Imports System.Text
Public Class DM_WorkFlowApprovals
    Inherits WebPages.Template.WhizTemplate
    Public WithEvents m_GenerateTree As New CommonFunctions.GenerateTree

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


        Dim strMode As String = ""
        strMode = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")
        If strMode.ToUpper.ToString = "SESSION_PROJECT" Then
            Call UpdateSession()
        End If

    End Sub

#End Region

#Region " Global Member variable "

    ' Event variables
    Private m_strTagID As String = CommonFunction.Constants.APP_TAG_WORKFLOW_APPROVALS.ToString
    Private m_objControlHashtable As CommonEngines.HashTables.UIControlTagMaster()
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private WithEvents m_objWorkFlowApprovalsGrid As New WebPages.Template.AdvancedGrid

    ' Data source variables
    Dim m_dsFieldList As DataSet
    Dim m_dsEndtityList As DataSet
    Dim m_dsEndtityGrid As DataSet

    ' Page variables
    Dim m_strAdvanceFilterWhereClause As String = ""
    Dim m_strEntityTagID As String = ""
    Dim m_strLoginType As String = ""
    Dim m_strUserID As String = ""
    Dim m_strAlertType As String = ""
    Dim m_strPageName As String = ""
    Dim m_strPrimaryKeyName As String = ""
    Dim m_strEntityName As String = ""
    Dim m_strMode As String = ""
    Dim m_strAppliedFilters As String = ""
    Dim m_strEntityFilters As String = ""
    'Addition by SuchitraP on 24-July-2008 for CRM Workflow
    Dim m_strFromWhere As String = ""
    Dim m_strSubject As String = ""
    Dim m_strFromDate As String = ""
    Dim m_strToDate As String = ""
    Protected m_strWorkflow As String
    Protected m_strSubmitter As String
    Dim m_strWorkflowName As String
    Dim m_strProcedureTitle As String
    'End by SuchitraP

    ' Paging Varibals
    Protected m_PageSize As Integer = 20
    Private m_intPageNumber As Integer = 1
    Protected m_NoOfpages As Integer
    Protected m_intTotalNoOfRows As Integer




#End Region

#Region "Sub-Routines"
    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here
    End Sub
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
        ' Author                :   MahendraV
        ' Created               :   05-April-2008
        ' Revisions             :   
        '=====================================================================

        ' Added  By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting


        MyBase.ApplySecurity(True)
        ' End Added By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
        Call setVariables()
        CommonFunctions.General.WriteHTML(InitializeMenu().ToString())
        CommonFunction.General.WriteHTML("<BR>")

        Call DrawPopupMenu()

        CommonFunction.General.WriteHTML("<INPUT type=hidden id='txtEntityID' name='txtEntityID' value=" + CommonFunction.General.CheckIsNothing(Request.QueryString("EntityID"), "") + ">")

        Call PlotCaption()
        If m_strEntityTagID <> "" Then
            Call DrawAdvanceFilter()
        End If
        Call PlotFilters()

        'Call SetCurrentIndexForPaging()
        'Call CalculateNoOfpagesForPaging()

        CommonFunction.General.WriteHTML(DisplayCurrentFilter())
        Call DrawWorkFlowApprovalsGrid()

    End Sub
    Protected Sub DrawHeader()
        '====================================================================
        ' Procedure Name        :  DrawHeader
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw page header 
        ' Description           :  This sub-routine draws page header 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  05-May-2008
        ' Revisions             :  
        '=====================================================================
        CommonFunctions.General.PlotPageHeadTag("Workflow Approvals")
    End Sub
    Private Sub setVariables()
        '====================================================================
        ' Procedure Name        :  setVariables
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To initialize global variable
        ' Description           :  This sub-routine nitialize global variable
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  05-May-2008
        ' Revisions             :  
        '=====================================================================
        Dim strSqlQuery As String = ""
        Dim strTempEntityTagID As String = ""
        Dim strEntityID As String = ""

        m_strLoginType = CType(IIf(HttpContext.Current.Session("strLoginType") Is Nothing, "E", HttpContext.Current.Session("strLoginType")), String)
        m_strUserID = CStr(HttpContext.Current.Session("intUserID"))

        'Addition by SuchitraP on 24-July-2008 for CRM Workflow
        If Not Request.QueryString("FromWhere") Is Nothing Or Request.QueryString("FromWhere") <> "" Then
            m_strFromWhere = Request.QueryString("FromWhere")
        End If
        'End by SuchitraP

        If IsPostBack() Then
            If Not CommonFunction.General.CheckIsNothing(Request.QueryString("EntityID"), "") = "" Then
                m_strEntityTagID = CommonFunction.General.CheckIsNothing(Request.QueryString("EntityID"), "")
            Else
                m_strEntityTagID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("cboEntityList"), "")
            End If
            'Addition by SuchitraP on 24-july-2008 for CRM workflow
        ElseIf m_strFromWhere = "CRM" Then
            m_strEntityTagID = Request.QueryString("EntityID")
            'End by SuchitraP
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & ", " & m_strTagID & " ,'CBO_ENTITY'"
            m_strEntityTagID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), "0"))
            If m_strEntityTagID = "" Then
                m_strEntityTagID = CommonFunction.Constants.APP_TAG_PM_PROJECT_LISTING.ToString()
            End If
        End If

            If m_strEntityTagID <> "" Then
                m_objControlHashtable = CommonEngines.HashTables.GetHashTableObject.GetHashTableControlTagMasterCPObject(CType(m_strEntityTagID, Long))
                m_dsFieldList = CommonFunctions.Data.GetDataSet("usp_sel_WorkFlowApprovals_FilterFieldList " + m_strEntityTagID, "FieldList")
                m_dsEndtityList = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_attributedetails " + m_strEntityTagID, "EntityList")

            End If


        If m_strEntityTagID <> "" Then
            If m_strEntityTagID <> "8035" Then
                strTempEntityTagID = m_strEntityTagID
                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'CBO_ENTITY',null,'F',N'" & m_strEntityTagID & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",'CBO_ENTITY'"
                m_strEntityTagID = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), "0"))
            Else
                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'TXT_Subject',null,'F',N'" & m_strSubject & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'DT_SubmittedFrom',null,'F',N'" & m_strFromDate & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'DT_SubmittedTill',null,'F',N'" & m_strToDate & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'CBO_Workflow',null,'F',N'" & m_strWorkflow & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'CBO_Submitter',null,'F',N'" & m_strSubmitter & "'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
            End If
        End If

        m_strMode = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Mode"), "")

        

        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("txtPageNumber"), "") <> "" Then
            If Request.Form("txtPageNumber").Trim() <> "" Then
                m_intPageNumber = CInt(CommonFunction.General.CheckIsNothing(Request.Form("txtPageNumber"), 1))

            End If

        End If

        'if Procedure Title filter is applied
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("TXT_KnowledgeManagement"), "") <> "" Then
            m_strProcedureTitle = Request.Form("TXT_KnowledgeManagement")
            m_strProcedureTitle = m_strProcedureTitle.Replace("''", """")
            m_strProcedureTitle = m_strProcedureTitle.Replace("'", "''")
            m_strProcedureTitle = CommonFunction.General.BuildQueryString(m_strProcedureTitle)
        End If

        'If Subject filter present
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("TXT_Subject"), "") <> "" Then
            m_strSubject = Request.Form("TXT_Subject")
            m_strSubject = m_strSubject.Replace("''", """")
            m_strSubject = m_strSubject.Replace("'", "''")
            m_strSubject = CommonFunction.General.BuildQueryString(m_strSubject)
        End If

        'If Fromdate filter present
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("DT_SubmittedFrom"), "") <> "" Then
            m_strFromDate = Request.Form("DT_SubmittedFrom")
        End If

        'If Todate filter present
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("DT_SubmittedTill"), "") <> "" Then
            m_strToDate = Request.Form("DT_SubmittedTill")
        End If

        'if Workflow filter present
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("CBO_Workflow"), "") <> "" Then
            m_strWorkflow = Request.Form("CBO_Workflow")
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Workflow"), "") <> "" Then
            m_strWorkflow = Request.QueryString("Workflow")
        End If

        'if submitter filter present
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("CBO_Submitter"), "") <> "" Then
            m_strSubmitter = Request.Form("CBO_Submitter")
        ElseIf CommonFunctions.General.CheckIsNothing(Request.QueryString("Submitter"), "") <> "" Then
            m_strSubmitter = Request.QueryString("Submitter")
        End If


    End Sub
    Private Sub PlotCaption()
        '====================================================================
        ' Procedure Name        :  PlotCaption
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the page caption
        ' Description           :  This sub-routine draws the page caption
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  13-April-2008
        ' Revisions             :  
        '=====================================================================
        Dim sbPageCaption As New System.Text.StringBuilder
        sbPageCaption.Append("<TABLE id='tblCap01263'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable>")
        sbPageCaption.Append("<TR class=clsTRPageCaption>")
        sbPageCaption.Append("<TD align=Left>Entity Workflow Approvals</TD>")
        sbPageCaption.Append("</TR>")
        sbPageCaption.Append("</TABLE>")
        sbPageCaption.Append("<BR>")
        CommonFunction.General.WriteHTML(sbPageCaption.ToString())

    End Sub
    Private Sub PlotFilters()
        '====================================================================
        ' Procedure Name        :  PlotFilters
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the page filters
        ' Description           :  This sub-routine draws the page filters
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  05-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim sbstr As New System.Text.StringBuilder
        Dim strOptValueArray() As String = {"True", "False", "False"}
        Dim strOptValue As String = ""
        Dim strSqlQuery As String = ""
        Dim strAlertType As String = ""
        Dim strTitle As String = ""
        Dim strEntityListValue As String = ""

        'get the value for the title filter from the form or from the database.
        For Each DREndtityList As DataRow In m_dsEndtityList.Tables(0).Rows
            If Not HttpContext.Current.Request.Form("TXT_" + DREndtityList("Attribute")) Is Nothing Then
                strTitle = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("TXT_" + DREndtityList("Attribute")), "").ToString()
            Else
                strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",'TXT_" + DREndtityList("Attribute").ToString() + "'"
                strTitle = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
            End If
        Next

        strTitle = strTitle.Replace("''", """")
        strTitle = strTitle.Replace("'", "''")
        strTitle = CommonFunction.General.BuildQueryString(strTitle)

        'Apply Title Filter
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("optType"), "").ToString() <> "" Then
            strAlertType = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("optType"), ""), String)
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",'AlertType'"
            strAlertType = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
        End If

        'Addition by SuchitraP on 4-Aug-2008 for CRM Workflow
        'Apply Subject filter
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("TXT_Subject"), "").ToString() <> "" Then
            m_strSubject = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("TXT_Subject"), ""), String)
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & ", " & m_strTagID & " ,'TXT_Subject'"
            m_strSubject = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
        End If

        'Apply FromDate and ToDate filter
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("DT_SubmittedFrom"), "").ToString() <> "" Then
            m_strFromDate = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("DT_SubmittedFrom"), ""), String)
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & ", " & m_strTagID & " ,'DT_SubmittedFrom'"
            m_strFromDate = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
        End If

        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("DT_SubmittedTill"), "").ToString() <> "" Then
            m_strToDate = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("DT_SubmittedTill"), ""), String)
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & ", " & m_strTagID & " ,'DT_SubmittedTill'"
            m_strToDate = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
        End If

        'Apply Workflow filter
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("CBO_Workflow"), "").ToString() <> "" Then
            m_strWorkflow = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("CBO_Workflow"), ""), String)
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & ", " & m_strTagID & " ,'CBO_Workflow'"
            m_strWorkflow = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
        End If

        'Apply Submitter filter
        If CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("CBO_Submitter"), "").ToString() <> "" Then
            m_strSubmitter = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("CBO_Submitter"), ""), String)
        Else
            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & ", " & m_strTagID & " ,'CBO_Submitter'"
            m_strSubmitter = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
        End If
        'End by SuchitraP


        Select Case strAlertType
            Case "To Do List"
                strOptValueArray(0) = "True"
                strOptValueArray(1) = "False"
                strOptValueArray(2) = "False"
                m_strAlertType = "T"
            Case "Watch List"
                strOptValueArray(0) = "False"
                strOptValueArray(1) = "True"
                strOptValueArray(2) = "False"
                m_strAlertType = "W"
            Case "All"
                strOptValueArray(0) = "False"
                strOptValueArray(1) = "False"
                strOptValueArray(2) = "True"
                m_strAlertType = ""
            Case Else
                strOptValueArray(0) = "False"
                strOptValueArray(1) = "False"
                strOptValueArray(2) = "True"

        End Select

        'plot option buttons for alert types filter and text box for initiative title filter
        sbstr.Append("<TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'><TR align=Left class='clsTREven'>")
        'Addition by SuchitraP on 24-July-2006 for CRM Workflow
        If m_strFromWhere = "CRM" Then
            sbstr.Append("<TD colspan=2 align=center>" & CommonFunctions.HTMLControls.DrawOptionButton("optType", "optType", , strOptValueArray(0).ToString, "To Do List", , "onclick=javascript:CRMFilterField_OnChange('opt','" + m_strFromWhere + "')", True) & "Inbox" & " </TD>")
            sbstr.Append("<TD colspan=2 align=center>" & CommonFunctions.HTMLControls.DrawOptionButton("optType", "optType", , strOptValueArray(1).ToString, "Watch List", , "onclick=javascript:CRMFilterField_OnChange('opt','" + m_strFromWhere + "')", True) & "Watch List" & "</TD>")
            sbstr.Append("<TD colspan=2 align=center>" & CommonFunctions.HTMLControls.DrawOptionButton("optType", "optType", , strOptValueArray(2).ToString, "All", , "onclick=javascript:CRMFilterField_OnChange('opt','" + m_strFromWhere + "')", True) & "All" & "</TD><TD></TD>")
        Else
            sbstr.Append("<TD>" & CommonFunctions.HTMLControls.DrawOptionButton("optType", "optType", , strOptValueArray(0).ToString, "To Do List", , "onclick=javascript:FilterField_OnChange('opt')", True) & "Inbox" & " </TD>")
            sbstr.Append("<TD>" & CommonFunctions.HTMLControls.DrawOptionButton("optType", "optType", , strOptValueArray(1).ToString, "Watch List", , "onclick=javascript:FilterField_OnChange('opt')", True) & "Watch List" & "</TD>")
            sbstr.Append("<TD>" & CommonFunctions.HTMLControls.DrawOptionButton("optType", "optType", , strOptValueArray(2).ToString, "All", , "onclick=javascript:FilterField_OnChange('opt')", True) & "All" & "</TD>")
        End If
        
        For Each DREndtityList As DataRow In m_dsEndtityList.Tables(0).Rows
            If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
                strTitle = ""
                m_strSubject = ""
                m_strFromDate = ""
                m_strToDate = ""
                m_strWorkflow = ""
                m_strSubmitter = ""
                m_strProcedureTitle = ""
            Else
                If m_strEntityTagID <> "8035" Then
                    m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(strTitle <> "", IIf(m_strAppliedFilters <> "", " , ", "") + DREndtityList("Attribute").ToString() + " : " + strTitle, ""))
                Else
                    m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(m_strProcedureTitle <> "", IIf(m_strAppliedFilters <> "", " , ", "") + "Procedure Title : " + m_strProcedureTitle, ""))
                End If
                m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(m_strSubject <> "", IIf(m_strAppliedFilters <> "", " , ", "") + " Subject : " + m_strSubject, ""))
                m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(m_strFromDate <> "", IIf(m_strAppliedFilters <> "", " , ", "") + " Submitted From : " + m_strFromDate, ""))
                m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(m_strToDate <> "", IIf(m_strAppliedFilters <> "", " , ", "") + " Submitted To : " + m_strToDate, ""))
                m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(CommonFunctions.General.CheckIsNothing(Request.QueryString("WorkflowName"), "") <> "", IIf(m_strAppliedFilters <> "", " , ", "") + " Workflow : " + CommonFunctions.General.CheckIsNothing(Request.QueryString("WorkflowName"), ""), ""))
                m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(CommonFunctions.General.CheckIsNothing(Request.QueryString("SubmitterName"), "") <> "", IIf(m_strAppliedFilters <> "", " , ", "") + " Submitter : " + CommonFunctions.General.CheckIsNothing(Request.QueryString("SubmitterName"), ""), ""))

            End If
            'Modification by SuchitraP on 4-Aug-2008 for CRM Workflow
            If m_strEntityTagID = "8035" Then
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                sbstr.Append("</TR><TR align=Left class='clsTREven'><TD align='right'> Procedure Title  : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawTextBox("TXT_KnowledgeManagement", "TXT_KnowledgeManagement", , 100, 100, m_strProcedureTitle, , , , , , , , True, EnableHTMLEncode:=True) & "</TD>")
                sbstr.Append("<TD align='right'> Subject : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawTextBox("TXT_Subject", "TXT_Subject", , 100, 100, m_strSubject, , , , , , , , True, EnableHTMLEncode:=True) & "</TD>")
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''sbstr.Append("<TD align='right'> Workflow : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawComboBox("CBO_Workflow", "SELECT ProjectNatureOfDemandID,NatureOfDemand FROM tbl_IM_ProjectNatureOfDemand WHERE IsActive=1 AND ProjectID=-1 AND AttributeID=8035 ORDER BY 2", 120, m_strWorkflow, , True, True) & "</TD>")
                sbstr.Append("<TD align='right'> Workflow : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawComboBox("CBO_Workflow", "usp_tbl_IM_ProjectNatureOfDemand_IsActive_AttributeID", 120, m_strWorkflow, , True, True) & "</TD>")
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                sbstr.Append("<TD></TD></TR><TR align=Left class='clsTREven'><TD align='right'> Submitted From: </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawDateControl("DT_SubmittedFrom", "DT_SubmittedFrom", , , m_strFromDate, , "frmDM_WorkFlowApprovals", , , , , , , True) & "</TD>")
                sbstr.Append("<TD align='right'> Submitted To: </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawDateControl("DT_SubmittedTill", "DT_SubmittedTill", , , m_strToDate, , "frmDM_WorkFlowApprovals", , , , , , , True) & "</TD>")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''sbstr.Append("<TD align='right'> Submitter : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawComboBox("CBO_Submitter", "SELECT EmployeeID,UserName FROM tbl_PM_Employee WHERE Status = 0 AND LeavingDate IS NULL ORDER BY UserName", 120, m_strSubmitter, , True, True))
                sbstr.Append("<TD align='right'> Submitter : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawComboBox("CBO_Submitter", "usp_sel_tbl_PM_Employee_EmployeeID_UserName", 120, m_strSubmitter, , True, True))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
                sbstr.Append("&nbsp;<A Href='javascript:SubmitterSelection()'  Title='Select Submitter'><IMG src='../../Images/Lookup.gif' id='SubmitterSelection' border=0></A></TD>")
                sbstr.Append("<TD><A Href='javascript:Show_Onclick()'  Title='Show'>Show</TD>")
            Else
                'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                sbstr.Append("<TD align='right'>" + DREndtityList("Attribute").ToString() + " : </TD><TD align='left'>" & CommonFunctions.HTMLControls.DrawTextBox("TXT_" + DREndtityList("Attribute").ToString(), "TXT_" + DREndtityList("Attribute").ToString(), , 100, 100, strTitle, , , , , , , "onkeypress=javascript:textSearch_OnKeyPress(event)", True, EnableHTMLEncode:=True) & "</TD>")
                'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            End If
            'End by SuchitraP
        Next

        'Modification by SuchitraP on 24-July-2008 for CRM Workflow
        'If m_strEntityTagID <> "20023" Then
        If m_strEntityTagID <> "8035" Then
            sbstr.Append("<TD align='right'><TABLE CellSpacing=0 BORDER=0 class='clsTable' width='99.9%'><TR align=Left class='clsTREven'><TD align='right'>" & "Entity Name : " & " " & CommonFunctions.HTMLControls.DrawComboBox("cboEntityList", "usp_sel_tbl_IM_Attributes_WFApprovals ", 120, m_strEntityTagID, "onchange=javascript:EntityList_OnChange()", , True) & "</TD></TR></TABLE></TD>")
        End If
        'End of modification by SuchitraP

        'Modification by SuchitraP on 24-July-2008 for CRM Workflow
        'If m_strEntityTagID <> "20023" Then
        If m_strEntityTagID <> "8035" Then
            sbstr.Append("<td align = 'left' title='Advance Search' >")
            sbstr.Append("&nbsp;<A href=""javascript:showFilters(1)"" >Advance Search</A>")
            sbstr.Append("</td>")
        End If
        'End of modification by SuchitraP
        sbstr.Append("</TR></TABLE><BR>")

        If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("optType"), ""), String) <> "" Then
            For Each DREndtityList As DataRow In m_dsEndtityList.Tables(0).Rows
                'strTitle = CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("TXT_" + DREndtityList("Attribute")), "").ToString(), String)
                If strTitle <> "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'TXT_" + DREndtityList("Attribute").ToString() + "',null,'F',N'" & strTitle & "'" 'To Do List'"                        
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                End If
                If m_strSubject <> "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'TXT_Subject',null,'F',N'" & m_strSubject & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                End If
                If m_strFromDate <> "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'DT_SubmittedFrom',null,'F',N'" & m_strFromDate & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                End If
                If m_strToDate <> "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'DT_SubmittedTill',null,'F',N'" & m_strToDate & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                End If
                If m_strWorkflow <> "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'CBO_Workflow',null,'F',N'" & m_strWorkflow & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                End If

                If m_strSubmitter <> "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'CBO_Submitter',null,'F',N'" & m_strSubmitter & "'"
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                End If
            Next
        End If

        Select Case strAlertType
            Case "To Do list"
                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'AlertType',null,'F','To Do List'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
            Case "Watch List"
                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'AlertType',null,'F','Watch List'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

            Case "All"
                strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'AlertType',null,'F','All'"
                CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
            Case Else
                'If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("Title"), ""), String) = "" Then
                strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",'AlertType'"
                strAlertType = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))

                If strAlertType = "" And CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("optType"), ""), String) = "" Then
                    strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'AlertType',null,'F','To Do List'"
                    CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                Else
                    If CType(CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("optType"), ""), String) <> "" Then
                        strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strTagID & ",null,'AlertType',null,'F','To Do List'"
                        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)
                    End If
                End If
        End Select

        If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
            Call ClearFilters()
            strTitle = ""
        End If
        'Dim strProjectID = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Session("intProjectID"), "0").ToString()
        'm_dsEndtityGrid = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox " + m_strEntityTagID + "," + m_strUserID + "," + IIf(m_strAlertType <> "", "'" + m_strAlertType + "'", "NULL") + IIf(CommonFunction.General.CheckIsNothing(strTitle, "") <> "", ",'" + strTitle + "'", ",NULL") + ",3," + strProjectID, "EntityGrid")
        If m_strEntityTagID <> "8035" Then
            m_dsEndtityGrid = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox " + m_strEntityTagID + "," + m_strUserID + "," + IIf(m_strAlertType <> "", "N'" + m_strAlertType + "'", "NULL") + IIf(CommonFunction.General.CheckIsNothing(strTitle, "") <> "", ",N'" + strTitle + "'", ",NULL") + ",3", "EntityGrid")
        Else
            m_dsEndtityGrid = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox_Filter " + m_strEntityTagID + "," + m_strUserID + "," + IIf(m_strAlertType <> "", "N'" + m_strAlertType + "'", "NULL") + IIf(CommonFunction.General.CheckIsNothing(m_strProcedureTitle, "") <> "", ",N'" + CommonFunction.General.BuildQueryString(m_strProcedureTitle) + "'", ",NULL") + IIf(CommonFunction.General.CheckIsNothing(m_strSubject, "") <> "", ",N'" + CommonFunction.General.BuildQueryString(m_strSubject) + "'", ",NULL") + IIf(CommonFunction.General.CheckIsNothing(m_strFromDate, "") <> "", ",N'" + m_strFromDate + "'", ",NULL") + IIf(CommonFunction.General.CheckIsNothing(m_strToDate, "") <> "", ",N'" + m_strToDate + "'", ",NULL") + IIf(CommonFunction.General.CheckIsNothing(m_strWorkflow, "") <> "", ",N'" + m_strWorkflow + "'", ",NULL") + IIf(CommonFunction.General.CheckIsNothing(m_strSubmitter, "") <> "", ",N'" + m_strSubmitter + "'", ",NULL") + ",3", "EntityGrid")
        End If



        CommonFunctions.General.WriteHTML(sbstr.ToString)
        sbstr = Nothing
    End Sub

   

    Private Sub DrawAdvanceFilter()
        '====================================================================
        ' Procedure Name        :  DrawAdvanceFilter
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the advance filters
        ' Description           :  This sub-routine draws the advance filters
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  05-April-2008
        ' Revisions             :  
        '=====================================================================
        Dim sbStrDivHTML As New System.Text.StringBuilder
        Dim strValue As String = ""
        Dim i As Integer = 0
        Dim strDropDownEditSQL As String = ""
        Dim intCount As Integer = 0
        Dim objDS As DataSet
        Dim strTempFieldvalue As String = ""
        Dim strSqlQuery As String = ""
        ''Commented and Added By Vidya Jadhav On 16 Aug 2016 
        'sbStrDivHTML.Append("<TABLE id='tblFilter' style='display:none;width:99.99%;position:absolute;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")
        sbStrDivHTML.Append("<TABLE id='tblFilter' style='display:none;width:99.99%;border:1' class='clsGridTable' cellspacing='1' cellpadding='1'>")
        ''End Of Commented and Added By Vidya Jadhav On 16 Aug 2016 
        For i = 0 To m_objControlHashtable.Length - 1
            For Each DRFieldList As DataRow In m_dsFieldList.Tables(0).Select("ControlTagID = " + m_objControlHashtable(i).ControlTagID.ToString())
                Select Case m_objControlHashtable(i).ControlTypeID
                    Case 1
                        intCount = intCount + 1
                        If intCount = 1 Then
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If

                        If Not HttpContext.Current.Request.Form("FLT_TXT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName) Is Nothing Then
                            strValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("FLT_TXT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName), "").ToString()
                        Else
                            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",'FLT_TXT_" + m_objControlHashtable(i).ControlName.ToString() + "'"
                            strValue = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
                        End If
                        strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'FLT_TXT_" + m_objControlHashtable(i).ControlName.ToString() + "',null,'F',N'" & strValue & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                        If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
                            strValue = ""
                        End If
                        If strValue <> "" Then

                            strValue = strValue.Replace("''", """")
                            strValue = strValue.Replace("'", "''")

                            m_strAdvanceFilterWhereClause = m_strAdvanceFilterWhereClause + CStr(IIf(m_strAdvanceFilterWhereClause <> "", " AND " + DRFieldList("ControlName").ToString() + " LIKE '%" + CommonFunction.General.BuildQueryString(strValue) + "%'", DRFieldList("ControlName").ToString() + " LIKE '%" + strValue + "%'"))
                            m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(strValue <> "", IIf(m_strAppliedFilters <> "", " , ", "") + DRFieldList("ControlCaption").ToString() + " : " + strValue, ""))
                        End If

                        sbStrDivHTML.Append("<TD align='right'> " + DRFieldList("ControlCaption").ToString() + " :</TD>")
                        sbStrDivHTML.Append("<TD align='left'>")
                        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                        sbStrDivHTML.Append(CommonFunction.HTMLControls.DrawTextBox("FLT_TXT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, "FLT_TXT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, , m_objControlHashtable(i).ControlWidth, m_objControlHashtable(i).MaxLength, strValue, CommonFunction.General.CheckIsNothing(m_objControlHashtable(i).Alignment, "Left"), , , , , , , True, EnableHTMLEncode:=True))
                        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
                        sbStrDivHTML.Append("</TD>")
                        If intCount Mod 2 = 0 Then
                            sbStrDivHTML.Append("</TR>")
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If
                    Case 2
                        intCount = intCount + 1

                        If intCount = 1 Then
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If

                        If Not HttpContext.Current.Request.Form("FLT_CBO_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName) Is Nothing Then
                            strValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("FLT_CBO_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName), "").ToString
                        Else
                            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",'FLT_CBO_" + m_objControlHashtable(i).ControlName.ToString() + "'"
                            strValue = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
                        End If
                        strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences N'" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'FLT_CBO_" + m_objControlHashtable(i).ControlName.ToString() + "',null,'F',N'" & strValue & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                        If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
                            strValue = ""
                        End If

                        If strValue <> "" Then
                            m_strAdvanceFilterWhereClause = m_strAdvanceFilterWhereClause + CStr(IIf(m_strAdvanceFilterWhereClause <> "", " AND " + DRFieldList("ControlName").ToString() + " = '" + strValue + "'", DRFieldList("ControlName").ToString() + " = '" + strValue + "'"))
                            strDropDownEditSQL = m_objControlHashtable(i).AdditionalInformation()
                        End If
                        'Added By Usha Pandit On 07.12.2020 For crash due to department filter
                        strDropDownEditSQL = m_objControlHashtable(i).AdditionalInformation()
                        strDropDownEditSQL = strDropDownEditSQL.ToString().Replace("<PROJECT_ID>", Session("intProjectID"))
                        'End Of Added By Usha Pandit On 07.12.2020 For crash due to department filter
                        If strValue <> "" Then
                            If strDropDownEditSQL <> "" Then

                                objDS = CommonFunction.Data.GetDataSet(strDropDownEditSQL, DRFieldList("ControlName").ToString())
                                objDS.Tables(0).Columns(0).ColumnName = objDS.Tables(0).Columns(0).ColumnName.Replace(" ", "")

                                For Each objdataRow As DataRow In objDS.Tables(0).Select(objDS.Tables(0).Columns(0).ColumnName + "='" + strValue + "'")
                                    If objDS.Tables(0).Columns.Count < 2 Then
                                        strTempFieldvalue = CStr(CommonFunction.Data.CheckIsDBNull(objdataRow.Item(0)))
                                    Else
                                        strTempFieldvalue = CStr(CommonFunction.Data.CheckIsDBNull(objdataRow.Item(1)))
                                    End If

                                Next
                                m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(strTempFieldvalue <> "", IIf(m_strAppliedFilters <> "", " , ", "") + DRFieldList("ControlCaption").ToString() + " : " + strTempFieldvalue, ""))
                            End If
                        End If

                        sbStrDivHTML.Append("<TD align='right'> " + DRFieldList("ControlCaption").ToString() + " :</TD>")
                        sbStrDivHTML.Append("<TD align='left'>")
                        'Commented And Added By Usha Pandit On 07.12.2020 For crash due to department filter
                        'sbStrDivHTML.Append(CommonFunction.HTMLControls.DrawComboBox("FLT_CBO_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, m_objControlHashtable(i).AdditionalInformation, m_objControlHashtable(i).ControlWidth, strValue, , True, True))
                        sbStrDivHTML.Append(CommonFunction.HTMLControls.DrawComboBox("FLT_CBO_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, strDropDownEditSQL, m_objControlHashtable(i).ControlWidth, strValue, , True, True))
                        'End Of Added By Usha Pandit On 07.12.2020 For crash due to department filter
                        sbStrDivHTML.Append("</TD>")
                        If intCount Mod 2 = 0 Then
                            sbStrDivHTML.Append("</TR>")
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If
                    Case 6
                        intCount = intCount + 1
                        If intCount = 1 Then
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If
                        If Not HttpContext.Current.Request.Form("FLT_CHK_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName) Is Nothing Then
                            strValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("FLT_CHK_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName), "").ToString
                        Else
                            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  '" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",'FLT_CHK_" + m_objControlHashtable(i).ControlName.ToString() + "'"
                            strValue = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
                        End If
                        strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'FLT_CHK_" + m_objControlHashtable(i).ControlName.ToString() + "',null,'F','" & strValue & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                        If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
                            strValue = ""
                        End If

                        If strValue <> "" Then
                            m_strAdvanceFilterWhereClause = m_strAdvanceFilterWhereClause + CStr(IIf(m_strAdvanceFilterWhereClause <> "", " AND " + DRFieldList("ControlName").ToString() + " = '" + strValue + "'", DRFieldList("ControlName").ToString() + " = '" + strValue + "'"))
                            m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(strValue <> "", IIf(m_strAppliedFilters <> "", " , ", "") + DRFieldList("ControlCaption").ToString() + " : " + strValue, ""))
                        End If

                        sbStrDivHTML.Append("<TD align='right'> " + DRFieldList("ControlCaption").ToString() + " :</TD>")
                        sbStrDivHTML.Append("<TD align='left'>")
                        sbStrDivHTML.Append(CommonFunction.HTMLControls.DrawCheckBox("FLT_CHK_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, "FLT_CHK_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, , , strValue, , , True))
                        sbStrDivHTML.Append("</TD>")
                        If intCount Mod 2 = 0 Then
                            sbStrDivHTML.Append("</TR>")
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If
                    Case 11
                        intCount = intCount + 1
                        If intCount = 1 Then
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If
                        If Not HttpContext.Current.Request.Form("FLT_DT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName) Is Nothing Then
                            strValue = CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.Form("FLT_DT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName), "").ToString
                        Else
                            strSqlQuery = "usp_sel_tbl_IM_FilterPreferences  '" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",'FLT_DT_" + m_objControlHashtable(i).ControlName.ToString() + "'"
                            strValue = CStr(CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlQuery, True), ""), ""))
                        End If
                        strSqlQuery = "Exec usp_upd_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID & ",null,'FLT_DT_" + m_objControlHashtable(i).ControlName.ToString() + "',null,'F','" & strValue & "'"
                        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)

                        If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
                            strValue = ""
                        End If

                        If strValue <> "" Then
                            m_strAdvanceFilterWhereClause = m_strAdvanceFilterWhereClause + CStr(IIf(m_strAdvanceFilterWhereClause <> "", " AND " + DRFieldList("ControlName").ToString() + " = '" + strValue + "'", DRFieldList("ControlName").ToString() + " = '" + strValue + "'"))
                            m_strAppliedFilters = m_strAppliedFilters + CStr(IIf(strValue <> "", IIf(m_strAppliedFilters <> "", " , ", "") + DRFieldList("ControlCaption").ToString() + " : " + strValue, ""))
                        End If

                        sbStrDivHTML.Append("<TD align='right'> " + DRFieldList("ControlCaption").ToString() + " :</TD>")
                        sbStrDivHTML.Append("<TD align='left'>")
                        sbStrDivHTML.Append(CommonFunction.HTMLControls.DrawDateControl("FLT_DT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, "FLT_DT_" + m_strEntityTagID.ToString() + "_" + m_objControlHashtable(i).ControlName, , , strValue, , "frmDM_WorkFlowApprovals", , , , , , , True))
                        sbStrDivHTML.Append("</TD>")
                        If intCount Mod 2 = 0 Then
                            sbStrDivHTML.Append("</TR>")
                            sbStrDivHTML.Append("<TR width=99.9% class=clsTRPageCaption>")
                        End If
                End Select
            Next
        Next
        sbStrDivHTML.Append("<tr class='clsTRPageCaption'><td colspan='" + CStr(i) + "'  style='text-align:center;' width=4% height=15%>")
        sbStrDivHTML.Append("<input type=button id=btnApply onclick='applyFilter()' value=""Apply"">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
        sbStrDivHTML.Append("<input type=button id=btnClose onclick='ClearFilter()' value=""Clear""></TD>")
        sbStrDivHTML.Append("</TABLE>")
        CommonFunction.General.WriteHTML(sbStrDivHTML.ToString())

        If m_strMode.ToUpper.ToString = "CLEAR_FILTER" Then
            Call ClearFilters()
        End If

    End Sub
    Private Sub ClearFilters()
        '====================================================================
        ' Procedure Name        :  ClearFilters
        ' Parameters Passed     :  ClearFilters
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To clear all filters
        ' Description           :  This sub-routine clear all filters
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  13-April-2008
        ' Revisions             :  
        '=====================================================================
        Dim strSqlQuery As String = ""
        m_strAdvanceFilterWhereClause = ""
        m_strAppliedFilters = "None"
        strSqlQuery = "Exec usp_del_tbl_IM_FilterPreferences '" & m_strLoginType & "'," & m_strUserID & "," & m_strEntityTagID
        CommonFunctions.Data.InsertOrUpdateData(strSqlQuery, True)



    End Sub
    Private Sub DrawWorkFlowApprovalsGrid()
        '====================================================================
        ' Procedure Name        :  DrawWorkFlowApprovalsGrid
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the workflow approvals grid
        ' Description           :  This sub-routine draws the orkflow approvals grid
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  08-May-2008
        ' Revisions             :  
        '=====================================================================

        Dim intCount As Integer = 0
        Dim PrimaryKeyName As String = ""
        Dim PageName As String = ""
        Dim strPKToken As String = ""
        Dim strInstanceID As String = ""
        Dim strWFInstanceID As String = ""
        Dim dsGridActualColumn As DataSet
        Dim dsGridUFColumn As DataSet
        Dim dtActualGridData As DataTable = New DataTable("EntityGrid")

        If m_strEntityTagID <> "8035" Then
            dsGridActualColumn = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox " + m_strEntityTagID + "," + m_strUserID + ",NULL,NULL,1", "GridActualColumn")
            dsGridUFColumn = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox " + m_strEntityTagID + "," + m_strUserID + ",NULL,NULL,2", "GridUFColumn")
        Else
            dsGridActualColumn = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox_Filter " + m_strEntityTagID + "," + m_strUserID + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,1", "GridActualColumn")
            dsGridUFColumn = CommonFunctions.Data.GetDataSet("usp_sel_tbl_IM_WorkflowInstance_Inbox_Filter " + m_strEntityTagID + "," + m_strUserID + ",NULL,NULL,NULL,NULL,NULL,NULL,NULL,2", "GridUFColumn")
        End If
        
        Dim arrActualColumnNames(dsGridActualColumn.Tables(0).Columns.Count - 2) As String
        Dim arrUserFriendlyColumnNames(dsGridActualColumn.Tables(0).Columns.Count - 2) As String
        Dim arrGroupOnColumn(dsGridActualColumn.Tables(0).Columns.Count - 2) As String
        Dim arrWidthArray(dsGridActualColumn.Tables(0).Columns.Count - 2) As String

        For Each drWFColumnName As DataColumn In dsGridActualColumn.Tables(0).Columns
            Select Case intCount
                Case 0
                    PrimaryKeyName = drWFColumnName.ColumnName
                Case Else
                    arrActualColumnNames(intCount - 1) = drWFColumnName.ColumnName
                    If intCount = 1 Then
                        arrGroupOnColumn(intCount - 1) = "1"
                        arrWidthArray(intCount - 1) = "style='width:1%'"
                    Else
                        arrGroupOnColumn(intCount - 1) = ""
                        arrWidthArray(intCount - 1) = ""
                    End If
            End Select
            intCount = intCount + 1
        Next
        intCount = 0
        For Each drWFUFColumnName As DataColumn In dsGridUFColumn.Tables(0).Columns
            Select Case intCount
                Case 0
                    PrimaryKeyName = drWFUFColumnName.ColumnName
                Case Else
                    arrUserFriendlyColumnNames(intCount - 1) = drWFUFColumnName.ColumnName
            End Select
            intCount = intCount + 1
        Next


        dtActualGridData = m_dsEndtityGrid.Tables(0).Clone()
        Dim drGridData() As DataRow = m_dsEndtityGrid.Tables(0).Select(IIf(m_strAdvanceFilterWhereClause <> "", m_strAdvanceFilterWhereClause, ""))
        For Each copyRow As DataRow In drGridData
            dtActualGridData.Rows.Add(copyRow.ItemArray)
        Next

        'Dim ViewRecords As DataView = New DataView(m_dsEndtityGrid.Tables(0))
        'ViewRecords.RowFilter = m_strAdvanceFilterWhereClause
        'dtActualGridData = ViewRecords.Table

        Dim arrIgnoreHTMLEncode() As String = {"0"}


        With m_objWorkFlowApprovalsGrid
            .ActualColumnArray = arrActualColumnNames
            .UserFriendlyColumnArray = arrUserFriendlyColumnNames
            .GroupOnColumn = arrGroupOnColumn
            .NoOfDataColumns = arrActualColumnNames.Length
            .PrimaryKey = PrimaryKeyName
            .TDStyleArray = arrWidthArray
            .DIVStyle = "OVERFLOW:auto; WIDTH:99.99%"
            .ColNameToolTipOnEachRow = False
            .DIVID = "DivList"
            .DIVHeight = 290
            .StaticHeaderStyle = STATIC_HEADER_STYLE.ENABLED
            .GridDataTable = dtActualGridData 'dtActualGridData
            .ColNameToolTipOnEachRow = True
            .UseSQL = True
            .returnHTML = True
            .PageSize = m_PageSize
            .CurrentPage = m_intPageNumber
            'Added By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 5th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With


        ' Clear Memory
        m_objWorkFlowApprovalsGrid = Nothing
        arrActualColumnNames = Nothing
        arrUserFriendlyColumnNames = Nothing
        arrWidthArray = Nothing
        If Not dsGridActualColumn Is Nothing Then
            dsGridActualColumn.Dispose()
        End If
        If Not dsGridUFColumn Is Nothing Then
            dsGridUFColumn.Dispose()
        End If
        If Not dtActualGridData Is Nothing Then
            dtActualGridData.Dispose()
        End If
    End Sub
    Private Sub DrawPopupMenu()
        '=====================================================================
        ' Procedure Name		:	DrawPopupMenu
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw floating menu.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	08 May 2008
        ' Revisions				:	
        '=====================================================================
        CommonFunction.General.WriteHTML("<div id=""divMNPopup"" style=""position:absolute;border-left: black 1px solid; border-bottom: black 1px solid; border-right: black 1px solid; border-top: black 1px solid; display:none;z-index:99"">")
        CommonFunction.General.WriteHTML("<table id=""tblMNPopup class=""clsGridTable"" cellpadding=""0"" cellspacing=""0"" >")
        For Each DREndtityList As DataRow In m_dsEndtityList.Tables(0).Rows
            m_strEntityName = DREndtityList("Attribute").ToString()
            m_strPrimaryKeyName = DREndtityList("PrimaryKeyName").ToString()
            m_strPageName = DREndtityList("PageName").ToString()
            CommonFunction.General.WriteHTML("<tr border=""1"" class=""clsTROdd"" id=""TR" + m_strEntityName + """ onmouseover=""mouseOverPopupMenu(event)"" onmousedown=""mouseDownPopupMenu('" + m_strPrimaryKeyName + "',1)"" ><td title=""" + m_strEntityName + " Details""><img src=""../../Images/DB/listMembers.gif""  width=25 height=15  >&nbsp;" + m_strEntityName + " Details&nbsp;&nbsp;&nbsp;</td></tr>")
        Next
        CommonFunction.General.WriteHTML("<tr border=""1"" class=""clsTROdd"" id=""HRLineTR4""><td  class='CtMn_Hr' align='center'></td></tr>")
        CommonFunction.General.WriteHTML("<tr border=""1"" class=""clsTROdd"" id=""TRShowStatus"" onmouseover=""mouseOverPopupMenu(event)"" onmousedown=""mouseDownPopupMenu('" + m_strPrimaryKeyName + "',2)"" ><td  title=""Show Status""><img src=""../../Images/DB/TrackView.gif""  width=25 height=15 >&nbsp;Show Status&nbsp;&nbsp;&nbsp;</td></tr>")
        CommonFunction.General.WriteHTML("</table>")
        CommonFunction.General.WriteHTML("</div>")
    End Sub
    Private Sub m_objWorkFlowApprovalsGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objWorkFlowApprovalsGrid.DataRowTD_BeforePrint

        If Args.DataField.ToUpper() = "STAGESTATUS" Then
            Cancel = True
            Dim strSqlImgQuery As String = "usp_Create_StageImages_HTML_ProjectNatureOfDemand_ForWhizSEM8  " & Args.DataReader(m_strPrimaryKeyName + "_PK").ToString() & ",'" & m_strEntityTagID & "','" + Args.DataReader("InstanceID").ToString() + "'"
            Dim strStatusImageHTML As String = CStr(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar(strSqlImgQuery, True), "0"))
            Args.StringToBeInserted = "<TD>" + strStatusImageHTML + "</TD>"
        End If

        If Args.ColIndex = 2 Then
            If Args.DataReader("AlertType").ToUpper() <> "Archive".ToUpper() Then
                Cancel = True

                Dim strPKToken As String = CommonFunctions.Security.Token.GetToken(Args.DataReader(m_strPrimaryKeyName + "_PK").ToString() + m_strUserID + "0" + CType(m_strEntityTagID, String))
                'Comment and modification done by SuchitraP on 24-July-2008 for CRM workflow
                'Args.StringToBeInserted = "<TD><A href=""#"" onclick=""javascript:ShowPopup(event," + Args.DataReader(m_strPrimaryKeyName + "_PK").ToString() + ",'" + m_strPageName + "'" + ",'" + strPKToken + "','" + Args.DataReader("InstanceID").ToString() + "','" + Args.DataReader("WorkflowInstanceID").ToString() + "','" + Args.DataReader("ProjectID").ToString() + "')"">" + Args.DataFieldValue.ToString() + "</></TD>"
                If m_strFromWhere = "CRM" Then
                    Args.StringToBeInserted = "<TD><A style='cursor:hand;text-decoration:underline;' onclick=""javascript:ShowPopup(event," + Args.DataReader(m_strPrimaryKeyName + "_PK").ToString() + ",'" + m_strPageName + "'" + ",'" + strPKToken + "','" + Args.DataReader("InstanceID").ToString() + "','" + Args.DataReader("WorkflowInstanceID").ToString() + "','" + CommonFunction.Data.CheckIsDBNull(Args.DataReader("ProjectID").ToString(), "-1") + "','" + Args.DataReader("QueryID").ToString() + "')"">" + Args.DataFieldValue.ToString() + "</></TD>"
                Else
                    Args.StringToBeInserted = "<TD><A style='cursor:hand;text-decoration:underline;' onclick=""javascript:ShowPopup(event," + Args.DataReader(m_strPrimaryKeyName + "_PK").ToString() + ",'" + m_strPageName + "'" + ",'" + strPKToken + "','" + Args.DataReader("InstanceID").ToString() + "','" + Args.DataReader("WorkflowInstanceID").ToString() + "','" + Args.DataReader("ProjectID").ToString() + "')"">" + Args.DataFieldValue.ToString() + "</></TD>"
                End If
                'End by SuchitraP
            End If
        End If
    End Sub
    Private Sub ClearMemory()
        '=====================================================================
        ' Procedure Name		:	ClearMemory
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To clear memory.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	09 May 2008
        ' Revisions				:	
        '=====================================================================
        If Not m_dsFieldList Is Nothing Then
            m_dsFieldList.Dispose()
        End If
        If Not m_dsEndtityList Is Nothing Then
            m_dsEndtityList.Dispose()
        End If
        If Not m_dsEndtityGrid Is Nothing Then
            m_dsEndtityGrid.Dispose()
        End If


    End Sub
    Protected Overrides Sub Finalize()
        '=====================================================================
        ' Procedure Name		:	Finalize
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To clear memory
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	09 May 2008
        ' Revisions				:	
        '=====================================================================
        MyBase.Finalize()
        Call ClearMemory()
    End Sub


    Protected Sub ReloadFrames()
        '====================================================================
        ' Procedure Name        :  ReloadFrames
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw page header 
        ' Description           :  This sub-routine draws page header 
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  PurvaJ
        ' Created               :  05-May-2008
        ' Revisions             :  
        '=====================================================================

    End Sub

    Protected Sub UpdateSession()
        Dim strProjectID As String = ""
        Dim strProjectName As String = ""
        Dim strMainPage As String = ""
        Dim strHashtableKey As String = ""
        Dim strPath As String = System.AppDomain.CurrentDomain.BaseDirectory
        Dim strFromWhere As String = "PM"

        strPath = strPath.Replace("/", "\")
        strProjectID = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Params("ProjectID"), "")

        If strProjectID <> CommonFunction.General.CheckIsNothing(Session("intProjectID"), "") And strProjectID <> "" Then

            Session("intProjectID") = strProjectID
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select ProjectName from tbl_PM_Project where ProjectID=" + strProjectID.ToString(), True), ""), "")
            strProjectName = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_tbl_PM_Project_ProjectName " + strProjectID.ToString(), True), ""), "")
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            Session("strProjectName") = strProjectName
            Session("intPostID") = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_Sel_EmployeeRoleOnProject " + CType(HttpContext.Current.Session("intUserID"), String) + "," + strProjectID + "," + CType(Context.Session("LoginType"), String), True), "0"), String)
            strHashtableKey = "PM-" & Session("intProjectID") & "-" & CType(Context.Session("intUserId"), String) & "-" & CType(Context.Session("intPostID"), String) & "-" & CType(Context.Session("LoginType"), String)

            If CommonEngines.HashTables.GetHashTableObject.IsUserTreeKeyExists(strHashtableKey) = False Then
                CommonEngines.HashTables.CreateHashTables.AddUserTreeKey(strHashtableKey)
                Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
            Else
                If CommonFunctions.FileDirectory.IsFileExists(strPath + "Reports\" & strHashtableKey & ".html") = False Then
                    Call m_GenerateTree.GenerateHTMLTree("", strFromWhere, MyBase.DefaultUILCID, CType(Session("LCID"), Long))
                End If
            End If
            If strMainPage = "" Then strMainPage = "../../Reports/" & strHashtableKey & ".html"
            'CommonFunction.General.WriteHTML("<Script language='javascript'>")
            'CommonFunction.General.WriteHTML("window.parent.document.frames['link'].location.reload();")
            'CommonFunction.General.WriteHTML("window.parent.document.frames['Main'].location.href='" + strMainPage + "';" + vbCrLf)
            'CommonFunction.General.WriteHTML("</Script>")
        End If

        ''PrashantSJ 12th June 2009
        strMainPage = "ProjectID_PK=" + strProjectID
        ''PrashantSJ
        Response.Clear()
        Response.Write(strMainPage)
        Response.End()
    End Sub
#End Region

#Region "Functions"
    Private Function InitializeMenu() As String
        '====================================================================
        ' Procedure Name        :  InitializeMenu
        ' Parameters Passed     :  None
        ' Returns               :  None
        ' Parameters Affected   :  None
        ' Purpose               :  To draw the page menu
        ' Description           :  This sub-routine draws page menu
        ' Assumptions           :  None
        ' Dependencies          :  None
        ' Author                :  MahendraV
        ' Created               :  05-April-2008
        ' Revisions             :  
        '=====================================================================

        Dim ArrMenuCaptionsList As New ArrayList 'Arraylist for Menu captions
        Dim ArrClientSideFunctionsList As New ArrayList 'ArrayList for menu client side functions
        Dim ArrMenuToolTipsList As New ArrayList 'ArrayList for Menu ToolTips
        Dim strMenu As String = ""

        'Added if condition by SuchitraP on 1-Aug-2008 to hide filter option for CRM workflow
        If m_strEntityTagID <> "8035" Then
            ArrMenuCaptionsList.Add("<img id='imgFilter' style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\Filter.gif' alt='Filter'/>")
            ArrMenuToolTipsList.Add("Filter")
            ArrClientSideFunctionsList.Add("showFilters(1)")
        End If

        If m_strFromWhere = "CRM" Then
            ArrMenuCaptionsList.Add("Select Request to Publish")
            ArrMenuToolTipsList.Add("Select Request to Publish")
            ArrClientSideFunctionsList.Add("PublishKM_OnClick()")

            '--- Commented by purvaj on 10 Jul 2009 SEM 8.1 New UI Changes.
            '''ArrMenuCaptionsList.Add("<img style='text-decoration:none;' border='0' src='..\..\Images\cssImages\Link Images\close.gif' alt='Close'/>Close")
            '''ArrMenuToolTipsList.Add("Close")
            '''ArrClientSideFunctionsList.Add("Close_OnClick()")
            '--- End comment purvaj
        End If

        ArrMenuCaptionsList.Add("<Img Border=0 src='../../Images/cssImages/Link images/help.gif'>")
        ArrMenuToolTipsList.Add("Help")
        ArrClientSideFunctionsList.Add("Help_OnClick('3936')")

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

        m_objMenu = New WebPage.Templates.StaticMenu
        strMenu = m_objMenu.DrawMenuWithEvents(ArrMenuCaptions, ArrClientSideFunctions, ArrMenuToolTips, True)
        m_objMenu = Nothing
        Return strMenu
    End Function
    Protected Function DisplayCurrentFilter() As String
        '=====================================================================
        ' Procedure Name		:	DisplayCurrentFilter
        ' Parameters Passed		:	
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To display current applied filter string.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	MahendraV
        ' Created				:	13 April 2008
        ' Revisions				:	
        '=====================================================================
        Dim sbFilterHTML As StringBuilder
        Dim strPageingHTML As String = ""

        Dim strTitle As String = ""
        sbFilterHTML = New StringBuilder("<BR><TABLE id='tblCurrentFilter'  cellspacing=0 cellpadding=0 Width='99.9%'  class=clsTable><TR class=clsTRPageCaption>")

        If Trim(m_strAppliedFilters & "") <> "" Then
            If m_strAppliedFilters.Length > 100 Then
                strTitle = "Current Filter :" + m_strAppliedFilters
                m_strAppliedFilters = m_strAppliedFilters.Substring(0, 100)
            Else
                strTitle = "Current Filter :" + m_strAppliedFilters
            End If
            If m_strAppliedFilters = "None" Then
                sbFilterHTML.Append("<td align=left  >Current Filter : " + m_strAppliedFilters)
            Else
                sbFilterHTML.Append("<td align=left  >Current Filter : ")
                ''Commented and Added By Vidya Jadhav ON 1 Sep 2016 For Mastercard  NextGen Upgrade
                'sbFilterHTML.Append("<A href='javascript:showFilters(1)' title='" + strTitle + "' >" + m_strAppliedFilters + "</A>")
                sbFilterHTML.Append("<A href='javascript:showFilters(1)' title='" + strTitle + "' >" + HttpUtility.HtmlEncode(m_strAppliedFilters) + "</A>")
                ''End Of Commented and Added By Vidya Jadhav ON 1 Sep 2016 For Mastercard  NextGen Upgrade
                If m_strAppliedFilters <> "None" Then
                    sbFilterHTML.Append("<img id='imgFilter' style='text-decoration:none;'border='0' src='..\..\Images\cssImages\Link Images\Clearfilter.gif' alt='Clear Filter' onclick='ClearFilter()'/>")
                End If
                sbFilterHTML.Append("</td>")
            End If
            sbFilterHTML.Append("<TD align=right>")
            strPageingHTML = DrawPaging()
            sbFilterHTML.Append(strPageingHTML)
            sbFilterHTML.Append("</TD>")

            sbFilterHTML.Append("</tr></table>")
            sbFilterHTML.Append("<BR>")
        End If
        If m_strAppliedFilters = "" Then
            sbFilterHTML.Append("<td align=left  >Current Filter : None")
            sbFilterHTML.Append("</td>")

            sbFilterHTML.Append("<TD align=right>")
            strPageingHTML = DrawPaging()
            sbFilterHTML.Append(strPageingHTML)
            sbFilterHTML.Append("</TD>")

            sbFilterHTML.Append("</tr></table>")
            sbFilterHTML.Append("<BR>")
        End If
        DisplayCurrentFilter = sbFilterHTML.ToString()
    End Function
    ''ADDED BY NILESH G ON 20/1/2016 FOR SECURITY URL ISSUE

    ''Commented and Added by Dhanashri S on 11 Aug 2016 2016 Pktoken validation
    '<System.Web.Services.WebMethod> _
    'Public Shared Function GenrateURLToken(WFInstanceID As String, TagID As String, UniqueID As String) As String
    '    Dim m_PKToken_Request_Multiple As String
    '    m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(WFInstanceID, String) + CType(TagID, String) + CType(UniqueID, String) + "0" + "0")
    '    Return m_PKToken_Request_Multiple

    'End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken(UniqueID As String, EmployeeID As String, TagID As String, WFInstanceID As String) As String
        Dim m_PKToken_Request_Multiple As String
        'm_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(UniqueID, String) + CType(EmployeeID, String) + CType(TagID, String) + "0" + "0" + CType(WFInstanceID, String))
        'Added By Tejal 13/8/2016 purpose Pk token Validation
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(UniqueID, String) + CType(EmployeeID, String) + "0" + "0" + CType(TagID, String) + CType(WFInstanceID, String))
        'End of By Tejal 13/8/2016 purpose Pk token Validation

        Return m_PKToken_Request_Multiple

    End Function
    '<System.Web.Services.WebMethod> _
    'Public Shared Function GenrateURLToken1(strWFPrimaryKey As String) As String
    '    Dim m_PKToken_Request_Multiple As String
    '    m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(strWFPrimaryKey, String) + "0" + "0")
    '    Return m_PKToken_Request_Multiple

    'End Function
    <System.Web.Services.WebMethod> _
    Public Shared Function GenrateURLToken1(WFInstanceID As String, EmployeeID As String) As String
        Dim m_PKToken_Request_Multiple As String
        m_PKToken_Request_Multiple = CommonFunctions.Security.Token.GetToken(CType(WFInstanceID, String) + CType(EmployeeID, String) + "0" + "0")
        Return m_PKToken_Request_Multiple
    End Function
    ''End of Addition by Dhanashri S on 11 Aug 2016
    ''ENDDED BY NILESH G ON 20/1/2016 FOR SECURITY URL ISSUE


    Private Function DrawPaging() As String
        '=====================================================================
        ' Procedure Name        : DrawPaging()
        ' Purpose               : To Plot Paging
        ' Parameters Passed     : None
        ' Returns               : string
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : 
        ' Author                : MahendraV
        ' Created               : May  14 ,2008
        ' Revisions             :
        '=====================================================================

        Dim PagingSQL As String
        Dim strSQL As String = ""
        Dim sbPaging As New StringBuilder

        Dim dtCountData As DataTable = New DataTable("CountRow")
        dtCountData = m_dsEndtityGrid.Tables(0).Clone()
        Dim drGridData() As DataRow = m_dsEndtityGrid.Tables(0).Select(IIf(m_strAdvanceFilterWhereClause <> "", m_strAdvanceFilterWhereClause, ""))
        For Each copyRow As DataRow In drGridData
            dtCountData.Rows.Add(copyRow.ItemArray)
        Next
        m_intTotalNoOfRows = dtCountData.Rows.Count

        If Math.Ceiling(m_intTotalNoOfRows / m_PageSize) < m_intPageNumber Then
            m_intPageNumber = 1
        End If

        sbPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowFirstPage()"" Title=""First Page"" onmouseover=""window.status='First Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPaging.Append("<Img Border=0 src='../../Images/NumNavFirstEnable.gif' align='top'></A>")
        sbPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowPreviousPage()""  Title=""Previous Page"" onmouseover=""window.status='Previous Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPaging.Append("<Img Border=0 src='../../Images/NumNavPreviousEnable.gif' align='top'></A>")

        If m_intPageNumber = -1 Or m_intTotalNoOfRows = 0 Then
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            sbPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, "", "right", ToBeInserted:="onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)' ", returnHTML:=True, EnableHTMLEncode:=True))
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

        Else
            'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
            sbPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtPageNumber", "txtPageNumber", , 50, 4, m_intPageNumber.ToString, "right", ToBeInserted:="onkeypress='txtPageNumber_KeyPress(event)' onblur='txtPageNumber_OnBlur(this)'", returnHTML:=True, EnableHTMLEncode:=True))
            'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        End If
        sbPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowNextPage()"" Title=""Next Page"" onmouseover=""window.status='Next Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPaging.Append("<Img Border=0 src='../../Images/NumNavNextEnable.gif' align='top'></A>")
        sbPaging.Append("<A style='TEXT-DECORATION:NONE' HREF=""Javascript:ShowLastPage()"" Title=""Last Page"" onmouseover=""window.status='Last Page';return true;"" onmouseout=""window.status=' ';return true;"">")
        sbPaging.Append("<Img Border=0 src='../../Images/NumNavLastEnable.gif' align='top'></A> ")
        sbPaging.Append("<input type=hidden id=hidNoOfPages value=" + (Math.Ceiling(m_intTotalNoOfRows / m_PageSize)).ToString + ">")

        sbPaging.Append(" of " + (Math.Ceiling(m_intTotalNoOfRows / m_PageSize)).ToString)
        'sbPaging.Append("|<A href='javascript:Page_OnClick(""-1"")' TITLE='Show All Records'><B>All</B></A>")
        'Modified by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding
        sbPaging.Append(CommonFunction.HTMLControls.DrawTextBox("txtNoOfPages", "txtNoOfPages", , , , (Math.Ceiling(m_intTotalNoOfRows / m_PageSize)).ToString, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
        'End Of Modification by Chakshuta H on 7th-Oct-2015 Purpoe::HTML Encoding

        Return sbPaging.ToString()


    End Function


#End Region

End Class
#End Region
