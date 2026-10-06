Imports CommonFunctions

Public Class SendEmail
    Inherits WebPages.Template.WhizTemplate
    Protected CONST_MAIL As String = "EMAIL"
    Protected CONST_MODE_ERROR As String = "ERROR"
    Protected CONST_MODE_SUCCESS As String = "SUCCESS"
    Protected CONST_ACTION_SEND As String = "SEND"

    Protected m_strMode As String
    Private m_strAction As String
    Protected m_lngMessageID As Long
    Protected m_lngIssueID As Long
    Protected m_lngReviewID As String = "'"
    ' Added By Rajanikant
    Protected m_lngQueryID As Long = 0
    ' end addition
    ' Added By Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011   1003  
    Protected m_strIsShowToCustomer As String = ""
    ' end Added By Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011   1003  
    Protected m_strWindowTitle As String
    Private m_strToEmailID As String = ""
    Private m_strCCEmailID As String = ""
    Private m_strSubject As String = ""
    Private m_strMessage As String = ""
    Private m_strFromEmailID As String = ""
    Private m_strSendMailTo As String = ""
    Private m_arrTemp() As String
    Private m_strOldReviewDate As Date


    'Added by DipaliS 20 Oct 2004
    Private m_strOldReviewStartDate As Date
    Private m_strOldReviewEndDate As Date
    'End addition by DipaliS 20 Oct 2004
    ' For PM Messages
    Private m_strTaskIDList As String = ""
    Private m_strProjectEmployeeRoleId As String = ""
    Private m_lngEmployeeID As Long = 0
    Private m_lngRoleID As Long = 0
    ' For FA Messages
    Private m_lngTimesheetNo As Long = 0
    Private m_lngInvoiceId As Long = 0
    'For Leave Related Messages
    Private m_lngLeaveId As Long = 0
    'Resource Allocation Related Messages
    Private m_lngRequestID As Long = 0
    Private m_strEmployeeIDList As String = ""
    'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
    'Added by SavitaS on 25 Nov 2005 
    Protected m_lngDeptID As Long
    Protected m_lngNewDeptID As Long
    Protected m_lngDeptName As String
    Protected m_lngNewDeptName As String
    Protected m_Subject As String
    'Protected m_strRequestType As String
    'Protected m_strSubRequestType As String
    'End Addition by SavitaS
    'End Integration by SavitaS 
    ''Integrated by manishK On 4th Jan 06
    ''Added by ShubhadaL for SP4 Integration
    '''Added By NageshM
    Protected m_strLoginName As String = ""
    Protected m_StrPassword As String = ""
    '' End of addition by NageshM
    ''End of addition by ShubhadaL for SP4 Integration
    ''End of Integrated by manishK On 4th Jan 06

    'Added By VidyaJ - IssueID - 672 	
    'Added By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1
    Protected m_strMsgID As String
    Private m_strInstanceID, m_strProcessID, m_strNextStageID, m_strCurrentStageID, m_strPrimaryKeyValue As String
    'End of Addition By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1

    'Added by MrugajaB for WhizibleSEM SP7
    'Code Added By PradipK on 8-June-2006
    'Purpose:To Check ShowToCustomer condition from Discussion Thread(DT) table if Mail is from DT.
    Private strFrom As String = ""
    'End Addtion By PradipK on 8-June-2006
    'End Addition
    'Added By MahendraV On 6:49 PM 5/21/2007 for IDs of ModuleID,SubProjectID and MilestoneId
    ' Start_MV_5/21/2007
    Private m_UniqueID As String = ""
    Private m_strUserComments As String = ""

    ' End_MV_5/21/2007
    'Added by ShraddhaM on 11,Jul 2008
    'Purpose : To integrate Risk Registration from Whizible 2007 
    Protected intOldCostOpportunity As String
    Protected intOldSizeOppurtunity As String
    Protected OldOppurtunityStatus As String
    Protected OldAssignedTo As String
    Protected strOldStartDate As String
    Protected strOldEnddate As String
    Protected intOldDuration As String
    Protected strOldFrequency As String
    Protected strOldResponsiblePerson As String
    'End of addition by ShraddhaM

    'Added by DarshanK on 30 Jul 2008
    Private FromWhere As String = ""
    Dim arrMsg2() As String
    'End of addition by DarshanK

    'Addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
    'Purpose:To display comments in Approval/Rejection mail
    Private m_strcomments As String
    'End of addition by SuchitraP on 16-dec-2008

    'added by Aniruddha for jump to record from email functionality
    Protected PKValue As Integer
    Protected EntityID As Integer
    'end addtion by Anirudha
    'Added by AmitM on 08 April 2011 for WhizibleSEM 10.0
    Private m_strExceptionMessage As String
    'End of Added by AmitM on 08 April 2011 for WhizibleSEM 10.0
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
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_EMAIL")

    End Sub
    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'initialize the resource file for send Email page.
        MyBase.InitializeResources("AppResources.SendEmail", "AppResources")
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
    ' Created				:	Feb 12 2004
    ' Revisions				:	
    '=====================================================================
    Public Sub PageInit()
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter

        'added by Aniruddha for jump to record from email functionality
        If Not Request("PKValue") Is Nothing Then
            If Request("PKValue") <> "" Then
                PKValue = Request("PKValue")
            End If
        End If
        If Not Request("EntityID") Is Nothing Then
            If Request("EntityID") <> "" Then
                EntityID = Request("EntityID")
            End If
        End If

        CommonFunction.HTMLControls.DrawTextBox("txtPKValue", "txtPKValue", , , , convert.ToString(PKValue), , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("txtEntityID", "txtEntityID", , , , convert.ToString(EntityID), , , , , , True)
        'end addtion by Anirudha

        'Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 
        General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
        General.WriteHTML("<TR class='clsTRSectionHeader'>")
        General.WriteHTML("<TD align='center'>")
        'General.WriteHTML("<IMG Border=0 style='display:none'  SRC='../../Images/TemporaryImages/ajax-loader.gif' title='Loading.....' onclick='' ID='imgLoader' name='imgLoader'>")
        General.WriteHTML("<IMG Border=0 style='display:none'  SRC='../../Images/TemporaryImages/2.gif' title='Loading.....' onclick='' ID='imgLoader' name='imgLoader'>")
        General.WriteHTML("</TD></TR>")
        General.WriteHTML("</Table>")
        'End of Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_MAIL
        'Modified By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1
        If Request.QueryString("Workflow") <> "" Then
            If Request.QueryString("MessageID") <> "" Then
                m_strMsgID = Request.QueryString("MessageID")
            End If
            If Request.QueryString("InstanceID") <> "" Then
                m_strInstanceID = Request.QueryString("InstanceID")
            End If
            If Request.QueryString("ProcessID") <> "" Then
                m_strProcessID = Request.QueryString("ProcessID")
            End If
            If Request.QueryString("NextStageID") <> "" Then
                m_strNextStageID = Request.QueryString("NextStageID")
            End If
            If Request.QueryString("CurrentStageID") <> "" Then
                m_strCurrentStageID = Request.QueryString("CurrentStageID")
            End If
            If Request.QueryString("PrimaryKeyValue") <> "" Then
                m_strPrimaryKeyValue = Request.QueryString("PrimaryKeyValue")
            End If
        Else
            If Request.QueryString("MessageID") <> "" Then
                m_lngMessageID = CType(Request.QueryString("MessageID"), Long)
            End If
            'Additon done by DarshanK on 30-Jul-2008
            If Request.QueryString("FromWorkFlow") <> "" Then
                FromWhere = "W"
            End If
            'End of Addition done by DarshanK
        End If
        'End of Addition By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1
        If Request.QueryString("IssueID") <> "" Then
            m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
        End If
        'Integrated by SavitaS on 22 Dec 2005 for IssueID 1936
        'Added by SavitaS on 25 Nov 2005 
        If Request.QueryString("Department") <> "" Then
            m_lngDeptID = CType(Request.QueryString("Department"), Long)
        End If

        If Request.QueryString("NewDepartment") <> "" Then
            m_lngNewDeptID = CType(Request.QueryString("NewDepartment"), Long)
        End If

        If Request.QueryString("DeptName") <> "" Then
            m_lngDeptName = CType(Request.QueryString("DeptName"), String)
        End If

        If Request.QueryString("NewDeptName") <> "" Then
            m_lngNewDeptName = CType(Request.QueryString("NewDeptName"), String)
        End If
        'End Addition by SavitaS
        'End Integration by SavitaS
        'Integrated by MrugajaB on 1st Aug,2005 for WhizibleSEM sp4 Issue ID.97
        ' Modified By NitinVS on 26 July 2005 for PSPL , 

        ' if Mulitple Request are assigned then dont store the m_lngQueryID 

        If Trim(Request("MultipleRequests") & "") <> "1" Then

            ' Added By Rajanikant
            If Request.QueryString("QueryID") <> "" Then
                m_lngQueryID = CType(Request.QueryString("QueryID"), Long)
            End If
        End If
        ' End Addition
        ' End Modification By NitinVS on 26 July 2005 if Mulitple Request are assigned then dont store the m_lngQueryID 
        If Request.QueryString("OldReviewDate") <> "" Then
            m_strOldReviewDate = CType(Request.QueryString("OldReviewDate"), Date)
        End If
        'Code Added by DipaliS 20 Oct 2004
        If Request.QueryString("OldReviewStartDate") <> "" Then
            m_strOldReviewStartDate = CType(Request.QueryString("OldReviewStartDate"), Date)
        End If
        If Request.QueryString("OldReviewEndDate") <> "" Then
            m_strOldReviewEndDate = CType(Request.QueryString("OldReviewEndDate"), Date)
        End If

        'End Addition
        If Request.QueryString("TaskID") <> "" Then
            m_strTaskIDList = Request.QueryString("TaskID")
        End If
        If Request.QueryString("ProjectEmployeeRoleId") <> "" Then
            m_strProjectEmployeeRoleId = Request.QueryString("ProjectEmployeeRoleId")
        End If
        If Request.QueryString("ReviewStatisticsID") <> "" Then
            m_lngReviewID = Request.QueryString("ReviewStatisticsID")
        End If
        m_strAction = Request.QueryString("Action") + ""
        m_strSendMailTo = Request.QueryString("EmployeeIDList") + ""
        m_strFromEmailID = Request.QueryString("FromEmailID") + ""

        'Addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
        'Purpose:To display comments in Approval/Rejection mail
        If Request.QueryString("Comments") <> "" Then
            m_strcomments = Server.UrlDecode(Request.QueryString("Comments"))
        End If
        'End of Addition by SuchitraP on 16-Dec-2008

        If Request.QueryString("EmployeeID") <> "" Then
            m_lngEmployeeID = CType(Request.QueryString("EmployeeID"), Long)
        End If

        If Request.QueryString("RoleID") <> "" Then
            m_lngRoleID = CType(Request.QueryString("RoleID"), Long)
        End If

        If Request.QueryString("TimeSheetID") <> "" Then
            m_lngTimesheetNo = CType(Request.QueryString("TimeSheetID"), Long)
        End If

        If Request.QueryString("InvoiceID") <> "" Then
            m_lngInvoiceId = CType(Request.QueryString("InvoiceID"), Long)
        End If

        If Request.QueryString("LeaveID") <> "" Then
            m_lngLeaveId = CType(Request.QueryString("LeaveID"), Long)
        End If

        If Request.QueryString("RequestID") <> "" Then
            m_lngRequestID = CType(Request.QueryString("RequestID"), Long)
        End If
        If Request.QueryString("EmployeeIDS") <> "" Then
            m_strEmployeeIDList = Request.QueryString("EmployeeIDS").ToString()
        End If

        If m_strAction <> "" Then
            'send the mail based on the message id
            Call performSendMailAction(m_lngMessageID)
        End If
        'Added By Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011     
        If Request.QueryString("IsShowToCustomer") <> "" Then
            m_strIsShowToCustomer = CType(Request.QueryString("IsShowToCustomer"), String)
        End If
        ''END Added By Amit Mahadik Whiziblesem 10.0 Issue ID:50821 ,01 August 2011     

        ''Added By Vaijat K ON 14/07/2017 For generating token
        If (m_lngMessageID = 1003) Then
            Dim strToken As String = CommonFunctions.Security.Token.GetToken(m_lngMessageID & m_lngQueryID & m_strIsShowToCustomer & HttpContext.Current.Session("intUserid") & 0)
            If (strToken <> Request.QueryString("PkToken")) Then
                System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        ''End Added By Vaijat K ON 14/07/2017 For generating token

        Select Case m_strMode.ToUpper
            Case CONST_MAIL, CONST_MODE_ERROR

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

                arrMenu = New System.Collections.ArrayList
                arrMenuToolTip = New System.Collections.ArrayList
                arrClientSideFunctions = New System.Collections.ArrayList

                'if error occured then dont show send menu
                If m_strMode.ToUpper <> CONST_MODE_ERROR Then
                    arrMenu.Add(MyBase.GetResourceString("MENU_SEND")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SEND_TOOLTIP")) : arrClientSideFunctions.Add("Send_OnClick()")
                End If
                arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SEND_MAIL')")

                'copy all the element to string array
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

                'Display the (* Mandatory) PageLegends 
                Dim strarrLegend() As String = {"Mandatory"}
                Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

                'initialize the resource file for Discussion page.
                MyBase.InitializeResources("AppResources.SendEmail", "AppResources")

                'draw page caption 
                WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_EMAIL"))
                General.WriteHTML("<BR>")

                'Modified by SachinR on 5 Mar 2004
                ''draw page description
                'objHeader = New WebPage.Templates.HeaderFooter
                'objHeader.HeaderFooter = MyBase.GetResourceString("PAGE_DESC_EMAIL") + ""
                'General.WriteHTML(objHeader.DrawHeaderFooter(, True))
                'General.WriteHTML("<BR>")
                'objHeader = Nothing

                'plot the screen for email screen
                General.WriteHTML("<Div id='DivBody' width=100% height=90% style='Overflow: auto;'>")

                If m_strMode.ToUpper = CONST_MODE_ERROR Then
                    'Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 
                    General.WriteHTML("<script language=""javascript"">")
                    General.WriteHTML("var objImgLoader = GetObjectReference('frmSendEmail','imgLoader');")
                    General.WriteHTML("objImgLoader.style.display = ""none"";")
                    General.WriteHTML("</script>")
                    'End of Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 

                    'if error in seding the mail then show error msg.
                    General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
                    General.WriteHTML("<TR class='clsTRSectionHeader'>")
                    General.WriteHTML("<TD align='center'>")
                    General.WriteHTML(MyBase.GetResourceString("MSG_ERROR_EMAIL"))
                    General.WriteHTML("</TD></TR>")
                    General.WriteHTML("<TR class='clsTRSectionHeader' >")
                    General.WriteHTML("<TD align='center'>")
                    General.WriteHTML(MyBase.GetResourceString("MSG_ERROR_EMAIL2"))
                    General.WriteHTML("</TD></TR>")
                    'Added by AmitM for WhizibleSEM 10.0
                    General.WriteHTML("<TR class='clsTRSectionHeader' >")
                    General.WriteHTML("<TD align='center'><B>")
                    General.WriteHTML("<a href='javascript:ShowDescription_onClick()'><IMG Border=0  SRC='../../Images/plus.gif' Collapse='N' title='Description' onclick='' ID='imgSummaryShowHide' name='imgSummaryShowHide'>&nbsp;Error Details </a>")
                    General.WriteHTML("</B></TD></TR>")
                    General.WriteHTML("<TR class='clsTRSectionHeader' style='display:none' id='Description' name='Description'>")
                    General.WriteHTML("<TD align='center'><B>")
                    General.WriteHTML(m_strExceptionMessage)
                    General.WriteHTML("</B></TD></TR>")
                    'End of Added by AmitM for WhizibleSEM 10.0
                    General.WriteHTML("</Table>")
                    General.WriteHTML("<BR>")

                    'get previous values form the controls
                    m_strFromEmailID = MyBase.GetFormValue("txtFromEmailID") + ""
                    m_strToEmailID = MyBase.GetFormValue("txtToEmailID") + ""
                    m_strCCEmailID = MyBase.GetFormValue("txtCCToEmailID") + ""
                    m_strSubject = MyBase.GetFormValue("txtSubject") + ""
                    m_strMessage = MyBase.GetFormValue("txtMessage") + ""
                Else

                    'get the email details from the database else take it from the session
                    If Request.QueryString("Workflow") <> "" Then
                        Call getEmailDetails(m_strMsgID)
                    Else
                        Call getEmailDetails(m_lngMessageID)
                    End If
                End If
                'modification end

                Call plotScreenForEmail()
                General.WriteHTML("</Div>")

            Case CONST_MODE_SUCCESS
                'display the success message and the email IDs

                'initialize the resource file for Discussion page.
                MyBase.InitializeResources("AppResources.SendEmail", "AppResources")

                'display success message here 
                General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;'>")
                General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
                General.WriteHTML("<TR class='clsTRSectionHeader'>")
                General.WriteHTML("<TD align='center'>")
                General.WriteHTML(MyBase.GetResourceString("MSG_SUCCESS_EMAIL"))
                General.WriteHTML("</TD></TR>")
                General.WriteHTML("</Table>")

                'display email IDs
                m_strToEmailID = MyBase.GetFormValue("txtToEmailID") + ""
                m_strCCEmailID = MyBase.GetFormValue("txtCCToEmailID") + ""

                Dim i As Integer
                General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")

                'display to emil IDs
                If m_strToEmailID <> "" And m_strToEmailID <> "," Then
                    m_arrTemp = Split(m_strToEmailID, ";")
                    For i = 0 To m_arrTemp.Length - 1
                        If m_arrTemp(i) <> "" Then
                            General.WriteHTML("<TR class='clsTRSectionHeader'><TD align='center'>" + m_arrTemp(i).Trim + "</TD></TR>")
                        End If
                    Next
                    m_arrTemp = Nothing
                End If

                'display CC email IDs
                If m_strCCEmailID <> "" And m_strCCEmailID <> "," Then
                    General.WriteHTML("<TR class='clsTRSectionHeader'><TD align='center'></TD></TR>")
                    m_arrTemp = Split(m_strCCEmailID, ";")
                    For i = 0 To m_arrTemp.Length - 1
                        If m_arrTemp(i) <> "" Then
                            General.WriteHTML("<TR class='clsTRSectionHeader'><TD align='center'>" + m_arrTemp(i).Trim + "</TD></TR>")
                        End If
                    Next
                    m_arrTemp = Nothing
                End If

                General.WriteHTML("</Table>")
                General.WriteHTML("</Div>")

            Case Else
        End Select

        'draw lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)

    End Sub

    '=====================================================================
    ' Procedure Name		:	plotScreenForEmail
    ' Parameters Passed		:	None
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To draw all controls on the page for SendEmail page.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 12 2004
    ' Revisions				:	
    '=====================================================================
    Private Sub plotScreenForEmail()
        Dim strSQL As String
        Dim blnShowFrom As Boolean

        'plot the controls
        General.WriteHTML("<Table width=99.9% class='clsTable' cellspacing=0 cellpadding=0 >")

        'display CC mail id textbox
        blnShowFrom = True
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_FROM") + "&nbsp;</TD>")
        'Integrated by Manishk on 4th Jan 06 
        'Modified by ShubhadaL for SP4 Integration on 28 Oct 2005
        'Commented By NageshM On Date 29th Jul 2005
        'General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtFromEmailID", "txtFromEmailID", , 450, , m_strFromEmailID + "".Trim, , , , Not blnShowFrom, , , , True, True) + "</TD>")
        ' End of Commenting By NageshM
        'Modified by PrajaktaR for TAVANT 
        'End of Integrated by Manishk on 4th Jan 06 

        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtFromEmailID", "txtFromEmailID", , 450, , m_strFromEmailID + "".Trim, , , True, Not blnShowFrom, , , True, True) + "</TD>")
        'End Of Modification by PrajaktaR for TAVANT 
        'End of modification by ShubhadaL for SP4 Integration on 28 Oct 2005
        General.WriteHTML("</TR>")

        'display the TO mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_TO") + "&nbsp;</TD>")

        'Added by DarshanK on 28-Jul-2008
        'Dim strSQLL As String = "SELECT EmailApproval FROM tbl_PM_EmailMessages WHERE Msgid=" & m_lngMessageID.ToString
        'Dim blnValue As Boolean = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQLL, CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")

        If m_lngMessageID <> 23 Then
            'General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , , , , , True, True) + "</TD>")
            'If Not blnValue Then
            '    General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , , , , , True, True) + "</TD>")
            'Else
            '--- Commented by PUrvaj on 15 Dec 2008 for Whiziblesem 8.0
            '--- readonly for 1,68, 440 Ids removed.
            'If m_lngMessageID = 1 Or m_lngMessageID = 68 Or m_lngMessageID = 440 Or m_strMsgID = 1 Then
            '    General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , True, , , , True, True) + "</TD>")
            'Else
            '--- End Commented by purvaj
            General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , , , , , True, True) + "</TD>")
            'End If

            'End If
            'End of Addition done by Darshank
        Else
            General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , True, , , , True, True) + "</TD>")
        End If

        General.WriteHTML("</TR>")

        'display CC mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_CC") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtCCToEmailID", "txtCCToEmailID", , 450, , m_strCCEmailID + "".Trim, , , , , , , , True) + "</TD>")
        General.WriteHTML("</TR>")

        'display the subject
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_SUBJECT") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 450, , m_strSubject + "".Trim, , , , , , , , True, True) + "</TD>")
        General.WriteHTML("</TR>")

        'display the note
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("NOTE") + " :</TD>")
        General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("EMAIL_NOTE") + "</TD>")
        General.WriteHTML("</TR>")

        'display the message
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_MESSAGE") + "&nbsp;</TD>")

        '---------------------------------------------------------------------------------------------------------------
        'Code Added by MonikaI. On 1st Aug 2006. For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To display the Site address in the text message of SendEmail page.
        Dim strMsg As String = ""
        Dim strMobileURL As String = ""
        Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")
        ' Modified By MahendraV On 11:33 AM 10/1/2007 For WhizibleSEM 7.1 Customization
        ' Purpose : To set footer link for 'Send for Approval' mail for Leave,IR,Expense,Project,ProjectTimesheet,ResourceTimeSheet
        ' 68 - Leave -----,3, 51, 55, 434, , 460
        ' 440 - Project
        ' 434 - Resource TimeSheet
        ' Start_MV_10/1/2007
        ' strMsg = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1) + "/Default.aspx"
        ' Commented and open default link for all mail event by MahendraV On 25-Feb-2008
        'Start_MV_25-Feb-2008
        'Select Case m_lngMessageID
        '    Case 68, 440, 434
        '        strMsg = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1) + "/Approvals.aspx"
        '    Case Else
        '        strMsg = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1) + "/Default.aspx"
        'End Select

        ''Commented And Added By Vaijat K ON 23/10/2015
        '' strMsg = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1) + "/Default.aspx"
        ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ''Dim ActionType As String = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select S.ActionType From tbl_PM_CompanyInformation C Left Join tbl_CNF_SiteDetailsActionMaster S ON C.ActionType=S.ID WHERE C.CompanyInfoID=1", True), "")
        Dim ActionType As String = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_ActionType", True), "")
        ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        If ActionType = "Default" Then
            strMsg = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1) + "/Default.aspx"
        ElseIf ActionType = "Dynamic" Then
            ''Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
            ''strMsg = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("Select SiteEmailID From tbl_PM_CompanyInformation WHERE CompanyInfoID=1", True), "")
            strMsg = CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_CompanyInformation_SiteEmailID", True), "")
            ''end of Commented and added By Nilesh g on 4/8/2016 Purpose : Remove Inline Query
        ElseIf ActionType = "None" Then
            strMsg = ""
        End If
        ''End Added By Vaijat K ON 23/10/2015
        'End_MV_25-Feb-2008
        ' End_MV_10/1/2007


        'Addition done by DarshanK on 13 Aug 2008
        Dim strTempMessage As String = m_strMessage

        ' ----############## Commented By purvaj on 15 Dec 2008
        'If m_lngMessageID = 1 Or m_lngMessageID = 68 Or m_lngMessageID = 440 Then
        '    Dim arrMsg() As String
        '    arrMsg = Split(strTempMessage, "Site Details - ")
        '    If arrMsg.Length > 1 Then
        '        strTempMessage = arrMsg(0)
        '    End If
        'End If


        'arrMsg2 = Split(strTempMessage, " GUIDList -")
        'If arrMsg2.Length > 1 Then
        '    strTempMessage = strTempMessage.Remove(strTempMessage.IndexOf(" GUIDList -"))
        '    General.WriteHTML(HTMLControls.DrawTextBox("txtGUID", "txtGUID", , 450, , arrMsg2(1), , , , , , True, , True))
        'End If
        'End of addition done by DarshanK on 13 Aug 2008
        ' ----############## End comment Purvaj

        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim, , , , , , , , True, True) + "</TD>")
        'Modified and Comment By VarunA on 6-June-2007 For Whizible Regression Project Issue-13396
        'Purpose : To change the caption of message box
        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , , True, True) + "</TD>")


        'Changes done by DarshanK on 13 Aug 2008
        'If m_lngMessageID = 1 Or m_lngMessageID = 68 Or m_lngMessageID = 440 Then
        '    General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , strTempMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10), , , , , , , , True, True) + "</TD>")
        'Else
        '    General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , strTempMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , , True, True) + "</TD>")
        'End If


        ' ----############## Commented By purvaj on 15 Dec 2008
        'If m_lngMessageID = 1 Or m_lngMessageID = 68 Or m_lngMessageID = 440 Then
        'strTempMessage += "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10)
        'Else

        ' ----############## End Commented By purvaj on 15 Dec 2008
        ''Commented And Added By Vaijat K On 23/10/2015
        ''strTempMessage += "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg
        If strMsg <> "" Then
            strTempMessage += "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg
        Else
            strTempMessage += "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10)
        End If
        ''End Added By Vaijat K ON 23/10/2015
        'End If

        'Commented By NitinVS MobileSiteURL is not used as not in use 

        'Added By Amol Changle On: 10 Dec 2008
        'purpose: To show link of Mobile Approval site
        'Dim drCompanyInfo As IDataReader
        'drCompanyInfo = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_CompanyInformation", True)
        'If drCompanyInfo.Read() Then
        '    strMobileURL = CommonFunctions.Data.CheckIsDBNull(drCompanyInfo("MobileSiteURL"))
        'End If
        'Commonfunction.data.DisposeDataReader (drCompanyInfo ) 

        'End Commented By NitinVS MobileSiteURL is not used as not in use 

        ' ----############## Commented By purvaj on 15 Dec 2008
        ' If strMobileURL <> "" And (m_lngMessageID = 1 Or m_lngMessageID = 68 Or m_lngMessageID = 434 Or m_lngMessageID = 440) Then
        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , strTempMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details for Mobile Users  - " + strMobileURL, , , , , , , , True, True) + "</TD>")
        'Else


        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , strTempMessage, , , , , , , , True, True) + "</TD>")
        ' ----############## END Commented By purvaj on 15 Dec 2008
        'End If
        'End Addition

        'End of Changes done by DarshanK on 13 Aug 2008

        'Original One is below:
        ''Commented And Added By Vaijat K ON 23/10/2015
        ''General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , , True, True) + "</TD>")
        If strMsg <> "" Then
            'Commented And Edited by KIRAN K K for IssueId:2426 on 30-11-15
            ' General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , , True, True) + "</TD>")
            General.WriteHTML("<TD align='left' style='vertical-align: top; ' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , , True, True) + "</TD>")
            'Commented And Edited by KIRAN K K for IssueId: on 30-11-15
        Else
            'Commented And Edited by KIRAN K K for IssueId:2426 on 30-11-15
            'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10), , , , , , , , True, True) + "</TD>")
            General.WriteHTML("<TD align='left' style='vertical-align: top; ' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10), , , , , , , , True, True) + "</TD>")
        End If
        'End of Changes done by DarshanK on 13 Aug 2008

        'End By VarunA on 6-June-2007
        General.WriteHTML("</TR>")
        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------

        General.WriteHTML("</Table>")



        'Commented by NitinVS on 3 Aug 2007 for WhizibleSEM 7
        ' Whizible Email functionality is to be removed for preformance problem
        ''Code added by MrugajaB on 12th Dec 2005
        ''Purpose: Implementation of communication feature
        'm_strToEmailID = CommonFunctions.General.BuildQueryString(m_strToEmailID)
        'm_strCCEmailID = CommonFunctions.General.BuildQueryString(m_strCCEmailID)
        'm_strFromEmailID = CommonFunctions.General.BuildQueryString(m_strFromEmailID)
        'm_strSubject = CommonFunctions.General.BuildQueryString(m_strSubject)
        'm_strMessage = CommonFunctions.General.BuildQueryString(m_strMessage)
        'CommonFunction.Data.InsertOrUpdateData("Exec usp_Ins_tbl_CDB_Communication '" & m_strToEmailID & "','" & m_strCCEmailID & "','" & m_strFromEmailID & "','" & m_strSubject & "','" & m_strMessage & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        ''End Addition
        'End Commenting by NitinVS on 3 Aug 2007 for WhizibleSEM 7

    End Sub

    '=====================================================================
    ' Procedure Name		:	performSendMailAction
    ' Parameters Passed		:	lngMessageID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To send the mail to the given To and CC email id list and display the status.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 12 2004
    ' Revisions				:	
    '=====================================================================
    'Private Sub performSendMailAction(ByVal lngMessageID As Long)
    '    Dim strTOEmailID As String
    '    Dim strCCEmailID As String
    '    Dim strSubject As String
    '    Dim strMessage As String
    '    Dim lngUserID As Long
    '    Dim strFromEmailID As String
    '    Dim strSQL As String
    '    Dim objDR As IDataReader
    '    Dim strLoginType As String

    '    'Added by DarshanK on 30-Jul-2008
    '    Dim strTempMessage As String = ""
    '    'End of addition done by DarshanK

    '    'Added by MonikaI on 7th Sep 2006 For WhizibleSEM SP7
    '    'Issue ID: 5342
    '    'Purpose : To display the Site address in the text message of SendEmail page.
    '    Dim objDRCompany As IDataReader
    '    Dim strSQLCompany As String
    '    Dim arrMsg() As String

    '    strSQLCompany = "SELECT EmailFormat FROM tbl_PM_CompanyInformation"
    '    objDRCompany = Data.GetDataReader(strSQLCompany, MyBase.UseSQL)
    '    If objDRCompany.Read Then
    '        If objDRCompany("EmailFormat").ToString = "TEXT" Then
    '            strMessage = MyBase.GetFormValue("txtMessage", False) + ""
    '            'Added by DarshanK on 20 Jul 2008
    '            strTempMessage = strMessage
    '            'End of addition
    '        Else
    '            strMessage = MyBase.GetFormValue("txtMessage", False) + ""
    '            'Added by DarshanK on 1-Aug-2008
    '            strMessage = strMessage.Replace("vbcrlf;", "<br>")
    '            'End of addition by DarshanK
    '            arrMsg = Split(strMessage, "Site Details - ")
    '            If arrMsg.Length > 1 Then
    '                strMessage = arrMsg(0) + "Site Details - <a href = '" + arrMsg(1) + "'>" + arrMsg(1) + "</a>"
    '            End If
    '            'Added by DarshanK on 20 Jul 2008
    '            strTempMessage = strMessage
    '            'End of addition
    '        End If
    '    End If
    '    Data.DisposeDataReader(objDRCompany)
    '    'End of addition by MonikaI

    '    'get the values from the page controls
    '    strTOEmailID = GetFormatedEmailIDList(MyBase.GetFormValue("txtToEmailID", False) + "")
    '    strCCEmailID = GetFormatedEmailIDList(MyBase.GetFormValue("txtCCToEmailID", False) + "")
    '    strSubject = MyBase.GetFormValue("txtSubject", False) + ""
    '    strFromEmailID = MyBase.GetFormValue("txtFromEmailID") + ""

    '    If strFromEmailID = "" Then
    '        'get the email id of the current user to use it as From email id
    '        'if user is customer then get details from the cutomer  detail table else
    '        'get the details from employeeInfo table
    '        lngUserID = CType(Session("intUserID"), Long)
    '        strLoginType = CommonFunction.General.CheckIsNothing(Session("LoginType")).ToString + ""
    '        If strLoginType.ToUpper.Trim = "C" Then
    '            strSQL = "usp_Sel_tbl_PM_Customer " + lngUserID.ToString
    '        Else
    '            strSQL = "usp_tbl_Sel_EmployeeInfo " + lngUserID.ToString
    '        End If
    '        objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
    '        If objDR.Read Then
    '            If Not IsDBNull(objDR("EmailID")) Then
    '                strFromEmailID = objDR("EmailID").ToString
    '            End If
    '        End If
    '        Data.DisposeDataReader(objDR)

    '        'if user dont have email ID the take company's emailID
    '        If strFromEmailID = "" Then
    '            strFromEmailID = CommonFunction.EmailMessages.funcGetCompanyMailID()
    '        End If
    '    End If

    '    ' Try
    '    'Added by DarshanK on 24-Jul-2008


    '    Dim arrToIDs() As String

    '    If strTOEmailID.Contains(",") Then
    '        arrToIDs = strTOEmailID.Split(",")
    '    ElseIf strTOEmailID.Contains(";") Then
    '        arrToIDs = strTOEmailID.Split(";")
    '    End If

    '    If Not arrToIDs Is Nothing Then
    '        Dim intCount As Integer = 0
    '        Dim EmailFormat As String = ""
    '        For intCount = 0 To arrToIDs.Length - 1
    '            If arrToIDs(intCount) <> "" Then
    '                strMessage = strTempMessage
    '                'send the mail
    '                If lngMessageID = 1 Or lngMessageID = 68 Then
    '                    If arrToIDs(intCount).Contains(";") Then
    '                        Dim arrTOIDsplitted() As String = arrToIDs(intCount).Split(";")

    '                        For j As Integer = 0 To arrTOIDsplitted.Length
    '                            CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, arrTOIDsplitted(j), strMessage, FromWhere)
    '                            Try
    '                                Dim arrMsg1() As String
    '                                arrMsg1 = Split(strMessage, "For Rejection, Click on the below link:")
    '                                If arrMsg1.Length > 1 Then
    '                                    strMessage = arrMsg1(0) + "For Rejection, Click on the below link: <a href = 'window.open(" + arrMsg(1) + ",,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='(window.screen.width - 600)/2 ',top='(window.screen.height - 500)/2 ',width=600,height=500')'>" + arrMsg(1) + "</a>"
    '                                End If
    '                                arrMsg1 = Nothing

    '                                arrMsg1 = Split(strMessage, "For Approval, Click on the below link:")
    '                                If arrMsg1.Length > 1 Then
    '                                    strMessage = arrMsg1(0) + "For Approval, Click on the below link: <a href = 'window.open(" + arrMsg(1) + ",,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='(window.screen.width - 600)/2 ',top='(window.screen.height - 500)/2 ',width=600,height=500')'>" + arrMsg(1) + "</a>"
    '                                End If

    '                                CommonFunction.Emails.SendEmailWithCC(arrTOIDsplitted(j), strCCEmailID, strFromEmailID, strSubject, strMessage)
    '                                m_strMode = CONST_MODE_SUCCESS
    '                            Catch ex As Exception
    '                                'if error occured during mail sent
    '                                m_strMode = CONST_MODE_ERROR
    '                            End Try
    '                        Next
    '                    Else
    '                        CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, arrToIDs(intCount), strMessage, FromWhere)
    '                        Try
    '                            Dim arrMsg1() As String
    '                            arrMsg1 = Split(strMessage, "For Rejection, Click on the below link:")
    '                            If arrMsg1.Length > 1 Then
    '                                strMessage = arrMsg1(0) + "For Rejection, Click on the below link: <a href = 'window.open(" + arrMsg1(1) + ",,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='(window.screen.width - 600)/2 ',top='(window.screen.height - 500)/2 ',width=600,height=500')'>" + arrMsg1(1) + "</a>"
    '                            End If
    '                            arrMsg1 = Nothing

    '                            arrMsg1 = Split(strMessage, "For Approval, Click on the below link:")
    '                            If arrMsg1.Length > 1 Then
    '                                strMessage = arrMsg1(0) + "For Approval, Click on the below link: <a href = 'window.open(" + arrMsg1(1) + ",,'','resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left='(window.screen.width - 600)/2 ',top='(window.screen.height - 500)/2 ',width=600,height=500')'>" + arrMsg1(1) + "</a>"
    '                            End If

    '                            CommonFunction.Emails.SendEmailWithCC(arrToIDs(intCount), strCCEmailID, strFromEmailID, strSubject, strMessage)
    '                            m_strMode = CONST_MODE_SUCCESS
    '                        Catch ex As Exception
    '                            'if error occured during mail sent
    '                            m_strMode = CONST_MODE_ERROR
    '                        End Try
    '                    End If
    '                Else
    '                    Try
    '                        CommonFunction.Emails.SendEmailWithCC(arrToIDs(intCount), strCCEmailID, strFromEmailID, strSubject, strMessage)
    '                        m_strMode = CONST_MODE_SUCCESS
    '                    Catch ex As Exception
    '                        'if error occured during mail sent
    '                        m_strMode = CONST_MODE_ERROR
    '                    End Try
    '                End If
    '            End If
    '            strMessage = ""
    '        Next
    '    Else
    '        CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, strTOEmailID, strMessage)
    '        Try
    '            CommonFunction.Emails.SendEmailWithCC(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)
    '            m_strMode = CONST_MODE_SUCCESS
    '        Catch ex As Exception
    '            'if error occured during mail sent
    '            m_strMode = CONST_MODE_ERROR
    '        End Try
    '    End If

    '    'Try
    '    '    'send the mail
    '    '    CommonFunction.Emails.SendEmailWithCC(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)

    '    '    'mail has beed sent successfully
    '    '    m_strMode = CONST_MODE_SUCCESS

    '    'Catch ex As Exception

    '    '    'if error occured during mail sent
    '    '    m_strMode = CONST_MODE_ERROR

    '    'End Try

    'End Sub

    '=====================================================================
    ' Procedure Name		:	performSendMailAction
    ' Parameters Passed		:	lngMessageID - Long
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To send the mail to the given To and CC email id list and display the status.
    ' Description			:	same as above
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 12 2004
    ' Revisions				:	
    '=====================================================================

    Private Sub performSendMailAction(ByVal lngMessageID As Long)
        Dim strTOEmailID As String
        Dim strCCEmailID As String
        Dim strSubject As String
        Dim strMessage As String
        Dim lngUserID As Long
        Dim strFromEmailID As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strLoginType As String
        'Added by NitinC on 08 April 2011
        Dim successMessage As String
        'End of Added by NitinC on 08 April 2011

        'Added by MonikaI on 7th Sep 2006 For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To display the Site address in the text message of SendEmail page.
        Dim objDRCompany As IDataReader
        Dim strSQLCompany As String
        Dim arrMsg() As String
        'Dim arrMsg2() As String
        'Added by DarshanK on 30-Jul-2008
        Dim strTempMessage As String = ""
        Dim arrGUID() As String
        'End of addition done by DarshanK

        strSQLCompany = "SELECT EmailFormat FROM tbl_PM_CompanyInformation"
        objDRCompany = Data.GetDataReader(strSQLCompany, MyBase.UseSQL)
        If objDRCompany.Read Then
            If objDRCompany("EmailFormat").ToString = "TEXT" Then
                strMessage = MyBase.GetFormValue("txtMessage", False) + ""

                'Added by DarshanK on 20 Jul 2008
                strTempMessage = strMessage
                'End of addition
            Else
                strMessage = MyBase.GetFormValue("txtMessage", False) + ""
                arrMsg = Split(strMessage, "Site Details - ")
                If arrMsg.Length > 1 Then
                    strMessage = arrMsg(0) + "Site Details - <a href = '" + arrMsg(1) + "'>" + arrMsg(1) + "</a>"
                End If
                'Added by DarshanK on 20 Jul 2008
                strTempMessage = strMessage
                'End of addition
            End If
        End If
        Data.DisposeDataReader(objDRCompany)
        'End of addition by MonikaI

        'get the values from the page controls
        strTOEmailID = GetFormatedEmailIDList(MyBase.GetFormValue("txtToEmailID", False) + "")
        strCCEmailID = GetFormatedEmailIDList(MyBase.GetFormValue("txtCCToEmailID", False) + "")
        strSubject = MyBase.GetFormValue("txtSubject", False) + ""
        strFromEmailID = MyBase.GetFormValue("txtFromEmailID") + ""

        If strFromEmailID = "" Then
            'get the email id of the current user to use it as From email id
            'if user is customer then get details from the cutomer  detail table else
            'get the details from employeeInfo table
            lngUserID = CType(Session("intUserID"), Long)
            strLoginType = CommonFunction.General.CheckIsNothing(Session("LoginType")).ToString + ""
            If strLoginType.ToUpper.Trim = "C" Then
                strSQL = "usp_Sel_tbl_PM_Customer " + lngUserID.ToString
            Else
                strSQL = "usp_tbl_Sel_EmployeeInfo " + lngUserID.ToString
            End If
            objDR = Data.GetDataReader(strSQL, MyBase.UseSQL)
            If objDR.Read Then
                If Not IsDBNull(objDR("EmailID")) Then
                    strFromEmailID = objDR("EmailID").ToString
                End If
            End If
            Data.DisposeDataReader(objDR)

            'if user dont have email ID the take company's emailID
            If strFromEmailID = "" Then
                strFromEmailID = CommonFunction.EmailMessages.funcGetCompanyMailID()
            End If
        End If

        ' Try
        'Added by DarshanK on 24-Jul-2008


        Dim arrToIDs() As String

        If strTOEmailID.Contains(",") Then
            arrToIDs = strTOEmailID.Split(",")
        ElseIf strTOEmailID.Contains(";") Then
            arrToIDs = strTOEmailID.Split(";")
        End If

        '-- added By purvaj on 2 Dec 2008 whiziblesem 8.0 
        If strCCEmailID Is Nothing Then
            strCCEmailID = ""
        End If
        '-- End addition purvaj

        ' ----############## Commented By purvaj on 15 Dec 2008
        'If lngMessageID = 1 Or lngMessageID = 68 Or lngMessageID = 440 Then
        '    arrMsg = Split(strTempMessage, "Site Details - ")
        '    If arrMsg.Length > 1 Then
        '        strTempMessage = arrMsg(0)
        '    End If

        '    '   strTempMessage = strTempMessage.Remove(strTempMessage.IndexOf(" GUIDList -"))
        '    If Not Request.Form("txtGUID") Is Nothing Then
        '        arrGUID = Split(Request.Form("txtGUID"), ",")
        '    End If
        'Else

        ' ----############## END Commented By purvaj on 15 Dec 2008

        strTempMessage = strTempMessage
        'End If


        ' ----############## Commented By purvaj on 15 Dec 2008

        'If lngMessageID = 1 Or lngMessageID = 68 Or lngMessageID = 440 Then
        '    If Not arrToIDs Is Nothing Then
        '        Dim intCount As Integer = 0
        '        For intCount = 0 To arrToIDs.Length - 1
        '            If arrToIDs(intCount) <> "" Then
        '                'send the mail
        '                strMessage = strTempMessage
        '                If arrToIDs(intCount).Contains(";") Then
        '                    Dim arrTOIDsplitted() As String = arrToIDs(intCount).Split(";")

        '                    For j As Integer = 0 To arrTOIDsplitted.Length
        '                        CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, arrTOIDsplitted(j), arrGUID(intCount), strMessage, FromWhere)
        '                        Try
        '                            If strCCEmailID Is Nothing Then
        '                                CommonFunction.Emails.SendEmail(arrToIDs(intCount), strFromEmailID, strSubject, strMessage)
        '                            Else
        '                                CommonFunction.Emails.SendEmailWithCC(arrToIDs(intCount), strCCEmailID.Replace(";", ","), strFromEmailID, strSubject, strMessage)
        '                            End If
        '                            m_strMode = CONST_MODE_SUCCESS
        '                        Catch ex As Exception
        '                            'if error occured during mail sent
        '                            m_strMode = CONST_MODE_ERROR
        '                        End Try
        '                    Next
        '                Else
        '                    '-- Added By purvaj on 3 Dec 2008 for Whiziblesem 8.0 
        '                    '-- arrGUID(intCount) Is Nothing , send mail was not working on the resources management page.
        '                    If Not arrGUID Is Nothing Then
        '                        '--- End addition purvaj
        '                        CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, arrToIDs(intCount), arrGUID(intCount), strMessage, FromWhere)
        '                    End If
        '                    Try
        '                        If strCCEmailID Is Nothing Then
        '                            CommonFunction.Emails.SendEmail(arrToIDs(intCount), strFromEmailID, strSubject, strMessage)
        '                        Else
        '                            CommonFunction.Emails.SendEmailWithCC(arrToIDs(intCount), strCCEmailID.Replace(";", ","), strFromEmailID, strSubject, strMessage)
        '                        End If
        '                        m_strMode = CONST_MODE_SUCCESS
        '                    Catch ex As Exception
        '                        'if error occured during mail sent
        '                        m_strMode = CONST_MODE_ERROR
        '                    End Try

        '                End If
        '                '    Try
        '                '        If strCCEmailID Is Nothing Then
        '                '            CommonFunction.Emails.SendEmail(arrToIDs(intCount), strFromEmailID, strSubject, strMessage)
        '                '        Else
        '                '            CommonFunction.Emails.SendEmailWithCC(arrToIDs(intCount), strCCEmailID.Replace(";", ","), strFromEmailID, strSubject, strMessage)
        '                '        End If
        '                '        m_strMode = CONST_MODE_SUCCESS
        '                '    Catch ex As Exception
        '                '        'if error occured during mail sent
        '                '        m_strMode = CONST_MODE_ERROR
        '                '    End Try
        '            End If

        '        Next
        '    Else
        '        CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, strTOEmailID, arrMsg2(1), strMessage)
        '    End If
        'Else
        'CommonFunction.EmailMessages.EmailApprover.funGetEmailApprovalStatus(lngMessageID, strTOEmailID, arrMsg2(1), strMessage)

        ' ----############## END Commented By purvaj on 15 Dec 2008


        'added by AniruddhaD on 17 jul 2009 for jump to record from email
        strMessage += vbNewLine
        strMessage += vbNewLine

        Dim intPKValue As Integer
        Dim intEntityID As Integer

        If Not Request("txtPKValue") Is Nothing Then
            If Request("txtPKValue") <> "" Then
                intPKValue = Request("txtPKValue").ToString()
            End If
        End If
        If Not Request("txtEntityID") Is Nothing Then
            If Request("txtEntityID") <> "" Then
                intEntityID = Request("txtEntityID").ToString()
            End If
        End If

        If intEntityID > 0 And intPKValue > 0 Then
            ''Commented By Vaijat K ON 30/05/2016 
            'If CommonFunction.Application.EmailFormat.ToUpper() = "HTML" Then
            '    strMessage = strMessage + "<A href='http://csldesk0057:85/Whiziblesem8_Whiz3/Default.aspx?EntityID=" + Replace(CommonFunction.Encryption.Encrypt(Convert.ToString(intEntityID)), "+", "plus") + "&PKValue=" + Replace(CommonFunction.Encryption.Encrypt(Convert.ToString(intPKValue)), "+", "plus") + "'"
            '    strMessage = strMessage + "'>Click here to view the record</A>"
            'Else
            '    strMessage = strMessage + "use below link to view the record:"
            '    strMessage = strMessage + vbNewLine

            '    strMessage = strMessage + "http://csldesk0057:85/Whiziblesem8_Whiz3/Default.aspx?EntityID=" + Replace(CommonFunction.Encryption.Encrypt(Convert.ToString(intEntityID)), "+", "plus") + "&PKValue=" + Replace(CommonFunction.Encryption.Encrypt(Convert.ToString(intPKValue)), "+", "plus")
            'End If
            ''End of Commented By Vaijat K
        End If
        'end addition by Aniruddha

        Try
            Dim strExceptionMessage As String
            strExceptionMessage = CommonFunction.Emails.SendEmailWithCC(strTOEmailID, strCCEmailID.Replace(";", ","), strFromEmailID, strSubject, strMessage)
            '''''***********************************ADDED BY AMIT MAHADIK ON 08 APRIL 2011 ***********************************
            'Commented And Added By Usha Pandit On 21.04.2020 For returning strExceptionMessage as nothing when mail sending failed
            'If strExceptionMessage = "" Then
            '    m_strExceptionMessage = ""
            '    m_strMode = CONST_MODE_SUCCESS

            'Else
            '    m_strExceptionMessage = strExceptionMessage
            '    'if error occured during mail sent
            '    m_strMode = CONST_MODE_ERROR
            'End If
            If strExceptionMessage = "" Or strExceptionMessage Is Nothing Then
                m_strExceptionMessage = ""
                m_strMode = CONST_MODE_SUCCESS

            Else
                m_strExceptionMessage = strExceptionMessage
                'if error occured during mail sent
                m_strMode = CONST_MODE_ERROR
            End If
            'Commented And Added By Usha Pandit On 21.04.2020 For returning strExceptionMessage as nothing when mail sending failed

            '''''***********************************end ADDED BY AMIT MAHADIK ON 08 APRIL 2011 ***********************************
        Catch ex As Exception
            'if error occured during mail sent
            m_strMode = CONST_MODE_ERROR
        End Try
        'End If
        'end of Addition done by Darshank on 08-Jul-2008  
    End Sub


    Private Sub getEmailDetails(ByVal lngMessageID As Long)

        'Added By VidyaJ - IssueID - 672 - Whiz2.0 Integration
        'Added By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1
        If Request.QueryString("workflow") <> "" Then
            Select Case UCase(m_strMsgID)
                'Submit
                Case "70478A07-EF57-492B-9AB4-CC31F50783AB"
                    Call WorkFlows.CommonEmails.SubmitMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strPrimaryKeyValue)
                    'Approve
                Case "37E64B21-ACE3-48A9-A9F2-73A31B944987"
                    Call WorkFlows.CommonEmails.ApproveMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strCurrentStageID, m_strPrimaryKeyValue)
                    'Reject
                Case "559B9008-00BC-4C95-99F5-5AD4F5CE66FD"
                    Call WorkFlows.CommonEmails.RejectMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strCurrentStageID, m_strPrimaryKeyValue)
                    'ReSubmit
                Case "A8697C62-BCF9-46BC-ADD7-A6799179315A"
                    Call WorkFlows.CommonEmails.ReSubmitMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strPrimaryKeyValue)

                    ''<Summary>
                    ''Author: PrashantSJ
                    ''Date  : 10 May 2008
                    ''Purpose: To call Configurable workflow mails
                    ''</Summary>
                    ''Added msgIDs 19,20,21 for CRM Workflow
                Case "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21"
                    Call CommonFunction.EmailMessages.ConfigurableWorkflowMessages.GetEmailMessage(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CInt(m_strMsgID), m_strPrimaryKeyValue, m_strcomments) 'm_strUserComments
                    ''End of addition by PrashantSJ on 10th May 2008

            End Select
            Exit Sub
        End If



        Select Case lngMessageID
            Case 2
                Call CommonFunction.EmailMessages.FAMessages.GetEmailMessage_2(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngInvoiceId)
            Case 3
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_3(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(m_lngTimesheetNo, Integer))
            Case 4
                Call CommonFunction.EmailMessages.FAMessages.GetEmailMessage_4(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngTimesheetNo)
            Case 5
                Call CommonFunction.EmailMessages.FAMessages.GetEmailMessage_5(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngTimesheetNo)
                'Added By VivekP On 2 August 2005 For SP4 WhizibleSEM  IssueID-87
            Case 6
                Call CommonFunction.EmailMessages.FAMessages.GetEmailMessage_6(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngTimesheetNo)
            Case 442
                Call CommonFunction.EmailMessages.FAMessages.GetEmailMessage_442(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngTimesheetNo)
                'End Of Addition By VivekP On 2 August 2005 For SP4 WhizibleSEM

            Case 8
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_8(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngIssueID)
            Case 14
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_14(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngIssueID, m_strSendMailTo)
            Case 16
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_16(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strProjectEmployeeRoleId)
                'added by SandipL on 30-Nov-2005 for Blank Email Issue
                'Added By PradeepD on 30-Nov-2005 for SA IssueID 21893 Blank Email 
                'case 17 for sending email on Project Closure page on closure
            Case 17
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_17(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
                'End: Added By PradeepD on 30-Nov-2005 for SA IssueID 21893 Blank Email 
                'End addition by SandipL on 30-Nov-2005

                ' Code added by SwapnilR on 10th Oct 2006
                ' Purpose : Added new mail message #470
                'Added By MahendraV On 6:43 PM 5/21/2007 for closure Email events of Module,SubProject,Milestone
                ' Start_MV_5/21/2007
            Case 483
                m_UniqueID = HttpContext.Current.Request.QueryString("UniqueID").ToString()
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_483(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_UniqueID)

            Case 484
                m_UniqueID = HttpContext.Current.Request.QueryString("UniqueID").ToString()
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_484(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_UniqueID)

            Case 485
                m_UniqueID = HttpContext.Current.Request.QueryString("UniqueID").ToString()
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_485(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_UniqueID)
            Case 486
                m_UniqueID = HttpContext.Current.Request.QueryString("UniqueID").ToString()
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_486(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_UniqueID)

            Case 487
                m_UniqueID = HttpContext.Current.Request.QueryString("UniqueID").ToString()
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_487(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_UniqueID)

            Case 488
                m_UniqueID = HttpContext.Current.Request.QueryString("UniqueID").ToString()
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_488(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_UniqueID)

                ' End_MV_5/21/2007
            Case 470
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_470(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
                ' End of code addition by SwapnilR on 10th Oct 2006

            Case 20
                'Modified by VivekP on  Jun 2005
                If Request.QueryString("ProjectID") = "" Then
                    'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strTaskIDList)
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strTaskIDList, CType(HttpContext.Current.Session("intProjectID"), String))
                Else
                    Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_20(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strTaskIDList, CType(Request.QueryString("ProjectID"), String))
                End If
                'End Of Modification On 3 jun 2005
            Case 33
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_33(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngIssueID)
            Case 34
                'Added by MrugajaB for WhizibleSEM SP7
                'Code Added By PradipK on 8-June-2006
                'Purpose:To Check ShowToCustomer condition from Discussion Thread(DT) table if Mail is from DT.
                If Request.QueryString("From") = "DT" Then
                    strFrom = "DT"
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngIssueID, strFrom)
                    'Status Change Mail is firing from DT Page.
                Else
                    'Status Change Mail is firing from Issue Base Page.
                    Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_34(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngIssueID)
                End If
                'End Addition By PradipK on 8-June-2006
                'End Addition
            Case 41
                Call CommonFunction.EmailMessages.IBMessages.GetEmailMessage_41(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngIssueID)
            Case 29 'Review Planned
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_29(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(m_lngReviewID, Long))
            Case 30 ' Review Reschedulded
                'Code Commented by DipaliS 20 oct 2004
                'Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_30(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngReviewID, m_strOldReviewDate)

                'Code Added by DipaliS 20 Oct 2004
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_30(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngReviewID, m_strOldReviewDate, m_strOldReviewStartDate, m_strOldReviewEndDate)
                'End addition by DipaliS

                ' *******************************************************************************************
                ' CRM Messages Added By Rajanikanr
                'Added by SavitaS on 25 Nov 2005 for IssueID 1936 
                'Purpose:To send email when there is change of department for Help Desk Request
            Case 445
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_445(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long), m_lngDeptID, m_lngNewDeptID, m_lngDeptName, m_lngNewDeptName)
                'End Addition

                'Integrated By ManishK on 4th Jan 06
                ' CRM Messages End Addition
                ' *******************************************************************************************
                'Added by ShubhadaL for SP4 integration on 28 Oct 2005
                ' *******************************************************************************************
                ''' Added by NageshM 
                '=====================================================================
                'Purpose        : To generate the silent mail for forgot password  issue 
                'Description    : same as above
                'author         : NageshM
                'Created on     : 13 th jul 2005
                'Modified By    : 
                '=====================================================================	
            Case 443
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(m_strFromEmailID, m_strToEmailID, m_strSubject, m_strMessage, m_strLoginName, m_StrPassword)
                ''End of addition by NageshM

                'End of addition by ShubhadaL for SP4 integration on 28 Oct 2005
                'End of Integrated By ManishK on 4th Jan 06

            Case 43
                If Trim(Request("MultipleRequests") & "") = "1" Then
                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Request.QueryString("QueryID").ToString, True)
                Else
                    CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_43(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Request.QueryString("QueryID").ToString, False)
                End If
                'Added By PrashantD on 25 Feb 2006
            Case 11
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_11(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Request.QueryString("QueryID").ToString)
                'End Of Addition by PrashantD

            Case 44
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID)
            Case 45
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_45(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, "")
            Case 46
                'Commented and added by ShraddhaM on 2,Oct 2008 for LineManager Approval in Whiziblesem8
                'CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID)
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_46(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, "")
                'Code added by vidyak for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
            Case 544
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_544(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, "")
            Case 545
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_545(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, "")
                'End Code added by vidyak for Whiziblesem9 SP1-HotFix 9.0.045 (Helpdesk Request Approval Status Workflow Modifications)
            Case 530
                'Addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                'Purpose:To display comments in Approval/Rejection mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_530(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, m_strcomments)
                'End by SuchitraP on 16-Dec-2008
            Case 531
                'Addition of comments field by SuchitraP on 16-Dec-2008 for IssueID:25892
                'Purpose:To display comments in Approval/Rejection mail
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_531(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, m_strcomments)
                'End by SuchitraP on 16-Dec-2008
                'End of comment and addition by ShraddhaM
            Case 47
                CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_47(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID)
                ' CRM Messages End Addition
                ' *******************************************************************************************

                '------------Added by AbhijeetD-------------
            Case 1
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_1(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
            Case 23
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_23(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
            Case 12
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_12(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Request.QueryString("UserType").Trim, CType(Request.QueryString("UserID").Trim, Long), Request.QueryString("LoginName").Trim, Request.QueryString("Password").Trim)
            Case 21
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_21(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Session("intProjectID"), Integer))
            Case 22
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_22(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(CommonFunction.General.CheckIsNothing(Request.QueryString("MilestoneID").Trim, "0"), Integer))
            Case 13
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_13(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ReleaseID").Trim, "0"), Integer))
                '--------------End Addition-------------

            Case 15 ' Reassign the Resource
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_15(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngEmployeeID, m_lngRoleID)
            Case 68 'Leave Application
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_68(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("LeaveID").Trim, Integer))
            Case 69 'Approved Leave Application
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_69(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngLeaveId)
            Case 70 'Reject Leave Appication
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_70(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngLeaveId)
            Case 84  'Cancel Leave Application
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_84(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("LeaveID").Trim, Integer))
            Case 75
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_75(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ResourceRequestID").Trim, Integer))
            Case 80
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_80(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ResourceRequestID").Trim, Integer))
                'Added By AratiS On 19-Aug-2009 For Change ALlocation Customisation Of Resource Allocation
            Case 543
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_543(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ResourceRequestID").Trim, Integer))
                'End:Added By AratiS On 19-Aug-2009 For Change ALlocation Customisation Of Resource Allocation
                'Added by SanaS on 8-Sep-09 for Change allocation Email messages
            Case 541
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_541(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID)
            Case 542
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_542(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID)
                'End addition by SanaS on 8-Sep-09 for Change allocation Email messages
                'Added by TruptiK on 17-Jan-2008 for Prepone Booking
            Case 498
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_498(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ResourceRequestID").Trim, Integer))
            Case 499
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_499(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID, m_strEmployeeIDList)
            Case 500
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_500(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID)
            Case 501
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_501(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID)
            Case 502
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_502(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID, m_strEmployeeIDList)
            Case 503
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_503(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID, m_strEmployeeIDList)
                'End of addition by TruptiK
            Case 76 'Assigned Resource to the Project.
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_76(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID, m_strEmployeeIDList)
                'added by NileshD   on 18 May 2004
                'Added by SonalD on 14th nov 2008 for issue ID 16783
                'Purpose:To send mail to requestor when request is declined
            Case 539 'Assigned Resource to the Project.
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_539(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngRequestID, m_strEmployeeIDList)
                'End of addition by SonalD on 14th Nov 2008
            Case 203 ' Reject Assigned resource
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_203(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
                'addition end
            Case 426
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_426(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
            Case 427
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_427(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
            Case 428
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_428(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
            Case 429
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_429(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
            Case 430
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_430(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
            Case 431
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_431(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
                'added by JayavantK on  31-Jul-2004
            Case 432
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_432(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
            Case 433
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_433(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("EmployeeID"), Long), CType(Request.QueryString("RequestID"), Long))
                'addition end
                'added by SachinR   on  06 May 2004
            Case 202    'Task Modify notification
                'Modified By vivekP On 3 jun 2005
                If Request.QueryString("ProjectID") = "" Then
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_202(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(m_strTaskIDList, Long), m_lngEmployeeID, CType(HttpContext.Current.Session("intProjectID"), String))
                Else
                    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_202(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(m_strTaskIDList, Long), m_lngEmployeeID, CType(Request.QueryString("ProjectID"), String))
                End If
                'End Of Modificaion On 3 Jun 2005
                'addition end
                'added by NileshD   on 2 August 2004
            Case 52
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_52(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RFIID"), Long))
                'added by NileshD   on 3 August 2004
            Case 51
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_51(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RFIID"), Long))
            Case 53
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_53(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RFIID"), Long))
            Case 54
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_54(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RFIID"), Long), Request.QueryString("UserType"))
            Case 55
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_55(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RFIID"), Long))
                'end Of Addition
                'Added By DipaliS 10 Aug 2004
                ' Case 56
                'CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_56(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("INVOICEID"), Long))
                'End Addition By DipaliS


                '##### Cases Added For Resource Timesheet Flow on 11 AUG 2004
            Case 435 'Resource Timesheet Verified
                Dim dteFromDate As String
                Dim dteToDate As String
                Dim intVerifiedBy As Integer
                Dim strResourceID As String
                dteFromDate = CType(Request.QueryString("FromDate"), String)
                dteToDate = CType(Request.QueryString("ToDate"), String)
                intVerifiedBy = CType(Request.QueryString("VerifiedBy"), Integer)
                strResourceID = CType(Request.QueryString("ResourceID"), String)
                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_435(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intVerifiedBy, CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))

            Case 434 'Resource Timesheet ready for verification
                Dim intTimesheetID As Integer

                intTimesheetID = CType(Request.QueryString("TimesheetID"), Integer)
                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_434(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intTimesheetID)

            Case 436 'Remarks Added
                Dim intVerifiedBy As Integer
                Dim strResourceID As String
                intVerifiedBy = CType(Request.QueryString("VerifiedBy"), Integer)
                strResourceID = CType(Request.QueryString("ResourceID"), String)
                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_436(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intVerifiedBy, CType(strResourceID, Integer))

            Case 437 ' Resource Timesheet Rejected
                Dim dteFromDate As String
                Dim dteToDate As String
                Dim intVerifiedBy As Integer
                Dim strResourceID As String
                dteFromDate = CType(Request.QueryString("FromDate"), String)
                dteToDate = CType(Request.QueryString("ToDate"), String)
                intVerifiedBy = CType(Request.QueryString("VerifiedBy"), Integer)
                strResourceID = CType(Request.QueryString("ResourceID"), String)
                CommonFunction.EmailMessages.ResourceTimesheetMessages.GetEmailMessage_437(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intVerifiedBy, CType(strResourceID, Integer), CType(dteFromDate, Date), CType(dteToDate, Date))
                '##### End of cases for Resource Timesheet Flow 

                'added by SachinR   on 20 Aug 2004
            Case 438    'for Deliverable discussion thread mail
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_438(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ScheduleID").ToString, Long), CType(Request.QueryString("DiscussionID").ToString, Long), CType(Request.QueryString("Show").ToString, Int16))
                'addition end
                'added by SachinR   on 24 Aug 2004
            Case 439    'for Deliverable status change mail
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_439(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ScheduleID").ToString, Long))
                'addition end
                'Added by ShamkantD for Plan Deliverables on 31st August 2004
            Case 79
                Dim strParentTaskIDs As String, strEmployeeID As String, strTitle As String
                strParentTaskIDs = Request.QueryString("ParentTaskID")
                strEmployeeID = Request.QueryString("EmployeeID")
                strTitle = Request.QueryString("Title")

                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_79(strEmployeeID, strParentTaskIDs, m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, strTitle)
                'End of addition - ShamkantD for Plan Deliverables on 31st August 2004

                'Added by ShamkantD on 29 Sep 2004 - added for Project Creation Workflow
            Case 440
                'Commented by DipaliS 27 Oct 2004
                'Purpose:   Issue 13593
                'Dim intApproverID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ApproverID"), "0"), Integer)
                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)

                'Added by DipaliS 27 Oct 2004
                'Purpose:   Issue 13593
                Dim intBusinessGroupId As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("BusinessGroupID"), "0"), Integer)
                Dim intLocationId As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("LocationID"), "0"), Integer)
                'End addition

                'Commented by DipaliS 27 Oct 2004
                'Purpose:   Issue 13593
                'CommonFunction.EmailMessages.PMMessages.GetEmailMessage_440(intApproverID.ToString(), m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intProjectID)
                'Added by DipaliS 27 Oct 2004
                'Purpose:   Issue 13593
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_440(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intProjectID, intBusinessGroupId.ToString, intLocationId.ToString)
                'End addition


                'End of addition - ShamkantD on 29 Sep 2004

                'Added by ShamkantD on 30 Sep 2004
            Case 441
                Dim intRecipientID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RecipientID"), "0"), Integer)
                Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)
                Dim strApprovalStatus As String = CommonFunction.General.CheckIsNothing(Request.QueryString("ApprovalStatus"), "").ToString()
                Dim intRevisionReasonID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RevisionReasonID"), "0"), Integer)

                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_441(intRecipientID.ToString(), m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intProjectID, strApprovalStatus, intRevisionReasonID)
                'End of addition - ShamkantD on 30 Sep 2004
                'added by dipalis 1 Nov 2004
            Case 73
                Dim intReviewStatisticsID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ReviewStatisticsID"), "0"), Integer)
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_73(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intReviewStatisticsID)
                'end addition by DipaliS

                'Integrated by MrugajaB on 20th March 2006 for WhizibleSEM 6.0 Expense WorkFlow - Issue ID.2886
                'Added By VivekP On 18 May 2005 For Expense Work Flow
            Case 460
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)
                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_460(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 461
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)
                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_461(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 462
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)
                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_462(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 463
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)
                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_463(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 464
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)

                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_464(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 465
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)
                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_465(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 466
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)

                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_466(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
            Case 467
                Dim ExpenseSheetID As Long
                Dim ExpenseEntryIDList As String

                ExpenseSheetID = CType(Request.QueryString("ExpenseSheetID"), Long)
                ExpenseEntryIDList = CType(Request.QueryString("ExpenseEntryIDList"), String)

                CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_467(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, ExpenseSheetID, ExpenseEntryIDList)
                'End Of Addition By VivekP On 18 May 2005 For Expense Work Flow
                ' End Modification By NitinVS on 24 May 2005 for Expense Workflow Implementation

                'Added Code by TinaB 6th June 2005
                ' Commented By MahendraV On 12:32 PM 9/7/2007 For WhizibleSEM 7.1
                ' Purpose : It is not used in base product
                ' Start_MV_9/7/2007
                ' Case 468
                ' CommonFunction.EmailMessages.EWFMessages.GetEmailMessage_468(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
                ' End_MV_9/7/2007
                'End of Added Code by TinaB 6th June 2005
                'End Integration

            Case 471    'for Deliverables Creation JP_21Aug2006

                Dim intScheduleID As Integer
                intScheduleID = CType(Request.QueryString("ScheduleID"), Integer)
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_471(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ScheduleID").ToString, Long))
            Case 472    'for Deliverables From Change Request  JP_21Aug2006
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_472(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ChangeRequestID").ToString, Long))
            Case 473    'for Deliverables from Issues   JP_21Aug2006
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_473(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("IssueID").ToString, Long))
                'Integrated by SandipL SP8 to SP9
            Case 475
                Dim ProjectId As Integer
                Dim Approver As String
                Dim CC As String
                Dim strProjectName As String
                Dim intProjectRequirementId As Integer
                intProjectRequirementId = CType(Request.QueryString("ProjectRequirementId"), Integer)

                Approver = CType(Request.QueryString("ReqApprovedBy"), String)
                CC = CType(Request.QueryString("ResponsiblePersonID"), String)
                ProjectId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)

                CommonFunction.EmailMessages.RMMessages.GetEmailMessage_475(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Approver)
            Case 477
                CommonFunction.EmailMessages.RMMessages.GetEmailMessage_477(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ProjectDocumentRefTypeId").ToString, Long))
            Case 479
                Dim ProjectId As Integer
                ' Dim CC As String
                Dim strProjectName As String
                Dim intProjectRequirementId As Integer

                intProjectRequirementId = CType(Request.QueryString("ProjectRequirementId"), Integer)
                ProjectId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)
                CommonFunction.EmailMessages.RMMessages.GetEmailMessage_479(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
            Case 480
                Dim ProjectId As Integer
                ' Dim CC As String
                Dim strProjectName As String
                Dim intProjectRequirementId As Integer

                intProjectRequirementId = CType(Request.QueryString("ProjectRequirementId"), Integer)
                ProjectId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)
                CommonFunction.EmailMessages.RMMessages.GetEmailMessage_480(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
                'End Integration by SandipL SP8 to SP9
                'Added by VarunA on 15-May-2007 Cleanup Activity for leave workflow
            Case 481 'Leave Submission Onbehalf

                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_481(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("LeaveID").Trim, Integer))
                'End By VarunA on 15-May-2007
                'Added By ShraddhaM on 28,June 2007
            Case 489 'Defaulter Mail From Resource Calender View
                Dim StartDate As String
                Dim intProjectID As Integer
                Dim intEmpID As Integer
                Dim intLoginID As Integer
                StartDate = Request.QueryString("StartDate")
                intProjectID = CType(Request.QueryString("ProjectID"), Integer)
                intEmpID = CType(Request.QueryString("EmployeeID"), Integer)
                intLoginID = CType(Request.QueryString("LoginUser"), Integer)
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_489(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, StartDate, intProjectID, intEmpID, intLoginID)

                'End of Addition By ShraddhaM on 28,June 2007
            Case 493
                'Added  by ArchanaN on 3 Dec 2007
                'Purpose : Send for Opportunity Approval
                Dim intOpportunityID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("OpportunityID"), "0"), Integer)
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_493(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intOpportunityID)
                'End addition
            Case 494
                ' Dim intRecipientID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RecipientID"), "0"), Integer)
                Dim intOpportunityID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("OpportunityID"), "0"), Integer)

                'Dim intProjectID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("OpportunityID"), "0"), Integer)
                ' Dim strApprovalStatus As String = CommonFunction.General.CheckIsNothing(Request.QueryString("ApprovalStatus"), "").ToString()
                ' Dim intRevisionReasonID As Integer = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("RevisionReasonID"), "0"), Integer)

                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_494(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, intOpportunityID)
                'End of addition - ShamkantD on 30 Sep 2004
                'added by dipalis 1 Nov 2004
                'Added by ShraddhaM on 11,Jul 2008
                'Purpose : To integrate Risk Registration from Whizible 2007 
            Case 532
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_532(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RiskID").ToString, Long))
            Case 533
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_533(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("RiskID").ToString, Long), intOldCostOpportunity, intOldSizeOppurtunity, OldOppurtunityStatus, OldAssignedTo)
            Case 534
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_534(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("MitigationPlanID").ToString, Long))

            Case 535
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_535(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("CommunicationID").ToString, Long))
            Case 536
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_536(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("CommunicationID").ToString, Long), strOldStartDate, strOldEnddate, intOldDuration, strOldFrequency, strOldResponsiblePerson)
            Case 537
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_537(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("CommunicationID").ToString, Long))
            Case 538
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_538(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ContingencyPlanID").ToString, Long))
                ''added by Amit Mahadik  on 11 April 2011
            Case 1002
                Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_1002(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ProjectID").ToString, Long))
                ''End  added by Amit Mahadik  on 11 April 2011
                ''ADDED by Amit Mahadik on 01 August 2011 for the purpose:  Whiziblesem 10.0 Issue ID:50821
            Case 1003
                Call CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_1003(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_lngQueryID, m_strIsShowToCustomer, Session("LoginType").ToString)
                ''End ADDED by Amit Mahadik on 01 August 2011 for the purpose:  Whiziblesem 10.0 Issue ID:50821

                ''Added By Ashwinim on 28th Feb 2013
            Case 20003
                Call CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_20003(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestID"), "0"), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowToCustomer"), 0), HttpContext.Current.Session("LoginType").ToString, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Comments"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueID"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), 0))

            Case 20004
                Call CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_20004(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("RequestID"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ShowToCustomer"), 0), HttpContext.Current.Session("LoginType").ToString, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("Comments"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("IssueID"), 0), CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("ProjectID"), 0))

                'Added By Bharat T on 28th-Oct-2016 for Euronet Password Policy Customization
            Case 20031
                Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20031(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CommonFunctions.General.CheckIsNothing(HttpContext.Current.Request.QueryString("LoginName"), ""))
                'End of Added By Bharat T on 28th-Oct-2016 for Euronet Password Policy Customization

            Case Else

        End Select

    End Sub


    '=====================================================================
    ' Procedure Name		:	GetFormatedEmailIDList
    ' Parameters Passed		:	strEmailIDList - String
    ' Returns				:	none
    ' Parameters Affected	:	None
    ' Purpose				:	To get the formated list of email id passes as parameter.
    ' Description			:	This procedure will take quama seperated or space seperated list of email ids
    '                           as parameter and returns the ';' seperated list of email ids.
    ' Assumptions			:	None
    ' Dependencies			:	None
    ' Author				:	SachinR
    ' Created				:	Feb 12 2004
    ' Revisions				:	
    '=====================================================================
    Private Function GetFormatedEmailIDList(ByVal strEmailIDList As String) As String
        Dim arrEmailID() As String
        Dim intCnt As Integer

        If strEmailIDList <> "" Then
            'replace all occuerences of ',' or space from the list by ';' and split the list 
            strEmailIDList = strEmailIDList.Replace(",", ";")
            strEmailIDList = strEmailIDList.Replace(" ", ";")
            arrEmailID = Split(strEmailIDList, ";")

            strEmailIDList = ""

            For intCnt = 0 To arrEmailID.Length - 1
                If arrEmailID(intCnt) <> "" Then
                    strEmailIDList += arrEmailID(intCnt).Trim + ";"
                End If
            Next

            GetFormatedEmailIDList = strEmailIDList.Trim
        End If
    End Function

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "SendEmail->InvalidInput"
        Throw ex
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub
End Class
