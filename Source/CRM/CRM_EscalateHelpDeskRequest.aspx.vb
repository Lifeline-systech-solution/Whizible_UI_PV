#Region "Imports"
Imports WebPages.Template
Imports CommonFunctions
Imports CommonFunctions.HTMLControls
#End Region
Public Class CRM_EscalateHelpDeskRequest
    Inherits WebPages.Template.WhizTemplate

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

#End Region
    Public m_strQueryID As String
    Protected m_strAction As String = ""
    Protected m_strMode As String = ""
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_lngRequestTypeId As Long
    Private lngFunctionID As Long
    Private m_intPostID As Integer
    Protected strOnloadClientScript As String
    Protected m_DepartmentID As String
    Protected m_NewDepartmentID As String
    Protected m_strDeptName As String
    'QueryString parameters for mail
    Protected m_strNewDepartment As String = ""
    Protected m_strNewDeptName As String = ""
    Protected m_strRequestType As String = ""
    Protected m_strSubRequestType As String = ""
    Protected m_strFromWhere As String = ""
    'Added by SavitaS on 06 Jan 2006 for IssueID 1936  
    Protected intIsTask_IssueCreated As Integer = 0
    ' added by harshada d on 10 feb 2006 for heldesk enhancements
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    Protected WithEvents frmCRMEscalateHelpDeskRequest As System.Web.UI.HtmlControls.HtmlForm
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    'end of addition by harshada d
    'End addition by SavitaS

    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_strQueyID As String
    Protected m_PKToken_FromRequestDetail As String
    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Put user code to initialize the page here

        m_intPostID = CType(Session("intPostID"), Integer)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        If Not Request.QueryString("fromwhere") Is Nothing Then
            m_strFromWhere = Request.QueryString("fromwhere")
            HttpContext.Current.Session("fromwhere") = m_strFromWhere
        Else
            m_strFromWhere = "FromDB"
        End If

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If
        'Added by Shamkant S on 20 Jan 2016
        If Not Request.QueryString("QueryID") Is Nothing Then
            m_strQueryID = CType(Request.QueryString("QueryID"), String)
            HttpContext.Current.Session("QueryID") = m_strQueryID
        Else
            m_strQueryID = 0
        End If
        'Ended By Shamkant S on 20 Jan 2015
        If Not Request.QueryString("Department") Is Nothing Then
            m_strDeptName = CType(Request.QueryString("Department"), String)
        Else
            m_strDeptName = ""
        End If

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_PKToken_FromRequestDetail = Request.QueryString("PKToken")
        Else
            m_PKToken_FromRequestDetail = Request.Form("txtPkToken").ToString
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197   

    End Sub

    Public Sub PageInitUI()
        '=====================================================================
        ' Function Name         : PageInitUI()	
        ' Purpose               : call methods for page 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Author                : SavitaS
        ' Created               : Nov 19 2005
        ' Revisions             :
        '=====================================================================
        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197 
        If (CommonFunctions.Security.Token.ValidateToken(m_strQueryID.ToString + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_FromRequestDetail) = True) Then
            'Added by SavitaS on 06 Jan 2006 for IssueID 1936 
            'Purpose: To check whether Tasks or Issues are created against the help desk request.
            Call ReadHTML()
            'End Addition by SavitaS 
            Call DrawMenu()
            ' Call DrawPageLegends()
            Call DrawMainHeaderFooter()
            Call PerformActions()
            Call GeneratePage()
            Call DrawMenu()
        Else
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Change Department", 0, 0, "Query ID", CType(m_strQueryID, String))
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
    End Sub
    Public Sub ReadHTML()
        If Request.QueryString("IsXMLHTTP") = "1" Then
            Response.Clear()

            Dim drIsTaskCreated As IDataReader
            Dim strSQLIsTaskCreated As String
            Dim dr As IDataReader

            strSQLIsTaskCreated = "select TaskID from tbl_pm_projectTasks where CRMQueryID = " & m_strQueryID.ToString
            strSQLIsTaskCreated += " union all select IssueID from tbl_IB_issue where CRMQueryID = " & m_strQueryID.ToString
            strSQLIsTaskCreated += " union all select DeliverableID from tbl_CRM_Query_Master where DeliverableID IS NOT NULL and QueryID = " & m_strQueryID.ToString
            strSQLIsTaskCreated += " union all select AssignTo from tbl_CRM_Query_Master where AssignTo IS NOT NULL and AssignTo <> 0 and QueryID = " & m_strQueryID.ToString

            'End Modification by SavitaS
            drIsTaskCreated = CommonFunctions.Data.GetDataReader(strSQLIsTaskCreated, MyBase.UseSQL)
            Dim strIsTaskCreated As String
            If drIsTaskCreated.Read Then
                strIsTaskCreated = CommonFunctions.Data.CheckIsDBNull(drIsTaskCreated("TaskID"), "0").ToString
            End If
            If Not strIsTaskCreated Is Nothing Then
                If strIsTaskCreated = "0" Or strIsTaskCreated = "" Then
                    intIsTask_IssueCreated = 0
                Else
                    intIsTask_IssueCreated = 1
                End If
            End If
            CommonFunctions.Data.DisposeDataReader(drIsTaskCreated)

            If intIsTask_IssueCreated = 1 Then
                Response.Write("0")
            Else
                Response.Write(Request.QueryString("QueryID"))
            End If
            Response.End()
        End If
    End Sub
    Public Sub DrawPageLegends()
        '=====================================================================
        ' Function Name         : DrawPageLegends()	
        ' Purpose               : To draw Page Legends 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Author                : SavitaS
        ' Created               : Nov 19 2005
        ' Revisions             :
        '=====================================================================
        'code for legends section
        Dim strPageLegend As New PageLegends
        Dim arrLegendImg() As String = {"<img src='../../Images/Star.gif'>"}
        Dim arrLegend() As String = {"Mandatory"}

        General.WriteHTML(strPageLegend.DrawPageLegends(Nothing, arrLegendImg, arrLegend))
    End Sub
    Private Sub DrawMenu()
        '=====================================================================
        ' Function Name         : DrawMenu()	
        ' Purpose               : To draw Menu 
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Author                : SavitaS
        ' Created               : Nov 19 2005
        ' Revisions             :
        '=====================================================================
        'Code for drawing menus,tooltips,captions
        Dim arrMenuNames() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), "?"}
        Dim arrMenuFunction() As String = {"Save_OnClick()", "Close_OnClick()", "Help_OnClick('Change_Dept')"}

        Dim arrToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), "Help"}

        CommonFunction.General.WriteHTML(WebPages.Template.StaticMenu.DrawMenu(arrMenuNames, arrMenuFunction, arrToolTip, True))
        MyBase.InitializeResources("AppResources.CRM_EscalateHelpDeskRequest", "AppResources")
    End Sub
    Public Sub DrawMainHeaderFooter()
        '=====================================================================
        ' Function Name         : DrawMainHeaderFooter()	
        ' Purpose               : To draw HeaderFooter
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Author                : SavitaS
        ' Created               : Nov 19 2005
        ' Revisions             :
        '=====================================================================
        'Code for  main page's header footer section
        Dim objMainHeaderFooter As New HeaderFooter
        objMainHeaderFooter.DisplayPosition = HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        General.WriteHTML(objMainHeaderFooter.DrawHeaderFooter())

    End Sub
    Private Function GeneratePage() As String
        '=====================================================================
        ' Function Name         : GeneratePage()	
        ' Purpose               : To generate ComboBoxes
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Author                : SavitaS
        ' Created               : Nov 19 2005
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim strSQLSubReq As String
        Dim lngSubRequestID As Long
        Dim dr As IDataReader
        Dim strHDRID As String
        Dim strSubject As String
        Dim strDesc As String
        Dim strHDRID_Caption As String
        Dim strSubject_Caption As String
        Dim strDesc_Caption As String
        Dim objHeader As New HeaderFooter
        Dim intOldDeptID As Long
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<div id='divBody' style='overflow:auto;width=100%'>")
        General.WriteHTML("<div id='divBody' style='overflow:auto;width:100%'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'Commented And Added By Vaijat K ON 07/12/2015
        ' General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width=99.9%'>")
        General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width:99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'Commented And Added By Vaijat K ON 07/12/2015
        ' General.WriteHTML("<TR class='clsTRMenu' style='width=100%'>")
        General.WriteHTML("<TR class='clsTRMenu' style='width:100%'>")
        General.WriteHTML("<B>")
        General.WriteHTML("<TD WIDTH='100%'>" + MyBase.GetResourceString("MENU_ESCALATE_HELP_DESK_REQUEST"))
        General.WriteHTML("</B>")
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")
        General.WriteHTML("</TABLE>")
        '------------------------------
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven style='height=50%'>")
        General.WriteHTML("<TR class='clsTREven style='height:50%'>")
        CommonFunctions.General.WriteHTML("<br>")
        General.WriteHTML("<TD WIDTH='100%'>")
        General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</br>")
        General.WriteHTML("</TR>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<TABLE  Width='99.9%' cellspacing=0 class=clsTable>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<TR class=clsTRPageHeader><TD align=Left> <b>" + MyBase.GetResourceString("NOTE"))
        General.WriteHTML("</b>")
        General.WriteHTML("" + MyBase.GetResourceString("PAGE_CAP1"))
        General.WriteHTML("</TD></TR></TABLE>")
        '------------------------------
        'for spacing purpose
        'Commented And Added By Vaijat K ON 07/12/2015
        ' General.WriteHTML("<TR class='clsTREven style='height=50%'>")
        General.WriteHTML("<TR class='clsTREven style='height:50%'>")
        CommonFunctions.General.WriteHTML("<br>")
        General.WriteHTML("<TD WIDTH='100%'>")
        General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</br>")
        General.WriteHTML("</TR>")
        '------------------------------------------------------------------------
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width=99.9%'>")
        General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width:99.9%'>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven' style='width=100%'>")
        General.WriteHTML("<TR class='clsTREven' style='width:100%'>")
        '---------------------------------------------------------------------------------------------------
        'To retrive Caption from "Configuration->HelpDesk->Sub Request Type" for respective Sub Request Type 


        ''strSQLSubReq = "Select SubRequestTypeID from tbl_CRM_Query_Master where QueryID=" & m_strQueryID
        strSQLSubReq = "usp_sel_tbl_CRM_Query_Master_SubRequestTypeID '" & m_strQueryID.ToString & "'"


        dr = CommonFunctions.Data.GetDataReader(strSQLSubReq, MyBase.UseSQL)
        If dr.Read Then
            lngSubRequestID = CType(CommonFunctions.Data.CheckIsDBNull(dr("SubRequestTypeID"), "0"), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_CRM_SubRequestType_Caption " & lngSubRequestID, MyBase.UseSQL)
        If dr.Read Then
            strHDRID_Caption = dr("QueryID").ToString & ""
            strSubject_Caption = dr("Subject").ToString & ""
            strDesc_Caption = dr("Description").ToString & ""
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        '---------------------------------------------------------------------------------------------------
        Dim QID As Long
        QID = CType(CommonFunctions.Data.CheckIsDBNull(m_strQueryID, "0"), Long)
        strHDRID = QID.ToString

        'Label for HelpDeskRequestId 
        General.WriteHTML("<TD WIDTH='10%'>")
        General.WriteHTML("<B>")
        General.WriteHTML("<TD WIDTH='25%'>" + strHDRID_Caption)
        General.WriteHTML("</TD>")
        General.WriteHTML("</B>")

        General.WriteHTML("<TD WIDTH='80%'>" + strHDRID)
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")


        'Label for  Subject 
        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "select Subject from tbl_CRM_Query_Master where QueryID=" & m_strQueryID
        strSQL = "usp_sel_tbl_CRM_Query_Master_Subject '" & m_strQueryID.ToString() & "'"
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If dr.Read Then
            strSubject = CType(CommonFunctions.Data.CheckIsDBNull(dr("Subject"), "0"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven' style='width=100%'>")
        General.WriteHTML("<TR class='clsTREven' style='width:100%'>")
        General.WriteHTML("<TD WIDTH='10%'>")
        General.WriteHTML("<TD WIDTH='25%'>" + strSubject_Caption)
        General.WriteHTML("</TD>")
        General.WriteHTML("<B>")
        General.WriteHTML("<TD WIDTH='80%'>" + strSubject)
        General.WriteHTML("</TD>")
        General.WriteHTML("</B>")
        General.WriteHTML("</TR>")
        '------------------------------------------------
        'Label for  Description

        ''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "select Description from tbl_CRM_Query_Master where QueryID=" & m_strQueryID
        strSQL = "usp_sel_tbl_CRM_Query_Master_Description '" & m_strQueryID.ToString() & "'"
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If dr.Read Then
            strDesc = CType(CommonFunctions.Data.CheckIsDBNull(dr("Description"), "0"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven' style='width=100%'>")
        General.WriteHTML("<TR class='clsTREven' style='width:100%'>")
        General.WriteHTML("<TD WIDTH='10%'>")
        General.WriteHTML("<B>")
        General.WriteHTML("<TD WIDTH='25%'>" + strDesc_Caption)
        General.WriteHTML("</B>")
        General.WriteHTML("</TD>")
        General.WriteHTML("<TD WIDTH='80%'>" + strDesc)
        General.WriteHTML("</TD>")

        General.WriteHTML("</TR>")
        General.WriteHTML("</TABLE>")

        '------------------------------
        'Table added for spacing purpose
        'General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width=100%'>")
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven style='height=50%'>")
        General.WriteHTML("<TR class='clsTREven style='height:50%'>")
        CommonFunctions.General.WriteHTML("<br>")
        General.WriteHTML("<TD WIDTH='100%'>")
        General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</br>")
        General.WriteHTML("</TR>")
        'General.WriteHTML("</TABLE>")
        '---------------------------------------
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width=99.9%'>")
        General.WriteHTML("<TABLE class=clsTable cellspacing=0 cellpadding=0 style='width:99.9%'>")
        'Ended by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        'Label for Department 
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven'  style='width=100%'>")
        General.WriteHTML("<TR class='clsTREven'  style='width:100%'>")
        General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_FROM_DEPT"))
        General.WriteHTML("</TD>")

        'Combo for Department 
        General.WriteHTML("<TD WIDTH='44%'>")

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT Department FROM tbl_CRM_Query_Master,tbl_PM_DepartmentMaster WHERE tbl_CRM_Query_Master.FunctionID = tbl_PM_DepartmentMaster.DepartmentID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID & " Order by Department"
        strSQL = "usp_sel_tbl_CRM_Query_Master_Department " & m_strQueryID
        ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        CommonFunctions.HTMLControls.DrawComboBox("cboDepartment", strSQL, 220, , "disabled", False, , , False, )
        General.WriteHTML("</TD>")

        'Label for New Department 
        General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_TO_DEPT"))
        General.WriteHTML("</TD>")

        'Combo for New Department
        General.WriteHTML("<TD WIDTH='55%'>")

        '-----------------------------------------------------------------
        'Added by SavitaS on 23 Dec 2005
        'To populate department combo with departments other than the one to which selected request belongs.

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT DepartmentID,Department FROM tbl_CRM_Query_Master,tbl_PM_DepartmentMaster WHERE tbl_CRM_Query_Master.FunctionID = tbl_PM_DepartmentMaster.DepartmentID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID
        strSQL = "usp_sel_tbl_CRM_Query_Master_ID_Department " & m_strQueryID
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If dr.Read Then
            intOldDeptID = CType(CommonFunctions.Data.CheckIsDBNull(dr("DepartmentID"), ""), Long)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)
        strSQL = "usp_CRM_GetFunctions_ForRole_ForMoveDept " & intOldDeptID.ToString & "," & Session("intPostID").ToString
        'End Addition on 23 Dec 2005 by SavitaS
        '-----------------------------------------------------------------

        'If lngFunctionID = 0 Then
        '    dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        '    If dr.Read Then lngFunctionID = CType(CommonFunctions.Data.CheckIsDBNull(dr("DepartmentID"), "0"), Long)
        '    CommonFunctions.Data.DisposeDataReader(dr)
        'End If
        CommonFunctions.HTMLControls.DrawComboBox("cboNewDepartment", strSQL, 220, lngFunctionID.ToString, "onchange=javascript:Combo_OnChange()", True, , , True, )

        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")
        '---------------------------------------------


        'label for Request Type 
        'Commented And Added By Vaijat K ON 07/12/2015
        'General.WriteHTML("<TR class='clsTREven' style='width=100%'>")
        General.WriteHTML("<TR class='clsTREven' style='width:100%'>")
        General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_FROM_REQUEST_TYPE"))
        General.WriteHTML("</TD>")

        ''Modified by Manishk on 28th Feb 2006 for The  help desk issues for SplitRequestTypeSubType
      
            If CommonFunction.Application.SplitRequestTypeSubType = True Then

                'combo for Request Type 
                General.WriteHTML("<TD WIDTH='44%'>")
            'Commented and modified by MonikaI on 3-10-2006. IssueID : 6478
            'strSQL = "SELECT RequestType FROM tbl_CRM_Query_Master,tbl_CRM_RequestType WHERE tbl_CRM_Query_Master.RequestTypeID = tbl_CRM_RequestType.RequestTypeID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT RequestType FROM tbl_CRM_Query_Master,tbl_CRM_RequestType WHERE tbl_CRM_Query_Master.RequestTypeID = tbl_CRM_RequestType.RequestTypeID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID & " Order by RequestType"
            strSQL = "usp_sel_tbl_CRM_Query_Master_RequestType " & m_strQueryID
            ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'End by MonikaI
            CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 220, , "disabled", False, , , False, )
                General.WriteHTML("</TD>")

                'Label for New Request Type 
                General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_TO_REQUEST_TYPE"))
                General.WriteHTML("</TD>")

                'Combo for New Request Type 
                General.WriteHTML("<TD WIDTH='55%'>")
                Dim strSQLReqType As New System.Text.StringBuilder("")
                strSQLReqType.Append("select distinct tbl_CRM_Function_RequestTypes.RequestTypeID ,tbl_CRM_RequestType.RequestType from ")
                strSQLReqType.Append(" tbl_CRM_Function_RequestTypes ,tbl_CRM_RequestType ")
                strSQLReqType.Append(" where tbl_CRM_Function_RequestTypes.RequestTypeID = tbl_CRM_RequestType.RequestTypeID ")
                strSQLReqType.Append(" and functionID = ")
            strSQLReqType.Append(lngFunctionID)
            'Added by MonikaI on 3-10-2006. IssueID : 6478
            strSQLReqType.Append(" Order by tbl_CRM_RequestType.RequestType")
            'End of addition by MonikaI
            'modified by harshada d for helpdesk ehanacements whiziblesem 6 issue id 1936 
            If Trim(MyBase.GetFormValue("cboNewDepartment") & "") = "" Then
                m_lngRequestTypeId = 0
            End If
            If Trim(MyBase.GetFormValue("cboNewRequestType") & "") = "" Then
                m_lngRequestTypeId = 0
            End If
            ' strSQL = "usp_CRM_RequestTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0"
            'modified by harshada d for helpdesk ehanacements whiziblesem 6 issue id 1936 
            CommonFunctions.HTMLControls.DrawComboBox("cboNewRequestType", strSQLReqType.ToString, 220, m_lngRequestTypeId.ToString, "onchange=javascript:Combo_OnChange()", True, , , True, )
            strSQLReqType = Nothing
            General.WriteHTML("</TD>")
            General.WriteHTML("</TR>")
            'Label for Sub Request Type 
            'Commented And Added By Vaijat K ON 07/12/2015
            'General.WriteHTML("<TR class='clsTREven'  style='width=100%'>")
            General.WriteHTML("<TR class='clsTREven'  style='width:100%'>")
            General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_FROM_SUBREQUEST_TYPE"))
            General.WriteHTML("</TD>")

            'Combo for Sub Request Type 
            General.WriteHTML("<TD WIDTH='44%'>")
            'Commented and modified by MonikaI on 3-10-2006. IssueID : 6478
            'strSQL = "SELECT SubRequestType FROM tbl_CRM_Query_Master,tbl_CRM_SubRequestType WHERE tbl_CRM_Query_Master.SubRequestTypeID = tbl_CRM_SubRequestType.SubRequestTypeID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT SubRequestType FROM tbl_CRM_Query_Master,tbl_CRM_SubRequestType WHERE tbl_CRM_Query_Master.SubRequestTypeID = tbl_CRM_SubRequestType.SubRequestTypeID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID & " Order by SubRequestType"
            strSQL = "usp_sel_tbl_CRM_Query_Master_SubRequestType " & m_strQueryID
            ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'End by MonikaI
            CommonFunctions.HTMLControls.DrawComboBox("cboSubRequestType", strSQL, 220, , "disabled", False, , , False, )
            General.WriteHTML("</TD>")

            'Label for New Sub Request Type 
            General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_TO_SUB_REQUEST_TYPE"))
            General.WriteHTML("</TD>")

            'Combo for Sub Request Type 
            General.WriteHTML("<TD WIDTH='55%'>")
            Dim strSQLSubReqType As New System.Text.StringBuilder("")
            strSQLSubReqType.Append(" select distinct tbl_CRM_Function_RequestTypes.SubRequestTypeID,tbl_CRM_subRequestType.subRequestType")
            strSQLSubReqType.Append(" from tbl_CRM_Function_RequestTypes ,tbl_CRM_subRequestType")
            strSQLSubReqType.Append(" where tbl_CRM_Function_RequestTypes.subRequestTypeID = tbl_CRM_subRequestType.subRequestTypeID")
            strSQLSubReqType.Append(" and RequestTypeID = ")
            strSQLSubReqType.Append(m_lngRequestTypeId.ToString)
            strSQLSubReqType.Append(" and functionID = ")
            strSQLSubReqType.Append(lngFunctionID.ToString)
            'Added by MonikaI on 3-10-2006. IssueID : 6478
            strSQLSubReqType.Append(" Order by tbl_CRM_subRequestType.subRequestType")
            'End of addition by MonikaI
            'strSQL = "usp_CRM_RequestSubTypes " & lngFunctionID & ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "','" & CommonFunctions.General.BuildQueryString(m_strLoginType) & "',0," & CommonFunctions.General.BuildQueryString(m_lngRequestTypeId.ToString)

            CommonFunctions.HTMLControls.DrawComboBox("cboNewSubRequestType", strSQLSubReqType.ToString, 220, , , True, , , True, )
            strSQLSubReqType = Nothing
            General.WriteHTML("</TD>")
            General.WriteHTML("</TR>")

            '--------------------------------------------
        Else
            '    'combo for Request Type without split
            General.WriteHTML("<TD WIDTH='44%'>")
            'Commented and modified by MonikaI on 3-10-2006. IssueID : 6478
            'strSQL = "SELECT RequestType + '->' + SubRequestType FROM tbl_CRM_Query_Master Q,tbl_CRM_RequestType R,tbl_CRM_SubRequestType SR WHERE Q.RequestTypeID = R.RequestTypeID AND Q.SubRequestTypeID=SR.SubRequestTypeID AND Q.QueryID=" & m_strQueryID

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''strSQL = "SELECT RequestType + '->' + SubRequestType FROM tbl_CRM_Query_Master Q,tbl_CRM_RequestType R,tbl_CRM_SubRequestType SR WHERE Q.RequestTypeID = R.RequestTypeID AND Q.SubRequestTypeID=SR.SubRequestTypeID AND Q.QueryID=" & m_strQueryID & " Order by RequestType"
            strSQL = "usp_sel_tbl_CRM_Query_Master_RequestType_SubRequestType " & m_strQueryID
            ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            'End by MonikaI
            CommonFunctions.HTMLControls.DrawComboBox("cboRequestType", strSQL, 220, , "disabled", False, , , False, )
            General.WriteHTML("</TD>")
            'Label for New Request Type 
            General.WriteHTML("<TD WIDTH='20%'>" + MyBase.GetResourceString("CAPTION_CHG_TO_REQUEST_TYPE"))
            General.WriteHTML("</TD>")

            'Combo for New Request Type 
            General.WriteHTML("<TD WIDTH='55%'>")
            Dim strSQLReq As String = "usp_CRM_RequestType_PopulateCombo " + lngFunctionID.ToString + ", 1"
            CommonFunctions.HTMLControls.DrawComboBox("cboNewRequestType", strSQLReq, 220, m_lngRequestTypeId.ToString, , True, , , True, )
            '"onchange=javascript:Combo_OnChange()"
            General.WriteHTML("</TD>")
            General.WriteHTML("</TR>")
            '--------------------------------------------
        End If
        ''eND OF Modified by Manishk on 28th Feb 2006 for The  help desk issues for SplitRequestTypeSubType
        ''''**************

        General.WriteHTML("</TABLE>")

        '-----------------------------------------------------------------
        'For spacing purpose
        General.WriteHTML("<TR class='clsTREven style='height=50%'>")
        General.WriteHTML("<TD WIDTH='100%'>")
        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")
        '----------------------------------------------------------------

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        'Commented and added by Yogesh J for HTML encoding Date:05/10/15
        CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:05/10/15

        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

        General.WriteHTML("</TABLE>")

        General.WriteHTML("</Div>")

    End Function

    Private Sub PerformActions()
        '=====================================================================
        ' Function Name         : PerformActions()	
        ' Purpose               : To take requested values from respective combo box 
        '                         and perform respective updates.
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : string
        ' Author                : SavitaS
        ' Created               : Nov 19 2005
        ' Revisions             :
        '=====================================================================
        Dim ReqID As String
        Dim strSQL As String
        Dim dr As IDataReader
        ReqID = m_strQueryID.ToString

        'Added code to get values for querystring for mail

        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strSQL = "SELECT DepartmentID FROM tbl_CRM_Query_Master,tbl_PM_DepartmentMaster WHERE tbl_CRM_Query_Master.FunctionID = tbl_PM_DepartmentMaster.DepartmentID AND tbl_CRM_Query_Master.QueryID=" & m_strQueryID
        strSQL = "usp_sel_tbl_CRM_Query_Master_DepartmentID " & m_strQueryID
        ''''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
        If dr.Read Then
            m_DepartmentID = CType(CommonFunctions.Data.CheckIsDBNull(dr("DepartmentID"), "0"), String)
        End If
        CommonFunctions.Data.DisposeDataReader(dr)

        m_NewDepartmentID = MyBase.GetFormValue("cboNewDepartment")

        'Code Ends
        'Modified by ManishK on 28th Feb 2006 for SP 6Help desk issue
        If CommonFunction.Application.SplitRequestTypeSubType = True Then
            If Trim(MyBase.GetFormValue("cboNewRequestType") & "") <> "" Then
                m_lngRequestTypeId = CType(Trim(MyBase.GetFormValue("cboNewRequestType") & ""), Long)
            End If
        Else
            If Trim(MyBase.GetFormValue("cboNewRequestType") & "") <> "" Then
                Dim strTemp As String()
                StrTemp = Trim(MyBase.GetFormValue("cboNewRequestType")).Split(CChar("|"))
                m_lngRequestTypeId = CType(strTemp(0), Long)
            End If
        End If
        'End Modified by ManishK on 28th Feb 2006 for SP 6Help desk issue
        If Trim(MyBase.GetFormValue("cboNewDepartment") & "") <> "" Then
            lngFunctionID = CType(MyBase.GetFormValue("cboNewDepartment"), Long)

        End If

        If m_strAction = "SAVE" Then

            '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
            If (m_strQueryID.ToString <> "0") Or (CommonFunctions.Security.Token.ValidateToken(CType(m_strQueryID, String) + CType(Session("intUserID"), String) + CType(0, String) + CType(0, String), m_PKToken_FromRequestDetail) = True) Then
                '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197

                'Save data
                If CommonFunction.Application.SplitRequestTypeSubType = True Then
                    strSQL = " Exec usp_upd_EscalateHelpDeskRequestDetails "
                    strSQL += m_strQueryID & ",'"
                    strSQL += MyBase.GetFormValue("cboNewDepartment") & "',"
                    strSQL += "'" & MyBase.GetFormValue("cboNewRequestType") & "',"
                    strSQL += "'" & MyBase.GetFormValue("cboNewSubRequestType") & "'"
                    ''Added by ManishK on 28th Feb 06 For SP 6 Helpdesk issues
                Else
                    Dim strTemp As String()
                    strSQL = " Exec usp_upd_EscalateHelpDeskRequestDetails "
                    strSQL += m_strQueryID & ",'"
                    strSQL += MyBase.GetFormValue("cboNewDepartment") & "',"
                    strSQL += "'" & MyBase.GetFormValue("cboNewRequestType") & "'"
                    strTemp = strSQL.Split(CChar("|"))
                    strSQL = strTemp(0) & "', '" & strTemp(1)
                End If
                'Code Added By PradipK on 25 Jan 2007 
                'Purpose:- To update ModifyBy & ModifyDate in tbl_CRM_Query_Master table
                strSQL += ",'" & CommonFunctions.General.BuildQueryString(m_strUserName) & "'"
                'End Addition By PradipK on 25 Jan 2007 

                ''End of Added by ManishK on 28th Feb 06 For SP 6 Helpdesk issues
                CommonFunctions.Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                '-----------------------------------------------------------------
                'Refresh CRM_Dashboard Window after saving data to reflect changes
                Dim mode1 As String
                mode1 = CType(HttpContext.Current.Session("fromwhere"), String)

                If mode1 = "FromRD" Then
                    'Refresh e dashboard->Request Details window on Help Desk Page
                    CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
                    'Commented by ShraddhaM on 13,Nov 2007
                    'Purpose: We are closing opener, so no need to refresh it
                    'CommonFunctions.General.WriteHTML("window.opener.location.href =" & Chr(34) & "CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + m_strQueryID.ToString + Chr(34) + ";")
                    'end of comment by ShraddhaM
                    'Commented and added by ShraddhaM on 13,Nov 2007
                    'Purpose : Issue :- While changing department from My-Dashboard , e-Dashboard page getting open.
                    'CommonFunctions.General.WriteHTML("window.opener.opener.location.href =" & Chr(34) & "CRM_DASHBOARD.ASPX" + Chr(34) + ";")
                    CommonFunctions.General.WriteHTML("if((window.opener.opener.location.href.match('CRM_MyDashboard.aspx')=='CRM_MyDashboard.aspx') || (window.opener.opener.location.href.match('CRM_Dashboard.aspx')=='CRM_Dashboard.aspx') ) ")
                    CommonFunctions.General.WriteHTML("window.opener.opener.location.href =" & Chr(34) & "CRM_MyDashboard.aspx" + Chr(34) + ";")
                    'End of comment and addition by ShraddhaM on 13,Nov 2007
                    CommonFunctions.General.WriteHTML("window.opener.close();")
                    CommonFunctions.General.WriteHTML("</script>")
                End If

                'Refresh e-dahboard window on Help Desk Page
                If mode1 = "FromDB" Then
                    CommonFunctions.General.WriteHTML("<script LANGUAGE=Javascript>")
                    'Added by ShraddhaM on 13,Nov 2007 
                    'Purpose : Issue :- While changing department from My-Dashboard , e-Dashboard page getting open.
                    '                    We are closing opener, so no need to refresh it
                    'CommonFunctions.General.WriteHTML("window.opener.location.href =" & Chr(34) & "CRM_RequestDetail.aspx?Mode=EDIT&FromWhere=DB&QueryID=" + m_strQueryID.ToString + Chr(34) + ";")
                    CommonFunctions.General.WriteHTML("if((window.opener.opener.location.href.match('CRM_MyDashboard.aspx')=='CRM_MyDashboard.aspx') || (window.opener.opener.location.href.match('CRM_Dashboard.aspx')=='CRM_Dashboard.aspx') ) ")
                    CommonFunctions.General.WriteHTML("window.opener.opener.location.href =" & Chr(34) & "CRM_Dashboard.aspx" + Chr(34) + ";")
                    CommonFunctions.General.WriteHTML("window.opener.close();")
                    'End of addition by ShraddhaM on 13,Nov 2007
                    CommonFunctions.General.WriteHTML("</script>")
                End If
                'End Refresh
                '---------------------------------------------------------------
                'To close the "Move Help Desk Rquest" window after saving data
                CommonFunctions.General.WriteHTML("<Script language='javascript'>")
                CommonFunctions.General.WriteHTML("window.close();")
                CommonFunctions.General.WriteHTML("</Script>")

                'To get Changed Department name for querystring in strOnloadClientScript below
                m_strNewDepartment = MyBase.GetFormValue("cboNewDepartment")

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strSQL = "SELECT Department from tbl_PM_DepartmentMaster where DepartmentID=" & m_strNewDepartment
                strSQL = "usp_sel_tbl_PM_DepartmentMaster_Department " & m_strNewDepartment
                ''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                dr = CommonFunctions.Data.GetDataReader(strSQL, MyBase.UseSQL)
                If dr.Read Then
                    m_strNewDeptName = CType(CommonFunctions.Data.CheckIsDBNull(dr("Department"), ""), String)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)
                'End for getting New Department name

                'Added by SavitaS on 25 Nov 2005 to provide mail facility

                Dim drEmailMessage As IDataReader
                Dim blnSendEmail, blnShowPopup As Boolean

                drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 445", MyBase.UseSQL)
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
                    strOnloadClientScript = strOnloadClientScript + vbCrLf + "window.open(""../General/SendEmail.aspx?MessageID=445&RequestID=" + ReqID + "&Department=" + m_DepartmentID.ToString + "&NewDepartment=" + m_NewDepartmentID.ToString + "&DeptName=" + m_strDeptName.ToString + "&NewDeptName=" + m_strNewDeptName.ToString + """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");" + vbCrLf
                End If
                '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
            Else
                Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Change Department", 0, 0, "Query ID", CType(m_strQueryID, String))
                'Token is Invalid now redirect to the Invalid Access Page 
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
            '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197
        End If


    End Sub


    Public Sub New()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        '' MyBase.ApplySecurity(True, 2)
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Private Sub Page_Error1(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Error

    End Sub
End Class
