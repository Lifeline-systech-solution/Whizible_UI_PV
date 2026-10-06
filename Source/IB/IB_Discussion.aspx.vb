Imports CommonFunctions
'Code added by SiddharthS on 24 Mar 2005 for Issue Id 15475
Imports System.Web.HttpUtility
'Addition ends.

Public Class IB_Discussion
    Inherits WebPages.Template.WhizTemplate

    Protected CONST_DISCUSSION As String = "DISCUSS"
    Protected CONST_ACTION_SAVE As String = "SAVE"
    Protected m_strMode As String
    Private m_strAction As String
    Protected m_lngIssueID As Long = 0
    Private m_strUserName As String
    Protected m_strWindowTitle As String
    Private m_strRowCount As Boolean = False
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid

    ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueId 63 
    Private m_strCurrentStatus As String = ""
    Private m_strOldStatus As String = ""
    Private m_strCorporateStatus As String = ""
    Private m_strCurrentType As String = ""
    Private m_strStatusSQL As String = ""
    Private m_strProjectID As String
    Private m_strSessionUserID As String
    Private m_strSessionPostID As String
    Protected m_LoginType As String
    Private m_blnEditAccess As Boolean
    ' End Modification By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueId 63 

	'Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006
                    
  'Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
    'Added by ShubhadaL on 23 Feb 2006 for FourSoft - 927
    ' ShowToCustomer Checkbox goes blank when parent gets refreshed from DiscussionThread_Save click
    Protected m_Customer As Integer = 0

    'Integrated By Amit J whizible SP 7.2 Issue ID 2596
    'Added By Amit J On 17th july For IVL IssueId = 2596
    Protected m_strRoleId As Integer
    'End of Addition by Amit J For Issue Id 2596

    'End of Integration
    'End of addition by ShubhadaL on 23 Feb 2006 for FourSoft - 927
    'End Integration by SavitaS
    'End Integration
    
    'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
    'Code Added By PradipK on 24 Feb 2006
    Protected m_strStatusChangeDate As String = ""
    Protected m_strStatusChangeTime As String = ""
    Protected m_strReportedDate As String = ""
    Protected m_strReportedTime As String = ""
    Protected m_strOldStatusIssue As String = ""


    'End Addition By PradipK on 24 Feb 2006
    Protected m_IsIssueSLAApplicable As Boolean = False

    'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    Protected m_strToken As String
    Protected m_Mode As String
    Protected m_strIssueID As String
    'End of Added by SavitaS on 19 Sept 2006 for Security Issue 6197
    Protected m_strFromwhere As String = ""
    Protected m_strFromReview As String = "0"
    'Added by SrikanthY on 21 Dec 2006
    Protected m_PKQueryToken As String
    Protected m_Queryid As String
    'Added by SrikanthY on 22 Jan 2007
    Protected m_QuerySortBy As String
    Protected m_QuerySortOrder As String

    Private m_blnIsRecordInGrid As Boolean
    'Added by GaneshD on 08 Jun 2009 For Issue base StatusFlow configuration
    Protected m_StatusFlowCount As Integer
    'Addition end by GaneshD
    'Added by VijayD on 17 Aug 2009 For Maintaing Search Filter on the Issue_Entry Page
    Protected m_strIssueListSearchType As String
    Protected m_strIssueListSearchValue As String
    'Addition end by VijayD


