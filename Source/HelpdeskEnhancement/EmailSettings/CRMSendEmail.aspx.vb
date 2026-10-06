Imports CommonFunctions
Imports System.Web.UI.WebControls
Imports System.Text
Imports System.Net.Mail
Imports System.IO
Imports System.Linq
Imports System.Net
Imports System.Net.Http
Imports EASendMail
Imports Newtonsoft.Json
Imports Newtonsoft.Json.Linq

Public Class CRMSendEmail

    Inherits WebPages.Template.WhizTemplate
    Protected CONST_MAIL As String = "EMAIL"
    Protected CONST_MODE_ERROR As String = "ERROR"
    Protected CONST_MODE_SUCCESS As String = "SUCCESS"
    Protected CONST_ACTION_SEND As String = "SEND"

    Protected m_strMode As String
    Public HasFile As Boolean
    'Private strAttachmentlisteds() As String

    Private strAttachmentlisteds As String() = {""}


    '
    Private m_strAction As String
    Protected m_lngMessageID As Long
    Protected m_DiscussionID As String = ""
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

    Private m_strAttatchments() As String
    Private m_strHrefForAttachs() As String
    Private m_strFilePath As String
    Private m_strFileNames() As String
    Private m_strFile As String
    Private m_strParameter As String = ""
    Private m_strHrefForAttatch As String
    Private m_strSeperator As String = ","
    Private m_charSep() As Char = m_strSeperator.ToCharArray

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

        CommonFunction.HTMLControls.DrawTextBox("txtPKValue", "txtPKValue", , , , Convert.ToString(PKValue), , , , , , True)
        CommonFunction.HTMLControls.DrawTextBox("txtEntityID", "txtEntityID", , , , Convert.ToString(EntityID), , , , , , True)
        'end addtion by Anirudha
        'Commented By Dipali V On 25th Oct 2017 For Send Mail New Page
        ''Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 
        'General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 >")
        'General.WriteHTML("<TR class='clsTRSectionHeader'>")
        'General.WriteHTML("<TD align='center'>")
        ''General.WriteHTML("<IMG Border=0 style='display:none'  SRC='../../Images/TemporaryImages/ajax-loader.gif' title='Loading.....' onclick='' ID='imgLoader' name='imgLoader'>")
        'General.WriteHTML("<IMG Border=0 style='display:none'  SRC='../../Images/TemporaryImages/2.gif' title='Loading.....' onclick='' ID='imgLoader' name='imgLoader'>")
        'General.WriteHTML("</TD></TR>")
        'General.WriteHTML("</Table>")
        ''End of Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 
        'End of Commented By Dipali V On 25th Oct 2017 For Send Mail New Page
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

        'Dipali V On 26th Oct 2017
        If Request.QueryString("DiscussionID") <> "" Then
            m_DiscussionID = Request.QueryString("DiscussionID").ToString()
        End If
        'End of Dipali V On 26th Oct 2017

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
        If (m_lngMessageID = 1003) And m_strAction <> "SEND" Then
            Dim strToken As String = CommonFunctions.Security.Token.GetToken(m_lngMessageID & m_lngQueryID & m_strIsShowToCustomer & HttpContext.Current.Session("intUserid") & 0)
            If (strToken <> Request.QueryString("PkToken")) Then
                System.Web.HttpContext.Current.Response.Redirect("../../General/CommonPage.aspx?MasterTagID=1836")
            End If
        End If

        ''End Added By Vaijat K ON 14/07/2017 For generating token

        Select Case m_strMode.ToUpper
            Case CONST_MAIL, CONST_MODE_ERROR

                'initialize the resource file for standard menu.
                MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
                'Commented By Dipali v On 25th Oct 2017 For Removing Menu Links
                'arrMenu = New System.Collections.ArrayList
                'arrMenuToolTip = New System.Collections.ArrayList
                'arrClientSideFunctions = New System.Collections.ArrayList


                'if error occured then dont show send menu
                'If m_strMode.ToUpper <> CONST_MODE_ERROR Then
                '    arrMenu.Add(MyBase.GetResourceString("MENU_SEND")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SEND_TOOLTIP")) : arrClientSideFunctions.Add("Send_OnClick()")
                'End If
                'arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
                'arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('SEND_MAIL')")

                ''copy all the element to string array
                'Dim arrstrMenu(arrMenu.Count - 1) As String
                'Dim arrstrMenuToolTip(arrMenuToolTip.Count - 1) As String
                'Dim arrstrClientSideFunctions(arrClientSideFunctions.Count - 1) As String
                'arrMenu.CopyTo(arrstrMenu)
                'arrMenuToolTip.CopyTo(arrstrMenuToolTip)
                'arrClientSideFunctions.CopyTo(arrstrClientSideFunctions)
                'arrMenu = Nothing
                'arrMenuToolTip = Nothing
                'arrClientSideFunctions = Nothing

                'strMenu = WebPage.Templates.StaticMenu.DrawMenu(arrstrMenu, arrstrClientSideFunctions, arrstrMenuToolTip, True)

                ''draw upper menu
                'General.WriteHTML(strMenu)

                'Display the (* Mandatory) PageLegends 
                'Dim strarrLegend() As String = {"Mandatory"}
                'Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
                ' General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)
                'End of Commented By Dipali v On 25th Oct 2017 For Removing Menu Links
                'initialize the resource file for Discussion page.
                MyBase.InitializeResources("AppResources.SendEmail", "AppResources")

                'draw page caption 
                'Commented By Dipali V On 25th Oct 2017 For Send Mail Pop_Up Page
                ' WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_EMAIL"))
                'End of Commented By Dipali V On 25th Oct 2017 For Send Mail Pop_Up Page
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
                    General.WriteHTML("var objImgLoader = GetObjectReference('frmCRMSendEmail','imgLoader');")
                    General.WriteHTML("objImgLoader.style.display = ""none"";")
                    General.WriteHTML("</script>")
                    'End of Added by NitinC on 26 April 2011 for WhizibleSEM 10.0 

                    'if error in seding the mail then show error msg.
                    General.WriteHTML("<Table class='clsTable' width=99.9% cellspacing=0 cellpadding=0 style='margin-top:3%' >")
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
                    General.WriteHTML("<a href='javascript:ShowDescription_onClick()'><IMG Border=0  SRC='../../../Images/plus.gif' Collapse='N' title='Description' onclick='' ID='imgSummaryShowHide' name='imgSummaryShowHide'>&nbsp;Error Details </a>")
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

                'Commented and Added by Usha Pandit On 28.12.2018 for Email success message display issue
                'General.WriteHTML("<TD align='center'>")
                General.WriteHTML("<TD align='center' style = 'padding-top: 24px!important;'>")
                'End of Added by Usha Pandit On 28.12.2018 for Email success message display issue

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

    Private Sub plotScreenForEmail()
        '=====================================================================
        ' Procedure Name		:	plotScreenForEmail
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw all controls on the page for SendEmail page.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali Vekhande
        ' Created				:	25th Oct 2017
        ' Revisions				:	
        '=====================================================================
        'Flag Acess
        Dim strsqlFlag As String
        strsqlFlag = "usp_sel_tbl_PM_CompanyInformation "
        strsqlFlag = strsqlFlag.Replace("''", "'")
        Dim drdataFlag As IDataReader
        Dim IsAllowExistingAttachment As String = ""
        Dim IsAllowNewAttachment As String = ""

        drdataFlag = CommonFunctions.Data.GetDataReader(strsqlFlag, True)
        If drdataFlag.Read() Then

            IsAllowExistingAttachment = CommonFunctions.Data.CheckIsDBNull(drdataFlag("IsAllowExistingAttachment"), "")
            IsAllowNewAttachment = CommonFunctions.Data.CheckIsDBNull(drdataFlag("IsAllowNewAttachment"), "")
        End If
        CommonFunctions.Data.DisposeDataReader(drdataFlag)
        drdataFlag = CommonFunctions.Data.GetDataReader(strsqlFlag, True)
        'End Flag Acess



        General.WriteHTML("<div id='id06'>")

        General.WriteHTML("<div class='imgcontainer'>")
        General.WriteHTML("<span class='appro-title'>Send Mail</span>")
        'Commented & Added By Dipali V On 28th March 2023 For Hide Window
        'General.WriteHTML("<span onclick='Cancel_OnClick()' class='close' title='Close'>&times;</span>")
        General.WriteHTML("<span onclick='window.close();' class='close' title='Close'>&times;</span>")
        'End of Commented & Added By Dipali V On 28th March 2023 For Hide Window
        General.WriteHTML("</div>")

        General.WriteHTML("<div class='container'>")

        General.WriteHTML("<div class='form-group'>")
        General.WriteHTML("<table style='width:100%'>")
        General.WriteHTML("<tr>")
        General.WriteHTML("<td>")
        General.WriteHTML("<label for='to'class='col-md-1'>To</label>")
        General.WriteHTML("</td>")
        General.WriteHTML("<td>")
        General.WriteHTML("<div class='col-md-9'>")
        General.WriteHTML("<input type='text' class='form-control' id='txtToEmailID' placeholder='Enter To' name='txtToEmailID' value='" & m_strToEmailID + "".Trim & "' onkeyup=ClearSpan('txtToEmailID','SpantxtToEmailID')>")
        'General.WriteHTML("<span id='SpantxtToEmailID'></span>")
        General.WriteHTML("<span style='color: #dd1037; font-size: 12px;' id='SpantxtToEmailID'></span>")
        General.WriteHTML("</div>")
        General.WriteHTML("</td>")

        General.WriteHTML("<td>")
        General.WriteHTML("<div class='col-md-2'>")
        'General.WriteHTML("<span><a href='#'>Cc  </a></span><span><a href='#'>Bcc</a></span>")
        General.WriteHTML("</div>")
        General.WriteHTML("</td>")
        General.WriteHTML("</tr>")
        General.WriteHTML("</table>")
        General.WriteHTML("</div>")


        General.WriteHTML("<div class='form-group'>")
        General.WriteHTML("<table style='width:100%'>")
        General.WriteHTML("<tr>")
        General.WriteHTML("<td>")
        General.WriteHTML("<label for='cc' class='col-md-1'>Cc</label>")
        General.WriteHTML("</td>")
        General.WriteHTML("<td>")
        General.WriteHTML("<div class='col-md-9'>")
        General.WriteHTML("<input type='text' class='form-control' id='txtCCToEmailID' placeholder='Enter Cc' name='txtCCToEmailID' value='" & m_strCCEmailID + "".Trim & "'  onkeyup=ClearSpan('txtCCToEmailID','SpantxtCCToEmailID')>")
        General.WriteHTML("<span style='color: #dd1037; font-size: 12px;' id='SpantxtCCToEmailID'></span>")
        General.WriteHTML(" </div>")
        General.WriteHTML("</td>")

        General.WriteHTML("<td>")
        General.WriteHTML("<div class='col-md-2'>")
        General.WriteHTML("</div>")
        General.WriteHTML("</td>")
        General.WriteHTML("</tr>")
        General.WriteHTML("</table>")
        General.WriteHTML("</div>")


        'General.WriteHTML("<TR class='clsTREven' >")
        'General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("NOTE") + " :</TD>")
        'General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("EMAIL_NOTE") + "</TD>")
        'General.WriteHTML("</TR>")


        General.WriteHTML("<div class='form-group'>")
        'Commented & Added By Dipali V On 10th May 2023 For UI Issue
        'General.WriteHTML("<table style='width: 88%;margin-left: 12%;'>") 
        General.WriteHTML("<table style='width: 88%;'>") ';margin-left: 12%;
        'End of Commented & Added By Dipali V On 10th May 2023 For UI Issue
        General.WriteHTML("<tr>")
        General.WriteHTML("<td >")
        General.WriteHTML("<label class='' style='font-size:10px'> " + MyBase.GetResourceString("NOTE") + ": &nbsp;</label>")
        General.WriteHTML("</td>")
        General.WriteHTML("<td>")
        General.WriteHTML("<div class='' style='font-size:10px'>")
        General.WriteHTML(MyBase.GetResourceString("EMAIL_NOTE"))
        General.WriteHTML("</div>")
        General.WriteHTML("</td>")
        General.WriteHTML("<td>")
        General.WriteHTML("<div class='col-md-2'>")

        General.WriteHTML("</div>")
        General.WriteHTML("</td>")
        General.WriteHTML("</tr>")
        General.WriteHTML("</table>")
        General.WriteHTML("</div>")


        General.WriteHTML("<div class='form-group'>")
        General.WriteHTML("<table style='width:100%'>")
        General.WriteHTML("<tr>")
        General.WriteHTML("<td>")
        General.WriteHTML("<div class='col-md-12'>")
        General.WriteHTML("<label for='subject'>Subject * </label>")
        General.WriteHTML("<input type='text' class='form-control' id='txtSubject' placeholder='Enter Subject' name='txtSubject' value='" & m_strSubject + "".Trim & "'  onkeyup=ClearSpan('txtSubject','SpantxtSubject')>")
        General.WriteHTML("<span style='color: #dd1037; font-size: 12px;' id='SpantxtSubject'></span>")
        General.WriteHTML("</div>")
        General.WriteHTML("</td>")
        General.WriteHTML("</tr>")
        General.WriteHTML("</table>")
        General.WriteHTML("</div>")

        Dim strMsg As String = ""
        General.WriteHTML("<div class='form-group'>")
        General.WriteHTML("<label for='subject'>Description * </label>")
        Dim strTempMessage As String = m_strMessage
        If strMsg <> "" Then
            strTempMessage += "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg
        Else
            strTempMessage += "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10)
        End If
        If strMsg <> "" Then
            'Commented and Added by Usha Pandit on 19 Apr 2019  for removing magnifier for textarea
            'General.WriteHTML("<TD align='left' style='vertical-align: top; ' valign='top'  colspan='2'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", "form-control", , "frmCRMSendEmail", "../../../images/zoomin.gif", , 498, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , "onkeyup=ClearSpan('txtMessage','SpantxtMessage')", True, False) + "</TD>")
            General.WriteHTML("<TD align='left' style='vertical-align: top; ' valign='top'  colspan='2'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", "form-control", , "", "", , 498, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , "onkeyup=ClearSpan('txtMessage','SpantxtMessage')", True, False) + "</TD>")
            'End of Added by Usha Pandit on 19 Apr 2019 for removing magnifier for textarea
        Else
            'Commented and Added by Usha Pandit on 19 Apr 2019  for removing magnifier for textarea
            'General.WriteHTML("<TD align='left' style='vertical-align: top; ' valign='top'  colspan='2'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", "form-control", , "frmCRMSendEmail", "../../../images/zoomin.gif", , 498, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10), , , , , , , "onkeyup=ClearSpan('txtMessage','SpantxtMessage')", True, False) + "</TD>")
            General.WriteHTML("<TD align='left' style='vertical-align: top; ' valign='top'  colspan='2'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", "Message", "form-control", , "", "", , 498, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10), , , , , , , "onkeyup=ClearSpan('txtMessage','SpantxtMessage')", True, False) + "</TD>")
            'End of Added by Usha Pandit on 19 Apr 2019 for removing magnifier for textarea
        End If
        General.WriteHTML("<span style='color: #dd1037; font-size: 12px;' id='SpantxtMessage'></span>")
        General.WriteHTML("</div>")
        General.WriteHTML("<div class='top-bar'>")
        General.WriteHTML("<ul class='left'>")
        General.WriteHTML("<li>")
        If IsAllowNewAttachment = "True" Then
            General.WriteHTML("<button type='button' class='btn btn-default attch left' style='margin-left:-10%' id='btnSelectFile' FileCount='0' onclick='SelectFile()';><i class='fa fa-paperclip' aria-hidden='true'></i>Attachment</button>")
        End If

        ' m_DiscussionID

        General.WriteHTML("<div id='FileControlUploadDiv'>")
        General.WriteHTML(CommonFunctions.HTMLControls.DrawFileControl("txtFileName0", "txtFileName0", , 74, , , , , , "onchange='addFileinGrid()' style=display:none;", True, , ))
        General.WriteHTML("</div>")
        General.WriteHTML("</li>")

        General.WriteHTML("</ul>")
        General.WriteHTML("<ul class='right'>")
        General.WriteHTML("<li class='save' style='border:none;'>")
        General.WriteHTML("<button type='button' class='btn btn-default save' onclick='Send_OnClick()' title='Send'>Send</button>")
        General.WriteHTML("</li>")
        General.WriteHTML("<li>")
        'Commented & Added By Dipali V On 28th March 2023 For Hide Window
        'General.WriteHTML("<button type='button' class='btn btn-default save' id='btncancel'  onclick='Cancel_OnClick();' title='Cancel'>Cancel</button>")
        General.WriteHTML("<button type='button' class='btn btn-default save' id='btncancel'  onclick='window.close();' title='Cancel'>Cancel</button>")
        'End of Commented & Added By Dipali V On 28th March 2023 For Hide Window
        General.WriteHTML("</li>")
        General.WriteHTML("</ul>")
        General.WriteHTML("</div>")
        Dim strsql As String
        If m_DiscussionID = "" Then
            strsql = "usp_NG2_sel_AttachmentDetails null," & m_lngQueryID & ""
        Else
            strsql = "usp_NG2_sel_AttachmentDetails " & m_DiscussionID & "," & m_lngQueryID & ""
        End If

        strsql = strsql.Replace("''", "'")
        Dim drdata As IDataReader
        Dim SystemFileName As String = ""
        Dim OriginalFileName As String = ""
        drdata = CommonFunctions.Data.GetDataReader(strsql, True)

        Dim Flag As Integer = 0
        Dim Count As Integer = 0
        Dim intCount As Integer
        ' If m_lngMessageID <> 44 And m_lngMessageID <> 544 And m_lngMessageID <> 45 Then
        If drdata.Read() Then
            Flag = 1
            OriginalFileName = CommonFunctions.Data.CheckIsDBNull(drdata("OriginalFileName"), "")
            SystemFileName = CommonFunctions.Data.CheckIsDBNull(drdata("SystemFileName"), "")
        End If
        CommonFunctions.Data.DisposeDataReader(drdata)
        drdata = CommonFunctions.Data.GetDataReader(strsql, True)
        ' End If

        General.WriteHTML("<div class='bottom-bar'>")
        If Flag = 1 And IsAllowExistingAttachment = "True" Then
            General.WriteHTML("<table id='tblFiles' style='width:90%;' class='clsGridTable table'>")
        Else
            General.WriteHTML("<table id='tblFiles' style='display:none;width:90%;' class='clsGridTable table'>")
        End If


        General.WriteHTML("<thead class='clsTRColumnHeader' align='left'>")
        General.WriteHTML("<tr>")
        General.WriteHTML("<th>Files</th>  ")
        General.WriteHTML("<th>Remove</th>  ")
        General.WriteHTML("</tr>")
        General.WriteHTML("</thead>")
        General.WriteHTML("<tbody>")
        strAttachmentlisteds = New String(1) {}

        m_strFilePath = AppDomain.CurrentDomain.BaseDirectory
        m_strFilePath = m_strFilePath + "ATTACHMENTS\CRM\"
        Dim m_strFilePath1 As String
        'If m_lngMessageID <> 44 And m_lngMessageID <> 544 And m_lngMessageID <> 45 Then
        If IsAllowExistingAttachment = "True" Then
            If Flag = 1 Then
                While drdata.Read

                    ' Count = Count + 1
                    OriginalFileName = CommonFunctions.Data.CheckIsDBNull(drdata("OriginalFileName"), "")
                    SystemFileName = CommonFunctions.Data.CheckIsDBNull(drdata("SystemFileName"), "")
                    m_strFilePath1 = m_strFilePath + SystemFileName

                    'If System.IO.File.Exists(m_strFilePath1) Then
                    strAttachmentlisteds(Count) = m_strFilePath + SystemFileName
                    General.WriteHTML("<tr class='clsTREven' id='FILENAME" & Count & "' >")
                    'Count = Count
                    General.WriteHTML("<td title='File Name'>")
                    General.WriteHTML(OriginalFileName)
                    ' General.WriteHTML("<A HREF=""" + "Javascript:OpenFile('" + m_strHrefForAttachs(Count).Trim.Replace("'", "\'") + "');" + """><FONT color=blue>" + m_strFileNames(Count) + "</FONT>;</A>")
                    General.WriteHTML("</td>")
                    General.WriteHTML("<td>")
                    General.WriteHTML("<A class='' style='' HREF='Javascript:RemoveAttachement(" & Count & ")' Title='Remove Attachment' >(Remove)</A>")
                    General.WriteHTML("</td>")
                    General.WriteHTML(CommonFunctions.HTMLControls.DrawFileControl("txtFileName" & Count & "", "txtFileName" & Count & "", , 74, , , , , , "onchange='addFileinGrid()' style=display:none;", True, , ))

                    General.WriteHTML("</tr>")
                    Count = Count + 1
                    intCount += 1
                    ReDim Preserve strAttachmentlisteds(Count)
                    ' Else
                    'the file doesn't exist
                    'End If

                End While
                General.WriteHTML("<input type='hidden' id='hdncount' value='" & Count & "'>")
                General.WriteHTML(CommonFunctions.HTMLControls.DrawFileControl("txtFileName" & Count & "", "txtFileName" & Count & "", , 74, , , , , , "onchange='addFileinGrid()' style=display:none;", True, , ))
            End If


            intCount = 0
            m_strFilePath = ""
            ' strAttachmentlisteds.Length = Count
            While intCount < strAttachmentlisteds.Length - 1
                m_strFilePath += strAttachmentlisteds(intCount) + ","
                intCount += 1
            End While
            'Remove the last ","
            If m_strFilePath <> "" Then
                m_strFilePath = Left(m_strFilePath, m_strFilePath.Length - 1)
            End If

            intCount = 0
            m_strFile = ""



            General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFilePath", "txtFilePath", , , , m_strFilePath, , , , , , True, , True))
            General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFileHref", "txtFileHref", , , , m_strHrefForAttatch, , , , , , True, , True))
            General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFileName", "txtFileName", , , , m_strFile, , , , , , True, , True))
            'Plot Hidden Control for the QueryString Value
            General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtParameter", "txtParameter", , , , m_strParameter, , , , , , True, , True))

        End If

        ' End If



        General.WriteHTML("</tbody>")
        General.WriteHTML("</table>")
        General.WriteHTML("</div>")
        General.WriteHTML("</div>")
        General.WriteHTML("</div>")

    End Sub


    Private Sub performSendMailAction(ByVal lngMessageID As Long)
        '=====================================================================
        ' Procedure Name		:	performSendMailAction
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw all controls on the page for SendEmail page.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali Vekhande
        ' Created				:	25th Oct 2017
        ' Revisions				:	
        '=====================================================================
        Dim strTOEmailID As String
        Dim strCCEmailID As String
        Dim strSubject As String
        Dim strMessage As String
        Dim lngUserID As Long
        Dim strFromEmailID As String
        Dim strSQL As String
        Dim objDR As IDataReader
        Dim strLoginType As String


        'get the values from the page controls
        strTOEmailID = GetFormatedEmailIDList(MyBase.GetFormValue("txtToEmailID", False) + "")
        strCCEmailID = GetFormatedEmailIDList(MyBase.GetFormValue("txtCCToEmailID", False) + "")
        strSubject = MyBase.GetFormValue("txtSubject", False) + ""
        strMessage = MyBase.GetFormValue("txtMessage", False) + ""
        strFromEmailID = MyBase.GetFormValue("txtFromEmailID") + ""
        m_strFilePath = MyBase.GetFormValue("txtFilePath") + ""
        m_strFile = MyBase.GetFormValue("txtFileName") + ""
        m_strHrefForAttatch = MyBase.GetFormValue("txtFileHref") + ""
        'Form the Array
        If m_strFilePath <> "" Then
            strAttachmentlisteds = m_strFilePath.Split(m_charSep)
        End If

        If m_strFile <> "" Then
            m_strFileNames = m_strFile.Split(m_charSep)
        End If

        If MyBase.GetFormValue("txtParameter") <> "" Then
            m_strParameter = MyBase.GetFormValue("txtParameter")
        End If

        If m_strHrefForAttatch <> "" Then
            m_strHrefForAttachs = m_strHrefForAttatch.Split(m_charSep)
        End If

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




        Try
            'send the mail
            'Added by Dipali v on 27th Oct 2017 For Nexgen Version 02
            If Request.Files.Count > 0 Or Request.Files.Count = 0 And Not (Request.Files Is Nothing) Then
                SendEmailWithAttachment(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage, Request.Files, strAttachmentlisteds)
                ''SendEmailWithAttachment(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage, m_strAttatchments)
                'mail has beed sent successfully
                m_strMode = CONST_MODE_SUCCESS
                PerformFurtherActions(lngMessageID, m_strParameter)
            Else

                ' CommonFunction.Emails.SendEmailWithCC(strTOEmailID, strCCEmailID.Replace(";", ","), strFromEmailID, strSubject, strMessage)

            End If

            'End of Added by Dipali v on 27th Oct 2017 For Nexgen Version 02

        Catch ex As Exception

            'if error occured during mail sent
            m_strMode = CONST_MODE_ERROR

        End Try

    End Sub

    'Added By Vyankat B. on 1st July 2026 for configurable SMTP / Azure Graph email delivery
    Private Shared tenantId As String = ConfigurationManager.AppSettings("tenantId_Email").ToString()
    Private Shared clientId As String = ConfigurationManager.AppSettings("ClientID_Email").ToString()
    Private Shared clientSecret As String = ConfigurationManager.AppSettings("clientSecret_Email").ToString()
    Private Shared UserAPI As String = ConfigurationManager.AppSettings("UserAPI_Email").ToString()

    Private Shared Function IsSMTPEnabled() As Boolean
        Dim isSMTPEnable As String = ConfigurationManager.AppSettings("IsSMTPEnable")
        If String.IsNullOrWhiteSpace(isSMTPEnable) Then
            Return True
        End If

        Dim parsedValue As Boolean
        If Boolean.TryParse(isSMTPEnable, parsedValue) Then
            Return parsedValue
        End If

        Return True
    End Function

    ' Added By Vyankat B. on 03-07-2026 for Azure Email failure logging in common ATTACHMENTS/Log folder
    Private Shared Function GetAzureEmailFailureReason(ByVal ex As Exception) As String
        If ex Is Nothing Then
            Return "Unknown error"
        End If

        Dim message As String = If(ex.Message, "Unknown error")
        Const graphPrefix As String = "Graph API error:"

        If message.IndexOf(graphPrefix, StringComparison.OrdinalIgnoreCase) >= 0 Then
            Dim jsonPart As String = message.Substring(message.IndexOf(graphPrefix, StringComparison.OrdinalIgnoreCase) + graphPrefix.Length).Trim()
            Try
                Dim errObj = Newtonsoft.Json.Linq.JObject.Parse(jsonPart)
                If errObj("error") IsNot Nothing Then
                    Dim code As String = If(errObj("error")("code")?.ToString(), "")
                    Dim graphMessage As String = If(errObj("error")("message")?.ToString(), jsonPart)
                    If String.IsNullOrWhiteSpace(code) Then
                        Return graphMessage
                    End If
                    Return code & " - " & graphMessage
                End If
            Catch
                Return jsonPart
            End Try
        End If

        If ex.InnerException IsNot Nothing AndAlso Not String.IsNullOrWhiteSpace(ex.InnerException.Message) Then
            Return message & " | " & ex.InnerException.Message
        End If

        Return message
    End Function

    Private Shared Sub WriteAzureEmailFailureLog(ByVal source As String, ByVal ex As Exception,
        Optional ByVal toEmail As String = "", Optional ByVal ccEmail As String = "", Optional ByVal fromEmail As String = "", Optional ByVal subject As String = "")
        Try
            Dim logFolder As String = IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "ATTACHMENTS", "Log")
            If Not IO.Directory.Exists(logFolder) Then
                IO.Directory.CreateDirectory(logFolder)
            End If

            Dim logFile As String = IO.Path.Combine(logFolder, "AzureEmailLog_" & DateTime.Now.ToString("yyyyMMdd") & ".txt")

            Using sw As New IO.StreamWriter(logFile, True)
                sw.WriteLine("--------------------------------------------------")
                sw.WriteLine("Time   : " & DateTime.Now.ToString("dd-MMM-yyyy hh:mm:ss tt"))
                sw.WriteLine("Source : " & source)
                sw.WriteLine("To     : " & toEmail)
                sw.WriteLine("CC     : " & ccEmail)
                sw.WriteLine("From   : " & fromEmail)
                sw.WriteLine("Subject: " & subject)
                sw.WriteLine("Reason : " & GetAzureEmailFailureReason(ex))
                sw.WriteLine("--------------------------------------------------")
            End Using
        Catch
        End Try
    End Sub
    ' End of Added By Vyankat B. on 03-07-2026 for Azure Email failure logging in common ATTACHMENTS/Log folder

    Public Shared Function GetAccessToken() As String
        ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12

        Dim tokenEndpoint As String = "https://login.microsoftonline.com/" &
                tenantId &
                "/oauth2/v2.0/token"

        Dim postData As String =
                "client_id=" & clientId &
                "&scope=https%3A%2F%2Fgraph.microsoft.com%2F.default" &
                "&client_secret=" & Uri.EscapeDataString(clientSecret) &
                "&grant_type=client_credentials"

        Dim request As HttpWebRequest = CType(WebRequest.Create(tokenEndpoint), HttpWebRequest)

        request.Method = "POST"
        request.ContentType =
            "application/x-www-form-urlencoded"

        Dim bytes As Byte() = Encoding.UTF8.GetBytes(postData)
        request.ContentLength = bytes.Length

        Using stream = request.GetRequestStream()
            stream.Write(bytes, 0, bytes.Length)
        End Using

        Dim response As HttpWebResponse = CType(request.GetResponse(), HttpWebResponse)
        Dim responseString As String

        Using reader As New StreamReader(response.GetResponseStream())
            responseString = reader.ReadToEnd()
        End Using

        Dim json = JObject.Parse(responseString)
        Return json("access_token").ToString()
    End Function
    'End of Added By Vyankat B. on 1st July 2026 for configurable SMTP / Azure Graph email delivery

    Public Shared Function SendEmailWithAttachment(ByVal strToEmailID As String, ByVal strCCEmailID As String, ByVal strFromEmailID As String, ByVal strSubject As String, ByVal strEmailBody As String, ByVal strAttachments As HttpFileCollection, ByVal strAttachmentlisteds() As String)
        '=====================================================================
        ' Procedure Name		:	SendEmailWithAttachment
        ' Parameters Passed		:	None
        ' Returns				:	none
        ' Parameters Affected	:	None
        ' Purpose				:	To draw all controls on the page for SendEmail page.
        ' Description			:	same as above
        ' Assumptions			:	None
        ' Dependencies			:	None
        ' Author				:	Dipali Vekhande
        ' Created				:	25th Oct 2017
        ' Revisions				:	
        '=====================================================================
        Dim Context As HttpContext = HttpContext.Current
        'Create the my message object
        Dim g_strSmtpServerPort As String
        Dim g_strSmtpServerIP As String
        Dim strFrom As String
        Dim isSSLEnabled As Boolean = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT IsSSLEnabled FROM tbl_PM_CompanyInformation", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), "0"), "0"), Boolean)
        Dim g_strSmtpServerUserId As String
        Dim g_strSmtpServerPW As String
        'Dim Mail As CommonFunction.MyMessage
        'Dim isWithCC As Boolean
        'Dim isWithBCC As Boolean
        'Dim successMessage As String
        Dim arrTemFile As String() = {""}
        Dim m_strFilePath As String = AppDomain.CurrentDomain.BaseDirectory
        m_strFilePath = m_strFilePath + "ATTACHMENTS\CRMSenEmailAttachment\"


        Dim strTempToEmailId As String = Trim(General.CheckIsNothing(strToEmailID))
        Dim strTempCCEmailID As String = Trim(General.CheckIsNothing(strCCEmailID))
        If strTempToEmailId <> "" Then
            strTempToEmailId = Replace(strTempToEmailId, ";", ",")
            If strTempToEmailId.Chars(strTempToEmailId.Length - 1) = ";" Or strTempToEmailId.Chars(strTempToEmailId.Length - 1) = "," Then
                strTempToEmailId = strTempToEmailId.Trim().Remove(strTempToEmailId.Length - 1)
            Else
                strTempToEmailId = strTempToEmailId
            End If
        End If

        Dim MyMessage As New System.Net.Mail.MailMessage(strFromEmailID, strTempToEmailId, strSubject, strEmailBody)

        ' Dim SmtpClient As New System.Net.Mail.SmtpClient
        Dim SmtpClient As New System.Net.Mail.SmtpClient(CommonFunctions.Application.SMTPServer, 587)

        Dim ICompanyInfo As IDataReader
        ICompanyInfo = CommonFunction.Data.GetDataReader("usp_SEL_Tbl_PM_CompanyInformation", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean))

        While ICompanyInfo.Read()
            g_strSmtpServerIP = CType(CommonFunction.General.CheckIsNothing(ICompanyInfo("SMTPServer"), ""), String)
            'strFrom = "swapnil.aswale@lifeline-sys.com"
            'g_strSmtpServerPort = "25"
            ' g_strSmtpServerPort = CType(CommonFunction.General.CheckIsNothing(ICompanyInfo("SMTPServerPort"), ""), String)
            'g_strSmtpServerUserId = "swapnil.aswale@lifeline-sys.com"
            g_strSmtpServerUserId = CType(CommonFunction.General.CheckIsNothing(ICompanyInfo("SMTPUserName"), ""), String)
            'g_strSmtpServerPW = "lenovo@1234"
            g_strSmtpServerPW = CType(CommonFunction.General.CheckIsNothing(ICompanyInfo("SMTPPassword"), ""), String)
        End While

        'g_strSmtpServerIP = "smtp.lifeline-sys.com"
        'g_strSmtpServerIP = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT smtpServer from tbl_PM_CompanyInformation", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)
        ''strFrom = "swapnil.aswale@lifeline-sys.com"
        ''g_strSmtpServerPort = "25"
        'g_strSmtpServerPort = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT smtpServerPort from tbl_PM_CompanyInformation", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), ""), String)
        ''g_strSmtpServerUserId = "swapnil.aswale@lifeline-sys.com"
        'g_strSmtpServerUserId = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT smtpUserName from tbl_PM_CompanyInformation", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
        ''g_strSmtpServerPW = "lenovo@1234"
        'g_strSmtpServerPW = CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT smtpPAssword from tbl_PM_CompanyInformation", CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "")
        If g_strSmtpServerPW <> "" Then
            g_strSmtpServerPW = CommonFunction.General.DecryptString(g_strSmtpServerPW)
        End If

        Dim basicCredential As System.Net.NetworkCredential = New Net.NetworkCredential(g_strSmtpServerUserId, g_strSmtpServerPW)

        SmtpClient.EnableSsl = True
        SmtpClient.UseDefaultCredentials = True
        SmtpClient.Credentials = basicCredential


        If strTempCCEmailID <> "" Then
            strTempCCEmailID = Replace(strCCEmailID, ";", ",")
            If strTempCCEmailID.Chars(strTempCCEmailID.Length - 1) = ";" Or strTempCCEmailID.Chars(strTempCCEmailID.Length - 1) = "," Then
                strTempCCEmailID = strTempCCEmailID.Trim().Remove(strTempCCEmailID.Length - 1)
            Else
                strTempCCEmailID = strTempCCEmailID
            End If
            MyMessage.CC.Add(strTempCCEmailID)
        End If

        'Added by Dipali V 26th Oct 2017 For Attachfile During Sending mail
        If strAttachments.Count > 0 Then

            If Not strAttachments Is Nothing Then
                Dim strFilePath As Stream
                'Dim intLastIndex As Integer = strAttachments.Length - 1
                Dim intIndex As HttpPostedFile
                Dim fi As FileInfo
                Dim strTempFileName As String
                Dim FileExt As String
                Dim Position As Integer

                arrTemFile = New String(1) {}
                'For Each intIndex As HttpPostedFile In strAttachments.Item
                For i As Integer = 0 To strAttachments.Count - 1
                    intIndex = DirectCast(strAttachments(i), HttpPostedFile)
                    strFilePath = DirectCast(intIndex.InputStream, Stream)
                    ''COmmneted BY Nikhil A on 24-Nov-2021 for Sending Mail Over Attachment
                    'If strFilePath.Length <> 0 Then
                    '    MyMessage.Attachments.Add(New System.Net.Mail.Attachment(strFilePath, intIndex.FileName))
                    'End If
                    ''End Of COmmneted BY Nikhil A on 24-Nov-2021 for Sending Mail Over Attachment
                    '--------------------------------

                    ''Added By Nikhil A on 24-Nov-2021 for Sending Mail Over Attachment
                    If strFilePath.Length <> 0 Then

                        Position = intIndex.FileName.IndexOf(".")
                        FileExt = intIndex.FileName.Substring(Position)
                        strTempFileName = CommonFunction.FileDirectory.GetUniqueFileName()
                        strAttachments(i).SaveAs(m_strFilePath + "\" + strTempFileName + FileExt)
                        If System.IO.File.Exists(m_strFilePath + "\" + strTempFileName + FileExt) Then
                            MyMessage.Attachments.Add(New System.Net.Mail.Attachment(m_strFilePath + "\" + strTempFileName + FileExt))
                        End If
                        arrTemFile(i) = strTempFileName + FileExt
                        ReDim Preserve arrTemFile(i + 1)
                    End If



                    ''End Of Added By Nikhil A on 24-Nov-2021 for Sending Mail Over Attachment

                    '--------------------------------




                Next
            End If


        End If

        'End of Added by Dipali V 26th Oct 2017 For Attachfile During Sending mail

        'Added by Dipali V 26th Oct 2017 For Already Attach file
        If strAttachmentlisteds.Length > 0 Then
            If Not strAttachmentlisteds Is Nothing Then
                Dim strFilePath1 As String
                Dim intLastIndex As Integer = strAttachmentlisteds.Length - 1
                Dim intIndex As Integer
                For intIndex = 0 To intLastIndex
                    If Not strAttachmentlisteds(intIndex) Is Nothing Then
                        strFilePath1 = strAttachmentlisteds(intIndex).Trim
                        If System.IO.File.Exists(strFilePath1) Then
                            If strFilePath1 <> "" Then MyMessage.Attachments.Add(New System.Net.Mail.Attachment(strFilePath1))
                        Else
                            'the file doesn't exist
                        End If

                    End If

                Next
            End If

        End If
        'End of Added by Dipali V 26th Oct 2017 For Already Attach file


        MyMessage.BodyEncoding = System.Text.Encoding.UTF8
        MyMessage.IsBodyHtml = True
        If CommonFunctions.Application.EmailFormat = "HTML" Then
            MyMessage.IsBodyHtml = True
        Else
            MyMessage.IsBodyHtml = False
        End If

        'Check the applicatin variable smtp server
        If Not CommonFunctions.Application.SMTPServer Is Nothing Then
            SmtpClient.Host = CommonFunctions.Application.SMTPServer
        Else
            SmtpClient.Host = "localhost"
        End If



        Try
            'Added By Vyankat B. on 1st July 2026 for configurable SMTP / Azure Graph email delivery
            Dim useSmtpEmail As Boolean = True
            Try
                useSmtpEmail = IsSMTPEnabled()
            Catch ex As Exception
                Throw
            End Try

            If useSmtpEmail Then
                SmtpClient.UseDefaultCredentials = False
                SmtpClient.Credentials = New Net.NetworkCredential(g_strSmtpServerUserId.ToString, g_strSmtpServerPW.ToString)
                SmtpClient.Port = CInt(CommonFunctions.Application.SMTPServerPort)
                SmtpClient.EnableSsl = True
                'SmtpClient.Host = g_strSmtpServerIP.ToString()
                SmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network
                SmtpClient.Send(MyMessage)
            Else
                Try
                    ' Added By Vyankat B. on 1st July 2026 - build Graph sendMail URL from request From email
                    Dim senderMailbox As String = strFromEmailID.Trim()
                    If String.IsNullOrWhiteSpace(senderMailbox) Then
                        Throw New Exception("From email address is required for Azure Graph email delivery.")
                    End If
                    Dim sendMailApi As String = UserAPI.TrimEnd("/"c) & "/" & senderMailbox & "/sendMail"
                    ' End of Added By Vyankat B. on 1st July 2026 - build Graph sendMail URL from request From email

                    Dim toRecipients =
                            strTempToEmailId.Split(","c).
                            Where(Function(e) Not String.IsNullOrWhiteSpace(e)).
                            Select(Function(email) New With {
                                .emailAddress = New With {
                                    .address = email.Trim()
                                }
                            }).ToArray()

                    Dim ccRecipients =
                            If(String.IsNullOrWhiteSpace(strTempCCEmailID),
                               Nothing,
                               strTempCCEmailID.Split(","c).
                               Where(Function(e) Not String.IsNullOrWhiteSpace(e)).
                               Select(Function(email) New With {
                                   .emailAddress = New With {
                                       .address = email.Trim()
                                   }
                               }).ToArray())

                    Dim attachmentsList As New List(Of Object)

                    For i As Integer = 0 To arrTemFile.Length - 1
                        If String.IsNullOrWhiteSpace(arrTemFile(i)) Then Continue For
                        Dim filePath = IO.Path.Combine(m_strFilePath, arrTemFile(i))
                        If IO.File.Exists(filePath) Then
                            Dim bytes = IO.File.ReadAllBytes(filePath)
                            Dim attachment As New Dictionary(Of String, Object) From {
                                {"@odata.type", "#microsoft.graph.fileAttachment"},
                                {"name", arrTemFile(i)},
                                {"contentBytes", Convert.ToBase64String(bytes)}
                            }
                            attachmentsList.Add(attachment)
                        End If
                    Next

                    If strAttachmentlisteds IsNot Nothing Then
                        For Each filePathExisting As String In strAttachmentlisteds
                            If String.IsNullOrWhiteSpace(filePathExisting) Then Continue For
                            If IO.File.Exists(filePathExisting) Then
                                Dim bytes = IO.File.ReadAllBytes(filePathExisting)
                                Dim attachmentExisting As New Dictionary(Of String, Object) From {
                                    {"@odata.type", "#microsoft.graph.fileAttachment"},
                                    {"name", IO.Path.GetFileName(filePathExisting)},
                                    {"contentBytes", Convert.ToBase64String(bytes)}
                                }
                                attachmentsList.Add(attachmentExisting)
                            End If
                        Next
                    End If

                    Dim token As String = GetAccessToken()
                    Dim emailContentType As String = "TEXT"
                    If CommonFunctions.Application.EmailFormat = "HTML" Then
                        emailContentType = "HTML"
                    End If

                    Dim mailData = New With {
                        .message = New With {
                            .subject = strSubject,
                            .body = New With {
                                .contentType = emailContentType,
                                .content = strEmailBody
                            },
                            .toRecipients = toRecipients,
                            .ccRecipients = ccRecipients,
                            .attachments = attachmentsList
                        },
                        .saveToSentItems = True
                    }

                    Dim mailJson = JsonConvert.SerializeObject(mailData)
                    Using client As New HttpClient()
                        client.DefaultRequestHeaders.Authorization =
                            New Headers.AuthenticationHeaderValue("Bearer", token)

                        Dim content = New StringContent(mailJson, Encoding.UTF8, "application/json")
                        Dim response = client.PostAsync(sendMailApi, content).Result
                        If Not response.IsSuccessStatusCode Then
                            Dim err = response.Content.ReadAsStringAsync().Result
                            Throw New Exception(err)
                        End If
                    End Using
                Catch ex As Exception
                    WriteAzureEmailFailureLog("CRMSendEmail.SendEmailWithAttachment", ex, strToEmailID, strCCEmailID, strFromEmailID, strSubject)
                    Throw
                End Try
            End If
            'End of Added By Vyankat B. on 1st July 2026 for configurable SMTP / Azure Graph email delivery
            ''SmtpClient.Send(MyMessage)
            '''Else
            '''    With Mail
            '''        .ToEmailID = strToEmailID
            '''        .CCEmailID = strCCEmailID ''SendEmailWithCC
            '''        .BCCEmailID = String.Empty
            '''        .FromEmailID = strFromEmailID
            '''        .Subject = strSubject
            '''        .EmailBody = strEmailBody
            '''        If CommonFunction.Application.EmailFormat = "HTML" Then
            '''            .IsBodyHtml = True
            '''        Else
            '''            .IsBodyHtml = False
            '''        End If
            '''        .SMTPServer = CommonFunctions.Application.SMTPServer
            '''        .Port = CInt(CommonFunctions.Application.SMTPServerPort)
            '''        .IsSSLEnabled = isSSLEnabled
            '''        .UseName = CommonFunction.Application.SMTPUserName
            '''        .Password = CommonFunction.Application.SMTPPassword
            '''        .SMTPDomainName = CommonFunction.Application.SMTPDomainName
            '''    End With
            '''    isWithCC = True ''SendEmailWithCC
            '''    isWithBCC = False
            '''    successMessage = String.Empty
            '''    'CommonFunction.Emails.SendEmailSSLCompatible(Mail, isWithCC, isWithBCC, successMessage)


            '''End If

            ''''---Added By Nikhil A on 24-Nov-2021 for Attachment over TLS mail Send
            '''Try
            '''    Dim oMail As EASendMail.SmtpMail = New EASendMail.SmtpMail("TryIt")
            '''    oMail.From = strFromEmailID
            '''    oMail.[To] = strToEmailID
            '''    oMail.Cc = strCCEmailID
            '''    oMail.Subject = strSubject
            '''    oMail.TextBody = strEmailBody
            '''    If strAttachments.Count > 0 Then

            '''        If Not strAttachments Is Nothing Then

            '''            For i As Integer = 0 To arrTemFile.Length - 1
            '''                If System.IO.File.Exists(m_strFilePath + "\" + arrTemFile(i)) Then
            '''                    oMail.AddAttachment(m_strFilePath + "\" + arrTemFile(i))
            '''                End If
            '''            Next
            '''        End If
            '''        If strAttachmentlisteds.Length > 0 Then
            '''            If Not strAttachmentlisteds Is Nothing Then
            '''                Dim strFilePath1 As String
            '''                Dim intLastIndex As Integer = strAttachmentlisteds.Length - 1
            '''                Dim intIndex As Integer
            '''                For intIndex = 0 To intLastIndex
            '''                    If Not strAttachmentlisteds(intIndex) Is Nothing Then
            '''                        strFilePath1 = strAttachmentlisteds(intIndex).Trim
            '''                        If System.IO.File.Exists(strFilePath1) Then
            '''                            If strFilePath1 <> "" Then oMail.AddAttachment(strFilePath1)
            '''                        Else
            '''                            'the file doesn't exist
            '''                        End If

            '''                    End If

            '''                Next
            '''            End If

            '''        End If

            '''    End If
            '''    Dim oServer As SmtpServer = New SmtpServer(CommonFunctions.Application.SMTPServer)
            '''    oServer.User = CommonFunction.Application.SMTPUserName
            '''    oServer.Password = CommonFunction.Application.SMTPPassword
            '''    oServer.Port = CommonFunctions.Application.SMTPServerPort
            '''    oServer.ConnectType = SmtpConnectType.ConnectSSLAuto
            '''    Dim oSmtp As EASendMail.SmtpClient = New EASendMail.SmtpClient()
            '''    oSmtp.SendMail(oServer, oMail)
            'Catch ex As Exception
            '        Console.WriteLine(ex.Message)
            '    Throw ex
            'End Try
            '----------------------End Of Added By Nikhil A ----------------
            'SmtpClient.UseDefaultCredentials = False
            'SmtpClient.Credentials = New Net.NetworkCredential(g_strSmtpServerUserId.ToString, g_strSmtpServerPW.ToString)
            'SmtpClient.Port = g_strSmtpServerPort
            'SmtpClient.EnableSsl = isSSLEnabled
            'SmtpClient.Host = g_strSmtpServerIP.ToString()
            'SmtpClient.DeliveryMethod = SmtpDeliveryMethod.Network
            'SmtpClient.Send(MyMessage)
        Catch ex As Exception
            'Added By UmeshJ Aug 06, 2007; Log the Error
            ''Dim args As CommonFunctions.Emails.Email_ErrorInfo
            ''With args
            ''    .SMTPServer = CommonFunctions.General.CheckIsNothing(CommonFunctions.Application.SMTPServer)
            ''    .SMTPServer_InstallationType = ""
            ''    .SMTPServerPort = CommonFunctions.General.CheckIsNothing(CommonFunctions.Application.SMTPServerPort)
            ''End With
            'Call LogError(ex)
            ''args = Nothing
            '''End of Addition
            ''Context.Session("Mail_strToEmailID") = strToEmailID
            ''Context.Session("Mail_strSubject") = strSubject
            ''Context.Session("Mail_strEmailMessage") = strEmailBody
            Throw
        Finally
            MyMessage = Nothing
            SmtpClient = Nothing
        End Try

    End Function

    Private Sub PerformFurtherActions(ByVal MessageID As Long, ByVal Parameter As String)
        Select Case MessageID

            Case 56
                Dim strSQLQuery As String
                'If mail is sent successfully then only update the field
                'Update the IsPDFSent field
                If m_strMode = CONST_MODE_SUCCESS Then
                    strSQLQuery = "usp_upd_tbl_pm_rfiinvoices " & Parameter
                    CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                End If
            Case 57 '
                Dim strSQLQuery As String
                'If mail is sent successfully then only update the field
                'Update the IsPDFSent field
                Dim arrInvoiceIDs() As String
                Dim strSep As String = ","
                Dim chrSep() As Char = strSep.ToCharArray
                Dim intCount As Integer
                If m_strMode = CONST_MODE_SUCCESS Then
                    If Parameter <> "" Then
                        arrInvoiceIDs = Parameter.Split(chrSep)
                    End If
                    If Not IsNothing(arrInvoiceIDs) Then
                        For intCount = 0 To arrInvoiceIDs.Length - 1
                            strSQLQuery = "usp_upd_tbl_pm_rfiinvoices " & arrInvoiceIDs(intCount)
                            CommonFunction.Data.InsertOrUpdateData(strSQLQuery, MyBase.UseSQL)
                        Next
                    End If
                End If
            Case Else
        End Select
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
                'Case 443
                '    CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(m_strFromEmailID, m_strToEmailID, m_strSubject, m_strMessage, m_strLoginName, m_StrPassword)
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
                'Added By Chakshuta H on 7th-Dec-2017 Purpose::Mail on login creation
            Case 20032
                CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, HttpContext.Current.Session("intUserid"), HttpContext.Current.Session("LoginType"), Request.QueryString("LoginName").ToString, Request.QueryString("Password").ToString)
                'End of Added By Chakshuta H on 7th-Dec-2017 Purpose::Mail on login creation
            Case 443
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_443(m_strFromEmailID, m_strToEmailID, m_strSubject, m_strMessage, Request.QueryString("LoginName").ToString, Request.QueryString("Password").ToString)

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