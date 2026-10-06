Imports CommonFunctions
Imports System.Web.HttpUtility


Public Class PM_ProjInfo_Discussion
    Inherits WebPages.Template.WhizTemplate

    Protected m_RefreshParent As Integer = 0
    Protected m_strRoleId As Integer
    Protected m_strWindowTitle As String
    Protected m_strProjectID As String = ""
    Protected CONST_ACTION_SAVE As String = "SAVE"

    Private m_blnEditAccess As Boolean
    Private m_strAction As String = ""
    Private m_strUserName As String
    Private m_strCurrentStatus As String = ""
    Private WithEvents m_objGrid As New WebPage.Templates.GenericGrid

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
        'Put user code to initialize the page here
        m_strWindowTitle = "Project Discussion Thread"
       
    End Sub
    Public Sub PlotHead()
        m_strWindowTitle = "Project Discussion Thread"
        CommonFunction.General.PlotPageHeadTag(m_strWindowTitle)
    End Sub

    Private Sub CreateGlobalObject()
        'Global object
        Dim objGlobal As WebPages.Template.IGlobal
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID, CommonFunction.General.GetApplicationKeySetting("UseHashTableForCLCP"))
        objGlobal = MyBase.GlobalObject
        objGlobal.TagID = 32

        objGlobal.RoleID = m_strRoleId

        Dim objAccess As New WebPage.Templates.AccessRights
        objAccess.GetAccess(objGlobal)

        m_blnEditAccess = objAccess.Edit 'If user has Edit Access

        'destroy global and AccessRights objects
        objGlobal = Nothing
        objAccess = Nothing
    End Sub 'Get all session variable values
    Public Sub PageInit()
        ''Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.ApplySecurity(True)
        ''End Of Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        Dim arrMenu As System.Collections.ArrayList
        Dim arrMenuToolTip As System.Collections.ArrayList
        Dim arrClientSideFunctions As System.Collections.ArrayList
        Dim strMenu As String

        Dim strProjectName As String = ""

        m_strRoleId = CType(Session("intPostID"), String)

        If Not Request.QueryString("RefreshParent") Is Nothing Then
            m_RefreshParent = Request.QueryString("RefreshParent").ToString
        Else
            m_RefreshParent = "0"
        End If

        If Not Request.QueryString("UniqueID") Is Nothing Then
            m_strProjectID = Request.QueryString("UniqueID").ToString
        Else
            m_strProjectID = "0"
        End If
        ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
        ''strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("select ProjectName from tbl_PM_Project WHERE ProjectID = " + m_strProjectID, True), ""), String)
        strProjectName = CType(CommonFunctions.Data.CheckIsDBNull(CommonFunctions.Data.GetDataScalar("usp_tbl_PM_Project_ProjectName " + m_strProjectID, True), ""), String)
        '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

        If Not Request.QueryString("Action") Is Nothing Then
            m_strAction = Request.QueryString("Action").ToString
        Else
            m_strAction = ""
        End If

        m_strUserName = Session("strUserName").ToString + ""
        If Not Request.Form("cboStatus") Is Nothing Then
            m_strCurrentStatus = Request.Form("cboStatus")
        Else
            m_strCurrentStatus = ""
        End If

        Call CreateGlobalObject()

        If m_strAction <> "" Then
            Call performDiscussionThreadAction(m_strProjectID)
        End If

        'initialize the resource file for standard menu.
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")

        arrMenu = New System.Collections.ArrayList
        arrMenuToolTip = New System.Collections.ArrayList
        arrClientSideFunctions = New System.Collections.ArrayList

        'If m_blnEditAccess Then
        arrMenu.Add(MyBase.GetResourceString("MENU_SAVE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_SAVE_TOOLTIP")) : arrClientSideFunctions.Add("Save_OnClick()")
        'End If

        arrMenu.Add(MyBase.GetResourceString("MENU_CLOSE")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_CLOSE_TOOLTIP")) : arrClientSideFunctions.Add("Close_OnClick()")
        arrMenu.Add(MyBase.GetResourceString("MENU_HELP")) : arrMenuToolTip.Add(MyBase.GetResourceString("MENU_HELP_TOOLTIP")) : arrClientSideFunctions.Add("Help_OnClick('PM_PrjInfo_Discussion')")

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

        Dim strarrLegend() As String = {"Mandatory"}
        Dim strarrLegendImage() As String = {"<img src='../../images/star.gif'>"}
        General.WriteHTML(WebPage.Templates.PageLegends.DrawPageLegends(Nothing, strarrLegendImage, strarrLegend) + vbCrLf)

        'draw page caption 
        WebPage.Templates.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PAGE_CAPTION_DISCUSS"), "Project : " + CType(strProjectName, String))
        General.WriteHTML("<BR>")

        'plot the screen for discussion page
        Call plotScreenForDiscussion(m_strProjectID)


        'draw lower menu
        General.WriteHTML("<BR>")
        General.WriteHTML(strMenu)
    End Sub
    Private Sub plotScreenForDiscussion(ByVal lngIssueID As Long)
        Dim strDate As String
        Dim strComments As String
        Dim strSQL As String

        strDate = CommonFunction.Dates.CGetDateTime(Date.Now) + ""
        If m_strAction = "" Then
            strComments = MyBase.GetFormValue("txtComments") + ""
        Else
            strComments = ""
        End If

        'plot the controls
        General.WriteHTML("<Div id='DivBody' width=100% height=90% style='overflow: auto;' >")
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
        General.WriteHTML("<TD align='right' valign='top' >Comments (max length 7000 characters)</TD>")
        'General.WriteHTML("<TD align='right' valign='top' >" + MyBase.GetResourceString("CAP_COMMENTS") + "&nbsp</TD>")
        General.WriteHTML("<TD align='left'>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , , True, True) + "</TD>")
        General.WriteHTML(HTMLControls.DrawTextArea("txtComments", "txtComments", "Comments", , , "frmDiscussion", , , 380, 100, 7000, strComments.Trim, , , , , , , , True, True, EnableHTMLEncode:=True) + "</TD>")
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        General.WriteHTML("</TR>")

        ''status
        'General.WriteHTML("<TR class='clsTREven' >")
        'General.WriteHTML("<TD align='right' valign='top' >Status</TD>")
        'General.WriteHTML("<TD align='left'>")
        'General.WriteHTML(HTMLControls.DrawComboBox("cboStatus", "usp_sel_PM_RiskStatus", 200, m_strCurrentStatus, "onchange=Status_Onchange()", , True) + "</TD>")
        'General.WriteHTML("</TR>")

        General.WriteHTML("</Table>")
        General.WriteHTML("<BR>")

        'plot the grid for previous comments
        Dim arrColHeader() As String = {MyBase.GetResourceString("CAP_USER_NAME"), MyBase.GetResourceString("CAP_DATE"), MyBase.GetResourceString("COL_COMMENTS")}
        Dim arrAN() As String = {"UserName", "DiscussionDate", "Comments"}
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        strSQL = "Exec usp_Sel_tbl_PM_ProjInfo_Discussions " + m_strProjectID.ToString
        strSQL += ",'" + General.CheckIsNothing(Session("LoginType"), "E") + "'"

        With m_objGrid
            .ActualColumnArray = arrAN
            .UserFriendlyColumnArray = arrColHeader
            .ColNameToolTipOnEachRow = True
            .DIVID = "DivList"
            .DIVHeight = 300
            .DIVStyle = "overflow:auto; width:100% "
            .NoOfDataColumns = 3
            .PrinterFriendlyVersion = False
            .VerticalDisplay = False
            .ColNameToolTipOnEachRow = True
            .returnHTML = False
            .EmptyValueReplacement = "-"
            .SQL = strSQL
            .UseSQL = MyBase.UseSQL
            'plot the grid 
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .DrawGrid()
        End With
        m_objGrid = Nothing

        General.WriteHTML("</Div>")
    End Sub
    Private Sub performDiscussionThreadAction(ByVal lngProjectID As Long)
        Dim strComments As String
        Dim strSQL As String

        strComments = Request.Form("txtComments").ToString + ""

        Select Case m_strAction
            Case CONST_ACTION_SAVE
                ''insert new record for discussion comments
                strSQL = "usp_Ins_tbl_PM_ProjInfo_Discussions " + lngProjectID.ToString + ",'" + General.BuildQueryString(m_strUserName.Trim) + "','" + General.BuildQueryString(strComments.Trim) + "',0"
                Data.InsertOrUpdateData(strSQL, MyBase.UseSQL)
                ''deleted,, E-Mail Sending disable temporarily By Amit Mahadik for WhizibleSEM 10.0 As per discussion with SanjayP ,02 August 2011
                '''CommonFunction.General.WriteHTML("<script>")
                '''CommonFunction.General.WriteHTML(" window.opener.location = window.opener.location; ")
                '''CommonFunction.General.WriteHTML("</script>")
                ''end deleted,, E-Mail Sending disable temporarily By Amit Mahadik for WhizibleSEM 10.0 As per discussion with SanjayP ,02 August 2011

                'get the settings for sending email
                Dim objDR As IDataReader
                Dim blnSendEMail As Boolean
                Dim blnDisplayMsg As Boolean
                Dim strFromEmailID As String
                Dim strToEmailID As String
                Dim strSubject As String
                Dim strEmailMsg As String
                Dim strCCToEmailId As String

                strSQL = "usp_Sel_tbl_PM_EmailMessages 1002"
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
                ''E-Mail Sending disable temporarily By Amit Mahadik for WhizibleSEM 10.0 As per discussion with SanjayP ,02 August 2011
                blnSendEMail = False
                ''End E-Mail Sending disable temporarily By Amit Mahadik for WhizibleSEM 10.0 As per discussion with SanjayP
                If blnSendEMail = True Then
                    If blnDisplayMsg = True Then
                        'write client side script to display the message window
                        General.WriteHTML("<Script language=javascript>")
                        General.WriteHTML("window.open('../General/SendEmail.aspx?MessageID=1002&ProjectID=" + lngProjectID.ToString + "','','resizable=yes,scrollbars=yes,toolbar=no,statusbar=no,left=' + (window.screen.width - 600)/2 + ',top=' + (window.screen.height - 500)/2 + ',width=600,height=500');")
                        General.WriteHTML("window.close();")
                        General.WriteHTML("</Script>")
                    Else
                        'send email silently
                        Call CommonFunction.EmailMessages.PMMessages.GetEmailMessage_1002(strFromEmailID, strToEmailID, strCCToEmailId, strSubject, strEmailMsg, lngProjectID)
                        Call CommonFunction.Emails.AppSendEmailWithCC(strToEmailID, strCCToEmailId, strFromEmailID, strSubject, strEmailMsg)
                    End If
                End If
        End Select

    End Sub
    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        If Args.DataField.Trim.ToUpper = "COMMENTS" Then

            Dim strComments As String
            strComments = Args.DataReader("Comments").ToString
            strComments = HtmlEncode(strComments)
            'Commented by Yogesh J on 25-Jan-2016
            '    Args.StringToBeInserted = "<TD><PRE>" & strComments & "</PRE></TD>"
            Args.StringToBeInserted = "<TD><P>" & strComments & "</P></TD>"
            'End of comment by Yogesh J 25-Jan-2016
            Cancel = True
        End If
        If Args.DataField.Trim.ToUpper = "DISCUSSIONDATE" Then
            Args.ShowTimeWithDate = True
        End If
    End Sub
End Class
