Public Class CRM_RequestRejection
    Inherits WebPages.Template.WhizTemplate

    Protected m_strAction As String = ""

    Private m_lngEmployeeID As Long
    Private m_strLoginType As String = "E"
    Private m_strUserName As String = ""
    Private m_blnUseSQL As Boolean
    Private m_lngQueryID As Long

    '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    Protected m_strQueyID As String
    Protected m_PKToken_FromRequestDetail As String
    '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197

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
        MyBase.ApplySecurity(True)
        Call Initialize()
        '' START : Added by ParagD 14-Sept-2006 : Security Issue 6197
        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_PKToken_FromRequestDetail = Request.QueryString("PKToken")
        Else
            m_PKToken_FromRequestDetail = Request.Form("txtPkToken").ToString
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If (m_lngQueryID.ToString <> "0") And (CommonFunctions.Security.Token.ValidateToken(CType(m_lngQueryID, String) + m_lngEmployeeID.ToString + "0" + "0", m_PKToken_FromRequestDetail) = True) Then
            If Page.IsPostBack Then
                Call PerformActions()
            End If
        Else
            Call CommonFunctions.General.WriteLog_InvalidRecordAccess("Help Desk Request Rejection", 0, 0, "Query ID", CType(m_lngQueryID, String))
            'Token is Invalid now redirect to the Invalid Access Page
            System.Web.HttpContext.Current.Response.Redirect("../General/CommonPage.aspx?MasterTagID=1836")
        End If
        '' END : Added by ParagD 14-Sept-2006 : Security Issue 6197 
    End Sub


    Public Sub New()
        MyBase.InitializeResources("Resources.StandardMenu", "Resources")
        '' MyBase.ApplySecurity(False, 2)
        'Added by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
        MyBase.ApplySecurity(True)
        'End of Addtion by Nilesh g date 10/11/2016 For SQL Injection,Cross Scripting
    End Sub


    Private Sub Initialize()
        '=====================================================================
        ' Procedure Name        : Initialize()	
        ' Purpose               : To initialize the module variables here
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : 
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        ' Action of the page
        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        m_lngQueryID = CType(Request.QueryString("QueryID"), Long)
        m_lngEmployeeID = CType(Session("intUserID"), Long)
        m_strUserName = Session("strUserName").ToString
        m_strLoginType = Session("LoginType").ToString

        ' whether to use SQL?
        m_blnUseSQL = CType(CommonFunctions.General.GetApplicationKeySetting("UseSQL"), Boolean)

        '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
        If Trim(Request.QueryString("PKToken") & "") <> "" Then
            m_PKToken_FromRequestDetail = Request.QueryString("PKToken")
        End If
        '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
    End Sub


    Private Sub PerformActions()
        '=====================================================================
        ' Procedure Name        : PerformActions()	
        ' Purpose               : To take requested actions on the page
        ' Description           : The proc. performs the actions for the page
        '                         Deletes, updates and inserts are done
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : Module variables are set.
        ' Dependencies          : module variables
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        Dim strSQL As String
        Dim dr As IDataReader
        Dim blnShowPopup As Boolean
        Dim blnSendMail As Boolean
        Dim strFromEmailID As String
        Dim strToMailID As String
        Dim strCCToMailID As String
        Dim strSubject, strMessage As String
        Dim strSessionUserName As String
        If UCase(Trim(m_strAction & "")) = "SAVE" Then
            ' save the discussion
            'Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master
            'strSQL = "usp_CRM_Reject_Request " & m_lngQueryID & ",'" & MyBase.GetFormValue("txtReasonsForRejection") & "'"

            strSessionUserName = CType(Session("strUserName"), String).Replace("'", "''")
            strSQL = "usp_CRM_Reject_Request " & m_lngQueryID & ",'" & MyBase.GetFormValue("txtReasonsForRejection") & "','" & strSessionUserName & "'"
            'End of Commented and Modified By ShraddhaM on 9,Jan 2008 to update modifiedBy in tbl_CRM_Query_Master

                CommonFunction.Data.InsertOrUpdateData(strSQL, m_blnUseSQL)
                blnSendMail = False : blnShowPopup = False
                ' send mail
                dr = CommonFunctions.Data.GetDataReader("usp_sel_tbl_PM_EmailMessages 44", m_blnUseSQL)
                If dr.Read Then
                    blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(dr("SendMail"), "0"), Boolean)
                    blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(dr("ShowPopup"), "0"), Boolean)
                End If
                CommonFunctions.Data.DisposeDataReader(dr)

                If blnSendMail Then
                    If blnShowPopup Then
                        With Response
                            .Write("<script language=javascript>")
                            .Write("window.open (""../General/SendEmail.aspx?MessageID=44&QueryID=" & m_lngQueryID & "&EmployeeIDList=" & Session("intUserid").ToString & """, """", ""resizable=yes,scrollbars=no,toolbar=no,statusbar=no,left="" + (window.screen.width - 600)/2 + "",top="" + (window.screen.height - 500)/2 + "",width=600,height=500"");")
                            .Write("</script>")
                        End With
                    Else
                        ' silent mail
                        CommonFunction.EmailMessages.CRMMessages.GetEmailMessage_44(strFromEmailID, strToMailID, strCCToMailID, strSubject, strMessage, m_lngQueryID)
                        CommonFunction.Emails.AppSendEmailWithCC(strToMailID, strCCToMailID, strFromEmailID, strSubject, strMessage)
                    End If
                End If
        End If
    End Sub


    Protected Sub WritePage()
        '=====================================================================
        ' Procedure Name        : WritePage()	
        ' Purpose               : To write the page for adding report to user Dashboards
        ' Description           : same as above
        ' Parameters Passed     : None
        ' Returns               : NA
        ' Parameters Affected   : 
        ' Assumptions           : module variables are set before this
        ' Dependencies          : 
        ' Author                : Rajanikant
        ' Created               : Feb 17,2004
        ' Revisions             :
        '=====================================================================
        Dim arrMenu() As String = {MyBase.GetResourceString("MENU_SAVE"), MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTip() As String = {MyBase.GetResourceString("MENU_SAVE_TOOLTIP"), MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}
        Dim arrMenuView() As String = {MyBase.GetResourceString("MENU_CLOSE"), MyBase.GetResourceString("MENU_Help")}
        Dim arrMenuToolTipView() As String = {MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), MyBase.GetResourceString("MENU_Help_TOOLTIP")}

        Dim arrCSFunction() As String = {"Save_OnClick(" & m_lngQueryID & ")", "Close_OnClick()", "Help_OnClick('CRM_REQUEST_REJECTION')"}
        Dim arrCSFunctionView() As String = {"Close_OnClick()", "Help_OnClick('CRM_REQUEST_REJECTION')"}

        Dim dr As IDataReader
        Dim strSQL As String
        Dim strMenu As String
        Dim arrLegend() As String = {"Mandatory"}
        Dim arrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        Dim strCaption As String = ""
        Dim strReason As String
        ' added by vidya helpdesk enhancements for issue id 1936
        If Not Request.QueryString("Mode") Is Nothing Then
            If Request.QueryString("Mode").ToString.ToUpper = "VIEW" Then
                strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenuView, arrCSFunctionView, arrMenuToolTipView)
            Else
                strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
            End If
        Else
            strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenu, arrCSFunction, arrMenuToolTip)
        End If
        'end addition by vidya

        MyBase.InitializeResources("AppResources.CRM_RequestRejection", "AppResources")

        With Response
            ' menu
            .Write(strMenu)

            'legends    
            WebPage.Templates.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend)

            'page caption
            .Write(WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("CAPTION_REJECT_REQUEST")))

            .Write("<BR>")

            .Write("<div id=DivList Style='Overflow:auto;width=100%;height=300' >")

            ' get the captions from the caption template	
            dr = CommonFunction.Data.GetDataReader("usp_sel_tbl_CRM_SubRequestType_Caption_Master ", m_blnUseSQL)
            If dr.Read Then
                strCaption = dr("ReasonsForRejection").ToString
            End If
            CommonFunctions.Data.DisposeDataReader(dr)

            If Trim(strCaption & "") = "" Then strCaption = MyBase.GetResourceString("CAPTION_REASONS_FOR_REJECTION")
            'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            .Write("<Table class=clsTable cellpadding=0 cellspacing=0 width=99.9%>")
            'ENded by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

            ' text area for comments
            .Write("<tr class=clsTREven>")
            .Write("<td  width='100%'>" & strCaption)
            .Write("</td></tr>")
            .Write("<tr class=clsTREven>")
            .Write("<td  width='100%' align=center VAlign=middle>")

            

            'Modified By VidyaJ - Whiz6.0 - HelpDesk enhancements  1936
            If Not Request.QueryString("Mode") Is Nothing Then
                If Request.QueryString("Mode").ToString.ToUpper = "VIEW" Then
                    strReason = CType(CommonFunction.General.CheckIsNothing(CommonFunction.Data.CheckIsDBNull(CommonFunction.Data.GetDataScalar("SELECT ReasonsForRejection From tbl_CRM_Query_Master Where QueryID = " & m_lngQueryID, MyBase.UseSQL), ""), ""), String)
                    'Modified By ShraddhaM on 27 July 2006
                    CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Comments", , , "frmRequestRejection", , , 450, 200, , strReason, , , , , , , , , True, , , , , , "Soft", )
                Else
                    'Modified By ShraddhaM on 27 July 2006
                    CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Comments", , , "frmRequestRejection", , , 450, 200, , , , , , , , , , , True, , , , , , "Soft", )
                End If
            Else
                'Modified By ShraddhaM on 27 July 2006
                CommonFunctions.HTMLControls.DrawTextArea("txtReasonsForRejection", "txtReasonsForRejection", "Comments", , , "frmRequestRejection", , , 450, 200, , , , , , , , , , , True, , , , , , "Soft", )
                '' START : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197
                'Commented and added by Yogesh J for HTML encoding Date:06/10/15
                CommonFunction.HTMLControls.DrawTextBox("txtPkToken", "txtPkToken", , , , m_PKToken_FromRequestDetail, , , , , , , , , , , , True, EnableHTMLEncode:=True)
                'ended by Yogesh J for HTML encoding Date:06/10/15
                '' END : Commented and modified by ParagD 14-Sept-2006 : Security Issue 6197  
            End If

            .Write("</td></tr>")
            .Write("</table>")

            .Write("</Div>")

            .Write(strMenu)
        End With
    End Sub
End Class
