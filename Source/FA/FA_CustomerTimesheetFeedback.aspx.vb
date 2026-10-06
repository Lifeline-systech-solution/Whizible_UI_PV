Public Class FA_CustomerTimesheetFeedback
    Inherits WebPages.Template.WhizTemplate

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

#Region " Constants Used in the Class "
    Private Const ACTION_DECLINE As String = "Decline"
    Private Const ACTION_AUTHENTICATE As String = "Authenticate"

    Private Enum MenuIndex
        SENDMAIL
        CLOSE
        HELP
    End Enum
    Private Const NUMBER_OF_MENUITEMS As Integer = 3
#End Region

#Region " Class scope Variables Declarations "    
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_lngTimesheetNo As Long = 0
    Private m_strAction As String = ""
    Private m_strComment As String = ""
    Private m_blnSendMail As Boolean = False
    Private m_blnShowPopup As Boolean = False
    'Email related Fields
    Protected m_intMessageId As Integer = 0
    Private m_strToEmailID As String = ""
    Private m_strCCToEmailID As String = ""
    Private m_strFromEmailID As String = ""
    Private m_strSubject As String = ""
    Private m_strEmailMessage As String = ""
#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strQuery As String = ""

        'Initiate the Menu items arrays. Used to plot the menu.
        InitPageMenu()

        m_lngTimesheetNo = CType(CommonFunctions.General.CheckIsNothing(Request.QueryString("TimeSheetNo"), "0"), Long)
        m_strAction = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("optAuthenticate"))
        m_strComment = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtareaAuthenticate"))
        m_strComment = CommonFunctions.General.UnBuildQueryString(m_strComment)

        If m_strAction = ACTION_AUTHENTICATE Then
            m_intMessageId = 4
            strQuery = "Exec usp_CustomerTimesheetUpdation 1, " & m_lngTimesheetNo.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strComment) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            GetEmailInformation()
        ElseIf m_strAction = ACTION_DECLINE Then
            m_intMessageId = 5
            strQuery = "Exec usp_CustomerTimesheetUpdation 0, " & m_lngTimesheetNo.ToString()
            strQuery &= ", '" & CommonFunctions.General.BuildQueryString(m_strComment) & "'"
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            GetEmailInformation()
        End If
    End Sub

    Public Sub New()
        'Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        'MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        'End of Commented and Added By Bharat Tekade on 10th-Oct-2016 For SSO and SQL Injection
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    End Sub

    Protected Overrides Sub Finalize()
        MyBase.Finalize()
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "FA_CustomerTimesheetFeedback : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objMenu = Nothing
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        m_arrMenuItem(MenuIndex.SENDMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL")
        m_arrMenuTooltip(MenuIndex.SENDMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SENDMAIL) = "SendMail_OnClick()"

        m_arrMenuItem(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE")
        m_arrMenuTooltip(MenuIndex.CLOSE) = MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.CLOSE) = "Close_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick('DB')"

        MyBase.InitializeResources("AppResources.FA_CustomerTimesheetFeedback", "AppResources")
    End Sub

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim strTemp As String = ""

        ' Check if the mail has to be sent.
        If m_blnSendMail = True Then
            ' If the mail has to be sent silently, then...
            If m_blnShowPopup = False Then
                ' Send the mail.
                CommonFunction.Emails.SendEmailWithCC(m_strToEmailID, m_strCCToEmailID, m_strFromEmailID, m_strSubject, m_strEmailMessage)
                CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")
                CommonFunctions.General.WriteHTML("<TR class='clsTRColumnHeader'>")
                CommonFunctions.General.WriteHTML("<TD align=center>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MESSAGE_DELIVERED"))
                CommonFunctions.General.WriteHTML("<BR>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PBN_MESSAGING_SYSTEM") & ":")
                CommonFunctions.General.WriteHTML("<BR><BR>")
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
                CommonFunctions.General.WriteHTML("<TD align=center>")
                strTemp = m_strToEmailID
                strTemp = Replace(strTemp, ";", "<BR>")
                CommonFunctions.General.WriteHTML(strTemp)
                strTemp = m_strCCToEmailID
                strTemp = Replace(strTemp, ";", "<BR>")
                CommonFunctions.General.WriteHTML(strTemp)
                CommonFunctions.General.WriteHTML("</TD>")
                CommonFunctions.General.WriteHTML("</TR>")
                CommonFunctions.General.WriteHTML("</TABLE>")
            End If
        End If

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display the Messages
        CommonFunctions.General.WriteHTML("<DIV id=PageDiv style='overflow:auto'>")
        CommonFunctions.General.WriteHTML("<TABLE class=clsTable cellpadding=0 cellspacing=0 style='height:100%;width:100%'>")
        CommonFunctions.General.WriteHTML("<TR class='clsTROdd'>")
        CommonFunctions.General.WriteHTML("<TD align=center>")
        If m_strAction = ACTION_AUTHENTICATE Then
            CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("TIMESHEET_AUTHENTICATE_SUCCESSFUL") & "</B>")
        Else
            CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("TIMESHEET_DECLINED") & "</B>")
        End If
        If m_blnSendMail = True And m_blnShowPopup = True Then
            CommonFunctions.General.WriteHTML("<BR><BR>")
            CommonFunctions.General.WriteHTML("[" & MyBase.GetResourceString("DONOT_FORGET_SENDMAIL") & "]")
        End If
        CommonFunctions.General.WriteHTML("</TD>")
        CommonFunctions.General.WriteHTML("</TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")
        CommonFunctions.General.WriteHTML("</DIV>")

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")
    End Sub

    Private Sub GetEmailInformation()
        '==================================================================================
        ' Procedure Name	:	GetEmailInformation
        ' Purpose			:	This procedure fetches the email information from the database
        '                       depending upon the Global Variable 'm_intMessageId'.
        '                       Also get the information from the common email messages.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	17-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drEmail As IDataReader

        strQuery = "Exec usp_Sel_tbl_PM_EmailMessages " & m_intMessageId.ToString()
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                m_blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                m_blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)

        If m_blnSendMail = True And m_blnShowPopup = False Then
            'Get the Email Message.
            If m_intMessageId = 4 Then
                CommonFunction.EmailMessages.FAMessages.GetEmailMessage_4(m_strFromEmailID, m_strToEmailID, m_strCCToEmailID, m_strSubject, m_strEmailMessage, m_lngTimesheetNo)
            End If
            If m_intMessageId = 5 Then
                CommonFunction.EmailMessages.FAMessages.GetEmailMessage_5(m_strFromEmailID, m_strToEmailID, m_strCCToEmailID, m_strSubject, m_strEmailMessage, m_lngTimesheetNo)
            End If
        End If
    End Sub
End Class
