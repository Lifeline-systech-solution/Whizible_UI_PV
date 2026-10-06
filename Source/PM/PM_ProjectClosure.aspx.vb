Imports System.Text

Public Class PM_ProjectClosure
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
    Private Const PM_PROJECT_RESOURCES As Integer = 38
    Protected Const ACTION_SAVE As String = "Save"
    Protected Const ACTION_REOPEN As String = "Reopen"
    Protected Const ACTION_SAVEDATA As String = "SaveData"

    Private Enum MenuIndex
       'Start_AJ_10-Oct-2006
        TASK_CLOSURE
        SHOW_HISTORY
        SAVE
        'End_AJ_10-Oct-2006
        SAVE_AND_CLOSE_PROJECT
        REOPEN_PROJECT
        SEND_EMAIL
        HELP
    End Enum
        Private Const NUMBER_OF_MENUITEMS As Integer = 7 'AJ_10-Oct-2006, changed the value from 4 to 7
#End Region

#Region " Class scope Variables Declarations "
    Private m_objGlobal As WebPages.Template.IGlobal
    Private m_objAccessRights As WebPages.Security.cAccessRights
    Private WithEvents m_objGrid As New WebPages.Template.GenericGrid
    'Menu
    Private WithEvents m_objMenu As New WebPages.Template.StaticMenu
    Private m_arrMenuItem(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrMenuTooltip(NUMBER_OF_MENUITEMS - 1) As String
    Private m_arrClientSideFunctions(NUMBER_OF_MENUITEMS - 1) As String

    Protected m_strClientSideScript As String = ""
    Private m_strNotSpecified As String = ""
    Private m_strAction As String = ""
    Protected m_lngMasterTagId As Long = 0
    Private m_lngProjectId As Long = 0
    Private m_blnProjectOver As Boolean = False
    Private m_intYearsToBeShown As Integer = 0
    Private m_intMonthsToBeShown As Integer = 0
    Private m_blnResourcesAssigned As Boolean = False
    Private m_blnToolsAssigned As Boolean = False
    Private m_arrToolDescription() As String '= {"0"}
    Private m_arrToolId() As Long
    Private m_blnSendMail As Boolean = False
    Private m_blnShowPopup As Boolean = False
    Private m_blnProjectResourcesRight As Boolean = False
    Private m_blnToolsUsedRights As Boolean = False

    'Project Closure related information
    Private m_strLOC As String = ""
    Private m_strFunctionPoints As String = ""
    Private m_strBackedUp As String = ""
    Private m_strDataLabeled As String = ""
    Private m_strSoftwaresReturned As String = ""
    Private m_strCProductsReturned As String = ""
    Private m_strConcernMailID As String = ""
    Private m_strProjectFeedback As String = ""
    Private m_strSuggestions As String = ""
    Private m_strBestPractices As String = ""
    Private m_strShortcoming As String = ""
    Private m_strReasonForClosure As String = ""
    Private m_strCommitments As String = ""
    Private m_strFutureControl As String = ""
    Private m_strSignoffDocuments As String = ""
    Protected m_Status As String
    'Start_AJ_10-Oct-2006
    Dim m_strCnt As String = ""
    Dim strAllowSkillsUpdation As Boolean = False
    'End_AJ_10-Oct-2006

#End Region

    Private Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Dim strQuery As String = ""
        Dim drEmail As IDataReader

        'Initialize the Global Objects
        MyBase.FillGlobalObject(MyBase.CurrentThreadUICultureID)
        m_objGlobal = MyBase.GlobalObject()
        m_objAccessRights = New WebPages.Security.cAccessRights(m_objGlobal)
        m_objAccessRights.GetAccess()
        m_lngProjectId = m_objGlobal.ProjectID
        m_lngMasterTagId = m_objGlobal.TagID
        InitPageMenu()
        'Added by TruptiK on 19-Mar-2008
        strQuery = "Exec usp_sel_projectstatus_reopen"
        m_Status = CommonFunctions.General.CheckIsNothing(CommonFunctions.Data.GetDataScalar(strQuery, MyBase.UseSQL))
        'End of addition by TruptiK on 19-Mar-2008

        'Get the Send Email and Show Popup Details
        strQuery = "usp_Sel_tbl_PM_EmailMessages 17"
        drEmail = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drEmail) <> "" Then
            If drEmail.Read() Then
                m_blnSendMail = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("SendMail"), "False"), Boolean)
                m_blnShowPopup = CType(CommonFunctions.Data.CheckIsDBNull(drEmail.Item("ShowPopup"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drEmail)

        m_strNotSpecified = "[" & MyBase.GetResourceString("NOT_SPECIFIED") & "]"
        m_strAction = CommonFunctions.General.CheckIsNothing(Request.QueryString("Action"))
        If m_strAction = ACTION_SAVE Then
            SaveProjectClosureDetails()
			'Start_AJ_10-Oct-2006
            strQuery = "update tbl_PM_Project set ActualEndDate = '" + MyBase.FixString(MyBase.GetFormValue("txtActualEndDate"), 0, False, True) + "' where ProjectID = " + m_lngProjectId.ToString()
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            'End_AJ_10-Oct-2006
            ' Code added by SwapnilR on 10th Oct 2006
            ' Purpose : To make entry in tbl_PM_ProjectClosureComments for project closing
            strQuery = ""
            strQuery = "EXEC usp_Upd_tbl_PM_ProjectClosureComments " + m_lngProjectId.ToString + ", " + m_objGlobal.UserID.ToString
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            ' End of code addition by SwapnilR on 10th Oct 2006
        ElseIf m_strAction = ACTION_REOPEN Then
            strQuery = "Exec usp_Upd_ReopenProject " & m_lngProjectId.ToString()
            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            'Start_AJ_10-Oct-2006
        ElseIf m_strAction = ACTION_SAVEDATA Then
            'This procedure only saves the data filled by the user without closing the project.
            SaveProjectClosureDetails()
            'End_AJ_10-Oct-2006

        End If
    End Sub

    Public Sub PageInit()
        Dim strMenu As String = ""
        Dim objHeaderFooter As WebPages.Template.HeaderFooter
        Dim strHTML As String = ""

        'Start_AJ_10-Oct-2006
        m_strCnt = CType(CommonFunction.Data.GetDataScalar("usp_sel_cnt_TaskForCompletion_VoidedTasks_ProjectClosure " + Session("intProjectID").ToString, MyBase.UseSQL), String)
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtCnt", "txtCnt", , 75, 10, m_strCnt, , , , , , True, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding

		'End_AJ_10-Oct-2006
        strHTML = GetProjectDetails()
        GetResourcesAndToolsInformation()

        'Display the Menu
        strMenu = m_objMenu.DrawMenuWithEvents(m_arrMenuItem, m_arrClientSideFunctions, m_arrMenuTooltip, True)
        CommonFunctions.General.WriteHTML(strMenu)
        CommonFunctions.General.WriteHTML("<BR>")

        'Display Page Caption
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(, MyBase.GetResourceString("PROJECT_CLOSURE_FORM"), , , True))
        CommonFunctions.General.WriteHTML("<br>")

        'Display Page Header
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_HEADER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Project Details
        CommonFunctions.General.WriteHTML(strHTML)

        CommonFunctions.General.WriteHTML("<DIV id=PageDiv style='overflow:auto;width:100%'>")
        If m_blnProjectOver = False Then
            DisplayPage_BeforeProjectOver()
        Else
            DisplayPage_AfterProjectOver()
        End If
        CommonFunctions.General.WriteHTML("</DIV>")

        'Display Page Footer
        objHeaderFooter = New WebPages.Template.HeaderFooter
        objHeaderFooter.DisplayPosition = WebPages.Template.HeaderFooter.HeaderFooterDisplayPosition.LIST_FOOTER
        objHeaderFooter.DrawHeaderFooter(m_objGlobal)
        objHeaderFooter = Nothing

        'Display the Menu at the Bottom
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML(strMenu)
    End Sub

    Public Sub New()
        ''Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        ' MyBase.ApplySecurity()
        MyBase.ApplySecurity(True)
        ''End Of Commented And Added By Vidya Jadhav ON 10 Oct 2016 For XSS and SQL Injection
        MyBase.InitializeResources("AppResources.PM_ProjectClosure", "AppResources")
    End Sub

    Protected Overrides Sub NotValidInput(ByVal UserInput As String, ByVal Cause As String)
        Dim ex As Exception
        ex.Source = "PM_ProjectClosure : " & UserInput & " " & Cause
        Throw ex
    End Sub

    Private Sub Page_Unload(ByVal sender As Object, ByVal e As System.EventArgs) Handles MyBase.Unload
        m_objGrid = Nothing
        m_objMenu = Nothing
        m_objAccessRights = Nothing
        m_objGlobal = Nothing
    End Sub

    Private Sub InitPageMenu()
        MyBase.InitializeResources("AppResources.StandardMenu", "AppResources")
    'Start_AJ_10-Oct-2006
        m_arrMenuItem(MenuIndex.TASK_CLOSURE) = MyBase.GetResourceString("MENU_PM_PROJECTCLOSURE_TASKCLOSURE")
        m_arrMenuTooltip(MenuIndex.TASK_CLOSURE) = MyBase.GetResourceString("MENU_PM_PROJECTCLOSURE_TASKCLOSURE")
        m_arrClientSideFunctions(MenuIndex.TASK_CLOSURE) = "Task_Closure()"

        m_arrMenuItem(MenuIndex.SHOW_HISTORY) = MyBase.GetResourceString("MENU_PM_PROJECTCLOSURE_SHOWHISTORY")
        m_arrMenuTooltip(MenuIndex.SHOW_HISTORY) = MyBase.GetResourceString("MENU_PM_PROJECTCLOSURE_SHOWHISTORY")
        m_arrClientSideFunctions(MenuIndex.SHOW_HISTORY) = "Show_History()"

        m_arrMenuItem(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_PM_PROJECTCLOSURE_SAVE")
        m_arrMenuTooltip(MenuIndex.SAVE) = MyBase.GetResourceString("MENU_PM_PROJECTCLOSURE_SAVE")
        m_arrClientSideFunctions(MenuIndex.SAVE) = "Save_ProjectClsoureInfo()"
        'End_AJ_10-Oct-2006


        m_arrMenuItem(MenuIndex.SAVE_AND_CLOSE_PROJECT) = MyBase.GetResourceString("MENU_PM_SAVE_AND_CLOSE_PROJECT")
        m_arrMenuTooltip(MenuIndex.SAVE_AND_CLOSE_PROJECT) = MyBase.GetResourceString("MENU_PM_SAVE_AND_CLOSE_PROJECT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SAVE_AND_CLOSE_PROJECT) = "Save_OnClick()"

        m_arrMenuItem(MenuIndex.REOPEN_PROJECT) = MyBase.GetResourceString("MENU_PM_REOPEN_PROJECT")
        m_arrMenuTooltip(MenuIndex.REOPEN_PROJECT) = MyBase.GetResourceString("MENU_PM_REOPEN_PROJECT_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.REOPEN_PROJECT) = "ReOpen_OnClick()"

        m_arrMenuItem(MenuIndex.SEND_EMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL")
        m_arrMenuTooltip(MenuIndex.SEND_EMAIL) = MyBase.GetResourceString("MENU_SEND_EMAIL_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.SEND_EMAIL) = "SendEmail_OnClick()"

        m_arrMenuItem(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP")
        m_arrMenuTooltip(MenuIndex.HELP) = MyBase.GetResourceString("MENU_HELP_TOOLTIP")
        m_arrClientSideFunctions(MenuIndex.HELP) = "Help_OnClick(" & m_lngMasterTagId.ToString() & ")"

        MyBase.InitializeResources("AppResources.PM_ProjectClosure", "AppResources")
    End Sub

#Region " To Display the Page Body for the Project which not yet Closed "
    Private Sub DisplayPage_BeforeProjectOver()
        '==================================================================================
        ' Procedure Name	:	DisplayPage_BeforeProjectOver
        ' Purpose			:	This procedure displays the Page Body for Project details, before its closure.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================

        'Display the Project Closure Process requirements
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td>")
        CommonFunctions.General.WriteHTML("<br>" & MyBase.GetResourceString("ACTIONS_REQUIRED"))
        CommonFunctions.General.WriteHTML("<UL>")
        CommonFunctions.General.WriteHTML("<LI>" & MyBase.GetResourceString("ACTION_1") & "<BR>&nbsp;")
        CommonFunctions.General.WriteHTML("<LI>" & MyBase.GetResourceString("ACTION_2") & "<BR>&nbsp;")
        CommonFunctions.General.WriteHTML("<LI>" & MyBase.GetResourceString("ACTION_3"))
        CommonFunctions.General.WriteHTML("</UL>")
        CommonFunctions.General.WriteHTML("</td></tr></TABLE>")
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Resources and Tools Used List
        If m_blnResourcesAssigned = True And m_blnToolsAssigned = True Then
            Display_ProjectClosureInfo_BeforeClosure()
        Else
            CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='center'>")
            If m_blnResourcesAssigned = False Then
                CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("NO_RESOURCES_ASSIGNED") & "</b><br>")
                CommonFunctions.General.WriteHTML("[" & MyBase.GetResourceString("CONTACT_PROJECT_MANAGER_RESOURCES") & "]<br>")
            End If
            If m_blnToolsAssigned = False Then
                CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("NO_TOOLS_ASSIGNED") & "</b><br>")
                CommonFunctions.General.WriteHTML("[" & MyBase.GetResourceString("CONTACT_PROJECT_MANAGER_TOOLS") & "]<br>")
                CommonFunctions.General.WriteHTML(MyBase.GetResourceString("IF_TOOLS_USED") & "<br>")
            End If
            CommonFunctions.General.WriteHTML("</td></tr></TABLE>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
    End Sub

    Private Sub Display_ProjectClosureInfo_BeforeClosure()
        '==================================================================================
        ' Procedure Name	:	Display_ProjectClosureInfo
        ' Purpose			:	This procedure displays the Grid of Resources and tools assigned to the Project.
        '                       Also the information related to the Project Closure.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strTemp As String = ""  'Used for storing the strings Temporarily

        'Get the Project Closure information
        GetProjectClosureInformation()

        'Display the Project Closure Steps
        'Step 1 - Update Employee Skills  
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("STEP_1"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        DisplayResourcesAndToolsList()
        CommonFunctions.General.WriteHTML("<BR>")

        'Step 2 - Lines of Code and number of comment lines.  
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("STEP_2"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LINES_OF_CODE"))
        'Commented And Added By Usha Pandit On 19.05.2020 For adding space before value print
        'CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp&nbsp;&nbsp;&nbsp;</TD><TD>")
        'End Of Added By Usha Pandit On 19.05.2020 For adding space before value print
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtLinesOfCode", "txtLinesOfCode", , 75, 9, m_strLOC, "Right", EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD></TR><TR class='clsTREven'><TD width=40% align=right>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_OF_COMMENT_LINES"))
        'Commented And Added By Usha Pandit On 19.05.2020 For adding space before value print
        'CommonFunctions.General.WriteHTML("</TD><TD>")
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp&nbsp;&nbsp;&nbsp;</TD><TD>")
        'End Of Added By Usha Pandit On 19.05.2020 For adding space before value print
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtFunctionPoints", "txtFunctionPoints", , 75, 9, m_strFunctionPoints, "Right", EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")

        'Step 3 - Parameters for completed projects  
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("STEP_3"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
        'Project Backup
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top width=40%>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_BACKEDUP") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MEASUREMENTS_BACKEDUP") & "<BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD width='60%'>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtBackedUp", "txtBackedUp", value:=m_strBackedUp, Style:="width:100%;height:100")
        CommonFunctions.HTMLControls.DrawTextArea("txtBackedUp", "txtBackedUp", value:=m_strBackedUp, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Project Labeled
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_LABELED") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABELED_CAPTION") & "<BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        'CommonFunctions.HTMLControls.DrawTextArea("txtDataLabeled", "txtDataLabeled", value:=m_strDataLabeled, Style:="width:100%;height:100")
        CommonFunctions.HTMLControls.DrawTextArea("txtDataLabeled", "txtDataLabeled", value:=m_strDataLabeled, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Software Returned
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("USED_SOFTWARE_RETURNED") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LICENSED_COPIES_RETURNED") & "<BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtSoftwaresReturned", "txtSoftwaresReturned", value:=m_strSoftwaresReturned, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Customer Supplied Products Returned
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("CUSTOMER_SUPPLIED_PRODUCTS_RETURNED") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtCProductsReturned", "txtCProductsReturned", value:=m_strCProductsReturned, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Project Feedback
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_FEEDBACK") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FEEDBACK_RECEIVED") & "<BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtProjectFeedback", "txtProjectFeedback", value:=m_strProjectFeedback, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Suggestions and Improvements
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SUGGESTIONS_AND_IMPROVEMENT") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtSuggestions", "txtSuggestions", value:=m_strSuggestions, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Best Practices Followed
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PRACTICES_FOLLOWED") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtBestPractices", "txtBestPractices", value:=m_strBestPractices, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Shortcommings
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHORT_COMMINGS") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHORT_COMMINGS_IDENTIFIED_DURING_PROJECT") & "<BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtShortcomings", "txtShortcomings", value:=m_strShortcoming, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Reasons for Project Closure
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PROJECT_CLOSURE_REASON") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtReasonClosure", "txtReasonClosure", value:=m_strReasonForClosure, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Outstanding Commitments
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("OUTSTANDING_COMMITMENTS") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtOCommitments", "txtOCommitments", value:=m_strCommitments, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Future  Project Controls
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FUTURE_PROJECT_CONTROL") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PARTIES_RESPONSIBLE_FOR_FUTURE_PROJECT_CONTROL") & "<BR>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtFutureControl", "txtFutureControl", value:=m_strFutureControl, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Signoff Documents
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SIGNOFF_DOCUMENT") & "<BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("GIVE_DETAILS"))
        CommonFunctions.General.WriteHTML("</FONT></TD><TD>")
        'Commented and added by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.HTMLControls.DrawTextArea("txtSignoffDocuments", "txtSignoffDocuments", value:=m_strSignoffDocuments, style:="width:100%;height:100", EnableHTMLEncode:=True)
        'End of addition by Yogesh Jalamkar on 03-Aug-2016 for HTML Encode
        CommonFunctions.General.WriteHTML("</TD></TR>")
        CommonFunctions.General.WriteHTML("<TR><TD colspan=2>&nbsp;</TD></TR>")
        'Your Email Id
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align=right valign=top>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("YOUR_EMAIL_ID"))
        CommonFunctions.General.WriteHTML("</TD><TD>")
        'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.HTMLControls.DrawTextBox("txtEMailID", "txtEMailID", , 300, 500, m_strConcernMailID, EnableHTMLEncode:=True)
        'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        CommonFunctions.General.WriteHTML("</TD></TR>")
        CommonFunctions.General.WriteHTML("<TR><TD colspan=2>&nbsp;</TD></TR>")
        CommonFunctions.General.WriteHTML("</TABLE>")

        'Step 4 - Update Lessons Learnt 
        strTemp = MyBase.GetResourceString("STEP_4")
        strTemp = Replace(strTemp, "<=FONT=>", "<FONT style='FONT-VARIANT: small-caps;'>")
        strTemp = Replace(strTemp, "<=/FONT=>", "</FONT>")
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, strTemp, , , True))
    End Sub
