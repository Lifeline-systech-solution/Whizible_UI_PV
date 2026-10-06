Public Class IB_UserSettings
    Inherits WebPages.Template.WhizTemplate

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

#Region " Class Scope Variables "
    Private m_strAction As String
    Private m_strPageTitle As String
    Private m_lngViewId As Long
    Private m_lngQueryId As Long
    Private m_intRowsPerPage As Integer
    Private m_lngProjectId As Long
    Private m_lngUserId As Long
    Private m_strLoginType As String
    Private m_intMaxItems As Integer
#End Region

#Region " Page Level Constants "
    Protected Const ACTION_APPLYSETTINGS As String = "ApplySettings"
    Protected Const STATUS_APPLIED As String = "Applied"
#End Region

    Property PageTitle() As String
        Get
            Return Server.HtmlEncode(m_strPageTitle)
        End Get
        Set(ByVal Value As String)
            m_strPageTitle = Value
        End Set
    End Property

    Property MaxItem() As Integer
        Get
            Return m_intMaxItems
        End Get
        Set(ByVal Value As Integer)
            m_intMaxItems = Value
        End Set
    End Property

    Property PageAction() As String
        Get
            Return m_strAction
        End Get
        Set(ByVal Value As String)
            m_strAction = Value
        End Set
    End Property

    Private Sub Page_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim drWork As IDataReader
        Dim strQuery As String

        'Put user code to initialize the page here

        'commented by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list(IssueID:685)
        'm_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intProjectID").ToString, "0"), Long) '312

        'Added by AniruddhaD on 18 Nov 2005 for providing projects combo on issue list(IssueID:685)
        m_lngProjectId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("IssueProject").ToString, "0"), Long)

        m_lngUserId = CType(CommonFunctions.General.CheckIsNothing(Session.Item("intUserID").ToString, "0"), Long)       '61
        m_strLoginType = CommonFunctions.General.CheckIsNothing(Session.Item("LoginType").ToString, "") '"E"

        PageTitle = MyBase.GetResourceString("TITLE")
        m_strAction = MyBase.GetFormValue("txthidAction_UserSettings")
        If m_strAction = ACTION_APPLYSETTINGS Then
            ApplySettings()
        Else
            MaxItem = CType(CommonFunctions.Application.MaxItemsInIssueIDCombo, Integer)
            strQuery = "Exec usp_Sel_tbl_IB_DefaultSettings " & m_lngProjectId & ", '"
            strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "', " & m_lngUserId
            drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
            If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
                If (drWork.Read()) Then
                    m_lngViewId = CType(CommonFunctions.Data.CheckIsDBNull(drWork("DefaultViewID"), "0"), Long)
                    m_lngQueryId = CType(CommonFunctions.Data.CheckIsDBNull(drWork("DefaultQueryID"), "0"), Long)
                    m_intRowsPerPage = CType(CommonFunctions.Data.CheckIsDBNull(drWork("IBRowsPerPage"), "0"), Integer)
                End If
            Else
                m_lngViewId = 0
                m_lngQueryId = 0
                m_intRowsPerPage = 0
            End If
            CommonFunctions.Data.DisposeDataReader(drWork)
        End If
    End Sub

    Public Sub WritePageHead()
        CommonFunction.General.PlotPageHeadTag(PageTitle)
    End Sub

    Public Sub WritePage()
        Dim strQuery As String
        Dim strMenu As String
        Dim strHTML As String
        Dim arrLegend(0) As String
        Dim arrLegendImage(0) As String

        'Display Menu 
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
        Dim arrMenuItem As String() = {MyBase.GetResourceString("MENU_IB_APPLYSETTINGS"), _
                                       MyBase.GetResourceString("MENU_CLOSE"), _
                                       MyBase.GetResourceString("MENU_HELP")}
        Dim arrMenuToolTip As String() = {MyBase.GetResourceString("MENU_IB_APPLYSETTINGS_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_CLOSE_TOOLTIP"), _
                                          MyBase.GetResourceString("MENU_HELP_TOOLTIP")}
        Dim arrClientSideFunction As String() = {"ApplySettings_OnClick()", _
                                                 "Close_OnClick()", _
                                                 "Help_OnClick('IB_SETTINGS')"}

        strMenu = WebPages.Template.StaticMenu.DrawMenu(arrMenuItem, arrClientSideFunction, arrMenuToolTip, True)
        Response.Write(strMenu)

        MyBase.InitializeResources("AppResources.IB_UserSettings", "AppResources")
        arrLegend(0) = MyBase.GetResourceString("MANDATORY")
        arrLegendImage(0) = CommonFunctions.HTMLControls.DrawMandatoryImage(, True)

        'Display Mandatory Legends
        Response.Write(WebPages.Template.PageLegends.DrawPageLegends(Nothing, arrLegendImage, arrLegend) + vbCrLf)

        'Display Page Body
        CommonFunctions.General.WriteHTML("<div id='divBody' style='overflow:auto; height:100%'>")
        'Modified by by SandipL on 8 Feb 2006 to show current Project Name as right PageCaption
        Dim strProjectName As String
        'Commented and added by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query
        'strProjectName = CType(CommonFunctions.Data.GetDataScalar("Select Isnull(ProjectName,'') From tbl_PM_Project where Projectid = " + CType(m_lngProjectId, String), True), String)
        strProjectName = CType(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_Project_ProjectNameID " + CType(m_lngProjectId, String), True), String)
        'End of addition by Sanyogeeta Raorane on 08-Aug-2016 To Remove Inline Query

        strHTML = WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SELECT_DEFAULTVIEW"), "Project: " + strProjectName, , True)
        'End Modification by SandipL
        CommonFunctions.General.WriteHTML(strHTML)
        CommonFunctions.General.WriteHTML("<br>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunction.General.WriteHTML("<table cellspacing='0' class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<tr class='clsTREven'><td align='right' style='width:25%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("SELECTVIEW"))
        CommonFunction.General.WriteHTML("</td><td valign='top'>")
        'Build the Query to fill the combo of Views
        strQuery = "Exec usp_Sel_tbl_IB_Project_Views " & m_lngProjectId & ", '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "',"
        strQuery &= m_lngUserId & ", NULL, 4, '-1'"
        CommonFunctions.HTMLControls.DrawComboBox("cboView", strQuery, 350, m_lngViewId.ToString(), , True, , , True)
        'Added By VidyaJ - For issueID - 3330 - Whiz6.0
        '' Integrated By ParagD On 17-Feb-2006
        '' Purpose : DSS 916 - Not able to set default view.

        '' Addition by Harshada D on 21 st of May 2005 for DATAMATICS ISSUE ID : 18606
        If m_lngViewId = 0 Or m_lngViewId.ToString() = "" Then
            Response.Write("<SCRIPT LANGUAGE=""JavaScript"">document.forms[0].cboView.options[document.forms[0].cboView.selectedIndex].text =""Corporate View""</SCRIPT>")
        Else
            Response.Write("<SCRIPT LANGUAGE=""JavaScript"">document.forms[0].cboView.options[0].text = ""Corporate View""</SCRIPT>")
        End If
        '' end of Addition by Harshada D on 21 st of May 2005 for DATAMATICS ISSUE ID : 18606

        '' END : Integrated By ParagD On 17-Feb-2006.

        CommonFunction.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("<br>")

        strHTML = WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("SELECT_DEFAULTQUERY"), , , True)
        CommonFunctions.General.WriteHTML(strHTML)
        CommonFunctions.General.WriteHTML("<br>")
        CommonFunction.General.WriteHTML("<table cellspacing='0' class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<tr class='clsTREven'><td align='right' style='width:25%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("SELECTQUERY"))
        CommonFunction.General.WriteHTML("</td><td valign='top'>")
        'Build the Query to fill the combo of Queries
        strQuery = "Exec usp_Sel_tbl_IB_Query NULL," & m_lngProjectId & ","
        strQuery &= m_lngUserId & ", '', '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "', 'A'"
        CommonFunctions.HTMLControls.DrawComboBox("cboQuery", strQuery, 350, m_lngQueryId.ToString(), , True)
        CommonFunction.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("<br>")

        strHTML = WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("OTHER_SETTINGS"), , , True)
        CommonFunctions.General.WriteHTML(strHTML)
        CommonFunctions.General.WriteHTML("<br>")
        'Modified by ShraddhaM on Date 20 June,2006 for WhizibleSEM Issue ID.4168

        CommonFunction.General.WriteHTML("<table cellspacing='0' class='clsTable' width='99.9%'>")
        CommonFunction.General.WriteHTML("<tr class='clsTREven'><td align='right' style='width:25%'>")
        CommonFunction.General.WriteHTML(MyBase.GetResourceString("ROWSPERPAGE"))
        CommonFunction.General.WriteHTML("</td><td valign='top'>")
        'Build the Query to fill the combo of Queries

        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txtRowsPerPage", "txtRowsPerPage", , 50, 4, m_intRowsPerPage.ToString(), "Right", EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
        CommonFunction.General.WriteHTML("</td></tr></table>")
        CommonFunctions.General.WriteHTML("</div>")
        CommonFunctions.General.WriteHTML("<br>")
        'Display Menu
        Response.Write(strMenu)

        'Hidden Fields
        'Commented and added by Yogesh J for HTML encoding Date:07/10/15
        CommonFunctions.HTMLControls.DrawTextBox("txthidAction_UserSettings", "txthidAction_UserSettings", , , , , , , , , , True, EnableHTMLEncode:=True)
        'ended by Yogesh J for HTML encoding Date:07/10/15
    End Sub

    Public Sub New()
        ''Commented and Added by Nilesh g on 10/10/2016 Purpose:For sso and sql injection
        ''MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End of Added by Nilesh g on 10/10/2016
        MyBase.InitializeResources("AppResources.IB_UserSettings", "AppResources")
    End Sub

    Private Sub ApplySettings()
        Dim strQuery As String

        'Added By VidyaJ - For issueID - 3330 - Whiz6.0
        'code modified by harshada d on 14082005 for datamatics issue id 19608 corporate view is mapped to cboview.value =0
        'm_lngViewId = CType(MyBase.FixString(MyBase.GetFormValue("cboView"), 0, True, True), Integer)
        If CommonFunction.General.CheckIsNothing(MyBase.GetFormValue("cboView")) = "" Then
            m_lngViewId = 0
        Else
            m_lngViewId = CType(MyBase.FixString(MyBase.GetFormValue("cboView"), 0, True, True), Integer)
        End If
        'end of modification by harshada d

        strQuery = "Exec usp_Ins_tbl_IB_DefaultSettings " & m_lngProjectId & ", '"
        strQuery &= CommonFunctions.General.BuildQueryString(m_strLoginType) & "', " & m_lngUserId
        strQuery &= "," & m_lngViewId.ToString()

        If MyBase.FixString(MyBase.GetFormValue("cboQuery"), 0, True, False) <> "" Then
            strQuery &= "," & MyBase.GetFormValue("cboQuery")
        Else
            strQuery &= ", NULL"
        End If

        If MyBase.FixString(MyBase.GetFormValue("txtRowsPerPage"), 0, True, False) <> "" Then
            strQuery &= ", " & MyBase.GetFormValue("txtRowsPerPage")
        Else
            strQuery &= ", NULL"
        End If
        CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
        PageAction = STATUS_APPLIED

        ' Store the default view ID in the session.
        Session("intViewID") = m_lngViewId

        ' Store the default Query ID in the session.
        Session("intQueryID") = m_lngQueryId
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As New Exception
        ex.Source = "IB_UserSettings: " & UserInput & " " & Cause
        Throw ex
    End Sub
End Class
