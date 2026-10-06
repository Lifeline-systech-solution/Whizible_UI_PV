Imports CommonEngines.General.cEventHandlers
Public Class cApprove_CommonPageDataManagement
    Inherits CommonEngine.CommonPage.cDataManagement
    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cApprove_CommonPageSubTagCLSQL
    Inherits CommonEngine.CommonList.cSubTagCLSQL
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        'Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
    End Sub

End Class
Public Class cApprove_CommonPageCPSQL
    Inherits CommonEngine.CommonPage.cCPSQL

    'Constructor
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        Call MyBase.New(WhizGlobal)
    End Sub
End Class
Public Class cApprove_CommonPagePlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Private m_strProjectID As String
    Public Sub New(ByVal WhizGlobal As WebPages.Template.IGlobal)
        ''Assign the Parameter values to the local variables
        Call MyBase.New(WhizGlobal)
        If HttpContext.Current.Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = HttpContext.Current.Request.QueryString("ProjectID")
        Else
            m_strProjectID = HttpContext.Current.Request.Form("hidProjectID")
        End If
    End Sub

    Protected Overrides Sub Before_PlotControlCell(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing)
        Dim strCommentData As String
        Dim strSQL As String
        Dim strRevisionReasonID As String

        strRevisionReasonID = HttpContext.Current.Request.QueryString("RevisionReasonID_PK")


        If Args.ControlName.ToUpper() = "REASONFORREVISION" Then
            If strRevisionReasonID <> "" Then

                'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                'strSQL = "Select REasonForRevision From d_tbl_RM_ReqRevisionReason Where RevisionReasonID=" + strRevisionReasonID
                strSQL = "usp_sel_d_tbl_RM_ReqRevisionReason_REasonForRevision " + strRevisionReasonID
                'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
                strCommentData = Replace(HttpContext.Current.Server.HtmlEncode(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar(strSQL, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean)), ""), "").ToString()), (Chr(13)), "<BR>")

                Args.IgnoreActualValue = True
                Args.NewValue = strCommentData
            End If
        End If
    End Sub

    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        'Added by PrashantD for removing session projectID placeholder to queryString ProjectID
        If Args.AdditionalInformation <> "" Then
            Args.AdditionalInformation = Args.AdditionalInformation.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.AddNewRelativeSource <> "" Then
            Args.AddNewRelativeSource = Args.AddNewRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.DropDownEditSQL <> "" Then
            Args.DropDownEditSQL = Args.DropDownEditSQL.Replace("<PROJECT_ID>", m_strProjectID)
        End If

        If Args.EditRelativeSource <> "" Then
            Args.EditRelativeSource = Args.EditRelativeSource.Replace("<PROJECT_ID>", m_strProjectID)
        End If
        'End of addition by PrashantD
    End Sub
End Class


Public Class Approve_CommonPage
    Inherits CommonPage
#Region "Global Variables"
    Protected m_strProjectRequirementID As String