#End Region

#Region " To Display the Page Body for the Project which is Closed "
    Private Sub DisplayPage_AfterProjectOver()
        '==================================================================================
        ' Procedure Name	:	DisplayPage_AfterProjectOver
        ' Purpose			:	This procedure displays the Page Body for Project details, after its closure.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================
        'Display the Project Closure Process requirements
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
        CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td><br>")
        CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("PROJECT_STATUS_CLOSED") & "</b>")
        CommonFunctions.General.WriteHTML("<br><br></td></tr></TABLE>")
        CommonFunctions.General.WriteHTML("<br>")

        'Display the Resources and Tools Used List
        If m_blnResourcesAssigned = True And m_blnToolsAssigned = True Then
            DisplayResourcesAndToolsList()
            CommonFunctions.General.WriteHTML("<BR>")
        Else
            CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
            CommonFunctions.General.WriteHTML("<tr class='clsTREven'><td align='center'>")
            If m_blnResourcesAssigned = False Then
                CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("NO_RESOURCES_ASSIGNED") & "</b><br>")
            ElseIf m_blnToolsAssigned = False Then
                CommonFunctions.General.WriteHTML("<b>" & MyBase.GetResourceString("NO_TOOLS_RECORDED") & "</b><br>")
            End If
            CommonFunctions.General.WriteHTML("</td></tr></TABLE>")
            CommonFunctions.General.WriteHTML("<br>")
        End If
        Display_ProjectClosureInfo_AfterClosure()
    End Sub

    Private Sub Display_ProjectClosureInfo_AfterClosure()
        '==================================================================================
        ' Procedure Name	:	Display_ProjectClosureInfo
        ' Purpose			:	This procedure displays the Grid of Resources and tools assigned to the Project.
        '                       Also the information related to the Project Closure.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strTemp As String = ""  'Used for storing the strings Temporarily

        'Get the Project Closure information
        GetProjectClosureInformation()

        'Display the Project Closure Steps
        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("LINES_OF_CODE_AND_COMMENTS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'><TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD align='Right'>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LINES_OF_CODE"))
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp&nbsp;&nbsp;&nbsp;</TD><TD>")
        If m_strLOC = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strLOC))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR><TR class='clsTREven'><TD width=30% align=right>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("NO_OF_COMMENT_LINES"))
        CommonFunctions.General.WriteHTML("&nbsp;&nbsp&nbsp;&nbsp;&nbsp;</TD><TD width='70%'>")
        If m_strFunctionPoints = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strFunctionPoints))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR></TABLE>")
        CommonFunctions.General.WriteHTML("<BR>")

        CommonFunctions.General.WriteHTML(WebPages.Template.PageCaption.GetPageCaptions(Nothing, MyBase.GetResourceString("OTHER_PARAMETERS"), , , True))
        CommonFunctions.General.WriteHTML("<BR>")
        CommonFunctions.General.WriteHTML("<TABLE cellspacing=0 cellpadding=0 class=clsTable width='99.9%'>")
        'Project Backup
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top width=40%><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("PROJECT_BACKEDUP") & "</B><BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("MEASUREMENTS_BACKEDUP"))
        CommonFunctions.General.WriteHTML("</FONT><BR><BR>")
        If m_strBackedUp = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strBackedUp))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Project Labeled
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("PROJECT_LABELED") & "</B><BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LABELED_CAPTION"))
        CommonFunctions.General.WriteHTML("</FONT><BR><BR>")
        If m_strDataLabeled = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strDataLabeled))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Software Returned
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("USED_SOFTWARE_RETURNED") & "</B><BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("LICENSED_COPIES_RETURNED"))
        CommonFunctions.General.WriteHTML("</FONT><BR><BR>")
        If m_strSoftwaresReturned = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strSoftwaresReturned))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Customer Supplied Products Returned
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("CUSTOMER_SUPPLIED_PRODUCTS_RETURNED") & "</B>")
        CommonFunctions.General.WriteHTML("<BR><BR>")
        If m_strCProductsReturned = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strCProductsReturned))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Project Feedback
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("PROJECT_FEEDBACK") & "</B><BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FEEDBACK_RECEIVED"))
        CommonFunctions.General.WriteHTML("</FONT><BR><BR>")
        If m_strProjectFeedback = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strProjectFeedback))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Suggestions and Improvements
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("SUGGESTIONS_AND_IMPROVEMENT") & "</B>")
        CommonFunctions.General.WriteHTML("<BR><BR>")
        If m_strSuggestions = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strSuggestions))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Best Practices Followed
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("PRACTICES_FOLLOWED") & "</B>")
        CommonFunctions.General.WriteHTML("<BR><BR>")
        If m_strBestPractices = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strBestPractices))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Shortcommings
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("SHORT_COMMINGS") & "</B><BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("SHORT_COMMINGS_IDENTIFIED_DURING_PROJECT"))
        CommonFunctions.General.WriteHTML("</FONT><BR><BR>")
        If m_strShortcoming = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strShortcoming))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Reasons for Project Closure
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("PROJECT_CLOSURE_REASON") & "</B>")
        CommonFunctions.General.WriteHTML("<BR><BR>")
        If m_strReasonForClosure = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strReasonForClosure))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Outstanding Commitments
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("OUTSTANDING_COMMITMENTS") & "</B>")
        CommonFunctions.General.WriteHTML("<BR><BR>")
        If m_strCommitments = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strCommitments))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Future  Project Controls
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("FUTURE_PROJECT_CONTROL") & "</B><BR><FONT size=1pt>")
        CommonFunctions.General.WriteHTML(MyBase.GetResourceString("PARTIES_RESPONSIBLE_FOR_FUTURE_PROJECT_CONTROL"))
        CommonFunctions.General.WriteHTML("</FONT><BR><BR>")
        If m_strFutureControl = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strFutureControl))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        'Signoff Documents
        CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
        CommonFunctions.General.WriteHTML("<TD valign=top><BR>")
        CommonFunctions.General.WriteHTML("<B>" & MyBase.GetResourceString("SIGNOFF_DOCUMENT") & "</B>")
        CommonFunctions.General.WriteHTML("<BR><BR>")
        If m_strSignoffDocuments = "" Then
            CommonFunctions.General.WriteHTML(m_strNotSpecified)
        Else
            CommonFunctions.General.WriteHTML(Server.HtmlEncode(m_strSignoffDocuments))
        End If
        CommonFunctions.General.WriteHTML("</TD></TR>")
        CommonFunctions.General.WriteHTML("<TR><TD>&nbsp;</TD></TR>")
        If m_strConcernMailID <> "" Then
            'Contact Email Id
            CommonFunctions.General.WriteHTML("<TR class='clsTREven'>")
            CommonFunctions.General.WriteHTML("<TD valign=top>")
            CommonFunctions.General.WriteHTML(MyBase.GetResourceString("FURTHER_CORRESPONDENCE_CONTACT") & " : ")
            CommonFunctions.General.WriteHTML("<A href=""mailto:" & Server.HtmlEncode(m_strConcernMailID) & """>")
            CommonFunctions.General.WriteHTML("<FONT size=2pt><B>" & Server.HtmlEncode(m_strConcernMailID) & "</B></FONT>")
            CommonFunctions.General.WriteHTML("</A>")
            CommonFunctions.General.WriteHTML("</TD></TR>")
            CommonFunctions.General.WriteHTML("<TR><TD colspan=2>&nbsp;</TD></TR>")
        End If
        CommonFunctions.General.WriteHTML("</TABLE>")

    End Sub
#End Region

    Private Sub DisplayResourcesAndToolsList()
        'Grid Related Variables
        Dim arrActualColumns() As String = {"UserName"}
        Dim arrUserFriendlyColumn() As String = {MyBase.GetResourceString("EMPLOYEE_NAME")}
        Dim arrTDStyle() As String = {""}
        Dim intNumberOfColumns As Integer = m_arrToolDescription.Length + 1
        Dim intIndex As Integer = 0
        Dim arrIgnoreHTMLEncode() As String = {"0"}

        ReDim Preserve arrActualColumns(intNumberOfColumns - 1)
        ReDim Preserve arrUserFriendlyColumn(intNumberOfColumns - 1)
        ReDim Preserve arrTDStyle(intNumberOfColumns - 1)
        For intIndex = 1 To m_arrToolDescription.Length
            arrUserFriendlyColumn(intIndex) = m_arrToolDescription(intIndex - 1)
            arrActualColumns(intIndex) = ""
            arrTDStyle(intIndex) = "align='center'"
        Next
        'Set the Grid Properties
        With m_objGrid
            .UserFriendlyColumnArray = arrUserFriendlyColumn
            .ActualColumnArray = arrActualColumns
            .TDStyleArray = arrTDStyle
            .PrimaryKey = "EmployeeID"
            .SQL = "Exec usp_Sel_GetProjectEmployeeWorkPeriod " & m_lngProjectId.ToString()
            .UseSQL = MyBase.UseSQL
            .DIVID = "divList"
            '.DIVHeight = 250
            .DIVStyle = "overflow:auto;width:100%"
            'Modified By UmeshJ on 25th October 2004 for Issue ID: 13550
            'The grid is populated in the events..has no relation with number of data columns specified in the property
            .NoOfDataColumns = 1
            'End of modifications
            .returnHTML = True
            'Added By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            .IgnoreHTMLEncode = arrIgnoreHTMLEncode
            'End Of Addition By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            CommonFunctions.General.WriteHTML(.DrawGrid())
        End With
    End Sub

#Region " Procedures/Functions Related to Database Activities "
    Private Function GetProjectDetails() As String
        '==================================================================================
        ' Function Name		:	GetProjectDetails
        ' Purpose			:	This procedure fetch the information about the Project from the database.
        ' Return Value      :   Returns the Fetched information, after properly indented in HTML Tags.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================
        'Used to Get the Access Rights.
        Dim objTempGlobal As WebPages.Template.WhizGlobal
        Dim objTempAccessRights As WebPages.Security.cAccessRights

        Dim strQuery As String = ""
        Dim drProject As IDataReader
        Dim sbProjectDetails As New StringBuilder("")

        'Project Related Fields
        Dim strProjectName As String = ""
        Dim lngLocationId As Long = 0
        Dim strLocation As String = ""
        Dim strActualStartDate As String = ""
        Dim strActualEndDate As String = ""

        strQuery = "Exec usp_Sel_tbl_PM_Project " & m_lngProjectId.ToString()
        drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
            If drProject.Read() Then
                strProjectName = drProject.Item("ProjectName").ToString()
                strProjectName = CommonFunctions.General.UnBuildQueryString(strProjectName)
                lngLocationId = CType(CommonFunctions.Data.CheckIsDBNull(drProject.Item("LocationID"), "0"), Long)
                'strActualStartDate = drProject.Item("ActualStartDate").ToString()
                'Modified By UmeshJ on 25th October 2004 for Issue ID: 13550
                'Get the Actual Start Date from the Minimum daily activity entry date instead of from Project table

                ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
                ''strActualStartDate = CStr(CommonFunctions.Data.GetDataScalar("SELECT IsNUll(MIN(EntryDate),getdate()) FROM tbl_PM_DailyActivity WHERE ProjectID = " + CStr(m_lngProjectId), MyBase.UseSQL))
                strActualStartDate = CStr(CommonFunctions.Data.GetDataScalar("usp_sel_tbl_PM_DailyActivity_MIN_EntryDate " + CStr(m_lngProjectId), MyBase.UseSQL))
                '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

                'End of modifications
                strActualStartDate = CommonFunctions.General.UnBuildQueryString(strActualStartDate)
                strActualEndDate = drProject.Item("ActualEndDate").ToString()
                strActualEndDate = CommonFunctions.General.UnBuildQueryString(strActualEndDate)
                m_blnProjectOver = CType(CommonFunctions.Data.CheckIsDBNull(drProject.Item("Over"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        'Get the Location
        strQuery = "Exec usp_Sel_PM_LocationList " & lngLocationId.ToString()
        drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
            If drProject.Read() Then
                strLocation = drProject.Item("Location").ToString()
                strLocation = CommonFunctions.General.UnBuildQueryString(strLocation)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        sbProjectDetails.Append("<TABLE class=clsTable cellspacing=0 cellpadding=0 width='99.9%'>")
        sbProjectDetails.Append("<TR>")
        sbProjectDetails.Append("<TD align=left style='width:50%'>")
        sbProjectDetails.Append("<B>" & MyBase.GetResourceString("PROJECT_NAME") & " : ")
        sbProjectDetails.Append(Server.HtmlEncode(strProjectName))
        sbProjectDetails.Append("</B></TD>")
        sbProjectDetails.Append("<TD align=right style='width:50%' valign=top>")
        If strLocation <> "" Then
            'Start_AJ_10-Oct-2006, commented and renamed the label from Location to OU
            'sbProjectDetails.Append("<B>" & MyBase.GetResourceString("LOCATION") & " : ")
            sbProjectDetails.Append("<B>" & MyBase.GetResourceString("OU") & " : ")
            'sbProjectDetails.Append("<B>Organization Unit : ")
            'End_AJ_10-Oct-2006
            sbProjectDetails.Append(Server.HtmlEncode(strLocation) & "</B>")
        End If
        sbProjectDetails.Append("</TD>")
        sbProjectDetails.Append("</TR><TR>")
        sbProjectDetails.Append("<TD align=left>")
        sbProjectDetails.Append("<B>" & MyBase.GetResourceString("ACTUAL_START_DATE") & " : ")
        If strActualStartDate <> "" Then
            sbProjectDetails.Append(CommonFunctions.Dates.CGetDate(CType(strActualStartDate, Date)))
        End If
        sbProjectDetails.Append("</B></TD><TD align=right>")
        If m_blnProjectOver = True Then
            sbProjectDetails.Append("<B>" & MyBase.GetResourceString("ACTUAL_END_DATE") & " : ")
            If strActualEndDate <> "" Then
                sbProjectDetails.Append(CommonFunctions.Dates.CGetDate(CType(strActualEndDate, Date)) & "</B>")
            End If
            'Start_AJ_10-Oct-2006
        Else
            Dim m_strMaxDAEntryDate As String = ""
            Dim m_strCurrentDate As String = ""
            sbProjectDetails.Append("<b>Actual End Date : </b>")

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''m_strMaxDAEntryDate = CType(CommonFunction.Data.GetDataScalar("select IsNUll(Max(EntryDate),getdate()) FROM tbl_PM_DailyActivity WHERE ProjectID = " + CStr(m_lngProjectId), MyBase.UseSQL), String)
            m_strMaxDAEntryDate = CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_DailyActivity_Max_EntryDate_getdate " + CStr(m_lngProjectId), MyBase.UseSQL), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            m_strMaxDAEntryDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(m_strMaxDAEntryDate, "").ToString))

            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            ''m_strCurrentDate = CType(CommonFunction.Data.GetDataScalar("select getdate()", MyBase.UseSQL), String)
            m_strCurrentDate = CType(CommonFunction.Data.GetDataScalar("usp_SELECT_GETDATE", MyBase.UseSQL), String)
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016

            m_strCurrentDate = CommonFunctions.Dates.GetDate(Date.Parse(CommonFunctions.Data.CheckIsDBNull(m_strCurrentDate, "").ToString))

            sbProjectDetails.Append(CommonFunctions.HTMLControls.DrawDateControl("txtActualEndDate", "txtActualEndDate", , 80, m_strMaxDAEntryDate, , "frmProjectClosure", returnHTML:=True, IsMandatory:=True, TabIndex:=8))
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbProjectDetails.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHidMaxDAEntryDate", "txtHidMaxDAEntryDate", , 80, , m_strMaxDAEntryDate, , , , , , True, , , , , , , EnableHTMLEncode:=True))
            sbProjectDetails.Append(CommonFunctions.HTMLControls.DrawTextBox("txtHidCurrentDate", "txtHidCurrentDate", , 80, , m_strCurrentDate, , , , , , True, , , , , , , EnableHTMLEncode:=True))
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            sbProjectDetails.Append("</TD></TR><tr style = 'font-family: Verdana, Arial;font-size: 8pt;'><td></td><td>[Actual End Date displayed is last Timesheet entry date/Todays date.]")
            'End_AJ_10-Oct-2006
        End If
        'Start_AJ_10-Oct-2006
        sbProjectDetails.Append("</TD></TR></TABLE>")
        'sbProjectDetails.Append("</TD></TR><tr><td></td><td>[Actual Enda Date displayed is last Timesheet entry date. If it does not exists then Todays date will be displayed.]</td></tr></table>")
        'End_AJ_10-Oct-2006

        sbProjectDetails.Append("<BR>")

        If m_blnProjectOver = False Then
            If strActualStartDate <> "" Then
                m_intYearsToBeShown = CType(DateDiff(DateInterval.Month, CType(strActualStartDate, Date), Now()) / 12, Integer)
                ' If the project lasted for more than 11 months, then add a year.
                If CType(DateDiff(DateInterval.Month, CType(strActualStartDate, Date), Now()) Mod 12, Integer) >= 11 Then
                    m_intYearsToBeShown += 1
                End If
                If m_intYearsToBeShown = 0 Then
                    m_intMonthsToBeShown = CType(DateDiff(DateInterval.Day, CType(strActualStartDate, Date), Now()) / 30, Integer)
                    If m_intMonthsToBeShown < 11 Then
                        m_intMonthsToBeShown += 1
                    End If
                Else
                    m_intMonthsToBeShown = 11
                End If
            Else
                m_intYearsToBeShown = 0
                m_intMonthsToBeShown = 0
            End If

            m_blnProjectResourcesRight = True
            ' Check if the concerned person has the rights to "PROJECT RESOURCES".
            objTempGlobal = New WebPages.Template.WhizGlobal
            objTempGlobal.TagID = PM_PROJECT_RESOURCES
            objTempGlobal.RoleID = m_objGlobal.RoleID
            objTempGlobal.UserID = m_objGlobal.UserID
            objTempGlobal.LoginType = m_objGlobal.LoginType
            objTempGlobal.ProjectID = m_objGlobal.ProjectID
            objTempAccessRights = New WebPages.Security.cAccessRights(objTempGlobal)
            objTempAccessRights.GetAccess()
            If objTempAccessRights.Add = False Then
                m_blnProjectResourcesRight = False
            End If
            objTempAccessRights = Nothing
            objTempGlobal = Nothing

            m_blnToolsUsedRights = True
            ' Check if the concerned person has the rights to "TOOLS USED".
            objTempGlobal = New WebPages.Template.WhizGlobal
            objTempGlobal.TagID = 35
            objTempGlobal.RoleID = m_objGlobal.RoleID
            objTempGlobal.UserID = m_objGlobal.UserID
            objTempGlobal.LoginType = m_objGlobal.LoginType
            objTempGlobal.ProjectID = m_objGlobal.ProjectID
            objTempAccessRights = New WebPages.Security.cAccessRights(objTempGlobal)
            objTempAccessRights.GetAccess()
            If objTempAccessRights.Add = False Then
                m_blnToolsUsedRights = False
            End If
            objTempAccessRights = Nothing
            objTempGlobal = Nothing
        End If
        Return (sbProjectDetails.ToString())
    End Function

    Private Sub SaveProjectClosureDetails()
        Dim strQuery As String = ""
        Dim drProject As IDataReader
        Dim strEmployeeIds As String = ""
        Dim strToolIds As String = ""
        Dim arrEmployeeId() As String
        Dim arrToolId() As String
        Dim intYears As Integer = 0
        Dim intMonths As Integer = 0
        Dim intRow As Integer = 0
        Dim intColumn As Integer = 0
        Dim strTemp As String = ""
        'Email Related Variables
        Dim strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage As String

        m_blnProjectOver = True
        strQuery = "Exec usp_Sel_tbl_PM_Project " & m_lngProjectId.ToString()
        drProject = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProject) <> "" Then
            If drProject.Read() Then
                m_blnProjectOver = CType(CommonFunctions.Data.CheckIsDBNull(drProject.Item("Over"), "False"), Boolean)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProject)

        If m_blnProjectOver = False Then
            strQuery = ""
            strEmployeeIds = MyBase.GetFormValue("txthidEmployeeId").ToString().Trim()
            strToolIds = MyBase.GetFormValue("txthidToolId").ToString().Trim()
            If strEmployeeIds <> "" Then
                arrEmployeeId = strEmployeeIds.Split(CType(",", Char))
            End If
            If strToolIds <> "" Then
                arrToolId = strToolIds.Split(CType(",", Char))
            End If

            'Modified By MrugajaB for Ensolvia Infotech Issue ID.13655 on 29th Oct,2004 HotFix ID.4.0.59
            'To check whether array arrEmployeeId is set i.e.Employees and their skills are displayed on the page
            If Not (IsNothing(arrEmployeeId)) Then
                'End Addition
                For intRow = 0 To arrEmployeeId.Length - 1
                    For intColumn = 0 To arrToolId.Length - 1
                        strTemp = "cboYear_" & arrEmployeeId(intRow) & "_" & arrToolId(intColumn)
                        intYears = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strTemp), "0"), Integer)
                        strTemp = "cboMonth_" & arrEmployeeId(intRow) & "_" & arrToolId(intColumn)
                        intMonths = CType("0" & CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue(strTemp), "0"), Integer)
                        strQuery &= "Exec usp_Ins_tbl_PM_EmployeeSkillMatrix_Detail " & m_lngProjectId.ToString()
                        strQuery &= "," & arrEmployeeId(intRow)
                        strQuery &= "," & arrToolId(intColumn)
                        strQuery &= "," & intYears.ToString() & "," & intMonths.ToString() & ", 0" & vbCrLf
                    Next
                Next
            End If
            If strQuery <> "" Then
                CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)
            End If

            strQuery = ""
            ' Build the query to close the project.
            'Start_AJ_10-Oct-2006
            If m_strAction = ACTION_SAVE Then
                strQuery = "Exec usp_Upd_tbl_ProjectClosure " & m_lngProjectId.ToString()
            ElseIf m_strAction = ACTION_SAVEDATA Then
                strQuery = "Exec usp_upd_ProjectClosureDataSave " & m_lngProjectId.ToString()
            End If
            'End_AJ_10-Oct-2006

            ' Update the function points.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFunctionPoints")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strQuery &= "," & FormatNumber(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFunctionPoints")).Trim(), , , , TriState.False)
            End If

            ' Update the lines of code.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtLinesOfCode")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strQuery &= "," & FormatNumber(CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtLinesOfCode")).Trim(), , , , TriState.False)
            End If

            ' Update the other Project Parameters.
            ' Project Backed Up.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtBackedUp")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtBackedUp")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Project Data labeled.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDataLabeled")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtDataLabeled")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Softwares returned.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSoftwaresReturned")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSoftwaresReturned")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Customer Products Returned.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtCProductsReturned")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtCProductsReturned")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Concerned person's Email ID.
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtEMailID")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtEMailID")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Project Feedback
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtProjectFeedback")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtProjectFeedback")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Suggestions And Improvemnets
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSuggestions")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSuggestions")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Best practices followed
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtBestPractices")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtBestPractices")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' shortcomings
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtShortcomings")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtShortcomings")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Reasons for project Closure
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtReasonClosure")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtReasonClosure")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Outstanding Commitments
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtOCommitments")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtOCommitments")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Future Project Control
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFutureControl")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtFutureControl")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            ' Signoff Documents
            If CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSignoffDocuments")).Trim() = "" Then
                strQuery &= ",NULL"
            Else
                strTemp = CommonFunctions.General.CheckIsNothing(MyBase.GetFormValue("txtSignoffDocuments")).Trim()
                strQuery &= ", '" & Left(strTemp, 500) & "'"
            End If

            CommonFunctions.Data.InsertOrUpdateData(strQuery, MyBase.UseSQL)

            ' Check if mail has to be sent.
            'Start_AJ_10-Oct-2006, Mail needs to be sent only when Clicked on "Save And Close Project" link. It should not be triggerd when user simply saves the data.
            If m_strAction = ACTION_SAVE Then
                If m_blnSendMail = True Then
                    ' If the popup flag is set to false, then send the mail silently.
                    If m_blnShowPopup = False Then
                        CommonFunction.EmailMessages.PMMessages.GetEmailMessage_17(strFromEmailId, strToEmailId, strCCToEmailId, strSubject, strEmailMessage)
                        CommonFunction.Emails.AppSendEmailWithCC(strToEmailId, strCCToEmailId, strFromEmailId, strSubject, strEmailMessage)
                        ' Code added by SwapnilR on 9th Oct 2006
                        ' Purpose : To show the pop-up of the project closure mail
                    Else
                        Dim strSQL As String
                        strSQL = "<script language = javascript>"
                        strSQL += "window.open('../General/SendEmail.aspx?MessageID=17',null,'status=no,toolbar=no,menubar=no,location=no,width=600,height=500');"
                        strSQL += "</script>"
                        CommonFunction.General.WriteHTML(strSQL)
                        ' End of code addition by SwapnilR on 9th Oct 2006
                    End If
                End If
            End If
        End If
    End Sub
	'End_AJ_10-Oct-2006
    Private Sub GetResourcesAndToolsInformation()
        '==================================================================================
        ' Procedure Name	:	GetResourcesAndToolsInformation
        ' Purpose			:	This procedure fetched the information about the resources and tools assigned to 
        '                       the Project. Also Build the Client side script if no resource is assigned 
        '                       or no tool is assigned to the project.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim drWork As IDataReader
        Dim strQuery As String = ""
        Dim intCount As Integer = 0

        strQuery = "Exec usp_Sel_GetProjectEmployeeWorkPeriod " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                m_blnResourcesAssigned = True
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        strQuery = "Exec usp_Sel_tbl_PM_ProjectTools " & m_lngProjectId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            While drWork.Read()
                m_blnToolsAssigned = True
                ReDim Preserve m_arrToolDescription(intCount)
                ReDim Preserve m_arrToolId(intCount)
                m_arrToolDescription(intCount) = drWork.Item("Description").ToString()
                m_arrToolDescription(intCount) = CommonFunctions.General.BuildQueryString(m_arrToolDescription(intCount)).Trim()
                m_arrToolId(intCount) = CType(CommonFunctions.Data.CheckIsDBNull(drWork.Item("ToolID"), "0"), Long)
                intCount += 1
            End While
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)

        If m_blnProjectOver = False Then
            'Build the Client Side Script Depending upon ProjectResourcesRight and ToolsUsedRight
            If m_blnResourcesAssigned = False Then
                If m_blnProjectResourcesRight = True Then
                    m_strClientSideScript = "alert(""" & MyBase.GetResourceString("ADD_RESOURCES_ASSIGNED") & """);"
                    'Start_AJ_10-Oct-2006, commented and added below as PM_ProjectResources.aspx was not there in PM folder which was giving error of Page not found.
                    'm_strClientSideScript &= "window.location.href = ""../PM/PM_ProjectResources.aspx?FromWhere=PM&MasterTagID=" & PM_PROJECT_RESOURCES & """;"
                    m_strClientSideScript &= "window.location.href = ""../General/CommonList.aspx?FromWhere=PM&MasterTagId=1019"";"

                End If
            End If
            If m_blnToolsAssigned = False Then
                If m_blnToolsUsedRights = True Then
                    m_strClientSideScript &= "alert(""" & MyBase.GetResourceString("ADD_TOOLS_USED") & """);"
                    m_strClientSideScript &= "window.location.href = ""../General/CommonList.aspx?FromWhere=PM&MasterTagID=35"";"
                End If
            End If
        End If
    End Sub

    Private Sub GetProjectClosureInformation()
        '==================================================================================
        ' Procedure Name	:	GetProjectClosureInformation
        ' Purpose			:	This procedure Project closure related information from the database.
        ' Description		:	
        ' Assumptions		:	
        ' Dependencies		:	None
        ' Author			:	Jayavant
        ' Created			:	11-Mar-2004
        ' Revisions			:	
        '==================================================================================
        Dim strQuery As String = ""
        Dim drProjectClosure As IDataReader

        strQuery = "Exec usp_Sel_tbl_ProjectClosure " & m_lngProjectId.ToString()
        drProjectClosure = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drProjectClosure) <> "" Then
            If drProjectClosure.Read() Then
                m_blnResourcesAssigned = True
                m_strLOC = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("LOC")).ToString()
                m_strLOC = CommonFunctions.General.UnBuildQueryString(m_strLOC).Trim()
                m_strFunctionPoints = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("FunctionPoint")).ToString()
                m_strFunctionPoints = CommonFunctions.General.UnBuildQueryString(m_strFunctionPoints).Trim()
                m_strBackedUp = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("ProjectBackedUp")).ToString()
                m_strBackedUp = CommonFunctions.General.UnBuildQueryString(m_strBackedUp).Trim()
                m_strDataLabeled = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("ProjectDataLabled")).ToString()
                m_strDataLabeled = CommonFunctions.General.UnBuildQueryString(m_strDataLabeled).Trim()
                m_strSoftwaresReturned = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("InternalSoftware")).ToString()
                m_strSoftwaresReturned = CommonFunctions.General.UnBuildQueryString(m_strSoftwaresReturned).Trim()
                m_strCProductsReturned = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("CustomerSoftware")).ToString()
                m_strCProductsReturned = CommonFunctions.General.UnBuildQueryString(m_strCProductsReturned).Trim()
                m_strConcernMailID = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("ConcernMailID")).ToString()
                m_strConcernMailID = CommonFunctions.General.UnBuildQueryString(m_strConcernMailID).Trim()
                m_strProjectFeedback = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("ProjectFeedback")).ToString()
                m_strProjectFeedback = CommonFunctions.General.UnBuildQueryString(m_strProjectFeedback).Trim()
                m_strSuggestions = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("Suggestions")).ToString()
                m_strSuggestions = CommonFunctions.General.UnBuildQueryString(m_strSuggestions).Trim()
                m_strBestPractices = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("BestPraticesFollowed")).ToString()
                m_strBestPractices = CommonFunctions.General.UnBuildQueryString(m_strBestPractices).Trim()
                m_strShortcoming = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("Shortcomings")).ToString()
                m_strShortcoming = CommonFunctions.General.UnBuildQueryString(m_strShortcoming).Trim()
                m_strReasonForClosure = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("ReasonForClosure")).ToString()
                m_strReasonForClosure = CommonFunctions.General.UnBuildQueryString(m_strReasonForClosure).Trim()
                m_strCommitments = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("OutstandingCommitmnets")).ToString()
                m_strCommitments = CommonFunctions.General.UnBuildQueryString(m_strCommitments).Trim()
                m_strFutureControl = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("FutureProjectControl")).ToString()
                m_strFutureControl = CommonFunctions.General.UnBuildQueryString(m_strFutureControl).Trim()
                m_strSignoffDocuments = CommonFunctions.Data.CheckIsDBNull(drProjectClosure.Item("SignOffDocuments")).ToString()
                m_strSignoffDocuments = CommonFunctions.General.UnBuildQueryString(m_strSignoffDocuments).Trim()
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drProjectClosure)

        If m_strConcernMailID = "" Then
            CommonFunction.EmailMessages.GetEmployeeInfo(m_objGlobal.UserID, "", m_strConcernMailID)
        End If
    End Sub

    Private Sub GetYearsMonthsAndDays(ByVal intDays As Integer, ByRef intEmployeeYears As Integer, _
                                      ByRef intEmployeeMonths As Integer, ByRef intEmployeeDays As Integer)
        '=====================================================================
        ' Procedure Name		:	GetYearsMonthsAndDays
        ' Parameters Passed     :	intDays				:- The number of days, that needs to be converted to years, months, and days.
        '							intEmployeeYears	:- The number of years after the conversion.
        '							intEmployeeMonths	:- The number of months after the conversion.
        '							intEmployeeDays		:- The number of days after the conversion.
        ' Returns               :	Returns the years, months and days (By Modifying the Reference Parameters).
        ' Parameters Affected   :	None.							
        ' Description           :	Converts the days given into years, months, and days.
        ' Purpose               :	Converts the days given into years, months, and days.
        ' Assumptions           :	
        ' Dependencies          :	None.
        ' Author                :	Jayavant
        ' Created               :	12-Mar-2004
        ' Revisions             :
        '=====================================================================	

        intEmployeeYears = CType(intDays / 365, Integer)
        intDays = intDays Mod 365

        If intDays = 365 Then
            intEmployeeMonths = 12
            intEmployeeDays = 0
        ElseIf intDays >= 334 Then
            intEmployeeMonths = 11
            intEmployeeDays = intDays - 334
        ElseIf intDays >= 304 Then
            intEmployeeMonths = 10
            intEmployeeDays = intDays - 304
        ElseIf intDays >= 273 Then
            intEmployeeMonths = 9
            intEmployeeDays = intDays - 273
        ElseIf intDays >= 243 Then
            intEmployeeMonths = 8
            intEmployeeDays = intDays - 243
        ElseIf intDays >= 212 Then
            intEmployeeMonths = 7
            intEmployeeDays = intDays - 212
        ElseIf intDays >= 181 Then
            intEmployeeMonths = 6
            intEmployeeDays = intDays - 181
        ElseIf intDays >= 151 Then
            intEmployeeMonths = 5
            intEmployeeDays = intDays - 151
        ElseIf intDays >= 120 Then
            intEmployeeMonths = 4
            intEmployeeDays = intDays - 120
        ElseIf intDays >= 90 Then
            intEmployeeMonths = 3
            intEmployeeDays = intDays - 90
        ElseIf intDays >= 59 Then
            intEmployeeMonths = 2
            intEmployeeDays = intDays - 59
        ElseIf intDays >= 31 Then
            intEmployeeMonths = 1
            intEmployeeDays = intDays - 31
        Else
            intEmployeeMonths = 0
            intEmployeeDays = intDays
        End If
    End Sub

    Private Sub GetProjectExperienceDetails(ByVal lngEmployeeId As Long, ByVal lngToolId As Long, _
                                            ByRef intEmployeeYears As Integer, ByRef intEmployeeMonths As Integer)
        '=====================================================================
        ' Procedure Name		:	GetProjectExperienceDetails
        ' Parameters Passed     :	lngEmployeeId		:- The EmployeeId of which Experience is suppose to get.
        '							intEmployeeYears	:- The number of years of Experience.
        '							intEmployeeMonths	:- The number of months of Experience.
        ' Returns               :	Returns the years, months of Experience(By Modifying the Reference Parameters).
        ' Parameters Affected   :	None.							
        ' Description           :	Converts the days given into years, months, and days.
        ' Purpose               :	Converts the days given into years, months, and days.
        ' Assumptions           :	
        ' Dependencies          :	None.
        ' Author                :	Jayavant
        ' Created               :	12-Mar-2004
        ' Revisions             :
        '=====================================================================	
        Dim strQuery As String
        Dim drWork As IDataReader

        strQuery = "Exec usp_Sel_tbl_PM_EmployeeSkillMatrix_Detail " & m_lngProjectId.ToString()
        strQuery &= ", " & lngEmployeeId.ToString()
        strQuery &= ", " & lngToolId.ToString()
        drWork = CommonFunctions.Data.GetDataReader(strQuery, MyBase.UseSQL)
        If CommonFunctions.General.CheckIsNothing(drWork) <> "" Then
            If drWork.Read() Then
                intEmployeeYears = CType("0" & CommonFunctions.Data.CheckIsDBNull(drWork.Item("YearsOfExperience")).ToString(), Integer)
                intEmployeeMonths = CType("0" & CommonFunctions.Data.CheckIsDBNull(drWork.Item("MonthsOfExperience")).ToString(), Integer)
            End If
        End If
        CommonFunctions.Data.DisposeDataReader(drWork)
    End Sub
#End Region

#Region " Menu and Grid Event Handlers "
    Private Sub m_objMenu_Before_Link_Print(ByRef Cancel As Boolean, ByRef Args As WAF_Menu_Links) Handles m_objMenu.Before_Link_Print
        If m_blnProjectOver = False Then
            If Args.LinkName = m_arrMenuItem(MenuIndex.REOPEN_PROJECT) Then Cancel = True
            If Args.LinkName = m_arrMenuItem(MenuIndex.SEND_EMAIL) Then Cancel = True
            If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE_AND_CLOSE_PROJECT) Or Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then
                If m_objAccessRights.Add = False Then
                    Cancel = True
                Else
                    If m_blnResourcesAssigned = False Or m_blnToolsAssigned = False Then Cancel = True
                End If
            End If
            'Start_AJ_10-Oct-2006
            If Args.LinkName = m_arrMenuItem(MenuIndex.TASK_CLOSURE) And m_strCnt = "0" Then
                Cancel = True
            End If
            'End_AJ_10-Oct-2006

        Else
			If Args.LinkName = m_arrMenuItem(MenuIndex.SAVE_AND_CLOSE_PROJECT) Or Args.LinkName = m_arrMenuItem(MenuIndex.SAVE) Then Cancel = True
            If m_objAccessRights.Add = False And Args.LinkName = m_arrMenuItem(MenuIndex.REOPEN_PROJECT) Then Cancel = True
            If Args.LinkName = m_arrMenuItem(MenuIndex.SEND_EMAIL) Then
                If m_blnSendMail = False Or m_blnShowPopup = False Then Cancel = True
			End If
            'Start_AJ_10-Oct-2006
            If Args.LinkName = m_arrMenuItem(MenuIndex.TASK_CLOSURE) Then
                Cancel = True
            End If
            'End_AJ_10-Oct-2006
       End If
        If Args.LinkName = m_arrMenuItem(MenuIndex.SHOW_HISTORY) Then
            ''''Commented and Added by Dhanashri S on 3 Aug 2016 Purpose: inline to SP conversion
            'If CommonFunctions.General.CheckIsNothing(CType(CommonFunction.Data.GetDataScalar("select count(*) from tbl_PM_ProjectClosureComments where ProjectID = " + CType(m_lngProjectId, String), MyBase.UseSQL), Long), "0") = "0" Then
            If CommonFunctions.General.CheckIsNothing(CType(CommonFunction.Data.GetDataScalar("usp_sel_tbl_PM_ProjectClosureComments_count " + CType(m_lngProjectId, String), MyBase.UseSQL), Long), "0") = "0" Then
                Cancel = True
            End If
            '''End of Comment and Addition by Dhanashri S on 3 Aug 2016
        End If
    End Sub

    Private Sub m_objGrid_DataRowTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_DataRowTD) Handles m_objGrid.DataRowTD_BeforePrint
        Dim strActualEndDate As String = ""
        Dim lngEmployeeId As Long = 0
        Dim intEmployeeDays As Integer = 0
        Dim intEmployeeMonths As Integer = 0
        Dim intEmployeeYears As Integer = 0
        Dim intTotalDays As Integer = 0
        Dim strYearsComboId As String = ""
        Dim strMonthsComboId As String = ""
        Dim strDataFieldValue As String = ""
        Dim intCtr As Integer = 0

        If m_blnProjectOver = False Then
            strActualEndDate = Args.DataReader.Item("ActualEndDate").ToString()
            If strActualEndDate <> "" Then
                Cancel = True
                Return
            End If
        End If

        lngEmployeeId = CType(CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("EmployeeId"), "0"), Long)
        If Args.ColIndex = 0 Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidEmployeeId", "txthidEmployeeId", value:=lngEmployeeId.ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        Else
            If m_blnProjectOver = False Then
                intTotalDays = CType("0" & CommonFunctions.Data.CheckIsDBNull(Args.DataReader.Item("TotalDays")).ToString(), Integer)
                GetYearsMonthsAndDays(intTotalDays, intEmployeeYears, intEmployeeMonths, intEmployeeDays)
                If intEmployeeDays > 0 Then
                    intEmployeeMonths = intEmployeeMonths + 1
                End If
                If intEmployeeMonths >= 12 Then
                    intEmployeeYears = intEmployeeYears + 1
                End If
            Else
                intEmployeeYears = 0
                intEmployeeMonths = 0
            End If

            GetProjectExperienceDetails(lngEmployeeId, m_arrToolId(Args.ColIndex - 1), intEmployeeYears, intEmployeeMonths)
            Args.StringToBeInserted = "<TD align=center noWrap>"
            If m_blnProjectOver = False Then
                strDataFieldValue = ""
                If m_intYearsToBeShown > 0 Then
                    strYearsComboId = "cboYear_" & lngEmployeeId.ToString
                    strYearsComboId &= "_" & m_arrToolId(Args.ColIndex - 1).ToString()
                    strDataFieldValue = "<SELECT name='" & strYearsComboId & "' class=clsCombobox>"
                    For intCtr = 0 To m_intYearsToBeShown
                        strDataFieldValue &= "<OPTION value='" & intCtr & "'"
                        If intEmployeeYears = intCtr Then strDataFieldValue &= "selected"
                        strDataFieldValue &= ">" & intCtr & "</OPTION>"
                    Next
                    strDataFieldValue &= "</SELECT>"
                    strDataFieldValue &= "&nbsp;" & MyBase.GetResourceString("YEARS") & "&nbsp;"
                End If
                strMonthsComboId = "cboMonth_" & lngEmployeeId.ToString
                strMonthsComboId &= "_" & m_arrToolId(Args.ColIndex - 1).ToString()
                strDataFieldValue &= "<SELECT name='" & strMonthsComboId & "' class=clsCombobox>"
                For intCtr = 0 To m_intMonthsToBeShown
                    strDataFieldValue &= "<OPTION value='" & intCtr & "'"
                    If intEmployeeMonths = intCtr Then strDataFieldValue &= "selected"
                    strDataFieldValue &= ">" & intCtr & "</OPTION>"
                Next
                strDataFieldValue &= "</SELECT>"
                strDataFieldValue &= "&nbsp;" & MyBase.GetResourceString("MONTHS") & "&nbsp;"
            Else
                If intEmployeeYears = 0 And intEmployeeMonths = 0 Then
                    strDataFieldValue = "-"
                Else
                    If intEmployeeYears <> 0 Then
                        strDataFieldValue = intEmployeeYears.ToString() & "&nbsp;" & MyBase.GetResourceString("YEARS") & "&nbsp;"
                    End If
                    If intEmployeeMonths <> 0 Then
                        strDataFieldValue &= intEmployeeMonths.ToString() & "&nbsp;" & MyBase.GetResourceString("MONTHS") & "&nbsp;"
                    End If
                End If
            End If
            Args.StringToBeInserted &= strDataFieldValue & "</TD>"
            Cancel = True
        End If
    End Sub

    Private Sub m_objGrid_ColumnHeaderTD_BeforePrint(ByRef Cancel As Boolean, ByRef Args As WAF_ColumnHeaderTD) Handles m_objGrid.ColumnHeaderTD_BeforePrint
        If Args.ColIndex > 0 Then
            'Modified By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
            Args.StringToBeInserted = CommonFunctions.HTMLControls.DrawTextBox("txthidToolId", "txthidToolId", value:=m_arrToolId(Args.ColIndex - 1).ToString(), IsHidden:=True, returnHTML:=True, EnableHTMLEncode:=True)
            'End Of Modification By Chakshuta H on 7th-Oct-2015 Purpose::HTML Encoding
        End If
    End Sub
#End Region

End Class
