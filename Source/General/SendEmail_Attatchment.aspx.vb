Imports CommonFunctions
Imports System.Net.Mail
Imports System.IO
Public Class SendEmail_Attatchment
    Inherits WebPages.Template.WhizTemplate

#Region "Member Variables"
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
    Private m_strAttatchments() As String
    Private m_strHrefForAttachs() As String
    Private m_strFilePath As String
    Private m_strFileNames() As String
    Private m_strFile As String
    Private m_strParameter As String = ""
    Private m_strHrefForAttatch As String
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
    Private m_strSeperator As String = ","
    Private m_charSep() As Char = m_strSeperator.ToCharArray
    'RFI Related Variables
    Protected m_strInvoiceID As String
    Private m_lngCusotmerID As Long
    Private m_lngCompanyID As Long
#End Region

#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Init
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub

#End Region
    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.SendEmail", "AppResources")
    End Sub

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'set the window title 
        m_strWindowTitle = MyBase.GetResourceString("WINDOW_TITLE_EMAIL")
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
        'Using writer As StreamWriter =
        'New StreamWriter("D:\\myfile.txt")

        '    writer.Write("One ")
        '    writer.WriteLine("two 2")
        '    writer.WriteLine("Three")
        'End Using

        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String
        Dim objHeader As WebPage.Templates.HeaderFooter

        m_strMode = Request.QueryString("Mode") + ""
        If m_strMode = "" Then m_strMode = CONST_MAIL
        If Request.QueryString("MessageID") <> "" Then
            m_lngMessageID = CType(Request.QueryString("MessageID"), Long)
        End If
        If Request.QueryString("IssueID") <> "" Then
            m_lngIssueID = CType(Request.QueryString("IssueID"), Long)
        End If
        ' Added By Rajanikant
        If Request.QueryString("QueryID") <> "" Then
            m_lngQueryID = CType(Request.QueryString("QueryID"), Long)
        End If
        ' End Addition
        If Request.QueryString("OldReviewDate") <> "" Then
            m_strOldReviewDate = CType(Request.QueryString("OldReviewDate"), Date)
        End If
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
            If m_lngMessageID <> 57 Then
                m_lngInvoiceId = CType(Request.QueryString("InvoiceID"), Long)
                m_strParameter = m_lngInvoiceId.ToString
            Else
                m_strInvoiceID = Request.QueryString("InvoiceID")
                m_strParameter = m_strInvoiceID
                m_lngCusotmerID = CType(Request.QueryString("CustomerID"), Long)
                m_lngCompanyID = CType(Request.QueryString("CompanyID"), Long)
            End If
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
        General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtFromEmailID", "txtFromEmailID", , 450, , m_strFromEmailID + "".Trim, , , , Not blnShowFrom, , , , True, True) + "</TD>")
        General.WriteHTML("</TR>")

        'display the TO mail id textbox
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_TO") + "&nbsp;</TD>")
        If m_lngMessageID <> 23 Then
            General.WriteHTML("<TD align='left' >" + HTMLControls.DrawTextBox("txtToEmailID", "txtToEmailID", , 450, , m_strToEmailID + "".Trim, , , , , , , , True, True) + "</TD>")
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

        'display the attathment section
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("CAP_ATTATCHMENT") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='left' >")
        Dim intCount As Integer

        While intCount < m_strAttatchments.Length - 1
            'General.WriteHTML("<A onclick='" + "alert(""test"")" + "' TARGET=_NEW><FONT color=blue>" + m_strFileNames(intCount) + "</FONT>;</A>")
            'General.WriteHTML("<A onclick='" + "window.open('../RFI/Viewinvoice.aspx?FileName=" + m_strHrefForAttachs(intCount).Trim + "','pp','MENUBAR=no,TITLEBAR=yes,TOOLBAR=no,RESIZABLE=yes'); " + "' TARGET=_NEW><FONT color=blue>" + m_strFileNames(intCount) + "</FONT>;</A>")
            'General.WriteHTML("<A HREF='" + "../RFI/RFI_Viewinvoice.aspx?FileName=" + m_strHrefForAttachs(intCount).Trim + "','pp','MENUBAR=no,TITLEBAR=yes,TOOLBAR=no,RESIZABLE=yes';" + "' TARGET=_NEW><FONT color=blue>" + m_strFileNames(intCount) + "</FONT>;</A>")
            ''Commented And AddedBy Usha Pandit On 20.02.2021 For Object referrence error
            'General.WriteHTML("<A HREF=""" + "Javascript:OpenFile('" + m_strHrefForAttachs(intCount).Trim.Replace("'", "\'") + "');" + """><FONT color=blue>" + m_strFileNames(intCount) + "</FONT>;</A>")
            If Not m_strAttatchments(intCount) Is Nothing And Not m_strAttatchments(intCount) = "" Then
                General.WriteHTML("<A HREF=""" + "Javascript:OpenFile('" + m_strHrefForAttachs(intCount).Trim.Replace("'", "\'") + "');" + """><FONT color=blue>" + m_strFileNames(intCount) + "</FONT>;</A>")
            End If
            ''End Of Added By Usha Pandit On 20.02.2021 For Object referrence error
            intCount += 1
        End While

        General.WriteHTML("</TD>")
        General.WriteHTML("</TR>")

        'display the note
        General.WriteHTML("<TR class='clsTREven' >")
        General.WriteHTML("<TD align='right' >" + MyBase.GetResourceString("NOTE") + " :</TD>")
        General.WriteHTML("<TD align='left' >" + MyBase.GetResourceString("EMAIL_NOTE") + "</TD>")
        General.WriteHTML("</TR>")

        'display the message
        General.WriteHTML("<TR class='clsTREven' >")

        ''Commented and Added by Usha Pandit on 12.06.2019 for Message label alignment issue
        'General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_MESSAGE") + "&nbsp;</TD>")
        General.WriteHTML("<TD align='right' valign='top' style='vertical-align: top !important;' >" + MyBase.GetResourceString("CAP_MESSAGE") + "&nbsp;</TD>")
        'End of Added by Usha Pandit on 12.06.2019 for Message label alignment issue
        General.WriteHTML("<TD align='left' valign='top'>" + HTMLControls.DrawTextArea("txtMessage", "txtMessage", , , , "frmSendEmail_Attatchment", , , 450, 230, , m_strMessage + "".Trim, , , , , , , , True, True) + "</TD>")
        General.WriteHTML("</TR>")

        intCount = 0
        m_strFilePath = ""

        While intCount < m_strAttatchments.Length - 1
            m_strFilePath += m_strAttatchments(intCount) + ","
            intCount += 1
        End While
        'Remove the last ","
        If m_strFilePath <> "" Then
            m_strFilePath = Left(m_strFilePath, m_strFilePath.Length - 1)
        End If

        intCount = 0
        m_strFile = ""

        While intCount < m_strFileNames.Length - 1
            m_strFile += m_strFileNames(intCount) + ","
            intCount += 1
        End While
        'Remove the last ","
        If m_strFile <> "" Then
            m_strFile = Left(m_strFile, m_strFile.Length - 1)
        End If

        intCount = 0
        m_strHrefForAttatch = ""
        While intCount < m_strHrefForAttachs.Length - 1
            m_strHrefForAttatch += m_strHrefForAttachs(intCount) + ","
            intCount += 1
        End While
        'Remove the last ","
        If m_strHrefForAttatch <> "" Then
            m_strHrefForAttatch = Left(m_strHrefForAttatch, m_strHrefForAttatch.Length - 1)
        End If


        General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFilePath", "txtFilePath", , , , m_strFilePath, , , , , , True, , True))
        General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFileHref", "txtFileHref", , , , m_strHrefForAttatch, , , , , , True, , True))
        General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtFileName", "txtFileName", , , , m_strFile, , , , , , True, , True))
        'Plot Hidden Control for the QueryString Value
        General.WriteHTML(CommonFunction.HTMLControls.DrawTextBox("txtParameter", "txtParameter", , , , m_strParameter, , , , , , True, , True))

        General.WriteHTML("</Table>")
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
            m_strAttatchments = m_strFilePath.Split(m_charSep)
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
            If m_strAttatchments.Length > 0 And Not (m_strAttatchments Is Nothing) Then
                '           Using writer As StreamWriter =
                'New StreamWriter("D:\\myfile.txt")


                '               writer.WriteLine("1212121121")
                '           End Using
                CommonFunction.Emails.SendEmailWithAttachment(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage, m_strAttatchments)
                ''SendEmailWithAttachment(strTOEmailID, strCCEmailID, strFromEmailID, strSubject, strMessage, m_strAttatchments)
                'mail has beed sent successfully
                m_strMode = CONST_MODE_SUCCESS
                PerformFurtherActions(lngMessageID, m_strParameter)
            End If



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

        Select Case lngMessageID
            'Added By DipaliS 10 Aug 2004
        Case 56
                'Get the Attatchment details
                Dim strInvoiceNumber As String
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_56(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, CType(Request.QueryString("INVOICEID"), Long), strInvoiceNumber)
                'ReDim m_strAttatchments(1)
                'ReDim m_strFileNames(1)
                'ReDim m_strHrefForAttachs(1)
                'm_strAttatchments(0) = Server.MapPath("../../Reports/" & strInvoiceNumber.Replace("/", "") & ".pdf")
                'm_strFileNames(0) = strInvoiceNumber
                'm_strHrefForAttachs(0) = strInvoiceNumber.Replace("/", "") & ".pdf"

                GenerateMultipleInvoices(Request.QueryString("INVOICEID"), m_strAttatchments, m_strFileNames, m_strHrefForAttachs)

                'End Addition By DipaliS
            Case 57
                Dim strInvoiceNumbers() As String
                CommonFunction.EmailMessages.RFIMessages.GetEmailMessage_57(m_strFromEmailID, m_strToEmailID, m_strCCEmailID, m_strSubject, m_strMessage, Request.QueryString("INVOICEID"), m_lngCusotmerID, m_lngCompanyID, strInvoiceNumbers)
                'ReDim m_strAttatchments(UBound(strInvoiceNumbers))
                'ReDim m_strFileNames(UBound(strInvoiceNumbers))
                'Dim intCount As Integer
                'For intCount = 0 To m_strFileNames.Length - 1
                'm_strAttatchments(intCount) = Server.MapPath("../../Reports/" & strInvoiceNumbers(intCount).Replace("/", "") & ".pdf")
                'm_strFileNames(intCount) = strInvoiceNumbers(intCount)
                'Next
                GenerateMultipleInvoices(Request.QueryString("INVOICEID"), m_strAttatchments, m_strFileNames, m_strHrefForAttachs)
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
    '====================================================================
    ' Procedure Name        :   PerformFurterActions
    ' Parameters Passed     :   MessageID
    ' Returns               :   None
    ' Parameters Affected   :   None
    ' Purpose               :   To perform action if any after the mail is successfully sent
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 23, 2004
    ' Revisions             :
    '=====================================================================
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
    '====================================================================
    ' Procedure Name        :   GenerateMultipleInvoices
    ' Parameters Passed     :   strInvoiceIDList	:- The comma separated list of Invoice IDs.
    '							strFilePath			:- The File Path.
    '							strFileName			:- The File Name.
    ' Returns               :   None 
    ' Parameters Affected   :   strFilePath, strFileName variables will be set.
    ' Purpose               :   To generate multiple invoices of the same customer
    ' Description           :   Same as above
    ' Assumptions           :   None
    ' Dependencies          :   None
    ' Author                :   DipaliS
    ' Created               :   August 25, 2004
    ' Revisions             :
    '=====================================================================
    Private Sub GenerateMultipleInvoices(ByVal strInvoiceIDList As String, ByRef strFilePath() As String, ByRef strFileName() As String, ByRef strHref() As String)
        Dim strSep As String = ","
        Dim chrSep() As Char = strSep.ToCharArray
        Dim arrTemp() As String
        Dim intCount As Integer
        If strInvoiceIDList <> "" Then
            arrTemp = strInvoiceIDList.Split(chrSep)
        End If

        If Not IsNothing(arrTemp) Then
            ReDim strFilePath(UBound(arrTemp) + 1)
            ReDim strFileName(UBound(arrTemp) + 1)
            ReDim strHref(UBound(arrTemp) + 1)
            For intCount = 0 To arrTemp.Length - 1
                GenerateInvoiceReport(CType(arrTemp(intCount), Integer), strFilePath(intCount), strFileName(intCount), strHref(intCount))
            Next
        End If

    End Sub
    Function GenerateInvoiceReport(ByVal intInvoiceID As Integer, ByRef strFilePath As String, ByRef strFileName As String, ByRef strHref As String) As Boolean
        '=====================================================================
        ' Procedure Name        :	GenerateInvoiceReport
        ' Purpose               :	To generate the invoice report.
        ' Description           :	Same as above.	
        ' Parameters Passed     :	intInvoiceID		:- Invoice ID.		
        '							strFilePath			:- The File Path.
        '							strFileName			:- The File Name.	
        ' Parameters Affected   :   strFilePath, strFileName variables will be set.
        ' Returns               :	True  :- If the .zip file was generated successfully.
        '							False :- If the .zip file was not generated successfully.
        ' Assumptions           :	None.
        ' Dependencies          :	Commonfunctions.asp
        ' Author                :	DipaliS
        ' Created               :	25 Aug 2004
        ' Revisions             :	
        '=====================================================================

        Dim strSQLQuery As String      ' The SQL Query.
        Dim blnRecordsFound As Boolean      ' Flag to check whether records exist for the report.

        Dim drInvoice As IDataReader     ' Recordset variable to retrieve the Invoice details.
        Dim strInvoiceNumber As String    ' The Invoice Number.

        Dim drReport As IDataReader      ' Recordset variable to retrieve the Invoice report details.
        Dim intInvoiceReportID As Integer    ' The Invoice Report ID.		
        Dim strSPName As String      ' The Stored Procedure Name. [This SP will be used to generate the invoice report.]
        Dim intFormatID As Integer     ' The Format ID for the report. [1->.pdf;  2->.htm; 3->.xls; 4->.rtf; 5->.csv; 6->.txt]



        Dim strFilePath_Local As String    ' The path of the file. [.PDF file of the invoice]
        Dim strFileName_Local As String    ' The name of the file.										

        'Dim objFileSystemObject   ' File System object for checking the existence of the report generated.		

        ' Initialize the return parameters. Only after the .pdf file is created successfully, these parameters will be set.
        strFilePath = ""
        strFileName = ""

        ' Get the invoice details.
        strSQLQuery = "Exec usp_Sel_tbl_PM_RFIInvoices " & intInvoiceID

        drInvoice = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drInvoice.Read Then
            strInvoiceNumber = Trim(CType(CommonFunction.Data.CheckIsDBNull(drInvoice("InvoiceNumber")), String) & "")
            intInvoiceReportID = CType(CommonFunction.Data.CheckIsDBNull(drInvoice("InvoiceReportID"), "0"), Integer)
            strFileName_Local = strInvoiceNumber
        End If

        CommonFunction.Data.DisposeDataReader(drInvoice)

        ' Get the report details.		
        strSQLQuery = "Exec usp_sel_tbl_CRW_Report_Master_ForRFI " & intInvoiceReportID

        'Remove the '/' from the Invoice Number for the name of Report
        strFileName_Local = strFileName_Local.Replace("/", "")

        'Aded by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3
        'Purpose: To avoid crash when filename having special character
        strFileName_Local = strFileName_Local.Replace("\", "")
        strFileName_Local = strFileName_Local.Replace("*", "")
        strFileName_Local = strFileName_Local.Replace("""", "")
        strFileName_Local = strFileName_Local.Replace("?", "")
        strFileName_Local = strFileName_Local.Replace("@", "")
        strFileName_Local = strFileName_Local.Replace("|", "")
        strFileName_Local = strFileName_Local.Replace("<", "")
        strFileName_Local = strFileName_Local.Replace(">", "")
        strFileName_Local = strFileName_Local.Replace(":", "")

        'End of Comment and addition by PrashantSJ on 5th June 2007 For WhizbieSEM 7.- Build 3

        drReport = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drReport.Read Then
            strSPName = Trim(CType(CommonFunction.Data.CheckIsDBNull(drReport("SpName")), String) & "")
        End If
        CommonFunction.Data.DisposeDataReader(drReport)

        ' PDF Format.
        intFormatID = 1

        ' Initialize the flag indicating whether records are present for the SP specified.
        blnRecordsFound = False

        ' Checking for existence of records before invoking the report.
        strSQLQuery = strSPName & " " & intInvoiceID

        drReport = CommonFunction.Data.GetDataReader(strSQLQuery, MyBase.UseSQL)

        If drReport.Read Then
            blnRecordsFound = True
        End If
        CommonFunction.Data.DisposeDataReader(drReport)

        ' If no records are found, exit the function.
        If blnRecordsFound = False Then
            Exit Function
        End If

        ' Get the file name to be used. [The Invoice Number will be used as the file name.]
        strFilePath_Local = "../../Reports/" & strFileName_Local & ".pdf"
        'strFilePath_Local = "../../Reports/" & CommonFunctions.FileDirectory.GetUniqueFileName(".pdf")

        ' Create the report object.
        Dim objReport As New AdHocReports.Report.AdHocReport(CInt(intInvoiceReportID), strSPName & " " & intInvoiceID, CommonFunctions.Application.ConnectionString, Server.MapPath(strFilePath_Local), CommonFunctions.FileDirectory.CleanPath(Server.MapPath("../../Attachments/Log/")))

        With objReport
            .UseMSSQL = MyBase.UseSQL
            .DefaultLCID = CType(MyBase.DefaultUILCID, Integer)
            .LCID = MyBase.CurrentThreadUICultureID
            If CommonFunctions.General.GetApplicationKeySetting("UseHashTableForCRW").Trim.ToUpper = "Y" Then
                .UseHashTables = True
            Else
                .UseHashTables = False
            End If
            .CompanyName = CommonFunctions.Application.CompanyName
            .DateFormat = CType(CommonFunctions.Application.DateFormatID, Integer)
        End With


        ' Generate the report in .PDF format. [FormatID for .PDF files = 1]
        If objReport.GenerateReport(AdHocReports.Format.PDF) = True Then

        End If

        objReport = Nothing

        ' Check for the existence of the file. If the file does not exist, then exit the function.

        Dim objFileSystemObject As CommonFunction.FileDirectory
        objFileSystemObject = New CommonFunction.FileDirectory
        If objFileSystemObject.IsFileExists(Server.MapPath(strFilePath_Local)) Then
            strFilePath = Server.MapPath(strFilePath_Local)
            strFileName = strInvoiceNumber
            strHref = strFileName_Local & ".pdf"
            Exit Function
        End If
        objFileSystemObject = Nothing

        Return True
    End Function
    
End Class