#End Region
    Private m_strProjectID As String
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

    Protected Overrides Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'Put user code to initialize the page here
        'Get this property from HashTable.
        MyBase.strListPage = "Approve_CommonList.aspx"
        MyBase.strFormPage = "Approve_CommonPage.aspx"
        If Request.QueryString("ProjectID") <> "" Then
            m_strProjectID = Request.QueryString("ProjectID")
        Else
            m_strProjectID = Request.Form("hidProjectID")
        End If

        MyBase.Page_Load(sender, e)

    End Sub

    Protected Overrides Function PageUIPreRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String
        Dim intRevisionReasonId As Integer
        Dim strApprover As String
        Dim strApproverComment As String
        Dim drApprover As IDataReader
        Dim strSql As String
        Dim strScript As String

        Dim intProjectRequirementId As Integer
        '  Dim strSQL As String
        Dim objDR As IDataReader
        Dim objdrstatus As IDataReader
        Dim blnSendEMail As Boolean
        Dim blnDisplayMsg As Boolean
        Dim strStatus As String


        m_strProjectRequirementID = HttpContext.Current.Request.QueryString("ProjectRequirementId")
        intRevisionReasonId = CType(HttpContext.Current.Request.QueryString("RevisionReasonId"), Integer)
        strApprover = CType(HttpContext.Current.Request.Form("RevisedBy"), String)
        strApproverComment = CType(HttpContext.Current.Request.Form("ApproverComment"), String)

        If strApproverComment <> "" Then
            '--- FOR APPROVAL
            If Request.QueryString("Mode").ToUpper = "EDIT" Then
                strSql = "usp_RM_Upd_tbl_RM_ReqRevisionReason " + CStr(intRevisionReasonId) + ",'" + strApproverComment + "','" + strApprover + "'," + CStr(1) + "," + m_strProjectRequirementID

            Else  'FOR REJECTION
                strSql = "usp_RM_Upd_tbl_RM_ReqRevisionReason " + CStr(intRevisionReasonId) + ",'" + strApproverComment + "','" + strApprover + "'," + CStr(2) + "," + m_strProjectRequirementID
            End If
            CommonFunctions.Data.InsertOrUpdateData(strSql, CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            'FOR SENDING MAIL
            intProjectRequirementId = CType(HttpContext.Current.Request.QueryString("ProjectRequirementId"), Integer)

            'Commented and added by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query
            'strSql = "Select Status From tbl_RM_ReqRevisionReason Where RevisionReasonID=" + intRevisionReasonId.ToString
            strSql = "usp_sel_tbl_RM_ReqRevisionReason_Status " + intRevisionReasonId.ToString
            'End of addition by Yogesh Jalamkar on 04-Aug-2016 To Remove Inline Query

            objdrstatus = CommonFunctions.Data.GetDataReader(strSql, True)
            If objdrstatus.Read Then
                strStatus = CStr(objdrstatus.Item("Status"))

                If strStatus = "1" Then 'approve email

                    'get the settings for sending email
                    strSql = "usp_Sel_tbl_PM_EmailMessages 479"
                    objDR = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
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
                    CommonFunction.Data.DisposeDataReader(objDR)
                    objDR = Nothing

                    'check the settings and send email
                    If blnSendEMail = True Then
                        If blnDisplayMsg = True Then

                            'send email silently
                            ' Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_477(strFromEmailID, strTOEmailID, strCCToEmailId, strSubject, strEmailMsg, m_intProjectDocumentReftypeid)
                            'write client side script to display the message window
                            CommonFunctions.General.WriteHTML("<Script language=javascript>")
                            CommonFunctions.General.WriteHTML("window.open('../RM/RM_SendEmail.aspx?MessageID=479&ProjectRequirementId=" + intProjectRequirementId.ToString + "&RevisionReasonID=" + intRevisionReasonId.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            ''''''CommonFunctions.General.WriteHTML("window.close();")
                            CommonFunctions.General.WriteHTML("</Script>")
                            '  Else

                            'Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
                        End If
                    End If
                    strScript = " refreshParent('frmCommonPage','ProjectRequirements_CommonPage.aspx?','ProjectRequirements_CommonPage.aspx?FromWhere=RM&ProjectID=" + m_strProjectID + "&MasterTagID=3714&FromMode=Approve&ProjectRequirementId=" + m_strProjectRequirementID + "');"
                    strScript += "if (window.opener)"
                    strScript += "if (window.opener.opener)"
                    strScript += "{ "
                    strScript += "window.opener.opener.document.forms[0].action=""../RM/RM_Tracking.aspx"";"
                    strScript += "window.opener.opener.document.forms[0].submit();"
                    strScript += "}"

                    strScript += "window.close();"
                ElseIf strStatus = "2" Then    'REJECTION MAIL

                    'get the settings for sending Rejection email
                    strSql = "usp_Sel_tbl_PM_EmailMessages 480"
                    objDR = CommonFunctions.Data.GetDataReader(strSql, MyBase.UseSQL)
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
                    CommonFunction.Data.DisposeDataReader(objDR)
                    objDR = Nothing

                    'check the settings and send email
                    If blnSendEMail = True Then
                        If blnDisplayMsg = True Then

                            'send email silently
                            ' Call CommonFunction.EmailMessages.RMMessages.GetEmailMessage_477(strFromEmailID, strTOEmailID, strCCToEmailId, strSubject, strEmailMsg, m_intProjectDocumentReftypeid)
                            'write client side script to display the message window
                            CommonFunctions.General.WriteHTML("<Script language=javascript>")
                            CommonFunctions.General.WriteHTML("window.open('../RM/RM_SendEmail.aspx?MessageID=480&ProjectRequirementId=" + intProjectRequirementId.ToString + "&RevisionReasonID=" + intRevisionReasonId.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                            ''''''''CommonFunctions.General.WriteHTML("window.close();")
                            CommonFunctions.General.WriteHTML("</Script>")
                            '  Else

                            'Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
                        End If
                    End If
                End If
                CommonFunctions.Data.DisposeDataReader(objdrstatus)
            End If


            strScript = " refreshParent('frmCommonPage','ProjectRequirements_CommonPage.aspx?','ProjectRequirements_CommonPage.aspx?FromWhere=RM&ProjectID=" + m_strProjectID + "&MasterTagID=3714&FromMode=Approve&ProjectRequirementId=" + m_strProjectRequirementID + "');"
            strScript += "if (window.opener)"
            strScript += "if (window.opener.opener)"
            strScript += "{ "
            strScript += "window.opener.opener.document.forms[0].action=""../RM/RM_Tracking.aspx"";"
            strScript += "window.opener.opener.document.forms[0].submit();"
            strScript += "}"

            strScript += "window.close();"

            PageUIPreRender = strScript
            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.ON_LOAD.ToString

        End If
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        CommonFunction.General.WriteHTML("<input type=hidden name=hidProjectID id=hidProjectID value=" + m_strProjectID + ">")
        'Put user code to initialize the page here
        Return New cApprove_CommonPagePlotControls(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagPlotControls() As CommonEngine.CommonPage.cPlotControls
    '    Return New c < PAGE_NAME > PlotControls(MyBase.m_objGlobal)
    'End Function

    Protected Overrides Function InitCPSQL() As CommonEngine.CommonPage.cCPSQL
        Return New cApprove_CommonPageCPSQL(MyBase.m_objGlobal)
    End Function

    Protected Overrides Function InitDataManagement() As CommonEngine.CommonPage.cDataManagement
        Return New cApprove_CommonPageDataManagement(MyBase.m_objGlobal)
    End Function

    'Protected Overrides Function InitSubTagCLSQL(ByVal WhizGlobal As WebPages.Template.IGlobal) As CommonEngine.CommonList.cSubTagCLSQL
    '    Return New c < PAGE_NAME > SubTagCLSQL(WhizGlobal)
    'End Function

    Protected Overrides Function PageUIPostRender(ByVal m_objGlobal As WebPages.Template.IGlobal, Optional ByRef strActionCode As String = "", Optional ByVal strPrimaryKey As String = "") As String

    End Function
End Class
