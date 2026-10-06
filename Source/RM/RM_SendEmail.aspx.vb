Imports CommonFunctions

Public Class RM_SendEmail
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
    Private m_strMsgID As String
    Private m_strInstanceID, m_strProcessID, m_strNextStageID, m_strCurrentStageID, m_strPrimaryKeyValue As String
    'End of Addition By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1

    'Added by MrugajaB for WhizibleSEM SP7
    'Code Added By PradipK on 8-June-2006
    'Purpose:To Check ShowToCustomer condition from Discussion Thread(DT) table if Mail is from DT.
    Private strFrom As String = ""
    'End Addtion By PradipK on 8-June-2006
    'End Addition

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
        ' Added and Commented By Sanyogeeta on 10-10-2016  For Sql Injection, Cross Scripting
        ' MyBase.ApplySecurity()

        MyBase.ApplySecurity(True)
        ' End Added and Commented By Sanyogeeta on 10-10-2016 For Sql Injection, Cross Scripting
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
                    Call getEmailDetails(m_lngMessageID)
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
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtFromEmailID", "txtFromEmailID", , 450, , m_strFromEmailID + "".Trim, , , True, Not blnShowFrom, , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:06/10/15
        'End Of Modification by PrajaktaR for TAVANT 
        'End of modification by ShubhadaL for SP4 Integration on 28 Oct 2005
        General.WriteHTML("</TR>")

        'display the TO mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_TO") + "&nbsp;</TD>")
        If m_lngMessageID <> 23 Then
            'Commented and added by Yogesh J for HTML encoding Date:06/10/15
            General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        Else
            General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , True, , , , True, True, EnableHTMLEncode:=True) + "</TD>")
            'ended by Yogesh J for HTML encoding Date:06/10/15
        End If
        General.WriteHTML("</TR>")

        'display CC mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_CC") + "&nbsp;</TD>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtCCToEmailID", "txtCCToEmailID", , 450, , m_strCCEmailID + "".Trim, , , , , , , , True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("</TR>")

        'display the subject
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_SUBJECT") + "&nbsp;</TD>")
        'Commented and added by Yogesh J for HTML encoding Date:06/10/15
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtSubject", "txtSubject", , 450, , m_strSubject + "".Trim, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        'ended by Yogesh J for HTML encoding Date:06/10/15
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
        Dim I As Integer = HttpContext.Current.Request.Url.ToString.IndexOf("Source")

        strMsg = HttpContext.Current.Request.Url.ToString.Substring(0, I - 1) + "/Default.aspx"
        'General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim, , , , , , , , True, True) + "</TD>")
        General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmSendEmail", , , 450, 230, , m_strMessage + "".Trim + Chr(13) + Chr(10) + Chr(10) + Chr(10) + "Site Details - " + strMsg, , , , , , , , True, True) + "</TD>")
        General.WriteHTML("</TR>")
        'End of addition by MonikaI
        '---------------------------------------------------------------------------------------------------------------

        General.WriteHTML("</Table>")

        'Code added by MrugajaB on 12th Dec 2005
        'Purpose: Implementation of communication feature
        m_strToEmailID = CommonFunctions.General.BuildQueryString(m_strToEmailID)
        m_strCCEmailID = CommonFunctions.General.BuildQueryString(m_strCCEmailID)
        m_strFromEmailID = CommonFunctions.General.BuildQueryString(m_strFromEmailID)
        m_strSubject = CommonFunctions.General.BuildQueryString(m_strSubject)
        m_strMessage = CommonFunctions.General.BuildQueryString(m_strMessage)
        CommonFunction.Data.InsertOrUpdateData("Exec usp_Ins_tbl_CDB_Communication '" & m_strToEmailID & "','" & m_strCCEmailID & "','" & m_strFromEmailID & "','" & m_strSubject & "','" & m_strMessage & "'", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        'End Addition

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

        'Added by MonikaI on 7th Sep 2006 For WhizibleSEM SP7
        'Issue ID: 5342
        'Purpose : To display the Site address in the text message of SendEmail page.
        Dim objDRCompany As IDataReader
        Dim strSQLCompany As String
        Dim arrMsg() As String

        'Commented and added by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        'strSQLCompany = "SELECT EmailFormat FROM tbl_PM_CompanyInformation"
        strSQLCompany = "usp_sel_tbl_PM_CompanyInformation_EmailFormat"
        'End of addition by Yogesh Jalamkar on 05-Aug-2016 To Remove Inline Query
        objDRCompany = Data.GetDataReader(strSQLCompany, MyBase.UseSQL)
        If objDRCompany.Read Then
            If objDRCompany("EmailFormat").ToString = "TEXT" Then
                strMessage = MyBase.GetFormValue("txtMessage", False) + ""
            Else
                strMessage = MyBase.GetFormValue("txtMessage", False) + ""
                arrMsg = Split(strMessage, "Site Details - ")
                If arrMsg.Length > 1 Then
                    strMessage = arrMsg(0) + "Site Details - <a href = '" + arrMsg(1) + "'>" + arrMsg(1) + "</a>"
                End If
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

        Try
            'send the mail
            CommonFunction.Emails.SendEmailWithCC(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage)

            'mail has beed sent successfully
            m_strMode = CONST_MODE_SUCCESS

        Catch ex As Exception

            'if error occured during mail sent
            m_strMode = CONST_MODE_ERROR

        End Try

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
    Private Sub getEmailDetails(ByVal lngMessageID As Long)

        'Added By VidyaJ - IssueID - 672 - Whiz2.0 Integration
        'Added By NileshD on 9 Dec 2005 for ReqID WAF3_WF_1
        If Request.QueryString("workflow") <> "" Then
            'Select Case UCase(m_strMsgID)
            '    'Submit
            'Case "70478A07-EF57-492B-9AB4-CC31F50783AB"
            '        Call WorkFlows.CommonEmails.SubmitMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strPrimaryKeyValue)
            '        'Approve
            '    Case "37E64B21-ACE3-48A9-A9F2-73A31B944987"
            '        Call WorkFlows.CommonEmails.ApproveMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strCurrentStageID, m_strPrimaryKeyValue)
            '        'Reject
            '    Case "559B9008-00BC-4C95-99F5-5AD4F5CE66FD"
            '        Call WorkFlows.CommonEmails.RejectMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strCurrentStageID, m_strPrimaryKeyValue)
            '        'ReSubmit
            '    Case "A8697C62-BCF9-46BC-ADD7-A6799179315A"
            '        Call WorkFlows.CommonEmails.ReSubmitMail(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, m_strInstanceID, m_strProcessID, m_strNextStageID, m_strPrimaryKeyValue)
            'End Select
            Exit Sub
        End If



        Select Case lngMessageID
           
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

                RM_CommonFunction.EmailMessages.RMMessages.GetEmailMessage_475(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Approver)
            Case 477
                RM_CommonFunction.EmailMessages.RMMessages.GetEmailMessage_477(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ProjectDocumentRefTypeId").ToString, Long))
            Case 479
                Dim ProjectId As Integer
                ' Dim CC As String
                Dim strProjectName As String
                Dim intProjectRequirementId As Integer

                intProjectRequirementId = CType(Request.QueryString("ProjectRequirementId"), Integer)
                ProjectId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)
                RM_CommonFunction.EmailMessages.RMMessages.GetEmailMessage_479(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)
            Case 480
                Dim ProjectId As Integer
                ' Dim CC As String
                Dim strProjectName As String
                Dim intProjectRequirementId As Integer

                intProjectRequirementId = CType(Request.QueryString("ProjectRequirementId"), Integer)
                ProjectId = CType(CommonFunction.General.CheckIsNothing(Request.QueryString("ProjectID"), "0"), Integer)
                RM_CommonFunction.EmailMessages.RMMessages.GetEmailMessage_480(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage)

            Case 3002
                RM_CommonFunction.EmailMessages.RMMessages.GetEmailMessage_3002(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("ProjectReqTRDocumentID"), Long))
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

    Private Sub Page_CommitTransaction(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.CommitTransaction
        Dim StrSql As String

    End Sub

    Private Sub Page_PreRender(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.PreRender

    End Sub


End Class
