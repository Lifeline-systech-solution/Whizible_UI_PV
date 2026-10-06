Imports CommonEngines.General.cEventHandlers
Public Class UnlockUser_CommonList
    Inherits CommonList



#Region " Web Form Designer Generated Code "

    'This call is required by the Web Form Designer.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()

    End Sub

    'NOTE: The following placeholder declaration is required by the Web Form Designer.
    'Do not delete or move it.
    Private designerPlaceholderDeclaration As System.Object

    Private Sub Page_Init(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.ApplySecurity(True)
        'CODEGEN: This method call is required by the Web Form Designer
        'Do not modify it using the code editor.
        InitializeComponent()
    End Sub
#End Region

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        MyBase.strListPage = "UnlockUser_CommonList.aspx"
        MyBase.strFormPage = "CommonPage.aspx"
        MyBase.strSubTagPage = "../General/CommonSubTag.aspx"
        If Request.QueryString("Action") IsNot Nothing Then
            If Request.QueryString("Action").ToUpper() = "SAVE" Then

                Call SaveData()
            End If
        End If
        'Put user code to initialize the page here
        MyBase.Page_Load(sender, e)
    End Sub
    Sub SaveData()
        Dim strLockedUser As String() = CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "").Split(",")
        Dim strPassword As String = ""
        Dim drEmail As IDataReader

        Dim strFromEmailID As String
        Dim strToEmailID As String
        Dim strUserName As String
        Dim strSenderName As String
        Dim strEncryptedNewPassword As String
        ''Added by Nilesh g on 15/11/2016 Purpose:Nextgen issue solving
        If CommonFunction.General.CheckIsNothing(HttpContext.Current.Request.Form("chkDelete"), "") <> "" Then
            ''end of Added by Nilesh g on 15/11/2016 Purpose:Nextgen issue solving
            For Each strUser As Integer In strLockedUser
                Dim strQuery As String = "usp_upd_tbl_PM_Login_LockUnlock " & strUser
                CommonFunctions.Data.InsertOrUpdateData(strQuery, True)

                Dim objCreateNewPassword As New CreateNewPassword()
                strPassword = objCreateNewPassword.CreatePassword()

                drEmail = CommonFunction.Data.GetDataReader("Usp_sel_LockedUser_Details " & strUser & "," & Session("intUserID") & "", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
                If drEmail.Read Then
                    strFromEmailID = CStr(drEmail("FromMailID"))
                    strToEmailID = CStr(drEmail("ToMailID"))
                    strUserName = CStr(drEmail("Username"))
                    strSenderName = CStr(drEmail("SenderName"))
                End If

                Dim objEncryptNewPassword As New Authentication.PWEncryption(strUserName, strPassword)

                'Get the encrypted password
                strEncryptedNewPassword = objEncryptNewPassword.Encrypt()

                CommonFunctions.Data.InsertOrUpdateData("usp_Upd_tbl_PM_Login_Password " & strUser & ",'" & strEncryptedNewPassword & "','" & Session("strUserName") & "'", True)

                Call SendMail(strUser, strPassword, strFromEmailID, strToEmailID, strUserName, strSenderName) 'To send mail to user about his password got reset.
            Next
        End If

    End Sub
    Private Sub SendMail(ByVal lngLoginID As Long, ByVal strPassword As String, ByVal strFromEmailID As String, ByVal strToEmailID As String, ByVal strUserName As String, ByVal strSenderName As String)

        Dim strLoginName As String
        Dim strUserType As String

        Dim drEmail As IDataReader = CommonFunction.Data.GetDataReader("usp_Sel_tbl_PM_EmailMessages 20033", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))
        Dim blnSendEmail As Boolean = False
        Dim blnShowPopup As Boolean = True

        Dim strCCToEmailID As String
        Dim strSubject As String
        Dim strEmailMessage As String

        Dim strMessage As New System.Text.StringBuilder("")

        ' Retrieve information about the mail message.
        If drEmail.Read Then
            blnSendEmail = CType(drEmail("SendMail"), Boolean)
            blnShowPopup = CType(drEmail("ShowPopup"), Boolean)

            strSubject = CStr(drEmail("Subject"))
            strEmailMessage = CStr(drEmail("Body"))
        End If
        'dispose
        CommonFunction.Data.DisposeDataReader(drEmail)

        strMessage.Append(strEmailMessage)

        strMessage.Replace("<LOGIN_NAME>", strUserName)
        strMessage.Replace("<NEW_PASSWORD>", strPassword)

        strMessage.Replace("<SENDER_NAME>", strSenderName)

        strEmailMessage = strMessage.ToString

        If blnSendEmail = True Then
            If blnShowPopup = False Then
                'Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            Else
                'Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_20032(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, lngUserId, strUserType, strLoginName, strPassword)
                Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailID, strFromEmailID, strSubject, strEmailMessage)
            End If
        End If

        strMessage = Nothing
    End Sub

    'Protected Overrides Function BeforeDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function AfterDelete(ByVal DeletedIDList As String, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.IGNORE_DELETE.ToString
    'End Function

    'Protected Overrides Function PageListPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String

    'End Function

    'Protected Overrides Function PageListPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "") As String
    '    strActionCode = ReturnCodes.DO_NOTHING.ToString
    'End Function


    'Protected Overrides Sub After_Getting_FilterClause(ByRef FilterClause As String)

    'End Sub

    'Protected Overrides Sub Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Link, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Before_Applying_Filter(ByRef ToBeInsertedInFunction As String)

    'End Sub

    'Protected Overrides Sub Before_Header_Footer_Print(ByRef Cancel As Boolean, ByRef Args As WAF_HeaderFooter)

    'End Sub

    'Protected Overrides Sub Before_Legend_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Legends)

    'End Sub

    'Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption)

    'End Sub

    'Protected Overrides Sub Before_Paging_Print(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize(ByRef Cancel As Boolean, ByRef Args As WAF_DynamicMenu, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Protected Overrides Sub Initialize_Legend(ByRef Cancel As Boolean, ByRef Args As WAF_InitializeLegends)

    'End Sub

    'Protected Overrides Sub Initialize_Paging_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Paging, ByVal WhizGlobal As WebPages.Template.IGlobal, ByRef Paging As WAF_DynamicMenu_Paging)

    'End Sub


    'Public Overrides Sub Before_GridLinksFunction_Print(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_DynamicLink.WAF_GridLinks_Function, ByVal WhizGlobal As WebPages.Template.IGlobal)

    'End Sub

    'Public Overrides Sub Before_PlotSection(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotSectionTitle(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSectionTitle(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotSection(ByVal Args As CommonEngines.EventHandlers.WAF_Section, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotGraph(ByVal Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub After_PlotRelatedDataHeader(ByVal Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotGraph(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Graph, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub

    'Protected Overrides Sub Before_PlotRelatedDataHeader(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_RelatedData.WAF_RelatedDataHeader, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal PrimaryKey As String = "")

    'End Sub
End Class
