Public Class HR_OpportunityApproval_CommonPage
    Inherits CommonPage
    Private strActionCode As String

   
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
        MyBase.ApplySecurity(True)

        MyBase.strFormPage = "../HR/HR_OpportunityApproval_CommonPage.aspx"
        MyBase.Page_Load(sender, e)
        'Put user code to initialize the page here
    End Sub


    Public Sub CreateMail()
        Dim strToStatus As String
        strToStatus = CType(HttpContext.Current.Request.QueryString("ToStatus"), String)

        If strToStatus = "S" Then
            Dim drEmailMessage As IDataReader
            Dim blnSendEmail As Boolean, blnShowPopup As Boolean
            Dim intApproverID As Integer = 0
            Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
            Dim strToEmailID As String = "", strCCToEmailID As String = ""
            Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
            Dim intOpportunityID As Integer
            Dim strPKToken As String

            Dim strOperation As String
            intOpportunityID = CType(HttpContext.Current.Request.QueryString.Get("OpportunityID"), Integer)
            strPKToken = HttpContext.Current.Request.QueryString("PKToken")
            drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 493", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drEmailMessage.Read Then
                blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
            End If


            If blnSendEmail = True And blnShowPopup = True Then
                'AfterSave = ("<script language=javascript>")
                ''CommonFunction.General.WriteHTML("window.open (""../General/SendEmail.aspx?MessageID=493&OpportunityID =" + PrimaryKey + """, ""_blank"", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                ''CommonFunction.General.WriteHTML("</script>")
                'AfterSave = "var OpportunityID = GetObjectReference('frmCommonPage','OpportunityID').value;" + vbCrLf
                ' AfterSave += "var PKToken = GetObjectReference('frmCommonPage','PKToken').value;" + vbCrLf
                CommonFunction.General.WriteHTML("<script language=javascript>")
                CommonFunction.General.WriteHTML(" window.open('../General/SendEmail.aspx?MessageID=493&OpportunityID=" + intOpportunityID.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                'AfterSave += "window.opener.location.href = ""../HR/HR_Opportunity_CommonPage.aspx?OpportunityID_PK=""" + intOpportunityID.ToString + """&PKToken=""" + strPKToken + """&MasterTagID=3851&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1;""" + vbCrLf
                CommonFunction.General.WriteHTML(" window.opener.location.href = '../HR/HR_Opportunity_CommonPage.aspx?OpportunityID_PK=" + intOpportunityID.ToString + "&PKToken=" + strPKToken + "&MasterTagID=3851&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';")
                CommonFunction.General.WriteHTML(" window.close();")
                CommonFunction.General.WriteHTML(" </script>")
            End If

            If blnSendEmail = True And blnShowPopup = False Then
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_493(strFromEmailID, strToEmailID, strCCToEmailID, strSubject, strEmailMessage, intOpportunityID)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If

            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.ON_LOAD.ToString
            CommonFunction.Data.DisposeDataReader(drEmailMessage)
            'End by ArchanaN
        Else
            '    ' added by ArchanaN on 4 Dec 2007
            ' Pupose : To send the mail after reject and Approve
            ''''Case CommonFunction.Constants.APP_TAG_RM_OPPORTUNITY_APPROVEANDREJECT
            Dim drEmailMessage As IDataReader
            Dim blnSendEmail As Boolean, blnShowPopup As Boolean
            Dim intApproverID As Integer = 0
            Dim strFromEmailID As String = "", strToMailID As String = "", strCCToMailID As String = ""
            Dim strToEmailID As String = "", strCCToEmailID As String = ""
            Dim strEmailMessage As String = "", strSubject As String = "", strMessage As String = ""
            Dim intOpportunityID As Integer
            Dim strPKToken As String
            Dim intRecipientID As Integer = 0, intRevisionReasonID As Integer = 0
            Dim strApprovalStatus As String = ""
            Dim strOperation As String

            intOpportunityID = CType(HttpContext.Current.Request.QueryString.Get("OpportunityID"), Integer)
            strPKToken = HttpContext.Current.Request.QueryString("PKToken")
            drEmailMessage = CommonFunction.Data.GetDataReader("Exec usp_Sel_tbl_PM_EmailMessages 494", CType(CommonFunction.General.GetApplicationKeySetting("UseSQL"), Boolean))

            If drEmailMessage.Read Then
                blnSendEmail = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("SendMail"), "0"), Boolean)
                blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmailMessage("ShowPopup"), "0"), Boolean)
            End If


            If blnSendEmail = True And blnShowPopup = True Then
                CommonFunction.General.WriteHTML("<script language=javascript>")
                CommonFunction.General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=494&OpportunityID=" + intOpportunityID.ToString + "', '', 'resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                CommonFunction.General.WriteHTML("window.opener.location.href = '../HR/HR_Opportunity_CommonPage.aspx?OpportunityID_PK=" + intOpportunityID.ToString + "&PKToken=" + strPKToken + "&MasterTagID=3865&FromWhere=RM&PagingAlphabet=-1&SortBy=&SortOrder=&ParentTagID=0&FromCL=1&PagingNumber=1';")
                CommonFunction.General.WriteHTML(" window.close();")
                CommonFunction.General.WriteHTML("</script>")


            End If

            If blnSendEmail = True And blnShowPopup = False Then
                CommonFunction.EmailMessages.PMMessages.GetEmailMessage_494(strFromEmailID, strToEmailID, strCCToMailID, strSubject, strMessage, intOpportunityID)
                CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
            End If

            strActionCode = CommonEngine.General.cEventHandlers.ReturnCodes.ON_LOAD.ToString
            CommonFunction.Data.DisposeDataReader(drEmailMessage)
            'End by ArchanaN
        End If
    End Sub

    Public Overrides Function AfterSave(ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal ControlsHashTable As System.Collections.Hashtable, Optional ByVal PrimaryKey As String = "", Optional ByRef strActionCode As String = "", Optional ByVal IsEditMode As Boolean = True, Optional ByRef RedirectToCL As Boolean = True) As String
        CreateMail()
    End Function

    Protected Overrides Function InitPlotControls() As CommonEngine.CommonPage.cPlotControls
        Return New OpportunityApproval_cPlotControls(MyBase.m_objGlobal)
    End Function

    Protected Overrides Sub Before_Page_Caption_Print(ByRef Cancel As Boolean, ByRef Args As WAF_PageCaption, ByVal WhizGlobal As WebPages.Template.IGlobal, ByVal Gen As CommonEngines.EventHandlers.WAF_General)
        If HttpContext.Current.Request.QueryString("ToStatus") = "A" Then
            Args.LeftPageCaption = "Approver Comments"
        End If
    End Sub
End Class

Public Class OpportunityApproval_cPlotControls
    Inherits CommonEngine.CommonPage.cPlotControls
    Sub New(ByVal objGlobal As WebPages.Template.IGlobal)
        MyBase.New(objGlobal)
    End Sub


    Protected Overrides Sub Before_PlotControl(ByRef Cancel As Boolean, ByRef Args As CommonEngines.EventHandlers.WAF_Controls, ByVal WhizGlobal As WebPages.Template.IGlobal, Optional ByVal drControls As System.Data.IDataReader = Nothing, Optional ByRef InsertBeforeControl As String = "")
        Dim strSenderComment As String
        Dim strOpportunityID As String
        Dim dr As IDataReader
        strOpportunityID = HttpContext.Current.Request.QueryString("OpportunityID")


        If Args.ControlName.ToUpper = "NONDATABASE2" Then
            '<#OpportunityID>,'S'
            If strOpportunityID <> "" Then
                dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_Opportunity_Comment " + strOpportunityID + ",'S'", True)
                If dr.Read Then
                    strSenderComment = dr(0).ToString
                End If
                CommonFunction.Data.DisposeDataReader(dr)
            Else
                strSenderComment = ""
            End If
            ''Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
            'Args.InsertAfterControl = "<SPAN><PRE>" + strSenderComment + "</PRE></SPAN>"
            Args.InsertAfterControl = "<SPAN><PRE>" + HttpUtility.HtmlEncode(strSenderComment) + "</PRE></SPAN>"
            ''End Of Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
            Cancel = True
        End If
        If Args.ControlName.ToUpper = "NONDATABASE1" Then
            '<#OpportunityID>,'S'
            If strOpportunityID <> "" Then
                dr = CommonFunction.Data.GetDataReader("usp_Sel_tbl_RM_Opportunity_Comment " + strOpportunityID + ",'A'", True)
                If dr.Read Then
                    strSenderComment = dr(0).ToString
                End If
                CommonFunction.Data.DisposeDataReader(dr)
            Else
                strSenderComment = ""
            End If
            ''Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
            'Args.InsertAfterControl = "<SPAN><PRE>" + strSenderComment + "</PRE></SPAN>"
            Args.InsertAfterControl = "<SPAN><PRE>" + HttpUtility.HtmlEncode(strSenderComment) + "</PRE></SPAN>"
            ''End Of Commented and Added By Vidya J ON 1 Sep 2016 For MasterCard NextGen Upgrade
            Cancel = True
        End If
    End Sub
End Class