#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        'MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region

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
        objGlobal.TagID = 5

        'Integrated By Amit J whizible SP 7.2 Issue ID 2596 
        'Added By Amit J For IVL IssueId = 2596 on 17th july
        'Purpose: To consider Project level Role Aceess depending on project selected in Support-->              Project Combo
        objGlobal.RoleID = m_strRoleId
        'End of Addition
        'End of Integration

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

      
        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        objAccess = Nothing
    End Sub 'Get all session variable values


    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        MyBase.ApplySecurity(True)
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_DISCUSS")

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
    End Sub
    Public Sub New()
        'MyBase.ApplySecurity(True, 1, , , True)
        'initialize the resource file for SDLC_Process page.
        MyBase.InitializeResources("AppResources.IB_Discussion", "AppResources")
    End Sub

    '=====================================================================
    ' Procedure Name		:	PageInit
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page
    ' Description			:	This is main procedure on this page which actually draw the page with its 
    '                           controls on it. This procedure is called from the HTML bady tag of the page.
    '                           this procedure gives the call to other procedures and functions in the class.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 9 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter

        'Added by SavitaS on 19 Sept 2006 for Security Issue 6197
        m_strIssueListSearchType = CommonFunctions.General.CheckIsNothing(Convert.ToString(Request.QueryString("IssueListSearchType")), "")
        m_strIssueListSearchValue = CommonFunctions.General.CheckIsNothing(Convert.ToString(Request.QueryString("IssueListSearchValue")), "0")

        If CType(m_strToken, String) <> "0" Then
            If Request.QueryString("PKToken") Is Nothing Then
                If Request.Form("txtPkToken") <> "" Then
                    m_strToken = Request.Form("txtPkToken").ToString
                End If
            Else
                m_strToken = Request.QueryString("PKToken").ToString
            End If
        End If

        If Not Request.QueryString("IssueID") Is Nothing Then
            m_strIssueID = Request.QueryString("IssueID").ToString
        Else
            m_strIssueID = "0"
        End If
        'Modified by SavitaS on 03 Sept 2006 for SP7 IssueID 6494
        If Not Request.QueryString("Fromwhere") Is Nothing Then
            m_strFromwhere = Request.QueryString("Fromwhere").ToString
        Else
            m_strFromwhere = Request.Form("txtFromwhere").ToString
        End If
        'End of Modified by SavitaS on 03 Sept 2006 for SP7 IssueID 6494
        'Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
        If Not Request.QueryString("FromReview") Is Nothing Then
            m_strFromReview = Request.QueryString("FromReview").ToString
            'Modified by MonikaI on 12th Oct 2006 IssueID : 6883
        ElseIf Not Request.Form("txtFromReview") Is Nothing Then
            'End by MonikaI
            m_strFromReview = Request.Form("txtFromReview").ToString
        End If
        'Added by SrikanthY on 21 Dec 2006
        If Trim(Request.QueryString("QueryToken") & "") <> "" Then
            m_PKQueryToken = Request.QueryString("QueryToken")
        End If

        If Trim(Request.QueryString("Queryid") & "") <> "" Then
            m_Queryid = Request.QueryString("Queryid")
        End If
        'End of Addition by SrikanthY
        'If Not Request.QueryString("FromReview") Is Nothing Then
        '    ' m_strFromReview = Request.QueryString("FromReview")
        '    If CType(Request.QueryString("FromReview"), String) = "1" Then
        '        m_strFromReview = "1"
        '    End If
        'Else
        '    m_strFromReview = "0"
        'End If
        'End of Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
        'If (m_Mode = "CopyIssue" Or m_Mode = "New") And m_strIssueID <> "0" Then
        '    m_strToken = CommonFunctions.Security.Token.GetToken(m_strIssueID.ToString + CType(Session("intUserID"), String) + "0" + "0")
        'End If

        Dim STRTOK As String = CommonFunctions.Security.Token.GetToken(CType(m_strIssueID, String) + CType(m_Queryid, String) + CType(Session("intUserID"), String) + "0" + "0")
        ''cOMMENTED AND ADDED BY NILESH G ON 28/1/2016 FOR URL ISSUE
        If ((m_strToken = "") And (m_strIssueID <> "0")) Or _
       ((m_strIssueID <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_strIssueID, String) + CType(Session("intUserID"), String) + "0" + "0", m_strToken) = False)) Then
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        'End of Added by SavitaS on 19 Sept 2006  for Security Issue 6197

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_DISCUSSION 'default mode

        'Code Added by PadmnabhA to display IssueID in Header
        If Request.QueryString("IssueID") <> "" Then
            m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
        End If
        'Addtion By PadmnabhA Ends
        ' Added by GaneshD on 08 Jun 2009 For Issue Base StatusFlow configuration
        If Request.QueryString("StatusFlow") <> "" Then
            m_StatusFlowCount = CType(Request.QueryString("StatusFlow"), Long)
        End If
        ' End of addition by GaneshD on 08 Jun 2009

        m_strAction = Request.QueryString("Action") + ""
        m_strUserName = Session("strUserName").ToString + ""

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueId 63 

        'Integrated By Amit J whizible SP 7.2 Issue ID 2596 
        'Commented By Amit J on 17th july For IVL Issue Id 2596
        'Purpose:To consider Project level Role Aceess depending on project selected in Support-->Project        Combo
        'Call CreateGlobalObject()
        'End of Integration

        'Integrated by MrugajaB on 28th June 2006 for Issue ID.4518
        'Commented and Modified by SavitaS on 24 May 2006 for IVL IssueID 1975 
        'Purpose : To consider ProjectID of the project selected in combo and not the Project opened.
        'm_strProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("intProjectID"), "0"), String)
        m_strProjectID = CType(CommonFunctions.General.CheckIsNothing(Session("IssueProject"), "0"), String)
        'End Modification by SavitaS for Sierra IssueID 1975
        'End Integration

        m_strSessionUserID = CType(Session("intUserID"), String)
        m_LoginType = CType(Session("LoginType"), String)
        ' m_strSessionPostID = CType(Session("intRoleID"), String)

        'Added by MrugajaB on 8th Aug 2006 for Whiziblesem SP7 Issue ID.4262
        'Purpose:To check value of 'Project level Issue SLA' field

        Dim drIssueProject As IDataReader
        Dim lngIssueProject As Long
        drIssueProject = CommonFunction.Data.GetDataReader("Exec usp_sel_tbl_IB_Issue " + CType(m_lngIssueID, String), MyBase.UseSQL)
        If drIssueProject.Read Then
            lngIssueProject = CType(CommonFunctions.Data.CheckIsDBNull(drIssueProject("ProjectID"), "0"), Long)
        End If
        ' Added by GaneshD on 17 Sep 2009 fro cleanup activity
        CommonFunction.Data.DisposeDataReader(drIssueProject)
        ' End of addtion by GaneshD

        If lngIssueProject > 0 Then
            'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
            'm_IsIssueSLAApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT IsIssueSLAApplicable FROM tbl_PM_Project WHERE ProjectID= " & lngIssueProject.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
            m_IsIssueSLAApplicable = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_Project_IsIssueSLAApplicable " & lngIssueProject.ToString, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), "False"), "False"), Boolean)
            'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        End If

        'End Addition

        'Added by SrikanthY on 26 Dec 2006 To Get projectid
        If m_strProjectID = "0" Then
            Dim drIssueDetails As IDataReader
            drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " & m_lngIssueID.ToString, MyBase.UseSQL)
            If drIssueDetails.Read Then
                m_strProjectID = CType(drIssueDetails("ProjectID"), String)
            End If
            CommonFunction.Data.DisposeDataReader(drIssueDetails)
        End If
        'End of Addition by SrikanthY
        'Added by SrikanthY on 22 Jan 2007 for getting Helpdesk page,sorting details
        If Not Session("ParentQuerySortBY") Is Nothing Then
            m_QuerySortBy = CType(Session("ParentQuerySortBY"), String)
        End If

        If Not Session("ParentQuerySortOrder") Is Nothing Then
            m_QuerySortOrder = CType(Session("ParentQuerySortOrder"), String)
        End If
        'end of addition by SrikanthY on 22 Jan 2007
        'Modified by Shraddham on 7th Aug 2006 for WhizibleSEM SP7 Issue ID.4262
        'Purpose : To Display Server Date And Time
        'Dim h As Integer
        'Dim m As Integer
        'Dim strHour As String
        'Dim strMinute As String

        'Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        'Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        'Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        'h = CType(Left(strGetServerTime1, 2), Integer)
        'm = CType(Right(strGetServerTime1, 2), Integer)

        'If h < 10 Then
        '    strHour = "0" + h.ToString
        'Else
        '    strHour = h.ToString

        'End If
        'If m < 10 Then
        '    strMinute = "0" + m.ToString
        'Else
        '    strMinute = m.ToString
        'End If

        'm_strStatusChangeDate = strGetServerDate1
        'm_strStatusChangeTime = strHour + ":" + strMinute
        ''end of modification shraddhaM
        ''End of Addition by PrajaktaR for Nucleus IssueID 18970

        If m_LoginType = "E" Then
            ' Get the role of the Employee in the current project.
            Dim drProject As IDataReader

            drProject = CommonFunction.Data.GetDataReader("Exec usp_Sel_EmployeeProjectRole " + m_strProjectID + ", " + m_strSessionUserID, MyBase.UseSQL)
            If drProject.Read Then
                m_strSessionPostID = CType(drProject("Role"), String)
            Else
                m_strSessionPostID = CType(Session("intPostID"), String)
            End If
            CommonFunction.Data.DisposeDataReader(drProject)
        Else
            m_strSessionPostID = CType(Session("intPostID"), String)

        End If
        ' End Modification By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueId 63 
        'Integrated By Amit J whizible SP 7.2 Issue ID 2596 
        'Added By AmitJ On 17th july For IVL  Issue Id 2596 
        'To consider Project level Role Aceess depending on project selected in Support-->Project Combo
        m_strRoleId = CType(m_strSessionPostID, Integer)
        Call CreateGlobalObject()
        'End of Addition By Amit J
        'End of Integration

        Select Case m_strMode
            Case CONST_DISCUSSION

                If m_strAction <> "" Then
                    'update the data
                    Call performDiscussionThreadAction(m_lngIssueID)
                End If

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('IB_DISCUSSION')")

                ' copy all the element to string array
                Dim arrstrMenu(arrMenu.Count - 1) As String
                Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                arrMenu.CopyTo(arrstrMenu)
                arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                arrMenu = Nothing
                arrMenuToolTip = Nothing
                arrClientSideFunctions = Nothing

                strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                'draw upper menu
                General.WriteHTML(strMenu)

                'initialize the resource file for Discussion page.
                MyBase.InitializeResources("AppResources.IB_Discussion", "AppResources")

                'Display the PageLegends 
                If General.CheckIsNothing(Session("LoginType"), "") = "C" Then
                    Dim strarrLegend() As String = {"Mandatory"}
                    Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                    General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)
                Else
                    Dim strarrLegend() As String = {MyBase.GetResourceString("LEGEND_SHOWTOCUSTOMER"), "Mandatory"}
                    Dim strarrLegendImage() As String = {"", "<img src='../../images/star.gif'>"}
                    General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)
                End If


                If Request.QueryString("IssueID") <> "" Then
                    m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
                End If

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_DISCUSS"), "Issue ID  : " + CType(m_lngIssueID, String))
                General.WriteHTML("<BR>")

                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_DISCUSS") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for discussion page
                Call plotScreenForDiscussion(m_lngIssueID)

        End Select
        'draw lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForDiscussion
    ' Parameters Passed		:	lngIssueID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page for discussion page.
    ' Description			:	This procedure will plot the screen to for discussion page with text area
    '                           for the comments. Here grid of previous comments with date and username is also
    '                           plotted.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 9 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForDiscussion(ByVal lngIssueID As Long)
        Dim strSQL As String
        Dim strDate As String
        Dim strComments As String
        Dim strCurrentHours As String
        Dim strCurrentTime As String

        'Added By PadmnabhA to check if the Show To Customer is checked for the Issue On 02-May-2005
        Dim objDR As IDataReader
        Dim strIssueShowStatus As Boolean
        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'strSQL = "SELECT ShowToCustomer FROM tbl_IB_Issue WHERE IssueID = " + CType(lngIssueID, String)
        strSQL = "usp_sel_tbl_IB_Issue_ShowToCustomer " + CType(lngIssueID, String)
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        objDR = Data.GetDataReader(strSQL, True)
        If objDR.Read Then
            If Not IsDBNull(objDR("ShowToCustomer")) Then
                strIssueShowStatus = CType(objDR("ShowToCustomer"), Boolean)
            End If
        End If

        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        CommonFunction.Data.DisposeDataReader(objDR)
        ' End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'End of Addition 

        'get the current date 
        strDate = CommonFunction.Dates.CGetDateTime(Date.Now) + ""
        If m_strAction = "" Then
            strComments = MyBase.GetFormValue("txtComments") + ""
        Else
            strComments = ""
        End If

        'plot the controls
        General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")

        'display user Name
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' width=30% >" + MyBase.GetResourceString("CAP_USER_NAME") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left'>" + m_strUserName.Trim + "</TD>")
        General.WriteHTML("</TR>")

        'display date
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right'>" + MyBase.GetResourceString("CAP_DATE") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left'>" + strDate.Trim + "</TD>")
        General.WriteHTML("</TR>")

        'display the textarea for comments
        General.WriteHTML("<TR class='clsTREven' >")
        'Commented And Added By Vaijat K ON 04/11/2015
        'General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_COMMENTS") + "&nbsp</TD>")
        General.WriteHTML("<TD align='right' valign='top' style='vertical-align:top !important' >" + MyBase.GetResourceString("CAP_COMMENTS") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left'>")
        'Modified By ShraddhaM on 28 July 2006
        'Modified By VidyaJ - 22nd Feb 2007 - Removed wrap=Soft property
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , , True, True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", , , , "frmDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("</TR>")

        'Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        'To show status combo 
        Dim objDRStatus As IDataReader

        'Added by MrugajaB for WhizibleSEM SP7
        Dim strSQLForRole As String
        Dim drTypeAccess As IDataReader
        Dim blnStatusAccessible As Boolean
        'End Addition

        m_strStatusSQL = "usp_Sel_tbl_IB_Issue " + m_lngIssueID.ToString
        objDRStatus = CommonFunction.Data.GetDataReader(m_strStatusSQL, MyBase.UseSQL)

        If objDRStatus.Read Then
            If CType(CommonFunctions.Data.CheckIsDBNull(objDRStatus("status"), ""), String) <> "" Then
                m_strCurrentStatus = CType(objDRStatus("Status"), String)
            Else
                m_strCurrentStatus = ""
            End If

            m_strCurrentType = CType(objDRStatus("Type"), String)
        End If

        CommonFunction.Data.DisposeDataReader(objDRStatus)

        m_strStatusSQL = "Exec usp_Sel_tbl_IB_Project_Type_Status_ProjectGroup " + m_strProjectID + ", '" + CommonFunction.General.BuildQueryString(m_strCurrentType.Trim) + "'" + ",Null,Null," + _
                                m_strSessionPostID + ",'" + CommonFunction.General.BuildQueryString(m_strCurrentStatus) + "'"

        General.WriteHTML("<TR class='clsTREven' >")
        If m_blnEditAccess = True Then
        
            'Added by MrugajaB for WhizibleSEM SP7
            strSQLForRole = "select dbo.udf_tbl_ib_typerolesecurity_Project_StatusAccess(" & m_strProjectID & "," & m_strSessionPostID & ",'" & CommonFunction.General.BuildQueryString(m_strCurrentType) & "','" & CommonFunction.General.BuildQueryString(m_strCurrentStatus) & "')" & vbCrLf

            blnStatusAccessible = CType(CommonFunctions.Data.GetDataScalar(strSQLForRole, MyBase.UseSQL), Boolean)
		'End Addition
			
            

            'blnRecordsExist = False
            General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("STATUS_CAPTION") + "&nbsp</TD>")
        Else
            General.WriteHTML("<TD align='right' valign='top' >" + "" + "&nbsp</TD>")
        End If
        General.WriteHTML("<TD align='left'>")
        'Added by GaneshD on 08 Jun 2009 For Issue Base StatusFlow configuration
        'Dim strOldStatus As String = CommonFunction.Data.CheckIsDBNull(drIssueDetails("Status"), "").ToString
        'm_strCurrentStatus
        ' Addition End by GaneshD
        'Modified By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
		'If the status is not accessible , then disable the combo box
        If m_blnEditAccess = True Then
            'Added By PradipK on 13 March 2006 for SLA Management 
			If (blnStatusAccessible = False) Then
                General.WriteHTML(HTMLControls.DrawComboBox("cboStatus", m_strStatusSQL, 200, m_strCurrentStatus.Trim, " Disabled onchange=Status_Onchange()", , True))
            Else
                General.WriteHTML(HTMLControls.DrawComboBox("cboStatus", m_strStatusSQL, 200, m_strCurrentStatus.Trim, "onchange=Status_Onchange()", , True))
                'Added By GaneshD on 08 Jun 2009 for Issue Base StatusFlow configuration
                Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType.Replace("'", "") + "'," + "2,'" + m_strCurrentStatus + "','" & m_strProjectID.ToString & "'", DisplayNone:=True)) '--, displaynone:=True
                Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType.Replace("'", "") + "'," + "1", DisplayNone:=True)) ', displaynone:=True
                'Addition end by GaneshD
 			End If

            'End Addition By PradipK on 13 March 2006 for SLA Management
        Else
            General.WriteHTML(HTMLControls.DrawComboBox("cboStatus", m_strStatusSQL, 200, m_strCurrentStatus.Trim, "onchange=Status_Onchange()", , True, , , , True))
            'Added By GaneshD on 08 Jun 2009 for Issue Base StatusFlow configuration
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType.Replace("'", "") + "'," + "2,'" + m_strCurrentStatus + "','" & m_strProjectID.ToString & "'", DisplayNone:=True)) '--, displaynone:=True
            Response.Write(CommonFunction.HTMLControls.DrawComboBox("CmbPrevStatus", "Exec usp_ValidateIssueStatus '" + m_strCurrentType.Replace("'", "") + "'," + "1", DisplayNone:=True)) ', displaynone:=True
            'Addition end by GaneshD
        End If

        ' OLdStatus 
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML(HTMLControls.DrawTextBox("txtStatusOld", "txtStatusOld", , , , m_strCurrentStatus.Trim, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True))
        ' Type 
        General.WriteHTML(HTMLControls.DrawTextBox("txtType", "txtType", , , , m_strCurrentType.Trim, returnHTML:=True, DisplayNone:=True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("</TR>")
        ' End Modification By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

        'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
        'Code Added By PradipK on 24 Feb 2006
        'Purpose : To add Status Change Date & Time.
        'SrikanthY on 17 Jan 2007 Modified below code For Issue 9532
        Dim dtRepDate As DateTime
        Dim Hour, Miniute As String

        m_strStatusSQL = "usp_Sel_tbl_IB_Issue " + m_lngIssueID.ToString
        objDRStatus = CommonFunction.Data.GetDataReader(m_strStatusSQL, MyBase.UseSQL)

        If objDRStatus.Read Then
            ''Dim strOldStatusChangeDate As String = CommonFunction.Data.CheckIsDBNull(CommonFunction.Dates.GetDate(CType(drIssueDetails("StatusChangeDate"), Date)), "").ToString
            If CType(CommonFunctions.Data.CheckIsDBNull(objDRStatus("StatusChangeDate"), ""), String) <> "" Then
                m_strStatusChangeDate = CommonFunction.Data.CheckIsDBNull(CommonFunction.Dates.GetDate(CType(objDRStatus("StatusChangeDate"), Date)), "").ToString
            End If
            If CType(CommonFunctions.Data.CheckIsDBNull(objDRStatus("StatusChangeTime"), ""), String) <> "" Then
                m_strStatusChangeTime = CType(objDRStatus("StatusChangeTime"), String)
            End If
            If CType(CommonFunctions.Data.CheckIsDBNull(objDRStatus("ReportedDate"), ""), String) <> "" Then
                m_strReportedDate = CommonFunction.Data.CheckIsDBNull(CommonFunction.Dates.GetDate(CType(objDRStatus("ReportedDate"), Date)), "").ToString
                dtRepDate = CType(objDRStatus("ReportedDate"), Date)
            End If
            If CType(CommonFunctions.Data.CheckIsDBNull(objDRStatus("ReportedTime"), ""), String) <> "" Then
                m_strReportedTime = CType(objDRStatus("ReportedTime"), String)
            Else
                Hour = CType(dtRepDate.Hour, String)
                Miniute = CType(dtRepDate.Minute, String)
                If Hour.Length = 1 Then Hour = "0" + Hour
                If Miniute.Length = 1 Then Miniute = "0" + Miniute
                m_strReportedTime = Hour & ":" & Miniute
            End If

            If CType(CommonFunctions.Data.CheckIsDBNull(objDRStatus("status"), ""), String) <> "" Then
                m_strOldStatusIssue = CType(objDRStatus("status"), String)
            End If

        End If
        'End of modification by SrikanthY on 17 Jan 2007
        ' Added by GaneshD on 17 Sep 2009 - For cleanup activity
        CommonFunction.Data.DisposeDataReader(objDRStatus)
        ' End of addition by Ganeshd

        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtOldStatus", "txtOldStatus", , , , m_strOldStatusIssue, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Plot Status Date & Control For Issue
        ' Response.Write(CommonFunction.HTMLControls.DrawTextBox("OldStatusChangeDate", "OldStatusChangeDate", , , , m_strStatusChangeDate, IsHidden:=True, returnHTML:=True))
        Response.Write(CommonFunction.HTMLControls.DrawDateControl("OldStatusChangeDate", "OldStatusChangeDate", , , m_strStatusChangeDate, DisplayNone:=True))
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("OldStatusChangeTime", "OldStatusChangeTime", , , , m_strStatusChangeTime, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'Plot Reported Date & Control For Issue
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("ReportedDate", "ReportedDate", , , , m_strReportedDate, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("ReportedTime", "ReportedTime", , , , m_strReportedTime, IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'Added by SavitaS on 20 Sept 2006
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_strToken, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtFromReview", "txtFromReview", , , , m_strFromReview, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("txtFromwhere", "txtFromwhere", , , , m_strFromwhere, , , , , , , , , , , , True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'End of Added by SavitaS on 04 Oct 2006 for SP7 IssueID 6640 and 6509
        'End Addition by SavitaS
        'Plot Current Date & Time.
        'shraddha

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'Dim strSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strSQL1 As String = "usp_sel_GetDate"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        Dim strDate1 As String = CommonFunction.Data.GetDataScalar(strSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Dim strHour As String
        Dim strMinute As String

        Dim h As Integer
        Dim m As Integer
        h = Now().Hour
        m = Now().Minute
        'integrated by harshada d 
        'Modified By AmitJ For PSPL IssueId = 22880
        'h = Now().Hour
        'm = Now().Minute

        h = CType(Left(strDate1, 2), Integer)
        m = CType(Right(strDate1, 2), Integer)
        'End of Modification 
        'end of integration by harshada d 
        If h < 10 Then
            strHour = "0" + h.ToString
        Else
            strHour = h.ToString

        End If
        If m < 10 Then
            strMinute = "0" + m.ToString
        Else
            strMinute = m.ToString
        End If
        'End Of addition by PrashantD
        'CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , CommonFunction.Dates.GetDate(Now()), , "frmDiscussion", , , , , , , , False, , , True)

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'Dim strGetServerTimeSQL1 As String = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        Dim strGetServerTimeSQL1 As String = "usp_sel_GetDate"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        Dim strGetServerTime1 As String = CommonFunction.Data.GetDataScalar(strGetServerTimeSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'Dim strGetServerDateSQL1 As String = "select REPLACE((convert(varchar(50),cast(GETDATE() AS SMALLDATETIME ),106)) ,' ','-')"
        Dim strGetServerDateSQL1 As String = "usp_sel_SMALLDATETIME"
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

        Dim strGetServerDate1 As String = CommonFunction.Data.GetDataScalar(strGetServerDateSQL1, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString

        Response.Write(CommonFunction.HTMLControls.DrawDateControl("CurrentDate", "CurrentDate", , , strGetServerDate1, DisplayNone:=True))

        'strCurrentHours = Now.Hour.ToString
        'If CType(Now.Hour.ToString, Integer) < 10 Then
        '    strCurrentHours = "0" + Now.Hour.ToString
        'End If
        'strCurrentTime = Now.Minute.ToString
        'If CType(Now.Minute.ToString, Integer) < 10 Then
        '    strCurrentTime = "0" + Now.Minute.ToString
        'End If
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strHour + ":" + strMinute, IsHidden:=True, EnableHTMLEncode:=True))
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'strSQL = "SELECT CONVERT(VARCHAR(5),GetDate(),8)"
        'strDate = CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)).ToString
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentDate", "CurrentDate", , , , CType(CommonFunction.Dates.GetDate(Date.Now), String), IsHidden:=True, returnHTML:=True))
        'Response.Write(CommonFunction.HTMLControls.DrawTextBox("CurrentTime", "CurrentTime", , , , strDate, IsHidden:=True, returnHTML:=True))

        'usp_Sel_tbl_IB_IssueEntry_Layout_Details null,65, NULL, 'StatusChangeDate'

        Dim drLayout As IDataReader
        Dim intLayoutID As Integer
        Dim CurrentType As String = ""

        'Commneted by SrikanthY To Get Projectid in the ealrier steps
        'If lngIssueID <> 0 Then
        '    Dim drIssueDetails As IDataReader
        '    drIssueDetails = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_Issue " & m_lngIssueID.ToString, MyBase.UseSQL)
        '    If drIssueDetails.Read Then
        '        m_strProjectID = CType(drIssueDetails("ProjectID"), String)
        '    End If
        '    CommonFunction.Data.DisposeDataReader(drIssueDetails)
        'End If
        ' End of comments by SriaknthY

        '' SnehalV 5-Oct
        '' CurrentType = CType(CommonFunctions.Data.GetDataScalar("select IsNull(Type,'')  from tbl_ib_Issue where IssueId='" + lngIssueID.ToString + "'", True), String)

        'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        'CurrentType = CommonFunction.General.BuildQueryString(CType(CommonFunctions.Data.GetDataScalar("select IsNull(Type,'')  from tbl_ib_Issue where IssueId='" + lngIssueID.ToString + "'", True), String))
        CurrentType = CommonFunction.General.BuildQueryString(CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_ib_Issue_IssueId_Type '" + lngIssueID.ToString + "'", True), String))
        'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
        '' END SnehalV 5-Oct

        ' Get the layout ID to be applied. since we want the Layout for the Type which is in the combobox selected.
        drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_GetIssueLayoutToBeApplied " + m_strProjectID.ToString + ", " + m_strSessionPostID.ToString + ", '" + CurrentType + "'", MyBase.UseSQL)
        If drLayout.Read Then
            ' Get the layout ID.
            intLayoutID = CType(drLayout("LayoutID"), Integer)
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)
        drLayout = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_IB_IssueEntry_Layout_Details NULL, " + intLayoutID.ToString + ", NULL, 'StatusChangeDate'", MyBase.UseSQL)
        'Modified by MrugajaB for WhizibleSEM SP7
        'Puprpose:Status combo will be displayed only if it is present in issue layout for logged in user
        If drLayout.Read And blnStatusAccessible Then
            'End Modification
            General.WriteHTML("<TR class='clsTREven' >")
            'Modified by MrugajaB on 24th July 2006 for WhizibleSEM SP7 Issue ID.4262
            'Purpose:When logintype is customer or project level issue SLA is not applicable then do not display status change fields
            If (m_LoginType = "C") Or (m_IsIssueSLAApplicable = False) Then

                General.WriteHTML("<TD align='right' style='display:none'> Status Change Date &nbsp</TD>")
                General.WriteHTML("<TD align='left' style='display:none'>" + HTMLControls.DrawDateControl("dtStatusChangeDate", "dtStatusChangeDate", , , m_strStatusChangeDate, , "frmDiscussion", , , , , , "", True, True, , ) + " </TD>")
                'General.WriteHTML(HTMLControls.DrawTextBox("txtStatusChangeTime", "txtStatusChangeTime", , , , m_strStatusChangeTime, , ) + "</TD>")
                General.WriteHTML("</TR>")
                General.WriteHTML("<TR class='clsTREven' >")
                General.WriteHTML("<TD align='right' style='display:none'> Status Change Time &nbsp</TD>")
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML("<TD align='left' style='display:none'>" + CommonFunction.HTMLControls.DrawTextBox("txtStatusChangeTime", "txtStatusChangeTime", , 50, , m_strStatusChangeTime, , , , , , , , True, True, EnableHTMLEncode:=True) + " </TD>")
                'ended by Yogesh J for HTML encoding Date:06/10/15
            Else
                General.WriteHTML("<TD align='right'> Status Change Date &nbsp</TD>")
                General.WriteHTML("<TD align='left'>" + HTMLControls.DrawDateControl("dtStatusChangeDate", "dtStatusChangeDate", , , m_strStatusChangeDate, , "frmDiscussion", , , , , , "", True, True, , ) + " </TD>")
                'General.WriteHTML(HTMLControls.DrawTextBox("txtStatusChangeTime", "txtStatusChangeTime", , , , m_strStatusChangeTime, , ) + "</TD>")
                General.WriteHTML("</TR>")
                General.WriteHTML("<TR class='clsTREven' >")
                General.WriteHTML("<TD align='right'> Status Change Time &nbsp</TD>")
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                General.WriteHTML("<TD align='left'>" + CommonFunction.HTMLControls.DrawTextBox("txtStatusChangeTime", "txtStatusChangeTime", , 50, , m_strStatusChangeTime, , , , , , , , True, True, EnableHTMLEncode:=True) + " </TD>")
                'ended by Yogesh J for HTML encoding Date:06/10/15

            End If
            'End Modification by MrugajaB
            General.WriteHTML("</TR>")
            'End Addition By PradipK on 24 Feb 2006
        End If
        CommonFunction.Data.DisposeDataReader(drLayout)
        'Added by PadmnabhA   on 02 May 2005
        'Implement the ShowToCustomer functionality.display checkbox if user is not customer
        If strIssueShowStatus = True Then
            'Integrated by MrugajaB for Whiziblesem SP7 Issue ID.4518 on 29th June 2006

            'Integrated by SavitaS on 25 May 2006 for FourSoft IssueID 2002
            'Added by ShubhadaL on 23 Feb 2006 for FourSoft - 927
            ' ShowToCustomer Checkbox goes blank when parent gets refreshed from DiscussionThread_Save click
            m_Customer = 1
            'End of addition by ShubhadaL on 23 Feb 2006 for FourSoft - 927
            'End Integration by SavitaS
            'End Integration
            If General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
                General.WriteHTML("<TR class='clsTREven' >")
                General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_SHOWTOCUSTOMER") + "&nbsp</TD>")
                General.WriteHTML("<TD align='left'>")
                General.WriteHTML(HTMLControls.DrawCheckBox("chkShowToCustomer", "chkShowToCustomer", , , "1", , , True) + "</TD>")
                General.WriteHTML("</TR>")
            End If
        End If
        'addition end

        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot the grid for previous comments
        Dim arrColHeader() As String = {MyBase.GetResourceString("CAP_USER_NAME"), MyBase.GetResourceString("CAP_DATE"), MyBase.GetResourceString("COL_COMMENTS")}
        Dim arrAN() As String = {"UserName", "DiscussionDate", "Comments"}
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        Dim arrIgnoreHTMLEncode() As String = {"0"}
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'create the SP for grid data without sorting 
        strSQL = "Exec Usp_Sel_IB_tbl_IB_Discussion " + lngIssueID.ToString

        'added by SachinR   on 09 Jul 2004
        'Implement the ShowToCustomer functionality.check checkbox status if user is not customer
        strSQL += ",'" + General.CheckIsNothing(Session("LoginType"), "E") + "'"
        'addition end

        'create Grid object and set the properties
        'm_objGrid = New WebPage.Templates.GenericGrid
        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 200
            .DIVStyle = "overflow:auto; width:100% "
            .NoOfDataColumns = 3
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            'plot the grid 
            .DrawGrid()
        End With
        m_objGrid = Nothing

        'close the body Div
        General.WriteHTML("</Div>")
        ' Modified By NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
        'objDR.Close()
        'objDR.Dispose()
        'objDR = Nothing
        'End Modification By NitinVS on  5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForDiscussion
    ' Parameters Passed		:	lngIssueID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To update the database by inserting new record of discussion for the give issueID.
    ' Description			:	This procedure will update the database by inserting new record of discussion for the 
    '                           given IssueId and will send E-mail to the user and display message based on the settings
    '                           in the database.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 9 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub performDiscussionThreadAction(ByVal lngIssueID As Long)
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strDate As String
        Dim strComments As String
        Dim blnSendEMail As Boolean
        Dim blnDisplayMsg As Boolean
        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strSubject As String
        Dim strEmailMsg As String
        Dim strCCToEmailId As String

        'get values from the page cotrols
        strComments = MyBase.GetFormValue("txtComments", False) + ""

        'Added By Bharat T on 1st-Dec-2015
        If strComments = "" Then
            strComments = Request.Form("txtComments") + ""
        End If
        'End of Added By Bharat T on 1st-Dec-2015

        Select Case m_strAction
            Case CONST_ACTION_SAVE

                'insert new record for discussion comments
                strSQL = "Usp_Ins_tbl_IB_Discussion " + lngIssueID.ToString + ",'" + General.BuildQueryString(m_strUserName.Trim) + "','" + General.BuildQueryString(strComments.Trim) + "'"

                'added by SachinR   on 09 Jul 2004
                'Implement the ShowToCustomer functionality.check checkbox status if user is not customer
                If General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
                    If MyBase.GetFormValue("chkShowToCustomer") = "1" Then
                        strSQL += ",1"
                    Else
                        strSQL += ",0"
                    End If
                End If
                'addition end

                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)

                'get the settings for sending email
                strSQL = "usp_Sel_tbl_PM_EmailMessages 33"
                objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
                If objDR.Read Then

                    If Not IsDBNull(objDR("SendMail")) Then
                        blnSendEMail = CType(objDR("SendMail"), Boolean)
                    Else
                        blnSendEMail = False
                    End If
                    If Not IsDBNull(objDR("ShowPopup")) Then
                        blnDisplayMsg = CType(objDR("ShowPopup"), Boolean)
                    Else
                        blnDisplayMsg = False
                    End If
                End If
                objDR.Close()
                objDR.Dispose()
                objDR = Nothing

                'check the settings and send email
                If blnSendEMail = True Then
                    If blnDisplayMsg = True Then
                        'write client side script to display the message window
                        'General.WriteHTML("<Script language=javascript>")
                        'General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=33&IssueID=" + lngIssueID.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                        'General.WriteHTML("window.close();")
                        'General.WriteHTML("</Script>")
                        Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_33(strFromEmailID, strToEmailID, strCCToEmailId, strSubject, strEmailMsg, lngIssueID)
                    Else
                        'send email silently
                        Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_33(strFromEmailID, strToEmailID, strCCToEmailId, strSubject, strEmailMsg, lngIssueID)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
                    End If
                End If

                ' Modified BY NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 
                ' To save Status if changed

                m_strCurrentStatus = MyBase.GetFormValue("cboStatus")
                m_strCurrentType = MyBase.GetFormValue("txtType")

                'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                m_strStatusChangeDate = MyBase.GetFormValue("dtStatusChangeDate")
                m_strStatusChangeTime = MyBase.GetFormValue("txtStatusChangeTime")

                'Added by MrugajaB for WhizibleSEM SP7
                m_strOldStatus = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtStatusOld"), "")
                If m_strCurrentStatus = "" Or m_strCurrentStatus Is Nothing Then
                    m_strCurrentStatus = m_strOldStatus
                End If
                'End Addition

                ' Get Corporate Status 
                m_strStatusSQL = "Exec usp_Sel_IB_GetCorporateValue 'Status' , '" + CommonFunction.General.BuildQueryString(m_strCurrentStatus) + "' , " + m_strProjectID + " , '" + CommonFunction.General.BuildQueryString(m_strCurrentType) + "' "

                objDR = CommonFunction.Data.GetDataReader(m_strStatusSQL, MyBase.UseSQL)

                If objDR.Read Then
                    m_strCorporateStatus = CommonFunction.Data.CheckIsDBNull(objDR("CorporateValue"), "").ToString
                End If

                CommonFunction.Data.DisposeDataReader(objDR)

                m_strOldStatus = CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("txtStatusOld"), "")

                'if old status is not equal to current staus update the status and send mail for Staus change 
                If m_strOldStatus <> m_strCurrentStatus Then

                    m_strStatusSQL = " UPDATE TBL_IB_ISSUE  "
                    m_strStatusSQL += " SET Status = '" + m_strCurrentStatus + "' , "
                    m_strStatusSQL += " CorporateStatus = '" + m_strCurrentStatus + "' , "
                    m_strStatusSQL += " CreatorOrModifier = '" & CommonFunction.General.BuildQueryString(m_strUserName) & "' , "
                    m_strStatusSQL += " LoginType = '" & CommonFunction.General.BuildQueryString(m_LoginType) & "'  , "
                    'Added By VidyaJ - For IssueID - 3394 - Whiz6.0 - IssueBase SLA 
                    'Code Added By PradipK on 27 Feb 2006
                    m_strStatusSQL += " StatusChangeDate = '" & CommonFunction.General.BuildQueryString(m_strStatusChangeDate) & "' , "
                    m_strStatusSQL += " StatusChangeTime = '" & CommonFunction.General.BuildQueryString(m_strStatusChangeTime) & "'  "
                    'End Addition By PradipK on 27 Feb 2006
                    m_strStatusSQL += " Where IssueID = " + m_lngIssueID.ToString

                    CommonFunction.Data.InsertOrUpdateData(m_strStatusSQL, MyBase.UseSQL)

                    'Commented and added by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query
                    'm_strStatusSQL = "SELECT * FROM tbl_IB_Project_Type_Status WHERE ProjectID = " + m_strProjectID.ToString + " AND Type = '" + m_strCurrentType + "' "
                    m_strStatusSQL = "usp_sel_tbl_IB_Project_Type_Status_Type " + m_strProjectID.ToString + ",'" + m_strCurrentType + "', '" + m_strCurrentStatus + "'"
                    'End of addition by Sanyogeeta Raorane on 05-Aug-2016 To Remove Inline Query

                    'm_strStatusSQL = m_strStatusSQL + "AND Status = '" + m_strCurrentStatus + "'"

                    objDR = CommonFunction.Data.GetDataReader(m_strStatusSQL, MyBase.UseSQL)

                    If objDR.Read Then
                        'Send mail if mail has to be changed and status has been changed
                        If CType(objDR("SendMail"), Boolean) = True Then

                            Dim drEmailMessage As IDataReader

                            ' Retrieve the details of the message to be sent to the Resource.
                            drEmailMessage = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 34", MyBase.UseSQL)
                            If drEmailMessage.Read Then
                                blnSendEMail = CType(drEmailMessage("SendMail"), Boolean)
                                blnDisplayMsg = CType(drEmailMessage("ShowPopup"), Boolean)
                            End If
                            CommonFunction.Data.DisposeDataReader(drEmailMessage)

                            ' Check if the mail has to be sent (exit if not to send)
                            If blnSendEMail = True Then

                                ' Check if a popup message has to be shown.
                                If blnDisplayMsg = True Then
                                    'write client side script to display the message window
                                    General.WriteHTML("<Script language=javascript>")
                                    'Added by MrugajaB for WhizibleSEM SP7
                                    'Code commented & Added By PradipK on 8-June-2006
                                    'Purpose:To Check ShowToCustomer condition from Discussion Thread(DT) table if Mail is from DT.
                                    ' General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=34&IssueID=" + lngIssueID.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                                    General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=34&From=DT&IssueID=" + lngIssueID.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                                    'End Addition
                                    General.WriteHTML("</Script>")

                                    ' Else, if the mail has to be sent silently, then...
                                Else
                                    'Added by MrugajaB for WhizibleSEM SP7
                                    'Code commented & Added By PradipK on 8-June-2006
                                    'Purpose:To Check ShowToCustomer condition from Discussion Thread(DT) table if Mail is from DT.
                                    'Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(strFromEmailID, strToEmailID, strCCToEmailId, strSubject, strEmailMsg, lngIssueID)
                                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(strFromEmailID, strToEmailID, strCCToEmailId, strSubject, strEmailMsg, lngIssueID, "DT") 'ie Mail fires from DT
                                    'End Addition By PradipK on 8-June-2006
                                    'End Addition
                                    Call CommonFunction.Emails.SendEmailWithCC(strToEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
                                End If

                            End If
                        End If
                    End If
                    CommonFunction.Data.DisposeDataReader(objDR)

                End If
                ' End Modification BY NitinVS on 5 Aug 2005 for WhizibleSEM SP4 IssueID 63 

            Case Else
        End Select

    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "COMMENTS" Then
            'Args.StringToBeInserted = "<TD><PRE>" & Args.DataReader("COMMENTS").ToString & "</PRE></TD>"
            'Cancel = True
            'Code added by SiddharthS on 24 Mar 2005 for Issue Id 15475
            Dim strComments As String
            strComments = Args.DataReader("Comments").ToString
            strComments = HtmlEncode(strComments)
            Args.StringToBeInserted = "<TD><PRE>" & strComments & "</PRE></TD>"
            Cancel = True
            'end addition.
        End If
        If Args.DataField.Trim.ToUpper = "DISCUSSIONDATE" Then
            Args.ShowTimeWithDate = True
        End If
    End Sub

    Private Sub m_objGrid_DataRowTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTR) Handles m_objGrid.DataRowTR_BeforePrint
        Dim ShowToCustFlag As Boolean
        Dim strTR As String
        Dim strComments As String
        ShowToCustFlag = CType(Args.DataReader.Item("ShowToCustomer"), Boolean)

        If m_strRowCount = True Then
            m_strRowCount = False
        Else
            m_strRowCount = True
        End If
        If General.CheckIsNothing(Session("LoginType"), "") <> "C" Then
            If ShowToCustFlag = True Then
                If m_strRowCount = False Then
                    strTR = "<TR class='clsTREven'> "
                Else
                    strTR = "<TR class='clsTROdd'> "
                End If
                strTR += "<TD vAlign=top title='User Name'><font color='BLUE'> " & CType(Args.DataReader.Item("UserName"), String) & " </font></td>"
                strTR += "<TD vAlign=top title='Date'><font color='BLUE'> " & CType(Args.DataReader.Item("DiscussionDate"), Date) & " </font></td>"
                strComments = Args.DataReader("Comments").ToString
                strComments = HtmlEncode(strComments)
                strTR += "<TD><font color='BLUE'><PRE>" & strComments & "</PRE></font></TD> </TR>"

                Args.StringToBeInserted = strTR
                m_blnIsRecordInGrid = True
                Cancel = True
            End If
        End If
    End Sub

    Private Sub m_objGrid_NoDataCommentTR_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_NoDataCommentTR) Handles m_objGrid.NoDataCommentTR_BeforePrint
        If m_blnIsRecordInGrid = True Then
            Cancel = True
        End If
    End Sub
End Class
